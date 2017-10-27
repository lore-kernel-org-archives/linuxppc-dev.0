Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yNVk10KMrzDrbl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Oct 2017 15:08:56 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9R48Us8020629
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Oct 2017 00:08:55 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dur20nm4c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Oct 2017 00:08:54 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 26 Oct 2017 22:08:53 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 01/16] powerpc/mm/hash: Remove the superfluous bitwise
 operation when find hpte group
Date: Fri, 27 Oct 2017 09:38:18 +0530
In-Reply-To: <20171027040833.3644-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20171027040833.3644-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20171027040833.3644-2-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When computing the starting slot number for a hash page table group we used
to do this
hpte_group = ((hash & htab_hash_mask) * HPTES_PER_GROUP) & ~0x7UL;

Multiplying with 8 (HPTES_PER_GROUP) imply the last three bits are 0. Hence we
really don't need to clear then separately.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/dump_hashpagetable.c |  2 +-
 arch/powerpc/mm/hash64_4k.c          |  8 ++++----
 arch/powerpc/mm/hash64_64k.c         | 16 ++++++++--------
 arch/powerpc/mm/hash_utils_64.c      | 10 ++++------
 arch/powerpc/mm/hugepage-hash64.c    |  9 ++++-----
 5 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/mm/dump_hashpagetable.c b/arch/powerpc/mm/dump_hashpagetable.c
index 5c4c93dcff19..2384d40bfcf4 100644
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
index 6fa450c12d6d..975793de0914 100644
--- a/arch/powerpc/mm/hash64_4k.c
+++ b/arch/powerpc/mm/hash64_4k.c
@@ -81,7 +81,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 		hash = hpt_hash(vpn, shift, ssize);
 
 repeat:
-		hpte_group = ((hash & htab_hash_mask) * HPTES_PER_GROUP) & ~0x7UL;
+		hpte_group = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 
 		/* Insert into the hash table, primary slot */
 		slot = mmu_hash_ops.hpte_insert(hpte_group, vpn, pa, rflags, 0,
@@ -90,7 +90,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 		 * Primary is full, try the secondary
 		 */
 		if (unlikely(slot == -1)) {
-			hpte_group = ((~hash & htab_hash_mask) * HPTES_PER_GROUP) & ~0x7UL;
+			hpte_group = (~hash & htab_hash_mask) * HPTES_PER_GROUP;
 			slot = mmu_hash_ops.hpte_insert(hpte_group, vpn, pa,
 							rflags,
 							HPTE_V_SECONDARY,
@@ -98,8 +98,8 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
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
index 1a68cb19b0e3..f1eb538721fc 100644
--- a/arch/powerpc/mm/hash64_64k.c
+++ b/arch/powerpc/mm/hash64_64k.c
@@ -163,7 +163,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 	}
 	hash = hpt_hash(vpn, shift, ssize);
 repeat:
-	hpte_group = ((hash & htab_hash_mask) * HPTES_PER_GROUP) & ~0x7UL;
+	hpte_group = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 
 	/* Insert into the hash table, primary slot */
 	slot = mmu_hash_ops.hpte_insert(hpte_group, vpn, pa, rflags, 0,
@@ -172,15 +172,15 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 	 * Primary is full, try the secondary
 	 */
 	if (unlikely(slot == -1)) {
-		hpte_group = ((~hash & htab_hash_mask) * HPTES_PER_GROUP) & ~0x7UL;
+		hpte_group = (~hash & htab_hash_mask) * HPTES_PER_GROUP;
 		slot = mmu_hash_ops.hpte_insert(hpte_group, vpn, pa,
 						rflags, HPTE_V_SECONDARY,
 						MMU_PAGE_4K, MMU_PAGE_4K,
 						ssize);
 		if (slot == -1) {
 			if (mftb() & 0x1)
-				hpte_group = ((hash & htab_hash_mask) *
-					      HPTES_PER_GROUP) & ~0x7UL;
+				hpte_group = (hash & htab_hash_mask) *
+						HPTES_PER_GROUP;
 			mmu_hash_ops.hpte_remove(hpte_group);
 			/*
 			 * FIXME!! Should be try the group from which we removed ?
@@ -285,7 +285,7 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
 		hash = hpt_hash(vpn, shift, ssize);
 
 repeat:
-		hpte_group = ((hash & htab_hash_mask) * HPTES_PER_GROUP) & ~0x7UL;
+		hpte_group = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 
 		/* Insert into the hash table, primary slot */
 		slot = mmu_hash_ops.hpte_insert(hpte_group, vpn, pa, rflags, 0,
@@ -295,7 +295,7 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
 		 * Primary is full, try the secondary
 		 */
 		if (unlikely(slot == -1)) {
-			hpte_group = ((~hash & htab_hash_mask) * HPTES_PER_GROUP) & ~0x7UL;
+			hpte_group = (~hash & htab_hash_mask) * HPTES_PER_GROUP;
 			slot = mmu_hash_ops.hpte_insert(hpte_group, vpn, pa,
 							rflags,
 							HPTE_V_SECONDARY,
@@ -303,8 +303,8 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
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
index 655a5a9a183d..4d4662a77c14 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1723,8 +1723,7 @@ long hpte_insert_repeating(unsigned long hash, unsigned long vpn,
 	long slot;
 
 repeat:
-	hpte_group = ((hash & htab_hash_mask) *
-		       HPTES_PER_GROUP) & ~0x7UL;
+	hpte_group = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 
 	/* Insert into the hash table, primary slot */
 	slot = mmu_hash_ops.hpte_insert(hpte_group, vpn, pa, rflags, vflags,
@@ -1732,15 +1731,14 @@ long hpte_insert_repeating(unsigned long hash, unsigned long vpn,
 
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
2.13.6
