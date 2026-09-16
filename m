Return-Path: <linuxppc-dev+bounces-27505-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B83C982C1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 16:56:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlQ5Z18ktz2yfD;
	Thu, 17 Sep 2026 02:56:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789577794;
	cv=none; b=NCCu8XH6agI8f52rudAdybODv5bdt/VPgeJ1gaYHP6eMaGRN4tPgcIwqC7s00e4xf5fdfJ+SJ/uN30ugtZtL45g/n+wmYh7RFhVZQsyz09o+Am9eHt4OfhgPaJeiwhgC3LBqCftBaUznZaMz9c5uBWHG23esqkcWzUv45O6/AUXvnhyqe36oc7AqmZhx7iwofJKe2wUMQWiIptbPDu2E4hcOAH0QqmFZIXXBkcWNEIO1igtHk4+d4YQbLWwBbL1hYMN7whKVroegt7VU33IFuYWFmiE2oyxSJnZX8zE0b1LPAr0KmXnFiQb4ivl0asY28r0x3KfK5Aw0r8ztoYhNPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789577794; c=relaxed/relaxed;
	bh=fuqbMSXmKaVksZQ0mp9Ucbs7t4/StAc7bwI5H6qAaCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQBSjaQP4WcLiPYduQxGEjOczQOfDVIWGhOrZWeh657+rjDBlGBBJKH0Zi/5i5O1D64dutJVPXl2u7Y4epUwDqso0IwgpaT1kFKoz6hpc8wndx2910Z5/Mh2YkrRoR27ZL6UG8fdqgqGBEBkJ8R72uIFbxlhNTakPemHBURsFt/LuVgEvon1J+aHE8yVjsckXQaHDkJr26gnnspYrley31/FD7GH52ubhJtVplhmldQLiMcDWqZ0Ou9oeVoY68vA4sE0+8bGdpu/jFufmFD5tUwHuGCVGks4+78O0ncJJJbQXL+1u4kh+MndTg+eI96Yh6LkZSCxN/jJnYLqSdM/SQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cg/A8+VC; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cg/A8+VC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlQ5Y2nDrz2yGT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 02:56:33 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E63D543B60
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 16:56:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C930F1F0089B
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 16:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789577791;
	bh=fuqbMSXmKaVksZQ0mp9Ucbs7t4/StAc7bwI5H6qAaCU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Cg/A8+VC9E080TzyvTpxu0YnPUmsHYmEPc7xtw8lOlwVWQFVXT213KsByPqqSIU2I
	 YKezTVvqkqyFj8RCV6X6z796z+cgGL3/V6KKfDg+c71b1lvwwgWiG1EI1uwu/m3Th0
	 3PiWWmOGjEHneUgz6Si80Fbz7NLf7VJpVq/lxnf4hkRztmLGONXApvwq5Bj6ihxbnh
	 2DEb0f9/ARGDI62c/9rCPp7kYe7gh6X3Np4O26+gdKgWFKq9/xbV2rRVt1oCMkC32O
	 lt6rPATnGQ4rlLkFzK27Q7Nts5BzFzoK5WLviocUhwMjzceCEZEyQbrc9KdJxu4ARU
	 QjSSuos16jzVg==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b76ff64d78so1067071e87.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 09:56:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxu2kPRmP8hHEynrNDbUzY3AK4IdhGHxcg9kryEtL2j6KaPOxR/NBdBG38iEhBb8d/eSuIclSw36aR/LrE=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mx65ZV0n2tys9HDK8Cy+ZtyhpY4zGmKxdyCs5Dyze3LKb6OjpN
	wvW1PGZOYugcBXGak0SnR5M5oAt+H/OpsN4hb6cNLU2pWqPz5brV4iiFlJK/K1OfKnpuas1Ys23
	EMRIP6psSZ8F1MdSVuqwBKXEICVJrGrg=
X-Received: by 2002:a05:6512:3a96:b0:5b6:1a7c:59dc with SMTP id
 2adb3069b0e04-5b8b66504bdmr1056044e87.54.1789577790547; Wed, 16 Sep 2026
 09:56:30 -0700 (PDT)
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
References: <20260909132153.1596191-1-arnd@kernel.org> <20260909132153.1596191-12-arnd@kernel.org>
In-Reply-To: <20260909132153.1596191-12-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 18:56:17 +0200
X-Gmail-Original-Message-ID: <CAD++jL=LM2agPEcCxjtQuCNx4q7zqutFA6oDb61kKEDAADR4Vw@mail.gmail.com>
X-Gm-Features: AcwNN1Uahpnh6JEjJOB4HtYt7IIRQWlpnYcwXmBiixUkMQ8clPYYJyQ4xy80br8
Message-ID: <CAD++jL=LM2agPEcCxjtQuCNx4q7zqutFA6oDb61kKEDAADR4Vw@mail.gmail.com>
Subject: Re: [PATCH 11/14] mfd: remove unused wm8350 driver
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
> This driver was used on the i.MX31 ADS reference board from Freescale
> and the smdk6410 reference board from Samsung. Both used platform_data
> based driver probing and are now gone from the kernel.
>
> Since probing with devicetree has never been supported by wm8350,
> it is clear that nothing can use the driver on an upstream kernel,
> and it is unlikely that anyone is still interested in a devicetree
> conversion, so remove it.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

