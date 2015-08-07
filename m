Return-Path: <Yuanjie.Huang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CB7B51A00E9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 16:55:03 +1000 (AEST)
From: Yuanjie Huang <Yuanjie.Huang@windriver.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Scott Wood
 <scottwood@freescale.com>, <linuxppc-dev@lists.ozlabs.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH] powerpc/fsl_book3e: fix the relocatable bug in debug
 interrupt handler
Date: Fri, 7 Aug 2015 14:58:10 +0800
Message-ID: <1438930690-28046-1-git-send-email-Yuanjie.Huang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PowerPC Book3E processor features hardware-supported single instruction
execution, and it is used for ptrace(PTRACE_SINGLESTEP, ...). When a debugger
loads a debuggee, it typically sets the CPU to yield debug interrupt on first
instruction complete or branch taken. However, the newly-forked child process
could run into instruction TLB miss exception handler when switched to, and
causes a debug interrupt in the exception entry sequence. This is not expected
by caller of ptrace(PTRACE_SINGLESTEP, ...), so the next instruction address
saved in DSRR0 is checked against the boundary of exception entry sequence, to
ensure the kernel only process the interrupt as a normal exception if the
address does not fall in the exception entry sequence.  Failure in obtaining
the correct boundary leads to such debug exception handled as from privileged
mode, and causes kernel oops.

The LOAD_REG_IMMEDIATE can't be used to load the boundary addresses when
relocatable enabled, so this patch replace them with LOAD_REG_ADDR_PIC. LR is
backed up and restored before and after calling LOAD_REG_ADDR_PIC, because
LOAD_REG_ADDR_PIC clobbers it.

Signed-off-by: Yuanjie Huang <Yuanjie.Huang@windriver.com>
---
 arch/powerpc/kernel/exceptions-64e.S | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 3e68d1c..c475f569 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -735,12 +735,24 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	andis.	r15,r14,(DBSR_IC|DBSR_BT)@h
 	beq+	1f
 
+#ifdef CONFIG_RELOCATABLE
+	mflr	r14
+	LOAD_REG_ADDR_PIC(r15,interrupt_base_book3e)
+	mtlr	r14
+	cmpld	cr0,r10,r15
+	blt+	cr0,1f
+	LOAD_REG_ADDR_PIC(r15,interrupt_end_book3e)
+	mtlr	r14
+	cmpld	cr0,r10,r15
+	bge+	cr0,1f
+#else
 	LOAD_REG_IMMEDIATE(r14,interrupt_base_book3e)
 	LOAD_REG_IMMEDIATE(r15,interrupt_end_book3e)
 	cmpld	cr0,r10,r14
 	cmpld	cr1,r10,r15
 	blt+	cr0,1f
 	bge+	cr1,1f
+#endif
 
 	/* here it looks like we got an inappropriate debug exception. */
 	lis	r14,(DBSR_IC|DBSR_BT)@h		/* clear the event */
@@ -799,12 +811,24 @@ kernel_dbg_exc:
 	andis.	r15,r14,(DBSR_IC|DBSR_BT)@h
 	beq+	1f
 
+#ifdef CONFIG_RELOCATABLE
+	mflr	r14
+	LOAD_REG_ADDR_PIC(r15,interrupt_base_book3e)
+	mtlr	r14
+	cmpld	cr0,r10,r15
+	blt+	cr0,1f
+	LOAD_REG_ADDR_PIC(r15,interrupt_end_book3e)
+	mtlr	r14
+	cmpld	cr0,r10,r15
+	bge+	cr0,1f
+#else
 	LOAD_REG_IMMEDIATE(r14,interrupt_base_book3e)
 	LOAD_REG_IMMEDIATE(r15,interrupt_end_book3e)
 	cmpld	cr0,r10,r14
 	cmpld	cr1,r10,r15
 	blt+	cr0,1f
 	bge+	cr1,1f
+#endif
 
 	/* here it looks like we got an inappropriate debug exception. */
 	lis	r14,(DBSR_IC|DBSR_BT)@h		/* clear the event */
-- 
2.5.0
