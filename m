Return-Path: <aik@ozlabs.ru>
Received: from mail-ie0-f175.google.com (mail-ie0-f175.google.com
 [209.85.223.175])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A238A2C01FA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2013 17:29:29 +1100 (EST)
Received: by mail-ie0-f175.google.com with SMTP id qd14so1874720ieb.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 22:29:26 -0800 (PST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: added DSCR support to ptrace
Date: Fri, 11 Jan 2013 17:29:09 +1100
Message-Id: <1357885749-14042-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Neuling <mikey@neuling.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
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

The patch does not increase PT_REGS_COUNT as the pt_regs struct has not
been changed.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/uapi/asm/ptrace.h |    1 +
 arch/powerpc/kernel/ptrace.c           |   29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/include/uapi/asm/ptrace.h
index ee67a2b..5a4863c 100644
--- a/arch/powerpc/include/uapi/asm/ptrace.h
+++ b/arch/powerpc/include/uapi/asm/ptrace.h
@@ -108,6 +108,7 @@ struct pt_regs {
 #define PT_DAR	41
 #define PT_DSISR 42
 #define PT_RESULT 43
+#define PT_DSCR 44
 #define PT_REGS_COUNT 44
 
 #define PT_FPR0	48	/* each FP reg occupies 2 slots in this space */
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index d4afccc..245c1b6 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -179,6 +179,30 @@ static int set_user_msr(struct task_struct *task, unsigned long msr)
 	return 0;
 }
 
+#ifdef CONFIG_PPC64
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
+#else
+static unsigned long get_user_dscr(struct task_struct *task)
+{
+	return -EIO;
+}
+
+static int set_user_dscr(struct task_struct *task, unsigned long dscr)
+{
+	return -EIO;
+}
+#endif
+
 /*
  * We prevent mucking around with the reserved area of trap
  * which are used internally by the kernel.
@@ -200,6 +224,9 @@ unsigned long ptrace_get_reg(struct task_struct *task, int regno)
 	if (regno == PT_MSR)
 		return get_user_msr(task);
 
+	if (regno == PT_DSCR)
+		return get_user_dscr(task);
+
 	if (regno < (sizeof(struct pt_regs) / sizeof(unsigned long)))
 		return ((unsigned long *)task->thread.regs)[regno];
 
@@ -218,6 +245,8 @@ int ptrace_put_reg(struct task_struct *task, int regno, unsigned long data)
 		return set_user_msr(task, data);
 	if (regno == PT_TRAP)
 		return set_user_trap(task, data);
+	if (regno == PT_DSCR)
+		return set_user_dscr(task, data);
 
 	if (regno <= PT_MAX_PUT_REG) {
 		((unsigned long *)task->thread.regs)[regno] = data;
-- 
1.7.10.4
