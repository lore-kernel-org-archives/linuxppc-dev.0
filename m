Return-Path: <linuxppc-dev+bounces-26940-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC88C79FB6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 13:28:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hg1pK4FS8z2ytj;
	Wed, 09 Sep 2026 23:28:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788960489;
	cv=none; b=fNUUX/c9ue2kMqXroowLlHVXeKhX8WS2K/kkyxEgRQrTyirqTtzI9pH4StW9/voDNHITIU6CJ+VvPZS0AEg/jFd0SWVD/vIAulPbnZ6FLPO0tHM9CVo9vqDz5jt6JSouiO2lAyj/Oxl6NOXQ1qOG3Y4Lo4LM+e+ukOdolbVC9tA31ncF69mk0zqtE2vL43AHna6mQ5tKGkLyceeFdcMqv5Oni7FaSnMJlew0j+/2tk8hSATjKoZRFeIN88u0fc3jjs3fu3IAmoEJnFVRvoTyluXgvybRFCR1ufzv4aYVpiamKCwb4iOn3v0fPlrtVHmJFMf8ZEEmE9mM2o2DH9LsNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788960489; c=relaxed/relaxed;
	bh=/hlzJNzei2knOn1RYcaTNkb4UoqZbwgVsH5KNit1MHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oL4Gf1Ejo13TVf1mbPp8qZFGMuVOxiQRoiDRaZVVD6UBdJMslmyefK9J9m56jwGedW4gC+rpKTGOYHlqiDua2xTSlZFNOa91MrKGW9xCEvDStbDPrxa+om6zadots5c61uxNFXSlMu5FQz8X6kzR+xw28dh2QFJXFxl4x1ImBkgXcCBtI6cbJD+puWI4zu7atn15r0MasRwPEkg+BkRLlAqvIkZAHgjokLlZoL8ABrWaYkeBxO6N5oDdcszEBu6inFZWBIjdLfxvkBr7qeOJEn1LvncgJrtwtrO2xP1x6ReoKH8ZC3psZRXVK1YLxzRFKHPTAX3sskKe5wPiBc9/aA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eR5D3nm1; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eR5D3nm1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg1pJ6hTlz2ysW
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 23:28:08 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1193D60216;
	Wed,  9 Sep 2026 13:28:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C301F00A3A;
	Wed,  9 Sep 2026 13:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788960486;
	bh=/hlzJNzei2knOn1RYcaTNkb4UoqZbwgVsH5KNit1MHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eR5D3nm1CPgbjmHPZ0Vv7T4vdNRF/43OgybS94gl2A9fsyrl4gGmKe6vwaT3jfTzX
	 +jD4I9IGrYtGuGXb5/A7jnHJvsDKGHllhymRTLq9kCq/SQi87n+n9y8sD4xk8HYc4W
	 1FMZTsqHXMX6M3yTH47nD27tyCXLTKlR5oFEGKYxbRLJ27lUqEnoIOljlrumgyldGk
	 vQ0EiMkovKU1SvLxEK2ji2FQp/hgc7rRh1M5u3fknsEg1fK7g7esz94rpEqvklnBCa
	 BYmZFTXxMbawW0CHZITqBgDveaise1uxWGeZVkrhXq8mgPMzdHFvBAlr06emaY0HNc
	 eC2FsYwPx3u3A==
Date: Wed, 9 Sep 2026 14:27:57 +0100
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Lee Jones <lee@kernel.org>, mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Sebastian Reichel <sre@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
	patches@opensource.cirrus.com, linux-watchdog@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-fbdev@vger.kernel.org, linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, llvm@lists.linux.dev
Subject: Re: [PATCH 04/14] mfd: remove unused wm8400 driver
Message-ID: <76d70b0a-a3c1-4051-84c9-77afb715c4a8@sirena.org.uk>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-5-arnd@kernel.org>
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
	protocol="application/pgp-signature"; boundary="E7vTznbJl/k8Ppdd"
Content-Disposition: inline
In-Reply-To: <20260909132153.1596191-5-arnd@kernel.org>
X-Cookie: Postage will be paid by addressee.


--E7vTznbJl/k8Ppdd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 09, 2026 at 03:21:41PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> This driver requires a platform_data definition, which does not exist
> in the kernel.
>=20
> According to Mark Brown, the hardware supported by this driver was never
> shipped in production.

Acked-by: Mark Brown <broonie@kernel.org>

--E7vTznbJl/k8Ppdd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqhXtwACgkQJNaLcl1U
h9DKkgf/RLbTE5UB6RL3Q66U8VBY9ivEji//LxLXmZDVRMWW85M/tZkuimYXhr1H
qRZzWzsDpkIZhMa5DFLZxJGgVhSyRq9lmv40QYt8TboWu0+dKRy4nuB95+RSTNWh
fjmkSjHkD/A3ELOP2Q/9B/cCFXsbGXHwS8eXeJVkuaDa1BSP3E7o1l338kofZy5F
KyFWqJgxYKL/U82xSTvj04+NKj++SorlCIGShW9hgF11hhNTRHMwW8uF2pksnopN
W8URlMgbSAEsELUabpsbzCFqwtnOJZU2y2vWAICyNt491Nctuj5oUx6D3c0HFsnZ
z8z8A5SciRK3sUB/+Uh4thfPneAMHA==
=lTKT
-----END PGP SIGNATURE-----

--E7vTznbJl/k8Ppdd--

