Return-Path: <msuchanek@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41m2rQ5DTvzDqk9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 06:22:56 +1000 (AEST)
Date: Wed, 8 Aug 2018 22:22:52 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, "Gautham R . Shenoy"
 <ego@linux.vnet.ibm.com>, Mahesh Jagannath Salgaonkar
 <mahesh@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, Akshay Adiga
 <akshay.adiga@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/64s: move machine check SLB flushing to
 mm/slb.c
Message-ID: <20180808222252.5be0feac@kitsune.suse.cz>
In-Reply-To: <20180803041350.25493-1-npiggin@gmail.com>
References: <20180803041350.25493-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri,  3 Aug 2018 14:13:49 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> The machine check code that flushes and restores bolted segments in
> real mode belongs in mm/slb.c. This will be used by pseries machine
> check and idle code.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/include/asm/book3s/64/mmu-hash.h |  3 ++
>  arch/powerpc/kernel/mce_power.c               | 21 ++--------
>  arch/powerpc/mm/slb.c                         | 38
> +++++++++++++++++++ 3 files changed, 44 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> b/arch/powerpc/include/asm/book3s/64/mmu-hash.h index
> 2f74bdc805e0..d4e398185b3a 100644 ---
> a/arch/powerpc/include/asm/book3s/64/mmu-hash.h +++
> b/arch/powerpc/include/asm/book3s/64/mmu-hash.h @@ -497,6 +497,9 @@
> extern void hpte_init_native(void); 
>  extern void slb_initialize(void);
>  extern void slb_flush_and_rebolt(void);
> +extern void slb_flush_all_realmode(void);
> +extern void __slb_restore_bolted_realmode(void);
> +extern void slb_restore_bolted_realmode(void);
>  
>  extern void slb_vmalloc_update(void);
>  extern void slb_set_size(u16 size);
> diff --git a/arch/powerpc/kernel/mce_power.c
> b/arch/powerpc/kernel/mce_power.c index d6756af6ec78..50f7b9817246
> 100644 --- a/arch/powerpc/kernel/mce_power.c
> +++ b/arch/powerpc/kernel/mce_power.c
> @@ -62,11 +62,8 @@ static unsigned long addr_to_pfn(struct pt_regs
> *regs, unsigned long addr) #ifdef CONFIG_PPC_BOOK3S_64
>  static void flush_and_reload_slb(void)
>  {
> -	struct slb_shadow *slb;
> -	unsigned long i, n;
> -
>  	/* Invalidate all SLBs */
> -	asm volatile("slbmte %0,%0; slbia" : : "r" (0));
> +	slb_flush_all_realmode();
>  
>  #ifdef CONFIG_KVM_BOOK3S_HANDLER
>  	/*
> @@ -76,22 +73,10 @@ static void flush_and_reload_slb(void)
>  	if (get_paca()->kvm_hstate.in_guest)
>  		return;
>  #endif
> -
> -	/* For host kernel, reload the SLBs from shadow SLB buffer.
> */
> -	slb = get_slb_shadow();
> -	if (!slb)
> +	if (early_radix_enabled())
>  		return;

And we lose the check that the shadow slb exists. Is !slb equivalent to
early_radix_enabled() 

>  
> -	n = min_t(u32, be32_to_cpu(slb->persistent), SLB_MIN_SIZE);
> -
> -	/* Load up the SLB entries from shadow SLB */
> -	for (i = 0; i < n; i++) {
> -		unsigned long rb =
> be64_to_cpu(slb->save_area[i].esid);
> -		unsigned long rs =
> be64_to_cpu(slb->save_area[i].vsid); -
> -		rb = (rb & ~0xFFFul) | i;
> -		asm volatile("slbmte %0,%1" : : "r" (rs), "r" (rb));
> -	}
> +	slb_restore_bolted_realmode();
>  }
>  #endif
>  
> diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
> index cb796724a6fc..136db8652577 100644
> --- a/arch/powerpc/mm/slb.c
> +++ b/arch/powerpc/mm/slb.c
> @@ -90,6 +90,44 @@ static inline void create_shadowed_slbe(unsigned
> long ea, int ssize, : "memory" );
>  }
>  
> +/*
> + * Insert bolted entries into SLB (which may not be empty).
> + */
> +void __slb_restore_bolted_realmode(void)
> +{
> +	struct slb_shadow *p = get_slb_shadow();
> +	enum slb_index index;

or can we get here at some point when shadow slb is not populated?

Thanks

Michal

> +
> +	 /* No isync needed because realmode. */
> +	for (index = 0; index < SLB_NUM_BOLTED; index++) {
> +		asm volatile("slbmte  %0,%1" :
> +		     : "r" (be64_to_cpu(p->save_area[index].vsid)),
> +		       "r" (be64_to_cpu(p->save_area[index].esid)));
> +	}
> +}
> +
> +/*
> + * Insert bolted entries into an empty SLB.
> + * This is not the same as rebolt because the bolted segments
> + * (e.g., kstack) are not changed (rebolted).
> + */
> +void slb_restore_bolted_realmode(void)
> +{
> +	__slb_restore_bolted_realmode();
> +	get_paca()->slb_cache_ptr = 0;
> +}
> +
> +/*
> + * This flushes all SLB entries including 0, so it must be realmode.
> + */
> +void slb_flush_all_realmode(void)
> +{
> +	/*
> +	 * This flushes all SLB entries including 0, so it must be
> realmode.
> +	 */
> +	asm volatile("slbmte %0,%0; slbia" : : "r" (0));
> +}
> +
>  static void __slb_flush_and_rebolt(void)
>  {
>  	/* If you change this make sure you change SLB_NUM_BOLTED
