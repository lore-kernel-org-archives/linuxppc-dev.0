Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wk70635qvzDqPm
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 00:21:41 +1000 (AEST)
Date: Thu, 08 Jun 2017 10:21:36 -0400 (EDT)
Message-Id: <20170608.102136.2294569179855411095.davem@davemloft.net>
To: hch@lst.de
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
 linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-mips@linux-mips.org, openrisc@lists.librecores.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
 linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: clean up and modularize arch dma_mapping interface
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170608132609.32662-1-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Christoph Hellwig <hch@lst.de>
Date: Thu,  8 Jun 2017 15:25:25 +0200

> for a while we have a generic implementation of the dma mapping routines
> that call into per-arch or per-device operations.  But right now there
> still are various bits in the interfaces where don't clearly operate
> on these ops.  This series tries to clean up a lot of those (but not all
> yet, but the series is big enough).  It gets rid of the DMA_ERROR_CODE
> way of signaling failures of the mapping routines from the
> implementations to the generic code (and cleans up various drivers that
> were incorrectly using it), and gets rid of the ->set_dma_mask routine
> in favor of relying on the ->dma_capable method that can be used in
> the same way, but which requires less code duplication.

There is unlikely to be conflicts for the sparc and net changes, so I
will simply ACK them.

Thanks Christoph.
