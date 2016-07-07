Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlqSr16H6zDr3C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 06:47:55 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u67Kixjw003769
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 16:47:53 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2415xn2knp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jul 2016 16:47:53 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Thu, 7 Jul 2016 14:47:52 -0600
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: benh@au1.ibm.com, paulus@ozlabs.org, mikey@neuling.org,
 ego@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, maddy@linux.vnet.ibm.com,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH v7 07/11] powerpc/powernv: Add platform support for stop
 instruction
Date: Fri,  8 Jul 2016 02:17:08 +0530
In-Reply-To: <1467924432-29003-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1467924432-29003-1-git-send-email-shreyas@linux.vnet.ibm.com>
Message-Id: <1467924432-29003-8-git-send-email-shreyas@linux.vnet.ibm.com>
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
Changes in v7
=============
 - LMRR, LMSER and ADSR not restored since its not necessary
 - power_stop0, power_stop renamed to power9_idle and power_idle_stop
 - PSSCR template is now a macro instead of storing in paca
 - power9_idle in C file instead of assembly
 - Fixed TOC related bug
 - Handling subcore within FTR section
 - Functions in idle.c reordered and broken into multiple functions
 - calling __restore_cpu_power8/9 via cur_cpu_spec->cpu_restore 
 
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
 arch/powerpc/include/asm/opal-api.h       |  11 +-
 arch/powerpc/include/asm/ppc-opcode.h     |   4 +
 arch/powerpc/include/asm/processor.h      |   2 +
 arch/powerpc/include/asm/reg.h            |  10 ++
 arch/powerpc/kernel/idle_book3s.S         | 189 ++++++++++++++++++++++++------
 arch/powerpc/platforms/powernv/idle.c     | 174 ++++++++++++++++++++++-----
 8 files changed, 328 insertions(+), 66 deletions(-)

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
diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 72b5f27..6de1e4e 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -166,13 +166,20 @@
 
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
diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 9de9df1..81657a1 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -205,6 +205,8 @@
 #define PPC_INST_SLEEP			0x4c0003a4
 #define PPC_INST_WINKLE			0x4c0003e4
 
+#define PPC_INST_STOP			0x4c0002e4
+
 /* A2 specific instructions */
 #define PPC_INST_ERATWE			0x7c0001a6
 #define PPC_INST_ERATRE			0x7c000166
@@ -394,6 +396,8 @@
 #define PPC_SLEEP		stringify_in_c(.long PPC_INST_SLEEP)
 #define PPC_WINKLE		stringify_in_c(.long PPC_INST_WINKLE)
 
+#define PPC_STOP		stringify_in_c(.long PPC_INST_STOP)
+
 /* BHRB instructions */
 #define PPC_CLRBHRB		stringify_in_c(.long PPC_INST_CLRBHRB)
 #define PPC_MFBHRBE(r, n)	stringify_in_c(.long PPC_INST_BHRBE | \
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index b5925d5..68e3bf5 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -460,6 +460,8 @@ extern int powersave_nap;	/* set if nap mode can be used in idle loop */
 extern unsigned long power7_nap(int check_irq);
 extern unsigned long power7_sleep(void);
 extern unsigned long power7_winkle(void);
+extern unsigned long power9_idle_stop(unsigned long stop_level);
+
 extern void flush_instruction_cache(void);
 extern void hard_reset_now(void);
 extern void poweroff_now(void);
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 320136f..387dc60 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -145,6 +145,15 @@
 #define MSR_64BIT	0
 #endif
 
+/* Power Management - Processor Stop Status and Control Register Fields */
+#define PSSCR_RL_MASK		0x0000000F /* Requested Level */
+#define PSSCR_MTL_MASK		0x000000F0 /* Maximum Transition Level */
+#define PSSCR_TR_MASK		0x00000300 /* Transition State */
+#define PSSCR_PSLL_MASK		0x000F0000 /* Power-Saving Level Limit */
+#define PSSCR_EC		0x00100000 /* Exit Criterion */
+#define PSSCR_ESL		0x00200000 /* Enable State Loss */
+#define PSSCR_SD		0x00400000 /* Status Disable */
+
 /* Floating Point Status and Control Register (FPSCR) Fields */
 #define FPSCR_FX	0x80000000	/* FPU exception summary */
 #define FPSCR_FEX	0x40000000	/* FPU enabled exception summary */
@@ -290,6 +299,7 @@
 #define SPRN_PMICR	0x354   /* Power Management Idle Control Reg */
 #define SPRN_PMSR	0x355   /* Power Management Status Reg */
 #define SPRN_PMMAR	0x356	/* Power Management Memory Activity Register */
+#define SPRN_PSSCR	0x357	/* Processor Stop Status and Control Register (ISA 3.0) */
 #define SPRN_PMCR	0x374	/* Power Management Control Register */
 
 /* HFSCR and FSCR bit numbers are the same */
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 2f909a1..601bbcc 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
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
 
@@ -37,6 +38,11 @@
 #define _AMOR	GPR9
 #define _WORT	GPR10
 #define _WORC	GPR11
+#define _PTCR	GPR12
+
+#define PSSCR_HV_TEMPLATE	PSSCR_ESL | PSSCR_EC | \
+				PSSCR_PSLL_MASK | PSSCR_TR_MASK | \
+				PSSCR_MTL_MASK
 
 /* Idle state entry routines */
 
@@ -61,8 +67,17 @@ save_sprs_to_stack:
 	 * Note all register i.e per-core, per-subcore or per-thread is saved
 	 * here since any thread in the core might wake up first
 	 */
+BEGIN_FTR_SECTION
+	mfspr	r3,SPRN_PTCR
+	std	r3,_PTCR(r1)
+	/*
+	 * Note - SDR1 is dropped in Power ISA v3. Hence not restoring
+	 * SDR1 here
+	 */
+FTR_SECTION_ELSE
 	mfspr	r3,SPRN_SDR1
 	std	r3,_SDR1(r1)
+ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
 	mfspr	r3,SPRN_RPR
 	std	r3,_RPR(r1)
 	mfspr	r3,SPRN_SPURR
@@ -100,7 +115,8 @@ core_idle_lock_held:
 
 /*
  * Pass requested state in r3:
- *	r3 - PNV_THREAD_NAP/SLEEP/WINKLE
+ *	r3 - PNV_THREAD_NAP/SLEEP/WINKLE in POWER8
+ *	   - Requested STOP state in POWER9
  *
  * To check IRQ_HAPPENED in r4
  * 	0 - don't check
@@ -161,7 +177,7 @@ _GLOBAL(pnv_powersave_common)
 
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 	/* Tell KVM we're entering idle */
-	li	r4,KVM_HWTHREAD_IN_NAP
+	li	r4,KVM_HWTHREAD_IN_IDLE
 	stb	r4,HSTATE_HWTHREAD_STATE(r13)
 #endif
 
@@ -243,6 +259,41 @@ enter_winkle:
 
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
@@ -293,6 +344,17 @@ ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S, 66);		\
 
 
 /*
+ * r3 - requested stop state
+ */
+_GLOBAL(power9_idle_stop)
+	LOAD_REG_IMMEDIATE(r4, PSSCR_HV_TEMPLATE)
+	or	r4,r4,r3
+	mtspr	SPRN_PSSCR, r4
+	li	r4, 1
+	LOAD_REG_ADDR(r5,power_enter_stop)
+	b	pnv_powersave_common
+	/* No return */
+/*
  * Called from reset vector. Check whether we have woken up with
  * hypervisor state loss. If yes, restore hypervisor state and return
  * back to reset vector.
@@ -301,7 +363,33 @@ ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S, 66);		\
  * cr3 - set to gt if waking up with partial/complete hypervisor state loss
  */
 _GLOBAL(pnv_restore_hyp_resource)
+	ld	r2,PACATOC(r13);
+BEGIN_FTR_SECTION
+	/*
+	 * POWER ISA 3. Use PSSCR to determine if we
+	 * are waking up from deep idle state
+	 */
+	LOAD_REG_ADDRBASE(r5,pnv_first_deep_stop_state)
+	ld	r4,ADDROFF(pnv_first_deep_stop_state)(r5)
+
+	mfspr	r5,SPRN_PSSCR
 	/*
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
@@ -324,9 +412,17 @@ _GLOBAL(pnv_restore_hyp_resource)
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
-	ld	r2,PACATOC(r13);
 	ld	r1,PACAR1(r13)
 	/*
 	 * Before entering any idle state, the NVGPRs are saved in the stack
@@ -361,35 +457,35 @@ lwarx_loop2:
 	bnel	core_idle_lock_held
 
 	cmpwi	cr2,r15,0
-	lbz	r4,PACA_SUBCORE_SIBLING_MASK(r13)
-	and	r4,r4,r15
-	cmpwi	cr1,r4,0	/* Check if first in subcore */
 
 	/*
 	 * At this stage
-	 * cr1 - 0b0100 if first thread to wakeup in subcore
-	 * cr2 - 0b0100 if first thread to wakeup in core
-	 * cr3-  0b0010 if waking up from sleep or winkle
-	 * cr4 - 0b0100 if waking up from winkle
+	 * cr2 - eq if first thread to wakeup in core
+	 * cr3-  gt if waking up with partial/complete hypervisor state loss
+	 * cr4 - eq if waking up from complete hypervisor state loss.
 	 */
 
-	or	r15,r15,r7		/* Set thread bit */
-
-	beq	cr1,first_thread_in_subcore
-
-	/* Not first thread in subcore to wake up */
-	stwcx.	r15,0,r14
-	bne-	lwarx_loop2
-	isync
-	b	common_exit
-
-first_thread_in_subcore:
-	/* First thread in subcore to wakeup */
 	ori	r15,r15,PNV_CORE_IDLE_LOCK_BIT
 	stwcx.	r15,0,r14
 	bne-	lwarx_loop2
 	isync
 
+BEGIN_FTR_SECTION
+	lbz	r4,PACA_SUBCORE_SIBLING_MASK(r13)
+	and	r4,r4,r15
+	cmpwi	r4,0	/* Check if first in subcore */
+
+	or	r15,r15,r7		/* Set thread bit */
+	beq	first_thread_in_subcore
+END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
+
+	or	r15,r15,r7		/* Set thread bit */
+	beq	cr2,first_thread_in_core
+
+	/* Not first thread in core or subcore to wake up */
+	b	clear_lock
+
+first_thread_in_subcore:
 	/*
 	 * If waking up from sleep, subcore state is not lost. Hence
 	 * skip subcore state restore
@@ -399,6 +495,7 @@ first_thread_in_subcore:
 	/* Restore per-subcore state */
 	ld      r4,_SDR1(r1)
 	mtspr   SPRN_SDR1,r4
+
 	ld      r4,_RPR(r1)
 	mtspr   SPRN_RPR,r4
 	ld	r4,_AMOR(r1)
@@ -414,19 +511,23 @@ subcore_state_restored:
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
@@ -439,7 +540,18 @@ timebase_resync:
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
+	ld	r4,_RPR(r1)
+	mtspr	SPRN_RPR,r4
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
+
 	ld	r4,_TSCR(r1)
 	mtspr	SPRN_TSCR,r4
 	ld	r4,_WORC(r1)
@@ -461,9 +573,7 @@ common_exit:
 
 	/* Waking up from winkle */
 
-	/* Restore per thread state */
-	bl	__restore_cpu_power8
-
+BEGIN_MMU_FTR_SECTION
 	/* Restore SLB  from PACA */
 	ld	r8,PACA_SLBSHADOWPTR(r13)
 
@@ -477,6 +587,9 @@ common_exit:
 	slbmte	r6,r5
 1:	addi	r8,r8,16
 	.endr
+END_MMU_FTR_SECTION_IFCLR(MMU_FTR_RADIX)
+
+	/* Restore per thread state */
 
 	ld	r4,_SPURR(r1)
 	mtspr	SPRN_SPURR,r4
@@ -487,6 +600,16 @@ common_exit:
 	ld	r4,_WORT(r1)
 	mtspr	SPRN_WORT,r4
 
+	/* Call cur_cpu_spec->cpu_restore() */
+	LOAD_REG_ADDR(r4, cur_cpu_spec)
+	ld	r4,0(r4)
+	ld	r12,CPU_SPEC_RESTORE(r4)
+#ifdef PPC64_ELF_ABI_v1
+	ld	r12,0(r12)
+#endif
+	mtctr	r12
+	bctrl
+
 hypervisor_state_restored:
 
 	mtspr	SPRN_SRR1,r16
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 8a77f5c..006e467 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -27,9 +27,12 @@
 #include "powernv.h"
 #include "subcore.h"
 
+/* Power ISA 3.0 allows for stop states 0x0 - 0xF */
+#define MAX_STOP_STATE	0xF
+
 static u32 supported_cpuidle_states;
 
-static int pnv_save_sprs_for_winkle(void)
+static int pnv_save_sprs_for_deep_states(void)
 {
 	int cpu;
 	int rc;
@@ -50,15 +53,19 @@ static int pnv_save_sprs_for_winkle(void)
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
@@ -130,8 +137,8 @@ static void pnv_alloc_idle_core_states(void)
 
 	update_subcore_sibling_mask();
 
-	if (supported_cpuidle_states & OPAL_PM_WINKLE_ENABLED)
-		pnv_save_sprs_for_winkle();
+	if (supported_cpuidle_states & OPAL_PM_LOSE_FULL_CONTEXT)
+		pnv_save_sprs_for_deep_states();
 }
 
 u32 pnv_get_supported_cpuidle_states(void)
@@ -230,43 +237,151 @@ static DEVICE_ATTR(fastsleep_workaround_applyonce, 0600,
 			show_fastsleep_workaround_applyonce,
 			store_fastsleep_workaround_applyonce);
 
-static int __init pnv_init_idle_states(void)
+
+/*
+ * Used for ppc_md.power_save which needs a function with no parameters
+ */
+static void power9_idle(void)
 {
-	struct device_node *power_mgt;
-	int dt_idle_states;
-	u32 *flags;
-	int i;
+	/* Requesting stop state 0 */
+	power9_idle_stop(0);
+}
+/*
+ * First deep stop state. Used to figure out when to save/restore
+ * hypervisor context.
+ */
+u64 pnv_first_deep_stop_state;
 
-	supported_cpuidle_states = 0;
+/*
+ * Power ISA 3.0 idle initialization.
+ *
+ * POWER ISA 3.0 defines a new SPR Processor stop Status and Control
+ * Register (PSSCR) to control idle behavior.
+ *
+ * PSSCR layout:
+ * ----------------------------------------------------------
+ * | PLS | /// | SD | ESL | EC | PSLL | /// | TR | MTL | RL |
+ * ----------------------------------------------------------
+ * 0      4     41   42    43   44     48    54   56    60
+ *
+ * PSSCR key fields:
+ *	Bits 0:3  - Power-Saving Level Status (PLS). This field indicates the
+ *	lowest power-saving state the thread entered since stop instruction was
+ *	last executed.
+ *
+ *	Bit 41 - Status Disable(SD)
+ *	0 - Shows PLS entries
+ *	1 - PLS entries are all 0
+ *
+ *	Bit 42 - Enable State Loss
+ *	0 - No state is lost irrespective of other fields
+ *	1 - Allows state loss
+ *
+ *	Bit 43 - Exit Criterion
+ *	0 - Exit from power-save mode on any interrupt
+ *	1 - Exit from power-save mode controlled by LPCR's PECE bits
+ *
+ *	Bits 44:47 - Power-Saving Level Limit
+ *	This limits the power-saving level that can be entered into.
+ *
+ *	Bits 60:63 - Requested Level
+ *	Used to specify which power-saving level must be entered on executing
+ *	stop instruction
+ *
+ * @np: /ibm,opal/power-mgt device node
+ * @flags: cpu-idle-state-flags array
+ * @dt_idle_states: Number of idle state entries
+ * Returns 0 on success
+ */
+static int __init pnv_arch300_idle_init(struct device_node *np, u32 *flags,
+					int dt_idle_states)
+{
+	u64 *psscr_val = NULL;
+	int rc = 0, i;
 
-	if (cpuidle_disable != IDLE_NO_OVERRIDE)
+	psscr_val = kcalloc(dt_idle_states, sizeof(*psscr_val),
+				GFP_KERNEL);
+	if (!psscr_val) {
+		rc = -1;
 		goto out;
-
-	if (!firmware_has_feature(FW_FEATURE_OPAL))
+	}
+	if (of_property_read_u64_array(np,
+		"ibm,cpu-idle-state-psscr",
+		psscr_val, dt_idle_states)) {
+		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-states-psscr in DT\n");
+		rc = -1;
 		goto out;
+	}
 
-	power_mgt = of_find_node_by_path("/ibm,opal/power-mgt");
-	if (!power_mgt) {
+	/*
+	 * Set pnv_first_deep_stop_state to the first stop level
+	 * to cause hypervisor state loss
+	 */
+	pnv_first_deep_stop_state = MAX_STOP_STATE;
+	for (i = 0; i < dt_idle_states; i++) {
+		u64 psscr_rl = psscr_val[i] & PSSCR_RL_MASK;
+
+		if ((flags[i] & OPAL_PM_LOSE_FULL_CONTEXT) &&
+		     (pnv_first_deep_stop_state > psscr_rl))
+			pnv_first_deep_stop_state = psscr_rl;
+	}
+
+out:
+	kfree(psscr_val);
+	return rc;
+}
+
+/*
+ * Probe device tree for supported idle states
+ */
+static void __init pnv_probe_idle_states(void)
+{
+	struct device_node *np;
+	int dt_idle_states;
+	u32 *flags = NULL;
+	int i;
+
+	np = of_find_node_by_path("/ibm,opal/power-mgt");
+	if (!np) {
 		pr_warn("opal: PowerMgmt Node not found\n");
 		goto out;
 	}
-	dt_idle_states = of_property_count_u32_elems(power_mgt,
+	dt_idle_states = of_property_count_u32_elems(np,
 			"ibm,cpu-idle-state-flags");
 	if (dt_idle_states < 0) {
 		pr_warn("cpuidle-powernv: no idle states found in the DT\n");
 		goto out;
 	}
 
-	flags = kzalloc(sizeof(*flags) * dt_idle_states, GFP_KERNEL);
-	if (of_property_read_u32_array(power_mgt,
+	flags = kcalloc(dt_idle_states, sizeof(*flags),  GFP_KERNEL);
+
+	if (of_property_read_u32_array(np,
 			"ibm,cpu-idle-state-flags", flags, dt_idle_states)) {
 		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-flags in DT\n");
-		goto out_free;
+		goto out;
+	}
+
+	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+		if (pnv_arch300_idle_init(np, flags, dt_idle_states))
+			goto out;
 	}
 
 	for (i = 0; i < dt_idle_states; i++)
 		supported_cpuidle_states |= flags[i];
 
+out:
+	kfree(flags);
+}
+static int __init pnv_init_idle_states(void)
+{
+
+	supported_cpuidle_states = 0;
+
+	if (cpuidle_disable != IDLE_NO_OVERRIDE)
+		goto out;
+
+	pnv_probe_idle_states();
+
 	if (!(supported_cpuidle_states & OPAL_PM_SLEEP_ENABLED_ER1)) {
 		patch_instruction(
 			(unsigned int *)pnv_fastsleep_workaround_at_entry,
@@ -288,8 +403,9 @@ static int __init pnv_init_idle_states(void)
 
 	if (supported_cpuidle_states & OPAL_PM_NAP_ENABLED)
 		ppc_md.power_save = power7_idle;
-out_free:
-	kfree(flags);
+	else if (supported_cpuidle_states & OPAL_PM_STOP_INST_FAST)
+		ppc_md.power_save = power9_idle;
+
 out:
 	return 0;
 }
