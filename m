Return-Path: <SRS0=8VeL=N4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C2CC43441
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 10:34:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6D3E204FD
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 10:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6D3E204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42xs0q5H9pzF3h7
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 21:34:35 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42xrnt4xwTzF3jg
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Nov 2018 21:25:06 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42xrnm2zjzz9v0Xm;
 Sat, 17 Nov 2018 11:25:00 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id aWyrQuNFwtGb; Sat, 17 Nov 2018 11:25:00 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42xrnm2Qv2z9v0XX;
 Sat, 17 Nov 2018 11:25:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 742978B78A;
 Sat, 17 Nov 2018 11:25:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 2UbYHlsEdgy1; Sat, 17 Nov 2018 11:25:03 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 258798B74B;
 Sat, 17 Nov 2018 11:25:03 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id ED2F369A6C; Sat, 17 Nov 2018 10:25:02 +0000 (UTC)
Message-Id: <1c200e524bc6533cff26461ad8decb9f848ceacd.1542395798.git.christophe.leroy@c-s.fr>
In-Reply-To: <aeeaafbdf0357f8bdb8ffd86822a0ddfd5521fd6.1542395798.git.christophe.leroy@c-s.fr>
References: <aeeaafbdf0357f8bdb8ffd86822a0ddfd5521fd6.1542395798.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 5/7] powerpc: change CONFIG_PPC_STD_MMU_32 to
 CONFIG_PPC_BOOK3S_32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 rjw@rjwysocki.net, viresh.kumar@linaro.org
Date: Sat, 17 Nov 2018 10:25:02 +0000 (UTC)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Today we have:

config PPC_BOOK3S_32
        bool "512x/52xx/6xx/7xx/74xx/82xx/83xx/86xx"
        [depends on PPC32 within a choice]

config PPC_BOOK3S
        def_bool y
        depends on PPC_BOOK3S_32 || PPC_BOOK3S_64

config PPC_STD_MMU
	def_bool y
	depends on PPC_BOOK3S

config PPC_STD_MMU_32
	def_bool y
	depends on PPC_STD_MMU && PPC32

PPC_STD_MMU_32 is therefore redundant with PPC_BOOK3S_32.

In order to make the code clearer, lets use preferably PPC_BOOK3S_32.
This will allow to remove CONFIG_PPC_STD_MMU_32 in a later patch.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/mmu.h     | 2 +-
 arch/powerpc/include/asm/tlb.h     | 2 +-
 arch/powerpc/kernel/setup-common.c | 4 ++--
 arch/powerpc/mm/Makefile           | 2 +-
 arch/powerpc/mm/pgtable_32.c       | 2 +-
 arch/powerpc/xmon/xmon.c           | 4 ++--
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 47b651deff5b..8a6d3b129c6d 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -338,7 +338,7 @@ static inline void mmu_early_init_devtree(void) { }
 #endif /* __ASSEMBLY__ */
 #endif
 
-#if defined(CONFIG_PPC_STD_MMU_32)
+#if defined(CONFIG_PPC_BOOK3S_32)
 /* 32-bit classic hash table MMU */
 #include <asm/book3s/32/mmu-hash.h>
 #elif defined(CONFIG_40x)
diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
index f0e571b2dc7c..e24c67d5ba75 100644
--- a/arch/powerpc/include/asm/tlb.h
+++ b/arch/powerpc/include/asm/tlb.h
@@ -40,7 +40,7 @@ extern void flush_hash_entry(struct mm_struct *mm, pte_t *ptep,
 static inline void __tlb_remove_tlb_entry(struct mmu_gather *tlb, pte_t *ptep,
 					  unsigned long address)
 {
-#ifdef CONFIG_PPC_STD_MMU_32
+#ifdef CONFIG_PPC_BOOK3S_32
 	if (pte_val(*ptep) & _PAGE_HASHPTE)
 		flush_hash_entry(tlb->mm, ptep, address);
 #endif
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 93ee3703b42f..ffa1e00349dd 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -800,7 +800,7 @@ static __init void print_system_info(void)
 #ifdef CONFIG_PPC_BOOK3S_64
 	pr_info("ppc64_pft_size    = 0x%llx\n", ppc64_pft_size);
 #endif
-#ifdef CONFIG_PPC_STD_MMU_32
+#ifdef CONFIG_PPC_BOOK3S_32
 	pr_info("Hash_size         = 0x%lx\n", Hash_size);
 #endif
 	pr_info("phys_mem_size     = 0x%llx\n",
@@ -830,7 +830,7 @@ static __init void print_system_info(void)
 	if (htab_hash_mask)
 		pr_info("htab_hash_mask    = 0x%lx\n", htab_hash_mask);
 #endif
-#ifdef CONFIG_PPC_STD_MMU_32
+#ifdef CONFIG_PPC_BOOK3S_32
 	if (Hash)
 		pr_info("Hash              = 0x%p\n", Hash);
 	if (Hash_mask)
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index ca96e7be4d0e..5cc9643d2e0c 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -17,7 +17,7 @@ hash64-$(CONFIG_PPC_NATIVE)	:= hash_native_64.o
 obj-$(CONFIG_PPC_BOOK3E_64)   += pgtable-book3e.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= pgtable-hash64.o hash_utils_64.o slb.o $(hash64-y) mmu_context_book3s64.o pgtable-book3s64.o
 obj-$(CONFIG_PPC_RADIX_MMU)	+= pgtable-radix.o tlb-radix.o
-obj-$(CONFIG_PPC_STD_MMU_32)	+= ppc_mmu_32.o hash_low_32.o mmu_context_hash32.o
+obj-$(CONFIG_PPC_BOOK3S_32)	+= ppc_mmu_32.o hash_low_32.o mmu_context_hash32.o
 obj-$(CONFIG_PPC_STD_MMU)	+= tlb_hash$(BITS).o
 ifdef CONFIG_PPC_BOOK3S_64
 obj-$(CONFIG_PPC_4K_PAGES)	+= hash64_4k.o
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index bda3c6f1bd32..10c4369cd02d 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -260,7 +260,7 @@ static void __init __mapin_ram_chunk(unsigned long offset, unsigned long top)
 		ktext = ((char *)v >= _stext && (char *)v < etext) ||
 			((char *)v >= _sinittext && (char *)v < _einittext);
 		map_kernel_page(v, p, ktext ? PAGE_KERNEL_TEXT : PAGE_KERNEL);
-#ifdef CONFIG_PPC_STD_MMU_32
+#ifdef CONFIG_PPC_BOOK3S_32
 		if (ktext)
 			hash_preload(&init_mm, v, false, 0x300);
 #endif
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 36b8dc47a3c3..79fa45df1eee 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -273,7 +273,7 @@ Commands:\n\
   X	exit monitor and don't recover\n"
 #if defined(CONFIG_PPC64) && !defined(CONFIG_PPC_BOOK3E)
 "  u	dump segment table or SLB\n"
-#elif defined(CONFIG_PPC_STD_MMU_32)
+#elif defined(CONFIG_PPC_BOOK3S_32)
 "  u	dump segment registers\n"
 #elif defined(CONFIG_44x) || defined(CONFIG_PPC_BOOK3E)
 "  u	dump TLB\n"
@@ -3495,7 +3495,7 @@ void dump_segments(void)
 }
 #endif
 
-#ifdef CONFIG_PPC_STD_MMU_32
+#ifdef CONFIG_PPC_BOOK3S_32
 void dump_segments(void)
 {
 	int i;
-- 
2.13.3

