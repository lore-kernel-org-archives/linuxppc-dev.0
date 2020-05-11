Return-Path: <SRS0=5PiN=6Z=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8627C54E4B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2020 11:30:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22D4320708
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2020 11:30:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22D4320708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49LJdY4VRTzDqhS
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2020 21:30:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49LJX10lm6zDqgB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2020 21:25:32 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 49LJWk4Dq0z9ty3k;
 Mon, 11 May 2020 13:25:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id wGN_it8mbnWn; Mon, 11 May 2020 13:25:22 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 49LJWk3MVtz9ty3g;
 Mon, 11 May 2020 13:25:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1F8828B7AE;
 Mon, 11 May 2020 13:25:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id XRFE_p_tBFYi; Mon, 11 May 2020 13:25:29 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id DD0538B7AD;
 Mon, 11 May 2020 13:25:28 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id C44F465A09; Mon, 11 May 2020 11:25:28 +0000 (UTC)
Message-Id: <70bad8bc9b7a4326a4d20849bccdfad078c004ac.1589196133.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1589196133.git.christophe.leroy@csgroup.eu>
References: <cover.1589196133.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 03/45] powerpc/kasan: Fix shadow pages allocation failure
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 11 May 2020 11:25:28 +0000 (UTC)
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

Doing kasan pages allocation in MMU_init is too early, kernel doesn't
have access yet to the entire memory space and memblock_alloc() fails
when the kernel is a bit big.

Do it from kasan_init() instead.

Fixes: 2edb16efc899 ("powerpc/32: Add KASAN support")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/kasan.h      | 2 --
 arch/powerpc/mm/init_32.c             | 2 --
 arch/powerpc/mm/kasan/kasan_init_32.c | 4 +++-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
index fc900937f653..4769bbf7173a 100644
--- a/arch/powerpc/include/asm/kasan.h
+++ b/arch/powerpc/include/asm/kasan.h
@@ -27,12 +27,10 @@
 
 #ifdef CONFIG_KASAN
 void kasan_early_init(void);
-void kasan_mmu_init(void);
 void kasan_init(void);
 void kasan_late_init(void);
 #else
 static inline void kasan_init(void) { }
-static inline void kasan_mmu_init(void) { }
 static inline void kasan_late_init(void) { }
 #endif
 
diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 872df48ae41b..a6991ef8727d 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -170,8 +170,6 @@ void __init MMU_init(void)
 	btext_unmap();
 #endif
 
-	kasan_mmu_init();
-
 	setup_kup();
 
 	/* Shortly after that, the entire linear mapping will be available */
diff --git a/arch/powerpc/mm/kasan/kasan_init_32.c b/arch/powerpc/mm/kasan/kasan_init_32.c
index 8b15fe09b967..b7c287adfd59 100644
--- a/arch/powerpc/mm/kasan/kasan_init_32.c
+++ b/arch/powerpc/mm/kasan/kasan_init_32.c
@@ -131,7 +131,7 @@ static void __init kasan_unmap_early_shadow_vmalloc(void)
 	flush_tlb_kernel_range(k_start, k_end);
 }
 
-void __init kasan_mmu_init(void)
+static void __init kasan_mmu_init(void)
 {
 	int ret;
 	struct memblock_region *reg;
@@ -159,6 +159,8 @@ void __init kasan_mmu_init(void)
 
 void __init kasan_init(void)
 {
+	kasan_mmu_init();
+
 	kasan_remap_early_shadow_ro();
 
 	clear_page(kasan_early_shadow_page);
-- 
2.25.0

