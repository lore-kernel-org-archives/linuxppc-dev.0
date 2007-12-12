Return-Path: <mikey@neuling.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Neuling <mikey@neuling.org>
Date: Wed, 12 Dec 2007 16:45:12 +1100
Subject: [PATCH 2/2] kdump shutdown hook support
Message-Id: <20071212054512.A02B062C153@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
	RAISCH@de.ibm.com, THEMANN@de.ibm.com
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

I've tested with bogus data and instruction exceptions.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 arch/powerpc/kernel/crash.c |   90 +++++++++++++++++++++++++++++++++++++++++---
 include/asm-powerpc/kexec.h |    3 +
 2 files changed, 88 insertions(+), 5 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/crash.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/crash.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/crash.c
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
 
+#define CRASH_SHUTDOWN_HANDLES_NUM 1
+/* NULL terminated list of shutdown handles */
+static crash_shutdown_t crash_shutdown_handles[CRASH_SHUTDOWN_HANDLES_NUM+1];
+static DEFINE_SPINLOCK(crash_handles_lock);
+
 #ifdef CONFIG_SMP
 static atomic_t enter_on_soft_reset = ATOMIC_INIT(0);
 
@@ -285,9 +292,69 @@ static inline void crash_kexec_stop_spus
 }
 #endif /* CONFIG_SPU_BASE */
 
+/* 
+ * Register a function to be called on shutdown.  Only use this if you
+ * can't reset your device in the second kernel.
+ */
+int crash_shutdown_register(crash_shutdown_t handler)
+{
+	unsigned int i;
+
+	spin_lock(&crash_handles_lock);
+	for(i = 0 ; i <= CRASH_SHUTDOWN_HANDLES_NUM; i++)
+		if (!crash_shutdown_handles[i])
+			break;
+
+	if (i == CRASH_SHUTDOWN_HANDLES_NUM){
+		printk(KERN_ERR "Crash shutdown handles full, "
+		       "not registered.\n");
+		spin_unlock(&crash_handles_lock);
+		return 1;
+	}
+
+	/* Insert handle at end */
+	crash_shutdown_handles[i] = handler;
+	spin_unlock(&crash_handles_lock);
+	return 0;
+}
+EXPORT_SYMBOL(crash_shutdown_register);
+
+int crash_shutdown_unregister(crash_shutdown_t handler)
+{
+	unsigned int i;
+
+	spin_lock(&crash_handles_lock);
+	for(i = 0 ; i <= CRASH_SHUTDOWN_HANDLES_NUM; i++)
+		if (crash_shutdown_handles[i] == handler)
+			break;
+
+	if (i == CRASH_SHUTDOWN_HANDLES_NUM){
+		printk(KERN_ERR "Crash shutdown handle not found\n");
+		spin_unlock(&crash_handles_lock);
+		return 1;
+	}
+
+	/* Shift handles down */
+	while(crash_shutdown_handles[i]) {
+		crash_shutdown_handles[i] = crash_shutdown_handles[i+1];
+		i++;
+	}
+	spin_unlock(&crash_handles_lock);
+	return 0;
+}
+EXPORT_SYMBOL(crash_shutdown_unregister);
+
+static long crash_shutdown_buf[SETJMP_BUF_LEN];
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
 
 	/*
 	 * This function is only called after the system
@@ -301,14 +368,27 @@ void default_machine_crash_shutdown(stru
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
+	/* Call registered shutdown routines */
+	__debugger_fault_handler = handle_fault;
+	i = 0;
+	while(crash_shutdown_handles[i]){
+		if (setjmp(crash_shutdown_buf) == 0) {
+			asm volatile("sync; isync");
+			crash_shutdown_handles[i]();
+			asm volatile("sync; isync");
+			__delay(200);
+		}
+		i++;
 	}
 
 	/*
Index: linux-2.6-ozlabs/include/asm-powerpc/kexec.h
===================================================================
--- linux-2.6-ozlabs.orig/include/asm-powerpc/kexec.h
+++ linux-2.6-ozlabs/include/asm-powerpc/kexec.h
@@ -123,6 +123,9 @@ struct pt_regs;
 extern void default_machine_kexec(struct kimage *image);
 extern int default_machine_kexec_prepare(struct kimage *image);
 extern void default_machine_crash_shutdown(struct pt_regs *regs);
+typedef void (*crash_shutdown_t)(void);
+extern int crash_shutdown_register(crash_shutdown_t handler);
+extern int crash_shutdown_unregister(crash_shutdown_t handler);
 
 extern void machine_kexec_simple(struct kimage *image);
 extern void crash_kexec_secondary(struct pt_regs *regs);
