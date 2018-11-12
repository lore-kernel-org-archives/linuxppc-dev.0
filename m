Return-Path: <SRS0=Ph+o=NX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36797C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 05:31:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B02D4216FD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 05:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7kt/Y4Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B02D4216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42tfWZ2sXdzF3TS
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 16:31:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f7kt/Y4Y";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="f7kt/Y4Y"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42tfRh5ClnzF3TS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 16:28:16 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id z17-v6so3516889pgv.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Nov 2018 21:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nqXjPzV+uhAhxTvNRXtXr7D9tjoD6z2Sa1Qvrclhhnw=;
 b=f7kt/Y4Y+y+U2wfnOFiorw8EuSwEl3p8vGJFhlJZBRCke+lBn1Ni3wjWpzaOUF0ao5
 8VdxIAt2BFPBiUoiWvF8OvbEk04erJUVs2wcXfE6rDNHm39io0NZIpgYJQRhQfKtSeRO
 FGgce/hVkvRZN8gPJqUiD3ZC5qO9W9dyFe0OAwSmVAREBFlKE+56PL1Hu0IWpwIQY1Cx
 9BA/vC5EsPJ68LVBSzEe/haE8YTjRt23zjNec6AlbISqXucML3/yd/IUPh7dqq+ohj51
 HBuK7ICjZQj+oChiDEVt0MrBpoLzrn9zztyV4w+4LgI96nO37jlISmSd6UIwKmdNgfsQ
 Sauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=nqXjPzV+uhAhxTvNRXtXr7D9tjoD6z2Sa1Qvrclhhnw=;
 b=YDFcunx2NmByNaoRyYUS634Bx26Hn/7N0DcAdrnS45h+CVGLhb8P9zrvN0Mg58N8YO
 jFwP3B2MrrVrFTei5/kIpqE1FkMualmAOWiJUAMfs/r6h4pYTuWwRZXdpZUDmBvCAlLm
 6C18CQ7NbehSwonqyN1dqLMogfstgoGKH5Arffhmes9uE6YbfKIAjfneucZnyUWAPg7Q
 ui4FpMyxI53UYbFZieeTQHgoO/H//a3k/+RaA3/zpzLa3tmVyRQCMt/iETpPxO9DCkbi
 cGHXuYQRpBOv/dcwIG1MN4wYJubOJwSvKhh3gbq5wZeV/GnD+siqL7EZQUpPNQdWLIEY
 xf0A==
X-Gm-Message-State: AGRZ1gLY/q8CHZDqomXrQOg77umZ4uE1j35RQ8NTcmBvjitrKPVuvBqE
 Fz1AbWvL3ee8qGu7vuYbgrCsno2f
X-Google-Smtp-Source: AJdET5fHwDZVwjfcmwY3rKXuc6fJ7gis6nVk5dQazre/UrTQNT3JnpUi9aDr/jwt+OCR3sqip4z7Bw==
X-Received: by 2002:a62:5e83:: with SMTP id
 s125-v6mr18541999pfb.232.1542000494124; 
 Sun, 11 Nov 2018 21:28:14 -0800 (PST)
Received: from aurora.jms.id.au ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id m10-v6sm27025557pfg.180.2018.11.11.21.28.11
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 11 Nov 2018 21:28:13 -0800 (PST)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Mon, 12 Nov 2018 15:58:07 +1030
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/32: Avoid unsupported flags with clang
Date: Mon, 12 Nov 2018 15:58:06 +1030
Message-Id: <20181112052806.18939-1-joel@jms.id.au>
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
Cc: Nick Desaulniers <ndesaulniers@google.com>
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

We wrap these flags in cc-option so that when Clang gains support the
kernel will be able use these flags.

Clang 8 can then build a ppc44x_defconfig which boots in Qemu:

  make CC=clang-8 ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu-  ppc44x_defconfig
  ./scripts/config -e CONFIG_DEVTMPFS -d DEVTMPFS_MOUNT
  make CC=clang-8 ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu-

  qemu-system-ppc -M bamboo \
   -kernel arch/powerpc/boot/zImage \
   -dtb arch/powerpc/boot/dts/bamboo.dtb \
   -initrd ~/ppc32-440-rootfs.cpio \
   -nographic -serial stdio -monitor pty -append "console=ttyS0"

Link: https://github.com/ClangBuiltLinux/linux/issues/261
Link: https://bugs.llvm.org/show_bug.cgi?id=39556
Link: https://bugs.llvm.org/show_bug.cgi?id=39555
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/powerpc/Makefile | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 8a2ce14d68d0..4685671dfb4f 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -152,7 +152,14 @@ endif
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mcmodel=medium,$(call cc-option,-mminimal-toc))
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mno-pointers-to-nested-functions)
 
-CFLAGS-$(CONFIG_PPC32)	:= -ffixed-r2 $(MULTIPLEWORD)
+# Clang unconditionally reserves r2 on ppc32 and does not support the flag
+# https://bugs.llvm.org/show_bug.cgi?id=39555
+CFLAGS-$(CONFIG_PPC32)	:= $(call cc-option, -ffixed-r2)
+
+# Clang doesn't support -mmultiple / -mno-multiple
+# https://bugs.llvm.org/show_bug.cgi?id=39556
+CFLAGS-$(CONFIG_PPC32)	+= $(call cc-option, $(MULTIPLEWORD))
+
 CFLAGS-$(CONFIG_PPC32)	+= $(call cc-option,-mno-readonly-in-sdata)
 
 ifdef CONFIG_PPC_BOOK3S_64
-- 
2.19.1

