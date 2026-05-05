Return-Path: <linuxppc-dev+bounces-20435-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1D3FF885A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 02:21:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8j1d12DPz2xH7;
	Tue, 05 May 2026 12:21:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777947685;
	cv=none; b=S7cdhcUEdGb1hcgIXlxEt5CP+ZWEeTRQFmAqJh22Gx4BPXfN7S+Va9TkHhO9PgJuFAFNOhiZa3ZPRJAd8mIHxZnMeW6diuGag+XGTqn8sHzLSPeua8j0JqRQZbuu1zfeFRKjIIuNH92eH7BbOHmn4k0WDL8gPbYmKi84Mw9UBUCIZTsUI/I7f0wtdM73pv7r0nzK4Z3x1SrJkYQhW6xCEzgp43OaCnO6xFbPkFCm9I+1bYwfaEL3ygPX13QLx04AcMZpEd9fdVWVfVT6Kj5SE656tWWArglzxHkH3hwbxyyKLqPWRIp+h3Sfj407jVSpyBzM6rBmf5NSaFLvtX6tJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777947685; c=relaxed/relaxed;
	bh=unmh/NzLauaJRbPvFNyUmXNZp8PhEMfuHX3iK6/vqVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGZBk7BFIGRQiz+0/eU6Rt4LX2Fg63LlmPUmK5ayfSjjux9yryhNEo/6pmW3LlAHZKZdj0RcSntQ+0ViJSs9njEry+mEQhh+M4fZ8dTZBf37rcZR+2gMZeYV+xVwrjAALbDg4xG5C8WUYy2qsWLVfIa6x9SrMXNNCgj4WzBBrsc9XZ7qFGeRrRVBa6G9cMJ/0NBRPxqSx610SRpC6ea52V1wdTPlCIkEZQuO3K424sGLPVcXFDv8mxo83i15ozgjqfFLo4aTCrxoWYt15pOZQqg4065Vwr3Wzb4HKzlqyElU1ApRbW3myt58vzjCG3u+KmO1/w4i+2FaONnPX8dB3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YhViaJCn; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YhViaJCn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8j1c3Pn1z2xGc
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 12:21:24 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C2EBD4451E;
	Tue,  5 May 2026 02:21:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86AE0C2BCB8;
	Tue,  5 May 2026 02:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777947681;
	bh=JO2IMv4fsRX0ZcyGTHisLvXxtyNEwmC3NfmP+6npWNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YhViaJCnZ9Iqwy4eVh+l7NLp5EUAgIDkA7qwztzRtOqY3Ju4IaOnqMoidw5NLSn8q
	 6m6WfGoxc/ZpKHOWKBmFoSq9bV3nbO3t7ikomujp8b+jM8QkXUH9Db16fgn3PTpJ8P
	 7g4k1zRU0ITLxxrrM1x5rUpU1p6uI68qWt4lZtASPF7ruQUc8Xu7buLCt7kXCXGNQy
	 tbbHU3DWLoalLFOKt+jB4jn3Tt9L6g/fq+bERDHLb+1IeeFHXDk4r+M2B1jQwCpdmV
	 ke79exptDwH95rFi/UDlLZS+/+7unvKCTRc8+XmouyppdN0nPVHg+Lum2/drHPxY+N
	 LYw3CMXgAjU3g==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 6D4FE1AC5871; Tue, 05 May 2026 03:21:19 +0100 (BST)
Date: Tue, 5 May 2026 11:21:19 +0900
From: Mark Brown <broonie@kernel.org>
To: Chancel Liu <chancel.liu@nxp.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
	shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
	nicoleotsuka@gmail.com, Frank.Li@nxp.com, s.hauer@pengutronix.de,
	kernel@pengutronix.de, shumingf@realtek.com,
	rander.wang@linux.intel.com, pierre-louis.bossart@linux.dev,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/3] ASoC: dapm: Fix widget lookup with
 snd_soc_dapm_widget_name_cmp()
Message-ID: <aflUH_mk3i_IDkac@sirena.co.uk>
References: <20260429021252.691263-1-chancel.liu@nxp.com>
 <20260429021252.691263-2-chancel.liu@nxp.com>
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
	protocol="application/pgp-signature"; boundary="H51FCLIJf4TpdLl7"
Content-Disposition: inline
In-Reply-To: <20260429021252.691263-2-chancel.liu@nxp.com>
X-Cookie: Alex Haley was adopted!


--H51FCLIJf4TpdLl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 11:12:50AM +0900, Chancel Liu wrote:
> Currently dapm_find_widget() manually constructs a prefixed widget name
> based on the provided DAPM context and compares it using strcmp(). This
> happens to work in most cases because callers usually know which DAPM
> context the target widget belongs to and pass in the matching DAPM
> context.

> -	if (prefix) {
> -		snprintf(prefixed_pin, sizeof(prefixed_pin), "%s %s",
> -			 prefix, pin);
> -		pin_name =3D prefixed_pin;
> -	} else {
> -		pin_name =3D pin;
> -	}
> =20
>  	for_each_card_widgets(dapm->card, w) {
> -		if (!strcmp(w->name, pin_name)) {
> +		if (!snd_soc_dapm_widget_name_cmp(w, pin)) {
>  			if (w->dapm =3D=3D dapm)
>  				return w;
>  			else

This means we can't use the prefix to disambiguate any more -
snd_soc_dapm_widget_name_cmp() will strip the prefix off.  We want the
prefix in contexts where the name is specified by the user since the
prefix is there to provide for disambiguation.  The prefix addition
logic is a bit weird and I'm not sure it makes sense, but the search
based on the fully specified name we got is something we want.

--H51FCLIJf4TpdLl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmn5VB4ACgkQJNaLcl1U
h9CupAf+MGqhy9yn/GtWv68HU9M+CSI26hbO/33u6YCfbI8rVD5r3sVvsPny+nIS
Hjcpp4SW27502ByKDEE/6t2CNSBpJS0Z3YbgVr/nlsyhs9zVFbvBb3W0BTO10USD
1cZyS1qeifNAglMYVM8zaR0YIHll+5NWVR4kQr2mVyOt6rOlfa6gVQWBpl5QlJbY
327ly0J96cBfeR/Irzq0/ya89I4HPIJuCRuIpn8MJBWY/cvQl6l87qWAVoDpk0wX
RTTkhF/PhREqDYMSDame5+VnaEqr2PJXZgu/MJlpOOgAHWaApnmfnVM62sUZXfkg
POV16q9CbmYfk2lJbW1huCz+h5xygg==
=YkxC
-----END PGP SIGNATURE-----

--H51FCLIJf4TpdLl7--

