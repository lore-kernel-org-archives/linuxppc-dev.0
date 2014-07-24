Return-Path: <aik@ozlabs.ru>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 117D51A0949
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 18:48:25 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Thu, 24 Jul 2014 18:48:19 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 668D12BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 18:48:22 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6O8PTOe8126476
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 18:25:29 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6O8mLwp030439
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 18:48:21 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 13/18] powerpc/iommu: Extend ppc_md.tce_build(_rm) to
 return old TCE values
Date: Thu, 24 Jul 2014 18:48:06 +1000
Message-Id: <1406191691-31441-14-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1406191691-31441-1-git-send-email-aik@ozlabs.ru>
References: <1406191691-31441-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The tce_build/tce_build_rm callbacks are used to implement H_PUT_TCE/etc
hypercalls. The PAPR spec does not allow to fail if the TCE is not empty.
However we cannot just overwrite the existing TCE value with the new one
as we still have to do page counting.

This adds an optional @old_tces return parameter. If it is not NULL,
it must point to an array of @npages size where the callbacks will
store old TCE values. Since tce_build receives virtual addresses,
the old_tces array will contain virtual addresses as well.

As this patch is mechanical, no change in behaviour is expected.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/machdep.h     |  2 ++
 arch/powerpc/kernel/iommu.c            |  8 +++++---
 arch/powerpc/platforms/powernv/pci.c   | 13 ++++++++-----
 arch/powerpc/platforms/pseries/iommu.c |  7 +++++--
 arch/powerpc/sysdev/dart_iommu.c       |  1 +
 5 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index f92b0b5..f11596c 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -69,6 +69,7 @@ struct machdep_calls {
 				     long index,
 				     long npages,
 				     unsigned long uaddr,
+				     unsigned long *old_tces,
 				     enum dma_data_direction direction,
 				     struct dma_attrs *attrs);
 	void		(*tce_free)(struct iommu_table *tbl,
@@ -83,6 +84,7 @@ struct machdep_calls {
 				     long index,
 				     long npages,
 				     unsigned long uaddr,
+				     long *old_tces,
 				     enum dma_data_direction direction,
 				     struct dma_attrs *attrs);
 	void		(*tce_free_rm)(struct iommu_table *tbl,
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 5af2319..ccf7510 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -324,7 +324,8 @@ static dma_addr_t iommu_alloc(struct device *dev, struct iommu_table *tbl,
 	/* Put the TCEs in the HW table */
 	build_fail = ppc_md.tce_build(tbl, entry, npages,
 				      (unsigned long)page &
-				      IOMMU_PAGE_MASK(tbl), direction, attrs);
+				      IOMMU_PAGE_MASK(tbl), NULL, direction,
+				      attrs);
 
 	/* ppc_md.tce_build() only returns non-zero for transient errors.
 	 * Clean up the table bitmap in this case and return
@@ -497,7 +498,7 @@ int iommu_map_sg(struct device *dev, struct iommu_table *tbl,
 		/* Insert into HW table */
 		build_fail = ppc_md.tce_build(tbl, entry, npages,
 					      vaddr & IOMMU_PAGE_MASK(tbl),
-					      direction, attrs);
+					      NULL, direction, attrs);
 		if(unlikely(build_fail))
 			goto failure;
 
@@ -1059,7 +1060,8 @@ int iommu_tce_build(struct iommu_table *tbl, unsigned long entry,
 	oldtce = ppc_md.tce_get(tbl, entry);
 	/* Add new entry if it is not busy */
 	if (!(oldtce & (TCE_PCI_WRITE | TCE_PCI_READ)))
-		ret = ppc_md.tce_build(tbl, entry, 1, hwaddr, direction, NULL);
+		ret = ppc_md.tce_build(tbl, entry, 1, hwaddr, NULL,
+				direction, NULL);
 
 	spin_unlock(&(pool->lock));
 
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index cc54e3b..4b764c2 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -572,7 +572,8 @@ static void pnv_tce_invalidate(struct iommu_table *tbl, __be64 *startp,
 }
 
 static int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
-			 unsigned long uaddr, enum dma_data_direction direction,
+			 unsigned long uaddr, unsigned long *old_tces,
+			 enum dma_data_direction direction,
 			 struct dma_attrs *attrs, bool rm)
 {
 	u64 proto_tce;
@@ -597,12 +598,12 @@ static int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
 }
 
 static int pnv_tce_build_vm(struct iommu_table *tbl, long index, long npages,
-			    unsigned long uaddr,
+			    unsigned long uaddr, unsigned long *old_tces,
 			    enum dma_data_direction direction,
 			    struct dma_attrs *attrs)
 {
-	return pnv_tce_build(tbl, index, npages, uaddr, direction, attrs,
-			false);
+	return pnv_tce_build(tbl, index, npages, uaddr, old_tces, direction,
+			attrs, false);
 }
 
 static void pnv_tce_free(struct iommu_table *tbl, long index, long npages,
@@ -630,10 +631,12 @@ static unsigned long pnv_tce_get(struct iommu_table *tbl, long index)
 
 static int pnv_tce_build_rm(struct iommu_table *tbl, long index, long npages,
 			    unsigned long uaddr,
+			    long *old_tces,
 			    enum dma_data_direction direction,
 			    struct dma_attrs *attrs)
 {
-	return pnv_tce_build(tbl, index, npages, uaddr, direction, attrs, true);
+	return pnv_tce_build(tbl, index, npages, uaddr, old_tces, direction,
+			attrs, true);
 }
 
 static void pnv_tce_free_rm(struct iommu_table *tbl, long index, long npages)
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index a047754..6c70b7c 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -82,6 +82,7 @@ static void tce_invalidate_pSeries_sw(struct iommu_table *tbl,
 
 static int tce_build_pSeries(struct iommu_table *tbl, long index,
 			      long npages, unsigned long uaddr,
+			      unsigned long *old_tces,
 			      enum dma_data_direction direction,
 			      struct dma_attrs *attrs)
 {
@@ -138,6 +139,7 @@ static void tce_freemulti_pSeriesLP(struct iommu_table*, long, long);
 
 static int tce_build_pSeriesLP(struct iommu_table *tbl, long tcenum,
 				long npages, unsigned long uaddr,
+				unsigned long *old_tces,
 				enum dma_data_direction direction,
 				struct dma_attrs *attrs)
 {
@@ -181,6 +183,7 @@ static DEFINE_PER_CPU(__be64 *, tce_page);
 
 static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 				     long npages, unsigned long uaddr,
+				     unsigned long *old_tces,
 				     enum dma_data_direction direction,
 				     struct dma_attrs *attrs)
 {
@@ -195,7 +198,7 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 
 	if (npages == 1) {
 		return tce_build_pSeriesLP(tbl, tcenum, npages, uaddr,
-		                           direction, attrs);
+					   old_tces, direction, attrs);
 	}
 
 	local_irq_save(flags);	/* to protect tcep and the page behind it */
@@ -211,7 +214,7 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 		if (!tcep) {
 			local_irq_restore(flags);
 			return tce_build_pSeriesLP(tbl, tcenum, npages, uaddr,
-					    direction, attrs);
+					    old_tces, direction, attrs);
 		}
 		__get_cpu_var(tce_page) = tcep;
 	}
diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
index 9e5353f..0d3cf7c 100644
--- a/arch/powerpc/sysdev/dart_iommu.c
+++ b/arch/powerpc/sysdev/dart_iommu.c
@@ -162,6 +162,7 @@ static void dart_flush(struct iommu_table *tbl)
 
 static int dart_build(struct iommu_table *tbl, long index,
 		       long npages, unsigned long uaddr,
+		       unsigned long *old_tces,
 		       enum dma_data_direction direction,
 		       struct dma_attrs *attrs)
 {
-- 
2.0.0
