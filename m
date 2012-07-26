Return-Path: <B38951@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe005.messaging.microsoft.com [213.199.154.143])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9385C2C00C6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2012 22:54:20 +1000 (EST)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>,
 <B07421@freescale.com>
Subject: [PATCH V3 5/5] Edac/85xx: Register mpc85xx_pci_err_driver by
 fsl_pci_driver
Date: Thu, 26 Jul 2012 20:30:27 +0800
Message-ID: <1343305827-26734-5-git-send-email-B38951@freescale.com>
In-Reply-To: <1343305827-26734-1-git-send-email-B38951@freescale.com>
References: <1343305827-26734-1-git-send-email-B38951@freescale.com>
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

From: Chunhe Lan <Chunhe.Lan@freescale.com>

Now we registered pci controllers as platform devices. It will make edac
driver failed to register pci nodes as platform devices too. So we combine
two initialization code as one platform driver.

Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Jia Hongtao <B38951@freescale.com>
---
 arch/powerpc/sysdev/fsl_pci.c |    4 +++
 arch/powerpc/sysdev/fsl_pci.h |    4 +++
 drivers/edac/mpc85xx_edac.c   |   43 +++++++++++-----------------------------
 3 files changed, 20 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 90e7ab9..6311d09 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -963,6 +963,10 @@ static int __devinit fsl_pci_probe(struct platform_device *pdev)
 	if (of_match_node(pci_ids, pdev->dev.of_node))
 		fsl_add_bridge(pdev->dev.of_node, is_primary);
 
+#ifdef CONFIG_EDAC_MPC85XX
+	mpc85xx_pci_err_probe(pdev);
+#endif
+
 	return 0;
 }
 
diff --git a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h
index c884e06..9845133 100644
--- a/arch/powerpc/sysdev/fsl_pci.h
+++ b/arch/powerpc/sysdev/fsl_pci.h
@@ -110,5 +110,9 @@ extern void pci_determine_swiotlb(void);
 static inline void pci_determine_swiotlb(void) {}
 #endif
 
+#ifdef CONFIG_EDAC_MPC85XX
+extern int mpc85xx_pci_err_probe(struct platform_device *op);
+#endif
+
 #endif /* __POWERPC_FSL_PCI_H */
 #endif /* __KERNEL__ */
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
