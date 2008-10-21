Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1B1F8DDDE7
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 12:37:10 +1100 (EST)
Date: Mon, 20 Oct 2008 20:37:03 -0500 (CDT)
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: linuxppc-dev@ozlabs.org
Message-id: <of-spin-t2@bga.com>
Subject: powerpc: pseries,
	cell: use cpu_thread_in_core in smp_init for of_spin_map
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We used to assume that even numbered threads were the primary
threads, ie those that would be listed and started as a cpu from
open firmware.  Replace a left over is even (% 2) check with a check
for it being a primary thread and update the comments.

Tested with a debug print on pseries, identical code found for cell.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
X-Patchwork-ID: 19578
Resend of July 11 patch, changelog edited.
Patch still applies to next-20081017.

Note: We assume the secondary threads are not spinning, but they are
actually spinning if we start via kexec.  This means that we call rtas to
spin up the secondary threads. If we get a bad return code from we skip
bringing the cpu online, leaving the thread spinning on the paca.  We don't
handle this case in kexec, and will leave the thread wild during another
kexec.  (I'm not changing this behavior in this patch).

---
diff --git a/arch/powerpc/platforms/cell/smp.c b/arch/powerpc/platforms/cell/smp.c
index efb3964..c0d86e1 100644
--- a/arch/powerpc/platforms/cell/smp.c
+++ b/arch/powerpc/platforms/cell/smp.c
@@ -54,8 +54,8 @@
 #endif
 
 /*
- * The primary thread of each non-boot processor is recorded here before
- * smp init.
+ * The Primary thread of each non-boot processor was started from the OF client
+ * interface by prom_hold_cpus and is spinning on secondary_hold_spinloop.
  */
 static cpumask_t of_spin_map;
 
@@ -208,11 +208,7 @@ void __init smp_init_cell(void)
 	/* Mark threads which are still spinning in hold loops. */
 	if (cpu_has_feature(CPU_FTR_SMT)) {
 		for_each_present_cpu(i) {
-			if (i % 2 == 0)
-				/*
-				 * Even-numbered logical cpus correspond to
-				 * primary threads.
-				 */
+			if (cpu_thread_in_core(i) == 0)
 				cpu_set(i, of_spin_map);
 		}
 	} else {
diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index 9d8f8c8..c9337c7 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -52,8 +52,8 @@
 
 
 /*
- * The primary thread of each non-boot processor is recorded here before
- * smp init.
+ * The Primary thread of each non-boot processor was started from the OF client
+ * interface by prom_hold_cpus and is spinning on secondary_hold_spinloop.
  */
 static cpumask_t of_spin_map;
 
@@ -191,8 +191,7 @@ static void __devinit smp_pSeries_kick_cpu(int nr)
 static int smp_pSeries_cpu_bootable(unsigned int nr)
 {
 	/* Special case - we inhibit secondary thread startup
-	 * during boot if the user requests it.  Odd-numbered
-	 * cpus are assumed to be secondary threads.
+	 * during boot if the user requests it.
 	 */
 	if (system_state < SYSTEM_RUNNING &&
 	    cpu_has_feature(CPU_FTR_SMT) &&
@@ -229,11 +228,7 @@ static void __init smp_init_pseries(void)
 	/* Mark threads which are still spinning in hold loops. */
 	if (cpu_has_feature(CPU_FTR_SMT)) {
 		for_each_present_cpu(i) { 
-			if (i % 2 == 0)
-				/*
-				 * Even-numbered logical cpus correspond to
-				 * primary threads.
-				 */
+			if (cpu_thread_in_core(i) == 0)
 				cpu_set(i, of_spin_map);
 		}
 	} else {
