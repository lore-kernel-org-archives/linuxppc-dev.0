Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AF71EDE00A
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 08:42:37 +1000 (EST)
From: Becky Bruce <beckyb@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH V2 3/3] powerpc: Add 86xx support for SWIOTLB
Date: Thu, 14 May 2009 17:42:29 -0500
Message-Id: <1242340949-16369-3-git-send-email-beckyb@kernel.crashing.org>
In-Reply-To: <1242340949-16369-2-git-send-email-beckyb@kernel.crashing.org>
References: <1242340949-16369-1-git-send-email-beckyb@kernel.crashing.org>
	<1242340949-16369-2-git-send-email-beckyb@kernel.crashing.org>
Cc: fujita.tomonori@lab.ntt.co.jp
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is the final bit of code to allow enabling swiotlb on
mpc86xx.  The platform-specific code is very small and consists
of enabling SWIOTLB in the config file, registering the
swiotlb_setup_bus_notifier initcall, and setting pci_dma_ops
to point to swiotlb_pci_dma_ops if we have more memory than
can be mapped by the inbound PCI windows.

Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
---
 arch/powerpc/platforms/86xx/Kconfig        |    1 +
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |   15 +++++++++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/platforms/86xx/Kconfig
index fdaf4dd..9c7b64a 100644
--- a/arch/powerpc/platforms/86xx/Kconfig
+++ b/arch/powerpc/platforms/86xx/Kconfig
@@ -15,6 +15,7 @@ config MPC8641_HPCN
 	select DEFAULT_UIMAGE
 	select FSL_ULI1575
 	select HAS_RAPIDIO
+	select SWIOTLB
 	help
 	  This option enables support for the MPC8641 HPCN board.
 
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index 7e9e83c..6632702 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <linux/seq_file.h>
 #include <linux/of_platform.h>
+#include <linux/lmb.h>
 
 #include <asm/system.h>
 #include <asm/time.h>
@@ -27,6 +28,7 @@
 #include <asm/prom.h>
 #include <mm/mmu_decl.h>
 #include <asm/udbg.h>
+#include <asm/swiotlb.h>
 
 #include <asm/mpic.h>
 
@@ -70,7 +72,9 @@ mpc86xx_hpcn_setup_arch(void)
 {
 #ifdef CONFIG_PCI
 	struct device_node *np;
+	struct pci_controller *hose;
 #endif
+	dma_addr_t max = 0xffffffff;
 
 	if (ppc_md.progress)
 		ppc_md.progress("mpc86xx_hpcn_setup_arch()", 0);
@@ -83,6 +87,9 @@ mpc86xx_hpcn_setup_arch(void)
 			fsl_add_bridge(np, 1);
 		else
 			fsl_add_bridge(np, 0);
+		hose = pci_find_hose_for_OF_device(np);
+		max = min(max, hose->dma_window_base_cur +
+			  hose->dma_window_size);
 	}
 
 	ppc_md.pci_exclude_device = mpc86xx_exclude_device;
@@ -94,6 +101,13 @@ mpc86xx_hpcn_setup_arch(void)
 #ifdef CONFIG_SMP
 	mpc86xx_smp_init();
 #endif
+
+#ifdef CONFIG_SWIOTLB
+	if (lmb_end_of_DRAM() > max) {
+		ppc_swiotlb_enable = 1;
+		set_pci_dma_ops(&swiotlb_pci_dma_ops);
+	}
+#endif
 }
 
 
@@ -158,6 +172,7 @@ static int __init declare_of_platform_devices(void)
 	return 0;
 }
 machine_device_initcall(mpc86xx_hpcn, declare_of_platform_devices);
+machine_arch_initcall(mpc86xx_hpcn, swiotlb_setup_bus_notifier);
 
 define_machine(mpc86xx_hpcn) {
 	.name			= "MPC86xx HPCN",
-- 
1.6.0.6
