Return-Path: <albert_herranz@yahoo.es>
Received: from smtp133.mail.ukl.yahoo.com (smtp133.mail.ukl.yahoo.com
	[77.238.184.64]) by ozlabs.org (Postfix) with SMTP id 6A7EBB7DCF
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 20 Mar 2010 05:33:02 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v5 08/10] wii: add mem2 dma mapping ops
Date: Fri, 19 Mar 2010 19:32:24 +0100
Message-Id: <1269023546-25534-9-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1269023546-25534-1-git-send-email-albert_herranz@yahoo.es>
References: <1269023546-25534-1-git-send-email-albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>, konrad.wilk@oracle.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some of the devices in the "Hollywood" chipset of the Nintendo Wii video
game console have restrictions performing DMA transfers to the first
contiguous RAM region (known as MEM1).
For example, up to 3 bytes of the last word of a DMA transfer of a
non-32 bit aligned length to MEM1 may be lost.
Such restrictions do not apply when using the second contiguous RAM
region (known as MEM2).

Add a set of DMA mapping operations which said devices can use to make
sure that DMA transfers are always performed to/from memory buffers
within MEM2.

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 arch/powerpc/boot/wii.c                      |   44 +++
 arch/powerpc/include/asm/wii.h               |   25 ++
 arch/powerpc/platforms/embedded6xx/Kconfig   |    1 +
 arch/powerpc/platforms/embedded6xx/Makefile  |    2 +-
 arch/powerpc/platforms/embedded6xx/wii-dma.c |  475 ++++++++++++++++++++++++++
 5 files changed, 546 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/include/asm/wii.h
 create mode 100755 arch/powerpc/platforms/embedded6xx/wii-dma.c

diff --git a/arch/powerpc/boot/wii.c b/arch/powerpc/boot/wii.c
index 2ebaec0..84ce593 100644
--- a/arch/powerpc/boot/wii.c
+++ b/arch/powerpc/boot/wii.c
@@ -30,6 +30,7 @@ BSS_STACK(8192);
 #define MEM2_TOP		(0x10000000 + 64*1024*1024)
 #define FIRMWARE_DEFAULT_SIZE	(12*1024*1024)
 
+#define MEM2_DMA_DEFAULT_SIZE	(512*1024)
 
 struct mipc_infohdr {
 	char magic[3];
@@ -101,6 +102,42 @@ out:
 
 }
 
+static char tmp_cmdline[COMMAND_LINE_SIZE];
+
+static void mem2_fixups(u32 *top, u32 *reg)
+{
+	/* ' mem2_dma=' + nnnnnnn + 'K@0x' + aaaaaaaa */
+	const int max_param_len = 10 + 7 + 4 + 8;
+	void *chosen;
+	u32 dma_base, dma_size;
+	char *p;
+
+	chosen = finddevice("/chosen");
+	if (!chosen)
+		fatal("Can't find chosen node\n");
+
+	/* the MEM2 DMA region must fit within MEM2 */
+	dma_size = MEM2_DMA_DEFAULT_SIZE;
+	if (dma_size > reg[3])
+		dma_size = reg[3];
+	/* reserve the region from the top of MEM2 */
+	*top -= dma_size;
+	dma_base = *top;
+	printf("mem2_dma: %uk@0x%08x\n", dma_size >> 10, dma_base);
+
+	/*
+	 * Finally, add the MEM2 DMA region location information to the
+	 * kernel command line. The wii-dma driver will pick this info up.
+	 */
+	getprop(chosen, "bootargs", tmp_cmdline, COMMAND_LINE_SIZE-1);
+	p = strchr(tmp_cmdline, 0);
+	if (p - tmp_cmdline + max_param_len >= COMMAND_LINE_SIZE)
+		fatal("No space left for mem2_dma param\n");
+
+	sprintf(p, " mem2_dma=%uk@0x%08x", dma_size >> 10, dma_base);
+	setprop_str(chosen, "bootargs", tmp_cmdline);
+}
+
 static void platform_fixups(void)
 {
 	void *mem;
@@ -127,9 +164,16 @@ static void platform_fixups(void)
 		mem2_boundary = MEM2_TOP - FIRMWARE_DEFAULT_SIZE;
 	}
 
+	mem2_fixups(&mem2_boundary, reg);
+
 	if (mem2_boundary > reg[2] && mem2_boundary < reg[2] + reg[3]) {
 		reg[3] = mem2_boundary - reg[2];
 		printf("top of MEM2 @ %08X\n", reg[2] + reg[3]);
+		/*
+		 * Find again the memory node as it may have changed its
+		 * position after adding some non-existing properties.
+		 */
+		mem = finddevice("/memory");
 		setprop(mem, "reg", reg, sizeof(reg));
 	}
 
diff --git a/arch/powerpc/include/asm/wii.h b/arch/powerpc/include/asm/wii.h
new file mode 100644
index 0000000..bb83c32
--- /dev/null
+++ b/arch/powerpc/include/asm/wii.h
@@ -0,0 +1,25 @@
+/*
+ * arch/powerpc/include/asm/wii.h
+ *
+ * Nintendo Wii board-specific definitions
+ * Copyright (C) 2010 The GameCube Linux Team
+ * Copyright (C) 2010 Albert Herranz
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ */
+
+#ifndef __ASM_POWERPC_WII_H
+#define __ASM_POWERPC_WII_H
+
+/*
+ * DMA operations for the Nintendo Wii.
+ */
+extern struct dma_map_ops wii_mem2_dma_ops;
+
+extern int wii_set_mem2_dma_constraints(struct device *dev);
+extern void wii_clear_mem2_dma_constraints(struct device *dev);
+
+#endif /* __ASM_POWERPC_WII_H */
diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/platforms/embedded6xx/Kconfig
index fe77ab2..f4fff0a 100644
--- a/arch/powerpc/platforms/embedded6xx/Kconfig
+++ b/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -120,6 +120,7 @@ config WII
 	depends on EMBEDDED6xx
 	select GAMECUBE_COMMON
 	select HAVE_GENERIC_DMA_COHERENT
+	select SWIOTLB
 	help
 	  Select WII if configuring for the Nintendo Wii.
 	  More information at: <http://gc-linux.sourceforge.net/>
diff --git a/arch/powerpc/platforms/embedded6xx/Makefile b/arch/powerpc/platforms/embedded6xx/Makefile
index 66c23e4..4d4c776 100644
--- a/arch/powerpc/platforms/embedded6xx/Makefile
+++ b/arch/powerpc/platforms/embedded6xx/Makefile
@@ -10,4 +10,4 @@ obj-$(CONFIG_PPC_C2K)		+= c2k.o
 obj-$(CONFIG_USBGECKO_UDBG)	+= usbgecko_udbg.o
 obj-$(CONFIG_GAMECUBE_COMMON)	+= flipper-pic.o
 obj-$(CONFIG_GAMECUBE)		+= gamecube.o
-obj-$(CONFIG_WII)		+= wii.o hlwd-pic.o
+obj-$(CONFIG_WII)		+= wii.o hlwd-pic.o wii-dma.o
diff --git a/arch/powerpc/platforms/embedded6xx/wii-dma.c b/arch/powerpc/platforms/embedded6xx/wii-dma.c
new file mode 100755
index 0000000..d7f6cb9
--- /dev/null
+++ b/arch/powerpc/platforms/embedded6xx/wii-dma.c
@@ -0,0 +1,475 @@
+/*
+ * arch/powerpc/platforms/embedded6xx/wii-dma.c
+ *
+ * DMA functions for the Nintendo Wii video game console.
+ * Copyright (C) 2010 The GameCube Linux Team
+ * Copyright (C) 2010 Albert Herranz
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ */
+
+/*
+ * The Nintendo Wii video game console is a NOT_COHERENT_CACHE
+ * platform that is unable to safely perform non-32 bit uncached writes
+ * to RAM because the byte enables are not connected to the bus.
+ * Thus, in this platform, "coherent" DMA buffers cannot be directly used
+ * by the kernel code unless it guarantees that all write accesses
+ * to said buffers are done in 32 bit chunks.
+ *
+ * In addition, some of the devices in the "Hollywood" chipset have a
+ * similar restriction regarding DMA transfers: those with non-32bit
+ * aligned lengths only work when performed to/from the second contiguous
+ * region of memory (known as MEM2).
+ *
+ * To solve these issues a specific set of dma mapping operations is made
+ * available for devices requiring it. When enabled, the kernel will make
+ * sure that DMA buffers sitting in MEM1 get bounced to/from DMA buffers
+ * allocated from MEM2.
+ *
+ * Bouncing is performed with the help of the swiotlb support.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/kernel.h>
+#include <linux/bootmem.h>
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <linux/of.h>
+#include <linux/lmb.h>
+#include <asm/wii.h>
+
+#include "mm/mmu_decl.h"
+
+/*
+ * The mem2_dma "device".
+ *
+ * This device "owns" a pool of coherent MEM2 memory that can be shared among
+ * several devices requiring MEM2 DMA buffers, instead of dedicating specific
+ * pools for each device.
+ *
+ * A device can use the shared coherent MEM2 memory pool by calling
+ * wii_set_mem2_dma_constraints().
+ *
+ */
+
+struct mem2_dma {
+	struct platform_device *pdev;
+
+	dma_addr_t dma_base;
+	void *base;
+	size_t size;
+};
+
+static struct mem2_dma mem2_dma_instance;
+
+static inline struct mem2_dma *mem2_dma_get_instance(void)
+{
+	return &mem2_dma_instance;
+}
+
+static int __init mem2_dma_init(dma_addr_t dma_base, size_t size)
+{
+	struct mem2_dma *mem2_dma = mem2_dma_get_instance();
+	const int flags = DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE;
+	struct device *dev;
+	int error = 0;
+
+	mem2_dma->pdev = platform_device_register_simple("mem2_dma",
+							 0, NULL, 0);
+	if (IS_ERR(mem2_dma->pdev)) {
+		error = PTR_ERR(mem2_dma->pdev);
+		pr_err("error %d registering platform device\n", error);
+		goto err_pdev_register;
+	}
+	dev = &mem2_dma->pdev->dev;
+
+	if (!dma_declare_coherent_memory(dev, dma_base, dma_base,
+					 size, flags)) {
+		dev_err(dev, "error declaring coherent memory %zu@%Lx\n",
+			size, (unsigned long long)dma_base);
+		error = -EBUSY;
+		goto err_declare_coherent;
+	}
+	mem2_dma->dma_base = dma_base;
+	mem2_dma->size = size;
+	dev_info(dev, "using %zu KiB at 0x%Lx\n", size / 1024,
+		 (unsigned long long)dma_base);
+	goto out;
+
+err_declare_coherent:
+	platform_device_unregister(mem2_dma->pdev);
+err_pdev_register:
+	mem2_dma->pdev = NULL;
+out:
+	return error;
+}
+
+static __initdata dma_addr_t dma_base, dma_size;
+
+static int __init mem2_setup_parse(char *str)
+{
+	char *p, *q = str;
+
+	dma_size = memparse(q, &p);
+	if (p == q) {
+		pr_err("dma_size expected\n");
+		return -EINVAL;
+	}
+	if (*p != '@') {
+		pr_err("missing @ separator between dma_size and dma_base\n");
+		return -EINVAL;
+	}
+
+	q = p + 1;
+	dma_base = memparse(q, &p);
+	if (p == q) {
+		pr_err("dma_base expected\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+__setup("mem2_dma=", mem2_setup_parse);
+
+static int __init mem2_dma_setup(void)
+{
+	int error;
+
+	BUG_ON(dma_base < lmb_end_of_DRAM());
+	BUG_ON(dma_size == 0);
+
+	error = mem2_dma_init(dma_base, dma_size);
+	if (error)
+		pr_err("error %d during setup\n", error);
+	return error;
+}
+arch_initcall(mem2_dma_setup);
+
+/**
+ * wii_mem2_dma_dev() - returns the device "owning" the shared MEM2 DMA region
+ *
+ * Use this function to retrieve the device for which the shared pool of
+ * coherent MEM2 memory has been registered.
+ */
+static struct device *wii_mem2_dma_dev(void)
+{
+	struct mem2_dma *mem2_dma = mem2_dma_get_instance();
+	BUG_ON(!mem2_dma->pdev);
+	return &mem2_dma->pdev->dev;
+}
+
+/**
+ * wii_set_mem2_dma_constraints() - forces device to use MEM2 DMA buffers only
+ * @dev:	device for which DMA constraints are defined
+ *
+ * Instructs device @dev to always use MEM2 DMA buffers for DMA transfers.
+ */
+int wii_set_mem2_dma_constraints(struct device *dev)
+{
+	struct dev_archdata *sd;
+
+	sd = &dev->archdata;
+	sd->max_direct_dma_addr = 0;
+	sd->min_direct_dma_addr = wii_hole_start + wii_hole_size;
+
+	set_dma_ops(dev, &wii_mem2_dma_ops);
+	return 0;
+}
+EXPORT_SYMBOL(wii_set_mem2_dma_constraints);
+
+/**
+ * wii_clear_mem2_dma_constraints() - clears device MEM2 DMA constraints
+ * @dev:	device for which DMA constraints are cleared
+ *
+ * Instructs device @dev to stop using MEM2 DMA buffers for DMA transfers.
+ * Must be called to undo wii_set_mem2_dma_constraints().
+ */
+void wii_clear_mem2_dma_constraints(struct device *dev)
+{
+	struct dev_archdata *sd;
+
+	sd = &dev->archdata;
+	sd->max_direct_dma_addr = 0;
+	sd->min_direct_dma_addr = 0;
+
+	set_dma_ops(dev, &dma_direct_ops);
+}
+EXPORT_SYMBOL(wii_clear_mem2_dma_constraints);
+
+/*
+ * swiotlb-based DMA ops for MEM2-only devices on the Wii.
+ *
+ */
+
+/*
+ * Allocate the SWIOTLB from MEM2.
+ */
+void * __init swiotlb_alloc_boot(size_t size, unsigned long nslabs)
+{
+	return __alloc_bootmem_low(size, PAGE_SIZE,
+				   wii_hole_start + wii_hole_size);
+}
+
+/*
+ * Bounce: copy the swiotlb buffer back to the original dma location
+ * This is a platform specific version replacing the generic __weak version.
+ */
+void swiotlb_bounce(phys_addr_t phys, char *dma_buf, size_t size,
+		    enum dma_data_direction dir)
+{
+	void *vaddr = phys_to_virt(phys);
+
+	if (dir == DMA_TO_DEVICE) {
+		memcpy(dma_buf, vaddr, size);
+		__dma_sync(dma_buf, size, dir);
+	} else {
+		__dma_sync(dma_buf, size, dir);
+		memcpy(vaddr, dma_buf, size);
+	}
+}
+
+static dma_addr_t
+mem2_virt_to_bus(struct device *dev, void *address)
+{
+	return phys_to_dma(dev, virt_to_phys(address));
+}
+
+static int
+mem2_dma_mapping_error(struct device *dev, dma_addr_t dma_handle)
+{
+	return dma_handle == mem2_virt_to_bus(dev, swiotlb_bk_overflow_buffer);
+}
+
+static int
+mem2_dma_supported(struct device *dev, u64 mask)
+{
+	return mem2_virt_to_bus(dev, swiotlb_bk_end - 1) <= mask;
+}
+
+/*
+ * Determines if a given DMA region specified by @dma_handle
+ * requires bouncing.
+ *
+ * Bouncing is required if the DMA region falls within MEM1.
+ */
+static int mem2_needs_dmabounce(dma_addr_t dma_handle)
+{
+	return dma_handle < wii_hole_start;
+}
+
+/*
+ * Use the dma_direct_ops hooks for allocating and freeing coherent memory
+ * from the MEM2 DMA region.
+ */
+
+static void *mem2_alloc_coherent(struct device *dev, size_t size,
+				 dma_addr_t *dma_handle, gfp_t gfp)
+{
+	void *vaddr;
+
+	vaddr = dma_direct_ops.alloc_coherent(wii_mem2_dma_dev(), size,
+					      dma_handle, gfp);
+	if (vaddr && mem2_needs_dmabounce(*dma_handle)) {
+		dma_direct_ops.free_coherent(wii_mem2_dma_dev(), size, vaddr,
+					     *dma_handle);
+		dev_err(dev, "failed to allocate MEM2 coherent memory\n");
+		vaddr = NULL;
+	}
+	return vaddr;
+}
+
+static void mem2_free_coherent(struct device *dev, size_t size,
+			       void *vaddr, dma_addr_t dma_handle)
+{
+	dma_direct_ops.free_coherent(wii_mem2_dma_dev(), size, vaddr,
+				     dma_handle);
+}
+
+/*
+ * Maps (part of) a page so it can be safely accessed by a device.
+ *
+ * Calls the corresponding dma_direct_ops hook if the page region falls
+ * within MEM2.
+ * Otherwise, a bounce buffer allocated from MEM2 coherent memory is used.
+ */
+static dma_addr_t
+mem2_map_page(struct device *dev, struct page *page, unsigned long offset,
+	      size_t size, enum dma_data_direction dir,
+	      struct dma_attrs *attrs)
+{
+	phys_addr_t phys = page_to_phys(page) + offset;
+	dma_addr_t dma_handle = phys_to_dma(dev, phys);
+	dma_addr_t swiotlb_start_dma;
+	void *map;
+
+	BUG_ON(dir == DMA_NONE);
+
+	if (dma_capable(dev, dma_handle, size) && !swiotlb_force) {
+		return dma_direct_ops.map_page(dev, page, offset, size,
+					       dir, attrs);
+	}
+
+	swiotlb_start_dma = mem2_virt_to_bus(dev, swiotlb_bk_start);
+	map = swiotlb_bk_map_single(dev, phys, swiotlb_start_dma, size, dir);
+	if (!map) {
+		swiotlb_full(dev, size, dir, 1);
+		map = swiotlb_bk_overflow_buffer;
+	}
+
+	dma_handle = mem2_virt_to_bus(dev, map);
+	BUG_ON(!dma_capable(dev, dma_handle, size));
+
+	return dma_handle;
+}
+
+/*
+ * Unmaps (part of) a page previously mapped.
+ *
+ * Calls the corresponding dma_direct_ops hook if the DMA region associated
+ * to the dma handle @dma_handle wasn't bounced.
+ * Otherwise, the associated bounce buffer is de-bounced.
+ */
+static void
+mem2_unmap_page(struct device *dev, dma_addr_t dma_handle, size_t size,
+		enum dma_data_direction dir, struct dma_attrs *attrs)
+{
+	swiotlb_unmap_page(dev, dma_handle, size, dir, attrs);
+}
+
+/*
+ * Unmaps a scatter/gather list by unmapping each entry.
+ */
+static void
+mem2_unmap_sg(struct device *dev, struct scatterlist *sgl, int nents,
+	      enum dma_data_direction dir, struct dma_attrs *attrs)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(sgl, sg, nents, i)
+		mem2_unmap_page(dev, sg->dma_address, sg->length, dir, attrs);
+}
+
+/*
+ * Maps a scatter/gather list by mapping each entry.
+ */
+static int
+mem2_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
+	    enum dma_data_direction dir, struct dma_attrs *attrs)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(sgl, sg, nents, i) {
+		sg->dma_length = sg->length;
+		sg->dma_address = mem2_map_page(dev, sg_page(sg), sg->offset,
+						sg->length, dir, attrs);
+		if (mem2_dma_mapping_error(dev, sg->dma_address)) {
+			mem2_unmap_sg(dev, sgl, i, dir, attrs);
+			nents = 0;
+			sgl[nents].dma_length = 0;
+			pr_debug("%s: mem2_map_page error\n", __func__);
+			break;
+		}
+	}
+	return nents;
+}
+
+/*
+ * The sync functions synchronize streaming mode DMA translations
+ * making physical memory consistent before/after a DMA transfer.
+ *
+ * They call the corresponding dma_direct_ops hook if the DMA region
+ * associated to the dma handle @dma_handle wasn't bounced.
+ * Otherwise, original DMA buffers and their matching bounce buffers are put
+ * in sync.
+ */
+
+static int
+mem2_sync_range(struct device *dev, dma_addr_t dma_handle,
+		unsigned long offset, size_t size, int dir, int target)
+{
+	phys_addr_t paddr = dma_to_phys(dev, dma_handle) + offset;
+	void *vaddr = phys_to_virt(paddr);
+
+	BUG_ON(dir == DMA_NONE);
+
+	if (is_swiotlb_buffer(paddr)) {
+		swiotlb_bk_sync_single(dev, vaddr, size, dir, target);
+		return 1;
+	}
+	return 0;
+}
+
+static void
+mem2_sync_range_for_cpu(struct device *dev, dma_addr_t dma_handle,
+			unsigned long offset, size_t size,
+			enum dma_data_direction dir)
+{
+	int done = mem2_sync_range(dev, dma_handle, offset, size, dir,
+				   SYNC_FOR_CPU);
+	if (!done) {
+		dma_direct_ops.sync_single_range_for_cpu(dev, dma_handle,
+							 offset, size, dir);
+	}
+}
+
+static void
+mem2_sync_range_for_device(struct device *dev, dma_addr_t dma_handle,
+			   unsigned long offset, size_t size,
+			   enum dma_data_direction dir)
+{
+	int done = mem2_sync_range(dev, dma_handle, offset, size, dir,
+				   SYNC_FOR_DEVICE);
+	if (!done) {
+		dma_direct_ops.sync_single_range_for_device(dev, dma_handle,
+							    offset, size, dir);
+	}
+}
+
+static void
+mem2_sync_sg_for_cpu(struct device *dev, struct scatterlist *sgl, int nents,
+		     enum dma_data_direction dir)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(sgl, sg, nents, i) {
+		mem2_sync_range_for_cpu(dev, sg_dma_address(sg), sg->offset,
+					sg_dma_len(sg), dir);
+	}
+}
+
+static void
+mem2_sync_sg_for_device(struct device *dev, struct scatterlist *sgl, int nents,
+			enum dma_data_direction dir)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(sgl, sg, nents, i) {
+		mem2_sync_range_for_device(dev, sg_dma_address(sg), sg->offset,
+					   sg_dma_len(sg), dir);
+	}
+}
+
+/*
+ * Set of DMA operations for devices requiring MEM2 DMA buffers.
+ */
+struct dma_map_ops wii_mem2_dma_ops = {
+	.alloc_coherent = mem2_alloc_coherent,
+	.free_coherent = mem2_free_coherent,
+	.map_sg = mem2_map_sg,
+	.unmap_sg = mem2_unmap_sg,
+	.dma_supported = mem2_dma_supported,
+	.map_page = mem2_map_page,
+	.unmap_page = mem2_unmap_page,
+	.sync_single_range_for_cpu = mem2_sync_range_for_cpu,
+	.sync_single_range_for_device = mem2_sync_range_for_device,
+	.sync_sg_for_cpu = mem2_sync_sg_for_cpu,
+	.sync_sg_for_device = mem2_sync_sg_for_device,
+	.mapping_error = mem2_dma_mapping_error,
+};
-- 
1.6.3.3
