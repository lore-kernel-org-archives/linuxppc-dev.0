Return-Path: <albert_herranz@yahoo.es>
Received: from smtp138.mail.ukl.yahoo.com (smtp138.mail.ukl.yahoo.com
	[77.238.184.69]) by ozlabs.org (Postfix) with SMTP id DE86BB7E3E
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  1 Mar 2010 01:08:29 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	linux-usb@vger.kernel.org
Subject: [RFC PATCH v2 7/9] wii: add mem2 dma mapping ops
Date: Sun, 28 Feb 2010 15:08:00 +0100
Message-Id: <1267366082-15248-8-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1267366082-15248-1-git-send-email-albert_herranz@yahoo.es>
References: <1267366082-15248-1-git-send-email-albert_herranz@yahoo.es>
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

QUICKFIX: wii-dma

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 arch/powerpc/boot/wii.c                      |   34 ++
 arch/powerpc/include/asm/wii.h               |   25 ++
 arch/powerpc/platforms/embedded6xx/Kconfig   |    1 +
 arch/powerpc/platforms/embedded6xx/Makefile  |    2 +-
 arch/powerpc/platforms/embedded6xx/wii-dma.c |  557 ++++++++++++++++++++++++++
 5 files changed, 618 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/include/asm/wii.h
 create mode 100755 arch/powerpc/platforms/embedded6xx/wii-dma.c

diff --git a/arch/powerpc/boot/wii.c b/arch/powerpc/boot/wii.c
index 2ebaec0..f884006 100644
--- a/arch/powerpc/boot/wii.c
+++ b/arch/powerpc/boot/wii.c
@@ -30,6 +30,9 @@ BSS_STACK(8192);
 #define MEM2_TOP		(0x10000000 + 64*1024*1024)
 #define FIRMWARE_DEFAULT_SIZE	(12*1024*1024)
 
+#define MEM2_DMA_BASE_PROP	"linux,wii-mem2-dma-base"
+#define MEM2_DMA_SIZE_PROP	"linux,wii-mem2-dma-size"
+#define MEM2_DMA_DEFAULT_SIZE	(1*1024*1024)
 
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
index fe77ab2..4d33755 100644
--- a/arch/powerpc/platforms/embedded6xx/Kconfig
+++ b/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -120,6 +120,7 @@ config WII
 	depends on EMBEDDED6xx
 	select GAMECUBE_COMMON
 	select HAVE_GENERIC_DMA_COHERENT
+	select HAVE_DMABOUNCE
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
index 0000000..d0d2c1f
--- /dev/null
+++ b/arch/powerpc/platforms/embedded6xx/wii-dma.c
@@ -0,0 +1,557 @@
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
+#undef BOUNCE_ALL
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmabounce.h>
+#include <linux/of.h>
+#include <linux/lmb.h>
+#include <asm/wii.h>
+
+#include "mm/mmu_decl.h"
+
+#define MEM2_DMA_BASE_PROP	"linux,wii-mem2-dma-base"
+#define MEM2_DMA_SIZE_PROP	"linux,wii-mem2-dma-size"
+
+#define MEM2_DMA_MAPPING_ERROR	((~(dma_addr_t)0)-1)
+
+#define MEM2_BOUNCE_ALIGN	32	/* cache line size */
+#define MEM2_ACCESS_ALIGN	4
+
+#define __align_ofs(x, size)	((unsigned long)(x)&((size)-1))
+#define __align_up(x, size)	(((unsigned long)(x)+((size)-1))&(~((size)-1)))
+#define __align_down(x, size)	(((unsigned long)(x))&(~((size)-1)))
+
+/* get the offset from the previous aligned access boundary */
+#define mem2_align_ofs(x)		__align_ofs((x), MEM2_ACCESS_ALIGN)
+/* adjust to the previous aligned access boundary */
+#define mem2_align_down(x)		__align_down((x), MEM2_ACCESS_ALIGN)
+/* adjust to the next aligned bouncing boundary */
+#define mem2_align_up(x)		__align_up((x), MEM2_BOUNCE_ALIGN)
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
+ * sure that DMA buffers sitting in MEM1 get bounced to/from coherent DMA
+ * buffers allocated from MEM2, and that the actual bouncing is done by
+ * using 32-bit accesses to coherent memory.
+ *
+ * Bouncing is performed with the help of the generic dmabounce support.
+ */
+
+/*
+ * Copies @len bytes from the coherent memory region starting at
+ * @src + @offset to the memory region starting at @dst + @offset.
+ * The source coherent memory region length is guaranteed to be
+ * 32-bit aligned _and_ equal or greater than @len.
+ *
+ * Reads from coherent memory have no access restrictions.
+ */
+static inline void *memcpy_from_coherent(void *dst, void *src,
+					 unsigned long offset, size_t len)
+{
+	memcpy(dst + offset, src + offset, len);
+	return dst;
+}
+
+/*
+ * Copies @len bytes from the memory region starting at @src + @offset
+ * to the coherent memory region starting at @dst + @offset.
+ * The destination coherent memory region length is guaranteed to be
+ * 32-bit aligned _and_ equal or greater than @len.
+ *
+ * Because of the write access restrictions, all writes to the
+ * destination coherent memory region must be performed in 32-bit chunks.
+ */
+static void *memcpy_to_coherent(void *dst, void *src,
+				unsigned long offset, size_t len)
+{
+	u32 *p4, *q4, v4;
+	u8 *p1, *q1;
+	size_t chunk_delta, chunk_size;
+
+	if (!len)
+		return dst;
+
+	/* first copy the unaligned prefix, if available */
+	q4 = dst + offset;
+	p4 = src + offset;
+	chunk_size = 0;
+	chunk_delta = mem2_align_ofs(q4);
+	if (chunk_delta) {
+		chunk_size = min(len, MEM2_ACCESS_ALIGN - chunk_delta);
+		q4 = (u32 *)mem2_align_down(q4);
+		v4 = *q4;
+		q1 = (u8 *)&v4;
+		memcpy(q1 + chunk_delta, p4, chunk_size);
+		*q4++ = v4;
+		p4 = src + offset + chunk_size;
+		len -= chunk_size;
+	}
+
+	/* second, perform the aligned central copy */
+	while (len >= 4) {
+		*q4++ = *p4++;
+		len -= 4;
+	}
+
+	/* finally, copy the unaligned trailing chunk if needed */
+	p1 = (u8 *)p4;
+	v4 = *q4;
+	q1 = (u8 *)&v4;
+	switch (len) {
+	case 3:
+		*q4 = p1[0] << 24 | p1[1] << 16 | p1[2] << 8 | q1[3];
+		break;
+	case 2:
+		*q4 = p1[0] << 24 | p1[1] << 16 | q1[2] << 8 | q1[3];
+		break;
+	case 1:
+		*q4 = p1[0] << 24 | q1[1] << 16 | q1[2] << 8 | q1[3];
+		break;
+	default:
+		break;
+	}
+	return dst;
+}
+
+/*
+ * Determines if a given DMA region specified by @dma_handle and @size
+ * requires bouncing.
+ *
+ * Bouncing is required if the DMA region falls within MEM1.
+ */
+static int mem2_needs_dmabounce(dma_addr_t dma_handle)
+{
+#ifndef BOUNCE_ALL
+	return dma_handle < wii_hole_start;
+#else
+	return 1;
+#endif
+}
+
+static int mem2_mapping_error(struct device *dev, dma_addr_t dma_handle)
+{
+	return dma_handle == MEM2_DMA_MAPPING_ERROR;
+}
+
+/*
+ * Use the dma_direct_ops hooks for allocating and freeing coherent memory.
+ * Idem for checking if a device supports a specific DMA mask.
+ */
+
+static void *mem2_alloc_coherent(struct device *dev, size_t size,
+				 dma_addr_t *dma_handle, gfp_t gfp)
+{
+	return dma_direct_ops.alloc_coherent(dev, size, dma_handle, gfp);
+}
+
+static void mem2_free_coherent(struct device *dev, size_t size,
+			       void *vaddr, dma_addr_t dma_handle)
+{
+	return dma_direct_ops.free_coherent(dev, size, vaddr, dma_handle);
+}
+
+static int mem2_dma_supported(struct device *dev, u64 mask)
+{
+	return dma_direct_ops.dma_supported(dev, mask);
+}
+
+/*
+ * Maps (part of) a page so it can be safely accessed by a device.
+ *
+ * Calls the corresponding dma_direct_ops hook if the page region falls
+ * within MEM2.
+ * Otherwise, a bounce buffer allocated from MEM2 coherent memory is used.
+ */
+static dma_addr_t mem2_map_page(struct device *dev, struct page *page,
+				unsigned long offset, size_t size,
+				enum dma_data_direction dir,
+				struct dma_attrs *attrs)
+{
+	struct dmabounce_info *info = dev->archdata.dmabounce;
+	void *buf = page_address(page) + offset;
+	dma_addr_t dma_handle = phys_to_dma(dev, page_to_phys(page) + offset);
+	size_t up_size = mem2_align_up(size);
+	struct dmabounce_buffer *bb;
+
+	BUG_ON(!info);
+	DMABOUNCE_DO_STATS(info, map_op_count++);
+
+	if (!mem2_needs_dmabounce(dma_handle)) {
+		dma_handle = dma_direct_ops.map_page(dev, page, offset, size,
+						     dir, attrs);
+		goto out;
+	}
+
+	bb = dmabounce_alloc_buffer(info, buf, up_size, dir, GFP_ATOMIC);
+	if (!bb) {
+		pr_debug("%s: dmabounce_alloc_buffer error\n", __func__);
+		dma_handle = MEM2_DMA_MAPPING_ERROR;
+		goto out;
+	}
+
+	if (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL)
+		memcpy_to_coherent(bb->bounce_buf, bb->buf, 0, size);
+	dma_handle = bb->bounce_buf_dma;
+out:
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
+static void mem2_unmap_page(struct device *dev, dma_addr_t dma_handle,
+			    size_t size, enum dma_data_direction dir,
+			    struct dma_attrs *attrs)
+{
+	struct dmabounce_info *info = dev->archdata.dmabounce;
+	size_t up_size = mem2_align_up(size);
+	struct dmabounce_buffer *bb;
+
+	BUG_ON(!info);
+
+	bb = dmabounce_find_buffer(info, dma_handle, up_size, dir);
+	if (!bb) {
+		dma_direct_ops.unmap_page(dev, dma_handle, size, dir, attrs);
+		return;
+	}
+
+	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL) {
+		DMABOUNCE_DO_STATS(info, bounce_count++);
+		memcpy_from_coherent(bb->buf, bb->bounce_buf, 0, size);
+		__dma_sync(bb->buf, size, DMA_BIDIRECTIONAL);
+	}
+	dmabounce_free_buffer(info, bb);
+}
+
+/*
+ * Unmaps a scatter/gather list by unmapping each entry.
+ */
+void mem2_unmap_sg(struct device *dev, struct scatterlist *sgl, int nents,
+		   enum dma_data_direction dir, struct dma_attrs *attrs)
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
+static int mem2_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
+		       enum dma_data_direction dir, struct dma_attrs *attrs)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(sgl, sg, nents, i) {
+		sg->dma_length = sg->length;
+		sg->dma_address = mem2_map_page(dev, sg_page(sg), sg->offset,
+						sg->length, dir, attrs);
+		if (mem2_mapping_error(dev, sg->dma_address)) {
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
+ * Also, for correctness, original DMA buffers are also made consistent.
+ */
+
+static void mem2_sync_range_for_cpu(struct device *dev, dma_addr_t dma_handle,
+				    unsigned long offset, size_t size,
+				    enum dma_data_direction dir)
+{
+	struct dmabounce_info *info = dev->archdata.dmabounce;
+	struct dmabounce_buffer *bb;
+
+	BUG_ON(!info);
+
+	dev_dbg(dev, "%s(dma=%#x,off=%#lx,sz=%zx,dir=%x)\n",
+		__func__, dma_handle, offset, size, dir);
+
+	bb = dmabounce_find_buffer(info, dma_handle, 0, dir);
+	if (!bb) {
+		dma_direct_ops.sync_single_range_for_cpu(dev, dma_handle,
+							 offset, size, dir);
+		return;
+	}
+	BUG_ON(offset + size > bb->size);
+
+	DMABOUNCE_DO_STATS(info, bounce_count++);
+
+	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL) {
+		dev_dbg(dev, "%s: copy back bounce %p to buf %p, size %d\n",
+			__func__, bb->bounce_buf + offset, bb->buf + offset,
+			size);
+		memcpy_from_coherent(bb->buf, bb->bounce_buf, offset, size);
+		__dma_sync(bb->buf + offset, size, DMA_BIDIRECTIONAL);
+	}
+}
+
+static void mem2_sync_range_for_device(struct device *dev,
+				       dma_addr_t dma_handle,
+				       unsigned long offset, size_t size,
+				       enum dma_data_direction dir)
+{
+	struct dmabounce_info *info = dev->archdata.dmabounce;
+	struct dmabounce_buffer *bb;
+
+	BUG_ON(!info);
+
+	dev_dbg(dev, "%s(dma=%#x,off=%#lx,sz=%zx,dir=%x)\n",
+		__func__, dma_handle, offset, size, dir);
+
+	bb = dmabounce_find_buffer(info, dma_handle, 0, dir);
+	if (!bb) {
+		WARN_ON(1);
+		dma_direct_ops.sync_single_range_for_device(dev, dma_handle,
+							    offset, size, dir);
+		return;
+	}
+	BUG_ON(offset + size > bb->size);
+
+	DMABOUNCE_DO_STATS(info, bounce_count++);
+
+	if (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL) {
+		dev_dbg(dev, "%s: copy out buf %p to bounce %p, size %d\n",
+			__func__, bb->buf + offset, bb->bounce_buf + offset,
+			size);
+		memcpy_to_coherent(bb->bounce_buf, bb->buf, offset, size);
+	}
+}
+
+static void mem2_sync_sg_for_cpu(struct device *dev,
+				 struct scatterlist *sgl, int nents,
+				 enum dma_data_direction dir)
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
+static void mem2_sync_sg_for_device(struct device *dev,
+				    struct scatterlist *sgl, int nents,
+				    enum dma_data_direction dir)
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
+ * The mem2_dma "device".
+ *
+ * This device "owns" a pool of coherent MEM2 memory that can be shared among
+ * several devices requiring MEM2 DMA buffers, instead of dedicating specific
+ * pools for each device.
+ *
+ * A device can use the shared coherent MEM2 memory pool by:
+ * - allocating a dmabounce_info struct associated to the mem2_dma device
+ * - registering this dmabounce_info with the device
+ * - making wii_mem2_dma_ops the default DMA operations for the device
+ */
+
+struct mem2_dma {
+	struct platform_device *pdev;
+	struct dmabounce_info *info;
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
+	struct dmabounce_info *info;
+	int error = -ENOMEM;
+
+	info = dmabounce_info_alloc(wii_mem2_dma_dev(), 0, 0, 4, 0);
+	if (!info)
+		goto out;
+	error = dmabounce_info_register(dev, info);
+	if (error)
+		goto out;
+	set_dma_ops(dev, &wii_mem2_dma_ops);
+out:
+	return error;
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
+	struct dmabounce_info *info = dev->archdata.dmabounce;
+
+	if (info) {
+		dmabounce_info_unregister(dev);
+		dmabounce_info_free(info);
+		set_dma_ops(dev, &dma_direct_ops);
+	}
+}
+EXPORT_SYMBOL(wii_clear_mem2_dma_constraints);
+
+/*
+ * Set of DMA operations for devices requiring MEM2 DMA buffers.
+ */
+struct dma_map_ops wii_mem2_dma_ops = {
+	.alloc_coherent = mem2_alloc_coherent,
+	.free_coherent = mem2_free_coherent,
+	.map_sg = mem2_map_sg,
+	.unmap_sg = mem2_unmap_sg,
+	.map_page = mem2_map_page,
+	.unmap_page = mem2_unmap_page,
+	.sync_single_range_for_cpu = mem2_sync_range_for_cpu,
+	.sync_single_range_for_device = mem2_sync_range_for_device,
+	.sync_sg_for_cpu = mem2_sync_sg_for_cpu,
+	.sync_sg_for_device = mem2_sync_sg_for_device,
+	.dma_supported = mem2_dma_supported,
+	.mapping_error = mem2_mapping_error,
+};
-- 
1.6.3.3
