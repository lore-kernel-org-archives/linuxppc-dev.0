Return-Path: <SRS0=oOud=KJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A106C433B4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 May 2021 11:09:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFD726127A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 May 2021 11:09:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD726127A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FhQlX0nMJz302K
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 May 2021 21:09:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FhQl42ZgKz2ykF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 May 2021 21:09:00 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4FhQkt4qvLz9sbS;
 Fri, 14 May 2021 13:08:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wy2Elb8z9V1b; Fri, 14 May 2021 13:08:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4FhQkt3mpCz9sZb;
 Fri, 14 May 2021 13:08:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 64BFC8B7F8;
 Fri, 14 May 2021 13:08:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id lWsu5EXndett; Fri, 14 May 2021 13:08:54 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 28EEF8B7F6;
 Fri, 14 May 2021 13:08:54 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id F3FB464956; Fri, 14 May 2021 11:08:53 +0000 (UTC)
Message-Id: <73ec95f40cafbbb69bdfb43a7f53876fd845b0ce.1620990479.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] arm64: Define only {pud/pmd}_{set/clear}_huge when usefull
To: Andrew Morton <akpm@linux-foundation.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Mike Kravetz <mike.kravetz@oracle.com>, Mike Rapoport <rppt@kernel.org>,
 naresh.kamboju@linaro.org
Date: Fri, 14 May 2021 11:08:53 +0000 (UTC)
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
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When PUD and/or PMD are folded, those functions are useless
and we now have a stub in linux/pgtable.h

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/arm64/mm/mmu.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 6dd9369e3ea0..98af085afe90 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1337,6 +1337,7 @@ void *__init fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
 	return dt_virt;
 }
 
+#if CONFIG_PGTABLE_LEVELS > 3
 int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
 {
 	pud_t new_pud = pfn_pud(__phys_to_pfn(phys), mk_pud_sect_prot(prot));
@@ -1351,6 +1352,16 @@ int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
 	return 1;
 }
 
+int pud_clear_huge(pud_t *pudp)
+{
+	if (!pud_sect(READ_ONCE(*pudp)))
+		return 0;
+	pud_clear(pudp);
+	return 1;
+}
+#endif
+
+#if CONFIG_PGTABLE_LEVELS > 2
 int pmd_set_huge(pmd_t *pmdp, phys_addr_t phys, pgprot_t prot)
 {
 	pmd_t new_pmd = pfn_pmd(__phys_to_pfn(phys), mk_pmd_sect_prot(prot));
@@ -1365,14 +1376,6 @@ int pmd_set_huge(pmd_t *pmdp, phys_addr_t phys, pgprot_t prot)
 	return 1;
 }
 
-int pud_clear_huge(pud_t *pudp)
-{
-	if (!pud_sect(READ_ONCE(*pudp)))
-		return 0;
-	pud_clear(pudp);
-	return 1;
-}
-
 int pmd_clear_huge(pmd_t *pmdp)
 {
 	if (!pmd_sect(READ_ONCE(*pmdp)))
@@ -1380,6 +1383,7 @@ int pmd_clear_huge(pmd_t *pmdp)
 	pmd_clear(pmdp);
 	return 1;
 }
+#endif
 
 int pmd_free_pte_page(pmd_t *pmdp, unsigned long addr)
 {
-- 
2.25.0

