Return-Path: <dja@axtens.net>
Received: from mail-pd0-x229.google.com (mail-pd0-x229.google.com
 [IPv6:2607:f8b0:400e:c02::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9EBF41A06F8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 16:01:38 +1100 (AEDT)
Received: by pdrw1 with SMTP id w1so213669pdr.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 22:01:37 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 06/19] powerpc: Create pci_controller_ops.probe_mode and
 shim
Date: Tue, 31 Mar 2015 16:00:44 +1100
Message-Id: <1427778057-9505-7-git-send-email-dja@axtens.net>
In-Reply-To: <1427778057-9505-1-git-send-email-dja@axtens.net>
References: <1427778057-9505-1-git-send-email-dja@axtens.net>
Cc: Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add pci_controller_ops.probe_mode, shadowing ppc_md.pci_probe_mode.
Add a shim, and changes the callsites to use the shim.

We also need to move the probe mode defines to pci-bridge.h from pci.h.
They are required by the shim in order to return a sensible default.
Previously, the were defined in pci.h, but pci.h includes pci-bridge.h
before the relevant #defines. This means the definitions are absent
if pci.h is included before pci-bridge.h. This occurs in some drivers.
So, move the definitons now, and move them back when we remove the shim.

Anything that wants the defines would have had to include pci.h, and
since pci.h includes pci-bridge.h, nothing will lose access to the
defines.

Signed-off-by: Daniel Axtens <dja@axtens.net>

---

v1 --> v2:
 - Better commit message
 - Use phb in favour of hose
 - Make shim name match ppc_md name, not pci_controller_ops name.
---
 arch/powerpc/include/asm/pci-bridge.h | 18 ++++++++++++++++++
 arch/powerpc/include/asm/pci.h        |  5 -----
 arch/powerpc/kernel/pci-common.c      |  4 ++--
 arch/powerpc/kernel/pci-hotplug.c     |  3 +--
 arch/powerpc/kernel/pci_of_scan.c     |  3 +--
 5 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 44305ac..65ffc16 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -12,6 +12,11 @@
 #include <linux/ioport.h>
 #include <asm-generic/pci-bridge.h>
 
+/* Return values for pci_controller_ops.probe_mode function */
+#define PCI_PROBE_NONE		-1	/* Don't look at this bus at all */
+#define PCI_PROBE_NORMAL	0	/* Do normal PCI probing */
+#define PCI_PROBE_DEVTREE	1	/* Instantiate from device tree */
+
 struct device_node;
 
 /*
@@ -20,6 +25,8 @@ struct device_node;
 struct pci_controller_ops {
 	void		(*dma_dev_setup)(struct pci_dev *dev);
 	void		(*dma_bus_setup)(struct pci_bus *bus);
+
+	int		(*probe_mode)(struct pci_bus *);
 };
 
 /*
@@ -290,5 +297,16 @@ static inline void pci_dma_bus_setup(struct pci_bus *bus)
 		ppc_md.pci_dma_bus_setup(bus);
 }
 
+static inline int pci_probe_mode(struct pci_bus *bus)
+{
+	struct pci_controller *phb = pci_bus_to_host(bus);
+
+	if (phb->controller_ops.probe_mode)
+		return phb->controller_ops.probe_mode(bus);
+	if (ppc_md.pci_probe_mode)
+		return ppc_md.pci_probe_mode(bus);
+	return PCI_PROBE_NORMAL;
+}
+
 #endif	/* __KERNEL__ */
 #endif	/* _ASM_POWERPC_PCI_BRIDGE_H */
diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index 1b0739b..8745067 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -22,11 +22,6 @@
 
 #include <asm-generic/pci-dma-compat.h>
 
-/* Return values for ppc_md.pci_probe_mode function */
-#define PCI_PROBE_NONE		-1	/* Don't look at this bus at all */
-#define PCI_PROBE_NORMAL	0	/* Do normal PCI probing */
-#define PCI_PROBE_DEVTREE	1	/* Instantiate from device tree */
-
 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		0x10000000
 
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 317ed00..977859e 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1622,8 +1622,8 @@ void pcibios_scan_phb(struct pci_controller *hose)
 
 	/* Get probe mode and perform scan */
 	mode = PCI_PROBE_NORMAL;
-	if (node && ppc_md.pci_probe_mode)
-		mode = ppc_md.pci_probe_mode(bus);
+	if (node)
+		mode = pci_probe_mode(bus);
 	pr_debug("    probe mode: %d\n", mode);
 	if (mode == PCI_PROBE_DEVTREE)
 		of_scan_bus(node, bus);
diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
index 5b78917..2cc9ccb 100644
--- a/arch/powerpc/kernel/pci-hotplug.c
+++ b/arch/powerpc/kernel/pci-hotplug.c
@@ -78,8 +78,7 @@ void pcibios_add_pci_devices(struct pci_bus * bus)
 	eeh_add_device_tree_early(dn);
 
 	mode = PCI_PROBE_NORMAL;
-	if (ppc_md.pci_probe_mode)
-		mode = ppc_md.pci_probe_mode(bus);
+	mode = pci_probe_mode(bus);
 
 	if (mode == PCI_PROBE_DEVTREE) {
 		/* use ofdt-based probe */
diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index e6245e9..25f8c57 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -287,8 +287,7 @@ void of_scan_pci_bridge(struct pci_dev *dev)
 	pr_debug("    bus name: %s\n", bus->name);
 
 	mode = PCI_PROBE_NORMAL;
-	if (ppc_md.pci_probe_mode)
-		mode = ppc_md.pci_probe_mode(bus);
+	mode = pci_probe_mode(bus);
 	pr_debug("    probe mode: %d\n", mode);
 
 	if (mode == PCI_PROBE_DEVTREE)
-- 
2.1.4
