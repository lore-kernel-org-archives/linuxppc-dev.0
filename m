Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3BDEADDFE3
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2007 11:17:07 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 11/15] [POWERPC] 86xx: Avoid system halt if link training
	isn't at least L0.
Date: Tue, 26 Jun 2007 20:16:41 -0500
Message-Id: <11829070222511-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1182907020965-git-send-email-galak@kernel.crashing.org>
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
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Zhang Wei <wei.zhang@freescale.com>

We check the Link Training and State Status register to make sure we
are at least at the L0 state.

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
Acked-by: Roy Zang <tie-fei.zang@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/86xx/pci.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/pci.c b/arch/powerpc/platforms/86xx/pci.c
index 0db51e8..3825e1a 100644
--- a/arch/powerpc/platforms/86xx/pci.c
+++ b/arch/powerpc/platforms/86xx/pci.c
@@ -122,7 +122,6 @@ static void __init
 mpc86xx_setup_pcie(struct pci_controller *hose, u32 pcie_offset, u32 pcie_size)
 {
 	u16 cmd;
-	unsigned int temps;
 
 	DBG("PCIE host controller register offset 0x%08x, size 0x%08x.\n",
 			pcie_offset, pcie_size);
@@ -135,6 +134,9 @@ mpc86xx_setup_pcie(struct pci_controller *hose, u32 pcie_offset, u32 pcie_size)
 	early_write_config_byte(hose, 0, 0, PCI_LATENCY_TIMER, 0x80);
 }
 
+#define PCIE_LTSSM	0x404	/* PCIe Link Training and Status */
+#define PCIE_LTSSM_L0	0x16	/* L0 state */
+
 int __init mpc86xx_add_bridge(struct device_node *dev)
 {
 	int len;
@@ -143,6 +145,7 @@ int __init mpc86xx_add_bridge(struct device_node *dev)
 	const int *bus_range;
 	int has_address = 0;
 	int primary = 0;
+	u16 val;
 
 	DBG("Adding PCIE host bridge %s\n", dev->full_name);
 
@@ -159,12 +162,18 @@ int __init mpc86xx_add_bridge(struct device_node *dev)
 	if (!hose)
 		return -ENOMEM;
 	hose->arch_data = dev;
+	hose->indirect_type = PPC_INDIRECT_TYPE_EXT_REG;
 
 	hose->first_busno = bus_range ? bus_range[0] : 0x0;
 	hose->last_busno = bus_range ? bus_range[1] : 0xff;
 
 	setup_indirect_pci(hose, rsrc.start, rsrc.start + 0x4);
 
+	/* Probe the hose link training status */
+	early_read_config_word(hose, 0, 0, PCIE_LTSSM, &val);
+	if (val < PCIE_LTSSM_L0)
+		return -ENXIO;
+
 	/* Setup the PCIE host controller. */
 	mpc86xx_setup_pcie(hose, rsrc.start, rsrc.end - rsrc.start + 1);
 
-- 
1.5.2.1
