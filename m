Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4D4EADDF6C
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 07:22:12 +1000 (EST)
Date: Thu, 10 Jul 2008 16:20:27 -0500 (CDT)
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <for-27-patch1-0@bga.com>
Message-Id: <for-27-patch5@bga.com>
Subject: powerpc: pseries,
	cell: use cpu_thread_in_core in smp_init for of_spin_map
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Replace a left over % 2 to be a check for the primary thread and
update the comments.

Note: We assume the secondary threads are not spinning, but they are
actually spinning if we start via kexec.  This means that we call rtas to
spin up the secondary threads. If we get a bad return code from we skip
bringing the cpu online, leaving the thread spinning on the paca.  We don't
handle this case in kexec, and will leave the thread wild during another
kexec.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
I added a debug print and manually verified the correct cpumask was
generated on pSeries.  I ran across the identical code in cell by
the grep of System.map.



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
