Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6033F67C92
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 14:47:14 +1100 (EST)
Date: Tue, 12 Dec 2006 12:47:06 +0900 (JST)
Message-Id: <200612120347.kBC3lAiH019486@toshiba.co.jp>
To: paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 9/15] celleb: Supporting iommu
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch creates Celleb platform dependent files to support iommu.

Signed-off-by: Kou Ishizaki <kou.ishizaki.co.jp>
---

Index: linux-powerpc-git/include/asm-powerpc/iommu.h
diff -u linux-powerpc-git/include/asm-powerpc/iommu.h:1.1.1.1 linux-powerpc-git/include/asm-powerpc/iommu.h:1.2
--- linux-powerpc-git/include/asm-powerpc/iommu.h:1.1.1.1	Wed Dec  6 08:24:04 2006
+++ linux-powerpc-git/include/asm-powerpc/iommu.h	Wed Dec  6 08:43:16 2006
@@ -99,6 +99,7 @@
 extern void iommu_init_early_pSeries(void);
 extern void iommu_init_early_iSeries(void);
 extern void iommu_init_early_dart(void);
+extern void celleb_init_iommu(void);
 
 #ifdef CONFIG_PCI
 extern void pci_iommu_init(void);
Index: linux-powerpc-git/arch/powerpc/platforms/celleb/iommu.c
diff -u /dev/null linux-powerpc-git/arch/powerpc/platforms/celleb/iommu.c:1.5
--- /dev/null	Mon Dec 11 21:26:17 2006
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/iommu.c	Mon Dec 11 21:09:38 2006
@@ -0,0 +1,418 @@
+/*
+ * Support for IOMMU on Celleb platform.
+ *
+ * (C) Copyright 2006 TOSHIBA CORPORATION
+ *
+ * This code is based on arch/powerpc/platforms/cell/iommu.c:
+ * Copyright (C) 2005 IBM Deutschland Entwicklung GmbH,
+ *			 Arnd Bergmann <arndb@de.ibm.com>
+ *
+ * and arch/powerpc/platforms/pseries/iommu.c:
+ * Copyright (C) 2001 Mike Corrigan & Dave Engebretsen, IBM Corporation
+ * Copyright (C) 2004 Olof Johansson <olof@lixom.net>, IBM Corporation
+ * Copyright (C) 2006 Olof Johansson <olof@lixom.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#undef DEBUG
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/string.h>
+#include <linux/init.h>
+#include <linux/bootmem.h>
+#include <linux/mm.h>
+#include <linux/dma-mapping.h>
+#include <linux/kernel.h>
+#include <linux/compiler.h>
+
+#include <asm/sections.h>
+#include <asm/iommu.h>
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <asm/pci-bridge.h>
+#include <asm/machdep.h>
+#include <asm/pmac_feature.h>
+#include <asm/abs_addr.h>
+#include <asm/system.h>
+#include <asm/ppc-pci.h>
+#include <asm/udbg.h>
+#include <asm/lmb.h>
+
+#include "beat.h"
+
+static void iommu_dev_setup_null(struct pci_dev *d)
+{
+}
+static void iommu_bus_setup_null(struct pci_bus *d)
+{
+}
+static void iopt_build_null(struct iommu_table *tbl, long index,
+	long npages, unsigned long uaddr, enum dma_data_direction direction)
+{
+}
+static void iopt_free_null(struct iommu_table *tbl, long index,
+	long npages)
+{
+}
+
+/* ToDo:
+ *  Current codes can not handle more than one NUMA domains.
+ */
+#define NR_IOMMUS	1
+
+
+struct celleb_iommu_dmap {
+	unsigned long real_addr;
+	unsigned long dma_addr;
+	unsigned long size;
+};
+
+struct celleb_iommu {
+	struct iommu_table tbl;    /* should be the first member */
+	unsigned long io_space_id;
+	unsigned long ioid;	   /* IOPTE parameter */
+	int	nid;
+	unsigned long io_address;  /* start DMA address */
+	unsigned long io_size;
+	unsigned long io_page_size;
+	unsigned long flags;       /* IOPTE parameter */
+	unsigned long dmap_size;   /* size of direct map ==
+	                                start address of the rest */
+	unsigned long dmap_regions;/* == number of actual lmb regions */
+	struct celleb_iommu_dmap *dmap;
+} iommus[NR_IOMMUS];
+
+static int celleb_nr_iommus = 0;
+
+
+/* initialize the iommu to support a simple linear mapping
+ * for each DMA window used by any device.
+ */
+static void celleb_do_map_iommu_direct(struct celleb_iommu *iommu)
+{
+	unsigned long io_address, real_address;
+	unsigned long old_address, old_ioid, old_flags;
+	int i;
+
+	iommu->dmap =
+	    kzalloc(sizeof(struct celleb_iommu_dmap) * lmb.memory.cnt,
+		    GFP_KERNEL);
+	if (!iommu->dmap) {
+		return;
+	}
+	iommu->dmap_regions = lmb.memory.cnt;
+
+	iommu->dmap_size = 0;
+	io_address = iommu->io_address;
+	for (i = 0; i < iommu->dmap_regions; i++) {
+		iommu->dmap[i].real_addr = lmb.memory.region[i].base;
+		if (io_address >= iommu->io_address + iommu->io_size) {
+			/* no more DMA address, ignore this memory region */
+			iommu->dmap[i].dma_addr = DMA_ERROR_CODE;
+			iommu->dmap[i].size = 0;
+			continue;
+		}
+		if ( (lmb.memory.region[i].base &
+		       ((1UL << iommu->io_page_size) - 1))
+		    || (lmb.memory.region[i].size &
+		       ((1UL << iommu->io_page_size) - 1))) {
+			/* page size mismatch, ignore this memory region */
+			iommu->dmap[i].dma_addr = DMA_ERROR_CODE;
+			iommu->dmap[i].size = 0;
+			continue;
+		}
+		iommu->dmap[i].dma_addr = io_address;
+		iommu->dmap[i].size = lmb.memory.region[i].size;
+
+		for (real_address = iommu->dmap[i].real_addr;
+		     real_address <
+		     iommu->dmap[i].real_addr + iommu->dmap[i].size;
+		     real_address += 1UL << iommu->io_page_size,
+		     io_address += 1UL << iommu->io_page_size) {
+			if (beat_put_iopte
+			    (iommu->io_space_id, io_address, (void *)real_address,
+			     iommu->ioid, iommu->flags, (void **)&old_address,
+			     &old_ioid, &old_flags) != 0) {
+				break;
+			}
+		}
+		if (real_address - iommu->dmap[i].real_addr <
+		    iommu->dmap[i].size) {
+			iommu->dmap[i].size =
+			    real_address - iommu->dmap[i].real_addr;
+		}
+
+		iommu->dmap_size += iommu->dmap[i].size;
+	}
+}
+
+static void iommu_bus_setup_celleb(struct pci_bus *b)
+{
+	struct device_node *dn = (struct device_node *) b->sysdata;
+	struct device_node *pdn;
+	struct pci_dn *pdn_pci = NULL;
+	const char *ctype, *ptype;
+	const unsigned long *dma_window = NULL;
+	struct celleb_iommu *iommu;
+	struct iommu_table **iommu_pos = NULL/*, **iommu_set_p */;
+
+	if (celleb_nr_iommus >= NR_IOMMUS) {
+		pr_debug("too many iommus.\n");
+		return ;
+	}
+
+	ctype = get_property(dn, "device_type", NULL);
+	if (!ctype) {
+		pr_debug("bus type not defined.\n");
+		return ;
+	}
+	if (strncmp(ctype,"pci",3) == 0)
+		iommu_pos = &(PCI_DN(dn)->iommu_table);
+
+	for (pdn = dn; pdn != NULL; pdn = pdn->parent) {
+		dma_window = get_property(pdn, "toshiba,dma-window", NULL);
+		if (dma_window != NULL)
+			break;
+	}
+	if (!dma_window) {
+		pr_debug("No toshiba,dma-window entry found !\n");
+		return;
+	}
+	ptype = get_property(pdn, "device_type", NULL);
+	if (!ptype) {
+		pr_debug("bus type not defined\n");
+		return ;
+	}
+	if (strncmp(ptype,"pci",3) == 0)
+		pdn_pci = PCI_DN(pdn);
+
+
+	/* ToDo: Do not initialize iommu tables in bus_setup, as they belong to
+	 *  CBE-IOC. To do here is to get NUMA node ID of the bus and find
+	 * an iommu table.
+         *  As the current version of Celleb's device tree doesn't have
+	 * CBE-IOC entry, we do initialize the table here..
+	 */
+	iommu = &iommus[0]; /* ToDo: must be nid of the bus */
+	if (!iommu->io_size) {
+		iommu->io_space_id = (dma_window[0] >> 32) & 0xffffffffUL;
+		iommu->ioid = dma_window[0] & 0x7ffUL;
+		iommu->nid = 0;
+		iommu->io_address = dma_window[1];
+		iommu->io_size = dma_window[2];
+		iommu->io_page_size = dma_window[3];
+		iommu->flags = 0xf800000000000000UL;
+		/* Fixed setting: read/write permitted,
+		 * Memory coherency required, Strongest order
+		 */
+		celleb_do_map_iommu_direct(iommu);	/* TBD: always? */
+
+		iommu->tbl.it_busno = pdn_pci ? pdn_pci->bussubno : 0;
+		if (iommu->dmap) {
+			iommu->tbl.it_size =
+			   (iommu->io_size - iommu->dmap_size) >> PAGE_SHIFT;
+			iommu->tbl.it_offset =
+			   (iommu->io_address + iommu->dmap_size) >> PAGE_SHIFT;
+		} else {
+			iommu->tbl.it_size = iommu->io_size >> PAGE_SHIFT;
+			iommu->tbl.it_offset = iommu->io_address >> PAGE_SHIFT;
+		}
+		iommu->tbl.it_base = 0;
+		iommu->tbl.it_index = 0;
+		iommu->tbl.it_blocksize = 16;
+
+	}
+
+	if (iommu_pos)
+		*iommu_pos = &iommu->tbl;
+}
+
+static void iommu_dev_setup_celleb(struct pci_dev *dev)
+{
+	struct celleb_iommu *iommu_found = NULL;
+
+#if 0
+	for (i=0;i<celleb_nr_iommus;i++) {
+		if (dev->dev.archdata.numa_node == iommus[i].nid) {
+			iommu_found = &iommus[i];
+			break;
+		}
+	}
+#else
+	/* ToDo: find nid and.. */
+	if (iommus[0].io_size) iommu_found = &iommus[0];
+#endif
+	dev->dev.archdata.dma_ops = pci_dma_ops;
+	dev->dev.archdata.dma_data = iommu_found;
+}
+
+
+static dma_addr_t get_dma_address(struct device *hwdev, size_t size,
+				  uint64_t phys_addr)
+{
+	struct celleb_iommu *iommu;
+	int i;
+
+	iommu = hwdev->archdata.dma_data;
+	if (!iommu)
+		return DMA_ERROR_CODE;
+
+	/* first, try directly mapped address */
+	if (iommu->dmap) {
+		for (i = 0; i < iommu->dmap_regions; i++) {
+			if (phys_addr >= iommu->dmap[i].real_addr &&
+			    phys_addr + size <
+			    iommu->dmap[i].real_addr + iommu->dmap[i].size)
+				return (iommu->dmap[i].dma_addr +
+					phys_addr - iommu->dmap[i].real_addr);
+		}
+	}
+	/* TBD: if not found in direct mapping.. */
+	return DMA_ERROR_CODE;
+}
+
+
+static void put_dma_address(struct device *hwdev, size_t size,
+			    dma_addr_t dma_addr)
+{
+	struct celleb_iommu *iommu;
+
+	iommu = hwdev->archdata.dma_data;
+	if (!iommu)
+		return;
+
+	if (iommu->dmap)
+		/* nothing to do */
+		;
+	else
+		/* TBD: not supported yet */
+		;
+}
+
+
+static void *celleb_alloc_coherent(struct device *hwdev, size_t size,
+				   dma_addr_t * dma_handle, gfp_t flag)
+{
+	void *ret;
+
+	ret = (void *) __get_free_pages(flag, get_order(size));
+	if (ret != NULL) {
+		memset(ret, 0, size);
+		*dma_handle =
+		    get_dma_address(hwdev, size, virt_to_phys(ret));
+		if (*dma_handle == DMA_ERROR_CODE) {
+			free_pages((unsigned long) ret, get_order(size));
+			return NULL;
+		}
+	}
+	return ret;
+}
+
+static void celleb_free_coherent(struct device *hwdev, size_t size,
+				 void *vaddr, dma_addr_t dma_handle)
+{
+	put_dma_address(hwdev, size, dma_handle);
+	free_pages((unsigned long) vaddr, get_order(size));
+}
+
+static dma_addr_t celleb_map_single(struct device *hwdev, void *ptr,
+				    size_t size,
+				    enum dma_data_direction direction)
+{
+	return get_dma_address(hwdev, size, virt_to_abs(ptr));
+}
+
+static void celleb_unmap_single(struct device *hwdev, dma_addr_t dma_addr,
+				size_t size,
+				enum dma_data_direction direction)
+{
+	put_dma_address(hwdev, size, dma_addr);
+}
+
+static int celleb_map_sg(struct device *hwdev, struct scatterlist *sg,
+			 int nents, enum dma_data_direction direction)
+{
+	int i;
+
+	for (i = 0; i < nents; i++, sg++) {
+		sg->dma_address =
+		    get_dma_address(hwdev, sg->length,
+				    page_to_phys(sg->page) + sg->offset);
+		sg->dma_length = sg->length;
+		if (sg->dma_address == DMA_ERROR_CODE) {
+			sg->dma_length = 0;
+			break;
+		}
+	}
+
+	return i;
+}
+
+static void celleb_unmap_sg(struct device *hwdev, struct scatterlist *sg,
+			    int nents, enum dma_data_direction direction)
+{
+	int i;
+
+	for (i = 0; i < nents; i++, sg++) {
+		if (sg->dma_address == DMA_ERROR_CODE)
+			break;
+		put_dma_address(hwdev, sg->length, sg->dma_address);
+	}
+}
+
+static int celleb_dma_supported(struct device *dev, u64 mask)
+{
+	return (mask < 0x100000000UL);
+}
+
+
+static struct dma_mapping_ops celleb_dma_ops = {
+	.alloc_coherent = celleb_alloc_coherent,
+	.free_coherent = celleb_free_coherent,
+	.map_single = celleb_map_single,
+	.unmap_single = celleb_unmap_single,
+	.map_sg = celleb_map_sg,
+	.unmap_sg = celleb_unmap_sg,
+	.dma_supported = celleb_dma_supported,
+};
+
+
+void celleb_init_iommu(void)
+{
+	int setup_bus = 0;
+
+	if (!(of_chosen &&
+	      get_property(of_chosen, "linux,iommu-off", NULL)))
+		setup_bus = 1;
+
+	if (setup_bus) {
+		pr_debug("%s: IOMMU mapping activated\n", __FUNCTION__);
+		ppc_md.pci_dma_dev_setup = iommu_dev_setup_celleb;
+		ppc_md.pci_dma_bus_setup = iommu_bus_setup_celleb;
+	} else {
+		pr_debug("%s: IOMMU mapping activated, "
+			 "no device action necessary\n", __FUNCTION__);
+		/* Direct I/O, IOMMU off */
+		ppc_md.pci_dma_dev_setup = iommu_dev_setup_null;
+		ppc_md.pci_dma_bus_setup = iommu_bus_setup_null;
+	}
+	ppc_md.tce_build = iopt_build_null;
+	ppc_md.tce_free = iopt_free_null;
+
+	pci_dma_ops = &celleb_dma_ops;
+}
