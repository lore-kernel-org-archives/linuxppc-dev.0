Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C0015DE065
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 15:45:32 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n4F5jLXu031056
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 00:45:26 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/85xx: Add SWIOTLB support to FSL boards
Date: Fri, 15 May 2009 00:45:21 -0500
Message-Id: <1242366321-29112-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add the platform-specific code for enabling SWIOTLB if needed on P2020DS,
MPC85xx DS, and MPC85xx MDS boards as they are capable of having >4G of
memory.

We determine if we need to enable swiotlb based on how much memory is in
the board and if it exceeds 4G or what we can map via PCI inbound
windows.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/85xx/Kconfig       |    3 +++
 arch/powerpc/platforms/85xx/mpc8536_ds.c  |   17 +++++++++++++++++
 arch/powerpc/platforms/85xx/mpc85xx_ds.c  |   19 +++++++++++++++++++
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |   20 ++++++++++++++++++++
 4 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 43d385c..0ee5b12 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -35,12 +35,14 @@ config MPC85xx_MDS
 	select DEFAULT_UIMAGE
 	select PHYLIB
 	select HAS_RAPIDIO
+	select SWIOTLB
 	help
 	  This option enables support for the MPC85xx MDS board
 
 config MPC8536_DS
 	bool "Freescale MPC8536 DS"
 	select DEFAULT_UIMAGE
+	select SWIOTLB
 	help
 	  This option enables support for the MPC8536 DS board
 
@@ -49,6 +51,7 @@ config MPC85xx_DS
 	select PPC_I8259
 	select DEFAULT_UIMAGE
 	select FSL_ULI1575
+	select SWIOTLB
 	help
 	  This option enables support for the MPC85xx DS (MPC8544 DS) board
 
diff --git a/arch/powerpc/platforms/85xx/mpc8536_ds.c b/arch/powerpc/platforms/85xx/mpc8536_ds.c
index 63efca2..055ff41 100644
--- a/arch/powerpc/platforms/85xx/mpc8536_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc8536_ds.c
@@ -17,6 +17,7 @@
 #include <linux/seq_file.h>
 #include <linux/interrupt.h>
 #include <linux/of_platform.h>
+#include <linux/lmb.h>
 
 #include <asm/system.h>
 #include <asm/time.h>
@@ -26,6 +27,7 @@
 #include <asm/prom.h>
 #include <asm/udbg.h>
 #include <asm/mpic.h>
+#include <asm/swiotlb.h>
 
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
@@ -65,7 +67,9 @@ static void __init mpc8536_ds_setup_arch(void)
 {
 #ifdef CONFIG_PCI
 	struct device_node *np;
+	struct pci_controller *hose;
 #endif
+	dma_addr_t max = 0xffffffff;
 
 	if (ppc_md.progress)
 		ppc_md.progress("mpc8536_ds_setup_arch()", 0);
@@ -80,11 +84,22 @@ static void __init mpc8536_ds_setup_arch(void)
 				fsl_add_bridge(np, 1);
 			else
 				fsl_add_bridge(np, 0);
+
+			hose = pci_find_hose_for_OF_device(np);
+			max = min(max, hose->dma_window_base_cur +
+					hose->dma_window_size);
 		}
 	}
 
 #endif
 
+#ifdef CONFIG_SWIOTLB
+	if (lmb_end_of_DRAM() > max) {
+		ppc_swiotlb_enable = 1;
+		set_pci_dma_ops(&swiotlb_pci_dma_ops);
+	}
+#endif
+
 	printk("MPC8536 DS board from Freescale Semiconductor\n");
 }
 
@@ -102,6 +117,8 @@ static int __init mpc8536_ds_publish_devices(void)
 }
 machine_device_initcall(mpc8536_ds, mpc8536_ds_publish_devices);
 
+machine_arch_initcall(mpc8536_ds, swiotlb_setup_bus_notifier);
+
 /*
  * Called very early, device-tree isn't unflattened
  */
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 53d5851..849c0ac 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -20,6 +20,7 @@
 #include <linux/seq_file.h>
 #include <linux/interrupt.h>
 #include <linux/of_platform.h>
+#include <linux/lmb.h>
 
 #include <asm/system.h>
 #include <asm/time.h>
@@ -30,6 +31,7 @@
 #include <asm/udbg.h>
 #include <asm/mpic.h>
 #include <asm/i8259.h>
+#include <asm/swiotlb.h>
 
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
@@ -155,7 +157,9 @@ static void __init mpc85xx_ds_setup_arch(void)
 {
 #ifdef CONFIG_PCI
 	struct device_node *np;
+	struct pci_controller *hose;
 #endif
+	dma_addr_t max = 0xffffffff;
 
 	if (ppc_md.progress)
 		ppc_md.progress("mpc85xx_ds_setup_arch()", 0);
@@ -171,6 +175,10 @@ static void __init mpc85xx_ds_setup_arch(void)
 				fsl_add_bridge(np, 1);
 			else
 				fsl_add_bridge(np, 0);
+
+			hose = pci_find_hose_for_OF_device(np);
+			max = min(max, hose->dma_window_base_cur +
+					hose->dma_window_size);
 		}
 	}
 
@@ -181,6 +189,13 @@ static void __init mpc85xx_ds_setup_arch(void)
 	mpc85xx_smp_init();
 #endif
 
+#ifdef CONFIG_SWIOTLB
+	if (lmb_end_of_DRAM() > max) {
+		ppc_swiotlb_enable = 1;
+		set_pci_dma_ops(&swiotlb_pci_dma_ops);
+	}
+#endif
+
 	printk("MPC85xx DS board from Freescale Semiconductor\n");
 }
 
@@ -217,6 +232,10 @@ machine_device_initcall(mpc8544_ds, mpc85xxds_publish_devices);
 machine_device_initcall(mpc8572_ds, mpc85xxds_publish_devices);
 machine_device_initcall(p2020_ds, mpc85xxds_publish_devices);
 
+machine_arch_initcall(mpc8544_ds, swiotlb_setup_bus_notifier);
+machine_arch_initcall(mpc8572_ds, swiotlb_setup_bus_notifier);
+machine_arch_initcall(p2020_ds, swiotlb_setup_bus_notifier);
+
 /*
  * Called very early, device-tree isn't unflattened
  */
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index b2c0a43..77f90b3 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -33,6 +33,7 @@
 #include <linux/of_platform.h>
 #include <linux/of_device.h>
 #include <linux/phy.h>
+#include <linux/lmb.h>
 
 #include <asm/system.h>
 #include <asm/atomic.h>
@@ -49,6 +50,7 @@
 #include <asm/qe.h>
 #include <asm/qe_ic.h>
 #include <asm/mpic.h>
+#include <asm/swiotlb.h>
 
 #undef DEBUG
 #ifdef DEBUG
@@ -155,6 +157,10 @@ static void __init mpc85xx_mds_setup_arch(void)
 {
 	struct device_node *np;
 	static u8 __iomem *bcsr_regs = NULL;
+#ifdef CONFIG_PCI
+	struct pci_controller *hose;
+#endif
+	dma_addr_t max = 0xffffffff;
 
 	if (ppc_md.progress)
 		ppc_md.progress("mpc85xx_mds_setup_arch()", 0);
@@ -179,6 +185,10 @@ static void __init mpc85xx_mds_setup_arch(void)
 				fsl_add_bridge(np, 1);
 			else
 				fsl_add_bridge(np, 0);
+
+			hose = pci_find_hose_for_OF_device(np);
+			max = min(max, hose->dma_window_base_cur +
+					hose->dma_window_size);
 		}
 	}
 #endif
@@ -227,6 +237,13 @@ static void __init mpc85xx_mds_setup_arch(void)
 		iounmap(bcsr_regs);
 	}
 #endif	/* CONFIG_QUICC_ENGINE */
+
+#ifdef CONFIG_SWIOTLB
+	if (lmb_end_of_DRAM() > max) {
+		ppc_swiotlb_enable = 1;
+		set_pci_dma_ops(&swiotlb_pci_dma_ops);
+	}
+#endif
 }
 
 
@@ -281,6 +298,9 @@ static int __init mpc85xx_publish_devices(void)
 machine_device_initcall(mpc8568_mds, mpc85xx_publish_devices);
 machine_device_initcall(mpc8569_mds, mpc85xx_publish_devices);
 
+machine_arch_initcall(mpc8568_mds, swiotlb_setup_bus_notifier);
+machine_arch_initcall(mpc8569_mds, swiotlb_setup_bus_notifier);
+
 static void __init mpc85xx_mds_pic_init(void)
 {
 	struct mpic *mpic;
-- 
1.6.0.6
