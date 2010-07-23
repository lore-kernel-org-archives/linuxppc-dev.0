Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F0B3E1007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Jul 2010 13:04:30 +1000 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id o6N34QWQ015079
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jul 2010 22:04:27 -0500
Subject: [PATCH 3/5 v2] powerpc/mm: Fix bugs in huge page hashing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 23 Jul 2010 13:04:25 +1000
Message-ID: <1279854265.1970.61.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There's a couple of nasty bugs lurking in our huge page hashing code.

First, we don't check the access permission atomically with setting
the _PAGE_BUSY bit, which means that the PTE value we end up using
for the hashing might be different than the one we have checked
the access permissions for.

We've seen cases where that leads us to try to use an invalidated
PTE for hashing, causing all sort of "interesting" issues.

Then, we also failed to set _PAGE_DIRTY on a write access.

Finally, a minor tweak but we should return 0 when we find the
PTE busy, in order to just re-execute the access, rather than 1
which means going to do_page_fault().

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/mm/hugetlbpage-hash64.c |   31 +++++++++++++------------------
 1 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index c9acd79..faae9ec 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -21,21 +21,13 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 	unsigned long old_pte, new_pte;
 	unsigned long va, rflags, pa, sz;
 	long slot;
-	int err = 1;
 
 	BUG_ON(shift != mmu_psize_defs[mmu_psize].shift);
 
 	/* Search the Linux page table for a match with va */
 	va = hpt_va(ea, vsid, ssize);
 
-	/*
-	 * Check the user's access rights to the page.  If access should be
-	 * prevented then send the problem up to do_page_fault.
-	 */
-	if (unlikely(access & ~pte_val(*ptep)))
-		goto out;
-	/*
-	 * At this point, we have a pte (old_pte) which can be used to build
+	/* At this point, we have a pte (old_pte) which can be used to build
 	 * or update an HPTE. There are 2 cases:
 	 *
 	 * 1. There is a valid (present) pte with no associated HPTE (this is
@@ -49,9 +41,17 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 
 	do {
 		old_pte = pte_val(*ptep);
-		if (old_pte & _PAGE_BUSY)
-			goto out;
+		/* If PTE busy, retry the access */
+		if (unlikely(old_pte & _PAGE_BUSY))
+			return 0;
+		/* If PTE permissions don't match, take page fault */
+		if (unlikely(access & ~old_pte))
+			return 1;
+		/* Try to lock the PTE, add ACCESSED and DIRTY if it was
+		 * a write access */
 		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED;
+		if (access & _PAGE_RW)
+			new_pte |= _PAGE_DIRTY;
 	} while(old_pte != __cmpxchg_u64((unsigned long *)ptep,
 					 old_pte, new_pte));
 
@@ -127,8 +127,7 @@ repeat:
 		 */
 		if (unlikely(slot == -2)) {
 			*ptep = __pte(old_pte);
-			err = -1;
-			goto out;
+			return -1;
 		}
 
 		new_pte |= (slot << 12) & (_PAGE_F_SECOND | _PAGE_F_GIX);
@@ -138,9 +137,5 @@ repeat:
 	 * No need to use ldarx/stdcx here
 	 */
 	*ptep = __pte(new_pte & ~_PAGE_BUSY);
-
-	err = 0;
-
- out:
-	return err;
+	return 0;
 }
