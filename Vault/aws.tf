# AWS Secret Engines

resource "vault_aws_secret_backend" "aws" {
  access_key                = ""
  secret_key                = ""
  path                      = "aws"
  region                    = "us-east-1"
  max_lease_ttl_seconds     = 86400
  default_lease_ttl_seconds = 3600
}

resource "vault_aws_secret_backend_role" "admin" {
  backend         = vault_aws_secret_backend.aws.path
  credential_type = "assumed_role"
  name            = "admin"

  role_arns = [data.terraform_remote_state.aws.outputs.vault-aws-admin-role]
}

resource "vault_aws_secret_backend_role" "consul-s3" {
  backend         = vault_aws_secret_backend.aws.path
  credential_type = "assumed_role"
  name            = "consul-s3"

  role_arns = [data.terraform_remote_state.aws.outputs.vault-aws-consul-s3-role]
}

