Return-Path: <linuxppc-dev+bounces-21920-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863CDCD6E5D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 20:51:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVNKk5c06z2xRs;
	Wed, 03 Jun 2026 06:51:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780433498;
	cv=none; b=N0599MbNENDoKrSfRY5VSE9Pu4lHapeBhkuz6KQVpbcwfkw4al+jQSaYXea1NAEexy/IJJ0UIAe0ZXnABzBMJno2LNskgyAU2Q+ITDzpWrwGQxPZcvAoJjlO8GVfpzx6BqEuXTuOX0dbdpN5V282QAJ2mMgQ5jvCZmZ/3G8u43ebDCDOzMDQ1B+Ar056cB6/PJUNS7LszTv0fifjVbO0ziUuAVzK8oKZnEk1+yuiZg5EzNWzOyr0Oznk74WmuEVYexMbW5IawYvVwKATkTuRz3TGI6QPoRd1V0fZEjs5ArkWvSI4toeOlNYHfM3CGuq3L7vpsD5wEfgnufrCiSx3Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780433498; c=relaxed/relaxed;
	bh=G6rZ7t6/DhXfpQVj0UlyYqS4gIMH66eg2Oc1gFXbhJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=baiBhdf4yILj1w4yZNX4ljOafftm+zWUemhuDMCKo/TOHpdZXaIwE0gp+ba9E71RC9XOAwqGTpXnCm6Tf4IqHhlqJF3Zh5d9fqSumKOs3hwLLWHl14ic+Hmt6RqPE4lmqXqvOGGZ4YTxqrgadK+Wdn+1dYhIZN75NzSMnDzoq07KyefMzm1BnpGh3IiFH0ZhUEwdP5vS8g8X3GD8boX93CO46TjEWlP5BbU3Gxy+Rm+mnMrvom9HLKBE0uzs8toIliXYygp2EM/4A5li8GPVKqIPR8OZJ6d0/e0hCtpvm8QdqpkOh99pVE4s+hoYs/evVY+tsAcRxVuDVBprFQlVmw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WsQo944G; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=timur@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WsQo944G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=timur@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVNKj5Q31z2xLm
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 06:51:37 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 35A7D601DE
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2026 20:51:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4A11F0089C
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2026 20:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780433494;
	bh=G6rZ7t6/DhXfpQVj0UlyYqS4gIMH66eg2Oc1gFXbhJ0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WsQo944GDchg/wLfBxF995MDsIQlWR94qpNUGNWfmtj0cc9Cm6IAvLYK49Jz+sub+
	 cCz9hX3qvk2i7XzqttjMLfpB2FTj81X0WI8T9GOEFst61x7uetTvHoQlZHBhkw3wj+
	 pWEXAl35dtpSL5N9q+XzcWkaBdzolGpamWnG3Ut+8eiWiblT+djxuby3gRu3VBbNTW
	 b5gX5xDdjGnEk3Uf3Rhjs7eEYv4grJDMr3ZOHMMp2kabifDBAot1ZDAITd3RH9n/oV
	 ENGlOonCAxXOF1Zy8Nr8B/0OQsXqHHxsvHFgQOc4sUtBFr0j9jX5I0vS+C7g/hnM3X
	 sTT2vS+XYtAaA==
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7e2f3646c10so38383067b3.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 13:51:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/e13GS8vrN+CR+ymiANG/dL4yENRNUgAx57yTo9JpvDJZiMdSmyAxksZgpGD7F80B2uIk47Xg+QaVlaK0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwS+tHZE9WQW0jLV1Nra+f0HXIjZ6df9mReoZSNIbF91hsD0EHP
	WC7OzFEYZ+RcjUbYKomqjRNo1ytGOqdldgj9K7nxz8kfabNk/90QFAnmBKPj5OAoDVzY1wrYd4i
	ww5LgjwY7oOmoK8vNPGj8R8W4IJW40JQ=
X-Received: by 2002:a05:690c:620f:b0:7b3:edc7:9b97 with SMTP id
 00721157ae682-7ea4400dc8fmr7795367b3.0.1780433493990; Tue, 02 Jun 2026
 13:51:33 -0700 (PDT)
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
References: <20260304-gpio-of-kconfig-v1-0-d597916e79e7@oss.qualcomm.com> <20260304-gpio-of-kconfig-v1-7-d597916e79e7@oss.qualcomm.com>
In-Reply-To: <20260304-gpio-of-kconfig-v1-7-d597916e79e7@oss.qualcomm.com>
From: Timur Tabi <timur@kernel.org>
Date: Tue, 2 Jun 2026 15:50:57 -0500
X-Gmail-Original-Message-ID: <CAOZdJXXetr-FPZUSX_nzS5nZc+bbv5b1m78sCcZzrDJi7C05vw@mail.gmail.com>
X-Gm-Features: AVHnY4IltjGxIj5Fh6-JK6uSKIHTP0yZBU085pIyp8WmlCvLfmlYl2sow6Y3Jn0
Message-ID: <CAOZdJXXetr-FPZUSX_nzS5nZc+bbv5b1m78sCcZzrDJi7C05vw@mail.gmail.com>
Subject: Re: [PATCH 07/14] pinctrl: Kconfig: drop unneeded dependencies on OF_GPIO
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Alexey Brodkin <abrodkin@synopsys.com>, Vineet Gupta <vgupta@kernel.org>, Scott Wood <oss@buserror.net>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Dvorkin Dmitry <dvorkin@tibbo.com>, 
	Wells Lu <wellslutw@gmail.com>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sebastian Reichel <sre@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	linux-leds@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 3:07=E2=80=AFAM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
>
> @@ -557,7 +549,6 @@ config PINCTRL_ST
>  config PINCTRL_STMFX
>         tristate "STMicroelectronics STMFX GPIO expander pinctrl driver"
>         depends on I2C
> -       depends on OF_GPIO
>         depends on HAS_IOMEM
>         select GENERIC_PINCONF
>         select GPIOLIB_IRQCHIP

This change causes the following warning on builds:

WARNING: unmet direct dependencies detected for MFD_STMFX
Depends on [n]: HAS_IOMEM [=3Dy] && I2C [=3Dy] && OF [=3Dn]
Selected by [m]:
- PINCTRL_STMFX [=3Dm] && PINCTRL [=3Dy] && I2C [=3Dy] && HAS_IOMEM [=3Dy]

WARNING: unmet direct dependencies detected for MFD_STMFX
Depends on [n]: HAS_IOMEM [=3Dy] && I2C [=3Dy] && OF [=3Dn]
Selected by [m]:
- PINCTRL_STMFX [=3Dm] && PINCTRL [=3Dy] && I2C [=3Dy] && HAS_IOMEM [=3Dy]

I believe the proper fix is to have PINCTRL_STMFX depend on CONFIG_OF,
since this driver actually does depend on CONFIG_OF.  The warning
comes because if CONFIG_OF is disabled, PINCTRL_STMFX can still be
enabled, but in doing so it selects MFD_STMFX which does depend on
CONFIG_OF.

Adding "depends on OF" to "config PINCTRL_STMFX" seems to fix the
problem, but I'm not familiar with this driver so I'm not sure this is
the right fix.  I'll post a patch.

