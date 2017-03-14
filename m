Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vj8Sg6hnczDqZ4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 20:24:19 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id 77so23197992pgc.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 02:24:19 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Gautham R Shenoy <ego@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: [PATCH 4/8] powerpc/64s: fix POWER9 machine check handler from stop
 state
Date: Tue, 14 Mar 2017 19:23:45 +1000
Message-Id: <20170314092349.10981-5-npiggin@gmail.com>
In-Reply-To: <20170314092349.10981-1-npiggin@gmail.com>
References: <20170314092349.10981-1-npiggin@gmail.com>
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

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/reg.h       |  1 +
 arch/powerpc/kernel/exceptions-64s.S | 69 ++++++++++++++++++------------------
 2 files changed, 35 insertions(+), 35 deletions(-)

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
index e390fcd04bcb..5779d2d6a192 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -306,6 +306,33 @@ EXC_COMMON_BEGIN(machine_check_common)
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
+	 * Now put SRR1_WAKEMCE_RESVD into SRR1, allows it to follow the
+	 * system reset wakeup code.
+	 */
+	oris	r12,r12,SRR1_WAKEMCE_RESVD@h
+	mtspr	SPRN_SRR1,r12
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
@@ -318,6 +345,7 @@ EXC_COMMON_BEGIN(machine_check_handle_early)
 	bl	machine_check_early
 	std	r3,RESULT(r1)	/* Save result */
 	ld	r12,_MSR(r1)
+
 #ifdef	CONFIG_PPC_P7_NAP
 	/*
 	 * Check if thread was in power saving mode. We come here when any
@@ -328,43 +356,14 @@ EXC_COMMON_BEGIN(machine_check_handle_early)
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
-- 
2.11.0
