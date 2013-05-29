Return-Path: <liuj97@gmail.com>
Received: from mail-pb0-x234.google.com (mail-pb0-x234.google.com
 [IPv6:2607:f8b0:400e:c01::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 26A092C031C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 00:45:47 +1000 (EST)
Received: by mail-pb0-f52.google.com with SMTP id um15so9291020pbc.39
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 May 2013 07:45:45 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH, v2 09/13] mm/PPC: prepare for killing free_all_bootmem_node()
Date: Wed, 29 May 2013 22:44:48 +0800
Message-Id: <1369838692-26860-10-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1369838692-26860-1-git-send-email-jiang.liu@huawei.com>
References: <1369838692-26860-1-git-send-email-jiang.liu@huawei.com>
Cc: linux-arch@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 David Howells <dhowells@redhat.com>, Jiang Liu <jiang.liu@huawei.com>,
 Wen Congyang <wency@cn.fujitsu.com>, linux-mm@kvack.org,
 Mark Salter <msalter@redhat.com>, linux-kernel@vger.kernel.org,
 Alexander Graf <agraf@suse.de>, Michal Hocko <mhocko@suse.cz>,
 Minchan Kim <minchan@kernel.org>, Paul Mackerras <paulus@samba.org>,
 Mel Gorman <mgorman@suse.de>, David Rientjes <rientjes@google.com>,
 "Suzuki K. Poulose" <suzuki@in.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
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
 arch/powerpc/mm/mem.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 49c18b6..1cb1ea1 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -304,22 +304,8 @@ void __init mem_init(void)
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
1.8.1.2
