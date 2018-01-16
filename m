Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLbTs637BzF0X0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 03:37:05 +1100 (AEDT)
Subject: Re: [PATCH 2/3] powerpc/mm: Allow more than 16 low slices
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <9a5dadc10f88e2fc0ac9fb5d18c5424df33f3f4c.1515169256.git.christophe.leroy@c-s.fr>
 <eed37907f78d84c973434b90a137a351bc233651.1515169256.git.christophe.leroy@c-s.fr>
 <873735by2e.fsf@linux.vnet.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <9958effd-4689-f0f5-b9bf-d9812fcc51ec@c-s.fr>
Date: Tue, 16 Jan 2018 17:37:01 +0100
MIME-Version: 1.0
In-Reply-To: <873735by2e.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 16/01/2018 à 16:52, Aneesh Kumar K.V a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> While the implementation of the "slices" address space allows
>> a significant amount of high slices, it limits the number of
>> low slices to 16 due to the use of a single u64 low_slices element
>> in struct slice_mask.
> 
> It is not really slice_mask. it is mm_context_t.low_slice_psize which is
> of type 64 and we need 4 bits per each slice to store the segment base
> page size details. What is that you want to achieve here. For book3s,
> we have 256MB segments upto 1TB and beyound that we use 1TB segments.
> But for 256MB segments in the range from 4G - 1TB they all use the same
> base page size because that is tracked by one slice in high slice.
> 
> Can you state the 8xx requirement here?

On the 8xx, we need each slice to be one or a multiple of PGD entries.

In 4k page size mode, each PGD entry covers 4M. So it may be interesting 
to have slices of size 4M.
In 16k page size mode, each PGD entry covers 64M, So it may be 
interesting to have slices of size 64M.

> 
> 
>>
>> In order to override this limitation, this patch switches the
>> handling of low_slices to BITMAPs as done already for high_slices.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/include/asm/book3s/64/mmu.h |   2 +-
>>   arch/powerpc/include/asm/mmu-8xx.h       |   2 +-
>>   arch/powerpc/include/asm/paca.h          |   2 +-
>>   arch/powerpc/kernel/paca.c               |   3 +-
>>   arch/powerpc/mm/hash_utils_64.c          |  13 ++--
>>   arch/powerpc/mm/slb_low.S                |   8 ++-
>>   arch/powerpc/mm/slice.c                  | 102 +++++++++++++++++--------------
>>   7 files changed, 73 insertions(+), 59 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
>> index c9448e19847a..27e7e9732ea1 100644
>> --- a/arch/powerpc/include/asm/book3s/64/mmu.h
>> +++ b/arch/powerpc/include/asm/book3s/64/mmu.h
>> @@ -91,7 +91,7 @@ typedef struct {
>>   	struct npu_context *npu_context;
>>   
>>   #ifdef CONFIG_PPC_MM_SLICES
>> -	u64 low_slices_psize;	/* SLB page size encodings */
>> +	unsigned char low_slices_psize[8]; /* SLB page size encodings */
>>   	unsigned char high_slices_psize[SLICE_ARRAY_SIZE];
>>   	unsigned long slb_addr_limit;
>>   #else
>> diff --git a/arch/powerpc/include/asm/mmu-8xx.h b/arch/powerpc/include/asm/mmu-8xx.h
>> index 5f89b6010453..d669d0062da4 100644
>> --- a/arch/powerpc/include/asm/mmu-8xx.h
>> +++ b/arch/powerpc/include/asm/mmu-8xx.h
>> @@ -171,7 +171,7 @@ typedef struct {
>>   	unsigned long vdso_base;
>>   #ifdef CONFIG_PPC_MM_SLICES
>>   	u16 user_psize;		/* page size index */
>> -	u64 low_slices_psize;	/* page size encodings */
>> +	unsigned char low_slices_psize[8]; /* 16 slices */
>>   	unsigned char high_slices_psize[0];
>>   	unsigned long slb_addr_limit;
>>   #endif
>> diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
>> index 3892db93b837..612017054825 100644
>> --- a/arch/powerpc/include/asm/paca.h
>> +++ b/arch/powerpc/include/asm/paca.h
>> @@ -141,7 +141,7 @@ struct paca_struct {
>>   #ifdef CONFIG_PPC_BOOK3S
>>   	mm_context_id_t mm_ctx_id;
>>   #ifdef CONFIG_PPC_MM_SLICES
>> -	u64 mm_ctx_low_slices_psize;
>> +	unsigned char mm_ctx_low_slices_psize[8];
>>   	unsigned char mm_ctx_high_slices_psize[SLICE_ARRAY_SIZE];
>>   	unsigned long mm_ctx_slb_addr_limit;
>>   #else
>> diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
>> index d6597038931d..8e1566bf82b8 100644
>> --- a/arch/powerpc/kernel/paca.c
>> +++ b/arch/powerpc/kernel/paca.c
>> @@ -264,7 +264,8 @@ void copy_mm_to_paca(struct mm_struct *mm)
>>   #ifdef CONFIG_PPC_MM_SLICES
>>   	VM_BUG_ON(!mm->context.slb_addr_limit);
>>   	get_paca()->mm_ctx_slb_addr_limit = mm->context.slb_addr_limit;
>> -	get_paca()->mm_ctx_low_slices_psize = context->low_slices_psize;
>> +	memcpy(&get_paca()->mm_ctx_low_slices_psize,
>> +	       &context->low_slices_psize, sizeof(context->low_slices_psize));
>>   	memcpy(&get_paca()->mm_ctx_high_slices_psize,
>>   	       &context->high_slices_psize, TASK_SLICE_ARRAY_SZ(mm));
>>   #else /* CONFIG_PPC_MM_SLICES */
>> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
>> index 3266b3326088..2f0c6b527a83 100644
>> --- a/arch/powerpc/mm/hash_utils_64.c
>> +++ b/arch/powerpc/mm/hash_utils_64.c
>> @@ -1097,19 +1097,18 @@ unsigned int hash_page_do_lazy_icache(unsigned int pp, pte_t pte, int trap)
>>   #ifdef CONFIG_PPC_MM_SLICES
>>   static unsigned int get_paca_psize(unsigned long addr)
>>   {
>> -	u64 lpsizes;
>> -	unsigned char *hpsizes;
>> +	unsigned char *psizes;
>>   	unsigned long index, mask_index;
>>   
>>   	if (addr <= SLICE_LOW_TOP) {
>> -		lpsizes = get_paca()->mm_ctx_low_slices_psize;
>> +		psizes = get_paca()->mm_ctx_low_slices_psize;
>>   		index = GET_LOW_SLICE_INDEX(addr);
>> -		return (lpsizes >> (index * 4)) & 0xF;
>> +	} else {
>> +		psizes = get_paca()->mm_ctx_high_slices_psize;
>> +		index = GET_HIGH_SLICE_INDEX(addr);
>>   	}
>> -	hpsizes = get_paca()->mm_ctx_high_slices_psize;
>> -	index = GET_HIGH_SLICE_INDEX(addr);
>>   	mask_index = index & 0x1;
>> -	return (hpsizes[index >> 1] >> (mask_index * 4)) & 0xF;
>> +	return (psizes[index >> 1] >> (mask_index * 4)) & 0xF;
>>   }
>>   
>>   #else
>> diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
>> index 2cf5ef3fc50d..2c7c717fd2ea 100644
>> --- a/arch/powerpc/mm/slb_low.S
>> +++ b/arch/powerpc/mm/slb_low.S
>> @@ -200,10 +200,12 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
>>   5:
>>   	/*
>>   	 * Handle lpsizes
>> -	 * r9 is get_paca()->context.low_slices_psize, r11 is index
>> +	 * r9 is get_paca()->context.low_slices_psize[index], r11 is mask_index
>>   	 */
>> -	ld	r9,PACALOWSLICESPSIZE(r13)
>> -	mr	r11,r10
>> +	srdi    r11,r10,1 /* index */
>> +	addi	r9,r11,PACALOWSLICESPSIZE
>> +	lbzx	r9,r13,r9		/* r9 is lpsizes[r11] */
>> +	rldicl	r11,r10,0,63		/* r11 = r10 & 0x1 */
>>   6:
>>   	sldi	r11,r11,2  /* index * 4 */
>>   	/* Extract the psize and multiply to get an array offset */
>> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
>> index 1a66fafc3e45..e01ea72f21c6 100644
>> --- a/arch/powerpc/mm/slice.c
>> +++ b/arch/powerpc/mm/slice.c
>> @@ -43,7 +43,7 @@ static DEFINE_SPINLOCK(slice_convert_lock);
>>    * in 1TB size.
>>    */
>>   struct slice_mask {
>> -	u64 low_slices;
>> +	DECLARE_BITMAP(low_slices, SLICE_NUM_LOW);
>>   	DECLARE_BITMAP(high_slices, SLICE_NUM_HIGH);
>>   };
>>   
>> @@ -54,7 +54,8 @@ static void slice_print_mask(const char *label, struct slice_mask mask)
>>   {
>>   	if (!_slice_debug)
>>   		return;
>> -	pr_devel("%s low_slice: %*pbl\n", label, (int)SLICE_NUM_LOW, &mask.low_slices);
>> +	pr_devel("%s low_slice: %*pbl\n", label, (int)SLICE_NUM_LOW,
>> +		 mask.low_slices);
>>   	pr_devel("%s high_slice: %*pbl\n", label, (int)SLICE_NUM_HIGH, mask.high_slices);
>>   }
>>   
>> @@ -72,15 +73,18 @@ static void slice_range_to_mask(unsigned long start, unsigned long len,
>>   {
>>   	unsigned long end = start + len - 1;
>>   
>> -	ret->low_slices = 0;
>> +	bitmap_zero(ret->low_slices, SLICE_NUM_LOW);
>>   	if (SLICE_NUM_HIGH)
>>   		bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
>>   
>>   	if (start <= SLICE_LOW_TOP) {
>>   		unsigned long mend = min(end, SLICE_LOW_TOP);
>> +		unsigned long start_index = GET_LOW_SLICE_INDEX(start);
>> +		unsigned long align_end = ALIGN(mend, (1UL << SLICE_LOW_SHIFT));
>> +		unsigned long count = GET_LOW_SLICE_INDEX(align_end) -
>> +				      start_index;
>>   
>> -		ret->low_slices = (1u << (GET_LOW_SLICE_INDEX(mend) + 1))
>> -			- (1u << GET_LOW_SLICE_INDEX(start));
>> +		bitmap_set(ret->low_slices, start_index, count);
>>   	}
>>   
>>   	if ((start + len) > SLICE_LOW_TOP) {
>> @@ -128,13 +132,13 @@ static void slice_mask_for_free(struct mm_struct *mm, struct slice_mask *ret,
>>   {
>>   	unsigned long i;
>>   
>> -	ret->low_slices = 0;
>> +	bitmap_zero(ret->low_slices, SLICE_NUM_LOW);
>>   	if (SLICE_NUM_HIGH)
>>   		bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
>>   
>>   	for (i = 0; i < SLICE_NUM_LOW; i++)
>>   		if (!slice_low_has_vma(mm, i))
>> -			ret->low_slices |= 1u << i;
>> +			__set_bit(i, ret->low_slices);
>>   
>>   	if (high_limit <= SLICE_LOW_TOP)
>>   		return;
>> @@ -147,19 +151,21 @@ static void slice_mask_for_free(struct mm_struct *mm, struct slice_mask *ret,
>>   static void slice_mask_for_size(struct mm_struct *mm, int psize, struct slice_mask *ret,
>>   				unsigned long high_limit)
>>   {
>> -	unsigned char *hpsizes;
>> +	unsigned char *hpsizes, *lpsizes;
>>   	int index, mask_index;
>>   	unsigned long i;
>> -	u64 lpsizes;
>>   
>> -	ret->low_slices = 0;
>> +	bitmap_zero(ret->low_slices, SLICE_NUM_LOW);
>>   	if (SLICE_NUM_HIGH)
>>   		bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
>>   
>>   	lpsizes = mm->context.low_slices_psize;
>> -	for (i = 0; i < SLICE_NUM_LOW; i++)
>> -		if (((lpsizes >> (i * 4)) & 0xf) == psize)
>> -			ret->low_slices |= 1u << i;
>> +	for (i = 0; i < SLICE_NUM_LOW; i++) {
>> +		mask_index = i & 0x1;
>> +		index = i >> 1;
>> +		if (((lpsizes[index] >> (mask_index * 4)) & 0xf) == psize)
>> +			__set_bit(i, ret->low_slices);
>> +	}
>>   
>>   	if (high_limit <= SLICE_LOW_TOP)
>>   		return;
>> @@ -176,6 +182,7 @@ static void slice_mask_for_size(struct mm_struct *mm, int psize, struct slice_ma
>>   static int slice_check_fit(struct mm_struct *mm,
>>   			   struct slice_mask mask, struct slice_mask available)
>>   {
>> +	DECLARE_BITMAP(result_low, SLICE_NUM_LOW);
>>   	DECLARE_BITMAP(result, SLICE_NUM_HIGH);
>>   	/*
>>   	 * Make sure we just do bit compare only to the max
>> @@ -183,11 +190,13 @@ static int slice_check_fit(struct mm_struct *mm,
>>   	 */
>>   	unsigned long slice_count = GET_HIGH_SLICE_INDEX(mm->context.slb_addr_limit);
>>   
>> +	bitmap_and(result_low, mask.low_slices,
>> +		   available.low_slices, SLICE_NUM_LOW);
>>   	if (SLICE_NUM_HIGH)
>>   		bitmap_and(result, mask.high_slices,
>>   			   available.high_slices, slice_count);
>>   
>> -	return (mask.low_slices & available.low_slices) == mask.low_slices &&
>> +	return bitmap_equal(result_low, mask.low_slices, SLICE_NUM_LOW) &&
>>   		(!slice_count ||
>>   		 bitmap_equal(result, mask.high_slices, slice_count));
>>   }
>> @@ -213,8 +222,7 @@ static void slice_convert(struct mm_struct *mm, struct slice_mask mask, int psiz
>>   {
>>   	int index, mask_index;
>>   	/* Write the new slice psize bits */
>> -	unsigned char *hpsizes;
>> -	u64 lpsizes;
>> +	unsigned char *hpsizes, *lpsizes;
>>   	unsigned long i, flags;
>>   
>>   	slice_dbg("slice_convert(mm=%p, psize=%d)\n", mm, psize);
>> @@ -226,13 +234,14 @@ static void slice_convert(struct mm_struct *mm, struct slice_mask mask, int psiz
>>   	spin_lock_irqsave(&slice_convert_lock, flags);
>>   
>>   	lpsizes = mm->context.low_slices_psize;
>> -	for (i = 0; i < SLICE_NUM_LOW; i++)
>> -		if (mask.low_slices & (1u << i))
>> -			lpsizes = (lpsizes & ~(0xful << (i * 4))) |
>> -				(((unsigned long)psize) << (i * 4));
>> -
>> -	/* Assign the value back */
>> -	mm->context.low_slices_psize = lpsizes;
>> +	for (i = 0; i < SLICE_NUM_LOW; i++) {
>> +		mask_index = i & 0x1;
>> +		index = i >> 1;
>> +		if (test_bit(i, mask.low_slices))
>> +			lpsizes[index] = (lpsizes[index] &
>> +					  ~(0xf << (mask_index * 4))) |
>> +				(((unsigned long)psize) << (mask_index * 4));
>> +	}
>>   
>>   	hpsizes = mm->context.high_slices_psize;
>>   	for (i = 0; i < GET_HIGH_SLICE_INDEX(mm->context.slb_addr_limit); i++) {
>> @@ -269,7 +278,7 @@ static bool slice_scan_available(unsigned long addr,
>>   	if (addr <= SLICE_LOW_TOP) {
>>   		slice = GET_LOW_SLICE_INDEX(addr);
>>   		*boundary_addr = (slice + end) << SLICE_LOW_SHIFT;
>> -		return !!(available.low_slices & (1u << slice));
>> +		return !!test_bit(slice, available.low_slices);
>>   	} else {
>>   		slice = GET_HIGH_SLICE_INDEX(addr);
>>   		*boundary_addr = (slice + end) ?
>> @@ -397,7 +406,8 @@ static inline void slice_or_mask(struct slice_mask *dst, struct slice_mask *src)
>>   {
>>   	DECLARE_BITMAP(result, SLICE_NUM_HIGH);
>>   
>> -	dst->low_slices |= src->low_slices;
>> +	bitmap_or(dst->low_slices, dst->low_slices, src->low_slices,
>> +		  SLICE_NUM_LOW);
>>   	if (SLICE_NUM_HIGH) {
>>   		bitmap_or(result, dst->high_slices, src->high_slices,
>>   			  SLICE_NUM_HIGH);
>> @@ -409,7 +419,8 @@ static inline void slice_andnot_mask(struct slice_mask *dst, struct slice_mask *
>>   {
>>   	DECLARE_BITMAP(result, SLICE_NUM_HIGH);
>>   
>> -	dst->low_slices &= ~src->low_slices;
>> +	bitmap_andnot(dst->low_slices, dst->low_slices, src->low_slices,
>> +		      SLICE_NUM_LOW);
>>   
>>   	if (SLICE_NUM_HIGH) {
>>   		bitmap_andnot(result, dst->high_slices, src->high_slices,
>> @@ -464,16 +475,16 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>>   	/*
>>   	 * init different masks
>>   	 */
>> -	mask.low_slices = 0;
>> +	bitmap_zero(mask.low_slices, SLICE_NUM_LOW);
>>   	if (SLICE_NUM_HIGH)
>>   		bitmap_zero(mask.high_slices, SLICE_NUM_HIGH);
>>   
>>   	/* silence stupid warning */;
>> -	potential_mask.low_slices = 0;
>> +	bitmap_zero(potential_mask.low_slices, SLICE_NUM_LOW);
>>   	if (SLICE_NUM_HIGH)
>>   		bitmap_zero(potential_mask.high_slices, SLICE_NUM_HIGH);
>>   
>> -	compat_mask.low_slices = 0;
>> +	bitmap_zero(compat_mask.low_slices, SLICE_NUM_LOW);
>>   	if (SLICE_NUM_HIGH)
>>   		bitmap_zero(compat_mask.high_slices, SLICE_NUM_HIGH);
>>   
>> @@ -613,7 +624,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>>    convert:
>>   	slice_andnot_mask(&mask, &good_mask);
>>   	slice_andnot_mask(&mask, &compat_mask);
>> -	if (mask.low_slices ||
>> +	if (!bitmap_empty(mask.low_slices, SLICE_NUM_LOW) ||
>>   	    (SLICE_NUM_HIGH &&
>>   	     !bitmap_empty(mask.high_slices, SLICE_NUM_HIGH))) {
>>   		slice_convert(mm, mask, psize);
>> @@ -647,7 +658,7 @@ unsigned long arch_get_unmapped_area_topdown(struct file *filp,
>>   
>>   unsigned int get_slice_psize(struct mm_struct *mm, unsigned long addr)
>>   {
>> -	unsigned char *hpsizes;
>> +	unsigned char *psizes;
>>   	int index, mask_index;
>>   
>>   	/*
>> @@ -661,15 +672,14 @@ unsigned int get_slice_psize(struct mm_struct *mm, unsigned long addr)
>>   #endif
>>   	}
>>   	if (addr <= SLICE_LOW_TOP) {
>> -		u64 lpsizes;
>> -		lpsizes = mm->context.low_slices_psize;
>> +		psizes = mm->context.low_slices_psize;
>>   		index = GET_LOW_SLICE_INDEX(addr);
>> -		return (lpsizes >> (index * 4)) & 0xf;
>> +	} else {
>> +		psizes = mm->context.high_slices_psize;
>> +		index = GET_HIGH_SLICE_INDEX(addr);
>>   	}
>> -	hpsizes = mm->context.high_slices_psize;
>> -	index = GET_HIGH_SLICE_INDEX(addr);
>>   	mask_index = index & 0x1;
>> -	return (hpsizes[index >> 1] >> (mask_index * 4)) & 0xf;
>> +	return (psizes[index >> 1] >> (mask_index * 4)) & 0xf;
>>   }
>>   EXPORT_SYMBOL_GPL(get_slice_psize);
>>   
>> @@ -690,8 +700,8 @@ EXPORT_SYMBOL_GPL(get_slice_psize);
>>   void slice_set_user_psize(struct mm_struct *mm, unsigned int psize)
>>   {
>>   	int index, mask_index;
>> -	unsigned char *hpsizes;
>> -	unsigned long flags, lpsizes;
>> +	unsigned char *hpsizes, *lpsizes;
>> +	unsigned long flags;
>>   	unsigned int old_psize;
>>   	int i;
>>   
>> @@ -709,12 +719,14 @@ void slice_set_user_psize(struct mm_struct *mm, unsigned int psize)
>>   	wmb();
>>   
>>   	lpsizes = mm->context.low_slices_psize;
>> -	for (i = 0; i < SLICE_NUM_LOW; i++)
>> -		if (((lpsizes >> (i * 4)) & 0xf) == old_psize)
>> -			lpsizes = (lpsizes & ~(0xful << (i * 4))) |
>> -				(((unsigned long)psize) << (i * 4));
>> -	/* Assign the value back */
>> -	mm->context.low_slices_psize = lpsizes;
>> +	for (i = 0; i < SLICE_NUM_LOW; i++) {
>> +		mask_index = i & 0x1;
>> +		index = i >> 1;
>> +		if (((lpsizes[index] >> (mask_index * 4)) & 0xf) == old_psize)
>> +			lpsizes[index] = (lpsizes[index] &
>> +					  ~(0xf << (mask_index * 4))) |
>> +				(((unsigned long)psize) << (mask_index * 4));
>> +	}
>>   
>>   	hpsizes = mm->context.high_slices_psize;
>>   	for (i = 0; i < SLICE_NUM_HIGH; i++) {
>> -- 
>> 2.13.3
