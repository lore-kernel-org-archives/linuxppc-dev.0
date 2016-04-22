Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x235.google.com (mail-pf0-x235.google.com
 [IPv6:2607:f8b0:400e:c00::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrlnt0DBPzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 16:19:29 +1000 (AEST)
Received: by mail-pf0-x235.google.com with SMTP id n1so38133368pfn.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 23:19:29 -0700 (PDT)
Subject: Re: [PATCH V2 36/68] powerpc/mm/radix: Add mmu context handling
 callback for radix
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-37-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <5719C26A.4020207@gmail.com>
Date: Fri, 22 Apr 2016 16:19:22 +1000
MIME-Version: 1.0
In-Reply-To: <1460182444-2468-37-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 09/04/16 16:13, Aneesh Kumar K.V wrote:
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/mmu_context.h |  4 ++++
>  arch/powerpc/mm/mmu_context_hash64.c   | 42 +++++++++++++++++++++++++++-------
>  2 files changed, 38 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
> index 0dd522ff4559..8f16a065d33d 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -37,10 +37,14 @@ extern void switch_slb(struct task_struct *tsk, struct mm_struct *mm);
>  extern void set_context(unsigned long id, pgd_t *pgd);
>  
>  #ifdef CONFIG_PPC_BOOK3S_64
> +extern void switch_radix_mmu_context(struct mm_struct *prev,
> +				     struct mm_struct *next);
>  static inline void switch_mmu_context(struct mm_struct *prev,
>  				      struct mm_struct *next,
>  				      struct task_struct *tsk)
>  {
> +	if (radix_enabled())
> +		return switch_radix_mmu_context(prev, next);
>  	return switch_slb(tsk, next);
>  }
>  
> diff --git a/arch/powerpc/mm/mmu_context_hash64.c b/arch/powerpc/mm/mmu_context_hash64.c
> index 4e4efbc2658e..08cc3182b744 100644
> --- a/arch/powerpc/mm/mmu_context_hash64.c
> +++ b/arch/powerpc/mm/mmu_context_hash64.c
> @@ -58,6 +58,17 @@ again:
>  	return index;
>  }
>  EXPORT_SYMBOL_GPL(__init_new_context);
> +static int rinit_new_context(struct mm_struct *mm, int index)
> +{
> +	unsigned long rts_field;
> +
> +	/*
> +	 * set the process table entry,
> +	 */
> +	rts_field = 3ull << PPC_BITLSHIFT(2);

rts_field1? The code needs to add some comments on what the size bits are as well. Do we set rts_field2?

> +	process_tb[index].prtb0 = cpu_to_be64(rts_field | __pa(mm->pgd) | R_PGD_INDEX_SIZE);
> +	return 0;
> +}
>  
>  int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
>  {
> @@ -67,13 +78,18 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
>  	if (index < 0)
>  		return index;
>  
> -	/* The old code would re-promote on fork, we don't do that
> -	 * when using slices as it could cause problem promoting slices
> -	 * that have been forced down to 4K
> -	 */
> -	if (slice_mm_new_context(mm))
> -		slice_set_user_psize(mm, mmu_virtual_psize);
> -	subpage_prot_init_new_context(mm);
> +	if (radix_enabled()) {
> +		rinit_new_context(mm, index);
> +	} else {
> +
> +		/* The old code would re-promote on fork, we don't do that
> +		 * when using slices as it could cause problem promoting slices
> +		 * that have been forced down to 4K
> +		 */
> +		if (slice_mm_new_context(mm))
> +			slice_set_user_psize(mm, mmu_virtual_psize);
> +		subpage_prot_init_new_context(mm);
> +	}
>  	mm->context.id = index;
>  #ifdef CONFIG_PPC_ICSWX
>  	mm->context.cop_lockp = kmalloc(sizeof(spinlock_t), GFP_KERNEL);
> @@ -145,8 +161,18 @@ void destroy_context(struct mm_struct *mm)
>  	mm->context.cop_lockp = NULL;
>  #endif /* CONFIG_PPC_ICSWX */
>  
> +	if (radix_enabled())
> +		process_tb[mm->context.id].prtb1 = 0;
> +	else
> +		subpage_prot_free(mm);
>  	destroy_pagetable_page(mm);
>  	__destroy_context(mm->context.id);
> -	subpage_prot_free(mm);
>  	mm->context.id = MMU_NO_CONTEXT;

Got to be careful w.r.t. setting it to 0

>  }
> +
> +void switch_radix_mmu_context(struct mm_struct *prev, struct mm_struct *next)
> +{
> +	mtspr(SPRN_PID, next->context.id);

Can we have next->context.id = 0, OS? Any additional checks?

> +	asm volatile("isync": : :"memory");
> +

Why do we need the prev again?

> +}
> 
