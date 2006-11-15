Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 47EAB67D75
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 20:47:19 +1100 (EST)
Received: from wall11.toshiba.co.jp (wall11 [133.199.90.149])
	by imx12.toshiba.co.jp  with ESMTP id kAF9lE4X024277
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 18:47:14 +0900 (JST)
Received: (from root@localhost) by wall11.toshiba.co.jp  id kAF9lEMd007635
	for linuxppc-dev@ozlabs.org; Wed, 15 Nov 2006 18:47:14 +0900 (JST)
Received: from mx2.toshiba.co.jp (localhost [127.0.0.1])
	by ovp11.toshiba.co.jp  with ESMTP id kAF9lDod014876
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 18:47:14 +0900 (JST)
Date: Wed, 15 Nov 2006 18:47:10 +0900 (JST)
Message-Id: <200611150947.kAF9lDMi007946@toshiba.co.jp>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 10/16] IOMMU on Celleb
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

This patch creates Celleb platform depend file to support iommu.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---

Index: linux-2.6.19/arch/powerpc/platforms/celleb/iommu.c
diff -u /dev/null linux-2.6.19/arch/powerpc/platforms/celleb/iommu.c:1.2
--- /dev/null	Thu Nov  9 18:40:50 2006
+++ linux-2.6.19/arch/powerpc/platforms/celleb/iommu.c	Mon Nov  6 20:26:20 2006
@@ -0,0 +1,448 @@
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
+#define DEBUG
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
+#include "ioif.h"
+
+
+static void iommu_dev_setup_null(struct pci_dev *d)
+{
+}
+static void iommu_bus_setup_null(struct pci_bus *b)
+{
+}
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
+	unsigned long io_address;  /* start DMA address */
+	unsigned long io_size;
+	unsigned long io_page_size;
+	unsigned long flags;       /* IOPTE parameter */
+	unsigned long dmap_size;   /* size of direct map ==
+	                                start address of the rest */
+	unsigned long dmap_regions;/* == number of actual lmb regions */
+	struct celleb_iommu_dmap *dmap;
+};
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
+	    kmalloc(sizeof(struct celleb_iommu_dmap) * lmb.memory.cnt,
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
+	struct pci_dn *pdn_pci;
+	struct ioif *ioif;
+	const char *ctype, *ptype;
+	unsigned long *dma_window = NULL;
+	struct celleb_iommu *iommu;
+	struct iommu_table **iommu_set_c, **iommu_set_p;
+
+	ctype = get_property(dn, "device_type", NULL);
+	if (!ctype) {
+		pr_debug("bus type not defined.\n");
+		return ;
+	}
+	if (strncmp(ctype,"pci",3) == 0) {
+		iommu_set_c = &(PCI_DN(dn)->iommu_table);
+	} else if (strncmp(ctype,"ioif",4) == 0) {
+		iommu_set_c = &((struct ioif *)dn->data)->iommu_table;
+	} else {
+		pr_debug("unknown bus type\n");
+		return ;
+	}
+
+
+	for (pdn = dn; pdn != NULL; pdn = pdn->parent) {
+		dma_window =
+		    (unsigned long *) get_property(pdn,
+						   "toshiba,dma-window",
+						   NULL);
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
+	if (strncmp(ptype,"pci",3) == 0) {
+		pdn_pci = PCI_DN(pdn);
+		ioif = NULL;
+		iommu_set_p = &pdn_pci->iommu_table;
+	} else if (strncmp(ptype,"ioif",4) == 0) {
+		pdn_pci = NULL;
+		ioif = (struct ioif *)pdn->data;
+		iommu_set_p = &ioif->iommu_table;
+	} else {
+		pr_debug("unknown bus type\n");
+		return ;
+	}
+
+	if (!(*iommu_set_p)) {
+		iommu =
+		    (struct celleb_iommu *)
+		    kmalloc(sizeof(struct celleb_iommu), GFP_KERNEL);
+		if (iommu == NULL) {
+			pr_debug("No memory for iommu struct.\n");
+			return;
+		}
+
+		iommu->io_space_id = (dma_window[0] >> 32) & 0xffffffffUL;
+		iommu->ioid = dma_window[0] & 0x7ffUL;
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
+		*iommu_set_p = (struct iommu_table *) iommu;
+	}
+
+	if (dn != pdn) {
+		*iommu_set_c = *iommu_set_p;
+	}
+}
+
+static void iommu_dev_setup_celleb(struct pci_dev *dev)
+{
+	struct device_node *dn, *pdn;
+	char *pdn_type;
+	struct iommu_table *iommu_found = NULL;
+
+	/* We assume dma-window property is set for the buses, not for devices.
+	 * Thus we search the tree upwards only to find an iommu_table enty.
+	 */
+	dn = dev->sysdata;
+	if (!dn || !PCI_DN(dn)) {
+		return;
+	}
+
+	/* pdn->data can be either a pointer to struct pci_dn or to struct ioif
+	 */
+	for (pdn = dn; pdn && pdn->data ; pdn = pdn->parent) {
+		pdn_type = (char *)get_property(pdn, "device_type", NULL);
+		if (pdn_type && strncmp(pdn_type,"ioif",4) == 0) {
+			iommu_found = ((struct ioif *)(pdn->data))->iommu_table;
+		} else {
+			iommu_found = PCI_DN(pdn)->iommu_table;
+		}
+		if (iommu_found)
+				break;
+	}
+
+	if (pdn && pdn != dn && pdn->data && iommu_found) {
+		PCI_DN(dn)->iommu_table = iommu_found;
+	}
+}
+
+
+static inline struct celleb_iommu *devnode_table(struct device *dev)
+{
+	struct device_node *dn;
+	struct pci_dev *pdev;
+
+	if (!dev) {
+		/* No ISA support now */
+#if 0
+		pdev = ppc64_isabridge_dev;
+		if (!pdev)
+#endif
+		return NULL;
+	} else {
+		pdev = to_pci_dev(dev);
+	}
+	dn = pdev->sysdata;
+
+	return (struct celleb_iommu *) (PCI_DN(dn)->iommu_table);
+}
+
+
+static dma_addr_t get_dma_address(struct device *hwdev, size_t size,
+				  uint64_t phys_addr)
+{
+	struct celleb_iommu *iommu;
+	int i;
+
+	iommu = devnode_table(hwdev);
+	if (!iommu) {
+		return DMA_ERROR_CODE;
+	}
+	/* first, try directly mapped address */
+	if (iommu->dmap) {
+		for (i = 0; i < iommu->dmap_regions; i++) {
+			if (phys_addr >= iommu->dmap[i].real_addr &&
+			    phys_addr + size <
+			    iommu->dmap[i].real_addr + iommu->dmap[i].size) {
+				return (iommu->dmap[i].dma_addr +
+					phys_addr - iommu->dmap[i].real_addr);
+			}
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
+	iommu = devnode_table(hwdev);
+	if (!iommu)
+		return;
+
+	if (iommu->dmap) {
+		/* nothing to do */
+		;
+	} else {
+		/* TBD: not supported yet */
+		;
+	}
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
+		ppc_md.iommu_dev_setup = iommu_dev_setup_celleb;
+		ppc_md.iommu_bus_setup = iommu_bus_setup_celleb;
+	} else {
+		pr_debug("%s: IOMMU mapping activated, "
+			 "no device action necessary\n", __FUNCTION__);
+		/* Direct I/O, IOMMU off */
+		ppc_md.iommu_dev_setup = iommu_dev_setup_null;
+		ppc_md.iommu_bus_setup = iommu_bus_setup_null;
+	}
+
+	pci_dma_ops.alloc_coherent = celleb_alloc_coherent;
+	pci_dma_ops.free_coherent = celleb_free_coherent;
+	pci_dma_ops.map_single = celleb_map_single;
+	pci_dma_ops.unmap_single = celleb_unmap_single;
+	pci_dma_ops.map_sg = celleb_map_sg;
+	pci_dma_ops.unmap_sg = celleb_unmap_sg;
+	pci_dma_ops.dma_supported = celleb_dma_supported;
+}
