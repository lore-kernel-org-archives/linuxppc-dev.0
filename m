Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D2B6FDDFE2
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2007 11:17:08 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 15/15] [POWERPC] 86xx: Created quirk_fsl_pcie_transparent() to
	initialize bridge resources.
Date: Tue, 26 Jun 2007 20:16:45 -0500
Message-Id: <11829070272146-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1182907026390-git-send-email-galak@kernel.crashing.org>
References: <11829070051484-git-send-email-galak@kernel.crashing.org>
	<11829070063989-git-send-email-galak@kernel.crashing.org>
	<11829070073637-git-send-email-galak@kernel.crashing.org>
	<11829070091056-git-send-email-galak@kernel.crashing.org>
	<11829070102887-git-send-email-galak@kernel.crashing.org>
	<11829070111239-git-send-email-galak@kernel.crashing.org>
	<1182907013252-git-send-email-galak@kernel.crashing.org>
	<1182907014549-git-send-email-galak@kernel.crashing.org>
	<1182907015126-git-send-email-galak@kernel.crashing.org>
	<11829070192461-git-send-email-galak@kernel.crashing.org>
	<1182907020965-git-send-email-galak@kernel.crashing.org>
	<11829070222511-git-send-email-galak@kernel.crashing.org>
	<11829070232635-git-send-email-galak@kernel.crashing.org>
	<11829070241688-git-send-email-galak@kernel.crashing.org>
	<1182907026390-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Zhang Wei <wei.zhang@freescale.com>

The Freescale PCI-e RC poses as a transparent bridge, but does not
implement the IO_BASE or IO_LIMIT registers in the config space.  This
means that the code which initializes the bridge resources ends up
setting the IO resources erroneously.  Add quick_fsl_pcie_transparent()
to handle this.

This change sets RC of mpc8641 to be a transparent bridge
for legacy I/O access and initializes the RC bridge resources
from the device tree.

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
Signed-off-by: Andy Fleming <afleming@freescale.com>
Signed-off-by: Jon Loeliger <jdl@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/86xx/pci.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/pci.c b/arch/powerpc/platforms/86xx/pci.c
index 6f3c0f6..2d7254c 100644
--- a/arch/powerpc/platforms/86xx/pci.c
+++ b/arch/powerpc/platforms/86xx/pci.c
@@ -134,6 +134,43 @@ mpc86xx_setup_pcie(struct pci_controller *hose, u32 pcie_offset, u32 pcie_size)
 	early_write_config_byte(hose, 0, 0, PCI_LATENCY_TIMER, 0x80);
 }
 
+static void __devinit quirk_fsl_pcie_transparent(struct pci_dev *dev)
+{
+	struct resource *res;
+	int i, res_idx = PCI_BRIDGE_RESOURCES;
+	struct pci_controller *hose;
+
+	/*
+	 * Make the bridge be transparent.
+	 */
+	dev->transparent = 1;
+
+	hose = pci_bus_to_hose(dev->bus->number);
+	if (!hose) {
+		printk(KERN_ERR "Can't find hose for bus %d\n",
+		       dev->bus->number);
+		return;
+	}
+
+	if (hose->io_resource.flags) {
+		res = &dev->resource[res_idx++];
+		res->start = hose->io_resource.start;
+		res->end = hose->io_resource.end;
+		res->flags = hose->io_resource.flags;
+	}
+
+	for (i = 0; i < 3; i++) {
+		res = &dev->resource[res_idx + i];
+		res->start = hose->mem_resources[i].start;
+		res->end = hose->mem_resources[i].end;
+		res->flags = hose->mem_resources[i].flags;
+	}
+}
+
+
+DECLARE_PCI_FIXUP_EARLY(0x1957, 0x7010, quirk_fsl_pcie_transparent);
+DECLARE_PCI_FIXUP_EARLY(0x1957, 0x7011, quirk_fsl_pcie_transparent);
+
 #define PCIE_LTSSM	0x404	/* PCIe Link Training and Status */
 #define PCIE_LTSSM_L0	0x16	/* L0 state */
 
-- 
1.5.2.1
