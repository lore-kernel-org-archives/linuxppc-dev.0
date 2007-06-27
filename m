Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C4BDFDDF47
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2007 11:16:50 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 06/15] [POWERPC] Added self_busno to indicate which bus number
	the PHB is
Date: Tue, 26 Jun 2007 20:16:36 -0500
Message-Id: <1182907013252-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <11829070111239-git-send-email-galak@kernel.crashing.org>
References: <11829070051484-git-send-email-galak@kernel.crashing.org>
	<11829070063989-git-send-email-galak@kernel.crashing.org>
	<11829070073637-git-send-email-galak@kernel.crashing.org>
	<11829070091056-git-send-email-galak@kernel.crashing.org>
	<11829070102887-git-send-email-galak@kernel.crashing.org>
	<11829070111239-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Added self_busno to pci_controller and indirect PCI ops to be set by
board code to indicate which bus number to use when talking to the PHB.
By default we use zero since the majority of controllers that have
implicit mechanisms to talk to the PHBs use a bus number of zero.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/sysdev/indirect_pci.c |   12 ++++++++++--
 include/asm-ppc/pci-bridge.h       |    1 +
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/indirect_pci.c b/arch/powerpc/sysdev/indirect_pci.c
index 3dedf8f..d490e71 100644
--- a/arch/powerpc/sysdev/indirect_pci.c
+++ b/arch/powerpc/sysdev/indirect_pci.c
@@ -33,6 +33,7 @@ indirect_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
 	struct pci_controller *hose = bus->sysdata;
 	volatile void __iomem *cfg_data;
 	u8 cfg_type = 0;
+	u32 bus_no;
 
 	if (ppc_md.pci_exclude_device)
 		if (ppc_md.pci_exclude_device(hose, bus->number, devfn))
@@ -42,8 +43,11 @@ indirect_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
 		if (bus->number != hose->first_busno)
 			cfg_type = 1;
 
+	bus_no = (bus->number == hose->first_busno) ?
+			hose->self_busno : bus->number - hose->bus_offset;
+
 	PCI_CFG_OUT(hose->cfg_addr,
-		 (0x80000000 | ((bus->number - hose->bus_offset) << 16)
+		 (0x80000000 | (bus_no << 16)
 		  | (devfn << 8) | ((offset & 0xfc) | cfg_type)));
 
 	/*
@@ -72,6 +76,7 @@ indirect_write_config(struct pci_bus *bus, unsigned int devfn, int offset,
 	struct pci_controller *hose = bus->sysdata;
 	volatile void __iomem *cfg_data;
 	u8 cfg_type = 0;
+	u32 bus_no;
 
 	if (ppc_md.pci_exclude_device)
 		if (ppc_md.pci_exclude_device(hose, bus->number, devfn))
@@ -81,8 +86,11 @@ indirect_write_config(struct pci_bus *bus, unsigned int devfn, int offset,
 		if (bus->number != hose->first_busno)
 			cfg_type = 1;
 
+	bus_no = (bus->number == hose->first_busno) ?
+			hose->self_busno : bus->number - hose->bus_offset;
+
 	PCI_CFG_OUT(hose->cfg_addr,
-		 (0x80000000 | ((bus->number - hose->bus_offset) << 16)
+		 (0x80000000 | (bus_no << 16)
 		  | (devfn << 8) | ((offset & 0xfc) | cfg_type)));
 
 	/*
diff --git a/include/asm-ppc/pci-bridge.h b/include/asm-ppc/pci-bridge.h
index 4d35b84..2c2abda 100644
--- a/include/asm-ppc/pci-bridge.h
+++ b/include/asm-ppc/pci-bridge.h
@@ -47,6 +47,7 @@ struct pci_controller {
 
 	int first_busno;
 	int last_busno;
+	int self_busno;
 	int bus_offset;
 
 	void __iomem *io_base_virt;
-- 
1.5.2.1
