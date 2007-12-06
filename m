Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 06 Dec 2007 19:00:08 +1100
Subject: [PATCH 10/25] powerpc: 4xx PLB to PCI 2.x support
In-Reply-To: <1196927999.714593.205329520306.qpush@grosgo>
Message-Id: <20071206080119.8D157DDF82@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds to the previous patch the support for the 4xx PCI 2.x
bridges.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

This version implement the basic support for the 405GP bridge,
I haven't yet looked at differences that other implementations
may have for the PCI 2.x part.

 arch/powerpc/sysdev/ppc4xx_pci.c |  183 ++++++++++++++++++++++++++++++++++++++-
 arch/powerpc/sysdev/ppc4xx_pci.h |   19 ++++
 2 files changed, 201 insertions(+), 1 deletion(-)

Index: linux-work/arch/powerpc/sysdev/ppc4xx_pci.c
===================================================================
--- linux-work.orig/arch/powerpc/sysdev/ppc4xx_pci.c	2007-12-03 12:09:54.000000000 +1100
+++ linux-work/arch/powerpc/sysdev/ppc4xx_pci.c	2007-12-03 12:10:36.000000000 +1100
@@ -21,6 +21,38 @@ static int dma_offset_set;
 /* Move that to a useable header */
 extern unsigned long total_memory;
 
+static void fixup_ppc4xx_pci_bridge(struct pci_dev *dev)
+{
+	struct pci_controller *hose;
+	struct device_node *np;
+	int i;
+
+	if (dev->devfn != 0 || dev->bus->self != NULL)
+		return;
+
+	hose = pci_bus_to_host(dev->bus);
+	if (hose == NULL)
+		return;
+	np = hose->arch_data;
+
+	if (!of_device_is_compatible(np, "ibm,plb-pciex") &&
+	    !of_device_is_compatible(np, "ibm,plb-pcix") &&
+	    !of_device_is_compatible(np, "ibm,plb-pci"))
+		return;
+
+	/* Hide the PCI host BARs from the kernel as their content doesn't
+	 * fit well in the resource management
+	 */
+	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
+		dev->resource[i].start = dev->resource[i].end = 0;
+		dev->resource[i].flags = 0;
+	}
+
+	printk(KERN_INFO "PCI: Hiding 4xx host bridge resources %s\n",
+	       pci_name(dev));
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, fixup_ppc4xx_pci_bridge);
+
 static int __init ppc4xx_parse_dma_ranges(struct pci_controller *hose,
 					  void __iomem *reg,
 					  struct resource *res)
@@ -126,9 +158,158 @@ static int __init ppc4xx_parse_dma_range
 /*
  * 4xx PCI 2.x part
  */
+
+static void __init ppc4xx_configure_pci_PMMs(struct pci_controller *hose,
+					     void __iomem *reg)
+{
+	struct device_node *np = hose->arch_data;
+	u32 la, ma, pcila, pciha;
+	int i, j;
+
+	/* Setup outbound memory windows */
+	for (i = j = 0; i < 3; i++) {
+		struct resource *res = &hose->mem_resources[i];
+
+		/* we only care about memory windows */
+		if (!(res->flags & IORESOURCE_MEM))
+			continue;
+		if (j > 2) {
+			printk(KERN_WARNING "%s: Too many ranges\n",
+			       np->full_name);
+			break;
+		}
+
+		/* Calculate register values */
+		la = res->start;
+#ifdef CONFIG_RESOURCES_64BIT
+		pciha = (res->start - hose->pci_mem_offset) >> 32;
+		pcila = (res->start - hose->pci_mem_offset) & 0xffffffffu;
+#else
+		pciha = 0;
+		pcila = res->start - hose->pci_mem_offset;
+#endif
+
+		ma = res->end + 1 - res->start;
+		if (!is_power_of_2(ma) || ma < 0x1000 || ma > 0xffffffffu) {
+			printk(KERN_WARNING "%s: Resource out of range\n",
+			       np->full_name);
+			continue;
+		}
+		ma = (0xffffffffu << ilog2(ma)) | 0x1;
+		if (res->flags & IORESOURCE_PREFETCH)
+			ma |= 0x2;
+
+		/* Program register values */
+		writel(la, reg + PCIL0_PMM0LA + (0x10 * j));
+		writel(pcila, reg + PCIL0_PMM0PCILA + (0x10 * j));
+		writel(pciha, reg + PCIL0_PMM0PCIHA + (0x10 * j));
+		writel(ma, reg + PCIL0_PMM0MA + (0x10 * j));
+		j++;
+	}
+}
+
+static void __init ppc4xx_configure_pci_PTMs(struct pci_controller *hose,
+					     void __iomem *reg,
+					     const struct resource *res)
+{
+	resource_size_t size = res->end - res->start + 1;
+	u32 sa;
+
+	/* Calculate window size */
+	sa = (0xffffffffu << ilog2(size)) | 1;
+	sa |= 0x1;
+
+	/* RAM is always at 0 local for now */
+	writel(0, reg + PCIL0_PTM1LA);
+	writel(sa, reg + PCIL0_PTM1MS);
+
+	/* Map on PCI side */
+	early_write_config_dword(hose, hose->first_busno, 0,
+				 PCI_BASE_ADDRESS_1, res->start);
+	early_write_config_dword(hose, hose->first_busno, 0,
+				 PCI_BASE_ADDRESS_2, 0x00000000);
+	early_write_config_word(hose, hose->first_busno, 0,
+				PCI_COMMAND, 0x0006);
+}
+
 static void __init ppc4xx_probe_pci_bridge(struct device_node *np)
 {
 	/* NYI */
+	struct resource rsrc_cfg;
+	struct resource rsrc_reg;
+	struct resource dma_window;
+	struct pci_controller *hose = NULL;
+	void __iomem *reg = NULL;
+	const int *bus_range;
+	int primary = 0;
+
+	/* Fetch config space registers address */
+	if (of_address_to_resource(np, 0, &rsrc_cfg)) {
+		printk(KERN_ERR "%s:Can't get PCI config register base !",
+		       np->full_name);
+		return;
+	}
+	/* Fetch host bridge internal registers address */
+	if (of_address_to_resource(np, 3, &rsrc_reg)) {
+		printk(KERN_ERR "%s: Can't get PCI internal register base !",
+		       np->full_name);
+		return;
+	}
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
+	writel(0, reg + PCIL0_PMM0MA);
+	writel(0, reg + PCIL0_PMM1MA);
+	writel(0, reg + PCIL0_PMM2MA);
+	writel(0, reg + PCIL0_PTM1MS);
+	writel(0, reg + PCIL0_PTM2MS);
+
+	/* Parse outbound mapping resources */
+	pci_process_bridge_OF_ranges(hose, np, primary);
+
+	/* Parse inbound mapping resources */
+	if (ppc4xx_parse_dma_ranges(hose, reg, &dma_window) != 0)
+		goto fail;
+
+	/* Configure outbound ranges POMs */
+	ppc4xx_configure_pci_PMMs(hose, reg);
+
+	/* Configure inbound ranges PIMs */
+	ppc4xx_configure_pci_PTMs(hose, reg, &dma_window);
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
 }
 
 /*
@@ -156,7 +337,7 @@ static void __init ppc4xx_configure_pcix
 		}
 
 		/* Calculate register values */
-#ifdef CONFIG_PTE_64BIT
+#ifdef CONFIG_RESOURCES_64BIT
 		lah = res->start >> 32;
 		lal = res->start & 0xffffffffu;
 		pciah = (res->start - hose->pci_mem_offset) >> 32;
Index: linux-work/arch/powerpc/sysdev/ppc4xx_pci.h
===================================================================
--- linux-work.orig/arch/powerpc/sysdev/ppc4xx_pci.h	2007-12-03 12:09:20.000000000 +1100
+++ linux-work/arch/powerpc/sysdev/ppc4xx_pci.h	2007-12-03 12:10:06.000000000 +1100
@@ -101,6 +101,25 @@
 #define PCIX0_MSGOH		0x10c
 #define PCIX0_IM		0x1f8
 
+/*
+ * 4xx PCI bridge register definitions
+ */
+#define PCIL0_PMM0LA		0x00
+#define PCIL0_PMM0MA		0x04
+#define PCIL0_PMM0PCILA		0x08
+#define PCIL0_PMM0PCIHA		0x0c
+#define PCIL0_PMM1LA		0x10
+#define PCIL0_PMM1MA		0x14
+#define PCIL0_PMM1PCILA		0x18
+#define PCIL0_PMM1PCIHA		0x1c
+#define PCIL0_PMM2LA		0x20
+#define PCIL0_PMM2MA		0x24
+#define PCIL0_PMM2PCILA		0x28
+#define PCIL0_PMM2PCIHA		0x2c
+#define PCIL0_PTM1MS		0x30
+#define PCIL0_PTM1LA		0x34
+#define PCIL0_PTM2MS		0x38
+#define PCIL0_PTM2LA		0x3c
 
 
 #endif /* __PPC4XX_PCI_H__ */
