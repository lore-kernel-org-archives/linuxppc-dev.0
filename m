Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHNSG2NLqzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 07:09:18 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9IK4XW6081019
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 16:09:15 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dpbx4wwbe-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 16:09:15 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 18 Oct 2017 16:09:15 -0400
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
In-Reply-To: <cd1c9d3f-c828-2477-ff31-fb6277a8a2aa@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH V2 3/3] pseries/initnodes: Ensure nodes initialized for hotplug
Date: Wed, 18 Oct 2017 15:09:10 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <b24385eb-10ed-b934-8658-b55cece61146@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pseries/nodes: On pseries systems which allow 'hot-add' of CPU,
it may occur that the new resources are to be inserted into nodes
that were not used for memory resources at bootup.  Many different
configurations of PowerPC resources may need to be supported depending
upon the environment.  This patch fixes some problems encountered at
runtime with configurations that support memory-less nodes, or that
hot-add resources during system execution after boot.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c |   27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index f885ab7..2be6363 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -551,7 +551,7 @@ static int numa_setup_cpu(unsigned long lcpu)
 	nid = of_node_to_nid_single(cpu);
 
 out_present:
-	if (nid < 0 || !node_online(nid))
+	if (nid < 0 || !node_possible(nid))
 		nid = first_online_node;
 
 	map_cpu_to_node(lcpu, nid);
@@ -1311,6 +1311,25 @@ static long vphn_get_associativity(unsigned long cpu,
 	return rc;
 }
 
+static int verify_node_preparation(int nid)
+{
+	/*
+	 * Need to allocate/initialize NODE_DATA from a node with
+	 * memory (see memblock_alloc_try_nid).  Code executed after
+	 * boot (like local_memory_node) often does not know enough
+	 * to recover fully for memoryless nodes. 
+	 */
+	if (NODE_DATA(nid) == NULL) 
+		setup_node_data(nid, 0, 0);
+
+	if (NODE_DATA(nid)->node_spanned_pages == 0) {
+		if (try_online_node(nid))
+			return first_online_node;
+	}
+
+	return nid;
+}
+
 /*
  * Update the CPU maps and sysfs entries for a single CPU when its NUMA
  * characteristics change. This function doesn't perform any locking and is
@@ -1334,7 +1353,7 @@ static int update_cpu_topology(void *data)
 		unmap_cpu_from_node(cpu);
 		map_cpu_to_node(cpu, new_nid);
 		set_cpu_numa_node(cpu, new_nid);
-		set_cpu_numa_mem(cpu, local_memory_node(new_nid));
+		set_cpu_numa_mem(cpu, local_memory_node(node_to_mem_node(new_nid)));
 		vdso_getcpu_init();
 	}
 
@@ -1419,9 +1438,11 @@ int numa_update_cpu_topology(bool cpus_locked)
 		/* Use associativity from first thread for all siblings */
 		vphn_get_associativity(cpu, associativity);
 		new_nid = associativity_to_nid(associativity);
-		if (new_nid < 0 || !node_online(new_nid))
+		if (new_nid < 0 || !node_possible(new_nid))
 			new_nid = first_online_node;
 
+		new_nid = verify_node_preparation(new_nid);
+
 		if (new_nid == numa_cpu_lookup_table[cpu]) {
 			cpumask_andnot(&cpu_associativity_changes_mask,
 					&cpu_associativity_changes_mask,
