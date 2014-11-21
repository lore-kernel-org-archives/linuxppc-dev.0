Return-Path: <mgorman@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EC0DA1A12FC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Nov 2014 00:58:05 +1100 (AEDT)
From: Mel Gorman <mgorman@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 09/10] mm: numa: Add paranoid check around pte_protnone_numa
Date: Fri, 21 Nov 2014 13:57:47 +0000
Message-Id: <1416578268-19597-10-git-send-email-mgorman@suse.de>
In-Reply-To: <1416578268-19597-1-git-send-email-mgorman@suse.de>
References: <1416578268-19597-1-git-send-email-mgorman@suse.de>
Cc: Rik van Riel <riel@redhat.com>, Hugh Dickins <hughd@google.com>,
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

pte_protnone_numa is only safe to use after VMA checks for PROT_NONE are
complete. Treating a real PROT_NONE PTE as a NUMA hinting fault is going
to result in strangeness so add a check for it. BUG_ON looks like overkill
but if this is hit then it's a serious bug that could result in corruption
so do not even try recovering. It would have been more comprehensive to
check VMA flags in pte_protnone_numa but it would have made the API ugly
just for a debugging check.

Signed-off-by: Mel Gorman <mgorman@suse.de>
---
 mm/huge_memory.c | 3 +++
 mm/memory.c      | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ad2a3ee..8546654 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1273,6 +1273,9 @@ int do_huge_pmd_numa_page(struct mm_struct *mm, struct vm_area_struct *vma,
 	bool migrated = false;
 	int flags = 0;
 
+	/* A PROT_NONE fault should not end up here */
+	BUG_ON(!(vma->vm_flags & (VM_READ | VM_EXEC | VM_WRITE)));
+
 	ptl = pmd_lock(mm, pmdp);
 	if (unlikely(!pmd_same(pmd, *pmdp)))
 		goto out_unlock;
diff --git a/mm/memory.c b/mm/memory.c
index 2ec07a9..7d97af5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3109,6 +3109,9 @@ static int do_numa_page(struct mm_struct *mm, struct vm_area_struct *vma,
 	bool migrated = false;
 	int flags = 0;
 
+	/* A PROT_NONE fault should not end up here */
+	BUG_ON(!(vma->vm_flags & (VM_READ | VM_EXEC | VM_WRITE)));
+
 	/*
 	* The "pte" at this point cannot be used safely without
 	* validation through pte_unmap_same(). It's of NUMA type but
-- 
2.1.2
