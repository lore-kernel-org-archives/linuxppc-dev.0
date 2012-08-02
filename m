Return-Path: <B38951@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E3BFF2C0268
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2012 22:07:48 +1000 (EST)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>
Subject: [PATCH V4 3/3] powerpc/fsl-pci: Unify pci/pcie initialization code
Date: Thu, 2 Aug 2012 19:42:21 +0800
Message-ID: <1343907741-20589-4-git-send-email-B38951@freescale.com>
In-Reply-To: <1343907741-20589-1-git-send-email-B38951@freescale.com>
References: <1343907741-20589-1-git-send-email-B38951@freescale.com>
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
 arch/powerpc/platforms/85xx/mpc85xx_ds.c |   32 ++--------
 arch/powerpc/sysdev/fsl_pci.c            |  102 ++++++++++++++++++-----------
 arch/powerpc/sysdev/fsl_pci.h            |    6 +-
 drivers/edac/mpc85xx_edac.c              |   43 ++++---------
 4 files changed, 83 insertions(+), 100 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 56f8c8f..f2c7b1c 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -20,7 +20,6 @@
 #include <linux/seq_file.h>
 #include <linux/interrupt.h>
 #include <linux/of_platform.h>
-#include <linux/memblock.h>
 
 #include <asm/time.h>
 #include <asm/machdep.h>
@@ -117,40 +116,16 @@ void __init mpc85xx_ds_pic_init(void)
 extern int uli_exclude_device(struct pci_controller *hose,
 				u_char bus, u_char devfn);
 
-static struct device_node *pci_with_uli;
-
 static int mpc85xx_exclude_device(struct pci_controller *hose,
 				   u_char bus, u_char devfn)
 {
-	if (hose->dn == pci_with_uli)
+	if (hose->dn == fsl_pci_primary)
 		return uli_exclude_device(hose, bus, devfn);
 
 	return PCIBIOS_SUCCESSFUL;
 }
 #endif	/* CONFIG_PCI */
 
-static void __init mpc85xx_ds_pci_init(void)
-{
-#ifdef CONFIG_PCI
-	struct device_node *node;
-
-	fsl_pci_init();
-
-	/* See if we have a ULI under the primary */
-
-	node = of_find_node_by_name(NULL, "uli1575");
-	while ((pci_with_uli = of_get_parent(node))) {
-		of_node_put(node);
-		node = pci_with_uli;
-
-		if (pci_with_uli == fsl_pci_primary) {
-			ppc_md.pci_exclude_device = mpc85xx_exclude_device;
-			break;
-		}
-	}
-#endif
-}
-
 /*
  * Setup the architecture
  */
@@ -159,8 +134,11 @@ static void __init mpc85xx_ds_setup_arch(void)
 	if (ppc_md.progress)
 		ppc_md.progress("mpc85xx_ds_setup_arch()", 0);
 
+#ifdef CONFIG_PCI
+	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
+#endif
+
 	swiotlb_detect_4g();
-	mpc85xx_ds_pci_init();
 	mpc85xx_smp_init();
 
 	printk("MPC85xx DS board from Freescale Semiconductor\n");
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index da7a3d7..6408d9d 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -826,54 +826,78 @@ static const struct of_device_id pci_ids[] = {
 
 struct device_node *fsl_pci_primary;
 
-void __devinit fsl_pci_init(void)
+/* Checkout if PCI contains ISA node */
+static int of_pci_has_isa(struct device_node *pci_node)
+{
+	struct device_node *np;
+	int ret = 0;
+
+	if (!pci_node)
+		return 0;
+
+	read_lock(&devtree_lock);
+	np = pci_node->allnext;
+
+	/* Only scan the children of PCI node */
+	for (; np != pci_node->sibling; np = np->allnext) {
+		if (np->type && (of_node_cmp(np->type, "isa") == 0)
+		    && of_node_get(np)) {
+			ret = 1;
+			break;
+		}
+	}
+
+	of_node_put(pci_node);
+	read_unlock(&devtree_lock);
+
+	return ret;
+}
+
+static int __devinit fsl_pci_probe(struct platform_device *pdev)
 {
 	int ret;
-	struct device_node *node;
 	struct pci_controller *hose;
-	dma_addr_t max = 0xffffffff;
+	int is_primary = 0;
 
-	/* Callers can specify the primary bus using other means. */
 	if (!fsl_pci_primary) {
-		/* If a PCI host bridge contains an ISA node, it's primary. */
-		node = of_find_node_by_type(NULL, "isa");
-		while ((fsl_pci_primary = of_get_parent(node))) {
-			of_node_put(node);
-			node = fsl_pci_primary;
-
-			if (of_match_node(pci_ids, node))
-				break;
-		}
+		is_primary = of_pci_has_isa(pdev->dev.of_node);
+		if (is_primary)
+			fsl_pci_primary = pdev->dev.of_node;
 	}
 
-	node = NULL;
-	for_each_node_by_type(node, "pci") {
-		if (of_match_node(pci_ids, node)) {
-			/*
-			 * If there's no PCI host bridge with ISA, arbitrarily
-			 * designate one as primary.  This can go away once
-			 * various bugs with primary-less systems are fixed.
-			 */
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
-	}
+	ret = fsl_add_bridge(pdev->dev.of_node, is_primary);
 
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
index baa0fd1..e3fcc6c 100644
--- a/arch/powerpc/sysdev/fsl_pci.h
+++ b/arch/powerpc/sysdev/fsl_pci.h
@@ -95,10 +95,10 @@ u64 fsl_pci_immrbar_base(struct pci_controller *hose);
 
 extern struct device_node *fsl_pci_primary;
 
-#ifdef CONFIG_FSL_PCI
-void fsl_pci_init(void);
+#ifdef CONFIG_EDAC_MPC85XX
+int mpc85xx_pci_err_probe(struct platform_device *op);
 #else
-static inline void fsl_pci_init(void) {}
+static inline int mpc85xx_pci_err_probe(struct platform_device *op) {}
 #endif
 
 #endif /* __POWERPC_FSL_PCI_H */
diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index 0e37462..2677883 100644
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
+EXPORT_SYMBOL_GPL(mpc85xx_pci_err_probe);
 
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
