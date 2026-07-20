Return-Path: <linuxppc-dev+bounces-24499-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC8EC4452A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 14:28:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3jYq045Jz2ySN;
	Tue, 21 Jul 2026 00:28:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784557726;
	cv=none; b=PBb3IbA89qb+l2ajHX054irEjCoqfknMTl4XCoW0nOEMCp8PIGieXKWGBmRuA5EOx+FKVuK0CRQD9+9bWm7YkB6PZ98aqTNM3z5PYcPRZX9Nml08GGNxu/avTCpzFDrabY/Ppp7bnMW8ozn6ApGtNHg/8kmCc5g2qsJv1lrbd+Bjeg/t8Z75f56KRXGXzaksJAESi+BZfappC5C2i933GvjZRxLY0NvySaQdkRbckVeK9T+5Fmx08HzLUwtCDdySW2P3cbYPp6ySt1rcxMZxUCfTbCIDrR+Xofs3yt9cnmFmOo1+oifmgdwzfQn16WtGJNX7MQCDjrd8QXDETHkoNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784557726; c=relaxed/relaxed;
	bh=YGgq0kgANQfSfLYugyd1czX94b3DsWuJoJbSm/P4QPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R7HWAX++c5ucJo8odIg9nof+1BfrBtqeXQQFrOdicxI/sELkEMKF0ckAiCckudF0q8f5kUrGLdwxq3LSQKHKfeZJ12ng4YwomA1t1sRFNuOMgszOqrkPqiXp1GW3H+Zdx1X5ojBFDvLQx8ww6W0Pehh0TFdG00nbOS4kHAgNid+gL9z5PQE1VvHKkT1TIP69jzCzd/qgQGFlt8Y9qWGY05mm0ieiuJe+Jx42/D+30OXzk3ZwAQJYgn0Cyaqu2fWv6DLXUM/o0vmSxoXLBdwHeWZJXQnnY+cbE7NB8wNeKD5hvPmusZnAGccxOYWdtVP9JY1h2taVtG/Kj+9DF5c9Hw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mmjA/ibQ; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mmjA/ibQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3jYp1TVwz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 00:28:46 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0826C41093;
	Mon, 20 Jul 2026 14:28:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40541F000E9;
	Mon, 20 Jul 2026 14:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784557722;
	bh=YGgq0kgANQfSfLYugyd1czX94b3DsWuJoJbSm/P4QPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mmjA/ibQFEKvbtDANfHjDwYzondvF8dCGbOlKvcYXhqfyoFvsJWBlVT3fMQ4CW2dV
	 EsVz1jSEX9nkyB2WD2Kp3gIZPs9paB0Ex9FU6eEBnLbe/2SYPmdcBX8juues0+1VNL
	 dMhG7MgxWgHpzUCpZQZlbgxXCNh3a5jbFg2UrmL4BDOwV1BKNxBAV0mHb5i2JqpxsF
	 QREQ1LPDXsK1d/CsVddkt39zQPKqPhUzNy+P9b+IpoZcw46UMTuiGuR+6xPoeKbed3
	 RSyVwbN5yXBs/7n0Ss5NcADewMl+VwdXAExwUvQ+oRbA71IAIlG/zoPt2nMGWzHetl
	 OVpuzQYTUwazw==
Date: Mon, 20 Jul 2026 15:28:36 +0100
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
Subject: Re: [PATCH 1/4] dt-bindings: sound: fsl,imx-asrc: update port
 binding to support multiple pairs
Message-ID: <3ce4bfa8-b051-40af-9478-00540019680b@sirena.org.uk>
References: <20260720095450.1618747-1-shengjiu.wang@oss.nxp.com>
 <20260720095450.1618747-2-shengjiu.wang@oss.nxp.com>
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
	protocol="application/pgp-signature"; boundary="UXRfRhuyL0flFFDD"
Content-Disposition: inline
In-Reply-To: <20260720095450.1618747-2-shengjiu.wang@oss.nxp.com>
X-Cookie: Caution: Keep out of reach of children.


--UXRfRhuyL0flFFDD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 05:54:47PM +0800, shengjiu.wang@oss.nxp.com wrote:
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
>=20
> The i.MX ASRC hardware supports up to three conversion pairs (A, B, C).
> The existing binding exposed only a single generic audio-graph port,
> which cannot represent the individual pair endpoints.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--UXRfRhuyL0flFFDD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpeMJMACgkQJNaLcl1U
h9Ctbgf/aH7yDt8XXrgvezUpFfpFQ5mZqqk3wPckaCo6daYpU4BG1u+NUAKBzvhl
muNUxzj7qKiFil/axJI6oSs/DwlazpzaLVOVlZI+GiLaec8Dv9QaKqpQFs7E4lAF
/V1cjx5SJ716WveCM914F7i8GWb8H2XLBo++jlEyTgOE3JRiiewPmrLl9HgSaA8B
ZxIIA+4GBGrmjPn22q4Sbs+orGPuVYBQuqyrsJYi5aGn6ANHdl/Qv2lEleJwqgWG
XcAMLGE16UceqIkZyJOQZf16dODg0S7zSLSJ8UuujFWFfxmDNuSs2Hm+X1eY7A4V
Sgyi6yiw5s3KskslFOtv5jPz7bNC1w==
=Nq5N
-----END PGP SIGNATURE-----

--UXRfRhuyL0flFFDD--

