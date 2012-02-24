Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9CFA0B6FDF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Feb 2012 01:26:53 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 36/37] KVM: PPC: booke: expose guest registers on irq reinject
Date: Fri, 24 Feb 2012 15:26:30 +0100
Message-Id: <1330093591-19523-37-git-send-email-agraf@suse.de>
In-Reply-To: <1330093591-19523-1-git-send-email-agraf@suse.de>
References: <1330093591-19523-1-git-send-email-agraf@suse.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When reinjecting an interrupt into the host interrupt handler after we're
back in host kernel land, let's tell the kernel about all the guest state
that the interrupt happened at.

This helps getting reasonable numbers out of perf.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/booke.c |   54 +++++++++++++++++++++++++++++++++------------
 1 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 423701b..709fd45 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -593,37 +593,61 @@ static int emulation_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 	}
 }
 
-/**
- * kvmppc_handle_exit
- *
- * Return value is in the form (errcode<<2 | RESUME_FLAG_HOST | RESUME_FLAG_NV)
- */
-int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
-                       unsigned int exit_nr)
+static void kvmppc_fill_pt_regs(struct kvm_vcpu *vcpu, struct pt_regs *regs)
 {
-	int r = RESUME_HOST;
+	int i;
 
-	/* update before a new last_exit_type is rewritten */
-	kvmppc_update_timing_stats(vcpu);
+	for (i = 0; i < 32; i++)
+		regs->gpr[i] = kvmppc_get_gpr(vcpu, i);
+	regs->nip = vcpu->arch.pc;
+	regs->msr = vcpu->arch.shared->msr;
+	regs->ctr = vcpu->arch.ctr;
+	regs->link = vcpu->arch.lr;
+	regs->xer = kvmppc_get_xer(vcpu);
+	regs->ccr = kvmppc_get_cr(vcpu);
+	regs->dar = get_guest_dear(vcpu);
+	regs->dsisr = get_guest_esr(vcpu);
+}
+
+static void kvmppc_restart_interrupt(struct kvm_vcpu *vcpu,
+				     unsigned int exit_nr)
+{
+	struct pt_regs regs = *current->thread.regs;
 
+	kvmppc_fill_pt_regs(vcpu, &regs);
 	switch (exit_nr) {
 	case BOOKE_INTERRUPT_EXTERNAL:
-		do_IRQ(current->thread.regs);
+		do_IRQ(&regs);
 		break;
-
 	case BOOKE_INTERRUPT_DECREMENTER:
-		timer_interrupt(current->thread.regs);
+		timer_interrupt(&regs);
 		break;
-
 #if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_BOOK3E_64)
 	case BOOKE_INTERRUPT_DOORBELL:
-		doorbell_exception(current->thread.regs);
+		doorbell_exception(&regs);
 		break;
 #endif
 	case BOOKE_INTERRUPT_MACHINE_CHECK:
 		/* FIXME */
 		break;
 	}
+}
+
+/**
+ * kvmppc_handle_exit
+ *
+ * Return value is in the form (errcode<<2 | RESUME_FLAG_HOST | RESUME_FLAG_NV)
+ */
+int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
+                       unsigned int exit_nr)
+{
+	int r = RESUME_HOST;
+
+	/* update before a new last_exit_type is rewritten */
+	kvmppc_update_timing_stats(vcpu);
+
+	/* restart interrupts if they were meant for the host */
+	kvmppc_restart_interrupt(vcpu, exit_nr);
 
 	local_irq_enable();
 
-- 
1.6.0.2
