Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 07 Jul 2008 13:44:31 +1000
Subject: [PATCH] powerpc: Use new printk extension %pS to print symbols on oops
Message-Id: <20080707034436.BEA2DDDF35@ozlabs.org>
Cc: Linus Torvalds <torvalds@osdl.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This changes the oops and backtrace code to use the new %pS
printk extension to print out symbols rather than manually
calling print_symbol.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 arch/powerpc/kernel/process.c |   14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

--- linux-work.orig/arch/powerpc/kernel/process.c	2008-07-07 10:16:53.000000000 +1000
+++ linux-work/arch/powerpc/kernel/process.c	2008-07-07 11:04:32.000000000 +1000
@@ -484,10 +484,8 @@ void show_regs(struct pt_regs * regs)
 	 * Lookup NIP late so we have the best change of getting the
 	 * above info out without failing
 	 */
-	printk("NIP ["REG"] ", regs->nip);
-	print_symbol("%s\n", regs->nip);
-	printk("LR ["REG"] ", regs->link);
-	print_symbol("%s\n", regs->link);
+	printk("NIP ["REG"] %pS\n", regs->nip, (void *)regs->nip);
+	printk("LR ["REG"] %pS\n", regs->link, (void *)regs->link);
 #endif
 	show_stack(current, (unsigned long *) regs->gpr[1]);
 	if (!user_mode(regs))
@@ -971,8 +969,7 @@ void show_stack(struct task_struct *tsk,
 		newsp = stack[0];
 		ip = stack[STACK_FRAME_LR_SAVE];
 		if (!firstframe || ip != lr) {
-			printk("["REG"] ["REG"] ", sp, ip);
-			print_symbol("%s", ip);
+			printk("["REG"] ["REG"] %pS", sp, ip, (void *)ip);
 			if (firstframe)
 				printk(" (unreliable)");
 			printk("\n");
@@ -987,10 +984,9 @@ void show_stack(struct task_struct *tsk,
 		    && stack[STACK_FRAME_MARKER] == STACK_FRAME_REGS_MARKER) {
 			struct pt_regs *regs = (struct pt_regs *)
 				(sp + STACK_FRAME_OVERHEAD);
-			printk("--- Exception: %lx", regs->trap);
-			print_symbol(" at %s\n", regs->nip);
 			lr = regs->link;
-			print_symbol("    LR = %s\n", lr);
+			printk("--- Exception: %lx at %pS\n    LR = %pS\n",
+			       regs->trap, (void *)regs->nip, (void *)lr);
 			firstframe = 1;
 		}
 
