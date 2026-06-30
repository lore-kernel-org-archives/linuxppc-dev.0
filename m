Return-Path: <linuxppc-dev+bounces-23195-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E05C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 13:25:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqP5g6Z7Lz2ybR;
	Tue, 30 Jun 2026 23:25:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782825911;
	cv=none; b=JEXsd2vAMnQxo1vbVWyzDcuOhEgLkpA4HuBT/ADLg6gJB4vc/Q3B6N9knQbSY8pZVluHgu9XGWKA/J0SHh0Myfc4fXJkUoswt/OQp4XumQKD+MElN5KVQ4PM2EFRlMG+OCevixo91WgWlJoAkC2wZD6P323wh4/MFxU5p6iC3T6j9494JbsQ5V6y/2zr639n31sQHLursPng+YOHvgJf/zQJslY5QzjqjXoyrT+P4AfCj3CCeAWWs/U1ScPqNGJz2NyNQkrtT3G5dnX+V6ag2lHuk/lt8+yDAj8J3weNoq3WiQltpSWsVar7oAKhE+Cm5i8Q6P95VVpGtzI1OQ/dNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782825911; c=relaxed/relaxed;
	bh=aN3AhlhZvp+Vej1wTa9tcQgECOaxstihSa4ef2eA6j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGycceM4mP2MCTm1xvIavPak1VpsmLOVAqCs5GHursLwiFxiunVNNEJ5gklvACjavcr0DbXAYQkeT/a3mn+VgvIzViVhGqm7uX0UVKMyxpFzsvTkVjwL+/6upvwdcV8xWyHNsbfQe4U49mvFOkBncTA8EjlVZRJPqYLcVOwQXNGkfrItDyLO3beVndMYifkeNI3wPawYynFQqo3ZU6euUN1bEKZgcd7QuXq193OoSn6D6d87BHBsb+GaTWLF0KNHSi7tprl0wcMR9+AzS+7DMY1rYkcrsEm/mDe+AkEyD/rS8kvDOspkqLzvWQL4UbkNVO/DnL1rdF9e/x7D5DNDZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PPGrUUeS; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PPGrUUeS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqP5f4r5dz2ybQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 23:25:10 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0488E601C1;
	Tue, 30 Jun 2026 13:25:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941CF1F00A3D;
	Tue, 30 Jun 2026 13:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782825907;
	bh=aN3AhlhZvp+Vej1wTa9tcQgECOaxstihSa4ef2eA6j4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PPGrUUeSl/XrMhQtEga5FLzhwJipIBhyy+Cl2YlPEKnbd13fF0wc9hMSdiRwnO5S/
	 FsEv3G5Wtln7mjfJypkaeJ1fqn4Cr962msmXnlH308MOswPjSfDa71eOvV70fDxfBw
	 IIuq33OvNwHzzY+yCmZxkbm7mxAG163Gq3135+/QCZctY+po8c49SgYbekXWt9X8LC
	 49nyZ7qXskvfBjTypvDirUlkvZB73efQ5s1/g6t8BNTc0AgADRndfTp/gFf1ewvG7m
	 XXOHBNhXt0DVzo8/6yuzsFoz5QPQurWFcm1pJmv4IuCkLUNkqOGXFbXabcdCVjL72R
	 8pQTfvoE2PB4g==
Date: Tue, 30 Jun 2026 14:25:03 +0100
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@oss.nxp.com
Cc: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
	tiwai@suse.com, linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] ASoC: fsl_audmix: rework runtime PM handling in probe
Message-ID: <e0367509-358c-4ace-a7b3-56b903cee0d9@sirena.org.uk>
References: <20260630124016.645114-1-shengjiu.wang@oss.nxp.com>
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
	protocol="application/pgp-signature"; boundary="k7GzKw/gt5Rm2Xcy"
Content-Disposition: inline
In-Reply-To: <20260630124016.645114-1-shengjiu.wang@oss.nxp.com>
X-Cookie: Air is water with holes in it.


--k7GzKw/gt5Rm2Xcy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 08:40:16PM +0800, shengjiu.wang@oss.nxp.com wrote:

> Changes in v3:
> - address the comments from sashiko.dev
> - replace the pm_runtime_put() with pm_runtime_put_sync() to fix the
>   race of async=20

I already applied v2, please submit new changes with these updates.

--k7GzKw/gt5Rm2Xcy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpDw64ACgkQJNaLcl1U
h9BvwQf9Hij/dQrKYeOKMveHecl8CVNUC7XqMFWQpw1P5aqN+PrK+R9mZnTrKUxe
S5BpWKmNeEN4hwPpZA2FfPZlKoRWDN+3/ecyQWqBvAy6Vl0ThGKMWrzxYhTvov0C
nanG7svDN36m8qyiitKuYNGB1c/FsizZe15G4Q5PPM6Z/7fbFC7asTAUQVaCJd3K
T/m3WsHbzYyqEmXPSCgHJU9fwroFT1/aclyUoscscLDEAaFrfQi1A9W9s0CH0nzt
V3G4dbU0O+xkA+zCDsn819YOv3ighnoJIVumTQFlkv91FXYfUUnO+4MvB+wWlmJX
Qn/hQV2+4tWeSOAhCJYBgyF+dz6AZg==
=Gc+K
-----END PGP SIGNATURE-----

--k7GzKw/gt5Rm2Xcy--

