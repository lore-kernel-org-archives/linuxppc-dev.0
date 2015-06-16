Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7FF351A06C7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2015 02:00:39 +1000 (AEST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 16 Jun 2015 21:30:37 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id A4BDB394005A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2015 21:30:33 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5GG0O9o53149700
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2015 21:30:25 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5GG0NGe007167
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2015 21:30:24 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, benh@kernel.crashing.org,
 paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [V2] powerpc/mm: Limit the max memory we can support
In-Reply-To: <20150611092312.14C161402B2@ozlabs.org>
References: <20150611092312.14C161402B2@ozlabs.org>
Date: Tue, 16 Jun 2015 21:30:21 +0530
Message-ID: <87fv5rhcdm.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> On Fri, 2015-29-05 at 08:20:18 UTC, "Aneesh Kumar K.V" wrote:
>> We need to limit the max memory based on Linux page table format.
>> Add checks to limit memory based on pte size. Also limit the memory
>> based on MAX_PHSYSMEM_BITS.
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>> Changes from V1:
>> * Update commit message. 4K can handle 64TB
>> * Also limit based on MAX_PHSYSMEM_BITS
>> 
>>  arch/powerpc/include/asm/mmu.h       |  8 ++++++++
>>  arch/powerpc/include/asm/sparsemem.h |  2 --
>>  arch/powerpc/kernel/prom.c           | 25 ++++++++++++++++++++++---
>>  3 files changed, 30 insertions(+), 5 deletions(-)
>> 
>> diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
>> index 3d5abfe6ba67..d44d49093c8d 100644
>> --- a/arch/powerpc/include/asm/mmu.h
>> +++ b/arch/powerpc/include/asm/mmu.h
>> @@ -200,6 +200,14 @@ static inline void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
>>  #  include <asm/mmu-8xx.h>
>>  #endif
>>  
>> +#ifdef CONFIG_PHYS_64BIT
>> +/*
>> + * Max supported memory on 64bit system is 64TB.
>
> Can you document in the comment where the limit comes from?

Will update the patch addressing all your feedback. But I would request
to drop this patch from the series for now. We need further fixes [1] in
this area and I will do a separate series addressing all the issues.

[1] Right now we ALIGN the total memory with PAGE_SIZE. That is not
really correct if we end up doing kernel linear mapping with 16MB size. 

>
>> + */
>> +#define MAX_PHYSMEM_BITS        46
>> +#else
>> +#define MAX_PHYSMEM_BITS        32
>> +#endif
>>  
>>  #endif /* __KERNEL__ */
>>  #endif /* _ASM_POWERPC_MMU_H_ */
>> diff --git a/arch/powerpc/include/asm/sparsemem.h b/arch/powerpc/include/asm/sparsemem.h
>> index f6fc0ee813d7..fc3808378893 100644
>> --- a/arch/powerpc/include/asm/sparsemem.h
>> +++ b/arch/powerpc/include/asm/sparsemem.h
>> @@ -11,8 +11,6 @@
>>  #define SECTION_SIZE_BITS       24
>>  
>>  #define MAX_PHYSADDR_BITS       46
>> -#define MAX_PHYSMEM_BITS        46
>
> Is there now no link between those two?
>
>>  #ifdef CONFIG_MEMORY_HOTPLUG
>> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
>> index 308c5e15676b..c09315b32ca7 100644
>> --- a/arch/powerpc/kernel/prom.c
>> +++ b/arch/powerpc/kernel/prom.c
>> @@ -698,9 +698,28 @@ void __init early_init_devtree(void *params)
>>  #endif
>>  		reserve_crashkernel();
>>  	early_reserve_mem();
>> -
>> -	/* Ensure that total memory size is page-aligned. */
>> -	limit = ALIGN(memory_limit ?: memblock_phys_mem_size(), PAGE_SIZE);
>> +	/*
>> +	 * if not specified limit the memory based on the pfn count that
>> +	 * we can fit in pte_t. Also ensure that total memory size is
>> +	 * page-aligned.
>
> Shouldn't you do the logic below even if memory_limit is specified? Otherwise
> someone can specify a really large memory_limit which will then overflow.
>
>> +	 */
>> +	if (!memory_limit) {
>> +		int bit_count;
>> +		phys_addr_t pte_mem_limit;
>> +
>> +		limit = memblock_phys_mem_size();
>> +		if (limit >= (1ULL << MAX_PHYSMEM_BITS))
>> +			limit = (1ULL << MAX_PHYSMEM_BITS) - 1;
>> +
>> +		BUILD_BUG_ON(sizeof(pte_basic_t) > 8);
>> +		bit_count = (sizeof(pte_basic_t) * 8) - PTE_RPN_SHIFT + PAGE_SHIFT;
>> +		pte_mem_limit = ~0ULL >> (64 - bit_count);
>
> It's fairly obvious what you're doing here, but a bit of a comment wouldn't hurt.
>
>> +		if (limit > pte_mem_limit)
>> +			limit = pte_mem_limit;
>> +	} else
>> +		limit = memory_limit;
>> +
>> +	limit = ALIGN(limit, PAGE_SIZE);
>
> cheers
