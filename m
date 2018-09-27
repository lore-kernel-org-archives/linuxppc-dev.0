Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42LHgt3QHdzF3LX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 11:45:30 +1000 (AEST)
Message-ID: <1811156d5a1df1166c7ab7522525619b951f047d.camel@kernel.crashing.org>
Subject: Re: [PATCH 3/5] dma-direct: refine dma_direct_alloc zone selection
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
 <robin.murphy@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Thu, 27 Sep 2018 11:45:15 +1000
In-Reply-To: <20180920185247.20037-4-hch@lst.de>
References: <20180920185247.20037-1-hch@lst.de>
 <20180920185247.20037-4-hch@lst.de>
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
> +static gfp_t __dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
> +               u64 *phys_mask)
> +{
> +       if (force_dma_unencrypted())
> +               *phys_mask = __dma_to_phys(dev, dma_mask);
> +       else
> +               *phys_mask = dma_to_phys(dev, dma_mask);
> +
> +       /* GFP_DMA32 and GFP_DMA are no ops without the corresponding zones: */
> +       if (*phys_mask <= DMA_BIT_MASK(ARCH_ZONE_DMA_BITS))
> +               return GFP_DMA;
> +       if (*phys_mask <= DMA_BIT_MASK(32))
> +               return GFP_DMA32;
> +       return 0;
> +}

I'm not sure this is entirely right.

Let's say the mask is 30 bits. You will return GFP_DMA32, which will
fail if you allocate something above 1G (which is legit for
ZONE_DMA32).

I think the logic should be:

	if (mask < ZONE_DMA)
		fail;
	else if (mask < ZONE_DMA32)
		use ZONE_DMA or fail if doesn't exist
	else if (mask < top_of_ram)
		use ZONE_DMA32 or fail if doesn't exist
	else
		use ZONE_NORMAL

Additionally, we want to fold-in the top-of-ram test such that we don't
fail the second case if the mask is 31-bits (smaller than ZONE_DMA32)
but top of ram is also small enough.

So the top of ram test should take precendence.

Cheers,
Ben.
