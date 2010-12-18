Return-Path: <jlarrew@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9B022B70AA
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 18 Dec 2010 19:03:39 +1100 (EST)
Received: from d01dlp01.pok.ibm.com (d01dlp01.pok.ibm.com [9.56.224.56])
	by e8.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id oBI7lGDu006283
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Dec 2010 02:47:16 -0500
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id BAF87728042
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 18 Dec 2010 03:03:34 -0500 (EST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oBI83XDJ439426
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Dec 2010 03:03:34 -0500
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id oBI87n3q020470
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Dec 2010 01:07:50 -0700
Date: Sat, 18 Dec 2010 01:07:47 -0700
From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Message-Id: <20101218080330.16701.36542.sendpatchset@manic8ball.ltc.austin.ibm.com>
Subject: [PATCH V2] powerpc/pseries: Fix VPHN build errors on non-SMP systems
Cc: markn@au1.ibm.com, tbreeds@au1.ibm.com, lkessler@us.ibm.com,
	Jesse Larrew <jlarrew@linux.vnet.ibm.com>, mjwolf@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>

The header asm/hvcall.h was previously included indirectly via
smp.h. On non-SMP systems, however, these declarations are excluded
and the build breaks. This is easily fixed by including asm/hvcall.h
directly.

The VPHN feature is only meaningful on NUMA systems that implement
the SPLPAR option, so exclude the VPHN code on systems without
SPLPAR enabled.

Also, expose unmap_cpu_from_node() on systems with SPLPAR enabled,
even if CONFIG_HOTPLUG_CPU is disabled.

Lastly, map_cpu_to_node() is now needed by VPHN to manipulate the
node masks after boot time, so remove the __cpuinit annotation to
fix a section mismatch.

Signed-off-by: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/topology.h |   20 +++++++++++---------
 arch/powerpc/mm/numa.c              |    9 ++++++---
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index aed188b..fbfcfd0 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -93,9 +93,20 @@ extern void __init dump_numa_cpu_topology(void);
 extern int sysfs_add_device_to_node(struct sys_device *dev, int nid);
 extern void sysfs_remove_device_from_node(struct sys_device *dev, int nid);
 
+#ifdef CONFIG_PPC_SPLPAR
 extern int start_topology_update(void);
 extern int stop_topology_update(void);
 #else
+static inline int start_topology_update(void)
+{
+	return 0;
+}
+static inline int stop_topology_update(void)
+{
+	return 0;
+}
+#endif /* CONFIG_PPC_SPLPAR */
+#else
 
 static inline void dump_numa_cpu_topology(void) {}
 
@@ -108,15 +119,6 @@ static inline void sysfs_remove_device_from_node(struct sys_device *dev,
 						int nid)
 {
 }
-
-static inline int start_topology_update(void)
-{
-	return 0;
-}
-static inline int stop_topology_update(void)
-{
-	return 0;
-}
 #endif /* CONFIG_NUMA */
 
 #include <asm-generic/topology.h>
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 42aa7d1..8f8845e 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -28,6 +28,7 @@
 #include <asm/smp.h>
 #include <asm/firmware.h>
 #include <asm/paca.h>
+#include <asm/hvcall.h>
 
 static int numa_enabled = 1;
 
@@ -167,7 +168,7 @@ static void __init get_node_active_region(unsigned long start_pfn,
 	work_with_active_regions(nid, get_active_region_work_fn, node_ar);
 }
 
-static void __cpuinit map_cpu_to_node(int cpu, int node)
+static void map_cpu_to_node(int cpu, int node)
 {
 	numa_cpu_lookup_table[cpu] = node;
 
@@ -177,7 +178,7 @@ static void __cpuinit map_cpu_to_node(int cpu, int node)
 		cpumask_set_cpu(cpu, node_to_cpumask_map[node]);
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_PPC_SPLPAR)
 static void unmap_cpu_from_node(unsigned long cpu)
 {
 	int node = numa_cpu_lookup_table[cpu];
@@ -191,7 +192,7 @@ static void unmap_cpu_from_node(unsigned long cpu)
 		       cpu, node);
 	}
 }
-#endif /* CONFIG_HOTPLUG_CPU */
+#endif /* CONFIG_HOTPLUG_CPU || CONFIG_PPC_SPLPAR */
 
 /* must hold reference to node during call */
 static const int *of_get_associativity(struct device_node *dev)
@@ -1263,6 +1264,7 @@ int hot_add_scn_to_nid(unsigned long scn_addr)
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
 /* Vrtual Processor Home Node (VPHN) support */
+#ifdef CONFIG_PPC_SPLPAR
 #define VPHN_NR_CHANGE_CTRS (8)
 static u8 vphn_cpu_change_counts[NR_CPUS][VPHN_NR_CHANGE_CTRS];
 static cpumask_t cpu_associativity_changes_mask;
@@ -1505,3 +1507,4 @@ int stop_topology_update(void)
 	vphn_enabled = 0;
 	return del_timer_sync(&topology_timer);
 }
+#endif /* CONFIG_PPC_SPLPAR */
-- 
1.7.2.3
