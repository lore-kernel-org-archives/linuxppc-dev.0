Return-Path: <SRS0=NKNt=YW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2E7CA9EC2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Oct 2019 08:26:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1032320717
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Oct 2019 08:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A4gHFXAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1032320717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 472PnJ13CzzDqqW
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Oct 2019 19:26:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::444;
 helo=mail-wr1-x444.google.com; envelope-from=ard.biesheuvel@linaro.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="A4gHFXAp"; 
 dkim-atps=neutral
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 472Phm49tLzF1bv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2019 19:22:32 +1100 (AEDT)
Received: by mail-wr1-x444.google.com with SMTP id l10so12580446wrb.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2019 01:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Dc5k5cS+lEX1SYr8UJULwUVDCp6mopnMnZfWYmGBCQo=;
 b=A4gHFXApxerLrfS/58BvoK//1y1mARGLUGD1wXl13PVjUkYphztL0q3I9iFgWYQGSP
 zrEjaLHDqHIsSXVnDwW8dI4GZmEfCJOKudCdIPzQM1Nh4qb0xIbNAD/naX5+pVK+5ZEn
 ZXPjBDwmR6IOqN/inZwk3UH0Oxo/+KGG01hKggDCr/5OJeRlACGTwthTragNkLJVR9qW
 P6U4Y7tpOEeAd0WTdtbAh7gk2izzk+2OniLv0UhtkKnHilz5Dr/h4WMeOHHcWLu8okVB
 t8YoEOrcTUon7n2Yeb8VbwLXLy64SbWNSYyOYE8zsamK8Fh85H/tugKYuE7BDTW3e8A9
 H3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Dc5k5cS+lEX1SYr8UJULwUVDCp6mopnMnZfWYmGBCQo=;
 b=Yh+Ru7TXj91aRO71SL9I3jO4w2GpyVbEwhkM4pJRQePJJGnCkw/TAhFte+HEoSd7Km
 qOj+VbGk/hqMVoEhC8VNtsgzFElDqkCxcqdqSMsjgsq0lQCMHHWeBOPpavv+lxO3pXnv
 d0qGgie1fwxr2Nq2ONmz5TOxo/+2VJdh5NEYAX60oMFqXwopkiOIU/GaFdLfXvrJ97JG
 b9FX5jGvtTA3gzH1ysQh3erwdRF/AjqVLHp0bQizNvYfdQFBK8KyFqjVJReTIc29va3A
 5447JOrAwBV9NWlfQqvWrSCH1kSw2VQupsVXsWgn3oxTW2xWsFurUwb0RUQyVPpCvfCu
 6vMQ==
X-Gm-Message-State: APjAAAU9OPci3pjNQMvlgKo8lOMdoHZmVVLroYwp4Zt1CsTNq2w+49ax
 so2n4StzsDK0dqMWcZRvaxOAs/gM3Z/fE3G7bnY5uw==
X-Google-Smtp-Source: APXvYqwN10D6LbfAXatOlZBrdKFI55fFKfkyB9LhxhsiVOFM0KEsohYgu7zOVPU91eDRAYF9dPJl1fNLY1QpmxWEcrI=
X-Received: by 2002:adf:f685:: with SMTP id v5mr19497461wrp.246.1572337348180; 
 Tue, 29 Oct 2019 01:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <20191028210559.8289-1-rth@twiddle.net>
In-Reply-To: <20191028210559.8289-1-rth@twiddle.net>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 29 Oct 2019 09:22:16 +0100
Message-ID: <CAKv+Gu-mnyKK_0s7fF_8C0aq1ur+RoHscVwTfd31quEVqZhefw@mail.gmail.com>
Subject: Re: [PATCH 0/6] Improvements for random.h/archrandom.h
To: Richard Henderson <richard.henderson@linaro.org>
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
Cc: linux-arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 28 Oct 2019 at 22:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> During patch review for an addition of archrandom.h for arm64,
> it was suggeted that the arch_random_get_* functions should be
> marked __must_check.  Which does sound like a good idea, since
> the by-reference integer output may be uninitialized when the
> boolean result is false.
>
> In addition, I noticed a few other minor inconsistencies between
> the different architectures: x86 defines some functional macros
> outside CONFIG_ARCH_RANDOM, and powerpc isn't using bool.
>
>
> r~
>
>
> Richard Henderson (6):
>   random: Mark CONFIG_ARCH_RANDOM functions __must_check
>   x86: Move arch_has_random* inside CONFIG_ARCH_RANDOM
>   x86: Mark archrandom.h functions __must_check
>   powerpc: Use bool in archrandom.h
>   powerpc: Mark archrandom.h functions __must_check
>   s390x: Mark archrandom.h functions __must_check
>

Modulo the nit in reply to 1/6:

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>


>  arch/powerpc/include/asm/archrandom.h | 24 +++++++++++++-----------
>  arch/s390/include/asm/archrandom.h    |  8 ++++----
>  arch/x86/include/asm/archrandom.h     | 24 ++++++++++++------------
>  include/linux/random.h                |  8 ++++----
>  4 files changed, 33 insertions(+), 31 deletions(-)
>
> --
> 2.17.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
