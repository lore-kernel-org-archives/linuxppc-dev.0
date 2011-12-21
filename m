Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 6B826B71B2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2011 12:34:35 +1100 (EST)
Date: Tue, 20 Dec 2011 19:34:16 -0600
From: Scott Wood <scottwood@freescale.com>
To: <agraf@suse.de>
Subject: [RFC PATCH 03/16] KVM: PPC: Use pt_regs in vcpu->arch
Message-ID: <20111221013416.GC8378@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20111221013340.GA8368@schlenkerla.am.freescale.net>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This makes it easy to pass to host exception handling functions, in
situations where we can't just let the interrupt happen again
naturally.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/include/asm/kvm_book3s.h   |   28 ++++++++++++------------
 arch/powerpc/include/asm/kvm_booke.h    |   24 +++++++++++-----------
 arch/powerpc/include/asm/kvm_host.h     |   11 ++-------
 arch/powerpc/kernel/asm-offsets.c       |   17 +++++----------
 arch/powerpc/kvm/book3s_32_mmu.c        |    2 +-
 arch/powerpc/kvm/book3s_hv.c            |    9 ++++---
 arch/powerpc/kvm/book3s_hv_rm_mmu.c     |   12 +++++-----
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |    4 +-
 arch/powerpc/kvm/booke.c                |   34 +++++++++++++++++-------------
 arch/powerpc/kvm/booke_emulate.c        |    2 +-
 arch/powerpc/kvm/e500_tlb.c             |    2 +-
 11 files changed, 70 insertions(+), 75 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index ea9539c..60e069e 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -206,7 +206,7 @@ static inline void kvmppc_set_gpr(struct kvm_vcpu *vcpu, int num, ulong val)
 		svcpu_put(svcpu);
 		to_book3s(vcpu)->shadow_vcpu->gpr[num] = val;
 	} else
-		vcpu->arch.gpr[num] = val;
+		vcpu->arch.regs.gpr[num] = val;
 }
 
 static inline ulong kvmppc_get_gpr(struct kvm_vcpu *vcpu, int num)
@@ -217,7 +217,7 @@ static inline ulong kvmppc_get_gpr(struct kvm_vcpu *vcpu, int num)
 		svcpu_put(svcpu);
 		return r;
 	} else
-		return vcpu->arch.gpr[num];
+		return vcpu->arch.regs.gpr[num];
 }
 
 static inline void kvmppc_set_cr(struct kvm_vcpu *vcpu, u32 val)
@@ -360,62 +360,62 @@ static inline void kvmppc_update_int_pending(struct kvm_vcpu *vcpu,
 
 static inline void kvmppc_set_gpr(struct kvm_vcpu *vcpu, int num, ulong val)
 {
-	vcpu->arch.gpr[num] = val;
+	vcpu->arch.regs.gpr[num] = val;
 }
 
 static inline ulong kvmppc_get_gpr(struct kvm_vcpu *vcpu, int num)
 {
-	return vcpu->arch.gpr[num];
+	return vcpu->arch.regs.gpr[num];
 }
 
 static inline void kvmppc_set_cr(struct kvm_vcpu *vcpu, u32 val)
 {
-	vcpu->arch.cr = val;
+	vcpu->arch.regs.ccr = val;
 }
 
 static inline u32 kvmppc_get_cr(struct kvm_vcpu *vcpu)
 {
-	return vcpu->arch.cr;
+	return vcpu->arch.regs.ccr;
 }
 
 static inline void kvmppc_set_xer(struct kvm_vcpu *vcpu, u32 val)
 {
-	vcpu->arch.xer = val;
+	vcpu->arch.regs.xer = val;
 }
 
 static inline u32 kvmppc_get_xer(struct kvm_vcpu *vcpu)
 {
-	return vcpu->arch.xer;
+	return vcpu->arch.regs.xer;
 }
 
 static inline void kvmppc_set_ctr(struct kvm_vcpu *vcpu, ulong val)
 {
-	vcpu->arch.ctr = val;
+	vcpu->arch.regs.ctr = val;
 }
 
 static inline ulong kvmppc_get_ctr(struct kvm_vcpu *vcpu)
 {
-	return vcpu->arch.ctr;
+	return vcpu->arch.regs.ctr;
 }
 
 static inline void kvmppc_set_lr(struct kvm_vcpu *vcpu, ulong val)
 {
-	vcpu->arch.lr = val;
+	vcpu->arch.regs.link = val;
 }
 
 static inline ulong kvmppc_get_lr(struct kvm_vcpu *vcpu)
 {
-	return vcpu->arch.lr;
+	return vcpu->arch.regs.link;
 }
 
 static inline void kvmppc_set_pc(struct kvm_vcpu *vcpu, ulong val)
 {
-	vcpu->arch.pc = val;
+	vcpu->arch.regs.nip = val;
 }
 
 static inline ulong kvmppc_get_pc(struct kvm_vcpu *vcpu)
 {
-	return vcpu->arch.pc;
+	return vcpu->arch.regs.nip;
 }
 
 static inline u32 kvmppc_get_last_inst(struct kvm_vcpu *vcpu)
diff --git a/arch/powerpc/include/asm/kvm_booke.h b/arch/powerpc/include/asm/kvm_booke.h
index a90e091..e20c162 100644
--- a/arch/powerpc/include/asm/kvm_booke.h
+++ b/arch/powerpc/include/asm/kvm_booke.h
@@ -25,32 +25,32 @@
 
 static inline void kvmppc_set_gpr(struct kvm_vcpu *vcpu, int num, ulong val)
 {
-	vcpu->arch.gpr[num] = val;
+	vcpu->arch.regs.gpr[num] = val;
 }
 
 static inline ulong kvmppc_get_gpr(struct kvm_vcpu *vcpu, int num)
 {
-	return vcpu->arch.gpr[num];
+	return vcpu->arch.regs.gpr[num];
 }
 
 static inline void kvmppc_set_cr(struct kvm_vcpu *vcpu, u32 val)
 {
-	vcpu->arch.cr = val;
+	vcpu->arch.regs.ccr = val;
 }
 
 static inline u32 kvmppc_get_cr(struct kvm_vcpu *vcpu)
 {
-	return vcpu->arch.cr;
+	return vcpu->arch.regs.ccr;
 }
 
 static inline void kvmppc_set_xer(struct kvm_vcpu *vcpu, u32 val)
 {
-	vcpu->arch.xer = val;
+	vcpu->arch.regs.xer = val;
 }
 
 static inline u32 kvmppc_get_xer(struct kvm_vcpu *vcpu)
 {
-	return vcpu->arch.xer;
+	return vcpu->arch.regs.xer;
 }
 
 static inline u32 kvmppc_get_last_inst(struct kvm_vcpu *vcpu)
@@ -60,32 +60,32 @@ static inline u32 kvmppc_get_last_inst(struct kvm_vcpu *vcpu)
 
 static inline void kvmppc_set_ctr(struct kvm_vcpu *vcpu, ulong val)
 {
-	vcpu->arch.ctr = val;
+	vcpu->arch.regs.ctr = val;
 }
 
 static inline ulong kvmppc_get_ctr(struct kvm_vcpu *vcpu)
 {
-	return vcpu->arch.ctr;
+	return vcpu->arch.regs.ctr;
 }
 
 static inline void kvmppc_set_lr(struct kvm_vcpu *vcpu, ulong val)
 {
-	vcpu->arch.lr = val;
+	vcpu->arch.regs.link = val;
 }
 
 static inline ulong kvmppc_get_lr(struct kvm_vcpu *vcpu)
 {
-	return vcpu->arch.lr;
+	return vcpu->arch.regs.link;
 }
 
 static inline void kvmppc_set_pc(struct kvm_vcpu *vcpu, ulong val)
 {
-	vcpu->arch.pc = val;
+	vcpu->arch.regs.nip = val;
 }
 
 static inline ulong kvmppc_get_pc(struct kvm_vcpu *vcpu)
 {
-	return vcpu->arch.pc;
+	return vcpu->arch.regs.nip;
 }
 
 static inline ulong kvmppc_get_fault_dar(struct kvm_vcpu *vcpu)
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 968f3aa..443f007 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -33,6 +33,7 @@
 #include <asm/kvm_asm.h>
 #include <asm/processor.h>
 #include <asm/page.h>
+#include <asm/ptrace.h>
 
 #define KVM_MAX_VCPUS		NR_CPUS
 #define KVM_MAX_VCORES		NR_CPUS
@@ -319,7 +320,8 @@ struct kvm_vcpu_arch {
 	struct kvmppc_mmu mmu;
 #endif
 
-	ulong gpr[32];
+	/* Valid fields: gpr, nip, ctr, link, xer, ccr */
+	struct pt_regs regs;
 
 	u64 fpr[32];
 	u64 fpscr;
@@ -344,13 +346,6 @@ struct kvm_vcpu_arch {
 	u32 qpr[32];
 #endif
 
-	ulong pc;
-	ulong ctr;
-	ulong lr;
-
-	ulong xer;
-	u32 cr;
-
 #ifdef CONFIG_PPC_BOOK3S
 	ulong hflags;
 	ulong guest_owned_ext;
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index ec24b36..c80bdd1 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -400,7 +400,7 @@ int main(void)
 #ifdef CONFIG_KVM
 	DEFINE(VCPU_HOST_STACK, offsetof(struct kvm_vcpu, arch.host_stack));
 	DEFINE(VCPU_HOST_PID, offsetof(struct kvm_vcpu, arch.host_pid));
-	DEFINE(VCPU_GPRS, offsetof(struct kvm_vcpu, arch.gpr));
+	DEFINE(VCPU_GPRS, offsetof(struct kvm_vcpu, arch.regs.gpr));
 	DEFINE(VCPU_VRSAVE, offsetof(struct kvm_vcpu, arch.vrsave));
 	DEFINE(VCPU_FPRS, offsetof(struct kvm_vcpu, arch.fpr));
 	DEFINE(VCPU_FPSCR, offsetof(struct kvm_vcpu, arch.fpscr));
@@ -411,11 +411,11 @@ int main(void)
 #ifdef CONFIG_VSX
 	DEFINE(VCPU_VSRS, offsetof(struct kvm_vcpu, arch.vsr));
 #endif
-	DEFINE(VCPU_XER, offsetof(struct kvm_vcpu, arch.xer));
-	DEFINE(VCPU_CTR, offsetof(struct kvm_vcpu, arch.ctr));
-	DEFINE(VCPU_LR, offsetof(struct kvm_vcpu, arch.lr));
-	DEFINE(VCPU_CR, offsetof(struct kvm_vcpu, arch.cr));
-	DEFINE(VCPU_PC, offsetof(struct kvm_vcpu, arch.pc));
+	DEFINE(VCPU_XER, offsetof(struct kvm_vcpu, arch.regs.xer));
+	DEFINE(VCPU_CTR, offsetof(struct kvm_vcpu, arch.regs.ctr));
+	DEFINE(VCPU_LR, offsetof(struct kvm_vcpu, arch.regs.link));
+	DEFINE(VCPU_CR, offsetof(struct kvm_vcpu, arch.regs.ccr));
+	DEFINE(VCPU_PC, offsetof(struct kvm_vcpu, arch.regs.nip));
 #ifdef CONFIG_KVM_BOOK3S_64_HV
 	DEFINE(VCPU_MSR, offsetof(struct kvm_vcpu, arch.shregs.msr));
 	DEFINE(VCPU_SRR0, offsetof(struct kvm_vcpu, arch.shregs.srr0));
@@ -564,11 +564,6 @@ int main(void)
 #endif /* CONFIG_KVM_BOOK3S_64_HV */
 
 #else /* CONFIG_PPC_BOOK3S */
-	DEFINE(VCPU_CR, offsetof(struct kvm_vcpu, arch.cr));
-	DEFINE(VCPU_XER, offsetof(struct kvm_vcpu, arch.xer));
-	DEFINE(VCPU_LR, offsetof(struct kvm_vcpu, arch.lr));
-	DEFINE(VCPU_CTR, offsetof(struct kvm_vcpu, arch.ctr));
-	DEFINE(VCPU_PC, offsetof(struct kvm_vcpu, arch.pc));
 	DEFINE(VCPU_LAST_INST, offsetof(struct kvm_vcpu, arch.last_inst));
 	DEFINE(VCPU_FAULT_DEAR, offsetof(struct kvm_vcpu, arch.fault_dear));
 	DEFINE(VCPU_FAULT_ESR, offsetof(struct kvm_vcpu, arch.fault_esr));
diff --git a/arch/powerpc/kvm/book3s_32_mmu.c b/arch/powerpc/kvm/book3s_32_mmu.c
index c8cefdd..e66d9cf 100644
--- a/arch/powerpc/kvm/book3s_32_mmu.c
+++ b/arch/powerpc/kvm/book3s_32_mmu.c
@@ -52,7 +52,7 @@
 static inline bool check_debug_ip(struct kvm_vcpu *vcpu)
 {
 #ifdef DEBUG_MMU_PTE_IP
-	return vcpu->arch.pc == DEBUG_MMU_PTE_IP;
+	return vcpu->arch.regs.nip == DEBUG_MMU_PTE_IP;
 #else
 	return true;
 #endif
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index cb8e15f..37b6f27 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -85,21 +85,22 @@ void kvmppc_dump_regs(struct kvm_vcpu *vcpu)
 
 	pr_err("vcpu %p (%d):\n", vcpu, vcpu->vcpu_id);
 	pr_err("pc  = %.16lx  msr = %.16llx  trap = %x\n",
-	       vcpu->arch.pc, vcpu->arch.shregs.msr, vcpu->arch.trap);
+	       vcpu->arch.regs.nip, vcpu->arch.shregs.msr, vcpu->arch.trap);
 	for (r = 0; r < 16; ++r)
 		pr_err("r%2d = %.16lx  r%d = %.16lx\n",
 		       r, kvmppc_get_gpr(vcpu, r),
 		       r+16, kvmppc_get_gpr(vcpu, r+16));
 	pr_err("ctr = %.16lx  lr  = %.16lx\n",
-	       vcpu->arch.ctr, vcpu->arch.lr);
+	       vcpu->arch.regs.ctr, vcpu->arch.regs.link);
 	pr_err("srr0 = %.16llx srr1 = %.16llx\n",
 	       vcpu->arch.shregs.srr0, vcpu->arch.shregs.srr1);
 	pr_err("sprg0 = %.16llx sprg1 = %.16llx\n",
 	       vcpu->arch.shregs.sprg0, vcpu->arch.shregs.sprg1);
 	pr_err("sprg2 = %.16llx sprg3 = %.16llx\n",
 	       vcpu->arch.shregs.sprg2, vcpu->arch.shregs.sprg3);
-	pr_err("cr = %.8x  xer = %.16lx  dsisr = %.8x\n",
-	       vcpu->arch.cr, vcpu->arch.xer, vcpu->arch.shregs.dsisr);
+	pr_err("cr = %.8lx  xer = %.16lx  dsisr = %.8x\n",
+	       vcpu->arch.regs.ccr, vcpu->arch.regs.xer,
+	       vcpu->arch.shregs.dsisr);
 	pr_err("dar = %.16llx\n", vcpu->arch.shregs.dar);
 	pr_err("fault dar = %.16lx dsisr = %.8x\n",
 	       vcpu->arch.fault_dar, vcpu->arch.fault_dsisr);
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index d3e36fc..3afda68 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -324,7 +324,7 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 	hpte[0] = pteh;
 	asm volatile("ptesync" : : : "memory");
 
-	vcpu->arch.gpr[4] = pte_index;
+	vcpu->arch.regs.gpr[4] = pte_index;
 	return H_SUCCESS;
 }
 EXPORT_SYMBOL_GPL(kvmppc_h_enter);
@@ -370,8 +370,8 @@ long kvmppc_h_remove(struct kvm_vcpu *vcpu, unsigned long flags,
 	}
 	if (atomic_read(&kvm->online_vcpus) == 1)
 		flags |= H_LOCAL;
-	vcpu->arch.gpr[4] = v = hpte[0] & ~HPTE_V_HVLOCK;
-	vcpu->arch.gpr[5] = r = hpte[1];
+	vcpu->arch.regs.gpr[4] = v = hpte[0] & ~HPTE_V_HVLOCK;
+	vcpu->arch.regs.gpr[5] = r = hpte[1];
 	rb = compute_tlbie_rb(v, r, pte_index);
 	if (v & HPTE_V_VALID)
 		remove_revmap_chain(kvm, pte_index, v);
@@ -398,7 +398,7 @@ long kvmppc_h_remove(struct kvm_vcpu *vcpu, unsigned long flags,
 long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
-	unsigned long *args = &vcpu->arch.gpr[4];
+	unsigned long *args = &vcpu->arch.regs.gpr[4];
 	unsigned long *hp, tlbrb[4];
 	long int i, found;
 	long int n_inval = 0;
@@ -571,8 +571,8 @@ long kvmppc_h_read(struct kvm_vcpu *vcpu, unsigned long flags,
 			else
 				r = hpte[1] | HPTE_R_RPN;
 		}
-		vcpu->arch.gpr[4 + i * 2] = v;
-		vcpu->arch.gpr[5 + i * 2] = r;
+		vcpu->arch.regs.gpr[4 + i * 2] = v;
+		vcpu->arch.regs.gpr[5 + i * 2] = r;
 	}
 	return H_SUCCESS;
 }
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 7b8dbf6..93a183b 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -506,7 +506,7 @@ fast_guest_return:
 	/* Enter guest */
 
 	ld	r5, VCPU_LR(r4)
-	lwz	r6, VCPU_CR(r4)
+	ld	r6, VCPU_CR(r4)
 	mtlr	r5
 	mtcr	r6
 
@@ -569,7 +569,7 @@ kvmppc_interrupt:
 	ld	r3, HSTATE_SCRATCH0(r13)
 	lwz	r4, HSTATE_SCRATCH1(r13)
 	std	r3, VCPU_GPR(r12)(r9)
-	stw	r4, VCPU_CR(r9)
+	std	r4, VCPU_CR(r9)
 
 	/* Restore R1/R2 so we can handle faults */
 	ld	r1, HSTATE_HOST_R1(r13)
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index ee9e1ee..a41287d 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -63,8 +63,10 @@ void kvmppc_dump_vcpu(struct kvm_vcpu *vcpu)
 {
 	int i;
 
-	printk("pc:   %08lx msr:  %08llx\n", vcpu->arch.pc, vcpu->arch.shared->msr);
-	printk("lr:   %08lx ctr:  %08lx\n", vcpu->arch.lr, vcpu->arch.ctr);
+	printk("pc:   %08lx msr:  %08llx\n",
+	       vcpu->arch.regs.nip, vcpu->arch.shared->msr);
+	printk("lr:   %08lx ctr:  %08lx\n",
+	       vcpu->arch.regs.link, vcpu->arch.regs.ctr);
 	printk("srr0: %08llx srr1: %08llx\n", vcpu->arch.shared->srr0,
 					    vcpu->arch.shared->srr1);
 
@@ -268,9 +270,10 @@ static int kvmppc_booke_irqprio_deliver(struct kvm_vcpu *vcpu,
 	}
 
 	if (allowed) {
-		vcpu->arch.shared->srr0 = vcpu->arch.pc;
+		vcpu->arch.shared->srr0 = vcpu->arch.regs.nip;
 		vcpu->arch.shared->srr1 = vcpu->arch.shared->msr;
-		vcpu->arch.pc = vcpu->arch.ivpr | vcpu->arch.ivor[priority];
+		vcpu->arch.regs.nip = vcpu->arch.ivpr |
+				      vcpu->arch.ivor[priority];
 		if (update_esr == true)
 			vcpu->arch.shared->esr = vcpu->arch.queued_esr;
 		if (update_dear == true)
@@ -432,7 +435,8 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		case EMULATE_FAIL:
 			/* XXX Deliver Program interrupt to guest. */
 			printk(KERN_CRIT "%s: emulation at %lx failed (%08x)\n",
-			       __func__, vcpu->arch.pc, vcpu->arch.last_inst);
+			       __func__, vcpu->arch.regs.nip,
+			       vcpu->arch.last_inst);
 			/* For debugging, encode the failing instruction and
 			 * report it to userspace. */
 			run->hw.hardware_exit_reason = ~0ULL << 32;
@@ -487,7 +491,7 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	case BOOKE_INTERRUPT_SPE_FP_DATA:
 	case BOOKE_INTERRUPT_SPE_FP_ROUND:
 		printk(KERN_CRIT "%s: unexpected SPE interrupt %u at %08lx\n",
-		       __func__, exit_nr, vcpu->arch.pc);
+		       __func__, exit_nr, vcpu->arch.regs.nip);
 		run->hw.hardware_exit_reason = exit_nr;
 		r = RESUME_HOST;
 		break;
@@ -575,7 +579,7 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	}
 
 	case BOOKE_INTERRUPT_ITLB_MISS: {
-		unsigned long eaddr = vcpu->arch.pc;
+		unsigned long eaddr = vcpu->arch.regs.nip;
 		gpa_t gpaddr;
 		gfn_t gfn;
 		int gtlb_index;
@@ -616,7 +620,7 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	case BOOKE_INTERRUPT_DEBUG: {
 		u32 dbsr;
 
-		vcpu->arch.pc = mfspr(SPRN_CSRR0);
+		vcpu->arch.regs.nip = mfspr(SPRN_CSRR0);
 
 		/* clear IAC events in DBSR register */
 		dbsr = mfspr(SPRN_DBSR);
@@ -658,7 +662,7 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 	int i;
 	int r;
 
-	vcpu->arch.pc = 0;
+	vcpu->arch.regs.nip = 0;
 	vcpu->arch.shared->msr = 0;
 	vcpu->arch.shadow_msr = MSR_USER | MSR_DE | MSR_IS | MSR_DS;
 	vcpu->arch.shared->pir = vcpu->vcpu_id;
@@ -683,10 +687,10 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
 	int i;
 
-	regs->pc = vcpu->arch.pc;
+	regs->pc = vcpu->arch.regs.nip;
 	regs->cr = kvmppc_get_cr(vcpu);
-	regs->ctr = vcpu->arch.ctr;
-	regs->lr = vcpu->arch.lr;
+	regs->ctr = vcpu->arch.regs.ctr;
+	regs->lr = vcpu->arch.regs.link;
 	regs->xer = kvmppc_get_xer(vcpu);
 	regs->msr = vcpu->arch.shared->msr;
 	regs->srr0 = vcpu->arch.shared->srr0;
@@ -711,10 +715,10 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
 	int i;
 
-	vcpu->arch.pc = regs->pc;
+	vcpu->arch.regs.nip = regs->pc;
 	kvmppc_set_cr(vcpu, regs->cr);
-	vcpu->arch.ctr = regs->ctr;
-	vcpu->arch.lr = regs->lr;
+	vcpu->arch.regs.ctr = regs->ctr;
+	vcpu->arch.regs.link = regs->lr;
 	kvmppc_set_xer(vcpu, regs->xer);
 	kvmppc_set_msr(vcpu, regs->msr);
 	vcpu->arch.shared->srr0 = regs->srr0;
diff --git a/arch/powerpc/kvm/booke_emulate.c b/arch/powerpc/kvm/booke_emulate.c
index 3e652da..a4af03b 100644
--- a/arch/powerpc/kvm/booke_emulate.c
+++ b/arch/powerpc/kvm/booke_emulate.c
@@ -32,7 +32,7 @@
 
 static void kvmppc_emul_rfi(struct kvm_vcpu *vcpu)
 {
-	vcpu->arch.pc = vcpu->arch.shared->srr0;
+	vcpu->arch.regs.nip = vcpu->arch.shared->srr0;
 	kvmppc_set_msr(vcpu, vcpu->arch.shared->srr1);
 }
 
diff --git a/arch/powerpc/kvm/e500_tlb.c b/arch/powerpc/kvm/e500_tlb.c
index 6e53e41..6e9bc42 100644
--- a/arch/powerpc/kvm/e500_tlb.c
+++ b/arch/powerpc/kvm/e500_tlb.c
@@ -1021,7 +1021,7 @@ void kvmppc_mmu_itlb_miss(struct kvm_vcpu *vcpu)
 {
 	unsigned int as = !!(vcpu->arch.shared->msr & MSR_IS);
 
-	kvmppc_e500_deliver_tlb_miss(vcpu, vcpu->arch.pc, as);
+	kvmppc_e500_deliver_tlb_miss(vcpu, vcpu->arch.regs.nip, as);
 }
 
 void kvmppc_mmu_dtlb_miss(struct kvm_vcpu *vcpu)
-- 
1.7.7.rc3.4.g8d714
