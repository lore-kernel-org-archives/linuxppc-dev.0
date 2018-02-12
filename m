Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zfvmy2fhqzF0b3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 16:46:41 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1C5hdBr102940
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 00:46:39 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g2k0rgtry-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 00:46:39 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 12 Feb 2018 05:46:37 -0000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 2/5] powerpc/mm/slice: Enhance for supporting PPC32
In-Reply-To: <0ac518636ae1e601ea0732dd69b48dcd0f347285.1518226173.git.christophe.leroy@c-s.fr>
References: <01e8f783db8f4d4d41df91e0400a8634272b326f.1518226173.git.christophe.leroy@c-s.fr>
 <0ac518636ae1e601ea0732dd69b48dcd0f347285.1518226173.git.christophe.leroy@c-s.fr>
Date: Mon, 12 Feb 2018 11:16:29 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87d11aiwui.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> In preparation for the following patch which will fix an issue on
> the 8xx by re-using the 'slices', this patch enhances the
> 'slices' implementation to support 32 bits CPUs.
>
> On PPC32, the address space is limited to 4Gbytes, hence only the low
> slices will be used.
>
> This patch moves "slices" functions prototypes from page64.h to slice.h
>
> The high slices use bitmaps. As bitmap functions are not prepared to
> handling bitmaps of size 0, the bitmap_xxx() calls are wrapped into
> slice_bitmap_xxx() functions which will void on PPC32
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  v2: First patch of v1 serie split in two parts ; added slice_bitmap_xxx() macros.
>  v3: Moving slice related stuff in slice.h and slice_32/64.h
>      slice_bitmap_xxx() are now static inline functions and platform dependent
>      SLICE_LOW_TOP declared ull on PPC32 with correct casts allows to keep it 0x100000000
>  v4: Moved slice_32.h and slice_64.h to respective subarch dirs
>      Moved somes #ifdefs from asm/slice.h to respective subarch slice.h
>      SLICE_LOW_ details distributed in repective subarch slices allthough they are identical for the moment
>
>  arch/powerpc/include/asm/book3s/64/slice.h | 79 ++++++++++++++++++++++++++++++
>  arch/powerpc/include/asm/nohash/32/slice.h | 65 ++++++++++++++++++++++++
>  arch/powerpc/include/asm/nohash/64/slice.h | 12 +++++
>  arch/powerpc/include/asm/page.h            |  1 +
>  arch/powerpc/include/asm/page_64.h         | 59 ----------------------
>  arch/powerpc/include/asm/slice.h           | 42 ++++++++++++++++
>  arch/powerpc/mm/slice.c                    | 38 ++++++++------
>  7 files changed, 221 insertions(+), 75 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/book3s/64/slice.h
>  create mode 100644 arch/powerpc/include/asm/nohash/32/slice.h
>  create mode 100644 arch/powerpc/include/asm/nohash/64/slice.h
>  create mode 100644 arch/powerpc/include/asm/slice.h
>
> diff --git a/arch/powerpc/include/asm/book3s/64/slice.h b/arch/powerpc/include/asm/book3s/64/slice.h
> new file mode 100644
> index 000000000000..f9a2c8bd7a77
> --- /dev/null
> +++ b/arch/powerpc/include/asm/book3s/64/slice.h
> @@ -0,0 +1,79 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_POWERPC_BOOK3S_64_SLICE_H
> +#define _ASM_POWERPC_BOOK3S_64_SLICE_H
> +
> +#ifdef CONFIG_PPC_MM_SLICES
> +
> +#define SLICE_LOW_SHIFT		28
> +#define SLICE_LOW_TOP		(0x100000000ul)
> +#define SLICE_NUM_LOW		(SLICE_LOW_TOP >> SLICE_LOW_SHIFT)
> +#define GET_LOW_SLICE_INDEX(addr)	((addr) >> SLICE_LOW_SHIFT)
> +
> +#define SLICE_HIGH_SHIFT	40
> +#define SLICE_NUM_HIGH		(H_PGTABLE_RANGE >> SLICE_HIGH_SHIFT)
> +#define GET_HIGH_SLICE_INDEX(addr)	((addr) >> SLICE_HIGH_SHIFT)
> +
> +#ifndef __ASSEMBLY__
> +
> +#include <linux/bitmap.h>
> +
> +static inline void slice_bitmap_zero(unsigned long *dst, unsigned int nbits)
> +{
> +	bitmap_zero(dst, nbits);
> +}
> +
> +static inline int slice_bitmap_and(unsigned long *dst,
> +				   const unsigned long *src1,
> +				   const unsigned long *src2,
> +				   unsigned int nbits)
> +{
> +	return bitmap_and(dst, src1, src2, nbits);
> +}
> +
> +static inline void slice_bitmap_or(unsigned long *dst,
> +				   const unsigned long *src1,
> +				   const unsigned long *src2,
> +				   unsigned int nbits)
> +{
> +	bitmap_or(dst, src1, src2, nbits);
> +}
> +
> +static inline int slice_bitmap_andnot(unsigned long *dst,
> +				      const unsigned long *src1,
> +				      const unsigned long *src2,
> +				      unsigned int nbits)
> +{
> +	return bitmap_andnot(dst, src1, src2, nbits);
> +}
> +
> +static inline int slice_bitmap_equal(const unsigned long *src1,
> +				     const unsigned long *src2,
> +				     unsigned int nbits)
> +{
> +	return bitmap_equal(src1, src2, nbits);
> +}
> +
> +static inline int slice_bitmap_empty(const unsigned long *src, unsigned nbits)
> +{
> +	return bitmap_empty(src, nbits);
> +}
> +
> +static inline void slice_bitmap_set(unsigned long *map, unsigned int start,
> +				    unsigned int nbits)
> +{
> +	bitmap_set(map, start, nbits);
> +}
> +#endif /* __ASSEMBLY__ */
> +
> +#else /* CONFIG_PPC_MM_SLICES */
> +
> +#define get_slice_psize(mm, addr)	((mm)->context.user_psize)
> +#define slice_set_user_psize(mm, psize)		\
> +do {						\
> +	(mm)->context.user_psize = (psize);	\
> +	(mm)->context.sllp = SLB_VSID_USER | mmu_psize_defs[(psize)].sllp; \
> +} while (0)
> +
> +#endif /* CONFIG_PPC_MM_SLICES */
> +
> +#endif /* _ASM_POWERPC_BOOK3S_64_SLICE_H */
> diff --git a/arch/powerpc/include/asm/nohash/32/slice.h b/arch/powerpc/include/asm/nohash/32/slice.h
> new file mode 100644
> index 000000000000..bcb4924f7d22
> --- /dev/null
> +++ b/arch/powerpc/include/asm/nohash/32/slice.h
> @@ -0,0 +1,65 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_POWERPC_NOHASH_32_SLICE_H
> +#define _ASM_POWERPC_NOHASH_32_SLICE_H
> +
> +#ifdef CONFIG_PPC_MM_SLICES
> +
> +#define SLICE_LOW_SHIFT		28
> +#define SLICE_LOW_TOP		(0x100000000ull)
> +#define SLICE_NUM_LOW		(SLICE_LOW_TOP >> SLICE_LOW_SHIFT)
> +#define GET_LOW_SLICE_INDEX(addr)	((addr) >> SLICE_LOW_SHIFT)
> +
> +#define SLICE_HIGH_SHIFT	0
> +#define SLICE_NUM_HIGH		0ul
> +#define GET_HIGH_SLICE_INDEX(addr)	(addr & 0)
> +
> +#ifndef __ASSEMBLY__
> +
> +static inline void slice_bitmap_zero(unsigned long *dst, unsigned int nbits)
> +{
> +}
> +
> +static inline int slice_bitmap_and(unsigned long *dst,
> +				   const unsigned long *src1,
> +				   const unsigned long *src2,
> +				   unsigned int nbits)
> +{
> +	return 0;
> +}
> +
> +static inline void slice_bitmap_or(unsigned long *dst,
> +				   const unsigned long *src1,
> +				   const unsigned long *src2,
> +				   unsigned int nbits)
> +{
> +}
> +
> +static inline int slice_bitmap_andnot(unsigned long *dst,
> +				      const unsigned long *src1,
> +				      const unsigned long *src2,
> +				      unsigned int nbits)
> +{
> +	return 0;
> +}
> +
> +static inline int slice_bitmap_equal(const unsigned long *src1,
> +				     const unsigned long *src2,
> +				     unsigned int nbits)
> +{
> +	return 1;
> +}
> +
> +static inline int slice_bitmap_empty(const unsigned long *src, unsigned nbits)
> +{
> +	return 1;
> +}
> +
> +static inline void slice_bitmap_set(unsigned long *map, unsigned int start,
> +				    unsigned int nbits)
> +{
> +}
> +#endif /* __ASSEMBLY__ */
> +
> +#endif /* CONFIG_PPC_MM_SLICES */
> +
> +#endif /* _ASM_POWERPC_NOHASH_32_SLICE_H */
> diff --git a/arch/powerpc/include/asm/nohash/64/slice.h b/arch/powerpc/include/asm/nohash/64/slice.h
> new file mode 100644
> index 000000000000..ad0d6e3cc1c5
> --- /dev/null
> +++ b/arch/powerpc/include/asm/nohash/64/slice.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_POWERPC_NOHASH_64_SLICE_H
> +#define _ASM_POWERPC_NOHASH_64_SLICE_H
> +
> +#ifdef CONFIG_PPC_64K_PAGES
> +#define get_slice_psize(mm, addr)	MMU_PAGE_64K
> +#else /* CONFIG_PPC_64K_PAGES */
> +#define get_slice_psize(mm, addr)	MMU_PAGE_4K
> +#endif /* !CONFIG_PPC_64K_PAGES */
> +#define slice_set_user_psize(mm, psize)	do { BUG(); } while (0)
> +
> +#endif /* _ASM_POWERPC_NOHASH_64_SLICE_H */
> diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
> index 8da5d4c1cab2..d5f1c41b7dba 100644
> --- a/arch/powerpc/include/asm/page.h
> +++ b/arch/powerpc/include/asm/page.h
> @@ -344,5 +344,6 @@ typedef struct page *pgtable_t;
>  
>  #include <asm-generic/memory_model.h>
>  #endif /* __ASSEMBLY__ */
> +#include <asm/slice.h>
>  
>  #endif /* _ASM_POWERPC_PAGE_H */
> diff --git a/arch/powerpc/include/asm/page_64.h b/arch/powerpc/include/asm/page_64.h
> index 56234c6fcd61..af04acdb873f 100644
> --- a/arch/powerpc/include/asm/page_64.h
> +++ b/arch/powerpc/include/asm/page_64.h
> @@ -86,65 +86,6 @@ extern u64 ppc64_pft_size;
>  
>  #endif /* __ASSEMBLY__ */
>  
> -#ifdef CONFIG_PPC_MM_SLICES
> -
> -#define SLICE_LOW_SHIFT		28
> -#define SLICE_HIGH_SHIFT	40
> -
> -#define SLICE_LOW_TOP		(0x100000000ul)
> -#define SLICE_NUM_LOW		(SLICE_LOW_TOP >> SLICE_LOW_SHIFT)
> -#define SLICE_NUM_HIGH		(H_PGTABLE_RANGE >> SLICE_HIGH_SHIFT)
> -
> -#define GET_LOW_SLICE_INDEX(addr)	((addr) >> SLICE_LOW_SHIFT)
> -#define GET_HIGH_SLICE_INDEX(addr)	((addr) >> SLICE_HIGH_SHIFT)
> -
> -#ifndef __ASSEMBLY__
> -struct mm_struct;
> -
> -extern unsigned long slice_get_unmapped_area(unsigned long addr,
> -					     unsigned long len,
> -					     unsigned long flags,
> -					     unsigned int psize,
> -					     int topdown);
> -
> -extern unsigned int get_slice_psize(struct mm_struct *mm,
> -				    unsigned long addr);
> -
> -extern void slice_set_user_psize(struct mm_struct *mm, unsigned int psize);
> -extern void slice_set_range_psize(struct mm_struct *mm, unsigned long start,
> -				  unsigned long len, unsigned int psize);
> -
> -#endif /* __ASSEMBLY__ */
> -#else
> -#define slice_init()
> -#ifdef CONFIG_PPC_BOOK3S_64
> -#define get_slice_psize(mm, addr)	((mm)->context.user_psize)
> -#define slice_set_user_psize(mm, psize)		\
> -do {						\
> -	(mm)->context.user_psize = (psize);	\
> -	(mm)->context.sllp = SLB_VSID_USER | mmu_psize_defs[(psize)].sllp; \
> -} while (0)
> -#else /* !CONFIG_PPC_BOOK3S_64 */
> -#ifdef CONFIG_PPC_64K_PAGES
> -#define get_slice_psize(mm, addr)	MMU_PAGE_64K
> -#else /* CONFIG_PPC_64K_PAGES */
> -#define get_slice_psize(mm, addr)	MMU_PAGE_4K
> -#endif /* !CONFIG_PPC_64K_PAGES */
> -#define slice_set_user_psize(mm, psize)	do { BUG(); } while(0)
> -#endif /* CONFIG_PPC_BOOK3S_64 */
> -
> -#define slice_set_range_psize(mm, start, len, psize)	\
> -	slice_set_user_psize((mm), (psize))
> -#endif /* CONFIG_PPC_MM_SLICES */
> -
> -#ifdef CONFIG_HUGETLB_PAGE
> -
> -#ifdef CONFIG_PPC_MM_SLICES
> -#define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
> -#endif
> -
> -#endif /* !CONFIG_HUGETLB_PAGE */
> -
>  #define VM_DATA_DEFAULT_FLAGS \
>  	(is_32bit_task() ? \
>  	 VM_DATA_DEFAULT_FLAGS32 : VM_DATA_DEFAULT_FLAGS64)
> diff --git a/arch/powerpc/include/asm/slice.h b/arch/powerpc/include/asm/slice.h
> new file mode 100644
> index 000000000000..172711fadb1c
> --- /dev/null
> +++ b/arch/powerpc/include/asm/slice.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_POWERPC_SLICE_H
> +#define _ASM_POWERPC_SLICE_H
> +
> +#ifdef CONFIG_PPC_BOOK3S_64
> +#include <asm/book3s/64/slice.h>
> +#elif defined(CONFIG_PPC64)
> +#include <asm/nohash/64/slice.h>
> +#elif defined(CONFIG_PPC_MMU_NOHASH)
> +#include <asm/nohash/32/slice.h>
> +#endif
> +
> +#ifdef CONFIG_PPC_MM_SLICES
> +
> +#ifdef CONFIG_HUGETLB_PAGE
> +#define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
> +#endif
> +#define HAVE_ARCH_UNMAPPED_AREA
> +#define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
> +
> +#ifndef __ASSEMBLY__
> +
> +struct mm_struct;
> +
> +unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
> +				      unsigned long flags, unsigned int psize,
> +				      int topdown);
> +
> +unsigned int get_slice_psize(struct mm_struct *mm, unsigned long addr);
> +
> +void slice_set_user_psize(struct mm_struct *mm, unsigned int psize);
> +void slice_set_range_psize(struct mm_struct *mm, unsigned long start,
> +			   unsigned long len, unsigned int psize);
> +#endif /* __ASSEMBLY__ */
> +
> +#else /* CONFIG_PPC_MM_SLICES */
> +
> +#define slice_set_range_psize(mm, start, len, psize)	\
> +	slice_set_user_psize((mm), (psize))
> +#endif /* CONFIG_PPC_MM_SLICES */
> +
> +#endif /* _ASM_POWERPC_SLICE_H */
> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
> index 98b53d48968f..549704dfa777 100644
> --- a/arch/powerpc/mm/slice.c
> +++ b/arch/powerpc/mm/slice.c
> @@ -73,10 +73,11 @@ static void slice_range_to_mask(unsigned long start, unsigned long len,
>  	unsigned long end = start + len - 1;
>  
>  	ret->low_slices = 0;
> -	bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
> +	slice_bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
>  
>  	if (start < SLICE_LOW_TOP) {
> -		unsigned long mend = min(end, (SLICE_LOW_TOP - 1));
> +		unsigned long mend = min(end,
> +					 (unsigned long)(SLICE_LOW_TOP - 1));
>  
>  		ret->low_slices = (1u << (GET_LOW_SLICE_INDEX(mend) + 1))
>  			- (1u << GET_LOW_SLICE_INDEX(start));
> @@ -87,7 +88,7 @@ static void slice_range_to_mask(unsigned long start, unsigned long len,
>  		unsigned long align_end = ALIGN(end, (1UL << SLICE_HIGH_SHIFT));
>  		unsigned long count = GET_HIGH_SLICE_INDEX(align_end) - start_index;
>  
> -		bitmap_set(ret->high_slices, start_index, count);
> +		slice_bitmap_set(ret->high_slices, start_index, count);
>  	}
>  }
>  
> @@ -113,11 +114,13 @@ static int slice_high_has_vma(struct mm_struct *mm, unsigned long slice)
>  	unsigned long start = slice << SLICE_HIGH_SHIFT;
>  	unsigned long end = start + (1ul << SLICE_HIGH_SHIFT);
>  
> +#ifdef CONFIG_PPC64
>  	/* Hack, so that each addresses is controlled by exactly one
>  	 * of the high or low area bitmaps, the first high area starts
>  	 * at 4GB, not 0 */
>  	if (start == 0)
>  		start = SLICE_LOW_TOP;
> +#endif
>  
>  	return !slice_area_is_free(mm, start, end - start);
>  }
> @@ -128,7 +131,7 @@ static void slice_mask_for_free(struct mm_struct *mm, struct slice_mask *ret,
>  	unsigned long i;
>  
>  	ret->low_slices = 0;
> -	bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
> +	slice_bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
>  
>  	for (i = 0; i < SLICE_NUM_LOW; i++)
>  		if (!slice_low_has_vma(mm, i))
> @@ -151,7 +154,7 @@ static void slice_mask_for_size(struct mm_struct *mm, int psize, struct slice_ma
>  	u64 lpsizes;
>  
>  	ret->low_slices = 0;
> -	bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
> +	slice_bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
>  
>  	lpsizes = mm->context.low_slices_psize;
>  	for (i = 0; i < SLICE_NUM_LOW; i++)
> @@ -180,15 +183,16 @@ static int slice_check_fit(struct mm_struct *mm,
>  	 */
>  	unsigned long slice_count = GET_HIGH_SLICE_INDEX(mm->context.slb_addr_limit);
>  
> -	bitmap_and(result, mask.high_slices,
> -		   available.high_slices, slice_count);
> +	slice_bitmap_and(result, mask.high_slices, available.high_slices,
> +			 slice_count);
>  
>  	return (mask.low_slices & available.low_slices) == mask.low_slices &&
> -		bitmap_equal(result, mask.high_slices, slice_count);
> +		slice_bitmap_equal(result, mask.high_slices, slice_count);
>  }
>  
>  static void slice_flush_segments(void *parm)
>  {
> +#ifdef CONFIG_PPC64
>  	struct mm_struct *mm = parm;
>  	unsigned long flags;
>  
> @@ -200,6 +204,7 @@ static void slice_flush_segments(void *parm)
>  	local_irq_save(flags);
>  	slb_flush_and_rebolt();
>  	local_irq_restore(flags);
> +#endif
>  }
>  
>  static void slice_convert(struct mm_struct *mm, struct slice_mask mask, int psize)
> @@ -389,16 +394,16 @@ static unsigned long slice_find_area(struct mm_struct *mm, unsigned long len,
>  static inline void slice_or_mask(struct slice_mask *dst, struct slice_mask *src)
>  {
>  	dst->low_slices |= src->low_slices;
> -	bitmap_or(dst->high_slices, dst->high_slices, src->high_slices,
> -		  SLICE_NUM_HIGH);
> +	slice_bitmap_or(dst->high_slices, dst->high_slices, src->high_slices,
> +			SLICE_NUM_HIGH);
>  }
>  
>  static inline void slice_andnot_mask(struct slice_mask *dst, struct slice_mask *src)
>  {
>  	dst->low_slices &= ~src->low_slices;
>  
> -	bitmap_andnot(dst->high_slices, dst->high_slices, src->high_slices,
> -		      SLICE_NUM_HIGH);
> +	slice_bitmap_andnot(dst->high_slices, dst->high_slices,
> +			    src->high_slices, SLICE_NUM_HIGH);
>  }
>  
>  #ifdef CONFIG_PPC_64K_PAGES
> @@ -446,14 +451,14 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>  	 * init different masks
>  	 */
>  	mask.low_slices = 0;
> -	bitmap_zero(mask.high_slices, SLICE_NUM_HIGH);
> +	slice_bitmap_zero(mask.high_slices, SLICE_NUM_HIGH);
>  
>  	/* silence stupid warning */;
>  	potential_mask.low_slices = 0;
> -	bitmap_zero(potential_mask.high_slices, SLICE_NUM_HIGH);
> +	slice_bitmap_zero(potential_mask.high_slices, SLICE_NUM_HIGH);
>  
>  	compat_mask.low_slices = 0;
> -	bitmap_zero(compat_mask.high_slices, SLICE_NUM_HIGH);
> +	slice_bitmap_zero(compat_mask.high_slices, SLICE_NUM_HIGH);
>  
>  	/* Sanity checks */
>  	BUG_ON(mm->task_size == 0);
> @@ -591,7 +596,8 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>   convert:
>  	slice_andnot_mask(&mask, &good_mask);
>  	slice_andnot_mask(&mask, &compat_mask);
> -	if (mask.low_slices || !bitmap_empty(mask.high_slices, SLICE_NUM_HIGH)) {
> +	if (mask.low_slices ||
> +	    !slice_bitmap_empty(mask.high_slices, SLICE_NUM_HIGH)) {
>  		slice_convert(mm, mask, psize);
>  		if (psize > MMU_PAGE_BASE)
>  			on_each_cpu(slice_flush_segments, mm, 1);
> -- 
> 2.13.3
