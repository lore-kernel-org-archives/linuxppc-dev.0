Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [83.169.36.222])
 by lists.ozlabs.org (Postfix) with ESMTP id 3t2RpH0hWFzDvfP
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 17:53:59 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH kernel v4 3/4] vfio/spapr: Reference mm in tce_container
Date: Mon, 24 Oct 2016 17:53:09 +1100
Message-Id: <1477291990-2872-4-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1477291990-2872-1-git-send-email-aik@ozlabs.ru>
References: <1477291990-2872-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In some situations the userspace memory context may live longer than
the userspace process itself so if we need to do proper memory context
cleanup, we better have tce_container take a reference to mm_struct and
use it later when the process is gone (@current or @current->mm is NULL).

This references mm and stores the pointer in the container; this is done
when a container is just created so checking for !current->mm in other
places becomes pointless.

This replaces current->mm with container->mm everywhere except debug
prints.

This adds a check that current->mm is the same as the one stored in
the container to prevent userspace from making changes to a memory
context of other processes; in order to add this check,
VFIO_CHECK_EXTENSION is moved out of the switch(cmd) as it is
quite special anyway - it is the only ioctl() called when neither
container nor container->mm is initialized.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v4:
* added check for container->mm!=current->mm in tce_iommu_ioctl()
for all ioctls and removed other redundand checks
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 131 ++++++++++++++++++------------------
 1 file changed, 66 insertions(+), 65 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index d0c38b2..81ab93f 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -31,49 +31,46 @@
 static void tce_iommu_detach_group(void *iommu_data,
 		struct iommu_group *iommu_group);
 
-static long try_increment_locked_vm(long npages)
+static long try_increment_locked_vm(struct mm_struct *mm, long npages)
 {
 	long ret = 0, locked, lock_limit;
 
-	if (!current || !current->mm)
-		return -ESRCH; /* process exited */
-
 	if (!npages)
 		return 0;
 
-	down_write(&current->mm->mmap_sem);
-	locked = current->mm->locked_vm + npages;
+	down_write(&mm->mmap_sem);
+	locked = mm->locked_vm + npages;
 	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
 	if (locked > lock_limit && !capable(CAP_IPC_LOCK))
 		ret = -ENOMEM;
 	else
-		current->mm->locked_vm += npages;
+		mm->locked_vm += npages;
 
 	pr_debug("[%d] RLIMIT_MEMLOCK +%ld %ld/%ld%s\n", current->pid,
 			npages << PAGE_SHIFT,
-			current->mm->locked_vm << PAGE_SHIFT,
+			mm->locked_vm << PAGE_SHIFT,
 			rlimit(RLIMIT_MEMLOCK),
 			ret ? " - exceeded" : "");
 
-	up_write(&current->mm->mmap_sem);
+	up_write(&mm->mmap_sem);
 
 	return ret;
 }
 
-static void decrement_locked_vm(long npages)
+static void decrement_locked_vm(struct mm_struct *mm, long npages)
 {
-	if (!current || !current->mm || !npages)
-		return; /* process exited */
+	if (!npages)
+		return;
 
-	down_write(&current->mm->mmap_sem);
-	if (WARN_ON_ONCE(npages > current->mm->locked_vm))
-		npages = current->mm->locked_vm;
-	current->mm->locked_vm -= npages;
+	down_write(&mm->mmap_sem);
+	if (WARN_ON_ONCE(npages > mm->locked_vm))
+		npages = mm->locked_vm;
+	mm->locked_vm -= npages;
 	pr_debug("[%d] RLIMIT_MEMLOCK -%ld %ld/%ld\n", current->pid,
 			npages << PAGE_SHIFT,
-			current->mm->locked_vm << PAGE_SHIFT,
+			mm->locked_vm << PAGE_SHIFT,
 			rlimit(RLIMIT_MEMLOCK));
-	up_write(&current->mm->mmap_sem);
+	up_write(&mm->mmap_sem);
 }
 
 /*
@@ -98,6 +95,7 @@ struct tce_container {
 	bool enabled;
 	bool v2;
 	unsigned long locked_pages;
+	struct mm_struct *mm;
 	struct iommu_table *tables[IOMMU_TABLE_GROUP_MAX_TABLES];
 	struct list_head group_list;
 };
@@ -107,17 +105,14 @@ static long tce_iommu_unregister_pages(struct tce_container *container,
 {
 	struct mm_iommu_table_group_mem_t *mem;
 
-	if (!current || !current->mm)
-		return -ESRCH; /* process exited */
-
 	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK))
 		return -EINVAL;
 
-	mem = mm_iommu_find(current->mm, vaddr, size >> PAGE_SHIFT);
+	mem = mm_iommu_find(container->mm, vaddr, size >> PAGE_SHIFT);
 	if (!mem)
 		return -ENOENT;
 
-	return mm_iommu_put(current->mm, mem);
+	return mm_iommu_put(container->mm, mem);
 }
 
 static long tce_iommu_register_pages(struct tce_container *container,
@@ -127,14 +122,11 @@ static long tce_iommu_register_pages(struct tce_container *container,
 	struct mm_iommu_table_group_mem_t *mem = NULL;
 	unsigned long entries = size >> PAGE_SHIFT;
 
-	if (!current || !current->mm)
-		return -ESRCH; /* process exited */
-
 	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK) ||
 			((vaddr + size) < vaddr))
 		return -EINVAL;
 
-	ret = mm_iommu_get(current->mm, vaddr, entries, &mem);
+	ret = mm_iommu_get(container->mm, vaddr, entries, &mem);
 	if (ret)
 		return ret;
 
@@ -143,7 +135,8 @@ static long tce_iommu_register_pages(struct tce_container *container,
 	return 0;
 }
 
-static long tce_iommu_userspace_view_alloc(struct iommu_table *tbl)
+static long tce_iommu_userspace_view_alloc(struct iommu_table *tbl,
+		struct mm_struct *mm)
 {
 	unsigned long cb = _ALIGN_UP(sizeof(tbl->it_userspace[0]) *
 			tbl->it_size, PAGE_SIZE);
@@ -152,13 +145,13 @@ static long tce_iommu_userspace_view_alloc(struct iommu_table *tbl)
 
 	BUG_ON(tbl->it_userspace);
 
-	ret = try_increment_locked_vm(cb >> PAGE_SHIFT);
+	ret = try_increment_locked_vm(mm, cb >> PAGE_SHIFT);
 	if (ret)
 		return ret;
 
 	uas = vzalloc(cb);
 	if (!uas) {
-		decrement_locked_vm(cb >> PAGE_SHIFT);
+		decrement_locked_vm(mm, cb >> PAGE_SHIFT);
 		return -ENOMEM;
 	}
 	tbl->it_userspace = uas;
@@ -166,7 +159,8 @@ static long tce_iommu_userspace_view_alloc(struct iommu_table *tbl)
 	return 0;
 }
 
-static void tce_iommu_userspace_view_free(struct iommu_table *tbl)
+static void tce_iommu_userspace_view_free(struct iommu_table *tbl,
+		struct mm_struct *mm)
 {
 	unsigned long cb = _ALIGN_UP(sizeof(tbl->it_userspace[0]) *
 			tbl->it_size, PAGE_SIZE);
@@ -176,7 +170,7 @@ static void tce_iommu_userspace_view_free(struct iommu_table *tbl)
 
 	vfree(tbl->it_userspace);
 	tbl->it_userspace = NULL;
-	decrement_locked_vm(cb >> PAGE_SHIFT);
+	decrement_locked_vm(mm, cb >> PAGE_SHIFT);
 }
 
 static bool tce_page_is_contained(struct page *page, unsigned page_shift)
@@ -236,9 +230,6 @@ static int tce_iommu_enable(struct tce_container *container)
 	struct iommu_table_group *table_group;
 	struct tce_iommu_group *tcegrp;
 
-	if (!current->mm)
-		return -ESRCH; /* process exited */
-
 	if (container->enabled)
 		return -EBUSY;
 
@@ -284,7 +275,7 @@ static int tce_iommu_enable(struct tce_container *container)
 		return -EPERM;
 
 	locked = table_group->tce32_size >> PAGE_SHIFT;
-	ret = try_increment_locked_vm(locked);
+	ret = try_increment_locked_vm(container->mm, locked);
 	if (ret)
 		return ret;
 
@@ -302,10 +293,7 @@ static void tce_iommu_disable(struct tce_container *container)
 
 	container->enabled = false;
 
-	if (!current->mm)
-		return;
-
-	decrement_locked_vm(container->locked_pages);
+	decrement_locked_vm(container->mm, container->locked_pages);
 }
 
 static void *tce_iommu_open(unsigned long arg)
@@ -326,13 +314,18 @@ static void *tce_iommu_open(unsigned long arg)
 
 	container->v2 = arg == VFIO_SPAPR_TCE_v2_IOMMU;
 
+	/* current->mm cannot be NULL in this context */
+	container->mm = current->mm;
+	atomic_inc(&container->mm->mm_count);
+
 	return container;
 }
 
 static int tce_iommu_clear(struct tce_container *container,
 		struct iommu_table *tbl,
 		unsigned long entry, unsigned long pages);
-static void tce_iommu_free_table(struct iommu_table *tbl);
+static void tce_iommu_free_table(struct tce_container *container,
+		struct iommu_table *tbl);
 
 static void tce_iommu_release(void *iommu_data)
 {
@@ -357,10 +350,11 @@ static void tce_iommu_release(void *iommu_data)
 			continue;
 
 		tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
-		tce_iommu_free_table(tbl);
+		tce_iommu_free_table(container, tbl);
 	}
 
 	tce_iommu_disable(container);
+	mmdrop(container->mm);
 	mutex_destroy(&container->lock);
 
 	kfree(container);
@@ -375,13 +369,14 @@ static void tce_iommu_unuse_page(struct tce_container *container,
 	put_page(page);
 }
 
-static int tce_iommu_prereg_ua_to_hpa(unsigned long tce, unsigned long size,
+static int tce_iommu_prereg_ua_to_hpa(struct tce_container *container,
+		unsigned long tce, unsigned long size,
 		unsigned long *phpa, struct mm_iommu_table_group_mem_t **pmem)
 {
 	long ret = 0;
 	struct mm_iommu_table_group_mem_t *mem;
 
-	mem = mm_iommu_lookup(current->mm, tce, size);
+	mem = mm_iommu_lookup(container->mm, tce, size);
 	if (!mem)
 		return -EINVAL;
 
@@ -394,18 +389,18 @@ static int tce_iommu_prereg_ua_to_hpa(unsigned long tce, unsigned long size,
 	return 0;
 }
 
-static void tce_iommu_unuse_page_v2(struct iommu_table *tbl,
-		unsigned long entry)
+static void tce_iommu_unuse_page_v2(struct tce_container *container,
+		struct iommu_table *tbl, unsigned long entry)
 {
 	struct mm_iommu_table_group_mem_t *mem = NULL;
 	int ret;
 	unsigned long hpa = 0;
 	unsigned long *pua = IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
 
-	if (!pua || !current || !current->mm)
+	if (!pua)
 		return;
 
-	ret = tce_iommu_prereg_ua_to_hpa(*pua, IOMMU_PAGE_SIZE(tbl),
+	ret = tce_iommu_prereg_ua_to_hpa(container, *pua, IOMMU_PAGE_SIZE(tbl),
 			&hpa, &mem);
 	if (ret)
 		pr_debug("%s: tce %lx at #%lx was not cached, ret=%d\n",
@@ -435,7 +430,7 @@ static int tce_iommu_clear(struct tce_container *container,
 			continue;
 
 		if (container->v2) {
-			tce_iommu_unuse_page_v2(tbl, entry);
+			tce_iommu_unuse_page_v2(container, tbl, entry);
 			continue;
 		}
 
@@ -520,8 +515,8 @@ static long tce_iommu_build_v2(struct tce_container *container,
 		unsigned long *pua = IOMMU_TABLE_USERSPACE_ENTRY(tbl,
 				entry + i);
 
-		ret = tce_iommu_prereg_ua_to_hpa(tce, IOMMU_PAGE_SIZE(tbl),
-				&hpa, &mem);
+		ret = tce_iommu_prereg_ua_to_hpa(container,
+				tce, IOMMU_PAGE_SIZE(tbl), &hpa, &mem);
 		if (ret)
 			break;
 
@@ -542,7 +537,7 @@ static long tce_iommu_build_v2(struct tce_container *container,
 		ret = iommu_tce_xchg(tbl, entry + i, &hpa, &dirtmp);
 		if (ret) {
 			/* dirtmp cannot be DMA_NONE here */
-			tce_iommu_unuse_page_v2(tbl, entry + i);
+			tce_iommu_unuse_page_v2(container, tbl, entry + i);
 			pr_err("iommu_tce: %s failed ioba=%lx, tce=%lx, ret=%ld\n",
 					__func__, entry << tbl->it_page_shift,
 					tce, ret);
@@ -550,7 +545,7 @@ static long tce_iommu_build_v2(struct tce_container *container,
 		}
 
 		if (dirtmp != DMA_NONE)
-			tce_iommu_unuse_page_v2(tbl, entry + i);
+			tce_iommu_unuse_page_v2(container, tbl, entry + i);
 
 		*pua = tce;
 
@@ -578,7 +573,7 @@ static long tce_iommu_create_table(struct tce_container *container,
 	if (!table_size)
 		return -EINVAL;
 
-	ret = try_increment_locked_vm(table_size >> PAGE_SHIFT);
+	ret = try_increment_locked_vm(container->mm, table_size >> PAGE_SHIFT);
 	if (ret)
 		return ret;
 
@@ -589,24 +584,25 @@ static long tce_iommu_create_table(struct tce_container *container,
 	WARN_ON(!ret && ((*ptbl)->it_allocated_size != table_size));
 
 	if (!ret && container->v2) {
-		ret = tce_iommu_userspace_view_alloc(*ptbl);
+		ret = tce_iommu_userspace_view_alloc(*ptbl, container->mm);
 		if (ret)
 			(*ptbl)->it_ops->free(*ptbl);
 	}
 
 	if (ret)
-		decrement_locked_vm(table_size >> PAGE_SHIFT);
+		decrement_locked_vm(container->mm, table_size >> PAGE_SHIFT);
 
 	return ret;
 }
 
-static void tce_iommu_free_table(struct iommu_table *tbl)
+static void tce_iommu_free_table(struct tce_container *container,
+		struct iommu_table *tbl)
 {
 	unsigned long pages = tbl->it_allocated_size >> PAGE_SHIFT;
 
-	tce_iommu_userspace_view_free(tbl);
+	tce_iommu_userspace_view_free(tbl, container->mm);
 	tbl->it_ops->free(tbl);
-	decrement_locked_vm(pages);
+	decrement_locked_vm(container->mm, pages);
 }
 
 static long tce_iommu_create_window(struct tce_container *container,
@@ -669,7 +665,7 @@ static long tce_iommu_create_window(struct tce_container *container,
 		table_group = iommu_group_get_iommudata(tcegrp->grp);
 		table_group->ops->unset_window(table_group, num);
 	}
-	tce_iommu_free_table(tbl);
+	tce_iommu_free_table(container, tbl);
 
 	return ret;
 }
@@ -707,7 +703,7 @@ static long tce_iommu_remove_window(struct tce_container *container,
 
 	/* Free table */
 	tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
-	tce_iommu_free_table(tbl);
+	tce_iommu_free_table(container, tbl);
 	container->tables[num] = NULL;
 
 	return 0;
@@ -720,8 +716,7 @@ static long tce_iommu_ioctl(void *iommu_data,
 	unsigned long minsz, ddwsz;
 	long ret;
 
-	switch (cmd) {
-	case VFIO_CHECK_EXTENSION:
+	if (cmd == VFIO_CHECK_EXTENSION) {
 		switch (arg) {
 		case VFIO_SPAPR_TCE_IOMMU:
 		case VFIO_SPAPR_TCE_v2_IOMMU:
@@ -733,7 +728,13 @@ static long tce_iommu_ioctl(void *iommu_data,
 		}
 
 		return (ret < 0) ? 0 : ret;
+	}
 
+	/* tce_iommu_open() initializes container->mm so it can't be NULL here */
+	if (container->mm != current->mm)
+		return -ESRCH;
+
+	switch (cmd) {
 	case VFIO_IOMMU_SPAPR_TCE_GET_INFO: {
 		struct vfio_iommu_spapr_tce_info info;
 		struct tce_iommu_group *tcegrp;
@@ -1049,7 +1050,7 @@ static void tce_iommu_release_ownership(struct tce_container *container,
 			continue;
 
 		tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
-		tce_iommu_userspace_view_free(tbl);
+		tce_iommu_userspace_view_free(tbl, container->mm);
 		if (tbl->it_map)
 			iommu_release_ownership(tbl);
 
@@ -1068,7 +1069,7 @@ static int tce_iommu_take_ownership(struct tce_container *container,
 		if (!tbl || !tbl->it_map)
 			continue;
 
-		rc = tce_iommu_userspace_view_alloc(tbl);
+		rc = tce_iommu_userspace_view_alloc(tbl, container->mm);
 		if (!rc)
 			rc = iommu_take_ownership(tbl);
 
-- 
2.5.0.rc3
