Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [83.169.36.222])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tZ7bR2vX2zDw5F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Dec 2016 19:20:35 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel 9/9] KVM: PPC: Add in-kernel acceleration for VFIO
Date: Thu,  8 Dec 2016 19:19:56 +1100
Message-Id: <20161208081956.26221-10-aik@ozlabs.ru>
In-Reply-To: <20161208081956.26221-1-aik@ozlabs.ru>
References: <20161208081956.26221-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This allows the host kernel to handle H_PUT_TCE, H_PUT_TCE_INDIRECT
and H_STUFF_TCE requests targeted an IOMMU TCE table used for VFIO
without passing them to user space which saves time on switching
to user space and back.

This adds H_PUT_TCE/H_PUT_TCE_INDIRECT/H_STUFF_TCE handlers to KVM.
KVM tries to handle a TCE request in the real mode, if failed
it passes the request to the virtual mode to complete the operation.
If it a virtual mode handler fails, the request is passed to
the user space; this is not expected to happen though.

To avoid dealing with page use counters (which is tricky in real mode),
this only accelerates SPAPR TCE IOMMU v2 clients which are required
to pre-register the userspace memory. The very first TCE request will
be handled in the VFIO SPAPR TCE driver anyway as the userspace view
of the TCE table (iommu_table::it_userspace) is not allocated till
the very first mapping happens and we cannot call vmalloc in real mode.

This adds new attribute - KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE - to
the VFIO KVM device. It takes a VFIO group fd and SPAPR TCE table fd
and associates a physical IOMMU table with the SPAPR TCE table (which
is a guest view of the hardware IOMMU table). The iommu_table object
is referenced so we do not have to retrieve in real mode when hypercall
happens.

This does not implement the UNSET counterpart as there is no use for it -
once the acceleration is enabled, the existing userspace won't
disable it unless a VFIO container is detroyed so this adds necessary
cleanup to the KVM_DEV_VFIO_GROUP_DEL handler.

This uses the kvm->lock mutex to protect against a race between
the VFIO KVM device's kvm_vfio_destroy() and SPAPR TCE table fd's
release() callback.

This advertises the new KVM_CAP_SPAPR_TCE_VFIO capability to the user
space.

This finally makes use of vfio_external_user_iommu_id() which was
introduced quite some time ago and was considered for removal.

Tests show that this patch increases transmission speed from 220MB/s
to 750..1020MB/s on 10Gb network (Chelsea CXGB3 10Gb ethernet card).

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 Documentation/virtual/kvm/devices/vfio.txt |  21 +-
 arch/powerpc/include/asm/kvm_host.h        |   8 +
 arch/powerpc/include/asm/kvm_ppc.h         |   5 +
 include/uapi/linux/kvm.h                   |   8 +
 arch/powerpc/kvm/book3s_64_vio.c           | 302 +++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_64_vio_hv.c        | 178 +++++++++++++++++
 arch/powerpc/kvm/powerpc.c                 |   2 +
 virt/kvm/vfio.c                            | 108 +++++++++++
 8 files changed, 630 insertions(+), 2 deletions(-)

diff --git a/Documentation/virtual/kvm/devices/vfio.txt b/Documentation/virtual/kvm/devices/vfio.txt
index ef51740c67ca..ddb5a6512ab3 100644
--- a/Documentation/virtual/kvm/devices/vfio.txt
+++ b/Documentation/virtual/kvm/devices/vfio.txt
@@ -16,7 +16,24 @@ Groups:
 
 KVM_DEV_VFIO_GROUP attributes:
   KVM_DEV_VFIO_GROUP_ADD: Add a VFIO group to VFIO-KVM device tracking
+	kvm_device_attr.addr points to an int32_t file descriptor
+	for the VFIO group.
   KVM_DEV_VFIO_GROUP_DEL: Remove a VFIO group from VFIO-KVM device tracking
+	kvm_device_attr.addr points to an int32_t file descriptor
+	for the VFIO group.
+  KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE: attaches a guest visible TCE table
+	allocated by sPAPR KVM.
+	kvm_device_attr.addr points to a struct:
 
-For each, kvm_device_attr.addr points to an int32_t file descriptor
-for the VFIO group.
+	struct kvm_vfio_spapr_tce {
+		__u32	argsz;
+		__s32	groupfd;
+		__s32	tablefd;
+		__u8	pad[4];
+	};
+
+	where
+	@argsz is the size of kvm_vfio_spapr_tce_liobn;
+	@groupfd is a file descriptor for a VFIO group;
+	@tablefd is a file descriptor for a TCE table allocated via
+		KVM_CREATE_SPAPR_TCE.
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 28350a294b1e..94774503c70d 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -191,6 +191,13 @@ struct kvmppc_pginfo {
 	atomic_t refcnt;
 };
 
+struct kvmppc_spapr_tce_iommu_table {
+	struct rcu_head rcu;
+	struct list_head next;
+	struct iommu_table *tbl;
+	atomic_t refs;
+};
+
 struct kvmppc_spapr_tce_table {
 	struct list_head list;
 	struct kvm *kvm;
@@ -199,6 +206,7 @@ struct kvmppc_spapr_tce_table {
 	u32 page_shift;
 	u64 offset;		/* in pages */
 	u64 size;		/* window size in pages */
+	struct list_head iommu_tables;
 	struct page *pages[0];
 };
 
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 0a21c8503974..17b947a0060d 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -163,6 +163,11 @@ extern long kvmppc_prepare_vrma(struct kvm *kvm,
 extern void kvmppc_map_vrma(struct kvm_vcpu *vcpu,
 			struct kvm_memory_slot *memslot, unsigned long porder);
 extern int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu);
+extern long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm,
+				int tablefd,
+				struct iommu_group *grp);
+extern void kvm_spapr_tce_detach_iommu_group(struct kvm *kvm,
+				struct iommu_group *grp);
 
 extern long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 				struct kvm_create_spapr_tce_64 *args);
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 810f74317987..9e4025724e28 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1068,6 +1068,7 @@ struct kvm_device_attr {
 #define  KVM_DEV_VFIO_GROUP			1
 #define   KVM_DEV_VFIO_GROUP_ADD			1
 #define   KVM_DEV_VFIO_GROUP_DEL			2
+#define   KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE		3
 
 enum kvm_device_type {
 	KVM_DEV_TYPE_FSL_MPIC_20	= 1,
@@ -1089,6 +1090,13 @@ enum kvm_device_type {
 	KVM_DEV_TYPE_MAX,
 };
 
+struct kvm_vfio_spapr_tce {
+	__u32	argsz;
+	__s32	groupfd;
+	__s32	tablefd;
+	__u8	pad[4];
+};
+
 /*
  * ioctls for VM fds
  */
diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 15df8ae627d9..f86d07781ee9 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -27,6 +27,8 @@
 #include <linux/hugetlb.h>
 #include <linux/list.h>
 #include <linux/anon_inodes.h>
+#include <linux/iommu.h>
+#include <linux/file.h>
 
 #include <asm/tlbflush.h>
 #include <asm/kvm_ppc.h>
@@ -39,6 +41,7 @@
 #include <asm/udbg.h>
 #include <asm/iommu.h>
 #include <asm/tce.h>
+#include <asm/mmu_context.h>
 
 static unsigned long kvmppc_tce_pages(unsigned long iommu_pages)
 {
@@ -90,6 +93,25 @@ static long kvmppc_account_memlimit(unsigned long stt_pages, bool inc)
 	return ret;
 }
 
+static void kvm_spapr_tce_iommu_table_free(struct rcu_head *head)
+{
+	struct kvmppc_spapr_tce_iommu_table *stit = container_of(head,
+			struct kvmppc_spapr_tce_iommu_table, rcu);
+
+	kfree(stit);
+}
+
+static void kvm_spapr_tce_iommu_table_put(
+		struct kvmppc_spapr_tce_iommu_table *stit)
+{
+	iommu_table_put(stit->tbl);
+	if (atomic_dec_return(&stit->refs))
+		return;
+
+	list_del_rcu(&stit->next);
+	call_rcu(&stit->rcu, kvm_spapr_tce_iommu_table_free);
+}
+
 static void release_spapr_tce_table(struct rcu_head *head)
 {
 	struct kvmppc_spapr_tce_table *stt = container_of(head,
@@ -130,8 +152,23 @@ static int kvm_spapr_tce_release(struct inode *inode, struct file *filp)
 {
 	struct kvmppc_spapr_tce_table *stt = filp->private_data;
 
+	kick_all_cpus_sync();
 	list_del_rcu(&stt->list);
 
+	mutex_lock(&stt->kvm->lock);
+
+	while (!list_empty(&stt->iommu_tables)) {
+		struct kvmppc_spapr_tce_iommu_table *stit;
+
+		stit = list_first_entry(&stt->iommu_tables,
+				struct kvmppc_spapr_tce_iommu_table, next);
+
+		while (atomic_read(&stit->refs))
+			kvm_spapr_tce_iommu_table_put(stit);
+	}
+
+	mutex_unlock(&stt->kvm->lock);
+
 	kvm_put_kvm(stt->kvm);
 
 	kvmppc_account_memlimit(
@@ -146,6 +183,98 @@ static const struct file_operations kvm_spapr_tce_fops = {
 	.release	= kvm_spapr_tce_release,
 };
 
+extern long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int tablefd,
+		struct iommu_group *grp)
+{
+	struct kvmppc_spapr_tce_table *stt = NULL;
+	bool found = false;
+	struct iommu_table *tbl = NULL;
+	struct iommu_table_group *table_group;
+	long i;
+	struct kvmppc_spapr_tce_iommu_table *stit;
+	struct fd f;
+
+	f = fdget(tablefd);
+	if (!f.file)
+		return -EBADF;
+
+	list_for_each_entry_rcu(stt, &kvm->arch.spapr_tce_tables, list) {
+		if (stt == f.file->private_data) {
+			found = true;
+			break;
+		}
+	}
+
+	fdput(f);
+
+	if (!found)
+		return -ENODEV;
+
+	table_group = iommu_group_get_iommudata(grp);
+	if (!table_group)
+		return -EFAULT;
+
+	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
+		struct iommu_table *tbltmp = table_group->tables[i];
+
+		if (!tbltmp)
+			continue;
+
+		if ((tbltmp->it_page_shift == stt->page_shift) &&
+				(tbltmp->it_offset == stt->offset)) {
+			tbl = tbltmp;
+			break;
+		}
+	}
+	if (!tbl)
+		return -ENODEV;
+
+	iommu_table_get(tbl);
+
+	list_for_each_entry_rcu(stit, &stt->iommu_tables, next) {
+		if (stit->tbl == tbl) {
+			atomic_inc(&stit->refs);
+			return 0;
+		}
+	}
+
+	stit = kzalloc(sizeof(*stit), GFP_KERNEL);
+	stit->tbl = tbl;
+	atomic_set(&stit->refs, 1);
+	list_add_rcu(&stit->next, &stt->iommu_tables);
+
+	return 0;
+}
+
+extern void kvm_spapr_tce_detach_iommu_group(struct kvm *kvm,
+		struct iommu_group *grp)
+{
+	struct kvmppc_spapr_tce_table *stt;
+	struct iommu_table_group *table_group;
+	struct kvmppc_spapr_tce_iommu_table *stit;
+
+	table_group = iommu_group_get_iommudata(grp);
+	if (!table_group)
+		return;
+
+	mutex_lock(&kvm->lock);
+
+	list_for_each_entry_rcu(stt, &kvm->arch.spapr_tce_tables, list) {
+		list_for_each_entry_rcu(stit, &stt->iommu_tables, next) {
+			long i;
+
+			for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
+				if (stit->tbl != table_group->tables[i])
+					continue;
+
+				kvm_spapr_tce_iommu_table_put(stit);
+			}
+		}
+	}
+
+	mutex_unlock(&kvm->lock);
+}
+
 long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 				   struct kvm_create_spapr_tce_64 *args)
 {
@@ -181,6 +310,7 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 	stt->offset = args->offset;
 	stt->size = size;
 	stt->kvm = kvm;
+	INIT_LIST_HEAD_RCU(&stt->iommu_tables);
 
 	for (i = 0; i < npages; i++) {
 		stt->pages[i] = alloc_page(GFP_KERNEL | __GFP_ZERO);
@@ -209,11 +339,161 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 	return ret;
 }
 
+static long kvmppc_tce_iommu_mapped_dec(struct kvm *kvm,
+		struct iommu_table *tbl, unsigned long entry)
+{
+	struct mm_iommu_table_group_mem_t *mem = NULL;
+	const unsigned long pgsize = 1ULL << tbl->it_page_shift;
+	unsigned long *pua = IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
+
+	if (!pua)
+		return H_HARDWARE;
+
+	mem = mm_iommu_lookup(kvm->mm, *pua, pgsize);
+	if (!mem)
+		return H_HARDWARE;
+
+	mm_iommu_mapped_dec(mem);
+
+	*pua = 0;
+
+	return H_SUCCESS;
+}
+
+static long kvmppc_tce_iommu_unmap(struct kvm *kvm,
+		struct iommu_table *tbl, unsigned long entry)
+{
+	enum dma_data_direction dir = DMA_NONE;
+	unsigned long hpa = 0;
+
+	if (iommu_tce_xchg(tbl, entry, &hpa, &dir))
+		return H_HARDWARE;
+
+	if (dir == DMA_NONE)
+		return H_SUCCESS;
+
+	return kvmppc_tce_iommu_mapped_dec(kvm, tbl, entry);
+}
+
+long kvmppc_tce_iommu_map(struct kvm *kvm, struct iommu_table *tbl,
+		unsigned long entry, unsigned long gpa,
+		enum dma_data_direction dir)
+{
+	long ret;
+	unsigned long hpa, ua, *pua = IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
+	struct mm_iommu_table_group_mem_t *mem;
+
+	if (!pua)
+		/* it_userspace allocation might be delayed */
+		return H_TOO_HARD;
+
+	if (kvmppc_gpa_to_ua(kvm, gpa, &ua, NULL))
+		return H_HARDWARE;
+
+	mem = mm_iommu_lookup(kvm->mm, ua, 1ULL << tbl->it_page_shift);
+	if (!mem)
+		return H_HARDWARE;
+
+	if (mm_iommu_ua_to_hpa(mem, ua, &hpa))
+		return H_HARDWARE;
+
+	if (mm_iommu_mapped_inc(mem))
+		return H_HARDWARE;
+
+	ret = iommu_tce_xchg(tbl, entry, &hpa, &dir);
+	if (ret) {
+		mm_iommu_mapped_dec(mem);
+		return H_TOO_HARD;
+	}
+
+	if (dir != DMA_NONE)
+		kvmppc_tce_iommu_mapped_dec(kvm, tbl, entry);
+
+	*pua = ua;
+
+	return 0;
+}
+
+long kvmppc_h_put_tce_iommu(struct kvm_vcpu *vcpu,
+		struct iommu_table *tbl,
+		unsigned long liobn, unsigned long ioba,
+		unsigned long tce)
+{
+	long idx, ret = H_HARDWARE;
+	const unsigned long entry = ioba >> tbl->it_page_shift;
+	const unsigned long gpa = tce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
+	const enum dma_data_direction dir = iommu_tce_direction(tce);
+
+	/* Clear TCE */
+	if (dir == DMA_NONE) {
+		if (iommu_tce_clear_param_check(tbl, ioba, 0, 1))
+			return H_PARAMETER;
+
+		return kvmppc_tce_iommu_unmap(vcpu->kvm, tbl, entry);
+	}
+
+	/* Put TCE */
+	if (iommu_tce_put_param_check(tbl, ioba, gpa))
+		return H_PARAMETER;
+
+	idx = srcu_read_lock(&vcpu->kvm->srcu);
+	ret = kvmppc_tce_iommu_map(vcpu->kvm, tbl, entry, gpa, dir);
+	srcu_read_unlock(&vcpu->kvm->srcu, idx);
+
+	return ret;
+}
+
+static long kvmppc_h_put_tce_indirect_iommu(struct kvm_vcpu *vcpu,
+		struct iommu_table *tbl, unsigned long ioba,
+		u64 __user *tces, unsigned long npages)
+{
+	unsigned long i, ret, tce, gpa;
+	const unsigned long entry = ioba >> tbl->it_page_shift;
+
+	for (i = 0; i < npages; ++i) {
+		gpa = be64_to_cpu(tces[i]) & ~(TCE_PCI_READ | TCE_PCI_WRITE);
+
+		if (iommu_tce_put_param_check(tbl, ioba +
+				(i << tbl->it_page_shift), gpa))
+			return H_PARAMETER;
+	}
+
+	for (i = 0; i < npages; ++i) {
+		tce = be64_to_cpu(tces[i]);
+		gpa = tce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
+
+		ret = kvmppc_tce_iommu_map(vcpu->kvm, tbl, entry + i, gpa,
+				iommu_tce_direction(tce));
+		if (ret != H_SUCCESS)
+			return ret;
+	}
+
+	return H_SUCCESS;
+}
+
+long kvmppc_h_stuff_tce_iommu(struct kvm_vcpu *vcpu,
+		struct iommu_table *tbl,
+		unsigned long liobn, unsigned long ioba,
+		unsigned long tce_value, unsigned long npages)
+{
+	unsigned long i;
+	const unsigned long entry = ioba >> tbl->it_page_shift;
+
+	if (iommu_tce_clear_param_check(tbl, ioba, tce_value, npages))
+		return H_PARAMETER;
+
+	for (i = 0; i < npages; ++i)
+		kvmppc_tce_iommu_unmap(vcpu->kvm, tbl, entry + i);
+
+	return H_SUCCESS;
+}
+
 long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 		      unsigned long ioba, unsigned long tce)
 {
 	struct kvmppc_spapr_tce_table *stt;
 	long ret;
+	struct kvmppc_spapr_tce_iommu_table *stit;
 
 	/* udbg_printf("H_PUT_TCE(): liobn=0x%lx ioba=0x%lx, tce=0x%lx\n", */
 	/* 	    liobn, ioba, tce); */
@@ -230,6 +510,12 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 	if (ret != H_SUCCESS)
 		return ret;
 
+	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
+		ret = kvmppc_h_put_tce_iommu(vcpu, stit->tbl, liobn, ioba, tce);
+		if (ret != H_SUCCESS)
+			return ret;
+	}
+
 	kvmppc_tce_put(stt, ioba >> stt->page_shift, tce);
 
 	return H_SUCCESS;
@@ -245,6 +531,7 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 	unsigned long entry, ua = 0;
 	u64 __user *tces;
 	u64 tce;
+	struct kvmppc_spapr_tce_iommu_table *stit;
 
 	stt = kvmppc_find_table(vcpu->kvm, liobn);
 	if (!stt)
@@ -272,6 +559,13 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 	}
 	tces = (u64 __user *) ua;
 
+	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
+		ret = kvmppc_h_put_tce_indirect_iommu(vcpu,
+				stit->tbl, ioba, tces, npages);
+		if (ret != H_SUCCESS)
+			goto unlock_exit;
+	}
+
 	for (i = 0; i < npages; ++i) {
 		if (get_user(tce, tces + i)) {
 			ret = H_TOO_HARD;
@@ -299,6 +593,7 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
 {
 	struct kvmppc_spapr_tce_table *stt;
 	long i, ret;
+	struct kvmppc_spapr_tce_iommu_table *stit;
 
 	stt = kvmppc_find_table(vcpu->kvm, liobn);
 	if (!stt)
@@ -312,6 +607,13 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
 	if (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ))
 		return H_PARAMETER;
 
+	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
+		ret = kvmppc_h_stuff_tce_iommu(vcpu, stit->tbl, liobn, ioba,
+				tce_value, npages);
+		if (ret != H_SUCCESS)
+			return ret;
+	}
+
 	for (i = 0; i < npages; ++i, ioba += (1ULL << stt->page_shift))
 		kvmppc_tce_put(stt, ioba >> stt->page_shift, tce_value);
 
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 8a6834e6e1c8..4d6f01712a6d 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -190,11 +190,165 @@ static struct mm_iommu_table_group_mem_t *kvmppc_rm_iommu_lookup(
 	return mm_iommu_lookup_rm(vcpu->kvm->mm, ua, size);
 }
 
+static long kvmppc_rm_tce_iommu_mapped_dec(struct kvm_vcpu *vcpu,
+		struct iommu_table *tbl, unsigned long entry)
+{
+	struct mm_iommu_table_group_mem_t *mem = NULL;
+	const unsigned long pgsize = 1ULL << tbl->it_page_shift;
+	unsigned long *pua = IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
+
+	if (!pua)
+		return H_SUCCESS;
+
+	pua = (void *) vmalloc_to_phys(pua);
+	if (!pua)
+		return H_SUCCESS;
+
+	mem = kvmppc_rm_iommu_lookup(vcpu, *pua, pgsize);
+	if (!mem)
+		return H_HARDWARE;
+
+	mm_iommu_mapped_dec(mem);
+
+	*pua = 0;
+
+	return H_SUCCESS;
+}
+
+static long kvmppc_rm_tce_iommu_unmap(struct kvm_vcpu *vcpu,
+		struct iommu_table *tbl, unsigned long entry)
+{
+	enum dma_data_direction dir = DMA_NONE;
+	unsigned long hpa = 0;
+
+	if (iommu_tce_xchg_rm(tbl, entry, &hpa, &dir))
+		return H_HARDWARE;
+
+	if (dir == DMA_NONE)
+		return H_SUCCESS;
+
+	return kvmppc_rm_tce_iommu_mapped_dec(vcpu, tbl, entry);
+}
+
+long kvmppc_rm_tce_iommu_map(struct kvm_vcpu *vcpu, struct iommu_table *tbl,
+		unsigned long entry, unsigned long gpa,
+		enum dma_data_direction dir)
+{
+	long ret;
+	unsigned long hpa = 0, ua;
+	unsigned long *pua = IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
+	struct mm_iommu_table_group_mem_t *mem;
+
+	if (!pua)
+		/* it_userspace allocation might be delayed */
+		return H_TOO_HARD;
+
+	if (kvmppc_gpa_to_ua(vcpu->kvm, gpa, &ua, NULL))
+		return H_HARDWARE;
+
+	mem = kvmppc_rm_iommu_lookup(vcpu, ua, 1ULL << tbl->it_page_shift);
+	if (!mem)
+		return H_HARDWARE;
+
+	if (mm_iommu_ua_to_hpa_rm(mem, ua, &hpa))
+		return H_HARDWARE;
+
+	pua = (void *) vmalloc_to_phys(pua);
+	if (!pua)
+		return H_HARDWARE;
+
+	if (mm_iommu_mapped_inc(mem))
+		return H_HARDWARE;
+
+	ret = iommu_tce_xchg_rm(tbl, entry, &hpa, &dir);
+	if (ret) {
+		mm_iommu_mapped_dec(mem);
+		return H_TOO_HARD;
+	}
+
+	if (dir != DMA_NONE)
+		kvmppc_rm_tce_iommu_mapped_dec(vcpu, tbl, entry);
+
+	*pua = ua;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kvmppc_rm_tce_iommu_map);
+
+static long kvmppc_rm_h_put_tce_iommu(struct kvm_vcpu *vcpu,
+		struct iommu_table *tbl, unsigned long liobn,
+		unsigned long ioba, unsigned long tce)
+{
+	const unsigned long entry = ioba >> tbl->it_page_shift;
+	const unsigned long gpa = tce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
+	const enum dma_data_direction dir = iommu_tce_direction(tce);
+
+	/* Clear TCE */
+	if (dir == DMA_NONE) {
+		if (iommu_tce_clear_param_check(tbl, ioba, 0, 1))
+			return H_PARAMETER;
+
+		return kvmppc_rm_tce_iommu_unmap(vcpu, tbl, entry);
+	}
+
+	/* Put TCE */
+	if (iommu_tce_put_param_check(tbl, ioba, gpa))
+		return H_PARAMETER;
+
+	return kvmppc_rm_tce_iommu_map(vcpu, tbl, entry, gpa, dir);
+}
+
+static long kvmppc_rm_h_put_tce_indirect_iommu(struct kvm_vcpu *vcpu,
+		struct iommu_table *tbl, unsigned long ioba,
+		u64 *tces, unsigned long npages)
+{
+	unsigned long i, ret, tce, gpa;
+	const unsigned long entry = ioba >> tbl->it_page_shift;
+
+	for (i = 0; i < npages; ++i) {
+		gpa = be64_to_cpu(tces[i]) & ~(TCE_PCI_READ | TCE_PCI_WRITE);
+
+		if (iommu_tce_put_param_check(tbl, ioba +
+				(i << tbl->it_page_shift), gpa))
+			return H_PARAMETER;
+	}
+
+	for (i = 0; i < npages; ++i) {
+		tce = be64_to_cpu(tces[i]);
+		gpa = tce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
+
+		ret = kvmppc_rm_tce_iommu_map(vcpu, tbl, entry + i, gpa,
+				iommu_tce_direction(tce));
+		if (ret != H_SUCCESS)
+			return ret;
+	}
+
+	return H_SUCCESS;
+}
+
+static long kvmppc_rm_h_stuff_tce_iommu(struct kvm_vcpu *vcpu,
+		struct iommu_table *tbl,
+		unsigned long liobn, unsigned long ioba,
+		unsigned long tce_value, unsigned long npages)
+{
+	unsigned long i;
+	const unsigned long entry = ioba >> tbl->it_page_shift;
+
+	if (iommu_tce_clear_param_check(tbl, ioba, tce_value, npages))
+		return H_PARAMETER;
+
+	for (i = 0; i < npages; ++i)
+		kvmppc_rm_tce_iommu_unmap(vcpu, tbl, entry + i);
+
+	return H_SUCCESS;
+}
+
 long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 		unsigned long ioba, unsigned long tce)
 {
 	struct kvmppc_spapr_tce_table *stt;
 	long ret;
+	struct kvmppc_spapr_tce_iommu_table *stit;
 
 	/* udbg_printf("H_PUT_TCE(): liobn=0x%lx ioba=0x%lx, tce=0x%lx\n", */
 	/* 	    liobn, ioba, tce); */
@@ -211,6 +365,13 @@ long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 	if (ret != H_SUCCESS)
 		return ret;
 
+	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
+		ret = kvmppc_rm_h_put_tce_iommu(vcpu, stit->tbl,
+				liobn, ioba, tce);
+		if (ret != H_SUCCESS)
+			return ret;
+	}
+
 	kvmppc_tce_put(stt, ioba >> stt->page_shift, tce);
 
 	return H_SUCCESS;
@@ -278,6 +439,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 		 * depend on hpt.
 		 */
 		struct mm_iommu_table_group_mem_t *mem;
+		struct kvmppc_spapr_tce_iommu_table *stit;
 
 		if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, NULL))
 			return H_TOO_HARD;
@@ -285,6 +447,13 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 		mem = kvmppc_rm_iommu_lookup(vcpu, ua, IOMMU_PAGE_SIZE_4K);
 		if (!mem || mm_iommu_ua_to_hpa_rm(mem, ua, &tces))
 			return H_TOO_HARD;
+
+		list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
+			ret = kvmppc_rm_h_put_tce_indirect_iommu(vcpu,
+					stit->tbl, ioba, (u64 *)tces, npages);
+			if (ret != H_SUCCESS)
+				return ret;
+		}
 	} else {
 		/*
 		 * This is emulated devices case.
@@ -334,6 +503,8 @@ long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
 {
 	struct kvmppc_spapr_tce_table *stt;
 	long i, ret;
+	struct kvmppc_spapr_tce_iommu_table *stit;
+
 
 	stt = kvmppc_find_table(vcpu->kvm, liobn);
 	if (!stt)
@@ -347,6 +518,13 @@ long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
 	if (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ))
 		return H_PARAMETER;
 
+	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
+		ret = kvmppc_rm_h_stuff_tce_iommu(vcpu, stit->tbl,
+				liobn, ioba, tce_value, npages);
+		if (ret != H_SUCCESS)
+			return ret;
+	}
+
 	for (i = 0; i < npages; ++i, ioba += (1ULL << stt->page_shift))
 		kvmppc_tce_put(stt, ioba >> stt->page_shift, tce_value);
 
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 70963c845e96..0e555ba998c0 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -536,6 +536,8 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 #ifdef CONFIG_PPC_BOOK3S_64
 	case KVM_CAP_SPAPR_TCE:
 	case KVM_CAP_SPAPR_TCE_64:
+		/* fallthrough */
+	case KVM_CAP_SPAPR_TCE_VFIO:
 	case KVM_CAP_PPC_ALLOC_HTAB:
 	case KVM_CAP_PPC_RTAS:
 	case KVM_CAP_PPC_FIXUP_HCALL:
diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
index 1dd087da6f31..e82182f9dea9 100644
--- a/virt/kvm/vfio.c
+++ b/virt/kvm/vfio.c
@@ -20,6 +20,10 @@
 #include <linux/vfio.h>
 #include "vfio.h"
 
+#ifdef CONFIG_SPAPR_TCE_IOMMU
+#include <asm/kvm_ppc.h>
+#endif
+
 struct kvm_vfio_group {
 	struct list_head node;
 	struct vfio_group *vfio_group;
@@ -76,6 +80,22 @@ static bool kvm_vfio_group_is_coherent(struct vfio_group *vfio_group)
 	return ret > 0;
 }
 
+static int kvm_vfio_external_user_iommu_id(struct vfio_group *vfio_group)
+{
+	int (*fn)(struct vfio_group *);
+	int ret = -1;
+
+	fn = symbol_get(vfio_external_user_iommu_id);
+	if (!fn)
+		return ret;
+
+	ret = fn(vfio_group);
+
+	symbol_put(vfio_external_user_iommu_id);
+
+	return ret;
+}
+
 /*
  * Groups can use the same or different IOMMU domains.  If the same then
  * adding a new group may change the coherency of groups we've previously
@@ -110,6 +130,22 @@ static void kvm_vfio_update_coherency(struct kvm_device *dev)
 	mutex_unlock(&kv->lock);
 }
 
+#ifdef CONFIG_SPAPR_TCE_IOMMU
+static void kvm_vfio_spapr_detach_iommu_group(struct kvm *kvm,
+		struct vfio_group *vfio_group)
+{
+	int group_id;
+	struct iommu_group *grp;
+
+	group_id = kvm_vfio_external_user_iommu_id(vfio_group);
+	grp = iommu_group_get_by_id(group_id);
+	if (grp) {
+		kvm_spapr_tce_detach_iommu_group(kvm, grp);
+		iommu_group_put(grp);
+	}
+}
+#endif
+
 static int kvm_vfio_set_group(struct kvm_device *dev, long attr, u64 arg)
 {
 	struct kvm_vfio *kv = dev->private;
@@ -185,6 +221,11 @@ static int kvm_vfio_set_group(struct kvm_device *dev, long attr, u64 arg)
 			if (kvg->vfio_group != vfio_group)
 				continue;
 
+#ifdef CONFIG_SPAPR_TCE_IOMMU
+			kvm_vfio_spapr_detach_iommu_group(dev->kvm,
+					kvg->vfio_group);
+#endif
+
 			list_del(&kvg->node);
 			kvm_vfio_group_put_external_user(kvg->vfio_group);
 			kfree(kvg);
@@ -201,6 +242,66 @@ static int kvm_vfio_set_group(struct kvm_device *dev, long attr, u64 arg)
 		kvm_vfio_update_coherency(dev);
 
 		return ret;
+
+#ifdef CONFIG_SPAPR_TCE_IOMMU
+	case KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE: {
+		struct kvm_vfio_spapr_tce param;
+		unsigned long minsz;
+		struct kvm_vfio *kv = dev->private;
+		struct vfio_group *vfio_group;
+		struct kvm_vfio_group *kvg;
+		struct fd f;
+
+		minsz = offsetofend(struct kvm_vfio_spapr_tce, pad);
+
+		if (copy_from_user(&param, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (param.argsz < minsz)
+			return -EINVAL;
+
+		f = fdget(param.groupfd);
+		if (!f.file)
+			return -EBADF;
+
+		vfio_group = kvm_vfio_group_get_external_user(f.file);
+		fdput(f);
+
+		if (IS_ERR(vfio_group))
+			return PTR_ERR(vfio_group);
+
+		ret = -ENOENT;
+
+		mutex_lock(&kv->lock);
+
+		list_for_each_entry(kvg, &kv->group_list, node) {
+			int group_id;
+			struct iommu_group *grp;
+
+			if (kvg->vfio_group != vfio_group)
+				continue;
+
+			group_id = kvm_vfio_external_user_iommu_id(
+					kvg->vfio_group);
+			grp = iommu_group_get_by_id(group_id);
+			if (!grp) {
+				ret = -EFAULT;
+				break;
+			}
+
+			ret = kvm_spapr_tce_attach_iommu_group(dev->kvm,
+					param.tablefd, grp);
+			iommu_group_put(grp);
+			break;
+		}
+
+		mutex_unlock(&kv->lock);
+
+		kvm_vfio_group_put_external_user(vfio_group);
+
+		return ret;
+	}
+#endif /* CONFIG_SPAPR_TCE_IOMMU */
 	}
 
 	return -ENXIO;
@@ -225,6 +326,9 @@ static int kvm_vfio_has_attr(struct kvm_device *dev,
 		switch (attr->attr) {
 		case KVM_DEV_VFIO_GROUP_ADD:
 		case KVM_DEV_VFIO_GROUP_DEL:
+#ifdef CONFIG_SPAPR_TCE_IOMMU
+		case KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE:
+#endif
 			return 0;
 		}
 
@@ -240,6 +344,10 @@ static void kvm_vfio_destroy(struct kvm_device *dev)
 	struct kvm_vfio_group *kvg, *tmp;
 
 	list_for_each_entry_safe(kvg, tmp, &kv->group_list, node) {
+#ifdef CONFIG_SPAPR_TCE_IOMMU
+		kvm_vfio_spapr_detach_iommu_group(dev->kvm,
+				kvg->vfio_group);
+#endif
 		kvm_vfio_group_put_external_user(kvg->vfio_group);
 		list_del(&kvg->node);
 		kfree(kvg);
-- 
2.11.0
