Return-Path: <aik@ozlabs.ru>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C4EAE1A091C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:25 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Sat, 25 Apr 2015 22:16:25 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id A7F143578065
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:20 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3PCGCxN9306286
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:20 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3PCFkmQ014117
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:15:47 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v9 29/32] vfio: powerpc/spapr: Register memory and
 define IOMMU v2
Date: Sat, 25 Apr 2015 22:14:53 +1000
Message-Id: <1429964096-11524-30-git-send-email-aik@ozlabs.ru>
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

The existing implementation accounts the whole DMA window in
the locked_vm counter. This is going to be worse with multiple
containers and huge DMA windows. Also, real-time accounting would requite
additional tracking of accounted pages due to the page size difference -
IOMMU uses 4K pages and system uses 4K or 64K pages.

Another issue is that actual pages pinning/unpinning happens on every
DMA map/unmap request. This does not affect the performance much now as
we spend way too much time now on switching context between
guest/userspace/host but this will start to matter when we add in-kernel
DMA map/unmap acceleration.

This introduces a new IOMMU type for SPAPR - VFIO_SPAPR_TCE_v2_IOMMU.
New IOMMU deprecates VFIO_IOMMU_ENABLE/VFIO_IOMMU_DISABLE and introduces
2 new ioctls to register/unregister DMA memory -
VFIO_IOMMU_SPAPR_REGISTER_MEMORY and VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY -
which receive user space address and size of a memory region which
needs to be pinned/unpinned and counted in locked_vm.
New IOMMU splits physical pages pinning and TCE table update into 2 different
operations. It requires 1) guest pages to be registered first 2) consequent
map/unmap requests to work only with pre-registered memory.
For the default single window case this means that the entire guest
(instead of 2GB) needs to be pinned before using VFIO.
When a huge DMA window is added, no additional pinning will be
required, otherwise it would be guest RAM + 2GB.

The new memory registration ioctls are not supported by
VFIO_SPAPR_TCE_IOMMU. Dynamic DMA window and in-kernel acceleration
will require memory to be preregistered in order to work.

The accounting is done per the user process.

This advertises v2 SPAPR TCE IOMMU and restricts what the userspace
can do with v1 or v2 IOMMUs.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
[aw: for the vfio related changes]
Acked-by: Alex Williamson <alex.williamson@redhat.com>
---
Changes:
v9:
* s/tce_get_hva_cached/tce_iommu_use_page_v2/

v7:
* now memory is registered per mm (i.e. process)
* moved memory registration code to powerpc/mmu
* merged "vfio: powerpc/spapr: Define v2 IOMMU" into this
* limited new ioctls to v2 IOMMU
* updated doc
* unsupported ioclts return -ENOTTY instead of -EPERM

v6:
* tce_get_hva_cached() returns hva via a pointer

v4:
* updated docs
* s/kzmalloc/vzalloc/
* in tce_pin_pages()/tce_unpin_pages() removed @vaddr, @size and
replaced offset with index
* renamed vfio_iommu_type_register_memory to vfio_iommu_spapr_register_memory
and removed duplicating vfio_iommu_spapr_register_memory
---
 Documentation/vfio.txt              |  23 ++++
 drivers/vfio/vfio_iommu_spapr_tce.c | 230 +++++++++++++++++++++++++++++++++++-
 include/uapi/linux/vfio.h           |  27 +++++
 3 files changed, 274 insertions(+), 6 deletions(-)

diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
index 96978ec..94328c8 100644
--- a/Documentation/vfio.txt
+++ b/Documentation/vfio.txt
@@ -427,6 +427,29 @@ The code flow from the example above should be slightly changed:
 
 	....
 
+5) There is v2 of SPAPR TCE IOMMU. It deprecates VFIO_IOMMU_ENABLE/
+VFIO_IOMMU_DISABLE and implements 2 new ioctls:
+VFIO_IOMMU_SPAPR_REGISTER_MEMORY and VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY
+(which are unsupported in v1 IOMMU).
+
+PPC64 paravirtualized guests generate a lot of map/unmap requests,
+and the handling of those includes pinning/unpinning pages and updating
+mm::locked_vm counter to make sure we do not exceed the rlimit.
+The v2 IOMMU splits accounting and pinning into separate operations:
+
+- VFIO_IOMMU_SPAPR_REGISTER_MEMORY/VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY ioctls
+receive a user space address and size of the block to be pinned.
+Bisecting is not supported and VFIO_IOMMU_UNREGISTER_MEMORY is expected to
+be called with the exact address and size used for registering
+the memory block. The userspace is not expected to call these often.
+The ranges are stored in a linked list in a VFIO container.
+
+- VFIO_IOMMU_MAP_DMA/VFIO_IOMMU_UNMAP_DMA ioctls only update the actual
+IOMMU table and do not do pinning; instead these check that the userspace
+address is from pre-registered range.
+
+This separation helps in optimizing DMA for guests.
+
 -------------------------------------------------------------------------------
 
 [1] VFIO was originally an acronym for "Virtual Function I/O" in its
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 892a584..4cfc2c1 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -21,6 +21,7 @@
 #include <linux/vfio.h>
 #include <asm/iommu.h>
 #include <asm/tce.h>
+#include <asm/mmu_context.h>
 
 #define DRIVER_VERSION  "0.1"
 #define DRIVER_AUTHOR   "aik@ozlabs.ru"
@@ -91,8 +92,58 @@ struct tce_container {
 	struct iommu_group *grp;
 	bool enabled;
 	unsigned long locked_pages;
+	bool v2;
 };
 
+static long tce_unregister_pages(struct tce_container *container,
+		__u64 vaddr, __u64 size)
+{
+	long ret;
+	struct mm_iommu_table_group_mem_t *mem;
+
+	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK))
+		return -EINVAL;
+
+	mem = mm_iommu_get(vaddr, size >> PAGE_SHIFT);
+	if (!mem)
+		return -EINVAL;
+
+	ret = mm_iommu_put(mem); /* undo kref_get() from mm_iommu_get() */
+	if (!ret)
+		ret = mm_iommu_put(mem);
+
+	return ret;
+}
+
+static long tce_register_pages(struct tce_container *container,
+		__u64 vaddr, __u64 size)
+{
+	long ret = 0;
+	struct mm_iommu_table_group_mem_t *mem;
+	unsigned long entries = size >> PAGE_SHIFT;
+
+	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK) ||
+			((vaddr + size) < vaddr))
+		return -EINVAL;
+
+	mem = mm_iommu_get(vaddr, entries);
+	if (!mem) {
+		ret = try_increment_locked_vm(entries);
+		if (ret)
+			return ret;
+
+		ret = mm_iommu_alloc(vaddr, entries, &mem);
+		if (ret) {
+			decrement_locked_vm(entries);
+			return ret;
+		}
+	}
+
+	container->enabled = true;
+
+	return 0;
+}
+
 static bool tce_page_is_contained(struct page *page, unsigned page_shift)
 {
 	/*
@@ -205,7 +256,7 @@ static void *tce_iommu_open(unsigned long arg)
 {
 	struct tce_container *container;
 
-	if (arg != VFIO_SPAPR_TCE_IOMMU) {
+	if ((arg != VFIO_SPAPR_TCE_IOMMU) && (arg != VFIO_SPAPR_TCE_v2_IOMMU)) {
 		pr_err("tce_vfio: Wrong IOMMU type\n");
 		return ERR_PTR(-EINVAL);
 	}
@@ -215,6 +266,7 @@ static void *tce_iommu_open(unsigned long arg)
 		return ERR_PTR(-ENOMEM);
 
 	mutex_init(&container->lock);
+	container->v2 = arg == VFIO_SPAPR_TCE_v2_IOMMU;
 
 	return container;
 }
@@ -243,6 +295,47 @@ static void tce_iommu_unuse_page(struct tce_container *container,
 	put_page(page);
 }
 
+static int tce_iommu_use_page_v2(unsigned long tce, unsigned long size,
+		unsigned long *phpa, struct mm_iommu_table_group_mem_t **pmem)
+{
+	long ret = 0;
+	struct mm_iommu_table_group_mem_t *mem;
+
+	mem = mm_iommu_lookup(tce, size);
+	if (!mem)
+		return -EINVAL;
+
+	ret = mm_iommu_ua_to_hpa(mem, tce, phpa);
+	if (ret)
+		return -EINVAL;
+
+	*pmem = mem;
+
+	return 0;
+}
+
+static void tce_iommu_unuse_page_v2(struct iommu_table *tbl,
+		unsigned long entry)
+{
+	struct mm_iommu_table_group_mem_t *mem = NULL;
+	int ret;
+	unsigned long hpa = 0;
+	unsigned long *pua = IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
+
+	if (!pua || !current || !current->mm)
+		return;
+
+	ret = tce_iommu_use_page_v2(*pua, IOMMU_PAGE_SIZE(tbl),
+			&hpa, &mem);
+	if (ret)
+		pr_debug("%s: tce %lx at #%lx was not cached, ret=%d\n",
+				__func__, *pua, entry, ret);
+	if (mem)
+		mm_iommu_mapped_update(mem, false);
+
+	*pua = 0;
+}
+
 static int tce_iommu_clear(struct tce_container *container,
 		struct iommu_table *tbl,
 		unsigned long entry, unsigned long pages)
@@ -261,6 +354,11 @@ static int tce_iommu_clear(struct tce_container *container,
 		if (direction == DMA_NONE)
 			continue;
 
+		if (container->v2) {
+			tce_iommu_unuse_page_v2(tbl, entry);
+			continue;
+		}
+
 		tce_iommu_unuse_page(container, oldtce);
 	}
 
@@ -327,6 +425,62 @@ static long tce_iommu_build(struct tce_container *container,
 	return ret;
 }
 
+static long tce_iommu_build_v2(struct tce_container *container,
+		struct iommu_table *tbl,
+		unsigned long entry, unsigned long tce, unsigned long pages,
+		enum dma_data_direction direction)
+{
+	long i, ret = 0;
+	struct page *page;
+	unsigned long hpa;
+	enum dma_data_direction dirtmp;
+
+	for (i = 0; i < pages; ++i) {
+		struct mm_iommu_table_group_mem_t *mem = NULL;
+		unsigned long *pua = IOMMU_TABLE_USERSPACE_ENTRY(tbl,
+				entry + i);
+
+		ret = tce_iommu_use_page_v2(tce, IOMMU_PAGE_SIZE(tbl),
+				&hpa, &mem);
+		if (ret)
+			break;
+
+		page = pfn_to_page(hpa >> PAGE_SHIFT);
+		if (!tce_page_is_contained(page, tbl->it_page_shift)) {
+			ret = -EPERM;
+			break;
+		}
+
+		/* Preserve offset within IOMMU page */
+		hpa |= tce & IOMMU_PAGE_MASK(tbl) & ~PAGE_MASK;
+		dirtmp = direction;
+
+		ret = iommu_tce_xchg(tbl, entry + i, &hpa, &dirtmp);
+		if (ret) {
+			/* dirtmp cannot be DMA_NONE here */
+			tce_iommu_unuse_page_v2(tbl, entry + i);
+			pr_err("iommu_tce: %s failed ioba=%lx, tce=%lx, ret=%ld\n",
+					__func__, entry << tbl->it_page_shift,
+					tce, ret);
+			break;
+		}
+
+		mm_iommu_mapped_update(mem, true);
+
+		if (dirtmp != DMA_NONE)
+			tce_iommu_unuse_page_v2(tbl, entry + i);
+
+		*pua = tce;
+
+		tce += IOMMU_PAGE_SIZE(tbl);
+	}
+
+	if (ret)
+		tce_iommu_clear(container, tbl, entry, i);
+
+	return ret;
+}
+
 static long tce_iommu_ioctl(void *iommu_data,
 				 unsigned int cmd, unsigned long arg)
 {
@@ -338,6 +492,7 @@ static long tce_iommu_ioctl(void *iommu_data,
 	case VFIO_CHECK_EXTENSION:
 		switch (arg) {
 		case VFIO_SPAPR_TCE_IOMMU:
+		case VFIO_SPAPR_TCE_v2_IOMMU:
 			ret = 1;
 			break;
 		default:
@@ -425,11 +580,18 @@ static long tce_iommu_ioctl(void *iommu_data,
 		if (ret)
 			return ret;
 
-		ret = tce_iommu_build(container, tbl,
-				param.iova >> tbl->it_page_shift,
-				param.vaddr,
-				param.size >> tbl->it_page_shift,
-				direction);
+		if (container->v2)
+			ret = tce_iommu_build_v2(container, tbl,
+					param.iova >> tbl->it_page_shift,
+					param.vaddr,
+					param.size >> tbl->it_page_shift,
+					direction);
+		else
+			ret = tce_iommu_build(container, tbl,
+					param.iova >> tbl->it_page_shift,
+					param.vaddr,
+					param.size >> tbl->it_page_shift,
+					direction);
 
 		iommu_flush_tce(tbl);
 
@@ -474,7 +636,60 @@ static long tce_iommu_ioctl(void *iommu_data,
 
 		return ret;
 	}
+	case VFIO_IOMMU_SPAPR_REGISTER_MEMORY: {
+		struct vfio_iommu_spapr_register_memory param;
+
+		if (!container->v2)
+			break;
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
+		if (!container->v2)
+			break;
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
+		if (container->v2)
+			break;
+
 		mutex_lock(&container->lock);
 		ret = tce_iommu_enable(container);
 		mutex_unlock(&container->lock);
@@ -482,6 +697,9 @@ static long tce_iommu_ioctl(void *iommu_data,
 
 
 	case VFIO_IOMMU_DISABLE:
+		if (container->v2)
+			break;
+
 		mutex_lock(&container->lock);
 		tce_iommu_disable(container);
 		mutex_unlock(&container->lock);
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index b57b750..8fdcfb9 100644
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
@@ -495,6 +497,31 @@ struct vfio_eeh_pe_op {
 
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
