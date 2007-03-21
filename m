Return-Path: <anton@ozlabs.org>
Message-Id: <20070321013825.490975000@samba.org>
References: <20070321013810.404636000@samba.org>
Date: Tue, 20 Mar 2007 20:38:18 -0500
From: anton@samba.org
To: linuxppc-dev@ozlabs.org
Subject: [patch 08/10] Use notifier hooks for xmon
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Use notifier hooks for xmon and remove all the debugger* junk. Based on
a patch by Ananth N Mavinakayanahalli <ananth@in.ibm.com>

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/arch/powerpc/xmon/xmon.c
===================================================================
--- linux-2.6.orig/arch/powerpc/xmon/xmon.c	2007-03-20 09:53:45.000000000 -0500
+++ linux-2.6/arch/powerpc/xmon/xmon.c	2007-03-20 09:54:03.000000000 -0500
@@ -40,6 +40,7 @@
 #include <asm/spu.h>
 #include <asm/spu_priv1.h>
 #include <asm/firmware.h>
+#include <asm/kdebug.h>
 
 #ifdef CONFIG_PPC64
 #include <asm/hvcall.h>
@@ -2578,38 +2579,91 @@
 }
 #endif
 
-void xmon_init(int enable)
+static int xmon_exceptions_notify(struct notifier_block *self,
+				  unsigned long val, void *data)
+{
+	struct die_args *args = (struct die_args *)data;
+
+	switch (val) {
+		case DIE_OOPS:
+		case DIE_DEBUGGER:
+			if (xmon(args->regs))
+				return NOTIFY_STOP;
+			break;
+		case DIE_IABR_MATCH:
+			if (xmon_iabr_match(args->regs))
+				return NOTIFY_STOP;
+			break;
+		case DIE_DABR_MATCH:
+			if (xmon_dabr_match(args->regs))
+				return NOTIFY_STOP;
+			break;
+		case DIE_BPT:
+			if (xmon_bpt(args->regs))
+				return NOTIFY_STOP;
+			break;
+		case DIE_SSTEP:
+			if (xmon_sstep(args->regs))
+				return NOTIFY_STOP;
+			break;
+		case DIE_PAGE_FAULT:
+			if ((TRAP(args->regs) == 0x300 ||
+			    TRAP(args->regs) == 0x400) &&
+			    xmon_fault_handler(args->regs))
+				return NOTIFY_STOP;
+			break;
+		case DIE_MACHINE_CHECK:
+			if (xmon_fault_handler(args->regs)) {
+				/* XXX doesnt look safe to me */
+				args->regs->msr |= MSR_RI;
+				return NOTIFY_STOP;
+			}
+			break;
+		case DIE_IPI:
+			if (!xmon_ipi(args->regs))
+				return NOTIFY_STOP;
+			break;
+		default:
+			break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+/* XXX What priority should we set? */
+static struct notifier_block xmon_exceptions_nb = {
+	.notifier_call = xmon_exceptions_notify,
+};
+
+static struct notifier_block xmon_page_fault_nb = {
+	.notifier_call = xmon_exceptions_notify,
+};
+
+void xmon_enable(void)
 {
-#ifdef CONFIG_PPC_ISERIES
 	if (firmware_has_feature(FW_FEATURE_ISERIES))
 		return;
-#endif
-	if (enable) {
-		__debugger = xmon;
-		__debugger_ipi = xmon_ipi;
-		__debugger_bpt = xmon_bpt;
-		__debugger_sstep = xmon_sstep;
-		__debugger_iabr_match = xmon_iabr_match;
-		__debugger_dabr_match = xmon_dabr_match;
-		__debugger_fault_handler = xmon_fault_handler;
-	} else {
-		__debugger = NULL;
-		__debugger_ipi = NULL;
-		__debugger_bpt = NULL;
-		__debugger_sstep = NULL;
-		__debugger_iabr_match = NULL;
-		__debugger_dabr_match = NULL;
-		__debugger_fault_handler = NULL;
-	}
+
+	register_die_notifier(&xmon_exceptions_nb);
+	register_page_fault_notifier(&xmon_page_fault_nb);
 	xmon_map_scc();
 }
 
+void xmon_disable(void)
+{
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		return;
+
+	unregister_die_notifier(&xmon_exceptions_nb);
+	unregister_page_fault_notifier(&xmon_page_fault_nb);
+}
+
 #ifdef CONFIG_MAGIC_SYSRQ
 static void sysrq_handle_xmon(int key, struct tty_struct *tty) 
 {
 	/* ensure xmon is enabled */
-	xmon_init(1);
-	debugger(get_irq_regs());
+	xmon_enable();
+	xmon(get_irq_regs());
 }
 
 static struct sysrq_key_op sysrq_xmon_op = 
@@ -2621,10 +2675,8 @@
 
 static int __init setup_xmon_sysrq(void)
 {
-#ifdef CONFIG_PPC_ISERIES
 	if (firmware_has_feature(FW_FEATURE_ISERIES))
 		return 0;
-#endif
 	register_sysrq_key('x', &sysrq_xmon_op);
 	return 0;
 }
@@ -2637,10 +2689,10 @@
 {
 	if (!p || strncmp(p, "early", 5) == 0) {
 		/* just "xmon" is equivalent to "xmon=early" */
-		xmon_init(1);
+		xmon_enable();
 		xmon_early = 1;
 	} else if (strncmp(p, "on", 2) == 0)
-		xmon_init(1);
+		xmon_enable();
 	else if (strncmp(p, "off", 3) == 0)
 		xmon_off = 1;
 	else if (strncmp(p, "nobt", 4) == 0)
@@ -2656,10 +2708,10 @@
 {
 #ifdef CONFIG_XMON_DEFAULT
 	if (!xmon_off)
-		xmon_init(1);
+		xmon_enable();
 #endif
 	if (xmon_early)
-		debugger(NULL);
+		xmon(NULL);
 }
 
 #ifdef CONFIG_SPU_BASE
Index: linux-2.6/include/asm-powerpc/system.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/system.h	2007-03-20 09:53:58.000000000 -0500
+++ linux-2.6/include/asm-powerpc/system.h	2007-03-20 09:54:03.000000000 -0500
@@ -65,42 +65,6 @@
 struct task_struct;
 struct pt_regs;
 
-#ifdef CONFIG_DEBUGGER
-
-extern int (*__debugger)(struct pt_regs *regs);
-extern int (*__debugger_ipi)(struct pt_regs *regs);
-extern int (*__debugger_bpt)(struct pt_regs *regs);
-extern int (*__debugger_sstep)(struct pt_regs *regs);
-extern int (*__debugger_iabr_match)(struct pt_regs *regs);
-extern int (*__debugger_dabr_match)(struct pt_regs *regs);
-extern int (*__debugger_fault_handler)(struct pt_regs *regs);
-
-#define DEBUGGER_BOILERPLATE(__NAME) \
-static inline int __NAME(struct pt_regs *regs) \
-{ \
-	if (unlikely(__ ## __NAME)) \
-		return __ ## __NAME(regs); \
-	return 0; \
-}
-
-DEBUGGER_BOILERPLATE(debugger)
-DEBUGGER_BOILERPLATE(debugger_ipi)
-DEBUGGER_BOILERPLATE(debugger_bpt)
-DEBUGGER_BOILERPLATE(debugger_sstep)
-DEBUGGER_BOILERPLATE(debugger_iabr_match)
-DEBUGGER_BOILERPLATE(debugger_dabr_match)
-DEBUGGER_BOILERPLATE(debugger_fault_handler)
-
-#else
-static inline int debugger(struct pt_regs *regs) { return 0; }
-static inline int debugger_ipi(struct pt_regs *regs) { return 0; }
-static inline int debugger_bpt(struct pt_regs *regs) { return 0; }
-static inline int debugger_sstep(struct pt_regs *regs) { return 0; }
-static inline int debugger_iabr_match(struct pt_regs *regs) { return 0; }
-static inline int debugger_dabr_match(struct pt_regs *regs) { return 0; }
-static inline int debugger_fault_handler(struct pt_regs *regs) { return 0; }
-#endif
-
 extern int set_dabr(unsigned long dabr);
 extern void print_backtrace(unsigned long *);
 extern void show_regs_log_lvl(struct pt_regs * regs, char * log_lvl);
Index: linux-2.6/arch/powerpc/kernel/traps.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/traps.c	2007-03-20 09:54:01.000000000 -0500
+++ linux-2.6/arch/powerpc/kernel/traps.c	2007-03-20 09:54:03.000000000 -0500
@@ -54,24 +54,6 @@
 #endif
 #include <asm/kexec.h>
 
-#ifdef CONFIG_DEBUGGER
-int (*__debugger)(struct pt_regs *regs);
-int (*__debugger_ipi)(struct pt_regs *regs);
-int (*__debugger_bpt)(struct pt_regs *regs);
-int (*__debugger_sstep)(struct pt_regs *regs);
-int (*__debugger_iabr_match)(struct pt_regs *regs);
-int (*__debugger_dabr_match)(struct pt_regs *regs);
-int (*__debugger_fault_handler)(struct pt_regs *regs);
-
-EXPORT_SYMBOL(__debugger);
-EXPORT_SYMBOL(__debugger_ipi);
-EXPORT_SYMBOL(__debugger_bpt);
-EXPORT_SYMBOL(__debugger_sstep);
-EXPORT_SYMBOL(__debugger_iabr_match);
-EXPORT_SYMBOL(__debugger_dabr_match);
-EXPORT_SYMBOL(__debugger_fault_handler);
-#endif
-
 ATOMIC_NOTIFIER_HEAD(powerpc_die_chain);
 
 int register_die_notifier(struct notifier_block *nb)
@@ -126,9 +108,6 @@
 		       NOTIFY_STOP)
 		return 1;
 
-	if (debugger(regs))
-		return 1;
-
 	oops_enter();
 
 	if (die.lock_owner != raw_smp_processor_id()) {
@@ -383,11 +362,6 @@
 		return;
 	}
 
-	if (debugger_fault_handler(regs)) {
-		regs->msr |= MSR_RI;
-		return;
-	}
-
 	if (check_io_access(regs))
 		return;
 
@@ -539,8 +513,6 @@
 	if (notify_die(DIE_IABR_MATCH, "iabr_match", regs, 5,
 					5, SIGTRAP) == NOTIFY_STOP)
 		return;
-	if (debugger_iabr_match(regs))
-		return;
 	_exception(SIGTRAP, regs, TRAP_BRKPT, regs->nip);
 }
 
@@ -556,8 +528,6 @@
 	if (notify_die(DIE_SSTEP, "single_step", regs, 5,
 					5, SIGTRAP) == NOTIFY_STOP)
 		return;
-	if (debugger_sstep(regs))
-		return;
 
 	_exception(SIGTRAP, regs, TRAP_TRACE, regs->nip);
 }
@@ -798,8 +768,6 @@
 		if (notify_die(DIE_BPT, "breakpoint", regs, 5, 5, SIGTRAP)
 				== NOTIFY_STOP)
 			return;
-		if (debugger_bpt(regs))
-			return;
 
 		if (!(regs->msr & MSR_PR) &&  /* not user-mode */
 		    report_bug(regs->nip) == BUG_TRAP_TYPE_WARN) {
@@ -888,7 +856,7 @@
 {
 	printk(KERN_CRIT "Kernel stack overflow in process %p, r1=%lx\n",
 	       current, regs->gpr[1]);
-	debugger(regs);
+	notify_die(DIE_DEBUGGER, "die", regs, 5, 5, SIGSEGV);
 	show_regs(regs);
 	panic("kernel stack overflow");
 }
@@ -999,8 +967,6 @@
 			if (notify_die(DIE_SSTEP, "single_step", regs, 5, 5,
 				       SIGTRAP) == NOTIFY_STOP)
 				return;
-			if (debugger_sstep(regs))
-				return;
 		}
 		_exception(SIGTRAP, regs, TRAP_TRACE, 0);
 	}
Index: linux-2.6/arch/powerpc/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/powerpc/mm/fault.c	2007-03-20 09:54:02.000000000 -0500
+++ linux-2.6/arch/powerpc/mm/fault.c	2007-03-20 09:54:03.000000000 -0500
@@ -115,9 +115,6 @@
 			11, SIGSEGV) == NOTIFY_STOP)
 		return;
 
-	if (debugger_dabr_match(regs))
-		return;
-
 	/* Clear the DABR */
 	set_dabr(0);
 
@@ -173,11 +170,6 @@
 				11, SIGSEGV) == NOTIFY_STOP)
 		return 0;
 
-	if (trap == 0x300) {
-		if (debugger_fault_handler(regs))
-			return 0;
-	}
-
 	/* On a kernel SLB miss we can only check for a valid exception entry */
 	if (!user_mode(regs) && (address >= TASK_SIZE))
 		return SIGSEGV;
Index: linux-2.6/arch/powerpc/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/smp.c	2007-03-20 09:53:19.000000000 -0500
+++ linux-2.6/arch/powerpc/kernel/smp.c	2007-03-20 09:54:03.000000000 -0500
@@ -45,6 +45,7 @@
 #include <asm/system.h>
 #include <asm/mpic.h>
 #include <asm/vdso_datapage.h>
+#include <asm/kdebug.h>
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
 #endif
@@ -108,10 +109,9 @@
 			crash_ipi_function_ptr(get_irq_regs());
 			break;
 		}
-#ifdef CONFIG_DEBUGGER
-		debugger_ipi(get_irq_regs());
-		break;
-#endif /* CONFIG_DEBUGGER */
+		if (notify_die(DIE_IPI, "smp_call_function",
+			       get_irq_regs(), 5, 5, SIGSEGV) == NOTIFY_STOP)
+			break;
 		/* FALLTHROUGH */
 	default:
 		printk("SMP %d: smp_message_recv(): unknown msg %d\n",
@@ -233,7 +233,8 @@
 			printk("smp_call_function on cpu %d: other cpus not "
 			       "responding (%d)\n", smp_processor_id(),
 			       atomic_read(&data.started));
-			debugger(NULL);
+			notify_die(DIE_DEBUGGER, "smp_call_function",
+				   NULL, 5, 5, SIGSEGV);
 			goto out;
 		}
 	}
@@ -247,7 +248,8 @@
 				       smp_processor_id(),
 				       atomic_read(&data.finished),
 				       atomic_read(&data.started));
-				debugger(NULL);
+				notify_die(DIE_DEBUGGER, "smp_call_function",
+					   NULL, 5, 5, SIGSEGV);
 				goto out;
 			}
 		}
Index: linux-2.6/include/asm-powerpc/kdebug.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/kdebug.h	2007-03-20 09:54:02.000000000 -0500
+++ linux-2.6/include/asm-powerpc/kdebug.h	2007-03-20 09:54:03.000000000 -0500
@@ -31,6 +31,8 @@
 	DIE_SSTEP,
 	DIE_PAGE_FAULT,
 	DIE_MACHINE_CHECK,
+	DIE_IPI,
+	DIE_DEBUGGER,
 };
 
 static inline int notify_die(enum die_val val, const char *str,

--
