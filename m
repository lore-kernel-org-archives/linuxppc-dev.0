Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 62F022C0185
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 13:37:26 +1000 (EST)
Message-ID: <1376883437.25016.61.camel@pasglop>
Subject: Re: [PATCH] powerpc: add the missing required isync for the
 coherent icache flush
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wang Dongsheng-B40534 <B40534@freescale.com>
Date: Mon, 19 Aug 2013 13:37:17 +1000
In-Reply-To: <1376883397.25016.60.camel@pasglop>
References: <1376567767-20620-1-git-send-email-haokexin@gmail.com>
 <ABB05CD9C9F68C46A5CEDC7F1543925901020606@039-SN2MPN1-021.039d.mgd.msft.net>
 <1376883397.25016.60.camel@pasglop>
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

On Mon, 2013-08-19 at 13:36 +1000, Benjamin Herrenschmidt wrote:

> The semantic of this function is to make data executable. Even if the
> implementation has a snooping icache, it *still* needs to make sure
> prefetched code is tossed out of the pipeline which is what isync
> should provide.
> 
> The architecture actually specifies that.

In fact, on P5 and later, I think we are supposed to do a single dummy
icbi followed by sync and isync.

Cheers,
Ben.

> Cheers,
> Ben.
> 
> > >  	blr
> > >  END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
> > >  	rlwinm	r3,r3,0,0,31-PAGE_SHIFT		/* Get page base address
> > > */
> > > @@ -474,6 +475,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_44x)
> > >   */
> > >  _GLOBAL(__flush_dcache_icache_phys)
> > >  BEGIN_FTR_SECTION
> > > +	isync
> > >  	blr					/* for 601, do nothing */
> > >  END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
> > >  	mfmsr	r10
> > > diff --git a/arch/powerpc/kernel/misc_64.S
> > > b/arch/powerpc/kernel/misc_64.S
> > > index 992a78e..d74fefb 100644
> > > --- a/arch/powerpc/kernel/misc_64.S
> > > +++ b/arch/powerpc/kernel/misc_64.S
> > > @@ -69,6 +69,7 @@ PPC64_CACHES:
> > > 
> > >  _KPROBE(flush_icache_range)
> > >  BEGIN_FTR_SECTION
> > > +	isync
> > >  	blr
> > >  END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
> > >  /*
> > > --
> > > 1.8.3.1
> > > 
> > > _______________________________________________
> > > Linuxppc-dev mailing list
> > > Linuxppc-dev@lists.ozlabs.org
> > > https://lists.ozlabs.org/listinfo/linuxppc-dev
> > 
> 
