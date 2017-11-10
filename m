Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yYFVv4WSqzDq78
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Nov 2017 20:44:39 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/64s/slice: Use addr limit when computing slice
 mask
In-Reply-To: <20171110045507.30147-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20171110045507.30147-1-aneesh.kumar@linux.vnet.ibm.com>
Date: Fri, 10 Nov 2017 20:44:38 +1100
Message-ID: <87zi7uo4c9.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> While computing slice mask for the free area we need make sure we only search
> in the addr limit applicable for this mmap. We update the slb_addr_limit
> after we request for a mmap above 128TB. But the following mmap request
> with hint addr below 128TB should still limit its search to below 128TB. ie.
> we should not use slb_addr_limit to compute slice mask in this case. Instead,
> we should derive high addr limit based on the mmap hint addr value.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/slice.c | 34 ++++++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 12 deletions(-)

How does this relate to the fixes Nick has sent?

cheers

> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
> index 564fff06f5c1..23ec2c5e3b78 100644
> --- a/arch/powerpc/mm/slice.c
> +++ b/arch/powerpc/mm/slice.c
> @@ -122,7 +122,8 @@ static int slice_high_has_vma(struct mm_struct *mm, unsigned long slice)
>  	return !slice_area_is_free(mm, start, end - start);
>  }
>  
> -static void slice_mask_for_free(struct mm_struct *mm, struct slice_mask *ret)
> +static void slice_mask_for_free(struct mm_struct *mm, struct slice_mask *ret,
> +				unsigned long high_limit)
>  {
>  	unsigned long i;
>  
> @@ -133,15 +134,16 @@ static void slice_mask_for_free(struct mm_struct *mm, struct slice_mask *ret)
>  		if (!slice_low_has_vma(mm, i))
>  			ret->low_slices |= 1u << i;
>  
> -	if (mm->context.slb_addr_limit <= SLICE_LOW_TOP)
> +	if (high_limit <= SLICE_LOW_TOP)
>  		return;
>  
> -	for (i = 0; i < GET_HIGH_SLICE_INDEX(mm->context.slb_addr_limit); i++)
> +	for (i = 0; i < GET_HIGH_SLICE_INDEX(high_limit); i++)
>  		if (!slice_high_has_vma(mm, i))
>  			__set_bit(i, ret->high_slices);
>  }
>  
> -static void slice_mask_for_size(struct mm_struct *mm, int psize, struct slice_mask *ret)
> +static void slice_mask_for_size(struct mm_struct *mm, int psize, struct slice_mask *ret,
> +				unsigned long high_limit)
>  {
>  	unsigned char *hpsizes;
>  	int index, mask_index;
> @@ -156,8 +158,11 @@ static void slice_mask_for_size(struct mm_struct *mm, int psize, struct slice_ma
>  		if (((lpsizes >> (i * 4)) & 0xf) == psize)
>  			ret->low_slices |= 1u << i;
>  
> +	if (high_limit <= SLICE_LOW_TOP)
> +		return;
> +
>  	hpsizes = mm->context.high_slices_psize;
> -	for (i = 0; i < GET_HIGH_SLICE_INDEX(mm->context.slb_addr_limit); i++) {
> +	for (i = 0; i < GET_HIGH_SLICE_INDEX(high_limit); i++) {
>  		mask_index = i & 0x1;
>  		index = i >> 1;
>  		if (((hpsizes[index] >> (mask_index * 4)) & 0xf) == psize)
> @@ -169,6 +174,10 @@ static int slice_check_fit(struct mm_struct *mm,
>  			   struct slice_mask mask, struct slice_mask available)
>  {
>  	DECLARE_BITMAP(result, SLICE_NUM_HIGH);
> +	/*
> +	 * Make sure we just do bit compare only to the max
> +	 * addr limit and not the full bit map size.
> +	 */
>  	unsigned long slice_count = GET_HIGH_SLICE_INDEX(mm->context.slb_addr_limit);
>  
>  	bitmap_and(result, mask.high_slices,
> @@ -472,7 +481,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>  	/* First make up a "good" mask of slices that have the right size
>  	 * already
>  	 */
> -	slice_mask_for_size(mm, psize, &good_mask);
> +	slice_mask_for_size(mm, psize, &good_mask, high_limit);
>  	slice_print_mask(" good_mask", good_mask);
>  
>  	/*
> @@ -497,7 +506,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>  #ifdef CONFIG_PPC_64K_PAGES
>  	/* If we support combo pages, we can allow 64k pages in 4k slices */
>  	if (psize == MMU_PAGE_64K) {
> -		slice_mask_for_size(mm, MMU_PAGE_4K, &compat_mask);
> +		slice_mask_for_size(mm, MMU_PAGE_4K, &compat_mask, high_limit);
>  		if (fixed)
>  			slice_or_mask(&good_mask, &compat_mask);
>  	}
> @@ -530,11 +539,11 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>  			return newaddr;
>  		}
>  	}
> -
> -	/* We don't fit in the good mask, check what other slices are
> +	/*
> +	 * We don't fit in the good mask, check what other slices are
>  	 * empty and thus can be converted
>  	 */
> -	slice_mask_for_free(mm, &potential_mask);
> +	slice_mask_for_free(mm, &potential_mask, high_limit);
>  	slice_or_mask(&potential_mask, &good_mask);
>  	slice_print_mask(" potential", potential_mask);
>  
> @@ -744,17 +753,18 @@ int is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
>  {
>  	struct slice_mask mask, available;
>  	unsigned int psize = mm->context.user_psize;
> +	unsigned long high_limit = mm->context.slb_addr_limit;
>  
>  	if (radix_enabled())
>  		return 0;
>  
>  	slice_range_to_mask(addr, len, &mask);
> -	slice_mask_for_size(mm, psize, &available);
> +	slice_mask_for_size(mm, psize, &available, high_limit);
>  #ifdef CONFIG_PPC_64K_PAGES
>  	/* We need to account for 4k slices too */
>  	if (psize == MMU_PAGE_64K) {
>  		struct slice_mask compat_mask;
> -		slice_mask_for_size(mm, MMU_PAGE_4K, &compat_mask);
> +		slice_mask_for_size(mm, MMU_PAGE_4K, &compat_mask, high_limit);
>  		slice_or_mask(&available, &compat_mask);
>  	}
>  #endif
> -- 
> 2.13.6
