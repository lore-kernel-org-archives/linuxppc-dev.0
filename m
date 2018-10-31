Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C71C6786F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 01:12:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2AFD2082B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 01:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2DIpTnR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2AFD2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42l9Kr5GX6zF2P4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 12:12:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C2DIpTnR";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="C2DIpTnR"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42l9Gx3XqszF1cK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 12:09:45 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id bb7-v6so6399731plb.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 18:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Y/aHLKfP04KRTXs5sn80en5K36ivXpunn7RcbndGFIw=;
 b=C2DIpTnRDqAaNl19whcaiV6VCAjEYRC9noCLMCJAYSieladzPqZfyrJT2yFXZsXWyJ
 uyId0D62fXV7EG56+eqAwb2MppY/UFGdlC59kAwU/+lJxmxHNOOwzc1UWxdm8CEPQRTr
 G9W555xueUQNs6j71fuiX4xFxSDvB/hmsObUGfLkMVmHySYXLcqMqwFC2eK/sxNqfvtR
 41SkmakjDPYyxU4tnwSge0T2QsqsD34uJdatsur0yWoOw7P1nwv4X9E9iiD+ZLb/K6Q5
 /q6J57Z0vIBjF93T49okGVxec5Y4iYZuOmF/sBSsfJElrSuJsQtj6iAxDV6Bp2xOk8HG
 YwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=Y/aHLKfP04KRTXs5sn80en5K36ivXpunn7RcbndGFIw=;
 b=dvfcE/741Ka6uhPwDu1o1tRv4ovbIffsJDHA2hO8tf/XgA610KRTIeWCZXEKkoY+IR
 zV5C6xzYXqVEI7U61AFnyMkbxkwy/CZ83I8dklz+AZGnu4QoKH9ALzpr6ZVAY8ivUknQ
 xcHiPzqjgOfBof9jHwDlLGsg7vxUMqV62Q2xN/i9RAhfZTDjxkz2GU2cxopW61KPdLoO
 LODedYWJFjuDE+0v0yO66rcKE7xYFuwefKHeexG5cDv7EXJsnSQZiMdZwm2u5iAKoJmB
 6CkzteVS9WgC3YuZzf4qmX4GHT0XtDhdF9zrRVQqI/YdjF6mWXIgcBPco2CBeImuYR2v
 r1Lw==
X-Gm-Message-State: AGRZ1gLgX2F1yanDCJGZ47E+q4W1wDXbblrCwAxYT5RbfxVgRBGgfbNT
 0kVnE0X+K6Psp6K0DP//IcA=
X-Google-Smtp-Source: AJdET5dkzsyKCWDd4ODp3Rd5oYME1u2PFtrNtnO1rWTKRZIiCfIUcfJEJGj1Q61VR2gI3br1xHpEyQ==
X-Received: by 2002:a17:902:bd91:: with SMTP id
 q17-v6mr1044739pls.105.1540948183247; 
 Tue, 30 Oct 2018 18:09:43 -0700 (PDT)
Received: from aurora.jms.id.au ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id s30-v6sm18584404pga.57.2018.10.30.18.09.39
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 30 Oct 2018 18:09:41 -0700 (PDT)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Wed, 31 Oct 2018 11:39:36 +1030
From: Joel Stanley <joel@jms.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/xmon: Relax frame size for clang
Date: Wed, 31 Oct 2018 11:39:34 +1030
Message-Id: <20181031010934.3627-1-joel@jms.id.au>
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

When building with clang (8 trunk, 7.0 release) the frame size limit is
hit:

 arch/powerpc/xmon/xmon.c:452:12: warning: stack frame size of 2576
 bytes in function 'xmon_core' [-Wframe-larger-than=]

Some investigation by Naveen indicates this is due to clang saving the
addresses to printf format strings on the stack.

While this issue is investigated, bump up the frame size limit for xmon
when building with clang.

Link: https://github.com/ClangBuiltLinux/linux/issues/252
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/powerpc/xmon/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/xmon/Makefile b/arch/powerpc/xmon/Makefile
index 69e7fb47bcaa..878f9c1d3615 100644
--- a/arch/powerpc/xmon/Makefile
+++ b/arch/powerpc/xmon/Makefile
@@ -11,6 +11,12 @@ UBSAN_SANITIZE := n
 ORIG_CFLAGS := $(KBUILD_CFLAGS)
 KBUILD_CFLAGS = $(subst $(CC_FLAGS_FTRACE),,$(ORIG_CFLAGS))
 
+ifdef CONFIG_CC_IS_CLANG
+# clang stores addresses on the stack causing the frame size to blow
+# out. See https://github.com/ClangBuiltLinux/linux/issues/252
+KBUILD_CFLAGS += -Wframe-larger-than=4096
+endif
+
 ccflags-$(CONFIG_PPC64) := $(NO_MINIMAL_TOC)
 
 obj-y			+= xmon.o nonstdio.o spr_access.o
-- 
2.19.1

