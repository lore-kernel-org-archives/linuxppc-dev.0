Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wptym1xfdzDq88
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 18:37:03 +1000 (AEST)
Date: Fri, 16 Jun 2017 10:37:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
 linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-mips@linux-mips.org, openrisc@lists.librecores.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
 linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/44] iommu/dma: don't rely on DMA_ERROR_CODE
Message-ID: <20170616083700.GA10582@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
 <20170608132609.32662-7-hch@lst.de>
 <0bfb0841-f054-78de-628d-a0955336bcb4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0bfb0841-f054-78de-628d-a0955336bcb4@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 08, 2017 at 02:59:07PM +0100, Robin Murphy wrote:
> Hi Christoph,
> 
> On 08/06/17 14:25, Christoph Hellwig wrote:
> > DMA_ERROR_CODE is not a public API and will go away soon.  dma dma-iommu
> > driver already implements a proper ->mapping_error method, so it's only
> > using the value internally.  Add a new local define using the value
> > that arm64 which is the only current user of dma-iommu.
> 
> It would be fine to just use 0, since dma-iommu already makes sure that
> that will never be allocated for a valid DMA address.

I'll change it to 0.

> Otherwise, looks good!

Can you give me a formal ACK or Reviewed-by: ?
