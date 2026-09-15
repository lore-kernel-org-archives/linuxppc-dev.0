Return-Path: <linuxppc-dev+bounces-27435-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE87BC88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 17:35:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkq1M0Xy7z2y8F;
	Wed, 16 Sep 2026 03:35:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789493751;
	cv=none; b=R6t2F/esF+LpvsKUDzjS/vms8H6chDAunu79V6TeoXQrys0LN+YdCY4r7z4QJoYu5jC6k/TqecE/D35aG7Be9jye0FUrKnd1oQOLWU0lUQML4c/7QmRq2XgeeLe79c8lVvtMoV8hVia09Z0b61EsGK+/01l+s1WnJ7L5EHzVpi1DM0jIGUHo6IbHcECiTLxmAdDhDjMZVE0NHx7EUC0mXfPXPteSFtEsI0bEMOagRQQPks3Zm6nvH4XR6oww2nKHE4AyP1Qh3iI0gNB7jaoum3JaZM0NM//XB/pD14TmY6OiraGWuaI6jMD8+1nJKVof5+r2EhikIdNzsrb9XctCZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789493751; c=relaxed/relaxed;
	bh=39FDW1iBleAYEn7xhDFenbNL76Y5Vr3j48V/WMdQHms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYxGO1RPoHbDN2mZnzT6g39l2+yenxnqQcsQ4SPacbnvHLCpifgzYZG+bK6dVcJnCqm+S2ArXUsum1QwXFN3ETPrF5VBmgUkbkP84Tud7BqTes3FS6bpf32UW1msixZBnN1sOoy71tKH5D7wepbt7H720RMis/BP1QIN1jgi7QXdLtkvc1Fx38cwWjRQQkJQ2yMkrealheztz11z++n0a96OuRmQILqczizQhlqcDE6NioUFyrAwoSLEWAHEBy+xWdISxWt5Cy9jrUUPMVjDr9nVAwIKfSar+o7+EYpw7OIbEE5wY/t6VhHoxd712TfkK70Ti8rP73OR6I/+Ypilnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pgaj2bP5; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pgaj2bP5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkq1K5kNcz2y2f
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 03:35:49 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E77FD600CB;
	Tue, 15 Sep 2026 17:35:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3EB11F000FF;
	Tue, 15 Sep 2026 17:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789493746;
	bh=39FDW1iBleAYEn7xhDFenbNL76Y5Vr3j48V/WMdQHms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Pgaj2bP5DrqGvx/3WqSGLRb/PQIcCCAc7m4hinrbcCyI2uUaLsCYHyY20o0qiWe9E
	 3RHqreO0iOHfl4AZoje9x9PeFfbrmV0KeHC5JKTvLEwtj4Lg5me7bz+rBmF6BtRhSy
	 AY9N7DIXo+XAZrcm7WgGeeLwC6EshU9/ROmHHy7QnE1Z7Gj9LyqSY5ptG89X1ynQpO
	 wjnAtxFFUXRLjFNTRcc5KFPCFDZFUFM8xN9GsK9CTgoi6PIwPgyjRS3SvqKAnoilEZ
	 YTY18zhIQwLsgIFNwpHPj3dWyNhJDY9/BroRpgJEmcXu9n2SAUZkZJ/3P8j1Zk14rh
	 lOg+hT20tfAkw==
Date: Tue, 15 Sep 2026 18:35:38 +0100
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Frank Li <Frank.Li@nxp.com>, Shengjiu Wang <shengjiu.wang@nxp.com>,
	bui duc phuc <phucduc.bui@gmail.com>,
	Tianchu Chen <flynnnchen@tencent.com>, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: Re: [PATCH v1 2/7] ASoC: sprd: Replace dma_request_slave_channel()
 by dma_request_chan()
Message-ID: <444f1340-f690-440d-85e7-4fa7d66644d5@sirena.org.uk>
References: <20260915100931.3593242-1-andriy.shevchenko@linux.intel.com>
 <20260915100931.3593242-3-andriy.shevchenko@linux.intel.com>
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
	protocol="application/pgp-signature"; boundary="Eev+jrxCI2X+PyJ/"
Content-Disposition: inline
In-Reply-To: <20260915100931.3593242-3-andriy.shevchenko@linux.intel.com>
X-Cookie: Void where prohibited by law.


--Eev+jrxCI2X+PyJ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 12:04:23PM +0200, Andy Shevchenko wrote:
> Replace dma_request_slave_channel() by dma_request_chan() as suggested
> since the former is deprecated.

> @@ -171,13 +171,12 @@ static int sprd_pcm_request_dma_channel(struct snd_=
soc_component *component,
>  	for (i =3D 0; i < channels; i++) {
>  		struct sprd_pcm_dma_data *data =3D &dma_private->data[i];
> =20
> -		data->chan =3D dma_request_slave_channel(dev,
> -						       dma_params->chan_name[i]);
> -		if (!data->chan) {
> +		data->chan =3D dma_request_chan(dev, dma_params->chan_name[i]);
> +		if (IS_ERR(data->chan)) {
>  			dev_err(dev, "failed to request dma channel:%s\n",
>  				dma_params->chan_name[i]);
>  			sprd_pcm_release_dma_channel(substream);
> -			return -ENODEV;
> +			return PTR_ERR(data->chan);

sprd_pcm_release_dma_channel() does:

                if (data->chan) {
                        dma_release_channel(data->chan);
                        data->chan =3D NULL;

so this won't DTRT with propagating the return code.

--Eev+jrxCI2X+PyJ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqpgekACgkQJNaLcl1U
h9Dv6wf8DIt782FfFomog7Ok5wncm/S0jGMUale3g0wtB7TmjZWZulho4w/W+9Op
NQdoSarIoFdY4G5RQQaXN9YY/+b3euC8guuyXq2oU9Qzl25W2xTey7eh/bLshP0D
RC7HQG5RWrDTvJYpyglVFP7TWTTVXtoP7c+2ZMjTps1+Ou6UvJvt/XYuFtS74beB
ol+eLO6z606nI9p3R2rCyMrZhDQUUzAe90WEtBgyAaN/obA4Wi6K0/itsLBIn0xu
9AFytXi9/IsoSIZ+BmgOkN29ZdtHW9dTM6Lo0w2d4YC718HywHRkqRPDcLagd8qc
Wgz7Rz3kFsOpWXRBzsrpPBjNQUUafg==
=1aFq
-----END PGP SIGNATURE-----

--Eev+jrxCI2X+PyJ/--

