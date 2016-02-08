Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 571FD1A0193
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Feb 2016 20:21:02 +1100 (AEDT)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 8 Feb 2016 04:21:00 -0500
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 89090C90042
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Feb 2016 04:20:54 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u189KuKW32964774
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Feb 2016 09:20:56 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u189Ks0X015554
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Feb 2016 04:20:56 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 01/29] powerpc/mm: add _PAGE_HASHPTE similar to 4K hash
Date: Mon,  8 Feb 2016 14:50:13 +0530
Message-Id: <1454923241-6681-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1454923241-6681-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1454923241-6681-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Not really needed. But this brings it back to as it was before

Check this
41743a4e34f0777f51c1cf0675b91508ba143050

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash64_64k.c         | 4 ++--
 arch/powerpc/mm/hugepage-hash64.c    | 2 +-
 arch/powerpc/mm/hugetlbpage-hash64.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
index 0762c1e08c88..3c417f9099f9 100644
--- a/arch/powerpc/mm/hash64_64k.c
+++ b/arch/powerpc/mm/hash64_64k.c
@@ -76,7 +76,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 		 * a write access. Since this is 4K insert of 64K page size
 		 * also add _PAGE_COMBO
 		 */
-		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED | _PAGE_COMBO;
+		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED | _PAGE_COMBO | _PAGE_HASHPTE;
 		if (access & _PAGE_RW)
 			new_pte |= _PAGE_DIRTY;
 	} while (old_pte != __cmpxchg_u64((unsigned long *)ptep,
@@ -246,7 +246,7 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
 		 * a write access. Since this is 4K insert of 64K page size
 		 * also add _PAGE_COMBO
 		 */
-		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED;
+		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED | _PAGE_HASHPTE;
 		if (access & _PAGE_RW)
 			new_pte |= _PAGE_DIRTY;
 	} while (old_pte != __cmpxchg_u64((unsigned long *)ptep,
diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
index 49b152b0f926..3c4bd4c0ade9 100644
--- a/arch/powerpc/mm/hugepage-hash64.c
+++ b/arch/powerpc/mm/hugepage-hash64.c
@@ -46,7 +46,7 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 		 * Try to lock the PTE, add ACCESSED and DIRTY if it was
 		 * a write access
 		 */
-		new_pmd = old_pmd | _PAGE_BUSY | _PAGE_ACCESSED;
+		new_pmd = old_pmd | _PAGE_BUSY | _PAGE_ACCESSED | _PAGE_HASHPTE;
 		if (access & _PAGE_RW)
 			new_pmd |= _PAGE_DIRTY;
 	} while (old_pmd != __cmpxchg_u64((unsigned long *)pmdp,
diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index e2138c7ae70f..9c224b012d62 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -54,7 +54,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 			return 1;
 		/* Try to lock the PTE, add ACCESSED and DIRTY if it was
 		 * a write access */
-		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED;
+		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED | _PAGE_HASHPTE;
 		if (access & _PAGE_RW)
 			new_pte |= _PAGE_DIRTY;
 	} while(old_pte != __cmpxchg_u64((unsigned long *)ptep,
-- 
2.5.0
