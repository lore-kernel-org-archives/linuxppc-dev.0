Return-Path: <posco.grubb@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.183])
	by ozlabs.org (Postfix) with ESMTP id AAB5BDDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 00:47:33 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id j37so30308waf.9
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2009 06:47:32 -0700 (PDT)
Date: Wed, 18 Mar 2009 22:47:26 +0900
From: TOMARI Hisanobu <posco.grubb@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: IDE cable detection on Apple PowerBook
Message-Id: <20090318224726.5cf83e23.posco.grubb@gmail.com>
In-Reply-To: <1237363097.25062.345.camel@pasglop>
References: <20090318140638.e6b61eaa.posco.grubb@gmail.com>
	<1237363097.25062.345.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I thought the short-40pin assumption would cause no problem
considering all models beginning with "PowerBook5" are laptops.
Do you mean an option to toggle this hack on/off should be present 
in Kconfig?

Thanks,
TOMARI Hisanobu

On Wed, 18 Mar 2009 18:58:17 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Wed, 2009-03-18 at 14:06 +0900, TOMARI Hisanobu wrote:
> > Hello,
> > 
> > I'm using an OCZ PATA SSD on Apple PowerBook5,4 computer.
> > The IDE drive fails to recognize 80-conductor cable that
> > connects the drive to motherboard to fall back to UDMA33.
> > 
> > This patch fixes this behavior by assuming that the cable is
> > short-40pin when the model string matches "PowerBook5" and 
> > the motherboard detects 80c cable.
> > 
> > This patch is against drivers/ide/pmac.c in linux 2.6.28.8.
> 
> The patch is too much of an ad-hoc hack... _maybe_ an option is to make
> the core fallback to 40 "short" when 80 pin detection fails on
> powerbooks instead ?
> 
> Ben.
> 
> > (before applying the patch) hdparm -i /dev/hda
> > /dev/hda:
> >  Timing buffered disk reads:   90 MB in  3.03 seconds =  29.73 MB/sec
> > (dmesg 2.6.26)
> > ide0: Found Apple UniNorth ATA-6 controller, bus ID 3, irq 39
> > Probing IDE interface ide0...
> > hda: CORE_PATA, ATA DISK drive
> > hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
> > hda: drive side 80-wire cable detection failed, limiting max speed to UDMA33
> > hda: UDMA/33 mode selected
> > 
> > (after applying the patch) hdparm -i /dev/hda
> > /dev/hda:
> >  Timing buffered disk reads:  240 MB in  3.02 seconds =  79.42 MB/sec
> > (dmesg 2.6.28.8)
> > ide-pmac: Found Apple UniNorth ATA-6 controller (PCI), bus ID 3, irq 39
> > Probing IDE interface ide0...
> > hda: CORE_PATA, ATA DISK drive
> > hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
> > hda: UDMA/100 mode selected
> > ide0 at 0xf102a000-0xf102a070,0xf102a160 on irq 39
> > 
> > 
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
