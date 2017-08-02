Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMhr10KmRzDsQH
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 15:41:04 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v725f23l055650
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 01:41:02 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c361vfnrb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Aug 2017 01:41:02 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 1 Aug 2017 23:40:55 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Anton Blanchard <anton@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH 04/17] powerpc/mm: Add hash invalidate callback
Date: Wed,  2 Aug 2017 11:10:03 +0530
In-Reply-To: <20170802054016.8927-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20170802054016.8927-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20170802054016.8927-5-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add hash based invalidate callback and use that in flush_hash_page.
Note: In a later patch, we will drop the slot tracking completely. At that point
we will also loose the __rpte_sub_valid() check in
pte_iterate_hashed_subpages(). That means we call the invalidate for all
subpages irrespective of whether we took a hash fault on that or not.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |  4 ++++
 arch/powerpc/mm/hash_native_64.c              | 27 +++++++++++++++++++++++++++
 arch/powerpc/mm/hash_utils_64.c               | 11 +++--------
 arch/powerpc/platforms/ps3/htab.c             | 22 ++++++++++++++++++++++
 arch/powerpc/platforms/pseries/lpar.c         | 26 ++++++++++++++++++++++++++
 5 files changed, 82 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index f9cce40a4035..7e1fcae472f0 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -135,6 +135,10 @@ struct mmu_hash_ops {
 					   unsigned long vpn,
 					   int bpsize, int apsize,
 					   int ssize, int local);
+	void            (*hash_invalidate)(unsigned long hash,
+					   unsigned long vpn,
+					   int bpsize, int apsize,
+					   int ssize, int local);
 	long		(*hpte_updatepp)(unsigned long slot,
 					 unsigned long newpp,
 					 unsigned long vpn,
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 4b3f6d66e7f0..ce25e125dd06 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -492,6 +492,32 @@ static void native_hpte_invalidate(unsigned long slot, unsigned long vpn,
 	local_irq_restore(flags);
 }
 
+static void native_hash_invalidate(unsigned long hash, unsigned long vpn,
+				   int bpsize, int apsize, int ssize, int local)
+{
+	unsigned long flags;
+	struct hash_pte *hptep;
+
+	DBG_LOW("    invalidate(vpn=%016lx, hash: %lx)\n", vpn, hash);
+	local_irq_save(flags);
+	hptep = native_hpte_find(hash, vpn, bpsize, ssize);
+	if (hptep) {
+		/*
+		 * Invalidate the hpte. NOTE: this also unlocks it
+		 */
+		hptep->v = 0;
+	}
+	/*
+	 * We need to invalidate the TLB always because hpte_remove doesn't do
+	 * a tlb invalidate. If a hash bucket gets full, we "evict" a more/less
+	 * random entry from it. When we do that we don't invalidate the TLB
+	 * (hpte_remove) because we assume the old translation is still
+	 * technically "valid".
+	 */
+	tlbie(vpn, bpsize, apsize, ssize, local);
+	local_irq_restore(flags);
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static void native_hugepage_invalidate(unsigned long vsid,
 				       unsigned long addr,
@@ -771,6 +797,7 @@ static int native_register_proc_table(unsigned long base, unsigned long page_siz
 void __init hpte_init_native(void)
 {
 	mmu_hash_ops.hpte_invalidate	= native_hpte_invalidate;
+	mmu_hash_ops.hash_invalidate	= native_hash_invalidate;
 	mmu_hash_ops.hpte_updatepp	= native_hpte_updatepp;
 	mmu_hash_ops.hpte_updateboltedpp = native_hpte_updateboltedpp;
 	mmu_hash_ops.hpte_removebolted = native_hpte_removebolted;
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index ff3c9522a2b3..a02570b4cfed 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1598,23 +1598,18 @@ static inline void tm_flush_hash_page(int local)
 void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize, int ssize,
 		     unsigned long flags)
 {
-	unsigned long hash, index, shift, hidx, slot;
+	unsigned long hash, index, shift;
 	int local = flags & HPTE_LOCAL_UPDATE;
 
 	DBG_LOW("flush_hash_page(vpn=%016lx)\n", vpn);
 	pte_iterate_hashed_subpages(pte, psize, vpn, index, shift) {
 		hash = hpt_hash(vpn, shift, ssize);
-		hidx = __rpte_to_hidx(pte, index);
-		if (hidx & _PTEIDX_SECONDARY)
-			hash = ~hash;
-		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
-		slot += hidx & _PTEIDX_GROUP_IX;
-		DBG_LOW(" sub %ld: hash=%lx, hidx=%lx\n", index, slot, hidx);
+		DBG_LOW(" sub %ld: hash=%lx\n", index, hash);
 		/*
 		 * We use same base page size and actual psize, because we don't
 		 * use these functions for hugepage
 		 */
-		mmu_hash_ops.hpte_invalidate(slot, vpn, psize, psize,
+		mmu_hash_ops.hash_invalidate(hash, vpn, psize, psize,
 					     ssize, local);
 	} pte_iterate_hashed_end();
 
diff --git a/arch/powerpc/platforms/ps3/htab.c b/arch/powerpc/platforms/ps3/htab.c
index 255b7a33fefe..813c2f77f75d 100644
--- a/arch/powerpc/platforms/ps3/htab.c
+++ b/arch/powerpc/platforms/ps3/htab.c
@@ -230,9 +230,31 @@ static long ps3_hpte_find(unsigned long hash, unsigned long want_v)
 	return -1;
 }
 
+static void ps3_hash_invalidate(unsigned long hash, unsigned long vpn,
+				int psize, int apsize, int ssize, int local)
+{
+	long slot;
+	unsigned long flags;
+	unsigned long want_v;
+
+	want_v = hpte_encode_avpn(vpn, psize, ssize);
+
+	spin_lock_irqsave(&ps3_htab_lock, flags);
+	slot = ps3_hpte_find(hash, want_v);
+	if (slot < 0)
+		/* HPTE not found */
+		goto err_out;
+	/* invalidate the entry */
+	lv1_write_htab_entry(PS3_LPAR_VAS_ID_CURRENT, slot, 0, 0);
+err_out:
+	spin_unlock_irqrestore(&ps3_htab_lock, flags);
+	return;
+}
+
 void __init ps3_hpte_init(unsigned long htab_size)
 {
 	mmu_hash_ops.hpte_invalidate = ps3_hpte_invalidate;
+	mmu_hash_ops.hash_invalidate = ps3_hash_invalidate;
 	mmu_hash_ops.hpte_updatepp = ps3_hpte_updatepp;
 	mmu_hash_ops.hpte_updateboltedpp = ps3_hpte_updateboltedpp;
 	mmu_hash_ops.hpte_insert = ps3_hpte_insert;
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index edab68d9f9f3..e366252e0e93 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -419,6 +419,31 @@ static void pSeries_lpar_hpte_invalidate(unsigned long slot, unsigned long vpn,
 	BUG_ON(lpar_rc != H_SUCCESS);
 }
 
+static void pSeries_lpar_hash_invalidate(unsigned long hash, unsigned long vpn,
+					 int psize, int apsize,
+					 int ssize, int local)
+{
+	long slot;
+	unsigned long want_v;
+	unsigned long lpar_rc;
+	unsigned long dummy1, dummy2;
+
+	pr_devel("    inval : hash=%lx, vpn=%016lx, psize: %d, local: %d\n",
+		 hash, vpn, psize, local);
+
+	want_v = hpte_encode_avpn(vpn, psize, ssize);
+	slot = __pSeries_lpar_hpte_find(hash, want_v);
+	if (slot < 0)
+		/* HPTE not found */
+		return;
+	lpar_rc = plpar_pte_remove(H_AVPN, slot, want_v, &dummy1, &dummy2);
+	if (lpar_rc == H_NOT_FOUND)
+		return;
+
+	BUG_ON(lpar_rc != H_SUCCESS);
+}
+
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 /*
  * Limit iterations holding pSeries_lpar_tlbie_lock to 3. We also need
@@ -758,6 +783,7 @@ static int pseries_lpar_register_process_table(unsigned long base,
 void __init hpte_init_pseries(void)
 {
 	mmu_hash_ops.hpte_invalidate	 = pSeries_lpar_hpte_invalidate;
+	mmu_hash_ops.hash_invalidate	 = pSeries_lpar_hash_invalidate;
 	mmu_hash_ops.hpte_updatepp	 = pSeries_lpar_hpte_updatepp;
 	mmu_hash_ops.hpte_updateboltedpp = pSeries_lpar_hpte_updateboltedpp;
 	mmu_hash_ops.hpte_insert	 = pSeries_lpar_hpte_insert;
-- 
2.13.3
