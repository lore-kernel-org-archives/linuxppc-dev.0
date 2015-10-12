Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0C1C21A07F0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 05:40:35 +1100 (AEDT)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 13 Oct 2015 00:10:34 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id CD24FE005C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 00:10:26 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9CIeUrX7602606
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 00:10:30 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9CIeUxr013654
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 00:10:30 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v3 20/31] powerpc/mm: update __real_pte to take address as
 argument
Date: Tue, 13 Oct 2015 00:10:04 +0530
Message-Id: <1444675215-19484-21-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1444675215-19484-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1444675215-19484-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
index c24e03f22655..f389f2d6789e 100644
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
index da133f2a51a7..456aa3bfa8f1 100644
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
index f7b80391bee7..dd0fd1783bcc 100644
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
