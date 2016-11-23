Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNqLh2KvszDvyg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 15:37:16 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id e9so196567pgc.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 20:37:16 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
To: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [mm v2 1/3] mm: Add basic infrastructure for memcg hotplug support
Date: Wed, 23 Nov 2016 15:36:52 +1100
Message-Id: <1479875814-11938-2-git-send-email-bsingharora@gmail.com>
In-Reply-To: <1479875814-11938-1-git-send-email-bsingharora@gmail.com>
References: <1479875814-11938-1-git-send-email-bsingharora@gmail.com>
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
 mm/memcontrol.c | 46 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 175ec51..5482c7d 100644
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
@@ -4106,14 +4107,7 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
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
@@ -5764,6 +5758,41 @@ static int __init cgroup_memory(char *s)
 }
 __setup("cgroup.memory=", cgroup_memory);
 
+static void memcg_node_offline(int node)
+{
+}
+
+static void memcg_node_online(int node)
+{
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
+	case MEM_CANCEL_OFFLINE:
+	case MEM_ONLINE:
+		break;
+	case MEM_GOING_ONLINE:
+		memcg_node_online(node);
+		break;
+	case MEM_CANCEL_ONLINE:
+	case MEM_OFFLINE:
+		memcg_node_offline(node);
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
@@ -5789,6 +5818,7 @@ static int __init mem_cgroup_init(void)
 
 	cpuhp_setup_state_nocalls(CPUHP_MM_MEMCQ_DEAD, "mm/memctrl:dead", NULL,
 				  memcg_hotplug_cpu_dead);
+	register_hotmemory_notifier(&memcg_memory_hotplug_nb);
 
 	for_each_possible_cpu(cpu)
 		INIT_WORK(&per_cpu_ptr(&memcg_stock, cpu)->work,
-- 
2.5.5
