Return-Path: <npiggin@gmail.com>
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41NrMP015tzDqBW
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2018 00:24:48 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id p23-v6so612327pgv.13
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Jul 2018 07:24:48 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: [RFC PATCH] powerpc/64s: Move ISAv3.0 / POWER9 idle code to powernv C
 code
Date: Mon,  9 Jul 2018 00:24:36 +1000
Message-Id: <20180708142436.15714-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Reimplement POWER9 idle code in C, in the powernv platform code.
Assembly stubs are used to save and restore the stack frame and
non-volatile GPRs before going to idle, but these are small and
mostly agnostic to microarchitecture implementation details.

POWER7/8 code is not converted (yet), but that's not a moving
target, and it doesn't make you want to claw your eyes out so
much with the POWER9 code untangled from it.

The optimisation where EC=ESL=0 idle modes did not have to save
GPRs or mtmsrd L=0 is restored, because it's simple to do.

Idle wakeup no longer uses the ->cpu_restore call to reinit SPRs,
but saves and restores them all explicitly.

Moving the HMI, SPR, OPAL, locking, etc. to C is the only real
way this stuff will cope with non-trivial new CPU implementation
details, firmware changes, etc., without becoming unmaintainable.
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |   1 +
 arch/powerpc/include/asm/cpuidle.h            |  14 +-
 arch/powerpc/include/asm/paca.h               |  38 +-
 arch/powerpc/include/asm/processor.h          |   3 +-
 arch/powerpc/include/asm/reg.h                |   7 +-
 arch/powerpc/kernel/Makefile                  |   2 +-
 arch/powerpc/kernel/asm-offsets.c             |  11 +-
 arch/powerpc/kernel/exceptions-64s.S          |  10 +-
 arch/powerpc/kernel/idle_book3s.S             | 348 ++-------------
 arch/powerpc/kernel/idle_isa3.S               |  73 ++++
 arch/powerpc/kernel/setup-common.c            |   4 +-
 arch/powerpc/mm/slb.c                         |   7 +-
 arch/powerpc/platforms/powernv/idle.c         | 402 +++++++++++++++---
 arch/powerpc/xmon/xmon.c                      |  25 +-
 14 files changed, 496 insertions(+), 449 deletions(-)
 create mode 100644 arch/powerpc/kernel/idle_isa3.S

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 50ed64fba4ae..c626319a962d 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -486,6 +486,7 @@ static inline void hpte_init_pseries(void) { }
 extern void hpte_init_native(void);
 
 extern void slb_initialize(void);
+extern void __slb_flush_and_rebolt(void);
 extern void slb_flush_and_rebolt(void);
 
 extern void slb_vmalloc_update(void);
diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
index e210a83eb196..b668f030d531 100644
--- a/arch/powerpc/include/asm/cpuidle.h
+++ b/arch/powerpc/include/asm/cpuidle.h
@@ -28,6 +28,7 @@
  * yet woken from the winkle state.
  */
 #define PNV_CORE_IDLE_LOCK_BIT			0x10000000
+#define NR_PNV_CORE_IDLE_LOCK_BIT		28
 
 #define PNV_CORE_IDLE_WINKLE_COUNT		0x00010000
 #define PNV_CORE_IDLE_WINKLE_COUNT_ALL_BIT	0x00080000
@@ -68,22 +69,9 @@
 #define ERR_DEEP_STATE_ESL_MISMATCH	-2
 
 #ifndef __ASSEMBLY__
-/* Additional SPRs that need to be saved/restored during stop */
-struct stop_sprs {
-	u64 pid;
-	u64 ldbar;
-	u64 fscr;
-	u64 hfscr;
-	u64 mmcr1;
-	u64 mmcr2;
-	u64 mmcra;
-};
-
 extern u32 pnv_fastsleep_workaround_at_entry[];
 extern u32 pnv_fastsleep_workaround_at_exit[];
 
-extern u64 pnv_first_deep_stop_state;
-
 unsigned long pnv_cpu_offline(unsigned int cpu);
 int validate_psscr_val_mask(u64 *psscr_val, u64 *psscr_mask, u32 flags);
 static inline void report_invalid_psscr_val(u64 psscr_val, int err)
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 4e9cede5a7e7..a7a4892d39c0 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -178,23 +178,29 @@ struct paca_struct {
 #endif
 
 #ifdef CONFIG_PPC_POWERNV
-	/* Per-core mask tracking idle threads and a lock bit-[L][TTTTTTTT] */
-	u32 *core_idle_state_ptr;
-	u8 thread_idle_state;		/* PNV_THREAD_RUNNING/NAP/SLEEP	*/
-	/* Mask to indicate thread id in core */
-	u8 thread_mask;
-	/* Mask to denote subcore sibling threads */
-	u8 subcore_sibling_mask;
-	/* Flag to request this thread not to stop */
-	atomic_t dont_stop;
-	/* The PSSCR value that the kernel requested before going to stop */
-	u64 requested_psscr;
+	union {
+		/* P7/P8 specific fields */
+		struct {
+			/* Per-core mask tracking idle threads and a lock bit-[L][TTTTTTTT] */
+			unsigned long *core_idle_state_ptr;
+			u8 thread_idle_state;	/* PNV_THREAD_RUNNING/NAP/SLEEP	*/
+			/* Mask to indicate thread id in core */
+			u8 thread_mask;
+			/* Mask to denote subcore sibling threads */
+			u8 subcore_sibling_mask;
+		};
 
-	/*
-	 * Save area for additional SPRs that need to be
-	 * saved/restored during cpuidle stop.
-	 */
-	struct stop_sprs stop_sprs;
+		/* P9 specific fields */
+		struct {
+			/* The PSSCR value that the kernel requested before going to stop */
+			u64 requested_psscr;
+			unsigned long idle_state;
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+			/* Flag to request this thread not to stop */
+			atomic_t dont_stop;
+#endif
+		};
+	};
 #endif
 
 #ifdef CONFIG_PPC_BOOK3S_64
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 5debe337ea9d..4774ec7603ee 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -513,7 +513,8 @@ enum idle_boot_override {IDLE_NO_OVERRIDE = 0, IDLE_POWERSAVE_OFF};
 extern int powersave_nap;	/* set if nap mode can be used in idle loop */
 extern unsigned long power7_idle_insn(unsigned long type); /* PNV_THREAD_NAP/etc*/
 extern void power7_idle_type(unsigned long type);
-extern unsigned long power9_idle_stop(unsigned long psscr_val);
+extern unsigned long isa3_idle_stop_noloss(unsigned long psscr_val);
+extern unsigned long isa3_idle_stop_mayloss(unsigned long psscr_val);
 extern unsigned long power9_offline_stop(unsigned long psscr_val);
 extern void power9_idle_type(unsigned long stop_psscr_val,
 			      unsigned long stop_psscr_mask);
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 562568414cf4..3c7d97b2abb0 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -750,10 +750,9 @@
 #define	  SRR1_WAKERESET	0x00100000 /* System reset */
 #define   SRR1_WAKEHDBELL	0x000c0000 /* Hypervisor doorbell on P8 */
 #define	  SRR1_WAKESTATE	0x00030000 /* Powersave exit mask [46:47] */
-#define	  SRR1_WS_DEEPEST	0x00030000 /* Some resources not maintained,
-					  * may not be recoverable */
-#define	  SRR1_WS_DEEPER	0x00020000 /* Some resources not maintained */
-#define	  SRR1_WS_DEEP		0x00010000 /* All resources maintained */
+#define	  SRR1_WS_HVLOSS	0x00030000 /* HV resources not maintained */
+#define	  SRR1_WS_GPRLOSS	0x00020000 /* GPRs not maintained */
+#define	  SRR1_WS_NOLOSS	0x00010000 /* All resources maintained */
 #define   SRR1_PROGTM		0x00200000 /* TM Bad Thing */
 #define   SRR1_PROGFPE		0x00100000 /* Floating Point Enabled */
 #define   SRR1_PROGILL		0x00080000 /* Illegal instruction */
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 2b4c40b255e4..6914fab16e2c 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -48,7 +48,7 @@ obj-$(CONFIG_PPC_BOOK3E_64)	+= exceptions-64e.o idle_book3e.o
 obj-$(CONFIG_PPC64)		+= vdso64/
 obj-$(CONFIG_ALTIVEC)		+= vecemu.o
 obj-$(CONFIG_PPC_970_NAP)	+= idle_power4.o
-obj-$(CONFIG_PPC_P7_NAP)	+= idle_book3s.o
+obj-$(CONFIG_PPC_P7_NAP)	+= idle_book3s.o idle_isa3.o
 procfs-y			:= proc_powerpc.o
 obj-$(CONFIG_PROC_FS)		+= $(procfs-y)
 rtaspci-$(CONFIG_PPC64)-$(CONFIG_PCI)	:= rtas_pci.o
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 89cf15566c4e..b8162bb80ddb 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -762,20 +762,11 @@ int main(void)
 #endif
 
 #ifdef CONFIG_PPC_POWERNV
+	/* POWER7/8 specific idle fields (kernel/idle_book3s.S) */
 	OFFSET(PACA_CORE_IDLE_STATE_PTR, paca_struct, core_idle_state_ptr);
 	OFFSET(PACA_THREAD_IDLE_STATE, paca_struct, thread_idle_state);
 	OFFSET(PACA_THREAD_MASK, paca_struct, thread_mask);
 	OFFSET(PACA_SUBCORE_SIBLING_MASK, paca_struct, subcore_sibling_mask);
-	OFFSET(PACA_REQ_PSSCR, paca_struct, requested_psscr);
-	OFFSET(PACA_DONT_STOP, paca_struct, dont_stop);
-#define STOP_SPR(x, f)	OFFSET(x, paca_struct, stop_sprs.f)
-	STOP_SPR(STOP_PID, pid);
-	STOP_SPR(STOP_LDBAR, ldbar);
-	STOP_SPR(STOP_FSCR, fscr);
-	STOP_SPR(STOP_HFSCR, hfscr);
-	STOP_SPR(STOP_MMCR1, mmcr1);
-	STOP_SPR(STOP_MMCR2, mmcr2);
-	STOP_SPR(STOP_MMCRA, mmcra);
 #endif
 
 	DEFINE(PPC_DBELL_SERVER, PPC_DBELL_SERVER);
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 76a14702cb9c..36b5f0e18c0c 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -135,8 +135,14 @@ TRAMP_KVM(PACA_EXNMI, 0x100)
 
 #ifdef CONFIG_PPC_P7_NAP
 EXC_COMMON_BEGIN(system_reset_idle_common)
+BEGIN_FTR_SECTION
+	mfspr	r3,SPRN_SRR1
+	bltlr	cr3	/* no state loss, return to idle caller */
+	b	isa3_idle_wake_gpr_loss
+FTR_SECTION_ELSE
 	mfspr	r12,SPRN_SRR1
 	b	pnv_powersave_wakeup
+ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
 #endif
 
 /*
@@ -425,7 +431,9 @@ EXC_COMMON_BEGIN(machine_check_idle_common)
 	li	r11,0
 	mtmsrd	r11,1
 
-	b	pnv_powersave_wakeup_mce
+	/* XXX fixup
+	b	pnv_powersave_wakeup_mce */
+	b	.
 #endif
 	/*
 	 * Handle machine check early in real mode. We come here with
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index d85d5515a091..506b88768767 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -1,6 +1,6 @@
 /*
- *  This file contains idle entry/exit functions for POWER7,
- *  POWER8 and POWER9 CPUs.
+ *  This file contains idle entry/exit functions for POWER7 and
+ *  POWER8 CPUs.
  *
  *  This program is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU General Public License
@@ -56,19 +56,8 @@ save_sprs_to_stack:
 	 * Note all register i.e per-core, per-subcore or per-thread is saved
 	 * here since any thread in the core might wake up first
 	 */
-BEGIN_FTR_SECTION
-	/*
-	 * Note - SDR1 is dropped in Power ISA v3. Hence not restoring
-	 * SDR1 here
-	 */
-	mfspr	r3,SPRN_PTCR
-	std	r3,_PTCR(r1)
-	mfspr	r3,SPRN_LPCR
-	std	r3,_LPCR(r1)
-FTR_SECTION_ELSE
 	mfspr	r3,SPRN_SDR1
 	std	r3,_SDR1(r1)
-ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
 	mfspr	r3,SPRN_RPR
 	std	r3,_RPR(r1)
 	mfspr	r3,SPRN_SPURR
@@ -85,66 +74,6 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
 	std	r3,_WORT(r1)
 	mfspr	r3,SPRN_WORC
 	std	r3,_WORC(r1)
-/*
- * On POWER9, there are idle states such as stop4, invoked via cpuidle,
- * that lose hypervisor resources. In such cases, we need to save
- * additional SPRs before entering those idle states so that they can
- * be restored to their older values on wakeup from the idle state.
- *
- * On POWER8, the only such deep idle state is winkle which is used
- * only in the context of CPU-Hotplug, where these additional SPRs are
- * reinitiazed to a sane value. Hence there is no need to save/restore
- * these SPRs.
- */
-BEGIN_FTR_SECTION
-	blr
-END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
-
-power9_save_additional_sprs:
-	mfspr	r3, SPRN_PID
-	mfspr	r4, SPRN_LDBAR
-	std	r3, STOP_PID(r13)
-	std	r4, STOP_LDBAR(r13)
-
-	mfspr	r3, SPRN_FSCR
-	mfspr	r4, SPRN_HFSCR
-	std	r3, STOP_FSCR(r13)
-	std	r4, STOP_HFSCR(r13)
-
-	mfspr	r3, SPRN_MMCRA
-	mfspr	r4, SPRN_MMCR0
-	std	r3, STOP_MMCRA(r13)
-	std	r4, _MMCR0(r1)
-
-	mfspr	r3, SPRN_MMCR1
-	mfspr	r4, SPRN_MMCR2
-	std	r3, STOP_MMCR1(r13)
-	std	r4, STOP_MMCR2(r13)
-	blr
-
-power9_restore_additional_sprs:
-	ld	r3,_LPCR(r1)
-	ld	r4, STOP_PID(r13)
-	mtspr	SPRN_LPCR,r3
-	mtspr	SPRN_PID, r4
-
-	ld	r3, STOP_LDBAR(r13)
-	ld	r4, STOP_FSCR(r13)
-	mtspr	SPRN_LDBAR, r3
-	mtspr	SPRN_FSCR, r4
-
-	ld	r3, STOP_HFSCR(r13)
-	ld	r4, STOP_MMCRA(r13)
-	mtspr	SPRN_HFSCR, r3
-	mtspr	SPRN_MMCRA, r4
-
-	ld	r3, _MMCR0(r1)
-	ld	r4, STOP_MMCR1(r13)
-	mtspr	SPRN_MMCR0, r3
-	mtspr	SPRN_MMCR1, r4
-
-	ld	r3, STOP_MMCR2(r13)
-	mtspr	SPRN_MMCR2, r3
 	blr
 
 /*
@@ -167,13 +96,23 @@ core_idle_lock_held:
 	blr
 
 /*
- * Pass requested state in r3:
- *	r3 - PNV_THREAD_NAP/SLEEP/WINKLE in POWER8
- *	   - Requested PSSCR value in POWER9
- *
- * Address of idle handler to branch to in realmode in r4
+ * This is the sequence required to execute idle instructions, as
+ * specified in ISA v2.07 (and earlier). MSR[IR] and MSR[DR] must be 0.
+ */
+#define IDLE_STATE_ENTER_SEQ_NORET(IDLE_INST)			\
+	/* Magic NAP/SLEEP/WINKLE mode enter sequence */	\
+	std	r0,0(r1);					\
+	ptesync;						\
+	ld	r0,0(r1);					\
+236:	cmpd	cr0,r0,r0;					\
+	bne	236b;						\
+	IDLE_INST;
+
+/*
+ * Entered with MSR[EE]=0 and no soft-masked interrupts pending.
+ * r3 contains desired idle state (PNV_THREAD_NAP/SLEEP/WINKLE).
  */
-pnv_powersave_common:
+_GLOBAL(power7_idle_insn)
 	/* Use r3 to pass state nap/sleep/winkle */
 	/* NAP is a state loss, we create a regs frame on the
 	 * stack, fill it up with the state we care about and
@@ -181,8 +120,6 @@ pnv_powersave_common:
 	 * need to save PC, some CR bits and the NV GPRs,
 	 * but for now an interrupt frame will do.
 	 */
-	mtctr	r4
-
 	mflr	r0
 	std	r0,16(r1)
 	stdu	r1,-INT_FRAME_SIZE(r1)
@@ -200,16 +137,7 @@ pnv_powersave_common:
 	std	r5,_CCR(r1)
 	std	r1,PACAR1(r13)
 
-BEGIN_FTR_SECTION
-	/*
-	 * POWER9 does not require real mode to stop, and presently does not
-	 * set hwthread_state for KVM (threads don't share MMU context), so
-	 * we can remain in virtual mode for this.
-	 */
-	bctr
-END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 	/*
-	 * POWER8
 	 * Go to real mode to do the nap, as required by the architecture.
 	 * Also, we need to be in real mode before setting hwthread_state,
 	 * because as soon as we do that, another thread can switch
@@ -217,24 +145,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 	 */
 	LOAD_REG_IMMEDIATE(r7, MSR_IDLE)
 	mtmsrd	r7,0
-	bctr
 
-/*
- * This is the sequence required to execute idle instructions, as
- * specified in ISA v2.07 (and earlier). MSR[IR] and MSR[DR] must be 0.
- */
-#define IDLE_STATE_ENTER_SEQ_NORET(IDLE_INST)			\
-	/* Magic NAP/SLEEP/WINKLE mode enter sequence */	\
-	std	r0,0(r1);					\
-	ptesync;						\
-	ld	r0,0(r1);					\
-236:	cmpd	cr0,r0,r0;					\
-	bne	236b;						\
-	IDLE_INST;
-
-
-	.globl pnv_enter_arch207_idle_mode
-pnv_enter_arch207_idle_mode:
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 	/* Tell KVM we're entering idle */
 	li	r4,KVM_HWTHREAD_IN_IDLE
@@ -321,86 +232,6 @@ enter_winkle:
 
 	IDLE_STATE_ENTER_SEQ_NORET(PPC_WINKLE)
 
-/*
- * r3 - PSSCR value corresponding to the requested stop state.
- */
-power_enter_stop:
-/*
- * Check if we are executing the lite variant with ESL=EC=0
- */
-	andis.   r4,r3,PSSCR_EC_ESL_MASK_SHIFTED
-	clrldi   r3,r3,60 /* r3 = Bits[60:63] = Requested Level (RL) */
-	bne	 .Lhandle_esl_ec_set
-	PPC_STOP
-	li	r3,0  /* Since we didn't lose state, return 0 */
-	std	r3, PACA_REQ_PSSCR(r13)
-
-	/*
-	 * pnv_wakeup_noloss() expects r12 to contain the SRR1 value so
-	 * it can determine if the wakeup reason is an HMI in
-	 * CHECK_HMI_INTERRUPT.
-	 *
-	 * However, when we wakeup with ESL=0, SRR1 will not contain the wakeup
-	 * reason, so there is no point setting r12 to SRR1.
-	 *
-	 * Further, we clear r12 here, so that we don't accidentally enter the
-	 * HMI in pnv_wakeup_noloss() if the value of r12[42:45] == WAKE_HMI.
-	 */
-	li	r12, 0
-	b 	pnv_wakeup_noloss
-
-.Lhandle_esl_ec_set:
-BEGIN_FTR_SECTION
-	/*
-	 * POWER9 DD2.0 or earlier can incorrectly set PMAO when waking up after
-	 * a state-loss idle. Saving and restoring MMCR0 over idle is a
-	 * workaround.
-	 */
-	mfspr	r4,SPRN_MMCR0
-	std	r4,_MMCR0(r1)
-END_FTR_SECTION_IFCLR(CPU_FTR_POWER9_DD2_1)
-
-/*
- * Check if the requested state is a deep idle state.
- */
-	LOAD_REG_ADDRBASE(r5,pnv_first_deep_stop_state)
-	ld	r4,ADDROFF(pnv_first_deep_stop_state)(r5)
-	cmpd	r3,r4
-	bge	.Lhandle_deep_stop
-	PPC_STOP	/* Does not return (system reset interrupt) */
-
-.Lhandle_deep_stop:
-/*
- * Entering deep idle state.
- * Clear thread bit in PACA_CORE_IDLE_STATE, save SPRs to
- * stack and enter stop
- */
-	lbz     r7,PACA_THREAD_MASK(r13)
-	ld      r14,PACA_CORE_IDLE_STATE_PTR(r13)
-
-lwarx_loop_stop:
-	lwarx   r15,0,r14
-	andis.	r9,r15,PNV_CORE_IDLE_LOCK_BIT@h
-	bnel-	core_idle_lock_held
-	andc    r15,r15,r7                      /* Clear thread bit */
-
-	stwcx.  r15,0,r14
-	bne-    lwarx_loop_stop
-	isync
-
-	bl	save_sprs_to_stack
-
-	PPC_STOP	/* Does not return (system reset interrupt) */
-
-/*
- * Entered with MSR[EE]=0 and no soft-masked interrupts pending.
- * r3 contains desired idle state (PNV_THREAD_NAP/SLEEP/WINKLE).
- */
-_GLOBAL(power7_idle_insn)
-	/* Now check if user or arch enabled NAP mode */
-	LOAD_REG_ADDR(r4, pnv_enter_arch207_idle_mode)
-	b	pnv_powersave_common
-
 #define CHECK_HMI_INTERRUPT						\
 BEGIN_FTR_SECTION_NESTED(66);						\
 	rlwinm	r0,r12,45-31,0xf;  /* extract wake reason field (P8) */	\
@@ -419,53 +250,6 @@ ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S, 66);		\
 	ld	r3,ORIG_GPR3(r1);	/* Restore original r3 */	\
 20:	nop;
 
-/*
- * Entered with MSR[EE]=0 and no soft-masked interrupts pending.
- * r3 contains desired PSSCR register value.
- *
- * Offline (CPU unplug) case also must notify KVM that the CPU is
- * idle.
- */
-_GLOBAL(power9_offline_stop)
-#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
-	/*
-	 * Tell KVM we're entering idle.
-	 * This does not have to be done in real mode because the P9 MMU
-	 * is independent per-thread. Some steppings share radix/hash mode
-	 * between threads, but in that case KVM has a barrier sync in real
-	 * mode before and after switching between radix and hash.
-	 */
-	li	r4,KVM_HWTHREAD_IN_IDLE
-	stb	r4,HSTATE_HWTHREAD_STATE(r13)
-#endif
-	/* fall through */
-
-_GLOBAL(power9_idle_stop)
-	std	r3, PACA_REQ_PSSCR(r13)
-#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
-BEGIN_FTR_SECTION
-	sync
-	lwz	r5, PACA_DONT_STOP(r13)
-	cmpwi	r5, 0
-	bne	1f
-END_FTR_SECTION_IFSET(CPU_FTR_P9_TM_XER_SO_BUG)
-#endif
-	mtspr 	SPRN_PSSCR,r3
-	LOAD_REG_ADDR(r4,power_enter_stop)
-	b	pnv_powersave_common
-	/* No return */
-#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
-1:
-	/*
-	 * We get here when TM / thread reconfiguration bug workaround
-	 * code wants to get the CPU into SMT4 mode, and therefore
-	 * we are being asked not to stop.
-	 */
-	li	r3, 0
-	std	r3, PACA_REQ_PSSCR(r13)
-	blr		/* return 0 for wakeup cause / SRR1 value */
-#endif
-
 /*
  * Called from machine check handler for powersave wakeups.
  * Low level machine check processing has already been done. Now just
@@ -499,11 +283,7 @@ pnv_powersave_wakeup_mce:
 pnv_powersave_wakeup:
 	ld	r2, PACATOC(r13)
 
-BEGIN_FTR_SECTION
-	bl	pnv_restore_hyp_resource_arch300
-FTR_SECTION_ELSE
-	bl	pnv_restore_hyp_resource_arch207
-ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
+	bl	pnv_restore_hyp_resource
 
 	li	r0,PNV_THREAD_RUNNING
 	stb	r0,PACA_THREAD_IDLE_STATE(r13)	/* Clear thread state */
@@ -535,50 +315,8 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
  *
  * cr3 - set to gt if waking up with partial/complete hypervisor state loss
  */
-pnv_restore_hyp_resource_arch300:
-	/*
-	 * Workaround for POWER9, if we lost resources, the ERAT
-	 * might have been mixed up and needs flushing. We also need
-	 * to reload MMCR0 (see comment above). We also need to set
-	 * then clear bit 60 in MMCRA to ensure the PMU starts running.
-	 */
-	blt	cr3,1f
-BEGIN_FTR_SECTION
-	PPC_INVALIDATE_ERAT
-	ld	r1,PACAR1(r13)
-	ld	r4,_MMCR0(r1)
-	mtspr	SPRN_MMCR0,r4
-END_FTR_SECTION_IFCLR(CPU_FTR_POWER9_DD2_1)
-	mfspr	r4,SPRN_MMCRA
-	ori	r4,r4,(1 << (63-60))
-	mtspr	SPRN_MMCRA,r4
-	xori	r4,r4,(1 << (63-60))
-	mtspr	SPRN_MMCRA,r4
-1:
-	/*
-	 * POWER ISA 3. Use PSSCR to determine if we
-	 * are waking up from deep idle state
-	 */
-	LOAD_REG_ADDRBASE(r5,pnv_first_deep_stop_state)
-	ld	r4,ADDROFF(pnv_first_deep_stop_state)(r5)
-
+pnv_restore_hyp_resource:
 	/*
-	 * 0-3 bits correspond to Power-Saving Level Status
-	 * which indicates the idle state we are waking up from
-	 */
-	mfspr	r5, SPRN_PSSCR
-	rldicl  r5,r5,4,60
-	li	r0, 0		/* clear requested_psscr to say we're awake */
-	std	r0, PACA_REQ_PSSCR(r13)
-	cmpd	cr4,r5,r4
-	bge	cr4,pnv_wakeup_tb_loss /* returns to caller */
-
-	blr	/* Waking up without hypervisor state loss. */
-
-/* Same calling convention as arch300 */
-pnv_restore_hyp_resource_arch207:
-	/*
-	 * POWER ISA 2.07 or less.
 	 * Check if we slept with sleep or winkle.
 	 */
 	lbz	r4,PACA_THREAD_IDLE_STATE(r13)
@@ -598,15 +336,9 @@ pnv_restore_hyp_resource_arch207:
  * Called if waking up from idle state which can cause either partial or
  * complete hyp state loss.
  * In POWER8, called if waking up from fastsleep or winkle
- * In POWER9, called if waking up from stop state >= pnv_first_deep_stop_state
  *
  * r13 - PACA
  * cr3 - gt if waking up with partial/complete hypervisor state loss
- *
- * If ISA300:
- * cr4 - gt or eq if waking up from complete hypervisor state loss.
- *
- * If ISA207:
  * r4 - PACA_THREAD_IDLE_STATE
  */
 pnv_wakeup_tb_loss:
@@ -621,9 +353,7 @@ pnv_wakeup_tb_loss:
 	 * and SRR1 test for restoring NVGPRs.
 	 *
 	 * We are about to clobber NVGPRs now, so set NAPSTATELOST to
-	 * guarantee they will always be restored. This might be tightened
-	 * with careful reading of specs (particularly for ISA300) but this
-	 * is already a slow wakeup path and it's simpler to be safe.
+	 * guarantee they will always be restored.
 	 */
 	li	r0,1
 	stb	r0,PACA_NAPSTATELOST(r13)
@@ -672,19 +402,16 @@ END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
 	 * At this stage
 	 * cr2 - eq if first thread to wakeup in core
 	 * cr3-  gt if waking up with partial/complete hypervisor state loss
-	 * ISA300:
-	 * cr4 - gt or eq if waking up from complete hypervisor state loss.
 	 */
 
-BEGIN_FTR_SECTION
 	/*
 	 * Were we in winkle?
 	 * If yes, check if all threads were in winkle, decrement our
 	 * winkle count, set all thread winkle bits if all were in winkle.
-	 * Check if our thread has a winkle bit set, and set cr4 accordingly
-	 * (to match ISA300, above). Pseudo-code for core idle state
-	 * transitions for ISA207 is as follows (everything happens atomically
-	 * due to store conditional and/or lock bit):
+	 * Check if our thread has a winkle bit set, and set cr4 accordingly.
+	 * Pseudo-code for core idle state transitions for ISA207 is as follows
+	 * (everything happens atomically due to store conditional and/or lock
+	 * bit):
 	 *
 	 * nap_idle() { }
 	 * nap_wake() { }
@@ -749,7 +476,6 @@ BEGIN_FTR_SECTION
 
 	or	r15,r15,r7		/* Set thread bit */
 	beq	first_thread_in_subcore
-END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
 
 	or	r15,r15,r7		/* Set thread bit */
 	beq	cr2,first_thread_in_core
@@ -815,15 +541,6 @@ timebase_resync:
 	 * complete hypervisor state loss. Restore per core hypervisor
 	 * state.
 	 */
-BEGIN_FTR_SECTION
-	ld	r4,_PTCR(r1)
-	mtspr	SPRN_PTCR,r4
-	ld	r4,_RPR(r1)
-	mtspr	SPRN_RPR,r4
-	ld	r4,_AMOR(r1)
-	mtspr	SPRN_AMOR,r4
-END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
-
 	ld	r4,_TSCR(r1)
 	mtspr	SPRN_TSCR,r4
 	ld	r4,_WORC(r1)
@@ -845,9 +562,6 @@ common_exit:
 
 	/* Waking up from winkle */
 
-BEGIN_MMU_FTR_SECTION
-	b	no_segments
-END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_RADIX)
 	/* Restore SLB  from PACA */
 	ld	r8,PACA_SLBSHADOWPTR(r13)
 
@@ -861,7 +575,6 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_RADIX)
 	slbmte	r6,r5
 1:	addi	r8,r8,16
 	.endr
-no_segments:
 
 	/* Restore per thread state */
 
@@ -884,17 +597,6 @@ no_segments:
 	mtctr	r12
 	bctrl
 
-/*
- * On POWER9, we can come here on wakeup from a cpuidle stop state.
- * Hence restore the additional SPRs to the saved value.
- *
- * On POWER8, we come here only on winkle. Since winkle is used
- * only in the case of CPU-Hotplug, we don't need to restore
- * the additional SPRs.
- */
-BEGIN_FTR_SECTION
-	bl 	power9_restore_additional_sprs
-END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 hypervisor_state_restored:
 
 	mr	r12,r19
diff --git a/arch/powerpc/kernel/idle_isa3.S b/arch/powerpc/kernel/idle_isa3.S
new file mode 100644
index 000000000000..c869512b716a
--- /dev/null
+++ b/arch/powerpc/kernel/idle_isa3.S
@@ -0,0 +1,73 @@
+/*
+ *  This file contains general idle entry/exit functions. The platform / CPU
+ *  must call the correct save/restore functions and ensure SPRs are saved
+ *  and restored correctly, handle KVM, interrupts, etc.
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#include <asm/ppc_asm.h>
+#include <asm/asm-offsets.h>
+#include <asm/ppc-opcode.h>
+
+/*
+ * Desired PSSCR in r3
+ *
+ * No state will be lost regardless of wakeup mechanism (interrupt or NIA).
+ * Interrupt driven wakeup may clobber volatiles, and should blr (with LR
+ * unchanged) to return to caller with r3 set according to caller's expected
+ * return code (for Book3S/64 that is SRR1).
+ *
+ * Caller is responsible for restoring SPRs, MSR, etc.
+ */
+_GLOBAL(isa3_idle_stop_noloss)
+	mtspr 	SPRN_PSSCR,r3
+	PPC_STOP
+	li	r3,0
+	blr
+
+/*
+ * Desired PSSCR in r3
+ *
+ * GPRs may be lost, so they are saved here. Wakeup is by interrupt only.
+ * Wakeup can return to caller by calling pnv_powersave_wakeup_gpr_loss
+ * with r3 set to return value.
+ *
+ * A wakeup without GPR loss may alterateively be handled as in
+ * isa3_idle_stop_noloss as an optimisation.
+ *
+ * Caller is responsible for restoring SPRs, MSR, etc.
+ */
+_GLOBAL(isa3_idle_stop_mayloss)
+	std	r1,PACAR1(r13)
+	mflr	r4
+	mfcr	r5
+	/* use stack red zone rather than a new frame */
+	addi	r6,r1,-INT_FRAME_SIZE
+	SAVE_GPR(2, r6)
+	SAVE_NVGPRS(r6)
+	std	r4,_LINK(r6)
+	std	r5,_CCR(r6)
+	mtspr 	SPRN_PSSCR,r3
+	PPC_STOP
+	b	.
+
+/*
+ * Desired return value in r3
+ *
+ * Idle wakeup can call this after calling isa3_idle_stop_loss to
+ * return to caller with r3 as return code.
+ */
+_GLOBAL(isa3_idle_wake_gpr_loss)
+	ld	r1,PACAR1(r13)
+	addi	r6,r1,-INT_FRAME_SIZE
+	ld	r4,_LINK(r6)
+	ld	r5,_CCR(r6)
+	REST_NVGPRS(r6)
+	REST_GPR(2, r6)
+	mtlr	r4
+	mtcr	r5
+	blr
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 40b44bb53a4e..e089da156ef3 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -401,8 +401,8 @@ void __init check_for_initrd(void)
 
 #ifdef CONFIG_SMP
 
-int threads_per_core, threads_per_subcore, threads_shift;
-cpumask_t threads_core_mask;
+int threads_per_core, threads_per_subcore, threads_shift __read_mostly;
+cpumask_t threads_core_mask __read_mostly;
 EXPORT_SYMBOL_GPL(threads_per_core);
 EXPORT_SYMBOL_GPL(threads_per_subcore);
 EXPORT_SYMBOL_GPL(threads_shift);
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index cb796724a6fc..2d5db5e0132e 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -90,7 +90,7 @@ static inline void create_shadowed_slbe(unsigned long ea, int ssize,
 		     : "memory" );
 }
 
-static void __slb_flush_and_rebolt(void)
+void __slb_flush_and_rebolt(void)
 {
 	/* If you change this make sure you change SLB_NUM_BOLTED
 	 * and PR KVM appropriately too. */
@@ -128,6 +128,8 @@ static void __slb_flush_and_rebolt(void)
 		        "r"(ksp_vsid_data),
 		        "r"(ksp_esid_data)
 		     : "memory");
+
+	get_paca()->slb_cache_ptr = 0;
 }
 
 void slb_flush_and_rebolt(void)
@@ -142,7 +144,6 @@ void slb_flush_and_rebolt(void)
 	hard_irq_disable();
 
 	__slb_flush_and_rebolt();
-	get_paca()->slb_cache_ptr = 0;
 }
 
 void slb_vmalloc_update(void)
@@ -213,6 +214,7 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 			asm volatile("slbie %0" : : "r" (slbie_data));
 		}
 		asm volatile("isync" : : : "memory");
+		get_paca()->slb_cache_ptr = 0;
 	} else {
 		__slb_flush_and_rebolt();
 	}
@@ -221,7 +223,6 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 	if (offset == 1 || offset > SLB_CACHE_ENTRIES)
 		asm volatile("slbie %0" : : "r" (slbie_data));
 
-	get_paca()->slb_cache_ptr = 0;
 	copy_mm_to_paca(mm);
 
 	/*
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 12f13acee1f6..2e129b882727 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -16,6 +16,7 @@
 #include <linux/device.h>
 #include <linux/cpu.h>
 
+#include <asm/asm-prototypes.h>
 #include <asm/firmware.h>
 #include <asm/machdep.h>
 #include <asm/opal.h>
@@ -46,10 +47,10 @@ static u64 pnv_default_stop_mask;
 static bool default_stop_found;
 
 /*
- * First deep stop state. Used to figure out when to save/restore
- * hypervisor context.
+ * First stop state levels when HV and TB loss can occur.
  */
-u64 pnv_first_deep_stop_state = MAX_STOP_STATE;
+static u64 pnv_first_tb_loss_level = MAX_STOP_STATE + 1;
+static u64 pnv_first_hv_loss_level = MAX_STOP_STATE + 1;
 
 /*
  * psscr value and mask of the deepest stop idle state.
@@ -135,11 +136,11 @@ static int pnv_save_sprs_for_deep_states(void)
 	return 0;
 }
 
-static void pnv_alloc_idle_core_states(void)
+static void pnv_alloc_idle_core_states_p8(void)
 {
 	int i, j;
 	int nr_cores = cpu_nr_cores();
-	u32 *core_idle_state;
+	unsigned long *core_idle_state;
 
 	/*
 	 * core_idle_state - The lower 8 bits track the idle state of
@@ -166,7 +167,7 @@ static void pnv_alloc_idle_core_states(void)
 		int node = cpu_to_node(first_cpu);
 		size_t paca_ptr_array_size;
 
-		core_idle_state = kmalloc_node(sizeof(u32), GFP_KERNEL, node);
+		core_idle_state = kmalloc_node(sizeof(unsigned long), GFP_KERNEL, node);
 		*core_idle_state = (1 << threads_per_core) - 1;
 		paca_ptr_array_size = (threads_per_core *
 				       sizeof(struct paca_struct *));
@@ -181,41 +182,6 @@ static void pnv_alloc_idle_core_states(void)
 	}
 
 	update_subcore_sibling_mask();
-
-	if (supported_cpuidle_states & OPAL_PM_LOSE_FULL_CONTEXT) {
-		int rc = pnv_save_sprs_for_deep_states();
-
-		if (likely(!rc))
-			return;
-
-		/*
-		 * The stop-api is unable to restore hypervisor
-		 * resources on wakeup from platform idle states which
-		 * lose full context. So disable such states.
-		 */
-		supported_cpuidle_states &= ~OPAL_PM_LOSE_FULL_CONTEXT;
-		pr_warn("cpuidle-powernv: Disabling idle states that lose full context\n");
-		pr_warn("cpuidle-powernv: Idle power-savings, CPU-Hotplug affected\n");
-
-		if (cpu_has_feature(CPU_FTR_ARCH_300) &&
-		    (pnv_deepest_stop_flag & OPAL_PM_LOSE_FULL_CONTEXT)) {
-			/*
-			 * Use the default stop state for CPU-Hotplug
-			 * if available.
-			 */
-			if (default_stop_found) {
-				pnv_deepest_stop_psscr_val =
-					pnv_default_stop_val;
-				pnv_deepest_stop_psscr_mask =
-					pnv_default_stop_mask;
-				pr_warn("cpuidle-powernv: Offlined CPUs will stop with psscr = 0x%016llx\n",
-					pnv_deepest_stop_psscr_val);
-			} else { /* Fallback to snooze loop for CPU-Hotplug */
-				deepest_stop_found = false;
-				pr_warn("cpuidle-powernv: Offlined CPUs will busy wait\n");
-			}
-		}
-	}
 }
 
 u32 pnv_get_supported_cpuidle_states(void)
@@ -345,6 +311,263 @@ void power7_idle(void)
 	power7_idle_type(PNV_THREAD_NAP);
 }
 
+struct p9_sprs {
+	/* per core */
+	u64 ptcr;
+	u64 rpr;
+	u64 tscr;
+	u64 ldbar;
+
+	/* per thread */
+	u64 lpcr;
+	u64 hfscr;
+	u64 fscr;
+	u64 pid;
+	u64 purr;
+	u64 spurr;
+	u64 dscr;
+
+	u64 mmcra;
+	u32 mmcr0;
+	u32 mmcr1;
+	u64 mmcr2;
+};
+
+static inline void atomic_start_thread_idle(void)
+{
+	int cpu = raw_smp_processor_id();
+	int first = cpu_first_thread_sibling(cpu);
+	int thread = cpu_thread_in_core(cpu);
+	unsigned long *state = &paca_ptrs[first]->idle_state;
+	u64 s = READ_ONCE(*state);
+	u64 new, tmp;
+
+again:
+	if (unlikely(s & PNV_CORE_IDLE_LOCK_BIT)) {
+		spin_begin();
+		do {
+			spin_cpu_relax();
+			s = READ_ONCE(*state);
+		} while (s & PNV_CORE_IDLE_LOCK_BIT);
+		spin_end();
+	}
+
+	BUG_ON(!(s & thread));
+
+	new = s & ~thread;
+	tmp = cmpxchg(state, s, new);
+	if (unlikely(tmp != s)) {
+		s = tmp;
+		goto again;
+	}
+}
+
+static inline void atomic_lock_thread_idle(void)
+{
+	int cpu = raw_smp_processor_id();
+	int first = cpu_first_thread_sibling(cpu);
+	unsigned long *state = &paca_ptrs[first]->idle_state;
+
+	while (unlikely(test_and_set_bit_lock(NR_PNV_CORE_IDLE_LOCK_BIT, state)))
+		barrier();
+}
+
+static inline void atomic_unlock_thread_idle(void)
+{
+	int cpu = raw_smp_processor_id();
+	int first = cpu_first_thread_sibling(cpu);
+	unsigned long *state = &paca_ptrs[first]->idle_state;
+
+	clear_bit_unlock(NR_PNV_CORE_IDLE_LOCK_BIT, state);
+}
+
+static unsigned long power9_idle_stop(unsigned long psscr, bool mmu_on)
+{
+	int cpu = raw_smp_processor_id();
+	int first = cpu_first_thread_sibling(cpu);
+	int thread = cpu_thread_in_core(cpu);
+	unsigned long *state = &paca_ptrs[first]->idle_state;
+	unsigned long srr1;
+	unsigned long mmcr0 = 0;
+	struct p9_sprs sprs;
+
+	/* XXX: this gets rid of the uninitialized warning. Should use attributes because this is expensive */
+	memset(&sprs, 0, sizeof(sprs));
+
+	if (!(psscr & (PSSCR_EC|PSSCR_ESL))) {
+		/*
+		 * Wake synchronously. SRESET via xscom may still cause
+		 * a 0x100 powersave wakeup with SRR1 reason!
+		 */
+		srr1 = isa3_idle_stop_noloss(psscr);
+		if (likely(!srr1))
+			return 0;
+
+	} else {
+		if (!cpu_has_feature(CPU_FTR_POWER9_DD2_1)) {
+			 /*
+			  * POWER9 DD2 can incorrectly set PMAO when waking up
+			  * after a state-loss idle. Saving and restoring MMCR0
+			  * over idle is a workaround.
+			  */
+			mmcr0 = mfspr(SPRN_MMCR0);
+		}
+		if ((psscr & PSSCR_RL_MASK) >= pnv_first_hv_loss_level) {
+			atomic_start_thread_idle();
+
+			sprs.ptcr = mfspr(SPRN_PTCR);
+			sprs.rpr = mfspr(SPRN_RPR);
+			sprs.tscr = mfspr(SPRN_TSCR);
+			sprs.ldbar = mfspr(SPRN_LDBAR);
+
+			sprs.lpcr = mfspr(SPRN_LPCR);
+			sprs.hfscr = mfspr(SPRN_HFSCR);
+			sprs.fscr = mfspr(SPRN_FSCR);
+			sprs.pid = mfspr(SPRN_PID);
+			sprs.purr = mfspr(SPRN_PURR);
+			sprs.spurr = mfspr(SPRN_SPURR);
+			sprs.dscr = mfspr(SPRN_DSCR);
+
+			sprs.mmcra = mfspr(SPRN_MMCRA);
+			sprs.mmcr0 = mfspr(SPRN_MMCR0);
+			sprs.mmcr1 = mfspr(SPRN_MMCR1);
+			sprs.mmcr2 = mfspr(SPRN_MMCR2);
+		}
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+		if (cpu_has_feature(CPU_FTR_P9_TM_XER_SO_BUG)) {
+			local_paca->requested_psscr = psscr;
+			/* order setting requested_psscr vs testing dont_stop */
+			smp_mb();
+			if (atomic_read(&local_paca->dont_stop)) {
+				local_paca->requested_psscr = 0;
+				return 0;
+			}
+
+			srr1 = isa3_idle_stop_mayloss(psscr);
+			local_paca->requested_psscr = 0;
+		} else
+#endif
+			srr1 = isa3_idle_stop_mayloss(psscr);
+	}
+
+	WARN_ON_ONCE(!srr1);
+	WARN_ON_ONCE(mfmsr() & (MSR_IR|MSR_DR));
+
+	if ((srr1 & SRR1_WAKESTATE) != SRR1_WS_NOLOSS) {
+		unsigned long mmcra;
+
+		/*
+		 * Workaround for POWER9 DD2, if we lost resources, the ERAT
+		 * might have been mixed up and needs flushing. We also need
+		 * to reload MMCR0 (see mmcr0 comment above).
+		 */
+		if (!cpu_has_feature(CPU_FTR_POWER9_DD2_1)) {
+			asm volatile(PPC_INVALIDATE_ERAT);
+			mtspr(SPRN_MMCR0, mmcr0);
+		}
+
+		/*
+		 * DD2.2 and earlier need to set then clear bit 60 in MMCRA
+		 * to ensure the PMU starts running.
+		 */
+		mmcra = mfspr(SPRN_MMCRA);
+		mmcra |= PPC_BIT(60);
+		mtspr(SPRN_MMCRA, mmcra);
+		mmcra &= ~PPC_BIT(60);
+		mtspr(SPRN_MMCRA, mmcra);
+	}
+
+	if (unlikely((srr1 & SRR1_WAKEMASK_P8) == SRR1_WAKEHMI))
+		hmi_exception_realmode(NULL);
+
+	if (likely((srr1 & SRR1_WAKESTATE) != SRR1_WS_HVLOSS)) {
+		mtmsr(MSR_KERNEL);
+		return srr1;
+	}
+
+	/* HV state loss */
+	WARN_ON((psscr & PSSCR_RL_MASK) < pnv_first_hv_loss_level);
+
+	atomic_lock_thread_idle();
+
+	WARN_ON(*state & thread);
+
+	if ((*state & ((1 << threads_per_core) - 1)) != 0)
+		goto core_woken;
+
+	/* Per-core SPRs */
+	mtspr(SPRN_PTCR, sprs.ptcr);
+	mtspr(SPRN_RPR, sprs.rpr);
+	mtspr(SPRN_TSCR, sprs.tscr);
+	mtspr(SPRN_LDBAR, sprs.ldbar);
+
+	if ((psscr & PSSCR_RL_MASK) >= pnv_first_tb_loss_level) {
+		unsigned long level = mfspr(SPRN_PSSCR) & PSSCR_RL_MASK;
+		if (level >= pnv_first_tb_loss_level) {
+			/* TB loss */
+			if (opal_resync_timebase() != OPAL_SUCCESS)
+				BUG();
+		}
+	}
+
+core_woken:
+	*state |= thread;
+	atomic_unlock_thread_idle();
+
+	/* Per-thread SPRs */
+	mtspr(SPRN_LPCR, sprs.lpcr);
+	mtspr(SPRN_HFSCR, sprs.hfscr);
+	mtspr(SPRN_FSCR, sprs.fscr);
+	mtspr(SPRN_PID, sprs.pid);
+	mtspr(SPRN_PURR, sprs.purr);
+	mtspr(SPRN_SPURR, sprs.spurr);
+	mtspr(SPRN_DSCR, sprs.dscr);
+
+	mtspr(SPRN_MMCRA, sprs.mmcra);
+	mtspr(SPRN_MMCR0, sprs.mmcr0);
+	mtspr(SPRN_MMCR1, sprs.mmcr1);
+	mtspr(SPRN_MMCR2, sprs.mmcr2);
+
+	if (!radix_enabled())
+		__slb_flush_and_rebolt();
+
+	mtmsr(MSR_KERNEL);
+
+	return srr1;
+}
+
+unsigned long power9_offline_stop(unsigned long psscr)
+{
+#ifndef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+	return power9_idle_stop(psscr, true);
+#else
+	unsigned long srr1;
+
+	/*
+	 * Tell KVM we're entering idle.
+	 * This does not have to be done in real mode because the P9 MMU
+	 * is independent per-thread. Some steppings share radix/hash mode
+	 * between threads, but in that case KVM has a barrier sync in real
+	 * mode before and after switching between radix and hash.
+	 */
+	local_paca->kvm_hstate.hwthread_state = KVM_HWTHREAD_IN_IDLE;
+	srr1 = power9_idle_stop(psscr, false);
+
+	if (local_paca->kvm_hstate.hwthread_state == KVM_HWTHREAD_IN_KERNEL) {
+		local_paca->kvm_hstate.hwthread_state = KVM_HWTHREAD_IN_KERNEL;
+		/* Order setting hwthread_state vs. testing hwthread_req */
+		smp_mb();
+	}
+	if (local_paca->kvm_hstate.hwthread_req) {
+		/* XXX: fix this so it's not garbage */
+		asm volatile("b	kvm_start_guest" ::: "memory");
+	}
+	mtmsr(MSR_KERNEL);
+
+	return srr1;
+#endif
+}
+
 static unsigned long __power9_idle_type(unsigned long stop_psscr_val,
 				      unsigned long stop_psscr_mask)
 {
@@ -358,7 +581,7 @@ static unsigned long __power9_idle_type(unsigned long stop_psscr_val,
 	psscr = (psscr & ~stop_psscr_mask) | stop_psscr_val;
 
 	__ppc64_runlatch_off();
-	srr1 = power9_idle_stop(psscr);
+	srr1 = power9_idle_stop(psscr, true);
 	__ppc64_runlatch_on();
 
 	fini_irq_for_idle_irqsoff();
@@ -407,7 +630,7 @@ void pnv_power9_force_smt4_catch(void)
 			atomic_inc(&paca_ptrs[cpu0+thr]->dont_stop);
 	}
 	/* order setting dont_stop vs testing requested_psscr */
-	mb();
+	smp_mb();
 	for (thr = 0; thr < threads_per_core; ++thr) {
 		if (!paca_ptrs[cpu0+thr]->requested_psscr)
 			++awake_threads;
@@ -623,7 +846,8 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
 	u64 *psscr_val = NULL;
 	u64 *psscr_mask = NULL;
 	u32 *residency_ns = NULL;
-	u64 max_residency_ns = 0;
+	u64 max_deep_residency_ns = 0;
+	u64 max_default_residency_ns = 0;
 	int rc = 0, i;
 
 	psscr_val = kcalloc(dt_idle_states, sizeof(*psscr_val), GFP_KERNEL);
@@ -661,26 +885,25 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
 	}
 
 	/*
-	 * Set pnv_first_deep_stop_state, pnv_deepest_stop_psscr_{val,mask},
-	 * and the pnv_default_stop_{val,mask}.
-	 *
-	 * pnv_first_deep_stop_state should be set to the first stop
-	 * level to cause hypervisor state loss.
-	 *
 	 * pnv_deepest_stop_{val,mask} should be set to values corresponding to
 	 * the deepest stop state.
 	 *
 	 * pnv_default_stop_{val,mask} should be set to values corresponding to
-	 * the shallowest (OPAL_PM_STOP_INST_FAST) loss-less stop state.
+	 * the deepest loss-less (OPAL_PM_STOP_INST_FAST) stop state.
 	 */
-	pnv_first_deep_stop_state = MAX_STOP_STATE;
+	pnv_first_tb_loss_level = MAX_STOP_STATE + 1;
+	pnv_first_hv_loss_level = MAX_STOP_STATE + 1;
 	for (i = 0; i < dt_idle_states; i++) {
 		int err;
 		u64 psscr_rl = psscr_val[i] & PSSCR_RL_MASK;
 
+		if ((flags[i] & OPAL_PM_TIMEBASE_STOP) &&
+		     (pnv_first_tb_loss_level > psscr_rl))
+			pnv_first_tb_loss_level = psscr_rl;
+
 		if ((flags[i] & OPAL_PM_LOSE_FULL_CONTEXT) &&
-		     (pnv_first_deep_stop_state > psscr_rl))
-			pnv_first_deep_stop_state = psscr_rl;
+		     (pnv_first_hv_loss_level > psscr_rl))
+			pnv_first_hv_loss_level = psscr_rl;
 
 		err = validate_psscr_val_mask(&psscr_val[i], &psscr_mask[i],
 					      flags[i]);
@@ -689,19 +912,21 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
 			continue;
 		}
 
-		if (max_residency_ns < residency_ns[i]) {
-			max_residency_ns = residency_ns[i];
+		if (max_deep_residency_ns < residency_ns[i]) {
+			max_deep_residency_ns = residency_ns[i];
 			pnv_deepest_stop_psscr_val = psscr_val[i];
 			pnv_deepest_stop_psscr_mask = psscr_mask[i];
 			pnv_deepest_stop_flag = flags[i];
 			deepest_stop_found = true;
 		}
 
-		if (!default_stop_found &&
+		if (max_default_residency_ns < residency_ns[i] &&
 		    (flags[i] & OPAL_PM_STOP_INST_FAST)) {
+			max_default_residency_ns = residency_ns[i];
 			pnv_default_stop_val = psscr_val[i];
 			pnv_default_stop_mask = psscr_mask[i];
 			default_stop_found = true;
+			WARN_ON(flags[i] & OPAL_PM_LOSE_FULL_CONTEXT);
 		}
 	}
 
@@ -721,15 +946,48 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
 			pnv_deepest_stop_psscr_mask);
 	}
 
-	pr_info("cpuidle-powernv: Requested Level (RL) value of first deep stop = 0x%llx\n",
-		pnv_first_deep_stop_state);
+	pr_info("cpuidle-powernv: First stop level that may lose SPRs = 0x%lld\n",
+		pnv_first_hv_loss_level);
+
+	pr_info("cpuidle-powernv: First stop level that may lose timebase = 0x%lld\n",
+		pnv_first_tb_loss_level);
 out:
 	kfree(psscr_val);
 	kfree(psscr_mask);
 	kfree(residency_ns);
+
 	return rc;
 }
 
+static void __init pnv_disable_deep_states(void)
+{
+	/*
+	 * The stop-api is unable to restore hypervisor
+	 * resources on wakeup from platform idle states which
+	 * lose full context. So disable such states.
+	 */
+	supported_cpuidle_states &= ~OPAL_PM_LOSE_FULL_CONTEXT;
+	pr_warn("cpuidle-powernv: Disabling idle states that lose full context\n");
+	pr_warn("cpuidle-powernv: Idle power-savings, CPU-Hotplug affected\n");
+
+	if (cpu_has_feature(CPU_FTR_ARCH_300) &&
+	    (pnv_deepest_stop_flag & OPAL_PM_LOSE_FULL_CONTEXT)) {
+		/*
+		 * Use the default stop state for CPU-Hotplug
+		 * if available.
+		 */
+		if (default_stop_found) {
+			pnv_deepest_stop_psscr_val = pnv_default_stop_val;
+			pnv_deepest_stop_psscr_mask = pnv_default_stop_mask;
+			pr_warn("cpuidle-powernv: Offlined CPUs will stop with psscr = 0x%016llx\n",
+				pnv_deepest_stop_psscr_val);
+		} else { /* Fallback to snooze loop for CPU-Hotplug */
+			deepest_stop_found = false;
+			pr_warn("cpuidle-powernv: Offlined CPUs will busy wait\n");
+		}
+	}
+}
+
 /*
  * Probe device tree for supported idle states
  */
@@ -771,6 +1029,7 @@ static void __init pnv_probe_idle_states(void)
 out:
 	kfree(flags);
 }
+
 static int __init pnv_init_idle_states(void)
 {
 
@@ -798,10 +1057,29 @@ static int __init pnv_init_idle_states(void)
 				&dev_attr_fastsleep_workaround_applyonce);
 	}
 
-	pnv_alloc_idle_core_states();
+	if (!cpu_has_feature(CPU_FTR_ARCH_300)) {
+		pnv_alloc_idle_core_states_p8();
+		if (supported_cpuidle_states & OPAL_PM_NAP_ENABLED)
+			ppc_md.power_save = power7_idle;
+	} else {
+		int cpu;
+
+		for_each_present_cpu(cpu) {
+			paca_ptrs[cpu]->requested_psscr = 0;
+			paca_ptrs[cpu]->idle_state = 0;
+			if (cpu == cpu_first_thread_sibling(cpu))
+				paca_ptrs[cpu]->idle_state =
+					(1 << threads_per_core) - 1;
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+			atomic_set(&paca_ptrs[cpu]->dont_stop, 0);
+#endif
+		}
+	}
 
-	if (supported_cpuidle_states & OPAL_PM_NAP_ENABLED)
-		ppc_md.power_save = power7_idle;
+	if (supported_cpuidle_states & OPAL_PM_LOSE_FULL_CONTEXT) {
+		if (pnv_save_sprs_for_deep_states())
+			pnv_disable_deep_states();
+	}
 
 out:
 	return 0;
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 21119cfe8474..09120d4ec12b 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2425,19 +2425,18 @@ static void dump_one_paca(int cpu)
 #endif
 
 #ifdef CONFIG_PPC_POWERNV
-	DUMP(p, core_idle_state_ptr, "%-*px");
-	DUMP(p, thread_idle_state, "%#-*x");
-	DUMP(p, thread_mask, "%#-*x");
-	DUMP(p, subcore_sibling_mask, "%#-*x");
-	DUMP(p, requested_psscr, "%#-*llx");
-	DUMP(p, stop_sprs.pid, "%#-*llx");
-	DUMP(p, stop_sprs.ldbar, "%#-*llx");
-	DUMP(p, stop_sprs.fscr, "%#-*llx");
-	DUMP(p, stop_sprs.hfscr, "%#-*llx");
-	DUMP(p, stop_sprs.mmcr1, "%#-*llx");
-	DUMP(p, stop_sprs.mmcr2, "%#-*llx");
-	DUMP(p, stop_sprs.mmcra, "%#-*llx");
-	DUMP(p, dont_stop.counter, "%#-*x");
+	if (!cpu_has_feature(CPU_FTR_ARCH_300)) {
+		DUMP(p, core_idle_state_ptr, "%-*px");
+		DUMP(p, thread_idle_state, "%#-*x");
+		DUMP(p, thread_mask, "%#-*x");
+		DUMP(p, subcore_sibling_mask, "%#-*x");
+	} else {
+		DUMP(p, idle_state, "%#-*lx");
+		DUMP(p, requested_psscr, "%#-*llx");
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+		DUMP(p, dont_stop.counter, "%#-*x");
+#endif
+	}
 #endif
 
 	DUMP(p, accounting.utime, "%#-*lx");
-- 
2.17.0
