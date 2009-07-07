Return-Path: <a.gusev1980@mail.ru>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 60A44B70A4
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  8 Jul 2009 07:18:08 +1000 (EST)
Received: from mx76.mail.ru (mx76.mail.ru [94.100.176.91])
	by ozlabs.org (Postfix) with ESMTP id 9694CDDD0B
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Jul 2009 07:18:07 +1000 (EST)
Date: Wed, 8 Jul 2009 01:18:02 +0400
From: Andrey Gusev <a.gusev1980@mail.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Delay on intialization ide subsystem(most likely)
Message-ID: <20090708011802.74a7c21b@power-debian>
In-Reply-To: <1246922623.22625.57.camel@pasglop>
References: <20090425170203.74603b9c@power-debian>
	<200906101344.30057.bzolnier@gmail.com>
	<20090705151754.6034ffad@power-debian>
	<200907061704.38539.bzolnier@gmail.com>
	<1246922623.22625.57.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-ide@vger.kernel.org, petkovbb@gmail.com,
	David Miller <davem@davemloft.net>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 07 Jul 2009 09:23:42 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Mon, 2009-07-06 at 17:04 +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> > > Delay is fixed itself in 2.6.31-rc2. Most likely it was platform
> > > specific issue. But lost interrupt still exists. There is log of
> > > 2.6.31-rc2:
> > 
> > Thanks for letting us know.  When it comes to the lost interrupt
> > issue I still suspect that this is pmac specific problem (though
> > Dave may have some fresh idea about it).
> 

> Hard to tell. Those things generally work... maybe something is wrong
> with that disk vs. that timing. Does it work if you move it to the
> other controller (the one to which the CD drive is connected ?)
> 
> Cheers,
> Ben.

I tried this drive on ide1 and ide2, there are same issue. This drive worked
on P-III before (as separate on channel, with another hard drive and with cdrom)
and I didn't have any problem with it. There are chunks of dmesg.

On the ide1 channel:

[    1.585394] MacIO PCI driver attached to Keylargo chipset
[    1.587134] irq: irq 32 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 32
[    1.588076] irq: irq 19 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 19
[    1.588113] irq: irq 11 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 16
[    1.588449] irq: irq 20 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 20
[    1.588485] irq: irq 12 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 17
[    1.588838] irq: irq 5 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 18
[    1.588873] irq: irq 6 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 21
[    1.589335] irq: irq 7 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 24
[    1.589370] irq: irq 8 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 29
[    1.591439] Uniform Multi-Platform E-IDE driver
[    1.592362] ide-pmac 0002:20:0d.0: enabling device (0000 -> 0002)
[    2.610659] ide-pmac: Found Apple UniNorth ATA-6 controller (PCI), bus ID 3, irq 39
[    2.610777] Probing IDE interface ide0...
[    2.910841] hda: IBM-IC35L060AVVA07-0, ATA DISK drive
[    3.631031] hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[    3.631208] hda: UDMA/100 mode selected
[    3.631484] ide0 at 0xf10c2000-0xf10c2070,0xf10c2160 on irq 39
[    4.660656] ide-pmac: Found Apple KeyLargo ATA-4 controller (macio), bus ID 2, irq 19
[    4.660759] Probing IDE interface ide1...
[    4.960962] hdc: QUANTUM FIREBALLP LM20.5, ATA DISK drive
[    5.680974] hdc: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[    5.681248] hdc: UDMA/66 mode selected
[    5.681698] ide1 at 0xf10ba000-0xf10ba070,0xf10ba160 on irq 19
[    6.710656] ide-pmac: Found Apple KeyLargo ATA-3 controller (macio), bus ID 0, irq 20
[    6.710752] Probing IDE interface ide2...
[    7.311008] ide2 at 0xf10be000-0xf10be070,0xf10be160 on irq 20
[    7.311361] ide-gd driver 1.18
[    7.311548] hda: max request size: 128KiB
[    7.340930] hda: 120103200 sectors (61492 MB) w/1863KiB Cache, CHS=65535/16/63
[    7.341321] hda: cache flushes supported
[    7.341637]  hda: [mac] hda1 hda2 hda3 hda4
[    7.354161] hdc: max request size: 128KiB
[    7.383460] hdc: Host Protected Area detected.
[    7.383463] 	current capacity is 40130390 sectors (20546 MB)
[    7.383467] 	native  capacity is 40132503 sectors (20547 MB)
[    7.383625] hdc: 40130390 sectors (20546 MB) w/1900KiB Cache, CHS=39811/16/63
[    7.383721] hdc: cache flushes not supported
[    7.383965]  hdc:
[   27.380690] ide-pmac lost interrupt, dma status: 8480
[   27.380754] hdc: lost interrupt
[   27.380795] hdc: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
[   27.380911] hdc: possibly failed opcode: 0xc8
[   27.385964] hdc: DMA disabled
[   27.430645] ide1: reset: success
[   27.475435]  hdc1 hdc2 < hdc5 hdc6 hdc7 hdc8 >
[   27.533836] ide-cd driver 5.00

On the ide2 channel:

[    1.594873] MacIO PCI driver attached to Keylargo chipset
[    1.596780] irq: irq 32 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 32
[    1.597804] irq: irq 19 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 19
[    1.597841] irq: irq 11 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 16
[    1.598208] irq: irq 20 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 20
[    1.598244] irq: irq 12 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 17
[    1.598631] irq: irq 5 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 18
[    1.598666] irq: irq 6 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 21
[    1.599172] irq: irq 7 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 24
[    1.599208] irq: irq 8 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 29
[    1.601387] Uniform Multi-Platform E-IDE driver
[    1.602315] ide-pmac 0002:20:0d.0: enabling device (0000 -> 0002)
[    2.630650] ide-pmac: Found Apple UniNorth ATA-6 controller (PCI), bus ID 3, irq 39
[    2.630764] Probing IDE interface ide0...
[    2.930832] hda: IBM-IC35L060AVVA07-0, ATA DISK drive
[    3.651031] hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[    3.651211] hda: UDMA/100 mode selected
[    3.651487] ide0 at 0xf10c2000-0xf10c2070,0xf10c2160 on irq 39
[    4.680647] ide-pmac: Found Apple KeyLargo ATA-4 controller (macio), bus ID 2, irq 19
[    4.680748] Probing IDE interface ide1...
[    5.280995] ide1 at 0xf10ba000-0xf10ba070,0xf10ba160 on irq 19
[    6.310646] ide-pmac: Found Apple KeyLargo ATA-3 controller (macio), bus ID 0, irq 20
[    6.310740] Probing IDE interface ide2...
[    6.610828] hde: QUANTUM FIREBALLP LM20.5, ATA DISK drive
[    7.330944] hde: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[    7.331214] hde: MWDMA2 mode selected
[    7.331613] ide2 at 0xf10be000-0xf10be070,0xf10be160 on irq 20
[    7.332342] ide-gd driver 1.18
[    7.332527] hda: max request size: 128KiB
[    7.363393] hda: 120103200 sectors (61492 MB) w/1863KiB Cache, CHS=65535/16/63
[    7.363743] hda: cache flushes supported
[    7.364269]  hda: [mac] hda1 hda2 hda3 hda4
[    7.370602] hde: max request size: 128KiB
[    7.403456] hde: Host Protected Area detected.
[    7.403460] 	current capacity is 40130390 sectors (20546 MB)
[    7.403464] 	native  capacity is 40132503 sectors (20547 MB)
[    7.403629] hde: 40130390 sectors (20546 MB) w/1900KiB Cache, CHS=39811/16/63
[    7.403724] hde: cache flushes not supported
[    7.403978]  hde:
[   27.400744] ide-pmac lost interrupt, dma status: 8480
[   27.400811] hde: lost interrupt
[   27.400851] hde: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
[   27.400976] hde: possibly failed opcode: 0xc8
[   27.403945] hde: DMA disabled
[   27.450635] ide2: reset: success
[   27.493588]  hde1 hde2 < hde5 hde6 hde7 hde8 >
[   27.551998] ide-cd driver 5.00
