Return-Path: <linuxppc-dev+bounces-28124-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1307C9830E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 17:03:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrKsv5y96z2yD3;
	Fri, 25 Sep 2026 03:03:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790269411;
	cv=none; b=S6G9mw9WgD+a7nHNTlHl410W3tZTF2LVIUpms8R7PXMBZTSZtWPpiv4FV6cRxJQM8waOeeEyAUsYWW5YoEsZV/uMx1rzIGNmSkdKiTkhd/tqoR58Uip5K8d2QKff+XYZw4IJWuCKmRbKWTOHmKqRxVwG3ghg9dymFSQW7XAdND+7vc8PncbAkO5MCl/MkrkRGAC9TIOrSK8v9f/ifAL0AGDu1tuCYc8zJfqjrmRQBiENc/lO082542JweQK8jWgWGQNr7xmXsNohFsUTpIGci/Jlg8PUGRUgntuKjU3V08e+wnZ4Sli6TMDuXvM5vuq4stITcQS3jY0rGSspkhQdzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790269411; c=relaxed/relaxed;
	bh=WUIXMGlF00n/an+XIpdJzwcraIyNlcy2fVXrbp/3+vI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TK3blOkN3k9AYWb6iY8dxPH8bZ7WzFfE4YWKMql26a6ztFRZaqFMSRJlogqOtqQLc67hoQWnxDdN0vCEKk8l/wjLel7lcsj6K0J1/gNM8cGs3Zzb7Q5TSlFQPp7B12NshaAwU34bCisbHux24YjDTi3ysK8tYWMZ72ZmIPwy1svErlxfEpEAFFBs0qmbj4QqGNie6a0tMYSLYyJ6cqIxXA6K/0t1xVoVLJaHoT8pC3mjlOHgYkzYnUwrnBbMddfy/bzsuO2WVYo4OOsTg4gwmiKRhNf9EhXBrsqe3qQaunvdr4vbAxTYbcUJDmpK9uVVJ0ViBvOyWjjxd3cpXpWJ1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C8sPSa+p; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C8sPSa+p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrKst2PJcz2y7Y
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 03:03:29 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 653B0601E4;
	Thu, 24 Sep 2026 17:03:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA6A1F000FF;
	Thu, 24 Sep 2026 17:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269405;
	bh=WUIXMGlF00n/an+XIpdJzwcraIyNlcy2fVXrbp/3+vI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C8sPSa+pp//4QY0n2InsviILwO2ANC2TmhgCzyKFTFL88X1OA1rd8piCZ75I9NYuf
	 fEC4gZaibZp2Mu+2cnaTVOycqGqUN+E9Ir2xIWEGVyYNu6SlG/wx/nOI6//uR1xuM4
	 SzEUnwUkjRl2qhzU1qZe9tmBaUl+HYwW3ds7tqxVGzCfdWyeX7dlIOsyUE70XAxjMu
	 a1FMvSAzwEYZrtkuHzbC+3WNlKr6kjS85sdATWW8JqrBJCfxxFOzOz+bs56EPWukLg
	 Caw4bVrWp2lhFZChfGOJzssdpZ7QUgtYQEDQOIS3Fyfy1xEhSduphAsxvK/HcrHISG
	 ZL+oTMyBJa+Ig==
Date: Thu, 24 Sep 2026 18:03:18 +0100
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@oss.nxp.com
Cc: lgirdwood@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, Frank.Li@nxp.com, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, shawnguo@kernel.org,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com, perex@perex.cz,
	tiwai@suse.com, linuxppc-dev@lists.ozlabs.org,
	Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [RESEND PATCH v5 0/5] ASoC: fsl_asrc/fsl_easrc: expose
 per-pair/context DAIs and fix DMA race
Message-ID: <744ce325-9d2e-45c7-b7d6-15ec7558dc83@sirena.org.uk>
References: <20260922033428.1690822-1-shengjiu.wang@oss.nxp.com>
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
	protocol="application/pgp-signature"; boundary="thyvYpNwRTH7ReUZ"
Content-Disposition: inline
In-Reply-To: <20260922033428.1690822-1-shengjiu.wang@oss.nxp.com>
X-Cookie: What's so funny?


--thyvYpNwRTH7ReUZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 22, 2026 at 11:34:23AM +0800, shengjiu.wang@oss.nxp.com wrote:

> Changes since v5:
> - rebase to latest master of linux-next

That's not a resend, a rebase is a new version.  This is all confusing
b4 badly, it's not picking up any of the reviews as being attached to
the v5 that already exist and doesn't even look at the new version since
it sees that it already has v5.  Can you please send a v6 with all the
reviews pulled in?

--thyvYpNwRTH7ReUZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq1V9UACgkQJNaLcl1U
h9BVcwf7BCet5mcdSMq0zC0cNsA9teLN9+P2zlswGHdgRRU40PVwEFizlbbS7wZl
DOt1x1P94upHDBxOIj1BQlE2NH0CCx1Ndmd+GoJ0iq+zvPD+6wWhehE1HJyf1odN
tHP8B7rCqkWXpKyWwPhWuQ7K6CjRo524433hqpLMfwEwIi4cRw2AIDPEJZEDxe4G
YVIw8Rs1M9mOcSeAW1AcEx6zW8ZRr9Fcsl1ZL4z5iOj7rBRVLjfy6AKbM+Xkekpf
3JcHWVENhCGh1J2m2PHfK3X4eKOJzRY/QJozB9KyoB75lQHUiYpC9msiJ+F4IN2J
2IKKSaDZ354mcPpf2uwWiGkUJN/bEw==
=1Dsv
-----END PGP SIGNATURE-----

--thyvYpNwRTH7ReUZ--

