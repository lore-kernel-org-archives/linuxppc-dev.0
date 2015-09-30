Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 436291A002B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 12:29:18 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 30 Sep 2015 12:29:17 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 733432CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 12:29:15 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8U2T3q234996312
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 12:29:11 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8U2Sg2d008770
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 12:28:43 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 20/31] powerpc/mm: update __real_pte to take address as
 argument
Date: Wed, 30 Sep 2015 07:57:13 +0530
Message-Id: <1443580044-30659-21-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1443580044-30659-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1443580044-30659-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/nohash/64/pgtable.h  | 4 ++--
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
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index c33aa32ffba5..6c35bd434f80 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
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
index b137e50a3e57..87cba0688fce 100644
--- a/arch/powerpc/mm/hash64_64k.c
+++ b/arch/powerpc/mm/hash64_64k.c
@@ -90,7 +90,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 
 	subpg_index = (ea & (PAGE_SIZE - 1)) >> shift;
 	vpn  = hpt_vpn(ea, vsid, ssize);
-	rpte = __real_pte(__pte(old_pte), ptep);
+	rpte = __real_pte(ea, __pte(old_pte), ptep);
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
