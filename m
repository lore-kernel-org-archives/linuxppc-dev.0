Return-Path: <haokexin@gmail.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 61A2A2C00C3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 May 2013 09:26:37 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: [PATCH 1/4] powerpc/book3e: introduce external_input_edge exception
 handler for 64bit kernel
Date: Sun, 12 May 2013 07:26:21 +0800
Message-ID: <1368314784-971-2-git-send-email-haokexin@gmail.com>
In-Reply-To: <1368314784-971-1-git-send-email-haokexin@gmail.com>
References: <1368314784-971-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the external proxy facility mode, the interrupt is automatically
acknowledged with the same effect as reading the IACK register. So
this makes external input interrupt more like edge sensitive. That
means we can leave the irq hard enabled when it occurs with irq soft
disabled just like the dec and doorbell interrupt. But the External
Proxy Register(EPR) is only considered valid from the time that the
external interrupt occurs until MSR[EE] is set to 1. So we have to
save the EPR before irq hard enabled.

In general, we would initialize all the interrupt sources to the same
priority. That means if a interrupt is in service and the other
interrupt would never get any chance to be delivered to the cpu.
And also in order not to complicate the implementation, we only support
to save one content of the EPR register and will set PACA_IRQ_EE
and then hard disable the irq if more external interrupt are received.

In order to support to choose the working mode of MPIC at runtime,
we introduce a new external input exception handler. And we will
use this handler if the external proxy is enabled.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/include/asm/paca.h      |  1 +
 arch/powerpc/kernel/asm-offsets.c    |  1 +
 arch/powerpc/kernel/entry_64.S       |  2 ++
 arch/powerpc/kernel/exceptions-64e.S | 26 +++++++++++++++++++++++---
 arch/powerpc/kernel/irq.c            | 12 ++++++------
 arch/powerpc/kernel/paca.c           |  3 +++
 arch/powerpc/sysdev/mpic.c           |  8 ++++++++
 7 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 77c91e7..9b3649d 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -118,6 +118,7 @@ struct paca_struct {
 	void *mc_kstack;
 	void *crit_kstack;
 	void *dbg_kstack;
+	u32 saved_epr;		/* EPR saved here */
 #endif /* CONFIG_PPC_BOOK3E */
 
 	mm_context_t context;
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index b51a97c..3199708 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -201,6 +201,7 @@ int main(void)
 	DEFINE(PACA_MC_STACK, offsetof(struct paca_struct, mc_kstack));
 	DEFINE(PACA_CRIT_STACK, offsetof(struct paca_struct, crit_kstack));
 	DEFINE(PACA_DBG_STACK, offsetof(struct paca_struct, dbg_kstack));
+	DEFINE(PACASAVEDEPR, offsetof(struct paca_struct, saved_epr));
 #endif /* CONFIG_PPC_BOOK3E */
 
 #ifdef CONFIG_PPC_STD_MMU_64
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 3fe5259..09ac356 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -884,6 +884,8 @@ restore_check_irq_replay:
 	 * still soft-disabled and we keep them that way.
 	*/
 	cmpwi	cr0,r3,0x500
+	cmpwi	cr1,r3,0x510
+	cror	eq,4*cr1+eq,eq
 	bne	1f
 	addi	r3,r1,STACK_FRAME_OVERHEAD;
  	bl	.do_IRQ
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 42a756e..e32bd6c 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -358,6 +358,9 @@ interrupt_end_book3e:
 	MASKABLE_EXCEPTION(0x500, BOOKE_INTERRUPT_EXTERNAL,
 			   external_input, .do_IRQ, ACK_NONE)
 
+	MASKABLE_EXCEPTION(0x510, BOOKE_INTERRUPT_EXTERNAL,
+			   external_input_edge, .do_IRQ, ACK_NONE)
+
 /* Alignment */
 	START_EXCEPTION(alignment);
 	NORMAL_EXCEPTION_PROLOG(0x600, BOOKE_INTERRUPT_ALIGNMENT,
@@ -685,13 +688,25 @@ kernel_dbg_exc:
 	ori	r10,r10,\paca_irq
 	stb	r10,PACAIRQHAPPENED(r13)
 
+	.if \paca_irq == PACA_IRQ_EE_EDGE
+	lwz	r10,PACASAVEDEPR(r13)
+	cmpwi	r10,~0
+	bne-	98f
+	mfspr	r10,SPRN_EPR
+	stw	r10,PACASAVEDEPR(r13)
+	b	99f
+98:	lbz	r10,PACAIRQHAPPENED(r13)
+	ori	r10,r10,PACA_IRQ_EE
+	stb	r10,PACAIRQHAPPENED(r13)
+	.endif
+
 	.if \full_mask == 1
 	rldicl	r10,r11,48,1		/* clear MSR_EE */
 	rotldi	r11,r10,16
 	mtspr	SPRN_SRR1,r11
 	.endif
 
-	lwz	r11,PACA_EXGEN+EX_CR(r13)
+99:	lwz	r11,PACA_EXGEN+EX_CR(r13)
 	mtcr	r11
 	ld	r10,PACA_EXGEN+EX_R10(r13)
 	ld	r11,PACA_EXGEN+EX_R11(r13)
@@ -701,9 +716,11 @@ kernel_dbg_exc:
 .endm
 
 masked_interrupt_book3e_0x500:
-	// XXX When adding support for EPR, use PACA_IRQ_EE_EDGE
 	masked_interrupt_book3e PACA_IRQ_EE 1
 
+masked_interrupt_book3e_0x510:
+	masked_interrupt_book3e PACA_IRQ_EE_EDGE 1
+
 masked_interrupt_book3e_0x900:
 	ACK_DEC(r10);
 	masked_interrupt_book3e PACA_IRQ_DEC 0
@@ -718,7 +735,7 @@ masked_interrupt_book3e_0x2c0:
 
 /*
  * Called from arch_local_irq_enable when an interrupt needs
- * to be resent. r3 contains either 0x500,0x900,0x260 or 0x280
+ * to be resent. r3 contains either 0x500,0x900,0x510 or 0x280
  * to indicate the kind of interrupt. MSR:EE is already off.
  * We generate a stackframe like if a real interrupt had happened.
  *
@@ -745,6 +762,8 @@ _GLOBAL(__replay_interrupt)
 	beq	exc_0x900_common
 	cmpwi	cr0,r3,0x280
 	beq	exc_0x280_common
+	cmpwi	cr0,r3,0x510
+	beq	exc_0x510_common
 	blr
 
 
@@ -859,6 +878,7 @@ BAD_STACK_TRAMPOLINE(0x310)
 BAD_STACK_TRAMPOLINE(0x320)
 BAD_STACK_TRAMPOLINE(0x400)
 BAD_STACK_TRAMPOLINE(0x500)
+BAD_STACK_TRAMPOLINE(0x510)
 BAD_STACK_TRAMPOLINE(0x600)
 BAD_STACK_TRAMPOLINE(0x700)
 BAD_STACK_TRAMPOLINE(0x800)
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 5cbcf4d..9349db9 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -165,11 +165,6 @@ notrace unsigned int __check_irq_replay(void)
 	if (decrementer_check_overflow())
 		return 0x900;
 
-	/* Finally check if an external interrupt happened */
-	local_paca->irq_happened &= ~PACA_IRQ_EE;
-	if (happened & PACA_IRQ_EE)
-		return 0x500;
-
 #ifdef CONFIG_PPC_BOOK3E
 	/* Finally check if an EPR external interrupt happened
 	 * this bit is typically set if we need to handle another
@@ -177,7 +172,7 @@ notrace unsigned int __check_irq_replay(void)
 	 */
 	local_paca->irq_happened &= ~PACA_IRQ_EE_EDGE;
 	if (happened & PACA_IRQ_EE_EDGE)
-		return 0x500;
+		return 0x510;
 
 	local_paca->irq_happened &= ~PACA_IRQ_DBELL;
 	if (happened & PACA_IRQ_DBELL)
@@ -191,6 +186,11 @@ notrace unsigned int __check_irq_replay(void)
 	}
 #endif /* CONFIG_PPC_BOOK3E */
 
+	/* Finally check if an external interrupt happened */
+	local_paca->irq_happened &= ~PACA_IRQ_EE;
+	if (happened & PACA_IRQ_EE)
+		return 0x500;
+
 	/* There should be nothing left ! */
 	BUG_ON(local_paca->irq_happened != 0);
 
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index f8f2468..ba370e9 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -144,6 +144,9 @@ void __init initialise_paca(struct paca_struct *new_paca, int cpu)
 #ifdef CONFIG_PPC_STD_MMU_64
 	new_paca->slb_shadow_ptr = &slb_shadow[cpu];
 #endif /* CONFIG_PPC_STD_MMU_64 */
+#ifdef CONFIG_PPC_BOOK3E
+	new_paca->saved_epr = ~0;
+#endif
 }
 
 /* Put the paca pointer into r13 and SPRG_PACA */
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index ee21b5e..4d248d3 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1804,7 +1804,15 @@ unsigned int mpic_get_coreint_irq(void)
 
 	BUG_ON(mpic == NULL);
 
+#ifdef CONFIG_PPC64
+	if (local_paca->saved_epr != ~0) {
+		src = local_paca->saved_epr;
+		local_paca->saved_epr = ~0;
+	} else
+		src = mfspr(SPRN_EPR);
+#else
 	src = mfspr(SPRN_EPR);
+#endif
 
 	if (unlikely(src == mpic->spurious_vec)) {
 		if (mpic->flags & MPIC_SPV_EOI)
-- 
1.8.1.4
