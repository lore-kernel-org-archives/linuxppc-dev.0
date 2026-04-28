Return-Path: <linuxppc-dev+bounces-20229-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5EDCFF886C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2026 08:48:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4YxW3v4bz2ySf;
	Tue, 28 Apr 2026 18:48:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777366111;
	cv=none; b=Inj+1VNUU+dhBmmXbLxg9uI1YoMwqHvMF9vOgS3DHPt0qZbQPX587fVlCPEYz1Zh6IR4pdvspIjpI5669Gg9f7aO7ngY5h6k2qAOkm4Hnq4GM8AUdBTHszLryxblARULwDDQtyfpvrzPDxkqoWi0Ec7cybCPr5QFcY1Q2LtznXnc6ALfpYZ1m2qU7JD7/ZdSpgjWfMcRd260jpzXkjHCJ1T921sKPD86KqNs/XBXC9+bjSh/33Jz8uKj/gI4nJqA0iL8/hLoj8IQzzudoV9rErelhj56xefIqm+itTXVUMF7UM99JCbegDfe4Zry91Z2D0j6drqAqmELgL/zjeCOWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777366111; c=relaxed/relaxed;
	bh=yRm2k79xTisXBIWWt8D5usInaBAOhjC3Ue5G7GGc7y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRp3LGom05UKC98ociuuXSh5eqdu6OU3u0n8ecHhfhVpOk0cwfxRyuLfWTGCyrxI9ZWgq+3W08dsZgDct/7ym8Z1zJyA5QE2ArkKI4Mvzhi1K6sfzpyu9KT2mAwu32M64j/Ukq5PVbgxe3xqewbr0B5Q2ou6ypOqFNjtTQxP6tkXdu3PCHNoz2EjOgLn8Sl0p2tHagSBym/QLELom3sO12v5UcSyp+fGky/hCWBOZ0EnO9zOk0NfzFDG05Ep1X9yF4Tv3STzheJ5ocKiC598RqW2RQfKb+da7CBYLUdadigTUMsTS5U+FX9JVLawyXhF0py5DTK69rnW+jgV/Rlq9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Z1UvRjJE; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Z1UvRjJE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4YxV5MYRz2xld
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 18:48:30 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A5CA660141;
	Tue, 28 Apr 2026 08:48:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A22AC2BCAF;
	Tue, 28 Apr 2026 08:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777366107;
	bh=mYuU6MXaswUtoHhacsBHyqLEb3RQrKd2tVDX/wlE3eI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z1UvRjJE6dflfyQhl8JY3L4hVKRTdb2yQn2oMGAXOIbVRq0ZE7yZrHlCJiQWzyqOO
	 Ayl4xpG2K9JvWcjNz6M84OnOonhmyhzMHQSWPUKF70T+ZedmFx4i6rIq8l1oGhDjJH
	 /p4D/qUIvM2cdbG/6+bIUxDPrDJSn+Dl6gwmVi0oh6fY9PCddZGxaVzSLwgaA7sSzQ
	 j/F8H1o4gReMWS3wfLhSk+uW2mBiTSAYnrRi/6PWHd+4xq4UuHFidugqYKbhaopTOD
	 ndEHGwLH3UfYPox7uUHMjZullYmSdqb+weGzUd5oNgqJovNthw4Vr8OTgr38Myi8q9
	 NFTyzHQvLk4Yg==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id EB9C01AC5841; Tue, 28 Apr 2026 09:48:24 +0100 (BST)
Date: Tue, 28 Apr 2026 17:48:24 +0900
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
Subject: Re: [PATCH v2 3/3] ASoC: fsl: imx-rpmsg: Switch to core
 ignore-suspend-widgets support
Message-ID: <afB0WHueZ5AGF3Vi@sirena.co.uk>
References: <20260415081942.4183108-1-chancel.liu@nxp.com>
 <20260415081942.4183108-4-chancel.liu@nxp.com>
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
	protocol="application/pgp-signature"; boundary="9UPrFDxvpRfQw9KX"
Content-Disposition: inline
In-Reply-To: <20260415081942.4183108-4-chancel.liu@nxp.com>
X-Cookie: Victory uber allies!


--9UPrFDxvpRfQw9KX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 05:19:42PM +0900, Chancel Liu wrote:

> @@ -274,6 +257,15 @@ static int imx_rpmsg_probe(struct platform_device *p=
dev)
>  		}
>  	}
> =20
> +	if (data->lpa && of_property_present(np, "ignore-suspend-widgets")) {
> +		ret =3D snd_soc_of_parse_ignore_suspend_widgets(&data->card,
> +							      "ignore-suspend-widgets");
> +		if (ret) {
> +			dev_err(&pdev->dev, "failed to parse ignore-suspend-widgets: %d\n", r=
et);
> +			return ret;
> +		}
> +	}
> +

The other error handling paths here have a goto fail to do cleanup of
the of_node in the platform device.

--9UPrFDxvpRfQw9KX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnwdFgACgkQJNaLcl1U
h9A7RQf/QUn+qnt2gIgZyXelbB3F/TVFy2HzRTJNgNigI/pP+0D9evGIAfFSilHe
bY/DChXlgzVcbleDy0tYinjOEJCFWMFbM5geexzQDCeLBVttOFJBxGFg+6miD3ny
XBfA3eBsgWML7fjtuVl8L9VvSoY/VqAxOlVd0ezQQhdPv1/+OTZ6tKMC2sfijJQi
OEo5m8hZpyStL9ez+64ZtCGJp8YjUa4yCqjEnqqCRvVAiJZCySLZHY3qQx19x4F/
biWimRE9KOg4o7MaSjodS1el8vIllMT13FpJMud9r3TnHhIgG9IRNrUdtdgBtriI
lVH1KxPbEDVL6hP8ny9Ick5+7MOiaQ==
=7KNo
-----END PGP SIGNATURE-----

--9UPrFDxvpRfQw9KX--

