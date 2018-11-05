Return-Path: <SRS0=pi+/=NQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A376C32789
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 00:15:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E24D52082E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 00:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="lwfmj+VZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24D52082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42pCrY0ZwmzDrPn
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 11:15:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=axtens.net header.i=@axtens.net header.b="lwfmj+VZ";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::742; helo=mail-qk1-x742.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="lwfmj+VZ"; 
 dkim-atps=neutral
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42pClx3t6CzDrPn
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Nov 2018 11:11:57 +1100 (AEDT)
Received: by mail-qk1-x742.google.com with SMTP id q1so11917984qkf.13
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Nov 2018 16:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=WZ0SN/9tIOLxDw5ecT7eyS26p7AIrwBGnjqeB2WICjE=;
 b=lwfmj+VZmnvhRNCzJ0Biylkt/sYF4zCNvsS1cfVx5a1treWDBmIKWQXqFRXYzgh0l8
 7GS3zm56rCCiXNepqRPCXAQz8Sz8XNveu+by4vat7nMlYdcBeL00HYr1CKUN3WKjFEex
 U93lVguGuwDeoiDhT279UVGftv72z3B9deecI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=WZ0SN/9tIOLxDw5ecT7eyS26p7AIrwBGnjqeB2WICjE=;
 b=tFvVv+ZMlplFT0MWnCmKG0caemcgqIXdcgGTeq5fVLb/2ehj4X29Te8h4ZFyN5QNFN
 p5JvhVOMleP6F/aaRS+KALC/fZ0bAFNBzXt7rhIjNnMLWOFi9vzPRDnDjVBcQSf8b4k+
 tDjKm/taQq2DByMlFyQSaf1v/dyLvGgpg6cQmZzW0n8T1QFZM02pLAFRBU6Q3w9ml01c
 /8EB9GD0mTInA635A5rAKWgEj/kvr0xy5ltdOihJuiiQaPZQHldmaz13/riXiB8DuYPS
 ZNh5Nz11VKPuqxb6UZI/aoLwmQnfNVUrj5Pz1y0nPSpuYxxrPEkoMzlS72J4QmJUo7v4
 bgrQ==
X-Gm-Message-State: AGRZ1gIQvV9t5v5qZfj1BRMK99Vz/tWWRcNUXm9KcuKneOd/PnHRO8q5
 qHTRBp7gt6ga1bIGP+TiOmsvNA==
X-Google-Smtp-Source: AJdET5d0d8Wnsse+wXmO+a2wHRWZG5XlesL/vcqRxFMtCeG9e2nhcsiuCrCZibHaoYr8weH61heNNQ==
X-Received: by 2002:ac8:1909:: with SMTP id t9mr18656691qtj.327.1541376715279; 
 Sun, 04 Nov 2018 16:11:55 -0800 (PST)
Received: from localhost ([2001:67c:1562:8007::aac:4356])
 by smtp.gmail.com with ESMTPSA id e17sm1090593qte.12.2018.11.04.16.11.53
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 04 Nov 2018 16:11:54 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Joel Stanley <joel@jms.id.au>, Michael Ellerman <mpe@ellerman.id.au>,
 Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 2/2] powerpc/boot: Set target when cross-compiling for
 clang
In-Reply-To: <20181104231133.30848-3-joel@jms.id.au>
References: <20181104231133.30848-1-joel@jms.id.au>
 <20181104231133.30848-3-joel@jms.id.au>
Date: Mon, 05 Nov 2018 11:11:49 +1100
Message-ID: <87d0rk4c3e.fsf@linkitivity.dja.id.au>
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

Joel Stanley <joel@jms.id.au> writes:

Hi Joel,

Thanks!

Tested-by: Daniel Axtens <dja@axtens.net> # powerpc 64-bit BE

This solves one of the 2 issues I have in building for 64-bit BE with
clang. The other is the VDSO32 stuff, and I hope to send a patch for
that soon.

Regards,
Daniel

> Clang needs to be told which target it is building for when cross
> compiling.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/259
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  arch/powerpc/boot/Makefile | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index 39354365f54a..8fdb1890f09a 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -55,6 +55,13 @@ BOOTAFLAGS	:= -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional -nostdinc
>  
>  BOOTARFLAGS	:= -cr$(KBUILD_ARFLAGS)
>  
> +ifdef CONFIG_CC_IS_CLANG
> +BOOTCFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
> +BOOTAFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
> +BOOTCFLAGS += $(call cc-option, -no-integrated-as)
> +BOOTAFLAGS += $(call cc-option, -no-integrated-as)
> +endif
> +
>  ifdef CONFIG_DEBUG_INFO
>  BOOTCFLAGS	+= -g
>  endif
> -- 
> 2.19.1
