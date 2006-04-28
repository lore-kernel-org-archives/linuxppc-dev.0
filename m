Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 27C46679E7
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Apr 2006 00:09:13 +1000 (EST)
Date: Fri, 28 Apr 2006 09:08:35 -0500
To: paulus@samba.org
Subject: [PATCH] [2.6.18] powerpc: kill union tce_entry
Message-ID: <20060428140835.GG5518@pb15.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It's been long overdue to kill the union tce_entry in the pSeries/iSeries
TCE code, especially since I asked the Summit guys to do it on the code
they copied from us.

Also, while I was at it, I cleaned up some whitespace.

Built and booted on pSeries, built on iSeries.


Signed-off-by: Olof Johansson <olof@lixom.net>


Index: powerpc/arch/powerpc/platforms/iseries/iommu.c
===================================================================
--- powerpc.orig/arch/powerpc/platforms/iseries/iommu.c
+++ powerpc/arch/powerpc/platforms/iseries/iommu.c
@@ -4,6 +4,7 @@
  * Rewrite, cleanup:
  *
  * Copyright (C) 2004 Olof Johansson <olof@lixom.net>, IBM Corporation
+ * Copyright (C) 2006 Olof Johansson <olof@lixom.net>
  *
  * Dynamic DMA mapping support, iSeries-specific parts.
  *
@@ -43,30 +44,28 @@ static void tce_build_iSeries(struct iom
 		unsigned long uaddr, enum dma_data_direction direction)
 {
 	u64 rc;
-	union tce_entry tce;
+	u64 tce, rpn;
 
 	index <<= TCE_PAGE_FACTOR;
 	npages <<= TCE_PAGE_FACTOR;
 
 	while (npages--) {
-		tce.te_word = 0;
-		tce.te_bits.tb_rpn = virt_to_abs(uaddr) >> TCE_SHIFT;
+		rpn = virt_to_abs(uaddr) >> TCE_SHIFT;
+		tce = (rpn & TCE_RPN_MASK) << TCE_RPN_SHIFT;
 
 		if (tbl->it_type == TCE_VB) {
 			/* Virtual Bus */
-			tce.te_bits.tb_valid = 1;
-			tce.te_bits.tb_allio = 1;
+			tce |= TCE_VALID|TCE_ALLIO;
 			if (direction != DMA_TO_DEVICE)
-				tce.te_bits.tb_rdwr = 1;
+				tce |= TCE_VB_WRITE;
 		} else {
 			/* PCI Bus */
-			tce.te_bits.tb_rdwr = 1; /* Read allowed */
+			tce |= TCE_PCI_READ; /* Read allowed */
 			if (direction != DMA_TO_DEVICE)
-				tce.te_bits.tb_pciwr = 1;
+				tce |= TCE_PCI_WRITE;
 		}
 
-		rc = HvCallXm_setTce((u64)tbl->it_index, (u64)index,
-				tce.te_word);
+		rc = HvCallXm_setTce((u64)tbl->it_index, (u64)index, tce);
 		if (rc)
 			panic("PCI_DMA: HvCallXm_setTce failed, Rc: 0x%lx\n",
 					rc);
@@ -124,7 +123,7 @@ void iommu_table_getparms_iSeries(unsign
 
 	/* itc_size is in pages worth of table, it_size is in # of entries */
 	tbl->it_size = ((parms->itc_size * TCE_PAGE_SIZE) /
-			sizeof(union tce_entry)) >> TCE_PAGE_FACTOR;
+			TCE_ENTRY_SIZE) >> TCE_PAGE_FACTOR;
 	tbl->it_busno = parms->itc_busno;
 	tbl->it_offset = parms->itc_offset >> TCE_PAGE_FACTOR;
 	tbl->it_index = parms->itc_index;
Index: powerpc/arch/powerpc/platforms/pseries/iommu.c
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/iommu.c
+++ powerpc/arch/powerpc/platforms/pseries/iommu.c
@@ -1,23 +1,24 @@
 /*
  * Copyright (C) 2001 Mike Corrigan & Dave Engebretsen, IBM Corporation
  *
- * Rewrite, cleanup: 
+ * Rewrite, cleanup:
  *
  * Copyright (C) 2004 Olof Johansson <olof@lixom.net>, IBM Corporation
+ * Copyright (C) 2006 Olof Johansson <olof@lixom.net>
  *
  * Dynamic DMA mapping support, pSeries-specific parts, both SMP and LPAR.
  *
- * 
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
- * 
+ *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- * 
+ *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
@@ -49,52 +50,46 @@
 
 #define DBG(fmt...)
 
-static void tce_build_pSeries(struct iommu_table *tbl, long index, 
-			      long npages, unsigned long uaddr, 
+static void tce_build_pSeries(struct iommu_table *tbl, long index,
+			      long npages, unsigned long uaddr,
 			      enum dma_data_direction direction)
 {
-	union tce_entry t;
-	union tce_entry *tp;
+	u64 proto_tce;
+	u64 *tcep;
+	u64 rpn;
 
 	index <<= TCE_PAGE_FACTOR;
 	npages <<= TCE_PAGE_FACTOR;
 
-	t.te_word = 0;
-	t.te_rdwr = 1; // Read allowed 
+	proto_tce = TCE_PCI_READ; // Read allowed
 
 	if (direction != DMA_TO_DEVICE)
-		t.te_pciwr = 1;
+		proto_tce |= TCE_PCI_WRITE;
 
-	tp = ((union tce_entry *)tbl->it_base) + index;
+	tcep = ((u64 *)tbl->it_base) + index;
 
 	while (npages--) {
 		/* can't move this out since we might cross LMB boundary */
-		t.te_rpn = (virt_to_abs(uaddr)) >> TCE_SHIFT;
-	
-		tp->te_word = t.te_word;
+		rpn = (virt_to_abs(uaddr)) >> TCE_SHIFT;
+		*tcep = proto_tce | (rpn & TCE_RPN_MASK) << TCE_RPN_SHIFT;
 
 		uaddr += TCE_PAGE_SIZE;
-		tp++;
+		tcep++;
 	}
 }
 
 
 static void tce_free_pSeries(struct iommu_table *tbl, long index, long npages)
 {
-	union tce_entry t;
-	union tce_entry *tp;
+	u64 *tcep;
 
 	npages <<= TCE_PAGE_FACTOR;
 	index <<= TCE_PAGE_FACTOR;
 
-	t.te_word = 0;
-	tp  = ((union tce_entry *)tbl->it_base) + index;
-		
-	while (npages--) {
-		tp->te_word = t.te_word;
-		
-		tp++;
-	}
+	tcep = ((u64 *)tbl->it_base) + index;
+
+	while (npages--)
+		*(tcep++) = 0;
 }
 
 
@@ -103,43 +98,44 @@ static void tce_build_pSeriesLP(struct i
 				enum dma_data_direction direction)
 {
 	u64 rc;
-	union tce_entry tce;
+	u64 proto_tce, tce;
+	u64 rpn;
 
 	tcenum <<= TCE_PAGE_FACTOR;
 	npages <<= TCE_PAGE_FACTOR;
 
-	tce.te_word = 0;
-	tce.te_rpn = (virt_to_abs(uaddr)) >> TCE_SHIFT;
-	tce.te_rdwr = 1;
+	rpn = (virt_to_abs(uaddr)) >> TCE_SHIFT;
+	proto_tce = TCE_PCI_READ;
 	if (direction != DMA_TO_DEVICE)
-		tce.te_pciwr = 1;
+		proto_tce |= TCE_PCI_WRITE;
 
 	while (npages--) {
-		rc = plpar_tce_put((u64)tbl->it_index, 
-				   (u64)tcenum << 12, 
-				   tce.te_word );
-		
+		tce = proto_tce | (rpn & TCE_RPN_MASK) << TCE_RPN_SHIFT;
+		rc = plpar_tce_put((u64)tbl->it_index, (u64)tcenum << 12, tce);
+
 		if (rc && printk_ratelimit()) {
 			printk("tce_build_pSeriesLP: plpar_tce_put failed. rc=%ld\n", rc);
 			printk("\tindex   = 0x%lx\n", (u64)tbl->it_index);
 			printk("\ttcenum  = 0x%lx\n", (u64)tcenum);
-			printk("\ttce val = 0x%lx\n", tce.te_word );
+			printk("\ttce val = 0x%lx\n", tce );
 			show_stack(current, (unsigned long *)__get_SP());
 		}
-			
+
 		tcenum++;
-		tce.te_rpn++;
+		rpn++;
 	}
 }
 
-static DEFINE_PER_CPU(void *, tce_page) = NULL;
+static DEFINE_PER_CPU(u64 *, tce_page) = NULL;
 
 static void tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 				     long npages, unsigned long uaddr,
 				     enum dma_data_direction direction)
 {
 	u64 rc;
-	union tce_entry tce, *tcep;
+	u64 proto_tce;
+	u64 *tcep;
+	u64 rpn;
 	long l, limit;
 
 	if (TCE_PAGE_FACTOR == 0 && npages == 1)
@@ -152,7 +148,7 @@ static void tce_buildmulti_pSeriesLP(str
 	 * from iommu_alloc{,_sg}()
 	 */
 	if (!tcep) {
-		tcep = (void *)__get_free_page(GFP_ATOMIC);
+		tcep = (u64 *)__get_free_page(GFP_ATOMIC);
 		/* If allocation fails, fall back to the loop implementation */
 		if (!tcep)
 			return tce_build_pSeriesLP(tbl, tcenum, npages,
@@ -163,11 +159,10 @@ static void tce_buildmulti_pSeriesLP(str
 	tcenum <<= TCE_PAGE_FACTOR;
 	npages <<= TCE_PAGE_FACTOR;
 
-	tce.te_word = 0;
-	tce.te_rpn = (virt_to_abs(uaddr)) >> TCE_SHIFT;
-	tce.te_rdwr = 1;
+	rpn = (virt_to_abs(uaddr)) >> TCE_SHIFT;
+	proto_tce = TCE_PCI_READ;
 	if (direction != DMA_TO_DEVICE)
-		tce.te_pciwr = 1;
+		proto_tce |= TCE_PCI_WRITE;
 
 	/* We can map max one pageful of TCEs at a time */
 	do {
@@ -175,11 +170,11 @@ static void tce_buildmulti_pSeriesLP(str
 		 * Set up the page with TCE data, looping through and setting
 		 * the values.
 		 */
-		limit = min_t(long, npages, 4096/sizeof(union tce_entry));
+		limit = min_t(long, npages, 4096/TCE_ENTRY_SIZE);
 
 		for (l = 0; l < limit; l++) {
-			tcep[l] = tce;
-			tce.te_rpn++;
+			tcep[l] = proto_tce | (rpn & TCE_RPN_MASK) << TCE_RPN_SHIFT;
+			rpn++;
 		}
 
 		rc = plpar_tce_put_indirect((u64)tbl->it_index,
@@ -195,7 +190,7 @@ static void tce_buildmulti_pSeriesLP(str
 		printk("tce_buildmulti_pSeriesLP: plpar_tce_put failed. rc=%ld\n", rc);
 		printk("\tindex   = 0x%lx\n", (u64)tbl->it_index);
 		printk("\tnpages  = 0x%lx\n", (u64)npages);
-		printk("\ttce[0] val = 0x%lx\n", tcep[0].te_word);
+		printk("\ttce[0] val = 0x%lx\n", tcep[0]);
 		show_stack(current, (unsigned long *)__get_SP());
 	}
 }
@@ -203,23 +198,17 @@ static void tce_buildmulti_pSeriesLP(str
 static void tce_free_pSeriesLP(struct iommu_table *tbl, long tcenum, long npages)
 {
 	u64 rc;
-	union tce_entry tce;
 
 	tcenum <<= TCE_PAGE_FACTOR;
 	npages <<= TCE_PAGE_FACTOR;
 
-	tce.te_word = 0;
-
 	while (npages--) {
-		rc = plpar_tce_put((u64)tbl->it_index,
-				   (u64)tcenum << 12,
-				   tce.te_word);
+		rc = plpar_tce_put((u64)tbl->it_index, (u64)tcenum << 12, 0);
 
 		if (rc && printk_ratelimit()) {
 			printk("tce_free_pSeriesLP: plpar_tce_put failed. rc=%ld\n", rc);
 			printk("\tindex   = 0x%lx\n", (u64)tbl->it_index);
 			printk("\ttcenum  = 0x%lx\n", (u64)tcenum);
-			printk("\ttce val = 0x%lx\n", tce.te_word );
 			show_stack(current, (unsigned long *)__get_SP());
 		}
 
@@ -231,31 +220,24 @@ static void tce_free_pSeriesLP(struct io
 static void tce_freemulti_pSeriesLP(struct iommu_table *tbl, long tcenum, long npages)
 {
 	u64 rc;
-	union tce_entry tce;
 
 	tcenum <<= TCE_PAGE_FACTOR;
 	npages <<= TCE_PAGE_FACTOR;
 
-	tce.te_word = 0;
-
-	rc = plpar_tce_stuff((u64)tbl->it_index,
-			   (u64)tcenum << 12,
-			   tce.te_word,
-			   npages);
+	rc = plpar_tce_stuff((u64)tbl->it_index, (u64)tcenum << 12, 0, npages);
 
 	if (rc && printk_ratelimit()) {
 		printk("tce_freemulti_pSeriesLP: plpar_tce_stuff failed\n");
 		printk("\trc      = %ld\n", rc);
 		printk("\tindex   = 0x%lx\n", (u64)tbl->it_index);
 		printk("\tnpages  = 0x%lx\n", (u64)npages);
-		printk("\ttce val = 0x%lx\n", tce.te_word );
 		show_stack(current, (unsigned long *)__get_SP());
 	}
 }
 
 static void iommu_table_setparms(struct pci_controller *phb,
 				 struct device_node *dn,
-				 struct iommu_table *tbl) 
+				 struct iommu_table *tbl)
 {
 	struct device_node *node;
 	unsigned long *basep;
@@ -275,16 +257,16 @@ static void iommu_table_setparms(struct 
 	memset((void *)tbl->it_base, 0, *sizep);
 
 	tbl->it_busno = phb->bus->number;
-	
+
 	/* Units of tce entries */
 	tbl->it_offset = phb->dma_window_base_cur >> PAGE_SHIFT;
-	
+
 	/* Test if we are going over 2GB of DMA space */
 	if (phb->dma_window_base_cur + phb->dma_window_size > 0x80000000ul) {
 		udbg_printf("PCI_DMA: Unexpected number of IOAs under this PHB.\n");
-		panic("PCI_DMA: Unexpected number of IOAs under this PHB.\n"); 
+		panic("PCI_DMA: Unexpected number of IOAs under this PHB.\n");
 	}
-	
+
 	phb->dma_window_base_cur += phb->dma_window_size;
 
 	/* Set the tce table size - measured in entries */
@@ -442,7 +424,7 @@ static void iommu_bus_setup_pSeriesLP(st
 
 		tbl = (struct iommu_table *)kmalloc(sizeof(struct iommu_table),
 						    GFP_KERNEL);
-	
+
 		iommu_table_setparms_lpar(ppci->phb, pdn, tbl, dma_window);
 
 		ppci->iommu_table = iommu_init_table(tbl);
Index: powerpc/include/asm-powerpc/tce.h
===================================================================
--- powerpc.orig/include/asm-powerpc/tce.h
+++ powerpc/include/asm-powerpc/tce.h
@@ -35,32 +35,15 @@
 #define TCE_PAGE_SIZE	(1 << TCE_SHIFT)
 #define TCE_PAGE_FACTOR	(PAGE_SHIFT - TCE_SHIFT)
 
+#define TCE_ENTRY_SIZE		8		/* each TCE is 64 bits */
 
-/* tce_entry
- * Used by pSeries (SMP) and iSeries/pSeries LPAR, but there it's
- * abstracted so layout is irrelevant.
- */
-union tce_entry {
-   	unsigned long te_word;
-	struct {
-		unsigned int  tb_cacheBits :6;	/* Cache hash bits - not used */
-		unsigned int  tb_rsvd      :6;
-		unsigned long tb_rpn       :40;	/* Real page number */
-		unsigned int  tb_valid     :1;	/* Tce is valid (vb only) */
-		unsigned int  tb_allio     :1;	/* Tce is valid for all lps (vb only) */
-		unsigned int  tb_lpindex   :8;	/* LpIndex for user of TCE (vb only) */
-		unsigned int  tb_pciwr     :1;	/* Write allowed (pci only) */
-		unsigned int  tb_rdwr      :1;	/* Read allowed  (pci), Write allowed (vb) */
-	} te_bits;
-#define te_cacheBits te_bits.tb_cacheBits
-#define te_rpn       te_bits.tb_rpn
-#define te_valid     te_bits.tb_valid
-#define te_allio     te_bits.tb_allio
-#define te_lpindex   te_bits.tb_lpindex
-#define te_pciwr     te_bits.tb_pciwr
-#define te_rdwr      te_bits.tb_rdwr
-};
-
+#define TCE_RPN_MASK		0xfffffffffful  /* 40-bit RPN (4K pages) */
+#define TCE_RPN_SHIFT		12
+#define TCE_VALID		0x200		/* TCE valid */
+#define TCE_ALLIO		0x100		/* TCE valid for all lpars */
+#define TCE_PCI_WRITE		0x2		/* write from PCI allowed */
+#define TCE_PCI_READ		0x1		/* read from PCI allowed */
+#define TCE_VB_WRITE		0x1		/* write from VB allowed */
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_TCE_H */
