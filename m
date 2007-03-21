Return-Path: <anton@ozlabs.org>
Message-Id: <20070321013824.959599000@samba.org>
References: <20070321013810.404636000@samba.org>
Date: Tue, 20 Mar 2007 20:38:13 -0500
From: anton@samba.org
To: linuxppc-dev@ozlabs.org
Subject: [patch 03/10] Handle recursive oopses
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Handle recursive oopses, like on x86. We had a few cases recently where 
we locked up in oops printing and didnt make it into crashdump.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/arch/powerpc/kernel/traps.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/traps.c	2007-03-11 10:34:44.000000000 -0500
+++ linux-2.6/arch/powerpc/kernel/traps.c	2007-03-11 11:03:11.000000000 -0500
@@ -108,42 +108,62 @@
 static inline void pmac_backlight_unblank(void) { }
 #endif
 
-static DEFINE_SPINLOCK(die_lock);
-
 int die(const char *str, struct pt_regs *regs, long err)
 {
+	static struct {
+		spinlock_t lock;
+		u32 lock_owner;
+		int lock_owner_depth;
+	} die = {
+		.lock =			__SPIN_LOCK_UNLOCKED(die.lock),
+		.lock_owner =		-1,
+		.lock_owner_depth =	0
+	};
 	static int die_counter;
+	unsigned long flags;
 
 	if (debugger(regs))
 		return 1;
 
 	oops_enter();
 
-	console_verbose();
-	spin_lock_irq(&die_lock);
-	bust_spinlocks(1);
-	if (machine_is(powermac))
-		pmac_backlight_unblank();
+	if (die.lock_owner != raw_smp_processor_id()) {
+		console_verbose();
+		spin_lock_irqsave(&die.lock, flags);
+		die.lock_owner = smp_processor_id();
+		die.lock_owner_depth = 0;
+		bust_spinlocks(1);
+		if (machine_is(powermac))
+			pmac_backlight_unblank();
+	} else {
+		local_save_flags(flags);
+	}
 
-	printk("Oops: %s, sig: %ld [#%d]\n", str, err, ++die_counter);
+	if (++die.lock_owner_depth < 3) {
+		printk("Oops: %s, sig: %ld [#%d]\n", str, err, ++die_counter);
 #ifdef CONFIG_PREEMPT
-	printk("PREEMPT ");
+		printk("PREEMPT ");
 #endif
 #ifdef CONFIG_SMP
-	printk("SMP NR_CPUS=%d ", NR_CPUS);
+		printk("SMP NR_CPUS=%d ", NR_CPUS);
 #endif
 #ifdef CONFIG_DEBUG_PAGEALLOC
-	printk("DEBUG_PAGEALLOC ");
+		printk("DEBUG_PAGEALLOC ");
 #endif
 #ifdef CONFIG_NUMA
-	printk("NUMA ");
+		printk("NUMA ");
 #endif
-	printk("%s\n", ppc_md.name ? "" : ppc_md.name);
+		printk("%s\n", ppc_md.name ? "" : ppc_md.name);
+
+		print_modules();
+		show_regs(regs);
+	} else {
+		printk("Recursive die() failure, output suppressed\n");
+	}
 
-	print_modules();
-	show_regs(regs);
 	bust_spinlocks(0);
-	spin_unlock_irq(&die_lock);
+	die.lock_owner = -1;
+	spin_unlock_irqrestore(&die.lock, flags);
 
 	if (kexec_should_crash(current) ||
 		kexec_sr_activated(smp_processor_id()))

--
