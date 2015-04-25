Return-Path: <aik@ozlabs.ru>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C24431A0408
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:47 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Sat, 25 Apr 2015 22:16:47 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 6F178357805A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:44 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3PCGab234013214
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:44 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3PCGAYI028570
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:11 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v9 30/32] vfio: powerpc/spapr: Use 32bit DMA window
 properties from table_group
Date: Sat, 25 Apr 2015 22:14:54 +1000
Message-Id: <1429964096-11524-31-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A table group might not have a table but it always has the default 32bit
window parameters so use these.

No change in behavior is expected.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v9:
* new in the series - to make the next patch simpler
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 4cfc2c1..a7d6729 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -185,7 +185,6 @@ static int tce_iommu_enable(struct tce_container *container)
 {
 	int ret = 0;
 	unsigned long locked;
-	struct iommu_table *tbl;
 	struct iommu_table_group *table_group;
 
 	if (!container->grp)
@@ -221,13 +220,19 @@ static int tce_iommu_enable(struct tce_container *container)
 	 * this is that we cannot tell here the amount of RAM used by the guest
 	 * as this information is only available from KVM and VFIO is
 	 * KVM agnostic.
+	 *
+	 * So we do not allow enabling a container without a group attached
+	 * as there is no way to know how much we should increment
+	 * the locked_vm counter.
 	 */
 	table_group = iommu_group_get_iommudata(container->grp);
 	if (!table_group)
 		return -ENODEV;
 
-	tbl = &table_group->tables[0];
-	locked = (tbl->it_size << tbl->it_page_shift) >> PAGE_SHIFT;
+	if (!table_group->tce32_size)
+		return -EPERM;
+
+	locked = table_group->tce32_size >> PAGE_SHIFT;
 	ret = try_increment_locked_vm(locked);
 	if (ret)
 		return ret;
@@ -504,7 +509,6 @@ static long tce_iommu_ioctl(void *iommu_data,
 
 	case VFIO_IOMMU_SPAPR_TCE_GET_INFO: {
 		struct vfio_iommu_spapr_tce_info info;
-		struct iommu_table *tbl;
 		struct iommu_table_group *table_group;
 
 		if (WARN_ON(!container->grp))
@@ -512,8 +516,7 @@ static long tce_iommu_ioctl(void *iommu_data,
 
 		table_group = iommu_group_get_iommudata(container->grp);
 
-		tbl = &table_group->tables[0];
-		if (WARN_ON_ONCE(!tbl))
+		if (!table_group)
 			return -ENXIO;
 
 		minsz = offsetofend(struct vfio_iommu_spapr_tce_info,
@@ -525,8 +528,8 @@ static long tce_iommu_ioctl(void *iommu_data,
 		if (info.argsz < minsz)
 			return -EINVAL;
 
-		info.dma32_window_start = tbl->it_offset << tbl->it_page_shift;
-		info.dma32_window_size = tbl->it_size << tbl->it_page_shift;
+		info.dma32_window_start = table_group->tce32_start;
+		info.dma32_window_size = table_group->tce32_size;
 		info.flags = 0;
 
 		if (copy_to_user((void __user *)arg, &info, minsz))
-- 
2.0.0
