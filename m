Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6FAFDB712E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 31 Aug 2010 15:23:55 +1000 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id o7V5NoGw001988
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Aug 2010 00:23:51 -0500
Subject: [PATCH 1/2] powerpc/dma: Add optional platform override of
	dma_set_mask()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 31 Aug 2010 15:23:52 +1000
Message-ID: <1283232232.2151.12.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some platforms may want to override dma_set_mask() to take into
account some specific "features" such as the availability of
a direct-map window in addition to an iommu.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/dma-mapping.h |   14 +-------------
 arch/powerpc/include/asm/machdep.h     |    3 +++
 arch/powerpc/kernel/dma.c              |   18 ++++++++++++++++++
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index c85ef23..ce6e78c 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -127,19 +127,7 @@ static inline int dma_supported(struct device *dev, u64 mask)
 	return dma_ops->dma_supported(dev, mask);
 }
 
-static inline int dma_set_mask(struct device *dev, u64 dma_mask)
-{
-	struct dma_map_ops *dma_ops = get_dma_ops(dev);
-
-	if (unlikely(dma_ops == NULL))
-		return -EIO;
-	if (dma_ops->set_dma_mask != NULL)
-		return dma_ops->set_dma_mask(dev, dma_mask);
-	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
-		return -EIO;
-	*dev->dma_mask = dma_mask;
-	return 0;
-}
+extern int dma_set_mask(struct device *dev, u64 dma_mask);
 
 static inline void *dma_alloc_coherent(struct device *dev, size_t size,
 				       dma_addr_t *dma_handle, gfp_t flag)
diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 9f0fc9e..41582c3 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -102,6 +102,9 @@ struct machdep_calls {
 	void		(*pci_dma_dev_setup)(struct pci_dev *dev);
 	void		(*pci_dma_bus_setup)(struct pci_bus *bus);
 
+	/* Platform set_dma_mask override */
+	int		(*dma_set_mask)(struct device *dev, u64 dma_mask);
+
 	int		(*probe)(void);
 	void		(*setup_arch)(void); /* Optional, may be NULL */
 	void		(*init_early)(void);
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 84d6367..f368c07 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -12,6 +12,7 @@
 #include <linux/memblock.h>
 #include <asm/bug.h>
 #include <asm/abs_addr.h>
+#include <asm/machdep.h>
 
 /*
  * Generic direct DMA implementation
@@ -154,6 +155,23 @@ EXPORT_SYMBOL(dma_direct_ops);
 
 #define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
 
+int dma_set_mask(struct device *dev, u64 dma_mask)
+{
+	struct dma_map_ops *dma_ops = get_dma_ops(dev);
+
+	if (ppc_md.dma_set_mask)
+		return ppc_md.dma_set_mask(dev, dma_mask);
+	if (unlikely(dma_ops == NULL))
+		return -EIO;
+	if (dma_ops->set_dma_mask != NULL)
+		return dma_ops->set_dma_mask(dev, dma_mask);
+	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
+		return -EIO;
+	*dev->dma_mask = dma_mask;
+	return 0;
+}
+EXPORT_SYMBOL(dma_set_mask);
+
 static int __init dma_init(void)
 {
        dma_debug_init(PREALLOC_DMA_DEBUG_ENTRIES);
