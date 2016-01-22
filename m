Return-Path: <aik@ozlabs.ru>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B66ED1A0562
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jan 2016 17:36:13 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 22 Jan 2016 16:36:00 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3D9372BB004D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jan 2016 17:35:57 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0M6ZiM766650358
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jan 2016 17:35:57 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0M6ZK4Z027192
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jan 2016 17:35:20 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH kernel] vfio: Only check for bus IOMMU when NOIOMMU is selected
Date: Fri, 22 Jan 2016 17:34:54 +1100
Message-Id: <1453444494-46900-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Recent change 03a76b60 "vfio: Include No-IOMMU mode" disabled VFIO
on systems which do not implement iommu_ops for the PCI bus even though
there is an VFIO IOMMU driver for it such as SPAPR TCE driver for
PPC64/powernv platform.

This moves iommu_present() call under #ifdef CONFIG_VFIO_NOIOMMU as
it is done in the rest of the file to re-enable VFIO on powernv.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 drivers/vfio/vfio.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index 82f25cc..3f8060e 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -343,7 +343,6 @@ static struct vfio_group *vfio_create_group(struct iommu_group *iommu_group,
 	atomic_set(&group->opened, 0);
 	group->iommu_group = iommu_group;
 	group->noiommu = !iommu_present;
-
 	group->nb.notifier_call = vfio_iommu_group_notifier;
 
 	/*
@@ -767,7 +766,11 @@ int vfio_add_group_dev(struct device *dev,
 
 	group = vfio_group_get_from_iommu(iommu_group);
 	if (!group) {
+#ifdef CONFIG_VFIO_NOIOMMU
 		group = vfio_create_group(iommu_group, iommu_present(dev->bus));
+#else
+		group = vfio_create_group(iommu_group, true);
+#endif
 		if (IS_ERR(group)) {
 			iommu_group_put(iommu_group);
 			return PTR_ERR(group);
-- 
2.5.0.rc3
