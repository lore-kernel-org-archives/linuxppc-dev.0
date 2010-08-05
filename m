Return-Path: <nfont@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 028791007D2
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Aug 2010 03:42:27 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o75HUtcC007636
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Aug 2010 11:30:55 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	o75HgKxi076450
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Aug 2010 11:42:21 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o75HgBZu028294
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Aug 2010 11:42:11 -0600
Received: from [9.53.40.150] (mudbug-009053040150.austin.ibm.com [9.53.40.150])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	o75HgBsv028221
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Aug 2010 11:42:11 -0600
Message-ID: <4C5AF7F3.3080901@austin.ibm.com>
Date: Thu, 05 Aug 2010 12:42:11 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Correct smt_enabled=X boot option for > 2 threads per core
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The 'smt_enabled=X' boot option does not handle values of X > 2.
For Power 7 processors with smt modes of 0,1,2,3, and 4 this does
not work.  This patch allows the smt_enabled option to be set to
any value limited to a max equal to the number of threads per
core.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
---
 arch/powerpc/kernel/setup_64.c       |   61 ++++++++++++++++++++---------------
 arch/powerpc/platforms/pseries/smp.c |   11 ++++--
 2 files changed, 42 insertions(+), 30 deletions(-)

Index: powerpc/arch/powerpc/kernel/setup_64.c
===================================================================
--- powerpc.orig/arch/powerpc/kernel/setup_64.c	2010-08-05 10:57:04.000000000 -0500
+++ powerpc/arch/powerpc/kernel/setup_64.c	2010-08-05 11:20:49.000000000 -0500
@@ -95,7 +95,7 @@ int ucache_bsize;
 
 #ifdef CONFIG_SMP
 
-static int smt_enabled_cmdline;
+static char *smt_enabled_cmdline;
 
 /* Look for ibm,smt-enabled OF option */
 static void check_smt_enabled(void)
@@ -103,37 +103,46 @@ static void check_smt_enabled(void)
 	struct device_node *dn;
 	const char *smt_option;
 
-	/* Allow the command line to overrule the OF option */
-	if (smt_enabled_cmdline)
-		return;
-
-	dn = of_find_node_by_path("/options");
+	/* Default to enabling all threads */
+	smt_enabled_at_boot = threads_per_core;
 
-	if (dn) {
-		smt_option = of_get_property(dn, "ibm,smt-enabled", NULL);
+	/* Allow the command line to overrule the OF option */
+	if (smt_enabled_cmdline) {
+		if (!strcmp(smt_enabled_cmdline, "on"))
+			smt_enabled_at_boot = threads_per_core;
+		else if (!strcmp(smt_enabled_cmdline, "off"))
+			smt_enabled_at_boot = 0;
+		else {
+			long smt;
+			int rc;
+
+			rc = strict_strtol(smt_enabled_cmdline, 10, &smt);
+			if (!rc)
+				smt_enabled_at_boot =
+					min(threads_per_core, (int)smt);
+		}
+	} else {
+		dn = of_find_node_by_path("/options");
+		if (dn) {
+			smt_option = of_get_property(dn, "ibm,smt-enabled",
+						     NULL);
+
+			if (smt_option) {
+				if (!strcmp(smt_option, "on"))
+					smt_enabled_at_boot = threads_per_core;
+				else if (!strcmp(smt_option, "off"))
+					smt_enabled_at_boot = 0;
+			}
 
-                if (smt_option) {
-			if (!strcmp(smt_option, "on"))
-				smt_enabled_at_boot = 1;
-			else if (!strcmp(smt_option, "off"))
-				smt_enabled_at_boot = 0;
-                }
-        }
+			of_node_put(dn);
+		}
+	}
 }
 
 /* Look for smt-enabled= cmdline option */
 static int __init early_smt_enabled(char *p)
 {
-	smt_enabled_cmdline = 1;
-
-	if (!p)
-		return 0;
-
-	if (!strcmp(p, "on") || !strcmp(p, "1"))
-		smt_enabled_at_boot = 1;
-	else if (!strcmp(p, "off") || !strcmp(p, "0"))
-		smt_enabled_at_boot = 0;
-
+	smt_enabled_cmdline = p;
 	return 0;
 }
 early_param("smt-enabled", early_smt_enabled);
@@ -390,8 +399,8 @@ void __init setup_system(void)
 	 */
 	xmon_setup();
 
-	check_smt_enabled();
 	smp_setup_cpu_maps();
+	check_smt_enabled();
 
 #ifdef CONFIG_SMP
 	/* Release secondary cpus out of their spinloops at 0x60 now that
Index: powerpc/arch/powerpc/platforms/pseries/smp.c
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/smp.c	2010-06-14 08:36:05.000000000 -0500
+++ powerpc/arch/powerpc/platforms/pseries/smp.c	2010-08-05 11:20:49.000000000 -0500
@@ -182,10 +182,13 @@ static int smp_pSeries_cpu_bootable(unsi
 	/* Special case - we inhibit secondary thread startup
 	 * during boot if the user requests it.
 	 */
-	if (system_state < SYSTEM_RUNNING &&
-	    cpu_has_feature(CPU_FTR_SMT) &&
-	    !smt_enabled_at_boot && cpu_thread_in_core(nr) != 0)
-		return 0;
+	if (system_state < SYSTEM_RUNNING && cpu_has_feature(CPU_FTR_SMT)) {
+		if (!smt_enabled_at_boot && cpu_thread_in_core(nr) != 0)
+			return 0;
+		if (smt_enabled_at_boot
+		    && cpu_thread_in_core(nr) >= smt_enabled_at_boot)
+			return 0;
+	}
 
 	return 1;
 }
 
