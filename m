Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41S3yy331jzF36C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jul 2018 06:18:18 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6DKG6nn110787
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2018 16:18:16 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2k705cxgsr-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2018 16:18:16 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Fri, 13 Jul 2018 16:18:14 -0400
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH v07 5/9] numa: Disable/enable arch_update_cpu_topology
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
In-Reply-To: <458ff569-f611-f506-afa1-138146551dde@linux.vnet.ibm.com>
Date: Fri, 13 Jul 2018 15:18:11 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <6fb35793-0400-6fdb-a1b6-5741df103f2e@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

numa: Provide mechanism to disable/enable operation of
arch_update_cpu_topology/numa_update_cpu_topology.  This is
a simple tool to eliminate some avenues for thread deadlock
observed during system execution.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/topology.h |   10 ++++++++++
 arch/powerpc/mm/numa.c              |   14 ++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index 16b0778..d9ceba6 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -43,6 +43,8 @@ static inline int pcibus_to_node(struct pci_bus *bus)
 extern int sysfs_add_device_to_node(struct device *dev, int nid);
 extern void sysfs_remove_device_from_node(struct device *dev, int nid);
 extern int numa_update_cpu_topology(bool cpus_locked);
+extern void arch_update_cpu_topology_suspend(void);
+extern void arch_update_cpu_topology_resume(void);
 
 static inline void update_numa_cpu_lookup_table(unsigned int cpu, int node)
 {
@@ -82,6 +84,14 @@ static inline int numa_update_cpu_topology(bool cpus_locked)
 	return 0;
 }
 
+static inline void arch_update_cpu_topology_suspend(void)
+{
+}
+
+static inline void arch_update_cpu_topology_resume(void)
+{
+}
+
 static inline void update_numa_cpu_lookup_table(unsigned int cpu, int node) {}
 
 #endif /* CONFIG_NUMA */
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index b22e27a..2352489 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1079,6 +1079,7 @@ struct topology_update_data {
 static int topology_timer_secs = 1;
 static int topology_inited;
 static int topology_update_needed;
+static int topology_update_enabled = 1;
 static struct mutex topology_update_lock;
 
 /*
@@ -1313,6 +1314,9 @@ int numa_update_cpu_topology(bool cpus_locked)
 		return 0;
 	}
 
+	if (!topology_update_enabled)
+		return 0;
+
 	weight = cpumask_weight(&cpu_associativity_changes_mask);
 	if (!weight)
 		return 0;
@@ -1439,6 +1443,16 @@ int arch_update_cpu_topology(void)
 	return numa_update_cpu_topology(true);
 }
 
+void arch_update_cpu_topology_suspend(void)
+{
+	topology_update_enabled = 0;
+}
+
+void arch_update_cpu_topology_resume(void)
+{
+	topology_update_enabled = 1;
+}
+
 static void topology_work_fn(struct work_struct *work)
 {
 	rebuild_sched_domains();
