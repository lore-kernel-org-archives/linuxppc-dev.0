Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ys4Nk4fwBzF0GN
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Dec 2017 14:49:09 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vB63mjME099408
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Dec 2017 22:49:06 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ep8ym00da-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Dec 2017 22:49:06 -0500
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 5 Dec 2017 22:49:06 -0500
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 vB63n28N38469732
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Dec 2017 03:49:02 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C1988B204D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Dec 2017 22:46:09 -0500 (EST)
Received: from ltcalpine2-lp14.aus.stglabs.ibm.com (unknown [9.40.195.197])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP id 87783B2050
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Dec 2017 22:46:09 -0500 (EST)
Subject: [PATCH V2] powerpc/pseries: Invalidate numa_cpu_lookup_table on cpu
 remove
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Tue, 05 Dec 2017 21:33:35 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <151253089428.9767.11338558114386276250.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When DLPAR removing a CPU we need to invalidate its entry in the
numa_cpu_lookup_table. There is no guarantee that on a subsequent
DLPAR add of the CPU the associativity will be the same and thus it
could be in a different node. Invalidating the entry in the
numa_cpu_lookup_table causes the associativity to be read from the
device tree at the time of the add.

The current behavior of not invalidating the CPUs entry in the
numa_cpu_lookup_table can result in scenarios where the the topology
layout of CPUs in the partition does not match the device tree
or the topology reported by the HMC.

This patch move the update_numa_cpu_lookup_table to topology.h so it is
available outside of numa.c. A call to this routine is added in
pseries_remove_processor().

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---

Updates for V2: Move the invalidation from unmap_cpu_from_node to
pseries_remove_processor, the former routine is also called during cpu
offline and we do not want to invalidate during cpu offline.

 arch/powerpc/include/asm/topology.h          |    5 +++++
 arch/powerpc/mm/numa.c                       |    5 -----
 arch/powerpc/platforms/pseries/hotplug-cpu.c |    2 ++
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index 88187c285c70..1c02e6900f78 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -44,6 +44,11 @@ extern int sysfs_add_device_to_node(struct device *dev, int nid);
 extern void sysfs_remove_device_from_node(struct device *dev, int nid);
 extern int numa_update_cpu_topology(bool cpus_locked);
 
+static inline void update_numa_cpu_lookup_table(unsigned int cpu, int node)
+{
+	numa_cpu_lookup_table[cpu] = node;
+}
+
 static inline int early_cpu_to_node(int cpu)
 {
 	int nid;
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index adb6364f4091..09be66fcea68 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -142,11 +142,6 @@ static void reset_numa_cpu_lookup_table(void)
 		numa_cpu_lookup_table[cpu] = -1;
 }
 
-static void update_numa_cpu_lookup_table(unsigned int cpu, int node)
-{
-	numa_cpu_lookup_table[cpu] = node;
-}
-
 static void map_cpu_to_node(int cpu, int node)
 {
 	update_numa_cpu_lookup_table(cpu, node);
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index a7d14aa7bb7c..09083ad82f7a 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -36,6 +36,7 @@
 #include <asm/xics.h>
 #include <asm/xive.h>
 #include <asm/plpar_wrappers.h>
+#include <asm/topology.h>
 
 #include "pseries.h"
 #include "offline_states.h"
@@ -331,6 +332,7 @@ static void pseries_remove_processor(struct device_node *np)
 			BUG_ON(cpu_online(cpu));
 			set_cpu_present(cpu, false);
 			set_hard_smp_processor_id(cpu, -1);
+			update_numa_cpu_lookup_table(cpu, -1);
 			break;
 		}
 		if (cpu >= nr_cpu_ids)
