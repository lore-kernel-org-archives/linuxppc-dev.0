Return-Path: <SRS0=4s7t=M7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776C2ECDE3D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 07:01:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 016F92087A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 07:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 016F92087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bxdl6VzkzF3Xw
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 18:00:59 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bxVn2X8PzF3Vc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 17:54:57 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42bxVj1fRHz9ttFT;
 Fri, 19 Oct 2018 08:54:53 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 4O9r_IoQTgOE; Fri, 19 Oct 2018 08:54:53 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42bxVj0lJHz9ttFM;
 Fri, 19 Oct 2018 08:54:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 52BFE8B8DF;
 Fri, 19 Oct 2018 08:54:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id qdHh4xBwKwbq; Fri, 19 Oct 2018 08:54:54 +0200 (CEST)
Received: from pc13168vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2C5468B75B;
 Fri, 19 Oct 2018 08:54:54 +0200 (CEST)
Received: by pc13168vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 256B76F496; Fri, 19 Oct 2018 06:54:54 +0000 (UTC)
Message-Id: <944206be46c14b9f0578f385bdc653a9c3b8cfe2.1539931702.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1539931702.git.christophe.leroy@c-s.fr>
References: <cover.1539931702.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v6 01/20] Revert "powerpc/8xx: Use L1 entry APG to handle
 _PAGE_ACCESSED for CONFIG_SWAP"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 19 Oct 2018 06:54:54 +0000 (UTC)
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

This reverts commit 4f94b2c7462d9720b2afa7e8e8d4c19446bb31ce.

That commit was buggy, as it used rlwinm instead of rlwimi.
Instead of fixing that bug, we revert the previous commit in order to
reduce the dependency between L1 entries and L2 entries

Fixes: 4f94b2c7462d9 ("powerpc/8xx: Use L1 entry APG to handle _PAGE_ACCESSED for CONFIG_SWAP")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/mmu-8xx.h | 34 +++++-----------------------
 arch/powerpc/kernel/head_8xx.S     | 45 +++++++++++++++++++++++---------------
 arch/powerpc/mm/8xx_mmu.c          |  2 +-
 3 files changed, 34 insertions(+), 47 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-8xx.h b/arch/powerpc/include/asm/mmu-8xx.h
index 4f547752ae79..193f53116c7a 100644
--- a/arch/powerpc/include/asm/mmu-8xx.h
+++ b/arch/powerpc/include/asm/mmu-8xx.h
@@ -34,20 +34,12 @@
  * respectively NA for All or X for Supervisor and no access for User.
  * Then we use the APG to say whether accesses are according to Page rules or
  * "all Supervisor" rules (Access to all)
- * We also use the 2nd APG bit for _PAGE_ACCESSED when having SWAP:
- * When that bit is not set access is done iaw "all user"
- * which means no access iaw page rules.
- * Therefore, we define 4 APG groups. lsb is _PMD_USER, 2nd is _PAGE_ACCESSED
- * 0x => No access => 11 (all accesses performed as user iaw page definition)
- * 10 => No user => 01 (all accesses performed according to page definition)
- * 11 => User => 00 (all accesses performed as supervisor iaw page definition)
+ * Therefore, we define 2 APG groups. lsb is _PMD_USER
+ * 0 => No user => 01 (all accesses performed according to page definition)
+ * 1 => User => 00 (all accesses performed as supervisor iaw page definition)
  * We define all 16 groups so that all other bits of APG can take any value
  */
-#ifdef CONFIG_SWAP
-#define MI_APG_INIT	0xf4f4f4f4
-#else
 #define MI_APG_INIT	0x44444444
-#endif
 
 /* The effective page number register.  When read, contains the information
  * about the last instruction TLB miss.  When MI_RPN is written, bits in
@@ -115,20 +107,12 @@
  * Supervisor and no access for user and NA for ALL.
  * Then we use the APG to say whether accesses are according to Page rules or
  * "all Supervisor" rules (Access to all)
- * We also use the 2nd APG bit for _PAGE_ACCESSED when having SWAP:
- * When that bit is not set access is done iaw "all user"
- * which means no access iaw page rules.
- * Therefore, we define 4 APG groups. lsb is _PMD_USER, 2nd is _PAGE_ACCESSED
- * 0x => No access => 11 (all accesses performed as user iaw page definition)
- * 10 => No user => 01 (all accesses performed according to page definition)
- * 11 => User => 00 (all accesses performed as supervisor iaw page definition)
+ * Therefore, we define 2 APG groups. lsb is _PMD_USER
+ * 0 => No user => 01 (all accesses performed according to page definition)
+ * 1 => User => 00 (all accesses performed as supervisor iaw page definition)
  * We define all 16 groups so that all other bits of APG can take any value
  */
-#ifdef CONFIG_SWAP
-#define MD_APG_INIT	0xf4f4f4f4
-#else
 #define MD_APG_INIT	0x44444444
-#endif
 
 /* The effective page number register.  When read, contains the information
  * about the last instruction TLB miss.  When MD_RPN is written, bits in
@@ -180,12 +164,6 @@
  */
 #define SPRN_M_TW	799
 
-/* APGs */
-#define M_APG0		0x00000000
-#define M_APG1		0x00000020
-#define M_APG2		0x00000040
-#define M_APG3		0x00000060
-
 #ifdef CONFIG_PPC_MM_SLICES
 #include <asm/nohash/32/slice.h>
 #define SLICE_ARRAY_SIZE	(1 << (32 - SLICE_LOW_SHIFT - 1))
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 134a573a9f2d..12c92a483fb1 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -353,13 +353,14 @@ _ENTRY(ITLBMiss_cmp)
 #if defined(ITLB_MISS_KERNEL) || defined(CONFIG_HUGETLB_PAGE)
 	mtcr	r12
 #endif
-
-#ifdef CONFIG_SWAP
-	rlwinm	r11, r10, 31, _PAGE_ACCESSED >> 1
-#endif
 	/* Load the MI_TWC with the attributes for this "segment." */
 	mtspr	SPRN_MI_TWC, r11	/* Set segment attributes */
 
+#ifdef CONFIG_SWAP
+	rlwinm	r11, r10, 32-5, _PAGE_PRESENT
+	and	r11, r11, r10
+	rlwimi	r10, r11, 0, _PAGE_PRESENT
+#endif
 	li	r11, RPN_PATTERN | 0x200
 	/* The Linux PTE won't go exactly into the MMU TLB.
 	 * Software indicator bits 20 and 23 must be clear.
@@ -470,14 +471,22 @@ _ENTRY(DTLBMiss_jmp)
 	 * above.
 	 */
 	rlwimi	r11, r10, 0, _PAGE_GUARDED
-#ifdef CONFIG_SWAP
-	/* _PAGE_ACCESSED has to be set. We use second APG bit for that, 0
-	 * on that bit will represent a Non Access group
-	 */
-	rlwinm	r11, r10, 31, _PAGE_ACCESSED >> 1
-#endif
 	mtspr	SPRN_MD_TWC, r11
 
+	/* Both _PAGE_ACCESSED and _PAGE_PRESENT has to be set.
+	 * We also need to know if the insn is a load/store, so:
+	 * Clear _PAGE_PRESENT and load that which will
+	 * trap into DTLB Error with store bit set accordinly.
+	 */
+	/* PRESENT=0x1, ACCESSED=0x20
+	 * r11 = ((r10 & PRESENT) & ((r10 & ACCESSED) >> 5));
+	 * r10 = (r10 & ~PRESENT) | r11;
+	 */
+#ifdef CONFIG_SWAP
+	rlwinm	r11, r10, 32-5, _PAGE_PRESENT
+	and	r11, r11, r10
+	rlwimi	r10, r11, 0, _PAGE_PRESENT
+#endif
 	/* The Linux PTE won't go exactly into the MMU TLB.
 	 * Software indicator bits 24, 25, 26, and 27 must be
 	 * set.  All other Linux PTE bits control the behavior
@@ -637,8 +646,8 @@ InstructionBreakpoint:
  */
 DTLBMissIMMR:
 	mtcr	r12
-	/* Set 512k byte guarded page and mark it valid and accessed */
-	li	r10, MD_PS512K | MD_GUARDED | MD_SVALID | M_APG2
+	/* Set 512k byte guarded page and mark it valid */
+	li	r10, MD_PS512K | MD_GUARDED | MD_SVALID
 	mtspr	SPRN_MD_TWC, r10
 	mfspr	r10, SPRN_IMMR			/* Get current IMMR */
 	rlwinm	r10, r10, 0, 0xfff80000		/* Get 512 kbytes boundary */
@@ -656,8 +665,8 @@ _ENTRY(dtlb_miss_exit_2)
 
 DTLBMissLinear:
 	mtcr	r12
-	/* Set 8M byte page and mark it valid and accessed */
-	li	r11, MD_PS8MEG | MD_SVALID | M_APG2
+	/* Set 8M byte page and mark it valid */
+	li	r11, MD_PS8MEG | MD_SVALID
 	mtspr	SPRN_MD_TWC, r11
 	rlwinm	r10, r10, 0, 0x0f800000	/* 8xx supports max 256Mb RAM */
 	ori	r10, r10, 0xf0 | MD_SPS16K | _PAGE_SH | _PAGE_DIRTY | \
@@ -675,8 +684,8 @@ _ENTRY(dtlb_miss_exit_3)
 #ifndef CONFIG_PIN_TLB_TEXT
 ITLBMissLinear:
 	mtcr	r12
-	/* Set 8M byte page and mark it valid,accessed */
-	li	r11, MI_PS8MEG | MI_SVALID | M_APG2
+	/* Set 8M byte page and mark it valid */
+	li	r11, MI_PS8MEG | MI_SVALID
 	mtspr	SPRN_MI_TWC, r11
 	rlwinm	r10, r10, 0, 0x0f800000	/* 8xx supports max 256Mb RAM */
 	ori	r10, r10, 0xf0 | MI_SPS16K | _PAGE_SH | _PAGE_DIRTY | \
@@ -960,7 +969,7 @@ initial_mmu:
 	ori	r8, r8, MI_EVALID	/* Mark it valid */
 	mtspr	SPRN_MI_EPN, r8
 	li	r8, MI_PS8MEG /* Set 8M byte page */
-	ori	r8, r8, MI_SVALID | M_APG2	/* Make it valid, APG 2 */
+	ori	r8, r8, MI_SVALID	/* Make it valid */
 	mtspr	SPRN_MI_TWC, r8
 	li	r8, MI_BOOTINIT		/* Create RPN for address 0 */
 	mtspr	SPRN_MI_RPN, r8		/* Store TLB entry */
@@ -987,7 +996,7 @@ initial_mmu:
 	ori	r8, r8, MD_EVALID	/* Mark it valid */
 	mtspr	SPRN_MD_EPN, r8
 	li	r8, MD_PS512K | MD_GUARDED	/* Set 512k byte page */
-	ori	r8, r8, MD_SVALID | M_APG2	/* Make it valid and accessed */
+	ori	r8, r8, MD_SVALID	/* Make it valid */
 	mtspr	SPRN_MD_TWC, r8
 	mr	r8, r9			/* Create paddr for TLB */
 	ori	r8, r8, MI_BOOTINIT|0x2 /* Inhibit cache -- Cort */
diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index 36484a2ef915..fee599cf3bc3 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -79,7 +79,7 @@ void __init MMU_init_hw(void)
 	for (; i < 32 && mem >= LARGE_PAGE_SIZE_8M; i++) {
 		mtspr(SPRN_MD_CTR, ctr | (i << 8));
 		mtspr(SPRN_MD_EPN, (unsigned long)__va(addr) | MD_EVALID);
-		mtspr(SPRN_MD_TWC, MD_PS8MEG | MD_SVALID | M_APG2);
+		mtspr(SPRN_MD_TWC, MD_PS8MEG | MD_SVALID);
 		mtspr(SPRN_MD_RPN, addr | flags | _PAGE_PRESENT);
 		addr += LARGE_PAGE_SIZE_8M;
 		mem -= LARGE_PAGE_SIZE_8M;
-- 
2.13.3

