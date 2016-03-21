Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qT22t0hg5zDqDV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Mar 2016 14:52:22 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org,
	aik@ozlabs.ru,
	benh@kernel.crashing.org
Cc: bharata@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 michael@ellerman.id.au, David Gibson <david@gibson.dropbear.id.au>
Subject: [RFCv3 14/17] powerpc/kvm: Outline of KVM-HV HPT resizing
 implementation
Date: Mon, 21 Mar 2016 14:53:21 +1100
Message-Id: <1458532404-21258-15-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1458532404-21258-1-git-send-email-david@gibson.dropbear.id.au>
References: <1458532404-21258-1-git-send-email-david@gibson.dropbear.id.au>
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
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 177 +++++++++++++++++++++++++++++++++++-
 arch/powerpc/kvm/book3s_hv.c        |   4 +
 3 files changed, 182 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 4c4f325..6c41c07 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -233,6 +233,8 @@ struct kvm_hpt_info {
 	int cma;
 };
 
+struct kvm_resize_hpt;
+
 struct kvm_arch {
 	unsigned int lpid;
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
@@ -251,6 +253,7 @@ struct kvm_arch {
 	cpumask_t need_tlb_flush;
 	struct dentry *debugfs_dir;
 	struct dentry *htab_dentry;
+	struct kvm_resize_hpt *resize_hpt; /* protected by kvm->lock */
 #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
 #ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 	struct mutex hpt_mutex;
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 0a69b64..05e8d52 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -43,6 +43,30 @@
 static long kvmppc_virtmode_do_h_enter(struct kvm *kvm, unsigned long flags,
 				long pte_index, unsigned long pteh,
 				unsigned long ptel, unsigned long *pte_idx_ret);
+#define DEBUG_RESIZE_HPT	1
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
 static void kvmppc_rmap_reset(struct kvm *kvm);
 
 int kvmppc_allocate_hpt(struct kvm_hpt_info *info, u32 order)
@@ -1131,19 +1155,168 @@ void kvmppc_unpin_guest_page(struct kvm *kvm, void *va, unsigned long gpa,
 /*
  * HPT resizing
  */
+static int resize_hpt_allocate(struct kvm_resize_hpt *resize)
+{
+	return H_SUCCESS;
+}
+
+static int resize_hpt_rehash(struct kvm_resize_hpt *resize)
+{
+	return H_HARDWARE;
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
 
 unsigned long do_h_resize_hpt_prepare(struct kvm_vcpu *vcpu,
 				      unsigned long flags,
 				      unsigned long shift)
 {
-	return H_HARDWARE;
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_resize_hpt *resize;
+	int ret;
+
+	if (flags != 0)
+		return H_PARAMETER;
+
+	if (shift && ((shift < 18) || (shift > 46)))
+		return H_PARAMETER;
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
+				if (ret != H_SUCCESS)
+					resize_hpt_release(kvm, resize);
+			} else {
+				ret = H_LONG_BUSY_ORDER_100_MSEC;
+			}
+
+			goto out;
+		}
+
+		/* not suitable, cancel it */
+		resize_hpt_release(kvm, resize);
+	}
+
+	ret = H_SUCCESS;
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
+	ret = H_LONG_BUSY_ORDER_100_MSEC;
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
 
 unsigned long do_h_resize_hpt_commit(struct kvm_vcpu *vcpu,
 				     unsigned long flags,
 				     unsigned long shift)
 {
-	return H_HARDWARE;
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_resize_hpt *resize;
+	long ret;
+
+	if (flags != 0)
+		return H_PARAMETER;
+
+	if (shift && ((shift < 18) || (shift > 46)))
+		return H_PARAMETER;
+
+	mutex_lock(&kvm->lock);
+
+	resize = kvm->arch.resize_hpt;
+	
+	/* This shouldn't be possible */
+	ret = H_HARDWARE;
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
+	ret = H_NOT_ACTIVE;
+	if (!resize || (resize->order != shift))
+		goto out;
+
+	ret = H_IN_PROGRESS;
+	if (!resize->prepare_done)
+		goto out;
+
+	ret = resize->error;
+	if (ret != H_SUCCESS)
+		goto out;
+
+	ret = resize_hpt_rehash(resize);
+
+	if (ret != H_SUCCESS)
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
 
 
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 878b4a7..5b09e22 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3229,6 +3229,10 @@ static int kvmppc_core_init_vm_hv(struct kvm *kvm)
 		lpcr |= LPCR_ONL;
 	kvm->arch.lpcr = lpcr;
 
+
+	/* Initialization for future HPT resizes */
+	kvm->arch.resize_hpt = NULL;
+
 	/*
 	 * Track that we now have a HV mode VM active. This blocks secondary
 	 * CPU threads from coming online.
-- 
2.5.0
