Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A0F0968850
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Nov 2005 17:04:00 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Wed, 30 Nov 2005 16:57:28 +1100
Message-Id: <1133330249.16726.75.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Update OF address parsers
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This updates the OF address parsers to return the IO flags
indicating the type of address obtained. It also adds a PCI
call for converting physical addresses that hit IO space into
into IO tokens, and add routines that return the translated
addresses into struct resource

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

For powerpc tree, not for 2.6.15

Index: linux-work/include/asm-powerpc/prom.h
===================================================================
--- linux-work.orig/include/asm-powerpc/prom.h	2005-11-30 15:37:21.000000000 +1100
+++ linux-work/include/asm-powerpc/prom.h	2005-11-30 16:19:51.000000000 +1100
@@ -223,14 +223,36 @@ extern struct resource *request_OF_resou
 				int index, const char* name_postfix);
 extern int release_OF_resource(struct device_node* node, int index);
 
+
 /*
- * Address translation function(s)
+ * OF address retreival & translation
+ */
+
+
+/* Translate an OF address block into a CPU physical address
  */
 #define OF_BAD_ADDR	((u64)-1)
 extern u64 of_translate_address(struct device_node *np, u32 *addr);
-extern u32 *of_get_address(struct device_node *dev, int index, u64 *size);
-extern u32 *of_get_pci_address(struct device_node *dev, int bar_no, u64 *size);
 
+/* Extract an address from a device, returns the region size and
+ * the address space flags too. The PCI version uses a BAR number
+ * instead of an absolute index
+ */
+extern u32 *of_get_address(struct device_node *dev, int index,
+			   u64 *size, unsigned int *flags);
+extern u32 *of_get_pci_address(struct device_node *dev, int bar_no,
+			       u64 *size, unsigned int *flags);
+
+/* Get an address as a resource. Note that if your address is
+ * a PIO address, the conversion will fail if the physical address
+ * can't be internally converted to an IO token with
+ * pci_address_to_pio(), that is because it's either called to early
+ * or it can't be matched to any host bridge IO space
+ */
+extern int of_address_to_resource(struct device_node *dev, int index,
+				  struct resource *r);
+extern int of_pci_address_to_resource(struct device_node *dev, int bar,
+				      struct resource *r);
 
 #endif /* __KERNEL__ */
 #endif /* _POWERPC_PROM_H */
Index: linux-work/arch/powerpc/kernel/legacy_serial.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/legacy_serial.c	2005-11-30 15:37:21.000000000 +1100
+++ linux-work/arch/powerpc/kernel/legacy_serial.c	2005-11-30 15:38:27.000000000 +1100
@@ -146,6 +146,7 @@ static int __init add_legacy_pci_port(st
 {
 	phys_addr_t addr, base;
 	u32 *addrp;
+	unsigned int flags;
 	int iotype, index = -1, lindex = 0;
 
 	/* We only support ports that have a clock frequency properly
@@ -159,12 +160,12 @@ static int __init add_legacy_pci_port(st
 		return -1;
 
 	/* Get the PCI address. Assume BAR 0 */
-	addrp = of_get_pci_address(pci_dev, 0, NULL);
+	addrp = of_get_pci_address(pci_dev, 0, NULL, &flags);
 	if (addrp == NULL)
 		return -1;
 
 	/* We only support BAR 0 for now */
-	iotype = (addrp[0] & 0x02000000) ? UPIO_MEM : UPIO_PORT;
+	iotype = (flags & IORESOURCE_MEM) ? UPIO_MEM : UPIO_PORT;
 	addr = of_translate_address(pci_dev, addrp);
 
 	/* Set the IO base to the same as the translated address for MMIO,
Index: linux-work/arch/powerpc/kernel/pci_64.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/pci_64.c	2005-11-30 15:37:21.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci_64.c	2005-11-30 15:38:27.000000000 +1100
@@ -1181,6 +1181,20 @@ void phbs_remap_io(void)
 		remap_bus_range(hose->bus);
 }
 
+unsigned int pci_address_to_pio(phys_addr_t address)
+{
+	struct pci_controller *hose, *tmp;
+
+	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
+		if (address >= hose->io_base_phys &&
+		    address < (hose->io_base_phys + hose->pci_io_size))
+			return (unsigned int)hose->io_base_virt +
+				(address - hose->io_base_phys);
+	}
+	return (unsigned int)-1;
+}
+EXPORT_SYMBOL_GPL(pci_address_to_pio);
+
 static void __devinit fixup_resource(struct resource *res, struct pci_dev *dev)
 {
 	struct pci_controller *hose = pci_bus_to_host(dev->bus);
Index: linux-work/arch/powerpc/kernel/prom_parse.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/prom_parse.c	2005-11-30 15:37:21.000000000 +1100
+++ linux-work/arch/powerpc/kernel/prom_parse.c	2005-11-30 16:20:22.000000000 +1100
@@ -4,7 +4,9 @@
 #include <linux/string.h>
 #include <linux/pci_regs.h>
 #include <linux/module.h>
+#include <linux/ioport.h>
 #include <asm/prom.h>
+#include <asm/pci-bridge.h>
 
 #ifdef DEBUG
 #define DBG(fmt...) do { printk(fmt); } while(0)
@@ -54,6 +56,7 @@ struct of_bus {
 				       int *addrc, int *sizec);
 	u64		(*map)(u32 *addr, u32 *range, int na, int ns, int pna);
 	int		(*translate)(u32 *addr, u64 offset, int na);
+	unsigned int	(*get_flags)(u32 *addr);
 };
 
 
@@ -61,8 +64,8 @@ struct of_bus {
  * Default translator (generic bus)
  */
 
-static void of_default_count_cells(struct device_node *dev,
-				   int *addrc, int *sizec)
+static void of_bus_default_count_cells(struct device_node *dev,
+				       int *addrc, int *sizec)
 {
 	if (addrc)
 		*addrc = prom_n_addr_cells(dev);
@@ -70,7 +73,7 @@ static void of_default_count_cells(struc
 		*sizec = prom_n_size_cells(dev);
 }
 
-static u64 of_default_map(u32 *addr, u32 *range, int na, int ns, int pna)
+static u64 of_bus_default_map(u32 *addr, u32 *range, int na, int ns, int pna)
 {
 	u64 cp, s, da;
 
@@ -86,7 +89,7 @@ static u64 of_default_map(u32 *addr, u32
 	return da - cp;
 }
 
-static int of_default_translate(u32 *addr, u64 offset, int na)
+static int of_bus_default_translate(u32 *addr, u64 offset, int na)
 {
 	u64 a = of_read_addr(addr, na);
 	memset(addr, 0, na * 4);
@@ -98,6 +101,11 @@ static int of_default_translate(u32 *add
 	return 0;
 }
 
+static unsigned int of_bus_default_get_flags(u32 *addr)
+{
+	return IORESOURCE_MEM;
+}
+
 
 /*
  * PCI bus specific translator
@@ -139,7 +147,24 @@ static u64 of_bus_pci_map(u32 *addr, u32
 
 static int of_bus_pci_translate(u32 *addr, u64 offset, int na)
 {
-	return of_default_translate(addr + 1, offset, na - 1);
+	return of_bus_default_translate(addr + 1, offset, na - 1);
+}
+
+static unsigned int of_bus_pci_get_flags(u32 *addr)
+{
+	unsigned int flags = 0;
+	u32 w = addr[0];
+
+	switch((w >> 24) & 0x03) {
+	case 0x01:
+		flags |= IORESOURCE_IO;
+	case 0x02: /* 32 bits */
+	case 0x03: /* 64 bits */
+		flags |= IORESOURCE_MEM;
+	}
+	if (w & 0x40000000)
+		flags |= IORESOURCE_PREFETCH;
+	return flags;
 }
 
 /*
@@ -182,9 +207,22 @@ static u64 of_bus_isa_map(u32 *addr, u32
 
 static int of_bus_isa_translate(u32 *addr, u64 offset, int na)
 {
-	return of_default_translate(addr + 1, offset, na - 1);
+	return of_bus_default_translate(addr + 1, offset, na - 1);
 }
 
+static unsigned int of_bus_isa_get_flags(u32 *addr)
+{
+	unsigned int flags = 0;
+	u32 w = addr[0];
+
+	if (w & 1)
+		flags |= IORESOURCE_IO;
+	else
+		flags |= IORESOURCE_MEM;
+	return flags;
+}
+
+
 /*
  * Array of bus specific translators
  */
@@ -198,6 +236,7 @@ static struct of_bus of_busses[] = {
 		.count_cells = of_bus_pci_count_cells,
 		.map = of_bus_pci_map,
 		.translate = of_bus_pci_translate,
+		.get_flags = of_bus_pci_get_flags,
 	},
 	/* ISA */
 	{
@@ -207,15 +246,17 @@ static struct of_bus of_busses[] = {
 		.count_cells = of_bus_isa_count_cells,
 		.map = of_bus_isa_map,
 		.translate = of_bus_isa_translate,
+		.get_flags = of_bus_isa_get_flags,
 	},
 	/* Default */
 	{
 		.name = "default",
 		.addresses = "reg",
 		.match = NULL,
-		.count_cells = of_default_count_cells,
-		.map = of_default_map,
-		.translate = of_default_translate,
+		.count_cells = of_bus_default_count_cells,
+		.map = of_bus_default_map,
+		.translate = of_bus_default_translate,
+		.get_flags = of_bus_default_get_flags,
 	},
 };
 
@@ -254,7 +295,8 @@ static int of_translate_one(struct devic
 	ranges = (u32 *)get_property(parent, "ranges", &rlen);
 	if (ranges == NULL || rlen == 0) {
 		offset = of_read_addr(addr, na);
-		memset(addr, 0, pna);
+		memset(addr, 0, pna * 4);
+		DBG("OF: no ranges, 1:1 translation\n");
 		goto finish;
 	}
 
@@ -370,7 +412,8 @@ u64 of_translate_address(struct device_n
 }
 EXPORT_SYMBOL(of_translate_address);
 
-u32 *of_get_address(struct device_node *dev, int index, u64 *size)
+u32 *of_get_address(struct device_node *dev, int index, u64 *size,
+		    unsigned int *flags)
 {
 	u32 *prop;
 	unsigned int psize;
@@ -399,22 +442,106 @@ u32 *of_get_address(struct device_node *
 		if (i == index) {
 			if (size)
 				*size = of_read_addr(prop + na, ns);
+			if (flags)
+				*flags = bus->get_flags(prop);
 			return prop;
 		}
 	return NULL;
 }
 EXPORT_SYMBOL(of_get_address);
 
-u32 *of_get_pci_address(struct device_node *dev, int bar_no, u64 *size)
+u32 *of_get_pci_address(struct device_node *dev, int bar_no, u64 *size,
+			unsigned int *flags)
 {
-	u32 *addr;
-	int index;
+	u32 *prop;
+	unsigned int psize;
+	struct device_node *parent;
+	struct of_bus *bus;
+	int onesize, i, na, ns;
 
-	for (index = 0; (addr = of_get_address(dev, index, size)) != NULL;
-	     index++) {
-		if ((addr[0] & 0xff) == ((bar_no * 4) + PCI_BASE_ADDRESS_0))
-			return addr;
-	}
+	/* Get parent & match bus type */
+	parent = of_get_parent(dev);
+	if (parent == NULL)
+		return NULL;
+	bus = of_match_bus(parent);
+	if (strcmp(bus->name, "pci"))
+		return NULL;
+	bus->count_cells(dev, &na, &ns);
+	of_node_put(parent);
+	if (!OF_CHECK_COUNTS(na, ns))
+		return NULL;
+
+	/* Get "reg" or "assigned-addresses" property */
+	prop = (u32 *)get_property(dev, bus->addresses, &psize);
+	if (prop == NULL)
+		return NULL;
+	psize /= 4;
+
+	onesize = na + ns;
+	for (i = 0; psize >= onesize; psize -= onesize, prop += onesize, i++)
+		if ((prop[0] & 0xff) == ((bar_no * 4) + PCI_BASE_ADDRESS_0)) {
+			if (size)
+				*size = of_read_addr(prop + na, ns);
+			if (flags)
+				*flags = bus->get_flags(prop);
+			return prop;
+		}
 	return NULL;
 }
 EXPORT_SYMBOL(of_get_pci_address);
+
+static int __of_address_to_resource(struct device_node *dev, u32 *addrp,
+				    u64 size, unsigned int flags,
+				    struct resource *r)
+{
+	u64 taddr;
+
+	if ((flags & (IORESOURCE_IO | IORESOURCE_MEM)) == 0)
+		return -EINVAL;
+	taddr = of_translate_address(dev, addrp);
+	if (taddr == OF_BAD_ADDR)
+		return -EINVAL;
+	memset(r, 0, sizeof(struct resource));
+	if (flags & IORESOURCE_IO) {
+		unsigned int port;
+		port = pci_address_to_pio(taddr);
+		if (port == (unsigned int)-1)
+			return -EINVAL;
+		r->start = port;
+		r->end = port + size - 1;
+	} else {
+		r->start = taddr;
+		r->end = taddr + size - 1;
+	}
+	r->flags = flags;
+	r->name = dev->name;
+	return 0;
+}
+
+int of_address_to_resource(struct device_node *dev, int index,
+			   struct resource *r)
+{
+	u32		*addrp;
+	u64		size;
+	unsigned int	flags;
+
+	addrp = of_get_address(dev, index, &size, &flags);
+	if (addrp == NULL)
+		return -EINVAL;
+	return __of_address_to_resource(dev, addrp, size, flags, r);
+}
+EXPORT_SYMBOL_GPL(of_address_to_resource);
+
+int of_pci_address_to_resource(struct device_node *dev, int bar,
+			       struct resource *r)
+{
+	u32		*addrp;
+	u64		size;
+	unsigned int	flags;
+
+	addrp = of_get_pci_address(dev, bar, &size, &flags);
+	if (addrp == NULL)
+		return -EINVAL;
+	return __of_address_to_resource(dev, addrp, size, flags, r);
+}
+EXPORT_SYMBOL_GPL(of_pci_address_to_resource);
Index: linux-work/arch/powerpc/platforms/powermac/feature.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/feature.c	2005-11-30 15:37:21.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/feature.c	2005-11-30 16:19:51.000000000 +1100
@@ -2672,7 +2672,7 @@ static void __init probe_one_macio(const
 		printk(KERN_ERR "pmac_feature: %s skipped\n", node->full_name);
 		return;
 	}
-	addrp = of_get_pci_address(node, 0, &size);
+	addrp = of_get_pci_address(node, 0, &size, NULL);
 	if (addrp == NULL) {
 		printk(KERN_ERR "pmac_feature: %s: can't find base !\n",
 		       node->full_name);
Index: linux-work/arch/ppc/kernel/pci.c
===================================================================
--- linux-work.orig/arch/ppc/kernel/pci.c	2005-11-30 15:37:21.000000000 +1100
+++ linux-work/arch/ppc/kernel/pci.c	2005-11-30 15:38:27.000000000 +1100
@@ -1805,6 +1805,21 @@ void pci_iounmap(struct pci_dev *dev, vo
 EXPORT_SYMBOL(pci_iomap);
 EXPORT_SYMBOL(pci_iounmap);
 
+unsigned int pci_address_to_pio(phys_addr_t address)
+{
+	struct pci_controller* hose = hose_head;
+
+	for (; hose; hose = hose->next) {
+		unsigned int size = hose->io_resource.end -
+			hose->io_resource.start + 1;
+		if (address >= hose->io_base_phys &&
+		    address < (hose->io_base_phys + size))
+			return (unsigned int)hose->io_base_virt +
+				(address - hose->io_base_phys);
+	}
+	return (unsigned int)-1;
+}
+EXPORT_SYMBOL(pci_address_to_pio);
 
 /*
  * Null PCI config access functions, for the case when we can't
Index: linux-work/drivers/macintosh/macio_asic.c
===================================================================
--- linux-work.orig/drivers/macintosh/macio_asic.c	2005-11-30 15:37:21.000000000 +1100
+++ linux-work/drivers/macintosh/macio_asic.c	2005-11-30 16:19:51.000000000 +1100
@@ -332,18 +332,14 @@ static void macio_setup_resources(struct
 				  struct resource *parent_res)
 {
 	struct device_node *np = dev->ofdev.node;
-	u32 *addr;
-	u64 size;
+	struct resource r;
 	int index;
 
-	for (index = 0; (addr = of_get_address(np, index, &size)) != NULL;
-	     index++) {
+	for (index = 0; of_address_to_resource(np, index, &r) == 0; index++) {
 		struct resource *res = &dev->resource[index];
 		if (index >= MACIO_DEV_COUNT_RESOURCES)
 			break;
-		res->start = of_translate_address(np, addr);
-		res->end = res->start + (unsigned long)size - 1;
-		res->flags = IORESOURCE_MEM;
+		*res = r;
 		res->name = dev->ofdev.dev.bus_id;
 
 		if (macio_resource_quirks(np, res, index)) {
@@ -353,7 +349,7 @@ static void macio_setup_resources(struct
 		/* Currently, we consider failure as harmless, this may
 		 * change in the future, once I've found all the device
 		 * tree bugs in older machines & worked around them
-		 */
+l		 */
 		if (insert_resource(parent_res, res)) {
 			printk(KERN_WARNING "Can't request resource "
 			       "%d for MacIO device %s\n",
Index: linux-work/include/asm-powerpc/pci-bridge.h
===================================================================
--- linux-work.orig/include/asm-powerpc/pci-bridge.h	2005-11-30 15:37:21.000000000 +1100
+++ linux-work/include/asm-powerpc/pci-bridge.h	2005-11-30 15:38:27.000000000 +1100
@@ -157,6 +157,15 @@ extern struct pci_controller *
 pcibios_alloc_controller(struct device_node *dev);
 extern void pcibios_free_controller(struct pci_controller *phb);
 
+#ifdef CONFIG_PCI
+extern unsigned int pci_address_to_pio(phys_addr_t address);
+#else
+static inline unsigned int pci_address_to_pio(phys_addr_t address)
+{
+	return (unsigned int)-1;
+}
+#endif
+
 /* Return values for ppc_md.pci_probe_mode function */
 #define PCI_PROBE_NONE		-1	/* Don't look at this bus at all */
 #define PCI_PROBE_NORMAL	0	/* Do normal PCI probing */
Index: linux-work/include/asm-ppc/pci-bridge.h
===================================================================
--- linux-work.orig/include/asm-ppc/pci-bridge.h	2005-11-30 15:37:21.000000000 +1100
+++ linux-work/include/asm-ppc/pci-bridge.h	2005-11-30 15:38:27.000000000 +1100
@@ -137,5 +137,14 @@ static inline unsigned char bridge_swizz
  */
 extern int pciauto_bus_scan(struct pci_controller *, int);
 
+#ifdef CONFIG_PCI
+extern unsigned int pci_address_to_pio(phys_addr_t address);
+#else
+static inline unsigned int pci_address_to_pio(phys_addr_t address)
+{
+	return (unsigned int)-1;
+}
+#endif
+
 #endif
 #endif /* __KERNEL__ */
Index: linux-work/include/asm-ppc/prom.h
===================================================================
--- linux-work.orig/include/asm-ppc/prom.h	2005-11-30 15:37:21.000000000 +1100
+++ linux-work/include/asm-ppc/prom.h	2005-11-30 15:38:27.000000000 +1100
@@ -138,12 +138,34 @@ extern unsigned long sub_reloc_offset(un
 
 
 /*
- * Address translation function(s)
+ * OF address retreival & translation
+ */
+
+
+/* Translate an OF address block into a CPU physical address
  */
 #define OF_BAD_ADDR	((u64)-1)
 extern u64 of_translate_address(struct device_node *np, u32 *addr);
-extern u32 *of_get_address(struct device_node *dev, int index, u64 *size);
-extern u32 *of_get_pci_address(struct device_node *dev, int bar_no, u64 *size);
+
+/* Extract an address from a device, returns the region size and
+ * the address space flags too. The PCI version uses a BAR number
+ * instead of an absolute index
+ */
+extern u32 *of_get_address(struct device_node *dev, int index,
+			   u64 *size, unsigned int *flags);
+extern u32 *of_get_pci_address(struct device_node *dev, int bar_no,
+			       u64 *size, unsigned int *flags);
+
+/* Get an address as a resource. Note that if your address is
+ * a PIO address, the conversion will fail if the physical address
+ * can't be internally converted to an IO token with
+ * pci_address_to_pio(), that is because it's either called to early
+ * or it can't be matched to any host bridge IO space
+ */
+extern int of_address_to_resource(struct device_node *dev, int index,
+				  struct resource *r);
+extern int of_pci_address_to_resource(struct device_node *dev, int bar,
+				      struct resource *r);
 
 
 #endif /* _PPC_PROM_H */
