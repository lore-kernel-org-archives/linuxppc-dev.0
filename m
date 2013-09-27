Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0D82A2C0334
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 20:04:13 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 27 Sep 2013 15:34:08 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 8228B125805E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 15:34:18 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8RA41jP44761258
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 15:34:01 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8RA43ju020144
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 15:34:03 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [RFC PATCH 05/11] kvm: powerpc: book3s: Add kvmppc_ops callback for
 HV and PR specific operations
Date: Fri, 27 Sep 2013 15:33:47 +0530
Message-Id: <1380276233-17095-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

This moves HV and PR specific functions to kvmppc_ops callback.
This is needed so that we can enable HV and PR together in the
same kernel. Actual changes to enable both come in the later
patch.This also renames almost all of the symbols that exist in both PR and HV
KVM for clarity. Symbols in the PR KVM implementation get "_pr"
appended, and those in the HV KVM implementation get "_hv".  Then,
in book3s.c, we add a function with the name without the suffix and
arrange for it to call the appropriate kvmppc_ops callback depending on
which kvm type we selected during VM creation.

NOTE: we still don't enable selecting both the HV and PR together
in this commit that will be done by a later commit.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_book3s.h |   5 +-
 arch/powerpc/include/asm/kvm_ppc.h    |  63 ++++++++--
 arch/powerpc/kvm/Kconfig              |  15 ++-
 arch/powerpc/kvm/Makefile             |   9 +-
 arch/powerpc/kvm/book3s.c             | 145 +++++++++++++++++++++-
 arch/powerpc/kvm/book3s_32_mmu_host.c |   2 +-
 arch/powerpc/kvm/book3s_64_mmu_host.c |   2 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c   |  17 ++-
 arch/powerpc/kvm/book3s_emulate.c     |   8 +-
 arch/powerpc/kvm/book3s_hv.c          | 226 +++++++++++++++++++++++++---------
 arch/powerpc/kvm/book3s_interrupts.S  |   2 +-
 arch/powerpc/kvm/book3s_pr.c          | 196 ++++++++++++++++++-----------
 arch/powerpc/kvm/emulate.c            |   6 +-
 arch/powerpc/kvm/powerpc.c            |  58 +++------
 14 files changed, 539 insertions(+), 215 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 1b32f6c..3efba3c 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -24,6 +24,8 @@
 #include <linux/kvm_host.h>
 #include <asm/kvm_book3s_asm.h>
 
+union kvmppc_one_reg;
+
 struct kvmppc_bat {
 	u64 raw;
 	u32 bepi;
@@ -124,7 +126,6 @@ extern void kvmppc_mmu_pte_flush(struct kvm_vcpu *vcpu, ulong ea, ulong ea_mask)
 extern void kvmppc_mmu_pte_vflush(struct kvm_vcpu *vcpu, u64 vp, u64 vp_mask);
 extern void kvmppc_mmu_pte_pflush(struct kvm_vcpu *vcpu, ulong pa_start, ulong pa_end);
 extern void kvmppc_set_msr(struct kvm_vcpu *vcpu, u64 new_msr);
-extern void kvmppc_set_pvr(struct kvm_vcpu *vcpu, u32 pvr);
 extern void kvmppc_mmu_book3s_64_init(struct kvm_vcpu *vcpu);
 extern void kvmppc_mmu_book3s_32_init(struct kvm_vcpu *vcpu);
 extern void kvmppc_mmu_book3s_hv_init(struct kvm_vcpu *vcpu);
@@ -193,8 +194,6 @@ static inline struct kvmppc_vcpu_book3s *to_book3s(struct kvm_vcpu *vcpu)
 	return vcpu->arch.book3s;
 }
 
-extern void kvm_return_point(void);
-
 /* Also add subarch specific defines */
 
 #ifdef CONFIG_KVM_BOOK3S_32_HANDLER
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 9161bd1..4d9641c 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -106,13 +106,6 @@ extern void kvmppc_core_queue_external(struct kvm_vcpu *vcpu,
                                        struct kvm_interrupt *irq);
 extern void kvmppc_core_dequeue_external(struct kvm_vcpu *vcpu);
 extern void kvmppc_core_flush_tlb(struct kvm_vcpu *vcpu);
-
-extern int kvmppc_core_emulate_op(struct kvm_run *run, struct kvm_vcpu *vcpu,
-                                  unsigned int op, int *advance);
-extern int kvmppc_core_emulate_mtspr(struct kvm_vcpu *vcpu, int sprn,
-				     ulong val);
-extern int kvmppc_core_emulate_mfspr(struct kvm_vcpu *vcpu, int sprn,
-				     ulong *val);
 extern int kvmppc_core_check_requests(struct kvm_vcpu *vcpu);
 
 extern int kvmppc_booke_init(void);
@@ -135,8 +128,6 @@ extern long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 				struct kvm_create_spapr_tce *args);
 extern long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 			     unsigned long ioba, unsigned long tce);
-extern long kvm_vm_ioctl_allocate_rma(struct kvm *kvm,
-				struct kvm_allocate_rma *rma);
 extern struct kvm_rma_info *kvm_alloc_rma(void);
 extern void kvm_release_rma(struct kvm_rma_info *ri);
 extern struct page *kvm_alloc_hpt(unsigned long nr_pages);
@@ -177,6 +168,55 @@ extern int kvmppc_xics_get_xive(struct kvm *kvm, u32 irq, u32 *server,
 extern int kvmppc_xics_int_on(struct kvm *kvm, u32 irq);
 extern int kvmppc_xics_int_off(struct kvm *kvm, u32 irq);
 
+struct kvmppc_ops {
+	int (*get_sregs)(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs);
+	int (*set_sregs)(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs);
+	int (*get_one_reg)(struct kvm_vcpu *vcpu, u64 id,
+			   union kvmppc_one_reg *val);
+	int (*set_one_reg)(struct kvm_vcpu *vcpu, u64 id,
+			   union kvmppc_one_reg *val);
+	void (*vcpu_load)(struct kvm_vcpu *vcpu, int cpu);
+	void (*vcpu_put)(struct kvm_vcpu *vcpu);
+	void (*set_msr)(struct kvm_vcpu *vcpu, u64 msr);
+	int (*vcpu_run)(struct kvm_run *run, struct kvm_vcpu *vcpu);
+	struct kvm_vcpu *(*vcpu_create)(struct kvm *kvm, unsigned int id);
+	void (*vcpu_free)(struct kvm_vcpu *vcpu);
+	int (*check_requests)(struct kvm_vcpu *vcpu);
+	int (*get_dirty_log)(struct kvm *kvm, struct kvm_dirty_log *log);
+	void (*flush_memslot)(struct kvm *kvm, struct kvm_memory_slot *memslot);
+	int (*prepare_memory_region)(struct kvm *kvm,
+				     struct kvm_memory_slot *memslot,
+				     struct kvm_userspace_memory_region *mem);
+	void (*commit_memory_region)(struct kvm *kvm,
+				     struct kvm_userspace_memory_region *mem,
+				     const struct kvm_memory_slot *old);
+	int (*unmap_hva)(struct kvm *kvm, unsigned long hva);
+	int (*unmap_hva_range)(struct kvm *kvm, unsigned long start,
+			   unsigned long end);
+	int (*age_hva)(struct kvm *kvm, unsigned long hva);
+	int (*test_age_hva)(struct kvm *kvm, unsigned long hva);
+	void (*set_spte_hva)(struct kvm *kvm, unsigned long hva, pte_t pte);
+	void (*mmu_destroy)(struct kvm_vcpu *vcpu);
+	void (*free_memslot)(struct kvm_memory_slot *free,
+			     struct kvm_memory_slot *dont);
+	int (*create_memslot)(struct kvm_memory_slot *slot,
+			      unsigned long npages);
+	int (*init_vm)(struct kvm *kvm);
+	void (*destroy_vm)(struct kvm *kvm);
+	int (*check_processor_compat)(void);
+	int (*get_smmu_info)(struct kvm *kvm, struct kvm_ppc_smmu_info *info);
+	int (*emulate_op)(struct kvm_run *run, struct kvm_vcpu *vcpu,
+			  unsigned int inst, int *advance);
+	int (*emulate_mtspr)(struct kvm_vcpu *vcpu, int sprn, ulong spr_val);
+	int (*emulate_mfspr)(struct kvm_vcpu *vcpu, int sprn, ulong *spr_val);
+	void (*fast_vcpu_kick)(struct kvm_vcpu *vcpu);
+	long (*arch_vm_ioctl)(struct file *filp, unsigned int ioctl,
+			      unsigned long arg);
+
+};
+
+extern struct kvmppc_ops *kvmppc_ops;
+
 /*
  * Cuts out inst bits with ordering according to spec.
  * That means the leftmost bit is zero. All given bits are included.
@@ -281,7 +321,10 @@ static inline void kvmppc_set_host_ipi(int cpu, u8 host_ipi)
 	paca[cpu].kvm_hstate.host_ipi = host_ipi;
 }
 
-extern void kvmppc_fast_vcpu_kick(struct kvm_vcpu *vcpu);
+static inline void kvmppc_fast_vcpu_kick(struct kvm_vcpu *vcpu)
+{
+	kvmppc_ops->fast_vcpu_kick(vcpu);
+}
 
 #else
 static inline void __init kvm_cma_reserve(void)
diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index 719c946..5c62459 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -62,6 +62,7 @@ config KVM_BOOK3S_64
 	depends on PPC_BOOK3S_64
 	select KVM_BOOK3S_64_HANDLER
 	select KVM
+	select KVM_BOOK3S_PR if !KVM_BOOK3S_HV
 	---help---
 	  Support running unmodified book3s_64 and book3s_32 guest kernels
 	  in virtual machines on book3s_64 host processors.
@@ -93,9 +94,21 @@ config KVM_BOOK3S_64_HV
 	  If unsure, say N.
 
 config KVM_BOOK3S_64_PR
-	def_bool y
+	bool "KVM support without using hypervisor mode in host"
 	depends on KVM_BOOK3S_64 && !KVM_BOOK3S_64_HV
 	select KVM_BOOK3S_PR
+	---help---
+	  Support running guest kernels in virtual machines on processors
+	  without using hypervisor mode in the host, by running the
+	  guest in user mode (problem state) and emulating all
+	  privileged instructions and registers.
+
+	  This is not as fast as using hypervisor mode, but works on
+	  machines where hypervisor mode is not available or not usable,
+	  and can emulate processors that are different from the host
+	  processor, including emulating 32-bit processors on a 64-bit
+	  host.
+
 
 config KVM_BOOKE_HV
 	bool
diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
index 104e8dc..c343793 100644
--- a/arch/powerpc/kvm/Makefile
+++ b/arch/powerpc/kvm/Makefile
@@ -69,8 +69,13 @@ kvm-book3s_64-objs-$(CONFIG_KVM_BOOK3S_64_PR) := \
 	book3s_64_mmu.o \
 	book3s_32_mmu.o
 
-kvm-book3s_64-builtin-objs-$(CONFIG_KVM_BOOK3S_64_PR) += \
+ifdef CONFIG_KVM_BOOK3S_PR
+kvm-book3s_64-module-objs := \
+	$(KVM)/coalesced_mmio.o
+
+kvm-book3s_64-builtin-objs-$(CONFIG_KVM_BOOK3S_64_HANDLER) += \
 	book3s_rmhandlers.o
+endif
 
 kvm-book3s_64-objs-$(CONFIG_KVM_BOOK3S_64_HV) := \
 	book3s_hv.o \
@@ -91,7 +96,7 @@ kvm-book3s_64-builtin-objs-$(CONFIG_KVM_BOOK3S_64_HV) += \
 kvm-book3s_64-objs-$(CONFIG_KVM_XICS) += \
 	book3s_xics.o
 
-kvm-book3s_64-module-objs := \
+kvm-book3s_64-module-objs += \
 	$(KVM)/kvm_main.o \
 	$(KVM)/eventfd.o \
 	powerpc.o \
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 700df6f..bdc3f95 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -419,6 +419,18 @@ void kvmppc_subarch_vcpu_uninit(struct kvm_vcpu *vcpu)
 {
 }
 
+int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
+				  struct kvm_sregs *sregs)
+{
+	return kvmppc_ops->get_sregs(vcpu, sregs);
+}
+
+int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
+				  struct kvm_sregs *sregs)
+{
+	return kvmppc_ops->set_sregs(vcpu, sregs);
+}
+
 int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
 	int i;
@@ -495,8 +507,7 @@ int kvm_vcpu_ioctl_get_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 	if (size > sizeof(val))
 		return -EINVAL;
 
-	r = kvmppc_get_one_reg(vcpu, reg->id, &val);
-
+	r = kvmppc_ops->get_one_reg(vcpu, reg->id, &val);
 	if (r == -EINVAL) {
 		r = 0;
 		switch (reg->id) {
@@ -572,8 +583,7 @@ int kvm_vcpu_ioctl_set_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 	if (copy_from_user(&val, (char __user *)(unsigned long)reg->addr, size))
 		return -EFAULT;
 
-	r = kvmppc_set_one_reg(vcpu, reg->id, &val);
-
+	r = kvmppc_ops->set_one_reg(vcpu, reg->id, &val);
 	if (r == -EINVAL) {
 		r = 0;
 		switch (reg->id) {
@@ -625,6 +635,26 @@ int kvm_vcpu_ioctl_set_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 	return r;
 }
 
+void kvmppc_core_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
+{
+	kvmppc_ops->vcpu_load(vcpu, cpu);
+}
+
+void kvmppc_core_vcpu_put(struct kvm_vcpu *vcpu)
+{
+	kvmppc_ops->vcpu_put(vcpu);
+}
+
+void kvmppc_set_msr(struct kvm_vcpu *vcpu, u64 msr)
+{
+	kvmppc_ops->set_msr(vcpu, msr);
+}
+
+int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
+{
+	return kvmppc_ops->vcpu_run(kvm_run, vcpu);
+}
+
 int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
                                   struct kvm_translation *tr)
 {
@@ -644,3 +674,110 @@ void kvmppc_decrementer_func(unsigned long data)
 	kvmppc_core_queue_dec(vcpu);
 	kvm_vcpu_kick(vcpu);
 }
+
+struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
+{
+	return kvmppc_ops->vcpu_create(kvm, id);
+}
+
+void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
+{
+	kvmppc_ops->vcpu_free(vcpu);
+}
+
+int kvmppc_core_check_requests(struct kvm_vcpu *vcpu)
+{
+	return kvmppc_ops->check_requests(vcpu);
+}
+
+int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
+{
+	return kvmppc_ops->get_dirty_log(kvm, log);
+}
+
+void kvmppc_core_free_memslot(struct kvm_memory_slot *free,
+			      struct kvm_memory_slot *dont)
+{
+	kvmppc_ops->free_memslot(free, dont);
+}
+
+int kvmppc_core_create_memslot(struct kvm_memory_slot *slot,
+			       unsigned long npages)
+{
+	return kvmppc_ops->create_memslot(slot, npages);
+}
+
+void kvmppc_core_flush_memslot(struct kvm *kvm, struct kvm_memory_slot *memslot)
+{
+	kvmppc_ops->flush_memslot(kvm, memslot);
+}
+
+int kvmppc_core_prepare_memory_region(struct kvm *kvm,
+				struct kvm_memory_slot *memslot,
+				struct kvm_userspace_memory_region *mem)
+{
+	return kvmppc_ops->prepare_memory_region(kvm, memslot, mem);
+}
+
+void kvmppc_core_commit_memory_region(struct kvm *kvm,
+				struct kvm_userspace_memory_region *mem,
+				const struct kvm_memory_slot *old)
+{
+	kvmppc_ops->commit_memory_region(kvm, mem, old);
+}
+
+int kvm_unmap_hva(struct kvm *kvm, unsigned long hva)
+{
+	return kvmppc_ops->unmap_hva(kvm, hva);
+}
+
+int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end)
+{
+	return kvmppc_ops->unmap_hva_range(kvm, start, end);
+}
+
+int kvm_age_hva(struct kvm *kvm, unsigned long hva)
+{
+	return kvmppc_ops->age_hva(kvm, hva);
+}
+
+int kvm_test_age_hva(struct kvm *kvm, unsigned long hva)
+{
+	return kvmppc_ops->test_age_hva(kvm, hva);
+}
+
+void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
+{
+	kvmppc_ops->set_spte_hva(kvm, hva, pte);
+}
+
+void kvmppc_mmu_destroy(struct kvm_vcpu *vcpu)
+{
+	kvmppc_ops->mmu_destroy(vcpu);
+}
+
+int kvmppc_core_init_vm(struct kvm *kvm)
+{
+
+#ifdef CONFIG_PPC64
+	INIT_LIST_HEAD(&kvm->arch.spapr_tce_tables);
+	INIT_LIST_HEAD(&kvm->arch.rtas_tokens);
+#endif
+
+	return kvmppc_ops->init_vm(kvm);
+}
+
+void kvmppc_core_destroy_vm(struct kvm *kvm)
+{
+	kvmppc_ops->destroy_vm(kvm);
+
+#ifdef CONFIG_PPC64
+	kvmppc_rtas_tokens_free(kvm);
+	WARN_ON(!list_empty(&kvm->arch.spapr_tce_tables));
+#endif
+}
+
+int kvmppc_core_check_processor_compat(void)
+{
+	return kvmppc_ops->check_processor_compat();
+}
diff --git a/arch/powerpc/kvm/book3s_32_mmu_host.c b/arch/powerpc/kvm/book3s_32_mmu_host.c
index 00e619b..c4361ef 100644
--- a/arch/powerpc/kvm/book3s_32_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_32_mmu_host.c
@@ -341,7 +341,7 @@ void kvmppc_mmu_flush_segments(struct kvm_vcpu *vcpu)
 	svcpu_put(svcpu);
 }
 
-void kvmppc_mmu_destroy(struct kvm_vcpu *vcpu)
+void kvmppc_mmu_destroy_pr(struct kvm_vcpu *vcpu)
 {
 	int i;
 
diff --git a/arch/powerpc/kvm/book3s_64_mmu_host.c b/arch/powerpc/kvm/book3s_64_mmu_host.c
index 6bda504..329a978 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
@@ -341,7 +341,7 @@ void kvmppc_mmu_flush_segments(struct kvm_vcpu *vcpu)
 	svcpu_put(svcpu);
 }
 
-void kvmppc_mmu_destroy(struct kvm_vcpu *vcpu)
+void kvmppc_mmu_destroy_pr(struct kvm_vcpu *vcpu)
 {
 	kvmppc_mmu_hpte_destroy(vcpu);
 	__destroy_context(to_book3s(vcpu)->context_id[0]);
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 043eec8..6f0485f 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -260,10 +260,6 @@ int kvmppc_mmu_hv_init(void)
 	return 0;
 }
 
-void kvmppc_mmu_destroy(struct kvm_vcpu *vcpu)
-{
-}
-
 static void kvmppc_mmu_book3s_64_hv_reset_msr(struct kvm_vcpu *vcpu)
 {
 	kvmppc_set_msr(vcpu, MSR_SF | MSR_ME);
@@ -906,21 +902,22 @@ static int kvm_unmap_rmapp(struct kvm *kvm, unsigned long *rmapp,
 	return 0;
 }
 
-int kvm_unmap_hva(struct kvm *kvm, unsigned long hva)
+int kvm_unmap_hva_hv(struct kvm *kvm, unsigned long hva)
 {
 	if (kvm->arch.using_mmu_notifiers)
 		kvm_handle_hva(kvm, hva, kvm_unmap_rmapp);
 	return 0;
 }
 
-int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end)
+int kvm_unmap_hva_range_hv(struct kvm *kvm, unsigned long start, unsigned long end)
 {
 	if (kvm->arch.using_mmu_notifiers)
 		kvm_handle_hva_range(kvm, start, end, kvm_unmap_rmapp);
 	return 0;
 }
 
-void kvmppc_core_flush_memslot(struct kvm *kvm, struct kvm_memory_slot *memslot)
+void kvmppc_core_flush_memslot_hv(struct kvm *kvm,
+				  struct kvm_memory_slot *memslot)
 {
 	unsigned long *rmapp;
 	unsigned long gfn;
@@ -994,7 +991,7 @@ static int kvm_age_rmapp(struct kvm *kvm, unsigned long *rmapp,
 	return ret;
 }
 
-int kvm_age_hva(struct kvm *kvm, unsigned long hva)
+int kvm_age_hva_hv(struct kvm *kvm, unsigned long hva)
 {
 	if (!kvm->arch.using_mmu_notifiers)
 		return 0;
@@ -1032,14 +1029,14 @@ static int kvm_test_age_rmapp(struct kvm *kvm, unsigned long *rmapp,
 	return ret;
 }
 
-int kvm_test_age_hva(struct kvm *kvm, unsigned long hva)
+int kvm_test_age_hva_hv(struct kvm *kvm, unsigned long hva)
 {
 	if (!kvm->arch.using_mmu_notifiers)
 		return 0;
 	return kvm_handle_hva(kvm, hva, kvm_test_age_rmapp);
 }
 
-void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
+void kvm_set_spte_hva_hv(struct kvm *kvm, unsigned long hva, pte_t pte)
 {
 	if (!kvm->arch.using_mmu_notifiers)
 		return;
diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index 34044b1..b9841ad 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -86,8 +86,8 @@ static bool spr_allowed(struct kvm_vcpu *vcpu, enum priv_level level)
 	return true;
 }
 
-int kvmppc_core_emulate_op(struct kvm_run *run, struct kvm_vcpu *vcpu,
-                           unsigned int inst, int *advance)
+int kvmppc_core_emulate_op_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
+			      unsigned int inst, int *advance)
 {
 	int emulated = EMULATE_DONE;
 	int rt = get_rt(inst);
@@ -345,7 +345,7 @@ static struct kvmppc_bat *kvmppc_find_bat(struct kvm_vcpu *vcpu, int sprn)
 	return bat;
 }
 
-int kvmppc_core_emulate_mtspr(struct kvm_vcpu *vcpu, int sprn, ulong spr_val)
+int kvmppc_core_emulate_mtspr_pr(struct kvm_vcpu *vcpu, int sprn, ulong spr_val)
 {
 	int emulated = EMULATE_DONE;
 
@@ -468,7 +468,7 @@ unprivileged:
 	return emulated;
 }
 
-int kvmppc_core_emulate_mfspr(struct kvm_vcpu *vcpu, int sprn, ulong *spr_val)
+int kvmppc_core_emulate_mfspr_pr(struct kvm_vcpu *vcpu, int sprn, ulong *spr_val)
 {
 	int emulated = EMULATE_DONE;
 
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index edc7f9f..36d7920 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -66,7 +66,7 @@
 static void kvmppc_end_cede(struct kvm_vcpu *vcpu);
 static int kvmppc_hv_setup_htab_rma(struct kvm_vcpu *vcpu);
 
-void kvmppc_fast_vcpu_kick(struct kvm_vcpu *vcpu)
+static void kvmppc_fast_vcpu_kick_hv(struct kvm_vcpu *vcpu)
 {
 	int me;
 	int cpu = vcpu->cpu;
@@ -125,7 +125,7 @@ void kvmppc_fast_vcpu_kick(struct kvm_vcpu *vcpu)
  * purely defensive; they should never fail.)
  */
 
-void kvmppc_core_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
+static void kvmppc_core_vcpu_load_hv(struct kvm_vcpu *vcpu, int cpu)
 {
 	struct kvmppc_vcore *vc = vcpu->arch.vcore;
 
@@ -143,7 +143,7 @@ void kvmppc_core_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	spin_unlock(&vcpu->arch.tbacct_lock);
 }
 
-void kvmppc_core_vcpu_put(struct kvm_vcpu *vcpu)
+static void kvmppc_core_vcpu_put_hv(struct kvm_vcpu *vcpu)
 {
 	struct kvmppc_vcore *vc = vcpu->arch.vcore;
 
@@ -155,13 +155,13 @@ void kvmppc_core_vcpu_put(struct kvm_vcpu *vcpu)
 	spin_unlock(&vcpu->arch.tbacct_lock);
 }
 
-void kvmppc_set_msr(struct kvm_vcpu *vcpu, u64 msr)
+static void kvmppc_set_msr_hv(struct kvm_vcpu *vcpu, u64 msr)
 {
 	vcpu->arch.shregs.msr = msr;
 	kvmppc_end_cede(vcpu);
 }
 
-void kvmppc_set_pvr(struct kvm_vcpu *vcpu, u32 pvr)
+void kvmppc_set_pvr_hv(struct kvm_vcpu *vcpu, u32 pvr)
 {
 	vcpu->arch.pvr = pvr;
 }
@@ -576,8 +576,8 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 	return RESUME_GUEST;
 }
 
-static int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
-			      struct task_struct *tsk)
+static int kvmppc_handle_exit_hv(struct kvm_run *run, struct kvm_vcpu *vcpu,
+				 struct task_struct *tsk)
 {
 	int r = RESUME_HOST;
 
@@ -679,8 +679,8 @@ static int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	return r;
 }
 
-int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
-				  struct kvm_sregs *sregs)
+static int kvm_arch_vcpu_ioctl_get_sregs_hv(struct kvm_vcpu *vcpu,
+					    struct kvm_sregs *sregs)
 {
 	int i;
 
@@ -694,12 +694,12 @@ int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
-int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
-				  struct kvm_sregs *sregs)
+static int kvm_arch_vcpu_ioctl_set_sregs_hv(struct kvm_vcpu *vcpu,
+					    struct kvm_sregs *sregs)
 {
 	int i, j;
 
-	kvmppc_set_pvr(vcpu, sregs->pvr);
+	kvmppc_set_pvr_hv(vcpu, sregs->pvr);
 
 	j = 0;
 	for (i = 0; i < vcpu->arch.slb_nr; i++) {
@@ -714,7 +714,8 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
-int kvmppc_get_one_reg(struct kvm_vcpu *vcpu, u64 id, union kvmppc_one_reg *val)
+static int kvmppc_get_one_reg_hv(struct kvm_vcpu *vcpu, u64 id,
+				 union kvmppc_one_reg *val)
 {
 	int r = 0;
 	long int i;
@@ -795,7 +796,8 @@ int kvmppc_get_one_reg(struct kvm_vcpu *vcpu, u64 id, union kvmppc_one_reg *val)
 	return r;
 }
 
-int kvmppc_set_one_reg(struct kvm_vcpu *vcpu, u64 id, union kvmppc_one_reg *val)
+static int kvmppc_set_one_reg_hv(struct kvm_vcpu *vcpu, u64 id,
+				 union kvmppc_one_reg *val)
 {
 	int r = 0;
 	long int i;
@@ -888,14 +890,8 @@ int kvmppc_set_one_reg(struct kvm_vcpu *vcpu, u64 id, union kvmppc_one_reg *val)
 	return r;
 }
 
-int kvmppc_core_check_processor_compat(void)
-{
-	if (cpu_has_feature(CPU_FTR_HVMODE))
-		return 0;
-	return -EIO;
-}
-
-struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
+static struct kvm_vcpu *kvmppc_core_vcpu_create_hv(struct kvm *kvm,
+						   unsigned int id)
 {
 	struct kvm_vcpu *vcpu;
 	int err = -EINVAL;
@@ -920,7 +916,6 @@ struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
 	vcpu->arch.ctrl = CTRL_RUNLATCH;
 	/* default to host PVR, since we can't spoof it */
 	vcpu->arch.pvr = mfspr(SPRN_PVR);
-	kvmppc_set_pvr(vcpu, vcpu->arch.pvr);
 	spin_lock_init(&vcpu->arch.vpa_update_lock);
 	spin_lock_init(&vcpu->arch.tbacct_lock);
 	vcpu->arch.busy_preempt = TB_NIL;
@@ -972,7 +967,7 @@ static void unpin_vpa(struct kvm *kvm, struct kvmppc_vpa *vpa)
 					vpa->dirty);
 }
 
-void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
+static void kvmppc_core_vcpu_free_hv(struct kvm_vcpu *vcpu)
 {
 	spin_lock(&vcpu->arch.vpa_update_lock);
 	unpin_vpa(vcpu->kvm, &vcpu->arch.dtl);
@@ -983,6 +978,12 @@ void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
 	kmem_cache_free(kvm_vcpu_cache, vcpu);
 }
 
+static int kvmppc_core_check_requests_hv(struct kvm_vcpu *vcpu)
+{
+	/* Indicate we want to get back into the guest */
+	return 1;
+}
+
 static void kvmppc_set_timer(struct kvm_vcpu *vcpu)
 {
 	unsigned long dec_nsec, now;
@@ -1264,8 +1265,8 @@ static void kvmppc_run_core(struct kvmppc_vcore *vc)
 
 		ret = RESUME_GUEST;
 		if (vcpu->arch.trap)
-			ret = kvmppc_handle_exit(vcpu->arch.kvm_run, vcpu,
-						 vcpu->arch.run_task);
+			ret = kvmppc_handle_exit_hv(vcpu->arch.kvm_run, vcpu,
+						    vcpu->arch.run_task);
 
 		vcpu->arch.ret = ret;
 		vcpu->arch.trap = 0;
@@ -1424,7 +1425,7 @@ static int kvmppc_run_vcpu(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 	return vcpu->arch.ret;
 }
 
-int kvmppc_vcpu_run(struct kvm_run *run, struct kvm_vcpu *vcpu)
+static int kvmppc_vcpu_run_hv(struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
 	int r;
 	int srcu_idx;
@@ -1546,7 +1547,8 @@ static const struct file_operations kvm_rma_fops = {
 	.release	= kvm_rma_release,
 };
 
-long kvm_vm_ioctl_allocate_rma(struct kvm *kvm, struct kvm_allocate_rma *ret)
+static long kvm_vm_ioctl_allocate_rma(struct kvm *kvm,
+				      struct kvm_allocate_rma *ret)
 {
 	long fd;
 	struct kvm_rma_info *ri;
@@ -1592,7 +1594,8 @@ static void kvmppc_add_seg_page_size(struct kvm_ppc_one_seg_page_size **sps,
 	(*sps)++;
 }
 
-int kvm_vm_ioctl_get_smmu_info(struct kvm *kvm, struct kvm_ppc_smmu_info *info)
+static int kvm_vm_ioctl_get_smmu_info_hv(struct kvm *kvm,
+					 struct kvm_ppc_smmu_info *info)
 {
 	struct kvm_ppc_one_seg_page_size *sps;
 
@@ -1613,7 +1616,8 @@ int kvm_vm_ioctl_get_smmu_info(struct kvm *kvm, struct kvm_ppc_smmu_info *info)
 /*
  * Get (and clear) the dirty memory log for a memory slot.
  */
-int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
+static int kvm_vm_ioctl_get_dirty_log_hv(struct kvm *kvm,
+					 struct kvm_dirty_log *log)
 {
 	struct kvm_memory_slot *memslot;
 	int r;
@@ -1667,8 +1671,8 @@ static void unpin_slot(struct kvm_memory_slot *memslot)
 	}
 }
 
-void kvmppc_core_free_memslot(struct kvm_memory_slot *free,
-			      struct kvm_memory_slot *dont)
+static void kvmppc_core_free_memslot_hv(struct kvm_memory_slot *free,
+					struct kvm_memory_slot *dont)
 {
 	if (!dont || free->arch.rmap != dont->arch.rmap) {
 		vfree(free->arch.rmap);
@@ -1681,8 +1685,8 @@ void kvmppc_core_free_memslot(struct kvm_memory_slot *free,
 	}
 }
 
-int kvmppc_core_create_memslot(struct kvm_memory_slot *slot,
-			       unsigned long npages)
+static int kvmppc_core_create_memslot_hv(struct kvm_memory_slot *slot,
+					 unsigned long npages)
 {
 	slot->arch.rmap = vzalloc(npages * sizeof(*slot->arch.rmap));
 	if (!slot->arch.rmap)
@@ -1692,9 +1696,9 @@ int kvmppc_core_create_memslot(struct kvm_memory_slot *slot,
 	return 0;
 }
 
-int kvmppc_core_prepare_memory_region(struct kvm *kvm,
-				      struct kvm_memory_slot *memslot,
-				      struct kvm_userspace_memory_region *mem)
+static int kvmppc_core_prepare_memory_region_hv(struct kvm *kvm,
+					struct kvm_memory_slot *memslot,
+					struct kvm_userspace_memory_region *mem)
 {
 	unsigned long *phys;
 
@@ -1710,9 +1714,9 @@ int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 	return 0;
 }
 
-void kvmppc_core_commit_memory_region(struct kvm *kvm,
-				      struct kvm_userspace_memory_region *mem,
-				      const struct kvm_memory_slot *old)
+static void kvmppc_core_commit_memory_region_hv(struct kvm *kvm,
+				struct kvm_userspace_memory_region *mem,
+				const struct kvm_memory_slot *old)
 {
 	unsigned long npages = mem->memory_size >> PAGE_SHIFT;
 	struct kvm_memory_slot *memslot;
@@ -1729,6 +1733,11 @@ void kvmppc_core_commit_memory_region(struct kvm *kvm,
 	}
 }
 
+static void kvmppc_mmu_destroy_hv(struct kvm_vcpu *vcpu)
+{
+	return;
+}
+
 static int kvmppc_hv_setup_htab_rma(struct kvm_vcpu *vcpu)
 {
 	int err = 0;
@@ -1875,7 +1884,7 @@ static int kvmppc_hv_setup_htab_rma(struct kvm_vcpu *vcpu)
 	goto out_srcu;
 }
 
-int kvmppc_core_init_vm(struct kvm *kvm)
+static int kvmppc_core_init_vm_hv(struct kvm *kvm)
 {
 	unsigned long lpcr, lpid;
 
@@ -1893,9 +1902,6 @@ int kvmppc_core_init_vm(struct kvm *kvm)
 	 */
 	cpumask_setall(&kvm->arch.need_tlb_flush);
 
-	INIT_LIST_HEAD(&kvm->arch.spapr_tce_tables);
-	INIT_LIST_HEAD(&kvm->arch.rtas_tokens);
-
 	kvm->arch.rma = NULL;
 
 	kvm->arch.host_sdr1 = mfspr(SPRN_SDR1);
@@ -1940,7 +1946,7 @@ static void kvmppc_free_vcores(struct kvm *kvm)
 	kvm->arch.online_vcores = 0;
 }
 
-void kvmppc_core_destroy_vm(struct kvm *kvm)
+static void kvmppc_core_destroy_vm_hv(struct kvm *kvm)
 {
 	uninhibit_secondary_onlining();
 
@@ -1950,39 +1956,137 @@ void kvmppc_core_destroy_vm(struct kvm *kvm)
 		kvm->arch.rma = NULL;
 	}
 
-	kvmppc_rtas_tokens_free(kvm);
-
 	kvmppc_free_hpt(kvm);
-	WARN_ON(!list_empty(&kvm->arch.spapr_tce_tables));
 }
 
-/* These are stubs for now */
-void kvmppc_mmu_pte_pflush(struct kvm_vcpu *vcpu, ulong pa_start, ulong pa_end)
+/* We don't need to emulate any privileged instructions or dcbz */
+static int kvmppc_core_emulate_op_hv(struct kvm_run *run, struct kvm_vcpu *vcpu,
+				     unsigned int inst, int *advance)
 {
+	return EMULATE_FAIL;
 }
 
-/* We don't need to emulate any privileged instructions or dcbz */
-int kvmppc_core_emulate_op(struct kvm_run *run, struct kvm_vcpu *vcpu,
-                           unsigned int inst, int *advance)
+static int kvmppc_core_emulate_mtspr_hv(struct kvm_vcpu *vcpu, int sprn,
+					ulong spr_val)
 {
 	return EMULATE_FAIL;
 }
 
-int kvmppc_core_emulate_mtspr(struct kvm_vcpu *vcpu, int sprn, ulong spr_val)
+static int kvmppc_core_emulate_mfspr_hv(struct kvm_vcpu *vcpu, int sprn,
+					ulong *spr_val)
 {
 	return EMULATE_FAIL;
 }
 
-int kvmppc_core_emulate_mfspr(struct kvm_vcpu *vcpu, int sprn, ulong *spr_val)
+static int kvmppc_core_check_processor_compat_hv(void)
 {
-	return EMULATE_FAIL;
+	if (!cpu_has_feature(CPU_FTR_HVMODE))
+		return -EIO;
+	return 0;
+}
+
+static long kvm_arch_vm_ioctl_hv(struct file *filp,
+				 unsigned int ioctl, unsigned long arg)
+{
+	struct kvm *kvm __maybe_unused = filp->private_data;
+	void __user *argp = (void __user *)arg;
+	long r;
+
+	switch (ioctl) {
+
+	case KVM_ALLOCATE_RMA: {
+		struct kvm_allocate_rma rma;
+		struct kvm *kvm = filp->private_data;
+
+		r = kvm_vm_ioctl_allocate_rma(kvm, &rma);
+		if (r >= 0 && copy_to_user(argp, &rma, sizeof(rma)))
+			r = -EFAULT;
+		break;
+	}
+
+	case KVM_PPC_ALLOCATE_HTAB: {
+		u32 htab_order;
+
+		r = -EFAULT;
+		if (get_user(htab_order, (u32 __user *)argp))
+			break;
+		r = kvmppc_alloc_reset_hpt(kvm, &htab_order);
+		if (r)
+			break;
+		r = -EFAULT;
+		if (put_user(htab_order, (u32 __user *)argp))
+			break;
+		r = 0;
+		break;
+	}
+
+	case KVM_PPC_GET_HTAB_FD: {
+		struct kvm_get_htab_fd ghf;
+
+		r = -EFAULT;
+		if (copy_from_user(&ghf, argp, sizeof(ghf)))
+			break;
+		r = kvm_vm_ioctl_get_htab_fd(kvm, &ghf);
+		break;
+	}
+
+	default:
+		r = -ENOTTY;
+	}
+
+	return r;
 }
 
-static int kvmppc_book3s_hv_init(void)
+/* FIXME!! move to header */
+extern void kvmppc_core_flush_memslot_hv(struct kvm *kvm,
+					 struct kvm_memory_slot *memslot);
+extern int kvm_unmap_hva_hv(struct kvm *kvm, unsigned long hva);
+extern int kvm_unmap_hva_range_hv(struct kvm *kvm, unsigned long start,
+				  unsigned long end);
+extern int kvm_age_hva_hv(struct kvm *kvm, unsigned long hva);
+extern int kvm_test_age_hva_hv(struct kvm *kvm, unsigned long hva);
+extern void kvm_set_spte_hva_hv(struct kvm *kvm, unsigned long hva, pte_t pte);
+
+static struct kvmppc_ops kvmppc_hv_ops = {
+	.get_sregs = kvm_arch_vcpu_ioctl_get_sregs_hv,
+	.set_sregs = kvm_arch_vcpu_ioctl_set_sregs_hv,
+	.get_one_reg = kvmppc_get_one_reg_hv,
+	.set_one_reg = kvmppc_set_one_reg_hv,
+	.vcpu_load   = kvmppc_core_vcpu_load_hv,
+	.vcpu_put    = kvmppc_core_vcpu_put_hv,
+	.set_msr     = kvmppc_set_msr_hv,
+	.vcpu_run    = kvmppc_vcpu_run_hv,
+	.vcpu_create = kvmppc_core_vcpu_create_hv,
+	.vcpu_free   = kvmppc_core_vcpu_free_hv,
+	.check_requests = kvmppc_core_check_requests_hv,
+	.get_dirty_log  = kvm_vm_ioctl_get_dirty_log_hv,
+	.flush_memslot  = kvmppc_core_flush_memslot_hv,
+	.prepare_memory_region = kvmppc_core_prepare_memory_region_hv,
+	.commit_memory_region  = kvmppc_core_commit_memory_region_hv,
+	.unmap_hva = kvm_unmap_hva_hv,
+	.unmap_hva_range = kvm_unmap_hva_range_hv,
+	.age_hva  = kvm_age_hva_hv,
+	.test_age_hva = kvm_test_age_hva_hv,
+	.set_spte_hva = kvm_set_spte_hva_hv,
+	.mmu_destroy  = kvmppc_mmu_destroy_hv,
+	.free_memslot = kvmppc_core_free_memslot_hv,
+	.create_memslot = kvmppc_core_create_memslot_hv,
+	.init_vm =  kvmppc_core_init_vm_hv,
+	.destroy_vm = kvmppc_core_destroy_vm_hv,
+	.check_processor_compat = kvmppc_core_check_processor_compat_hv,
+	.get_smmu_info = kvm_vm_ioctl_get_smmu_info_hv,
+	.emulate_op = kvmppc_core_emulate_op_hv,
+	.emulate_mtspr = kvmppc_core_emulate_mtspr_hv,
+	.emulate_mfspr = kvmppc_core_emulate_mfspr_hv,
+	.fast_vcpu_kick = kvmppc_fast_vcpu_kick_hv,
+	.arch_vm_ioctl  = kvm_arch_vm_ioctl_hv,
+};
+
+static int kvmppc_book3s_init_hv(void)
 {
 	int r;
 
-	r = kvm_init(NULL, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
+	r = kvm_init(&kvmppc_hv_ops, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
 
 	if (r)
 		return r;
@@ -1992,10 +2096,10 @@ static int kvmppc_book3s_hv_init(void)
 	return r;
 }
 
-static void kvmppc_book3s_hv_exit(void)
+static void kvmppc_book3s_exit_hv(void)
 {
 	kvm_exit();
 }
 
-module_init(kvmppc_book3s_hv_init);
-module_exit(kvmppc_book3s_hv_exit);
+module_init(kvmppc_book3s_init_hv);
+module_exit(kvmppc_book3s_exit_hv);
diff --git a/arch/powerpc/kvm/book3s_interrupts.S b/arch/powerpc/kvm/book3s_interrupts.S
index 279ee3f..491d4b4 100644
--- a/arch/powerpc/kvm/book3s_interrupts.S
+++ b/arch/powerpc/kvm/book3s_interrupts.S
@@ -181,7 +181,7 @@ kvm_start_lightweight:
 
 	/* Restore r3 (kvm_run) and r4 (vcpu) */
 	REST_2GPRS(3, r1)
-	bl	FUNC(kvmppc_handle_exit)
+	bl	FUNC(kvmppc_handle_exit_pr)
 
 	/* If RESUME_GUEST, get back in the loop */
 	cmpwi	r3, RESUME_GUEST
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 17f7bfb..ff5bd24 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -56,7 +56,7 @@ static int kvmppc_handle_ext(struct kvm_vcpu *vcpu, unsigned int exit_nr,
 #define HW_PAGE_SIZE PAGE_SIZE
 #endif
 
-void kvmppc_core_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
+static void kvmppc_core_vcpu_load_pr(struct kvm_vcpu *vcpu, int cpu)
 {
 #ifdef CONFIG_PPC_BOOK3S_64
 	struct kvmppc_book3s_shadow_vcpu *svcpu = svcpu_get(vcpu);
@@ -70,7 +70,7 @@ void kvmppc_core_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 #endif
 }
 
-void kvmppc_core_vcpu_put(struct kvm_vcpu *vcpu)
+static void kvmppc_core_vcpu_put_pr(struct kvm_vcpu *vcpu)
 {
 #ifdef CONFIG_PPC_BOOK3S_64
 	struct kvmppc_book3s_shadow_vcpu *svcpu = svcpu_get(vcpu);
@@ -137,7 +137,7 @@ void kvmppc_copy_from_svcpu(struct kvm_vcpu *vcpu,
 	vcpu->arch.last_inst   = svcpu->last_inst;
 }
 
-int kvmppc_core_check_requests(struct kvm_vcpu *vcpu)
+static int kvmppc_core_check_requests_pr(struct kvm_vcpu *vcpu)
 {
 	int r = 1; /* Indicate we want to get back into the guest */
 
@@ -151,7 +151,7 @@ int kvmppc_core_check_requests(struct kvm_vcpu *vcpu)
 
 /************* MMU Notifiers *************/
 
-int kvm_unmap_hva(struct kvm *kvm, unsigned long hva)
+static int kvm_unmap_hva_pr(struct kvm *kvm, unsigned long hva)
 {
 	trace_kvm_unmap_hva(hva);
 
@@ -164,7 +164,8 @@ int kvm_unmap_hva(struct kvm *kvm, unsigned long hva)
 	return 0;
 }
 
-int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end)
+static int kvm_unmap_hva_range_pr(struct kvm *kvm, unsigned long start,
+			   unsigned long end)
 {
 	/* kvm_unmap_hva flushes everything anyways */
 	kvm_unmap_hva(kvm, start);
@@ -172,19 +173,19 @@ int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end)
 	return 0;
 }
 
-int kvm_age_hva(struct kvm *kvm, unsigned long hva)
+static int kvm_age_hva_pr(struct kvm *kvm, unsigned long hva)
 {
 	/* XXX could be more clever ;) */
 	return 0;
 }
 
-int kvm_test_age_hva(struct kvm *kvm, unsigned long hva)
+static int kvm_test_age_hva_pr(struct kvm *kvm, unsigned long hva)
 {
 	/* XXX could be more clever ;) */
 	return 0;
 }
 
-void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
+static void kvm_set_spte_hva_pr(struct kvm *kvm, unsigned long hva, pte_t pte)
 {
 	/* The page will get remapped properly on its next fault */
 	kvm_unmap_hva(kvm, hva);
@@ -209,7 +210,7 @@ static void kvmppc_recalc_shadow_msr(struct kvm_vcpu *vcpu)
 	vcpu->arch.shadow_msr = smsr;
 }
 
-void kvmppc_set_msr(struct kvm_vcpu *vcpu, u64 msr)
+static void kvmppc_set_msr_pr(struct kvm_vcpu *vcpu, u64 msr)
 {
 	ulong old_msr = vcpu->arch.shared->msr;
 
@@ -269,7 +270,7 @@ void kvmppc_set_msr(struct kvm_vcpu *vcpu, u64 msr)
 		kvmppc_handle_ext(vcpu, BOOK3S_INTERRUPT_FP_UNAVAIL, MSR_FP);
 }
 
-void kvmppc_set_pvr(struct kvm_vcpu *vcpu, u32 pvr)
+void kvmppc_set_pvr_pr(struct kvm_vcpu *vcpu, u32 pvr)
 {
 	u32 host_pvr;
 
@@ -688,8 +689,8 @@ static void kvmppc_handle_lost_ext(struct kvm_vcpu *vcpu)
 	current->thread.regs->msr |= lost_ext;
 }
 
-int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
-                       unsigned int exit_nr)
+int kvmppc_handle_exit_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
+			  unsigned int exit_nr)
 {
 	int r = RESUME_HOST;
 	int s;
@@ -989,8 +990,8 @@ program_interrupt:
 	return r;
 }
 
-int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
-                                  struct kvm_sregs *sregs)
+static int kvm_arch_vcpu_ioctl_get_sregs_pr(struct kvm_vcpu *vcpu,
+					    struct kvm_sregs *sregs)
 {
 	struct kvmppc_vcpu_book3s *vcpu3s = to_book3s(vcpu);
 	int i;
@@ -1016,13 +1017,13 @@ int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
-int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
-                                  struct kvm_sregs *sregs)
+static int kvm_arch_vcpu_ioctl_set_sregs_pr(struct kvm_vcpu *vcpu,
+					    struct kvm_sregs *sregs)
 {
 	struct kvmppc_vcpu_book3s *vcpu3s = to_book3s(vcpu);
 	int i;
 
-	kvmppc_set_pvr(vcpu, sregs->pvr);
+	kvmppc_set_pvr_pr(vcpu, sregs->pvr);
 
 	vcpu3s->sdr1 = sregs->u.s.sdr1;
 	if (vcpu->arch.hflags & BOOK3S_HFLAG_SLB) {
@@ -1052,7 +1053,8 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
-int kvmppc_get_one_reg(struct kvm_vcpu *vcpu, u64 id, union kvmppc_one_reg *val)
+static int kvmppc_get_one_reg_pr(struct kvm_vcpu *vcpu, u64 id,
+				 union kvmppc_one_reg *val)
 {
 	int r = 0;
 
@@ -1081,7 +1083,8 @@ int kvmppc_get_one_reg(struct kvm_vcpu *vcpu, u64 id, union kvmppc_one_reg *val)
 	return r;
 }
 
-int kvmppc_set_one_reg(struct kvm_vcpu *vcpu, u64 id, union kvmppc_one_reg *val)
+static int kvmppc_set_one_reg_pr(struct kvm_vcpu *vcpu, u64 id,
+				 union kvmppc_one_reg *val)
 {
 	int r = 0;
 
@@ -1111,12 +1114,8 @@ int kvmppc_set_one_reg(struct kvm_vcpu *vcpu, u64 id, union kvmppc_one_reg *val)
 	return r;
 }
 
-int kvmppc_core_check_processor_compat(void)
-{
-	return 0;
-}
-
-struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
+static struct kvm_vcpu *kvmppc_core_vcpu_create_pr(struct kvm *kvm,
+						   unsigned int id)
 {
 	struct kvmppc_vcpu_book3s *vcpu_book3s;
 	struct kvm_vcpu *vcpu;
@@ -1163,7 +1162,7 @@ struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
 	/* default to book3s_32 (750) */
 	vcpu->arch.pvr = 0x84202;
 #endif
-	kvmppc_set_pvr(vcpu, vcpu->arch.pvr);
+	kvmppc_set_pvr_pr(vcpu, vcpu->arch.pvr);
 	vcpu->arch.slb_nr = 64;
 
 	vcpu->arch.shadow_msr = MSR_USER64;
@@ -1188,7 +1187,7 @@ out:
 	return ERR_PTR(err);
 }
 
-void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
+static void kvmppc_core_vcpu_free_pr(struct kvm_vcpu *vcpu)
 {
 	struct kvmppc_vcpu_book3s *vcpu_book3s = to_book3s(vcpu);
 
@@ -1242,7 +1241,7 @@ static void enable_relon_interrupts(struct kvm *kvm)
 	kvm->arch.relon_disabled = false;
 }
 
-int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
+static int kvmppc_vcpu_run_pr(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 {
 	int ret;
 	double fpr[32][TS_FPRWIDTH];
@@ -1354,8 +1353,8 @@ out:
 /*
  * Get (and clear) the dirty memory log for a memory slot.
  */
-int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm,
-				      struct kvm_dirty_log *log)
+static int kvm_vm_ioctl_get_dirty_log_pr(struct kvm *kvm,
+					 struct kvm_dirty_log *log)
 {
 	struct kvm_memory_slot *memslot;
 	struct kvm_vcpu *vcpu;
@@ -1390,8 +1389,42 @@ out:
 	return r;
 }
 
+static void kvmppc_core_flush_memslot_pr(struct kvm *kvm,
+					 struct kvm_memory_slot *memslot)
+{
+	return;
+}
+
+static int kvmppc_core_prepare_memory_region_pr(struct kvm *kvm,
+					struct kvm_memory_slot *memslot,
+					struct kvm_userspace_memory_region *mem)
+{
+	return 0;
+}
+
+static void kvmppc_core_commit_memory_region_pr(struct kvm *kvm,
+				struct kvm_userspace_memory_region *mem,
+				const struct kvm_memory_slot *old)
+{
+	return;
+}
+
+static void kvmppc_core_free_memslot_pr(struct kvm_memory_slot *free,
+					struct kvm_memory_slot *dont)
+{
+	return;
+}
+
+static int kvmppc_core_create_memslot_pr(struct kvm_memory_slot *slot,
+					 unsigned long npages)
+{
+	return 0;
+}
+
+
 #ifdef CONFIG_PPC64
-int kvm_vm_ioctl_get_smmu_info(struct kvm *kvm, struct kvm_ppc_smmu_info *info)
+static int kvm_vm_ioctl_get_smmu_info_pr(struct kvm *kvm,
+					 struct kvm_ppc_smmu_info *info)
 {
 	long int i;
 	struct kvm_vcpu *vcpu;
@@ -1437,40 +1470,8 @@ int kvm_vm_ioctl_get_smmu_info(struct kvm *kvm, struct kvm_ppc_smmu_info *info)
 }
 #endif /* CONFIG_PPC64 */
 
-void kvmppc_core_free_memslot(struct kvm_memory_slot *free,
-			      struct kvm_memory_slot *dont)
-{
-}
-
-int kvmppc_core_create_memslot(struct kvm_memory_slot *slot,
-			       unsigned long npages)
-{
-	return 0;
-}
-
-int kvmppc_core_prepare_memory_region(struct kvm *kvm,
-				      struct kvm_memory_slot *memslot,
-				      struct kvm_userspace_memory_region *mem)
-{
-	return 0;
-}
-
-void kvmppc_core_commit_memory_region(struct kvm *kvm,
-				struct kvm_userspace_memory_region *mem,
-				const struct kvm_memory_slot *old)
-{
-}
-
-void kvmppc_core_flush_memslot(struct kvm *kvm, struct kvm_memory_slot *memslot)
-{
-}
-
-int kvmppc_core_init_vm(struct kvm *kvm)
+static int kvmppc_core_init_vm_pr(struct kvm *kvm)
 {
-#ifdef CONFIG_PPC64
-	INIT_LIST_HEAD(&kvm->arch.spapr_tce_tables);
-	INIT_LIST_HEAD(&kvm->arch.rtas_tokens);
-#endif
 	mutex_init(&kvm->arch.hpt_mutex);
 
 	/*
@@ -1482,16 +1483,71 @@ int kvmppc_core_init_vm(struct kvm *kvm)
 	return 0;
 }
 
-void kvmppc_core_destroy_vm(struct kvm *kvm)
+static void kvmppc_core_destroy_vm_pr(struct kvm *kvm)
 {
 	enable_relon_interrupts(kvm);
 }
 
-static int kvmppc_book3s_init(void)
+static int kvmppc_core_check_processor_compat_pr(void)
+{
+	/* we are always compatible */
+	return 0;
+}
+
+static long kvm_arch_vm_ioctl_pr(struct file *filp,
+				 unsigned int ioctl, unsigned long arg)
+{
+	return -ENOTTY;
+}
+
+extern void kvmppc_mmu_destroy_pr(struct kvm_vcpu *vcpu);
+extern int kvmppc_core_emulate_op_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
+				     unsigned int inst, int *advance);
+extern int kvmppc_core_emulate_mtspr_pr(struct kvm_vcpu *vcpu,
+					int sprn, ulong spr_val);
+extern int kvmppc_core_emulate_mfspr_pr(struct kvm_vcpu *vcpu,
+					int sprn, ulong *spr_val);
+
+static struct kvmppc_ops kvmppc_pr_ops = {
+	.get_sregs = kvm_arch_vcpu_ioctl_get_sregs_pr,
+	.set_sregs = kvm_arch_vcpu_ioctl_set_sregs_pr,
+	.get_one_reg = kvmppc_get_one_reg_pr,
+	.set_one_reg = kvmppc_set_one_reg_pr,
+	.vcpu_load   = kvmppc_core_vcpu_load_pr,
+	.vcpu_put    = kvmppc_core_vcpu_put_pr,
+	.set_msr     = kvmppc_set_msr_pr,
+	.vcpu_run    = kvmppc_vcpu_run_pr,
+	.vcpu_create = kvmppc_core_vcpu_create_pr,
+	.vcpu_free   = kvmppc_core_vcpu_free_pr,
+	.check_requests = kvmppc_core_check_requests_pr,
+	.get_dirty_log = kvm_vm_ioctl_get_dirty_log_pr,
+	.flush_memslot = kvmppc_core_flush_memslot_pr,
+	.prepare_memory_region = kvmppc_core_prepare_memory_region_pr,
+	.commit_memory_region = kvmppc_core_commit_memory_region_pr,
+	.unmap_hva = kvm_unmap_hva_pr,
+	.unmap_hva_range = kvm_unmap_hva_range_pr,
+	.age_hva  = kvm_age_hva_pr,
+	.test_age_hva = kvm_test_age_hva_pr,
+	.set_spte_hva = kvm_set_spte_hva_pr,
+	.mmu_destroy  = kvmppc_mmu_destroy_pr,
+	.free_memslot = kvmppc_core_free_memslot_pr,
+	.create_memslot = kvmppc_core_create_memslot_pr,
+	.init_vm = kvmppc_core_init_vm_pr,
+	.destroy_vm = kvmppc_core_destroy_vm_pr,
+	.check_processor_compat = kvmppc_core_check_processor_compat_pr,
+	.get_smmu_info = kvm_vm_ioctl_get_smmu_info_pr,
+	.emulate_op = kvmppc_core_emulate_op_pr,
+	.emulate_mtspr = kvmppc_core_emulate_mtspr_pr,
+	.emulate_mfspr = kvmppc_core_emulate_mfspr_pr,
+	.fast_vcpu_kick = kvm_vcpu_kick,
+	.arch_vm_ioctl  = kvm_arch_vm_ioctl_pr,
+};
+
+static int kvmppc_book3s_init_pr(void)
 {
 	int r;
 
-	r = kvm_init(NULL, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
+	r = kvm_init(&kvmppc_pr_ops, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
 
 	if (r)
 		return r;
@@ -1501,11 +1557,11 @@ static int kvmppc_book3s_init(void)
 	return r;
 }
 
-static void kvmppc_book3s_exit(void)
+static void kvmppc_book3s_exit_pr(void)
 {
 	kvmppc_mmu_hpte_sysexit();
 	kvm_exit();
 }
 
-module_init(kvmppc_book3s_init);
-module_exit(kvmppc_book3s_exit);
+module_init(kvmppc_book3s_init_pr);
+module_exit(kvmppc_book3s_exit_pr);
diff --git a/arch/powerpc/kvm/emulate.c b/arch/powerpc/kvm/emulate.c
index 751cd45..81762eb 100644
--- a/arch/powerpc/kvm/emulate.c
+++ b/arch/powerpc/kvm/emulate.c
@@ -130,7 +130,7 @@ static int kvmppc_emulate_mtspr(struct kvm_vcpu *vcpu, int sprn, int rs)
 	case SPRN_PIR: break;
 
 	default:
-		emulated = kvmppc_core_emulate_mtspr(vcpu, sprn,
+		emulated = kvmppc_ops->emulate_mtspr(vcpu, sprn,
 						     spr_val);
 		if (emulated == EMULATE_FAIL)
 			printk(KERN_INFO "mtspr: unknown spr "
@@ -191,7 +191,7 @@ static int kvmppc_emulate_mfspr(struct kvm_vcpu *vcpu, int sprn, int rt)
 		spr_val = kvmppc_get_dec(vcpu, get_tb());
 		break;
 	default:
-		emulated = kvmppc_core_emulate_mfspr(vcpu, sprn,
+		emulated = kvmppc_ops->emulate_mfspr(vcpu, sprn,
 						     &spr_val);
 		if (unlikely(emulated == EMULATE_FAIL)) {
 			printk(KERN_INFO "mfspr: unknown spr "
@@ -464,7 +464,7 @@ int kvmppc_emulate_instruction(struct kvm_run *run, struct kvm_vcpu *vcpu)
 	}
 
 	if (emulated == EMULATE_FAIL) {
-		emulated = kvmppc_core_emulate_op(run, vcpu, inst, &advance);
+		emulated = kvmppc_ops->emulate_op(run, vcpu, inst, &advance);
 		if (emulated == EMULATE_AGAIN) {
 			advance = 0;
 		} else if (emulated == EMULATE_FAIL) {
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 07c0106..69b9305 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -39,6 +39,8 @@
 #define CREATE_TRACE_POINTS
 #include "trace.h"
 
+struct kvmppc_ops *kvmppc_ops;
+
 int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
 {
 	return !!(v->arch.pending_exceptions) ||
@@ -1024,52 +1026,11 @@ long kvm_arch_vm_ioctl(struct file *filp,
 		r = kvm_vm_ioctl_create_spapr_tce(kvm, &create_tce);
 		goto out;
 	}
-#endif /* CONFIG_PPC_BOOK3S_64 */
-
-#ifdef CONFIG_KVM_BOOK3S_64_HV
-	case KVM_ALLOCATE_RMA: {
-		struct kvm_allocate_rma rma;
-		struct kvm *kvm = filp->private_data;
-
-		r = kvm_vm_ioctl_allocate_rma(kvm, &rma);
-		if (r >= 0 && copy_to_user(argp, &rma, sizeof(rma)))
-			r = -EFAULT;
-		break;
-	}
-
-	case KVM_PPC_ALLOCATE_HTAB: {
-		u32 htab_order;
-
-		r = -EFAULT;
-		if (get_user(htab_order, (u32 __user *)argp))
-			break;
-		r = kvmppc_alloc_reset_hpt(kvm, &htab_order);
-		if (r)
-			break;
-		r = -EFAULT;
-		if (put_user(htab_order, (u32 __user *)argp))
-			break;
-		r = 0;
-		break;
-	}
-
-	case KVM_PPC_GET_HTAB_FD: {
-		struct kvm_get_htab_fd ghf;
-
-		r = -EFAULT;
-		if (copy_from_user(&ghf, argp, sizeof(ghf)))
-			break;
-		r = kvm_vm_ioctl_get_htab_fd(kvm, &ghf);
-		break;
-	}
-#endif /* CONFIG_KVM_BOOK3S_64_HV */
-
-#ifdef CONFIG_PPC_BOOK3S_64
 	case KVM_PPC_GET_SMMU_INFO: {
 		struct kvm_ppc_smmu_info info;
 
 		memset(&info, 0, sizeof(info));
-		r = kvm_vm_ioctl_get_smmu_info(kvm, &info);
+		r = kvmppc_ops->get_smmu_info(kvm, &info);
 		if (r >= 0 && copy_to_user(argp, &info, sizeof(info)))
 			r = -EFAULT;
 		break;
@@ -1080,11 +1041,14 @@ long kvm_arch_vm_ioctl(struct file *filp,
 		r = kvm_vm_ioctl_rtas_define_token(kvm, argp);
 		break;
 	}
-#endif /* CONFIG_PPC_BOOK3S_64 */
+	default:
+		r = kvmppc_ops->arch_vm_ioctl(filp, ioctl, arg);
+
+#else /* CONFIG_PPC_BOOK3S_64 */
 	default:
 		r = -ENOTTY;
+#endif
 	}
-
 out:
 	return r;
 }
@@ -1125,9 +1089,15 @@ void kvmppc_init_lpid(unsigned long nr_lpids_param)
 
 int kvm_arch_init(void *opaque)
 {
+	if (kvmppc_ops) {
+		printk(KERN_ERR "kvm: already loaded the other module\n");
+		return -EEXIST;
+	}
+	kvmppc_ops = (struct kvmppc_ops *)opaque;
 	return 0;
 }
 
 void kvm_arch_exit(void)
 {
+	kvmppc_ops = NULL;
 }
-- 
1.8.1.2
