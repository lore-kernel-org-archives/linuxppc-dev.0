Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ymfHF5s0BzDrb3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Nov 2017 09:59:05 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vASMrdak123651
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 17:59:03 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ehfhfuskc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 17:59:03 -0500
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 28 Nov 2017 17:59:02 -0500
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
In-Reply-To: <79bd4c96-2381-c9b1-8222-b350e069655b@linux.vnet.ibm.com>
Subject: [PATCH V8 3/3] hotplug/cpu: Fix crash with memoryless nodes
Date: Tue, 28 Nov 2017 16:58:43 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <55ff4b6a-7f43-e171-d214-cf10d466aa71@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On powerpc systems with shared configurations of CPUs and memory and
memoryless nodes at boot, an event ordering problem was observed on
a SLES12 build platforms with the hot-add of CPUs to the memoryless
nodes.

* The most common error occurred when the memory SLAB driver attempted
  to reference the memoryless node to which a CPU was being added
  before the kernel had finished initializing all of the data structures
  for the CPU and exited 'device_online' under DLPAR/hot-add.

  Normally the memoryless node would be initialized through the call
  path device_online ... arch_update_cpu_topology ... find_cpu_nid
  ...  try_online_node.  This patch ensures that the powerpc node will
  be initialized as early as possible, even if it was memoryless and
  CPU-less at the point when we are trying to hot-add a new CPU to it.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
Changes in V8:
  -- Change a 'printk(KERN_INFO ...)' statement to be a pr_debug()
     statement.
  -- Rename 'find_cpu_nid' to 'find_and_online_cpu_nid' for better
     clarity of its function.
---
 arch/powerpc/mm/numa.c                       |    4 +++-
 arch/powerpc/platforms/pseries/hotplug-cpu.c |    3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 6b08dd8..a182f9e 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1307,7 +1307,7 @@ static long vphn_get_associativity(unsigned long cpu,
 	return rc;
 }
 
-static inline int find_and_online_cpu_nid(int cpu)
+int find_and_online_cpu_nid(int cpu)
 {
 	__be32 associativity[VPHN_ASSOC_BUFSIZE] = {0};
 	int new_nid;
@@ -1340,6 +1340,8 @@ static inline int find_and_online_cpu_nid(int cpu)
 #endif
 	}
 
+	pr_debug("%s:%d cpu %d nid %d\n", __FUNCTION__, __LINE__,
+		cpu, new_nid);
 	return new_nid;
 }
 
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index a7d14aa7..dceb514 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -340,6 +340,8 @@ static void pseries_remove_processor(struct device_node *np)
 	cpu_maps_update_done();
 }
 
+extern int find_and_online_cpu_nid(int cpu);
+
 static int dlpar_online_cpu(struct device_node *dn)
 {
 	int rc = 0;
@@ -364,6 +366,7 @@ static int dlpar_online_cpu(struct device_node *dn)
 					!= CPU_STATE_OFFLINE);
 			cpu_maps_update_done();
 			timed_topology_update(1);
+			find_and_online_cpu_nid(cpu);
 			rc = device_online(get_cpu_device(cpu));
 			if (rc)
 				goto out;
