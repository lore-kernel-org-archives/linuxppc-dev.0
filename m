Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2E97ADDF1C
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 06:50:46 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH 05/25] [POWERPC] FSL: Cleanup how we detect if we are a PCIe
	controller
Date: Mon, 23 Jul 2007 15:49:52 -0500
Message-Id: <11852238193371-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1185223818821-git-send-email-galak@kernel.crashing.org>
References: <11852238122538-git-send-email-galak@kernel.crashing.org>
	<1185223813693-git-send-email-galak@kernel.crashing.org>
	<11852238151983-git-send-email-galak@kernel.crashing.org>
	<11852238161546-git-send-email-galak@kernel.crashing.org>
	<1185223818821-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Use the PCI capabilities to determine if we are PCIe PHB.  Also use
PPC_INDIRECT_TYPE_NO_PCIE_LINK since the Freescale PCIe controllers
will lock the system if they don't have link and you try to do a config
access to anything but the PHB.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/sysdev/fsl_pci.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 10c47b5..69d3c6e 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -102,6 +102,10 @@ static void __devinit quirk_fsl_pcie_transparent(struct pci_dev *dev)
 	int i, res_idx = PCI_BRIDGE_RESOURCES;
 	struct pci_controller *hose;
 
+	/* if we aren't a PCIe don't bother */
+	if (!pci_find_capability(dev, PCI_CAP_ID_EXP))
+		return ;
+
 	/*
 	 * Make the bridge be transparent.
 	 */
@@ -167,20 +171,16 @@ int __init fsl_add_bridge(struct device_node *dev, int is_primary)
 	hose->first_busno = bus_range ? bus_range[0] : 0x0;
 	hose->last_busno = bus_range ? bus_range[1] : 0xff;
 
-	/* check PCI express bridge */
-	if (of_device_is_compatible(dev, "fsl,mpc8548-pcie") ||
-		of_device_is_compatible(dev, "fsl,mpc8641-pcie"))
-		hose->indirect_type = PPC_INDIRECT_TYPE_EXT_REG |
-			PPC_INDIRECT_TYPE_SURPRESS_PRIMARY_BUS;
-
 	setup_indirect_pci(hose, rsrc.start, rsrc.start + 0x4);
 	setup_pci_cmd(hose);
 
 	/* check PCI express link status */
-	if (of_device_is_compatible(dev, "fsl,mpc8548-pcie") ||
-		of_device_is_compatible(dev, "fsl,mpc8641-pcie"))
+	if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
+		hose->indirect_type = PPC_INDIRECT_TYPE_EXT_REG |
+			PPC_INDIRECT_TYPE_SURPRESS_PRIMARY_BUS;
 		if (fsl_pcie_check_link(hose))
-			return -ENXIO;
+			hose->indirect_type |= PPC_INDIRECT_TYPE_NO_PCIE_LINK;
+	}
 
 	printk(KERN_INFO "Found FSL PCI host bridge at 0x%016llx."
 		"Firmware bus number: %d->%d\n",
-- 
1.5.2.2
