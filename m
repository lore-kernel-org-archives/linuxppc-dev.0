Return-Path: <linuxppc-dev+bounces-26939-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5827AC79FB6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 13:27:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hg1n96dGrz2ysb;
	Wed, 09 Sep 2026 23:27:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788960429;
	cv=none; b=HDpS4doRrEXBEsTlQJa/t8ykueM5EJZ64z9xI/XcNwP8KrtxgMv152T6mDdrcYAlnhl0VAuAY+wo6MmVqSevcBh5g2ocYX3oRvlcI6Q2Fs77QHOn+AvDn2/MHAQZSK70NAzQC7bSoZW26o8/kJpzaejJ3ovA53x/DEfJRRNVkw1T4XOQ4DGlK18VMoYJo5zM4vHbfiHUBpzW/JqFw/zLtUj7cpWRdG5eWbhEziBUCJdO7R2OANbzrFzibCU1Hylq5Kt32zE3+LtXMI81fhcP8Xz/xlpXdwLxvDx0g3GiH0TxEro15fnpzFLLUrLrDqXa5CoNzYT8FqDzQRKGXXqj3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788960429; c=relaxed/relaxed;
	bh=DyJDRtyrOiFKO4N22eNPlSOSoe7akPPD8qIhnTft0HE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/Mp3uoOg8tyRtNg6sI0lZPMS5jOECXhRKtwPa1UHM2KrbF57TUIA8RjKsvOQWrFTawFfpDtoxp7jShtVl847zctZFq9dQN/JWXAWbp2abRAQiVT14bp1GghS5bu1O0Q3qu9mLHgvwnGVT2/g3lKKjbNyueRCxNyq/4cCl9K3gLNW221Cd5rQAlSgwAk+CY6B4QM3ET/PM7xK2F3EUF0wZdYkx8+D1rrLn0yuZRhQdD8L0kvRSfCCVxkVS/EUmPcy8VRLMKa5gMyKRrA+uYa7VB7UpPc0UOfKVEPd49CbydCw9FVkIXoHcZoMyBIJVTzTOberFJhlPutserlDl/tMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d3V76u8H; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d3V76u8H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg1n90WJvz2ysW
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 23:27:08 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C5B03408EE;
	Wed,  9 Sep 2026 13:27:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EEA1F00A3D;
	Wed,  9 Sep 2026 13:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788960426;
	bh=DyJDRtyrOiFKO4N22eNPlSOSoe7akPPD8qIhnTft0HE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d3V76u8HnL5Z9pp4wy3RQNKchXYH8Otyy77S95DJ9zdGw4fkY3ln7i9VyqIQNPugH
	 67vnvr1VdyHiYUE16sqA1edVX0+5p1B+4leYRShc4bGimTF16H6SwlccQVeQ9P1GaV
	 79EujtWYDBCd57UQY4UJO3hFLhuOu829nBfyeDhoNfF00lIbpzQsToP5DhNQk/Jl2f
	 e9rRo2eqj7UX/Uo4GA8Ug5R43G7wtrinEnnQS89I6mVMsoASHk07UlMMBfRq+INx0E
	 OV/UNTkewM0lYvKt1pPC5ua5XkuZk5vuX+YrEydfVZXlcoT+fZ98HTlxzyhVI0RNwe
	 +DGHfUWQ6orHQ==
Date: Wed, 9 Sep 2026 14:26:56 +0100
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
Subject: Re: [PATCH 11/14] mfd: remove unused wm8350 driver
Message-ID: <64ddded6-e140-4bdd-9a66-ebaed56e000a@sirena.org.uk>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-12-arnd@kernel.org>
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
	protocol="application/pgp-signature"; boundary="OTZg4QPdZD4DW1fD"
Content-Disposition: inline
In-Reply-To: <20260909132153.1596191-12-arnd@kernel.org>
X-Cookie: Postage will be paid by addressee.


--OTZg4QPdZD4DW1fD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 09, 2026 at 03:21:48PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> This driver was used on the i.MX31 ADS reference board from Freescale
> and the smdk6410 reference board from Samsung. Both used platform_data
> based driver probing and are now gone from the kernel.
>=20
> Since probing with devicetree has never been supported by wm8350,
> it is clear that nothing can use the driver on an upstream kernel,
> and it is unlikely that anyone is still interested in a devicetree
> conversion, so remove it.

Acked-by: Mark Brown <broonie@kernel.org>

--OTZg4QPdZD4DW1fD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqhXp8ACgkQJNaLcl1U
h9A07Af+LjyYi8M0LVR+2guh7aV8ps1LJA/pBB1O0OjpYy1QtH9cEK6q9ImsQnRT
0OPXYfJXJnrnuoai+hsB2yjzWOVjtPoJx6g9H4vKQTyS2Od6ZegQLMuRIVgMXBiq
7Q9Wi/uOmPQmoVG3JpsWWCbl1HIHHaT/bzPDUIRW+DfdETAzm41UjqD7/+q+M/oW
sZ01BjqHwsbUixQGGxH5ZHxohPrcBx/q87mgegdQ3LOXXFdIblVJEBC7bYcolvyo
h/HDLlK7wy4//jPZ0Q40odTi4mfgG994PZSxCT/8HJQgcyCHVjOV0F+12N+zKyTd
Im9GhJ9X2G4I9k7BipiAnpgrzM3Ohg==
=v3Pm
-----END PGP SIGNATURE-----

--OTZg4QPdZD4DW1fD--

