Return-Path: <mihai.caraman@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0189.outbound.protection.outlook.com [207.46.163.189])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B3D131A001A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Jul 2014 01:35:13 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 2/6 v2] KVM: PPC: Book3E: Refactor SPE/FP exit handling
Date: Mon, 30 Jun 2014 18:34:53 +0300
Message-ID: <1404142497-6430-3-git-send-email-mihai.caraman@freescale.com>
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

SPE/FP/AltiVec interrupts share the same numbers. Refactor SPE/FP exit handling
to accommodate AltiVec later on the same flow. Add kvmppc_supports_spe() to detect
suport for the unit at runtime since it can be configured in the kernel but not
featured on hardware and vice versa.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
v2:
 - enable SPE only if !HV && SPE

 arch/powerpc/kvm/booke.c | 93 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 60 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 3c86d9b..80cd8df 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -91,6 +91,15 @@ void kvmppc_dump_vcpu(struct kvm_vcpu *vcpu)
 	}
 }
 
+static inline bool kvmppc_supports_spe(void)
+{
+#ifdef CONFIG_SPE
+	if (cpu_has_feature(CPU_FTR_SPE))
+		return true;
+#endif
+	return false;
+}
+
 #ifdef CONFIG_SPE
 void kvmppc_vcpu_disable_spe(struct kvm_vcpu *vcpu)
 {
@@ -976,49 +985,67 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		r = RESUME_GUEST;
 		break;
 
-#ifdef CONFIG_SPE
 	case BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL: {
-		if (vcpu->arch.shared->msr & MSR_SPE)
-			kvmppc_vcpu_enable_spe(vcpu);
-		else
-			kvmppc_booke_queue_irqprio(vcpu,
-				BOOKE_IRQPRIO_SPE_ALTIVEC_UNAVAIL);
+		if (kvmppc_supports_spe()) {
+			bool enabled = false;
+
+#if !defined(CONFIG_KVM_BOOKE_HV) && defined(CONFIG_SPE)
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
-		kvmppc_booke_queue_irqprio(vcpu,
-			BOOKE_IRQPRIO_SPE_FP_DATA_ALTIVEC_ASSIST);
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
+			pr_crit("%s: unexpected SPE interrupt %u at %08lx\n",
+				__func__, exit_nr, vcpu->arch.pc);
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
+			pr_crit("%s: unexpected SPE interrupt %u at %08lx\n",
+			       __func__, exit_nr, vcpu->arch.pc);
+			run->hw.hardware_exit_reason = exit_nr;
+			r = RESUME_HOST;
+		}
 		break;
-#endif
 
 	case BOOKE_INTERRUPT_DATA_STORAGE:
 		kvmppc_core_queue_data_storage(vcpu, vcpu->arch.fault_dear,
-- 
1.7.11.7
