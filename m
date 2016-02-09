Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B6C281A02BF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 21:58:24 +1100 (AEDT)
In-Reply-To: <1448290875-20896-2-git-send-email-dougmill@linux.vnet.ibm.com>
To: Douglas Miller <dougmill@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc/xmon: Add xmon command to dump process/task similar to
 ps(1)
Message-Id: <20160209105824.9231E140B97@ozlabs.org>
Date: Tue,  9 Feb 2016 21:58:24 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-23-11 at 15:01:15 UTC, Douglas Miller wrote:
> Add 'P' command with optional task_struct address to dump all/one task's
> information: task pointer, kernel stack pointer, PID, PPID, state
> (interpreted), CPU where (last) running, and command.
> 
> Introduce XMON_PROTECT macro to standardize memory-access-fault
> protection (setjmp). Initially used only by the 'P' command.

Hi Doug,

Sorry this has taken a while, it keeps getting preempted by more important
patches.

I'm also not a big fan of the protect macro, it works for this case, but it's
already a bit ugly calling for_each_process() inside the macro, and it would be
even worse for multi line logic.

I think I'd rather just open code it, and hopefully we can come up with a
better solution for catching errors in the long run.

I also renamed the routines to use "task", because "proc" in xmon is already
used to mean "procedure", and the struct is task_struct after all.

How does this look?

cheers

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 47e195d66a9a..942796fa4767 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -163,6 +163,7 @@ static int  cpu_cmd(void);
 static void csum(void);
 static void bootcmds(void);
 static void proccall(void);
+static void show_tasks(void);
 void dump_segments(void);
 static void symbol_lookup(void);
 static void xmon_show_stack(unsigned long sp, unsigned long lr,
@@ -238,6 +239,7 @@ Commands:\n\
   mz	zero a block of memory\n\
   mi	show information about memory allocation\n\
   p 	call a procedure\n\
+  P 	list processes/tasks\n\
   r	print registers\n\
   s	single step\n"
 #ifdef CONFIG_SPU_BASE
@@ -967,6 +969,9 @@ cmds(struct pt_regs *excp)
 		case 'p':
 			proccall();
 			break;
+		case 'P':
+			show_tasks();
+			break;
 #ifdef CONFIG_PPC_STD_MMU
 		case 'u':
 			dump_segments();
@@ -2566,6 +2571,61 @@ memzcan(void)
 		printf("%.8x\n", a - mskip);
 }
 
+static void show_task(struct task_struct *tsk)
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
+static void show_tasks(void)
+{
+	unsigned long tskv;
+	struct task_struct *tsk = NULL;
+
+	printf("     task_struct     ->thread.ksp    PID   PPID S  P CMD\n");
+
+	if (scanhex(&tskv))
+		tsk = (struct task_struct *)tskv;
+
+	if (setjmp(bus_error_jmp) != 0) {
+		catch_memory_errors = 0;
+		printf("*** Error dumping task %p\n", tsk);
+		return;
+	}
+
+	catch_memory_errors = 1;
+	sync();
+
+	if (tsk)
+		show_task(tsk);
+	else
+		for_each_process(tsk)
+			show_task(tsk);
+
+	sync();
+	__delay(200);
+	catch_memory_errors = 0;
+}
+
 static void proccall(void)
 {
 	unsigned long args[8];
