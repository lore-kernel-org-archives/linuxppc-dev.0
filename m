Return-Path: <paulus@ozlabs.org>
Date: Wed, 11 May 2011 20:46:15 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org
Subject: [PATCH 12/13] kvm/powerpc: Accelerate H_PUT_TCE by implementing it
	in real mode
Message-ID: <20110511104615.GM2837@brick.ozlabs.ibm.com>
References: <20110511103443.GA2837@brick.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110511103443.GA2837@brick.ozlabs.ibm.com>
Cc: Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: David Gibson <dwg@au1.ibm.com>

This improves I/O performance for guests using the PAPR paravirtualization
interface by making the H_PUT_TCE hcall faster, by implementing it in
real mode.  H_PUT_TCE is used for updating virtual IOMMU tables, and is
used both for virtual I/O and for real I/O in the PAPR interface.

Since this moves the IOMMU tables into the kernel, we define a new
KVM_CREATE_SPAPR_TCE ioctl to allow qemu to create the tables.
The ioctl returns a file descriptor which can be used to mmap the
newly created table.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/kvm.h           |    9 +++
 arch/powerpc/include/asm/kvm_book3s_64.h |    2 +
 arch/powerpc/include/asm/kvm_host.h      |    9 +++
 arch/powerpc/include/asm/kvm_ppc.h       |    2 +
 arch/powerpc/kvm/Makefile                |    3 +-
 arch/powerpc/kvm/book3s_64_vio_hv.c      |   73 +++++++++++++++++++
 arch/powerpc/kvm/book3s_hv.c             |  116 +++++++++++++++++++++++++++++-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S  |    2 +-
 arch/powerpc/kvm/powerpc.c               |   18 +++++
 include/linux/kvm.h                      |    5 ++
 10 files changed, 236 insertions(+), 3 deletions(-)
 create mode 100644 arch/powerpc/kvm/book3s_64_vio_hv.c

diff --git a/arch/powerpc/include/asm/kvm.h b/arch/powerpc/include/asm/kvm.h
index 18ea696..a9e641b 100644
--- a/arch/powerpc/include/asm/kvm.h
+++ b/arch/powerpc/include/asm/kvm.h
@@ -22,6 +22,9 @@
 
 #include <linux/types.h>
 
+/* Select powerpc specific features in <linux/kvm.h> */
+#define __KVM_HAVE_SPAPR_TCE
+
 struct kvm_regs {
 	__u64 pc;
 	__u64 cr;
@@ -88,4 +91,10 @@ struct kvm_guest_debug_arch {
 #define KVM_INTERRUPT_UNSET	-2U
 #define KVM_INTERRUPT_SET_LEVEL	-3U
 
+/* for KVM_CAP_SPAPR_TCE */
+struct kvm_create_spapr_tce {
+	__u64 liobn;
+	__u32 window_size;
+};
+
 #endif /* __LINUX_KVM_POWERPC_H */
diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 4cadd61..e1a096b 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -25,4 +25,6 @@ static inline struct kvmppc_book3s_shadow_vcpu *to_svcpu(struct kvm_vcpu *vcpu)
 	return &get_paca()->shadow_vcpu;
 }
 
+#define SPAPR_TCE_SHIFT		12
+
 #endif /* __ASM_KVM_BOOK3S_64_H__ */
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index af6703e..cda183e 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -144,6 +144,14 @@ struct kvmppc_pginfo {
 	atomic_t refcnt;
 };
 
+struct kvmppc_spapr_tce_table {
+	struct list_head list;
+	struct kvm *kvm;
+	u64 liobn;
+	u32 window_size;
+	struct page *pages[0];
+};
+
 struct kvm_arch {
 	unsigned long hpt_virt;
 	unsigned long ram_npages;
@@ -157,6 +165,7 @@ struct kvm_arch {
 	unsigned long host_sdr1;
 	int tlbie_lock;
 	unsigned short last_vcpu[NR_CPUS];
+	struct list_head spapr_tce_tables;
 };
 
 struct kvmppc_pte {
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index b4ee11a..de683fa 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -117,6 +117,8 @@ extern long kvmppc_prepare_vrma(struct kvm *kvm,
 extern void kvmppc_map_vrma(struct kvm *kvm,
 			    struct kvm_userspace_memory_region *mem);
 extern int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu);
+extern long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
+				struct kvm_create_spapr_tce *args);
 extern int kvmppc_core_init_vm(struct kvm *kvm);
 extern void kvmppc_core_destroy_vm(struct kvm *kvm);
 extern int kvmppc_core_prepare_memory_region(struct kvm *kvm,
diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
index 37c1a60..8ba062f 100644
--- a/arch/powerpc/kvm/Makefile
+++ b/arch/powerpc/kvm/Makefile
@@ -59,7 +59,8 @@ kvm-book3s_64_hv-objs := \
 	book3s.o \
 	book3s_hv.o \
 	book3s_hv_interrupts.o \
-	book3s_64_mmu_hv.o
+	book3s_64_mmu_hv.o \
+	book3s_64_vio_hv.o
 kvm-objs-$(CONFIG_KVM_BOOK3S_64_HV) := $(kvm-book3s_64_hv-objs)
 
 kvm-book3s_32-objs := \
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
new file mode 100644
index 0000000..ea0f8c5
--- /dev/null
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -0,0 +1,73 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ *
+ * Copyright 2010 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
+ * Copyright 2011 David Gibson, IBM Corporation <dwg@au1.ibm.com>
+ */
+
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/kvm.h>
+#include <linux/kvm_host.h>
+#include <linux/highmem.h>
+#include <linux/gfp.h>
+#include <linux/slab.h>
+#include <linux/hugetlb.h>
+#include <linux/list.h>
+
+#include <asm/tlbflush.h>
+#include <asm/kvm_ppc.h>
+#include <asm/kvm_book3s.h>
+#include <asm/mmu-hash64.h>
+#include <asm/hvcall.h>
+#include <asm/synch.h>
+#include <asm/ppc-opcode.h>
+#include <asm/kvm_host.h>
+#include <asm/udbg.h>
+
+#define TCES_PER_PAGE	(PAGE_SIZE / sizeof(u64))
+
+long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
+		      unsigned long ioba, unsigned long tce)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvmppc_spapr_tce_table *stt;
+
+	/* udbg_printf("H_PUT_TCE(): liobn=0x%lx ioba=0x%lx, tce=0x%lx\n", */
+	/* 	    liobn, ioba, tce); */
+
+	list_for_each_entry(stt, &kvm->arch.spapr_tce_tables, list) {
+		if (stt->liobn == liobn) {
+			unsigned long idx = ioba >> SPAPR_TCE_SHIFT;
+			struct page *page;
+			u64 *tbl;
+
+			/* udbg_printf("H_PUT_TCE: liobn 0x%lx => stt=%p  window_size=0x%x\n", */
+			/* 	    liobn, stt, stt->window_size); */
+			if (ioba >= stt->window_size)
+				return H_PARAMETER;
+
+			page = stt->pages[idx / TCES_PER_PAGE];
+			tbl = (u64 *)page_address(page);
+
+			/* FIXME: Need to validate the TCE itself */
+			/* udbg_printf("tce @ %p\n", &tbl[idx % TCES_PER_PAGE]); */
+			tbl[idx % TCES_PER_PAGE] = tce;
+			return H_SUCCESS;
+		}
+	}
+
+	/* Didn't find the liobn, punt it to userspace */
+	return H_TOO_HARD;
+}
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 377a35a..eed2c10 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -506,6 +506,116 @@ int kvmppc_vcpu_run(struct kvm_run *run, struct kvm_vcpu *vcpu)
 	return r;
 }
 
+static long kvmppc_stt_npages(unsigned long window_size)
+{
+	return ALIGN((window_size >> SPAPR_TCE_SHIFT)
+		     * sizeof(u64), PAGE_SIZE) / PAGE_SIZE;
+}
+
+static void release_spapr_tce_table(struct kvmppc_spapr_tce_table *stt)
+{
+	struct kvm *kvm = stt->kvm;
+	int i;
+
+	mutex_lock(&kvm->lock);
+	list_del(&stt->list);
+	for (i = 0; i < kvmppc_stt_npages(stt->window_size); i++)
+		__free_page(stt->pages[i]);
+	kfree(stt);
+	mutex_unlock(&kvm->lock);
+
+	kvm_put_kvm(kvm);
+}
+
+static int kvm_spapr_tce_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
+{
+	struct kvmppc_spapr_tce_table *stt = vma->vm_file->private_data;
+	struct page *page;
+
+	if (vmf->pgoff >= kvmppc_stt_npages(stt->window_size))
+		return VM_FAULT_SIGBUS;
+
+	page = stt->pages[vmf->pgoff];
+	get_page(page);
+	vmf->page = page;
+	return 0;
+}
+
+static const struct vm_operations_struct kvm_spapr_tce_vm_ops = {
+	.fault = kvm_spapr_tce_fault,
+};
+
+static int kvm_spapr_tce_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	vma->vm_ops = &kvm_spapr_tce_vm_ops;
+	return 0;
+}
+
+static int kvm_spapr_tce_release(struct inode *inode, struct file *filp)
+{
+	struct kvmppc_spapr_tce_table *stt = filp->private_data;
+
+	release_spapr_tce_table(stt);
+	return 0;
+}
+
+static struct file_operations kvm_spapr_tce_fops = {
+	.mmap           = kvm_spapr_tce_mmap,
+	.release	= kvm_spapr_tce_release,
+};
+
+long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
+				   struct kvm_create_spapr_tce *args)
+{
+	struct kvmppc_spapr_tce_table *stt = NULL;
+	long npages;
+	int ret = -ENOMEM;
+	int i;
+
+	/* Check this LIOBN hasn't been previously allocated */
+	list_for_each_entry(stt, &kvm->arch.spapr_tce_tables, list) {
+		if (stt->liobn == args->liobn)
+			return -EBUSY;
+	}
+
+	npages = kvmppc_stt_npages(args->window_size);
+
+	stt = kzalloc(sizeof(*stt) + npages* sizeof(struct page *),
+		      GFP_KERNEL);
+	if (!stt)
+		goto fail;
+
+	stt->liobn = args->liobn;
+	stt->window_size = args->window_size;
+	stt->kvm = kvm;
+
+	for (i = 0; i < npages; i++) {
+		stt->pages[i] = alloc_page(GFP_KERNEL | __GFP_ZERO);
+		if (!stt->pages[i])
+			goto fail;
+	}
+
+	kvm_get_kvm(kvm);
+
+	mutex_lock(&kvm->lock);
+	list_add(&stt->list, &kvm->arch.spapr_tce_tables);
+
+	mutex_unlock(&kvm->lock);
+
+	return anon_inode_getfd("kvm-spapr-tce", &kvm_spapr_tce_fops,
+				stt, O_RDONLY);
+
+fail:
+	if (stt) {
+		for (i = 0; i < npages; i++)
+			if (stt->pages[i])
+				__free_page(stt->pages[i]);
+
+		kfree(stt);
+	}
+	return ret;
+}
+
 int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 				struct kvm_userspace_memory_region *mem)
 {
@@ -527,13 +637,17 @@ int kvmppc_core_init_vm(struct kvm *kvm)
 
 	/* Allocate hashed page table */
 	r = kvmppc_alloc_hpt(kvm);
+	if (r)
+		return r;
 
-	return r;
+	INIT_LIST_HEAD(&kvm->arch.spapr_tce_tables);
+	return 0;
 }
 
 void kvmppc_core_destroy_vm(struct kvm *kvm)
 {
 	kvmppc_free_hpt(kvm);
+	WARN_ON(!list_empty(&kvm->arch.spapr_tce_tables));
 }
 
 /* These are stubs for now */
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index e8a8f3c..95f6386 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -722,7 +722,7 @@ hcall_real_table:
 	.long	0		/* 0x14 - H_CLEAR_REF */
 	.long	.kvmppc_h_protect - hcall_real_table
 	.long	0		/* 0x1c - H_GET_TCE */
-	.long	0		/* 0x20 - H_SET_TCE */
+	.long	.kvmppc_h_put_tce - hcall_real_table
 	.long	0		/* 0x24 - H_SET_SPRG0 */
 	.long	.kvmppc_h_set_dabr - hcall_real_table
 	.long	0		/* 0x2c */
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 7bfe413..10f777a 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -196,6 +196,11 @@ int kvm_dev_ioctl_check_extension(long ext)
 		r = KVM_COALESCED_MMIO_PAGE_OFFSET;
 		break;
 #endif
+#ifdef CONFIG_KVM_BOOK3S_64_HV
+	case KVM_CAP_SPAPR_TCE:
+		r = 1;
+		break;
+#endif
 	default:
 		r = 0;
 		break;
@@ -628,6 +633,19 @@ long kvm_arch_vm_ioctl(struct file *filp,
 
 		break;
 	}
+#ifdef CONFIG_KVM_BOOK3S_64_HV
+	case KVM_CREATE_SPAPR_TCE: {
+		struct kvm_create_spapr_tce create_tce;
+		struct kvm *kvm = filp->private_data;
+
+		r = -EFAULT;
+		if (copy_from_user(&create_tce, argp, sizeof(create_tce)))
+			goto out;
+		r = kvm_vm_ioctl_create_spapr_tce(kvm, &create_tce);
+		goto out;
+	}
+#endif /* CONFIG_KVM_BOOK3S_64_HV */
+
 	default:
 		r = -ENOTTY;
 	}
diff --git a/include/linux/kvm.h b/include/linux/kvm.h
index a4447ce..3d3cdf1 100644
--- a/include/linux/kvm.h
+++ b/include/linux/kvm.h
@@ -547,6 +547,9 @@ struct kvm_ppc_pvinfo {
 #define KVM_CAP_PPC_GET_PVINFO 57
 #define KVM_CAP_PPC_IRQ_LEVEL 58
 #define KVM_CAP_ASYNC_PF 59
+#ifdef __KVM_HAVE_SPAPR_TCE
+#define KVM_CAP_SPAPR_TCE 60
+#endif
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -746,6 +749,8 @@ struct kvm_clock_data {
 /* Available with KVM_CAP_XCRS */
 #define KVM_GET_XCRS		  _IOR(KVMIO,  0xa6, struct kvm_xcrs)
 #define KVM_SET_XCRS		  _IOW(KVMIO,  0xa7, struct kvm_xcrs)
+/* Available with KVM_CAP_SPAPR_TCE */
+#define KVM_CREATE_SPAPR_TCE	  _IOW(KVMIO,  0xa8, struct kvm_create_spapr_tce)
 
 #define KVM_DEV_ASSIGN_ENABLE_IOMMU	(1 << 0)
 
-- 
1.7.4.4
