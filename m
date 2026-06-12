Return-Path: <linuxppc-dev+bounces-22573-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9373DCD98CF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 15:05:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcN9R1bZrz2ytJ;
	Sat, 13 Jun 2026 01:05:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781276715;
	cv=none; b=bH4dbHwH7Go6/SQXxuEYDdnVKDjXn/V2uZqyFVElCw0yuEW22cB1KzjQblp4HrA2inoYpVnaTD5sRqa2hRFhBvw7VuAlDYtplkfXGCzTZHhKWECirOykZmTgaJfGKhcbfShopNjAvMayVQheNH/2tII7aZNaxDyvFGUG3o+kopX1htzyymy7E6r4xe0SXseEdmyPpb8Oq8Rhsmcxn80h6Hc0Ioabq/SEVzX5PSPAK6ynegrLDJjHnD0I7ln6lIZB9mHSdiKiyu16AmCnpmAL/gWGd5M9I/JlmPKB5KjZ1Vbmdj73ShZsF7cO5R2MQ9PSC13jEOL5Nmna64i92EmseQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781276715; c=relaxed/relaxed;
	bh=9RAbFIw0jamNPl6PD31GkbyejBwj+MRucx19vqfzlvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMS6c/zbZnPvGFsPMD8gav+Eze3n9sZEId33IFJgZNK8xpDkTpsWqTyhngnDbP0x5rTaJojwWt7+YepVgVq4kwGI4b0s/rFKygBWI/PyEjdXzrJUtkR4lyU49hwb/eg9vX7pGx80HyzMBQmwwBR1wX7aZG8QjKmKdse/flSGrHY20BjWvLIwRQ02+uFZnlnjaMLihwuYXZIPe4biimzoByX6Xt7ScUDau4Mf24P8IlUIoDPRY+a0LAYS1YVCyU9DZcY75WRbrYiRuyJtr94XfiPfsQuzZAm3NIeow6z7FlCGzGuVqmaQrcYFLxtemTcSYj8H6R84D2j/ZKXENxiDXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BV3KTv5D; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BV3KTv5D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcN9Q1mlLz2ykX
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jun 2026 01:05:14 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C913A40C21;
	Fri, 12 Jun 2026 15:05:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C8C1F000E9;
	Fri, 12 Jun 2026 15:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781276711;
	bh=9RAbFIw0jamNPl6PD31GkbyejBwj+MRucx19vqfzlvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BV3KTv5DAe7pofu/YoU+7QCEDYAss1lut0QgGf+ZAw/YLG+VjpmDtd+ZNmOg4aXrp
	 a8O4jgwr10lulxIMSmAu8QT3H/CREASd4ANPG2zE8sqdpMmQqerVn330n3jqfvJeHO
	 Csz4PW9uwgaInmQgdJr0TvRr6wWBGGnh2Rmu+PrO0JQ9GSD5dpWMrx71luE8HxJ1TF
	 MRuqUhd977WEf0QMV0/VksoJhILqD21C+qkSGjCnJ8iXYFReZxqSsGu9mZpmp7REnz
	 dVdywULgKQ0homL2sVlf0B3M9jWEmLG3mFfdjHg1qyimse6FfdTye6/HCpq5VNZb/w
	 ApMpj2vjiRfMQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 681511AC5ABF; Fri, 12 Jun 2026 16:05:06 +0100 (BST)
Date: Fri, 12 Jun 2026 16:05:06 +0100
From: Mark Brown <broonie@kernel.org>
To: phucduc.bui@gmail.com
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 11/11] ASoC: fsl: mpc5200_psc_ac97: Use guard() for mutex
 locks
Message-ID: <aiwgIjVqa4PeGjRQ@sirena.co.uk>
References: <20260612132639.78086-1-phucduc.bui@gmail.com>
 <20260612132639.78086-12-phucduc.bui@gmail.com>
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
	protocol="application/pgp-signature"; boundary="78eYuAPeqMdiQgRf"
Content-Disposition: inline
In-Reply-To: <20260612132639.78086-12-phucduc.bui@gmail.com>
X-Cookie: Nice guys get sick.


--78eYuAPeqMdiQgRf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 12, 2026 at 08:26:39PM +0700, phucduc.bui@gmail.com wrote:

> -	dev_dbg(psc_dma->dev, "cold reset\n");
> +	scoped_guard(mutex_lock, &psc_dma->mutex) {
> +		dev_dbg(psc_dma->dev, "cold reset\n");

mutex_lock not mutex?

--78eYuAPeqMdiQgRf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmosICEACgkQJNaLcl1U
h9BWkwgAhUG/BmHjT9vHm05/5/nin4LjC8fo8dB0dxAhqUOforJ+jokmjumsPz9h
2ZIsrszudxyiYPjue+UatceR/7Jjt3fAQSGKO5JeOPF+TWKW/O9LhpNPG0PFxoX3
6JIvxheh6qUaQgcu6I2opGcWRkNsUogX0ms9EqaKqMqdl9GsXaB+DsebpRpT+ig6
IesvG+gspxw6bxf0zQJ848CK2TDYnYC6pIeh1sfTTpOKXEq1cpiov+ub9GkmprH6
huycDqa5UDHqqRmfSaERRr0JO/dKd6OxYG5rLGFBT9c/te3hhgLDZcqFh2Czp5er
lBlS5G0zOAZKOmQW6E5Wxh3YgRh+0Q==
=f0Pg
-----END PGP SIGNATURE-----

--78eYuAPeqMdiQgRf--

