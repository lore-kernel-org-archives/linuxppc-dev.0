Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sb9Sk6K8FzDsc2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 19:48:06 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8G9hZAc048647
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 05:48:04 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25gcvvvv9d-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 05:48:04 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Fri, 16 Sep 2016 03:48:03 -0600
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Michael Neuling <mikey@neuling.org>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH 1/2] powernv:idle: Add IDLE_STATE_ENTER_SEQ_NORET macro
Date: Fri, 16 Sep 2016 15:17:41 +0530
In-Reply-To: <cover.1474015799.git.ego@linux.vnet.ibm.com>
References: <cover.1474015799.git.ego@linux.vnet.ibm.com>
In-Reply-To: <cover.1474015799.git.ego@linux.vnet.ibm.com>
References: <cover.1474015799.git.ego@linux.vnet.ibm.com>
Message-Id: <de9708f33f8a96bf47130941d08732b7c57705f4.1474015799.git.ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

Currently all the low-power idle states are expected to wake up
at reset vector 0x100. Which is why the macro IDLE_STATE_ENTER_SEQ
that puts the CPU to an idle state and never returns.

On ISA_300, when the ESL and EC bits in the PSSCR are zero, the
CPU is expected to wake up at the next instruction of the idle
instruction.

This patch adds a new macro named IDLE_STATE_ENTER_SEQ_NORET for the
no-return variant and reuses the name IDLE_STATE_ENTER_SEQ
for a variant that allows resuming operation at the instruction next
to the idle-instruction.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/cpuidle.h   |  5 ++++-
 arch/powerpc/kernel/exceptions-64s.S |  6 +++---
 arch/powerpc/kernel/idle_book3s.S    | 10 +++++-----
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
index 01b8a13..9fd23f6 100644
--- a/arch/powerpc/include/asm/cpuidle.h
+++ b/arch/powerpc/include/asm/cpuidle.h
@@ -21,7 +21,7 @@ extern u64 pnv_first_deep_stop_state;
 
 /* Idle state entry routines */
 #ifdef	CONFIG_PPC_P7_NAP
-#define	IDLE_STATE_ENTER_SEQ(IDLE_INST)				\
+#define IDLE_STATE_ENTER_SEQ(IDLE_INST)                         \
 	/* Magic NAP/SLEEP/WINKLE mode enter sequence */	\
 	std	r0,0(r1);					\
 	ptesync;						\
@@ -29,6 +29,9 @@ extern u64 pnv_first_deep_stop_state;
 1:	cmp	cr0,r0,r0;					\
 	bne	1b;						\
 	IDLE_INST;						\
+
+#define	IDLE_STATE_ENTER_SEQ_NORET(IDLE_INST)			\
+	IDLE_STATE_ENTER_SEQ(IDLE_INST)                         \
 	b	.
 #endif /* CONFIG_PPC_P7_NAP */
 
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index bffec73..238307d 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1301,12 +1301,12 @@ machine_check_handle_early:
 	lbz	r3,PACA_THREAD_IDLE_STATE(r13)
 	cmpwi	r3,PNV_THREAD_NAP
 	bgt	10f
-	IDLE_STATE_ENTER_SEQ(PPC_NAP)
+	IDLE_STATE_ENTER_SEQ_NORET(PPC_NAP)
 	/* No return */
 10:
 	cmpwi	r3,PNV_THREAD_SLEEP
 	bgt	2f
-	IDLE_STATE_ENTER_SEQ(PPC_SLEEP)
+	IDLE_STATE_ENTER_SEQ_NORET(PPC_SLEEP)
 	/* No return */
 
 2:
@@ -1320,7 +1320,7 @@ machine_check_handle_early:
 	 */
 	ori	r13,r13,1
 	SET_PACA(r13)
-	IDLE_STATE_ENTER_SEQ(PPC_WINKLE)
+	IDLE_STATE_ENTER_SEQ_NORET(PPC_WINKLE)
 	/* No return */
 4:
 #endif
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index bd739fe..32d666b 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -188,7 +188,7 @@ pnv_enter_arch207_idle_mode:
 	stb	r3,PACA_THREAD_IDLE_STATE(r13)
 	cmpwi	cr3,r3,PNV_THREAD_SLEEP
 	bge	cr3,2f
-	IDLE_STATE_ENTER_SEQ(PPC_NAP)
+	IDLE_STATE_ENTER_SEQ_NORET(PPC_NAP)
 	/* No return */
 2:
 	/* Sleep or winkle */
@@ -222,7 +222,7 @@ pnv_fastsleep_workaround_at_entry:
 
 common_enter: /* common code for all the threads entering sleep or winkle */
 	bgt	cr3,enter_winkle
-	IDLE_STATE_ENTER_SEQ(PPC_SLEEP)
+	IDLE_STATE_ENTER_SEQ_NORET(PPC_SLEEP)
 
 fastsleep_workaround_at_entry:
 	ori	r15,r15,PNV_CORE_IDLE_LOCK_BIT
@@ -244,7 +244,7 @@ fastsleep_workaround_at_entry:
 enter_winkle:
 	bl	save_sprs_to_stack
 
-	IDLE_STATE_ENTER_SEQ(PPC_WINKLE)
+	IDLE_STATE_ENTER_SEQ_NORET(PPC_WINKLE)
 
 /*
  * r3 - requested stop state
@@ -257,7 +257,7 @@ power_enter_stop:
 	ld	r4,ADDROFF(pnv_first_deep_stop_state)(r5)
 	cmpd	r3,r4
 	bge	2f
-	IDLE_STATE_ENTER_SEQ(PPC_STOP)
+	IDLE_STATE_ENTER_SEQ_NORET(PPC_STOP)
 2:
 /*
  * Entering deep idle state.
@@ -279,7 +279,7 @@ lwarx_loop_stop:
 
 	bl	save_sprs_to_stack
 
-	IDLE_STATE_ENTER_SEQ(PPC_STOP)
+	IDLE_STATE_ENTER_SEQ_NORET(PPC_STOP)
 
 _GLOBAL(power7_idle)
 	/* Now check if user or arch enabled NAP mode */
-- 
1.9.4
