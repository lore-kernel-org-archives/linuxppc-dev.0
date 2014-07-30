Return-Path: <aik@ozlabs.ru>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5B3231A061E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 19:31:50 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Wed, 30 Jul 2014 19:31:48 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 413792CE802D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 19:31:46 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6U98jDx23855322
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 19:08:45 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6U9Vj7P031443
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 19:31:45 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 12/16] powerpc/pseries/lpar: Enable VFIO
Date: Wed, 30 Jul 2014 19:31:31 +1000
Message-Id: <1406712695-9491-13-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1406712695-9491-1-git-send-email-aik@ozlabs.ru>
References: <1406712695-9491-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Michael Ellerman <michael@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The previous patch introduced iommu_table_ops::set_and_get() callback
which effectively disabled VFIO on pseries. This implements set_and_get()
for pseries/lpar so VFIO can work under pHyp again.

Since set_and_get() callback must return old TCE, it has to do H_GET_TCE
for every TCE being replaced, therefore VFIO's performance under pHyp
is expected to be slow.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/pseries/iommu.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 793f002..d3cded1 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -138,13 +138,14 @@ static void tce_freemulti_pSeriesLP(struct iommu_table*, long, long);
 
 static int tce_build_pSeriesLP(struct iommu_table *tbl, long tcenum,
 				long npages, unsigned long uaddr,
+				unsigned long *old_tces,
 				enum dma_data_direction direction,
 				struct dma_attrs *attrs)
 {
 	u64 rc = 0;
 	u64 proto_tce, tce;
 	u64 rpn;
-	int ret = 0;
+	int ret = 0, i = 0;
 	long tcenum_start = tcenum, npages_start = npages;
 
 	rpn = __pa(uaddr) >> TCE_SHIFT;
@@ -154,6 +155,9 @@ static int tce_build_pSeriesLP(struct iommu_table *tbl, long tcenum,
 
 	while (npages--) {
 		tce = proto_tce | (rpn & TCE_RPN_MASK) << TCE_RPN_SHIFT;
+		if (old_tces)
+			plpar_tce_get((u64)tbl->it_index, (u64)tcenum << 12,
+					&old_tces[i++]);
 		rc = plpar_tce_put((u64)tbl->it_index, (u64)tcenum << 12, tce);
 
 		if (unlikely(rc == H_NOT_ENOUGH_RESOURCES)) {
@@ -179,8 +183,9 @@ static int tce_build_pSeriesLP(struct iommu_table *tbl, long tcenum,
 
 static DEFINE_PER_CPU(__be64 *, tce_page);
 
-static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
+static int tce_set_and_get_pSeriesLP(struct iommu_table *tbl, long tcenum,
 				     long npages, unsigned long uaddr,
+				     unsigned long *old_tces,
 				     enum dma_data_direction direction,
 				     struct dma_attrs *attrs)
 {
@@ -195,6 +200,7 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 
 	if ((npages == 1) || !firmware_has_feature(FW_FEATURE_MULTITCE)) {
 		return tce_build_pSeriesLP(tbl, tcenum, npages, uaddr,
+					   old_tces,
 		                           direction, attrs);
 	}
 
@@ -211,6 +217,7 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 		if (!tcep) {
 			local_irq_restore(flags);
 			return tce_build_pSeriesLP(tbl, tcenum, npages, uaddr,
+					    old_tces,
 					    direction, attrs);
 		}
 		__get_cpu_var(tce_page) = tcep;
@@ -232,6 +239,10 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 		for (l = 0; l < limit; l++) {
 			tcep[l] = cpu_to_be64(proto_tce | (rpn & TCE_RPN_MASK) << TCE_RPN_SHIFT);
 			rpn++;
+			if (old_tces)
+				plpar_tce_get((u64)tbl->it_index,
+						(u64)(tcenum + l) << 12,
+						&old_tces[tcenum + l]);
 		}
 
 		rc = plpar_tce_put_indirect((u64)tbl->it_index,
@@ -262,6 +273,15 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 	return ret;
 }
 
+static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
+				     long npages, unsigned long uaddr,
+				     enum dma_data_direction direction,
+				     struct dma_attrs *attrs)
+{
+	return tce_set_and_get_pSeriesLP(tbl, tcenum, npages, uaddr, NULL,
+			direction, attrs);
+}
+
 static void tce_free_pSeriesLP(struct iommu_table *tbl, long tcenum, long npages)
 {
 	u64 rc;
@@ -637,6 +657,7 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
 
 struct iommu_table_ops iommu_table_lpar_multi_ops = {
 	.set = tce_buildmulti_pSeriesLP,
+	.set_and_get = tce_set_and_get_pSeriesLP,
 	.clear = tce_freemulti_pSeriesLP,
 	.get = tce_get_pSeriesLP
 };
-- 
2.0.0
