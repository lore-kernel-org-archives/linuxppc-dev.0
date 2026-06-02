Return-Path: <linuxppc-dev+bounces-21852-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131ECC5DF71
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 07:51:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV31x5GhRz2xdh;
	Tue, 02 Jun 2026 17:51:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780386709;
	cv=none; b=FigUyvYBlfehRw7EVjUg9gr1Zr+4HLJnC38p+PnxPEyrjcFzM3Gn8rlmL7EnP0E6CAo1JKCllLE3wOelyk19DL5y4hh1DzxpW1O0mUkhaE4bGTEoS6j5CuUf+X/DZCElvwWLC1DO8cfPH4ElCN6k5J0w3wYLbe8CVloQY9GhlJt671aqfyLB8O3TWrknLg1AhuJNWBY4udBK+5kNeUMTkzk5wpQ/Ic4Yqv/kAetiVS82hSZ0/0AnxSgS+SHbpSMgkmHixB5Uv+MUX6Ca+j+JWz5sqwU/vG0bystPgCHBTGnJ9/K8Ahty38M/3llj4BX90Aqid/yLOEPNuq/KHvVSyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780386709; c=relaxed/relaxed;
	bh=XM1cyr1vrg2HBK1U1khpsYAE4BrS8XU8+D6WO/ogaEg=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DzYknVV3xG9yolxrT3HNGm0GhNnE9dXLig95GlsI5ZtCJx5xxLMvcahuDqK7jodiS82lB8pB2muhVlhnlyX7rLKUF/VGdLkMsPKQgGFyy6ijo5sTMZ4rD3cQyL9E0IvZq1dV3Utc7uGQFelQpgkAXQ+KTjlmR/NfBpLmoTWzWVSmUQDkhRIEDC4MGAYF0AlX5BBl1dIszj8uEYXvtSgfrYgLghIeovKoF8LzbAHoF1rA8ZOnnVWDo4CatKbhyViaaaV9x/IQ/e4JiPa5m8Q9udMsPfi5v2xjcsKHUSx6gNYcTvARe5X9Mb4Y4vzxt650XXzUJzD5++6FU6x150yTXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cLN2WanV; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cLN2WanV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV31w4Q95z2xLm
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 17:51:48 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2C5B540715
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2026 07:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E2A1F0089B
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2026 07:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780386706;
	bh=XM1cyr1vrg2HBK1U1khpsYAE4BrS8XU8+D6WO/ogaEg=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=cLN2WanV4w7DSAaxyuIl+hxPLF55Z2df+kpIab1MB4r0y4z1+joeDWUVxfWUBq+Tn
	 FzYDr3Hu2+fS35+3aRDQktCuLqn3LFWeGwDaPM0qNWSgzHwr4VfpVCMl9xo+2mBXcX
	 PY/Z+o2OgSyjCnOyomXhrIHRMFGoBWKhP8ANCG5pCDKnaXtCVAPG1LX23HkTpMHXok
	 7Kl8qZow8+Rpja02/6Wi6Wto8VJn/IV+J4i+gSmgGTIoAxzh/RiRir3+5JZ/EDcrU3
	 bSnL5BCYwazUz3liDr0Z/QFXmfMvoCt1EJcWa4cc5TIFwY1g1TApzT8CnuCYItrQTX
	 pq4O31uFw2pPA==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39661f81eacso36344171fa.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 00:51:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/6ec8cYBN2AtCPH+5w560n4qkmjoXTocIO6vndFeKP4v84eq9umd3FaqD1yYG6tRJkSI9kz/YR/mtVopA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwfFYZJLvhDEEuY6F+NDiighiFFNzfM2FrZH3bqZAe9ZI0B9Eb5
	V8sXQd+4wtQlH+byEzCnC3wTSGkIlN09KzzpCm+h7oG10ROwjlaZiRvVOZFhy7ASlaLzTV7sm6z
	QrA9WfUxkeeY69u+Gu0h3nFo2eBdlUeRACqKHznSVtw==
X-Received: by 2002:a05:651c:248:b0:396:7f13:99f3 with SMTP id
 38308e7fff4ca-3969ba86c5fmr8390851fa.12.1780386704787; Tue, 02 Jun 2026
 00:51:44 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Jun 2026 07:51:42 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Jun 2026 07:51:42 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260602050131.856789-6-rosenp@gmail.com>
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
References: <20260602050131.856789-1-rosenp@gmail.com> <20260602050131.856789-6-rosenp@gmail.com>
Date: Tue, 2 Jun 2026 07:51:42 +0000
X-Gmail-Original-Message-ID: <CAMRc=Me0rqs8nxrp95X-2Bjw059ahRxwKrg-NtmEt025w2m9bw@mail.gmail.com>
X-Gm-Features: AVHnY4LkpB6dJhgbPXQCl-FD0u4U2hnvkB7wtmJ832CgKjY2LSe3im_-EB8j-9k
Message-ID: <CAMRc=Me0rqs8nxrp95X-2Bjw059ahRxwKrg-NtmEt025w2m9bw@mail.gmail.com>
Subject: Re: [PATCH 5/7] gpio: ppc44x: Convert GPIO to generic MMIO
To: Rosen Penev <rosenp@gmail.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, chleroy@kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	"open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>, open list <linux-kernel@vger.kernel.org>, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jun 2026 07:01:29 +0200, Rosen Penev <rosenp@gmail.com> said:
> Use gpio_generic_chip_init() to set up the PPC44x GPIO chip
> instead of open-coding the basic get, set, locking and state handling.
>
> Keep the PPC44x-specific direction callbacks because they still need to
> program ODR and the OSR/TSR registers around the generic data and
> direction registers.
>
> Assisted-by: Codex:GPT-5.5
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---

...

> @@ -124,10 +102,11 @@ static int
>  ppc4xx_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
>  {
>  	struct ppc4xx_gpio_chip *chip = gpiochip_get_data(gc);
> +	struct gpio_generic_chip *gen_gc = &chip->chip;
>  	struct ppc4xx_gpio __iomem *regs = chip->regs;
>  	unsigned long flags;
>
> -	spin_lock_irqsave(&chip->lock, flags);
> +	gpio_generic_chip_lock_irqsave(gen_gc, flags);

If you're already doing it, can you use lock guards too?

Bart

