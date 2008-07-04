Return-Path: <arnd@arndb.de>
Message-Id: <20080704190806.295617645@arndb.de>
References: <20080704190535.316377278@arndb.de>
Date: Fri, 04 Jul 2008 21:05:41 +0200
From: arnd@arndb.de
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch 06/11] powerpc: Add struct iommu_table argument to
	iommu_map_sg()
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

Make iommu_map_sg take a struct iommu_table. It did so before commit
740c3ce66700640a6e6136ff679b067e92125794 (iommu sg merging: ppc: make
iommu respect the segment size limits).

This stops the function looking in the archdata.dma_data for the iommu
table because in the future it will be called with a device that has
no table there.

This also has the nice side effect of making iommu_map_sg() match the
other map functions.

Signed-off-by: Mark Nelson <markn@au1.ibm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/kernel/dma_64.c |    2 +-
 arch/powerpc/kernel/iommu.c  |    7 +++----
 include/asm-powerpc/iommu.h  |    6 +++---
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/dma_64.c b/arch/powerpc/kernel/dma_64.c
index 3a317cb..7397445 100644
--- a/arch/powerpc/kernel/dma_64.c
+++ b/arch/powerpc/kernel/dma_64.c
@@ -68,7 +68,7 @@ static void dma_iommu_unmap_single(struct device *dev, dma_addr_t dma_handle,
 static int dma_iommu_map_sg(struct device *dev, struct scatterlist *sglist,
 			    int nelems, enum dma_data_direction direction)
 {
-	return iommu_map_sg(dev, sglist, nelems,
+	return iommu_map_sg(dev, dev->archdata.dma_data, sglist, nelems,
 			    device_to_mask(dev), direction);
 }
 
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 0c66366..ccf00fe 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -267,11 +267,10 @@ static void iommu_free(struct iommu_table *tbl, dma_addr_t dma_addr,
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
diff --git a/include/asm-powerpc/iommu.h b/include/asm-powerpc/iommu.h
index 852e15f..65f6682 100644
--- a/include/asm-powerpc/iommu.h
+++ b/include/asm-powerpc/iommu.h
@@ -79,9 +79,9 @@ extern void iommu_free_table(struct iommu_table *tbl, const char *node_name);
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
1.5.4.3

-- 
