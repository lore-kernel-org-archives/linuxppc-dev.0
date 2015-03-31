Return-Path: <dja@axtens.net>
Received: from mail-pa0-x229.google.com (mail-pa0-x229.google.com
 [IPv6:2607:f8b0:400e:c03::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B8DDD1A09BE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 16:02:12 +1100 (AEDT)
Received: by padcy3 with SMTP id cy3so8042165pad.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 22:02:11 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 18/19] powerpc: Remove shims for pci_controller_ops
 operations
Date: Tue, 31 Mar 2015 16:00:56 +1100
Message-Id: <1427778057-9505-19-git-send-email-dja@axtens.net>
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

Remove shims, patch callsites to use pci_controller_ops
versions instead.

Also move back the probe mode defines, as explained in the patch
for pci_probe_mode.

Signed-off-by: Daniel Axtens <dja@axtens.net>

---

v1 --> v2:
 - Squash all the shim removal.
 - Prefer phb to hose.
---
 arch/powerpc/include/asm/machdep.h    | 14 ------
 arch/powerpc/include/asm/pci-bridge.h | 84 -----------------------------------
 arch/powerpc/include/asm/pci.h        |  5 +++
 arch/powerpc/kernel/pci-common.c      | 43 ++++++++++++++----
 arch/powerpc/kernel/pci-hotplug.c     |  6 ++-
 arch/powerpc/kernel/pci_of_scan.c     |  6 ++-
 arch/powerpc/sysdev/dart_iommu.c      |  5 ---
 7 files changed, 50 insertions(+), 113 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 9d4a067..92b085b 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -103,9 +103,6 @@ struct machdep_calls {
 #endif
 #endif /* CONFIG_PPC64 */
 
-	void		(*pci_dma_dev_setup)(struct pci_dev *dev);
-	void		(*pci_dma_bus_setup)(struct pci_bus *bus);
-
 	/* Platform set_dma_mask and dma_get_required_mask overrides */
 	int		(*dma_set_mask)(struct device *dev, u64 dma_mask);
 	u64		(*dma_get_required_mask)(struct device *dev);
@@ -127,7 +124,6 @@ struct machdep_calls {
 	/* PCI stuff */
 	/* Called after scanning the bus, before allocating resources */
 	void		(*pcibios_fixup)(void);
-	int		(*pci_probe_mode)(struct pci_bus *);
 	void		(*pci_irq_fixup)(struct pci_dev *dev);
 	int		(*pcibios_root_bridge_prepare)(struct pci_host_bridge
 				*bridge);
@@ -237,19 +233,9 @@ struct machdep_calls {
 	/* Called for each PCI bus in the system when it's probed */
 	void (*pcibios_fixup_bus)(struct pci_bus *);
 
-	/* Called when pci_enable_device() is called. Returns true to
-	 * allow assignment/enabling of the device. */
-	bool (*pcibios_enable_device_hook)(struct pci_dev *);
-
 	/* Called after scan and before resource survey */
 	void (*pcibios_fixup_phb)(struct pci_controller *hose);
 
-	/* Called during PCI resource reassignment */
-	resource_size_t (*pcibios_window_alignment)(struct pci_bus *, unsigned long type);
-
-	/* Reset the secondary bus of bridge */
-	void  (*pcibios_reset_secondary_bus)(struct pci_dev *dev);
-
 	/* Called to shutdown machine specific hardware not already controlled
 	 * by other drivers.
 	 */
diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index d2cba2f..4f39ef9 100644
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
@@ -282,84 +277,5 @@ static inline int pcibios_vaddr_is_ioport(void __iomem *address)
 }
 #endif	/* CONFIG_PCI */
 
-/*
- * Shims to prefer pci_controller version over ppc_md where available.
- */
-static inline void pci_dma_dev_setup(struct pci_dev *dev)
-{
-	struct pci_controller *phb = pci_bus_to_host(dev->bus);
-
-	if (phb->controller_ops.dma_dev_setup)
-		phb->controller_ops.dma_dev_setup(dev);
-	else if (ppc_md.pci_dma_dev_setup)
-		ppc_md.pci_dma_dev_setup(dev);
-}
-
-static inline void pci_dma_bus_setup(struct pci_bus *bus)
-{
-	struct pci_controller *phb = pci_bus_to_host(bus);
-
-	if (phb->controller_ops.dma_bus_setup)
-		phb->controller_ops.dma_bus_setup(bus);
-	else if (ppc_md.pci_dma_bus_setup)
-		ppc_md.pci_dma_bus_setup(bus);
-}
-
-static inline int pci_probe_mode(struct pci_bus *bus)
-{
-	struct pci_controller *phb = pci_bus_to_host(bus);
-
-	if (phb->controller_ops.probe_mode)
-		return phb->controller_ops.probe_mode(bus);
-	if (ppc_md.pci_probe_mode)
-		return ppc_md.pci_probe_mode(bus);
-	return PCI_PROBE_NORMAL;
-}
-
-static inline bool pcibios_enable_device_hook(struct pci_dev *dev)
-{
-	struct pci_controller *phb = pci_bus_to_host(dev->bus);
-
-	if (phb->controller_ops.enable_device_hook)
-		return phb->controller_ops.enable_device_hook(dev);
-	if (ppc_md.pcibios_enable_device_hook)
-		return ppc_md.pcibios_enable_device_hook(dev);
-	return true;
-}
-
-static inline resource_size_t pci_window_alignment(struct pci_bus *bus,
-						   unsigned long type)
-{
-	struct pci_controller *phb = pci_bus_to_host(bus);
-
-	if (phb->controller_ops.window_alignment)
-		return phb->controller_ops.window_alignment(bus, type);
-	if (ppc_md.pcibios_window_alignment)
-		return ppc_md.pcibios_window_alignment(bus, type);
-
-	/*
-	 * PCI core will figure out the default
-	 * alignment: 4KiB for I/O and 1MiB for
-	 * memory window.
-	 */
-	return 1;
-}
-
-static inline void pcibios_reset_secondary_bus_shim(struct pci_dev *dev)
-{
-	struct pci_controller *phb = pci_bus_to_host(dev->bus);
-
-	if (phb->controller_ops.reset_secondary_bus)
-		phb->controller_ops.reset_secondary_bus(dev);
-	else if (ppc_md.pcibios_reset_secondary_bus)
-		ppc_md.pcibios_reset_secondary_bus(dev);
-	else
-		/*
-		 * Fallback to the generic function if no
-		 * platform-specific one is provided
-		 */
-		pci_reset_secondary_bus(dev);
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
index 8b3616a..95c717d 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -109,12 +109,29 @@ void pcibios_free_controller(struct pci_controller *phb)
 resource_size_t pcibios_window_alignment(struct pci_bus *bus,
 					 unsigned long type)
 {
-	return pci_window_alignment(bus, type);
+	struct pci_controller *phb = pci_bus_to_host(bus);
+
+	if (phb->controller_ops.window_alignment)
+		return phb->controller_ops.window_alignment(bus, type);
+
+	/*
+	 * PCI core will figure out the default
+	 * alignment: 4KiB for I/O and 1MiB for
+	 * memory window.
+	 */
+	return 1;
 }
 
 void pcibios_reset_secondary_bus(struct pci_dev *dev)
 {
-	pcibios_reset_secondary_bus_shim(dev);
+	struct pci_controller *phb = pci_bus_to_host(dev->bus);
+
+	if (phb->controller_ops.reset_secondary_bus) {
+		phb->controller_ops.reset_secondary_bus(dev);
+		return;
+	}
+
+	pci_reset_secondary_bus(dev);
 }
 
 static resource_size_t pcibios_io_size(const struct pci_controller *hose)
@@ -929,6 +946,8 @@ static void pcibios_fixup_bridge(struct pci_bus *bus)
 
 void pcibios_setup_bus_self(struct pci_bus *bus)
 {
+	struct pci_controller *phb;
+
 	/* Fix up the bus resources for P2P bridges */
 	if (bus->self != NULL)
 		pcibios_fixup_bridge(bus);
@@ -940,11 +959,14 @@ void pcibios_setup_bus_self(struct pci_bus *bus)
 		ppc_md.pcibios_fixup_bus(bus);
 
 	/* Setup bus DMA mappings */
-	pci_dma_bus_setup(bus);
+	phb = pci_bus_to_host(bus);
+	if (phb->controller_ops.dma_bus_setup)
+		phb->controller_ops.dma_bus_setup(bus);
 }
 
 static void pcibios_setup_device(struct pci_dev *dev)
 {
+	struct pci_controller *phb;
 	/* Fixup NUMA node as it may not be setup yet by the generic
 	 * code and is needed by the DMA init
 	 */
@@ -955,7 +977,9 @@ static void pcibios_setup_device(struct pci_dev *dev)
 	set_dma_offset(&dev->dev, PCI_DRAM_OFFSET);
 
 	/* Additional platform DMA/iommu setup */
-	pci_dma_dev_setup(dev);
+	phb = pci_bus_to_host(dev->bus);
+	if (phb->controller_ops.dma_dev_setup)
+		phb->controller_ops.dma_dev_setup(dev);
 
 	/* Read default IRQs and fixup if necessary */
 	pci_read_irq_line(dev);
@@ -1435,8 +1459,11 @@ EXPORT_SYMBOL_GPL(pcibios_finish_adding_to_bus);
 
 int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
-	if (!pcibios_enable_device_hook(dev))
-		return -EINVAL;
+	struct pci_controller *phb = pci_bus_to_host(dev->bus);
+
+	if (phb->controller_ops.enable_device_hook)
+		if (!phb->controller_ops.enable_device_hook(dev))
+			return -EINVAL;
 
 	return pci_enable_resources(dev, mask);
 }
@@ -1608,8 +1635,8 @@ void pcibios_scan_phb(struct pci_controller *hose)
 
 	/* Get probe mode and perform scan */
 	mode = PCI_PROBE_NORMAL;
-	if (node)
-		mode = pci_probe_mode(bus);
+	if (node && hose->controller_ops.probe_mode)
+		mode = hose->controller_ops.probe_mode(bus);
 	pr_debug("    probe mode: %d\n", mode);
 	if (mode == PCI_PROBE_DEVTREE)
 		of_scan_bus(node, bus);
diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
index 2cc9ccb..52b3a5d 100644
--- a/arch/powerpc/kernel/pci-hotplug.c
+++ b/arch/powerpc/kernel/pci-hotplug.c
@@ -73,12 +73,16 @@ void pcibios_add_pci_devices(struct pci_bus * bus)
 {
 	int slotno, mode, pass, max;
 	struct pci_dev *dev;
+	struct pci_controller *phb;
 	struct device_node *dn = pci_bus_to_OF_node(bus);
 
 	eeh_add_device_tree_early(dn);
 
+	phb = pci_bus_to_host(bus);
+
 	mode = PCI_PROBE_NORMAL;
-	mode = pci_probe_mode(bus);
+	if (phb->controller_ops.probe_mode)
+		mode = phb->controller_ops.probe_mode(bus);
 
 	if (mode == PCI_PROBE_DEVTREE) {
 		/* use ofdt-based probe */
diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index 25f8c57..28a41d1 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -207,6 +207,7 @@ void of_scan_pci_bridge(struct pci_dev *dev)
 {
 	struct device_node *node = dev->dev.of_node;
 	struct pci_bus *bus;
+	struct pci_controller *phb;
 	const __be32 *busrange, *ranges;
 	int len, i, mode;
 	struct pci_bus_region region;
@@ -286,8 +287,11 @@ void of_scan_pci_bridge(struct pci_dev *dev)
 		bus->number);
 	pr_debug("    bus name: %s\n", bus->name);
 
+	phb = pci_bus_to_host(bus);
+
 	mode = PCI_PROBE_NORMAL;
-	mode = pci_probe_mode(bus);
+	if (phb->controller_ops.probe_mode)
+		mode = phb->controller_ops.probe_mode(bus);
 	pr_debug("    probe mode: %d\n", mode);
 
 	if (mode == PCI_PROBE_DEVTREE)
diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
index 120e96a..87b8000 100644
--- a/arch/powerpc/sysdev/dart_iommu.c
+++ b/arch/powerpc/sysdev/dart_iommu.c
@@ -398,9 +398,6 @@ void __init iommu_init_early_dart(struct pci_controller_ops *controller_ops)
 	if (controller_ops) {
 		controller_ops->dma_dev_setup = pci_dma_dev_setup_dart;
 		controller_ops->dma_bus_setup = pci_dma_bus_setup_dart;
-	} else {
-		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_dart;
-		ppc_md.pci_dma_bus_setup = pci_dma_bus_setup_dart;
 	}
 	/* Setup pci_dma ops */
 	set_pci_dma_ops(&dma_iommu_ops);
@@ -412,8 +409,6 @@ void __init iommu_init_early_dart(struct pci_controller_ops *controller_ops)
 		controller_ops->dma_dev_setup = NULL;
 		controller_ops->dma_bus_setup = NULL;
 	}
-	ppc_md.pci_dma_dev_setup = NULL;
-	ppc_md.pci_dma_bus_setup = NULL;
 
 	/* Setup pci_dma ops */
 	set_pci_dma_ops(&dma_direct_ops);
-- 
2.1.4
