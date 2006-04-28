Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 27D13679EF
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Apr 2006 00:09:13 +1000 (EST)
Date: Fri, 28 Apr 2006 08:57:09 -0500
To: paulus@samba.org
Subject: [PATCH] [2.6.18] powerpc iommu: minor cleanup
Message-ID: <20060428135709.GF5518@pb15.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A couple of minor renames:

* The iommu_table is no longer a part of the device node structure,
  so devnode_table is misleading
* Rename struct device *-variables to hwdev

Signed-off-by: Olof Johansson <olof@lixom.net>


Index: powerpc/arch/powerpc/kernel/pci_iommu.c
===================================================================
--- powerpc.orig/arch/powerpc/kernel/pci_iommu.c
+++ powerpc/arch/powerpc/kernel/pci_iommu.c
@@ -44,16 +44,16 @@
  */
 #define PCI_GET_DN(dev) ((struct device_node *)((dev)->sysdata))
 
-static inline struct iommu_table *devnode_table(struct device *dev)
+static inline struct iommu_table *device_to_table(struct device *hwdev)
 {
 	struct pci_dev *pdev;
 
-	if (!dev) {
+	if (!hwdev) {
 		pdev = ppc64_isabridge_dev;
 		if (!pdev)
 			return NULL;
 	} else
-		pdev = to_pci_dev(dev);
+		pdev = to_pci_dev(hwdev);
 
 	return PCI_DN(PCI_GET_DN(pdev))->iommu_table;
 }
@@ -85,14 +85,14 @@ static inline unsigned long device_to_ma
 static void *pci_iommu_alloc_coherent(struct device *hwdev, size_t size,
 			   dma_addr_t *dma_handle, gfp_t flag)
 {
-	return iommu_alloc_coherent(devnode_table(hwdev), size, dma_handle,
+	return iommu_alloc_coherent(device_to_table(hwdev), size, dma_handle,
 			device_to_mask(hwdev), flag);
 }
 
 static void pci_iommu_free_coherent(struct device *hwdev, size_t size,
 			 void *vaddr, dma_addr_t dma_handle)
 {
-	iommu_free_coherent(devnode_table(hwdev), size, vaddr, dma_handle);
+	iommu_free_coherent(device_to_table(hwdev), size, vaddr, dma_handle);
 }
 
 /* Creates TCEs for a user provided buffer.  The user buffer must be 
@@ -104,7 +104,7 @@ static void pci_iommu_free_coherent(stru
 static dma_addr_t pci_iommu_map_single(struct device *hwdev, void *vaddr,
 		size_t size, enum dma_data_direction direction)
 {
-	return iommu_map_single(devnode_table(hwdev), vaddr, size,
+	return iommu_map_single(device_to_table(hwdev), vaddr, size,
 			        device_to_mask(hwdev), direction);
 }
 
@@ -112,27 +112,27 @@ static dma_addr_t pci_iommu_map_single(s
 static void pci_iommu_unmap_single(struct device *hwdev, dma_addr_t dma_handle,
 		size_t size, enum dma_data_direction direction)
 {
-	iommu_unmap_single(devnode_table(hwdev), dma_handle, size, direction);
+	iommu_unmap_single(device_to_table(hwdev), dma_handle, size, direction);
 }
 
 
 static int pci_iommu_map_sg(struct device *pdev, struct scatterlist *sglist,
 		int nelems, enum dma_data_direction direction)
 {
-	return iommu_map_sg(pdev, devnode_table(pdev), sglist,
+	return iommu_map_sg(pdev, device_to_table(pdev), sglist,
 			nelems, device_to_mask(pdev), direction);
 }
 
 static void pci_iommu_unmap_sg(struct device *pdev, struct scatterlist *sglist,
 		int nelems, enum dma_data_direction direction)
 {
-	iommu_unmap_sg(devnode_table(pdev), sglist, nelems, direction);
+	iommu_unmap_sg(device_to_table(pdev), sglist, nelems, direction);
 }
 
 /* We support DMA to/from any memory page via the iommu */
 static int pci_iommu_dma_supported(struct device *dev, u64 mask)
 {
-	struct iommu_table *tbl = devnode_table(dev);
+	struct iommu_table *tbl = device_to_table(dev);
 
 	if (!tbl || tbl->it_offset > mask) {
 		printk(KERN_INFO "Warning: IOMMU table offset too big for device mask\n");
