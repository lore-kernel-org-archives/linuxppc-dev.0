Return-Path: <arnd@arndb.de>
Message-Id: <20080704190806.831029912@arndb.de>
References: <20080704190535.316377278@arndb.de>
Date: Fri, 04 Jul 2008 21:05:45 +0200
From: arnd@arndb.de
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch 10/11] powerpc: move device_to_mask() to dma-mapping.h
Cc: Mark Nelson <markn@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Move device_to_mask() to dma-mapping.h because we need to use it from
outside dma_64.c in a later patch.

Signed-off-by: Mark Nelson <markn@au1.ibm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/kernel/dma_64.c      |    9 ---------
 include/asm-powerpc/dma-mapping.h |    9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/dma_64.c b/arch/powerpc/kernel/dma_64.c
index 3ae0c35..ae5708e 100644
--- a/arch/powerpc/kernel/dma_64.c
+++ b/arch/powerpc/kernel/dma_64.c
@@ -15,15 +15,6 @@
  * Generic iommu implementation
  */
 
-static inline unsigned long device_to_mask(struct device *dev)
-{
-	if (dev->dma_mask && *dev->dma_mask)
-		return *dev->dma_mask;
-	/* Assume devices without mask can take 32 bit addresses */
-	return 0xfffffffful;
-}
-
-
 /* Allocates a contiguous real buffer and creates mappings over it.
  * Returns the virtual address of the buffer and sets dma_handle
  * to the dma address (mapping) of the first page.
diff --git a/include/asm-powerpc/dma-mapping.h b/include/asm-powerpc/dma-mapping.h
index de13950..74c5497 100644
--- a/include/asm-powerpc/dma-mapping.h
+++ b/include/asm-powerpc/dma-mapping.h
@@ -45,6 +45,15 @@ extern void __dma_sync_page(struct page *page, unsigned long offset,
 #endif /* ! CONFIG_NOT_COHERENT_CACHE */
 
 #ifdef CONFIG_PPC64
+
+static inline unsigned long device_to_mask(struct device *dev)
+{
+	if (dev->dma_mask && *dev->dma_mask)
+		return *dev->dma_mask;
+	/* Assume devices without mask can take 32 bit addresses */
+	return 0xfffffffful;
+}
+
 /*
  * DMA operations are abstracted for G5 vs. i/pSeries, PCI vs. VIO
  */
-- 
1.5.4.3

-- 
