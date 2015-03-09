Return-Path: <aik@ozlabs.ru>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 789A11A04BC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:08:53 +1100 (AEDT)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 10 Mar 2015 00:08:51 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 1BA342CE8060
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:08:49 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t29E8e0G27197494
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:08:48 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t29E8FSq013829
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:08:15 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 26/29] vfio: powerpc/spapr: Define v2 IOMMU
Date: Tue, 10 Mar 2015 01:07:22 +1100
Message-Id: <1425910045-26167-27-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1425910045-26167-1-git-send-email-aik@ozlabs.ru>
References: <1425910045-26167-1-git-send-email-aik@ozlabs.ru>
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

The existing IOMMU code takes/releases ownership over the existing IOMMU
tables created by the platform code, i.e. the tables remain in memory
all the time. Also, the existing IOMMU requires VFIO_IOMMU_ENABLE call to
start working as that's where we check the rlimit for locked pages.

New IOMMU will take over the IOMMU group completely which means the IOMMU
tables created by the platform code are going to be disposed and VFIO
will create its own tables. Also, with the DMA memory pre-registration
feature, the userspace will not need to call VFIO_IOMMU_ENABLE as
the locked pages accounting will be done by
VFIO_IOMMU_SPAPR_REGISTER_MEMORY.

In order to inform the userspace that VFIO supports new capabilities,
this adds a new SPAPR TCE IOMMU v2 type.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 3 ++-
 include/uapi/linux/vfio.h           | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index e572c28..d665ddc 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -404,7 +404,7 @@ static void *tce_iommu_open(unsigned long arg)
 {
 	struct tce_container *container;
 
-	if (arg != VFIO_SPAPR_TCE_IOMMU) {
+	if ((arg != VFIO_SPAPR_TCE_IOMMU) && (arg != VFIO_SPAPR_TCE_v2_IOMMU)) {
 		pr_err("tce_vfio: Wrong IOMMU type\n");
 		return ERR_PTR(-EINVAL);
 	}
@@ -588,6 +588,7 @@ static long tce_iommu_ioctl(void *iommu_data,
 	case VFIO_CHECK_EXTENSION:
 		switch (arg) {
 		case VFIO_SPAPR_TCE_IOMMU:
+		case VFIO_SPAPR_TCE_v2_IOMMU:
 			ret = 1;
 			break;
 		default:
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
