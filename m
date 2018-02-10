Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zdw5Q5QlCzDqbd
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Feb 2018 01:57:30 +1100 (AEDT)
Subject: Re: [PATCH v4 1/5] powerpc/mm/slice: Remove intermediate bitmap copy
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, aneesh.kumar@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <01e8f783db8f4d4d41df91e0400a8634272b326f.1518226173.git.christophe.leroy@c-s.fr>
 <20180211004309.2eda56a3@roar.ozlabs.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <501bab56-c389-87c6-8d90-24b5b9fd5e67@c-s.fr>
Date: Sat, 10 Feb 2018 15:57:25 +0100
MIME-Version: 1.0
In-Reply-To: <20180211004309.2eda56a3@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 10/02/2018 à 15:43, Nicholas Piggin a écrit :
> On Sat, 10 Feb 2018 13:54:25 +0100 (CET)
> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> 
>> bitmap_or() and bitmap_andnot() can work properly with dst identical
>> to src1 or src2. There is no need of an intermediate result bitmap
>> that is copied back to dst in a second step.
> 
> Everyone seems to be working on the slice code all of a sudden. I
> had the same change in my series I just posted, but I didn't notice
> this one of yours earlier, and it's better split out, so this is
> fine by me.

Thanks,

I had a quick look at your serie, it looks promising.

The main purpose of mine is to allow the use of slies on the 8xx in 
order to fix a hugepage related bug.

Your serie is performance oriented and seems nice, indeed I should have 
noticed that it was passing huge structures instead of pointers to 
subfunctions. I will look at your serie more in details next week.

Christophe


> 
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> 
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>   v2: New in v2
>>   v3: patch moved up front of the serie to avoid ephemeral slice_bitmap_copy() function in following patch
>>   v4: No change
>>
>>   arch/powerpc/mm/slice.c | 12 ++++--------
>>   1 file changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
>> index 23ec2c5e3b78..98b53d48968f 100644
>> --- a/arch/powerpc/mm/slice.c
>> +++ b/arch/powerpc/mm/slice.c
>> @@ -388,21 +388,17 @@ static unsigned long slice_find_area(struct mm_struct *mm, unsigned long len,
>>   
>>   static inline void slice_or_mask(struct slice_mask *dst, struct slice_mask *src)
>>   {
>> -	DECLARE_BITMAP(result, SLICE_NUM_HIGH);
>> -
>>   	dst->low_slices |= src->low_slices;
>> -	bitmap_or(result, dst->high_slices, src->high_slices, SLICE_NUM_HIGH);
>> -	bitmap_copy(dst->high_slices, result, SLICE_NUM_HIGH);
>> +	bitmap_or(dst->high_slices, dst->high_slices, src->high_slices,
>> +		  SLICE_NUM_HIGH);
>>   }
>>   
>>   static inline void slice_andnot_mask(struct slice_mask *dst, struct slice_mask *src)
>>   {
>> -	DECLARE_BITMAP(result, SLICE_NUM_HIGH);
>> -
>>   	dst->low_slices &= ~src->low_slices;
>>   
>> -	bitmap_andnot(result, dst->high_slices, src->high_slices, SLICE_NUM_HIGH);
>> -	bitmap_copy(dst->high_slices, result, SLICE_NUM_HIGH);
>> +	bitmap_andnot(dst->high_slices, dst->high_slices, src->high_slices,
>> +		      SLICE_NUM_HIGH);
>>   }
>>   
>>   #ifdef CONFIG_PPC_64K_PAGES
