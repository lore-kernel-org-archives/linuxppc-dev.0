Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 33689DE477
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 23:19:47 +1100 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Milton Miller <miltonm@bga.com>
Subject: [PATCH 3/4] powerpc: remove redundant find_cpu_node
Date: Thu, 08 Jan 2009 06:19:45 -0600
Message-ID: <1231417185_141717@mercury.realtime.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

use of_get_cpu_node, which is a superset of numa.c's find_cpu_node in
a less restrictive section (text vs cpuinit).

Signed-off-by: Milton Miller <miltonm@bga.com>

Index: work.git/arch/powerpc/mm/numa.c
===================================================================
--- work.git.orig/arch/powerpc/mm/numa.c	2008-12-18 15:31:35.000000000 -0600
+++ work.git/arch/powerpc/mm/numa.c	2009-01-05 05:10:29.000000000 -0600
@@ -157,35 +157,6 @@ static void unmap_cpu_from_node(unsigned
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
-static struct device_node * __cpuinit find_cpu_node(unsigned int cpu)
-{
-	unsigned int hw_cpuid = get_hard_smp_processor_id(cpu);
-	struct device_node *cpu_node = NULL;
-	const unsigned int *interrupt_server, *reg;
-	int len;
-
-	while ((cpu_node = of_find_node_by_type(cpu_node, "cpu")) != NULL) {
-		/* Try interrupt server first */
-		interrupt_server = of_get_property(cpu_node,
-					"ibm,ppc-interrupt-server#s", &len);
-
-		len = len / sizeof(u32);
-
-		if (interrupt_server && (len > 0)) {
-			while (len--) {
-				if (interrupt_server[len] == hw_cpuid)
-					return cpu_node;
-			}
-		} else {
-			reg = of_get_property(cpu_node, "reg", &len);
-			if (reg && (len > 0) && (reg[0] == hw_cpuid))
-				return cpu_node;
-		}
-	}
-
-	return NULL;
-}
-
 /* must hold reference to node during call */
 static const int *of_get_associativity(struct device_node *dev)
 {
@@ -469,7 +440,7 @@ static int of_drconf_to_nid_single(struc
 static int __cpuinit numa_setup_cpu(unsigned long lcpu)
 {
 	int nid = 0;
-	struct device_node *cpu = find_cpu_node(lcpu);
+	struct device_node *cpu = of_get_cpu_node(lcpu, NULL);
 
 	if (!cpu) {
 		WARN_ON(1);
@@ -651,7 +622,7 @@ static int __init parse_numa_properties(
 	for_each_present_cpu(i) {
 		int nid;
 
-		cpu = find_cpu_node(i);
+		cpu = of_get_cpu_node(i, NULL);
 		BUG_ON(!cpu);
 		nid = of_node_to_nid_single(cpu);
 		of_node_put(cpu);
