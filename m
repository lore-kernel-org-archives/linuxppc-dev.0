Return-Path: <adaplas@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by ozlabs.org (Postfix) with ESMTP id 19B58DDDE4
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 09:37:35 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so401857wag
	for <linuxppc-dev@ozlabs.org>; Wed, 06 Jun 2007 16:37:34 -0700 (PDT)
Subject: Re: [Linux-fbdev-devel] [patch 17/18] PS3: Frame buffer system-bus
	rework
From: "Antonino A. Daplas" <adaplas@gmail.com>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <46673E57.3020009@am.sony.com>
References: <20070606024407.786638029@am.sony.com> >
	<46662399.7030401@am.sony.com>
	<Pine.LNX.4.62.0706060849530.19499@pademelon.sonytel.be>
	<1181145418.5023.11.camel@daplas>  <46673E57.3020009@am.sony.com>
Content-Type: text/plain
Date: Thu, 07 Jun 2007 07:37:27 +0800
Message-Id: <1181173048.5023.20.camel@daplas>
Mime-Version: 1.0
Cc: "Geert.Uytterhoeven" <Geert.Uytterhoeven@sonycom.com>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	linux-fbdev-devel@lists.sourceforge.net, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-06-06 at 16:08 -0700, Geoff Levand wrote:
> Hi.
> 
> Antonino A. Daplas wrote:
> > On Wed, 2007-06-06 at 08:51 +0200, Geert Uytterhoeven wrote:
> >> This one should go through linux-fbdev-devel (CC) for review, but Paul can
> >> merge it because it depends on the PS3 system bus device rework.
> >> 
> > 
> >> >  
> >> > -static void ps3fb_shutdown(struct platform_device *dev)
> >> > +static int __devexit ps3fb_remove(struct ps3_system_bus_device *dev)
> >> >  {
> >> > -	ps3fb_flip_ctl(0);	/* flip off */
> >> > -	ps3fb.dinfo->irq.mask = 0;
> >> > -	free_irq(ps3fb.irq_no, ps3fb.dev);
> >> > -	ps3_irq_plug_destroy(ps3fb.irq_no);
> >> > -	iounmap((u8 __iomem *)ps3fb.dinfo);
> >> > +	BUG();
> > 
> > Why BUG()?
> 
> remove() doesn't work because lack of support from fbcon.

We already have console registration/unregistration support for the past
few kernel versions.

>   I'll remove
> this though, since it independent of the fbcon fix.

This is part of module_exit(), correct? Then yes, module-init-tools
will disallow rmmod to remove the module if fbcon is holding a reference
count to it. However, if fbcon is not loaded, or fbcon is not bound to
it (with an echo 0 > /sys/class/vtconsole/vtcon1/bind), then rmmod will
succeed, and so should ps3fb_remove().

Tony
