Message-ID: <EFB813091B18D511BD3600508B644F820A617F00@tx14exm06.ftw.mot.com>
From: Zajac Adam-AAZ004 <Adam.Zajac@motorola.com>
To: "'David Gardiner'" <daveg@sonartech.com.au>,
	Zajac Adam-AAZ004 <Adam.Zajac@motorola.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Question on the fs choice
Date: Fri, 21 May 2004 09:55:45 -0500
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David,

Thank you for your brief report.

You're getting quite a number of errors. Let's attack'em one by one.
This is your CF card type:
> hde: SanDisk SDCFB-512, CFA DISK drive

SDCFB-512 cards are equipped with the 100 series internal controller and are
not DMA capable.
I think you should try to turn DMA off for your CF card. Not sure if you can
selectively specify such support for individual IDE devices, though (you may
still want it for your hard drives if you have any in that system) -
CONFIG_BLK_DEV_IDEDMA.
As far as SanDisk cards are concerned, only cards equipped with 201
controller fully support DMA transfers (SDCFB-512-201-00, SDCFB-512-201-80).

> Partition check:
 /dev/ide/host2/bus0/target0/lun0
The partition on your CF card should get detected as hde1 or p1. The fact
that you're getting the absolute path tells me that either you don't have
hde, hde1, hde2..entries created at /dev on your root file system or you're
not running DEVFS. At the beginning, try to enable DEVFS in your kernel.

> hde: dma_intr: error=0x04 { DriveStatusError }
> hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hde: dma_intr: error=0x04 { DriveStatusError }
> hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hde: dma_intr: error=0x04 { DriveStatusError }
> hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hde: dma_intr: error=0x04 { DriveStatusError }

Compact flash cards are relatively slow in comparison with e.g. hard drives.
You may want to play with the timeout at ide.h file for pending on READY,
DRQ, BUSY bits.

Regards,
Adam


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
