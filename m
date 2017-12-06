Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ysHpP1KFxzDrns
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Dec 2017 23:23:41 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/xmon: Don't print hashed pointers in xmon
Date: Wed,  6 Dec 2017 23:23:28 +1100
Message-Id: <20171206122328.913-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
pointers printed with %p are hashed, ie. you don't see the actual
pointer value but rather a cryptographic hash of its value.

In xmon we want to see the actual pointer values, because xmon is a
debugger, so replace %p with %px which prints the actual pointer
value.

We justify doing this in xmon because 1) xmon is a kernel crash
debugger, it's only accessible via the console 2) xmon doesn't print
to dmesg, so the pointers it prints are not able to be leaked that
way.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/xmon/xmon.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 1b2d8cb49abb..cab24f549e7c 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1590,7 +1590,7 @@ static void print_bug_trap(struct pt_regs *regs)
 	printf("kernel BUG at %s:%u!\n",
 	       bug->file, bug->line);
 #else
-	printf("kernel BUG at %p!\n", (void *)bug->bug_addr);
+	printf("kernel BUG at %px!\n", (void *)bug->bug_addr);
 #endif
 #endif /* CONFIG_BUG */
 }
@@ -2329,7 +2329,7 @@ static void dump_one_paca(int cpu)
 
 	p = &paca[cpu];
 
-	printf("paca for cpu 0x%x @ %p:\n", cpu, p);
+	printf("paca for cpu 0x%x @ %px:\n", cpu, p);
 
 	printf(" %-*s = %s\n", 20, "possible", cpu_possible(cpu) ? "yes" : "no");
 	printf(" %-*s = %s\n", 20, "present", cpu_present(cpu) ? "yes" : "no");
@@ -2945,7 +2945,7 @@ static void show_task(struct task_struct *tsk)
 		(tsk->exit_state & EXIT_DEAD) ? 'E' :
 		(tsk->state & TASK_INTERRUPTIBLE) ? 'S' : '?';
 
-	printf("%p %016lx %6d %6d %c %2d %s\n", tsk,
+	printf("%px %016lx %6d %6d %c %2d %s\n", tsk,
 		tsk->thread.ksp,
 		tsk->pid, tsk->parent->pid,
 		state, task_thread_info(tsk)->cpu,
@@ -2988,7 +2988,7 @@ static void show_pte(unsigned long addr)
 
 	if (setjmp(bus_error_jmp) != 0) {
 		catch_memory_errors = 0;
-		printf("*** Error dumping pte for task %p\n", tsk);
+		printf("*** Error dumping pte for task %px\n", tsk);
 		return;
 	}
 
@@ -3074,7 +3074,7 @@ static void show_tasks(void)
 
 	if (setjmp(bus_error_jmp) != 0) {
 		catch_memory_errors = 0;
-		printf("*** Error dumping task %p\n", tsk);
+		printf("*** Error dumping task %px\n", tsk);
 		return;
 	}
 
-- 
2.14.3
