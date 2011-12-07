Return-Path: <acrux_it@libero.it>
Received: from outrelay01.libero.it (outrelay01.libero.it [212.52.84.101])
 by ozlabs.org (Postfix) with ESMTP id C61D51007D2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2011 12:15:04 +1100 (EST)
Received: from wmail54 (172.31.0.245) by outrelay01.libero.it (8.5.140)
 (authenticated as acrux_it@libero.it)
 id 4EDDE03B001E2127 for linuxppc-dev@lists.ozlabs.org;
 Wed, 7 Dec 2011 02:15:00 +0100
Message-ID: <28546010.491181323220500482.JavaMail.defaultUser@defaultHost>
Date: Wed, 7 Dec 2011 02:15:00 +0100 (CET)
From: "acrux_it@libero.it" <acrux_it@libero.it>
To: linuxppc-dev@lists.ozlabs.org
Subject: pata_sl82c105 is unable to properly handle dma (indeed it try to
 use mwdma2)
MIME-Version: 1.0
Content-Type: text/plain;charset="UTF-8"
Reply-To: "acrux_it@libero.it" <acrux_it@libero.it>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

New pata_sl82c105 is unable to properly handle dma (indeed it try to use 
mwdma2).
Old ide driver instead worked fine.

Tested on IBM 9114-275 where to use it i must boot with dma disabled i.e. with 
libata.dma=0

[...]
pata_sl82c105 0000:00:03.1: enabling device (0144 -> 0145)
scsi1 : pata_sl82c105
scsi2 : pata_sl82c105
ata1: PATA max MWDMA2 cmd 0x1f000 ctl 0x1f010 bmdma 0x1f040 irq 165
ata2: PATA max MWDMA2 cmd 0x1f020 ctl 0x1f030 bmdma 0x1f048 irq 165
ata1.00: ATAPI: IBM     DROM00205, NR38, max UDMA/33
ata1.00: configured for MWDMA2
[...]
scsi 1:0:0:0: CD-ROM            IBM      DROM00205        NR38 PQ: 0 ANSI: 2
sr0: scsi3-mmc drive: 24x/24x cd/rw xa/form2 cdda tray
cdrom: Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi generic sg3 type 5
[...]
ata1: lost interrupt (Status 0x50)
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
sr 1:0:0:0: CDB: Get configuration: 46 00 00 00 00 00 00 00 20 00
ata1.00: cmd a0/01:00:00:20:00/00:00:00:00:00/a0 tag 0 dma 16416 in
         res 40/00:02:00:0c:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1.00: configured for MWDMA2
ata1: EH complete
sr0: CDROM (ioctl) error, command: Get configuration 46 00 00 00 00 00 00 00 
20 00
sr: Sense Key : Aborted Command [current] [descriptor]
sr: Add. Sense: No additional sense information
ata1: lost interrupt (Status 0x50)
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
sr 1:0:0:0: CDB: Xdread, Read track info: 52 01 00 00 00 01 00 00 20 00
ata1.00: cmd a0/01:00:00:20:00/00:00:00:00:00/a0 tag 0 dma 16416 in
         res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1.00: configured for MWDMA2
ata1: EH complete
sr0: CDROM (ioctl) error, command: Xdread, Read track info 52 01 00 00 00 01 
00 000
sr: Sense Key : Aborted Command [current] [descriptor]
sr: Add. Sense: No additional sense information
ata1: lost interrupt (Status 0x50)
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
sr 1:0:0:0: CDB: Get configuration: 46 00 00 00 00 00 00 00 20 00
ata1.00: cmd a0/01:00:00:20:00/00:00:00:00:00/a0 tag 0 dma 16416 in
         res 40/00:02:00:0c:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1.00: configured for MWDMA2
ata1: EH complete
sr0: CDROM (ioctl) error, command: Get configuration 46 00 00 00 00 00 00 00 
20 00
sr: Sense Key : Aborted Command [current] [descriptor]
sr: Add. Sense: No additional sense information
ata1: lost interrupt (Status 0x50)
ata1.00: limiting speed to MWDMA1:PIO4
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
sr 1:0:0:0: CDB: Get configuration: 46 00 00 00 00 00 00 00 20 00
ata1.00: cmd a0/01:00:00:20:00/00:00:00:00:00/a0 tag 0 dma 16416 in
         res 40/00:02:00:0c:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1.00: configured for MWDMA1
ata1: EH complete
sr0: CDROM (ioctl) error, command: Get configuration 46 00 00 00 00 00 00 00 
20 00
sr: Sense Key : Aborted Command [current] [descriptor]
sr: Add. Sense: No additional sense information
ata1: lost interrupt (Status 0x50)
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
sr 1:0:0:0: CDB: Get configuration: 46 00 00 00 00 00 00 00 20 00
ata1.00: cmd a0/01:00:00:20:00/00:00:00:00:00/a0 tag 0 dma 16416 in
         res 40/00:02:00:0c:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1.00: configured for MWDMA1
ata1: EH complete
sr0: CDROM (ioctl) error, command: Get configuration 46 00 00 00 00 00 00 00 
20 00
sr: Sense Key : Aborted Command [current] [descriptor]
sr: Add. Sense: No additional sense information
ata1: lost interrupt (Status 0x50)
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
sr 1:0:0:0: CDB: Get configuration: 46 00 00 00 00 00 00 00 20 00
ata1.00: cmd a0/01:00:00:20:00/00:00:00:00:00/a0 tag 0 dma 16416 in
         res 40/00:02:00:0c:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1.00: configured for MWDMA1
ata1: EH complete
sr0: CDROM (ioctl) error, command: Get configuration 46 00 00 00 00 00 00 00 
20 00
sr: Sense Key : Aborted Command [current] [descriptor]
sr: Add. Sense: No additional sense information
ata1: lost interrupt (Status 0x50)
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
sr 1:0:0:0: CDB: Get configuration: 46 00 00 00 00 00 00 00 20 00
ata1.00: cmd a0/01:00:00:20:00/00:00:00:00:00/a0 tag 0 dma 16416 in
         res 40/00:02:00:0c:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1.00: configured for MWDMA1
ata1: EH complete
sr0: CDROM (ioctl) error, command: Get configuration 46 00 00 00 00 00 00 00 
20 00
sr: Sense Key : Aborted Command [current] [descriptor]
sr: Add. Sense: No additional sense information
ata1: lost interrupt (Status 0x50)
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
sr 1:0:0:0: CDB: Get configuration: 46 00 00 00 00 00 00 00 20 00
ata1.00: cmd a0/01:00:00:20:00/00:00:00:00:00/a0 tag 0 dma 16416 in
         res 40/00:02:00:0c:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1.00: configured for MWDMA1
ata1: EH complete







cheers,
--nico
