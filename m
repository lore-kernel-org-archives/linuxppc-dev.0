Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C46892C0085
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Sep 2012 09:50:13 +1000 (EST)
Message-ID: <1347061804.2385.58.camel@pasglop>
Subject: Re: [PATCH 2/2] powerpc/e6500: TLB miss handler with hardware
 tablewalk support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Sat, 08 Sep 2012 09:50:04 +1000
In-Reply-To: <504A7CBC.80803@freescale.com>
References: <20120614234101.GB17147@tyr.buserror.net>
 <1346992880.2385.51.camel@pasglop> <504A4C3D.3040709@freescale.com>
 <504A7CBC.80803@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> That would be one more cache line that misses need... and the threads
> share cache, so there's no ping-pong.

Ok, keep it that way then.

> >> After all that, do you have some bullets left for the HW designers ?
> 
> They seem to not care much about making our lives easier, only how bad
> the benchmarks will be without it -- and they seem to think TLB miss
> performance is no longer important since we won't take them as often
> with hardware tablewalk.  I suspect they'll be regretting that when they
> see workloads that thrash TLB1's ability to hold 2MiB indirect pages.
> Then it'll probably be "why can't you use larger page tables?" :-P

Didn't you simulate ?

> >>> +tlb_miss_common_e6500:
> >>> +	/*
> >>> +	 * Search if we already have an indirect entry for that virtual
> >>> +	 * address, and if we do, bail out.
> >>> +	 *
> >>> +	 * MAS6:IND should be already set based on MAS4
> >>> +	 */
> >>> +	addi	r10,r11,PERCORE_TLB_LOCK
> >>> +1:	lbarx	r15,0,r10
> >>> +	cmpdi	r15,0
> >>> +	bne	2f
> >>> +	li	r15,1
> >>> +	stbcx.	r15,0,r10
> >>
> >> No need for barriers here ?
> 
> I don't think so.  We're not guarding memory accesses, just the
> tlbsx+tlbwe.  At least on FSL cores those instructions have enough
> internal sync that isync shouldn't be needed (according to the core
> manual tlbsx, tlbwe, and stbcx. all have presync and postsync, so
> nothing else should be able to run at the same time).  And this is
> FSL-specific code. :-)

Sadly...

> >>>  #endif /* CONFIG_PPC64 */
> >>> @@ -377,7 +382,7 @@ void tlb_flush_pgtable(struct mmu_gather *tlb, unsigned long address)
> >>>  {
> >>>  	int tsize = mmu_psize_defs[mmu_pte_psize].enc;
> >>>  
> >>> -	if (book3e_htw_enabled) {
> >>> +	if (book3e_htw_mode) {
> >>
> >> Make it if (boot3e_htw_enabled != PPC_HTW_NONE)
> 
> Seems a little verbose, but OK.
> 
> Same with things like this, I guess:
> 	book3e_htw_mode ? "enabled" : "not supported"

Well, it's no longer a boolean so ...

BTW. On another note, can you pickup Ananth series for larger address
space (minus the one patch that breaks the BookE build, it shouldn't
matter) and see if there's any runtime issue on BookE 64 ? (And whether
the larger address space actually works for you too, using something
like high up mmap tests)

Cheers,
Ben.
