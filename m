Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yd7X02MQLzDr5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 04:29:04 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAGHQ2pS014762
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 12:28:59 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2e9csc89b1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 12:28:59 -0500
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Thu, 16 Nov 2017 10:28:58 -0700
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, John Allen
 <jallen@linux.vnet.ibm.com>, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
In-Reply-To: <c88f7263-4f99-c13d-c4d2-9fa8f3d59b8f@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH V7 3/3] hotplug/cpu: Fix crash with memoryless nodes
Date: Thu, 16 Nov 2017 11:28:55 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <3445a368-d2d4-f908-5f0e-df7bbd659e07@linux.vnet.ibm.com>
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
Changes in V7:
  -- Make function find_cpu_nid() externally visible/usable so that
     it may be used from hotplug-cpu.c
---
 arch/powerpc/mm/numa.c                       |    3 ++-
 arch/powerpc/platforms/pseries/hotplug-cpu.c |    3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 163f4cc..d6d4f7c 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1310,7 +1310,7 @@ static long vphn_get_associativity(unsigned long cpu,
 	return rc;
 }
 
-static inline int find_cpu_nid(int cpu)
+int find_cpu_nid(int cpu)
 {
 	__be32 associativity[VPHN_ASSOC_BUFSIZE] = {0};
 	int new_nid;
@@ -1343,6 +1343,7 @@ static inline int find_cpu_nid(int cpu)
 #endif
 	}
 
+	printk(KERN_INFO "%s:%d cpu %d nid %d\n", __FUNCTION__, __LINE__, cpu, new_nid);
 	return new_nid;
 }
 
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index a7d14aa7..df8c732 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -340,6 +340,8 @@ static void pseries_remove_processor(struct device_node *np)
 	cpu_maps_update_done();
 }
 
+extern int find_cpu_nid(int cpu);
+
 static int dlpar_online_cpu(struct device_node *dn)
 {
 	int rc = 0;
@@ -364,6 +366,7 @@ static int dlpar_online_cpu(struct device_node *dn)
 					!= CPU_STATE_OFFLINE);
 			cpu_maps_update_done();
 			timed_topology_update(1);
+			find_cpu_nid(cpu);
 			rc = device_online(get_cpu_device(cpu));
 			if (rc)
 				goto out;
