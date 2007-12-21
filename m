Return-Path: <benh@ozlabs.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 21 Dec 2007 15:39:22 +1100
Subject: [PATCH 3/21] [POWERPC] 4xx PLB to PCI-X support
Message-Id: <20071221043926.67C65DDE37@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds base support code for the 4xx PCI-X bridge. It also provides
placeholders for the PCI and PCI-E version but they aren't supported
with this patch.

The bridges are configured based on device-tree properties.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Tested on 440GP only so far.

 arch/powerpc/sysdev/Makefile     |    3 
 arch/powerpc/sysdev/ppc4xx_pci.c |  339 +++++++++++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/ppc4xx_pci.h |  106 ++++++++++++
 3 files changed, 448 insertions(+)

--- linux-merge.orig/arch/powerpc/sysdev/Makefile	2007-12-14 15:48:56.000000000 +1100
+++ linux-merge/arch/powerpc/sysdev/Makefile	2007-12-14 15:49:42.000000000 +1100
@@ -27,6 +27,9 @@ obj-$(CONFIG_PPC_I8259)		+= i8259.o
 obj-$(CONFIG_PPC_83xx)		+= ipic.o
 obj-$(CONFIG_4xx)		+= uic.o
 obj-$(CONFIG_XILINX_VIRTEX)	+= xilinx_intc.o
+ifeq ($(CONFIG_PCI),y)
+obj-$(CONFIG_4xx)		+= ppc4xx_pci.o
+endif
 endif
 
 # Temporary hack until we have migrated to asm-powerpc
Index: linux-merge/arch/powerpc/sysdev/ppc4xx_pci.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-merge/arch/powerpc/sysdev/ppc4xx_pci.c	2007-12-14 15:49:42.000000000 +1100
@@ -0,0 +1,339 @@
+/*
+ * PCI / PCI-X / PCI-Express support for 4xx parts
+ *
+ * Copyright 2007 Ben. Herrenschmidt <benh@kernel.crashing.org>, IBM Corp.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/of.h>
+
+#include <asm/io.h>
+#include <asm/pci-bridge.h>
+#include <asm/machdep.h>
+
+#include "ppc4xx_pci.h"
+
+static int dma_offset_set;
+
+/* Move that to a useable header */
+extern unsigned long total_memory;
+
+static int __init ppc4xx_parse_dma_ranges(struct pci_controller *hose,
+					  void __iomem *reg,
+					  struct resource *res)
+{
+	u64 size;
+	const u32 *ranges;
+	int rlen;
+	int pna = of_n_addr_cells(hose->dn);
+	int np = pna + 5;
+
+	/* Default */
+	res->start = 0;
+	res->end = size = 0x80000000;
+	res->flags = IORESOURCE_MEM | IORESOURCE_PREFETCH;
+
+	/* Get dma-ranges property */
+	ranges = of_get_property(hose->dn, "dma-ranges", &rlen);
+	if (ranges == NULL)
+		goto out;
+
+	/* Walk it */
+	while ((rlen -= np * 4) >= 0) {
+		u32 pci_space = ranges[0];
+		u64 pci_addr = of_read_number(ranges + 1, 2);
+		u64 cpu_addr = of_translate_dma_address(hose->dn, ranges + 3);
+		size = of_read_number(ranges + pna + 3, 2);
+		ranges += np;
+		if (cpu_addr == OF_BAD_ADDR || size == 0)
+			continue;
+
+		/* We only care about memory */
+		if ((pci_space & 0x03000000) != 0x02000000)
+			continue;
+
+		/* We currently only support memory at 0, and pci_addr
+		 * within 32 bits space
+		 */
+		if (cpu_addr != 0 || pci_addr > 0xffffffff) {
+			printk(KERN_WARNING "%s: Ignored unsupported dma range"
+			       " 0x%016llx...0x%016llx -> 0x%016llx\n",
+			       hose->dn->full_name,
+			       pci_addr, pci_addr + size - 1, cpu_addr);
+			continue;
+		}
+
+		/* Check if not prefetchable */
+		if (!(pci_space & 0x40000000))
+			res->flags &= ~IORESOURCE_PREFETCH;
+
+
+		/* Use that */
+		res->start = pci_addr;
+#ifndef CONFIG_RESOURCES_64BIT
+		/* Beware of 32 bits resources */
+		if ((pci_addr + size) > 0x100000000ull)
+			res->end = 0xffffffff;
+		else
+#endif
+			res->end = res->start + size - 1;
+		break;
+	}
+
+	/* We only support one global DMA offset */
+	if (dma_offset_set && pci_dram_offset != res->start) {
+		printk(KERN_ERR "%s: dma-ranges(s) mismatch\n",
+		       hose->dn->full_name);
+		return -ENXIO;
+	}
+
+	/* Check that we can fit all of memory as we don't support
+	 * DMA bounce buffers
+	 */
+	if (size < total_memory) {
+		printk(KERN_ERR "%s: dma-ranges too small "
+		       "(size=%llx total_memory=%lx)\n",
+		       hose->dn->full_name, size, total_memory);
+		return -ENXIO;
+	}
+
+	/* Check we are a power of 2 size and that base is a multiple of size*/
+	if (!is_power_of_2(size) ||
+	    (res->start & (size - 1)) != 0) {
+		printk(KERN_ERR "%s: dma-ranges unaligned\n",
+		       hose->dn->full_name);
+		return -ENXIO;
+	}
+
+	/* Check that we are fully contained within 32 bits space */
+	if (res->end > 0xffffffff) {
+		printk(KERN_ERR "%s: dma-ranges outside of 32 bits space\n",
+		       hose->dn->full_name);
+		return -ENXIO;
+	}
+ out:
+	dma_offset_set = 1;
+	pci_dram_offset = res->start;
+
+	printk(KERN_INFO "4xx PCI DMA offset set to 0x%08lx\n",
+	       pci_dram_offset);
+	return 0;
+}
+
+/*
+ * 4xx PCI 2.x part
+ */
+static void __init ppc4xx_probe_pci_bridge(struct device_node *np)
+{
+	/* NYI */
+}
+
+/*
+ * 4xx PCI-X part
+ */
+
+static void __init ppc4xx_configure_pcix_POMs(struct pci_controller *hose,
+					      void __iomem *reg)
+{
+	u32 lah, lal, pciah, pcial, sa;
+	int i, j;
+
+	/* Setup outbound memory windows */
+	for (i = j = 0; i < 3; i++) {
+		struct resource *res = &hose->mem_resources[i];
+
+		/* we only care about memory windows */
+		if (!(res->flags & IORESOURCE_MEM))
+			continue;
+		if (j > 1) {
+			printk(KERN_WARNING "%s: Too many ranges\n",
+			       hose->dn->full_name);
+			break;
+		}
+
+		/* Calculate register values */
+#ifdef CONFIG_PTE_64BIT
+		lah = res->start >> 32;
+		lal = res->start & 0xffffffffu;
+		pciah = (res->start - hose->pci_mem_offset) >> 32;
+		pcial = (res->start - hose->pci_mem_offset) & 0xffffffffu;
+#else
+		lah = pciah = 0;
+		lal = res->start;
+		pcial = res->start - hose->pci_mem_offset;
+#endif
+		sa = res->end + 1 - res->start;
+		if (!is_power_of_2(sa) || sa < 0x100000 ||
+		    sa > 0xffffffffu) {
+			printk(KERN_WARNING "%s: Resource out of range\n",
+			       hose->dn->full_name);
+			continue;
+		}
+		sa = (0xffffffffu << ilog2(sa)) | 0x1;
+
+		/* Program register values */
+		if (j == 0) {
+			writel(lah, reg + PCIX0_POM0LAH);
+			writel(lal, reg + PCIX0_POM0LAL);
+			writel(pciah, reg + PCIX0_POM0PCIAH);
+			writel(pcial, reg + PCIX0_POM0PCIAL);
+			writel(sa, reg + PCIX0_POM0SA);
+		} else {
+			writel(lah, reg + PCIX0_POM1LAH);
+			writel(lal, reg + PCIX0_POM1LAL);
+			writel(pciah, reg + PCIX0_POM1PCIAH);
+			writel(pcial, reg + PCIX0_POM1PCIAL);
+			writel(sa, reg + PCIX0_POM1SA);
+		}
+		j++;
+	}
+}
+
+static void __init ppc4xx_configure_pcix_PIMs(struct pci_controller *hose,
+					      void __iomem *reg,
+					      const struct resource *res,
+					      int big_pim,
+					      int enable_msi_hole)
+{
+	resource_size_t size = res->end - res->start + 1;
+	u32 sa;
+
+	/* RAM is always at 0 */
+	writel(0x00000000, reg + PCIX0_PIM0LAH);
+	writel(0x00000000, reg + PCIX0_PIM0LAL);
+
+	/* Calculate window size */
+	sa = (0xffffffffu << ilog2(size)) | 1;
+	sa |= 0x1;
+	if (res->flags & IORESOURCE_PREFETCH)
+		sa |= 0x2;
+	if (enable_msi_hole)
+		sa |= 0x4;
+	writel(sa, reg + PCIX0_PIM0SA);
+	if (big_pim)
+		writel(0xffffffff, reg + PCIX0_PIM0SAH);
+
+	/* Map on PCI side */
+	writel(0x00000000, reg + PCIX0_BAR0H);
+	writel(res->start, reg + PCIX0_BAR0L);
+	writew(0x0006, reg + PCIX0_COMMAND);
+}
+
+static void __init ppc4xx_probe_pcix_bridge(struct device_node *np)
+{
+	struct resource rsrc_cfg;
+	struct resource rsrc_reg;
+	struct resource dma_window;
+	struct pci_controller *hose = NULL;
+	void __iomem *reg = NULL;
+	const int *bus_range;
+	int big_pim = 0, msi = 0, primary = 0;
+
+	/* Fetch config space registers address */
+	if (of_address_to_resource(np, 0, &rsrc_cfg)) {
+		printk(KERN_ERR "%s:Can't get PCI-X config register base !",
+		       np->full_name);
+		return;
+	}
+	/* Fetch host bridge internal registers address */
+	if (of_address_to_resource(np, 3, &rsrc_reg)) {
+		printk(KERN_ERR "%s: Can't get PCI-X internal register base !",
+		       np->full_name);
+		return;
+	}
+
+	/* Check if it supports large PIMs (440GX) */
+	if (of_get_property(np, "large-inbound-windows", NULL))
+		big_pim = 1;
+
+	/* Check if we should enable MSIs inbound hole */
+	if (of_get_property(np, "enable-msi-hole", NULL))
+		msi = 1;
+
+	/* Check if primary bridge */
+	if (of_get_property(np, "primary", NULL))
+		primary = 1;
+
+	/* Get bus range if any */
+	bus_range = of_get_property(np, "bus-range", NULL);
+
+	/* Map registers */
+	reg = ioremap(rsrc_reg.start, rsrc_reg.end + 1 - rsrc_reg.start);
+	if (reg == NULL) {
+		printk(KERN_ERR "%s: Can't map registers !", np->full_name);
+		goto fail;
+	}
+
+	/* Allocate the host controller data structure */
+	hose = pcibios_alloc_controller(np);
+	if (!hose)
+		goto fail;
+
+	hose->first_busno = bus_range ? bus_range[0] : 0x0;
+	hose->last_busno = bus_range ? bus_range[1] : 0xff;
+
+	/* Setup config space */
+	setup_indirect_pci(hose, rsrc_cfg.start, rsrc_cfg.start + 0x4, 0);
+
+	/* Disable all windows */
+	writel(0, reg + PCIX0_POM0SA);
+	writel(0, reg + PCIX0_POM1SA);
+	writel(0, reg + PCIX0_POM2SA);
+	writel(0, reg + PCIX0_PIM0SA);
+	writel(0, reg + PCIX0_PIM1SA);
+	writel(0, reg + PCIX0_PIM2SA);
+	if (big_pim) {
+		writel(0, reg + PCIX0_PIM0SAH);
+		writel(0, reg + PCIX0_PIM2SAH);
+	}
+
+	/* Parse outbound mapping resources */
+	pci_process_bridge_OF_ranges(hose, np, primary);
+
+	/* Parse inbound mapping resources */
+	if (ppc4xx_parse_dma_ranges(hose, reg, &dma_window) != 0)
+		goto fail;
+
+	/* Configure outbound ranges POMs */
+	ppc4xx_configure_pcix_POMs(hose, reg);
+
+	/* Configure inbound ranges PIMs */
+	ppc4xx_configure_pcix_PIMs(hose, reg, &dma_window, big_pim, msi);
+
+	/* We don't need the registers anymore */
+	iounmap(reg);
+	return;
+
+ fail:
+	if (hose)
+		pcibios_free_controller(hose);
+	if (reg)
+		iounmap(reg);
+}
+
+/*
+ * 4xx PCI-Express part
+ */
+static void __init ppc4xx_probe_pciex_bridge(struct device_node *np)
+{
+	/* NYI */
+}
+
+static int __init ppc4xx_pci_find_bridges(void)
+{
+	struct device_node *np;
+
+	for_each_compatible_node(np, NULL, "ibm,plb-pciex")
+		ppc4xx_probe_pciex_bridge(np);
+	for_each_compatible_node(np, NULL, "ibm,plb-pcix")
+		ppc4xx_probe_pcix_bridge(np);
+	for_each_compatible_node(np, NULL, "ibm,plb-pci")
+		ppc4xx_probe_pci_bridge(np);
+
+	return 0;
+}
+arch_initcall(ppc4xx_pci_find_bridges);
+
Index: linux-merge/arch/powerpc/sysdev/ppc4xx_pci.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-merge/arch/powerpc/sysdev/ppc4xx_pci.h	2007-12-14 15:49:42.000000000 +1100
@@ -0,0 +1,106 @@
+/*
+ * PCI / PCI-X / PCI-Express support for 4xx parts
+ *
+ * Copyright 2007 Ben. Herrenschmidt <benh@kernel.crashing.org>, IBM Corp.
+ *
+ * Bits and pieces extracted from arch/ppc support by
+ *
+ * Matt Porter <mporter@kernel.crashing.org>
+ *
+ * Copyright 2002-2005 MontaVista Software Inc.
+ */
+#ifndef __PPC4XX_PCI_H__
+#define __PPC4XX_PCI_H__
+
+/*
+ * 4xx PCI-X bridge register definitions
+ */
+#define PCIX0_VENDID		0x000
+#define PCIX0_DEVID		0x002
+#define PCIX0_COMMAND		0x004
+#define PCIX0_STATUS		0x006
+#define PCIX0_REVID		0x008
+#define PCIX0_CLS		0x009
+#define PCIX0_CACHELS		0x00c
+#define PCIX0_LATTIM		0x00d
+#define PCIX0_HDTYPE		0x00e
+#define PCIX0_BIST		0x00f
+#define PCIX0_BAR0L		0x010
+#define PCIX0_BAR0H		0x014
+#define PCIX0_BAR1		0x018
+#define PCIX0_BAR2L		0x01c
+#define PCIX0_BAR2H		0x020
+#define PCIX0_BAR3		0x024
+#define PCIX0_CISPTR		0x028
+#define PCIX0_SBSYSVID		0x02c
+#define PCIX0_SBSYSID		0x02e
+#define PCIX0_EROMBA		0x030
+#define PCIX0_CAP		0x034
+#define PCIX0_RES0		0x035
+#define PCIX0_RES1		0x036
+#define PCIX0_RES2		0x038
+#define PCIX0_INTLN		0x03c
+#define PCIX0_INTPN		0x03d
+#define PCIX0_MINGNT		0x03e
+#define PCIX0_MAXLTNCY		0x03f
+#define PCIX0_BRDGOPT1		0x040
+#define PCIX0_BRDGOPT2		0x044
+#define PCIX0_ERREN		0x050
+#define PCIX0_ERRSTS		0x054
+#define PCIX0_PLBBESR		0x058
+#define PCIX0_PLBBEARL		0x05c
+#define PCIX0_PLBBEARH		0x060
+#define PCIX0_POM0LAL		0x068
+#define PCIX0_POM0LAH		0x06c
+#define PCIX0_POM0SA		0x070
+#define PCIX0_POM0PCIAL		0x074
+#define PCIX0_POM0PCIAH		0x078
+#define PCIX0_POM1LAL		0x07c
+#define PCIX0_POM1LAH		0x080
+#define PCIX0_POM1SA		0x084
+#define PCIX0_POM1PCIAL		0x088
+#define PCIX0_POM1PCIAH		0x08c
+#define PCIX0_POM2SA		0x090
+#define PCIX0_PIM0SAL		0x098
+#define PCIX0_PIM0SA		PCIX0_PIM0SAL
+#define PCIX0_PIM0LAL		0x09c
+#define PCIX0_PIM0LAH		0x0a0
+#define PCIX0_PIM1SA		0x0a4
+#define PCIX0_PIM1LAL		0x0a8
+#define PCIX0_PIM1LAH		0x0ac
+#define PCIX0_PIM2SAL		0x0b0
+#define PCIX0_PIM2SA		PCIX0_PIM2SAL
+#define PCIX0_PIM2LAL		0x0b4
+#define PCIX0_PIM2LAH		0x0b8
+#define PCIX0_OMCAPID		0x0c0
+#define PCIX0_OMNIPTR		0x0c1
+#define PCIX0_OMMC		0x0c2
+#define PCIX0_OMMA		0x0c4
+#define PCIX0_OMMUA		0x0c8
+#define PCIX0_OMMDATA		0x0cc
+#define PCIX0_OMMEOI		0x0ce
+#define PCIX0_PMCAPID		0x0d0
+#define PCIX0_PMNIPTR		0x0d1
+#define PCIX0_PMC		0x0d2
+#define PCIX0_PMCSR		0x0d4
+#define PCIX0_PMCSRBSE		0x0d6
+#define PCIX0_PMDATA		0x0d7
+#define PCIX0_PMSCRR		0x0d8
+#define PCIX0_CAPID		0x0dc
+#define PCIX0_NIPTR		0x0dd
+#define PCIX0_CMD		0x0de
+#define PCIX0_STS		0x0e0
+#define PCIX0_IDR		0x0e4
+#define PCIX0_CID		0x0e8
+#define PCIX0_RID		0x0ec
+#define PCIX0_PIM0SAH		0x0f8
+#define PCIX0_PIM2SAH		0x0fc
+#define PCIX0_MSGIL		0x100
+#define PCIX0_MSGIH		0x104
+#define PCIX0_MSGOL		0x108
+#define PCIX0_MSGOH		0x10c
+#define PCIX0_IM		0x1f8
+
+
+
+#endif /* __PPC4XX_PCI_H__ */
