Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tyR4X6zQpzDqHq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 20:07:40 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v0A9437W025690
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 04:07:38 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27vuky2f1w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 04:07:38 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 10 Jan 2017 04:07:36 -0500
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 "Oliver O'Halloran" <oohall@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH v5 1/5] powernv:idle: Add IDLE_STATE_ENTER_SEQ_NORET macro
Date: Tue, 10 Jan 2017 14:37:00 +0530
In-Reply-To: <1484039224-5630-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1484039224-5630-1-git-send-email-ego@linux.vnet.ibm.com>
Message-Id: <1484039224-5630-2-git-send-email-ego@linux.vnet.ibm.com>
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

On ISA v3.0, when the ESL and EC bits in the PSSCR are zero, the CPU
is expected to wake up at the next instruction of the idle
instruction.

This patch adds a new macro named IDLE_STATE_ENTER_SEQ_NORET for the
no-return variant and reuses the name IDLE_STATE_ENTER_SEQ
for a variant that allows resuming operation at the instruction next
to the idle-instruction.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
No changes from v4

 arch/powerpc/include/asm/cpuidle.h   |  5 ++++-
 arch/powerpc/kernel/exceptions-64s.S |  6 +++---
 arch/powerpc/kernel/idle_book3s.S    | 10 +++++-----
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
index 3919332..0a3255b 100644
--- a/arch/powerpc/include/asm/cpuidle.h
+++ b/arch/powerpc/include/asm/cpuidle.h
@@ -21,7 +21,7 @@
 
 /* Idle state entry routines */
 #ifdef	CONFIG_PPC_P7_NAP
-#define	IDLE_STATE_ENTER_SEQ(IDLE_INST)				\
+#define IDLE_STATE_ENTER_SEQ(IDLE_INST)                         \
 	/* Magic NAP/SLEEP/WINKLE mode enter sequence */	\
 	std	r0,0(r1);					\
 	ptesync;						\
@@ -29,6 +29,9 @@
 1:	cmpd	cr0,r0,r0;					\
 	bne	1b;						\
 	IDLE_INST;						\
+
+#define	IDLE_STATE_ENTER_SEQ_NORET(IDLE_INST)			\
+	IDLE_STATE_ENTER_SEQ(IDLE_INST)                         \
 	b	.
 #endif /* CONFIG_PPC_P7_NAP */
 
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 1ba82ea..7aa8afc 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -381,12 +381,12 @@ EXC_COMMON_BEGIN(machine_check_handle_early)
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
@@ -400,7 +400,7 @@ EXC_COMMON_BEGIN(machine_check_handle_early)
 	 */
 	ori	r13,r13,1
 	SET_PACA(r13)
-	IDLE_STATE_ENTER_SEQ(PPC_WINKLE)
+	IDLE_STATE_ENTER_SEQ_NORET(PPC_WINKLE)
 	/* No return */
 4:
 #endif
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 72dac0b..be90e2f 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -205,7 +205,7 @@ pnv_enter_arch207_idle_mode:
 	stb	r3,PACA_THREAD_IDLE_STATE(r13)
 	cmpwi	cr3,r3,PNV_THREAD_SLEEP
 	bge	cr3,2f
-	IDLE_STATE_ENTER_SEQ(PPC_NAP)
+	IDLE_STATE_ENTER_SEQ_NORET(PPC_NAP)
 	/* No return */
 2:
 	/* Sleep or winkle */
@@ -239,7 +239,7 @@ pnv_fastsleep_workaround_at_entry:
 
 common_enter: /* common code for all the threads entering sleep or winkle */
 	bgt	cr3,enter_winkle
-	IDLE_STATE_ENTER_SEQ(PPC_SLEEP)
+	IDLE_STATE_ENTER_SEQ_NORET(PPC_SLEEP)
 
 fastsleep_workaround_at_entry:
 	ori	r15,r15,PNV_CORE_IDLE_LOCK_BIT
@@ -261,7 +261,7 @@ fastsleep_workaround_at_entry:
 enter_winkle:
 	bl	save_sprs_to_stack
 
-	IDLE_STATE_ENTER_SEQ(PPC_WINKLE)
+	IDLE_STATE_ENTER_SEQ_NORET(PPC_WINKLE)
 
 /*
  * r3 - requested stop state
@@ -280,7 +280,7 @@ power_enter_stop:
 	ld	r4,ADDROFF(pnv_first_deep_stop_state)(r5)
 	cmpd	r3,r4
 	bge	2f
-	IDLE_STATE_ENTER_SEQ(PPC_STOP)
+	IDLE_STATE_ENTER_SEQ_NORET(PPC_STOP)
 2:
 /*
  * Entering deep idle state.
@@ -302,7 +302,7 @@ lwarx_loop_stop:
 
 	bl	save_sprs_to_stack
 
-	IDLE_STATE_ENTER_SEQ(PPC_STOP)
+	IDLE_STATE_ENTER_SEQ_NORET(PPC_STOP)
 
 _GLOBAL(power7_idle)
 	/* Now check if user or arch enabled NAP mode */
-- 
1.9.4
