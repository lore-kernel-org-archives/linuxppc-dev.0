Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwfvZ6wXzzF1Z9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2018 01:55:06 +1100 (AEDT)
Subject: Re: [PATCH 08/10] powerpc/mm/slice: Use const pointers to cached
 slice masks where possible
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
References: <20180306132507.10649-1-npiggin@gmail.com>
 <20180306132507.10649-9-npiggin@gmail.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <248c0062-7710-bb96-6677-3c6d7bdc13ee@c-s.fr>
Date: Tue, 6 Mar 2018 15:55:04 +0100
MIME-Version: 1.0
In-Reply-To: <20180306132507.10649-9-npiggin@gmail.com>
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
> The slice_mask cache was a basic conversion which copied the slice
> mask into caller's structures, because that's how the original code
> worked. In most cases the pointer can be used directly instead, saving
> a copy and an on-stack structure.
> 
> On POWER8, this increases vfork+exec+exit performance by 0.3%
> and reduces time to mmap+munmap a 64kB page by 2%.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   arch/powerpc/mm/slice.c | 77 +++++++++++++++++++++----------------------------
>   1 file changed, 33 insertions(+), 44 deletions(-)
> 
> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
> index 46daa1d1794f..086c31b8b982 100644
> --- a/arch/powerpc/mm/slice.c
> +++ b/arch/powerpc/mm/slice.c
> @@ -472,10 +472,10 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>   				      unsigned long flags, unsigned int psize,
>   				      int topdown)
>   {
> -	struct slice_mask mask;
>   	struct slice_mask good_mask;
>   	struct slice_mask potential_mask;
> -	struct slice_mask compat_mask;
> +	const struct slice_mask *maskp;
> +	const struct slice_mask *compat_maskp = NULL;
>   	int fixed = (flags & MAP_FIXED);
>   	int pshift = max_t(int, mmu_psize_defs[psize].shift, PAGE_SHIFT);
>   	unsigned long page_size = 1UL << pshift;
> @@ -509,22 +509,6 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>   		on_each_cpu(slice_flush_segments, mm, 1);
>   	}
>   
> -	/*
> -	 * init different masks
> -	 */
> -	mask.low_slices = 0;
> -
> -	/* silence stupid warning */;
> -	potential_mask.low_slices = 0;
> -
> -	compat_mask.low_slices = 0;
> -
> -	if (SLICE_NUM_HIGH) {
> -		bitmap_zero(mask.high_slices, SLICE_NUM_HIGH);
> -		bitmap_zero(potential_mask.high_slices, SLICE_NUM_HIGH);
> -		bitmap_zero(compat_mask.high_slices, SLICE_NUM_HIGH);
> -	}
> -
>   	/* Sanity checks */
>   	BUG_ON(mm->task_size == 0);
>   	BUG_ON(mm->context.slb_addr_limit == 0);
> @@ -547,8 +531,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>   	/* First make up a "good" mask of slices that have the right size
>   	 * already
>   	 */
> -	good_mask = *slice_mask_for_size(mm, psize);
> -	slice_print_mask(" good_mask", &good_mask);
> +	maskp = slice_mask_for_size(mm, psize);
>   
>   	/*
>   	 * Here "good" means slices that are already the right page size,
> @@ -572,11 +555,19 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>   #ifdef CONFIG_PPC_64K_PAGES
>   	/* If we support combo pages, we can allow 64k pages in 4k slices */
>   	if (psize == MMU_PAGE_64K) {
> -		compat_mask = *slice_mask_for_size(mm, MMU_PAGE_4K);
> +		compat_maskp = slice_mask_for_size(mm, MMU_PAGE_4K);
>   		if (fixed)
> -			slice_or_mask(&good_mask, &good_mask, &compat_mask);
> -	}
> +			slice_or_mask(&good_mask, maskp, compat_maskp);
> +		else
> +			slice_copy_mask(&good_mask, maskp);
> +	} else
>   #endif
> +	{
> +		slice_copy_mask(&good_mask, maskp);
> +	}

You could get something nicer by removing that #ifdef and doing instead:

	if (IS_ENABLED(CONFIG_PPC_64K_PAGES) && psize == MMU_PAGE_64K) {
		...
	} else {
		slice_copy_mask(&good_mask, maskp);
	}

> +	slice_print_mask(" good_mask", &good_mask);
> +	if (compat_maskp)
> +		slice_print_mask(" compat_mask", compat_maskp);
>   
>   	/* First check hint if it's valid or if we have MAP_FIXED */
>   	if (addr || fixed) {
> @@ -643,7 +634,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>   #ifdef CONFIG_PPC_64K_PAGES
>   	if (addr == -ENOMEM && psize == MMU_PAGE_64K) {
>   		/* retry the search with 4k-page slices included */
> -		slice_or_mask(&potential_mask, &potential_mask, &compat_mask);
> +		slice_or_mask(&potential_mask, &potential_mask, compat_maskp);
>   		addr = slice_find_area(mm, len, &potential_mask,
>   				       psize, topdown, high_limit);
>   	}
> @@ -652,17 +643,18 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>   	if (addr == -ENOMEM)
>   		return -ENOMEM;
>   
> -	slice_range_to_mask(addr, len, &mask);
> +	slice_range_to_mask(addr, len, &potential_mask);
>   	slice_dbg(" found potential area at 0x%lx\n", addr);
> -	slice_print_mask(" mask", &mask);
> +	slice_print_mask(" mask", &potential_mask);
>   
>    convert:
> -	slice_andnot_mask(&mask, &mask, &good_mask);
> -	slice_andnot_mask(&mask, &mask, &compat_mask);
> -	if (mask.low_slices ||
> -	    (SLICE_NUM_HIGH &&
> -	     !bitmap_empty(mask.high_slices, SLICE_NUM_HIGH))) {
> -		slice_convert(mm, &mask, psize);
> +	slice_andnot_mask(&potential_mask, &potential_mask, &good_mask);
> +	if (compat_maskp && !fixed)
> +		slice_andnot_mask(&potential_mask, &potential_mask, compat_maskp);
> +	if (potential_mask.low_slices ||
> +		(SLICE_NUM_HIGH &&
> +		 !bitmap_empty(potential_mask.high_slices, SLICE_NUM_HIGH))) {
> +		slice_convert(mm, &potential_mask, psize);
>   		if (psize > MMU_PAGE_BASE)
>   			on_each_cpu(slice_flush_segments, mm, 1);
>   	}
> @@ -786,28 +778,25 @@ void slice_set_range_psize(struct mm_struct *mm, unsigned long start,
>   int is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
>   			   unsigned long len)
>   {
> -	struct slice_mask available;
> +	const struct slice_mask *maskp;
>   	unsigned int psize = mm->context.user_psize;
>   
>   	if (radix_enabled())
>   		return 0;
>   
> -	available = *slice_mask_for_size(mm, psize);
> +	maskp = slice_mask_for_size(mm, psize);
>   #ifdef CONFIG_PPC_64K_PAGES
>   	/* We need to account for 4k slices too */
>   	if (psize == MMU_PAGE_64K) {
> -		struct slice_mask compat_mask;
> -		compat_mask = *slice_mask_for_size(mm, MMU_PAGE_4K);
> -		slice_or_mask(&available, &available, &compat_mask);
> +		const struct slice_mask *compat_maskp;
> +		struct slice_mask available;
> +
> +		compat_maskp = slice_mask_for_size(mm, MMU_PAGE_4K);
> +		slice_or_mask(&available, maskp, compat_maskp);
> +		return !slice_check_range_fits(mm, &available, addr, len);
>   	}
>   #endif
>   
> -#if 0 /* too verbose */
> -	slice_dbg("is_hugepage_only_range(mm=%p, addr=%lx, len=%lx)\n",
> -		 mm, addr, len);
> -	slice_print_mask(" mask", &mask);
> -	slice_print_mask(" available", &available);
> -#endif

That's cleanup, should be in a previous patch.

Christophe

> -	return !slice_check_range_fits(mm, &available, addr, len);
> +	return !slice_check_range_fits(mm, maskp, addr, len);
>   }
>   #endif
> 
