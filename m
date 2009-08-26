Return-Path: <glikely@secretlab.ca>
Received: from mail-pz0-f202.google.com (mail-pz0-f202.google.com
	[209.85.222.202])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 851CBB7EC9
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 26 Aug 2009 16:07:16 +1000 (EST)
Received: by pzk40 with SMTP id 40so2099509pzk.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 25 Aug 2009 23:07:14 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH V2 2/3] powerpc/pci: move pci_64.c device tree scanning code
	into pci-common.c
To: benh@kernel.crashing.org, galak@kernel.crashing.org, sfr@canb.auug.org.au,
	linuxppc-dev@lists.ozlabs.org
Date: Wed, 26 Aug 2009 00:07:11 -0600
Message-ID: <20090826060708.30936.54239.stgit@localhost.localdomain>
In-Reply-To: <20090826060659.30936.75706.stgit@localhost.localdomain>
References: <20090826060659.30936.75706.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

The PCI device tree scanning code in pci_64.c is some useful functionality.
It allows PCI devices to be described in the device tree instead of being
probed for, which in turn allows pci devices to use all of the device tree
facilities to describe complex PCI bus architectures like GPIO and IRQ
routing (perhaps not a common situation for desktop or server systems,
but useful for embedded systems with on-board PCI devices).

This patch moves the device tree scanning into pci-common.c so it is
available for 32-bit powerpc machines too.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/include/asm/pci-bridge.h |    5 
 arch/powerpc/include/asm/pci.h        |    5 
 arch/powerpc/kernel/Makefile          |    2 
 arch/powerpc/kernel/pci-common.c      |    1 
 arch/powerpc/kernel/pci_64.c          |  289 ---------------------------
 arch/powerpc/kernel/pci_of_scan.c     |  358 +++++++++++++++++++++++++++++++++
 6 files changed, 364 insertions(+), 296 deletions(-)
 create mode 100644 arch/powerpc/kernel/pci_of_scan.c


diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 4c61fa0..3faf575 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -284,11 +284,6 @@ static inline int isa_vaddr_is_ioport(void __iomem *address)
 extern int pcibios_unmap_io_space(struct pci_bus *bus);
 extern int pcibios_map_io_space(struct pci_bus *bus);
 
-/* Return values for ppc_md.pci_probe_mode function */
-#define PCI_PROBE_NONE		-1	/* Don't look at this bus at all */
-#define PCI_PROBE_NORMAL	0	/* Do normal PCI probing */
-#define PCI_PROBE_DEVTREE	1	/* Instantiate from device tree */
-
 #ifdef CONFIG_NUMA
 #define PHB_SET_NODE(PHB, NODE)		((PHB)->node = (NODE))
 #else
diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index d9483c5..9ae2e3e 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -22,6 +22,11 @@
 
 #include <asm-generic/pci-dma-compat.h>
 
+/* Return values for ppc_md.pci_probe_mode function */
+#define PCI_PROBE_NONE		-1	/* Don't look at this bus at all */
+#define PCI_PROBE_NORMAL	0	/* Do normal PCI probing */
+#define PCI_PROBE_DEVTREE	1	/* Instantiate from device tree */
+
 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		0x10000000
 
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index b73396b..3811062 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -88,7 +88,7 @@ obj-$(CONFIG_SWIOTLB)		+= dma-swiotlb.o
 
 pci64-$(CONFIG_PPC64)		+= pci_dn.o isa-bridge.o
 obj-$(CONFIG_PCI)		+= pci_$(CONFIG_WORD_SIZE).o $(pci64-y) \
-				   pci-common.o
+				   pci-common.o pci_of_scan.o
 obj-$(CONFIG_PCI_MSI)		+= msi.o
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o crash.o \
 				   machine_kexec_$(CONFIG_WORD_SIZE).o
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 23eeb3e..44497a8 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1617,4 +1617,3 @@ void __devinit pcibios_setup_phb_resources(struct pci_controller *hose)
 		 (unsigned long)hose->io_base_virt - _IO_BASE);
 
 }
-
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 9e8902f..4d5b4ce 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -43,295 +43,6 @@ unsigned long pci_probe_only = 1;
 unsigned long pci_io_base = ISA_IO_BASE;
 EXPORT_SYMBOL(pci_io_base);
 
-static u32 get_int_prop(struct device_node *np, const char *name, u32 def)
-{
-	const u32 *prop;
-	int len;
-
-	prop = of_get_property(np, name, &len);
-	if (prop && len >= 4)
-		return *prop;
-	return def;
-}
-
-static unsigned int pci_parse_of_flags(u32 addr0, int bridge)
-{
-	unsigned int flags = 0;
-
-	if (addr0 & 0x02000000) {
-		flags = IORESOURCE_MEM | PCI_BASE_ADDRESS_SPACE_MEMORY;
-		flags |= (addr0 >> 22) & PCI_BASE_ADDRESS_MEM_TYPE_64;
-		flags |= (addr0 >> 28) & PCI_BASE_ADDRESS_MEM_TYPE_1M;
-		if (addr0 & 0x40000000)
-			flags |= IORESOURCE_PREFETCH
-				 | PCI_BASE_ADDRESS_MEM_PREFETCH;
-		/* Note: We don't know whether the ROM has been left enabled
-		 * by the firmware or not. We mark it as disabled (ie, we do
-		 * not set the IORESOURCE_ROM_ENABLE flag) for now rather than
-		 * do a config space read, it will be force-enabled if needed
-		 */
-		if (!bridge && (addr0 & 0xff) == 0x30)
-			flags |= IORESOURCE_READONLY;
-	} else if (addr0 & 0x01000000)
-		flags = IORESOURCE_IO | PCI_BASE_ADDRESS_SPACE_IO;
-	if (flags)
-		flags |= IORESOURCE_SIZEALIGN;
-	return flags;
-}
-
-
-static void pci_parse_of_addrs(struct device_node *node, struct pci_dev *dev)
-{
-	u64 base, size;
-	unsigned int flags;
-	struct resource *res;
-	const u32 *addrs;
-	u32 i;
-	int proplen;
-
-	addrs = of_get_property(node, "assigned-addresses", &proplen);
-	if (!addrs)
-		return;
-	pr_debug("    parse addresses (%d bytes) @ %p\n", proplen, addrs);
-	for (; proplen >= 20; proplen -= 20, addrs += 5) {
-		flags = pci_parse_of_flags(addrs[0], 0);
-		if (!flags)
-			continue;
-		base = of_read_number(&addrs[1], 2);
-		size = of_read_number(&addrs[3], 2);
-		if (!size)
-			continue;
-		i = addrs[0] & 0xff;
-		pr_debug("  base: %llx, size: %llx, i: %x\n",
-			 (unsigned long long)base,
-			 (unsigned long long)size, i);
-
-		if (PCI_BASE_ADDRESS_0 <= i && i <= PCI_BASE_ADDRESS_5) {
-			res = &dev->resource[(i - PCI_BASE_ADDRESS_0) >> 2];
-		} else if (i == dev->rom_base_reg) {
-			res = &dev->resource[PCI_ROM_RESOURCE];
-			flags |= IORESOURCE_READONLY | IORESOURCE_CACHEABLE;
-		} else {
-			printk(KERN_ERR "PCI: bad cfg reg num 0x%x\n", i);
-			continue;
-		}
-		res->start = base;
-		res->end = base + size - 1;
-		res->flags = flags;
-		res->name = pci_name(dev);
-	}
-}
-
-struct pci_dev *of_create_pci_dev(struct device_node *node,
-				 struct pci_bus *bus, int devfn)
-{
-	struct pci_dev *dev;
-	const char *type;
-
-	dev = alloc_pci_dev();
-	if (!dev)
-		return NULL;
-	type = of_get_property(node, "device_type", NULL);
-	if (type == NULL)
-		type = "";
-
-	pr_debug("    create device, devfn: %x, type: %s\n", devfn, type);
-
-	dev->bus = bus;
-	dev->sysdata = node;
-	dev->dev.parent = bus->bridge;
-	dev->dev.bus = &pci_bus_type;
-	dev->devfn = devfn;
-	dev->multifunction = 0;		/* maybe a lie? */
-
-	dev->vendor = get_int_prop(node, "vendor-id", 0xffff);
-	dev->device = get_int_prop(node, "device-id", 0xffff);
-	dev->subsystem_vendor = get_int_prop(node, "subsystem-vendor-id", 0);
-	dev->subsystem_device = get_int_prop(node, "subsystem-id", 0);
-
-	dev->cfg_size = pci_cfg_space_size(dev);
-
-	dev_set_name(&dev->dev, "%04x:%02x:%02x.%d", pci_domain_nr(bus),
-		dev->bus->number, PCI_SLOT(devfn), PCI_FUNC(devfn));
-	dev->class = get_int_prop(node, "class-code", 0);
-	dev->revision = get_int_prop(node, "revision-id", 0);
-
-	pr_debug("    class: 0x%x\n", dev->class);
-	pr_debug("    revision: 0x%x\n", dev->revision);
-
-	dev->current_state = 4;		/* unknown power state */
-	dev->error_state = pci_channel_io_normal;
-	dev->dma_mask = 0xffffffff;
-
-	if (!strcmp(type, "pci") || !strcmp(type, "pciex")) {
-		/* a PCI-PCI bridge */
-		dev->hdr_type = PCI_HEADER_TYPE_BRIDGE;
-		dev->rom_base_reg = PCI_ROM_ADDRESS1;
-	} else if (!strcmp(type, "cardbus")) {
-		dev->hdr_type = PCI_HEADER_TYPE_CARDBUS;
-	} else {
-		dev->hdr_type = PCI_HEADER_TYPE_NORMAL;
-		dev->rom_base_reg = PCI_ROM_ADDRESS;
-		/* Maybe do a default OF mapping here */
-		dev->irq = NO_IRQ;
-	}
-
-	pci_parse_of_addrs(node, dev);
-
-	pr_debug("    adding to system ...\n");
-
-	pci_device_add(dev, bus);
-
-	return dev;
-}
-EXPORT_SYMBOL(of_create_pci_dev);
-
-static void __devinit __of_scan_bus(struct device_node *node,
-				    struct pci_bus *bus, int rescan_existing)
-{
-	struct device_node *child;
-	const u32 *reg;
-	int reglen, devfn;
-	struct pci_dev *dev;
-
-	pr_debug("of_scan_bus(%s) bus no %d... \n",
-		 node->full_name, bus->number);
-
-	/* Scan direct children */
-	for_each_child_of_node(node, child) {
-		pr_debug("  * %s\n", child->full_name);
-		reg = of_get_property(child, "reg", &reglen);
-		if (reg == NULL || reglen < 20)
-			continue;
-		devfn = (reg[0] >> 8) & 0xff;
-
-		/* create a new pci_dev for this device */
-		dev = of_create_pci_dev(child, bus, devfn);
-		if (!dev)
-			continue;
-		pr_debug("    dev header type: %x\n", dev->hdr_type);
-	}
-
-	/* Apply all fixups necessary. We don't fixup the bus "self"
-	 * for an existing bridge that is being rescanned
-	 */
-	if (!rescan_existing)
-		pcibios_setup_bus_self(bus);
-	pcibios_setup_bus_devices(bus);
-
-	/* Now scan child busses */
-	list_for_each_entry(dev, &bus->devices, bus_list) {
-		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
-		    dev->hdr_type == PCI_HEADER_TYPE_CARDBUS) {
-			struct device_node *child = pci_device_to_OF_node(dev);
-			if (dev)
-				of_scan_pci_bridge(child, dev);
-		}
-	}
-}
-
-void __devinit of_scan_bus(struct device_node *node,
-			   struct pci_bus *bus)
-{
-	__of_scan_bus(node, bus, 0);
-}
-EXPORT_SYMBOL_GPL(of_scan_bus);
-
-void __devinit of_rescan_bus(struct device_node *node,
-			     struct pci_bus *bus)
-{
-	__of_scan_bus(node, bus, 1);
-}
-EXPORT_SYMBOL_GPL(of_rescan_bus);
-
-void __devinit of_scan_pci_bridge(struct device_node *node,
-				  struct pci_dev *dev)
-{
-	struct pci_bus *bus;
-	const u32 *busrange, *ranges;
-	int len, i, mode;
-	struct resource *res;
-	unsigned int flags;
-	u64 size;
-
-	pr_debug("of_scan_pci_bridge(%s)\n", node->full_name);
-
-	/* parse bus-range property */
-	busrange = of_get_property(node, "bus-range", &len);
-	if (busrange == NULL || len != 8) {
-		printk(KERN_DEBUG "Can't get bus-range for PCI-PCI bridge %s\n",
-		       node->full_name);
-		return;
-	}
-	ranges = of_get_property(node, "ranges", &len);
-	if (ranges == NULL) {
-		printk(KERN_DEBUG "Can't get ranges for PCI-PCI bridge %s\n",
-		       node->full_name);
-		return;
-	}
-
-	bus = pci_add_new_bus(dev->bus, dev, busrange[0]);
-	if (!bus) {
-		printk(KERN_ERR "Failed to create pci bus for %s\n",
-		       node->full_name);
-		return;
-	}
-
-	bus->primary = dev->bus->number;
-	bus->subordinate = busrange[1];
-	bus->bridge_ctl = 0;
-	bus->sysdata = node;
-
-	/* parse ranges property */
-	/* PCI #address-cells == 3 and #size-cells == 2 always */
-	res = &dev->resource[PCI_BRIDGE_RESOURCES];
-	for (i = 0; i < PCI_NUM_RESOURCES - PCI_BRIDGE_RESOURCES; ++i) {
-		res->flags = 0;
-		bus->resource[i] = res;
-		++res;
-	}
-	i = 1;
-	for (; len >= 32; len -= 32, ranges += 8) {
-		flags = pci_parse_of_flags(ranges[0], 1);
-		size = of_read_number(&ranges[6], 2);
-		if (flags == 0 || size == 0)
-			continue;
-		if (flags & IORESOURCE_IO) {
-			res = bus->resource[0];
-			if (res->flags) {
-				printk(KERN_ERR "PCI: ignoring extra I/O range"
-				       " for bridge %s\n", node->full_name);
-				continue;
-			}
-		} else {
-			if (i >= PCI_NUM_RESOURCES - PCI_BRIDGE_RESOURCES) {
-				printk(KERN_ERR "PCI: too many memory ranges"
-				       " for bridge %s\n", node->full_name);
-				continue;
-			}
-			res = bus->resource[i];
-			++i;
-		}
-		res->start = of_read_number(&ranges[1], 2);
-		res->end = res->start + size - 1;
-		res->flags = flags;
-	}
-	sprintf(bus->name, "PCI Bus %04x:%02x", pci_domain_nr(bus),
-		bus->number);
-	pr_debug("    bus name: %s\n", bus->name);
-
-	mode = PCI_PROBE_NORMAL;
-	if (ppc_md.pci_probe_mode)
-		mode = ppc_md.pci_probe_mode(bus);
-	pr_debug("    probe mode: %d\n", mode);
-
-	if (mode == PCI_PROBE_DEVTREE)
-		of_scan_bus(node, bus);
-	else if (mode == PCI_PROBE_NORMAL)
-		pci_scan_child_bus(bus);
-}
-EXPORT_SYMBOL(of_scan_pci_bridge);
-
 void __devinit scan_phb(struct pci_controller *hose)
 {
 	struct pci_bus *bus;
diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
new file mode 100644
index 0000000..72c31bc
--- /dev/null
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -0,0 +1,358 @@
+/*
+ * Helper routines to scan the device tree for PCI devices and busses
+ *
+ * Migrated out of PowerPC architecture pci_64.c file by Grant Likely
+ * <grant.likely@secretlab.ca> so that these routines are available for
+ * 32 bit also.
+ *
+ * Copyright (C) 2003 Anton Blanchard <anton@au.ibm.com>, IBM
+ *   Rework, based on alpha PCI code.
+ * Copyright (c) 2009 Secret Lab Technologies Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ */
+
+#include <linux/pci.h>
+#include <asm/pci-bridge.h>
+#include <asm/prom.h>
+
+/**
+ * get_int_prop - Decode a u32 from a device tree property
+ */
+static u32 get_int_prop(struct device_node *np, const char *name, u32 def)
+{
+	const u32 *prop;
+	int len;
+
+	prop = of_get_property(np, name, &len);
+	if (prop && len >= 4)
+		return *prop;
+	return def;
+}
+
+/**
+ * pci_parse_of_flags - Parse the flags cell of a device tree PCI address
+ * @addr0: value of 1st cell of a device tree PCI address.
+ * @bridge: Set this flag if the address is from a bridge 'ranges' property
+ */
+unsigned int pci_parse_of_flags(u32 addr0, int bridge)
+{
+	unsigned int flags = 0;
+
+	if (addr0 & 0x02000000) {
+		flags = IORESOURCE_MEM | PCI_BASE_ADDRESS_SPACE_MEMORY;
+		flags |= (addr0 >> 22) & PCI_BASE_ADDRESS_MEM_TYPE_64;
+		flags |= (addr0 >> 28) & PCI_BASE_ADDRESS_MEM_TYPE_1M;
+		if (addr0 & 0x40000000)
+			flags |= IORESOURCE_PREFETCH
+				 | PCI_BASE_ADDRESS_MEM_PREFETCH;
+		/* Note: We don't know whether the ROM has been left enabled
+		 * by the firmware or not. We mark it as disabled (ie, we do
+		 * not set the IORESOURCE_ROM_ENABLE flag) for now rather than
+		 * do a config space read, it will be force-enabled if needed
+		 */
+		if (!bridge && (addr0 & 0xff) == 0x30)
+			flags |= IORESOURCE_READONLY;
+	} else if (addr0 & 0x01000000)
+		flags = IORESOURCE_IO | PCI_BASE_ADDRESS_SPACE_IO;
+	if (flags)
+		flags |= IORESOURCE_SIZEALIGN;
+	return flags;
+}
+
+/**
+ * of_pci_parse_addrs - Parse PCI addresses assigned in the device tree node
+ * @node: device tree node for the PCI device
+ * @dev: pci_dev structure for the device
+ *
+ * This function parses the 'assigned-addresses' property of a PCI devices'
+ * device tree node and writes them into the associated pci_dev structure.
+ */
+static void of_pci_parse_addrs(struct device_node *node, struct pci_dev *dev)
+{
+	u64 base, size;
+	unsigned int flags;
+	struct resource *res;
+	const u32 *addrs;
+	u32 i;
+	int proplen;
+
+	addrs = of_get_property(node, "assigned-addresses", &proplen);
+	if (!addrs)
+		return;
+	pr_debug("    parse addresses (%d bytes) @ %p\n", proplen, addrs);
+	for (; proplen >= 20; proplen -= 20, addrs += 5) {
+		flags = pci_parse_of_flags(addrs[0], 0);
+		if (!flags)
+			continue;
+		base = of_read_number(&addrs[1], 2);
+		size = of_read_number(&addrs[3], 2);
+		if (!size)
+			continue;
+		i = addrs[0] & 0xff;
+		pr_debug("  base: %llx, size: %llx, i: %x\n",
+			 (unsigned long long)base,
+			 (unsigned long long)size, i);
+
+		if (PCI_BASE_ADDRESS_0 <= i && i <= PCI_BASE_ADDRESS_5) {
+			res = &dev->resource[(i - PCI_BASE_ADDRESS_0) >> 2];
+		} else if (i == dev->rom_base_reg) {
+			res = &dev->resource[PCI_ROM_RESOURCE];
+			flags |= IORESOURCE_READONLY | IORESOURCE_CACHEABLE;
+		} else {
+			printk(KERN_ERR "PCI: bad cfg reg num 0x%x\n", i);
+			continue;
+		}
+		res->start = base;
+		res->end = base + size - 1;
+		res->flags = flags;
+		res->name = pci_name(dev);
+	}
+}
+
+/**
+ * of_create_pci_dev - Given a device tree node on a pci bus, create a pci_dev
+ * @node: device tree node pointer
+ * @bus: bus the device is sitting on
+ * @devfn: PCI function number, extracted from device tree by caller.
+ */
+struct pci_dev *of_create_pci_dev(struct device_node *node,
+				 struct pci_bus *bus, int devfn)
+{
+	struct pci_dev *dev;
+	const char *type;
+
+	dev = alloc_pci_dev();
+	if (!dev)
+		return NULL;
+	type = of_get_property(node, "device_type", NULL);
+	if (type == NULL)
+		type = "";
+
+	pr_debug("    create device, devfn: %x, type: %s\n", devfn, type);
+
+	dev->bus = bus;
+	dev->sysdata = node;
+	dev->dev.parent = bus->bridge;
+	dev->dev.bus = &pci_bus_type;
+	dev->devfn = devfn;
+	dev->multifunction = 0;		/* maybe a lie? */
+
+	dev->vendor = get_int_prop(node, "vendor-id", 0xffff);
+	dev->device = get_int_prop(node, "device-id", 0xffff);
+	dev->subsystem_vendor = get_int_prop(node, "subsystem-vendor-id", 0);
+	dev->subsystem_device = get_int_prop(node, "subsystem-id", 0);
+
+	dev->cfg_size = pci_cfg_space_size(dev);
+
+	dev_set_name(&dev->dev, "%04x:%02x:%02x.%d", pci_domain_nr(bus),
+		dev->bus->number, PCI_SLOT(devfn), PCI_FUNC(devfn));
+	dev->class = get_int_prop(node, "class-code", 0);
+	dev->revision = get_int_prop(node, "revision-id", 0);
+
+	pr_debug("    class: 0x%x\n", dev->class);
+	pr_debug("    revision: 0x%x\n", dev->revision);
+
+	dev->current_state = 4;		/* unknown power state */
+	dev->error_state = pci_channel_io_normal;
+	dev->dma_mask = 0xffffffff;
+
+	if (!strcmp(type, "pci") || !strcmp(type, "pciex")) {
+		/* a PCI-PCI bridge */
+		dev->hdr_type = PCI_HEADER_TYPE_BRIDGE;
+		dev->rom_base_reg = PCI_ROM_ADDRESS1;
+	} else if (!strcmp(type, "cardbus")) {
+		dev->hdr_type = PCI_HEADER_TYPE_CARDBUS;
+	} else {
+		dev->hdr_type = PCI_HEADER_TYPE_NORMAL;
+		dev->rom_base_reg = PCI_ROM_ADDRESS;
+		/* Maybe do a default OF mapping here */
+		dev->irq = NO_IRQ;
+	}
+
+	of_pci_parse_addrs(node, dev);
+
+	pr_debug("    adding to system ...\n");
+
+	pci_device_add(dev, bus);
+
+	return dev;
+}
+EXPORT_SYMBOL(of_create_pci_dev);
+
+/**
+ * of_scan_pci_bridge - Set up a PCI bridge and scan for child nodes
+ * @node: device tree node of bridge
+ * @dev: pci_dev structure for the bridge
+ *
+ * of_scan_bus() calls this routine for each PCI bridge that it finds, and
+ * this routine in turn call of_scan_bus() recusively to scan for more child
+ * devices.
+ */
+void __devinit of_scan_pci_bridge(struct device_node *node,
+				  struct pci_dev *dev)
+{
+	struct pci_bus *bus;
+	const u32 *busrange, *ranges;
+	int len, i, mode;
+	struct resource *res;
+	unsigned int flags;
+	u64 size;
+
+	pr_debug("of_scan_pci_bridge(%s)\n", node->full_name);
+
+	/* parse bus-range property */
+	busrange = of_get_property(node, "bus-range", &len);
+	if (busrange == NULL || len != 8) {
+		printk(KERN_DEBUG "Can't get bus-range for PCI-PCI bridge %s\n",
+		       node->full_name);
+		return;
+	}
+	ranges = of_get_property(node, "ranges", &len);
+	if (ranges == NULL) {
+		printk(KERN_DEBUG "Can't get ranges for PCI-PCI bridge %s\n",
+		       node->full_name);
+		return;
+	}
+
+	bus = pci_add_new_bus(dev->bus, dev, busrange[0]);
+	if (!bus) {
+		printk(KERN_ERR "Failed to create pci bus for %s\n",
+		       node->full_name);
+		return;
+	}
+
+	bus->primary = dev->bus->number;
+	bus->subordinate = busrange[1];
+	bus->bridge_ctl = 0;
+	bus->sysdata = node;
+
+	/* parse ranges property */
+	/* PCI #address-cells == 3 and #size-cells == 2 always */
+	res = &dev->resource[PCI_BRIDGE_RESOURCES];
+	for (i = 0; i < PCI_NUM_RESOURCES - PCI_BRIDGE_RESOURCES; ++i) {
+		res->flags = 0;
+		bus->resource[i] = res;
+		++res;
+	}
+	i = 1;
+	for (; len >= 32; len -= 32, ranges += 8) {
+		flags = pci_parse_of_flags(ranges[0], 1);
+		size = of_read_number(&ranges[6], 2);
+		if (flags == 0 || size == 0)
+			continue;
+		if (flags & IORESOURCE_IO) {
+			res = bus->resource[0];
+			if (res->flags) {
+				printk(KERN_ERR "PCI: ignoring extra I/O range"
+				       " for bridge %s\n", node->full_name);
+				continue;
+			}
+		} else {
+			if (i >= PCI_NUM_RESOURCES - PCI_BRIDGE_RESOURCES) {
+				printk(KERN_ERR "PCI: too many memory ranges"
+				       " for bridge %s\n", node->full_name);
+				continue;
+			}
+			res = bus->resource[i];
+			++i;
+		}
+		res->start = of_read_number(&ranges[1], 2);
+		res->end = res->start + size - 1;
+		res->flags = flags;
+	}
+	sprintf(bus->name, "PCI Bus %04x:%02x", pci_domain_nr(bus),
+		bus->number);
+	pr_debug("    bus name: %s\n", bus->name);
+
+	mode = PCI_PROBE_NORMAL;
+	if (ppc_md.pci_probe_mode)
+		mode = ppc_md.pci_probe_mode(bus);
+	pr_debug("    probe mode: %d\n", mode);
+
+	if (mode == PCI_PROBE_DEVTREE)
+		of_scan_bus(node, bus);
+	else if (mode == PCI_PROBE_NORMAL)
+		pci_scan_child_bus(bus);
+}
+EXPORT_SYMBOL(of_scan_pci_bridge);
+
+/**
+ * __of_scan_bus - given a PCI bus node, setup bus and scan for child devices
+ * @node: device tree node for the PCI bus
+ * @bus: pci_bus structure for the PCI bus
+ * @rescan_existing: Flag indicating bus has already been set up
+ */
+static void __devinit __of_scan_bus(struct device_node *node,
+				    struct pci_bus *bus, int rescan_existing)
+{
+	struct device_node *child;
+	const u32 *reg;
+	int reglen, devfn;
+	struct pci_dev *dev;
+
+	pr_debug("of_scan_bus(%s) bus no %d... \n",
+		 node->full_name, bus->number);
+
+	/* Scan direct children */
+	for_each_child_of_node(node, child) {
+		pr_debug("  * %s\n", child->full_name);
+		reg = of_get_property(child, "reg", &reglen);
+		if (reg == NULL || reglen < 20)
+			continue;
+		devfn = (reg[0] >> 8) & 0xff;
+
+		/* create a new pci_dev for this device */
+		dev = of_create_pci_dev(child, bus, devfn);
+		if (!dev)
+			continue;
+		pr_debug("    dev header type: %x\n", dev->hdr_type);
+	}
+
+	/* Apply all fixups necessary. We don't fixup the bus "self"
+	 * for an existing bridge that is being rescanned
+	 */
+	if (!rescan_existing)
+		pcibios_setup_bus_self(bus);
+	pcibios_setup_bus_devices(bus);
+
+	/* Now scan child busses */
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
+		    dev->hdr_type == PCI_HEADER_TYPE_CARDBUS) {
+			struct device_node *child = pci_device_to_OF_node(dev);
+			if (dev)
+				of_scan_pci_bridge(child, dev);
+		}
+	}
+}
+
+/**
+ * of_scan_bus - given a PCI bus node, setup bus and scan for child devices
+ * @node: device tree node for the PCI bus
+ * @bus: pci_bus structure for the PCI bus
+ */
+void __devinit of_scan_bus(struct device_node *node,
+			   struct pci_bus *bus)
+{
+	__of_scan_bus(node, bus, 0);
+}
+EXPORT_SYMBOL_GPL(of_scan_bus);
+
+/**
+ * of_rescan_bus - given a PCI bus node, scan for child devices
+ * @node: device tree node for the PCI bus
+ * @bus: pci_bus structure for the PCI bus
+ *
+ * Same as of_scan_bus, but for a pci_bus structure that has already been
+ * setup.
+ */
+void __devinit of_rescan_bus(struct device_node *node,
+			     struct pci_bus *bus)
+{
+	__of_scan_bus(node, bus, 1);
+}
+EXPORT_SYMBOL_GPL(of_rescan_bus);
+
