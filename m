Return-Path: <anton@samba.org>
Date: Tue, 10 Jan 2012 11:29:15 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, paulmck@linux.vnet.ibm.com
Subject: [PATCH] powerpc: Fix RCU idle and hcall tracing
Message-ID: <20120110112915.387e8b1c@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Tracepoints should not be called inside an rcu_idle_enter/rcu_idle_exit
region. Since pSeries calls H_CEDE in the idle loop, we were violating
this rule.

commit a7b152d5342c (powerpc: Tell RCU about idle after hcall tracing)
tried to work around it by delaying the rcu_idle_enter until after we
called the hcall tracepoint, but there are a number of issues with it.

The hcall tracepoint trampoline code is called conditionally when the
tracepoint is enabled. If the tracepoint is not enabled we never call
rcu_idle_enter. The idle_uses_rcu check was also done at compile time
which breaks multiplatform builds.

The simple fix is to avoid tracing H_CEDE and rely on other tracepoints
and the hypervisor dispatch trace log to work out if we called H_CEDE.

This fixes a hang during boot on pSeries.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/kernel/idle.c
===================================================================
--- linux-build.orig/arch/powerpc/kernel/idle.c	2012-01-10 11:07:22.091615183 +1100
+++ linux-build/arch/powerpc/kernel/idle.c	2012-01-10 11:07:57.172264229 +1100
@@ -50,12 +50,6 @@ static int __init powersave_off(char *ar
 }
 __setup("powersave=off", powersave_off);
 
-#if defined(CONFIG_PPC_PSERIES) && defined(CONFIG_TRACEPOINTS)
-static const bool idle_uses_rcu = 1;
-#else
-static const bool idle_uses_rcu;
-#endif
-
 /*
  * The body of the idle task.
  */
@@ -67,8 +61,7 @@ void cpu_idle(void)
 	set_thread_flag(TIF_POLLING_NRFLAG);
 	while (1) {
 		tick_nohz_idle_enter();
-		if (!idle_uses_rcu)
-			rcu_idle_enter();
+		rcu_idle_enter();
 
 		while (!need_resched() && !cpu_should_die()) {
 			ppc64_runlatch_off();
@@ -106,8 +99,7 @@ void cpu_idle(void)
 
 		HMT_medium();
 		ppc64_runlatch_on();
-		if (!idle_uses_rcu)
-			rcu_idle_exit();
+		rcu_idle_exit();
 		tick_nohz_idle_exit();
 		preempt_enable_no_resched();
 		if (cpu_should_die())
Index: linux-build/arch/powerpc/platforms/pseries/lpar.c
===================================================================
--- linux-build.orig/arch/powerpc/platforms/pseries/lpar.c	2012-01-10 11:07:22.079614961 +1100
+++ linux-build/arch/powerpc/platforms/pseries/lpar.c	2012-01-10 11:16:55.710226236 +1100
@@ -546,6 +546,13 @@ void __trace_hcall_entry(unsigned long o
 	unsigned long flags;
 	unsigned int *depth;
 
+	/*
+	 * We cannot call tracepoints inside RCU idle regions which
+	 * means we must not trace H_CEDE.
+	 */
+	if (opcode == H_CEDE)
+		return;
+
 	local_irq_save(flags);
 
 	depth = &__get_cpu_var(hcall_trace_depth);
@@ -556,8 +563,6 @@ void __trace_hcall_entry(unsigned long o
 	(*depth)++;
 	preempt_disable();
 	trace_hcall_entry(opcode, args);
-	if (opcode == H_CEDE)
-		rcu_idle_enter();
 	(*depth)--;
 
 out:
@@ -570,6 +575,9 @@ void __trace_hcall_exit(long opcode, uns
 	unsigned long flags;
 	unsigned int *depth;
 
+	if (opcode == H_CEDE)
+		return;
+
 	local_irq_save(flags);
 
 	depth = &__get_cpu_var(hcall_trace_depth);
@@ -578,8 +586,6 @@ void __trace_hcall_exit(long opcode, uns
 		goto out;
 
 	(*depth)++;
-	if (opcode == H_CEDE)
-		rcu_idle_exit();
 	trace_hcall_exit(opcode, retval, retbuf);
 	preempt_enable();
 	(*depth)--;
