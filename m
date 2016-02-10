Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A30361A03C4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 20:00:33 +1100 (AEDT)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 10 Feb 2016 02:00:31 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 48BD519D8048
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 01:48:28 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1A90Tww11862106
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 02:00:29 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1A90RwG020147
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 02:00:29 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>, mpe@ellerman.id.au,
 paulus@samba.org, benh@kernel.crashing.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 3/4] powerpc/mm: Clean up memory hotplug failure paths
In-Reply-To: <1454988763-5580-4-git-send-email-david@gibson.dropbear.id.au>
References: <1454988763-5580-1-git-send-email-david@gibson.dropbear.id.au>
 <1454988763-5580-4-git-send-email-david@gibson.dropbear.id.au>
Date: Wed, 10 Feb 2016 14:30:20 +0530
Message-ID: <874mdhx7mj.fsf@linux.vnet.ibm.com>
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

David Gibson <david@gibson.dropbear.id.au> writes:

> This makes a number of cleanups to handling of mapping failures during
> memory hotplug on Power:
>
> For errors creating the linear mapping for the hot-added region:
>   * This is now reported with EFAULT which is more appropriate than the
>     previous EINVAL (the failure is unlikely to be related to the
>     function's parameters)
>   * An error in this path now prints a warning message, rather than just
>     silently failing to add the extra memory.
>   * Previously a failure here could result in the region being partially
>     mapped.  We now clean up any partial mapping before failing.
>
> For errors creating the vmemmap for the hot-added region:
>    * This is now reported with EFAULT instead of causing a BUG() - this
>      could happen for external reason (e.g. full hash table) so it's better
>      to handle this non-fatally
>    * An error message is also printed, so the failure won't be silent
>    * As above a failure could cause a partially mapped region, we now
>      clean this up.
>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Paul Mackerras <paulus@samba.org>
> ---
>  arch/powerpc/mm/hash_utils_64.c | 13 ++++++++++---
>  arch/powerpc/mm/init_64.c       | 38 ++++++++++++++++++++++++++------------
>  arch/powerpc/mm/mem.c           | 10 ++++++++--
>  3 files changed, 44 insertions(+), 17 deletions(-)
>
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index 99fbee0..fdcf9d1 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -640,9 +640,16 @@ static unsigned long __init htab_get_table_size(void)
>  #ifdef CONFIG_MEMORY_HOTPLUG
>  int create_section_mapping(unsigned long start, unsigned long end)
>  {
> -	return htab_bolt_mapping(start, end, __pa(start),
> -				 pgprot_val(PAGE_KERNEL), mmu_linear_psize,
> -				 mmu_kernel_ssize);
> +	int rc = htab_bolt_mapping(start, end, __pa(start),
> +				   pgprot_val(PAGE_KERNEL), mmu_linear_psize,
> +				   mmu_kernel_ssize);
> +
> +	if (rc < 0) {
> +		int rc2 = htab_remove_mapping(start, end, mmu_linear_psize,
> +					      mmu_kernel_ssize);
> +		BUG_ON(rc2 && (rc2 != -ENOENT));
> +	}
> +	return rc;
>  }
>  
>  int remove_section_mapping(unsigned long start, unsigned long end)
> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
> index baa1a23..fbc9448 100644
> --- a/arch/powerpc/mm/init_64.c
> +++ b/arch/powerpc/mm/init_64.c
> @@ -188,9 +188,9 @@ static int __meminit vmemmap_populated(unsigned long start, int page_size)
>   */
>  
>  #ifdef CONFIG_PPC_BOOK3E
> -static void __meminit vmemmap_create_mapping(unsigned long start,
> -					     unsigned long page_size,
> -					     unsigned long phys)
> +static int __meminit vmemmap_create_mapping(unsigned long start,
> +					    unsigned long page_size,
> +					    unsigned long phys)
>  {
>  	/* Create a PTE encoding without page size */
>  	unsigned long i, flags = _PAGE_PRESENT | _PAGE_ACCESSED |
> @@ -208,6 +208,8 @@ static void __meminit vmemmap_create_mapping(unsigned long start,
>  	 */
>  	for (i = 0; i < page_size; i += PAGE_SIZE)
>  		BUG_ON(map_kernel_page(start + i, phys, flags));
> +
> +	return 0;
>  }
>  
>  #ifdef CONFIG_MEMORY_HOTPLUG
> @@ -217,15 +219,20 @@ static void vmemmap_remove_mapping(unsigned long start,
>  }
>  #endif
>  #else /* CONFIG_PPC_BOOK3E */
> -static void __meminit vmemmap_create_mapping(unsigned long start,
> -					     unsigned long page_size,
> -					     unsigned long phys)
> +static int __meminit vmemmap_create_mapping(unsigned long start,
> +					    unsigned long page_size,
> +					    unsigned long phys)
>  {
> -	int  mapped = htab_bolt_mapping(start, start + page_size, phys,
> -					pgprot_val(PAGE_KERNEL),
> -					mmu_vmemmap_psize,
> -					mmu_kernel_ssize);
> -	BUG_ON(mapped < 0);
> +	int rc = htab_bolt_mapping(start, start + page_size, phys,
> +				   pgprot_val(PAGE_KERNEL),
> +				   mmu_vmemmap_psize, mmu_kernel_ssize);
> +	if (rc < 0) {
> +		int rc2 = htab_remove_mapping(start, start + page_size,
> +					      mmu_vmemmap_psize,
> +					      mmu_kernel_ssize);
> +		BUG_ON(rc2 && (rc2 != -ENOENT));
> +	}
> +	return rc;
>  }
>  
>  #ifdef CONFIG_MEMORY_HOTPLUG
> @@ -304,6 +311,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
>  
>  	for (; start < end; start += page_size) {
>  		void *p;
> +		int rc;
>  
>  		if (vmemmap_populated(start, page_size))
>  			continue;
> @@ -317,7 +325,13 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
>  		pr_debug("      * %016lx..%016lx allocated at %p\n",
>  			 start, start + page_size, p);
>  
> -		vmemmap_create_mapping(start, page_size, __pa(p));
> +		rc = vmemmap_create_mapping(start, page_size, __pa(p));
> +		if (rc < 0) {
> +			pr_warning(
> +				"vmemmap_populate: Unable to create vmemmap mapping: %d\n",
> +				rc);
> +			return -EFAULT;
> +		}
>  	}
>  
>  	return 0;
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index d0f0a51..f980da6 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -119,12 +119,18 @@ int arch_add_memory(int nid, u64 start, u64 size, bool for_device)
>  	struct zone *zone;
>  	unsigned long start_pfn = start >> PAGE_SHIFT;
>  	unsigned long nr_pages = size >> PAGE_SHIFT;
> +	int rc;
>  
>  	pgdata = NODE_DATA(nid);
>  
>  	start = (unsigned long)__va(start);
> -	if (create_section_mapping(start, start + size))
> -		return -EINVAL;
> +	rc = create_section_mapping(start, start + size);
> +	if (rc) {
> +		pr_warning(
> +			"Unable to create mapping for hot added memory 0x%llx..0x%llx: %d\n",
> +			start, start + size, rc);
> +		return -EFAULT;
> +	}
>  
>  	/* this should work for most non-highmem platforms */
>  	zone = pgdata->node_zones +
> -- 
> 2.5.0
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
