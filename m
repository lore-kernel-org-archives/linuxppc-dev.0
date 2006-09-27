Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao04.cox.net (fed1rmmtao04.cox.net [68.230.241.35])
	by ozlabs.org (Postfix) with ESMTP id C269E67BC3
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Sep 2006 01:58:55 +1000 (EST)
Date: Wed, 27 Sep 2006 08:58:53 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/2] enable generic rtc hook for the MPC8349 mITX
Message-ID: <20060927155853.GB2385@smtp.west.cox.net>
References: <20060926174651.032a474e.kim.phillips@freescale.com>
	<B35FD5A1-2C71-41E2-A014-A2C8D37F10C2@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <B35FD5A1-2C71-41E2-A014-A2C8D37F10C2@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 26, 2006 at 11:34:43PM -0500, Kumar Gala wrote:
> On Sep 26, 2006, at 5:46 PM, Kim Phillips wrote:
[snip]
> > diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/ 
> > powerpc/platforms/83xx/mpc834x_itx.c
> > index 969fbb6..8c676d7 100644
> > --- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
> > +++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
> > @@ -109,6 +109,10 @@ static int __init mpc834x_itx_probe(void
> >  	return 1;
> >  }
> >
> > +#ifdef CONFIG_RTC_CLASS
> > +late_initcall(rtc_class_hookup);
> > +#endif
> 
> Any reason we can't just do this in setup_arch?

I think because of rtc-over-i2c and similar where we need the whole rest
of the system 'up' before we can try and use the RTC (which might not be
the case for this specific board, but for consistency it looks like a
good thing to always do it like this).

-- 
Tom Rini
