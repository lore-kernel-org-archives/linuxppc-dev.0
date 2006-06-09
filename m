Return-Path: <jdl@jdl.com>
Received: from jdl.com (colo.jdl.com [66.118.10.122])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E57A967C29
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Jun 2006 02:00:21 +1000 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/10 v2] Guard L3CR references with CPU_FTR_L3CR. 
In-Reply-To: Your message of "Fri, 09 Jun 2006 14:17:59 +1000."
	<1149826679.12687.44.camel@localhost.localdomain>
References: <1149803912.23938.282.camel@cashmere.sps.mot.com>
	<1149826679.12687.44.camel@localhost.localdomain>
Date: Fri, 09 Jun 2006 11:00:15 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1FojPE-0004Aj-0l@jdl.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Benjamin Herrenschmidt mumbled:
> On Thu, 2006-06-08 at 16:58 -0500, Jon Loeliger wrote:
> > Signed-off-by: Jon Loeliger <jdl@freescale.com>
> 
> Beware about this one... the CPU setup code might run before the feature
> fixup in the future...
> ...
> or go read the feature bit directly in the structure
> rather than relying on the fixup mecanism.

OK.

> you should probably do a separate setup function for your core

Truth be told, this is a pretty generic fix for other
parts as well. If I recall correctly, 7447, 7448, 7448A and 7450
as well as the new 8641 now.

But I can certainly introduce a new setup function here
if you think that is the right thing to do.  No problem.

Thanks,
jdl

> > --- a/arch/powerpc/kernel/cpu_setup_6xx.S
> > +++ b/arch/powerpc/kernel/cpu_setup_6xx.S

> > +BEGIN_FTR_SECTION
> >  	mfspr	r11,SPRN_L3CR
> >  	andis.	r11,r11,L3CR_L3E@h
> >  	beq	1f
> > +END_FTR_SECTION_IFSET(CPU_FTR_L3CR)
> >  	lwz	r6,CPU_SPEC_FEATURES(r5)
> >  	andi.	r0,r6,CPU_FTR_L3_DISABLE_NAP
> >  	beq	1f
