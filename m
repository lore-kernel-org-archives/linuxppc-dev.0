Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 15BC82C034D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 20:04:12 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 27 Sep 2013 15:34:07 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 43384E0059
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 15:35:11 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8RA6Mv639059598
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 15:36:22 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8RA44Q9020344
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 15:34:04 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [RFC PATCH 10/11] kvm: powerpc: book3s: Allow the HV and PR selection
 per virtual machine
Date: Fri, 27 Sep 2013 15:33:52 +0530
Message-Id: <1380276233-17095-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1380276233-17095-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1380276233-17095-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

This moves the kvmppc_ops callbacks to be a per VM entity. This
enables us to select HV and PR mode when creating a VM

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_host.h |  3 ++
 arch/powerpc/include/asm/kvm_ppc.h  | 11 ++++--
 arch/powerpc/kvm/book3s.c           | 60 +++++++++++++++---------------
 arch/powerpc/kvm/book3s_hv.c        | 18 +++++----
 arch/powerpc/kvm/book3s_pr.c        | 18 ++++++---
 arch/powerpc/kvm/emulate.c          | 11 +++---
 arch/powerpc/kvm/powerpc.c          | 74 ++++++++++++++++++++++++-------------
 include/linux/kvm_host.h            |  7 ++--
 include/uapi/linux/kvm.h            |  4 ++
 virt/kvm/kvm_main.c                 | 18 ++++-----
 10 files changed, 135 insertions(+), 89 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 283e52e..61a297fc 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -276,6 +276,9 @@ struct kvm_arch {
 #ifdef CONFIG_KVM_XICS
 	struct kvmppc_xics *xics;
 #endif
+#ifdef CONFIG_PPC_BOOK3S_64
+	struct kvmppc_ops *kvm_ops;
+#endif
 };
 
 /*
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 592501b..a4a5893 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -134,9 +134,11 @@ extern struct page *kvm_alloc_hpt(unsigned long nr_pages);
 extern void kvm_release_hpt(struct page *page, unsigned long nr_pages);
 extern int kvmppc_core_init_vm(struct kvm *kvm);
 extern void kvmppc_core_destroy_vm(struct kvm *kvm);
-extern void kvmppc_core_free_memslot(struct kvm_memory_slot *free,
+extern void kvmppc_core_free_memslot(struct kvm *kvm,
+				     struct kvm_memory_slot *free,
 				     struct kvm_memory_slot *dont);
-extern int kvmppc_core_create_memslot(struct kvm_memory_slot *slot,
+extern int kvmppc_core_create_memslot(struct kvm *kvm,
+				      struct kvm_memory_slot *slot,
 				      unsigned long npages);
 extern int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 				struct kvm_memory_slot *memslot,
@@ -216,7 +218,8 @@ struct kvmppc_ops {
 
 };
 
-extern struct kvmppc_ops *kvmppc_ops;
+extern struct kvmppc_ops *kvmppc_hv_ops;
+extern struct kvmppc_ops *kvmppc_pr_ops;
 
 /*
  * Cuts out inst bits with ordering according to spec.
@@ -324,7 +327,7 @@ static inline void kvmppc_set_host_ipi(int cpu, u8 host_ipi)
 
 static inline void kvmppc_fast_vcpu_kick(struct kvm_vcpu *vcpu)
 {
-	kvmppc_ops->fast_vcpu_kick(vcpu);
+	vcpu->kvm->arch.kvm_ops->fast_vcpu_kick(vcpu);
 }
 
 #else
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 485a6ff..34e189c 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -71,7 +71,7 @@ void kvmppc_core_load_guest_debugstate(struct kvm_vcpu *vcpu)
 
 static inline unsigned long kvmppc_interrupt_offset(struct kvm_vcpu *vcpu)
 {
-	if (!kvmppc_ops->is_hv_enabled)
+	if (!vcpu->kvm->arch.kvm_ops->is_hv_enabled)
 		return to_book3s(vcpu)->hior;
 	return 0;
 }
@@ -79,7 +79,7 @@ static inline unsigned long kvmppc_interrupt_offset(struct kvm_vcpu *vcpu)
 static inline void kvmppc_update_int_pending(struct kvm_vcpu *vcpu,
 			unsigned long pending_now, unsigned long old_pending)
 {
-	if (kvmppc_ops->is_hv_enabled)
+	if (vcpu->kvm->arch.kvm_ops->is_hv_enabled)
 		return;
 	if (pending_now)
 		vcpu->arch.shared->int_pending = 1;
@@ -93,7 +93,7 @@ static inline bool kvmppc_critical_section(struct kvm_vcpu *vcpu)
 	ulong crit_r1;
 	bool crit;
 
-	if (kvmppc_ops->is_hv_enabled)
+	if (vcpu->kvm->arch.kvm_ops->is_hv_enabled)
 		return false;
 
 	crit_raw = vcpu->arch.shared->critical;
@@ -470,13 +470,13 @@ void kvmppc_subarch_vcpu_uninit(struct kvm_vcpu *vcpu)
 int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 				  struct kvm_sregs *sregs)
 {
-	return kvmppc_ops->get_sregs(vcpu, sregs);
+	return vcpu->kvm->arch.kvm_ops->get_sregs(vcpu, sregs);
 }
 
 int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 				  struct kvm_sregs *sregs)
 {
-	return kvmppc_ops->set_sregs(vcpu, sregs);
+	return vcpu->kvm->arch.kvm_ops->set_sregs(vcpu, sregs);
 }
 
 int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
@@ -555,7 +555,7 @@ int kvm_vcpu_ioctl_get_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 	if (size > sizeof(val))
 		return -EINVAL;
 
-	r = kvmppc_ops->get_one_reg(vcpu, reg->id, &val);
+	r = vcpu->kvm->arch.kvm_ops->get_one_reg(vcpu, reg->id, &val);
 	if (r == -EINVAL) {
 		r = 0;
 		switch (reg->id) {
@@ -631,7 +631,7 @@ int kvm_vcpu_ioctl_set_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 	if (copy_from_user(&val, (char __user *)(unsigned long)reg->addr, size))
 		return -EFAULT;
 
-	r = kvmppc_ops->set_one_reg(vcpu, reg->id, &val);
+	r = vcpu->kvm->arch.kvm_ops->set_one_reg(vcpu, reg->id, &val);
 	if (r == -EINVAL) {
 		r = 0;
 		switch (reg->id) {
@@ -685,23 +685,23 @@ int kvm_vcpu_ioctl_set_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 
 void kvmppc_core_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
-	kvmppc_ops->vcpu_load(vcpu, cpu);
+	vcpu->kvm->arch.kvm_ops->vcpu_load(vcpu, cpu);
 }
 
 void kvmppc_core_vcpu_put(struct kvm_vcpu *vcpu)
 {
-	kvmppc_ops->vcpu_put(vcpu);
+	vcpu->kvm->arch.kvm_ops->vcpu_put(vcpu);
 }
 
 void kvmppc_set_msr(struct kvm_vcpu *vcpu, u64 msr)
 {
-	kvmppc_ops->set_msr(vcpu, msr);
+	vcpu->kvm->arch.kvm_ops->set_msr(vcpu, msr);
 }
 EXPORT_SYMBOL_GPL(kvmppc_set_msr);
 
 int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 {
-	return kvmppc_ops->vcpu_run(kvm_run, vcpu);
+	return vcpu->kvm->arch.kvm_ops->vcpu_run(kvm_run, vcpu);
 }
 
 int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
@@ -726,84 +726,84 @@ void kvmppc_decrementer_func(unsigned long data)
 
 struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
 {
-	return kvmppc_ops->vcpu_create(kvm, id);
+	return kvm->arch.kvm_ops->vcpu_create(kvm, id);
 }
 
 void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
 {
-	kvmppc_ops->vcpu_free(vcpu);
+	vcpu->kvm->arch.kvm_ops->vcpu_free(vcpu);
 }
 
 int kvmppc_core_check_requests(struct kvm_vcpu *vcpu)
 {
-	return kvmppc_ops->check_requests(vcpu);
+	return vcpu->kvm->arch.kvm_ops->check_requests(vcpu);
 }
 
 int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
 {
-	return kvmppc_ops->get_dirty_log(kvm, log);
+	return kvm->arch.kvm_ops->get_dirty_log(kvm, log);
 }
 
-void kvmppc_core_free_memslot(struct kvm_memory_slot *free,
+void kvmppc_core_free_memslot(struct kvm *kvm, struct kvm_memory_slot *free,
 			      struct kvm_memory_slot *dont)
 {
-	kvmppc_ops->free_memslot(free, dont);
+	kvm->arch.kvm_ops->free_memslot(free, dont);
 }
 
-int kvmppc_core_create_memslot(struct kvm_memory_slot *slot,
+int kvmppc_core_create_memslot(struct kvm *kvm, struct kvm_memory_slot *slot,
 			       unsigned long npages)
 {
-	return kvmppc_ops->create_memslot(slot, npages);
+	return kvm->arch.kvm_ops->create_memslot(slot, npages);
 }
 
 void kvmppc_core_flush_memslot(struct kvm *kvm, struct kvm_memory_slot *memslot)
 {
-	kvmppc_ops->flush_memslot(kvm, memslot);
+	kvm->arch.kvm_ops->flush_memslot(kvm, memslot);
 }
 
 int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 				struct kvm_memory_slot *memslot,
 				struct kvm_userspace_memory_region *mem)
 {
-	return kvmppc_ops->prepare_memory_region(kvm, memslot, mem);
+	return kvm->arch.kvm_ops->prepare_memory_region(kvm, memslot, mem);
 }
 
 void kvmppc_core_commit_memory_region(struct kvm *kvm,
 				struct kvm_userspace_memory_region *mem,
 				const struct kvm_memory_slot *old)
 {
-	kvmppc_ops->commit_memory_region(kvm, mem, old);
+	kvm->arch.kvm_ops->commit_memory_region(kvm, mem, old);
 }
 
 int kvm_unmap_hva(struct kvm *kvm, unsigned long hva)
 {
-	return kvmppc_ops->unmap_hva(kvm, hva);
+	return kvm->arch.kvm_ops->unmap_hva(kvm, hva);
 }
 EXPORT_SYMBOL_GPL(kvm_unmap_hva);
 
 int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end)
 {
-	return kvmppc_ops->unmap_hva_range(kvm, start, end);
+	return kvm->arch.kvm_ops->unmap_hva_range(kvm, start, end);
 }
 
 int kvm_age_hva(struct kvm *kvm, unsigned long hva)
 {
-	return kvmppc_ops->age_hva(kvm, hva);
+	return kvm->arch.kvm_ops->age_hva(kvm, hva);
 }
 
 int kvm_test_age_hva(struct kvm *kvm, unsigned long hva)
 {
-	return kvmppc_ops->test_age_hva(kvm, hva);
+	return kvm->arch.kvm_ops->test_age_hva(kvm, hva);
 }
 
 void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
 {
-	kvmppc_ops->set_spte_hva(kvm, hva, pte);
+	kvm->arch.kvm_ops->set_spte_hva(kvm, hva, pte);
 }
 
 void kvmppc_mmu_destroy(struct kvm_vcpu *vcpu)
 {
-	kvmppc_ops->mmu_destroy(vcpu);
+	vcpu->kvm->arch.kvm_ops->mmu_destroy(vcpu);
 }
 
 int kvmppc_core_init_vm(struct kvm *kvm)
@@ -814,12 +814,12 @@ int kvmppc_core_init_vm(struct kvm *kvm)
 	INIT_LIST_HEAD(&kvm->arch.rtas_tokens);
 #endif
 
-	return kvmppc_ops->init_vm(kvm);
+	return kvm->arch.kvm_ops->init_vm(kvm);
 }
 
 void kvmppc_core_destroy_vm(struct kvm *kvm)
 {
-	kvmppc_ops->destroy_vm(kvm);
+	kvm->arch.kvm_ops->destroy_vm(kvm);
 
 #ifdef CONFIG_PPC64
 	kvmppc_rtas_tokens_free(kvm);
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 4322db4..0a684a7 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2052,7 +2052,7 @@ extern int kvm_age_hva_hv(struct kvm *kvm, unsigned long hva);
 extern int kvm_test_age_hva_hv(struct kvm *kvm, unsigned long hva);
 extern void kvm_set_spte_hva_hv(struct kvm *kvm, unsigned long hva, pte_t pte);
 
-static struct kvmppc_ops kvmppc_hv_ops = {
+static struct kvmppc_ops kvm_ops_hv = {
 	.is_hv_enabled = true,
 	.get_sregs = kvm_arch_vcpu_ioctl_get_sregs_hv,
 	.set_sregs = kvm_arch_vcpu_ioctl_set_sregs_hv,
@@ -2092,11 +2092,13 @@ static int kvmppc_book3s_init_hv(void)
 {
 	int r;
 
-	r = kvm_init(&kvmppc_hv_ops, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
-
-	if (r)
-		return r;
-
+	if (!kvmppc_pr_ops) {
+		r = kvm_init(&kvm_ops_hv, sizeof(struct kvm_vcpu),
+			     0, THIS_MODULE);
+		if (r)
+			return r;
+	}
+	kvmppc_hv_ops = &kvm_ops_hv;
 	r = kvmppc_mmu_hv_init();
 
 	return r;
@@ -2104,7 +2106,9 @@ static int kvmppc_book3s_init_hv(void)
 
 static void kvmppc_book3s_exit_hv(void)
 {
-	kvm_exit();
+	kvmppc_hv_ops = NULL;
+	if (!kvmppc_pr_ops)
+		kvm_exit();
 }
 
 module_init(kvmppc_book3s_init_hv);
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 127b961..e49e4b0 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -1511,7 +1511,7 @@ extern int kvmppc_core_emulate_mtspr_pr(struct kvm_vcpu *vcpu,
 extern int kvmppc_core_emulate_mfspr_pr(struct kvm_vcpu *vcpu,
 					int sprn, ulong *spr_val);
 
-static struct kvmppc_ops kvmppc_pr_ops = {
+static struct kvmppc_ops kvm_ops_pr = {
 	.is_hv_enabled = false,
 	.get_sregs = kvm_arch_vcpu_ioctl_get_sregs_pr,
 	.set_sregs = kvm_arch_vcpu_ioctl_set_sregs_pr,
@@ -1551,10 +1551,14 @@ static int kvmppc_book3s_init_pr(void)
 {
 	int r;
 
-	r = kvm_init(&kvmppc_pr_ops, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
-
-	if (r)
-		return r;
+	if (!kvmppc_hv_ops) {
+		r = kvm_init(&kvm_ops_pr, sizeof(struct kvm_vcpu),
+			     0, THIS_MODULE);
+		if (r)
+			return r;
+	}
+	/* Assign the global value */
+	kvmppc_pr_ops = &kvm_ops_pr;
 
 	r = kvmppc_mmu_hpte_sysinit();
 
@@ -1563,8 +1567,10 @@ static int kvmppc_book3s_init_pr(void)
 
 static void kvmppc_book3s_exit_pr(void)
 {
+	kvmppc_pr_ops = NULL;
 	kvmppc_mmu_hpte_sysexit();
-	kvm_exit();
+	if (!kvmppc_hv_ops)
+		kvm_exit();
 }
 
 module_init(kvmppc_book3s_init_pr);
diff --git a/arch/powerpc/kvm/emulate.c b/arch/powerpc/kvm/emulate.c
index de9a340..2f9a087 100644
--- a/arch/powerpc/kvm/emulate.c
+++ b/arch/powerpc/kvm/emulate.c
@@ -130,8 +130,8 @@ static int kvmppc_emulate_mtspr(struct kvm_vcpu *vcpu, int sprn, int rs)
 	case SPRN_PIR: break;
 
 	default:
-		emulated = kvmppc_ops->emulate_mtspr(vcpu, sprn,
-						     spr_val);
+		emulated = vcpu->kvm->arch.kvm_ops->emulate_mtspr(vcpu, sprn,
+								  spr_val);
 		if (emulated == EMULATE_FAIL)
 			printk(KERN_INFO "mtspr: unknown spr "
 				"0x%x\n", sprn);
@@ -191,8 +191,8 @@ static int kvmppc_emulate_mfspr(struct kvm_vcpu *vcpu, int sprn, int rt)
 		spr_val = kvmppc_get_dec(vcpu, get_tb());
 		break;
 	default:
-		emulated = kvmppc_ops->emulate_mfspr(vcpu, sprn,
-						     &spr_val);
+		emulated = vcpu->kvm->arch.kvm_ops->emulate_mfspr(vcpu, sprn,
+								  &spr_val);
 		if (unlikely(emulated == EMULATE_FAIL)) {
 			printk(KERN_INFO "mfspr: unknown spr "
 				"0x%x\n", sprn);
@@ -464,7 +464,8 @@ int kvmppc_emulate_instruction(struct kvm_run *run, struct kvm_vcpu *vcpu)
 	}
 
 	if (emulated == EMULATE_FAIL) {
-		emulated = kvmppc_ops->emulate_op(run, vcpu, inst, &advance);
+		emulated = vcpu->kvm->arch.kvm_ops->emulate_op(run, vcpu, inst,
+							       &advance);
 		if (emulated == EMULATE_AGAIN) {
 			advance = 0;
 		} else if (emulated == EMULATE_FAIL) {
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 1404f4d..1209229 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -39,7 +39,11 @@
 #define CREATE_TRACE_POINTS
 #include "trace.h"
 
-struct kvmppc_ops *kvmppc_ops;
+struct kvmppc_ops *kvmppc_hv_ops;
+struct kvmppc_ops *kvmppc_pr_ops;
+EXPORT_SYMBOL_GPL(kvmppc_hv_ops);
+EXPORT_SYMBOL_GPL(kvmppc_pr_ops);
+
 
 int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
 {
@@ -195,7 +199,7 @@ int kvmppc_sanity_check(struct kvm_vcpu *vcpu)
 		goto out;
 
 	/* HV KVM can only do PAPR mode for now */
-	if (!vcpu->arch.papr_enabled && kvmppc_ops->is_hv_enabled)
+	if (!vcpu->arch.papr_enabled && vcpu->kvm->arch.kvm_ops->is_hv_enabled)
 		goto out;
 
 #ifdef CONFIG_KVM_BOOKE_HV
@@ -266,10 +270,28 @@ void kvm_arch_hardware_unsetup(void)
 
 int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 {
-	if (type)
-		return -EINVAL;
+	/*
+	 * if we have both HV and PR enabled, default is HV
+	 */
+	if (type == 0) {
+		if (kvmppc_hv_ops)
+			kvm->arch.kvm_ops = kvmppc_hv_ops;
+		else
+			kvm->arch.kvm_ops = kvmppc_pr_ops;
+	} else	if (type == KVM_VM_PPC_HV) {
+		if (!kvmppc_hv_ops)
+			goto err_out;
+		kvm->arch.kvm_ops = kvmppc_hv_ops;
+	} else if (type == KVM_VM_PPC_PR) {
+		if (!kvmppc_pr_ops)
+			goto err_out;
+		kvm->arch.kvm_ops = kvmppc_pr_ops;
+	} else
+		goto err_out;
 
 	return kvmppc_core_init_vm(kvm);
+err_out:
+	return -EINVAL;
 }
 
 void kvm_arch_destroy_vm(struct kvm *kvm)
@@ -295,9 +317,13 @@ void kvm_arch_sync_events(struct kvm *kvm)
 {
 }
 
-int kvm_dev_ioctl_check_extension(long ext)
+int kvm_dev_ioctl_check_extension(struct file *filp, long ext)
 {
 	int r;
+	/* FIXME!!
+	 * Should some of this be vm ioctl ? is it possible now ?
+	 */
+	int hv_enabled = kvmppc_hv_ops ? 1: 0;
 
 	switch (ext) {
 #ifdef CONFIG_BOOKE
@@ -324,7 +350,7 @@ int kvm_dev_ioctl_check_extension(long ext)
 	case KVM_CAP_SW_TLB:
 #endif
 		/* We support this only for PR */
-		r = !kvmppc_ops->is_hv_enabled;
+		r = !hv_enabled;
 		break;
 #ifdef CONFIG_KVM_MMIO
 	case KVM_CAP_COALESCED_MMIO:
@@ -349,13 +375,13 @@ int kvm_dev_ioctl_check_extension(long ext)
 #endif /* CONFIG_PPC_BOOK3S_64 */
 #ifdef CONFIG_KVM_BOOK3S_HV
 	case KVM_CAP_PPC_SMT:
-		if (kvmppc_ops->is_hv_enabled)
+		if (hv_enabled)
 			r = threads_per_core;
 		else
 			r = 0;
 		break;
 	case KVM_CAP_PPC_RMA:
-		r = kvmppc_ops->is_hv_enabled;
+		r = hv_enabled;
 		/* PPC970 requires an RMA */
 		if (r && cpu_has_feature(CPU_FTR_ARCH_201))
 			r = 2;
@@ -363,7 +389,7 @@ int kvm_dev_ioctl_check_extension(long ext)
 #endif
 	case KVM_CAP_SYNC_MMU:
 #ifdef CONFIG_KVM_BOOK3S_HV
-		if (kvmppc_ops->is_hv_enabled)
+		if (hv_enabled)
 			r = cpu_has_feature(CPU_FTR_ARCH_206) ? 1 : 0;
 		else
 			r = 0;
@@ -375,7 +401,7 @@ int kvm_dev_ioctl_check_extension(long ext)
 		break;
 #ifdef CONFIG_KVM_BOOK3S_HV
 	case KVM_CAP_PPC_HTAB_FD:
-		r = kvmppc_ops->is_hv_enabled;
+		r = hv_enabled;
 		break;
 #endif
 	case KVM_CAP_NR_VCPUS:
@@ -385,7 +411,7 @@ int kvm_dev_ioctl_check_extension(long ext)
 		 * will have secondary threads "offline"), and for other KVM
 		 * implementations just count online CPUs.
 		 */
-		if (kvmppc_ops->is_hv_enabled)
+		if (hv_enabled)
 			r = num_present_cpus();
 		else
 			r = num_online_cpus();
@@ -412,15 +438,16 @@ long kvm_arch_dev_ioctl(struct file *filp,
 	return -EINVAL;
 }
 
-void kvm_arch_free_memslot(struct kvm_memory_slot *free,
+void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *free,
 			   struct kvm_memory_slot *dont)
 {
-	kvmppc_core_free_memslot(free, dont);
+	kvmppc_core_free_memslot(kvm, free, dont);
 }
 
-int kvm_arch_create_memslot(struct kvm_memory_slot *slot, unsigned long npages)
+int kvm_arch_create_memslot(struct kvm *kvm, struct kvm_memory_slot *slot,
+			    unsigned long npages)
 {
-	return kvmppc_core_create_memslot(slot, npages);
+	return kvmppc_core_create_memslot(kvm, slot, npages);
 }
 
 void kvm_arch_memslots_updated(struct kvm *kvm)
@@ -1033,9 +1060,10 @@ long kvm_arch_vm_ioctl(struct file *filp,
 	}
 	case KVM_PPC_GET_SMMU_INFO: {
 		struct kvm_ppc_smmu_info info;
+		struct kvm *kvm = filp->private_data;
 
 		memset(&info, 0, sizeof(info));
-		r = kvmppc_ops->get_smmu_info(kvm, &info);
+		r = kvm->arch.kvm_ops->get_smmu_info(kvm, &info);
 		if (r >= 0 && copy_to_user(argp, &info, sizeof(info)))
 			r = -EFAULT;
 		break;
@@ -1046,9 +1074,10 @@ long kvm_arch_vm_ioctl(struct file *filp,
 		r = kvm_vm_ioctl_rtas_define_token(kvm, argp);
 		break;
 	}
-	default:
-		r = kvmppc_ops->arch_vm_ioctl(filp, ioctl, arg);
-
+	default: {
+		struct kvm *kvm = filp->private_data;
+		r = kvm->arch.kvm_ops->arch_vm_ioctl(filp, ioctl, arg);
+	}
 #else /* CONFIG_PPC_BOOK3S_64 */
 	default:
 		r = -ENOTTY;
@@ -1094,15 +1123,10 @@ void kvmppc_init_lpid(unsigned long nr_lpids_param)
 
 int kvm_arch_init(void *opaque)
 {
-	if (kvmppc_ops) {
-		printk(KERN_ERR "kvm: already loaded the other module\n");
-		return -EEXIST;
-	}
-	kvmppc_ops = (struct kvmppc_ops *)opaque;
 	return 0;
 }
 
 void kvm_arch_exit(void)
 {
-	kvmppc_ops = NULL;
+
 }
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 459b359..2938636 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -508,9 +508,10 @@ int kvm_set_memory_region(struct kvm *kvm,
 			  struct kvm_userspace_memory_region *mem);
 int __kvm_set_memory_region(struct kvm *kvm,
 			    struct kvm_userspace_memory_region *mem);
-void kvm_arch_free_memslot(struct kvm_memory_slot *free,
+void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *free,
 			   struct kvm_memory_slot *dont);
-int kvm_arch_create_memslot(struct kvm_memory_slot *slot, unsigned long npages);
+int kvm_arch_create_memslot(struct kvm *kvm, struct kvm_memory_slot *slot,
+			    unsigned long npages);
 void kvm_arch_memslots_updated(struct kvm *kvm);
 int kvm_arch_prepare_memory_region(struct kvm *kvm,
 				struct kvm_memory_slot *memslot,
@@ -597,7 +598,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 			 unsigned int ioctl, unsigned long arg);
 int kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf);
 
-int kvm_dev_ioctl_check_extension(long ext);
+int kvm_dev_ioctl_check_extension(struct file *filp, long ext);
 
 int kvm_get_dirty_log(struct kvm *kvm,
 			struct kvm_dirty_log *log, int *is_dirty);
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 99c2533..aebfc11 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -518,6 +518,10 @@ struct kvm_ppc_smmu_info {
 /* machine type bits, to be used as argument to KVM_CREATE_VM */
 #define KVM_VM_S390_UCONTROL	1
 
+/* on ppc, 0 indicate default, 1 should force HV and 2 PR */
+#define KVM_VM_PPC_HV 1
+#define KVM_VM_PPC_PR 2
+
 #define KVM_S390_SIE_PAGE_OFFSET 1
 
 /*
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 0594b22..2d43702 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -541,13 +541,13 @@ static void kvm_destroy_dirty_bitmap(struct kvm_memory_slot *memslot)
 /*
  * Free any memory in @free but not in @dont.
  */
-static void kvm_free_physmem_slot(struct kvm_memory_slot *free,
+static void kvm_free_physmem_slot(struct kvm *kvm, struct kvm_memory_slot *free,
 				  struct kvm_memory_slot *dont)
 {
 	if (!dont || free->dirty_bitmap != dont->dirty_bitmap)
 		kvm_destroy_dirty_bitmap(free);
 
-	kvm_arch_free_memslot(free, dont);
+	kvm_arch_free_memslot(kvm, free, dont);
 
 	free->npages = 0;
 }
@@ -558,7 +558,7 @@ void kvm_free_physmem(struct kvm *kvm)
 	struct kvm_memory_slot *memslot;
 
 	kvm_for_each_memslot(memslot, slots)
-		kvm_free_physmem_slot(memslot, NULL);
+		kvm_free_physmem_slot(kvm, memslot, NULL);
 
 	kfree(kvm->memslots);
 }
@@ -822,7 +822,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
 	if (change == KVM_MR_CREATE) {
 		new.userspace_addr = mem->userspace_addr;
 
-		if (kvm_arch_create_memslot(&new, npages))
+		if (kvm_arch_create_memslot(kvm, &new, npages))
 			goto out_free;
 	}
 
@@ -898,7 +898,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
 
 	kvm_arch_commit_memory_region(kvm, mem, &old, change);
 
-	kvm_free_physmem_slot(&old, &new);
+	kvm_free_physmem_slot(kvm, &old, &new);
 	kfree(old_memslots);
 
 	return 0;
@@ -906,7 +906,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
 out_slots:
 	kfree(slots);
 out_free:
-	kvm_free_physmem_slot(&new, &old);
+	kvm_free_physmem_slot(kvm, &new, &old);
 out:
 	return r;
 }
@@ -2579,7 +2579,7 @@ static int kvm_dev_ioctl_create_vm(unsigned long type)
 	return r;
 }
 
-static long kvm_dev_ioctl_check_extension_generic(long arg)
+static long kvm_dev_ioctl_check_extension_generic(struct file *filp, long arg)
 {
 	switch (arg) {
 	case KVM_CAP_USER_MEMORY:
@@ -2603,7 +2603,7 @@ static long kvm_dev_ioctl_check_extension_generic(long arg)
 	default:
 		break;
 	}
-	return kvm_dev_ioctl_check_extension(arg);
+	return kvm_dev_ioctl_check_extension(filp, arg);
 }
 
 static long kvm_dev_ioctl(struct file *filp,
@@ -2622,7 +2622,7 @@ static long kvm_dev_ioctl(struct file *filp,
 		r = kvm_dev_ioctl_create_vm(arg);
 		break;
 	case KVM_CHECK_EXTENSION:
-		r = kvm_dev_ioctl_check_extension_generic(arg);
+		r = kvm_dev_ioctl_check_extension_generic(filp, arg);
 		break;
 	case KVM_GET_VCPU_MMAP_SIZE:
 		r = -EINVAL;
-- 
1.8.1.2
