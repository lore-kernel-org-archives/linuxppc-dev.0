Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42LblC5KTtzF36X
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 23:49:26 +1000 (AEST)
Date: Thu, 27 Sep 2018 15:49:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/5] dma-direct: refine dma_direct_alloc zone selection
Message-ID: <20180927134922.GA8281@lst.de>
References: <20180920185247.20037-1-hch@lst.de>
 <20180920185247.20037-4-hch@lst.de>
 <1811156d5a1df1166c7ab7522525619b951f047d.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1811156d5a1df1166c7ab7522525619b951f047d.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 27, 2018 at 11:45:15AM +1000, Benjamin Herrenschmidt wrote:
> I'm not sure this is entirely right.
> 
> Let's say the mask is 30 bits. You will return GFP_DMA32, which will
> fail if you allocate something above 1G (which is legit for
> ZONE_DMA32).

And then we will try GFP_DMA further down in the function:

		if (IS_ENABLED(CONFIG_ZONE_DMA) &&
		    dev->coherent_dma_mask < DMA_BIT_MASK(32) &&
		    !(gfp & GFP_DMA)) {
			gfp = (gfp & ~GFP_DMA32) | GFP_DMA;
			goto again;
		}

This is and old optimization from x86, because chances are high that
GFP_DMA32 will give you suitable memory for the infamous 31-bit
dma mask devices (at least at boot time) and thus we don't have
to deplete the tiny ZONE_DMA pool.
