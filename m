Return-Path: <geoffrey.levand@am.sony.com>
Received: from mgw3.sony.co.jp (MGW3.Sony.CO.JP [137.153.0.15])
	by ozlabs.org (Postfix) with ESMTP id 471BB67E66
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 07:02:31 +1100 (EST)
Received: from mail5.sony.co.jp (localhost [127.0.0.1])
	by mail5.sony.co.jp (R8/Sony) with ESMTP id kAAK2Psa013465
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 05:02:25 +0900 (JST)
Received: from mailgw01.scei.sony.co.jp (mailgw01.scei.sony.co.jp [43.27.73.7])
	by mail5.sony.co.jp (R8/Sony) with SMTP id kAAK2OdI013450
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 05:02:24 +0900 (JST)
Message-ID: <4554DACB.8060809@am.sony.com>
Date: Fri, 10 Nov 2006 12:02:19 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 7/16] powerpc: add support for ps3 platform
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

This adds the core platform support for the PS3 game console and other
platforms using the PS3 Platform hypervisor.


Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
 MAINTAINERS                             |    7 
 arch/powerpc/Kconfig                    |   11 
 arch/powerpc/platforms/Makefile         |    1 
 arch/powerpc/platforms/ps3pf/Kconfig    |   32 +
 arch/powerpc/platforms/ps3pf/Makefile   |    2 
 arch/powerpc/platforms/ps3pf/mm.c       |  872 ++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/ps3pf/platform.h |   59 ++
 arch/powerpc/platforms/ps3pf/setup.c    |  177 ++++++
 arch/powerpc/platforms/ps3pf/smp.c      |  164 ++++++
 arch/powerpc/platforms/ps3pf/time.c     |  105 +++
 include/asm-powerpc/ps3pf.h             |  240 ++++++++
 11 files changed, 1669 insertions(+), 1 deletion(-)

Index: cell--common--6/MAINTAINERS
===================================================================
--- cell--common--6.orig/MAINTAINERS
+++ cell--common--6/MAINTAINERS
@@ -2423,6 +2423,13 @@
 W:	http://www.pnd-pc.demon.co.uk/promise/
 S:	Maintained
 
+PS3PF (PS3 PLATFORM) SUPPORT
+P:	Geoff Levand
+M:	geoffrey.levand@am.sony.com
+L:	linuxppc-dev@ozlabs.org
+L:	cbe-oss-dev@ozlabs.org
+S:	Supported
+
 PVRUSB2 VIDEO4LINUX DRIVER
 P:	Mike Isely
 M:	isely@pobox.com
Index: cell--common--6/arch/powerpc/Kconfig
===================================================================
--- cell--common--6.orig/arch/powerpc/Kconfig
+++ cell--common--6/arch/powerpc/Kconfig
@@ -461,6 +461,14 @@
 	depends on PPC_RTAS
 	default n
 
+config PS3PF
+	bool "PS3 Platform"
+	depends on PPC_MULTIPLATFORM && PPC64
+	select PPC_CELL
+	help
+	  This option enables support for the PS3 game console
+	  and other platforms using the PS3 Platform hypervisor.
+
 config XICS
 	depends on PPC_PSERIES
 	bool
@@ -604,6 +612,7 @@
 source arch/powerpc/platforms/86xx/Kconfig
 source arch/powerpc/platforms/8xx/Kconfig
 source arch/powerpc/platforms/cell/Kconfig
+source arch/powerpc/platforms/ps3pf/Kconfig
 
 menu "Kernel options"
 
@@ -876,7 +885,7 @@
 	bool "PCI support" if 40x || CPM2 || PPC_83xx || PPC_85xx || PPC_86xx \
 		|| PPC_MPC52xx || (EMBEDDED && PPC_ISERIES) || MPC7448HPC2
 	default y if !40x && !CPM2 && !8xx && !APUS && !PPC_83xx \
-		&& !PPC_85xx && !PPC_86xx
+		&& !PPC_85xx && !PPC_86xx && !PS3PF
 	default PCI_PERMEDIA if !4xx && !CPM2 && !8xx && APUS
 	default PCI_QSPAN if !4xx && !CPM2 && 8xx
 	help
Index: cell--common--6/arch/powerpc/platforms/Makefile
===================================================================
--- cell--common--6.orig/arch/powerpc/platforms/Makefile
+++ cell--common--6/arch/powerpc/platforms/Makefile
@@ -15,4 +15,5 @@
 obj-$(CONFIG_PPC_MAPLE)		+= maple/
 obj-$(CONFIG_PPC_PASEMI)		+= pasemi/
 obj-$(CONFIG_PPC_CELL)		+= cell/
+obj-$(CONFIG_PS3PF)		+= ps3pf/
 obj-$(CONFIG_EMBEDDED6xx)	+= embedded6xx/
Index: cell--common--6/arch/powerpc/platforms/ps3pf/Kconfig
===================================================================
--- /dev/null
+++ cell--common--6/arch/powerpc/platforms/ps3pf/Kconfig
@@ -0,0 +1,32 @@
+menu "PS3 Platform Options"
+	depends on PS3PF
+
+config PS3PF_HTAB_SIZE
+	depends on PS3PF
+	int "PS3 Platform pagetable size"
+	range 18 20
+	default 20
+	help
+	  This option is only for experts who may have the desire to fine
+	  tune the pagetable size on their system.  The value here is
+	  expressed as the log2 of the page table size.  Valid values are
+	  18, 19, and 20, corresponding to 256KB, 512KB and 1MB respectively.
+
+	  If unsure, choose the default (20) with the confidence that your
+	  system will have optimal runtime performance.
+
+config PS3PF_DYNAMIC_DMA
+	depends on PS3PF && EXPERIMENTAL
+	bool "PS3 Platform dynamic DMA page table management"
+	default n
+	help
+	  This option will enable kernel support to take advantage of the
+	  per device dynamic DMA page table management provided by the Cell
+	  processor's IO Controller.  This support incurs some runtime
+	  overhead and also slightly increases kernel memory usage.  The
+	  current implementation should be considered experimental.
+
+	  This support is mainly for Linux kernel development.  If unsure,
+	  say N.
+
+endmenu
Index: cell--common--6/arch/powerpc/platforms/ps3pf/Makefile
===================================================================
--- /dev/null
+++ cell--common--6/arch/powerpc/platforms/ps3pf/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_PS3PF) += setup.o mm.o smp.o time.o hvcall.o htab.o repository.o
+obj-$(CONFIG_PS3PF) += interrupt.o exports.o
Index: cell--common--6/arch/powerpc/platforms/ps3pf/mm.c
===================================================================
--- /dev/null
+++ cell--common--6/arch/powerpc/platforms/ps3pf/mm.c
@@ -0,0 +1,872 @@
+/*
+ * mm.c - PS3 Platform address space management.
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
+#undef DEBUG
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/memory_hotplug.h>
+
+#include <asm/lmb.h>
+#include <asm/udbg.h>
+#include <asm/ps3pf.h>
+#include <asm/lv1call.h>
+
+#include "platform.h"
+
+#if defined(DEBUG)
+#undef pr_debug
+#define pr_debug(fmt...) udbg_printf(fmt)
+#endif
+
+enum {
+#if defined(CONFIG_PS3PF_USE_LPAR_ADDR)
+	USE_LPAR_ADDR = 1,
+#else
+	USE_LPAR_ADDR = 0,
+#endif
+#if defined(CONFIG_PS3PF_DYNAMIC_DMA)
+	USE_DYNAMIC_DMA = 1,
+#else
+	USE_DYNAMIC_DMA = 0,
+#endif
+};
+
+enum page_size {
+	page_size_4k = 12U,
+	page_size_64k = 16U,
+	page_size_16m = 24U,
+};
+
+enum allocate_memory {
+	/* bit 63: transferability */
+	LV1_AM_TF_NO = 0x00,
+	LV1_AM_TF_YES = 0x01,
+	/* bit 62: destruction scheme */
+	LV1_AM_DS_NO_CONNECTIONS = 0x00,
+	LV1_AM_DS_ANYTIME = 0x02,
+	/* bit 61: fail or alternative */
+	LV1_AM_FA_FAIL = 0x00,
+	LV1_AM_FA_ALTERNATIVE = 0x04,
+	/* bit 60: lpar address */
+	LV1_AM_ADDR_ANY = 0x00,
+	LV1_AM_ADDR_0 = 0x08,
+};
+
+static unsigned long make_page_sizes(enum page_size a, enum page_size b)
+{
+	return ((unsigned long)a << 56) | ((unsigned long)b << 48);
+}
+
+/* valid htab sizes are {18,19,20} = 256K, 512K, 1M */
+
+enum {
+	htab_size_max = 20U, /* HV limit of 1MB */
+	htab_size_min = 18U, /* CPU limit of 256KB */
+};
+
+/*============================================================================*/
+/* virtual address space routines                                             */
+/*============================================================================*/
+
+/**
+ * struct mem_region - memory region structure
+ * @base: base address
+ * @size: size in bytes
+ * @offset: difference between base and rm.size
+ */
+
+struct mem_region {
+	unsigned long base;
+	unsigned long size;
+	unsigned long offset;
+};
+
+/**
+ * struct map - address space state variables holder
+ * @total: total memory available as reported by HV
+ * @vas_id - HV virtual address space id
+ * @htab_size: htab size in bytes
+ *
+ * The HV virtual address space (vas) allows for hotplug memory regions.
+ * Memory regions can be created and destroyed in the vas at runtime.
+ * @rm: real mode (bootmem) region
+ * @r1: hotplug memory region(s)
+ *
+ * ps3pf addresses
+ * virt_addr: a cpu 'translated' effective address
+ * phys_addr: an address in what Linux thinks is the physical address space
+ * lpar_addr: an address in the HV virtual address space
+ * bus_addr: an io controller 'translated' address on a device bus
+ */
+
+struct map {
+	unsigned long total;
+	unsigned long vas_id;
+	unsigned long htab_size;
+	struct mem_region rm;
+	struct mem_region r1;
+};
+
+#define debug_dump_map(x) _debug_dump_map(x, __func__, __LINE__)
+static void _debug_dump_map(const struct map* m, const char* func, int line)
+{
+	pr_debug("%s:%d: map.total     = %lxh\n", func, line, m->total);
+	pr_debug("%s:%d: map.rm.size   = %lxh\n", func, line, m->rm.size);
+	pr_debug("%s:%d: map.vas_id    = %lu\n", func, line, m->vas_id);
+	pr_debug("%s:%d: map.htab_size = %lxh\n", func, line, m->htab_size);
+	pr_debug("%s:%d: map.r1.base   = %lxh\n", func, line, m->r1.base);
+	pr_debug("%s:%d: map.r1.offset = %lxh\n", func, line, m->r1.offset);
+	pr_debug("%s:%d: map.r1.size   = %lxh\n", func, line, m->r1.size);
+}
+
+static struct map map;
+
+/**
+ * ps3pf_mm_phys_to_lpar - translate a linux physical address to lpar address
+ * @phys_addr: linux physical address
+ */
+
+unsigned long ps3pf_mm_phys_to_lpar(unsigned long phys_addr)
+{
+	BUG_ON(is_kernel_addr(phys_addr));
+	if (USE_LPAR_ADDR)
+		return phys_addr;
+	else
+		return (phys_addr < map.rm.size || phys_addr >= map.total)
+			? phys_addr : phys_addr + map.r1.offset;
+}
+
+EXPORT_SYMBOL(ps3pf_mm_phys_to_lpar);
+
+/**
+ * ps3pf_mm_vas_create - create the virtual address space
+ */
+
+void __init ps3pf_mm_vas_create(unsigned long* htab_size)
+{
+	int result;
+	unsigned long start_address;
+	unsigned long size;
+	unsigned long access_right;
+	unsigned long max_page_size;
+	unsigned long flags;
+
+	result = lv1_query_logical_partition_address_region_info(0,
+		&start_address, &size, &access_right, &max_page_size,
+		&flags);
+
+	if (result) {
+		pr_debug("%s:%d: lv1_query_logical_partition_address_region_info "
+			"failed: %s\n", __func__, __LINE__,
+			ps3pf_result(result));
+		goto fail;
+	}
+
+	if (max_page_size < page_size_16m) {
+		pr_debug("%s:%d: bad max_page_size %lxh\n", __func__, __LINE__,
+			max_page_size);
+		goto fail;
+	}
+
+	BUILD_BUG_ON(CONFIG_PS3PF_HTAB_SIZE > htab_size_max);
+	BUILD_BUG_ON(CONFIG_PS3PF_HTAB_SIZE < htab_size_min);
+
+	result = lv1_construct_virtual_address_space(CONFIG_PS3PF_HTAB_SIZE,
+			2, make_page_sizes(page_size_16m, page_size_64k),
+			&map.vas_id, &map.htab_size);
+
+	if (result) {
+		pr_debug("%s:%d: lv1_construct_virtual_address_space failed: %s\n",
+			__func__, __LINE__, ps3pf_result(result));
+		goto fail;
+	}
+
+	result = lv1_select_virtual_address_space(map.vas_id);
+
+	if (result) {
+		pr_debug("%s:%d: lv1_select_virtual_address_space failed: %s\n",
+			__func__, __LINE__, ps3pf_result(result));
+		goto fail;
+	}
+
+	*htab_size = map.htab_size;
+
+	debug_dump_map(&map);
+
+	return;
+
+fail:
+	panic("ps3pf_mm_vas_create failed");
+}
+
+/**
+ * ps3pf_mm_vas_destroy -
+ */
+
+void ps3pf_mm_vas_destroy(void)
+{
+	if (map.vas_id) {
+		lv1_select_virtual_address_space(0);
+		lv1_destruct_virtual_address_space(map.vas_id);
+		map.vas_id = 0;
+	}
+}
+
+/*============================================================================*/
+/* memory hotplug routines                                                    */
+/*============================================================================*/
+
+/**
+ * ps3pf_mm_region_create - create a memory region in the vas
+ * @r: pointer to a struct mem_region to accept initialized values
+ * @size: requested region size
+ *
+ * This implementation creates the region with the vas large page size.
+ * @size is rounded down to a multiple of the vas large page size.
+ */
+
+int ps3pf_mm_region_create(struct mem_region *r, unsigned long size)
+{
+	int result;
+	unsigned long muid;
+
+	r->size = _ALIGN_DOWN(size, 1 << page_size_16m);
+
+	pr_debug("%s:%d requested  %lxh\n", __func__, __LINE__, size);
+	pr_debug("%s:%d actual     %lxh\n", __func__, __LINE__, r->size);
+	pr_debug("%s:%d difference %lxh (%luMB)\n", __func__, __LINE__,
+		(unsigned long)(size - r->size),
+		(size - r->size) / 1024 / 1024);
+
+	if (r->size == 0) {
+		pr_debug("%s:%d: size == 0\n", __func__, __LINE__);
+		result = -1;
+		goto zero_region;
+	}
+
+	result = lv1_allocate_memory(r->size, page_size_16m, 0,
+		LV1_AM_TF_NO | LV1_AM_DS_ANYTIME | LV1_AM_FA_ALTERNATIVE
+		| LV1_AM_ADDR_ANY, &r->base, &muid);
+
+	if (result || r->base < map.rm.size) {
+		pr_debug("%s:%d: lv1_allocate_memory failed: %s\n",
+			__func__, __LINE__, ps3pf_result(result));
+		goto zero_region;
+	}
+
+	r->offset = r->base - map.rm.size;
+	return result;
+
+zero_region:
+	r->size = r->base = r->offset = 0;
+	return result;
+}
+
+/**
+ * ps3pf_mm_region_destroy - destroy a memory region
+ * @r: pointer to struct mem_region
+ */
+
+void ps3pf_mm_region_destroy(struct mem_region *r)
+{
+	if (r->base) {
+		lv1_release_memory(r->base);
+		r->size = r->base = r->offset = 0;
+		map.total = map.rm.size;
+	}
+}
+
+/**
+ * ps3pf_mm_add_memory - hot add memory
+ * @r: pointer to dma region structure
+ * @lpar_addr: HV lpar address
+ */
+
+static int __init ps3pf_mm_add_memory(void)
+{
+	int result;
+	unsigned long start_addr;
+	unsigned long start_pfn;
+	unsigned long nr_pages;
+
+	BUG_ON(!mem_init_done);
+
+	start_addr = USE_LPAR_ADDR ? map.r1.base : map.rm.size;
+	start_pfn = start_addr >> PAGE_SHIFT;
+	nr_pages = (map.r1.size + PAGE_SIZE - 1) >> PAGE_SHIFT;
+
+	pr_debug("%s:%d: start_addr %lxh, start_pfn %lxh, nr_pages %lxh\n",
+		__func__, __LINE__, start_addr, start_pfn, nr_pages);
+
+	result = add_memory(0, start_addr, map.r1.size);
+
+	if (result) {
+		pr_debug("%s:%d: add_memory failed: (%d)\n",
+			__func__, __LINE__, result);
+		return result;
+	}
+
+	result = online_pages(start_pfn, nr_pages);
+
+	if (result)
+		pr_debug("%s:%d: online_pages failed: (%d)\n",
+			__func__, __LINE__, result);
+
+	return result;
+}
+
+core_initcall(ps3pf_mm_add_memory);
+
+/*============================================================================*/
+/* dma routines                                                               */
+/*============================================================================*/
+
+/**
+ * dma_lpar_to_bus - Translate an lpar address to ioc mapped bus address.
+ * @r: pointer to dma region structure
+ * @lpar_addr: HV lpar address
+ */
+
+static unsigned long dma_lpar_to_bus(struct ps3pf_dma_region *r,
+	unsigned long lpar_addr)
+{
+	BUG_ON(lpar_addr >= map.r1.base + map.r1.size);
+	return r->bus_addr + (lpar_addr <= map.rm.size ? lpar_addr
+		: lpar_addr - map.r1.offset);
+}
+
+#define dma_dump_region(_a) _dma_dump_region(_a, __func__, __LINE__)
+static void _dma_dump_region(const struct ps3pf_dma_region *r, const char* func,
+	int line)
+{
+	pr_debug("%s:%d: dev        %u:%u\n", func, line, r->did.bus_id,
+		r->did.dev_id);
+	pr_debug("%s:%d: page_size  %u\n", func, line, r->page_size);
+	pr_debug("%s:%d: bus_addr   %lxh\n", func, line, r->bus_addr);
+	pr_debug("%s:%d: len        %lxh\n", func, line, r->len);
+}
+
+/**
+ * dma_chunk - A chunk of dma pages mapped by the io controller.
+ * @region - The dma region that owns this chunk.
+ * @lpar_addr: Starting lpar address of the area to map.
+ * @bus_addr: Starting ioc bus address of the area to map.
+ * @len: Length in bytes of the area to map.
+ * @link: A struct list_head used with struct ps3pf_dma_region.chunk_list, the
+ * list of all chuncks owned by the region.
+ *
+ * This implementation uses a very simple dma page manager
+ * based on the dma_chunk structure.  This scheme assumes
+ * that all drivers use very well behaved dma ops.
+ */
+
+struct dma_chunk {
+	struct ps3pf_dma_region *region;
+	unsigned long lpar_addr;
+	unsigned long bus_addr;
+	unsigned long len;
+	struct list_head link;
+	unsigned int usage_count;
+};
+
+#define dma_dump_chunk(_a) _dma_dump_chunk(_a, __func__, __LINE__)
+static void _dma_dump_chunk (const struct dma_chunk* c, const char* func,
+	int line)
+{
+	pr_debug("%s:%d: r.dev        %u:%u\n", func, line,
+		c->region->did.bus_id, c->region->did.dev_id);
+	pr_debug("%s:%d: r.bus_addr   %lxh\n", func, line, c->region->bus_addr);
+	pr_debug("%s:%d: r.page_size  %u\n", func, line, c->region->page_size);
+	pr_debug("%s:%d: r.len        %lxh\n", func, line, c->region->len);
+	pr_debug("%s:%d: c.lpar_addr  %lxh\n", func, line, c->lpar_addr);
+	pr_debug("%s:%d: c.bus_addr   %lxh\n", func, line, c->bus_addr);
+	pr_debug("%s:%d: c.len        %lxh\n", func, line, c->len);
+}
+
+static struct dma_chunk * dma_find_chunk(struct ps3pf_dma_region *r,
+	unsigned long bus_addr, unsigned long len)
+{
+	struct dma_chunk *c;
+	unsigned long aligned_bus = _ALIGN_DOWN(bus_addr, 1 << r->page_size);
+	unsigned long aligned_len = _ALIGN_UP(len, 1 << r->page_size);
+
+	list_for_each_entry(c, &r->chunk_list.head, link) {
+		/* intersection */
+		if (aligned_bus >= c->bus_addr
+			&& aligned_bus < c->bus_addr + c->len
+			&& aligned_bus + aligned_len <= c->bus_addr + c->len) {
+			return c;
+		}
+		/* below */
+		if (aligned_bus + aligned_len <= c->bus_addr) {
+			continue;
+		}
+		/* above */
+		if (aligned_bus >= c->bus_addr + c->len) {
+			continue;
+		}
+
+		/* we don't handle the multi-chunk case for now */
+
+		dma_dump_chunk(c);
+		BUG();
+	}
+	return NULL;
+}
+
+static int dma_free_chunk(struct dma_chunk *c)
+{
+	int result = 0;
+
+	if (c->bus_addr) {
+		result = lv1_unmap_device_dma_region(c->region->did.bus_id,
+			c->region->did.dev_id, c->bus_addr, c->len);
+		BUG_ON(result);
+	}
+
+	kfree(c);
+	return result;
+}
+
+/**
+ * dma_map_pages - Maps dma pages into the io controller bus address space.
+ * @r: Pointer to a struct ps3pf_dma_region.
+ * @virt_addr: Starting virtual address of the area to map.
+ * @len: Length in bytes of the area to map.
+ * c_out: A pointer to receive an allocated struct dma_chunk for this area.
+ *
+ * This is the lowest level dma mapping routine, and is the one that will
+ * make the HV call to add the pages into the io controller address space.
+ */
+
+static int dma_map_pages(struct ps3pf_dma_region *r, unsigned long virt_addr,
+	unsigned long len, struct dma_chunk **c_out)
+{
+	int result;
+	unsigned long phys_addr;
+	struct dma_chunk *c;
+
+	phys_addr = is_kernel_addr(virt_addr) ? __pa(virt_addr) : virt_addr;
+
+	c = kzalloc(sizeof(struct dma_chunk), GFP_ATOMIC);
+
+	if (!c) {
+		result = -ENOMEM;
+		goto fail_alloc;
+	}
+
+	c->region = r;
+	c->lpar_addr = ps3pf_mm_phys_to_lpar(phys_addr);
+	c->bus_addr = dma_lpar_to_bus(r, c->lpar_addr);
+	c->len = len;
+
+	result = lv1_map_device_dma_region(c->region->did.bus_id,
+		c->region->did.dev_id, c->lpar_addr, c->bus_addr, c->len,
+		0xf800000000000000UL);
+
+	if (result) {
+		pr_debug("%s:%d: lv1_map_device_dma_region failed: %s\n",
+			__func__, __LINE__, ps3pf_result(result));
+		goto fail_map;
+	}
+
+	list_add(&c->link, &r->chunk_list.head);
+
+	*c_out = c;
+	return 0;
+
+fail_map:
+	kfree(c);
+fail_alloc:
+	*c_out = NULL;
+	pr_debug(" <- %s:%d\n", __func__, __LINE__);
+	return result;
+}
+
+/**
+ * dma_region_create - Create a device dma region.
+ * @r: Pointer to a struct ps3pf_dma_region.
+ *
+ * This is the lowest level dma region create routine, and is the one that
+ * will make the HV call to create the region.
+ */
+
+static int dma_region_create(struct ps3pf_dma_region* r)
+{
+	int result;
+
+	r->len = _ALIGN_UP(map.total, 1 << r->page_size);
+	INIT_LIST_HEAD(&r->chunk_list.head);
+	spin_lock_init(&r->chunk_list.lock);
+
+	result = lv1_allocate_device_dma_region(r->did.bus_id, r->did.dev_id,
+		r->len, r->page_size, r->region_type, &r->bus_addr);
+
+	dma_dump_region(r);
+
+	if (result) {
+		pr_debug("%s:%d: lv1_allocate_device_dma_region failed: %s\n",
+			__func__, __LINE__, ps3pf_result(result));
+		r->len = r->bus_addr = 0;
+	}
+
+	return result;
+}
+
+/**
+ * dma_region_free - Free a device dma region.
+ * @r: Pointer to a struct ps3pf_dma_region.
+ *
+ * This is the lowest level dma region free routine, and is the one that
+ * will make the HV call to free the region.
+ */
+
+static int dma_region_free(struct ps3pf_dma_region* r)
+{
+	int result;
+	struct dma_chunk *c;
+	struct dma_chunk *tmp;
+
+	list_for_each_entry_safe(c, tmp, &r->chunk_list.head, link) {
+		list_del(&c->link);
+		dma_free_chunk(c);
+	}
+
+	result = lv1_free_device_dma_region(r->did.bus_id, r->did.dev_id,
+		r->bus_addr);
+
+	if (result)
+		pr_debug("%s:%d: lv1_free_device_dma_region failed: %s\n",
+			__func__, __LINE__, ps3pf_result(result));
+
+	r->len = r->bus_addr = 0;
+
+	return result;
+}
+
+/**
+ * dma_map_area - Map an area of memory into a device dma region.
+ * @r: Pointer to a struct ps3pf_dma_region.
+ * @virt_addr: Starting virtual address of the area to map.
+ * @len: Length in bytes of the area to map.
+ * @bus_addr: A pointer to return the starting ioc bus address of the area to
+ * map.
+ *
+ * This is the common dma mapping routine.
+ */
+
+static int dma_map_area(struct ps3pf_dma_region *r, unsigned long virt_addr,
+	unsigned long len, unsigned long *bus_addr)
+{
+	int result;
+	unsigned long flags;
+	struct dma_chunk *c;
+	unsigned long phys_addr = is_kernel_addr(virt_addr) ? __pa(virt_addr)
+		: virt_addr;
+
+	*bus_addr = dma_lpar_to_bus(r, ps3pf_mm_phys_to_lpar(phys_addr));
+
+	if (!USE_DYNAMIC_DMA) {
+		unsigned long lpar_addr = ps3pf_mm_phys_to_lpar(phys_addr);
+		pr_debug(" -> %s:%d\n", __func__, __LINE__);
+		pr_debug("%s:%d virt_addr %lxh\n", __func__, __LINE__,
+			virt_addr);
+		pr_debug("%s:%d phys_addr %lxh\n", __func__, __LINE__,
+			phys_addr);
+		pr_debug("%s:%d lpar_addr %lxh\n", __func__, __LINE__,
+			lpar_addr);
+		pr_debug("%s:%d len       %lxh\n", __func__, __LINE__, len);
+		pr_debug("%s:%d bus_addr  %lxh (%lxh)\n", __func__, __LINE__,
+		*bus_addr, len);
+	}
+
+	spin_lock_irqsave(&r->chunk_list.lock, flags);
+	c = dma_find_chunk(r, *bus_addr, len);
+
+	if (c) {
+		c->usage_count++;
+		spin_unlock_irqrestore(&r->chunk_list.lock, flags);
+		return 0;
+	}
+
+	result = dma_map_pages(r, _ALIGN_DOWN(virt_addr, 1 << r->page_size),
+		_ALIGN_UP(len, 1 << r->page_size), &c);
+
+	if (result) {
+		*bus_addr = 0;
+		pr_debug("%s:%d: dma_map_pages failed (%d)\n",
+			__func__, __LINE__, result);
+		spin_unlock_irqrestore(&r->chunk_list.lock, flags);
+		return result;
+	}
+
+	c->usage_count = 1;
+
+	spin_unlock_irqrestore(&r->chunk_list.lock, flags);
+	return result;
+}
+
+/**
+ * dma_unmap_area - Unmap an area of memory from a device dma region.
+ * @r: Pointer to a struct ps3pf_dma_region.
+ * @bus_addr: The starting ioc bus address of the area to unmap.
+ * @len: Length in bytes of the area to unmap.
+ *
+ * This is the common dma unmap routine.
+ */
+
+int dma_unmap_area(struct ps3pf_dma_region *r, unsigned long bus_addr,
+	unsigned long len)
+{
+	unsigned long flags;
+	struct dma_chunk *c;
+
+	spin_lock_irqsave(&r->chunk_list.lock, flags);
+	c = dma_find_chunk(r, bus_addr, len);
+
+	if (!c) {
+		unsigned long aligned_bus = _ALIGN_DOWN(bus_addr,
+			1 << r->page_size);
+		unsigned long aligned_len = _ALIGN_UP(len, 1 << r->page_size);
+		pr_debug("%s:%d: not found: bus_addr %lxh\n",
+			__func__, __LINE__, bus_addr);
+		pr_debug("%s:%d: not found: len %lxh\n",
+			__func__, __LINE__, len);
+		pr_debug("%s:%d: not found: aligned_bus %lxh\n",
+			__func__, __LINE__, aligned_bus);
+		pr_debug("%s:%d: not found: aligned_len %lxh\n",
+			__func__, __LINE__, aligned_len);
+		BUG();
+	}
+
+	c->usage_count--;
+
+	if (!c->usage_count) {
+		list_del(&c->link);
+		dma_free_chunk(c);
+	}
+
+	spin_unlock_irqrestore(&r->chunk_list.lock, flags);
+	return 0;
+}
+
+/**
+ * dma_region_create_linear - Setup a linear dma maping for a device.
+ * @r: Pointer to a struct ps3pf_dma_region.
+ *
+ * This routine creates an HV dma region for the device and maps all available
+ * ram into the io controller bus address space.
+ */
+
+static int dma_region_create_linear(struct ps3pf_dma_region *r)
+{
+	int result;
+	unsigned long tmp;
+
+	/* force 16M dma pages for linear mapping */
+
+	if (r->page_size != ps3pf_dma_16m) {
+		pr_info("%s:%d: forcing 16M pages for linear map\n",
+			__func__, __LINE__);
+		r->page_size = ps3pf_dma_16m;
+	}
+
+	result = dma_region_create(r);
+
+	if (result) {
+		pr_debug("%s:%d: ps3pf_dma_region_create failed\n",
+			__func__, __LINE__);
+		BUG();
+	}
+
+	result = dma_map_area(r, map.rm.base, map.rm.size, &tmp);
+
+	if (result) {
+		pr_debug("%s:%d: ps3pf_dma_map_pages failed\n",
+			__func__, __LINE__);
+		BUG();
+	}
+
+	if (USE_LPAR_ADDR)
+		result = dma_map_area(r, map.r1.base, map.r1.size,
+			&tmp);
+	else
+		result = dma_map_area(r, map.rm.size, map.r1.size,
+			&tmp);
+
+	if (result) {
+		pr_debug("%s:%d: ps3pf_dma_map_pages failed\n",
+			__func__, __LINE__);
+		BUG();
+	}
+
+	return result;
+}
+
+/**
+ * dma_region_free_linear - Free a linear dma mapping for a device.
+ * @r: Pointer to a struct ps3pf_dma_region.
+ *
+ * This routine will unmap all mapped areas and free the HV dma region.
+ */
+
+static int dma_region_free_linear(struct ps3pf_dma_region *r)
+{
+	int result;
+
+	result = dma_unmap_area(r, dma_lpar_to_bus(r, 0), map.rm.size);
+
+	if (result) {
+		pr_debug("%s:%d: ps3pf_dma_unmap_pages failed\n",
+			__func__, __LINE__);
+		BUG();
+	}
+
+	result = dma_unmap_area(r, dma_lpar_to_bus(r, map.r1.base),
+		map.r1.size);
+
+	if (result) {
+		pr_debug("%s:%d: ps3pf_dma_unmap_pages failed\n",
+			__func__, __LINE__);
+		BUG();
+	}
+
+	result = dma_region_free(r);
+
+	if (result) {
+		pr_debug("%s:%d: ps3pf_dma_region_free failed\n",
+			__func__, __LINE__);
+		BUG();
+	}
+	return result;
+}
+
+/**
+ * dma_map_area_linear - Map an area of memory into a device dma region.
+ * @r: Pointer to a struct ps3pf_dma_region.
+ * @virt_addr: Starting virtual address of the area to map.
+ * @len: Length in bytes of the area to map.
+ * @bus_addr: A pointer to return the starting ioc bus address of the area to
+ * map.
+ *
+ * This routine just returns the coresponding bus address.  Actual mapping
+ * occurs in dma_region_create_linear().
+ */
+
+static int dma_map_area_linear(struct ps3pf_dma_region *r,
+	unsigned long virt_addr, unsigned long len, unsigned long *bus_addr)
+{
+	unsigned long phys_addr = is_kernel_addr(virt_addr) ? __pa(virt_addr)
+		: virt_addr;
+	*bus_addr = dma_lpar_to_bus(r, ps3pf_mm_phys_to_lpar(phys_addr));
+	return 0;
+}
+
+/**
+ * dma_unmap_area_linear - Unmap an area of memory from a device dma region.
+ * @r: Pointer to a struct ps3pf_dma_region.
+ * @bus_addr: The starting ioc bus address of the area to unmap.
+ * @len: Length in bytes of the area to unmap.
+ *
+ * This routine does nothing.  Unmapping occurs in dma_region_free_linear().
+ */
+
+static int dma_unmap_area_linear(struct ps3pf_dma_region *r,
+	unsigned long bus_addr, unsigned long len)
+{
+	return 0;
+}
+
+int ps3pf_dma_region_create(struct ps3pf_dma_region *r)
+{
+	return (USE_DYNAMIC_DMA)
+		? dma_region_create(r)
+		: dma_region_create_linear(r);
+}
+
+int ps3pf_dma_region_free(struct ps3pf_dma_region *r)
+{
+	return (USE_DYNAMIC_DMA)
+		? dma_region_free(r)
+		: dma_region_free_linear(r);
+}
+
+int ps3pf_dma_map(struct ps3pf_dma_region *r, unsigned long virt_addr,
+	unsigned long len, unsigned long *bus_addr)
+{
+	return (USE_DYNAMIC_DMA)
+		? dma_map_area(r, virt_addr, len, bus_addr)
+		: dma_map_area_linear(r, virt_addr, len, bus_addr);
+}
+
+int ps3pf_dma_unmap(struct ps3pf_dma_region *r, unsigned long bus_addr,
+	unsigned long len)
+{
+	return (USE_DYNAMIC_DMA) ? dma_unmap_area(r, bus_addr, len)
+		: dma_unmap_area_linear(r, bus_addr, len);
+}
+
+/*============================================================================*/
+/* system startup routines                                                    */
+/*============================================================================*/
+
+/**
+ * ps3pf_mm_init - initialize the address space state variables
+ */
+
+void __init ps3pf_mm_init(void)
+{
+	int result;
+
+	pr_debug(" -> %s:%d\n", __func__, __LINE__);
+
+	result = ps3pf_repository_read_mm_info(&map.rm.base, &map.rm.size,
+		&map.total);
+
+	if (result)
+		panic("ps3pf_repository_read_mm_info() failed");
+
+	map.rm.offset = map.rm.base;
+	map.vas_id = map.htab_size = 0;
+
+	/* this implementation assumes map.rm.base is zero */
+
+	BUG_ON(map.rm.base);
+	BUG_ON(!map.rm.size);
+
+	lmb_add(map.rm.base, map.rm.size);
+	lmb_analyze();
+
+	// arrange to do this in ps3pf_mm_add_memory!!!
+	ps3pf_mm_region_create(&map.r1, map.total - map.rm.size);
+
+	pr_debug(" <- %s:%d\n", __func__, __LINE__);
+}
+
+/**
+ * ps3pf_mm_shutdown - final cleanup of address space
+ */
+
+void ps3pf_mm_shutdown(void)
+{
+	ps3pf_mm_region_destroy(&map.r1);
+	map.total = map.rm.size;
+}
Index: cell--common--6/arch/powerpc/platforms/ps3pf/platform.h
===================================================================
--- /dev/null
+++ cell--common--6/arch/powerpc/platforms/ps3pf/platform.h
@@ -0,0 +1,59 @@
+/*
+ * platform.h - PS3 Platform declarations.
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
+#if !defined(_510B7842_EE09_4B12_BE5C_D217383D50C7)
+#define _510B7842_EE09_4B12_BE5C_D217383D50C7
+
+#include <linux/rtc.h>
+
+/* htab */
+
+void __init ps3pf_hpte_init(unsigned long htab_size);
+void __init ps3pf_map_htab(void);
+
+/* mm */
+
+void __init ps3pf_mm_init(void);
+void __init ps3pf_mm_vas_create(unsigned long* htab_size);
+void ps3pf_mm_shutdown(void);
+
+/* irq */
+
+void ps3pf_init_IRQ(void);
+void __init ps3pf_register_ipi_debug_brk(unsigned int cpu, unsigned int virq);
+
+/* smp */
+
+void smp_init_ps3pf(void);
+void ps3pf_smp_cleanup_cpu(int cpu);
+
+/* time */
+
+void __init ps3pf_calibrate_decr(void);
+unsigned long __init ps3pf_get_boot_time(void);
+void ps3pf_get_rtc_time(struct rtc_time *time);
+int ps3pf_set_rtc_time(struct rtc_time *time);
+
+/* os area */
+
+int __init ps3pf_os_area_init(void);
+u64 ps3pf_os_area_rtc_diff(void);
+
+#endif
Index: cell--common--6/arch/powerpc/platforms/ps3pf/setup.c
===================================================================
--- /dev/null
+++ cell--common--6/arch/powerpc/platforms/ps3pf/setup.c
@@ -0,0 +1,177 @@
+/*
+ * setup.c - PS3 Platform setup routines.
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
+#undef DEBUG
+
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/fs.h>
+#include <linux/root_dev.h>
+#include <linux/console.h>
+#include <linux/kexec.h>
+
+#include <asm/machdep.h>
+#include <asm/firmware.h>
+#include <asm/time.h>
+#include <asm/iommu.h>
+#include <asm/udbg.h>
+#include <asm/lv1call.h>
+
+#include "platform.h"
+
+#if defined(DEBUG)
+#undef pr_debug
+#define pr_debug(fmt...) udbg_printf(fmt)
+#endif
+
+static void ps3pf_show_cpuinfo(struct seq_file *m)
+{
+	seq_printf(m, "machine\t\t: %s\n", ppc_md.name);
+}
+
+static void ps3pf_power_save(void)
+{
+	/*
+	 * lv1_pause() puts the PPE thread into inactive state until an
+	 * irq on an unmasked plug exists. MSR[EE] has no effect.
+	 * flags: 0 = wake on DEC interrupt, 1 = ignore DEC interrupt.
+	 */
+
+	lv1_pause(0);
+}
+
+static void ps3pf_panic(char *str)
+{
+	pr_debug("%s:%d %s\n", __func__, __LINE__, str);
+
+#ifdef CONFIG_SMP
+	smp_send_stop();
+#endif
+	printk("\n");
+	printk("   System does not reboot automatically.\n");
+	printk("   Please press POWER button.\n");
+	printk("\n");
+
+	for (;;) ;
+}
+
+static void __init ps3pf_setup_arch(void)
+{
+	pr_debug(" -> %s:%d\n", __func__, __LINE__);
+
+	ps3pf_map_htab();
+
+#if defined(CONFIG_BLK_DEV_INITRD)
+ 	if (initrd_start)
+ 		ROOT_DEV = Root_RAM0;
+ 	else
+#endif
+#if defined(CONFIG_ROOT_NFS)
+		ROOT_DEV = Root_NFS;
+#else
+ 		ROOT_DEV = Root_HDA1;
+#endif
+
+#ifdef CONFIG_SMP
+	smp_init_ps3pf();
+#endif
+
+#ifdef CONFIG_DUMMY_CONSOLE
+	conswitchp = &dummy_con;
+#endif
+
+	ppc_md.power_save = ps3pf_power_save;
+
+	pr_debug(" <- %s:%d\n", __func__, __LINE__);
+}
+
+static void __init ps3pf_progress(char *s, unsigned short hex)
+{
+	printk("*** %04x : %s\n", hex, s ? s : "");
+}
+
+static int __init ps3pf_probe(void)
+{
+	unsigned long htab_size;
+
+	pr_debug(" -> %s:%d\n", __func__, __LINE__);
+
+	powerpc_firmware_features |= FW_FEATURE_LPAR;
+
+	ps3pf_mm_init();
+	ps3pf_mm_vas_create(&htab_size);
+	ps3pf_hpte_init(htab_size);
+
+	pr_debug(" <- %s:%d\n", __func__, __LINE__);
+	return 1;
+}
+
+#if defined(CONFIG_KEXEC)
+static void ps3pf_kexec_cpu_down(int crash_shutdown, int secondary)
+{
+	pr_debug(" -> %s:%d\n", __func__, __LINE__);
+
+	if (secondary) {
+		int cpu;
+		for_each_online_cpu(cpu)
+			if (cpu)
+				ps3pf_smp_cleanup_cpu(cpu);
+	} else
+		ps3pf_smp_cleanup_cpu(0);
+
+	pr_debug(" <- %s:%d\n", __func__, __LINE__);
+}
+
+static void ps3pf_machine_kexec(struct kimage *image)
+{
+	unsigned long ppe_id;
+
+	pr_debug(" -> %s:%d\n", __func__, __LINE__);
+
+	lv1_get_logical_ppe_id(&ppe_id);
+	lv1_configure_irq_state_bitmap(ppe_id, 0, 0);
+	ps3pf_mm_shutdown();
+	ps3pf_mm_vas_destroy();
+
+	default_machine_kexec(image);
+
+	pr_debug(" <- %s:%d\n", __func__, __LINE__);
+}
+#endif
+
+define_machine(ps3pf) {
+	.name				= "PS3PF",
+	.probe				= ps3pf_probe,
+	.setup_arch			= ps3pf_setup_arch,
+	.show_cpuinfo			= ps3pf_show_cpuinfo,
+	.init_IRQ			= ps3pf_init_IRQ,
+	.panic				= ps3pf_panic,
+	.get_boot_time			= ps3pf_get_boot_time,
+	.set_rtc_time			= ps3pf_set_rtc_time,
+	.get_rtc_time			= ps3pf_get_rtc_time,
+	.calibrate_decr			= ps3pf_calibrate_decr,
+	.progress			= ps3pf_progress,
+#if defined(CONFIG_KEXEC)
+	.kexec_cpu_down			= ps3pf_kexec_cpu_down,
+	.machine_kexec			= ps3pf_machine_kexec,
+	.machine_kexec_prepare		= ps3pf_machine_kexec_prepare,
+	.machine_crash_shutdown		= default_machine_crash_shutdown,
+#endif
+};
Index: cell--common--6/arch/powerpc/platforms/ps3pf/smp.c
===================================================================
--- /dev/null
+++ cell--common--6/arch/powerpc/platforms/ps3pf/smp.c
@@ -0,0 +1,164 @@
+/*
+ * smp.c - PS3 Platform SMP routines.
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
+#undef DEBUG
+
+#include <linux/kernel.h>
+#include <linux/smp.h>
+
+#include <asm/machdep.h>
+#include <asm/udbg.h>
+#include <asm/ps3pf.h>
+
+#include "platform.h"
+
+#if defined(DEBUG)
+#undef pr_debug
+#define pr_debug(fmt...) udbg_printf(fmt)
+#endif
+
+#if !defined(PPC_MSG_MIGRATE_TASK)
+static const int PPC_MSG_MIGRATE_TASK = 2;
+#endif
+
+static irqreturn_t ipi_function_handler(int irq, void *msg)
+{
+	smp_message_recv((int)(long)msg);
+	return IRQ_HANDLED;
+}
+
+/**
+  * virqs - a per cpu array of virqs for ipi use
+  */
+
+#define MSG_COUNT 4
+static DEFINE_PER_CPU(unsigned int, virqs[MSG_COUNT]);
+
+static const char *names[MSG_COUNT] = {
+	"ipi call",
+	"ipi reschedule",
+	"ipi migrate",
+	"ipi debug brk"
+};
+
+static void do_message_pass(int target, int msg)
+{
+	int result;
+	unsigned int virq;
+
+	if (msg >= MSG_COUNT) {
+		pr_debug("%s:%d: bad msg: %d\n", __func__, __LINE__, msg);
+		return;
+	}
+
+	virq = per_cpu(virqs, target)[msg];
+	result = ps3pf_send_event_locally(virq);
+
+	if (result)
+		pr_debug("%s:%d: ps3pf_send_event_locally(%d, %d) failed"
+			" (%d)\n", __func__, __LINE__, target, msg, result);
+}
+
+static void ps3pf_smp_message_pass(int target, int msg)
+{
+	int cpu;
+
+	if (target < NR_CPUS)
+		do_message_pass(target, msg);
+	else if (target == MSG_ALL_BUT_SELF) {
+		for_each_online_cpu(cpu)
+			if (cpu != smp_processor_id())
+				do_message_pass(cpu, msg);
+	} else {
+		for_each_online_cpu(cpu)
+			do_message_pass(cpu, msg);
+	}
+}
+
+static int ps3pf_smp_probe(void)
+{
+	return 2;
+}
+
+static void __init ps3pf_smp_setup_cpu(int cpu)
+{
+	int result;
+	unsigned int *virqs = per_cpu(virqs, cpu);
+	int i;
+
+	pr_debug(" -> %s:%d: (%d)\n", __func__, __LINE__, cpu);
+
+	/*
+	 * Check assumptions on virqs[] indexing. If this
+	 * check fails, then a different mapping of PPC_MSG_
+	 * to index needs to be setup.
+	 */
+
+	BUILD_BUG_ON(PPC_MSG_CALL_FUNCTION  != 0);
+	BUILD_BUG_ON(PPC_MSG_RESCHEDULE     != 1);
+	BUILD_BUG_ON(PPC_MSG_MIGRATE_TASK   != 2);
+	BUILD_BUG_ON(PPC_MSG_DEBUGGER_BREAK != 3);
+
+	for (i = 0; i < MSG_COUNT; i++) {
+		result = ps3pf_alloc_event_irq(&virqs[i]);
+
+		if (result)
+			continue;
+
+		pr_debug("%s:%d: (%d, %d) => virq %u\n",
+			__func__, __LINE__, cpu, i, virqs[i]);
+
+
+		request_irq(virqs[i], ipi_function_handler, IRQF_DISABLED,
+			names[i], (void*)(long)i);
+	}
+
+	ps3pf_register_ipi_debug_brk(cpu, virqs[PPC_MSG_DEBUGGER_BREAK]);
+
+	pr_debug(" <- %s:%d: (%d)\n", __func__, __LINE__, cpu);
+}
+
+void ps3pf_smp_cleanup_cpu(int cpu)
+{
+	unsigned int *virqs = per_cpu(virqs, cpu);
+	int i;
+
+	pr_debug(" -> %s:%d: (%d)\n", __func__, __LINE__, cpu);
+	for (i = 0; i < MSG_COUNT; i++) {
+		ps3pf_free_event_irq(virqs[i]);
+		free_irq(virqs[i], (void*)(long)i);
+		virqs[i] = NO_IRQ;
+	}
+	pr_debug(" <- %s:%d: (%d)\n", __func__, __LINE__, cpu);
+}
+
+static struct smp_ops_t ps3pf_smp_ops = {
+	.probe		= ps3pf_smp_probe,
+	.message_pass	= ps3pf_smp_message_pass,
+	.kick_cpu	= smp_generic_kick_cpu,
+	.setup_cpu	= ps3pf_smp_setup_cpu,
+};
+
+void smp_init_ps3pf(void)
+{
+	pr_debug(" -> %s\n", __func__);
+	smp_ops = &ps3pf_smp_ops;
+	pr_debug(" <- %s\n", __func__);
+}
Index: cell--common--6/arch/powerpc/platforms/ps3pf/time.c
===================================================================
--- /dev/null
+++ cell--common--6/arch/powerpc/platforms/ps3pf/time.c
@@ -0,0 +1,105 @@
+/*
+ * time.c - PS3 Platform time and rtc routines.
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
+#undef DEBUG
+
+#include <linux/kernel.h>
+
+#include <asm/rtc.h>
+#include <asm/lv1call.h>
+#include <asm/ps3pf.h>
+
+#include "platform.h"
+
+#define dump_tm(_a) _dump_tm(_a, __func__, __LINE__)
+static void _dump_tm(const struct rtc_time *tm, const char* func, int line)
+{
+	pr_debug("%s:%d tm_sec  %d\n", func, line, tm->tm_sec);
+	pr_debug("%s:%d tm_min  %d\n", func, line, tm->tm_min);
+	pr_debug("%s:%d tm_hour %d\n", func, line, tm->tm_hour);
+	pr_debug("%s:%d tm_mday %d\n", func, line, tm->tm_mday);
+	pr_debug("%s:%d tm_mon  %d\n", func, line, tm->tm_mon);
+	pr_debug("%s:%d tm_year %d\n", func, line, tm->tm_year);
+	pr_debug("%s:%d tm_wday %d\n", func, line, tm->tm_wday);
+}
+
+#define dump_time(_a) _dump_time(_a, __func__, __LINE__)
+static void _dump_time(int time, const char* func, int line)
+{
+	struct rtc_time tm;
+
+	to_tm(time, &tm);
+
+	pr_debug("%s:%d time    %d\n", func, line, time);
+	_dump_tm(&tm, func, line);
+}
+
+/**
+ * rtc_shift - Difference in seconds between 1970 and the ps3pf rtc value.
+ */
+
+static s64 rtc_shift;
+
+void __init ps3pf_calibrate_decr(void)
+{
+	int result;
+	u64 tmp;
+
+	result = ps3pf_repository_read_be_tb_freq(0, &tmp);
+	BUG_ON(result);
+
+	ppc_tb_freq = tmp;
+	ppc_proc_freq = ppc_tb_freq * 40;
+
+	rtc_shift = ps3pf_os_area_rtc_diff();
+}
+
+static u64 read_rtc(void)
+{
+	int result;
+	u64 rtc_val;
+	u64 tb_val;
+
+	result = lv1_get_rtc(&rtc_val, &tb_val);
+	BUG_ON(result);
+
+	return rtc_val;
+}
+
+int ps3pf_set_rtc_time(struct rtc_time *tm)
+{
+	u64 now = mktime(tm->tm_year + 1900, tm->tm_mon + 1, tm->tm_mday,
+		tm->tm_hour, tm->tm_min, tm->tm_sec);
+
+	rtc_shift = now - read_rtc();
+	return 0;
+}
+
+void ps3pf_get_rtc_time(struct rtc_time *tm)
+{
+	to_tm(read_rtc() + rtc_shift, tm);
+	tm->tm_year -= 1900;
+	tm->tm_mon -= 1;
+}
+
+unsigned long __init ps3pf_get_boot_time(void)
+{
+	return read_rtc() + rtc_shift;
+}
Index: cell--common--6/include/asm-powerpc/ps3pf.h
===================================================================
--- /dev/null
+++ cell--common--6/include/asm-powerpc/ps3pf.h
@@ -0,0 +1,240 @@
+/*
+ * ps3fp.h - PS3 Platform declarations
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
+#if !defined(_A380E61A_0F69_48BF_A5DA_8FDC3BE8F31F)
+#define _A380E61A_0F69_48BF_A5DA_8FDC3BE8F31F
+
+#include <linux/compiler.h> /* for __deprecated */
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/device.h>
+
+/**
+ * struct ps3pf_device_id - HV bus device identifier from the system repository
+ * @bus_id: HV bus id, {1..} (zero invalid)
+ * @dev_id: HV device id, {0..}
+ */
+
+struct ps3pf_device_id {
+	unsigned int bus_id;
+	unsigned int dev_id;
+};
+
+
+/* dma routines */
+
+enum ps3pf_dma_page_size {ps3pf_dma_4k = 12U, ps3pf_dma_64k = 16U,
+	ps3pf_dma_1m = 20U, ps3pf_dma_16m = 24U};
+enum ps3pf_dma_region_type {ps3pf_dma_other = 0, ps3pf_dma_internal = 2};
+
+/**
+ * struct ps3pf_dma_region - A per device dma state variables structure
+ * @did: The HV device id.
+ * @page_size: The ioc pagesize.
+ * @region_type: The HV region type.
+ * @bus_addr: The 'translated' bus address of the region.
+ * @len: The length in bytes of the region.
+ * @chunk_list: Opaque variable used by the ioc page manager.
+ */
+
+struct ps3pf_dma_region {
+	struct ps3pf_device_id did;
+	enum ps3pf_dma_page_size page_size;
+	enum ps3pf_dma_region_type region_type;
+	unsigned long bus_addr;
+	unsigned long len;
+	struct {
+		spinlock_t lock;
+		struct list_head head;
+	} chunk_list;
+};
+
+/**
+ * struct ps3pf_dma_region_init - Helper to initialize structure variables
+ *
+ * Helper to properly initialize variables prior to calling
+ * ps3pf_system_bus_device_register.
+ */
+
+static inline void ps3pf_dma_region_init(struct ps3pf_dma_region *r,
+	const struct ps3pf_device_id* did, enum ps3pf_dma_page_size page_size,
+	enum ps3pf_dma_region_type region_type)
+{
+	r->did = *did;
+	r->page_size = page_size;
+	r->region_type = region_type;
+}
+int ps3pf_dma_region_create(struct ps3pf_dma_region *r);
+int ps3pf_dma_region_free(struct ps3pf_dma_region *r);
+int ps3pf_dma_map(struct ps3pf_dma_region *r, unsigned long virt_addr,
+	unsigned long len, unsigned long *bus_addr);
+int ps3pf_dma_unmap(struct ps3pf_dma_region *r, unsigned long bus_addr,
+	unsigned long len);
+
+/* mmio routines */
+
+enum ps3pf_mmio_page_size {ps3pf_mmio_4k = 12U, ps3pf_mmio_64k = 16U};
+
+/**
+ * struct ps3pf_mmio_region - a per device mmio state variables structure
+ *
+ * Current systems can be supported with a single region per device.
+ */
+
+struct ps3pf_mmio_region {
+	struct ps3pf_device_id did;
+	unsigned long bus_addr;
+	unsigned long len;
+	enum ps3pf_mmio_page_size page_size;
+	unsigned long lpar_addr;
+};
+
+/**
+ * struct ps3pf_mmio_region_init - Helper to initialize structure variables
+ *
+ * Helper to properly initialize variables prior to calling
+ * ps3pf_system_bus_device_register.
+ */
+
+static inline void ps3pf_mmio_region_init(struct ps3pf_mmio_region *r,
+	const struct ps3pf_device_id* did, unsigned long bus_addr,
+	unsigned long len, enum ps3pf_mmio_page_size page_size)
+{
+	r->did = *did;
+	r->bus_addr = bus_addr;
+	r->len = len;
+	r->page_size = page_size;
+}
+int ps3pf_mmio_region_create(struct ps3pf_mmio_region *r);
+int ps3pf_free_mmio_region(struct ps3pf_mmio_region *r);
+unsigned long ps3pf_mm_phys_to_lpar(unsigned long phys_addr);
+
+/* inrerrupt routines */
+
+int ps3pf_alloc_io_irq(unsigned int interrupt_id, unsigned int *virq);
+int ps3pf_free_io_irq(unsigned int virq);
+int ps3pf_alloc_event_irq(unsigned int *virq);
+int ps3pf_free_event_irq(unsigned int virq);
+int ps3pf_send_event_locally(unsigned int virq);
+int ps3pf_connect_event_irq(const struct ps3pf_device_id *did,
+	unsigned int interrupt_id, unsigned int *virq);
+int ps3pf_disconnect_event_irq(const struct ps3pf_device_id *did,
+	unsigned int interrupt_id, unsigned int virq);
+int ps3pf_alloc_vuart_irq(void* virt_addr_bmp, unsigned int *virq);
+int ps3pf_free_vuart_irq(unsigned int virq);
+int ps3pf_alloc_spe_irq(unsigned long spe_id, unsigned int class,
+	unsigned int *virq);
+int ps3pf_free_spe_irq(unsigned int virq);
+unsigned long __deprecated ps3pf_legacy_virq_to_outlet(unsigned int virq);
+
+/* lv1 result codes */
+
+enum lv1_result {
+	LV1_SUCCESS                     = 0,
+	/* not used                       -1 */
+	LV1_RESOURCE_SHORTAGE           = -2,
+	LV1_NO_PRIVILEGE                = -3,
+	LV1_DENIED_BY_POLICY            = -4,
+	LV1_ACCESS_VIOLATION            = -5,
+	LV1_NO_ENTRY                    = -6,
+	LV1_DUPLICATE_ENTRY             = -7,
+	LV1_TYPE_MISMATCH               = -8,
+	LV1_BUSY                        = -9,
+	LV1_EMPTY                       = -10,
+	LV1_WRONG_STATE                 = -11,
+	/* not used                       -12 */
+	LV1_NO_MATCH                    = -13,
+	LV1_ALREADY_CONNECTED           = -14,
+	LV1_UNSUPPORTED_PARAMETER_VALUE = -15,
+	LV1_CONDITION_NOT_SATISFIED     = -16,
+	LV1_ILLEGAL_PARAMETER_VALUE     = -17,
+	LV1_BAD_OPTION                  = -18,
+	LV1_IMPLEMENTATION_LIMITATION   = -19,
+	LV1_NOT_IMPLEMENTED             = -20,
+	LV1_INVALID_CLASS_ID            = -21,
+	LV1_CONSTRAINT_NOT_SATISFIED    = -22,
+	LV1_ALIGNMENT_ERROR             = -23,
+	LV1_INTERNAL_ERROR              = -32768,
+};
+
+static inline const char* ps3pf_result(int result)
+{
+#if defined(DEBUG)
+	switch (result) {
+	case LV1_SUCCESS:
+		return "LV1_SUCCESS (0)";
+	case -1:
+		return "** unknown result ** (-1)";
+	case LV1_RESOURCE_SHORTAGE:
+		return "LV1_RESOURCE_SHORTAGE (-2)";
+	case LV1_NO_PRIVILEGE:
+		return "LV1_NO_PRIVILEGE (-3)";
+	case LV1_DENIED_BY_POLICY:
+		return "LV1_DENIED_BY_POLICY (-4)";
+	case LV1_ACCESS_VIOLATION:
+		return "LV1_ACCESS_VIOLATION (-5)";
+	case LV1_NO_ENTRY:
+		return "LV1_NO_ENTRY (-6)";
+	case LV1_DUPLICATE_ENTRY:
+		return "LV1_DUPLICATE_ENTRY (-7)";
+	case LV1_TYPE_MISMATCH:
+		return "LV1_TYPE_MISMATCH (-8)";
+	case LV1_BUSY:
+		return "LV1_BUSY (-9)";
+	case LV1_EMPTY:
+		return "LV1_EMPTY (-10)";
+	case LV1_WRONG_STATE:
+		return "LV1_WRONG_STATE (-11)";
+	case -12:
+		return "** unknown result ** (-12)";
+	case LV1_NO_MATCH:
+		return "LV1_NO_MATCH (-13)";
+	case LV1_ALREADY_CONNECTED:
+		return "LV1_ALREADY_CONNECTED (-14)";
+	case LV1_UNSUPPORTED_PARAMETER_VALUE:
+		return "LV1_UNSUPPORTED_PARAMETER_VALUE (-15)";
+	case LV1_CONDITION_NOT_SATISFIED:
+		return "LV1_CONDITION_NOT_SATISFIED (-16)";
+	case LV1_ILLEGAL_PARAMETER_VALUE:
+		return "LV1_ILLEGAL_PARAMETER_VALUE (-17)";
+	case LV1_BAD_OPTION:
+		return "LV1_BAD_OPTION (-18)";
+	case LV1_IMPLEMENTATION_LIMITATION:
+		return "LV1_IMPLEMENTATION_LIMITATION (-19)";
+	case LV1_NOT_IMPLEMENTED:
+		return "LV1_NOT_IMPLEMENTED (-20)";
+	case LV1_INVALID_CLASS_ID:
+		return "LV1_INVALID_CLASS_ID (-21)";
+	case LV1_CONSTRAINT_NOT_SATISFIED:
+		return "LV1_CONSTRAINT_NOT_SATISFIED (-22)";
+	case LV1_ALIGNMENT_ERROR:
+		return "LV1_ALIGNMENT_ERROR (-23)";
+	case LV1_INTERNAL_ERROR:
+		return "LV1_INTERNAL_ERROR (-32768)";
+	default:
+		BUG();
+		return "** unknown result **";
+	};
+#else
+	return "";
+#endif
+}
+
+#endif
