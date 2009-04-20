Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0E526DE15D
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 02:27:08 +1000 (EST)
From: Becky Bruce <beckyb@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org, fujita.tomonori@lab.ntt.co.jp
Subject: [PATCH 5/5] powerpc: Add 86xx support for SWIOTLB
Date: Mon, 20 Apr 2009 11:26:50 -0500
Message-Id: <1240244810-32193-8-git-send-email-beckyb@kernel.crashing.org>
In-Reply-To: <1240244810-32193-7-git-send-email-beckyb@kernel.crashing.org>
References: <1240244810-32193-1-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-2-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-3-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-4-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-5-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-6-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-7-git-send-email-beckyb@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Minor code to allow enabling swiotlb on mpc86xx, including
Kconfig addition for SWIOTLB.

Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
---
 arch/powerpc/Kconfig                       |   10 ++++++++++
 arch/powerpc/kernel/dma-swiotlb.c          |    2 ++
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    3 +++
 3 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 197f6a3..e47c81d 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -292,6 +292,16 @@ config IOMMU_VMERGE
 config IOMMU_HELPER
 	def_bool PPC64
 
+config SWIOTLB
+	bool "SWIOTLB support"
+	depends on PPC_86xx
+	select IOMMU_HELPER
+	---help---
+	  Support for IO bounce buffering for systems without an IOMMU.
+	  This allows us to DMA to the full physical address space on
+	  platforms where the size of a physical address is larger
+	  than the bus address.
+
 config PPC_NEED_DMA_SYNC_OPS
 	def_bool y
 	depends on (NOT_COHERENT_CACHE || SWIOTLB)
diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
index 29a68e6..3065d03 100644
--- a/arch/powerpc/kernel/dma-swiotlb.c
+++ b/arch/powerpc/kernel/dma-swiotlb.c
@@ -159,3 +159,5 @@ static int __init setup_bus_notifier(void)
 
 	return 0;
 }
+
+machine_arch_initcall(mpc86xx_hpcn, setup_bus_notifier);
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index c4ec49b..f7b88b9 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -88,6 +88,9 @@ mpc86xx_hpcn_setup_arch(void)
 
 	ppc_md.pci_exclude_device = mpc86xx_exclude_device;
 
+#ifdef CONFIG_SWIOTLB
+	set_pci_dma_ops(&swiotlb_pci_dma_ops);
+#endif
 #endif
 
 	printk("MPC86xx HPCN board from Freescale Semiconductor\n");
-- 
1.6.0.6
