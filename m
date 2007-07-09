Return-Path: <mikpe@user.it.uu.se>
Received: from aun.it.uu.se (aun.it.uu.se [130.238.12.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8528DDDE0A
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 09:22:07 +1000 (EST)
Date: Tue, 10 Jul 2007 01:04:16 +0200 (MEST)
Message-Id: <200707092304.l69N4Ggd023137@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: albertl@mail.com, jeff@garzik.org
Subject: Re: [PATCH 1/1] libata: pata_pdc2027x PLL input clock fix
Cc: dwm@enoyolf.org, mikpe@it.uu.se, linux-ide@vger.kernel.org,
	bahadir.balban@gmail.com, linuxppc-dev@ozlabs.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(cc:ing linuxppc-dev)

On Tue, 26 Jun 2007 13:43:15 +0800, Albert Lee wrote:
> Recently the PLL input clock of pata_pdc2027x is sometimes detected
> higer than expected (e.g. 20.027 MHz compared to 16.714 MHz).
> It seems sometimes the mdelay() function is not as precise as it
> used to be. Per Alan's advice, HT or power management might affect
> the precision of mdelay().
> 
> This patch calls gettimeofday() to mesure the time elapsed and
> calculate the PLL input clock accordingly.

Unfortunately this breaks pata_pdc2027x on my PowerMac G3:

--- dmesg-2.6.22-rc5	2007-06-23 20:45:45.000000000 +0200
+++ dmesg-2.6.22	2007-07-10 00:39:51.000000000 +0200
@@ -1,6 +1,6 @@
 Using PowerMac machine description
 Total memory = 768MB; using 2048kB for hash table (at cfe00000)
-Linux version 2.6.22-rc5 (mikpe@eisbock) (gcc version 4.2.0) #1 Sat Jun 23 20:38:48 CEST 2007
+Linux version 2.6.22 (mikpe@eisbock) (gcc version 4.2.0) #1 Tue Jul 10 00:29:58 CEST 2007
 Found a Heathrow mac-io controller, rev: 1, mapped at 0xfdf80000
 PowerMac motherboard: PowerMac G3 (Gossamer)
 Entering add_active_range(0, 0, 196608) 0 entries of 256 used
@@ -32,7 +32,7 @@
 console handover: boot [udbg0] -> real [tty0]
 Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
 Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
-Memory: 771456k/786432k available (2344k kernel code, 14560k reserved, 116k data, 94k bss, 148k init)
+Memory: 771584k/786432k available (2340k kernel code, 14544k reserved, 116k data, 94k bss, 148k init)
 Calibrating delay loop... 33.38 BogoMIPS (lpj=166912)
 Mount-cache hash table entries: 512
 device-tree: Duplicate name in /pci/mac-io, renamed to "ide#1"
@@ -108,17 +108,15 @@
  sda: [mac] sda1 sda2 sda3 sda4 sda5 sda6 sda7 sda8 sda9
 sd 0:0:0:0: [sda] Attached SCSI disk
 pata_pdc2027x 0000:00:0e.0: version 0.9
-pata_pdc2027x 0000:00:0e.0: PLL input clock 16000 kHz
+pata_pdc2027x 0000:00:0e.0: PLL input clock 1691742 kHz
+pata_pdc2027x: Invalid PLL input clock 1691742kHz, give up!
 scsi1 : pata_pdc2027x
 scsi2 : pata_pdc2027x
-ata1: PATA max UDMA/133 cmd 0xf10197c0 ctl 0xf1019fda bmdma 0xf1019000 irq 0
-ata2: PATA max UDMA/133 cmd 0xf10195c0 ctl 0xf1019dda bmdma 0xf1019008 irq 0
-ata1.00: ata_hpa_resize 1: sectors = 60036480, hpa_sectors = 60036480
+ata1: PATA max UDMA/133 cmd 0xf10197c0 ctl 0xf1019fda bmdma 0xf1019000 irq 24
+ata2: PATA max UDMA/133 cmd 0xf10195c0 ctl 0xf1019dda bmdma 0xf1019008 irq 24
 ata1.00: ATA-5: IBM-DTLA-307030, TX4OA6AA, max UDMA/100
 ata1.00: 60036480 sectors, multi 0: LBA 
-ata1.00: ata_hpa_resize 1: sectors = 60036480, hpa_sectors = 60036480
 ata1.00: configured for UDMA/100
-ATA: abnormal status 0x8 on port 0xf10195df
 scsi 1:0:0:0: Direct-Access     ATA      IBM-DTLA-307030  TX4O PQ: 0 ANSI: 5
 sd 1:0:0:0: [sdb] 60036480 512-byte hardware sectors (30739 MB)
 sd 1:0:0:0: [sdb] Write Protect is off
@@ -128,7 +126,36 @@
 sd 1:0:0:0: [sdb] Write Protect is off
 sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
 sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
- sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 sdb7 >
+ sdb:<3>ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
+ata1.00: (BMDMA stat 0x4)
+ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 in
+         res 51/84:00:07:00:00/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
+ata1: soft resetting port
+ata1.00: configured for UDMA/100
+ata1: EH complete
+ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
+ata1.00: (BMDMA stat 0x4)
+ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 in
+         res 51/84:00:07:00:00/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
+ata1: soft resetting port
+ata1.00: configured for UDMA/100
+ata1: EH complete
+ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
+ata1.00: (BMDMA stat 0x4)
+ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 in
+         res 51/84:00:07:00:00/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
+ata1: soft resetting port
+ata1.00: configured for UDMA/100
+ata1: EH complete
+ata1.00: limiting speed to UDMA/66:PIO4
+ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
+ata1.00: (BMDMA stat 0x4)
+ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 in
+         res 51/84:00:07:00:00/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
+ata1: soft resetting port
+ata1.00: configured for UDMA/66
+ata1: EH complete
+ sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 sdb7 >
 sd 1:0:0:0: [sdb] Attached SCSI disk
 mice: PS/2 mouse device common for all mice
 TCP cubic registered

In fairness, this is a slightly non-standard PowerMac G3, in that it
has a G4 upgrade processor. The firmware doesn't recognise the CPU
and gives some CPU core frequency-related properties too low values.
However, the bus frequency property _is_ correct, which is what
most or all timing stuff should be based on.

Looks like a platform bug.

/Mikael
