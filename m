Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C6BBDB6EEF
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Jul 2010 20:43:06 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 05/27] KVM: PPC: Convert SRR0 and SRR1 to shared page
Date: Thu,  1 Jul 2010 12:42:40 +0200
Message-Id: <1277980982-12433-6-git-send-email-agraf@suse.de>
In-Reply-To: <1277980982-12433-1-git-send-email-agraf@suse.de>
References: <1277980982-12433-1-git-send-email-agraf@suse.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The SRR0 and SRR1 registers contain cached values of the PC and MSR
respectively. They get written to by the hypervisor when an interrupt
occurs or directly by the kernel. They are also used to tell the rfi(d)
instruction where to jump to.

Because it only gets touched on defined events that, it's very simple to
share with the guest. Hypervisor and guest both have full r/w access.

This patch converts all users of the current field to the shared page.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/include/asm/kvm_host.h |    2 --
 arch/powerpc/include/asm/kvm_para.h |    2 ++
 arch/powerpc/kvm/book3s.c           |   12 ++++++------
 arch/powerpc/kvm/book3s_emulate.c   |    4 ++--
 arch/powerpc/kvm/booke.c            |   15 ++++++++-------
 arch/powerpc/kvm/booke_emulate.c    |    4 ++--
 arch/powerpc/kvm/emulate.c          |   12 ++++++++----
 7 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 4502c0f..227f770 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -224,8 +224,6 @@ struct kvm_vcpu_arch {
 	ulong sprg5;
 	ulong sprg6;
 	ulong sprg7;
-	ulong srr0;
-	ulong srr1;
 	ulong csrr0;
 	ulong csrr1;
 	ulong dsrr0;
diff --git a/arch/powerpc/include/asm/kvm_para.h b/arch/powerpc/include/asm/kvm_para.h
index ec72a1c..d7fc6c2 100644
--- a/arch/powerpc/include/asm/kvm_para.h
+++ b/arch/powerpc/include/asm/kvm_para.h
@@ -23,6 +23,8 @@
 #include <linux/types.h>
 
 struct kvm_vcpu_arch_shared {
+	__u64 srr0;
+	__u64 srr1;
 	__u64 dar;
 	__u64 msr;
 	__u32 dsisr;
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 29a3ed6..7cc3da6 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -162,8 +162,8 @@ void kvmppc_set_msr(struct kvm_vcpu *vcpu, u64 msr)
 
 void kvmppc_inject_interrupt(struct kvm_vcpu *vcpu, int vec, u64 flags)
 {
-	vcpu->arch.srr0 = kvmppc_get_pc(vcpu);
-	vcpu->arch.srr1 = vcpu->arch.shared->msr | flags;
+	vcpu->arch.shared->srr0 = kvmppc_get_pc(vcpu);
+	vcpu->arch.shared->srr1 = vcpu->arch.shared->msr | flags;
 	kvmppc_set_pc(vcpu, to_book3s(vcpu)->hior + vec);
 	vcpu->arch.mmu.reset_msr(vcpu);
 }
@@ -1059,8 +1059,8 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	regs->lr = kvmppc_get_lr(vcpu);
 	regs->xer = kvmppc_get_xer(vcpu);
 	regs->msr = vcpu->arch.shared->msr;
-	regs->srr0 = vcpu->arch.srr0;
-	regs->srr1 = vcpu->arch.srr1;
+	regs->srr0 = vcpu->arch.shared->srr0;
+	regs->srr1 = vcpu->arch.shared->srr1;
 	regs->pid = vcpu->arch.pid;
 	regs->sprg0 = vcpu->arch.sprg0;
 	regs->sprg1 = vcpu->arch.sprg1;
@@ -1086,8 +1086,8 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	kvmppc_set_lr(vcpu, regs->lr);
 	kvmppc_set_xer(vcpu, regs->xer);
 	kvmppc_set_msr(vcpu, regs->msr);
-	vcpu->arch.srr0 = regs->srr0;
-	vcpu->arch.srr1 = regs->srr1;
+	vcpu->arch.shared->srr0 = regs->srr0;
+	vcpu->arch.shared->srr1 = regs->srr1;
 	vcpu->arch.sprg0 = regs->sprg0;
 	vcpu->arch.sprg1 = regs->sprg1;
 	vcpu->arch.sprg2 = regs->sprg2;
diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index c147864..f333cb4 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -73,8 +73,8 @@ int kvmppc_core_emulate_op(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		switch (get_xop(inst)) {
 		case OP_19_XOP_RFID:
 		case OP_19_XOP_RFI:
-			kvmppc_set_pc(vcpu, vcpu->arch.srr0);
-			kvmppc_set_msr(vcpu, vcpu->arch.srr1);
+			kvmppc_set_pc(vcpu, vcpu->arch.shared->srr0);
+			kvmppc_set_msr(vcpu, vcpu->arch.shared->srr1);
 			*advance = 0;
 			break;
 
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 5844bcf..8b546fe 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -64,7 +64,8 @@ void kvmppc_dump_vcpu(struct kvm_vcpu *vcpu)
 
 	printk("pc:   %08lx msr:  %08llx\n", vcpu->arch.pc, vcpu->arch.shared->msr);
 	printk("lr:   %08lx ctr:  %08lx\n", vcpu->arch.lr, vcpu->arch.ctr);
-	printk("srr0: %08lx srr1: %08lx\n", vcpu->arch.srr0, vcpu->arch.srr1);
+	printk("srr0: %08llx srr1: %08llx\n", vcpu->arch.shared->srr0,
+					    vcpu->arch.shared->srr1);
 
 	printk("exceptions: %08lx\n", vcpu->arch.pending_exceptions);
 
@@ -189,8 +190,8 @@ static int kvmppc_booke_irqprio_deliver(struct kvm_vcpu *vcpu,
 	}
 
 	if (allowed) {
-		vcpu->arch.srr0 = vcpu->arch.pc;
-		vcpu->arch.srr1 = vcpu->arch.shared->msr;
+		vcpu->arch.shared->srr0 = vcpu->arch.pc;
+		vcpu->arch.shared->srr1 = vcpu->arch.shared->msr;
 		vcpu->arch.pc = vcpu->arch.ivpr | vcpu->arch.ivor[priority];
 		if (update_esr == true)
 			vcpu->arch.esr = vcpu->arch.queued_esr;
@@ -491,8 +492,8 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	regs->lr = vcpu->arch.lr;
 	regs->xer = kvmppc_get_xer(vcpu);
 	regs->msr = vcpu->arch.shared->msr;
-	regs->srr0 = vcpu->arch.srr0;
-	regs->srr1 = vcpu->arch.srr1;
+	regs->srr0 = vcpu->arch.shared->srr0;
+	regs->srr1 = vcpu->arch.shared->srr1;
 	regs->pid = vcpu->arch.pid;
 	regs->sprg0 = vcpu->arch.sprg0;
 	regs->sprg1 = vcpu->arch.sprg1;
@@ -518,8 +519,8 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	vcpu->arch.lr = regs->lr;
 	kvmppc_set_xer(vcpu, regs->xer);
 	kvmppc_set_msr(vcpu, regs->msr);
-	vcpu->arch.srr0 = regs->srr0;
-	vcpu->arch.srr1 = regs->srr1;
+	vcpu->arch.shared->srr0 = regs->srr0;
+	vcpu->arch.shared->srr1 = regs->srr1;
 	vcpu->arch.sprg0 = regs->sprg0;
 	vcpu->arch.sprg1 = regs->sprg1;
 	vcpu->arch.sprg2 = regs->sprg2;
diff --git a/arch/powerpc/kvm/booke_emulate.c b/arch/powerpc/kvm/booke_emulate.c
index 51ef453..1260f5f 100644
--- a/arch/powerpc/kvm/booke_emulate.c
+++ b/arch/powerpc/kvm/booke_emulate.c
@@ -31,8 +31,8 @@
 
 static void kvmppc_emul_rfi(struct kvm_vcpu *vcpu)
 {
-	vcpu->arch.pc = vcpu->arch.srr0;
-	kvmppc_set_msr(vcpu, vcpu->arch.srr1);
+	vcpu->arch.pc = vcpu->arch.shared->srr0;
+	kvmppc_set_msr(vcpu, vcpu->arch.shared->srr1);
 }
 
 int kvmppc_booke_emulate_op(struct kvm_run *run, struct kvm_vcpu *vcpu,
diff --git a/arch/powerpc/kvm/emulate.c b/arch/powerpc/kvm/emulate.c
index 4568ec3..ad0fa4f 100644
--- a/arch/powerpc/kvm/emulate.c
+++ b/arch/powerpc/kvm/emulate.c
@@ -242,9 +242,11 @@ int kvmppc_emulate_instruction(struct kvm_run *run, struct kvm_vcpu *vcpu)
 
 			switch (sprn) {
 			case SPRN_SRR0:
-				kvmppc_set_gpr(vcpu, rt, vcpu->arch.srr0); break;
+				kvmppc_set_gpr(vcpu, rt, vcpu->arch.shared->srr0);
+				break;
 			case SPRN_SRR1:
-				kvmppc_set_gpr(vcpu, rt, vcpu->arch.srr1); break;
+				kvmppc_set_gpr(vcpu, rt, vcpu->arch.shared->srr1);
+				break;
 			case SPRN_PVR:
 				kvmppc_set_gpr(vcpu, rt, vcpu->arch.pvr); break;
 			case SPRN_PIR:
@@ -320,9 +322,11 @@ int kvmppc_emulate_instruction(struct kvm_run *run, struct kvm_vcpu *vcpu)
 			rs = get_rs(inst);
 			switch (sprn) {
 			case SPRN_SRR0:
-				vcpu->arch.srr0 = kvmppc_get_gpr(vcpu, rs); break;
+				vcpu->arch.shared->srr0 = kvmppc_get_gpr(vcpu, rs);
+				break;
 			case SPRN_SRR1:
-				vcpu->arch.srr1 = kvmppc_get_gpr(vcpu, rs); break;
+				vcpu->arch.shared->srr1 = kvmppc_get_gpr(vcpu, rs);
+				break;
 
 			/* XXX We need to context-switch the timebase for
 			 * watchdog and FIT. */
-- 
1.6.0.2
