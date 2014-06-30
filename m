Return-Path: <mihai.caraman@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0186.outbound.protection.outlook.com [207.46.163.186])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B1F5E1A0019
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Jul 2014 01:35:13 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 1/6 v2] KVM: PPC: Book3E: Use common defines for
 SPE/FP/AltiVec int numbers
Date: Mon, 30 Jun 2014 18:34:52 +0300
Message-ID: <1404142497-6430-2-git-send-email-mihai.caraman@freescale.com>
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

Use common BOOKE_IRQPRIO and BOOKE_INTERRUPT defines for SPE/FP/AltiVec
which share the same interrupt numbers.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
v2:
 - remove outdated definitions

 arch/powerpc/include/asm/kvm_asm.h    |  8 --------
 arch/powerpc/kvm/booke.c              | 17 +++++++++--------
 arch/powerpc/kvm/booke.h              |  4 ++--
 arch/powerpc/kvm/booke_interrupts.S   |  9 +++++----
 arch/powerpc/kvm/bookehv_interrupts.S |  4 ++--
 arch/powerpc/kvm/e500.c               | 10 ++++++----
 arch/powerpc/kvm/e500_emulate.c       | 10 ++++++----
 7 files changed, 30 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_asm.h b/arch/powerpc/include/asm/kvm_asm.h
index 9601741..c94fd33 100644
--- a/arch/powerpc/include/asm/kvm_asm.h
+++ b/arch/powerpc/include/asm/kvm_asm.h
@@ -56,14 +56,6 @@
 /* E500 */
 #define BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL 32
 #define BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST 33
-/*
- * TODO: Unify 32-bit and 64-bit kernel exception handlers to use same defines
- */
-#define BOOKE_INTERRUPT_SPE_UNAVAIL BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL
-#define BOOKE_INTERRUPT_SPE_FP_DATA BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST
-#define BOOKE_INTERRUPT_ALTIVEC_UNAVAIL BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL
-#define BOOKE_INTERRUPT_ALTIVEC_ASSIST \
-				BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST
 #define BOOKE_INTERRUPT_SPE_FP_ROUND 34
 #define BOOKE_INTERRUPT_PERFORMANCE_MONITOR 35
 #define BOOKE_INTERRUPT_DOORBELL 36
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index ab62109..3c86d9b 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -388,8 +388,8 @@ static int kvmppc_booke_irqprio_deliver(struct kvm_vcpu *vcpu,
 	case BOOKE_IRQPRIO_ITLB_MISS:
 	case BOOKE_IRQPRIO_SYSCALL:
 	case BOOKE_IRQPRIO_FP_UNAVAIL:
-	case BOOKE_IRQPRIO_SPE_UNAVAIL:
-	case BOOKE_IRQPRIO_SPE_FP_DATA:
+	case BOOKE_IRQPRIO_SPE_ALTIVEC_UNAVAIL:
+	case BOOKE_IRQPRIO_SPE_FP_DATA_ALTIVEC_ASSIST:
 	case BOOKE_IRQPRIO_SPE_FP_ROUND:
 	case BOOKE_IRQPRIO_AP_UNAVAIL:
 		allowed = 1;
@@ -977,18 +977,19 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		break;
 
 #ifdef CONFIG_SPE
-	case BOOKE_INTERRUPT_SPE_UNAVAIL: {
+	case BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL: {
 		if (vcpu->arch.shared->msr & MSR_SPE)
 			kvmppc_vcpu_enable_spe(vcpu);
 		else
 			kvmppc_booke_queue_irqprio(vcpu,
-						   BOOKE_IRQPRIO_SPE_UNAVAIL);
+				BOOKE_IRQPRIO_SPE_ALTIVEC_UNAVAIL);
 		r = RESUME_GUEST;
 		break;
 	}
 
-	case BOOKE_INTERRUPT_SPE_FP_DATA:
-		kvmppc_booke_queue_irqprio(vcpu, BOOKE_IRQPRIO_SPE_FP_DATA);
+	case BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST:
+		kvmppc_booke_queue_irqprio(vcpu,
+			BOOKE_IRQPRIO_SPE_FP_DATA_ALTIVEC_ASSIST);
 		r = RESUME_GUEST;
 		break;
 
@@ -997,7 +998,7 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		r = RESUME_GUEST;
 		break;
 #else
-	case BOOKE_INTERRUPT_SPE_UNAVAIL:
+	case BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL:
 		/*
 		 * Guest wants SPE, but host kernel doesn't support it.  Send
 		 * an "unimplemented operation" program check to the guest.
@@ -1010,7 +1011,7 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	 * These really should never happen without CONFIG_SPE,
 	 * as we should never enable the real MSR[SPE] in the guest.
 	 */
-	case BOOKE_INTERRUPT_SPE_FP_DATA:
+	case BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST:
 	case BOOKE_INTERRUPT_SPE_FP_ROUND:
 		printk(KERN_CRIT "%s: unexpected SPE interrupt %u at %08lx\n",
 		       __func__, exit_nr, vcpu->arch.pc);
diff --git a/arch/powerpc/kvm/booke.h b/arch/powerpc/kvm/booke.h
index b632cd3..f182b32 100644
--- a/arch/powerpc/kvm/booke.h
+++ b/arch/powerpc/kvm/booke.h
@@ -32,8 +32,8 @@
 #define BOOKE_IRQPRIO_ALIGNMENT 2
 #define BOOKE_IRQPRIO_PROGRAM 3
 #define BOOKE_IRQPRIO_FP_UNAVAIL 4
-#define BOOKE_IRQPRIO_SPE_UNAVAIL 5
-#define BOOKE_IRQPRIO_SPE_FP_DATA 6
+#define BOOKE_IRQPRIO_SPE_ALTIVEC_UNAVAIL 5
+#define BOOKE_IRQPRIO_SPE_FP_DATA_ALTIVEC_ASSIST 6
 #define BOOKE_IRQPRIO_SPE_FP_ROUND 7
 #define BOOKE_IRQPRIO_SYSCALL 8
 #define BOOKE_IRQPRIO_AP_UNAVAIL 9
diff --git a/arch/powerpc/kvm/booke_interrupts.S b/arch/powerpc/kvm/booke_interrupts.S
index 2c6deb5ef..a275dc5 100644
--- a/arch/powerpc/kvm/booke_interrupts.S
+++ b/arch/powerpc/kvm/booke_interrupts.S
@@ -137,8 +137,9 @@ KVM_HANDLER BOOKE_INTERRUPT_WATCHDOG SPRN_SPRG_RSCRATCH_CRIT SPRN_CSRR0
 KVM_HANDLER BOOKE_INTERRUPT_DTLB_MISS SPRN_SPRG_RSCRATCH0 SPRN_SRR0
 KVM_HANDLER BOOKE_INTERRUPT_ITLB_MISS SPRN_SPRG_RSCRATCH0 SPRN_SRR0
 KVM_DBG_HANDLER BOOKE_INTERRUPT_DEBUG SPRN_SPRG_RSCRATCH_CRIT SPRN_CSRR0
-KVM_HANDLER BOOKE_INTERRUPT_SPE_UNAVAIL SPRN_SPRG_RSCRATCH0 SPRN_SRR0
-KVM_HANDLER BOOKE_INTERRUPT_SPE_FP_DATA SPRN_SPRG_RSCRATCH0 SPRN_SRR0
+KVM_HANDLER BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL SPRN_SPRG_RSCRATCH0 SPRN_SRR0
+KVM_HANDLER BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST SPRN_SPRG_RSCRATCH0 \
+	SPRN_SRR0
 KVM_HANDLER BOOKE_INTERRUPT_SPE_FP_ROUND SPRN_SPRG_RSCRATCH0 SPRN_SRR0
 _GLOBAL(kvmppc_handlers_end)
 
@@ -525,8 +526,8 @@ KVM_HANDLER_ADDR BOOKE_INTERRUPT_WATCHDOG
 KVM_HANDLER_ADDR BOOKE_INTERRUPT_DTLB_MISS
 KVM_HANDLER_ADDR BOOKE_INTERRUPT_ITLB_MISS
 KVM_HANDLER_ADDR BOOKE_INTERRUPT_DEBUG
-KVM_HANDLER_ADDR BOOKE_INTERRUPT_SPE_UNAVAIL
-KVM_HANDLER_ADDR BOOKE_INTERRUPT_SPE_FP_DATA
+KVM_HANDLER_ADDR BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL
+KVM_HANDLER_ADDR BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST
 KVM_HANDLER_ADDR BOOKE_INTERRUPT_SPE_FP_ROUND
 KVM_HANDLER_END /*Always keep this in end*/
 
diff --git a/arch/powerpc/kvm/bookehv_interrupts.S b/arch/powerpc/kvm/bookehv_interrupts.S
index a1712b8..ff73143 100644
--- a/arch/powerpc/kvm/bookehv_interrupts.S
+++ b/arch/powerpc/kvm/bookehv_interrupts.S
@@ -300,9 +300,9 @@ kvm_handler BOOKE_INTERRUPT_DTLB_MISS, EX_PARAMS_TLB, \
 	SPRN_SRR0, SPRN_SRR1, (NEED_EMU | NEED_DEAR | NEED_ESR)
 kvm_handler BOOKE_INTERRUPT_ITLB_MISS, EX_PARAMS_TLB, \
 	SPRN_SRR0, SPRN_SRR1, 0
-kvm_handler BOOKE_INTERRUPT_SPE_UNAVAIL, EX_PARAMS(GEN), \
+kvm_handler BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL, EX_PARAMS(GEN), \
 	SPRN_SRR0, SPRN_SRR1, 0
-kvm_handler BOOKE_INTERRUPT_SPE_FP_DATA, EX_PARAMS(GEN), \
+kvm_handler BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST, EX_PARAMS(GEN), \
 	SPRN_SRR0, SPRN_SRR1, 0
 kvm_handler BOOKE_INTERRUPT_SPE_FP_ROUND, EX_PARAMS(GEN), \
 	SPRN_SRR0, SPRN_SRR1, 0
diff --git a/arch/powerpc/kvm/e500.c b/arch/powerpc/kvm/e500.c
index 2e02ed8..3c1a30d 100644
--- a/arch/powerpc/kvm/e500.c
+++ b/arch/powerpc/kvm/e500.c
@@ -383,8 +383,10 @@ static int kvmppc_core_get_sregs_e500(struct kvm_vcpu *vcpu,
 	sregs->u.e.impl.fsl.hid0 = vcpu_e500->hid0;
 	sregs->u.e.impl.fsl.mcar = vcpu_e500->mcar;
 
-	sregs->u.e.ivor_high[0] = vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_UNAVAIL];
-	sregs->u.e.ivor_high[1] = vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_FP_DATA];
+	sregs->u.e.ivor_high[0] =
+		vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_ALTIVEC_UNAVAIL];
+	sregs->u.e.ivor_high[1] =
+		vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_FP_DATA_ALTIVEC_ASSIST];
 	sregs->u.e.ivor_high[2] = vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_FP_ROUND];
 	sregs->u.e.ivor_high[3] =
 		vcpu->arch.ivor[BOOKE_IRQPRIO_PERFORMANCE_MONITOR];
@@ -414,9 +416,9 @@ static int kvmppc_core_set_sregs_e500(struct kvm_vcpu *vcpu,
 		return 0;
 
 	if (sregs->u.e.features & KVM_SREGS_E_SPE) {
-		vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_UNAVAIL] =
+		vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_ALTIVEC_UNAVAIL] =
 			sregs->u.e.ivor_high[0];
-		vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_FP_DATA] =
+		vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_FP_DATA_ALTIVEC_ASSIST] =
 			sregs->u.e.ivor_high[1];
 		vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_FP_ROUND] =
 			sregs->u.e.ivor_high[2];
diff --git a/arch/powerpc/kvm/e500_emulate.c b/arch/powerpc/kvm/e500_emulate.c
index 98a22e5..6a6833f 100644
--- a/arch/powerpc/kvm/e500_emulate.c
+++ b/arch/powerpc/kvm/e500_emulate.c
@@ -256,10 +256,11 @@ int kvmppc_core_emulate_mtspr_e500(struct kvm_vcpu *vcpu, int sprn, ulong spr_va
 
 	/* extra exceptions */
 	case SPRN_IVOR32:
-		vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_UNAVAIL] = spr_val;
+		vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_ALTIVEC_UNAVAIL] = spr_val;
 		break;
 	case SPRN_IVOR33:
-		vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_FP_DATA] = spr_val;
+		vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_FP_DATA_ALTIVEC_ASSIST] =
+			spr_val;
 		break;
 	case SPRN_IVOR34:
 		vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_FP_ROUND] = spr_val;
@@ -378,10 +379,11 @@ int kvmppc_core_emulate_mfspr_e500(struct kvm_vcpu *vcpu, int sprn, ulong *spr_v
 
 	/* extra exceptions */
 	case SPRN_IVOR32:
-		*spr_val = vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_UNAVAIL];
+		*spr_val = vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_ALTIVEC_UNAVAIL];
 		break;
 	case SPRN_IVOR33:
-		*spr_val = vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_FP_DATA];
+		*spr_val =
+		    vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_FP_DATA_ALTIVEC_ASSIST];
 		break;
 	case SPRN_IVOR34:
 		*spr_val = vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_FP_ROUND];
-- 
1.7.11.7
