Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9930E2BDB5
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Nov 2004 07:39:52 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Frank Murphy <murphyf+xfree86@f-m.fm>
In-Reply-To: <200411282114.48141.murphyf+xfree86@f-m.fm>
References: <200411232008.16854.murphyf+xfree86@f-m.fm>
	<200411270948.08054.murphyf+xfree86@f-m.fm>
	<1101607094.5176.0.camel@gaston>
	<200411282114.48141.murphyf+xfree86@f-m.fm>
Content-Type: text/plain
Date: Mon, 29 Nov 2004 07:39:39 +1100
Message-Id: <1101674379.4653.9.camel@gaston>
Mime-Version: 1.0
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

On Sun, 2004-11-28 at 21:14 +0100, Frank Murphy wrote:
> On Sunday 28 November 2004 2:58, Benjamin Herrenschmidt wrote:
> > >
> > > So I've tried this using the stock Debian 2.6.8 and 2.6.9 PPC kernels
> > > with the same results.
> > >
> > > $ grep ATY /boot/config-2.6.9-powerpc
> > > CONFIG_FB_ATY128=y
> > > CONFIG_FB_ATY=y
> > > CONFIG_FB_ATY_CT=y
> > > CONFIG_FB_ATY_GX=y
> > > # CONFIG_FB_ATY_XL_INIT is not set
> > >
> > > It seems that the atyfb module is compiled in. Is there another way to
> > > check?
> >
> > Check the bits in CONFIG_PMAC_BACKLIGHT in atyfb (like, add some
> > printk's to see if they are reached etc..)
> 
> So I added a couple of printk()s like you asked. I added one to 
> aty128fb_blank() in aty128fb.c:2037 and two to aty_init() in 
> atyfb_base.c:1793 and 1802 (inside the 'if (M64_HAS(MOBIL_BUS))'). The one I 
> added to aty128fb didn't print (as expected), but both of them from 
> atyfb_base.c printed. So it seems that CONFIG_PMAC_BACKLIGHT is properly 
> defined. Anything you'd specifically like me to try?

Well, the backlight control is done by writing to one of the LCD
register, you can try to track down the values in there and eventually
compare with 2.4

> I find it interesting that in the console the dimming works. I thought that on 
> PPC the console used the framebuffer. Another notable thing is that while in 
> X, the dimming doesn't work, but when I switch to one of the VTs, the screen 
> brightness is adjusted to what it should have been in X.

Ah ? What do you mean by "dimming" ? blanking ? or backlight control ?

Could be some crap done by the X driver ... It's notoriously allergic to
fbdev's ... I'll have to double check.

> Thanks for your help on this,
> 
> Frank
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>
