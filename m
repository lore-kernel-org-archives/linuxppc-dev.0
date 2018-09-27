Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42LHnc6gmKzDqjl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 11:50:28 +1000 (AEST)
Message-ID: <985079efc3296ac45de1e6344d7916c42fc7cbdd.camel@kernel.crashing.org>
Subject: Re: [PATCH 5/5] dma-direct: always allow dma mask <= physiscal
 memory size
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
 <robin.murphy@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Thu, 27 Sep 2018 11:50:14 +1000
In-Reply-To: <20180920185247.20037-6-hch@lst.de>
References: <20180920185247.20037-1-hch@lst.de>
 <20180920185247.20037-6-hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-09-20 at 20:52 +0200, Christoph Hellwig wrote:
> This way an architecture with less than 4G of RAM can support dma_mask
> smaller than 32-bit without a ZONE_DMA.  Apparently that is a common
> case on powerpc.

Anything that uses a b43 wifi adapter which has a 31-bit limitation
actually :-)
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  kernel/dma/direct.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 64466b7ef67b..d1e103c6b107 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -4,6 +4,7 @@
>   *
>   * DMA operations that map physical memory directly without using an IOMMU.
>   */
> +#include <linux/bootmem.h> /* for max_pfn */
>  #include <linux/export.h>
>  #include <linux/mm.h>
>  #include <linux/dma-direct.h>
> @@ -283,21 +284,24 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>  	return nents;
>  }
>  
> +/*
> + * Because 32-bit DMA masks are so common we expect every architecture to be
> + * able to satisfy them - either by not supporting more physical memory, or by
> + * providing a ZONE_DMA32.  If neither is the case, the architecture needs to
> + * use an IOMMU instead of the direct mapping.
> + */
>  int dma_direct_supported(struct device *dev, u64 mask)
>  {
> -#ifdef CONFIG_ZONE_DMA
> -	if (mask < phys_to_dma(dev, DMA_BIT_MASK(ARCH_ZONE_DMA_BITS)))
> -		return 0;
> -#else
> -	/*
> -	 * Because 32-bit DMA masks are so common we expect every architecture
> -	 * to be able to satisfy them - either by not supporting more physical
> -	 * memory, or by providing a ZONE_DMA32.  If neither is the case, the
> -	 * architecture needs to use an IOMMU instead of the direct mapping.
> -	 */
> -	if (mask < phys_to_dma(dev, DMA_BIT_MASK(32)))
> +	u64 min_mask;
> +
> +	if (IS_ENABLED(CONFIG_ZONE_DMA))
> +		min_mask = DMA_BIT_MASK(ARCH_ZONE_DMA_BITS);
> +	else
> +		min_mask = min_t(u64, DMA_BIT_MASK(32),
> +				 (max_pfn - 1) << PAGE_SHIFT);
> +
> +	if (mask >= phys_to_dma(dev, min_mask))
>  		return 0;

nitpick ... to be completely "correct", I would have written

	if (IS_ENABLED(CONFIG_ZONE_DMA))
		min_mask = DMA_BIT_MASK(ARCH_ZONE_DMA_BITS);
	else
		min_mask = DMA_BIT_MASK(32);

	min_mask = min_t(u64, min_mask,	(max_pfn - 1) << PAGE_SHIFT);

In "theory" it's also ok to have a mask < ZONE_DMA_BITS as long as it's
big enough to fit all memory :-)
	
> -#endif
>  	return 1;
>  }
>  
