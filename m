Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 30C771A0006
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Mar 2015 05:06:37 +1100 (AEDT)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Thu, 5 Mar 2015 11:06:35 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id CA2941FF0023
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Mar 2015 10:57:44 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t25I6UHS26214444
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Mar 2015 11:06:30 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t25I67Zo011780
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Mar 2015 11:06:08 -0700
Date: Thu, 5 Mar 2015 10:05:49 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [RFC PATCH] powerpc/numa: reset node_possible_map to only
 node_online_map
Message-ID: <20150305180549.GA29601@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 David Rientjes <rientjes@google.com>, Tejun Heo <tj@kernel.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Raghu noticed an issue with excessive memory allocation on power with a
simple cgroup test, specifically, in mem_cgroup_css_alloc ->
for_each_node -> alloc_mem_cgroup_per_zone_info(), which ends up blowing
up the kmalloc-2048 slab (to the order of 200MB for 400 cgroup
directories).

The underlying issue is that NODES_SHIFT on power is 8 (256 NUMA nodes
possible), which defines node_possible_map, which in turn defines the
iteration of for_each_node.

In practice, we never see a system with 256 NUMA nodes, and in fact, we
do not support node hotplug on power in the first place, so the nodes
that are online when we come up are the nodes that will be present for
the lifetime of this kernel. So let's, at least, drop the NUMA possible
map down to the online map at runtime. This is similar to what x86 does
in its initialization routines.

One could alternatively nodemask_and(node_possible_map,
node_online_map), but I think the cost of anding the two will always be
higher than zero and set a few bits in practice.

Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>

---
While looking at this, I noticed that nr_node_ids is actually a
misnomer, it seems. It's not the number, but the maximum_node_id, as
with sparse NUMA nodes, you might only have two NUMA nodes possible, but
to make certain loops work, nr_node_ids will be, e.g., 17. Should it be
changed?

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 0257a7d659ef..24de29b3651b 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -958,9 +958,17 @@ void __init initmem_init(void)
 
 	memblock_dump_all();
 
+	/*
+	 * zero out the possible nodes after we parse the device-tree,
+	 * so that we lower the maximum NUMA node ID to what is actually
+	 * present.
+	 */
+	nodes_clear(node_possible_map);
+
 	for_each_online_node(nid) {
 		unsigned long start_pfn, end_pfn;
 
+		node_set(nid, node_possible_map);
 		get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
 		setup_node_data(nid, start_pfn, end_pfn);
 		sparse_memory_present_with_active_regions(nid);
