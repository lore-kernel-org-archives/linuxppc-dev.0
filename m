Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E46F4DE1F5
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jun 2008 01:12:53 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5KFCn0P016695
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 11:12:49 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5KFCnT6206734
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 11:12:49 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5KFCmMo005530
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 11:12:49 -0400
Date: Fri, 20 Jun 2008 10:12:47 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: paulus@samba.org, linuxppc-dev@ozlabs.org,
	Brian King <brking@linux.vnet.ibm.com>,
	Nathan Fontenot <nfont@austin.ibm.com>,
	David Darrington <ddarring@linux.vnet.ibm.com>
Subject: Re: [PATCH 11/19][v2] powerpc: iommu enablement for CMO
Message-ID: <20080620151246.GB6594@linux.vnet.ibm.com>
References: <20080612215312.GF30916@linux.vnet.ibm.com>
	<20080612221936.GS30916@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080612221936.GS30916@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

To support Cooperative Memory Overcommitment (CMO), we need to check
for failure from some of the tce hcalls.

These changes for the pseries platform affect the powerpc architecture;
patches for the other affected platforms are included in this patch.

pSeries platform IOMMU code changes:
 * platform TCE functions must handle H_NOT_ENOUGH_RESOURCES errors and
   return an error.

Architecture IOMMU code changes:
 * Calls to ppc_md.tce_build need to check return values and return 
   DMA_MAPPING_ERROR for transient errors.

Architecture changes:
 * struct machdep_calls for tce_build*_pSeriesLP functions need to change
   to indicate failure.
 * all other platforms will need updates to iommu functions to match the new
   calling semantics; they will return 0 on success.  The other platforms
   default configs have been built, but no further testing was performed.

Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>

---
 arch/powerpc/kernel/iommu.c            |   26 +++++++++++++++++++++----
 arch/powerpc/platforms/cell/iommu.c    |    3 ++-
 arch/powerpc/platforms/iseries/iommu.c |    3 ++-
 arch/powerpc/platforms/pasemi/iommu.c  |    3 ++-
 arch/powerpc/platforms/pseries/iommu.c |   34 ++++++++++++++++++++++++++++-----
 arch/powerpc/sysdev/dart_iommu.c       |    3 ++-
 include/asm-powerpc/machdep.h          |    2 +-
 7 files changed, 60 insertions(+), 14 deletions(-)

Index: b/arch/powerpc/kernel/iommu.c
===================================================================
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -49,6 +49,8 @@ static int novmerge = 1;
 
 static int protect4gb = 1;
 
+static void __iommu_free(struct iommu_table *, dma_addr_t, unsigned int);
+
 static inline unsigned long iommu_num_pages(unsigned long vaddr,
 					    unsigned long slen)
 {
@@ -190,6 +192,7 @@ static dma_addr_t iommu_alloc(struct dev
 {
 	unsigned long entry, flags;
 	dma_addr_t ret = DMA_ERROR_CODE;
+	int build_fail;
 
 	spin_lock_irqsave(&(tbl->it_lock), flags);
 
@@ -204,9 +207,21 @@ static dma_addr_t iommu_alloc(struct dev
 	ret = entry << IOMMU_PAGE_SHIFT;	/* Set the return dma address */
 
 	/* Put the TCEs in the HW table */
-	ppc_md.tce_build(tbl, entry, npages, (unsigned long)page & IOMMU_PAGE_MASK,
-			 direction);
+	build_fail = ppc_md.tce_build(tbl, entry, npages,
+	                              (unsigned long)page & IOMMU_PAGE_MASK,
+	                              direction);
+
+	/* ppc_md.tce_build() only returns non-zero for transient errors.
+	 * Clean up the table bitmap in this case and return
+	 * DMA_ERROR_CODE. For all other errors the functionality is
+	 * not altered.
+	 */
+	if (unlikely(build_fail)) {
+		__iommu_free(tbl, ret, npages);
 
+		spin_unlock_irqrestore(&(tbl->it_lock), flags);
+		return DMA_ERROR_CODE;
+	}
 
 	/* Flush/invalidate TLB caches if necessary */
 	if (ppc_md.tce_flush)
@@ -275,7 +290,7 @@ int iommu_map_sg(struct device *dev, str
 	dma_addr_t dma_next = 0, dma_addr;
 	unsigned long flags;
 	struct scatterlist *s, *outs, *segstart;
-	int outcount, incount, i;
+	int outcount, incount, i, build_fail = 0;
 	unsigned int align;
 	unsigned long handle;
 	unsigned int max_seg_size;
@@ -336,7 +351,10 @@ int iommu_map_sg(struct device *dev, str
 			    npages, entry, dma_addr);
 
 		/* Insert into HW table */
-		ppc_md.tce_build(tbl, entry, npages, vaddr & IOMMU_PAGE_MASK, direction);
+		build_fail = ppc_md.tce_build(tbl, entry, npages,
+		                              vaddr & IOMMU_PAGE_MASK, direction);
+		if(unlikely(build_fail))
+			goto failure;
 
 		/* If we are in an open segment, try merging */
 		if (segstart != s) {
Index: b/arch/powerpc/platforms/cell/iommu.c
===================================================================
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -172,7 +172,7 @@ static void invalidate_tce_cache(struct 
 	}
 }
 
-static void tce_build_cell(struct iommu_table *tbl, long index, long npages,
+static int tce_build_cell(struct iommu_table *tbl, long index, long npages,
 		unsigned long uaddr, enum dma_data_direction direction)
 {
 	int i;
@@ -210,6 +210,7 @@ static void tce_build_cell(struct iommu_
 
 	pr_debug("tce_build_cell(index=%lx,n=%lx,dir=%d,base_pte=%lx)\n",
 		 index, npages, direction, base_pte);
+	return 0;
 }
 
 static void tce_free_cell(struct iommu_table *tbl, long index, long npages)
Index: b/arch/powerpc/platforms/iseries/iommu.c
===================================================================
--- a/arch/powerpc/platforms/iseries/iommu.c
+++ b/arch/powerpc/platforms/iseries/iommu.c
@@ -41,7 +41,7 @@
 #include <asm/iseries/hv_call_event.h>
 #include <asm/iseries/iommu.h>
 
-static void tce_build_iSeries(struct iommu_table *tbl, long index, long npages,
+static int tce_build_iSeries(struct iommu_table *tbl, long index, long npages,
 		unsigned long uaddr, enum dma_data_direction direction)
 {
 	u64 rc;
@@ -70,6 +70,7 @@ static void tce_build_iSeries(struct iom
 		index++;
 		uaddr += TCE_PAGE_SIZE;
 	}
+	return 0;
 }
 
 static void tce_free_iSeries(struct iommu_table *tbl, long index, long npages)
Index: b/arch/powerpc/platforms/pasemi/iommu.c
===================================================================
--- a/arch/powerpc/platforms/pasemi/iommu.c
+++ b/arch/powerpc/platforms/pasemi/iommu.c
@@ -83,7 +83,7 @@ static u32 *iob_l2_base;
 static struct iommu_table iommu_table_iobmap;
 static int iommu_table_iobmap_inited;
 
-static void iobmap_build(struct iommu_table *tbl, long index,
+static int iobmap_build(struct iommu_table *tbl, long index,
 			 long npages, unsigned long uaddr,
 			 enum dma_data_direction direction)
 {
@@ -107,6 +107,7 @@ static void iobmap_build(struct iommu_ta
 		uaddr += IOBMAP_PAGE_SIZE;
 		bus_addr += IOBMAP_PAGE_SIZE;
 	}
+	return 0;
 }
 
 
Index: b/arch/powerpc/platforms/pseries/iommu.c
===================================================================
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -48,7 +48,7 @@
 #include "plpar_wrappers.h"
 
 
-static void tce_build_pSeries(struct iommu_table *tbl, long index,
+static int tce_build_pSeries(struct iommu_table *tbl, long index,
 			      long npages, unsigned long uaddr,
 			      enum dma_data_direction direction)
 {
@@ -71,6 +71,7 @@ static void tce_build_pSeries(struct iom
 		uaddr += TCE_PAGE_SIZE;
 		tcep++;
 	}
+	return 0;
 }
 
 
@@ -93,13 +94,18 @@ static unsigned long tce_get_pseries(str
 	return *tcep;
 }
 
-static void tce_build_pSeriesLP(struct iommu_table *tbl, long tcenum,
+static void tce_free_pSeriesLP(struct iommu_table*, long, long);
+static void tce_freemulti_pSeriesLP(struct iommu_table*, long, long);
+
+static int tce_build_pSeriesLP(struct iommu_table *tbl, long tcenum,
 				long npages, unsigned long uaddr,
 				enum dma_data_direction direction)
 {
-	u64 rc;
+	u64 rc = 0;
 	u64 proto_tce, tce;
 	u64 rpn;
+	int ret = 0;
+	long tcenum_start = tcenum, npages_start = npages;
 
 	rpn = (virt_to_abs(uaddr)) >> TCE_SHIFT;
 	proto_tce = TCE_PCI_READ;
@@ -110,6 +116,13 @@ static void tce_build_pSeriesLP(struct i
 		tce = proto_tce | (rpn & TCE_RPN_MASK) << TCE_RPN_SHIFT;
 		rc = plpar_tce_put((u64)tbl->it_index, (u64)tcenum << 12, tce);
 
+		if (unlikely(rc == H_NOT_ENOUGH_RESOURCES)) {
+			ret = (int)rc;
+			tce_free_pSeriesLP(tbl, tcenum_start,
+			                   (npages_start - (npages + 1)));
+			break;
+		}
+
 		if (rc && printk_ratelimit()) {
 			printk("tce_build_pSeriesLP: plpar_tce_put failed. rc=%ld\n", rc);
 			printk("\tindex   = 0x%lx\n", (u64)tbl->it_index);
@@ -121,19 +134,22 @@ static void tce_build_pSeriesLP(struct i
 		tcenum++;
 		rpn++;
 	}
+	return ret;
 }
 
 static DEFINE_PER_CPU(u64 *, tce_page) = NULL;
 
-static void tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
+static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 				     long npages, unsigned long uaddr,
 				     enum dma_data_direction direction)
 {
-	u64 rc;
+	u64 rc = 0;
 	u64 proto_tce;
 	u64 *tcep;
 	u64 rpn;
 	long l, limit;
+	long tcenum_start = tcenum, npages_start = npages;
+	int ret = 0;
 
 	if (npages == 1)
 		return tce_build_pSeriesLP(tbl, tcenum, npages, uaddr,
@@ -180,6 +196,13 @@ static void tce_buildmulti_pSeriesLP(str
 		tcenum += limit;
 	} while (npages > 0 && !rc);
 
+	if (unlikely(rc == H_NOT_ENOUGH_RESOURCES)) {
+		ret = (int)rc;
+		tce_freemulti_pSeriesLP(tbl, tcenum_start,
+		                        (npages_start - (npages + limit)));
+		return ret;
+	}
+
 	if (rc && printk_ratelimit()) {
 		printk("tce_buildmulti_pSeriesLP: plpar_tce_put failed. rc=%ld\n", rc);
 		printk("\tindex   = 0x%lx\n", (u64)tbl->it_index);
@@ -187,6 +210,7 @@ static void tce_buildmulti_pSeriesLP(str
 		printk("\ttce[0] val = 0x%lx\n", tcep[0]);
 		show_stack(current, (unsigned long *)__get_SP());
 	}
+	return ret;
 }
 
 static void tce_free_pSeriesLP(struct iommu_table *tbl, long tcenum, long npages)
Index: b/arch/powerpc/sysdev/dart_iommu.c
===================================================================
--- a/arch/powerpc/sysdev/dart_iommu.c
+++ b/arch/powerpc/sysdev/dart_iommu.c
@@ -147,7 +147,7 @@ static void dart_flush(struct iommu_tabl
 	}
 }
 
-static void dart_build(struct iommu_table *tbl, long index,
+static int dart_build(struct iommu_table *tbl, long index,
 		       long npages, unsigned long uaddr,
 		       enum dma_data_direction direction)
 {
@@ -183,6 +183,7 @@ static void dart_build(struct iommu_tabl
 	} else {
 		dart_dirty = 1;
 	}
+	return 0;
 }
 
 
Index: b/include/asm-powerpc/machdep.h
===================================================================
--- a/include/asm-powerpc/machdep.h
+++ b/include/asm-powerpc/machdep.h
@@ -76,7 +76,7 @@ struct machdep_calls {
 	 * destroyed as well */
 	void		(*hpte_clear_all)(void);
 
-	void		(*tce_build)(struct iommu_table * tbl,
+	int		(*tce_build)(struct iommu_table *tbl,
 				     long index,
 				     long npages,
 				     unsigned long uaddr,
