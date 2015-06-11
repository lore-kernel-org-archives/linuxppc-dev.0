Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2B0D31A0615
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 19:23:12 +1000 (AEST)
In-Reply-To: <1432887618-23666-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [V2] powerpc/mm: Limit the max memory we can support
Message-Id: <20150611092312.14C161402B2@ozlabs.org>
Date: Thu, 11 Jun 2015 19:23:12 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-29-05 at 08:20:18 UTC, "Aneesh Kumar K.V" wrote:
> We need to limit the max memory based on Linux page table format.
> Add checks to limit memory based on pte size. Also limit the memory
> based on MAX_PHSYSMEM_BITS.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
> Changes from V1:
> * Update commit message. 4K can handle 64TB
> * Also limit based on MAX_PHSYSMEM_BITS
> 
>  arch/powerpc/include/asm/mmu.h       |  8 ++++++++
>  arch/powerpc/include/asm/sparsemem.h |  2 --
>  arch/powerpc/kernel/prom.c           | 25 ++++++++++++++++++++++---
>  3 files changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
> index 3d5abfe6ba67..d44d49093c8d 100644
> --- a/arch/powerpc/include/asm/mmu.h
> +++ b/arch/powerpc/include/asm/mmu.h
> @@ -200,6 +200,14 @@ static inline void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
>  #  include <asm/mmu-8xx.h>
>  #endif
>  
> +#ifdef CONFIG_PHYS_64BIT
> +/*
> + * Max supported memory on 64bit system is 64TB.

Can you document in the comment where the limit comes from?

> + */
> +#define MAX_PHYSMEM_BITS        46
> +#else
> +#define MAX_PHYSMEM_BITS        32
> +#endif
>  
>  #endif /* __KERNEL__ */
>  #endif /* _ASM_POWERPC_MMU_H_ */
> diff --git a/arch/powerpc/include/asm/sparsemem.h b/arch/powerpc/include/asm/sparsemem.h
> index f6fc0ee813d7..fc3808378893 100644
> --- a/arch/powerpc/include/asm/sparsemem.h
> +++ b/arch/powerpc/include/asm/sparsemem.h
> @@ -11,8 +11,6 @@
>  #define SECTION_SIZE_BITS       24
>  
>  #define MAX_PHYSADDR_BITS       46
> -#define MAX_PHYSMEM_BITS        46

Is there now no link between those two?

>  #ifdef CONFIG_MEMORY_HOTPLUG
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 308c5e15676b..c09315b32ca7 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -698,9 +698,28 @@ void __init early_init_devtree(void *params)
>  #endif
>  		reserve_crashkernel();
>  	early_reserve_mem();
> -
> -	/* Ensure that total memory size is page-aligned. */
> -	limit = ALIGN(memory_limit ?: memblock_phys_mem_size(), PAGE_SIZE);
> +	/*
> +	 * if not specified limit the memory based on the pfn count that
> +	 * we can fit in pte_t. Also ensure that total memory size is
> +	 * page-aligned.

Shouldn't you do the logic below even if memory_limit is specified? Otherwise
someone can specify a really large memory_limit which will then overflow.

> +	 */
> +	if (!memory_limit) {
> +		int bit_count;
> +		phys_addr_t pte_mem_limit;
> +
> +		limit = memblock_phys_mem_size();
> +		if (limit >= (1ULL << MAX_PHYSMEM_BITS))
> +			limit = (1ULL << MAX_PHYSMEM_BITS) - 1;
> +
> +		BUILD_BUG_ON(sizeof(pte_basic_t) > 8);
> +		bit_count = (sizeof(pte_basic_t) * 8) - PTE_RPN_SHIFT + PAGE_SHIFT;
> +		pte_mem_limit = ~0ULL >> (64 - bit_count);

It's fairly obvious what you're doing here, but a bit of a comment wouldn't hurt.

> +		if (limit > pte_mem_limit)
> +			limit = pte_mem_limit;
> +	} else
> +		limit = memory_limit;
> +
> +	limit = ALIGN(limit, PAGE_SIZE);

cheers
