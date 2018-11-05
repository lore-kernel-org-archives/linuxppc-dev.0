Return-Path: <SRS0=pi+/=NQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C4CECDE44
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 00:13:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB56C2082E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 00:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="J2kYTNhC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB56C2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42pCnd3BWczDqfb
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 11:13:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=axtens.net header.i=@axtens.net header.b="J2kYTNhC";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::744; helo=mail-qk1-x744.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="J2kYTNhC"; 
 dkim-atps=neutral
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42pCks1bqTzDrNP
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Nov 2018 11:10:59 +1100 (AEDT)
Received: by mail-qk1-x744.google.com with SMTP id o89so12042931qko.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Nov 2018 16:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=DefHv6QVwy4iBHaY7rU6bIW3MRtaDfO7YheFLG6O6rc=;
 b=J2kYTNhC5lnKI2ecqJKrWwo5LqCz/RQ9TvXBUJMVCJUlr5PFc6D3ciIGBIMbdsTfW6
 vDOJCIgrrkFmxdC04GmwmQSf3kvQUrUN/lvEfKZc+aKNgohepCfq+RXqQRYmKQuEiAS5
 5VVsRgf3OtTmVo4l3l3XL1HPSYvZDCip1P0Co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=DefHv6QVwy4iBHaY7rU6bIW3MRtaDfO7YheFLG6O6rc=;
 b=aeLa3L8jTCbkDFpgMhKSd1cMjAYShtQmvcLaTnB8XjYXDb9CVAAkWoLCDoki9hw+/v
 zYihavD+K5Gt+0x+rzWvMHhWV6D9d2pdCO+N6tfGeyf+jdBWcKzcwFv4UDGTS+K0o9d0
 95FS6aYc5+O7s7ArdapLzE6Xo7jO/OLVCr+LYU2SzaMdyaNQll3bQe1KRjdR7mXWr+qY
 X4tGpQkaYImNuaxb7327u69dHtFk/8MUfZji+7nxnBT6TFIXZV8tmU98Uh17N85lSvoM
 4WWMbL3Wk6046mrXi6+xff7cfytsJrjPkjsFvJyXOBIHjIez0wnkmwbEIkVPrFKnSC+S
 qr2Q==
X-Gm-Message-State: AGRZ1gL0xLwU1Q+sngmOnguuODE1F4qoLaHvSF8T9bEH8mEaRGplEjVu
 v6kYfozgjLLXJt8BUXK87mANnw==
X-Google-Smtp-Source: AJdET5fqqpmJQMTqhywuWxPh6SndKwYXrHtysPORvcO201bXdlKsusNH8RcGlQvq4hpPI9Y35pWVjQ==
X-Received: by 2002:a0c:c38d:: with SMTP id o13mr19328795qvi.100.1541376657311; 
 Sun, 04 Nov 2018 16:10:57 -0800 (PST)
Received: from localhost ([2001:67c:1562:8007::aac:4356])
 by smtp.gmail.com with ESMTPSA id j51-v6sm20916062qtj.26.2018.11.04.16.10.53
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 04 Nov 2018 16:10:55 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Joel Stanley <joel@jms.id.au>, Michael Ellerman <mpe@ellerman.id.au>,
 Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 1/2] Makefile: Export clang toolchain variables
In-Reply-To: <20181104231133.30848-2-joel@jms.id.au>
References: <20181104231133.30848-1-joel@jms.id.au>
 <20181104231133.30848-2-joel@jms.id.au>
Date: Mon, 05 Nov 2018 11:10:49 +1100
Message-ID: <87ftwg4c52.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Joel,

Thanks!

Tested-by: Daniel Axtens <dja@axtens.net> # powerpc 64-bit BE

Regards,
Daniel

> The powerpc makefile will use these in it's boot wrapper.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  Makefile | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 9aa352b38815..a2db3c885b38 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -495,6 +495,9 @@ endif
>  ifneq ($(GCC_TOOLCHAIN),)
>  CLANG_GCC_TC	:= --gcc-toolchain=$(GCC_TOOLCHAIN)
>  endif
> +export CLANG_TARGET
> +export CLANG_GCC_TC
> +export CLANG_PREFIX
>  KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
>  KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
>  KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
> -- 
> 2.19.1
