Return-Path: <SRS0=ImKy=S4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241CCC43219
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 06:08:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 996A9206E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 06:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="oYk95YCV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 996A9206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44r3Wk4CKfzDqSP
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 16:08:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="oYk95YCV"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44r3Kq1yJrzDqSP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 15:59:43 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44r3Kl0PTXz9v1vC;
 Fri, 26 Apr 2019 07:59:39 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=oYk95YCV; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 0clHxgRsOcsU; Fri, 26 Apr 2019 07:59:38 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44r3Kk6SL2z9v1tj;
 Fri, 26 Apr 2019 07:59:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1556258378; bh=kASoNFoXQwhQvXag35yjm4SiZqKjgmULZHVp53xGhLI=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=oYk95YCVnFb9AV9/PQhUSuzdCRxfEc0A5C7+1hWqtuzR04a/uP+5m9f3Taz+qBj0F
 cfLK1hyDaf1pwAQL7jGjwiFGedeM5sg3DrokEd3eNZ7cQcS4VJ3C6oEOZQvJuYNLio
 d/6to4hiI5vPuWY/7dm7axiP4hGAGtRw/Rl2z/MM=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C6A548B807;
 Fri, 26 Apr 2019 07:59:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id i1FlX50W2Inf; Fri, 26 Apr 2019 07:59:39 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.6])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A40F98B74C;
 Fri, 26 Apr 2019 07:59:39 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 7701E66278; Fri, 26 Apr 2019 05:59:39 +0000 (UTC)
Message-Id: <e85a81d80cf30e195ccd55757f31f89e093e1864.1556258135.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1556258134.git.christophe.leroy@c-s.fr>
References: <cover.1556258134.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 04/17] powerpc/64: only book3s/64 supports
 CONFIG_PPC_64K_PAGES
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 aneesh.kumar@linux.ibm.com
Date: Fri, 26 Apr 2019 05:59:39 +0000 (UTC)
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

CONFIG_PPC_64K_PAGES cannot be selected by nohash/64.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig                         |  1 -
 arch/powerpc/include/asm/nohash/64/pgalloc.h |  3 ---
 arch/powerpc/include/asm/nohash/64/pgtable.h |  4 ----
 arch/powerpc/include/asm/nohash/pte-book3e.h |  5 -----
 arch/powerpc/include/asm/pgtable-be-types.h  |  9 ++------
 arch/powerpc/include/asm/pgtable-types.h     |  9 ++------
 arch/powerpc/include/asm/task_size_64.h      |  2 +-
 arch/powerpc/mm/tlb_low_64e.S                | 31 ----------------------------
 arch/powerpc/mm/tlb_nohash.c                 | 13 ------------
 9 files changed, 5 insertions(+), 72 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2d0be82c3061..5d8e692d6470 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -375,7 +375,6 @@ config ZONE_DMA
 config PGTABLE_LEVELS
 	int
 	default 2 if !PPC64
-	default 3 if PPC_64K_PAGES && !PPC_BOOK3S_64
 	default 4
 
 source "arch/powerpc/sysdev/Kconfig"
diff --git a/arch/powerpc/include/asm/nohash/64/pgalloc.h b/arch/powerpc/include/asm/nohash/64/pgalloc.h
index 66d086f85bd5..ded453f9b5a8 100644
--- a/arch/powerpc/include/asm/nohash/64/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/64/pgalloc.h
@@ -171,12 +171,9 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 
 #define __pmd_free_tlb(tlb, pmd, addr)		      \
 	pgtable_free_tlb(tlb, pmd, PMD_CACHE_INDEX)
-#ifndef CONFIG_PPC_64K_PAGES
 #define __pud_free_tlb(tlb, pud, addr)		      \
 	pgtable_free_tlb(tlb, pud, PUD_INDEX_SIZE)
 
-#endif /* CONFIG_PPC_64K_PAGES */
-
 #define check_pgt_cache()	do { } while (0)
 
 #endif /* _ASM_POWERPC_PGALLOC_64_H */
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index 0384a3302fb6..937a8476ec41 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -10,10 +10,6 @@
 #include <asm/barrier.h>
 #include <asm/asm-const.h>
 
-#ifdef CONFIG_PPC_64K_PAGES
-#error "Page size not supported"
-#endif
-
 #define FIRST_USER_ADDRESS	0UL
 
 /*
diff --git a/arch/powerpc/include/asm/nohash/pte-book3e.h b/arch/powerpc/include/asm/nohash/pte-book3e.h
index dd40d200f274..813918f40765 100644
--- a/arch/powerpc/include/asm/nohash/pte-book3e.h
+++ b/arch/powerpc/include/asm/nohash/pte-book3e.h
@@ -60,13 +60,8 @@
 #define _PAGE_SPECIAL	_PAGE_SW0
 
 /* Base page size */
-#ifdef CONFIG_PPC_64K_PAGES
-#define _PAGE_PSIZE	_PAGE_PSIZE_64K
-#define PTE_RPN_SHIFT	(28)
-#else
 #define _PAGE_PSIZE	_PAGE_PSIZE_4K
 #define	PTE_RPN_SHIFT	(24)
-#endif
 
 #define PTE_WIMGE_SHIFT (19)
 #define PTE_BAP_SHIFT	(2)
diff --git a/arch/powerpc/include/asm/pgtable-be-types.h b/arch/powerpc/include/asm/pgtable-be-types.h
index a89c67b62680..b169bbf95fcb 100644
--- a/arch/powerpc/include/asm/pgtable-be-types.h
+++ b/arch/powerpc/include/asm/pgtable-be-types.h
@@ -33,11 +33,7 @@ static inline __be64 pmd_raw(pmd_t x)
 	return x.pmd;
 }
 
-/*
- * 64 bit hash always use 4 level table. Everybody else use 4 level
- * only for 4K page size.
- */
-#if defined(CONFIG_PPC_BOOK3S_64) || !defined(CONFIG_PPC_64K_PAGES)
+/* 64 bit always use 4 level table. */
 typedef struct { __be64 pud; } pud_t;
 #define __pud(x)	((pud_t) { cpu_to_be64(x) })
 #define __pud_raw(x)	((pud_t) { (x) })
@@ -51,7 +47,6 @@ static inline __be64 pud_raw(pud_t x)
 	return x.pud;
 }
 
-#endif /* CONFIG_PPC_BOOK3S_64 || !CONFIG_PPC_64K_PAGES */
 #endif /* CONFIG_PPC64 */
 
 /* PGD level */
@@ -77,7 +72,7 @@ typedef struct { unsigned long pgprot; } pgprot_t;
  * With hash config 64k pages additionally define a bigger "real PTE" type that
  * gathers the "second half" part of the PTE for pseudo 64k pages
  */
-#if defined(CONFIG_PPC_64K_PAGES) && defined(CONFIG_PPC_BOOK3S_64)
+#ifdef CONFIG_PPC_64K_PAGES
 typedef struct { pte_t pte; unsigned long hidx; } real_pte_t;
 #else
 typedef struct { pte_t pte; } real_pte_t;
diff --git a/arch/powerpc/include/asm/pgtable-types.h b/arch/powerpc/include/asm/pgtable-types.h
index 3b0edf041b2e..d11b4c61d686 100644
--- a/arch/powerpc/include/asm/pgtable-types.h
+++ b/arch/powerpc/include/asm/pgtable-types.h
@@ -23,18 +23,13 @@ static inline unsigned long pmd_val(pmd_t x)
 	return x.pmd;
 }
 
-/*
- * 64 bit hash always use 4 level table. Everybody else use 4 level
- * only for 4K page size.
- */
-#if defined(CONFIG_PPC_BOOK3S_64) || !defined(CONFIG_PPC_64K_PAGES)
+/* 64 bit always use 4 level table. */
 typedef struct { unsigned long pud; } pud_t;
 #define __pud(x)	((pud_t) { (x) })
 static inline unsigned long pud_val(pud_t x)
 {
 	return x.pud;
 }
-#endif /* CONFIG_PPC_BOOK3S_64 || !CONFIG_PPC_64K_PAGES */
 #endif /* CONFIG_PPC64 */
 
 /* PGD level */
@@ -54,7 +49,7 @@ typedef struct { unsigned long pgprot; } pgprot_t;
  * With hash config 64k pages additionally define a bigger "real PTE" type that
  * gathers the "second half" part of the PTE for pseudo 64k pages
  */
-#if defined(CONFIG_PPC_64K_PAGES) && defined(CONFIG_PPC_BOOK3S_64)
+#ifdef CONFIG_PPC_64K_PAGES
 typedef struct { pte_t pte; unsigned long hidx; } real_pte_t;
 #else
 typedef struct { pte_t pte; } real_pte_t;
diff --git a/arch/powerpc/include/asm/task_size_64.h b/arch/powerpc/include/asm/task_size_64.h
index eab4779f6b84..c993482237ed 100644
--- a/arch/powerpc/include/asm/task_size_64.h
+++ b/arch/powerpc/include/asm/task_size_64.h
@@ -20,7 +20,7 @@
 /*
  * For now 512TB is only supported with book3s and 64K linux page size.
  */
-#if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_PPC_64K_PAGES)
+#ifdef CONFIG_PPC_64K_PAGES
 /*
  * Max value currently used:
  */
diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64e.S
index 9ed90064f542..58959ce15415 100644
--- a/arch/powerpc/mm/tlb_low_64e.S
+++ b/arch/powerpc/mm/tlb_low_64e.S
@@ -24,11 +24,7 @@
 #include <asm/kvm_booke_hv_asm.h>
 #include <asm/feature-fixups.h>
 
-#ifdef CONFIG_PPC_64K_PAGES
-#define VPTE_PMD_SHIFT	(PTE_INDEX_SIZE+1)
-#else
 #define VPTE_PMD_SHIFT	(PTE_INDEX_SIZE)
-#endif
 #define VPTE_PUD_SHIFT	(VPTE_PMD_SHIFT + PMD_INDEX_SIZE)
 #define VPTE_PGD_SHIFT	(VPTE_PUD_SHIFT + PUD_INDEX_SIZE)
 #define VPTE_INDEX_SIZE (VPTE_PGD_SHIFT + PGD_INDEX_SIZE)
@@ -167,13 +163,11 @@ MMU_FTR_SECTION_ELSE
 	ldx	r14,r14,r15		/* grab pgd entry */
 ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_USE_TLBRSRV)
 
-#ifndef CONFIG_PPC_64K_PAGES
 	rldicl	r15,r16,64-PUD_SHIFT+3,64-PUD_INDEX_SIZE-3
 	clrrdi	r15,r15,3
 	cmpdi	cr0,r14,0
 	bge	tlb_miss_fault_bolted	/* Bad pgd entry or hugepage; bail */
 	ldx	r14,r14,r15		/* grab pud entry */
-#endif /* CONFIG_PPC_64K_PAGES */
 
 	rldicl	r15,r16,64-PMD_SHIFT+3,64-PMD_INDEX_SIZE-3
 	clrrdi	r15,r15,3
@@ -682,18 +676,7 @@ normal_tlb_miss:
 	 * order to handle the weird page table format used by linux
 	 */
 	ori	r10,r15,0x1
-#ifdef CONFIG_PPC_64K_PAGES
-	/* For the top bits, 16 bytes per PTE */
-	rldicl	r14,r16,64-(PAGE_SHIFT-4),PAGE_SHIFT-4+4
-	/* Now create the bottom bits as 0 in position 0x8000 and
-	 * the rest calculated for 8 bytes per PTE
-	 */
-	rldicl	r15,r16,64-(PAGE_SHIFT-3),64-15
-	/* Insert the bottom bits in */
-	rlwimi	r14,r15,0,16,31
-#else
 	rldicl	r14,r16,64-(PAGE_SHIFT-3),PAGE_SHIFT-3+4
-#endif
 	sldi	r15,r10,60
 	clrrdi	r14,r14,3
 	or	r10,r15,r14
@@ -732,11 +715,7 @@ finish_normal_tlb_miss:
 
 	/* Check page size, if not standard, update MAS1 */
 	rldicl	r11,r14,64-8,64-8
-#ifdef CONFIG_PPC_64K_PAGES
-	cmpldi	cr0,r11,BOOK3E_PAGESZ_64K
-#else
 	cmpldi	cr0,r11,BOOK3E_PAGESZ_4K
-#endif
 	beq-	1f
 	mfspr	r11,SPRN_MAS1
 	rlwimi	r11,r14,31,21,24
@@ -857,14 +836,12 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_USE_TLBRSRV)
 	cmpdi	cr0,r15,0
 	bge	virt_page_table_tlb_miss_fault
 
-#ifndef CONFIG_PPC_64K_PAGES
 	/* Get to PUD entry */
 	rldicl	r11,r16,64-VPTE_PUD_SHIFT,64-PUD_INDEX_SIZE-3
 	clrrdi	r10,r11,3
 	ldx	r15,r10,r15
 	cmpdi	cr0,r15,0
 	bge	virt_page_table_tlb_miss_fault
-#endif /* CONFIG_PPC_64K_PAGES */
 
 	/* Get to PMD entry */
 	rldicl	r11,r16,64-VPTE_PMD_SHIFT,64-PMD_INDEX_SIZE-3
@@ -1106,14 +1083,12 @@ htw_tlb_miss:
 	cmpdi	cr0,r15,0
 	bge	htw_tlb_miss_fault
 
-#ifndef CONFIG_PPC_64K_PAGES
 	/* Get to PUD entry */
 	rldicl	r11,r16,64-(PUD_SHIFT-3),64-PUD_INDEX_SIZE-3
 	clrrdi	r10,r11,3
 	ldx	r15,r10,r15
 	cmpdi	cr0,r15,0
 	bge	htw_tlb_miss_fault
-#endif /* CONFIG_PPC_64K_PAGES */
 
 	/* Get to PMD entry */
 	rldicl	r11,r16,64-(PMD_SHIFT-3),64-PMD_INDEX_SIZE-3
@@ -1132,9 +1107,7 @@ htw_tlb_miss:
 	 * 4K page we need to extract a bit from the virtual address and
 	 * insert it into the "PA52" bit of the RPN.
 	 */
-#ifndef CONFIG_PPC_64K_PAGES
 	rlwimi	r15,r16,32-9,20,20
-#endif
 	/* Now we build the MAS:
 	 *
 	 * MAS 0   :	Fully setup with defaults in MAS4 and TLBnCFG
@@ -1144,11 +1117,7 @@ htw_tlb_miss:
 	 * MAS 2   :	Use defaults
 	 * MAS 3+7 :	Needs to be done
 	 */
-#ifdef CONFIG_PPC_64K_PAGES
-	ori	r10,r15,(BOOK3E_PAGESZ_64K << MAS3_SPSIZE_SHIFT)
-#else
 	ori	r10,r15,(BOOK3E_PAGESZ_4K << MAS3_SPSIZE_SHIFT)
-#endif
 
 BEGIN_MMU_FTR_SECTION
 	srdi	r16,r10,32
diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index 088e0a6b5ade..1514d5e2a73b 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -433,11 +433,7 @@ void tlb_flush_pgtable(struct mmu_gather *tlb, unsigned long address)
 		unsigned long rid = (address & rmask) | 0x1000000000000000ul;
 		unsigned long vpte = address & ~rmask;
 
-#ifdef CONFIG_PPC_64K_PAGES
-		vpte = (vpte >> (PAGE_SHIFT - 4)) & ~0xfffful;
-#else
 		vpte = (vpte >> (PAGE_SHIFT - 3)) & ~0xffful;
-#endif
 		vpte |= rid;
 		__flush_tlb_page(tlb->mm, vpte, tsize, 0);
 	}
@@ -625,21 +621,12 @@ static void early_init_this_mmu(void)
 
 	case PPC_HTW_IBM:
 		mas4 |= MAS4_INDD;
-#ifdef CONFIG_PPC_64K_PAGES
-		mas4 |=	BOOK3E_PAGESZ_256M << MAS4_TSIZED_SHIFT;
-		mmu_pte_psize = MMU_PAGE_256M;
-#else
 		mas4 |=	BOOK3E_PAGESZ_1M << MAS4_TSIZED_SHIFT;
 		mmu_pte_psize = MMU_PAGE_1M;
-#endif
 		break;
 
 	case PPC_HTW_NONE:
-#ifdef CONFIG_PPC_64K_PAGES
-		mas4 |=	BOOK3E_PAGESZ_64K << MAS4_TSIZED_SHIFT;
-#else
 		mas4 |=	BOOK3E_PAGESZ_4K << MAS4_TSIZED_SHIFT;
-#endif
 		mmu_pte_psize = mmu_virtual_psize;
 		break;
 	}
-- 
2.13.3

