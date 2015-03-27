Return-Path: <aik@ozlabs.ru>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9C9251A02F6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 01:56:57 +1100 (AEDT)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Sat, 28 Mar 2015 00:56:57 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 4C5862CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 01:56:53 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2REujo746596340
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 01:56:53 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2REuJCV030983
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 01:56:20 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v7 08/31] vfio: powerpc/spapr: Rework groups attaching
Date: Sat, 28 Mar 2015 01:54:52 +1100
Message-Id: <1427468115-2224-9-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1427468115-2224-1-git-send-email-aik@ozlabs.ru>
References: <1427468115-2224-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
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

This is to make extended ownership and multiple groups support patches
simpler for review.

This is a mechanical patch.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 38 ++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index ec5ee83..244c958 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -478,16 +478,21 @@ static int tce_iommu_attach_group(void *iommu_data,
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
@@ -505,18 +510,21 @@ static void tce_iommu_detach_group(void *iommu_data,
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
+	iommu_release_ownership(tbl);
+
+unlock_exit:
 	mutex_unlock(&container->lock);
 }
 
-- 
2.0.0
