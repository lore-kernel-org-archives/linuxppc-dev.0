Return-Path: <linuxppc-dev+bounces-24997-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B8FC53200
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 12:05:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h99y11LTgz2xwP;
	Wed, 29 Jul 2026 22:05:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785326713;
	cv=none; b=AYS+R4WG8rtwlkDOhgq7C2U/a+tO45THuFM+BqdD6O44Q3UMmEI09DFHflMxz6Gl0RKQYCadwjinIKaZjv3cgQVyA2Q7NmvBBa0tLk/rsHhVP0e6KX2A1B3MBXdqH2+aCMMHsSItVf3bSvVrut+nwwBAjoB4gHKv+mheL5jXQvJ8egYGbBcXSK18CST165HX5ZcghidMlBRkRTg7cTVj+OuJ6YW+A9zONt+zuxSnu2EjV8qiIpeP8xREHTNn4P3T9vcpH0ON7r9wVgVGD1zuueQxCokHxkgxU49tNpkrRDZGa1ZPGY/BRvrbmgcwljLiipTEfD8HjXydLFxxgWOwDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785326713; c=relaxed/relaxed;
	bh=GOMKQKK8qMkZBpt81UGEM/4x78s7SDOI8h9FLDwWwVI=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g/Ai8CqBj5sk+StOJi6SEyOKbW2eAyc13RUUbbW0aPjylCpg5nOriJ1sDRmz+yFaMt9pshOWpBASpg0jYz01z/WrQcQR1zpO8RWhOP1O5MWHiFrwV2pq+F3kaYefxW2pyawVgfSj9RwfJ6+vydaQSvWwwyloNm2d9rWUdpIKy+1hBJmvu5+9+22ZVacA19F4liPsDzy1kYU7oRWMspL5+yah9mE8F7xIYx2e13lFvjAwTWeFEPTNMAuppxVxmMA/9HrKFh7B/2vT7JlmrdkK9M0P3+QvaR3l+z49rBFQ5c3+BP/PAZ+WYt4Ad4qXP/EsPDhCuQQq3Dx3N7W79T14ug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K1QQ5q3T; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K1QQ5q3T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h99xz6ZD7z2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 22:05:11 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8CED542DFD
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 12:05:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710D61F00A3E
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 12:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785326709;
	bh=GOMKQKK8qMkZBpt81UGEM/4x78s7SDOI8h9FLDwWwVI=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=K1QQ5q3TgqwoV1ia8hWc5pSw5Q+OHVWZPXX0hrXGZrcXcZF4WO7EUy1ReP2nR2Ajh
	 XtORVQ/b0nRrRSvrireGbD8oQbx9M2FfAodXQlNXB8+8HnWBmtX4ijs+sJGAXVd7yR
	 Qy28SyyWX6e82MfbdzgjU0B5xfKavuSU3f03CP22FeW5gpJaTiyNoBbiKSmdulO5O8
	 SVVQhHqnZDLCZZl5nNOgYKD0RW5jlIT+p/CqKPnofBsgD3S6nwlngvgq44lUQH9Fg1
	 RxrPZ71Pfm5RMrI6QIUAJr9uOvTk/YIqC6oZHF1qi3HeOWZYcNdcX2VDDv32tyLatq
	 qM4BdEiUwdByg==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b14d1f9315so671304e87.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 05:05:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqfhjiJBWOXKbXMQffFmmbsQznDKUV5JDgWPY06+8Dfu5krQDDtFX7DabKsN9/pc3Boi5w7UaTmijkvXJQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx5xSrNk3UOhIW0DTugCaDLG47KycHDhWIdKq8Yvp55BYGzJ4I/
	pJDki1dpEsgSqtEcIgP2Oe0QSlNVk0LYDk/woEiJrUpJY34XvQOpNCQVaA9WI7liFBm9EygHPd4
	5ery8vVSXvZYpsRfAf7IFNG/1hZkYTFrmSx6ALoX9Fg==
X-Received: by 2002:a05:6512:158b:b0:5b2:a919:f9fb with SMTP id
 2adb3069b0e04-5b2d02232d4mr1407054e87.22.1785326708196; Wed, 29 Jul 2026
 05:05:08 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 29 Jul 2026 05:05:06 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 29 Jul 2026 05:05:06 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <c6eb70aa0e1ba6e15f947c827006aa79edace05c.1785318836.git.chleroy@kernel.org>
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
References: <2565e33e629d16d9e33086570834146bb1c962db.1785318831.git.chleroy@kernel.org>
 <c6eb70aa0e1ba6e15f947c827006aa79edace05c.1785318836.git.chleroy@kernel.org>
Date: Wed, 29 Jul 2026 05:05:06 -0700
X-Gmail-Original-Message-ID: <CAMRc=MdpYBZqTVeME2Bd6+6e76f8pU04PWiidbsfGCPSy65TtQ@mail.gmail.com>
X-Gm-Features: AUfX_mzq7ZVpTopgcSr4EblAUlv1nRkcH2m8kyb6qKgG3g-yIZi9OofmPCxKQ4w
Message-ID: <CAMRc=MdpYBZqTVeME2Bd6+6e76f8pU04PWiidbsfGCPSy65TtQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: implement get_direction() in cpm2
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, 
	RAGUENES Jean Noel <jean-noel.raguenes2@cs-soprasteria.com>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Jul 2026 11:56:48 +0200, "Christophe Leroy (CS GROUP)"
<chleroy@kernel.org> said:
> The lack of get_direction() callback in this driver causes GPIOLIB to
> emit a warning. Implement it.
>
> Fixes: e623c4303ed1 ("gpiolib: sanitize the return value of gpio_chip::get_direction()")
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> ---
>  arch/powerpc/sysdev/cpm_common.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/arch/powerpc/sysdev/cpm_common.c b/arch/powerpc/sysdev/cpm_common.c
> index 07ea605ab0e6..b5d200e3ad68 100644
> --- a/arch/powerpc/sysdev/cpm_common.c
> +++ b/arch/powerpc/sysdev/cpm_common.c
> @@ -181,6 +181,18 @@ static int cpm2_gpio32_dir_in(struct gpio_chip *gc, unsigned int gpio)
>  	return 0;
>  }
>
> +static int cpm2_gpio32_get_direction(struct gpio_chip *gc, unsigned int gpio)
> +{
> +	struct cpm2_gpio32_chip *cpm2_gc = gpiochip_get_data(gc);
> +	struct cpm2_ioports __iomem *iop = cpm2_gc->regs;
> +	u32 pin_mask = 1 << (31 - gpio);
> +
> +	if (in_be32(&iop->dir) & pin_mask)
> +		return GPIO_LINE_DIRECTION_OUT;
> +
> +	return GPIO_LINE_DIRECTION_IN;
> +}
> +
>  int cpm2_gpiochip_add32(struct device *dev)
>  {
>  	struct device_node *np = dev->of_node;
> @@ -199,6 +211,7 @@ int cpm2_gpiochip_add32(struct device *dev)
>  	gc->ngpio = 32;
>  	gc->direction_input = cpm2_gpio32_dir_in;
>  	gc->direction_output = cpm2_gpio32_dir_out;
> +	gc->get_direction = cpm2_gpio32_get_direction;
>  	gc->get = cpm2_gpio32_get;
>  	gc->set = cpm2_gpio32_set;
>  	gc->parent = dev;
> --
> 2.54.0
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

