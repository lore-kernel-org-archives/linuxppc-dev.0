Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ED9EF1A045D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 15:00:58 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 4 Mar 2016 14:00:51 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B73D23578053
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 15:00:34 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2440QP657606156
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 15:00:34 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u24402oN017331
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 15:00:02 +1100
Message-ID: <56D90830.3060102@linux.vnet.ibm.com>
Date: Fri, 04 Mar 2016 09:29:44 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
CC: aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [RFC] powerpc/mm: Add validation for platform reserved memory
 ranges
References: <20160302121055.B3D69140784@ozlabs.org>
In-Reply-To: <20160302121055.B3D69140784@ozlabs.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/02/2016 05:40 PM, Michael Ellerman wrote:
> On Wed, 2016-02-03 at 08:46:12 UTC, Anshuman Khandual wrote:
>> For partition running on PHYP, there can be a adjunct partition
>> which shares the virtual address range with the operating system.
>> Virtual address ranges which can be used by the adjunct partition
>> are communicated with virtual device node of the device tree with
>> a property known as "ibm,reserved-virtual-addresses". This patch
>> introduces a new function named 'validate_reserved_va_range' which
>> is called inside 'setup_system' to validate that these reserved
>> virtual address ranges do not overlap with the address ranges used
>> by the kernel for all supported memory contexts. This helps prevent
>> the possibility of getting return codes similar to H_RESOURCE for
>> H_PROTECT hcalls for conflicting HPTE entries.
> 
> Good plan.

Thanks !

> 
>> diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
>> index 3d5abfe..95257c1 100644
>> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
>> index 5c03a6a..04bc592 100644
>> --- a/arch/powerpc/kernel/setup_64.c
>> +++ b/arch/powerpc/kernel/setup_64.c
>> @@ -546,6 +546,8 @@ void __init setup_system(void)
>>  	smp_release_cpus();
>>  #endif
>>  
>> +	validate_reserved_va_range();
>> +
> 
> I don't see why this can't just be an initcall in hash_utils_64.c, rather than
> being called from here.

That works, will change it.

> 
>>  	pr_info("Starting Linux %s %s\n", init_utsname()->machine,
>>  		 init_utsname()->version);
>>  
>> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
>> index ba59d59..03adafc 100644
>> --- a/arch/powerpc/mm/hash_utils_64.c
>> +++ b/arch/powerpc/mm/hash_utils_64.c
>> @@ -810,6 +810,57 @@ void __init early_init_mmu(void)
>>  	slb_initialize();
>>  }
>>  
>> +/*
>> + * PAPR says that each record contains 3 * 32 bit element, hence 12 bytes.
>> + * First two element contains the abbreviated virtual address (high order
>> + * 32 bits and low order 32 bits generates the abbreviated virtual address
>> + * of 64 bits which need to be concatenated with 12 bits of 0 at the end
>> + * to generate the actual 76 bit reserved virtual address) and size of the
>> + * reserved virtual address range is encoded in next 32 bit element as number
>> + * of 4K pages.
>> + */
>> +#define	BYTES_PER_RVA_RECORD	12
> 
> Please define a properly endian-annotated struct which encodes the layout.

something like this ?

struct reserved_va_record {
	__be32	high_addr;	/* High 32 bits of the abbreviated VA */
	__be32	low_addr;	/* Low 32 bits of the abbreviated VA */
	__be32	nr_4k;		/* VA range in multiple of 4K pages */
};

> 
> It can be local to the function if that works.
> 

Okay.

>> +/*
>> + * Linux uses 65 bits (MAX_PHYSMEM_BITS + CONTEXT_BITS) from available 78
>> + * bit wide virtual address range. As reserved virtual address range comes
>> + * as an abbreviated form of 64 bits, we will use a partial address mask
>> + * (65 bit mask >> 12) to match it for simplicity.
>> + */
>> +#define	PARTIAL_USED_VA_MASK	0x1FFFFFFFFFFFFFULL
> 
> Please calculate this from the appropriate constants. We don't want to have to
> update it in future.

Sure, I guess something like this works.

#define RVA_SKIPPED_BITS        12      /* This changes with PAPR */
#define USED_VA_BITS            MAX_PHYSMEM_BITS + CONTEXT_BITS
#define PARTIAL_USED_VA_MASK    ((1ULL << (USED_VA_BITS - RVA_SKIPPED_BITS)) - 1)

> 
>> +void __init validate_reserved_va_range(void)
>> +{
>> +	struct device_node *np;
>> +	struct property *prop;
>> +	unsigned int size, count, i;
>> +	const __be32 *value;
>> +	__be64 vaddr;
>> +
>> +	np = of_find_node_by_name(NULL, "vdevice");
>> +	if (!np)
>> +		return;
>> +
>> +	prop = of_find_property(np, "ibm,reserved-virtual-addresses", NULL);
>> +	if (!prop)
>> +		return;
> 
> You don't need to do a find, the get below will do it for you.

Sure.

> 
>> +	value = of_get_property(np, "ibm,reserved-virtual-addresses", &size);
>> +	if (!value)
>> +		return;
>> +
>> +	count = size / BYTES_PER_RVA_RECORD;
>> +	for (i = 0; i < count; i++) {
>> +		vaddr = ((__be64) value[i * 3] << 32) | value[i * 3 + 1];
>> +		if (vaddr & ~PARTIAL_USED_VA_MASK) {
> 
> How can it work to test a __be64 against a non-byte-swapped mask ? But like I
> said above, please do this with a struct and proper endian conversions.

sure.

> 
>> +			pr_info("Reserved virtual address range starting "
>> +				"at [%llx000] verified for overlap\n", vaddr);
> 
> This should print nothing in the success case.

Not even as a pr_devel level message ? 

> 
>> +			continue;
>> +		}
>> +		BUG_ON("Reserved virtual address range overlapping");
> 
> But here you should provide more detail. The first thing a debugger will need
> to know is what address overlapped.

Sure, will provide the starting VA and the size of the range.
