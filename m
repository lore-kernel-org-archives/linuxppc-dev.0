Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E84AFDDE07
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2008 18:12:27 +1100 (EST)
Subject: Re: [PATCH 2/3] powerpc: Split mmu_context handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20081204171733.ad200e55.sfr@canb.auug.org.au>
References: <20081204054228.E8FE6DDE0F@ozlabs.org>
	<20081204171733.ad200e55.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Thu, 04 Dec 2008 18:10:13 +1100
Message-Id: <1228374613.7356.302.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-12-04 at 17:17 +1100, Stephen Rothwell wrote:

> Please don't make unrelated trivial fixups - they just make us look hard
> to see if something really changed.

Ooops... caught :-)

> > -/*
> > - * switch_mm is the entry point called from the architecture independent
> > +/* switch_mm is the entry point called from the architecture independent
> 
> The same goes for just changing the comment style away from the usual ...

Yeah, I felt that file had way too much white space in it :-)

> > --- linux-work.orig/arch/powerpc/kernel/head_32.S	2008-12-03 13:50:01.000000000 +1100
> > +++ linux-work/arch/powerpc/kernel/head_32.S	2008-12-03 13:50:18.000000000 +1100
> > @@ -1050,7 +1051,7 @@ start_here:
> >  	 * We do this here because we know the mmu is disabled, and
> >  	 * will be enabled for real in just a few instructions.
> >  	 */
> > -	lis	r5, abatron_pteptrs@h
> > +	lis	r5, abatron_pteptrs@h\
>                                      ^
> Is this right?

Nope. 

I really should review my own patches before posting them :-) Guess I
was in a hurry to go home.

> > +++ linux-work/arch/powerpc/mm/mmu_context_hash32.c	2008-12-03 13:50:18.000000000 +1100
> > +/*
> > + * This function defines the mapping from contexts to VSIDs (virtual
> > + * segment IDs).  We use a skew on both the context and the high 4 bits
> > + * of the 32-bit virtual address (the "effective segment ID") in order
> > + * to spread out the entries in the MMU hash table.  Note, if this
> > + * function is changed then arch/ppc/mm/hashtable.S will have to be
> > + * changed to correspond.
> > + */
> > +#define CTX_TO_VSID(ctx, va)	(((ctx) * (897 * 16) + ((va) >> 28) * 0x111) \
> > +				 & 0xffffff)
> 
> Any reason this is not a static inline function?  Hmmm, actually it
> doesn't look like it is used anywhere ... I guess its just for
> documentation?

This is just moved from it's previous location in mmu_context.h, and
yes, as it is, it's mostly documentation.

> > +++ linux-work/arch/powerpc/mm/mmu_context_nohash.c	2008-12-03 13:50:18.000000000 +1100
> > +#ifdef CONFIG_8xx
> > +#define NO_CONTEXT      	16
> > +#define LAST_CONTEXT    	15
> > +#define FIRST_CONTEXT    	0
> > +
> > +#elif defined(CONFIG_4xx)
> > +#define NO_CONTEXT      	256
> > +#define LAST_CONTEXT    	255
> > +#define FIRST_CONTEXT    	1
> > +
> > +#elif defined(CONFIG_E200) || defined(CONFIG_E500)
> > +#define NO_CONTEXT      	256
> > +#define LAST_CONTEXT    	255
> > +#define FIRST_CONTEXT    	1
> 
> Why not combine these last two?

I think some FSL can get more contexts, dunno, this is also just
existing code moved. In any case, I plan to remove those and make the
whole context count runtime selected anyway.

> > +static unsigned long next_mmu_context;
> 
> > +	/* free up context `next_mmu_context' */
> > +	/* if we shouldn't free context 0, don't... */
> > +	if (next_mmu_context < FIRST_CONTEXT)
> 
> If FIRST_CONTEXT is 0, this will generate a compiler warning (as
> next_mmu_context can't be < 0).

Same as above, existing code moved from mmu_context_32.c, not the place
to change that though it's a good catch. I don't think I still have this
issue after the next patch but I'll dbl check.

> > +config PPC_MMU_NOHASH_32
> > +	def_bool y
> > +	depends on PPC_MMU_NOHASH && PPC32
> > +
> > +config PPC_MMU_NOHASH_64
> > +	def_bool y
> > +	depends on PPC_MMU_NOHASH && PPC64
> 
> Neither of these are used anywhere.

Right well... I had something in mind for those that didn't make it into
this patch, I can remove them.

Cheers,
Ben.
