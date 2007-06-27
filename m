Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 383B8DDFF3
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2007 11:17:00 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 10/15] [POWERPC] Added indirect_type to handle variants of PCI
	ops
Date: Tue, 26 Jun 2007 20:16:40 -0500
Message-Id: <1182907020965-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <11829070192461-git-send-email-galak@kernel.crashing.org>
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
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The generic PCI config ops indirect support for ppc32 covers only two
cases (implicit vs explicit) type 0/1 config cycles via set_cfg_type.
Added a indirect_type bit mask to handle other variants.

Added support for PCI-e extended registers and moved the cfg_type
handling into the bit mask for ARCH=powerpc.  We can also use this to
handle indirect quirks.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/sysdev/indirect_pci.c |   22 ++++++++++++++++------
 include/asm-ppc/pci-bridge.h       |   10 ++++++++++
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/sysdev/indirect_pci.c b/arch/powerpc/sysdev/indirect_pci.c
index efe3cff..3a16122 100644
--- a/arch/powerpc/sysdev/indirect_pci.c
+++ b/arch/powerpc/sysdev/indirect_pci.c
@@ -33,22 +33,27 @@ indirect_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
 	struct pci_controller *hose = bus->sysdata;
 	volatile void __iomem *cfg_data;
 	u8 cfg_type = 0;
-	u32 bus_no;
+	u32 bus_no, reg;
 
 	if (ppc_md.pci_exclude_device)
 		if (ppc_md.pci_exclude_device(hose, bus->number, devfn))
 			return PCIBIOS_DEVICE_NOT_FOUND;
 	
-	if (hose->set_cfg_type)
+	if (hose->indirect_type & PPC_INDIRECT_TYPE_SET_CFG_TYPE)
 		if (bus->number != hose->first_busno)
 			cfg_type = 1;
 
 	bus_no = (bus->number == hose->first_busno) ?
 			hose->self_busno : bus->number;
 
+	if (hose->indirect_type & PPC_INDIRECT_TYPE_EXT_REG)
+		reg = ((offset & 0xf00) << 16) | (offset & 0xfc);
+	else
+		reg = offset & 0xfc;
+
 	PCI_CFG_OUT(hose->cfg_addr,
 		 (0x80000000 | (bus_no << 16)
-		  | (devfn << 8) | ((offset & 0xfc) | cfg_type)));
+		  | (devfn << 8) | reg | cfg_type));
 
 	/*
 	 * Note: the caller has already checked that offset is
@@ -76,22 +81,27 @@ indirect_write_config(struct pci_bus *bus, unsigned int devfn, int offset,
 	struct pci_controller *hose = bus->sysdata;
 	volatile void __iomem *cfg_data;
 	u8 cfg_type = 0;
-	u32 bus_no;
+	u32 bus_no, reg;
 
 	if (ppc_md.pci_exclude_device)
 		if (ppc_md.pci_exclude_device(hose, bus->number, devfn))
 			return PCIBIOS_DEVICE_NOT_FOUND;
 
-	if (hose->set_cfg_type)
+	if (hose->indirect_type & PPC_INDIRECT_TYPE_SET_CFG_TYPE)
 		if (bus->number != hose->first_busno)
 			cfg_type = 1;
 
 	bus_no = (bus->number == hose->first_busno) ?
 			hose->self_busno : bus->number;
 
+	if (hose->indirect_type & PPC_INDIRECT_TYPE_EXT_REG)
+		reg = ((offset & 0xf00) << 16) | (offset & 0xfc);
+	else
+		reg = offset & 0xfc;
+
 	PCI_CFG_OUT(hose->cfg_addr,
 		 (0x80000000 | (bus_no << 16)
-		  | (devfn << 8) | ((offset & 0xfc) | cfg_type)));
+		  | (devfn << 8) | reg | cfg_type));
 
 	/*
 	 * Note: the caller has already checked that offset is
diff --git a/include/asm-ppc/pci-bridge.h b/include/asm-ppc/pci-bridge.h
index 70aab66..0dee56b 100644
--- a/include/asm-ppc/pci-bridge.h
+++ b/include/asm-ppc/pci-bridge.h
@@ -65,9 +65,19 @@ struct pci_controller {
 	/*
 	 * If set, indirect method will set the cfg_type bit as
 	 * needed to generate type 1 configuration transactions.
+	 * use only on ARCH=ppc
 	 */
 	int set_cfg_type;
 
+	/*
+	 * Used for variants of PCI indirect handling and possible quirks:
+	 *  SET_CFG_TYPE - used on 4xx or any PHB that does explicit type0/1
+	 *  EXT_REG - provides access to PCI-e extended registers
+	 */
+#define PPC_INDIRECT_TYPE_SET_CFG_TYPE		(0x00000001)
+#define PPC_INDIRECT_TYPE_EXT_REG		(0x00000002)
+	u32 indirect_type;
+
 	/* Currently, we limit ourselves to 1 IO range and 3 mem
 	 * ranges since the common pci_bus structure can't handle more
 	 */
-- 
1.5.2.1
