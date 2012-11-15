Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 84B562C00C6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 15:50:17 +1100 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 15 Nov 2012 14:46:07 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qAF4daWx1048922
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 15:39:37 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qAF4o0gv029743
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 15:50:00 +1100
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 5/7] powerpc: Add code to handle soft-disabled doorbells on
 server
Date: Thu, 15 Nov 2012 15:49:48 +1100
Message-Id: <1352954990-2858-6-git-send-email-imunsie@au1.ibm.com>
In-Reply-To: <1352954990-2858-1-git-send-email-imunsie@au1.ibm.com>
References: <1352954990-2858-1-git-send-email-imunsie@au1.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

This patch adds the logic to properly handle doorbells that come in when
interrupts have been soft disabled and to replay them when interrupts
are re-enabled:

- masked_##_H##interrupt is modified to leave interrupts enabled when a
  doorbell has come in since doorbells are edge sensitive and as such
  won't be automatically re-raised.

- __check_irq_replay now tests if a doorbell happened on book3s, and
  returns either 0xe80 or 0xa00 depending on whether we are the
  hypervisor or not.

- restore_check_irq_replay now tests for the two possible server
  doorbell vector numbers to replay.

- __replay_interrupt also adds tests for the two server doorbell vector
  numbers, and is modified to use a compare instruction rather than an
  andi. on the single bit difference between 0x500 and 0x900.

The last two use a CPU feature section to avoid needlessly testing
against the hypervisor vector if it is not the hypervisor, and vice
versa.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 arch/powerpc/kernel/entry_64.S       |   13 ++++++++++--
 arch/powerpc/kernel/exceptions-64s.S |   37 +++++++++++++++++++++++-----------
 arch/powerpc/kernel/irq.c            |   11 ++++++++--
 3 files changed, 45 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index ad76666..df6857f 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -842,13 +842,22 @@ restore_check_irq_replay:
 	addi	r3,r1,STACK_FRAME_OVERHEAD;
 	bl	.timer_interrupt
 	b	.ret_from_except
+#ifdef CONFIG_PPC_DOORBELL
+1:
 #ifdef CONFIG_PPC_BOOK3E
-1:	cmpwi	cr0,r3,0x280
+	cmpwi	cr0,r3,0x280
+#else
+	BEGIN_FTR_SECTION
+		cmpwi	cr0,r3,0xe80
+	FTR_SECTION_ELSE
+		cmpwi	cr0,r3,0xa00
+	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
+#endif /* CONFIG_PPC_BOOK3E */
 	bne	1f
 	addi	r3,r1,STACK_FRAME_OVERHEAD;
 	bl	.doorbell_exception
 	b	.ret_from_except
-#endif /* CONFIG_PPC_BOOK3E */
+#endif /* CONFIG_PPC_DOORBELL */
 1:	b	.ret_from_except /* What else to do here ? */
  
 unrecov_restore:
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 176bf99..32fc04f 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -528,10 +528,12 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_ARCH_206)
 	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0xf40)
 
 /*
- * An interrupt came in while soft-disabled. We set paca->irq_happened,
- * then, if it was a decrementer interrupt, we bump the dec to max and
- * and return, else we hard disable and return. This is called with
- * r10 containing the value to OR to the paca field.
+ * An interrupt came in while soft-disabled. We set paca->irq_happened, then:
+ * - If it was a decrementer interrupt, we bump the dec to max and and return.
+ * - If it was a doorbell we return immediately since doorbells are edge
+ *   triggered and won't automatically refire.
+ * - else we hard disable and return.
+ * This is called with r10 containing the value to OR to the paca field.
  */
 #define MASKED_INTERRUPT(_H)				\
 masked_##_H##interrupt:					\
@@ -539,13 +541,15 @@ masked_##_H##interrupt:					\
 	lbz	r11,PACAIRQHAPPENED(r13);		\
 	or	r11,r11,r10;				\
 	stb	r11,PACAIRQHAPPENED(r13);		\
-	andi.	r10,r10,PACA_IRQ_DEC;			\
-	beq	1f;					\
+	cmpwi	r10,PACA_IRQ_DEC;			\
+	bne	1f;					\
 	lis	r10,0x7fff;				\
 	ori	r10,r10,0xffff;				\
 	mtspr	SPRN_DEC,r10;				\
 	b	2f;					\
-1:	mfspr	r10,SPRN_##_H##SRR1;			\
+1:	cmpwi	r10,PACA_IRQ_DBELL;			\
+	beq	2f;					\
+	mfspr	r10,SPRN_##_H##SRR1;			\
 	rldicl	r10,r10,48,1; /* clear MSR_EE */	\
 	rotldi	r10,r10,16;				\
 	mtspr	SPRN_##_H##SRR1,r10;			\
@@ -562,8 +566,8 @@ masked_##_H##interrupt:					\
 
 /*
  * Called from arch_local_irq_enable when an interrupt needs
- * to be resent. r3 contains 0x500 or 0x900 to indicate which
- * kind of interrupt. MSR:EE is already off. We generate a
+ * to be resent. r3 contains 0x500, 0x900, 0xa00 or 0xe80 to indicate
+ * which kind of interrupt. MSR:EE is already off. We generate a
  * stackframe like if a real interrupt had happened.
  *
  * Note: While MSR:EE is off, we need to make sure that _MSR
@@ -579,9 +583,18 @@ _GLOBAL(__replay_interrupt)
 	mflr	r11
 	mfcr	r9
 	ori	r12,r12,MSR_EE
-	andi.	r3,r3,0x0800
-	bne	decrementer_common
-	b	hardware_interrupt_common
+	cmpwi	r3,0x900
+	beq	decrementer_common
+	cmpwi	r3,0x500
+	beq	hardware_interrupt_common
+BEGIN_FTR_SECTION
+	cmpwi	r3,0xe80
+	beq	h_doorbell_common
+FTR_SECTION_ELSE
+	cmpwi	r3,0xa00
+	beq	doorbell_super_common
+ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
+	blr
 
 #ifdef CONFIG_PPC_PSERIES
 /*
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 71413f4..4f97fe3 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -122,8 +122,8 @@ static inline notrace int decrementer_check_overflow(void)
 }
 
 /* This is called whenever we are re-enabling interrupts
- * and returns either 0 (nothing to do) or 500/900 if there's
- * either an EE or a DEC to generate.
+ * and returns either 0 (nothing to do) or 500/900/280/a00/e80 if
+ * there's an EE, DEC or DBELL to generate.
  *
  * This is called in two contexts: From arch_local_irq_restore()
  * before soft-enabling interrupts, and from the exception exit
@@ -182,6 +182,13 @@ notrace unsigned int __check_irq_replay(void)
 	local_paca->irq_happened &= ~PACA_IRQ_DBELL;
 	if (happened & PACA_IRQ_DBELL)
 		return 0x280;
+#else
+	local_paca->irq_happened &= ~PACA_IRQ_DBELL;
+	if (happened & PACA_IRQ_DBELL) {
+		if (cpu_has_feature(CPU_FTR_HVMODE))
+			return 0xe80;
+		return 0xa00;
+	}
 #endif /* CONFIG_PPC_BOOK3E */
 
 	/* There should be nothing left ! */
-- 
1.7.10.4
