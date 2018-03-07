Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zx3G43ThVzF1XH
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2018 17:12:27 +1100 (AEDT)
Subject: Re: [PATCH 06/10] powerpc/mm/slice: implement slice_check_range_fits
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
References: <20180306132507.10649-1-npiggin@gmail.com>
 <20180306132507.10649-7-npiggin@gmail.com>
 <e600126e-ab89-e15b-e4c3-17dec7799a57@c-s.fr>
 <20180307091232.4fb8d3c2@roar.ozlabs.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <a61d33eb-dde3-526a-0847-e2d56f824217@c-s.fr>
Date: Wed, 7 Mar 2018 07:12:23 +0100
MIME-Version: 1.0
In-Reply-To: <20180307091232.4fb8d3c2@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 07/03/2018 à 00:12, Nicholas Piggin a écrit :
> On Tue, 6 Mar 2018 15:41:00 +0100
> Christophe LEROY <christophe.leroy@c-s.fr> wrote:
> 
>> Le 06/03/2018 à 14:25, Nicholas Piggin a écrit :
> 
> 
>>> +static bool slice_check_range_fits(struct mm_struct *mm,
>>> +			   const struct slice_mask *available,
>>> +			   unsigned long start, unsigned long len)
>>>    {
>>> -	DECLARE_BITMAP(result, SLICE_NUM_HIGH);
>>> -	/*
>>> -	 * Make sure we just do bit compare only to the max
>>> -	 * addr limit and not the full bit map size.
>>> -	 */
>>> -	unsigned long slice_count = GET_HIGH_SLICE_INDEX(mm->context.slb_addr_limit);
>>> +	unsigned long end = start + len - 1;
>>> +	u64 low_slices = 0;
>>>    
>>> -	if (!SLICE_NUM_HIGH)
>>> -		return (mask->low_slices & available->low_slices) ==
>>> -		       mask->low_slices;
>>> +	if (start < SLICE_LOW_TOP) {
>>> +		unsigned long mend = min(end, (SLICE_LOW_TOP - 1));
>>
>> See slice_range_to_mask()
>>
>> You'll have an issue here with PPC32, you have to cast (SLICE_LOW_TOP -
>> 1) to unsigned long because SLICE_LOW_TOP is unsigned long long on PPC32
> 
> Okay thanks. Forgot to cross compiled it on 8xx, so I'll do that next
> time.
> 
>>> +
>>> +		low_slices = (1u << (GET_LOW_SLICE_INDEX(mend) + 1))
>>> +				- (1u << GET_LOW_SLICE_INDEX(start));
>>> +	}
>>> +	if ((low_slices & available->low_slices) != low_slices)
>>> +		return false;
>>> +
>>> +	if (SLICE_NUM_HIGH && ((start + len) > SLICE_LOW_TOP)) {
>>> +		unsigned long start_index = GET_HIGH_SLICE_INDEX(start);
>>> +		unsigned long align_end = ALIGN(end, (1UL << SLICE_HIGH_SHIFT));
>>> +		unsigned long count = GET_HIGH_SLICE_INDEX(align_end) - start_index;
>>> +		unsigned long i;
>>>    
>>> -	bitmap_and(result, mask->high_slices,
>>> -		   available->high_slices, slice_count);
>>> +		for (i = start_index; i < start_index + count; i++) {
>>> +			if (!test_bit(i, available->high_slices))
>>> +				return false;
>>> +		}
>>
>> What about using bitmap_find_next_zero_area()
> 
> I'll look at it. Perhaps in another patch, because existing
> loops are not using bitmap range operations either. A series
> to convert those is a good idea.
> 
>>> @@ -562,15 +571,11 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>>>    #endif
>>>    
>>>    	/* First check hint if it's valid or if we have MAP_FIXED */
>>> -	if (addr != 0 || fixed) {
>>> -		/* Build a mask for the requested range */
>>> -		slice_range_to_mask(addr, len, &mask);
>>> -		slice_print_mask(" mask", &mask);
>>> -
>>> +	if (addr || fixed) {
>>
>> It is cleanup, should it really be part of this patch ?
> 
> 
> 
>>> @@ -596,10 +601,11 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>>>    	slice_or_mask(&potential_mask, &good_mask);
>>>    	slice_print_mask(" potential", &potential_mask);
>>>    
>>> -	if ((addr != 0 || fixed) &&
>>> -			slice_check_fit(mm, &mask, &potential_mask)) {
>>> -		slice_dbg(" fits potential !\n");
>>> -		goto convert;
>>> +	if (addr || fixed) {
>>> +		if (slice_check_range_fits(mm, &potential_mask, addr, len)) {
>>> +			slice_dbg(" fits potential !\n");
>>> +			goto convert;
>>> +		}
>>
>> Why not keep the original structure and just replacing slice_check_fit()
>> by slice_check_range_fits() ?
>>
>> I believe cleanups should not be mixed with real feature changes. If
>> needed, you should have a cleanup patch up front the serie.
> 
> For code that is already changing, I think minor cleanups are okay if
> they're very simple. Maybe this is getting to the point of needing
> another patch. You've made valid points for a lot of other unnecessary
> cleanups though, so I'll fix all of those.

Ok, that's not a big point, but I like when patches really modifies
only the lines they need to modify. Why do we need a double if ?

Why not just the following ? With proper alignment of the second line 
with the open parenthese, it fits in one line

	if ((addr != 0 || fixed) &&
-			slice_check_fit(mm, &mask, &potential_mask)) {
+	    slice_check_range_fits(mm, &potential_mask, addr, len)) {
  		slice_dbg(" fits potential !\n");
  		goto convert;
	}


Christophe
