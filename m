Return-Path: <mihai.caraman@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0189.outbound.protection.outlook.com [207.46.163.189])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2EB661A005E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Jul 2014 01:35:16 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 3/6 v2] KVM: PPC: Book3E: Increase FPU laziness
Date: Mon, 30 Jun 2014 18:34:54 +0300
Message-ID: <1404142497-6430-4-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1404142497-6430-1-git-send-email-mihai.caraman@freescale.com>
References: <1404142497-6430-1-git-send-email-mihai.caraman@freescale.com>
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

Increase FPU laziness by calling kvmppc_load_guest_fp() just before
returning to guest instead of each sched in. Without this improvement
an interrupt may also claim floting point corrupting guest state.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
v2:
 - remove fpu_active
 - add descriptive comments

 arch/powerpc/kvm/booke.c  | 43 ++++++++++++++++++++++++++++++++++++-------
 arch/powerpc/kvm/booke.h  | 34 ----------------------------------
 arch/powerpc/kvm/e500mc.c |  2 --
 3 files changed, 36 insertions(+), 43 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 80cd8df..4cc9b26 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -134,6 +134,40 @@ static void kvmppc_vcpu_sync_spe(struct kvm_vcpu *vcpu)
 }
 #endif
 
+/*
+ * Load up guest vcpu FP state if it's needed.
+ * It also set the MSR_FP in thread so that host know
+ * we're holding FPU, and then host can help to save
+ * guest vcpu FP state if other threads require to use FPU.
+ * This simulates an FP unavailable fault.
+ *
+ * It requires to be called with preemption disabled.
+ */
+static inline void kvmppc_load_guest_fp(struct kvm_vcpu *vcpu)
+{
+#ifdef CONFIG_PPC_FPU
+	if (!(current->thread.regs->msr & MSR_FP)) {
+		enable_kernel_fp();
+		load_fp_state(&vcpu->arch.fp);
+		current->thread.fp_save_area = &vcpu->arch.fp;
+		current->thread.regs->msr |= MSR_FP;
+	}
+#endif
+}
+
+/*
+ * Save guest vcpu FP state into thread.
+ * It requires to be called with preemption disabled.
+ */
+static inline void kvmppc_save_guest_fp(struct kvm_vcpu *vcpu)
+{
+#ifdef CONFIG_PPC_FPU
+	if (current->thread.regs->msr & MSR_FP)
+		giveup_fpu(current);
+	current->thread.fp_save_area = NULL;
+#endif
+}
+
 static void kvmppc_vcpu_sync_fpu(struct kvm_vcpu *vcpu)
 {
 #if defined(CONFIG_PPC_FPU) && !defined(CONFIG_KVM_BOOKE_HV)
@@ -710,12 +744,8 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 
 	/*
 	 * Since we can't trap on MSR_FP in GS-mode, we consider the guest
-	 * as always using the FPU.  Kernel usage of FP (via
-	 * enable_kernel_fp()) in this thread must not occur while
-	 * vcpu->fpu_active is set.
+	 * as always using the FPU.
 	 */
-	vcpu->fpu_active = 1;
-
 	kvmppc_load_guest_fp(vcpu);
 #endif
 
@@ -739,8 +769,6 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 
 #ifdef CONFIG_PPC_FPU
 	kvmppc_save_guest_fp(vcpu);
-
-	vcpu->fpu_active = 0;
 #endif
 
 out:
@@ -1220,6 +1248,7 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		else {
 			/* interrupts now hard-disabled */
 			kvmppc_fix_ee_before_entry();
+			kvmppc_load_guest_fp(vcpu);
 		}
 	}
 
diff --git a/arch/powerpc/kvm/booke.h b/arch/powerpc/kvm/booke.h
index f182b32..faad8af 100644
--- a/arch/powerpc/kvm/booke.h
+++ b/arch/powerpc/kvm/booke.h
@@ -123,40 +123,6 @@ extern int kvmppc_core_emulate_mtspr_e500(struct kvm_vcpu *vcpu, int sprn,
 extern int kvmppc_core_emulate_mfspr_e500(struct kvm_vcpu *vcpu, int sprn,
 					  ulong *spr_val);
 
-/*
- * Load up guest vcpu FP state if it's needed.
- * It also set the MSR_FP in thread so that host know
- * we're holding FPU, and then host can help to save
- * guest vcpu FP state if other threads require to use FPU.
- * This simulates an FP unavailable fault.
- *
- * It requires to be called with preemption disabled.
- */
-static inline void kvmppc_load_guest_fp(struct kvm_vcpu *vcpu)
-{
-#ifdef CONFIG_PPC_FPU
-	if (vcpu->fpu_active && !(current->thread.regs->msr & MSR_FP)) {
-		enable_kernel_fp();
-		load_fp_state(&vcpu->arch.fp);
-		current->thread.fp_save_area = &vcpu->arch.fp;
-		current->thread.regs->msr |= MSR_FP;
-	}
-#endif
-}
-
-/*
- * Save guest vcpu FP state into thread.
- * It requires to be called with preemption disabled.
- */
-static inline void kvmppc_save_guest_fp(struct kvm_vcpu *vcpu)
-{
-#ifdef CONFIG_PPC_FPU
-	if (vcpu->fpu_active && (current->thread.regs->msr & MSR_FP))
-		giveup_fpu(current);
-	current->thread.fp_save_area = NULL;
-#endif
-}
-
 static inline void kvmppc_clear_dbsr(void)
 {
 	mtspr(SPRN_DBSR, mfspr(SPRN_DBSR));
diff --git a/arch/powerpc/kvm/e500mc.c b/arch/powerpc/kvm/e500mc.c
index 690499d..c60b653 100644
--- a/arch/powerpc/kvm/e500mc.c
+++ b/arch/powerpc/kvm/e500mc.c
@@ -145,8 +145,6 @@ static void kvmppc_core_vcpu_load_e500mc(struct kvm_vcpu *vcpu, int cpu)
 		kvmppc_e500_tlbil_all(vcpu_e500);
 		__get_cpu_var(last_vcpu_of_lpid)[vcpu->kvm->arch.lpid] = vcpu;
 	}
-
-	kvmppc_load_guest_fp(vcpu);
 }
 
 static void kvmppc_core_vcpu_put_e500mc(struct kvm_vcpu *vcpu)
-- 
1.7.11.7
