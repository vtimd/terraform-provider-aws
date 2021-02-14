#Avner Version
package terraform.validation
import data.terraform.library as lib
default allow = false
violations[msg] {
  only_allowed_instance_types[msg]
}
only_allowed_instance_types[msg] {
  allowed_instance_types := ["t2.micro", "t2.medium"]
  used_instance_types := lib.resources[r].values.instance_type
  not lib.list_contains_value(allowed_instance_types, used_instance_types)
  msg = sprintf("Instance type not allowed. Resource in violation: %v",[r.address])
}
allow {
  count(violations) == 0
}