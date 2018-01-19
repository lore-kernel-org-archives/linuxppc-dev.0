Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zNFVX2b8BzDqhf
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 20:13:23 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0J9Amqv121066
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 04:13:21 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fkdbwhcp9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 04:13:20 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 19 Jan 2018 02:13:20 -0700
Subject: Re: [PATCH v2 1/5] powerpc/mm: Enhance 'slice' for supporting PPC32
To: Christophe LEROY <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <49148d07955d3e5f963cedf9adcfcc37c3e03ef4.1516179904.git.christophe.leroy@c-s.fr>
 <87vafyz265.fsf@linux.vnet.ibm.com>
 <84dc1df4-db2f-be11-c1f3-5dddd1e44983@c-s.fr>
 <b4d8f01b-9ee1-ec34-aa0d-5a353064438c@linux.vnet.ibm.com>
 <28c3ba39-ef31-5ff3-7672-3e9d1942be94@c-s.fr>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Fri, 19 Jan 2018 14:43:11 +0530
MIME-Version: 1.0
In-Reply-To: <28c3ba39-ef31-5ff3-7672-3e9d1942be94@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <c9ab9a1b-4c77-fdfc-50d1-974388cc3b10@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 01/19/2018 02:37 PM, Christophe LEROY wrote:
> 
> 
> Le 19/01/2018 à 10:02, Aneesh Kumar K.V a écrit :
>>
>>
>> On 01/19/2018 02:14 PM, Christophe LEROY wrote:
>>>
>>>
>>> Le 19/01/2018 à 09:24, Aneesh Kumar K.V a écrit :
>>>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>>>
>>>>> In preparation for the following patch which will fix an issue on
>>>>> the 8xx by re-using the 'slices', this patch enhances the
>>>>> 'slices' implementation to support 32 bits CPUs.
>>>>>
>>>>> On PPC32, the address space is limited to 4Gbytes, hence only the low
>>>>> slices will be used. As of today, the code uses
>>>>> SLICE_LOW_TOP (0x100000000ul) and compares it with addr to determine
>>>>> if addr refers to low or high space.
>>>>> On PPC32, such a (addr < SLICE_LOW_TOP) test is always false because
>>>>> 0x100000000ul degrades to 0. Therefore, the patch modifies
>>>>> SLICE_LOW_TOP to (0xfffffffful) and modifies the tests to
>>>>> (addr <= SLICE_LOW_TOP) which will then always be true on PPC32
>>>>> as addr has type 'unsigned long' while not modifying the PPC64
>>>>> behaviour.
>>>>>
>>>>> This patch moves "slices" functions prototypes from page64.h to page.h
>>>>>
>>>>> The high slices use bitmaps. As bitmap functions are not prepared to
>>>>> handling bitmaps of size 0, the bitmap_xxx() calls are wrapped into
>>>>> slice_bitmap_xxx() macros which will take care of the 0 nbits case.
>>>>>
>>>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>>>> ---
>>>>>   v2: First patch of v1 serie split in two parts ; added 
>>>>> slice_bitmap_xxx() macros.
>>>>>
>>>>>   arch/powerpc/include/asm/page.h      | 14 +++++++++
>>>>>   arch/powerpc/include/asm/page_32.h   | 19 ++++++++++++
>>>>>   arch/powerpc/include/asm/page_64.h   | 21 ++-----------
>>>>>   arch/powerpc/mm/hash_utils_64.c      |  2 +-
>>>>>   arch/powerpc/mm/mmu_context_nohash.c |  7 +++++
>>>>>   arch/powerpc/mm/slice.c              | 60 
>>>>> ++++++++++++++++++++++++------------
>>>>>   6 files changed, 83 insertions(+), 40 deletions(-)
>>>>>
>>>>> diff --git a/arch/powerpc/include/asm/page.h 
>>>>> b/arch/powerpc/include/asm/page.h
>>>>> index 8da5d4c1cab2..d0384f9db9eb 100644
>>>>> --- a/arch/powerpc/include/asm/page.h
>>>>> +++ b/arch/powerpc/include/asm/page.h
>>>>> @@ -342,6 +342,20 @@ typedef struct page *pgtable_t;
>>>>>   #endif
>>>>>   #endif
>>>>> +#ifdef CONFIG_PPC_MM_SLICES
>>>>> +struct mm_struct;
>>>>> +
>>>>> +unsigned long slice_get_unmapped_area(unsigned long addr, unsigned 
>>>>> long len,
>>>>> +                      unsigned long flags, unsigned int psize,
>>>>> +                      int topdown);
>>>>> +
>>>>> +unsigned int get_slice_psize(struct mm_struct *mm, unsigned long 
>>>>> addr);
>>>>> +
>>>>> +void slice_set_user_psize(struct mm_struct *mm, unsigned int psize);
>>>>> +void slice_set_range_psize(struct mm_struct *mm, unsigned long start,
>>>>> +               unsigned long len, unsigned int psize);
>>>>> +#endif
>>>>> +
>>>>
>>>> Should we do a slice.h ? the way we have other files? and then do
>>>
>>> Yes we could add a slice.h instead of using page.h for that, good idea.
>>>
>>>>
>>>> arch/powerpc/include/asm/book3s/64/slice.h that will carry
>>>> #define slice_bitmap_zero(dst, nbits) \
>>>>     do { if (nbits) bitmap_zero(dst, nbits); } while (0)
>>>> #define slice_bitmap_set(dst, pos, nbits) \
>>>> do { if (nbits) bitmap_set(dst, pos, nbits); } while (0)
>>>> #define slice_bitmap_copy(dst, src, nbits) \
>>>> do { if (nbits) bitmap_copy(dst, src, nbits); } while (0)
>>>> #define slice_bitmap_and(dst, src1, src2, nbits) \
>>>>     ({ (nbits) ? bitmap_and(dst, src1, src2, nbits) : 0; })
>>>> #define slice_bitmap_or(dst, src1, src2, nbits) \
>>>>     do { if (nbits) bitmap_or(dst, src1, src2, nbits); } while (0)
>>>> #define slice_bitmap_andnot(dst, src1, src2, nbits) \
>>>>     ({ (nbits) ? bitmap_andnot(dst, src1, src2, nbits) : 0; })
>>>> #define slice_bitmap_equal(src1, src2, nbits) \
>>>>     ({ (nbits) ? bitmap_equal(src1, src2, nbits) : 1; })
>>>> #define slice_bitmap_empty(src, nbits) \
>>>>     ({ (nbits) ? bitmap_empty(src, nbits) : 1; })
>>>>
>>>> This without that if(nbits) check and a proper static inline so that we
>>>> can do type checking.
>>>
>>> Is it really worth duplicating that just for eliminating the 'if 
>>> (nbits)' in one case ?
>>>
>>> Only in book3s/64 we will be able to eliminate that, for nohash/32 we 
>>> need to keep the test due to the difference between low and high slices.
>>
>> the other advantage is we move the SLICE_LOW_SHIFT to the right 
>> location. IMHO mm subystem is really complex with these really 
>> overloaded headers. If we can keep it  seperate we should with minimal 
>> code duplication?
> 
> For the constants I fully agree with your proposal and I will do it. I 
> was only questionning the benefit of moving the slice_bitmap_xxxx() 
> stuff, taking into account that the 'if (nbits)' test is already 
> eliminated by the compiler.
> 

That is compiler dependent as you are finding with the other patch where 
if (0) didn't get compiled out

-aneesh
