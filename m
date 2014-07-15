Return-Path: <aik@ozlabs.ru>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 154931A169D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:40:26 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 15 Jul 2014 19:40:25 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0DA4A2CE805E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:39:52 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6F9dZhS10354958
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:39:35 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6F9dpKi026501
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:39:51 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH QEMU 09/12] vfio: Enable DDW ioctls to VFIO IOMMU driver
Date: Tue, 15 Jul 2014 19:39:41 +1000
Message-Id: <1405417184-14333-10-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1405417184-14333-1-git-send-email-aik@ozlabs.ru>
References: <1405417184-14333-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
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
 hw/misc/vfio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/misc/vfio.c b/hw/misc/vfio.c
index 0b9eba0..e7b4d6e 100644
--- a/hw/misc/vfio.c
+++ b/hw/misc/vfio.c
@@ -4437,6 +4437,10 @@ int vfio_container_ioctl(AddressSpace *as, int32_t groupid,
     switch (req) {
     case VFIO_CHECK_EXTENSION:
     case VFIO_IOMMU_SPAPR_TCE_GET_INFO:
+    case VFIO_IOMMU_SPAPR_TCE_QUERY:
+    case VFIO_IOMMU_SPAPR_TCE_CREATE:
+    case VFIO_IOMMU_SPAPR_TCE_REMOVE:
+    case VFIO_IOMMU_SPAPR_TCE_RESET:
         break;
     default:
         /* Return an error on unknown requests */
-- 
2.0.0
