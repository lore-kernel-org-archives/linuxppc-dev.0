Return-Path: <B25806@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 312B52C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2012 16:59:32 +1000 (EST)
Received: from mail56-ch1 (localhost [127.0.0.1])	by mail56-ch1-R.bigfish.com
 (Postfix) with ESMTP id 698921600FF	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,
 27 Sep 2012 06:59:27 +0000 (UTC)
Received: from CH1EHSMHS016.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.244])	by mail56-ch1.bigfish.com (Postfix) with ESMTP id
 7BAB06008E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2012 06:59:25 +0000 (UTC)
From: Chunhe Lan <Chunhe.Lan@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 3/3] edac/85xx: Enable the EDAC PCI err driver by
 device_initcall
Date: Thu, 27 Sep 2012 15:02:03 -0400
Message-ID: <1348772523-17587-3-git-send-email-Chunhe.Lan@freescale.com>
In-Reply-To: <1348772523-17587-1-git-send-email-Chunhe.Lan@freescale.com>
References: <1348772523-17587-1-git-send-email-Chunhe.Lan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: kumar.gala@freescale.com, Chunhe Lan <Chunhe.Lan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Original process of call:
	The mpc85xx_pci_err_probe function completes to been registered
	and enabled of EDAC PCI err driver at the latter time stage of
	kernel boot in the mpc85xx_edac.c.
Current process of call:
	The mpc85xx_pci_err_probe function completes to been registered
	and enabled of EDAC PCI err driver at the first	time stage of
	kernel boot in the fsl_pci.c.

So in this case the following error messages appear in the boot log:

    PCI: Probing PCI hardware
    pci 0000:00:00.0: ignoring class b20 (doesn't match header type 01)
    PCIE error(s) detected
    PCIE ERR_DR register: 0x00020000
    PCIE ERR_CAP_STAT register: 0x80000001
    PCIE ERR_CAP_R0 register: 0x00000800
    PCIE ERR_CAP_R1 register: 0x00000000
    PCIE ERR_CAP_R2 register: 0x00000000
    PCIE ERR_CAP_R3 register: 0x00000000

Because the EDAC PCI err driver is registered and enabled earlier than
original point of call. But at this point of time, PCI hardware is not
probed and initialized, and it is in unknowable state.

So, move enable function into mpc85xx_pci_err_en which is called at the
middle time stage of kernel boot and after PCI hardware is probed and
initialized by device_initcall in the fsl_pci.c.

Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
---
 arch/powerpc/sysdev/fsl_pci.c |   12 ++++++++++
 arch/powerpc/sysdev/fsl_pci.h |    5 ++++
 drivers/edac/mpc85xx_edac.c   |   47 ++++++++++++++++++++++++++++------------
 3 files changed, 50 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 3d6f4d8..a591965 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -904,4 +904,16 @@ static int __init fsl_pci_init(void)
 	return platform_driver_register(&fsl_pci_driver);
 }
 arch_initcall(fsl_pci_init);
+
+static int __init fsl_pci_err_en(void)
+{
+	struct device_node *np;
+
+	for_each_node_by_type(np, "pci")
+		if (of_match_node(pci_ids, np))
+			mpc85xx_pci_err_en(np);
+
+	return 0;
+}
+device_initcall(fsl_pci_err_en);
 #endif
diff --git a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h
index 796fe55..62a7323 100644
--- a/arch/powerpc/sysdev/fsl_pci.h
+++ b/arch/powerpc/sysdev/fsl_pci.h
@@ -136,11 +136,16 @@ static inline void fsl_pci_assign_primary(void) {}
 
 #ifdef CONFIG_EDAC_MPC85XX
 int mpc85xx_pci_err_probe(struct platform_device *op);
+int __init mpc85xx_pci_err_en(struct device_node *np);
 #else
 static inline int mpc85xx_pci_err_probe(struct platform_device *op)
 {
 	return -ENOTSUPP;
 }
+static inline int __init mpc85xx_pci_err_en(struct device_node *np)
+{
+	return -ENOTSUPP;
+}
 #endif
 
 #endif /* __POWERPC_FSL_PCI_H */
diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index 05ef1f2..c317683 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -394,9 +394,6 @@ int __devinit mpc85xx_pci_err_probe(struct platform_device *op)
 	pdata->orig_pci_err_en = in_be32(&reg->pex_err_en);
 	out_be32(&reg->pex_err_en, 0);
 
-	/* clear all error bits */
-	out_be32(&reg->pex_err_dr, ~0);
-
 	if (edac_pci_add_device(pci, pdata->edac_idx) > 0) {
 		edac_dbg(3, "failed edac_pci_add_device()\n");
 		goto err;
@@ -420,17 +417,6 @@ int __devinit mpc85xx_pci_err_probe(struct platform_device *op)
 		       pdata->irq);
 	}
 
-	if (pdata->pcie_flag) {
-		/* enable all pcie error interrupt & error detect */
-		out_be32(&reg->pex_err_en, ~0);
-		out_be32(&reg->pex_err_disr, 0);
-	} else {
-		/* PCI master abort is expected during config cycles */
-		out_be32(&reg->pex_err_cap_dr, PCI_ERR_CAP_DR_DIS_MST);
-		/* disable master abort reporting */
-		out_be32(&reg->pex_err_en, PCI_ERR_EN_DIS_MST);
-	}
-
 	devres_remove_group(&op->dev, mpc85xx_pci_err_probe);
 	edac_dbg(3, "success\n");
 	printk(KERN_INFO EDAC_MOD_STR " PCI err registered\n");
@@ -446,6 +432,39 @@ err:
 }
 EXPORT_SYMBOL(mpc85xx_pci_err_probe);
 
+int __init mpc85xx_pci_err_en(struct device_node *np)
+{
+	struct mpc85xx_pci_pdata pdata;
+	struct resource res;
+	struct ccsr_pci *reg;
+
+	if (mpc85xx_pcie_find_capability(np) > 0)
+		pdata.pcie_flag = 1;
+
+	of_address_to_resource(np, 0, &res);
+	pdata.pci_reg = ioremap(res.start, (res.end - res.start + 1));
+	reg = pdata.pci_reg;
+
+	/* clear all error bits */
+	out_be32(&reg->pex_err_dr, ~0);
+
+	if (pdata.pcie_flag) {
+		/* enable all pcie error interrupt & error detect */
+		out_be32(&reg->pex_err_en, ~0);
+		out_be32(&reg->pex_err_disr, 0);
+	} else {
+		/* PCI master abort is expected during config cycles */
+		out_be32(&reg->pex_err_cap_dr, PCI_ERR_CAP_DR_DIS_MST);
+		/* disable master abort reporting */
+		out_be32(&reg->pex_err_en, PCI_ERR_EN_DIS_MST);
+	}
+
+	pr_info(EDAC_MOD_STR " PCI err enabled\n");
+
+	return 0;
+}
+EXPORT_SYMBOL(mpc85xx_pci_err_en);
+
 static int mpc85xx_pci_err_remove(struct platform_device *op)
 {
 	struct edac_pci_ctl_info *pci = dev_get_drvdata(&op->dev);
-- 
1.7.6.5
