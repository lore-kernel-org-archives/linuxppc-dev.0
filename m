Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571FCC64EAD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 15:55:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF869204FD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 15:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF869204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42V1zG4rprzF3MR
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 02:55:38 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TzF40NcLzF38T
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 00:52:24 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42TzDm0qcGz9ttg1;
 Tue,  9 Oct 2018 15:52:08 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id Ie_soBRj9TX2; Tue,  9 Oct 2018 15:52:08 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42TzDm0GJxz9ttfw;
 Tue,  9 Oct 2018 15:52:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B93E28B80B;
 Tue,  9 Oct 2018 15:52:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id rFl0LY-ZN9Ra; Tue,  9 Oct 2018 15:52:19 +0200 (CEST)
Received: from pc13168vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 74D588B80A;
 Tue,  9 Oct 2018 15:52:19 +0200 (CEST)
Received: by pc13168vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 8043D6F444; Tue,  9 Oct 2018 13:52:18 +0000 (UTC)
Message-Id: <f01dd2670a0325da7731be171fddb62f773ca09c.1539092112.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1539092111.git.christophe.leroy@c-s.fr>
References: <cover.1539092111.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 23/24] powerpc/8xx: change name of a few page flags to
 avoid confusion
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Geoff Levand <geoff@infradead.org>, Jens Axboe <axboe@kernel.dk>,
 Kumar Gala <galak@kernel.crashing.org>, Li Yang <leoyang.li@nxp.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>,
 aneesh.kumar@linux.vnet.ibm.com
Date: Tue,  9 Oct 2018 13:52:18 +0000 (UTC)
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
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-block@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

_PAGE_PRIVILEGED corresponds to the SH bit which doesn't protect
against user access but only disables ASID verification on kernel
accesses. User access is controlled with _PMD_USER flag.

Name it _PAGE_SH instead of _PAGE_PRIVILEGED

_PAGE_HUGE corresponds to the SPS bit which doesn't really tells
that's it is a huge page but only that it is not a 4k page.

Name it _PAGE_SPS instead of _PAGE_HUGE

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/32/pte-8xx.h | 28 ++++++++++++++--------------
 arch/powerpc/kernel/head_8xx.S               |  6 +++---
 arch/powerpc/mm/8xx_mmu.c                    |  2 +-
 arch/powerpc/mm/dump_linuxpagetables-8xx.c   |  2 +-
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
index 2b4669b3badb..1c57efac089d 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
@@ -29,10 +29,10 @@
  */
 
 /* Definitions for 8xx embedded chips. */
-#define _PAGE_PRESENT	0x0001	/* Page is valid */
-#define _PAGE_NO_CACHE	0x0002	/* I: cache inhibit */
-#define _PAGE_PRIVILEGED	0x0004	/* No ASID (context) compare */
-#define _PAGE_HUGE	0x0008	/* SPS: Small Page Size (1 if 16k, 512k or 8M)*/
+#define _PAGE_PRESENT	0x0001	/* V: Page is valid */
+#define _PAGE_NO_CACHE	0x0002	/* CI: cache inhibit */
+#define _PAGE_SH	0x0004	/* SH: No ASID (context) compare */
+#define _PAGE_SPS	0x0008	/* SPS: Small Page Size (1 if 16k, 512k or 8M)*/
 #define _PAGE_DIRTY	0x0100	/* C: page changed */
 
 /* These 4 software bits must be masked out when the L2 entry is loaded
@@ -50,15 +50,15 @@
 #define _PAGE_COHERENT	0
 #define _PAGE_WRITETHRU	0
 
-#define _PAGE_KERNEL_RO		(_PAGE_PRIVILEGED | _PAGE_RO)
-#define _PAGE_KERNEL_ROX	(_PAGE_PRIVILEGED | _PAGE_RO | _PAGE_EXEC)
-#define _PAGE_KERNEL_RW		(_PAGE_PRIVILEGED | _PAGE_DIRTY)
-#define _PAGE_KERNEL_RWX	(_PAGE_PRIVILEGED | _PAGE_DIRTY | _PAGE_EXEC)
+#define _PAGE_KERNEL_RO		(_PAGE_SH | _PAGE_RO)
+#define _PAGE_KERNEL_ROX	(_PAGE_SH | _PAGE_RO | _PAGE_EXEC)
+#define _PAGE_KERNEL_RW		(_PAGE_SH | _PAGE_DIRTY)
+#define _PAGE_KERNEL_RWX	(_PAGE_SH | _PAGE_DIRTY | _PAGE_EXEC)
 
 /* Mask of bits returned by pte_pgprot() */
 #define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_NO_CACHE | \
 			 _PAGE_ACCESSED | _PAGE_RO | _PAGE_NA | \
-			 _PAGE_PRIVILEGED | _PAGE_DIRTY | _PAGE_EXEC)
+			 _PAGE_SH | _PAGE_DIRTY | _PAGE_EXEC)
 
 #define _PMD_PRESENT	0x0001
 #define _PMD_PRESENT_MASK	_PMD_PRESENT
@@ -74,7 +74,7 @@
 #define PTE_ATOMIC_UPDATES	1
 
 #ifdef CONFIG_PPC_16K_PAGES
-#define _PAGE_PSIZE	_PAGE_HUGE
+#define _PAGE_PSIZE	_PAGE_SPS
 #else
 #define _PAGE_PSIZE		0
 #endif
@@ -115,28 +115,28 @@ static inline pte_t pte_mkwrite(pte_t pte)
 
 static inline bool pte_user(pte_t pte)
 {
-	return !(pte_val(pte) & _PAGE_PRIVILEGED);
+	return !(pte_val(pte) & _PAGE_SH);
 }
 
 #define pte_user pte_user
 
 static inline pte_t pte_mkprivileged(pte_t pte)
 {
-	return __pte(pte_val(pte) | _PAGE_PRIVILEGED);
+	return __pte(pte_val(pte) | _PAGE_SH);
 }
 
 #define pte_mkprivileged pte_mkprivileged
 
 static inline pte_t pte_mkuser(pte_t pte)
 {
-	return __pte(pte_val(pte) & ~_PAGE_PRIVILEGED);
+	return __pte(pte_val(pte) & ~_PAGE_SH);
 }
 
 #define pte_mkuser pte_mkuser
 
 static inline pte_t pte_mkhuge(pte_t pte)
 {
-	return __pte(pte_val(pte) | _PAGE_HUGE);
+	return __pte(pte_val(pte) | _PAGE_SPS);
 }
 
 #define pte_mkhuge pte_mkhuge
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 6582f824d620..134a573a9f2d 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -642,7 +642,7 @@ DTLBMissIMMR:
 	mtspr	SPRN_MD_TWC, r10
 	mfspr	r10, SPRN_IMMR			/* Get current IMMR */
 	rlwinm	r10, r10, 0, 0xfff80000		/* Get 512 kbytes boundary */
-	ori	r10, r10, 0xf0 | MD_SPS16K | _PAGE_PRIVILEGED | _PAGE_DIRTY | \
+	ori	r10, r10, 0xf0 | MD_SPS16K | _PAGE_SH | _PAGE_DIRTY | \
 			  _PAGE_PRESENT | _PAGE_NO_CACHE
 	mtspr	SPRN_MD_RPN, r10	/* Update TLB entry */
 
@@ -660,7 +660,7 @@ DTLBMissLinear:
 	li	r11, MD_PS8MEG | MD_SVALID | M_APG2
 	mtspr	SPRN_MD_TWC, r11
 	rlwinm	r10, r10, 0, 0x0f800000	/* 8xx supports max 256Mb RAM */
-	ori	r10, r10, 0xf0 | MD_SPS16K | _PAGE_PRIVILEGED | _PAGE_DIRTY | \
+	ori	r10, r10, 0xf0 | MD_SPS16K | _PAGE_SH | _PAGE_DIRTY | \
 			  _PAGE_PRESENT
 	mtspr	SPRN_MD_RPN, r10	/* Update TLB entry */
 
@@ -679,7 +679,7 @@ ITLBMissLinear:
 	li	r11, MI_PS8MEG | MI_SVALID | M_APG2
 	mtspr	SPRN_MI_TWC, r11
 	rlwinm	r10, r10, 0, 0x0f800000	/* 8xx supports max 256Mb RAM */
-	ori	r10, r10, 0xf0 | MI_SPS16K | _PAGE_PRIVILEGED | _PAGE_DIRTY | \
+	ori	r10, r10, 0xf0 | MI_SPS16K | _PAGE_SH | _PAGE_DIRTY | \
 			  _PAGE_PRESENT
 	mtspr	SPRN_MI_RPN, r10	/* Update TLB entry */
 
diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index 9137361d687d..36484a2ef915 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -67,7 +67,7 @@ void __init MMU_init_hw(void)
 	/* PIN up to the 3 first 8Mb after IMMR in DTLB table */
 #ifdef CONFIG_PIN_TLB_DATA
 	unsigned long ctr = mfspr(SPRN_MD_CTR) & 0xfe000000;
-	unsigned long flags = 0xf0 | MD_SPS16K | _PAGE_PRIVILEGED | _PAGE_DIRTY;
+	unsigned long flags = 0xf0 | MD_SPS16K | _PAGE_SH | _PAGE_DIRTY;
 #ifdef CONFIG_PIN_TLB_IMMR
 	int i = 29;
 #else
diff --git a/arch/powerpc/mm/dump_linuxpagetables-8xx.c b/arch/powerpc/mm/dump_linuxpagetables-8xx.c
index 33f52a97975b..ab9e3f24db2f 100644
--- a/arch/powerpc/mm/dump_linuxpagetables-8xx.c
+++ b/arch/powerpc/mm/dump_linuxpagetables-8xx.c
@@ -11,7 +11,7 @@
 
 static const struct flag_info flag_array[] = {
 	{
-		.mask	= _PAGE_PRIVILEGED,
+		.mask	= _PAGE_SH,
 		.val	= 0,
 		.set	= "user",
 		.clear	= "    ",
-- 
2.13.3

