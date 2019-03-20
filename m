Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813CFC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 10:22:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDB6D2146E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 10:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="mV9NsOJB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDB6D2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PQwF0rnZzDq8B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 21:22:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="mV9NsOJB"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PQZ01CKnzDqJX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 21:06:48 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44PQYv21ppz9vC07;
 Wed, 20 Mar 2019 11:06:43 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=mV9NsOJB; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id O3jlt3R78t9O; Wed, 20 Mar 2019 11:06:43 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44PQYv0rRyz9vByx;
 Wed, 20 Mar 2019 11:06:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553076403; bh=X0LiwJM7sZFl1rz1tQ3IaI3Bh0G0lBzR81laNMZXDmk=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=mV9NsOJBvvW5hELMn2j+dW7JCT0YIFt6YIQW86VKnkDtFqpdizyUcLn28fjKuPyLb
 n1mKSIXO6AMqslixlGodBTwcPVuD4CL9qYsKSPOKXkKoWFvu++03OHavpac0yhgxGC
 50w5U01aNhjZAo4O2TdfUteFsV4L5f+8clmRkiLY=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 3B7348B918;
 Wed, 20 Mar 2019 11:06:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id BBYHdAGOnXFo; Wed, 20 Mar 2019 11:06:44 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 0DD078B911;
 Wed, 20 Mar 2019 11:06:44 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id ED2D463AEF; Wed, 20 Mar 2019 10:06:43 +0000 (UTC)
Message-Id: <c2ba1b09b69f4f8d5b57e88d84cf40203a3b8c43.1553076180.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1553076180.git.christophe.leroy@c-s.fr>
References: <cover.1553076180.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 08/27] powerpc/mm: move __find_linux_pte() out of
 hugetlbpage.c
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 aneesh.kumar@linux.ibm.com
Date: Wed, 20 Mar 2019 10:06:43 +0000 (UTC)
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

__find_linux_pte() is the only function in hugetlbpage.c
which is compiled in regardless on CONFIG_HUGETLBPAGE

This patch moves it in pgtable.c.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/hugetlbpage.c | 103 -----------------------------------------
 arch/powerpc/mm/pgtable.c     | 104 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+), 103 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index cf2978e235f3..202ae006aa39 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -759,109 +759,6 @@ void flush_dcache_icache_hugepage(struct page *page)
 
 #endif /* CONFIG_HUGETLB_PAGE */
 
-/*
- * We have 4 cases for pgds and pmds:
- * (1) invalid (all zeroes)
- * (2) pointer to next table, as normal; bottom 6 bits == 0
- * (3) leaf pte for huge page _PAGE_PTE set
- * (4) hugepd pointer, _PAGE_PTE = 0 and bits [2..6] indicate size of table
- *
- * So long as we atomically load page table pointers we are safe against teardown,
- * we can follow the address down to the the page and take a ref on it.
- * This function need to be called with interrupts disabled. We use this variant
- * when we have MSR[EE] = 0 but the paca->irq_soft_mask = IRQS_ENABLED
- */
-pte_t *__find_linux_pte(pgd_t *pgdir, unsigned long ea,
-			bool *is_thp, unsigned *hpage_shift)
-{
-	pgd_t pgd, *pgdp;
-	pud_t pud, *pudp;
-	pmd_t pmd, *pmdp;
-	pte_t *ret_pte;
-	hugepd_t *hpdp = NULL;
-	unsigned pdshift = PGDIR_SHIFT;
-
-	if (hpage_shift)
-		*hpage_shift = 0;
-
-	if (is_thp)
-		*is_thp = false;
-
-	pgdp = pgdir + pgd_index(ea);
-	pgd  = READ_ONCE(*pgdp);
-	/*
-	 * Always operate on the local stack value. This make sure the
-	 * value don't get updated by a parallel THP split/collapse,
-	 * page fault or a page unmap. The return pte_t * is still not
-	 * stable. So should be checked there for above conditions.
-	 */
-	if (pgd_none(pgd))
-		return NULL;
-	else if (pgd_huge(pgd)) {
-		ret_pte = (pte_t *) pgdp;
-		goto out;
-	} else if (is_hugepd(__hugepd(pgd_val(pgd))))
-		hpdp = (hugepd_t *)&pgd;
-	else {
-		/*
-		 * Even if we end up with an unmap, the pgtable will not
-		 * be freed, because we do an rcu free and here we are
-		 * irq disabled
-		 */
-		pdshift = PUD_SHIFT;
-		pudp = pud_offset(&pgd, ea);
-		pud  = READ_ONCE(*pudp);
-
-		if (pud_none(pud))
-			return NULL;
-		else if (pud_huge(pud)) {
-			ret_pte = (pte_t *) pudp;
-			goto out;
-		} else if (is_hugepd(__hugepd(pud_val(pud))))
-			hpdp = (hugepd_t *)&pud;
-		else {
-			pdshift = PMD_SHIFT;
-			pmdp = pmd_offset(&pud, ea);
-			pmd  = READ_ONCE(*pmdp);
-			/*
-			 * A hugepage collapse is captured by pmd_none, because
-			 * it mark the pmd none and do a hpte invalidate.
-			 */
-			if (pmd_none(pmd))
-				return NULL;
-
-			if (pmd_trans_huge(pmd) || pmd_devmap(pmd)) {
-				if (is_thp)
-					*is_thp = true;
-				ret_pte = (pte_t *) pmdp;
-				goto out;
-			}
-			/*
-			 * pmd_large check below will handle the swap pmd pte
-			 * we need to do both the check because they are config
-			 * dependent.
-			 */
-			if (pmd_huge(pmd) || pmd_large(pmd)) {
-				ret_pte = (pte_t *) pmdp;
-				goto out;
-			} else if (is_hugepd(__hugepd(pmd_val(pmd))))
-				hpdp = (hugepd_t *)&pmd;
-			else
-				return pte_offset_kernel(&pmd, ea);
-		}
-	}
-	if (!hpdp)
-		return NULL;
-
-	ret_pte = hugepte_offset(*hpdp, ea, pdshift);
-	pdshift = hugepd_shift(*hpdp);
-out:
-	if (hpage_shift)
-		*hpage_shift = pdshift;
-	return ret_pte;
-}
-EXPORT_SYMBOL_GPL(__find_linux_pte);
-
 int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 		unsigned long end, int write, struct page **pages, int *nr)
 {
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index d3d61d29b4f1..9f4ccd15849f 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -30,6 +30,7 @@
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
+#include <asm/hugetlb.h>
 
 static inline int is_exec_fault(void)
 {
@@ -299,3 +300,106 @@ unsigned long vmalloc_to_phys(void *va)
 	return __pa(pfn_to_kaddr(pfn)) + offset_in_page(va);
 }
 EXPORT_SYMBOL_GPL(vmalloc_to_phys);
+
+/*
+ * We have 4 cases for pgds and pmds:
+ * (1) invalid (all zeroes)
+ * (2) pointer to next table, as normal; bottom 6 bits == 0
+ * (3) leaf pte for huge page _PAGE_PTE set
+ * (4) hugepd pointer, _PAGE_PTE = 0 and bits [2..6] indicate size of table
+ *
+ * So long as we atomically load page table pointers we are safe against teardown,
+ * we can follow the address down to the the page and take a ref on it.
+ * This function need to be called with interrupts disabled. We use this variant
+ * when we have MSR[EE] = 0 but the paca->irq_soft_mask = IRQS_ENABLED
+ */
+pte_t *__find_linux_pte(pgd_t *pgdir, unsigned long ea,
+			bool *is_thp, unsigned *hpage_shift)
+{
+	pgd_t pgd, *pgdp;
+	pud_t pud, *pudp;
+	pmd_t pmd, *pmdp;
+	pte_t *ret_pte;
+	hugepd_t *hpdp = NULL;
+	unsigned pdshift = PGDIR_SHIFT;
+
+	if (hpage_shift)
+		*hpage_shift = 0;
+
+	if (is_thp)
+		*is_thp = false;
+
+	pgdp = pgdir + pgd_index(ea);
+	pgd  = READ_ONCE(*pgdp);
+	/*
+	 * Always operate on the local stack value. This make sure the
+	 * value don't get updated by a parallel THP split/collapse,
+	 * page fault or a page unmap. The return pte_t * is still not
+	 * stable. So should be checked there for above conditions.
+	 */
+	if (pgd_none(pgd))
+		return NULL;
+	else if (pgd_huge(pgd)) {
+		ret_pte = (pte_t *) pgdp;
+		goto out;
+	} else if (is_hugepd(__hugepd(pgd_val(pgd))))
+		hpdp = (hugepd_t *)&pgd;
+	else {
+		/*
+		 * Even if we end up with an unmap, the pgtable will not
+		 * be freed, because we do an rcu free and here we are
+		 * irq disabled
+		 */
+		pdshift = PUD_SHIFT;
+		pudp = pud_offset(&pgd, ea);
+		pud  = READ_ONCE(*pudp);
+
+		if (pud_none(pud))
+			return NULL;
+		else if (pud_huge(pud)) {
+			ret_pte = (pte_t *) pudp;
+			goto out;
+		} else if (is_hugepd(__hugepd(pud_val(pud))))
+			hpdp = (hugepd_t *)&pud;
+		else {
+			pdshift = PMD_SHIFT;
+			pmdp = pmd_offset(&pud, ea);
+			pmd  = READ_ONCE(*pmdp);
+			/*
+			 * A hugepage collapse is captured by pmd_none, because
+			 * it mark the pmd none and do a hpte invalidate.
+			 */
+			if (pmd_none(pmd))
+				return NULL;
+
+			if (pmd_trans_huge(pmd) || pmd_devmap(pmd)) {
+				if (is_thp)
+					*is_thp = true;
+				ret_pte = (pte_t *) pmdp;
+				goto out;
+			}
+			/*
+			 * pmd_large check below will handle the swap pmd pte
+			 * we need to do both the check because they are config
+			 * dependent.
+			 */
+			if (pmd_huge(pmd) || pmd_large(pmd)) {
+				ret_pte = (pte_t *) pmdp;
+				goto out;
+			} else if (is_hugepd(__hugepd(pmd_val(pmd))))
+				hpdp = (hugepd_t *)&pmd;
+			else
+				return pte_offset_kernel(&pmd, ea);
+		}
+	}
+	if (!hpdp)
+		return NULL;
+
+	ret_pte = hugepte_offset(*hpdp, ea, pdshift);
+	pdshift = hugepd_shift(*hpdp);
+out:
+	if (hpage_shift)
+		*hpage_shift = pdshift;
+	return ret_pte;
+}
+EXPORT_SYMBOL_GPL(__find_linux_pte);
-- 
2.13.3

