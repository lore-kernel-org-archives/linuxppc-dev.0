Return-Path: <markn@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (E23SMTP06.au.ibm.com [202.81.18.175])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E79D6DDFB5
	for <linuxppc-dev@ozlabs.org>; Mon, 26 May 2008 14:19:32 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id m4Q4J3vV020918
	for <linuxppc-dev@ozlabs.org>; Mon, 26 May 2008 14:19:03 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4Q4JH2p4403316
	for <linuxppc-dev@ozlabs.org>; Mon, 26 May 2008 14:19:17 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4Q4JVUk024955
	for <linuxppc-dev@ozlabs.org>; Mon, 26 May 2008 14:19:31 +1000
Message-Id: <20080526041943.572193044@au1.ibm.com>
References: <20080526041430.324464061@au1.ibm.com>
Date: Mon, 26 May 2008 14:14:34 +1000
From: markn@au1.ibm.com
To: linuxppc-dev@ozlabs.org
Subject: [patch 4/6] Make cell_dma_dev_setup_iommu() return the iommu table
Cc: Mark Nelson <markn@au1.ibm.com>, arnd@arndb.de
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
---
 arch/powerpc/platforms/cell/iommu.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: upstream/arch/powerpc/platforms/cell/iommu.c
===================================================================
--- upstream.orig/arch/powerpc/platforms/cell/iommu.c
+++ upstream/arch/powerpc/platforms/cell/iommu.c
@@ -541,7 +541,7 @@ static unsigned long cell_dma_direct_off
 static unsigned long dma_iommu_fixed_base;
 struct dma_mapping_ops dma_iommu_fixed_ops;
 
-static void cell_dma_dev_setup_iommu(struct device *dev)
+static struct iommu_table *cell_get_iommu_table(struct device *dev)
 {
 	struct iommu_window *window;
 	struct cbe_iommu *iommu;
@@ -556,11 +556,11 @@ static void cell_dma_dev_setup_iommu(str
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
@@ -573,7 +573,7 @@ static void cell_dma_dev_setup(struct de
 	if (get_dma_ops(dev) == &dma_iommu_fixed_ops)
 		cell_dma_dev_setup_fixed(dev);
 	else if (get_pci_dma_ops() == &dma_iommu_ops)
-		cell_dma_dev_setup_iommu(dev);
+		archdata->dma_data = cell_get_iommu_table(dev);
 	else if (get_pci_dma_ops() == &dma_direct_ops)
 		archdata->dma_data = (void *)cell_dma_direct_offset;
 	else

-- 
