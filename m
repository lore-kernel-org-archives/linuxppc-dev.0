Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 62617DDDF4
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Aug 2007 01:41:28 +1000 (EST)
From: Segher Boessenkool <segher@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Replace a few #defines with empty inline functions
Date: Wed,  1 Aug 2007 17:41:15 +0200
Message-Id: <11859828792347-git-send-email-segher@kernel.crashing.org>
In-Reply-To: <11859828781513-git-send-email-segher@kernel.crashing.org>
References: <11859828761541-git-send-email-segher@kernel.crashing.org>
	<11859828781513-git-send-email-segher@kernel.crashing.org>
Message-Id: <4533e849af9996f5f9ce038e37bf67c4c9012a87.1185982410.git.segher@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

...so that GCC doesn't complain about unused variables in the
callers of these.

Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
---
 include/asm-powerpc/dma-mapping.h |   24 ++++++++++++++++++------
 1 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/include/asm-powerpc/dma-mapping.h b/include/asm-powerpc/dma-mapping.h
index f6bd804..22b3c40 100644
--- a/include/asm-powerpc/dma-mapping.h
+++ b/include/asm-powerpc/dma-mapping.h
@@ -249,8 +249,12 @@ dma_map_single(struct device *dev, void *ptr, size_t size,
 	return virt_to_bus(ptr);
 }
 
-/* We do nothing. */
-#define dma_unmap_single(dev, addr, size, dir)	((void)0)
+static inline void dma_unmap_single(struct device *dev, dma_addr_t dma_addr,
+				    size_t size,
+				    enum dma_data_direction direction)
+{
+	/* We do nothing. */
+}
 
 static inline dma_addr_t
 dma_map_page(struct device *dev, struct page *page,
@@ -264,8 +268,12 @@ dma_map_page(struct device *dev, struct page *page,
 	return page_to_bus(page) + offset;
 }
 
-/* We do nothing. */
-#define dma_unmap_page(dev, handle, size, dir)	((void)0)
+static inline void dma_unmap_page(struct device *dev, dma_addr_t dma_address,
+				  size_t size,
+				  enum dma_data_direction direction)
+{
+	/* We do nothing. */
+}
 
 static inline int
 dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
@@ -284,8 +292,12 @@ dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 	return nents;
 }
 
-/* We don't do anything here. */
-#define dma_unmap_sg(dev, sg, nents, dir)	((void)0)
+static inline void dma_unmap_sg(struct device *dev, struct scatterlist *sg,
+				int nhwentries,
+				enum dma_data_direction direction)
+{
+	/* We don't do anything here. */
+}
 
 #endif /* CONFIG_PPC64 */
 
-- 
1.5.2.1.144.gabc40-dirty
