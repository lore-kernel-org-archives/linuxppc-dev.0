Return-Path: <arnd@arndb.de>
Message-Id: <20061024163817.559485000@arndb.de>
References: <20061024163113.694643000@arndb.de>
Date: Tue, 24 Oct 2006 18:31:26 +0200
From: arnd@arndb.de
To: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, paulus@samba.org
Subject: [PATCH 13/16] cell: use ppc_md->power_save instead of cbe_idle_loop
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This moves the cell idle function to use the default cpu_idle
with a special power_save callback, like all other platforms
except iSeries already do.

It also makes it possible to disable this power_save function
with a new powerpc-specific boot option "powersave=off".

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/arch/powerpc/kernel/idle.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/idle.c
+++ linux-2.6/arch/powerpc/kernel/idle.c
@@ -39,6 +39,13 @@
 #define cpu_should_die()	0
 #endif
 
+static int __init powersave_off(char *arg)
+{
+	ppc_md.power_save = NULL;
+	return 0;
+}
+__setup("powersave=off", powersave_off);
+
 /*
  * The body of the idle task.
  */
Index: linux-2.6/arch/powerpc/platforms/cell/pervasive.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/pervasive.c
+++ linux-2.6/arch/powerpc/platforms/cell/pervasive.c
@@ -38,32 +38,16 @@
 #include "pervasive.h"
 #include "cbe_regs.h"
 
-static DEFINE_SPINLOCK(cbe_pervasive_lock);
-
-static void __init cbe_enable_pause_zero(void)
+static void cbe_power_save(void)
 {
-	unsigned long thread_switch_control;
-	unsigned long temp_register;
-	struct cbe_pmd_regs __iomem *pregs;
-
-	spin_lock_irq(&cbe_pervasive_lock);
-	pregs = cbe_get_cpu_pmd_regs(smp_processor_id());
-	if (pregs == NULL)
-		goto out;
-
-	pr_debug("Power Management: CPU %d\n", smp_processor_id());
-
-	 /* Enable Pause(0) control bit */
-	temp_register = in_be64(&pregs->pmcr);
-
-	out_be64(&pregs->pmcr,
-		 temp_register | CBE_PMD_PAUSE_ZERO_CONTROL);
+	unsigned long ctrl, thread_switch_control;
+	ctrl = mfspr(SPRN_CTRLF);
 
 	/* Enable DEC and EE interrupt request */
 	thread_switch_control  = mfspr(SPRN_TSC_CELL);
 	thread_switch_control |= TSC_CELL_EE_ENABLE | TSC_CELL_EE_BOOST;
 
-	switch ((mfspr(SPRN_CTRLF) & CTRL_CT)) {
+	switch (ctrl & CTRL_CT) {
 	case CTRL_CT0:
 		thread_switch_control |= TSC_CELL_DEC_ENABLE_0;
 		break;
@@ -75,58 +59,21 @@ static void __init cbe_enable_pause_zero
 			__FUNCTION__);
 		break;
 	}
-
 	mtspr(SPRN_TSC_CELL, thread_switch_control);
 
-out:
-	spin_unlock_irq(&cbe_pervasive_lock);
-}
-
-static void cbe_idle(void)
-{
-	unsigned long ctrl;
-
-	/* Why do we do that on every idle ? Couldn't that be done once for
-	 * all or do we lose the state some way ? Also, the pmcr
-	 * register setting, that can't be set once at boot ? We really want
-	 * to move that away in order to implement a simple powersave
+	/*
+	 * go into low thread priority, medium priority will be
+	 * restored for us after wake-up.
 	 */
-	cbe_enable_pause_zero();
+	HMT_low();
 
-	while (1) {
-		if (!need_resched()) {
-			local_irq_disable();
-			while (!need_resched()) {
-				/* go into low thread priority */
-				HMT_low();
-
-				/*
-				 * atomically disable thread execution
-				 * and runlatch.
-				 * External and Decrementer exceptions
-				 * are still handled when the thread
-				 * is disabled but now enter in
-				 * cbe_system_reset_exception()
-				 */
-				ctrl = mfspr(SPRN_CTRLF);
-				ctrl &= ~(CTRL_RUNLATCH | CTRL_TE);
-				mtspr(SPRN_CTRLT, ctrl);
-			}
-			/* restore thread prio */
-			HMT_medium();
-			local_irq_enable();
-		}
-
-		/*
-		 * turn runlatch on again before scheduling the
-		 * process we just woke up
-		 */
-		ppc64_runlatch_on();
-
-		preempt_enable_no_resched();
-		schedule();
-		preempt_disable();
-	}
+	/*
+	 * atomically disable thread execution and runlatch.
+	 * External and Decrementer exceptions are still handled when the
+	 * thread is disabled but now enter in cbe_system_reset_exception()
+	 */
+	ctrl &= ~(CTRL_RUNLATCH | CTRL_TE);
+	mtspr(SPRN_CTRLT, ctrl);
 }
 
 static int cbe_system_reset_exception(struct pt_regs *regs)
@@ -158,9 +105,20 @@ static int cbe_system_reset_exception(st
 
 void __init cbe_pervasive_init(void)
 {
+	int cpu;
 	if (!cpu_has_feature(CPU_FTR_PAUSE_ZERO))
 		return;
 
-	ppc_md.idle_loop = cbe_idle;
+	for_each_possible_cpu(cpu) {
+		struct cbe_pmd_regs __iomem *regs = cbe_get_cpu_pmd_regs(cpu);
+		if (!regs)
+			continue;
+
+		 /* Enable Pause(0) control bit */
+		out_be64(&regs->pmcr, in_be64(&regs->pmcr) |
+					    CBE_PMD_PAUSE_ZERO_CONTROL);
+	}
+
+	ppc_md.power_save = cbe_power_save;
 	ppc_md.system_reset_exception = cbe_system_reset_exception;
 }

--
