Message-ID: <8D7C5F56B409554D9D46AC22195807F3061A56@exchwenz01.smtp.dmcwave.co.nz>
From: Rod Boyce <rod_boyce@stratexnet.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Mounting Compact Flash card under Linux on ppc823
Date: Fri, 13 Sep 2002 10:55:51 +1200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


My only question is does /dev/hda1 exist in the device file system?

If this does not exist not amount of trying will get this to work.

Regards,
Rod Boyce

 -----Original Message-----
From: 	Richard Jones [mailto:rjones@nexus-tech.net]
Sent:	Thursday, September 12, 2002 3:49 PM
To:	linuxppc-embedded@lists.linuxppc.org
Subject:	Mounting Compact Flash card under Linux on ppc823


Hello all,

I need help getting a compact flash card working on my system.

I am using a custom 823 board running ppcboot 1.1.6.  I have added support
for FAT file system here and have been able to load the linux kernel from a
compact flash card (meaning the pcmcia interface is configured and working
properly).  The problem I have is in getting Linux to recognize the IDE
interface properly and let me mount the drive.

I am using the Linux kernel from www.denx.de that has the version 2.4.4
(2002-08-09) with all the support for the 8xx pcmcia/direct etc... code.
When Linux boots (using NFS remote filesystem) it comes up and prints the
following:

<misc deleted>
...
Kernel command line: root=/dev/nfs rw nfsroot=192.168.0.120:/ppcroot
nfsaddrs=19
2.168.0.20:192.168.0.120 init=/bin/bash idebus=25
ide_setup: idebus=25PCMCIA slot B: phys mem e0000000...ec000000 (size
0c000000)
Card ID: SST 48CF032 55LD017-A2 FW17-4C
 Fixed Disk Card
 IDE interface
 [silicon] [unique] [single] [sleep] [standby] [idle] [low power]
...
<more stuff deleted>
...
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 25MHz system bus speed for PIO modes
...

and finally gives me a shell prompt.  In the above, the Kernel seems to
recognize the card as being an SST-based flash card.  All seems okay but the
IDE device does not appear in the /proc/devices listing.  Also, I can't
mount a filesystem (probably because the IDE doesn't seem to have installed
completely).  The card I am using has a DOS filesystem on it with a few
files that I added.  My /etc/fstab has the following entry:

/dev/hda1       /mnt/flash      msdos   noauto,owner    0 0

Using make menuconfig, I set the following:
under IDE, ATA and ATAPI Block Devices:
   <*> Enhanced IDE/MFM/RLL disk/cdrom/tape/floppy support
   [*]   MPC8xx IDE support
   (8xx_PCCARD) Type of MPC8xx IDE interface
under File systems:
   <*>  DOS FAT fs support
   <*>    MSDOS fs support
   <*>      UMSDOS: Unix-like file system on top of standard MSDOS fs
   <*>    VFAT (Windows-95) fs support

Questions:
- should the device really be hda1 ?
- is there something more that I forgot in my board config header file for
setting up pcmcia?


Thanks & best regards,

Richard Jones
Nexus Technologies, Inc.
10 National Avenue
Fletcher NC 28748
(828) 681-2844 x22


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
