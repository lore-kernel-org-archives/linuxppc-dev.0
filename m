Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjgL247qszDqVg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 21:35:54 +1000 (AEST)
In-Reply-To: <87o9vauvyk.fsf@concordia.ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: aneesh.kumar@linux.vnet.ibm.com
Subject: Re: powerpc/mm: Fix mapped range information print during boot
Message-Id: <3xjgL21GZpz9t1t@ozlabs.org>
Date: Thu, 31 Aug 2017 21:35:53 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-05-03 at 09:32:35 UTC, Michael Ellerman wrote:
> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> index c28165d8970b..519cfef569d1 100644
> --- a/arch/powerpc/mm/pgtable-radix.c
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -8,9 +8,14 @@
>   * as published by the Free Software Foundation; either version
>   * 2 of the License, or (at your option) any later version.
>   */
> +
> +#define pr_fmt(fmt) "radix-mmu: " fmt
> +
> +#include <linux/kernel.h>
>  #include <linux/sched/mm.h>
>  #include <linux/memblock.h>
>  #include <linux/of_fdt.h>
> +#include <linux/string_helpers.h>
>  
>  #include <asm/pgtable.h>
>  #include <asm/pgalloc.h>
> @@ -112,10 +117,14 @@ static inline void __meminit print_mapping(unsigned long start,
>  					   unsigned long end,
>  					   unsigned long size)
>  {
> +	char buf[10];
> +
>  	if (end <= start)
>  		return;
>  
> -	pr_info("Mapped range 0x%lx - 0x%lx with 0x%lx\n", start, end, size);
> +	string_get_size(size, 1, STRING_UNITS_2, buf, sizeof(buf));
> +
> +	pr_info("Mapped 0x%016lx-0x%016lx with %s pages\n", start, end, buf);
>  }
>  
>  static int __meminit create_physical_mapping(unsigned long start,

Applied to powerpc next.

https://git.kernel.org/powerpc/c/6deb6b474bda4d2d3fbee066f20561

cheers
