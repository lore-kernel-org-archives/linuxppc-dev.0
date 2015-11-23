Return-Path: <dougmill@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B238D1A0404
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 02:01:38 +1100 (AEDT)
Received: from localhost
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dougmill@linux.vnet.ibm.com>;
 Mon, 23 Nov 2015 08:01:35 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id E476C1FF0021
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 07:49:44 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id tANF1XKH20906054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 08:01:33 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tANF1WxS030974
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 08:01:32 -0700
Received: from oc5780617838.ibm.com ([9.80.96.161])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 tANF1V3J030737
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 08:01:32 -0700
From: Douglas Miller <dougmill@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/xmon: Add xmon command to dump process/task similar
 to ps(1)
Date: Mon, 23 Nov 2015 09:01:15 -0600
Message-Id: <1448290875-20896-2-git-send-email-dougmill@linux.vnet.ibm.com>
In-Reply-To: <1448290875-20896-1-git-send-email-dougmill@linux.vnet.ibm.com>
References: <1448290875-20896-1-git-send-email-dougmill@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add 'P' command with optional task_struct address to dump all/one task's
information: task pointer, kernel stack pointer, PID, PPID, state
(interpreted), CPU where (last) running, and command.

Introduce XMON_PROTECT macro to standardize memory-access-fault
protection (setjmp). Initially used only by the 'P' command.

Signed-off-by: Douglas Miller <dougmill@linux.vnet.ibm.com>
---
 arch/powerpc/xmon/xmon.c |   63 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 13c6e20..8e203f0 100644
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
@@ -2450,6 +2473,46 @@ memzcan(void)
 		printf("%.8x\n", a - mskip);
 }
 
+static void procshow(struct task_struct *tsk)
+{
+	char state;
+
+	/*
+	 * Cloned from kdb_task_state_char(), which is not entirely
+	 * appropriate for calling from xmon. This could be moved
+	 * to a common, generic, routine used by both.
+	 */
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
+	struct task_struct *tsk = NULL;
+
+	printf("     task_struct     ->thread.ksp    PID   PPID S  P CMD\n");
+	if (scanhex(&tskv)) {
+		tsk = (struct task_struct *)tskv;
+		XMON_PROTECT(procshow(tsk), "*** Error dumping task %p\n", tsk);
+	} else {
+		XMON_PROTECT(for_each_process(tsk) procshow(tsk),
+			"*** Error dumping task %p\n", tsk);
+	}
+}
+
 static void proccall(void)
 {
 	unsigned long args[8];
-- 
1.7.1
