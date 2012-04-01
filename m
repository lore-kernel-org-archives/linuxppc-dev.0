Return-Path: <B38951@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe003.messaging.microsoft.com [213.199.154.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 68C99B701E
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Apr 2012 17:08:11 +1000 (EST)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2 2/4] powerpc/fsl-pci: Using common pci/pcie initialization
 for all boards
Date: Sun, 1 Apr 2012 14:55:29 +0800
Message-ID: <1333263331-23881-2-git-send-email-B38951@freescale.com>
In-Reply-To: <1333263331-23881-1-git-send-email-B38951@freescale.com>
References: <1333263331-23881-1-git-send-email-B38951@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: b38951@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Including all 85xx and 86xx platforms.

Signed-off-by: Jia Hongtao <B38951@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/platforms/85xx/common.c       |   18 ++++++++
 arch/powerpc/platforms/85xx/corenet_ds.c   |   27 +------------
 arch/powerpc/platforms/85xx/corenet_ds.h   |    1 +
 arch/powerpc/platforms/85xx/ge_imp3a.c     |   34 +--------------
 arch/powerpc/platforms/85xx/mpc8536_ds.c   |   40 ++++-------------
 arch/powerpc/platforms/85xx/mpc85xx.h      |    1 +
 arch/powerpc/platforms/85xx/mpc85xx_ads.c  |   17 ++++----
 arch/powerpc/platforms/85xx/mpc85xx_cds.c  |   24 ++++------
 arch/powerpc/platforms/85xx/mpc85xx_ds.c   |   33 ++------------
 arch/powerpc/platforms/85xx/mpc85xx_mds.c  |   62 +++++++++++++--------------
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c  |   13 ++----
 arch/powerpc/platforms/85xx/p1010rdb.c     |   13 +-----
 arch/powerpc/platforms/85xx/p1022_ds.c     |   29 +------------
 arch/powerpc/platforms/85xx/p1023_rds.c    |    6 +--
 arch/powerpc/platforms/85xx/p2041_rdb.c    |    1 +
 arch/powerpc/platforms/85xx/p3041_ds.c     |    1 +
 arch/powerpc/platforms/85xx/p3060_qds.c    |    1 +
 arch/powerpc/platforms/85xx/p4080_ds.c     |    1 +
 arch/powerpc/platforms/85xx/p5020_ds.c     |    1 +
 arch/powerpc/platforms/85xx/sbc8548.c      |   27 ++++--------
 arch/powerpc/platforms/85xx/sbc8560.c      |   19 ++++----
 arch/powerpc/platforms/85xx/socrates.c     |   16 +++----
 arch/powerpc/platforms/85xx/stx_gp3.c      |   19 ++++----
 arch/powerpc/platforms/85xx/tqm85xx.c      |   29 ++++---------
 arch/powerpc/platforms/85xx/xes_mpc85xx.c  |   25 ++---------
 arch/powerpc/platforms/86xx/gef_ppc9a.c    |   24 +++++++----
 arch/powerpc/platforms/86xx/gef_sbc310.c   |   24 +++++++----
 arch/powerpc/platforms/86xx/gef_sbc610.c   |   24 +++++++----
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c |   31 +++++++-------
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |   45 +++++++-------------
 arch/powerpc/platforms/86xx/sbc8641d.c     |   20 +++++----
 31 files changed, 237 insertions(+), 389 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/common.c b/arch/powerpc/platforms/85xx/common.c
index 9fef530..2c91272 100644
--- a/arch/powerpc/platforms/85xx/common.c
+++ b/arch/powerpc/platforms/85xx/common.c
@@ -28,6 +28,24 @@ int __init mpc85xx_common_publish_devices(void)
 {
 	return of_platform_bus_probe(NULL, mpc85xx_common_ids, NULL);
 }
+
+static struct of_device_id __initdata mpc85xx_pci_ids[] = {
+	{ .compatible = "fsl,mpc8540-pci", },
+	{ .compatible = "fsl,mpc8548-pcie", },
+	{ .compatible = "fsl,p1022-pcie", },
+	{ .compatible = "fsl,p1010-pcie", },
+	{ .compatible = "fsl,p1023-pcie", },
+	{ .compatible = "fsl,p4080-pcie", },
+	{ .compatible = "fsl,qoriq-pcie-v2.3", },
+	{ .compatible = "fsl,qoriq-pcie-v2.2", },
+	{},
+};
+
+int __init mpc85xx_pci_publish_devices(void)
+{
+	return of_platform_bus_probe(NULL, mpc85xx_pci_ids, NULL);
+}
+
 #ifdef CONFIG_CPM2
 static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
 {
diff --git a/arch/powerpc/platforms/85xx/corenet_ds.c b/arch/powerpc/platforms/85xx/corenet_ds.c
index df69e99..a21a075 100644
--- a/arch/powerpc/platforms/85xx/corenet_ds.c
+++ b/arch/powerpc/platforms/85xx/corenet_ds.c
@@ -53,36 +53,17 @@ void __init corenet_ds_pic_init(void)
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
 
 #ifdef CONFIG_PCI
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
 #ifdef CONFIG_PPC64
 	pci_devs_phb_init();
 #endif
 #endif
 
 #ifdef CONFIG_SWIOTLB
-	if (memblock_end_of_DRAM() > max) {
+	if (memblock_end_of_DRAM() > 0xffffffff)
 		ppc_swiotlb_enable = 1;
-		set_pci_dma_ops(&swiotlb_dma_ops);
-		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
-	}
 #endif
 	pr_info("%s board from Freescale Semiconductor\n", ppc_md.name);
 }
@@ -94,12 +75,6 @@ static const struct of_device_id of_device_ids[] __devinitconst = {
 	{
 		.compatible	= "fsl,srio",
 	},
-	{
-		.compatible	= "fsl,p4080-pcie",
-	},
-	{
-		.compatible	= "fsl,qoriq-pcie-v2.2",
-	},
 	/* The following two are for the Freescale hypervisor */
 	{
 		.name		= "hypervisor",
diff --git a/arch/powerpc/platforms/85xx/corenet_ds.h b/arch/powerpc/platforms/85xx/corenet_ds.h
index ddd700b..89700e6 100644
--- a/arch/powerpc/platforms/85xx/corenet_ds.h
+++ b/arch/powerpc/platforms/85xx/corenet_ds.h
@@ -15,5 +15,6 @@
 extern void __init corenet_ds_pic_init(void);
 extern void __init corenet_ds_setup_arch(void);
 extern int __init corenet_ds_publish_devices(void);
+extern int __init mpc85xx_pci_publish_devices(void);
 
 #endif
diff --git a/arch/powerpc/platforms/85xx/ge_imp3a.c b/arch/powerpc/platforms/85xx/ge_imp3a.c
index d50056f..43f7142 100644
--- a/arch/powerpc/platforms/85xx/ge_imp3a.c
+++ b/arch/powerpc/platforms/85xx/ge_imp3a.c
@@ -85,52 +85,21 @@ void __init ge_imp3a_pic_init(void)
 	of_node_put(cascade_node);
 }
 
-#ifdef CONFIG_PCI
-static int primary_phb_addr;
-#endif	/* CONFIG_PCI */
-
 /*
  * Setup the architecture
  */
 static void __init ge_imp3a_setup_arch(void)
 {
 	struct device_node *regs;
-#ifdef CONFIG_PCI
-	struct device_node *np;
-	struct pci_controller *hose;
-#endif
-	dma_addr_t max = 0xffffffff;
 
 	if (ppc_md.progress)
 		ppc_md.progress("ge_imp3a_setup_arch()", 0);
 
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
-#endif
-
 	mpc85xx_smp_init();
 
 #ifdef CONFIG_SWIOTLB
-	if (memblock_end_of_DRAM() > max) {
+	if (memblock_end_of_DRAM() > 0xffffffff)
 		ppc_swiotlb_enable = 1;
-		set_pci_dma_ops(&swiotlb_dma_ops);
-		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
-	}
 #endif
 
 	/* Remap basic board registers */
@@ -226,6 +195,7 @@ static int __init ge_imp3a_probe(void)
 	return 0;
 }
 
+machine_arch_initcall(p1022_ds, mpc85xx_pci_publish_devices);
 machine_device_initcall(ge_imp3a, mpc85xx_common_publish_devices);
 
 machine_arch_initcall(ge_imp3a, swiotlb_setup_bus_notifier);
diff --git a/arch/powerpc/platforms/85xx/mpc8536_ds.c b/arch/powerpc/platforms/85xx/mpc8536_ds.c
index f588726..e9fc274 100644
--- a/arch/powerpc/platforms/85xx/mpc8536_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc8536_ds.c
@@ -47,40 +47,12 @@ void __init mpc8536_ds_pic_init(void)
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
 #ifdef CONFIG_SWIOTLB
-	if (memblock_end_of_DRAM() > max) {
+	if (memblock_end_of_DRAM() > 0xffffffff)
 		ppc_swiotlb_enable = 1;
-		set_pci_dma_ops(&swiotlb_dma_ops);
-		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
-	}
 #endif
 
 	printk("MPC8536 DS board from Freescale Semiconductor\n");
@@ -88,6 +60,7 @@ static void __init mpc8536_ds_setup_arch(void)
 
 machine_device_initcall(mpc8536_ds, mpc85xx_common_publish_devices);
 
+machine_arch_initcall(mpc8536_ds, mpc85xx_pci_publish_devices);
 machine_arch_initcall(mpc8536_ds, swiotlb_setup_bus_notifier);
 
 /*
@@ -97,7 +70,14 @@ static int __init mpc8536_ds_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
 
-	return of_flat_dt_is_compatible(root, "fsl,mpc8536ds");
+	if (of_flat_dt_is_compatible(root, "fsl,mpc8536ds")) {
+#ifdef CONFIG_PCI
+		primary_phb_addr = 0x8000;
+#endif
+		return 1;
+	}
+
+	return 0;
 }
 
 define_machine(mpc8536_ds) {
diff --git a/arch/powerpc/platforms/85xx/mpc85xx.h b/arch/powerpc/platforms/85xx/mpc85xx.h
index 2aa7c5d..4ebdbb7 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx.h
+++ b/arch/powerpc/platforms/85xx/mpc85xx.h
@@ -1,6 +1,7 @@
 #ifndef MPC85xx_H
 #define MPC85xx_H
 extern int mpc85xx_common_publish_devices(void);
+extern int mpc85xx_pci_publish_devices(void);
 
 #ifdef CONFIG_CPM2
 extern void mpc85xx_cpm2_pic_init(void);
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index d19f675..f590df8 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -138,10 +138,6 @@ static void __init init_ioports(void)
 
 static void __init mpc85xx_ads_setup_arch(void)
 {
-#ifdef CONFIG_PCI
-	struct device_node *np;
-#endif
-
 	if (ppc_md.progress)
 		ppc_md.progress("mpc85xx_ads_setup_arch()", 0);
 
@@ -151,9 +147,6 @@ static void __init mpc85xx_ads_setup_arch(void)
 #endif
 
 #ifdef CONFIG_PCI
-	for_each_compatible_node(np, "pci", "fsl,mpc8540-pci")
-		fsl_add_bridge(np, 1);
-
 	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
 #endif
 }
@@ -174,6 +167,7 @@ static void mpc85xx_ads_show_cpuinfo(struct seq_file *m)
 	seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
 }
 
+machine_arch_initcall(mpc85xx_ads, mpc85xx_pci_publish_devices);
 machine_device_initcall(mpc85xx_ads, mpc85xx_common_publish_devices);
 
 /*
@@ -183,7 +177,14 @@ static int __init mpc85xx_ads_probe(void)
 {
         unsigned long root = of_get_flat_dt_root();
 
-        return of_flat_dt_is_compatible(root, "MPC85xxADS");
+	if (of_flat_dt_is_compatible(root, "MPC85xxADS")) {
+#ifdef CONFIG_PCI
+		primary_phb_addr = 0x8000;
+#endif
+		return 1;
+	}
+
+	return 0;
 }
 
 define_machine(mpc85xx_ads) {
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index ab5f0bf1..2bb6b9c 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -310,18 +310,6 @@ static void __init mpc85xx_cds_setup_arch(void)
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
@@ -351,12 +339,20 @@ static void mpc85xx_cds_show_cpuinfo(struct seq_file *m)
  */
 static int __init mpc85xx_cds_probe(void)
 {
-        unsigned long root = of_get_flat_dt_root();
+	unsigned long root = of_get_flat_dt_root();
 
-        return of_flat_dt_is_compatible(root, "MPC85xxCDS");
+	if (of_flat_dt_is_compatible(root, "MPC85xxCDS")) {
+#ifdef CONFIG_PCI
+		primary_phb_addr = 0x8000;
+#endif
+		return 1;
+	}
+
+	return 0;
 }
 
 machine_device_initcall(mpc85xx_cds, mpc85xx_common_publish_devices);
+machine_arch_initcall(mpc85xx_cds, mpc85xx_pci_publish_devices);
 
 define_machine(mpc85xx_cds) {
 	.name		= "MPC85xx CDS",
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 6e23e3e..e33a8cf 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -115,7 +115,6 @@ void __init mpc85xx_ds_pic_init(void)
 }
 
 #ifdef CONFIG_PCI
-static int primary_phb_addr;
 extern int uli_exclude_device(struct pci_controller *hose,
 				u_char bus, u_char devfn);
 
@@ -141,44 +140,18 @@ static int mpc85xx_exclude_device(struct pci_controller *hose,
  */
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
 
 #ifdef CONFIG_PCI
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
-
 	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
 #endif
 
 	mpc85xx_smp_init();
 
 #ifdef CONFIG_SWIOTLB
-	if (memblock_end_of_DRAM() > max) {
+	if (memblock_end_of_DRAM() > 0xffffffff)
 		ppc_swiotlb_enable = 1;
-		set_pci_dma_ops(&swiotlb_dma_ops);
-		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
-	}
 #endif
 
 	printk("MPC85xx DS board from Freescale Semiconductor\n");
@@ -205,6 +178,10 @@ machine_device_initcall(mpc8544_ds, mpc85xx_common_publish_devices);
 machine_device_initcall(mpc8572_ds, mpc85xx_common_publish_devices);
 machine_device_initcall(p2020_ds, mpc85xx_common_publish_devices);
 
+machine_arch_initcall(mpc8544_ds, mpc85xx_pci_publish_devices);
+machine_arch_initcall(mpc8572_ds, mpc85xx_pci_publish_devices);
+machine_arch_initcall(p2020_ds, mpc85xx_pci_publish_devices);
+
 machine_arch_initcall(mpc8544_ds, swiotlb_setup_bus_notifier);
 machine_arch_initcall(mpc8572_ds, swiotlb_setup_bus_notifier);
 machine_arch_initcall(p2020_ds, swiotlb_setup_bus_notifier);
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index e82f06f..6170d5f 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -328,43 +328,16 @@ static void __init mpc85xx_mds_qeic_init(void) { }
 
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
 
 #ifdef CONFIG_SWIOTLB
-	if (memblock_end_of_DRAM() > max) {
+	if (memblock_end_of_DRAM() > 0xffffffff)
 		ppc_swiotlb_enable = 1;
-		set_pci_dma_ops(&swiotlb_dma_ops);
-		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
-	}
 #endif
 }
 
@@ -423,6 +396,10 @@ machine_device_initcall(mpc8568_mds, mpc85xx_publish_devices);
 machine_device_initcall(mpc8569_mds, mpc85xx_publish_devices);
 machine_device_initcall(p1021_mds, mpc85xx_common_publish_devices);
 
+machine_arch_initcall(mpc8568_mds, mpc85xx_pci_publish_devices);
+machine_arch_initcall(mpc8569_mds, mpc85xx_pci_publish_devices);
+machine_arch_initcall(p1021_mds, mpc85xx_pci_publish_devices);
+
 machine_arch_initcall(mpc8568_mds, swiotlb_setup_bus_notifier);
 machine_arch_initcall(mpc8569_mds, swiotlb_setup_bus_notifier);
 machine_arch_initcall(p1021_mds, swiotlb_setup_bus_notifier);
@@ -440,9 +417,16 @@ static void __init mpc85xx_mds_pic_init(void)
 
 static int __init mpc85xx_mds_probe(void)
 {
-        unsigned long root = of_get_flat_dt_root();
+	unsigned long root = of_get_flat_dt_root();
 
-        return of_flat_dt_is_compatible(root, "MPC85xxMDS");
+	if (of_flat_dt_is_compatible(root, "MPC85xxMDS")) {
+#ifdef CONFIG_PCI
+		primary_phb_addr = 0x8000;
+#endif
+		return 1;
+	}
+
+	return 0;
 }
 
 define_machine(mpc8568_mds) {
@@ -463,7 +447,14 @@ static int __init mpc8569_mds_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
 
-	return of_flat_dt_is_compatible(root, "fsl,MPC8569EMDS");
+	if (of_flat_dt_is_compatible(root, "fsl,MPC8569EMDS")) {
+#ifdef CONFIG_PCI
+		primary_phb_addr = 0x8000;
+#endif
+		return 1;
+	}
+
+	return 0;
 }
 
 define_machine(mpc8569_mds) {
@@ -484,7 +475,14 @@ static int __init p1021_mds_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
 
-	return of_flat_dt_is_compatible(root, "fsl,P1021MDS");
+	if (of_flat_dt_is_compatible(root, "fsl,P1021MDS")) {
+#ifdef CONFIG_PCI
+		primary_phb_addr = 0x8000;
+#endif
+		return 1;
+	}
+
+	return 0;
 
 }
 
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index 1a66c3d..453a935 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -87,21 +87,13 @@ void __init mpc85xx_rdb_pic_init(void)
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
 
 #ifdef CONFIG_QUICC_ENGINE
@@ -171,6 +163,9 @@ machine_device_initcall(p1020_utm_pc, mpc85xx_common_publish_devices);
 machine_device_initcall(p1021_rdb_pc, mpc85xx_common_publish_devices);
 machine_device_initcall(p1025_rdb, mpc85xx_common_publish_devices);
 
+machine_arch_initcall(p2020_rdb, mpc85xx_pci_publish_devices);
+machine_arch_initcall(p1020_rdb, mpc85xx_pci_publish_devices);
+
 /*
  * Called very early, device-tree isn't unflattened
  */
diff --git a/arch/powerpc/platforms/85xx/p1010rdb.c b/arch/powerpc/platforms/85xx/p1010rdb.c
index d8bd656..ad9987c 100644
--- a/arch/powerpc/platforms/85xx/p1010rdb.c
+++ b/arch/powerpc/platforms/85xx/p1010rdb.c
@@ -47,25 +47,14 @@ void __init p1010_rdb_pic_init(void)
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
-
 	printk(KERN_INFO "P1010 RDB board from Freescale Semiconductor\n");
 }
 
 machine_device_initcall(p1010_rdb, mpc85xx_common_publish_devices);
+machine_arch_initcall(p1010_rdb, mpc85xx_pci_publish_devices);
 machine_arch_initcall(p1010_rdb, swiotlb_setup_bus_notifier);
 
 /*
diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index e74b7cd..a8c4118 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -385,32 +385,9 @@ early_param("video", early_video_setup);
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
@@ -450,11 +427,8 @@ static void __init p1022_ds_setup_arch(void)
 	mpc85xx_smp_init();
 
 #ifdef CONFIG_SWIOTLB
-	if (memblock_end_of_DRAM() > max) {
+	if (memblock_end_of_DRAM() > 0xffffffff)
 		ppc_swiotlb_enable = 1;
-		set_pci_dma_ops(&swiotlb_dma_ops);
-		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
-	}
 #endif
 
 	pr_info("Freescale P1022 DS reference board\n");
@@ -473,6 +447,7 @@ static int __init p1022_ds_publish_devices(void)
 }
 machine_device_initcall(p1022_ds, p1022_ds_publish_devices);
 
+machine_arch_initcall(p1022_ds, mpc85xx_pci_publish_devices);
 machine_arch_initcall(p1022_ds, swiotlb_setup_bus_notifier);
 
 /*
diff --git a/arch/powerpc/platforms/85xx/p1023_rds.c b/arch/powerpc/platforms/85xx/p1023_rds.c
index 6b07398..c62303c 100644
--- a/arch/powerpc/platforms/85xx/p1023_rds.c
+++ b/arch/powerpc/platforms/85xx/p1023_rds.c
@@ -81,15 +81,11 @@ static void __init mpc85xx_rds_setup_arch(void)
 		}
 	}
 
-#ifdef CONFIG_PCI
-	for_each_compatible_node(np, "pci", "fsl,p1023-pcie")
-		fsl_add_bridge(np, 0);
-#endif
-
 	mpc85xx_smp_init();
 }
 
 machine_device_initcall(p1023_rds, mpc85xx_common_publish_devices);
+machine_arch_initcall(p1023_rds, mpc85xx_pci_publish_devices);
 
 static void __init mpc85xx_rds_pic_init(void)
 {
diff --git a/arch/powerpc/platforms/85xx/p2041_rdb.c b/arch/powerpc/platforms/85xx/p2041_rdb.c
index eda6ed5..5123400 100644
--- a/arch/powerpc/platforms/85xx/p2041_rdb.c
+++ b/arch/powerpc/platforms/85xx/p2041_rdb.c
@@ -81,6 +81,7 @@ define_machine(p2041_rdb) {
 	.power_save		= e500_idle,
 };
 
+machine_arch_initcall(p2041_rdb, mpc85xx_pci_publish_devices);
 machine_device_initcall(p2041_rdb, corenet_ds_publish_devices);
 
 #ifdef CONFIG_SWIOTLB
diff --git a/arch/powerpc/platforms/85xx/p3041_ds.c b/arch/powerpc/platforms/85xx/p3041_ds.c
index 96d99a3..aa0dd29 100644
--- a/arch/powerpc/platforms/85xx/p3041_ds.c
+++ b/arch/powerpc/platforms/85xx/p3041_ds.c
@@ -83,6 +83,7 @@ define_machine(p3041_ds) {
 	.power_save		= e500_idle,
 };
 
+machine_arch_initcall(p3041_ds, mpc85xx_pci_publish_devices);
 machine_device_initcall(p3041_ds, corenet_ds_publish_devices);
 
 #ifdef CONFIG_SWIOTLB
diff --git a/arch/powerpc/platforms/85xx/p3060_qds.c b/arch/powerpc/platforms/85xx/p3060_qds.c
index 081cf4a..51aece5 100644
--- a/arch/powerpc/platforms/85xx/p3060_qds.c
+++ b/arch/powerpc/platforms/85xx/p3060_qds.c
@@ -70,6 +70,7 @@ define_machine(p3060_qds) {
 	.power_save		= e500_idle,
 };
 
+machine_arch_initcall(p3060_qds, mpc85xx_pci_publish_devices);
 machine_device_initcall(p3060_qds, corenet_ds_publish_devices);
 
 #ifdef CONFIG_SWIOTLB
diff --git a/arch/powerpc/platforms/85xx/p4080_ds.c b/arch/powerpc/platforms/85xx/p4080_ds.c
index d1b21d7..e6b52e8 100644
--- a/arch/powerpc/platforms/85xx/p4080_ds.c
+++ b/arch/powerpc/platforms/85xx/p4080_ds.c
@@ -82,6 +82,7 @@ define_machine(p4080_ds) {
 	.power_save		= e500_idle,
 };
 
+machine_arch_initcall(p4080_ds, mpc85xx_pci_publish_devices);
 machine_device_initcall(p4080_ds, corenet_ds_publish_devices);
 #ifdef CONFIG_SWIOTLB
 machine_arch_initcall(p4080_ds, swiotlb_setup_bus_notifier);
diff --git a/arch/powerpc/platforms/85xx/p5020_ds.c b/arch/powerpc/platforms/85xx/p5020_ds.c
index e8cba50..77953cc 100644
--- a/arch/powerpc/platforms/85xx/p5020_ds.c
+++ b/arch/powerpc/platforms/85xx/p5020_ds.c
@@ -92,6 +92,7 @@ define_machine(p5020_ds) {
 #endif
 };
 
+machine_arch_initcall(p5020_ds, mpc85xx_pci_publish_devices);
 machine_device_initcall(p5020_ds, corenet_ds_publish_devices);
 
 #ifdef CONFIG_SWIOTLB
diff --git a/arch/powerpc/platforms/85xx/sbc8548.c b/arch/powerpc/platforms/85xx/sbc8548.c
index 1677b8a..9049994 100644
--- a/arch/powerpc/platforms/85xx/sbc8548.c
+++ b/arch/powerpc/platforms/85xx/sbc8548.c
@@ -89,26 +89,9 @@ static int __init sbc8548_hw_rev(void)
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
 	sbc_rev = sbc8548_hw_rev();
 }
 
@@ -129,6 +112,7 @@ static void sbc8548_show_cpuinfo(struct seq_file *m)
 	seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
 }
 
+machine_arch_initcall(sbc8548, mpc85xx_pci_publish_devices);
 machine_device_initcall(sbc8548, mpc85xx_common_publish_devices);
 
 /*
@@ -138,7 +122,14 @@ static int __init sbc8548_probe(void)
 {
         unsigned long root = of_get_flat_dt_root();
 
-        return of_flat_dt_is_compatible(root, "SBC8548");
+	if (of_flat_dt_is_compatible(root, "SBC8548")) {
+#ifdef CONFIG_PCI
+		primary_phb_addr = 0x8000;
+#endif
+		return 1;
+	}
+
+	return 0;
 }
 
 define_machine(sbc8548) {
diff --git a/arch/powerpc/platforms/85xx/sbc8560.c b/arch/powerpc/platforms/85xx/sbc8560.c
index 3c3bbcc..c62692d 100644
--- a/arch/powerpc/platforms/85xx/sbc8560.c
+++ b/arch/powerpc/platforms/85xx/sbc8560.c
@@ -127,10 +127,6 @@ static void __init init_ioports(void)
 
 static void __init sbc8560_setup_arch(void)
 {
-#ifdef CONFIG_PCI
-	struct device_node *np;
-#endif
-
 	if (ppc_md.progress)
 		ppc_md.progress("sbc8560_setup_arch()", 0);
 
@@ -138,11 +134,6 @@ static void __init sbc8560_setup_arch(void)
 	cpm2_reset();
 	init_ioports();
 #endif
-
-#ifdef CONFIG_PCI
-	for_each_compatible_node(np, "pci", "fsl,mpc8540-pci")
-		fsl_add_bridge(np, 1);
-#endif
 }
 
 static void sbc8560_show_cpuinfo(struct seq_file *m)
@@ -161,6 +152,7 @@ static void sbc8560_show_cpuinfo(struct seq_file *m)
 	seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
 }
 
+machine_arch_initcall(sbc8560, mpc85xx_pci_publish_devices);
 machine_device_initcall(sbc8560, mpc85xx_common_publish_devices);
 
 /*
@@ -170,7 +162,14 @@ static int __init sbc8560_probe(void)
 {
         unsigned long root = of_get_flat_dt_root();
 
-        return of_flat_dt_is_compatible(root, "SBC8560");
+	if (of_flat_dt_is_compatible(root, "SBC8560")) {
+#ifdef CONFIG_PCI
+		primary_phb_addr = 0x8000;
+#endif
+		return 1;
+	}
+
+	return 0;
 }
 
 #ifdef CONFIG_RTC_DRV_M48T59
diff --git a/arch/powerpc/platforms/85xx/socrates.c b/arch/powerpc/platforms/85xx/socrates.c
index b719192..eb94e586 100644
--- a/arch/powerpc/platforms/85xx/socrates.c
+++ b/arch/powerpc/platforms/85xx/socrates.c
@@ -67,19 +67,11 @@ static void __init socrates_pic_init(void)
  */
 static void __init socrates_setup_arch(void)
 {
-#ifdef CONFIG_PCI
-	struct device_node *np;
-#endif
-
 	if (ppc_md.progress)
 		ppc_md.progress("socrates_setup_arch()", 0);
-
-#ifdef CONFIG_PCI
-	for_each_compatible_node(np, "pci", "fsl,mpc8540-pci")
-		fsl_add_bridge(np, 1);
-#endif
 }
 
+machine_arch_initcall(socrates, mpc85xx_pci_publish_devices);
 machine_device_initcall(socrates, mpc85xx_common_publish_devices);
 
 /*
@@ -89,8 +81,12 @@ static int __init socrates_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
 
-	if (of_flat_dt_is_compatible(root, "abb,socrates"))
+	if (of_flat_dt_is_compatible(root, "abb,socrates")) {
+#ifdef CONFIG_PCI
+		primary_phb_addr = 0x8000;
+#endif
 		return 1;
+	}
 
 	return 0;
 }
diff --git a/arch/powerpc/platforms/85xx/stx_gp3.c b/arch/powerpc/platforms/85xx/stx_gp3.c
index 27ca3a7..92d2c3b 100644
--- a/arch/powerpc/platforms/85xx/stx_gp3.c
+++ b/arch/powerpc/platforms/85xx/stx_gp3.c
@@ -61,21 +61,12 @@ static void __init stx_gp3_pic_init(void)
  */
 static void __init stx_gp3_setup_arch(void)
 {
-#ifdef CONFIG_PCI
-	struct device_node *np;
-#endif
-
 	if (ppc_md.progress)
 		ppc_md.progress("stx_gp3_setup_arch()", 0);
 
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
@@ -94,6 +85,7 @@ static void stx_gp3_show_cpuinfo(struct seq_file *m)
 	seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
 }
 
+machine_arch_initcall(stx_gp3, mpc85xx_pci_publish_devices);
 machine_device_initcall(stx_gp3, mpc85xx_common_publish_devices);
 
 /*
@@ -103,7 +95,14 @@ static int __init stx_gp3_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
 
-	return of_flat_dt_is_compatible(root, "stx,gp3-8560");
+	if (of_flat_dt_is_compatible(root, "stx,gp3-8560")) {
+#ifdef CONFIG_PCI
+		primary_phb_addr = 0x8000;
+#endif
+		return 1;
+	}
+
+	return 0;
 }
 
 define_machine(stx_gp3) {
diff --git a/arch/powerpc/platforms/85xx/tqm85xx.c b/arch/powerpc/platforms/85xx/tqm85xx.c
index d7504ce..c8e2599 100644
--- a/arch/powerpc/platforms/85xx/tqm85xx.c
+++ b/arch/powerpc/platforms/85xx/tqm85xx.c
@@ -60,31 +60,12 @@ static void __init tqm85xx_pic_init(void)
  */
 static void __init tqm85xx_setup_arch(void)
 {
-#ifdef CONFIG_PCI
-	struct device_node *np;
-#endif
-
 	if (ppc_md.progress)
 		ppc_md.progress("tqm85xx_setup_arch()", 0);
 
 #ifdef CONFIG_CPM2
 	cpm2_reset();
 #endif
-
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
 }
 
 static void tqm85xx_show_cpuinfo(struct seq_file *m)
@@ -124,6 +105,7 @@ static void __init tqm85xx_ti1520_fixup(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_1520,
 		tqm85xx_ti1520_fixup);
 
+machine_arch_initcall(tqm85xx, mpc85xx_pci_publish_devices);
 machine_device_initcall(tqm85xx, mpc85xx_common_publish_devices);
 
 static const char *board[] __initdata = {
@@ -140,7 +122,14 @@ static const char *board[] __initdata = {
  */
 static int __init tqm85xx_probe(void)
 {
-	return of_flat_dt_match(of_get_flat_dt_root(), board);
+	if (of_flat_dt_match(of_get_flat_dt_root(), board)) {
+#ifdef CONFIG_PCI
+		primary_phb_addr = 0x8000;
+#endif
+		return 1;
+	}
+
+	return 0;
 }
 
 define_machine(tqm85xx) {
diff --git a/arch/powerpc/platforms/85xx/xes_mpc85xx.c b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
index 503c215..f5ef6b5 100644
--- a/arch/powerpc/platforms/85xx/xes_mpc85xx.c
+++ b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
@@ -112,18 +112,11 @@ static void xes_mpc85xx_fixups(void)
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
 
@@ -138,20 +131,6 @@ static void __init xes_mpc85xx_setup_arch(void)
 
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
 }
 
@@ -159,6 +138,10 @@ machine_device_initcall(xes_mpc8572, mpc85xx_common_publish_devices);
 machine_device_initcall(xes_mpc8548, mpc85xx_common_publish_devices);
 machine_device_initcall(xes_mpc8540, mpc85xx_common_publish_devices);
 
+machine_arch_initcall(xes_mpc8572, mpc85xx_pci_publish_devices);
+machine_arch_initcall(xes_mpc8548, mpc85xx_pci_publish_devices);
+machine_arch_initcall(xes_mpc8540, mpc85xx_pci_publish_devices);
+
 /*
  * Called very early, device-tree isn't unflattened
  */
diff --git a/arch/powerpc/platforms/86xx/gef_ppc9a.c b/arch/powerpc/platforms/86xx/gef_ppc9a.c
index ed58b6c..d27ab58 100644
--- a/arch/powerpc/platforms/86xx/gef_ppc9a.c
+++ b/arch/powerpc/platforms/86xx/gef_ppc9a.c
@@ -74,13 +74,6 @@ static void __init gef_ppc9a_init_irq(void)
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
 
@@ -197,8 +190,12 @@ static int __init gef_ppc9a_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
 
-	if (of_flat_dt_is_compatible(root, "gef,ppc9a"))
+	if (of_flat_dt_is_compatible(root, "gef,ppc9a")) {
+#ifdef CONFIG_PCI
+		primary_phb_addr = 0x8000;
+#endif
 		return 1;
+	}
 
 	return 0;
 }
@@ -219,6 +216,17 @@ static long __init mpc86xx_time_init(void)
 	return 0;
 }
 
+static struct of_device_id __initdata gef_ppc9a_pci_ids[] = {
+	{ .compatible = "fsl,mpc8641-pcie", },
+	{},
+};
+
+static int __init gef_ppc9a_publish_pci_device(void)
+{
+	return of_platform_bus_probe(NULL, gef_ppc9a_pci_ids, NULL);
+}
+machine_arch_initcall(gef_ppc9a, gef_ppc9a_publish_pci_device);
+
 static __initdata struct of_device_id of_bus_ids[] = {
 	{ .compatible = "simple-bus", },
 	{ .compatible = "gianfar", },
diff --git a/arch/powerpc/platforms/86xx/gef_sbc310.c b/arch/powerpc/platforms/86xx/gef_sbc310.c
index 710db69..1659013 100644
--- a/arch/powerpc/platforms/86xx/gef_sbc310.c
+++ b/arch/powerpc/platforms/86xx/gef_sbc310.c
@@ -74,13 +74,6 @@ static void __init gef_sbc310_init_irq(void)
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
 
 	printk(KERN_INFO "GE Intelligent Platforms SBC310 6U VPX SBC\n");
 
@@ -185,8 +178,12 @@ static int __init gef_sbc310_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
 
-	if (of_flat_dt_is_compatible(root, "gef,sbc310"))
+	if (of_flat_dt_is_compatible(root, "gef,sbc310")) {
+#ifdef CONFIG_PCI
+		primary_phb_addr = 0x8000;
+#endif
 		return 1;
+	}
 
 	return 0;
 }
@@ -207,6 +204,17 @@ static long __init mpc86xx_time_init(void)
 	return 0;
 }
 
+static struct of_device_id __initdata gef_sbc310_pci_ids[] = {
+	{ .compatible = "fsl,mpc8641-pcie", },
+	{},
+};
+
+static int __init gef_sbc310_publish_pci_device(void)
+{
+	return of_platform_bus_probe(NULL, gef_sbc310_pci_ids, NULL);
+}
+machine_arch_initcall(gef_sbc310, gef_sbc310_publish_pci_device);
+
 static __initdata struct of_device_id of_bus_ids[] = {
 	{ .compatible = "simple-bus", },
 	{ .compatible = "gianfar", },
diff --git a/arch/powerpc/platforms/86xx/gef_sbc610.c b/arch/powerpc/platforms/86xx/gef_sbc610.c
index 4a13d2f..a7bba61 100644
--- a/arch/powerpc/platforms/86xx/gef_sbc610.c
+++ b/arch/powerpc/platforms/86xx/gef_sbc610.c
@@ -74,13 +74,6 @@ static void __init gef_sbc610_init_irq(void)
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
 
@@ -174,8 +167,12 @@ static int __init gef_sbc610_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
 
-	if (of_flat_dt_is_compatible(root, "gef,sbc610"))
+	if (of_flat_dt_is_compatible(root, "gef,sbc610")) {
+#ifdef CONFIG_PCI
+		primary_phb_addr = 0x8000;
+#endif
 		return 1;
+	}
 
 	return 0;
 }
@@ -196,6 +193,17 @@ static long __init mpc86xx_time_init(void)
 	return 0;
 }
 
+static struct of_device_id __initdata gef_sbc610_pci_ids[] = {
+	{ .compatible = "fsl,mpc8641-pcie", },
+	{},
+};
+
+static int __init gef_sbc610_publish_pci_device(void)
+{
+	return of_platform_bus_probe(NULL, gef_sbc610_pci_ids, NULL);
+}
+machine_arch_initcall(gef_sbc610, gef_sbc610_publish_pci_device);
+
 static __initdata struct of_device_id of_bus_ids[] = {
 	{ .compatible = "simple-bus", },
 	{ .compatible = "gianfar", },
diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
index b8b1f33..4946ed5 100644
--- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
+++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
@@ -86,6 +86,17 @@ static void __init mpc8610_suspend_init(void)
 static inline void mpc8610_suspend_init(void) { }
 #endif /* CONFIG_SUSPEND */
 
+static struct of_device_id __initdata mpc86xx_hpcd_pci_ids[] = {
+	{ .compatible = "fsl,mpc8641-pcie", },
+	{},
+};
+
+static int __init mpc86xx_hpcd_publish_pci_device(void)
+{
+	return of_platform_bus_probe(NULL, mpc86xx_hpcd_pci_ids, NULL);
+}
+machine_arch_initcall(mpc86xx_hpcd, mpc86xx_hpcd_publish_pci_device);
+
 static struct of_device_id __initdata mpc8610_ids[] = {
 	{ .compatible = "fsl,mpc8610-immr", },
 	{ .compatible = "fsl,mpc8610-guts", },
@@ -279,25 +290,11 @@ mpc8610hpcd_valid_monitor_port(enum fsl_diu_monitor_port port)
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
 #if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
 	diu_ops.get_pixel_format	= mpc8610hpcd_get_pixel_format;
 	diu_ops.set_gamma_table		= mpc8610hpcd_set_gamma_table;
@@ -331,8 +328,12 @@ static int __init mpc86xx_hpcd_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
 
-	if (of_flat_dt_is_compatible(root, "fsl,MPC8610HPCD"))
+	if (of_flat_dt_is_compatible(root, "fsl,MPC8610HPCD")) {
+#ifdef CONFIG_PCI
+		primary_phb_addr = 0xa000;
+#endif
 		return 1;	/* Looks good */
+	}
 
 	return 0;
 }
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index 569262c..165dd40 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -70,30 +70,11 @@ static int mpc86xx_exclude_device(struct pci_controller *hose,
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
@@ -103,11 +84,8 @@ mpc86xx_hpcn_setup_arch(void)
 #endif
 
 #ifdef CONFIG_SWIOTLB
-	if (memblock_end_of_DRAM() > max) {
+	if (memblock_end_of_DRAM() > 0xffffffff)
 		ppc_swiotlb_enable = 1;
-		set_pci_dma_ops(&swiotlb_dma_ops);
-		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
-	}
 #endif
 }
 
@@ -130,12 +108,10 @@ static int __init mpc86xx_hpcn_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
 
-	if (of_flat_dt_is_compatible(root, "fsl,mpc8641hpcn"))
-		return 1;	/* Looks good */
-
-	/* Be nice and don't give silent boot death.  Delete this in 2.6.27 */
-	if (of_flat_dt_is_compatible(root, "mpc86xx")) {
-		pr_warning("WARNING: your dts/dtb is old. You must update before the next kernel release\n");
+	if (of_flat_dt_is_compatible(root, "fsl,mpc8641hpcn")) {
+#ifdef CONFIG_PCI
+		primary_phb_addr = 0x8000;
+#endif
 		return 1;
 	}
 
@@ -159,6 +135,17 @@ mpc86xx_time_init(void)
 	return 0;
 }
 
+static struct of_device_id __initdata mpc86xx_hpcn_pci_ids[] = {
+	{ .compatible = "fsl,mpc8641-pcie", },
+	{},
+};
+
+static int __init mpc86xx_hpcn_publish_pci_device(void)
+{
+	return of_platform_bus_probe(NULL, mpc86xx_hpcn_pci_ids, NULL);
+}
+machine_arch_initcall(mpc86xx_hpcn, mpc86xx_hpcn_publish_pci_device);
+
 static __initdata struct of_device_id of_bus_ids[] = {
 	{ .compatible = "simple-bus", },
 	{ .compatible = "fsl,srio", },
diff --git a/arch/powerpc/platforms/86xx/sbc8641d.c b/arch/powerpc/platforms/86xx/sbc8641d.c
index 51c8f33..1226949 100644
--- a/arch/powerpc/platforms/86xx/sbc8641d.c
+++ b/arch/powerpc/platforms/86xx/sbc8641d.c
@@ -39,18 +39,9 @@
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
@@ -100,6 +91,17 @@ mpc86xx_time_init(void)
 	return 0;
 }
 
+static struct of_device_id __initdata sbc8641_pci_ids[] = {
+	{ .compatible = "fsl,mpc8641-pcie", },
+	{},
+};
+
+static int __init sbc8641_publish_pci_device(void)
+{
+	return of_platform_bus_probe(NULL, sbc8641_pci_ids, NULL);
+}
+machine_arch_initcall(sbc8641, sbc8641_publish_pci_device);
+
 static __initdata struct of_device_id of_bus_ids[] = {
 	{ .compatible = "simple-bus", },
 	{ .compatible = "gianfar", },
-- 
1.7.5.1
