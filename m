Return-Path: <linuxppc-dev+bounces-26969-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64880C79FB6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 16:02:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hg5DJ6ZmSz2ywn;
	Thu, 10 Sep 2026 02:02:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=136.143.188.11 arc.chain=zohomail.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788969744;
	cv=pass; b=Q3/63vd3GL98FSxeRl3bwY7cNO9GbTxd3AyjXj1NYhVpp5b9hkqi7h7Nu04s2uCMxdi2Iesm+zW23lWP7mBYyNMnlSEWO5HKcYo3fntMneL65udiksCVHS50rkr98JEGGbUIeM/xgANG5ZkB4sWQi+KrDl56oKNqoRCRZsk3zB+ItKR0z0M3ACXmWyD/9vUFdo0Fn2PUFyaUyQNB2McxM/R0ol8lSdKEaKBdUGa/k5NwdogFQHSexsQ9RjBf8Z+hw2P6DfbWGDTAGdguqNOtY7RKcQEKEZAcXoxn/eKDy2z3p40Ei5xw+yQnCFa3y9v6D/sqtSxTRK/aYfrsjIA8ZA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788969744; c=relaxed/relaxed;
	bh=+2jg2ESPMMGY2dLnVmlBMJSk4zf6hyXqLuJROhsLZFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgAdHFEgZc2Fn4bR80q6spveNIWhEyK4ulaMWpRRReOJCeXJBMM6MM/Oxu5Ln7B/mZeQkE7mX0J0JDQg6RQJIROtRjYGk8KSWx8LogmomZmXuKHy4TF8rMQWsWWTdmc+/DCHiYBrjsssAEeJ+nVYAGxuA/Le/4grf3wCiikzuw6QzrfSowBqA6CHrzMiyvSGYRqaRbXRumMlsTO0lhIPt6szodQF5WXfrVEiq75OSPzWaAGC6fEnPzYF0enNwrOnUljOwDNidclVCnsohSEpXSveX2YMUoV2pvGSoouQZwMwNBrI2gAHT0Y0BAOCXs+1XzCvrZQXjwybD7CuGK7nlQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=collabora.com; dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=RrRxL6K+; dkim-atps=neutral; spf=pass (client-ip=136.143.188.11; helo=sender4-op-o11.zoho.com; envelope-from=sebastian.reichel@collabora.com; receiver=lists.ozlabs.org) smtp.mailfrom=collabora.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=RrRxL6K+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=collabora.com (client-ip=136.143.188.11; helo=sender4-op-o11.zoho.com; envelope-from=sebastian.reichel@collabora.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 912 seconds by postgrey-1.37 at boromir; Thu, 10 Sep 2026 02:02:19 AEST
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg5DC2xxFz2yvT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 02:02:18 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1788968791; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bIP7FxCUP7PHjxh/nM4jKTnSi4O3I6PRlfBOfFxAVACnPdkG1o4ROdKc9mHAKRk9dawZAajHbag1i0Dtm5oZk73POFNeyTsIoMQdqnIex15/DdocxTTJLcvNzHv+8W2Brfrmzqd5aG+ycRGI3Kd6X4Q83AZV8i/HAccJDK0A7uQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1788968791; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+2jg2ESPMMGY2dLnVmlBMJSk4zf6hyXqLuJROhsLZFs=; 
	b=fHK0xZYkJa0EQ8iscGhXs3nCz+azjAIWs6h68cT2ql692DXJDd4uXiAI5yoxp5+3TWpg0puF6aimsbN7lur+FafMxu8awciKl9BP+tkdlvpc/mFm22kHkLG3ENAuLoHnilj1qqzm/Fi5AAKKvOLxax8bDHgaJF7386Ys1Wsq9ck=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788968791;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=+2jg2ESPMMGY2dLnVmlBMJSk4zf6hyXqLuJROhsLZFs=;
	b=RrRxL6K+fJgetX/zevzIf8shNUQZ64sHRap9E0npkCTqOSQIKdGw7QGQsmmT/nEh
	MDEWBwP3A3JSNrYY6AU5UVrxINL1kX0CeJRhDr083WK6iOkhdTlz+KNgeB67XQeShiX
	D9sDnGwGS2S6atyJx9cWGAcEY8UQgBcy05nf5uW0=
Received: by mx.zohomail.com with SMTPS id 1788968790593167.81978655910598;
	Wed, 9 Sep 2026 08:46:30 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 24C93183377; Wed, 09 Sep 2026 17:46:21 +0200 (CEST)
Date: Wed, 9 Sep 2026 17:46:21 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Lee Jones <lee@kernel.org>, mfd@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Arnd Bergmann <arnd@arndb.de>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Guenter Roeck <linux@roeck-us.net>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@kernel.org>, 
	Michael Hennerich <michael.hennerich@analog.com>, Support Opensource <support.opensource@diasemi.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org, 
	linux-doc@vger.kernel.org, linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, patches@opensource.cirrus.com, linux-watchdog@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	llvm@lists.linux.dev
Subject: Re: [PATCH 06/14] mfd: remove unused da903x driver
Message-ID: <aqF_GZq1C4Tv1JB9@venus>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-7-arnd@kernel.org>
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
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jrej5ylckfdda26t"
Content-Disposition: inline
In-Reply-To: <20260909132153.1596191-7-arnd@kernel.org>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/288.959.6
X-ZohoMailClient: External


--jrej5ylckfdda26t
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 06/14] mfd: remove unused da903x driver
MIME-Version: 1.0

Hi,

On Wed, Sep 09, 2026 at 03:21:43PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> This driver was used on a handful of ARM/PXA boards until those
> got removed a few years ago. Without devicetree support, there is
> no way to use them upstream.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  MAINTAINERS                           |   1 -
>  drivers/input/touchscreen/Kconfig     |  13 -
>  drivers/input/touchscreen/Makefile    |   1 -
>  drivers/input/touchscreen/da9034-ts.c | 365 ----------------
>  drivers/leds/Kconfig                  |   8 -
>  drivers/leds/Makefile                 |   1 -
>  drivers/leds/leds-da903x.c            | 145 -------
>  drivers/mfd/Kconfig                   |  11 -
>  drivers/mfd/Makefile                  |   2 -
>  drivers/mfd/da903x.c                  | 565 -------------------------
>  drivers/power/supply/Kconfig          |   7 -
>  drivers/power/supply/Makefile         |   1 -
>  drivers/power/supply/da9030_battery.c | 581 --------------------------
>  drivers/regulator/Kconfig             |   8 -
>  drivers/regulator/Makefile            |   1 -
>  drivers/regulator/da903x-regulator.c  | 495 ----------------------
>  drivers/video/backlight/Kconfig       |   7 -
>  drivers/video/backlight/Makefile      |   1 -
>  drivers/video/backlight/da903x_bl.c   | 160 -------
>  19 files changed, 2373 deletions(-)
>  delete mode 100644 drivers/input/touchscreen/da9034-ts.c
>  delete mode 100644 drivers/leds/leds-da903x.c
>  delete mode 100644 drivers/mfd/da903x.c
>  delete mode 100644 drivers/power/supply/da9030_battery.c
>  delete mode 100644 drivers/regulator/da903x-regulator.c
>  delete mode 100644 drivers/video/backlight/da903x_bl.c

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

--jrej5ylckfdda26t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmqhf0gACgkQ2O7X88g7
+ppaAhAAjamgA9v7fn8KcrThl75UZh6bOUT/5XiVqaq9zEwVJoY2fygDVmYao95K
QhI39+RMyWRuGdnDCBrpw0eVA53PbFPc1VTm+Iw4FWehLC1skbbSwDpPLFSIZaLe
DJlLr11UbevMyqcmNKw8yeRolbQfUbAA4leflpjAbhhEvAzotNSeIxLY3yFHNXoV
hJsWKIRE4cFFb5bsx3qTlJFQMop9WidRYq3vdPeoGVCUW2zjROm5drG9e8Hb2dvd
I1KgIIFgyn2WJYDlD3u0eLwYZk/YabwYv3PUfxRXIXRS3+JMzwA3ubQyoMit/SHv
MMH4/sJdjtgUjUcnWKA9Ktle3BQgYFr80H6HHHaBoFQveCC2B/98B85Ev0wwi9Xa
60t+RHmELFKX9TnD6o797ZxnsXxErlDhjl+UZhEKQpsQjKwBQHnV1RzX3QLFWYkv
i16c5MyNzgDusXB4zpTBiAy/kVNKUysPwY13R8BBvr2NsQcBf9uYDTRHr/g+3Xd4
wquTx7yb8tYLUn6cJr9jXHrSseS5TpMUu+8scdSVZBC9KSuaeRYigm5dLM0X6Zj5
vmXaD9vlAGtPL7fv+zomhwt4Ufe51v2YGxWa8IQSEsyOG1eUO6zdfFIiajXpgBTR
mZ6OWJdhnZ9sRSQVANNafU85fqkka6x1/ZAQvqaKPBGVE7bXzhc=
=3btz
-----END PGP SIGNATURE-----

--jrej5ylckfdda26t--

