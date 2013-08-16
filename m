Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 80D062C0265
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 20:08:26 +1000 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Fri, 16 Aug 2013 15:30:43 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 05DF3394004E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 15:38:03 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7GA9YfC45482172
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 15:39:34 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7GA8BVB027672
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 15:38:11 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iommu: Don't remove device when no iommu_group associated
Date: Fri, 16 Aug 2013 18:08:06 +0800
Message-Id: <1376647687-20550-2-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1376647687-20550-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1376647687-20550-1-git-send-email-weiyang@linux.vnet.ibm.com>
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

In some cases, one device may not associated with any iommu_group.
For example, not enough DMA address space.

For those devices, kernel will crash when try to remove it from an iommu_group.

This patch do the check before remove it.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/iommu/iommu.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index fbe9ca7..fe41946 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -379,6 +379,9 @@ void iommu_group_remove_device(struct device *dev)
 	struct iommu_group *group = dev->iommu_group;
 	struct iommu_device *tmp_device, *device = NULL;
 
+	if (!group)
+		return;
+
 	/* Pre-notify listeners that a device is being removed. */
 	blocking_notifier_call_chain(&group->notifier,
 				     IOMMU_GROUP_NOTIFY_DEL_DEVICE, dev);
-- 
1.7.5.4
