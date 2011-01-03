Return-Path: <acrux_it@libero.it>
Received: from cp-out11.libero.it (cp-out11.libero.it [212.52.84.111])
	by ozlabs.org (Postfix) with ESMTP id 95A04B6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  3 Jan 2011 23:13:44 +1100 (EST)
Received: from acrux-1faad1e87 (62.98.27.116) by cp-out11.libero.it (8.5.133)
	(authenticated as acrux_it@libero.it)
	id 4D0F3682016B3E28 for linuxppc-dev@lists.ozlabs.org;
	Mon, 3 Jan 2011 13:08:00 +0100
Date: Mon, 3 Jan 2011 13:08:38 +0100
From: acrux <acrux_it@libero.it>
To: linuxppc-dev@lists.ozlabs.org
Subject: PATA_WINBOND  lost interrupt - linux-2.6.36.2 - ppc64
Message-Id: <20110103130838.34f34218.acrux_it@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

hi,
there is a problem using new pata drivers with an old IBM Intellistation POWER 275  (9114-275 pSeries POWER4+).
These boxes are equipped with an IDE dvd-rom drive (PATA_WINBOND driver). 
0000:00:03.1 IDE interface: Symphony Labs SL82c105 (rev 05)

I can report, instead, that the old ide-cd driver BLK_DEV_SL82C105 (i tested the same scenario but with linux-2.6.32.7) works fine. Obviously it happens only when boot or try to read from the dvdrom drive.

[...]
ata1: lost interrupt (Status 0x50)
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
sr 1:0:0:0: CDB: Xdread, Read track info: 52 01 00 00 00 01 00 00 20 00
ata1.00: cmd a0/01:00:00:20:00/00:00:00:00:00/a0 tag 0 dma 16416 in
         res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1.00: configured for MWDMA2
ata1: EH complete
sr0: CDROM (ioctl) error, command: Xdread, Read track info 52 01 00 00 00 01 00 00 20 00
sr: Sense Key : Aborted Command [current] [descriptor]
sr: Add. Sense: No additional sense information
ata1: lost interrupt (Status 0x50)
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
sr 1:0:0:0: [sr0] CDB: Xpwrite, Read disk info: 51 00 00 00 00 00 00 00 20 00
ata1.00: cmd a0/01:00:00:20:00/00:00:00:00:00/a0 tag 0 dma 16416 in
         res 40/00:02:00:0c:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1.00: configured for MWDMA2
ata1: EH complete
ata1: lost interrupt (Status 0x50)
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
sr 1:0:0:0: CDB: Get configuration: 46 00 00 00 00 00 00 00 20 00
ata1.00: cmd a0/01:00:00:20:00/00:00:00:00:00/a0 tag 0 dma 16416 in
         res 40/00:02:00:0c:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1.00: configured for MWDMA2
sr0: CDROM (ioctl) error, command: 
ata1: EH complete
Get configuration 46 00 00 00 00 00 00 00 20 00
sr: Sense Key : Aborted Command [current] [descriptor]
sr: Add. Sense: No additional sense information
ata1: lost interrupt (Status 0x50)
ata1.00: limiting speed to MWDMA1:PIO4
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
sr 1:0:0:0: [sr0] CDB: Xpwrite, Read disk info: 51 00 00 00 00 00 00 00 20 00
ata1.00: cmd a0/01:00:00:20:00/00:00:00:00:00/a0 tag 0 dma 16416 in
         res 40/00:02:00:0c:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1.00: configured for MWDMA1
ata1: EH complete
ata1: lost interrupt (Status 0x50)
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
sr 1:0:0:0: CDB: Get configuration: 46 00 00 00 00 00 00 00 20 00
ata1.00: cmd a0/01:00:00:20:00/00:00:00:00:00/a0 tag 0 dma 16416 in
         res 40/00:02:00:0c:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1.00: configured for MWDMA1
ata1: EH complete
sr0: CDROM (ioctl) error, command: Get configuration 46 00 00 00 00 00 00 00 20 00
sr: Sense Key : Aborted Command [current] [descriptor]
sr: Add. Sense: No additional sense information
[...]

Here the full dmesg and kernel config:
http://cruxppc.org/~acrux/linux-2.6.36.2-IntellistationPOWER275.dmesg
http://cruxppc.org/~acrux/linux-2.6.36.2-IntellistationPOWER275.config



thanks,
--acrux
-- 
GNU/Linux on Power Architecture
CRUX PPC - http://cruxppc.org/
