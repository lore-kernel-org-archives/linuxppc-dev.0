Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwfgg4rLdzF1W5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2018 01:44:47 +1100 (AEDT)
Subject: Re: [PATCH 07/10] powerpc/mm/slice: Switch to 3-operand slice bitops
 helpers
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
References: <20180306132507.10649-1-npiggin@gmail.com>
 <20180306132507.10649-8-npiggin@gmail.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <49fb018e-50b2-a37c-e329-19b5d4f87942@c-s.fr>
Date: Tue, 6 Mar 2018 15:44:46 +0100
MIME-Version: 1.0
In-Reply-To: <20180306132507.10649-8-npiggin@gmail.com>
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
> This converts the slice_mask bit operation helpers to be the usual
> 3-operand kind, which is clearer to work with.

What's the real benefit of doing that ?

It is helps for a subsequent patch, say it.
Otherwise, I really can't see the point.

> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   arch/powerpc/mm/slice.c | 38 +++++++++++++++++++++++---------------
>   1 file changed, 23 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
> index 3841fca75006..46daa1d1794f 100644
> --- a/arch/powerpc/mm/slice.c
> +++ b/arch/powerpc/mm/slice.c
> @@ -433,25 +433,33 @@ static unsigned long slice_find_area(struct mm_struct *mm, unsigned long len,
>   		return slice_find_area_bottomup(mm, len, mask, psize, high_limit);
>   }
>   
> -static inline void slice_or_mask(struct slice_mask *dst,
> +static inline void slice_copy_mask(struct slice_mask *dst,
>   					const struct slice_mask *src)

This new function is not used, the compiler while probably not be happy.

Christophe

>   {
> -	dst->low_slices |= src->low_slices;
> +	dst->low_slices = src->low_slices;
>   	if (!SLICE_NUM_HIGH)
>   		return;
> -	bitmap_or(dst->high_slices, dst->high_slices, src->high_slices,
> -		  SLICE_NUM_HIGH);
> +	bitmap_copy(dst->high_slices, src->high_slices, SLICE_NUM_HIGH);
>   }
>   
> -static inline void slice_andnot_mask(struct slice_mask *dst,
> -					const struct slice_mask *src)
> +static inline void slice_or_mask(struct slice_mask *dst,
> +					const struct slice_mask *src1,
> +					const struct slice_mask *src2)
>   {
> -	dst->low_slices &= ~src->low_slices;
> +	dst->low_slices = src1->low_slices | src2->low_slices;
> +	if (!SLICE_NUM_HIGH)
> +		return;
> +	bitmap_or(dst->high_slices, src1->high_slices, src2->high_slices, SLICE_NUM_HIGH);
> +}
>   
> +static inline void slice_andnot_mask(struct slice_mask *dst,
> +					const struct slice_mask *src1,
> +					const struct slice_mask *src2)
> +{
> +	dst->low_slices = src1->low_slices & ~src2->low_slices;
>   	if (!SLICE_NUM_HIGH)
>   		return;
> -	bitmap_andnot(dst->high_slices, dst->high_slices, src->high_slices,
> -		      SLICE_NUM_HIGH);
> +	bitmap_andnot(dst->high_slices, src1->high_slices, src2->high_slices, SLICE_NUM_HIGH);
>   }
>   
>   #ifdef CONFIG_PPC_64K_PAGES
> @@ -566,7 +574,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>   	if (psize == MMU_PAGE_64K) {
>   		compat_mask = *slice_mask_for_size(mm, MMU_PAGE_4K);
>   		if (fixed)
> -			slice_or_mask(&good_mask, &compat_mask);
> +			slice_or_mask(&good_mask, &good_mask, &compat_mask);
>   	}
>   #endif
>   
> @@ -598,7 +606,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>   	 * empty and thus can be converted
>   	 */
>   	slice_mask_for_free(mm, &potential_mask, high_limit);
> -	slice_or_mask(&potential_mask, &good_mask);
> +	slice_or_mask(&potential_mask, &potential_mask, &good_mask);
>   	slice_print_mask(" potential", &potential_mask);
>   
>   	if (addr || fixed) {
> @@ -635,7 +643,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>   #ifdef CONFIG_PPC_64K_PAGES
>   	if (addr == -ENOMEM && psize == MMU_PAGE_64K) {
>   		/* retry the search with 4k-page slices included */
> -		slice_or_mask(&potential_mask, &compat_mask);
> +		slice_or_mask(&potential_mask, &potential_mask, &compat_mask);
>   		addr = slice_find_area(mm, len, &potential_mask,
>   				       psize, topdown, high_limit);
>   	}
> @@ -649,8 +657,8 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>   	slice_print_mask(" mask", &mask);
>   
>    convert:
> -	slice_andnot_mask(&mask, &good_mask);
> -	slice_andnot_mask(&mask, &compat_mask);
> +	slice_andnot_mask(&mask, &mask, &good_mask);
> +	slice_andnot_mask(&mask, &mask, &compat_mask);
>   	if (mask.low_slices ||
>   	    (SLICE_NUM_HIGH &&
>   	     !bitmap_empty(mask.high_slices, SLICE_NUM_HIGH))) {
> @@ -790,7 +798,7 @@ int is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
>   	if (psize == MMU_PAGE_64K) {
>   		struct slice_mask compat_mask;
>   		compat_mask = *slice_mask_for_size(mm, MMU_PAGE_4K);
> -		slice_or_mask(&available, &compat_mask);
> +		slice_or_mask(&available, &available, &compat_mask);
>   	}
>   #endif
>   
> 
