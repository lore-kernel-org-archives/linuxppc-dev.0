Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPvgh2RPgzDqJV
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 02:55:12 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u58GsYWe057455
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Jun 2016 12:55:10 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23e9m3x0mg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jun 2016 12:55:10 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Wed, 8 Jun 2016 10:55:08 -0600
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: benh@au1.ibm.com, paulus@ozlabs.org, mikey@neuling.org,
 ego@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH v6 08/11] powerpc/powernv: Add platform support for stop
 instruction
Date: Wed,  8 Jun 2016 11:54:28 -0500
In-Reply-To: <1465404871-5406-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1465404871-5406-1-git-send-email-shreyas@linux.vnet.ibm.com>
Message-Id: <1465404871-5406-9-git-send-email-shreyas@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

POWER ISA v3 defines a new idle processor core mechanism. In summary,
 a) new instruction named stop is added. This instruction replaces
	instructions like nap, sleep, rvwinkle.
 b) new per thread SPR named Processor Stop Status and Control Register
	(PSSCR) is added which controls the behavior of stop instruction.

PSSCR layout:
----------------------------------------------------------
| PLS | /// | SD | ESL | EC | PSLL | /// | TR | MTL | RL |
----------------------------------------------------------
0      4     41   42    43   44     48    54   56    60

PSSCR key fields:
	Bits 0:3  - Power-Saving Level Status. This field indicates the lowest
	power-saving state the thread entered since stop instruction was last
	executed.

	Bit 42 - Enable State Loss
	0 - No state is lost irrespective of other fields
	1 - Allows state loss

	Bits 44:47 - Power-Saving Level Limit
	This limits the power-saving level that can be entered into.

	Bits 60:63 - Requested Level
	Used to specify which power-saving level must be entered on executing
	stop instruction

This patch adds support for stop instruction and PSSCR handling.

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
---
Changes in v6
=============
 - Save/restore new P9 SPRs when using deep idle states

Changes in v4:
==============
 - Added PSSCR layout to commit message
 - Improved / Fixed comments
 - Fixed whitespace error in paca.h
 - Using MAX_POSSIBLE_STOP_STATE macro instead of hardcoding 0xF as 
   max possible stop state

Changes in v3:
==============
 - Instead of introducing new file idle_power_stop.S, P9 idle support
   is added to idle_power_common.S using CPU_FTR sections.
 - Fixed r4 reg clobbering in power_stop0
 - Improved comments

Changes in v2:
==============
 - Using CPU_FTR_ARCH_300 bit instead of CPU_FTR_STOP_INST

 arch/powerpc/include/asm/cpuidle.h        |   2 +
 arch/powerpc/include/asm/kvm_book3s_asm.h |   2 +-
 arch/powerpc/include/asm/machdep.h        |   1 +
 arch/powerpc/include/asm/opal-api.h       |  11 +-
 arch/powerpc/include/asm/paca.h           |   2 +
 arch/powerpc/include/asm/ppc-opcode.h     |   4 +
 arch/powerpc/include/asm/processor.h      |   1 +
 arch/powerpc/include/asm/reg.h            |  14 +++
 arch/powerpc/kernel/asm-offsets.c         |   2 +
 arch/powerpc/kernel/idle_power_common.S   | 175 +++++++++++++++++++++++++++---
 arch/powerpc/platforms/powernv/idle.c     |  84 ++++++++++++--
 11 files changed, 265 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
index d2f99ca..3d7fc06 100644
--- a/arch/powerpc/include/asm/cpuidle.h
+++ b/arch/powerpc/include/asm/cpuidle.h
@@ -13,6 +13,8 @@
 #ifndef __ASSEMBLY__
 extern u32 pnv_fastsleep_workaround_at_entry[];
 extern u32 pnv_fastsleep_workaround_at_exit[];
+
+extern u64 pnv_first_deep_stop_state;
 #endif
 
 #endif
diff --git a/arch/powerpc/include/asm/kvm_book3s_asm.h b/arch/powerpc/include/asm/kvm_book3s_asm.h
index 72b6225..d318d43 100644
--- a/arch/powerpc/include/asm/kvm_book3s_asm.h
+++ b/arch/powerpc/include/asm/kvm_book3s_asm.h
@@ -162,7 +162,7 @@ struct kvmppc_book3s_shadow_vcpu {
 
 /* Values for kvm_state */
 #define KVM_HWTHREAD_IN_KERNEL	0
-#define KVM_HWTHREAD_IN_NAP	1
+#define KVM_HWTHREAD_IN_IDLE	1
 #define KVM_HWTHREAD_IN_KVM	2
 
 #endif /* __ASM_KVM_BOOK3S_ASM_H__ */
diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 6bdcd0d..ae3b155 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -262,6 +262,7 @@ struct machdep_calls {
 extern void e500_idle(void);
 extern void power4_idle(void);
 extern void power7_idle(void);
+extern void power_stop0(void);
 extern void ppc6xx_idle(void);
 extern void book3e_idle(void);
 
diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 9bb8ddf..7f3f8c6 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -162,13 +162,20 @@
 
 /* Device tree flags */
 
-/* Flags set in power-mgmt nodes in device tree if
- * respective idle states are supported in the platform.
+/*
+ * Flags set in power-mgmt nodes in device tree describing
+ * idle states that are supported in the platform.
  */
+
+#define OPAL_PM_TIMEBASE_STOP		0x00000002
+#define OPAL_PM_LOSE_HYP_CONTEXT	0x00002000
+#define OPAL_PM_LOSE_FULL_CONTEXT	0x00004000
 #define OPAL_PM_NAP_ENABLED		0x00010000
 #define OPAL_PM_SLEEP_ENABLED		0x00020000
 #define OPAL_PM_WINKLE_ENABLED		0x00040000
 #define OPAL_PM_SLEEP_ENABLED_ER1	0x00080000 /* with workaround */
+#define OPAL_PM_STOP_INST_FAST		0x00100000
+#define OPAL_PM_STOP_INST_DEEP		0x00200000
 
 /*
  * OPAL_CONFIG_CPU_IDLE_STATE parameters
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 546540b..ae91b44 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -171,6 +171,8 @@ struct paca_struct {
 	/* Mask to denote subcore sibling threads */
 	u8 subcore_sibling_mask;
 #endif
+	/* Template for PSSCR with EC, ESL, TR, PSLL, MTL fields set */
+	u64 thread_psscr;
 
 #ifdef CONFIG_PPC_BOOK3S_64
 	/* Exclusive emergency stack pointer for machine check exception. */
diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 1d035c1..6a8e43b 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -199,6 +199,8 @@
 #define PPC_INST_SLEEP			0x4c0003a4
 #define PPC_INST_WINKLE			0x4c0003e4
 
+#define PPC_INST_STOP			0x4c0002e4
+
 /* A2 specific instructions */
 #define PPC_INST_ERATWE			0x7c0001a6
 #define PPC_INST_ERATRE			0x7c000166
@@ -370,6 +372,8 @@
 #define PPC_SLEEP		stringify_in_c(.long PPC_INST_SLEEP)
 #define PPC_WINKLE		stringify_in_c(.long PPC_INST_WINKLE)
 
+#define PPC_STOP		stringify_in_c(.long PPC_INST_STOP)
+
 /* BHRB instructions */
 #define PPC_CLRBHRB		stringify_in_c(.long PPC_INST_CLRBHRB)
 #define PPC_MFBHRBE(r, n)	stringify_in_c(.long PPC_INST_BHRBE | \
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 009fab1..7f92fc8 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -457,6 +457,7 @@ extern int powersave_nap;	/* set if nap mode can be used in idle loop */
 extern unsigned long power7_nap(int check_irq);
 extern unsigned long power7_sleep(void);
 extern unsigned long power7_winkle(void);
+extern unsigned long power_stop(unsigned long state);
 extern void flush_instruction_cache(void);
 extern void hard_reset_now(void);
 extern void poweroff_now(void);
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index a0948f4..89a00d9 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -145,6 +145,16 @@
 #define MSR_64BIT	0
 #endif
 
+/* Power Management - PSSCR Fields */
+#define PSSCR_RL_MASK		0x0000000F
+#define PSSCR_MTL_MASK		0x000000F0
+#define PSSCR_TR_MASK		0x00000300
+#define PSSCR_PSLL_MASK		0x000F0000
+#define PSSCR_EC		0x00100000
+#define PSSCR_ESL		0x00200000
+#define PSSCR_SD		0x00400000
+
+
 /* Floating Point Status and Control Register (FPSCR) Fields */
 #define FPSCR_FX	0x80000000	/* FPU exception summary */
 #define FPSCR_FEX	0x40000000	/* FPU enabled exception summary */
@@ -288,6 +298,7 @@
 #define SPRN_PMICR	0x354   /* Power Management Idle Control Reg */
 #define SPRN_PMSR	0x355   /* Power Management Status Reg */
 #define SPRN_PMMAR	0x356	/* Power Management Memory Activity Register */
+#define SPRN_PSSCR	0x357	/* Processor Stop Status and Control Register */
 #define SPRN_PMCR	0x374	/* Power Management Control Register */
 
 /* HFSCR and FSCR bit numbers are the same */
@@ -761,6 +772,9 @@
 #define   SIER_SDAR_VALID	0x0200000	/* SDAR contents valid */
 #define SPRN_SIAR	796
 #define SPRN_SDAR	797
+#define SPRN_LMRR	813
+#define SPRN_LMSER	814
+#define SPRN_ASDR	816
 #define SPRN_TACR	888
 #define SPRN_TCSCR	889
 #define SPRN_CSIGR	890
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 9ea0955..670d2a7 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -779,6 +779,8 @@ int main(void)
 			offsetof(struct paca_struct, thread_mask));
 	DEFINE(PACA_SUBCORE_SIBLING_MASK,
 			offsetof(struct paca_struct, subcore_sibling_mask));
+	DEFINE(PACA_THREAD_PSSCR,
+			offsetof(struct paca_struct, thread_psscr));
 #endif
 
 	DEFINE(PPC_DBELL_SERVER, PPC_DBELL_SERVER);
diff --git a/arch/powerpc/kernel/idle_power_common.S b/arch/powerpc/kernel/idle_power_common.S
index 2f909a1..c6c2f66 100644
--- a/arch/powerpc/kernel/idle_power_common.S
+++ b/arch/powerpc/kernel/idle_power_common.S
@@ -1,6 +1,6 @@
 /*
- *  This file contains idle entry/exit functions for POWER7 and
- *  POWER8 CPUs.
+ *  This file contains idle entry/exit functions for POWER7,
+ *  POWER8 and POWER9 CPUs.
  *
  *  This program is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU General Public License
@@ -21,6 +21,7 @@
 #include <asm/opal.h>
 #include <asm/cpuidle.h>
 #include <asm/book3s/64/mmu-hash.h>
+#include <asm/mmu.h>
 
 #undef DEBUG
 
@@ -28,6 +29,8 @@
  * Use unused space in the interrupt stack to save and restore
  * registers for winkle support.
  */
+#define _LMRR	GPR0
+#define _LMSER	GPR1
 #define _SDR1	GPR3
 #define _RPR	GPR4
 #define _SPURR	GPR5
@@ -37,6 +40,8 @@
 #define _AMOR	GPR9
 #define _WORT	GPR10
 #define _WORC	GPR11
+#define _PTCR	GPR12
+#define _ASDR	GPR13
 
 /* Idle state entry routines */
 
@@ -50,6 +55,15 @@
 	IDLE_INST;						\
 	b	.
 
+/*
+ * rA - Requested stop state
+ * rB - Spare reg that can be used
+ */
+#define PSSCR_REQUEST_STATE(rA, rB) 		\
+	ld	rB, PACA_THREAD_PSSCR(r13);	\
+	or	rB,rB,rA;			\
+	mtspr	SPRN_PSSCR, rB;
+
 	.text
 
 /*
@@ -61,8 +75,19 @@ save_sprs_to_stack:
 	 * Note all register i.e per-core, per-subcore or per-thread is saved
 	 * here since any thread in the core might wake up first
 	 */
+BEGIN_FTR_SECTION
+	mfspr	r3,SPRN_PTCR
+	std	r3,_PTCR(r1)
+	mfspr	r3,SPRN_LMRR
+	std	r3,_LMRR(r1)
+	mfspr	r3,SPRN_LMSER
+	std	r3,_LMSER(r1)
+	mfspr	r3,SPRN_ASDR
+	std	r3,_ASDR(r1)
+FTR_SECTION_ELSE
 	mfspr	r3,SPRN_SDR1
 	std	r3,_SDR1(r1)
+ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
 	mfspr	r3,SPRN_RPR
 	std	r3,_RPR(r1)
 	mfspr	r3,SPRN_SPURR
@@ -100,7 +125,8 @@ core_idle_lock_held:
 
 /*
  * Pass requested state in r3:
- *	r3 - PNV_THREAD_NAP/SLEEP/WINKLE
+ *	r3 - PNV_THREAD_NAP/SLEEP/WINKLE in POWER8
+ *	   - Requested STOP state in POWER9
  *
  * To check IRQ_HAPPENED in r4
  * 	0 - don't check
@@ -161,7 +187,7 @@ _GLOBAL(pnv_powersave_common)
 
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 	/* Tell KVM we're entering idle */
-	li	r4,KVM_HWTHREAD_IN_NAP
+	li	r4,KVM_HWTHREAD_IN_IDLE
 	stb	r4,HSTATE_HWTHREAD_STATE(r13)
 #endif
 
@@ -243,6 +269,41 @@ enter_winkle:
 
 	IDLE_STATE_ENTER_SEQ(PPC_WINKLE)
 
+/*
+ * r3 - requested stop state
+ */
+power_enter_stop:
+/*
+ * Check if the requested state is a deep idle state.
+ */
+	LOAD_REG_ADDRBASE(r5,pnv_first_deep_stop_state)
+	ld	r4,ADDROFF(pnv_first_deep_stop_state)(r5)
+	cmpd	r3,r4
+	bge	2f
+	IDLE_STATE_ENTER_SEQ(PPC_STOP)
+2:
+/*
+ * Entering deep idle state.
+ * Clear thread bit in PACA_CORE_IDLE_STATE, save SPRs to
+ * stack and enter stop
+ */
+	lbz     r7,PACA_THREAD_MASK(r13)
+	ld      r14,PACA_CORE_IDLE_STATE_PTR(r13)
+
+lwarx_loop_stop:
+	lwarx   r15,0,r14
+	andi.   r9,r15,PNV_CORE_IDLE_LOCK_BIT
+	bnel    core_idle_lock_held
+	andc    r15,r15,r7                      /* Clear thread bit */
+
+	stwcx.  r15,0,r14
+	bne-    lwarx_loop_stop
+	isync
+
+	bl	save_sprs_to_stack
+
+	IDLE_STATE_ENTER_SEQ(PPC_STOP)
+
 _GLOBAL(power7_idle)
 	/* Now check if user or arch enabled NAP mode */
 	LOAD_REG_ADDRBASE(r3,powersave_nap)
@@ -293,6 +354,21 @@ ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S, 66);		\
 
 
 /*
+ * Used for ppc_md.power_save which needs a function with no parameters
+ */
+_GLOBAL(power_stop0)
+	li	r3,0
+	/* Fall through to power_stop */
+/*
+ * r3 - requested stop state
+ */
+_GLOBAL(power_stop)
+	PSSCR_REQUEST_STATE(r3,r4)
+	li	r4, 1
+	LOAD_REG_ADDR(r5,power_enter_stop)
+	b	pnv_powersave_common
+	/* No return */
+/*
  * Called from reset vector. Check whether we have woken up with
  * hypervisor state loss. If yes, restore hypervisor state and return
  * back to reset vector.
@@ -301,7 +377,32 @@ ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S, 66);		\
  * cr3 - set to gt if waking up with partial/complete hypervisor state loss
  */
 _GLOBAL(pnv_restore_hyp_resource)
+BEGIN_FTR_SECTION
 	/*
+	 * POWER ISA 3. Use PSSCR to determine if we
+	 * are waking up from deep idle state
+	 */
+	LOAD_REG_ADDRBASE(r5,pnv_first_deep_stop_state)
+	ld	r4,ADDROFF(pnv_first_deep_stop_state)(r5)
+
+	mfspr	r5,SPRN_PSSCR
+	/*
+	 * 0-3 bits correspond to Power-Saving Level Status
+	 * which indicates the idle state we are waking up from
+	 */
+	rldicl  r5,r5,4,60
+	cmpd	cr4,r5,r4
+	bge	cr4,pnv_wakeup_tb_loss
+	/*
+	 * Waking up without hypervisor state loss. Return to
+	 * reset vector
+	 */
+	blr
+
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
+
+	/*
+	 * POWER ISA 2.07 or less.
 	 * Check if last bit of HSPGR0 is set. This indicates whether we are
 	 * waking up from winkle.
 	 */
@@ -324,7 +425,16 @@ _GLOBAL(pnv_restore_hyp_resource)
 	blr	/* Return back to System Reset vector from where
 		   pnv_restore_hyp_resource was invoked */
 
-
+/*
+ * Called if waking up from idle state which can cause either partial or
+ * complete hyp state loss.
+ * In POWER8, called if waking up from fastsleep or winkle
+ * In POWER9, called if waking up from stop state >= pnv_first_deep_stop_state
+ *
+ * r13 - PACA
+ * cr3 - gt if waking up with partial/complete hypervisor state loss
+ * cr4 - eq if waking up from complete hypervisor state loss.
+ */
 _GLOBAL(pnv_wakeup_tb_loss)
 	ld	r2,PACATOC(r13);
 	ld	r1,PACAR1(r13)
@@ -367,10 +477,10 @@ lwarx_loop2:
 
 	/*
 	 * At this stage
-	 * cr1 - 0b0100 if first thread to wakeup in subcore
-	 * cr2 - 0b0100 if first thread to wakeup in core
-	 * cr3-  0b0010 if waking up from sleep or winkle
-	 * cr4 - 0b0100 if waking up from winkle
+	 * cr1 - eq if first thread to wakeup in subcore
+	 * cr2 - eq if first thread to wakeup in core
+	 * cr3-  gt if waking up with partial/complete hypervisor state loss
+	 * cr4 - eq if waking up from complete hypervisor state loss.
 	 */
 
 	or	r15,r15,r7		/* Set thread bit */
@@ -397,8 +507,11 @@ first_thread_in_subcore:
 	bne	cr4,subcore_state_restored
 
 	/* Restore per-subcore state */
+BEGIN_FTR_SECTION
 	ld      r4,_SDR1(r1)
 	mtspr   SPRN_SDR1,r4
+END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
+
 	ld      r4,_RPR(r1)
 	mtspr   SPRN_RPR,r4
 	ld	r4,_AMOR(r1)
@@ -414,19 +527,23 @@ subcore_state_restored:
 first_thread_in_core:
 
 	/*
-	 * First thread in the core waking up from fastsleep. It needs to
+	 * First thread in the core waking up from any state which can cause
+	 * partial or complete hypervisor state loss. It needs to
 	 * call the fastsleep workaround code if the platform requires it.
 	 * Call it unconditionally here. The below branch instruction will
-	 * be patched out when the idle states are discovered if platform
-	 * does not require workaround.
+	 * be patched out if the platform does not have fastsleep or does not
+	 * require the workaround. Patching will be performed during the
+	 * discovery of idle-states.
 	 */
 .global pnv_fastsleep_workaround_at_exit
 pnv_fastsleep_workaround_at_exit:
 	b	fastsleep_workaround_at_exit
 
 timebase_resync:
-	/* Do timebase resync if we are waking up from sleep. Use cr3 value
-	 * set in exceptions-64s.S */
+	/*
+	 * Use cr3 which indicates that we are waking up with atleast partial
+	 * hypervisor state loss to determine if TIMEBASE RESYNC is needed.
+	 */
 	ble	cr3,clear_lock
 	/* Time base re-sync */
 	li	r0,OPAL_RESYNC_TIMEBASE
@@ -439,7 +556,16 @@ timebase_resync:
 	 */
 	bne	cr4,clear_lock
 
-	/* Restore per core state */
+	/*
+	 * First thread in the core to wake up and its waking up with
+	 * complete hypervisor state loss. Restore per core hypervisor
+	 * state.
+	 */
+BEGIN_FTR_SECTION
+	ld	r4,_PTCR(r1)
+	mtspr	SPRN_PTCR,r4
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
+
 	ld	r4,_TSCR(r1)
 	mtspr	SPRN_TSCR,r4
 	ld	r4,_WORC(r1)
@@ -461,9 +587,7 @@ common_exit:
 
 	/* Waking up from winkle */
 
-	/* Restore per thread state */
-	bl	__restore_cpu_power8
-
+BEGIN_MMU_FTR_SECTION
 	/* Restore SLB  from PACA */
 	ld	r8,PACA_SLBSHADOWPTR(r13)
 
@@ -477,6 +601,21 @@ common_exit:
 	slbmte	r6,r5
 1:	addi	r8,r8,16
 	.endr
+END_MMU_FTR_SECTION_IFCLR(MMU_FTR_RADIX)
+
+	/* Restore per thread state */
+BEGIN_FTR_SECTION
+	bl      __restore_cpu_power9
+
+	ld	r4,_LMRR(r1)
+	mtspr	SPRN_LMRR,r4
+	ld	r4,_LMSER(r1)
+	mtspr	SPRN_LMSER,r4
+	ld	r4,_ASDR(r1)
+	mtspr	SPRN_ASDR,r4
+FTR_SECTION_ELSE
+	bl	__restore_cpu_power8
+ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
 
 	ld	r4,_SPURR(r1)
 	mtspr	SPRN_SPURR,r4
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index fbb09fb..bfbd359 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -27,9 +27,11 @@
 #include "powernv.h"
 #include "subcore.h"
 
+#define MAX_STOP_STATE	0xF
+
 static u32 supported_cpuidle_states;
 
-int pnv_save_sprs_for_winkle(void)
+int pnv_save_sprs_for_deep_states(void)
 {
 	int cpu;
 	int rc;
@@ -50,15 +52,19 @@ int pnv_save_sprs_for_winkle(void)
 		uint64_t pir = get_hard_smp_processor_id(cpu);
 		uint64_t hsprg0_val = (uint64_t)&paca[cpu];
 
-		/*
-		 * HSPRG0 is used to store the cpu's pointer to paca. Hence last
-		 * 3 bits are guaranteed to be 0. Program slw to restore HSPRG0
-		 * with 63rd bit set, so that when a thread wakes up at 0x100 we
-		 * can use this bit to distinguish between fastsleep and
-		 * deep winkle.
-		 */
-		hsprg0_val |= 1;
-
+		if (!cpu_has_feature(CPU_FTR_ARCH_300)) {
+			/*
+			 * HSPRG0 is used to store the cpu's pointer to paca.
+			 * Hence last 3 bits are guaranteed to be 0. Program
+			 * slw to restore HSPRG0 with 63rd bit set, so that
+			 * when a thread wakes up at 0x100 we can use this bit
+			 * to distinguish between fastsleep and deep winkle.
+			 * This is not necessary with stop/psscr since PLS
+			 * field of psscr indicates which state we are waking
+			 * up from.
+			 */
+			hsprg0_val |= 1;
+		}
 		rc = opal_slw_set_reg(pir, SPRN_HSPRG0, hsprg0_val);
 		if (rc != 0)
 			return rc;
@@ -130,8 +136,8 @@ static void pnv_alloc_idle_core_states(void)
 
 	update_subcore_sibling_mask();
 
-	if (supported_cpuidle_states & OPAL_PM_WINKLE_ENABLED)
-		pnv_save_sprs_for_winkle();
+	if (supported_cpuidle_states & OPAL_PM_LOSE_FULL_CONTEXT)
+		pnv_save_sprs_for_deep_states();
 }
 
 u32 pnv_get_supported_cpuidle_states(void)
@@ -230,11 +236,18 @@ static DEVICE_ATTR(fastsleep_workaround_applyonce, 0600,
 			show_fastsleep_workaround_applyonce,
 			store_fastsleep_workaround_applyonce);
 
+/*
+ * First deep stop state. Used to figure out when to save/restore
+ * hypervisor context.
+ */
+u64 pnv_first_deep_stop_state;
+
 static int __init pnv_init_idle_states(void)
 {
 	struct device_node *power_mgt;
 	int dt_idle_states;
 	u32 *flags;
+	u64 *psscr_val = NULL;
 	int i;
 
 	supported_cpuidle_states = 0;
@@ -264,6 +277,32 @@ static int __init pnv_init_idle_states(void)
 		goto out_free;
 	}
 
+	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+		psscr_val = kcalloc(dt_idle_states, sizeof(*psscr_val),
+					GFP_KERNEL);
+		if (!psscr_val)
+			goto out_free;
+		if (of_property_read_u64_array(power_mgt,
+			"ibm,cpu-idle-state-psscr",
+			psscr_val, dt_idle_states)) {
+			pr_warn("cpuidle-powernv: missing ibm,cpu-idle-states-psscr in DT\n");
+			goto out_free_psscr;
+		}
+
+		/*
+		 * Set pnv_first_deep_stop_state to the first stop level
+		 * to cause hypervisor state loss
+		 */
+		pnv_first_deep_stop_state = MAX_STOP_STATE;
+		for (i = 0; i < dt_idle_states; i++) {
+			u64 psscr_rl = psscr_val[i] & PSSCR_RL_MASK;
+
+			if ((flags[i] & OPAL_PM_LOSE_FULL_CONTEXT) &&
+			     (pnv_first_deep_stop_state > psscr_rl))
+				pnv_first_deep_stop_state = psscr_rl;
+		}
+	}
+
 	for (i = 0; i < dt_idle_states; i++)
 		supported_cpuidle_states |= flags[i];
 
@@ -286,8 +325,29 @@ static int __init pnv_init_idle_states(void)
 
 	pnv_alloc_idle_core_states();
 
+	if (supported_cpuidle_states & OPAL_PM_STOP_INST_FAST)
+		for_each_possible_cpu(i) {
+
+			u64 psscr_init_val = PSSCR_ESL | PSSCR_EC |
+					PSSCR_PSLL_MASK | PSSCR_TR_MASK |
+					PSSCR_MTL_MASK;
+
+			paca[i].thread_psscr = psscr_init_val;
+			/*
+			 * Memory barrier to ensure that the writes to PACA
+			 * goes through before ppc_md.power_save is updated
+			 * below.
+			 */
+			mb();
+		}
+
 	if (supported_cpuidle_states & OPAL_PM_NAP_ENABLED)
 		ppc_md.power_save = power7_idle;
+	else if (supported_cpuidle_states & OPAL_PM_STOP_INST_FAST)
+		ppc_md.power_save = power_stop0;
+
+out_free_psscr:
+	kfree(psscr_val);
 out_free:
 	kfree(flags);
 out:
-- 
2.1.4
