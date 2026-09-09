Return-Path: <linuxppc-dev+bounces-26944-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32BD8C79FB7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 14:04:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hg2bs449Dz2ytT;
	Thu, 10 Sep 2026 00:04:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788962649;
	cv=none; b=X+ty2m3QJloWs34N8OLinfysYPp7bTsiT9tnf8RZyhLSeU/r/t47R5KddymPHZFNVUC2QyMUCrgFgPw7L7nrloudpPNi9EjZ7yFK8dCTA62f8bjEuhLqX/ZrJTgokcamUCPyRm97xtlHulrsOQ/7kwa2elxdBhA7faMJAvRn2TpBYP3+wZ7aB/rW971ILebrhX98St4Gof36lKdXYNyStwXEIIpcmKRVf6FrqmqyKUNtCS3wWPCqkR7aGE4JfejCBXZiNeiO8457V/Ogzuh/HslWQdJphCxyFET7OGljfG86AI96eqemURdqPKsu0wE40biq6GRm90IZyVGqlZvPWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788962649; c=relaxed/relaxed;
	bh=0qvI3Ij6pHot4GWpLZbVGJuwCMn3p13tzKFz475rd7w=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NWSEPWpnMAcF6ZYdgsWAikh7Kbu5+6QXJEqi5XVfS65NhPiCAk6a7/LoNnLuI0SO6EGzV7WViu/8PJoFZsiF6N0Zw3YF7bluPwxv8FQIvU1a1da91sB+Ihe1g2flVlMLNLigmym+9BB2vPUiUyaXBsGzgeinWzyJWEHMUNtW2SXntdC4Hsh/fH6UBOCSyZBfY0Fmqu9ct72xGo5i5XWKC5QqmSbZUHlcg8DRrWnKgX79CNV2sqpONG73KGHxkzu7/b7fpeDjgXOiGh++RUpdETtKIw7PNYKJB0QV9GoF8Rz7fSpqJmNkoMVVTflTEHoMyUjI0bouf2VbVDAv9beNPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f7DiDcNg; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f7DiDcNg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg2bp3Pvtz2ysW
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 00:04:06 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8F36C44095
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Sep 2026 14:04:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774371F01559
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Sep 2026 14:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788962643;
	bh=0qvI3Ij6pHot4GWpLZbVGJuwCMn3p13tzKFz475rd7w=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=f7DiDcNgtX0V7nhexZdovTM5uwfD8FIy1VWToiVrwFCMZWT4ep6JgIAU9A08oRbCo
	 AN5nLWLvXgYJ0tGr6wFrfzd3rKYIkdLPqiBR0VzeQED0wp7YlqC4jeS1GMXkHG4/9n
	 rSRsC4A/6gdv9Gv8AQI600Wb6YYCblzz9DRARCproumk9co1hoW2WRhNGkDft6Tzax
	 PlG1ifpPiYVwdpSR8gZdxMUAGkHqzxn1Z4gwkjoqczWwZ1lp/WEsPxvp3bMaLysJ7f
	 oDPtMmEa6U0c/+EmoOFo4is5xc/9+yX8aTqSrj5Pdxa0aAdw1d0RPb3GcrSi18mgHW
	 RbsjrhA44gWCQ==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3a49a022221so8694981fa.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 07:04:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw93N2vKugvWbcOG1DBOQUNSLkJeoI5V1vDHOWZLHjWZWT9upPFDMTMwtEhPnnnRnw1bOC+xUa2qB+7rF0=@lists.ozlabs.org
X-Gm-Message-State: AFuF++l0RVYYcQcLNHLy8Y0eOpXbXca6RToX8x8S28wpThQX/qXyDIGz
	8zOov6fj0+kkN78IGqiVv80aO01LIVdVRJSNXR8uaquyytMtESmgJB4yy5Wd+WM5XMW8SmCvoML
	wD8uuIw93ZYryzDBBQmGKyF1Pl4u2GSTlhHYH7SyZOw==
X-Received: by 2002:a05:651c:a103:10b0:3a4:973c:9387 with SMTP id
 38308e7fff4ca-3a4973c96fdmr5064251fa.26.1788962641476; Wed, 09 Sep 2026
 07:04:01 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 07:03:58 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 07:03:57 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260909132153.1596191-1-arnd@kernel.org>
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
References: <20260909132153.1596191-1-arnd@kernel.org>
Date: Wed, 9 Sep 2026 07:03:57 -0700
X-Gmail-Original-Message-ID: <CAMRc=MfvwcvV7yvkXz_YikGxQ8M0_ajgGA3bf==ZpT_Z46v7EA@mail.gmail.com>
X-Gm-Features: AcwNN1US7FJNeFLdpa5M-NPN5cGI7wXmVw6SZ5lmp-9zPkwIPUzMBGaaTvwumLk
Message-ID: <CAMRc=MfvwcvV7yvkXz_YikGxQ8M0_ajgGA3bf==ZpT_Z46v7EA@mail.gmail.com>
Subject: Re: [PATCH 00/14] mfd: unused driver purge
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Arnd Bergmann <arnd@arndb.de>, Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Guenter Roeck <linux@roeck-us.net>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@kernel.org>, 
	Michael Hennerich <michael.hennerich@analog.com>, 
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
	llvm@lists.linux.dev, Lee Jones <lee@kernel.org>, mfd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Sep 2026 15:21:37 +0200, Arnd Bergmann <arnd@kernel.org> said:
> From: Arnd Bergmann <arnd@arndb.de>
>
> As part of my cleanup of old platforms, I had a look at all drivers that
> may have become unused because the last platform_data or DT definition
> was removed, or because of unmet Kconfig dependencies.
>
> These are all the mfd drivers I found. The first ten in the list
> actually turned out to have been unusable long before my series, and
> I have added explanations on how I determined this in each patch. The
> last four patches are still in use in linux-7.3 but become unused after
> my series [1] that I hope to get merged for 7.4.
>
> Somewhat unorthodox, I took a shortcut here and remove both the mfd drivers
> and the corresponding subsystem drivers (gpio, hwmon, iio, input, led,
> media, power, regulator, rtc, video, watchdog, asoc) in a combined patch,
> to simplify the interdependencies: removing just the mfd driver would
> leave unselectable or broken drivers in other subsystems.  I also have
> additional patches for each of the other subsystems, currently a total
> of 300 patches, many of which still need better testing or proper
> changelog texts.
>
> Please let me know if you all think this approach is ok, or if I should
> explode this further and turn these 14 patches into 70 individual ones
> by splitting them per subsystem.
>
> See [2] for the current state of the overall series.
>
>      Arnd
>
> [1] https://lore.kernel.org/lkml/20260908152808.3928630-1-arnd@kernel.org/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/log/?h=board-remove-7.3
>
> Arnd Bergmann (14):
>   mfd: remove unused 88pm80x driver
>   mfd: remove unused rdc321x southbridge support
>   mfd: remove unused si476x driver
>   mfd: remove unused wm8400 driver
>   mfd: remove unused adp5520 driver
>   mfd: remove unused da903x driver
>   mfd: remove unused lp8788 driver
>   mfd: remove unused aat2870 driver
>   mfd: remove unused lm3533 driver
>   mfd: remove unused rc5t583 driver
>   mfd: remove unused wm8350 driver
>   mfd: remove unused mcp-sa11x0/ucb1x00 driver
>   mfd: remove unused menelaus driver
>   mfd: remove unused iPaq micro driver
>
>  .../ABI/testing/sysfs-class-backlight         |   11 -
>  Documentation/admin-guide/devices.txt         |    1 -
>  .../admin-guide/media/radio-cardlist.rst      |    1 -
>  Documentation/admin-guide/media/si476x.rst    |  160 --
>  .../admin-guide/media/v4l-drivers.rst         |    1 -
>  .../devicetree/bindings/regulator/88pm800.txt |   38 -
>  Documentation/hwmon/index.rst                 |    1 -
>  Documentation/hwmon/wm8350.rst                |   30 -
>  .../watchdog/watchdog-parameters.rst          |    7 -
>  MAINTAINERS                                   |   14 -
>  drivers/gpio/Kconfig                          |   22 -
>  drivers/gpio/Makefile                         |    3 -
>  drivers/gpio/gpio-adp5520.c                   |  169 --
>  drivers/gpio/gpio-rdc321x.c                   |  199 --
>  drivers/gpio/gpio-wm8350.c                    |  144 --

For GPIO:

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

