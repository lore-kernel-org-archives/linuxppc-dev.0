Return-Path: <SRS0=ImKy=S4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B607DC43218
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 16:21:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 349FC2084F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 16:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="tByPRNgj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 349FC2084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44rK7m1CdFzDqbc
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 02:21:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="tByPRNgj"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44rJcS206XzDqWc
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Apr 2019 01:58:16 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44rJcM4TYXz9v0yW;
 Fri, 26 Apr 2019 17:58:11 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=tByPRNgj; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id TIfFUh2P_ucg; Fri, 26 Apr 2019 17:58:11 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44rJcM3SHBz9v0yN;
 Fri, 26 Apr 2019 17:58:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1556294291; bh=BJUjxAqmwyqsLsgBqpREoOxE2zbWQiZBaalNK2aCg7Y=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=tByPRNgjCj9GsJ80zNL8LgLSTknBCnUOq/J2rCyAFDLRU1DnT7LuN9binLjtu3zeg
 HWe0FpwnHMpoVFn33f2OVPR6vjTK3th6K50/7PApWbf2EXKSRl2FZud+AW5Xm6609S
 wSPGnlkuz+oJOI1MaO6BDDkdpWQMVBHSd6Z1SV0Q=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 199E48B94A;
 Fri, 26 Apr 2019 17:58:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id b2oxUYkhPIzs; Fri, 26 Apr 2019 17:58:13 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.6])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id EC1988B82F;
 Fri, 26 Apr 2019 17:58:12 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id CA267666FE; Fri, 26 Apr 2019 15:58:12 +0000 (UTC)
Message-Id: <06d26906786aaa50cefa6ba11a4176799d433fd5.1556293738.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1556293738.git.christophe.leroy@c-s.fr>
References: <cover.1556293738.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 14/15] powerpc/mm: refactor pmd_pgtable()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 aneesh.kumar@linux.ibm.com
Date: Fri, 26 Apr 2019 15:58:12 +0000 (UTC)
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

pmd_pgtable() is identical on the 4 subarches, refactor it.

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/pgalloc.h | 2 --
 arch/powerpc/include/asm/book3s/64/pgalloc.h | 5 -----
 arch/powerpc/include/asm/nohash/32/pgalloc.h | 2 --
 arch/powerpc/include/asm/nohash/64/pgalloc.h | 2 --
 arch/powerpc/include/asm/pgalloc.h           | 5 +++++
 5 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgalloc.h b/arch/powerpc/include/asm/book3s/32/pgalloc.h
index 1b9b5c228230..998317702630 100644
--- a/arch/powerpc/include/asm/book3s/32/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/32/pgalloc.h
@@ -37,8 +37,6 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
 	*pmdp = __pmd(__pa(pte_page) | _PMD_PRESENT);
 }
 
-#define pmd_pgtable(pmd) ((pgtable_t)pmd_page_vaddr(pmd))
-
 static inline void pgtable_free(void *table, unsigned index_size)
 {
 	if (!index_size) {
diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
index df2dce6afe14..053a7940504e 100644
--- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -163,11 +163,6 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 	*pmd = __pmd(__pgtable_ptr_val(pte_page) | PMD_VAL_BITS);
 }
 
-static inline pgtable_t pmd_pgtable(pmd_t pmd)
-{
-	return (pgtable_t)pmd_page_vaddr(pmd);
-}
-
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 				  unsigned long address)
 {
diff --git a/arch/powerpc/include/asm/nohash/32/pgalloc.h b/arch/powerpc/include/asm/nohash/32/pgalloc.h
index 6c0f5151dc1d..137761b01588 100644
--- a/arch/powerpc/include/asm/nohash/32/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/32/pgalloc.h
@@ -43,6 +43,4 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
 		*pmdp = __pmd(__pa(pte_page) | _PMD_USER | _PMD_PRESENT);
 }
 
-#define pmd_pgtable(pmd) ((pgtable_t)pmd_page_vaddr(pmd))
-
 #endif /* _ASM_POWERPC_PGALLOC_32_H */
diff --git a/arch/powerpc/include/asm/nohash/64/pgalloc.h b/arch/powerpc/include/asm/nohash/64/pgalloc.h
index c636feced1ff..5a0ea63c77c7 100644
--- a/arch/powerpc/include/asm/nohash/64/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/64/pgalloc.h
@@ -59,8 +59,6 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 	pmd_set(pmd, (unsigned long)pte_page);
 }
 
-#define pmd_pgtable(pmd) ((pgtable_t)pmd_page_vaddr(pmd))
-
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
 	return kmem_cache_alloc(PGT_CACHE(PMD_CACHE_INDEX),
diff --git a/arch/powerpc/include/asm/pgalloc.h b/arch/powerpc/include/asm/pgalloc.h
index 5761bee0f004..2b2c60a1a66d 100644
--- a/arch/powerpc/include/asm/pgalloc.h
+++ b/arch/powerpc/include/asm/pgalloc.h
@@ -72,4 +72,9 @@ static inline void check_pgt_cache(void) { }
 #include <asm/nohash/pgalloc.h>
 #endif
 
+static inline pgtable_t pmd_pgtable(pmd_t pmd)
+{
+	return (pgtable_t)pmd_page_vaddr(pmd);
+}
+
 #endif /* _ASM_POWERPC_PGALLOC_H */
-- 
2.13.3

