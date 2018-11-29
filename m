Return-Path: <SRS0=BLVf=OI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF35C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 14:33:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8993920663
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 14:33:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8993920663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 435Kl72hBWzDrB0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Nov 2018 01:33:39 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 435K8R1y07zDrDZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Nov 2018 01:07:03 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 435K8L6vKtz9vFvn;
 Thu, 29 Nov 2018 15:06:58 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id mtfUfyq8z1bz; Thu, 29 Nov 2018 15:06:58 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 435K8L6Nklz9vFvc;
 Thu, 29 Nov 2018 15:06:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 28B1F8B89E;
 Thu, 29 Nov 2018 15:07:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id LEhOPfuUjyG4; Thu, 29 Nov 2018 15:07:00 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E820C8B899;
 Thu, 29 Nov 2018 15:06:59 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id AC07569AE8; Thu, 29 Nov 2018 14:06:59 +0000 (UTC)
Message-Id: <02136697ed7be9ca538a02e571a8f21737d3927e.1543499863.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1543499860.git.christophe.leroy@c-s.fr>
References: <cover.1543499860.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v9 07/20] powerpc/mm: add helpers to get/set
 mm.context->pte_frag
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 29 Nov 2018 14:06:59 +0000 (UTC)
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

In order to handle pte_fragment functions with single fragment
without adding pte_frag in all mm_context_t, this patch creates
two helpers which do nothing on platforms using a single fragment.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/pgtable.h | 25 +++++++++++++++++++++++++
 arch/powerpc/mm/pgtable-frag.c     |  8 ++++----
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 9679b7519a35..314a2890a972 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -110,6 +110,31 @@ void mark_initmem_nx(void);
 static inline void mark_initmem_nx(void) { }
 #endif
 
+/*
+ * When used, PTE_FRAG_NR is defined in subarch pgtable.h
+ * so we are sure it is included when arriving here.
+ */
+#ifdef PTE_FRAG_NR
+static inline void *pte_frag_get(mm_context_t *ctx)
+{
+	return ctx->pte_frag;
+}
+
+static inline void pte_frag_set(mm_context_t *ctx, void *p)
+{
+	ctx->pte_frag = p;
+}
+#else
+static inline void *pte_frag_get(mm_context_t *ctx)
+{
+	return NULL;
+}
+
+static inline void pte_frag_set(mm_context_t *ctx, void *p)
+{
+}
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_PGTABLE_H */
diff --git a/arch/powerpc/mm/pgtable-frag.c b/arch/powerpc/mm/pgtable-frag.c
index 7544d0d7177d..af23a587f019 100644
--- a/arch/powerpc/mm/pgtable-frag.c
+++ b/arch/powerpc/mm/pgtable-frag.c
@@ -38,7 +38,7 @@ static pte_t *get_pte_from_cache(struct mm_struct *mm)
 		return NULL;
 
 	spin_lock(&mm->page_table_lock);
-	ret = mm->context.pte_frag;
+	ret = pte_frag_get(&mm->context);
 	if (ret) {
 		pte_frag = ret + PTE_FRAG_SIZE;
 		/*
@@ -46,7 +46,7 @@ static pte_t *get_pte_from_cache(struct mm_struct *mm)
 		 */
 		if (((unsigned long)pte_frag & ~PAGE_MASK) == 0)
 			pte_frag = NULL;
-		mm->context.pte_frag = pte_frag;
+		pte_frag_set(&mm->context, pte_frag);
 	}
 	spin_unlock(&mm->page_table_lock);
 	return (pte_t *)ret;
@@ -86,9 +86,9 @@ static pte_t *__alloc_for_ptecache(struct mm_struct *mm, int kernel)
 	 * the allocated page with single fragement
 	 * count.
 	 */
-	if (likely(!mm->context.pte_frag)) {
+	if (likely(!pte_frag_get(&mm->context))) {
 		atomic_set(&page->pt_frag_refcount, PTE_FRAG_NR);
-		mm->context.pte_frag = ret + PTE_FRAG_SIZE;
+		pte_frag_set(&mm->context, ret + PTE_FRAG_SIZE);
 	}
 	spin_unlock(&mm->page_table_lock);
 
-- 
2.13.3

