From: "Richard Jones" <rjones@nexus-tech.net>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Mounting Compact Flash card under Linux on ppc823 
Date: Fri, 13 Sep 2002 17:40:28 -0400
Message-ID: <PEEPKCHHHBJOFJKGMMLHAEEGCAAA.rjones@nexus-tech.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20020912232210.128B8FA8D@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> In message <PEEPKCHHHBJOFJKGMMLHOEEDCAAA.rjones@nexus-tech.net> you wrote:
> >
> > I am using the Linux kernel from www.denx.de that has the version 2.4.4
> > (2002-08-09) with all the support for the 8xx pcmcia/direct etc... code.
> > When Linux boots (using NFS remote filesystem) it comes up and
> prints the
> > following:
> >
> > <misc deleted>
> > ...
> > Kernel command line: root=/dev/nfs rw nfsroot=192.168.0.120:/ppcroot
> > nfsaddrs=19
> > 2.168.0.20:192.168.0.120 init=/bin/bash idebus=25
> > ide_setup: idebus=25PCMCIA slot B: phys mem e0000000...ec000000 (size
> > 0c000000)
> > Card ID: SST 48CF032 55LD017-A2 FW17-4C
> >  Fixed Disk Card
> >  IDE interface
> >  [silicon] [unique] [single] [sleep] [standby] [idle] [low power]
> > ...
> > <more stuff deleted>
> > ...
>
> This "more stuff deleted" would have been the interesting  part;  the
> kernel   will  tell  you  something  about  the  partition  table  it
> recognizes, or at least the device. So if you are  sure  your  device
> contains  a  valid partition table with at least one valid partition,
> you should have seen something like:
>
> 	...
> 	hda: probing with STATUS(0x50) instead of ALTSTATUS(0x41)
> 	hda: CF 128MB, ATA DISK drive
> 	ide0 at 0xc7000320-0xc7000327,0xc3000106 on irq 13
> 	hda: 250368 sectors (128 MB) w/16KiB Cache, CHS=978/8/32
> 	Partition check:
> 	 hda: hda1
>
> > and finally gives me a shell prompt.  In the above, the Kernel seems to
> > recognize the card as being an SST-based flash card.  All seems
> okay but the
> > IDE device does not appear in the /proc/devices listing.  Also, I can't
> > mount a filesystem (probably because the IDE doesn't seem to
> have installed
> > completely).  The card I am using has a DOS filesystem on it with a few
> > files that I added.  My /etc/fstab has the following entry:
> >
> > /dev/hda1       /mnt/flash      msdos   noauto,owner    0 0
> >
> > Using make menuconfig, I set the following:
> > under IDE, ATA and ATAPI Block Devices:
> >    <*> Enhanced IDE/MFM/RLL disk/cdrom/tape/floppy support
> >    [*]   MPC8xx IDE support
> >    (8xx_PCCARD) Type of MPC8xx IDE interface
> > under File systems:
> >    <*>  DOS FAT fs support
> >    <*>    MSDOS fs support
> >    <*>      UMSDOS: Unix-like file system on top of standard MSDOS fs
> >    <*>    VFAT (Windows-95) fs support
> >
> > Questions:
> > - should the device really be hda1 ?
>
> Yes, most probably.
>
> > - is there something more that I forgot in my board config
> header file for
> > setting up pcmcia?
>
> No, I don't think so.
>
> My guess is that you forgot to enable any partition table support  in
> your Linux kernel. Make sure your config file contains:
>
>
> 	CONFIG_IDE=y
> 	CONFIG_BLK_DEV_IDE=y
> 	CONFIG_BLK_DEV_IDEDISK=y
> 	CONFIG_IDEDISK_MULTI_MODE=y
> 	CONFIG_BLK_DEV_MPC8xx_IDE=y
> 	CONFIG_BLK_DEV_IDE_MODES=y
> and
> 	CONFIG_PARTITION_ADVANCED=y
> 	CONFIG_MAC_PARTITION=y
> 	CONFIG_MSDOS_PARTITION=y
> 	CONFIG_NLS=y
> 	CONFIG_NLS_DEFAULT="y"
> 	CONFIG_NLS_ISO8859_1=y
> 	CONFIG_NLS_ISO8859_15=y
>
> See  also  our   documentation   at   http://www.denx.de/re/DPLG.html
> especially  section  "7.  Advanced Topics" (7.3.2. PC Card Support in
> Linux).
>
> Wolfgang Denk
>

I checked these and made a couple of changes but to no avail.  Then I added
the following lines to my board configuration file that I copied from the
tqm8xx.h file:

/*
 * Definitions for IDE0 Interface
 */
#define IDE0_BASE_OFFSET      0
#define IDE0_DATA_REG_OFFSET     (PCMCIA_MEM_SIZE + 0x320)
#define IDE0_ERROR_REG_OFFSET    (2 * PCMCIA_MEM_SIZE + 0x320 + 1)
#define IDE0_NSECTOR_REG_OFFSET     (2 * PCMCIA_MEM_SIZE + 0x320 + 2)
#define IDE0_SECTOR_REG_OFFSET      (2 * PCMCIA_MEM_SIZE + 0x320 + 3)
#define IDE0_LCYL_REG_OFFSET     (2 * PCMCIA_MEM_SIZE + 0x320 + 4)
#define IDE0_HCYL_REG_OFFSET     (2 * PCMCIA_MEM_SIZE + 0x320 + 5)
#define IDE0_SELECT_REG_OFFSET      (2 * PCMCIA_MEM_SIZE + 0x320 + 6)
#define IDE0_STATUS_REG_OFFSET      (2 * PCMCIA_MEM_SIZE + 0x320 + 7)
#define IDE0_CONTROL_REG_OFFSET     0x0106
#define IDE0_IRQ_REG_OFFSET      0x000A   /* not used       */

#define IDE0_INTERRUPT  13    /* = SIU_LEVEL6         */


This was the clincher, the defined values I had did not have the 0x320
offsets factored in.  I also had the IDE0_INTERRUPT set to the wrong value.
Now with these changes all is well. I was able to successfully mount the
partition and see my files.

Thanks for all the help,

Richard Jones


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
