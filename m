Return-Path: <linuxppc-dev+bounces-27500-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7019DC982CC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 16:52:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlQ1F5Fvfz2yGT;
	Thu, 17 Sep 2026 02:52:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789577569;
	cv=none; b=fZr2Um9IHbbRxVZaZGiP47ZN6gU9J4oFRlXK0cTXorDlGLuN64c5sYa4/ZZ7/euizoHa9IRWVfniERcZMNFwVl6kutiqGOey1uMZRuzH+kRsRQWY9gXiriiD9levUckZLtNNU7y94tlMHjtrPl1GkGAiLRxA7lQBCpwrdI85LaN3yhUe1zSv289V4tejEiqKUdOGURPI9/OzFApy4Rd+N8Q9NdMQac9b+juEYASqgYWEnWHoKEtulW3dGMHR9ejYPvYUo5dc3gJVI/0EvU/2dli4w4kn5vTUZmwuot5DIojK6iTMJN1Rk5MWzSQcWVHpJh0CXpoNlWnqogCHgHBF7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789577569; c=relaxed/relaxed;
	bh=iIGcosXdsqHKF2ZHJfMci5sHM1xFoCT4RjNBihYG63k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CEOdxTASbbKviYy0iSiW7yCmUnTdfq8WF2Ngs9fhMyfvTGXs5UaTwT7BooSLLYsCqt9VpgdjgCYzT/UgOUi7yxwtvgL69StXIcBfEAl2pO1VB/ejiHIyEcJ961q/DCBU9j9ilJ9epsGRMbamFqC2u73FazM5EW5UEHTb/GnbcQwRUYsQZe0aL0Ta4G6FMoJw6FeaQDlQ46nu93/1s2tpC2SdkqWXAeJhupvBsBUnHeJsN6dBmKKTkTCAbF7VeO0UpvlDO8r9FoGwXKDLRE+rZidrPCsdfRs55DOcPIs4FiuMRhyp3FloYL3mH1GqaUMe8N1wgONdb3cmPDWzlqLR6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KAhjYlUJ; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KAhjYlUJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlQ1D4LJbz2xqp
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 02:52:48 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B759E43D3E
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 16:52:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7642E1F00A03
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 16:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789577566;
	bh=iIGcosXdsqHKF2ZHJfMci5sHM1xFoCT4RjNBihYG63k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KAhjYlUJz4B3vlKbDDlDmaEOmLi6tMe6vOLCW5EZoCs26rLbd8glXJaTpSZ5ZncRt
	 G1EQC5qwpstgB2j2XaL86slCFiWMTfVHspK6M+fbSkz9IsAkX78GqJs2dpYzkU2az5
	 pLiawOJCLQ408ODC/MdUIRjzmGWlpTCTWUmaGZ7quTrO+c5iLtuE4rqYPtVgHEdkO0
	 Kc8fUuOuvuraydHFdXnnYj5vBz5OVYt8cGxLANsZDmJmv0dsmNq5PvmvLSGGl3QqPP
	 P7KD/vfJErAG9yROB1uqphrZwuUor23SdPagQu0WaDDl3rLRb2sksX4etGG4xRFK33
	 rCWMVsGN5e/Og==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b5f21afe8cso2362055e87.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 09:52:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzWzsuyAFWdVBleKufVF61GoD4lYASTjdq3d0xLr/XGpUxWmKzf1Zqu0p3n4cUQfkFZ94J+/6YsjS478JI=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mkZ0MhvVc14pxYl6Ja1fchoSe4cirUK3TaWxBoJtLaWb9H1hpp
	bPvkkcXH4vCkW2j7XZrn/iq4GplMD6eY5zy56vJerdcSxdTW1wo8M3jjpiIUrr14HyO/mjDhK48
	UcEsxJwDzBCD+L6U74pfPXO3casEWF5g=
X-Received: by 2002:ac2:5299:0:b0:5b8:9a95:e251 with SMTP id
 2adb3069b0e04-5b8ba710651mr51799e87.25.1789577565097; Wed, 16 Sep 2026
 09:52:45 -0700 (PDT)
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
References: <20260909132153.1596191-1-arnd@kernel.org> <20260909132153.1596191-14-arnd@kernel.org>
In-Reply-To: <20260909132153.1596191-14-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 18:52:32 +0200
X-Gmail-Original-Message-ID: <CAD++jLkz5WV2OBPRu+JJT3PeKhQruiF-Ydcgg7e4OGdM9qchQQ@mail.gmail.com>
X-Gm-Features: AcwNN1Xmdqnt0f8Pu7UGQOVbB8vXW7jTvbrrYbhRnZP_VjfrieoeJn1KmD2hzRE
Message-ID: <CAD++jLkz5WV2OBPRu+JJT3PeKhQruiF-Ydcgg7e4OGdM9qchQQ@mail.gmail.com>
Subject: Re: [PATCH 13/14] mfd: remove unused menelaus driver
To: Arnd Bergmann <arnd@kernel.org>
Cc: Lee Jones <lee@kernel.org>, mfd@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Guenter Roeck <linux@roeck-us.net>, Bartosz Golaszewski <brgl@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Pavel Machek <pavel@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	Support Opensource <support.opensource@diasemi.com>, Sebastian Reichel <sre@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Helge Deller <deller@gmx.de>, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, patches@opensource.cirrus.com, 
	linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 3:24=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:

> From: Arnd Bergmann <arnd@arndb.de>
>
> Menelaus was a companion chip for the omap24xx platform, which has
> been remvoed from the kernel, so now the menelaus driver is unused
> and can be removed.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

