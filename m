Return-Path: <mgorman@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D8F3F1A05F0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 22:24:39 +1100 (AEDT)
From: Mel Gorman <mgorman@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 01/10] mm: numa: Do not dereference pmd outside of the lock
 during NUMA hinting fault
Date: Thu,  4 Dec 2014 11:24:24 +0000
Message-Id: <1417692273-27170-2-git-send-email-mgorman@suse.de>
In-Reply-To: <1417692273-27170-1-git-send-email-mgorman@suse.de>
References: <1417692273-27170-1-git-send-email-mgorman@suse.de>
Cc: Rik van Riel <riel@redhat.com>,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>, Hugh Dickins <hughd@google.com>,
 Linux Kernel <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
 Sasha Levin <sasha.levin@oracle.com>, Dave Jones <davej@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Kirill Shutemov <kirill.shutemov@linux.intel.com>,
 Mel Gorman <mgorman@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A transhuge NUMA hinting fault may find the page is migrating and should
wait until migration completes. The check is race-prone because the pmd
is deferenced outside of the page lock and while the race is tiny, it'll
be larger if the PMD is cleared while marking PMDs for hinting fault.
This patch closes the race.

Signed-off-by: Mel Gorman <mgorman@suse.de>
---
 include/linux/migrate.h | 4 ----
 mm/huge_memory.c        | 3 ++-
 mm/migrate.c            | 6 ------
 3 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 01aad3e..a3edcdf 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -77,7 +77,6 @@ static inline int migrate_huge_page_move_mapping(struct address_space *mapping,
 
 #ifdef CONFIG_NUMA_BALANCING
 extern bool pmd_trans_migrating(pmd_t pmd);
-extern void wait_migrate_huge_page(struct anon_vma *anon_vma, pmd_t *pmd);
 extern int migrate_misplaced_page(struct page *page,
 				  struct vm_area_struct *vma, int node);
 extern bool migrate_ratelimited(int node);
@@ -86,9 +85,6 @@ static inline bool pmd_trans_migrating(pmd_t pmd)
 {
 	return false;
 }
-static inline void wait_migrate_huge_page(struct anon_vma *anon_vma, pmd_t *pmd)
-{
-}
 static inline int migrate_misplaced_page(struct page *page,
 					 struct vm_area_struct *vma, int node)
 {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 817a875..a2cd021 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1283,8 +1283,9 @@ int do_huge_pmd_numa_page(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * check_same as the page may no longer be mapped.
 	 */
 	if (unlikely(pmd_trans_migrating(*pmdp))) {
+		page = pmd_page(*pmdp);
 		spin_unlock(ptl);
-		wait_migrate_huge_page(vma->anon_vma, pmdp);
+		wait_on_page_locked(page);
 		goto out;
 	}
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 41945cb..11d86b4 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1698,12 +1698,6 @@ bool pmd_trans_migrating(pmd_t pmd)
 	return PageLocked(page);
 }
 
-void wait_migrate_huge_page(struct anon_vma *anon_vma, pmd_t *pmd)
-{
-	struct page *page = pmd_page(*pmd);
-	wait_on_page_locked(page);
-}
-
 /*
  * Attempt to migrate a misplaced page to the specified destination
  * node. Caller is expected to have an elevated reference count on
-- 
2.1.2
