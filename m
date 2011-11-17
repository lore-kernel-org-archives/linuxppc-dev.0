Return-Path: <dbaryshkov@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 8F6DCB72CE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2011 04:56:53 +1100 (EST)
Received: by mail-ww0-f45.google.com with SMTP id 10so2764655wwf.14
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2011 09:56:53 -0800 (PST)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/6] powerpc/85xx: unify common parts of *_setup_arch
Date: Thu, 17 Nov 2011 21:56:19 +0400
Message-Id: <1321552581-29773-4-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1321552581-29773-1-git-send-email-dbaryshkov@gmail.com>
References: <1321552581-29773-1-git-send-email-dbaryshkov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Refactor PCI, SWIOTLB and SMP handling out of board-specific setup_arch
functions. These tasks are more or less common to all boards and thus
can be moved to common place.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/powerpc/platforms/85xx/corenet_ds.c     |   37 +------------------
 arch/powerpc/platforms/85xx/mpc8536_ds.c     |   33 +----------------
 arch/powerpc/platforms/85xx/mpc85xx.h        |    3 +
 arch/powerpc/platforms/85xx/mpc85xx_ads.c    |    9 +---
 arch/powerpc/platforms/85xx/mpc85xx_cds.c    |   18 +--------
 arch/powerpc/platforms/85xx/mpc85xx_common.c |   52 ++++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/mpc85xx_ds.c     |   40 +-------------------
 arch/powerpc/platforms/85xx/mpc85xx_mds.c    |   40 +-------------------
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c    |   19 +---------
 arch/powerpc/platforms/85xx/p1010rdb.c       |   12 +-----
 arch/powerpc/platforms/85xx/p1022_ds.c       |   39 +-------------------
 arch/powerpc/platforms/85xx/p1023_rds.c      |   13 +------
 arch/powerpc/platforms/85xx/sbc8548.c        |   18 +--------
 arch/powerpc/platforms/85xx/sbc8560.c        |    9 +----
 arch/powerpc/platforms/85xx/socrates.c       |    9 +----
 arch/powerpc/platforms/85xx/stx_gp3.c        |    9 +----
 arch/powerpc/platforms/85xx/tqm85xx.c        |   19 +---------
 arch/powerpc/platforms/85xx/xes_mpc85xx.c    |   32 +---------------
 18 files changed, 74 insertions(+), 337 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/corenet_ds.c b/arch/powerpc/platforms/85xx/corenet_ds.c
index b4abc01..d782d55 100644
--- a/arch/powerpc/platforms/85xx/corenet_ds.c
+++ b/arch/powerpc/platforms/85xx/corenet_ds.c
@@ -42,45 +42,10 @@ void __init corenet_ds_pic_init(void)
 /*
  * Setup the architecture
  */
-#ifdef CONFIG_SMP
-void __init mpc85xx_smp_init(void);
-#endif
-
 void __init corenet_ds_setup_arch(void)
 {
-#ifdef CONFIG_PCI
-	struct device_node *np;
-	struct pci_controller *hose;
-#endif
-	dma_addr_t max = 0xffffffff;
-
-#ifdef CONFIG_SMP
-	mpc85xx_smp_init();
-#endif
-
-#ifdef CONFIG_PCI
-	for_each_node_by_type(np, "pci") {
-		if (of_device_is_compatible(np, "fsl,p4080-pcie") ||
-		    of_device_is_compatible(np, "fsl,qoriq-pcie-v2.2")) {
-			fsl_add_bridge(np, 0);
-			hose = pci_find_hose_for_OF_device(np);
-			max = min(max, hose->dma_window_base_cur +
-					hose->dma_window_size);
-		}
-	}
-
-#ifdef CONFIG_PPC64
-	pci_devs_phb_init();
-#endif
-#endif
+	mpc85xx_setup_arch(MPC85xx_NO_PRIMARY_PHB);
 
-#ifdef CONFIG_SWIOTLB
-	if (memblock_end_of_DRAM() > max) {
-		ppc_swiotlb_enable = 1;
-		set_pci_dma_ops(&swiotlb_dma_ops);
-		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
-	}
-#endif
 	pr_info("%s board from Freescale Semiconductor\n", ppc_md.name);
 }
 
diff --git a/arch/powerpc/platforms/85xx/mpc8536_ds.c b/arch/powerpc/platforms/85xx/mpc8536_ds.c
index 223bb7a..8a7fc81 100644
--- a/arch/powerpc/platforms/85xx/mpc8536_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc8536_ds.c
@@ -44,41 +44,10 @@ void __init mpc8536_ds_pic_init(void)
  */
 static void __init mpc8536_ds_setup_arch(void)
 {
-#ifdef CONFIG_PCI
-	struct device_node *np;
-	struct pci_controller *hose;
-#endif
-	dma_addr_t max = 0xffffffff;
-
 	if (ppc_md.progress)
 		ppc_md.progress("mpc8536_ds_setup_arch()", 0);
 
-#ifdef CONFIG_PCI
-	for_each_node_by_type(np, "pci") {
-		if (of_device_is_compatible(np, "fsl,mpc8540-pci") ||
-		    of_device_is_compatible(np, "fsl,mpc8548-pcie")) {
-			struct resource rsrc;
-			of_address_to_resource(np, 0, &rsrc);
-			if ((rsrc.start & 0xfffff) == 0x8000)
-				fsl_add_bridge(np, 1);
-			else
-				fsl_add_bridge(np, 0);
-
-			hose = pci_find_hose_for_OF_device(np);
-			max = min(max, hose->dma_window_base_cur +
-					hose->dma_window_size);
-		}
-	}
-
-#endif
-
-#ifdef CONFIG_SWIOTLB
-	if (memblock_end_of_DRAM() > max) {
-		ppc_swiotlb_enable = 1;
-		set_pci_dma_ops(&swiotlb_dma_ops);
-		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
-	}
-#endif
+	mpc85xx_setup_arch(0x8000);
 
 	printk("MPC8536 DS board from Freescale Semiconductor\n");
 }
diff --git a/arch/powerpc/platforms/85xx/mpc85xx.h b/arch/powerpc/platforms/85xx/mpc85xx.h
index 466923b..e2a6631 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx.h
+++ b/arch/powerpc/platforms/85xx/mpc85xx.h
@@ -9,4 +9,7 @@ extern void mpc85xx_cpm2_pic_init(void);
 static inline void __init mpc85xx_cpm2_pic_init(void) {}
 #endif /* CONFIG_CPM2 */
 
+#define MPC85xx_NO_PRIMARY_PHB 0xffff
+extern void mpc85xx_setup_arch(unsigned primary_phb_addr);
+
 #endif
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index 37edba4..384b4cc 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -135,10 +135,6 @@ static void __init init_ioports(void)
 
 static void __init mpc85xx_ads_setup_arch(void)
 {
-#ifdef CONFIG_PCI
-	struct device_node *np;
-#endif
-
 	if (ppc_md.progress)
 		ppc_md.progress("mpc85xx_ads_setup_arch()", 0);
 
@@ -147,10 +143,9 @@ static void __init mpc85xx_ads_setup_arch(void)
 	init_ioports();
 #endif
 
-#ifdef CONFIG_PCI
-	for_each_compatible_node(np, "pci", "fsl,mpc8540-pci")
-		fsl_add_bridge(np, 1);
+	mpc85xx_setup_arch(0x8000);
 
+#ifdef CONFIG_PCI
 	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
 #endif
 }
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index aa42202..49366e7 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -245,10 +245,6 @@ machine_device_initcall(mpc85xx_cds, mpc85xx_cds_8259_attach);
  */
 static void __init mpc85xx_cds_setup_arch(void)
 {
-#ifdef CONFIG_PCI
-	struct device_node *np;
-#endif
-
 	if (ppc_md.progress)
 		ppc_md.progress("mpc85xx_cds_setup_arch()", 0);
 
@@ -262,19 +258,9 @@ static void __init mpc85xx_cds_setup_arch(void)
 		ppc_md.progress(buf, 0);
 	}
 
-#ifdef CONFIG_PCI
-	for_each_node_by_type(np, "pci") {
-		if (of_device_is_compatible(np, "fsl,mpc8540-pci") ||
-		    of_device_is_compatible(np, "fsl,mpc8548-pcie")) {
-			struct resource rsrc;
-			of_address_to_resource(np, 0, &rsrc);
-			if ((rsrc.start & 0xfffff) == 0x8000)
-				fsl_add_bridge(np, 1);
-			else
-				fsl_add_bridge(np, 0);
-		}
-	}
+	mpc85xx_setup_arch(0x8000);
 
+#ifdef CONFIG_PCI
 	ppc_md.pci_irq_fixup = mpc85xx_cds_pci_irq_fixup;
 	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
 #endif
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_common.c b/arch/powerpc/platforms/85xx/mpc85xx_common.c
index 7579e24..87e61a3 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_common.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_common.c
@@ -5,12 +5,15 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include <linux/memblock.h>
 #include <linux/of_platform.h>
+#include <linux/pci.h>
 
 #include <asm/machdep.h>
 #include <asm/mpic.h>
 
 #include <sysdev/cpm2_pic.h>
+#include <sysdev/fsl_pci.h>
 
 #include "mpc85xx.h"
 
@@ -106,3 +109,52 @@ void __init mpc85xx_init_mpic(bool reset, bool broken_frr, bool singledest)
 
 	mpic_init(mpic);
 }
+
+#ifdef CONFIG_SMP
+extern void __init mpc85xx_smp_init(void);
+#endif
+
+void __init mpc85xx_setup_arch(unsigned primary_phb_addr)
+{
+	dma_addr_t max = 0xffffffff;
+
+#ifdef CONFIG_PCI
+	struct device_node *np;
+	struct pci_controller *hose;
+
+	for_each_node_by_type(np, "pci") {
+		if (of_device_is_compatible(np, "fsl,mpc8540-pci") ||
+		    of_device_is_compatible(np, "fsl,mpc8548-pcie") ||
+		    of_device_is_compatible(np, "fsl,p2020-pcie") ||
+		    of_device_is_compatible(np, "fsl,p4080-pcie") ||
+		    of_device_is_compatible(np, "fsl,qoriq-pcie-v2.2")) {
+			struct resource rsrc;
+			of_address_to_resource(np, 0, &rsrc);
+			if ((rsrc.start & 0xfffff) == primary_phb_addr)
+				fsl_add_bridge(np, 1);
+			else
+				fsl_add_bridge(np, 0);
+
+			hose = pci_find_hose_for_OF_device(np);
+			max = min(max, hose->dma_window_base_cur +
+					hose->dma_window_size);
+		}
+	}
+
+#ifdef CONFIG_PPC64
+	pci_devs_phb_init();
+#endif
+#endif
+
+#ifdef CONFIG_SMP
+	mpc85xx_smp_init();
+#endif
+
+#ifdef CONFIG_SWIOTLB
+	if (memblock_end_of_DRAM() > max) {
+		ppc_swiotlb_enable = 1;
+		set_pci_dma_ops(&swiotlb_dma_ops);
+		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
+	}
+#endif
+}
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 7e535da..bd9931a 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -129,53 +129,17 @@ static int mpc85xx_exclude_device(struct pci_controller *hose,
 /*
  * Setup the architecture
  */
-#ifdef CONFIG_SMP
-extern void __init mpc85xx_smp_init(void);
-#endif
 static void __init mpc85xx_ds_setup_arch(void)
 {
-#ifdef CONFIG_PCI
-	struct device_node *np;
-	struct pci_controller *hose;
-#endif
-	dma_addr_t max = 0xffffffff;
-
 	if (ppc_md.progress)
 		ppc_md.progress("mpc85xx_ds_setup_arch()", 0);
 
-#ifdef CONFIG_PCI
-	for_each_node_by_type(np, "pci") {
-		if (of_device_is_compatible(np, "fsl,mpc8540-pci") ||
-		    of_device_is_compatible(np, "fsl,mpc8548-pcie") ||
-		    of_device_is_compatible(np, "fsl,p2020-pcie")) {
-			struct resource rsrc;
-			of_address_to_resource(np, 0, &rsrc);
-			if ((rsrc.start & 0xfffff) == primary_phb_addr)
-				fsl_add_bridge(np, 1);
-			else
-				fsl_add_bridge(np, 0);
-
-			hose = pci_find_hose_for_OF_device(np);
-			max = min(max, hose->dma_window_base_cur +
-					hose->dma_window_size);
-		}
-	}
+	mpc85xx_setup_arch(primary_phb_addr);
 
+#ifdef CONFIG_PCI
 	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
 #endif
 
-#ifdef CONFIG_SMP
-	mpc85xx_smp_init();
-#endif
-
-#ifdef CONFIG_SWIOTLB
-	if (memblock_end_of_DRAM() > max) {
-		ppc_swiotlb_enable = 1;
-		set_pci_dma_ops(&swiotlb_dma_ops);
-		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
-	}
-#endif
-
 	printk("MPC85xx DS board from Freescale Semiconductor\n");
 }
 
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index c49d31f..1f5f1af 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -156,10 +156,6 @@ static int mpc8568_mds_phy_fixups(struct phy_device *phydev)
  * Setup the architecture
  *
  */
-#ifdef CONFIG_SMP
-extern void __init mpc85xx_smp_init(void);
-#endif
-
 #ifdef CONFIG_QUICC_ENGINE
 static void __init mpc85xx_mds_reset_ucc_phys(void)
 {
@@ -337,46 +333,12 @@ static void __init mpc85xx_mds_qeic_init(void) { }
 
 static void __init mpc85xx_mds_setup_arch(void)
 {
-#ifdef CONFIG_PCI
-	struct pci_controller *hose;
-	struct device_node *np;
-#endif
-	dma_addr_t max = 0xffffffff;
-
 	if (ppc_md.progress)
 		ppc_md.progress("mpc85xx_mds_setup_arch()", 0);
 
-#ifdef CONFIG_PCI
-	for_each_node_by_type(np, "pci") {
-		if (of_device_is_compatible(np, "fsl,mpc8540-pci") ||
-		    of_device_is_compatible(np, "fsl,mpc8548-pcie")) {
-			struct resource rsrc;
-			of_address_to_resource(np, 0, &rsrc);
-			if ((rsrc.start & 0xfffff) == 0x8000)
-				fsl_add_bridge(np, 1);
-			else
-				fsl_add_bridge(np, 0);
-
-			hose = pci_find_hose_for_OF_device(np);
-			max = min(max, hose->dma_window_base_cur +
-					hose->dma_window_size);
-		}
-	}
-#endif
-
-#ifdef CONFIG_SMP
-	mpc85xx_smp_init();
-#endif
+	mpc85xx_setup_arch(0x8000);
 
 	mpc85xx_mds_qe_init();
-
-#ifdef CONFIG_SWIOTLB
-	if (memblock_end_of_DRAM() > max) {
-		ppc_swiotlb_enable = 1;
-		set_pci_dma_ops(&swiotlb_dma_ops);
-		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
-	}
-#endif
 }
 
 
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index d9ac565..82906b0 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -53,29 +53,12 @@ void __init mpc85xx_rdb_pic_init(void)
 /*
  * Setup the architecture
  */
-#ifdef CONFIG_SMP
-extern void __init mpc85xx_smp_init(void);
-#endif
 static void __init mpc85xx_rdb_setup_arch(void)
 {
-#ifdef CONFIG_PCI
-	struct device_node *np;
-#endif
-
 	if (ppc_md.progress)
 		ppc_md.progress("mpc85xx_rdb_setup_arch()", 0);
 
-#ifdef CONFIG_PCI
-	for_each_node_by_type(np, "pci") {
-		if (of_device_is_compatible(np, "fsl,mpc8548-pcie"))
-			fsl_add_bridge(np, 0);
-	}
-
-#endif
-
-#ifdef CONFIG_SMP
-	mpc85xx_smp_init();
-#endif
+	mpc85xx_setup_arch(MPC85xx_NO_PRIMARY_PHB);
 
 	printk(KERN_INFO "MPC85xx RDB board from Freescale Semiconductor\n");
 }
diff --git a/arch/powerpc/platforms/85xx/p1010rdb.c b/arch/powerpc/platforms/85xx/p1010rdb.c
index 9273c6a..832ed1d 100644
--- a/arch/powerpc/platforms/85xx/p1010rdb.c
+++ b/arch/powerpc/platforms/85xx/p1010rdb.c
@@ -41,20 +41,10 @@ void __init p1010_rdb_pic_init(void)
  */
 static void __init p1010_rdb_setup_arch(void)
 {
-#ifdef CONFIG_PCI
-	struct device_node *np;
-#endif
-
 	if (ppc_md.progress)
 		ppc_md.progress("p1010_rdb_setup_arch()", 0);
 
-#ifdef CONFIG_PCI
-	for_each_node_by_type(np, "pci") {
-		if (of_device_is_compatible(np, "fsl,p1010-pcie"))
-			fsl_add_bridge(np, 0);
-	}
-
-#endif
+	mpc85xx_setup_arch(MPC85xx_NO_PRIMARY_PHB);
 
 	printk(KERN_INFO "P1010 RDB board from Freescale Semiconductor\n");
 }
diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index 6a7fc02..82da3dd 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -245,41 +245,14 @@ void __init p1022_ds_pic_init(void)
 	mpc85xx_init_mpic(1, 1, 1);
 }
 
-#ifdef CONFIG_SMP
-void __init mpc85xx_smp_init(void);
-#endif
-
 /*
  * Setup the architecture
  */
 static void __init p1022_ds_setup_arch(void)
 {
-#ifdef CONFIG_PCI
-	struct device_node *np;
-#endif
-	dma_addr_t max = 0xffffffff;
-
 	if (ppc_md.progress)
 		ppc_md.progress("p1022_ds_setup_arch()", 0);
 
-#ifdef CONFIG_PCI
-	for_each_compatible_node(np, "pci", "fsl,p1022-pcie") {
-		struct resource rsrc;
-		struct pci_controller *hose;
-
-		of_address_to_resource(np, 0, &rsrc);
-
-		if ((rsrc.start & 0xfffff) == 0x8000)
-			fsl_add_bridge(np, 1);
-		else
-			fsl_add_bridge(np, 0);
-
-		hose = pci_find_hose_for_OF_device(np);
-		max = min(max, hose->dma_window_base_cur +
-			  hose->dma_window_size);
-	}
-#endif
-
 #if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
 	diu_ops.get_pixel_format	= p1022ds_get_pixel_format;
 	diu_ops.set_gamma_table		= p1022ds_set_gamma_table;
@@ -289,17 +262,7 @@ static void __init p1022_ds_setup_arch(void)
 	diu_ops.set_sysfs_monitor_port	= p1022ds_set_sysfs_monitor_port;
 #endif
 
-#ifdef CONFIG_SMP
-	mpc85xx_smp_init();
-#endif
-
-#ifdef CONFIG_SWIOTLB
-	if (memblock_end_of_DRAM() > max) {
-		ppc_swiotlb_enable = 1;
-		set_pci_dma_ops(&swiotlb_dma_ops);
-		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
-	}
-#endif
+	mpc85xx_setup_arch(0x8000);
 
 	pr_info("Freescale P1022 DS reference board\n");
 }
diff --git a/arch/powerpc/platforms/85xx/p1023_rds.c b/arch/powerpc/platforms/85xx/p1023_rds.c
index f6fc2b7..0098775 100644
--- a/arch/powerpc/platforms/85xx/p1023_rds.c
+++ b/arch/powerpc/platforms/85xx/p1023_rds.c
@@ -41,10 +41,6 @@
  * Setup the architecture
  *
  */
-#ifdef CONFIG_SMP
-void __init mpc85xx_smp_init(void);
-#endif
-
 static void __init mpc85xx_rds_setup_arch(void)
 {
 	struct device_node *np;
@@ -84,14 +80,7 @@ static void __init mpc85xx_rds_setup_arch(void)
 		}
 	}
 
-#ifdef CONFIG_PCI
-	for_each_compatible_node(np, "pci", "fsl,p1023-pcie")
-		fsl_add_bridge(np, 0);
-#endif
-
-#ifdef CONFIG_SMP
-	mpc85xx_smp_init();
-#endif
+	mpc85xx_setup_arch(MPC85xx_NO_PRIMARY_PHB);
 }
 
 static struct of_device_id p1023_ids[] = {
diff --git a/arch/powerpc/platforms/85xx/sbc8548.c b/arch/powerpc/platforms/85xx/sbc8548.c
index 862c16e..e948b4c 100644
--- a/arch/powerpc/platforms/85xx/sbc8548.c
+++ b/arch/powerpc/platforms/85xx/sbc8548.c
@@ -87,26 +87,10 @@ static int __init sbc8548_hw_rev(void)
  */
 static void __init sbc8548_setup_arch(void)
 {
-#ifdef CONFIG_PCI
-	struct device_node *np;
-#endif
-
 	if (ppc_md.progress)
 		ppc_md.progress("sbc8548_setup_arch()", 0);
 
-#ifdef CONFIG_PCI
-	for_each_node_by_type(np, "pci") {
-		if (of_device_is_compatible(np, "fsl,mpc8540-pci") ||
-		    of_device_is_compatible(np, "fsl,mpc8548-pcie")) {
-			struct resource rsrc;
-			of_address_to_resource(np, 0, &rsrc);
-			if ((rsrc.start & 0xfffff) == 0x8000)
-				fsl_add_bridge(np, 1);
-			else
-				fsl_add_bridge(np, 0);
-		}
-	}
-#endif
+	mpc85xx_setup_arch(0x8000);
 	sbc_rev = sbc8548_hw_rev();
 }
 
diff --git a/arch/powerpc/platforms/85xx/sbc8560.c b/arch/powerpc/platforms/85xx/sbc8560.c
index b211b63..b0c62f0 100644
--- a/arch/powerpc/platforms/85xx/sbc8560.c
+++ b/arch/powerpc/platforms/85xx/sbc8560.c
@@ -124,10 +124,6 @@ static void __init init_ioports(void)
 
 static void __init sbc8560_setup_arch(void)
 {
-#ifdef CONFIG_PCI
-	struct device_node *np;
-#endif
-
 	if (ppc_md.progress)
 		ppc_md.progress("sbc8560_setup_arch()", 0);
 
@@ -136,10 +132,7 @@ static void __init sbc8560_setup_arch(void)
 	init_ioports();
 #endif
 
-#ifdef CONFIG_PCI
-	for_each_compatible_node(np, "pci", "fsl,mpc8540-pci")
-		fsl_add_bridge(np, 1);
-#endif
+	mpc85xx_setup_arch(0x8000);
 }
 
 static void sbc8560_show_cpuinfo(struct seq_file *m)
diff --git a/arch/powerpc/platforms/85xx/socrates.c b/arch/powerpc/platforms/85xx/socrates.c
index a390d67..67535a5 100644
--- a/arch/powerpc/platforms/85xx/socrates.c
+++ b/arch/powerpc/platforms/85xx/socrates.c
@@ -64,17 +64,10 @@ static void __init socrates_pic_init(void)
  */
 static void __init socrates_setup_arch(void)
 {
-#ifdef CONFIG_PCI
-	struct device_node *np;
-#endif
-
 	if (ppc_md.progress)
 		ppc_md.progress("socrates_setup_arch()", 0);
 
-#ifdef CONFIG_PCI
-	for_each_compatible_node(np, "pci", "fsl,mpc8540-pci")
-		fsl_add_bridge(np, 1);
-#endif
+	mpc85xx_setup_arch(0x8000);
 }
 
 machine_device_initcall(socrates, mpc85xx_common_publish_devices);
diff --git a/arch/powerpc/platforms/85xx/stx_gp3.c b/arch/powerpc/platforms/85xx/stx_gp3.c
index cdd2d35..18a9fc5 100644
--- a/arch/powerpc/platforms/85xx/stx_gp3.c
+++ b/arch/powerpc/platforms/85xx/stx_gp3.c
@@ -58,10 +58,6 @@ static void __init stx_gp3_pic_init(void)
  */
 static void __init stx_gp3_setup_arch(void)
 {
-#ifdef CONFIG_PCI
-	struct device_node *np;
-#endif
-
 	if (ppc_md.progress)
 		ppc_md.progress("stx_gp3_setup_arch()", 0);
 
@@ -69,10 +65,7 @@ static void __init stx_gp3_setup_arch(void)
 	cpm2_reset();
 #endif
 
-#ifdef CONFIG_PCI
-	for_each_compatible_node(np, "pci", "fsl,mpc8540-pci")
-		fsl_add_bridge(np, 1);
-#endif
+	mpc85xx_setup_arch(0x8000);
 }
 
 static void stx_gp3_show_cpuinfo(struct seq_file *m)
diff --git a/arch/powerpc/platforms/85xx/tqm85xx.c b/arch/powerpc/platforms/85xx/tqm85xx.c
index 800842b..56c5518 100644
--- a/arch/powerpc/platforms/85xx/tqm85xx.c
+++ b/arch/powerpc/platforms/85xx/tqm85xx.c
@@ -56,10 +56,6 @@ static void __init tqm85xx_pic_init(void)
  */
 static void __init tqm85xx_setup_arch(void)
 {
-#ifdef CONFIG_PCI
-	struct device_node *np;
-#endif
-
 	if (ppc_md.progress)
 		ppc_md.progress("tqm85xx_setup_arch()", 0);
 
@@ -67,20 +63,7 @@ static void __init tqm85xx_setup_arch(void)
 	cpm2_reset();
 #endif
 
-#ifdef CONFIG_PCI
-	for_each_node_by_type(np, "pci") {
-		if (of_device_is_compatible(np, "fsl,mpc8540-pci") ||
-		    of_device_is_compatible(np, "fsl,mpc8548-pcie")) {
-			struct resource rsrc;
-			if (!of_address_to_resource(np, 0, &rsrc)) {
-				if ((rsrc.start & 0xfffff) == 0x8000)
-					fsl_add_bridge(np, 1);
-				else
-					fsl_add_bridge(np, 0);
-			}
-		}
-	}
-#endif
+	mpc85xx_setup_arch(0x8000);
 }
 
 static void tqm85xx_show_cpuinfo(struct seq_file *m)
diff --git a/arch/powerpc/platforms/85xx/xes_mpc85xx.c b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
index 136b732..e1ddff5 100644
--- a/arch/powerpc/platforms/85xx/xes_mpc85xx.c
+++ b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
@@ -108,21 +108,13 @@ static void xes_mpc85xx_fixups(void)
 	}
 }
 
-#ifdef CONFIG_PCI
 static int primary_phb_addr;
-#endif
 
 /*
  * Setup the architecture
  */
-#ifdef CONFIG_SMP
-extern void __init mpc85xx_smp_init(void);
-#endif
 static void __init xes_mpc85xx_setup_arch(void)
 {
-#ifdef CONFIG_PCI
-	struct device_node *np;
-#endif
 	struct device_node *root;
 	const char *model = "Unknown";
 
@@ -137,23 +129,7 @@ static void __init xes_mpc85xx_setup_arch(void)
 
 	xes_mpc85xx_fixups();
 
-#ifdef CONFIG_PCI
-	for_each_node_by_type(np, "pci") {
-		if (of_device_is_compatible(np, "fsl,mpc8540-pci") ||
-		    of_device_is_compatible(np, "fsl,mpc8548-pcie")) {
-			struct resource rsrc;
-			of_address_to_resource(np, 0, &rsrc);
-			if ((rsrc.start & 0xfffff) == primary_phb_addr)
-				fsl_add_bridge(np, 1);
-			else
-				fsl_add_bridge(np, 0);
-		}
-	}
-#endif
-
-#ifdef CONFIG_SMP
-	mpc85xx_smp_init();
-#endif
+	mpc85xx_setup_arch(primary_phb_addr);
 }
 
 machine_device_initcall(xes_mpc8572, mpc85xx_common_publish_devices);
@@ -168,9 +144,7 @@ static int __init xes_mpc8572_probe(void)
 	unsigned long root = of_get_flat_dt_root();
 
 	if (of_flat_dt_is_compatible(root, "xes,MPC8572")) {
-#ifdef CONFIG_PCI
 		primary_phb_addr = 0x8000;
-#endif
 		return 1;
 	} else {
 		return 0;
@@ -182,9 +156,7 @@ static int __init xes_mpc8548_probe(void)
 	unsigned long root = of_get_flat_dt_root();
 
 	if (of_flat_dt_is_compatible(root, "xes,MPC8548")) {
-#ifdef CONFIG_PCI
 		primary_phb_addr = 0xb000;
-#endif
 		return 1;
 	} else {
 		return 0;
@@ -196,9 +168,7 @@ static int __init xes_mpc8540_probe(void)
 	unsigned long root = of_get_flat_dt_root();
 
 	if (of_flat_dt_is_compatible(root, "xes,MPC8540")) {
-#ifdef CONFIG_PCI
 		primary_phb_addr = 0xb000;
-#endif
 		return 1;
 	} else {
 		return 0;
-- 
1.7.7.1
