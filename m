Return-Path: <SRS0=Ph+o=NX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E3EC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 04:28:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 897DD21527
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 04:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZmY98PQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 897DD21527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42td6x6lyFzF3R4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 15:28:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aZmY98PQ";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="aZmY98PQ"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42tcz106C3zF3M6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 15:21:48 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id n4-v6so3671707plp.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Nov 2018 20:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0FWWRUwPZPf5wN0wtSRNRqcACmh2GKG5vi8Tr0gcNfI=;
 b=aZmY98PQb0RldgHAxuwhL46Le+nD2a1edqbVtacR9vAJSY+597Qfn/7sow4sFzptTh
 ZBPP5nNUtoa2ysWWmJtI9GdFdbdqYRydRe9SyibGOhkgLO0TPWOEW+jF4fnoaXMeE5DX
 Ayuape9EUDpCHNu1V2pK50OT6HmuX3Stug84qbCssg27/SJp+aBdMFuEz+y8r2lDt4I+
 ge6gkSR/SlDXuIOkjuj+CCdg2tOXD7uKEVWsSzdA0KCpOlMDjF0qBHlDWmKa91p/fws8
 fgvg/6GfGKxcGe9mtOV8COQW1qFUhZEfMzbbFmHfw6KRc4tUztnDPq1xJXx9g5ikKQcC
 eZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=0FWWRUwPZPf5wN0wtSRNRqcACmh2GKG5vi8Tr0gcNfI=;
 b=BLLnO7DpTh8/PbxveaUITvXX8FdLNmLzfbN1c4DHasWlVyBXDckzmJDLJL+Zh8Is+z
 VmLF3IqpkwXVFQ0rhFvltEL2z22Luyd29s8RzXQTr2ylCPkDqF2eXEl2A4u0RVG2wiql
 o+8iwXnfG6ZbgXwkeqnQdsFqLnhKBusL3JXrNEDMr5NI4E4Gr2d/e3/qsgrLdX+VxIbV
 smJ19eZzuS8airnTnt7+sdIC8IqYRuhPHaO6/QOLQsteF84KPUF1JoiI1sdGVdmNYiXC
 fVbX2AtrDLrBg++YgSRamrcg3lO640QHCwQ/sukVgM4VsNs05mEimUchdPplWGgA6f6Z
 ++3Q==
X-Gm-Message-State: AGRZ1gIq1qxPnrbhZU6Eg+nLYjt4JNccojLilh3rGZrSSAOjV/4yUgEz
 r7jIq71lkan5AT/RjLhlp6IA3Nav
X-Google-Smtp-Source: AJdET5dQVMWY2bcx8C0tiCJpNGgtCnNjIZh+sr9a29jsOegEU3BkMnABYSVtPWP1A0v85Qu9FR6eqA==
X-Received: by 2002:a17:902:1744:: with SMTP id
 i62-v6mr17717218pli.250.1541996506822; 
 Sun, 11 Nov 2018 20:21:46 -0800 (PST)
Received: from aurora.jms.id.au ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id g123-v6sm3314835pfc.155.2018.11.11.20.21.41
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 11 Nov 2018 20:21:46 -0800 (PST)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Mon, 12 Nov 2018 14:51:38 +1030
From: Joel Stanley <joel@jms.id.au>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 2/2] powerpc/boot: Set target when cross-compiling for clang
Date: Mon, 12 Nov 2018 14:51:16 +1030
Message-Id: <20181112042116.5271-3-joel@jms.id.au>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181112042116.5271-1-joel@jms.id.au>
References: <20181112042116.5271-1-joel@jms.id.au>
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
Cc: Michal Marek <michal.lkml@markovi.net>, linux-kbuild@vger.kernel.org,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Clang needs to be told which target it is building for when cross
compiling.

Link: https://github.com/ClangBuiltLinux/linux/issues/259
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/powerpc/boot/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 39354365f54a..111f97b1ccec 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -55,6 +55,11 @@ BOOTAFLAGS	:= -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional -nostdinc
 
 BOOTARFLAGS	:= -cr$(KBUILD_ARFLAGS)
 
+ifdef CONFIG_CC_IS_CLANG
+BOOTCFLAGS += $(CLANG_FLAGS)
+BOOTAFLAGS += $(CLANG_FLAGS)
+endif
+
 ifdef CONFIG_DEBUG_INFO
 BOOTCFLAGS	+= -g
 endif
-- 
2.19.1

