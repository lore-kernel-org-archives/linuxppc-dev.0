Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BEDB52BDF2
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Nov 2004 12:03:08 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christof Petig <lists@petig-baender.de>
In-Reply-To: <41A70567.8050000@petig-baender.de>
References: <200411232008.16854.murphyf+xfree86@f-m.fm>
	<41A70567.8050000@petig-baender.de>
Content-Type: text/plain
Date: Sat, 27 Nov 2004 12:02:53 +1100
Message-Id: <1101517373.4668.2.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Frank Murphy <murphyf+xfree86@f-m.fm>, debian-x@lists.debian.org
Subject: Re: G3 iBook LCD brightness in X under kernel 2.4.25 and 2.6.8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2004-11-26 at 11:28 +0100, Christof Petig wrote:

> > I'm running pbbuttonsd 0.6.6-2 with gtkpbbuttons 0.6.4-3 (which are tools that 
> > enable the LCD to be dimmed and brightened with keyboard pressed). When I'm 
> > running the Debian kernel-image 2.4.25-8 and I press the brightness up or 
> > down keys, I get the on-screen indication from gtkpbbuttons and the LCD dims 
> > or brightens as expected in both X and on the console. However, when I boot 
> > into kernel-image 2.6.8-6 or 2.6.9-1 and press the brightness keys, I get the 
> > on-screen indication in X, but the LCD doesn't change brightness. However, if 
> > I switch to a VT with a console, the brightness changes to what I tried to 
> > change it to. Also, pressing the brightness buttons works fine when I press 
> > them while in the console.

What machine model precisely ? If it's an iBook, only the very first one
had a mach64 based chip and indeed used atyfb-based brightness control,
that might have been broken...

> > My video card is a Mach64, and I'm using the 'ati' driver for X. One guess I 
> > have is that in 2.6, lots more things are built as kernel modules. I'd like 
> > to try build any needed video stuff in, but I don't know what it could be. 
> > Does anyone here have an idea what controls screen brightness in X?

Some earlier models have PMU-controlled brightness, independently on the
video card...

> Your mouse pointer might get some noisy spots on brightness change, ever 
> noticed? I would blame the kernel first (since 2.4 works well).

Ah ? Haven't noticed that ? what machine ? 

> > The reason this is important for me is that the LCD is not dimmed when I close 
> > the lid for sleep, which kind of ruins the point of sleep.
> > 
> > Does anyone have an idea of what else I need to do to get screen dimming to 
> > work under X with Linux 2.6?

You may be missing the atyfb kernel driver.

> Try to ask on the ppc-kernel list (CCed). I suspect that nobody has 
> reimplemented power management for mach64 in 2.6. The fact that lid 
> closing does not put the display to sleep keeps me locked in 2.4, too 
> (though I experienced that 2.6 is way faster).

It is, provided you have the right driver.

> I played with the thought of fixing it myself (like I plan to fix DRI 
> DMA some time) but was unable to allocate ressources (and enough motivation)
> 
> So take this as a "I have the problem, too" posting
>     Christof
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>
