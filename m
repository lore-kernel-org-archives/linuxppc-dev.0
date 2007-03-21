Return-Path: <anton@ozlabs.org>
Message-Id: <20070321013825.283024000@samba.org>
References: <20070321013810.404636000@samba.org>
Date: Tue, 20 Mar 2007 20:38:16 -0500
From: anton@samba.org
To: linuxppc-dev@ozlabs.org
Subject: [patch 06/10] Add notify die hooks and remove some redundant debugger
	hooks
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a DIE_OOPS and DIE_MACHINE_CHECK notify_die hook and remove some
redundant debugger* hooks.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/arch/powerpc/kernel/traps.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/traps.c	2007-03-11 12:11:13.000000000 -0500
+++ linux-2.6/arch/powerpc/kernel/traps.c	2007-03-11 12:40:41.000000000 -0500
@@ -122,6 +122,10 @@
 	static int die_counter;
 	unsigned long flags;
 
+	if (notify_die(DIE_OOPS, str, regs, err, regs->trap, SIGSEGV) ==
+		       NOTIFY_STOP)
+		return 1;
+
 	if (debugger(regs))
 		return 1;
 
@@ -374,6 +378,11 @@
 	return;
 #endif
 
+        if (notify_die(DIE_MACHINE_CHECK, "machine_check", regs, 7, 7,
+		       SIGBUS) == NOTIFY_STOP) {
+		return;
+	}
+
 	if (debugger_fault_handler(regs)) {
 		regs->msr |= MSR_RI;
 		return;
@@ -505,8 +514,6 @@
 	 */
 	platform_machine_check(regs);
 
-	if (debugger_fault_handler(regs))
-		return;
 	die("Machine check", regs, SIGBUS);
 
 	/* Must die if the interrupt is not recoverable */
@@ -890,7 +897,6 @@
 {
 	printk(KERN_ERR "Non-recoverable exception at PC=%lx MSR=%lx\n",
 	       regs->nip, regs->msr);
-	debugger(regs);
 	die("nonrecoverable exception", regs, SIGKILL);
 }
 
@@ -936,10 +942,8 @@
 
 	CHECK_FULL_REGS(regs);
 
-	if (!user_mode(regs)) {
-		debugger(regs);
+	if (!user_mode(regs))
 		die("Kernel Mode Software FPU Emulation", regs, SIGFPE);
-	}
 
 #ifdef CONFIG_MATH_EMULATION
 	errcode = do_mathemu(regs);
@@ -992,6 +996,9 @@
 			mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) & ~DBCR0_IC);
 			/* Clear the instruction completion event */
 			mtspr(SPRN_DBSR, DBSR_IC);
+			if (notify_die(DIE_SSTEP, "single_step", regs, 5, 5,
+				       SIGTRAP) == NOTIFY_STOP)
+				return;
 			if (debugger_sstep(regs))
 				return;
 		}
Index: linux-2.6/include/asm-powerpc/kdebug.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/kdebug.h	2007-03-11 12:36:52.000000000 -0500
+++ linux-2.6/include/asm-powerpc/kdebug.h	2007-03-11 12:37:05.000000000 -0500
@@ -30,6 +30,7 @@
 	DIE_BPT,
 	DIE_SSTEP,
 	DIE_PAGE_FAULT,
+	DIE_MACHINE_CHECK,
 };
 
 static inline int notify_die(enum die_val val,char *str,struct pt_regs *regs,long err,int trap, int sig)

--
