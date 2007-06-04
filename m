Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8485BDDF9E
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Jun 2007 08:30:11 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l54MU5aC009426
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Jun 2007 15:30:06 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l54MU3Eh021865
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Jun 2007 17:30:05 -0500 (CDT)
Subject: [PATCH v2 3/9] 8641HPCN: Add PCI-Express link training status check
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1180996203.9632.71.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Mon, 04 Jun 2007 17:30:03 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Zhang Wei <wei.zhang@freescale.com>

Avoid system halt while the link training is fault.

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
Acked-by: Roy Zang <tie-fei.zang@freescale.com>
Signed-off-by: Jon Loeliger <jdl@freescale.com>
---
 arch/powerpc/platforms/86xx/pci.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/pci.c b/arch/powerpc/platforms/86xx/pci.c
index 7efae7c..07ff52c 100644
--- a/arch/powerpc/platforms/86xx/pci.c
+++ b/arch/powerpc/platforms/86xx/pci.c
@@ -122,7 +122,6 @@ static void __init
 mpc86xx_setup_pcie(struct pci_controller *hose, u32 pcie_offset, u32 pcie_size)
 {
 	u16 cmd;
-	unsigned int temps;
 
 	DBG("PCIE host controller register offset 0x%08x, size 0x%08x.\n",
 			pcie_offset, pcie_size);
@@ -140,6 +139,9 @@ int mpc86xx_exclude_device(u_char bus, u_char devfn)
 	return PCIBIOS_SUCCESSFUL;
 }
 
+#define PCIE_LTSSM	0x04000004	/* PCIe Link Training and Status */
+#define PCIE_LTSSM_L0	0x16		/* L0 state */
+
 int __init add_bridge(struct device_node *dev)
 {
 	int len;
@@ -148,12 +150,20 @@ int __init add_bridge(struct device_node *dev)
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
1.5.0.3
