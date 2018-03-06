Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwgHl3sk2zDrS2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2018 02:12:35 +1100 (AEDT)
Subject: Re: [PATCH 10/10] powerpc/mm/slice: remove radix calls to the slice
 code
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
References: <20180306132507.10649-1-npiggin@gmail.com>
 <20180306132507.10649-11-npiggin@gmail.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <01d94f39-91fc-53c4-79ad-b43b3234c2ea@c-s.fr>
Date: Tue, 6 Mar 2018 16:12:34 +0100
MIME-Version: 1.0
In-Reply-To: <20180306132507.10649-11-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 06/03/2018 à 14:25, Nicholas Piggin a écrit :
> This is a tidy up which removes radix MMU calls into the slice
> code.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   arch/powerpc/include/asm/hugetlb.h |  9 ++++++---
>   arch/powerpc/mm/hugetlbpage.c      |  5 +++--
>   arch/powerpc/mm/slice.c            | 17 ++++-------------
>   3 files changed, 13 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
> index 1a4847f67ea8..59885d444695 100644
> --- a/arch/powerpc/include/asm/hugetlb.h
> +++ b/arch/powerpc/include/asm/hugetlb.h
> @@ -90,16 +90,19 @@ pte_t *huge_pte_offset_and_shift(struct mm_struct *mm,
>   void flush_dcache_icache_hugepage(struct page *page);
>   
>   #if defined(CONFIG_PPC_MM_SLICES)
> -int is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
> +int slice_is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
>   			   unsigned long len);
> -#else
> +#endif
>   static inline int is_hugepage_only_range(struct mm_struct *mm,
>   					 unsigned long addr,
>   					 unsigned long len)
>   {
> +#if defined(CONFIG_PPC_MM_SLICES)
> +	if (!radix_enabled())
> +		return slice_is_hugepage_only_range(mm, addr, len);
> +#endif
>   	return 0;

Might be easier to understand as

	if (!IS_ENABLED(CONFIG_PPC_MM_SLICES) || radix_enabled())
		return 0;
	return slice_is_hugepage_only_range(mm, addr, len);


>   }
> -#endif
>   
>   void book3e_hugetlb_preload(struct vm_area_struct *vma, unsigned long ea,
>   			    pte_t pte);
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index 590be3fa0ce2..b29d40889d1c 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -565,10 +565,11 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>   unsigned long vma_mmu_pagesize(struct vm_area_struct *vma)
>   {
>   #ifdef CONFIG_PPC_MM_SLICES
> -	unsigned int psize = get_slice_psize(vma->vm_mm, vma->vm_start);
>   	/* With radix we don't use slice, so derive it from vma*/
> -	if (!radix_enabled())
> +	if (!radix_enabled()) {
> +		unsigned int psize = get_slice_psize(vma->vm_mm, vma->vm_start);

Insert a blank line here.

Christophe

>   		return 1UL << mmu_psize_to_shift(psize);
> +	}
>   #endif
>   	if (!is_vm_hugetlb_page(vma))
>   		return PAGE_SIZE;
> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
> index 507d17e2cfcd..15a857772617 100644
> --- a/arch/powerpc/mm/slice.c
> +++ b/arch/powerpc/mm/slice.c
> @@ -697,16 +697,8 @@ unsigned int get_slice_psize(struct mm_struct *mm, unsigned long addr)
>   	unsigned char *psizes;
>   	int index, mask_index;
>   
> -	/*
> -	 * Radix doesn't use slice, but can get enabled along with MMU_SLICE
> -	 */
> -	if (radix_enabled()) {
> -#ifdef CONFIG_PPC_64K_PAGES
> -		return MMU_PAGE_64K;
> -#else
> -		return MMU_PAGE_4K;
> -#endif
> -	}
> +	VM_BUG_ON(radix_enabled());
> +
>   	if (addr < SLICE_LOW_TOP) {
>   		psizes = mm->context.low_slices_psize;
>   		index = GET_LOW_SLICE_INDEX(addr);
> @@ -788,14 +780,13 @@ void slice_set_range_psize(struct mm_struct *mm, unsigned long start,
>    * for now as we only use slices with hugetlbfs enabled. This should
>    * be fixed as the generic code gets fixed.
>    */
> -int is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
> +int slice_is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
>   			   unsigned long len)
>   {
>   	const struct slice_mask *maskp;
>   	unsigned int psize = mm->context.user_psize;
>   
> -	if (radix_enabled())
> -		return 0;
> +	VM_BUG_ON(radix_enabled());
>   
>   	maskp = slice_mask_for_size(mm, psize);
>   #ifdef CONFIG_PPC_64K_PAGES
> 
