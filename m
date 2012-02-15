Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 39E481008F9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2012 15:23:00 +1100 (EST)
Message-ID: <1329279770.3772.25.camel@pasglop>
Subject: [PATCH 2/3] powerpc/fsl/pci: Improve PCIe host bridge quirks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 15 Feb 2012 15:22:50 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The current quirk is a header quirk which runs after
pci_setup_device(). This means that we can warnings
from the later due to an unrecognized class code,
and some parts of pci_dev aren't setup properly.

On the other hand, we somewhat rely on that later on
as this causes "pci_read_bases" to not be called, thus
not bringing in the bogus BAR 0 of the root complex.

This breaks up the quirk in two. One is an early quirk
and fixes up the class code. The other one remains a
header quirk and removes the bogus resource.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/sysdev/fsl_pci.c |   34 +++++++++++++++++++++++++++++-----
 1 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index b392144..a1da340 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -36,23 +36,48 @@
 
 static int fsl_pcie_bus_fixup, is_mpc83xx_pci;
 
-static void __init quirk_fsl_pcie_header(struct pci_dev *dev)
+static int __devinit __quirk_is_fsl_pcie_host(struct pci_dev *dev)
 {
 	u8 progif;
 
+	/* We aren't a root complex, don't bother */
+	if (dev->bus->self)
+		return 0;
+
 	/* if we aren't a PCIe don't bother */
 	if (!pci_find_capability(dev, PCI_CAP_ID_EXP))
-		return;
+		return 0;
 
 	/* if we aren't in host mode don't bother */
 	pci_read_config_byte(dev, PCI_CLASS_PROG, &progif);
 	if (progif & 0x1)
+		return 0;
+
+	return 1;
+}
+
+static void __devinit quirk_fsl_pcie_early(struct pci_dev *dev)
+{
+
+	if (!__quirk_is_fsl_pcie_host(dev))
 		return;
 
+	/* Fix incorrect class code */
 	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
 	fsl_pcie_bus_fixup = 1;
-	return;
 }
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID, quirk_fsl_pcie_early);
+
+static void __devinit quirk_fsl_pcie_header(struct pci_dev *dev)
+{
+	if (!__quirk_is_fsl_pcie_host(dev))
+		return;
+
+	/* Hide resource 0 */
+	dev->resource[0].start = dev->resource[0].end = 0;
+	dev->resource[0].flags = 0;
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID, quirk_fsl_pcie_header);
 
 static int __init fsl_pcie_check_link(struct pci_controller *hose)
 {
@@ -81,6 +106,7 @@ static int fsl_pci_dma_set_mask(struct device *dev, u64 dma_mask)
 	 */
 	if ((dev->bus == &pci_bus_type) &&
 	    dma_mask >= DMA_BIT_MASK(MAX_PHYS_ADDR_BITS)) {
+		dev_info(dev, "Switching PCI device to direct DMA ops\n");
 		set_dma_ops(dev, &dma_direct_ops);
 		set_dma_offset(dev, pci64_dma_offset);
 	}
@@ -496,8 +522,6 @@ int __init fsl_add_bridge(struct device_node *dev, int is_primary)
 }
 #endif /* CONFIG_FSL_SOC_BOOKE || CONFIG_PPC_86xx */
 
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID, quirk_fsl_pcie_header);
-
 #if defined(CONFIG_PPC_83xx) || defined(CONFIG_PPC_MPC512x)
 struct mpc83xx_pcie_priv {
 	void __iomem *cfg_type0;
-- 
1.7.7.3
