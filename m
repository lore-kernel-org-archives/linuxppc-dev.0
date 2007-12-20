Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 20 Dec 2007 14:55:01 +1100
Subject: [PATCH 16/19] [POWERPC] Enable self-view of the HT host bridge on
	PowerMac G5
In-Reply-To: <1198122881.874131.56762399546.qpush@grosgo>
Message-Id: <20071220035503.B7A8CDDE42@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This enables the PCI code to see the device that represents the
HT host bridge on the PowerMac G5.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/platforms/powermac/pci.c   |   54 ++++++++++++++++++++------------
 arch/powerpc/platforms/powermac/setup.c |    4 +-
 2 files changed, 38 insertions(+), 20 deletions(-)

--- linux-merge.orig/arch/powerpc/platforms/powermac/pci.c	2007-12-19 15:47:23.000000000 +1100
+++ linux-merge/arch/powerpc/platforms/powermac/pci.c	2007-12-19 15:50:46.000000000 +1100
@@ -314,10 +314,13 @@ static int u3_ht_skip_device(struct pci_
 
 	/* We only allow config cycles to devices that are in OF device-tree
 	 * as we are apparently having some weird things going on with some
-	 * revs of K2 on recent G5s
+	 * revs of K2 on recent G5s, except for the host bridge itself, which
+	 * is missing from the tree but we know we can probe.
 	 */
 	if (bus->self)
 		busdn = pci_device_to_OF_node(bus->self);
+	else if (devfn == 0)
+		return 0;
 	else
 		busdn = hose->dn;
 	for (dn = busdn->child; dn; dn = dn->sibling)
@@ -344,14 +347,15 @@ static int u3_ht_skip_device(struct pci_
 		+ (((unsigned int)bus) << 16) \
 		+ 0x01000000UL)
 
-static volatile void __iomem *u3_ht_cfg_access(struct pci_controller* hose,
-					     u8 bus, u8 devfn, u8 offset)
+static void __iomem *u3_ht_cfg_access(struct pci_controller *hose, u8 bus,
+				      u8 devfn, u8 offset, int *swap)
 {
+	*swap = 1;
 	if (bus == hose->first_busno) {
-		/* For now, we don't self probe U3 HT bridge */
-		if (PCI_SLOT(devfn) == 0)
-			return NULL;
-		return hose->cfg_data + U3_HT_CFA0(devfn, offset);
+		if (devfn != 0)
+			return hose->cfg_data + U3_HT_CFA0(devfn, offset);
+		*swap = 0;
+		return ((void __iomem *)hose->cfg_addr) + (offset << 2);
 	} else
 		return hose->cfg_data + U3_HT_CFA1(bus, devfn, offset);
 }
@@ -360,14 +364,15 @@ static int u3_ht_read_config(struct pci_
 				    int offset, int len, u32 *val)
 {
 	struct pci_controller *hose;
-	volatile void __iomem *addr;
+	void __iomem *addr;
+	int swap;
 
 	hose = pci_bus_to_host(bus);
 	if (hose == NULL)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	if (offset >= 0x100)
 		return  PCIBIOS_BAD_REGISTER_NUMBER;
-	addr = u3_ht_cfg_access(hose, bus->number, devfn, offset);
+	addr = u3_ht_cfg_access(hose, bus->number, devfn, offset, &swap);
 	if (!addr)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
@@ -397,10 +402,10 @@ static int u3_ht_read_config(struct pci_
 		*val = in_8(addr);
 		break;
 	case 2:
-		*val = in_le16(addr);
+		*val = swap ? in_le16(addr) : in_be16(addr);
 		break;
 	default:
-		*val = in_le32(addr);
+		*val = swap ? in_le32(addr) : in_be32(addr);
 		break;
 	}
 	return PCIBIOS_SUCCESSFUL;
@@ -410,14 +415,15 @@ static int u3_ht_write_config(struct pci
 				     int offset, int len, u32 val)
 {
 	struct pci_controller *hose;
-	volatile void __iomem *addr;
+	void __iomem *addr;
+	int swap;
 
 	hose = pci_bus_to_host(bus);
 	if (hose == NULL)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	if (offset >= 0x100)
 		return  PCIBIOS_BAD_REGISTER_NUMBER;
-	addr = u3_ht_cfg_access(hose, bus->number, devfn, offset);
+	addr = u3_ht_cfg_access(hose, bus->number, devfn, offset, &swap);
 	if (!addr)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
@@ -439,10 +445,10 @@ static int u3_ht_write_config(struct pci
 		out_8(addr, val);
 		break;
 	case 2:
-		out_le16(addr, val);
+		swap ? out_le16(addr, val) : out_be16(addr, val);
 		break;
 	default:
-		out_le32((u32 __iomem *)addr, val);
+		swap ? out_le32(addr, val) : out_be32(addr, val);
 		break;
 	}
 	return PCIBIOS_SUCCESSFUL;
@@ -780,16 +786,26 @@ static void __init setup_u3_ht(struct pc
 {
 	struct device_node *np = hose->dn;
 	struct pci_controller *other = NULL;
+	struct resource cfg_res, self_res;
 	int i, cur;
 
 
 	hose->ops = &u3_ht_pci_ops;
 
-	/* We hard code the address because of the different size of
-	 * the reg address cell, we shall fix that by killing struct
-	 * reg_property and using some accessor functions instead
+	/* Get base addresses from OF tree
+	 */
+	if (of_address_to_resource(np, 0, &cfg_res) ||
+	    of_address_to_resource(np, 1, &self_res)) {
+		printk(KERN_ERR "PCI: Failed to get U3/U4 HT resources !\n");
+		return;
+	}
+
+	/* Map external cfg space access into cfg_data and self registers
+	 * into cfg_addr
 	 */
-	hose->cfg_data = ioremap(0xf2000000, 0x02000000);
+	hose->cfg_data = ioremap(cfg_res.start, 0x02000000);
+	hose->cfg_addr = ioremap(self_res.start,
+				 self_res.end - self_res.start + 1);
 
 	/*
 	 * /ht node doesn't expose a "ranges" property, so we "remove"
Index: linux-merge/arch/powerpc/platforms/powermac/setup.c
===================================================================
--- linux-merge.orig/arch/powerpc/platforms/powermac/setup.c	2007-12-19 15:45:18.000000000 +1100
+++ linux-merge/arch/powerpc/platforms/powermac/setup.c	2007-12-19 15:47:24.000000000 +1100
@@ -613,9 +613,11 @@ static int pmac_pci_probe_mode(struct pc
 
 	/* We need to use normal PCI probing for the AGP bus,
 	 * since the device for the AGP bridge isn't in the tree.
+	 * Same for the PCIe host on U4 and the HT host bridge.
 	 */
 	if (bus->self == NULL && (of_device_is_compatible(node, "u3-agp") ||
-				  of_device_is_compatible(node, "u4-pcie")))
+				  of_device_is_compatible(node, "u4-pcie") ||
+				  of_device_is_compatible(node, "u3-ht")))
 		return PCI_PROBE_NORMAL;
 	return PCI_PROBE_DEVTREE;
 }
