Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHnDQ0tc2zDvj3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 10:44:22 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id x23so10104131pgx.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 15:44:22 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
To: linux-mm@kvack.org
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 akpm@linux-foundation.org, tj@kernel.org,
 Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v1 1/3] Add basic infrastructure for memcg hotplug support
Date: Tue, 15 Nov 2016 10:44:03 +1100
Message-Id: <1479167045-28136-2-git-send-email-bsingharora@gmail.com>
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

The lack of hotplug support makes us allocate all memory
upfront for per node data structures. With large number
of cgroups this can be an overhead. PPC64 actually limits
n_possible nodes to n_online to avoid some of this overhead.

This patch adds the basic notifiers to listen to hotplug
events and does the allocation and free of those structures
per cgroup. We walk every cgroup per event, its a trade-off
of allocating upfront vs allocating on demand and freeing
on offline.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 mm/memcontrol.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 60 insertions(+), 8 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 91dfc7c..5585fce 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -63,6 +63,7 @@
 #include <linux/lockdep.h>
 #include <linux/file.h>
 #include <linux/tracehook.h>
+#include <linux/memory.h>
 #include "internal.h"
 #include <net/sock.h>
 #include <net/ip.h>
@@ -1342,6 +1343,10 @@ int mem_cgroup_select_victim_node(struct mem_cgroup *memcg)
 {
 	return 0;
 }
+
+static void mem_cgroup_may_update_nodemask(struct mem_cgroup *memcg)
+{
+}
 #endif
 
 static int mem_cgroup_soft_reclaim(struct mem_cgroup *root_memcg,
@@ -4115,14 +4120,7 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 {
 	struct mem_cgroup_per_node *pn;
 	int tmp = node;
-	/*
-	 * This routine is called against possible nodes.
-	 * But it's BUG to call kmalloc() against offline node.
-	 *
-	 * TODO: this routine can waste much memory for nodes which will
-	 *       never be onlined. It's better to use memory hotplug callback
-	 *       function.
-	 */
+
 	if (!node_state(node, N_NORMAL_MEMORY))
 		tmp = -1;
 	pn = kzalloc_node(sizeof(*pn), GFP_KERNEL, tmp);
@@ -5773,6 +5771,59 @@ static int __init cgroup_memory(char *s)
 }
 __setup("cgroup.memory=", cgroup_memory);
 
+static void memcg_node_offline(int node)
+{
+	struct mem_cgroup *memcg;
+
+	if (node < 0)
+		return;
+
+	for_each_mem_cgroup(memcg) {
+		free_mem_cgroup_per_node_info(memcg, node);
+		mem_cgroup_may_update_nodemask(memcg);
+	}
+}
+
+static void memcg_node_online(int node)
+{
+	struct mem_cgroup *memcg;
+
+	if (node < 0)
+		return;
+
+	for_each_mem_cgroup(memcg) {
+		alloc_mem_cgroup_per_node_info(memcg, node);
+		mem_cgroup_may_update_nodemask(memcg);
+	}
+}
+
+static int memcg_memory_hotplug_callback(struct notifier_block *self,
+					unsigned long action, void *arg)
+{
+	struct memory_notify *marg = arg;
+	int node = marg->status_change_nid;
+
+	switch (action) {
+	case MEM_GOING_OFFLINE:
+	case MEM_CANCEL_ONLINE:
+		memcg_node_offline(node);
+		break;
+	case MEM_GOING_ONLINE:
+	case MEM_CANCEL_OFFLINE:
+		memcg_node_online(node);
+		break;
+	case MEM_ONLINE:
+	case MEM_OFFLINE:
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block memcg_memory_hotplug_nb __meminitdata = {
+	.notifier_call = memcg_memory_hotplug_callback,
+	.priority = IPC_CALLBACK_PRI,
+};
+
 /*
  * subsys_initcall() for memory controller.
  *
@@ -5797,6 +5848,7 @@ static int __init mem_cgroup_init(void)
 #endif
 
 	hotcpu_notifier(memcg_cpu_hotplug_callback, 0);
+	register_hotmemory_notifier(&memcg_memory_hotplug_nb);
 
 	for_each_possible_cpu(cpu)
 		INIT_WORK(&per_cpu_ptr(&memcg_stock, cpu)->work,
-- 
2.5.5
