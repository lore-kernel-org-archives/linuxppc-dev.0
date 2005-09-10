Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17186.49095.634728.107442@cargo.ozlabs.ibm.com>
Date: Sat, 10 Sep 2005 21:13:11 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc32: Kill init on unhandled synchronous signals
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a patch that I have had in my tree for ages.  If init causes
an exception that raises a signal, such as a SIGSEGV, SIGILL or
SIGFPE, and it hasn't registered a handler for it, we don't deliver
the signal, since init doesn't get any signals that it doesn't have a
handler for.  But that means that we just return to userland and
generate the same exception again immediately.  With this patch we
print a message and kill init in this situation.

This is very useful when you have a bug in the kernel that means that
init doesn't get as far as executing its first instruction. :)
Without this patch the system hangs when it gets to starting the
userland init; with it you at least get a message giving you a clue
about what has gone wrong.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff -urx .git linux-2.6/arch/ppc/kernel/traps.c test/arch/ppc/kernel/traps.c
--- linux-2.6/arch/ppc/kernel/traps.c	2005-09-10 09:25:11.000000000 +1000
+++ test/arch/ppc/kernel/traps.c	2005-09-10 19:34:18.000000000 +1000
@@ -118,6 +118,28 @@
 	info.si_code = code;
 	info.si_addr = (void __user *) addr;
 	force_sig_info(signr, &info, current);
+
+	/*
+	 * Init gets no signals that it doesn't have a handler for.
+	 * That's all very well, but if it has caused a synchronous
+	 * exception and we ignore the resulting signal, it will just
+	 * generate the same exception over and over again and we get
+	 * nowhere.  Better to kill it and let the kernel panic.
+	 */
+	if (current->pid == 1) {
+		__sighandler_t handler;
+
+		spin_lock_irq(&current->sighand->siglock);
+		handler = current->sighand->action[signr-1].sa.sa_handler;
+		spin_unlock_irq(&current->sighand->siglock);
+		if (handler == SIG_DFL) {
+			/* init has generated a synchronous exception
+			   and it doesn't have a handler for the signal */
+			printk(KERN_CRIT "init has generated signal %d "
+			       "but has no handler for it\n", signr);
+			do_exit(signr);
+		}
+	}
 }
 
 /*
diff -urx .git linux-2.6/arch/ppc/mm/fault.c test/arch/ppc/mm/fault.c
--- linux-2.6/arch/ppc/mm/fault.c	2005-04-26 15:37:55.000000000 +1000
+++ test/arch/ppc/mm/fault.c	2005-09-10 19:34:19.000000000 +1000
@@ -278,11 +278,7 @@
 
 	/* User mode accesses cause a SIGSEGV */
 	if (user_mode(regs)) {
-		info.si_signo = SIGSEGV;
-		info.si_errno = 0;
-		info.si_code = code;
-		info.si_addr = (void __user *) address;
-		force_sig_info(SIGSEGV, &info, current);
+		_exception(SIGSEGV, regs, code, address);
 		return 0;
 	}
 
diff -urx .git linux-2.6/include/asm-ppc/system.h test/include/asm-ppc/system.h
--- linux-2.6/include/asm-ppc/system.h	2005-09-07 08:51:40.000000000 +1000
+++ test/include/asm-ppc/system.h	2005-09-10 19:34:49.000000000 +1000
@@ -88,6 +88,7 @@
 extern int do_page_fault(struct pt_regs *, unsigned long, unsigned long);
 extern void bad_page_fault(struct pt_regs *, unsigned long, int);
 extern void die(const char *, struct pt_regs *, long);
+extern void _exception(int, struct pt_regs *, int, unsigned long);
 #ifdef CONFIG_BOOKE_WDT
 extern u32 booke_wdt_enabled;
 extern u32 booke_wdt_period;
