Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F3BBDB70C6
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 10:41:59 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp01.au.ibm.com (8.14.4/8.13.1) with ESMTP id o6N0dHN1004293
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 10:39:17 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6N0fxSY1400952
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 10:41:59 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o6N0fxCC011750
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 10:41:59 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/5] powerpc/mm: Fix bugs in huge page hashing
Date: Fri, 23 Jul 2010 10:41:42 +1000
Message-Id: <1279845704-14848-3-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1279845704-14848-2-git-send-email-benh@kernel.crashing.org>
References: <1279845704-14848-1-git-send-email-benh@kernel.crashing.org>
	<1279845704-14848-2-git-send-email-benh@kernel.crashing.org>
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

This fixes both, while also simplifying the code a bit.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
---
 arch/powerpc/mm/hugetlbpage-hash64.c |   31 +++++++++++++------------------
 1 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index c9acd79..fd0a15e 100644
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
+		if (unlikely(access & ~pte_val(*ptep)))
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
-- 
1.6.3.3
