Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 191C7DDEF3
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 13:51:44 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <63d4252b846a0db6b7448854b7a584499b927e86.1217476198.git.tony@bakeyournoodle.com>
In-Reply-To: <cac86e24e42bd05087b43663b687f04df91326ba.1217476198.git.tony@bakeyournoodle.com>
References: <cac86e24e42bd05087b43663b687f04df91326ba.1217476198.git.tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
Subject: [PATCH 2/8] Guard htab_dt_scan_hugepage_blocks appropriately
Date: Thu, 31 Jul 2008 13:51:42 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

htab_dt_scan_hugepage_blocks is only used when CONFIG_HUGETLB_PAGE is
defined, likewise guard the declaration.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/mm/hash_utils_64.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 5ce5a4d..fa58777 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -329,6 +329,7 @@ static int __init htab_dt_scan_page_sizes(unsigned long node,
 	return 0;
 }
 
+#ifdef CONFIG_HUGETLB_PAGE
 /* Scan for 16G memory blocks that have been set aside for huge pages
  * and reserve those blocks for 16G huge pages.
  */
@@ -366,6 +367,7 @@ static int __init htab_dt_scan_hugepage_blocks(unsigned long node,
 	add_gpage(phys_addr, block_size, expected_pages);
 	return 0;
 }
+#endif /* CONFIG_HUGETLB_PAGE */
 
 static void __init htab_init_page_sizes(void)
 {
-- 
1.5.6.3
