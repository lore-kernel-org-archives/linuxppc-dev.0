Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 2FCDDDDF7E
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 02:13:40 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] 4xx: Add endpoint support to 4xx PCIe driver
Date: Wed,  2 Apr 2008 17:12:29 +0200
Message-Id: <1207149149-17107-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds basic endpoint support to the 4xx PCIe driver.

This is done by checking whether the PCIe port is already configured as
root-complex or as endpoint. This has been done previously in U-Boot and
can be configured there dynamically by setting the "pcie_mode"
environment variable (reboot necessary of course). Here an example:

  pcie_mode = 'RP:RP:EP'

Port 0 & 1 are configured as root-complex and port 2 as endpoint.
This mode will now be used in the Linux driver too.

Note: Currently we map a fixed 64MByte window to PLB address 0 (SDRAM).
This should probably be configurable via a dts property.

Signed-off-by: Stefan Roese <sr@denx.de>
---
 arch/powerpc/sysdev/ppc4xx_pci.c |  133 +++++++++++++++++++++++++++-----------
 1 files changed, 96 insertions(+), 37 deletions(-)

diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_pci.c
index d183b83..013fd05 100644
--- a/arch/powerpc/sysdev/ppc4xx_pci.c
+++ b/arch/powerpc/sysdev/ppc4xx_pci.c
@@ -563,6 +563,18 @@ struct ppc4xx_pciex_hwops
 
 static struct ppc4xx_pciex_hwops *ppc4xx_pciex_hwops;
 
+static int is_endpoint(struct ppc4xx_pciex_port *port)
+{
+	u32 val;
+
+	val = mfdcri(SDR0, port->sdr_base + PESDRn_DLPSET);
+
+	if (((val >> 20) & 0xf) == PTYPE_LEGACY_ENDPOINT)
+		return 1;
+	else
+		return 0;
+}
+
 #ifdef CONFIG_44x
 
 /* Check various reset bits of the 440SPe PCIe core */
@@ -1400,28 +1412,59 @@ static void __init ppc4xx_configure_pciex_PIMs(struct ppc4xx_pciex_port *port,
 	resource_size_t size = res->end - res->start + 1;
 	u64 sa;
 
-	/* Calculate window size */
-	sa = (0xffffffffffffffffull << ilog2(size));;
-	if (res->flags & IORESOURCE_PREFETCH)
-		sa |= 0x8;
+	if (port->endpoint) {
+		resource_size_t ep_addr = 0;
+		resource_size_t ep_size = 32 << 20;
 
-	out_le32(mbase + PECFG_BAR0HMPA, RES_TO_U32_HIGH(sa));
-	out_le32(mbase + PECFG_BAR0LMPA, RES_TO_U32_LOW(sa));
+		/* Currently we map a fixed 64MByte window to PLB address
+		 * 0 (SDRAM). This should probably be configurable via a dts
+		 * property.
+		 */
+
+		/* Calculate window size */
+		sa = (0xffffffffffffffffull << ilog2(ep_size));;
+
+		/* Setup BAR0 */
+		out_le32(mbase + PECFG_BAR0HMPA, RES_TO_U32_HIGH(sa));
+		out_le32(mbase + PECFG_BAR0LMPA, RES_TO_U32_LOW(sa) |
+			 PCI_BASE_ADDRESS_MEM_TYPE_64);
 
-	/* The setup of the split looks weird to me ... let's see if it works */
-	out_le32(mbase + PECFG_PIM0LAL, 0x00000000);
-	out_le32(mbase + PECFG_PIM0LAH, 0x00000000);
-	out_le32(mbase + PECFG_PIM1LAL, 0x00000000);
-	out_le32(mbase + PECFG_PIM1LAH, 0x00000000);
-	out_le32(mbase + PECFG_PIM01SAH, 0xffff0000);
-	out_le32(mbase + PECFG_PIM01SAL, 0x00000000);
+		/* Disable BAR1 & BAR2 */
+		out_le32(mbase + PECFG_BAR1MPA, 0);
+		out_le32(mbase + PECFG_BAR2HMPA, 0);
+		out_le32(mbase + PECFG_BAR2LMPA, 0);
+
+		out_le32(mbase + PECFG_PIM01SAH, RES_TO_U32_HIGH(sa));
+		out_le32(mbase + PECFG_PIM01SAL, RES_TO_U32_LOW(sa));
+
+		out_le32(mbase + PCI_BASE_ADDRESS_0, RES_TO_U32_LOW(ep_addr));
+		out_le32(mbase + PCI_BASE_ADDRESS_1, RES_TO_U32_HIGH(ep_addr));
+	} else {
+		/* Calculate window size */
+		sa = (0xffffffffffffffffull << ilog2(size));;
+		if (res->flags & IORESOURCE_PREFETCH)
+			sa |= 0x8;
+
+		out_le32(mbase + PECFG_BAR0HMPA, RES_TO_U32_HIGH(sa));
+		out_le32(mbase + PECFG_BAR0LMPA, RES_TO_U32_LOW(sa));
+
+		/* The setup of the split looks weird to me ... let's see
+		 * if it works
+		 */
+		out_le32(mbase + PECFG_PIM0LAL, 0x00000000);
+		out_le32(mbase + PECFG_PIM0LAH, 0x00000000);
+		out_le32(mbase + PECFG_PIM1LAL, 0x00000000);
+		out_le32(mbase + PECFG_PIM1LAH, 0x00000000);
+		out_le32(mbase + PECFG_PIM01SAH, 0xffff0000);
+		out_le32(mbase + PECFG_PIM01SAL, 0x00000000);
+
+		out_le32(mbase + PCI_BASE_ADDRESS_0, RES_TO_U32_LOW(res->start));
+		out_le32(mbase + PCI_BASE_ADDRESS_1, RES_TO_U32_HIGH(res->start));
+	}
 
 	/* Enable inbound mapping */
 	out_le32(mbase + PECFG_PIMEN, 0x1);
 
-	out_le32(mbase + PCI_BASE_ADDRESS_0, RES_TO_U32_LOW(res->start));
-	out_le32(mbase + PCI_BASE_ADDRESS_1, RES_TO_U32_HIGH(res->start));
-
 	/* Enable I/O, Mem, and Busmaster cycles */
 	out_le16(mbase + PCI_COMMAND,
 		 in_le16(mbase + PCI_COMMAND) |
@@ -1436,13 +1479,6 @@ static void __init ppc4xx_pciex_port_setup_hose(struct ppc4xx_pciex_port *port)
 	int primary = 0, busses;
 	void __iomem *mbase = NULL, *cfg_data = NULL;
 
-	/* XXX FIXME: Handle endpoint mode properly */
-	if (port->endpoint) {
-		printk(KERN_WARNING "PCIE%d: Port in endpoint mode !\n",
-		       port->index);
-		return;
-	}
-
 	/* Check if primary bridge */
 	if (of_get_property(port->node, "primary", NULL))
 		primary = 1;
@@ -1502,12 +1538,14 @@ static void __init ppc4xx_pciex_port_setup_hose(struct ppc4xx_pciex_port *port)
 	port->hose = hose;
 	mbase = (void __iomem *)hose->cfg_addr;
 
-	/*
-	 * Set bus numbers on our root port
-	 */
-	out_8(mbase + PCI_PRIMARY_BUS, hose->first_busno);
-	out_8(mbase + PCI_SECONDARY_BUS, hose->first_busno + 1);
-	out_8(mbase + PCI_SUBORDINATE_BUS, hose->last_busno);
+	if (!port->endpoint) {
+		/*
+		 * Set bus numbers on our root port
+		 */
+		out_8(mbase + PCI_PRIMARY_BUS, hose->first_busno);
+		out_8(mbase + PCI_SECONDARY_BUS, hose->first_busno + 1);
+		out_8(mbase + PCI_SUBORDINATE_BUS, hose->last_busno);
+	}
 
 	/*
 	 * OMRs are already reset, also disable PIMs
@@ -1531,14 +1569,26 @@ static void __init ppc4xx_pciex_port_setup_hose(struct ppc4xx_pciex_port *port)
 	 * and device IDs into it. Those are the same bogus one that the
 	 * initial code in arch/ppc add. We might want to change that.
 	 */
-	out_le16(mbase + 0x200, 0xaaa0 + port->index);
-	out_le16(mbase + 0x202, 0xbed0 + port->index);
+	if (!port->endpoint) {
+		out_le16(mbase + 0x200, 0xaaa0 + port->index);
+		out_le16(mbase + 0x202, 0xbed0 + port->index);
 
-	/* Set Class Code to PCI-PCI bridge and Revision Id to 1 */
-	out_le32(mbase + 0x208, 0x06040001);
+		/* Set Class Code to PCI-PCI bridge and Revision Id to 1 */
+		out_le32(mbase + 0x208, 0x06040001);
+
+		printk(KERN_INFO "PCIE%d: successfully set as root-complex\n",
+		       port->index);
+	} else {
+		out_le16(mbase + 0x200, 0xeee0 + port->index);
+		out_le16(mbase + 0x202, 0xfed0 + port->index);
+
+		/* Set Class Code to Processor/PPC */
+		out_le32(mbase + 0x208, 0x0b200001);
+
+		printk(KERN_INFO "PCIE%d: successfully set as endpoint\n",
+		       port->index);
+	}
 
-	printk(KERN_INFO "PCIE%d: successfully set as root-complex\n",
-	       port->index);
 	return;
  fail:
 	if (hose)
@@ -1586,8 +1636,17 @@ static void __init ppc4xx_probe_pciex_bridge(struct device_node *np)
 	}
 	port->sdr_base = *pval;
 
-	/* XXX Currently, we only support root complex mode */
-	port->endpoint = 0;
+	/* Check whether the PCIe port is already configured as root-complex
+	 * or as endpoint. This has been done previously in U-Boot and can
+	 * be configured there dynamically by setting the "pcie_mode"
+	 * environment variable (reboot necessary of course). Here an example:
+	 *
+	 * pcie_mode = 'RP:RP:EP'
+	 *
+	 * Port 0 & 1 are configured as root-complex and port 2 as endpoint.
+	 * This mode will now be used in the Linux driver too.
+	 */
+	port->endpoint = is_endpoint(port);
 
 	/* Fetch config space registers address */
 	if (of_address_to_resource(np, 0, &port->cfg_space)) {
-- 
1.5.4.5
