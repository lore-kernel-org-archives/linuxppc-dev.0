Message-ID: <3FBD4E10.9080905@arlut.utexas.edu>
Date: Thu, 20 Nov 2003 17:28:16 -0600
From: Benjamin Davis <bmdavis@arlut.utexas.edu>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: mvme powersave during idle, and note on autoboot
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am running an mvme5500 board with linux-2.4.20 kernal with motorola
patches.  The patches do nothing for power managment though. Each board
uses something like 35-40 watts of power, with only watt or two
difference for idle verses heavy usage.  Does this bother anyone else?
I know the mpc7455 is capable of going into multiple powersaving modes,
i believe this processor was used in previous versions of the
powerbooks.  One feature I have noticed that is not utilized is the
powersave_nap flag, which would cause the processor to go to its nap
state while in idle.  This seems to save around 10 watts of power, thats
over 20%.  however it does havoc(locks up) to the nfs loading.  Is
anyone else out there looking at this???




Auto Boot

Auto Boot provides an independent mechanism for booting an operating
system where no console is required. MOTLoad does not provide an
explicit Auto Boot command, flag, or parameter. Instead, Auto Boot is
established by appropriately defining the mot-script-boot Global
Environment Variable (GEV). Refer to the Reserved Global Environment
Variables appendix for more information on GEVs used by MOTLoad.

Upon start-up, MOTLoad checks mot-script-boot in the GEV section of
NVRAM for boot commands. Boot commands that MOTLoad recognizes are:

    diskBoot
    netBoot

Upon detection of either command, Motload performs the selected
boot command using arguments specified either from the command-line
argument (stored in mot-script-boot along with the command) or
from a GEV. If neither provides the requisite arguments, MOTLoad
uses default values which can be viewed using the help command
on diskBoot/netBoot. Since not all command arguments can be
specified by GEV variables, defaults values are used in the
cases where mot-script-boot does not contain the argument's
value.

To Auto Boot from a floppy, disk, or CD-ROM use the diskBoot command.
MOTLoad selects the boot device from a scan list provided as part of
the command-line arguments (if stored in mot-script-boot) or from the
diskBoot's corresponding GEV variable: mot-boot-path. Refer to the
Reserved Global Environment Variables appendix for additional
information on this GEV variable.

To Auto Boot across the ethernet use the netBoot command. The
command-line parameters that can be specified by GEVs are
listed in the Reserved Global Environment Variables appendix.

To create the GEVs to use with either boot command, MOTLoad
provides the gevEdit command. Existing GEVs can be viewed using
either gevList or gevShow.

When using MOTLoad's Auto Boot mechanism, MOTLoad delays
execution of the commands by the amount of time (in seconds)
defined in mot-script-delay. If mot-script-delay is not defined,
the default of 7 seconds is used. During this time the boot process
can be cancelled to return MOTLoad back to its normal boot-up sequence
by pressing the ESC key.

The following depicts an example of setting up an Auto Boot from disk:

    MVME5500>gevEdit mot-script-boot
    (Blank line terminates input.)
    diskBoot<cr>
    <cr>
    MVME5500>

    MVME5500>gevEdit mot-boot-path
    (Blank line terminates input.)
    /dev/scsi0/hdisk0\1\\boot\os.bin<cr>
    <cr>
    MVME5500>

In the above example MOTLoad downloads the file to the user download
area by default. The execution address offset is 0, also by default.
The boot file is located on device "/dev/scsi0/hdisk0", in partition 1,
under the /boot directory, and the file's name is os.bin.

This could also have been accomplished by specifying the GEVs as
follows:

   mot-script-boot : diskBoot -f/dev/scsi0/hdisk0\1\\boot\os.bin
   mot-boot-path   : <leave undefined>

Here is an example of Auto Booting across a network:

    MVME5500>gevEdit mot-script-boot
    (Blank line terminates input.)
    netBoot -d/dev/enet0 -a0x04000000<cr>
    <cr>
    MVME5500>

    MVME5500>gevEdit mot-/dev/enet0-cipa
    (Blank line terminates input.)
    144.191.27.143
    <cr>
    MVME5500>

    MVME5500>gevEdit mot-/dev/enet0-sipa
    (Blank line terminates input.)
    144.191.13.33
    <cr>
    MVME5500>

    MVME5500>gevEdit mot-/dev/enet0-file
    (Blank line terminates input.)
    /tftpBoot/bootFile.rom
    <cr>
    MVME5500>

In this example MOTLoad downloads the file from device "enet0" to the
location in memory at 0x04000000. The IP address of "enet0" is
144.191.27.143; the IP address of the source is 144.191.13.33. The
execution address offset is 0 by default. The boot file is located in
the /tftpBoot directory and the boot file name is bootFile.rom.

In both examples above, Auto Boot is initiated on the next reset or
power cycle of the board.

To disable Auto Boot, simply use gevEdit or gevDelete to modify
mot-script-boot appropriately. Note: placing the board in safe-
start does not disable the Auto Boot mechanism.

--
--
Benjamin Davis


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
