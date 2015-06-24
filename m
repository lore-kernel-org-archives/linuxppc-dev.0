Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9D5C01A0034
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2015 15:25:28 +1000 (AEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id t5O5PMAn022073
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2015 00:25:24 -0500
Message-ID: <1435123522.3996.29.camel@kernel.crashing.org>
Subject: [PATCH 1/3] powerpc/iommu: Remove dma_data union
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 24 Jun 2015 15:25:22 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To support "hybrid" DMA ops in a subsequent patch, we will need both
a direct DMA offset and an iommu pointer. Those are currently exclusive
(a union), so change them to be separate fields.

While there, also type iommu_table_base properly and make exist only
on CONFIG_PPC64 since it's not referenced on 32-bit at all.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/device.h      | 15 +++++++++------
 arch/powerpc/include/asm/dma-mapping.h |  4 ++--
 arch/powerpc/include/asm/iommu.h       | 31 +++++++++++++++++++++++++------
 3 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/device.h b/arch/powerpc/include/asm/device.h
index e9bdda8..406c2b1 100644
--- a/arch/powerpc/include/asm/device.h
+++ b/arch/powerpc/include/asm/device.h
@@ -10,6 +10,7 @@ struct dma_map_ops;
 struct device_node;
 #ifdef CONFIG_PPC64
 struct pci_dn;
+struct iommu_table;
 #endif
 
 /*
@@ -23,13 +24,15 @@ struct dev_archdata {
 	struct dma_map_ops	*dma_ops;
 
 	/*
-	 * When an iommu is in use, dma_data is used as a ptr to the base of the
-	 * iommu_table.  Otherwise, it is a simple numerical offset.
+	 * These two used to be a union. However, with the hybrid ops we need
+	 * both so here we store both a DMA offset for direct mappings and
+	 * an iommu_table for remapped DMA.
 	 */
-	union {
-		dma_addr_t	dma_offset;
-		void		*iommu_table_base;
-	} dma_data;
+	dma_addr_t		dma_offset;
+
+#ifdef CONFIG_PPC64
+	struct iommu_table	*iommu_table_base;
+#endif
 
 #ifdef CONFIG_IOMMU_API
 	void			*iommu_domain;
diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 9103687..9cbbc9e 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -106,7 +106,7 @@ static inline void set_dma_ops(struct device *dev, struct dma_map_ops *ops)
 static inline dma_addr_t get_dma_offset(struct device *dev)
 {
 	if (dev)
-		return dev->archdata.dma_data.dma_offset;
+		return dev->archdata.dma_offset;
 
 	return PCI_DRAM_OFFSET;
 }
@@ -114,7 +114,7 @@ static inline dma_addr_t get_dma_offset(struct device *dev)
 static inline void set_dma_offset(struct device *dev, dma_addr_t off)
 {
 	if (dev)
-		dev->archdata.dma_data.dma_offset = off;
+		dev->archdata.dma_offset = off;
 }
 
 /* this will be removed soon */
diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index ca18cff..7b87bab 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -2,17 +2,17 @@
  * Copyright (C) 2001 Mike Corrigan & Dave Engebretsen, IBM Corporation
  * Rewrite, cleanup:
  * Copyright (C) 2004 Olof Johansson <olof@lixom.net>, IBM Corporation
- * 
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
- * 
+ *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- * 
+ *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
@@ -131,16 +131,21 @@ int get_iommu_order(unsigned long size, struct iommu_table *tbl)
 
 struct scatterlist;
 
-static inline void set_iommu_table_base(struct device *dev, void *base)
+#ifdef CONFIG_PPC64
+
+static inline void set_iommu_table_base(struct device *dev,
+					struct iommu_table *base)
 {
-	dev->archdata.dma_data.iommu_table_base = base;
+	dev->archdata.iommu_table_base = base;
 }
 
 static inline void *get_iommu_table_base(struct device *dev)
 {
-	return dev->archdata.dma_data.iommu_table_base;
+	return dev->archdata.iommu_table_base;
 }
 
+extern int dma_iommu_dma_supported(struct device *dev, u64 mask);
+
 /* Frees table for an individual device node */
 extern void iommu_free_table(struct iommu_table *tbl, const char *node_name);
 
@@ -225,6 +230,20 @@ static inline int __init tce_iommu_bus_notifier_init(void)
 }
 #endif /* !CONFIG_IOMMU_API */
 
+#else
+
+static inline void *get_iommu_table_base(struct device *dev)
+{
+	return NULL;
+}
+
+static inline int dma_iommu_dma_supported(struct device *dev, u64 mask)
+{
+	return 0;
+}
+
+#endif /* CONFIG_PPC64 */
+
 extern int ppc_iommu_map_sg(struct device *dev, struct iommu_table *tbl,
 			    struct scatterlist *sglist, int nelems,
 			    unsigned long mask,
