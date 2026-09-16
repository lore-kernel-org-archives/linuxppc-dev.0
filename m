Return-Path: <linuxppc-dev+bounces-27497-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC05C982C1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 16:50:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlPyl1L3Dz2yGT;
	Thu, 17 Sep 2026 02:50:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789577439;
	cv=none; b=Cz7NINhlDo/w1eIHpH6coDPq6UsLuAZYV98U7plyAKH20TGhzjnH0YCLnZ36vTc1NU6lJJ+uMmVjBiPDw4MVckR1Ds6WhTCfahLXMT7xh40SpN5//pUIDabY1iGCKs6JOSZAE21Sou9JHL6RkKMAisoYGLa4B3uPRrWXiQK2ETi4AI5cRQLipUPOd+XRtcEUaZiKXbsxkekRIrExy5/W1ORqHVKgKFd/D4KwEh//x+o7Qw2XUfFt2WX8Ar6UIy3pian+l2R7GP1sTQ0us6Q7YviBWTD0RUWJaRypcMphiz69mYIUzVGLhLTBb0wCDdwrz50SOgoahnRrIgsL0Zv7XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789577439; c=relaxed/relaxed;
	bh=YbF9Hq6ip8NH9UOOHu4vU+eokzBGAvhZ+dvcT2bOj6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nAmcfYK+QejMEhwR8PA3UDHOJ1ljyX6/VfHckIKdRi4tagwuAUHgJHJmfVpSSIYu7KVMV1+ZwRzX1LDzS8b7yZae5aw9TR3N7Nz/EtVRsAsQGthy14uluzIYz25aIKBzqfPSkHhbgC7+dYePm74H2XZDwWKLIA9rhqRdUfKK4EcXlE6nVjz1c88H4SYfBB3M+nR9dQiBJ3RLSbqDPZcC+hvZsn+mCQV4uEDM945BdaeSaTSIxKoGPb+/lVwQDt7AKCM2FtX6rh+eY8jG32JNkOqafIvUSthUCoQxA/BbcLo6nzmxjqYchggyz4EgNl1JEil0uCatqLDkhPnLpCXonA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HzyqTTzd; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HzyqTTzd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlPyk2GGJz2xqp
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 02:50:38 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C4A9460A55
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 16:50:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71DE41F00A03
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 16:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789577435;
	bh=YbF9Hq6ip8NH9UOOHu4vU+eokzBGAvhZ+dvcT2bOj6k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HzyqTTzdTWLsGmoCJP7+EXA26N7h4dqjzbXM5JPEPRmAvBShC5ylp3QJV/IjFmw2j
	 mjYxuiIBuHovU5P+xcx8DR4hs3yIUF84rFvt80tKQbbcmWfaC3EJjON9izC9FxzvdM
	 oFVfWzvRvSrFfZUjJLWso1ndlCj0t1vaf66uaca+2kSipx62tXWjn+XumW5OQJgL4j
	 T4S5S1y7EEAGt7l3v09zRQP7DTAhU8QxP8B2Vg2Tp9QhJZlqEaP1j07YpuHi9gJLJK
	 RTsbMzdFpidBi3Q6p012fOaANPqli9LviU2nv30Gm+quxkMLGJbSfeU5/2BANPeULK
	 z/AWiwO1xhFsg==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f16c81so1167806e87.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 09:50:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByjysQEnyK0bN7btSoN6bW+gLC0hUiFVC5DkH5KtmS0eJzvWuEBbMpRb2aBrrfZa0gUMnKQ9eyz79PgRuM=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kwN4MwVwTQzg+E0bAGGN7fyWcnuXMFC/yYZ8uV16R5JVcxRmet
	xFBKlegD88b/V4kVnmz+RJmQGFQdVuNfxGAFbReq490u33SzsFn2OW4LJFcLJQU9GHqQyaoB+vD
	uCpDEJO3SNNes4jzXMrzhSPZyOjQlM4E=
X-Received: by 2002:a05:6512:12cb:b0:5b5:e263:dcc7 with SMTP id
 2adb3069b0e04-5b8b660c1ebmr1008093e87.5.1789577434048; Wed, 16 Sep 2026
 09:50:34 -0700 (PDT)
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
References: <20260909132153.1596191-1-arnd@kernel.org> <20260909132153.1596191-6-arnd@kernel.org>
In-Reply-To: <20260909132153.1596191-6-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 18:50:21 +0200
X-Gmail-Original-Message-ID: <CAD++jL=8g4U-BkKH2zVuxQD1BqHNP-EseUsKzTJNpJFaR+Q6AQ@mail.gmail.com>
X-Gm-Features: AcwNN1W58wTtgVz2clQ_wz9Mlu89xpFs3b5LWAbQ7ez6ueMaGMU5iIjS17A22CM
Message-ID: <CAD++jL=8g4U-BkKH2zVuxQD1BqHNP-EseUsKzTJNpJFaR+Q6AQ@mail.gmail.com>
Subject: Re: [PATCH 05/14] mfd: remove unused adp5520 driver
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
> This driver requires the use of platform_data definitions rather than
> devicetree, but that was last used on the blackfin architecture in
> 2018 and nothing could have used it upstream since.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

