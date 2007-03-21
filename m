Return-Path: <anton@ozlabs.org>
Message-Id: <20070321013825.385423000@samba.org>
References: <20070321013810.404636000@samba.org>
Date: Tue, 20 Mar 2007 20:38:17 -0500
From: anton@samba.org
To: linuxppc-dev@ozlabs.org
Subject: [patch 07/10] Page fault handler should not depend on CONFIG_KPROBES
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Like x86-64, change the page fault notifier code to not depend on
CONFIG_KPROBES and export the handlers.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/arch/powerpc/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/powerpc/mm/fault.c	2007-03-11 12:34:34.000000000 -0500
+++ linux-2.6/arch/powerpc/mm/fault.c	2007-03-11 12:40:52.000000000 -0500
@@ -39,7 +39,6 @@
 #include <asm/kdebug.h>
 #include <asm/siginfo.h>
 
-#ifdef CONFIG_KPROBES
 ATOMIC_NOTIFIER_HEAD(notify_page_fault_chain);
 
 /* Hook to register for page fault notifications */
@@ -47,11 +46,13 @@
 {
 	return atomic_notifier_chain_register(&notify_page_fault_chain, nb);
 }
+EXPORT_SYMBOL_GPL(register_page_fault_notifier);
 
 int unregister_page_fault_notifier(struct notifier_block *nb)
 {
 	return atomic_notifier_chain_unregister(&notify_page_fault_chain, nb);
 }
+EXPORT_SYMBOL_GPL(unregister_page_fault_notifier);
 
 static inline int notify_page_fault(enum die_val val, const char *str,
 			struct pt_regs *regs, long err, int trap, int sig)
@@ -65,13 +66,6 @@
 	};
 	return atomic_notifier_call_chain(&notify_page_fault_chain, val, &args);
 }
-#else
-static inline int notify_page_fault(enum die_val val, const char *str,
-			struct pt_regs *regs, long err, int trap, int sig)
-{
-	return NOTIFY_DONE;
-}
-#endif
 
 /*
  * Check whether the instruction at regs->nip is a store using
Index: linux-2.6/include/asm-powerpc/kdebug.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/kdebug.h	2007-03-11 12:42:23.000000000 -0500
+++ linux-2.6/include/asm-powerpc/kdebug.h	2007-03-11 12:42:49.000000000 -0500
@@ -33,7 +33,8 @@
 	DIE_MACHINE_CHECK,
 };
 
-static inline int notify_die(enum die_val val,char *str,struct pt_regs *regs,long err,int trap, int sig)
+static inline int notify_die(enum die_val val, const char *str,
+			     struct pt_regs *regs, long err, int trap, int sig)
 {
 	struct die_args args = { .regs=regs, .str=str, .err=err, .trapnr=trap,.signr=sig };
 	return atomic_notifier_call_chain(&powerpc_die_chain, val, &args);

--
