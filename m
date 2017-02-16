Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPQ1D5XQqzDqCr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 05:39:28 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id y6so1543138pgy.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 10:39:28 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 5/5] powerpc/64s: fix POWER9 machine check handler from stop
 state
Date: Fri, 17 Feb 2017 04:39:01 +1000
Message-Id: <20170216183901.28611-6-npiggin@gmail.com>
In-Reply-To: <20170216183901.28611-1-npiggin@gmail.com>
References: <20170216183901.28611-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The ISA specifies power save wakeup can cause a machine check interrupt.
The machine check handler currently has code to handle that for POWER8,
but POWER9 crashes when trying to execute the P8 style sleep
instructions.

So queue up the machine check, then call into the idle code to wake up
as the system reset interrupt does, rather than attempting to sleep
again without going through the main idle path.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 71 ++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 5f775783f744..0388843c8d12 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -329,6 +329,35 @@ EXC_COMMON_BEGIN(machine_check_common)
 	/* restore original r1. */			\
 	ld	r1,GPR1(r1)
 
+#ifdef CONFIG_PPC_P7_NAP
+EXC_COMMON_BEGIN(machine_check_idle_common)
+	bl	machine_check_queue_event
+	/*
+	 * Queue the machine check, then reload SRR1 and use it to set
+	 * CR3 according to pnv_powersave_wakeup convention.
+	 */
+	ld	r12,_MSR(r1)
+	rlwinm	r11,r12,47-31,30,31
+	cmpwi	cr3,r11,2
+
+	/*
+	 * Now have to make SRR1 wake up reason look like a system reset
+	 * interrupt. Put 0xf in there, which is reserved (and does not
+	 * match HMI).
+	 */
+	li	r11,0xf
+	insrdi	r12,r11,4,45
+	mtspr	r12,SPRN_SRR1
+	std	r12,_MSR(r1)
+
+	/*
+	 * Decrement MCE nesting after finishing with the stack.
+	 */
+	lhz	r11,PACA_IN_MCE(r13)
+	subi	r11,r11,1
+	sth	r11,PACA_IN_MCE(r13)
+	b	pnv_powersave_wakeup
+#endif
 	/*
 	 * Handle machine check early in real mode. We come here with
 	 * ME=1, MMU (IR=0 and DR=0) off and using MC emergency stack.
@@ -341,6 +370,7 @@ EXC_COMMON_BEGIN(machine_check_handle_early)
 	bl	machine_check_early
 	std	r3,RESULT(r1)	/* Save result */
 	ld	r12,_MSR(r1)
+
 #ifdef	CONFIG_PPC_P7_NAP
 	/*
 	 * Check if thread was in power saving mode. We come here when any
@@ -351,43 +381,14 @@ EXC_COMMON_BEGIN(machine_check_handle_early)
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
-	IDLE_STATE_ENTER_SEQ(PPC_NAP)
-	/* No return */
-10:
-	cmpwi	r3,PNV_THREAD_SLEEP
-	bgt	2f
-	IDLE_STATE_ENTER_SEQ(PPC_SLEEP)
-	/* No return */
-
-2:
-	/*
-	 * Go back to winkle. Please note that this thread was woken up in
-	 * machine check from winkle and have not restored the per-subcore
-	 * state.
-	 */
-	IDLE_STATE_ENTER_SEQ(PPC_WINKLE)
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
-- 
2.11.0
