Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42DG0D4N4kzDr4C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Sep 2018 16:08:44 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8H64SjF020059
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Sep 2018 02:08:42 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mj5r9j27m-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Sep 2018 02:08:41 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Mon, 17 Sep 2018 07:08:40 +0100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 05/12] powerpc/64s/hash: Use POWER6 SLBIA IH=1 variant in
 switch_slb
In-Reply-To: <20180914153056.3644-6-npiggin@gmail.com>
References: <20180914153056.3644-1-npiggin@gmail.com>
 <20180914153056.3644-6-npiggin@gmail.com>
Date: Mon, 17 Sep 2018 11:38:35 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <874leoirks.fsf@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> The SLBIA IH=1 hint will remove all non-zero SLBEs, but only
> invalidate ERAT entries associated with a class value of 1, for
> processors that support the hint (e.g., POWER6 and newer), which
> Linux assigns to user addresses.
>
> This prevents kernel ERAT entries from being invalidated when
> context switchig (if the thread faulted in more than 8 user SLBEs).


how about renaming stuff to indicate kernel ERAT entries are kept?
something like slb_flush_and_rebolt_user()? 

>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/mm/slb.c | 38 +++++++++++++++++++++++---------------
>  1 file changed, 23 insertions(+), 15 deletions(-)
>
> diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
> index a5e58f11d676..03fa1c663ccf 100644
> --- a/arch/powerpc/mm/slb.c
> +++ b/arch/powerpc/mm/slb.c
> @@ -128,13 +128,21 @@ void slb_flush_all_realmode(void)
>  	asm volatile("slbmte %0,%0; slbia" : : "r" (0));
>  }
>  
> -static void __slb_flush_and_rebolt(void)
> +void slb_flush_and_rebolt(void)
>  {
>  	/* If you change this make sure you change SLB_NUM_BOLTED
>  	 * and PR KVM appropriately too. */
>  	unsigned long linear_llp, lflags;
>  	unsigned long ksp_esid_data, ksp_vsid_data;
>  
> +	WARN_ON(!irqs_disabled());
> +
> +	/*
> +	 * We can't take a PMU exception in the following code, so hard
> +	 * disable interrupts.
> +	 */
> +	hard_irq_disable();
> +
>  	linear_llp = mmu_psize_defs[mmu_linear_psize].sllp;
>  	lflags = SLB_VSID_KERNEL | linear_llp;
>  
> @@ -160,20 +168,7 @@ static void __slb_flush_and_rebolt(void)
>  		     :: "r"(ksp_vsid_data),
>  		        "r"(ksp_esid_data)
>  		     : "memory");
> -}
>  
> -void slb_flush_and_rebolt(void)
> -{
> -
> -	WARN_ON(!irqs_disabled());
> -
> -	/*
> -	 * We can't take a PMU exception in the following code, so hard
> -	 * disable interrupts.
> -	 */
> -	hard_irq_disable();
> -
> -	__slb_flush_and_rebolt();
>  	get_paca()->slb_cache_ptr = 0;
>  }
>  
> @@ -248,7 +243,20 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
>  
>  		asm volatile("isync" : : : "memory");
>  	} else {
> -		__slb_flush_and_rebolt();
> +		struct slb_shadow *p = get_slb_shadow();
> +		unsigned long ksp_esid_data =
> +			be64_to_cpu(p->save_area[KSTACK_INDEX].esid);
> +		unsigned long ksp_vsid_data =
> +			be64_to_cpu(p->save_area[KSTACK_INDEX].vsid);
> +
> +		asm volatile("isync\n"
> +			     PPC_SLBIA(1) "\n"
> +			     "slbmte	%0,%1\n"
> +			     "isync"
> +			     :: "r"(ksp_vsid_data),
> +				"r"(ksp_esid_data));
> +
> +		asm volatile("isync" : : : "memory");
>  	}
>  
>  	get_paca()->slb_cache_ptr = 0;
> -- 
> 2.18.0
