Message-ID: <3C4C1EED00000325@charlotte.ccc-dcs.com> (added by charlotte.ccc-dcs.com)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Jim Duey <jduey@ccc-dcs.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Walnut(405GP) Kernel Compiling HowTo
Date: Tue, 22 Jan 2002 15:26:29 +0000
MIME-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi folks.  I've spent the better part of 3 days tracking down pieces of scant
or non-existent documentation to figure out how to bring up a linux kernel on
the Walnut development system.  The following procedure is almost certainly
non-optimal and if anyone cares to make suggestions, I'd appreciate it.
However, this is the process that worked for me.

Some starting assumptions:
You have a Walnut board.
You have a desktop linux system, not necessarily Redhat.
You want to cross-compile on your desktop system to target the Walnut.

Procedure:
1. Download the Journeyman CD from Monte Vista. (www.mvista.com).  MV is very
good about providing these online and will also send them to you by snail
mail if you have trouble downloading them.  At least they did for me.  It
isn't necessary to download all 3 cd's.  CD number 2 has the PowerPC 405
stuff on it.  If you have a different target, poke around on their ftp site
and see which cd you need.  Once it's downloaded, you can either burn
yourself a cd or mount the ISO on a loopback device.

2. The MV tools will run fine on non-Redhat systems if you work at it.  I'm
currently using a distro called Gentoo. (www.gentoo.org)  However, getting it
installed involved jumping through some hoops.  I got another hard drive that
was lying around, put it in my machine and installed RedHat 7.2 on it.  Then
I booted to the Redhat drive and mounted the drive partition that had my
normal root file system on it to /mnt/gentoo.  Then I remounted the gentoo
opt directory to the opt directory in the Redhat file tree using the bind
option i.e. 'mount -o bind /mnt/gentoo/opt /opt'.  After that installation of
HardHat Linux went smoothly and it ended up in the 'opt' directory of my
Gentoo linux partition.  Then I booted back to Gentoo linux.

3. Setup the host according to the docs included on the Journeyman CD.  This
involves configuring DHCP, tftp, /tftpboot and nfs.  And yes, the Walnut does
work fine with this version of DHCP (ISC v. 3.0rc12), though the DHCP server
appears as a BOOTP server to it.

At this point, the walnut should be booting.  The next step is to be able to
compile the kernel so you can keep up-to-date.

4. The kernel source code tree is managed using Bitkeeper
(www.bitkeeper.com).  Download and install the latest version.

5. Get the source tree using the instructions at
penguinppc.org/dev/kernel.shtml.  Essentially you create a directory to hold
the source tree, say /opt/src.  'cd' to it and enter 'bk clone
bk://ppc.bkserver.net/linuxppc_2_4_devel linuxppc_2_4_devel'.  This will
create a directory, /opt/src/linuxppc_2_4_devel, that will contain the source
tree.

5.a.  If you want to revert to an older version of the source tree after you
have downloaded the current one, go to the directory that you cloned the
source tree in and run 'bk revtool'.  This will pop up an X application that
will let you look at the revisions made to the source code.  Open a file
called 'ChangeSet'.  The boxes in the top window appear to be the updates
made to the source.  Select different boxes until you see a line like 'TAG:
v2.4.17' in the bottom window.  Select the tag you want and then exit.  Then
clone the source tree again but add a '-rv2.4.17' or whatever tag you
want and it should get a tree of the proper rev into the directory you want.

6.  Go to the top level directory of your source tree, i.e.
/opt/src/linuxppc_2_4_devel, and enter 'bk edit Makefile'.  This will check
out the kernel Makefile and mark it read/write.  Edit the Makefile and change
the ARCH to equal 'ppc' and the CROSS_COMPILE to equal 'ppc_405-'.  This will
cause the kernel to be compiled targeting the Walnut board.

7.  Bitkeeper keeps the source files in special directories so it can control
how they're written.  Do a 'bk -r get -q' to get the source tree in a useable
form.

8.  The Walnut configuration needs to be made the default so do a 'make
walnut_config'.  Followed by 'make mrproper' to clean up anything that might
be in the tree.  Then do 'make menuconfig' to configure the kernel.  If you
want to be able to telnet into the Walnut, be sure and turn on Character
Devices->Unix98 PTY support and File Systems->/dev/pts file system for Unix98
PTYs.  Then a 'make dep zImage' and your kernel should compile.

9.  After compilation is complete, the new kernel image is in
arch/ppc/boot/images/zImage.treeboot.  Replace the vmlinuz-ibm-walnut in
/tftpboot with this file and you should be good to go.

Jim

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
