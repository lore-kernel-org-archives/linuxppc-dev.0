Return-Path: <BATV+eb06f239ea6f59aeb59b+5037+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wk5pL3xTqzDqLx
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 23:28:10 +1000 (AEST)
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
Subject: [PATCH 26/44] dma-mapping: remove DMA_ERROR_CODE
Date: Thu,  8 Jun 2017 15:25:51 +0200
Message-Id: <20170608132609.32662-27-hch@lst.de>
In-Reply-To: <20170608132609.32662-1-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

And update the documentation - dma_mapping_error has been supported
everywhere for a long time.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/DMA-API-HOWTO.txt | 31 +++++--------------------------
 include/linux/dma-mapping.h     |  5 -----
 2 files changed, 5 insertions(+), 31 deletions(-)

diff --git a/Documentation/DMA-API-HOWTO.txt b/Documentation/DMA-API-HOWTO.txt
index 979228bc9035..4ed388356898 100644
--- a/Documentation/DMA-API-HOWTO.txt
+++ b/Documentation/DMA-API-HOWTO.txt
@@ -550,32 +550,11 @@ and to unmap it:
 	dma_unmap_single(dev, dma_handle, size, direction);
 
 You should call dma_mapping_error() as dma_map_single() could fail and return
-error. Not all DMA implementations support the dma_mapping_error() interface.
-However, it is a good practice to call dma_mapping_error() interface, which
-will invoke the generic mapping error check interface. Doing so will ensure
-that the mapping code will work correctly on all DMA implementations without
-any dependency on the specifics of the underlying implementation. Using the
-returned address without checking for errors could result in failures ranging
-from panics to silent data corruption. A couple of examples of incorrect ways
-to check for errors that make assumptions about the underlying DMA
-implementation are as follows and these are applicable to dma_map_page() as
-well.
-
-Incorrect example 1:
-	dma_addr_t dma_handle;
-
-	dma_handle = dma_map_single(dev, addr, size, direction);
-	if ((dma_handle & 0xffff != 0) || (dma_handle >= 0x1000000)) {
-		goto map_error;
-	}
-
-Incorrect example 2:
-	dma_addr_t dma_handle;
-
-	dma_handle = dma_map_single(dev, addr, size, direction);
-	if (dma_handle == DMA_ERROR_CODE) {
-		goto map_error;
-	}
+error.  Doing so will ensure that the mapping code will work correctly on all
+DMA implementations without any dependency on the specifics of the underlying
+implementation. Using the returned address without checking for errors could
+result in failures ranging from panics to silent data corruption.  The same
+applies to dma_map_page() as well.
 
 You should call dma_unmap_single() when the DMA activity is finished, e.g.,
 from the interrupt which told you that the DMA transfer is done.
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 4f3eecedca2d..a57875309bfd 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -546,12 +546,7 @@ static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 
 	if (get_dma_ops(dev)->mapping_error)
 		return get_dma_ops(dev)->mapping_error(dev, dma_addr);
-
-#ifdef DMA_ERROR_CODE
-	return dma_addr == DMA_ERROR_CODE;
-#else
 	return 0;
-#endif
 }
 
 #ifndef HAVE_ARCH_DMA_SUPPORTED
-- 
2.11.0
