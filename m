Return-Path: <srs0=kvdi=hm=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40V5xR4r0WzDqvH
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2018 22:53:47 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40V5xR32BRz8svW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2018 22:53:47 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40V5xQ30fXz9rxs
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2018 22:53:46 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3NCnKvl108775
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2018 08:53:43 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hhdp167ba-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2018 08:53:41 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Mon, 23 Apr 2018 13:53:40 +0100
Subject: Re: [PATCH v4 4/7] powerpc/fadump: Reservationless firmware assisted
 dump
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Ananth Narayan <ananth@in.ibm.com>, kernelfans@gmail.com,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <152420062000.31037.770773018944092449.stgit@jupiter.in.ibm.com>
 <152420068315.31037.10792452404355231147.stgit@jupiter.in.ibm.com>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Mon, 23 Apr 2018 18:23:35 +0530
MIME-Version: 1.0
In-Reply-To: <152420068315.31037.10792452404355231147.stgit@jupiter.in.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <715a2407-2a62-4c5a-7a1a-7c0dbdf0cd43@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Friday 20 April 2018 10:34 AM, Mahesh J Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>
> One of the primary issues with Firmware Assisted Dump (fadump) on Power
> is that it needs a large amount of memory to be reserved. On large
> systems with TeraBytes of memory, this reservation can be quite
> significant.
>
> In some cases, fadump fails if the memory reserved is insufficient, or
> if the reserved memory was DLPAR hot-removed.
>
> In the normal case, post reboot, the preserved memory is filtered to
> extract only relevant areas of interest using the makedumpfile tool.
> While the tool provides flexibility to determine what needs to be part
> of the dump and what memory to filter out, all supported distributions
> default this to "Capture only kernel data and nothing else".
>
> We take advantage of this default and the Linux kernel's Contiguous
> Memory Allocator (CMA) to fundamentally change the memory reservation
> model for fadump.
>
> Instead of setting aside a significant chunk of memory nobody can use,
> this patch uses CMA instead, to reserve a significant chunk of memory
> that the kernel is prevented from using (due to MIGRATE_CMA), but
> applications are free to use it. With this fadump will still be able
> to capture all of the kernel memory and most of the user space memory
> except the user pages that were present in CMA region.
>
> Essentially, on a P9 LPAR with 2 cores, 8GB RAM and current upstream:
> [root@zzxx-yy10 ~]# free -m
>                total        used        free      shared  buff/cache   available
> Mem:           7557         193        6822          12         541        6725
> Swap:          4095           0        4095
>
> With this patch:
> [root@zzxx-yy10 ~]# free -m
>                total        used        free      shared  buff/cache   available
> Mem:           8133         194        7464          12         475        7338
> Swap:          4095           0        4095
>
> Changes made here are completely transparent to how fadump has
> traditionally worked.
>
> Thanks to Aneesh Kumar and Anshuman Khandual for helping us understand
> CMA and its usage.
>
> TODO:
> - Handle case where CMA reservation spans nodes.
>
> Signed-off-by: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> ---
>   arch/powerpc/kernel/fadump.c |  120 ++++++++++++++++++++++++++++++++++++------
>   1 file changed, 103 insertions(+), 17 deletions(-)
>
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index 16b3e8c5cae0..7f76924ab190 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -34,6 +34,7 @@
>   #include <linux/crash_dump.h>
>   #include <linux/kobject.h>
>   #include <linux/sysfs.h>
> +#include <linux/cma.h>
>
>   #include <asm/debugfs.h>
>   #include <asm/page.h>
> @@ -45,11 +46,57 @@
>   static struct fw_dump fw_dump;
>   static struct fadump_mem_struct fdm;
>   static const struct fadump_mem_struct *fdm_active;
> +static struct cma *fadump_cma;
>
>   static DEFINE_MUTEX(fadump_mutex);
>   struct fad_crash_memory_ranges crash_memory_ranges[INIT_CRASHMEM_RANGES];
>   int crash_mem_ranges;
>
> +/*
> + * fadump_cma_reserve() - reserve area for fadump memory reservation
> + *
> + * This function reserves memory from early allocator. It should be
> + * called by arch specific code once the memblock allocator
> + * has been activated.
> + */
> +int __init fadump_cma_reserve(void)
> +{
> +	unsigned long long base, size;
> +	int rc;
> +
> +	if (!fw_dump.fadump_enabled)
> +		return 0;
> +
> +	base = fw_dump.reserve_dump_area_start;
> +	size = fw_dump.reserve_dump_area_size;

Mahesh, How about moving sections around instead:

Old:
   1. cpu state data region
   2. hpte region
   3. real memory region

New:
   2. cpu state data region
   3. hpte region
   1. real memory region

and using only boot memory size for cma reserve. The other regions, 
crashinfo header
& elfcorehdrs can still use memblock_reserve.

This achieves two things. One, ensures we don't waste memory in alignment
as cma uses hugepage(16MB)/maxorder as default alignment (we need to 
ensure boot
memory size is aligned by hugepage(16MB)/maxorder though). Two, we don't 
have to
move around meta data from end to start (patch 1/7)

To differentiate the old and new section order, we can overload crash 
info magic
(FADUMPINF -> FADUMPIV2), I guess. That differentiation may be needed for
re-registering after dump capture..

> +	pr_debug("Original reserve area base %ld, size %ld\n",
> +				(unsigned long)base >> 20,
> +				(unsigned long)size >> 20);
> +	if (!size)
> +		return 0;
> +
> +	rc = cma_declare_contiguous(base, size, 0, 0, 0, false,
> +						"fadump_cma", &fadump_cma);

Compilation fails when CONFIG_CMA is not set. A fallback when CONFIG_CMA
is not set or dependency enforced for FA_DUMP config option seems to be 
missing..

Also, considering we already deduce the base by looking for holes in 
fadump code, we could
have a 'fixed' ('true' for 6th parameter) cma region? Again, we have to 
ensure CMA alignment
for boot memory size in fadump_calculate_reserve_size() for doing all 
this seamlessly..

> +	if (rc) {
> +		printk(KERN_ERR "fadump: Failed to reserve cma area for "
> +				"firmware-assisted dump, %d\n", rc);
> +		fw_dump.reserve_dump_area_size = 0;
> +		return 0;
> +	}
> +	/*
> +	 * So we now have cma area reserved for fadump. base may be different
> +	 * from what we requested.
> +	 */
> +	fw_dump.reserve_dump_area_start = cma_get_base(fadump_cma);
> +	fw_dump.reserve_dump_area_size = cma_get_size(fadump_cma);
> +	printk("Reserved %ldMB cma area at %ldMB for firmware-assisted dump "
> +			"(System RAM: %ldMB)\n",
> +			cma_get_size(fadump_cma) >> 20,
> +			(unsigned long)cma_get_base(fadump_cma) >> 20,
> +			(unsigned long)(memblock_phys_mem_size() >> 20));
> +	return 1;
> +}
> +
>   /* Scan the Firmware Assisted dump configuration details. */
>   int __init early_init_dt_scan_fw_dump(unsigned long node,
>   			const char *uname, int depth, void *data)
> @@ -496,8 +543,9 @@ int __init fadump_reserve_mem(void)
>   		pr_info("Number of kernel Dump sections: %d\n",
>   			be16_to_cpu(fdm_active->header.dump_num_sections));
>   		fw_dump.fadumphdr_addr = get_fadump_metadata_base(fdm_active);
> -		pr_debug("fadumphdr_addr = %p\n",
> -				(void *) fw_dump.fadumphdr_addr);
> +		pr_debug("fadumphdr_addr = %pa\n", &fw_dump.fadumphdr_addr);
> +		fw_dump.reserve_dump_area_start = base;
> +		fw_dump.reserve_dump_area_size = size;
>   	} else {
>   		size = get_fadump_area_size();
>
> @@ -514,21 +562,10 @@ int __init fadump_reserve_mem(void)
>   			    !memblock_is_region_reserved(base, size))
>   				break;
>   		}
> -		if ((base > (memory_boundary - size)) ||
> -		    memblock_reserve(base, size)) {
> -			pr_err("Failed to reserve memory\n");
> -			return 0;
> -		}
> -
> -		pr_info("Reserved %ldMB of memory at %ldMB for firmware-"
> -			"assisted dump (System RAM: %ldMB)\n",
> -			(unsigned long)(size >> 20),
> -			(unsigned long)(base >> 20),
> -			(unsigned long)(memblock_phys_mem_size() >> 20));
> +		fw_dump.reserve_dump_area_start = base;
> +		fw_dump.reserve_dump_area_size = size;
> +		return fadump_cma_reserve();
>   	}
> -
> -	fw_dump.reserve_dump_area_start = base;
> -	fw_dump.reserve_dump_area_size = size;
>   	return 1;
>   }
>
> @@ -1191,6 +1228,39 @@ static unsigned long init_fadump_header(unsigned long addr)
>   	return addr;
>   }
>
> +static unsigned long allocate_metadata_area(void)
> +{
> +	int nr_pages;
> +	unsigned long size;
> +	struct page *page = NULL;
> +
> +	/*
> +	 * Check if fadump cma region is activated.
> +	 * fadump_cma->count == 0 means cma activation has failed. This means
> +	 * that the fadump reserved memory now will not be visible/available
> +	 * for user applications to use. It will be as good as old fadump
> +	 * behaviour of blocking this memory chunk from production system
> +	 * use. CMA activation failure does not mean that fadump will not
> +	 * work. Will continue to setup fadump.
> +	 */
> +	if (!fadump_cma || !cma_get_size(fadump_cma)) {
> +		pr_warn("fadump cma region activation failed.\n");
> +		return 0;
> +	}
> +
> +	size = get_fadump_metadata_size();
> +	nr_pages = ALIGN(size, PAGE_SIZE) >> PAGE_SHIFT;
> +	pr_info("Fadump metadata size = %ld (nr_pages = %d)\n", size, nr_pages);
> +
> +	page = cma_alloc(fadump_cma, nr_pages, 0, GFP_KERNEL);
> +	if (page) {
> +		pr_debug("Allocated fadump metadata area at %ldMB (cma)\n",
> +				(unsigned long)page_to_phys(page) >> 20);
> +		return page_to_phys(page);
> +	}
> +	return 0;
> +}
> +

We shouldn't be needing this function with the above mentioned change..

Thanks
Hari
