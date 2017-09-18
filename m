Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xwvf972K9zDqGs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 04:28:49 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8IIOQTF085090
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Sep 2017 14:28:47 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d2ea04hm1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Sep 2017 14:28:46 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 18 Sep 2017 14:28:46 -0400
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH 2/2] powerpc/hotplug: Ensure nodes initialized for hotplug
In-Reply-To: <49626c85-d466-3f99-bde8-f459e278f6ee@linux.vnet.ibm.com>
Date: Mon, 18 Sep 2017 13:28:41 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <a5f7fdb2-d974-03c6-5ecc-c7f726f2b244@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc/hotplug: On systems like PowerPC which allow 'hot-add' of CPU,
it may occur that the new resources are to be inserted into nodes
that were not used for memory resources at bootup.  Many different
configurations of PowerPC resources may need to be supported depending
upon the environment.  This patch fixes some problems encountered at
runtime with configurations that support memory-less nodes, but which
allow CPUs to be added at and after boot.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index b385cd0..e811dd1 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -551,7 +551,7 @@ static int numa_setup_cpu(unsigned long lcpu)
 	nid = of_node_to_nid_single(cpu);
 
 out_present:
-	if (nid < 0 || !node_online(nid))
+	if (nid < 0 || !node_possible(nid))
 		nid = first_online_node;
 
 	map_cpu_to_node(lcpu, nid);
@@ -1325,6 +1325,17 @@ static long vphn_get_associativity(unsigned long cpu,
 	return rc;
 }
 
+static int verify_node_preparation(int nid)
+{
+	if ((NODE_DATA(nid) == NULL) ||
+	    (NODE_DATA(nid)->node_spanned_pages == 0)) {
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
@@ -1433,9 +1444,11 @@ int numa_update_cpu_topology(bool cpus_locked)
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
