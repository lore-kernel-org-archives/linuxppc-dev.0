Return-Path: <SRS0=8MIQ=RP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A37C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 22:40:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58D142087C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 22:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="ppbmv4QM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D142087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Jqgn2sSkzDqJM
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 09:40:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="ppbmv4QM"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Jq7V5WbKzDqFF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 09:16:22 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44Jq7R37Dgz9tylm;
 Tue, 12 Mar 2019 23:16:19 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=ppbmv4QM; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id Cxnfh8EvFSN2; Tue, 12 Mar 2019 23:16:19 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44Jq7R1ln8z9tyll;
 Tue, 12 Mar 2019 23:16:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1552428979; bh=vq1JoFcCtAeRhW/hDKejQR/3usXiiHCmkghqbTpni3o=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=ppbmv4QMYyVzJnVaDv1LlrW/YBn7WDpq9y7uhIQIMraG1GroXwN67XUk+ewLxqBPt
 Q//B9yx2NBoqrwLEhvO5wM4u9CJiIX6xmnl/z+9nBhfuVSo5sRxkSwXVWpKI8yAmzO
 BovEfYoKfyiKqnhrP0rLgtcO8dZ4vFZ01yxV2z0g=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7149C8B8B1;
 Tue, 12 Mar 2019 23:16:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id kNUBN7VIp_-l; Tue, 12 Mar 2019 23:16:19 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 36B708B8A7;
 Tue, 12 Mar 2019 23:16:19 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id F1B4F6FA15; Tue, 12 Mar 2019 22:16:18 +0000 (UTC)
Message-Id: <72e314980c084940115d7568a503b615a72709c9.1552428161.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1552428161.git.christophe.leroy@c-s.fr>
References: <cover.1552428161.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v10 13/18] powerpc/32s: set up an early static hash table for
 KASAN.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Daniel Axtens <dja@axtens.net>
Date: Tue, 12 Mar 2019 22:16:18 +0000 (UTC)
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

KASAN requires early activation of hash table, before memblock()
functions are available.

This patch implements an early hash_table statically defined in
__initdata.

During early boot, a single page table is used.

For hash32, when doing the final init, one page table is allocated
for each PGD entry because of the _PAGE_HASHPTE flag which can't be
common to several virt pages. This is done after memblock get
available but before switching to the final hash table, otherwise
there are issues with TLB flushing due to the shared entries.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_32.S         | 40 ++++++++++++++++++++++++++---------
 arch/powerpc/mm/kasan/kasan_init_32.c | 23 +++++++++++++++++++-
 arch/powerpc/mm/mmu_decl.h            |  1 +
 3 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 0bfaf64e67ee..fd7c394bc77c 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -160,6 +160,10 @@ __after_mmu_off:
 	bl	flush_tlbs
 
 	bl	initial_bats
+	bl	load_segment_registers
+#ifdef CONFIG_KASAN
+	bl	early_hash_table
+#endif
 #if defined(CONFIG_BOOTX_TEXT)
 	bl	setup_disp_bat
 #endif
@@ -205,7 +209,7 @@ __after_mmu_off:
  */
 turn_on_mmu:
 	mfmsr	r0
-	ori	r0,r0,MSR_DR|MSR_IR
+	ori	r0,r0,MSR_DR|MSR_IR|MSR_RI
 	mtspr	SPRN_SRR1,r0
 	lis	r0,start_here@h
 	ori	r0,r0,start_here@l
@@ -884,11 +888,24 @@ _ENTRY(__restore_cpu_setup)
 	blr
 #endif /* !defined(CONFIG_PPC_BOOK3S_32) */
 
-
 /*
  * Load stuff into the MMU.  Intended to be called with
  * IR=0 and DR=0.
  */
+#ifdef CONFIG_KASAN
+early_hash_table:
+	sync			/* Force all PTE updates to finish */
+	isync
+	tlbia			/* Clear all TLB entries */
+	sync			/* wait for tlbia/tlbie to finish */
+	TLBSYNC			/* ... on all CPUs */
+	/* Load the SDR1 register (hash table base & size) */
+	lis	r6, early_hash - PAGE_OFFSET@h
+	ori	r6, r6, 3	/* 256kB table */
+	mtspr	SPRN_SDR1, r6
+	blr
+#endif
+
 load_up_mmu:
 	sync			/* Force all PTE updates to finish */
 	isync
@@ -900,14 +917,6 @@ load_up_mmu:
 	tophys(r6,r6)
 	lwz	r6,_SDR1@l(r6)
 	mtspr	SPRN_SDR1,r6
-	li	r0,16		/* load up segment register values */
-	mtctr	r0		/* for context 0 */
-	lis	r3,0x2000	/* Ku = 1, VSID = 0 */
-	li	r4,0
-3:	mtsrin	r3,r4
-	addi	r3,r3,0x111	/* increment VSID */
-	addis	r4,r4,0x1000	/* address of next segment */
-	bdnz	3b
 
 /* Load the BAT registers with the values set up by MMU_init.
    MMU_init takes care of whether we're on a 601 or not. */
@@ -929,6 +938,17 @@ BEGIN_MMU_FTR_SECTION
 END_MMU_FTR_SECTION_IFSET(MMU_FTR_USE_HIGH_BATS)
 	blr
 
+load_segment_registers:
+	li	r0, 16		/* load up segment register values */
+	mtctr	r0		/* for context 0 */
+	lis	r3, 0x2000	/* Ku = 1, VSID = 0 */
+	li	r4, 0
+3:	mtsrin	r3, r4
+	addi	r3, r3, 0x111	/* increment VSID */
+	addis	r4, r4, 0x1000	/* address of next segment */
+	bdnz	3b
+	blr
+
 /*
  * This is where the main kernel code starts.
  */
diff --git a/arch/powerpc/mm/kasan/kasan_init_32.c b/arch/powerpc/mm/kasan/kasan_init_32.c
index 42617fcad828..ba8361487075 100644
--- a/arch/powerpc/mm/kasan/kasan_init_32.c
+++ b/arch/powerpc/mm/kasan/kasan_init_32.c
@@ -94,6 +94,13 @@ void __init kasan_mmu_init(void)
 	int ret;
 	struct memblock_region *reg;
 
+	if (early_mmu_has_feature(MMU_FTR_HPTE_TABLE)) {
+		ret = kasan_init_shadow_page_tables(KASAN_SHADOW_START, KASAN_SHADOW_END);
+
+		if (ret)
+			panic("kasan: kasan_init_shadow_page_tables() failed");
+	}
+
 	for_each_memblock(memory, reg) {
 		phys_addr_t base = reg->base;
 		phys_addr_t top = min(base + reg->size, total_lowmem);
@@ -135,6 +142,20 @@ void *module_alloc(unsigned long size)
 }
 #endif
 
+#ifdef CONFIG_PPC_BOOK3S_32
+u8 __initdata early_hash[256 << 10] __aligned(256 << 10) = {0};
+
+static void __init kasan_early_hash_table(void)
+{
+	modify_instruction_site(&patch__hash_page_A0, 0xffff, __pa(early_hash) >> 16);
+	modify_instruction_site(&patch__flush_hash_A0, 0xffff, __pa(early_hash) >> 16);
+
+	Hash = (struct hash_pte *)early_hash;
+}
+#else
+static void __init kasan_early_hash_table(void) {}
+#endif
+
 void __init kasan_early_init(void)
 {
 	unsigned long addr = KASAN_SHADOW_START;
@@ -152,5 +173,5 @@ void __init kasan_early_init(void)
 	} while (pmd++, addr = next, addr != end);
 
 	if (early_mmu_has_feature(MMU_FTR_HPTE_TABLE))
-		WARN(true, "KASAN not supported on hash 6xx");
+		kasan_early_hash_table();
 }
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index d726ff776054..31fce3914ddc 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -106,6 +106,7 @@ extern unsigned int rtas_data, rtas_size;
 struct hash_pte;
 extern struct hash_pte *Hash, *Hash_end;
 extern unsigned long Hash_size, Hash_mask;
+extern u8 early_hash[];
 
 #endif /* CONFIG_PPC32 */
 
-- 
2.13.3

