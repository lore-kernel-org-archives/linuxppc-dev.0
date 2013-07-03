Return-Path: <B02008@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 378A42C009C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 22:43:08 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 1/6] KVM: PPC: Book3E: Use common defines for SPE/FP/AltiVec
 int numbers
Date: Wed, 3 Jul 2013 15:42:34 +0300
Message-ID: <1372855359-13452-2-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1372855359-13452-1-git-send-email-mihai.caraman@freescale.com>
References: <1372855359-13452-1-git-send-email-mihai.caraman@freescale.com>
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
which share the same interrupts numbers.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/kvm/booke.c              |   16 ++++++++--------
 arch/powerpc/kvm/booke.h              |    4 ++--
 arch/powerpc/kvm/bookehv_interrupts.S |    8 ++++----
 arch/powerpc/kvm/e500.c               |   10 ++++++----
 arch/powerpc/kvm/e500_emulate.c       |    8 ++++----
 5 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index d2fef74..fb47e85 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -362,8 +362,8 @@ static int kvmppc_booke_irqprio_deliver(struct kvm_vcpu *vcpu,
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
@@ -944,18 +944,18 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		break;
 
 #ifdef CONFIG_SPE
-	case BOOKE_INTERRUPT_SPE_UNAVAIL: {
+	case BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL: {
 		if (vcpu->arch.shared->msr & MSR_SPE)
 			kvmppc_vcpu_enable_spe(vcpu);
 		else
 			kvmppc_booke_queue_irqprio(vcpu,
-						   BOOKE_IRQPRIO_SPE_UNAVAIL);
+						   BOOKE_IRQPRIO_SPE_ALTIVEC_UNAVAIL);
 		r = RESUME_GUEST;
 		break;
 	}
 
-	case BOOKE_INTERRUPT_SPE_FP_DATA:
-		kvmppc_booke_queue_irqprio(vcpu, BOOKE_IRQPRIO_SPE_FP_DATA);
+	case BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST:
+		kvmppc_booke_queue_irqprio(vcpu, BOOKE_IRQPRIO_SPE_FP_DATA_ALTIVEC_ASSIST);
 		r = RESUME_GUEST;
 		break;
 
@@ -964,7 +964,7 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		r = RESUME_GUEST;
 		break;
 #else
-	case BOOKE_INTERRUPT_SPE_UNAVAIL:
+	case BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL:
 		/*
 		 * Guest wants SPE, but host kernel doesn't support it.  Send
 		 * an "unimplemented operation" program check to the guest.
@@ -977,7 +977,7 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	 * These really should never happen without CONFIG_SPE,
 	 * as we should never enable the real MSR[SPE] in the guest.
 	 */
-	case BOOKE_INTERRUPT_SPE_FP_DATA:
+	case BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST:
 	case BOOKE_INTERRUPT_SPE_FP_ROUND:
 		printk(KERN_CRIT "%s: unexpected SPE interrupt %u at %08lx\n",
 		       __func__, exit_nr, vcpu->arch.pc);
diff --git a/arch/powerpc/kvm/booke.h b/arch/powerpc/kvm/booke.h
index 5fd1ba6..9e92006 100644
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
diff --git a/arch/powerpc/kvm/bookehv_interrupts.S b/arch/powerpc/kvm/bookehv_interrupts.S
index e8ed7d6..8d35dc0 100644
--- a/arch/powerpc/kvm/bookehv_interrupts.S
+++ b/arch/powerpc/kvm/bookehv_interrupts.S
@@ -295,9 +295,9 @@ kvm_handler BOOKE_INTERRUPT_DTLB_MISS, EX_PARAMS_TLB, \
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
@@ -398,8 +398,8 @@ kvm_lvl_handler BOOKE_INTERRUPT_WATCHDOG, \
 kvm_handler BOOKE_INTERRUPT_DTLB_MISS, \
 	SPRN_SRR0, SPRN_SRR1, (NEED_EMU | NEED_DEAR | NEED_ESR)
 kvm_handler BOOKE_INTERRUPT_ITLB_MISS, SPRN_SRR0, SPRN_SRR1, 0
-kvm_handler BOOKE_INTERRUPT_SPE_UNAVAIL, SPRN_SRR0, SPRN_SRR1, 0
-kvm_handler BOOKE_INTERRUPT_SPE_FP_DATA, SPRN_SRR0, SPRN_SRR1, 0
+kvm_handler BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL, SPRN_SRR0, SPRN_SRR1, 0
+kvm_handler BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST, SPRN_SRR0, SPRN_SRR1, 0
 kvm_handler BOOKE_INTERRUPT_SPE_FP_ROUND, SPRN_SRR0, SPRN_SRR1, 0
 kvm_handler BOOKE_INTERRUPT_PERFORMANCE_MONITOR, SPRN_SRR0, SPRN_SRR1, 0
 kvm_handler BOOKE_INTERRUPT_DOORBELL, SPRN_SRR0, SPRN_SRR1, 0
diff --git a/arch/powerpc/kvm/e500.c b/arch/powerpc/kvm/e500.c
index ce6b73c..0fb2f4d 100644
--- a/arch/powerpc/kvm/e500.c
+++ b/arch/powerpc/kvm/e500.c
@@ -380,8 +380,10 @@ void kvmppc_core_get_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
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
@@ -409,9 +411,9 @@ int kvmppc_core_set_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
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
index b10a012..b2e159b 100644
--- a/arch/powerpc/kvm/e500_emulate.c
+++ b/arch/powerpc/kvm/e500_emulate.c
@@ -211,10 +211,10 @@ int kvmppc_core_emulate_mtspr(struct kvm_vcpu *vcpu, int sprn, ulong spr_val)
 
 	/* extra exceptions */
 	case SPRN_IVOR32:
-		vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_UNAVAIL] = spr_val;
+		vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_ALTIVEC_UNAVAIL] = spr_val;
 		break;
 	case SPRN_IVOR33:
-		vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_FP_DATA] = spr_val;
+		vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_FP_DATA_ALTIVEC_ASSIST] = spr_val;
 		break;
 	case SPRN_IVOR34:
 		vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_FP_ROUND] = spr_val;
@@ -329,10 +329,10 @@ int kvmppc_core_emulate_mfspr(struct kvm_vcpu *vcpu, int sprn, ulong *spr_val)
 
 	/* extra exceptions */
 	case SPRN_IVOR32:
-		*spr_val = vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_UNAVAIL];
+		*spr_val = vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_ALTIVEC_UNAVAIL];
 		break;
 	case SPRN_IVOR33:
-		*spr_val = vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_FP_DATA];
+		*spr_val = vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_FP_DATA_ALTIVEC_ASSIST];
 		break;
 	case SPRN_IVOR34:
 		*spr_val = vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_FP_ROUND];
-- 
1.7.3.4
