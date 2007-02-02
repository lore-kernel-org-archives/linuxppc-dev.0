Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 28579DDDF8
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Feb 2007 16:04:20 +1100 (EST)
Message-Id: <20070202045509.426755000@lixom.net>>
References: <20070202045448.145851000@lixom.net>>
Date: Thu, 01 Feb 2007 22:54:56 -0600
From: Olof Johansson <olof@lixom.net>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] [8/9] pasemi: iommu support
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I/O TLB support for PA6T-1682M.

Signed-off-by: Olof Johansson <olof@lixom.net>


Index: merge/arch/powerpc/platforms/pasemi/iommu.c
===================================================================
--- /dev/null
+++ merge/arch/powerpc/platforms/pasemi/iommu.c
@@ -0,0 +1,281 @@
+/*
+ * Copyright (C) 2005-2007, PA Semi, Inc
+ *
+ * Maintained by: Olof Johansson <olof@lixom.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#undef DEBUG
+
+#include <linux/types.h>
+#include <linux/spinlock.h>
+#include <linux/pci.h>
+#include <asm/iommu.h>
+#include <asm/machdep.h>
+#include <asm/abs_addr.h>
+
+
+#define IOBMAP_PAGE_SHIFT	12
+#define IOBMAP_PAGE_SIZE	(1 << IOBMAP_PAGE_SHIFT)
+#define IOBMAP_PAGE_MASK	(IOBMAP_PAGE_SIZE - 1)
+
+#define IOBMAP_PAGE_FACTOR	(PAGE_SHIFT - IOBMAP_PAGE_SHIFT)
+
+#define IOB_BASE		0xe0000000
+#define IOB_SIZE		0x3000
+/* Configuration registers */
+#define IOBCAP_REG		0x10
+#define IOBCOM_REG		0x40
+/* Enable IOB address translation */
+#define IOBCOM_ATEN		0x00000100
+
+/* Address decode configuration register */
+#define IOB_AD_REG		0x53
+/* IOBCOM_AD_REG fields */
+#define IOB_AD_VGPRT		0x00000e00
+#define IOB_AD_VGAEN		0x00000100
+/* Direct mapping settings */
+#define IOB_AD_MPSEL_MASK	0x00000030
+#define IOB_AD_MPSEL_B38	0x00000000
+#define IOB_AD_MPSEL_B40	0x00000010
+#define IOB_AD_MPSEL_B42	0x00000020
+/* Translation window size / enable */
+#define IOB_AD_TRNG_MASK	0x00000003
+#define IOB_AD_TRNG_256M	0x00000000
+#define IOB_AD_TRNG_2G		0x00000001
+#define IOB_AD_TRNG_128G	0x00000003
+
+#define IOB_TABLEBASE_REG	0x55
+
+/* Base of the 64 4-byte L1 registers */
+#define IOB_XLT_L1_REGBASE	0xac0
+
+/* Register to invalidate TLB entries */
+#define IOB_AT_INVAL_TLB_REG	0xb40
+
+/* The top two bits of the level 1 entry contains valid and type flags */
+#define IOBMAP_L1E_V		0x40000000
+#define IOBMAP_L1E_V_B		0x80000000
+
+/* For big page entries, the bottom two bits contains flags */
+#define IOBMAP_L1E_BIG_CACHED	0x00000002
+#define IOBMAP_L1E_BIG_PRIORITY	0x00000001
+
+/* For regular level 2 entries, top 2 bits contain valid and cache flags */
+#define IOBMAP_L2E_V		0x80000000
+#define IOBMAP_L2E_V_CACHED	0xc0000000
+
+static u32 *iob;
+static u32 iob_l1_emptyval;
+static u32 iob_l2_emptyval;
+static u32 *iob_l2_base;
+
+static struct iommu_table iommu_table_iobmap;
+static int iommu_table_iobmap_inited;
+
+static void iobmap_build(struct iommu_table *tbl, long index,
+			 long npages, unsigned long uaddr,
+			 enum dma_data_direction direction)
+{
+	u32 *ip;
+	u32 rpn;
+	unsigned long bus_addr;
+
+	pr_debug("iobmap: build at: %lx, %lx, addr: %lx\n", index, npages, uaddr);
+
+	bus_addr = (tbl->it_offset + index) << PAGE_SHIFT;
+
+	npages <<= IOBMAP_PAGE_FACTOR;
+	index <<= IOBMAP_PAGE_FACTOR;
+
+	ip = ((u32 *)tbl->it_base) + index;
+
+	while (npages--) {
+		rpn = virt_to_abs(uaddr) >> IOBMAP_PAGE_SHIFT;
+
+		*(ip++) = IOBMAP_L2E_V | rpn;
+		/* invalidate tlb, can be optimized more */
+		out_le32(iob+IOB_AT_INVAL_TLB_REG, bus_addr >> 14);
+
+		uaddr += IOBMAP_PAGE_SIZE;
+		bus_addr += IOBMAP_PAGE_SIZE;
+	}
+}
+
+
+static void iobmap_free(struct iommu_table *tbl, long index,
+			long npages)
+{
+	u32 *ip;
+	unsigned long bus_addr;
+
+	pr_debug("iobmap: free at: %lx, %lx\n", index, npages);
+
+	bus_addr = (tbl->it_offset + index) << PAGE_SHIFT;
+
+	npages <<= IOBMAP_PAGE_FACTOR;
+	index <<= IOBMAP_PAGE_FACTOR;
+
+	ip = ((u32 *)tbl->it_base) + index;
+
+	while (npages--) {
+		*(ip++) = iob_l2_emptyval;
+		/* invalidate tlb, can be optimized more */
+		out_le32(iob+IOB_AT_INVAL_TLB_REG, bus_addr >> 14);
+		bus_addr += IOBMAP_PAGE_SIZE;
+	}
+}
+
+
+static void iommu_table_iobmap_setup(void)
+{
+	pr_debug(" -> %s\n", __func__);
+	iommu_table_iobmap.it_busno = 0;
+	iommu_table_iobmap.it_offset = 0;
+	/* it_size is in number of entries */
+	iommu_table_iobmap.it_size = 0x80000000 >> PAGE_SHIFT;
+
+	/* Initialize the common IOMMU code */
+	iommu_table_iobmap.it_base = (unsigned long)iob_l2_base;
+	iommu_table_iobmap.it_index = 0;
+	/* XXXOJN tune this on real hardware to avoid IOB cache invals.
+	 * Should probably be 8 (64 bytes)
+	 */
+	iommu_table_iobmap.it_blocksize = 4;
+	iommu_init_table(&iommu_table_iobmap, 0);
+	pr_debug(" <- %s\n", __func__);
+}
+
+
+
+static void pci_dma_bus_setup_pasemi(struct pci_bus *bus)
+{
+	struct device_node *dn;
+
+	pr_debug("pci_dma_bus_setup, bus %p, bus->self %p\n", bus, bus->self);
+
+	if (!iommu_table_iobmap_inited) {
+		iommu_table_iobmap_inited = 1;
+		iommu_table_iobmap_setup();
+	}
+
+	dn = pci_bus_to_OF_node(bus);
+
+	if (dn)
+		PCI_DN(dn)->iommu_table = &iommu_table_iobmap;
+
+}
+
+
+static void pci_dma_dev_setup_pasemi(struct pci_dev *dev)
+{
+	pr_debug("pci_dma_dev_setup, dev %p (%s)\n", dev, pci_name(dev));
+
+	/* DMA device is untranslated, but all other PCI-e goes through
+	 * the IOMMU
+	 */
+	if (dev->vendor == 0x1959 && dev->device == 0xa007)
+		dev->dev.archdata.dma_ops = &dma_direct_ops;
+	else
+		dev->dev.archdata.dma_data = &iommu_table_iobmap;
+}
+
+static void pci_dma_bus_setup_null(struct pci_bus *b) { }
+static void pci_dma_dev_setup_null(struct pci_dev *d) { }
+
+int iob_init(struct device_node *dn)
+{
+	unsigned long tmp;
+	u32 regword;
+	int i;
+
+	pr_debug(" -> %s\n", __func__);
+
+	/* Allocate a spare page to map all invalid IOTLB pages. */
+	tmp = lmb_alloc(IOBMAP_PAGE_SIZE, IOBMAP_PAGE_SIZE);
+	if (!tmp)
+		panic("IOBMAP: Cannot allocate spare page!");
+	/* Empty l1 is marked invalid */
+	iob_l1_emptyval = 0;
+	/* Empty l2 is mapped to dummy page */
+	iob_l2_emptyval = IOBMAP_L2E_V | (tmp >> IOBMAP_PAGE_SHIFT);
+
+	iob = ioremap(IOB_BASE, IOB_SIZE);
+	if (!iob)
+		panic("IOBMAP: Cannot map registers!");
+
+	/* setup direct mapping of the L1 entries */
+	for (i = 0; i < 64; i++) {
+		/* Each L1 covers 32MB, i.e. 8K entries = 32K of ram */
+		regword = IOBMAP_L1E_V | (__pa(iob_l2_base + i*0x2000) >> 12);
+		out_le32(iob+IOB_XLT_L1_REGBASE+i, regword);
+	}
+
+	/* set 2GB translation window, based at 0 */
+	regword = in_le32(iob+IOB_AD_REG);
+	regword &= ~IOB_AD_TRNG_MASK;
+	regword |= IOB_AD_TRNG_2G;
+	out_le32(iob+IOB_AD_REG, regword);
+
+	/* Enable translation */
+	regword = in_le32(iob+IOBCOM_REG);
+	regword |= IOBCOM_ATEN;
+	out_le32(iob+IOBCOM_REG, regword);
+
+	pr_debug(" <- %s\n", __func__);
+
+	return 0;
+}
+
+
+/* These are called very early. */
+void iommu_init_early_pasemi(void)
+{
+	int iommu_off;
+
+#ifndef CONFIG_PPC_PASEMI_IOMMU
+	iommu_off = 1;
+#else
+	iommu_off = of_chosen &&
+			get_property(of_chosen, "linux,iommu-off", NULL);
+#endif
+	if (iommu_off) {
+		/* Direct I/O, IOMMU off */
+		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_null;
+		ppc_md.pci_dma_bus_setup = pci_dma_bus_setup_null;
+		pci_dma_ops = &dma_direct_ops;
+
+		return;
+	}
+
+	iob_init(NULL);
+
+	ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_pasemi;
+	ppc_md.pci_dma_bus_setup = pci_dma_bus_setup_pasemi;
+	ppc_md.tce_build = iobmap_build;
+	ppc_md.tce_free  = iobmap_free;
+	pci_dma_ops = &dma_iommu_ops;
+}
+
+void __init alloc_iobmap_l2(void)
+{
+#ifndef CONFIG_PPC_PASEMI_IOMMU
+	return;
+#endif
+	/* For 2G space, 8x64 pages (2^21 bytes) is max total l2 size */
+	iob_l2_base = (u32 *)abs_to_virt(lmb_alloc_base(1UL<<21, 1UL<<21, 0x80000000));
+
+	printk(KERN_INFO "IOBMAP L2 allocated at: %p\n", iob_l2_base);
+}
Index: merge/arch/powerpc/platforms/pasemi/setup.c
===================================================================
--- merge.orig/arch/powerpc/platforms/pasemi/setup.c
+++ merge/arch/powerpc/platforms/pasemi/setup.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006 PA Semi, Inc
+ * Copyright (C) 2006-2007 PA Semi, Inc
  *
  * Authors: Kip Walker, PA Semi
  *	    Olof Johansson, PA Semi
@@ -91,9 +91,6 @@ void __init pas_setup_arch(void)
 	/* Setup SMP callback */
 	smp_ops = &pas_smp_ops;
 #endif
-	/* no iommu yet */
-	pci_dma_ops = &dma_direct_ops;
-
 	/* Lookup PCI hosts */
 	pas_pci_init();
 
@@ -214,6 +211,11 @@ static int pas_machine_check_handler(str
 	return !!(srr1 & 0x2);
 }
 
+static void __init pas_init_early(void)
+{
+	iommu_init_early_pasemi();
+}
+
 
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
@@ -227,6 +229,8 @@ static int __init pas_probe(void)
 
 	hpte_init_native();
 
+	alloc_iobmap_l2();
+
 	return 1;
 }
 
@@ -234,6 +238,7 @@ define_machine(pas) {
 	.name			= "PA Semi PA6T-1682M",
 	.probe			= pas_probe,
 	.setup_arch		= pas_setup_arch,
+	.init_early		= pas_init_early,
 	.init_IRQ		= pas_init_IRQ,
 	.get_irq		= mpic_get_irq,
 	.restart		= pas_restart,
Index: merge/include/asm-powerpc/iommu.h
===================================================================
--- merge.orig/include/asm-powerpc/iommu.h
+++ merge/include/asm-powerpc/iommu.h
@@ -99,6 +99,7 @@ extern void iommu_unmap_single(struct io
 extern void iommu_init_early_pSeries(void);
 extern void iommu_init_early_iSeries(void);
 extern void iommu_init_early_dart(void);
+extern void iommu_init_early_pasemi(void);
 
 #ifdef CONFIG_PCI
 extern void pci_iommu_init(void);
Index: merge/arch/powerpc/Kconfig
===================================================================
--- merge.orig/arch/powerpc/Kconfig
+++ merge/arch/powerpc/Kconfig
@@ -699,6 +699,7 @@ source arch/powerpc/platforms/86xx/Kconf
 source arch/powerpc/platforms/8xx/Kconfig
 source arch/powerpc/platforms/cell/Kconfig
 source arch/powerpc/platforms/ps3/Kconfig
+source arch/powerpc/platforms/pasemi/Kconfig
 
 menu "Kernel options"
 
Index: merge/arch/powerpc/platforms/pasemi/Kconfig
===================================================================
--- /dev/null
+++ merge/arch/powerpc/platforms/pasemi/Kconfig
@@ -0,0 +1,10 @@
+menu "PA Semi PWRficient options"
+	depends on PPC_PASEMI
+
+config PPC_PASEMI_IOMMU
+	bool "PA Semi IOMMU support"
+	depends on PPC_PASEMI
+	help
+	  IOMMU support for PA6T-1682M
+
+endmenu
Index: merge/arch/powerpc/platforms/pasemi/Makefile
===================================================================
--- merge.orig/arch/powerpc/platforms/pasemi/Makefile
+++ merge/arch/powerpc/platforms/pasemi/Makefile
@@ -1,2 +1,2 @@
-obj-y	+= setup.o pci.o time.o idle.o powersave.o
+obj-y	+= setup.o pci.o time.o idle.o powersave.o iommu.o
 
Index: merge/arch/powerpc/platforms/pasemi/pasemi.h
===================================================================
--- merge.orig/arch/powerpc/platforms/pasemi/pasemi.h
+++ merge/arch/powerpc/platforms/pasemi/pasemi.h
@@ -4,6 +4,9 @@
 extern unsigned long pas_get_boot_time(void);
 extern void pas_pci_init(void);
 extern void __devinit pas_pci_irq_fixup(struct pci_dev *dev);
+extern void __devinit pas_pci_dma_dev_setup(struct pci_dev *dev);
+
+extern void __init alloc_iobmap_l2(void);
 
 extern void __init pasemi_idle_init(void);
 
@@ -12,4 +15,5 @@ extern void idle_spin(void);
 extern void idle_doze(void);
 
 
+
 #endif /* _PASEMI_PASEMI_H */

--
