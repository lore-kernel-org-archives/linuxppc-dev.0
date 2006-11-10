Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 10 Nov 2006 18:45:09 +1100
Subject: [PATCH 29/32] powerpc: Cell iommu support
In-Reply-To: <1163144683.554182.685908332811.qpush@grosgo>
Message-Id: <20061110074513.5001767F84@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Jeremy Kerr <jk@ozlabs.org>

This patch adds full cell iommu support (and iommu diabled mode).

It implements mapping/unmapping of iommu pages on demand using the
standard powerpc iommu framework. It also supports running with
iommu disabled for machines with less than 2Gb of memory. (The
default is off in that case, though it can be forced on with the
kernel command line option iommu=force).

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 arch/powerpc/kernel/prom_init.c     |   14 
 arch/powerpc/kernel/setup_64.c      |    3 
 arch/powerpc/platforms/cell/iommu.c |  995 +++++++++++++++++++++++-------------
 arch/powerpc/platforms/cell/iommu.h |   67 --
 arch/powerpc/platforms/cell/setup.c |   43 -
 arch/powerpc/sysdev/dart_iommu.c    |    3 
 include/asm-powerpc/iommu.h         |    6 
 7 files changed, 660 insertions(+), 471 deletions(-)

Index: linux-cell/arch/powerpc/platforms/cell/iommu.c
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/cell/iommu.c	2006-11-10 16:54:09.000000000 +1100
+++ linux-cell/arch/powerpc/platforms/cell/iommu.c	2006-11-10 17:07:48.000000000 +1100
@@ -1,446 +1,747 @@
 /*
  * IOMMU implementation for Cell Broadband Processor Architecture
- * We just establish a linear mapping at boot by setting all the
- * IOPT cache entries in the CPU.
- * The mapping functions should be identical to pci_direct_iommu, 
- * except for the handling of the high order bit that is required
- * by the Spider bridge. These should be split into a separate
- * file at the point where we get a different bridge chip.
  *
- * Copyright (C) 2005 IBM Deutschland Entwicklung GmbH,
- *			 Arnd Bergmann <arndb@de.ibm.com>
+ * (C) Copyright IBM Corporation 2006
  *
- * Based on linear mapping
- * Copyright (C) 2003 Benjamin Herrenschmidt (benh@kernel.crashing.org)
+ * Author: Jeremy Kerr <jk@ozlabs.org>
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
 #undef DEBUG
 
 #include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/delay.h>
-#include <linux/string.h>
 #include <linux/init.h>
-#include <linux/bootmem.h>
-#include <linux/mm.h>
-#include <linux/dma-mapping.h>
-#include <linux/kernel.h>
-#include <linux/compiler.h>
+#include <linux/interrupt.h>
+#include <linux/notifier.h>
 
-#include <asm/sections.h>
-#include <asm/iommu.h>
-#include <asm/io.h>
 #include <asm/prom.h>
-#include <asm/pci-bridge.h>
+#include <asm/iommu.h>
 #include <asm/machdep.h>
-#include <asm/pmac_feature.h>
-#include <asm/abs_addr.h>
-#include <asm/system.h>
-#include <asm/ppc-pci.h>
+#include <asm/pci-bridge.h>
 #include <asm/udbg.h>
+#include <asm/of_platform.h>
+#include <asm/lmb.h>
 
-#include "iommu.h"
+#include "cbe_regs.h"
+#include "interrupt.h"
 
-static inline unsigned long 
-get_iopt_entry(unsigned long real_address, unsigned long ioid,
-			 unsigned long prot)
-{
-	return (prot & IOPT_PROT_MASK)
-	     | (IOPT_COHERENT)
-	     | (IOPT_ORDER_VC)
-	     | (real_address & IOPT_RPN_MASK)
-	     | (ioid & IOPT_IOID_MASK);
-}
-
-typedef struct {
-	unsigned long val;
-} ioste;
-
-static inline ioste
-mk_ioste(unsigned long val)
-{
-	ioste ioste = { .val = val, };
-	return ioste;
-}
-
-static inline ioste
-get_iost_entry(unsigned long iopt_base, unsigned long io_address, unsigned page_size)
-{
-	unsigned long ps;
-	unsigned long iostep;
-	unsigned long nnpt;
-	unsigned long shift;
-
-	switch (page_size) {
-	case 0x1000000:
-		ps = IOST_PS_16M;
-		nnpt = 0;  /* one page per segment */
-		shift = 5; /* segment has 16 iopt entries */
-		break;
-
-	case 0x100000:
-		ps = IOST_PS_1M;
-		nnpt = 0;  /* one page per segment */
-		shift = 1; /* segment has 256 iopt entries */
-		break;
-
-	case 0x10000:
-		ps = IOST_PS_64K;
-		nnpt = 0x07; /* 8 pages per io page table */
-		shift = 0;   /* all entries are used */
-		break;
-
-	case 0x1000:
-		ps = IOST_PS_4K;
-		nnpt = 0x7f; /* 128 pages per io page table */
-		shift = 0;   /* all entries are used */
-		break;
-
-	default: /* not a known compile time constant */
-		{
-			/* BUILD_BUG_ON() is not usable here */
-			extern void __get_iost_entry_bad_page_size(void);
-			__get_iost_entry_bad_page_size();
-		}
-		break;
-	}
+/* Define CELL_IOMMU_REAL_UNMAP to actually unmap non-used pages
+ * instead of leaving them mapped to some dummy page. This can be
+ * enabled once the appropriate workarounds for spider bugs have
+ * been enabled
+ */
+#define CELL_IOMMU_REAL_UNMAP
 
-	iostep = iopt_base +
-			 /* need 8 bytes per iopte */
-			(((io_address / page_size * 8)
-			 /* align io page tables on 4k page boundaries */
-				 << shift) 
-			 /* nnpt+1 pages go into each iopt */
-				 & ~(nnpt << 12));
+/* Define CELL_IOMMU_STRICT_PROTECTION to enforce protection of
+ * IO PTEs based on the transfer direction. That can be enabled
+ * once spider-net has been fixed to pass the correct direction
+ * to the DMA mapping functions
+ */
+#define CELL_IOMMU_STRICT_PROTECTION
 
-	nnpt++; /* this seems to work, but the documentation is not clear
-		   about wether we put nnpt or nnpt-1 into the ioste bits.
-		   In theory, this can't work for 4k pages. */
-	return mk_ioste(IOST_VALID_MASK
-			| (iostep & IOST_PT_BASE_MASK)
-			| ((nnpt << 5) & IOST_NNPT_MASK)
-			| (ps & IOST_PS_MASK));
-}
 
-/* compute the address of an io pte */
-static inline unsigned long
-get_ioptep(ioste iost_entry, unsigned long io_address)
-{
-	unsigned long iopt_base;
-	unsigned long page_size;
-	unsigned long page_number;
-	unsigned long iopt_offset;
+#define NR_IOMMUS			2
 
-	iopt_base = iost_entry.val & IOST_PT_BASE_MASK;
-	page_size = iost_entry.val & IOST_PS_MASK;
+/* IOC mmap registers */
+#define IOC_Reg_Size			0x2000
 
-	/* decode page size to compute page number */
-	page_number = (io_address & 0x0fffffff) >> (10 + 2 * page_size);
-	/* page number is an offset into the io page table */
-	iopt_offset = (page_number << 3) & 0x7fff8ul;
-	return iopt_base + iopt_offset;
-}
+#define IOC_IOPT_CacheInvd		0x908
+#define IOC_IOPT_CacheInvd_NE_Mask	0xffe0000000000000ul
+#define IOC_IOPT_CacheInvd_IOPTE_Mask	0x000003fffffffff8ul
+#define IOC_IOPT_CacheInvd_Busy		0x0000000000000001ul
+
+#define IOC_IOST_Origin			0x918
+#define IOC_IOST_Origin_E		0x8000000000000000ul
+#define IOC_IOST_Origin_HW		0x0000000000000800ul
+#define IOC_IOST_Origin_HL		0x0000000000000400ul
+
+#define IOC_IO_ExcpStat			0x920
+#define IOC_IO_ExcpStat_V		0x8000000000000000ul
+#define IOC_IO_ExcpStat_SPF_Mask	0x6000000000000000ul
+#define IOC_IO_ExcpStat_SPF_S		0x6000000000000000ul
+#define IOC_IO_ExcpStat_SPF_P		0x4000000000000000ul
+#define IOC_IO_ExcpStat_ADDR_Mask	0x00000007fffff000ul
+#define IOC_IO_ExcpStat_RW_Mask		0x0000000000000800ul
+#define IOC_IO_ExcpStat_IOID_Mask	0x00000000000007fful
+
+#define IOC_IO_ExcpMask			0x928
+#define IOC_IO_ExcpMask_SFE		0x4000000000000000ul
+#define IOC_IO_ExcpMask_PFE		0x2000000000000000ul
+
+#define IOC_IOCmd_Offset		0x1000
+
+#define IOC_IOCmd_Cfg			0xc00
+#define IOC_IOCmd_Cfg_TE		0x0000800000000000ul
+
+
+/* Segment table entries */
+#define IOSTE_V			0x8000000000000000ul /* valid */
+#define IOSTE_H			0x4000000000000000ul /* cache hint */
+#define IOSTE_PT_Base_RPN_Mask  0x3ffffffffffff000ul /* base RPN of IOPT */
+#define IOSTE_NPPT_Mask		0x0000000000000fe0ul /* no. pages in IOPT */
+#define IOSTE_PS_Mask		0x0000000000000007ul /* page size */
+#define IOSTE_PS_4K		0x0000000000000001ul /*   - 4kB  */
+#define IOSTE_PS_64K		0x0000000000000003ul /*   - 64kB */
+#define IOSTE_PS_1M		0x0000000000000005ul /*   - 1MB  */
+#define IOSTE_PS_16M		0x0000000000000007ul /*   - 16MB */
+
+/* Page table entries */
+#define IOPTE_PP_W		0x8000000000000000ul /* protection: write */
+#define IOPTE_PP_R		0x4000000000000000ul /* protection: read */
+#define IOPTE_M			0x2000000000000000ul /* coherency required */
+#define IOPTE_SO_R		0x1000000000000000ul /* ordering: writes */
+#define IOPTE_SO_RW             0x1800000000000000ul /* ordering: r & w */
+#define IOPTE_RPN_Mask		0x07fffffffffff000ul /* RPN */
+#define IOPTE_H			0x0000000000000800ul /* cache hint */
+#define IOPTE_IOID_Mask		0x00000000000007fful /* ioid */
+
+
+/* IOMMU sizing */
+#define IO_SEGMENT_SHIFT	28
+#define IO_PAGENO_BITS		(IO_SEGMENT_SHIFT - IOMMU_PAGE_SHIFT)
+
+/* The high bit needs to be set on every DMA address */
+#define SPIDER_DMA_OFFSET	0x80000000ul
+
+struct iommu_window {
+	struct list_head list;
+	struct cbe_iommu *iommu;
+	unsigned long offset;
+	unsigned long size;
+	unsigned long pte_offset;
+	unsigned int ioid;
+	struct iommu_table table;
+};
 
-/* compute the tag field of the iopt cache entry */
-static inline unsigned long
-get_ioc_tag(ioste iost_entry, unsigned long io_address)
-{
-	unsigned long iopte = get_ioptep(iost_entry, io_address);
+#define NAMESIZE 8
+struct cbe_iommu {
+	int nid;
+	char name[NAMESIZE];
+	void __iomem *xlate_regs;
+	void __iomem *cmd_regs;
+	unsigned long *stab;
+	unsigned long *ptab;
+	void *pad_page;
+	struct list_head windows;
+};
 
-	return IOPT_VALID_MASK
-	     | ((iopte & 0x00000000000000ff8ul) >> 3)
-	     | ((iopte & 0x0000003fffffc0000ul) >> 9);
-}
+/* Static array of iommus, one per node
+ *   each contains a list of windows, keyed from dma_window property
+ *   - on bus setup, look for a matching window, or create one
+ *   - on dev setup, assign iommu_table ptr
+ */
+static struct cbe_iommu iommus[NR_IOMMUS];
+static int cbe_nr_iommus;
 
-/* compute the hashed 6 bit index for the 4-way associative pte cache */
-static inline unsigned long
-get_ioc_hash(ioste iost_entry, unsigned long io_address)
+static void invalidate_tce_cache(struct cbe_iommu *iommu, unsigned long *pte,
+		long n_ptes)
 {
-	unsigned long iopte = get_ioptep(iost_entry, io_address);
+	unsigned long *reg, val;
+	long n;
+
+	reg = iommu->xlate_regs + IOC_IOPT_CacheInvd;
+
+	while (n_ptes > 0) {
+		/* we can invalidate up to 1 << 11 PTEs at once */
+		n = min(n_ptes, 1l << 11);
+		val = (((n /*- 1*/) << 53) & IOC_IOPT_CacheInvd_NE_Mask)
+			| (__pa(pte) & IOC_IOPT_CacheInvd_IOPTE_Mask)
+		        | IOC_IOPT_CacheInvd_Busy;
+
+		out_be64(reg, val);
+		while (in_be64(reg) & IOC_IOPT_CacheInvd_Busy)
+			;
 
-	return ((iopte & 0x000000000000001f8ul) >> 3)
-	     ^ ((iopte & 0x00000000000020000ul) >> 17)
-	     ^ ((iopte & 0x00000000000010000ul) >> 15)
-	     ^ ((iopte & 0x00000000000008000ul) >> 13)
-	     ^ ((iopte & 0x00000000000004000ul) >> 11)
-	     ^ ((iopte & 0x00000000000002000ul) >> 9)
-	     ^ ((iopte & 0x00000000000001000ul) >> 7);
+		n_ptes -= n;
+		pte += n;
+	}
 }
 
-/* same as above, but pretend that we have a simpler 1-way associative
-   pte cache with an 8 bit index */
-static inline unsigned long
-get_ioc_hash_1way(ioste iost_entry, unsigned long io_address)
+static void tce_build_cell(struct iommu_table *tbl, long index, long npages,
+		unsigned long uaddr, enum dma_data_direction direction)
 {
-	unsigned long iopte = get_ioptep(iost_entry, io_address);
+	int i;
+	unsigned long *io_pte, base_pte;
+	struct iommu_window *window =
+		container_of(tbl, struct iommu_window, table);
 
-	return ((iopte & 0x000000000000001f8ul) >> 3)
-	     ^ ((iopte & 0x00000000000020000ul) >> 17)
-	     ^ ((iopte & 0x00000000000010000ul) >> 15)
-	     ^ ((iopte & 0x00000000000008000ul) >> 13)
-	     ^ ((iopte & 0x00000000000004000ul) >> 11)
-	     ^ ((iopte & 0x00000000000002000ul) >> 9)
-	     ^ ((iopte & 0x00000000000001000ul) >> 7)
-	     ^ ((iopte & 0x0000000000000c000ul) >> 8);
-}
+	/* implementing proper protection causes problems with the spidernet
+	 * driver - check mapping directions later, but allow read & write by
+	 * default for now.*/
+#ifdef CELL_IOMMU_STRICT_PROTECTION
+	/* to avoid referencing a global, we use a trick here to setup the
+	 * protection bit. "prot" is setup to be 3 fields of 4 bits apprended
+	 * together for each of the 3 supported direction values. It is then
+	 * shifted left so that the fields matching the desired direction
+	 * lands on the appropriate bits, and other bits are masked out.
+	 */
+	const unsigned long prot = 0xc48;
+	base_pte =
+		((prot << (52 + 4 * direction)) & (IOPTE_PP_W | IOPTE_PP_R))
+		| IOPTE_M | IOPTE_SO_RW | (window->ioid & IOPTE_IOID_Mask);
+#else
+	base_pte = IOPTE_PP_W | IOPTE_PP_R | IOPTE_M | IOPTE_SO_RW |
+		(window->ioid & IOPTE_IOID_Mask);
+#endif
 
-static inline ioste
-get_iost_cache(void __iomem *base, unsigned long index)
-{
-	unsigned long __iomem *p = (base + IOC_ST_CACHE_DIR);
-	return mk_ioste(in_be64(&p[index]));
-}
+	io_pte = (unsigned long *)tbl->it_base + (index - window->pte_offset);
 
-static inline void
-set_iost_cache(void __iomem *base, unsigned long index, ioste ste)
-{
-	unsigned long __iomem *p = (base + IOC_ST_CACHE_DIR);
-	pr_debug("ioste %02lx was %016lx, store %016lx", index,
-			get_iost_cache(base, index).val, ste.val);
-	out_be64(&p[index], ste.val);
-	pr_debug(" now %016lx\n", get_iost_cache(base, index).val);
-}
+	for (i = 0; i < npages; i++, uaddr += IOMMU_PAGE_SIZE)
+		io_pte[i] = base_pte | (__pa(uaddr) & IOPTE_RPN_Mask);
 
-static inline unsigned long
-get_iopt_cache(void __iomem *base, unsigned long index, unsigned long *tag)
-{
-	unsigned long __iomem *tags = (void *)(base + IOC_PT_CACHE_DIR);
-	unsigned long __iomem *p = (void *)(base + IOC_PT_CACHE_REG);	
+	mb();
+
+	invalidate_tce_cache(window->iommu, io_pte, npages);
 
-	*tag = tags[index];
-	rmb();
-	return *p;
+	pr_debug("tce_build_cell(index=%lx,n=%lx,dir=%d,base_pte=%lx)\n",
+		 index, npages, direction, base_pte);
 }
 
-static inline void
-set_iopt_cache(void __iomem *base, unsigned long index,
-		 unsigned long tag, unsigned long val)
+static void tce_free_cell(struct iommu_table *tbl, long index, long npages)
 {
-	unsigned long __iomem *tags = base + IOC_PT_CACHE_DIR;
-	unsigned long __iomem *p = base + IOC_PT_CACHE_REG;
 
-	out_be64(p, val);
-	out_be64(&tags[index], tag);
-}
+	int i;
+	unsigned long *io_pte, pte;
+	struct iommu_window *window =
+		container_of(tbl, struct iommu_window, table);
 
-static inline void
-set_iost_origin(void __iomem *base)
-{
-	unsigned long __iomem *p = base + IOC_ST_ORIGIN;
-	unsigned long origin = IOSTO_ENABLE | IOSTO_SW;
+	pr_debug("tce_free_cell(index=%lx,n=%lx)\n", index, npages);
 
-	pr_debug("iost_origin %016lx, now %016lx\n", in_be64(p), origin);
-	out_be64(p, origin);
-}
+#ifdef CELL_IOMMU_REAL_UNMAP
+	pte = 0;
+#else
+	/* spider bridge does PCI reads after freeing - insert a mapping
+	 * to a scratch page instead of an invalid entry */
+	pte = IOPTE_PP_R | IOPTE_M | IOPTE_SO_RW | __pa(window->iommu->pad_page)
+		| (window->ioid & IOPTE_IOID_Mask);
+#endif
 
-static inline void
-set_iocmd_config(void __iomem *base)
-{
-	unsigned long __iomem *p = base + 0xc00;
-	unsigned long conf;
+	io_pte = (unsigned long *)tbl->it_base + (index - window->pte_offset);
 
-	conf = in_be64(p);
-	pr_debug("iost_conf %016lx, now %016lx\n", conf, conf | IOCMD_CONF_TE);
-	out_be64(p, conf | IOCMD_CONF_TE);
+	for (i = 0; i < npages; i++)
+		io_pte[i] = pte;
+
+	mb();
+
+	invalidate_tce_cache(window->iommu, io_pte, npages);
 }
 
-static void enable_mapping(void __iomem *base, void __iomem *mmio_base)
+static irqreturn_t ioc_interrupt(int irq, void *data)
 {
-	set_iocmd_config(base);
-	set_iost_origin(mmio_base);
+	unsigned long stat;
+	struct cbe_iommu *iommu = data;
+
+	stat = in_be64(iommu->xlate_regs + IOC_IO_ExcpStat);
+
+	/* Might want to rate limit it */
+	printk(KERN_ERR "iommu: DMA exception 0x%016lx\n", stat);
+	printk(KERN_ERR "  V=%d, SPF=[%c%c], RW=%s, IOID=0x%04x\n",
+	       !!(stat & IOC_IO_ExcpStat_V),
+	       (stat & IOC_IO_ExcpStat_SPF_S) ? 'S' : ' ',
+	       (stat & IOC_IO_ExcpStat_SPF_P) ? 'P' : ' ',
+	       (stat & IOC_IO_ExcpStat_RW_Mask) ? "Read" : "Write",
+	       (unsigned int)(stat & IOC_IO_ExcpStat_IOID_Mask));
+	printk(KERN_ERR "  page=0x%016lx\n",
+	       stat & IOC_IO_ExcpStat_ADDR_Mask);
+
+	/* clear interrupt */
+	stat &= ~IOC_IO_ExcpStat_V;
+	out_be64(iommu->xlate_regs + IOC_IO_ExcpStat, stat);
+
+	return IRQ_HANDLED;
 }
 
-struct cell_iommu {
-	unsigned long base;
-	unsigned long mmio_base;
-	void __iomem *mapped_base;
-	void __iomem *mapped_mmio_base;
-};
+static int cell_iommu_find_ioc(int nid, unsigned long *base)
+{
+	struct device_node *np;
+	struct resource r;
 
-static struct cell_iommu cell_iommus[NR_CPUS];
+	*base = 0;
 
-/* initialize the iommu to support a simple linear mapping
- * for each DMA window used by any device. For now, we
- * happen to know that there is only one DMA window in use,
- * starting at iopt_phys_offset. */
-static void cell_do_map_iommu(struct cell_iommu *iommu,
-			      unsigned int ioid,
-			      unsigned long map_start,
-			      unsigned long map_size)
-{
-	unsigned long io_address, real_address;
-	void __iomem *ioc_base, *ioc_mmio_base;
-	ioste ioste;
-	unsigned long index;
+	/* First look for new style /be nodes */
+	for_each_node_by_name(np, "ioc") {
+		if (of_node_to_nid(np) != nid)
+			continue;
+		if (of_address_to_resource(np, 0, &r)) {
+			printk(KERN_ERR "iommu: can't get address for %s\n",
+			       np->full_name);
+			continue;
+		}
+		*base = r.start;
+		of_node_put(np);
+		return 0;
+	}
 
-	/* we pretend the io page table was at a very high address */
-	const unsigned long fake_iopt = 0x10000000000ul;
-	const unsigned long io_page_size = 0x1000000; /* use 16M pages */
-	const unsigned long io_segment_size = 0x10000000; /* 256M */
-
-	ioc_base = iommu->mapped_base;
-	ioc_mmio_base = iommu->mapped_mmio_base;
-
-	for (real_address = 0, io_address = map_start;
-	     io_address <= map_start + map_size;
-	     real_address += io_page_size, io_address += io_page_size) {
-		ioste = get_iost_entry(fake_iopt, io_address, io_page_size);
-		if ((real_address % io_segment_size) == 0) /* segment start */
-			set_iost_cache(ioc_mmio_base,
-				       io_address >> 28, ioste);
-		index = get_ioc_hash_1way(ioste, io_address);
-		pr_debug("addr %08lx, index %02lx, ioste %016lx\n",
-					 io_address, index, ioste.val);
-		set_iopt_cache(ioc_mmio_base,
-			get_ioc_hash_1way(ioste, io_address),
-			get_ioc_tag(ioste, io_address),
-			get_iopt_entry(real_address, ioid, IOPT_PROT_RW));
+	/* Ok, let's try the old way */
+	for_each_node_by_type(np, "cpu") {
+		const unsigned int *nidp;
+		const unsigned long *tmp;
+
+		nidp = get_property(np, "node-id", NULL);
+		if (nidp && *nidp == nid) {
+			tmp = get_property(np, "ioc-translation", NULL);
+			if (tmp) {
+				*base = *tmp;
+				of_node_put(np);
+				return 0;
+			}
+		}
 	}
+
+	return -ENODEV;
 }
 
-static void pci_dma_cell_bus_setup(struct pci_bus *b)
+static void cell_iommu_setup_hardware(struct cbe_iommu *iommu, unsigned long size)
 {
-	const unsigned int *ioid;
-	unsigned long map_start, map_size, token;
-	const unsigned long *dma_window;
-	struct cell_iommu *iommu;
-	struct device_node *d;
+	struct page *page;
+	int ret, i;
+	unsigned long reg, segments, pages_per_segment, ptab_size, n_pte_pages;
+	unsigned long xlate_base;
+	unsigned int virq;
+
+	if (cell_iommu_find_ioc(iommu->nid, &xlate_base))
+		panic("%s: missing IOC register mappings for node %d\n",
+		      __FUNCTION__, iommu->nid);
+
+	iommu->xlate_regs = ioremap(xlate_base, IOC_Reg_Size);
+	iommu->cmd_regs = iommu->xlate_regs + IOC_IOCmd_Offset;
+
+	segments = size >> IO_SEGMENT_SHIFT;
+	pages_per_segment = 1ull << IO_PAGENO_BITS;
+
+	pr_debug("%s: iommu[%d]: segments: %lu, pages per segment: %lu\n",
+			__FUNCTION__, iommu->nid, segments, pages_per_segment);
+
+	/* set up the segment table */
+	page = alloc_pages_node(iommu->nid, GFP_KERNEL, 0);
+	BUG_ON(!page);
+	iommu->stab = page_address(page);
+	clear_page(iommu->stab);
+
+	/* ... and the page tables. Since these are contiguous, we can treat
+	 * the page tables as one array of ptes, like pSeries does.
+	 */
+	ptab_size = segments * pages_per_segment * sizeof(unsigned long);
+	pr_debug("%s: iommu[%d]: ptab_size: %lu, order: %d\n", __FUNCTION__,
+			iommu->nid, ptab_size, get_order(ptab_size));
+	page = alloc_pages_node(iommu->nid, GFP_KERNEL, get_order(ptab_size));
+	BUG_ON(!page);
+
+	iommu->ptab = page_address(page);
+	memset(iommu->ptab, 0, ptab_size);
+
+	/* allocate a bogus page for the end of each mapping */
+	page = alloc_pages_node(iommu->nid, GFP_KERNEL, 0);
+	BUG_ON(!page);
+	iommu->pad_page = page_address(page);
+	clear_page(iommu->pad_page);
+
+	/* number of pages needed for a page table */
+	n_pte_pages = (pages_per_segment *
+		       sizeof(unsigned long)) >> IOMMU_PAGE_SHIFT;
+
+	pr_debug("%s: iommu[%d]: stab at %p, ptab at %p, n_pte_pages: %lu\n",
+			__FUNCTION__, iommu->nid, iommu->stab, iommu->ptab,
+			n_pte_pages);
+
+	/* initialise the STEs */
+	reg = IOSTE_V | ((n_pte_pages - 1) << 5);
+
+	if (IOMMU_PAGE_SIZE == 0x1000)
+		reg |= IOSTE_PS_4K;
+	else if (IOMMU_PAGE_SIZE == 0x10000)
+		reg |= IOSTE_PS_64K;
+	else {
+		extern void __unknown_page_size_error(void);
+		__unknown_page_size_error();
+	}
+
+	pr_debug("Setting up IOMMU stab:\n");
+	for (i = 0; i * (1ul << IO_SEGMENT_SHIFT) < size; i++) {
+		iommu->stab[i] = reg |
+			(__pa(iommu->ptab) + n_pte_pages * IOMMU_PAGE_SIZE * i);
+		pr_debug("\t[%d] 0x%016lx\n", i, iommu->stab[i]);
+	}
 
-	d = pci_bus_to_OF_node(b);
+	/* ensure that the STEs have updated */
+	mb();
 
-	ioid = get_property(d, "ioid", NULL);
-	if (!ioid)
-		pr_debug("No ioid entry found !\n");
+	/* setup interrupts for the iommu. */
+	reg = in_be64(iommu->xlate_regs + IOC_IO_ExcpStat);
+	out_be64(iommu->xlate_regs + IOC_IO_ExcpStat,
+			reg & ~IOC_IO_ExcpStat_V);
+	out_be64(iommu->xlate_regs + IOC_IO_ExcpMask,
+			IOC_IO_ExcpMask_PFE | IOC_IO_ExcpMask_SFE);
 
-	dma_window = get_property(d, "ibm,dma-window", NULL);
-	if (!dma_window)
-		pr_debug("No ibm,dma-window entry found !\n");
+	virq = irq_create_mapping(NULL,
+			IIC_IRQ_IOEX_ATI | (iommu->nid << IIC_IRQ_NODE_SHIFT));
+	BUG_ON(virq == NO_IRQ);
 
-	map_start = dma_window[1];
-	map_size = dma_window[2];
-	token = dma_window[0] >> 32;
+	ret = request_irq(virq, ioc_interrupt, IRQF_DISABLED,
+			iommu->name, iommu);
+	BUG_ON(ret);
 
-	iommu = &cell_iommus[token];
+	/* set the IOC segment table origin register (and turn on the iommu) */
+	reg = IOC_IOST_Origin_E | __pa(iommu->stab) | IOC_IOST_Origin_HW;
+	out_be64(iommu->xlate_regs + IOC_IOST_Origin, reg);
+	in_be64(iommu->xlate_regs + IOC_IOST_Origin);
 
-	cell_do_map_iommu(iommu, *ioid, map_start, map_size);
+	/* turn on IO translation */
+	reg = in_be64(iommu->cmd_regs + IOC_IOCmd_Cfg) | IOC_IOCmd_Cfg_TE;
+	out_be64(iommu->cmd_regs + IOC_IOCmd_Cfg, reg);
 }
 
+#if 0/* Unused for now */
+static struct iommu_window *find_window(struct cbe_iommu *iommu,
+		unsigned long offset, unsigned long size)
+{
+	struct iommu_window *window;
+
+	/* todo: check for overlapping (but not equal) windows) */
 
-static int cell_map_iommu_hardcoded(int num_nodes)
+	list_for_each_entry(window, &(iommu->windows), list) {
+		if (window->offset == offset && window->size == size)
+			return window;
+	}
+
+	return NULL;
+}
+#endif
+
+static struct iommu_window * __init
+cell_iommu_setup_window(struct cbe_iommu *iommu, struct device_node *np,
+			unsigned long offset, unsigned long size,
+			unsigned long pte_offset)
 {
-	struct cell_iommu *iommu = NULL;
+	struct iommu_window *window;
+	const unsigned int *ioid;
 
-	pr_debug("%s(%d): Using hardcoded defaults\n", __FUNCTION__, __LINE__);
+	ioid = get_property(np, "ioid", NULL);
+	if (ioid == NULL)
+		printk(KERN_WARNING "iommu: missing ioid for %s using 0\n",
+		       np->full_name);
+
+	window = kmalloc_node(sizeof(*window), GFP_KERNEL, iommu->nid);
+	BUG_ON(window == NULL);
+
+	window->offset = offset;
+	window->size = size;
+	window->ioid = ioid ? *ioid : 0;
+	window->iommu = iommu;
+	window->pte_offset = pte_offset;
+
+	window->table.it_blocksize = 16;
+	window->table.it_base = (unsigned long)iommu->ptab;
+	window->table.it_index = iommu->nid;
+	window->table.it_offset = (offset >> IOMMU_PAGE_SHIFT) +
+		window->pte_offset;
+	window->table.it_size = size >> IOMMU_PAGE_SHIFT;
+
+	iommu_init_table(&window->table, iommu->nid);
+
+	pr_debug("\tioid      %d\n", window->ioid);
+	pr_debug("\tblocksize %ld\n", window->table.it_blocksize);
+	pr_debug("\tbase      0x%016lx\n", window->table.it_base);
+	pr_debug("\toffset    0x%lx\n", window->table.it_offset);
+	pr_debug("\tsize      %ld\n", window->table.it_size);
+
+	list_add(&window->list, &iommu->windows);
+
+	if (offset != 0)
+		return window;
+
+	/* We need to map and reserve the first IOMMU page since it's used
+	 * by the spider workaround. In theory, we only need to do that when
+	 * running on spider but it doesn't really matter.
+	 *
+	 * This code also assumes that we have a window that starts at 0,
+	 * which is the case on all spider based blades.
+	 */
+	__set_bit(0, window->table.it_map);
+	tce_build_cell(&window->table, window->table.it_offset, 1,
+		       (unsigned long)iommu->pad_page, DMA_TO_DEVICE);
+	window->table.it_hint = window->table.it_blocksize;
+
+	return window;
+}
+
+static struct cbe_iommu *cell_iommu_for_node(int nid)
+{
+	int i;
+
+	for (i = 0; i < cbe_nr_iommus; i++)
+		if (iommus[i].nid == nid)
+			return &iommus[i];
+	return NULL;
+}
+
+static void cell_dma_dev_setup(struct device *dev)
+{
+	struct iommu_window *window;
+	struct cbe_iommu *iommu;
+	struct dev_sysdata *sysdata = &dev->sysdata;
+
+	/* If we run without iommu, no need to do anything */
+	if (pci_dma_ops == &dma_direct_ops)
+		return;
+
+	/* Current implementation uses the first window available in that
+	 * node's iommu. We -might- do something smarter later though it may
+	 * never be necessary
+	 */
+	iommu = cell_iommu_for_node(sysdata->numa_node);
+	if (iommu == NULL || list_empty(&iommu->windows)) {
+		printk(KERN_ERR "iommu: missing iommu for %s (node %d)\n",
+		       sysdata->of_node ? sysdata->of_node->full_name : "?",
+		       sysdata->numa_node);
+		return;
+	}
+	window = list_entry(iommu->windows.next, struct iommu_window, list);
 
-	/* node 0 */
-	iommu = &cell_iommus[0];
-	iommu->mapped_base = ioremap(0x20000511000ul, 0x1000);
-	iommu->mapped_mmio_base = ioremap(0x20000510000ul, 0x1000);
+	sysdata->dma_data = &window->table;
+}
 
-	enable_mapping(iommu->mapped_base, iommu->mapped_mmio_base);
+static void cell_pci_dma_dev_setup(struct pci_dev *dev)
+{
+	cell_dma_dev_setup(&dev->dev);
+}
 
-	cell_do_map_iommu(iommu, 0x048a,
-			  0x20000000ul,0x20000000ul);
+static int cell_of_bus_notify(struct notifier_block *nb, unsigned long action,
+			      void *data)
+{
+	struct device *dev = data;
 
-	if (num_nodes < 2)
+	/* We are only intereted in device addition */
+	if (action != BUS_NOTIFY_ADD_DEVICE)
 		return 0;
 
-	/* node 1 */
-	iommu = &cell_iommus[1];
-	iommu->mapped_base = ioremap(0x30000511000ul, 0x1000);
-	iommu->mapped_mmio_base = ioremap(0x30000510000ul, 0x1000);
-
-	enable_mapping(iommu->mapped_base, iommu->mapped_mmio_base);
+	/* We use the PCI DMA ops */
+	dev->sysdata.dma_ops = pci_dma_ops;
 
-	cell_do_map_iommu(iommu, 0x048a,
-			  0x20000000,0x20000000ul);
+	cell_dma_dev_setup(dev);
 
 	return 0;
 }
 
+static struct notifier_block cell_of_bus_notifier = {
+	.notifier_call = cell_of_bus_notify
+};
 
-static int cell_map_iommu(void)
+static int __init cell_iommu_get_window(struct device_node *np,
+					 unsigned long *base,
+					 unsigned long *size)
 {
-	unsigned int num_nodes = 0;
-	const unsigned int *node_id;
-	const unsigned long *base, *mmio_base;
-	struct device_node *dn;
-	struct cell_iommu *iommu = NULL;
-
-	/* determine number of nodes (=iommus) */
-	pr_debug("%s(%d): determining number of nodes...", __FUNCTION__, __LINE__);
-	for(dn = of_find_node_by_type(NULL, "cpu");
-	    dn;
-	    dn = of_find_node_by_type(dn, "cpu")) {
-		node_id = get_property(dn, "node-id", NULL);
+	const void *dma_window;
+	unsigned long index;
 
-		if (num_nodes < *node_id)
-			num_nodes = *node_id;
-		}
+	/* Use ibm,dma-window if available, else, hard code ! */
+	dma_window = get_property(np, "ibm,dma-window", NULL);
+	if (dma_window == NULL) {
+		*base = 0;
+		*size = 0x80000000u;
+		return -ENODEV;
+	}
 
-	num_nodes++;
-	pr_debug("%i found.\n", num_nodes);
+	of_parse_dma_window(np, dma_window, &index, base, size);
+	return 0;
+}
 
-	/* map the iommu registers for each node */
-	pr_debug("%s(%d): Looping through nodes\n", __FUNCTION__, __LINE__);
-	for(dn = of_find_node_by_type(NULL, "cpu");
-	    dn;
-	    dn = of_find_node_by_type(dn, "cpu")) {
+static void __init cell_iommu_init_one(struct device_node *np, unsigned long offset)
+{
+	struct cbe_iommu *iommu;
+	unsigned long base, size;
+	int nid, i;
+
+	/* Get node ID */
+	nid = of_node_to_nid(np);
+	if (nid < 0) {
+		printk(KERN_ERR "iommu: failed to get node for %s\n",
+		       np->full_name);
+		return;
+	}
+	pr_debug("iommu: setting up iommu for node %d (%s)\n",
+		 nid, np->full_name);
 
-		node_id = get_property(dn, "node-id", NULL);
-		base = get_property(dn, "ioc-cache", NULL);
-		mmio_base = get_property(dn, "ioc-translation", NULL);
+	/* XXX todo: If we can have multiple windows on the same IOMMU, which
+	 * isn't the case today, we probably want here to check wether the
+	 * iommu for that node is already setup.
+	 * However, there might be issue with getting the size right so let's
+	 * ignore that for now. We might want to completely get rid of the
+	 * multiple window support since the cell iommu supports per-page ioids
+	 */
+
+	if (cbe_nr_iommus >= NR_IOMMUS) {
+		printk(KERN_ERR "iommu: too many IOMMUs detected ! (%s)\n",
+		       np->full_name);
+		return;
+	}
 
-		if (!base || !mmio_base || !node_id)
-			return cell_map_iommu_hardcoded(num_nodes);
+	/* Init base fields */
+	i = cbe_nr_iommus++;
+	iommu = &iommus[i];
+	iommu->stab = 0;
+	iommu->nid = nid;
+	snprintf(iommu->name, sizeof(iommu->name), "iommu%d", i);
+	INIT_LIST_HEAD(&iommu->windows);
+
+	/* Obtain a window for it */
+	cell_iommu_get_window(np, &base, &size);
+
+	pr_debug("\ttranslating window 0x%lx...0x%lx\n",
+		 base, base + size - 1);
+
+	/* Initialize the hardware */
+	cell_iommu_setup_hardware(iommu, size);
+
+	/* Setup the iommu_table */
+	cell_iommu_setup_window(iommu, np, base, size,
+				offset >> IOMMU_PAGE_SHIFT);
+}
+
+static void __init cell_disable_iommus(void)
+{
+	int node;
+	unsigned long base, val;
+	void __iomem *xregs, *cregs;
+
+	/* Make sure IOC translation is disabled on all nodes */
+	for_each_online_node(node) {
+		if (cell_iommu_find_ioc(node, &base))
+			continue;
+		xregs = ioremap(base, IOC_Reg_Size);
+		if (xregs == NULL)
+			continue;
+		cregs = xregs + IOC_IOCmd_Offset;
+
+		pr_debug("iommu: cleaning up iommu on node %d\n", node);
+
+		out_be64(xregs + IOC_IOST_Origin, 0);
+		(void)in_be64(xregs + IOC_IOST_Origin);
+		val = in_be64(cregs + IOC_IOCmd_Cfg);
+		val &= ~IOC_IOCmd_Cfg_TE;
+		out_be64(cregs + IOC_IOCmd_Cfg, val);
+		(void)in_be64(cregs + IOC_IOCmd_Cfg);
 
-		iommu = &cell_iommus[*node_id];
-		iommu->base = *base;
-		iommu->mmio_base = *mmio_base;
+		iounmap(xregs);
+	}
+}
 
-		iommu->mapped_base = ioremap(*base, 0x1000);
-		iommu->mapped_mmio_base = ioremap(*mmio_base, 0x1000);
+static int __init cell_iommu_init_disabled(void)
+{
+	struct device_node *np = NULL;
+	unsigned long base = 0, size;
 
-		enable_mapping(iommu->mapped_base,
-			       iommu->mapped_mmio_base);
+	/* When no iommu is present, we use direct DMA ops */
+	pci_dma_ops = &dma_direct_ops;
+
+	/* First make sure all IOC translation is turned off */
+	cell_disable_iommus();
+
+	/* If we have no Axon, we set up the spider DMA magic offset */
+	if (of_find_node_by_name(NULL, "axon") == NULL)
+		dma_direct_offset = SPIDER_DMA_OFFSET;
+
+	/* Now we need to check to see where the memory is mapped
+	 * in PCI space. We assume that all busses use the same dma
+	 * window which is always the case so far on Cell, thus we
+	 * pick up the first pci-internal node we can find and check
+	 * the DMA window from there.
+	 */
+	for_each_node_by_name(np, "axon") {
+		if (np->parent == NULL || np->parent->parent != NULL)
+			continue;
+		if (cell_iommu_get_window(np, &base, &size) == 0)
+			break;
+	}
+	if (np == NULL) {
+		for_each_node_by_name(np, "pci-internal") {
+			if (np->parent == NULL || np->parent->parent != NULL)
+				continue;
+			if (cell_iommu_get_window(np, &base, &size) == 0)
+				break;
+		}
+	}
+	of_node_put(np);
 
-		/* everything else will be done in iommu_bus_setup */
+	/* If we found a DMA window, we check if it's big enough to enclose
+	 * all of physical memory. If not, we force enable IOMMU
+	 */
+	if (np && size < lmb_end_of_DRAM()) {
+		printk(KERN_WARNING "iommu: force-enabled, dma window"
+		       " (%ldMB) smaller than total memory (%ldMB)\n",
+		       size >> 20, lmb_end_of_DRAM() >> 20);
+		return -ENODEV;
 	}
 
-	return 1;
+	dma_direct_offset += base;
+
+	printk("iommu: disabled, direct DMA offset is 0x%lx\n",
+	       dma_direct_offset);
+
+	return 0;
 }
 
-void cell_init_iommu(void)
+static int __init cell_iommu_init(void)
 {
-	int setup_bus = 0;
+	struct device_node *np;
 
-	if (of_find_node_by_path("/mambo")) {
-		pr_info("Not using iommu on systemsim\n");
-	} else {
-		/* If we don't have an Axon bridge, we assume we have a
-		 * spider which requires a DMA offset
-		 */
-		if (of_find_node_by_name(NULL, "axon") == NULL)
-			dma_direct_offset = SPIDER_DMA_VALID;
+	if (!machine_is(cell))
+		return -ENODEV;
 
-		if (!(of_chosen &&
-		      get_property(of_chosen, "linux,iommu-off", NULL)))
-			setup_bus = cell_map_iommu();
+	/* If IOMMU is disabled or we have little enough RAM to not need
+	 * to enable it, we setup a direct mapping.
+	 *
+	 * Note: should we make sure we have the IOMMU actually disabled ?
+	 */
+	if (iommu_is_off ||
+	    (!iommu_force_on && lmb_end_of_DRAM() <= 0x80000000ull))
+		if (cell_iommu_init_disabled() == 0)
+			goto bail;
+
+	/* Setup various ppc_md. callbacks */
+	ppc_md.pci_dma_dev_setup = cell_pci_dma_dev_setup;
+	ppc_md.tce_build = tce_build_cell;
+	ppc_md.tce_free = tce_free_cell;
+
+	/* Create an iommu for each /axon node.  */
+	for_each_node_by_name(np, "axon") {
+		if (np->parent == NULL || np->parent->parent != NULL)
+			continue;
+		cell_iommu_init_one(np, 0);
+	}
 
-		if (setup_bus) {
-			pr_debug("%s: IOMMU mapping activated\n", __FUNCTION__);
-			ppc_md.pci_dma_bus_setup = pci_dma_cell_bus_setup;
-		} else {
-			pr_debug("%s: IOMMU mapping activated, "
-				 "no device action necessary\n", __FUNCTION__);
-			/* Direct I/O, IOMMU off */
-		}
+	/* Create an iommu for each toplevel /pci-internal node for
+	 * old hardware/firmware
+	 */
+	for_each_node_by_name(np, "pci-internal") {
+		if (np->parent == NULL || np->parent->parent != NULL)
+			continue;
+		cell_iommu_init_one(np, SPIDER_DMA_OFFSET);
 	}
 
-	pci_dma_ops = &dma_direct_ops;
+	/* Setup default PCI iommu ops */
+	pci_dma_ops = &dma_iommu_ops;
+
+ bail:
+	/* Register callbacks on OF platform device addition/removal
+	 * to handle linking them to the right DMA operations
+	 */
+	register_bus_notifier(&of_platform_bus_type, &cell_of_bus_notifier);
+
+	return 0;
 }
+arch_initcall(cell_iommu_init);
+
Index: linux-cell/arch/powerpc/platforms/cell/iommu.h
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/cell/iommu.h	2006-11-10 16:53:06.000000000 +1100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,67 +0,0 @@
-#ifndef CELL_IOMMU_H
-#define CELL_IOMMU_H
-
-/* some constants */
-enum {
-	/* segment table entries */
-	IOST_VALID_MASK	  = 0x8000000000000000ul,
-	IOST_TAG_MASK     = 0x3000000000000000ul,
-	IOST_PT_BASE_MASK = 0x000003fffffff000ul,
-	IOST_NNPT_MASK	  = 0x0000000000000fe0ul,
-	IOST_PS_MASK	  = 0x000000000000000ful,
-
-	IOST_PS_4K	  = 0x1,
-	IOST_PS_64K	  = 0x3,
-	IOST_PS_1M	  = 0x5,
-	IOST_PS_16M	  = 0x7,
-
-	/* iopt tag register */
-	IOPT_VALID_MASK   = 0x0000000200000000ul,
-	IOPT_TAG_MASK	  = 0x00000001fffffffful,
-
-	/* iopt cache register */
-	IOPT_PROT_MASK	  = 0xc000000000000000ul,
-	IOPT_PROT_NONE	  = 0x0000000000000000ul,
-	IOPT_PROT_READ	  = 0x4000000000000000ul,
-	IOPT_PROT_WRITE	  = 0x8000000000000000ul,
-	IOPT_PROT_RW	  = 0xc000000000000000ul,
-	IOPT_COHERENT	  = 0x2000000000000000ul,
-	
-	IOPT_ORDER_MASK	  = 0x1800000000000000ul,
-	/* order access to same IOID/VC on same address */
-	IOPT_ORDER_ADDR	  = 0x0800000000000000ul,
-	/* similar, but only after a write access */
-	IOPT_ORDER_WRITES = 0x1000000000000000ul,
-	/* Order all accesses to same IOID/VC */
-	IOPT_ORDER_VC	  = 0x1800000000000000ul,
-	
-	IOPT_RPN_MASK	  = 0x000003fffffff000ul,
-	IOPT_HINT_MASK	  = 0x0000000000000800ul,
-	IOPT_IOID_MASK	  = 0x00000000000007fful,
-
-	IOSTO_ENABLE	  = 0x8000000000000000ul,
-	IOSTO_ORIGIN	  = 0x000003fffffff000ul,
-	IOSTO_HW	  = 0x0000000000000800ul,
-	IOSTO_SW	  = 0x0000000000000400ul,
-
-	IOCMD_CONF_TE	  = 0x0000800000000000ul,
-
-	/* memory mapped registers */
-	IOC_PT_CACHE_DIR  = 0x000,
-	IOC_ST_CACHE_DIR  = 0x800,
-	IOC_PT_CACHE_REG  = 0x910,
-	IOC_ST_ORIGIN     = 0x918,
-	IOC_CONF	  = 0x930,
-
-	/* The high bit needs to be set on every DMA address when using
-	 * a spider bridge and only 2GB are addressable with the current
-	 * iommu code.
-	 */
-	SPIDER_DMA_VALID  = 0x80000000,
-	CELL_DMA_MASK	  = 0x7fffffff,
-};
-
-
-void cell_init_iommu(void);
-
-#endif
Index: linux-cell/arch/powerpc/platforms/cell/setup.c
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/cell/setup.c	2006-11-10 16:53:06.000000000 +1100
+++ linux-cell/arch/powerpc/platforms/cell/setup.c	2006-11-10 16:54:10.000000000 +1100
@@ -30,7 +30,6 @@
 #include <linux/console.h>
 #include <linux/mutex.h>
 #include <linux/memory_hotplug.h>
-#include <linux/notifier.h>
 
 #include <asm/mmu.h>
 #include <asm/processor.h>
@@ -55,7 +54,6 @@
 #include <asm/of_platform.h>
 
 #include "interrupt.h"
-#include "iommu.h"
 #include "cbe_regs.h"
 #include "pervasive.h"
 #include "ras.h"
@@ -83,38 +81,11 @@ static void cell_progress(char *s, unsig
 	printk("*** %04x : %s\n", hex, s ? s : "");
 }
 
-static int cell_of_bus_notify(struct notifier_block *nb, unsigned long action,
-			      void *data)
-{
-	struct device *dev = data;
-
-	if (action != BUS_NOTIFY_ADD_DEVICE)
-		return 0;
-
-	/* For now, we just use the PCI DMA ops for everything, though
-	 * we'll need something better when we have a real iommu
-	 * implementation.
-	 */
-	dev->sysdata.dma_ops = pci_dma_ops;
-
-	return 0;
-}
-
-static struct notifier_block cell_of_bus_notifier = {
-	.notifier_call = cell_of_bus_notify
-};
-
-
 static int __init cell_publish_devices(void)
 {
 	if (!machine_is(cell))
 		return 0;
 
-	/* Register callbacks on OF platform device addition/removal
-	 * to handle linking them to the right DMA operations
-	 */
-	register_bus_notifier(&of_platform_bus_type, &cell_of_bus_notifier);
-
 	/* Publish OF platform devices for southbridge IOs */
 	of_platform_bus_probe(NULL, NULL, NULL);
 
@@ -205,19 +176,6 @@ static void __init cell_setup_arch(void)
 	mmio_nvram_init();
 }
 
-/*
- * Early initialization.  Relocation is on but do not reference unbolted pages
- */
-static void __init cell_init_early(void)
-{
-	DBG(" -> cell_init_early()\n");
-
-	cell_init_iommu();
-
-	DBG(" <- cell_init_early()\n");
-}
-
-
 static int __init cell_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
@@ -244,7 +202,6 @@ define_machine(cell) {
 	.name			= "Cell",
 	.probe			= cell_probe,
 	.setup_arch		= cell_setup_arch,
-	.init_early		= cell_init_early,
 	.show_cpuinfo		= cell_show_cpuinfo,
 	.restart		= rtas_restart,
 	.power_off		= rtas_power_off,
Index: linux-cell/arch/powerpc/kernel/setup_64.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/setup_64.c	2006-11-10 16:53:06.000000000 +1100
+++ linux-cell/arch/powerpc/kernel/setup_64.c	2006-11-10 16:54:10.000000000 +1100
@@ -393,7 +393,8 @@ void __init setup_system(void)
 	 * setting up the hash table pointers. It also sets up some interrupt-mapping
 	 * related options that will be used by finish_device_tree()
 	 */
-	ppc_md.init_early();
+	if (ppc_md.init_early)
+		ppc_md.init_early();
 
  	/*
 	 * We can discover serial ports now since the above did setup the
Index: linux-cell/arch/powerpc/kernel/prom_init.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/prom_init.c	2006-11-10 16:53:06.000000000 +1100
+++ linux-cell/arch/powerpc/kernel/prom_init.c	2006-11-10 16:54:10.000000000 +1100
@@ -173,8 +173,8 @@ static unsigned long __initdata dt_strin
 static unsigned long __initdata prom_initrd_start, prom_initrd_end;
 
 #ifdef CONFIG_PPC64
-static int __initdata iommu_force_on;
-static int __initdata ppc64_iommu_off;
+static int __initdata prom_iommu_force_on;
+static int __initdata prom_iommu_off;
 static unsigned long __initdata prom_tce_alloc_start;
 static unsigned long __initdata prom_tce_alloc_end;
 #endif
@@ -582,9 +582,9 @@ static void __init early_cmdline_parse(v
 		while (*opt && *opt == ' ')
 			opt++;
 		if (!strncmp(opt, RELOC("off"), 3))
-			RELOC(ppc64_iommu_off) = 1;
+			RELOC(prom_iommu_off) = 1;
 		else if (!strncmp(opt, RELOC("force"), 5))
-			RELOC(iommu_force_on) = 1;
+			RELOC(prom_iommu_force_on) = 1;
 	}
 #endif
 }
@@ -1167,7 +1167,7 @@ static void __init prom_initialize_tce_t
 	u64 local_alloc_top, local_alloc_bottom;
 	u64 i;
 
-	if (RELOC(ppc64_iommu_off))
+	if (RELOC(prom_iommu_off))
 		return;
 
 	prom_debug("starting prom_initialize_tce_table\n");
@@ -2283,11 +2283,11 @@ unsigned long __init prom_init(unsigned 
 	 * Fill in some infos for use by the kernel later on
 	 */
 #ifdef CONFIG_PPC64
-	if (RELOC(ppc64_iommu_off))
+	if (RELOC(prom_iommu_off))
 		prom_setprop(_prom->chosen, "/chosen", "linux,iommu-off",
 			     NULL, 0);
 
-	if (RELOC(iommu_force_on))
+	if (RELOC(prom_iommu_force_on))
 		prom_setprop(_prom->chosen, "/chosen", "linux,iommu-force-on",
 			     NULL, 0);
 
Index: linux-cell/arch/powerpc/sysdev/dart_iommu.c
===================================================================
--- linux-cell.orig/arch/powerpc/sysdev/dart_iommu.c	2006-11-10 16:53:06.000000000 +1100
+++ linux-cell/arch/powerpc/sysdev/dart_iommu.c	2006-11-10 16:54:10.000000000 +1100
@@ -48,9 +48,6 @@
 
 #include "dart.h"
 
-extern int iommu_is_off;
-extern int iommu_force_on;
-
 /* Physical base address and size of the DART table */
 unsigned long dart_tablebase; /* exported to htab_initialize */
 static unsigned long dart_tablesize;
Index: linux-cell/include/asm-powerpc/iommu.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/iommu.h	2006-11-10 16:53:06.000000000 +1100
+++ linux-cell/include/asm-powerpc/iommu.h	2006-11-10 16:54:10.000000000 +1100
@@ -34,7 +34,9 @@
 #define IOMMU_PAGE_MASK       (~((1 << IOMMU_PAGE_SHIFT) - 1))
 #define IOMMU_PAGE_ALIGN(addr) _ALIGN_UP(addr, IOMMU_PAGE_SIZE)
 
-#ifndef __ASSEMBLY__
+/* Boot time flags */
+extern int iommu_is_off;
+extern int iommu_force_on;
 
 /* Pure 2^n version of get_order */
 static __inline__ __attribute_const__ int get_iommu_order(unsigned long size)
@@ -42,8 +44,6 @@ static __inline__ __attribute_const__ in
 	return __ilog2((size - 1) >> IOMMU_PAGE_SHIFT) + 1;
 }
 
-#endif   /* __ASSEMBLY__ */
-
 
 /*
  * IOMAP_MAX_ORDER defines the largest contiguous block
