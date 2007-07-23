Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6D340DDF40
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 06:51:06 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH 16/25] [POWERPC] Provide ability to setup P2P bridge registers
	from struct resource
Date: Mon, 23 Jul 2007 15:50:03 -0500
Message-Id: <11852238362041-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <11852238353292-git-send-email-galak@kernel.crashing.org>
References: <11852238122538-git-send-email-galak@kernel.crashing.org>
	<1185223813693-git-send-email-galak@kernel.crashing.org>
	<11852238151983-git-send-email-galak@kernel.crashing.org>
	<11852238161546-git-send-email-galak@kernel.crashing.org>
	<1185223818821-git-send-email-galak@kernel.crashing.org>
	<11852238193371-git-send-email-galak@kernel.crashing.org>
	<1185223821183-git-send-email-galak@kernel.crashing.org>
	<11852238233066-git-send-email-galak@kernel.crashing.org>
	<11852238241475-git-send-email-galak@kernel.crashing.org>
	<11852238253550-git-send-email-galak@kernel.crashing.org>
	<11852238271141-git-send-email-galak@kernel.crashing.org>
	<11852238283648-git-send-email-galak@kernel.crashing.org>
	<1185223830411-git-send-email-galak@kernel.crashing.org>
	<11852238322319-git-send-email-galak@kernel.crashing.org>
	<11852238333649-git-send-email-galak@kernel.crashing.org>
	<11852238353292-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We need the ability to set P2P bridge registers to properly setup the virtual
P2P bridges that exist in PCIe controllers for some of the embedded setups.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/pci_32.c     |   18 ++++++++++++------
 include/asm-powerpc/pci-bridge.h |    2 ++
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index bfcfa14..721a694 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -415,15 +415,13 @@ probe_resource(struct pci_bus *parent, struct resource *pr,
 	return 0;
 }
 
-static void __init
-update_bridge_base(struct pci_bus *bus, int i)
+void __init
+update_bridge_resource(struct pci_dev *dev, struct resource *res)
 {
-	struct resource *res = bus->resource[i];
 	u8 io_base_lo, io_limit_lo;
 	u16 mem_base, mem_limit;
 	u16 cmd;
 	unsigned long start, end, off;
-	struct pci_dev *dev = bus->self;
 	struct pci_controller *hose = dev->sysdata;
 
 	if (!hose) {
@@ -467,12 +465,20 @@ update_bridge_base(struct pci_bus *bus, int i)
 		pci_write_config_word(dev, PCI_PREF_MEMORY_LIMIT, mem_limit);
 
 	} else {
-		DBG(KERN_ERR "PCI: ugh, bridge %s res %d has flags=%lx\n",
-		    pci_name(dev), i, res->flags);
+		DBG(KERN_ERR "PCI: ugh, bridge %s res has flags=%lx\n",
+		    pci_name(dev), res->flags);
 	}
 	pci_write_config_word(dev, PCI_COMMAND, cmd);
 }
 
+static void __init
+update_bridge_base(struct pci_bus *bus, int i)
+{
+	struct resource *res = bus->resource[i];
+	struct pci_dev *dev = bus->self;
+	update_bridge_resource(dev, res);
+}
+
 static inline void alloc_resource(struct pci_dev *dev, int idx)
 {
 	struct resource *pr, *r = &dev->resource[idx];
diff --git a/include/asm-powerpc/pci-bridge.h b/include/asm-powerpc/pci-bridge.h
index 435bfe8..b7d2ea4 100644
--- a/include/asm-powerpc/pci-bridge.h
+++ b/include/asm-powerpc/pci-bridge.h
@@ -93,6 +93,8 @@ extern int early_find_capability(struct pci_controller *hose, int bus,
 extern void setup_indirect_pci(struct pci_controller* hose,
 			       u32 cfg_addr, u32 cfg_data, u32 flags);
 extern void setup_grackle(struct pci_controller *hose);
+extern void __init update_bridge_resource(struct pci_dev *dev,
+					  struct resource *res);
 
 #else
 
-- 
1.5.2.2
