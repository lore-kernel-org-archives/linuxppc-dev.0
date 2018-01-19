Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zNFBb2NlxzF0bN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 19:59:35 +1100 (AEDT)
Subject: Re: [PATCH v2 3/5] powerpc/mm: Allow more than 16 low slices
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <49148d07955d3e5f963cedf9adcfcc37c3e03ef4.1516179904.git.christophe.leroy@c-s.fr>
 <1c9752ac98fd3278ef448e2553053c287af42b3f.1516179904.git.christophe.leroy@c-s.fr>
 <87po66z1w2.fsf@linux.vnet.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <baf3a2db-3522-8419-0eda-ef62ad13d76e@c-s.fr>
Date: Fri, 19 Jan 2018 09:59:30 +0100
MIME-Version: 1.0
In-Reply-To: <87po66z1w2.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 19/01/2018 à 09:30, Aneesh Kumar K.V a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> While the implementation of the "slices" address space allows
>> a significant amount of high slices, it limits the number of
>> low slices to 16 due to the use of a single u64 low_slices_psize
>> element in struct mm_context_t
>>
>> On the 8xx, the minimum slice size is the size of the area
>> covered by a single PMD entry, ie 4M in 4K pages mode and 64M in
>> 16K pages mode. This means we could have resp. up to 1024 and 64
>> slices.
>>
>> In order to override this limitation, this patch switches the
>> handling of low_slices to BITMAPs as done already for high_slices.
> 
> Does it have a performance impact. When we switched high_slices
> that was one of the question asked. Now with a topdown search we should
> mostly be using the high_slices. But it will good to get numbers for
> ppc64 for this change.

It should have almost no performance impact at all, because all bitmap 
functions used a simplified way when the number of bits is small and 
constant:

-	ret->low_slices = 0;
+	slice_bitmap_zero(ret->low_slices, SLICE_NUM_LOW);


static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
{
	if (small_const_nbits(nbits))
		*dst = 0UL;
	else {
		unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
		memset(dst, 0, len);
	}
}



-	dst->low_slices |= src->low_slices;
+	slice_bitmap_or(dst->low_slices, dst->low_slices, src->low_slices,
+			SLICE_NUM_LOW);


static inline void bitmap_or(unsigned long *dst, const unsigned long *src1,
			const unsigned long *src2, unsigned int nbits)
{
	if (small_const_nbits(nbits))
		*dst = *src1 | *src2;
	else
		__bitmap_or(dst, src1, src2, nbits);
}


> 
> 
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   v2: Usign slice_bitmap_xxx() macros instead of bitmap_xxx() functions.
>>
>>   arch/powerpc/include/asm/book3s/64/mmu.h |   2 +-
>>   arch/powerpc/include/asm/mmu-8xx.h       |   2 +-
>>   arch/powerpc/include/asm/paca.h          |   2 +-
>>   arch/powerpc/kernel/paca.c               |   3 +-
>>   arch/powerpc/mm/hash_utils_64.c          |  13 ++--
>>   arch/powerpc/mm/slb_low.S                |   8 ++-
>>   arch/powerpc/mm/slice.c                  | 104 +++++++++++++++++--------------
>>   7 files changed, 74 insertions(+), 60 deletions(-)
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
> 
> Can that 8 be a #define?

Sure

> 
> 
>>   	unsigned char high_slices_psize[SLICE_ARRAY_SIZE];
>>   	unsigned long slb_addr_limit;
>>   #else
> 
> -aneesh
> 

Christophe
