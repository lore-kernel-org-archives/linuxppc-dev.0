Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41B2f45LLNzF13G
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 10:30:04 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5L0SvcC103069
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 20:30:02 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jqvwx93yx-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 20:30:02 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 20 Jun 2018 18:30:01 -0600
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Subject: [PATCH v04 5/9] numa: Disable/enable arch_update_cpu_topology
In-Reply-To: <0425b353-54b0-6ccd-fbb6-3d26d9448bb5@linux.vnet.ibm.com>
Date: Wed, 20 Jun 2018 19:29:57 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <9d7f62eb-7296-5ccc-3ff5-12535bc45eef@linux.vnet.ibm.com>
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
index d4543b3..13c0068 100644
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
