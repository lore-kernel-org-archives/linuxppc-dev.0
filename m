Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2101F2C00FC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Aug 2013 07:29:11 +1000 (EST)
Message-ID: <1377034134.25016.160.camel@pasglop>
Subject: Re: [PATCH] powerpc: add the missing required isync for the
 coherent icache flush
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kevin Hao <haokexin@gmail.com>
Date: Wed, 21 Aug 2013 07:28:54 +1000
In-Reply-To: <20130820121627.GB18634@pek-khao-d1.corp.ad.wrs.com>
References: <1376567767-20620-1-git-send-email-haokexin@gmail.com>
 <ABB05CD9C9F68C46A5CEDC7F1543925901020606@039-SN2MPN1-021.039d.mgd.msft.net>
 <1376883397.25016.60.camel@pasglop> <1376883437.25016.61.camel@pasglop>
 <20130819115029.GD20146@pek-khao-d1.corp.ad.wrs.com>
 <1376916335.25016.72.camel@pasglop>
 <20130820121627.GB18634@pek-khao-d1.corp.ad.wrs.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Wang Dongsheng-B40534 <B40534@freescale.com>,
 linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-08-20 at 20:16 +0800, Kevin Hao wrote:

> Dummy question: What does the ifetch buffers mean? The instruction fetch
> pipeline or instruction dispatch pipeline? Shouldn't all the prefetched
> instructions in these buffers be discarded by isync?

Architecturally isync doesn't have to toss prefetch completely. It only
needs to make sense that context changes performed by previous
instructions (and interrupts/traps) happen at the point of the isync,
for example, it will ensure that a trap conditional is fully evaluated
before subsequent instruction execution, etc....

So in this case, it makes sure the icbi has been executed and it's the
icbi that invalidates the prefetched instructions.

> 
> >, sync orders the icbi and isync ensures its execution has been
> > synchronized. At least I *think* that's the required sequence, I have to
> > dbl check the arch, maybe tomorrow. I wouldn't be surprise if we also
> > need a sync before the icbi to order the actual stores to memory that
> > might have modified instructions with the icbi.
> 
> Doesn't the coherence between icache and dcache be maintained by the snooping?

The icache yes, but not the ifetch buffers (basically think of them as
buffering stages between icache and dispatch). At least that's my
understanding of the implementation. 

Cheers,
Ben.

> Thanks,
> Kevin
> 
> > 
> > Cheers,
> > Ben.
> > 
> > > diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
> > > index d74fefb..8fcdec7 100644
> > > --- a/arch/powerpc/kernel/misc_64.S
> > > +++ b/arch/powerpc/kernel/misc_64.S
> > > @@ -69,6 +69,8 @@ PPC64_CACHES:
> > >  
> > >  _KPROBE(flush_icache_range)
> > >  BEGIN_FTR_SECTION
> > > +	icbi	0,r3
> > > +	sync
> > >  	isync
> > >  	blr
> > >  END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
> > > @@ -209,6 +211,8 @@ _GLOBAL(flush_inval_dcache_range)
> > >   */
> > >  _GLOBAL(__flush_dcache_icache)
> > >  BEGIN_FTR_SECTION
> > > +	icbi	0,r3
> > > +	sync
> > >  	isync
> > >  	blr
> > >  END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
> > > 
> > > Thanks,
> > > Kevin
> > > 
> > > > 
> > > > Cheers,
> > > > Ben.
> > > > 
> > > > > Cheers,
> > > > > Ben.
> > > > > 
> > > > > > >  	blr
> > > > > > >  END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
> > > > > > >  	rlwinm	r3,r3,0,0,31-PAGE_SHIFT		/* Get page base address
> > > > > > > */
> > > > > > > @@ -474,6 +475,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_44x)
> > > > > > >   */
> > > > > > >  _GLOBAL(__flush_dcache_icache_phys)
> > > > > > >  BEGIN_FTR_SECTION
> > > > > > > +	isync
> > > > > > >  	blr					/* for 601, do nothing */
> > > > > > >  END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
> > > > > > >  	mfmsr	r10
> > > > > > > diff --git a/arch/powerpc/kernel/misc_64.S
> > > > > > > b/arch/powerpc/kernel/misc_64.S
> > > > > > > index 992a78e..d74fefb 100644
> > > > > > > --- a/arch/powerpc/kernel/misc_64.S
> > > > > > > +++ b/arch/powerpc/kernel/misc_64.S
> > > > > > > @@ -69,6 +69,7 @@ PPC64_CACHES:
> > > > > > > 
> > > > > > >  _KPROBE(flush_icache_range)
> > > > > > >  BEGIN_FTR_SECTION
> > > > > > > +	isync
> > > > > > >  	blr
> > > > > > >  END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
> > > > > > >  /*
> > > > > > > --
> > > > > > > 1.8.3.1
> > > > > > > 
> > > > > > > _______________________________________________
> > > > > > > Linuxppc-dev mailing list
> > > > > > > Linuxppc-dev@lists.ozlabs.org
> > > > > > > https://lists.ozlabs.org/listinfo/linuxppc-dev
> > > > > > 
> > > > > 
> > > > 
> > > > 
> > 
> > 
