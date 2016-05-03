Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzZ3q18gczDqFS
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 18:25:10 +1000 (AEST)
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Tue, 3 May 2016 02:25:09 -0600
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, paulus@ozlabs.org,
 linux-kernel@vger.kernel.org, mikey@neuling.org,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH v2 3/9] powerpc/powernv: Move idle code usable by multiple
 hardware to common location
Date: Tue,  3 May 2016 13:54:32 +0530
Message-Id: <1462263878-25237-4-git-send-email-shreyas@linux.vnet.ibm.com>
In-Reply-To: <1462263878-25237-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1462263878-25237-1-git-send-email-shreyas@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CPU-idle related code like context save/restore functions idle_power7.S
can reused for adding stop instruction support. Move this
code to a new commonly accessible location.

Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/Makefile            |   1 +
 arch/powerpc/kernel/idle_power7.S       | 144 ----------------------------
 arch/powerpc/kernel/idle_power_common.S | 160 ++++++++++++++++++++++++++++++++
 3 files changed, 161 insertions(+), 144 deletions(-)
 create mode 100644 arch/powerpc/kernel/idle_power_common.S

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 2da380f..b877b84 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_PPC64)		+= vdso64/
 obj-$(CONFIG_ALTIVEC)		+= vecemu.o
 obj-$(CONFIG_PPC_970_NAP)	+= idle_power4.o
 obj-$(CONFIG_PPC_P7_NAP)	+= idle_power7.o
+obj-$(CONFIG_PPC_POWERNV)	+= idle_power_common.o
 procfs-y			:= proc_powerpc.o
 obj-$(CONFIG_PROC_FS)		+= $(procfs-y)
 rtaspci-$(CONFIG_PPC64)-$(CONFIG_PCI)	:= rtas_pci.o
diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle_power7.S
index 82d164b..594e1c5 100644
--- a/arch/powerpc/kernel/idle_power7.S
+++ b/arch/powerpc/kernel/idle_power7.S
@@ -68,80 +68,6 @@ core_idle_lock_held:
 	lwarx	r15,0,r14
 	blr
 
-/*
- * Pass requested state in r3:
- *	r3 - PNV_THREAD_NAP/SLEEP/WINKLE
- *
- * To check IRQ_HAPPENED in r4
- * 	0 - don't check
- * 	1 - check
- */
-_GLOBAL(power7_powersave_common)
-	/* Use r3 to pass state nap/sleep/winkle */
-	/* NAP is a state loss, we create a regs frame on the
-	 * stack, fill it up with the state we care about and
-	 * stick a pointer to it in PACAR1. We really only
-	 * need to save PC, some CR bits and the NV GPRs,
-	 * but for now an interrupt frame will do.
-	 */
-	mflr	r0
-	std	r0,16(r1)
-	stdu	r1,-INT_FRAME_SIZE(r1)
-	std	r0,_LINK(r1)
-	std	r0,_NIP(r1)
-
-	/* Hard disable interrupts */
-	mfmsr	r9
-	rldicl	r9,r9,48,1
-	rotldi	r9,r9,16
-	mtmsrd	r9,1			/* hard-disable interrupts */
-
-	/* Check if something happened while soft-disabled */
-	lbz	r0,PACAIRQHAPPENED(r13)
-	andi.	r0,r0,~PACA_IRQ_HARD_DIS@l
-	beq	1f
-	cmpwi	cr0,r4,0
-	beq	1f
-	addi	r1,r1,INT_FRAME_SIZE
-	ld	r0,16(r1)
-	li	r3,0			/* Return 0 (no nap) */
-	mtlr	r0
-	blr
-
-1:	/* We mark irqs hard disabled as this is the state we'll
-	 * be in when returning and we need to tell arch_local_irq_restore()
-	 * about it
-	 */
-	li	r0,PACA_IRQ_HARD_DIS
-	stb	r0,PACAIRQHAPPENED(r13)
-
-	/* We haven't lost state ... yet */
-	li	r0,0
-	stb	r0,PACA_NAPSTATELOST(r13)
-
-	/* Continue saving state */
-	SAVE_GPR(2, r1)
-	SAVE_NVGPRS(r1)
-	mfcr	r4
-	std	r4,_CCR(r1)
-	std	r9,_MSR(r1)
-	std	r1,PACAR1(r13)
-
-	/*
-	 * Go to real mode to do the nap, as required by the architecture.
-	 * Also, we need to be in real mode before setting hwthread_state,
-	 * because as soon as we do that, another thread can switch
-	 * the MMU context to the guest.
-	 */
-	LOAD_REG_IMMEDIATE(r5, MSR_IDLE)
-	li	r6, MSR_RI
-	andc	r6, r9, r6
-	LOAD_REG_ADDR(r7, power7_enter_nap_mode)
-	mtmsrd	r6, 1		/* clear RI before setting SRR0/1 */
-	mtspr	SPRN_SRR0, r7
-	mtspr	SPRN_SRR1, r5
-	rfid
-
 	.globl	power7_enter_nap_mode
 power7_enter_nap_mode:
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
@@ -258,35 +184,6 @@ _GLOBAL(power7_winkle)
 	b	power7_powersave_common
 	/* No return */
 
-/*
- * Called from reset vector. Check whether we have woken up with
- * hypervisor state loss. If yes, restore hypervisor state and return
- * back to reset vector.
- */
-_GLOBAL(power7_restore_hyp_resource)
-	/*
-	 * Check if last bit of HSPGR0 is set. This indicates whether we are
-	 * waking up from winkle.
-	 */
-	GET_PACA(r13)
-	clrldi	r5,r13,63
-	clrrdi	r13,r13,1
-	cmpwi	cr4,r5,1
-	mtspr	SPRN_HSPRG0,r13
-
-	lbz	r0,PACA_THREAD_IDLE_STATE(r13)
-	cmpwi   cr2,r0,PNV_THREAD_NAP
-	bgt     cr2,power7_wakeup_tb_loss	/* Either sleep or Winkle */
-
-	/*
-	 * We fall through here if PACA_THREAD_IDLE_STATE shows we are waking
-	 * up from nap. At this stage CR3 shouldn't contains 'gt' since that
-	 * indicates we are waking with hypervisor state loss from nap.
-	 */
-	bgt	cr3,.
-
-	blr
-
 _GLOBAL(power7_wakeup_tb_loss)
 	ld	r2,PACATOC(r13);
 	ld	r1,PACAR1(r13)
@@ -461,44 +358,3 @@ fastsleep_workaround_at_exit:
 	li	r0,OPAL_CONFIG_CPU_IDLE_STATE
 	bl	opal_call_realmode
 	b	timebase_resync
-
-/*
- * R3 here contains the value that will be returned to the caller
- * of power7_nap.
- */
-_GLOBAL(power7_wakeup_loss)
-	ld	r1,PACAR1(r13)
-BEGIN_FTR_SECTION
-	CHECK_HMI_INTERRUPT
-END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
-	REST_NVGPRS(r1)
-	REST_GPR(2, r1)
-	ld	r6,_CCR(r1)
-	ld	r4,_MSR(r1)
-	ld	r5,_NIP(r1)
-	addi	r1,r1,INT_FRAME_SIZE
-	mtcr	r6
-	mtspr	SPRN_SRR1,r4
-	mtspr	SPRN_SRR0,r5
-	rfid
-
-/*
- * R3 here contains the value that will be returned to the caller
- * of power7_nap.
- */
-_GLOBAL(power7_wakeup_noloss)
-	lbz	r0,PACA_NAPSTATELOST(r13)
-	cmpwi	r0,0
-	bne	power7_wakeup_loss
-BEGIN_FTR_SECTION
-	CHECK_HMI_INTERRUPT
-END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
-	ld	r1,PACAR1(r13)
-	ld	r6,_CCR(r1)
-	ld	r4,_MSR(r1)
-	ld	r5,_NIP(r1)
-	addi	r1,r1,INT_FRAME_SIZE
-	mtcr	r6
-	mtspr	SPRN_SRR1,r4
-	mtspr	SPRN_SRR0,r5
-	rfid
diff --git a/arch/powerpc/kernel/idle_power_common.S b/arch/powerpc/kernel/idle_power_common.S
new file mode 100644
index 0000000..05954ae
--- /dev/null
+++ b/arch/powerpc/kernel/idle_power_common.S
@@ -0,0 +1,160 @@
+#include <asm/cputable.h>
+#include <asm/thread_info.h>
+#include <asm/ppc_asm.h>
+#include <asm/asm-offsets.h>
+#include <asm/ppc-opcode.h>
+#include <asm/hw_irq.h>
+#include <asm/kvm_book3s_asm.h>
+#include <asm/opal.h>
+#include <asm/cpuidle.h>
+#include <asm/exception-64s.h>
+#include <asm/book3s/64/mmu-hash.h>
+
+#undef DEBUG
+
+	.text
+
+/*
+ * Pass requested state in r3:
+ *	r3 - PNV_THREAD_NAP/SLEEP/WINKLE
+ *
+ * To check IRQ_HAPPENED in r4
+ * 	0 - don't check
+ * 	1 - check
+ */
+_GLOBAL(power7_powersave_common)
+	/* Use r3 to pass state nap/sleep/winkle */
+	/* NAP is a state loss, we create a regs frame on the
+	 * stack, fill it up with the state we care about and
+	 * stick a pointer to it in PACAR1. We really only
+	 * need to save PC, some CR bits and the NV GPRs,
+	 * but for now an interrupt frame will do.
+	 */
+	mflr	r0
+	std	r0,16(r1)
+	stdu	r1,-INT_FRAME_SIZE(r1)
+	std	r0,_LINK(r1)
+	std	r0,_NIP(r1)
+
+	/* Hard disable interrupts */
+	mfmsr	r9
+	rldicl	r9,r9,48,1
+	rotldi	r9,r9,16
+	mtmsrd	r9,1			/* hard-disable interrupts */
+
+	/* Check if something happened while soft-disabled */
+	lbz	r0,PACAIRQHAPPENED(r13)
+	andi.	r0,r0,~PACA_IRQ_HARD_DIS@l
+	beq	1f
+	cmpwi	cr0,r4,0
+	beq	1f
+	addi	r1,r1,INT_FRAME_SIZE
+	ld	r0,16(r1)
+	li	r3,0			/* Return 0 (no nap) */
+	mtlr	r0
+	blr
+
+1:	/* We mark irqs hard disabled as this is the state we'll
+	 * be in when returning and we need to tell arch_local_irq_restore()
+	 * about it
+	 */
+	li	r0,PACA_IRQ_HARD_DIS
+	stb	r0,PACAIRQHAPPENED(r13)
+
+	/* We haven't lost state ... yet */
+	li	r0,0
+	stb	r0,PACA_NAPSTATELOST(r13)
+
+	/* Continue saving state */
+	SAVE_GPR(2, r1)
+	SAVE_NVGPRS(r1)
+	mfcr	r4
+	std	r4,_CCR(r1)
+	std	r9,_MSR(r1)
+	std	r1,PACAR1(r13)
+
+	/*
+	 * Go to real mode to do the nap, as required by the architecture.
+	 * Also, we need to be in real mode before setting hwthread_state,
+	 * because as soon as we do that, another thread can switch
+	 * the MMU context to the guest.
+	 */
+	LOAD_REG_IMMEDIATE(r5, MSR_IDLE)
+	li	r6, MSR_RI
+	andc	r6, r9, r6
+	LOAD_REG_ADDR(r7, power7_enter_nap_mode)
+	mtmsrd	r6, 1		/* clear RI before setting SRR0/1 */
+	mtspr	SPRN_SRR0, r7
+	mtspr	SPRN_SRR1, r5
+	rfid
+	/* No return */
+
+/*
+ * Called from reset vector. Check whether we have woken up with
+ * hypervisor state loss. If yes, restore hypervisor state and return
+ * back to reset vector.
+ */
+_GLOBAL(power7_restore_hyp_resource)
+	/*
+	 * Check if last bit of HSPGR0 is set. This indicates whether we are
+	 * waking up from winkle.
+	 */
+	GET_PACA(r13)
+	clrldi	r5,r13,63
+	clrrdi	r13,r13,1
+	cmpwi	cr4,r5,1
+	mtspr	SPRN_HSPRG0,r13
+
+	lbz	r0,PACA_THREAD_IDLE_STATE(r13)
+	cmpwi   cr2,r0,PNV_THREAD_NAP
+	bgt     cr2,power7_wakeup_tb_loss	/* Either sleep or Winkle */
+
+	/*
+	 * We fall through here if PACA_THREAD_IDLE_STATE shows we are waking
+	 * up from nap. At this stage CR3 shouldn't contains 'gt' since that
+	 * indicates we are waking with hypervisor state loss from nap.
+	 */
+	bgt	cr3,.
+
+	blr
+
+/*
+ * R3 here contains the value that will be returned to the caller
+ * of power7_nap.
+ */
+_GLOBAL(power7_wakeup_loss)
+	ld	r1,PACAR1(r13)
+BEGIN_FTR_SECTION
+	CHECK_HMI_INTERRUPT
+END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
+	REST_NVGPRS(r1)
+	REST_GPR(2, r1)
+	ld	r6,_CCR(r1)
+	ld	r4,_MSR(r1)
+	ld	r5,_NIP(r1)
+	addi	r1,r1,INT_FRAME_SIZE
+	mtcr	r6
+	mtspr	SPRN_SRR1,r4
+	mtspr	SPRN_SRR0,r5
+	rfid
+
+/*
+ * R3 here contains the value that will be returned to the caller
+ * of power7_nap.
+ */
+_GLOBAL(power7_wakeup_noloss)
+	lbz	r0,PACA_NAPSTATELOST(r13)
+	cmpwi	r0,0
+	bne	power7_wakeup_loss
+BEGIN_FTR_SECTION
+	CHECK_HMI_INTERRUPT
+END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
+	ld	r1,PACAR1(r13)
+	ld	r6,_CCR(r1)
+	ld	r4,_MSR(r1)
+	ld	r5,_NIP(r1)
+	addi	r1,r1,INT_FRAME_SIZE
+	mtcr	r6
+	mtspr	SPRN_SRR1,r4
+	mtspr	SPRN_SRR0,r5
+	rfid
-- 
2.4.11
