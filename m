Return-Path: <SRS0=BLVf=OI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D91FC43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 15:12:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E019E20868
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 15:12:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E019E20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 435Lbt6HQSzDqxj
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Nov 2018 02:12:26 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 435K8s6QtczDrDX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Nov 2018 01:07:25 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 435K8n4J6Lz9vGF8;
 Thu, 29 Nov 2018 15:07:21 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id kOLPCewdYA80; Thu, 29 Nov 2018 15:07:21 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 435K8n3nLlz9vGDx;
 Thu, 29 Nov 2018 15:07:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A4F078B8A0;
 Thu, 29 Nov 2018 15:07:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id B0LoQBHjsgd4; Thu, 29 Nov 2018 15:07:22 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 5D3BF8B899;
 Thu, 29 Nov 2018 15:07:22 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id F2CF569AE8; Thu, 29 Nov 2018 14:07:21 +0000 (UTC)
Message-Id: <c4c843b16167e5fc0f7346a721a31232f47a79cd.1543499865.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1543499860.git.christophe.leroy@c-s.fr>
References: <cover.1543499860.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v9 18/20] powerpc/8xx: reintroduce 16K pages with HW assistance
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 29 Nov 2018 14:07:21 +0000 (UTC)
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

Using this HW assistance implies some constraints on the
page table structure:
- Regardless of the main page size used (4k or 16k), the
level 1 table (PGD) contains 1024 entries and each PGD entry covers
a 4Mbytes area which is managed by a level 2 table (PTE) containing
also 1024 entries each describing a 4k page.
- 16k pages require 4 identifical entries in the L2 table
- 512k pages PTE have to be spread every 128 bytes in the L2 table
- 8M pages PTE are at the address pointed by the L1 entry and each
8M page require 2 identical entries in the PGD.

In order to use hardware assistance with 16K pages, this patch does
the following modifications:
- Make PGD size independent of the main page size
- In 16k pages mode, redefine pte_t as a struct with 4 elements,
and populate those 4 elements in __set_pte_at() and pte_update()
- Adapt the size of the hugepage tables.
- Define a PTE_FRAGMENT_NB so that a 16k page contains 4 page tables.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig                         | 2 +-
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h | 4 ++++
 arch/powerpc/include/asm/nohash/32/pgtable.h | 8 +++++++-
 arch/powerpc/include/asm/nohash/pgtable.h    | 4 ++++
 arch/powerpc/include/asm/page_32.h           | 3 ++-
 arch/powerpc/include/asm/pgtable-types.h     | 4 ++++
 6 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index ddfccdf004fe..8be31261aec8 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -689,7 +689,7 @@ config PPC_4K_PAGES
 
 config PPC_16K_PAGES
 	bool "16k page size"
-	depends on 44x
+	depends on 44x || PPC_8xx
 
 config PPC_64K_PAGES
 	bool "64k page size"
diff --git a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
index fa05aa566ece..b0f764c827c0 100644
--- a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
@@ -190,6 +190,7 @@ typedef struct {
 	struct slice_mask mask_8m;
 # endif
 #endif
+	void *pte_frag;
 } mm_context_t;
 
 #define PHYS_IMMR_BASE (mfspr(SPRN_IMMR) & 0xfff80000)
@@ -244,6 +245,9 @@ extern s32 patch__itlbmiss_perf, patch__dtlbmiss_perf;
 #define mmu_virtual_psize	MMU_PAGE_4K
 #elif defined(CONFIG_PPC_16K_PAGES)
 #define mmu_virtual_psize	MMU_PAGE_16K
+#define PTE_FRAG_NR		4
+#define PTE_FRAG_SIZE_SHIFT	12
+#define PTE_FRAG_SIZE		(1UL << 12)
 #else
 #error "Unsupported PAGE_SIZE"
 #endif
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index e9c8604cc8c5..bed433358260 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -232,7 +232,13 @@ static inline unsigned long pte_update(pte_t *p,
 	: "cc" );
 #else /* PTE_ATOMIC_UPDATES */
 	unsigned long old = pte_val(*p);
-	*p = __pte((old & ~clr) | set);
+	unsigned long new = (old & ~clr) | set;
+
+#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
+	p->pte = p->pte1 = p->pte2 = p->pte3 = new;
+#else
+	*p = __pte(new);
+#endif
 #endif /* !PTE_ATOMIC_UPDATES */
 
 #ifdef CONFIG_44x
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index 70ff23974b59..1ca1c1864b32 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -209,7 +209,11 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 	/* Anything else just stores the PTE normally. That covers all 64-bit
 	 * cases, and 32-bit non-hash with 32-bit PTEs.
 	 */
+#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
+	ptep->pte = ptep->pte1 = ptep->pte2 = ptep->pte3 = pte_val(pte);
+#else
 	*ptep = pte;
+#endif
 
 	/*
 	 * With hardware tablewalk, a sync is needed to ensure that
diff --git a/arch/powerpc/include/asm/page_32.h b/arch/powerpc/include/asm/page_32.h
index 5c378e9b78c8..683dfbc67ca8 100644
--- a/arch/powerpc/include/asm/page_32.h
+++ b/arch/powerpc/include/asm/page_32.h
@@ -22,7 +22,8 @@
 #define PTE_FLAGS_OFFSET	0
 #endif
 
-#ifdef CONFIG_PPC_256K_PAGES
+#if defined(CONFIG_PPC_256K_PAGES) || \
+    (defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES))
 #define PTE_SHIFT	(PAGE_SHIFT - PTE_T_LOG2 - 2)	/* 1/4 of a page */
 #else
 #define PTE_SHIFT	(PAGE_SHIFT - PTE_T_LOG2)	/* full page */
diff --git a/arch/powerpc/include/asm/pgtable-types.h b/arch/powerpc/include/asm/pgtable-types.h
index eccb30b38b47..3b0edf041b2e 100644
--- a/arch/powerpc/include/asm/pgtable-types.h
+++ b/arch/powerpc/include/asm/pgtable-types.h
@@ -3,7 +3,11 @@
 #define _ASM_POWERPC_PGTABLE_TYPES_H
 
 /* PTE level */
+#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
+typedef struct { pte_basic_t pte, pte1, pte2, pte3; } pte_t;
+#else
 typedef struct { pte_basic_t pte; } pte_t;
+#endif
 #define __pte(x)	((pte_t) { (x) })
 static inline pte_basic_t pte_val(pte_t x)
 {
-- 
2.13.3

