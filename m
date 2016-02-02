Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B6C811A01D8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2016 02:04:35 +1100 (AEDT)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 2 Feb 2016 10:04:30 -0500
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id BFA9638C8026
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Feb 2016 10:04:27 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u12F4RiY24641544
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Feb 2016 15:04:27 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u12F4Qmn026291
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Feb 2016 10:04:27 -0500
Subject: Re: [RFCv2 4/9] arch/powerpc: Clean up memory hotplug failure paths
To: David Gibson <david@gibson.dropbear.id.au>, paulus@samba.org,
 mpe@ellerman.id.au, benh@kernel.crashing.org
References: <1454045043-25545-1-git-send-email-david@gibson.dropbear.id.au>
 <1454045043-25545-5-git-send-email-david@gibson.dropbear.id.au>
Cc: aik@ozlabs.ru, lvivier@redhat.com, thuth@redhat.com,
 linuxppc-dev@lists.ozlabs.org
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Message-ID: <56B0C577.1030809@linux.vnet.ibm.com>
Date: Tue, 2 Feb 2016 09:04:23 -0600
MIME-Version: 1.0
In-Reply-To: <1454045043-25545-5-git-send-email-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/28/2016 11:23 PM, David Gibson wrote:
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
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  arch/powerpc/mm/hash_utils_64.c | 13 ++++++++++---
>  arch/powerpc/mm/init_64.c       | 38 ++++++++++++++++++++++++++------------
>  arch/powerpc/mm/mem.c           | 10 ++++++++--
>  3 files changed, 44 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index 0737eae..e88a86e 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -635,9 +635,16 @@ static unsigned long __init htab_get_table_size(void)
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

<-- snip -->

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

If I'm reading this correctly it appears that create_section_mapping() and
vmemmap_create_mapping() for !PPC_BOOK3E are identical. Any reason to not
have one routine, perhaps just have vmemmap_create_mapping() just call
create_section_mapping()?

-Nathan
