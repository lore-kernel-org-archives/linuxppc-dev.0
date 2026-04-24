Return-Path: <linuxppc-dev+bounces-20089-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536D6FED3EF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 16:09:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g2HwN0Q6Tz2yWK;
	Sat, 25 Apr 2026 02:09:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777046979;
	cv=none; b=N31bwTDfG61ZuyqMmzbSwBQ1vH4L6SsxtbdNUbxYpj9huoqTBMFIbsj3oPk1pfiXOK2ucxj6uyEIrkSV2XjYOZHTc0smCV6xLhH8D2+k9OUzwBYqhKxmPCtlid4YQVlkXhGCAkrMhz7vZ3MPqytG4t7Cb3BuVNJr6Mm6riOp+ZhDe7/VeqtP1xoAIaPQ0qPiiIA1+EyGhiRmzzRhFhM1KGb30+E+v2maJYOB0Ef0LIYBvLs6hHfr1xr6fll6RMw+sKdMpzrVXUIkmEKV1/sfAy/H1RNAfmpo7EF4cdEZRIhubsP0eyYIHfhIbR8Amw64PMBD/0seyPl1heTl0Lvhfg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777046979; c=relaxed/relaxed;
	bh=9cfYd0u0UVOBXOrGcV+i5dgvGDy91DNDc3bcQlfXpMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+NRM+pHO9XCO94ltwjV+aRS/Y7Vurii1vhlukDWGILP+3UGQkGJao1Gu4HS+BBj8TCXOcchKBE+oVKg826hlPPMzuGgj55gi59KmSMuAQRirb/oUDPGFJ6WIqdCqMddh7IsvTkqI/YiEwkDRYeoraxCUIKkReBP/b62obtUfydGya5PNZmGNXaD1HCP3yZ31uuHdnL4AdjrzGc7fO0crIRVy9Hu6uQ0SMg+vHs6Tx1pTNf+fRmrGBSM81sz/B+aiOKCuEgWy0ax9FJgTu4wQBnff3DWPlHS0fFHBAlbuf85SDGac2aOFW2yXjO8T7e4Gb1Q9sUYT2idN+qaLexEUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=O9URvp0m; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=O9URvp0m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g2HwM2sX9z2yC9
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2026 02:09:39 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 37B3560128;
	Fri, 24 Apr 2026 16:09:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C564DC2BCB2;
	Fri, 24 Apr 2026 16:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777046976;
	bh=Bmxf+kSLRyZzILqSP1RoPMKZCg2c1UE0whfFdtgIgZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O9URvp0mFZCPMhsvjttXDH1IlhIbyj3fz5knEyEBnYO404TmAQNnqVVx9c+zd5dCV
	 tzkiqucveNOtwCXDPRXfQgbZnkEJfV2+ucqbLIMefMOMwUiC8s6NeyxmwsOtvyh4Px
	 Q/QVVyHteM+YDLd8AV7nHUgeFJuxBeZ0LvIr7jNLq19I37SrdItjqkSN5VEzDvu25a
	 nVkhoP1WECqTpdnDbDdikQXcDe1nCrMoY8BitNCtJwEpTvEyc9Y5Mswf/Hm2klVyqs
	 SYsJuscHfJGcOU396nWwn0zC5nM7ocgCxoX0QbtE0+ryeC/7S5IWotPwXLhncp9Crm
	 0cIcC4wzoqR3Q==
Date: Fri, 24 Apr 2026 17:09:32 +0100
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
	tiwai@suse.com, linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] ASoC: fsl-asoc-card: add channel and rate
 constraints for CS42888
Message-ID: <c925e9e6-934d-4b07-aaef-a7f737c687a2@sirena.org.uk>
References: <20260424103806.2276780-1-shengjiu.wang@nxp.com>
 <20260424103806.2276780-4-shengjiu.wang@nxp.com>
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
	protocol="application/pgp-signature"; boundary="OOY2g0cHqmoB5HE/"
Content-Disposition: inline
In-Reply-To: <20260424103806.2276780-4-shengjiu.wang@nxp.com>
X-Cookie: I can't drive 55.


--OOY2g0cHqmoB5HE/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 24, 2026 at 06:38:04PM +0800, Shengjiu Wang wrote:

> The CS42888 codec has 4 I2S lanes with 2 channels per lane. Using odd
> channel counts (3, 5, 7) causes data misalignment in the I2S frame,
> resulting in incorrect channel mapping. Only mono and even channel
> counts (1, 2, 4, 6, 8) work correctly.

> +static int fsl_asoc_card_startup(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct fsl_asoc_card_priv *priv = snd_soc_card_get_drvdata(rtd->card);
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	static struct snd_pcm_hw_constraint_list constraint_rates;
> +	static struct snd_pcm_hw_constraint_list constraint_channels;

This makes the constraints global for all substreams, given that the
Freescale SoCs tend to have multiple DAIs and have things like direct
PDM inputs I'd expect it'd be relatively common to have disjoint
constraints.

--OOY2g0cHqmoB5HE/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnrlbsACgkQJNaLcl1U
h9A+SAgAgajMZ4IC+0VYx5rMiGKr2keBas/+oFT/82spBqE6gK9hyGaqIcJ5WhiF
IvT28+aTaGlRBRCyWvxvMhmrciWoNCJQBHiJJVpYLwW2MeCZPHIJp/EF0TcHPxr2
pQ9o73I3ArA1Le9hYYyZVkLIG1hNBA8xfmz7cwVqJ5G2OnQL19aeW9nRUaNfNL7l
bUQEEt3gKskAKtm/pE9b4ZBG5aezx2mNnAJB+vCZVMIyvC8GIu7VPcKLJm7R1/ng
0FsqX01ABGwoBVhgK/A0lm1dd8ffYTCOUj7QxRlnI2j3i6TL1bHfR17hqhRVpt1p
qKxPKVXHmO6BbZmBPGr/tzWNhf3x5g==
=r2dV
-----END PGP SIGNATURE-----

--OOY2g0cHqmoB5HE/--

