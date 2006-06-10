Return-Path: <anton@ozlabs.org>
Date: Sat, 10 Jun 2006 23:04:39 +1000
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: cleanup dma_mapping_ops
Message-ID: <20060610130438.GR23891@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


For pseries IOMMU bypass I want to be able to fall back to the regular
IOMMU ops. Do this by creating a dma_mapping_ops struct, and convert
the others while at it.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: build/arch/powerpc/kernel/pci_iommu.c
===================================================================
--- build.orig/arch/powerpc/kernel/pci_iommu.c	2006-06-10 11:37:31.000000000 +1000
+++ build/arch/powerpc/kernel/pci_iommu.c	2006-06-10 22:35:25.000000000 +1000
@@ -148,13 +148,17 @@ static int pci_iommu_dma_supported(struc
 		return 1;
 }
 
+struct dma_mapping_ops pci_iommu_ops = {
+	.alloc_coherent = pci_iommu_alloc_coherent,
+	.free_coherent = pci_iommu_free_coherent,
+	.map_single = pci_iommu_map_single,
+	.unmap_single = pci_iommu_unmap_single,
+	.map_sg = pci_iommu_map_sg,
+	.unmap_sg = pci_iommu_unmap_sg,
+	.dma_supported = pci_iommu_dma_supported,
+};
+
 void pci_iommu_init(void)
 {
-	pci_dma_ops.alloc_coherent = pci_iommu_alloc_coherent;
-	pci_dma_ops.free_coherent = pci_iommu_free_coherent;
-	pci_dma_ops.map_single = pci_iommu_map_single;
-	pci_dma_ops.unmap_single = pci_iommu_unmap_single;
-	pci_dma_ops.map_sg = pci_iommu_map_sg;
-	pci_dma_ops.unmap_sg = pci_iommu_unmap_sg;
-	pci_dma_ops.dma_supported = pci_iommu_dma_supported;
+	pci_dma_ops = pci_iommu_ops;
 }
Index: build/arch/powerpc/kernel/pci_direct_iommu.c
===================================================================
--- build.orig/arch/powerpc/kernel/pci_direct_iommu.c	2006-06-08 10:57:36.000000000 +1000
+++ build/arch/powerpc/kernel/pci_direct_iommu.c	2006-06-10 22:35:25.000000000 +1000
@@ -82,13 +82,17 @@ static int pci_direct_dma_supported(stru
 	return mask < 0x100000000ull;
 }
 
+static struct dma_mapping_ops pci_direct_ops = {
+	.alloc_coherent = pci_direct_alloc_coherent,
+	.free_coherent = pci_direct_free_coherent,
+	.map_single = pci_direct_map_single,
+	.unmap_single = pci_direct_unmap_single,
+	.map_sg = pci_direct_map_sg,
+	.unmap_sg = pci_direct_unmap_sg,
+	.dma_supported = pci_direct_dma_supported,
+};
+
 void __init pci_direct_iommu_init(void)
 {
-	pci_dma_ops.alloc_coherent = pci_direct_alloc_coherent;
-	pci_dma_ops.free_coherent = pci_direct_free_coherent;
-	pci_dma_ops.map_single = pci_direct_map_single;
-	pci_dma_ops.unmap_single = pci_direct_unmap_single;
-	pci_dma_ops.map_sg = pci_direct_map_sg;
-	pci_dma_ops.unmap_sg = pci_direct_unmap_sg;
-	pci_dma_ops.dma_supported = pci_direct_dma_supported;
+	pci_dma_ops = pci_direct_ops;
 }
Index: build/arch/powerpc/platforms/cell/iommu.c
===================================================================
--- build.orig/arch/powerpc/platforms/cell/iommu.c	2006-06-08 10:57:36.000000000 +1000
+++ build/arch/powerpc/platforms/cell/iommu.c	2006-06-10 22:35:25.000000000 +1000
@@ -473,6 +473,16 @@ static int cell_dma_supported(struct dev
 	return mask < 0x100000000ull;
 }
 
+static struct dma_mapping_ops cell_iommu_ops = {
+	.alloc_coherent = cell_alloc_coherent,
+	.free_coherent = cell_free_coherent,
+	.map_single = cell_map_single,
+	.unmap_single = cell_unmap_single,
+	.map_sg = cell_map_sg,
+	.unmap_sg = cell_unmap_sg,
+	.dma_supported = cell_dma_supported,
+};
+
 void cell_init_iommu(void)
 {
 	int setup_bus = 0;
@@ -498,11 +508,5 @@ void cell_init_iommu(void)
 		}
 	}
 
-	pci_dma_ops.alloc_coherent = cell_alloc_coherent;
-	pci_dma_ops.free_coherent = cell_free_coherent;
-	pci_dma_ops.map_single = cell_map_single;
-	pci_dma_ops.unmap_single = cell_unmap_single;
-	pci_dma_ops.map_sg = cell_map_sg;
-	pci_dma_ops.unmap_sg = cell_unmap_sg;
-	pci_dma_ops.dma_supported = cell_dma_supported;
+	pci_dma_ops = cell_iommu_ops;
 }
