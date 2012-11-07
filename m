Return-Path: <B38951@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 649E02C00DE
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Nov 2012 19:54:15 +1100 (EST)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>
Subject: [PATCH][V2] powerpc/fsl-pci: Add PCI controller ATMU PM support
Date: Wed, 7 Nov 2012 16:10:06 +0800
Message-ID: <1352275806-5754-1-git-send-email-B38951@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: B07421@freescale.com, B04825@freescale.com, b38951@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Power supply for PCI controller ATMU registers is off when system go to
deep-sleep state. So ATMU registers should be re-setup during PCI
controllers resume from sleep.

Signed-off-by: Jia Hongtao <B38951@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/sysdev/fsl_pci.c |   37 +++++++++++++++++++++++++++++++++++--
 1 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index ffb93ae..e6ab952 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -89,7 +89,7 @@ static int fsl_pci_dma_set_mask(struct device *dev, u64 dma_mask)
 	return 0;
 }
 
-static int __init setup_one_atmu(struct ccsr_pci __iomem *pci,
+static int setup_one_atmu(struct ccsr_pci __iomem *pci,
 	unsigned int index, const struct resource *res,
 	resource_size_t offset)
 {
@@ -126,7 +126,7 @@ static int __init setup_one_atmu(struct ccsr_pci __iomem *pci,
 }
 
 /* atmu setup for fsl pci/pcie controller */
-static void __init setup_pci_atmu(struct pci_controller *hose,
+static void setup_pci_atmu(struct pci_controller *hose,
 				  struct resource *rsrc)
 {
 	struct ccsr_pci __iomem *pci;
@@ -902,9 +902,42 @@ static int __devinit fsl_pci_probe(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int fsl_pci_resume(struct device *dev)
+{
+	struct pci_controller *hose;
+	struct resource pci_rsrc;
+
+	hose = pci_find_hose_for_OF_device(dev->of_node);
+	if (!hose)
+		return -ENODEV;
+
+	if (of_address_to_resource(dev->of_node, 0, &pci_rsrc)) {
+		pr_warning("Get pci register base failed");
+		return -ENOMEM;
+	}
+
+	setup_pci_atmu(hose, &pci_rsrc);
+
+	return 0;
+}
+
+static const struct dev_pm_ops pci_pm_ops = {
+	.resume = fsl_pci_resume,
+};
+
+#define PCI_PM_OPS (&pci_pm_ops)
+
+#else
+
+#define PCI_PM_OPS NULL
+
+#endif
+
 static struct platform_driver fsl_pci_driver = {
 	.driver = {
 		.name = "fsl-pci",
+		.pm = PCI_PM_OPS,
 		.of_match_table = pci_ids,
 	},
 	.probe = fsl_pci_probe,
-- 
1.7.5.1
