Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BB2A92C00C8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2013 03:48:58 +1100 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 8 Oct 2013 02:48:57 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 787183578060
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2013 03:48:56 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r97Gmj176554006
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Oct 2013 03:48:45 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r97Gmume025264
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Oct 2013 03:48:56 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V2 13/14] kvm: powerpc: book3s: Allow the HV and PR selection
 per virtual machine
Date: Mon,  7 Oct 2013 22:18:01 +0530
Message-Id: <1381164482-31001-14-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1381164482-31001-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1381164482-31001-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
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
enables us to select HV and PR mode when creating a VM. We also
allow both kvm-hv and kvm-pr kernel module to be loaded. To
achieve this we move /dev/kvm ownership to kvm.ko module. Depending on
which KVM mode we select during VM creation we take a reference
count on respective module

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_host.h |  1 +
 arch/powerpc/include/asm/kvm_ppc.h  |  7 +--
 arch/powerpc/kvm/44x.c              |  7 ++-
 arch/powerpc/kvm/book3s.c           | 89 +++++++++++++++++++++++++------------
 arch/powerpc/kvm/book3s.h           |  2 +
 arch/powerpc/kvm/book3s_hv.c        | 18 ++++----
 arch/powerpc/kvm/book3s_pr.c        | 25 +++++++----
 arch/powerpc/kvm/book3s_xics.c      |  2 +-
 arch/powerpc/kvm/booke.c            | 22 ++++-----
 arch/powerpc/kvm/e500.c             |  8 +++-
 arch/powerpc/kvm/e500mc.c           |  6 ++-
 arch/powerpc/kvm/emulate.c          | 11 ++---
 arch/powerpc/kvm/powerpc.c          | 76 ++++++++++++++++++++++---------
 include/uapi/linux/kvm.h            |  4 ++
 14 files changed, 187 insertions(+), 91 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index e86db97..c7a041d 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -275,6 +275,7 @@ struct kvm_arch {
 #ifdef CONFIG_KVM_XICS
 	struct kvmppc_xics *xics;
 #endif
+	struct kvmppc_ops *kvm_ops;
 };
 
 /*
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 20f4616..3069cf4 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -182,6 +182,7 @@ union kvmppc_one_reg {
 };
 
 struct kvmppc_ops {
+	struct module *owner;
 	bool is_hv_enabled;
 	int (*get_sregs)(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs);
 	int (*set_sregs)(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs);
@@ -217,7 +218,6 @@ struct kvmppc_ops {
 			      unsigned long npages);
 	int (*init_vm)(struct kvm *kvm);
 	void (*destroy_vm)(struct kvm *kvm);
-	int (*check_processor_compat)(void);
 	int (*get_smmu_info)(struct kvm *kvm, struct kvm_ppc_smmu_info *info);
 	int (*emulate_op)(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			  unsigned int inst, int *advance);
@@ -229,7 +229,8 @@ struct kvmppc_ops {
 
 };
 
-extern struct kvmppc_ops *kvmppc_ops;
+extern struct kvmppc_ops *kvmppc_hv_ops;
+extern struct kvmppc_ops *kvmppc_pr_ops;
 
 /*
  * Cuts out inst bits with ordering according to spec.
@@ -326,7 +327,7 @@ static inline void kvmppc_set_host_ipi(int cpu, u8 host_ipi)
 
 static inline void kvmppc_fast_vcpu_kick(struct kvm_vcpu *vcpu)
 {
-	kvmppc_ops->fast_vcpu_kick(vcpu);
+	vcpu->kvm->arch.kvm_ops->fast_vcpu_kick(vcpu);
 }
 
 #else
diff --git a/arch/powerpc/kvm/44x.c b/arch/powerpc/kvm/44x.c
index a765bcd..93221e8 100644
--- a/arch/powerpc/kvm/44x.c
+++ b/arch/powerpc/kvm/44x.c
@@ -213,16 +213,19 @@ static int __init kvmppc_44x_init(void)
 	if (r)
 		goto err_out;
 
-	r = kvm_init(&kvm_ops_44x, sizeof(struct kvmppc_vcpu_44x),
-		     0, THIS_MODULE);
+	r = kvm_init(NULL, sizeof(struct kvmppc_vcpu_44x), 0, THIS_MODULE);
 	if (r)
 		goto err_out;
+	kvm_ops_44x.owner = THIS_MODULE;
+	kvmppc_pr_ops = &kvm_ops_44x;
+
 err_out:
 	return r;
 }
 
 static void __exit kvmppc_44x_exit(void)
 {
+	kvmppc_pr_ops = NULL;
 	kvmppc_booke_exit();
 }
 
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 130fe1d..ad8f6ed 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -34,6 +34,7 @@
 #include <linux/vmalloc.h>
 #include <linux/highmem.h>
 
+#include "book3s.h"
 #include "trace.h"
 
 #define VCPU_STAT(x) offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU
@@ -71,7 +72,7 @@ void kvmppc_core_load_guest_debugstate(struct kvm_vcpu *vcpu)
 
 static inline unsigned long kvmppc_interrupt_offset(struct kvm_vcpu *vcpu)
 {
-	if (!kvmppc_ops->is_hv_enabled)
+	if (!vcpu->kvm->arch.kvm_ops->is_hv_enabled)
 		return to_book3s(vcpu)->hior;
 	return 0;
 }
@@ -79,7 +80,7 @@ static inline unsigned long kvmppc_interrupt_offset(struct kvm_vcpu *vcpu)
 static inline void kvmppc_update_int_pending(struct kvm_vcpu *vcpu,
 			unsigned long pending_now, unsigned long old_pending)
 {
-	if (kvmppc_ops->is_hv_enabled)
+	if (vcpu->kvm->arch.kvm_ops->is_hv_enabled)
 		return;
 	if (pending_now)
 		vcpu->arch.shared->int_pending = 1;
@@ -93,7 +94,7 @@ static inline bool kvmppc_critical_section(struct kvm_vcpu *vcpu)
 	ulong crit_r1;
 	bool crit;
 
-	if (kvmppc_ops->is_hv_enabled)
+	if (vcpu->kvm->arch.kvm_ops->is_hv_enabled)
 		return false;
 
 	crit_raw = vcpu->arch.shared->critical;
@@ -477,13 +478,13 @@ void kvmppc_subarch_vcpu_uninit(struct kvm_vcpu *vcpu)
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
@@ -562,7 +563,7 @@ int kvm_vcpu_ioctl_get_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 	if (size > sizeof(val))
 		return -EINVAL;
 
-	r = kvmppc_ops->get_one_reg(vcpu, reg->id, &val);
+	r = vcpu->kvm->arch.kvm_ops->get_one_reg(vcpu, reg->id, &val);
 	if (r == -EINVAL) {
 		r = 0;
 		switch (reg->id) {
@@ -641,7 +642,7 @@ int kvm_vcpu_ioctl_set_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 	if (copy_from_user(&val, (char __user *)(unsigned long)reg->addr, size))
 		return -EFAULT;
 
-	r = kvmppc_ops->set_one_reg(vcpu, reg->id, &val);
+	r = vcpu->kvm->arch.kvm_ops->set_one_reg(vcpu, reg->id, &val);
 	if (r == -EINVAL) {
 		r = 0;
 		switch (reg->id) {
@@ -702,23 +703,23 @@ int kvm_vcpu_ioctl_set_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 
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
@@ -743,84 +744,84 @@ void kvmppc_decrementer_func(unsigned long data)
 
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
 
 void kvmppc_core_free_memslot(struct kvm *kvm, struct kvm_memory_slot *free,
 			      struct kvm_memory_slot *dont)
 {
-	kvmppc_ops->free_memslot(free, dont);
+	kvm->arch.kvm_ops->free_memslot(free, dont);
 }
 
 int kvmppc_core_create_memslot(struct kvm *kvm, struct kvm_memory_slot *slot,
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
@@ -831,12 +832,12 @@ int kvmppc_core_init_vm(struct kvm *kvm)
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
@@ -846,5 +847,35 @@ void kvmppc_core_destroy_vm(struct kvm *kvm)
 
 int kvmppc_core_check_processor_compat(void)
 {
-	return kvmppc_ops->check_processor_compat();
+	/*
+	 * We always return 0 for book3s. We check
+	 * for compatability while loading the HV
+	 * or PR module
+	 */
+	return 0;
+}
+
+static int kvmppc_book3s_init(void)
+{
+	int r;
+
+	r = kvm_init(NULL, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
+	if (r)
+		return r;
+#ifdef CONFIG_KVM_BOOK3S_32
+	r = kvmppc_book3s_init_pr();
+#endif
+	return r;
+
+}
+
+static void kvmppc_book3s_exit(void)
+{
+#ifdef CONFIG_KVM_BOOK3S_32
+	kvmppc_book3s_exit_pr();
+#endif
+	kvm_exit();
 }
+
+module_init(kvmppc_book3s_init);
+module_exit(kvmppc_book3s_exit);
diff --git a/arch/powerpc/kvm/book3s.h b/arch/powerpc/kvm/book3s.h
index 9e5b3a3..4bf956c 100644
--- a/arch/powerpc/kvm/book3s.h
+++ b/arch/powerpc/kvm/book3s.h
@@ -28,5 +28,7 @@ extern int kvmppc_core_emulate_mtspr_pr(struct kvm_vcpu *vcpu,
 					int sprn, ulong spr_val);
 extern int kvmppc_core_emulate_mfspr_pr(struct kvm_vcpu *vcpu,
 					int sprn, ulong *spr_val);
+extern int kvmppc_book3s_init_pr(void);
+extern void kvmppc_book3s_exit_pr(void);
 
 #endif
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 47fca8c..31922d5 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2159,7 +2159,7 @@ static long kvm_arch_vm_ioctl_hv(struct file *filp,
 	return r;
 }
 
-static struct kvmppc_ops kvmppc_hv_ops = {
+static struct kvmppc_ops kvm_ops_hv = {
 	.is_hv_enabled = true,
 	.get_sregs = kvm_arch_vcpu_ioctl_get_sregs_hv,
 	.set_sregs = kvm_arch_vcpu_ioctl_set_sregs_hv,
@@ -2186,7 +2186,6 @@ static struct kvmppc_ops kvmppc_hv_ops = {
 	.create_memslot = kvmppc_core_create_memslot_hv,
 	.init_vm =  kvmppc_core_init_vm_hv,
 	.destroy_vm = kvmppc_core_destroy_vm_hv,
-	.check_processor_compat = kvmppc_core_check_processor_compat_hv,
 	.get_smmu_info = kvm_vm_ioctl_get_smmu_info_hv,
 	.emulate_op = kvmppc_core_emulate_op_hv,
 	.emulate_mtspr = kvmppc_core_emulate_mtspr_hv,
@@ -2198,20 +2197,23 @@ static struct kvmppc_ops kvmppc_hv_ops = {
 static int kvmppc_book3s_init_hv(void)
 {
 	int r;
-
-	r = kvm_init(&kvmppc_hv_ops, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
-
-	if (r)
+	/*
+	 * FIXME!! Do we need to check on all cpus ?
+	 */
+	r = kvmppc_core_check_processor_compat_hv();
+	if (r < 0)
 		return r;
 
-	r = kvmppc_mmu_hv_init();
+	kvm_ops_hv.owner = THIS_MODULE;
+	kvmppc_hv_ops = &kvm_ops_hv;
 
+	r = kvmppc_mmu_hv_init();
 	return r;
 }
 
 static void kvmppc_book3s_exit_hv(void)
 {
-	kvm_exit();
+	kvmppc_hv_ops = NULL;
 }
 
 module_init(kvmppc_book3s_init_hv);
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 7f583a4..fbd985f 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -1525,7 +1525,7 @@ static long kvm_arch_vm_ioctl_pr(struct file *filp,
 	return -ENOTTY;
 }
 
-static struct kvmppc_ops kvmppc_pr_ops = {
+static struct kvmppc_ops kvm_ops_pr = {
 	.is_hv_enabled = false,
 	.get_sregs = kvm_arch_vcpu_ioctl_get_sregs_pr,
 	.set_sregs = kvm_arch_vcpu_ioctl_set_sregs_pr,
@@ -1552,7 +1552,6 @@ static struct kvmppc_ops kvmppc_pr_ops = {
 	.create_memslot = kvmppc_core_create_memslot_pr,
 	.init_vm = kvmppc_core_init_vm_pr,
 	.destroy_vm = kvmppc_core_destroy_vm_pr,
-	.check_processor_compat = kvmppc_core_check_processor_compat_pr,
 	.get_smmu_info = kvm_vm_ioctl_get_smmu_info_pr,
 	.emulate_op = kvmppc_core_emulate_op_pr,
 	.emulate_mtspr = kvmppc_core_emulate_mtspr_pr,
@@ -1561,27 +1560,35 @@ static struct kvmppc_ops kvmppc_pr_ops = {
 	.arch_vm_ioctl  = kvm_arch_vm_ioctl_pr,
 };
 
-static int kvmppc_book3s_init_pr(void)
+
+int kvmppc_book3s_init_pr(void)
 {
 	int r;
 
-	r = kvm_init(&kvmppc_pr_ops, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
-
-	if (r)
+	r = kvmppc_core_check_processor_compat_pr();
+	if (r < 0)
 		return r;
 
-	r = kvmppc_mmu_hpte_sysinit();
+	kvm_ops_pr.owner = THIS_MODULE;
+	kvmppc_pr_ops = &kvm_ops_pr;
 
+	r = kvmppc_mmu_hpte_sysinit();
 	return r;
 }
 
-static void kvmppc_book3s_exit_pr(void)
+void kvmppc_book3s_exit_pr(void)
 {
+	kvmppc_pr_ops = NULL;
 	kvmppc_mmu_hpte_sysexit();
-	kvm_exit();
 }
 
+/*
+ * We only support separate modules for book3s 64
+ */
+#ifdef CONFIG_PPC_BOOK3S_64
+
 module_init(kvmppc_book3s_init_pr);
 module_exit(kvmppc_book3s_exit_pr);
 
 MODULE_LICENSE("GPL");
+#endif
diff --git a/arch/powerpc/kvm/book3s_xics.c b/arch/powerpc/kvm/book3s_xics.c
index cef3de9..76ef525 100644
--- a/arch/powerpc/kvm/book3s_xics.c
+++ b/arch/powerpc/kvm/book3s_xics.c
@@ -818,7 +818,7 @@ int kvmppc_xics_hcall(struct kvm_vcpu *vcpu, u32 req)
 	}
 
 	/* Check for real mode returning too hard */
-	if (xics->real_mode && kvmppc_ops->is_hv_enabled)
+	if (xics->real_mode && vcpu->kvm->arch.kvm_ops->is_hv_enabled)
 		return kvmppc_xics_rm_complete(vcpu, req);
 
 	switch (req) {
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index cb2d986..15d0149 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1472,7 +1472,7 @@ int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 
 	get_sregs_base(vcpu, sregs);
 	get_sregs_arch206(vcpu, sregs);
-	return kvmppc_ops->get_sregs(vcpu, sregs);
+	return vcpu->kvm->arch.kvm_ops->get_sregs(vcpu, sregs);
 }
 
 int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
@@ -1491,7 +1491,7 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 	if (ret < 0)
 		return ret;
 
-	return kvmppc_ops->set_sregs(vcpu, sregs);
+	return vcpu->kvm->arch.kvm_ops->set_sregs(vcpu, sregs);
 }
 
 int kvm_vcpu_ioctl_get_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
@@ -1548,7 +1548,7 @@ int kvm_vcpu_ioctl_get_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 		val = get_reg_val(reg->id, vcpu->arch.vrsave);
 		break;
 	default:
-		r = kvmppc_ops->get_one_reg(vcpu, reg->id, &val);
+		r = vcpu->kvm->arch.kvm_ops->get_one_reg(vcpu, reg->id, &val);
 		break;
 	}
 
@@ -1631,7 +1631,7 @@ int kvm_vcpu_ioctl_set_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 		vcpu->arch.vrsave = set_reg_val(reg->id, val);
 		break;
 	default:
-		r = kvmppc_ops->set_one_reg(vcpu, reg->id, &val);
+		r = vcpu->kvm->arch.kvm_ops->set_one_reg(vcpu, reg->id, &val);
 		break;
 	}
 
@@ -1911,37 +1911,37 @@ void kvmppc_booke_vcpu_put(struct kvm_vcpu *vcpu)
 
 void kvmppc_mmu_destroy(struct kvm_vcpu *vcpu)
 {
-	kvmppc_ops->mmu_destroy(vcpu);
+	vcpu->kvm->arch.kvm_ops->mmu_destroy(vcpu);
 }
 
 int kvmppc_core_init_vm(struct kvm *kvm)
 {
-	return kvmppc_ops->init_vm(kvm);
+	return kvm->arch.kvm_ops->init_vm(kvm);
 }
 
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
 
 void kvmppc_core_destroy_vm(struct kvm *kvm)
 {
-	kvmppc_ops->destroy_vm(kvm);
+	kvm->arch.kvm_ops->destroy_vm(kvm);
 }
 
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
 
 int __init kvmppc_booke_init(void)
diff --git a/arch/powerpc/kvm/e500.c b/arch/powerpc/kvm/e500.c
index d225d5e..497b142 100644
--- a/arch/powerpc/kvm/e500.c
+++ b/arch/powerpc/kvm/e500.c
@@ -555,13 +555,19 @@ static int __init kvmppc_e500_init(void)
 	flush_icache_range(kvmppc_booke_handlers, kvmppc_booke_handlers +
 			   ivor[max_ivor] + handler_len);
 
-	r = kvm_init(&kvm_ops_e500, sizeof(struct kvmppc_vcpu_e500), 0, THIS_MODULE);
+	r = kvm_init(NULL, sizeof(struct kvmppc_vcpu_e500), 0, THIS_MODULE);
+	if (r)
+		goto err_out;
+	kvm_ops_e500.owner = THIS_MODULE;
+	kvmppc_pr_ops = &kvm_ops_e500;
+
 err_out:
 	return r;
 }
 
 static void __exit kvmppc_e500_exit(void)
 {
+	kvmppc_pr_ops = NULL;
 	kvmppc_booke_exit();
 }
 
diff --git a/arch/powerpc/kvm/e500mc.c b/arch/powerpc/kvm/e500mc.c
index db6a383..4132cd2 100644
--- a/arch/powerpc/kvm/e500mc.c
+++ b/arch/powerpc/kvm/e500mc.c
@@ -373,15 +373,19 @@ static int __init kvmppc_e500mc_init(void)
 	kvmppc_init_lpid(64);
 	kvmppc_claim_lpid(0); /* host */
 
-	r = kvm_init(&kvm_ops_e500mc, sizeof(struct kvmppc_vcpu_e500), 0, THIS_MODULE);
+	r = kvm_init(NULL, sizeof(struct kvmppc_vcpu_e500), 0, THIS_MODULE);
 	if (r)
 		goto err_out;
+	kvm_ops_e500mc.owner = THIS_MODULE;
+	kvmppc_pr_ops = &kvm_ops_e500mc;
+
 err_out:
 	return r;
 }
 
 static void __exit kvmppc_e500mc_exit(void)
 {
+	kvmppc_pr_ops = NULL;
 	kvmppc_booke_exit();
 }
 
diff --git a/arch/powerpc/kvm/emulate.c b/arch/powerpc/kvm/emulate.c
index 230b4e9..ced1810 100644
--- a/arch/powerpc/kvm/emulate.c
+++ b/arch/powerpc/kvm/emulate.c
@@ -173,8 +173,8 @@ static int kvmppc_emulate_mtspr(struct kvm_vcpu *vcpu, int sprn, int rs)
 	case SPRN_PIR: break;
 
 	default:
-		emulated = kvmppc_ops->emulate_mtspr(vcpu, sprn,
-						     spr_val);
+		emulated = vcpu->kvm->arch.kvm_ops->emulate_mtspr(vcpu, sprn,
+								  spr_val);
 		if (emulated == EMULATE_FAIL)
 			printk(KERN_INFO "mtspr: unknown spr "
 				"0x%x\n", sprn);
@@ -234,8 +234,8 @@ static int kvmppc_emulate_mfspr(struct kvm_vcpu *vcpu, int sprn, int rt)
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
@@ -507,7 +507,8 @@ int kvmppc_emulate_instruction(struct kvm_run *run, struct kvm_vcpu *vcpu)
 	}
 
 	if (emulated == EMULATE_FAIL) {
-		emulated = kvmppc_ops->emulate_op(run, vcpu, inst, &advance);
+		emulated = vcpu->kvm->arch.kvm_ops->emulate_op(run, vcpu, inst,
+							       &advance);
 		if (emulated == EMULATE_AGAIN) {
 			advance = 0;
 		} else if (emulated == EMULATE_FAIL) {
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index db48a7f..00a995a 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -26,6 +26,7 @@
 #include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/file.h>
+#include <linux/module.h>
 #include <asm/cputable.h>
 #include <asm/uaccess.h>
 #include <asm/kvm_ppc.h>
@@ -39,7 +40,11 @@
 #define CREATE_TRACE_POINTS
 #include "trace.h"
 
-struct kvmppc_ops *kvmppc_ops;
+struct kvmppc_ops *kvmppc_hv_ops;
+EXPORT_SYMBOL_GPL(kvmppc_hv_ops);
+struct kvmppc_ops *kvmppc_pr_ops;
+EXPORT_SYMBOL_GPL(kvmppc_pr_ops);
+
 
 int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
 {
@@ -195,7 +200,7 @@ int kvmppc_sanity_check(struct kvm_vcpu *vcpu)
 		goto out;
 
 	/* HV KVM can only do PAPR mode for now */
-	if (!vcpu->arch.papr_enabled && kvmppc_ops->is_hv_enabled)
+	if (!vcpu->arch.papr_enabled && vcpu->kvm->arch.kvm_ops->is_hv_enabled)
 		goto out;
 
 #ifdef CONFIG_KVM_BOOKE_HV
@@ -271,10 +276,35 @@ void kvm_arch_check_processor_compat(void *rtn)
 
 int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 {
-	if (type)
-		return -EINVAL;
-
+	struct kvmppc_ops *kvm_ops = NULL;
+	/*
+	 * if we have both HV and PR enabled, default is HV
+	 */
+	if (type == 0) {
+		if (kvmppc_hv_ops)
+			kvm_ops = kvmppc_hv_ops;
+		else
+			kvm_ops = kvmppc_pr_ops;
+		if (!kvm_ops)
+			goto err_out;
+	} else	if (type == KVM_VM_PPC_HV) {
+		if (!kvmppc_hv_ops)
+			goto err_out;
+		kvm_ops = kvmppc_hv_ops;
+	} else if (type == KVM_VM_PPC_PR) {
+		if (!kvmppc_pr_ops)
+			goto err_out;
+		kvm_ops = kvmppc_pr_ops;
+	} else
+		goto err_out;
+
+	if (kvm_ops->owner && !try_module_get(kvm_ops->owner))
+		return -ENOENT;
+
+	kvm->arch.kvm_ops = kvm_ops;
 	return kvmppc_core_init_vm(kvm);
+err_out:
+	return -EINVAL;
 }
 
 void kvm_arch_destroy_vm(struct kvm *kvm)
@@ -294,6 +324,9 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	kvmppc_core_destroy_vm(kvm);
 
 	mutex_unlock(&kvm->lock);
+
+	/* drop the module reference */
+	module_put(kvm->arch.kvm_ops->owner);
 }
 
 void kvm_arch_sync_events(struct kvm *kvm)
@@ -303,6 +336,10 @@ void kvm_arch_sync_events(struct kvm *kvm)
 int kvm_dev_ioctl_check_extension(long ext)
 {
 	int r;
+	/* FIXME!!
+	 * Should some of this be vm ioctl ? is it possible now ?
+	 */
+	int hv_enabled = kvmppc_hv_ops ? 1: 0;
 
 	switch (ext) {
 #ifdef CONFIG_BOOKE
@@ -329,7 +366,7 @@ int kvm_dev_ioctl_check_extension(long ext)
 	case KVM_CAP_SW_TLB:
 #endif
 		/* We support this only for PR */
-		r = !kvmppc_ops->is_hv_enabled;
+		r = !hv_enabled;
 		break;
 #ifdef CONFIG_KVM_MMIO
 	case KVM_CAP_COALESCED_MMIO:
@@ -354,13 +391,13 @@ int kvm_dev_ioctl_check_extension(long ext)
 #endif /* CONFIG_PPC_BOOK3S_64 */
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
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
@@ -368,7 +405,7 @@ int kvm_dev_ioctl_check_extension(long ext)
 #endif
 	case KVM_CAP_SYNC_MMU:
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
-		if (kvmppc_ops->is_hv_enabled)
+		if (hv_enabled)
 			r = cpu_has_feature(CPU_FTR_ARCH_206) ? 1 : 0;
 		else
 			r = 0;
@@ -380,7 +417,7 @@ int kvm_dev_ioctl_check_extension(long ext)
 		break;
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 	case KVM_CAP_PPC_HTAB_FD:
-		r = kvmppc_ops->is_hv_enabled;
+		r = hv_enabled;
 		break;
 #endif
 	case KVM_CAP_NR_VCPUS:
@@ -390,7 +427,7 @@ int kvm_dev_ioctl_check_extension(long ext)
 		 * will have secondary threads "offline"), and for other KVM
 		 * implementations just count online CPUs.
 		 */
-		if (kvmppc_ops->is_hv_enabled)
+		if (hv_enabled)
 			r = num_present_cpus();
 		else
 			r = num_online_cpus();
@@ -1039,9 +1076,10 @@ long kvm_arch_vm_ioctl(struct file *filp,
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
@@ -1052,9 +1090,10 @@ long kvm_arch_vm_ioctl(struct file *filp,
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
@@ -1104,15 +1143,10 @@ EXPORT_SYMBOL_GPL(kvmppc_init_lpid);
 
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
-- 
1.8.1.2
