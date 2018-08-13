Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41pjPp56mJzDr5t
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2018 14:27:42 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7D4OE3K098682
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2018 00:27:40 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ktqcm0ayy-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2018 00:27:40 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Mon, 13 Aug 2018 05:27:37 +0100
Subject: Re: [PATCH v2 1/2] powerpc/64s: move machine check SLB flushing to
 mm/slb.c
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
References: <20180810064249.13724-1-npiggin@gmail.com>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Mon, 13 Aug 2018 09:57:33 +0530
MIME-Version: 1.0
In-Reply-To: <20180810064249.13724-1-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <a216c87b-99ac-3a64-1c92-9e90ac28c8b6@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/10/2018 12:12 PM, Nicholas Piggin wrote:
> The machine check code that flushes and restores bolted segments in
> real mode belongs in mm/slb.c. This will also be used by pseries
> machine check and idle code in future changes.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> 
> Since v1:
> - Restore the test for slb_shadow (mpe)
> ---
>  arch/powerpc/include/asm/book3s/64/mmu-hash.h |  3 ++
>  arch/powerpc/kernel/mce_power.c               | 26 +++++--------
>  arch/powerpc/mm/slb.c                         | 39 +++++++++++++++++++
>  3 files changed, 51 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> index 2f74bdc805e0..d4e398185b3a 100644
> --- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> @@ -497,6 +497,9 @@ extern void hpte_init_native(void);
> 
>  extern void slb_initialize(void);
>  extern void slb_flush_and_rebolt(void);
> +extern void slb_flush_all_realmode(void);
> +extern void __slb_restore_bolted_realmode(void);
> +extern void slb_restore_bolted_realmode(void);
> 
>  extern void slb_vmalloc_update(void);
>  extern void slb_set_size(u16 size);
> diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
> index d6756af6ec78..3497c8329c1d 100644
> --- a/arch/powerpc/kernel/mce_power.c
> +++ b/arch/powerpc/kernel/mce_power.c
> @@ -62,11 +62,8 @@ static unsigned long addr_to_pfn(struct pt_regs *regs, unsigned long addr)
>  #ifdef CONFIG_PPC_BOOK3S_64
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
> @@ -76,22 +73,17 @@ static void flush_and_reload_slb(void)
>  	if (get_paca()->kvm_hstate.in_guest)
>  		return;
>  #endif
> -
> -	/* For host kernel, reload the SLBs from shadow SLB buffer. */
> -	slb = get_slb_shadow();
> -	if (!slb)
> +	if (early_radix_enabled())
>  		return;

Would we ever get MCE for SLB errors when radix is enabled ?

> 
> -	n = min_t(u32, be32_to_cpu(slb->persistent), SLB_MIN_SIZE);
> -
> -	/* Load up the SLB entries from shadow SLB */
> -	for (i = 0; i < n; i++) {
> -		unsigned long rb = be64_to_cpu(slb->save_area[i].esid);
> -		unsigned long rs = be64_to_cpu(slb->save_area[i].vsid);
> +	/*
> +	 * This probably shouldn't happen, but it may be possible it's
> +	 * called in early boot before SLB shadows are allocated.
> +	 */
> +	if (!get_slb_shadow())
> +		return;

Any reason you added above check here instead on mm/slb.c ? Should we
move above check inside slb_restore_bolted_realmode() ? I guess mm/slb.c
is right place for this check. This will also help pseries machine check
to avoid calling this extra check explicitly.

Thanks,
-Mahesh.

> 
> -		rb = (rb & ~0xFFFul) | i;
> -		asm volatile("slbmte %0,%1" : : "r" (rs), "r" (rb));
> -	}
> +	slb_restore_bolted_realmode();
>  }
>  #endif
> 
> diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
> index cb796724a6fc..0b095fa54049 100644
> --- a/arch/powerpc/mm/slb.c
> +++ b/arch/powerpc/mm/slb.c
> @@ -90,6 +90,45 @@ static inline void create_shadowed_slbe(unsigned long ea, int ssize,
>  		     : "memory" );
>  }
> 
> +/*
> + * Insert bolted entries into SLB (which may not be empty, so don't clear
> + * slb_cache_ptr).
> + */
> +void __slb_restore_bolted_realmode(void)
> +{
> +	struct slb_shadow *p = get_slb_shadow();
> +	enum slb_index index;
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
> + * Insert the bolted entries into an empty SLB.
> + * This is not the same as rebolt because the bolted segments are not
> + * changed, just loaded from the shadow area.
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
> +	 * This flushes all SLB entries including 0, so it must be realmode.
> +	 */
> +	asm volatile("slbmte %0,%0; slbia" : : "r" (0));
> +}
> +
>  static void __slb_flush_and_rebolt(void)
>  {
>  	/* If you change this make sure you change SLB_NUM_BOLTED
> 
