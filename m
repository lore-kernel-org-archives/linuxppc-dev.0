Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 020D81A04EF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2016 03:45:06 +1100 (AEDT)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 18 Feb 2016 11:45:04 -0500
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id E102AC9003E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 11:44:56 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1IGiwrA33292540
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 16:44:59 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1IGivuC030859
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 11:44:58 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/mm/hash: Clear the invalid slot information correctly
Date: Thu, 18 Feb 2016 22:14:44 +0530
Message-Id: <1455813884-8283-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We can get a hash pte fault with 4k base page size and find the pte
already inserted with 64K base page size. In that case we need to clear
the existing slot information from the old pte. Fix this correctly

With THP, we also clear the slot information with respect to all
the 64K hash pte mapping that 16MB page. They are all invalid
now. This make sure we don't find the slot valid when we fault with
4k base page size. Finding the slot valid should not result in any wrong
behavior because we do check again in hash page table for the validity.
But we can avoid that check completely.

Fixes: a43c0eb8364c022 ("powerpc/mm: Convert 4k hash insert to C")

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash64_4k.c       |  2 +-
 arch/powerpc/mm/hash64_64k.c      | 12 +++++++++---
 arch/powerpc/mm/hugepage-hash64.c |  7 ++++++-
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/hash64_4k.c b/arch/powerpc/mm/hash64_4k.c
index e7c04542ba62..e3e76b929f33 100644
--- a/arch/powerpc/mm/hash64_4k.c
+++ b/arch/powerpc/mm/hash64_4k.c
@@ -106,7 +106,7 @@ repeat:
 			}
 		}
 		/*
-		 * Hypervisor failure. Restore old pmd and return -1
+		 * Hypervisor failure. Restore old pte and return -1
 		 * similar to __hash_page_*
 		 */
 		if (unlikely(slot == -2)) {
diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
index 0762c1e08c88..b3895720edb0 100644
--- a/arch/powerpc/mm/hash64_64k.c
+++ b/arch/powerpc/mm/hash64_64k.c
@@ -111,7 +111,13 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 	 */
 	if (!(old_pte & _PAGE_COMBO)) {
 		flush_hash_page(vpn, rpte, MMU_PAGE_64K, ssize, flags);
-		old_pte &= ~_PAGE_HASHPTE | _PAGE_F_GIX | _PAGE_F_SECOND;
+		/*
+		 * clear the old slot details from the old and new pte.
+		 * On hash insert failure we use old pte value and we don't
+		 * want slot information there if we have a insert failure.
+		 */
+		old_pte &= ~(_PAGE_HASHPTE | _PAGE_F_GIX | _PAGE_F_SECOND);
+		new_pte &= ~(_PAGE_HASHPTE | _PAGE_F_GIX | _PAGE_F_SECOND);
 		goto htab_insert_hpte;
 	}
 	/*
@@ -182,7 +188,7 @@ repeat:
 		}
 	}
 	/*
-	 * Hypervisor failure. Restore old pmd and return -1
+	 * Hypervisor failure. Restore old pte and return -1
 	 * similar to __hash_page_*
 	 */
 	if (unlikely(slot == -2)) {
@@ -305,7 +311,7 @@ repeat:
 			}
 		}
 		/*
-		 * Hypervisor failure. Restore old pmd and return -1
+		 * Hypervisor failure. Restore old pte and return -1
 		 * similar to __hash_page_*
 		 */
 		if (unlikely(slot == -2)) {
diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
index 49b152b0f926..8424f46c2bf7 100644
--- a/arch/powerpc/mm/hugepage-hash64.c
+++ b/arch/powerpc/mm/hugepage-hash64.c
@@ -78,9 +78,14 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 		 * base page size. This is because demote_segment won't flush
 		 * hash page table entries.
 		 */
-		if ((old_pmd & _PAGE_HASHPTE) && !(old_pmd & _PAGE_COMBO))
+		if ((old_pmd & _PAGE_HASHPTE) && !(old_pmd & _PAGE_COMBO)) {
 			flush_hash_hugepage(vsid, ea, pmdp, MMU_PAGE_64K,
 					    ssize, flags);
+			/*
+			 * clear the old slot information 
+			 */
+			memset(hpte_slot_array, 0, PTE_FRAG_SIZE);
+		}
 	}
 
 	valid = hpte_valid(hpte_slot_array, index);
-- 
2.5.0
