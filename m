Return-Path: <albert_herranz@yahoo.es>
Received: from smtp134.mail.ukl.yahoo.com (smtp134.mail.ukl.yahoo.com
	[77.238.184.65]) by ozlabs.org (Postfix) with SMTP id 381E9B7EE7
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  7 Mar 2010 23:12:06 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v3 09/11] wii: add mem2 dma mapping ops
Date: Sun,  7 Mar 2010 13:11:50 +0100
Message-Id: <1267963912-984-10-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1267963912-984-1-git-send-email-albert_herranz@yahoo.es>
References: <1267963912-984-1-git-send-email-albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>
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
 arch/powerpc/boot/wii.c                      |   34 ++++
 arch/powerpc/include/asm/wii.h               |   25 +++
 arch/powerpc/platforms/embedded6xx/Kconfig   |    1 +
 arch/powerpc/platforms/embedded6xx/Makefile  |    2 +-
 arch/powerpc/platforms/embedded6xx/wii-dma.c |  255 ++++++++++++++++++++++++++
 5 files changed, 316 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/include/asm/wii.h
 create mode 100755 arch/powerpc/platforms/embedded6xx/wii-dma.c

diff --git a/arch/powerpc/boot/wii.c b/arch/powerpc/boot/wii.c
index 2ebaec0..388e33d 100644
--- a/arch/powerpc/boot/wii.c
+++ b/arch/powerpc/boot/wii.c
@@ -30,6 +30,9 @@ BSS_STACK(8192);
 #define MEM2_TOP		(0x10000000 + 64*1024*1024)
 #define FIRMWARE_DEFAULT_SIZE	(12*1024*1024)
 
+#define MEM2_DMA_BASE_PROP	"linux,wii-mem2-dma-base"
+#define MEM2_DMA_SIZE_PROP	"linux,wii-mem2-dma-size"
+#define MEM2_DMA_DEFAULT_SIZE	(512*1024)
 
 struct mipc_infohdr {
 	char magic[3];
@@ -101,6 +104,30 @@ out:
 
 }
 
+static void mem2_fixups(u32 *top, u32 *reg)
+{
+	void *chosen;
+	u32 dma_base, dma_size;
+	int len;
+
+	chosen = finddevice("/chosen");
+	if (!chosen)
+		fatal("Can't find chosen node\n");
+
+	len = getprop(chosen, MEM2_DMA_SIZE_PROP, &dma_size, sizeof(dma_size));
+	if (len != sizeof(dma_size))
+		dma_size = MEM2_DMA_DEFAULT_SIZE;
+	if (dma_size > reg[3])
+		dma_size = reg[3];
+	setprop_val(chosen, MEM2_DMA_SIZE_PROP, dma_size);
+
+	*top -= dma_size;
+	dma_base = *top;
+	setprop_val(chosen, MEM2_DMA_BASE_PROP, dma_base);
+
+	printf("mem2_dma: %08X@%08X\n", dma_size, dma_base);
+}
+
 static void platform_fixups(void)
 {
 	void *mem;
@@ -127,9 +154,16 @@ static void platform_fixups(void)
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
index 0000000..ff2eb67
--- /dev/null
+++ b/arch/powerpc/platforms/embedded6xx/wii-dma.c
@@ -0,0 +1,255 @@
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
+/* same as in arch/powerpc/boot/wii.c */
+#define MEM2_DMA_BASE_PROP	"linux,wii-mem2-dma-base"
+#define MEM2_DMA_SIZE_PROP	"linux,wii-mem2-dma-size"
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
+static int __init mem2_dma_setup(void)
+{
+	const dma_addr_t *dma_base;
+	const size_t *dma_size;
+	int error = -ENODEV;
+
+	dma_base = of_get_property(of_chosen, MEM2_DMA_BASE_PROP, NULL);
+	if (!dma_base) {
+		pr_err("can't find %s property\n", MEM2_DMA_BASE_PROP);
+		goto out;
+	}
+
+	dma_size = of_get_property(of_chosen, MEM2_DMA_SIZE_PROP, NULL);
+	if (!dma_size) {
+		pr_err("can't find %s property\n", MEM2_DMA_SIZE_PROP);
+		goto out;
+	}
+
+	error = mem2_dma_init(*dma_base, *dma_size);
+	if (error)
+		pr_err("error %d during setup\n", error);
+out:
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
+ * Use the dma_direct_ops hooks for allocating and freeing coherent memory.
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
+		dev_err(wii_mem2_dma_dev(), "failed to allocate MEM2 coherent"
+			" memory\n");
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
+ * Set of DMA operations for devices requiring MEM2 DMA buffers.
+ */
+struct dma_map_ops wii_mem2_dma_ops = {
+	.alloc_coherent = mem2_alloc_coherent,
+	.free_coherent = mem2_free_coherent,
+	.map_sg = swiotlb_map_sg_attrs,
+	.unmap_sg = swiotlb_unmap_sg_attrs,
+	.dma_supported = swiotlb_dma_supported,
+	.map_page = swiotlb_map_page,
+	.unmap_page = swiotlb_unmap_page,
+	.sync_single_range_for_cpu = swiotlb_sync_single_range_for_cpu,
+	.sync_single_range_for_device = swiotlb_sync_single_range_for_device,
+	.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
+	.sync_sg_for_device = swiotlb_sync_sg_for_cpu,
+	.mapping_error = swiotlb_dma_mapping_error,
+};
-- 
1.6.3.3
