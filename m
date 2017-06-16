Return-Path: <BATV+48ca1ab4adaecdf09dc3+5045+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wq7jD6Ty8zDq8B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Jun 2017 04:11:12 +1000 (AEST)
From: Christoph Hellwig <hch@lst.de>
To: x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
 linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-mips@linux-mips.org, openrisc@lists.librecores.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
 linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: clean up and modularize arch dma_mapping interface V2
Date: Fri, 16 Jun 2017 20:10:15 +0200
Message-Id: <20170616181059.19206-1-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

for a while we have a generic implementation of the dma mapping routines
that call into per-arch or per-device operations.  But right now there
still are various bits in the interfaces where don't clearly operate
on these ops.  This series tries to clean up a lot of those (but not all
yet, but the series is big enough).  It gets rid of the DMA_ERROR_CODE
way of signaling failures of the mapping routines from the
implementations to the generic code (and cleans up various drivers that
were incorrectly using it), and gets rid of the ->set_dma_mask routine
in favor of relying on the ->dma_capable method that can be used in
the same way, but which requires less code duplication.

I've got a good number of reviews last time, but a few are still missing.
I'd love to not have to re-spam everyone with this patchbomb, so early
ACKs (or complaints) are welcome.

I plan to create a new dma-mapping tree to collect all this work.
Any volunteers for co-maintainers, especially from the iommu gang?

The whole series is also available in git:

    git://git.infradead.org/users/hch/misc.git dma-map

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-map

Changes since V1:
 - remove two lines of code from arm dmabounce
 - a few commit message tweaks
 - lots of ACKs
