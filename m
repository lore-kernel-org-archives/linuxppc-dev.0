Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1A1BE1A05D7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 15:48:43 +1100 (AEDT)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 22 Feb 2016 23:48:41 -0500
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 1EE7F38C8026
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 23:48:38 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1N4mc9726738796
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 04:48:38 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1N4mbT0027907
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 23:48:37 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V4 03/18] powerpc/mm: add _PAGE_HASHPTE similar to 4K hash
Date: Tue, 23 Feb 2016 10:18:05 +0530
Message-Id: <1456202900-5454-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1456202900-5454-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1456202900-5454-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The difference between 64K and 4K hash fault handling is confusing
with respect to when we set _PAGE_HASHPTE in the linux pte.
I was trying to find out whether we miss a hpte flush in any
scenario because of this. ie, a pte update on a linux pte, for which we
are doing a parallel hash pte insert. After looking at it closer my
understanding is this won't happen because pte update also look at
_PAGE_BUSY and we will wait for hash pte insert to finish before going
ahead with the pte update. But to avoid further confusion keep the
hash fault handler for all the page size similar to  __hash_page_4k.

This partially reverts commit 41743a4e34f0 ("powerpc: Free a PTE bit on ppc64 with 64K pages"

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash64_64k.c         | 4 ++--
 arch/powerpc/mm/hugepage-hash64.c    | 2 +-
 arch/powerpc/mm/hugetlbpage-hash64.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
index b2d659cf51c6..507c1e55a424 100644
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
@@ -251,7 +251,7 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
 		 * Try to lock the PTE, add ACCESSED and DIRTY if it was
 		 * a write access.
 		 */
-		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED;
+		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED | _PAGE_HASHPTE;
 		if (access & _PAGE_RW)
 			new_pte |= _PAGE_DIRTY;
 	} while (old_pte != __cmpxchg_u64((unsigned long *)ptep,
diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
index eb2accdd76fd..56d677b7972c 100644
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
index 8555fce902fe..08efcad7cae0 100644
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
