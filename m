Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41H9434GY7zF1dT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 18:36:51 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5T8Y1Q9025972
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 04:36:48 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jwe65g92q-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 04:36:48 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Fri, 29 Jun 2018 02:36:47 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 1/3] powerpc/mm/hash: Remove the superfluous bitwise operation
 when find hpte group
Date: Fri, 29 Jun 2018 14:06:29 +0530
Message-Id: <20180629083631.28017-1-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

When computing the starting slot number for a hash page table group we used
to do this
hpte_group = ((hash & htab_hash_mask) * HPTES_PER_GROUP) & ~0x7UL;

Multiplying with 8 (HPTES_PER_GROUP) imply the last three bits are 0. Hence we
really don't need to clear then separately.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/dump_hashpagetable.c |  2 +-
 arch/powerpc/mm/hash64_4k.c          |  8 ++++----
 arch/powerpc/mm/hash64_64k.c         | 15 +++++++--------
 arch/powerpc/mm/hash_utils_64.c      | 10 ++++------
 arch/powerpc/mm/hugepage-hash64.c    |  9 ++++-----
 5 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/mm/dump_hashpagetable.c b/arch/powerpc/mm/dump_hashpagetable.c
index 14cfb11b09d0..d241cb6518da 100644
--- a/arch/powerpc/mm/dump_hashpagetable.c
+++ b/arch/powerpc/mm/dump_hashpagetable.c
@@ -260,7 +260,7 @@ static int pseries_find(unsigned long ea, int psize, bool primary, u64 *v, u64 *
 	/* to check in the secondary hash table, we invert the hash */
 	if (!primary)
 		hash = ~hash;
-	hpte_group = ((hash & htab_hash_mask) * HPTES_PER_GROUP) & ~0x7UL;
+	hpte_group = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 	/* see if we can find an entry in the hpte with this hash */
 	for (i = 0; i < HPTES_PER_GROUP; i += 4, hpte_group += 4) {
 		lpar_rc = plpar_pte_read_4(0, hpte_group, (void *)ptes);
diff --git a/arch/powerpc/mm/hash64_4k.c b/arch/powerpc/mm/hash64_4k.c
index d573d7d07f25..6fa6765a10eb 100644
--- a/arch/powerpc/mm/hash64_4k.c
+++ b/arch/powerpc/mm/hash64_4k.c
@@ -80,7 +80,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 		hash = hpt_hash(vpn, shift, ssize);
 
 repeat:
-		hpte_group = ((hash & htab_hash_mask) * HPTES_PER_GROUP) & ~0x7UL;
+		hpte_group = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 
 		/* Insert into the hash table, primary slot */
 		slot = mmu_hash_ops.hpte_insert(hpte_group, vpn, pa, rflags, 0,
@@ -89,7 +89,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 		 * Primary is full, try the secondary
 		 */
 		if (unlikely(slot == -1)) {
-			hpte_group = ((~hash & htab_hash_mask) * HPTES_PER_GROUP) & ~0x7UL;
+			hpte_group = (~hash & htab_hash_mask) * HPTES_PER_GROUP;
 			slot = mmu_hash_ops.hpte_insert(hpte_group, vpn, pa,
 							rflags,
 							HPTE_V_SECONDARY,
@@ -97,8 +97,8 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 							MMU_PAGE_4K, ssize);
 			if (slot == -1) {
 				if (mftb() & 0x1)
-					hpte_group = ((hash & htab_hash_mask) *
-						      HPTES_PER_GROUP) & ~0x7UL;
+					hpte_group = (hash & htab_hash_mask) *
+							HPTES_PER_GROUP;
 				mmu_hash_ops.hpte_remove(hpte_group);
 				/*
 				 * FIXME!! Should be try the group from which we removed ?
diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
index e601d95c3b20..3afa253d7f52 100644
--- a/arch/powerpc/mm/hash64_64k.c
+++ b/arch/powerpc/mm/hash64_64k.c
@@ -154,7 +154,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 	}
 	hash = hpt_hash(vpn, shift, ssize);
 repeat:
-	hpte_group = ((hash & htab_hash_mask) * HPTES_PER_GROUP) & ~0x7UL;
+	hpte_group = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 
 	/* Insert into the hash table, primary slot */
 	slot = mmu_hash_ops.hpte_insert(hpte_group, vpn, pa, rflags, 0,
@@ -165,7 +165,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 	if (unlikely(slot == -1)) {
 		bool soft_invalid;
 
-		hpte_group = ((~hash & htab_hash_mask) * HPTES_PER_GROUP) & ~0x7UL;
+		hpte_group = (~hash & htab_hash_mask) * HPTES_PER_GROUP;
 		slot = mmu_hash_ops.hpte_insert(hpte_group, vpn, pa,
 						rflags, HPTE_V_SECONDARY,
 						MMU_PAGE_4K, MMU_PAGE_4K,
@@ -193,8 +193,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 			 * that we do not get the same soft-invalid slot.
 			 */
 			if (soft_invalid || (mftb() & 0x1))
-				hpte_group = ((hash & htab_hash_mask) *
-					      HPTES_PER_GROUP) & ~0x7UL;
+				hpte_group = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 
 			mmu_hash_ops.hpte_remove(hpte_group);
 			/*
@@ -288,7 +287,7 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
 		hash = hpt_hash(vpn, shift, ssize);
 
 repeat:
-		hpte_group = ((hash & htab_hash_mask) * HPTES_PER_GROUP) & ~0x7UL;
+		hpte_group = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 
 		/* Insert into the hash table, primary slot */
 		slot = mmu_hash_ops.hpte_insert(hpte_group, vpn, pa, rflags, 0,
@@ -298,7 +297,7 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
 		 * Primary is full, try the secondary
 		 */
 		if (unlikely(slot == -1)) {
-			hpte_group = ((~hash & htab_hash_mask) * HPTES_PER_GROUP) & ~0x7UL;
+			hpte_group = (~hash & htab_hash_mask) * HPTES_PER_GROUP;
 			slot = mmu_hash_ops.hpte_insert(hpte_group, vpn, pa,
 							rflags,
 							HPTE_V_SECONDARY,
@@ -306,8 +305,8 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
 							MMU_PAGE_64K, ssize);
 			if (slot == -1) {
 				if (mftb() & 0x1)
-					hpte_group = ((hash & htab_hash_mask) *
-						      HPTES_PER_GROUP) & ~0x7UL;
+					hpte_group = (hash & htab_hash_mask) *
+							HPTES_PER_GROUP;
 				mmu_hash_ops.hpte_remove(hpte_group);
 				/*
 				 * FIXME!! Should be try the group from which we removed ?
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 8318716e5075..4ba901223000 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1783,8 +1783,7 @@ long hpte_insert_repeating(unsigned long hash, unsigned long vpn,
 	long slot;
 
 repeat:
-	hpte_group = ((hash & htab_hash_mask) *
-		       HPTES_PER_GROUP) & ~0x7UL;
+	hpte_group = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 
 	/* Insert into the hash table, primary slot */
 	slot = mmu_hash_ops.hpte_insert(hpte_group, vpn, pa, rflags, vflags,
@@ -1792,15 +1791,14 @@ long hpte_insert_repeating(unsigned long hash, unsigned long vpn,
 
 	/* Primary is full, try the secondary */
 	if (unlikely(slot == -1)) {
-		hpte_group = ((~hash & htab_hash_mask) *
-			      HPTES_PER_GROUP) & ~0x7UL;
+		hpte_group = (~hash & htab_hash_mask) * HPTES_PER_GROUP;
 		slot = mmu_hash_ops.hpte_insert(hpte_group, vpn, pa, rflags,
 						vflags | HPTE_V_SECONDARY,
 						psize, psize, ssize);
 		if (slot == -1) {
 			if (mftb() & 0x1)
-				hpte_group = ((hash & htab_hash_mask) *
-					      HPTES_PER_GROUP)&~0x7UL;
+				hpte_group = (hash & htab_hash_mask) *
+						HPTES_PER_GROUP;
 
 			mmu_hash_ops.hpte_remove(hpte_group);
 			goto repeat;
diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
index f20d16f849c5..01f213d2bcb9 100644
--- a/arch/powerpc/mm/hugepage-hash64.c
+++ b/arch/powerpc/mm/hugepage-hash64.c
@@ -128,7 +128,7 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 		new_pmd |= H_PAGE_HASHPTE;
 
 repeat:
-		hpte_group = ((hash & htab_hash_mask) * HPTES_PER_GROUP) & ~0x7UL;
+		hpte_group = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 
 		/* Insert into the hash table, primary slot */
 		slot = mmu_hash_ops.hpte_insert(hpte_group, vpn, pa, rflags, 0,
@@ -137,16 +137,15 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 		 * Primary is full, try the secondary
 		 */
 		if (unlikely(slot == -1)) {
-			hpte_group = ((~hash & htab_hash_mask) *
-				      HPTES_PER_GROUP) & ~0x7UL;
+			hpte_group = (~hash & htab_hash_mask) * HPTES_PER_GROUP;
 			slot = mmu_hash_ops.hpte_insert(hpte_group, vpn, pa,
 							rflags,
 							HPTE_V_SECONDARY,
 							psize, lpsize, ssize);
 			if (slot == -1) {
 				if (mftb() & 0x1)
-					hpte_group = ((hash & htab_hash_mask) *
-						      HPTES_PER_GROUP) & ~0x7UL;
+					hpte_group = (hash & htab_hash_mask) *
+							HPTES_PER_GROUP;
 
 				mmu_hash_ops.hpte_remove(hpte_group);
 				goto repeat;
-- 
2.17.1
