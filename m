Return-Path: <B02008@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AC0E52C0357
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 22:43:46 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 2/6] KVM: PPC: Book3E: Refactor SPE/FP exit handling
Date: Wed, 3 Jul 2013 15:42:35 +0300
Message-ID: <1372855359-13452-3-git-send-email-mihai.caraman@freescale.com>
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

SPE/FP/AltiVec interrupts share the same numbers. Refactor SPE/FP exit handling
to accommodate AltiVec later. Detect the targeted unit at run time since it can
be configured in the kernel but not featured on hardware.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/kvm/booke.c |  102 +++++++++++++++++++++++++++++++---------------
 arch/powerpc/kvm/booke.h |    1 +
 2 files changed, 70 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index fb47e85..113961f 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -89,6 +89,15 @@ void kvmppc_dump_vcpu(struct kvm_vcpu *vcpu)
 	}
 }
 
+static inline bool kvmppc_supports_spe(void)
+{
+#ifdef CONFIG_SPE
+		if (cpu_has_feature(CPU_FTR_SPE))
+			return true;
+#endif
+	return false;
+}
+
 #ifdef CONFIG_SPE
 void kvmppc_vcpu_disable_spe(struct kvm_vcpu *vcpu)
 {
@@ -99,7 +108,7 @@ void kvmppc_vcpu_disable_spe(struct kvm_vcpu *vcpu)
 	preempt_enable();
 }
 
-static void kvmppc_vcpu_enable_spe(struct kvm_vcpu *vcpu)
+void kvmppc_vcpu_enable_spe(struct kvm_vcpu *vcpu)
 {
 	preempt_disable();
 	enable_kernel_spe();
@@ -118,6 +127,14 @@ static void kvmppc_vcpu_sync_spe(struct kvm_vcpu *vcpu)
 	}
 }
 #else
+void kvmppc_vcpu_disable_spe(struct kvm_vcpu *vcpu)
+{
+}
+
+void kvmppc_vcpu_enable_spe(struct kvm_vcpu *vcpu)
+{
+}
+
 static void kvmppc_vcpu_sync_spe(struct kvm_vcpu *vcpu)
 {
 }
@@ -943,48 +960,67 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		r = RESUME_GUEST;
 		break;
 
-#ifdef CONFIG_SPE
 	case BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL: {
-		if (vcpu->arch.shared->msr & MSR_SPE)
-			kvmppc_vcpu_enable_spe(vcpu);
-		else
-			kvmppc_booke_queue_irqprio(vcpu,
-						   BOOKE_IRQPRIO_SPE_ALTIVEC_UNAVAIL);
+		if (kvmppc_supports_spe()) {
+			bool enabled = false;
+
+#ifndef CONFIG_KVM_BOOKE_HV
+			if (vcpu->arch.shared->msr & MSR_SPE) {
+				kvmppc_vcpu_enable_spe(vcpu);
+				enabled = true;
+			}
+#endif
+			if (!enabled)
+				kvmppc_booke_queue_irqprio(vcpu,
+					BOOKE_IRQPRIO_SPE_ALTIVEC_UNAVAIL);
+		} else {
+			/*
+			 * Guest wants SPE, but host kernel doesn't support it.
+			 * Send an "unimplemented operation" program check to
+			 * the guest.
+			 */
+			kvmppc_core_queue_program(vcpu, ESR_PUO | ESR_SPV);
+		}
+
 		r = RESUME_GUEST;
 		break;
 	}
 
 	case BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST:
-		kvmppc_booke_queue_irqprio(vcpu, BOOKE_IRQPRIO_SPE_FP_DATA_ALTIVEC_ASSIST);
-		r = RESUME_GUEST;
-		break;
-
-	case BOOKE_INTERRUPT_SPE_FP_ROUND:
-		kvmppc_booke_queue_irqprio(vcpu, BOOKE_IRQPRIO_SPE_FP_ROUND);
-		r = RESUME_GUEST;
-		break;
-#else
-	case BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL:
-		/*
-		 * Guest wants SPE, but host kernel doesn't support it.  Send
-		 * an "unimplemented operation" program check to the guest.
-		 */
-		kvmppc_core_queue_program(vcpu, ESR_PUO | ESR_SPV);
-		r = RESUME_GUEST;
+		if (kvmppc_supports_spe()) {
+			kvmppc_booke_queue_irqprio(vcpu,
+				BOOKE_IRQPRIO_SPE_FP_DATA_ALTIVEC_ASSIST);
+			r = RESUME_GUEST;
+		} else {
+			/*
+			 * These really should never happen without CONFIG_SPE,
+			 * as we should never enable the real MSR[SPE] in the
+			 * guest.
+			 */
+			printk(KERN_CRIT "%s: unexpected SPE interrupt %u at \
+				%08lx\n", __func__, exit_nr, vcpu->arch.pc);
+			run->hw.hardware_exit_reason = exit_nr;
+			r = RESUME_HOST;
+		}
 		break;
 
-	/*
-	 * These really should never happen without CONFIG_SPE,
-	 * as we should never enable the real MSR[SPE] in the guest.
-	 */
-	case BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST:
 	case BOOKE_INTERRUPT_SPE_FP_ROUND:
-		printk(KERN_CRIT "%s: unexpected SPE interrupt %u at %08lx\n",
-		       __func__, exit_nr, vcpu->arch.pc);
-		run->hw.hardware_exit_reason = exit_nr;
-		r = RESUME_HOST;
+		if (kvmppc_supports_spe()) {
+			kvmppc_booke_queue_irqprio(vcpu,
+				BOOKE_IRQPRIO_SPE_FP_ROUND);
+			r = RESUME_GUEST;
+		} else {
+			/*
+			 * These really should never happen without CONFIG_SPE,
+			 * as we should never enable the real MSR[SPE] in the
+			 * guest.
+			 */
+			printk(KERN_CRIT "%s: unexpected SPE interrupt %u at %08lx\n",
+			       __func__, exit_nr, vcpu->arch.pc);
+			run->hw.hardware_exit_reason = exit_nr;
+			r = RESUME_HOST;
+		}
 		break;
-#endif
 
 	case BOOKE_INTERRUPT_DATA_STORAGE:
 		kvmppc_core_queue_data_storage(vcpu, vcpu->arch.fault_dear,
diff --git a/arch/powerpc/kvm/booke.h b/arch/powerpc/kvm/booke.h
index 9e92006..e92ce5b 100644
--- a/arch/powerpc/kvm/booke.h
+++ b/arch/powerpc/kvm/booke.h
@@ -85,6 +85,7 @@ void kvmppc_load_guest_spe(struct kvm_vcpu *vcpu);
 void kvmppc_save_guest_spe(struct kvm_vcpu *vcpu);
 
 /* high-level function, manages flags, host state */
+void kvmppc_vcpu_enable_spe(struct kvm_vcpu *vcpu);
 void kvmppc_vcpu_disable_spe(struct kvm_vcpu *vcpu);
 
 void kvmppc_booke_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
-- 
1.7.3.4
