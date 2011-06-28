Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 904EDB6F64
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Jun 2011 05:57:56 +1000 (EST)
From: Becky Bruce <beckyb@kernel.crashing.org>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/5] hugetlb: add phys addr to struct huge_bootmem_page
Date: Tue, 28 Jun 2011 14:54:45 -0500
Message-Id: <13092910103675-git-send-email-beckyb@kernel.crashing.org>
In-Reply-To: <13092909493748-git-send-email-beckyb@kernel.crashing.org>
References: <1309290888309-git-send-email-beckyb@kernel.crashing.org>
	<13092909493748-git-send-email-beckyb@kernel.crashing.org>
Cc: wli@holomorphy.com, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Becky Bruce <beckyb@kernel.crashing.org>

This is needed on HIGHMEM systems - we don't always have a virtual
address so store the physical address and map it in as needed.

Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
---
 include/linux/hugetlb.h |    3 +++
 mm/hugetlb.c            |    8 +++++++-
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 59225ef..19644e0 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -231,6 +231,9 @@ struct hstate {
 struct huge_bootmem_page {
 	struct list_head list;
 	struct hstate *hstate;
+#ifdef CONFIG_HIGHMEM
+	phys_addr_t phys;
+#endif
 };
 
 struct page *alloc_huge_page_node(struct hstate *h, int nid);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6402458..2db81ea 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1105,8 +1105,14 @@ static void __init gather_bootmem_prealloc(void)
 	struct huge_bootmem_page *m;
 
 	list_for_each_entry(m, &huge_boot_pages, list) {
-		struct page *page = virt_to_page(m);
 		struct hstate *h = m->hstate;
+#ifdef CONFIG_HIGHMEM
+		struct page *page = pfn_to_page(m->phys >> PAGE_SHIFT);
+		free_bootmem_late((unsigned long)m,
+				  sizeof(struct huge_bootmem_page));
+#else
+		struct page *page = virt_to_page(m);
+#endif
 		__ClearPageReserved(page);
 		WARN_ON(page_count(page) != 1);
 		prep_compound_huge_page(page, h->order);
-- 
1.5.6.5
