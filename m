Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0E5E7B70DA
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 10:42:00 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp09.au.ibm.com (8.14.4/8.13.1) with ESMTP id o6N0fx5U028355
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 10:41:59 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6N0fxZl1155276
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 10:41:59 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o6N0fxOt011745
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 10:41:59 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/5] powerpc/mm: Move around testing of _PAGE_PRESENT in hash
	code
Date: Fri, 23 Jul 2010 10:41:41 +1000
Message-Id: <1279845704-14848-2-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1279845704-14848-1-git-send-email-benh@kernel.crashing.org>
References: <1279845704-14848-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Instead of adding _PAGE_PRESENT to the access permission mask
in each low level routine independently, we add it once from
hash_page().

We also move the preliminary access check (the racy one before
the PTE is locked) up so it applies to the huge page case. This
duplicates code in __hash_page_huge() which we'll remove in a
subsequent patch to fix a race in there.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/mm/hash_low_64.S   |    9 ---------
 arch/powerpc/mm/hash_utils_64.c |   19 +++++++++++--------
 2 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/mm/hash_low_64.S b/arch/powerpc/mm/hash_low_64.S
index a719f53..3079f6b 100644
--- a/arch/powerpc/mm/hash_low_64.S
+++ b/arch/powerpc/mm/hash_low_64.S
@@ -68,9 +68,6 @@ _GLOBAL(__hash_page_4K)
 	std	r8,STK_PARM(r8)(r1)
 	std	r9,STK_PARM(r9)(r1)
 	
-	/* Add _PAGE_PRESENT to access */
-	ori	r4,r4,_PAGE_PRESENT
-
 	/* Save non-volatile registers.
 	 * r31 will hold "old PTE"
 	 * r30 is "new PTE"
@@ -347,9 +344,6 @@ _GLOBAL(__hash_page_4K)
 	std	r8,STK_PARM(r8)(r1)
 	std	r9,STK_PARM(r9)(r1)
 
-	/* Add _PAGE_PRESENT to access */
-	ori	r4,r4,_PAGE_PRESENT
-
 	/* Save non-volatile registers.
 	 * r31 will hold "old PTE"
 	 * r30 is "new PTE"
@@ -687,9 +681,6 @@ _GLOBAL(__hash_page_64K)
 	std	r8,STK_PARM(r8)(r1)
 	std	r9,STK_PARM(r9)(r1)
 
-	/* Add _PAGE_PRESENT to access */
-	ori	r4,r4,_PAGE_PRESENT
-
 	/* Save non-volatile registers.
 	 * r31 will hold "old PTE"
 	 * r30 is "new PTE"
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 98f262d..40847a9 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -955,6 +955,17 @@ int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
 		return 1;
 	}
 
+	/* Add _PAGE_PRESENT to the required access perm */
+	access |= _PAGE_PRESENT;
+
+	/* Pre-check access permissions (will be re-checked atomically
+	 * in __hash_page_XX but this pre-check is a fast path
+	 */
+	if (access & ~pte_val(*ptep)) {
+		DBG_LOW(" no access !\n");
+		return 1;
+	}
+
 #ifdef CONFIG_HUGETLB_PAGE
 	if (hugeshift)
 		return __hash_page_huge(ea, access, vsid, ptep, trap, local,
@@ -967,14 +978,6 @@ int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
 	DBG_LOW(" i-pte: %016lx %016lx\n", pte_val(*ptep),
 		pte_val(*(ptep + PTRS_PER_PTE)));
 #endif
-	/* Pre-check access permissions (will be re-checked atomically
-	 * in __hash_page_XX but this pre-check is a fast path
-	 */
-	if (access & ~pte_val(*ptep)) {
-		DBG_LOW(" no access !\n");
-		return 1;
-	}
-
 	/* Do actual hashing */
 #ifdef CONFIG_PPC_64K_PAGES
 	/* If _PAGE_4K_PFN is set, make sure this is a 4k segment */
-- 
1.6.3.3
