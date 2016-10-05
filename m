Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spc2Q0scKzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:23:26 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v3 40/42] powerpc/64s: Move __replay_interrupt function below
 handlers
Date: Wed,  5 Oct 2016 11:23:02 +1100
Message-Id: <1475626984-18770-41-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1475626984-18770-1-git-send-email-mpe@ellerman.id.au>
References: <1475626984-18770-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Nicholas Piggin <npiggin@gmail.com>

This is not an exception handler as such, it's called from
local_irq_enable(), not exception entry.

Also clean up some now redundant comments at the end of the
consolidation series.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/exceptions-64s.S | 74 ++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 307e117b95d3..9b26b7b6f74a 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1317,43 +1317,6 @@ USE_FIXED_SECTION(virt_trampolines)
 	MASKED_INTERRUPT()
 	MASKED_INTERRUPT(H)
 
-/*
- * Called from arch_local_irq_enable when an interrupt needs
- * to be resent. r3 contains 0x500, 0x900, 0xa00 or 0xe80 to indicate
- * which kind of interrupt. MSR:EE is already off. We generate a
- * stackframe like if a real interrupt had happened.
- *
- * Note: While MSR:EE is off, we need to make sure that _MSR
- * in the generated frame has EE set to 1 or the exception
- * handler will not properly re-enable them.
- */
-USE_TEXT_SECTION()
-_GLOBAL(__replay_interrupt)
-	/* We are going to jump to the exception common code which
-	 * will retrieve various register values from the PACA which
-	 * we don't give a damn about, so we don't bother storing them.
-	 */
-	mfmsr	r12
-	mflr	r11
-	mfcr	r9
-	ori	r12,r12,MSR_EE
-	cmpwi	r3,0x900
-	beq	decrementer_common
-	cmpwi	r3,0x500
-	beq	hardware_interrupt_common
-BEGIN_FTR_SECTION
-	cmpwi	r3,0xe80
-	beq	h_doorbell_common
-	cmpwi	r3,0xea0
-	beq	h_virt_irq_common
-	cmpwi	r3,0xe60
-	beq	hmi_exception_common
-FTR_SECTION_ELSE
-	cmpwi	r3,0xa00
-	beq	doorbell_super_common
-ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
-	blr
-
 #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
 TRAMP_REAL_BEGIN(kvmppc_skip_interrupt)
 	/*
@@ -1409,7 +1372,6 @@ TRAMP_REAL_BEGIN(kvmppc_skip_Hinterrupt)
 EXC_COMMON_BEGIN(ppc64_runlatch_on_trampoline)
 	b	__ppc64_runlatch_on
 
-	/* Equivalents to the above handlers for relocation-on interrupt vectors */
 USE_FIXED_SECTION(virt_trampolines)
 	/*
 	 * The __end_interrupts marker must be past the out-of-line (OOL)
@@ -1584,3 +1546,39 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 1:	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	kernel_bad_stack
 	b	1b
+
+/*
+ * Called from arch_local_irq_enable when an interrupt needs
+ * to be resent. r3 contains 0x500, 0x900, 0xa00 or 0xe80 to indicate
+ * which kind of interrupt. MSR:EE is already off. We generate a
+ * stackframe like if a real interrupt had happened.
+ *
+ * Note: While MSR:EE is off, we need to make sure that _MSR
+ * in the generated frame has EE set to 1 or the exception
+ * handler will not properly re-enable them.
+ */
+_GLOBAL(__replay_interrupt)
+	/* We are going to jump to the exception common code which
+	 * will retrieve various register values from the PACA which
+	 * we don't give a damn about, so we don't bother storing them.
+	 */
+	mfmsr	r12
+	mflr	r11
+	mfcr	r9
+	ori	r12,r12,MSR_EE
+	cmpwi	r3,0x900
+	beq	decrementer_common
+	cmpwi	r3,0x500
+	beq	hardware_interrupt_common
+BEGIN_FTR_SECTION
+	cmpwi	r3,0xe80
+	beq	h_doorbell_common
+	cmpwi	r3,0xea0
+	beq	h_virt_irq_common
+	cmpwi	r3,0xe60
+	beq	hmi_exception_common
+FTR_SECTION_ELSE
+	cmpwi	r3,0xa00
+	beq	doorbell_super_common
+ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
+	blr
-- 
2.7.4
