Return-Path: <B31939@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5E6912C037C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Oct 2013 21:42:19 +1100 (EST)
From: Minghuan Lian <Minghuan.Lian@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 11/12][v3] pci: fsl: update PCI EDAC driver
Date: Wed, 23 Oct 2013 18:41:33 +0800
Message-ID: <1382524894-15164-11-git-send-email-Minghuan.Lian@freescale.com>
In-Reply-To: <1382524894-15164-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1382524894-15164-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>, linux-pci@vger.kernel.org,
 Zang Roy-R61911 <r61911@freescale.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

1. The pci-fsl-common driver has set fsl_pci to device as drvdata,
so EDAC driver can not call dev_set_drvdata() again. fsl_pci
contains regs field to point PCI CCSR, so EDAC may directly use
the pointer and not need to call devm_ioremap().
2. Add mpc85xx_pci_err_remove() to disable PCI error interrupt
and delete PCI EDAC from EDAC subsystem.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
change log:
v1-v3:
Derived from http://patchwork.ozlabs.org/patch/278965/
Added mpc85xx_pci_err_remove()

Based on upstream master.
Based on the discussion of RFC version here
http://patchwork.ozlabs.org/patch/274487/

 arch/powerpc/sysdev/fsl_pci.c |  1 +
 arch/powerpc/sysdev/fsl_pci.h |  6 ++++++
 drivers/edac/mpc85xx_edac.c   | 46 +++++++++++++++----------------------------
 drivers/edac/mpc85xx_edac.h   |  1 +
 4 files changed, 24 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 40d2e1d..4a03e1a 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -236,6 +236,7 @@ void fsl_arch_pci_sys_remove(struct fsl_pci *pci)
 	if (!hose)
 		return;
 
+	mpc85xx_pci_err_remove(to_platform_device(pci->dev));
 	pcibios_free_controller(hose);
 }
 
diff --git a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h
index ce77aad..ae4dbe2 100644
--- a/arch/powerpc/sysdev/fsl_pci.h
+++ b/arch/powerpc/sysdev/fsl_pci.h
@@ -35,11 +35,17 @@ static inline void fsl_pci_assign_primary(void) {}
 
 #ifdef CONFIG_EDAC_MPC85XX
 int mpc85xx_pci_err_probe(struct platform_device *op);
+int mpc85xx_pci_err_remove(struct platform_device *op);
 #else
 static inline int mpc85xx_pci_err_probe(struct platform_device *op)
 {
 	return -ENOTSUPP;
 }
+static inline int mpc85xx_pci_err_remove(struct platform_device *op)
+{
+	return -ENOTSUPP;
+}
+
 #endif
 
 #ifdef CONFIG_FSL_PCI
diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index 3eb32f6..14a4116 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -21,6 +21,7 @@
 
 #include <linux/of_platform.h>
 #include <linux/of_device.h>
+#include <linux/fsl/pci-common.h>
 #include "edac_module.h"
 #include "edac_core.h"
 #include "mpc85xx_edac.h"
@@ -214,11 +215,13 @@ static irqreturn_t mpc85xx_pci_isr(int irq, void *dev_id)
 
 int mpc85xx_pci_err_probe(struct platform_device *op)
 {
+	struct fsl_pci *fslpci;
 	struct edac_pci_ctl_info *pci;
 	struct mpc85xx_pci_pdata *pdata;
-	struct resource r;
 	int res = 0;
 
+	fslpci = platform_get_drvdata(op);
+
 	if (!devres_open_group(&op->dev, mpc85xx_pci_err_probe, GFP_KERNEL))
 		return -ENOMEM;
 
@@ -239,7 +242,6 @@ int mpc85xx_pci_err_probe(struct platform_device *op)
 	pdata = pci->pvt_info;
 	pdata->name = "mpc85xx_pci_err";
 	pdata->irq = NO_IRQ;
-	dev_set_drvdata(&op->dev, pci);
 	pci->dev = &op->dev;
 	pci->mod_name = EDAC_MOD_STR;
 	pci->ctl_name = pdata->name;
@@ -250,30 +252,8 @@ int mpc85xx_pci_err_probe(struct platform_device *op)
 
 	pdata->edac_idx = edac_pci_idx++;
 
-	res = of_address_to_resource(op->dev.of_node, 0, &r);
-	if (res) {
-		printk(KERN_ERR "%s: Unable to get resource for "
-		       "PCI err regs\n", __func__);
-		goto err;
-	}
-
 	/* we only need the error registers */
-	r.start += 0xe00;
-
-	if (!devm_request_mem_region(&op->dev, r.start, resource_size(&r),
-					pdata->name)) {
-		printk(KERN_ERR "%s: Error while requesting mem region\n",
-		       __func__);
-		res = -EBUSY;
-		goto err;
-	}
-
-	pdata->pci_vbase = devm_ioremap(&op->dev, r.start, resource_size(&r));
-	if (!pdata->pci_vbase) {
-		printk(KERN_ERR "%s: Unable to setup PCI err regs\n", __func__);
-		res = -ENOMEM;
-		goto err;
-	}
+	pdata->pci_vbase = (void *)fslpci->regs + MPC85XX_PCI_ERR_OFFSET;
 
 	orig_pci_err_cap_dr =
 	    in_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_CAP_DR);
@@ -327,20 +307,25 @@ err:
 }
 EXPORT_SYMBOL(mpc85xx_pci_err_probe);
 
-static int mpc85xx_pci_err_remove(struct platform_device *op)
+int mpc85xx_pci_err_remove(struct platform_device *op)
 {
-	struct edac_pci_ctl_info *pci = dev_get_drvdata(&op->dev);
-	struct mpc85xx_pci_pdata *pdata = pci->pvt_info;
+	struct edac_pci_ctl_info *pci;
+	struct mpc85xx_pci_pdata *pdata;
 
 	edac_dbg(0, "\n");
 
+	pci = edac_pci_del_device(&op->dev);
+
+	if (!pci)
+		return -EINVAL;
+
+	pdata = pci->pvt_info;
+
 	out_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_CAP_DR,
 		 orig_pci_err_cap_dr);
 
 	out_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_EN, orig_pci_err_en);
 
-	edac_pci_del_device(pci->dev);
-
 	if (edac_op_state == EDAC_OPSTATE_INT)
 		irq_dispose_mapping(pdata->irq);
 
@@ -348,6 +333,7 @@ static int mpc85xx_pci_err_remove(struct platform_device *op)
 
 	return 0;
 }
+EXPORT_SYMBOL(mpc85xx_pci_err_remove);
 
 #endif				/* CONFIG_PCI */
 
diff --git a/drivers/edac/mpc85xx_edac.h b/drivers/edac/mpc85xx_edac.h
index 932016f..3ba235a 100644
--- a/drivers/edac/mpc85xx_edac.h
+++ b/drivers/edac/mpc85xx_edac.h
@@ -131,6 +131,7 @@
 #define PCI_EDE_PERR_MASK	(PCI_EDE_TGT_PERR | PCI_EDE_MST_PERR | \
 				PCI_EDE_ADDR_PERR)
 
+#define MPC85XX_PCI_ERR_OFFSET		0x0e00
 #define MPC85XX_PCI_ERR_DR		0x0000
 #define MPC85XX_PCI_ERR_CAP_DR		0x0004
 #define MPC85XX_PCI_ERR_EN		0x0008
-- 
1.8.1.2
