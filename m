Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C72A5DDE2D
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jun 2007 23:40:13 +1000 (EST)
Date: Fri, 22 Jun 2007 08:40:12 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: RFC: Add indirect variants to pci indirect
Message-ID: <Pine.LNX.4.64.0706220839420.1470@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Wei.Zhang@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben,

I wanted to get your feedback on this approach for handling the variants
of pci indirect that we have on Freescale parts.

The idea is hose->indirect_type is a bit mask of 'features'.  I'm not sure
if PPC_INDIRECT_TYPE_PHB_IS_ZERO is the best name and if we could get ride
of bus_offset all together.

It was pointed out that a system that doesn't care about X that has
multiple PHBs may assign PCI bus # as hose0: bus0-4, hose1: 0-3.

- k

diff --git a/arch/powerpc/sysdev/indirect_pci.c b/arch/powerpc/sysdev/indirect_pci.c
index e4f6c67..b18fa53 100644
--- a/arch/powerpc/sysdev/indirect_pci.c
+++ b/arch/powerpc/sysdev/indirect_pci.c
@@ -33,6 +33,7 @@ indirect_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
 	struct pci_controller *hose = bus->sysdata;
 	volatile void __iomem *cfg_data;
 	u8 cfg_type = 0;
+	u32 bus_no, reg;

 	if (ppc_md.pci_exclude_device)
 		if (ppc_md.pci_exclude_device(hose, bus->number, devfn))
@@ -42,9 +43,18 @@ indirect_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
 		if (bus->number != hose->first_busno)
 			cfg_type = 1;

-	PCI_CFG_OUT(hose->cfg_addr,
-		 (0x80000000 | ((bus->number - hose->bus_offset) << 16)
-		  | (devfn << 8) | ((offset & 0xfc) | cfg_type)));
+	if (hose->indirect_type & PPC_INDIRECT_TYPE_PHB_IS_ZERO)
+		bus_no = bus->number == hose->first_busno ? 0 : bus->number;
+	else
+		bus_no = bus->number - hose->bus_offset;
+
+	if (hose->set_cfg_type & PPC_INDIRECT_TYPE_EXT_REG)
+		reg = ((offset & 0xf00) << 16) | (offset & 0xfc);
+	else
+		reg = offset & 0xfc;
+
+	PCI_CFG_OUT(hose->cfg_addr,
+                 (0x80000000 | bus_no | (devfn << 8) | reg | cfg_type));

 	/*
 	 * Note: the caller has already checked that offset is
@@ -72,6 +82,7 @@ indirect_write_config(struct pci_bus *bus, unsigned int devfn, int offset,
 	struct pci_controller *hose = bus->sysdata;
 	volatile void __iomem *cfg_data;
 	u8 cfg_type = 0;
+	u32 bus_no, reg;

 	if (ppc_md.pci_exclude_device)
 		if (ppc_md.pci_exclude_device(hose, bus->number, devfn))
@@ -81,9 +92,23 @@ indirect_write_config(struct pci_bus *bus, unsigned int devfn, int offset,
 		if (bus->number != hose->first_busno)
 			cfg_type = 1;

-	PCI_CFG_OUT(hose->cfg_addr,
-		 (0x80000000 | ((bus->number - hose->bus_offset) << 16)
-		  | (devfn << 8) | ((offset & 0xfc) | cfg_type)));
+	if (hose->indirect_type & PPC_INDIRECT_TYPE_PHB_IS_ZERO)
+		bus_no = bus->number == hose->first_busno ? 0 : bus->number;
+	else
+		bus_no = bus->number - hose->bus_offset;
+
+	if (hose->set_cfg_type & PPC_INDIRECT_TYPE_EXT_REG)
+		reg = ((offset & 0xf00) << 16) | (offset & 0xfc);
+	else
+		reg = offset & 0xfc;
+
+	PCI_CFG_OUT(hose->cfg_addr,
+                 (0x80000000 | bus_no | (devfn << 8) | reg | cfg_type));
+
+	if (hose->indirect_type & PPC_INDIRECT_TYPE_FSL_PCIE_HACK)
+		if ((offset == PCI_PRIMARY_BUS) &&
+			(bus->number == hose->first_busno))
+		val &= 0xffffff00;

 	/*
 	 * Note: the caller has already checked that offset is
diff --git a/include/asm-ppc/pci-bridge.h b/include/asm-ppc/pci-bridge.h
index 4d35b84..2f6651d 100644
--- a/include/asm-ppc/pci-bridge.h
+++ b/include/asm-ppc/pci-bridge.h
@@ -66,6 +66,15 @@ struct pci_controller {
 	 */
 	int set_cfg_type;

+	/*
+	 * If set, indirect method will set the cfg_type bit as
+	 * needed to generate type 1 configuration transactions.
+	 */
+#define PPC_INDIRECT_TYPE_PHB_IS_ZERO		(0x00000001)
+#define PPC_INDIRECT_TYPE_EXT_REG		(0x00000002)
+#define PPC_INDIRECT_TYPE_FSL_PCIE_HACK		(0x00000004)
+	u32 indirect_type;
+
 	/* Currently, we limit ourselves to 1 IO range and 3 mem
 	 * ranges since the common pci_bus structure can't handle more
 	 */
