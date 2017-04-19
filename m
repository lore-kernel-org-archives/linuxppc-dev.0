Return-Path: <npiggin@gmail.com>
Received: from mail-it0-x244.google.com (mail-it0-x244.google.com
 [IPv6:2607:f8b0:4001:c0b::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7MhB3V09zDr2w
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 23:06:18 +1000 (AEST)
Received: by mail-it0-x244.google.com with SMTP id a140so2676571ita.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 06:06:18 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 5/9] powerpc/64s: fix POWER9 machine check handler from stop
 state
Date: Wed, 19 Apr 2017 23:05:47 +1000
Message-Id: <20170419130551.32378-6-npiggin@gmail.com>
In-Reply-To: <20170419130551.32378-1-npiggin@gmail.com>
References: <20170419130551.32378-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The ISA specifies power save wakeup due to a machine check exception can
cause a machine check interrupt (rather than the usual system reset
interrupt).

The machine check handler copes with this by doing low level machine
check recovery without restoring full state from idle, then queues up a
machine check event for logging, then directly executes the same idle
instruction it woke from. This minimises the work done before recovery
is performed.

The problem is that it requires machine specific instructions and
knowledge of the book3s idle code. Currently it only has code to handle
POWER8 idle, so POWER9 crashes when trying to execute the P8 idle
instructions which don't exist in ISAv3.0B.

cpu 0x0: Vector: e40 (Emulation Assist) at [c0000000008f3810]
    pc: c000000000008380: machine_check_handle_early+0x130/0x2f0
    lr: c00000000053a098: stop_loop+0x68/0xd0
    sp: c0000000008f3a90
   msr: 9000000000081001
  current = 0xc0000000008a1080
  paca    = 0xc00000000ffd0000   softe: 0        irq_happened: 0x01
    pid   = 0, comm = swapper/0

Instead of going to sleep after recovery, do the usual idle wakeup and
state restoration by calling into the normal idle wakeup path. This
reuses the normal idle wakeup paths.

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Reviewed-by: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/reg.h       |  1 +
 arch/powerpc/kernel/exceptions-64s.S | 79 ++++++++++++++++++++----------------
 arch/powerpc/kernel/idle_book3s.S    | 25 ++++++++++++
 3 files changed, 70 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 4b594ed6180a..d4f653c9259a 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -659,6 +659,7 @@
 #define   SRR1_ISI_PROT		0x08000000 /* ISI: Other protection fault */
 #define   SRR1_WAKEMASK		0x00380000 /* reason for wakeup */
 #define   SRR1_WAKEMASK_P8	0x003c0000 /* reason for wakeup on POWER8 and 9 */
+#define   SRR1_WAKEMCE_RESVD	0x003c0000 /* Unused/reserved value used by MCE wakeup to indicate cause to idle wakeup handler */
 #define   SRR1_WAKESYSERR	0x00300000 /* System error */
 #define   SRR1_WAKEEE		0x00200000 /* External interrupt */
 #define   SRR1_WAKEHVI		0x00240000 /* Hypervisor Virtualization Interrupt (P9) */
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index e390fcd04bcb..28f8d7bed6b1 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -178,6 +178,12 @@ BEGIN_FTR_SECTION
 	 * NOTE: We are here with MSR_ME=0 (off), which means we risk a
 	 * checkstop if we get another machine check exception before we do
 	 * rfid with MSR_ME=1.
+	 *
+	 * This interrupt can wake directly from idle. If that is the case,
+	 * the machine check is handled then the idle wakeup code is called
+	 * to restore state. In that case, the POWER9 DD1 idle PACA workaround
+	 * is not applied in the early machine check code, which will cause
+	 * bugs.
 	 */
 	mr	r11,r1			/* Save r1 */
 	lhz	r10,PACA_IN_MCE(r13)
@@ -306,6 +312,37 @@ EXC_COMMON_BEGIN(machine_check_common)
 	/* restore original r1. */			\
 	ld	r1,GPR1(r1)
 
+#ifdef CONFIG_PPC_P7_NAP
+/*
+ * This is an idle wakeup. Low level machine check has already been
+ * done. Queue the event then call the idle code to do the wake up.
+ */
+EXC_COMMON_BEGIN(machine_check_idle_common)
+	bl	machine_check_queue_event
+
+	/*
+	 * We have not used any non-volatile GPRs here, and as a rule
+	 * most exception code including machine check does not.
+	 * Therefore PACA_NAPSTATELOST does not need to be set. Idle
+	 * wakeup will restore volatile registers.
+	 *
+	 * Load the original SRR1 into r3 for pnv_powersave_wakeup_mce.
+	 *
+	 * Then decrement MCE nesting after finishing with the stack.
+	 */
+	ld	r3,_MSR(r1)
+
+	lhz	r11,PACA_IN_MCE(r13)
+	subi	r11,r11,1
+	sth	r11,PACA_IN_MCE(r13)
+
+	/* Turn off the RI bit because SRR1 is used by idle wakeup code. */
+	/* Recoverability could be improved by reducing the use of SRR1. */
+	li	r11,0
+	mtmsrd	r11,1
+
+	b	pnv_powersave_wakeup_mce
+#endif
 	/*
 	 * Handle machine check early in real mode. We come here with
 	 * ME=1, MMU (IR=0 and DR=0) off and using MC emergency stack.
@@ -318,6 +355,7 @@ EXC_COMMON_BEGIN(machine_check_handle_early)
 	bl	machine_check_early
 	std	r3,RESULT(r1)	/* Save result */
 	ld	r12,_MSR(r1)
+
 #ifdef	CONFIG_PPC_P7_NAP
 	/*
 	 * Check if thread was in power saving mode. We come here when any
@@ -328,43 +366,14 @@ EXC_COMMON_BEGIN(machine_check_handle_early)
 	 *
 	 * Go back to nap/sleep/winkle mode again if (b) is true.
 	 */
-	rlwinm.	r11,r12,47-31,30,31	/* Was it in power saving mode? */
-	beq	4f			/* No, it wasn't */
-	/* Thread was in power saving mode. Go back to nap again. */
-	cmpwi	r11,2
-	blt	3f
-	/* Supervisor/Hypervisor state loss */
-	li	r0,1
-	stb	r0,PACA_NAPSTATELOST(r13)
-3:	bl	machine_check_queue_event
-	MACHINE_CHECK_HANDLER_WINDUP
-	GET_PACA(r13)
-	ld	r1,PACAR1(r13)
-	/*
-	 * Check what idle state this CPU was in and go back to same mode
-	 * again.
-	 */
-	lbz	r3,PACA_THREAD_IDLE_STATE(r13)
-	cmpwi	r3,PNV_THREAD_NAP
-	bgt	10f
-	IDLE_STATE_ENTER_SEQ_NORET(PPC_NAP)
-	/* No return */
-10:
-	cmpwi	r3,PNV_THREAD_SLEEP
-	bgt	2f
-	IDLE_STATE_ENTER_SEQ_NORET(PPC_SLEEP)
-	/* No return */
-
-2:
-	/*
-	 * Go back to winkle. Please note that this thread was woken up in
-	 * machine check from winkle and have not restored the per-subcore
-	 * state.
-	 */
-	IDLE_STATE_ENTER_SEQ_NORET(PPC_WINKLE)
-	/* No return */
+	BEGIN_FTR_SECTION
+	rlwinm.	r11,r12,47-31,30,31
+	beq-	4f
+	BRANCH_TO_COMMON(r10, machine_check_idle_common)
 4:
+	END_FTR_SECTION_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
 #endif
+
 	/*
 	 * Check if we are coming from hypervisor userspace. If yes then we
 	 * continue in host kernel in V mode to deliver the MC event.
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 695cff40b0fe..cc016757d743 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -416,6 +416,31 @@ power9_dd1_recover_paca:
 	blr
 
 /*
+ * Called from machine check handler for powersave wakeups.
+ * Low level machine check processing has already been done. Now just
+ * go through the wake up path to get everything in order.
+ *
+ * r3 - The original SRR1 value.
+ * Original SRR[01] have been clobbered.
+ * MSR_RI is clear.
+ */
+.global pnv_powersave_wakeup_mce
+pnv_powersave_wakeup_mce:
+	/* Set cr3 for pnv_powersave_wakeup */
+	rlwinm	r11,r3,47-31,30,31
+	cmpwi	cr3,r11,2
+
+	/*
+	 * Now put the original SRR1 with SRR1_WAKEMCE_RESVD as the wake
+	 * reason into SRR1, which allows reuse of the system reset wakeup
+	 * code without being mistaken for another type of wakeup.
+	 */
+	oris	r3,r3,SRR1_WAKEMCE_RESVD@h
+	mtspr	SPRN_SRR1,r3
+
+	b	pnv_powersave_wakeup
+
+/*
  * Called from reset vector for powersave wakeups.
  * cr3 - set to gt if waking up with partial/complete hypervisor state loss
  */
-- 
2.11.0
