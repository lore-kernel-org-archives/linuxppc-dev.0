Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D12EC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 15:38:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB5E620685
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 15:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB5E620685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43b9Bg5TNRzDqq0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 02:38:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43b8cD5vr6zDqjv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 02:12:12 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43b8c82Mvmz9v0fG;
 Thu, 10 Jan 2019 16:12:08 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id Phh_-gWp3-bK; Thu, 10 Jan 2019 16:12:08 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43b8c81sC0z9v0f8;
 Thu, 10 Jan 2019 16:12:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id BA6CA8B8A0;
 Thu, 10 Jan 2019 16:12:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 8urukiNxpEue; Thu, 10 Jan 2019 16:12:09 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7D0F18B89F;
 Thu, 10 Jan 2019 16:12:09 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 2F0BD6BF21; Thu, 10 Jan 2019 15:12:09 +0000 (UTC)
Message-Id: <505e1dbe9c874a7642efddcf0446229d37b05c95.1547132682.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1547132681.git.christophe.leroy@c-s.fr>
References: <cover.1547132681.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 15/15] powerpc/kconfig: make _etext and data areas
 alignment configurable on 8xx
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 j.neuschaefer@gmx.net
Date: Thu, 10 Jan 2019 15:12:09 +0000 (UTC)
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

On 8xx, large pages (512kb or 8M) are used to map kernel linear
memory. Aligning to 8M reduces TLB misses as only 8M pages are used
in that case.

This patchs allows the user to do it via Kconfig.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig           | 16 ++++++++++++++--
 arch/powerpc/kernel/head_8xx.S |  4 ++--
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 18744290c078..4f09150c92f5 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -732,7 +732,8 @@ config THREAD_SHIFT
 	  want. Only change this if you know what you are doing.
 
 config ETEXT_SHIFT_BOOL
-	bool "Set custom etext alignment" if STRICT_KERNEL_RWX && PPC_BOOK3S_32
+	bool "Set custom etext alignment" if STRICT_KERNEL_RWX && \
+					     (PPC_BOOK3S_32 || PPC_8xx)
 	depends on ADVANCED_OPTIONS
 	help
 	  This option allows you to set the kernel end of text alignment. When
@@ -744,6 +745,7 @@ config ETEXT_SHIFT_BOOL
 config ETEXT_SHIFT
 	int "_etext shift" if ETEXT_SHIFT_BOOL
 	range 17 28 if STRICT_KERNEL_RWX && PPC_BOOK3S_32
+	range 19 23 if STRICT_KERNEL_RWX && PPC_8xx
 	default 17 if STRICT_KERNEL_RWX && PPC_BOOK3S_32
 	default 19 if STRICT_KERNEL_RWX && PPC_8xx
 	default PPC_PAGE_SHIFT
@@ -751,8 +753,13 @@ config ETEXT_SHIFT
 	  On Book3S 32 (603+), IBATs are used to map kernel text.
 	  Smaller is the alignment, greater is the number of necessary IBATs.
 
+	  On 8xx, large pages (512kb or 8M) are used to map kernel linear
+	  memory. Aligning to 8M reduces TLB misses as only 8M pages are used
+	  in that case.
+
 config DATA_SHIFT_BOOL
-	bool "Set custom data alignment" if STRICT_KERNEL_RWX && PPC_BOOK3S_32
+	bool "Set custom data alignment" if STRICT_KERNEL_RWX && \
+					    (PPC_BOOK3S_32 || PPC_8xx)
 	depends on ADVANCED_OPTIONS
 	help
 	  This option allows you to set the kernel data alignment. When
@@ -765,6 +772,7 @@ config DATA_SHIFT
 	int "Data shift" if DATA_SHIFT_BOOL
 	default 24 if STRICT_KERNEL_RWX && PPC64
 	range 17 28 if STRICT_KERNEL_RWX && PPC_BOOK3S_32
+	range 19 23 if STRICT_KERNEL_RWX && PPC_8xx
 	default 22 if STRICT_KERNEL_RWX && PPC_BOOK3S_32
 	default 19 if STRICT_KERNEL_RWX && PPC_8xx
 	default PPC_PAGE_SHIFT
@@ -772,6 +780,10 @@ config DATA_SHIFT
 	  On Book3S 32 (603+), DBATs are used to map kernel text and rodata RO.
 	  Smaller is the alignment, greater is the number of necessary DBATs.
 
+	  On 8xx, large pages (512kb or 8M) are used to map kernel linear
+	  memory. Aligning to 8M reduces TLB misses as only 8M pages are used
+	  in that case.
+
 config FORCE_MAX_ZONEORDER
 	int "Maximum zone order"
 	range 8 9 if PPC64 && PPC_64K_PAGES
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index f095c3c18455..dc7c8be8d9da 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -405,7 +405,7 @@ InstructionTLBMiss:
 #ifndef CONFIG_PIN_TLB_TEXT
 ITLBMissLinear:
 	mtcr	r11
-#ifdef CONFIG_STRICT_KERNEL_RWX
+#if defined(CONFIG_STRICT_KERNEL_RWX) && CONFIG_ETEXT_SHIFT < 23
 	patch_site	0f, patch__itlbmiss_linmem_top8
 
 	mfspr	r10, SPRN_SRR0
@@ -536,7 +536,7 @@ DTLBMissIMMR:
 DTLBMissLinear:
 	mtcr	r11
 	rlwinm	r10, r10, 20, 0x0f800000	/* 8xx supports max 256Mb RAM */
-#ifdef CONFIG_STRICT_KERNEL_RWX
+#if defined(CONFIG_STRICT_KERNEL_RWX) && CONFIG_DATA_SHIFT < 23
 	patch_site	0f, patch__dtlbmiss_romem_top8
 
 0:	subis	r11, r10, (PAGE_OFFSET - 0x80000000)@ha
-- 
2.13.3

