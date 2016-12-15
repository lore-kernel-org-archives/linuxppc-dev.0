Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tfN6Z3Wh7zDt2L
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2016 16:58:46 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org
Cc: michael@ellerman.id.au, benh@kernel.crashing.org, sjitindarsingh@gmail.com,
 thuth@redhat.com, lvivier@redhat.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 09/11] powerpc/kvm: Outline of KVM-HV HPT resizing
 implementation
Date: Thu, 15 Dec 2016 16:54:02 +1100
Message-Id: <20161215055404.29351-10-david@gibson.dropbear.id.au>
In-Reply-To: <20161215055404.29351-1-david@gibson.dropbear.id.au>
References: <20161215055404.29351-1-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds an outline (not yet working) of an implementation for the HPT
resizing PAPR extension.  Specifically it adds the work function which will
handle preparation for the resize, and synchronization between this, the
the HPT resizing hypercalls, the guest page fault path and guest HPT update
paths.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/include/asm/kvm_host.h |   3 +
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 179 +++++++++++++++++++++++++++++++++++-
 arch/powerpc/kvm/book3s_hv.c        |   3 +
 3 files changed, 183 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 3900f63..23559c3 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -248,6 +248,8 @@ struct kvm_hpt_info {
 	int cma;
 };
 
+struct kvm_resize_hpt;
+
 struct kvm_arch {
 	unsigned int lpid;
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
@@ -268,6 +270,7 @@ struct kvm_arch {
 	cpumask_t need_tlb_flush;
 	struct dentry *debugfs_dir;
 	struct dentry *htab_dentry;
+	struct kvm_resize_hpt *resize_hpt; /* protected by kvm->lock */
 #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
 #ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 	struct mutex hpt_mutex;
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index ac0f18b..a2ac749 100644
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
@@ -1162,17 +1187,167 @@ void kvmppc_unpin_guest_page(struct kvm *kvm, void *va, unsigned long gpa,
 /*
  * HPT resizing
  */
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
 
 long kvm_vm_ioctl_resize_hpt_prepare(struct kvm *kvm,
 				     struct kvm_ppc_resize_hpt *rhpt)
 {
-	return -EIO;
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
 }
 
 long kvm_vm_ioctl_resize_hpt_commit(struct kvm *kvm,
 				    struct kvm_ppc_resize_hpt *rhpt)
 {
-	return -EIO;
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
 }
 
 /*
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index d022322..613b8a5 100644
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
-- 
2.9.3
