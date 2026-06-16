Return-Path: <linuxppc-dev+bounces-22698-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E59CD98CF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2026 10:48:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfkHW3vhrz3brH;
	Tue, 16 Jun 2026 20:48:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781606919;
	cv=none; b=mhiYnFhtsuCbjm4f/anINEFAWoWWNSJtV3HyyiRsLb/yqfTCzJt6Csrbe/K35Wo3wuPSYhEVkHp06I5/SEjRUREMsbO0EY8iKnyB8qWcqqqM9PGAfVyglql0rxO01KOMrW6S1IAmr3sn7aVY0DLWIm+Canykrq4shyxbqPsx4GbO2I+J5UvXDTkveznig31/+1E76kdoa2vcyVJrTOIGtxQ9zNUAmWP942vC6+sXWXpAtTYEbNS/A6PzDws/9GKVC/mLfxDYLGMqR2r8NFDrretTvMhyF30M3MJchr7bFGY8GjXU302sJfPxR8uca3G7nANLyP8AfNj7SEtm6bEBMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781606919; c=relaxed/relaxed;
	bh=lHAFcW0nG96oh4/5rGfxXXQpPFLmRkRujWnlOBdcS5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVdRjdY1ZGsN7IMlRdkiHWIjdwNQa+4IuVCuhdU67VXxC4K03cfDgni64vn5WaDBzbYM+ttzdklMEaD7i5BiZysQXSNZqpbIJLfCWey+70QxMYqeFSTyXFe1+LVufogPpz9kLk4sjc3J0jCRsY7qpDnyN9UeV+I8mxkFeqsBFYc/Y3oPCYc1qDsSRKFqim1IcWHGXHPDTmufLyNxApvobj6NaxSZ2wgAWcg3MDuTdBCTv/szp/Zge+jIwms4S2WGNtxWLIc7JkAnOed5bUdXYvZlZqyp7PZLZfcOGRVblfG/vqo2+2GrOV8R7F/5vD5hWEmPEcRwniEQAvQ2NDRHaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XViuzm9W; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XViuzm9W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfkHV4Dy8z3bqM
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 20:48:38 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C2D93600AB;
	Tue, 16 Jun 2026 10:48:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FEF01F00A3A;
	Tue, 16 Jun 2026 10:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781606915;
	bh=lHAFcW0nG96oh4/5rGfxXXQpPFLmRkRujWnlOBdcS5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XViuzm9WsVpI0YtxUgSlGg544D0RfGK5rUhQFyvC1lbqfi6GlR0aR44R+y+/zS6zV
	 odUuEINSC55wyGU84DBa9UUb0VcMuDCKNAvZ4oKUpt81wD64chqA7tPgDm+N2pFEXP
	 ptlTF8Er7gxBp244++ukyTuc+4mEQn0R6PaWEcxVt2qGu9kUXkZ36o5Ns9NvO09Sf8
	 djOVXfbcrBYKkw03Gf1MfPxgFNajAnsZuH8hVpY8yqIdEgRYPW8qqgvaAcuu4zMrhW
	 dJ69LX3UDo6ijvzbIbhTh3BRxWifkPLhh7Xo+METipXWGsm8w0yLqS3dAYZezNTqyp
	 zN0nTr7mkhhxA==
Date: Tue, 16 Jun 2026 11:48:30 +0100
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@oss.nxp.com
Cc: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
	tiwai@suse.com, linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_audmix: switch regmap to cache-only mode after
 probe
Message-ID: <a5a652cb-d6bb-45a2-a1f5-ca540b34c115@sirena.org.uk>
References: <20260616030038.4170204-1-shengjiu.wang@oss.nxp.com>
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
	protocol="application/pgp-signature"; boundary="0QxAaZebDU/txdAX"
Content-Disposition: inline
In-Reply-To: <20260616030038.4170204-1-shengjiu.wang@oss.nxp.com>
X-Cookie: Password:


--0QxAaZebDU/txdAX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 11:00:38AM +0800, shengjiu.wang@oss.nxp.com wrote:
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
>=20
> After pm_runtime_enable() the AUDMIX hardware block is powered off and
> remains suspended until the first runtime resume. Any register write
> issued between probe() and the first resume (for example from DAPM or
> ALSA control paths) would target unpowered hardware and be silently
> lost.

>  	platform_set_drvdata(pdev, priv);
>  	pm_runtime_enable(dev);
> +	regcache_cache_only(priv->regmap, true);

How does the cache get turned off again when runtime PM is configured
off?  I'd expect the device to probe powered up and then be powered down
and put into cache only mode as a result of runtime PM running.

--0QxAaZebDU/txdAX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoxKf4ACgkQJNaLcl1U
h9B7dQf/W/e8VMHNcIYJXnNZsr/kx8uz9FBbVMYpPUftjvAh3scxQ8UUQdJvAPbg
tKXGbdyhKSiPUVqpX8l4uqDUYnl7gbtwBYJqto2bwwg+iiGyo2PX/tXPpwODzAqY
LIXtws7AnKUAJ/biDa8btHIRjein0m496mC31pphbg2roK3Ohx0WVrq9kjV/IeBO
LlyxMHSeYr+4IEDhjvifa2+kMH+4JusPTp5Mpg9uU6Y9viIsgbX9lBmTY+VVEVST
6WlryPoyIxSJ+U8+N0UyjqkIj/OdSS8Hkvb4PCEMryn1EqXiqJWFqUXpDdEvLn7e
D5lh6XRTEOuKylHknmTLPpepZcx6uQ==
=7epm
-----END PGP SIGNATURE-----

--0QxAaZebDU/txdAX--

