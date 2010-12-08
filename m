Return-Path: <anton@samba.org>
Date: Wed, 8 Dec 2010 11:36:05 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: iommu: Add device name to iommu error printks
Message-ID: <20101208113605.38ac68a9@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Right now its difficult to see which device is running out of iommu space:

iommu_alloc failed, tbl c00000076e096660 vaddr c000000768806600 npages 1

Use dev_info() so we get the device name and location:

ipr 0000:00:01.0: iommu_alloc failed, tbl c00000076e096660 vaddr c000000768806600 npages 1

Signed-off-by: Anton Blanchard <anton@samba.org> 
---

Index: powerpc.git/arch/powerpc/kernel/iommu.c
===================================================================
--- powerpc.git.orig/arch/powerpc/kernel/iommu.c	2010-12-08 11:28:39.055483332 +1100
+++ powerpc.git/arch/powerpc/kernel/iommu.c	2010-12-08 11:30:54.569176185 +1100
@@ -311,8 +311,9 @@ int iommu_map_sg(struct device *dev, str
 		/* Handle failure */
 		if (unlikely(entry == DMA_ERROR_CODE)) {
 			if (printk_ratelimit())
-				printk(KERN_INFO "iommu_alloc failed, tbl %p vaddr %lx"
-				       " npages %lx\n", tbl, vaddr, npages);
+				dev_info(dev, "iommu_alloc failed, tbl %p "
+					 "vaddr %lx npages %lu\n", tbl, vaddr,
+					 npages);
 			goto failure;
 		}
 
@@ -579,9 +580,9 @@ dma_addr_t iommu_map_page(struct device
 					 attrs);
 		if (dma_handle == DMA_ERROR_CODE) {
 			if (printk_ratelimit())  {
-				printk(KERN_INFO "iommu_alloc failed, "
-						"tbl %p vaddr %p npages %d\n",
-						tbl, vaddr, npages);
+				dev_info(dev, "iommu_alloc failed, tbl %p "
+					 "vaddr %p npages %d\n", tbl, vaddr,
+					 npages);
 			}
 		} else
 			dma_handle |= (uaddr & ~IOMMU_PAGE_MASK);
@@ -627,7 +628,8 @@ void *iommu_alloc_coherent(struct device
 	 * the tce tables.
 	 */
 	if (order >= IOMAP_MAX_ORDER) {
-		printk("iommu_alloc_consistent size too large: 0x%lx\n", size);
+		dev_info(dev, "iommu_alloc_consistent size too large: 0x%lx\n",
+			 size);
 		return NULL;
 	}
 
