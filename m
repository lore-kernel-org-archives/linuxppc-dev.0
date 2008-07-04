Return-Path: <arnd@arndb.de>
Message-Id: <20080704190806.699999227@arndb.de>
References: <20080704190535.316377278@arndb.de>
Date: Fri, 04 Jul 2008 21:05:44 +0200
From: arnd@arndb.de
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch 09/11] powerpc/cell: cell_dma_dev_setup_iommu() return the
	iommu table
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

Make cell_dma_dev_setup_iommu() return a pointer to the struct iommu_table
(or NULL if no table can be found) rather than putting this pointer into
dev->archdata.dma_data (let the caller do that), and rename this function
to cell_get_iommu_table() to reflect this change.

This will allow us to get the iommu table for a device that doesn't have
the table in the archdata.

Signed-off-by: Mark Nelson <markn@au1.ibm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/cell/iommu.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index b4fe598..3b70784 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -541,7 +541,7 @@ static unsigned long cell_dma_direct_offset;
 static unsigned long dma_iommu_fixed_base;
 struct dma_mapping_ops dma_iommu_fixed_ops;
 
-static void cell_dma_dev_setup_iommu(struct device *dev)
+static struct iommu_table *cell_get_iommu_table(struct device *dev)
 {
 	struct iommu_window *window;
 	struct cbe_iommu *iommu;
@@ -556,11 +556,11 @@ static void cell_dma_dev_setup_iommu(struct device *dev)
 		printk(KERN_ERR "iommu: missing iommu for %s (node %d)\n",
 		       archdata->of_node ? archdata->of_node->full_name : "?",
 		       archdata->numa_node);
-		return;
+		return NULL;
 	}
 	window = list_entry(iommu->windows.next, struct iommu_window, list);
 
-	archdata->dma_data = &window->table;
+	return &window->table;
 }
 
 static void cell_dma_dev_setup_fixed(struct device *dev);
@@ -573,7 +573,7 @@ static void cell_dma_dev_setup(struct device *dev)
 	if (get_dma_ops(dev) == &dma_iommu_fixed_ops)
 		cell_dma_dev_setup_fixed(dev);
 	else if (get_pci_dma_ops() == &dma_iommu_ops)
-		cell_dma_dev_setup_iommu(dev);
+		archdata->dma_data = cell_get_iommu_table(dev);
 	else if (get_pci_dma_ops() == &dma_direct_ops)
 		archdata->dma_data = (void *)cell_dma_direct_offset;
 	else
-- 
1.5.4.3

-- 
