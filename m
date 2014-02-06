Return-Path: <iamjoonsoo.kim@lge.com>
Received: from lgemrelse7q.lge.com (LGEMRELSE7Q.lge.com [156.147.1.151])
 by ozlabs.org (Postfix) with ESMTP id A474F2C009B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Feb 2014 19:06:59 +1100 (EST)
From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: [RFC PATCH 1/3] slub: search partial list on numa_mem_id(),
 instead of numa_node_id()
Date: Thu,  6 Feb 2014 17:07:04 +0900
Message-Id: <1391674026-20092-1-git-send-email-iamjoonsoo.kim@lge.com>
In-Reply-To: <20140206020757.GC5433@linux.vnet.ibm.com>
References: <20140206020757.GC5433@linux.vnet.ibm.com>
Cc: Han Pingtian <hanpt@linux.vnet.ibm.com>, mpm@selenic.com,
 penberg@kernel.org, linux-mm@kvack.org, paulus@samba.org,
 Anton Blanchard <anton@samba.org>, David Rientjes <rientjes@google.com>,
 Christoph Lameter <cl@linux.com>, linuxppc-dev@lists.ozlabs.org,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, if allocation constraint to node is NUMA_NO_NODE, we search
a partial slab on numa_node_id() node. This doesn't work properly on the
system having memoryless node, since it can have no memory on that node and
there must be no partial slab on that node.

On that node, page allocation always fallback to numa_mem_id() first. So
searching a partial slab on numa_node_id() in that case is proper solution
for memoryless node case.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

diff --git a/mm/slub.c b/mm/slub.c
index 545a170..cc1f995 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1698,7 +1698,7 @@ static void *get_partial(struct kmem_cache *s, gfp_t flags, int node,
 		struct kmem_cache_cpu *c)
 {
 	void *object;
-	int searchnode = (node == NUMA_NO_NODE) ? numa_node_id() : node;
+	int searchnode = (node == NUMA_NO_NODE) ? numa_mem_id() : node;
 
 	object = get_partial_node(s, get_node(s, searchnode), c, flags);
 	if (object || node != NUMA_NO_NODE)
-- 
1.7.9.5
