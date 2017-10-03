Return-Path: <BATV+69bb01a06caa5cf26dd3+5154+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y5wcP19HSzDql7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 21:43:30 +1100 (AEDT)
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Michal Simek <monstr@monstr.eu>,
 David Howells <dhowells@redhat.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 x86@kernel.org, linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: refactor dma_cache_sync V2
Date: Tue,  3 Oct 2017 12:43:00 +0200
Message-Id: <20171003104311.10058-1-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The dma_cache_sync routines is used to flush caches for memory returned
by dma_alloc_attrs with the DMA_ATTR_NON_CONSISTENT flag (or previously
from dma_alloc_noncoherent), but the requirements for it seems to be
frequently misunderstood.  dma_cache_sync is documented to be a no-op for
allocations that do not have the DMA_ATTR_NON_CONSISTENT flag set, and
yet a lot of architectures implement it in some way despite not
implementing DMA_ATTR_NON_CONSISTENT.

This series removes a few abuses of dma_cache_sync for non-DMA API
purposes, then changes all remaining architectures that do not implement
DMA_ATTR_NON_CONSISTENT to implement dma_cache_sync as a no-op, and
then adds the struct dma_map_ops indirection we use for all other
DMA mapping operations to dma_cache_sync as well, thus removing all but
two implementations of the function.

Changes since V1:
 - drop the mips fd_cacheflush, merged via maintainer
 - spelling fix in last commit descriptions (thanks Geert)
