Return-Path: <minchan@kernel.org>
Received: from lgemrelse6q.lge.com (LGEMRELSE6Q.lge.com [156.147.1.121])
 by lists.ozlabs.org (Postfix) with ESMTP id D37C51A02BE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 15:33:43 +1000 (EST)
Date: Thu, 12 Jun 2014 14:18:53 +0900
From: Minchan Kim <minchan@kernel.org>
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v2 01/10] DMA, CMA: clean-up log message
Message-ID: <20140612051853.GD12415@bbox>
References: <1402543307-29800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1402543307-29800-2-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1402543307-29800-2-git-send-email-iamjoonsoo.kim@lge.com>
Cc: kvm-ppc@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>,
 kvm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Graf <agraf@suse.de>, Michal Nazarewicz <mina86@mina86.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Joonsoo,

On Thu, Jun 12, 2014 at 12:21:38PM +0900, Joonsoo Kim wrote:
> We don't need explicit 'CMA:' prefix, since we already define prefix
> 'cma:' in pr_fmt. So remove it.
> 
> And, some logs print function name and others doesn't. This looks
> bad to me, so I unify log format to print function name consistently.
> 
> Lastly, I add one more debug log on cma_activate_area().

When I take a look, it just indicates cma_activate_area was called or not,
without what range for the area was reserved successfully so I couldn't see
the intention for new message. Description should explain it so that everybody
can agree on your claim.

> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
> index 83969f8..bd0bb81 100644
> --- a/drivers/base/dma-contiguous.c
> +++ b/drivers/base/dma-contiguous.c
> @@ -144,7 +144,7 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
>  	}
>  
>  	if (selected_size && !dma_contiguous_default_area) {
> -		pr_debug("%s: reserving %ld MiB for global area\n", __func__,
> +		pr_debug("%s(): reserving %ld MiB for global area\n", __func__,
>  			 (unsigned long)selected_size / SZ_1M);
>  
>  		dma_contiguous_reserve_area(selected_size, selected_base,
> @@ -163,8 +163,9 @@ static int __init cma_activate_area(struct cma *cma)
>  	unsigned i = cma->count >> pageblock_order;
>  	struct zone *zone;
>  
> -	cma->bitmap = kzalloc(bitmap_size, GFP_KERNEL);
> +	pr_debug("%s()\n", __func__);
>  
> +	cma->bitmap = kzalloc(bitmap_size, GFP_KERNEL);
>  	if (!cma->bitmap)
>  		return -ENOMEM;
>  
> @@ -234,7 +235,8 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
>  
>  	/* Sanity checks */
>  	if (cma_area_count == ARRAY_SIZE(cma_areas)) {
> -		pr_err("Not enough slots for CMA reserved regions!\n");
> +		pr_err("%s(): Not enough slots for CMA reserved regions!\n",
> +			__func__);
>  		return -ENOSPC;
>  	}
>  
> @@ -274,14 +276,15 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
>  	*res_cma = cma;
>  	cma_area_count++;
>  
> -	pr_info("CMA: reserved %ld MiB at %08lx\n", (unsigned long)size / SZ_1M,
> -		(unsigned long)base);
> +	pr_info("%s(): reserved %ld MiB at %08lx\n",
> +		__func__, (unsigned long)size / SZ_1M, (unsigned long)base);
>  
>  	/* Architecture specific contiguous memory fixup. */
>  	dma_contiguous_early_fixup(base, size);
>  	return 0;
>  err:
> -	pr_err("CMA: failed to reserve %ld MiB\n", (unsigned long)size / SZ_1M);
> +	pr_err("%s(): failed to reserve %ld MiB\n",
> +		__func__, (unsigned long)size / SZ_1M);
>  	return ret;
>  }
>  
> -- 
> 1.7.9.5

-- 
Kind regards,
Minchan Kim
