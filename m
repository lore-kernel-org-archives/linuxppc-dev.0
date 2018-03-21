Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405mC950fVzF0x9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 21:25:09 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Cc: kvm-ppc@vger.kernel.org
Subject: [PATCH 3/5] KVM: PPC: Book3S HV: Work around transactional memory
 bugs in POWER9
Date: Wed, 21 Mar 2018 21:24:59 +1100
Message-Id: <1521627901-13547-4-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1521627901-13547-1-git-send-email-paulus@ozlabs.org>
References: <1521627901-13547-1-git-send-email-paulus@ozlabs.org>
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

Emulation of the instructions that cause a softpatch interrupt is
handled in two paths.  If the guest is in real suspend mode, we call
kvmhv_p9_tm_emulation_early() to handle the cases where the guest is
transitioning to transactional state.  This is called before we do the
treclaim in the guest exit path; because we haven't done treclaim, we
can get back to the guest with the transaction still active.  If the
instruction is a case that kvmhv_p9_tm_emulation_early() doesn't
handle, or if the guest is in fake suspend state, then we proceed to
do the complete guest exit path and subsequently call
kvmhv_p9_tm_emulation() in host context with the MMU on.  This handles
all the cases including the cases that generate program interrupts
(illegal instruction or TM Bad Thing) and facility unavailable
interrupts.

The emulation is reasonably straightforward and is mostly concerned
with checking for exception conditions and updating the state of
registers such as MSR and CR0.  The treclaim emulation takes care to
ensure that the TEXASR register gets updated as if it were the guest
treclaim instruction that had done failure recording, not the treclaim
done in hypervisor state in the guest exit path.

With this, the KVM_CAP_PPC_HTM capability returns true (1) even if
transactional memory is not available to host userspace.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/kvm_asm.h        |   2 +
 arch/powerpc/include/asm/kvm_book3s.h     |   4 +
 arch/powerpc/include/asm/kvm_book3s_64.h  |  43 ++++++
 arch/powerpc/include/asm/kvm_book3s_asm.h |   1 +
 arch/powerpc/include/asm/kvm_host.h       |   1 +
 arch/powerpc/include/asm/ppc-opcode.h     |   4 +
 arch/powerpc/include/asm/reg.h            |   7 +
 arch/powerpc/kernel/asm-offsets.c         |   2 +
 arch/powerpc/kernel/cputable.c            |   1 -
 arch/powerpc/kernel/exceptions-64s.S      |   4 +-
 arch/powerpc/kvm/Makefile                 |   7 +
 arch/powerpc/kvm/book3s_hv.c              |  18 ++-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S   | 143 +++++++++++++++++++-
 arch/powerpc/kvm/book3s_hv_tm.c           | 216 ++++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_hv_tm_builtin.c   | 109 +++++++++++++++
 arch/powerpc/kvm/powerpc.c                |   5 +-
 16 files changed, 557 insertions(+), 10 deletions(-)
 create mode 100644 arch/powerpc/kvm/book3s_hv_tm.c
 create mode 100644 arch/powerpc/kvm/book3s_hv_tm_builtin.c

diff --git a/arch/powerpc/include/asm/kvm_asm.h b/arch/powerpc/include/asm/kvm_asm.h
index 09a802b..a790d5c 100644
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
index 376ae80..4c02a73 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -241,6 +241,10 @@ extern void kvmppc_update_lpcr(struct kvm *kvm, unsigned long lpcr,
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
index 998f7b7..c424e44 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -472,6 +472,49 @@ static inline void set_dirty_bits_atomic(unsigned long *map, unsigned long i,
 			set_bit_le(i, map);
 }
 
+static inline u64 sanitize_msr(u64 msr)
+{
+	msr &= ~MSR_HV;
+	msr |= MSR_ME;
+	return msr;
+}
+
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
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
+#endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
+
 #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
 
 #endif /* __ASM_KVM_BOOK3S_64_H__ */
diff --git a/arch/powerpc/include/asm/kvm_book3s_asm.h b/arch/powerpc/include/asm/kvm_book3s_asm.h
index ab386af..d978fdf 100644
--- a/arch/powerpc/include/asm/kvm_book3s_asm.h
+++ b/arch/powerpc/include/asm/kvm_book3s_asm.h
@@ -119,6 +119,7 @@ struct kvmppc_host_state {
 	u8 host_ipi;
 	u8 ptid;		/* thread number within subcore when split */
 	u8 tid;			/* thread number within whole core */
+	u8 fake_suspend;
 	struct kvm_vcpu *kvm_vcpu;
 	struct kvmppc_vcore *kvm_vcore;
 	void __iomem *xics_phys;
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 1f53b56..deb5429 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -610,6 +610,7 @@ struct kvm_vcpu_arch {
 	u64 tfhar;
 	u64 texasr;
 	u64 tfiar;
+	u64 orig_texasr;
 
 	u32 cr_tm;
 	u64 xer_tm;
diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index f1083bc..772eff7 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -232,6 +232,7 @@
 #define PPC_INST_MSGSYNC		0x7c0006ec
 #define PPC_INST_MSGSNDP		0x7c00011c
 #define PPC_INST_MSGCLRP		0x7c00015c
+#define PPC_INST_MTMSRD			0x7c000164
 #define PPC_INST_MTTMR			0x7c0003dc
 #define PPC_INST_NOP			0x60000000
 #define PPC_INST_PASTE			0x7c20070d
@@ -239,8 +240,10 @@
 #define PPC_INST_POPCNTB_MASK		0xfc0007fe
 #define PPC_INST_POPCNTD		0x7c0003f4
 #define PPC_INST_POPCNTW		0x7c0002f4
+#define PPC_INST_RFEBB			0x4c000124
 #define PPC_INST_RFCI			0x4c000066
 #define PPC_INST_RFDI			0x4c00004e
+#define PPC_INST_RFID			0x4c000024
 #define PPC_INST_RFMCI			0x4c00004c
 #define PPC_INST_MFSPR			0x7c0002a6
 #define PPC_INST_MFSPR_DSCR		0x7c1102a6
@@ -277,6 +280,7 @@
 #define PPC_INST_TRECHKPT		0x7c0007dd
 #define PPC_INST_TRECLAIM		0x7c00075d
 #define PPC_INST_TABORT			0x7c00071d
+#define PPC_INST_TSR			0x7c0005dd
 
 #define PPC_INST_NAP			0x4c000364
 #define PPC_INST_SLEEP			0x4c0003a4
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index e6c7ead..cb0f272 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -156,6 +156,8 @@
 #define PSSCR_SD		0x00400000 /* Status Disable */
 #define PSSCR_PLS	0xf000000000000000 /* Power-saving Level Status */
 #define PSSCR_GUEST_VIS	0xf0000000000003ff /* Guest-visible PSSCR fields */
+#define PSSCR_FAKE_SUSPEND	0x00000400 /* Fake-suspend bit (P9 DD2.2) */
+#define PSSCR_FAKE_SUSPEND_LG	10	   /* Fake-suspend bit position */
 
 /* Floating Point Status and Control Register (FPSCR) Fields */
 #define FPSCR_FX	0x80000000	/* FPU exception summary */
@@ -237,7 +239,12 @@
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
index dbefe30..daf809a 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -568,6 +568,7 @@ int main(void)
 	OFFSET(VCPU_TFHAR, kvm_vcpu, arch.tfhar);
 	OFFSET(VCPU_TFIAR, kvm_vcpu, arch.tfiar);
 	OFFSET(VCPU_TEXASR, kvm_vcpu, arch.texasr);
+	OFFSET(VCPU_ORIG_TEXASR, kvm_vcpu, arch.orig_texasr);
 	OFFSET(VCPU_GPR_TM, kvm_vcpu, arch.gpr_tm);
 	OFFSET(VCPU_FPRS_TM, kvm_vcpu, arch.fp_tm.fpr);
 	OFFSET(VCPU_VRS_TM, kvm_vcpu, arch.vr_tm.vr);
@@ -650,6 +651,7 @@ int main(void)
 	HSTATE_FIELD(HSTATE_HOST_IPI, host_ipi);
 	HSTATE_FIELD(HSTATE_PTID, ptid);
 	HSTATE_FIELD(HSTATE_TID, tid);
+	HSTATE_FIELD(HSTATE_FAKE_SUSPEND, fake_suspend);
 	HSTATE_FIELD(HSTATE_MMCR0, host_mmcr[0]);
 	HSTATE_FIELD(HSTATE_MMCR1, host_mmcr[1]);
 	HSTATE_FIELD(HSTATE_MMCRA, host_mmcr[2]);
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 68052ea..b3de017 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -569,7 +569,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_INVALID,
 		.cpu_setup		= __setup_cpu_power9,
 		.cpu_restore		= __restore_cpu_power9,
-		.flush_tlb		= __flush_tlb_power9,
 		.machine_check_early	= __machine_check_early_realmode_p9,
 		.platform		= "power9",
 	},
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 3ac87e5..a19fbaa 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1273,7 +1273,7 @@ EXC_REAL_BEGIN(denorm_exception_hv, 0x1500, 0x100)
 	bne+	denorm_assist
 #endif
 
-	KVMTEST_PR(0x1500)
+	KVMTEST_HV(0x1500)
 	EXCEPTION_PROLOG_PSERIES_1(denorm_common, EXC_HV)
 EXC_REAL_END(denorm_exception_hv, 0x1500, 0x100)
 
@@ -1285,7 +1285,7 @@ EXC_VIRT_END(denorm_exception, 0x5500, 0x100)
 EXC_VIRT_NONE(0x5500, 0x100)
 #endif
 
-TRAMP_KVM_SKIP(PACA_EXGEN, 0x1500)
+TRAMP_KVM_HV(PACA_EXGEN, 0x1500)
 
 #ifdef CONFIG_PPC_DENORMALISATION
 TRAMP_REAL_BEGIN(denorm_assist)
diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
index 85ba80d..4b19da8 100644
--- a/arch/powerpc/kvm/Makefile
+++ b/arch/powerpc/kvm/Makefile
@@ -74,9 +74,15 @@ kvm-hv-y += \
 	book3s_64_mmu_hv.o \
 	book3s_64_mmu_radix.o
 
+kvm-hv-$(CONFIG_PPC_TRANSACTIONAL_MEM) += \
+	book3s_hv_tm.o
+
 kvm-book3s_64-builtin-xics-objs-$(CONFIG_KVM_XICS) := \
 	book3s_hv_rm_xics.o book3s_hv_rm_xive.o
 
+kvm-book3s_64-builtin-tm-objs-$(CONFIG_PPC_TRANSACTIONAL_MEM) += \
+	book3s_hv_tm_builtin.o
+
 ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 kvm-book3s_64-builtin-objs-$(CONFIG_KVM_BOOK3S_64_HANDLER) += \
 	book3s_hv_hmi.o \
@@ -84,6 +90,7 @@ kvm-book3s_64-builtin-objs-$(CONFIG_KVM_BOOK3S_64_HANDLER) += \
 	book3s_hv_rm_mmu.o \
 	book3s_hv_ras.o \
 	book3s_hv_builtin.o \
+	$(kvm-book3s_64-builtin-tm-objs-y) \
 	$(kvm-book3s_64-builtin-xics-objs-y)
 endif
 
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 8970735..a043bde 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1206,6 +1206,19 @@ static int kvmppc_handle_exit_hv(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			r = RESUME_GUEST;
 		}
 		break;
+
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	case BOOK3S_INTERRUPT_HV_SOFTPATCH:
+		/*
+		 * This occurs for various TM-related instructions that
+		 * we need to emulate on POWER9 DD2.2.  We have already
+		 * handled the cases where the guest was in real-suspend
+		 * mode and was transitioning to transactional state.
+		 */
+		r = kvmhv_p9_tm_emulation(vcpu);
+		break;
+#endif
+
 	case BOOK3S_INTERRUPT_HV_RM_HARD:
 		r = RESUME_PASSTHROUGH;
 		break;
@@ -1978,7 +1991,9 @@ static struct kvm_vcpu *kvmppc_core_vcpu_create_hv(struct kvm *kvm,
 	 * turn off the HFSCR bit, which causes those instructions to trap.
 	 */
 	vcpu->arch.hfscr = mfspr(SPRN_HFSCR);
-	if (!cpu_has_feature(CPU_FTR_TM))
+	if (cpu_has_feature(CPU_FTR_P9_TM_HV_ASSIST))
+		vcpu->arch.hfscr |= HFSCR_TM;
+	else if (!cpu_has_feature(CPU_FTR_TM_COMP))
 		vcpu->arch.hfscr &= ~HFSCR_TM;
 	if (cpu_has_feature(CPU_FTR_ARCH_300))
 		vcpu->arch.hfscr &= ~HFSCR_MSGP;
@@ -2242,6 +2257,7 @@ static void kvmppc_start_thread(struct kvm_vcpu *vcpu, struct kvmppc_vcore *vc)
 	tpaca = &paca[cpu];
 	tpaca->kvm_hstate.kvm_vcpu = vcpu;
 	tpaca->kvm_hstate.ptid = cpu - vc->pcpu;
+	tpaca->kvm_hstate.fake_suspend = 0;
 	/* Order stores to hstate.kvm_vcpu etc. before store to kvm_vcore */
 	smp_wmb();
 	tpaca->kvm_hstate.kvm_vcore = vc;
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index f31f357..5af6174 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -787,12 +787,18 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+/*
+ * Branch around the call if both CPU_FTR_TM and
+ * CPU_FTR_P9_TM_HV_ASSIST are off.
+ */
 BEGIN_FTR_SECTION
+	b	91f
+END_FTR_SECTION(CPU_FTR_TM | CPU_FTR_P9_TM_HV_ASSIST, 0)
 	/*
 	 * NOTE THAT THIS TRASHES ALL NON-VOLATILE REGISTERS INCLUDING CR
 	 */
 	bl	kvmppc_restore_tm
-END_FTR_SECTION_IFSET(CPU_FTR_TM)
+91:
 #endif
 
 	/* Load guest PMU registers */
@@ -915,11 +921,14 @@ BEGIN_FTR_SECTION
 	mtspr	SPRN_ACOP, r6
 	mtspr	SPRN_CSIGR, r7
 	mtspr	SPRN_TACR, r8
+	nop
 FTR_SECTION_ELSE
 	/* POWER9-only registers */
 	ld	r5, VCPU_TID(r4)
 	ld	r6, VCPU_PSSCR(r4)
+	lbz	r8, HSTATE_FAKE_SUSPEND(r13)
 	oris	r6, r6, PSSCR_EC@h	/* This makes stop trap to HV */
+	rldimi	r6, r8, PSSCR_FAKE_SUSPEND_LG, 63 - PSSCR_FAKE_SUSPEND_LG
 	ld	r7, VCPU_HFSCR(r4)
 	mtspr	SPRN_TIDR, r5
 	mtspr	SPRN_PSSCR, r6
@@ -1370,6 +1379,12 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	std	r3, VCPU_CTR(r9)
 	std	r4, VCPU_XER(r9)
 
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	/* For softpatch interrupt, go off and do TM instruction emulation */
+	cmpwi	r12, BOOK3S_INTERRUPT_HV_SOFTPATCH
+	beq	kvmppc_tm_emul
+#endif
+
 	/* If this is a page table miss then see if it's theirs or ours */
 	cmpwi	r12, BOOK3S_INTERRUPT_H_DATA_STORAGE
 	beq	kvmppc_hdsi
@@ -1729,12 +1744,18 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
 	bl	kvmppc_save_fp
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+/*
+ * Branch around the call if both CPU_FTR_TM and
+ * CPU_FTR_P9_TM_HV_ASSIST are off.
+ */
 BEGIN_FTR_SECTION
+	b	91f
+END_FTR_SECTION(CPU_FTR_TM | CPU_FTR_P9_TM_HV_ASSIST, 0)
 	/*
 	 * NOTE THAT THIS TRASHES ALL NON-VOLATILE REGISTERS INCLUDING CR
 	 */
 	bl	kvmppc_save_tm
-END_FTR_SECTION_IFSET(CPU_FTR_TM)
+91:
 #endif
 
 	/* Increment yield count if they have a VPA */
@@ -2054,6 +2075,42 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_RADIX)
 	mtlr	r0
 	blr
 
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
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
+#endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
+
 /*
  * Check whether an HDSI is an HPTE not found fault or something else.
  * If it is an HPTE not found fault that is due to the guest accessing
@@ -2587,13 +2644,19 @@ _GLOBAL(kvmppc_h_cede)		/* r3 = vcpu pointer, r11 = msr, r13 = paca */
 	bl	kvmppc_save_fp
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+/*
+ * Branch around the call if both CPU_FTR_TM and
+ * CPU_FTR_P9_TM_HV_ASSIST are off.
+ */
 BEGIN_FTR_SECTION
+	b	91f
+END_FTR_SECTION(CPU_FTR_TM | CPU_FTR_P9_TM_HV_ASSIST, 0)
 	/*
 	 * NOTE THAT THIS TRASHES ALL NON-VOLATILE REGISTERS INCLUDING CR
 	 */
 	ld	r9, HSTATE_KVM_VCPU(r13)
 	bl	kvmppc_save_tm
-END_FTR_SECTION_IFSET(CPU_FTR_TM)
+91:
 #endif
 
 	/*
@@ -2700,12 +2763,18 @@ kvm_end_cede:
 #endif
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+/*
+ * Branch around the call if both CPU_FTR_TM and
+ * CPU_FTR_P9_TM_HV_ASSIST are off.
+ */
 BEGIN_FTR_SECTION
+	b	91f
+END_FTR_SECTION(CPU_FTR_TM | CPU_FTR_P9_TM_HV_ASSIST, 0)
 	/*
 	 * NOTE THAT THIS TRASHES ALL NON-VOLATILE REGISTERS INCLUDING CR
 	 */
 	bl	kvmppc_restore_tm
-END_FTR_SECTION_IFSET(CPU_FTR_TM)
+91:
 #endif
 
 	/* load up FP state */
@@ -3046,6 +3115,15 @@ kvmppc_save_tm:
 	std	r1, HSTATE_HOST_R1(r13)
 	li	r3, TM_CAUSE_KVM_RESCHED
 
+BEGIN_FTR_SECTION
+	/* Emulation of the treclaim instruction needs TEXASR before treclaim */
+	mfspr	r6, SPRN_TEXASR
+	std	r6, VCPU_ORIG_TEXASR(r9)
+
+	rldicl. r8, r8, 64 - MSR_TS_S_LG, 62
+	beq	3f
+END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_HV_ASSIST)
+
 	/* Clear the MSR RI since r1, r13 are all going to be foobar. */
 	li	r5, 0
 	mtmsrd	r5, 1
@@ -3057,6 +3135,38 @@ kvmppc_save_tm:
 	SET_SCRATCH0(r13)
 	GET_PACA(r13)
 	std	r9, PACATMSCRATCH(r13)
+
+	/* If doing TM emulation on POWER9 DD2.2, check for fake suspend mode */
+BEGIN_FTR_SECTION
+3:
+	lbz	r9, HSTATE_FAKE_SUSPEND(r13)
+	cmpwi	r9, 0
+	beq	2f
+	/*
+	 * We were in fake suspend, so we are not going to save the
+	 * register state as the guest checkpointed state (since
+	 * we already have it), therefore we can now use any volatile GPR.
+	 */
+	/* Reload stack pointer and TOC. */
+	ld	r1, HSTATE_HOST_R1(r13)
+	ld	r2, PACATOC(r13)
+	li	r5, MSR_RI
+	mtmsrd	r5, 1
+	HMT_MEDIUM
+	ld	r6, HSTATE_DSCR(r13)
+	mtspr	SPRN_DSCR, r6
+	li	r0, 0
+	stb	r0, HSTATE_FAKE_SUSPEND(r13)
+	mfspr	r3, SPRN_PSSCR
+	/* PSSCR_FAKE_SUSPEND is a write-only bit, but clear it anyway */
+	li	r0, PSSCR_FAKE_SUSPEND
+	andc	r3, r3, r0
+	mtspr	SPRN_PSSCR, r3
+	ld	r9, HSTATE_KVM_VCPU(r13)
+	b	1f
+2:
+END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_HV_ASSIST)
+
 	ld	r9, HSTATE_KVM_VCPU(r13)
 
 	/* Get a few more GPRs free. */
@@ -3182,6 +3292,15 @@ kvmppc_restore_tm:
 	mtspr	SPRN_TEXASR, r7
 
 	/*
+	 * If we are doing TM emulation for the guest on a POWER9 DD2,
+	 * then we don't actually do a trechkpt -- we either set up
+	 * fake-suspend mode, or emulate a TM rollback.
+	 */
+BEGIN_FTR_SECTION
+	b	.Ldo_tm_fake_load
+END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_HV_ASSIST)
+
+	/*
 	 * We need to load up the checkpointed state for the guest.
 	 * We need to do this early as it will blow away any GPRs, VSRs and
 	 * some SPRs.
@@ -3253,10 +3372,24 @@ kvmppc_restore_tm:
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
+	b	9b		/* and return */
+10:	stdu	r1, -PPC_MIN_STKFRM(r1)
+	/* guest is in transactional state, so simulate rollback */
+	mr	r3, r4
+	bl	kvmhv_emulate_tm_rollback
+	nop
+	ld      r4, HSTATE_KVM_VCPU(r13) /* our vcpu pointer has been trashed */
+	addi	r1, r1, PPC_MIN_STKFRM
+	b	9b
 #endif
 
 /*
diff --git a/arch/powerpc/kvm/book3s_hv_tm.c b/arch/powerpc/kvm/book3s_hv_tm.c
new file mode 100644
index 0000000..bf710ad
--- /dev/null
+++ b/arch/powerpc/kvm/book3s_hv_tm.c
@@ -0,0 +1,216 @@
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
index 0000000..d98ccfd
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
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 52c2053..4e38764 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -646,10 +646,13 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = hv_enabled;
 		break;
 #endif
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	case KVM_CAP_PPC_HTM:
 		r = hv_enabled &&
-		    (cur_cpu_spec->cpu_user_features2 & PPC_FEATURE2_HTM_COMP);
+		    (!!(cur_cpu_spec->cpu_user_features2 & PPC_FEATURE2_HTM) ||
+		     cpu_has_feature(CPU_FTR_P9_TM_HV_ASSIST));
 		break;
+#endif
 	default:
 		r = 0;
 		break;
-- 
2.7.4
