Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4668FB6FCA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Feb 2012 11:10:24 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 36/38] KVM: PPC: booke: expose good state on irq reinject
Date: Wed, 29 Feb 2012 01:10:04 +0100
Message-Id: <1330474206-14794-37-git-send-email-agraf@suse.de>
In-Reply-To: <1330474206-14794-1-git-send-email-agraf@suse.de>
References: <1330474206-14794-1-git-send-email-agraf@suse.de>
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
back in host kernel land, we need to tell the kernel where the interrupt
happened. We can't tell it that we were in guest state, because that might
lead to random code walking host addresses. So instead, we tell it that
we came from the interrupt reinject code.

This helps getting reasonable numbers out of perf.

Signed-off-by: Alexander Graf <agraf@suse.de>

---

v2 -> v3:

  - actually sync host state
  - no need for vcpu in sync
---
 arch/powerpc/kvm/booke.c |   56 +++++++++++++++++++++++++++++++++------------
 1 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index ee39c8a..488936b 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -595,37 +595,63 @@ static int emulation_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 	}
 }
 
-/**
- * kvmppc_handle_exit
- *
- * Return value is in the form (errcode<<2 | RESUME_FLAG_HOST | RESUME_FLAG_NV)
- */
-int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
-                       unsigned int exit_nr)
+static void kvmppc_fill_pt_regs(struct pt_regs *regs)
 {
-	int r = RESUME_HOST;
+	ulong r1, ip, msr, lr;
+
+	asm("mr %0, 1" : "=r"(r1));
+	asm("mflr %0" : "=r"(lr));
+	asm("mfmsr %0" : "=r"(msr));
+	asm("bl 1f; 1: mflr %0" : "=r"(ip));
+
+	memset(regs, 0, sizeof(*regs));
+	regs->gpr[1] = r1;
+	regs->nip = ip;
+	regs->msr = msr;
+	regs->link = lr;
+}
 
-	/* update before a new last_exit_type is rewritten */
-	kvmppc_update_timing_stats(vcpu);
+static void kvmppc_restart_interrupt(struct kvm_vcpu *vcpu,
+				     unsigned int exit_nr)
+{
+	struct pt_regs regs;
 
 	switch (exit_nr) {
 	case BOOKE_INTERRUPT_EXTERNAL:
-		do_IRQ(current->thread.regs);
+		kvmppc_fill_pt_regs(&regs);
+		do_IRQ(&regs);
 		break;
-
 	case BOOKE_INTERRUPT_DECREMENTER:
-		timer_interrupt(current->thread.regs);
+		kvmppc_fill_pt_regs(&regs);
+		timer_interrupt(&regs);
 		break;
-
 #if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_BOOK3E_64)
 	case BOOKE_INTERRUPT_DOORBELL:
-		doorbell_exception(current->thread.regs);
+		kvmppc_fill_pt_regs(&regs);
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
