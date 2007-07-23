Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1EA1CDDEE4
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 06:51:05 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH 17/25] [POWERPC] Make sure virtual P2P bridge registers are
	setup on PCIe PHB
Date: Mon, 23 Jul 2007 15:50:04 -0500
Message-Id: <11852238383453-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <11852238362041-git-send-email-galak@kernel.crashing.org>
References: <11852238122538-git-send-email-galak@kernel.crashing.org>
	<1185223813693-git-send-email-galak@kernel.crashing.org>
	<11852238151983-git-send-email-galak@kernel.crashing.org>
	<11852238161546-git-send-email-galak@kernel.crashing.org>
	<1185223818821-git-send-email-galak@kernel.crashing.org>
	<11852238193371-git-send-email-galak@kernel.crashing.org>
	<1185223821183-git-send-email-galak@kernel.crashing.org>
	<11852238233066-git-send-email-galak@kernel.crashing.org>
	<11852238241475-git-send-email-galak@kernel.crashing.org>
	<11852238253550-git-send-email-galak@kernel.crashing.org>
	<11852238271141-git-send-email-galak@kernel.crashing.org>
	<11852238283648-git-send-email-galak@kernel.crashing.org>
	<1185223830411-git-send-email-galak@kernel.crashing.org>
	<11852238322319-git-send-email-galak@kernel.crashing.org>
	<11852238333649-git-send-email-galak@kernel.crashing.org>
	<11852238353292-git-send-email-galak@kernel.crashing.org>
	<11852238362041-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For the Freescale PCIe PHBs Not all firmwares setup the virtual P2P
bridge registers properly.  Make sure they get setup based on what
the struct pci_controller got from the device tree.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/sysdev/fsl_pci.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index f51fedf..fc3e13e 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -118,11 +118,24 @@ static void __devinit quirk_fsl_pcie_transparent(struct pci_dev *dev)
 		return;
 	}
 
+	/* Clear out any of the virtual P2P bridge registers */
+	pci_write_config_word(dev, PCI_IO_BASE_UPPER16, 0);
+	pci_write_config_word(dev, PCI_IO_LIMIT_UPPER16, 0);
+	pci_write_config_byte(dev, PCI_IO_BASE, 0x10);
+	pci_write_config_byte(dev, PCI_IO_LIMIT, 0);
+	pci_write_config_word(dev, PCI_MEMORY_BASE, 0x10);
+	pci_write_config_word(dev, PCI_MEMORY_LIMIT, 0);
+	pci_write_config_word(dev, PCI_PREF_BASE_UPPER32, 0x0);
+	pci_write_config_word(dev, PCI_PREF_LIMIT_UPPER32, 0x0);
+	pci_write_config_word(dev, PCI_PREF_MEMORY_BASE, 0x10);
+	pci_write_config_word(dev, PCI_PREF_MEMORY_LIMIT, 0);
+
 	if (hose->io_resource.flags) {
 		res = &dev->resource[res_idx++];
 		res->start = hose->io_resource.start;
 		res->end = hose->io_resource.end;
 		res->flags = hose->io_resource.flags;
+		update_bridge_resource(dev, res);
 	}
 
 	for (i = 0; i < 3; i++) {
@@ -130,6 +143,7 @@ static void __devinit quirk_fsl_pcie_transparent(struct pci_dev *dev)
 		res->start = hose->mem_resources[i].start;
 		res->end = hose->mem_resources[i].end;
 		res->flags = hose->mem_resources[i].flags;
+		update_bridge_resource(dev, res);
 	}
 }
 
-- 
1.5.2.2
