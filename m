Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdpBY1cgRzDrK0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 14:31:01 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id q16so2044086pgc.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 21:31:01 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH v3 2/4] powerpc/64s: idle POWER9 can execute stop without a
 sync sequence
Date: Fri, 25 Aug 2017 14:30:34 +1000
Message-Id: <20170825043036.18236-3-npiggin@gmail.com>
In-Reply-To: <20170825043036.18236-1-npiggin@gmail.com>
References: <20170825043036.18236-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/cpuidle.h | 16 ----------------
 arch/powerpc/kernel/idle_book3s.S  | 26 ++++++++++++++++++++------
 2 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
index 8a174cba5567..eb43b5c3a7b5 100644
--- a/arch/powerpc/include/asm/cpuidle.h
+++ b/arch/powerpc/include/asm/cpuidle.h
@@ -101,20 +101,4 @@ static inline void report_invalid_psscr_val(u64 psscr_val, int err)
 
 #endif
 
-/* Idle state entry routines */
-#ifdef	CONFIG_PPC_P7_NAP
-#define IDLE_STATE_ENTER_SEQ(IDLE_INST)                         \
-	/* Magic NAP/SLEEP/WINKLE mode enter sequence */	\
-	std	r0,0(r1);					\
-	ptesync;						\
-	ld	r0,0(r1);					\
-236:	cmpd	cr0,r0,r0;					\
-	bne	236b;						\
-	IDLE_INST;						\
-
-#define	IDLE_STATE_ENTER_SEQ_NORET(IDLE_INST)			\
-	IDLE_STATE_ENTER_SEQ(IDLE_INST)                         \
-	b	.
-#endif /* CONFIG_PPC_P7_NAP */
-
 #endif
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 4924647d964d..14e97f442167 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -205,6 +205,19 @@ pnv_powersave_common:
 	mtmsrd	r7,0
 	bctr
 
+/*
+ * This is the sequence required to execute idle instructions, as
+ * specified in ISA v2.07. MSR[IR] and MSR[DR] must be 0.
+ */
+#define ARCH207_IDLE_STATE_ENTER_SEQ_NORET(IDLE_INST)		\
+	/* Magic NAP/SLEEP/WINKLE mode enter sequence */	\
+	std	r0,0(r1);					\
+	ptesync;						\
+	ld	r0,0(r1);					\
+236:	cmpd	cr0,r0,r0;					\
+	bne	236b;						\
+	IDLE_INST;
+
 	.globl pnv_enter_arch207_idle_mode
 pnv_enter_arch207_idle_mode:
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
@@ -230,7 +243,7 @@ pnv_enter_arch207_idle_mode:
 	stb	r3,PACA_THREAD_IDLE_STATE(r13)
 	cmpwi	cr3,r3,PNV_THREAD_SLEEP
 	bge	cr3,2f
-	IDLE_STATE_ENTER_SEQ_NORET(PPC_NAP)
+	ARCH207_IDLE_STATE_ENTER_SEQ_NORET(PPC_NAP)
 	/* No return */
 2:
 	/* Sleep or winkle */
@@ -269,7 +282,7 @@ pnv_fastsleep_workaround_at_entry:
 
 common_enter: /* common code for all the threads entering sleep or winkle */
 	bgt	cr3,enter_winkle
-	IDLE_STATE_ENTER_SEQ_NORET(PPC_SLEEP)
+	ARCH207_IDLE_STATE_ENTER_SEQ_NORET(PPC_SLEEP)
 
 fastsleep_workaround_at_entry:
 	oris	r15,r15,PNV_CORE_IDLE_LOCK_BIT@h
@@ -291,7 +304,7 @@ fastsleep_workaround_at_entry:
 enter_winkle:
 	bl	save_sprs_to_stack
 
-	IDLE_STATE_ENTER_SEQ_NORET(PPC_WINKLE)
+	ARCH207_IDLE_STATE_ENTER_SEQ_NORET(PPC_WINKLE)
 
 /*
  * r3 - PSSCR value corresponding to the requested stop state.
@@ -316,7 +329,7 @@ power_enter_stop:
 	andis.   r4,r3,PSSCR_EC_ESL_MASK_SHIFTED
 	clrldi   r3,r3,60 /* r3 = Bits[60:63] = Requested Level (RL) */
 	bne	 .Lhandle_esl_ec_set
-	IDLE_STATE_ENTER_SEQ(PPC_STOP)
+	PPC_STOP
 	li	r3,0  /* Since we didn't lose state, return 0 */
 
 	/*
@@ -349,7 +362,8 @@ power_enter_stop:
 	ld	r4,ADDROFF(pnv_first_deep_stop_state)(r5)
 	cmpd	r3,r4
 	bge	.Lhandle_deep_stop
-	IDLE_STATE_ENTER_SEQ_NORET(PPC_STOP)
+	PPC_STOP	/* Does not return (system reset interrupt) */
+
 .Lhandle_deep_stop:
 /*
  * Entering deep idle state.
@@ -371,7 +385,7 @@ lwarx_loop_stop:
 
 	bl	save_sprs_to_stack
 
-	IDLE_STATE_ENTER_SEQ_NORET(PPC_STOP)
+	PPC_STOP	/* Does not return (system reset interrupt) */
 
 /*
  * Entered with MSR[EE]=0 and no soft-masked interrupts pending.
-- 
2.13.3
