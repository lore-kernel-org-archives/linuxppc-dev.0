Return-Path: <robin.murphy@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 42LcfV58p7zF35y
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 00:30:25 +1000 (AEST)
Subject: Re: [PATCH 3/5] dma-direct: refine dma_direct_alloc zone selection
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20180920185247.20037-1-hch@lst.de>
 <20180920185247.20037-4-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <fd524731-a0aa-b970-d320-fe209b9c68f6@arm.com>
Date: Thu, 27 Sep 2018 15:30:20 +0100
MIME-Version: 1.0
In-Reply-To: <20180920185247.20037-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 20/09/18 19:52, Christoph Hellwig wrote:
> We need to take the DMA offset and encryption bit into account when
> selecting a zone.  User the opportunity to factor out the zone
> selection into a helper for reuse.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   kernel/dma/direct.c | 31 +++++++++++++++++++++----------
>   1 file changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 81b73a5bba54..3c404e33d946 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -68,6 +68,22 @@ u64 dma_direct_get_required_mask(struct device *dev)
>   	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
>   }
>   
> +static gfp_t __dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
> +		u64 *phys_mask)
> +{
> +	if (force_dma_unencrypted())
> +		*phys_mask = __dma_to_phys(dev, dma_mask);
> +	else
> +		*phys_mask = dma_to_phys(dev, dma_mask);

Maybe make phys_to_dma_direct() take u64 instead of phys_addr_t so we 
can reuse it here?

> +	/* GFP_DMA32 and GFP_DMA are no ops without the corresponding zones: */
> +	if (*phys_mask <= DMA_BIT_MASK(ARCH_ZONE_DMA_BITS))
> +		return GFP_DMA;

If we don't have ZONE_DMA it would in theory be a tiny bit better to 
fall back to GFP_DMA32 instead of returning 0 here, but I'm not sure 
it's worth the bother.

> +	if (*phys_mask <= DMA_BIT_MASK(32))
> +		return GFP_DMA32;
> +	return 0;
> +}
> +
>   static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
>   {
>   	return phys_to_dma_direct(dev, phys) + size - 1 <=
> @@ -80,17 +96,13 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
>   	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>   	int page_order = get_order(size);
>   	struct page *page = NULL;
> +	u64 phys_mask;
>   	void *ret;
>   
>   	/* we always manually zero the memory once we are done: */
>   	gfp &= ~__GFP_ZERO;
> -
> -	/* GFP_DMA32 and GFP_DMA are no ops without the corresponding zones: */
> -	if (dev->coherent_dma_mask <= DMA_BIT_MASK(ARCH_ZONE_DMA_BITS))
> -		gfp |= GFP_DMA;
> -	if (dev->coherent_dma_mask <= DMA_BIT_MASK(32) && !(gfp & GFP_DMA))
> -		gfp |= GFP_DMA32;
> -
> +	gfp |= __dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
> +			&phys_mask);
>   again:
>   	/* CMA can be used only in the context which permits sleeping */
>   	if (gfpflags_allow_blocking(gfp)) {
> @@ -109,15 +121,14 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
>   		page = NULL;
>   
>   		if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
> -		    dev->coherent_dma_mask < DMA_BIT_MASK(64) &&
> +		    phys_mask < DMA_BIT_MASK(64) &&
>   		    !(gfp & (GFP_DMA32 | GFP_DMA))) {
>   			gfp |= GFP_DMA32;
>   			goto again;

Ah right, in that situation we should probably end up here anyway, so 
that's good enough - definitely not worth any more #ifdeffery above. 
Nits aside,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

>   		}
>   
>   		if (IS_ENABLED(CONFIG_ZONE_DMA) &&
> -		    dev->coherent_dma_mask < DMA_BIT_MASK(32) &&
> -		    !(gfp & GFP_DMA)) {
> +		    phys_mask < DMA_BIT_MASK(32) && !(gfp & GFP_DMA)) {
>   			gfp = (gfp & ~GFP_DMA32) | GFP_DMA;
>   			goto again;
>   		}
> 
