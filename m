Return-Path: <SRS0=3bX/=SF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8878C4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 20:31:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CE302082C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 20:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="JHnJQ6ye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CE302082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ZHmL6G2tzDqFm
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 07:31:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="JHnJQ6ye"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ZHCW1MgDzDqHr
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 07:06:31 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44ZHCR7092z9v3q1;
 Wed,  3 Apr 2019 22:06:27 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=JHnJQ6ye; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id vdEa6pStQStb; Wed,  3 Apr 2019 22:06:27 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44ZHCR5vbHz9v3pn;
 Wed,  3 Apr 2019 22:06:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1554321987; bh=KMLQNS656LPk8TrOzEewpXov97NObk8UyA43BCDWep8=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=JHnJQ6yeF3lB+dmZJgeHtK+d0dz67U8hcQ5dPMl9KcLSzx0nlZStOXw3kx4DUFfRW
 4boyDSLGvgHEGQwKZg1bgoqzPimxYVgIfQ9CHSr2wUV6nQLMYAG2SLRL4x6GEtNi8F
 mJ3PuPWapdwQOhu8/BFw6NJfEmygfSuMVGg9oKNY=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id ECBDC8B905;
 Wed,  3 Apr 2019 22:06:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id Ejl1dJDN_uOx; Wed,  3 Apr 2019 22:06:27 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C5BFF8B902;
 Wed,  3 Apr 2019 22:06:27 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 9D87E655EC; Wed,  3 Apr 2019 20:06:27 +0000 (UTC)
Message-Id: <427a67a11b408839062dbf2677964d0bd4bb1886.1554321743.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1554321743.git.christophe.leroy@c-s.fr>
References: <cover.1554321743.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 15/15] powerpc/mm: refactor pgd_alloc() and pgd_free() on
 nohash
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 aneesh.kumar@linux.ibm.com
Date: Wed,  3 Apr 2019 20:06:27 +0000 (UTC)
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

pgd_alloc() and pgd_free() are identical on nohash 32 and 64.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/32/pgalloc.h | 11 -----------
 arch/powerpc/include/asm/nohash/64/pgalloc.h | 11 -----------
 arch/powerpc/include/asm/nohash/pgalloc.h    | 12 ++++++++++++
 3 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pgalloc.h b/arch/powerpc/include/asm/nohash/32/pgalloc.h
index 137761b01588..11eac371e7e0 100644
--- a/arch/powerpc/include/asm/nohash/32/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/32/pgalloc.h
@@ -5,17 +5,6 @@
 #include <linux/threads.h>
 #include <linux/slab.h>
 
-static inline pgd_t *pgd_alloc(struct mm_struct *mm)
-{
-	return kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
-			pgtable_gfp_flags(mm, GFP_KERNEL));
-}
-
-static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
-{
-	kmem_cache_free(PGT_CACHE(PGD_INDEX_SIZE), pgd);
-}
-
 /*
  * We don't have any real pmd's, and this code never triggers because
  * the pgd will always be present..
diff --git a/arch/powerpc/include/asm/nohash/64/pgalloc.h b/arch/powerpc/include/asm/nohash/64/pgalloc.h
index 5a0ea63c77c7..62321cd12da9 100644
--- a/arch/powerpc/include/asm/nohash/64/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/64/pgalloc.h
@@ -18,17 +18,6 @@ struct vmemmap_backing {
 };
 extern struct vmemmap_backing *vmemmap_list;
 
-static inline pgd_t *pgd_alloc(struct mm_struct *mm)
-{
-	return kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
-			pgtable_gfp_flags(mm, GFP_KERNEL));
-}
-
-static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
-{
-	kmem_cache_free(PGT_CACHE(PGD_INDEX_SIZE), pgd);
-}
-
 #define pgd_populate(MM, PGD, PUD)	pgd_set(PGD, (unsigned long)PUD)
 
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
diff --git a/arch/powerpc/include/asm/nohash/pgalloc.h b/arch/powerpc/include/asm/nohash/pgalloc.h
index 4fccac6af3ad..332b13b4ecdb 100644
--- a/arch/powerpc/include/asm/nohash/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/pgalloc.h
@@ -3,6 +3,7 @@
 #define _ASM_POWERPC_NOHASH_PGALLOC_H
 
 #include <linux/mm.h>
+#include <linux/slab.h>
 
 extern void tlb_remove_table(struct mmu_gather *tlb, void *table);
 #ifdef CONFIG_PPC64
@@ -16,6 +17,17 @@ static inline void tlb_flush_pgtable(struct mmu_gather *tlb,
 }
 #endif /* !CONFIG_PPC_BOOK3E */
 
+static inline pgd_t *pgd_alloc(struct mm_struct *mm)
+{
+	return kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
+			pgtable_gfp_flags(mm, GFP_KERNEL));
+}
+
+static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
+{
+	kmem_cache_free(PGT_CACHE(PGD_INDEX_SIZE), pgd);
+}
+
 #ifdef CONFIG_PPC64
 #include <asm/nohash/64/pgalloc.h>
 #else
-- 
2.13.3

