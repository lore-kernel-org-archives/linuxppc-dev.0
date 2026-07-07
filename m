Return-Path: <linuxppc-dev+bounces-23709-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441A6C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 14:54:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvkkt6XQmz2xWY;
	Wed, 08 Jul 2026 00:53:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.233.101.22
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783433497;
	cv=none; b=bxXoNAqIrmJS5lG9oOj2LpAWt0PHozO12Y6Nb4DVR88XstCCUiHDECOSszo/jS4WqGGiU4WYj9Wfrdio9hk7KyKJfsOtmEbmRsHlL5+zA4wyiMqZAqf4YtJuBXpy7sM+SHNgB29yKhKCQhhIdLUDY6iqRogslHzCthFZivAguUjdFzGerN76kpZmrwaRDZzfyKrXgzM5iCGDkO7GLRiHeC7iV7tW0eEylAOPe3hSqe+4/qLiLDkmC23eCh81yOL/CQm8BUDmQQ0kpjPVhF6oVVDzS775OWQ7drGteELxXnlFjJh+dNFn5ecL3i9XiHtbwDDNNcCAwrD8PnCl3BqyoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783433497; c=relaxed/relaxed;
	bh=20E1hLMMPXhHS8pnWfbMyHG7K9cQcKn2dO/QA3nMBBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vd8BO6s1XetHL+bao8+A21BBtZqveuueb1L/dzwym7toIG32ixE57ae6da/JT0YMkW8iFslacE+KC8Pe8htSYEIotP3G9r3Hqrufz/TatBq4C0e/IRhNSCNbIRcbu57swZKLasb1DjXeTroXnuhc2+pPvZWmvNRrETcH66xpeKahKxup6YSbWOh5lSzeufxOp5cm8zxgiT+dNWzZ3VNRSloaaxjEiJF7mw6YDXPH9bZ1BiL0pXVy4nLUzrCuhrpmbRoChxGIg874OIPQmVJIGX8xUZLB08R6giP0Ff0QYJmqqmR8fhiOMBrDgiUo5qDolNWDKwwNqERtbFw475GUQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=sys-base.io; spf=pass (client-ip=185.233.101.22; helo=leonov.paulk.fr; envelope-from=paulk@sys-base.io; receiver=lists.ozlabs.org) smtp.mailfrom=sys-base.io
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sys-base.io (client-ip=185.233.101.22; helo=leonov.paulk.fr; envelope-from=paulk@sys-base.io; receiver=lists.ozlabs.org)
X-Greylist: delayed 311 seconds by postgrey-1.37 at boromir; Wed, 08 Jul 2026 00:11:35 AEST
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvjnz0LPCz2xpn;
	Wed, 08 Jul 2026 00:11:34 +1000 (AEST)
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
	by leonov.paulk.fr (Postfix) with ESMTPS id 8929D3700300;
	Tue,  7 Jul 2026 14:11:10 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
	id E5BF4AE5EC4; Tue,  7 Jul 2026 14:11:05 +0000 (UTC)
Received: from shepard (unknown [192.168.1.1])
	by laika.paulk.fr (Postfix) with ESMTPSA id 6816EAE5EBF;
	Tue,  7 Jul 2026 14:10:55 +0000 (UTC)
Date: Tue, 7 Jul 2026 16:10:52 +0200
From: Paul Kocialkowski <paulk@sys-base.io>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Paul Cercueil <paul@crapouillou.net>,
	Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
	Linus Walleij <linusw@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Alexey Brodkin <abrodkin@synopsys.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Michal Simek <michal.simek@amd.com>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Eddie James <eajames@linux.ibm.com>,
	Tiffany Lin <tiffany.lin@mediatek.com>,
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
	Yunfei Dong <yunfei.dong@mediatek.com>,
	Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
	Houlong Wei <houlong.wei@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Joseph Liu <kwliu@nuvoton.com>, Marvin Lin <kflin@nuvoton.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ge Gordon <gordon.ge@bst.ai>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Peter Chen <peter.chen@cixtech.com>,
	Fugang Duan <fugang.duan@cixtech.com>,
	Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
	BST Linux Kernel Upstream Group <bst-upstream@bstai.top>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	CIX Linux Kernel Upstream Group <cix-kernel-upstream@cixtech.com>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
	linux-sunxi@lists.linux.dev, linux-media@vger.kernel.org,
	openbmc@lists.ozlabs.org, linux-mediatek@lists.infradead.org,
	kernel@collabora.com, linux-tegra@vger.kernel.org,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	imx@lists.linux.dev, sound-open-firmware@alsa-project.org
Subject: Re: [PATCH 08/42] drm: logicvc: Use
 devm_of_reserved_mem_device_init()
Message-ID: <ak0I7AbfFITG1nyi@shepard>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
 <20260703193855.110619-9-mukesh.ojha@oss.qualcomm.com>
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
	protocol="application/pgp-signature"; boundary="ThTwSIZV2a2cCNSQ"
Content-Disposition: inline
In-Reply-To: <20260703193855.110619-9-mukesh.ojha@oss.qualcomm.com>

--ThTwSIZV2a2cCNSQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mukesh,

On Sat 04 Jul 26, 01:08, Mukesh Ojha wrote:
> Switch to devm_of_reserved_mem_device_init() so the reserved memory
> region is released automatically on probe failure or device unbind.
> Replace all error paths that jumped to error_reserved_mem: with
> error_early: since the manual cleanup label is no longer needed, and
> remove the explicit of_reserved_mem_device_release() call in the remove
> function.
>=20
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

Looks good to me, thanks!

Reviewed-by: Paul Kocialkowski <paulk@sys-base.io>
Acked-by: Paul Kocialkowski <paulk@sys-base.io>

All the best,

Paul

> ---
>  drivers/gpu/drm/logicvc/logicvc_drm.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/logicvc/logicvc_drm.c b/drivers/gpu/drm/logi=
cvc/logicvc_drm.c
> index bbebf4fc7f51..d6dbe52ff0a9 100644
> --- a/drivers/gpu/drm/logicvc/logicvc_drm.c
> +++ b/drivers/gpu/drm/logicvc/logicvc_drm.c
> @@ -306,7 +306,7 @@ static int logicvc_drm_probe(struct platform_device *=
pdev)
>  	int irq;
>  	int ret;
> =20
> -	ret =3D of_reserved_mem_device_init(dev);
> +	ret =3D devm_of_reserved_mem_device_init(dev);
>  	if (ret && ret !=3D -ENODEV) {
>  		dev_err(dev, "Failed to init memory region\n");
>  		goto error_early;
> @@ -327,14 +327,14 @@ static int logicvc_drm_probe(struct platform_device=
 *pdev)
>  		ret =3D of_address_to_resource(of_node, 0, &res);
>  		if (ret) {
>  			dev_err(dev, "Failed to get resource from address\n");
> -			goto error_reserved_mem;
> +			goto error_early;
>  		}
> =20
>  		base =3D devm_ioremap_resource(dev, &res);
>  		if (IS_ERR(base)) {
>  			dev_err(dev, "Failed to map I/O base\n");
>  			ret =3D PTR_ERR(base);
> -			goto error_reserved_mem;
> +			goto error_early;
>  		}
> =20
>  		logicvc_drm_regmap_config.max_register =3D resource_size(&res) -
> @@ -345,21 +345,21 @@ static int logicvc_drm_probe(struct platform_device=
 *pdev)
>  		if (IS_ERR(regmap)) {
>  			dev_err(dev, "Failed to create regmap for I/O\n");
>  			ret =3D PTR_ERR(regmap);
> -			goto error_reserved_mem;
> +			goto error_early;
>  		}
>  	}
> =20
>  	irq =3D platform_get_irq(pdev, 0);
>  	if (irq < 0) {
>  		ret =3D -ENODEV;
> -		goto error_reserved_mem;
> +		goto error_early;
>  	}
> =20
>  	logicvc =3D devm_drm_dev_alloc(dev, &logicvc_drm_driver,
>  				     struct logicvc_drm, drm_dev);
>  	if (IS_ERR(logicvc)) {
>  		ret =3D PTR_ERR(logicvc);
> -		goto error_reserved_mem;
> +		goto error_early;
>  	}
> =20
>  	platform_set_drvdata(pdev, logicvc);
> @@ -371,7 +371,7 @@ static int logicvc_drm_probe(struct platform_device *=
pdev)
>  	caps =3D logicvc_drm_caps_match(logicvc);
>  	if (!caps) {
>  		ret =3D -EINVAL;
> -		goto error_reserved_mem;
> +		goto error_early;
>  	}
> =20
>  	logicvc->caps =3D caps;
> @@ -382,7 +382,7 @@ static int logicvc_drm_probe(struct platform_device *=
pdev)
>  	ret =3D logicvc_clocks_prepare(logicvc);
>  	if (ret) {
>  		drm_err(drm_dev, "Failed to prepare clocks\n");
> -		goto error_reserved_mem;
> +		goto error_early;
>  	}
> =20
>  	ret =3D devm_request_irq(dev, irq, logicvc_drm_irq_handler, 0,
> @@ -450,9 +450,6 @@ static int logicvc_drm_probe(struct platform_device *=
pdev)
>  error_clocks:
>  	logicvc_clocks_unprepare(logicvc);
> =20
> -error_reserved_mem:
> -	of_reserved_mem_device_release(dev);
> -
>  error_early:
>  	return ret;
>  }
> @@ -469,8 +466,6 @@ static void logicvc_drm_remove(struct platform_device=
 *pdev)
>  	logicvc_mode_fini(logicvc);
> =20
>  	logicvc_clocks_unprepare(logicvc);
> -
> -	of_reserved_mem_device_release(dev);
>  }
> =20
>  static void logicvc_drm_shutdown(struct platform_device *pdev)
> --=20
> 2.53.0
>=20

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Expert in multimedia, graphics and embedded hardware support with Linux.

--ThTwSIZV2a2cCNSQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmpNCOwACgkQhP3B6o/u
lQyaPQ//f4pAYoEPe2VkBx5ziaC0VkGALJ8pMaCBZzEG6pnd2z1UBPK8Y2xJLlQP
5bkyAxCQjpN0fwzwtB+kdA0jp2iokJqDThaLYoql9R0Qvj2DyOy7x+SwRqbRzdyJ
npZtxXLCuF9oXL4YlUHBVPkgL9WsGf2cMpqkXAI/iPd0K+9zBfxT48xlRnuslCQF
gwlVwkghlca2EFVG0f4q4HVkGRcFkAM9pYpKZD4B4iS89SwzHmJo44SZWV0CsWfe
ysY5SERP+XL8EbiVlQxCWyqo9Yb//Ikc/EuIWFPMzPW7hp4ZTzjzYaRtVdWEM3Or
GQ8uFNoXZfWHzfBpHk1Ewfdr7JBtXM0vPIh650GS2SCdGaCS0Ud2UUv7QZdSluel
uGrsM82ZQ6ts4V8ct1O/dWG7TwYnc8BaFADG90JdKck+zb3fRnQ07aTNrF/bRDU1
gcnN0yfM/zPIZAc7GA+4Stzok5c+bj2Sb849b5S5g6LNETsScU+WPK5pvEjjWq9E
zsLawR41dclgUWujmQqflY1sbvVA3YsAADIxWAAsT1WDULfQ/c70/2rMIvNATzBN
VxbCWSZtk77xMlu6aje7HIbEQa9PGm52xeqNOqfwv/t5kGZxU1fqyAULXAfSYQ2R
jkjMhoWPkeb15z5Be0yQY0auFkEuIORZboIqn49NxQW0LVu7byA=
=tX4X
-----END PGP SIGNATURE-----

--ThTwSIZV2a2cCNSQ--

