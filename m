Return-Path: <SRS0=wfc/=E2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5820AC2D0E4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2020 22:46:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31B1F2236F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2020 22:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="hEAHv6+6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B1F2236F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CdBVN4fqtzDr2j
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Nov 2020 09:46:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--morbo.bounces.google.com
 (client-ip=2607:f8b0:4864:20::449; helo=mail-pf1-x449.google.com;
 envelope-from=350w4xwukdfgceh1e6ee6b4.2ecb8dknff2-34lb8iji.epb01i.eh6@flex--morbo.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20161025 header.b=hEAHv6+6; dkim-atps=neutral
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com
 [IPv6:2607:f8b0:4864:20::449])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CdBN411Q8zDqyx
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2020 09:40:44 +1100 (AEDT)
Received: by mail-pf1-x449.google.com with SMTP id z68so8059683pfc.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2020 14:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc; bh=MfMOr+ciBUvyEku7jbwiTGrVOTlGbi/Zq462ZlqWA5o=;
 b=hEAHv6+6r7XIe1SCtgqFqJB8TWT7TeGLv3HStVxu/Y++4b/Q3ex6jG44MxMa99/I/m
 CUIYVRIRq57uxCeUYnVk+iz+GWGt8i7fDpqc4rKwQJDkQLtIX+92Rk/goUarXVnYI5sQ
 VODRaFC7ZevRIihbBz6saABGIaRPllTeOSR1vaUpAydIULn81PLBIQT/T5E1nLyYC+hC
 9WSN2vXcSHsSqOLPSvPW/vzB6sNDfgbqRSmnIbH9O1Nf2gC4ZTXl2K/yNEC73DOIINq2
 VSIExazQrERuoHzA6CWoZxLqVQMGkm1G33DjQvue9PuC7XGPvcsr58A771lAsdzDw8Ku
 qcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=MfMOr+ciBUvyEku7jbwiTGrVOTlGbi/Zq462ZlqWA5o=;
 b=WzJhHd3JD5dyEDO5RLwmyDarFjvm6txJAUsgH84OwoKGxbLK4IHt02jSjnbAmlwNzD
 Y30Y9kVgI7C3+geurnOEDi2RMloa8JtBzxbvHnyebEW2ELs6U298FACTO7J/fiTNI1F5
 +K9wmURymo/xf3zeZ8VTglBkgGPUOf1zujwG3uYt0KdohvAHVuFZC1zKrbfncjZT0Z/o
 oCpDt9DocDaJkBubBWA8G6BNENGoRU3oyWt+DReGHWdX0B1XB06+KLTZXi2FJPqMUX+h
 8XHulVxALlfMqpJ8XbEwsiVnmy+Cs+gYNWewZviRbOHiMZvcdmC7GfpWr27qlOMJK7ej
 i3Kw==
X-Gm-Message-State: AOAM532aqhyJit5SiDh/z7QeznH4frcH925q1QNKsPhYtiJUcF02ycqS
 ls5k880PufoBFhGExCKgjRtuiGx3
X-Google-Smtp-Source: ABdhPJwRZm3Smhn9xHqh0D/np8+PMLDUjOTg3JBIHjVxQTdmB5jicIb16n5IVzngnbkO4mBUrNyCHbUumg==
X-Received: from fawn.svl.corp.google.com ([100.116.77.50]) (user=morbo
 job=sendgmr) by 2002:a17:90b:293:: with SMTP id
 az19mr1293672pjb.1.1605912039637; 
 Fri, 20 Nov 2020 14:40:39 -0800 (PST)
Date: Fri, 20 Nov 2020 14:40:31 -0800
In-Reply-To: <20201118223513.2704722-1-morbo@google.com>
Message-Id: <20201120224034.191382-1-morbo@google.com>
Mime-Version: 1.0
References: <20201118223513.2704722-1-morbo@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v3 0/3] PPC: fixes for clang support
From: Bill Wendling <morbo@google.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
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
Cc: Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Note: This is a resend of PPC/clang patches I sent before. The previous series
had a bad title, and one of the patches had a typo in it.

This series of patches include fixes for clang issues that arose. The
"powerpc/64s" patch was "inspired" by a similar patch for ARM:

eb7c11ee3c5ce arm64: alternative: Work around .inst assembler bugs

Bill Wendling (3):
  powerpc/wrapper: add "-z notext" flag to disable diagnostic
  powerpc/boot: Use clang when CC is clang
  powerpc/64s: feature: Work around inline asm issues

 arch/powerpc/boot/Makefile                |  4 ++++
 arch/powerpc/boot/wrapper                 |  4 +++-
 arch/powerpc/include/asm/feature-fixups.h | 17 +++++++++++++----
 3 files changed, 20 insertions(+), 5 deletions(-)

-- 
2.29.2.454.gaff20da3a2-goog

