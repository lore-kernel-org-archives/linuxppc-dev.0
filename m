Return-Path: <SRS0=VBhC=OH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6AAC43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 12:04:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03F73208E7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 12:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F73208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 434fTQ2QkZzDqYt
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 23:04:26 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 434f4s0lYMzDqWQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 22:46:37 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 434f4n0RBZz9v0B0;
 Wed, 28 Nov 2018 12:46:33 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id ZrO6X6NoEiHD; Wed, 28 Nov 2018 12:46:33 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 434f4m73qGz9v09s;
 Wed, 28 Nov 2018 12:46:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 13DD78B867;
 Wed, 28 Nov 2018 12:46:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id IaCZvhg9T4MJ; Wed, 28 Nov 2018 12:46:33 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id DF8D88B853;
 Wed, 28 Nov 2018 12:46:33 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id C6F5169B1B; Wed, 28 Nov 2018 11:46:33 +0000 (UTC)
Message-Id: <ea410c874c321aef87813356ba2fa2fa79c242df.1543405086.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1543405086.git.christophe.leroy@c-s.fr>
References: <cover.1543405086.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v7 06/16] powerpc/mm: Move pgtable_t into platform headers
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 28 Nov 2018 11:46:33 +0000 (UTC)
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

This patch move pgtable_t into platform headers.

It gets rid of the CONFIG_PPC_64K_PAGES case for PPC64
as nohash/64 doesn't support CONFIG_PPC_64K_PAGES.

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/mmu-hash.h |  2 ++
 arch/powerpc/include/asm/book3s/64/mmu.h      |  9 +++++++++
 arch/powerpc/include/asm/nohash/32/mmu.h      |  4 ++++
 arch/powerpc/include/asm/nohash/64/mmu.h      |  4 ++++
 arch/powerpc/include/asm/page.h               | 14 --------------
 5 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/mmu-hash.h b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
index e38c91388c40..5bd26c218b94 100644
--- a/arch/powerpc/include/asm/book3s/32/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
@@ -42,6 +42,8 @@ struct ppc_bat {
 	u32 batu;
 	u32 batl;
 };
+
+typedef struct page *pgtable_t;
 #endif /* !__ASSEMBLY__ */
 
 /*
diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 6328857f259f..1ceee000c18d 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_POWERPC_BOOK3S_64_MMU_H_
 #define _ASM_POWERPC_BOOK3S_64_MMU_H_
 
+#include <asm/page.h>
+
 #ifndef __ASSEMBLY__
 /*
  * Page size definition
@@ -24,6 +26,13 @@ struct mmu_psize_def {
 };
 extern struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
 
+/*
+ * For BOOK3s 64 with 4k and 64K linux page size
+ * we want to use pointers, because the page table
+ * actually store pfn
+ */
+typedef pte_t *pgtable_t;
+
 #endif /* __ASSEMBLY__ */
 
 /* 64-bit classic hash table MMU */
diff --git a/arch/powerpc/include/asm/nohash/32/mmu.h b/arch/powerpc/include/asm/nohash/32/mmu.h
index af0e8b54876a..f61f933a4cd8 100644
--- a/arch/powerpc/include/asm/nohash/32/mmu.h
+++ b/arch/powerpc/include/asm/nohash/32/mmu.h
@@ -16,4 +16,8 @@
 #include <asm/nohash/32/mmu-8xx.h>
 #endif
 
+#ifndef __ASSEMBLY__
+typedef struct page *pgtable_t;
+#endif
+
 #endif /* _ASM_POWERPC_NOHASH_32_MMU_H_ */
diff --git a/arch/powerpc/include/asm/nohash/64/mmu.h b/arch/powerpc/include/asm/nohash/64/mmu.h
index 87871d027b75..e6585480dfc4 100644
--- a/arch/powerpc/include/asm/nohash/64/mmu.h
+++ b/arch/powerpc/include/asm/nohash/64/mmu.h
@@ -5,4 +5,8 @@
 /* Freescale Book-E software loaded TLB or Book-3e (ISA 2.06+) MMU */
 #include <asm/nohash/mmu-book3e.h>
 
+#ifndef __ASSEMBLY__
+typedef struct page *pgtable_t;
+#endif
+
 #endif /* _ASM_POWERPC_NOHASH_64_MMU_H_ */
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 9ea903221a9f..a7624a3b1435 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -335,20 +335,6 @@ void arch_free_page(struct page *page, int order);
 #endif
 
 struct vm_area_struct;
-#ifdef CONFIG_PPC_BOOK3S_64
-/*
- * For BOOK3s 64 with 4k and 64K linux page size
- * we want to use pointers, because the page table
- * actually store pfn
- */
-typedef pte_t *pgtable_t;
-#else
-#if defined(CONFIG_PPC_64K_PAGES) && defined(CONFIG_PPC64)
-typedef pte_t *pgtable_t;
-#else
-typedef struct page *pgtable_t;
-#endif
-#endif
 
 #include <asm-generic/memory_model.h>
 #endif /* __ASSEMBLY__ */
-- 
2.13.3

