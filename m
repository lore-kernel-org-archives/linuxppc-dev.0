Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrKsG2hnJzDr82
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 23:50:58 +1000 (AEST)
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Thu, 21 Apr 2016 07:50:56 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 3B0333E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 07:50:54 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3LDosM038731946
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 06:50:54 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3LDorst004393
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 07:50:53 -0600
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, paulus@ozlabs.org,
 linux-kernel@vger.kernel.org, mikey@neuling.org,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH 7/9] powerpc/powernv: Add platform support for stop instruction
Date: Thu, 21 Apr 2016 19:19:57 +0530
Message-Id: <1461246599-6098-8-git-send-email-shreyas@linux.vnet.ibm.com>
In-Reply-To: <1461246599-6098-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1461246599-6098-1-git-send-email-shreyas@linux.vnet.ibm.com>
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
 b) new per thread SPR named PSSCR is added which controls the behavior
	of stop instruction.

PSSCR has following key fields
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

Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/cpuidle.h        |   2 +
 arch/powerpc/include/asm/cputable.h       |   4 +-
 arch/powerpc/include/asm/kvm_book3s_asm.h |   2 +-
 arch/powerpc/include/asm/machdep.h        |   1 +
 arch/powerpc/include/asm/opal-api.h       |  11 +-
 arch/powerpc/include/asm/paca.h           |   4 +
 arch/powerpc/include/asm/ppc-opcode.h     |   4 +
 arch/powerpc/include/asm/processor.h      |   1 +
 arch/powerpc/include/asm/reg.h            |  11 ++
 arch/powerpc/kernel/Makefile              |   1 +
 arch/powerpc/kernel/asm-offsets.c         |   4 +
 arch/powerpc/kernel/idle_power7.S         |   2 +-
 arch/powerpc/kernel/idle_power_common.S   |  26 +++-
 arch/powerpc/kernel/idle_power_stop.S     | 221 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/Kconfig            |   4 +
 arch/powerpc/platforms/powernv/Kconfig    |   1 +
 arch/powerpc/platforms/powernv/idle.c     |  80 +++++++++--
 17 files changed, 361 insertions(+), 18 deletions(-)
 create mode 100644 arch/powerpc/kernel/idle_power_stop.S

diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
index faa97b7..6d20583 100644
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
diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index df4fb5f..a4739a1 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -205,6 +205,7 @@ enum {
 #define CPU_FTR_DABRX			LONG_ASM_CONST(0x0800000000000000)
 #define CPU_FTR_PMAO_BUG		LONG_ASM_CONST(0x1000000000000000)
 #define CPU_FTR_SUBCORE			LONG_ASM_CONST(0x2000000000000000)
+#define CPU_FTR_STOP_INST		LONG_ASM_CONST(0x4000000000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -464,7 +465,8 @@ enum {
 	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
 	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY | \
 	    CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_DAWR | \
-	    CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP | CPU_FTR_ARCH_300)
+	    CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP | CPU_FTR_ARCH_300 | \
+	    CPU_FTR_STOP_INST)
 #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
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
index fd22442..ca4b116 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -261,6 +261,7 @@ struct machdep_calls {
 extern void e500_idle(void);
 extern void power4_idle(void);
 extern void power7_idle(void);
+extern void power_stop0(void);
 extern void ppc6xx_idle(void);
 extern void book3e_idle(void);
 
diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index f8faaae..3b978ba 100644
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
index 546540b..bf48b7e 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -171,6 +171,10 @@ struct paca_struct {
 	/* Mask to denote subcore sibling threads */
 	u8 subcore_sibling_mask;
 #endif
+#ifdef CONFIG_PPC_STOP_INST
+	 /* Template for PSSCR with EC, ESL, TR, PSLL, MTL fields set */
+	u64 thread_psscr;
+#endif
 
 #ifdef CONFIG_PPC_BOOK3S_64
 	/* Exclusive emergency stack pointer for machine check exception. */
diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 7ab04fc..f66747f 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -198,6 +198,8 @@
 #define PPC_INST_SLEEP			0x4c0003a4
 #define PPC_INST_WINKLE			0x4c0003e4
 
+#define PPC_INST_STOP			0x4c0002e4
+
 /* A2 specific instructions */
 #define PPC_INST_ERATWE			0x7c0001a6
 #define PPC_INST_ERATRE			0x7c000166
@@ -368,6 +370,8 @@
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
index f5f4c66..f74c6a1 100644
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
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index b877b84..052224e 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_ALTIVEC)		+= vecemu.o
 obj-$(CONFIG_PPC_970_NAP)	+= idle_power4.o
 obj-$(CONFIG_PPC_P7_NAP)	+= idle_power7.o
 obj-$(CONFIG_PPC_POWERNV)	+= idle_power_common.o
+obj-$(CONFIG_PPC_STOP_INST)	+= idle_power_stop.o
 procfs-y			:= proc_powerpc.o
 obj-$(CONFIG_PROC_FS)		+= $(procfs-y)
 rtaspci-$(CONFIG_PPC64)-$(CONFIG_PCI)	:= rtas_pci.o
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 0d0183d..33191b1 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -771,6 +771,10 @@ int main(void)
 			offsetof(struct paca_struct, thread_mask));
 	DEFINE(PACA_SUBCORE_SIBLING_MASK,
 			offsetof(struct paca_struct, subcore_sibling_mask));
+#ifdef CONFIG_PPC_STOP_INST
+	DEFINE(PACA_THREAD_PSSCR,
+			offsetof(struct paca_struct, thread_psscr));
+#endif
 #endif
 
 	DEFINE(PPC_DBELL_SERVER, PPC_DBELL_SERVER);
diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle_power7.S
index 6a24769..d85f834 100644
--- a/arch/powerpc/kernel/idle_power7.S
+++ b/arch/powerpc/kernel/idle_power7.S
@@ -46,7 +46,7 @@ core_idle_lock_held:
 power7_enter_nap_mode:
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 	/* Tell KVM we're napping */
-	li	r4,KVM_HWTHREAD_IN_NAP
+	li	r4,KVM_HWTHREAD_IN_IDLE
 	stb	r4,HSTATE_HWTHREAD_STATE(r13)
 #endif
 	stb	r3,PACA_THREAD_IDLE_STATE(r13)
diff --git a/arch/powerpc/kernel/idle_power_common.S b/arch/powerpc/kernel/idle_power_common.S
index ff7a541..63de119 100644
--- a/arch/powerpc/kernel/idle_power_common.S
+++ b/arch/powerpc/kernel/idle_power_common.S
@@ -96,11 +96,35 @@ _GLOBAL(power_powersave_common)
  * back to reset vector.
  */
 _GLOBAL(power7_restore_hyp_resource)
+	GET_PACA(r13)
+BEGIN_FTR_SECTION_NESTED(888)
+	/*
+	 * POWER ISA 3. Use PSSCR to determine if we
+	 * are waking up from deep idle state
+	 */
+	LOAD_REG_ADDRBASE(r5,pnv_first_deep_stop_state)
+	ld	r4,ADDROFF(pnv_first_deep_stop_state)(r5)
+
+	mfspr	r5,SPRN_PSSCR
+	/*
+	 * 0-4 bits correspond to Power-Saving Level Status
+	 * which indicates the idle state we are waking up from
+	 */
+	rldicl  r5,r5,4,60
+	cmpd	r5,r4
+	bge	power_stop_wakeup_hyp_loss
 	/*
+	 * Waking up without hypervisor state loss. Return to
+	 * reset vector
+	 */
+	blr
+
+END_FTR_SECTION_NESTED(CPU_FTR_STOP_INST,CPU_FTR_STOP_INST,888)
+	/*
+	 * POWER ISA 2.07 or less.
 	 * Check if last bit of HSPGR0 is set. This indicates whether we are
 	 * waking up from winkle.
 	 */
-	GET_PACA(r13)
 	clrldi	r5,r13,63
 	clrrdi	r13,r13,1
 	cmpwi	cr4,r5,1
diff --git a/arch/powerpc/kernel/idle_power_stop.S b/arch/powerpc/kernel/idle_power_stop.S
new file mode 100644
index 0000000..6c86c56
--- /dev/null
+++ b/arch/powerpc/kernel/idle_power_stop.S
@@ -0,0 +1,221 @@
+#include <linux/threads.h>
+
+#include <asm/processor.h>
+#include <asm/cputable.h>
+#include <asm/thread_info.h>
+#include <asm/ppc_asm.h>
+#include <asm/asm-offsets.h>
+#include <asm/ppc-opcode.h>
+#include <asm/hw_irq.h>
+#include <asm/kvm_book3s_asm.h>
+#include <asm/opal.h>
+#include <asm/cpuidle.h>
+#include <asm/book3s/64/mmu-hash.h>
+#include <asm/exception-64s.h>
+
+#undef DEBUG
+
+/*
+ * rA - Requested stop state
+ * rB - Spare reg that can be used
+ */
+#define PSSCR_REQUEST_STATE(rA, rB) 		\
+	ld	rB, PACA_THREAD_PSSCR(r13);	\
+	or	rB,rB,rA;			\
+	mtspr	SPRN_PSSCR, rB;			\
+
+	.text
+
+	.globl	power_enter_stop
+power_enter_stop:
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+	/* Tell KVM we're napping */
+	li	r4,KVM_HWTHREAD_IN_IDLE
+	stb	r4,HSTATE_HWTHREAD_STATE(r13)
+#endif
+	LOAD_REG_ADDRBASE(r5,pnv_first_deep_stop_state)
+	ld	r4,ADDROFF(pnv_first_deep_stop_state)(r5)
+	cmpd	cr3,r3,r4
+	bge	2f
+	IDLE_STATE_ENTER_SEQ(PPC_STOP)
+2:
+	lbz     r7,PACA_THREAD_MASK(r13)
+	ld      r14,PACA_CORE_IDLE_STATE_PTR(r13)
+
+lwarx_loop1:
+	lwarx   r15,0,r14
+	andi.   r9,r15,PNV_CORE_IDLE_LOCK_BIT
+	bnel    core_idle_lock_held
+	andc    r15,r15,r7                      /* Clear thread bit */
+
+	andi.   r15,r15,PNV_CORE_IDLE_THREAD_BITS
+	stwcx.  r15,0,r14
+	bne-    lwarx_loop1
+
+	/*
+	 * Note all register i.e per-core, per-subcore or per-thread is saved
+	 * here since any thread in the core might wake up first
+	 */
+	mfspr	r3,SPRN_RPR
+	std	r3,_RPR(r1)
+	mfspr	r3,SPRN_SPURR
+	std	r3,_SPURR(r1)
+	mfspr	r3,SPRN_PURR
+	std	r3,_PURR(r1)
+	mfspr	r3,SPRN_TSCR
+	std	r3,_TSCR(r1)
+	mfspr	r3,SPRN_DSCR
+	std	r3,_DSCR(r1)
+	mfspr	r3,SPRN_AMOR
+	std	r3,_AMOR(r1)
+
+	IDLE_STATE_ENTER_SEQ(PPC_STOP)
+
+
+_GLOBAL(power_stop)
+	PSSCR_REQUEST_STATE(r3,r4)
+	li	r4, 1
+	LOAD_REG_ADDR(r5,power_enter_stop)
+	b	power_powersave_common
+
+_GLOBAL(power_stop0)
+	li	r3,0
+	li	r4,1
+	LOAD_REG_ADDR(r5,power_enter_stop)
+	PSSCR_REQUEST_STATE(r3,r4)
+	b	power_powersave_common
+
+_GLOBAL(power_stop_wakeup_hyp_loss)
+	ld	r2,PACATOC(r13);
+	ld	r1,PACAR1(r13)
+	/*
+	 * Before entering any idle state, the NVGPRs are saved in the stack
+	 * and they are restored before switching to the process context. Hence
+	 * until they are restored, they are free to be used.
+	 *
+	 * Save SRR1 in a NVGPR as it might be clobbered in opal_call_realmode
+	 * (called in CHECK_HMI_INTERRUPT). SRR1 is required to determine the
+	 * wakeup reason if we branch to kvm_start_guest.
+	 */
+	mflr	r17
+	mfspr	r16,SPRN_SRR1
+BEGIN_FTR_SECTION
+	CHECK_HMI_INTERRUPT
+END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
+
+	lbz	r7,PACA_THREAD_MASK(r13)
+	ld	r14,PACA_CORE_IDLE_STATE_PTR(r13)
+lwarx_loop2:
+	lwarx	r15,0,r14
+	andi.	r9,r15,PNV_CORE_IDLE_LOCK_BIT
+	/*
+	 * Lock bit is set in one of the 2 cases-
+	 * a. In the stop enter path, the last thread is executing
+	 * fastsleep workaround code.
+	 * b. In the wake up path, another thread is resyncing timebase or
+	 * restoring context
+	 * In either case loop until the lock bit is cleared.
+	 */
+	bne	core_idle_lock_held
+
+	cmpwi	cr2,r15,0
+	lbz	r4,PACA_SUBCORE_SIBLING_MASK(r13)
+	and	r4,r4,r15
+	cmpwi	cr1,r4,0	/* Check if first in subcore */
+
+	or	r15,r15,r7		/* Set thread bit */
+
+	beq	cr1,first_thread_in_subcore
+
+	/* Not first thread in subcore to wake up */
+	stwcx.	r15,0,r14
+	bne-	lwarx_loop2
+	isync
+	b	common_exit
+
+core_idle_lock_held:
+	HMT_LOW
+core_idle_lock_loop:
+	lwz	r15,0(14)
+	andi.   r9,r15,PNV_CORE_IDLE_LOCK_BIT
+	bne	core_idle_lock_loop
+	HMT_MEDIUM
+	b	lwarx_loop2
+
+first_thread_in_subcore:
+	/* First thread in subcore to wakeup */
+	ori	r15,r15,PNV_CORE_IDLE_LOCK_BIT
+	stwcx.	r15,0,r14
+	bne-	lwarx_loop2
+	isync
+
+	/*
+	 * If waking up from sleep, subcore state is not lost. Hence
+	 * skip subcore state restore
+	 */
+	bne	cr4,subcore_state_restored
+
+	/* Restore per-subcore state */
+	ld      r4,_RPR(r1)
+	mtspr   SPRN_RPR,r4
+	ld	r4,_AMOR(r1)
+	mtspr	SPRN_AMOR,r4
+
+subcore_state_restored:
+	/*
+	 * Check if the thread is also the first thread in the core. If not,
+	 * skip to clear_lock.
+	 */
+	bne	cr2,clear_lock
+
+first_thread_in_core:
+
+timebase_resync:
+	/* Do timebase resync if we are waking up from sleep. Use cr3 value
+	 * set in exceptions-64s.S */
+	ble	cr3,clear_lock
+	/* Time base re-sync */
+	li	r0,OPAL_RESYNC_TIMEBASE
+	bl	opal_call_realmode;
+
+	/*
+	 * If waking up from sleep, per core state is not lost, skip to
+	 * clear_lock.
+	 */
+	bne	cr4,clear_lock
+
+	/* Restore per core state */
+	ld	r4,_TSCR(r1)
+	mtspr	SPRN_TSCR,r4
+
+clear_lock:
+	andi.	r15,r15,PNV_CORE_IDLE_THREAD_BITS
+	lwsync
+	stw	r15,0(r14)
+
+common_exit:
+	/*
+	 * Common to all threads.
+	 *
+	 * If waking up from sleep, hypervisor state is not lost. Hence
+	 * skip hypervisor state restore.
+	 */
+	bne	cr4,hypervisor_state_restored
+
+	/* Waking up from deep idle state */
+
+	/* Restore per thread state */
+	bl	__restore_cpu_power8
+
+	ld	r4,_SPURR(r1)
+	mtspr	SPRN_SPURR,r4
+	ld	r4,_PURR(r1)
+	mtspr	SPRN_PURR,r4
+	ld	r4,_DSCR(r1)
+	mtspr	SPRN_DSCR,r4
+
+hypervisor_state_restored:
+
+	mtspr	SPRN_SRR1,r16
+	mtlr	r17
+	blr
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 46a3533..5fd9611 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -196,6 +196,10 @@ config PPC_P7_NAP
 	bool
 	default n
 
+config PPC_STOP_INST
+	bool
+	default n
+
 config PPC_INDIRECT_PIO
 	bool
 	select GENERIC_IOMAP
diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
index 604190c..9f65d4a 100644
--- a/arch/powerpc/platforms/powernv/Kconfig
+++ b/arch/powerpc/platforms/powernv/Kconfig
@@ -5,6 +5,7 @@ config PPC_POWERNV
 	select PPC_XICS
 	select PPC_ICP_NATIVE
 	select PPC_P7_NAP
+	select PPC_STOP_INST
 	select PPC_PCI_CHOICE if EMBEDDED
 	select EPAPR_BOOT
 	select PPC_INDIRECT_PIO
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index fbb09fb..7643ff1 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -29,7 +29,7 @@
 
 static u32 supported_cpuidle_states;
 
-int pnv_save_sprs_for_winkle(void)
+int pnv_save_sprs_for_deep_states(void)
 {
 	int cpu;
 	int rc;
@@ -50,15 +50,19 @@ int pnv_save_sprs_for_winkle(void)
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
+		if (!cpu_has_feature(CPU_FTR_STOP_INST)) {
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
@@ -130,8 +134,8 @@ static void pnv_alloc_idle_core_states(void)
 
 	update_subcore_sibling_mask();
 
-	if (supported_cpuidle_states & OPAL_PM_WINKLE_ENABLED)
-		pnv_save_sprs_for_winkle();
+	if (supported_cpuidle_states & OPAL_PM_LOSE_FULL_CONTEXT)
+		pnv_save_sprs_for_deep_states();
 }
 
 u32 pnv_get_supported_cpuidle_states(void)
@@ -230,11 +234,18 @@ static DEVICE_ATTR(fastsleep_workaround_applyonce, 0600,
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
@@ -264,6 +275,30 @@ static int __init pnv_init_idle_states(void)
 		goto out_free;
 	}
 
+	if (cpu_has_feature(CPU_FTR_STOP_INST)) {
+		psscr_val = kcalloc(dt_idle_states, sizeof(*psscr_val),
+					GFP_KERNEL);
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
+		pnv_first_deep_stop_state = 0xF;
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
 
@@ -286,8 +321,29 @@ static int __init pnv_init_idle_states(void)
 
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
