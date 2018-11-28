Return-Path: <SRS0=VBhC=OH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9BCC43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 11:52:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 538B0223DD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 11:52:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 538B0223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 434fCy3KvRzDqKk
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 22:52:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 434f4h0yg5zDqWQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 22:46:27 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 434f4Z6bPSz9v09x;
 Wed, 28 Nov 2018 12:46:22 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id qytso1yXT5Fz; Wed, 28 Nov 2018 12:46:22 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 434f4Z63Gdz9v09s;
 Wed, 28 Nov 2018 12:46:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D59B98B867;
 Wed, 28 Nov 2018 12:46:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id P2FbcyZJcUXe; Wed, 28 Nov 2018 12:46:23 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B14EC8B853;
 Wed, 28 Nov 2018 12:46:23 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id A8C1469B1B; Wed, 28 Nov 2018 11:46:23 +0000 (UTC)
Message-Id: <a5fe47f2e78d16a007ff24aa9f6b541c7515536c.1543405086.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1543405086.git.christophe.leroy@c-s.fr>
References: <cover.1543405086.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v7 01/16] powerpc/book3s32: Remove CONFIG_BOOKE dependent code
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 28 Nov 2018 11:46:23 +0000 (UTC)
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

BOOK3S/32 cannot be BOOKE, so remove useless code

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/pgalloc.h | 18 ------------------
 arch/powerpc/include/asm/book3s/32/pgtable.h | 14 --------------
 2 files changed, 32 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgalloc.h b/arch/powerpc/include/asm/book3s/32/pgalloc.h
index 96138ab3ddd6..a70f3cf16dc8 100644
--- a/arch/powerpc/include/asm/book3s/32/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/32/pgalloc.h
@@ -47,8 +47,6 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 #define __pmd_free_tlb(tlb,x,a)		do { } while (0)
 /* #define pgd_populate(mm, pmd, pte)      BUG() */
 
-#ifndef CONFIG_BOOKE
-
 static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp,
 				       pte_t *pte)
 {
@@ -62,22 +60,6 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
 }
 
 #define pmd_pgtable(pmd) pmd_page(pmd)
-#else
-
-static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp,
-				       pte_t *pte)
-{
-	*pmdp = __pmd((unsigned long)pte | _PMD_PRESENT);
-}
-
-static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
-				pgtable_t pte_page)
-{
-	*pmdp = __pmd((unsigned long)lowmem_page_address(pte_page) | _PMD_PRESENT);
-}
-
-#define pmd_pgtable(pmd) pmd_page(pmd)
-#endif
 
 extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr);
 extern pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long addr);
diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index c21d33704633..32c33eccc0e2 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -328,24 +328,10 @@ static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
 #define __HAVE_ARCH_PTE_SAME
 #define pte_same(A,B)	(((pte_val(A) ^ pte_val(B)) & ~_PAGE_HASHPTE) == 0)
 
-/*
- * Note that on Book E processors, the pmd contains the kernel virtual
- * (lowmem) address of the pte page.  The physical address is less useful
- * because everything runs with translation enabled (even the TLB miss
- * handler).  On everything else the pmd contains the physical address
- * of the pte page.  -- paulus
- */
-#ifndef CONFIG_BOOKE
 #define pmd_page_vaddr(pmd)	\
 	((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
 #define pmd_page(pmd)		\
 	pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT)
-#else
-#define pmd_page_vaddr(pmd)	\
-	((unsigned long) (pmd_val(pmd) & PAGE_MASK))
-#define pmd_page(pmd)		\
-	pfn_to_page((__pa(pmd_val(pmd)) >> PAGE_SHIFT))
-#endif
 
 /* to find an entry in a kernel page-table-directory */
 #define pgd_offset_k(address) pgd_offset(&init_mm, address)
-- 
2.13.3

