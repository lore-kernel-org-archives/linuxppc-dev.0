Return-Path: <aik@ozlabs.ru>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2B7B01A0CA9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:46:26 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 29 May 2015 18:46:24 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3C7C6357806E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:46:22 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4T8kCMB9830422
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:46:20 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4T8jnmk027367
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:45:49 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH kernel v11 33/34] vfio: powerpc/spapr: Register memory and
 define IOMMU v2
Date: Fri, 29 May 2015 18:44:57 +1000
Message-Id: <1432889098-22924-34-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
References: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
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
New IOMMU splits physical pages pinning and TCE table update
into 2 different operations. It requires:
1) guest pages to be registered first
2) consequent map/unmap requests to work only with pre-registered memory.
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

In order to support memory pre-registration, we need a way to track
the use of every registered memory region and only allow unregistration
if a region is not in use anymore. So we need a way to tell from what
region the just cleared TCE was from.

This adds a userspace view of the TCE table into iommu_table struct.
It contains userspace address, one per TCE entry. The table is only
allocated when the ownership over an IOMMU group is taken which means
it is only used from outside of the powernv code (such as VFIO).

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
[aw: for the vfio related changes]
Acked-by: Alex Williamson <alex.williamson@redhat.com>
---
Changes:
v11:
* mm_iommu_put() does not return a code so this does not check it
* moved "v2" in tce_container to pack the struct

v10:
* moved it_userspace allocation to vfio_iommu_spapr_tce as it VFIO
specific thing
* squashed "powerpc/iommu: Add userspace view of TCE table" into this as
it is
a part of IOMMU v2
* s/tce_iommu_use_page_v2/tce_iommu_prereg_ua_to_hpa/
* fixed some function names to have "tce_iommu_" in the beginning rather
just "tce_"
* as mm_iommu_mapped_inc() can now fail, check for the return code

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
 Documentation/vfio.txt              |  31 ++-
 arch/powerpc/include/asm/iommu.h    |   6 +
 drivers/vfio/vfio_iommu_spapr_tce.c | 512 ++++++++++++++++++++++++++++++------
 include/uapi/linux/vfio.h           |  27 ++
 4 files changed, 487 insertions(+), 89 deletions(-)

diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
index 96978ec..7dcf2b5 100644
--- a/Documentation/vfio.txt
+++ b/Documentation/vfio.txt
@@ -289,10 +289,12 @@ PPC64 sPAPR implementation note
 
 This implementation has some specifics:
 
-1) Only one IOMMU group per container is supported as an IOMMU group
-represents the minimal entity which isolation can be guaranteed for and
-groups are allocated statically, one per a Partitionable Endpoint (PE)
+1) On older systems (POWER7 with P5IOC2/IODA1) only one IOMMU group per
+container is supported as an IOMMU table is allocated at the boot time,
+one table per a IOMMU group which is a Partitionable Endpoint (PE)
 (PE is often a PCI domain but not always).
+Newer systems (POWER8 with IODA2) have improved hardware design which allows
+to remove this limitation and have multiple IOMMU groups per a VFIO container.
 
 2) The hardware supports so called DMA windows - the PCI address range
 within which DMA transfer is allowed, any attempt to access address space
@@ -427,6 +429,29 @@ The code flow from the example above should be slightly changed:
 
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
diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 9d37492..f9957eb 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -112,9 +112,15 @@ struct iommu_table {
 	unsigned long *it_map;       /* A simple allocation bitmap for now */
 	unsigned long  it_page_shift;/* table iommu page size */
 	struct list_head it_group_list;/* List of iommu_table_group_link */
+	unsigned long *it_userspace; /* userspace view of the table */
 	struct iommu_table_ops *it_ops;
 };
 
+#define IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry) \
+		((tbl)->it_userspace ? \
+			&((tbl)->it_userspace[(entry) - (tbl)->it_offset]) : \
+			NULL)
+
 /* Pure 2^n version of get_order */
 static inline __attribute_const__
 int get_iommu_order(unsigned long size, struct iommu_table *tbl)
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 7a84110..cadd9f8 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -19,8 +19,10 @@
 #include <linux/uaccess.h>
 #include <linux/err.h>
 #include <linux/vfio.h>
+#include <linux/vmalloc.h>
 #include <asm/iommu.h>
 #include <asm/tce.h>
+#include <asm/mmu_context.h>
 
 #define DRIVER_VERSION  "0.1"
 #define DRIVER_AUTHOR   "aik@ozlabs.ru"
@@ -81,6 +83,11 @@ static void decrement_locked_vm(long npages)
  * into DMA'ble space using the IOMMU
  */
 
+struct tce_iommu_group {
+	struct list_head next;
+	struct iommu_group *grp;
+};
+
 /*
  * The container descriptor supports only a single group per container.
  * Required by the API as the container is not supplied with the IOMMU group
@@ -88,11 +95,84 @@ static void decrement_locked_vm(long npages)
  */
 struct tce_container {
 	struct mutex lock;
-	struct iommu_group *grp;
 	bool enabled;
+	bool v2;
 	unsigned long locked_pages;
+	struct iommu_table *tables[IOMMU_TABLE_GROUP_MAX_TABLES];
+	struct list_head group_list;
 };
 
+static long tce_iommu_unregister_pages(struct tce_container *container,
+		__u64 vaddr, __u64 size)
+{
+	struct mm_iommu_table_group_mem_t *mem;
+
+	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK))
+		return -EINVAL;
+
+	mem = mm_iommu_lookup(vaddr, size >> PAGE_SHIFT);
+	if (!mem)
+		return -EINVAL;
+
+	return mm_iommu_put(mem);
+}
+
+static long tce_iommu_register_pages(struct tce_container *container,
+		__u64 vaddr, __u64 size)
+{
+	long ret = 0;
+	struct mm_iommu_table_group_mem_t *mem = NULL;
+	unsigned long entries = size >> PAGE_SHIFT;
+
+	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK) ||
+			((vaddr + size) < vaddr))
+		return -EINVAL;
+
+	ret = mm_iommu_get(vaddr, entries, &mem);
+	if (ret)
+		return ret;
+
+	container->enabled = true;
+
+	return 0;
+}
+
+static long tce_iommu_userspace_view_alloc(struct iommu_table *tbl)
+{
+	unsigned long cb = _ALIGN_UP(sizeof(tbl->it_userspace[0]) *
+			tbl->it_size, PAGE_SIZE);
+	unsigned long *uas;
+	long ret;
+
+	BUG_ON(tbl->it_userspace);
+
+	ret = try_increment_locked_vm(cb >> PAGE_SHIFT);
+	if (ret)
+		return ret;
+
+	uas = vzalloc(cb);
+	if (!uas) {
+		decrement_locked_vm(cb >> PAGE_SHIFT);
+		return -ENOMEM;
+	}
+	tbl->it_userspace = uas;
+
+	return 0;
+}
+
+static void tce_iommu_userspace_view_free(struct iommu_table *tbl)
+{
+	unsigned long cb = _ALIGN_UP(sizeof(tbl->it_userspace[0]) *
+			tbl->it_size, PAGE_SIZE);
+
+	if (!tbl->it_userspace)
+		return;
+
+	vfree(tbl->it_userspace);
+	tbl->it_userspace = NULL;
+	decrement_locked_vm(cb >> PAGE_SHIFT);
+}
+
 static bool tce_page_is_contained(struct page *page, unsigned page_shift)
 {
 	/*
@@ -103,18 +183,18 @@ static bool tce_page_is_contained(struct page *page, unsigned page_shift)
 	return (PAGE_SHIFT + compound_order(compound_head(page))) >= page_shift;
 }
 
+static inline bool tce_groups_attached(struct tce_container *container)
+{
+	return !list_empty(&container->group_list);
+}
+
 static long tce_iommu_find_table(struct tce_container *container,
 		phys_addr_t ioba, struct iommu_table **ptbl)
 {
 	long i;
-	struct iommu_table_group *table_group;
-
-	table_group = iommu_group_get_iommudata(container->grp);
-	if (!table_group)
-		return -1;
 
 	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
-		struct iommu_table *tbl = table_group->tables[i];
+		struct iommu_table *tbl = container->tables[i];
 
 		if (tbl) {
 			unsigned long entry = ioba >> tbl->it_page_shift;
@@ -136,9 +216,7 @@ static int tce_iommu_enable(struct tce_container *container)
 	int ret = 0;
 	unsigned long locked;
 	struct iommu_table_group *table_group;
-
-	if (!container->grp)
-		return -ENXIO;
+	struct tce_iommu_group *tcegrp;
 
 	if (!current->mm)
 		return -ESRCH; /* process exited */
@@ -175,7 +253,12 @@ static int tce_iommu_enable(struct tce_container *container)
 	 * as there is no way to know how much we should increment
 	 * the locked_vm counter.
 	 */
-	table_group = iommu_group_get_iommudata(container->grp);
+	if (!tce_groups_attached(container))
+		return -ENODEV;
+
+	tcegrp = list_first_entry(&container->group_list,
+			struct tce_iommu_group, next);
+	table_group = iommu_group_get_iommudata(tcegrp->grp);
 	if (!table_group)
 		return -ENODEV;
 
@@ -211,7 +294,7 @@ static void *tce_iommu_open(unsigned long arg)
 {
 	struct tce_container *container;
 
-	if (arg != VFIO_SPAPR_TCE_IOMMU) {
+	if ((arg != VFIO_SPAPR_TCE_IOMMU) && (arg != VFIO_SPAPR_TCE_v2_IOMMU)) {
 		pr_err("tce_vfio: Wrong IOMMU type\n");
 		return ERR_PTR(-EINVAL);
 	}
@@ -221,18 +304,45 @@ static void *tce_iommu_open(unsigned long arg)
 		return ERR_PTR(-ENOMEM);
 
 	mutex_init(&container->lock);
+	INIT_LIST_HEAD_RCU(&container->group_list);
+
+	container->v2 = arg == VFIO_SPAPR_TCE_v2_IOMMU;
 
 	return container;
 }
 
+static int tce_iommu_clear(struct tce_container *container,
+		struct iommu_table *tbl,
+		unsigned long entry, unsigned long pages);
+static void tce_iommu_free_table(struct iommu_table *tbl);
+
 static void tce_iommu_release(void *iommu_data)
 {
 	struct tce_container *container = iommu_data;
+	struct iommu_table_group *table_group;
+	struct tce_iommu_group *tcegrp;
+	long i;
 
-	WARN_ON(container->grp);
+	while (tce_groups_attached(container)) {
+		tcegrp = list_first_entry(&container->group_list,
+				struct tce_iommu_group, next);
+		table_group = iommu_group_get_iommudata(tcegrp->grp);
+		tce_iommu_detach_group(iommu_data, tcegrp->grp);
+	}
 
-	if (container->grp)
-		tce_iommu_detach_group(iommu_data, container->grp);
+	/*
+	 * If VFIO created a table, it was not disposed
+	 * by tce_iommu_detach_group() so do it now.
+	 */
+	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
+		struct iommu_table *tbl = container->tables[i];
+
+		if (!tbl)
+			continue;
+
+		tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
+		tce_iommu_free_table(tbl);
+	}
 
 	tce_iommu_disable(container);
 	mutex_destroy(&container->lock);
@@ -249,6 +359,47 @@ static void tce_iommu_unuse_page(struct tce_container *container,
 	put_page(page);
 }
 
+static int tce_iommu_prereg_ua_to_hpa(unsigned long tce, unsigned long size,
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
+	ret = tce_iommu_prereg_ua_to_hpa(*pua, IOMMU_PAGE_SIZE(tbl),
+			&hpa, &mem);
+	if (ret)
+		pr_debug("%s: tce %lx at #%lx was not cached, ret=%d\n",
+				__func__, *pua, entry, ret);
+	if (mem)
+		mm_iommu_mapped_dec(mem);
+
+	*pua = 0;
+}
+
 static int tce_iommu_clear(struct tce_container *container,
 		struct iommu_table *tbl,
 		unsigned long entry, unsigned long pages)
@@ -267,6 +418,11 @@ static int tce_iommu_clear(struct tce_container *container,
 		if (direction == DMA_NONE)
 			continue;
 
+		if (container->v2) {
+			tce_iommu_unuse_page_v2(tbl, entry);
+			continue;
+		}
+
 		tce_iommu_unuse_page(container, oldhpa);
 	}
 
@@ -333,6 +489,64 @@ static long tce_iommu_build(struct tce_container *container,
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
+		ret = tce_iommu_prereg_ua_to_hpa(tce, IOMMU_PAGE_SIZE(tbl),
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
+		/* The registered region is being unregistered */
+		if (mm_iommu_mapped_inc(mem))
+			break;
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
 static long tce_iommu_create_table(struct tce_container *container,
 			struct iommu_table_group *table_group,
 			int num,
@@ -358,6 +572,12 @@ static long tce_iommu_create_table(struct tce_container *container,
 	WARN_ON(!ret && !(*ptbl)->it_ops->free);
 	WARN_ON(!ret && ((*ptbl)->it_allocated_size != table_size));
 
+	if (!ret && container->v2) {
+		ret = tce_iommu_userspace_view_alloc(*ptbl);
+		if (ret)
+			(*ptbl)->it_ops->free(*ptbl);
+	}
+
 	if (ret)
 		decrement_locked_vm(table_size >> PAGE_SHIFT);
 
@@ -368,6 +588,7 @@ static void tce_iommu_free_table(struct iommu_table *tbl)
 {
 	unsigned long pages = tbl->it_allocated_size >> PAGE_SHIFT;
 
+	tce_iommu_userspace_view_free(tbl);
 	tbl->it_ops->free(tbl);
 	decrement_locked_vm(pages);
 }
@@ -383,6 +604,7 @@ static long tce_iommu_ioctl(void *iommu_data,
 	case VFIO_CHECK_EXTENSION:
 		switch (arg) {
 		case VFIO_SPAPR_TCE_IOMMU:
+		case VFIO_SPAPR_TCE_v2_IOMMU:
 			ret = 1;
 			break;
 		default:
@@ -394,12 +616,15 @@ static long tce_iommu_ioctl(void *iommu_data,
 
 	case VFIO_IOMMU_SPAPR_TCE_GET_INFO: {
 		struct vfio_iommu_spapr_tce_info info;
+		struct tce_iommu_group *tcegrp;
 		struct iommu_table_group *table_group;
 
-		if (WARN_ON(!container->grp))
+		if (!tce_groups_attached(container))
 			return -ENXIO;
 
-		table_group = iommu_group_get_iommudata(container->grp);
+		tcegrp = list_first_entry(&container->group_list,
+				struct tce_iommu_group, next);
+		table_group = iommu_group_get_iommudata(tcegrp->grp);
 
 		if (!table_group)
 			return -ENXIO;
@@ -468,11 +693,18 @@ static long tce_iommu_ioctl(void *iommu_data,
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
 
@@ -518,7 +750,61 @@ static long tce_iommu_ioctl(void *iommu_data,
 
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
+		ret = tce_iommu_register_pages(container, param.vaddr,
+				param.size);
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
+		ret = tce_iommu_unregister_pages(container, param.vaddr, param.size);
+		mutex_unlock(&container->lock);
+
+		return ret;
+	}
 	case VFIO_IOMMU_ENABLE:
+		if (container->v2)
+			break;
+
 		mutex_lock(&container->lock);
 		ret = tce_iommu_enable(container);
 		mutex_unlock(&container->lock);
@@ -526,16 +812,27 @@ static long tce_iommu_ioctl(void *iommu_data,
 
 
 	case VFIO_IOMMU_DISABLE:
+		if (container->v2)
+			break;
+
 		mutex_lock(&container->lock);
 		tce_iommu_disable(container);
 		mutex_unlock(&container->lock);
 		return 0;
-	case VFIO_EEH_PE_OP:
-		if (!container->grp)
-			return -ENODEV;
 
-		return vfio_spapr_iommu_eeh_ioctl(container->grp,
-						  cmd, arg);
+	case VFIO_EEH_PE_OP: {
+		struct tce_iommu_group *tcegrp;
+
+		ret = 0;
+		list_for_each_entry(tcegrp, &container->group_list, next) {
+			ret = vfio_spapr_iommu_eeh_ioctl(tcegrp->grp,
+					cmd, arg);
+			if (ret)
+				return ret;
+		}
+		return ret;
+	}
+
 	}
 
 	return -ENOTTY;
@@ -547,14 +844,17 @@ static void tce_iommu_release_ownership(struct tce_container *container,
 	int i;
 
 	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
-		struct iommu_table *tbl = table_group->tables[i];
+		struct iommu_table *tbl = container->tables[i];
 
 		if (!tbl)
 			continue;
 
 		tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
+		tce_iommu_userspace_view_free(tbl);
 		if (tbl->it_map)
 			iommu_release_ownership(tbl);
+
+		container->tables[i] = NULL;
 	}
 }
 
@@ -569,7 +869,10 @@ static int tce_iommu_take_ownership(struct tce_container *container,
 		if (!tbl || !tbl->it_map)
 			continue;
 
-		rc = iommu_take_ownership(tbl);
+		rc = tce_iommu_userspace_view_alloc(tbl);
+		if (!rc)
+			rc = iommu_take_ownership(tbl);
+
 		if (rc) {
 			for (j = 0; j < i; ++j)
 				iommu_release_ownership(
@@ -579,6 +882,9 @@ static int tce_iommu_take_ownership(struct tce_container *container,
 		}
 	}
 
+	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i)
+		container->tables[i] = table_group->tables[i];
+
 	return 0;
 }
 
@@ -592,18 +898,8 @@ static void tce_iommu_release_ownership_ddw(struct tce_container *container,
 		return;
 	}
 
-	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
-		/* Store table pointer as unset_window resets it */
-		struct iommu_table *tbl = table_group->tables[i];
-
-		if (!tbl)
-			continue;
-
+	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i)
 		table_group->ops->unset_window(table_group, i);
-		tce_iommu_clear(container, tbl,
-				tbl->it_offset, tbl->it_size);
-		tce_iommu_free_table(tbl);
-	}
 
 	table_group->ops->release_ownership(table_group);
 }
@@ -611,7 +907,7 @@ static void tce_iommu_release_ownership_ddw(struct tce_container *container,
 static long tce_iommu_take_ownership_ddw(struct tce_container *container,
 		struct iommu_table_group *table_group)
 {
-	long ret;
+	long i, ret = 0;
 	struct iommu_table *tbl = NULL;
 
 	if (!table_group->ops->create_table || !table_group->ops->set_window ||
@@ -622,23 +918,45 @@ static long tce_iommu_take_ownership_ddw(struct tce_container *container,
 
 	table_group->ops->take_ownership(table_group);
 
-	ret = tce_iommu_create_table(container,
-			table_group,
-			0, /* window number */
-			IOMMU_PAGE_SHIFT_4K,
-			table_group->tce32_size,
-			1, /* default levels */
-			&tbl);
-	if (!ret) {
-		ret = table_group->ops->set_window(table_group, 0, tbl);
+	/*
+	 * If it the first group attached, check if there is
+	 * a default DMA window and create one if none as
+	 * the userspace expects it to exist.
+	 */
+	if (!tce_groups_attached(container) && !container->tables[0]) {
+		ret = tce_iommu_create_table(container,
+				table_group,
+				0, /* window number */
+				IOMMU_PAGE_SHIFT_4K,
+				table_group->tce32_size,
+				1, /* default levels */
+				&tbl);
 		if (ret)
-			tce_iommu_free_table(tbl);
+			goto release_exit;
 		else
-			table_group->tables[0] = tbl;
+			container->tables[0] = tbl;
 	}
 
-	if (ret)
-		table_group->ops->release_ownership(table_group);
+	/* Set all windows to the new group */
+	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
+		tbl = container->tables[i];
+
+		if (!tbl)
+			continue;
+
+		/* Set the default window to a new group */
+		ret = table_group->ops->set_window(table_group, i, tbl);
+		if (ret)
+			goto release_exit;
+	}
+
+	return 0;
+
+release_exit:
+	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i)
+		table_group->ops->unset_window(table_group, i);
+
+	table_group->ops->release_ownership(table_group);
 
 	return ret;
 }
@@ -649,29 +967,44 @@ static int tce_iommu_attach_group(void *iommu_data,
 	int ret;
 	struct tce_container *container = iommu_data;
 	struct iommu_table_group *table_group;
+	struct tce_iommu_group *tcegrp = NULL;
 
 	mutex_lock(&container->lock);
 
 	/* pr_debug("tce_vfio: Attaching group #%u to iommu %p\n",
 			iommu_group_id(iommu_group), iommu_group); */
-	if (container->grp) {
-		pr_warn("tce_vfio: Only one group per IOMMU container is allowed, existing id=%d, attaching id=%d\n",
-				iommu_group_id(container->grp),
-				iommu_group_id(iommu_group));
-		ret = -EBUSY;
-		goto unlock_exit;
-	}
-
-	if (container->enabled) {
-		pr_err("tce_vfio: attaching group #%u to enabled container\n",
-				iommu_group_id(iommu_group));
-		ret = -EBUSY;
-		goto unlock_exit;
-	}
-
 	table_group = iommu_group_get_iommudata(iommu_group);
-	if (!table_group) {
-		ret = -ENXIO;
+
+	if (tce_groups_attached(container) && (!table_group->ops ||
+			!table_group->ops->take_ownership ||
+			!table_group->ops->release_ownership)) {
+		ret = -EBUSY;
+		goto unlock_exit;
+	}
+
+	/* Check if new group has the same iommu_ops (i.e. compatible) */
+	list_for_each_entry(tcegrp, &container->group_list, next) {
+		struct iommu_table_group *table_group_tmp;
+
+		if (tcegrp->grp == iommu_group) {
+			pr_warn("tce_vfio: Group %d is already attached\n",
+					iommu_group_id(iommu_group));
+			ret = -EBUSY;
+			goto unlock_exit;
+		}
+		table_group_tmp = iommu_group_get_iommudata(tcegrp->grp);
+		if (table_group_tmp->ops != table_group->ops) {
+			pr_warn("tce_vfio: Group %d is incompatible with group %d\n",
+					iommu_group_id(iommu_group),
+					iommu_group_id(tcegrp->grp));
+			ret = -EPERM;
+			goto unlock_exit;
+		}
+	}
+
+	tcegrp = kzalloc(sizeof(*tcegrp), GFP_KERNEL);
+	if (!tcegrp) {
+		ret = -ENOMEM;
 		goto unlock_exit;
 	}
 
@@ -681,10 +1014,15 @@ static int tce_iommu_attach_group(void *iommu_data,
 	else
 		ret = tce_iommu_take_ownership_ddw(container, table_group);
 
-	if (!ret)
-		container->grp = iommu_group;
+	if (!ret) {
+		tcegrp->grp = iommu_group;
+		list_add(&tcegrp->next, &container->group_list);
+	}
 
 unlock_exit:
+	if (ret && tcegrp)
+		kfree(tcegrp);
+
 	mutex_unlock(&container->lock);
 
 	return ret;
@@ -695,24 +1033,26 @@ static void tce_iommu_detach_group(void *iommu_data,
 {
 	struct tce_container *container = iommu_data;
 	struct iommu_table_group *table_group;
+	bool found = false;
+	struct tce_iommu_group *tcegrp;
 
 	mutex_lock(&container->lock);
-	if (iommu_group != container->grp) {
-		pr_warn("tce_vfio: detaching group #%u, expected group is #%u\n",
-				iommu_group_id(iommu_group),
-				iommu_group_id(container->grp));
+
+	list_for_each_entry(tcegrp, &container->group_list, next) {
+		if (tcegrp->grp == iommu_group) {
+			found = true;
+			break;
+		}
+	}
+
+	if (!found) {
+		pr_warn("tce_vfio: detaching unattached group #%u\n",
+				iommu_group_id(iommu_group));
 		goto unlock_exit;
 	}
 
-	if (container->enabled) {
-		pr_warn("tce_vfio: detaching group #%u from enabled container, forcing disable\n",
-				iommu_group_id(container->grp));
-		tce_iommu_disable(container);
-	}
-
-	/* pr_debug("tce_vfio: detaching group #%u from iommu %p\n",
-	   iommu_group_id(iommu_group), iommu_group); */
-	container->grp = NULL;
+	list_del(&tcegrp->next);
+	kfree(tcegrp);
 
 	table_group = iommu_group_get_iommudata(iommu_group);
 	BUG_ON(!table_group);
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
2.4.0.rc3.8.gfb3e7d5
