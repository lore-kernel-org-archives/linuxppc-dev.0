Return-Path: <linuxppc-dev+bounces-23710-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B25B5C43602
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 14:54:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvklC1x7lz2xWY;
	Wed, 08 Jul 2026 00:54:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.233.101.22
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783433670;
	cv=none; b=isjz51/Nt+0hMy5UlE9Srs1di5gYLmThDeGRMbmq334+UsIOz0eWSXLbvw7FT8JMkgUXbsn/WnTRlVILug4ltAdgLqrjXPM0nOk/OnXVoo7XtLi5NhSYuSjlV5phYnX/wHz4Y5G+GYOpjgGaYDWabeQ4NoSxdV23dpQZsJ9QKwbgzcRNM8Ytr8SfaAWnWNyvbeDo2t6OMKQ7hHuMpsdyLHy4dkDg8MT7Mb40OvNLjROSv1ZEIv3JjMa6RKvCDZWqOznwGUxWHoZp9rgvUu7VGDvf8BGszKDVQaQfZ+37I8q/JaZTiuPtFGnA3AGkOx5AOBVfj+Iqq1P5umVi+T4zcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783433670; c=relaxed/relaxed;
	bh=qCciVIAgFYNh8iiCE6A1FVMN5+3AnpIFscEXkkxF9ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ephjhREpJDI2kS54b33WJYcsz++A4R3GoEjZNPmuVFS1gn7mBqdmz0WaP4ewDi+F0/42X+8H6u7eM8N0Bsx+AGUsg/Z3LOwFtHJoWH0+GFrts+Ic5O3Ri9gHG0StxC1UKlICafXhRLG7WTExScG9YNOAgbI5QRE27PvkbPTl678bcRB3I84Zd8J+ywtHjVpSbQJh4radDypUwIgmq75pKXlxfvEsZNouKR9RiT8Or07pmfvO91nWj6H5aXvcSbnJujVt7XSP0pD+ddAVTFUe42h0Z/S3srnOhVUCIHVb4mgm8220yyztx40evy5UutcQPmWWjq8P5Pje7Sto1xAXlw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=sys-base.io; spf=pass (client-ip=185.233.101.22; helo=leonov.paulk.fr; envelope-from=paulk@sys-base.io; receiver=lists.ozlabs.org) smtp.mailfrom=sys-base.io
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sys-base.io (client-ip=185.233.101.22; helo=leonov.paulk.fr; envelope-from=paulk@sys-base.io; receiver=lists.ozlabs.org)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvjsK5M2gz2xKh;
	Wed, 08 Jul 2026 00:14:29 +1000 (AEST)
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
	by leonov.paulk.fr (Postfix) with ESMTPS id 9D2A0370032B;
	Tue,  7 Jul 2026 14:05:38 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
	id BB948AE5ECC; Tue,  7 Jul 2026 14:05:31 +0000 (UTC)
Received: from shepard (unknown [192.168.1.1])
	by laika.paulk.fr (Postfix) with ESMTPSA id B6432AE5EB6;
	Tue,  7 Jul 2026 14:05:21 +0000 (UTC)
Date: Tue, 7 Jul 2026 16:05:19 +0200
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
Subject: Re: [PATCH 30/42] staging: media: cedrus: Use
 devm_of_reserved_mem_device_init()
Message-ID: <ak0HnzMzGT_WZ9u1@shepard>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
 <20260703193855.110619-31-mukesh.ojha@oss.qualcomm.com>
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
	protocol="application/pgp-signature"; boundary="L/gXhcj/KYS6Adou"
Content-Disposition: inline
In-Reply-To: <20260703193855.110619-31-mukesh.ojha@oss.qualcomm.com>

--L/gXhcj/KYS6Adou
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mukesh,

On Sat 04 Jul 26, 01:08, Mukesh Ojha wrote:
> Use the devres-managed devm_of_reserved_mem_device_init() instead of
> the manual of_reserved_mem_device_init()/of_reserved_mem_device_release()
> pair, letting the device resource manager handle cleanup automatically.

Thanks for your work!

> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>  drivers/staging/media/sunxi/cedrus/cedrus_hw.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c b/drivers/sta=
ging/media/sunxi/cedrus/cedrus_hw.c
> index 444fb53878d1..7b5aa94064a1 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
> @@ -266,7 +266,7 @@ int cedrus_hw_probe(struct cedrus_dev *dev)
>  		return ret;
>  	}
> =20
> -	ret =3D of_reserved_mem_device_init(dev->dev);
> +	ret =3D devm_of_reserved_mem_device_init(dev->dev);
>  	if (ret && ret !=3D -ENODEV) {
>  		dev_err(dev->dev, "Failed to reserve memory\n");
> =20
> @@ -341,8 +341,6 @@ int cedrus_hw_probe(struct cedrus_dev *dev)
>  err_sram:
>  	sunxi_sram_release(dev->dev);
>  err_mem:

Could you also remove this label and switch the goto user to a regular
return ret?

Thanks!

All the best,

Paul

> -	of_reserved_mem_device_release(dev->dev);
> -
>  	return ret;
>  }
> =20
> @@ -353,6 +351,4 @@ void cedrus_hw_remove(struct cedrus_dev *dev)
>  		cedrus_hw_suspend(dev->dev);
> =20
>  	sunxi_sram_release(dev->dev);
> -
> -	of_reserved_mem_device_release(dev->dev);
>  }
> --=20
> 2.53.0
>=20

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Expert in multimedia, graphics and embedded hardware support with Linux.

--L/gXhcj/KYS6Adou
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmpNB58ACgkQhP3B6o/u
lQyTjg//fLyoug7RFssI1dop/066e79975deN6blykU3a96LxKKn7ru6j0LCnfu4
VTSFjvO7qjkf2yQeXqxnQWvrXBT/JiPMb/nPvBW0MGDi1M1+4kT7238LR5fuNLU0
eBAuY181rHDg+ftoXP7Rzj0XZlZ/dck0119WsWFEUk9gP0Q8BlgTs7QTUu3k2E+E
VUftOitNophkc0JUvgUi5wKODfIgzgp/nj9ZnCsjF9QSDjcr3Wjn2qwvdS4hG43H
m8QkFdiim8NX6PKzgqcjLNOUEXjjphI6+onlAT3qREs2ThXycXu0m5/+r+5IP6AT
OeVpkJQ9zrx91+tL94Yi4iXPERdq1zcnpUsiE1YhOnlB/KfCAXX3WeS6ZjLfF5aW
7/5j2Bd/rTlqCSH25ek2EQKZj476WJUgYplyAGFpLb/3iXyV89VpkdIk2VEc7ynK
V99TGimHONG+iiDOl/z3pn+MX5RzXeMWhmevSrfiTJzsG5Kb+mOKr86er3oTehf0
g8NOS3ITmO5IGHbfJSUx236uPw58QMEWKmKyZ/Sx7nDhhhskPBSgCJSvSPn0cbz9
cXejK2y8wLRj1RaSjCGUdM9ZoZPlNDoyqDrWZDxI2tzgXFYDbcuFEHM19GIDPTTY
2iujg05WmAKMP0jVtjzc7NoSbdBmeZG2atzsSP6M76kSPNdEJvI=
=0n6x
-----END PGP SIGNATURE-----

--L/gXhcj/KYS6Adou--

