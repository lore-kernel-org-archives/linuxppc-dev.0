Return-Path: <hughd@google.com>
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com
 [IPv6:2607:f8b0:400e:c03::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 51DBA1A0908
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Jan 2016 11:59:48 +1100 (AEDT)
Received: by mail-pa0-x22d.google.com with SMTP id yy13so209749568pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 09 Jan 2016 16:59:48 -0800 (PST)
Date: Sat, 9 Jan 2016 16:59:42 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Cyrill Gorcunov <gorcunov@gmail.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org
Subject: [PATCH next] mm: make swapoff more robust against soft dirty
In-Reply-To: <alpine.LSU.2.11.1601091651130.9808@eggly.anvils>
Message-ID: <alpine.LSU.2.11.1601091656491.9808@eggly.anvils>
References: <alpine.LSU.2.11.1601091651130.9808@eggly.anvils>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Both s390 and powerpc have hit the issue of swapoff hanging, when
CONFIG_HAVE_ARCH_SOFT_DIRTY and CONFIG_MEM_SOFT_DIRTY ifdefs were
not quite as x86_64 had them.  I think it would be much clearer if
HAVE_ARCH_SOFT_DIRTY was just a Kconfig option set by architectures
to determine whether the MEM_SOFT_DIRTY option should be offered,
and the actual code depend upon CONFIG_MEM_SOFT_DIRTY alone.

But won't embark on that change myself: instead make swapoff more
robust, by using pte_swp_clear_soft_dirty() on each pte it encounters,
without an explicit #ifdef CONFIG_MEM_SOFT_DIRTY.  That being a no-op,
whether the bit in question is defined as 0 or the asm-generic fallback
is used, unless soft dirty is fully turned on.

Why "maybe" in maybe_same_pte()?  Rename it pte_same_as_swp().

Signed-off-by: Hugh Dickins <hughd@google.com>
---

 mm/swapfile.c |   18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

--- 4.4-next/mm/swapfile.c	2016-01-06 11:54:46.327006983 -0800
+++ linux/mm/swapfile.c	2016-01-09 13:39:19.632872694 -0800
@@ -1109,19 +1109,9 @@ unsigned int count_swap_pages(int type,
 }
 #endif /* CONFIG_HIBERNATION */
 
-static inline int maybe_same_pte(pte_t pte, pte_t swp_pte)
+static inline int pte_same_as_swp(pte_t pte, pte_t swp_pte)
 {
-#ifdef CONFIG_MEM_SOFT_DIRTY
-	/*
-	 * When pte keeps soft dirty bit the pte generated
-	 * from swap entry does not has it, still it's same
-	 * pte from logical point of view.
-	 */
-	pte_t swp_pte_dirty = pte_swp_mksoft_dirty(swp_pte);
-	return pte_same(pte, swp_pte) || pte_same(pte, swp_pte_dirty);
-#else
-	return pte_same(pte, swp_pte);
-#endif
+	return pte_same(pte_swp_clear_soft_dirty(pte), swp_pte);
 }
 
 /*
@@ -1150,7 +1140,7 @@ static int unuse_pte(struct vm_area_stru
 	}
 
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
-	if (unlikely(!maybe_same_pte(*pte, swp_entry_to_pte(entry)))) {
+	if (unlikely(!pte_same_as_swp(*pte, swp_entry_to_pte(entry)))) {
 		mem_cgroup_cancel_charge(page, memcg, false);
 		ret = 0;
 		goto out;
@@ -1208,7 +1198,7 @@ static int unuse_pte_range(struct vm_are
 		 * swapoff spends a _lot_ of time in this loop!
 		 * Test inline before going to call unuse_pte.
 		 */
-		if (unlikely(maybe_same_pte(*pte, swp_pte))) {
+		if (unlikely(pte_same_as_swp(*pte, swp_pte))) {
 			pte_unmap(pte);
 			ret = unuse_pte(vma, pmd, addr, entry, page);
 			if (ret)
