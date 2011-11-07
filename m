Return-Path: <johnstul@us.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 264A01007D4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2011 05:27:31 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <johnstul@us.ibm.com>;
 Mon, 7 Nov 2011 13:27:23 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pA7IRKpu286306
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Nov 2011 13:27:20 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pA7IRJbG017150
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Nov 2011 16:27:19 -0200
Message-ID: <1320690408.5809.4.camel@work-vm>
Subject: Re: [PATCH 2/4] powerpc/time: Use clocksource_register_hz
From: john stultz <johnstul@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Date: Mon, 07 Nov 2011 10:26:48 -0800
In-Reply-To: <20111105005551.GB31510@bloggs.ozlabs.ibm.com>
References: <20111103005922.854058953@samba.org>
 <20111103010111.951358660@samba.org> <1320326084.2892.4.camel@js-netbook>
 <20111105005551.GB31510@bloggs.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2011-11-05 at 11:55 +1100, Paul Mackerras wrote:
> On Thu, Nov 03, 2011 at 09:14:44AM -0400, John Stultz wrote:
> > On Thu, 2011-11-03 at 11:59 +1100, Anton Blanchard wrote:
> > > plain text document attachment (clock3)
> > > Use clocksource_register_hz which calculates the shift/mult
> > > factors for us.
> > > 
> > > Signed-off-by: Anton Blanchard <anton@samba.org>
> > > ---
> > > 
> > > Index: linux-build/arch/powerpc/kernel/time.c
> > > ===================================================================
> > > --- linux-build.orig/arch/powerpc/kernel/time.c	2011-11-03 10:19:59.493679032 +1100
> > > +++ linux-build/arch/powerpc/kernel/time.c	2011-11-03 10:20:00.965704053 +1100
> > > @@ -86,8 +86,6 @@ static struct clocksource clocksource_rt
> > >  	.rating       = 400,
> > >  	.flags        = CLOCK_SOURCE_IS_CONTINUOUS,
> > >  	.mask         = CLOCKSOURCE_MASK(64),
> > > -	.shift        = 22,
> > > -	.mult         = 0,	/* To be filled in */
> > >  	.read         = rtc_read,
> > >  };
> > > 
> > > @@ -97,8 +95,6 @@ static struct clocksource clocksource_ti
> > >  	.rating       = 400,
> > >  	.flags        = CLOCK_SOURCE_IS_CONTINUOUS,
> > >  	.mask         = CLOCKSOURCE_MASK(64),
> > > -	.shift        = 22,
> > > -	.mult         = 0,	/* To be filled in */
> > >  	.read         = timebase_read,
> > >  };
> > 
> > So I've held off on ppc conversion to clocksource_register_hz due to the
> > fact that the ppc vdso gettimeofday at least used to make assumptions
> > that shift was 22.
> > 
> > Is that no longer the case?
> 
> It is still the case; specifically, update_vsyscall() in
> arch/powerpc/kernel/time.c converts a multiplier value to a 'tb_to_xs'
> multiplier (timebase to xsec conversion factor, where 1 xsec = 2^-20
> seconds) using a factor which assumes a shift of 22.  The factor needs
> to be 2^(20 + 64 - shift) / 1e9, so we could accommodate other shift
> values by changing the line that computes new_tb_to_xs to do
> 
>        new_tb_to_xs = (u64) mult * (19342813113834067ULL >> shift);
> 
> assuming the shift value is easily available to update_vsyscall
> (I assume it would be clock->shift).

Ok. That sounds reasonable. clock->shift should be correct there.

thanks
-john
