Date: Tue, 9 Oct 2001 04:46:32 -0800
From: Ethan Benson <erbenson@alaska.net>
To: Debian PowerPC <debian-powerpc@lists.debian.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: [ANN] yaboot-1.3.4pre1 Please test
Message-ID: <20011009044631.B30229@plato.local.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have uploaded yaboot 1.3.4pre1 for testing.
http://master.penguinppc.org/projects/yaboot/1.3.4pre/

This version fixes many bugs and adds a couple new features, the most
interesting of which is SGI XFS filesystem support.

Please test this as much as possible, including all filesystems (ext2,
reiserfs, xfs, network, etc) there has been changes made to them all.

Here is the current changelog:

        * yaboot:
          - Add SGI XFS filesystem support.
          - Rewrite OpenFirmware device path parsing code.  This fixes
            many bugs and inconsistencies in yaboot's file loading.
          - Fix OpenFirmware filesystem support to automatically convert
            path separator from / to \.  CDROM authors no longer need to use
            hacks like image=\\install\\powermac\\vmlinux.
          - Fix kernel loading on some systems.
          - Allow for getting files from tftp server that does not run a
            bootpd/dhcpd.
          - Fix a great deal of incorrect format strings which could cause
            yaboot crashes.
          - Fix all filesystems to properly return error conditions, and
            report those error conditions (instead of just saying `image not
            found').
          - Add `help' command to yaboot which prints out basic usage information.
          - General cruft removal and code cleanup.

        * Makefile cleanup, make filesystems configurable.

When testing its recommended that you have an alternate means of
booting your system in case something is wrong in this test version,
to do this do the following:

hmount /dev/<bootstrap_partition>
hcopy -r /usr/lib/yaboot/yaboot :yaboot.safe
humount

cd yaboot-1.3.4pre1
make
ybin -i second/yaboot  # NOT mkofboot, it will erase the backup yaboot.

Do not run make install since that will overwrite your currently
installed stable release of yaboot, you need to keep that around in
case of problems.

This will make the test version boot by default, if it fails you can
boot the backup version like this:

Boot into OpenFirmware by holding down "command option o f"
enter the following command:
boot hd:X,yaboot.safe

Where X is the partition number of your bootstrap partition, to find
this out enter the following:

printenv boot-device

If you allow ybin to update the nvram this will have the right
device path (just replace the \\:tbxi with yaboot.safe).

When reporting bugs you must send me the following:

/etc/yaboot.conf

Every error or message yaboot printed verbatim. (write it down, don't
give me vague paraphrased guesses from memory)

The value of OpenFirmware's boot-device variable, you can get this by running:
cat /proc/device-tree/options/boot-device

What kind of machine you have:
cat /proc/device-tree/model
cat /proc/device-tree/openprom/model

Your partition table:
mac-fdisk -l /dev/hda (or whatever is appropriate on your system)
(pdisk -l on some systems)

Do not send me useless reports like: `It doesn't werk'

Test it, try and break it, I want to know about bugs now, not three
days after I release 1.3.4 final ;-)

Thanks.

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
