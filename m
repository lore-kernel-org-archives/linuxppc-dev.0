Return-Path: <SRS0=8MIQ=RP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC401C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 22:42:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 581CB214AE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 22:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="N2TM9CNF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 581CB214AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44JqjY1zvVzDqGq
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 09:42:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="N2TM9CNF"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Jq7W4xXSzDqGP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 09:16:23 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44Jq7S2kbMz9tyln;
 Tue, 12 Mar 2019 23:16:20 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=N2TM9CNF; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id qTzJ1ppy2_Hj; Tue, 12 Mar 2019 23:16:20 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44Jq7S1Z5Wz9tyll;
 Tue, 12 Mar 2019 23:16:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1552428980; bh=3EkWwfm1J9eIRyBAvVT+4ioqJyrfykTcLJkz42zJae0=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=N2TM9CNFJJZcGDGQgUrPK4MYpe/al6eQHIrgQrWJWcmO2YuKobOm5OK7m9EZlK0xG
 B6uP41oS5KK5Jzh2rvnrRFvwrgHFS7B2fPk83j6E4FGdrrsJp5+yXVRo5lW+ecBbLf
 qaXPTXztGHCEFMxvL91DA/r2eFRyTqWevkyabkZU=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 6F1D48B8B1;
 Tue, 12 Mar 2019 23:16:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id Q5Qbh1RmwQXX; Tue, 12 Mar 2019 23:16:20 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 46EAC8B8A7;
 Tue, 12 Mar 2019 23:16:20 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 0AB216FA15; Tue, 12 Mar 2019 22:16:19 +0000 (UTC)
Message-Id: <053c7aa774fe73402e690c47f432c9d3279dfc30.1552428161.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1552428161.git.christophe.leroy@c-s.fr>
References: <cover.1552428161.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v10 14/18] powerpc/32s: map kasan zero shadow with
 PAGE_READONLY instead of PAGE_KERNEL_RO
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Daniel Axtens <dja@axtens.net>
Date: Tue, 12 Mar 2019 22:16:19 +0000 (UTC)
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

