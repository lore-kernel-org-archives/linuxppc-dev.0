Return-Path: <SRS0=FZqe=NR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B392C0044C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 03:08:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D04032081D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 03:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="bazDBYFf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D04032081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42pvdh3dCzzF35y
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 14:08:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="bazDBYFf";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.76; helo=conuserg-09.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="bazDBYFf"; 
 dkim-atps=neutral
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42pvb16c6ZzF35n
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2018 14:06:37 +1100 (AEDT)
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp
 [153.142.97.92]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id wA635Mp2025438;
 Tue, 6 Nov 2018 12:05:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com wA635Mp2025438
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1541473524;
 bh=1+BFxkaRJrjARU/GhxBmY3HEDiOtKleHWhuKBQ9VCEE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bazDBYFf/fLxanBbDMmWZm0TVTNGgnIONdWRlQA2PS2kGPaamgVRgGYmeEfyqRYEb
 6R1nNrYuVHJ6bVdGEBxyIp32WdqB5RyaT19n7QkMYpUCh0A2THp5iMvf6kjIA24sPm
 hUN7TSvYaoC0mFCIdXGGPgwoHIft96zYMa4KXQNgeDox2rXdwE8jDu/t8pzoS38P7p
 Mv1I9AGb17xpnMwI9jeZur+USMq9L1fxVOOWniR5SkE7WwY7oFHOzyTPGvg0dwRYfE
 yaZWT+SyH7nuaFSBLi0sqxSlJT4f75ZKAAlM9R+wwSDVjLAMmuPwCLmeBS/sNrx4bp
 wcWnVDLoaB2EQ==
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Subject: [PATCH v2 2/2] kbuild: consolidate Clang compiler flags
Date: Tue,  6 Nov 2018 12:04:55 +0900
Message-Id: <1541473495-25262-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541473495-25262-1-git-send-email-yamada.masahiro@socionext.com>
References: <1541473495-25262-1-git-send-email-yamada.masahiro@socionext.com>
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
Cc: Michal Marek <michal.lkml@markovi.net>,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 Stefan Agner <stefan@agner.ch>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Matthias Kaehlcke <mka@chromium.org>, Joel Stanley <joel@jms.id.au>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Collect basic Clang options such as --target, --prefix, --gcc-toolchain,
-no-integrated-as into a single variable CLANG_FLAGS so that it can be
easily reused in other parts of Makefile.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
 - Use := flavor instead of = because $(CLANG_FLAGS) is expanded soon anyway

 Makefile | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index da11700..e173a73 100644
--- a/Makefile
+++ b/Makefile
@@ -487,18 +487,17 @@ endif
 
 ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
 ifneq ($(CROSS_COMPILE),)
-CLANG_TARGET	:= --target=$(notdir $(CROSS_COMPILE:%-=%))
+CLANG_FLAGS	:= --target=$(notdir $(CROSS_COMPILE:%-=%))
 GCC_TOOLCHAIN_DIR := $(dir $(shell which $(LD)))
-CLANG_PREFIX	:= --prefix=$(GCC_TOOLCHAIN_DIR)
+CLANG_FLAGS	+= --prefix=$(GCC_TOOLCHAIN_DIR)
 GCC_TOOLCHAIN	:= $(realpath $(GCC_TOOLCHAIN_DIR)/..)
 endif
 ifneq ($(GCC_TOOLCHAIN),)
-CLANG_GCC_TC	:= --gcc-toolchain=$(GCC_TOOLCHAIN)
+CLANG_FLAGS	+= --gcc-toolchain=$(GCC_TOOLCHAIN)
 endif
-KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
-KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
-KBUILD_CFLAGS += -no-integrated-as
-KBUILD_AFLAGS += -no-integrated-as
+CLANG_FLAGS	+= -no-integrated-as
+KBUILD_CFLAGS	+= $(CLANG_FLAGS)
+KBUILD_AFLAGS	+= $(CLANG_FLAGS)
 endif
 
 RETPOLINE_CFLAGS_GCC := -mindirect-branch=thunk-extern -mindirect-branch-register
-- 
2.7.4

