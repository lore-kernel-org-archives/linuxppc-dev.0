Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B91E41A02BA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 07:12:50 +1100 (AEDT)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 21 Oct 2015 01:42:48 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 441F2125805F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 01:42:36 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9KKCk8J459060
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 01:42:46 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9KKCjQS006458
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 01:42:45 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH 6/7] powerpc/mm: Update pte_iterate_hashed_subpaes args
Date: Wed, 21 Oct 2015 01:42:32 +0530
Message-Id: <1445371953-9627-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1445371953-9627-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1445371953-9627-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/nohash/64/pgtable.h  |  7 +++----
 arch/powerpc/mm/hash_native_64.c              | 10 ++++------
 arch/powerpc/mm/hash_utils_64.c               |  6 +++---
 arch/powerpc/platforms/pseries/lpar.c         |  4 ++--
 6 files changed, 18 insertions(+), 21 deletions(-)

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
index 64ef7316ff88..79a90ca7b9f6 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -52,10 +52,9 @@
 #endif
 #define __rpte_to_hidx(r,index)	(pte_val(__rpte_to_pte(r)) >>_PAGE_F_GIX_SHIFT)
 
-#define pte_iterate_hashed_subpages(rpte, psize, va, index, shift)       \
-	do {							         \
-		index = 0;					         \
-		shift = mmu_psize_defs[psize].shift;		         \
+#define pte_iterate_hashed_subpages(vpn, psize, shift)		\
+	do {							\
+		shift = mmu_psize_defs[psize].shift;		\
 
 #define pte_iterate_hashed_end() } while(0)
 
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index 8969b4c93c4f..37b5a62d18f4 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -123,10 +123,9 @@
 #endif
 #define __rpte_to_hidx(r,index)	(pte_val(__rpte_to_pte(r)) >> _PAGE_F_GIX_SHIFT)
 
-#define pte_iterate_hashed_subpages(rpte, psize, va, index, shift)       \
-	do {							         \
-		index = 0;					         \
-		shift = mmu_psize_defs[psize].shift;		         \
+#define pte_iterate_hashed_subpages(vpn, psize, shift)       \
+	do {						     \
+		shift = mmu_psize_defs[psize].shift;	     \
 
 #define pte_iterate_hashed_end() } while(0)
 
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index ca747ae19c76..b035dafcdea0 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -646,7 +646,7 @@ static void native_hpte_clear(void)
 static void native_flush_hash_range(unsigned long number, int local)
 {
 	unsigned long vpn;
-	unsigned long hash, index, hidx, shift, slot;
+	unsigned long hash, hidx, shift, slot;
 	struct hash_pte *hptep;
 	unsigned long hpte_v;
 	unsigned long want_v;
@@ -665,7 +665,7 @@ static void native_flush_hash_range(unsigned long number, int local)
 		vpn = batch->vpn[i];
 		pte = batch->pte[i];
 
-		pte_iterate_hashed_subpages(pte, psize, vpn, index, shift) {
+		pte_iterate_hashed_subpages(vpn, psize, shift) {
 			hash = hpt_hash(vpn, shift, ssize);
 			hidx = __rpte_to_hidx(pte, hash, vpn, ssize, &valid_slot);
 			if (!valid_slot)
@@ -693,8 +693,7 @@ static void native_flush_hash_range(unsigned long number, int local)
 			vpn = batch->vpn[i];
 			pte = batch->pte[i];
 
-			pte_iterate_hashed_subpages(pte, psize,
-						    vpn, index, shift) {
+			pte_iterate_hashed_subpages(vpn, psize, shift) {
 				/*
 				 * We are not looking at subpage valid here
 				 */
@@ -713,8 +712,7 @@ static void native_flush_hash_range(unsigned long number, int local)
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
index c7c6bde41293..431290b08113 100644
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
