Return-Path: <liuj97@gmail.com>
Received: from mail-pb0-f53.google.com (mail-pb0-f53.google.com
 [209.85.160.53])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 232F92C0084
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Apr 2013 01:41:50 +1000 (EST)
Received: by mail-pb0-f53.google.com with SMTP id un15so1855470pbc.26
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Apr 2013 08:41:48 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, Yinghai Lu <yinghai@kernel.org>
Subject: [RFC PATCH v1 09/19] mm/PPC: prepare for killing
 free_all_bootmem_node()
Date: Sat, 13 Apr 2013 23:36:29 +0800
Message-Id: <1365867399-21323-10-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1365867399-21323-1-git-send-email-jiang.liu@huawei.com>
References: <1365867399-21323-1-git-send-email-jiang.liu@huawei.com>
Cc: linux-arch@vger.kernel.org, David Howells <dhowells@redhat.com>,
 Jiang Liu <jiang.liu@huawei.com>, Wen Congyang <wency@cn.fujitsu.com>,
 linux-mm@kvack.org, Mark Salter <msalter@redhat.com>,
 linux-kernel@vger.kernel.org, Alexander Graf <agraf@suse.de>,
 Michal Hocko <mhocko@suse.cz>, Minchan Kim <minchan@kernel.org>,
 Paul Mackerras <paulus@samba.org>, Mel Gorman <mgorman@suse.de>,
 David Rientjes <rientjes@google.com>, "Suzuki K. Poulose" <suzuki@in.ibm.com>,
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

Prepare for killing free_all_bootmem_node() by using
free_all_bootmem().

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Alexander Graf <agraf@suse.de>
Cc: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
---
 arch/powerpc/mm/mem.c |   16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 07663de..22e46db 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -305,22 +305,8 @@ void __init mem_init(void)
 #endif
 
 	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
-
-#ifdef CONFIG_NEED_MULTIPLE_NODES
-	{
-		pg_data_t *pgdat;
-
-		for_each_online_pgdat(pgdat)
-			if (pgdat->node_spanned_pages != 0) {
-				printk("freeing bootmem node %d\n",
-					pgdat->node_id);
-				free_all_bootmem_node(pgdat);
-			}
-	}
-#else
-	max_mapnr = max_pfn;
+	set_max_mapnr(max_pfn);
 	free_all_bootmem();
-#endif
 
 #ifdef CONFIG_HIGHMEM
 	{
-- 
1.7.9.5
