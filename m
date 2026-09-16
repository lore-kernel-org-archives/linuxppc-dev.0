Return-Path: <linuxppc-dev+bounces-27499-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50EE8C982C1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 16:51:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlQ086RZkz2yGT;
	Thu, 17 Sep 2026 02:51:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789577512;
	cv=none; b=kXfRNPl/KlfYWiJlxSEzMHqyj/r96K/HV2/oOdDAz1dq37yyHTdWRHOV/Qf2nHITLV+tcP03oizV5fpxs4lajy8vVuUQ0QeXgMIMkBSNDpuGYv3KvAqWLLYsMIb9bbVv1UQJGiL4RsaODcP4yFaISkgrUpLaN9Lz8kLfIy8xsDAKyKAa9u60dx2s6edt29pwky3mREtGB7D3z3PBbq6NYwQ0RThGcxXmDOJ5zvrEo+EKd1JAVSrQMT243yFKrbQ6vKCkqi454nEoTqEtKaTLqQrneL3VGZtGWK4UJoYF8Ji2dCP7cT2DsCdCDoQKHBJkbZYrO474061EZtHYjnd53A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789577512; c=relaxed/relaxed;
	bh=jlDHHiMVqeXgdpn1Zj7e0N2hLgqwzeWFJxceKYb+YHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pd25CJnojXfWEff7NPi2ZuNnbpSwc9nm8GEy3wdt/IguHkT3OwzmSFnWyBXfnHYc9S7jhlXuBH489Ei8VPC7FL6do79crDJWUs0ueHB2MYm6oVtDZ3YPyy+ET0XvsvmLmfwtqs4dn5TfkKJ2emjGtsmczjwaLnpk55ro5WP3vmS0dSh0RnxvtlNlnrHt4BPUqgXxtr88s+iHbXZWI9wdq53JnhZHAZzeXZGZytZckA+lkZCXQcMZ5Hvm0/8RX/ClcwJEjYkMakU0v25SDSF2VMMoOhRxECVTQZVKl90lW24I4N6Wj8Xyhb46nKtL64zgOGJ5I1kP+V/soL190yig3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JcbHzxFv; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JcbHzxFv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlQ0824pVz2xqp
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 02:51:52 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5D45B60A59
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 16:51:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4CA01F008A7
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 16:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789577509;
	bh=jlDHHiMVqeXgdpn1Zj7e0N2hLgqwzeWFJxceKYb+YHU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JcbHzxFvgLrpPJkR5R3XBY3y2SfCcwhDFnSiLhJ1B+/JTtnxdxndb4zLLznpRuxMr
	 zDUB6DlQP+4KRhUFQ8qZIwmbtMSg4Sa213btbd920xJW3yvf/Rn4Qzedge0V2JpjlX
	 DSseYM02zkMboFVManwZ9pkz7gBcwpL3z/fAJjcC2l/MJBjBv12ZukFan7Y5adtLR5
	 PKISREbVUR980BR6UCPR2TSmSQ7nhb1eCTbfCo2hB8HPqtX95CCZxk0cjc1OeNxXHC
	 wHby+UM/xrpkpvxH7mvJSJwmMZRLimAjK/eOXdvW4CtjMIwx6V8jFLqWrsv0qByTdb
	 TzMjmwn1jm1BA==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f15b79so1142415e87.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 09:51:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByEJiivpWGLMaBGxHwvTtnXrZrHO4lWuTmt+mCBwoQ1o1AQ/CHYlxPFbprd2WpxC5sR5uCIPFSZgewisnw=@lists.ozlabs.org
X-Gm-Message-State: AFuF++ls88tg6iRx8IvA0bZMVto8oyOjkxpmy3NpbJ/2yMocbChyfB10
	MMtE+7aAj6JmBRevyYHLF75jhbnxgylDRGS0SnsQIQvnpsCuobxemKo9nfIezPlJcNT21Qke98o
	SedHr+2qr7V0szg2l85Gyvy7IcZ+ivL4=
X-Received: by 2002:a05:6512:3d10:b0:5b6:17b6:2224 with SMTP id
 2adb3069b0e04-5b8b665478emr1974764e87.23.1789577508492; Wed, 16 Sep 2026
 09:51:48 -0700 (PDT)
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
References: <20260909132153.1596191-1-arnd@kernel.org> <20260909132153.1596191-13-arnd@kernel.org>
In-Reply-To: <20260909132153.1596191-13-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 18:51:35 +0200
X-Gmail-Original-Message-ID: <CAD++jLm253spmn1Tq2Jekiw2Q9xD_HDQ+AFRgWovLyE=veAfhA@mail.gmail.com>
X-Gm-Features: AcwNN1Xrn_ibUNrql-q0n8N3iTosx-ZSLrxjHuJr9HzfGfgIlGS2dfpxQ3q588w
Message-ID: <CAD++jLm253spmn1Tq2Jekiw2Q9xD_HDQ+AFRgWovLyE=veAfhA@mail.gmail.com>
Subject: Re: [PATCH 12/14] mfd: remove unused mcp-sa11x0/ucb1x00 driver
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
> The sa1100 platform has been removed, so these drivers are no longer
> used anywhere.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

