Return-Path: <arnd.bergmann@de.ibm.com>
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] cell: use ppc_md->power_save instead of cbe_idle_loop
Date: Mon, 23 Oct 2006 13:50:35 +0200
References: <200610201840.14389.arnd.bergmann@de.ibm.com>
	<200610231152.07675.arnd.bergmann@de.ibm.com>
	<1161598587.10524.455.camel@localhost.localdomain>
In-Reply-To: <1161598587.10524.455.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610231350.36963.arnd.bergmann@de.ibm.com>
Cc: paulus@samba.org, cbe-oss-dev@ozlabs.org,
	Anthony J Marsala <marsala@us.ibm.com>
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

---

On Monday 23 October 2006 12:16, Benjamin Herrenschmidt wrote:
> I disagree here... this should be done in setup_cpu() for non-boot CPUs,
> and sometime in setup_arch for the boot CPU. 

ok, good point.

> Another option is to have the pm_control bit done once for all CPUs at
> boot in setup_arch() or such, and the TSC_CELL SPR bit done
> unconditionally in powersave...

How about this then?

diff --git a/arch/powerpc/kernel/idle.c b/arch/powerpc/kernel/idle.c
index 4180c39..8994af3 100644
--- a/arch/powerpc/kernel/idle.c
+++ b/arch/powerpc/kernel/idle.c
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
diff --git a/arch/powerpc/platforms/cell/pervasive.c b/arch/powerpc/platforms/cell/pervasive.c
index 9f2e4ed..10b150a 100644
--- a/arch/powerpc/platforms/cell/pervasive.c
+++ b/arch/powerpc/platforms/cell/pervasive.c
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
-	temp_register = in_be64(&pregs->pm_control);
-
-	out_be64(&pregs->pm_control,
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
-	 * all or do we lose the state some way ? Also, the pm_control
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
+		out_be64(&regs->pm_control, in_be64(&regs->pm_control) |
+					    CBE_PMD_PAUSE_ZERO_CONTROL);
+	}
+
+	ppc_md.power_save = cbe_power_save;
 	ppc_md.system_reset_exception = cbe_system_reset_exception;
 }
