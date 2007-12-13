Return-Path: <mikey@neuling.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Neuling <mikey@neuling.org>
Date: Thu, 13 Dec 2007 20:59:17 +1100
Subject: [PATCH 2/2] kdump shutdown hook support
In-Reply-To: <1197539957.623622.326790809699.qpush@coopers>
Message-Id: <20071213095918.432D27038C@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, RAISCH@de.ibm.com, THEMANN@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds hooks into the default_machine_crash_shutdown so drivers can
register a function to be run in the first kernel before we hand off
to the second kernel.  This should only be used in exceptional
circumstances, like where the device can't be reset in the second
kernel alone (as is the case with eHEA).  To emphasize this, the
number of handles allowed to be registered is currently #def to 1.

This uses the setjmp/longjmp code to call out to the registered hooks,
so any bogus exceptions we encounter will hopefully be recoverable.  

Tested with bogus data and instruction exceptions.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 arch/powerpc/kernel/crash.c |  102 +++++++++++++++++++++++++++++++++++++++++---
 include/asm-powerpc/kexec.h |    3 +
 2 files changed, 100 insertions(+), 5 deletions(-)

Index: clone3/arch/powerpc/kernel/crash.c
===================================================================
--- clone3.orig/arch/powerpc/kernel/crash.c
+++ clone3/arch/powerpc/kernel/crash.c
@@ -32,6 +32,8 @@
 #include <asm/lmb.h>
 #include <asm/firmware.h>
 #include <asm/smp.h>
+#include <asm/system.h>
+#include <asm/setjmp.h>
 
 #ifdef DEBUG
 #include <asm/udbg.h>
@@ -45,6 +47,11 @@ int crashing_cpu = -1;
 static cpumask_t cpus_in_crash = CPU_MASK_NONE;
 cpumask_t cpus_in_sr = CPU_MASK_NONE;
 
+#define CRASH_HANDLER_MAX 1
+/* NULL terminated list of shutdown handles */
+static crash_shutdown_t crash_shutdown_handles[CRASH_HANDLER_MAX+1];
+static DEFINE_SPINLOCK(crash_handlers_lock);
+
 #ifdef CONFIG_SMP
 static atomic_t enter_on_soft_reset = ATOMIC_INIT(0);
 
@@ -285,9 +292,72 @@ static inline void crash_kexec_stop_spus
 }
 #endif /* CONFIG_SPU_BASE */
 
+/*
+ * Register a function to be called on shutdown.  Only use this if you
+ * can't reset your device in the second kernel.
+ */
+int crash_shutdown_register(crash_shutdown_t handler)
+{
+	unsigned int i, rc;
+
+	spin_lock(&crash_handlers_lock);
+	for (i = 0 ; i < CRASH_HANDLER_MAX; i++)
+		if (!crash_shutdown_handles[i]) {
+			/* Insert handle at first empty entry */
+			crash_shutdown_handles[i] = handler;
+			rc = 0;
+			break;
+		}
+
+	if (i == CRASH_HANDLER_MAX) {
+		printk(KERN_ERR "Crash shutdown handles full, "
+		       "not registered.\n");
+		rc = 1;
+	}
+
+	spin_unlock(&crash_handlers_lock);
+	return rc;
+}
+EXPORT_SYMBOL(crash_shutdown_register);
+
+int crash_shutdown_unregister(crash_shutdown_t handler)
+{
+	unsigned int i, rc;
+
+	spin_lock(&crash_handlers_lock);
+	for (i = 0 ; i < CRASH_HANDLER_MAX; i++)
+		if (crash_shutdown_handles[i] == handler)
+			break;
+
+	if (i == CRASH_HANDLER_MAX) {
+		printk(KERN_ERR "Crash shutdown handle not found\n");
+		rc = 1;
+	} else {
+		/* Shift handles down */
+		for (; crash_shutdown_handles[i]; i++)
+			crash_shutdown_handles[i] =
+				crash_shutdown_handles[i+1];
+		rc = 0;
+	}
+
+	spin_unlock(&crash_handlers_lock);
+	return rc;
+}
+EXPORT_SYMBOL(crash_shutdown_unregister);
+
+static unsigned long crash_shutdown_buf[SETJMP_BUF_LEN];
+
+static int handle_fault(struct pt_regs *regs)
+{
+	longjmp(crash_shutdown_buf, 1);
+	return 0;
+}
+
 void default_machine_crash_shutdown(struct pt_regs *regs)
 {
-	unsigned int irq;
+	unsigned int i;
+	int (*old_handler)(struct pt_regs *regs);
+
 
 	/*
 	 * This function is only called after the system
@@ -301,15 +371,37 @@ void default_machine_crash_shutdown(stru
 	 */
 	hard_irq_disable();
 
-	for_each_irq(irq) {
-		struct irq_desc *desc = irq_desc + irq;
+	for_each_irq(i) {
+		struct irq_desc *desc = irq_desc + i;
 
 		if (desc->status & IRQ_INPROGRESS)
-			desc->chip->eoi(irq);
+			desc->chip->eoi(i);
 
 		if (!(desc->status & IRQ_DISABLED))
-			desc->chip->disable(irq);
+			desc->chip->disable(i);
+	}
+
+	/*
+	 * Call registered shutdown routines savely.  Swap out
+	 * __debugger_fault_handler, and replace on exit.
+	 */
+	old_handler = __debugger_fault_handler;
+	__debugger_fault_handler = handle_fault;
+	for (i = 0; crash_shutdown_handles[i]; i++) {
+		if (setjmp(crash_shutdown_buf) == 0) {
+			/*
+			 * Insert syncs and delay to ensure
+			 * instructions in the dangerous region don't
+			 * leak away from this protected region.
+			 */
+			asm volatile("sync; isync");
+			/* dangerous region */
+			crash_shutdown_handles[i]();
+			asm volatile("sync; isync");
+			__delay(SETJMP_MACHINE_CHECK_DELAY);
+		}
 	}
+	__debugger_fault_handler = old_handler;
 
 	/*
 	 * Make a note of crashing cpu. Will be used in machine_kexec
Index: clone3/include/asm-powerpc/kexec.h
===================================================================
--- clone3.orig/include/asm-powerpc/kexec.h
+++ clone3/include/asm-powerpc/kexec.h
@@ -123,6 +123,9 @@ struct pt_regs;
 extern void default_machine_kexec(struct kimage *image);
 extern int default_machine_kexec_prepare(struct kimage *image);
 extern void default_machine_crash_shutdown(struct pt_regs *regs);
+typedef void (*crash_shutdown_t)(void);
+extern int crash_shutdown_register(crash_shutdown_t handler);
+extern int crash_shutdown_unregister(crash_shutdown_t handler);
 
 extern void machine_kexec_simple(struct kimage *image);
 extern void crash_kexec_secondary(struct pt_regs *regs);
