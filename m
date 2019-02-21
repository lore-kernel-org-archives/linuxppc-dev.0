Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CB7C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 19:37:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D04C2077B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 19:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="VaqE2geA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D04C2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4454Vc4kNjzDqDx
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 06:37:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="VaqE2geA"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4453t03FwvzDqRp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 06:08:56 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4453sx2XJLz9v9DH;
 Thu, 21 Feb 2019 20:08:53 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=VaqE2geA; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 8AiBhz-sgqYT; Thu, 21 Feb 2019 20:08:53 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4453sx1Qfdz9v9DG;
 Thu, 21 Feb 2019 20:08:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1550776133; bh=QyluC/3wRlKw8Mq1z/4mj/rTBv2DhqiZpxBqmcvCH1s=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=VaqE2geAiEsAQPP5GlaIds9R6cMXG9DsuubWFKJsdPaAK77JItwymv9CYtAFTaSzN
 /Yf8vSsDvmby+HQptmfjkQPKyCC115D/O6tQYAR0t66NJNIZ68laQmz/L7I8Qpmk2u
 o8i5S/DWHMqFqpIIESLFlgIxqRcDyvogETmjLoEs=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 362798B86A;
 Thu, 21 Feb 2019 20:08:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id V_HV48MlqOfD; Thu, 21 Feb 2019 20:08:53 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id F2F698B852;
 Thu, 21 Feb 2019 20:08:52 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id BE4F76EF61; Thu, 21 Feb 2019 19:08:52 +0000 (UTC)
Message-Id: <9f81d57c0c61d21f58293e8d82b101f6775e9b3e.1550775950.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1550775950.git.christophe.leroy@c-s.fr>
References: <cover.1550775950.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 16/16] powerpc/kconfig: make _etext and data areas
 alignment configurable on 8xx
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 j.neuschaefer@gmx.net
Date: Thu, 21 Feb 2019 19:08:52 +0000 (UTC)
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
in that case. We make 8M the default for data.

This patchs allows the user to do it via Kconfig.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig           | 18 +++++++++++++++---
 arch/powerpc/kernel/head_8xx.S |  4 ++--
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c4d6c97d7699..cf30a8f522b9 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -726,7 +726,8 @@ config THREAD_SHIFT
 	  want. Only change this if you know what you are doing.
 
 config ETEXT_SHIFT_BOOL
-	bool "Set custom etext alignment" if STRICT_KERNEL_RWX && PPC_BOOK3S_32
+	bool "Set custom etext alignment" if STRICT_KERNEL_RWX && \
+					     (PPC_BOOK3S_32 || PPC_8xx)
 	depends on ADVANCED_OPTIONS
 	help
 	  This option allows you to set the kernel end of text alignment. When
@@ -738,6 +739,7 @@ config ETEXT_SHIFT_BOOL
 config ETEXT_SHIFT
 	int "_etext shift" if ETEXT_SHIFT_BOOL
 	range 17 28 if STRICT_KERNEL_RWX && PPC_BOOK3S_32
+	range 19 23 if STRICT_KERNEL_RWX && PPC_8xx
 	default 17 if STRICT_KERNEL_RWX && PPC_BOOK3S_32
 	default 19 if STRICT_KERNEL_RWX && PPC_8xx
 	default PPC_PAGE_SHIFT
@@ -745,8 +747,13 @@ config ETEXT_SHIFT
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
@@ -759,13 +766,18 @@ config DATA_SHIFT
 	int "Data shift" if DATA_SHIFT_BOOL
 	default 24 if STRICT_KERNEL_RWX && PPC64
 	range 17 28 if STRICT_KERNEL_RWX && PPC_BOOK3S_32
+	range 19 23 if STRICT_KERNEL_RWX && PPC_8xx
 	default 22 if STRICT_KERNEL_RWX && PPC_BOOK3S_32
-	default 19 if STRICT_KERNEL_RWX && PPC_8xx
+	default 23 if STRICT_KERNEL_RWX && PPC_8xx
 	default PPC_PAGE_SHIFT
 	help
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
index 01ed8f3c95c8..63f1b7eec3f0 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -416,7 +416,7 @@ InstructionTLBMiss:
 #ifndef CONFIG_PIN_TLB_TEXT
 ITLBMissLinear:
 	mtcr	r11
-#ifdef CONFIG_STRICT_KERNEL_RWX
+#if defined(CONFIG_STRICT_KERNEL_RWX) && CONFIG_ETEXT_SHIFT < 23
 	patch_site	0f, patch__itlbmiss_linmem_top8
 
 	mfspr	r10, SPRN_SRR0
@@ -537,7 +537,7 @@ DTLBMissIMMR:
 DTLBMissLinear:
 	mtcr	r11
 	rlwinm	r10, r10, 20, 0x0f800000	/* 8xx supports max 256Mb RAM */
-#ifdef CONFIG_STRICT_KERNEL_RWX
+#if defined(CONFIG_STRICT_KERNEL_RWX) && CONFIG_DATA_SHIFT < 23
 	patch_site	0f, patch__dtlbmiss_romem_top8
 
 0:	subis	r11, r10, (PAGE_OFFSET - 0x80000000)@ha
-- 
2.13.3

