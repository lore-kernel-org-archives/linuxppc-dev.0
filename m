Return-Path: <SRS0=Ph+o=NX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0198FC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 19:09:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 747312245E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 19:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="n5U0YE0K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 747312245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42v0g51KW6zF3HX
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 06:09:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="n5U0YE0K";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=ndesaulniers@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="n5U0YE0K"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42v0XF0sGszF3GK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2018 06:03:24 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id t13so1794857ply.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 11:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=F73BoH0qM9ADBHcBiXopQvKF5rs7oS9TiYg6Gnm6VE8=;
 b=n5U0YE0KV5X+yt9XJiCTk2U2pc+3hYvhfkq8lnunAu8ulH1YrGg87MIhjiHReNBV1i
 SKvGtiUJukrKVvY1zvAncLqQvnGEWI+LwEFfUUU6O0Ari6jamMfNsTJRvE47ea8pjaqw
 PMTH16GXQjNST18Bky/yFIB3Tai6rtbIX5y25f2PHNyBqpzAzk5g3Nn5Mipq2CrvxxBW
 Cf1jnbddP66EHDsUTUp3edTYuqBtcZjOk+k/G78/uw3xOmixRPt2ZUyFj5ZF9xGjE9Ra
 zf6/+8ctNgKAPZI4fnCveo+rGnDU0aubRCL2yvnGtpz7kcPVdyKi95dy2+oBoELnd8Ed
 tdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=F73BoH0qM9ADBHcBiXopQvKF5rs7oS9TiYg6Gnm6VE8=;
 b=WzwhTpsDKrqlTj7s/0NxIHEW8c8A94oHjk7nRWJo4zBRxMkX69t9N0q/rYE8ORZ9NK
 3/n+zkagV96tI3KjoeSH4dJh02gm6hG8JwymKeTkMHMp/3FdHx7Wa/o8T0oRcEaR43Vb
 ovorCNerizO9f7mUT7enPk6TMCWKQRhHzDKQAwvRxUEDfTEA0JYQUTIqs/V/VfseJXZH
 Nu/QPwSHnTHeUspxW4w+jh3LApFtPuat6qWglzW7p2KJFO/YNGwcH6bdkZ+RjVt9Qnyw
 ogU5ehxAhfHDNxfSX6WCMq9ougPr9MsVZVW3ACKqCQixQEV40plkuW/wskMoCLy2+CIj
 4iPQ==
X-Gm-Message-State: AGRZ1gL9NEkVmhYpa9we3zfyyfT+9P9eDZcZehE3umGBflHv+v2xIMfO
 iMpdtmZRY04pblGu1JMUf471nWD28nVsx92Oig6Wjg==
X-Google-Smtp-Source: AJdET5e4CNDXaQXU1S03LHDzBgpbuVHAM/bvtWP1Imul3RBJIrJunv87XDOcXGRt9Z9UlkV4DpudASr7swqN/ajQ/c8=
X-Received: by 2002:a17:902:5a2:: with SMTP id
 f31-v6mr2005249plf.320.1542049403085; 
 Mon, 12 Nov 2018 11:03:23 -0800 (PST)
MIME-Version: 1.0
References: <20181112042116.5271-1-joel@jms.id.au>
 <20181112042116.5271-3-joel@jms.id.au>
In-Reply-To: <20181112042116.5271-3-joel@jms.id.au>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 12 Nov 2018 11:03:11 -0800
Message-ID: <CAKwvOd=Sck9MMyq4sBe24iNbcVd=KX7enfxN=+Y7uvL-YrxHrg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] powerpc/boot: Set target when cross-compiling for
 clang
To: joel@jms.id.au
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
Cc: Michal Marek <michal.lkml@markovi.net>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>, linuxppc-dev@lists.ozlabs.org,
 dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Nov 11, 2018 at 8:21 PM Joel Stanley <joel@jms.id.au> wrote:
>
> Clang needs to be told which target it is building for when cross
> compiling.

Neat! This will help us for continuous integration.
https://github.com/ClangBuiltLinux/continuous-integration

>
> Link: https://github.com/ClangBuiltLinux/linux/issues/259
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Assuming patch 1/2 gets fixed up (or is fine) and doesn't radically change:
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/powerpc/boot/Makefile | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index 39354365f54a..111f97b1ccec 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -55,6 +55,11 @@ BOOTAFLAGS   := -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional -nostdinc
>
>  BOOTARFLAGS    := -cr$(KBUILD_ARFLAGS)
>
> +ifdef CONFIG_CC_IS_CLANG
> +BOOTCFLAGS += $(CLANG_FLAGS)
> +BOOTAFLAGS += $(CLANG_FLAGS)
> +endif
> +
>  ifdef CONFIG_DEBUG_INFO
>  BOOTCFLAGS     += -g
>  endif
> --
> 2.19.1
>


-- 
Thanks,
~Nick Desaulniers
