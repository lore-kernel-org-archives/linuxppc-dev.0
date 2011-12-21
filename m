Return-Path: <B38951@freescale.com>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
 [65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 4BB5BB710C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2011 18:58:28 +1100 (EST)
Received: from mail86-tx2 (localhost [127.0.0.1])	by mail86-tx2-R.bigfish.com
 (Postfix) with ESMTP id 1439A600382	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,
 21 Dec 2011 07:58:32 +0000 (UTC)
Received: from TX2EHSMHS044.bigfish.com (unknown [10.9.14.243])	by
 mail86-tx2.bigfish.com (Postfix) with ESMTP id C21C92C004B	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2011 07:58:31 +0000 (UTC)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH SDK1.2 1/3] powerpc/fsl-pci: Unify pci/pcie initialization code
Date: Wed, 21 Dec 2011 15:10:56 +0800
Message-ID: <1324451458-4644-2-git-send-email-B38951@freescale.com>
In-Reply-To: <1324451458-4644-1-git-send-email-B38951@freescale.com>
References: <1324451458-4644-1-git-send-email-B38951@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: B11780@freescale.com, b38951@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We unified the Freescale pci/pcie initialization by changing the fsl_pci
to a platform driver.

In previous version pci/pcie initialization is in platform code which
Initialize pci bridge base on EP/RC or host/agent settings.

Signed-off-by: Jia Hongtao <B38951@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/platforms/85xx/p1022_ds.c |   39 +++++++----------------
 arch/powerpc/sysdev/fsl_pci.c          |   53 ++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index 2bf4342..41de2c1 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -277,32 +277,9 @@ void __init mpc85xx_smp_init(void);
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
@@ -316,11 +293,8 @@ static void __init p1022_ds_setup_arch(void)
 #endif
 
 #ifdef CONFIG_SWIOTLB
-	if (memblock_end_of_DRAM() > max) {
+	if (memblock_end_of_DRAM() > 0xffffffff)
 		ppc_swiotlb_enable = 1;
-		set_pci_dma_ops(&swiotlb_dma_ops);
-		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
-	}
 #endif
 
 	pr_info("Freescale P1022 DS reference board\n");
@@ -339,6 +313,17 @@ static int __init p1022_ds_publish_devices(void)
 }
 machine_device_initcall(p1022_ds, p1022_ds_publish_devices);
 
+static struct of_device_id __initdata p1022_pci_ids[] = {
+	{ .compatible = "fsl,p1022-pcie", },
+	{},
+};
+
+static int __init p1022_ds_publish_pci_device(void)
+{
+	return of_platform_bus_probe(NULL, p1022_pci_ids, NULL);
+}
+machine_arch_initcall(p1022_ds, p1022_ds_publish_pci_device);
+
 machine_arch_initcall(p1022_ds, swiotlb_setup_bus_notifier);
 
 /*
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 4ce547e..a0f305d 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -712,3 +712,56 @@ u64 fsl_pci_immrbar_base(struct pci_controller *hose)
 
 	return 0;
 }
+
+static const struct of_device_id pci_ids[] = {
+	{ .compatible = "fsl,mpc8540-pci", },
+	{ .compatible = "fsl,mpc8548-pcie", },
+	{ .compatible = "fsl,p1022-pcie", },
+	{},
+};
+
+static int __devinit fsl_pci_probe(struct platform_device *pdev)
+{
+	struct pci_controller *hose;
+
+	if (of_match_node(pci_ids, pdev->dev.of_node)) {
+		struct resource rsrc;
+		of_address_to_resource(pdev->dev.of_node, 0, &rsrc);
+		if ((rsrc.start & 0xfffff) == 8000)
+			fsl_add_bridge(pdev->dev.of_node, 1);
+		else
+			fsl_add_bridge(pdev->dev.of_node, 0);
+
+#ifdef CONFIG_SWIOTLB
+		hose = pci_find_hose_for_OF_device(pdev->dev.of_node);
+		/*
+		 * if we couldn't map all of DRAM via the dma windows
+		 * we need SWIOTLB to handle buffers located outside of
+		 * dma capable memory region
+		 */
+		if (memblock_end_of_DRAM() > hose->dma_window_base_cur
+				+ hose->dma_window_size) {
+			ppc_swiotlb_enable = 1;
+			set_pci_dma_ops(&swiotlb_dma_ops);
+			ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
+		}
+#endif
+
+	}
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
+}
+arch_initcall(fsl_pci_init);
-- 
1.7.5.1
