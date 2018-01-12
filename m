Return-Path: <BATV+b628242e4f103a69f336+5255+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHx8d1N0KzF0c0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 19:42:54 +1100 (AEDT)
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Cc: Konrad Rzeszutek Wilk <konrad@darnok.org>, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
 linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
 Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 patches@groups.riscv.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: consolidate direct dma mapping V4
Date: Fri, 12 Jan 2018 09:41:58 +0100
Message-Id: <20180112084232.2857-1-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Almost every architecture supports a direct dma mapping implementation,
where no iommu is used and the device dma address is a 1:1 mapping to
the physical address or has a simple linear offset.  Currently the
code for this implementation is most duplicated over the architectures,
and the duplicated again in the swiotlb code, and then duplicated again
for special cases like the x86 memory encryption DMA ops.

This series takes the existing very simple dma-noop dma mapping
implementation, enhances it with all the x86 features and quirks, and
creates a common set of architecture hooks for it and the swiotlb code.

It then switches a number of architectures to this generic
direct map implemention.

Note that for now this only handles architectures that do cache coherent
DMA, but a similar consolidation for non-coherent architectures is in the
work for later merge windows.

A git tree is also available:

   git://git.infradead.org/users/hch/misc.git dma-direct.3

Gitweb:

   http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-direct.3

Changes since V3
 - new patch to fix an off-by-one in mips dma_capable
Changes since V2:
 - fixed a few patch description typos
 - fixed a few printk formats
 - fixed an off by one in dma_coherent_ok
 - add a few Reviewed-by/Acked-by tags.
 - moved the swiotlb consolidation to a new series
 - dropped a few patches for now to not overwhelem the x86
   maintainers.  They will be resubmitted in the next merge window
