Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zNDQS6C5XzF0yP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 19:24:48 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0J8OAk1107874
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 03:24:45 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fkc242mp3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 03:24:45 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 19 Jan 2018 08:24:42 -0000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] powerpc/mm: Enhance 'slice' for supporting PPC32
In-Reply-To: <49148d07955d3e5f963cedf9adcfcc37c3e03ef4.1516179904.git.christophe.leroy@c-s.fr>
References: <49148d07955d3e5f963cedf9adcfcc37c3e03ef4.1516179904.git.christophe.leroy@c-s.fr>
Date: Fri, 19 Jan 2018 13:54:34 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87vafyz265.fsf@linux.vnet.ibm.com>
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
> slices will be used. As of today, the code uses
> SLICE_LOW_TOP (0x100000000ul) and compares it with addr to determine
> if addr refers to low or high space.
> On PPC32, such a (addr < SLICE_LOW_TOP) test is always false because
> 0x100000000ul degrades to 0. Therefore, the patch modifies
> SLICE_LOW_TOP to (0xfffffffful) and modifies the tests to
> (addr <= SLICE_LOW_TOP) which will then always be true on PPC32
> as addr has type 'unsigned long' while not modifying the PPC64
> behaviour.
>
> This patch moves "slices" functions prototypes from page64.h to page.h
>
> The high slices use bitmaps. As bitmap functions are not prepared to
> handling bitmaps of size 0, the bitmap_xxx() calls are wrapped into
> slice_bitmap_xxx() macros which will take care of the 0 nbits case.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  v2: First patch of v1 serie split in two parts ; added slice_bitmap_xxx() macros.
>
>  arch/powerpc/include/asm/page.h      | 14 +++++++++
>  arch/powerpc/include/asm/page_32.h   | 19 ++++++++++++
>  arch/powerpc/include/asm/page_64.h   | 21 ++-----------
>  arch/powerpc/mm/hash_utils_64.c      |  2 +-
>  arch/powerpc/mm/mmu_context_nohash.c |  7 +++++
>  arch/powerpc/mm/slice.c              | 60 ++++++++++++++++++++++++------------
>  6 files changed, 83 insertions(+), 40 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
> index 8da5d4c1cab2..d0384f9db9eb 100644
> --- a/arch/powerpc/include/asm/page.h
> +++ b/arch/powerpc/include/asm/page.h
> @@ -342,6 +342,20 @@ typedef struct page *pgtable_t;
>  #endif
>  #endif
>  
> +#ifdef CONFIG_PPC_MM_SLICES
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
> +#endif
> +

Should we do a slice.h ? the way we have other files? and then do

arch/powerpc/include/asm/book3s/64/slice.h that will carry
#define slice_bitmap_zero(dst, nbits) \
	do { if (nbits) bitmap_zero(dst, nbits); } while (0)
#define slice_bitmap_set(dst, pos, nbits) \
do { if (nbits) bitmap_set(dst, pos, nbits); } while (0)
#define slice_bitmap_copy(dst, src, nbits) \
do { if (nbits) bitmap_copy(dst, src, nbits); } while (0)
#define slice_bitmap_and(dst, src1, src2, nbits) \
	({ (nbits) ? bitmap_and(dst, src1, src2, nbits) : 0; })
#define slice_bitmap_or(dst, src1, src2, nbits) \
	do { if (nbits) bitmap_or(dst, src1, src2, nbits); } while (0)
#define slice_bitmap_andnot(dst, src1, src2, nbits) \
	({ (nbits) ? bitmap_andnot(dst, src1, src2, nbits) : 0; })
#define slice_bitmap_equal(src1, src2, nbits) \
	({ (nbits) ? bitmap_equal(src1, src2, nbits) : 1; })
#define slice_bitmap_empty(src, nbits) \
	({ (nbits) ? bitmap_empty(src, nbits) : 1; })

This without that if(nbits) check and a proper static inline so that we
can do type checking.

also related definitions for
#define SLICE_LOW_SHIFT		28
#define SLICE_HIGH_SHIFT	0

#define SLICE_LOW_TOP		(0xfffffffful)
#define SLICE_NUM_LOW		((SLICE_LOW_TOP >> SLICE_LOW_SHIFT) + 1)
+#define SLICE_NUM_HIGH		0ul

Common stuff between 64 and 32 can got to
arch/powerpc/include/asm/slice.h ?

It also gives an indication of which 32 bit version we are looking at
here. IIUC 8xx will got to arch/powerpc/include/asm/nohash/32/slice.h?

>  #include <asm-generic/memory_model.h>
>  #endif /* __ASSEMBLY__ */
>  
> diff --git a/arch/powerpc/include/asm/page_32.h b/arch/powerpc/include/asm/page_32.h
> index 5c378e9b78c8..f7d1bd1183c8 100644
> --- a/arch/powerpc/include/asm/page_32.h
> +++ b/arch/powerpc/include/asm/page_32.h
> @@ -60,4 +60,23 @@ extern void copy_page(void *to, void *from);
>  
>  #endif /* __ASSEMBLY__ */
>  
> +#ifdef CONFIG_PPC_MM_SLICES
> +
> +#define SLICE_LOW_SHIFT		28
> +#define SLICE_HIGH_SHIFT	0
> +
> +#define SLICE_LOW_TOP		(0xfffffffful)
> +#define SLICE_NUM_LOW		((SLICE_LOW_TOP >> SLICE_LOW_SHIFT) + 1)
> +#define SLICE_NUM_HIGH		0ul
> +
> +#define GET_LOW_SLICE_INDEX(addr)	((addr) >> SLICE_LOW_SHIFT)
> +#define GET_HIGH_SLICE_INDEX(addr)	(addr & 0)
> +
> +#ifdef CONFIG_HUGETLB_PAGE
> +#define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
> +#endif
> +#define HAVE_ARCH_UNMAPPED_AREA
> +#define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
> +
> +#endif
>  #endif /* _ASM_POWERPC_PAGE_32_H */
> diff --git a/arch/powerpc/include/asm/page_64.h b/arch/powerpc/include/asm/page_64.h
> index 56234c6fcd61..a7baef5bbe5f 100644
> --- a/arch/powerpc/include/asm/page_64.h
> +++ b/arch/powerpc/include/asm/page_64.h
> @@ -91,30 +91,13 @@ extern u64 ppc64_pft_size;
>  #define SLICE_LOW_SHIFT		28
>  #define SLICE_HIGH_SHIFT	40
>  
> -#define SLICE_LOW_TOP		(0x100000000ul)
> -#define SLICE_NUM_LOW		(SLICE_LOW_TOP >> SLICE_LOW_SHIFT)
> +#define SLICE_LOW_TOP		(0xfffffffful)
> +#define SLICE_NUM_LOW		((SLICE_LOW_TOP >> SLICE_LOW_SHIFT) + 1)
>  #define SLICE_NUM_HIGH		(H_PGTABLE_RANGE >> SLICE_HIGH_SHIFT)
>  
>  #define GET_LOW_SLICE_INDEX(addr)	((addr) >> SLICE_LOW_SHIFT)
>  #define GET_HIGH_SLICE_INDEX(addr)	((addr) >> SLICE_HIGH_SHIFT)
>  
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
>  #else
>  #define slice_init()
>  #ifdef CONFIG_PPC_BOOK3S_64
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index 655a5a9a183d..3266b3326088 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -1101,7 +1101,7 @@ static unsigned int get_paca_psize(unsigned long addr)
>  	unsigned char *hpsizes;
>  	unsigned long index, mask_index;
>  
> -	if (addr < SLICE_LOW_TOP) {
> +	if (addr <= SLICE_LOW_TOP) {
>  		lpsizes = get_paca()->mm_ctx_low_slices_psize;
>  		index = GET_LOW_SLICE_INDEX(addr);
>  		return (lpsizes >> (index * 4)) & 0xF;
> diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
> index 4554d6527682..42e02f5b6660 100644
> --- a/arch/powerpc/mm/mmu_context_nohash.c
> +++ b/arch/powerpc/mm/mmu_context_nohash.c
> @@ -331,6 +331,13 @@ int init_new_context(struct task_struct *t, struct mm_struct *mm)
>  {
>  	pr_hard("initing context for mm @%p\n", mm);
>  
> +#ifdef CONFIG_PPC_MM_SLICES
> +	if (!mm->context.slb_addr_limit)
> +		mm->context.slb_addr_limit = DEFAULT_MAP_WINDOW;
> +	if (!mm->context.id)
> +		slice_set_user_psize(mm, mmu_virtual_psize);
> +#endif
> +
>  	mm->context.id = MMU_NO_CONTEXT;
>  	mm->context.active = 0;
>  	return 0;
> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
> index 23ec2c5e3b78..3f35a93afe13 100644
> --- a/arch/powerpc/mm/slice.c
> +++ b/arch/powerpc/mm/slice.c
> @@ -67,16 +67,33 @@ static void slice_print_mask(const char *label, struct slice_mask mask) {}
>  
>  #endif
>  
> +#define slice_bitmap_zero(dst, nbits) \
> +	do { if (nbits) bitmap_zero(dst, nbits); } while (0)
> +#define slice_bitmap_set(dst, pos, nbits) \
> +	do { if (nbits) bitmap_set(dst, pos, nbits); } while (0)
> +#define slice_bitmap_copy(dst, src, nbits) \
> +	do { if (nbits) bitmap_copy(dst, src, nbits); } while (0)
> +#define slice_bitmap_and(dst, src1, src2, nbits) \
> +	({ (nbits) ? bitmap_and(dst, src1, src2, nbits) : 0; })
> +#define slice_bitmap_or(dst, src1, src2, nbits) \
> +	do { if (nbits) bitmap_or(dst, src1, src2, nbits); } while (0)
> +#define slice_bitmap_andnot(dst, src1, src2, nbits) \
> +	({ (nbits) ? bitmap_andnot(dst, src1, src2, nbits) : 0; })
> +#define slice_bitmap_equal(src1, src2, nbits) \
> +	({ (nbits) ? bitmap_equal(src1, src2, nbits) : 1; })
> +#define slice_bitmap_empty(src, nbits) \
> +	({ (nbits) ? bitmap_empty(src, nbits) : 1; })
> +
>  static void slice_range_to_mask(unsigned long start, unsigned long len,
>  				struct slice_mask *ret)
>  {
>  	unsigned long end = start + len - 1;
>  
>  	ret->low_slices = 0;
> -	bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
> +	slice_bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
>  
> -	if (start < SLICE_LOW_TOP) {
> -		unsigned long mend = min(end, (SLICE_LOW_TOP - 1));
> +	if (start <= SLICE_LOW_TOP) {
> +		unsigned long mend = min(end, SLICE_LOW_TOP);
>  
>  		ret->low_slices = (1u << (GET_LOW_SLICE_INDEX(mend) + 1))
>  			- (1u << GET_LOW_SLICE_INDEX(start));
> @@ -87,7 +104,7 @@ static void slice_range_to_mask(unsigned long start, unsigned long len,
>  		unsigned long align_end = ALIGN(end, (1UL << SLICE_HIGH_SHIFT));
>  		unsigned long count = GET_HIGH_SLICE_INDEX(align_end) - start_index;
>  
> -		bitmap_set(ret->high_slices, start_index, count);
> +		slice_bitmap_set(ret->high_slices, start_index, count);
>  	}
>  }
>  
> @@ -117,7 +134,7 @@ static int slice_high_has_vma(struct mm_struct *mm, unsigned long slice)
>  	 * of the high or low area bitmaps, the first high area starts
>  	 * at 4GB, not 0 */
>  	if (start == 0)
> -		start = SLICE_LOW_TOP;
> +		start = SLICE_LOW_TOP + 1;
>  
>  	return !slice_area_is_free(mm, start, end - start);
>  }
> @@ -128,7 +145,7 @@ static void slice_mask_for_free(struct mm_struct *mm, struct slice_mask *ret,
>  	unsigned long i;
>  
>  	ret->low_slices = 0;
> -	bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
> +	slice_bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
>  
>  	for (i = 0; i < SLICE_NUM_LOW; i++)
>  		if (!slice_low_has_vma(mm, i))
> @@ -151,7 +168,7 @@ static void slice_mask_for_size(struct mm_struct *mm, int psize, struct slice_ma
>  	u64 lpsizes;
>  
>  	ret->low_slices = 0;
> -	bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
> +	slice_bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
>  
>  	lpsizes = mm->context.low_slices_psize;
>  	for (i = 0; i < SLICE_NUM_LOW; i++)
> @@ -180,11 +197,11 @@ static int slice_check_fit(struct mm_struct *mm,
>  	 */
>  	unsigned long slice_count = GET_HIGH_SLICE_INDEX(mm->context.slb_addr_limit);
>  
> -	bitmap_and(result, mask.high_slices,
> -		   available.high_slices, slice_count);
> +	slice_bitmap_and(result, mask.high_slices,
> +			 available.high_slices, slice_count);
>  
>  	return (mask.low_slices & available.low_slices) == mask.low_slices &&
> -		bitmap_equal(result, mask.high_slices, slice_count);
> +		slice_bitmap_equal(result, mask.high_slices, slice_count));
>  }
>  
>  static void slice_flush_segments(void *parm)
> @@ -259,7 +276,7 @@ static bool slice_scan_available(unsigned long addr,
>  				 unsigned long *boundary_addr)
>  {
>  	unsigned long slice;
> -	if (addr < SLICE_LOW_TOP) {
> +	if (addr <= SLICE_LOW_TOP) {
>  		slice = GET_LOW_SLICE_INDEX(addr);
>  		*boundary_addr = (slice + end) << SLICE_LOW_SHIFT;
>  		return !!(available.low_slices & (1u << slice));
> @@ -391,8 +408,9 @@ static inline void slice_or_mask(struct slice_mask *dst, struct slice_mask *src)
>  	DECLARE_BITMAP(result, SLICE_NUM_HIGH);
>  
>  	dst->low_slices |= src->low_slices;
> -	bitmap_or(result, dst->high_slices, src->high_slices, SLICE_NUM_HIGH);
> -	bitmap_copy(dst->high_slices, result, SLICE_NUM_HIGH);
> +	slice_bitmap_or(result, dst->high_slices, src->high_slices,
> +			SLICE_NUM_HIGH);
> +	slice_bitmap_copy(dst->high_slices, result, SLICE_NUM_HIGH);
>  }
>  
>  static inline void slice_andnot_mask(struct slice_mask *dst, struct slice_mask *src)
> @@ -401,8 +419,9 @@ static inline void slice_andnot_mask(struct slice_mask *dst, struct slice_mask *
>  
>  	dst->low_slices &= ~src->low_slices;
>  
> -	bitmap_andnot(result, dst->high_slices, src->high_slices, SLICE_NUM_HIGH);
> -	bitmap_copy(dst->high_slices, result, SLICE_NUM_HIGH);
> +	slice_bitmap_andnot(result, dst->high_slices, src->high_slices,
> +			    SLICE_NUM_HIGH);
> +	slice_bitmap_copy(dst->high_slices, result, SLICE_NUM_HIGH);
>  }
>  
>  #ifdef CONFIG_PPC_64K_PAGES
> @@ -450,14 +469,14 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
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
> @@ -595,7 +614,8 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>   convert:
>  	slice_andnot_mask(&mask, &good_mask);
>  	slice_andnot_mask(&mask, &compat_mask);
> -	if (mask.low_slices || !bitmap_empty(mask.high_slices, SLICE_NUM_HIGH)) {
> +	if (mask.low_slices ||
> +	    !slice_bitmap_empty(mask.high_slices, SLICE_NUM_HIGH)) {
>  		slice_convert(mm, mask, psize);
>  		if (psize > MMU_PAGE_BASE)
>  			on_each_cpu(slice_flush_segments, mm, 1);
> @@ -640,7 +660,7 @@ unsigned int get_slice_psize(struct mm_struct *mm, unsigned long addr)
>  		return MMU_PAGE_4K;
>  #endif
>  	}
> -	if (addr < SLICE_LOW_TOP) {
> +	if (addr <= SLICE_LOW_TOP) {
>  		u64 lpsizes;
>  		lpsizes = mm->context.low_slices_psize;
>  		index = GET_LOW_SLICE_INDEX(addr);
> -- 
> 2.13.3
