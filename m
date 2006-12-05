Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 05 Dec 2006 17:52:37 +1100
Subject: [PATCH 2/5] Move pSeries_mach_cpu_die() into
	platforms/pseries/hotplug-cpu.c
In-Reply-To: <1165301556.843426.760217571714.qpush@cradle>
Message-Id: <20061205065235.8DD2B67B5F@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Move pSeries_mach_cpu_die() into platforms/pseries/hotplug-cpu.c,
this allows rtas_stop_self() to be static so remove the prototype.

Wire up pSeries_mach_cpu_die() in the initcall, rather than statically
in setup.c, the initcall will still run prior to the cpu hotplug code
being callable, so there should be no change in behaviour.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/platforms/pseries/hotplug-cpu.c |   18 ++++++++++++++++--
 arch/powerpc/platforms/pseries/setup.c       |   16 ----------------
 include/asm-powerpc/rtas.h                   |    2 --
 3 files changed, 16 insertions(+), 20 deletions(-)

Index: powerpc/arch/powerpc/platforms/pseries/hotplug-cpu.c
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ powerpc/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -1,7 +1,8 @@
 /*
  * pseries CPU Hotplug infrastructure.
  *
- * Split out from arch/powerpc/kernel/rtas.c
+ * Split out from arch/powerpc/platforms/pseries/setup.c and
+ *  arch/powerpc/kernel/rtas.c
  *
  * Peter Bergner, IBM	March 2001.
  * Copyright (C) 2001 IBM.
@@ -34,7 +35,7 @@ static struct rtas_args rtas_stop_self_a
 	.rets = &rtas_stop_self_args.args[0],
 };
 
-void rtas_stop_self(void)
+static void rtas_stop_self(void)
 {
 	struct rtas_args *args = &rtas_stop_self_args;
 
@@ -49,10 +50,23 @@ void rtas_stop_self(void)
 	panic("Alas, I survived.\n");
 }
 
+static void pSeries_mach_cpu_die(void)
+{
+	local_irq_disable();
+	idle_task_exit();
+	xics_teardown_cpu(0);
+	rtas_stop_self();
+	/* Should never get here... */
+	BUG();
+	for(;;);
+}
+
 static int __init pseries_cpu_hotplug_init(void)
 {
 	rtas_stop_self_args.token = rtas_token("stop-self");
 
+	ppc_md.cpu_die = pSeries_mach_cpu_die;
+
 	return 0;
 }
 arch_initcall(pseries_cpu_hotplug_init);
Index: powerpc/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/setup.c
+++ powerpc/arch/powerpc/platforms/pseries/setup.c
@@ -347,21 +347,6 @@ static int __init pSeries_init_panel(voi
 }
 arch_initcall(pSeries_init_panel);
 
-#ifdef CONFIG_HOTPLUG_CPU
-static void pSeries_mach_cpu_die(void)
-{
-	local_irq_disable();
-	idle_task_exit();
-	xics_teardown_cpu(0);
-	rtas_stop_self();
-	/* Should never get here... */
-	BUG();
-	for(;;);
-}
-#else
-#define pSeries_mach_cpu_die NULL
-#endif
-
 static int pseries_set_dabr(unsigned long dabr)
 {
 	return plpar_hcall_norets(H_SET_DABR, dabr);
@@ -561,7 +546,6 @@ define_machine(pseries) {
 	.power_off		= rtas_power_off,
 	.halt			= rtas_halt,
 	.panic			= rtas_os_term,
-	.cpu_die		= pSeries_mach_cpu_die,
 	.get_boot_time		= rtas_get_boot_time,
 	.get_rtc_time		= rtas_get_rtc_time,
 	.set_rtc_time		= rtas_set_rtc_time,
Index: powerpc/include/asm-powerpc/rtas.h
===================================================================
--- powerpc.orig/include/asm-powerpc/rtas.h
+++ powerpc/include/asm-powerpc/rtas.h
@@ -221,8 +221,6 @@ extern int rtas_get_error_log_max(void);
 extern spinlock_t rtas_data_buf_lock;
 extern char rtas_data_buf[RTAS_DATA_BUF_SIZE];
 
-extern void rtas_stop_self(void);
-
 /* RMO buffer reserved for user-space RTAS use */
 extern unsigned long rtas_rmo_buf;
 
