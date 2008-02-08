Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <afb8c03a6459479bf878611cb16181417f0a27bf.1202449018.git.michael@ellerman.id.au>
In-Reply-To: <3aa63ba024ba35ff3bf5b5f1d6aec2efa9782ba5.1202449018.git.michael@ellerman.id.au>
References: <3aa63ba024ba35ff3bf5b5f1d6aec2efa9782ba5.1202449018.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 4/4] Make cell IOMMU fixed mapping printk more useful
Date: Fri,  8 Feb 2008 16:37:04 +1100 (EST)
Cc: cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently the cell IOMMU fixed mapping just printks that it's been setup,
which is not particularly useful. Much more interesting is the address
ranges for the different windows. This adds one line to dmesg on a blade.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/iommu.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 5cdcd36..edab631 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -991,8 +991,8 @@ static int __init cell_iommu_fixed_mapping_init(void)
 			dsize = htab_size_bytes;
 		}
 
-		pr_debug("iommu: setting up %d, dynamic window %lx-%lx " \
-			 "fixed window %lx-%lx\n", iommu->nid, dbase,
+		printk(KERN_DEBUG "iommu: node %d, dynamic window 0x%lx-0x%lx "
+			"fixed window 0x%lx-0x%lx\n", iommu->nid, dbase,
 			 dbase + dsize, fbase, fbase + fsize);
 
 		cell_iommu_setup_page_tables(iommu, dbase, dsize, fbase, fsize);
@@ -1008,8 +1008,6 @@ static int __init cell_iommu_fixed_mapping_init(void)
 	dma_iommu_ops.set_dma_mask = dma_set_mask_and_switch;
 	set_pci_dma_ops(&dma_iommu_ops);
 
-	printk(KERN_DEBUG "IOMMU fixed mapping established.\n");
-
 	return 0;
 }
 
-- 
1.5.2.rc1.1884.g59b20
