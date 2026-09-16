Return-Path: <linuxppc-dev+bounces-27501-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF736C982CC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 16:53:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlQ220v57z2yGT;
	Thu, 17 Sep 2026 02:53:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789577610;
	cv=none; b=fesIGJ2PfKJ9oUshnOg7FwVbsjYto5PKIHvky3DL/IehkOTbNUIU98cB5kZ1cJr8+S+KuWlC4TKx8PmbTZa+XkCS++6YyN2fXm3evdfzNmUfxMNzSxtLdZhOarlmugVTgtpOxAOhwhw4kogm5C/Bl27d2wa0QqOGCuZPyBg+AKx3S43fo7DLW+FYEJrq6z5ETrZ5TCS2XQcDJ9AR1D5EkbqGaALIroYGmMhgtpZTajj4ChUp04kOaCMiJGvIAIs4Qhj+MqIbFL9miPzZj4fGJvsfnoxwx04gtVeoudPHj9j4ALY5t31zT2f3nJBcWem7tz2Jq8EuKpGthd8HF98OJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789577610; c=relaxed/relaxed;
	bh=A8OUnScFkntcgVv0El+XRQhsZJJugzhrkrqucm1xVqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z4O6F3fT4MTGwkGGi1Z2a/4ircXJR76kUJE4lTzcFGoh0yEwoSnXDANbiNOifJtkd4HsvMvGNoDv4mdrjALRHgtg5gLSmMnBt290xC8dGGv63V4neT8EFfC+Ums9wnU7xMVRQsF8iQ3N9tO9+EQJj7eLqAcdYusTiF+viKJuJ4zWPSsngjJQSuEoCwWCIa49dzZiwFe2Sc2NYm4GOUrdjki0oXCPg6zkoXYuKuHE2mz89GdUVRhFHSWjS/Ud+cxiadrtggvSY6G9vS/yhhrUmiLgykrcI0e1LT2LnbA25z2HOqukOXnxsrTpv10hePvUxIxBITOJQXaDx4tNUNxIvg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JJ//Aepn; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JJ//Aepn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlQ211Wy4z2xqp
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 02:53:29 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 53C6C43D4A
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 16:53:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E719F1F00A05
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 16:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789577606;
	bh=A8OUnScFkntcgVv0El+XRQhsZJJugzhrkrqucm1xVqI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JJ//Aepn20JwNBvgjPe2RGPw3W1TnzMJZL/1hbP4HXBkwn7oafbEKxyAkD242zIlA
	 mxiFlxtkmChee+seVVxgSwqzTw2/2qQK0we0712tsN07f4SxhiZzdIQV4fEFge8P3/
	 eXve/Ikiuca0hD0ksm1quV6jvVcfQKngvgIPch06kggcScyYBReWU1BZQ4w+BDChhO
	 cGkgQlSSPeS1/dDsoagEKEc13m+IpOu4TIhAfls9D/+S+C/kUAOQgOb9jAwOjq10Cs
	 9vCLGY4l6ToWfXsrjRRPyQjen+4pYHsH5KDYWCIGz6+YqUeRWbKAAdd7LHAkuCR8Qp
	 yDeQXu92KeBiA==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff17443dso12057861fa.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 09:53:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwQ+yAR0ZYlH1+W1ZWfacpQqpgYMzpsKsSM0CZ7Rcx4hKtIwK0UsyHI/b+LY2QqgZyNex5oCDThdFVKgjY=@lists.ozlabs.org
X-Gm-Message-State: AFuF++l+nfTzBOgDCvH6SWd95EGQVqbfnmelT+qdvrtuZA5k70NdloMK
	/hTSOO/qMQxE/RiCKyWjCU/3QcZ30WpGhDbqMaCm9pxxaDYMb5/OSvpnll7ZX2hR1gPnG4GGXch
	Yrm+8ElA/B2NW97dhhVDcEenPqpCg7ro=
X-Received: by 2002:a05:6512:3e07:b0:5b6:95e:87ce with SMTP id
 2adb3069b0e04-5b8b660a94fmr1957280e87.2.1789577605581; Wed, 16 Sep 2026
 09:53:25 -0700 (PDT)
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
References: <20260909132153.1596191-1-arnd@kernel.org> <20260909132153.1596191-15-arnd@kernel.org>
In-Reply-To: <20260909132153.1596191-15-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 18:53:12 +0200
X-Gmail-Original-Message-ID: <CAD++jLk-e58uiZ5JfiKtW+4tKoVyCXrEz9n4W52PnmtKLqQrEA@mail.gmail.com>
X-Gm-Features: AcwNN1UPBZKZl1X4uCVkQyjhp-cH_klICrLDEiep9UNQdzrrNpZtksTPMzubFl4
Message-ID: <CAD++jLk-e58uiZ5JfiKtW+4tKoVyCXrEz9n4W52PnmtKLqQrEA@mail.gmail.com>
Subject: Re: [PATCH 14/14] mfd: remove unused iPaq micro driver
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
> The iPaq support has been removed from the kernel, this driver is
> no longer used anywhere.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Also delete the header as Sashiko says, with that:
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

