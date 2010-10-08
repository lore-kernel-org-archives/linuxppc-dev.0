Return-Path: <nacc@us.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CD3D1100817
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  9 Oct 2010 04:33:37 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e38.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o98HPg6h006066
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Oct 2010 11:25:42 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	o98HXWrO249962
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Oct 2010 11:33:32 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o98HXVhs014315
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Oct 2010 11:33:32 -0600
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: nacc@us.ibm.com
Subject: [RFC PATCH 02/11] ppc: allow direct and iommu to coexist
Date: Fri,  8 Oct 2010 10:33:03 -0700
Message-Id: <1286559192-10898-3-git-send-email-nacc@us.ibm.com>
In-Reply-To: <1286559192-10898-1-git-send-email-nacc@us.ibm.com>
References: <1286559192-10898-1-git-send-email-nacc@us.ibm.com>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	linux-kernel@vger.kernel.org, miltonm@bga.com,
	Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Replace the union with just the multiple fields, ifdef on CONFIG_PPC64.

Future pseries boxes will allow a 64 bit dma mapping covering all
memory, coexisting with a smaller iommu window in 32 bit pci space.

The cell fixed mapping would also like both to coexist.

Signed-off-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
---
I used the ifdef guard of CONFIG_PPC64 according to the current makefile
for iommu.c.  One set is burried in the middle of iommu.h.
---
 arch/powerpc/include/asm/device.h      |   14 ++++++--------
 arch/powerpc/include/asm/dma-mapping.h |    4 ++--
 arch/powerpc/include/asm/iommu.h       |    6 ++++--
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/device.h b/arch/powerpc/include/asm/device.h
index 16d25c0..ed883ea 100644
--- a/arch/powerpc/include/asm/device.h
+++ b/arch/powerpc/include/asm/device.h
@@ -19,14 +19,12 @@ struct dev_archdata {
 	/* DMA operations on that device */
 	struct dma_map_ops	*dma_ops;
 
-	/*
-	 * When an iommu is in use, dma_data is used as a ptr to the base of the
-	 * iommu_table.  Otherwise, it is a simple numerical offset.
-	 */
-	union {
-		dma_addr_t	dma_offset;
-		void		*iommu_table_base;
-	} dma_data;
+	/* dma_offset is used by swiotlb and direct dma ops, but no iommu */
+	dma_addr_t	dma_offset;
+
+#ifdef CONFIG_PPC64
+	void		*iommu_table_base;
+#endif
 
 #ifdef CONFIG_SWIOTLB
 	dma_addr_t		max_direct_dma_addr;
diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 8c9c6ad..644103a 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -100,7 +100,7 @@ static inline void set_dma_ops(struct device *dev, struct dma_map_ops *ops)
 static inline dma_addr_t get_dma_offset(struct device *dev)
 {
 	if (dev)
-		return dev->archdata.dma_data.dma_offset;
+		return dev->archdata.dma_offset;
 
 	return PCI_DRAM_OFFSET;
 }
@@ -108,7 +108,7 @@ static inline dma_addr_t get_dma_offset(struct device *dev)
 static inline void set_dma_offset(struct device *dev, dma_addr_t off)
 {
 	if (dev)
-		dev->archdata.dma_data.dma_offset = off;
+		dev->archdata.dma_offset = off;
 }
 
 /* this will be removed soon */
diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index edfc980..0f605a4 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -70,15 +70,17 @@ struct iommu_table {
 
 struct scatterlist;
 
+#ifdef CONFIG_PPC64
 static inline void set_iommu_table_base(struct device *dev, void *base)
 {
-	dev->archdata.dma_data.iommu_table_base = base;
+	dev->archdata.iommu_table_base = base;
 }
 
 static inline void *get_iommu_table_base(struct device *dev)
 {
-	return dev->archdata.dma_data.iommu_table_base;
+	return dev->archdata.iommu_table_base;
 }
+#endif
 
 /* Frees table for an individual device node */
 extern void iommu_free_table(struct iommu_table *tbl, const char *node_name);
-- 
1.7.1
