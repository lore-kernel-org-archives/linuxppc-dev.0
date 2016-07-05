Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rk6RB0XDszDqpJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 11:55:34 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH V2] powerpc/mm: Add validation for platform reserved
 memory ranges
In-Reply-To: <1457344559-2505-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1457344559-2505-1-git-send-email-khandual@linux.vnet.ibm.com>
Date: Tue, 05 Jul 2016 11:55:31 +1000
Message-ID: <87zipwetm4.fsf@@concordia.ellerman.id.au>
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

Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:

> For partition running on PHYP, there can be a adjunct partition
> which shares the virtual address range with the operating system.
> Virtual address ranges which can be used by the adjunct partition
> are communicated with virtual device node of the device tree with
> a property known as "ibm,reserved-virtual-addresses". This patch
> introduces a new function named 'validate_reserved_va_range' which
> is called  during initialization to validate that these reserved
> virtual address ranges do not overlap with the address ranges used
> by the kernel for all supported memory contexts. This helps prevent
> the possibility of getting return codes similar to H_RESOURCE for
> H_PROTECT hcalls for conflicting HPTE entries.

Have you tested this? The endian conversions look wrong to me.

> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index ba59d59..b47f667 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -1564,3 +1564,80 @@ void setup_initial_memory_limit(phys_addr_t first_memblock_base,
>  	/* Finally limit subsequent allocations */
>  	memblock_set_current_limit(ppc64_rma_size);
>  }
> +
> +/*
> + * PAPR says that each reserved virtual address range record
> + * contains three be32 elements which is of toal 12 bytes.
> + * First two be32 elements contain the abbreviated virtual
> + * address (high order 32 bits and low order 32 bits that
> + * generate the abbreviated virtual address of 64 bits which
> + * need to be concatenated with 24 bits of 0 at the end) and
> + * the third be32 element contains the size of the reserved
> + * virtual address range as number of consecutive 4K pages.
> + */
> +struct reserved_va_record {
> +	__be32	high_addr;
> +	__be32	low_addr;
> +	__be32	nr_pages_4K;
> +};

Here you define those fields as __be32.

> +/*
> + * Linux uses 65 bits (CONTEXT_BITS + ESID_BITS + SID_SHIFT)
> + * of virtual address. As reserved virtual address comes in
> + * as an abbreviated form (64 bits) from the device tree, we
> + * will use a partial address bit mask (65 >> 24) to match it
> + * for simplicity.
> + */
> +#define RVA_LESS_BITS		24
> +#define LINUX_VA_BITS		(CONTEXT_BITS + ESID_BITS + SID_SHIFT)
> +#define PARTIAL_LINUX_VA_MASK	((1ULL << (LINUX_VA_BITS - RVA_LESS_BITS)) - 1)
> +
> +static int __init validate_reserved_va_range(void)
> +{
> +	struct reserved_va_record rva;
> +	struct device_node *np;
> +	int records, ret, i;
> +	__be64 vaddr;
> +
> +	np = of_find_node_by_name(NULL, "vdevice");
> +	if (!np)
> +		return -ENODEV;
> +
> +	records = of_property_count_elems_of_size(np,
> +			"ibm,reserved-virtual-addresses",
> +				sizeof(struct reserved_va_record));
> +	if (records < 0)
> +		return records;
> +
> +	for (i = 0; i < records; i++) {
> +		ret = of_property_read_u32_index(np,
> +			"ibm,reserved-virtual-addresses",
> +				3 * i, &rva.high_addr);

But then here you use of_property_read_u32_index(), which does the
endian conversion (to CPU endian) for you.

> +		ret = of_property_read_u32_index(np,
> +			"ibm,reserved-virtual-addresses",
> +				3 * i + 1, &rva.low_addr);

> +		ret = of_property_read_u32_index(np,
> +			"ibm,reserved-virtual-addresses",
> +				3 * i + 2, &rva.nr_pages_4K);

So now all the values in rva are CPU endian.

> +		vaddr =  rva.high_addr;
> +		vaddr =  (vaddr << 32) | rva.low_addr;
> +		if (vaddr & cpu_to_be64(~PARTIAL_LINUX_VA_MASK))
> +			continue;

But then here you do the comparison against a __be64 value.

I know I told you to use "properly endian-annotated struct", but you
stil need to use the right conversions in the right places.

I think the best option is to use of_property_read_u32_array() and just
read the three 32 values into a CPU endian struct.

cheers
