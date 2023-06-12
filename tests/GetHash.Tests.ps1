# Tests for Get-Hash

Describe 'Hash generation tests' {
  BeforeAll {
    # Import WIP modules to be tested
    foreach ($module in $(Get-ChildItem -Path (Join-Path $PSScriptRoot "..") -Filter *.psm1)) {
      Write-Output "Importing $module"
      Import-Module -Name $module.FullName -Prefix 'WIP' -Force
    }
  }

  Describe "Get-Hash" {
    Context "Empty strings" {
      It "Generates SHA1 hash from empty str" {
        Get-WIPHash -Text "" -Method SHA1 | Should -Be "da39a3ee5e6b4b0d3255bfef95601890afd80709"
      }

      It "Generates SHA256 hash from emtpy str" {
        Get-WIPHash -Text "" -Method SHA256 | Should -Be "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
      }

      It "Generates MD5 hash from emtpy str" {
        Get-WIPHash -Text "" -Method MD5 | Should -Be "d41d8cd98f00b204e9800998ecf8427e"
      }
    }

    Context "Simple positive tests" {
      It "Generates SHA1 hash correctly" {
        Get-WIPHash -Text "Moin" -Method SHA1 | Should -Be "fa715b6b274fe68d4d41b6b1ff5d618e100d35b1"
      }

      It "Generates SHA256 hash correctly" {
        Get-WIPHash -Text "Moin" -Method SHA256 | Should -Be "f805f7a2ddfb5551bc8a690acd0a2c182e12df2c746e16f0116d36b39ef43582"
      }

      It "Generates MD5 hash correctly" {
        Get-WIPHash -Text "Moin" -Method MD5 | Should -Be "d83788ae081c72c01ef3e59ddd14a4cd"
      }
    }

    Context "Pipeline input tests" {
      It "Generates SHA1 hash correctly from pipeline" {
        $expected = @(
          "356a192b7913b04c54574d18c28d46e6395428ab", # 1
          "86f7e437faa5a7fce15d1ddcb9eaeaea377667b8", # a
          "fa715b6b274fe68d4d41b6b1ff5d618e100d35b1" # Moin
        )
        $actual = @(1, "a", "Moin") | Get-Hash -Method SHA1

        $actual | Should -Be $expected
      }

    }
  }
}
