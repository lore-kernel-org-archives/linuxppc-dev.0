Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C8598DDF80
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Mar 2009 15:03:22 +1100 (EST)
Subject: Re: [patch 1/2] powerpc: optimise smp_mb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nick Piggin <npiggin@suse.de>
In-Reply-To: <20090219171229.GJ1747@wotan.suse.de>
References: <20090219171229.GJ1747@wotan.suse.de>
Content-Type: text/plain
Date: Wed, 04 Mar 2009 15:03:15 +1100
Message-Id: <1236139395.6696.9.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Allright, sorry for the delay, I had those stored into my "need more
than half a brain cell for review" list and only got to them today :-)

On Thu, 2009-02-19 at 18:12 +0100, Nick Piggin wrote:
> Using lwsync, isync sequence in a microbenchmark is 5 times faster on my G5 than
> using sync for smp_mb. Although it takes more instructions.
> 
> Running tbench with 4 clients on my 4 core G5 (20 times) gives the
> following:
> 
> unpatched AVG=920.33 STD=2.36
>   patched AVG=921.27 STD=2.77
> 
> So not a big improvement here, actually it could even be in the noise.
> But other workloads or systems might see a bigger win, and the patch
> maybe is interesting or could be improved, so I'll ask for comments. 

So not a huge objection here, however I have some doubts as to whether
this will be worthwhile on power5,6,7 since those optimized somewhat the
behaviour of the full sync. Since anything older than power4 doesn't
have lwsync, that potentially makes it not worth the pain.

But I need to measure to be sure... it might be that newer embedded
processors that support lwsync and SMP (and that are using a different
pipeline structure) might benefit from this. I'll try to run some tests
later this week or next week, but ping me in case I forget.

Now what would be worth doing is to also try using a twi;isync sequence
like we do to order MMIO reads, see if it's any better than cmp/branch

Cheers,
Ben.

> ---
> Index: linux-2.6/arch/powerpc/include/asm/system.h
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/include/asm/system.h	2009-02-20 01:51:24.000000000 +1100
> +++ linux-2.6/arch/powerpc/include/asm/system.h	2009-02-20 02:09:41.000000000 +1100
> @@ -52,7 +52,16 @@
>  #    define SMPWMB      eieio
>  #endif
>  
> +#ifdef __powerpc64__
> +#define smp_mb()	__asm__ __volatile__ (				    \
> +					"1:	lwsync			\n" \
> +					"	cmpw	0,%%r0,%%r0	\n" \
> +					"	bne-	1b		\n" \
> +					"	isync			\n" \
> +					: : : "memory")
> +#else
>  #define smp_mb()	mb()
> +#endif
>  #define smp_rmb()	__asm__ __volatile__ (stringify_in_c(LWSYNC) : : :"memory")
>  #define smp_wmb()	__asm__ __volatile__ (stringify_in_c(SMPWMB) : : :"memory")
>  #define smp_read_barrier_depends()	read_barrier_depends()
