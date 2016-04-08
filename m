Return-Path: <aik@ozlabs.ru>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qh6cS3r9NzDqBY
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Apr 2016 14:56:24 +1000 (AEST)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 8 Apr 2016 14:56:23 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A29452CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Apr 2016 14:55:49 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u384tWhx48300246
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Apr 2016 14:55:49 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u384t8PP006050
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Apr 2016 14:55:08 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, kvm@vger.kernel.org
Subject: [PATCH kernel] vfio_iommu_spapr_tce: Remove unneeded
 iommu_group_get_iommudata
Date: Fri,  8 Apr 2016 14:54:41 +1000
Message-Id: <1460091281-14664-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This removes iommu_group_get_iommudata() as the result is never used.
As this is a minor cleanup, no change in behavior is expected.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 0582b72..6419566 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -331,14 +331,12 @@ static void tce_iommu_free_table(struct iommu_table *tbl);
 static void tce_iommu_release(void *iommu_data)
 {
 	struct tce_container *container = iommu_data;
-	struct iommu_table_group *table_group;
 	struct tce_iommu_group *tcegrp;
 	long i;
 
 	while (tce_groups_attached(container)) {
 		tcegrp = list_first_entry(&container->group_list,
 				struct tce_iommu_group, next);
-		table_group = iommu_group_get_iommudata(tcegrp->grp);
 		tce_iommu_detach_group(iommu_data, tcegrp->grp);
 	}
 
-- 
2.5.0.rc3
