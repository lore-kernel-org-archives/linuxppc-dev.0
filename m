Return-Path: <murphyf+xfree86@f-m.fm>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by ozlabs.org (Postfix) with ESMTP id 80FC72BDF2
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Nov 2004 20:42:50 +1100 (EST)
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
References: <200411232008.16854.murphyf+xfree86@f-m.fm>   
	<200411270948.08054.murphyf+xfree86@f-m.fm>   
	<1101607094.5176.0.camel@gaston>   
	<200411282114.48141.murphyf+xfree86@f-m.fm>   
	<1101674379.4653.9.camel@gaston>
In-Reply-To: <1101674379.4653.9.camel@gaston>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	"Frank Murphy" <murphyf+xfree86@f-m.fm>
Date: Mon, 29 Nov 2004 10:42:35 +0100
From: "Frank Murphy" <murphyf+xfree86@f-m.fm>
Message-Id: <1101721355.31317.209633721@webmail.messagingengine.com>
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


On Mon, 29 Nov 2004 07:39:39 +1100, "Benjamin Herrenschmidt" said:
> On Sun, 2004-11-28 at 21:14 +0100, Frank Murphy wrote:
> > On Sunday 28 November 2004 2:58, Benjamin Herrenschmidt wrote:
> > > >
> > > > So I've tried this using the stock Debian 2.6.8 and 2.6.9 PPC kernels
> > > > with the same results.
> > > >
> > > > $ grep ATY /boot/config-2.6.9-powerpc
> > > > CONFIG_FB_ATY128=y
> > > > CONFIG_FB_ATY=y
> > > > CONFIG_FB_ATY_CT=y
> > > > CONFIG_FB_ATY_GX=y
> > > > # CONFIG_FB_ATY_XL_INIT is not set
> > > >
> > > > It seems that the atyfb module is compiled in. Is there another way to
> > > > check?
> > >
> > > Check the bits in CONFIG_PMAC_BACKLIGHT in atyfb (like, add some
> > > printk's to see if they are reached etc..)
> > 
> > So I added a couple of printk()s like you asked. I added one to 
> > aty128fb_blank() in aty128fb.c:2037 and two to aty_init() in 
> > atyfb_base.c:1793 and 1802 (inside the 'if (M64_HAS(MOBIL_BUS))'). The one I 
> > added to aty128fb didn't print (as expected), but both of them from 
> > atyfb_base.c printed. So it seems that CONFIG_PMAC_BACKLIGHT is properly 
> > defined. Anything you'd specifically like me to try?
> 
> Well, the backlight control is done by writing to one of the LCD
> register, you can try to track down the values in there and eventually
> compare with 2.4

I'll try to look at this, but I don't know very much about it.

> > I find it interesting that in the console the dimming works. I thought that on 
> > PPC the console used the framebuffer. Another notable thing is that while in 
> > X, the dimming doesn't work, but when I switch to one of the VTs, the screen 
> > brightness is adjusted to what it should have been in X.
> 
> Ah ? What do you mean by "dimming" ? blanking ? or backlight control ?

OK, the F1 and F2 keys on my keyboard have little "brighter"/"dimmer"
icons on them. When I press them when running X on 2.4.25, the screen
brightness changes. So for me, that's "dimming." I believe that it's the
"backlight control" that does this. When I press the "dimmer" button
enough (8 times, I think), then the backlight turns totally off, and I
can't see anything on the screen. For me that's "blanking" in this
context. It's true that something else (X, I think) will kind of blank
the screen, but the backlight stays lit. I noticed this when I closed
the lid to make the iBook sleep, but the backlight stayed on, warming
the keyboard. I then noticed the same problem with the dimmer keys.

> Could be some crap done by the X driver ... It's notoriously allergic to
> fbdev's ... I'll have to double check.

It probably is. But it's strange because I use all the same software
except the kernel to get this behavior. So there's something with the
kernel / X interface that has changed, either for 2.6 or the way Debian
builds 2.6. I have a hard time with this because there are so many
interactions:  is it the PMU? The APM emulation? X driver? Kernel
driver? I don't have a good idea about how these things interact.

Let me know what you find out.

Frank
