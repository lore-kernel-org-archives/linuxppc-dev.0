Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xP5JY693LzDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Aug 2017 22:07:09 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v74C4hgB016036
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Aug 2017 08:07:07 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c4pg1fqj3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Aug 2017 08:07:07 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Fri, 4 Aug 2017 13:07:03 +0100
Subject: Re: [PATCH 5/6] powerpc/mm: Optimize detection of thread local mm's
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com,
 Michael Ellerman <mpe@ellerman.id.au>
References: <20170724042803.25848-1-benh@kernel.crashing.org>
 <20170724042803.25848-5-benh@kernel.crashing.org>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Fri, 4 Aug 2017 14:06:58 +0200
MIME-Version: 1.0
In-Reply-To: <20170724042803.25848-5-benh@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <19e07887-2b70-324b-ae63-cb68a74f5fd8@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 24/07/2017 à 06:28, Benjamin Herrenschmidt a écrit :
> Instead of comparing the whole CPU mask every time, let's
> keep a counter of how many bits are set in the mask. Thus
> testing for a local mm only requires testing if that counter
> is 1 and the current CPU bit is set in the mask.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>   arch/powerpc/include/asm/book3s/64/mmu.h |  3 +++
>   arch/powerpc/include/asm/mmu_context.h   |  9 +++++++++
>   arch/powerpc/include/asm/tlb.h           | 11 ++++++++++-
>   arch/powerpc/mm/mmu_context_book3s64.c   |  2 ++
>   4 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
> index 1a220cdff923..c3b00e8ff791 100644
> --- a/arch/powerpc/include/asm/book3s/64/mmu.h
> +++ b/arch/powerpc/include/asm/book3s/64/mmu.h
> @@ -83,6 +83,9 @@ typedef struct {
>   	mm_context_id_t id;
>   	u16 user_psize;		/* page size index */
> 
> +	/* Number of bits in the mm_cpumask */
> +	atomic_t active_cpus;
> +
>   	/* NPU NMMU context */
>   	struct npu_context *npu_context;
> 
> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
> index ff1aeb2cd19f..cf8f50cd4030 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -96,6 +96,14 @@ static inline void switch_mm_pgdir(struct task_struct *tsk,
>   				   struct mm_struct *mm) { }
>   #endif
> 
> +#ifdef CONFIG_PPC_BOOK3S_64
> +static inline void inc_mm_active_cpus(struct mm_struct *mm)
> +{
> +	atomic_inc(&mm->context.active_cpus);
> +}
> +#else
> +static inline void inc_mm_active_cpus(struct mm_struct *mm) { }
> +#endif
> 
>   /*
>    * switch_mm is the entry point called from the architecture independent
> @@ -110,6 +118,7 @@ static inline void switch_mm_irqs_off(struct mm_struct *prev,
>   	/* Mark this context has been used on the new CPU */
>   	if (!cpumask_test_cpu(smp_processor_id(), mm_cpumask(next))) {
>   		cpumask_set_cpu(smp_processor_id(), mm_cpumask(next));
> +		inc_mm_active_cpus(next);
>   		smp_mb();
>   		new_on_cpu = true;
>   	}
> diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
> index 609557569f65..a7eabff27a0f 100644
> --- a/arch/powerpc/include/asm/tlb.h
> +++ b/arch/powerpc/include/asm/tlb.h
> @@ -69,13 +69,22 @@ static inline int mm_is_core_local(struct mm_struct *mm)
>   			      topology_sibling_cpumask(smp_processor_id()));
>   }
> 
> +#ifdef CONFIG_PPC_BOOK3S_64
> +static inline int mm_is_thread_local(struct mm_struct *mm)
> +{
> +	if (atomic_read(&mm->context.active_cpus) > 1)
> +		return false;
> +	return cpumask_test_cpu(smp_processor_id(), mm_cpumask(mm));
> +}
> +#else /* CONFIG_PPC_BOOK3S_64 */


While working on something related (mark memory context as needing 
global TLBI if used behind a NPU or PSL):
http://patchwork.ozlabs.org/patch/796775/

Michael raised the point that the store for the pte update cannot be 
reordered with the load which decides the scope of the TLBI, and had 
convinced me that a memory barrier was required.

Couldn't we have the same problem here, where the atomic read is 
reordered with the store of the invalid PTE?

Thanks,

   Fred


>   static inline int mm_is_thread_local(struct mm_struct *mm)
>   {
>   	return cpumask_equal(mm_cpumask(mm),
>   			      cpumask_of(smp_processor_id()));
>   }
> +#endif /* !CONFIG_PPC_BOOK3S_64 */
> 
> -#else
> +#else /* CONFIG_SMP */
>   static inline int mm_is_core_local(struct mm_struct *mm)
>   {
>   	return 1;
> diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
> index 8159f5219137..de17d3e714aa 100644
> --- a/arch/powerpc/mm/mmu_context_book3s64.c
> +++ b/arch/powerpc/mm/mmu_context_book3s64.c
> @@ -174,6 +174,8 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
>   #ifdef CONFIG_SPAPR_TCE_IOMMU
>   	mm_iommu_init(mm);
>   #endif
> +	atomic_set(&mm->context.active_cpus, 0);
> +
>   	return 0;
>   }
> 
