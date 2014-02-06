Return-Path: <iamjoonsoo.kim@lge.com>
Received: from lgemrelse7q.lge.com (LGEMRELSE7Q.lge.com [156.147.1.151])
 by ozlabs.org (Postfix) with ESMTP id A67302C009C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Feb 2014 19:06:59 +1100 (EST)
From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: [RFC PATCH 3/3] slub: fallback to get_numa_mem() node if we want to
 allocate on memoryless node
Date: Thu,  6 Feb 2014 17:07:06 +0900
Message-Id: <1391674026-20092-3-git-send-email-iamjoonsoo.kim@lge.com>
In-Reply-To: <1391674026-20092-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <20140206020757.GC5433@linux.vnet.ibm.com>
 <1391674026-20092-1-git-send-email-iamjoonsoo.kim@lge.com>
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

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

diff --git a/mm/slub.c b/mm/slub.c
index cc1f995..c851f82 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1700,6 +1700,14 @@ static void *get_partial(struct kmem_cache *s, gfp_t flags, int node,
 	void *object;
 	int searchnode = (node == NUMA_NO_NODE) ? numa_mem_id() : node;
 
+	if (node == NUMA_NO_NODE)
+		searchnode = numa_mem_id();
+	else {
+		searchnode = node;
+		if (!node_present_pages(node))
+			searchnode = get_numa_mem(node);
+	}
+
 	object = get_partial_node(s, get_node(s, searchnode), c, flags);
 	if (object || node != NUMA_NO_NODE)
 		return object;
@@ -2277,11 +2285,18 @@ static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 redo:
 
 	if (unlikely(!node_match(page, node))) {
-		stat(s, ALLOC_NODE_MISMATCH);
-		deactivate_slab(s, page, c->freelist);
-		c->page = NULL;
-		c->freelist = NULL;
-		goto new_slab;
+		int searchnode = node;
+
+		if (node != NUMA_NO_NODE && !node_present_pages(node))
+			searchnode = get_numa_mem(node);
+
+		if (!node_match(page, searchnode)) {
+			stat(s, ALLOC_NODE_MISMATCH);
+			deactivate_slab(s, page, c->freelist);
+			c->page = NULL;
+			c->freelist = NULL;
+			goto new_slab;
+		}
 	}
 
 	/*
-- 
1.7.9.5
