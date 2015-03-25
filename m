Return-Path: <dja@axtens.net>
Received: from mail-pd0-x22c.google.com (mail-pd0-x22c.google.com
 [IPv6:2607:f8b0:400e:c02::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 200501A09DD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 16:37:24 +1100 (AEDT)
Received: by pdnc3 with SMTP id c3so17207446pdn.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 22:37:22 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 24/27] powerpc: Remove shim for pci_controller_ops.probe_mode
Date: Wed, 25 Mar 2015 16:35:58 +1100
Message-Id: <1427261761-22952-25-git-send-email-dja@axtens.net>
In-Reply-To: <1427261761-22952-1-git-send-email-dja@axtens.net>
References: <1427261761-22952-1-git-send-email-dja@axtens.net>
Cc: Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This also moves back the defines, as explained in the commit that
created the shim.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/include/asm/machdep.h    |  1 -
 arch/powerpc/include/asm/pci-bridge.h | 16 ----------------
 arch/powerpc/include/asm/pci.h        |  5 +++++
 arch/powerpc/kernel/pci-common.c      |  4 ++--
 arch/powerpc/kernel/pci-hotplug.c     |  6 +++++-
 arch/powerpc/kernel/pci_of_scan.c     |  6 +++++-
 6 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 5549b6c..dfc8d2b 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -127,7 +127,6 @@ struct machdep_calls {
 	/* PCI stuff */
 	/* Called after scanning the bus, before allocating resources */
 	void		(*pcibios_fixup)(void);
-	int		(*pci_probe_mode)(struct pci_bus *);
 	void		(*pci_irq_fixup)(struct pci_dev *dev);
 	int		(*pcibios_root_bridge_prepare)(struct pci_host_bridge
 				*bridge);
diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 029def0..b5d8631 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -12,11 +12,6 @@
 #include <linux/ioport.h>
 #include <asm-generic/pci-bridge.h>
 
-/* Return values for pci_controller_ops.probe_mode function */
-#define PCI_PROBE_NONE		-1	/* Don't look at this bus at all */
-#define PCI_PROBE_NORMAL	0	/* Do normal PCI probing */
-#define PCI_PROBE_DEVTREE	1	/* Instantiate from device tree */
-
 struct device_node;
 
 /*
@@ -305,16 +300,5 @@ static inline void dma_bus_setup(struct pci_bus *bus)
 		ppc_md.pci_dma_bus_setup(bus);
 }
 
-static inline int probe_mode(struct pci_bus *bus)
-{
-	struct pci_controller *hose = pci_bus_to_host(bus);
-
-	if (hose->controller_ops.probe_mode)
-		return hose->controller_ops.probe_mode(bus);
-	if (ppc_md.pci_probe_mode)
-		return ppc_md.pci_probe_mode(bus);
-	return PCI_PROBE_NORMAL;
-}
-
 #endif	/* __KERNEL__ */
 #endif	/* _ASM_POWERPC_PCI_BRIDGE_H */
diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index 8745067..4aef8d6 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -22,6 +22,11 @@
 
 #include <asm-generic/pci-dma-compat.h>
 
+/* Return values for pci_controller_ops.probe_mode function */
+#define PCI_PROBE_NONE		-1	/* Don't look at this bus at all */
+#define PCI_PROBE_NORMAL	0	/* Do normal PCI probing */
+#define PCI_PROBE_DEVTREE	1	/* Instantiate from device tree */
+
 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		0x10000000
 
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 5b90e99c..a61ecb4 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1628,8 +1628,8 @@ void pcibios_scan_phb(struct pci_controller *hose)
 
 	/* Get probe mode and perform scan */
 	mode = PCI_PROBE_NORMAL;
-	if (node)
-		mode = probe_mode(bus);
+	if (node && hose->controller_ops.probe_mode)
+		mode = hose->controller_ops.probe_mode(bus);
 	pr_debug("    probe mode: %d\n", mode);
 	if (mode == PCI_PROBE_DEVTREE)
 		of_scan_bus(node, bus);
diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
index 504d823..e9b0a4a 100644
--- a/arch/powerpc/kernel/pci-hotplug.c
+++ b/arch/powerpc/kernel/pci-hotplug.c
@@ -73,12 +73,16 @@ void pcibios_add_pci_devices(struct pci_bus * bus)
 {
 	int slotno, mode, pass, max;
 	struct pci_dev *dev;
+	struct pci_controller *hose;
 	struct device_node *dn = pci_bus_to_OF_node(bus);
 
 	eeh_add_device_tree_early(dn);
 
+	hose = pci_bus_to_host(bus);
+
 	mode = PCI_PROBE_NORMAL;
-	mode = probe_mode(bus);
+	if (hose->controller_ops.probe_mode)
+		mode = hose->controller_ops.probe_mode(bus);
 
 	if (mode == PCI_PROBE_DEVTREE) {
 		/* use ofdt-based probe */
diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index ae1767b..8312962 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -207,6 +207,7 @@ void of_scan_pci_bridge(struct pci_dev *dev)
 {
 	struct device_node *node = dev->dev.of_node;
 	struct pci_bus *bus;
+	struct pci_controller *hose;
 	const __be32 *busrange, *ranges;
 	int len, i, mode;
 	struct pci_bus_region region;
@@ -286,8 +287,11 @@ void of_scan_pci_bridge(struct pci_dev *dev)
 		bus->number);
 	pr_debug("    bus name: %s\n", bus->name);
 
+	hose = pci_bus_to_host(bus);
+
 	mode = PCI_PROBE_NORMAL;
-	mode = probe_mode(bus);
+	if (hose->controller_ops.probe_mode)
+		mode = hose->controller_ops.probe_mode(bus);
 	pr_debug("    probe mode: %d\n", mode);
 
 	if (mode == PCI_PROBE_DEVTREE)
-- 
2.1.4
