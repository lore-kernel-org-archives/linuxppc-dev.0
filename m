Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 444C5DDFF4
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2007 11:17:00 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 12/15] [POWERPC] 86xx: Workaround PCI_PRIMARY_BUS usage
Date: Tue, 26 Jun 2007 20:16:42 -0500
Message-Id: <11829070232635-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <11829070222511-git-send-email-galak@kernel.crashing.org>
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
	<11829070222511-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The Freescale PCI-e controllers have an issue in that they use the
PCI_PRIMARY_BUS register in the virtual P2P bridge to determine which
bus number to match on when generating a type 0 config cycle.  The
issue is if we are renumbering bus numbers to match Linux we will try
setting the PCI_PRIMARY_BUS and will not know which bus number to use
for generating type 0 config cycles.  We surpress writing the register
in the P2P bridge and always keep it at zero.

In the future when proper PCI domain support is working we should be
able to remove this.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/86xx/pci.c  |    4 +++-
 arch/powerpc/sysdev/indirect_pci.c |    6 ++++++
 include/asm-ppc/pci-bridge.h       |    5 +++++
 3 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/pci.c b/arch/powerpc/platforms/86xx/pci.c
index 3825e1a..6f3c0f6 100644
--- a/arch/powerpc/platforms/86xx/pci.c
+++ b/arch/powerpc/platforms/86xx/pci.c
@@ -158,11 +158,13 @@ int __init mpc86xx_add_bridge(struct device_node *dev)
 		printk(KERN_WARNING "Can't get bus-range for %s, assume"
 		       " bus 0\n", dev->full_name);
 
+	pci_assign_all_buses = 1;
 	hose = pcibios_alloc_controller();
 	if (!hose)
 		return -ENOMEM;
 	hose->arch_data = dev;
-	hose->indirect_type = PPC_INDIRECT_TYPE_EXT_REG;
+	hose->indirect_type = PPC_INDIRECT_TYPE_EXT_REG |
+				PPC_INDIRECT_TYPE_SURPRESS_PRIMARY_BUS;
 
 	hose->first_busno = bus_range ? bus_range[0] : 0x0;
 	hose->last_busno = bus_range ? bus_range[1] : 0xff;
diff --git a/arch/powerpc/sysdev/indirect_pci.c b/arch/powerpc/sysdev/indirect_pci.c
index 3a16122..c7e6e85 100644
--- a/arch/powerpc/sysdev/indirect_pci.c
+++ b/arch/powerpc/sysdev/indirect_pci.c
@@ -103,6 +103,12 @@ indirect_write_config(struct pci_bus *bus, unsigned int devfn, int offset,
 		 (0x80000000 | (bus_no << 16)
 		  | (devfn << 8) | reg | cfg_type));
 
+	/* surpress setting of PCI_PRIMARY_BUS */
+	if (hose->indirect_type & PPC_INDIRECT_TYPE_SURPRESS_PRIMARY_BUS)
+		if ((offset == PCI_PRIMARY_BUS) &&
+			(bus->number == hose->first_busno))
+		val &= 0xffffff00;
+
 	/*
 	 * Note: the caller has already checked that offset is
 	 * suitably aligned and that len is 1, 2 or 4.
diff --git a/include/asm-ppc/pci-bridge.h b/include/asm-ppc/pci-bridge.h
index 0dee56b..c09fbf0 100644
--- a/include/asm-ppc/pci-bridge.h
+++ b/include/asm-ppc/pci-bridge.h
@@ -73,9 +73,14 @@ struct pci_controller {
 	 * Used for variants of PCI indirect handling and possible quirks:
 	 *  SET_CFG_TYPE - used on 4xx or any PHB that does explicit type0/1
 	 *  EXT_REG - provides access to PCI-e extended registers
+	 *  SURPRESS_PRIMARY_BUS - we surpress the setting of PCI_PRIMARY_BUS
+	 *   on Freescale PCI-e controllers since they used the PCI_PRIMARY_BUS
+	 *   to determine which bus number to match on when generating type0
+	 *   config cycles
 	 */
 #define PPC_INDIRECT_TYPE_SET_CFG_TYPE		(0x00000001)
 #define PPC_INDIRECT_TYPE_EXT_REG		(0x00000002)
+#define PPC_INDIRECT_TYPE_SURPRESS_PRIMARY_BUS	(0x00000004)
 	u32 indirect_type;
 
 	/* Currently, we limit ourselves to 1 IO range and 3 mem
-- 
1.5.2.1
