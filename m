Return-Path: <SRS0=KHR7=NP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD17ECDE44
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Nov 2018 23:18:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79A192082D
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Nov 2018 23:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzgzJlJX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A192082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42pBZY0zzkzDrP4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 10:18:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jzgzJlJX";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="jzgzJlJX"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42pBR56SGWzDrPg
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Nov 2018 10:12:17 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id z10so1445743pgp.7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Nov 2018 15:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UpNAPKimz1my7YVFzTj+MgOPaV27toX8fTxUd9TBuTE=;
 b=jzgzJlJX/qfXtaRGtaTlkLG1juQ+83tLMdAYz7BTO7biw8rUNMsz/upQxTFL6cuezV
 l1Uo4i+PkJ/T0q0E4zAdlHuctra15I9aREmowH/dIqqZuhABT7DbEIV9sVLkyJkkjzKY
 CCHg7zep0+GDimeKRdhPKauysEJh4l7mdI3/X5cUPzw3c1E6/rCey6LHok3pn3b+auS/
 D6dAIHtuVJ8CseQe4TmOrGDJmH99ETXjC2kWSmORq4SU/hrR/1qkksBB1BKvjnRYM3+m
 IAfBnBYjLJVkBqRYF5INWOvut1BMn+tlxnT1wPQmET9GMNT5QA3tS8dTlHiA6npJeGkx
 kJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=UpNAPKimz1my7YVFzTj+MgOPaV27toX8fTxUd9TBuTE=;
 b=fuO+OK9/b0v1CDukgcU2jWu1M1lkDjGxX/lCWGhexcuILj0GGOEKYOqnEWk3FYKk78
 SVk5MzeeL8R2DBrNVraB+n26WoFOgwqqwMqU+wOTB6wtvKGLLcr5KYt/7e1LAsvXTMgD
 76S2i5auAuexPu2zpxOgbwOAGZhHtafZbYknRn8x4uDUhdKeDcPt7WXXsMzpQJhkLVCK
 eeWCQEir+2MI+0Z/INHHIWsJrzMtX7kKglas+wDo2CG91tdAY2dZ40dyhERnow2i/vQw
 r5yfd/FLGsGVLKtB3xhT7ge8q2Rkey3k+dZ0ZEyH97uHL02CdYD1q2ITPiTBgHXSq8IX
 czuQ==
X-Gm-Message-State: AGRZ1gIFW0NArId4lG3rpDwU64F+NJZ8ZT7EZAzRMCaJX9+/LtLgSv1j
 reeOmAJs+KEVy6EdRp2QmMk=
X-Google-Smtp-Source: AJdET5drI1g+j4nUcrlzMnpH0ujnY37mrNpHJZpV7v1qFPLkku6SpnghRSEAQ7ynsIyFYYhIvy6TzA==
X-Received: by 2002:a62:5d49:: with SMTP id
 r70-v6mr20112960pfb.123.1541373135917; 
 Sun, 04 Nov 2018 15:12:15 -0800 (PST)
Received: from aurora.jms.id.au (pa49-178-43-40.pa.nsw.optusnet.com.au.
 [49.178.43.40])
 by smtp.gmail.com with ESMTPSA id z8sm286467pgz.53.2018.11.04.15.12.10
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 04 Nov 2018 15:12:15 -0800 (PST)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Mon, 05 Nov 2018 09:42:04 +1030
From: Joel Stanley <joel@jms.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 2/2] powerpc/boot: Set target when cross-compiling for clang
Date: Mon,  5 Nov 2018 09:41:33 +1030
Message-Id: <20181104231133.30848-3-joel@jms.id.au>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181104231133.30848-1-joel@jms.id.au>
References: <20181104231133.30848-1-joel@jms.id.au>
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
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michal Marek <michal.lkml@markovi.net>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Clang needs to be told which target it is building for when cross
compiling.

Link: https://github.com/ClangBuiltLinux/linux/issues/259
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/powerpc/boot/Makefile | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 39354365f54a..8fdb1890f09a 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -55,6 +55,13 @@ BOOTAFLAGS	:= -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional -nostdinc
 
 BOOTARFLAGS	:= -cr$(KBUILD_ARFLAGS)
 
+ifdef CONFIG_CC_IS_CLANG
+BOOTCFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
+BOOTAFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
+BOOTCFLAGS += $(call cc-option, -no-integrated-as)
+BOOTAFLAGS += $(call cc-option, -no-integrated-as)
+endif
+
 ifdef CONFIG_DEBUG_INFO
 BOOTCFLAGS	+= -g
 endif
-- 
2.19.1

