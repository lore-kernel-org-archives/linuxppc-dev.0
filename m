Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <854cf7522a012469ff1af0b90e874cb96c4d1a37.1196839256.git.michael@ellerman.id.au>
In-Reply-To: <ac4252cfbaa0c1a3534443007417dfc43b597eb5.1196839256.git.michael@ellerman.id.au>
References: <ac4252cfbaa0c1a3534443007417dfc43b597eb5.1196839256.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 6/7] Remove the global dma_direct_offset
Date: Wed,  5 Dec 2007 18:21:05 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We no longer need the global dma_direct_offset, update the comment to
reflect the new reality.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/dma_64.c      |    7 ++++---
 include/asm-powerpc/dma-mapping.h |    2 --
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/dma_64.c b/arch/powerpc/kernel/dma_64.c
index 19d5fb0..26c0d8c 100644
--- a/arch/powerpc/kernel/dma_64.c
+++ b/arch/powerpc/kernel/dma_64.c
@@ -112,10 +112,11 @@ EXPORT_SYMBOL(dma_iommu_ops);
 /*
  * Generic direct DMA implementation
  *
- * This implementation supports a global offset that can be applied if
- * the address at which memory is visible to devices is not 0.
+ * This implementation supports a per-device offset that can be applied if
+ * the address at which memory is visible to devices is not 0. Platform code
+ * can point archdata.dma_data at an unsigned long holding the offset. By
+ * default no offset is used.
  */
-unsigned long dma_direct_offset;
 
 static unsigned long get_dma_direct_offset(struct device *dev)
 {
diff --git a/include/asm-powerpc/dma-mapping.h b/include/asm-powerpc/dma-mapping.h
index ff52013..d9b429a 100644
--- a/include/asm-powerpc/dma-mapping.h
+++ b/include/asm-powerpc/dma-mapping.h
@@ -186,8 +186,6 @@ static inline void dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 extern struct dma_mapping_ops dma_iommu_ops;
 extern struct dma_mapping_ops dma_direct_ops;
 
-extern unsigned long dma_direct_offset;
-
 #else /* CONFIG_PPC64 */
 
 #define dma_supported(dev, mask)	(1)
-- 
1.5.3.7.1.g4e596e
