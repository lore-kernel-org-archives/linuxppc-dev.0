Return-Path: <liuj97@gmail.com>
Received: from mail-pb0-f52.google.com (mail-pb0-f52.google.com
 [209.85.160.52])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 761BE2C0306
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Mar 2013 19:09:32 +1100 (EST)
Received: by mail-pb0-f52.google.com with SMTP id ma3so2677107pbc.39
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Mar 2013 00:09:30 -0800 (PST)
From: Jiang Liu <liuj97@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 David Rientjes <rientjes@google.com>
Subject: [PATCH v2,
 part2 07/10] mm/PPC: use free_highmem_page() to free highmem pages
 into buddy system
Date: Sun, 10 Mar 2013 16:01:07 +0800
Message-Id: <1362902470-25787-8-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1362902470-25787-1-git-send-email-jiang.liu@huawei.com>
References: <1362902470-25787-1-git-send-email-jiang.liu@huawei.com>
Cc: Jiang Liu <jiang.liu@huawei.com>, Wen Congyang <wency@cn.fujitsu.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Alexander Graf <agraf@suse.de>, Michal Hocko <mhocko@suse.cz>,
 Minchan Kim <minchan@kernel.org>, Paul Mackerras <paulus@samba.org>,
 Mel Gorman <mgorman@suse.de>, "Suzuki K. Poulose" <suzuki@in.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
 Jianguo Wu <wujianguo@huawei.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use helper function free_highmem_page() to free highmem pages into
the buddy system.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Jiang Liu <jiang.liu@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Graf <agraf@suse.de>
Cc: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
---
 arch/powerpc/mm/mem.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index c756713..68f51d0 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -352,13 +352,9 @@ void __init mem_init(void)
 			struct page *page = pfn_to_page(pfn);
 			if (memblock_is_reserved(paddr))
 				continue;
-			ClearPageReserved(page);
-			init_page_count(page);
-			__free_page(page);
-			totalhigh_pages++;
+			free_higmem_page(page);
 			reservedpages--;
 		}
-		totalram_pages += totalhigh_pages;
 		printk(KERN_DEBUG "High memory: %luk\n",
 		       totalhigh_pages << (PAGE_SHIFT-10));
 	}
-- 
1.7.9.5
