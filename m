Return-Path: <Martin.Leisner@xerox.com>
Received: from wvmler2.mail.xerox.com (wvmler2.mail.xerox.com [13.8.138.217])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wvmler2.mail.xerox.com",
	Issuer "wvmler2.mail.xerox.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6D867DDE08
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Jun 2007 06:46:16 +1000 (EST)
Received: from wvmlir2.mail.xerox.com (wvmlir2.mail.xerox.com [13.147.8.222])
	by wvmler2.mail.xerox.com (8.13.8/8.13.6) with ESMTP id
	l5LKkCj7020391
	for <linuxppc-embedded@ozlabs.org>; Thu, 21 Jun 2007 13:46:13 -0700
Received: from wvmlir2.mail.xerox.com (localhost [127.0.0.1])
	by wvmlir2.mail.xerox.com (8.13.8/8.13.6) with ESMTP id l5LKk8AM027762
	for <linuxppc-embedded@ozlabs.org>; Thu, 21 Jun 2007 13:46:08 -0700
Received: from USA7061GW002.na.xerox.net (usa7061gw002.na.xerox.net
	[13.151.210.15])
	by wvmlir2.mail.xerox.com (8.13.8/8.13.6) with ESMTP id l5LKk8LI027752
	for <linuxppc-embedded@ozlabs.org>; Thu, 21 Jun 2007 13:46:08 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: sata_mv as module on taiga?
Date: Thu, 21 Jun 2007 16:46:03 -0400
Message-ID: <556445368AFA1C438794ABDA8901891C066B5B1C@usa0300ms03.na.xerox.net>
From: "Leisner, Martin" <Martin.Leisner@xerox.com>
To: <linuxppc-embedded@ozlabs.org>
Cc: "Puzio, Robert E" <Robert.Puzio@xerox.com>, "Lund,
	Nathan" <Nathan.Lund@xerox.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm using 2.6.20.11 on a taiga board.

With the default kernel config, sata_mv runs fine if nothing is in the
pci slots.

If I install a vitesse 7174 (or an intel gd32144, I happen to have both)
it causes bizarre failures in the sata_mv driver:
sata_mv 0000:00:03.0: version 0.7
sata_mv 0000:00:03.0: 32 slots 4 ports SCSI mode IRQ via INTx
ata1: SATA max UDMA/133 cmd 0x0 ctl 0xE10A2120 bmdma 0x0 irq 38
ata2: SATA max UDMA/133 cmd 0x0 ctl 0xE10A4120 bmdma 0x0 irq 38
ata3: SATA max UDMA/133 cmd 0x0 ctl 0xE10A6120 bmdma 0x0 irq 38
ata4: SATA max UDMA/133 cmd 0x0 ctl 0xE10A8120 bmdma 0x0 irq 38
scsi0 : sata_mv
ATA: abnormal status 0x80 on port 0xE10A211C
ATA: abnormal status 0x80 on port 0xE10A211C
ATA: abnormal status 0x80 on port 0xE10A211C
ATA: abnormal status 0x80 on port 0xE10A211C
ATA: abnormal status 0x80 on port 0xE10A211C
ATA: abnormal status 0x80 on port 0xE10A211C
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
ATA: abnormal status 0x80 on port 0xE10A211C
ATA: abnormal status 0x80 on port 0xE10A211C
ATA: abnormal status 0x80 on port 0xE10A211C
ATA: abnormal status 0x80 on port 0xE10A211C
ATA: abnormal status 0x80 on port 0xE10A211C
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
ATA: abnormal status 0x80 on port 0xE10A211C
ATA: abnormal status 0x80 on port 0xE10A211C
ATA: abnormal status 0x80 on port 0xE10A211C
ATA: abnormal status 0x80 on port 0xE10A211C
ATA: abnormal status 0x80 on port 0xE10A211C
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
ata1.00: limiting speed to PIO0
ata1.00: disabled

When it works I see:
sata_mv 0000:00:03.0: version 0.7
sata_mv 0000:00:03.0: 32 slots 4 ports SCSI mode IRQ via INTx
ata1: SATA max UDMA/133 cmd 0x0 ctl 0xE10A2120 bmdma 0x0 irq 38
ata2: SATA max UDMA/133 cmd 0x0 ctl 0xE10A4120 bmdma 0x0 irq 38
ata3: SATA max UDMA/133 cmd 0x0 ctl 0xE10A6120 bmdma 0x0 irq 38
ata4: SATA max UDMA/133 cmd 0x0 ctl 0xE10A8120 bmdma 0x0 irq 38
scsi0 : sata_mv
ata1.00: ATA-6, max UDMA/133, 156301488 sectors: LBA48 NCQ (depth 0/32)
ata1.00: configured for UDMA/133
scsi1 : sata_mv
ata2: no device found (phy stat 00000000)
scsi2 : sata_mv
ata3: no device found (phy stat 00000000)
scsi3 : sata_mv
ata4: no device found (phy stat 00000000)
scsi 0:0:0:0: Direct-Access     ATA      ST380817AS       3.42 PQ: 0
ANSI: 5
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
SCSI device sda: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
SCSI device sda: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 sda12 sda13
sda14 sda15 >
sd 0:0:0:0: Attached scsi disk sda

Note the failure are VERY slow (I don't having timing printks on in the
default configuration).

Also, with 2.6.21.1, it works without a problem (but we want to bring up
2.6.20 on another system
with the GD32144 driver -- which doesn't work on our custom system or
the taiga board.

marty
