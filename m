To: "Richard Jones" <rjones@nexus-tech.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Mounting Compact Flash card under Linux on ppc823 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 12 Sep 2002 18:48:42 EDT."
             <PEEPKCHHHBJOFJKGMMLHOEEDCAAA.rjones@nexus-tech.net>
Date: Fri, 13 Sep 2002 01:22:04 +0200
Message-Id: <20020912232210.128B8FA8D@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <PEEPKCHHHBJOFJKGMMLHOEEDCAAA.rjones@nexus-tech.net> you wrote:
>
> I am using the Linux kernel from www.denx.de that has the version 2.4.4
> (2002-08-09) with all the support for the 8xx pcmcia/direct etc... code.
> When Linux boots (using NFS remote filesystem) it comes up and prints the
> following:
>
> <misc deleted>
> ...
> Kernel command line: root=/dev/nfs rw nfsroot=192.168.0.120:/ppcroot
> nfsaddrs=19
> 2.168.0.20:192.168.0.120 init=/bin/bash idebus=25
> ide_setup: idebus=25PCMCIA slot B: phys mem e0000000...ec000000 (size
> 0c000000)
> Card ID: SST 48CF032 55LD017-A2 FW17-4C
>  Fixed Disk Card
>  IDE interface
>  [silicon] [unique] [single] [sleep] [standby] [idle] [low power]
> ...
> <more stuff deleted>
> ...

This "more stuff deleted" would have been the interesting  part;  the
kernel   will  tell  you  something  about  the  partition  table  it
recognizes, or at least the device. So if you are  sure  your  device
contains  a  valid partition table with at least one valid partition,
you should have seen something like:

	...
	hda: probing with STATUS(0x50) instead of ALTSTATUS(0x41)
	hda: CF 128MB, ATA DISK drive
	ide0 at 0xc7000320-0xc7000327,0xc3000106 on irq 13
	hda: 250368 sectors (128 MB) w/16KiB Cache, CHS=978/8/32
	Partition check:
	 hda: hda1

> and finally gives me a shell prompt.  In the above, the Kernel seems to
> recognize the card as being an SST-based flash card.  All seems okay but the
> IDE device does not appear in the /proc/devices listing.  Also, I can't
> mount a filesystem (probably because the IDE doesn't seem to have installed
> completely).  The card I am using has a DOS filesystem on it with a few
> files that I added.  My /etc/fstab has the following entry:
>
> /dev/hda1       /mnt/flash      msdos   noauto,owner    0 0
>
> Using make menuconfig, I set the following:
> under IDE, ATA and ATAPI Block Devices:
>    <*> Enhanced IDE/MFM/RLL disk/cdrom/tape/floppy support
>    [*]   MPC8xx IDE support
>    (8xx_PCCARD) Type of MPC8xx IDE interface
> under File systems:
>    <*>  DOS FAT fs support
>    <*>    MSDOS fs support
>    <*>      UMSDOS: Unix-like file system on top of standard MSDOS fs
>    <*>    VFAT (Windows-95) fs support
>
> Questions:
> - should the device really be hda1 ?

Yes, most probably.

> - is there something more that I forgot in my board config header file for
> setting up pcmcia?

No, I don't think so.

My guess is that you forgot to enable any partition table support  in
your Linux kernel. Make sure your config file contains:


	CONFIG_IDE=y
	CONFIG_BLK_DEV_IDE=y
	CONFIG_BLK_DEV_IDEDISK=y
	CONFIG_IDEDISK_MULTI_MODE=y
	CONFIG_BLK_DEV_MPC8xx_IDE=y
	CONFIG_BLK_DEV_IDE_MODES=y
and
	CONFIG_PARTITION_ADVANCED=y
	CONFIG_MAC_PARTITION=y
	CONFIG_MSDOS_PARTITION=y
	CONFIG_NLS=y
	CONFIG_NLS_DEFAULT="y"
	CONFIG_NLS_ISO8859_1=y
	CONFIG_NLS_ISO8859_15=y

See  also  our   documentation   at   http://www.denx.de/re/DPLG.html
especially  section  "7.  Advanced Topics" (7.3.2. PC Card Support in
Linux).

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The following statement is not true.  The previous statement is true.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
