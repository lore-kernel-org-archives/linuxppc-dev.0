Return-Path: <SRS0=BLVf=OI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D428EC43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 14:41:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 171C321104
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 14:41:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 171C321104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 435Kvh4p0wzDrDF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Nov 2018 01:41:04 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 435K8W3TyxzDrF2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Nov 2018 01:07:07 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 435K8R1QcSz9vGDx;
 Thu, 29 Nov 2018 15:07:03 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id hpYJQwH1UVmK; Thu, 29 Nov 2018 15:07:03 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 435K8R0sLCz9vGDm;
 Thu, 29 Nov 2018 15:07:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 41D2D8B8A0;
 Thu, 29 Nov 2018 15:07:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id ALgmijt-w9yZ; Thu, 29 Nov 2018 15:07:04 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id F1EC98B89E;
 Thu, 29 Nov 2018 15:07:03 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id B7D6C69AE8; Thu, 29 Nov 2018 14:07:03 +0000 (UTC)
Message-Id: <8861a72c21e819e310cc1e84c402dfbfc1552312.1543499864.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1543499860.git.christophe.leroy@c-s.fr>
References: <cover.1543499860.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v9 09/20] powerpc/mm: enable the use of page table cache of
 order 0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 29 Nov 2018 14:07:03 +0000 (UTC)
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

hugepages uses a cache of order 0. Lets allow page tables
of order 0 in the common part in order to avoid open coding
in hugetlb

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/pgalloc.h | 5 +----
 arch/powerpc/include/asm/book3s/64/pgalloc.h | 5 +----
 arch/powerpc/include/asm/nohash/32/pgalloc.h | 5 +----
 arch/powerpc/include/asm/nohash/64/pgalloc.h | 5 +----
 arch/powerpc/mm/init-common.c                | 6 +++---
 5 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgalloc.h b/arch/powerpc/include/asm/book3s/32/pgalloc.h
index 0f58e5b9dbe7..b5b955eb2fb7 100644
--- a/arch/powerpc/include/asm/book3s/32/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/32/pgalloc.h
@@ -25,10 +25,7 @@
 extern void __bad_pte(pmd_t *pmd);
 
 extern struct kmem_cache *pgtable_cache[];
-#define PGT_CACHE(shift) ({				\
-			BUG_ON(!(shift));		\
-			pgtable_cache[(shift) - 1];	\
-		})
+#define PGT_CACHE(shift) pgtable_cache[shift]
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
index f949dd90af9b..4aba625389c4 100644
--- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -37,10 +37,7 @@ extern struct vmemmap_backing *vmemmap_list;
 #define MAX_PGTABLE_INDEX_SIZE	0xf
 
 extern struct kmem_cache *pgtable_cache[];
-#define PGT_CACHE(shift) ({				\
-			BUG_ON(!(shift));		\
-			pgtable_cache[(shift) - 1];	\
-		})
+#define PGT_CACHE(shift) pgtable_cache[shift]
 
 extern pte_t *pte_fragment_alloc(struct mm_struct *, unsigned long, int);
 extern pmd_t *pmd_fragment_alloc(struct mm_struct *, unsigned long);
diff --git a/arch/powerpc/include/asm/nohash/32/pgalloc.h b/arch/powerpc/include/asm/nohash/32/pgalloc.h
index 7e234582dce5..17963951bdb0 100644
--- a/arch/powerpc/include/asm/nohash/32/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/32/pgalloc.h
@@ -25,10 +25,7 @@
 extern void __bad_pte(pmd_t *pmd);
 
 extern struct kmem_cache *pgtable_cache[];
-#define PGT_CACHE(shift) ({				\
-			BUG_ON(!(shift));		\
-			pgtable_cache[(shift) - 1];	\
-		})
+#define PGT_CACHE(shift) pgtable_cache[shift]
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
diff --git a/arch/powerpc/include/asm/nohash/64/pgalloc.h b/arch/powerpc/include/asm/nohash/64/pgalloc.h
index e2d62d033708..e95eb499a174 100644
--- a/arch/powerpc/include/asm/nohash/64/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/64/pgalloc.h
@@ -36,10 +36,7 @@ extern struct vmemmap_backing *vmemmap_list;
 #define MAX_PGTABLE_INDEX_SIZE	0xf
 
 extern struct kmem_cache *pgtable_cache[];
-#define PGT_CACHE(shift) ({				\
-			BUG_ON(!(shift));		\
-			pgtable_cache[(shift) - 1];	\
-		})
+#define PGT_CACHE(shift) pgtable_cache[shift]
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
index 2b656e67f2ea..41190f2b60c2 100644
--- a/arch/powerpc/mm/init-common.c
+++ b/arch/powerpc/mm/init-common.c
@@ -40,7 +40,7 @@ static void pmd_ctor(void *addr)
 	memset(addr, 0, PMD_TABLE_SIZE);
 }
 
-struct kmem_cache *pgtable_cache[MAX_PGTABLE_INDEX_SIZE];
+struct kmem_cache *pgtable_cache[MAX_PGTABLE_INDEX_SIZE + 1];
 EXPORT_SYMBOL_GPL(pgtable_cache);	/* used by kvm_hv module */
 
 /*
@@ -71,7 +71,7 @@ void pgtable_cache_add(unsigned shift, void (*ctor)(void *))
 	 * moment, gcc doesn't seem to recognize is_power_of_2 as a
 	 * constant expression, so so much for that. */
 	BUG_ON(!is_power_of_2(minalign));
-	BUG_ON((shift < 1) || (shift > MAX_PGTABLE_INDEX_SIZE));
+	BUG_ON(shift > MAX_PGTABLE_INDEX_SIZE);
 
 	if (PGT_CACHE(shift))
 		return; /* Already have a cache of this size */
@@ -83,7 +83,7 @@ void pgtable_cache_add(unsigned shift, void (*ctor)(void *))
 		panic("Could not allocate pgtable cache for order %d", shift);
 
 	kfree(name);
-	pgtable_cache[shift - 1] = new;
+	pgtable_cache[shift] = new;
 
 	pr_debug("Allocated pgtable cache for order %d\n", shift);
 }
-- 
2.13.3

