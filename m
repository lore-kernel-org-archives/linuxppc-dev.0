Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9DE052C0264
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 20:08:23 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Fri, 16 Aug 2013 15:31:58 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id D53A0394004E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 15:38:05 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7GA9bZn45678732
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 15:39:37 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7GA8Dnm025005
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 15:38:14 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] powerpc/iommu: check dev->iommu_group before remove a
 device from iommu_group
Date: Fri, 16 Aug 2013 18:08:07 +0800
Message-Id: <1376647687-20550-3-git-send-email-weiyang@linux.vnet.ibm.com>
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

---
 arch/powerpc/kernel/iommu.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index b20ff17..5abf7c3 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -1149,7 +1149,8 @@ static int iommu_bus_notifier(struct notifier_block *nb,
 	case BUS_NOTIFY_ADD_DEVICE:
 		return iommu_add_device(dev);
 	case BUS_NOTIFY_DEL_DEVICE:
-		iommu_del_device(dev);
+		if (dev->iommu_group)
+			iommu_del_device(dev);
 		return 0;
 	default:
 		return 0;
-- 
1.7.5.4
