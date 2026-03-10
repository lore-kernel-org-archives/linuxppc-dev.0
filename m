Return-Path: <linuxppc-dev+bounces-17947-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05BAAEA8550
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2026 09:11:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVSn06fj5z3bjb;
	Tue, 10 Mar 2026 20:11:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773133908;
	cv=none; b=R1dRG4Hl5GnuSOPNuYlV8MZnAe9Z88Oy7f9meA+gWEfN6FtuerrjujSn+1VrQcKcOToZfpR9odsXyTqRnPEcr0YsnTDBvEvzUtalJFwbrdIeTxLJt1s9gstROt3AOqm0oblguMUaQERrpwa8Ed4xsehjez181dwQzh17pEpfk9UAZaOXgpA5mrbYPcNOksWhAIYVmmJsTxdorZOAWiNGBdtDR91snwp/WpHiJeqztuCeQO1yxwfPrfztbDpge0HcePi04zCp/uf8cP7IkQlTy8z7jEbmq6kCvTvolq+QvUPjIy8dPAQcBTq1gCed1NJuhz3+n6z3j1BwEXmoPg5l3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773133908; c=relaxed/relaxed;
	bh=k2F848Zif0ENv+dioxwCTNyt1oN71pv8VacY1VvtFtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EdXhr3m6msRIZbT1fH0ea+shh0slkYrM2GTVkmtK65+ZNF5qg2OE6Smi5RL0Reyed9c/zdnK90tP+aBgzpsVyHxSg1QjNXk7JQNGIFP4z8vtH3pE0XUK3FjXm9aOh2WT8a3eyKKAxslgJq96soGwYKZqox7ITClqvCmXoMRodEaB4tQzKdEzey/R14mn8/0+MgSRxgZfmKLbd7q80NdTSQr+wVrzx1dOJit9K+nMlle4jIXhFbC1cS2EDmLjgUeWxXNpO8IbcIu5Kqj2bhzFMXPH3jg+0aIwwyZQjkWOSgK2C+BEiJFU9j7ynQUlJzcAwrgaeMXlCvud0ClpbkGi9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iAC9yuid; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iAC9yuid;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVSn00QThz2yFY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 20:11:47 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 41C976011F
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 09:11:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D3FC2BCB3
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 09:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773133904;
	bh=k2F848Zif0ENv+dioxwCTNyt1oN71pv8VacY1VvtFtA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iAC9yuid2s68RAiwdOVhUAT93xNVNA2ATIxfFQW4dQE+FXIxaOjCapUEbvNoJpl3y
	 h2pplicze6P7A4b+Z6qbUbtprHuZrE9SX0jf3Sb4kCb/xuO4g9UYyRBe8uvfafxgRT
	 MlAX+ROJ8fI/1IOzq7SkCPxxTiIpFKn+NYkqTzRN0dUhcjO7WBb3lfQwjlgSF/mA+T
	 2usZruX6YvLaJaQhmlbepRt3wWrMdiACaKI2164NU4H61OgYEdZxJ1pAz5ZSFsRuvC
	 WcmI0hJYuRpJWSR7Y2rPjq/q7wgBF2MIdaG1bDSswPwS60nWibUKDp0Oxtc2EMhkSk
	 Up1JqmHIxcM/g==
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64ca4dfdd88so12343633d50.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 02:11:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXa5yawyubD0yY2eGQ2ymEXxJtf1Hj309AvwwxQ+bbozvyoSoQHLEjiMNsBDkhHCG0Ttfi8MaCRrhLqu+A=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxKIdJCoprxrJYZ8msV/PL1XQ1aqI/XHra0NtzVFl0yS9jjSUXJ
	Cov4zqJmHKuaiw+0NW42GDyrV5JZnU3zcBbMWkc2/HgDLEK00prL9erEDerlcGCbIEYD37TVliM
	El0Tx3VFwaqwnNwarNldzz7Dg+jx8eMI=
X-Received: by 2002:a05:690e:b8c:b0:64c:905:6f2c with SMTP id
 956f58d0204a3-64d1411d8b4mr13101525d50.20.1773133904182; Tue, 10 Mar 2026
 02:11:44 -0700 (PDT)
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
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 10 Mar 2026 10:11:32 +0100
X-Gmail-Original-Message-ID: <CAD++jL=pOw2ZZqMXFK4cQ67g3yUGho6mjbW3JM8iQDQpiKL8TA@mail.gmail.com>
X-Gm-Features: AaiRm53Xu9gGfY3MrM83r361-dKQ36aGj99vP6wgofH18qCwDYgWNRZvm6MhVmA
Message-ID: <CAD++jL=pOw2ZZqMXFK4cQ67g3yUGho6mjbW3JM8iQDQpiKL8TA@mail.gmail.com>
Subject: Re: [PATCH 07/14] pinctrl: Kconfig: drop unneeded dependencies on OF_GPIO
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Alexey Brodkin <abrodkin@synopsys.com>, Vineet Gupta <vgupta@kernel.org>, Scott Wood <oss@buserror.net>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
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

On Wed, Mar 4, 2026 at 10:03=E2=80=AFAM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:

> OF_GPIO is selected automatically on all OF systems. Any symbols it
> controls also provide stubs so there's really no reason to select it
> explicitly.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Patch applied to the pinctrl tree!

Yours,
Linus Walleij

