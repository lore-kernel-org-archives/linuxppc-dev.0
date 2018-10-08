Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F68C00449
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 06:11:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25F2D2086D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 06:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="HfAEnKnQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25F2D2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42T93y10nTzF3F2
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 17:11:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="HfAEnKnQ";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42T89s1RxNzF35x
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 16:31:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="HfAEnKnQ"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42T89r4V7jzB4NP; Mon,  8 Oct 2018 16:31:44 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42T89q1vL8zB4Nf;
 Mon,  8 Oct 2018 16:31:43 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538976703; bh=XdFtod+2nIEmDXnAd6/tGhgKKmau1MErO4hJSdIhmW8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HfAEnKnQOPr06hwU5nMxErPhH9luuhfWh7ggGpLHgBU+0kvawWtt8RN/FWQlpCFaG
 DkENiCbMgLOCPsDyN0RNFwFVpANOv8pkMMNsSWlYLUBHqBzsicwzrvPG+b3/q+uTMg
 /2srfEJpVZEosssPm1hBzMuxJf0b4dietwhks0XgG9aP5iNc6mK4g31wAlzja017zd
 W2Mavo8Z609jQdjWW3HLuBesv99Thu50fgyypx3/svgO8c3ASm4Wet9uPhfKLbTBN+
 IB+Hei4kKdmAK4bq9T2XwTxI6DiUL2KyLzf17WICTlUlD9/EQ6dB4wlp+saW72vJRp
 P+YKWU69BCT2w==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v5 16/33] KVM: PPC: Book3S HV: Use kvmppc_unmap_pte() in
 kvm_unmap_radix()
Date: Mon,  8 Oct 2018 16:31:02 +1100
Message-Id: <1538976679-1363-17-git-send-email-paulus@ozlabs.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538976679-1363-1-git-send-email-paulus@ozlabs.org>
References: <1538976679-1363-1-git-send-email-paulus@ozlabs.org>
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
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

kvmppc_unmap_pte() does a sequence of operations that are open-coded in
kvm_unmap_radix().  This extends kvmppc_unmap_pte() a little so that it
can be used by kvm_unmap_radix(), and makes kvm_unmap_radix() call it.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_64_mmu_radix.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index 47f2b18..bd06a95 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -240,19 +240,22 @@ static void kvmppc_pmd_free(pmd_t *pmdp)
 }
 
 static void kvmppc_unmap_pte(struct kvm *kvm, pte_t *pte,
-			     unsigned long gpa, unsigned int shift)
+			     unsigned long gpa, unsigned int shift,
+			     struct kvm_memory_slot *memslot)
 
 {
-	unsigned long page_size = 1ul << shift;
 	unsigned long old;
 
 	old = kvmppc_radix_update_pte(kvm, pte, ~0UL, 0, gpa, shift);
 	kvmppc_radix_tlbie_page(kvm, gpa, shift);
 	if (old & _PAGE_DIRTY) {
 		unsigned long gfn = gpa >> PAGE_SHIFT;
-		struct kvm_memory_slot *memslot;
+		unsigned long page_size = PAGE_SIZE;
 
-		memslot = gfn_to_memslot(kvm, gfn);
+		if (shift)
+			page_size = 1ul << shift;
+		if (!memslot)
+			memslot = gfn_to_memslot(kvm, gfn);
 		if (memslot && memslot->dirty_bitmap)
 			kvmppc_update_dirty_map(memslot, gfn, page_size);
 	}
@@ -282,7 +285,7 @@ static void kvmppc_unmap_free_pte(struct kvm *kvm, pte_t *pte, bool full)
 			WARN_ON_ONCE(1);
 			kvmppc_unmap_pte(kvm, p,
 					 pte_pfn(*p) << PAGE_SHIFT,
-					 PAGE_SHIFT);
+					 PAGE_SHIFT, NULL);
 		}
 	}
 
@@ -304,7 +307,7 @@ static void kvmppc_unmap_free_pmd(struct kvm *kvm, pmd_t *pmd, bool full)
 				WARN_ON_ONCE(1);
 				kvmppc_unmap_pte(kvm, (pte_t *)p,
 					 pte_pfn(*(pte_t *)p) << PAGE_SHIFT,
-					 PMD_SHIFT);
+					 PMD_SHIFT, NULL);
 			}
 		} else {
 			pte_t *pte;
@@ -468,7 +471,7 @@ static int kvmppc_create_pte(struct kvm *kvm, pgd_t *pgtable, pte_t pte,
 			goto out_unlock;
 		}
 		/* Valid 1GB page here already, remove it */
-		kvmppc_unmap_pte(kvm, (pte_t *)pud, hgpa, PUD_SHIFT);
+		kvmppc_unmap_pte(kvm, (pte_t *)pud, hgpa, PUD_SHIFT, NULL);
 	}
 	if (level == 2) {
 		if (!pud_none(*pud)) {
@@ -517,7 +520,7 @@ static int kvmppc_create_pte(struct kvm *kvm, pgd_t *pgtable, pte_t pte,
 			goto out_unlock;
 		}
 		/* Valid 2MB page here already, remove it */
-		kvmppc_unmap_pte(kvm, pmdp_ptep(pmd), lgpa, PMD_SHIFT);
+		kvmppc_unmap_pte(kvm, pmdp_ptep(pmd), lgpa, PMD_SHIFT, NULL);
 	}
 	if (level == 1) {
 		if (!pmd_none(*pmd)) {
@@ -780,20 +783,10 @@ int kvm_unmap_radix(struct kvm *kvm, struct kvm_memory_slot *memslot,
 	pte_t *ptep;
 	unsigned long gpa = gfn << PAGE_SHIFT;
 	unsigned int shift;
-	unsigned long old;
 
 	ptep = __find_linux_pte(kvm->arch.pgtable, gpa, NULL, &shift);
-	if (ptep && pte_present(*ptep)) {
-		old = kvmppc_radix_update_pte(kvm, ptep, ~0UL, 0,
-					      gpa, shift);
-		kvmppc_radix_tlbie_page(kvm, gpa, shift);
-		if ((old & _PAGE_DIRTY) && memslot->dirty_bitmap) {
-			unsigned long psize = PAGE_SIZE;
-			if (shift)
-				psize = 1ul << shift;
-			kvmppc_update_dirty_map(memslot, gfn, psize);
-		}
-	}
+	if (ptep && pte_present(*ptep))
+		kvmppc_unmap_pte(kvm, ptep, gpa, shift, memslot);
 	return 0;				
 }
 
-- 
2.7.4

