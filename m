Return-Path: <B02008@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 516C32C02FD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Jun 2013 06:54:50 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [RFC PATCH 2/6] KVM: PPC: Book3E: Refactor SPE_FP exit handling
Date: Mon, 3 Jun 2013 23:54:24 +0300
Message-ID: <1370292868-2697-3-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1370292868-2697-1-git-send-email-mihai.caraman@freescale.com>
References: <1370292868-2697-1-git-send-email-mihai.caraman@freescale.com>
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

SPE_FP interrupts are shared with ALTIVEC. Refactor SPE_FP exit handling
to detect KVM support for the featured unit at run-time, in order to
accommodate ALTIVEC later.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/kvm/booke.c |   80 ++++++++++++++++++++++++++++++++++------------
 1 files changed, 59 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 1020119..d082bbc 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -822,6 +822,15 @@ static void kvmppc_restart_interrupt(struct kvm_vcpu *vcpu,
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
 /**
  * kvmppc_handle_exit
  *
@@ -931,42 +940,71 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		r = RESUME_GUEST;
 		break;
 
-#ifdef CONFIG_SPE
 	case BOOKE_INTERRUPT_SPE_UNAVAIL: {
-		if (vcpu->arch.shared->msr & MSR_SPE)
-			kvmppc_vcpu_enable_spe(vcpu);
-		else
-			kvmppc_booke_queue_irqprio(vcpu,
-						   BOOKE_IRQPRIO_SPE_UNAVAIL);
+		/*
+		 * The interrupt is shared, KVM support for the featured unit
+		 * is detected at run-time.
+		 */
+		bool handled = false;
+
+		if (kvmppc_supports_spe()) {
+#ifdef CONFIG_SPE
+			if (cpu_has_feature(CPU_FTR_SPE))
+				if (vcpu->arch.shared->msr & MSR_SPE) {
+					kvmppc_vcpu_enable_spe(vcpu);
+					handled = true;
+				}
+#endif
+			if (!handled)
+				kvmppc_booke_queue_irqprio(vcpu,
+					BOOKE_IRQPRIO_SPE_UNAVAIL);
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
 
 	case BOOKE_INTERRUPT_SPE_FP_DATA:
-		kvmppc_booke_queue_irqprio(vcpu, BOOKE_IRQPRIO_SPE_FP_DATA);
-		r = RESUME_GUEST;
+		/*
+		 * The interrupt is shared, KVM support for the featured unit
+		 * is detected at run-time.
+		 */
+		if (kvmppc_supports_spe()) {
+			kvmppc_booke_queue_irqprio(vcpu,
+				BOOKE_IRQPRIO_SPE_FP_DATA);
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
+
 		break;
 
 	case BOOKE_INTERRUPT_SPE_FP_ROUND:
+#ifdef CONFIG_SPE
 		kvmppc_booke_queue_irqprio(vcpu, BOOKE_IRQPRIO_SPE_FP_ROUND);
 		r = RESUME_GUEST;
 		break;
 #else
-	case BOOKE_INTERRUPT_SPE_UNAVAIL:
 		/*
-		 * Guest wants SPE, but host kernel doesn't support it.  Send
-		 * an "unimplemented operation" program check to the guest.
+		 * These really should never happen without CONFIG_SPE,
+		 * as we should never enable the real MSR[SPE] in the
+		 * guest.
 		 */
-		kvmppc_core_queue_program(vcpu, ESR_PUO | ESR_SPV);
-		r = RESUME_GUEST;
-		break;
-
-	/*
-	 * These really should never happen without CONFIG_SPE,
-	 * as we should never enable the real MSR[SPE] in the guest.
-	 */
-	case BOOKE_INTERRUPT_SPE_FP_DATA:
-	case BOOKE_INTERRUPT_SPE_FP_ROUND:
 		printk(KERN_CRIT "%s: unexpected SPE interrupt %u at %08lx\n",
 		       __func__, exit_nr, vcpu->arch.pc);
 		run->hw.hardware_exit_reason = exit_nr;
-- 
1.7.4.1
