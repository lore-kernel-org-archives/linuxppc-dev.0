Return-Path: <nfont@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2E0BBB7DFE
	for <linuxppc-dev@ozlabs.org>; Thu, 13 May 2010 00:51:08 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o4CEhv1R015645
	for <linuxppc-dev@ozlabs.org>; Wed, 12 May 2010 08:43:57 -0600
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	o4CEosms092624
	for <linuxppc-dev@ozlabs.org>; Wed, 12 May 2010 08:50:55 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o4CErW1j010675
	for <linuxppc-dev@ozlabs.org>; Wed, 12 May 2010 08:53:32 -0600
Received: from [9.53.40.163] (mudbug-009053040163.austin.ibm.com [9.53.40.163])
	by d03av06.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVin) with ESMTP id
	o4CErWd0010668
	for <linuxppc-dev@ozlabs.org>; Wed, 12 May 2010 08:53:32 -0600
Message-ID: <4BEAC041.4000404@austin.ibm.com>
Date: Wed, 12 May 2010 09:50:41 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Update smt_enabled=X handling for cores with more than two
	threads
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch updates the handling of the smt-enabled=X boot option to handle
settings on systems with more than two threads per core.  This change involves
moving all of the handling of the boot option to the check_smt_enabled()
routine and the calling of this routine in setup_system() until after the
smp_setup_cpu_maps() call.  This is done so that we can use the
threads_per_core variable when validating the smt boot option specified.

Signed-off-by: Nathan Fontenot<nfont@austin.ibm.com>
---
  arch/powerpc/kernel/setup_64.c       |   61 ++++++++++++++++++++---------------
  arch/powerpc/platforms/pseries/smp.c |   11 ++++--
  2 files changed, 42 insertions(+), 30 deletions(-)

Index: powerpc/arch/powerpc/kernel/setup_64.c
===================================================================
--- powerpc.orig/arch/powerpc/kernel/setup_64.c	2010-05-12 08:33:38.000000000 -0500
+++ powerpc/arch/powerpc/kernel/setup_64.c	2010-05-12 08:48:10.000000000 -0500
@@ -95,7 +95,7 @@

  #ifdef CONFIG_SMP

-static int smt_enabled_cmdline;
+static char *smt_enabled_cmdline;

  /* Look for ibm,smt-enabled OF option */
  static void check_smt_enabled(void)
@@ -103,37 +103,46 @@
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
+			rc = strict_strtol(smt_enabled_cmdline, 10,&smt);
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
@@ -390,8 +399,8 @@
  	 */
  	xmon_setup();

-	check_smt_enabled();
  	smp_setup_cpu_maps();
+	check_smt_enabled();

  #ifdef CONFIG_SMP
  	/* Release secondary cpus out of their spinloops at 0x60 now that
Index: powerpc/arch/powerpc/platforms/pseries/smp.c
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/smp.c	2010-05-12 08:33:38.000000000 -0500
+++ powerpc/arch/powerpc/platforms/pseries/smp.c	2010-05-12 08:36:09.000000000 -0500
@@ -154,10 +154,13 @@
  	/* Special case - we inhibit secondary thread startup
  	 * during boot if the user requests it.
  	 */
-	if (system_state<  SYSTEM_RUNNING&&
-	    cpu_has_feature(CPU_FTR_SMT)&&
-	    !smt_enabled_at_boot&&  cpu_thread_in_core(nr) != 0)
-		return 0;
+	if (system_state<  SYSTEM_RUNNING&&  cpu_has_feature(CPU_FTR_SMT)) {
+		if (!smt_enabled_at_boot&&  cpu_thread_in_core(nr) != 0)
+			return 0;
+		if (smt_enabled_at_boot
+		&&  cpu_thread_in_core(nr)>= smt_enabled_at_boot)
+			return 0;
+	}

  	return 1;
  }
