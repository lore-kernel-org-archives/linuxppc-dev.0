Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 525A8DDD1C
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2009 05:51:30 +1100 (EST)
Date: Tue, 17 Feb 2009 12:51:22 -0600
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC/PATCH] powerpc: provide APIs for validating and updating DABR
Message-ID: <20090217125122.5bbf713b@thinkcentre.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A checkpointed task image may specify a value for the DABR (Data
Access Breakpoint Register).  The restart code needs to validate this
value before making any changes to the current task.

ptrace_set_debugreg encapsulates the bounds checking and platform
dependencies of programming the DABR.  Split this into "validate"
(debugreg_valid) and "update" (debugreg_update) functions, and make
them available for use outside of the ptrace code.

Also ptrace_set_debugreg has extern linkage, but no users outside of
ptrace.c.  Make it static.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---
 arch/powerpc/include/asm/ptrace.h |    6 +++
 arch/powerpc/kernel/ptrace.c      |   68 ++++++++++++++++++++----------------
 2 files changed, 44 insertions(+), 30 deletions(-)

Is something like this okay to carry in the checkpoint/restart patches?


diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index c9c678f..1b3a5f0 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -81,6 +81,8 @@ struct pt_regs {
 
 #ifndef __ASSEMBLY__
 
+#include <linux/types.h>
+
 #define instruction_pointer(regs) ((regs)->nip)
 #define user_stack_pointer(regs) ((regs)->gpr[1])
 #define regs_return_value(regs) ((regs)->gpr[3])
@@ -138,6 +140,10 @@ do {									      \
 extern void user_enable_single_step(struct task_struct *);
 extern void user_disable_single_step(struct task_struct *);
 
+/* for reprogramming DABR/DAC during restart of a checkpointed task */
+extern bool debugreg_valid(unsigned long val);
+extern void debugreg_update(struct task_struct *task, unsigned long val);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 3635be6..60259c6 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -735,22 +735,13 @@ void user_disable_single_step(struct task_struct *task)
 	clear_tsk_thread_flag(task, TIF_SINGLESTEP);
 }
 
-int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
-			       unsigned long data)
+bool debugreg_valid(unsigned long val)
 {
-	/* For ppc64 we support one DABR and no IABR's at the moment (ppc64).
-	 *  For embedded processors we support one DAC and no IAC's at the
-	 *  moment.
-	 */
-	if (addr > 0)
-		return -EINVAL;
-
 	/* The bottom 3 bits in dabr are flags */
-	if ((data & ~0x7UL) >= TASK_SIZE)
-		return -EIO;
+	if ((val & ~0x7UL) >= TASK_SIZE)
+		return false;
 
 #ifndef CONFIG_BOOKE
-
 	/* For processors using DABR (i.e. 970), the bottom 3 bits are flags.
 	 *  It was assumed, on previous implementations, that 3 bits were
 	 *  passed together with the data address, fitting the design of the
@@ -764,47 +755,64 @@ int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
 	 */
 
 	/* Ensure breakpoint translation bit is set */
-	if (data && !(data & DABR_TRANSLATION))
-		return -EIO;
-
-	/* Move contents to the DABR register */
-	task->thread.dabr = data;
-
-#endif
-#if defined(CONFIG_BOOKE)
-
+	if (val && !(val & DABR_TRANSLATION))
+		return false;
+#else
 	/* As described above, it was assumed 3 bits were passed with the data
 	 *  address, but we will assume only the mode bits will be passed
 	 *  as to not cause alignment restrictions for DAC-based processors.
 	 */
 
+	/* Read or Write bits must be set */
+	if (!(val & 0x3UL))
+		return -EINVAL;
+#endif
+	return true;
+}
+
+void debugreg_update(struct task_struct *task, unsigned long val)
+{
+#ifndef CONFIG_BOOKE
+	task->thread.dabr = val;
+#else
 	/* DAC's hold the whole address without any mode flags */
-	task->thread.dabr = data & ~0x3UL;
+	task->thread.dabr = val & ~0x3UL;
 
 	if (task->thread.dabr == 0) {
 		task->thread.dbcr0 &= ~(DBSR_DAC1R | DBSR_DAC1W | DBCR0_IDM);
 		task->thread.regs->msr &= ~MSR_DE;
-		return 0;
 	}
 
-	/* Read or Write bits must be set */
-
-	if (!(data & 0x3UL))
-		return -EINVAL;
-
 	/* Set the Internal Debugging flag (IDM bit 1) for the DBCR0
 	   register */
 	task->thread.dbcr0 = DBCR0_IDM;
 
 	/* Check for write and read flags and set DBCR0
 	   accordingly */
-	if (data & 0x1UL)
+	if (val & 0x1UL)
 		task->thread.dbcr0 |= DBSR_DAC1R;
-	if (data & 0x2UL)
+	if (val & 0x2UL)
 		task->thread.dbcr0 |= DBSR_DAC1W;
 
 	task->thread.regs->msr |= MSR_DE;
 #endif
+}
+
+static int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
+			       unsigned long data)
+{
+	/* For ppc64 we support one DABR and no IABR's at the moment (ppc64).
+	 *  For embedded processors we support one DAC and no IAC's at the
+	 *  moment.
+	 */
+	if (addr > 0)
+		return -EINVAL;
+
+	if (!debugreg_valid(data))
+		return -EIO;
+
+	debugreg_update(task, data);
+
 	return 0;
 }
 
-- 
1.6.0.6
