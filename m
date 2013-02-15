Return-Path: <aik@ozlabs.ru>
Received: from mail-da0-f51.google.com (mail-da0-f51.google.com
 [209.85.210.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BEEFE2C0089
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2013 14:44:40 +1100 (EST)
Received: by mail-da0-f51.google.com with SMTP id n15so1293936dad.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2013 19:44:38 -0800 (PST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: fixing ptrace_get_reg to return an error
Date: Fri, 15 Feb 2013 14:44:23 +1100
Message-Id: <1360899863-17181-1-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1358273835.2782.5.camel@pasglop>
References: <1358273835.2782.5.camel@pasglop>
Cc: Michael Neuling <mikey@neuling.org>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently ptrace_get_reg returns error as a value
what make impossible to tell whether it is a correct value or error code.

The patch adds a parameter which points to the real return data and
returns an error code.

As get_user_msr() never fails and it is used in multiple places so it has not
been changed by this patch.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/ptrace.h |    3 ++-
 arch/powerpc/kernel/ptrace.c      |   29 ++++++++++++++++++-----------
 arch/powerpc/kernel/ptrace32.c    |   15 ++++++++++++---
 3 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index 5f99568..becc08e 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -92,7 +92,8 @@ static inline long regs_return_value(struct pt_regs *regs)
 	} while(0)
 
 struct task_struct;
-extern unsigned long ptrace_get_reg(struct task_struct *task, int regno);
+extern int ptrace_get_reg(struct task_struct *task, int regno,
+			  unsigned long *data);
 extern int ptrace_put_reg(struct task_struct *task, int regno,
 			  unsigned long data);
 
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 245c1b6..d5ff7ea 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -180,9 +180,10 @@ static int set_user_msr(struct task_struct *task, unsigned long msr)
 }
 
 #ifdef CONFIG_PPC64
-static unsigned long get_user_dscr(struct task_struct *task)
+static int get_user_dscr(struct task_struct *task, unsigned long *data)
 {
-	return task->thread.dscr;
+	*data = task->thread.dscr;
+	return 0;
 }
 
 static int set_user_dscr(struct task_struct *task, unsigned long dscr)
@@ -192,7 +193,7 @@ static int set_user_dscr(struct task_struct *task, unsigned long dscr)
 	return 0;
 }
 #else
-static unsigned long get_user_dscr(struct task_struct *task)
+static int get_user_dscr(struct task_struct *task, unsigned long *data)
 {
 	return -EIO;
 }
@@ -216,19 +217,23 @@ static int set_user_trap(struct task_struct *task, unsigned long trap)
 /*
  * Get contents of register REGNO in task TASK.
  */
-unsigned long ptrace_get_reg(struct task_struct *task, int regno)
+int ptrace_get_reg(struct task_struct *task, int regno, unsigned long *data)
 {
-	if (task->thread.regs == NULL)
+	if ((task->thread.regs == NULL) || !data)
 		return -EIO;
 
-	if (regno == PT_MSR)
-		return get_user_msr(task);
+	if (regno == PT_MSR) {
+		*data = get_user_msr(task);
+		return 0;
+	}
 
 	if (regno == PT_DSCR)
-		return get_user_dscr(task);
+		return get_user_dscr(task, data);
 
-	if (regno < (sizeof(struct pt_regs) / sizeof(unsigned long)))
-		return ((unsigned long *)task->thread.regs)[regno];
+	if (regno < (sizeof(struct pt_regs) / sizeof(unsigned long))) {
+		*data = ((unsigned long *)task->thread.regs)[regno];
+		return 0;
+	}
 
 	return -EIO;
 }
@@ -1559,7 +1564,9 @@ long arch_ptrace(struct task_struct *child, long request,
 
 		CHECK_FULL_REGS(child->thread.regs);
 		if (index < PT_FPR0) {
-			tmp = ptrace_get_reg(child, (int) index);
+			ret = ptrace_get_reg(child, (int) index, &tmp);
+			if (ret)
+				break;
 		} else {
 			unsigned int fpidx = index - PT_FPR0;
 
diff --git a/arch/powerpc/kernel/ptrace32.c b/arch/powerpc/kernel/ptrace32.c
index c0244e7..f51599e 100644
--- a/arch/powerpc/kernel/ptrace32.c
+++ b/arch/powerpc/kernel/ptrace32.c
@@ -95,7 +95,9 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 
 		CHECK_FULL_REGS(child->thread.regs);
 		if (index < PT_FPR0) {
-			tmp = ptrace_get_reg(child, index);
+			ret = ptrace_get_reg(child, index, &tmp);
+			if (ret)
+				break;
 		} else {
 			flush_fp_to_thread(child);
 			/*
@@ -148,7 +150,11 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 			tmp = ((u64 *)child->thread.fpr)
 				[FPRINDEX_3264(numReg)];
 		} else { /* register within PT_REGS struct */
-			tmp = ptrace_get_reg(child, numReg);
+			unsigned long tmp2;
+			ret = ptrace_get_reg(child, numReg, &tmp2);
+			if (ret)
+				break;
+			tmp = tmp2;
 		} 
 		reg32bits = ((u32*)&tmp)[part];
 		ret = put_user(reg32bits, (u32 __user *)data);
@@ -232,7 +238,10 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 			break;
 		CHECK_FULL_REGS(child->thread.regs);
 		if (numReg < PT_FPR0) {
-			unsigned long freg = ptrace_get_reg(child, numReg);
+			unsigned long freg;
+			ret = ptrace_get_reg(child, numReg, &freg);
+			if (ret)
+				break;
 			if (index % 2)
 				freg = (freg & ~0xfffffffful) | (data & 0xfffffffful);
 			else
-- 
1.7.10.4
