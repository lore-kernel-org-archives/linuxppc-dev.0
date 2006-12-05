Return-Path: <Leonid@a-k-a.net>
Received: from mis011-2.exch011.intermedia.net
	(mis011-2.exch011.intermedia.net [64.78.21.129])
	by ozlabs.org (Postfix) with ESMTP id 04B6967BBE
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Dec 2006 11:58:49 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: cdrecord for PPC440EP, Lunux 2.6.13
Date: Mon, 4 Dec 2006 16:58:46 -0800
Message-ID: <406A31B117F2734987636D6CCC93EE3CA1BE07@ehost011-3.exch011.intermedia.net>
From: "Leonid" <Leonid@a-k-a.net>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi:

I'm trying to use cdrecord under Linux 2.6 on PPC440EP board. It informs
that there are certain problems with Linux 2.6, but in general it works.
For example, I can burn image on USB CDROM.

However I couldn't make it working with my IDE CDROM (I have Sony
CRX320AE). I think I have enabled anything SCSI related in kernel, yet
cdrecord cannot recognize it. I realize that I must forward to kernel
hdb=3Dide-... parameter. I used 2 different parameters for bootarg:

1) "hdb=3Dide-scsi":
...............................................
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=3Dxx
SiI680: IDE controller at PCI slot 0000:01:06.0
SiI680: chipset revision 2
SiI680: BASE CLOCK =3D=3D 133
SiI680: 100% native mode on irq 25
    ide0: MMIO-DMA , BIOS settings: hda:pio, hdb:pio
    ide1: MMIO-DMA , BIOS settings: hdc:pio, hdd:pio
hdb: IDE DVD-ROM 16X, ATAPI CD/DVD-ROM drive
ide0 at 0xd105cf80-0xd105cf87,0xd105cf8a on irq 25
hdc: Maxtor 6L100P0, ATA DISK drive
ide1 at 0xd105cfc0-0xd105cfc7,0xd105cfca on irq 25
hdc: max request size: 64KiB
hdc: 195813072 sectors (100256 MB) w/8192KiB Cache, CHS=3D65535/16/63,
UDMA(133)
hdc: cache flushes supported
 hdc: hdc1 hdc2 hdc3
ide-scsi is deprecated for cd burning! Use ide-cd and give =
dev=3D/dev/hdX
as device
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: IDE       Model: DVD-ROM 16X       Rev: 7.92
  Type:   CD-ROM                             ANSI SCSI revision: 02
st: Version 20050501, fixed bufsize 32768, s/g segs 256
osst :I: Tape driver with OnStream support version 0.99.3
osst :I: $Id: osst.c,v 1.73 2005/01/01 21:13:34 wriede Exp $
sr0: scsi3-mmc drive: 2x/48x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 5
SCSI Media Changer driver v0.25

However cdrecord doesn't like him:

bash-2.05b# /opt/schily/bin/cdrecord -dev=3D/dev/sr0 -checkdrive
Cdrecord-Clone 2.01 (powerpc-unknown-linux-gnu) Copyright (C) 1995-2004
J?g Schilling
/opt/schily/bin/cdrecord: Warning: Running on Linux-2.6.13
/opt/schily/bin/cdrecord: There are unsettled issues with Linux-2.5 and
newer.
/opt/schily/bin/cdrecord: If you have unexpected problems, please try
Linux-2.4 or Solaris.
scsidev: '/dev/sr0'
devname: '/dev/sr0'
scsibus: -2 target: -2 lun: -2
Warning: Open by 'devname' is unintentional and not supported.
Linux sg driver version: 3.5.27
Using libscg version 'schily-0.8'.
Device type    : Removable scsi: unknown opcode 0x01
CD-ROM
Version        : 0
Response Format: 1
Vendor_info    : 'IDE     '
Identifikation : 'DVD-ROM 16X     '
Revision       : '7.92'
Device seems to be: Generic mmc2 DVD-ROM.
/opt/schily/bin/cdrecord: Sorry, no CD/DVD-Recorder or unsupported
CD/DVD-Recorder found on this target.

2) Since ide-scsi may be deprecated, I tried "hdb=3Dide-cd":

....................................
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=3Dxx
SiI680: IDE controller at PCI slot 0000:01:06.0
SiI680: chipset revision 2
SiI680: BASE CLOCK =3D=3D 133
SiI680: 100% native mode on irq 25
    ide0: MMIO-DMA , BIOS settings: hda:pio, hdb:pio
    ide1: MMIO-DMA , BIOS settings: hdc:pio, hdd:pio
hdb: IDE DVD-ROM 16X, ATAPI CD/DVD-ROM drive
ide0 at 0xd105cf80-0xd105cf87,0xd105cf8a on irq 25
hdc: Maxtor 6L100P0, ATA DISK drive
eth0: Link is Up
eth0: Speed: 100, Full duplex.
ide1 at 0xd105cfc0-0xd105cfc7,0xd105cfca on irq 25
hdc: max request size: 64KiB
hdc: 195813072 sectors (100256 MB) w/8192KiB Cache, CHS=3D65535/16/63,
UDMA(133)
hdc: cache flushes supported
 hdc: hdc1 hdc2 hdc3
hdb: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
st: Version 20050501, fixed bufsize 32768, s/g segs 256
osst :I: Tape driver with OnStream support version 0.99.3
osst :I: $Id: osst.c,v 1.73 2005/01/01 21:13:34 wriede Exp $
SCSI Media Changer driver v0.25

cdrecord doesn't like this driver anyway:

bash-2.05b# /opt/schily/bin/cdrecord -dev=3D/dev/hdb -checkdrive
Cdrecord-Clone 2.01 (powerpc-unknown-linux-gnu) Copyright (C) 1995-2004
J?g Schilling
/opt/schily/bin/cdrecord: Warning: Running on Linux-2.6.13
/opt/schily/bin/cdrecord: There are unsettled issues with Linux-2.5 and
newer.
/opt/schily/bin/cdrecord: If you have unexpected problems, please try
Linux-2.4 or Solaris.
scsidev: '/dev/hdb'
devname: '/dev/hdb'
scsibus: -2 target: -2 lun: -2
Warning: Open by 'devname' is unintentional and not supported.
Linux sg driver version: 3.5.27
Using libscg version 'schily-0.8'.
Device type    : Removable CD-ROM
Version        : 0
Response Format: 1
Vendor_info    : 'IDE     '
Identifikation : 'DVD-ROM 16X     '
Revision       : '7.92'
Device seems to be: Generic mmc2 DVD-ROM.
/opt/schily/bin/cdrecord: Sorry, no CD/DVD-Recorder or unsupported
CD/DVD-Recorder found on this target.

Could it be that this CDROM needs some special drivers? Should I simply
get another CDROM?

Thanks,

Leonid.
