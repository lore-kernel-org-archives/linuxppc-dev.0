Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao12.cox.net (fed1rmmtao12.cox.net [68.230.241.27])
	by ozlabs.org (Postfix) with ESMTP id A98972BF17
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  8 Jan 2005 03:22:33 +1100 (EST)
Date: Fri, 7 Jan 2005 09:22:31 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-embedded@ozlabs.org
Message-ID: <20050107162230.GB5259@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [PATCH] Handle I-TLB Error and Miss separately on 8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

As the code stands currently, there is a bug in the 2.4 and 2.6 handling
of I-TLB Miss and Error exceptions on 8xx.  The problem is that since we
treat both of them as the same exception when we hit do_page_fault,
there is a case where we can incorrectly find that a protection fault
has occured, when it hasn't.  This is because we check bit 4 of SRR1 in
both cases, but in the case of an I-TLB Miss, this bit is always set,
and it only indicates a protection fault on an I-TLB Error.

Originally from Grigori Tolstolytkin <gtolstolytkin@ru.mvista.com>.
Signed-off-by: Tom Rini <trini@kernel.crashing.org>

Patch vs 2.4-current:
--- 1.19/arch/ppc/kernel/head_8xx.S	2003-10-27 12:31:25 -07:00
+++ edited/arch/ppc/kernel/head_8xx.S	2005-01-07 08:57:31 -07:00
@@ -501,10 +501,18 @@
 /* This is an instruction TLB error on the MPC8xx.  This could be due
  * to many reasons, such as executing guarded memory or illegal instruction
  * addresses.  There is nothing to do but handle a big time error fault.
+ * But we can't just jump from the InstructionAccess fault (0x400) as
+ * do_page_fault() needs to know.
  */
 	. = 0x1300
 InstructionTLBError:
-	b	InstructionAccess
+	EXCEPTION_PROLOG
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	mr	r4,r22
+	mr	r5,r23
+	li	r20,MSR_KERNEL
+	rlwimi	r20,r23,0,16,16		/* copy EE bit from saved MSR */
+	FINISH_EXCEPTION(do_page_fault)
 
 /* This is the data TLB error on the MPC8xx.  This could be due to
  * many reasons, including a dirty update to a pte.  We can catch that
--- 1.15/arch/ppc/mm/fault.c	2003-08-29 03:37:49 -07:00
+++ edited/arch/ppc/mm/fault.c	2005-01-07 08:59:25 -07:00
@@ -91,7 +91,8 @@
  * For 600- and 800-family processors, the error_code parameter is DSISR
  * for a data fault, SRR1 for an instruction fault. For 400-family processors
  * the error_code parameter is ESR for a data fault, 0 for an instruction
- * fault.
+ * fault.  On 800-family processors, we fudge an I-TLB Miss (0x1100) as
+ * being at 0x400 for space reasons.
  */
 void do_page_fault(struct pt_regs *regs, unsigned long address,
 		   unsigned long error_code)
@@ -111,7 +112,11 @@
 	 * bits we are interested in.  But there are some bits which
 	 * indicate errors in DSISR but can validly be set in SRR1.
 	 */
+#ifdef CONFIG_8xx
+	if (regs->trap == 0x400 || regs->trap == 0x1300)
+#else
 	if (regs->trap == 0x400)
+#endif
 		error_code &= 0x48200000;
 	else
 		is_write = error_code & 0x02000000;
@@ -204,8 +209,17 @@
 			goto bad_area;
 	/* a read */
 	} else {
-		/* protection fault */
+		/*
+		 * On non-8xx, a protection fault.  On 8xx, this bit is
+		 * always set on I-TLB Miss, but indicates a protection
+		 * fault on an I-TLB Error.  So we only check this bit
+		 * if we aren't an I-TLB Miss.
+		 */
+#ifdef CONFIG_8xx
+		if ((error_code & 0x08000000) && regs->trap != 0x400)
+#else
 		if (error_code & 0x08000000)
+#endif
 			goto bad_area;
 		if (!(vma->vm_flags & (VM_READ | VM_EXEC)))
 			goto bad_area;

Patch vs 2.6-current:
--- 1.18/arch/ppc/kernel/head_8xx.S	2004-11-11 01:25:53 -07:00
+++ edited/arch/ppc/kernel/head_8xx.S	2005-01-07 09:13:05 -07:00
@@ -445,10 +445,15 @@
 /* This is an instruction TLB error on the MPC8xx.  This could be due
  * to many reasons, such as executing guarded memory or illegal instruction
  * addresses.  There is nothing to do but handle a big time error fault.
+ * But we can't just jump from the InstructionAccess fault (0x400) as
+ * do_page_fault() needs to know.
  */
 	. = 0x1300
 InstructionTLBError:
-	b	InstructionAccess
+	EXCEPTION_PROLOG
+	mr	r4,r12
+	mr	r5,r9
+	EXC_XFER_EE_LITE(0x1300, handle_page_fault)
 
 /* This is the data TLB error on the MPC8xx.  This could be due to
  * many reasons, including a dirty update to a pte.  We can catch that
--- 1.21/arch/ppc/mm/fault.c	2004-07-26 14:43:22 -07:00
+++ edited/arch/ppc/mm/fault.c	2005-01-07 09:11:44 -07:00
@@ -90,7 +90,8 @@
  * For 600- and 800-family processors, the error_code parameter is DSISR
  * for a data fault, SRR1 for an instruction fault. For 400-family processors
  * the error_code parameter is ESR for a data fault, 0 for an instruction
- * fault.
+ * fault.  On 800-family processors, we fudge an I-TLB Miss (0x1100) as
+ * being at 0x400 for space reasons.
  */
 int do_page_fault(struct pt_regs *regs, unsigned long address,
 		  unsigned long error_code)
@@ -110,7 +111,11 @@
 	 * bits we are interested in.  But there are some bits which
 	 * indicate errors in DSISR but can validly be set in SRR1.
 	 */
-	if (TRAP(regs) == 0x400)
+#ifdef CONFIG_8xx
+	if (TRAP(regs) == 0x400 || TRAP(regs) == 0x1300)
+#else
+ 	if (TRAP(regs) == 0x400)
+#endif
 		error_code &= 0x48200000;
 	else
 		is_write = error_code & 0x02000000;
@@ -235,8 +240,17 @@
 #endif
 	/* a read */
 	} else {
-		/* protection fault */
+		/*
+		 * On non-8xx, a protection fault.  On 8xx, this bit is
+		 * always set on I-TLB Miss, but indicates a protection
+		 * fault on an I-TLB Error.  So we only check this bit
+		 * if we aren't an I-TLB Miss.
+		 */
+#ifdef CONFIG_8xx
+		if ((error_code & 0x08000000) && regs->trap != 0x400)
+#else
 		if (error_code & 0x08000000)
+#endif
 			goto bad_area;
 		if (!(vma->vm_flags & (VM_READ | VM_EXEC)))
 			goto bad_area;

-- 
Tom Rini
http://gate.crashing.org/~trini/
