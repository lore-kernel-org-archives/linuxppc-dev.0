Return-Path: <mgorman@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2F3201A088A
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Mar 2015 02:21:00 +1100 (AEDT)
From: Mel Gorman <mgorman@suse.de>
To: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 3/4] mm: numa: Mark huge PTEs young when clearing NUMA hinting
 faults
Date: Sat,  7 Mar 2015 15:20:50 +0000
Message-Id: <1425741651-29152-4-git-send-email-mgorman@suse.de>
In-Reply-To: <1425741651-29152-1-git-send-email-mgorman@suse.de>
References: <1425741651-29152-1-git-send-email-mgorman@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, xfs@oss.sgi.com,
 Linux-MM <linux-mm@kvack.org>, Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>,
 Mel Gorman <mgorman@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Base PTEs are marked young when the NUMA hinting information is cleared
but the same does not happen for huge pages which this patch addresses.
Note that migrated pages are not marked young as the base page migration
code does not assume that migrated pages have been referenced. This could
be addressed but beyond the scope of this series which is aimed at Dave
Chinners shrink workload that is unlikely to be affected by this issue.

Signed-off-by: Mel Gorman <mgorman@suse.de>
---
 mm/huge_memory.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 194c0f019774..ae13ad31e113 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1359,6 +1359,7 @@ int do_huge_pmd_numa_page(struct mm_struct *mm, struct vm_area_struct *vma,
 clear_pmdnuma:
 	BUG_ON(!PageLocked(page));
 	pmd = pmd_modify(pmd, vma->vm_page_prot);
+	pmd = pmd_mkyoung(pmd);
 	set_pmd_at(mm, haddr, pmdp, pmd);
 	update_mmu_cache_pmd(vma, addr, pmdp);
 	unlock_page(page);
-- 
2.1.2
