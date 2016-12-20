Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tjRgD6Tc8zDwRW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 16:49:12 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org,
	sjitindarsingh@gmail.com
Cc: benh@kernel.crashing.org, thuth@redhat.com, lvivier@redhat.com,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCHv2 09/11] powerpc/kvm: Outline of KVM-HV HPT resizing
 implementation
Date: Tue, 20 Dec 2016 16:49:05 +1100
Message-Id: <20161220054907.9204-10-david@gibson.dropbear.id.au>
In-Reply-To: <20161220054907.9204-1-david@gibson.dropbear.id.au>
References: <20161220054907.9204-1-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds a not yet working outline of the HPT resizing PAPR
extension.  Specifically it adds the necessary ioctl() functions,
their basic steps, the work function which will handle preparation for
the resize, and synchronization between these, the guest page fault
path and guest HPT update path.

The actual guts of the implementation isn't here yet, so for now the
calls will always fail.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/include/asm/kvm_host.h |   3 +
 arch/powerpc/include/asm/kvm_ppc.h  |   4 +
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 191 ++++++++++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_hv.c        |  25 +++++
 4 files changed, 223 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 7576e0e..fb8e508 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -252,6 +252,8 @@ struct kvm_hpt_info {
 	int cma;
 };
 
+struct kvm_resize_hpt;
+
 struct kvm_arch {
 	unsigned int lpid;
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
@@ -272,6 +274,7 @@ struct kvm_arch {
 	cpumask_t need_tlb_flush;
 	struct dentry *debugfs_dir;
 	struct dentry *htab_dentry;
+	struct kvm_resize_hpt *resize_hpt; /* protected by kvm->lock */
 #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
 #ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 	struct mutex hpt_mutex;
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 3b837bc..f8eaed0 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -215,6 +215,10 @@ extern void kvmppc_bookehv_exit(void);
 extern int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu);
 
 extern int kvm_vm_ioctl_get_htab_fd(struct kvm *kvm, struct kvm_get_htab_fd *);
+extern long kvm_vm_ioctl_resize_hpt_prepare(struct kvm *kvm,
+					    struct kvm_ppc_resize_hpt *rhpt);
+extern long kvm_vm_ioctl_resize_hpt_commit(struct kvm *kvm,
+					   struct kvm_ppc_resize_hpt *rhpt);
 
 int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu, struct kvm_interrupt *irq);
 
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 74e909a..86a1bcb 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -40,9 +40,34 @@
 
 #include "trace_hv.h"
 
+//#define DEBUG_RESIZE_HPT	1
+
+#ifdef DEBUG_RESIZE_HPT
+#define resize_hpt_debug(resize, ...)				\
+	do {							\
+		printk(KERN_DEBUG "RESIZE HPT %p: ", resize);	\
+		printk(__VA_ARGS__);				\
+	} while (0)
+#else
+#define resize_hpt_debug(resize, ...)				\
+	do { } while (0)
+#endif
+
 static long kvmppc_virtmode_do_h_enter(struct kvm *kvm, unsigned long flags,
 				long pte_index, unsigned long pteh,
 				unsigned long ptel, unsigned long *pte_idx_ret);
+
+struct kvm_resize_hpt {
+	/* These fields read-only after init */
+	struct kvm *kvm;
+	struct work_struct work;
+	u32 order;
+
+	/* These fields protected by kvm->lock */
+	int error;
+	bool prepare_done;
+};
+
 static void kvmppc_rmap_reset(struct kvm *kvm);
 
 int kvmppc_allocate_hpt(struct kvm_hpt_info *info, u32 order)
@@ -1158,6 +1183,172 @@ void kvmppc_unpin_guest_page(struct kvm *kvm, void *va, unsigned long gpa,
 }
 
 /*
+ * HPT resizing
+ */
+static int resize_hpt_allocate(struct kvm_resize_hpt *resize)
+{
+	return 0;
+}
+
+static int resize_hpt_rehash(struct kvm_resize_hpt *resize)
+{
+	return -EIO;
+}
+
+static void resize_hpt_pivot(struct kvm_resize_hpt *resize)
+{
+}
+
+static void resize_hpt_release(struct kvm *kvm, struct kvm_resize_hpt *resize)
+{
+	BUG_ON(kvm->arch.resize_hpt != resize);
+	kvm->arch.resize_hpt = NULL;
+	kfree(resize);
+}
+
+static void resize_hpt_prepare_work(struct work_struct *work)
+{
+	struct kvm_resize_hpt *resize = container_of(work,
+						     struct kvm_resize_hpt,
+						     work);
+	struct kvm *kvm = resize->kvm;
+	int err;
+
+	resize_hpt_debug(resize, "resize_hpt_prepare_work(): order = %d\n",
+			 resize->order);
+
+	err = resize_hpt_allocate(resize);
+
+	mutex_lock(&kvm->lock);
+
+	resize->error = err;
+	resize->prepare_done = true;
+
+	mutex_unlock(&kvm->lock);
+}
+
+long kvm_vm_ioctl_resize_hpt_prepare(struct kvm *kvm,
+				     struct kvm_ppc_resize_hpt *rhpt)
+{
+	unsigned long flags = rhpt->flags;
+	unsigned long shift = rhpt->shift;
+	struct kvm_resize_hpt *resize;
+	int ret;
+
+	if (flags != 0)
+		return -EINVAL;
+
+	if (shift && ((shift < 18) || (shift > 46)))
+		return -EINVAL;
+
+	mutex_lock(&kvm->lock);
+
+	resize = kvm->arch.resize_hpt;
+
+	if (resize) {
+		if (resize->order == shift) {
+			/* Suitable resize in progress */
+			if (resize->prepare_done) {
+				ret = resize->error;
+				if (ret != 0)
+					resize_hpt_release(kvm, resize);
+			} else {
+				ret = 100; /* estimated time in ms */
+			}
+
+			goto out;
+		}
+
+		/* not suitable, cancel it */
+		resize_hpt_release(kvm, resize);
+	}
+
+	ret = 0;
+	if (!shift)
+		goto out; /* nothing to do */
+
+	/* start new resize */
+
+	resize = kzalloc(sizeof(*resize), GFP_KERNEL);
+	resize->order = shift;
+	resize->kvm = kvm;
+	INIT_WORK(&resize->work, resize_hpt_prepare_work);
+	kvm->arch.resize_hpt = resize;
+
+	schedule_work(&resize->work);
+
+	ret = 100; /* estimated time in ms */
+
+out:
+	mutex_unlock(&kvm->lock);
+	return ret;
+}
+
+static void resize_hpt_boot_vcpu(void *opaque)
+{
+	/* Nothing to do, just force a KVM exit */
+}
+
+long kvm_vm_ioctl_resize_hpt_commit(struct kvm *kvm,
+				    struct kvm_ppc_resize_hpt *rhpt)
+{
+	unsigned long flags = rhpt->flags;
+	unsigned long shift = rhpt->shift;
+	struct kvm_resize_hpt *resize;
+	long ret;
+
+	if (flags != 0)
+		return -EINVAL;
+
+	if (shift && ((shift < 18) || (shift > 46)))
+		return -EINVAL;
+
+	mutex_lock(&kvm->lock);
+
+	resize = kvm->arch.resize_hpt;
+
+	/* This shouldn't be possible */
+	ret = -EIO;
+	if (WARN_ON(!kvm->arch.hpte_setup_done))
+		goto out_no_hpt;
+
+	/* Stop VCPUs from running while we mess with the HPT */
+	kvm->arch.hpte_setup_done = 0;
+	smp_mb();
+
+	/* Boot all CPUs out of the guest so they re-read
+	 * hpte_setup_done */
+	on_each_cpu(resize_hpt_boot_vcpu, NULL, 1);
+
+	ret = -ENXIO;
+	if (!resize || (resize->order != shift))
+		goto out;
+
+	ret = -EBUSY;
+	if (!resize->prepare_done)
+		goto out;
+
+	ret = resize->error;
+	if (ret != 0)
+		goto out;
+
+	ret = resize_hpt_rehash(resize);
+	if (ret != 0)
+		goto out;
+
+	resize_hpt_pivot(resize);
+
+out:
+	/* Let VCPUs run again */
+	kvm->arch.hpte_setup_done = 1;
+	smp_mb();
+out_no_hpt:
+	resize_hpt_release(kvm, resize);
+	mutex_unlock(&kvm->lock);
+	return ret;
+}
+
+/*
  * Functions for reading and writing the hash table via reads and
  * writes on a file descriptor.
  *
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 9ebb9e6..7fd1dba 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3323,6 +3323,9 @@ static int kvmppc_core_init_vm_hv(struct kvm *kvm)
 
 	kvm->arch.lpcr = lpcr;
 
+	/* Initialization for future HPT resizes */
+	kvm->arch.resize_hpt = NULL;
+
 	/*
 	 * Work out how many sets the TLB has, for the use of
 	 * the TLB invalidation loop in book3s_hv_rmhandlers.S.
@@ -3617,6 +3620,28 @@ static long kvm_arch_vm_ioctl_hv(struct file *filp,
 		break;
 	}
 
+	case KVM_PPC_RESIZE_HPT_PREPARE: {
+		struct kvm_ppc_resize_hpt rhpt;
+
+		r = -EFAULT;
+		if (copy_from_user(&rhpt, argp, sizeof(rhpt)))
+			break;
+
+		r = kvm_vm_ioctl_resize_hpt_prepare(kvm, &rhpt);
+		break;
+	}
+
+	case KVM_PPC_RESIZE_HPT_COMMIT: {
+		struct kvm_ppc_resize_hpt rhpt;
+
+		r = -EFAULT;
+		if (copy_from_user(&rhpt, argp, sizeof(rhpt)))
+			break;
+
+		r = kvm_vm_ioctl_resize_hpt_commit(kvm, &rhpt);
+		break;
+	}
+
 	default:
 		r = -ENOTTY;
 	}
-- 
2.9.3
