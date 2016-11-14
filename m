Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHnDX683fzDvkF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 10:44:28 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id i88so6817322pfk.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 15:44:28 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
To: linux-mm@kvack.org
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 akpm@linux-foundation.org, tj@kernel.org,
 Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v1 3/3] powerpc: fix node_possible_map limitations
Date: Tue, 15 Nov 2016 10:44:05 +1100
Message-Id: <1479167045-28136-4-git-send-email-bsingharora@gmail.com>
In-Reply-To: <1479167045-28136-1-git-send-email-bsingharora@gmail.com>
References: <1479167045-28136-1-git-send-email-bsingharora@gmail.com>
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

Fixes: commit 3af229f2071f
("powerpc/numa: Reset node_possible_map to only node_online_map")

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
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
