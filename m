Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B94322C009C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 11:55:26 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Fri, 23 Aug 2013 07:18:48 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 3FACE394004D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 07:25:05 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7N1tBZu44695784
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 07:25:11 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7N1tD0x012718
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 07:25:14 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: alex.williamson@redhat.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] iommu: WARN_ON when removing a device with no iommu_group
 associated
Date: Fri, 23 Aug 2013 09:55:11 +0800
Message-Id: <1377222911-12144-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, paulus@au1.ibm.com, benh@au1.ibm.com,
 Wei Yang <weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When removing a device from the system, iommu_group driver will try to
disconnect it from its group. While in some cases, one device may not
associated with any iommu_group. For example, not enough DMA address space.

In the generic bus notification, it will check dev->iommu_group before calling
iommu_group_remove_device(). While in some cases, developers may call
iommu_group_remove_device() in a different code path and without check. For
those devices with dev->iommu_group set to NULL, kernel will crash.

This patch gives a warning and return when trying to remove a device from an
iommu_group with dev->iommu_group set to NULL. This helps to indicate some bad
behavior and also guard the kernel.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/iommu/iommu.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index fbe9ca7..43396f0 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -379,6 +379,9 @@ void iommu_group_remove_device(struct device *dev)
 	struct iommu_group *group = dev->iommu_group;
 	struct iommu_device *tmp_device, *device = NULL;
 
+	if (WARN_ON(!group))
+		return;
+
 	/* Pre-notify listeners that a device is being removed. */
 	blocking_notifier_call_chain(&group->notifier,
 				     IOMMU_GROUP_NOTIFY_DEL_DEVICE, dev);
-- 
1.7.5.4
