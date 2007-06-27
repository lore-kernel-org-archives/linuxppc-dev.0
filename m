Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2E34DDDF7E
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2007 11:16:51 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 07/15] [POWERPC] Removed remnants of bus_offset
Date: Tue, 26 Jun 2007 20:16:37 -0500
Message-Id: <1182907014549-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1182907013252-git-send-email-galak@kernel.crashing.org>
References: <11829070051484-git-send-email-galak@kernel.crashing.org>
	<11829070063989-git-send-email-galak@kernel.crashing.org>
	<11829070073637-git-send-email-galak@kernel.crashing.org>
	<11829070091056-git-send-email-galak@kernel.crashing.org>
	<11829070102887-git-send-email-galak@kernel.crashing.org>
	<11829070111239-git-send-email-galak@kernel.crashing.org>
	<1182907013252-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Removed the remants of bus_offset and use self_busno in the mv64x60 case
and use pci_assign_all_buses on 83xx/85xx.

83xx/85xx have multiple PHBs and the firmwares on these devices tend not
to handle topologies with P2P bridges well so we let Linux just reassign
the bus numbers to match.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/83xx/pci.c  |    2 +-
 arch/powerpc/platforms/85xx/pci.c  |    2 +-
 arch/powerpc/sysdev/indirect_pci.c |    4 ++--
 arch/powerpc/sysdev/mv64x60_pci.c  |    2 +-
 include/asm-ppc/pci-bridge.h       |    1 +
 5 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/pci.c b/arch/powerpc/platforms/83xx/pci.c
index 8da935c..f49ed27 100644
--- a/arch/powerpc/platforms/83xx/pci.c
+++ b/arch/powerpc/platforms/83xx/pci.c
@@ -61,6 +61,7 @@ int __init mpc83xx_add_bridge(struct device_node *dev)
 		       " bus 0\n", dev->full_name);
 	}
 
+	pci_assign_all_buses = 1;
 	hose = pcibios_alloc_controller();
 	if (!hose)
 		return -ENOMEM;
@@ -80,7 +81,6 @@ int __init mpc83xx_add_bridge(struct device_node *dev)
 	if ((rsrc.start & 0xfffff) == 0x8600) {
 		setup_indirect_pci(hose, immr + 0x8380, immr + 0x8384);
 		primary = 0;
-		hose->bus_offset = hose->first_busno;
 	}
 
 	printk(KERN_INFO "Found MPC83xx PCI host bridge at 0x%016llx. "
diff --git a/arch/powerpc/platforms/85xx/pci.c b/arch/powerpc/platforms/85xx/pci.c
index be67f67..a25b3e7 100644
--- a/arch/powerpc/platforms/85xx/pci.c
+++ b/arch/powerpc/platforms/85xx/pci.c
@@ -55,6 +55,7 @@ int __init mpc85xx_add_bridge(struct device_node *dev)
 		       " bus 0\n", dev->full_name);
 	}
 
+	pci_assign_all_buses = 1;
 	hose = pcibios_alloc_controller();
 	if (!hose)
 		return -ENOMEM;
@@ -71,7 +72,6 @@ int __init mpc85xx_add_bridge(struct device_node *dev)
 	if ((rsrc.start & 0xfffff) == 0x9000) {
 		setup_indirect_pci(hose, immr + 0x9000, immr + 0x9004);
 		primary = 0;
-		hose->bus_offset = hose->first_busno;
 	}
 
 	printk(KERN_INFO "Found MPC85xx PCI host bridge at 0x%016llx. "
diff --git a/arch/powerpc/sysdev/indirect_pci.c b/arch/powerpc/sysdev/indirect_pci.c
index d490e71..efe3cff 100644
--- a/arch/powerpc/sysdev/indirect_pci.c
+++ b/arch/powerpc/sysdev/indirect_pci.c
@@ -44,7 +44,7 @@ indirect_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
 			cfg_type = 1;
 
 	bus_no = (bus->number == hose->first_busno) ?
-			hose->self_busno : bus->number - hose->bus_offset;
+			hose->self_busno : bus->number;
 
 	PCI_CFG_OUT(hose->cfg_addr,
 		 (0x80000000 | (bus_no << 16)
@@ -87,7 +87,7 @@ indirect_write_config(struct pci_bus *bus, unsigned int devfn, int offset,
 			cfg_type = 1;
 
 	bus_no = (bus->number == hose->first_busno) ?
-			hose->self_busno : bus->number - hose->bus_offset;
+			hose->self_busno : bus->number;
 
 	PCI_CFG_OUT(hose->cfg_addr,
 		 (0x80000000 | (bus_no << 16)
diff --git a/arch/powerpc/sysdev/mv64x60_pci.c b/arch/powerpc/sysdev/mv64x60_pci.c
index 6b08e76..2e77384 100644
--- a/arch/powerpc/sysdev/mv64x60_pci.c
+++ b/arch/powerpc/sysdev/mv64x60_pci.c
@@ -147,7 +147,7 @@ static int __init mv64x60_add_bridge(struct device_node *dev)
 	hose->last_busno = bus_range ? bus_range[1] : 0xff;
 
 	setup_indirect_pci(hose, rsrc.start, rsrc.start + 4);
-	hose->bus_offset = hose->first_busno;
+	hose->self_busno = hose->first_busno;
 
 	printk(KERN_INFO "Found MV64x60 PCI host bridge at 0x%016llx. "
 	       "Firmware bus number: %d->%d\n",
diff --git a/include/asm-ppc/pci-bridge.h b/include/asm-ppc/pci-bridge.h
index 2c2abda..70aab66 100644
--- a/include/asm-ppc/pci-bridge.h
+++ b/include/asm-ppc/pci-bridge.h
@@ -48,6 +48,7 @@ struct pci_controller {
 	int first_busno;
 	int last_busno;
 	int self_busno;
+	/* bus_offset is only used by ARCH=ppc */
 	int bus_offset;
 
 	void __iomem *io_base_virt;
-- 
1.5.2.1
