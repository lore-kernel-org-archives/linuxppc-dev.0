Return-Path: <SRS0=lgwO=Q2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B102C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 17:35:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F1022147A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 17:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="aF0T3QOn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F1022147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 443nvK4v3GzDqFv
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 04:35:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="aF0T3QOn"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 443nd63qJ5zDqF7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 04:23:22 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 443nd13SlVz9v4wh;
 Tue, 19 Feb 2019 18:23:17 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=aF0T3QOn; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id z64kTG7dNlcw; Tue, 19 Feb 2019 18:23:17 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 443nd12Ljjz9v4wf;
 Tue, 19 Feb 2019 18:23:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1550596997; bh=Jv4JVBbRhfA3gyIP1EYU/TxFEfL2VMG+F/ri6hG6mlk=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=aF0T3QOn8yGPZr6IFDElhGbGr/VoMO6mCmlKI6jNFM9Qdog2yFGH0s/P8D6Ar94AI
 Qjq7crncHc1zDoznvtPGtj/Riko/lE89rVwNOlc+P/hEh//fv8QMfyzgAHiDgtFu7y
 pkiWOojNjzKmExJ2CQRq19MknrgXXM7ilApNjnjY=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id EA8828B7FE;
 Tue, 19 Feb 2019 18:23:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 0MSO2AGC11U1; Tue, 19 Feb 2019 18:23:18 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A1DFD8B7F9;
 Tue, 19 Feb 2019 18:23:18 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 739186E81D; Tue, 19 Feb 2019 17:23:18 +0000 (UTC)
Message-Id: <4256ccd5f58f58f13ff06bfcf86fab06d52a86d2.1550596242.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1550596242.git.christophe.leroy@c-s.fr>
References: <cover.1550596242.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v6 6/6] powerpc/32: enable CONFIG_KASAN for book3s hash
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Daniel Axtens <dja@axtens.net>
Date: Tue, 19 Feb 2019 17:23:18 +0000 (UTC)
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

The challenge with book3s/32 is that the hash table management
has to be set up before being able to use KASAN.

This patch adds a kasan_arch_is_ready() helper to defer
the activation of KASAN until paging is ready.

This limits KASAN to KASAN_MINIMAL mode. The downside of it
is that the 603, which doesn't use hash table, also gets
downgraded to KASAN_MINIMAL because this is no way to
activate full support dynamically because that's compiled-in.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Makefile                 |  2 ++
 arch/powerpc/include/asm/kasan.h      | 13 +++++++++++++
 arch/powerpc/mm/kasan/kasan_init_32.c | 27 +++++++++++++++++++++++++--
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index f0738099e31e..06d085558d21 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -428,11 +428,13 @@ endif
 endif
 
 ifdef CONFIG_KASAN
+ifndef CONFIG_PPC_BOOK3S_32
 prepare: kasan_prepare
 
 kasan_prepare: prepare0
        $(eval KASAN_SHADOW_OFFSET = $(shell awk '{if ($$2 == "KASAN_SHADOW_OFFSET") print $$3;}' include/generated/asm-offsets.h))
 endif
+endif
 
 # Check toolchain versions:
 # - gcc-4.6 is the minimum kernel-wide version so nothing required.
diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
index 0bc9148f5d87..97b5ccf0702f 100644
--- a/arch/powerpc/include/asm/kasan.h
+++ b/arch/powerpc/include/asm/kasan.h
@@ -16,6 +16,7 @@
 
 #include <asm/page.h>
 #include <asm/pgtable-types.h>
+#include <linux/jump_label.h>
 
 #define KASAN_SHADOW_SCALE_SHIFT	3
 
@@ -34,5 +35,17 @@
 void kasan_early_init(void);
 void kasan_init(void);
 
+extern struct static_key_false powerpc_kasan_enabled_key;
+
+static inline bool kasan_arch_is_ready(void)
+{
+	if (!IS_ENABLED(CONFIG_BOOK3S_32))
+		return true;
+	if (static_branch_likely(&powerpc_kasan_enabled_key))
+		return true;
+	return false;
+}
+#define kasan_arch_is_ready kasan_arch_is_ready
+
 #endif /* __ASSEMBLY */
 #endif
diff --git a/arch/powerpc/mm/kasan/kasan_init_32.c b/arch/powerpc/mm/kasan/kasan_init_32.c
index 495c908d6ee6..f24f8f56d450 100644
--- a/arch/powerpc/mm/kasan/kasan_init_32.c
+++ b/arch/powerpc/mm/kasan/kasan_init_32.c
@@ -9,6 +9,9 @@
 #include <linux/vmalloc.h>
 #include <asm/pgalloc.h>
 
+/* Used by BOOK3S_32 only */
+DEFINE_STATIC_KEY_FALSE(powerpc_kasan_enabled_key);
+
 void __init kasan_early_init(void)
 {
 	unsigned long addr = KASAN_SHADOW_START;
@@ -21,7 +24,7 @@ void __init kasan_early_init(void)
 	BUILD_BUG_ON(KASAN_SHADOW_START & ~PGDIR_MASK);
 
 	if (early_mmu_has_feature(MMU_FTR_HPTE_TABLE))
-		panic("KASAN not supported with Hash MMU\n");
+		return;
 
 	for (i = 0; i < PTRS_PER_PTE; i++)
 		__set_pte_at(&init_mm, (unsigned long)kasan_early_shadow_page,
@@ -32,6 +35,22 @@ void __init kasan_early_init(void)
 		next = pgd_addr_end(addr, end);
 		pmd_populate_kernel(&init_mm, pmd, kasan_early_shadow_pte);
 	} while (pmd++, addr = next, addr != end);
+
+	if (IS_ENABLED(CONFIG_PPC_BOOK3S_32)) {
+		jump_label_init();
+		static_branch_enable(&powerpc_kasan_enabled_key);
+	}
+}
+
+static void __init kasan_late_init(void)
+{
+	unsigned long addr;
+	phys_addr_t pa = __pa(kasan_early_shadow_page);
+
+	for (addr = KASAN_SHADOW_START; addr < KASAN_SHADOW_END; addr += PAGE_SIZE)
+		map_kernel_page(addr, pa, PAGE_KERNEL_RO);
+
+	static_branch_enable(&powerpc_kasan_enabled_key);
 }
 
 static void __ref *kasan_get_one_page(void)
@@ -113,6 +132,9 @@ void __init kasan_init(void)
 {
 	struct memblock_region *reg;
 
+	if (early_mmu_has_feature(MMU_FTR_HPTE_TABLE))
+		kasan_late_init();
+
 	for_each_memblock(memory, reg) {
 		int ret = kasan_init_region(__va(reg->base), reg->size);
 
@@ -120,7 +142,8 @@ void __init kasan_init(void)
 			panic("kasan: kasan_init_region() failed");
 	}
 
-	kasan_remap_early_shadow_ro();
+	if (!early_mmu_has_feature(MMU_FTR_HPTE_TABLE))
+		kasan_remap_early_shadow_ro();
 
 	clear_page(kasan_early_shadow_page);
 
-- 
2.13.3

