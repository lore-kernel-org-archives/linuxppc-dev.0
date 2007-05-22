Return-Path: <wei.zhang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E6F34DDE1D
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 13:31:47 +1000 (EST)
From: Zhang Wei <wei.zhang@freescale.com>
To: paulus@samba.org
Subject: [PATCH 3/5] Float the pci bus number on MPC8641HPCN board.
Date: Tue, 22 May 2007 11:38:28 +0800
Message-Id: <1179805110278-git-send-email-wei.zhang@freescale.com>
In-Reply-To: <1179805110272-git-send-email-wei.zhang@freescale.com>
References: <11798051102658-git-send-email-wei.zhang@freescale.com>
	<11798051101543-git-send-email-wei.zhang@freescale.com>
	<1179805110272-git-send-email-wei.zhang@freescale.com>
Sender: Zhang Wei <wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Float the pci bus number on MPC8641HPCN board.
For example, PCI hose 1 bus range is from 0 to 2, the PCI hose 2 bus
range will start from 3.
Add the pci-express link training stats check. It avoid the system halt
while the link training is fault.

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
Acked-by: Roy Zang <tie-fei.zang@freescale.com>
---
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    1 +
 arch/powerpc/platforms/86xx/pci.c          |   23 ++++++++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index ae5714f..2dacc33 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -358,6 +358,7 @@ mpc86xx_hpcn_setup_arch(void)
 	}
 
 #ifdef CONFIG_PCI
+	pci_assign_all_buses = 1;
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
 		add_bridge(np);
 
diff --git a/arch/powerpc/platforms/86xx/pci.c b/arch/powerpc/platforms/86xx/pci.c
index 7efae7c..5612f6a 100644
--- a/arch/powerpc/platforms/86xx/pci.c
+++ b/arch/powerpc/platforms/86xx/pci.c
@@ -122,7 +122,6 @@ static void __init
 mpc86xx_setup_pcie(struct pci_controller *hose, u32 pcie_offset, u32 pcie_size)
 {
 	u16 cmd;
-	unsigned int temps;
 
 	DBG("PCIE host controller register offset 0x%08x, size 0x%08x.\n",
 			pcie_offset, pcie_size);
@@ -137,9 +136,23 @@ mpc86xx_setup_pcie(struct pci_controller *hose, u32 pcie_offset, u32 pcie_size)
 
 int mpc86xx_exclude_device(u_char bus, u_char devfn)
 {
+	struct pci_controller *hose;
+
+	hose = pci_bus_to_hose(bus);
+	if (unlikely(!hose))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	/* Correcting the hose->bus_offset value. */
+	out_be32(hose->cfg_addr, 0x80000000 | ((hose->first_busno
+					- hose->bus_offset) << 16));
+	if (unlikely(in_le32(hose->cfg_data) == 0xffffffff))
+		hose->bus_offset = hose->bus_offset ? 0 : hose->first_busno;
+
 	return PCIBIOS_SUCCESSFUL;
 }
 
+#define PCIE_LTSSM	0x04000004	/* PCIe Link Training and Status */
+#define PCIE_LTSSM_L0	0x16		/* L0 state */
 int __init add_bridge(struct device_node *dev)
 {
 	int len;
@@ -148,12 +161,20 @@ int __init add_bridge(struct device_node *dev)
 	const int *bus_range;
 	int has_address = 0;
 	int primary = 0;
+	void *pcicfg_addr;
 
 	DBG("Adding PCIE host bridge %s\n", dev->full_name);
 
 	/* Fetch host bridge registers address */
 	has_address = (of_address_to_resource(dev, 0, &rsrc) == 0);
 
+	/* Probe the hose link training status */
+	pcicfg_addr = ioremap(rsrc.start, 0x1000);
+	out_be32(pcicfg_addr, 0x80000000 | PCIE_LTSSM);
+	if (in_le16(pcicfg_addr + 4) < PCIE_LTSSM_L0)
+		return -ENXIO;
+	iounmap(pcicfg_addr);
+
 	/* Get bus range if any */
 	bus_range = of_get_property(dev, "bus-range", &len);
 	if (bus_range == NULL || len < 2 * sizeof(int))
-- 
1.5.1
