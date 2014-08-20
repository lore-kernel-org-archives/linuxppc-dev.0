Return-Path: <mihai.caraman@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0144.outbound.protection.outlook.com [207.46.163.144])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BD9921A019A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 23:36:46 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH v4 2/6] KVM: PPC: Book3e: Add AltiVec support
Date: Wed, 20 Aug 2014 16:36:23 +0300
Message-ID: <1408541787-24625-3-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1408541787-24625-1-git-send-email-mihai.caraman@freescale.com>
References: <1408541787-24625-1-git-send-email-mihai.caraman@freescale.com>
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

Add AltiVec support in KVM for Book3e. FPU support gracefully reuse host
infrastructure so follow the same approach for AltiVec.

Book3e specification defines shared interrupt numbers for SPE and AltiVec
units. Still SPE is present in e200/e500v2 cores while AltiVec is present in
e6500 core. So we can currently decide at compile-time which of the SPE or
AltiVec units to support exclusively by using CONFIG_SPE_POSSIBLE and
CONFIG_PPC_E500MC defines. As Alexander Graf suggested, keep SPE and AltiVec
exception handlers distinct to improve code readability.

Guests have the privilege to enable AltiVec, so we always need to support
AltiVec in KVM and implicitly in host to reflect interrupts and to save/restore
the unit context. KVM will be loaded on cores with AltiVec unit only if
CONFIG_ALTIVEC is defined. Use this define to guard KVM AltiVec logic.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
v4:
 - use CONFIG_SPE_POSSIBLE and a new ifdef for CONFIG_ALTIVEC
 - remove SPE handlers from bookehv
 - update commit message

v3:
 - use distinct SPE/AltiVec exception handlers

v2:
 - integrate Paul's FP/VMX/VSX changes

 arch/powerpc/kvm/booke.c              | 74 ++++++++++++++++++++++++++++++++++-
 arch/powerpc/kvm/booke.h              |  6 +++
 arch/powerpc/kvm/bookehv_interrupts.S |  9 +----
 arch/powerpc/kvm/e500_emulate.c       | 20 ++++++++++
 4 files changed, 101 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 91e7217..8ace612 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -168,6 +168,40 @@ static void kvmppc_vcpu_sync_fpu(struct kvm_vcpu *vcpu)
 #endif
 }
 
+/*
+ * Simulate AltiVec unavailable fault to load guest state
+ * from thread to AltiVec unit.
+ * It requires to be called with preemption disabled.
+ */
+static inline void kvmppc_load_guest_altivec(struct kvm_vcpu *vcpu)
+{
+#ifdef CONFIG_ALTIVEC
+	if (cpu_has_feature(CPU_FTR_ALTIVEC)) {
+		if (!(current->thread.regs->msr & MSR_VEC)) {
+			enable_kernel_altivec();
+			load_vr_state(&vcpu->arch.vr);
+			current->thread.vr_save_area = &vcpu->arch.vr;
+			current->thread.regs->msr |= MSR_VEC;
+		}
+	}
+#endif
+}
+
+/*
+ * Save guest vcpu AltiVec state into thread.
+ * It requires to be called with preemption disabled.
+ */
+static inline void kvmppc_save_guest_altivec(struct kvm_vcpu *vcpu)
+{
+#ifdef CONFIG_ALTIVEC
+	if (cpu_has_feature(CPU_FTR_ALTIVEC)) {
+		if (current->thread.regs->msr & MSR_VEC)
+			giveup_altivec(current);
+		current->thread.vr_save_area = NULL;
+	}
+#endif
+}
+
 static void kvmppc_vcpu_sync_debug(struct kvm_vcpu *vcpu)
 {
 	/* Synchronize guest's desire to get debug interrupts into shadow MSR */
@@ -375,9 +409,15 @@ static int kvmppc_booke_irqprio_deliver(struct kvm_vcpu *vcpu,
 	case BOOKE_IRQPRIO_ITLB_MISS:
 	case BOOKE_IRQPRIO_SYSCALL:
 	case BOOKE_IRQPRIO_FP_UNAVAIL:
+#ifdef CONFIG_SPE_POSSIBLE
 	case BOOKE_IRQPRIO_SPE_UNAVAIL:
 	case BOOKE_IRQPRIO_SPE_FP_DATA:
 	case BOOKE_IRQPRIO_SPE_FP_ROUND:
+#endif
+#ifdef CONFIG_ALTIVEC
+	case BOOKE_IRQPRIO_ALTIVEC_UNAVAIL:
+	case BOOKE_IRQPRIO_ALTIVEC_ASSIST:
+#endif
 	case BOOKE_IRQPRIO_AP_UNAVAIL:
 		allowed = 1;
 		msr_mask = MSR_CE | MSR_ME | MSR_DE;
@@ -697,6 +737,17 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 	kvmppc_load_guest_fp(vcpu);
 #endif
 
+#ifdef CONFIG_ALTIVEC
+	/* Save userspace AltiVec state in stack */
+	if (cpu_has_feature(CPU_FTR_ALTIVEC))
+		enable_kernel_altivec();
+	/*
+	 * Since we can't trap on MSR_VEC in GS-mode, we consider the guest
+	 * as always using the AltiVec.
+	 */
+	kvmppc_load_guest_altivec(vcpu);
+#endif
+
 	/* Switch to guest debug context */
 	debug = vcpu->arch.dbg_reg;
 	switch_booke_debug_regs(&debug);
@@ -719,6 +770,10 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 	kvmppc_save_guest_fp(vcpu);
 #endif
 
+#ifdef CONFIG_ALTIVEC
+	kvmppc_save_guest_altivec(vcpu);
+#endif
+
 out:
 	vcpu->mode = OUTSIDE_GUEST_MODE;
 	return ret;
@@ -1025,7 +1080,7 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		kvmppc_booke_queue_irqprio(vcpu, BOOKE_IRQPRIO_SPE_FP_ROUND);
 		r = RESUME_GUEST;
 		break;
-#else
+#elif defined(CONFIG_SPE_POSSIBLE)
 	case BOOKE_INTERRUPT_SPE_UNAVAIL:
 		/*
 		 * Guest wants SPE, but host kernel doesn't support it.  Send
@@ -1046,6 +1101,22 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		run->hw.hardware_exit_reason = exit_nr;
 		r = RESUME_HOST;
 		break;
+#endif /* CONFIG_SPE_POSSIBLE */
+
+/*
+ * On cores with Vector category, KVM is loaded only if CONFIG_ALTIVEC,
+ * see kvmppc_core_check_processor_compat().
+ */
+#ifdef CONFIG_ALTIVEC
+	case BOOKE_INTERRUPT_ALTIVEC_UNAVAIL:
+		kvmppc_booke_queue_irqprio(vcpu, BOOKE_IRQPRIO_ALTIVEC_UNAVAIL);
+		r = RESUME_GUEST;
+		break;
+
+	case BOOKE_INTERRUPT_ALTIVEC_ASSIST:
+		kvmppc_booke_queue_irqprio(vcpu, BOOKE_IRQPRIO_ALTIVEC_ASSIST);
+		r = RESUME_GUEST;
+		break;
 #endif
 
 	case BOOKE_INTERRUPT_DATA_STORAGE:
@@ -1223,6 +1294,7 @@ out:
 			/* interrupts now hard-disabled */
 			kvmppc_fix_ee_before_entry();
 			kvmppc_load_guest_fp(vcpu);
+			kvmppc_load_guest_altivec(vcpu);
 		}
 	}
 
diff --git a/arch/powerpc/kvm/booke.h b/arch/powerpc/kvm/booke.h
index e73d513..22ba08e 100644
--- a/arch/powerpc/kvm/booke.h
+++ b/arch/powerpc/kvm/booke.h
@@ -32,9 +32,15 @@
 #define BOOKE_IRQPRIO_ALIGNMENT 2
 #define BOOKE_IRQPRIO_PROGRAM 3
 #define BOOKE_IRQPRIO_FP_UNAVAIL 4
+#ifdef CONFIG_SPE_POSSIBLE
 #define BOOKE_IRQPRIO_SPE_UNAVAIL 5
 #define BOOKE_IRQPRIO_SPE_FP_DATA 6
 #define BOOKE_IRQPRIO_SPE_FP_ROUND 7
+#endif
+#ifdef CONFIG_PPC_E500MC
+#define BOOKE_IRQPRIO_ALTIVEC_UNAVAIL 5
+#define BOOKE_IRQPRIO_ALTIVEC_ASSIST 6
+#endif
 #define BOOKE_IRQPRIO_SYSCALL 8
 #define BOOKE_IRQPRIO_AP_UNAVAIL 9
 #define BOOKE_IRQPRIO_DTLB_MISS 10
diff --git a/arch/powerpc/kvm/bookehv_interrupts.S b/arch/powerpc/kvm/bookehv_interrupts.S
index e9fa56a..c8e4da5 100644
--- a/arch/powerpc/kvm/bookehv_interrupts.S
+++ b/arch/powerpc/kvm/bookehv_interrupts.S
@@ -256,11 +256,9 @@ kvm_handler BOOKE_INTERRUPT_DTLB_MISS, EX_PARAMS_TLB, \
 	SPRN_SRR0, SPRN_SRR1, (NEED_EMU | NEED_DEAR | NEED_ESR)
 kvm_handler BOOKE_INTERRUPT_ITLB_MISS, EX_PARAMS_TLB, \
 	SPRN_SRR0, SPRN_SRR1, 0
-kvm_handler BOOKE_INTERRUPT_SPE_UNAVAIL, EX_PARAMS(GEN), \
+kvm_handler BOOKE_INTERRUPT_ALTIVEC_UNAVAIL, EX_PARAMS(GEN), \
 	SPRN_SRR0, SPRN_SRR1, 0
-kvm_handler BOOKE_INTERRUPT_SPE_FP_DATA, EX_PARAMS(GEN), \
-	SPRN_SRR0, SPRN_SRR1, 0
-kvm_handler BOOKE_INTERRUPT_SPE_FP_ROUND, EX_PARAMS(GEN), \
+kvm_handler BOOKE_INTERRUPT_ALTIVEC_ASSIST, EX_PARAMS(GEN), \
 	SPRN_SRR0, SPRN_SRR1, 0
 kvm_handler BOOKE_INTERRUPT_PERFORMANCE_MONITOR, EX_PARAMS(GEN), \
 	SPRN_SRR0, SPRN_SRR1, 0
@@ -361,9 +359,6 @@ kvm_lvl_handler BOOKE_INTERRUPT_WATCHDOG, \
 kvm_handler BOOKE_INTERRUPT_DTLB_MISS, \
 	SPRN_SRR0, SPRN_SRR1, (NEED_EMU | NEED_DEAR | NEED_ESR)
 kvm_handler BOOKE_INTERRUPT_ITLB_MISS, SPRN_SRR0, SPRN_SRR1, 0
-kvm_handler BOOKE_INTERRUPT_SPE_UNAVAIL, SPRN_SRR0, SPRN_SRR1, 0
-kvm_handler BOOKE_INTERRUPT_SPE_FP_DATA, SPRN_SRR0, SPRN_SRR1, 0
-kvm_handler BOOKE_INTERRUPT_SPE_FP_ROUND, SPRN_SRR0, SPRN_SRR1, 0
 kvm_handler BOOKE_INTERRUPT_PERFORMANCE_MONITOR, SPRN_SRR0, SPRN_SRR1, 0
 kvm_handler BOOKE_INTERRUPT_DOORBELL, SPRN_SRR0, SPRN_SRR1, 0
 kvm_lvl_handler BOOKE_INTERRUPT_DOORBELL_CRITICAL, \
diff --git a/arch/powerpc/kvm/e500_emulate.c b/arch/powerpc/kvm/e500_emulate.c
index c99c40e..ce7291c 100644
--- a/arch/powerpc/kvm/e500_emulate.c
+++ b/arch/powerpc/kvm/e500_emulate.c
@@ -259,6 +259,7 @@ int kvmppc_core_emulate_mtspr_e500(struct kvm_vcpu *vcpu, int sprn, ulong spr_va
 		break;
 
 	/* extra exceptions */
+#ifdef CONFIG_SPE_POSSIBLE
 	case SPRN_IVOR32:
 		vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_UNAVAIL] = spr_val;
 		break;
@@ -268,6 +269,15 @@ int kvmppc_core_emulate_mtspr_e500(struct kvm_vcpu *vcpu, int sprn, ulong spr_va
 	case SPRN_IVOR34:
 		vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_FP_ROUND] = spr_val;
 		break;
+#endif
+#ifdef CONFIG_ALTIVEC
+	case SPRN_IVOR32:
+		vcpu->arch.ivor[BOOKE_IRQPRIO_ALTIVEC_UNAVAIL] = spr_val;
+		break;
+	case SPRN_IVOR33:
+		vcpu->arch.ivor[BOOKE_IRQPRIO_ALTIVEC_ASSIST] = spr_val;
+		break;
+#endif
 	case SPRN_IVOR35:
 		vcpu->arch.ivor[BOOKE_IRQPRIO_PERFORMANCE_MONITOR] = spr_val;
 		break;
@@ -381,6 +391,7 @@ int kvmppc_core_emulate_mfspr_e500(struct kvm_vcpu *vcpu, int sprn, ulong *spr_v
 		break;
 
 	/* extra exceptions */
+#ifdef CONFIG_SPE_POSSIBLE
 	case SPRN_IVOR32:
 		*spr_val = vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_UNAVAIL];
 		break;
@@ -390,6 +401,15 @@ int kvmppc_core_emulate_mfspr_e500(struct kvm_vcpu *vcpu, int sprn, ulong *spr_v
 	case SPRN_IVOR34:
 		*spr_val = vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_FP_ROUND];
 		break;
+#endif
+#ifdef CONFIG_ALTIVEC
+	case SPRN_IVOR32:
+		*spr_val = vcpu->arch.ivor[BOOKE_IRQPRIO_ALTIVEC_UNAVAIL];
+		break;
+	case SPRN_IVOR33:
+		*spr_val = vcpu->arch.ivor[BOOKE_IRQPRIO_ALTIVEC_ASSIST];
+		break;
+#endif
 	case SPRN_IVOR35:
 		*spr_val = vcpu->arch.ivor[BOOKE_IRQPRIO_PERFORMANCE_MONITOR];
 		break;
-- 
1.7.11.7
