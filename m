Return-Path: <aik@ozlabs.ru>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CA0B11A04C1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 21:07:47 +1100 (AEDT)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Mon, 16 Feb 2015 20:07:47 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 83DD42BB005C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 21:07:44 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1GA7aBm49676392
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 21:07:44 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1GA7BT7021016
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 21:07:11 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 08/28] vfio: powerpc/spapr: Register memory
Date: Mon, 16 Feb 2015 21:06:00 +1100
Message-Id: <1424081180-4494-9-git-send-email-aik@ozlabs.ru>
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

The existing implementation accounts the whole DMA window in
the locked_vm counter which is going to be even worse with multiple
containers and huge DMA windows.

This introduces 2 ioctls to register/unregister DMA memory which
receive user space address and size of a memory region which
needs to be pinned/unpinned and counted in locked_vm.

If any memory region was registered, all subsequent DMA map requests
should address already pinned memory. If no memory was registered,
then the amount of memory required for a single default memory will be
accounted when the container is enabled and every map/unmap will pin/unpin
a page (with degraded performance).

Dynamic DMA window and in-kernel acceleration will require memory to
be preregistered in order to work.

The accounting is done per VFIO container. When the support of
multiple groups per container is added, we will have accurate locked_vm
accounting.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v4:
* updated docs
* s/kzmalloc/vzalloc/
* in tce_pin_pages()/tce_unpin_pages() removed @vaddr, @size and
replaced offset with index
* renamed vfio_iommu_type_register_memory to vfio_iommu_spapr_register_memory
and removed duplicating vfio_iommu_spapr_register_memory
---
 Documentation/vfio.txt              |  19 +++
 drivers/vfio/vfio_iommu_spapr_tce.c | 274 +++++++++++++++++++++++++++++++++++-
 include/uapi/linux/vfio.h           |  25 ++++
 3 files changed, 312 insertions(+), 6 deletions(-)

diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
index 96978ec..791e85c 100644
--- a/Documentation/vfio.txt
+++ b/Documentation/vfio.txt
@@ -427,6 +427,25 @@ The code flow from the example above should be slightly changed:
 
 	....
 
+5) PPC64 paravirtualized guests may generate a lot of map/unmap requests,
+and the handling of those includes pinning/unpinning pages and updating
+mm::locked_vm counter to make sure we do not exceed the rlimit. Handling these
+in real-mode is quite expensive and may fail. In order to simplify in-kernel
+acceleration of map/unmap requests, two ioctls have been added to pre-register
+and unregister guest RAM pages where DMA can possibly happen to. Having these
+calles, the userspace and in-kernel handlers do not have to take care of
+pinning or accounting.
+
+The ioctls are VFIO_IOMMU_SPAPR_REGISTER_MEMORY and
+VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY.
+These receive a user space address and size of the block to be pinned.
+Bisecting is not supported and VFIO_IOMMU_UNREGISTER_MEMORY is expected to
+be called with the exact address and size used for registering
+the memory block.
+
+The user space is not expected to call these often and the block descriptors
+are stored in a linked list in the kernel.
+
 -------------------------------------------------------------------------------
 
 [1] VFIO was originally an acronym for "Virtual Function I/O" in its
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 7fd60f9..9b884e0 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -21,6 +21,7 @@
 #include <linux/uaccess.h>
 #include <linux/err.h>
 #include <linux/vfio.h>
+#include <linux/vmalloc.h>
 #include <asm/iommu.h>
 #include <asm/tce.h>
 
@@ -93,8 +94,196 @@ struct tce_container {
 	struct iommu_table *tbl;
 	bool enabled;
 	unsigned long locked_pages;
+	struct list_head mem_list;
 };
 
+struct tce_memory {
+	struct list_head next;
+	struct rcu_head rcu;
+	__u64 vaddr;
+	__u64 size;
+	__u64 hpas[];
+};
+
+static inline bool tce_preregistered(struct tce_container *container)
+{
+	return !list_empty(&container->mem_list);
+}
+
+static struct tce_memory *tce_mem_alloc(struct tce_container *container,
+		__u64 vaddr, __u64 size)
+{
+	struct tce_memory *mem;
+	long ret;
+
+	ret = try_increment_locked_vm(size >> PAGE_SHIFT);
+	if (ret)
+		return NULL;
+
+	mem = vzalloc(sizeof(*mem) + (size >> (PAGE_SHIFT - 3)));
+	if (!mem) {
+		decrement_locked_vm(size >> PAGE_SHIFT);
+		return NULL;
+	}
+
+	mem->vaddr = vaddr;
+	mem->size = size;
+
+	list_add_rcu(&mem->next, &container->mem_list);
+
+	return mem;
+}
+
+static void release_tce_memory(struct rcu_head *head)
+{
+	struct tce_memory *mem = container_of(head, struct tce_memory, rcu);
+
+	vfree(mem);
+}
+
+static void tce_mem_free(struct tce_memory *mem)
+{
+	decrement_locked_vm(mem->size);
+	list_del_rcu(&mem->next);
+	call_rcu(&mem->rcu, release_tce_memory);
+}
+
+static struct tce_memory *tce_pinned_desc(struct tce_container *container,
+		__u64 vaddr, __u64 size)
+{
+	struct tce_memory *mem, *ret = NULL;
+
+	rcu_read_lock();
+	vaddr &= ~(TCE_PCI_READ | TCE_PCI_WRITE);
+	list_for_each_entry_rcu(mem, &container->mem_list, next) {
+		if ((mem->vaddr <= vaddr) &&
+				(vaddr + size <= mem->vaddr + mem->size)) {
+			ret = mem;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
+
+static bool tce_mem_overlapped(struct tce_container *container,
+		__u64 vaddr, __u64 size)
+{
+	struct tce_memory *mem;
+	bool ret = false;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(mem, &container->mem_list, next) {
+		if ((mem->vaddr < (vaddr + size)) &&
+				(vaddr < (mem->vaddr + mem->size))) {
+			ret = true;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
+
+static void tce_unpin_pages(struct tce_container *container,
+		struct tce_memory *mem)
+{
+	long i;
+	struct page *page = NULL;
+
+	for (i = 0; i < (mem->size >> PAGE_SHIFT); ++i) {
+		if (!mem->hpas[i])
+			continue;
+
+		page = pfn_to_page(mem->hpas[i] >> PAGE_SHIFT);
+		if (!page)
+			continue;
+
+		put_page(page);
+		mem->hpas[i] = 0;
+	}
+}
+
+static long tce_unregister_pages(struct tce_container *container,
+		__u64 vaddr, __u64 size)
+{
+	struct tce_memory *mem, *memtmp;
+
+	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK))
+		return -EINVAL;
+
+	list_for_each_entry_safe(mem, memtmp, &container->mem_list, next) {
+		if ((mem->vaddr == vaddr) && (mem->size == size)) {
+			tce_unpin_pages(container, mem);
+			tce_mem_free(mem);
+
+			/* If that was the last region, disable the container */
+			if (!tce_preregistered(container))
+				container->enabled = false;
+
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
+
+static void tce_mem_unregister_all(struct tce_container *container)
+{
+	struct tce_memory *mem, *memtmp;
+
+	list_for_each_entry_safe(mem, memtmp, &container->mem_list, next) {
+		tce_unpin_pages(container, mem);
+		tce_mem_free(mem);
+	}
+}
+
+static long tce_pin_pages(struct tce_container *container,
+		struct tce_memory *mem)
+{
+	long i;
+	struct page *page = NULL;
+
+	for (i = 0; i < (mem->size >> PAGE_SHIFT); ++i) {
+		if (1 != get_user_pages_fast(mem->vaddr + (i << PAGE_SHIFT),
+					1/* pages */, 1/* iswrite */, &page)) {
+			tce_unpin_pages(container, mem);
+			return -EFAULT;
+		}
+
+		mem->hpas[i] = page_to_pfn(page) << PAGE_SHIFT;
+	}
+
+	return 0;
+}
+
+static long tce_register_pages(struct tce_container *container,
+		__u64 vaddr, __u64 size)
+{
+	struct tce_memory *mem;
+
+	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK) ||
+			((vaddr + size) < vaddr))
+		return -EINVAL;
+
+	if (tce_mem_overlapped(container, vaddr, size))
+		return -EBUSY;
+
+	mem = tce_mem_alloc(container, vaddr, size);
+	if (!mem)
+		return -ENOMEM;
+
+	if (tce_pin_pages(container, mem)) {
+		tce_mem_free(mem);
+		return -EFAULT;
+	}
+
+	container->enabled = true;
+
+	return 0;
+}
+
 static bool tce_page_is_contained(struct page *page, unsigned page_shift)
 {
 	unsigned shift;
@@ -151,12 +340,14 @@ static int tce_iommu_enable(struct tce_container *container)
 	 * as this information is only available from KVM and VFIO is
 	 * KVM agnostic.
 	 */
-	locked = (tbl->it_size << tbl->it_page_shift) >> PAGE_SHIFT;
-	ret = try_increment_locked_vm(locked);
-	if (ret)
-		return ret;
+	if (!tce_preregistered(container)) {
+		locked = (tbl->it_size << tbl->it_page_shift) >> PAGE_SHIFT;
+		ret = try_increment_locked_vm(locked);
+		if (ret)
+			return ret;
 
-	container->locked_pages = locked;
+		container->locked_pages = locked;
+	}
 
 	container->enabled = true;
 
@@ -190,6 +381,7 @@ static void *tce_iommu_open(unsigned long arg)
 		return ERR_PTR(-ENOMEM);
 
 	mutex_init(&container->lock);
+	INIT_LIST_HEAD_RCU(&container->mem_list);
 
 	return container;
 }
@@ -212,6 +404,9 @@ static void tce_iommu_release(void *iommu_data)
 		if (tbl->it_group)
 			tce_iommu_detach_group(iommu_data, tbl->it_group);
 	}
+
+	tce_mem_unregister_all(container);
+
 	mutex_destroy(&container->lock);
 
 	kfree(container);
@@ -230,6 +425,9 @@ static void tce_iommu_unuse_page(struct tce_container *container,
 	if (oldtce & TCE_PCI_WRITE)
 		SetPageDirty(page);
 
+	if (tce_preregistered(container))
+		return;
+
 	put_page(page);
 }
 
@@ -280,6 +478,22 @@ static unsigned long tce_get_hva(struct tce_container *container,
 	return hva;
 }
 
+static unsigned long tce_get_hva_cached(struct tce_container *container,
+		unsigned page_shift, unsigned long tce)
+{
+	struct tce_memory *mem;
+	unsigned long gfn;
+
+	tce &= PAGE_MASK;
+	mem = tce_pinned_desc(container, tce, 1ULL << page_shift);
+	if (!mem)
+		return -1;
+
+	gfn = (tce - mem->vaddr) >> PAGE_SHIFT;
+
+	return (unsigned long) __va(mem->hpas[gfn]);
+}
+
 static long tce_iommu_build(struct tce_container *container,
 		struct iommu_table *tbl,
 		unsigned long entry, unsigned long tce, unsigned long pages)
@@ -290,7 +504,11 @@ static long tce_iommu_build(struct tce_container *container,
 	enum dma_data_direction direction = tce_iommu_direction(tce);
 
 	for (i = 0; i < pages; ++i) {
-		hva = tce_get_hva(container, tbl->it_page_shift, tce);
+		if (tce_preregistered(container))
+			hva = tce_get_hva_cached(container, tbl->it_page_shift,
+					tce);
+		else
+			hva = tce_get_hva(container, tbl->it_page_shift, tce);
 		if (hva == -1) {
 			ret = -EFAULT;
 			break;
@@ -455,6 +673,50 @@ static long tce_iommu_ioctl(void *iommu_data,
 
 		return ret;
 	}
+	case VFIO_IOMMU_SPAPR_REGISTER_MEMORY: {
+		struct vfio_iommu_spapr_register_memory param;
+
+		minsz = offsetofend(struct vfio_iommu_spapr_register_memory,
+				size);
+
+		if (copy_from_user(&param, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (param.argsz < minsz)
+			return -EINVAL;
+
+		/* No flag is supported now */
+		if (param.flags)
+			return -EINVAL;
+
+		mutex_lock(&container->lock);
+		ret = tce_register_pages(container, param.vaddr, param.size);
+		mutex_unlock(&container->lock);
+
+		return ret;
+	}
+	case VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY: {
+		struct vfio_iommu_spapr_register_memory param;
+
+		minsz = offsetofend(struct vfio_iommu_spapr_register_memory,
+				size);
+
+		if (copy_from_user(&param, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (param.argsz < minsz)
+			return -EINVAL;
+
+		/* No flag is supported now */
+		if (param.flags)
+			return -EINVAL;
+
+		mutex_lock(&container->lock);
+		tce_unregister_pages(container, param.vaddr, param.size);
+		mutex_unlock(&container->lock);
+
+		return 0;
+	}
 	case VFIO_IOMMU_ENABLE:
 		mutex_lock(&container->lock);
 		ret = tce_iommu_enable(container);
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 29715d2..0f55c08 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -492,6 +492,31 @@ struct vfio_eeh_pe_op {
 
 #define VFIO_EEH_PE_OP			_IO(VFIO_TYPE, VFIO_BASE + 21)
 
+/**
+ * VFIO_IOMMU_SPAPR_REGISTER_MEMORY - _IOW(VFIO_TYPE, VFIO_BASE + 17, struct vfio_iommu_spapr_register_memory)
+ *
+ * Registers user space memory where DMA is allowed. It pins
+ * user pages and does the locked memory accounting so
+ * subsequent VFIO_IOMMU_MAP_DMA/VFIO_IOMMU_UNMAP_DMA calls
+ * get faster.
+ */
+struct vfio_iommu_spapr_register_memory {
+	__u32	argsz;
+	__u32	flags;
+	__u64	vaddr;				/* Process virtual address */
+	__u64	size;				/* Size of mapping (bytes) */
+};
+#define VFIO_IOMMU_SPAPR_REGISTER_MEMORY	_IO(VFIO_TYPE, VFIO_BASE + 17)
+
+/**
+ * VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY - _IOW(VFIO_TYPE, VFIO_BASE + 18, struct vfio_iommu_spapr_register_memory)
+ *
+ * Unregisters user space memory registered with
+ * VFIO_IOMMU_SPAPR_REGISTER_MEMORY.
+ * Uses vfio_iommu_spapr_register_memory for parameters.
+ */
+#define VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY	_IO(VFIO_TYPE, VFIO_BASE + 18)
+
 /* ***************************************************************** */
 
 #endif /* _UAPIVFIO_H */
-- 
2.0.0
