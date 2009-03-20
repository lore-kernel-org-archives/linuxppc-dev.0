Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 14BA5DDEF0
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 17:27:08 +1100 (EST)
Subject: Re: IDE cable detection on Apple PowerBook
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: TOMARI Hisanobu <posco.grubb@gmail.com>
In-Reply-To: <20090319223001.c2674366.posco.grubb@gmail.com>
References: <20090318140638.e6b61eaa.posco.grubb@gmail.com>
	<1237363097.25062.345.camel@pasglop>
	<20090318224726.5cf83e23.posco.grubb@gmail.com>
	<1237442846.25062.466.camel@pasglop>
	<1237442917.25062.467.camel@pasglop>
	<20090319223001.c2674366.posco.grubb@gmail.com>
Content-Type: text/plain
Date: Fri, 20 Mar 2009 17:27:00 +1100
Message-Id: <1237530420.25062.570.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-03-19 at 22:30 +0900, TOMARI Hisanobu wrote:
> Thanks for helpful advices.
> This patch adds an option to drivers/ide/Kconfig and adds 
> some lines to drivers/ide/pmac.c . Now the driver checks
> if the model is prefixed with "PowerBook" and the entire hack
> can be toggled in the Kconfig.
> 
> Again, the patch is against linux 2.6.28.8.

Ack. I forwarded it to Bart for his queue.

Ben.

> Best regards,
> TOMARI Hisanobu
> 
> p.s. oddly, the drive works in ATA/100 mode under untouched
> MacOS X 10.5.
> 
> On Thu, 19 Mar 2009 17:08:37 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > On Thu, 2009-03-19 at 17:07 +1100, Benjamin Herrenschmidt wrote:
> > > On Wed, 2009-03-18 at 22:47 +0900, TOMARI Hisanobu wrote:
> > > > I thought the short-40pin assumption would cause no problem
> > > > considering all models beginning with "PowerBook5" are laptops.
> > > > Do you mean an option to toggle this hack on/off should be present 
> > > > in Kconfig?
> > > 
> > > Actually, it makes -some- amount of sense to do it by testing
> > > specifically for the prefix "PowerBook" and "iBook" without a specific
> > > number I suppose.
> > 
> > Actually "PowerBook" is enough, there's no iBook prefix in the
> > device-tree, I was confusing with old busted iMac firmwares that used
> > iMac instead of PowerMac in there.
> > 
> > Cheers,
> > Ben.
> > 
> > > Ben.
> > > 
> > > > Thanks,
> > > > TOMARI Hisanobu
> > > > 
> > > > On Wed, 18 Mar 2009 18:58:17 +1100
> > > > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > > > 
> > > > > On Wed, 2009-03-18 at 14:06 +0900, TOMARI Hisanobu wrote:
> > > > > > Hello,
> > > > > > 
> > > > > > I'm using an OCZ PATA SSD on Apple PowerBook5,4 computer.
> > > > > > The IDE drive fails to recognize 80-conductor cable that
> > > > > > connects the drive to motherboard to fall back to UDMA33.
> > > > > > 
> > > > > > This patch fixes this behavior by assuming that the cable is
> > > > > > short-40pin when the model string matches "PowerBook5" and 
> > > > > > the motherboard detects 80c cable.
> > > > > > 
> > > > > > This patch is against drivers/ide/pmac.c in linux 2.6.28.8.
> > > > > 
> > > > > The patch is too much of an ad-hoc hack... _maybe_ an option is to make
> > > > > the core fallback to 40 "short" when 80 pin detection fails on
> > > > > powerbooks instead ?
> > > > > 
> > > > > Ben.
> > > > > 
> > > > > > (before applying the patch) hdparm -i /dev/hda
> > > > > > /dev/hda:
> > > > > >  Timing buffered disk reads:   90 MB in  3.03 seconds =  29.73 MB/sec
> > > > > > (dmesg 2.6.26)
> > > > > > ide0: Found Apple UniNorth ATA-6 controller, bus ID 3, irq 39
> > > > > > Probing IDE interface ide0...
> > > > > > hda: CORE_PATA, ATA DISK drive
> > > > > > hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
> > > > > > hda: drive side 80-wire cable detection failed, limiting max speed to UDMA33
> > > > > > hda: UDMA/33 mode selected
> > > > > > 
> > > > > > (after applying the patch) hdparm -i /dev/hda
> > > > > > /dev/hda:
> > > > > >  Timing buffered disk reads:  240 MB in  3.02 seconds =  79.42 MB/sec
> > > > > > (dmesg 2.6.28.8)
> > > > > > ide-pmac: Found Apple UniNorth ATA-6 controller (PCI), bus ID 3, irq 39
> > > > > > Probing IDE interface ide0...
> > > > > > hda: CORE_PATA, ATA DISK drive
> > > > > > hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
> > > > > > hda: UDMA/100 mode selected
> > > > > > ide0 at 0xf102a000-0xf102a070,0xf102a160 on irq 39
> > > > > > 
> > > > > > 
> > > > > > _______________________________________________
> > > > > > Linuxppc-dev mailing list
> > > > > > Linuxppc-dev@ozlabs.org
> > > > > > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> > > > > 
> > 
