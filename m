Return-Path: <murphyf+xfree86@f-m.fm>
Received: from smtp.hispeed.ch (mxout.hispeed.ch [62.2.95.247])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 93C832BDF2
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Nov 2004 21:20:20 +1100 (EST)
From: Frank Murphy <murphyf+xfree86@f-m.fm>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sat, 27 Nov 2004 09:48:06 +0100
References: <200411232008.16854.murphyf+xfree86@f-m.fm>
	<41A70567.8050000@petig-baender.de>
	<1101517373.4668.2.camel@gaston>
In-Reply-To: <1101517373.4668.2.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200411270948.08054.murphyf+xfree86@f-m.fm>
Cc: debian-x@lists.debian.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: G3 iBook LCD brightness in X under kernel 2.4.25 and 2.6.8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 27 November 2004 2:02, Benjamin Herrenschmidt wrote:
> On Fri, 2004-11-26 at 11:28 +0100, Christof Petig wrote:
> > > I'm running pbbuttonsd 0.6.6-2 with gtkpbbuttons 0.6.4-3 (which are
> > > tools that enable the LCD to be dimmed and brightened with keyboard
> > > pressed). When I'm running the Debian kernel-image 2.4.25-8 and I press
> > > the brightness up or down keys, I get the on-screen indication from
> > > gtkpbbuttons and the LCD dims or brightens as expected in both X and on
> > > the console. However, when I boot into kernel-image 2.6.8-6 or 2.6.9-1
> > > and press the brightness keys, I get the on-screen indication in X, but
> > > the LCD doesn't change brightness. However, if I switch to a VT with a
> > > console, the brightness changes to what I tried to change it to. Also,
> > > pressing the brightness buttons works fine when I press them while in
> > > the console.
>
> What machine model precisely ? If it's an iBook, only the very first one
> had a mach64 based chip and indeed used atyfb-based brightness control,
> that might have been broken...

It's a first generation iBook SE (Special Edition). The SE means that it came 
with a 6GB HD, more RAM, and a slightly faster CPU (366MHz), but it does have 
a Mach64.

> > > My video card is a Mach64, and I'm using the 'ati' driver for X. One
> > > guess I have is that in 2.6, lots more things are built as kernel
> > > modules. I'd like to try build any needed video stuff in, but I don't
> > > know what it could be. Does anyone here have an idea what controls
> > > screen brightness in X?
>
> Some earlier models have PMU-controlled brightness, independently on the
> video card...

So I don't think it's an "early model" because it came out later than the 
fruit-colored iBooks (it's grey and white, not <color>-berry like the real 
first gen iBooks).

> > Your mouse pointer might get some noisy spots on brightness change, ever
> > noticed? I would blame the kernel first (since 2.4 works well).
>
> Ah ? Haven't noticed that ? what machine ?
>
> > > The reason this is important for me is that the LCD is not dimmed when
> > > I close the lid for sleep, which kind of ruins the point of sleep.
> > >
> > > Does anyone have an idea of what else I need to do to get screen
> > > dimming to work under X with Linux 2.6?
>
> You may be missing the atyfb kernel driver.

So I've tried this using the stock Debian 2.6.8 and 2.6.9 PPC kernels with the 
same results.

$ grep ATY /boot/config-2.6.9-powerpc
CONFIG_FB_ATY128=y
CONFIG_FB_ATY=y
CONFIG_FB_ATY_CT=y
CONFIG_FB_ATY_GX=y
# CONFIG_FB_ATY_XL_INIT is not set

It seems that the atyfb module is compiled in. Is there another way to check?

Frank
