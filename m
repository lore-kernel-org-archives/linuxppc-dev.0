Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E2A851A01EB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:42:46 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 21 Sep 2015 16:42:46 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 8F0382BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:42:42 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8L6gOxE14483492
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:42:32 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8L6g9IQ015221
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:42:10 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 20/31] powerpc/mm: update __real_pte to take address as
 argument
Date: Mon, 21 Sep 2015 12:10:47 +0530
Message-Id: <1442817658-2588-21-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1442817658-2588-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1442817658-2588-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We will use this in the later patch to compute the right hash index

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-64k.h | 2 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h  | 4 ++--
 arch/powerpc/include/asm/booke/64/pgtable.h   | 4 ++--
 arch/powerpc/mm/hash64_64k.c                  | 2 +-
 arch/powerpc/mm/tlb_hash64.c                  | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index ee073822145d..ced5a17a8d1a 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -78,7 +78,7 @@
  * generic accessors and iterators here
  */
 #define __real_pte __real_pte
-static inline real_pte_t __real_pte(pte_t pte, pte_t *ptep)
+static inline real_pte_t __real_pte(unsigned long addr, pte_t pte, pte_t *ptep)
 {
 	real_pte_t rpte;
 
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index f2ace2cac7bb..3117f0495b74 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -44,10 +44,10 @@
 #ifndef __real_pte
 
 #ifdef CONFIG_STRICT_MM_TYPECHECKS
-#define __real_pte(e,p)		((real_pte_t){(e)})
+#define __real_pte(a,e,p)	((real_pte_t){(e)})
 #define __rpte_to_pte(r)	((r).pte)
 #else
-#define __real_pte(e,p)		(e)
+#define __real_pte(a,e,p)	(e)
 #define __rpte_to_pte(r)	(__pte(r))
 #endif
 #define __rpte_to_hidx(r,index)	(pte_val(__rpte_to_pte(r)) >> 12)
diff --git a/arch/powerpc/include/asm/booke/64/pgtable.h b/arch/powerpc/include/asm/booke/64/pgtable.h
index 9abf7a1720f7..81e850c32c13 100644
--- a/arch/powerpc/include/asm/booke/64/pgtable.h
+++ b/arch/powerpc/include/asm/booke/64/pgtable.h
@@ -115,10 +115,10 @@
 #ifndef __real_pte
 
 #ifdef CONFIG_STRICT_MM_TYPECHECKS
-#define __real_pte(e,p)		((real_pte_t){(e)})
+#define __real_pte(a,e,p)	((real_pte_t){(e)})
 #define __rpte_to_pte(r)	((r).pte)
 #else
-#define __real_pte(e,p)		(e)
+#define __real_pte(a,e,p)	(e)
 #define __rpte_to_pte(r)	(__pte(r))
 #endif
 #define __rpte_to_hidx(r,index)	(pte_val(__rpte_to_pte(r)) >> 12)
diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
index cbbef40c549a..0c2a4c1c482f 100644
--- a/arch/powerpc/mm/hash64_64k.c
+++ b/arch/powerpc/mm/hash64_64k.c
@@ -92,7 +92,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 
 	subpg_index = (ea & (PAGE_SIZE - 1)) >> shift;
 	vpn  = hpt_vpn(ea, vsid, ssize);
-	rpte = __real_pte(old_pte, ptep);
+	rpte = __real_pte(ea, old_pte, ptep);
 	/*
 	 *None of the sub 4k page is hashed
 	 */
diff --git a/arch/powerpc/mm/tlb_hash64.c b/arch/powerpc/mm/tlb_hash64.c
index c522969f012d..cc35ae0d02e6 100644
--- a/arch/powerpc/mm/tlb_hash64.c
+++ b/arch/powerpc/mm/tlb_hash64.c
@@ -89,7 +89,7 @@ void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
 	}
 	WARN_ON(vsid == 0);
 	vpn = hpt_vpn(addr, vsid, ssize);
-	rpte = __real_pte(__pte(pte), ptep);
+	rpte = __real_pte(addr, __pte(pte), ptep);
 
 	/*
 	 * Check if we have an active batch on this CPU. If not, just
-- 
2.5.0
