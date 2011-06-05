$pwd = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$pwd\$sut"
. "$pwd\..\Pester.ps1"

Describe "the In statement" {
    Setup -Dir "test_path"

    It "executes a command in that directory" {
        In "$TestDrive" -Execute { "" | Out-File "test_file" }
        "$TestDrive\test_file".should.exist() 
    }

    It "MAKE THIS WORK! - updates the `$pwd variable when executed" {
        In "$TestDrive" -Execute { Write-Host $pwd }
    }

    It "will still allow the It {} block to transcribe the console" {
        In "$TestDrive" -Execute { Write-Host "The bird is the word" }
        $(Get-ConsoleText).should.match("The bird is the word")
    }
}
