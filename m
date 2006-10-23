Return-Path: <arnd.bergmann@de.ibm.com>
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: linuxppc-dev@ozlabs.org, paulus@samba.org, cbe-oss-dev@ozlabs.org
Subject: [PATCH] cell: use ppc_md->power_save instead of cbe_idle_loop
Date: Mon, 23 Oct 2006 11:52:06 +0200
References: <200610201840.14389.arnd.bergmann@de.ibm.com>
	<20061020182203.7871d1b1@pb15>
In-Reply-To: <20061020182203.7871d1b1@pb15>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610231152.07675.arnd.bergmann@de.ibm.com>
Cc: Olof Johansson <olof@lixom.net>, Anthony J Marsala <marsala@us.ibm.com>
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

Anthony, can you verify that the new options works for you?

I've added this patch to my cell series, and want to submit
it for 2.6.20 if everyone's happy with it.

Index: linux-2.6/arch/powerpc/platforms/cell/pervasive.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/pervasive.c
+++ linux-2.6/arch/powerpc/platforms/cell/pervasive.c
@@ -82,51 +82,24 @@ out:
 	spin_unlock_irq(&cbe_pervasive_lock);
 }
 
-static void cbe_idle(void)
+static void cbe_power_save(void)
 {
 	unsigned long ctrl;
 
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
+	ctrl = mfspr(SPRN_CTRLF);
+	ctrl &= ~(CTRL_RUNLATCH | CTRL_TE);
+	mtspr(SPRN_CTRLT, ctrl);
 }
 
 static int cbe_system_reset_exception(struct pt_regs *regs)
@@ -161,6 +134,13 @@ void __init cbe_pervasive_init(void)
 	if (!cpu_has_feature(CPU_FTR_PAUSE_ZERO))
 		return;
 
-	ppc_md.idle_loop = cbe_idle;
+	/*
+	 * We need to call cbe_enable_pause_zero on each CPU
+	 * before first entering power_save(). The most convenient
+	 * place for this is ppc_md->idle, because that is called
+	 * right before entering the idle loop.
+	 */
+	ppc_md.idle_loop = cbe_enable_pause_zero;
+	ppc_md.power_save = cbe_power_save;
 	ppc_md.system_reset_exception = cbe_system_reset_exception;
 }
Index: linux-2.6/arch/powerpc/kernel/idle.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/idle.c
+++ linux-2.6/arch/powerpc/kernel/idle.c
@@ -39,13 +39,20 @@
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
 void cpu_idle(void)
 {
 	if (ppc_md.idle_loop)
-		ppc_md.idle_loop();	/* doesn't return */
+		ppc_md.idle_loop();	/* usually does not return */
 
 	set_thread_flag(TIF_POLLING_NRFLAG);
 	while (1) {
