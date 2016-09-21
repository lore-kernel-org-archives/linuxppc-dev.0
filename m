Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfBWb1d2jzDshQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 17:46:03 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id oz2so1949896pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 00:46:03 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 39/41] powerpc/64s: move __replay_interrupt function below
 handlers
Date: Wed, 21 Sep 2016 17:44:05 +1000
Message-Id: <20160921074407.4885-40-npiggin@gmail.com>
In-Reply-To: <20160921074407.4885-1-npiggin@gmail.com>
References: <20160921074407.4885-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is not an exception handler as such: it's called from
local_irq_enable(), not exception entry.

Also clean up some now redundant comments at the end of the
consolidation series.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 99 +++++++++++++-----------------------
 1 file changed, 36 insertions(+), 63 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 9f96ec2..69a2379 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1319,42 +1319,6 @@ USE_FIXED_SECTION(virt_trampolines)
 	MASKED_INTERRUPT(H)
 UNUSE_FIXED_SECTION(virt_trampolines)
 
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
 TRAMP_HANDLER_BEGIN(kvmppc_skip_interrupt)
 	/*
@@ -1383,37 +1347,10 @@ TRAMP_HANDLER_BEGIN(kvmppc_skip_Hinterrupt)
 TRAMP_HANDLER_END(kvmppc_skip_Hinterrupt)
 #endif
 
-/*
- * Ensure that any handlers that get invoked from the exception prologs
- * above are below the first 64KB (0x10000) of the kernel image because
- * the prologs assemble the addresses of these handlers using the
- * LOAD_HANDLER macro, which uses an ori instruction.
- */
-
-/*** Common interrupt handlers ***/
-
-
-	/*
-	 * Relocation-on interrupts: A subset of the interrupts can be delivered
-	 * with IR=1/DR=1, if AIL==2 and MSR.HV won't be changed by delivering
-	 * it.  Addresses are the same as the original interrupt addresses, but
-	 * offset by 0xc000000000004000.
-	 * It's impossible to receive interrupts below 0x300 via this mechanism.
-	 * KVM: None of these traps are from the guest ; anything that escalated
-	 * to HV=1 from HV=0 is delivered via real mode handlers.
-	 */
-
-	/*
-	 * This uses the standard macro, since the original 0x300 vector
-	 * only has extra guff for STAB-based processors -- which never
-	 * come here.
-	 */
-
 TRAMP_HANDLER_BEGIN(ppc64_runlatch_on_trampoline)
 	b	__ppc64_runlatch_on
 TRAMP_HANDLER_END(ppc64_runlatch_on_trampoline)
 
-	/* Equivalents to the above handlers for relocation-on interrupt vectors */
 USE_FIXED_SECTION(virt_trampolines)
 	/*
 	 * The __end_interrupts marker must be past the out-of-line (OOL)
@@ -1589,3 +1526,39 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
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
2.9.3
