Return-Path: <wangnan0@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 578671A013F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jul 2014 18:17:09 +1000 (EST)
From: Wang Nan <wangnan0@huawei.com>
To: Ingo Molnar <mingo@redhat.com>, Yinghai Lu <yinghai@kernel.org>, "Mel
 Gorman" <mgorman@suse.de>, Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/5] memory-hotplug: ia64: suitable memory should go to
 ZONE_MOVABLE
Date: Fri, 18 Jul 2014 15:56:01 +0800
Message-ID: <1405670163-53747-4-git-send-email-wangnan0@huawei.com>
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
and lower than newly added memory for ia64.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 arch/ia64/mm/init.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index 25c3502..d81c916 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -625,6 +625,7 @@ int arch_add_memory(int nid, u64 start, u64 size)
 {
 	pg_data_t *pgdat;
 	struct zone *zone;
+	struct zone *movable_zone;
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 	int ret;
@@ -632,6 +633,12 @@ int arch_add_memory(int nid, u64 start, u64 size)
 	pgdat = NODE_DATA(nid);
 
 	zone = pgdat->node_zones + ZONE_NORMAL;
+	movable_zone = pgdat->node_zones + ZONE_MOVABLE;
+	if (!zone_is_empty(movable_zone))
+		if (zone_spans_pfn(movable_zone, start_pfn) ||
+				(zone_end_pfn(movable_zone) <= start_pfn))
+			zone = movable_zone;
+
 	ret = __add_pages(nid, zone, start_pfn, nr_pages);
 
 	if (ret)
-- 
1.8.4
