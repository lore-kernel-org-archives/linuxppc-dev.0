Return-Path: <fujita.tomonori@lab.ntt.co.jp>
Received: from sh.osrg.net (sh.osrg.net [192.16.179.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CA79FB6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jul 2009 13:27:15 +1000 (EST)
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/5] powerpc: remove swiotlb_pci_dma_ops
Date: Fri, 24 Jul 2009 12:24:12 +0900
Message-Id: <1248405855-15546-3-git-send-email-fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <1248405855-15546-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
References: <1248405855-15546-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now swiotlb_pci_dma_ops is identical to swiotlb_dma_ops; we can use
swiotlb_dma_ops with any devices. This removes swiotlb_pci_dma_ops.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
---
 arch/powerpc/include/asm/swiotlb.h         |    1 -
 arch/powerpc/kernel/dma-swiotlb.c          |   14 --------------
 arch/powerpc/platforms/85xx/mpc8536_ds.c   |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx_ds.c   |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx_mds.c  |    2 +-
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    2 +-
 6 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/include/asm/swiotlb.h b/arch/powerpc/include/asm/swiotlb.h
index 31e0e43..21ce0a3 100644
--- a/arch/powerpc/include/asm/swiotlb.h
+++ b/arch/powerpc/include/asm/swiotlb.h
@@ -14,7 +14,6 @@
 #include <linux/swiotlb.h>
 
 extern struct dma_mapping_ops swiotlb_dma_ops;
-extern struct dma_mapping_ops swiotlb_pci_dma_ops;
 
 static inline void dma_mark_clean(void *addr, size_t size) {}
 
diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
index c9f6a30..ca141e1 100644
--- a/arch/powerpc/kernel/dma-swiotlb.c
+++ b/arch/powerpc/kernel/dma-swiotlb.c
@@ -45,20 +45,6 @@ struct dma_mapping_ops swiotlb_dma_ops = {
 	.sync_sg_for_device = swiotlb_sync_sg_for_device
 };
 
-struct dma_mapping_ops swiotlb_pci_dma_ops = {
-	.alloc_coherent = dma_direct_alloc_coherent,
-	.free_coherent = dma_direct_free_coherent,
-	.map_sg = swiotlb_map_sg_attrs,
-	.unmap_sg = swiotlb_unmap_sg_attrs,
-	.dma_supported = swiotlb_dma_supported,
-	.map_page = swiotlb_map_page,
-	.unmap_page = swiotlb_unmap_page,
-	.sync_single_range_for_cpu = swiotlb_sync_single_range_for_cpu,
-	.sync_single_range_for_device = swiotlb_sync_single_range_for_device,
-	.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
-	.sync_sg_for_device = swiotlb_sync_sg_for_device
-};
-
 void pci_dma_dev_setup_swiotlb(struct pci_dev *pdev)
 {
 	struct pci_controller *hose;
diff --git a/arch/powerpc/platforms/85xx/mpc8536_ds.c b/arch/powerpc/platforms/85xx/mpc8536_ds.c
index bf052c0..004b7d3 100644
--- a/arch/powerpc/platforms/85xx/mpc8536_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc8536_ds.c
@@ -96,7 +96,7 @@ static void __init mpc8536_ds_setup_arch(void)
 #ifdef CONFIG_SWIOTLB
 	if (lmb_end_of_DRAM() > max) {
 		ppc_swiotlb_enable = 1;
-		set_pci_dma_ops(&swiotlb_pci_dma_ops);
+		set_pci_dma_ops(&swiotlb_dma_ops);
 		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
 	}
 #endif
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index c6f92cc..544011a 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -192,7 +192,7 @@ static void __init mpc85xx_ds_setup_arch(void)
 #ifdef CONFIG_SWIOTLB
 	if (lmb_end_of_DRAM() > max) {
 		ppc_swiotlb_enable = 1;
-		set_pci_dma_ops(&swiotlb_pci_dma_ops);
+		set_pci_dma_ops(&swiotlb_dma_ops);
 		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
 	}
 #endif
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 8b8e5f9..c4961ed 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -241,7 +241,7 @@ static void __init mpc85xx_mds_setup_arch(void)
 #ifdef CONFIG_SWIOTLB
 	if (lmb_end_of_DRAM() > max) {
 		ppc_swiotlb_enable = 1;
-		set_pci_dma_ops(&swiotlb_pci_dma_ops);
+		set_pci_dma_ops(&swiotlb_dma_ops);
 		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
 	}
 #endif
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index 8032301..2aa69a6 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -105,7 +105,7 @@ mpc86xx_hpcn_setup_arch(void)
 #ifdef CONFIG_SWIOTLB
 	if (lmb_end_of_DRAM() > max) {
 		ppc_swiotlb_enable = 1;
-		set_pci_dma_ops(&swiotlb_pci_dma_ops);
+		set_pci_dma_ops(&swiotlb_dma_ops);
 		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
 	}
 #endif
-- 
1.6.0.6
