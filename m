Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41M7Qh4f8qzF204
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jul 2018 05:36:43 +1000 (AEST)
Date: Thu, 5 Jul 2018 21:37:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: hch@lst.de, m.szyprowski@samsung.com, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 1/2] dma-mapping: Clean up dma_set_*mask() hooks
Message-ID: <20180705193738.GB28905@lst.de>
References: <55ac9550c311f056dcfeed9b2c8265375f17b155.1530726467.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55ac9550c311f056dcfeed9b2c8265375f17b155.1530726467.git.robin.murphy@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 04, 2018 at 06:50:11PM +0100, Robin Murphy wrote:
> Arch-specific implementions for dma_set_{coherent_,}mask() currently
> rely on an inconsistent mix of arch-defined Kconfig symbols and macro
> overrides. Now that we have a nice centralised home for DMA API gubbins,
> let's consolidate these loose ends under consistent config options.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> Here's hoping the buildbot comes by to point out what I've inevitably
> missed, although I did check a cursory cross-compile of ppc64_defconfig
> to iron out the obvious howlers.

The patch looks sensible to me, although I was hoping to get rid of these
hooks in this or the next merge window as they are a horrible bad idea.

> The motivation here is that I'm looking at adding set_mask overrides
> for arm64, and having discovered a bit of a mess it seemed prudent to
> clean up before ingraining it any more.

What are you trying to do?  I really don't want to see more users of
the hooks as they are are a horribly bad idea.
