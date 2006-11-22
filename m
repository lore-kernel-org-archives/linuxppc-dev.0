Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from mail78-cpk-R.bigfish.com (mail-cpk.bigfish.com [207.46.163.10])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D6BFA67E30
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 15:51:08 +1100 (EST)
Message-ID: <4563D02F.9010307@am.sony.com>
Date: Tue, 21 Nov 2006 20:21:03 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 13/14] powerpc: add ps3 platform system bus support
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Geoff Levand <geoffrey.levand@am.sony.com>

Adds a PS3 system bus driver.  This system bus is a virtual bus used to present
the PS3 system devices in the LDM.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
 drivers/Makefile          |    1 
 drivers/ps3/Makefile      |    1 
 drivers/ps3/system-bus.c  |  358 ++++++++++++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/ps3.h |   73 +++++++++
 4 files changed, 433 insertions(+)

Index: cell--common--6/drivers/Makefile
===================================================================
--- cell--common--6.orig/drivers/Makefile
+++ cell--common--6/drivers/Makefile
@@ -77,3 +77,4 @@
 obj-$(CONFIG_SUPERH)		+= sh/
 obj-$(CONFIG_GENERIC_TIME)	+= clocksource/
 obj-$(CONFIG_DMA_ENGINE)	+= dma/
+obj-$(CONFIG_PS3)		+= ps3/
Index: cell--common--6/drivers/ps3/Makefile
===================================================================
--- /dev/null
+++ cell--common--6/drivers/ps3/Makefile
@@ -0,0 +1 @@
+obj-y += system-bus.o
Index: cell--common--6/drivers/ps3/system-bus.c
===================================================================
--- /dev/null
+++ cell--common--6/drivers/ps3/system-bus.c
@@ -0,0 +1,358 @@
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
+#include <asm/ps3.h>
+#include <asm/lv1call.h>
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
+		r->lpar_addr = r->len = r->bus_addr = 0;
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
+		r->bus_addr);
+
+	if (result)
+		pr_debug("%s:%d: lv1_unmap_device_mmio_region failed: %s\n",
+			__func__, __LINE__, ps3_result(result));
+
+	r->lpar_addr = r->len = r->bus_addr = 0;
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
+        .name = "ps3_system_bus",
+	.match = ps3_system_bus_match,
+	.probe = ps3_system_bus_probe,
+	.remove = ps3_system_bus_remove,
+};
+
+int __init ps3_system_bus_init(void)
+{
+	int result;
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
Index: cell--common--6/include/asm-powerpc/ps3.h
===================================================================
--- cell--common--6.orig/include/asm-powerpc/ps3.h
+++ cell--common--6/include/asm-powerpc/ps3.h
@@ -386,4 +386,77 @@
 int ps3_repository_read_spu_resource_id(unsigned int res_index,
 	enum ps3_spu_resource_type* resource_type, unsigned int *resource_id);
 
+
+/* system bus routines */
+
+enum ps3_match_id {
+	PS3_MATCH_ID_EHCI = 1,
+	PS3_MATCH_ID_OHCI,
+	PS3_MATCH_ID_GELIC,
+	PS3_MATCH_ID_AV_SETTINGS,
+	PS3_MATCH_ID_SYSTEM_MANAGER,
+};
+
+/**
+ * struct ps3_system_bus_device - a device on the system bus
+ */
+
+struct ps3_system_bus_device {
+	enum ps3_match_id match_id;
+	struct ps3_device_id did;
+	unsigned int interrupt_id;
+/*	struct iommu_table *iommu_table; -- waiting for Ben's cleanups */
+	struct ps3_dma_region *d_region;
+	struct ps3_mmio_region *m_region;
+	struct device core;
+};
+
+/**
+ * struct ps3_system_bus_driver - a driver for a device on the system bus
+ */
+
+struct ps3_system_bus_driver {
+	enum ps3_match_id match_id;
+	struct device_driver core;
+	int (*probe)(struct ps3_system_bus_device *);
+	int (*remove)(struct ps3_system_bus_device *);
+/*	int (*suspend)(struct ps3_system_bus_device *, pm_message_t); */
+/*	int (*resume)(struct ps3_system_bus_device *); */
+};
+
+int ps3_system_bus_device_register(struct ps3_system_bus_device *dev);
+int ps3_system_bus_driver_register(struct ps3_system_bus_driver *drv);
+void ps3_system_bus_driver_unregister(struct ps3_system_bus_driver *drv);
+static inline struct ps3_system_bus_driver *to_ps3_system_bus_driver(
+	struct device_driver *_drv)
+{
+	return container_of(_drv, struct ps3_system_bus_driver, core);
+}
+static inline struct ps3_system_bus_device *to_ps3_system_bus_device(
+	struct device *_dev)
+{
+	return container_of(_dev, struct ps3_system_bus_device, core);
+}
+
+/**
+ * ps3_system_bus_set_drvdata -
+ * @dev: device structure
+ * @data: Data to set
+ */
+
+static inline void ps3_system_bus_set_driver_data(
+	struct ps3_system_bus_device *dev, void *data)
+{
+	dev->core.driver_data = data;
+}
+static inline void *ps3_system_bus_get_driver_data(
+	struct ps3_system_bus_device *dev)
+{
+	return dev->core.driver_data;
+}
+
+/* These two need global scope for get_dma_ops(). */
+
+extern struct bus_type ps3_system_bus_type;
+
 #endif
