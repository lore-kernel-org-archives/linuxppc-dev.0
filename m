Return-Path: <SRS0=ImKy=S4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FF8C43218
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 16:17:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CBC02084F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 16:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="D+VYBx/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CBC02084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44rK2V3G5kzDq7d
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 02:17:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="D+VYBx/i"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44rJcP1Sy5zDqSG
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Apr 2019 01:58:13 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44rJcJ415sz9v0yT;
 Fri, 26 Apr 2019 17:58:08 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=D+VYBx/i; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id zFPbq5a55teq; Fri, 26 Apr 2019 17:58:08 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44rJcJ2nffz9v0yN;
 Fri, 26 Apr 2019 17:58:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1556294288; bh=gwSBkR8SNd8udGVI3QTStX+M6+oZhF2H+aToHhBfwcI=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=D+VYBx/i8J8lhJLh41BLspdDaJ+MwM4D7XDlaToE4h8pdB/oNMZ/x+Sa/iM8FwgZj
 KamxYd2mssxObl37VKTbXbz3DB03yY0/QAV0fNdKACPFeFFS/zyuqWIOi1waudIqLU
 07TlUSfiu0fE6f/E6v50m62QB+l4OgnqR5jASeWE=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 05BF58B94A;
 Fri, 26 Apr 2019 17:58:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id lhVBhYkWhRyT; Fri, 26 Apr 2019 17:58:09 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.6])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D69438B82F;
 Fri, 26 Apr 2019 17:58:09 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id B563E666FE; Fri, 26 Apr 2019 15:58:09 +0000 (UTC)
Message-Id: <e48c9e09b90d85438f5a1da85c315f378456c5c2.1556293738.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1556293738.git.christophe.leroy@c-s.fr>
References: <cover.1556293738.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 11/15] powerpc/mm: refactor definition of pgtable_cache[]
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 aneesh.kumar@linux.ibm.com
Date: Fri, 26 Apr 2019 15:58:09 +0000 (UTC)
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

pgtable_cache[] is the same for the 4 subarches, lets make it common.

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/pgalloc.h | 21 ---------------------
 arch/powerpc/include/asm/book3s/64/pgalloc.h | 22 ----------------------
 arch/powerpc/include/asm/nohash/32/pgalloc.h | 21 ---------------------
 arch/powerpc/include/asm/nohash/64/pgalloc.h | 22 ----------------------
 arch/powerpc/include/asm/pgalloc.h           | 21 +++++++++++++++++++++
 5 files changed, 21 insertions(+), 86 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgalloc.h b/arch/powerpc/include/asm/book3s/32/pgalloc.h
index 46422309d6e0..1b9b5c228230 100644
--- a/arch/powerpc/include/asm/book3s/32/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/32/pgalloc.h
@@ -5,26 +5,6 @@
 #include <linux/threads.h>
 #include <linux/slab.h>
 
-/*
- * Functions that deal with pagetables that could be at any level of
- * the table need to be passed an "index_size" so they know how to
- * handle allocation.  For PTE pages (which are linked to a struct
- * page for now, and drawn from the main get_free_pages() pool), the
- * allocation size will be (2^index_size * sizeof(pointer)) and
- * allocations are drawn from the kmem_cache in PGT_CACHE(index_size).
- *
- * The maximum index size needs to be big enough to allow any
- * pagetable sizes we need, but small enough to fit in the low bits of
- * any page table pointer.  In other words all pagetables, even tiny
- * ones, must be aligned to allow at least enough low 0 bits to
- * contain this value.  This value is also used as a mask, so it must
- * be one less than a power of two.
- */
-#define MAX_PGTABLE_INDEX_SIZE	0xf
-
-extern struct kmem_cache *pgtable_cache[];
-#define PGT_CACHE(shift) pgtable_cache[shift]
-
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	return kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
@@ -69,7 +49,6 @@ static inline void pgtable_free(void *table, unsigned index_size)
 	}
 }
 
-#define check_pgt_cache()	do { } while (0)
 #define get_hugepd_cache_index(x)  (x)
 
 #ifdef CONFIG_SMP
diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
index cfd48d8cc055..df2dce6afe14 100644
--- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -19,26 +19,6 @@ struct vmemmap_backing {
 };
 extern struct vmemmap_backing *vmemmap_list;
 
-/*
- * Functions that deal with pagetables that could be at any level of
- * the table need to be passed an "index_size" so they know how to
- * handle allocation.  For PTE pages (which are linked to a struct
- * page for now, and drawn from the main get_free_pages() pool), the
- * allocation size will be (2^index_size * sizeof(pointer)) and
- * allocations are drawn from the kmem_cache in PGT_CACHE(index_size).
- *
- * The maximum index size needs to be big enough to allow any
- * pagetable sizes we need, but small enough to fit in the low bits of
- * any page table pointer.  In other words all pagetables, even tiny
- * ones, must be aligned to allow at least enough low 0 bits to
- * contain this value.  This value is also used as a mask, so it must
- * be one less than a power of two.
- */
-#define MAX_PGTABLE_INDEX_SIZE	0xf
-
-extern struct kmem_cache *pgtable_cache[];
-#define PGT_CACHE(shift) pgtable_cache[shift]
-
 extern pmd_t *pmd_fragment_alloc(struct mm_struct *, unsigned long);
 extern void pmd_fragment_free(unsigned long *);
 extern void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift);
@@ -199,8 +179,6 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 	pgtable_free_tlb(tlb, table, PTE_INDEX);
 }
 
-#define check_pgt_cache()	do { } while (0)
-
 extern atomic_long_t direct_pages_count[MMU_PAGE_COUNT];
 static inline void update_page_count(int psize, long count)
 {
diff --git a/arch/powerpc/include/asm/nohash/32/pgalloc.h b/arch/powerpc/include/asm/nohash/32/pgalloc.h
index e96ef2fde2ca..4615801aa953 100644
--- a/arch/powerpc/include/asm/nohash/32/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/32/pgalloc.h
@@ -5,26 +5,6 @@
 #include <linux/threads.h>
 #include <linux/slab.h>
 
-/*
- * Functions that deal with pagetables that could be at any level of
- * the table need to be passed an "index_size" so they know how to
- * handle allocation.  For PTE pages (which are linked to a struct
- * page for now, and drawn from the main get_free_pages() pool), the
- * allocation size will be (2^index_size * sizeof(pointer)) and
- * allocations are drawn from the kmem_cache in PGT_CACHE(index_size).
- *
- * The maximum index size needs to be big enough to allow any
- * pagetable sizes we need, but small enough to fit in the low bits of
- * any page table pointer.  In other words all pagetables, even tiny
- * ones, must be aligned to allow at least enough low 0 bits to
- * contain this value.  This value is also used as a mask, so it must
- * be one less than a power of two.
- */
-#define MAX_PGTABLE_INDEX_SIZE	0xf
-
-extern struct kmem_cache *pgtable_cache[];
-#define PGT_CACHE(shift) pgtable_cache[shift]
-
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	return kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
@@ -87,7 +67,6 @@ static inline void pgtable_free(void *table, unsigned index_size)
 	}
 }
 
-#define check_pgt_cache()	do { } while (0)
 #define get_hugepd_cache_index(x)	(x)
 
 #ifdef CONFIG_SMP
diff --git a/arch/powerpc/include/asm/nohash/64/pgalloc.h b/arch/powerpc/include/asm/nohash/64/pgalloc.h
index 98de4f3b0306..ffc86d42816d 100644
--- a/arch/powerpc/include/asm/nohash/64/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/64/pgalloc.h
@@ -18,26 +18,6 @@ struct vmemmap_backing {
 };
 extern struct vmemmap_backing *vmemmap_list;
 
-/*
- * Functions that deal with pagetables that could be at any level of
- * the table need to be passed an "index_size" so they know how to
- * handle allocation.  For PTE pages (which are linked to a struct
- * page for now, and drawn from the main get_free_pages() pool), the
- * allocation size will be (2^index_size * sizeof(pointer)) and
- * allocations are drawn from the kmem_cache in PGT_CACHE(index_size).
- *
- * The maximum index size needs to be big enough to allow any
- * pagetable sizes we need, but small enough to fit in the low bits of
- * any page table pointer.  In other words all pagetables, even tiny
- * ones, must be aligned to allow at least enough low 0 bits to
- * contain this value.  This value is also used as a mask, so it must
- * be one less than a power of two.
- */
-#define MAX_PGTABLE_INDEX_SIZE	0xf
-
-extern struct kmem_cache *pgtable_cache[];
-#define PGT_CACHE(shift) pgtable_cache[shift]
-
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	return kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
@@ -140,6 +120,4 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 #define __pud_free_tlb(tlb, pud, addr)		      \
 	pgtable_free_tlb(tlb, pud, PUD_INDEX_SIZE)
 
-#define check_pgt_cache()	do { } while (0)
-
 #endif /* _ASM_POWERPC_PGALLOC_64_H */
diff --git a/arch/powerpc/include/asm/pgalloc.h b/arch/powerpc/include/asm/pgalloc.h
index c2c6fd438840..5761bee0f004 100644
--- a/arch/powerpc/include/asm/pgalloc.h
+++ b/arch/powerpc/include/asm/pgalloc.h
@@ -45,6 +45,27 @@ static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
 	pte_fragment_free((unsigned long *)ptepage, 0);
 }
 
+/*
+ * Functions that deal with pagetables that could be at any level of
+ * the table need to be passed an "index_size" so they know how to
+ * handle allocation.  For PTE pages, the allocation size will be
+ * (2^index_size * sizeof(pointer)) and allocations are drawn from
+ * the kmem_cache in PGT_CACHE(index_size).
+ *
+ * The maximum index size needs to be big enough to allow any
+ * pagetable sizes we need, but small enough to fit in the low bits of
+ * any page table pointer.  In other words all pagetables, even tiny
+ * ones, must be aligned to allow at least enough low 0 bits to
+ * contain this value.  This value is also used as a mask, so it must
+ * be one less than a power of two.
+ */
+#define MAX_PGTABLE_INDEX_SIZE	0xf
+
+extern struct kmem_cache *pgtable_cache[];
+#define PGT_CACHE(shift) pgtable_cache[shift]
+
+static inline void check_pgt_cache(void) { }
+
 #ifdef CONFIG_PPC_BOOK3S
 #include <asm/book3s/pgalloc.h>
 #else
-- 
2.13.3

