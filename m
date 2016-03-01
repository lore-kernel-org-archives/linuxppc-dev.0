Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2A83A1A074D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 12:59:08 +1100 (AEDT)
In-Reply-To: <1454988763-5580-4-git-send-email-david@gibson.dropbear.id.au>
To: David Gibson <david@gibson.dropbear.id.au>, paulus@samba.org,
 benh@kernel.crashing.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [3/4] powerpc/mm: Clean up memory hotplug failure paths
Message-Id: <20160301015907.D4344140BA7@ozlabs.org>
Date: Tue,  1 Mar 2016 12:59:07 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-09-02 at 03:32:42 UTC, David Gibson wrote:
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
...
> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
> index baa1a23..fbc9448 100644
> --- a/arch/powerpc/mm/init_64.c
> +++ b/arch/powerpc/mm/init_64.c
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

This breaks the build when CONFIG_MEMORY_HOTPLUG=n, because
htab_remove_mapping() is not defined.

The obvious fix of moving htab_remove_mapping() out of CONFIG_MEMORY_HOTPLUG
works, so I'll do that unless anyone objects.

cheers
