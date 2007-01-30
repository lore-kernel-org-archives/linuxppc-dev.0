Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A299FDE1ED
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 10:20:37 +1100 (EST)
Message-ID: <45BFD2BB.1030008@am.sony.com>
Date: Tue, 30 Jan 2007 15:20:27 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/4] PS3: Move system bus to platform directory
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Move the PS3 system bus routines from drivers/ps3 to arch/powerpc/platforms/ps3.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---

As requested by Ben and Christoph.

 drivers/ps3/system-bus.c                |  362 -------------------------------
 arch/powerpc/platforms/ps3/Makefile     |    1 
 arch/powerpc/platforms/ps3/htab.c       |    1 
 arch/powerpc/platforms/ps3/interrupt.c  |    1 
 arch/powerpc/platforms/ps3/mm.c         |    1 
 arch/powerpc/platforms/ps3/os-area.c    |    1 
 arch/powerpc/platforms/ps3/platform.h   |  151 +++++++++++++
 arch/powerpc/platforms/ps3/repository.c |    3 
 arch/powerpc/platforms/ps3/setup.c      |    1 
 arch/powerpc/platforms/ps3/smp.c        |    1 
 arch/powerpc/platforms/ps3/spu.c        |    3 
 arch/powerpc/platforms/ps3/system-bus.c |  363 ++++++++++++++++++++++++++++++++
 drivers/ps3/Makefile                    |    1 
 include/asm-powerpc/ps3.h               |  150 -------------
 14 files changed, 519 insertions(+), 521 deletions(-)

--- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/Makefile
+++ ps3-linux-dev/arch/powerpc/platforms/ps3/Makefile
@@ -1,5 +1,6 @@
 obj-y += setup.o mm.o time.o hvcall.o htab.o repository.o
 obj-y += interrupt.o exports.o os-area.o
+obj-y += system-bus.o
 
 obj-$(CONFIG_SMP) += smp.o
 obj-$(CONFIG_SPU_BASE) += spu.o
--- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/htab.c
+++ ps3-linux-dev/arch/powerpc/platforms/ps3/htab.c
@@ -23,7 +23,6 @@
 #include <asm/machdep.h>
 #include <asm/lmb.h>
 #include <asm/udbg.h>
-#include <asm/ps3.h>
 #include <asm/lv1call.h>
 
 #include "platform.h"
--- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/interrupt.c
+++ ps3-linux-dev/arch/powerpc/platforms/ps3/interrupt.c
@@ -24,7 +24,6 @@
 
 #include <asm/machdep.h>
 #include <asm/udbg.h>
-#include <asm/ps3.h>
 #include <asm/lv1call.h>
 
 #include "platform.h"
--- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/mm.c
+++ ps3-linux-dev/arch/powerpc/platforms/ps3/mm.c
@@ -25,7 +25,6 @@
 #include <asm/firmware.h>
 #include <asm/lmb.h>
 #include <asm/udbg.h>
-#include <asm/ps3.h>
 #include <asm/lv1call.h>
 
 #include "platform.h"
--- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/os-area.c
+++ ps3-linux-dev/arch/powerpc/platforms/ps3/os-area.c
@@ -22,7 +22,6 @@
 #include <linux/io.h>
 
 #include <asm/lmb.h>
-#include <asm/ps3.h>
 
 #include "platform.h"
 
--- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/platform.h
+++ ps3-linux-dev/arch/powerpc/platforms/ps3/platform.h
@@ -22,6 +22,9 @@
 #define _PS3_PLATFORM_H
 
 #include <linux/rtc.h>
+#include <scsi/scsi.h>
+
+#include <asm/ps3.h>
 
 /* htab */
 
@@ -65,4 +68,152 @@ void ps3_spu_set_platform (void);
 static inline void ps3_spu_set_platform (void) {}
 #endif
 
+/* repository bus info */
+
+enum ps3_bus_type {
+	PS3_BUS_TYPE_SB = 4,
+	PS3_BUS_TYPE_STORAGE = 5,
+};
+
+enum ps3_dev_type {
+	PS3_DEV_TYPE_STOR_DISK = TYPE_DISK,	/* 0 */
+	PS3_DEV_TYPE_SB_GELIC = 3,
+	PS3_DEV_TYPE_SB_USB = 4,
+	PS3_DEV_TYPE_STOR_ROM = TYPE_ROM,	/* 5 */
+	PS3_DEV_TYPE_SB_GPIO = 6,
+	PS3_DEV_TYPE_STOR_FLASH = TYPE_RBC,	/* 14 */
+};
+
+int ps3_repository_read_bus_str(unsigned int bus_index, const char *bus_str,
+	u64 *value);
+int ps3_repository_read_bus_id(unsigned int bus_index, unsigned int *bus_id);
+int ps3_repository_read_bus_type(unsigned int bus_index,
+	enum ps3_bus_type *bus_type);
+int ps3_repository_read_bus_num_dev(unsigned int bus_index,
+	unsigned int *num_dev);
+
+/* repository bus device info */
+
+enum ps3_interrupt_type {
+	PS3_INTERRUPT_TYPE_EVENT_PORT = 2,
+	PS3_INTERRUPT_TYPE_SB_OHCI = 3,
+	PS3_INTERRUPT_TYPE_SB_EHCI = 4,
+	PS3_INTERRUPT_TYPE_OTHER = 5,
+};
+
+enum ps3_reg_type {
+	PS3_REG_TYPE_SB_OHCI = 3,
+	PS3_REG_TYPE_SB_EHCI = 4,
+	PS3_REG_TYPE_SB_GPIO = 5,
+};
+
+int ps3_repository_read_dev_str(unsigned int bus_index,
+	unsigned int dev_index, const char *dev_str, u64 *value);
+int ps3_repository_read_dev_id(unsigned int bus_index, unsigned int dev_index,
+	unsigned int *dev_id);
+int ps3_repository_read_dev_type(unsigned int bus_index,
+	unsigned int dev_index, enum ps3_dev_type *dev_type);
+int ps3_repository_read_dev_intr(unsigned int bus_index,
+	unsigned int dev_index, unsigned int intr_index,
+	enum ps3_interrupt_type *intr_type, unsigned int *interrupt_id);
+int ps3_repository_read_dev_reg_type(unsigned int bus_index,
+	unsigned int dev_index, unsigned int reg_index,
+	enum ps3_reg_type *reg_type);
+int ps3_repository_read_dev_reg_addr(unsigned int bus_index,
+	unsigned int dev_index, unsigned int reg_index, u64 *bus_addr,
+	u64 *len);
+int ps3_repository_read_dev_reg(unsigned int bus_index,
+	unsigned int dev_index, unsigned int reg_index,
+	enum ps3_reg_type *reg_type, u64 *bus_addr, u64 *len);
+
+/* repository bus enumerators */
+
+struct ps3_repository_device {
+	unsigned int bus_index;
+	unsigned int dev_index;
+	struct ps3_device_id did;
+};
+
+int ps3_repository_find_device(enum ps3_bus_type bus_type,
+	enum ps3_dev_type dev_type,
+	const struct ps3_repository_device *start_dev,
+	struct ps3_repository_device *dev);
+static inline int ps3_repository_find_first_device(
+	enum ps3_bus_type bus_type, enum ps3_dev_type dev_type,
+	struct ps3_repository_device *dev)
+{
+	return ps3_repository_find_device(bus_type, dev_type, NULL, dev);
+}
+int ps3_repository_find_interrupt(const struct ps3_repository_device *dev,
+	enum ps3_interrupt_type intr_type, unsigned int *interrupt_id);
+int ps3_repository_find_reg(const struct ps3_repository_device *dev,
+	enum ps3_reg_type reg_type, u64 *bus_addr, u64 *len);
+
+/* repository block device info */
+
+int ps3_repository_read_stor_dev_port(unsigned int bus_index,
+	unsigned int dev_index, u64 *port);
+int ps3_repository_read_stor_dev_blk_size(unsigned int bus_index,
+	unsigned int dev_index, u64 *blk_size);
+int ps3_repository_read_stor_dev_num_blocks(unsigned int bus_index,
+	unsigned int dev_index, u64 *num_blocks);
+int ps3_repository_read_stor_dev_num_regions(unsigned int bus_index,
+	unsigned int dev_index, unsigned int *num_regions);
+int ps3_repository_read_stor_dev_region_id(unsigned int bus_index,
+	unsigned int dev_index, unsigned int region_index,
+	unsigned int *region_id);
+int ps3_repository_read_stor_dev_region_size(unsigned int bus_index,
+	unsigned int dev_index,	unsigned int region_index, u64 *region_size);
+int ps3_repository_read_stor_dev_region_start(unsigned int bus_index,
+	unsigned int dev_index, unsigned int region_index, u64 *region_start);
+int ps3_repository_read_stor_dev_info(unsigned int bus_index,
+	unsigned int dev_index, u64 *port, u64 *blk_size,
+	u64 *num_blocks, unsigned int *num_regions);
+int ps3_repository_read_stor_dev_region(unsigned int bus_index,
+	unsigned int dev_index, unsigned int region_index,
+	unsigned int *region_id, u64 *region_start, u64 *region_size);
+
+/* repository pu and memory info */
+
+int ps3_repository_read_num_pu(unsigned int *num_pu);
+int ps3_repository_read_ppe_id(unsigned int *pu_index, unsigned int *ppe_id);
+int ps3_repository_read_rm_base(unsigned int ppe_id, u64 *rm_base);
+int ps3_repository_read_rm_size(unsigned int ppe_id, u64 *rm_size);
+int ps3_repository_read_region_total(u64 *region_total);
+int ps3_repository_read_mm_info(u64 *rm_base, u64 *rm_size,
+	u64 *region_total);
+
+/* repository pme info */
+
+int ps3_repository_read_num_be(unsigned int *num_be);
+int ps3_repository_read_be_node_id(unsigned int be_index, u64 *node_id);
+int ps3_repository_read_tb_freq(u64 node_id, u64 *tb_freq);
+int ps3_repository_read_be_tb_freq(unsigned int be_index, u64 *tb_freq);
+
+/* repository 'Other OS' area */
+
+int ps3_repository_read_boot_dat_addr(u64 *lpar_addr);
+int ps3_repository_read_boot_dat_size(unsigned int *size);
+int ps3_repository_read_boot_dat_info(u64 *lpar_addr, unsigned int *size);
+
+/* repository spu info */
+
+/**
+ * enum spu_resource_type - Type of spu resource.
+ * @spu_resource_type_shared: Logical spu is shared with other partions.
+ * @spu_resource_type_exclusive: Logical spu is not shared with other partions.
+ *
+ * Returned by ps3_repository_read_spu_resource_id().
+ */
+
+enum ps3_spu_resource_type {
+	PS3_SPU_RESOURCE_TYPE_SHARED = 0,
+	PS3_SPU_RESOURCE_TYPE_EXCLUSIVE = 0x8000000000000000UL,
+};
+
+int ps3_repository_read_num_spu_reserved(unsigned int *num_spu_reserved);
+int ps3_repository_read_num_spu_resource_id(unsigned int *num_resource_id);
+int ps3_repository_read_spu_resource_id(unsigned int res_index,
+	enum ps3_spu_resource_type* resource_type, unsigned int *resource_id);
+
 #endif
--- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/repository.c
+++ ps3-linux-dev/arch/powerpc/platforms/ps3/repository.c
@@ -18,9 +18,10 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-#include <asm/ps3.h>
 #include <asm/lv1call.h>
 
+#include "platform.h"
+
 enum ps3_vendor_id {
 	PS3_VENDOR_ID_NONE = 0,
 	PS3_VENDOR_ID_SONY = 0x8000000000000000UL,
--- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/setup.c
+++ ps3-linux-dev/arch/powerpc/platforms/ps3/setup.c
@@ -32,7 +32,6 @@
 #include <asm/udbg.h>
 #include <asm/prom.h>
 #include <asm/lv1call.h>
-#include <asm/ps3.h>
 
 #include "platform.h"
 
--- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/smp.c
+++ ps3-linux-dev/arch/powerpc/platforms/ps3/smp.c
@@ -23,7 +23,6 @@
 
 #include <asm/machdep.h>
 #include <asm/udbg.h>
-#include <asm/ps3.h>
 
 #include "platform.h"
 
--- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/spu.c
+++ ps3-linux-dev/arch/powerpc/platforms/ps3/spu.c
@@ -26,9 +26,10 @@
 
 #include <asm/spu.h>
 #include <asm/spu_priv1.h>
-#include <asm/ps3.h>
 #include <asm/lv1call.h>
 
+#include "platform.h"
+
 /* spu_management_ops */
 
 /**
--- /dev/null
+++ ps3-linux-dev/arch/powerpc/platforms/ps3/system-bus.c
@@ -0,0 +1,363 @@
+/*
+ *  PS3 system bus driver.
+ *
+ *  Copyright (C) 2006 Sony Computer Entertainment Inc.
+ *  Copyright 2006 Sony Corp.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
+
+#include <asm/udbg.h>
+#include <asm/lv1call.h>
+#include <asm/firmware.h>
+
+#include "platform.h"
+
+#define dump_mmio_region(_a) _dump_mmio_region(_a, __func__, __LINE__)
+static void _dump_mmio_region(const struct ps3_mmio_region* r,
+	const char* func, int line)
+{
+	pr_debug("%s:%d: dev       %u:%u\n", func, line, r->did.bus_id,
+		r->did.dev_id);
+	pr_debug("%s:%d: bus_addr  %lxh\n", func, line, r->bus_addr);
+	pr_debug("%s:%d: len       %lxh\n", func, line, r->len);
+	pr_debug("%s:%d: lpar_addr %lxh\n", func, line, r->lpar_addr);
+}
+
+int ps3_mmio_region_create(struct ps3_mmio_region *r)
+{
+	int result;
+
+	result = lv1_map_device_mmio_region(r->did.bus_id, r->did.dev_id,
+		r->bus_addr, r->len, r->page_size, &r->lpar_addr);
+
+	if (result) {
+		pr_debug("%s:%d: lv1_map_device_mmio_region failed: %s\n",
+			__func__, __LINE__, ps3_result(result));
+		r->lpar_addr = 0;
+	}
+
+	dump_mmio_region(r);
+	return result;
+}
+
+int ps3_free_mmio_region(struct ps3_mmio_region *r)
+{
+	int result;
+
+	result = lv1_unmap_device_mmio_region(r->did.bus_id, r->did.dev_id,
+		r->lpar_addr);
+
+	if (result)
+		pr_debug("%s:%d: lv1_unmap_device_mmio_region failed: %s\n",
+			__func__, __LINE__, ps3_result(result));
+
+	r->lpar_addr = 0;
+	return result;
+}
+
+static int ps3_system_bus_match(struct device *_dev,
+	struct device_driver *_drv)
+{
+	int result;
+	struct ps3_system_bus_driver *drv = to_ps3_system_bus_driver(_drv);
+	struct ps3_system_bus_device *dev = to_ps3_system_bus_device(_dev);
+
+	result = dev->match_id == drv->match_id;
+
+	pr_info("%s:%d: dev=%u(%s), drv=%u(%s): %s\n", __func__, __LINE__,
+		dev->match_id, dev->core.bus_id, drv->match_id, drv->core.name,
+		(result ? "match" : "miss"));
+	return result;
+}
+
+static int ps3_system_bus_probe(struct device *_dev)
+{
+	int result;
+	struct ps3_system_bus_device *dev = to_ps3_system_bus_device(_dev);
+	struct ps3_system_bus_driver *drv =
+		to_ps3_system_bus_driver(_dev->driver);
+
+	result = lv1_open_device(dev->did.bus_id, dev->did.dev_id, 0);
+
+	if (result) {
+		pr_debug("%s:%d: lv1_open_device failed (%d)\n",
+			__func__, __LINE__, result);
+		result = -EACCES;
+		goto clean_none;
+	}
+
+	if (dev->d_region->did.bus_id) {
+		result = ps3_dma_region_create(dev->d_region);
+
+		if (result) {
+			pr_debug("%s:%d: ps3_dma_region_create failed (%d)\n",
+				__func__, __LINE__, result);
+			BUG_ON("check region type");
+			result = -EINVAL;
+			goto clean_device;
+		}
+	}
+
+	BUG_ON(!drv);
+
+	if (drv->probe)
+		result = drv->probe(dev);
+	else
+		pr_info("%s:%d: %s no probe method\n", __func__, __LINE__,
+			dev->core.bus_id);
+
+	if (result) {
+		pr_debug("%s:%d: drv->probe failed\n", __func__, __LINE__);
+		goto clean_dma;
+	}
+
+	return result;
+
+clean_dma:
+	ps3_dma_region_free(dev->d_region);
+clean_device:
+	lv1_close_device(dev->did.bus_id, dev->did.dev_id);
+clean_none:
+	return result;
+}
+
+static int ps3_system_bus_remove(struct device *_dev)
+{
+	struct ps3_system_bus_device *dev = to_ps3_system_bus_device(_dev);
+	struct ps3_system_bus_driver *drv =
+		to_ps3_system_bus_driver(_dev->driver);
+
+	if (drv->remove)
+		drv->remove(dev);
+	else
+		pr_info("%s:%d: %s no remove method\n", __func__, __LINE__,
+			dev->core.bus_id);
+
+	ps3_dma_region_free(dev->d_region);
+	ps3_free_mmio_region(dev->m_region);
+	lv1_close_device(dev->did.bus_id, dev->did.dev_id);
+
+	return 0;
+}
+
+struct bus_type ps3_system_bus_type = {
+	.name = "ps3_system_bus",
+	.match = ps3_system_bus_match,
+	.probe = ps3_system_bus_probe,
+	.remove = ps3_system_bus_remove,
+};
+
+int __init ps3_system_bus_init(void)
+{
+	int result;
+
+	if (!firmware_has_feature(FW_FEATURE_PS3_LV1))
+		return 0;
+
+	result = bus_register(&ps3_system_bus_type);
+	BUG_ON(result);
+	return result;
+}
+
+core_initcall(ps3_system_bus_init);
+
+/* Allocates a contiguous real buffer and creates mappings over it.
+ * Returns the virtual address of the buffer and sets dma_handle
+ * to the dma address (mapping) of the first page.
+ */
+
+static void * ps3_alloc_coherent(struct device *_dev, size_t size,
+	dma_addr_t *dma_handle, gfp_t flag)
+{
+	int result;
+	struct ps3_system_bus_device *dev = to_ps3_system_bus_device(_dev);
+	unsigned long virt_addr;
+
+	BUG_ON(!dev->d_region->bus_addr);
+
+	flag &= ~(__GFP_DMA | __GFP_HIGHMEM);
+	flag |= __GFP_ZERO;
+
+	virt_addr = __get_free_pages(flag, get_order(size));
+
+	if (!virt_addr) {
+		pr_debug("%s:%d: get_free_pages failed\n", __func__, __LINE__);
+		goto clean_none;
+	}
+
+	result = ps3_dma_map(dev->d_region, virt_addr, size, dma_handle);
+
+	if (result) {
+		pr_debug("%s:%d: ps3_dma_map failed (%d)\n",
+			__func__, __LINE__, result);
+		BUG_ON("check region type");
+		goto clean_alloc;
+	}
+
+	return (void*)virt_addr;
+
+clean_alloc:
+	free_pages(virt_addr, get_order(size));
+clean_none:
+	dma_handle = NULL;
+	return NULL;
+}
+
+static void ps3_free_coherent(struct device *_dev, size_t size, void *vaddr,
+	dma_addr_t dma_handle)
+{
+	struct ps3_system_bus_device *dev = to_ps3_system_bus_device(_dev);
+
+	ps3_dma_unmap(dev->d_region, dma_handle, size);
+	free_pages((unsigned long)vaddr, get_order(size));
+}
+
+/* Creates TCEs for a user provided buffer.  The user buffer must be
+ * contiguous real kernel storage (not vmalloc).  The address of the buffer
+ * passed here is the kernel (virtual) address of the buffer.  The buffer
+ * need not be page aligned, the dma_addr_t returned will point to the same
+ * byte within the page as vaddr.
+ */
+
+static dma_addr_t ps3_map_single(struct device *_dev, void *ptr, size_t size,
+	enum dma_data_direction direction)
+{
+	struct ps3_system_bus_device *dev = to_ps3_system_bus_device(_dev);
+	int result;
+	unsigned long bus_addr;
+
+	result = ps3_dma_map(dev->d_region, (unsigned long)ptr, size,
+		&bus_addr);
+
+	if (result) {
+		pr_debug("%s:%d: ps3_dma_map failed (%d)\n",
+			__func__, __LINE__, result);
+	}
+
+	return bus_addr;
+}
+
+static void ps3_unmap_single(struct device *_dev, dma_addr_t dma_addr,
+	size_t size, enum dma_data_direction direction)
+{
+	struct ps3_system_bus_device *dev = to_ps3_system_bus_device(_dev);
+	int result;
+
+	result = ps3_dma_unmap(dev->d_region, dma_addr, size);
+
+	if (result) {
+		pr_debug("%s:%d: ps3_dma_unmap failed (%d)\n",
+			__func__, __LINE__, result);
+	}
+}
+
+static int ps3_map_sg(struct device *_dev, struct scatterlist *sg, int nents,
+	enum dma_data_direction direction)
+{
+#if defined(CONFIG_PS3_DYNAMIC_DMA)
+	BUG_ON("do");
+#endif
+	return 0;
+}
+
+static void ps3_unmap_sg(struct device *_dev, struct scatterlist *sg,
+	int nents, enum dma_data_direction direction)
+{
+#if defined(CONFIG_PS3_DYNAMIC_DMA)
+	BUG_ON("do");
+#endif
+}
+
+static int ps3_dma_supported(struct device *_dev, u64 mask)
+{
+	return 1;
+}
+
+static struct dma_mapping_ops ps3_dma_ops = {
+	.alloc_coherent = ps3_alloc_coherent,
+	.free_coherent = ps3_free_coherent,
+	.map_single = ps3_map_single,
+	.unmap_single = ps3_unmap_single,
+	.map_sg = ps3_map_sg,
+	.unmap_sg = ps3_unmap_sg,
+	.dma_supported = ps3_dma_supported
+};
+
+/**
+ * ps3_system_bus_release_device - remove a device from the system bus
+ */
+
+static void ps3_system_bus_release_device(struct device *_dev)
+{
+	struct ps3_system_bus_device *dev = to_ps3_system_bus_device(_dev);
+	kfree(dev);
+}
+
+/**
+ * ps3_system_bus_device_register - add a device to the system bus
+ *
+ * ps3_system_bus_device_register() expects the dev object to be allocated
+ * dynamically by the caller.  The system bus takes ownership of the dev
+ * object and frees the object in ps3_system_bus_release_device().
+ */
+
+int ps3_system_bus_device_register(struct ps3_system_bus_device *dev)
+{
+	int result;
+	static unsigned int dev_count = 1;
+
+	dev->core.parent = NULL;
+	dev->core.bus = &ps3_system_bus_type;
+	dev->core.release = ps3_system_bus_release_device;
+
+	dev->core.archdata.of_node = NULL;
+	dev->core.archdata.dma_ops = &ps3_dma_ops;
+	dev->core.archdata.numa_node = 0;
+
+	snprintf(dev->core.bus_id, sizeof(dev->core.bus_id), "sb_%02x",
+		dev_count++);
+
+	pr_debug("%s:%d add %s\n", __func__, __LINE__, dev->core.bus_id);
+
+	result = device_register(&dev->core);
+	return result;
+}
+
+EXPORT_SYMBOL_GPL(ps3_system_bus_device_register);
+
+int ps3_system_bus_driver_register(struct ps3_system_bus_driver *drv)
+{
+	int result;
+
+	drv->core.bus = &ps3_system_bus_type;
+
+	result = driver_register(&drv->core);
+	return result;
+}
+
+EXPORT_SYMBOL_GPL(ps3_system_bus_driver_register);
+
+void ps3_system_bus_driver_unregister(struct ps3_system_bus_driver *drv)
+{
+	driver_unregister(&drv->core);
+}
+
+EXPORT_SYMBOL_GPL(ps3_system_bus_driver_unregister);
--- ps3-linux-dev.orig/drivers/ps3/Makefile
+++ ps3-linux-dev/drivers/ps3/Makefile
@@ -1,2 +1 @@
-obj-y += system-bus.o
 obj-$(CONFIG_PS3_VUART) += vuart.o
--- ps3-linux-dev.orig/drivers/ps3/system-bus.c
+++ /dev/null
@@ -1,362 +0,0 @@
-/*
- *  PS3 system bus driver.
- *
- *  Copyright (C) 2006 Sony Computer Entertainment Inc.
- *  Copyright 2006 Sony Corp.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; version 2 of the License.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/dma-mapping.h>
-#include <linux/err.h>
-
-#include <asm/udbg.h>
-#include <asm/ps3.h>
-#include <asm/lv1call.h>
-#include <asm/firmware.h>
-
-#define dump_mmio_region(_a) _dump_mmio_region(_a, __func__, __LINE__)
-static void _dump_mmio_region(const struct ps3_mmio_region* r,
-	const char* func, int line)
-{
-	pr_debug("%s:%d: dev       %u:%u\n", func, line, r->did.bus_id,
-		r->did.dev_id);
-	pr_debug("%s:%d: bus_addr  %lxh\n", func, line, r->bus_addr);
-	pr_debug("%s:%d: len       %lxh\n", func, line, r->len);
-	pr_debug("%s:%d: lpar_addr %lxh\n", func, line, r->lpar_addr);
-}
-
-int ps3_mmio_region_create(struct ps3_mmio_region *r)
-{
-	int result;
-
-	result = lv1_map_device_mmio_region(r->did.bus_id, r->did.dev_id,
-		r->bus_addr, r->len, r->page_size, &r->lpar_addr);
-
-	if (result) {
-		pr_debug("%s:%d: lv1_map_device_mmio_region failed: %s\n",
-			__func__, __LINE__, ps3_result(result));
-		r->lpar_addr = 0;
-	}
-
-	dump_mmio_region(r);
-	return result;
-}
-
-int ps3_free_mmio_region(struct ps3_mmio_region *r)
-{
-	int result;
-
-	result = lv1_unmap_device_mmio_region(r->did.bus_id, r->did.dev_id,
-		r->lpar_addr);
-
-	if (result)
-		pr_debug("%s:%d: lv1_unmap_device_mmio_region failed: %s\n",
-			__func__, __LINE__, ps3_result(result));
-
-	r->lpar_addr = 0;
-	return result;
-}
-
-static int ps3_system_bus_match(struct device *_dev,
-	struct device_driver *_drv)
-{
-	int result;
-	struct ps3_system_bus_driver *drv = to_ps3_system_bus_driver(_drv);
-	struct ps3_system_bus_device *dev = to_ps3_system_bus_device(_dev);
-
-	result = dev->match_id == drv->match_id;
-
-	pr_info("%s:%d: dev=%u(%s), drv=%u(%s): %s\n", __func__, __LINE__,
-		dev->match_id, dev->core.bus_id, drv->match_id, drv->core.name,
-		(result ? "match" : "miss"));
-	return result;
-}
-
-static int ps3_system_bus_probe(struct device *_dev)
-{
-	int result;
-	struct ps3_system_bus_device *dev = to_ps3_system_bus_device(_dev);
-	struct ps3_system_bus_driver *drv =
-		to_ps3_system_bus_driver(_dev->driver);
-
-	result = lv1_open_device(dev->did.bus_id, dev->did.dev_id, 0);
-
-	if (result) {
-		pr_debug("%s:%d: lv1_open_device failed (%d)\n",
-			__func__, __LINE__, result);
-		result = -EACCES;
-		goto clean_none;
-	}
-
-	if (dev->d_region->did.bus_id) {
-		result = ps3_dma_region_create(dev->d_region);
-
-		if (result) {
-			pr_debug("%s:%d: ps3_dma_region_create failed (%d)\n",
-				__func__, __LINE__, result);
-			BUG_ON("check region type");
-			result = -EINVAL;
-			goto clean_device;
-		}
-	}
-
-	BUG_ON(!drv);
-
-	if (drv->probe)
-		result = drv->probe(dev);
-	else
-		pr_info("%s:%d: %s no probe method\n", __func__, __LINE__,
-			dev->core.bus_id);
-
-	if (result) {
-		pr_debug("%s:%d: drv->probe failed\n", __func__, __LINE__);
-		goto clean_dma;
-	}
-
-	return result;
-
-clean_dma:
-	ps3_dma_region_free(dev->d_region);
-clean_device:
-	lv1_close_device(dev->did.bus_id, dev->did.dev_id);
-clean_none:
-	return result;
-}
-
-static int ps3_system_bus_remove(struct device *_dev)
-{
-	struct ps3_system_bus_device *dev = to_ps3_system_bus_device(_dev);
-	struct ps3_system_bus_driver *drv =
-		to_ps3_system_bus_driver(_dev->driver);
-
-	if (drv->remove)
-		drv->remove(dev);
-	else
-		pr_info("%s:%d: %s no remove method\n", __func__, __LINE__,
-			dev->core.bus_id);
-
-	ps3_dma_region_free(dev->d_region);
-	ps3_free_mmio_region(dev->m_region);
-	lv1_close_device(dev->did.bus_id, dev->did.dev_id);
-
-	return 0;
-}
-
-struct bus_type ps3_system_bus_type = {
-        .name = "ps3_system_bus",
-	.match = ps3_system_bus_match,
-	.probe = ps3_system_bus_probe,
-	.remove = ps3_system_bus_remove,
-};
-
-int __init ps3_system_bus_init(void)
-{
-	int result;
-
-	if (!firmware_has_feature(FW_FEATURE_PS3_LV1))
-		return 0;
-
-	result = bus_register(&ps3_system_bus_type);
-	BUG_ON(result);
-	return result;
-}
-
-core_initcall(ps3_system_bus_init);
-
-/* Allocates a contiguous real buffer and creates mappings over it.
- * Returns the virtual address of the buffer and sets dma_handle
- * to the dma address (mapping) of the first page.
- */
-
-static void * ps3_alloc_coherent(struct device *_dev, size_t size,
-	dma_addr_t *dma_handle, gfp_t flag)
-{
-	int result;
-	struct ps3_system_bus_device *dev = to_ps3_system_bus_device(_dev);
-	unsigned long virt_addr;
-
-	BUG_ON(!dev->d_region->bus_addr);
-
-	flag &= ~(__GFP_DMA | __GFP_HIGHMEM);
-	flag |= __GFP_ZERO;
-
-	virt_addr = __get_free_pages(flag, get_order(size));
-
-	if (!virt_addr) {
-		pr_debug("%s:%d: get_free_pages failed\n", __func__, __LINE__);
-		goto clean_none;
-	}
-
-	result = ps3_dma_map(dev->d_region, virt_addr, size, dma_handle);
-
-	if (result) {
-		pr_debug("%s:%d: ps3_dma_map failed (%d)\n",
-			__func__, __LINE__, result);
-		BUG_ON("check region type");
-		goto clean_alloc;
-	}
-
-	return (void*)virt_addr;
-
-clean_alloc:
-	free_pages(virt_addr, get_order(size));
-clean_none:
-	dma_handle = NULL;
-	return NULL;
-}
-
-static void ps3_free_coherent(struct device *_dev, size_t size, void *vaddr,
-	dma_addr_t dma_handle)
-{
-	struct ps3_system_bus_device *dev = to_ps3_system_bus_device(_dev);
-
-	ps3_dma_unmap(dev->d_region, dma_handle, size);
-	free_pages((unsigned long)vaddr, get_order(size));
-}
-
-/* Creates TCEs for a user provided buffer.  The user buffer must be
- * contiguous real kernel storage (not vmalloc).  The address of the buffer
- * passed here is the kernel (virtual) address of the buffer.  The buffer
- * need not be page aligned, the dma_addr_t returned will point to the same
- * byte within the page as vaddr.
- */
-
-static dma_addr_t ps3_map_single(struct device *_dev, void *ptr, size_t size,
-	enum dma_data_direction direction)
-{
-	struct ps3_system_bus_device *dev = to_ps3_system_bus_device(_dev);
-	int result;
-	unsigned long bus_addr;
-
-	result = ps3_dma_map(dev->d_region, (unsigned long)ptr, size,
-		&bus_addr);
-
-	if (result) {
-		pr_debug("%s:%d: ps3_dma_map failed (%d)\n",
-			__func__, __LINE__, result);
-	}
-
-	return bus_addr;
-}
-
-static void ps3_unmap_single(struct device *_dev, dma_addr_t dma_addr,
-	size_t size, enum dma_data_direction direction)
-{
-	struct ps3_system_bus_device *dev = to_ps3_system_bus_device(_dev);
-	int result;
-
-	result = ps3_dma_unmap(dev->d_region, dma_addr, size);
-
-	if (result) {
-		pr_debug("%s:%d: ps3_dma_unmap failed (%d)\n",
-			__func__, __LINE__, result);
-	}
-}
-
-static int ps3_map_sg(struct device *_dev, struct scatterlist *sg, int nents,
-	enum dma_data_direction direction)
-{
-#if defined(CONFIG_PS3_DYNAMIC_DMA)
-	BUG_ON("do");
-#endif
-	return 0;
-}
-
-static void ps3_unmap_sg(struct device *_dev, struct scatterlist *sg,
-	int nents, enum dma_data_direction direction)
-{
-#if defined(CONFIG_PS3_DYNAMIC_DMA)
-	BUG_ON("do");
-#endif
-}
-
-static int ps3_dma_supported(struct device *_dev, u64 mask)
-{
-	return 1;
-}
-
-static struct dma_mapping_ops ps3_dma_ops = {
-	.alloc_coherent = ps3_alloc_coherent,
-	.free_coherent = ps3_free_coherent,
-	.map_single = ps3_map_single,
-	.unmap_single = ps3_unmap_single,
-	.map_sg = ps3_map_sg,
-	.unmap_sg = ps3_unmap_sg,
-	.dma_supported = ps3_dma_supported
-};
-
-/**
- * ps3_system_bus_release_device - remove a device from the system bus
- */
-
-static void ps3_system_bus_release_device(struct device *_dev)
-{
-	struct ps3_system_bus_device *dev = to_ps3_system_bus_device(_dev);
-	kfree(dev);
-}
-
-/**
- * ps3_system_bus_device_register - add a device to the system bus
- *
- * ps3_system_bus_device_register() expects the dev object to be allocated
- * dynamically by the caller.  The system bus takes ownership of the dev
- * object and frees the object in ps3_system_bus_release_device().
- */
-
-int ps3_system_bus_device_register(struct ps3_system_bus_device *dev)
-{
-	int result;
-	static unsigned int dev_count = 1;
-
-	dev->core.parent = NULL;
-	dev->core.bus = &ps3_system_bus_type;
-	dev->core.release = ps3_system_bus_release_device;
-
-	dev->core.archdata.of_node = NULL;
-	dev->core.archdata.dma_ops = &ps3_dma_ops;
-	dev->core.archdata.numa_node = 0;
-
-	snprintf(dev->core.bus_id, sizeof(dev->core.bus_id), "sb_%02x",
-		dev_count++);
-
-	pr_debug("%s:%d add %s\n", __func__, __LINE__, dev->core.bus_id);
-
-	result = device_register(&dev->core);
-	return result;
-}
-
-EXPORT_SYMBOL_GPL(ps3_system_bus_device_register);
-
-int ps3_system_bus_driver_register(struct ps3_system_bus_driver *drv)
-{
-	int result;
-
-	drv->core.bus = &ps3_system_bus_type;
-
-	result = driver_register(&drv->core);
-	return result;
-}
-
-EXPORT_SYMBOL_GPL(ps3_system_bus_driver_register);
-
-void ps3_system_bus_driver_unregister(struct ps3_system_bus_driver *drv)
-{
-	driver_unregister(&drv->core);
-}
-
-EXPORT_SYMBOL_GPL(ps3_system_bus_driver_unregister);
--- ps3-linux-dev.orig/include/asm-powerpc/ps3.h
+++ ps3-linux-dev/include/asm-powerpc/ps3.h
@@ -24,7 +24,6 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/device.h>
-#include <scsi/scsi.h>
 
 union ps3_firmware_version {
 	u64 raw;
@@ -282,155 +281,6 @@ static inline const char* ps3_result(int
 #endif
 }
 
-/* repository bus info */
-
-enum ps3_bus_type {
-	PS3_BUS_TYPE_SB = 4,
-	PS3_BUS_TYPE_STORAGE = 5,
-};
-
-enum ps3_dev_type {
-	PS3_DEV_TYPE_STOR_DISK = TYPE_DISK,	/* 0 */
-	PS3_DEV_TYPE_SB_GELIC = 3,
-	PS3_DEV_TYPE_SB_USB = 4,
-	PS3_DEV_TYPE_STOR_ROM = TYPE_ROM,	/* 5 */
-	PS3_DEV_TYPE_SB_GPIO = 6,
-	PS3_DEV_TYPE_STOR_FLASH = TYPE_RBC,	/* 14 */
-};
-
-int ps3_repository_read_bus_str(unsigned int bus_index, const char *bus_str,
-	u64 *value);
-int ps3_repository_read_bus_id(unsigned int bus_index, unsigned int *bus_id);
-int ps3_repository_read_bus_type(unsigned int bus_index,
-	enum ps3_bus_type *bus_type);
-int ps3_repository_read_bus_num_dev(unsigned int bus_index,
-	unsigned int *num_dev);
-
-/* repository bus device info */
-
-enum ps3_interrupt_type {
-	PS3_INTERRUPT_TYPE_EVENT_PORT = 2,
-	PS3_INTERRUPT_TYPE_SB_OHCI = 3,
-	PS3_INTERRUPT_TYPE_SB_EHCI = 4,
-	PS3_INTERRUPT_TYPE_OTHER = 5,
-};
-
-enum ps3_reg_type {
-	PS3_REG_TYPE_SB_OHCI = 3,
-	PS3_REG_TYPE_SB_EHCI = 4,
-	PS3_REG_TYPE_SB_GPIO = 5,
-};
-
-int ps3_repository_read_dev_str(unsigned int bus_index,
-	unsigned int dev_index, const char *dev_str, u64 *value);
-int ps3_repository_read_dev_id(unsigned int bus_index, unsigned int dev_index,
-	unsigned int *dev_id);
-int ps3_repository_read_dev_type(unsigned int bus_index,
-	unsigned int dev_index, enum ps3_dev_type *dev_type);
-int ps3_repository_read_dev_intr(unsigned int bus_index,
-	unsigned int dev_index, unsigned int intr_index,
-	enum ps3_interrupt_type *intr_type, unsigned int *interrupt_id);
-int ps3_repository_read_dev_reg_type(unsigned int bus_index,
-	unsigned int dev_index, unsigned int reg_index,
-	enum ps3_reg_type *reg_type);
-int ps3_repository_read_dev_reg_addr(unsigned int bus_index,
-	unsigned int dev_index, unsigned int reg_index, u64 *bus_addr,
-	u64 *len);
-int ps3_repository_read_dev_reg(unsigned int bus_index,
-	unsigned int dev_index, unsigned int reg_index,
-	enum ps3_reg_type *reg_type, u64 *bus_addr, u64 *len);
-
-/* repository bus enumerators */
-
-struct ps3_repository_device {
-	unsigned int bus_index;
-	unsigned int dev_index;
-	struct ps3_device_id did;
-};
-
-int ps3_repository_find_device(enum ps3_bus_type bus_type,
-	enum ps3_dev_type dev_type,
-	const struct ps3_repository_device *start_dev,
-	struct ps3_repository_device *dev);
-static inline int ps3_repository_find_first_device(
-	enum ps3_bus_type bus_type, enum ps3_dev_type dev_type,
-	struct ps3_repository_device *dev)
-{
-	return ps3_repository_find_device(bus_type, dev_type, NULL, dev);
-}
-int ps3_repository_find_interrupt(const struct ps3_repository_device *dev,
-	enum ps3_interrupt_type intr_type, unsigned int *interrupt_id);
-int ps3_repository_find_reg(const struct ps3_repository_device *dev,
-	enum ps3_reg_type reg_type, u64 *bus_addr, u64 *len);
-
-/* repository block device info */
-
-int ps3_repository_read_stor_dev_port(unsigned int bus_index,
-	unsigned int dev_index, u64 *port);
-int ps3_repository_read_stor_dev_blk_size(unsigned int bus_index,
-	unsigned int dev_index, u64 *blk_size);
-int ps3_repository_read_stor_dev_num_blocks(unsigned int bus_index,
-	unsigned int dev_index, u64 *num_blocks);
-int ps3_repository_read_stor_dev_num_regions(unsigned int bus_index,
-	unsigned int dev_index, unsigned int *num_regions);
-int ps3_repository_read_stor_dev_region_id(unsigned int bus_index,
-	unsigned int dev_index, unsigned int region_index,
-	unsigned int *region_id);
-int ps3_repository_read_stor_dev_region_size(unsigned int bus_index,
-	unsigned int dev_index,	unsigned int region_index, u64 *region_size);
-int ps3_repository_read_stor_dev_region_start(unsigned int bus_index,
-	unsigned int dev_index, unsigned int region_index, u64 *region_start);
-int ps3_repository_read_stor_dev_info(unsigned int bus_index,
-	unsigned int dev_index, u64 *port, u64 *blk_size,
-	u64 *num_blocks, unsigned int *num_regions);
-int ps3_repository_read_stor_dev_region(unsigned int bus_index,
-	unsigned int dev_index, unsigned int region_index,
-	unsigned int *region_id, u64 *region_start, u64 *region_size);
-
-/* repository pu and memory info */
-
-int ps3_repository_read_num_pu(unsigned int *num_pu);
-int ps3_repository_read_ppe_id(unsigned int *pu_index, unsigned int *ppe_id);
-int ps3_repository_read_rm_base(unsigned int ppe_id, u64 *rm_base);
-int ps3_repository_read_rm_size(unsigned int ppe_id, u64 *rm_size);
-int ps3_repository_read_region_total(u64 *region_total);
-int ps3_repository_read_mm_info(u64 *rm_base, u64 *rm_size,
-	u64 *region_total);
-
-/* repository pme info */
-
-int ps3_repository_read_num_be(unsigned int *num_be);
-int ps3_repository_read_be_node_id(unsigned int be_index, u64 *node_id);
-int ps3_repository_read_tb_freq(u64 node_id, u64 *tb_freq);
-int ps3_repository_read_be_tb_freq(unsigned int be_index, u64 *tb_freq);
-
-/* repository 'Other OS' area */
-
-int ps3_repository_read_boot_dat_addr(u64 *lpar_addr);
-int ps3_repository_read_boot_dat_size(unsigned int *size);
-int ps3_repository_read_boot_dat_info(u64 *lpar_addr, unsigned int *size);
-
-/* repository spu info */
-
-/**
- * enum spu_resource_type - Type of spu resource.
- * @spu_resource_type_shared: Logical spu is shared with other partions.
- * @spu_resource_type_exclusive: Logical spu is not shared with other partions.
- *
- * Returned by ps3_repository_read_spu_resource_id().
- */
-
-enum ps3_spu_resource_type {
-	PS3_SPU_RESOURCE_TYPE_SHARED = 0,
-	PS3_SPU_RESOURCE_TYPE_EXCLUSIVE = 0x8000000000000000UL,
-};
-
-int ps3_repository_read_num_spu_reserved(unsigned int *num_spu_reserved);
-int ps3_repository_read_num_spu_resource_id(unsigned int *num_resource_id);
-int ps3_repository_read_spu_resource_id(unsigned int res_index,
-	enum ps3_spu_resource_type* resource_type, unsigned int *resource_id);
-
-
 /* system bus routines */
 
 enum ps3_match_id {
