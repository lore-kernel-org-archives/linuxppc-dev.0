Return-Path: <aik@ozlabs.ru>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C6A91A03DB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 21:08:11 +1100 (AEDT)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Mon, 16 Feb 2015 20:08:10 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 803CC3578052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 21:08:08 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1GA80Fn27263002
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 21:08:08 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1GA7YGm008640
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 21:07:34 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 17/28] powerpc/pseries/lpar: Enable VFIO
Date: Mon, 16 Feb 2015 21:06:09 +1100
Message-Id: <1424081180-4494-18-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1424081180-4494-1-git-send-email-aik@ozlabs.ru>
References: <1424081180-4494-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The previous patch introduced iommu_table_ops::exchange() callback
which effectively disabled VFIO on pseries. This implements exchange()
for pseries/lpar so VFIO can work in nested guests.

Since exchange() callback returns an old TCE, it has to call H_GET_TCE
for every TCE being put to the table so VFIO performance in guests
running under PR KVM is expected to be slower than in guests running under
HV KVM or bare metal hosts.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v5:
* added global lock for xchg operations
* added missing be64_to_cpu(oldtce)
---
 arch/powerpc/platforms/pseries/iommu.c | 44 ++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index f537e6e..a903a27 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -137,14 +137,25 @@ static void tce_freemulti_pSeriesLP(struct iommu_table*, long, long);
 
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
+	static spinlock_t get_tces_lock;
+	static bool get_tces_lock_initialized;
+
+	if (old_tces) {
+		if (!get_tces_lock_initialized) {
+			spin_lock_init(&get_tces_lock);
+			get_tces_lock_initialized = true;
+		}
+		spin_lock(&get_tces_lock);
+	}
 
 	rpn = __pa(uaddr) >> TCE_SHIFT;
 	proto_tce = TCE_PCI_READ;
@@ -153,6 +164,14 @@ static int tce_build_pSeriesLP(struct iommu_table *tbl, long tcenum,
 
 	while (npages--) {
 		tce = proto_tce | (rpn & TCE_RPN_MASK) << TCE_RPN_SHIFT;
+		if (old_tces) {
+			unsigned long oldtce = 0;
+
+			plpar_tce_get((u64)tbl->it_index, (u64)tcenum << 12,
+					&oldtce);
+			old_tces[i] = be64_to_cpu(oldtce);
+			i++;
+		}
 		rc = plpar_tce_put((u64)tbl->it_index, (u64)tcenum << 12, tce);
 
 		if (unlikely(rc == H_NOT_ENOUGH_RESOURCES)) {
@@ -173,13 +192,18 @@ static int tce_build_pSeriesLP(struct iommu_table *tbl, long tcenum,
 		tcenum++;
 		rpn++;
 	}
+
+	if (old_tces)
+		spin_unlock(&get_tces_lock);
+
 	return ret;
 }
 
 static DEFINE_PER_CPU(__be64 *, tce_page);
 
-static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
+static int tce_xchg_pSeriesLP(struct iommu_table *tbl, long tcenum,
 				     long npages, unsigned long uaddr,
+				     unsigned long *old_tces,
 				     enum dma_data_direction direction,
 				     struct dma_attrs *attrs)
 {
@@ -194,6 +218,7 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 
 	if ((npages == 1) || !firmware_has_feature(FW_FEATURE_MULTITCE)) {
 		return tce_build_pSeriesLP(tbl, tcenum, npages, uaddr,
+					   old_tces,
 		                           direction, attrs);
 	}
 
@@ -210,6 +235,7 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 		if (!tcep) {
 			local_irq_restore(flags);
 			return tce_build_pSeriesLP(tbl, tcenum, npages, uaddr,
+					    old_tces,
 					    direction, attrs);
 		}
 		__this_cpu_write(tce_page, tcep);
@@ -231,6 +257,10 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 		for (l = 0; l < limit; l++) {
 			tcep[l] = cpu_to_be64(proto_tce | (rpn & TCE_RPN_MASK) << TCE_RPN_SHIFT);
 			rpn++;
+			if (old_tces)
+				plpar_tce_get((u64)tbl->it_index,
+						(u64)(tcenum + l) << 12,
+						&old_tces[tcenum + l]);
 		}
 
 		rc = plpar_tce_put_indirect((u64)tbl->it_index,
@@ -261,6 +291,15 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 	return ret;
 }
 
+static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
+				     long npages, unsigned long uaddr,
+				     enum dma_data_direction direction,
+				     struct dma_attrs *attrs)
+{
+	return tce_xchg_pSeriesLP(tbl, tcenum, npages, uaddr, NULL,
+			direction, attrs);
+}
+
 static void tce_free_pSeriesLP(struct iommu_table *tbl, long tcenum, long npages)
 {
 	u64 rc;
@@ -634,6 +673,7 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
 
 struct iommu_table_ops iommu_table_lpar_multi_ops = {
 	.set = tce_buildmulti_pSeriesLP,
+	.exchange = tce_xchg_pSeriesLP,
 	.clear = tce_freemulti_pSeriesLP,
 	.get = tce_get_pSeriesLP
 };
-- 
2.0.0
