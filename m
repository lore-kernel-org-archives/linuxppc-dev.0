Return-Path: <anton@samba.org>
Date: Fri, 25 Nov 2011 16:47:05 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, miltonm@bga.com
Subject: [PATCH] powerpc: Atomically output each stack frame line in show_stack
Message-ID: <20111125164705.78eb9da8@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Milton Miller <miltonm@bga.com>

show_stack uses up to 4 printks per line and other CPUs using printk
can corrupt the output. This patch calls printk once per stack frame
line to produce more readable output.

Signed-off-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/kernel/process.c
===================================================================
--- linux-build.orig/arch/powerpc/kernel/process.c	2011-11-25
16:44:06.548045629 +1100 +++
linux-build/arch/powerpc/kernel/process.c	2011-11-25
16:44:07.944070260 +1100 @@ -1147,7 +1147,7 @@ void show_stack(struct
task_struct *tsk, { unsigned long sp, ip, lr, newsp;
 	int count = 0;
-	int firstframe = 1;
+	char *firstframe = " (unreliable)";
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	int curr_frame = current->curr_ret_stack;
 	extern void return_to_handler(void);
@@ -1180,20 +1180,20 @@ void show_stack(struct task_struct *tsk,
 		stack = (unsigned long *) sp;
 		newsp = stack[0];
 		ip = stack[STACK_FRAME_LR_SAVE];
-		if (!firstframe || ip != lr) {
-			printk("["REG"] ["REG"] %pS", sp, ip, (void
*)ip);
+		if (!firstframe[0] || ip != lr) {
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 			if ((ip == rth || ip == mrth) && curr_frame >=
0) {
-				printk(" (%pS)",
-				       (void
*)current->ret_stack[curr_frame].ret);
+				printk("["REG"] ["REG"] %pS
(%pS)%s\n", sp, ip,
+				       (void *)ip, (void *)
+
current->ret_stack[curr_frame].ret,
+				       firstframe);
 				curr_frame--;
-			}
+			} else
 #endif
-			if (firstframe)
-				printk(" (unreliable)");
-			printk("\n");
+				printk("["REG"] ["REG"] %pS%s\n", sp,
ip,
+				       (void *)ip, firstframe);
 		}
-		firstframe = 0;
+		firstframe = "";
 
 		/*
 		 * See if this is an exception frame.
@@ -1206,7 +1206,7 @@ void show_stack(struct task_struct *tsk,
 			lr = regs->link;
 			printk("--- Exception: %lx at %pS\n    LR =
%pS\n", regs->trap, (void *)regs->nip, (void *)lr);
-			firstframe = 1;
+			firstframe = " (unreliable)";
 		}
 
 		sp = newsp;
