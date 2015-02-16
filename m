Return-Path: <aik@ozlabs.ru>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 605DA1A02FA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 21:07:48 +1100 (AEDT)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Mon, 16 Feb 2015 20:07:47 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3E46E2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 21:07:44 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1GA7aoI44564524
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 21:07:44 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1GA7AKJ013571
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 21:07:10 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 05/28] vfio: powerpc/spapr: Move locked_vm accounting to
 helpers
Date: Mon, 16 Feb 2015 21:05:57 +1100
Message-Id: <1424081180-4494-6-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1424081180-4494-1-git-send-email-aik@ozlabs.ru>
References: <1424081180-4494-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There moves locked pages accounting to helpers.
Later they will be reused for Dynamic DMA windows (DDW).

This reworks debug messages to show the current value and the limit.

This stores the locked pages number in the container so when unlocking
the iommu table pointer won't be needed. This does not have an effect
now but it will with the multiple tables per container as then we will
allow attaching/detaching groups on fly and we may end up having
a container with no group attached but with the counter incremented.

While we are here, update the comment explaining why RLIMIT_MEMLOCK
might be required to be bigger than the guest RAM. This also prints
pid of the current process in pr_warn/pr_debug.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v4:
* new helpers do nothing if @npages == 0
* tce_iommu_disable() now can decrement the counter if the group was
detached (not possible now but will be in the future)
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 82 ++++++++++++++++++++++++++++---------
 1 file changed, 63 insertions(+), 19 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index c2ca38f..2beeae5 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -31,6 +31,51 @@
 static void tce_iommu_detach_group(void *iommu_data,
 		struct iommu_group *iommu_group);
 
+static long try_increment_locked_vm(long npages)
+{
+	long ret = 0, locked, lock_limit;
+
+	if (!current || !current->mm)
+		return -ESRCH; /* process exited */
+
+	if (!npages)
+		return 0;
+
+	down_write(&current->mm->mmap_sem);
+	locked = current->mm->locked_vm + npages;
+	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
+	if (locked > lock_limit && !capable(CAP_IPC_LOCK))
+		ret = -ENOMEM;
+	else
+		current->mm->locked_vm += npages;
+
+	pr_debug("[%d] RLIMIT_MEMLOCK +%ld %ld/%ld%s\n", current->pid,
+			npages << PAGE_SHIFT,
+			current->mm->locked_vm << PAGE_SHIFT,
+			rlimit(RLIMIT_MEMLOCK),
+			ret ? " - exceeded" : "");
+
+	up_write(&current->mm->mmap_sem);
+
+	return ret;
+}
+
+static void decrement_locked_vm(long npages)
+{
+	if (!current || !current->mm || !npages)
+		return; /* process exited */
+
+	down_write(&current->mm->mmap_sem);
+	if (npages > current->mm->locked_vm)
+		npages = current->mm->locked_vm;
+	current->mm->locked_vm -= npages;
+	pr_debug("[%d] RLIMIT_MEMLOCK -%ld %ld/%ld\n", current->pid,
+			npages << PAGE_SHIFT,
+			current->mm->locked_vm << PAGE_SHIFT,
+			rlimit(RLIMIT_MEMLOCK));
+	up_write(&current->mm->mmap_sem);
+}
+
 /*
  * VFIO IOMMU fd for SPAPR_TCE IOMMU implementation
  *
@@ -47,6 +92,7 @@ struct tce_container {
 	struct mutex lock;
 	struct iommu_table *tbl;
 	bool enabled;
+	unsigned long locked_pages;
 };
 
 static bool tce_page_is_contained(struct page *page, unsigned page_shift)
@@ -68,7 +114,7 @@ static bool tce_page_is_contained(struct page *page, unsigned page_shift)
 static int tce_iommu_enable(struct tce_container *container)
 {
 	int ret = 0;
-	unsigned long locked, lock_limit, npages;
+	unsigned long locked;
 	struct iommu_table *tbl = container->tbl;
 
 	if (!container->tbl)
@@ -97,21 +143,22 @@ static int tce_iommu_enable(struct tce_container *container)
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
-	down_write(&current->mm->mmap_sem);
-	npages = (tbl->it_size << tbl->it_page_shift) >> PAGE_SHIFT;
-	locked = current->mm->locked_vm + npages;
-	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
-	if (locked > lock_limit && !capable(CAP_IPC_LOCK)) {
-		pr_warn("RLIMIT_MEMLOCK (%ld) exceeded\n",
-				rlimit(RLIMIT_MEMLOCK));
-		ret = -ENOMEM;
-	} else {
+	locked = (tbl->it_size << tbl->it_page_shift) >> PAGE_SHIFT;
+	ret = try_increment_locked_vm(locked);
+	if (ret)
+		return ret;
 
-		current->mm->locked_vm += npages;
-		container->enabled = true;
-	}
-	up_write(&current->mm->mmap_sem);
+	container->locked_pages = locked;
+
+	container->enabled = true;
 
 	return ret;
 }
@@ -123,13 +170,10 @@ static void tce_iommu_disable(struct tce_container *container)
 
 	container->enabled = false;
 
-	if (!container->tbl || !current->mm)
+	if (!current->mm)
 		return;
 
-	down_write(&current->mm->mmap_sem);
-	current->mm->locked_vm -= (container->tbl->it_size <<
-			container->tbl->it_page_shift) >> PAGE_SHIFT;
-	up_write(&current->mm->mmap_sem);
+	decrement_locked_vm(container->locked_pages);
 }
 
 static void *tce_iommu_open(unsigned long arg)
-- 
2.0.0
