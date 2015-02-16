Return-Path: <aik@ozlabs.ru>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ED3CB1A01AA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 21:08:10 +1100 (AEDT)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Mon, 16 Feb 2015 20:08:10 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E8BC52BB005E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 21:08:08 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1GA801J42729558
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 21:08:08 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1GA7ZOC021625
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 21:07:35 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 26/28] vfio: powerpc/spapr: Rework an IOMMU group
 attach/detach
Date: Mon, 16 Feb 2015 21:06:18 +1100
Message-Id: <1424081180-4494-27-git-send-email-aik@ozlabs.ru>
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

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 62 +++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 24 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index fdcc04c..4ff8289 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -435,7 +435,7 @@ static void tce_iommu_release(void *iommu_data)
 		iommu = iommu_group_get_iommudata(container->grp);
 		tbl = &iommu->tables[0];
 		tce_iommu_clear(container, tbl,	tbl->it_offset, tbl->it_size);
-
+		iommu->ops->free_table(tbl);
 		tce_iommu_detach_group(iommu_data, container->grp);
 	}
 
@@ -796,6 +796,7 @@ static int tce_iommu_attach_group(void *iommu_data,
 	int ret = 0;
 	struct tce_container *container = iommu_data;
 	struct powerpc_iommu *iommu;
+	struct iommu_table tbltmp = { 0 }, *tbl = &tbltmp;
 
 	mutex_lock(&container->lock);
 
@@ -806,35 +807,44 @@ static int tce_iommu_attach_group(void *iommu_data,
 				iommu_group_id(container->grp),
 				iommu_group_id(iommu_group));
 		ret = -EBUSY;
-	} else if (container->enabled) {
+		goto unlock_exit;
+	}
+
+	if (container->enabled) {
 		pr_err("tce_vfio: attaching group #%u to enabled container\n",
 				iommu_group_id(iommu_group));
 		ret = -EBUSY;
+		goto unlock_exit;
+	}
+
+	iommu = iommu_group_get_iommudata(iommu_group);
+	if (WARN_ON_ONCE(!iommu)) {
+		ret = -ENXIO;
+		goto unlock_exit;
+	}
+
+	/*
+	 * Disable iommu bypass, otherwise the user can DMA to all of
+	 * our physical memory via the bypass window instead of just
+	 * the pages that has been explicitly mapped into the iommu
+	 */
+	if (iommu->ops && iommu->ops->set_ownership) {
+		iommu->ops->set_ownership(iommu, true);
 	} else {
-		iommu = iommu_group_get_iommudata(iommu_group);
-		if (WARN_ON_ONCE(!iommu)) {
-			ret = -ENXIO;
-		} else if (iommu->ops && iommu->ops->set_ownership) {
-			/*
-			 * Disable iommu bypass, otherwise the user can DMA to all of
-			 * our physical memory via the bypass window instead of just
-			 * the pages that has been explicitly mapped into the iommu
-			 */
-			struct iommu_table tbltmp = { 0 }, *tbl = &tbltmp;
-
-			iommu->ops->set_ownership(iommu, true);
-			container->grp = iommu_group;
-
-			ret = iommu->ops->create_table(iommu, 0,
-					IOMMU_PAGE_SHIFT_4K,
-					ilog2(iommu->tce32_size), 1, tbl);
-			if (!ret)
-				ret = iommu->ops->set_window(iommu, 0, tbl);
-		} else {
-			ret = -ENODEV;
-		}
+		ret = -ENODEV;
+		goto unlock_exit;
 	}
 
+	container->grp = iommu_group;
+
+	/* Create the default window as only now we know the parameters */
+	ret = iommu->ops->create_table(iommu, 0,
+			IOMMU_PAGE_SHIFT_4K,
+			ilog2(iommu->tce32_size), 1, tbl);
+	if (!ret)
+		ret = iommu->ops->set_window(iommu, 0, tbl);
+
+unlock_exit:
 	mutex_unlock(&container->lock);
 
 	return ret;
@@ -845,6 +855,7 @@ static void tce_iommu_detach_group(void *iommu_data,
 {
 	struct tce_container *container = iommu_data;
 	struct powerpc_iommu *iommu;
+	long i;
 
 	mutex_lock(&container->lock);
 	if (iommu_group != container->grp) {
@@ -865,6 +876,9 @@ static void tce_iommu_detach_group(void *iommu_data,
 		iommu = iommu_group_get_iommudata(iommu_group);
 		BUG_ON(!iommu);
 
+		for (i = 0; i < POWERPC_IOMMU_MAX_TABLES; ++i)
+			iommu->ops->unset_window(iommu, i);
+
 		/* Kernel owns the device now, we can restore bypass */
 		if (iommu->ops && iommu->ops->set_ownership)
 			iommu->ops->set_ownership(iommu, false);
-- 
2.0.0
