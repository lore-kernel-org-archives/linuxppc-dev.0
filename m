Return-Path: <SRS0=pcIm=NN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17677C6786F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 04:41:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FE1B2081F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 04:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idA1Ho+j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FE1B2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42mTtM53J5zF36k
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 15:41:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="idA1Ho+j";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="idA1Ho+j"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42mTqn2wbkzF36j
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Nov 2018 15:39:16 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id p6-v6so399116pll.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Nov 2018 21:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=87MJpdLEngAxUeRin2Lp24yHbS+4XRxDVlHwAqjjgM0=;
 b=idA1Ho+jSietrgROeMSysOknuaE233jtREP9UJy49gxdMyyQKtOmT2fjNrqnQVrfG/
 oTZbAmHpGSPHC/8QTntjbsuUSy6bNnmez+CqOAq5Cre6ePdTEswIaW37D+ZiOS5wxV90
 SYywVZCxAV9ZssDM2Q3JG4wgj6qpp12uOJJbHh3AaEDRXOmoVTm9HvqKUv6D9sgKBFJP
 GdWTw8Ovr417BECZQIaCt0wWHzWOP/iC+Oeb16MEPqd2XHVTWGNeiUprwo1joBRDZtjc
 vUSodCw+Ua8DSxIOObTdX7PWpT2aGYCS7+uCWJ86PbLAcXAE+dlmhzkHxgbVn4rq1/om
 gYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=87MJpdLEngAxUeRin2Lp24yHbS+4XRxDVlHwAqjjgM0=;
 b=qttT0p/qEYOz5wyrCn/S22qbAEFRiY9wqGsQpPRgwvy707H6TvAan+TC4VfDTSwrY1
 lP7hmrU80OVnw0J1DueaXWwdTklQeCxZhI5AiE1q4nKCzK5xVCV+oVEpmvb4ZDO+cHLh
 cKx2DUgYIuylij2cC61LMjtcISr7nNHYMk3P3vVY0fqJ2w9CqjdqNo+421lrg/gdVRNd
 ++nP8M9vhjAHEskZa4f1RiCFgE5dp+eM3O9RNtmVyUWAV/lovWqBPN7YOfLEYyeooxIv
 +W8MOMsKU0K+8ug3YBtZQYj/rGM7GgspTCd2S/LL0dWuvgVvgxuEL43CRniRjMWsG+WR
 /TOg==
X-Gm-Message-State: AGRZ1gKBe4jdMcg3r8/Sy+pBYAdJeidV36gzEj5vVx9lPqonQXFP1Gjd
 N7no+IT661fs6oT2FYD2/P3Brj3U
X-Google-Smtp-Source: AJdET5d97Bqdhgadm9fJlZTjQxXobouB2n7bjSmIITi1KcOCC7vgq7rLZ81Rx+SjYCxWgjJJF96Uaw==
X-Received: by 2002:a17:902:14e:: with SMTP id
 72-v6mr10010850plb.299.1541133554686; 
 Thu, 01 Nov 2018 21:39:14 -0700 (PDT)
Received: from aurora.jms.id.au ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id s80-v6sm37134479pfa.114.2018.11.01.21.39.11
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 01 Nov 2018 21:39:13 -0700 (PDT)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Fri, 02 Nov 2018 15:09:07 +1030
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org, Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH] powerpc/32: Avoid unsupported flags with clang
Date: Fri,  2 Nov 2018 15:09:04 +1030
Message-Id: <20181102043904.2808-1-joel@jms.id.au>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When building for ppc32 with clang these flags are unsupported:

  -ffixed-r2 and -mmultiple

llvm's lib/Target/PowerPC/PPCRegisterInfo.cpp marks r2 as reserved on
when building for SVR4ABI and !ppc64:

  // The SVR4 ABI reserves r2 and r13
  if (Subtarget.isSVR4ABI()) {
    // We only reserve r2 if we need to use the TOC pointer. If we have no
    // explicit uses of the TOC pointer (meaning we're a leaf function with
    // no constant-pool loads, etc.) and we have no potential uses inside an
    // inline asm block, then we can treat r2 has an ordinary callee-saved
    // register.
    const PPCFunctionInfo *FuncInfo = MF.getInfo<PPCFunctionInfo>();
    if (!TM.isPPC64() || FuncInfo->usesTOCBasePtr() || MF.hasInlineAsm())
      markSuperRegs(Reserved, PPC::R2);  // System-reserved register
    markSuperRegs(Reserved, PPC::R13); // Small Data Area pointer register
  }

This means we can safely omit -ffixed-r2 when building for 32-bit
targets.

The -mmultiple/-mno-multiple flags are not supported by clang, so
platforms that might support multiple miss out on using multiple word
instructions.

Clang 8 can then build a ppc44x_defconfig which boots in Qemu:

  make CC=clang-8 ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu-  ppc44x_defconfig
  make CC=clang-8 ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu-

  qemu-system-ppc -M bamboo \
   -kernel arch/powerpc/boot/zImage \
   -dtb arch/powerpc/boot/dts/bamboo.dtb \
   -initrd ~/ppc32-440-rootfs.cpio \
   -nographic -serial stdio -monitor pty -append "console=ttyS0"

Link: https://github.com/ClangBuiltLinux/linux/issues/261
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
I considered putting these behind a cc-option test. If someone has an
opinion on that I'm happy to change.

 arch/powerpc/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 17be664dafa2..5fa678eee747 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -152,7 +152,9 @@ endif
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mcmodel=medium,$(call cc-option,-mminimal-toc))
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mno-pointers-to-nested-functions)
 
-CFLAGS-$(CONFIG_PPC32)	:= -ffixed-r2 $(MULTIPLEWORD)
+ifndef CONFIG_CC_IS_CLANG
+#CFLAGS-$(CONFIG_PPC32)	:= -ffixed-r2 $(MULTIPLEWORD)
+endif
 CFLAGS-$(CONFIG_PPC32)	+= $(call cc-option,-mno-readonly-in-sdata)
 
 ifdef CONFIG_PPC_BOOK3S_64
-- 
2.19.1

