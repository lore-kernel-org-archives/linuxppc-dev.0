Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 9CC43DDF59
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 05:15:09 +1100 (EST)
Message-Id: <20071218175105.263700000@arndb.de>
References: <20071218174852.112644000@arndb.de>
Date: Tue, 18 Dec 2007 18:49:01 +0100
From: arnd@arndb.de
To: paulus@samba.org
Subject: [POWERPC 09/18] Remove the global dma_direct_offset
Cc: linuxppc-dev@ozlabs.org
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
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/kernel/dma_64.c      |    7 ++++---
 include/asm-powerpc/dma-mapping.h |    2 --
 2 files changed, 4 insertions(+), 5 deletions(-)

Index: linux-2.6-new/arch/powerpc/kernel/dma_64.c
===================================================================
--- linux-2.6-new.orig/arch/powerpc/kernel/dma_64.c
+++ linux-2.6-new/arch/powerpc/kernel/dma_64.c
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
Index: linux-2.6-new/include/asm-powerpc/dma-mapping.h
===================================================================
--- linux-2.6-new.orig/include/asm-powerpc/dma-mapping.h
+++ linux-2.6-new/include/asm-powerpc/dma-mapping.h
@@ -186,8 +186,6 @@ static inline void dma_unmap_sg(struct d
 extern struct dma_mapping_ops dma_iommu_ops;
 extern struct dma_mapping_ops dma_direct_ops;
 
-extern unsigned long dma_direct_offset;
-
 #else /* CONFIG_PPC64 */
 
 #define dma_supported(dev, mask)	(1)

-- 
