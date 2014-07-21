Return-Path: <wangnan0@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [119.145.14.64])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F03021A01F1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jul 2014 13:56:53 +1000 (EST)
From: Wang Nan <wangnan0@huawei.com>
To: Ingo Molnar <mingo@redhat.com>, Yinghai Lu <yinghai@kernel.org>, "Mel
 Gorman" <mgorman@suse.de>, Andrew Morton <akpm@linux-foundation.org>, "Dave
 Hansen" <dave.hansen@intel.com>, Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Subject: [PATCH v2 2/7] memory-hotplug: x86_64: suitable memory should go to
 ZONE_MOVABLE
Date: Mon, 21 Jul 2014 11:46:37 +0800
Message-ID: <1405914402-66212-3-git-send-email-wangnan0@huawei.com>
In-Reply-To: <1405914402-66212-1-git-send-email-wangnan0@huawei.com>
References: <1405914402-66212-1-git-send-email-wangnan0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: wangnan0@huawei.com, linux-ia64@vger.kernel.org, peifeiyue@huawei.com,
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

This patch introduces zone_for_memory() to arch_add_memory() on x86_64
to ensure new, higher memory added into ZONE_MOVABLE if movable zone has
already setup.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Cc: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Cc: Dave Hansen <dave.hansen@intel.com>
---
 arch/x86/mm/init_64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index df1a992..5621c47 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -691,7 +691,8 @@ static void  update_end_of_memory_vars(u64 start, u64 size)
 int arch_add_memory(int nid, u64 start, u64 size)
 {
 	struct pglist_data *pgdat = NODE_DATA(nid);
-	struct zone *zone = pgdat->node_zones + ZONE_NORMAL;
+	struct zone *zone = pgdat->node_zones +
+		zone_for_memory(nid, start, size, ZONE_NORMAL);
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 	int ret;
-- 
1.8.4
