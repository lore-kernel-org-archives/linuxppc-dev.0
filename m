Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 72ADF2C016F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 13:36:50 +1000 (EST)
Message-ID: <1376883397.25016.60.camel@pasglop>
Subject: Re: [PATCH] powerpc: add the missing required isync for the
 coherent icache flush
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wang Dongsheng-B40534 <B40534@freescale.com>
Date: Mon, 19 Aug 2013 13:36:37 +1000
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F1543925901020606@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1376567767-20620-1-git-send-email-haokexin@gmail.com>
 <ABB05CD9C9F68C46A5CEDC7F1543925901020606@039-SN2MPN1-021.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>, Kevin Hao <haokexin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-08-19 at 03:24 +0000, Wang Dongsheng-B40534 wrote:
> 
> > -----Original Message-----
> > From: Linuxppc-dev [mailto:linuxppc-dev-
> > bounces+b40534=freescale.com@lists.ozlabs.org] On Behalf Of Kevin Hao
> > Sent: Thursday, August 15, 2013 7:56 PM
> > To: Benjamin Herrenschmidt
> > Cc: linuxppc
> > Subject: [PATCH] powerpc: add the missing required isync for the coherent
> > icache flush
> > 
> > Even we don't need to flush the dcache and invalidate the icache
> > on the CPU which has coherent icache. But we do need an isync to
> > discard the prefetched instructions in this case.
> > 
> > Signed-off-by: Kevin Hao <haokexin@gmail.com>
> > ---
> >  arch/powerpc/kernel/misc_32.S | 2 ++
> >  arch/powerpc/kernel/misc_64.S | 1 +
> >  2 files changed, 3 insertions(+)
> > 
> > diff --git a/arch/powerpc/kernel/misc_32.S
> > b/arch/powerpc/kernel/misc_32.S
> > index 777d999..0b84c8d 100644
> > --- a/arch/powerpc/kernel/misc_32.S
> > +++ b/arch/powerpc/kernel/misc_32.S
> > @@ -433,6 +433,7 @@ _GLOBAL(invalidate_dcache_range)
> >   */
> >  _GLOBAL(__flush_dcache_icache)
> >  BEGIN_FTR_SECTION
> > +	isync
> There is not touch the icache, why need we to do this?

The semantic of this function is to make data executable. Even if the
implementation has a snooping icache, it *still* needs to make sure
prefetched code is tossed out of the pipeline which is what isync
should provide.

The architecture actually specifies that.

Cheers,
Ben.

> >  	blr
> >  END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
> >  	rlwinm	r3,r3,0,0,31-PAGE_SHIFT		/* Get page base address
> > */
> > @@ -474,6 +475,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_44x)
> >   */
> >  _GLOBAL(__flush_dcache_icache_phys)
> >  BEGIN_FTR_SECTION
> > +	isync
> >  	blr					/* for 601, do nothing */
> >  END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
> >  	mfmsr	r10
> > diff --git a/arch/powerpc/kernel/misc_64.S
> > b/arch/powerpc/kernel/misc_64.S
> > index 992a78e..d74fefb 100644
> > --- a/arch/powerpc/kernel/misc_64.S
> > +++ b/arch/powerpc/kernel/misc_64.S
> > @@ -69,6 +69,7 @@ PPC64_CACHES:
> > 
> >  _KPROBE(flush_icache_range)
> >  BEGIN_FTR_SECTION
> > +	isync
> >  	blr
> >  END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
> >  /*
> > --
> > 1.8.3.1
> > 
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
