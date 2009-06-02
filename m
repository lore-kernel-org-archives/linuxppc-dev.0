Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 130CBDDD0B
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jun 2009 21:37:30 +1000 (EST)
Subject: Re: [PATCH 3/5] powerpc: Introduce CONFIG_PPC_BOOK3S
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200906021149.17816.arnd@arndb.de>
References: <20090602075022.57FE2DDF72@ozlabs.org>
	<200906021149.17816.arnd@arndb.de>
Content-Type: text/plain
Date: Tue, 02 Jun 2009 21:37:18 +1000
Message-Id: <1243942638.5308.48.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2009-06-02 at 11:49 +0100, Arnd Bergmann wrote:
> On Tuesday 02 June 2009, Benjamin Herrenschmidt wrote:
> > --- linux-work.orig/arch/powerpc/platforms/Kconfig.cputype	2009-06-02 16:29:27.000000000 +1000
> > +++ linux-work/arch/powerpc/platforms/Kconfig.cputype	2009-06-02 16:55:01.000000000 +1000
> > @@ -9,7 +9,6 @@ menu "Processor support"
> >  choice
> >  	prompt "Processor Type"
> >  	depends on PPC32
> > -	default 6xx
> >  	help
> >  	  There are five families of 32 bit PowerPC chips supported.
> >  	  The most common ones are the desktop and server CPUs (601, 603,
> 
> It looks like you couldn't decide which route to take here. You leave the
> 'depends on PPC32' above, but

The choice depends on PPC32 since there is no choice .. yet for 64-bit.
I removed the default 6xx because I noticed a warning from Kbuild that
it doesn't like defaults for choices.

> >  config PPC_85xx
> >  	bool "Freescale 85xx"
> > +	depends on PPC32

Ah right, I can remove these. Initially, the choice was available for
both 32 and 64 bit ;-) That's an artifact of the patch splitting since I
only introduce Book3E for 64-bit later.

> also add it (redundantly) in all other processor types except BOOK3S, and

Right. As I said, artifact of the split. I'll remove them for now.

> > -# Until we have a choice of exclusive CPU types on 64-bit, we always
> > -# use PPC_BOOK3S. On 32-bit, this is equivalent to 6xx which is
> > -# "classic" MMU
> > -
> >  config PPC_BOOK3S
> > -       def_bool y
> > -       depends on PPC64 || 6xx
> > +	default y
> > +       	depends on PPC64
> > +	select PPC_FPU
> > +
> 
> then add the other BOOK3S option depending on PPC64. Even though
> it might look silly to have a choice statement with just one possible
> option in case of PPC64, why not integrate it right away, for consistency
> reasons. It seems strange to have the same Kconfig symbol both
> as a choice and a simple bool.

Well, I was hesitating. The initial patch added the choice with E and S
for both 32 and 64 as you can guess. But we aren't ready for that yet.

I suppose I can do a one-option choice in the meantime.

> > @@ -125,6 +131,7 @@ config BOOKE
> >  config FSL_BOOKE
> >  	bool
> >  	depends on E200 || E500
> > +	select PPC_BOOK3E_MMU
> >  	default y
> >  
> >  config FSL_EMB_PERFMON
> > @@ -203,7 +210,7 @@ config SPE
> >  
> >  config PPC_STD_MMU
> >  	bool
> > -	depends on 6xx || PPC64
> > +	depends on PPC_BOOK3S
> >  	default y
> >  
> >  config PPC_STD_MMU_32
> 
> This also feels inconsistent, using a 'select' in one case and 'depends on' in the
> other one. The two ways are obviously equivalent, but I find it a bit confusing
> to mix them.

Right, I should probably use select in both.

Cheers,
Ben.
