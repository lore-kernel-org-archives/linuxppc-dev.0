Return-Path: <wangnan0@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 644041A07E7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jul 2014 18:14:28 +1000 (EST)
From: Wang Nan <wangnan0@huawei.com>
To: Ingo Molnar <mingo@redhat.com>, Yinghai Lu <yinghai@kernel.org>, "Mel
 Gorman" <mgorman@suse.de>, Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/5] memory-hotplug: x86_32: suitable memory should go to
 ZONE_MOVABLE
Date: Fri, 18 Jul 2014 15:56:00 +0800
Message-ID: <1405670163-53747-3-git-send-email-wangnan0@huawei.com>
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
and lower than newly added memory for x86_32.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 arch/x86/mm/init_32.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index e395048..dd69833 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -826,9 +826,15 @@ int arch_add_memory(int nid, u64 start, u64 size)
 {
 	struct pglist_data *pgdata = NODE_DATA(nid);
 	struct zone *zone = pgdata->node_zones + ZONE_HIGHMEM;
+	struct zone *movable_zone = pgdat->node_zones + ZONE_MOVABLE;
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 
+	if (!zone_is_empty(movable_zone))
+		if (zone_spans_pfn(movable_zone, start_pfn) ||
+				(zone_end_pfn(movable_zone) <= start_pfn))
+			zone = movable_zone;
+
 	return __add_pages(nid, zone, start_pfn, nr_pages);
 }
 
-- 
1.8.4
