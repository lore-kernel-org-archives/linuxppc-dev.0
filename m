Return-Path: <linuxppc-dev+bounces-19658-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EDF1E937E1
	for <linuxppc-dev@archiver.kernel.org>; Sun, 12 Apr 2026 13:23:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ftrnv027Cz2ypk;
	Sun, 12 Apr 2026 23:23:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::635" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776000194;
	cv=pass; b=CEnyGwk4SeeU4khGlCiYwN85d98hoLhydNFSTm7WEnrnYGgMo1WTcBWZd0o5BfZFoU7lRQ2W75HQ7u6b1NzLPeqB9AdGfgb28rGls1B6Le3/Ij2CL+NVFtxV6cK6rqzDogOZYfXZ2O3cnZNTwjA37aV0FrMSFWlO9UYJpQ65XRukPCADkl9POJ9GTCCfOqSDrtMNXhpL7axaTaDLGGJGpzd9rf4HZeW19KaYs6YeY7O9qFad4r8nlZNBAgr6MUiAD+bKUJW2cHLx2iVcoLiCLE+u4ts4cj+QrAhpEISOKVVBSDp/e0F8roKj7L4nK/Xzkq/TTLcOxkh3oMuOMj1e0w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776000194; c=relaxed/relaxed;
	bh=gDdA9vu4Fz00bgurrj0mXlyC2hJ8rRfiuCUxuR8xwe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ISs2fsZJXYUMOLczB6Z14hGv3zF4qKniMXSjdk8ggSx0SYA+9EMNoKtl2KZJFXHye1EIZ/JlhWixkoB7HhzSwpit9+XG80eYVX6b4kAk9sOeCdrx3FYZlo9dqFOfLE6I+IYPlNTF/SSlIuodqqWnwD7mo6Zd1D5diEcK3WiqlGSBBe1s8MRZm3m2FM7IuG0bIOVguzWWSN7DHEPGjRcatPJU4TUOjQszZYPaD1cWH/uRQ4s0zuG5hFw0VwXyvWe7qVoqoeGJC3NK3Fu9UpTjWudqCazROC17olFXH0PJx0wgU4r1pVw1gk4F7CsBidPoqRelnycdot5d4SYrFwdaDw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qgimthR2; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qgimthR2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ftrnr66sTz2ypY
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Apr 2026 23:23:11 +1000 (AEST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-b97f9587e6eso465135666b.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Apr 2026 06:23:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776000183; cv=none;
        d=google.com; s=arc-20240605;
        b=IRQMBpevFPWT0QsbU88BljojWmE+i6Q3eJRpynB8MyRjn/5pM26zfTgUgAFjrrH+NB
         wwLykfXm86lAYNJ9QWghOLXGEjkwRI9aixVncYBiNktFStrCIY78/6dji63myhTFQpY9
         uMUCvStg93K1o8lPjrfxjQTml3Hz4BAhB08jLLBz0ymLeZdP473yAiWKq5UKmQEZsoZm
         HBGFHnxnmnwEPQsWRPskntH0ByCYPQmni7HR66ja6YOqhRLKMn5kXRHAx3qSK5f0RFzr
         w92znnphLNLjvpZShhLTsrJia21t6P/dwx7FPVWL9gg5dljvMptkHmipehCWF6CNryD5
         25BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gDdA9vu4Fz00bgurrj0mXlyC2hJ8rRfiuCUxuR8xwe8=;
        fh=H95nPcwOtV8XNaHmb0hzXOAN3sW27UaIjDOfJLMvM8c=;
        b=FmwCwCcSKxMCCedbnLk+g1bt9aluOGtNdIBD2x0drXZiHYnrIlraJltZTW1aNaDPFo
         Q+TM7svXO93WvCrEtqHzAZWUuQ8Mt/GW+CqkFezjybTJPo26JDbm7AR4qjZN4moAoUub
         ABzIp8mKe4uJM3SOU1pMfOg/H/brlKwMGsu7ZA+CkqVsyEdra9/xBqfLWwHZrIIvzP5E
         uKV8Ww5AUUb2ORM8jvJSNGse3+a7XTsyLIecElc8BhutvA1cQSEa8S/WnA/pOBHGiDWC
         /7h0Gr8ON+YnhXt/Bq+NZbuwiZp6S66Zwz0ZmIG62j1om5rsR/x5i1Zhyww9OOUAS+Fx
         IvRg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776000183; x=1776604983; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDdA9vu4Fz00bgurrj0mXlyC2hJ8rRfiuCUxuR8xwe8=;
        b=qgimthR2CpkHgbtjgRNJZfHPKFAA/0YMTWAxXTey6MfrP8+hcUWk9/WKnGe6fZEnpd
         JJ8UtKq9PXb7zm22bytE/nooRT1v6XkF9j+hQwFfFV6WtrB1hoFS/1GaAa4nVhvuEIQD
         kSt1WfTjwwNKBW/42NRRPOkOOUsZnMCrjIjBOn0hKhZWFxVc/qlw7TFRNM7K29Tw5bhJ
         CaHCg0pHldok+Y9yJx6BenWQ7OhI66LFoaCWZjnAsQuLGdljtd6U87exg2FedzcAgZt2
         U05CnYINH8/pndU/QHswyBmbXH30dpFICiIfEOytT4RSPBdMAXr11Sy1U5nyiKA90T5o
         rnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776000183; x=1776604983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gDdA9vu4Fz00bgurrj0mXlyC2hJ8rRfiuCUxuR8xwe8=;
        b=tO3p2HpoWhB1AtjnFURprcf85KRPI9VoR5LZg6wfggRGOdWXQir+4Hmp10FG5Msuby
         wmiFhNODqbrZ5xzFT1/4gV9e2fT048kIT0dbabr+oxadcpoiW91pRQekCcrs94mHGI1E
         cEyoNoMv2EjG45v+iZ6SOATXEQ+2Lg8MJm0hA4ebhjAJs5XcYDMzNlEY4vbwITOd0VyK
         BJgQYg+Y4TJvt8FC8MLE1HTGX7uDxEvOYtHAU6XjAU4JyyXwwBsbikNvQqDYI4GYo+2A
         qaSX4xqkFTbCAqu9nsAGYLrHRfgh0CNxN0eqQ8esb7JJEV844ZKV6W8XrNnv8A51UCKf
         PVsw==
X-Forwarded-Encrypted: i=1; AJvYcCWYJqgVH/9U9OxryuT7A25NaCMsH/rgqrdvblm/ut4xEW2IEHjhrWIVpm6uRgpyBviuJ/5n84hs3Dg89DA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwnXdVSHm6/4tCrJBn0JuDCO7rhhY7wlNMaUbr3R31szs9f3FuZ
	qPHoItInxcgyFvFsYwUGbGqbko6xUDB/2FLi/y4UMjJyb4HZR0EVq1bBuZCTEbmIs8IzccOpEcb
	5/k+QXtaYBZoBe08rAESKq268TnPOhw0=
X-Gm-Gg: AeBDieuKmy3HlD9qk1g+O9qccp1aOVdHYaticI8iUWffc35uv7vh9t+S1vlp018R3/x
	ljQMmLQzygXfd0xgLSrpcOr10W8vP7BVzY3h9RmqIMf/0+S/CTsBfiym0pmL2w3vlRMglMrZpLA
	DLdGVAwbyJL+r2K3UphtbBtkteR6sRHs7hrB7xYyOVwe9DzpRPBlH0d3kOnUDQdVmjNOsxXh4TC
	EwYXrG6XPK72tgFS0f/k5aupbHHexZ8lQ5Q2lFLVgBCY8e/BPo79YJ0owwySKrvfMLCabVUA1Jw
	dzQOoue+w8Kt/jhLlV00wQUx5Lo0fliOsa6SQTHs
X-Received: by 2002:a17:907:e113:b0:b9c:6ef1:ed18 with SMTP id
 a640c23a62f3a-b9d727aa4fdmr352963766b.25.1776000183133; Sun, 12 Apr 2026
 06:23:03 -0700 (PDT)
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120319.131582521@kernel.org>
In-Reply-To: <20260410120319.131582521@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 12 Apr 2026 15:22:51 +0200
X-Gm-Features: AQROBzAeMsaeSVePCJ__tEd4f2rWAY6MixXzp_fii2b8vyUpLt4xjSbtYzENFaw
Message-ID: <CA+=Fv5S68wZQapeaYTspOfsuGk=nBj60sx-ojHBSqrxV59Q+ZA@mail.gmail.com>
Subject: Re: [patch 23/38] alpha: Select ARCH_HAS_RANDOM_ENTROPY
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, 
	iommu@lists.linux.dev, Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org, 
	David Woodhouse <dwmw2@infradead.org>, Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, 
	Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Thomas Sailer <t.sailer@alumni.ethz.ch>, 
	linux-hams@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-m68k@lists.linux-m68k.org, Dinh Nguyen <dinguyen@kernel.org>, 
	Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 2:36=E2=80=AFPM Thomas Gleixner <tglx@kernel.org> w=
rote:
>
> The only remaining usage of get_cycles() is to provide
> random_get_entropy().
>
> Switch alpha over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY
> and providing random_get_entropy() in asm/random.h.
>
> Remove asm/timex.h as it has no functionality anymore.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: linux-alpha@vger.kernel.org
> ---
>  arch/alpha/Kconfig              |    1 +
>  arch/alpha/include/asm/random.h |   14 ++++++++++++++
>  arch/alpha/include/asm/timex.h  |   26 --------------------------
>  3 files changed, 15 insertions(+), 26 deletions(-)

Hi,

The Alpha side looks fine to me.

I've applied this patch on top of v7.0-rc7, built a kernel successfully,
boot-tested it on an Alpha UP2000+ (SMP) without issues.

Acked-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>

