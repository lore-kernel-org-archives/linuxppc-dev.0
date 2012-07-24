Return-Path: <B38951@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3D7E42C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2012 20:43:33 +1000 (EST)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>,
 <B07421@freescale.com>
Subject: [PATCH 4/6] powerpc/mpc85xx_ds: convert to unified PCI init
Date: Tue, 24 Jul 2012 18:20:08 +0800
Message-ID: <1343125210-16720-4-git-send-email-B38951@freescale.com>
In-Reply-To: <1343125210-16720-1-git-send-email-B38951@freescale.com>
References: <1343125210-16720-1-git-send-email-B38951@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: b38951@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PCI initialization is now done by PCI controller driver. In board setup_arch
stage we don't need PCI init any more but swiotlb should be determined at this
stage.

Signed-off-by: Jia Hongtao <B38951@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/platforms/85xx/common.c     |    9 ++++
 arch/powerpc/platforms/85xx/mpc85xx_ds.c |   75 +++--------------------------
 2 files changed, 17 insertions(+), 67 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/common.c b/arch/powerpc/platforms/85xx/common.c
index 67dac22..303fedb 100644
--- a/arch/powerpc/platforms/85xx/common.c
+++ b/arch/powerpc/platforms/85xx/common.c
@@ -27,6 +27,15 @@ static struct of_device_id __initdata mpc85xx_common_ids[] = {
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
+	{ .compatible = "fsl,qoriq-pcie-v2.3", },
+	{ .compatible = "fsl,qoriq-pcie-v2.2", },
 	{},
 };
 
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index d30f6c4..b7ef007 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -114,22 +114,14 @@ void __init mpc85xx_ds_pic_init(void)
 }
 
 #ifdef CONFIG_PCI
-static int primary_phb_addr;
 extern int uli_exclude_device(struct pci_controller *hose,
 				u_char bus, u_char devfn);
 
 static int mpc85xx_exclude_device(struct pci_controller *hose,
 				   u_char bus, u_char devfn)
 {
-	struct device_node* node;
-	struct resource rsrc;
-
-	node = hose->dn;
-	of_address_to_resource(node, 0, &rsrc);
-
-	if ((rsrc.start & 0xfffff) == primary_phb_addr) {
+	if (hose->is_primary)
 		return uli_exclude_device(hose, bus, devfn);
-	}
 
 	return PCIBIOS_SUCCESSFUL;
 }
@@ -140,46 +132,16 @@ static int mpc85xx_exclude_device(struct pci_controller *hose,
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
+	pci_check_swiotlb();
 	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
 #endif
 
 	mpc85xx_smp_init();
 
-#ifdef CONFIG_SWIOTLB
-	if ((memblock_end_of_DRAM() - 1) > max) {
-		ppc_swiotlb_enable = 1;
-		set_pci_dma_ops(&swiotlb_dma_ops);
-		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
-	}
-#endif
-
 	printk("MPC85xx DS board from Freescale Semiconductor\n");
 }
 
@@ -190,19 +152,12 @@ static int __init mpc8544_ds_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
 
-	if (of_flat_dt_is_compatible(root, "MPC8544DS")) {
-#ifdef CONFIG_PCI
-		primary_phb_addr = 0xb000;
-#endif
-		return 1;
-	}
-
-	return 0;
+	return of_flat_dt_is_compatible(root, "MPC8544DS");
 }
 
-machine_device_initcall(mpc8544_ds, mpc85xx_common_publish_devices);
-machine_device_initcall(mpc8572_ds, mpc85xx_common_publish_devices);
-machine_device_initcall(p2020_ds, mpc85xx_common_publish_devices);
+machine_arch_initcall(mpc8544_ds, mpc85xx_common_publish_devices);
+machine_arch_initcall(mpc8572_ds, mpc85xx_common_publish_devices);
+machine_arch_initcall(p2020_ds, mpc85xx_common_publish_devices);
 
 machine_arch_initcall(mpc8544_ds, swiotlb_setup_bus_notifier);
 machine_arch_initcall(mpc8572_ds, swiotlb_setup_bus_notifier);
@@ -215,14 +170,7 @@ static int __init mpc8572_ds_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
 
-	if (of_flat_dt_is_compatible(root, "fsl,MPC8572DS")) {
-#ifdef CONFIG_PCI
-		primary_phb_addr = 0x8000;
-#endif
-		return 1;
-	}
-
-	return 0;
+	return of_flat_dt_is_compatible(root, "fsl,MPC8572DS");
 }
 
 /*
@@ -232,14 +180,7 @@ static int __init p2020_ds_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
 
-	if (of_flat_dt_is_compatible(root, "fsl,P2020DS")) {
-#ifdef CONFIG_PCI
-		primary_phb_addr = 0x9000;
-#endif
-		return 1;
-	}
-
-	return 0;
+	return of_flat_dt_is_compatible(root, "fsl,P2020DS");
 }
 
 define_machine(mpc8544_ds) {
-- 
1.7.5.1
