Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [83.169.36.222])
 by lists.ozlabs.org (Postfix) with ESMTP id 3s464Q3WkpzDqRl
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 18:41:42 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH kernel 15/15] KVM: PPC: Add in-kernel acceleration for VFIO
Date: Wed,  3 Aug 2016 18:40:56 +1000
Message-Id: <1470213656-1042-16-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
References: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
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

Both real and virtual modes are supported. The kernel tries to
handle a TCE request in the real mode, if fails it passes the request
to the virtual mode to complete the operation. If it a virtual mode
handler fails, the request is passed to user space; this is not expected
to happen ever though.

The first user of this is VFIO on POWER. Trampolines to the VFIO external
user API functions are required for this patch.

This adds ioctl() interface to SPAPR TCE fd which already handles
in-kernel acceleration for emulated IO by allocating the guest view of
the TCE table in KVM. New ioctls allows the userspace to attach/detach
VFIO containers to the kernel-allocated TCE table and handle
the hardware TCE table updates in the kernel. The new interface
accepts VFIO container fd and uses exported API to get to the actual
hardware TCE table. Until _unset() ioctl is called, the VFIO container
is referenced to guarantee the TCE table presense in the memory.

This also releases unused containers when new container is registered.
The criteria of "unused" is vfio_container_get_iommu_data_ext()
returning NULL which happens when the container fd is closed.

Note that this interface does not operate with IOMMU groups as
TCE tables are owned by VFIO containers (and even may have no IOMMU groups
attached).

This advertises the new KVM_CAP_SPAPR_TCE_VFIO capability to the user
space.

Tests show that this patch increases transmission speed from 220MB/s
to 750..1020MB/s on 10Gb network (Chelsea CXGB3 10Gb ethernet card).

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/kvm_host.h |   8 +
 arch/powerpc/include/uapi/asm/kvm.h |  12 ++
 arch/powerpc/kvm/book3s_64_vio.c    | 403 ++++++++++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_64_vio_hv.c | 173 ++++++++++++++++
 arch/powerpc/kvm/powerpc.c          |   2 +
 5 files changed, 598 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index ec35af3..3e3d65f 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -182,6 +182,13 @@ struct kvmppc_pginfo {
 	atomic_t refcnt;
 };
 
+struct kvmppc_spapr_tce_container {
+	struct list_head next;
+	struct rcu_head rcu;
+	struct vfio_container *vfiocontainer;
+	struct iommu_table *tbl;
+};
+
 struct kvmppc_spapr_tce_table {
 	struct list_head list;
 	struct kvm *kvm;
@@ -190,6 +197,7 @@ struct kvmppc_spapr_tce_table {
 	u32 page_shift;
 	u64 offset;		/* in pages */
 	u64 size;		/* window size in pages */
+	struct list_head containers;
 	struct page *pages[0];
 };
 
diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index c93cf35..cbeb7bb 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -342,6 +342,18 @@ struct kvm_create_spapr_tce_64 {
 	__u64 size;	/* in pages */
 };
 
+#define KVM_SPAPR_TCE			(':')
+#define KVM_SPAPR_TCE_VFIO_SET		_IOW(KVM_SPAPR_TCE,  0x00, \
+					     struct kvm_spapr_tce_vfio)
+#define KVM_SPAPR_TCE_VFIO_UNSET	_IOW(KVM_SPAPR_TCE,  0x01, \
+					     struct kvm_spapr_tce_vfio)
+
+struct kvm_spapr_tce_vfio {
+	__u32 argsz;
+	__u32 flags;
+	__u32 container_fd;
+};
+
 /* for KVM_ALLOCATE_RMA */
 struct kvm_allocate_rma {
 	__u64 rma_size;
diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 15df8ae..d420ee0 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -27,6 +27,10 @@
 #include <linux/hugetlb.h>
 #include <linux/list.h>
 #include <linux/anon_inodes.h>
+#include <linux/module.h>
+#include <linux/compat.h>
+#include <linux/vfio.h>
+#include <linux/file.h>
 
 #include <asm/tlbflush.h>
 #include <asm/kvm_ppc.h>
@@ -39,6 +43,70 @@
 #include <asm/udbg.h>
 #include <asm/iommu.h>
 #include <asm/tce.h>
+#include <asm/mmu_context.h>
+
+static struct iommu_table *kvm_vfio_container_spapr_tce_table_get_ext(
+		void *iommu_data, u64 offset)
+{
+	struct iommu_table *tbl;
+	struct iommu_table *(*fn)(void *, u64);
+
+	fn = symbol_get(vfio_container_spapr_tce_table_get_ext);
+	if (!fn)
+		return NULL;
+
+	tbl = fn(iommu_data, offset);
+
+	symbol_put(vfio_container_spapr_tce_table_get_ext);
+
+	return tbl;
+}
+
+static struct vfio_container *kvm_vfio_container_get_ext(struct file *filep)
+{
+	struct vfio_container *container;
+	struct vfio_container *(*fn)(struct file *);
+
+	fn = symbol_get(vfio_container_get_ext);
+	if (!fn)
+		return NULL;
+
+	container = fn(filep);
+
+	symbol_put(vfio_container_get_ext);
+
+	return container;
+}
+
+static void kvm_vfio_container_put_ext(struct vfio_container *container)
+{
+	void (*fn)(struct vfio_container *container);
+
+	fn = symbol_get(vfio_container_put_ext);
+	if (!fn)
+		return;
+
+	fn(container);
+
+	symbol_put(vfio_container_put_ext);
+}
+
+static void *kvm_vfio_container_get_iommu_data_ext(
+		struct vfio_container *container)
+{
+	void *iommu_data;
+	void *(*fn)(struct vfio_container *);
+
+	fn = symbol_get(vfio_container_get_iommu_data_ext);
+	if (!fn)
+		return NULL;
+
+	iommu_data = fn(container);
+
+	symbol_put(vfio_container_get_iommu_data_ext);
+
+	return iommu_data;
+}
 
 static unsigned long kvmppc_tce_pages(unsigned long iommu_pages)
 {
@@ -90,15 +158,39 @@ static long kvmppc_account_memlimit(unsigned long stt_pages, bool inc)
 	return ret;
 }
 
+static void kvm_spapr_tce_release_container_cb(struct rcu_head *head)
+{
+	struct kvmppc_spapr_tce_container *kc = container_of(head,
+			struct kvmppc_spapr_tce_container, rcu);
+
+	kvm_vfio_container_put_ext(kc->vfiocontainer);
+	iommu_table_put(kc->tbl);
+	kfree(kc);
+}
+
+static void kvm_spapr_tce_release_container(
+		struct kvmppc_spapr_tce_container *kc)
+{
+	list_del_rcu(&kc->next);
+	call_rcu(&kc->rcu, kvm_spapr_tce_release_container_cb);
+}
+
 static void release_spapr_tce_table(struct rcu_head *head)
 {
 	struct kvmppc_spapr_tce_table *stt = container_of(head,
 			struct kvmppc_spapr_tce_table, rcu);
 	unsigned long i, npages = kvmppc_tce_pages(stt->size);
+	struct kvmppc_spapr_tce_container *kc;
 
 	for (i = 0; i < npages; i++)
 		__free_page(stt->pages[i]);
 
+	while (!list_empty(&stt->containers)) {
+		kc = list_first_entry(&stt->containers,
+				struct kvmppc_spapr_tce_container, next);
+		kvm_spapr_tce_release_container(kc);
+	}
+
 	kfree(stt);
 }
 
@@ -141,9 +233,148 @@ static int kvm_spapr_tce_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static void kvm_spapr_tce_release_unused_containers(
+		struct kvmppc_spapr_tce_table *stt)
+{
+	struct kvmppc_spapr_tce_container *kc, *kctmp;
+
+	list_for_each_entry_safe(kc, kctmp, &stt->containers, next) {
+		if (kvm_vfio_container_get_iommu_data_ext(kc->vfiocontainer))
+			continue;
+
+		kvm_spapr_tce_release_container(kc);
+	}
+}
+
+static long kvm_spapr_tce_set_container(struct kvmppc_spapr_tce_table *stt,
+		int container_fd)
+{
+	void *iommu_data = NULL;
+	struct vfio_container *container;
+	struct iommu_table *tbl;
+	struct kvmppc_spapr_tce_container *kc;
+	struct fd f;
+
+	f = fdget(container_fd);
+	if (!f.file)
+		return -EBADF;
+
+	container = kvm_vfio_container_get_ext(f.file);
+	fdput(f);
+	if (IS_ERR(container))
+		return PTR_ERR(container);
+
+	iommu_data = kvm_vfio_container_get_iommu_data_ext(container);
+	if (!iommu_data) {
+		kvm_vfio_container_put_ext(container);
+		return -ENOENT;
+	}
+
+	list_for_each_entry_rcu(kc, &stt->containers, next) {
+		if (kc->vfiocontainer == container) {
+			kvm_vfio_container_put_ext(container);
+			return -EBUSY;
+		}
+	}
+
+	tbl = kvm_vfio_container_spapr_tce_table_get_ext(
+			iommu_data, stt->offset << stt->page_shift);
+
+	kc = kzalloc(sizeof(*kc), GFP_KERNEL);
+	kc->vfiocontainer = container;
+	kc->tbl = tbl;
+	list_add_rcu(&kc->next, &stt->containers);
+
+	return 0;
+}
+
+static long kvm_spapr_tce_unset_container(struct kvmppc_spapr_tce_table *stt,
+		int container_fd)
+{
+	struct vfio_container *container;
+	struct kvmppc_spapr_tce_container *kc;
+	struct fd f;
+	long ret;
+
+	f = fdget(container_fd);
+	if (!f.file)
+		return -EBADF;
+
+	container = kvm_vfio_container_get_ext(f.file);
+	fdput(f);
+	if (IS_ERR(container))
+		return PTR_ERR(container);
+
+	ret = -ENOENT;
+
+	list_for_each_entry_rcu(kc, &stt->containers, next) {
+		if (kc->vfiocontainer != container)
+			continue;
+
+		kvm_spapr_tce_release_container(kc);
+		ret = 0;
+		break;
+	}
+	kvm_vfio_container_put_ext(container);
+
+	return ret;
+}
+
+static long kvm_spapr_tce_unl_ioctl(struct file *filp,
+		unsigned int cmd, unsigned long arg)
+{
+	struct kvmppc_spapr_tce_table *stt = filp->private_data;
+	struct kvm_spapr_tce_vfio param;
+	unsigned long minsz;
+	long ret = -EINVAL;
+
+	if (!stt)
+		return ret;
+
+	minsz = offsetofend(struct kvm_spapr_tce_vfio, container_fd);
+
+	if (copy_from_user(&param, (void __user *)arg, minsz))
+		return -EFAULT;
+
+	if (param.argsz < minsz)
+		return -EINVAL;
+
+	if (param.flags)
+		return -EINVAL;
+
+	mutex_lock(&stt->kvm->lock);
+
+	switch (cmd) {
+	case KVM_SPAPR_TCE_VFIO_SET:
+		kvm_spapr_tce_release_unused_containers(stt);
+		ret = kvm_spapr_tce_set_container(stt, param.container_fd);
+		break;
+	case KVM_SPAPR_TCE_VFIO_UNSET:
+		ret = kvm_spapr_tce_unset_container(stt, param.container_fd);
+		break;
+	}
+
+	mutex_unlock(&stt->kvm->lock);
+
+	return ret;
+}
+
+#ifdef CONFIG_COMPAT
+static long kvm_spapr_tce_compat_ioctl(struct file *filep,
+		unsigned int cmd, unsigned long arg)
+{
+	arg = (unsigned long)compat_ptr(arg);
+	return kvm_spapr_tce_unl_ioctl(filep, cmd, arg);
+}
+#endif	/* CONFIG_COMPAT */
+
 static const struct file_operations kvm_spapr_tce_fops = {
 	.mmap           = kvm_spapr_tce_mmap,
 	.release	= kvm_spapr_tce_release,
+	.unlocked_ioctl	= kvm_spapr_tce_unl_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= kvm_spapr_tce_compat_ioctl,
+#endif
 };
 
 long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
@@ -181,6 +412,7 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 	stt->offset = args->offset;
 	stt->size = size;
 	stt->kvm = kvm;
+	INIT_LIST_HEAD_RCU(&stt->containers);
 
 	for (i = 0; i < npages; i++) {
 		stt->pages[i] = alloc_page(GFP_KERNEL | __GFP_ZERO);
@@ -209,11 +441,160 @@ fail:
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
+		return H_HARDWARE;
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
+	struct kvmppc_spapr_tce_container *kc;
 
 	/* udbg_printf("H_PUT_TCE(): liobn=0x%lx ioba=0x%lx, tce=0x%lx\n", */
 	/* 	    liobn, ioba, tce); */
@@ -230,6 +611,12 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 	if (ret != H_SUCCESS)
 		return ret;
 
+	list_for_each_entry_lockless(kc, &stt->containers, next) {
+		ret = kvmppc_h_put_tce_iommu(vcpu, kc->tbl, liobn, ioba, tce);
+		if (ret != H_SUCCESS)
+			return ret;
+	}
+
 	kvmppc_tce_put(stt, ioba >> stt->page_shift, tce);
 
 	return H_SUCCESS;
@@ -245,6 +632,7 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 	unsigned long entry, ua = 0;
 	u64 __user *tces;
 	u64 tce;
+	struct kvmppc_spapr_tce_container *kc;
 
 	stt = kvmppc_find_table(vcpu->kvm, liobn);
 	if (!stt)
@@ -272,6 +660,13 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 	}
 	tces = (u64 __user *) ua;
 
+	list_for_each_entry_lockless(kc, &stt->containers, next) {
+		ret = kvmppc_h_put_tce_indirect_iommu(vcpu,
+				kc->tbl, ioba, tces, npages);
+		if (ret != H_SUCCESS)
+			goto unlock_exit;
+	}
+
 	for (i = 0; i < npages; ++i) {
 		if (get_user(tce, tces + i)) {
 			ret = H_TOO_HARD;
@@ -299,6 +694,7 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
 {
 	struct kvmppc_spapr_tce_table *stt;
 	long i, ret;
+	struct kvmppc_spapr_tce_container *kc;
 
 	stt = kvmppc_find_table(vcpu->kvm, liobn);
 	if (!stt)
@@ -312,6 +708,13 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
 	if (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ))
 		return H_PARAMETER;
 
+	list_for_each_entry_lockless(kc, &stt->containers, next) {
+		ret = kvmppc_h_stuff_tce_iommu(vcpu, kc->tbl, liobn, ioba,
+				tce_value, npages);
+		if (ret != H_SUCCESS)
+			return ret;
+	}
+
 	for (i = 0; i < npages; ++i, ioba += (1ULL << stt->page_shift))
 		kvmppc_tce_put(stt, ioba >> stt->page_shift, tce_value);
 
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 8a6834e..4bc09f4 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -190,11 +190,161 @@ static struct mm_iommu_table_group_mem_t *kvmppc_rm_iommu_lookup(
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
+	struct kvmppc_spapr_tce_container *kc;
 
 	/* udbg_printf("H_PUT_TCE(): liobn=0x%lx ioba=0x%lx, tce=0x%lx\n", */
 	/* 	    liobn, ioba, tce); */
@@ -211,6 +361,13 @@ long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 	if (ret != H_SUCCESS)
 		return ret;
 
+	list_for_each_entry_lockless(kc, &stt->containers, next) {
+		ret = kvmppc_rm_h_put_tce_iommu(vcpu, kc->tbl,
+				liobn, ioba, tce);
+		if (ret != H_SUCCESS)
+			return ret;
+	}
+
 	kvmppc_tce_put(stt, ioba >> stt->page_shift, tce);
 
 	return H_SUCCESS;
@@ -278,6 +435,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 		 * depend on hpt.
 		 */
 		struct mm_iommu_table_group_mem_t *mem;
+		struct kvmppc_spapr_tce_container *kc;
 
 		if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, NULL))
 			return H_TOO_HARD;
@@ -285,6 +443,13 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 		mem = kvmppc_rm_iommu_lookup(vcpu, ua, IOMMU_PAGE_SIZE_4K);
 		if (!mem || mm_iommu_ua_to_hpa_rm(mem, ua, &tces))
 			return H_TOO_HARD;
+
+		list_for_each_entry_lockless(kc, &stt->containers, next) {
+			ret = kvmppc_rm_h_put_tce_indirect_iommu(vcpu,
+					kc->tbl, ioba, (u64 *)tces, npages);
+			if (ret != H_SUCCESS)
+				return ret;
+		}
 	} else {
 		/*
 		 * This is emulated devices case.
@@ -334,6 +499,7 @@ long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
 {
 	struct kvmppc_spapr_tce_table *stt;
 	long i, ret;
+	struct kvmppc_spapr_tce_container *kc;
 
 	stt = kvmppc_find_table(vcpu->kvm, liobn);
 	if (!stt)
@@ -347,6 +513,13 @@ long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
 	if (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ))
 		return H_PARAMETER;
 
+	list_for_each_entry_lockless(kc, &stt->containers, next) {
+		ret = kvmppc_rm_h_stuff_tce_iommu(vcpu, kc->tbl,
+				liobn, ioba, tce_value, npages);
+		if (ret != H_SUCCESS)
+			return ret;
+	}
+
 	for (i = 0; i < npages; ++i, ioba += (1ULL << stt->page_shift))
 		kvmppc_tce_put(stt, ioba >> stt->page_shift, tce_value);
 
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 6ce40dd..303d393 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -524,6 +524,8 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 #ifdef CONFIG_PPC_BOOK3S_64
 	case KVM_CAP_SPAPR_TCE:
 	case KVM_CAP_SPAPR_TCE_64:
+		/* fallthrough */
+	case KVM_CAP_SPAPR_TCE_VFIO:
 	case KVM_CAP_PPC_ALLOC_HTAB:
 	case KVM_CAP_PPC_RTAS:
 	case KVM_CAP_PPC_FIXUP_HCALL:
-- 
2.5.0.rc3
