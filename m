Return-Path: <aik@ozlabs.ru>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9D5B21A0569
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:25 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Sat, 25 Apr 2015 22:16:25 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 875803578072
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:21 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3PCGDfj43122920
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:21 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3PCFll4027712
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:15:48 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v9 09/32] vfio: powerpc/spapr: Rework groups attaching
Date: Sat, 25 Apr 2015 22:14:33 +1000
Message-Id: <1429964096-11524-10-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is to make extended ownership and multiple groups support patches
simpler for review.

This should cause no behavioural change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
[aw: for the vfio related changes]
Acked-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 40 ++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 115d5e6..0fbe03e 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -460,16 +460,21 @@ static int tce_iommu_attach_group(void *iommu_data,
 				iommu_group_id(container->tbl->it_group),
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
-	} else {
-		ret = iommu_take_ownership(tbl);
-		if (!ret)
-			container->tbl = tbl;
+		goto unlock_exit;
 	}
 
+	ret = iommu_take_ownership(tbl);
+	if (!ret)
+		container->tbl = tbl;
+
+unlock_exit:
 	mutex_unlock(&container->lock);
 
 	return ret;
@@ -487,19 +492,22 @@ static void tce_iommu_detach_group(void *iommu_data,
 		pr_warn("tce_vfio: detaching group #%u, expected group is #%u\n",
 				iommu_group_id(iommu_group),
 				iommu_group_id(tbl->it_group));
-	} else {
-		if (container->enabled) {
-			pr_warn("tce_vfio: detaching group #%u from enabled container, forcing disable\n",
-					iommu_group_id(tbl->it_group));
-			tce_iommu_disable(container);
-		}
+		goto unlock_exit;
+	}
 
-		/* pr_debug("tce_vfio: detaching group #%u from iommu %p\n",
-				iommu_group_id(iommu_group), iommu_group); */
-		container->tbl = NULL;
-		tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
-		iommu_release_ownership(tbl);
+	if (container->enabled) {
+		pr_warn("tce_vfio: detaching group #%u from enabled container, forcing disable\n",
+				iommu_group_id(tbl->it_group));
+		tce_iommu_disable(container);
 	}
+
+	/* pr_debug("tce_vfio: detaching group #%u from iommu %p\n",
+	   iommu_group_id(iommu_group), iommu_group); */
+	container->tbl = NULL;
+	tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
+	iommu_release_ownership(tbl);
+
+unlock_exit:
 	mutex_unlock(&container->lock);
 }
 
-- 
2.0.0
