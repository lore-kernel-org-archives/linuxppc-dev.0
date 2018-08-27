Return-Path: <oss@buserror.net>
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41zQj76k3KzDrJ7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Aug 2018 18:56:11 +1000 (AEST)
Message-ID: <f48ee881bf38c97575202a8921bf8df2ff2136cb.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christoph Hellwig
 <hch@lst.de>, Paul Mackerras <paulus@samba.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Tony Luck <tony.luck@intel.com>, Fenghua Yu
 <fenghua.yu@intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Robin Murphy
 <robin.murphy@arm.com>, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux-foundation.org, linux-ia64@vger.kernel.org
Date: Mon, 27 Aug 2018 03:51:23 -0500
In-Reply-To: <4d5c934ea7bc9802eb3653e6afe7583cb05e4484.camel@kernel.crashing.org>
References: <20180730163824.10064-1-hch@lst.de>
 <20180730163824.10064-17-hch@lst.de>
 <4d5c934ea7bc9802eb3653e6afe7583cb05e4484.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH 16/20] powerpc/dma: use dma_direct_{alloc,free}
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-08-09 at 10:52 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2018-07-30 at 18:38 +0200, Christoph Hellwig wrote:
> > These do the same functionality as the existing helpers, but do it
> > simpler, and also allow the (optional) use of CMA.
> > 
> > Note that the swiotlb code now calls into the dma_direct code directly,
> > given that it doesn't work with noncoherent caches at all, and isn't
> > called
> > when we have an iommu either, so the iommu special case in
> > dma_nommu_alloc_coherent isn't required for swiotlb.
> 
> I am not convinced that this will produce the same results due to
> the way the zone picking works.
> 
> As for the interaction with swiotlb, we'll need the FSL guys to have
> a look. Scott, do you remember what this is about ?

dma_direct_alloc() has similar (though not identical[1]) zone picking, so I
think it will work.  Needs testing though, and I no longer have a book3e
machine with a PCIe card in it.

The odd thing about this platform (fsl book3e) is the 31-bit[2] limitation on
PCI.  We currently use ZONE_DMA32 for this, rather than ZONE_DMA, at Ben's
request[3].  dma_direct_alloc() regards ZONE_DMA32 as being fixed at 32-bits,
but it doesn't really matter as long as limit_zone_pfn() still works, and the
allocation is made below 2 GiB.  If we were to switch to ZONE_DMA, and have
both 31-bit and 32-bit zones, then dma_direct_alloc() would have a problem
knowing when to use the 31-bit zone since it's based on a non-power-of-2 limit
that isn't reflected in the dma mask.

-Scott

[1] The logic in dma_direct_alloc() seems wrong -- the zone should need to fit
in the mask, not the other way around.  If ARCH_ZONE_DMA_BITS is 24, then
0x007fffff should be a failure rather than GFP_DMA, 0x7fffffff should be
GFP_DMA rather than GFP_DMA32, and 0x3ffffffff should be GFP_DMA32 rather than
an unrestricted allocation (in each case assuming that the end of RAM is
beyond the mask).

[2] The actual limit is closer to 4 GiB, but not quite due to special windows.
 swiotlb still uses the real limit when deciding whether to bounce, so the dma
mask is still 32 bits.

[3] https://lists.ozlabs.org/pipermail/linuxppc-dev/2012-July/099593.html
