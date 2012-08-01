Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F2C252C00C9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2012 17:44:17 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 1 Aug 2012 17:44:08 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q717ZWk623724094
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Aug 2012 17:35:32 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q717hnAh011927
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Aug 2012 17:43:49 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH -V5 06/13] arch/powerpc: Increase the slice range to 64TB
In-Reply-To: <20120801051617.GC24014@drongo>
References: <1343647339-25576-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1343647339-25576-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20120801051617.GC24014@drongo>
Date: Wed, 01 Aug 2012 13:13:37 +0530
Message-ID: <87wr1jhxau.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> writes:

> On Mon, Jul 30, 2012 at 04:52:12PM +0530, Aneesh Kumar K.V wrote:
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> 
>> This patch makes the high psizes mask as an unsigned char array
>> so that we can have more than 16TB. Currently we support upto
>> 64TB
>
> Comments below...
>
>> diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
>> index b9ee79ce..c355af6 100644
>> --- a/arch/powerpc/mm/slb_low.S
>> +++ b/arch/powerpc/mm/slb_low.S
>> @@ -108,17 +108,34 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
>>  	 * between 4k and 64k standard page size
>>  	 */
>>  #ifdef CONFIG_PPC_MM_SLICES
>> +	/* r10 have esid */
>>  	cmpldi	r10,16
>> -
>> -	/* Get the slice index * 4 in r11 and matching slice size mask in r9 */
>> -	ld	r9,PACALOWSLICESPSIZE(r13)
>> -	sldi	r11,r10,2
>> +	/* below SLICE_LOW_TOP */
>>  	blt	5f
>> -	ld	r9,PACAHIGHSLICEPSIZE(r13)
>> -	srdi	r11,r10,(SLICE_HIGH_SHIFT - SLICE_LOW_SHIFT - 2)
>> -	andi.	r11,r11,0x3c
>> -
>> -5:	/* Extract the psize and multiply to get an array offset */
>> +	/*
>> +	 * Handle hpsizes,
>> +	 * r9 is get_paca()->context.high_slices_psize[index], r11 is mask_index
>> +	 * We use r10 here, later we restore it to esid.
>> +	 * Can we use other register instead of r10 ?
>
> Only r9, r10 and r11 are available here, and you're using them all.
> Restoring r10 with one integer instruction is going to be quicker than
> saving and restoring another register to/from memory.
>
>> +	 */
>> +	srdi    r10,r10,(SLICE_HIGH_SHIFT - SLICE_LOW_SHIFT) /* index */
>> +	srdi	r11,r10,1			/* r11 is array index */
>> +	addi	r9,r11,PACAHIGHSLICEPSIZE
>> +	lbzx	r9,r9,r13			/* r9 is hpsizes[r11] */
>> +	sldi    r11,r11,1
>> +	subf	r11,r11,r10	/* mask_index = index - (array_index << 1) */
>> +	srdi	r10,r3,28	/* restore r10 with esid */
>> +	b	6f
>
> How about (untested):
>
> 	srdi    r11,r10,(SLICE_HIGH_SHIFT - SLICE_LOW_SHIFT + 1) /* index */
> 	addi	r9,r11,PACAHIGHSLICEPSIZE
> 	lbzx	r9,r13,r9			/* r9 is hpsizes[r11] */
> 	/* r11 = (r10 >> 12) & 1, i.e. grab lowest bit of 1T ESID */
> 	rldicl	r11,r10,(64 - (SLICE_HIGH_SHIFT - SLICE_LOW_SHIFT)),63
> 	b	6f
>

nice, I missed the assembly part when you asked to update the c code
in previous review. This change also bring it closer to the c code.

> Note that I swapped the RA and RB arguments for the lbzx.  Our recent
> processors process indexed mode instructions more quickly if the value
> in RB is small.
>
>>  static struct slice_mask slice_mask_for_size(struct mm_struct *mm, int psize)
>>  {
>> +	unsigned char *hpsizes;
>> +	int index, mask_index;
>>  	struct slice_mask ret = { 0, 0 };
>>  	unsigned long i;
>> -	u64 psizes;
>> +	u64 lpsizes;
>>  
>> -	psizes = mm->context.low_slices_psize;
>> +	lpsizes = mm->context.low_slices_psize;
>>  	for (i = 0; i < SLICE_NUM_LOW; i++)
>> -		if (((psizes >> (i * 4)) & 0xf) == psize)
>> +		if (((lpsizes >> (i * 4)) & 0xf) == psize)
>>  			ret.low_slices |= 1u << i;
>>  
>> -	psizes = mm->context.high_slices_psize;
>> -	for (i = 0; i < SLICE_NUM_HIGH; i++)
>> -		if (((psizes >> (i * 4)) & 0xf) == psize)
>> +	hpsizes = mm->context.high_slices_psize;
>> +	for (i = 0; i < SLICE_NUM_HIGH; i++) {
>> +		mask_index = i & 0x1;
>> +		index = i >> 1;
>> +		if (((hpsizes[index] >> (mask_index * 4)) & 0xf) == psize)
>>  			ret.high_slices |= 1u << i;
>
> This needs to be 1ul not 1u, since we are creating a 64-bit mask.
>
>>  static void slice_convert(struct mm_struct *mm, struct slice_mask mask, int psize)
>>  {
>> +	int index, mask_index;
>>  	/* Write the new slice psize bits */
>> -	u64 lpsizes, hpsizes;
>> +	unsigned char *hpsizes;
>> +	u64 lpsizes;
>>  	unsigned long i, flags;
>>  
>>  	slice_dbg("slice_convert(mm=%p, psize=%d)\n", mm, psize);
>> @@ -201,14 +208,18 @@ static void slice_convert(struct mm_struct *mm, struct slice_mask mask, int psiz
>>  			lpsizes = (lpsizes & ~(0xful << (i * 4))) |
>>  				(((unsigned long)psize) << (i * 4));
>>  
>> +	/* Assign the value back */
>> +	mm->context.low_slices_psize = lpsizes;
>> +
>>  	hpsizes = mm->context.high_slices_psize;
>> -	for (i = 0; i < SLICE_NUM_HIGH; i++)
>> +	for (i = 0; i < SLICE_NUM_HIGH; i++) {
>> +		mask_index = i & 0x1;
>> +		index = i >> 1;
>>  		if (mask.high_slices & (1u << i))
>
> Again, 1ul now.  Check all the other places where we manipulate a
> slice mask to see if there are any other instances of 1u that need to
> be changed.

I ended up with this. 

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 0136040..b4e996a 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -54,7 +54,7 @@ static void slice_print_mask(const char *label, struct slice_mask mask)
 	*(p++) = '-';
 	*(p++) = ' ';
 	for (i = 0; i < SLICE_NUM_HIGH; i++)
-		*(p++) = (mask.high_slices & (1 << i)) ? '1' : '0';
+		*(p++) = (mask.high_slices & (1ul << i)) ? '1' : '0';
 	*(p++) = 0;
 
 	printk(KERN_DEBUG "%s:%s\n", label, buf);
@@ -84,8 +84,8 @@ static struct slice_mask slice_range_to_mask(unsigned long start,
 	}
 
 	if ((start + len) > SLICE_LOW_TOP)
-		ret.high_slices = (1u << (GET_HIGH_SLICE_INDEX(end) + 1))
-			- (1u << GET_HIGH_SLICE_INDEX(start));
+		ret.high_slices = (1ul << (GET_HIGH_SLICE_INDEX(end) + 1))
+			- (1ul << GET_HIGH_SLICE_INDEX(start));
 
 	return ret;
 }
@@ -135,7 +135,7 @@ static struct slice_mask slice_mask_for_free(struct mm_struct *mm)
 
 	for (i = 0; i < SLICE_NUM_HIGH; i++)
 		if (!slice_high_has_vma(mm, i))
-			ret.high_slices |= 1u << i;
+			ret.high_slices |= 1ul << i;
 
 	return ret;
 }
@@ -158,7 +158,7 @@ static struct slice_mask slice_mask_for_size(struct mm_struct *mm, int psize)
 		mask_index = i & 0x1;
 		index = i >> 1;
 		if (((hpsizes[index] >> (mask_index * 4)) & 0xf) == psize)
-			ret.high_slices |= 1u << i;
+			ret.high_slices |= 1ul << i;
 	}
 
 	return ret;
@@ -215,7 +215,7 @@ static void slice_convert(struct mm_struct *mm, struct slice_mask mask, int psiz
 	for (i = 0; i < SLICE_NUM_HIGH; i++) {
 		mask_index = i & 0x1;
 		index = i >> 1;
-		if (mask.high_slices & (1u << i))
+		if (mask.high_slices & (1ul << i))
 			hpsizes[index] = (hpsizes[index] &
 					  ~(0xf << (mask_index * 4))) |
 				(((unsigned long)psize) << (mask_index * 4));


-aneesh
