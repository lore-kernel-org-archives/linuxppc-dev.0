Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9E4EA2C0082
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 21:28:44 +1100 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 18 Feb 2013 15:55:57 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 3982B394004E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 15:58:38 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1IASaiS22216946
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 15:58:36 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1IASZAL001077
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 21:28:37 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [RFC PATCH 08/17] powerpc: print both base and actual page size on
 hash failure
Date: Mon, 18 Feb 2013 15:58:06 +0530
Message-Id: <1361183295-6958-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1361183295-6958-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1361183295-6958-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mmu-hash64.h |    3 ++-
 arch/powerpc/mm/hash_utils_64.c       |   12 +++++++-----
 arch/powerpc/mm/hugetlbpage-hash64.c  |    2 +-
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index 6290e26..6ec65b6 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -321,7 +321,8 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 		     unsigned int shift, unsigned int mmu_psize);
 extern void hash_failure_debug(unsigned long ea, unsigned long access,
 			       unsigned long vsid, unsigned long trap,
-			       int ssize, int psize, unsigned long pte);
+			       int ssize, int psize, int lpsize,
+			       unsigned long pte);
 extern int htab_bolt_mapping(unsigned long vstart, unsigned long vend,
 			     unsigned long pstart, unsigned long prot,
 			     int psize, int ssize);
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 48edb46..df48ba5 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -917,14 +917,14 @@ static inline int subpage_protection(struct mm_struct *mm, unsigned long ea)
 
 void hash_failure_debug(unsigned long ea, unsigned long access,
 			unsigned long vsid, unsigned long trap,
-			int ssize, int psize, unsigned long pte)
+			int ssize, int psize, int lpsize, unsigned long pte)
 {
 	if (!printk_ratelimit())
 		return;
 	pr_info("mm: Hashing failure ! EA=0x%lx access=0x%lx current=%s\n",
 		ea, access, current->comm);
-	pr_info("    trap=0x%lx vsid=0x%lx ssize=%d psize=%d pte=0x%lx\n",
-		trap, vsid, ssize, psize, pte);
+	pr_info("    trap=0x%lx vsid=0x%lx ssize=%d base psize=%d psize %d pte=0x%lx\n",
+		trap, vsid, ssize, psize, lpsize, pte);
 }
 
 /* Result code is:
@@ -1097,7 +1097,7 @@ int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
 	 */
 	if (rc == -1)
 		hash_failure_debug(ea, access, vsid, trap, ssize, psize,
-				   pte_val(*ptep));
+				   psize, pte_val(*ptep));
 #ifndef CONFIG_PPC_64K_PAGES
 	DBG_LOW(" o-pte: %016lx\n", pte_val(*ptep));
 #else
@@ -1175,7 +1175,9 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 	 */
 	if (rc == -1)
 		hash_failure_debug(ea, access, vsid, trap, ssize,
-				   mm->context.user_psize, pte_val(*ptep));
+				   mm->context.user_psize,
+				   mm->context.user_psize,
+				   pte_val(*ptep));
 
 	local_irq_restore(flags);
 }
diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index cecad34..af98ee8 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -129,7 +129,7 @@ repeat:
 		if (unlikely(slot == -2)) {
 			*ptep = __pte(old_pte);
 			hash_failure_debug(ea, access, vsid, trap, ssize,
-					   mmu_psize, old_pte);
+					   mmu_psize, mmu_psize, old_pte);
 			return -1;
 		}
 
-- 
1.7.10
