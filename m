Return-Path: <aik@ozlabs.ru>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 579DC1A0A07
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 19:09:27 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 13 Mar 2015 18:09:26 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 0F5143578054
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 19:09:25 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2D89Gki42336322
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 19:09:24 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2D88p3p017143
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 19:08:51 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v6 26/29] vfio: powerpc/spapr: Define v2 IOMMU
Date: Fri, 13 Mar 2015 19:07:34 +1100
Message-Id: <1426234057-16165-27-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1426234057-16165-1-git-send-email-aik@ozlabs.ru>
References: <1426234057-16165-1-git-send-email-aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The existing IOMMU requires VFIO_IOMMU_ENABLE call to enable actual use
of the container (i.e. call DMA map/unmap) and this is where we check
the rlimit for locked pages. It assumes that only as much memory
as a default DMA window can be mapped. Every DMA map/unmap request will
do pinning/unpinning of physical pages.

New IOMMU will split physical pages pinning and TCE table update.
It will require guest pages to be registered first and consequent
map/unmap requests to work only with pre-registered memory.
For the default single window case this means that the entire guest
(instead of 2GB) needs to be pinned before using VFIO.
However when a huge DMA window is added, no additional pinning will be
required, otherwise it would be guest RAM + 2GB.

This advertises v2 SPAPR TCE IOMMU and restricts what the userspace
can do with v1 or v2 IOMMUs.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v6:
* enforced limitations imposed by the SPAPR TCE IOMMU version
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 18 +++++++++++++++++-
 include/uapi/linux/vfio.h           |  2 ++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 9d240b4..e191438 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -95,6 +95,7 @@ struct tce_container {
 	bool enabled;
 	unsigned long locked_pages;
 	struct list_head mem_list;
+	bool v2;
 };
 
 struct tce_memory {
@@ -398,7 +399,7 @@ static void *tce_iommu_open(unsigned long arg)
 {
 	struct tce_container *container;
 
-	if (arg != VFIO_SPAPR_TCE_IOMMU) {
+	if ((arg != VFIO_SPAPR_TCE_IOMMU) && (arg != VFIO_SPAPR_TCE_v2_IOMMU)) {
 		pr_err("tce_vfio: Wrong IOMMU type\n");
 		return ERR_PTR(-EINVAL);
 	}
@@ -410,6 +411,8 @@ static void *tce_iommu_open(unsigned long arg)
 	mutex_init(&container->lock);
 	INIT_LIST_HEAD_RCU(&container->mem_list);
 
+	container->v2 = arg == VFIO_SPAPR_TCE_v2_IOMMU;
+
 	return container;
 }
 
@@ -580,6 +583,7 @@ static long tce_iommu_ioctl(void *iommu_data,
 	case VFIO_CHECK_EXTENSION:
 		switch (arg) {
 		case VFIO_SPAPR_TCE_IOMMU:
+		case VFIO_SPAPR_TCE_v2_IOMMU:
 			ret = 1;
 			break;
 		default:
@@ -719,6 +723,9 @@ static long tce_iommu_ioctl(void *iommu_data,
 	case VFIO_IOMMU_SPAPR_REGISTER_MEMORY: {
 		struct vfio_iommu_spapr_register_memory param;
 
+		if (!container->v2)
+			return -EPERM;
+
 		minsz = offsetofend(struct vfio_iommu_spapr_register_memory,
 				size);
 
@@ -741,6 +748,9 @@ static long tce_iommu_ioctl(void *iommu_data,
 	case VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY: {
 		struct vfio_iommu_spapr_register_memory param;
 
+		if (!container->v2)
+			return -EPERM;
+
 		minsz = offsetofend(struct vfio_iommu_spapr_register_memory,
 				size);
 
@@ -761,6 +771,9 @@ static long tce_iommu_ioctl(void *iommu_data,
 		return 0;
 	}
 	case VFIO_IOMMU_ENABLE:
+		if (container->v2)
+			return -EPERM;
+
 		mutex_lock(&container->lock);
 		ret = tce_iommu_enable(container);
 		mutex_unlock(&container->lock);
@@ -768,6 +781,9 @@ static long tce_iommu_ioctl(void *iommu_data,
 
 
 	case VFIO_IOMMU_DISABLE:
+		if (container->v2)
+			return -EPERM;
+
 		mutex_lock(&container->lock);
 		tce_iommu_disable(container);
 		mutex_unlock(&container->lock);
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index b17e120..fbc5286 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -36,6 +36,8 @@
 /* Two-stage IOMMU */
 #define VFIO_TYPE1_NESTING_IOMMU	6	/* Implies v2 */
 
+#define VFIO_SPAPR_TCE_v2_IOMMU		7
+
 /*
  * The IOCTL interface is designed for extensibility by embedding the
  * structure length (argsz) and flags into structures passed between
-- 
2.0.0
