Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C96D31A0B4C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 23:10:55 +1100 (AEDT)
In-Reply-To: <1456908372-18876-1-git-send-email-khandual@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [RFC] powerpc/mm: Add validation for platform reserved memory
 ranges
Message-Id: <20160302121055.B3D69140784@ozlabs.org>
Date: Wed,  2 Mar 2016 23:10:55 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-02-03 at 08:46:12 UTC, Anshuman Khandual wrote:
> For partition running on PHYP, there can be a adjunct partition
> which shares the virtual address range with the operating system.
> Virtual address ranges which can be used by the adjunct partition
> are communicated with virtual device node of the device tree with
> a property known as "ibm,reserved-virtual-addresses". This patch
> introduces a new function named 'validate_reserved_va_range' which
> is called inside 'setup_system' to validate that these reserved
> virtual address ranges do not overlap with the address ranges used
> by the kernel for all supported memory contexts. This helps prevent
> the possibility of getting return codes similar to H_RESOURCE for
> H_PROTECT hcalls for conflicting HPTE entries.

Good plan.

> diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
> index 3d5abfe..95257c1 100644
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index 5c03a6a..04bc592 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -546,6 +546,8 @@ void __init setup_system(void)
>  	smp_release_cpus();
>  #endif
>  
> +	validate_reserved_va_range();
> +

I don't see why this can't just be an initcall in hash_utils_64.c, rather than
being called from here.

>  	pr_info("Starting Linux %s %s\n", init_utsname()->machine,
>  		 init_utsname()->version);
>  
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index ba59d59..03adafc 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -810,6 +810,57 @@ void __init early_init_mmu(void)
>  	slb_initialize();
>  }
>  
> +/*
> + * PAPR says that each record contains 3 * 32 bit element, hence 12 bytes.
> + * First two element contains the abbreviated virtual address (high order
> + * 32 bits and low order 32 bits generates the abbreviated virtual address
> + * of 64 bits which need to be concatenated with 12 bits of 0 at the end
> + * to generate the actual 76 bit reserved virtual address) and size of the
> + * reserved virtual address range is encoded in next 32 bit element as number
> + * of 4K pages.
> + */
> +#define	BYTES_PER_RVA_RECORD	12

Please define a properly endian-annotated struct which encodes the layout.

It can be local to the function if that works.

> +/*
> + * Linux uses 65 bits (MAX_PHYSMEM_BITS + CONTEXT_BITS) from available 78
> + * bit wide virtual address range. As reserved virtual address range comes
> + * as an abbreviated form of 64 bits, we will use a partial address mask
> + * (65 bit mask >> 12) to match it for simplicity.
> + */
> +#define	PARTIAL_USED_VA_MASK	0x1FFFFFFFFFFFFFULL

Please calculate this from the appropriate constants. We don't want to have to
update it in future.

> +void __init validate_reserved_va_range(void)
> +{
> +	struct device_node *np;
> +	struct property *prop;
> +	unsigned int size, count, i;
> +	const __be32 *value;
> +	__be64 vaddr;
> +
> +	np = of_find_node_by_name(NULL, "vdevice");
> +	if (!np)
> +		return;
> +
> +	prop = of_find_property(np, "ibm,reserved-virtual-addresses", NULL);
> +	if (!prop)
> +		return;

You don't need to do a find, the get below will do it for you.

> +	value = of_get_property(np, "ibm,reserved-virtual-addresses", &size);
> +	if (!value)
> +		return;
> +
> +	count = size / BYTES_PER_RVA_RECORD;
> +	for (i = 0; i < count; i++) {
> +		vaddr = ((__be64) value[i * 3] << 32) | value[i * 3 + 1];
> +		if (vaddr & ~PARTIAL_USED_VA_MASK) {

How can it work to test a __be64 against a non-byte-swapped mask ? But like I
said above, please do this with a struct and proper endian conversions.

> +			pr_info("Reserved virtual address range starting "
> +				"at [%llx000] verified for overlap\n", vaddr);

This should print nothing in the success case.

> +			continue;
> +		}
> +		BUG_ON("Reserved virtual address range overlapping");

But here you should provide more detail. The first thing a debugger will need
to know is what address overlapped.

cheers
