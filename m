Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 343C9B6F14
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 10:42:00 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id o6N0fxfa027301
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 10:41:59 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6N0fxx31384674
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 10:41:59 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o6N0fxR5031603
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 10:41:59 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/5] powerpc/mm: Add some debug output when hash insertion
	fails
Date: Fri, 23 Jul 2010 10:41:43 +1000
Message-Id: <1279845704-14848-4-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1279845704-14848-3-git-send-email-benh@kernel.crashing.org>
References: <1279845704-14848-1-git-send-email-benh@kernel.crashing.org>
	<1279845704-14848-2-git-send-email-benh@kernel.crashing.org>
	<1279845704-14848-3-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds some debug output to our MMU hash code to print out some
useful debug data if the hypervisor refuses the insertion (which
should normally never happen).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
---
 arch/powerpc/include/asm/mmu-hash64.h |    4 ++-
 arch/powerpc/mm/hash_utils_64.c       |   34 ++++++++++++++++++++++++++++----
 arch/powerpc/mm/hugetlbpage-hash64.c  |    2 +
 3 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index 2102b21..0e398cf 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -250,7 +250,9 @@ extern int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
 int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 		     pte_t *ptep, unsigned long trap, int local, int ssize,
 		     unsigned int shift, unsigned int mmu_psize);
-
+extern void hash_failure_debug(unsigned long ea, unsigned long access,
+			       unsigned long vsid, unsigned long trap,
+			       int ssize, int psize, unsigned long pte);
 extern int htab_bolt_mapping(unsigned long vstart, unsigned long vend,
 			     unsigned long pstart, unsigned long prot,
 			     int psize, int ssize);
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 40847a9..09dffe6 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -871,6 +871,18 @@ static inline int subpage_protection(struct mm_struct *mm, unsigned long ea)
 }
 #endif
 
+void hash_failure_debug(unsigned long ea, unsigned long access,
+			unsigned long vsid, unsigned long trap,
+			int ssize, int psize, unsigned long pte)
+{
+	if (!printk_ratelimit())
+		return;
+	pr_info("mm: Hashing failure ! EA=0x%lx access=0x%lx current=%s\n",
+		ea, access, current->comm);
+	pr_info("    trap=0x%lx vsid=0x%lx ssize=%d psize=%d pte=0x%lx\n",
+		trap, vsid, ssize, psize, pte);
+}
+
 /* Result code is:
  *  0 - handled
  *  1 - normal page fault
@@ -1036,6 +1048,12 @@ int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
 					    local, ssize, spp);
 	}
 
+	/* Dump some info in case of hash insertion failure, they should
+	 * never happen so it is really useful to know if/when they do
+	 */
+	if (rc == -1)
+		hash_failure_debug(ea, access, vsid, trap, ssize, psize,
+				   pte_val(*ptep));
 #ifndef CONFIG_PPC_64K_PAGES
 	DBG_LOW(" o-pte: %016lx\n", pte_val(*ptep));
 #else
@@ -1054,8 +1072,7 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 	void *pgdir;
 	pte_t *ptep;
 	unsigned long flags;
-	int local = 0;
-	int ssize;
+	int rc, ssize, local = 0;
 
 	BUG_ON(REGION_ID(ea) != USER_REGION_ID);
 
@@ -1101,11 +1118,18 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 	/* Hash it in */
 #ifdef CONFIG_PPC_HAS_HASH_64K
 	if (mm->context.user_psize == MMU_PAGE_64K)
-		__hash_page_64K(ea, access, vsid, ptep, trap, local, ssize);
+		rc = __hash_page_64K(ea, access, vsid, ptep, trap, local, ssize);
 	else
 #endif /* CONFIG_PPC_HAS_HASH_64K */
-		__hash_page_4K(ea, access, vsid, ptep, trap, local, ssize,
-			       subpage_protection(pgdir, ea));
+		rc = __hash_page_4K(ea, access, vsid, ptep, trap, local, ssize,
+				    subpage_protection(pgdir, ea));
+
+	/* Dump some info in case of hash insertion failure, they should
+	 * never happen so it is really useful to know if/when they do
+	 */
+	if (rc == -1)
+		hash_failure_debug(ea, access, vsid, trap, ssize,
+				   mm->context.user_psize, pte_val(*ptep));
 
 	local_irq_restore(flags);
 }
diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index fd0a15e..db70c0d 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -127,6 +127,8 @@ repeat:
 		 */
 		if (unlikely(slot == -2)) {
 			*ptep = __pte(old_pte);
+			hash_failure_debug(ea, access, vsid, trap, ssize,
+					   mmu_psize, old_pte);
 			return -1;
 		}
 
-- 
1.6.3.3
