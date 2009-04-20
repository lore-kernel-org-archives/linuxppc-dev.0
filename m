Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BF6E1DE0E1
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 02:27:12 +1000 (EST)
From: Becky Bruce <beckyb@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org, fujita.tomonori@lab.ntt.co.jp
Subject: [PATCH 4/5] powerpc: Add support for swiotlb on 32-bit
Date: Mon, 20 Apr 2009 11:26:49 -0500
Message-Id: <1240244810-32193-7-git-send-email-beckyb@kernel.crashing.org>
In-Reply-To: <1240244810-32193-6-git-send-email-beckyb@kernel.crashing.org>
References: <1240244810-32193-1-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-2-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-3-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-4-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-5-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-6-git-send-email-beckyb@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch includes the basic infrastructure to use swiotlb
bounce buffering on 32-bit powerpc.  It is not yet enabled on
any platforms.

Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
---
 arch/powerpc/Kconfig                   |    2 +-
 arch/powerpc/include/asm/dma-mapping.h |   11 ++
 arch/powerpc/include/asm/swiotlb.h     |   24 +++++
 arch/powerpc/kernel/Makefile           |    1 +
 arch/powerpc/kernel/dma-swiotlb.c      |  161 ++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/dma.c              |    2 +-
 arch/powerpc/kernel/setup_32.c         |    4 +
 7 files changed, 203 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/include/asm/swiotlb.h
 create mode 100644 arch/powerpc/kernel/dma-swiotlb.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 5b50e1a..197f6a3 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -294,7 +294,7 @@ config IOMMU_HELPER
 
 config PPC_NEED_DMA_SYNC_OPS
 	def_bool y
-	depends on NOT_COHERENT_CACHE
+	depends on (NOT_COHERENT_CACHE || SWIOTLB)
 
 config HOTPLUG_CPU
 	bool "Support for enabling/disabling CPUs"
diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index c69f2b5..71bbc17 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -15,9 +15,18 @@
 #include <linux/scatterlist.h>
 #include <linux/dma-attrs.h>
 #include <asm/io.h>
+#include <asm/swiotlb.h>
 
 #define DMA_ERROR_CODE		(~(dma_addr_t)0x0)
 
+/* Some dma direct funcs must be visible for use in other dma_ops */
+extern void *dma_direct_alloc_coherent(struct device *dev, size_t size,
+				       dma_addr_t *dma_handle, gfp_t flag);
+extern void dma_direct_free_coherent(struct device *dev, size_t size,
+				     void *vaddr, dma_addr_t dma_handle);
+
+extern unsigned long get_dma_direct_offset(struct device *dev);
+
 #ifdef CONFIG_NOT_COHERENT_CACHE
 /*
  * DMA-consistent mapping functions for PowerPCs that don't support
@@ -76,6 +85,8 @@ struct dma_mapping_ops {
 				dma_addr_t dma_address, size_t size,
 				enum dma_data_direction direction,
 				struct dma_attrs *attrs);
+	int		(*addr_needs_map)(struct device *dev, dma_addr_t addr,
+				size_t size);
 #ifdef CONFIG_PPC_NEED_DMA_SYNC_OPS
 	void            (*sync_single_range_for_cpu)(struct device *hwdev,
 				dma_addr_t dma_handle, unsigned long offset,
diff --git a/arch/powerpc/include/asm/swiotlb.h b/arch/powerpc/include/asm/swiotlb.h
new file mode 100644
index 0000000..6440fdf
--- /dev/null
+++ b/arch/powerpc/include/asm/swiotlb.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) 2009 Becky Bruce, Freescale Semiconductor
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+#ifndef __ASM_SWIOTLB_H
+#define __ASM_SWIOTLB_H
+
+#include <linux/swiotlb.h>
+
+extern struct dma_mapping_ops swiotlb_dma_ops;
+extern struct dma_mapping_ops swiotlb_pci_dma_ops;
+
+int swiotlb_arch_address_needs_mapping(struct device *, dma_addr_t,
+				       size_t size);
+
+static inline void dma_mark_clean(void *addr, size_t size) {}
+
+#endif /* __ASM_SWIOTLB_H */
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 71901fb..34c0a95 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -82,6 +82,7 @@ obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
 obj-$(CONFIG_PPC_UDBG_16550)	+= legacy_serial.o udbg_16550.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
+obj-$(CONFIG_SWIOTLB)		+= dma-swiotlb.o
 
 pci64-$(CONFIG_PPC64)		+= pci_dn.o isa-bridge.o
 obj-$(CONFIG_PCI)		+= pci_$(CONFIG_WORD_SIZE).o $(pci64-y) \
diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
new file mode 100644
index 0000000..29a68e6
--- /dev/null
+++ b/arch/powerpc/kernel/dma-swiotlb.c
@@ -0,0 +1,161 @@
+/*
+ * Contains routines needed to support swiotlb for ppc.
+ *
+ * Copyright (C) 2009 Becky Bruce, Freescale Semiconductor
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/pfn.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pci.h>
+
+#include <asm/machdep.h>
+#include <asm/swiotlb.h>
+#include <asm/dma.h>
+#include <asm/abs_addr.h>
+
+int swiotlb __read_mostly;
+
+void *swiotlb_bus_to_virt(struct device *hwdev, dma_addr_t addr)
+{
+	unsigned long pfn = PFN_DOWN(swiotlb_bus_to_phys(hwdev, addr));
+	void *pageaddr = page_address(pfn_to_page(pfn));
+
+	if (pageaddr != NULL)
+		return pageaddr + (addr % PAGE_SIZE);
+	return NULL;
+}
+
+dma_addr_t swiotlb_phys_to_bus(struct device *hwdev, phys_addr_t paddr)
+{
+	return paddr + get_dma_direct_offset(hwdev);
+}
+
+phys_addr_t swiotlb_bus_to_phys(struct device *hwdev, dma_addr_t baddr)
+
+{
+	return baddr - get_dma_direct_offset(hwdev);
+}
+
+/*
+ * Determine if an address needs bounce buffering via swiotlb.
+ * Going forward I expect the swiotlb code to generalize on using
+ * a dma_ops->addr_needs_map, and this function will move from here to the
+ * generic swiotlb code.
+ */
+int
+swiotlb_arch_address_needs_mapping(struct device *hwdev, dma_addr_t addr,
+				   size_t size)
+{
+	struct dma_mapping_ops *dma_ops = get_dma_ops(hwdev);
+
+	BUG_ON(!dma_ops);
+	return dma_ops->addr_needs_map(hwdev, addr, size);
+}
+
+/*
+ * Determine if an address is reachable by a pci device, or if we must bounce.
+ */
+static int
+swiotlb_pci_addr_needs_map(struct device *hwdev, dma_addr_t addr, size_t size)
+{
+	u64 mask = dma_get_mask(hwdev);
+	dma_addr_t max;
+	struct pci_controller *hose;
+	struct pci_dev *pdev = to_pci_dev(hwdev);
+
+	hose = pci_bus_to_host(pdev->bus);
+	max = hose->dma_window_base_cur + hose->dma_window_size;
+
+	/* check that we're within mapped pci window space */
+	if ((addr + size > max) | (addr < hose->dma_window_base_cur))
+		return 1;
+
+	return !is_buffer_dma_capable(mask, addr, size);
+}
+
+static int
+swiotlb_addr_needs_map(struct device *hwdev, dma_addr_t addr, size_t size)
+{
+	return !is_buffer_dma_capable(dma_get_mask(hwdev), addr, size);
+}
+
+
+/*
+ * At the moment, all platforms that use this code only require
+ * swiotlb to be used if we're operating on HIGHMEM.  Since
+ * we don't ever call anything other than map_sg, unmap_sg,
+ * map_page, and unmap_page on highmem, use normal dma_ops
+ * for everything else.
+ */
+struct dma_mapping_ops swiotlb_dma_ops = {
+	.alloc_coherent = dma_direct_alloc_coherent,
+	.free_coherent = dma_direct_free_coherent,
+	.map_sg = swiotlb_map_sg_attrs,
+	.unmap_sg = swiotlb_unmap_sg_attrs,
+	.dma_supported = swiotlb_dma_supported,
+	.map_page = swiotlb_map_page,
+	.unmap_page = swiotlb_unmap_page,
+	.addr_needs_map = swiotlb_addr_needs_map,
+	.sync_single_range_for_cpu = swiotlb_sync_single_range_for_cpu,
+	.sync_single_range_for_device = swiotlb_sync_single_range_for_device,
+	.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
+	.sync_sg_for_device = swiotlb_sync_sg_for_device
+};
+
+struct dma_mapping_ops swiotlb_pci_dma_ops = {
+	.alloc_coherent = dma_direct_alloc_coherent,
+	.free_coherent = dma_direct_free_coherent,
+	.map_sg = swiotlb_map_sg_attrs,
+	.unmap_sg = swiotlb_unmap_sg_attrs,
+	.dma_supported = swiotlb_dma_supported,
+	.map_page = swiotlb_map_page,
+	.unmap_page = swiotlb_unmap_page,
+	.addr_needs_map = swiotlb_pci_addr_needs_map,
+	.sync_single_range_for_cpu = swiotlb_sync_single_range_for_cpu,
+	.sync_single_range_for_device = swiotlb_sync_single_range_for_device,
+	.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
+	.sync_sg_for_device = swiotlb_sync_sg_for_device
+};
+
+static int ppc_swiotlb_bus_notify(struct notifier_block *nb,
+				  unsigned long action, void *data)
+{
+	struct device *dev = data;
+
+	/* We are only intereted in device addition */
+	if (action != BUS_NOTIFY_ADD_DEVICE)
+		return 0;
+
+	if (dma_get_mask(dev) < DMA_BIT_MASK(36))
+		set_dma_ops(dev, &swiotlb_dma_ops);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block ppc_swiotlb_plat_bus_notifier = {
+	.notifier_call = ppc_swiotlb_bus_notify,
+	.priority = 0,
+};
+
+static struct notifier_block ppc_swiotlb_of_bus_notifier = {
+	.notifier_call = ppc_swiotlb_bus_notify,
+	.priority = 0,
+};
+
+static int __init setup_bus_notifier(void)
+{
+	bus_register_notifier(&platform_bus_type,
+			      &ppc_swiotlb_plat_bus_notifier);
+	bus_register_notifier(&of_platform_bus_type,
+			      &ppc_swiotlb_of_bus_notifier);
+
+	return 0;
+}
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 53c7788..62d80c4 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -19,7 +19,7 @@
  * default the offset is PCI_DRAM_OFFSET.
  */
 
-static unsigned long get_dma_direct_offset(struct device *dev)
+unsigned long get_dma_direct_offset(struct device *dev)
 {
 	if (dev)
 		return (unsigned long)dev->archdata.dma_data;
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 9e1ca74..f038b13 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -332,6 +332,10 @@ void __init setup_arch(char **cmdline_p)
 		ppc_md.setup_arch();
 	if ( ppc_md.progress ) ppc_md.progress("arch: exit", 0x3eab);
 
+	/* Allow iotlb to do it's setup */
+#ifdef CONFIG_SWIOTLB
+	swiotlb_init();
+#endif
 	paging_init();
 
 	/* Initialize the MMU context management stuff */
-- 
1.6.0.6
