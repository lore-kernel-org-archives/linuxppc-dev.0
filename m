Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vmzS85xZxzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 01:52:08 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id o126so17708181pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 07:52:08 -0700 (PDT)
Date: Tue, 21 Mar 2017 00:51:54 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, "Gautham R . Shenoy"
 <ego@linux.vnet.ibm.com>, Mahesh Jagannath Salgaonkar
 <mahesh@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/7] powerpc/64s: fix POWER9 machine check handler from
 stop state
Message-ID: <20170321005154.1fa18ef1@roar.ozlabs.ibm.com>
In-Reply-To: <20170320060152.1016-5-npiggin@gmail.com>
References: <20170320060152.1016-1-npiggin@gmail.com>
 <20170320060152.1016-5-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 20 Mar 2017 16:01:49 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> The ISA specifies power save wakeup can cause a machine check interrupt.
> The machine check handler currently has code to handle that for POWER8,
> but POWER9 crashes when trying to execute the P8 style sleep
> instructions.
> 
> So queue up the machine check, then call into the idle code to wake up
> as the system reset interrupt does, rather than attempting to sleep
> again without going through the main idle path.
> 
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Reviewed-by: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Hmm, I sent the wrong patch here. Not having a good day. Sorry to waste
your time :( (It works fine, but it was setting NAPSTATELOST, which I
since decided we don't need, and had an incomplete comment change.)

Here's a patch with the comment explaining why nap state is not lost,
and a bit more code moved into idle_book3s.S -- now exception-64s.S does
not know anything about idle wakeups except SRR1[46:47].

BTW, I've tested this in mambo including nested non-idle MCEs inside the
idle-wakeup MCE at various points. I will tidy up and submit the mambo
script I've been using for MCE injection to skiboot tomorrow.

Thanks,
Nick


The ISA specifies power save wakeup can cause a machine check interrupt.
The machine check handler currently has code to handle that for POWER8,
but POWER9 crashes when trying to execute the P8 style sleep
instructions.

So queue up the machine check, then call into the idle code to wake up
as the system reset interrupt does, rather than attempting to sleep
again without going through the main idle path.

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Reviewed-by: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/reg.h       |  1 +
 arch/powerpc/kernel/exceptions-64s.S | 73 +++++++++++++++++++-----------------
 arch/powerpc/kernel/idle_book3s.S    | 25 ++++++++++++
 3 files changed, 64 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index fc879fd6bdae..8bbdfacce970 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -656,6 +656,7 @@
 #define   SRR1_ISI_PROT		0x08000000 /* ISI: Other protection fault */
 #define   SRR1_WAKEMASK		0x00380000 /* reason for wakeup */
 #define   SRR1_WAKEMASK_P8	0x003c0000 /* reason for wakeup on POWER8 and 9 */
+#define   SRR1_WAKEMCE_RESVD	0x003c0000 /* Unused/reserved value used by MCE wakeup to indicate cause to idle wakeup handler */
 #define   SRR1_WAKESYSERR	0x00300000 /* System error */
 #define   SRR1_WAKEEE		0x00200000 /* External interrupt */
 #define   SRR1_WAKEHVI		0x00240000 /* Hypervisor Virtualization Interrupt (P9) */
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index bef9b04a3b2d..e9d4be08813a 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -306,6 +306,37 @@ EXC_COMMON_BEGIN(machine_check_common)
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
@@ -318,6 +349,7 @@ EXC_COMMON_BEGIN(machine_check_handle_early)
 	bl	machine_check_early
 	std	r3,RESULT(r1)	/* Save result */
 	ld	r12,_MSR(r1)
+
 #ifdef	CONFIG_PPC_P7_NAP
 	/*
 	 * Check if thread was in power saving mode. We come here when any
@@ -328,43 +360,14 @@ EXC_COMMON_BEGIN(machine_check_handle_early)
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
index 819e64104469..02ec876423cd 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -378,6 +378,31 @@ _GLOBAL(power9_idle_stop)
 	/* No return */
 
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
