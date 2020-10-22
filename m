Return-Path: <SRS0=xaUg=D5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE95C4363A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Oct 2020 06:56:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A33072245F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Oct 2020 06:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A33072245F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CGynJ6f59zDr0m
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Oct 2020 17:56:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CGyBw0kP3zDqLR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2020 17:29:44 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4CGyBr1mFrz9vCxg;
 Thu, 22 Oct 2020 08:29:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id SW-tFubHQOup; Thu, 22 Oct 2020 08:29:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4CGyBr10WQz9vBKl;
 Thu, 22 Oct 2020 08:29:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 17EF38B806;
 Thu, 22 Oct 2020 08:29:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id WW8AyKCvhhi4; Thu, 22 Oct 2020 08:29:41 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D68E18B805;
 Thu, 22 Oct 2020 08:29:40 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id BAC8F667EF; Thu, 22 Oct 2020 06:29:40 +0000 (UTC)
Message-Id: <9af895be7d4b404d40e749a2659552fd138e62c4.1603348103.git.christophe.leroy@csgroup.eu>
In-Reply-To: <648e2448e938d52d0b5887445e018ca584edc06d.1603348103.git.christophe.leroy@csgroup.eu>
References: <648e2448e938d52d0b5887445e018ca584edc06d.1603348103.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 15/20] powerpc/32s: Inline flush_hash_entry()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 22 Oct 2020 06:29:40 +0000 (UTC)
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

flush_hash_entry() is a simple function calling
flush_hash_pages() if it's a hash MMU or doing nothing otherwise.

Inline it.

And use it also in __ptep_test_and_clear_young().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h | 17 +++++++++++------
 arch/powerpc/include/asm/tlb.h               |  3 ---
 arch/powerpc/mm/book3s32/tlb.c               | 14 --------------
 3 files changed, 11 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 36443cda8dcf..914c19959a84 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -238,8 +238,14 @@ extern void add_hash_page(unsigned context, unsigned long va,
 			  unsigned long pmdval);
 
 /* Flush an entry from the TLB/hash table */
-extern void flush_hash_entry(struct mm_struct *mm, pte_t *ptep,
-			     unsigned long address);
+static inline void flush_hash_entry(struct mm_struct *mm, pte_t *ptep, unsigned long addr)
+{
+	if (mmu_has_feature(MMU_FTR_HPTE_TABLE)) {
+		unsigned long ptephys = __pa(ptep) & PAGE_MASK;
+
+		flush_hash_pages(mm->context.id, addr, ptephys, 1);
+	}
+}
 
 /*
  * PTE updates. This function is called whenever an existing
@@ -291,10 +297,9 @@ static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
 {
 	unsigned long old;
 	old = pte_update(mm, addr, ptep, _PAGE_ACCESSED, 0, 0);
-	if (old & _PAGE_HASHPTE) {
-		unsigned long ptephys = __pa(ptep) & PAGE_MASK;
-		flush_hash_pages(mm->context.id, addr, ptephys, 1);
-	}
+	if (old & _PAGE_HASHPTE)
+		flush_hash_entry(mm, ptep, addr);
+
 	return (old & _PAGE_ACCESSED) != 0;
 }
 #define ptep_test_and_clear_young(__vma, __addr, __ptep) \
diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
index d97f061fecac..160422a439aa 100644
--- a/arch/powerpc/include/asm/tlb.h
+++ b/arch/powerpc/include/asm/tlb.h
@@ -40,9 +40,6 @@ extern void tlb_flush(struct mmu_gather *tlb);
 /* Get the generic bits... */
 #include <asm-generic/tlb.h>
 
-extern void flush_hash_entry(struct mm_struct *mm, pte_t *ptep,
-			     unsigned long address);
-
 static inline void __tlb_remove_tlb_entry(struct mmu_gather *tlb, pte_t *ptep,
 					  unsigned long address)
 {
diff --git a/arch/powerpc/mm/book3s32/tlb.c b/arch/powerpc/mm/book3s32/tlb.c
index e7865a3f0231..0d412953fe58 100644
--- a/arch/powerpc/mm/book3s32/tlb.c
+++ b/arch/powerpc/mm/book3s32/tlb.c
@@ -29,20 +29,6 @@
 
 #include <mm/mmu_decl.h>
 
-/*
- * Called when unmapping pages to flush entries from the TLB/hash table.
- */
-void flush_hash_entry(struct mm_struct *mm, pte_t *ptep, unsigned long addr)
-{
-	unsigned long ptephys;
-
-	if (mmu_has_feature(MMU_FTR_HPTE_TABLE)) {
-		ptephys = __pa(ptep) & PAGE_MASK;
-		flush_hash_pages(mm->context.id, addr, ptephys, 1);
-	}
-}
-EXPORT_SYMBOL(flush_hash_entry);
-
 /*
  * TLB flushing:
  *
-- 
2.25.0

