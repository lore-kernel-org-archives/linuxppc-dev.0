Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zr8ns3HVHzF1TD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 18:04:31 +1100 (AEDT)
Subject: Re: [RFC REBASED 1/5] powerpc/mm/slice: pass pointers to struct
 slice_mask where possible
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
References: <02a62db83282b5ef3e0e8281fdc46fa91beffc86.1518382747.git.christophe.leroy@c-s.fr>
 <87muzu7w58.fsf@linux.vnet.ibm.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Nicholas Piggin <npiggin@gmail.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <81cef95a-aa8d-5500-89d3-a089ffb41beb@c-s.fr>
Date: Tue, 27 Feb 2018 08:04:25 +0100
MIME-Version: 1.0
In-Reply-To: <87muzu7w58.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 27/02/2018 à 08:02, Aneesh Kumar K.V a écrit :
> 
> Hi,
> 
> Do you have an updated series for this with your latest PPC32 slice
> post?

No, but I can make one if it is on any interest.

Christophe

> 
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> Pass around const pointers to struct slice_mask where possible, rather
>> than copies of slice_mask, to reduce stack and call overhead.
>>
>> checkstack.pl gives, before:
>> 0x00000de4 slice_get_unmapped_area [slice.o]:		656
>> 0x00001b4c is_hugepage_only_range [slice.o]:		512
>> 0x0000075c slice_find_area_topdown [slice.o]:		416
>> 0x000004c8 slice_find_area_bottomup.isra.1 [slice.o]:	272
>> 0x00001aa0 slice_set_range_psize [slice.o]:		240
>> 0x00000a64 slice_find_area [slice.o]:			176
>> 0x00000174 slice_check_fit [slice.o]:			112
>>
>> after:
>> 0x00000bd4 slice_get_unmapped_area [slice.o]:		496
>> 0x000017cc is_hugepage_only_range [slice.o]:		352
>> 0x00000758 slice_find_area [slice.o]:			144
>> 0x00001750 slice_set_range_psize [slice.o]:		144
>> 0x00000180 slice_check_fit [slice.o]:			128
>> 0x000005b0 slice_find_area_bottomup.isra.2 [slice.o]:	128
>>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   rebased on top of "[v4,3/5] powerpc/mm/slice: Fix hugepage allocation at hint address on 8xx" (https://patchwork.ozlabs.org/patch/871675/)
>>
>>   arch/powerpc/mm/slice.c | 81 +++++++++++++++++++++++++++----------------------
>>   1 file changed, 44 insertions(+), 37 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
>> index 549704dfa777..db1278ac21c2 100644
>> --- a/arch/powerpc/mm/slice.c
>> +++ b/arch/powerpc/mm/slice.c
>> @@ -50,19 +50,21 @@ struct slice_mask {
>>   #ifdef DEBUG
>>   int _slice_debug = 1;
>>   
>> -static void slice_print_mask(const char *label, struct slice_mask mask)
>> +static void slice_print_mask(const char *label, const struct slice_mask *mask)
>>   {
>>   	if (!_slice_debug)
>>   		return;
>> -	pr_devel("%s low_slice: %*pbl\n", label, (int)SLICE_NUM_LOW, &mask.low_slices);
>> -	pr_devel("%s high_slice: %*pbl\n", label, (int)SLICE_NUM_HIGH, mask.high_slices);
>> +	pr_devel("%s low_slice: %*pbl\n", label,
>> +			(int)SLICE_NUM_LOW, &mask->low_slices);
>> +	pr_devel("%s high_slice: %*pbl\n", label,
>> +			(int)SLICE_NUM_HIGH, mask->high_slices);
>>   }
>>   
>>   #define slice_dbg(fmt...) do { if (_slice_debug) pr_devel(fmt); } while (0)
>>   
>>   #else
>>   
>> -static void slice_print_mask(const char *label, struct slice_mask mask) {}
>> +static void slice_print_mask(const char *label, const struct slice_mask *mask) {}
>>   #define slice_dbg(fmt...)
>>   
>>   #endif
>> @@ -145,7 +147,8 @@ static void slice_mask_for_free(struct mm_struct *mm, struct slice_mask *ret,
>>   			__set_bit(i, ret->high_slices);
>>   }
>>   
>> -static void slice_mask_for_size(struct mm_struct *mm, int psize, struct slice_mask *ret,
>> +static void slice_mask_for_size(struct mm_struct *mm, int psize,
>> +				struct slice_mask *ret,
>>   				unsigned long high_limit)
>>   {
>>   	unsigned char *hpsizes;
>> @@ -174,7 +177,8 @@ static void slice_mask_for_size(struct mm_struct *mm, int psize, struct slice_ma
>>   }
>>   
>>   static int slice_check_fit(struct mm_struct *mm,
>> -			   struct slice_mask mask, struct slice_mask available)
>> +			   const struct slice_mask *mask,
>> +			   const struct slice_mask *available)
>>   {
>>   	DECLARE_BITMAP(result, SLICE_NUM_HIGH);
>>   	/*
>> @@ -183,11 +187,11 @@ static int slice_check_fit(struct mm_struct *mm,
>>   	 */
>>   	unsigned long slice_count = GET_HIGH_SLICE_INDEX(mm->context.slb_addr_limit);
>>   
>> -	slice_bitmap_and(result, mask.high_slices, available.high_slices,
>> +	slice_bitmap_and(result, mask->high_slices, available->high_slices,
>>   			 slice_count);
>>   
>> -	return (mask.low_slices & available.low_slices) == mask.low_slices &&
>> -		slice_bitmap_equal(result, mask.high_slices, slice_count);
>> +	return (mask->low_slices & available->low_slices) == mask->low_slices &&
>> +		slice_bitmap_equal(result, mask->high_slices, slice_count);
>>   }
>>   
>>   static void slice_flush_segments(void *parm)
>> @@ -207,7 +211,8 @@ static void slice_flush_segments(void *parm)
>>   #endif
>>   }
>>   
>> -static void slice_convert(struct mm_struct *mm, struct slice_mask mask, int psize)
>> +static void slice_convert(struct mm_struct *mm,
>> +				const struct slice_mask *mask, int psize)
>>   {
>>   	int index, mask_index;
>>   	/* Write the new slice psize bits */
>> @@ -225,7 +230,7 @@ static void slice_convert(struct mm_struct *mm, struct slice_mask mask, int psiz
>>   
>>   	lpsizes = mm->context.low_slices_psize;
>>   	for (i = 0; i < SLICE_NUM_LOW; i++)
>> -		if (mask.low_slices & (1u << i))
>> +		if (mask->low_slices & (1u << i))
>>   			lpsizes = (lpsizes & ~(0xful << (i * 4))) |
>>   				(((unsigned long)psize) << (i * 4));
>>   
>> @@ -236,7 +241,7 @@ static void slice_convert(struct mm_struct *mm, struct slice_mask mask, int psiz
>>   	for (i = 0; i < GET_HIGH_SLICE_INDEX(mm->context.slb_addr_limit); i++) {
>>   		mask_index = i & 0x1;
>>   		index = i >> 1;
>> -		if (test_bit(i, mask.high_slices))
>> +		if (test_bit(i, mask->high_slices))
>>   			hpsizes[index] = (hpsizes[index] &
>>   					  ~(0xf << (mask_index * 4))) |
>>   				(((unsigned long)psize) << (mask_index * 4));
>> @@ -259,26 +264,25 @@ static void slice_convert(struct mm_struct *mm, struct slice_mask mask, int psiz
>>    * 'available' slice_mark.
>>    */
>>   static bool slice_scan_available(unsigned long addr,
>> -				 struct slice_mask available,
>> -				 int end,
>> -				 unsigned long *boundary_addr)
>> +				 const struct slice_mask *available,
>> +				 int end, unsigned long *boundary_addr)
>>   {
>>   	unsigned long slice;
>>   	if (addr < SLICE_LOW_TOP) {
>>   		slice = GET_LOW_SLICE_INDEX(addr);
>>   		*boundary_addr = (slice + end) << SLICE_LOW_SHIFT;
>> -		return !!(available.low_slices & (1u << slice));
>> +		return !!(available->low_slices & (1u << slice));
>>   	} else {
>>   		slice = GET_HIGH_SLICE_INDEX(addr);
>>   		*boundary_addr = (slice + end) ?
>>   			((slice + end) << SLICE_HIGH_SHIFT) : SLICE_LOW_TOP;
>> -		return !!test_bit(slice, available.high_slices);
>> +		return !!test_bit(slice, available->high_slices);
>>   	}
>>   }
>>   
>>   static unsigned long slice_find_area_bottomup(struct mm_struct *mm,
>>   					      unsigned long len,
>> -					      struct slice_mask available,
>> +					      const struct slice_mask *available,
>>   					      int psize, unsigned long high_limit)
>>   {
>>   	int pshift = max_t(int, mmu_psize_defs[psize].shift, PAGE_SHIFT);
>> @@ -324,7 +328,7 @@ static unsigned long slice_find_area_bottomup(struct mm_struct *mm,
>>   
>>   static unsigned long slice_find_area_topdown(struct mm_struct *mm,
>>   					     unsigned long len,
>> -					     struct slice_mask available,
>> +					     const struct slice_mask *available,
>>   					     int psize, unsigned long high_limit)
>>   {
>>   	int pshift = max_t(int, mmu_psize_defs[psize].shift, PAGE_SHIFT);
>> @@ -382,7 +386,7 @@ static unsigned long slice_find_area_topdown(struct mm_struct *mm,
>>   
>>   
>>   static unsigned long slice_find_area(struct mm_struct *mm, unsigned long len,
>> -				     struct slice_mask mask, int psize,
>> +				     const struct slice_mask *mask, int psize,
>>   				     int topdown, unsigned long high_limit)
>>   {
>>   	if (topdown)
>> @@ -391,14 +395,16 @@ static unsigned long slice_find_area(struct mm_struct *mm, unsigned long len,
>>   		return slice_find_area_bottomup(mm, len, mask, psize, high_limit);
>>   }
>>   
>> -static inline void slice_or_mask(struct slice_mask *dst, struct slice_mask *src)
>> +static inline void slice_or_mask(struct slice_mask *dst,
>> +					const struct slice_mask *src)
>>   {
>>   	dst->low_slices |= src->low_slices;
>>   	slice_bitmap_or(dst->high_slices, dst->high_slices, src->high_slices,
>>   			SLICE_NUM_HIGH);
>>   }
>>   
>> -static inline void slice_andnot_mask(struct slice_mask *dst, struct slice_mask *src)
>> +static inline void slice_andnot_mask(struct slice_mask *dst,
>> +					const struct slice_mask *src)
>>   {
>>   	dst->low_slices &= ~src->low_slices;
>>   
>> @@ -483,7 +489,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>>   	 * already
>>   	 */
>>   	slice_mask_for_size(mm, psize, &good_mask, high_limit);
>> -	slice_print_mask(" good_mask", good_mask);
>> +	slice_print_mask(" good_mask", &good_mask);
>>   
>>   	/*
>>   	 * Here "good" means slices that are already the right page size,
>> @@ -517,12 +523,12 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>>   	if (addr != 0 || fixed) {
>>   		/* Build a mask for the requested range */
>>   		slice_range_to_mask(addr, len, &mask);
>> -		slice_print_mask(" mask", mask);
>> +		slice_print_mask(" mask", &mask);
>>   
>>   		/* Check if we fit in the good mask. If we do, we just return,
>>   		 * nothing else to do
>>   		 */
>> -		if (slice_check_fit(mm, mask, good_mask)) {
>> +		if (slice_check_fit(mm, &mask, &good_mask)) {
>>   			slice_dbg(" fits good !\n");
>>   			return addr;
>>   		}
>> @@ -530,7 +536,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>>   		/* Now let's see if we can find something in the existing
>>   		 * slices for that size
>>   		 */
>> -		newaddr = slice_find_area(mm, len, good_mask,
>> +		newaddr = slice_find_area(mm, len, &good_mask,
>>   					  psize, topdown, high_limit);
>>   		if (newaddr != -ENOMEM) {
>>   			/* Found within the good mask, we don't have to setup,
>> @@ -546,9 +552,10 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>>   	 */
>>   	slice_mask_for_free(mm, &potential_mask, high_limit);
>>   	slice_or_mask(&potential_mask, &good_mask);
>> -	slice_print_mask(" potential", potential_mask);
>> +	slice_print_mask(" potential", &potential_mask);
>>   
>> -	if ((addr != 0 || fixed) && slice_check_fit(mm, mask, potential_mask)) {
>> +	if ((addr != 0 || fixed) &&
>> +			slice_check_fit(mm, &mask, &potential_mask)) {
>>   		slice_dbg(" fits potential !\n");
>>   		goto convert;
>>   	}
>> @@ -563,7 +570,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>>   	 * anywhere in the good area.
>>   	 */
>>   	if (addr) {
>> -		addr = slice_find_area(mm, len, good_mask,
>> +		addr = slice_find_area(mm, len, &good_mask,
>>   				       psize, topdown, high_limit);
>>   		if (addr != -ENOMEM) {
>>   			slice_dbg(" found area at 0x%lx\n", addr);
>> @@ -574,14 +581,14 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>>   	/* Now let's see if we can find something in the existing slices
>>   	 * for that size plus free slices
>>   	 */
>> -	addr = slice_find_area(mm, len, potential_mask,
>> +	addr = slice_find_area(mm, len, &potential_mask,
>>   			       psize, topdown, high_limit);
>>   
>>   #ifdef CONFIG_PPC_64K_PAGES
>>   	if (addr == -ENOMEM && psize == MMU_PAGE_64K) {
>>   		/* retry the search with 4k-page slices included */
>>   		slice_or_mask(&potential_mask, &compat_mask);
>> -		addr = slice_find_area(mm, len, potential_mask,
>> +		addr = slice_find_area(mm, len, &potential_mask,
>>   				       psize, topdown, high_limit);
>>   	}
>>   #endif
>> @@ -591,14 +598,14 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>>   
>>   	slice_range_to_mask(addr, len, &mask);
>>   	slice_dbg(" found potential area at 0x%lx\n", addr);
>> -	slice_print_mask(" mask", mask);
>> +	slice_print_mask(" mask", &mask);
>>   
>>    convert:
>>   	slice_andnot_mask(&mask, &good_mask);
>>   	slice_andnot_mask(&mask, &compat_mask);
>>   	if (mask.low_slices ||
>>   	    !slice_bitmap_empty(mask.high_slices, SLICE_NUM_HIGH)) {
>> -		slice_convert(mm, mask, psize);
>> +		slice_convert(mm, &mask, psize);
>>   		if (psize > MMU_PAGE_BASE)
>>   			on_each_cpu(slice_flush_segments, mm, 1);
>>   	}
>> @@ -727,7 +734,7 @@ void slice_set_range_psize(struct mm_struct *mm, unsigned long start,
>>   	VM_BUG_ON(radix_enabled());
>>   
>>   	slice_range_to_mask(start, len, &mask);
>> -	slice_convert(mm, mask, psize);
>> +	slice_convert(mm, &mask, psize);
>>   }
>>   
>>   #ifdef CONFIG_HUGETLB_PAGE
>> @@ -774,9 +781,9 @@ int is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
>>   #if 0 /* too verbose */
>>   	slice_dbg("is_hugepage_only_range(mm=%p, addr=%lx, len=%lx)\n",
>>   		 mm, addr, len);
>> -	slice_print_mask(" mask", mask);
>> -	slice_print_mask(" available", available);
>> +	slice_print_mask(" mask", &mask);
>> +	slice_print_mask(" available", &available);
>>   #endif
>> -	return !slice_check_fit(mm, mask, available);
>> +	return !slice_check_fit(mm, &mask, &available);
>>   }
>>   #endif
>> -- 
>> 2.13.3
