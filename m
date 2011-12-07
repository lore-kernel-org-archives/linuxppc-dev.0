Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B4C741007D2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2011 13:21:39 +1100 (EST)
Message-ID: <1323224488.660.33.camel@pasglop>
Subject: Re: pata_sl82c105 is unable to properly handle dma (indeed it try
 to use mwdma2)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "acrux_it@libero.it" <acrux_it@libero.it>
Date: Wed, 07 Dec 2011 13:21:28 +1100
In-Reply-To: <28546010.491181323220500482.JavaMail.defaultUser@defaultHost>
References: <28546010.491181323220500482.JavaMail.defaultUser@defaultHost>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-12-07 at 02:15 +0100, acrux_it@libero.it wrote:
> New pata_sl82c105 is unable to properly handle dma (indeed it try to use 
> mwdma2).
> Old ide driver instead worked fine.
> 
> Tested on IBM 9114-275 where to use it i must boot with dma disabled i.e. with 
> libata.dma=0

Adding the linux-ide list on CC. Can you also send a dmesg with the old
IDE driver ? It might be useful to compare the values programmed by the
2 versions of the driver in the timing registers.

Cheers,
Ben.

> [...]
> pata_sl82c105 0000:00:03.1: enabling device (0144 -> 0145)
> scsi1 : pata_sl82c105
> scsi2 : pata_sl82c105
> ata1: PATA max MWDMA2 cmd 0x1f000 ctl 0x1f010 bmdma 0x1f040 irq 165
> ata2: PATA max MWDMA2 cmd 0x1f020 ctl 0x1f030 bmdma 0x1f048 irq 165
> ata1.00: ATAPI: IBM     DROM00205, NR38, max UDMA/33
> ata1.00: configured for MWDMA2
> [...]
> scsi 1:0:0:0: CD-ROM            IBM      DROM00205        NR38 PQ: 0 ANSI: 2
> sr0: scsi3-mmc drive: 24x/24x cd/rw xa/form2 cdda tray
> cdrom: Uniform CD-ROM driver Revision: 3.20
> sr 1:0:0:0: Attached scsi generic sg3 type 5
> [...]
> ata1: lost interrupt (Status 0x50)
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> sr 1:0:0:0: CDB: Get configuration: 46 00 00 00 00 00 00 00 20 00
> ata1.00: cmd a0/01:00:00:20:00/00:00:00:00:00/a0 tag 0 dma 16416 in
>          res 40/00:02:00:0c:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1: soft resetting link
> ata1.00: configured for MWDMA2
> ata1: EH complete
> sr0: CDROM (ioctl) error, command: Get configuration 46 00 00 00 00 00 00 00 
> 20 00
> sr: Sense Key : Aborted Command [current] [descriptor]
> sr: Add. Sense: No additional sense information
> ata1: lost interrupt (Status 0x50)
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> sr 1:0:0:0: CDB: Xdread, Read track info: 52 01 00 00 00 01 00 00 20 00
> ata1.00: cmd a0/01:00:00:20:00/00:00:00:00:00/a0 tag 0 dma 16416 in
>          res 40/00:02:00:08:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1: soft resetting link
> ata1.00: configured for MWDMA2
> ata1: EH complete
> sr0: CDROM (ioctl) error, command: Xdread, Read track info 52 01 00 00 00 01 
> 00 000
> sr: Sense Key : Aborted Command [current] [descriptor]
> sr: Add. Sense: No additional sense information
> ata1: lost interrupt (Status 0x50)
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> sr 1:0:0:0: CDB: Get configuration: 46 00 00 00 00 00 00 00 20 00
> ata1.00: cmd a0/01:00:00:20:00/00:00:00:00:00/a0 tag 0 dma 16416 in
>          res 40/00:02:00:0c:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1: soft resetting link
> ata1.00: configured for MWDMA2
> ata1: EH complete
> sr0: CDROM (ioctl) error, command: Get configuration 46 00 00 00 00 00 00 00 
> 20 00
> sr: Sense Key : Aborted Command [current] [descriptor]
> sr: Add. Sense: No additional sense information
> ata1: lost interrupt (Status 0x50)
> ata1.00: limiting speed to MWDMA1:PIO4
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> sr 1:0:0:0: CDB: Get configuration: 46 00 00 00 00 00 00 00 20 00
> ata1.00: cmd a0/01:00:00:20:00/00:00:00:00:00/a0 tag 0 dma 16416 in
>          res 40/00:02:00:0c:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1: soft resetting link
> ata1.00: configured for MWDMA1
> ata1: EH complete
> sr0: CDROM (ioctl) error, command: Get configuration 46 00 00 00 00 00 00 00 
> 20 00
> sr: Sense Key : Aborted Command [current] [descriptor]
> sr: Add. Sense: No additional sense information
> ata1: lost interrupt (Status 0x50)
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> sr 1:0:0:0: CDB: Get configuration: 46 00 00 00 00 00 00 00 20 00
> ata1.00: cmd a0/01:00:00:20:00/00:00:00:00:00/a0 tag 0 dma 16416 in
>          res 40/00:02:00:0c:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1: soft resetting link
> ata1.00: configured for MWDMA1
> ata1: EH complete
> sr0: CDROM (ioctl) error, command: Get configuration 46 00 00 00 00 00 00 00 
> 20 00
> sr: Sense Key : Aborted Command [current] [descriptor]
> sr: Add. Sense: No additional sense information
> ata1: lost interrupt (Status 0x50)
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> sr 1:0:0:0: CDB: Get configuration: 46 00 00 00 00 00 00 00 20 00
> ata1.00: cmd a0/01:00:00:20:00/00:00:00:00:00/a0 tag 0 dma 16416 in
>          res 40/00:02:00:0c:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1: soft resetting link
> ata1.00: configured for MWDMA1
> ata1: EH complete
> sr0: CDROM (ioctl) error, command: Get configuration 46 00 00 00 00 00 00 00 
> 20 00
> sr: Sense Key : Aborted Command [current] [descriptor]
> sr: Add. Sense: No additional sense information
> ata1: lost interrupt (Status 0x50)
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> sr 1:0:0:0: CDB: Get configuration: 46 00 00 00 00 00 00 00 20 00
> ata1.00: cmd a0/01:00:00:20:00/00:00:00:00:00/a0 tag 0 dma 16416 in
>          res 40/00:02:00:0c:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1: soft resetting link
> ata1.00: configured for MWDMA1
> ata1: EH complete
> sr0: CDROM (ioctl) error, command: Get configuration 46 00 00 00 00 00 00 00 
> 20 00
> sr: Sense Key : Aborted Command [current] [descriptor]
> sr: Add. Sense: No additional sense information
> ata1: lost interrupt (Status 0x50)
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> sr 1:0:0:0: CDB: Get configuration: 46 00 00 00 00 00 00 00 20 00
> ata1.00: cmd a0/01:00:00:20:00/00:00:00:00:00/a0 tag 0 dma 16416 in
>          res 40/00:02:00:0c:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1: soft resetting link
> ata1.00: configured for MWDMA1
> ata1: EH complete
> 
> 
> 
> 
> 
> 
> 
> cheers,
> --nico
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
