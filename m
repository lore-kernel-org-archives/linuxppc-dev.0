Return-Path: <B16395@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5BF8D2C0202
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2013 22:34:47 +1100 (EST)
From: Varun Sethi <Varun.Sethi@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>,
 <scottwood@freescale.com>
Subject: [linuxppc-dev][PATCH] powerpc/fsl_pci: Store the pci controller
 device pointer in the pci controller structure.
Date: Mon, 14 Jan 2013 16:58:00 +0530
Message-ID: <1358162880-16012-1-git-send-email-Varun.Sethi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Varun Sethi <Varun.Sethi@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The pci controller structure has a provision to store the device strcuture
pointer of the corresponding platform device. Currently this information is
not stored during fsl pci controller initialization. This information is
required while dealing with iommu groups for pci devices connected to the fsl
pci controller. For the case where the pci devices can't be paritioned, they 
would fall under the same device group as the pci controller.

This patch stores the platform device information in the pci controller
structure during initialization.

Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
---
 arch/powerpc/sysdev/fsl_pci.c |    9 +++++++--
 arch/powerpc/sysdev/fsl_pci.h |    2 +-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 92a5915..b393ae7 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -421,13 +421,16 @@ void fsl_pcibios_fixup_bus(struct pci_bus *bus)
 	}
 }
 
-int __init fsl_add_bridge(struct device_node *dev, int is_primary)
+int __init fsl_add_bridge(struct platform_device *pdev, int is_primary)
 {
 	int len;
 	struct pci_controller *hose;
 	struct resource rsrc;
 	const int *bus_range;
 	u8 hdr_type, progif;
+	struct device_node *dev;
+
+	dev = pdev->dev.of_node;
 
 	if (!of_device_is_available(dev)) {
 		pr_warning("%s: disabled\n", dev->full_name);
@@ -453,6 +456,8 @@ int __init fsl_add_bridge(struct device_node *dev, int is_primary)
 	if (!hose)
 		return -ENOMEM;
 
+	/* set platform device as the parent */
+	hose->parent = &pdev->dev;
 	hose->first_busno = bus_range ? bus_range[0] : 0x0;
 	hose->last_busno = bus_range ? bus_range[1] : 0xff;
 
@@ -880,7 +885,7 @@ static int fsl_pci_probe(struct platform_device *pdev)
 #endif
 
 	node = pdev->dev.of_node;
-	ret = fsl_add_bridge(node, fsl_pci_primary == node);
+	ret = fsl_add_bridge(pdev, fsl_pci_primary == node);
 
 #ifdef CONFIG_SWIOTLB
 	if (ret == 0) {
diff --git a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h
index d078537..c495c00 100644
--- a/arch/powerpc/sysdev/fsl_pci.h
+++ b/arch/powerpc/sysdev/fsl_pci.h
@@ -91,7 +91,7 @@ struct ccsr_pci {
 	__be32	pex_err_cap_r3;		/* 0x.e34 - PCIE error capture register 0 */
 };
 
-extern int fsl_add_bridge(struct device_node *dev, int is_primary);
+extern int fsl_add_bridge(struct platform_device *pdev, int is_primary);
 extern void fsl_pcibios_fixup_bus(struct pci_bus *bus);
 extern int mpc83xx_add_bridge(struct device_node *dev);
 u64 fsl_pci_immrbar_base(struct pci_controller *hose);
-- 
1.7.4.1
