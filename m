Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLbZx5Q33zDqMg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 03:41:29 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0GGfLEg132652
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jan 2018 11:41:27 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2fhku8cbqe-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jan 2018 11:41:26 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 16 Jan 2018 09:41:24 -0700
Subject: Re: [PATCH 1/3] powerpc/32: Fix hugepage allocation on 8xx at hint
 address
To: Christophe LEROY <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <9a5dadc10f88e2fc0ac9fb5d18c5424df33f3f4c.1515169256.git.christophe.leroy@c-s.fr>
 <876081by7g.fsf@linux.vnet.ibm.com>
 <b5e34a5b-94b8-9405-929d-d35dde3fcb3b@c-s.fr>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 16 Jan 2018 22:11:09 +0530
MIME-Version: 1.0
In-Reply-To: <b5e34a5b-94b8-9405-929d-d35dde3fcb3b@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <945affcd-b25c-bc6e-68e5-8bbbcd31c0fd@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 01/16/2018 10:01 PM, Christophe LEROY wrote:
> 
>>> diff --git a/arch/powerpc/include/asm/page_64.h 
>>> b/arch/powerpc/include/asm/page_64.h
>>> index 56234c6fcd61..a7baef5bbe5f 100644
>>> --- a/arch/powerpc/include/asm/page_64.h
>>> +++ b/arch/powerpc/include/asm/page_64.h
>>> @@ -91,30 +91,13 @@ extern u64 ppc64_pft_size;
>>>   #define SLICE_LOW_SHIFT        28
>>>   #define SLICE_HIGH_SHIFT    40
>>> -#define SLICE_LOW_TOP        (0x100000000ul)
>>> -#define SLICE_NUM_LOW        (SLICE_LOW_TOP >> SLICE_LOW_SHIFT)
>>> +#define SLICE_LOW_TOP        (0xfffffffful)
>>> +#define SLICE_NUM_LOW        ((SLICE_LOW_TOP >> SLICE_LOW_SHIFT) + 1)
>>>   #define SLICE_NUM_HIGH        (H_PGTABLE_RANGE >> SLICE_HIGH_SHIFT)
>>
>>
>> Why are you changing this? is this a bug fix?
> 
> That's because 0x100000000ul is out of range of unsigned long on PPC32.

Ok that detail was important. I missed that.

> 
>>
>>>   #define GET_LOW_SLICE_INDEX(addr)    ((addr) >> SLICE_LOW_SHIFT)
>>>   #define GET_HIGH_SLICE_INDEX(addr)    ((addr) >> SLICE_HIGH_SHIFT)
>>> -#ifndef __ASSEMBLY__
>>> -struct mm_struct;
>>> -
>>> -extern unsigned long slice_get_unmapped_area(unsigned long addr,
>>> -                         unsigned long len,
>>> -                         unsigned long flags,
>>> -                         unsigned int psize,
>>> -                         int topdown);
>>> -
>>> -extern unsigned int get_slice_psize(struct mm_struct *mm,
>>> -                    unsigned long addr);
>>> -
>>> -extern void slice_set_user_psize(struct mm_struct *mm, unsigned int 
>>> psize);
>>> -extern void slice_set_range_psize(struct mm_struct *mm, unsigned 
>>> long start,
>>> -                  unsigned long len, unsigned int psize);
>>> -
>>> -#endif /* __ASSEMBLY__ */
>>>   #else
>>>   #define slice_init()
>>>   #ifdef CONFIG_PPC_BOOK3S_64
>>> diff --git a/arch/powerpc/kernel/setup-common.c 
>>> b/arch/powerpc/kernel/setup-common.c
>>> index 9d213542a48b..a285e1067713 100644
>>> --- a/arch/powerpc/kernel/setup-common.c
>>> +++ b/arch/powerpc/kernel/setup-common.c
>>> @@ -928,7 +928,7 @@ void __init setup_arch(char **cmdline_p)
>>>       if (!radix_enabled())
>>>           init_mm.context.slb_addr_limit = DEFAULT_MAP_WINDOW_USER64;
>>>   #else
>>> -#error    "context.addr_limit not initialized."
>>> +    init_mm.context.slb_addr_limit = DEFAULT_MAP_WINDOW;
>>>   #endif
>>
>>
>> May be put this within #ifdef 8XX and retain the error?
> 
> Is this error really worth it ?
> I wanted to avoid spreading too many #ifdef PPC_8xx, but ok I can do that.
> 
>>
>>>   #endif
>>> diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
>>> index f29212e40f40..0be77709446c 100644
>>> --- a/arch/powerpc/mm/8xx_mmu.c
>>> +++ b/arch/powerpc/mm/8xx_mmu.c
>>> @@ -192,7 +192,7 @@ void set_context(unsigned long id, pgd_t *pgd)
>>>       mtspr(SPRN_M_TW, __pa(pgd) - offset);
>>>       /* Update context */
>>> -    mtspr(SPRN_M_CASID, id);
>>> +    mtspr(SPRN_M_CASID, id - 1);
>>>       /* sync */
>>>       mb();
>>>   }
>>> diff --git a/arch/powerpc/mm/hash_utils_64.c 
>>> b/arch/powerpc/mm/hash_utils_64.c
>>> index 655a5a9a183d..3266b3326088 100644
>>> --- a/arch/powerpc/mm/hash_utils_64.c
>>> +++ b/arch/powerpc/mm/hash_utils_64.c
>>> @@ -1101,7 +1101,7 @@ static unsigned int get_paca_psize(unsigned 
>>> long addr)
>>>       unsigned char *hpsizes;
>>>       unsigned long index, mask_index;
>>> -    if (addr < SLICE_LOW_TOP) {
>>> +    if (addr <= SLICE_LOW_TOP) {
>>
>> If this is part of bug fix, please do it as part of seperate patch 
>> with details
> 
> As explained above, in order to allow comparison to work on PPC32, 
> SLICE_LOW_TOP has to be 0xffffffff instead of 0x100000000
> 
> How should I split in separate patches ? Something like ?
> 1/ Slice support for PPC32 > 2/ Activate slice for 8xx

Yes something like that. Will you  be able to avoid that
  if (SLICE_NUM_HIGH) from the code? That makes the code ugly. Right now 
i don't have definite suggestion on what we could do though.


-aneesh
