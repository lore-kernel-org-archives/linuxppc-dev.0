Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id AB8A667B67
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Sep 2006 14:43:43 +1000 (EST)
Date: Wed, 27 Sep 2006 23:43:04 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: [PATCH 2/2] enable generic rtc hook for the MPC8349 mITX
Message-Id: <20060927234304.0cf4d22d.kim.phillips@freescale.com>
In-Reply-To: <20060927155853.GB2385@smtp.west.cox.net>
References: <20060926174651.032a474e.kim.phillips@freescale.com>
	<B35FD5A1-2C71-41E2-A014-A2C8D37F10C2@kernel.crashing.org>
	<20060927155853.GB2385@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 27 Sep 2006 08:58:53 -0700
Tom Rini <trini@kernel.crashing.org> wrote:

> On Tue, Sep 26, 2006 at 11:34:43PM -0500, Kumar Gala wrote:
> > On Sep 26, 2006, at 5:46 PM, Kim Phillips wrote:
> [snip]
> > > diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/ 
> > > powerpc/platforms/83xx/mpc834x_itx.c
> > > index 969fbb6..8c676d7 100644
> > > --- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
> > > +++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
> > > @@ -109,6 +109,10 @@ static int __init mpc834x_itx_probe(void
> > >  	return 1;
> > >  }
> > >
> > > +#ifdef CONFIG_RTC_CLASS
> > > +late_initcall(rtc_class_hookup);
> > > +#endif
> > 
> > Any reason we can't just do this in setup_arch?
> 
> I think because of rtc-over-i2c and similar where we need the whole rest
> of the system 'up' before we can try and use the RTC (which might not be
> the case for this specific board, but for consistency it looks like a
> good thing to always do it like this).
> 
this is indeed the case, as with the static assignment of the ppc_md rtc_time functions in define_machine.  In the early assignment case, the kernel oopses early in rtc_class_open().

During testing I noticed hwclock get/set operations worked even without hooking up with the ppc_md rtc_time functions.  Turns out this rtc_class provides access to the RTC to the whole kernel and userspace:

http://lkml.org/lkml/2005/12/20/220

so, both of these patches are really unnecessary, unless there's a genuine consumer in arch/powerpc that I can't find (I'm assuming get_boot_time() isn't one of them since it gets called way too early in the rtc-over-i2c based platform case).

So we should just configure RTC_CLASS and the specific chip and we're done. :)

Kim
