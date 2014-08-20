Return-Path: <mihai.caraman@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0244.outbound.protection.outlook.com [207.46.163.244])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 705761A0162
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 23:36:46 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH v4 1/6] KVM: PPC: Book3E: Increase FPU laziness
Date: Wed, 20 Aug 2014 16:36:22 +0300
Message-ID: <1408541787-24625-2-git-send-email-mihai.caraman@freescale.com>
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

Increase FPU laziness by loading the guest state into the unit before entering
the guest instead of doing it on each vcpu schedule. Without this improvement
an interrupt may claim floating point corrupting guest state.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
v4:
 - update commit message

v3:
 - no changes

v2:
 - remove fpu_active
 - add descriptive comments

 arch/powerpc/kvm/booke.c  | 43 ++++++++++++++++++++++++++++++++++++-------
 arch/powerpc/kvm/booke.h  | 34 ----------------------------------
 arch/powerpc/kvm/e500mc.c |  2 --
 3 files changed, 36 insertions(+), 43 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 074b7fc..91e7217 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -124,6 +124,40 @@ static void kvmppc_vcpu_sync_spe(struct kvm_vcpu *vcpu)
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
@@ -658,12 +692,8 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 
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
 
@@ -687,8 +717,6 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 
 #ifdef CONFIG_PPC_FPU
 	kvmppc_save_guest_fp(vcpu);
-
-	vcpu->fpu_active = 0;
 #endif
 
 out:
@@ -1194,6 +1222,7 @@ out:
 		else {
 			/* interrupts now hard-disabled */
 			kvmppc_fix_ee_before_entry();
+			kvmppc_load_guest_fp(vcpu);
 		}
 	}
 
diff --git a/arch/powerpc/kvm/booke.h b/arch/powerpc/kvm/booke.h
index f753543..e73d513 100644
--- a/arch/powerpc/kvm/booke.h
+++ b/arch/powerpc/kvm/booke.h
@@ -116,40 +116,6 @@ extern int kvmppc_core_emulate_mtspr_e500(struct kvm_vcpu *vcpu, int sprn,
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
index 000cf82..4549349 100644
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
