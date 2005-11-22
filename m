Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Content-Type: text/plain
Date: Tue, 22 Nov 2005 15:45:53 +1100
Message-Id: <1132634753.26560.128.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Add OF address parsing code
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Parsing addresses extracted from Open Firmware isn't a simple matter. We
have various bits of code that try to do it in various place, including
some heuristics in prom.c that pre-parse addresses at boot and fill
device-nodes "addrs", but those are dodgy at best and I want to
deprecate them. So this patch introduces a new set of routines that
should be capable of parsing most types of addresses and translating
them into CPU physical addresses. It currently works for things on PCI
busses and ISA busses and should work on "standard" busses like the root
bus or the MacIO bus that don't put funky flags in addresses. If you
have other bus types that do use funky flags, you'll have to add new bus
type translators, which is fairly easy.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

This is not for 2.6.15. It's part of a series of patch which, when complete,
will unify serial port detection and udbg, and remove completely "addrs"
and the crappy heuristics from prom.c

Index: linux-serialfix/arch/powerpc/kernel/Makefile
===================================================================
--- linux-serialfix.orig/arch/powerpc/kernel/Makefile	2005-11-22 14:41:26.000000000 +1100
+++ linux-serialfix/arch/powerpc/kernel/Makefile	2005-11-22 15:43:43.000000000 +1100
@@ -12,7 +12,8 @@
 endif
 
 obj-y				:= semaphore.o cputable.o ptrace.o syscalls.o \
-				   irq.o align.o signal_32.o pmc.o vdso.o
+				   irq.o align.o signal_32.o pmc.o vdso.o \
+				   prom_parse.o
 obj-y				+= vdso32/
 obj-$(CONFIG_PPC64)		+= setup_64.o binfmt_elf32.o sys_ppc32.o \
 				   signal_64.o ptrace32.o systbl.o \
Index: linux-serialfix/arch/powerpc/kernel/prom_parse.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-serialfix/arch/powerpc/kernel/prom_parse.c	2005-11-22 15:11:59.000000000 +1100
@@ -0,0 +1,404 @@
+#undef DEBUG
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/pci_regs.h>
+#include <linux/module.h>
+#include <asm/prom.h>
+
+#ifdef DEBUG
+#define DBG(fmt...) do { printk(fmt); } while(0)
+#else
+#define DBG(fmt...) do { } while(0)
+#endif
+
+/* Max address size we deal with */
+#define OF_MAX_ADDR_CELLS	4
+#define OF_CHECK_COUNTS(na, ns)	((na) > 0 && (na) <= OF_MAX_ADDR_CELLS && \
+			(ns) > 0)
+
+/* Debug utility */
+#ifdef DEBUG
+static void of_dump_addr(const char *s, u32 *addr, int na)
+{
+	printk("%s", s);
+	while(na--)
+		printk(" %08x", *(addr++));
+	printk("\n");
+}
+#else
+static void of_dump_addr(const char *s, u32 *addr, int na) { }
+#endif
+
+/* Read a big address */
+static inline u64 of_read_addr(u32 *cell, int size)
+{
+	u64 r = 0;
+	while (size--)
+		r = (r << 32) | *(cell++);
+	return r;
+}
+
+/* Callbacks for bus specific translators */
+struct of_bus {
+	char		*name;
+	int		(*match)(struct device_node *parent);
+	void		(*count_cells)(struct device_node *child,
+				       int *addrc, int *sizec);
+	u64		(*map)(u32 *addr, u32 *range, int na, int ns, int pna);
+	int		(*translate)(u32 *addr, u64 offset, int na);
+};
+
+
+/*
+ * Default translator (generic bus)
+ */
+
+static void of_default_count_cells(struct device_node *dev,
+				   int *addrc, int *sizec)
+{
+	if (addrc)
+		*addrc = prom_n_addr_cells(dev);
+	if (sizec)
+		*sizec = prom_n_size_cells(dev);
+}
+
+static u64 of_default_map(u32 *addr, u32 *range, int na, int ns, int pna)
+{
+	u64 cp, s, da;
+
+	cp = of_read_addr(range, na);
+	s  = of_read_addr(range + na + pna, ns);
+	da = of_read_addr(addr, na);
+
+	DBG("OF: default map, cp=%lx, s=%lx, da=%lx\n", cp, s, da);
+
+	if (da < cp || da >= (cp + s))
+		return OF_BAD_ADDR;
+	return da - cp;
+}
+
+static int of_default_translate(u32 *addr, u64 offset, int na)
+{
+	u64 a = of_read_addr(addr, na);
+	memset(addr, 0, na * 4);
+	a += offset;
+	if (na > 1)
+		addr[na - 2] = a >> 32;
+	addr[na - 1] = a & 0xffffffffu;
+
+	return 0;
+}
+
+
+/*
+ * PCI bus specific translator
+ */
+
+static int of_bus_pci_match(struct device_node *np)
+{
+	return !strcmp(np->type, "pci");
+}
+
+static void of_bus_pci_count_cells(struct device_node *np,
+				   int *addrc, int *sizec)
+{
+	if (addrc)
+		*addrc = 3;
+	if (sizec)
+		*sizec = 2;
+}
+
+static u64 of_bus_pci_map(u32 *addr, u32 *range, int na, int ns, int pna)
+{
+	u64 cp, s, da;
+
+	/* Check address type match */
+	if ((addr[0] ^ range[0]) & 0x03000000)
+		return OF_BAD_ADDR;
+
+	/* Read address values, skipping high cell */
+	cp = of_read_addr(range + 1, na - 1);
+	s  = of_read_addr(range + na + pna, ns);
+	da = of_read_addr(addr + 1, na - 1);
+
+	DBG("OF: PCI map, cp=%lx, s=%lx, da=%lx\n", cp, s, da);
+
+	if (da < cp || da >= (cp + s))
+		return OF_BAD_ADDR;
+	return da - cp;
+}
+
+static int of_bus_pci_translate(u32 *addr, u64 offset, int na)
+{
+	return of_default_translate(addr + 1, offset, na - 1);
+}
+
+/*
+ * ISA bus specific translator
+ */
+
+static int of_bus_isa_match(struct device_node *np)
+{
+	return !strcmp(np->name, "isa");
+}
+
+static void of_bus_isa_count_cells(struct device_node *child,
+				   int *addrc, int *sizec)
+{
+	if (addrc)
+		*addrc = 2;
+	if (sizec)
+		*sizec = 1;
+}
+
+static u64 of_bus_isa_map(u32 *addr, u32 *range, int na, int ns, int pna)
+{
+	u64 cp, s, da;
+
+	/* Check address type match */
+	if ((addr[0] ^ range[0]) & 0x00000001)
+		return OF_BAD_ADDR;
+
+	/* Read address values, skipping high cell */
+	cp = of_read_addr(range + 1, na - 1);
+	s  = of_read_addr(range + na + pna, ns);
+	da = of_read_addr(addr + 1, na - 1);
+
+	DBG("OF: ISA map, cp=%lx, s=%lx, da=%lx\n", cp, s, da);
+
+	if (da < cp || da >= (cp + s))
+		return OF_BAD_ADDR;
+	return da - cp;
+}
+
+static int of_bus_isa_translate(u32 *addr, u64 offset, int na)
+{
+	return of_default_translate(addr + 1, offset, na - 1);
+}
+
+/*
+ * Array of bus specific translators
+ */
+
+static struct of_bus of_busses[] = {
+	/* PCI */
+	{
+		.name = "pci",
+		.match = of_bus_pci_match,
+		.count_cells = of_bus_pci_count_cells,
+		.map = of_bus_pci_map,
+		.translate = of_bus_pci_translate,
+	},
+	/* ISA */
+	{
+		.name = "isa",
+		.match = of_bus_isa_match,
+		.count_cells = of_bus_isa_count_cells,
+		.map = of_bus_isa_map,
+		.translate = of_bus_isa_translate,
+	},
+	/* Default */
+	{
+		.name = "default",
+		.match = NULL,
+		.count_cells = of_default_count_cells,
+		.map = of_default_map,
+		.translate = of_default_translate,
+	},
+};
+
+static struct of_bus *of_match_bus(struct device_node *np)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(of_busses); i ++)
+		if (!of_busses[i].match || of_busses[i].match(np))
+			return &of_busses[i];
+	BUG();
+	return NULL;
+}
+
+static int of_translate_one(struct device_node *parent, struct of_bus *bus,
+			    struct of_bus *pbus, u32 *addr,
+			    int na, int ns, int pna)
+{
+	u32 *ranges;
+	unsigned int rlen;
+	int rone;
+	u64 offset = OF_BAD_ADDR;
+
+	/* No "ranges" property is not an error */
+	ranges = (u32 *)get_property(parent, "ranges", &rlen);
+	if (ranges == NULL) {
+		offset = of_read_addr(addr, na);
+		memset(addr, 0, pna);
+		goto finish;
+	}
+
+	DBG("OF: walking ranges...\n");
+
+	/* Now walk through the ranges */
+	rlen /= 4;
+	rone = na + pna + ns;
+	for (; rlen >= rone; rlen -= rone, ranges += rone) {
+		offset = bus->map(addr, ranges, na, ns, pna);
+		if (offset != OF_BAD_ADDR)
+			break;
+	}
+	if (offset == OF_BAD_ADDR) {
+		DBG("OF: not found !\n");
+		return 1;
+	}
+	memcpy(addr, ranges + na, 4 * pna);
+
+ finish:
+	of_dump_addr("OF: parent translation for:", addr, pna);
+	DBG("OF: with offset: %lx\n", offset);
+
+	/* Translate it into parent bus space */
+	return pbus->translate(addr, offset, pna);
+}
+
+
+/*
+ * Translate an address from the device-tree into a CPU physical address,
+ * this walks up the tree and applies the various bus mappings on the
+ * way.
+ *
+ * Note: We consider that crossing any level with #size-cells == 0 to mean
+ * that translation is impossible (that is we are not dealing with a value
+ * that can be mapped to a cpu physical address). This is not really specified
+ * that way, but this is traditionally the way IBM at least do things
+ */
+u64 of_translate_address(struct device_node *dev, u32 *in_addr)
+{
+	struct device_node *parent = NULL;
+	struct of_bus *bus, *pbus;
+	u32 addr[OF_MAX_ADDR_CELLS];
+	int na, ns, pna, pns;
+	u64 result = OF_BAD_ADDR;
+
+	DBG("OF: ** translation for device %s **\n", dev->full_name);
+
+	/* Increase refcount at current level */
+	of_node_get(dev);
+
+	/* Get parent & match bus type */
+	parent = of_get_parent(dev);
+	if (parent == NULL)
+		goto bail;
+	bus = of_match_bus(parent);
+
+	/* Cound address cells & copy address locally */
+	bus->count_cells(dev, &na, &ns);
+	if (!OF_CHECK_COUNTS(na, ns)) {
+		printk(KERN_ERR "prom_parse: Bad cell count for %s\n",
+		       dev->full_name);
+		goto bail;
+	}
+	memcpy(addr, in_addr, na * 4);
+
+	DBG("OF: bus is %s (na=%d, ns=%d) on %s\n",
+	    bus->name, na, ns, parent->full_name);
+	of_dump_addr("OF: translating address:", addr, na);
+
+	/* Translate */
+	for (;;) {
+		/* Switch to parent bus */
+		of_node_put(dev);
+		dev = parent;
+		parent = of_get_parent(dev);
+
+		/* If root, we have finished */
+		if (parent == NULL) {
+			DBG("OF: reached root node\n");
+			result = of_read_addr(addr, na);
+			break;
+		}
+
+		/* Get new parent bus and counts */
+		pbus = of_match_bus(parent);
+		pbus->count_cells(dev, &pna, &pns);
+		if (!OF_CHECK_COUNTS(pna, pns)) {
+			printk(KERN_ERR "prom_parse: Bad cell count for %s\n",
+			       dev->full_name);
+			break;
+		}
+
+		DBG("OF: parent bus is %s (na=%d, ns=%d) on %s\n",
+		    pbus->name, pna, pns, parent->full_name);
+
+		/* Apply bus translation */
+		if (of_translate_one(dev, bus, pbus, addr, na, ns, pna))
+			break;
+
+		/* Complete the move up one level */
+		na = pna;
+		ns = pns;
+		bus = pbus;
+
+		of_dump_addr("OF: one level translation:", addr, na);
+	}
+ bail:
+	of_node_put(parent);
+	of_node_put(dev);
+
+	return result;
+}
+EXPORT_SYMBOL(of_translate_address);
+
+u32 *of_get_address(struct device_node *dev, int index, u64 *size)
+{
+	u32 *prop;
+	unsigned int psize;
+	struct device_node *parent;
+	struct of_bus *bus;
+	int onesize, i, na, ns;
+
+	/* Get "reg" property */
+	prop = (u32 *)get_property(dev, "reg", &psize);
+	if (prop == NULL)
+		return NULL;
+	psize /= 4;
+
+	/* Get parent & match bus type */
+	parent = of_get_parent(dev);
+	if (parent == NULL)
+		return NULL;
+	bus = of_match_bus(parent);
+	bus->count_cells(dev, &na, &ns);
+	of_node_put(parent);
+	if (!OF_CHECK_COUNTS(na, ns))
+		return NULL;
+
+	onesize = na + ns;
+	for (i = 0; psize >= onesize; psize -= onesize, prop += onesize, i++)
+		if (i == index) {
+			if (size)
+				*size = of_read_addr(prop + na, ns);
+			return prop;
+		}
+	return NULL;
+}
+EXPORT_SYMBOL(of_get_address);
+
+u32 *of_get_pci_addr(struct device_node *pd, int bar, u64 *out_size)
+{
+	u32 *prop;
+	unsigned int psize;
+
+	prop = (u32 *)get_property(pd, "assigned-addresses", &psize);
+	if (prop == NULL)
+		return NULL;
+	psize /= 4;
+	for (; psize >= 5; psize -= 5, prop += 5) {
+		if (bar == (((prop[0] & 0xff) - PCI_BASE_ADDRESS_0) / 4)) {
+			if (out_size)
+				*out_size = of_read_addr(prop + 3, 2);
+			return prop;
+		}
+	}
+	return NULL;
+}
+EXPORT_SYMBOL(of_get_pci_addr);
Index: linux-serialfix/include/asm-powerpc/mmu.h
===================================================================
--- linux-serialfix.orig/include/asm-powerpc/mmu.h	2005-11-22 14:41:26.000000000 +1100
+++ linux-serialfix/include/asm-powerpc/mmu.h	2005-11-22 14:41:49.000000000 +1100
@@ -393,6 +393,10 @@
 #define VSID_SCRAMBLE(pvsid)	(((pvsid) * VSID_MULTIPLIER) % VSID_MODULUS)
 #define KERNEL_VSID(ea)		VSID_SCRAMBLE(GET_ESID(ea))
 
+/* Physical address used by some IO functions */
+typedef unsigned long phys_addr_t;
+
+
 #endif /* __ASSEMBLY */
 
 #endif /* CONFIG_PPC64 */
Index: linux-serialfix/include/asm-powerpc/prom.h
===================================================================
--- linux-serialfix.orig/include/asm-powerpc/prom.h	2005-11-22 14:41:26.000000000 +1100
+++ linux-serialfix/include/asm-powerpc/prom.h	2005-11-22 14:41:49.000000000 +1100
@@ -223,5 +223,14 @@
 				int index, const char* name_postfix);
 extern int release_OF_resource(struct device_node* node, int index);
 
+/*
+ * Address translation function(s)
+ */
+#define OF_BAD_ADDR	((u64)-1)
+extern u64 of_translate_address(struct device_node *np, u32 *addr);
+extern u32 *of_get_address(struct device_node *dev, int index, u64 *size);
+extern u32 *of_get_pci_addr(struct device_node *pd, int bar, u64 *out_size);
+
+
 #endif /* __KERNEL__ */
 #endif /* _POWERPC_PROM_H */
Index: linux-serialfix/include/asm-ppc/prom.h
===================================================================
--- linux-serialfix.orig/include/asm-ppc/prom.h	2005-11-22 14:41:26.000000000 +1100
+++ linux-serialfix/include/asm-ppc/prom.h	2005-11-22 14:41:49.000000000 +1100
@@ -136,5 +136,15 @@
 #define PTRRELOC(x)	((typeof(x))add_reloc_offset((unsigned long)(x)))
 #define PTRUNRELOC(x)	((typeof(x))sub_reloc_offset((unsigned long)(x)))
 
+
+/*
+ * Address translation function(s)
+ */
+#define OF_BAD_ADDR	((u64)-1)
+extern u64 of_translate_address(struct device_node *np, u32 *addr);
+extern u32 *of_get_address(struct device_node *dev, int index, u64 *size);
+extern u32 *of_get_pci_addr(struct device_node *pd, int bar, u64 *out_size);
+
+
 #endif /* _PPC_PROM_H */
 #endif /* __KERNEL__ */
