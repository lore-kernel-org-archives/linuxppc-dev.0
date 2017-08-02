Return-Path: <pasha.tatashin@oracle.com>
Received: from userp1050.oracle.com (userp1050.oracle.com [156.151.31.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xN4n70GZwzDqpF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 06:39:54 +1000 (AEST)
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by userp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 v72Kdr33026603
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 20:39:53 GMT
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 mhocko@kernel.org
Subject: [v4 08/15] mm: zero struct pages during initialization
Date: Wed,  2 Aug 2017 16:38:17 -0400
Message-Id: <1501706304-869240-9-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1501706304-869240-1-git-send-email-pasha.tatashin@oracle.com>
References: <1501706304-869240-1-git-send-email-pasha.tatashin@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add struct page zeroing as a part of initialization of other fields in
__init_single_page().

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Reviewed-by: Bob Picco <bob.picco@oracle.com>
---
 include/linux/mm.h | 9 +++++++++
 mm/page_alloc.c    | 1 +
 2 files changed, 10 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 46b9ac5e8569..183ac5e733db 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -94,6 +94,15 @@ extern int mmap_rnd_compat_bits __read_mostly;
 #endif
 
 /*
+ * On some architectures it is expensive to call memset() for small sizes.
+ * Those architectures should provide their own implementation of "struct page"
+ * zeroing by defining this macro in <asm/pgtable.h>.
+ */
+#ifndef mm_zero_struct_page
+#define mm_zero_struct_page(pp)  ((void)memset((pp), 0, sizeof(struct page)))
+#endif
+
+/*
  * Default maximum number of active map areas, this limits the number of vmas
  * per mm struct. Users can overwrite this number by sysctl but there is a
  * problem.
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 99b9e2e06319..debea7c0febb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1168,6 +1168,7 @@ static void free_one_page(struct zone *zone,
 static void __meminit __init_single_page(struct page *page, unsigned long pfn,
 				unsigned long zone, int nid)
 {
+	mm_zero_struct_page(page);
 	set_page_links(page, zone, nid, pfn);
 	init_page_count(page);
 	page_mapcount_reset(page);
-- 
2.13.3
