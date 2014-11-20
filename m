Return-Path: <mgorman@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 849A01A09EA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Nov 2014 21:20:10 +1100 (AEDT)
From: Mel Gorman <mgorman@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 10/10] mm: numa: Avoid unnecessary TLB flushes when setting
 NUMA hinting entries
Date: Thu, 20 Nov 2014 10:19:50 +0000
Message-Id: <1416478790-27522-11-git-send-email-mgorman@suse.de>
In-Reply-To: <1416478790-27522-1-git-send-email-mgorman@suse.de>
References: <1416478790-27522-1-git-send-email-mgorman@suse.de>
Cc: Rik van Riel <riel@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>, Linux-MM <linux-mm@kvack.org>,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
 Sasha Levin <sasha.levin@oracle.com>, Dave Jones <davej@redhat.com>,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
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

If a PTE or PMD is already marked NUMA when scanning to mark entries
for NUMA hinting then it is not necessary to update the entry and
incur a TLB flush penalty. Avoid the avoidhead where possible.

Signed-off-by: Mel Gorman <mgorman@suse.de>
---
 mm/huge_memory.c | 14 ++++++++------
 mm/mprotect.c    |  4 ++++
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 6458229f..a7ea9b8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1524,12 +1524,14 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 			return 0;
 		}
 
-		ret = 1;
-		entry = pmdp_get_and_clear(mm, addr, pmd);
-		entry = pmd_modify(entry, newprot);
-		ret = HPAGE_PMD_NR;
-		set_pmd_at(mm, addr, pmd, entry);
-		BUG_ON(pmd_write(entry));
+		if (!prot_numa || !pmd_protnone_numa(*pmd)) {
+			ret = 1;
+			entry = pmdp_get_and_clear(mm, addr, pmd);
+			entry = pmd_modify(entry, newprot);
+			ret = HPAGE_PMD_NR;
+			set_pmd_at(mm, addr, pmd, entry);
+			BUG_ON(pmd_write(entry));
+		}
 		spin_unlock(ptl);
 	}
 
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 33dfafb..eb890d0 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -86,6 +86,10 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				page = vm_normal_page(vma, addr, oldpte);
 				if (!page || PageKsm(page))
 					continue;
+
+				/* Avoid TLB flush if possible */
+				if (pte_protnone_numa(oldpte))
+					continue;
 			}
 
 			ptent = ptep_modify_prot_start(mm, addr, pte);
-- 
2.1.2
