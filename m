Return-Path: <liuj97@gmail.com>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
 [209.85.220.47])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D84492C00D9
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Apr 2013 01:46:30 +1100 (EST)
Received: by mail-pa0-f47.google.com with SMTP id bj3so2509351pad.20
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 06 Apr 2013 07:46:28 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v4,
 part3 31/41] mm/ppc: prepare for removing num_physpages and simplify
 mem_init()
Date: Sat,  6 Apr 2013 22:32:30 +0800
Message-Id: <1365258760-30821-32-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1365258760-30821-1-git-send-email-jiang.liu@huawei.com>
References: <1365258760-30821-1-git-send-email-jiang.liu@huawei.com>
Cc: linux-arch@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 David Howells <dhowells@redhat.com>, Jiang Liu <jiang.liu@huawei.com>,
 Wen Congyang <wency@cn.fujitsu.com>, linux-mm@kvack.org,
 Mark Salter <msalter@redhat.com>, linux-kernel@vger.kernel.org,
 Michal Hocko <mhocko@suse.cz>, Minchan Kim <minchan@kernel.org>,
 Paul Mackerras <paulus@samba.org>, Mel Gorman <mgorman@suse.de>,
 David Rientjes <rientjes@google.com>, linuxppc-dev@lists.ozlabs.org,
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

Prepare for removing num_physpages and simplify mem_init().

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
---
 arch/powerpc/mm/mem.c |   56 +++++++++++--------------------------------------
 1 file changed, 12 insertions(+), 44 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 8ddef0a..07663de 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -300,46 +300,27 @@ void __init paging_init(void)
 
 void __init mem_init(void)
 {
-#ifdef CONFIG_NEED_MULTIPLE_NODES
-	int nid;
-#endif
-	pg_data_t *pgdat;
-	unsigned long i;
-	struct page *page;
-	unsigned long reservedpages = 0, codesize, initsize, datasize, bsssize;
-
 #ifdef CONFIG_SWIOTLB
 	swiotlb_init(0);
 #endif
 
-	num_physpages = memblock_phys_mem_size() >> PAGE_SHIFT;
 	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
 
 #ifdef CONFIG_NEED_MULTIPLE_NODES
-        for_each_online_node(nid) {
-		if (NODE_DATA(nid)->node_spanned_pages != 0) {
-			printk("freeing bootmem node %d\n", nid);
-			free_all_bootmem_node(NODE_DATA(nid));
-		}
+	{
+		pg_data_t *pgdat;
+
+		for_each_online_pgdat(pgdat)
+			if (pgdat->node_spanned_pages != 0) {
+				printk("freeing bootmem node %d\n",
+					pgdat->node_id);
+				free_all_bootmem_node(pgdat);
+			}
 	}
 #else
 	max_mapnr = max_pfn;
 	free_all_bootmem();
 #endif
-	for_each_online_pgdat(pgdat) {
-		for (i = 0; i < pgdat->node_spanned_pages; i++) {
-			if (!pfn_valid(pgdat->node_start_pfn + i))
-				continue;
-			page = pgdat_page_nr(pgdat, i);
-			if (PageReserved(page))
-				reservedpages++;
-		}
-	}
-
-	codesize = (unsigned long)&_sdata - (unsigned long)&_stext;
-	datasize = (unsigned long)&_edata - (unsigned long)&_sdata;
-	initsize = (unsigned long)&__init_end - (unsigned long)&__init_begin;
-	bsssize = (unsigned long)&__bss_stop - (unsigned long)&__bss_start;
 
 #ifdef CONFIG_HIGHMEM
 	{
@@ -349,13 +330,9 @@ void __init mem_init(void)
 		for (pfn = highmem_mapnr; pfn < max_mapnr; ++pfn) {
 			phys_addr_t paddr = (phys_addr_t)pfn << PAGE_SHIFT;
 			struct page *page = pfn_to_page(pfn);
-			if (memblock_is_reserved(paddr))
-				continue;
-			free_highmem_page(page);
-			reservedpages--;
+			if (!memblock_is_reserved(paddr))
+				free_highmem_page(page);
 		}
-		printk(KERN_DEBUG "High memory: %luk\n",
-		       totalhigh_pages << (PAGE_SHIFT-10));
 	}
 #endif /* CONFIG_HIGHMEM */
 
@@ -368,16 +345,7 @@ void __init mem_init(void)
 		(mfspr(SPRN_TLB1CFG) & TLBnCFG_N_ENTRY) - 1;
 #endif
 
-	printk(KERN_INFO "Memory: %luk/%luk available (%luk kernel code, "
-	       "%luk reserved, %luk data, %luk bss, %luk init)\n",
-		nr_free_pages() << (PAGE_SHIFT-10),
-		num_physpages << (PAGE_SHIFT-10),
-		codesize >> 10,
-		reservedpages << (PAGE_SHIFT-10),
-		datasize >> 10,
-		bsssize >> 10,
-		initsize >> 10);
-
+	mem_init_print_info(NULL);
 #ifdef CONFIG_PPC32
 	pr_info("Kernel virtual memory layout:\n");
 	pr_info("  * 0x%08lx..0x%08lx  : fixmap\n", FIXADDR_START, FIXADDR_TOP);
-- 
1.7.9.5
