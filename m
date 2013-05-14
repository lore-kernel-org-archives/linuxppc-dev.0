Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0252.outbound.messaging.microsoft.com [213.199.154.252])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 67E9B2C009E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 May 2013 10:15:07 +1000 (EST)
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/booke64: fix kernel hangs at kernel_dbg_exc
Date: Mon, 13 May 2013 19:14:53 -0500
Message-ID: <1368490493-24606-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

MSR_DE is not cleared on entry to the kernel, and we don't clear it
explicitly outside of debug code.  If we have MSR_DE set in
prime_debug_regs(), and the new thread has events enabled in DBCR0
(e.g.  ICMP is set in thread->dbsr0, even though it was cleared in the
real DBCR0 when the thread got scheduled out), we'll end up taking a
debug exception in the kernel when DBCR0 is loaded.  DSRR0 will not
point to an exception vector, and the kernel ends up hanging at
kernel_dbg_exc.  Fix this by always clearing MSR_DE when we load new
debug state.

Another observed source of kernel_dbg_exc hangs is with the branch
taken event.  If this event is active, but we take a non-debug trap
(e.g. a TLB miss or an asynchronous interrupt) before the next branch.
We end up taking a branch-taken debug exception on the initial branch
instruction of the exception vector, but because the debug exception is
DBSR_BT rather than DBSR_IC we branch to kernel_dbg_exc before even
checking the DSRR0 address.  Fix this by checking for DBSR_BT as well
as DBSR_IC, which is what 32-bit does and what the comments suggest was
intended in the 64-bit code as well.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kernel/exceptions-64e.S |    8 ++++----
 arch/powerpc/kernel/process.c        |    7 +++++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 42a756e..645170a 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -489,7 +489,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	 */
 
 	mfspr	r14,SPRN_DBSR		/* check single-step/branch taken */
-	andis.	r15,r14,DBSR_IC@h
+	andis.	r15,r14,(DBSR_IC|DBSR_BT)@h
 	beq+	1f
 
 	LOAD_REG_IMMEDIATE(r14,interrupt_base_book3e)
@@ -500,7 +500,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	bge+	cr1,1f
 
 	/* here it looks like we got an inappropriate debug exception. */
-	lis	r14,DBSR_IC@h		/* clear the IC event */
+	lis	r14,(DBSR_IC|DBSR_BT)@h		/* clear the event */
 	rlwinm	r11,r11,0,~MSR_DE	/* clear DE in the CSRR1 value */
 	mtspr	SPRN_DBSR,r14
 	mtspr	SPRN_CSRR1,r11
@@ -555,7 +555,7 @@ kernel_dbg_exc:
 	 */
 
 	mfspr	r14,SPRN_DBSR		/* check single-step/branch taken */
-	andis.	r15,r14,DBSR_IC@h
+	andis.	r15,r14,(DBSR_IC|DBSR_BT)@h
 	beq+	1f
 
 	LOAD_REG_IMMEDIATE(r14,interrupt_base_book3e)
@@ -566,7 +566,7 @@ kernel_dbg_exc:
 	bge+	cr1,1f
 
 	/* here it looks like we got an inappropriate debug exception. */
-	lis	r14,DBSR_IC@h		/* clear the IC event */
+	lis	r14,(DBSR_IC|DBSR_BT)@h		/* clear the event */
 	rlwinm	r11,r11,0,~MSR_DE	/* clear DE in the DSRR1 value */
 	mtspr	SPRN_DBSR,r14
 	mtspr	SPRN_DSRR1,r11
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index ceb4e7b..912fe3c 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -339,6 +339,13 @@ static void set_debug_reg_defaults(struct thread_struct *thread)
 
 static void prime_debug_regs(struct thread_struct *thread)
 {
+	/*
+	 * We could have inherited MSR_DE from userspace, since
+	 * it doesn't get cleared on exception entry.  Make sure
+	 * MSR_DE is clear before we enable any debug events.
+	 */
+	mtmsr(mfmsr() & ~MSR_DE);
+
 	mtspr(SPRN_IAC1, thread->iac1);
 	mtspr(SPRN_IAC2, thread->iac2);
 #if CONFIG_PPC_ADV_DEBUG_IACS > 2
-- 
1.7.10.4
