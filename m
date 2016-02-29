Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D3FD11A005D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 23:25:03 +1100 (AEDT)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Mon, 29 Feb 2016 05:25:01 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 685E619D8042
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 05:12:55 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1TCOwxw36438068
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 05:24:58 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1TCOweM023951
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 05:24:58 -0700
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mahesh@linux.vnet.ibm.com,
 maddy@linux.vnet.ibm.com, "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH 2/3] powerpc/powernv: Encapsulate idle preparation steps in a
 macro
Date: Mon, 29 Feb 2016 17:52:59 +0530
Message-Id: <1456748580-10519-3-git-send-email-shreyas@linux.vnet.ibm.com>
In-Reply-To: <1456748580-10519-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1456748580-10519-1-git-send-email-shreyas@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Before entering any idle state which can result in a state loss
we currently save the context in the stack before entering idle.
Encapsulate these steps in a macro IDLE_STATE_PREP. Move this
and other macros to commonly accessible location.

Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/cpuidle.h | 68 ++++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/idle_power7.S  | 65 ++----------------------------------
 2 files changed, 70 insertions(+), 63 deletions(-)

diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
index d2f99ca1e3a6..6c678a779e8e 100644
--- a/arch/powerpc/include/asm/cpuidle.h
+++ b/arch/powerpc/include/asm/cpuidle.h
@@ -15,6 +15,74 @@ extern u32 pnv_fastsleep_workaround_at_entry[];
 extern u32 pnv_fastsleep_workaround_at_exit[];
 #endif
 
+/*
+ * IDLE_STATE_PREP - Will be called in preparation for entering
+ * any hardware idle state. Since idle states can result in a
+ * state loss, we create a regs frame on the stack, fill it up
+ * with the state we care about and stick a pointer to it in
+ * PACAR1. Use interrupt stack frame for this purpose.
+ * r3 - contains idle state to be entered
+ * r13 - PACA pointer
+ */
+#define IDLE_STATE_PREP						\
+	mflr	r0;						\
+	std	r0,16(r1);					\
+	stdu	r1,-INT_FRAME_SIZE(r1);				\
+	std	r0,_LINK(r1);					\
+	std	r0,_NIP(r1);					\
+								\
+	/* Hard disable interrupts */				\
+	mfmsr	r9;						\
+	rldicl	r9,r9,48,1;					\
+	rotldi	r9,r9,16;					\
+	mtmsrd	r9,1;		/* hard-disable interrupts */	\
+								\
+	/* Check if something happened while soft-disabled */	\
+	lbz	r0,PACAIRQHAPPENED(r13);			\
+	andi.	r0,r0,~PACA_IRQ_HARD_DIS@l;			\
+	beq	1f;						\
+	cmpwi	cr0,r4,0;					\
+	beq	1f;						\
+	addi	r1,r1,INT_FRAME_SIZE;				\
+	ld	r0,16(r1);					\
+	li	r3,0;			/* Return 0 (no nap) */	\
+	mtlr	r0;						\
+	blr;							\
+1:	/* We mark irqs hard disabled as this is the state	\
+	 * we'll  be in when returning and we need to tell	\
+	 * arch_local_irq_restore() about it */			\
+	li	r0,PACA_IRQ_HARD_DIS;				\
+	stb	r0,PACAIRQHAPPENED(r13);			\
+								\
+	/* We haven't lost state ... yet */			\
+	li	r0,0;						\
+	stb	r0,PACA_NAPSTATELOST(r13);			\
+								\
+	/* Continue saving state */				\
+	SAVE_GPR(2, r1);					\
+	SAVE_NVGPRS(r1);					\
+	mfcr	r4;						\
+	std	r4,_CCR(r1);					\
+	std	r9,_MSR(r1);					\
+	std	r1,PACAR1(r13);					\
+
+/*
+ * We use interrupt stack to save and restore few registers like
+ * PC, CR, LR and NVGPRs while enter/exiting idle states. Since
+ * volatile registers don't need to be saved/restored use that space
+ * instead to save/restore sprs which lose state during winkle.
+ */
+#define _SDR1	GPR3
+#define _RPR	GPR4
+#define _SPURR	GPR5
+#define _PURR	GPR6
+#define _TSCR	GPR7
+#define _DSCR	GPR8
+#define _AMOR	GPR9
+#define _WORT	GPR10
+#define _WORC	GPR11
+
+
 #endif
 
 #endif
diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle_power7.S
index abc53e88a5b4..6af57e292848 100644
--- a/arch/powerpc/kernel/idle_power7.S
+++ b/arch/powerpc/kernel/idle_power7.S
@@ -24,20 +24,6 @@
 
 #undef DEBUG
 
-/*
- * Use unused space in the interrupt stack to save and restore
- * registers for winkle support.
- */
-#define _SDR1	GPR3
-#define _RPR	GPR4
-#define _SPURR	GPR5
-#define _PURR	GPR6
-#define _TSCR	GPR7
-#define _DSCR	GPR8
-#define _AMOR	GPR9
-#define _WORT	GPR10
-#define _WORC	GPR11
-
 /* Idle state entry routines */
 
 #define	IDLE_STATE_ENTER_SEQ(IDLE_INST)				\
@@ -77,55 +63,8 @@ core_idle_lock_held:
  * 	1 - check
  */
 _GLOBAL(power7_powersave_common)
-	/* Use r3 to pass state nap/sleep/winkle */
-	/* NAP is a state loss, we create a regs frame on the
-	 * stack, fill it up with the state we care about and
-	 * stick a pointer to it in PACAR1. We really only
-	 * need to save PC, some CR bits and the NV GPRs,
-	 * but for now an interrupt frame will do.
-	 */
-	mflr	r0
-	std	r0,16(r1)
-	stdu	r1,-INT_FRAME_SIZE(r1)
-	std	r0,_LINK(r1)
-	std	r0,_NIP(r1)
-
-	/* Hard disable interrupts */
-	mfmsr	r9
-	rldicl	r9,r9,48,1
-	rotldi	r9,r9,16
-	mtmsrd	r9,1			/* hard-disable interrupts */
-
-	/* Check if something happened while soft-disabled */
-	lbz	r0,PACAIRQHAPPENED(r13)
-	andi.	r0,r0,~PACA_IRQ_HARD_DIS@l
-	beq	1f
-	cmpwi	cr0,r4,0
-	beq	1f
-	addi	r1,r1,INT_FRAME_SIZE
-	ld	r0,16(r1)
-	li	r3,0			/* Return 0 (no nap) */
-	mtlr	r0
-	blr
-
-1:	/* We mark irqs hard disabled as this is the state we'll
-	 * be in when returning and we need to tell arch_local_irq_restore()
-	 * about it
-	 */
-	li	r0,PACA_IRQ_HARD_DIS
-	stb	r0,PACAIRQHAPPENED(r13)
-
-	/* We haven't lost state ... yet */
-	li	r0,0
-	stb	r0,PACA_NAPSTATELOST(r13)
-
-	/* Continue saving state */
-	SAVE_GPR(2, r1)
-	SAVE_NVGPRS(r1)
-	mfcr	r4
-	std	r4,_CCR(r1)
-	std	r9,_MSR(r1)
-	std	r1,PACAR1(r13)
+	/* Save PC, CR, LR and NVGPRs in stack */
+	IDLE_STATE_PREP;
 
 	/*
 	 * Go to real mode to do the nap, as required by the architecture.
-- 
1.9.3
