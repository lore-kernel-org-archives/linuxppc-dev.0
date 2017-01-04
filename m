Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttdyt2xJGzDqGs
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 16:04:37 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v0454ZCx022661
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jan 2017 00:04:35 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27rkvymutc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Jan 2017 00:04:34 -0500
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 3 Jan 2017 22:04:32 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Reza Arbab <arbab@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, Balbir Singh <bsingharora@gmail.com>,
 Alistair Popple <apopple@au1.ibm.com>
Subject: Re: [PATCH v4 1/4] powerpc/mm: refactor radix physical page mapping
In-Reply-To: <1483476218-17271-2-git-send-email-arbab@linux.vnet.ibm.com>
References: <1483476218-17271-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1483476218-17271-2-git-send-email-arbab@linux.vnet.ibm.com>
Date: Wed, 04 Jan 2017 10:34:25 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <878tqr76w6.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Reza Arbab <arbab@linux.vnet.ibm.com> writes:

> Move the page mapping code in radix_init_pgtable() into a separate
> function that will also be used for memory hotplug.
>
> The current goto loop progressively decreases its mapping size as it
> covers the tail of a range whose end is unaligned. Change this to a for
> loop which can do the same for both ends of the range.
>

We lost the below in the change.

		pr_info("Mapping range 0x%lx - 0x%lx with 0x%lx\n",
			(unsigned long)base, (unsigned long)end,
			linear_page_size);


Is there a way to dump the range and the size with which we mapped that
range ?


> Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/pgtable-radix.c | 69 ++++++++++++++++++-----------------------
>  1 file changed, 31 insertions(+), 38 deletions(-)
>
> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> index 623a0dc..5cee6d1 100644
> --- a/arch/powerpc/mm/pgtable-radix.c
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -107,54 +107,47 @@ int radix__map_kernel_page(unsigned long ea, unsigned long pa,
>  	return 0;
>  }
>
> +static int __meminit create_physical_mapping(unsigned long start,
> +					     unsigned long end)
> +{
> +	unsigned long mapping_size;
> +
> +	start = _ALIGN_UP(start, PAGE_SIZE);
> +	for (; start < end; start += mapping_size) {
> +		unsigned long gap = end - start;
> +		int rc;
> +
> +		if (IS_ALIGNED(start, PUD_SIZE) && gap >= PUD_SIZE &&
> +		    mmu_psize_defs[MMU_PAGE_1G].shift)
> +			mapping_size = PUD_SIZE;
> +		else if (IS_ALIGNED(start, PMD_SIZE) && gap >= PMD_SIZE &&
> +			 mmu_psize_defs[MMU_PAGE_2M].shift)
> +			mapping_size = PMD_SIZE;
> +		else
> +			mapping_size = PAGE_SIZE;
> +
> +		rc = radix__map_kernel_page((unsigned long)__va(start), start,
> +					    PAGE_KERNEL_X, mapping_size);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
>  static void __init radix_init_pgtable(void)
>  {
> -	int loop_count;
> -	u64 base, end, start_addr;
>  	unsigned long rts_field;
>  	struct memblock_region *reg;
> -	unsigned long linear_page_size;
>
>  	/* We don't support slb for radix */
>  	mmu_slb_size = 0;
>  	/*
>  	 * Create the linear mapping, using standard page size for now
>  	 */
> -	loop_count = 0;
> -	for_each_memblock(memory, reg) {
> -
> -		start_addr = reg->base;
> -
> -redo:
> -		if (loop_count < 1 && mmu_psize_defs[MMU_PAGE_1G].shift)
> -			linear_page_size = PUD_SIZE;
> -		else if (loop_count < 2 && mmu_psize_defs[MMU_PAGE_2M].shift)
> -			linear_page_size = PMD_SIZE;
> -		else
> -			linear_page_size = PAGE_SIZE;
> -
> -		base = _ALIGN_UP(start_addr, linear_page_size);
> -		end = _ALIGN_DOWN(reg->base + reg->size, linear_page_size);
> -
> -		pr_info("Mapping range 0x%lx - 0x%lx with 0x%lx\n",
> -			(unsigned long)base, (unsigned long)end,
> -			linear_page_size);
> -
> -		while (base < end) {
> -			radix__map_kernel_page((unsigned long)__va(base),
> -					      base, PAGE_KERNEL_X,
> -					      linear_page_size);
> -			base += linear_page_size;
> -		}
> -		/*
> -		 * map the rest using lower page size
> -		 */
> -		if (end < reg->base + reg->size) {
> -			start_addr = end;
> -			loop_count++;
> -			goto redo;
> -		}
> -	}
> +	for_each_memblock(memory, reg)
> +		WARN_ON(create_physical_mapping(reg->base,
> +						reg->base + reg->size));
>  	/*
>  	 * Allocate Partition table and process table for the
>  	 * host.
> -- 
> 1.8.3.1
