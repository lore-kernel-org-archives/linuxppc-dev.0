Return-Path: <mihai.caraman@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4C9152C00C0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Feb 2014 03:30:42 +1100 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 3/4] KVM: PPC: Alow kvmppc_get_last_inst() to fail
Date: Thu, 20 Feb 2014 18:30:20 +0200
Message-ID: <1392913821-4520-3-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1392913821-4520-1-git-send-email-mihai.caraman@freescale.com>
References: <1392913821-4520-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On booke3e we got the last instruction on the exist path, using
load external pid (lwepx) dedicated instruction. The current
implementation proved to be buggy, and the alternative, to hook
lwepx exceptions into KVM, is considered too intrusive for host.

In the proposed solution we gets the instruction by mapping the
memory in the host, which requires to locate the guest TLB entry.
This may fail if the guest TLB entry gets evicted. In the failure
case we will force a TLB update, by reexecuting the guest instruction
which generates a guest TLB miss exception.

Alex G. suggested to get the last instruction on kvmppc_get_last_inst()
call and to  handle the TLB seach miss on its call chain. This patch
allows the function to fail, by returning an emulation_result error code,
and handles the EMULATE_AGAIN error code in the emulation layer
(leading to guest instruction reexecution).

Emulation_result common structure is not accesible from specific
booke headers, so this patch moves kvmppc_get_last_inst() definitions
to booke3 source files.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>

Please sanity check Book3S changes, I did the integration blindly.
---
 arch/powerpc/include/asm/kvm_book3s.h    |   29 ----------------------------
 arch/powerpc/include/asm/kvm_booke.h     |    5 ----
 arch/powerpc/include/asm/kvm_ppc.h       |    2 +
 arch/powerpc/kvm/book3s.c                |   31 ++++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_paired_singles.c |   29 ++++++++++++++++-----------
 arch/powerpc/kvm/book3s_pr.c             |   27 +++++++++++++++++--------
 arch/powerpc/kvm/booke.c                 |   16 ++++++++++++++-
 arch/powerpc/kvm/booke.h                 |    5 ++++
 arch/powerpc/kvm/e500_mmu_host.c         |    5 ++++
 arch/powerpc/kvm/emulate.c               |   19 ++++++++++++-----
 arch/powerpc/kvm/powerpc.c               |   10 +++++++-
 11 files changed, 114 insertions(+), 64 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index bc23b1b..6048eea 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -271,35 +271,6 @@ static inline ulong kvmppc_get_pc(struct kvm_vcpu *vcpu)
 	return vcpu->arch.pc;
 }
 
-static inline u32 kvmppc_get_last_inst(struct kvm_vcpu *vcpu)
-{
-	ulong pc = kvmppc_get_pc(vcpu);
-
-	/* Load the instruction manually if it failed to do so in the
-	 * exit path */
-	if (vcpu->arch.last_inst == KVM_INST_FETCH_FAILED)
-		kvmppc_ld(vcpu, &pc, sizeof(u32), &vcpu->arch.last_inst, false);
-
-	return vcpu->arch.last_inst;
-}
-
-/*
- * Like kvmppc_get_last_inst(), but for fetching a sc instruction.
- * Because the sc instruction sets SRR0 to point to the following
- * instruction, we have to fetch from pc - 4.
- */
-static inline u32 kvmppc_get_last_sc(struct kvm_vcpu *vcpu)
-{
-	ulong pc = kvmppc_get_pc(vcpu) - 4;
-
-	/* Load the instruction manually if it failed to do so in the
-	 * exit path */
-	if (vcpu->arch.last_inst == KVM_INST_FETCH_FAILED)
-		kvmppc_ld(vcpu, &pc, sizeof(u32), &vcpu->arch.last_inst, false);
-
-	return vcpu->arch.last_inst;
-}
-
 static inline ulong kvmppc_get_fault_dar(struct kvm_vcpu *vcpu)
 {
 	return vcpu->arch.fault_dar;
diff --git a/arch/powerpc/include/asm/kvm_booke.h b/arch/powerpc/include/asm/kvm_booke.h
index dd8f615..7a85a69 100644
--- a/arch/powerpc/include/asm/kvm_booke.h
+++ b/arch/powerpc/include/asm/kvm_booke.h
@@ -63,11 +63,6 @@ static inline u32 kvmppc_get_xer(struct kvm_vcpu *vcpu)
 	return vcpu->arch.xer;
 }
 
-static inline u32 kvmppc_get_last_inst(struct kvm_vcpu *vcpu)
-{
-	return vcpu->arch.last_inst;
-}
-
 static inline void kvmppc_set_ctr(struct kvm_vcpu *vcpu, ulong val)
 {
 	vcpu->arch.ctr = val;
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index c8317fb..bc0cd21 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -71,6 +71,8 @@ extern int kvmppc_sanity_check(struct kvm_vcpu *vcpu);
 extern int kvmppc_subarch_vcpu_init(struct kvm_vcpu *vcpu);
 extern void kvmppc_subarch_vcpu_uninit(struct kvm_vcpu *vcpu);
 
+extern int kvmppc_get_last_inst(struct kvm_vcpu *vcpu, u32 *inst);
+
 /* Core-specific hooks */
 
 extern void kvmppc_mmu_map(struct kvm_vcpu *vcpu, u64 gvaddr, gpa_t gpaddr,
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 8912608..a86f7a4 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -461,6 +461,37 @@ mmio:
 }
 EXPORT_SYMBOL_GPL(kvmppc_ld);
 
+int kvmppc_get_last_inst(struct kvm_vcpu *vcpu, u32 *inst)
+{
+	ulong pc = kvmppc_get_pc(vcpu);
+
+	/* Load the instruction manually if it failed to do so in the
+	 * exit path */
+	if (vcpu->arch.last_inst == KVM_INST_FETCH_FAILED)
+		kvmppc_ld(vcpu, &pc, sizeof(u32), &vcpu->arch.last_inst, false);
+	*inst = vcpu->arch.last_inst;
+
+	return EMULATE_DONE;
+}
+
+/*
+ * Like kvmppc_get_last_inst(), but for fetching a sc instruction.
+ * Because the sc instruction sets SRR0 to point to the following
+ * instruction, we have to fetch from pc - 4.
+ */
+int kvmppc_get_last_sc(struct kvm_vcpu *vcpu, u32 *inst)
+{
+	ulong pc = kvmppc_get_pc(vcpu) - 4;
+
+	/* Load the instruction manually if it failed to do so in the
+	 * exit path */
+	if (vcpu->arch.last_inst == KVM_INST_FETCH_FAILED)
+		kvmppc_ld(vcpu, &pc, sizeof(u32), &vcpu->arch.last_inst, false);
+	*inst = vcpu->arch.last_inst;
+
+	return EMULATE_DONE;
+}
+
 int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 {
 	return 0;
diff --git a/arch/powerpc/kvm/book3s_paired_singles.c b/arch/powerpc/kvm/book3s_paired_singles.c
index a59a25a..80c533e 100644
--- a/arch/powerpc/kvm/book3s_paired_singles.c
+++ b/arch/powerpc/kvm/book3s_paired_singles.c
@@ -640,19 +640,24 @@ static int kvmppc_ps_one_in(struct kvm_vcpu *vcpu, bool rc,
 
 int kvmppc_emulate_paired_single(struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
-	u32 inst = kvmppc_get_last_inst(vcpu);
+	u32 inst;
 	enum emulation_result emulated = EMULATE_DONE;
-
-	int ax_rd = inst_get_field(inst, 6, 10);
-	int ax_ra = inst_get_field(inst, 11, 15);
-	int ax_rb = inst_get_field(inst, 16, 20);
-	int ax_rc = inst_get_field(inst, 21, 25);
-	short full_d = inst_get_field(inst, 16, 31);
-
-	u64 *fpr_d = &vcpu->arch.fpr[ax_rd];
-	u64 *fpr_a = &vcpu->arch.fpr[ax_ra];
-	u64 *fpr_b = &vcpu->arch.fpr[ax_rb];
-	u64 *fpr_c = &vcpu->arch.fpr[ax_rc];
+	int ax_rd, ax_ra, ax_rb, ax_rc;
+	short full_d;
+	u64 *fpr_d, *fpr_a, *fpr_b, *fpr_c;
+
+	kvmppc_get_last_inst(vcpu, &inst);
+
+	ax_rd = inst_get_field(inst, 6, 10);
+	ax_ra = inst_get_field(inst, 11, 15);
+	ax_rb = inst_get_field(inst, 16, 20);
+	ax_rc = inst_get_field(inst, 21, 25);
+	full_d = inst_get_field(inst, 16, 31);
+
+	fpr_d = &vcpu->arch.fpr[ax_rd];
+	fpr_a = &vcpu->arch.fpr[ax_ra];
+	fpr_b = &vcpu->arch.fpr[ax_rb];
+	fpr_c = &vcpu->arch.fpr[ax_rc];
 
 	bool rcomp = (inst & 1) ? true : false;
 	u32 cr = kvmppc_get_cr(vcpu);
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 5b9e906..b0d884d 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -624,9 +624,10 @@ void kvmppc_giveup_ext(struct kvm_vcpu *vcpu, ulong msr)
 static int kvmppc_read_inst(struct kvm_vcpu *vcpu)
 {
 	ulong srr0 = kvmppc_get_pc(vcpu);
-	u32 last_inst = kvmppc_get_last_inst(vcpu);
+	u32 last_inst;
 	int ret;
 
+	kvmppc_get_last_inst(vcpu, &last_inst);
 	ret = kvmppc_ld(vcpu, &srr0, sizeof(u32), &last_inst, false);
 	if (ret == -ENOENT) {
 		ulong msr = vcpu->arch.shared->msr;
@@ -890,15 +891,17 @@ int kvmppc_handle_exit_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	{
 		enum emulation_result er;
 		ulong flags;
+		u32 last_inst;
 
 program_interrupt:
 		flags = vcpu->arch.shadow_srr1 & 0x1f0000ull;
+		kvmppc_get_last_inst(vcpu, &last_inst);
 
 		if (vcpu->arch.shared->msr & MSR_PR) {
 #ifdef EXIT_DEBUG
-			printk(KERN_INFO "Userspace triggered 0x700 exception at 0x%lx (0x%x)\n", kvmppc_get_pc(vcpu), kvmppc_get_last_inst(vcpu));
+			printk(KERN_INFO "Userspace triggered 0x700 exception at 0x%lx (0x%x)\n", kvmppc_get_pc(vcpu), last_inst);
 #endif
-			if ((kvmppc_get_last_inst(vcpu) & 0xff0007ff) !=
+			if ((last_inst & 0xff0007ff) !=
 			    (INS_DCBZ & 0xfffffff7)) {
 				kvmppc_core_queue_program(vcpu, flags);
 				r = RESUME_GUEST;
@@ -917,7 +920,7 @@ program_interrupt:
 			break;
 		case EMULATE_FAIL:
 			printk(KERN_CRIT "%s: emulation at %lx failed (%08x)\n",
-			       __func__, kvmppc_get_pc(vcpu), kvmppc_get_last_inst(vcpu));
+			       __func__, kvmppc_get_pc(vcpu), last_inst);
 			kvmppc_core_queue_program(vcpu, flags);
 			r = RESUME_GUEST;
 			break;
@@ -934,8 +937,11 @@ program_interrupt:
 		break;
 	}
 	case BOOK3S_INTERRUPT_SYSCALL:
+	{
+		u32 last_sc;
+		kvmppc_get_last_sc(vcpu, &last_sc);
 		if (vcpu->arch.papr_enabled &&
-		    (kvmppc_get_last_sc(vcpu) == 0x44000022) &&
+		    (last_sc == 0x44000022) &&
 		    !(vcpu->arch.shared->msr & MSR_PR)) {
 			/* SC 1 papr hypercalls */
 			ulong cmd = kvmppc_get_gpr(vcpu, 3);
@@ -980,6 +986,7 @@ program_interrupt:
 			r = RESUME_GUEST;
 		}
 		break;
+	}
 	case BOOK3S_INTERRUPT_FP_UNAVAIL:
 	case BOOK3S_INTERRUPT_ALTIVEC:
 	case BOOK3S_INTERRUPT_VSX:
@@ -1008,15 +1015,17 @@ program_interrupt:
 		break;
 	}
 	case BOOK3S_INTERRUPT_ALIGNMENT:
+	{
+		u32 last_inst;
+		kvmppc_get_last_inst(vcpu, &last_inst);
 		if (kvmppc_read_inst(vcpu) == EMULATE_DONE) {
-			vcpu->arch.shared->dsisr = kvmppc_alignment_dsisr(vcpu,
-				kvmppc_get_last_inst(vcpu));
-			vcpu->arch.shared->dar = kvmppc_alignment_dar(vcpu,
-				kvmppc_get_last_inst(vcpu));
+			vcpu->arch.shared->dsisr = kvmppc_alignment_dsisr(vcpu, last_inst);
+			vcpu->arch.shared->dar = kvmppc_alignment_dar(vcpu, last_inst);
 			kvmppc_book3s_queue_irqprio(vcpu, exit_nr);
 		}
 		r = RESUME_GUEST;
 		break;
+	}
 	case BOOK3S_INTERRUPT_MACHINE_CHECK:
 	case BOOK3S_INTERRUPT_TRACE:
 		kvmppc_book3s_queue_irqprio(vcpu, exit_nr);
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 0591e05..886e511 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -201,7 +201,7 @@ static void kvmppc_core_queue_data_storage(struct kvm_vcpu *vcpu,
 	kvmppc_booke_queue_irqprio(vcpu, BOOKE_IRQPRIO_DATA_STORAGE);
 }
 
-static void kvmppc_core_queue_inst_storage(struct kvm_vcpu *vcpu,
+void kvmppc_core_queue_inst_storage(struct kvm_vcpu *vcpu,
                                            ulong esr_flags)
 {
 	vcpu->arch.queued_esr = esr_flags;
@@ -772,6 +772,9 @@ static int emulation_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 		 * they were actually modified by emulation. */
 		return RESUME_GUEST_NV;
 
+	case EMULATE_AGAIN:
+		return RESUME_GUEST;
+
 	case EMULATE_DO_DCR:
 		run->exit_reason = KVM_EXIT_DCR;
 		return RESUME_HOST;
@@ -1943,6 +1946,17 @@ void kvmppc_core_vcpu_put(struct kvm_vcpu *vcpu)
 	vcpu->kvm->arch.kvm_ops->vcpu_put(vcpu);
 }
 
+int kvmppc_get_last_inst(struct kvm_vcpu *vcpu, u32 *inst)
+{
+	int result = EMULATE_DONE;
+
+	if (vcpu->arch.last_inst == KVM_INST_FETCH_FAILED)
+		result = kvmppc_ld_inst(vcpu, &vcpu->arch.last_inst);
+	*inst = vcpu->arch.last_inst;
+
+	return result;
+}
+
 int __init kvmppc_booke_init(void)
 {
 #ifndef CONFIG_KVM_BOOKE_HV
diff --git a/arch/powerpc/kvm/booke.h b/arch/powerpc/kvm/booke.h
index 09bfd9b..c7c60c2 100644
--- a/arch/powerpc/kvm/booke.h
+++ b/arch/powerpc/kvm/booke.h
@@ -90,6 +90,9 @@ void kvmppc_vcpu_disable_spe(struct kvm_vcpu *vcpu);
 void kvmppc_booke_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
 void kvmppc_booke_vcpu_put(struct kvm_vcpu *vcpu);
 
+void kvmppc_core_queue_inst_storage(struct kvm_vcpu *vcpu,
+                                           ulong esr_flags);
+
 enum int_class {
 	INT_CLASS_NONCRIT,
 	INT_CLASS_CRIT,
@@ -123,6 +126,8 @@ extern int kvmppc_core_emulate_mtspr_e500(struct kvm_vcpu *vcpu, int sprn,
 extern int kvmppc_core_emulate_mfspr_e500(struct kvm_vcpu *vcpu, int sprn,
 					  ulong *spr_val);
 
+extern int kvmppc_ld_inst(struct kvm_vcpu *vcpu, u32 *instr) ;
+
 /*
  * Load up guest vcpu FP state if it's needed.
  * It also set the MSR_FP in thread so that host know
diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
index ecf2247..6025cb7 100644
--- a/arch/powerpc/kvm/e500_mmu_host.c
+++ b/arch/powerpc/kvm/e500_mmu_host.c
@@ -34,6 +34,7 @@
 #include "e500.h"
 #include "timing.h"
 #include "e500_mmu_host.h"
+#include "booke.h"
 
 #include "trace_booke.h"
 
@@ -597,6 +598,10 @@ void kvmppc_mmu_map(struct kvm_vcpu *vcpu, u64 eaddr, gpa_t gpaddr,
 	}
 }
 
+int kvmppc_ld_inst(struct kvm_vcpu *vcpu, u32 *instr) {
+	return EMULATE_FAIL;
+};
+
 /************* MMU Notifiers *************/
 
 int kvm_unmap_hva(struct kvm *kvm, unsigned long hva)
diff --git a/arch/powerpc/kvm/emulate.c b/arch/powerpc/kvm/emulate.c
index 2f9a087..24a8e50 100644
--- a/arch/powerpc/kvm/emulate.c
+++ b/arch/powerpc/kvm/emulate.c
@@ -225,19 +225,26 @@ static int kvmppc_emulate_mfspr(struct kvm_vcpu *vcpu, int sprn, int rt)
  * from opcode tables in the future. */
 int kvmppc_emulate_instruction(struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
-	u32 inst = kvmppc_get_last_inst(vcpu);
-	int ra = get_ra(inst);
-	int rs = get_rs(inst);
-	int rt = get_rt(inst);
-	int sprn = get_sprn(inst);
-	enum emulation_result emulated = EMULATE_DONE;
+	u32 inst;
+	int ra, rs, rt, sprn;
+	enum emulation_result emulated;
 	int advance = 1;
 
 	/* this default type might be overwritten by subcategories */
 	kvmppc_set_exit_type(vcpu, EMULATED_INST_EXITS);
 
+	emulated = kvmppc_get_last_inst(vcpu, &inst);
+	if (emulated != EMULATE_DONE) {
+		return emulated;
+	}
+
 	pr_debug("Emulating opcode %d / %d\n", get_op(inst), get_xop(inst));
 
+	ra = get_ra(inst);
+	rs = get_rs(inst);
+	rt = get_rt(inst);
+	sprn = get_sprn(inst);
+
 	switch (get_op(inst)) {
 	case OP_TRAP:
 #ifdef CONFIG_PPC_BOOK3S
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 9ae9768..b611a5d 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -228,6 +228,9 @@ int kvmppc_emulate_mmio(struct kvm_run *run, struct kvm_vcpu *vcpu)
 		 * actually modified. */
 		r = RESUME_GUEST_NV;
 		break;
+	case EMULATE_AGAIN:
+		r = RESUME_GUEST;
+		break;
 	case EMULATE_DO_MMIO:
 		run->exit_reason = KVM_EXIT_MMIO;
 		/* We must reload nonvolatiles because "update" load/store
@@ -237,11 +240,14 @@ int kvmppc_emulate_mmio(struct kvm_run *run, struct kvm_vcpu *vcpu)
 		r = RESUME_HOST_NV;
 		break;
 	case EMULATE_FAIL:
+	{
+		u32 last_inst;
+		kvmppc_get_last_inst(vcpu, &last_inst);
 		/* XXX Deliver Program interrupt to guest. */
-		printk(KERN_EMERG "%s: emulation failed (%08x)\n", __func__,
-		       kvmppc_get_last_inst(vcpu));
+		printk(KERN_EMERG "%s: emulation failed (%08x)\n", __func__, last_inst);
 		r = RESUME_HOST;
 		break;
+	}
 	default:
 		WARN_ON(1);
 		r = RESUME_GUEST;
-- 
1.7.3.4
