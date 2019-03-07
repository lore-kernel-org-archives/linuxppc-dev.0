Return-Path: <SRS0=+pA4=RK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5912C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Mar 2019 09:49:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05E5F20675
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Mar 2019 09:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="UxhcCfpA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E5F20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44FQpQ3mHYzDqHp
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Mar 2019 20:49:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="UxhcCfpA"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44FQmJ1QM8zDqCM
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Mar 2019 20:47:57 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44FQm65R7Xz9v09d;
 Thu,  7 Mar 2019 10:47:50 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=UxhcCfpA; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id ymhWtgtwKwUd; Thu,  7 Mar 2019 10:47:50 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44FQm64HFtz9v09c;
 Thu,  7 Mar 2019 10:47:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1551952070; bh=GRjJRshyGa4oONJpjdDLtJiVesc7qjaIeWrn3R7faqo=;
 h=From:Subject:To:Cc:Date:From;
 b=UxhcCfpA2B/d3FUWlQOOikNs9sPthLGQ/3tqtIoSrsYAJhmmNSSc8ABbhE48SIbMU
 7PNZfQP4XpRUm7Af2jzIYOpinbQaQomccYghrUxgezf5V6INXz7guXgNU3eJepz7ql
 Q7F6dIOhVa9DkxnC8u5vPrpLihC/jcOM07ZntFk8=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7E4E68B8EB;
 Thu,  7 Mar 2019 10:47:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 9Fd0E95XeN1D; Thu,  7 Mar 2019 10:47:51 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 569488B8C2;
 Thu,  7 Mar 2019 10:47:51 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 026AF6F9CB; Thu,  7 Mar 2019 09:47:50 +0000 (UTC)
Message-Id: <0365f99ce2b9273e269a241394957cba924f995e.1551951985.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/highmem: change BUG_ON() to WARN_ON()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Thu,  7 Mar 2019 09:47:50 +0000 (UTC)
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

In arch/powerpc/mm/highmem.c, BUG_ON() is called only when
CONFIG_DEBUG_HIGHMEM is selected, this means the BUG_ON() is
not vital and can be replaced by a a WARN_ON

At the sametime, use IS_ENABLED() instead of #ifdef to clean a bit.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/highmem.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/mm/highmem.c b/arch/powerpc/mm/highmem.c
index 82a0e37557a5..b68c9f20fbdf 100644
--- a/arch/powerpc/mm/highmem.c
+++ b/arch/powerpc/mm/highmem.c
@@ -43,9 +43,7 @@ void *kmap_atomic_prot(struct page *page, pgprot_t prot)
 	type = kmap_atomic_idx_push();
 	idx = type + KM_TYPE_NR*smp_processor_id();
 	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-#ifdef CONFIG_DEBUG_HIGHMEM
-	BUG_ON(!pte_none(*(kmap_pte-idx)));
-#endif
+	WARN_ON(IS_ENABLED(CONFIG_DEBUG_HIGHMEM) && !pte_none(*(kmap_pte - idx)));
 	__set_pte_at(&init_mm, vaddr, kmap_pte-idx, mk_pte(page, prot), 1);
 	local_flush_tlb_page(NULL, vaddr);
 
@@ -56,7 +54,7 @@ EXPORT_SYMBOL(kmap_atomic_prot);
 void __kunmap_atomic(void *kvaddr)
 {
 	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
-	int type __maybe_unused;
+	int type;
 
 	if (vaddr < __fix_to_virt(FIX_KMAP_END)) {
 		pagefault_enable();
@@ -66,12 +64,11 @@ void __kunmap_atomic(void *kvaddr)
 
 	type = kmap_atomic_idx();
 
-#ifdef CONFIG_DEBUG_HIGHMEM
-	{
+	if (IS_ENABLED(CONFIG_DEBUG_HIGHMEM)) {
 		unsigned int idx;
 
 		idx = type + KM_TYPE_NR * smp_processor_id();
-		BUG_ON(vaddr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
+		WARN_ON(vaddr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
 
 		/*
 		 * force other mappings to Oops if they'll try to access
@@ -80,7 +77,6 @@ void __kunmap_atomic(void *kvaddr)
 		pte_clear(&init_mm, vaddr, kmap_pte-idx);
 		local_flush_tlb_page(NULL, vaddr);
 	}
-#endif
 
 	kmap_atomic_idx_pop();
 	pagefault_enable();
-- 
2.13.3

