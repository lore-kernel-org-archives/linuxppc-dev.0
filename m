Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BE28F1A040A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 15:56:40 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4A590140322
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2016 15:56:40 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 25 Feb 2016 14:56:39 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 821DC3578052
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2016 15:56:38 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1P4uUlM55181418
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2016 15:56:38 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1P4u5Bi020047
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2016 15:56:05 +1100
Subject: [PATCH 3/3] powernv: Fix MCE handler to avoid trashing CR0/CR1
 registers.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Date: Thu, 25 Feb 2016 10:25:46 +0530
Message-ID: <20160225045524.6543.52552.stgit@mars.in.ibm.com>
In-Reply-To: <20160225045420.6543.55495.stgit@mars.in.ibm.com>
References: <20160225045420.6543.55495.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

The current implementation of MCE early handling modifies CR0/1 registers
without saving its old values. Fix this by moving early check for
powersaving mode to machine_check_handle_early().

The power architecture 2.06 or later allows the possibility of getting
machine check while in nap/sleep/winkle. The last bit of HSPRG0 is set
to 1, if thread is woken up from winkle. Hence, clear the last bit of
HSPRG0 (r13) before MCE handler starts using it as paca pointer.

Also, the current code always puts the thread into nap state irrespective
of whatever idle state it woke up from. Fix that by looking at
paca->thread_idle_state and put the thread back into same state where it
came from.

Reported-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/exceptions-64s.S |   66 ++++++++++++++++++++--------------
 1 file changed, 39 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index d4c99f0..7fa71e7 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -164,29 +164,14 @@ machine_check_pSeries_1:
 	 * vector
 	 */
 	SET_SCRATCH0(r13)		/* save r13 */
-#ifdef CONFIG_PPC_P7_NAP
-BEGIN_FTR_SECTION
-	/* Running native on arch 2.06 or later, check if we are
-	 * waking up from nap. We only handle no state loss and
-	 * supervisor state loss. We do -not- handle hypervisor
-	 * state loss at this time.
+	/*
+	 * Running native on arch 2.06 or later, we may wakeup from winkle
+	 * inside machine check. If yes, then last bit of HSPGR0 would be set
+	 * to 1. Hence clear it unconditionally.
 	 */
-	mfspr	r13,SPRN_SRR1
-	rlwinm.	r13,r13,47-31,30,31
-	OPT_GET_SPR(r13, SPRN_CFAR, CPU_FTR_CFAR)
-	beq	9f
-
-	mfspr	r13,SPRN_SRR1
-	rlwinm.	r13,r13,47-31,30,31
-	/* waking up from powersave (nap) state */
-	cmpwi	cr1,r13,2
-	/* Total loss of HV state is fatal. let's just stay stuck here */
-	OPT_GET_SPR(r13, SPRN_CFAR, CPU_FTR_CFAR)
-	bgt	cr1,.
-9:
-	OPT_SET_SPR(r13, SPRN_CFAR, CPU_FTR_CFAR)
-END_FTR_SECTION_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
-#endif /* CONFIG_PPC_P7_NAP */
+	GET_PACA(r13)
+	clrrdi	r13,r13,1
+	SET_PACA(r13)
 	EXCEPTION_PROLOG_0(PACA_EXMC)
 BEGIN_FTR_SECTION
 	b	machine_check_powernv_early
@@ -1362,25 +1347,52 @@ machine_check_handle_early:
 	 * Check if thread was in power saving mode. We come here when any
 	 * of the following is true:
 	 * a. thread wasn't in power saving mode
-	 * b. thread was in power saving mode with no state loss or
-	 *    supervisor state loss
+	 * b. thread was in power saving mode with no state loss,
+	 *    supervisor state loss or hypervisor state loss.
 	 *
-	 * Go back to nap again if (b) is true.
+	 * Go back to nap/sleep/winkle mode again if (b) is true.
 	 */
 	rlwinm.	r11,r12,47-31,30,31	/* Was it in power saving mode? */
 	beq	4f			/* No, it wasn;t */
 	/* Thread was in power saving mode. Go back to nap again. */
 	cmpwi	r11,2
-	bne	3f
-	/* Supervisor state loss */
+	blt	3f
+	/* Supervisor/Hypervisor state loss loss */
 	li	r0,1
 	stb	r0,PACA_NAPSTATELOST(r13)
 3:	bl	machine_check_queue_event
 	MACHINE_CHECK_HANDLER_WINDUP
 	GET_PACA(r13)
+	/*
+	 * Check what idle state this CPU was in and go back to same mode
+	 * again.
+	 */
+	lbz	r3,PACA_THREAD_IDLE_STATE(r13)
+	cmpwi	r3,PNV_THREAD_NAP
+	bgt	1f
 	ld	r1,PACAR1(r13)
 	li	r3,PNV_THREAD_NAP
 	b	power7_enter_nap_mode
+	/* No return */
+1:
+	cmpwi	r3,PNV_THREAD_SLEEP
+	bgt	2f
+	IDLE_STATE_ENTER_SEQ(PPC_SLEEP)
+	/* No return */
+
+2:
+	/*
+	 * Go back to winkle. Please note that this thread was woken up in
+	 * machine check from winkle and have not restored the per-subcore
+	 * state. Hence before going back to winkle, set last bit of HSPGR0
+	 * to 1. This will make sure that if this thread gets woken up
+	 * again at reset vector 0x100 then it will get chance to restore
+	 * the subcore state.
+	 */
+	ori	r13,r13,1
+	SET_PACA(r13)
+	IDLE_STATE_ENTER_SEQ(PPC_WINKLE)
+	/* No return */
 4:
 #endif
 	/*
