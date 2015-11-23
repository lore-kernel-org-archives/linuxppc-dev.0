Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6FE771A2CFB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:35:12 +1100 (AEDT)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 23 Nov 2015 20:35:11 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id AC5802CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:35:10 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tANAZ41w36700162
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:35:12 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tANAYbeL028410
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:34:38 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 10/10] powerpc/mm: Optmize the hashed subpage iteration
Date: Mon, 23 Nov 2015 16:03:45 +0530
Message-Id: <1448274825-30289-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

If we have _PAGE_COMBO set, we override the _PAGE_F_GIX_SHIFT
and _PAGE_F_SECOND. Together we have 4 bits, each of them
used to indicate whether any of the 4 4k subpage in that group
is valid. ie,

[ group 1 bit ]   [ group 2 bit ]  ..... [ group 4 ]
[ subpage 1 - 4]  [ subpage 5- 8]  ..... [ subpage 13 - 16]

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-64k.h |  9 ++++-
 arch/powerpc/include/asm/book3s/64/pgtable.h  |  6 ++--
 arch/powerpc/mm/hash64_64k.c                  | 51 ++++++++++++++++++++-------
 arch/powerpc/mm/hash_native_64.c              | 12 ++-----
 arch/powerpc/mm/hash_utils_64.c               |  2 +-
 arch/powerpc/platforms/pseries/lpar.c         |  2 +-
 6 files changed, 55 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index 5f18801ae722..9ae5eb82fb85 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -27,6 +27,11 @@
 
 #define _PAGE_COMBO	0x00020000 /* this is a combo 4k page */
 #define _PAGE_4K_PFN	0x00040000 /* PFN is for a single 4k page */
+/*
+ * Used to track subpage group valid if _PAGE_COMBO is set
+ * This overloads _PAGE_F_GIX and _PAGE_F_SECOND
+ */
+#define _PAGE_COMBO_VALID	(_PAGE_F_GIX | _PAGE_F_SECOND)
 
 /* PTE flags to conserve for HPTE identification */
 #define _PAGE_HPTEFLAGS (_PAGE_BUSY | _PAGE_F_SECOND | \
@@ -66,17 +71,19 @@
 #define pte_to_hidx pte_to_hidx
 extern unsigned long pte_to_hidx(pte_t pte, unsigned long hash,
 				 unsigned long vpn, int ssize, bool *valid);
+extern bool pte_or_subptegroup_valid(pte_t pte, unsigned long index);
 /*
  * Trick: we set __end to va + 64k, which happens works for
  * a 16M page as well as we want only one iteration
  */
-#define pte_iterate_hashed_subpages(vpn, psize, shift)			\
+#define pte_iterate_hashed_subpages(pte, vpn, psize, shift)		\
 	do {								\
 		unsigned long index;					\
 		unsigned long __end = vpn + (1UL << (PAGE_SHIFT - VPN_SHIFT)); \
 		shift = mmu_psize_defs[psize].shift;			\
 		for (index = 0; vpn < __end; index++,			\
 			     vpn += (1L << (shift - VPN_SHIFT))) {	\
+			if (pte_or_subptegroup_valid(pte, index))		\
 				do {
 
 #define pte_iterate_hashed_end() } while(0); } } while(0)
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 74be69c8e5de..9000884cf715 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -55,9 +55,9 @@ static inline unsigned long pte_to_hidx(pte_t pte, unsigned long hash,
 #endif
 
 #ifndef pte_iterate_hashed_subpages
-#define pte_iterate_hashed_subpages(vpn, psize, shift)	\
-	do {						\
-		shift = mmu_psize_defs[psize].shift;	\
+#define pte_iterate_hashed_subpages(pte, vpn, psize, shift)	\
+        do {                                                    \
+                shift = mmu_psize_defs[psize].shift;            \
 
 #define pte_iterate_hashed_end() } while(0)
 #endif
diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
index c0bed3d01c1c..4c38ccd1e52f 100644
--- a/arch/powerpc/mm/hash64_64k.c
+++ b/arch/powerpc/mm/hash64_64k.c
@@ -16,6 +16,43 @@
 #include <asm/machdep.h>
 #include <asm/mmu.h>
 
+/*
+ * index from 0 - 15
+ */
+bool pte_or_subptegroup_valid(pte_t pte, unsigned long index)
+{
+	unsigned long ptev = pte_val(pte);
+
+	if (!(ptev & _PAGE_HASHPTE))
+		return false;
+	if (ptev & _PAGE_COMBO) {
+		unsigned long g_idx;
+
+		g_idx = (ptev & _PAGE_COMBO_VALID) >> _PAGE_F_GIX_SHIFT;
+		index = index >> 2;
+		if (g_idx & (0x1 << index))
+			return true;
+		else
+			return false;
+	}
+	return true;
+}
+
+/*
+ * index from 0 - 15
+ */
+static unsigned long mark_subptegroup_valid(unsigned long ptev, unsigned long index)
+{
+	unsigned long g_idx;
+
+	if (!(ptev & _PAGE_COMBO))
+		return ptev;
+	index = index >> 2;
+	g_idx = 0x1 << index;
+
+	return ptev | (g_idx << _PAGE_F_GIX_SHIFT);
+}
+
 unsigned long pte_to_hidx(pte_t pte, unsigned long hash,
 			  unsigned long vpn, int ssize, bool *valid)
 {
@@ -182,18 +219,8 @@ repeat:
 				   MMU_PAGE_4K, MMU_PAGE_4K, old_pte);
 		return -1;
 	}
-	/*
-	 * Insert slot number & secondary bit in PTE second half,
-	 * clear _PAGE_BUSY and set appropriate HPTE slot bit
-	 * Since we have _PAGE_BUSY set on ptep, we can be sure
-	 * nobody is undating hidx.
-	 */
-	new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | _PAGE_HASHPTE | _PAGE_COMBO;
-	/*
-	 * check __real_pte for details on matching smp_rmb()
-	 * FIXME!! We can possibly get rid of this ?
-	 */
-	smp_wmb();
+	new_pte = mark_subptegroup_valid(new_pte, subpg_index);
+	new_pte |=  _PAGE_HASHPTE;
 	*ptep = __pte(new_pte & ~_PAGE_BUSY);
 	return 0;
 }
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 9f7f6673e726..9bd0c6f505f0 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -664,7 +664,7 @@ static void native_flush_hash_range(unsigned long number, int local)
 		vpn = batch->vpn[i];
 		pte = batch->pte[i];
 
-		pte_iterate_hashed_subpages(vpn, psize, shift) {
+		pte_iterate_hashed_subpages(pte, vpn, psize, shift) {
 			hash = hpt_hash(vpn, shift, ssize);
 			hidx = pte_to_hidx(pte, hash, vpn, ssize, &valid_slot);
 			if (!valid_slot)
@@ -692,10 +692,7 @@ static void native_flush_hash_range(unsigned long number, int local)
 			vpn = batch->vpn[i];
 			pte = batch->pte[i];
 
-			pte_iterate_hashed_subpages(vpn, psize, shift) {
-				/*
-				 * We are not looking at subpage valid here
-				 */
+			pte_iterate_hashed_subpages(pte, vpn, psize, shift) {
 				__tlbiel(vpn, psize, psize, ssize);
 			} pte_iterate_hashed_end();
 		}
@@ -711,10 +708,7 @@ static void native_flush_hash_range(unsigned long number, int local)
 			vpn = batch->vpn[i];
 			pte = batch->pte[i];
 
-			pte_iterate_hashed_subpages(vpn, psize, shift) {
-				/*
-				 * We are not looking at subpage valid here
-				 */
+			pte_iterate_hashed_subpages(pte, vpn, psize, shift) {
 				__tlbie(vpn, psize, psize, ssize);
 			} pte_iterate_hashed_end();
 		}
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 80e71ccc9474..d2fa41effa23 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1302,7 +1302,7 @@ void flush_hash_page(unsigned long vpn, pte_t pte, int psize, int ssize,
 	int local = flags & HPTE_LOCAL_UPDATE;
 
 	DBG_LOW("flush_hash_page(vpn=%016lx)\n", vpn);
-	pte_iterate_hashed_subpages(vpn, psize, shift) {
+	pte_iterate_hashed_subpages(pte, vpn, psize, shift) {
 		hash = hpt_hash(vpn, shift, ssize);
 		hidx = pte_to_hidx(pte, hash, vpn, ssize, &valid_slot);
 		if (!valid_slot)
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 1708cab20fc8..06af06420a35 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -549,7 +549,7 @@ static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
 
 		vpn = batch->vpn[i];
 		pte = batch->pte[i];
-		pte_iterate_hashed_subpages(vpn, psize, shift) {
+		pte_iterate_hashed_subpages(pte, vpn, psize, shift) {
 			hash = hpt_hash(vpn, shift, ssize);
 			hidx = pte_to_hidx(pte, hash, vpn, ssize, &valid_slot);
 			if (!valid_slot)
-- 
2.5.0
