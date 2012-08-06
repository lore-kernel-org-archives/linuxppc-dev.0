Return-Path: <mcaraman@mcaraman-VirtualBox.ea.freescale.net>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8D9AD2C0123
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Aug 2012 23:27:31 +1000 (EST)
Received: from mail245-ch1 (localhost [127.0.0.1])	by
 mail245-ch1-R.bigfish.com (Postfix) with ESMTP id C5FF3F8015C	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Aug 2012 13:27:26 +0000 (UTC)
Received: from CH1EHSMHS008.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.242])	by mail245-ch1.bigfish.com (Postfix) with ESMTP id
 96932D4004E	for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Aug 2012 13:27:24
 +0000 (UTC)
Received: from mcaraman-VirtualBox.ea.freescale.net ([10.213.130.145])	by
 az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id q76DRJT8014471	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Aug 2012 06:27:20 -0700
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 3/6] powerpc/booke64: add DO_KVM kernel hooks
Date: Mon, 6 Aug 2012 16:27:05 +0300
Message-ID: <1344259628-31161-4-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1344259628-31161-1-git-send-email-mihai.caraman@freescale.com>
References: <1344259628-31161-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hook DO_KVM macro into 64-bit booke for KVM integration. Extend interrupt
handlers' parameter list with interrupt vector numbers to accomodate the macro.
Only the bolted version of tlb miss handers is addressed now.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/kernel/exceptions-64e.S |   93 +++++++++++++++++++++------------
 arch/powerpc/mm/tlb_low_64e.S        |   14 ++++-
 2 files changed, 70 insertions(+), 37 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 0f58a95..3b1ad1b 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -25,6 +25,8 @@
 #include <asm/ppc-opcode.h>
 #include <asm/mmu.h>
 #include <asm/hw_irq.h>
+#include <asm/kvm_asm.h>
+#include <asm/kvm_booke_hv_asm.h>
 
 /* XXX This will ultimately add space for a special exception save
  *     structure used to save things like SRR0/SRR1, SPRGs, MAS, etc...
@@ -35,12 +37,14 @@
 #define	SPECIAL_EXC_FRAME_SIZE	INT_FRAME_SIZE
 
 /* Exception prolog code for all exceptions */
-#define EXCEPTION_PROLOG(n, type, addition)				    \
+#define EXCEPTION_PROLOG(n, intnum, type, addition)	    		    \
 	mtspr	SPRN_SPRG_##type##_SCRATCH,r13;	/* get spare registers */   \
 	mfspr	r13,SPRN_SPRG_PACA;	/* get PACA */			    \
 	std	r10,PACA_EX##type+EX_R10(r13);				    \
 	std	r11,PACA_EX##type+EX_R11(r13);				    \
 	mfcr	r10;			/* save CR */			    \
+	mfspr	r11,SPRN_##type##_SRR1;/* what are we coming from */	    \
+	DO_KVM	intnum,SPRN_##type##_SRR1;    /* KVM hook */		    \
 	addition;			/* additional code for that exc. */ \
 	std	r1,PACA_EX##type+EX_R1(r13); /* save old r1 in the PACA */  \
 	stw	r10,PACA_EX##type+EX_CR(r13); /* save old CR in the PACA */ \
@@ -81,20 +85,20 @@
 #define SPRN_MC_SRR0	SPRN_MCSRR0
 #define SPRN_MC_SRR1	SPRN_MCSRR1
 
-#define NORMAL_EXCEPTION_PROLOG(n, addition)				    \
-	EXCEPTION_PROLOG(n, GEN, addition##_GEN(n))
+#define NORMAL_EXCEPTION_PROLOG(n, intnum, addition)			    \
+	EXCEPTION_PROLOG(n, intnum, GEN, addition##_GEN(n))
 
-#define CRIT_EXCEPTION_PROLOG(n, addition)				    \
-	EXCEPTION_PROLOG(n, CRIT, addition##_CRIT(n))
+#define CRIT_EXCEPTION_PROLOG(n, intnum, addition)			    \
+	EXCEPTION_PROLOG(n, intnum, CRIT, addition##_CRIT(n))
 
-#define DBG_EXCEPTION_PROLOG(n, addition)				    \
-	EXCEPTION_PROLOG(n, DBG, addition##_DBG(n))
+#define DBG_EXCEPTION_PROLOG(n, intnum, addition)			    \
+	EXCEPTION_PROLOG(n, intnum, DBG, addition##_DBG(n))
 
-#define MC_EXCEPTION_PROLOG(n, addition)				    \
-	EXCEPTION_PROLOG(n, MC, addition##_MC(n))
+#define MC_EXCEPTION_PROLOG(n, intnum, addition)			    \
+	EXCEPTION_PROLOG(n, intnum, MC, addition##_MC(n))
 
-#define GDBELL_EXCEPTION_PROLOG(n, addition)				    \
-	EXCEPTION_PROLOG(n, GDBELL, addition##_GDBELL(n))
+#define GDBELL_EXCEPTION_PROLOG(n, intnum, addition)			    \
+	EXCEPTION_PROLOG(n, intnum, GDBELL, addition##_GDBELL(n))
 
 /* Variants of the "addition" argument for the prolog
  */
@@ -240,9 +244,9 @@ exc_##n##_bad_stack:							    \
 1:
 
 
-#define MASKABLE_EXCEPTION(trapnum, label, hdlr, ack)			\
+#define MASKABLE_EXCEPTION(trapnum, intnum, label, hdlr, ack)		\
 	START_EXCEPTION(label);						\
-	NORMAL_EXCEPTION_PROLOG(trapnum, PROLOG_ADDITION_MASKABLE)	\
+	NORMAL_EXCEPTION_PROLOG(trapnum, intnum, PROLOG_ADDITION_MASKABLE)\
 	EXCEPTION_COMMON(trapnum, PACA_EXGEN, INTS_DISABLE)		\
 	ack(r8);							\
 	CHECK_NAPPING();						\
@@ -293,7 +297,8 @@ interrupt_end_book3e:
 
 /* Critical Input Interrupt */
 	START_EXCEPTION(critical_input);
-	CRIT_EXCEPTION_PROLOG(0x100, PROLOG_ADDITION_NONE)
+	CRIT_EXCEPTION_PROLOG(0x100, BOOKE_INTERRUPT_CRITICAL,
+			      PROLOG_ADDITION_NONE)
 //	EXCEPTION_COMMON(0x100, PACA_EXCRIT, INTS_DISABLE)
 //	bl	special_reg_save_crit
 //	CHECK_NAPPING();
@@ -304,7 +309,8 @@ interrupt_end_book3e:
 
 /* Machine Check Interrupt */
 	START_EXCEPTION(machine_check);
-	MC_EXCEPTION_PROLOG(0x200, PROLOG_ADDITION_NONE)
+	MC_EXCEPTION_PROLOG(0x200, BOOKE_INTERRUPT_MACHINE_CHECK,
+			    PROLOG_ADDITION_NONE)
 //	EXCEPTION_COMMON(0x200, PACA_EXMC, INTS_DISABLE)
 //	bl	special_reg_save_mc
 //	addi	r3,r1,STACK_FRAME_OVERHEAD
@@ -315,7 +321,8 @@ interrupt_end_book3e:
 
 /* Data Storage Interrupt */
 	START_EXCEPTION(data_storage)
-	NORMAL_EXCEPTION_PROLOG(0x300, PROLOG_ADDITION_2REGS)
+	NORMAL_EXCEPTION_PROLOG(0x300, BOOKE_INTERRUPT_DATA_STORAGE,
+				PROLOG_ADDITION_2REGS)
 	mfspr	r14,SPRN_DEAR
 	mfspr	r15,SPRN_ESR
 	EXCEPTION_COMMON(0x300, PACA_EXGEN, INTS_DISABLE)
@@ -323,18 +330,21 @@ interrupt_end_book3e:
 
 /* Instruction Storage Interrupt */
 	START_EXCEPTION(instruction_storage);
-	NORMAL_EXCEPTION_PROLOG(0x400, PROLOG_ADDITION_2REGS)
+	NORMAL_EXCEPTION_PROLOG(0x400, BOOKE_INTERRUPT_INST_STORAGE,
+				PROLOG_ADDITION_2REGS)
 	li	r15,0
 	mr	r14,r10
 	EXCEPTION_COMMON(0x400, PACA_EXGEN, INTS_DISABLE)
 	b	storage_fault_common
 
 /* External Input Interrupt */
-	MASKABLE_EXCEPTION(0x500, external_input, .do_IRQ, ACK_NONE)
+	MASKABLE_EXCEPTION(0x500, BOOKE_INTERRUPT_EXTERNAL,
+			   external_input, .do_IRQ, ACK_NONE)
 
 /* Alignment */
 	START_EXCEPTION(alignment);
-	NORMAL_EXCEPTION_PROLOG(0x600, PROLOG_ADDITION_2REGS)
+	NORMAL_EXCEPTION_PROLOG(0x600, BOOKE_INTERRUPT_ALIGNMENT,
+				PROLOG_ADDITION_2REGS)
 	mfspr	r14,SPRN_DEAR
 	mfspr	r15,SPRN_ESR
 	EXCEPTION_COMMON(0x600, PACA_EXGEN, INTS_KEEP)
@@ -342,7 +352,8 @@ interrupt_end_book3e:
 
 /* Program Interrupt */
 	START_EXCEPTION(program);
-	NORMAL_EXCEPTION_PROLOG(0x700, PROLOG_ADDITION_1REG)
+	NORMAL_EXCEPTION_PROLOG(0x700, BOOKE_INTERRUPT_PROGRAM,
+				PROLOG_ADDITION_1REG)
 	mfspr	r14,SPRN_ESR
 	EXCEPTION_COMMON(0x700, PACA_EXGEN, INTS_DISABLE)
 	std	r14,_DSISR(r1)
@@ -354,7 +365,8 @@ interrupt_end_book3e:
 
 /* Floating Point Unavailable Interrupt */
 	START_EXCEPTION(fp_unavailable);
-	NORMAL_EXCEPTION_PROLOG(0x800, PROLOG_ADDITION_NONE)
+	NORMAL_EXCEPTION_PROLOG(0x800, BOOKE_INTERRUPT_FP_UNAVAIL,
+				PROLOG_ADDITION_NONE)
 	/* we can probably do a shorter exception entry for that one... */
 	EXCEPTION_COMMON(0x800, PACA_EXGEN, INTS_KEEP)
 	ld	r12,_MSR(r1)
@@ -369,14 +381,17 @@ interrupt_end_book3e:
 	b	.ret_from_except
 
 /* Decrementer Interrupt */
-	MASKABLE_EXCEPTION(0x900, decrementer, .timer_interrupt, ACK_DEC)
+	MASKABLE_EXCEPTION(0x900, BOOKE_INTERRUPT_DECREMENTER,
+			   decrementer, .timer_interrupt, ACK_DEC)
 
 /* Fixed Interval Timer Interrupt */
-	MASKABLE_EXCEPTION(0x980, fixed_interval, .unknown_exception, ACK_FIT)
+	MASKABLE_EXCEPTION(0x980, BOOKE_INTERRUPT_FIT,
+			   fixed_interval, .unknown_exception, ACK_FIT)
 
 /* Watchdog Timer Interrupt */
 	START_EXCEPTION(watchdog);
-	CRIT_EXCEPTION_PROLOG(0x9f0, PROLOG_ADDITION_NONE)
+	CRIT_EXCEPTION_PROLOG(0x9f0, BOOKE_INTERRUPT_WATCHDOG,
+			      PROLOG_ADDITION_NONE)
 //	EXCEPTION_COMMON(0x9f0, PACA_EXCRIT, INTS_DISABLE)
 //	bl	special_reg_save_crit
 //	CHECK_NAPPING();
@@ -395,7 +410,8 @@ interrupt_end_book3e:
 
 /* Auxiliary Processor Unavailable Interrupt */
 	START_EXCEPTION(ap_unavailable);
-	NORMAL_EXCEPTION_PROLOG(0xf20, PROLOG_ADDITION_NONE)
+	NORMAL_EXCEPTION_PROLOG(0xf20, BOOKE_INTERRUPT_AP_UNAVAIL,
+				PROLOG_ADDITION_NONE)
 	EXCEPTION_COMMON(0xf20, PACA_EXGEN, INTS_DISABLE)
 	bl	.save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
@@ -404,7 +420,8 @@ interrupt_end_book3e:
 
 /* Debug exception as a critical interrupt*/
 	START_EXCEPTION(debug_crit);
-	CRIT_EXCEPTION_PROLOG(0xd00, PROLOG_ADDITION_2REGS)
+	CRIT_EXCEPTION_PROLOG(0xd00, BOOKE_INTERRUPT_DEBUG,
+			      PROLOG_ADDITION_2REGS)
 
 	/*
 	 * If there is a single step or branch-taken exception in an
@@ -469,7 +486,8 @@ kernel_dbg_exc:
 
 /* Debug exception as a debug interrupt*/
 	START_EXCEPTION(debug_debug);
-	DBG_EXCEPTION_PROLOG(0xd08, PROLOG_ADDITION_2REGS)
+	DBG_EXCEPTION_PROLOG(0xd00, BOOKE_INTERRUPT_DEBUG,
+						 PROLOG_ADDITION_2REGS)
 
 	/*
 	 * If there is a single step or branch-taken exception in an
@@ -530,18 +548,21 @@ kernel_dbg_exc:
 	b	.ret_from_except
 
 	START_EXCEPTION(perfmon);
-	NORMAL_EXCEPTION_PROLOG(0x260, PROLOG_ADDITION_NONE)
+	NORMAL_EXCEPTION_PROLOG(0x260, BOOKE_INTERRUPT_PERFORMANCE_MONITOR,
+				PROLOG_ADDITION_NONE)
 	EXCEPTION_COMMON(0x260, PACA_EXGEN, INTS_DISABLE)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.performance_monitor_exception
 	b	.ret_from_except_lite
 
 /* Doorbell interrupt */
-	MASKABLE_EXCEPTION(0x280, doorbell, .doorbell_exception, ACK_NONE)
+	MASKABLE_EXCEPTION(0x280, BOOKE_INTERRUPT_DOORBELL,
+			   doorbell, .doorbell_exception, ACK_NONE)
 
 /* Doorbell critical Interrupt */
 	START_EXCEPTION(doorbell_crit);
-	CRIT_EXCEPTION_PROLOG(0x2a0, PROLOG_ADDITION_NONE)
+	CRIT_EXCEPTION_PROLOG(0x2a0, BOOKE_INTERRUPT_DOORBELL_CRITICAL,
+			      PROLOG_ADDITION_NONE)
 //	EXCEPTION_COMMON(0x2a0, PACA_EXCRIT, INTS_DISABLE)
 //	bl	special_reg_save_crit
 //	CHECK_NAPPING();
@@ -555,7 +576,8 @@ kernel_dbg_exc:
  *	This general exception use GSRRx save/restore registers
  */
 	START_EXCEPTION(guest_doorbell);
-	GDBELL_EXCEPTION_PROLOG(0x2c0, PROLOG_ADDITION_NONE)
+	GDBELL_EXCEPTION_PROLOG(0x2c0, BOOKE_INTERRUPT_GUEST_DBELL,
+			        PROLOG_ADDITION_NONE)
 	EXCEPTION_COMMON(0x2c0, PACA_EXGEN, INTS_KEEP)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.save_nvgprs
@@ -565,7 +587,8 @@ kernel_dbg_exc:
 
 /* Guest Doorbell critical Interrupt */
 	START_EXCEPTION(guest_doorbell_crit);
-	CRIT_EXCEPTION_PROLOG(0x2e0, PROLOG_ADDITION_NONE)
+	CRIT_EXCEPTION_PROLOG(0x2e0, BOOKE_INTERRUPT_GUEST_DBELL_CRIT,
+			      PROLOG_ADDITION_NONE)
 //	EXCEPTION_COMMON(0x2e0, PACA_EXCRIT, INTS_DISABLE)
 //	bl	special_reg_save_crit
 //	CHECK_NAPPING();
@@ -576,7 +599,8 @@ kernel_dbg_exc:
 
 /* Hypervisor call */
 	START_EXCEPTION(hypercall);
-	NORMAL_EXCEPTION_PROLOG(0x310, PROLOG_ADDITION_NONE)
+	NORMAL_EXCEPTION_PROLOG(0x310, BOOKE_INTERRUPT_HV_SYSCALL,
+			        PROLOG_ADDITION_NONE)
 	EXCEPTION_COMMON(0x310, PACA_EXGEN, INTS_KEEP)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.save_nvgprs
@@ -586,7 +610,8 @@ kernel_dbg_exc:
 
 /* Embedded Hypervisor priviledged  */
 	START_EXCEPTION(ehpriv);
-	NORMAL_EXCEPTION_PROLOG(0x320, PROLOG_ADDITION_NONE)
+	NORMAL_EXCEPTION_PROLOG(0x320, BOOKE_INTERRUPT_HV_PRIV,
+			        PROLOG_ADDITION_NONE)
 	EXCEPTION_COMMON(0x320, PACA_EXGEN, INTS_KEEP)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.save_nvgprs
diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64e.S
index f09d48e..d884fa4 100644
--- a/arch/powerpc/mm/tlb_low_64e.S
+++ b/arch/powerpc/mm/tlb_low_64e.S
@@ -20,6 +20,8 @@
 #include <asm/pgtable.h>
 #include <asm/exception-64e.h>
 #include <asm/ppc-opcode.h>
+#include <asm/kvm_asm.h>
+#include <asm/kvm_booke_hv_asm.h>
 
 #ifdef CONFIG_PPC_64K_PAGES
 #define VPTE_PMD_SHIFT	(PTE_INDEX_SIZE+1)
@@ -37,12 +39,18 @@
  *                                                                    *
  **********************************************************************/
 
-.macro tlb_prolog_bolted addr
+.macro tlb_prolog_bolted intnum addr
 	mtspr	SPRN_SPRG_TLB_SCRATCH,r13
 	mfspr	r13,SPRN_SPRG_PACA
 	std	r10,PACA_EXTLB+EX_TLB_R10(r13)
 	mfcr	r10
 	std	r11,PACA_EXTLB+EX_TLB_R11(r13)
+#ifdef CONFIG_KVM_BOOKE_HV
+BEGIN_FTR_SECTION
+	mfspr	r11, SPRN_SRR1
+END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
+#endif
+	DO_KVM	\intnum, SPRN_SRR1
 	std	r16,PACA_EXTLB+EX_TLB_R16(r13)
 	mfspr	r16,\addr		/* get faulting address */
 	std	r14,PACA_EXTLB+EX_TLB_R14(r13)
@@ -66,7 +74,7 @@
 
 /* Data TLB miss */
 	START_EXCEPTION(data_tlb_miss_bolted)
-	tlb_prolog_bolted SPRN_DEAR
+	tlb_prolog_bolted BOOKE_INTERRUPT_DTLB_MISS SPRN_DEAR
 
 	/* We need _PAGE_PRESENT and  _PAGE_ACCESSED set */
 
@@ -214,7 +222,7 @@ itlb_miss_fault_bolted:
 
 /* Instruction TLB miss */
 	START_EXCEPTION(instruction_tlb_miss_bolted)
-	tlb_prolog_bolted SPRN_SRR0
+	tlb_prolog_bolted BOOKE_INTERRUPT_ITLB_MISS SPRN_SRR0
 
 	rldicl.	r10,r16,64-PGTABLE_EADDR_SIZE,PGTABLE_EADDR_SIZE+4
 	srdi	r15,r16,60		/* get region */
-- 
1.7.4.1
