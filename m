Return-Path: <jlarrew@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C6479B7082
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Dec 2010 10:53:50 +1100 (EST)
Received: from d01dlp01.pok.ibm.com (d01dlp01.pok.ibm.com [9.56.224.56])
	by e3.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id oBCNZfLD023316
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Dec 2010 18:35:41 -0500
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 9A889728042
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 12 Dec 2010 18:53:46 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oBCNrkZ32253046
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Dec 2010 18:53:46 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	oBCNrh03004865
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Dec 2010 18:53:44 -0500
Date: Sun, 12 Dec 2010 18:53:42 -0500
From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Message-Id: <20101212235342.3583.29397.sendpatchset@manic8ball.ltc.austin.ibm.com>
Subject: [PATCH] powerpc/pseries: Fix VPHN build errors on non-SMP systems
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

The VPHN feature is only meaningful on NUMA systems that implement
the SPLPAR option, so exclude the VPHN code on systems without
SPLPAR enabled.

This patch fixes a build problem on non-SMP systems introduced by the
following commits:

3b7a27db3b6b5501e3d1c1628e6d5a547ffe76c6
9eff1a38407c051273fe1a20f03f8155bd32de35

Signed-off-by: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/topology.h |   20 +++++++++++---------
 arch/powerpc/mm/numa.c              |    3 +++
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index aed188b..a2832b8 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -93,9 +93,20 @@ extern void __init dump_numa_cpu_topology(void);
 extern int sysfs_add_device_to_node(struct sys_device *dev, int nid);
 extern void sysfs_remove_device_from_node(struct sys_device *dev, int nid);
 
+#ifdef CONFIG_SPLPAR
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
+#endif /* CONFIG_SPLPAR */
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
index 42aa7d1..0f50941 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -28,6 +28,7 @@
 #include <asm/smp.h>
 #include <asm/firmware.h>
 #include <asm/paca.h>
+#include <asm/hvcall.h>
 
 static int numa_enabled = 1;
 
@@ -1263,6 +1264,7 @@ int hot_add_scn_to_nid(unsigned long scn_addr)
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
 /* Vrtual Processor Home Node (VPHN) support */
+#ifdef CONFIG_SPLPAR
 #define VPHN_NR_CHANGE_CTRS (8)
 static u8 vphn_cpu_change_counts[NR_CPUS][VPHN_NR_CHANGE_CTRS];
 static cpumask_t cpu_associativity_changes_mask;
@@ -1505,3 +1507,4 @@ int stop_topology_update(void)
 	vphn_enabled = 0;
 	return del_timer_sync(&topology_timer);
 }
+#endif /* CONFIG_SPLPAR */
-- 
1.7.2.3
