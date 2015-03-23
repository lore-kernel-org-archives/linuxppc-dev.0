Return-Path: <mgorman@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6F6E01A2AE3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 23:24:08 +1100 (AEDT)
From: Mel Gorman <mgorman@suse.de>
To: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 1/3] mm: numa: Group related processes based on VMA flags
 instead of page table flags
Date: Mon, 23 Mar 2015 12:24:01 +0000
Message-Id: <1427113443-20973-2-git-send-email-mgorman@suse.de>
In-Reply-To: <1427113443-20973-1-git-send-email-mgorman@suse.de>
References: <1427113443-20973-1-git-send-email-mgorman@suse.de>
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

Threads that share writable data within pages are grouped together as
related tasks. This decision is based on whether the PTE is marked dirty
which is subject to timing races between the PTE scanner update and when the
application writes the page. If the page is file-backed, then background
flushes and sync also affect placement. This is unpredictable behaviour
which is impossible to reason about so this patch makes grouping decisions
based on the VMA flags.

Signed-off-by: Mel Gorman <mgorman@suse.de>
---
 mm/huge_memory.c | 13 ++-----------
 mm/memory.c      | 19 +++++++++++--------
 2 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 626e93db28ba..2f12e9fcf1a2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1291,17 +1291,8 @@ int do_huge_pmd_numa_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		flags |= TNF_FAULT_LOCAL;
 	}
 
-	/*
-	 * Avoid grouping on DSO/COW pages in specific and RO pages
-	 * in general, RO pages shouldn't hurt as much anyway since
-	 * they can be in shared cache state.
-	 *
-	 * FIXME! This checks "pmd_dirty()" as an approximation of
-	 * "is this a read-only page", since checking "pmd_write()"
-	 * is even more broken. We haven't actually turned this into
-	 * a writable page, so pmd_write() will always be false.
-	 */
-	if (!pmd_dirty(pmd))
+	/* See similar comment in do_numa_page for explanation */
+	if (!(vma->vm_flags & VM_WRITE))
 		flags |= TNF_NO_GROUP;
 
 	/*
diff --git a/mm/memory.c b/mm/memory.c
index 411144f977b1..20beb6647dba 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3069,16 +3069,19 @@ static int do_numa_page(struct mm_struct *mm, struct vm_area_struct *vma,
 	}
 
 	/*
-	 * Avoid grouping on DSO/COW pages in specific and RO pages
-	 * in general, RO pages shouldn't hurt as much anyway since
-	 * they can be in shared cache state.
+	 * Avoid grouping on RO pages in general. RO pages shouldn't hurt as
+	 * much anyway since they can be in shared cache state. This misses
+	 * the case where a mapping is writable but the process never writes
+	 * to it but pte_write gets cleared during protection updates and
+	 * pte_dirty has unpredictable behaviour between PTE scan updates,
+	 * background writeback, dirty balancing and application behaviour.
 	 *
-	 * FIXME! This checks "pmd_dirty()" as an approximation of
-	 * "is this a read-only page", since checking "pmd_write()"
-	 * is even more broken. We haven't actually turned this into
-	 * a writable page, so pmd_write() will always be false.
+	 * TODO: Note that the ideal here would be to avoid a situation where a
+	 * NUMA fault is taken immediately followed by a write fault in
+	 * some cases which would have lower overhead overall but would be
+	 * invasive as the fault paths would need to be unified.
 	 */
-	if (!pte_dirty(pte))
+	if (!(vma->vm_flags & VM_WRITE))
 		flags |= TNF_NO_GROUP;
 
 	/*
-- 
2.1.2
