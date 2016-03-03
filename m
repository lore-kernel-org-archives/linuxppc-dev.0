Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9BC631A0342
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Mar 2016 12:59:56 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org,
	aik@ozlabs.ru,
	benh@kernel.crashing.org
Cc: bharata@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [RFC 18/18] powerpc/kvm: Outline of HPT resizing implementation
Date: Thu,  3 Mar 2016 12:59:49 +1100
Message-Id: <1456970389-28802-19-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1456970389-28802-1-git-send-email-david@gibson.dropbear.id.au>
References: <1456970389-28802-1-git-send-email-david@gibson.dropbear.id.au>
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
see through the resizing workflow, and adds in the synchronization between
this and the HPT resizing hypercalls.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/include/asm/kvm_host.h |   4 +
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 262 +++++++++++++++++++++++++++++++++++-
 arch/powerpc/kvm/book3s_hv.c        |   5 +
 3 files changed, 269 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 718dc56..6e7f2f7 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -230,6 +230,8 @@ struct kvm_hpt_info {
 	int cma;
 };
 
+struct kvm_resize_hpt;
+
 struct kvm_arch {
 	unsigned int lpid;
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
@@ -248,6 +250,8 @@ struct kvm_arch {
 	cpumask_t need_tlb_flush;
 	struct dentry *debugfs_dir;
 	struct dentry *htab_dentry;
+	struct kvm_resize_hpt *resize_hpt; /* protected by kvm->mmu_lock */
+	wait_queue_head_t resize_hpt_wq;
 #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
 #ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 	struct mutex hpt_mutex;
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index b92384f..fa3c0f3 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -40,6 +40,56 @@
 
 #include "trace_hv.h"
 
+#define DEBUG_RESIZE_HPT	1
+
+
+struct kvm_resize_hpt {
+	/* These fields are read-only after initialization */
+	struct kvm *kvm;
+	struct work_struct work;
+	u32 order;
+
+	/* These fields protected by kvm->mmu_lock */
+	unsigned long state;
+	/*	Prepare completed, or failed */
+#define 	RESIZE_HPT_PREPARED		(1UL << 1)
+	/*	Something failed in work thread */
+#define		RESIZE_HPT_FAILED		(1UL << 2)
+	/*	New HPT is active */
+#define		RESIZE_HPT_COMMITTED		(1UL << 3)
+
+	/*	H_COMMIT hypercall has started */
+#define		RESIZE_HPT_COMMIT		(1UL << 16)
+	/*	Cancelled */
+#define		RESIZE_HPT_CANCEL		(1UL << 17)
+	/*	All done, state can be free()d */
+#define		RESIZE_HPT_FREE			(1UL << 18)       
+
+	/* Private to the work thread, until RESIZE_HPT_FAILED is set,
+	 * thereafter read-only */
+	int error;
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
+static void resize_hpt_set_state(struct kvm_resize_hpt *resize,
+				   unsigned long newstate)
+{
+	struct kvm *kvm = resize->kvm;
+
+	resize->state |= newstate;
+	wake_up_all(&kvm->arch.resize_hpt_wq);
+}
+
 static long kvmppc_virtmode_do_h_enter(struct kvm *kvm, unsigned long flags,
 				long pte_index, unsigned long pteh,
 				unsigned long ptel, unsigned long *pte_idx_ret);
@@ -1120,19 +1170,227 @@ void kvmppc_unpin_guest_page(struct kvm *kvm, void *va, unsigned long gpa,
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
+static void resize_hpt_flush_rmaps(struct kvm_resize_hpt *resize)
+{
+}
+
+static void resize_hpt_free(struct kvm_resize_hpt *resize)
+{
+}
+
+static void resize_hpt_work(struct work_struct *work)
+{
+	struct kvm_resize_hpt *resize = container_of(work,
+						     struct kvm_resize_hpt,
+						     work);
+	struct kvm *kvm = resize->kvm;
+
+	resize_hpt_debug(resize, "Starting work, order = %d\n", resize->order);
+
+	resize->error = resize_hpt_allocate(resize);
+	spin_lock(&kvm->mmu_lock);
+
+	if (resize->error || (resize->state & RESIZE_HPT_CANCEL))
+		goto out;
+
+	resize_hpt_set_state(resize, RESIZE_HPT_PREPARED);
+
+	spin_unlock(&kvm->mmu_lock);
+	/* Unlocked access to state is safe here, because the bit can
+	 * only transition 0->1 */
+	wait_event(kvm->arch.resize_hpt_wq,
+		   resize->state & (RESIZE_HPT_COMMIT | RESIZE_HPT_CANCEL));
+	spin_lock(&kvm->mmu_lock);
+
+	if (resize->state & RESIZE_HPT_CANCEL)
+		goto out;
+
+	spin_unlock(&kvm->mmu_lock);
+	resize->error = resize_hpt_rehash(resize);
+	spin_lock(&kvm->mmu_lock);
+
+	if (resize->error || (resize->state & RESIZE_HPT_CANCEL))
+		goto out;
+
+	resize_hpt_pivot(resize);
+
+	resize_hpt_set_state(resize, RESIZE_HPT_COMMITTED);
+
+	BUG_ON((resize->state & RESIZE_HPT_CANCEL)
+	       || (kvm->arch.resize_hpt != resize));
+
+	spin_unlock(&kvm->mmu_lock);
+	resize_hpt_flush_rmaps(resize);
+	spin_lock(&kvm->mmu_lock);
+
+	BUG_ON((resize->state & RESIZE_HPT_CANCEL)
+	       || (kvm->arch.resize_hpt != resize));
+
+	kvm->arch.resize_hpt = NULL;
+
+out:
+	if (resize->error != H_SUCCESS)
+		resize_hpt_set_state(resize, RESIZE_HPT_FAILED);
+
+	spin_unlock(&kvm->mmu_lock);
+
+	resize_hpt_free(resize);
+
+	/* Unlocked access to state is safe here, because the bit can
+	 * only transition 0->1 */
+	wait_event(kvm->arch.resize_hpt_wq,
+		   resize->state & RESIZE_HPT_FREE);
+
+	kfree(resize);
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
+	// FIXME: resources limit of some sort
+
+	spin_lock(&kvm->mmu_lock);
+
+retry:
+	resize = kvm->arch.resize_hpt;
+
+	if (resize) {
+		if (resize->state & RESIZE_HPT_COMMITTED) {
+			/* Can't cancel a committed resize, have to
+			 * wait for it to complete */
+			ret = H_BUSY;
+			goto out;
+		}
+
+		if (resize->order == shift) {
+			/* Suitable resize in progress */
+			if (resize->state & RESIZE_HPT_FAILED) {
+				ret = resize->error;
+				kvm->arch.resize_hpt = NULL;
+				resize_hpt_set_state(resize, RESIZE_HPT_FREE);
+			} else if (resize->state & RESIZE_HPT_PREPARED) {
+				ret = H_SUCCESS;
+			} else {
+				ret = H_LONG_BUSY_ORDER_100_MSEC;
+			}
+
+			goto out;
+		}
+		
+		/* not suitable, cancel it */
+		kvm->arch.resize_hpt = NULL;
+		resize_hpt_set_state(resize,
+				     RESIZE_HPT_CANCEL | RESIZE_HPT_FREE);
+	}
+
+	spin_unlock(&kvm->mmu_lock);
+
+	if (!shift)
+		return H_SUCCESS; /* nothing to do */
+
+	/* start new resize */
+
+	resize = kmalloc(sizeof(*resize), GFP_KERNEL);
+	resize->order = shift;
+	resize->kvm = kvm;
+	resize->state = 0;
+	INIT_WORK(&resize->work, resize_hpt_work);
+
+	schedule_work(&resize->work);
+
+	spin_lock(&kvm->mmu_lock);
+
+	if (kvm->arch.resize_hpt) {
+		/* Race with another H_PREPARE */
+		resize_hpt_set_state(resize,
+				     RESIZE_HPT_CANCEL | RESIZE_HPT_FREE);
+		goto retry;
+	}
+
+	kvm->arch.resize_hpt = resize;
+
+	ret = H_LONG_BUSY_ORDER_100_MSEC;
+
+out:
+	spin_unlock(&kvm->mmu_lock);
+	return ret;
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
+	spin_lock(&kvm->mmu_lock);
+
+	resize = kvm->arch.resize_hpt;
+
+	ret = H_NOT_ACTIVE;
+	if (!resize || (resize->order != shift))
+		goto out;
+
+	resize_hpt_set_state(resize, RESIZE_HPT_COMMIT);
+
+	spin_unlock(&kvm->mmu_lock);
+	/* Unlocked read of resize->state here is safe, because the
+	 * bits can only ever transition 0->1 */
+	wait_event(kvm->arch.resize_hpt_wq,
+		   (resize->state & (RESIZE_HPT_COMMITTED | RESIZE_HPT_FAILED
+				     | RESIZE_HPT_CANCEL)));
+
+	spin_lock(&kvm->mmu_lock);
+
+	if (kvm->arch.resize_hpt != resize) {
+		BUG_ON(!(resize->state & RESIZE_HPT_CANCEL));
+		BUG_ON(!(resize->state & RESIZE_HPT_FREE));
+		ret = H_CLOSED;
+		goto out;
+	}
+
+	if (resize->state & RESIZE_HPT_FAILED)
+		ret = resize->error;
+	else
+		ret = H_SUCCESS;
+
+	resize_hpt_set_state(resize, RESIZE_HPT_FREE);
+
+out:
+	spin_unlock(&kvm->mmu_lock);
+	return ret;
 }
 
 
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 5a451f8..8ee459f 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3041,6 +3041,11 @@ static int kvmppc_core_init_vm_hv(struct kvm *kvm)
 		lpcr |= LPCR_ONL;
 	kvm->arch.lpcr = lpcr;
 
+
+	/* Initialization for future HPT resizes */
+	kvm->arch.resize_hpt = NULL;
+	init_waitqueue_head(&kvm->arch.resize_hpt_wq);
+
 	/*
 	 * Track that we now have a HV mode VM active. This blocks secondary
 	 * CPU threads from coming online.
-- 
2.5.0
