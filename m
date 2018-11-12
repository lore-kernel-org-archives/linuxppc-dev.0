Return-Path: <SRS0=Ph+o=NX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D166CC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 04:26:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4549F21527
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 04:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZZCFUgD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4549F21527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42td4N2RXmzF3VQ
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 15:26:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hZZCFUgD";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="hZZCFUgD"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42tcyq3nsPzF3Gx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 15:21:39 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id n11-v6so3654058pfb.6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Nov 2018 20:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AfmLjimSE+u9Sy0yk5tbns1pzcTs/BVhUoretovdKgc=;
 b=hZZCFUgDmcDa9atXmPKhPjcQ2NSeQxlDEo4KWPNsgL9x5dRq0Tu9NAFjPVm3QSXk4D
 NZwQdRV5W4GpGjRWyMEf/Q3oIp/yP1sdVgSyZWZLG9t2tWBOg5VuwzU/DuQBxcwlU042
 JN77N8M7lf1TEGW6zvdiR8lQV96J57gQXHwcwCuhvqJRc3G+PwE31wvD1s3JMckXTkqw
 ZGOOUNxGFF8M5owZtzwAKHv13skrkvGVsR1A7o3+fVh9eCWXcWzLDkcbJ8Oaw04XLxnl
 LUhL+lZX6nrVI258Yf1cc7as51wt1IrtNHmBwGlVE4Mp6Q0sVyRMzuUhRGodFC1fgbbI
 O/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=AfmLjimSE+u9Sy0yk5tbns1pzcTs/BVhUoretovdKgc=;
 b=WsDDQ3AU0S8wTe4Ua08lpA6hFA5C30mjCwji3nnIXhRnhv9rPiUUdUQKgLUhQsERuX
 VJD7BWkciwxYLz73o+zU5lkHnhSZ261AYNRprqkJ9HpJjyR9E1EZrAfeXZB6GAFrhxYs
 baa+ZSel1Qnk4DjGu9Wjid6k0z5rwCzirvg4EE3K8f6OsoQf941w7suMsfnur5cYBboA
 a6zTrZHhNkW2V3AItZrQGLc53EPTu/+uKMYZe38MT5PPDIQdEd5DVFhBACnqrCKgQsLK
 otiI8Ul12YY/yoTikvVQ+2TGa4RVmpSXHniXNKORYcyn0nq7XOt77wQlDwz90n3gSlIo
 mrXQ==
X-Gm-Message-State: AGRZ1gLOdixMRvDIHiNA0FlfPzxwFYU1mMdQN2Be1obcAJugv9a7YYpX
 gnG/BCkrElCGeQ/NIOLJsP8=
X-Google-Smtp-Source: AJdET5ef/PNEQHg9krXR0mrZKkE56lCnm2fbxajHf5TuowdEy8abYUO39Feq2b6OoQAbSYmPsX7ONw==
X-Received: by 2002:a63:4566:: with SMTP id u38mr16016372pgk.4.1541996497502; 
 Sun, 11 Nov 2018 20:21:37 -0800 (PST)
Received: from aurora.jms.id.au ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id 34sm16556456pgp.90.2018.11.11.20.21.32
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 11 Nov 2018 20:21:36 -0800 (PST)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Mon, 12 Nov 2018 14:51:29 +1030
From: Joel Stanley <joel@jms.id.au>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 1/2] Makefile: Export clang toolchain variables
Date: Mon, 12 Nov 2018 14:51:15 +1030
Message-Id: <20181112042116.5271-2-joel@jms.id.au>
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

The powerpc makefile will use these in it's boot wrapper.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 09278330282d..840efe6eb54c 100644
--- a/Makefile
+++ b/Makefile
@@ -495,6 +495,7 @@ endif
 ifneq ($(GCC_TOOLCHAIN),)
 CLANG_FLAGS	+= --gcc-toolchain=$(GCC_TOOLCHAIN)
 endif
+export CLANG_FLAGS
 CLANG_FLAGS	+= -no-integrated-as
 KBUILD_CFLAGS	+= $(CLANG_FLAGS)
 KBUILD_AFLAGS	+= $(CLANG_FLAGS)
-- 
2.19.1

