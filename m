Return-Path: <a.gusev1980@mail.ru>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A515DB6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  5 Jul 2009 21:18:00 +1000 (EST)
Received: from mx39.mail.ru (mx39.mail.ru [94.100.176.53])
	by ozlabs.org (Postfix) with ESMTP id C21B9DDD01
	for <linuxppc-dev@ozlabs.org>; Sun,  5 Jul 2009 21:17:59 +1000 (EST)
Date: Sun, 5 Jul 2009 15:17:54 +0400
From: Andrey Gusev <a.gusev1980@mail.ru>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Delay on intialization ide subsystem(most likely)
Message-ID: <20090705151754.6034ffad@power-debian>
In-Reply-To: <200906101344.30057.bzolnier@gmail.com>
References: <20090425170203.74603b9c@power-debian>
	<200906082220.41763.bzolnier@gmail.com>
	<1244503587.8971.9.camel@pasglop>
	<200906101344.30057.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, petkovbb@gmail.com, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 10 Jun 2009 13:44:29 +0200
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> On Tuesday 09 June 2009 01:26:27 Benjamin Herrenschmidt wrote:
> > On Mon, 2009-06-08 at 22:20 +0200, Bartlomiej Zolnierkiewicz wrote:
> > 
> > > > [   70.584122]  hdb:<3>ide-pmac lost interrupt, dma status: 8480
> > > 
> > > DMA status indicates that DMA transfer is still active according
> > > to the controller.  This one is really a platform/hardware
> > > specific issue.
> > 
> > I've partially missed that thread. Is the a bugzilla entry or
> 
> There is no bugzilla entry currently so please check mailing list
> archives for previous discussion.
> 
> > something ? Is this a regression ?
> 
> At least not a recent one (it happens since at least 2.6.24).
> 

Delay is fixed itself in 2.6.31-rc2. Most likely it was platform specific issue. But lost interrupt still exists.
There is log of 2.6.31-rc2:

[    1.595268] MacIO PCI driver attached to Keylargo chipset
[    1.597024] irq: irq 32 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 32
[    1.597988] irq: irq 19 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 19
[    1.598024] irq: irq 11 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 16
[    1.598365] irq: irq 20 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 20
[    1.598401] irq: irq 12 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 17
[    1.598762] irq: irq 5 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 18
[    1.598797] irq: irq 6 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 21
[    1.599264] irq: irq 7 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 24
[    1.599300] irq: irq 8 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 29
[    1.601336] Uniform Multi-Platform E-IDE driver
[    1.602201] ide-pmac 0002:20:0d.0: enabling device (0000 -> 0002)
[    2.630651] ide-pmac: Found Apple UniNorth ATA-6 controller (PCI), bus ID 3, irq 39
[    2.630767] Probing IDE interface ide0...
[    2.930834] hda: IBM-IC35L060AVVA07-0, ATA DISK drive
[    3.290646] hdb: QUANTUM FIREBALLP LM20.5, ATA DISK drive
[    3.291087] hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[    3.291264] hda: UDMA/100 mode selected
[    3.291473] hdb: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[    3.291720] hdb: UDMA/66 mode selected
[    3.292118] ide0 at 0xf10c2000-0xf10c2070,0xf10c2160 on irq 39
[    4.320649] ide-pmac: Found Apple KeyLargo ATA-4 controller (macio), bus ID 2, irq 19
[    4.320753] Probing IDE interface ide1...
[    4.921004] ide1 at 0xf10ba000-0xf10ba070,0xf10ba160 on irq 19
[    5.950647] ide-pmac: Found Apple KeyLargo ATA-3 controller (macio), bus ID 0, irq 20
[    5.950743] Probing IDE interface ide2...
[    6.370828] hde: PHILIPS CDD5101, ATAPI CD/DVD-ROM drive
[    6.730948] hde: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[    6.731332] hde: MWDMA2 mode selected
[    6.731832] ide2 at 0xf10be000-0xf10be070,0xf10be160 on irq 20
[    6.732558] ide-gd driver 1.18
[    6.732735] hda: max request size: 128KiB
[    6.763392] hda: 120103200 sectors (61492 MB) w/1863KiB Cache, CHS=65535/16/63
[    6.763741] hda: cache flushes supported
[    6.764277]  hda: [mac] hda1 hda2 hda3 hda4
[    6.770469] hdb: max request size: 128KiB
[    6.803427] hdb: Host Protected Area detected.
[    6.803431] 	current capacity is 40130390 sectors (20546 MB)
[    6.803435] 	native  capacity is 40132503 sectors (20547 MB)
[    6.803590] hdb: 40130390 sectors (20546 MB) w/1900KiB Cache, CHS=39811/16/63
[    6.803684] hdb: cache flushes not supported
[    6.803910]  hdb:
[   26.800743] ide-pmac lost interrupt, dma status: 8480
[   26.800809] hdb: lost interrupt
[   26.800850] hdb: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
[   26.800976] hdb: possibly failed opcode: 0xc8
[   26.803449] hda: DMA disabled
[   26.805664] hdb: DMA disabled
[   26.900633] ide0: reset: success
[   26.949147]  hdb1 hdb2 < hdb5 hdb6 hdb7 hdb8 >
[   27.007890] ide-cd driver 5.00
[   27.011728] ide-cd: hde: ATAPI 32X DVD-ROM CD-R/RW drive, 8192kB Cache
[   27.014163] Uniform CD-ROM driver Revision: 3.20
