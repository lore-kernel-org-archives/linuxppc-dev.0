Return-Path: <linuxppc-dev+bounces-19849-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B9DF588C1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Apr 2026 12:50:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fzlhW4B8cz2ynn;
	Mon, 20 Apr 2026 22:50:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776689435;
	cv=none; b=cAoDR01w0TjaRW9Rluw4m1ge9I9Ex3OiGuQGJGR1t+j78yjSXFfodhmtlGaV4jPn/HELRTKUR0T0tJid5fM87HvfOimi5fSWObdx8FZYbxeULTB22TbXqObb+5z3AOLr6q3YGIlBY1wOeQpTQEXC+BiLdDlpT3myAMyVoxPAy+mCG1zjixc80Ipv0dzeKIH80rpunvBMbYs68+a0BnXfgYD8NYPDKVIvULhSDamzAZDgjyz/7KboIoQmuWGapb1BNuO7J+TAzWJc8fVcy5qy6uVchrNuMJuzW9gIIU1qpDiths83xbml/4q5Mpu9meynLZrRHy28Xh4vmWHdUXrNyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776689435; c=relaxed/relaxed;
	bh=JA5D5Lai+x906ctoJM5XVa8H3mRw6/oPTglOWqaX+aM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VquXYN++JSPI2DR6Ud+CIthZv2UZC07q5ceA7QSYq3hsqsQv3+k/EZ7PcWlB/gXnqsOXHCJPqLk6q2zAWIU/myRo2ifG7HKhiAmB4KiwnpE1+nPl60J4H2PSCuN0LbgvbgX/bcufcgSYyIhfi7t0zz0Xnv5fAVS05tNKntXbXpfulC34crRsn2JoZ/t2XhK2FwknmX73qhs6GYzahBE17ofrVQUpZ895FoXlmitMRFOXHkmAMkrjcOO1LuZ4JGVR+lIHwsgsZfaF/BCVQG+T1seku0B3v3MslZVwSpU0zNFUY+rntZyT5jUQ6RPIlxeieAb5wXEWpLYQMNjLYK1fPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ErFvZhLY; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ErFvZhLY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fzlhV2JK7z2xll
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2026 22:50:34 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D29B060055;
	Mon, 20 Apr 2026 12:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741BCC19425;
	Mon, 20 Apr 2026 12:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776689431;
	bh=xTIIm6v0aDSvm3HYaOhaWOqM1+ERQmESsoyqC0gy2jc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ErFvZhLYCAbOYtZB5cf8nFzowfaWmqIlzHDrYgZOwAlRd+mB/ObVF3AY+Z67NZO1A
	 7d5wh23h/7qfyILBYz6Dp4Sge8caG/OaqOPxjA+eeNP6ckMwYFwQE8lTkfsEHnaraL
	 l+xeFvDTZBtdZ7vOg2nkcgggY+Czj+982kopyvxVcWiH8Qu8mbel8J+hnL6ZMXMGdZ
	 qqtkRx2YrAsl3MmCCZkmHiqBvEIimWRqE6cjc4zzuLXfs8FfZkYTEVJwUwKWH2nLNu
	 nsFY+8lD/HvolznL/3BBG1ySRdti/nlBKDhAj4AucT/EMY0k34Q7ygP/u/6kVyJF0/
	 OQcv0NE1VAg2g==
Date: Mon, 20 Apr 2026 13:50:26 +0100
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
	tiwai@suse.com, linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_micfil: Add DC output remover control
Message-ID: <6c6f94b1-a4fa-418a-b471-8e3c82305233@sirena.org.uk>
References: <20260420085344.2081805-1-shengjiu.wang@nxp.com>
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
	protocol="application/pgp-signature"; boundary="flMtTIAJpPEILprL"
Content-Disposition: inline
In-Reply-To: <20260420085344.2081805-1-shengjiu.wang@nxp.com>
X-Cookie: Sales tax applies.


--flMtTIAJpPEILprL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 20, 2026 at 04:53:44PM +0800, Shengjiu Wang wrote:

> +static int micfil_put_dc_out_remover_state(struct snd_kcontrol *kcontrol,
> +					   struct snd_ctl_elem_value *ucontrol)
> +{

> +	if (val < 0 || val > 3)
> +		return -EINVAL;
> +
> +	ret = pm_runtime_resume_and_get(comp->dev);
> +	if (ret)
> +		return ret;
> +
> +	micfil->dc_out_remover = val;

...

> +	/* Update DC Remover mode for all channels */
> +	ret = snd_soc_component_update_bits(comp, REG_MICFIL_DC_OUT_CTRL,
> +					    MICFIL_DC_CTRL_CONFIG, reg_val);
> +
> +	pm_runtime_put_autosuspend(comp->dev);
> +
> +	return ret;

This will return 0 not 1 when the value changes, meaning event
generation is missed.  The mixer-test selftest should report this.

--flMtTIAJpPEILprL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnmIREACgkQJNaLcl1U
h9BIGQf/RpXGRbf0pZBOYDwpdzOcFiJwjjmkZadSsDpc0g3ybn3NjnIwvfOKtMzN
jebpDFBtsmpudB7+wkjIEzme/PdFYUrlj/wu4ZPicIkREErh12fLTibTLvTI/YHQ
RKbMge93GcT2FW9mQi065RluhNvCGTdp7wCIU1X6b7Qwsv8KxNfSbsjwVZUyqLK8
7rhdWKJYJfhMr0a/zQNXexCNbs2oRsKK23Jl4Q++GWwz1oXe/b0W8zvweavk8baP
ZJP1gE+NnwAWwP6hDEi/ZO9LiVI3wlWphUIIpawkPiuHbg2MF3PQuTJ2jGocmDN/
ThfvgM8/pO6z5Z8YzWyClLREtSzekg==
=HZhI
-----END PGP SIGNATURE-----

--flMtTIAJpPEILprL--

