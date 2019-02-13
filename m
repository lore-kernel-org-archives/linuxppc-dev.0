Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1F3C282C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 16:09:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6F0B218D3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 16:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Q9hEMKYZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6F0B218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4404GT6kf2zDqRf
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 03:09:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="Q9hEMKYZ"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4404C54QyMzDqGv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 03:06:25 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4404C05JsFz9vKHt;
 Wed, 13 Feb 2019 17:06:20 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=Q9hEMKYZ; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id yCGx1A9PKAZ7; Wed, 13 Feb 2019 17:06:20 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4404C04HFpz9vKHr;
 Wed, 13 Feb 2019 17:06:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1550073980; bh=YENrTdZmjRUQzznsCocFVOEf27q2NU6laX+CVp49Qwk=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=Q9hEMKYZFJIIe5jotB1jmSVsne04ZjiZcngjYsaJc/vpgUnqwSwS705Mn8qcAJyBn
 WxRVjYKA9ULNkwORGKyBQH822F7gV9YMge/4nadzf3gKd2QPcpicTjYjML/ifux6pH
 1vYOxJvKL6J6NKJjIy4e5uvLS553mtgDvgIbC8mc=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 289568B876;
 Wed, 13 Feb 2019 17:06:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id HM3eYe_1KKhk; Wed, 13 Feb 2019 17:06:22 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 0340F8B756;
 Wed, 13 Feb 2019 17:06:22 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id EAAA769D7C; Wed, 13 Feb 2019 16:06:21 +0000 (UTC)
Message-Id: <c1fee958acabcfadcab6cb2c07f04fd395583e88.1550073540.git.christophe.leroy@c-s.fr>
In-Reply-To: <21f171c0cbd460905a134ce9b9afc2ecb5277269.1550073540.git.christophe.leroy@c-s.fr>
References: <21f171c0cbd460905a134ce9b9afc2ecb5277269.1550073540.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 2/2] powerpc/8xx: Map 32Mb of RAM at init.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 13 Feb 2019 16:06:21 +0000 (UTC)
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

At the time being, initial MMU setup allows 24 Mbytes
of DATA and 8 Mbytes of code.

Some debug setup like CONFIG_KASAN generate huge
kernels with text size over the 8M limit and data over the
24 Mbytes limit.

Here is an 8xx kernel compiled with CONFIG_KASAN_INLINE for
one of my boards:

[root@po16846vm linux-powerpc]# size -x vmlinux
   text	   data	    bss	    dec	    hex	filename
0x111019c	0x41b0d4	0x490de0	26984528	19bc050	vmlinux

This patch maps up to 32 Mbytes code based on _einittext symbol
and allows 32 Mbytes of memory instead of 24.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v3: Maps 32M of both data and text.

 v2: Using IS_ENABLED() instead of #ifdef in 8xx_mmu.c

 arch/powerpc/kernel/head_8xx.S | 51 +++++++++++++++++++++++++-----------------
 arch/powerpc/mm/8xx_mmu.c      |  7 ++++--
 2 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 20cc816b3508..fe2857ef0309 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -337,8 +337,8 @@ InstructionTLBMiss:
 	rlwinm	r10, r10, 16, 0xfff8
 	cmpli	cr0, r10, PAGE_OFFSET@h
 #ifndef CONFIG_PIN_TLB_TEXT
-	/* It is assumed that kernel code fits into the first 8M page */
-0:	cmpli	cr7, r10, (PAGE_OFFSET + 0x0800000)@h
+	/* It is assumed that kernel code fits into the first 32M */
+0:	cmpli	cr7, r10, (PAGE_OFFSET + 0x2000000)@h
 	patch_site	0b, patch__itlbmiss_linmem_top
 #endif
 #endif
@@ -434,7 +434,7 @@ DataStoreTLBMiss:
 #ifndef CONFIG_PIN_TLB_IMMR
 	cmpli	cr6, r10, VIRT_IMMR_BASE@h
 #endif
-0:	cmpli	cr7, r10, (PAGE_OFFSET + 0x1800000)@h
+0:	cmpli	cr7, r10, (PAGE_OFFSET + 0x2000000)@h
 	patch_site	0b, patch__dtlbmiss_linmem_top
 
 	mfspr	r10, SPRN_M_TWB	/* Get level 1 table */
@@ -886,28 +886,11 @@ initial_mmu:
 	mtspr	SPRN_MD_CTR, r10	/* remove PINNED DTLB entries */
 
 	tlbia			/* Invalidate all TLB entries */
-#ifdef CONFIG_PIN_TLB_TEXT
-	lis	r8, MI_RSV4I@h
-	ori	r8, r8, 0x1c00
-
-	mtspr	SPRN_MI_CTR, r8	/* Set instruction MMU control */
-#endif
-
 #ifdef CONFIG_PIN_TLB_DATA
 	oris	r10, r10, MD_RSV4I@h
 	mtspr	SPRN_MD_CTR, r10	/* Set data TLB control */
 #endif
 
-	/* Now map the lower 8 Meg into the ITLB. */
-	lis	r8, KERNELBASE@h	/* Create vaddr for TLB */
-	ori	r8, r8, MI_EVALID	/* Mark it valid */
-	mtspr	SPRN_MI_EPN, r8
-	li	r8, MI_PS8MEG /* Set 8M byte page */
-	ori	r8, r8, MI_SVALID	/* Make it valid */
-	mtspr	SPRN_MI_TWC, r8
-	li	r8, MI_BOOTINIT		/* Create RPN for address 0 */
-	mtspr	SPRN_MI_RPN, r8		/* Store TLB entry */
-
 	lis	r8, MI_APG_INIT@h	/* Set protection modes */
 	ori	r8, r8, MI_APG_INIT@l
 	mtspr	SPRN_MI_AP, r8
@@ -937,6 +920,34 @@ initial_mmu:
 	mtspr	SPRN_MD_RPN, r8
 #endif
 
+	/* Now map the lower RAM (up to 32 Mbytes) into the ITLB. */
+#ifdef CONFIG_PIN_TLB_TEXT
+	lis	r8, MI_RSV4I@h
+	ori	r8, r8, 0x1c00
+#endif
+	li	r9, 4				/* up to 4 pages of 8M */
+	mtctr	r9
+	lis	r9, KERNELBASE@h		/* Create vaddr for TLB */
+	li	r10, MI_PS8MEG | MI_SVALID	/* Set 8M byte page */
+	li	r11, MI_BOOTINIT		/* Create RPN for address 0 */
+	lis	r12, _einittext@h
+	ori	r12, r12, _einittext@l
+1:
+#ifdef CONFIG_PIN_TLB_TEXT
+	mtspr	SPRN_MI_CTR, r8	/* Set instruction MMU control */
+	addi	r8, r8, 0x100
+#endif
+
+	ori	r0, r9, MI_EVALID		/* Mark it valid */
+	mtspr	SPRN_MI_EPN, r0
+	mtspr	SPRN_MI_TWC, r10
+	mtspr	SPRN_MI_RPN, r11		/* Store TLB entry */
+	addis	r9, r9, 0x80
+	addis	r11, r11, 0x80
+
+	cmpl	cr0, r9, r12
+	bdnzf	gt, 1b
+
 	/* Since the cache is enabled according to the information we
 	 * just loaded into the TLB, invalidate and enable the caches here.
 	 * We should probably check/set other modes....later.
diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index 92b677faea8c..50c8cd8d3cb9 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -112,6 +112,9 @@ unsigned long __init mmu_mapin_ram(unsigned long top)
 			mmu_patch_cmp_limit(&patch__itlbmiss_linmem_top, 0);
 	} else {
 		mapped = top & ~(LARGE_PAGE_SIZE_8M - 1);
+		if (!IS_ENABLED(CONFIG_PIN_TLB_TEXT))
+			mmu_patch_cmp_limit(&patch__itlbmiss_linmem_top,
+					    _ALIGN(__pa(_einittext), 8 << 20));
 	}
 
 	mmu_patch_cmp_limit(&patch__dtlbmiss_linmem_top, mapped);
@@ -140,8 +143,8 @@ void __init setup_initial_memory_limit(phys_addr_t first_memblock_base,
 	 */
 	BUG_ON(first_memblock_base != 0);
 
-	/* 8xx can only access 24MB at the moment */
-	memblock_set_current_limit(min_t(u64, first_memblock_size, 0x01800000));
+	/* 8xx can only access 32MB at the moment */
+	memblock_set_current_limit(min_t(u64, first_memblock_size, 0x02000000));
 }
 
 /*
-- 
2.13.3

