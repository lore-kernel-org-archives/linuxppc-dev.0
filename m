Return-Path: <SRS0=v/d1=S3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039B3C43219
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 14:50:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81D142088F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 14:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Ci2TY9BB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D142088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44qg8m5n24zDq9B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 00:50:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="Ci2TY9BB"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44qfhh3hnwzDqZV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 00:29:40 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44qfhY5Nznz9v07D;
 Thu, 25 Apr 2019 16:29:33 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=Ci2TY9BB; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id rjLrzFRfISzF; Thu, 25 Apr 2019 16:29:33 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44qfhY4MKzz9v06V;
 Thu, 25 Apr 2019 16:29:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1556202573; bh=wu3SsXDw9+qyf/gIy8GDSFblH0FQGwqwaG1cAbdHGMU=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=Ci2TY9BB/gjZ1zvQZ4j8wl6byVxq3HNoJJtzK5u0Nd3bFYEOjA7zOZ4dLC7Uemsah
 /V6m5IW6Jm13otL4Dc2UOoCDo6BN3iAJr988ZkO01Kv+v+pFZi95ZFQmFoIalLytq7
 OZGE/Hg8EtNpBCqOaTyEvVT8ncMPMmBGmxfAJwcM=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2A6598B931;
 Thu, 25 Apr 2019 16:29:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id hquzzkm4QH2P; Thu, 25 Apr 2019 16:29:35 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 00F138B923;
 Thu, 25 Apr 2019 16:29:34 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id C274666276; Thu, 25 Apr 2019 14:29:34 +0000 (UTC)
Message-Id: <59cd0a363886c9d77da4b1f8c1439b0371d95811.1556202029.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1556202028.git.christophe.leroy@c-s.fr>
References: <cover.1556202028.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 08/11] powerpc/8xx: get rid of #ifdef CONFIG_HUGETLB_PAGE
 for slices
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 aneesh.kumar@linux.ibm.com
Date: Thu, 25 Apr 2019 14:29:34 +0000 (UTC)
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

The 8xx only selects CONFIG_PPC_MM_SLICES when CONFIG_HUGETLB_PAGE
is set.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
index beded4df1f50..0224fc7633b0 100644
--- a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
@@ -216,10 +216,8 @@ typedef struct {
 	unsigned char high_slices_psize[0];
 	unsigned long slb_addr_limit;
 	struct slice_mask mask_base_psize; /* 4k or 16k */
-# ifdef CONFIG_HUGETLB_PAGE
 	struct slice_mask mask_512k;
 	struct slice_mask mask_8m;
-# endif
 #endif
 	void *pte_frag;
 } mm_context_t;
@@ -257,12 +255,10 @@ static inline void mm_ctx_set_slb_addr_limit(mm_context_t *ctx, unsigned long li
 
 static inline struct slice_mask *slice_mask_for_size(mm_context_t *ctx, int psize)
 {
-#ifdef CONFIG_HUGETLB_PAGE
 	if (psize == MMU_PAGE_512K)
 		return &ctx->mask_512k;
 	if (psize == MMU_PAGE_8M)
 		return &ctx->mask_8m;
-#endif
 	VM_BUG_ON(psize != mmu_virtual_psize);
 
 	return &ctx->mask_base_psize;
-- 
2.13.3

