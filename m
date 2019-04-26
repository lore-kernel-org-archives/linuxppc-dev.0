Return-Path: <SRS0=ImKy=S4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3B6C4321A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 16:00:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4C942077B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 16:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="UgSwlMG1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4C942077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44rJfv05JFzDqQV
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 02:00:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="UgSwlMG1"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44rJcF1jPDzDqRq
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Apr 2019 01:58:04 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44rJc81jgkz9v0yR;
 Fri, 26 Apr 2019 17:58:00 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=UgSwlMG1; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id y2BSecOSzp5Z; Fri, 26 Apr 2019 17:58:00 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44rJc80g3Qz9v0yM;
 Fri, 26 Apr 2019 17:58:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1556294280; bh=NzkgjIlmzqfsKNHCSyxuFQ9nYYJ76OP1jL8czDGc7rE=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=UgSwlMG19xM3PTPfEtHHdkf2njOWIFF7Xs2ed7CiuRtwrM9RHWGMma1yGqeT/Qe6z
 PDyhEldOrlTBoCsXibdrPWh+b5hH+S7UR6RLiSa9jQZfj810SOIRj0tqRCIGVBIocE
 eTskfnEU+MfppM7Y+8d0xEjQHrPWKjZSmkt5eDi4=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B47D68B94A;
 Fri, 26 Apr 2019 17:58:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id DLMC3WhRyDsS; Fri, 26 Apr 2019 17:58:01 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.6])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8F72C8B82F;
 Fri, 26 Apr 2019 17:58:01 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 8170A666FE; Fri, 26 Apr 2019 15:58:01 +0000 (UTC)
Message-Id: <c440b242da6de3823c4ef51f35f38405bbd51430.1556293738.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1556293738.git.christophe.leroy@c-s.fr>
References: <cover.1556293738.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 03/15] powerpc/mm: convert Book3E 64 to pte_fragment
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 aneesh.kumar@linux.ibm.com
Date: Fri, 26 Apr 2019 15:58:01 +0000 (UTC)
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

Book3E 64 is the only subarch not using pte_fragment. In order
to allow refactorisation, this patch converts it to pte_fragment.

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/mmu_context.h       |  6 -----
 arch/powerpc/include/asm/nohash/64/mmu.h     |  4 +++-
 arch/powerpc/include/asm/nohash/64/pgalloc.h | 33 ++++++++++------------------
 arch/powerpc/mm/Makefile                     |  4 ++--
 arch/powerpc/mm/mmu_context.c                |  2 +-
 5 files changed, 18 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 6ee8195a2ffb..66a3805dc935 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -228,13 +228,7 @@ static inline void enter_lazy_tlb(struct mm_struct *mm,
 #endif
 }
 
-#ifdef CONFIG_PPC_BOOK3E_64
-static inline void arch_exit_mmap(struct mm_struct *mm)
-{
-}
-#else
 extern void arch_exit_mmap(struct mm_struct *mm);
-#endif
 
 static inline void arch_unmap(struct mm_struct *mm,
 			      struct vm_area_struct *vma,
diff --git a/arch/powerpc/include/asm/nohash/64/mmu.h b/arch/powerpc/include/asm/nohash/64/mmu.h
index 81cf30c370e5..26e05ce8f5aa 100644
--- a/arch/powerpc/include/asm/nohash/64/mmu.h
+++ b/arch/powerpc/include/asm/nohash/64/mmu.h
@@ -4,11 +4,13 @@
 
 #define MAX_PHYSMEM_BITS        44
 
+#include <asm/page.h>
+
 /* Freescale Book-E software loaded TLB or Book-3e (ISA 2.06+) MMU */
 #include <asm/nohash/mmu-book3e.h>
 
 #ifndef __ASSEMBLY__
-typedef struct page *pgtable_t;
+typedef pte_t *pgtable_t;
 #endif
 
 #endif /* _ASM_POWERPC_NOHASH_64_MMU_H_ */
diff --git a/arch/powerpc/include/asm/nohash/64/pgalloc.h b/arch/powerpc/include/asm/nohash/64/pgalloc.h
index ded453f9b5a8..7fb87235f845 100644
--- a/arch/powerpc/include/asm/nohash/64/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/64/pgalloc.h
@@ -76,10 +76,10 @@ static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 				pgtable_t pte_page)
 {
-	pmd_set(pmd, (unsigned long)page_address(pte_page));
+	pmd_set(pmd, (unsigned long)pte_page);
 }
 
-#define pmd_pgtable(pmd) pmd_page(pmd)
+#define pmd_pgtable(pmd) ((pgtable_t)pmd_page_vaddr(pmd))
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
@@ -92,44 +92,35 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 	kmem_cache_free(PGT_CACHE(PMD_CACHE_INDEX), pmd);
 }
 
+pte_t *pte_fragment_alloc(struct mm_struct *mm, int kernel);
 
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 {
-	return (pte_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
+	return (pte_t *)pte_fragment_alloc(mm, 1);
 }
 
 static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
 {
-	struct page *page;
-	pte_t *pte;
-
-	pte = (pte_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT);
-	if (!pte)
-		return NULL;
-	page = virt_to_page(pte);
-	if (!pgtable_page_ctor(page)) {
-		__free_page(page);
-		return NULL;
-	}
-	return page;
+	return (pgtable_t)pte_fragment_alloc(mm, 0);
 }
 
+void pte_frag_destroy(void *pte_frag);
+void pte_fragment_free(unsigned long *table, int kernel);
+
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
-	free_page((unsigned long)pte);
+	pte_fragment_free((unsigned long *)pte, 1);
 }
 
 static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
 {
-	pgtable_page_dtor(ptepage);
-	__free_page(ptepage);
+	pte_fragment_free((unsigned long *)ptepage, 0);
 }
 
 static inline void pgtable_free(void *table, int shift)
 {
 	if (!shift) {
-		pgtable_page_dtor(virt_to_page(table));
-		free_page((unsigned long)table);
+		pte_fragment_free((unsigned long *)table, 0);
 	} else {
 		BUG_ON(shift > MAX_PGTABLE_INDEX_SIZE);
 		kmem_cache_free(PGT_CACHE(shift), table);
@@ -166,7 +157,7 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 				  unsigned long address)
 {
 	tlb_flush_pgtable(tlb, address);
-	pgtable_free_tlb(tlb, page_address(table), 0);
+	pgtable_free_tlb(tlb, table, 0);
 }
 
 #define __pmd_free_tlb(tlb, pmd, addr)		      \
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index 3c1bd9fa23cd..138c772d58d1 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -9,6 +9,7 @@ CFLAGS_REMOVE_slb.o = $(CC_FLAGS_FTRACE)
 
 obj-y				:= fault.o mem.o pgtable.o mmap.o \
 				   init_$(BITS).o pgtable_$(BITS).o \
+				   pgtable-frag.o \
 				   init-common.o mmu_context.o drmem.o
 obj-$(CONFIG_PPC_MMU_NOHASH)	+= mmu_context_nohash.o tlb_nohash.o \
 				   tlb_nohash_low.o
@@ -17,8 +18,7 @@ hash64-$(CONFIG_PPC_NATIVE)	:= hash_native_64.o
 obj-$(CONFIG_PPC_BOOK3E_64)   += pgtable-book3e.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= pgtable-hash64.o hash_utils_64.o slb.o \
 				   $(hash64-y) mmu_context_book3s64.o \
-				   pgtable-book3s64.o pgtable-frag.o
-obj-$(CONFIG_PPC32)		+= pgtable-frag.o
+				   pgtable-book3s64.o
 obj-$(CONFIG_PPC_RADIX_MMU)	+= pgtable-radix.o tlb-radix.o
 obj-$(CONFIG_PPC_BOOK3S_32)	+= ppc_mmu_32.o hash_low_32.o mmu_context_hash32.o
 obj-$(CONFIG_PPC_BOOK3S)	+= tlb_hash$(BITS).o
diff --git a/arch/powerpc/mm/mmu_context.c b/arch/powerpc/mm/mmu_context.c
index bb52320b7369..6b049d82b98a 100644
--- a/arch/powerpc/mm/mmu_context.c
+++ b/arch/powerpc/mm/mmu_context.c
@@ -98,7 +98,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	switch_mmu_context(prev, next, tsk);
 }
 
-#ifdef CONFIG_PPC32
+#ifndef CONFIG_PPC_BOOK3S_64
 void arch_exit_mmap(struct mm_struct *mm)
 {
 	void *frag = pte_frag_get(&mm->context);
-- 
2.13.3

