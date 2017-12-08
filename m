Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ytMRw4HXPzDrqW
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Dec 2017 17:11:24 +1100 (AEDT)
Date: Fri, 8 Dec 2017 17:11:13 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Cc: David Gibson <david@gibson.dropbear.id.au>
Subject: [RFC PATCH 2/2] KVM: PPC: Book3S HV: Work around transactional
 memory bugs in POWER9
Message-ID: <20171208061113.sm2cuug2uypdduw5@rohan>
References: <20171208060803.relvzabipgl2lub6@rohan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171208060803.relvzabipgl2lub6@rohan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

POWER9 has hardware bugs relating to transactional memory and thread
reconfiguration (changes to hardware SMT mode).  Specifically, the core
does not have enough storage to store a complete checkpoint of all the
architected state for all four threads.  The DD2.2 version of POWER9
includes hardware modifications designed to allow hypervisor software
to implement workarounds for these problems.  This patch implements
those workarounds in KVM code so that KVM guests see a full, working
transactional memory implementation.

The problems center around the use of TM suspended state, where the
CPU has a checkpointed state but execution is not transactional.  The
workaround is to implement a "fake suspend" state, which looks to the
guest like suspended state but the CPU does not store a checkpoint.
In this state, any instruction that would cause a transition to
transactional state (rfid, rfebb, mtmsrd, tresume) or would use the
checkpointed state (treclaim) causes a "soft patch" interrupt (vector
0x1500) to the hypervisor so that it can be emulated.  The trechkpt
instruction also causes a soft patch interrupt.

On POWER9 DD2.2, we avoid returning to the guest in any state which
would require a checkpoint to be present.  The trechkpt in the guest
entry path which would normally create that checkpoint is replaced by
either a transition to fake suspend state, if the guest is in suspend
state, or a rollback to the pre-transactional state if the guest is in
transactional state.  Fake suspend state is indicated by a flag in the
PACA plus a new bit in the PSSCR.  The new PSSCR bit is write-only and
reads back as 0.

On exit from the guest, if the guest is in fake suspend state, we still
do the treclaim instruction as we would in real suspend state, in order
to get into non-transactional state, but we do not save the resulting
register state since there was no checkpoint.

Emulation of the instructions that cause a softpath interrupt is handled
in two paths.  If the guest is in real suspend mode, we call
kvmhv_p9_tm_emulation_early() to handle the cases where the guest is
transitioning to transactional state.  This is called before we do
the treclaim in the guest exit path; because we haven't done treclaim,
we can get back to the guest with the transaction still active.
If the instruction is a case that kvmhv_p9_tm_emulation_early() doesn't
handle, or if the guest is in fake suspend state, then we proceed to
do the complete guest exit path and subsequently call
kvmhv_p9_tm_emulation() in host context with the MMU on.  This
handles all the cases including the cases that generate program
interrupts (illegal instruction or TM Bad Thing) and facility
unavailable interrupts.

The emulation is reasonably straightforward and is mostly concerned
with checking for exception conditions and updating the state of
registers such as MSR and CR0.  The treclaim emulation takes care to
ensure that the TEXASR register gets updated as if it were the guest
treclaim instruction that had done failure recording, not the treclaim
done in hypervisor state in the guest exit path.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/kvm_asm.h        |   2 +
 arch/powerpc/include/asm/kvm_book3s.h     |   4 +
 arch/powerpc/include/asm/kvm_book3s_64.h  |  41 ++++++
 arch/powerpc/include/asm/kvm_book3s_asm.h |   1 +
 arch/powerpc/include/asm/kvm_host.h       |   1 +
 arch/powerpc/include/asm/ppc-opcode.h     |   4 +
 arch/powerpc/include/asm/reg.h            |   6 +
 arch/powerpc/kernel/asm-offsets.c         |   2 +
 arch/powerpc/kernel/exceptions-64s.S      |   4 +-
 arch/powerpc/kvm/Makefile                 |   2 +
 arch/powerpc/kvm/book3s_hv.c              |  12 ++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S   |  93 ++++++++++++-
 arch/powerpc/kvm/book3s_hv_tm.c           | 217 ++++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_hv_tm_builtin.c   | 109 +++++++++++++++
 14 files changed, 495 insertions(+), 3 deletions(-)
 create mode 100644 arch/powerpc/kvm/book3s_hv_tm.c
 create mode 100644 arch/powerpc/kvm/book3s_hv_tm_builtin.c

diff --git a/arch/powerpc/include/asm/kvm_asm.h b/arch/powerpc/include/asm/kvm_asm.h
index 09a802bb702f..a790d5cf6ea3 100644
--- a/arch/powerpc/include/asm/kvm_asm.h
+++ b/arch/powerpc/include/asm/kvm_asm.h
@@ -108,6 +108,8 @@
 
 /* book3s_hv */
 
+#define BOOK3S_INTERRUPT_HV_SOFTPATCH	0x1500
+
 /*
  * Special trap used to indicate to host that this is a
  * passthrough interrupt that could not be handled
diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index b8d5b8e35244..d302f4ed8385 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -240,6 +240,10 @@ extern void kvmppc_update_lpcr(struct kvm *kvm, unsigned long lpcr,
 			unsigned long mask);
 extern void kvmppc_set_fscr(struct kvm_vcpu *vcpu, u64 fscr);
 
+extern int kvmhv_p9_tm_emulation_early(struct kvm_vcpu *vcpu);
+extern int kvmhv_p9_tm_emulation(struct kvm_vcpu *vcpu);
+extern void kvmhv_emulate_tm_rollback(struct kvm_vcpu *vcpu);
+
 extern void kvmppc_entry_trampoline(void);
 extern void kvmppc_hv_entry_trampoline(void);
 extern u32 kvmppc_alignment_dsisr(struct kvm_vcpu *vcpu, unsigned int inst);
diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index d55c7f881ce7..884617208640 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -370,6 +370,47 @@ static inline unsigned long kvmppc_hpt_mask(struct kvm_hpt_info *hpt)
 	return (1UL << (hpt->order - 7)) - 1;
 }
 
+static inline u64 sanitize_msr(u64 msr)
+{
+	msr &= ~MSR_HV;
+	msr |= MSR_ME;
+	return msr;
+}
+
+static inline void copy_from_checkpoint(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.cr  = vcpu->arch.cr_tm;
+	vcpu->arch.xer = vcpu->arch.xer_tm;
+	vcpu->arch.lr  = vcpu->arch.lr_tm;
+	vcpu->arch.ctr = vcpu->arch.ctr_tm;
+	vcpu->arch.amr = vcpu->arch.amr_tm;
+	vcpu->arch.ppr = vcpu->arch.ppr_tm;
+	vcpu->arch.dscr = vcpu->arch.dscr_tm;
+	vcpu->arch.tar = vcpu->arch.tar_tm;
+	memcpy(vcpu->arch.gpr, vcpu->arch.gpr_tm,
+	       sizeof(vcpu->arch.gpr));
+	vcpu->arch.fp  = vcpu->arch.fp_tm;
+	vcpu->arch.vr  = vcpu->arch.vr_tm;
+	vcpu->arch.vrsave = vcpu->arch.vrsave_tm;
+}
+
+static inline void copy_to_checkpoint(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.cr_tm  = vcpu->arch.cr;
+	vcpu->arch.xer_tm = vcpu->arch.xer;
+	vcpu->arch.lr_tm  = vcpu->arch.lr;
+	vcpu->arch.ctr_tm = vcpu->arch.ctr;
+	vcpu->arch.amr_tm = vcpu->arch.amr;
+	vcpu->arch.ppr_tm = vcpu->arch.ppr;
+	vcpu->arch.dscr_tm = vcpu->arch.dscr;
+	vcpu->arch.tar_tm = vcpu->arch.tar;
+	memcpy(vcpu->arch.gpr_tm, vcpu->arch.gpr,
+	       sizeof(vcpu->arch.gpr));
+	vcpu->arch.fp_tm  = vcpu->arch.fp;
+	vcpu->arch.vr_tm  = vcpu->arch.vr;
+	vcpu->arch.vrsave_tm = vcpu->arch.vrsave;
+}
+
 #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
 
 #endif /* __ASM_KVM_BOOK3S_64_H__ */
diff --git a/arch/powerpc/include/asm/kvm_book3s_asm.h b/arch/powerpc/include/asm/kvm_book3s_asm.h
index 83596f32f50b..52f70144f0c6 100644
--- a/arch/powerpc/include/asm/kvm_book3s_asm.h
+++ b/arch/powerpc/include/asm/kvm_book3s_asm.h
@@ -112,6 +112,7 @@ struct kvmppc_host_state {
 	u8 hwthread_state;
 	u8 host_ipi;
 	u8 ptid;
+	u8 fake_suspend;
 	struct kvm_vcpu *kvm_vcpu;
 	struct kvmppc_vcore *kvm_vcore;
 	void __iomem *xics_phys;
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index e372ed871c51..a4054797e036 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -612,6 +612,7 @@ struct kvm_vcpu_arch {
 	u64 tfhar;
 	u64 texasr;
 	u64 tfiar;
+	u64 orig_texasr;
 
 	u32 cr_tm;
 	u64 xer_tm;
diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index ce0930d68857..15d4fde570f6 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -226,6 +226,7 @@
 #define PPC_INST_MSGSYNC		0x7c0006ec
 #define PPC_INST_MSGSNDP		0x7c00011c
 #define PPC_INST_MSGCLRP		0x7c00015c
+#define PPC_INST_MTMSRD			0x7c000164
 #define PPC_INST_MTTMR			0x7c0003dc
 #define PPC_INST_NOP			0x60000000
 #define PPC_INST_PASTE			0x7c20070d
@@ -233,8 +234,10 @@
 #define PPC_INST_POPCNTB_MASK		0xfc0007fe
 #define PPC_INST_POPCNTD		0x7c0003f4
 #define PPC_INST_POPCNTW		0x7c0002f4
+#define PPC_INST_RFEBB			0x4c000124
 #define PPC_INST_RFCI			0x4c000066
 #define PPC_INST_RFDI			0x4c00004e
+#define PPC_INST_RFID			0x4c000024
 #define PPC_INST_RFMCI			0x4c00004c
 #define PPC_INST_MFSPR_DSCR		0x7c1102a6
 #define PPC_INST_MFSPR_DSCR_MASK	0xfc1ffffe
@@ -270,6 +273,7 @@
 #define PPC_INST_TRECHKPT		0x7c0007dd
 #define PPC_INST_TRECLAIM		0x7c00075d
 #define PPC_INST_TABORT			0x7c00071d
+#define PPC_INST_TSR			0x7c0005dd
 
 #define PPC_INST_NAP			0x4c000364
 #define PPC_INST_SLEEP			0x4c0003a4
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index b779f3ccd412..889328d264fb 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -156,6 +156,7 @@
 #define PSSCR_SD		0x00400000 /* Status Disable */
 #define PSSCR_PLS	0xf000000000000000 /* Power-saving Level Status */
 #define PSSCR_GUEST_VIS	0xf0000000000003ff /* Guest-visible PSSCR fields */
+#define PSSCR_FAKE_SUSPEND	0x00000400 /* Fake-suspend bit (P9 DD2.2) */
 
 /* Floating Point Status and Control Register (FPSCR) Fields */
 #define FPSCR_FX	0x80000000	/* FPU exception summary */
@@ -237,7 +238,12 @@
 #define SPRN_TFIAR	0x81	/* Transaction Failure Inst Addr   */
 #define SPRN_TEXASR	0x82	/* Transaction EXception & Summary */
 #define SPRN_TEXASRU	0x83	/* ''	   ''	   ''	 Upper 32  */
+#define   TEXASR_ABORT	__MASK(63-31) /* terminated by tabort or treclaim */
+#define   TEXASR_SUSP	__MASK(63-32) /* tx failed in suspended state */
+#define   TEXASR_HV	__MASK(63-34) /* MSR[HV] when failure occurred */
+#define   TEXASR_PR	__MASK(63-35) /* MSR[PR] when failure occurred */
 #define   TEXASR_FS	__MASK(63-36) /* TEXASR Failure Summary */
+#define   TEXASR_EXACT	__MASK(63-37) /* TFIAR value is exact */
 #define SPRN_TFHAR	0x80	/* Transaction Failure Handler Addr */
 #define SPRN_TIDR	144	/* Thread ID register */
 #define SPRN_CTRLF	0x088
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 8cfb20e38cfe..a513e5b9ac67 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -561,6 +561,7 @@ int main(void)
 	OFFSET(VCPU_TFHAR, kvm_vcpu, arch.tfhar);
 	OFFSET(VCPU_TFIAR, kvm_vcpu, arch.tfiar);
 	OFFSET(VCPU_TEXASR, kvm_vcpu, arch.texasr);
+	OFFSET(VCPU_ORIG_TEXASR, kvm_vcpu, arch.orig_texasr);
 	OFFSET(VCPU_GPR_TM, kvm_vcpu, arch.gpr_tm);
 	OFFSET(VCPU_FPRS_TM, kvm_vcpu, arch.fp_tm.fpr);
 	OFFSET(VCPU_VRS_TM, kvm_vcpu, arch.vr_tm.vr);
@@ -642,6 +643,7 @@ int main(void)
 	HSTATE_FIELD(HSTATE_SAVED_XIRR, saved_xirr);
 	HSTATE_FIELD(HSTATE_HOST_IPI, host_ipi);
 	HSTATE_FIELD(HSTATE_PTID, ptid);
+	HSTATE_FIELD(HSTATE_FAKE_SUSPEND, fake_suspend);
 	HSTATE_FIELD(HSTATE_MMCR0, host_mmcr[0]);
 	HSTATE_FIELD(HSTATE_MMCR1, host_mmcr[1]);
 	HSTATE_FIELD(HSTATE_MMCRA, host_mmcr[2]);
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 1c80bd292e48..73bc08f8c9e1 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1225,7 +1225,7 @@ EXC_REAL_BEGIN(denorm_exception_hv, 0x1500, 0x100)
 	bne+	denorm_assist
 #endif
 
-	KVMTEST_PR(0x1500)
+	KVMTEST_HV(0x1500)
 	EXCEPTION_PROLOG_PSERIES_1(denorm_common, EXC_HV)
 EXC_REAL_END(denorm_exception_hv, 0x1500, 0x100)
 
@@ -1237,7 +1237,7 @@ EXC_VIRT_END(denorm_exception, 0x5500, 0x100)
 EXC_VIRT_NONE(0x5500, 0x100)
 #endif
 
-TRAMP_KVM_SKIP(PACA_EXGEN, 0x1500)
+TRAMP_KVM_HV(PACA_EXGEN, 0x1500)
 
 #ifdef CONFIG_PPC_DENORMALISATION
 TRAMP_REAL_BEGIN(denorm_assist)
diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
index 85ba80de7133..de32ad161511 100644
--- a/arch/powerpc/kvm/Makefile
+++ b/arch/powerpc/kvm/Makefile
@@ -70,6 +70,7 @@ endif
 
 kvm-hv-y += \
 	book3s_hv.o \
+	book3s_hv_tm.o \
 	book3s_hv_interrupts.o \
 	book3s_64_mmu_hv.o \
 	book3s_64_mmu_radix.o
@@ -84,6 +85,7 @@ kvm-book3s_64-builtin-objs-$(CONFIG_KVM_BOOK3S_64_HANDLER) += \
 	book3s_hv_rm_mmu.o \
 	book3s_hv_ras.o \
 	book3s_hv_builtin.o \
+	book3s_hv_tm_builtin.o \
 	$(kvm-book3s_64-builtin-xics-objs-y)
 endif
 
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 8d43cf205d34..d3a18533efbf 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1191,6 +1191,17 @@ static int kvmppc_handle_exit_hv(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			r = RESUME_GUEST;
 		}
 		break;
+
+	case BOOK3S_INTERRUPT_HV_SOFTPATCH:
+		/*
+		 * This occurs for various TM-related instructions that
+		 * we need to emulate on POWER9 DD2.2.  We have already
+		 * handled the cases where the guest was in real-suspend
+		 * mode and was transitioning to transactional state.
+		 */
+		r = kvmhv_p9_tm_emulation(vcpu);
+		break;
+
 	case BOOK3S_INTERRUPT_HV_RM_HARD:
 		r = RESUME_PASSTHROUGH;
 		break;
@@ -2230,6 +2241,7 @@ static void kvmppc_start_thread(struct kvm_vcpu *vcpu, struct kvmppc_vcore *vc)
 	tpaca = &paca[cpu];
 	tpaca->kvm_hstate.kvm_vcpu = vcpu;
 	tpaca->kvm_hstate.ptid = cpu - vc->pcpu;
+	tpaca->kvm_hstate.fake_suspend = 0;
 	/* Order stores to hstate.kvm_vcpu etc. before store to kvm_vcore */
 	smp_wmb();
 	tpaca->kvm_hstate.kvm_vcore = vc;
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 42639fba89e8..b2d0539f27d3 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -1287,6 +1287,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	std	r3, VCPU_CTR(r9)
 	std	r4, VCPU_XER(r9)
 
+	/* For softpatch interrupt, go off and do TM instruction emulation */
+	cmpwi	r12, BOOK3S_INTERRUPT_HV_SOFTPATCH
+	beq	kvmppc_tm_emul
+
 	/* If this is a page table miss then see if it's theirs or ours */
 	cmpwi	r12, BOOK3S_INTERRUPT_H_DATA_STORAGE
 	beq	kvmppc_hdsi
@@ -1956,6 +1960,40 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_RADIX)
 	mtlr	r0
 	blr
 
+/*
+ * Softpatch interrupt for transactional memory emulation cases
+ * on POWER9 DD2.2.  This is early in the guest exit path - we
+ * haven't saved registers or done a treclaim yet.
+ */
+kvmppc_tm_emul:
+	/* Save instruction image in HEIR */
+	mfspr	r3, SPRN_HEIR
+	stw	r3, VCPU_HEIR(r9)
+
+	/*
+	 * The cases we want to handle here are those where the guest
+	 * is in real suspend mode and is trying to transition to
+	 * transactional mode.
+	 */
+	lbz	r0, HSTATE_FAKE_SUSPEND(r13)
+	cmpwi	r0, 0		/* keep exiting guest if in fake suspend */
+	bne	guest_exit_cont
+	rldicl	r3, r11, 64 - MSR_TS_S_LG, 62
+	cmpwi	r3, 1		/* or if not in suspend state */
+	bne	guest_exit_cont
+
+	/* Call C code to do the emulation */
+	mr	r3, r9
+	bl	kvmhv_p9_tm_emulation_early
+	nop
+	ld	r9, HSTATE_KVM_VCPU(r13)
+	li	r12, BOOK3S_INTERRUPT_HV_SOFTPATCH
+	cmpwi	r3, 0
+	beq	guest_exit_cont		/* continue exiting if not handled */
+	ld	r10, VCPU_PC(r9)
+	ld	r11, VCPU_MSR(r9)
+	b	fast_interrupt_c_return	/* go back to guest if handled */
+
 /*
  * Check whether an HDSI is an HPTE not found fault or something else.
  * If it is an HPTE not found fault that is due to the guest accessing
@@ -2925,6 +2963,12 @@ kvmppc_save_tm:
 	std	r1, HSTATE_HOST_R1(r13)
 	li	r3, TM_CAUSE_KVM_RESCHED
 
+BEGIN_FTR_SECTION
+	/* Emulation of the treclaim instruction needs TEXASR before treclaim */
+	mfspr	r6, SPRN_TEXASR
+	std	r6, VCPU_ORIG_TEXASR(r9)
+END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_EMUL)
+
 	/* Clear the MSR RI since r1, r13 are all going to be foobar. */
 	li	r5, 0
 	mtmsrd	r5, 1
@@ -2936,6 +2980,29 @@ kvmppc_save_tm:
 	SET_SCRATCH0(r13)
 	GET_PACA(r13)
 	std	r9, PACATMSCRATCH(r13)
+
+	/* If doing TM emulation on POWER9 DD2.2, check for fake suspend mode */
+BEGIN_FTR_SECTION
+	lbz	r9, HSTATE_FAKE_SUSPEND(r13)
+	cmpwi	r9, 0
+	beq	2f
+	/*
+	 * We were in fake suspend, so the treclaim above didn't
+	 * change any registers, therefore we can now use any volatile GPR.
+	 */
+	li	r5, MSR_RI
+	mtmsrd	r5, 1
+	li	r0, 0
+	stb	r0, HSTATE_FAKE_SUSPEND(r13)
+	mfspr	r3, SPRN_PSSCR
+	/* PSSCR_FAKE_SUSPEND is a write-only bit, but clear it anyway */
+	li	r0, PSSCR_FAKE_SUSPEND
+	andc	r3, r3, r0
+	mtspr	SPRN_PSSCR, r3
+	b	1f
+2:
+END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_EMUL)
+
 	ld	r9, HSTATE_KVM_VCPU(r13)
 
 	/* Get a few more GPRs free. */
@@ -3060,6 +3127,15 @@ kvmppc_restore_tm:
 	oris	r7, r7, (TEXASR_FS)@h
 	mtspr	SPRN_TEXASR, r7
 
+	/*
+	 * If we are doing TM emulation for the guest on a POWER9 DD2,
+	 * then we don't actually do a trechkpt -- we either set up
+	 * fake-suspend mode, or emulate a TM rollback.
+	 */
+BEGIN_FTR_SECTION
+	b	.Ldo_tm_fake_load
+END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_EMUL)
+
 	/*
 	 * We need to load up the checkpointed state for the guest.
 	 * We need to do this early as it will blow away any GPRs, VSRs and
@@ -3132,10 +3208,25 @@ kvmppc_restore_tm:
 	/* Set the MSR RI since we have our registers back. */
 	li	r5, MSR_RI
 	mtmsrd	r5, 1
-
+9:
 	ld	r0, PPC_LR_STKOFF(r1)
 	mtlr	r0
 	blr
+
+.Ldo_tm_fake_load:
+	cmpwi	r5, 1		/* check for suspended state */
+	bgt	10f
+	stb	r5, HSTATE_FAKE_SUSPEND(r13)
+	mfspr	r6, SPRN_PSSCR
+	ori	r6, r6, PSSCR_FAKE_SUSPEND
+	mtspr	SPRN_PSSCR, r6	/* set it in HW too */
+	b	9b		/* and return */
+10:	stdu	r1, -PPC_MIN_STKFRM(r1)
+	/* guest is in transactional state, so simulate rollback */
+	bl	kvmhv_emulate_tm_rollback
+	nop
+	addi	r1, r1, PPC_MIN_STKFRM
+	b	9b
 #endif
 
 /*
diff --git a/arch/powerpc/kvm/book3s_hv_tm.c b/arch/powerpc/kvm/book3s_hv_tm.c
new file mode 100644
index 000000000000..4a2bef347f66
--- /dev/null
+++ b/arch/powerpc/kvm/book3s_hv_tm.c
@@ -0,0 +1,217 @@
+/*
+ * Copyright 2017 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kvm_host.h>
+
+#include <asm/kvm_ppc.h>
+#include <asm/kvm_book3s.h>
+#include <asm/kvm_book3s_64.h>
+#include <asm/reg.h>
+#include <asm/ppc-opcode.h>
+
+static void emulate_tx_failure(struct kvm_vcpu *vcpu, u64 failure_cause)
+{
+	u64 texasr, tfiar;
+	u64 msr = vcpu->arch.shregs.msr;
+
+	tfiar = vcpu->arch.pc & ~0x3ull;
+	texasr = (failure_cause << 56) | TEXASR_ABORT | TEXASR_FS | TEXASR_EXACT;
+	if (MSR_TM_SUSPENDED(vcpu->arch.shregs.msr))
+		texasr |= TEXASR_SUSP;
+	if (msr & MSR_PR) {
+		texasr |= TEXASR_PR;
+		tfiar |= 1;
+	}
+	vcpu->arch.tfiar = tfiar;
+	/* Preserve ROT and TL fields of existing TEXASR */
+	vcpu->arch.texasr = (vcpu->arch.texasr & 0x3ffffff) | texasr;
+}
+
+/*
+ * This gets called on a softpatch interrupt on POWER9 DD2.2 processors.
+ * We expect to find a TM-related instruction to be emulated.  The
+ * instruction image is in vcpu->arch.emul_inst.  If the guest was in
+ * TM suspended or transactional state, the checkpointed state has been
+ * reclaimed and is in the vcpu struct.  The CPU is in virtual mode in
+ * host context.
+ */
+int kvmhv_p9_tm_emulation(struct kvm_vcpu *vcpu)
+{
+	u32 instr = vcpu->arch.emul_inst;
+	u64 msr = vcpu->arch.shregs.msr;
+	u64 newmsr, bescr;
+	int ra, rs;
+
+	switch (instr & 0xfc0007ff) {
+	case PPC_INST_RFID:
+		/* XXX do we need to check for PR=0 here? */
+		newmsr = vcpu->arch.shregs.srr1;
+		/* should only get here for Sx -> T1 transition */
+		WARN_ON_ONCE(!(MSR_TM_SUSPENDED(msr) &&
+			       MSR_TM_TRANSACTIONAL(newmsr) &&
+			       (newmsr & MSR_TM)));
+		newmsr = sanitize_msr(newmsr);
+		vcpu->arch.shregs.msr = newmsr;
+		vcpu->arch.cfar = vcpu->arch.pc - 4;
+		vcpu->arch.pc = vcpu->arch.shregs.srr0;
+		return RESUME_GUEST;
+
+	case PPC_INST_RFEBB:
+		if ((msr & MSR_PR) && (vcpu->arch.vcore->pcr & PCR_ARCH_206)) {
+			/* generate an illegal instruction interrupt */
+			kvmppc_core_queue_program(vcpu, SRR1_PROGILL);
+			return RESUME_GUEST;
+		}
+		/* check EBB facility is available */
+		if (!(vcpu->arch.hfscr & HFSCR_EBB)) {
+			/* generate an illegal instruction interrupt */
+			kvmppc_core_queue_program(vcpu, SRR1_PROGILL);
+			return RESUME_GUEST;
+		}
+		if ((msr & MSR_PR) && !(vcpu->arch.fscr & FSCR_EBB)) {
+			/* generate a facility unavailable interrupt */
+			vcpu->arch.fscr = (vcpu->arch.fscr & ~(0xffull << 56)) |
+				((u64)FSCR_EBB_LG << 56);
+			kvmppc_book3s_queue_irqprio(vcpu, BOOK3S_INTERRUPT_FAC_UNAVAIL);
+			return RESUME_GUEST;
+		}
+		bescr = vcpu->arch.bescr;
+		/* expect to see a S->T transition requested */
+		WARN_ON_ONCE(!(MSR_TM_SUSPENDED(msr) &&
+			       ((bescr >> 30) & 3) == 2));
+		bescr &= ~BESCR_GE;
+		if (instr & (1 << 11))
+			bescr |= BESCR_GE;
+		vcpu->arch.bescr = bescr;
+		msr = (msr & ~MSR_TS_MASK) | MSR_TS_T;
+		vcpu->arch.shregs.msr = msr;
+		vcpu->arch.cfar = vcpu->arch.pc - 4;
+		vcpu->arch.pc = vcpu->arch.ebbrr;
+		return RESUME_GUEST;
+
+	case PPC_INST_MTMSRD:
+		/* XXX do we need to check for PR=0 here? */
+		rs = (instr >> 21) & 0x1f;
+		newmsr = kvmppc_get_gpr(vcpu, rs);
+		/* check this is a Sx -> T1 transition */
+		WARN_ON_ONCE(!(MSR_TM_SUSPENDED(msr) &&
+			       MSR_TM_TRANSACTIONAL(newmsr) &&
+			       (newmsr & MSR_TM)));
+		/* mtmsrd doesn't change LE */
+		newmsr = (newmsr & ~MSR_LE) | (msr & MSR_LE);
+		newmsr = sanitize_msr(newmsr);
+		vcpu->arch.shregs.msr = newmsr;
+		return RESUME_GUEST;
+
+	case PPC_INST_TSR:
+		/* check for PR=1 and arch 2.06 bit set in PCR */
+		if ((msr & MSR_PR) && (vcpu->arch.vcore->pcr & PCR_ARCH_206)) {
+			/* generate an illegal instruction interrupt */
+			kvmppc_core_queue_program(vcpu, SRR1_PROGILL);
+			return RESUME_GUEST;
+		}
+		/* check for TM disabled in the HFSCR or MSR */
+		if (!(vcpu->arch.hfscr & HFSCR_TM)) {
+			/* generate an illegal instruction interrupt */
+			kvmppc_core_queue_program(vcpu, SRR1_PROGILL);
+			return RESUME_GUEST;
+		}
+		if (!(msr & MSR_TM)) {
+			/* generate a facility unavailable interrupt */
+			vcpu->arch.fscr = (vcpu->arch.fscr & ~(0xffull << 56)) |
+				((u64)FSCR_TM_LG << 56);
+			kvmppc_book3s_queue_irqprio(vcpu,
+						BOOK3S_INTERRUPT_FAC_UNAVAIL);
+			return RESUME_GUEST;
+		}
+		/* Set CR0 to indicate previous transactional state */
+		vcpu->arch.cr = (vcpu->arch.cr & 0x0fffffff) |
+			(((msr & MSR_TS_MASK) >> MSR_TS_S_LG) << 28);
+		/* L=1 => tresume, L=0 => tsuspend */
+		if (instr & (1 << 21)) {
+			if (MSR_TM_SUSPENDED(msr))
+				msr = (msr & ~MSR_TS_MASK) | MSR_TS_T;
+		} else {
+			if (MSR_TM_TRANSACTIONAL(msr))
+				msr = (msr & ~MSR_TS_MASK) | MSR_TS_S;
+		}
+		vcpu->arch.shregs.msr = msr;
+		return RESUME_GUEST;
+
+	case PPC_INST_TRECLAIM:
+		/* XXX do we need to check for PR=0 here? */
+		/* check for TM disabled in the HFSCR or MSR */
+		if (!(vcpu->arch.hfscr & HFSCR_TM)) {
+			/* generate an illegal instruction interrupt */
+			kvmppc_core_queue_program(vcpu, SRR1_PROGILL);
+			return RESUME_GUEST;
+		}
+		if (!(msr & MSR_TM)) {
+			/* generate a facility unavailable interrupt */
+			vcpu->arch.fscr = (vcpu->arch.fscr & ~(0xffull << 56)) |
+				((u64)FSCR_TM_LG << 56);
+			kvmppc_book3s_queue_irqprio(vcpu,
+						BOOK3S_INTERRUPT_FAC_UNAVAIL);
+			return RESUME_GUEST;
+		}
+		/* If no transaction active, generate TM bad thing */
+		if (!MSR_TM_ACTIVE(msr)) {
+			kvmppc_core_queue_program(vcpu, SRR1_PROGTM);
+			return RESUME_GUEST;
+		}
+		/* If failure was not previously recorded, recompute TEXASR */
+		if (!(vcpu->arch.orig_texasr & TEXASR_FS)) {
+			ra = (instr >> 16) & 0x1f;
+			if (ra)
+				ra = kvmppc_get_gpr(vcpu, ra) & 0xff;
+			emulate_tx_failure(vcpu, ra);
+		}
+
+		copy_from_checkpoint(vcpu);
+
+		/* Set CR0 to indicate previous transactional state */
+		vcpu->arch.cr = (vcpu->arch.cr & 0x0fffffff) |
+			(((msr & MSR_TS_MASK) >> MSR_TS_S_LG) << 28);
+		vcpu->arch.shregs.msr &= ~MSR_TS_MASK;
+		return RESUME_GUEST;
+
+	case PPC_INST_TRECHKPT:
+		/* XXX do we need to check for PR=0 here? */
+		/* check for TM disabled in the HFSCR or MSR */
+		if (!(vcpu->arch.hfscr & HFSCR_TM)) {
+			/* generate an illegal instruction interrupt */
+			kvmppc_core_queue_program(vcpu, SRR1_PROGILL);
+			return RESUME_GUEST;
+		}
+		if (!(msr & MSR_TM)) {
+			/* generate a facility unavailable interrupt */
+			vcpu->arch.fscr = (vcpu->arch.fscr & ~(0xffull << 56)) |
+				((u64)FSCR_TM_LG << 56);
+			kvmppc_book3s_queue_irqprio(vcpu,
+						BOOK3S_INTERRUPT_FAC_UNAVAIL);
+			return RESUME_GUEST;
+		}
+		/* If transaction active or TEXASR[FS] = 0, bad thing */
+		if (MSR_TM_ACTIVE(msr) || !(vcpu->arch.texasr & TEXASR_FS)) {
+			kvmppc_core_queue_program(vcpu, SRR1_PROGTM);
+			return RESUME_GUEST;
+		}
+
+		copy_to_checkpoint(vcpu);
+
+		/* Set CR0 to indicate previous transactional state */
+		vcpu->arch.cr = (vcpu->arch.cr & 0x0fffffff) |
+			(((msr & MSR_TS_MASK) >> MSR_TS_S_LG) << 28);
+		vcpu->arch.shregs.msr = msr | MSR_TS_S;
+		return RESUME_GUEST;
+	}
+
+	/* What should we do here? We didn't recognize the instruction */
+	WARN_ON_ONCE(1);
+	return RESUME_GUEST;
+}
diff --git a/arch/powerpc/kvm/book3s_hv_tm_builtin.c b/arch/powerpc/kvm/book3s_hv_tm_builtin.c
new file mode 100644
index 000000000000..d98ccfd2b88c
--- /dev/null
+++ b/arch/powerpc/kvm/book3s_hv_tm_builtin.c
@@ -0,0 +1,109 @@
+/*
+ * Copyright 2017 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kvm_host.h>
+
+#include <asm/kvm_ppc.h>
+#include <asm/kvm_book3s.h>
+#include <asm/kvm_book3s_64.h>
+#include <asm/reg.h>
+#include <asm/ppc-opcode.h>
+
+/*
+ * This handles the cases where the guest is in real suspend mode
+ * and we want to get back to the guest without dooming the transaction.
+ * The caller has checked that the guest is in real-suspend mode
+ * (MSR[TS] = S and the fake-suspend flag is not set).
+ */
+int kvmhv_p9_tm_emulation_early(struct kvm_vcpu *vcpu)
+{
+	u32 instr = vcpu->arch.emul_inst;
+	u64 newmsr, msr, bescr;
+	int rs;
+
+	switch (instr & 0xfc0007ff) {
+	case PPC_INST_RFID:
+		/* XXX do we need to check for PR=0 here? */
+		newmsr = vcpu->arch.shregs.srr1;
+		/* should only get here for Sx -> T1 transition */
+		if (!(MSR_TM_TRANSACTIONAL(newmsr) && (newmsr & MSR_TM)))
+			return 0;
+		newmsr = sanitize_msr(newmsr);
+		vcpu->arch.shregs.msr = newmsr;
+		vcpu->arch.cfar = vcpu->arch.pc - 4;
+		vcpu->arch.pc = vcpu->arch.shregs.srr0;
+		return 1;
+
+	case PPC_INST_RFEBB:
+		/* check for PR=1 and arch 2.06 bit set in PCR */
+		msr = vcpu->arch.shregs.msr;
+		if ((msr & MSR_PR) && (vcpu->arch.vcore->pcr & PCR_ARCH_206))
+			return 0;
+		/* check EBB facility is available */
+		if (!(vcpu->arch.hfscr & HFSCR_EBB) ||
+		    ((msr & MSR_PR) && !(mfspr(SPRN_FSCR) & FSCR_EBB)))
+			return 0;
+		bescr = mfspr(SPRN_BESCR);
+		/* expect to see a S->T transition requested */
+		if (((bescr >> 30) & 3) != 2)
+			return 0;
+		bescr &= ~BESCR_GE;
+		if (instr & (1 << 11))
+			bescr |= BESCR_GE;
+		mtspr(SPRN_BESCR, bescr);
+		msr = (msr & ~MSR_TS_MASK) | MSR_TS_T;
+		vcpu->arch.shregs.msr = msr;
+		vcpu->arch.cfar = vcpu->arch.pc - 4;
+		vcpu->arch.pc = mfspr(SPRN_EBBRR);
+		return 1;
+
+	case PPC_INST_MTMSRD:
+		/* XXX do we need to check for PR=0 here? */
+		rs = (instr >> 21) & 0x1f;
+		newmsr = kvmppc_get_gpr(vcpu, rs);
+		msr = vcpu->arch.shregs.msr;
+		/* check this is a Sx -> T1 transition */
+		if (!(MSR_TM_TRANSACTIONAL(newmsr) && (newmsr & MSR_TM)))
+			return 0;
+		/* mtmsrd doesn't change LE */
+		newmsr = (newmsr & ~MSR_LE) | (msr & MSR_LE);
+		newmsr = sanitize_msr(newmsr);
+		vcpu->arch.shregs.msr = newmsr;
+		return 1;
+
+	case PPC_INST_TSR:
+		/* we know the MSR has the TS field = S (0b01) here */
+		msr = vcpu->arch.shregs.msr;
+		/* check for PR=1 and arch 2.06 bit set in PCR */
+		if ((msr & MSR_PR) && (vcpu->arch.vcore->pcr & PCR_ARCH_206))
+			return 0;
+		/* check for TM disabled in the HFSCR or MSR */
+		if (!(vcpu->arch.hfscr & HFSCR_TM) || !(msr & MSR_TM))
+			return 0;
+		/* L=1 => tresume => set TS to T (0b10) */
+		if (instr & (1 << 21))
+			vcpu->arch.shregs.msr = (msr & ~MSR_TS_MASK) | MSR_TS_T;
+		/* Set CR0 to 0b0010 */
+		vcpu->arch.cr = (vcpu->arch.cr & 0x0fffffff) | 0x20000000;
+		return 1;
+	}
+
+	return 0;
+}
+
+/*
+ * This is called when we are returning to a guest in TM transactional
+ * state.  We roll the guest state back to the checkpointed state.
+ */
+void kvmhv_emulate_tm_rollback(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.shregs.msr &= ~MSR_TS_MASK;	/* go to N state */
+	vcpu->arch.pc = vcpu->arch.tfhar;
+	copy_from_checkpoint(vcpu);
+	vcpu->arch.cr = (vcpu->arch.cr & 0x0fffffff) | 0xa0000000;
+}
-- 
2.14.1
