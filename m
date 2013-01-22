Return-Path: <tangchen@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id 971462C0240
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 22:46:52 +1100 (EST)
From: Tang Chen <tangchen@cn.fujitsu.com>
To: akpm@linux-foundation.org, rjw@sisk.pl, len.brown@intel.com,
 mingo@redhat.com, tglx@linutronix.de, minchan.kim@gmail.com,
 rientjes@google.com, benh@kernel.crashing.org, paulus@samba.org,
 cl@linux.com, kosaki.motohiro@jp.fujitsu.com,
 isimatu.yasuaki@jp.fujitsu.com, wujianguo@huawei.com,
 wency@cn.fujitsu.com, hpa@zytor.com, linfeng@cn.fujitsu.com,
 laijs@cn.fujitsu.com, mgorman@suse.de, yinghai@kernel.org,
 glommer@parallels.com, jiang.liu@huawei.com, julian.calaby@gmail.com,
 sfr@canb.auug.org.au
Subject: [PATCH Bug fix 4/5] cpu-hotplug,
 memory-hotplug: clear cpu_to_node() when offlining the node
Date: Tue, 22 Jan 2013 19:45:55 +0800
Message-Id: <1358855156-6126-5-git-send-email-tangchen@cn.fujitsu.com>
In-Reply-To: <1358855156-6126-1-git-send-email-tangchen@cn.fujitsu.com>
References: <1358855156-6126-1-git-send-email-tangchen@cn.fujitsu.com>
Cc: linux-acpi@vger.kernel.org, Mel Gorman <mel@csn.ul.ie>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 Jiang Liu <liuj97@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wen Congyang <wency@cn.fujitsu.com>

When the node is offlined, there is no memory/cpu on the node. If a
sleep task runs on a cpu of this node, it will be migrated to the
cpu on the other node. So we can clear cpu-to-node mapping.

Cc: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Jiang Liu <liuj97@gmail.com>
Cc: Minchan Kim <minchan.kim@gmail.com>
Cc: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mel Gorman <mel@csn.ul.ie>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tang Chen <tangchen@cn.fujitsu.com>
Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
---
 mm/memory_hotplug.c |   30 +++++++++++++++++++++++++++++-
 1 files changed, 29 insertions(+), 1 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index edd1773..022583b 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1702,6 +1702,34 @@ static int check_cpu_on_node(void *data)
 	return 0;
 }
 
+static void unmap_cpu_on_node(void *data)
+{
+#ifdef CONFIG_ACPI_NUMA
+	struct pglist_data *pgdat = data;
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		if (cpu_to_node(cpu) == pgdat->node_id)
+			numa_clear_node(cpu);
+#endif
+}
+
+static int check_and_unmap_cpu_on_node(void *data)
+{
+	int ret = check_cpu_on_node(data);
+
+	if (ret)
+		return ret;
+
+	/*
+	 * the node will be offlined when we come here, so we can clear
+	 * the cpu_to_node() now.
+	 */
+
+	unmap_cpu_on_node(data);
+	return 0;
+}
+
 /* offline the node if all memory sections of this node are removed */
 void try_offline_node(int nid)
 {
@@ -1728,7 +1756,7 @@ void try_offline_node(int nid)
 		return;
 	}
 
-	if (stop_machine(check_cpu_on_node, pgdat, NULL))
+	if (stop_machine(check_and_unmap_cpu_on_node, pgdat, NULL))
 		return;
 
 	/*
-- 
1.7.1
