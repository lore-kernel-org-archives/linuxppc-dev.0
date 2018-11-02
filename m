Return-Path: <SRS0=pcIm=NN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3882CC6786F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 03:39:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CC6120657
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 03:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQaqDs/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CC6120657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42mSW96g0kzF370
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 14:39:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BQaqDs/j";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="BQaqDs/j"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42mSSS4G3JzF36h
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Nov 2018 14:37:24 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id i62-v6so365147pfi.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Nov 2018 20:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SO4qFyNtZRAyRYcxf8bVasvG8JLeMITXAit0RIpL1wg=;
 b=BQaqDs/jT3LZROR97SJkD5usPu4SORJ0sTfWHKknM1j181MAJc+GRLpZ95y7g+ZPn8
 7YVVu1KdkE+r+uQDjKjBFKzstknquRr9ZF8G3vgiqQuDebwNx+l1fjX7y4iSpVVKXK50
 daj6kf42oD86xBGMISxtvG8lfXiCPjG4XdinFMCH6a7D410rFngDxEG9F39+LCUJBdKk
 n20B23Z9ou10E8uVzBH3C7njM2lToJcvNE/bQ3AR79wDgFE9cMKST7rBMnAdhn5RYJlg
 16ebMUovRGsIJcC8XDKSuhnx8dZMkB3M42VkMmWOn6B9XeCkMF2ZYS/NflzIJpQJBzeu
 lrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=SO4qFyNtZRAyRYcxf8bVasvG8JLeMITXAit0RIpL1wg=;
 b=LfFJhPT7763Y56eM6PB8e11xnutJN2XETicfHVWiKOujzTQTTzYd6gAr2F+PDAwnuT
 ADLQYTF/p7cifD4hxK71WUyk8+bYHBzasLaA9ulDttiYJgJ8Ue8uuJNTfAVo3oX83PxE
 SSxuTCNQGacuj0wvJYJ79oOdLYiqVnC2CLygBxR1O23Lk/PDGCu1kA8c+MwSml3Hl5Ak
 kx5lH6LSatEbMnTyfuAfTA9JmHqdp2iqjFbv1m73mctzPl18xJG+3X+bbCpNWX+K0CI+
 8B/Q7vGflWQ/Qgb1Cy4oPls+lfywyZBp6BOSfZjAjvVPN1wZaY4Lb7i/CzNo9CAMuvnR
 W+MA==
X-Gm-Message-State: AGRZ1gLlQ84o7l7RoAP+CbHVNPI0iLtVnkboXziOZaLP10cL33aag8ul
 t7d9VHJvg22C1dLXSO7aKWjdaK9d
X-Google-Smtp-Source: AJdET5cqzgbnN6JaCziE9sp3i4RN0AuQjyw8O7Ivgt5hor+4CvlTnMGEFmEoHXRZ8uPMinxvU+FEgg==
X-Received: by 2002:a62:5ac3:: with SMTP id
 o186-v6mr10534647pfb.40.1541129842276; 
 Thu, 01 Nov 2018 20:37:22 -0700 (PDT)
Received: from aurora.jms.id.au ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id 74-v6sm48087788pfx.182.2018.11.01.20.37.18
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 01 Nov 2018 20:37:21 -0700 (PDT)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Fri, 02 Nov 2018 14:07:15 +1030
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/math-emu: Fix building with clang
Date: Fri,  2 Nov 2018 14:07:13 +1030
Message-Id: <20181102033713.31916-1-joel@jms.id.au>
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

  make CC=clang-8 ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu-  ppc44x_defconfig
  make CC=clang-8 ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu-

  ...

  arch/powerpc/math-emu/fnmsub.c:46:2: error: invalid use of a cast in a
  inline asm context requiring an l-value: remove the cast or build with
  -fheinous-gnu-extensions
          FP_ADD_D(R, T, B);
          ^~~~~~~~~~~~~~~~~
  ./include/math-emu/double.h:110:27: note: expanded from macro 'FP_ADD_D'
  #define FP_ADD_D(R,X,Y)                 _FP_ADD(D,2,R,X,Y)
                                          ^~~~~~~~~~~~~~~~~~
  ./include/math-emu/op-common.h:367:34: note: expanded from macro '_FP_ADD'
  #define _FP_ADD(fs, wc, R, X, Y) _FP_ADD_INTERNAL(fs, wc, R, X, Y, '+')
                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ./include/math-emu/op-common.h:264:4: note: expanded from macro '_FP_ADD_INTERNAL'
            _FP_FRAC_ADD_##wc(R, X, Y);                                        \
            ^~~~~~~~~~~~~~~~~~~~~~~~~~
  note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
  ./include/math-emu/op-2.h:94:27: note: expanded from macro '_FP_FRAC_ADD_2'
    __FP_FRAC_ADD_2(R##_f1, R##_f0, X##_f1, X##_f0, Y##_f1, Y##_f0)
    ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Link: https://github.com/ClangBuiltLinux/linux/issues/260
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/powerpc/math-emu/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/math-emu/Makefile b/arch/powerpc/math-emu/Makefile
index 494df26c5988..b9cb797445ac 100644
--- a/arch/powerpc/math-emu/Makefile
+++ b/arch/powerpc/math-emu/Makefile
@@ -18,3 +18,7 @@ CFLAGS_fabs.o = -fno-builtin-fabs
 CFLAGS_math.o = -fno-builtin-fabs
 
 ccflags-y = -I. -Iinclude/math-emu -w
+
+ifdef CONFIG_CC_IS_CLANG
+ccflags-y += -fheinous-gnu-extensions
+endif
-- 
2.19.1

