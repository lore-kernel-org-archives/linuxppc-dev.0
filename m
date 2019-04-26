Return-Path: <SRS0=ImKy=S4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E30C43219
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 16:15:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4177320B7C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 16:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Z4X1gF8t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4177320B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44rK0k4S4hzDqD7
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 02:15:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="Z4X1gF8t"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44rJcN1D73zDqQV
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Apr 2019 01:58:12 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44rJcH3NLJz9v0yP;
 Fri, 26 Apr 2019 17:58:07 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=Z4X1gF8t; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id nmsGD7NRdQxW; Fri, 26 Apr 2019 17:58:07 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44rJcH2MSNz9v0yN;
 Fri, 26 Apr 2019 17:58:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1556294287; bh=rPd1KhX8+UIoTL1m9RzG5ss8I9hT3dLgysZOEHzsous=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=Z4X1gF8trfqC8nicV60pyvKu1o5wBENwRcbM/IivXkbstuazlXuHNvVARw+hyUnj2
 FZkLPeW2+Q+Ikw+2itqFg0yroGrbIzELwl3NqLR1iAtoc8dGMTL6RgnSR2Iu3PQwFo
 EG76GMwCNLJTIEY+il58A3PugsZgIsYDnjtJ0fKo=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id F03718B94A;
 Fri, 26 Apr 2019 17:58:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id c_cCf6c8JTbf; Fri, 26 Apr 2019 17:58:08 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.6])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id CB9938B82F;
 Fri, 26 Apr 2019 17:58:08 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id AEB4B666FE; Fri, 26 Apr 2019 15:58:08 +0000 (UTC)
Message-Id: <f3b41febfb7f6ad46413013a28b89342f1b9d02a.1556293738.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1556293738.git.christophe.leroy@c-s.fr>
References: <cover.1556293738.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 10/15] powerpc/mm: refactor pte_alloc_one() and pte_free()
 families definition.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 aneesh.kumar@linux.ibm.com
Date: Fri, 26 Apr 2019 15:58:08 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Functions pte_alloc_one(), pte_alloc_one_kernel(), pte_free(),
pte_free_kernel() are identical for the four subarches.

This patch moves their definition in a common place.

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/pgalloc.h | 25 -------------------------
 arch/powerpc/include/asm/book3s/64/pgalloc.h | 22 ----------------------
 arch/powerpc/include/asm/nohash/32/pgalloc.h | 25 -------------------------
 arch/powerpc/include/asm/nohash/64/pgalloc.h | 25 -------------------------
 arch/powerpc/include/asm/pgalloc.h           | 25 +++++++++++++++++++++++++
 5 files changed, 25 insertions(+), 97 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgalloc.h b/arch/powerpc/include/asm/book3s/32/pgalloc.h
index 0ed856068bb8..46422309d6e0 100644
--- a/arch/powerpc/include/asm/book3s/32/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/32/pgalloc.h
@@ -59,31 +59,6 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
 
 #define pmd_pgtable(pmd) ((pgtable_t)pmd_page_vaddr(pmd))
 
-pte_t *pte_fragment_alloc(struct mm_struct *mm, int kernel);
-
-static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
-{
-	return (pte_t *)pte_fragment_alloc(mm, 1);
-}
-
-static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
-{
-	return (pgtable_t)pte_fragment_alloc(mm, 0);
-}
-
-void pte_frag_destroy(void *pte_frag);
-void pte_fragment_free(unsigned long *table, int kernel);
-
-static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
-{
-	pte_fragment_free((unsigned long *)pte, 1);
-}
-
-static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
-{
-	pte_fragment_free((unsigned long *)ptepage, 0);
-}
-
 static inline void pgtable_free(void *table, unsigned index_size)
 {
 	if (!index_size) {
diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
index 138bc2ecc0c4..cfd48d8cc055 100644
--- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -39,9 +39,7 @@ extern struct vmemmap_backing *vmemmap_list;
 extern struct kmem_cache *pgtable_cache[];
 #define PGT_CACHE(shift) pgtable_cache[shift]
 
-extern pte_t *pte_fragment_alloc(struct mm_struct *, int);
 extern pmd_t *pmd_fragment_alloc(struct mm_struct *, unsigned long);
-extern void pte_fragment_free(unsigned long *, int);
 extern void pmd_fragment_free(unsigned long *);
 extern void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift);
 #ifdef CONFIG_SMP
@@ -190,26 +188,6 @@ static inline pgtable_t pmd_pgtable(pmd_t pmd)
 	return (pgtable_t)pmd_page_vaddr(pmd);
 }
 
-static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
-{
-	return (pte_t *)pte_fragment_alloc(mm, 1);
-}
-
-static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
-{
-	return (pgtable_t)pte_fragment_alloc(mm, 0);
-}
-
-static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
-{
-	pte_fragment_free((unsigned long *)pte, 1);
-}
-
-static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
-{
-	pte_fragment_free((unsigned long *)ptepage, 0);
-}
-
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 				  unsigned long address)
 {
diff --git a/arch/powerpc/include/asm/nohash/32/pgalloc.h b/arch/powerpc/include/asm/nohash/32/pgalloc.h
index 1d41508f0676..e96ef2fde2ca 100644
--- a/arch/powerpc/include/asm/nohash/32/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/32/pgalloc.h
@@ -77,31 +77,6 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
 #define pmd_pgtable(pmd) ((pgtable_t)pmd_page_vaddr(pmd))
 #endif
 
-pte_t *pte_fragment_alloc(struct mm_struct *mm, int kernel);
-
-static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
-{
-	return (pte_t *)pte_fragment_alloc(mm, 1);
-}
-
-static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
-{
-	return (pgtable_t)pte_fragment_alloc(mm, 0);
-}
-
-void pte_frag_destroy(void *pte_frag);
-void pte_fragment_free(unsigned long *table, int kernel);
-
-static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
-{
-	pte_fragment_free((unsigned long *)pte, 1);
-}
-
-static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
-{
-	pte_fragment_free((unsigned long *)ptepage, 0);
-}
-
 static inline void pgtable_free(void *table, unsigned index_size)
 {
 	if (!index_size) {
diff --git a/arch/powerpc/include/asm/nohash/64/pgalloc.h b/arch/powerpc/include/asm/nohash/64/pgalloc.h
index 7fb87235f845..98de4f3b0306 100644
--- a/arch/powerpc/include/asm/nohash/64/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/64/pgalloc.h
@@ -92,31 +92,6 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 	kmem_cache_free(PGT_CACHE(PMD_CACHE_INDEX), pmd);
 }
 
-pte_t *pte_fragment_alloc(struct mm_struct *mm, int kernel);
-
-static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
-{
-	return (pte_t *)pte_fragment_alloc(mm, 1);
-}
-
-static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
-{
-	return (pgtable_t)pte_fragment_alloc(mm, 0);
-}
-
-void pte_frag_destroy(void *pte_frag);
-void pte_fragment_free(unsigned long *table, int kernel);
-
-static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
-{
-	pte_fragment_free((unsigned long *)pte, 1);
-}
-
-static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
-{
-	pte_fragment_free((unsigned long *)ptepage, 0);
-}
-
 static inline void pgtable_free(void *table, int shift)
 {
 	if (!shift) {
diff --git a/arch/powerpc/include/asm/pgalloc.h b/arch/powerpc/include/asm/pgalloc.h
index e11f03007b57..c2c6fd438840 100644
--- a/arch/powerpc/include/asm/pgalloc.h
+++ b/arch/powerpc/include/asm/pgalloc.h
@@ -20,6 +20,31 @@ static inline gfp_t pgtable_gfp_flags(struct mm_struct *mm, gfp_t gfp)
 
 #define PGALLOC_GFP (GFP_KERNEL | __GFP_ZERO)
 
+pte_t *pte_fragment_alloc(struct mm_struct *mm, int kernel);
+
+static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
+{
+	return (pte_t *)pte_fragment_alloc(mm, 1);
+}
+
+static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
+{
+	return (pgtable_t)pte_fragment_alloc(mm, 0);
+}
+
+void pte_frag_destroy(void *pte_frag);
+void pte_fragment_free(unsigned long *table, int kernel);
+
+static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
+{
+	pte_fragment_free((unsigned long *)pte, 1);
+}
+
+static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
+{
+	pte_fragment_free((unsigned long *)ptepage, 0);
+}
+
 #ifdef CONFIG_PPC_BOOK3S
 #include <asm/book3s/pgalloc.h>
 #else
-- 
2.13.3

