Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 33F711A0341
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 16:47:11 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 4 Mar 2016 15:47:09 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 1F2922BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 16:47:07 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u245kwfo54001856
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 16:47:07 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u245kYXq005355
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 16:46:34 +1100
Message-ID: <56D92128.7060304@linux.vnet.ibm.com>
Date: Fri, 04 Mar 2016 11:16:16 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC] powerpc/mm: Add validation for platform reserved memory
 ranges
References: <20160302121055.B3D69140784@ozlabs.org>
 <56D90830.3060102@linux.vnet.ibm.com> <87si06q249.fsf@linux.vnet.ibm.com>
In-Reply-To: <87si06q249.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/04/2016 10:19 AM, Aneesh Kumar K.V wrote:
> Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:
> 
>> On 03/02/2016 05:40 PM, Michael Ellerman wrote:
>>> On Wed, 2016-02-03 at 08:46:12 UTC, Anshuman Khandual wrote:
>>>> For partition running on PHYP, there can be a adjunct partition
>>>> which shares the virtual address range with the operating system.
>>>> Virtual address ranges which can be used by the adjunct partition
>>>> are communicated with virtual device node of the device tree with
>>>> a property known as "ibm,reserved-virtual-addresses". This patch
>>>> introduces a new function named 'validate_reserved_va_range' which
>>>> is called inside 'setup_system' to validate that these reserved
>>>> virtual address ranges do not overlap with the address ranges used
>>>> by the kernel for all supported memory contexts. This helps prevent
>>>> the possibility of getting return codes similar to H_RESOURCE for
>>>> H_PROTECT hcalls for conflicting HPTE entries.
>>>
>>> Good plan.
>>
>> Thanks !
>>
>>>
>>>> diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
>>>> index 3d5abfe..95257c1 100644
>>>> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
>>>> index 5c03a6a..04bc592 100644
>>>> --- a/arch/powerpc/kernel/setup_64.c
>>>> +++ b/arch/powerpc/kernel/setup_64.c
>>>> @@ -546,6 +546,8 @@ void __init setup_system(void)
>>>>  	smp_release_cpus();
>>>>  #endif
>>>>  
>>>> +	validate_reserved_va_range();
>>>> +
>>>
>>> I don't see why this can't just be an initcall in hash_utils_64.c, rather than
>>> being called from here.
>>
>> That works, will change it.
>>
>>>
>>>>  	pr_info("Starting Linux %s %s\n", init_utsname()->machine,
>>>>  		 init_utsname()->version);
>>>>  
>>>> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
>>>> index ba59d59..03adafc 100644
>>>> --- a/arch/powerpc/mm/hash_utils_64.c
>>>> +++ b/arch/powerpc/mm/hash_utils_64.c
>>>> @@ -810,6 +810,57 @@ void __init early_init_mmu(void)
>>>>  	slb_initialize();
>>>>  }
>>>>  
>>>> +/*
>>>> + * PAPR says that each record contains 3 * 32 bit element, hence 12 bytes.
>>>> + * First two element contains the abbreviated virtual address (high order
>>>> + * 32 bits and low order 32 bits generates the abbreviated virtual address
>>>> + * of 64 bits which need to be concatenated with 12 bits of 0 at the end
>>>> + * to generate the actual 76 bit reserved virtual address) and size of the
>>>> + * reserved virtual address range is encoded in next 32 bit element as number
>>>> + * of 4K pages.
>>>> + */
>>>> +#define	BYTES_PER_RVA_RECORD	12
>>>
>>> Please define a properly endian-annotated struct which encodes the layout.
>>
>> something like this ?
>>
>> struct reserved_va_record {
>> 	__be32	high_addr;	/* High 32 bits of the abbreviated VA */
>> 	__be32	low_addr;	/* Low 32 bits of the abbreviated VA */
>> 	__be32	nr_4k;		/* VA range in multiple of 4K pages */
>> };
>>
>>>
>>> It can be local to the function if that works.
>>>
>>
>> Okay.
>>
>>>> +/*
>>>> + * Linux uses 65 bits (MAX_PHYSMEM_BITS + CONTEXT_BITS) from available 78
>>>> + * bit wide virtual address range. As reserved virtual address range comes
>>>> + * as an abbreviated form of 64 bits, we will use a partial address mask
>>>> + * (65 bit mask >> 12) to match it for simplicity.
>>>> + */
>>>> +#define	PARTIAL_USED_VA_MASK	0x1FFFFFFFFFFFFFULL
>>>
>>> Please calculate this from the appropriate constants. We don't want to have to
>>> update it in future.
>>
>> Sure, I guess something like this works.
>>
>> #define RVA_SKIPPED_BITS        12      /* This changes with PAPR */
>> #define USED_VA_BITS            MAX_PHYSMEM_BITS + CONTEXT_BITS
> 
> context + esid + sid shift it should be

Yeah its more appropriate but but we dont have any constants like
ESID_SHIFT (or ESID_SHIFT_1T) to match SID_SHIFT (or SID_SHIFT_1T)
which adds up to 46 bits of EA.
