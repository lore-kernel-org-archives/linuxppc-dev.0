Return-Path: <B38951@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6AA402C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2012 14:02:07 +1100 (EST)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/fsl-pci: Add PCI controller ATMU PM support
Date: Thu, 1 Nov 2012 10:19:08 +0800
Message-ID: <1351736348-26754-1-git-send-email-B38951@freescale.com>
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

Power supply for PCI controller ATMU registers is off when system go to
deep-sleep state. So ATMU registers should be re-setup during PCI
controllers resume from sleep.

Signed-off-by: Jia Hongtao <B38951@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/sysdev/fsl_pci.c |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index ffb93ae..793a017 100644
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
@@ -902,12 +902,29 @@ static int __devinit fsl_pci_probe(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_SUSPEND
+static int fsl_pci_resume(struct platform_device *pdev)
+{
+	struct pci_controller *hose;
+	struct resource pci_rsrc;
+
+	hose = pci_find_hose_for_OF_device(pdev->dev.of_node);
+	of_address_to_resource(pdev->dev.of_node, 0, &pci_rsrc);
+	setup_pci_atmu(hose, &pci_rsrc);
+
+	return 0;
+}
+#endif
+
 static struct platform_driver fsl_pci_driver = {
 	.driver = {
 		.name = "fsl-pci",
 		.of_match_table = pci_ids,
 	},
 	.probe = fsl_pci_probe,
+#ifdef CONFIG_SUSPEND
+	.resume	= fsl_pci_resume,
+#endif
 };
 
 static int __init fsl_pci_init(void)
-- 
1.7.5.1
