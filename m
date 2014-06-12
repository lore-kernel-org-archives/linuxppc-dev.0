Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BEAAE1A02AE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 14:50:29 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 12 Jun 2014 14:50:28 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 7E59C2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 14:50:26 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5C4SOVt51380266
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 14:28:24 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5C4oOW3030217
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 14:50:26 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Michal Nazarewicz <mina86@mina86.com>
Subject: Re: [PATCH v2 04/10] DMA,
 CMA: support alignment constraint on cma region
In-Reply-To: <1402543307-29800-5-git-send-email-iamjoonsoo.kim@lge.com>
References: <1402543307-29800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1402543307-29800-5-git-send-email-iamjoonsoo.kim@lge.com>
Date: Thu, 12 Jun 2014 10:20:18 +0530
Message-ID: <87oaxypw8l.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, kvm@vger.kernel.org,
 linux-mm@kvack.org, Gleb Natapov <gleb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Joonsoo Kim <iamjoonsoo.kim@lge.com> writes:

> ppc kvm's cma area management needs alignment constraint on
> cma region. So support it to prepare generalization of cma area
> management functionality.
>
> Additionally, add some comments which tell us why alignment
> constraint is needed on cma region.
>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

>
> diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
> index 8a44c82..bc4c171 100644
> --- a/drivers/base/dma-contiguous.c
> +++ b/drivers/base/dma-contiguous.c
> @@ -32,6 +32,7 @@
>  #include <linux/swap.h>
>  #include <linux/mm_types.h>
>  #include <linux/dma-contiguous.h>
> +#include <linux/log2.h>
>
>  struct cma {
>  	unsigned long	base_pfn;
> @@ -219,6 +220,7 @@ core_initcall(cma_init_reserved_areas);
>   * @size: Size of the reserved area (in bytes),
>   * @base: Base address of the reserved area optional, use 0 for any
>   * @limit: End address of the reserved memory (optional, 0 for any).
> + * @alignment: Alignment for the contiguous memory area, should be power of 2
>   * @res_cma: Pointer to store the created cma region.
>   * @fixed: hint about where to place the reserved area
>   *
> @@ -233,15 +235,15 @@ core_initcall(cma_init_reserved_areas);
>   */
>  static int __init __dma_contiguous_reserve_area(phys_addr_t size,
>  				phys_addr_t base, phys_addr_t limit,
> +				phys_addr_t alignment,
>  				struct cma **res_cma, bool fixed)
>  {
>  	struct cma *cma = &cma_areas[cma_area_count];
> -	phys_addr_t alignment;
>  	int ret = 0;
>
> -	pr_debug("%s(size %lx, base %08lx, limit %08lx)\n", __func__,
> -		 (unsigned long)size, (unsigned long)base,
> -		 (unsigned long)limit);
> +	pr_debug("%s(size %lx, base %08lx, limit %08lx align_order %08lx)\n",
> +		__func__, (unsigned long)size, (unsigned long)base,
> +		(unsigned long)limit, (unsigned long)alignment);
>
>  	/* Sanity checks */
>  	if (cma_area_count == ARRAY_SIZE(cma_areas)) {
> @@ -253,8 +255,17 @@ static int __init __dma_contiguous_reserve_area(phys_addr_t size,
>  	if (!size)
>  		return -EINVAL;
>
> -	/* Sanitise input arguments */
> -	alignment = PAGE_SIZE << max(MAX_ORDER - 1, pageblock_order);
> +	if (alignment && !is_power_of_2(alignment))
> +		return -EINVAL;
> +
> +	/*
> +	 * Sanitise input arguments.
> +	 * CMA area should be at least MAX_ORDER - 1 aligned. Otherwise,
> +	 * CMA area could be merged into other MIGRATE_TYPE by buddy mechanism
> +	 * and CMA property will be broken.
> +	 */
> +	alignment = max(alignment,
> +		(phys_addr_t)PAGE_SIZE << max(MAX_ORDER - 1, pageblock_order));
>  	base = ALIGN(base, alignment);
>  	size = ALIGN(size, alignment);
>  	limit &= ~(alignment - 1);
> @@ -302,7 +313,8 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
>  {
>  	int ret;
>
> -	ret = __dma_contiguous_reserve_area(size, base, limit, res_cma, fixed);
> +	ret = __dma_contiguous_reserve_area(size, base, limit, 0,
> +						res_cma, fixed);
>  	if (ret)
>  		return ret;
>
> -- 
> 1.7.9.5
