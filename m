Return-Path: <B38951@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2B9782C008E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2012 20:35:31 +1000 (EST)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>
Subject: [PATCH V8] powerpc/fsl-pci: Unify pci/pcie initialization code
Date: Mon, 20 Aug 2012 18:06:01 +0800
Message-ID: <1345457161-4731-1-git-send-email-B38951@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: B07421@freescale.com, b38951@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We unified the Freescale pci/pcie initialization by changing the fsl_pci
to a platform driver. In previous PCI code architecture the initialization
routine is called at board_setup_arch stage. Now the initialization is done
in probe function which is architectural better. Also It's convenient for
adding PM support for PCI controller in later patch.

Now we registered pci controllers as platform devices. So we combine two
initialization code as one platform driver.

Signed-off-by: Jia Hongtao <B38951@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
---
Changes for V8:
* Use previous primary determination. Based on the point that there are
  bugs on primary-less system.
* Add exceptional support on ge_imp3a in which the primary bus is not the
  first pci bus detected.

 arch/powerpc/platforms/85xx/common.c       |   10 ++++
 arch/powerpc/platforms/85xx/corenet_ds.c   |   34 ++-----------
 arch/powerpc/platforms/85xx/ge_imp3a.c     |   64 ++++++++-----------------
 arch/powerpc/platforms/85xx/mpc8536_ds.c   |   36 +-------------
 arch/powerpc/platforms/85xx/mpc85xx_ads.c  |   11 +---
 arch/powerpc/platforms/85xx/mpc85xx_cds.c  |   16 +-----
 arch/powerpc/platforms/85xx/mpc85xx_ds.c   |   14 ++---
 arch/powerpc/platforms/85xx/mpc85xx_mds.c  |   40 ++-------------
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c  |   30 +++++-------
 arch/powerpc/platforms/85xx/p1010rdb.c     |   14 +-----
 arch/powerpc/platforms/85xx/p1022_ds.c     |   36 ++------------
 arch/powerpc/platforms/85xx/p1022_rdk.c    |   36 ++------------
 arch/powerpc/platforms/85xx/p1023_rds.c    |    9 +--
 arch/powerpc/platforms/85xx/p2041_rdb.c    |    2 +-
 arch/powerpc/platforms/85xx/p3041_ds.c     |    2 +-
 arch/powerpc/platforms/85xx/p4080_ds.c     |    2 +-
 arch/powerpc/platforms/85xx/p5020_ds.c     |    2 +-
 arch/powerpc/platforms/85xx/p5040_ds.c     |    2 +-
 arch/powerpc/platforms/85xx/qemu_e500.c    |    4 +-
 arch/powerpc/platforms/85xx/sbc8548.c      |   21 +-------
 arch/powerpc/platforms/85xx/socrates.c     |   11 +----
 arch/powerpc/platforms/85xx/stx_gp3.c      |   13 +----
 arch/powerpc/platforms/85xx/tqm85xx.c      |   21 +-------
 arch/powerpc/platforms/85xx/xes_mpc85xx.c  |   56 +++-------------------
 arch/powerpc/platforms/86xx/gef_ppc9a.c    |   12 ++---
 arch/powerpc/platforms/86xx/gef_sbc310.c   |   13 ++----
 arch/powerpc/platforms/86xx/gef_sbc610.c   |   12 ++---
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c |   21 ++------
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |   42 ++--------------
 arch/powerpc/platforms/86xx/sbc8641d.c     |   14 ++----
 arch/powerpc/sysdev/fsl_pci.c              |   71 +++++++++++++++++----------
 arch/powerpc/sysdev/fsl_pci.h              |   15 +++++-
 drivers/edac/mpc85xx_edac.c                |   43 +++++------------
 33 files changed, 203 insertions(+), 526 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/common.c b/arch/powerpc/platforms/85xx/common.c
index 67dac22..d0861a0 100644
--- a/arch/powerpc/platforms/85xx/common.c
+++ b/arch/powerpc/platforms/85xx/common.c
@@ -27,6 +27,16 @@ static struct of_device_id __initdata mpc85xx_common_ids[] = {
 	{ .compatible = "fsl,mpc8548-guts", },
 	/* Probably unnecessary? */
 	{ .compatible = "gpio-leds", },
+	/* For all PCI controllers */
+	{ .compatible = "fsl,mpc8540-pci", },
+	{ .compatible = "fsl,mpc8548-pcie", },
+	{ .compatible = "fsl,p1022-pcie", },
+	{ .compatible = "fsl,p1010-pcie", },
+	{ .compatible = "fsl,p1023-pcie", },
+	{ .compatible = "fsl,p4080-pcie", },
+	{ .compatible = "fsl,qoriq-pcie-v2.4", },
+	{ .compatible = "fsl,qoriq-pcie-v2.3", },
+	{ .compatible = "fsl,qoriq-pcie-v2.2", },
 	{},
 };
 
diff --git a/arch/powerpc/platforms/85xx/corenet_ds.c b/arch/powerpc/platforms/85xx/corenet_ds.c
index 473d573..ed69c92 100644
--- a/arch/powerpc/platforms/85xx/corenet_ds.c
+++ b/arch/powerpc/platforms/85xx/corenet_ds.c
@@ -16,7 +16,6 @@
 #include <linux/kdev_t.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
-#include <linux/memblock.h>
 
 #include <asm/time.h>
 #include <asm/machdep.h>
@@ -52,39 +51,16 @@ void __init corenet_ds_pic_init(void)
  */
 void __init corenet_ds_setup_arch(void)
 {
-#ifdef CONFIG_PCI
-	struct device_node *np;
-	struct pci_controller *hose;
-#endif
-	dma_addr_t max = 0xffffffff;
-
 	mpc85xx_smp_init();
 
-#ifdef CONFIG_PCI
-	for_each_node_by_type(np, "pci") {
-		if (of_device_is_compatible(np, "fsl,p4080-pcie") ||
-		    of_device_is_compatible(np, "fsl,qoriq-pcie-v2.2") ||
-		    of_device_is_compatible(np, "fsl,qoriq-pcie-v2.3") ||
-		    of_device_is_compatible(np, "fsl,qoriq-pcie-v2.4")) {
-			fsl_add_bridge(np, 0);
-			hose = pci_find_hose_for_OF_device(np);
-			max = min(max, hose->dma_window_base_cur +
-					hose->dma_window_size);
-		}
-	}
-
-#ifdef CONFIG_PPC64
+#if defined(CONFIG_PCI) && defined(CONFIG_PPC64)
 	pci_devs_phb_init();
 #endif
-#endif
 
-#ifdef CONFIG_SWIOTLB
-	if ((memblock_end_of_DRAM() - 1) > max) {
-		ppc_swiotlb_enable = 1;
-		set_pci_dma_ops(&swiotlb_dma_ops);
-		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
-	}
-#endif
+	fsl_pci_assign_primary();
+
+	swiotlb_detect_4g();
+
 	pr_info("%s board from Freescale Semiconductor\n", ppc_md.name);
 }
 
diff --git a/arch/powerpc/platforms/85xx/ge_imp3a.c b/arch/powerpc/platforms/85xx/ge_imp3a.c
index b6a728b..1eb0046 100644
--- a/arch/powerpc/platforms/85xx/ge_imp3a.c
+++ b/arch/powerpc/platforms/85xx/ge_imp3a.c
@@ -22,7 +22,6 @@
 #include <linux/seq_file.h>
 #include <linux/interrupt.h>
 #include <linux/of_platform.h>
-#include <linux/memblock.h>
 
 #include <asm/time.h>
 #include <asm/machdep.h>
@@ -84,53 +83,37 @@ void __init ge_imp3a_pic_init(void)
 	of_node_put(cascade_node);
 }
 
-#ifdef CONFIG_PCI
-static int primary_phb_addr;
-#endif	/* CONFIG_PCI */
-
-/*
- * Setup the architecture
- */
-static void __init ge_imp3a_setup_arch(void)
+void ge_imp3a_assign_pci_primary(void)
 {
-	struct device_node *regs;
-#ifdef CONFIG_PCI
 	struct device_node *np;
-	struct pci_controller *hose;
-#endif
-	dma_addr_t max = 0xffffffff;
-
-	if (ppc_md.progress)
-		ppc_md.progress("ge_imp3a_setup_arch()", 0);
+	struct resource rsrc;
 
-#ifdef CONFIG_PCI
 	for_each_node_by_type(np, "pci") {
 		if (of_device_is_compatible(np, "fsl,mpc8540-pci") ||
 		    of_device_is_compatible(np, "fsl,mpc8548-pcie") ||
 		    of_device_is_compatible(np, "fsl,p2020-pcie")) {
-			struct resource rsrc;
 			of_address_to_resource(np, 0, &rsrc);
-			if ((rsrc.start & 0xfffff) == primary_phb_addr)
-				fsl_add_bridge(np, 1);
-			else
-				fsl_add_bridge(np, 0);
-
-			hose = pci_find_hose_for_OF_device(np);
-			max = min(max, hose->dma_window_base_cur +
-					hose->dma_window_size);
+			if ((rsrc.start & 0xfffff) == 0x9000)
+				fsl_pci_primary = np;
 		}
 	}
-#endif
+}
+
+/*
+ * Setup the architecture
+ */
+static void __init ge_imp3a_setup_arch(void)
+{
+	struct device_node *regs;
+
+	if (ppc_md.progress)
+		ppc_md.progress("ge_imp3a_setup_arch()", 0);
 
 	mpc85xx_smp_init();
 
-#ifdef CONFIG_SWIOTLB
-	if ((memblock_end_of_DRAM() - 1) > max) {
-		ppc_swiotlb_enable = 1;
-		set_pci_dma_ops(&swiotlb_dma_ops);
-		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
-	}
-#endif
+	ge_imp3a_assign_pci_primary();
+
+	swiotlb_detect_4g();
 
 	/* Remap basic board registers */
 	regs = of_find_compatible_node(NULL, NULL, "ge,imp3a-fpga-regs");
@@ -215,17 +198,10 @@ static int __init ge_imp3a_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
 
-	if (of_flat_dt_is_compatible(root, "ge,IMP3A")) {
-#ifdef CONFIG_PCI
-		primary_phb_addr = 0x9000;
-#endif
-		return 1;
-	}
-
-	return 0;
+	return of_flat_dt_is_compatible(root, "ge,IMP3A");
 }
 
-machine_device_initcall(ge_imp3a, mpc85xx_common_publish_devices);
+machine_arch_initcall(ge_imp3a, mpc85xx_common_publish_devices);
 
 machine_arch_initcall(ge_imp3a, swiotlb_setup_bus_notifier);
 
diff --git a/arch/powerpc/platforms/85xx/mpc8536_ds.c b/arch/powerpc/platforms/85xx/mpc8536_ds.c
index 767c7cf..15ce4b5 100644
--- a/arch/powerpc/platforms/85xx/mpc8536_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc8536_ds.c
@@ -17,7 +17,6 @@
 #include <linux/seq_file.h>
 #include <linux/interrupt.h>
 #include <linux/of_platform.h>
-#include <linux/memblock.h>
 
 #include <asm/time.h>
 #include <asm/machdep.h>
@@ -46,46 +45,17 @@ void __init mpc8536_ds_pic_init(void)
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
+	fsl_pci_assign_primary();
 
-#ifdef CONFIG_SWIOTLB
-	if ((memblock_end_of_DRAM() - 1) > max) {
-		ppc_swiotlb_enable = 1;
-		set_pci_dma_ops(&swiotlb_dma_ops);
-		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
-	}
-#endif
+	swiotlb_detect_4g();
 
 	printk("MPC8536 DS board from Freescale Semiconductor\n");
 }
 
-machine_device_initcall(mpc8536_ds, mpc85xx_common_publish_devices);
+machine_arch_initcall(mpc8536_ds, mpc85xx_common_publish_devices);
 
 machine_arch_initcall(mpc8536_ds, swiotlb_setup_bus_notifier);
 
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index 29ee8fc..7d12a19 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -137,10 +137,6 @@ static void __init init_ioports(void)
 
 static void __init mpc85xx_ads_setup_arch(void)
 {
-#ifdef CONFIG_PCI
-	struct device_node *np;
-#endif
-
 	if (ppc_md.progress)
 		ppc_md.progress("mpc85xx_ads_setup_arch()", 0);
 
@@ -150,11 +146,10 @@ static void __init mpc85xx_ads_setup_arch(void)
 #endif
 
 #ifdef CONFIG_PCI
-	for_each_compatible_node(np, "pci", "fsl,mpc8540-pci")
-		fsl_add_bridge(np, 1);
-
 	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
 #endif
+
+	fsl_pci_assign_primary();
 }
 
 static void mpc85xx_ads_show_cpuinfo(struct seq_file *m)
@@ -173,7 +168,7 @@ static void mpc85xx_ads_show_cpuinfo(struct seq_file *m)
 	seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
 }
 
-machine_device_initcall(mpc85xx_ads, mpc85xx_common_publish_devices);
+machine_arch_initcall(mpc85xx_ads, mpc85xx_common_publish_devices);
 
 /*
  * Called very early, device-tree isn't unflattened
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 11156fb..48cb82a 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -309,21 +309,11 @@ static void __init mpc85xx_cds_setup_arch(void)
 	}
 
 #ifdef CONFIG_PCI
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
-
 	ppc_md.pci_irq_fixup = mpc85xx_cds_pci_irq_fixup;
 	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
 #endif
+
+	fsl_pci_assign_primary();
 }
 
 static void mpc85xx_cds_show_cpuinfo(struct seq_file *m)
@@ -355,7 +345,7 @@ static int __init mpc85xx_cds_probe(void)
         return of_flat_dt_is_compatible(root, "MPC85xxCDS");
 }
 
-machine_device_initcall(mpc85xx_cds, mpc85xx_common_publish_devices);
+machine_arch_initcall(mpc85xx_cds, mpc85xx_common_publish_devices);
 
 define_machine(mpc85xx_cds) {
 	.name		= "MPC85xx CDS",
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 56f8c8f..9ebb91e 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -20,7 +20,6 @@
 #include <linux/seq_file.h>
 #include <linux/interrupt.h>
 #include <linux/of_platform.h>
-#include <linux/memblock.h>
 
 #include <asm/time.h>
 #include <asm/machdep.h>
@@ -129,13 +128,11 @@ static int mpc85xx_exclude_device(struct pci_controller *hose,
 }
 #endif	/* CONFIG_PCI */
 
-static void __init mpc85xx_ds_pci_init(void)
+static void __init mpc85xx_ds_uli_init(void)
 {
 #ifdef CONFIG_PCI
 	struct device_node *node;
 
-	fsl_pci_init();
-
 	/* See if we have a ULI under the primary */
 
 	node = of_find_node_by_name(NULL, "uli1575");
@@ -160,7 +157,8 @@ static void __init mpc85xx_ds_setup_arch(void)
 		ppc_md.progress("mpc85xx_ds_setup_arch()", 0);
 
 	swiotlb_detect_4g();
-	mpc85xx_ds_pci_init();
+	fsl_pci_assign_primary();
+	mpc85xx_ds_uli_init();
 	mpc85xx_smp_init();
 
 	printk("MPC85xx DS board from Freescale Semiconductor\n");
@@ -176,9 +174,9 @@ static int __init mpc8544_ds_probe(void)
 	return !!of_flat_dt_is_compatible(root, "MPC8544DS");
 }
 
-machine_device_initcall(mpc8544_ds, mpc85xx_common_publish_devices);
-machine_device_initcall(mpc8572_ds, mpc85xx_common_publish_devices);
-machine_device_initcall(p2020_ds, mpc85xx_common_publish_devices);
+machine_arch_initcall(mpc8544_ds, mpc85xx_common_publish_devices);
+machine_arch_initcall(mpc8572_ds, mpc85xx_common_publish_devices);
+machine_arch_initcall(p2020_ds, mpc85xx_common_publish_devices);
 
 machine_arch_initcall(mpc8544_ds, swiotlb_setup_bus_notifier);
 machine_arch_initcall(mpc8572_ds, swiotlb_setup_bus_notifier);
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 8e4b094..8498f73 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -327,44 +327,16 @@ static void __init mpc85xx_mds_qeic_init(void) { }
 
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
 	mpc85xx_smp_init();
 
 	mpc85xx_mds_qe_init();
 
-#ifdef CONFIG_SWIOTLB
-	if ((memblock_end_of_DRAM() - 1) > max) {
-		ppc_swiotlb_enable = 1;
-		set_pci_dma_ops(&swiotlb_dma_ops);
-		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
-	}
-#endif
+	fsl_pci_assign_primary();
+
+	swiotlb_detect_4g();
 }
 
 
@@ -409,9 +381,9 @@ static int __init mpc85xx_publish_devices(void)
 	return mpc85xx_common_publish_devices();
 }
 
-machine_device_initcall(mpc8568_mds, mpc85xx_publish_devices);
-machine_device_initcall(mpc8569_mds, mpc85xx_publish_devices);
-machine_device_initcall(p1021_mds, mpc85xx_common_publish_devices);
+machine_arch_initcall(mpc8568_mds, mpc85xx_publish_devices);
+machine_arch_initcall(mpc8569_mds, mpc85xx_publish_devices);
+machine_arch_initcall(p1021_mds, mpc85xx_common_publish_devices);
 
 machine_arch_initcall(mpc8568_mds, swiotlb_setup_bus_notifier);
 machine_arch_initcall(mpc8569_mds, swiotlb_setup_bus_notifier);
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index 1910fdc..ede8771 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -86,23 +86,17 @@ void __init mpc85xx_rdb_pic_init(void)
  */
 static void __init mpc85xx_rdb_setup_arch(void)
 {
-#if defined(CONFIG_PCI) || defined(CONFIG_QUICC_ENGINE)
+#ifdef CONFIG_QUICC_ENGINE
 	struct device_node *np;
 #endif
 
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
 	mpc85xx_smp_init();
 
+	fsl_pci_assign_primary();
+
 #ifdef CONFIG_QUICC_ENGINE
 	np = of_find_compatible_node(NULL, NULL, "fsl,qe");
 	if (!np) {
@@ -161,15 +155,15 @@ qe_fail:
 	printk(KERN_INFO "MPC85xx RDB board from Freescale Semiconductor\n");
 }
 
-machine_device_initcall(p2020_rdb, mpc85xx_common_publish_devices);
-machine_device_initcall(p2020_rdb_pc, mpc85xx_common_publish_devices);
-machine_device_initcall(p1020_mbg_pc, mpc85xx_common_publish_devices);
-machine_device_initcall(p1020_rdb, mpc85xx_common_publish_devices);
-machine_device_initcall(p1020_rdb_pc, mpc85xx_common_publish_devices);
-machine_device_initcall(p1020_utm_pc, mpc85xx_common_publish_devices);
-machine_device_initcall(p1021_rdb_pc, mpc85xx_common_publish_devices);
-machine_device_initcall(p1025_rdb, mpc85xx_common_publish_devices);
-machine_device_initcall(p1024_rdb, mpc85xx_common_publish_devices);
+machine_arch_initcall(p2020_rdb, mpc85xx_common_publish_devices);
+machine_arch_initcall(p2020_rdb_pc, mpc85xx_common_publish_devices);
+machine_arch_initcall(p1020_mbg_pc, mpc85xx_common_publish_devices);
+machine_arch_initcall(p1020_rdb, mpc85xx_common_publish_devices);
+machine_arch_initcall(p1020_rdb_pc, mpc85xx_common_publish_devices);
+machine_arch_initcall(p1020_utm_pc, mpc85xx_common_publish_devices);
+machine_arch_initcall(p1021_rdb_pc, mpc85xx_common_publish_devices);
+machine_arch_initcall(p1025_rdb, mpc85xx_common_publish_devices);
+machine_arch_initcall(p1024_rdb, mpc85xx_common_publish_devices);
 
 /*
  * Called very early, device-tree isn't unflattened
diff --git a/arch/powerpc/platforms/85xx/p1010rdb.c b/arch/powerpc/platforms/85xx/p1010rdb.c
index dbaf443..0252961 100644
--- a/arch/powerpc/platforms/85xx/p1010rdb.c
+++ b/arch/powerpc/platforms/85xx/p1010rdb.c
@@ -46,25 +46,15 @@ void __init p1010_rdb_pic_init(void)
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
+	fsl_pci_assign_primary();
 
 	printk(KERN_INFO "P1010 RDB board from Freescale Semiconductor\n");
 }
 
-machine_device_initcall(p1010_rdb, mpc85xx_common_publish_devices);
+machine_arch_initcall(p1010_rdb, mpc85xx_common_publish_devices);
 machine_arch_initcall(p1010_rdb, swiotlb_setup_bus_notifier);
 
 /*
diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index 3c732ac..848a3e9 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -18,7 +18,6 @@
 
 #include <linux/pci.h>
 #include <linux/of_platform.h>
-#include <linux/memblock.h>
 #include <asm/div64.h>
 #include <asm/mpic.h>
 #include <asm/swiotlb.h>
@@ -507,32 +506,9 @@ early_param("video", early_video_setup);
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
@@ -601,18 +577,14 @@ static void __init p1022_ds_setup_arch(void)
 
 	mpc85xx_smp_init();
 
-#ifdef CONFIG_SWIOTLB
-	if ((memblock_end_of_DRAM() - 1) > max) {
-		ppc_swiotlb_enable = 1;
-		set_pci_dma_ops(&swiotlb_dma_ops);
-		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
-	}
-#endif
+	fsl_pci_assign_primary();
+
+	swiotlb_detect_4g();
 
 	pr_info("Freescale P1022 DS reference board\n");
 }
 
-machine_device_initcall(p1022_ds, mpc85xx_common_publish_devices);
+machine_arch_initcall(p1022_ds, mpc85xx_common_publish_devices);
 
 machine_arch_initcall(p1022_ds, swiotlb_setup_bus_notifier);
 
diff --git a/arch/powerpc/platforms/85xx/p1022_rdk.c b/arch/powerpc/platforms/85xx/p1022_rdk.c
index b3cf11b..55ffa1c 100644
--- a/arch/powerpc/platforms/85xx/p1022_rdk.c
+++ b/arch/powerpc/platforms/85xx/p1022_rdk.c
@@ -14,7 +14,6 @@
 
 #include <linux/pci.h>
 #include <linux/of_platform.h>
-#include <linux/memblock.h>
 #include <asm/div64.h>
 #include <asm/mpic.h>
 #include <asm/swiotlb.h>
@@ -121,32 +120,9 @@ void __init p1022_rdk_pic_init(void)
  */
 static void __init p1022_rdk_setup_arch(void)
 {
-#ifdef CONFIG_PCI
-	struct device_node *np;
-#endif
-	dma_addr_t max = 0xffffffff;
-
 	if (ppc_md.progress)
 		ppc_md.progress("p1022_rdk_setup_arch()", 0);
 
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
 	diu_ops.set_monitor_port	= p1022rdk_set_monitor_port;
 	diu_ops.set_pixel_clock		= p1022rdk_set_pixel_clock;
@@ -155,18 +131,14 @@ static void __init p1022_rdk_setup_arch(void)
 
 	mpc85xx_smp_init();
 
-#ifdef CONFIG_SWIOTLB
-	if ((memblock_end_of_DRAM() - 1) > max) {
-		ppc_swiotlb_enable = 1;
-		set_pci_dma_ops(&swiotlb_dma_ops);
-		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
-	}
-#endif
+	fsl_pci_assign_primary();
+
+	swiotlb_detect_4g();
 
 	pr_info("Freescale / iVeia P1022 RDK reference board\n");
 }
 
-machine_device_initcall(p1022_rdk, mpc85xx_common_publish_devices);
+machine_arch_initcall(p1022_rdk, mpc85xx_common_publish_devices);
 
 machine_arch_initcall(p1022_rdk, swiotlb_setup_bus_notifier);
 
diff --git a/arch/powerpc/platforms/85xx/p1023_rds.c b/arch/powerpc/platforms/85xx/p1023_rds.c
index 2990e8b..9cc60a7 100644
--- a/arch/powerpc/platforms/85xx/p1023_rds.c
+++ b/arch/powerpc/platforms/85xx/p1023_rds.c
@@ -80,15 +80,12 @@ static void __init mpc85xx_rds_setup_arch(void)
 		}
 	}
 
-#ifdef CONFIG_PCI
-	for_each_compatible_node(np, "pci", "fsl,p1023-pcie")
-		fsl_add_bridge(np, 0);
-#endif
-
 	mpc85xx_smp_init();
+
+	fsl_pci_assign_primary();
 }
 
-machine_device_initcall(p1023_rds, mpc85xx_common_publish_devices);
+machine_arch_initcall(p1023_rds, mpc85xx_common_publish_devices);
 
 static void __init mpc85xx_rds_pic_init(void)
 {
diff --git a/arch/powerpc/platforms/85xx/p2041_rdb.c b/arch/powerpc/platforms/85xx/p2041_rdb.c
index 6541fa2..000c089 100644
--- a/arch/powerpc/platforms/85xx/p2041_rdb.c
+++ b/arch/powerpc/platforms/85xx/p2041_rdb.c
@@ -80,7 +80,7 @@ define_machine(p2041_rdb) {
 	.power_save		= e500_idle,
 };
 
-machine_device_initcall(p2041_rdb, corenet_ds_publish_devices);
+machine_arch_initcall(p2041_rdb, corenet_ds_publish_devices);
 
 #ifdef CONFIG_SWIOTLB
 machine_arch_initcall(p2041_rdb, swiotlb_setup_bus_notifier);
diff --git a/arch/powerpc/platforms/85xx/p3041_ds.c b/arch/powerpc/platforms/85xx/p3041_ds.c
index f238efa..b3edc20 100644
--- a/arch/powerpc/platforms/85xx/p3041_ds.c
+++ b/arch/powerpc/platforms/85xx/p3041_ds.c
@@ -82,7 +82,7 @@ define_machine(p3041_ds) {
 	.power_save		= e500_idle,
 };
 
-machine_device_initcall(p3041_ds, corenet_ds_publish_devices);
+machine_arch_initcall(p3041_ds, corenet_ds_publish_devices);
 
 #ifdef CONFIG_SWIOTLB
 machine_arch_initcall(p3041_ds, swiotlb_setup_bus_notifier);
diff --git a/arch/powerpc/platforms/85xx/p4080_ds.c b/arch/powerpc/platforms/85xx/p4080_ds.c
index c92417d..54df106 100644
--- a/arch/powerpc/platforms/85xx/p4080_ds.c
+++ b/arch/powerpc/platforms/85xx/p4080_ds.c
@@ -81,7 +81,7 @@ define_machine(p4080_ds) {
 	.power_save		= e500_idle,
 };
 
-machine_device_initcall(p4080_ds, corenet_ds_publish_devices);
+machine_arch_initcall(p4080_ds, corenet_ds_publish_devices);
 #ifdef CONFIG_SWIOTLB
 machine_arch_initcall(p4080_ds, swiotlb_setup_bus_notifier);
 #endif
diff --git a/arch/powerpc/platforms/85xx/p5020_ds.c b/arch/powerpc/platforms/85xx/p5020_ds.c
index 17bef15..753a42c 100644
--- a/arch/powerpc/platforms/85xx/p5020_ds.c
+++ b/arch/powerpc/platforms/85xx/p5020_ds.c
@@ -91,7 +91,7 @@ define_machine(p5020_ds) {
 #endif
 };
 
-machine_device_initcall(p5020_ds, corenet_ds_publish_devices);
+machine_arch_initcall(p5020_ds, corenet_ds_publish_devices);
 
 #ifdef CONFIG_SWIOTLB
 machine_arch_initcall(p5020_ds, swiotlb_setup_bus_notifier);
diff --git a/arch/powerpc/platforms/85xx/p5040_ds.c b/arch/powerpc/platforms/85xx/p5040_ds.c
index 8e22a34..1138185 100644
--- a/arch/powerpc/platforms/85xx/p5040_ds.c
+++ b/arch/powerpc/platforms/85xx/p5040_ds.c
@@ -82,7 +82,7 @@ define_machine(p5040_ds) {
 #endif
 };
 
-machine_device_initcall(p5040_ds, corenet_ds_publish_devices);
+machine_arch_initcall(p5040_ds, corenet_ds_publish_devices);
 
 #ifdef CONFIG_SWIOTLB
 machine_arch_initcall(p5040_ds, swiotlb_setup_bus_notifier);
diff --git a/arch/powerpc/platforms/85xx/qemu_e500.c b/arch/powerpc/platforms/85xx/qemu_e500.c
index 3c5490c..f6ea561 100644
--- a/arch/powerpc/platforms/85xx/qemu_e500.c
+++ b/arch/powerpc/platforms/85xx/qemu_e500.c
@@ -41,7 +41,7 @@ static void __init qemu_e500_setup_arch(void)
 {
 	ppc_md.progress("qemu_e500_setup_arch()", 0);
 
-	fsl_pci_init();
+	fsl_pci_assign_primary();
 	swiotlb_detect_4g();
 	mpc85xx_smp_init();
 }
@@ -56,7 +56,7 @@ static int __init qemu_e500_probe(void)
 	return !!of_flat_dt_is_compatible(root, "fsl,qemu-e500");
 }
 
-machine_device_initcall(qemu_e500, mpc85xx_common_publish_devices);
+machine_arch_initcall(qemu_e500, mpc85xx_common_publish_devices);
 
 define_machine(qemu_e500) {
 	.name			= "QEMU e500",
diff --git a/arch/powerpc/platforms/85xx/sbc8548.c b/arch/powerpc/platforms/85xx/sbc8548.c
index cd3a66b..f621218 100644
--- a/arch/powerpc/platforms/85xx/sbc8548.c
+++ b/arch/powerpc/platforms/85xx/sbc8548.c
@@ -88,26 +88,11 @@ static int __init sbc8548_hw_rev(void)
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
+	fsl_pci_assign_primary();
+
 	sbc_rev = sbc8548_hw_rev();
 }
 
@@ -128,7 +113,7 @@ static void sbc8548_show_cpuinfo(struct seq_file *m)
 	seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
 }
 
-machine_device_initcall(sbc8548, mpc85xx_common_publish_devices);
+machine_arch_initcall(sbc8548, mpc85xx_common_publish_devices);
 
 /*
  * Called very early, device-tree isn't unflattened
diff --git a/arch/powerpc/platforms/85xx/socrates.c b/arch/powerpc/platforms/85xx/socrates.c
index b9c6daa..ae368e0 100644
--- a/arch/powerpc/platforms/85xx/socrates.c
+++ b/arch/powerpc/platforms/85xx/socrates.c
@@ -66,20 +66,13 @@ static void __init socrates_pic_init(void)
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
+	fsl_pci_assign_primary();
 }
 
-machine_device_initcall(socrates, mpc85xx_common_publish_devices);
+machine_arch_initcall(socrates, mpc85xx_common_publish_devices);
 
 /*
  * Called very early, device-tree isn't unflattened
diff --git a/arch/powerpc/platforms/85xx/stx_gp3.c b/arch/powerpc/platforms/85xx/stx_gp3.c
index e050800..6f4939b 100644
--- a/arch/powerpc/platforms/85xx/stx_gp3.c
+++ b/arch/powerpc/platforms/85xx/stx_gp3.c
@@ -60,21 +60,14 @@ static void __init stx_gp3_pic_init(void)
  */
 static void __init stx_gp3_setup_arch(void)
 {
-#ifdef CONFIG_PCI
-	struct device_node *np;
-#endif
-
 	if (ppc_md.progress)
 		ppc_md.progress("stx_gp3_setup_arch()", 0);
 
+	fsl_pci_assign_primary();
+
 #ifdef CONFIG_CPM2
 	cpm2_reset();
 #endif
-
-#ifdef CONFIG_PCI
-	for_each_compatible_node(np, "pci", "fsl,mpc8540-pci")
-		fsl_add_bridge(np, 1);
-#endif
 }
 
 static void stx_gp3_show_cpuinfo(struct seq_file *m)
@@ -93,7 +86,7 @@ static void stx_gp3_show_cpuinfo(struct seq_file *m)
 	seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
 }
 
-machine_device_initcall(stx_gp3, mpc85xx_common_publish_devices);
+machine_arch_initcall(stx_gp3, mpc85xx_common_publish_devices);
 
 /*
  * Called very early, device-tree isn't unflattened
diff --git a/arch/powerpc/platforms/85xx/tqm85xx.c b/arch/powerpc/platforms/85xx/tqm85xx.c
index 4d786c2..942870f 100644
--- a/arch/powerpc/platforms/85xx/tqm85xx.c
+++ b/arch/powerpc/platforms/85xx/tqm85xx.c
@@ -59,10 +59,6 @@ static void __init tqm85xx_pic_init(void)
  */
 static void __init tqm85xx_setup_arch(void)
 {
-#ifdef CONFIG_PCI
-	struct device_node *np;
-#endif
-
 	if (ppc_md.progress)
 		ppc_md.progress("tqm85xx_setup_arch()", 0);
 
@@ -70,20 +66,7 @@ static void __init tqm85xx_setup_arch(void)
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
+	fsl_pci_assign_primary();
 }
 
 static void tqm85xx_show_cpuinfo(struct seq_file *m)
@@ -123,7 +106,7 @@ static void __init tqm85xx_ti1520_fixup(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_1520,
 		tqm85xx_ti1520_fixup);
 
-machine_device_initcall(tqm85xx, mpc85xx_common_publish_devices);
+machine_arch_initcall(tqm85xx, mpc85xx_common_publish_devices);
 
 static const char *board[] __initdata = {
 	"tqc,tqm8540",
diff --git a/arch/powerpc/platforms/85xx/xes_mpc85xx.c b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
index 41c6875..dcbf7e4 100644
--- a/arch/powerpc/platforms/85xx/xes_mpc85xx.c
+++ b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
@@ -111,18 +111,11 @@ static void xes_mpc85xx_fixups(void)
 	}
 }
 
-#ifdef CONFIG_PCI
-static int primary_phb_addr;
-#endif
-
 /*
  * Setup the architecture
  */
 static void __init xes_mpc85xx_setup_arch(void)
 {
-#ifdef CONFIG_PCI
-	struct device_node *np;
-#endif
 	struct device_node *root;
 	const char *model = "Unknown";
 
@@ -137,26 +130,14 @@ static void __init xes_mpc85xx_setup_arch(void)
 
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
 	mpc85xx_smp_init();
+
+	fsl_pci_assign_primary();
 }
 
-machine_device_initcall(xes_mpc8572, mpc85xx_common_publish_devices);
-machine_device_initcall(xes_mpc8548, mpc85xx_common_publish_devices);
-machine_device_initcall(xes_mpc8540, mpc85xx_common_publish_devices);
+machine_arch_initcall(xes_mpc8572, mpc85xx_common_publish_devices);
+machine_arch_initcall(xes_mpc8548, mpc85xx_common_publish_devices);
+machine_arch_initcall(xes_mpc8540, mpc85xx_common_publish_devices);
 
 /*
  * Called very early, device-tree isn't unflattened
@@ -165,42 +146,21 @@ static int __init xes_mpc8572_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
 
-	if (of_flat_dt_is_compatible(root, "xes,MPC8572")) {
-#ifdef CONFIG_PCI
-		primary_phb_addr = 0x8000;
-#endif
-		return 1;
-	} else {
-		return 0;
-	}
+	return of_flat_dt_is_compatible(root, "xes,MPC8572");
 }
 
 static int __init xes_mpc8548_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
 
-	if (of_flat_dt_is_compatible(root, "xes,MPC8548")) {
-#ifdef CONFIG_PCI
-		primary_phb_addr = 0xb000;
-#endif
-		return 1;
-	} else {
-		return 0;
-	}
+	return of_flat_dt_is_compatible(root, "xes,MPC8548");
 }
 
 static int __init xes_mpc8540_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
 
-	if (of_flat_dt_is_compatible(root, "xes,MPC8540")) {
-#ifdef CONFIG_PCI
-		primary_phb_addr = 0xb000;
-#endif
-		return 1;
-	} else {
-		return 0;
-	}
+	return of_flat_dt_is_compatible(root, "xes,MPC8540");
 }
 
 define_machine(xes_mpc8572) {
diff --git a/arch/powerpc/platforms/86xx/gef_ppc9a.c b/arch/powerpc/platforms/86xx/gef_ppc9a.c
index 1fca663..58d753f 100644
--- a/arch/powerpc/platforms/86xx/gef_ppc9a.c
+++ b/arch/powerpc/platforms/86xx/gef_ppc9a.c
@@ -73,13 +73,6 @@ static void __init gef_ppc9a_init_irq(void)
 static void __init gef_ppc9a_setup_arch(void)
 {
 	struct device_node *regs;
-#ifdef CONFIG_PCI
-	struct device_node *np;
-
-	for_each_compatible_node(np, "pci", "fsl,mpc8641-pcie") {
-		fsl_add_bridge(np, 1);
-	}
-#endif
 
 	printk(KERN_INFO "GE Intelligent Platforms PPC9A 6U VME SBC\n");
 
@@ -87,6 +80,8 @@ static void __init gef_ppc9a_setup_arch(void)
 	mpc86xx_smp_init();
 #endif
 
+	fsl_pci_assign_primary();
+
 	/* Remap basic board registers */
 	regs = of_find_compatible_node(NULL, NULL, "gef,ppc9a-fpga-regs");
 	if (regs) {
@@ -221,6 +216,7 @@ static long __init mpc86xx_time_init(void)
 static __initdata struct of_device_id of_bus_ids[] = {
 	{ .compatible = "simple-bus", },
 	{ .compatible = "gianfar", },
+	{ .compatible = "fsl,mpc8641-pcie", },
 	{},
 };
 
@@ -231,7 +227,7 @@ static int __init declare_of_platform_devices(void)
 
 	return 0;
 }
-machine_device_initcall(gef_ppc9a, declare_of_platform_devices);
+machine_arch_initcall(gef_ppc9a, declare_of_platform_devices);
 
 define_machine(gef_ppc9a) {
 	.name			= "GE PPC9A",
diff --git a/arch/powerpc/platforms/86xx/gef_sbc310.c b/arch/powerpc/platforms/86xx/gef_sbc310.c
index 14e0e576..67aaa81 100644
--- a/arch/powerpc/platforms/86xx/gef_sbc310.c
+++ b/arch/powerpc/platforms/86xx/gef_sbc310.c
@@ -73,20 +73,14 @@ static void __init gef_sbc310_init_irq(void)
 static void __init gef_sbc310_setup_arch(void)
 {
 	struct device_node *regs;
-#ifdef CONFIG_PCI
-	struct device_node *np;
-
-	for_each_compatible_node(np, "pci", "fsl,mpc8641-pcie") {
-		fsl_add_bridge(np, 1);
-	}
-#endif
-
 	printk(KERN_INFO "GE Intelligent Platforms SBC310 6U VPX SBC\n");
 
 #ifdef CONFIG_SMP
 	mpc86xx_smp_init();
 #endif
 
+	fsl_pci_assign_primary();
+
 	/* Remap basic board registers */
 	regs = of_find_compatible_node(NULL, NULL, "gef,fpga-regs");
 	if (regs) {
@@ -209,6 +203,7 @@ static long __init mpc86xx_time_init(void)
 static __initdata struct of_device_id of_bus_ids[] = {
 	{ .compatible = "simple-bus", },
 	{ .compatible = "gianfar", },
+	{ .compatible = "fsl,mpc8641-pcie", },
 	{},
 };
 
@@ -219,7 +214,7 @@ static int __init declare_of_platform_devices(void)
 
 	return 0;
 }
-machine_device_initcall(gef_sbc310, declare_of_platform_devices);
+machine_arch_initcall(gef_sbc310, declare_of_platform_devices);
 
 define_machine(gef_sbc310) {
 	.name			= "GE SBC310",
diff --git a/arch/powerpc/platforms/86xx/gef_sbc610.c b/arch/powerpc/platforms/86xx/gef_sbc610.c
index 1638f43..7666273 100644
--- a/arch/powerpc/platforms/86xx/gef_sbc610.c
+++ b/arch/powerpc/platforms/86xx/gef_sbc610.c
@@ -73,13 +73,6 @@ static void __init gef_sbc610_init_irq(void)
 static void __init gef_sbc610_setup_arch(void)
 {
 	struct device_node *regs;
-#ifdef CONFIG_PCI
-	struct device_node *np;
-
-	for_each_compatible_node(np, "pci", "fsl,mpc8641-pcie") {
-		fsl_add_bridge(np, 1);
-	}
-#endif
 
 	printk(KERN_INFO "GE Intelligent Platforms SBC610 6U VPX SBC\n");
 
@@ -87,6 +80,8 @@ static void __init gef_sbc610_setup_arch(void)
 	mpc86xx_smp_init();
 #endif
 
+	fsl_pci_assign_primary();
+
 	/* Remap basic board registers */
 	regs = of_find_compatible_node(NULL, NULL, "gef,fpga-regs");
 	if (regs) {
@@ -198,6 +193,7 @@ static long __init mpc86xx_time_init(void)
 static __initdata struct of_device_id of_bus_ids[] = {
 	{ .compatible = "simple-bus", },
 	{ .compatible = "gianfar", },
+	{ .compatible = "fsl,mpc8641-pcie", },
 	{},
 };
 
@@ -208,7 +204,7 @@ static int __init declare_of_platform_devices(void)
 
 	return 0;
 }
-machine_device_initcall(gef_sbc610, declare_of_platform_devices);
+machine_arch_initcall(gef_sbc610, declare_of_platform_devices);
 
 define_machine(gef_sbc610) {
 	.name			= "GE SBC610",
diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
index 62cd3c5..a817398 100644
--- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
+++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
@@ -91,6 +91,9 @@ static struct of_device_id __initdata mpc8610_ids[] = {
 	{ .compatible = "simple-bus", },
 	/* So that the DMA channel nodes can be probed individually: */
 	{ .compatible = "fsl,eloplus-dma", },
+	/* PCI controllers */
+	{ .compatible = "fsl,mpc8610-pci", },
+	{ .compatible = "fsl,mpc8641-pcie", },
 	{}
 };
 
@@ -107,7 +110,7 @@ static int __init mpc8610_declare_of_platform_devices(void)
 
 	return 0;
 }
-machine_device_initcall(mpc86xx_hpcd, mpc8610_declare_of_platform_devices);
+machine_arch_initcall(mpc86xx_hpcd, mpc8610_declare_of_platform_devices);
 
 #if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
 
@@ -278,25 +281,13 @@ mpc8610hpcd_valid_monitor_port(enum fsl_diu_monitor_port port)
 static void __init mpc86xx_hpcd_setup_arch(void)
 {
 	struct resource r;
-	struct device_node *np;
 	unsigned char *pixis;
 
 	if (ppc_md.progress)
 		ppc_md.progress("mpc86xx_hpcd_setup_arch()", 0);
 
-#ifdef CONFIG_PCI
-	for_each_node_by_type(np, "pci") {
-		if (of_device_is_compatible(np, "fsl,mpc8610-pci")
-		    || of_device_is_compatible(np, "fsl,mpc8641-pcie")) {
-			struct resource rsrc;
-			of_address_to_resource(np, 0, &rsrc);
-			if ((rsrc.start & 0xfffff) == 0xa000)
-				fsl_add_bridge(np, 1);
-			else
-				fsl_add_bridge(np, 0);
-		}
-        }
-#endif
+	fsl_pci_assign_primary();
+
 #if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
 	diu_ops.get_pixel_format	= mpc8610hpcd_get_pixel_format;
 	diu_ops.set_gamma_table		= mpc8610hpcd_set_gamma_table;
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index 817245b..e8bf3fa 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -19,7 +19,6 @@
 #include <linux/delay.h>
 #include <linux/seq_file.h>
 #include <linux/of_platform.h>
-#include <linux/memblock.h>
 
 #include <asm/time.h>
 #include <asm/machdep.h>
@@ -51,15 +50,8 @@ extern int uli_exclude_device(struct pci_controller *hose,
 static int mpc86xx_exclude_device(struct pci_controller *hose,
 				   u_char bus, u_char devfn)
 {
-	struct device_node* node;	
-	struct resource rsrc;
-
-	node = hose->dn;
-	of_address_to_resource(node, 0, &rsrc);
-
-	if ((rsrc.start & 0xfffff) == 0x8000) {
+	if (hose->dn == fsl_pci_primary)
 		return uli_exclude_device(hose, bus, devfn);
-	}
 
 	return PCIBIOS_SUCCESSFUL;
 }
@@ -69,30 +61,11 @@ static int mpc86xx_exclude_device(struct pci_controller *hose,
 static void __init
 mpc86xx_hpcn_setup_arch(void)
 {
-#ifdef CONFIG_PCI
-	struct device_node *np;
-	struct pci_controller *hose;
-#endif
-	dma_addr_t max = 0xffffffff;
-
 	if (ppc_md.progress)
 		ppc_md.progress("mpc86xx_hpcn_setup_arch()", 0);
 
 #ifdef CONFIG_PCI
-	for_each_compatible_node(np, "pci", "fsl,mpc8641-pcie") {
-		struct resource rsrc;
-		of_address_to_resource(np, 0, &rsrc);
-		if ((rsrc.start & 0xfffff) == 0x8000)
-			fsl_add_bridge(np, 1);
-		else
-			fsl_add_bridge(np, 0);
-		hose = pci_find_hose_for_OF_device(np);
-		max = min(max, hose->dma_window_base_cur +
-			  hose->dma_window_size);
-	}
-
 	ppc_md.pci_exclude_device = mpc86xx_exclude_device;
-
 #endif
 
 	printk("MPC86xx HPCN board from Freescale Semiconductor\n");
@@ -101,13 +74,9 @@ mpc86xx_hpcn_setup_arch(void)
 	mpc86xx_smp_init();
 #endif
 
-#ifdef CONFIG_SWIOTLB
-	if ((memblock_end_of_DRAM() - 1) > max) {
-		ppc_swiotlb_enable = 1;
-		set_pci_dma_ops(&swiotlb_dma_ops);
-		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
-	}
-#endif
+	fsl_pci_assign_primary();
+
+	swiotlb_detect_4g();
 }
 
 
@@ -162,6 +131,7 @@ static __initdata struct of_device_id of_bus_ids[] = {
 	{ .compatible = "simple-bus", },
 	{ .compatible = "fsl,srio", },
 	{ .compatible = "gianfar", },
+	{ .compatible = "fsl,mpc8641-pcie", },
 	{},
 };
 
@@ -171,7 +141,7 @@ static int __init declare_of_platform_devices(void)
 
 	return 0;
 }
-machine_device_initcall(mpc86xx_hpcn, declare_of_platform_devices);
+machine_arch_initcall(mpc86xx_hpcn, declare_of_platform_devices);
 machine_arch_initcall(mpc86xx_hpcn, swiotlb_setup_bus_notifier);
 
 define_machine(mpc86xx_hpcn) {
diff --git a/arch/powerpc/platforms/86xx/sbc8641d.c b/arch/powerpc/platforms/86xx/sbc8641d.c
index e7007d0..b47a8fd 100644
--- a/arch/powerpc/platforms/86xx/sbc8641d.c
+++ b/arch/powerpc/platforms/86xx/sbc8641d.c
@@ -38,23 +38,16 @@
 static void __init
 sbc8641_setup_arch(void)
 {
-#ifdef CONFIG_PCI
-	struct device_node *np;
-#endif
-
 	if (ppc_md.progress)
 		ppc_md.progress("sbc8641_setup_arch()", 0);
 
-#ifdef CONFIG_PCI
-	for_each_compatible_node(np, "pci", "fsl,mpc8641-pcie")
-		fsl_add_bridge(np, 0);
-#endif
-
 	printk("SBC8641 board from Wind River\n");
 
 #ifdef CONFIG_SMP
 	mpc86xx_smp_init();
 #endif
+
+	fsl_pci_assign_primary();
 }
 
 
@@ -102,6 +95,7 @@ mpc86xx_time_init(void)
 static __initdata struct of_device_id of_bus_ids[] = {
 	{ .compatible = "simple-bus", },
 	{ .compatible = "gianfar", },
+	{ .compatible = "fsl,mpc8641-pcie", },
 	{},
 };
 
@@ -111,7 +105,7 @@ static int __init declare_of_platform_devices(void)
 
 	return 0;
 }
-machine_device_initcall(sbc8641, declare_of_platform_devices);
+machine_arch_initcall(sbc8641, declare_of_platform_devices);
 
 define_machine(sbc8641) {
 	.name			= "SBC8641D",
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index da7a3d7..e2d33fa 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -826,12 +826,9 @@ static const struct of_device_id pci_ids[] = {
 
 struct device_node *fsl_pci_primary;
 
-void __devinit fsl_pci_init(void)
+void fsl_pci_assign_primary(void)
 {
-	int ret;
 	struct device_node *node;
-	struct pci_controller *hose;
-	dma_addr_t max = 0xffffffff;
 
 	/* Callers can specify the primary bus using other means. */
 	if (!fsl_pci_primary) {
@@ -842,38 +839,60 @@ void __devinit fsl_pci_init(void)
 			node = fsl_pci_primary;
 
 			if (of_match_node(pci_ids, node))
-				break;
+				return;
 		}
-	}
 
-	node = NULL;
-	for_each_node_by_type(node, "pci") {
-		if (of_match_node(pci_ids, node)) {
+		node = of_find_node_by_type(NULL, "pci");
+		if (of_match_node(pci_ids, node))
 			/*
 			 * If there's no PCI host bridge with ISA, arbitrarily
 			 * designate one as primary.  This can go away once
 			 * various bugs with primary-less systems are fixed.
 			 */
-			if (!fsl_pci_primary)
-				fsl_pci_primary = node;
-
-			ret = fsl_add_bridge(node, fsl_pci_primary == node);
-			if (ret == 0) {
-				hose = pci_find_hose_for_OF_device(node);
-				max = min(max, hose->dma_window_base_cur +
-						hose->dma_window_size);
-			}
-		}
+			fsl_pci_primary = node;
 	}
+}
+
+static int __devinit fsl_pci_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct device_node *node;
+	struct pci_controller *hose;
+
+	node = pdev->dev.of_node;
+	ret = fsl_add_bridge(node, fsl_pci_primary == node);
 
 #ifdef CONFIG_SWIOTLB
-	/*
-	 * if we couldn't map all of DRAM via the dma windows
-	 * we need SWIOTLB to handle buffers located outside of
-	 * dma capable memory region
-	 */
-	if (memblock_end_of_DRAM() - 1 > max)
-		ppc_swiotlb_enable = 1;
+	if (ret == 0) {
+		hose = pci_find_hose_for_OF_device(pdev->dev.of_node);
+
+		/*
+		 * if we couldn't map all of DRAM via the dma windows
+		 * we need SWIOTLB to handle buffers located outside of
+		 * dma capable memory region
+		 */
+		if (memblock_end_of_DRAM() - 1 > hose->dma_window_base_cur +
+				hose->dma_window_size)
+			ppc_swiotlb_enable = 1;
+	}
 #endif
+
+	mpc85xx_pci_err_probe(pdev);
+
+	return 0;
+}
+
+static struct platform_driver fsl_pci_driver = {
+	.driver = {
+		.name = "fsl-pci",
+		.of_match_table = pci_ids,
+	},
+	.probe = fsl_pci_probe,
+};
+
+static int __init fsl_pci_init(void)
+{
+	return platform_driver_register(&fsl_pci_driver);
 }
+arch_initcall(fsl_pci_init);
 #endif
diff --git a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h
index baa0fd1..d5aa1d9 100644
--- a/arch/powerpc/sysdev/fsl_pci.h
+++ b/arch/powerpc/sysdev/fsl_pci.h
@@ -95,10 +95,19 @@ u64 fsl_pci_immrbar_base(struct pci_controller *hose);
 
 extern struct device_node *fsl_pci_primary;
 
-#ifdef CONFIG_FSL_PCI
-void fsl_pci_init(void);
+#ifdef CONFIG_PCI
+void fsl_pci_assign_primary(void);
 #else
-static inline void fsl_pci_init(void) {}
+static inline void fsl_pci_assign_primary(void) {}
+#endif
+
+#ifdef CONFIG_EDAC_MPC85XX
+int mpc85xx_pci_err_probe(struct platform_device *op);
+#else
+static inline int mpc85xx_pci_err_probe(struct platform_device *op)
+{
+	return -ENOTSUPP;
+}
 #endif
 
 #endif /* __POWERPC_FSL_PCI_H */
diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index 0e37462..e4b6113 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -200,7 +200,7 @@ static irqreturn_t mpc85xx_pci_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __devinit mpc85xx_pci_err_probe(struct platform_device *op)
+int __devinit mpc85xx_pci_err_probe(struct platform_device *op)
 {
 	struct edac_pci_ctl_info *pci;
 	struct mpc85xx_pci_pdata *pdata;
@@ -214,6 +214,16 @@ static int __devinit mpc85xx_pci_err_probe(struct platform_device *op)
 	if (!pci)
 		return -ENOMEM;
 
+	/* make sure error reporting method is sane */
+	switch (edac_op_state) {
+	case EDAC_OPSTATE_POLL:
+	case EDAC_OPSTATE_INT:
+		break;
+	default:
+		edac_op_state = EDAC_OPSTATE_INT;
+		break;
+	}
+
 	pdata = pci->pvt_info;
 	pdata->name = "mpc85xx_pci_err";
 	pdata->irq = NO_IRQ;
@@ -303,6 +313,7 @@ err:
 	devres_release_group(&op->dev, mpc85xx_pci_err_probe);
 	return res;
 }
+EXPORT_SYMBOL(mpc85xx_pci_err_probe);
 
 static int mpc85xx_pci_err_remove(struct platform_device *op)
 {
@@ -326,27 +337,6 @@ static int mpc85xx_pci_err_remove(struct platform_device *op)
 	return 0;
 }
 
-static struct of_device_id mpc85xx_pci_err_of_match[] = {
-	{
-	 .compatible = "fsl,mpc8540-pcix",
-	 },
-	{
-	 .compatible = "fsl,mpc8540-pci",
-	},
-	{},
-};
-MODULE_DEVICE_TABLE(of, mpc85xx_pci_err_of_match);
-
-static struct platform_driver mpc85xx_pci_err_driver = {
-	.probe = mpc85xx_pci_err_probe,
-	.remove = __devexit_p(mpc85xx_pci_err_remove),
-	.driver = {
-		.name = "mpc85xx_pci_err",
-		.owner = THIS_MODULE,
-		.of_match_table = mpc85xx_pci_err_of_match,
-	},
-};
-
 #endif				/* CONFIG_PCI */
 
 /**************************** L2 Err device ***************************/
@@ -1193,12 +1183,6 @@ static int __init mpc85xx_mc_init(void)
 	if (res)
 		printk(KERN_WARNING EDAC_MOD_STR "L2 fails to register\n");
 
-#ifdef CONFIG_PCI
-	res = platform_driver_register(&mpc85xx_pci_err_driver);
-	if (res)
-		printk(KERN_WARNING EDAC_MOD_STR "PCI fails to register\n");
-#endif
-
 #ifdef CONFIG_FSL_SOC_BOOKE
 	pvr = mfspr(SPRN_PVR);
 
@@ -1235,9 +1219,6 @@ static void __exit mpc85xx_mc_exit(void)
 		on_each_cpu(mpc85xx_mc_restore_hid1, NULL, 0);
 	}
 #endif
-#ifdef CONFIG_PCI
-	platform_driver_unregister(&mpc85xx_pci_err_driver);
-#endif
 	platform_driver_unregister(&mpc85xx_l2_err_driver);
 	platform_driver_unregister(&mpc85xx_mc_err_driver);
 }
-- 
1.7.5.1
