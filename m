Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHNS35x4tzDq8f
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 07:09:07 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9IK5mJX087045
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 16:09:05 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dpbse6mvc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 16:09:05 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 18 Oct 2017 16:09:04 -0400
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
In-Reply-To: <cd1c9d3f-c828-2477-ff31-fb6277a8a2aa@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH V2 2/3] pseries/findnodes: Find nodes with memory for
 memoryless nodes
Date: Wed, 18 Oct 2017 15:09:01 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <bcccffb8-8472-463d-cca5-698db5cbc8e1@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


pseries/findnodes: On pseries systems which allow 'hot-add' of
resources, we may boot configurations that have CPUs, but no memory
associated to a node by the affinity calculations.  Previously, the
software took a shortcut to collapse initialization and references
to such memoryless nodes with other nodes that did have memory
associated with them at boot.  This patch is based on fixes that
allow the proper initialization and distinguishment of memoryless
and memory-plus nodes after NUMA initialization.  It extends the
use of the 'node_to_mem_node()' API from 'topology.h' to modules
that are allocating node-specific memory at boot, and allows such
references to find available memory in another node.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 block/blk-mq-cpumap.c |    3 ++-
 mm/page_alloc.c       |    1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 9f8cffc..a27a31f 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -73,7 +73,8 @@ int blk_mq_hw_queue_to_node(unsigned int *mq_map, unsigned int index)
 
 	for_each_possible_cpu(i) {
 		if (index == mq_map[i])
-			return local_memory_node(cpu_to_node(i));
+			return local_memory_node(
+					node_to_mem_node(cpu_to_node(i)));
 	}
 
 	return NUMA_NO_NODE;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 77e4d3c..e7aaa2a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4188,6 +4188,7 @@ struct page *
 
 	gfp_mask &= gfp_allowed_mask;
 	alloc_mask = gfp_mask;
+	preferred_nid = node_to_mem_node(preferred_nid);
 	if (!prepare_alloc_pages(gfp_mask, order, preferred_nid, nodemask, &ac, &alloc_mask, &alloc_flags))
 		return NULL;
 
