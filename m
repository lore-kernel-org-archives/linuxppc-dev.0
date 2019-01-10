Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B57C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 15:37:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C4FE20685
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 15:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C4FE20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43b98y2Q3LzDqmY
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 02:37:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43b8cB6bLKzDqjX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 02:12:10 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43b8c6315rz9v0fF;
 Thu, 10 Jan 2019 16:12:06 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id cLdCENG9OLwS; Thu, 10 Jan 2019 16:12:06 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43b8c628hsz9v0f8;
 Thu, 10 Jan 2019 16:12:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C4F2A8B8A0;
 Thu, 10 Jan 2019 16:12:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id yNLKDSW5i6XA; Thu, 10 Jan 2019 16:12:07 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7E3768B89F;
 Thu, 10 Jan 2019 16:12:07 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 29C976BF21; Thu, 10 Jan 2019 15:12:07 +0000 (UTC)
Message-Id: <a2a5bdf662a72875c66fbf8c2ec2ec5186d5433c.1547132681.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1547132681.git.christophe.leroy@c-s.fr>
References: <cover.1547132681.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 14/15] powerpc/8xx: don't disable large TLBs with
 CONFIG_STRICT_KERNEL_RWX
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 j.neuschaefer@gmx.net
Date: Thu, 10 Jan 2019 15:12:07 +0000 (UTC)
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

This patch implements handling of STRICT_KERNEL_RWX with
large TLBs directly in the TLB miss handlers.

To do so, etext and sinittext are aligned on 512kB boundaries
and the miss handlers use 512kB pages instead of 8Mb pages for
addresses close to the boundaries.

It sets RO PP flags for addresses under sinittext.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig                         |  2 ++
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h |  3 ++-
 arch/powerpc/kernel/head_8xx.S               | 33 ++++++++++++++++++++++++++--
 arch/powerpc/mm/8xx_mmu.c                    | 31 +++++++++++++++++++++++++-
 arch/powerpc/mm/init_32.c                    |  2 +-
 arch/powerpc/mm/mmu_decl.h                   |  2 +-
 6 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 3f6365f29c65..18744290c078 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -745,6 +745,7 @@ config ETEXT_SHIFT
 	int "_etext shift" if ETEXT_SHIFT_BOOL
 	range 17 28 if STRICT_KERNEL_RWX && PPC_BOOK3S_32
 	default 17 if STRICT_KERNEL_RWX && PPC_BOOK3S_32
+	default 19 if STRICT_KERNEL_RWX && PPC_8xx
 	default PPC_PAGE_SHIFT
 	help
 	  On Book3S 32 (603+), IBATs are used to map kernel text.
@@ -765,6 +766,7 @@ config DATA_SHIFT
 	default 24 if STRICT_KERNEL_RWX && PPC64
 	range 17 28 if STRICT_KERNEL_RWX && PPC_BOOK3S_32
 	default 22 if STRICT_KERNEL_RWX && PPC_BOOK3S_32
+	default 19 if STRICT_KERNEL_RWX && PPC_8xx
 	default PPC_PAGE_SHIFT
 	help
 	  On Book3S 32 (603+), DBATs are used to map kernel text and rodata RO.
diff --git a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
index b0f764c827c0..0a1a3fc54e54 100644
--- a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
@@ -231,9 +231,10 @@ static inline unsigned int mmu_psize_to_shift(unsigned int mmu_psize)
 }
 
 /* patch sites */
-extern s32 patch__itlbmiss_linmem_top;
+extern s32 patch__itlbmiss_linmem_top, patch__itlbmiss_linmem_top8;
 extern s32 patch__dtlbmiss_linmem_top, patch__dtlbmiss_immr_jmp;
 extern s32 patch__fixupdar_linmem_top;
+extern s32 patch__dtlbmiss_romem_top, patch__dtlbmiss_romem_top8;
 
 extern s32 patch__itlbmiss_exit_1, patch__itlbmiss_exit_2;
 extern s32 patch__dtlbmiss_exit_1, patch__dtlbmiss_exit_2, patch__dtlbmiss_exit_3;
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index c3f776fda984..f095c3c18455 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -405,10 +405,20 @@ InstructionTLBMiss:
 #ifndef CONFIG_PIN_TLB_TEXT
 ITLBMissLinear:
 	mtcr	r11
+#ifdef CONFIG_STRICT_KERNEL_RWX
+	patch_site	0f, patch__itlbmiss_linmem_top8
+
+	mfspr	r10, SPRN_SRR0
+0:	subis	r11, r10, (PAGE_OFFSET - 0x80000000)@ha
+	rlwinm	r11, r11, 4, MI_PS8MEG ^ MI_PS512K
+	ori	r11, r11, MI_PS512K | MI_SVALID
+	rlwinm	r10, r10, 0, 0x0ff80000	/* 8xx supports max 256Mb RAM */
+#else
 	/* Set 8M byte page and mark it valid */
 	li	r11, MI_PS8MEG | MI_SVALID
-	mtspr	SPRN_MI_TWC, r11
 	rlwinm	r10, r10, 20, 0x0f800000	/* 8xx supports max 256Mb RAM */
+#endif
+	mtspr	SPRN_MI_TWC, r11
 	ori	r10, r10, 0xf0 | MI_SPS16K | _PAGE_SH | _PAGE_DIRTY | \
 			  _PAGE_PRESENT
 	mtspr	SPRN_MI_RPN, r10	/* Update TLB entry */
@@ -525,10 +535,29 @@ DTLBMissIMMR:
 
 DTLBMissLinear:
 	mtcr	r11
+	rlwinm	r10, r10, 20, 0x0f800000	/* 8xx supports max 256Mb RAM */
+#ifdef CONFIG_STRICT_KERNEL_RWX
+	patch_site	0f, patch__dtlbmiss_romem_top8
+
+0:	subis	r11, r10, (PAGE_OFFSET - 0x80000000)@ha
+	rlwinm	r11, r11, 0, 0xff800000
+	neg	r10, r11
+	or	r11, r11, r10
+	rlwinm	r11, r11, 4, MI_PS8MEG ^ MI_PS512K
+	ori	r11, r11, MI_PS512K | MI_SVALID
+	mfspr	r10, SPRN_MD_EPN
+	rlwinm	r10, r10, 0, 0x0ff80000	/* 8xx supports max 256Mb RAM */
+#else
 	/* Set 8M byte page and mark it valid */
 	li	r11, MD_PS8MEG | MD_SVALID
+#endif
 	mtspr	SPRN_MD_TWC, r11
-	rlwinm	r10, r10, 20, 0x0f800000	/* 8xx supports max 256Mb RAM */
+#ifdef CONFIG_STRICT_KERNEL_RWX
+	patch_site	0f, patch__dtlbmiss_romem_top
+
+0:	subis	r11, r10, 0
+	rlwimi	r10, r11, 11, _PAGE_RO
+#endif
 	ori	r10, r10, 0xf0 | MD_SPS16K | _PAGE_SH | _PAGE_DIRTY | \
 			  _PAGE_PRESENT
 	mtspr	SPRN_MD_RPN, r10	/* Update TLB entry */
diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index b542dd0bff9c..0024ceb77852 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -94,11 +94,20 @@ static void __init mmu_mapin_immr(void)
 		map_kernel_page(v + offset, p + offset, PAGE_KERNEL_NCG);
 }
 
-static void __init mmu_patch_cmp_limit(s32 *site, unsigned long mapped)
+static void mmu_patch_cmp_limit(s32 *site, unsigned long mapped)
 {
 	modify_instruction_site(site, 0xffff, (unsigned long)__va(mapped) >> 16);
 }
 
+static void mmu_patch_addis(s32 *site, long simm)
+{
+	unsigned int instr = *(unsigned int *)patch_site_addr(site);
+
+	instr &= 0xffff0000;
+	instr |= ((unsigned long)simm) >> 16;
+	patch_instruction_site(site, instr);
+}
+
 unsigned long __init mmu_mapin_ram(unsigned long base, unsigned long top)
 {
 	unsigned long mapped;
@@ -135,6 +144,26 @@ unsigned long __init mmu_mapin_ram(unsigned long base, unsigned long top)
 	return mapped;
 }
 
+void mmu_mark_initmem_nx(void)
+{
+	if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX) && CONFIG_ETEXT_SHIFT < 23)
+		mmu_patch_addis(&patch__itlbmiss_linmem_top8,
+				-((long)_etext & ~(LARGE_PAGE_SIZE_8M - 1)));
+	if (!IS_ENABLED(CONFIG_PIN_TLB_TEXT))
+		mmu_patch_cmp_limit(&patch__itlbmiss_linmem_top, __pa(_etext));
+}
+
+#ifdef CONFIG_STRICT_KERNEL_RWX
+void mmu_mark_rodata_ro(void)
+{
+	if (CONFIG_DATA_SHIFT < 23)
+		mmu_patch_addis(&patch__dtlbmiss_romem_top8,
+				-__pa(((unsigned long)_sinittext) &
+				      ~(LARGE_PAGE_SIZE_8M - 1)));
+	mmu_patch_addis(&patch__dtlbmiss_romem_top, -__pa(_sinittext));
+}
+#endif
+
 void __init setup_initial_memory_limit(phys_addr_t first_memblock_base,
 				       phys_addr_t first_memblock_size)
 {
diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index bc28995a37ea..41a3513cadc9 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -108,7 +108,7 @@ static void __init MMU_setup(void)
 		__map_without_bats = 1;
 		__map_without_ltlbs = 1;
 	}
-	if (strict_kernel_rwx_enabled())
+	if (strict_kernel_rwx_enabled() && !IS_ENABLED(CONFIG_PPC_8xx))
 		__map_without_ltlbs = 1;
 }
 
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 98fc94affc29..74ff61dabcb1 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -166,7 +166,7 @@ static inline phys_addr_t v_block_mapped(unsigned long va) { return 0; }
 static inline unsigned long p_block_mapped(phys_addr_t pa) { return 0; }
 #endif
 
-#if defined(CONFIG_PPC_BOOK3S_32)
+#if defined(CONFIG_PPC_BOOK3S_32) || defined(CONFIG_PPC_8xx)
 void mmu_mark_initmem_nx(void);
 void mmu_mark_rodata_ro(void);
 #else
-- 
2.13.3

