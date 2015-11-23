Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 759F51A0C70
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:35:08 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 23 Nov 2015 20:35:07 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0B3402CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:35:06 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tANAYwOZ50135094
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:35:06 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tANAYWKp028318
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:34:33 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 08/10] powerpc/mm: Update pte_iterate_hashed_subpages args
Date: Mon, 23 Nov 2015 16:03:43 +0530
Message-Id: <1448274825-30289-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1448274825-30289-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1448274825-30289-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we don't really use real_pte_t drop them from iterator argument
list. The follow up patch will remove real_pte_t completely

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-64k.h |  5 +++--
 arch/powerpc/include/asm/book3s/64/pgtable.h  |  7 +++----
 arch/powerpc/mm/hash_native_64.c              | 10 ++++------
 arch/powerpc/mm/hash_utils_64.c               |  6 +++---
 arch/powerpc/platforms/pseries/lpar.c         |  4 ++--
 5 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index a28dbfe2baed..19e0afb36fa8 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -77,9 +77,10 @@ static inline pte_t __rpte_to_pte(real_pte_t rpte)
  * Trick: we set __end to va + 64k, which happens works for
  * a 16M page as well as we want only one iteration
  */
-#define pte_iterate_hashed_subpages(rpte, psize, vpn, index, shift)	\
+#define pte_iterate_hashed_subpages(vpn, psize, shift)			\
 	do {								\
-		unsigned long __end = vpn + (1UL << (PAGE_SHIFT - VPN_SHIFT));	\
+		unsigned long index;					\
+		unsigned long __end = vpn + (1UL << (PAGE_SHIFT - VPN_SHIFT)); \
 		shift = mmu_psize_defs[psize].shift;			\
 		for (index = 0; vpn < __end; index++,			\
 			     vpn += (1L << (shift - VPN_SHIFT))) {	\
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 875b2ca3d0a9..63120d4025d7 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -61,10 +61,9 @@ static inline unsigned long __rpte_to_hidx(real_pte_t rpte, unsigned long hash,
 	return 0;
 }
 
-#define pte_iterate_hashed_subpages(rpte, psize, va, index, shift)       \
-	do {							         \
-		index = 0;					         \
-		shift = mmu_psize_defs[psize].shift;		         \
+#define pte_iterate_hashed_subpages(vpn, psize, shift)		\
+	do {							\
+		shift = mmu_psize_defs[psize].shift;		\
 
 #define pte_iterate_hashed_end() } while(0)
 
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 63074bc031b1..15c92279953d 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -645,7 +645,7 @@ static void native_hpte_clear(void)
 static void native_flush_hash_range(unsigned long number, int local)
 {
 	unsigned long vpn;
-	unsigned long hash, index, hidx, shift, slot;
+	unsigned long hash, hidx, shift, slot;
 	struct hash_pte *hptep;
 	unsigned long hpte_v;
 	unsigned long want_v;
@@ -664,7 +664,7 @@ static void native_flush_hash_range(unsigned long number, int local)
 		vpn = batch->vpn[i];
 		pte = batch->pte[i];
 
-		pte_iterate_hashed_subpages(pte, psize, vpn, index, shift) {
+		pte_iterate_hashed_subpages(vpn, psize, shift) {
 			hash = hpt_hash(vpn, shift, ssize);
 			hidx = __rpte_to_hidx(pte, hash, vpn, ssize, &valid_slot);
 			if (!valid_slot)
@@ -692,8 +692,7 @@ static void native_flush_hash_range(unsigned long number, int local)
 			vpn = batch->vpn[i];
 			pte = batch->pte[i];
 
-			pte_iterate_hashed_subpages(pte, psize,
-						    vpn, index, shift) {
+			pte_iterate_hashed_subpages(vpn, psize, shift) {
 				/*
 				 * We are not looking at subpage valid here
 				 */
@@ -712,8 +711,7 @@ static void native_flush_hash_range(unsigned long number, int local)
 			vpn = batch->vpn[i];
 			pte = batch->pte[i];
 
-			pte_iterate_hashed_subpages(pte, psize,
-						    vpn, index, shift) {
+			pte_iterate_hashed_subpages(vpn, psize, shift) {
 				/*
 				 * We are not looking at subpage valid here
 				 */
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index f3d113b32c5e..99a9de74993e 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1298,11 +1298,11 @@ void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize, int ssize,
 		     unsigned long flags)
 {
 	bool valid_slot;
-	unsigned long hash, index, shift, hidx, slot;
+	unsigned long hash, shift, hidx, slot;
 	int local = flags & HPTE_LOCAL_UPDATE;
 
 	DBG_LOW("flush_hash_page(vpn=%016lx)\n", vpn);
-	pte_iterate_hashed_subpages(pte, psize, vpn, index, shift) {
+	pte_iterate_hashed_subpages(vpn, psize, shift) {
 		hash = hpt_hash(vpn, shift, ssize);
 		hidx = __rpte_to_hidx(pte, hash, vpn, ssize, &valid_slot);
 		if (!valid_slot)
@@ -1311,7 +1311,7 @@ void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize, int ssize,
 			hash = ~hash;
 		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 		slot += hidx & _PTEIDX_GROUP_IX;
-		DBG_LOW(" sub %ld: hash=%lx, hidx=%lx\n", index, slot, hidx);
+		DBG_LOW(" hash=%lx, hidx=%lx\n", slot, hidx);
 		/*
 		 * We use same base page size and actual psize, because we don't
 		 * use these functions for hugepage
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 828e298f6ce6..e3c20ea64ec8 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -534,7 +534,7 @@ static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
 	struct ppc64_tlb_batch *batch = this_cpu_ptr(&ppc64_tlb_batch);
 	int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
 	unsigned long param[9];
-	unsigned long hash, index, shift, hidx, slot;
+	unsigned long hash, shift, hidx, slot;
 	real_pte_t pte;
 	int psize, ssize;
 
@@ -549,7 +549,7 @@ static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
 
 		vpn = batch->vpn[i];
 		pte = batch->pte[i];
-		pte_iterate_hashed_subpages(pte, psize, vpn, index, shift) {
+		pte_iterate_hashed_subpages(vpn, psize, shift) {
 			hash = hpt_hash(vpn, shift, ssize);
 			hidx = __rpte_to_hidx(pte, hash, vpn, ssize, &valid_slot);
 			if (!valid_slot)
-- 
2.5.0
