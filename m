Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C6A31DE208
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 08:21:12 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5CML91e000862
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 18:21:09 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5CML8PK175034
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 16:21:08 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5CML7Ft021127
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 16:21:08 -0600
Date: Thu, 12 Jun 2008 17:19:36 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: [PATCH 11/19] powerpc: iommu enablement for CMO
Message-ID: <20080612221936.GS30916@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080612215312.GF30916@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	David Darrington <ddarring@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=46rom: Robert Jennings <rcj@linux.vnet.ibm.com>

To support Cooperative Memory Overcommitment (CMO), we need to check
for failure and busy responses from some of the tce hcalls.

These changes for the pseries platform affect the powerpc architecture;
patches for the other affected platforms are included in this patch.

pSeries platform IOMMU code changes:
 * platform TCE functions must handle H_NOT_ENOUGH_RESOURCES errors.
 * platform TCE functions must retry when H_LONG_BUSY_* is returned.
 * platform TCE functions must return error when H_NOT_ENOUGH_RESOURCES
   encountered.

Architecture IOMMU code changes:
 * Calls to ppc_md.tce_build need to check return values and return=20
   DMA_MAPPING_ERROR

Architecture changes:
 * struct machdep_calls for tce_build*_pSeriesLP functions need to change
   to indicate failure
 * all other platforms will need updates to iommu functions to match the new
   calling semantics; they will return 0 on success.  The other platforms
   default configs have been built, but no further testing was performed.

Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>

---
 arch/powerpc/kernel/iommu.c            |   71 ++++++++++++++++++++++++++++=
+--
 arch/powerpc/platforms/cell/iommu.c    |    3 +
 arch/powerpc/platforms/iseries/iommu.c |    3 +
 arch/powerpc/platforms/pasemi/iommu.c  |    3 +
 arch/powerpc/platforms/pseries/iommu.c |   76 ++++++++++++++++++++++++++++=
-----
 arch/powerpc/sysdev/dart_iommu.c       |    3 +
 include/asm-powerpc/machdep.h          |    2=20
 7 files changed, 139 insertions(+), 22 deletions(-)

Index: b/arch/powerpc/kernel/iommu.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -183,6 +183,49 @@ static unsigned long iommu_range_alloc(s
 	return n;
 }
=20
+/** iommu_undo - Clear iommu_table bits without calling platform tce_free.
+ *
+ * @tbl - struct iommu_table to alter
+ * @dma_addr - DMA address to free entries for
+ * @npages - number of pages to free entries for
+ *
+ * This is the same as __iommu_free without the call to ppc_md.tce_free();
+ *
+ * To clean up after ppc_md.tce_build() errors we need to clear bits
+ * in the table without calling the ppc_md.tce_free() method; calling
+ * ppc_md.tce_free() could alter entries that were not touched due to a
+ * premature failure in ppc_md.tce_build().
+ *
+ * The ppc_md.tce_build() needs to perform its own clean up prior to
+ * returning its error.
+ */
+static void iommu_undo(struct iommu_table *tbl, dma_addr_t dma_addr,
+			 unsigned int npages)
+{
+	unsigned long entry, free_entry;
+
+	entry =3D dma_addr >> IOMMU_PAGE_SHIFT;
+	free_entry =3D entry - tbl->it_offset;
+
+	if (((free_entry + npages) > tbl->it_size) ||
+	    (entry < tbl->it_offset)) {
+		if (printk_ratelimit()) {
+			printk(KERN_INFO "iommu_undo: invalid entry\n");
+			printk(KERN_INFO "\tentry    =3D 0x%lx\n", entry);
+			printk(KERN_INFO "\tdma_addr =3D 0x%lx\n", (u64)dma_addr);
+			printk(KERN_INFO "\tTable    =3D 0x%lx\n", (u64)tbl);
+			printk(KERN_INFO "\tbus#     =3D 0x%lx\n", tbl->it_busno);
+			printk(KERN_INFO "\tsize     =3D 0x%lx\n", tbl->it_size);
+			printk(KERN_INFO "\tstartOff =3D 0x%lx\n", tbl->it_offset);
+			printk(KERN_INFO "\tindex    =3D 0x%lx\n", tbl->it_index);
+			WARN_ON(1);
+		}
+		return;
+	}
+
+	iommu_area_free(tbl->it_map, free_entry, npages);
+}
+
 static dma_addr_t iommu_alloc(struct device *dev, struct iommu_table *tbl,
 			      void *page, unsigned int npages,
 			      enum dma_data_direction direction,
@@ -190,6 +233,7 @@ static dma_addr_t iommu_alloc(struct dev
 {
 	unsigned long entry, flags;
 	dma_addr_t ret =3D DMA_ERROR_CODE;
+	int rc;
=20
 	spin_lock_irqsave(&(tbl->it_lock), flags);
=20
@@ -204,9 +248,20 @@ static dma_addr_t iommu_alloc(struct dev
 	ret =3D entry << IOMMU_PAGE_SHIFT;	/* Set the return dma address */
=20
 	/* Put the TCEs in the HW table */
-	ppc_md.tce_build(tbl, entry, npages, (unsigned long)page & IOMMU_PAGE_MAS=
K,
-			 direction);
+	rc =3D ppc_md.tce_build(tbl, entry, npages,
+	                      (unsigned long)page & IOMMU_PAGE_MASK, direction);
=20
+	/* ppc_md.tce_build() only returns non-zero for transient errors.
+	 * Clean up the table bitmap in this case and return
+	 * DMA_ERROR_CODE. For all other errors the functionality is
+	 * not altered.
+	 */
+	if (unlikely(rc)) {
+		iommu_undo(tbl, ret, npages);
+
+		spin_unlock_irqrestore(&(tbl->it_lock), flags);
+		return DMA_ERROR_CODE;
+	}
=20
 	/* Flush/invalidate TLB caches if necessary */
 	if (ppc_md.tce_flush)
@@ -275,7 +330,7 @@ int iommu_map_sg(struct device *dev, str
 	dma_addr_t dma_next =3D 0, dma_addr;
 	unsigned long flags;
 	struct scatterlist *s, *outs, *segstart;
-	int outcount, incount, i;
+	int outcount, incount, i, rc =3D 0;
 	unsigned int align;
 	unsigned long handle;
 	unsigned int max_seg_size;
@@ -336,7 +391,10 @@ int iommu_map_sg(struct device *dev, str
 			    npages, entry, dma_addr);
=20
 		/* Insert into HW table */
-		ppc_md.tce_build(tbl, entry, npages, vaddr & IOMMU_PAGE_MASK, direction);
+		rc =3D ppc_md.tce_build(tbl, entry, npages,
+		                      vaddr & IOMMU_PAGE_MASK, direction);
+		if(unlikely(rc))
+			goto failure;
=20
 		/* If we are in an open segment, try merging */
 		if (segstart !=3D s) {
@@ -399,7 +457,10 @@ int iommu_map_sg(struct device *dev, str
=20
 			vaddr =3D s->dma_address & IOMMU_PAGE_MASK;
 			npages =3D iommu_num_pages(s->dma_address, s->dma_length);
-			__iommu_free(tbl, vaddr, npages);
+			if (!rc)
+				__iommu_free(tbl, vaddr, npages);
+			else
+				iommu_undo(tbl, vaddr, npages);
 			s->dma_address =3D DMA_ERROR_CODE;
 			s->dma_length =3D 0;
 		}
Index: b/arch/powerpc/platforms/cell/iommu.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -172,7 +172,7 @@ static void invalidate_tce_cache(struct=20
 	}
 }
=20
-static void tce_build_cell(struct iommu_table *tbl, long index, long npage=
s,
+static int tce_build_cell(struct iommu_table *tbl, long index, long npages,
 		unsigned long uaddr, enum dma_data_direction direction)
 {
 	int i;
@@ -210,6 +210,7 @@ static void tce_build_cell(struct iommu_
=20
 	pr_debug("tce_build_cell(index=3D%lx,n=3D%lx,dir=3D%d,base_pte=3D%lx)\n",
 		 index, npages, direction, base_pte);
+	return 0;
 }
=20
 static void tce_free_cell(struct iommu_table *tbl, long index, long npages)
Index: b/arch/powerpc/platforms/iseries/iommu.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/powerpc/platforms/iseries/iommu.c
+++ b/arch/powerpc/platforms/iseries/iommu.c
@@ -41,7 +41,7 @@
 #include <asm/iseries/hv_call_event.h>
 #include <asm/iseries/iommu.h>
=20
-static void tce_build_iSeries(struct iommu_table *tbl, long index, long np=
ages,
+static int tce_build_iSeries(struct iommu_table *tbl, long index, long npa=
ges,
 		unsigned long uaddr, enum dma_data_direction direction)
 {
 	u64 rc;
@@ -70,6 +70,7 @@ static void tce_build_iSeries(struct iom
 		index++;
 		uaddr +=3D TCE_PAGE_SIZE;
 	}
+	return 0;
 }
=20
 static void tce_free_iSeries(struct iommu_table *tbl, long index, long npa=
ges)
Index: b/arch/powerpc/platforms/pasemi/iommu.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/powerpc/platforms/pasemi/iommu.c
+++ b/arch/powerpc/platforms/pasemi/iommu.c
@@ -83,7 +83,7 @@ static u32 *iob_l2_base;
 static struct iommu_table iommu_table_iobmap;
 static int iommu_table_iobmap_inited;
=20
-static void iobmap_build(struct iommu_table *tbl, long index,
+static int iobmap_build(struct iommu_table *tbl, long index,
 			 long npages, unsigned long uaddr,
 			 enum dma_data_direction direction)
 {
@@ -107,6 +107,7 @@ static void iobmap_build(struct iommu_ta
 		uaddr +=3D IOBMAP_PAGE_SIZE;
 		bus_addr +=3D IOBMAP_PAGE_SIZE;
 	}
+	return 0;
 }
=20
=20
Index: b/arch/powerpc/platforms/pseries/iommu.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -25,6 +25,7 @@
  */
=20
 #include <linux/init.h>
+#include <linux/delay.h>
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
@@ -48,7 +49,7 @@
 #include "plpar_wrappers.h"
=20
=20
-static void tce_build_pSeries(struct iommu_table *tbl, long index,
+static int tce_build_pSeries(struct iommu_table *tbl, long index,
 			      long npages, unsigned long uaddr,
 			      enum dma_data_direction direction)
 {
@@ -71,6 +72,7 @@ static void tce_build_pSeries(struct iom
 		uaddr +=3D TCE_PAGE_SIZE;
 		tcep++;
 	}
+	return 0;
 }
=20
=20
@@ -93,13 +95,18 @@ static unsigned long tce_get_pseries(str
 	return *tcep;
 }
=20
-static void tce_build_pSeriesLP(struct iommu_table *tbl, long tcenum,
+static void tce_free_pSeriesLP(struct iommu_table*, long, long);
+static void tce_freemulti_pSeriesLP(struct iommu_table*, long, long);
+
+static int tce_build_pSeriesLP(struct iommu_table *tbl, long tcenum,
 				long npages, unsigned long uaddr,
 				enum dma_data_direction direction)
 {
-	u64 rc;
+	u64 rc =3D 0;
 	u64 proto_tce, tce;
 	u64 rpn;
+	int sleep_msecs, ret =3D 0;
+	long tcenum_start =3D tcenum, npages_start =3D npages;
=20
 	rpn =3D (virt_to_abs(uaddr)) >> TCE_SHIFT;
 	proto_tce =3D TCE_PCI_READ;
@@ -108,7 +115,21 @@ static void tce_build_pSeriesLP(struct i
=20
 	while (npages--) {
 		tce =3D proto_tce | (rpn & TCE_RPN_MASK) << TCE_RPN_SHIFT;
-		rc =3D plpar_tce_put((u64)tbl->it_index, (u64)tcenum << 12, tce);
+		do {
+			rc =3D plpar_tce_put((u64)tbl->it_index,
+			                   (u64)tcenum << 12, tce);
+			if (unlikely(H_IS_LONG_BUSY(rc))) {
+				sleep_msecs =3D plpar_get_longbusy_msecs(rc);
+				mdelay(sleep_msecs);
+			}
+		} while (unlikely(H_IS_LONG_BUSY(rc)));
+
+		if (unlikely(rc =3D=3D H_NOT_ENOUGH_RESOURCES)) {
+			ret =3D (int)rc;
+			tce_free_pSeriesLP(tbl, tcenum_start,
+			                   (npages_start - (npages + 1)));
+			break;
+		}
=20
 		if (rc && printk_ratelimit()) {
 			printk("tce_build_pSeriesLP: plpar_tce_put failed. rc=3D%ld\n", rc);
@@ -121,19 +142,22 @@ static void tce_build_pSeriesLP(struct i
 		tcenum++;
 		rpn++;
 	}
+	return ret;
 }
=20
 static DEFINE_PER_CPU(u64 *, tce_page) =3D NULL;
=20
-static void tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
+static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 				     long npages, unsigned long uaddr,
 				     enum dma_data_direction direction)
 {
-	u64 rc;
+	u64 rc =3D 0;
 	u64 proto_tce;
 	u64 *tcep;
 	u64 rpn;
 	long l, limit;
+	long tcenum_start =3D tcenum, npages_start =3D npages;
+	int sleep_msecs, ret =3D 0;
=20
 	if (npages =3D=3D 1)
 		return tce_build_pSeriesLP(tbl, tcenum, npages, uaddr,
@@ -171,15 +195,26 @@ static void tce_buildmulti_pSeriesLP(str
 			rpn++;
 		}
=20
-		rc =3D plpar_tce_put_indirect((u64)tbl->it_index,
-					    (u64)tcenum << 12,
-					    (u64)virt_to_abs(tcep),
-					    limit);
+		do {
+			rc =3D plpar_tce_put_indirect(tbl->it_index, tcenum << 12,
+						    virt_to_abs(tcep), limit);
+			if (unlikely(H_IS_LONG_BUSY(rc))) {
+				sleep_msecs =3D plpar_get_longbusy_msecs(rc);
+				mdelay(sleep_msecs);
+			}
+		} while (unlikely(H_IS_LONG_BUSY(rc)));
=20
 		npages -=3D limit;
 		tcenum +=3D limit;
 	} while (npages > 0 && !rc);
=20
+	if (unlikely(rc =3D=3D H_NOT_ENOUGH_RESOURCES)) {
+		ret =3D (int)rc;
+		tce_freemulti_pSeriesLP(tbl, tcenum_start,
+		                        (npages_start - (npages + limit)));
+		return ret;
+	}
+
 	if (rc && printk_ratelimit()) {
 		printk("tce_buildmulti_pSeriesLP: plpar_tce_put failed. rc=3D%ld\n", rc);
 		printk("\tindex   =3D 0x%lx\n", (u64)tbl->it_index);
@@ -187,14 +222,23 @@ static void tce_buildmulti_pSeriesLP(str
 		printk("\ttce[0] val =3D 0x%lx\n", tcep[0]);
 		show_stack(current, (unsigned long *)__get_SP());
 	}
+	return ret;
 }
=20
 static void tce_free_pSeriesLP(struct iommu_table *tbl, long tcenum, long =
npages)
 {
+	int sleep_msecs;
 	u64 rc;
=20
 	while (npages--) {
-		rc =3D plpar_tce_put((u64)tbl->it_index, (u64)tcenum << 12, 0);
+		do {
+			rc =3D plpar_tce_put((u64)tbl->it_index,
+			                   (u64)tcenum << 12, 0);
+			if (unlikely(H_IS_LONG_BUSY(rc))) {
+				sleep_msecs =3D plpar_get_longbusy_msecs(rc);
+				mdelay(sleep_msecs);
+			}
+		} while (unlikely(H_IS_LONG_BUSY(rc)));
=20
 		if (rc && printk_ratelimit()) {
 			printk("tce_free_pSeriesLP: plpar_tce_put failed. rc=3D%ld\n", rc);
@@ -210,9 +254,17 @@ static void tce_free_pSeriesLP(struct io
=20
 static void tce_freemulti_pSeriesLP(struct iommu_table *tbl, long tcenum, =
long npages)
 {
+	int sleep_msecs;
 	u64 rc;
=20
-	rc =3D plpar_tce_stuff((u64)tbl->it_index, (u64)tcenum << 12, 0, npages);
+	do {
+		rc =3D plpar_tce_stuff((u64)tbl->it_index,
+		                     (u64)tcenum << 12, 0, npages);
+		if (unlikely(H_IS_LONG_BUSY(rc))) {
+			sleep_msecs =3D plpar_get_longbusy_msecs(rc);
+			mdelay(sleep_msecs);
+		}
+	} while (unlikely(H_IS_LONG_BUSY(rc)));
=20
 	if (rc && printk_ratelimit()) {
 		printk("tce_freemulti_pSeriesLP: plpar_tce_stuff failed\n");
Index: b/arch/powerpc/sysdev/dart_iommu.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/powerpc/sysdev/dart_iommu.c
+++ b/arch/powerpc/sysdev/dart_iommu.c
@@ -147,7 +147,7 @@ static void dart_flush(struct iommu_tabl
 	}
 }
=20
-static void dart_build(struct iommu_table *tbl, long index,
+static int dart_build(struct iommu_table *tbl, long index,
 		       long npages, unsigned long uaddr,
 		       enum dma_data_direction direction)
 {
@@ -183,6 +183,7 @@ static void dart_build(struct iommu_tabl
 	} else {
 		dart_dirty =3D 1;
 	}
+	return 0;
 }
=20
=20
Index: b/include/asm-powerpc/machdep.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-powerpc/machdep.h
+++ b/include/asm-powerpc/machdep.h
@@ -76,7 +76,7 @@ struct machdep_calls {
 	 * destroyed as well */
 	void		(*hpte_clear_all)(void);
=20
-	void		(*tce_build)(struct iommu_table * tbl,
+	int		(*tce_build)(struct iommu_table * tbl,
 				     long index,
 				     long npages,
 				     unsigned long uaddr,
