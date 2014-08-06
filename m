Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 202EF1A0372
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 17:10:26 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 6 Aug 2014 17:10:25 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 863342BB0023
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 17:10:22 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s766lDdQ60358718
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Aug 2014 16:47:13 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s767ALcK014919
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Aug 2014 17:10:21 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc/powernv: Remove duplicate check in
 tce_iommu_bus_notifier()
Date: Wed,  6 Aug 2014 17:10:17 +1000
Message-Id: <1407309017-13870-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1407309017-13870-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1407309017-13870-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The called function iommu_del_device() checks if the device has
attached IOMMU group, we needn't check it again in the parent
function call tce_iommu_bus_notifier().

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index f91a4e5..b562b0d 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -820,17 +820,18 @@ static int tce_iommu_bus_notifier(struct notifier_block *nb,
 		unsigned long action, void *data)
 {
 	struct device *dev = data;
+	int ret = 0;
 
 	switch (action) {
 	case BUS_NOTIFY_ADD_DEVICE:
-		return iommu_add_device(dev);
+		ret = iommu_add_device(dev);
+		break;
 	case BUS_NOTIFY_DEL_DEVICE:
-		if (dev->iommu_group)
-			iommu_del_device(dev);
-		return 0;
-	default:
-		return 0;
+		iommu_del_device(dev);
+		break;
 	}
+
+	return ret;
 }
 
 static struct notifier_block tce_iommu_bus_nb = {
-- 
1.8.3.2
