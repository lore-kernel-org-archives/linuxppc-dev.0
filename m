Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vpYQZ2hd0zDq8x
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 15:26:14 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	linuxppc-dev@ozlabs.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH 1/5] KVM: PPC: Provide functions for queueing up FP/VEC/VSX
 unavailable interrupts
Date: Thu, 23 Mar 2017 15:25:59 +1100
Message-Id: <1490243163-19566-2-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1490243163-19566-1-git-send-email-paulus@ozlabs.org>
References: <1490243163-19566-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This provides functions that can be used for generating interrupts
indicating that a given functional unit (floating point, vector, or
VSX) is unavailable.  These functions will be used in instruction
emulation code.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/kvm_ppc.h |  3 +++
 arch/powerpc/kvm/book3s.c          | 18 ++++++++++++++++++
 arch/powerpc/kvm/booke.c           |  5 +++++
 3 files changed, 26 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index dd11c4c..4f1f22f 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -132,6 +132,9 @@ extern void kvmppc_core_vcpu_put(struct kvm_vcpu *vcpu);
 extern int kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcpu);
 extern int kvmppc_core_pending_dec(struct kvm_vcpu *vcpu);
 extern void kvmppc_core_queue_program(struct kvm_vcpu *vcpu, ulong flags);
+extern void kvmppc_core_queue_fpunavail(struct kvm_vcpu *vcpu);
+extern void kvmppc_core_queue_vec_unavail(struct kvm_vcpu *vcpu);
+extern void kvmppc_core_queue_vsx_unavail(struct kvm_vcpu *vcpu);
 extern void kvmppc_core_queue_dec(struct kvm_vcpu *vcpu);
 extern void kvmppc_core_dequeue_dec(struct kvm_vcpu *vcpu);
 extern void kvmppc_core_queue_external(struct kvm_vcpu *vcpu,
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index b6b5c18..0ff0d07 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -197,6 +197,24 @@ void kvmppc_core_queue_program(struct kvm_vcpu *vcpu, ulong flags)
 }
 EXPORT_SYMBOL_GPL(kvmppc_core_queue_program);
 
+void kvmppc_core_queue_fpunavail(struct kvm_vcpu *vcpu)
+{
+	/* might as well deliver this straight away */
+	kvmppc_inject_interrupt(vcpu, BOOK3S_INTERRUPT_FP_UNAVAIL, 0);
+}
+
+void kvmppc_core_queue_vec_unavail(struct kvm_vcpu *vcpu)
+{
+	/* might as well deliver this straight away */
+	kvmppc_inject_interrupt(vcpu, BOOK3S_INTERRUPT_ALTIVEC, 0);
+}
+
+void kvmppc_core_queue_vsx_unavail(struct kvm_vcpu *vcpu)
+{
+	/* might as well deliver this straight away */
+	kvmppc_inject_interrupt(vcpu, BOOK3S_INTERRUPT_VSX, 0);
+}
+
 void kvmppc_core_queue_dec(struct kvm_vcpu *vcpu)
 {
 	kvmppc_book3s_queue_irqprio(vcpu, BOOK3S_INTERRUPT_DECREMENTER);
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 0514cbd..3c296c2 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -300,6 +300,11 @@ void kvmppc_core_queue_program(struct kvm_vcpu *vcpu, ulong esr_flags)
 	kvmppc_booke_queue_irqprio(vcpu, BOOKE_IRQPRIO_PROGRAM);
 }
 
+void kvmppc_core_queue_fpunavail(struct kvm_vcpu *vcpu)
+{
+	kvmppc_booke_queue_irqprio(vcpu, BOOKE_IRQPRIO_FP_UNAVAIL);
+}
+
 void kvmppc_core_queue_dec(struct kvm_vcpu *vcpu)
 {
 	kvmppc_booke_queue_irqprio(vcpu, BOOKE_IRQPRIO_DECREMENTER);
-- 
2.7.4
