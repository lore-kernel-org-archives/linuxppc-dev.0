Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Lblp0T5MzF36x
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 23:49:57 +1000 (AEST)
Date: Thu, 27 Sep 2018 15:49:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 5/5] dma-direct: always allow dma mask <= physiscal
 memory size
Message-ID: <20180927134954.GB8281@lst.de>
References: <20180920185247.20037-1-hch@lst.de>
 <20180920185247.20037-6-hch@lst.de>
 <985079efc3296ac45de1e6344d7916c42fc7cbdd.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <985079efc3296ac45de1e6344d7916c42fc7cbdd.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 27, 2018 at 11:50:14AM +1000, Benjamin Herrenschmidt wrote:
> > -	 * to be able to satisfy them - either by not supporting more physical
> > -	 * memory, or by providing a ZONE_DMA32.  If neither is the case, the
> > -	 * architecture needs to use an IOMMU instead of the direct mapping.
> > -	 */
> > -	if (mask < phys_to_dma(dev, DMA_BIT_MASK(32)))
> > +	u64 min_mask;
> > +
> > +	if (IS_ENABLED(CONFIG_ZONE_DMA))
> > +		min_mask = DMA_BIT_MASK(ARCH_ZONE_DMA_BITS);
> > +	else
> > +		min_mask = min_t(u64, DMA_BIT_MASK(32),
> > +				 (max_pfn - 1) << PAGE_SHIFT);
> > +
> > +	if (mask >= phys_to_dma(dev, min_mask))
> >  		return 0;
> 
> nitpick ... to be completely "correct", I would have written
> 
> 	if (IS_ENABLED(CONFIG_ZONE_DMA))
> 		min_mask = DMA_BIT_MASK(ARCH_ZONE_DMA_BITS);
> 	else
> 		min_mask = DMA_BIT_MASK(32);
> 
> 	min_mask = min_t(u64, min_mask,	(max_pfn - 1) << PAGE_SHIFT);
> 
> In "theory" it's also ok to have a mask < ZONE_DMA_BITS as long as it's
> big enough to fit all memory :-)

Yeah, we could do that.
