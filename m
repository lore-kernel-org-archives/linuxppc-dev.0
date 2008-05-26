Return-Path: <markn@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (E23SMTP03.au.ibm.com [202.81.18.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5F1D3DDFAF
	for <linuxppc-dev@ozlabs.org>; Mon, 26 May 2008 14:19:32 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id m4Q4IdBC020994
	for <linuxppc-dev@ozlabs.org>; Mon, 26 May 2008 14:18:40 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4Q4JGP74403302
	for <linuxppc-dev@ozlabs.org>; Mon, 26 May 2008 14:19:16 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4Q4JUkl031784
	for <linuxppc-dev@ozlabs.org>; Mon, 26 May 2008 14:19:30 +1000
Message-Id: <20080526041942.253059496@au1.ibm.com>
References: <20080526041430.324464061@au1.ibm.com>
Date: Mon, 26 May 2008 14:14:31 +1000
From: markn@au1.ibm.com
To: linuxppc-dev@ozlabs.org
Subject: [patch 1/6] Add struct iommu_table argument to iommu_map_sg()
Cc: Mark Nelson <markn@au1.ibm.com>, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Make iommu_map_sg take a struct iommu_table. It did so before commit
740c3ce66700640a6e6136ff679b067e92125794 (iommu sg merging: ppc: make
iommu respect the segment size limits).

This stops the function looking in the archdata.dma_data for the iommu
table because in the future it will be called with a device that has
no table there.

This also has the nice side effect of making iommu_map_sg() match the
other map functions.

Signed-off-by: Mark Nelson <markn@au1.ibm.com>
---
 arch/powerpc/kernel/dma_64.c |    2 +-
 arch/powerpc/kernel/iommu.c  |    7 +++----
 include/asm-powerpc/iommu.h  |    6 +++---
 3 files changed, 7 insertions(+), 8 deletions(-)

Index: upstream/arch/powerpc/kernel/dma_64.c
===================================================================
--- upstream.orig/arch/powerpc/kernel/dma_64.c
+++ upstream/arch/powerpc/kernel/dma_64.c
@@ -68,7 +68,7 @@ static void dma_iommu_unmap_single(struc
 static int dma_iommu_map_sg(struct device *dev, struct scatterlist *sglist,
 			    int nelems, enum dma_data_direction direction)
 {
-	return iommu_map_sg(dev, sglist, nelems,
+	return iommu_map_sg(dev, dev->archdata.dma_data, sglist, nelems,
 			    device_to_mask(dev), direction);
 }
 
Index: upstream/arch/powerpc/kernel/iommu.c
===================================================================
--- upstream.orig/arch/powerpc/kernel/iommu.c
+++ upstream/arch/powerpc/kernel/iommu.c
@@ -267,11 +267,10 @@ static void iommu_free(struct iommu_tabl
 	spin_unlock_irqrestore(&(tbl->it_lock), flags);
 }
 
-int iommu_map_sg(struct device *dev, struct scatterlist *sglist,
-		 int nelems, unsigned long mask,
-		 enum dma_data_direction direction)
+int iommu_map_sg(struct device *dev, struct iommu_table *tbl,
+		 struct scatterlist *sglist, int nelems,
+		 unsigned long mask, enum dma_data_direction direction)
 {
-	struct iommu_table *tbl = dev->archdata.dma_data;
 	dma_addr_t dma_next = 0, dma_addr;
 	unsigned long flags;
 	struct scatterlist *s, *outs, *segstart;
Index: upstream/include/asm-powerpc/iommu.h
===================================================================
--- upstream.orig/include/asm-powerpc/iommu.h
+++ upstream/include/asm-powerpc/iommu.h
@@ -79,9 +79,9 @@ extern void iommu_free_table(struct iomm
 extern struct iommu_table *iommu_init_table(struct iommu_table * tbl,
 					    int nid);
 
-extern int iommu_map_sg(struct device *dev, struct scatterlist *sglist,
-			int nelems, unsigned long mask,
-			enum dma_data_direction direction);
+extern int iommu_map_sg(struct device *dev, struct iommu_table *tbl,
+			struct scatterlist *sglist, int nelems,
+			unsigned long mask, enum dma_data_direction direction);
 extern void iommu_unmap_sg(struct iommu_table *tbl, struct scatterlist *sglist,
 			   int nelems, enum dma_data_direction direction);
 

-- 
