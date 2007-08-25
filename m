Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 94C35DDEE6
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Aug 2007 19:30:07 +1000 (EST)
To: "linuxppc-dev" <linuxppc-dev@ozlabs.org>
From: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: [PATCH 3/3] [POWERPC] Add PCI support for AMCC 440EPx (sequoia)
Date: Sat, 25 Aug 2007 13:30:01 +0400
Message-ID: <20070825093001.4087.18160.stgit@localhost.localdomain>
In-Reply-To: <20070825091440.4087.1428.stgit@localhost.localdomain>
References: <20070825091440.4087.1428.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


In fact, loosely move of arch/ppc bits, though regions are
set up using values from ranges property. This also adds
setup_indirect_pci_noremap() function to handle indirect
PCI without one more ioremap.

Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
Signed-off-by: Stefan Roese <sr@denx.de>

---

 arch/powerpc/platforms/44x/44x.h           |   28 ++++
 arch/powerpc/platforms/44x/Makefile        |    4 +
 arch/powerpc/platforms/44x/ppc440epx-pci.c |  192 ++++++++++++++++++++++++++++
 arch/powerpc/platforms/44x/sequoia.c       |   14 ++
 arch/powerpc/sysdev/indirect_pci.c         |   14 ++
 include/asm-powerpc/pci-bridge.h           |    2 
 6 files changed, 254 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/44x/44x.h b/arch/powerpc/platforms/44x/44x.h
index 42eabf8..d3845f9 100644
--- a/arch/powerpc/platforms/44x/44x.h
+++ b/arch/powerpc/platforms/44x/44x.h
@@ -1,8 +1,36 @@
 #ifndef __POWERPC_PLATFORMS_44X_44X_H
 #define __POWERPC_PLATFORMS_44X_44X_H
+#include <asm/pci-bridge.h>
+
+/* PCI support */
+#define PPC4xx_PCI_CFGA_OFFSET		0
+#define PPC4xx_PCI_CFGD_OFFSET		0x4
+
+#define PPC4xx_PCIL0_PMM0LA		0x000
+#define PPC4xx_PCIL0_PMM0MA		0x004
+#define PPC4xx_PCIL0_PMM0PCILA		0x008
+#define PPC4xx_PCIL0_PMM0PCIHA		0x00C
+#define PPC4xx_PCIL0_PMM1LA		0x010
+#define PPC4xx_PCIL0_PMM1MA		0x014
+#define PPC4xx_PCIL0_PMM1PCILA		0x018
+#define PPC4xx_PCIL0_PMM1PCIHA		0x01C
+#define PPC4xx_PCIL0_PMM2LA		0x020
+#define PPC4xx_PCIL0_PMM2MA		0x024
+#define PPC4xx_PCIL0_PMM2PCILA		0x028
+#define PPC4xx_PCIL0_PMM2PCIHA		0x02C
+#define PPC4xx_PCIL0_PTM1MS		0x030
+#define PPC4xx_PCIL0_PTM1LA		0x034
+#define PPC4xx_PCIL0_PTM2MS		0x038
+#define PPC4xx_PCIL0_PTM2LA		0x03C
 
 extern u8 as1_readb(volatile u8 __iomem  *addr);
 extern void as1_writeb(u8 data, volatile u8 __iomem *addr);
 extern void ppc44x_reset_system(char *cmd);
 
+#ifdef CONFIG_PCI
+int ppc440epx_exclude_device(struct pci_controller *hose,
+		u_char bus, u_char devfn);
+int ppc440epx_add_bridge(struct device_node *dev);
+#endif
+
 #endif /* __POWERPC_PLATFORMS_44X_44X_H */
diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platforms/44x/Makefile
index 10ce674..d2a5278 100644
--- a/arch/powerpc/platforms/44x/Makefile
+++ b/arch/powerpc/platforms/44x/Makefile
@@ -2,3 +2,7 @@ obj-$(CONFIG_44x)	:= misc_44x.o
 obj-$(CONFIG_EBONY)	+= ebony.o
 obj-$(CONFIG_BAMBOO) += bamboo.o
 obj-$(CONFIG_SEQUOIA)	+= sequoia.o
+
+ifeq ($(CONFIG_PCI),y)
+obj-$(CONFIG_440EPX)   += ppc440epx-pci.o
+endif
diff --git a/arch/powerpc/platforms/44x/ppc440epx-pci.c b/arch/powerpc/platforms/44x/ppc440epx-pci.c
new file mode 100644
index 0000000..bd4a352
--- /dev/null
+++ b/arch/powerpc/platforms/44x/ppc440epx-pci.c
@@ -0,0 +1,192 @@
+/*
+ * PPC44x PCI host support
+ *
+ * Vitaly Bordug <vitb@kernel.crashing.org>
+ * Stefan Roese <sr@denx.de>
+ *
+ * Based on arch/ppc sequoia pci bits, that are
+ * Copyright 2006-2007 DENX Software Engineering, Stefan Roese <sr@denx.de>
+ *
+ * Based on bamboo.c from Wade Farnsworth <wfarnsworth@mvista.com>
+ *      Copyright 2004 MontaVista Software Inc.
+ *      Copyright 2006 AMCC
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/io.h>
+
+#include <mm/mmu_decl.h>
+
+#include <asm/system.h>
+#include <asm/atomic.h>
+#include <asm/pci-bridge.h>
+#include <asm/prom.h>
+
+#include "44x.h"
+
+#undef DEBUG
+
+#ifdef DEBUG
+#define DBG(x...) printk(x)
+#else
+#define DBG(x...)
+#endif
+
+#ifdef CONFIG_PCI
+
+int ppc440epx_exclude_device(struct pci_controller *hose, u_char bus,
+			   u_char devfn)
+{
+	if ((bus == hose->first_busno) && PCI_SLOT(devfn) == 0)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	return PCIBIOS_SUCCESSFUL;
+}
+
+inline void pci_writel(void *pci_reg_base, u32 offset, unsigned int val)
+{
+	writel(val, pci_reg_base + offset);
+}
+
+inline void pci_cfg_out(void *cfg, u32 offset, unsigned int value)
+{
+	out_le32((void *)((u32) cfg + offset), value);
+}
+
+inline u32 pci_cfg_in(void *cfg, u32 offset)
+{
+	return in_le32((void *)((u32) cfg + offset));
+}
+
+static void __init ppc440epx_setup_pci(struct pci_controller *hose,
+				     void *pci_reg_base, void *pci_cfg_base)
+{
+	unsigned long memory_size, pci_size = 0;
+	phys_addr_t pci_phys_base = 0;
+	phys_addr_t pci_pci_base = 0;
+	int i;
+
+	memory_size = total_memory;
+
+	/*
+	 * 440EPx has single memory region, we'll use it to configure phb
+	 */
+	for (i = 0; i < 3; i++)
+		if (hose->mem_resources[i].start) {
+			pci_phys_base = hose->mem_resources[i].start;
+			pci_pci_base = pci_phys_base - hose->pci_mem_offset;
+			pci_size =
+			    hose->mem_resources[i].end -
+			    hose->mem_resources[i].start;
+		}
+
+	if (pci_phys_base == 0) {
+		printk(KERN_ERR "PHB bridge memory region is not defined!\n");
+		return;
+	}
+
+	pci_cfg_out(pci_cfg_base, PPC4xx_PCI_CFGA_OFFSET,
+		    (pci_pci_base & 0xFFFFFFFF) | (PCI_COMMAND & 0xfc));
+	pci_cfg_out(pci_cfg_base, PPC4xx_PCI_CFGD_OFFSET,
+		    (pci_cfg_in(pci_cfg_base, PPC4xx_PCI_CFGD_OFFSET) |
+		     PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER));
+
+	/* Disable region first */
+	pci_writel(pci_reg_base, PPC4xx_PCIL0_PMM0MA, 0);
+
+	/* PLB starting addr: 0x0000000180000000
+	 * We need just lower word to get the things work
+	 */
+	pci_writel(pci_reg_base, PPC4xx_PCIL0_PMM0LA,
+		   pci_phys_base & 0xFFFFFFFF);
+
+	/* PCI start addr, 0x80000000 (PCI Address) */
+	pci_writel(pci_reg_base, PPC4xx_PCIL0_PMM0PCILA,
+		   pci_pci_base & 0xFFFFFFFF);
+	pci_writel(pci_reg_base, PPC4xx_PCIL0_PMM0PCIHA, 0);
+
+	/* Enable no pre-fetch, enable region */
+	pci_writel(pci_reg_base, PPC4xx_PCIL0_PMM0MA,
+		   ((0xffffffff - pci_size) | 0x01));
+
+	/* Disable region one */
+	pci_writel(pci_reg_base, PPC4xx_PCIL0_PMM1MA, 0);
+	pci_writel(pci_reg_base, PPC4xx_PCIL0_PMM1LA, 0);
+	pci_writel(pci_reg_base, PPC4xx_PCIL0_PMM1PCILA, 0);
+	pci_writel(pci_reg_base, PPC4xx_PCIL0_PMM1PCIHA, 0);
+
+	/* Disable region two */
+	pci_writel(pci_reg_base, PPC4xx_PCIL0_PMM1MA, 0);
+	pci_writel(pci_reg_base, PPC4xx_PCIL0_PMM1LA, 0);
+	pci_writel(pci_reg_base, PPC4xx_PCIL0_PMM1PCILA, 0);
+	pci_writel(pci_reg_base, PPC4xx_PCIL0_PMM1PCIHA, 0);
+
+	/* Now configure the PCI->PLB windows, we only use PTM1
+	 *
+	 * For Inbound flow, set the window size to all available memory
+	 * This is required because if size is smaller,
+	 * then Eth/PCI DD would fail as PCI card not able to access
+	 * the memory allocated by DD.
+	 */
+
+	pci_writel(pci_reg_base, PPC4xx_PCIL0_PTM1MS, 0);
+	pci_writel(pci_reg_base, PPC4xx_PCIL0_PTM1LA, 0);
+
+	memory_size = 1 << fls(memory_size - 1);
+
+	/* Size low + Enabled */
+	pci_writel(pci_reg_base, PPC4xx_PCIL0_PTM1MS,
+		   (0xffffffff - (memory_size - 1)) | 0x1);
+	eieio();
+}
+
+int __init ppc440epx_add_bridge(struct device_node *dev)
+{
+	int len;
+	struct pci_controller *hose;
+	const int *bus_range;
+	int primary = 1;
+	void *reg, *cfg;
+
+	/* Fetch host bridge registers address */
+	reg = of_iomap(dev, 1);
+	cfg = of_iomap(dev, 0);
+
+	DBG("Adding PCI host bridge %s\n reg %p cfg %p\n", dev->full_name, reg,
+	    cfg);
+
+	/* Get bus range if any */
+	bus_range = of_get_property(dev, "bus-range", &len);
+	if (bus_range == NULL || len < 2 * sizeof(int))
+		printk(KERN_WARNING "Can't get bus-range for %s, assume"
+		       " bus 0\n", dev->full_name);
+
+	pci_assign_all_buses = 1;
+	hose = pcibios_alloc_controller(dev);
+	if (!hose)
+		return -ENOMEM;
+
+	hose->first_busno = bus_range ? bus_range[0] : 0;
+	hose->last_busno = bus_range ? bus_range[1] : 0xff;
+
+	setup_indirect_pci_noremap(hose, (u32) cfg,
+				   (u32) (cfg + PPC4xx_PCI_CFGD_OFFSET), 0);
+
+	/* Interpret the "ranges" property */
+	/* This also maps the I/O region and sets isa_io/mem_base */
+	pci_process_bridge_OF_ranges(hose, dev, primary);
+	ppc440epx_setup_pci(hose, reg, cfg);
+
+	return 0;
+}
+#endif
diff --git a/arch/powerpc/platforms/44x/sequoia.c b/arch/powerpc/platforms/44x/sequoia.c
index ca3c9cc..c3a638b 100644
--- a/arch/powerpc/platforms/44x/sequoia.c
+++ b/arch/powerpc/platforms/44x/sequoia.c
@@ -52,6 +52,20 @@ static int __init sequoia_probe(void)
 
 static void __init sequoia_setup_arch(void)
 {
+#ifdef CONFIG_PCI
+	struct device_node *np;
+#endif
+
+	if (ppc_md.progress)
+		ppc_md.progress("ppc44x_setup_arch()", 0);
+
+#ifdef CONFIG_PCI
+	for (np = NULL; (np = of_find_compatible_node(np,
+					"pci", "ibm, 440epx")) != NULL;)
+		ppc440epx_add_bridge(np);
+	ppc_md.pci_exclude_device = ppc440epx_exclude_device;
+#endif
+
 }
 
 define_machine(sequoia) {
diff --git a/arch/powerpc/sysdev/indirect_pci.c b/arch/powerpc/sysdev/indirect_pci.c
index b5d0682..9dab751 100644
--- a/arch/powerpc/sysdev/indirect_pci.c
+++ b/arch/powerpc/sysdev/indirect_pci.c
@@ -162,3 +162,17 @@ setup_indirect_pci(struct pci_controller* hose, u32 cfg_addr, u32 cfg_data, u32
 	hose->ops = &indirect_pci_ops;
 	hose->indirect_type = flags;
 }
+
+/*
+ * For some reason, ioremap does not handle 2-nd way mapping well,
+ * causing system check while trying to access config space later
+ */
+void __init
+setup_indirect_pci_noremap(struct pci_controller *hose, u32 cfg_addr,
+		u32 cfg_data, u32 flags)
+{
+	hose->cfg_addr = (void *)cfg_addr;
+	hose->cfg_data = (void *)cfg_data;
+	hose->ops = &indirect_pci_ops;
+	hose->indirect_type = flags;
+}
diff --git a/include/asm-powerpc/pci-bridge.h b/include/asm-powerpc/pci-bridge.h
index e909769..4bde6e5 100644
--- a/include/asm-powerpc/pci-bridge.h
+++ b/include/asm-powerpc/pci-bridge.h
@@ -99,6 +99,8 @@ extern int early_find_capability(struct pci_controller *hose, int bus,
 
 extern void setup_indirect_pci(struct pci_controller* hose,
 			       u32 cfg_addr, u32 cfg_data, u32 flags);
+extern void setup_indirect_pci_noremap(struct pci_controller *hose,
+			       u32 cfg_addr, u32 cfg_data, u32 flags);
 extern void setup_grackle(struct pci_controller *hose);
 extern void __init update_bridge_resource(struct pci_dev *dev,
 					  struct resource *res);
