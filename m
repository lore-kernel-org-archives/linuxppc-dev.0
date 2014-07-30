Return-Path: <aik@ozlabs.ru>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 05B491A0866
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 19:31:50 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Wed, 30 Jul 2014 19:31:39 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 58BE02CE802D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 19:31:47 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6U9VNhW10682506
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 19:31:23 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6U9VkVJ000648
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 19:31:47 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 14/16] vfio: powerpc/spapr: Reuse locked_vm accounting
 helpers
Date: Wed, 30 Jul 2014 19:31:33 +1000
Message-Id: <1406712695-9491-15-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1406712695-9491-1-git-send-email-aik@ozlabs.ru>
References: <1406712695-9491-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Michael Ellerman <michael@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are helpers to account locked pages in locked_vm counter, this
reuses these helpers in VFIO-SPAPR-IOMMU driver.

While we are here, update the comment explaining why RLIMIT_MEMLOCK
might be required to be bigger than entire guest RAM.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v4:
* added comment explaining how big the ulimit should be
* used try_increment_locked_vm/decrement_locked_vm
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index d9845af..6ed0fc3 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -58,7 +58,6 @@ static void tce_iommu_take_ownership_notify(struct spapr_tce_iommu_group *data,
 static int tce_iommu_enable(struct tce_container *container)
 {
 	int ret = 0;
-	unsigned long locked, lock_limit, npages;
 	struct iommu_table *tbl;
 	struct spapr_tce_iommu_group *data;
 
@@ -92,24 +91,24 @@ static int tce_iommu_enable(struct tce_container *container)
 	 * Also we don't have a nice way to fail on H_PUT_TCE due to ulimits,
 	 * that would effectively kill the guest at random points, much better
 	 * enforcing the limit based on the max that the guest can map.
+	 *
+	 * Unfortunately at the moment it counts whole tables, no matter how
+	 * much memory the guest has. I.e. for 4GB guest and 4 IOMMU groups
+	 * each with 2GB DMA window, 8GB will be counted here. The reason for
+	 * this is that we cannot tell here the amount of RAM used by the guest
+	 * as this information is only available from KVM and VFIO is
+	 * KVM agnostic.
 	 */
 	tbl = data->ops->get_table(data, TCE_DEFAULT_WINDOW);
 	if (!tbl)
 		return -ENXIO;
 
-	down_write(&current->mm->mmap_sem);
-	npages = (tbl->it_size << IOMMU_PAGE_SHIFT_4K) >> PAGE_SHIFT;
-	locked = current->mm->locked_vm + npages;
-	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
-	if (locked > lock_limit && !capable(CAP_IPC_LOCK)) {
-		pr_warn("RLIMIT_MEMLOCK (%ld) exceeded\n",
-				rlimit(RLIMIT_MEMLOCK));
-		ret = -ENOMEM;
-	} else {
-		current->mm->locked_vm += npages;
-		container->enabled = true;
-	}
-	up_write(&current->mm->mmap_sem);
+	ret = try_increment_locked_vm((tbl->it_size << IOMMU_PAGE_SHIFT_4K) >>
+			PAGE_SHIFT);
+	if (ret)
+		return ret;
+
+	container->enabled = true;
 
 	return ret;
 }
@@ -135,10 +134,8 @@ static void tce_iommu_disable(struct tce_container *container)
 	if (!tbl)
 		return;
 
-	down_write(&current->mm->mmap_sem);
-	current->mm->locked_vm -= (tbl->it_size <<
-			IOMMU_PAGE_SHIFT_4K) >> PAGE_SHIFT;
-	up_write(&current->mm->mmap_sem);
+	decrement_locked_vm((tbl->it_size << IOMMU_PAGE_SHIFT_4K) >>
+			PAGE_SHIFT);
 }
 
 static void *tce_iommu_open(unsigned long arg)
-- 
2.0.0
