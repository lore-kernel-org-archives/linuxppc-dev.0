Return-Path: <anton@ozlabs.org>
Date: Mon, 17 May 2010 16:01:28 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, nfont@austin.ibm.com
Subject: [PATCH 1/2] powerpc: Remove ibm,smt-snooze-delay OF property
Message-ID: <20100517060128.GC13509@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


I'm not sure why we have code for parsing an ibm,smt-snooze-delay OF
property. Since we have a smt-snooze-delay= boot option and we can
also set it at runtime via sysfs, it should be safe to get rid of
this code.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/kernel/sysfs.c
===================================================================
--- powerpc.git.orig/arch/powerpc/kernel/sysfs.c	2010-05-17 15:05:29.917208655 +1000
+++ powerpc.git/arch/powerpc/kernel/sysfs.c	2010-05-17 15:18:24.164704601 +1000
@@ -67,33 +67,6 @@ static ssize_t show_smt_snooze_delay(str
 static SYSDEV_ATTR(smt_snooze_delay, 0644, show_smt_snooze_delay,
 		   store_smt_snooze_delay);
 
-/* Only parse OF options if the matching cmdline option was not specified */
-static int smt_snooze_cmdline;
-
-static int __init smt_setup(void)
-{
-	struct device_node *options;
-	const unsigned int *val;
-	unsigned int cpu;
-
-	if (!cpu_has_feature(CPU_FTR_SMT))
-		return -ENODEV;
-
-	options = of_find_node_by_path("/options");
-	if (!options)
-		return -ENODEV;
-
-	val = of_get_property(options, "ibm,smt-snooze-delay", NULL);
-	if (!smt_snooze_cmdline && val) {
-		for_each_possible_cpu(cpu)
-			per_cpu(smt_snooze_delay, cpu) = *val;
-	}
-
-	of_node_put(options);
-	return 0;
-}
-__initcall(smt_setup);
-
 static int __init setup_smt_snooze_delay(char *str)
 {
 	unsigned int cpu;
@@ -102,8 +75,6 @@ static int __init setup_smt_snooze_delay
 	if (!cpu_has_feature(CPU_FTR_SMT))
 		return 1;
 
-	smt_snooze_cmdline = 1;
-
 	if (get_option(&str, &snooze)) {
 		for_each_possible_cpu(cpu)
 			per_cpu(smt_snooze_delay, cpu) = snooze;
