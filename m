Return-Path: <SRS0=4s7t=M7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738D4ECDE43
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 07:40:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC87F2087A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 07:40:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC87F2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42byVn16DHzF3bJ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 18:40:01 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bxWX1dkczF3VL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 17:55:36 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42bxWS0w8Wz9ttFY;
 Fri, 19 Oct 2018 08:55:32 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id sELrb-9WrBYd; Fri, 19 Oct 2018 08:55:32 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42bxWR6n4mz9ttFM;
 Fri, 19 Oct 2018 08:55:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2BBD58B8DF;
 Fri, 19 Oct 2018 08:55:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id O2c4tmC1pPrD; Fri, 19 Oct 2018 08:55:33 +0200 (CEST)
Received: from pc13168vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 09C0C8B75B;
 Fri, 19 Oct 2018 08:55:33 +0200 (CEST)
Received: by pc13168vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id B96956F496; Fri, 19 Oct 2018 06:55:32 +0000 (UTC)
Message-Id: <e6d55509dbb979da8c1a3a2b704d300d2f4e19d2.1539931703.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1539931702.git.christophe.leroy@c-s.fr>
References: <cover.1539931702.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v6 20/20] powerpc/mm: reintroduce 16K pages with HW assistance
 on 8xx
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 19 Oct 2018 06:55:32 +0000 (UTC)
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

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig                         |  2 +-
 arch/powerpc/include/asm/nohash/32/pgtable.h | 18 +++++++++++++++++-
 arch/powerpc/include/asm/nohash/pgtable.h    |  4 ++++
 arch/powerpc/include/asm/pgtable-types.h     |  4 ++++
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 287befcf37ab..3d008115fe18 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -690,7 +690,7 @@ config PPC_4K_PAGES
 
 config PPC_16K_PAGES
 	bool "16k page size"
-	depends on 44x
+	depends on 44x || PPC_8xx
 
 config PPC_64K_PAGES
 	bool "64k page size"
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index c33fbbb7ce82..19941fb8d690 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -19,9 +19,15 @@ extern int icache_44x_need_flush;
 
 #endif /* __ASSEMBLY__ */
 
+#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
+#define PTE_INDEX_SIZE  (PTE_SHIFT - 2)
+#define PTE_FRAG_NR		4
+#define PTE_FRAG_SIZE_SHIFT	12
+#else
 #define PTE_INDEX_SIZE	PTE_SHIFT
 #define PTE_FRAG_NR		1
 #define PTE_FRAG_SIZE_SHIFT	PAGE_SHIFT
+#endif
 #define PTE_FRAG_SIZE (1UL << PTE_FRAG_SIZE_SHIFT)
 
 #define PMD_INDEX_SIZE	0
@@ -52,7 +58,11 @@ extern int icache_44x_need_flush;
  * -Matt
  */
 /* PGDIR_SHIFT determines what a top-level page table entry can map */
+#ifdef CONFIG_PPC_8xx
+#define PGDIR_SHIFT	22
+#else
 #define PGDIR_SHIFT	(PAGE_SHIFT + PTE_INDEX_SIZE)
+#endif
 #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
@@ -236,7 +246,13 @@ static inline unsigned long pte_update(pte_t *p,
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

