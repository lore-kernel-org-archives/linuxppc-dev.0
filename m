Return-Path: <wangnan0@huawei.com>
Received: from lhrrgout.huawei.com (lhrrgout.huawei.com [194.213.3.17])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A72C71A01D0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jul 2014 18:41:39 +1000 (EST)
From: Wang Nan <wangnan0@huawei.com>
To: Ingo Molnar <mingo@redhat.com>, Yinghai Lu <yinghai@kernel.org>, "Mel
 Gorman" <mgorman@suse.de>, Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4/5] memory-hotplug: sh: suitable memory should go to
 ZONE_MOVABLE
Date: Fri, 18 Jul 2014 15:56:02 +0800
Message-ID: <1405670163-53747-5-git-send-email-wangnan0@huawei.com>
In-Reply-To: <1405670163-53747-1-git-send-email-wangnan0@huawei.com>
References: <1405670163-53747-1-git-send-email-wangnan0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-ia64@vger.kernel.org, Pei Feiyue <peifeiyue@huawei.com>,
 linux-sh@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch add new memory to ZONE_MOVABLE if movable zone is setup
and lower than newly added memory for sh.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 arch/sh/mm/init.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index 2d089fe..ff9decc 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -487,16 +487,19 @@ void free_initrd_mem(unsigned long start, unsigned long end)
 #ifdef CONFIG_MEMORY_HOTPLUG
 int arch_add_memory(int nid, u64 start, u64 size)
 {
-	pg_data_t *pgdat;
+	pg_data_t *pgdat = NODE_DATA(nid);
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
+	struct zone *zone = pgdat->node_zones + ZONE_NORMAL;
+	struct zone *movable_zone = pgdat->node_zones + ZONE_MOVABLE;
 	int ret;
 
-	pgdat = NODE_DATA(nid);
+	if (!zone_is_empty(movable_zone))
+		if (zone_spans_pfn(movable_zone, start_pfn) ||
+				(zone_end_pfn(movable_zone) <= start_pfn))
+			zone = movable_zone;
 
-	/* We only have ZONE_NORMAL, so this is easy.. */
-	ret = __add_pages(nid, pgdat->node_zones + ZONE_NORMAL,
-				start_pfn, nr_pages);
+	ret = __add_pages(nid, zone, start_pfn, nr_pages);
 	if (unlikely(ret))
 		printk("%s: Failed, __add_pages() == %d\n", __func__, ret);
 
-- 
1.8.4
