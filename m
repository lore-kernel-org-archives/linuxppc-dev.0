Return-Path: <linuxppc-dev+bounces-17715-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 929C1EB7ECD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2026 11:23:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQr016Pthz30hq;
	Wed, 04 Mar 2026 22:23:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772623425;
	cv=none; b=DJsbXzVJ0oKnHsb8BAaH8EHm1xfAfPZwEL1IGLHh/Yruv/Zut5xNA3CtpzGz9I3XTLKc9jfRjEBoJu/vmUXuz0XQyL67aqZ8bO04iQuUFVcb7MG3RJ+eM3ripDDTSO21lrW7BLsPEU2IAXkgmSxPSIJRtBIWR7MNTIeq/nXxVzAF6PnnM7Xz8edpyVZ5y4DtPPURyQ7fT2uZnlpvlc6eWa9ZAj6orF7jrjsX2FmY1Z7Y+84nXAfZONJ3fHzH9xN/J4opFQccUlMgcnMc76T7EfKHq8+63BhGe53yNJPAbCFL4+ORUmjPcoJz3Ye5oN7sb6Odj6Su7Xepv6C0LGs5GA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772623425; c=relaxed/relaxed;
	bh=C6thk8aDkO3+RFrMj6Zn7+L4aByacKorBxGcYucUwVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEbKUUyQkjwIBjqgohs22iifgUoeuUi6ef7l0WEzQg3Z6b6ttZVoybfCM7iVtv+YPn9sJYeGyZNVQB8Y998IVxvCdaIkrw57R6nRDHbuH28WL29XI/ejAE4Tk0IMR5bNzim/CkL8L0D6J+TSXdLmCiOHPVgf0RfcFCz4Qpk5LiXQ762bguqMlH0+zHuzFEQjJay8sXHLjBe8L1EN/auJsWBKE22h28kVOROCI7myEQ9lkvbbzhuwHlcueb6b2r0CvSsC32VY3TtBHXojpeETudGqbGPM4HJ6FkEuDbcvDCg0wg8Hcu95x7Aou84jp+Qm/E0AQlhyigMIPaiRY6B1FA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qWQyvxcV; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qWQyvxcV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQqzz5c4Dz2yY0
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 22:23:43 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7540B4423F;
	Wed,  4 Mar 2026 11:23:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458E1C19423;
	Wed,  4 Mar 2026 11:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772623421;
	bh=h9cK7pBF4PrYZeuQA4C5C9xLaF0GsLQIP8AyKutBfBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qWQyvxcVOI9I/fIn34XDL82Wiv/j9A/0CO+HIzbod1hKepstSs1YL1ATVeJEuknoO
	 G1E4RF2B/MFABg8S/0HhAy7IvbBvPtrGcibTxXxqkZQ7xBDxvBJC+yaoeOlcsC6Ee+
	 ndfD62jjuB1WSwU9SVxtgMsERFivVEvg8KyfWfUpQ6HpK0FeTcVeHuK+vhjHF+mHdR
	 7iIAPaFKpFinAHvRkXItep1op8e6chjhnFmk+4fHsAdkX3yQkRo/ZVscYgN2TuR0Cp
	 cg3k1KseLgnQfcRh46WMlVr7dOefgQP+hRWN1QSYHzDduu6zyCnUwr/opYJn6h1XZx
	 PclxjlJCDXevA==
Date: Wed, 4 Mar 2026 11:23:29 +0000
From: Mark Brown <broonie@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Alexey Brodkin <abrodkin@synopsys.com>,
	Vineet Gupta <vgupta@kernel.org>, Scott Wood <oss@buserror.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Dvorkin Dmitry <dvorkin@tibbo.com>, Wells Lu <wellslutw@gmail.com>,
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Reichel <sre@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	netdev@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-amlogic@lists.infradead.org, linux-leds@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 05/14] regulator: drop unneeded dependencies on OF_GPIO
Message-ID: <31c9910c-8157-40bb-9128-9db34704d637@sirena.org.uk>
References: <20260304-gpio-of-kconfig-v1-0-d597916e79e7@oss.qualcomm.com>
 <20260304-gpio-of-kconfig-v1-5-d597916e79e7@oss.qualcomm.com>
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
	protocol="application/pgp-signature"; boundary="zVeDWCP0gn6RDW1P"
Content-Disposition: inline
In-Reply-To: <20260304-gpio-of-kconfig-v1-5-d597916e79e7@oss.qualcomm.com>
X-Cookie: Take it easy, we're in a hurry.


--zVeDWCP0gn6RDW1P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 04, 2026 at 10:02:26AM +0100, Bartosz Golaszewski wrote:
> OF_GPIO is selected automatically on all OF systems. Any symbols it
> controls also provide stubs so there's really no reason to select it
> explicitly.

> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index d10b6f9243d51574a9ac662b93d4678cd7d94a4f..10e64e3ffb1f5f60e0b62b16ab513f002a42fa1f 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -1232,7 +1232,6 @@ config REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY
>  	depends on ARM || ARM64 || COMPILE_TEST
>  	depends on BACKLIGHT_CLASS_DEVICE
>  	depends on I2C
> -	depends on OF_GPIO
>  	select REGMAP_I2C
>  	help
>  	  This driver supports ATTINY regulator on the Raspberry Pi 7-inch

This is a depends rather than a select, though it's fairly redundant
with the arch:

Acked-by: Mark Brown <broonie@kernel.org>

--zVeDWCP0gn6RDW1P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmoFjAACgkQJNaLcl1U
h9CHUQf+OxkRqulw7IQRBWvsy5b7fUXsBVsAfKiGM5xDUpiNuKd4S1A6tLOnAn45
3I8XeQGoX3PGjjNCIQsc3+Tsta1x1lKnTINxC1oxhPg4vuQF8O96ExfK5rw2SbNu
wIgQOz00KrJnhI/QkBNPEUhw2mWXzQuqkwd4ljTlDlUXJCwgc0bWAcR6W7LWq9bW
YeqQrGM7BM83jHyDJAFQsnVLeA6gQM+fV/LkZSTwcNYN3SMz3Csdy3wlcHOEpkbE
Tl7qsVyLstyKIr9F6wUeYRPOH2hl9/Oi9cTvCYBRu1CK/zLsDPyczcWKF0yhfMaO
Q+nIB9oU+/dYWlYxHma+RHEckx9A8A==
=6Y+O
-----END PGP SIGNATURE-----

--zVeDWCP0gn6RDW1P--

