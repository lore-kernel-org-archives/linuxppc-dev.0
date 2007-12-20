Return-Path: <roland@redhat.com>
Received: from QMTA04.emeryville.ca.mail.comcast.net
	(qmta04.emeryville.ca.mail.comcast.net [76.96.30.40])
	by ozlabs.org (Postfix) with ESMTP id 98C49DDE38
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 23:02:38 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: Roland McGrath's message of  Thursday,
	20 December 2007 03:52:00 -0800
	<20071220115200.C767E26F98A@magilla.localdomain>
References: <20071220115200.C767E26F98A@magilla.localdomain>
Subject: [PATCH -mm 13/43] powerpc ptrace special regs
Message-Id: <20071220115751.78CE726F98A@magilla.localdomain>
Date: Thu, 20 Dec 2007 03:57:51 -0800 (PST)
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This isolates the ptrace code for the special-case registers msr and trap
from the ptrace-layout dispatch code.  This should inline away completely.
It cleanly separates the low-level machine magic that has to be done for
deep reasons, from the superficial details of the ptrace interface.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 arch/powerpc/kernel/ptrace.c |   45 ++++++++++++++++++++++++++++--------------
 1 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 8c25b00..4edc118 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -60,20 +60,38 @@
 #define PT_MAX_PUT_REG	PT_CCR
 #endif
 
+static unsigned long get_user_msr(struct task_struct *task)
+{
+	return task->thread.regs->msr | task->thread.fpexc_mode;
+}
+
+static int set_user_msr(struct task_struct *task, unsigned long msr)
+{
+	task->thread.regs->msr &= ~MSR_DEBUGCHANGE;
+	task->thread.regs->msr |= msr & MSR_DEBUGCHANGE;
+	return 0;
+}
+
+/*
+ * We prevent mucking around with the reserved area of trap
+ * which are used internally by the kernel.
+ */
+static int set_user_trap(struct task_struct *task, unsigned long trap)
+{
+	task->thread.regs->trap = trap & 0xfff0;
+	return 0;
+}
+
 /*
  * Get contents of register REGNO in task TASK.
  */
 unsigned long ptrace_get_reg(struct task_struct *task, int regno)
 {
-	unsigned long tmp = 0;
-
 	if (task->thread.regs == NULL)
 		return -EIO;
 
-	if (regno == PT_MSR) {
-		tmp = ((unsigned long *)task->thread.regs)[PT_MSR];
-		return tmp | task->thread.fpexc_mode;
-	}
+	if (regno == PT_MSR)
+		return get_user_msr(task);
 
 	if (regno < (sizeof(struct pt_regs) / sizeof(unsigned long)))
 		return ((unsigned long *)task->thread.regs)[regno];
@@ -89,15 +107,12 @@ int ptrace_put_reg(struct task_struct *task, int regno, unsigned long data)
 	if (task->thread.regs == NULL)
 		return -EIO;
 
-	if (regno <= PT_MAX_PUT_REG || regno == PT_TRAP) {
-		if (regno == PT_MSR)
-			data = (data & MSR_DEBUGCHANGE)
-				| (task->thread.regs->msr & ~MSR_DEBUGCHANGE);
-		/* We prevent mucking around with the reserved area of trap
-		 * which are used internally by the kernel
-		 */
-		if (regno == PT_TRAP)
-			data &= 0xfff0;
+	if (regno == PT_MSR)
+		return set_user_msr(task, data);
+	if (regno == PT_TRAP)
+		return set_user_trap(task, data);
+
+	if (regno <= PT_MAX_PUT_REG) {
 		((unsigned long *)task->thread.regs)[regno] = data;
 		return 0;
 	}
-- 
1.5.3.6
