Return-Path: <dougmill@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D9EBE1A0C6B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2015 23:32:17 +1100 (AEDT)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dougmill@linux.vnet.ibm.com>;
 Thu, 19 Nov 2015 07:32:14 -0500
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 957BEC9003C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2015 07:20:21 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAJCWBKg51118136
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2015 12:32:11 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAJCUEgR032133
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2015 07:30:15 -0500
From: Douglas Miller <dougmill@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Douglas Miller <dougmill@linux.vnet.ibm.com>
Subject: [PATCH] Add xmon command to dump process/task similar to ps(1)
Date: Thu, 19 Nov 2015 06:31:58 -0600
Message-Id: <1447936318-18487-2-git-send-email-dougmill@linux.vnet.ibm.com>
In-Reply-To: <1447936318-18487-1-git-send-email-dougmill@linux.vnet.ibm.com>
References: <1447936318-18487-1-git-send-email-dougmill@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Douglas Miller <dougmill@linux.vnet.ibm.com>
---
 arch/powerpc/xmon/xmon.c |   58 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 13c6e20..5c24f55 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -149,6 +149,7 @@ static int  cpu_cmd(void);
 static void csum(void);
 static void bootcmds(void);
 static void proccall(void);
+static void proclist(void);
 void dump_segments(void);
 static void symbol_lookup(void);
 static void xmon_show_stack(unsigned long sp, unsigned long lr,
@@ -191,6 +192,24 @@ extern void xmon_leave(void);
 			 || ('A' <= (c) && (c) <= 'Z'))
 #define isspace(c)	(c == ' ' || c == '\t' || c == 10 || c == 13 || c == 0)
 
+/*
+ * Wrap a statement (typically function call) in setjmp to
+ * protect it from memory access errors. msg... are printf
+ * fmt+args used if error is trapped.
+ */
+#define XMON_PROTECT(stmt, msg...) 		\
+	if (setjmp(bus_error_jmp) != 0) {	\
+		catch_memory_errors = 0;	\
+		printf(msg);			\
+	} else {				\
+		catch_memory_errors = 1;	\
+		sync();				\
+		stmt;				\
+		sync();				\
+		__delay(200);			\
+		catch_memory_errors = 0;	\
+	}
+
 static char *help_string = "\
 Commands:\n\
   b	show breakpoints\n\
@@ -228,6 +247,7 @@ Commands:\n\
   mz	zero a block of memory\n\
   mi	show information about memory allocation\n\
   p 	call a procedure\n\
+  P 	list processes/tasks\n\
   r	print registers\n\
   s	single step\n"
 #ifdef CONFIG_SPU_BASE
@@ -947,6 +967,9 @@ cmds(struct pt_regs *excp)
 		case 'p':
 			proccall();
 			break;
+		case 'P':
+			proclist();
+			break;
 #ifdef CONFIG_PPC_STD_MMU
 		case 'u':
 			dump_segments();
@@ -2450,6 +2473,41 @@ memzcan(void)
 		printf("%.8x\n", a - mskip);
 }
 
+static void procshow(struct task_struct *tsk)
+{
+	char state;
+
+	state = (tsk->state == 0) ? 'R' :
+		(tsk->state < 0) ? 'U' :
+		(tsk->state & TASK_UNINTERRUPTIBLE) ? 'D' :
+		(tsk->state & TASK_STOPPED) ? 'T' :
+		(tsk->state & TASK_TRACED) ? 'C' :
+		(tsk->exit_state & EXIT_ZOMBIE) ? 'Z' :
+		(tsk->exit_state & EXIT_DEAD) ? 'E' :
+		(tsk->state & TASK_INTERRUPTIBLE) ? 'S' : '?';
+
+	printf("%p %016lx %6d %6d %c %2d %s\n", tsk,
+		tsk->thread.ksp,
+		tsk->pid, tsk->parent->pid,
+		state, task_thread_info(tsk)->cpu,
+		tsk->comm);
+}
+
+static void proclist(void)
+{
+	unsigned long tskv;
+	struct task_struct *tsk;
+
+	if (scanhex(&tskv)) {
+		tsk = (struct task_struct *)tskv;
+		XMON_PROTECT(procshow(tsk), "*** Error dumping task %p\n", tsk);
+	} else {
+		for_each_process(tsk) {
+			XMON_PROTECT(procshow(tsk), "*** Error dumping task %p\n", tsk);
+		}
+	}
+}
+
 static void proccall(void)
 {
 	unsigned long args[8];
-- 
1.7.1
