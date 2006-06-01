Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id A6BEC67A66
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Jun 2006 07:10:26 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: SII3124-2
Date: Thu, 1 Jun 2006 16:10:24 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B0189DDFF@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Has anybody been successful in getting a SII3124-2 based SATA controller
to work under PPC?

I have a eval board that I tried on two different freescale boards (a
MPC8266ADS board and a MPC8560ADS board).
Kernel 2.6.16.16.

Here is the relevant output from the kernel.

ata1: SATA max UDMA/100 cmd 0xD1010000 ctl 0x0 bmdma 0x0 irq 115
ata2: SATA max UDMA/100 cmd 0xD1012000 ctl 0x0 bmdma 0x0 irq 115
ata3: SATA max UDMA/100 cmd 0xD1014000 ctl 0x0 bmdma 0x0 irq 115
ata4: SATA max UDMA/100 cmd 0xD1016000 ctl 0x0 bmdma 0x0 irq 115
ata1: SATA link down (SStatus 0)
scsi0 : sata_sil24
ata2: SATA link up 3.0 Gbps (SStatus 123)
sata_sil24 ata2: SRST failed, disabling port
scsi1 : sata_sil24
ata3: SATA link down (SStatus 0)
scsi2 : sata_sil24
ata4: SATA link down (SStatus 0)
scsi3 : sata_sil24

I added debug output to see the content of the Command Error register.
It is set to 26 which according to the datasheet for the 3124-1 (I am
running a -2), is PLDCMDERRORMASTERABORT, "A PCI Master Abort occurred
while the SiI3124 was fetching a Port Request Block (PRB) from host
memory."
