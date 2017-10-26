Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yMyQp5xv6zDrCn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Oct 2017 17:53:54 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9Q6mduQ141754
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Oct 2017 02:53:52 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2du8b9xpym-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Oct 2017 02:53:51 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 26 Oct 2017 07:53:49 +0100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 3/3] powerpc/64s/radix: Fix process table entry cache
 invalidation
In-Reply-To: <20171024130654.1223-4-npiggin@gmail.com>
References: <20171024130654.1223-1-npiggin@gmail.com>
 <20171024130654.1223-4-npiggin@gmail.com>
Date: Thu, 26 Oct 2017 12:23:45 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <878tfy2ydi.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> According to the architecture, the process table entry cache must be
> flushed with tlbie RIC=2.
>
> Currently the process table entry is set to invalid right before the
> PID is returned to the allocator, with no invalidation. This works on
> existing implementations that are known to not cache the process table
> entry for any except the current PIDR.
>
> It is architecturally correct and cleaner to invalidate with RIC=2
> after clearing the process table entry and before the PID is returned
> to the allocator. This can be done in arch_exit_mmap that runs before
> the final flush, and to ensure the final flush (fullmm) is always a
> RIC=2 variant.
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/include/asm/mmu_context.h |  4 ++++
>  arch/powerpc/mm/mmu_context_book3s64.c | 25 ++++++++++++++++++++-----
>  arch/powerpc/mm/tlb-radix.c            |  6 +++++-
>  3 files changed, 29 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
> index a0d7145d6cd2..20eae6f76247 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -164,9 +164,13 @@ static inline void arch_dup_mmap(struct mm_struct *oldmm,
>  {
>  }
>
> +#ifndef CONFIG_PPC_BOOK3S_64
>  static inline void arch_exit_mmap(struct mm_struct *mm)
>  {
>  }
> +#else
> +extern void arch_exit_mmap(struct mm_struct *mm);
> +#endif
>
>  static inline void arch_unmap(struct mm_struct *mm,
>  			      struct vm_area_struct *vma,
> diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
> index 05e15386d4cb..6d724dab27c2 100644
> --- a/arch/powerpc/mm/mmu_context_book3s64.c
> +++ b/arch/powerpc/mm/mmu_context_book3s64.c
> @@ -216,19 +216,34 @@ void destroy_context(struct mm_struct *mm)
>  #ifdef CONFIG_SPAPR_TCE_IOMMU
>  	WARN_ON_ONCE(!list_empty(&mm->context.iommu_group_mem_list));
>  #endif
> +	if (radix_enabled())
> +		WARN_ON(process_tb[mm->context.id].prtb0 != 0);
> +	else
> +		subpage_prot_free(mm);
> +	destroy_pagetable_page(mm);
> +	__destroy_context(mm->context.id);
> +	mm->context.id = MMU_NO_CONTEXT;
> +}
> +
> +void arch_exit_mmap(struct mm_struct *mm)
> +{
>  	if (radix_enabled()) {
>  		/*
>  		 * Radix doesn't have a valid bit in the process table
>  		 * entries. However we know that at least P9 implementation
>  		 * will avoid caching an entry with an invalid RTS field,
>  		 * and 0 is invalid. So this will do.
> +		 *
> +		 * This runs before the "fullmm" tlb flush in exit_mmap,
> +		 * which does a RIC=2 tlbie to clear the process table
> +		 * entry. See the "fullmm" comments in tlb-radix.c.
> +		 *
> +		 * No barrier required here after the store because
> +		 * this process will do the invalidate, which starts with
> +		 * ptesync.
>  		 */
>  		process_tb[mm->context.id].prtb0 = 0;
> -	} else
> -		subpage_prot_free(mm);
> -	destroy_pagetable_page(mm);
> -	__destroy_context(mm->context.id);
> -	mm->context.id = MMU_NO_CONTEXT;
> +	}
>  }
>
>  #ifdef CONFIG_PPC_RADIX_MMU
> diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
> index 18170dc264aa..0c8464653aa3 100644
> --- a/arch/powerpc/mm/tlb-radix.c
> +++ b/arch/powerpc/mm/tlb-radix.c
> @@ -297,10 +297,14 @@ void radix__tlb_flush(struct mmu_gather *tlb)
>  	psize = radix_get_mmu_psize(page_size);
>  	/*
>  	 * if page size is not something we understand, do a full mm flush
> +	 *
> +	 * A "fullmm" flush must always do a flush_all_mm (RIC=2) flush
> +	 * that flushes the process table entry cache upon process teardown.
> +	 * See the comment for radix in arch_exit_mmap().
>  	 */
>  	if (psize != -1 && !tlb->fullmm && !tlb->need_flush_all)
>  		radix__flush_tlb_range_psize(mm, tlb->start, tlb->end, psize);
> -	else if (tlb->need_flush_all) {
> +	else if (tlb->fullmm || tlb->need_flush_all) {
>  		tlb->need_flush_all = 0;
>  		radix__flush_all_mm(mm);
>  	} else
> -- 
> 2.13.3
