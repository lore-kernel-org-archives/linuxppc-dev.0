Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJPCF0TkTzDvNS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 10:45:29 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id e9so12618839pgc.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 15:45:28 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
To: mpe@ellerman.id.au, hannes@cmpxchg.org, mhocko@kernel.org,
 vdavydov.dev@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 Balbir Singh <bsingharora@gmail.com>, Tejun Heo <tj@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [RESEND] [PATCH v1 3/3] powerpc: fix node_possible_map limitations
Date: Wed, 16 Nov 2016 10:45:01 +1100
Message-Id: <1479253501-26261-4-git-send-email-bsingharora@gmail.com>
In-Reply-To: <1479253501-26261-1-git-send-email-bsingharora@gmail.com>
References: <1479253501-26261-1-git-send-email-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We've fixed the memory hotplug issue with memcg, hence
this work around should not be required.

Reverts: commit 3af229f2071f
("powerpc/numa: Reset node_possible_map to only node_online_map")

Cc: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org> 
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Signed-off-by: Balbir Singh <bsingharora@gmail.com>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>

---
 arch/powerpc/mm/numa.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index a51c188..ca8c2ab 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -916,13 +916,6 @@ void __init initmem_init(void)
 
 	memblock_dump_all();
 
-	/*
-	 * Reduce the possible NUMA nodes to the online NUMA nodes,
-	 * since we do not support node hotplug. This ensures that  we
-	 * lower the maximum NUMA node ID to what is actually present.
-	 */
-	nodes_and(node_possible_map, node_possible_map, node_online_map);
-
 	for_each_online_node(nid) {
 		unsigned long start_pfn, end_pfn;
 
-- 
2.5.5
