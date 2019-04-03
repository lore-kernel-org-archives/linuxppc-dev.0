Return-Path: <SRS0=3bX/=SF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D4AC4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 20:28:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 722BD206C0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 20:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="ECbzrYeK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 722BD206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ZHhk2FYYzDqD5
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 07:28:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="ECbzrYeK"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ZHCT1kSSzDqHh
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 07:06:29 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44ZHCP6VXmz9v3q0;
 Wed,  3 Apr 2019 22:06:25 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=ECbzrYeK; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id vaTjaJP2E-0K; Wed,  3 Apr 2019 22:06:25 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44ZHCP5QhGz9v3pp;
 Wed,  3 Apr 2019 22:06:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1554321985; bh=8ho2v9nDYOZx8aR7I3T7obQsL0sM3UzsRT35jMaFzi8=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=ECbzrYeKj0AbTJNMzdU1cYI0OxmJJ2Y0l5Qi9sVyTnZ4PJFdtVcF49lCY2slBP9YY
 k94kSPayuvYGnXIqOOq/PW0Ovn03GFTXsS0fXja0NxMDg6/wTcOWdownSQ9LVm8BSX
 4z1UwW96cW8103Vxh3Qv0RHq3c3MzYQhUVh5c/4I=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id DCAB08B905;
 Wed,  3 Apr 2019 22:06:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id jHR9nqXGxIFT; Wed,  3 Apr 2019 22:06:25 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id AE5388B902;
 Wed,  3 Apr 2019 22:06:25 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 8D98E655EC; Wed,  3 Apr 2019 20:06:25 +0000 (UTC)
Message-Id: <d7cfc093d5516600c1df5e1ae052db46af506353.1554321743.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1554321743.git.christophe.leroy@c-s.fr>
References: <cover.1554321743.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 13/15] powerpc/mm: refactor pgtable freeing functions on
 nohash
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 aneesh.kumar@linux.ibm.com
Date: Wed,  3 Apr 2019 20:06:25 +0000 (UTC)
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

pgtable_free() and others are identical on nohash/32 and 64,
so move them into asm/nohash/pgalloc.h

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/32/pgalloc.h | 43 ---------------------------
 arch/powerpc/include/asm/nohash/64/pgalloc.h | 43 ---------------------------
 arch/powerpc/include/asm/nohash/pgalloc.h    | 44 ++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 86 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pgalloc.h b/arch/powerpc/include/asm/nohash/32/pgalloc.h
index 7ee8e27070f4..6c0f5151dc1d 100644
--- a/arch/powerpc/include/asm/nohash/32/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/32/pgalloc.h
@@ -45,47 +45,4 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
 
 #define pmd_pgtable(pmd) ((pgtable_t)pmd_page_vaddr(pmd))
 
-static inline void pgtable_free(void *table, unsigned index_size)
-{
-	if (!index_size) {
-		pte_fragment_free((unsigned long *)table, 0);
-	} else {
-		BUG_ON(index_size > MAX_PGTABLE_INDEX_SIZE);
-		kmem_cache_free(PGT_CACHE(index_size), table);
-	}
-}
-
-#define get_hugepd_cache_index(x)	(x)
-
-#ifdef CONFIG_SMP
-static inline void pgtable_free_tlb(struct mmu_gather *tlb,
-				    void *table, int shift)
-{
-	unsigned long pgf = (unsigned long)table;
-	BUG_ON(shift > MAX_PGTABLE_INDEX_SIZE);
-	pgf |= shift;
-	tlb_remove_table(tlb, (void *)pgf);
-}
-
-static inline void __tlb_remove_table(void *_table)
-{
-	void *table = (void *)((unsigned long)_table & ~MAX_PGTABLE_INDEX_SIZE);
-	unsigned shift = (unsigned long)_table & MAX_PGTABLE_INDEX_SIZE;
-
-	pgtable_free(table, shift);
-}
-#else
-static inline void pgtable_free_tlb(struct mmu_gather *tlb,
-				    void *table, int shift)
-{
-	pgtable_free(table, shift);
-}
-#endif
-
-static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
-				  unsigned long address)
-{
-	tlb_flush_pgtable(tlb, address);
-	pgtable_free_tlb(tlb, table, 0);
-}
 #endif /* _ASM_POWERPC_PGALLOC_32_H */
diff --git a/arch/powerpc/include/asm/nohash/64/pgalloc.h b/arch/powerpc/include/asm/nohash/64/pgalloc.h
index ffc86d42816d..c636feced1ff 100644
--- a/arch/powerpc/include/asm/nohash/64/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/64/pgalloc.h
@@ -72,49 +72,6 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 	kmem_cache_free(PGT_CACHE(PMD_CACHE_INDEX), pmd);
 }
 
-static inline void pgtable_free(void *table, int shift)
-{
-	if (!shift) {
-		pte_fragment_free((unsigned long *)table, 0);
-	} else {
-		BUG_ON(shift > MAX_PGTABLE_INDEX_SIZE);
-		kmem_cache_free(PGT_CACHE(shift), table);
-	}
-}
-
-#define get_hugepd_cache_index(x)	(x)
-#ifdef CONFIG_SMP
-static inline void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift)
-{
-	unsigned long pgf = (unsigned long)table;
-
-	BUG_ON(shift > MAX_PGTABLE_INDEX_SIZE);
-	pgf |= shift;
-	tlb_remove_table(tlb, (void *)pgf);
-}
-
-static inline void __tlb_remove_table(void *_table)
-{
-	void *table = (void *)((unsigned long)_table & ~MAX_PGTABLE_INDEX_SIZE);
-	unsigned shift = (unsigned long)_table & MAX_PGTABLE_INDEX_SIZE;
-
-	pgtable_free(table, shift);
-}
-
-#else
-static inline void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift)
-{
-	pgtable_free(table, shift);
-}
-#endif
-
-static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
-				  unsigned long address)
-{
-	tlb_flush_pgtable(tlb, address);
-	pgtable_free_tlb(tlb, table, 0);
-}
-
 #define __pmd_free_tlb(tlb, pmd, addr)		      \
 	pgtable_free_tlb(tlb, pmd, PMD_CACHE_INDEX)
 #define __pud_free_tlb(tlb, pud, addr)		      \
diff --git a/arch/powerpc/include/asm/nohash/pgalloc.h b/arch/powerpc/include/asm/nohash/pgalloc.h
index 0634f2949438..4fccac6af3ad 100644
--- a/arch/powerpc/include/asm/nohash/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/pgalloc.h
@@ -21,4 +21,48 @@ static inline void tlb_flush_pgtable(struct mmu_gather *tlb,
 #else
 #include <asm/nohash/32/pgalloc.h>
 #endif
+
+static inline void pgtable_free(void *table, int shift)
+{
+	if (!shift) {
+		pte_fragment_free((unsigned long *)table, 0);
+	} else {
+		BUG_ON(shift > MAX_PGTABLE_INDEX_SIZE);
+		kmem_cache_free(PGT_CACHE(shift), table);
+	}
+}
+
+#define get_hugepd_cache_index(x)	(x)
+
+#ifdef CONFIG_SMP
+static inline void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift)
+{
+	unsigned long pgf = (unsigned long)table;
+
+	BUG_ON(shift > MAX_PGTABLE_INDEX_SIZE);
+	pgf |= shift;
+	tlb_remove_table(tlb, (void *)pgf);
+}
+
+static inline void __tlb_remove_table(void *_table)
+{
+	void *table = (void *)((unsigned long)_table & ~MAX_PGTABLE_INDEX_SIZE);
+	unsigned shift = (unsigned long)_table & MAX_PGTABLE_INDEX_SIZE;
+
+	pgtable_free(table, shift);
+}
+
+#else
+static inline void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift)
+{
+	pgtable_free(table, shift);
+}
+#endif
+
+static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
+				  unsigned long address)
+{
+	tlb_flush_pgtable(tlb, address);
+	pgtable_free_tlb(tlb, table, 0);
+}
 #endif /* _ASM_POWERPC_NOHASH_PGALLOC_H */
-- 
2.13.3

