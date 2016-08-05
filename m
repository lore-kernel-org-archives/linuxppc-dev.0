Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5QTS40rqzDqZW
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 22:04:28 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s5QTS0TqGz9t17
 for <linuxppc-dev@ozlabs.org>; Fri,  5 Aug 2016 22:04:27 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u75C3w1p117121
 for <linuxppc-dev@ozlabs.org>; Fri, 5 Aug 2016 08:04:26 -0400
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24kkak5an9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 05 Aug 2016 08:04:25 -0400
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 5 Aug 2016 17:34:22 +0530
Received: from d28relay09.in.ibm.com (d28relay09.in.ibm.com [9.184.220.160])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id B3916394005E
 for <linuxppc-dev@ozlabs.org>; Fri,  5 Aug 2016 17:34:19 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u75C4JPt34603022
 for <linuxppc-dev@ozlabs.org>; Fri, 5 Aug 2016 17:34:19 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u75C4EFT028204
 for <linuxppc-dev@ozlabs.org>; Fri, 5 Aug 2016 17:34:16 +0530
Subject: [PATCH v3 2/2] powernv: Fix MCE handler to avoid trashing CR0/CR1
 registers.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Date: Fri, 05 Aug 2016 17:34:13 +0530
In-Reply-To: <147039864368.4007.8950616642100181791.stgit@jupiter.in.ibm.com>
References: <147039864368.4007.8950616642100181791.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <147039865296.4007.7482355227065137884.stgit@jupiter.in.ibm.com>
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
Reviewed-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
---
Change in v3:
- Rebase to Linus' master.

Change in v2:
- Call IDLE_STATE_ENTER_SEQ(PPC_NAP) instead of power7_enter_nap_mode()
  to be consistent with other part of code.
---
 arch/powerpc/kernel/exceptions-64s.S |   69 ++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 694def6..a59c9cc 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -144,29 +144,14 @@ machine_check_pSeries_1:
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
@@ -1273,25 +1258,51 @@ machine_check_handle_early:
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
+	/* Supervisor/Hypervisor state loss */
 	li	r0,1
 	stb	r0,PACA_NAPSTATELOST(r13)
 3:	bl	machine_check_queue_event
 	MACHINE_CHECK_HANDLER_WINDUP
 	GET_PACA(r13)
 	ld	r1,PACAR1(r13)
-	li	r3,PNV_THREAD_NAP
-	b	pnv_enter_arch207_idle_mode
+	/*
+	 * Check what idle state this CPU was in and go back to same mode
+	 * again.
+	 */
+	lbz	r3,PACA_THREAD_IDLE_STATE(r13)
+	cmpwi	r3,PNV_THREAD_NAP
+	bgt	10f
+	IDLE_STATE_ENTER_SEQ(PPC_NAP)
+	/* No return */
+10:
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
