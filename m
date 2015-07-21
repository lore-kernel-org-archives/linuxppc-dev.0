Return-Path: <chris.j.arges@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9343E1A0A23
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 03:36:45 +1000 (AEST)
From: Chris J Arges <chris.j.arges@canonical.com>
To: nacc@linux.vnet.ibm.com,
	pshelar@nicira.com
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 linux-numa@vger.kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 dev@openvswitch.org, linux-kernel@vger.kernel.org,
 Chris J Arges <chris.j.arges@canonical.com>
Subject: [PATCH v2] openvswitch: allocate nr_node_ids flow_stats instead of
 num_possible_nodes
Date: Tue, 21 Jul 2015 12:36:33 -0500
Message-Id: <1437500193-10255-1-git-send-email-chris.j.arges@canonical.com>
In-Reply-To: <20150721162418.GM38815@linux.vnet.ibm.com>
References: <20150721162418.GM38815@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some architectures like POWER can have a NUMA node_possible_map that
contains sparse entries. This causes memory corruption with openvswitch
since it allocates flow_cache with a multiple of num_possible_nodes() and
assumes the node variable returned by for_each_node will index into
flow->stats[node].

Use nr_node_ids to allocate a maximal sparse array instead of
num_possible_nodes().

The crash was noticed after 3af229f2 was applied as it changed the
node_possible_map to match node_online_map on boot.
Fixes: 3af229f2071f5b5cb31664be6109561fbe19c861

Signed-off-by: Chris J Arges <chris.j.arges@canonical.com>
---
 net/openvswitch/flow_table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/openvswitch/flow_table.c b/net/openvswitch/flow_table.c
index 4613df8..6552394 100644
--- a/net/openvswitch/flow_table.c
+++ b/net/openvswitch/flow_table.c
@@ -752,7 +752,7 @@ int ovs_flow_init(void)
 	BUILD_BUG_ON(sizeof(struct sw_flow_key) % sizeof(long));
 
 	flow_cache = kmem_cache_create("sw_flow", sizeof(struct sw_flow)
-				       + (num_possible_nodes()
+				       + (nr_node_ids
 					  * sizeof(struct flow_stats *)),
 				       0, 0, NULL);
 	if (flow_cache == NULL)
-- 
1.9.1
