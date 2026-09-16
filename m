Return-Path: <linuxppc-dev+bounces-27498-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63860C982C1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 16:51:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlPzB4Gkbz2yGT;
	Thu, 17 Sep 2026 02:51:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789577462;
	cv=none; b=FAvvBnSQkLwXDp8xbXX8wwNhGacgyJ88IBE1IaLErSI6uC5X96coaeIBPx6q/WAVlrW+DOCx1Cz7qHEtkPM6P0oua97tDW9nwTgTgKvjEbwl5IXBvWzi3BjclV4lld92bAaKRzmKRNW0109LSqcOMggzWZ5Xm3vIzNrk6ti8m+iufOS8p0Tl1LFuheDBwc4/kaNvID68+4DWCYk9iCqHuWHyXU0Sc/dK2ZtEhcVJlHw9REFHmZ4Y2jRBCk5FpnI+ICAmkVbqqjo9CVpEQ/hNmi8sbBpIvcGmYfaRpq2JLH06uWO0xOsGVhcQm0LXtFiik7T8yPaGZKBmo9BqhCfCnw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789577462; c=relaxed/relaxed;
	bh=aPNoc/IlVGOzrz4AF5oUnZbB8ytSLfqRYFF3aP/E0sQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N9ty3IpR2Q4Q+15nDq1HWSpIKe6I+UPQUqj+40KXyMrFShdsRTyLjSLFMNWuHm36iGIHZIgpZyatA8wTbFnWXmzgsqZw9DQG3fEyL3puznlPgNIrxNFjsPI1o2Fka6duLICBO7r8yxq2UTCSxy3mX60L+KfWiUIKVwqfyldcDlskfx8CbTALK7pO17wQGPu7wiOroNZCTm+FTHzBC5RAS7Ay+pfn/7FyRm/aNh+qXFYTsFAzZdw7JAdbZosBFRcHCUoEvK3GuYP1UGDJz6Cc8n547iXl0Je8LTjFTn2VktsmfAO30H8eNG9PmTWnXNsvhDZcklcd30knno4GP7nRWQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KDzpsTWg; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KDzpsTWg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlPz970c1z2xqp
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 02:51:01 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0EB2943D3B
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 16:51:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D889A1F0092B
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 16:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789577459;
	bh=aPNoc/IlVGOzrz4AF5oUnZbB8ytSLfqRYFF3aP/E0sQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KDzpsTWg/z/5krxTobDbUSigXfKLPKN3GY+kPVHqBR7Qs64CjzbIot5CkPAxP2KI+
	 Upq0GS82M9H0w++Czaj9svBiDTIMQmYdYP/CnWtiPeFrOEHUujcdjRSLexmI83DV+8
	 d3OQKB1DCYTLA88vtfqbmhxp+3cXxscBoXEspNQE0qlsMYOfCwjg24mnoTiNgsl1/S
	 2qLgSSSaznjuc0hKlv6DMiusMtJMUHjJIhhSSySZ7vl9callQF4Q+5MgOlSemRyTDx
	 yueZt3Uscllvxw64KPLdcYhjZOLgiIXI50AcSMUhvVtuef5e/bhhcPutASFv5vSY+5
	 AtaQQrqZxPKdg==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f13d77so1508608e87.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 09:50:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxuO6hGRUibZjKO+o7t8US4JfEyz0MEIH/8b+ZTK6zL6inuImu/nRu435u/7YAu1hCYzBTeMnJUt0ixJAw=@lists.ozlabs.org
X-Gm-Message-State: AFuF++n305/qMb6COaFbuPWbIiTOkQwMnFDox4MvEx/mPAjBj4w4RK4D
	JGcRkNc8j4Qsj9G2x4lUgDeaqoaWP1G5LjXWl6QmpVVBmgzIzGe2ort2qe/C/daOwiO+jgGGgYo
	Rjixykl86xHnPhLyXR4K3Xe9drOnaClA=
X-Received: by 2002:a05:6512:4023:b0:5b8:b419:c8ad with SMTP id
 2adb3069b0e04-5b8b6617917mr969995e87.17.1789577458536; Wed, 16 Sep 2026
 09:50:58 -0700 (PDT)
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
References: <20260909132153.1596191-1-arnd@kernel.org> <20260909132153.1596191-9-arnd@kernel.org>
In-Reply-To: <20260909132153.1596191-9-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 18:50:45 +0200
X-Gmail-Original-Message-ID: <CAD++jL=dBJNiZMwRfYtVXC=qfWEU8WY1DRRzDA1o9Ngsd_VRqg@mail.gmail.com>
X-Gm-Features: AcwNN1VWCbypMBp0nAwSnIVxOHs3QNpjZkwVGv_5Swi1QUA8mHWSb92JoMn3LYg
Message-ID: <CAD++jL=dBJNiZMwRfYtVXC=qfWEU8WY1DRRzDA1o9Ngsd_VRqg@mail.gmail.com>
Subject: Re: [PATCH 08/14] mfd: remove unused aat2870 driver
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

On Wed, Sep 9, 2026 at 3:23=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:

> From: Arnd Bergmann <arnd@arndb.de>
>
> This driver was apparently never used, as it has has no devicetree
> support and never had corresponding platform_data definitions.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

