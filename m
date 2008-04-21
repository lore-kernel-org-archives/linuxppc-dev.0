Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id D0FC9DE899
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 01:05:23 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] [POWERPC] 4xx: Add endpoint support to 4xx PCIe driver
Date: Mon, 21 Apr 2008 16:54:30 +0200
Message-Id: <1208789670-28909-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds basic endpoint support to the 4xx PCIe driver.

This is done by checking the device_type property of the PCIe
device node ("pci" for root-complex and "pci-endpoint" for endpoint
configuration).

Note: Currently we map a fixed 64MByte window to PLB address 0 (SDRAM).
This should probably be configurable via a dts property.

Signed-off-by: Stefan Roese <sr@denx.de>
---
Changes in v2:
--------------
- As suggested by Benjamin Herrenschmidt, don't determine endpoint mode
  by looking at the already configured PCIe port state, but evaluate
  the device_type property instead. This makes it possible for boards
  without a previously run PCIe configuration (e.g. U-Boot) to configure
  a port as endpoint as well.

- Don't map the big external config space upon endpoint configuration.

- Introduce "vendor-id" and "device-id" properties to be written to
  the host bridge.

 arch/powerpc/sysdev/ppc4xx_pci.c |  180 +++++++++++++++++++++++++++----------
 1 files changed, 131 insertions(+), 49 deletions(-)

diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_pci.c
index 1087196..acdc309 100644
--- a/arch/powerpc/sysdev/ppc4xx_pci.c
+++ b/arch/powerpc/sysdev/ppc4xx_pci.c
@@ -1390,28 +1390,59 @@ static void __init ppc4xx_configure_pciex_PIMs(struct ppc4xx_pciex_port *port,
 	resource_size_t size = res->end - res->start + 1;
 	u64 sa;
 
-	/* Calculate window size */
-	sa = (0xffffffffffffffffull << ilog2(size));;
-	if (res->flags & IORESOURCE_PREFETCH)
-		sa |= 0x8;
+	if (port->endpoint) {
+		resource_size_t ep_addr = 0;
+		resource_size_t ep_size = 32 << 20;
+
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
 
-	out_le32(mbase + PECFG_BAR0HMPA, RES_TO_U32_HIGH(sa));
-	out_le32(mbase + PECFG_BAR0LMPA, RES_TO_U32_LOW(sa));
+		/* Disable BAR1 & BAR2 */
+		out_le32(mbase + PECFG_BAR1MPA, 0);
+		out_le32(mbase + PECFG_BAR2HMPA, 0);
+		out_le32(mbase + PECFG_BAR2LMPA, 0);
 
-	/* The setup of the split looks weird to me ... let's see if it works */
-	out_le32(mbase + PECFG_PIM0LAL, 0x00000000);
-	out_le32(mbase + PECFG_PIM0LAH, 0x00000000);
-	out_le32(mbase + PECFG_PIM1LAL, 0x00000000);
-	out_le32(mbase + PECFG_PIM1LAH, 0x00000000);
-	out_le32(mbase + PECFG_PIM01SAH, 0xffff0000);
-	out_le32(mbase + PECFG_PIM01SAL, 0x00000000);
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
@@ -1425,13 +1456,8 @@ static void __init ppc4xx_pciex_port_setup_hose(struct ppc4xx_pciex_port *port)
 	const int *bus_range;
 	int primary = 0, busses;
 	void __iomem *mbase = NULL, *cfg_data = NULL;
-
-	/* XXX FIXME: Handle endpoint mode properly */
-	if (port->endpoint) {
-		printk(KERN_WARNING "PCIE%d: Port in endpoint mode !\n",
-		       port->index);
-		return;
-	}
+	const u32 *pval;
+	u32 val;
 
 	/* Check if primary bridge */
 	if (of_get_property(port->node, "primary", NULL))
@@ -1465,21 +1491,30 @@ static void __init ppc4xx_pciex_port_setup_hose(struct ppc4xx_pciex_port *port)
 		hose->last_busno = hose->first_busno + busses;
 	}
 
-	/* We map the external config space in cfg_data and the host config
-	 * space in cfg_addr. External space is 1M per bus, internal space
-	 * is 4K
+	if (!port->endpoint) {
+		/* Only map the external config space in cfg_data for
+		 * PCIe root-complexes. External space is 1M per bus
+		 */
+		cfg_data = ioremap(port->cfg_space.start +
+				   (hose->first_busno + 1) * 0x100000,
+				   busses * 0x100000);
+		if (cfg_data == NULL) {
+			printk(KERN_ERR "%s: Can't map external config space !",
+			       port->node->full_name);
+			goto fail;
+		}
+		hose->cfg_data = cfg_data;
+	}
+
+	/* Always map the host config space in cfg_addr.
+	 * Internal space is 4K
 	 */
-	cfg_data = ioremap(port->cfg_space.start +
-				 (hose->first_busno + 1) * 0x100000,
-				 busses * 0x100000);
 	mbase = ioremap(port->cfg_space.start + 0x10000000, 0x1000);
-	if (cfg_data == NULL || mbase == NULL) {
-		printk(KERN_ERR "%s: Can't map config space !",
+	if (mbase == NULL) {
+		printk(KERN_ERR "%s: Can't map internal config space !",
 		       port->node->full_name);
 		goto fail;
 	}
-
-	hose->cfg_data = cfg_data;
 	hose->cfg_addr = mbase;
 
 	pr_debug("PCIE %s, bus %d..%d\n", port->node->full_name,
@@ -1492,12 +1527,14 @@ static void __init ppc4xx_pciex_port_setup_hose(struct ppc4xx_pciex_port *port)
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
@@ -1518,17 +1555,49 @@ static void __init ppc4xx_pciex_port_setup_hose(struct ppc4xx_pciex_port *port)
 	ppc4xx_configure_pciex_PIMs(port, hose, mbase, &dma_window);
 
 	/* The root complex doesn't show up if we don't set some vendor
-	 * and device IDs into it. Those are the same bogus one that the
-	 * initial code in arch/ppc add. We might want to change that.
+	 * and device IDs into it. The defaults below are the same bogus
+	 * one that the initial code in arch/ppc had. This can be
+	 * overwritten by setting the "vendor-id/device-id" properties
+	 * in the pciex node.
 	 */
-	out_le16(mbase + 0x200, 0xaaa0 + port->index);
-	out_le16(mbase + 0x202, 0xbed0 + port->index);
 
-	/* Set Class Code to PCI-PCI bridge and Revision Id to 1 */
-	out_le32(mbase + 0x208, 0x06040001);
+	/* Get the (optional) vendor-/device-id from the device-tree */
+	pval = of_get_property(port->node, "vendor-id", NULL);
+	if (pval) {
+		val = *pval;
+	} else {
+		if (!port->endpoint)
+			val = 0xaaa0 + port->index;
+		else
+			val = 0xeee0 + port->index;
+	}
+	out_le16(mbase + 0x200, val);
+
+	pval = of_get_property(port->node, "device-id", NULL);
+	if (pval) {
+		val = *pval;
+	} else {
+		if (!port->endpoint)
+			val = 0xbed0 + port->index;
+		else
+			val = 0xfed0 + port->index;
+	}
+	out_le16(mbase + 0x202, val);
+
+	if (!port->endpoint) {
+		/* Set Class Code to PCI-PCI bridge and Revision Id to 1 */
+		out_le32(mbase + 0x208, 0x06040001);
+
+		printk(KERN_INFO "PCIE%d: successfully set as root-complex\n",
+		       port->index);
+	} else {
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
@@ -1545,6 +1614,7 @@ static void __init ppc4xx_probe_pciex_bridge(struct device_node *np)
 	const u32 *pval;
 	int portno;
 	unsigned int dcrs;
+	const char *val;
 
 	/* First, proceed to core initialization as we assume there's
 	 * only one PCIe core in the system
@@ -1576,8 +1646,20 @@ static void __init ppc4xx_probe_pciex_bridge(struct device_node *np)
 	}
 	port->sdr_base = *pval;
 
-	/* XXX Currently, we only support root complex mode */
-	port->endpoint = 0;
+	/* Check if device_type property is set to "pci" or "pci-endpoint".
+	 * Resulting from this setup this PCIe port will be configured
+	 * as root-complex or as endpoint.
+	 */
+	val = of_get_property(port->node, "device_type", NULL);
+	if (!strcmp(val, "pci-endpoint")) {
+		port->endpoint = 1;
+	} else if (!strcmp(val, "pci")) {
+		port->endpoint = 0;
+	} else {
+		printk(KERN_ERR "PCIE: missing or incorrect device_type for %s\n",
+		       np->full_name);
+		return;
+	}
 
 	/* Fetch config space registers address */
 	if (of_address_to_resource(np, 0, &port->cfg_space)) {
-- 
1.5.5
