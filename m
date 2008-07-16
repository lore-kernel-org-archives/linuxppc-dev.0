Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <265ffd8379f89c869c8e87806ced8737272b81f7.1216182085.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] powerpc: Streamline ret_from_except_lite for non-iSeries
	platforms
Date: Wed, 16 Jul 2008 14:21:34 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There is a small passage of code in ret_from_except_lite which is
only required on iSeries. For a multi-platform kernel on non-iSeries
machines this means we end up executing ~15 nops in ret_from_except_lite.

It would be nicer if non-iSeries could skip the code entirely, and on
iSeries we can jump out of line to execute the code.

I have no performance numbers to justify this, other than the assertion
that executing 15 nops takes longer than executing 0.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

---
Booted on POWER5 & legacy iSeries.


 arch/powerpc/kernel/entry_64.S |   53 ++++++++++++++++++++++------------------
 1 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index d736924..fff7490 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -507,31 +507,12 @@ _GLOBAL(ret_from_except_lite)
 #endif
 
 restore:
-	ld	r5,SOFTE(r1)
-#ifdef CONFIG_PPC_ISERIES
 BEGIN_FW_FTR_SECTION
-	cmpdi	0,r5,0
-	beq	4f
-	/* Check for pending interrupts (iSeries) */
-	ld	r3,PACALPPACAPTR(r13)
-	ld	r3,LPPACAANYINT(r3)
-	cmpdi	r3,0
-	beq+	4f			/* skip do_IRQ if no interrupts */
-
-	li	r3,0
-	stb	r3,PACASOFTIRQEN(r13)	/* ensure we are soft-disabled */
-#ifdef CONFIG_TRACE_IRQFLAGS
-	bl	.trace_hardirqs_off
-	mfmsr	r10
-#endif
-	ori	r10,r10,MSR_EE
-	mtmsrd	r10			/* hard-enable again */
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	.do_IRQ
-	b	.ret_from_except_lite		/* loop back and handle more */
-4:
-END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
-#endif
+	ld	r5,SOFTE(r1)
+FW_FTR_SECTION_ELSE
+	b	iseries_check_pending_irqs
+ALT_FW_FTR_SECTION_END_IFCLR(FW_FEATURE_ISERIES)
+2:
 	TRACE_AND_RESTORE_IRQ(r5);
 
 	/* extract EE bit and use it to restore paca->hard_enabled */
@@ -587,6 +568,30 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
 	rfid
 	b	.	/* prevent speculative execution */
 
+iseries_check_pending_irqs:
+#ifdef CONFIG_PPC_ISERIES
+	ld	r5,SOFTE(r1)
+	cmpdi	0,r5,0
+	beq	2b
+	/* Check for pending interrupts (iSeries) */
+	ld	r3,PACALPPACAPTR(r13)
+	ld	r3,LPPACAANYINT(r3)
+	cmpdi	r3,0
+	beq+	2b			/* skip do_IRQ if no interrupts */
+
+	li	r3,0
+	stb	r3,PACASOFTIRQEN(r13)	/* ensure we are soft-disabled */
+#ifdef CONFIG_TRACE_IRQFLAGS
+	bl	.trace_hardirqs_off
+	mfmsr	r10
+#endif
+	ori	r10,r10,MSR_EE
+	mtmsrd	r10			/* hard-enable again */
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	.do_IRQ
+	b	.ret_from_except_lite		/* loop back and handle more */
+#endif
+
 do_work:
 #ifdef CONFIG_PREEMPT
 	andi.	r0,r3,MSR_PR	/* Returning to user mode? */
-- 
1.5.5
