Return-Path: <linuxppc-dev+bounces-28395-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C40CA5FA2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 11:26:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htfCf3jK4z2yMK;
	Mon, 28 Sep 2026 21:26:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790594814;
	cv=none; b=L9zgsKwBDdd9e+gVdZC1MMcwEYL2nd2q9HfwGzBPK6Mc3gwQ+p6tnyYMhXWljcAyuXNxBgKaOFFoE8FUevBqOCGLuRaU9q0bYAOqeUwgOsrAGMW28vCIKFkLXXkAtwkqAJtUaNBr21pRzSz/cEHSwgMUiTVlCld21/mkNpOTNH244D5dJuGpn5n3y9CYCR9WnnsS36xa3Yf8Wq5lu7vmle6d4hzwBwuSP/iR+UONNB6EGSemeZoZyE8IjKkQHQKEEr5f0AWBF4oFwi4NbtWcRFjH1AeEKryQ08A7YadX14YmX+9bcwAFS+pXIhLQNd0d609j0sTksib7wUBpD3NjYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790594814; c=relaxed/relaxed;
	bh=MIgiakxNIvlbIOvXbpa9aAXTvVdIjMv2YRdjshxXmZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUiE/R6QIBaep6wWMW1kQ+XosvwCENn6o4EfwcrJYySpcDHbOECzxlQHlRYkPYSXMQnXvFgkkxrJ4rmG95pSs/Rs6G3REONCQ6kVBjZ+hzV2r+OrfBB6I1RT/FMlneZfueCl8kQhRCHAqPWwy/OYoVgJeUCB4YkD97vAz9wB/9HDmlc9HdNLJiIkJdpWTStgDxpXninQJnCLpnx7kmu5kD1zYh2rlr0bUgMgi4BU2IxDUrBrVox0Tj7J/Ftg9ZJnu5fhwGRLb76Q0BCUhkMXTqJZjREt2qE/x0B/ibpwW4YjF/gfojC8f823R5liFNh2zUVGjsk5WEtbz83arQz2rQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ahxNhXzB; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ahxNhXzB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htfCc61Myz2yCL
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 21:26:52 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6540840C59;
	Mon, 28 Sep 2026 11:26:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248561F00898;
	Mon, 28 Sep 2026 11:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790594808;
	bh=MIgiakxNIvlbIOvXbpa9aAXTvVdIjMv2YRdjshxXmZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ahxNhXzBmiYTokoVc3H9EOIJnhTiIRXS8yTi4jkl4NBTZ/Nv4WBvbWNNickZgLD1z
	 tNTkt7Rpv9XxkYAOXiaXinGpn1TVGBrrbxanqOu9maY5zQYsCbj2Kl2WxEpMoLo6lA
	 HyRfdH+ObdVSBA7w4w9JV+SDdnt9JSpXYy2YAyZS9KKWJSWRd9riZxE6F0W6HOVL9X
	 2iAWSuoOVWLw3Ct8h8c7Sh+0rVPFOiRRWCfOZjZSIp8/fNo5+a2/vmeOP2Yj4rEmOJ
	 tDEEBitSlXsbvXPDtbXy8t1DqLoOL26HqgSKvoMF/Kp/L8ROFcPMKaTrW/S34orq3w
	 f7DQ71vdlasSw==
Date: Mon, 28 Sep 2026 12:26:41 +0100
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
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Chancel Liu <chancel.liu@gmail.com>
Subject: Re: [PATCH v6 4/5] ASoC: fsl_asrc: expose individual DAIs per
 conversion path
Message-ID: <7be95093-1e29-45a7-9860-5605763baaf2@sirena.org.uk>
References: <20260928061727.1844167-1-shengjiu.wang@oss.nxp.com>
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
	protocol="application/pgp-signature"; boundary="agS6p3a5qSig1fa6"
Content-Disposition: inline
In-Reply-To: <20260928061727.1844167-1-shengjiu.wang@oss.nxp.com>
X-Cookie: All is fear in love and war.


--agS6p3a5qSig1fa6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 02:17:27PM +0800, shengjiu.wang@oss.nxp.com wrote:
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
>=20
> The i.MX ASRC hardware supports three independent conversion pairs
> (A, B, C). The driver previously registered a single DAI with generic
> stream names "ASRC-Playback" and "ASRC-Capture", which prevents
> multiple independent conversion paths from being used simultaneously.

This and patch 5 are not threaded with the rest of the series which
really upsets b4 :( .  I'll fix it up but please look into your tooling
here.

--agS6p3a5qSig1fa6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq6TvAACgkQJNaLcl1U
h9AZrgf/VFOKxMUjK6hmwAHkqM+y0Ua45JlbNuxKyoHHyV84DmfhdqY51ofpXfuQ
6N+x6DTT+UZJkw8xrPqdRMRhps2mxGnkl0FdOiqAe1dR/VuGMOAck7lF80PMIOxD
CUljelqNF6bYnmr8MQ5qPzYIUn7VEcvZiirLFwT5OHfi5/x37fQUAFJ1YJFgq8MX
fuuBv1DOxVGdXUD5MsFdkcMfd9617FupVjCOhrZFQpTzj1yEvuAnmnTCs02wF/3S
QjBDyIaaTRdUFDag3qQ/tMKwfIJjvLDrHsp2iXwoQUdoL+Ga6f9W+QJUrBcoiu+B
TkSZSFWED6F7dnYsXunQoC0iWlZFGg==
=A3IY
-----END PGP SIGNATURE-----

--agS6p3a5qSig1fa6--

