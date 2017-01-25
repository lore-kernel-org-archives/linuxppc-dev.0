Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v7kp53yK7zDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2017 23:27:25 +1100 (AEDT)
From: Thomas Huth <thuth@redhat.com>
To: kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@samba.org>
Cc: kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Alexander Graf <agraf@suse.com>
Subject: [PATCH] KVM: PPC: Book3S PR: Refactor program interrupt related code
 into separate function
Date: Wed, 25 Jan 2017 13:27:22 +0100
Message-Id: <1485347242-4692-1-git-send-email-thuth@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The function kvmppc_handle_exit_pr() is quite huge and thus hard to read,
and even contains a "spaghetti-code"-like goto between the different case
labels of the big switch statement. This can be made much more readable
by moving the code related to injecting program interrupts / instruction
emulation into a separate function instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/powerpc/kvm/book3s_pr.c | 130 +++++++++++++++++++++----------------------
 1 file changed, 65 insertions(+), 65 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 1482961..d4dfc0c 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -902,6 +902,69 @@ static void kvmppc_clear_debug(struct kvm_vcpu *vcpu)
 	}
 }
 
+static int kvmppc_exit_pr_progint(struct kvm_run *run, struct kvm_vcpu *vcpu,
+				  unsigned int exit_nr)
+{
+	enum emulation_result er;
+	ulong flags;
+	u32 last_inst;
+	int emul, r;
+
+	/*
+	 * shadow_srr1 only contains valid flags if we came here via a program
+	 * exception. The other exceptions (emulation assist, FP unavailable,
+	 * etc.) do not provide flags in SRR1, so use an illegal-instruction
+	 * exception when injecting a program interrupt into the guest.
+	 */
+	if (exit_nr == BOOK3S_INTERRUPT_PROGRAM)
+		flags = vcpu->arch.shadow_srr1 & 0x1f0000ull;
+	else
+		flags = SRR1_PROGILL;
+
+	emul = kvmppc_get_last_inst(vcpu, INST_GENERIC, &last_inst);
+	if (emul != EMULATE_DONE)
+		return RESUME_GUEST;
+
+	if (kvmppc_get_msr(vcpu) & MSR_PR) {
+#ifdef EXIT_DEBUG
+		pr_info("Userspace triggered 0x700 exception at\n 0x%lx (0x%x)\n",
+			kvmppc_get_pc(vcpu), last_inst);
+#endif
+		if ((last_inst & 0xff0007ff) != (INS_DCBZ & 0xfffffff7)) {
+			kvmppc_core_queue_program(vcpu, flags);
+			return RESUME_GUEST;
+		}
+	}
+
+	vcpu->stat.emulated_inst_exits++;
+	er = kvmppc_emulate_instruction(run, vcpu);
+	switch (er) {
+	case EMULATE_DONE:
+		r = RESUME_GUEST_NV;
+		break;
+	case EMULATE_AGAIN:
+		r = RESUME_GUEST;
+		break;
+	case EMULATE_FAIL:
+		pr_crit("%s: emulation at %lx failed (%08x)\n",
+			__func__, kvmppc_get_pc(vcpu), last_inst);
+		kvmppc_core_queue_program(vcpu, flags);
+		r = RESUME_GUEST;
+		break;
+	case EMULATE_DO_MMIO:
+		run->exit_reason = KVM_EXIT_MMIO;
+		r = RESUME_HOST_NV;
+		break;
+	case EMULATE_EXIT_USER:
+		r = RESUME_HOST_NV;
+		break;
+	default:
+		BUG();
+	}
+
+	return r;
+}
+
 int kvmppc_handle_exit_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			  unsigned int exit_nr)
 {
@@ -1044,71 +1107,8 @@ int kvmppc_handle_exit_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		break;
 	case BOOK3S_INTERRUPT_PROGRAM:
 	case BOOK3S_INTERRUPT_H_EMUL_ASSIST:
-	{
-		enum emulation_result er;
-		ulong flags;
-		u32 last_inst;
-		int emul;
-
-program_interrupt:
-		/*
-		 * shadow_srr1 only contains valid flags if we came here via
-		 * a program exception. The other exceptions (emulation assist,
-		 * FP unavailable, etc.) do not provide flags in SRR1, so use
-		 * an illegal-instruction exception when injecting a program
-		 * interrupt into the guest.
-		 */
-		if (exit_nr == BOOK3S_INTERRUPT_PROGRAM)
-			flags = vcpu->arch.shadow_srr1 & 0x1f0000ull;
-		else
-			flags = SRR1_PROGILL;
-
-		emul = kvmppc_get_last_inst(vcpu, INST_GENERIC, &last_inst);
-		if (emul != EMULATE_DONE) {
-			r = RESUME_GUEST;
-			break;
-		}
-
-		if (kvmppc_get_msr(vcpu) & MSR_PR) {
-#ifdef EXIT_DEBUG
-			pr_info("Userspace triggered 0x700 exception at\n 0x%lx (0x%x)\n",
-				kvmppc_get_pc(vcpu), last_inst);
-#endif
-			if ((last_inst & 0xff0007ff) !=
-			    (INS_DCBZ & 0xfffffff7)) {
-				kvmppc_core_queue_program(vcpu, flags);
-				r = RESUME_GUEST;
-				break;
-			}
-		}
-
-		vcpu->stat.emulated_inst_exits++;
-		er = kvmppc_emulate_instruction(run, vcpu);
-		switch (er) {
-		case EMULATE_DONE:
-			r = RESUME_GUEST_NV;
-			break;
-		case EMULATE_AGAIN:
-			r = RESUME_GUEST;
-			break;
-		case EMULATE_FAIL:
-			printk(KERN_CRIT "%s: emulation at %lx failed (%08x)\n",
-			       __func__, kvmppc_get_pc(vcpu), last_inst);
-			kvmppc_core_queue_program(vcpu, flags);
-			r = RESUME_GUEST;
-			break;
-		case EMULATE_DO_MMIO:
-			run->exit_reason = KVM_EXIT_MMIO;
-			r = RESUME_HOST_NV;
-			break;
-		case EMULATE_EXIT_USER:
-			r = RESUME_HOST_NV;
-			break;
-		default:
-			BUG();
-		}
+		r = kvmppc_exit_pr_progint(run, vcpu, exit_nr);
 		break;
-	}
 	case BOOK3S_INTERRUPT_SYSCALL:
 	{
 		u32 last_sc;
@@ -1185,7 +1185,7 @@ int kvmppc_handle_exit_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			emul = kvmppc_get_last_inst(vcpu, INST_GENERIC,
 						    &last_inst);
 			if (emul == EMULATE_DONE)
-				goto program_interrupt;
+				r = kvmppc_exit_pr_progint(run, vcpu, exit_nr);
 			else
 				r = RESUME_GUEST;
 
-- 
1.8.3.1
