Return-Path: <linuxppc-dev+bounces-6126-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC953C02198
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Feb 2025 14:58:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YtLzy1LP0z3028;
	Thu, 13 Feb 2025 01:58:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739372334;
	cv=none; b=JKEB21sXw8CMM4vfqLT/cEaJzMpsK4zGqXtsEt2DQY0tELoNNaRhbf/gGyo6PUxeqJ1VprQtVGk/Fpq0L7qDgc8Sa2EjvduxzvEQ6FYU7f0gEHeN+eY59e6aZZ4PaemyqKxpKX3LDeJRDxs3Dm3IH2KyjotZHPKDMv/h4L7xXsZKqBGYTLWPYPmz5GHRDh3PkZieyNHMqGTZ0rN2FjZp/bXDTVNPmq0aaauihW8OW3kgjQirT9nHOkcLgz/CRIzdquRJP11bxWPC6DpGQvvaMhzgNpJ7pj2tPKpUZaIju2TunYDphqgI3W8C+hYo8sDQbl5RTKdKF+Tgk3DSE8e8OA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739372334; c=relaxed/relaxed;
	bh=c8kns5CxPREN1NpIVPXiiqBg8ZcFUasFRqZU8/mMvX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNb7BOPs2HMR4cdmn+KZd5IKt/M4bTy+DBkXxd+aZM5twobiCJfNPcLtRP5uN9oqXU8F8lhygQEmLNckV8L3ixtoxiZGfG0zrx9rU9HLImztSPuSzJHdZ+tyrduZKJBw3IV5v83kueL/KzAH3mSSysr+4Y6Vpmnu0UfTzBahd11DehOwFHUfcyYHcO2Llw52GlfPyihWpAhONimCOPePsPROqswP7ltfwMC5Utjbbg0J2nO1kP5WF2hM2XQ7g8j95BT2Fo783sn5WBYRZfM7IwKxZooLXDAXLZrhnQXJGiJamEB7tHyC9b8MaadYgBViKYdYC6TqoS+B02FM3RSrgw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=vKCazHFO; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=vKCazHFO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YtLzx2t94z2ypP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Feb 2025 01:58:53 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 756BCA407C5;
	Wed, 12 Feb 2025 14:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ABD8C4CEDF;
	Wed, 12 Feb 2025 14:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739372330;
	bh=VfPCsV6WWIedIQpMHbXE7Twk3RA4OVR/ycnIBsYi/5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vKCazHFOn2V5aNKha56y6oXj8E3nQcQFhDCe7vTDA6PTEFuURoB42/DkJS1CYL+sq
	 e+f9mX+XUIP4zwMpyjcVwPJTneK1nqUJSwyt3X2M7Guu0ZPB5QWjYu/G5RuxARTXrg
	 SKX++juExqFMlzI9bU0+SaOTvn2UtCu8X81f9/tNE2hICBtd/PAJSi/npE/+ZWNcO3
	 nWR+H9WwO1HcLvwYGsKzdc9sfpk+HL3sL2b14Yn4b+tnpOiR1aDl+SQT9+Wr4cghc8
	 pKhpA5DHRA0yeinKGgWg7kUNWGKCt356sgaGG6suJfPzeC/F0KEZEk8OShe6AHM8D1
	 ylcVRVJAA9aZA==
Date: Wed, 12 Feb 2025 14:58:45 +0000
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
	tiwai@suse.com, linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: imx-audmix: release cpu_mclk clock at failure
Message-ID: <7e37e951-17ad-4cac-a855-33c48ae0a283@sirena.org.uk>
References: <20250212093816.1857188-1-shengjiu.wang@nxp.com>
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
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fAwhL1alp7d3aLFt"
Content-Disposition: inline
In-Reply-To: <20250212093816.1857188-1-shengjiu.wang@nxp.com>
X-Cookie: Reality does not exist -- yet.


--fAwhL1alp7d3aLFt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 05:38:16PM +0800, Shengjiu Wang wrote:
> When defer probe happens, there may be below error:
>=20
> platform 59820000.sai: Resources present before probing
>=20
> The cpu_mclk clock is from the cpu dai device, if it is
> not released, then the cpu dai device probe will fail
> for the second time.

>  	ret =3D devm_snd_soc_register_card(&pdev->dev, &priv->card);
>  	if (ret) {
> +		devm_clk_put(&cpu_pdev->dev, priv->cpu_mclk);

The driver shouldn't be using another driver's device to do devm_
requests (or really to look anything up), that's just going to lead to
trouble like this - if it's got to look up another device's clocks it
should do a regular clk_get().  There will also potentially be problems
if the other device unregisters first and frees our clock underneath us,
and this will request multiple copies of the clock if we unbind and
rebind the imx-audmix driver.

--fAwhL1alp7d3aLFt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmestyQACgkQJNaLcl1U
h9Bjngf/WfuwuKGeK2nB+kS9poygpKCLuG9wbqSJbBo3TWSTk4l/5HcDoYFMf3Qd
DMjzt+C6i1ZKZ3aL7+jm4sQvxWUHX8ciF0FQqarOjN7ZVbCRNQggndMqphCuaNpJ
TMeIlSrKjSEDiajGNLjt0cbusl/CLP6nsHzfp+HCc2WSe6b12QSqndtJCB+seG9c
jVdR6dNZc2yePUIUVP+MeafpbWpru2KS0N+Fg3Fle0VNhs1TJ1+W3qKsLfUQQStR
Xr9JQdSzrjdIw3Vr2jDyKcWGVTh05G0BsZ+OLCAQo3PuaoFg2/lrs4HP7t7KGfnK
i4hrFK/hPV7ZZkWL0NxgTSGVeRjJ3g==
=Of57
-----END PGP SIGNATURE-----

--fAwhL1alp7d3aLFt--

