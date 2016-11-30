Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [83.169.36.222])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tTB234jZzzDvrV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 17:52:59 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org
Subject: [PATCH kernel v7 6/7] vfio/spapr: Reference mm in tce_container
Date: Wed, 30 Nov 2016 17:52:04 +1100
Message-Id: <1480488725-12783-7-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1480488725-12783-1-git-send-email-aik@ozlabs.ru>
References: <1480488725-12783-1-git-send-email-aik@ozlabs.ru>
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
in a new helper - tce_iommu_mm_set() - when one of the following happens:
- a container is enabled (IOMMU v1);
- a first attempt to pre-register memory is made (IOMMU v2);
- a DMA window is created (IOMMU v2).
The @mm stays referenced till the container is destroyed.

This replaces current->mm with container->mm everywhere except debug
prints.

This adds a check that current->mm is the same as the one stored in
the container to prevent userspace from making changes to a memory
context of other processes.

DMA map/unmap ioctls() do not check for @mm as they already check
for @enabled which is set after tce_iommu_mm_set() is called.

This does not reference a task as multiple threads within the same mm
are allowed to ioctl() to vfio and supposedly they will have same limits
and capabilities and if they do not, we'll just fail with no harm made.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v7:
* WARN_ON_ONCE(!mm)) in try_increment_locked_vm()
* s/&&/||/ in a parameter check in decrement_locked_vm()
* instead of failing on unset container,
the VFIO_IOMMU_SPAPR_TCE_REMOVE handler sets mm to container now

v6:
* updated the commit log about not referencing task

v5:
* postpone referencing of mm

v4:
* added check for container->mm!=current->mm in tce_iommu_ioctl()
for all ioctls and removed other redundand checks
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 160 ++++++++++++++++++++++--------------
 1 file changed, 100 insertions(+), 60 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 88622be..4c03c85 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -31,49 +31,49 @@
 static void tce_iommu_detach_group(void *iommu_data,
 		struct iommu_group *iommu_group);
 
-static long try_increment_locked_vm(long npages)
+static long try_increment_locked_vm(struct mm_struct *mm, long npages)
 {
 	long ret = 0, locked, lock_limit;
 
-	if (!current || !current->mm)
-		return -ESRCH; /* process exited */
+	if (WARN_ON_ONCE(!mm))
+		return -EPERM;
 
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
+	if (!mm || !npages)
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
@@ -99,26 +99,38 @@ struct tce_container {
 	bool v2;
 	bool def_window_pending;
 	unsigned long locked_pages;
+	struct mm_struct *mm;
 	struct iommu_table *tables[IOMMU_TABLE_GROUP_MAX_TABLES];
 	struct list_head group_list;
 };
 
+static long tce_iommu_mm_set(struct tce_container *container)
+{
+	if (container->mm) {
+		if (container->mm == current->mm)
+			return 0;
+		return -EPERM;
+	}
+	BUG_ON(!current->mm);
+	container->mm = current->mm;
+	atomic_inc(&container->mm->mm_count);
+
+	return 0;
+}
+
 static long tce_iommu_unregister_pages(struct tce_container *container,
 		__u64 vaddr, __u64 size)
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
@@ -128,14 +140,11 @@ static long tce_iommu_register_pages(struct tce_container *container,
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
 
@@ -144,7 +153,8 @@ static long tce_iommu_register_pages(struct tce_container *container,
 	return 0;
 }
 
-static long tce_iommu_userspace_view_alloc(struct iommu_table *tbl)
+static long tce_iommu_userspace_view_alloc(struct iommu_table *tbl,
+		struct mm_struct *mm)
 {
 	unsigned long cb = _ALIGN_UP(sizeof(tbl->it_userspace[0]) *
 			tbl->it_size, PAGE_SIZE);
@@ -153,13 +163,13 @@ static long tce_iommu_userspace_view_alloc(struct iommu_table *tbl)
 
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
@@ -167,7 +177,8 @@ static long tce_iommu_userspace_view_alloc(struct iommu_table *tbl)
 	return 0;
 }
 
-static void tce_iommu_userspace_view_free(struct iommu_table *tbl)
+static void tce_iommu_userspace_view_free(struct iommu_table *tbl,
+		struct mm_struct *mm)
 {
 	unsigned long cb = _ALIGN_UP(sizeof(tbl->it_userspace[0]) *
 			tbl->it_size, PAGE_SIZE);
@@ -177,7 +188,7 @@ static void tce_iommu_userspace_view_free(struct iommu_table *tbl)
 
 	vfree(tbl->it_userspace);
 	tbl->it_userspace = NULL;
-	decrement_locked_vm(cb >> PAGE_SHIFT);
+	decrement_locked_vm(mm, cb >> PAGE_SHIFT);
 }
 
 static bool tce_page_is_contained(struct page *page, unsigned page_shift)
@@ -237,9 +248,6 @@ static int tce_iommu_enable(struct tce_container *container)
 	struct iommu_table_group *table_group;
 	struct tce_iommu_group *tcegrp;
 
-	if (!current->mm)
-		return -ESRCH; /* process exited */
-
 	if (container->enabled)
 		return -EBUSY;
 
@@ -284,8 +292,12 @@ static int tce_iommu_enable(struct tce_container *container)
 	if (!table_group->tce32_size)
 		return -EPERM;
 
+	ret = tce_iommu_mm_set(container);
+	if (ret)
+		return ret;
+
 	locked = table_group->tce32_size >> PAGE_SHIFT;
-	ret = try_increment_locked_vm(locked);
+	ret = try_increment_locked_vm(container->mm, locked);
 	if (ret)
 		return ret;
 
@@ -303,10 +315,8 @@ static void tce_iommu_disable(struct tce_container *container)
 
 	container->enabled = false;
 
-	if (!current->mm)
-		return;
-
-	decrement_locked_vm(container->locked_pages);
+	BUG_ON(!container->mm);
+	decrement_locked_vm(container->mm, container->locked_pages);
 }
 
 static void *tce_iommu_open(unsigned long arg)
@@ -333,7 +343,8 @@ static void *tce_iommu_open(unsigned long arg)
 static int tce_iommu_clear(struct tce_container *container,
 		struct iommu_table *tbl,
 		unsigned long entry, unsigned long pages);
-static void tce_iommu_free_table(struct iommu_table *tbl);
+static void tce_iommu_free_table(struct tce_container *container,
+		struct iommu_table *tbl);
 
 static void tce_iommu_release(void *iommu_data)
 {
@@ -358,10 +369,12 @@ static void tce_iommu_release(void *iommu_data)
 			continue;
 
 		tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
-		tce_iommu_free_table(tbl);
+		tce_iommu_free_table(container, tbl);
 	}
 
 	tce_iommu_disable(container);
+	if (container->mm)
+		mmdrop(container->mm);
 	mutex_destroy(&container->lock);
 
 	kfree(container);
@@ -376,13 +389,14 @@ static void tce_iommu_unuse_page(struct tce_container *container,
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
 
@@ -395,18 +409,18 @@ static int tce_iommu_prereg_ua_to_hpa(unsigned long tce, unsigned long size,
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
@@ -436,7 +450,7 @@ static int tce_iommu_clear(struct tce_container *container,
 			continue;
 
 		if (container->v2) {
-			tce_iommu_unuse_page_v2(tbl, entry);
+			tce_iommu_unuse_page_v2(container, tbl, entry);
 			continue;
 		}
 
@@ -517,7 +531,7 @@ static long tce_iommu_build_v2(struct tce_container *container,
 	enum dma_data_direction dirtmp;
 
 	if (!tbl->it_userspace) {
-		ret = tce_iommu_userspace_view_alloc(tbl);
+		ret = tce_iommu_userspace_view_alloc(tbl, container->mm);
 		if (ret)
 			return ret;
 	}
@@ -527,8 +541,8 @@ static long tce_iommu_build_v2(struct tce_container *container,
 		unsigned long *pua = IOMMU_TABLE_USERSPACE_ENTRY(tbl,
 				entry + i);
 
-		ret = tce_iommu_prereg_ua_to_hpa(tce, IOMMU_PAGE_SIZE(tbl),
-				&hpa, &mem);
+		ret = tce_iommu_prereg_ua_to_hpa(container,
+				tce, IOMMU_PAGE_SIZE(tbl), &hpa, &mem);
 		if (ret)
 			break;
 
@@ -549,7 +563,7 @@ static long tce_iommu_build_v2(struct tce_container *container,
 		ret = iommu_tce_xchg(tbl, entry + i, &hpa, &dirtmp);
 		if (ret) {
 			/* dirtmp cannot be DMA_NONE here */
-			tce_iommu_unuse_page_v2(tbl, entry + i);
+			tce_iommu_unuse_page_v2(container, tbl, entry + i);
 			pr_err("iommu_tce: %s failed ioba=%lx, tce=%lx, ret=%ld\n",
 					__func__, entry << tbl->it_page_shift,
 					tce, ret);
@@ -557,7 +571,7 @@ static long tce_iommu_build_v2(struct tce_container *container,
 		}
 
 		if (dirtmp != DMA_NONE)
-			tce_iommu_unuse_page_v2(tbl, entry + i);
+			tce_iommu_unuse_page_v2(container, tbl, entry + i);
 
 		*pua = tce;
 
@@ -585,7 +599,7 @@ static long tce_iommu_create_table(struct tce_container *container,
 	if (!table_size)
 		return -EINVAL;
 
-	ret = try_increment_locked_vm(table_size >> PAGE_SHIFT);
+	ret = try_increment_locked_vm(container->mm, table_size >> PAGE_SHIFT);
 	if (ret)
 		return ret;
 
@@ -598,13 +612,14 @@ static long tce_iommu_create_table(struct tce_container *container,
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
@@ -667,7 +682,7 @@ static long tce_iommu_create_window(struct tce_container *container,
 		table_group = iommu_group_get_iommudata(tcegrp->grp);
 		table_group->ops->unset_window(table_group, num);
 	}
-	tce_iommu_free_table(tbl);
+	tce_iommu_free_table(container, tbl);
 
 	return ret;
 }
@@ -705,7 +720,7 @@ static long tce_iommu_remove_window(struct tce_container *container,
 
 	/* Free table */
 	tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
-	tce_iommu_free_table(tbl);
+	tce_iommu_free_table(container, tbl);
 	container->tables[num] = NULL;
 
 	return 0;
@@ -760,7 +775,17 @@ static long tce_iommu_ioctl(void *iommu_data,
 		}
 
 		return (ret < 0) ? 0 : ret;
+	}
 
+	/*
+	 * Sanity check to prevent one userspace from manipulating
+	 * another userspace mm.
+	 */
+	BUG_ON(!container);
+	if (container->mm && container->mm != current->mm)
+		return -EPERM;
+
+	switch (cmd) {
 	case VFIO_IOMMU_SPAPR_TCE_GET_INFO: {
 		struct vfio_iommu_spapr_tce_info info;
 		struct tce_iommu_group *tcegrp;
@@ -929,6 +954,10 @@ static long tce_iommu_ioctl(void *iommu_data,
 		minsz = offsetofend(struct vfio_iommu_spapr_register_memory,
 				size);
 
+		ret = tce_iommu_mm_set(container);
+		if (ret)
+			return ret;
+
 		if (copy_from_user(&param, (void __user *)arg, minsz))
 			return -EFAULT;
 
@@ -952,6 +981,9 @@ static long tce_iommu_ioctl(void *iommu_data,
 		if (!container->v2)
 			break;
 
+		if (!container->mm)
+			return -EPERM;
+
 		minsz = offsetofend(struct vfio_iommu_spapr_register_memory,
 				size);
 
@@ -1010,6 +1042,10 @@ static long tce_iommu_ioctl(void *iommu_data,
 		if (!container->v2)
 			break;
 
+		ret = tce_iommu_mm_set(container);
+		if (ret)
+			return ret;
+
 		if (!tce_groups_attached(container))
 			return -ENXIO;
 
@@ -1048,6 +1084,10 @@ static long tce_iommu_ioctl(void *iommu_data,
 		if (!container->v2)
 			break;
 
+		ret = tce_iommu_mm_set(container);
+		if (ret)
+			return ret;
+
 		if (!tce_groups_attached(container))
 			return -ENXIO;
 
@@ -1093,7 +1133,7 @@ static void tce_iommu_release_ownership(struct tce_container *container,
 			continue;
 
 		tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
-		tce_iommu_userspace_view_free(tbl);
+		tce_iommu_userspace_view_free(tbl, container->mm);
 		if (tbl->it_map)
 			iommu_release_ownership(tbl);
 
-- 
2.5.0.rc3
