Return-Path: <aik@ozlabs.ru>
Received: from mail-ia0-f179.google.com (mail-ia0-f179.google.com
 [209.85.210.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 91D032C008D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2012 16:34:14 +1100 (EST)
Received: by mail-ia0-f179.google.com with SMTP id o25so1585022iad.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2012 21:34:11 -0800 (PST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: added DSCR support to ptrace
Date: Thu, 13 Dec 2012 16:34:00 +1100
Message-Id: <1355376840-9287-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The DSCR (aka Data Stream Control Register) is supported on some
server PowerPC chips and allow some control over the prefetch
of data streams.

The kernel already supports DSCR value per thread but there is also
a need in a ability to change it from an external process for
the specific pid.

The patch adds new register index PT_DSCR (index=44) which can be
set/get by:
  ptrace(PTRACE_POKEUSER, traced_process, PT_DSCR << 3, dscr);
  dscr = ptrace(PTRACE_PEEKUSER, traced_process, PT_DSCR << 3, NULL);

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/ptrace.h |    1 +
 arch/powerpc/kernel/ptrace.c      |   17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index 9c21ed4..340fe36 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -276,6 +276,7 @@ static inline unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs,
 #define PT_DAR	41
 #define PT_DSISR 42
 #define PT_RESULT 43
+#define PT_DSCR 44
 #define PT_REGS_COUNT 44
 
 #define PT_FPR0	48	/* each FP reg occupies 2 slots in this space */
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index c10fc28..aa19389 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -179,6 +179,18 @@ static int set_user_msr(struct task_struct *task, unsigned long msr)
 	return 0;
 }
 
+static unsigned long get_user_dscr(struct task_struct *task)
+{
+	return task->thread.dscr;
+}
+
+static int set_user_dscr(struct task_struct *task, unsigned long dscr)
+{
+	task->thread.dscr = dscr;
+	task->thread.dscr_inherit = 1;
+	return 0;
+}
+
 /*
  * We prevent mucking around with the reserved area of trap
  * which are used internally by the kernel.
@@ -200,6 +212,9 @@ unsigned long ptrace_get_reg(struct task_struct *task, int regno)
 	if (regno == PT_MSR)
 		return get_user_msr(task);
 
+	if (regno == PT_DSCR)
+		return get_user_dscr(task);
+
 	if (regno < (sizeof(struct pt_regs) / sizeof(unsigned long)))
 		return ((unsigned long *)task->thread.regs)[regno];
 
@@ -218,6 +233,8 @@ int ptrace_put_reg(struct task_struct *task, int regno, unsigned long data)
 		return set_user_msr(task, data);
 	if (regno == PT_TRAP)
 		return set_user_trap(task, data);
+	if (regno == PT_DSCR)
+		return set_user_dscr(task, data);
 
 	if (regno <= PT_MAX_PUT_REG) {
 		((unsigned long *)task->thread.regs)[regno] = data;
-- 
1.7.10.4
