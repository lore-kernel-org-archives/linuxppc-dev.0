Return-Path: <linuxppc-dev+bounces-27638-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C15C88E72
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 22:30:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hm9Rt0Kvmz2xlY;
	Fri, 18 Sep 2026 08:30:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789684201;
	cv=none; b=gnqc5DGOrBjMZszk+SeJgzT3pqh1zu4Atvhk2Tdli2tybWfj/VNSIPpTXSoz3Zbr2PMe8YfmyLtU2S0BbVyAsNozfwjOChhbdnGRrYFIHwR7KMtccvCuTNP9j3NsTp0Mv6l7XE9Rw/gYbszl4A1bu9vsLGvd1udoOVboingKi2C7/E2ePFvgK3W07asPthIiAxb4VNb3gm1lH4wdVa2BfBLdqWvTlVfnj7VJcQvrg+7+2PkWW3hyh6mASjPT4ZkVFNfq4F1PAR1yWUKKsR10qEiGAzo/6tEpn98uUR+GP3cwK7zyqGAF6CWL+QpEJvrGvWpTIJjbSSKBNWulOe+XNg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789684201; c=relaxed/relaxed;
	bh=zF1jZ2y/W2JhFoI4myqzn+siVnTYK47RwOCQ1PPgOqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUmeb5yIrG1/VlFxvVDd/SqKvNwS1AMUNn+R3YjdwJmjeG1WisTsUkqQ6Zi/GrnRyvl7aexHxRSg1tLE757Xyy2dcEp4vZvdFEuIcUGCpaSPvGg0tVDEasGKS0rg9V4wH8btsqch56bWuu6B394Q3YkQ3iIY0lUpYEbOWLvrTTHTApu8puqmO13cgJy8B58KFcZDWuuaq/MGTJx0etKNM5q1Zb0dJW5V0OqUOzx76xqxTdLu7Rom22CwWiJS34lRThSlAHELxKQ/c0VCVtn74Z929DhtR+VNhurknKFSjJsQ5+AFLAZwfncbqoozGtRpggBwEVGNAyTpiEh5H7wL1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g3DrAFGC; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g3DrAFGC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hm9Rs20N0z2xfT
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 08:30:01 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2B4A4600AA;
	Thu, 17 Sep 2026 22:29:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695AA1F000FF;
	Thu, 17 Sep 2026 22:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789684198;
	bh=zF1jZ2y/W2JhFoI4myqzn+siVnTYK47RwOCQ1PPgOqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g3DrAFGCXodJgXf8lrkUeFKFopTWa2xYEacf93xGv6ZYtyLzyqKtzaaDe3MVfDFqD
	 An3uxil+l8Uf4hVzs/Yrp1kg3B461zNoGzoIiRmAs96LnaDYhPdxoe9NniGragGqIj
	 ++L9k8HW/31w4toD9phIV3nZHZcCddEBiYL9VIrsD9PC76xCRrvyzBVwmnPgw5Ti0O
	 lyvJEPlcSUmKkk0X/uOGuxgBjyLlLu5J0VFp6O00EzFu+Nh97JEKTS85orxDXcxrpE
	 bAEby48luqnTPVMvrI1nOmmUgO+G5XK7RY4D3dToafgBREG2C7HkKf5SX0F+OhebN5
	 FoxD/BXF1NVCg==
Date: Thu, 17 Sep 2026 23:29:53 +0100
From: Mark Brown <broonie@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Xiubo.Lee@gmail.com, festevam@gmail.com, lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, nicoleotsuka@gmail.com,
	perex@perex.cz, shengjiu.wang@gmail.com, tiwai@suse.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl-asoc-card: Fix codec device leak in
 fsl_asoc_card_probe()
Message-ID: <1ff14ab8-fa35-45c3-abcc-1075a848be2d@sirena.org.uk>
References: <20260917165654.2163461-1-vulab@iscas.ac.cn>
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
	protocol="application/pgp-signature"; boundary="daAMsHLhBjcveUdx"
Content-Disposition: inline
In-Reply-To: <20260917165654.2163461-1-vulab@iscas.ac.cn>
X-Cookie: Whip it, whip it good!


--daAMsHLhBjcveUdx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 17, 2026 at 04:56:54PM +0000, Wentao Liang wrote:
> The codec device reference taken by of_find_i2c_device_by_node() is kept
> in codec_dev[] and never released, leaking the I2C client on both the
> error paths and the successful registration path. The same slot also
> holds the reference of_find_device_by_node() takes when the codec is a
> platform device, which leaks in the same way.

This doesn't apply against current code, please check and resend.

--daAMsHLhBjcveUdx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqsaeEACgkQJNaLcl1U
h9AKRAf+I5U/zFfzbOfGdHHHyloZBavITTecgnUthXRxd031B60RwgXz4kFI59vb
GLorypBTYwytxvXSpg4SrNRYJTjDz2vD8o7oGPjzTDn7Hwb4ZlaiywYisezZqg5C
KOP9AZfQgIRao95uGpkPoH4EVi86dOUYUbUaU6z16GLkbPHI54svv36Y4qbTTi8I
SpBGBEOAu7rm5FJdTPg/eZtFuO3bh2Cdggd7oh/Q/oijLlaOt9MhPrHHP25CSD4W
kjzrjfmNBaQUnOD222LZd+aMQLEVrekPGwLzY00dr00z54kt70JB88frXUOuILji
2R4OnnuUVOMnwhpYgPyv1bRJYkADtw==
=TPUY
-----END PGP SIGNATURE-----

--daAMsHLhBjcveUdx--

