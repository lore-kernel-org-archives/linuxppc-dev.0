Return-Path: <SRS0=ImKy=S4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B937C4321B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 16:48:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4943320679
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 16:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="RzCZfl9l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4943320679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44rKkk3dzWzDqk9
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 02:48:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="RzCZfl9l"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44rK9n0WWPzDqTv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Apr 2019 02:23:41 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44rK9h2mbXz9vDcM;
 Fri, 26 Apr 2019 18:23:36 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=RzCZfl9l; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id NB2S6uXwwIQN; Fri, 26 Apr 2019 18:23:36 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44rK9h1cbwz9v0yk;
 Fri, 26 Apr 2019 18:23:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1556295816; bh=3EkWwfm1J9eIRyBAvVT+4ioqJyrfykTcLJkz42zJae0=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=RzCZfl9lrGv+E2O/U2IO/559Fg/vp/ExGaHGKmyMVcm3NogzJ6PefZ3HSDyIhSVYN
 R2K2nvdLXxJD49Im7pqWbzy2wDddDSEbkq2gi/TbGD0sfAzgVHn7WaCzKkqe26gC67
 2uk1URLUA8TBODXz4nmPhy6DQucKWwtzZHV24bJM=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id DA7EA8B950;
 Fri, 26 Apr 2019 18:23:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id i64AY_ketOJA; Fri, 26 Apr 2019 18:23:37 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.6])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B5C728B82F;
 Fri, 26 Apr 2019 18:23:37 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 9B7B7666FE; Fri, 26 Apr 2019 16:23:37 +0000 (UTC)
Message-Id: <c829a8a1d366dc83cc7d8c9e00310230c5f21b4e.1556295461.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1556295459.git.christophe.leroy@c-s.fr>
References: <cover.1556295459.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v11 13/13] powerpc/32s: map kasan zero shadow with
 PAGE_READONLY instead of PAGE_KERNEL_RO
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Daniel Axtens <dja@axtens.net>
Date: Fri, 26 Apr 2019 16:23:37 +0000 (UTC)
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

For hash32, the zero shadow page gets mapped with PAGE_READONLY instead
of PAGE_KERNEL_RO, because the PP bits don't provide a RO kernel, so
PAGE_KERNEL_RO is equivalent to PAGE_KERNEL. By using PAGE_READONLY,
the page is RO for both kernel and user, but this is not a security issue
as it contains only zeroes.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/kasan/kasan_init_32.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/kasan/kasan_init_32.c b/arch/powerpc/mm/kasan/kasan_init_32.c
index ba8361487075..0d62be3cba47 100644
--- a/arch/powerpc/mm/kasan/kasan_init_32.c
+++ b/arch/powerpc/mm/kasan/kasan_init_32.c
@@ -39,7 +39,10 @@ static int kasan_init_shadow_page_tables(unsigned long k_start, unsigned long k_
 
 		if (!new)
 			return -ENOMEM;
-		kasan_populate_pte(new, PAGE_KERNEL_RO);
+		if (early_mmu_has_feature(MMU_FTR_HPTE_TABLE))
+			kasan_populate_pte(new, PAGE_READONLY);
+		else
+			kasan_populate_pte(new, PAGE_KERNEL_RO);
 		pmd_populate_kernel(&init_mm, pmd, new);
 	}
 	return 0;
@@ -84,7 +87,10 @@ static int __ref kasan_init_region(void *start, size_t size)
 
 static void __init kasan_remap_early_shadow_ro(void)
 {
-	kasan_populate_pte(kasan_early_shadow_pte, PAGE_KERNEL_RO);
+	if (early_mmu_has_feature(MMU_FTR_HPTE_TABLE))
+		kasan_populate_pte(kasan_early_shadow_pte, PAGE_READONLY);
+	else
+		kasan_populate_pte(kasan_early_shadow_pte, PAGE_KERNEL_RO);
 
 	flush_tlb_kernel_range(KASAN_SHADOW_START, KASAN_SHADOW_END);
 }
-- 
2.13.3

