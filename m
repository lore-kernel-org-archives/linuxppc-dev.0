Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHn7C0ddvzF0T1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 13:41:10 +1100 (AEDT)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH v4 3/6] powerpc/kvm/xive: Don't use existing "prodded" flag
 for xive escalations
Date: Fri, 12 Jan 2018 13:37:13 +1100
Message-Id: <20180112023716.9963-3-benh@kernel.crashing.org>
In-Reply-To: <20180112023716.9963-1-benh@kernel.crashing.org>
References: <20180112023716.9963-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The prodded flag is only cleared at the beginning of H_CEDE,
so every time we have an escalation, we will cause the *next*
H_CEDE to return immediately.

Instead use a dedicated "irq_pending" flag to indicate that
a guest interrupt is pending for the VCPU. We don't reuse the
existing exception bitmap as to avoid expensive atomic ops.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/kvm_host.h     |  1 +
 arch/powerpc/kernel/asm-offsets.c       |  1 +
 arch/powerpc/kvm/book3s_hv.c            |  2 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 10 ++++++++++
 arch/powerpc/kvm/book3s_xive.c          |  3 +--
 5 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 3aa5b577cd60..bfe51356af5e 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -709,6 +709,7 @@ struct kvm_vcpu_arch {
 	u8 ceded;
 	u8 prodded;
 	u8 doorbell_request;
+	u8 irq_pending; /* Used by XIVE to signal pending guest irqs */
 	u32 last_inst;
 
 	struct swait_queue_head *wqp;
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 6b958414b4e0..825089cf3e23 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -514,6 +514,7 @@ int main(void)
 	OFFSET(VCPU_PENDING_EXC, kvm_vcpu, arch.pending_exceptions);
 	OFFSET(VCPU_CEDED, kvm_vcpu, arch.ceded);
 	OFFSET(VCPU_PRODDED, kvm_vcpu, arch.prodded);
+	OFFSET(VCPU_IRQ_PENDING, kvm_vcpu, arch.irq_pending);
 	OFFSET(VCPU_DBELL_REQ, kvm_vcpu, arch.doorbell_request);
 	OFFSET(VCPU_MMCR, kvm_vcpu, arch.mmcr);
 	OFFSET(VCPU_PMC, kvm_vcpu, arch.pmc);
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 2d46037ce936..eafd722dce56 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2987,7 +2987,7 @@ static inline bool xive_interrupt_pending(struct kvm_vcpu *vcpu)
 {
 	if (!xive_enabled())
 		return false;
-	return vcpu->arch.xive_saved_state.pipr <
+	return vcpu->arch.irq_pending || vcpu->arch.xive_saved_state.pipr <
 		vcpu->arch.xive_saved_state.cppr;
 }
 #else
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 2659844784b8..327f5e6a1e4d 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -1033,6 +1033,16 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_ARCH_300)
 	li	r9, 1
 	stw	r9, VCPU_XIVE_PUSHED(r4)
 	eieio
+
+	/*
+	 * We clear the irq_pending flag. There is a small chance of a
+	 * race vs. the escalation interrupt happening on another
+	 * processor setting it again, but the only consequence is to
+	 * cause a spurrious wakeup on the next H_CEDE which is not an
+	 * issue.
+	 */
+	li	r0,0
+	stb	r0, VCPU_IRQ_PENDING(r4)
 no_xive:
 #endif /* CONFIG_KVM_XICS */
 
diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index 87f814e81e7d..de78ac38f7ed 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -84,8 +84,7 @@ static irqreturn_t xive_esc_irq(int irq, void *data)
 {
 	struct kvm_vcpu *vcpu = data;
 
-	/* We use the existing H_PROD mechanism to wake up the target */
-	vcpu->arch.prodded = 1;
+	vcpu->arch.irq_pending = 1;
 	smp_mb();
 	if (vcpu->arch.ceded)
 		kvmppc_fast_vcpu_kick(vcpu);
-- 
2.14.3
