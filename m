Return-Path: <anton@samba.org>
Message-Id: <20111130102414.774855009@samba.org>
Date: Wed, 30 Nov 2011 21:23:09 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
 paulus@samba.org,
 hbabu@us.ibm.com
Subject: [PATCH 1/9] powerpc: Give us time to get all oopses out before
 panicking
References: <20111130102308.348262468@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I've been seeing truncated output when people send system reset info
to me. We should see a backtrace for every CPU, but the panic() code
takes the box down before they all make it out to the console. The
panic code runs unlocked so we also see corrupted console output.

If we are going to panic, then delay 1 second before calling into the
panic code. Move oops_exit inside the die lock and put a newline
between oopses for clarity. 

Signed-off-by: Anton Blanchard <anton@samba.org>
---

We should really rename kexec_should_crash() to something like
kernel_will_panic() and use it here. I'll work on that in a follow up
patch.

Index: linux-powerpc/arch/powerpc/kernel/traps.c
===================================================================
--- linux-powerpc.orig/arch/powerpc/kernel/traps.c	2011-07-05 14:21:44.017308041 +1000
+++ linux-powerpc/arch/powerpc/kernel/traps.c	2011-07-05 14:21:52.727459818 +1000
@@ -158,6 +158,8 @@ int die(const char *str, struct pt_regs
 	bust_spinlocks(0);
 	die.lock_owner = -1;
 	add_taint(TAINT_DIE);
+	oops_exit();
+	printk("\n");
 	raw_spin_unlock_irqrestore(&die.lock, flags);
 
 	if (kexec_should_crash(current) ||
@@ -165,13 +167,23 @@ int die(const char *str, struct pt_regs
 		crash_kexec(regs);
 	crash_kexec_secondary(regs);
 
+	/*
+	 * While our oops output is serialised by a spinlock, output
+	 * from panic() called below can race and corrupt it. If we
+	 * know we are going to panic, delay for 1 second so we have a
+	 * chance to get clean backtraces from all CPUs that are oopsing.
+	 */
+	if (in_interrupt() || panic_on_oops || !current->pid ||
+	    is_global_init(current)) {
+		mdelay(MSEC_PER_SEC);
+	}
+
 	if (in_interrupt())
 		panic("Fatal exception in interrupt");
 
 	if (panic_on_oops)
 		panic("Fatal exception");
 
-	oops_exit();
 	do_exit(err);
 
 	return 0;
