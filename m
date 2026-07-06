Return-Path: <linuxppc-dev+bounces-23602-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0390EC44501
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 12:16:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gv3Hd49cFz3bby;
	Mon, 06 Jul 2026 22:16:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783340189;
	cv=none; b=hY5XFyY2YTXDz60dyWr9+AAZZ6/OOxZ8B0bGDdKOowyZsaEMwGKn2Lm/Zr2UKdtox6AFF/hM74l4EkGwWdkauZDiCy76ANAP3ZPsjeyk5m0WHyPhrqcLQPq8mMBZ8WkCN1J9Scn6ZQSOKxFstmEGMR3uoaaCbKYxceUuNJxY7Fqc2Gnb/NoZuebCsLYX0WiJXqr21+q6QxVhl2ziFU+HTemZKRAATeuWKCuAqZY6Bfz+aeOfpWufGsqEF2X2nGq/0f1vUm3T5TTHYu6TnZvy7VHbP+xtEcWhfYqRW3blRXWBvrfUr6Ut3gQlai/xbrnEASIxFYr0XnjJT/+FTG/WfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783340189; c=relaxed/relaxed;
	bh=Z/lKSRcjWKapJuVT4TtgVFwUxKxBHhkUK36Xyw1gFTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMIP+tHwcq3wEvqmAR6CBY5ek4d685dJ37nN9JKdP9ID+WAGdQwK0ERbFYdYA1rlKlJq3vaGzzzk4JasqzMYAzOrSBQxGXNGX8SUgvAjol36ZeQ0pgDvz6PqgyTidGUmWR4FnQa9gMveD4BZiSPeOwvoCW5y8/nOJjbjUfi/zSaWurD/TmFpCbuSKrO39R8ZzRQLQRF3TLmp/Dn0b1g/+QA69FMV2SnsFqGE9Rw4YWqZ7OVzJAw9st4sX4ITSarx8C9K8gg7cHoHeBl+JPuvzWBvpqYUytNJHTaJGIgOQy/Dm3IqNGcb6AHbTZCNWHNeJ9F2GSnvbzL+Ma4Yd9kFFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dW5IodGu; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dW5IodGu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gv3Hc3ysMz2yVZ;
	Mon, 06 Jul 2026 22:16:28 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4D48B600C3;
	Mon,  6 Jul 2026 12:16:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7811F000E9;
	Mon,  6 Jul 2026 12:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783340185;
	bh=Z/lKSRcjWKapJuVT4TtgVFwUxKxBHhkUK36Xyw1gFTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dW5IodGu3nJX8tn88T9LM0lVQH7B5jfoPkOf0/3aM09o2lOWbX5/1tGJteOIx5aLR
	 6QMzRBv5Ym2m9tdoG15pdKLOvIlH/expuQAYXijlgRFOW3BFLSk5s0QVLDVa8qLu4n
	 s0T+1tTPeI4UtcMDbils+y2W4FB0RpuRXqzSs43+b6E7A8n1Hdcyz15cbQ2dcZvDV9
	 PbLaqmINOR4dyPTKyA3QCIT91q3zjgsqRENCYLsmuqYD+eUNgL0npmvOsnBO3CNGQd
	 2GWMjfkdCyIx5/NBqXveNcRvzQX8yvF28yrkaYeV1T0p/x2tXHKF6oDpSuv3dxEljV
	 mJqJPa69yVtJQ==
Date: Mon, 6 Jul 2026 13:16:06 +0100
From: Mark Brown <broonie@kernel.org>
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
	Paul Kocialkowski <paulk@sys-base.io>,
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
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
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
Subject: Re: [PATCH 25/42] ASoC: mediatek: mt8192: Use
 devm_of_reserved_mem_device_init()
Message-ID: <231e493b-cd54-4e8e-b14b-ce7ade97d645@sirena.org.uk>
Mail-Followup-To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
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
	Paul Kocialkowski <paulk@sys-base.io>,
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
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
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
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
 <20260703193855.110619-26-mukesh.ojha@oss.qualcomm.com>
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
	protocol="application/pgp-signature"; boundary="RIv4GAh9IbQg1LAQ"
Content-Disposition: inline
In-Reply-To: <20260703193855.110619-26-mukesh.ojha@oss.qualcomm.com>
X-Cookie: Did I do an INCORRECT THING??


--RIv4GAh9IbQg1LAQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 04, 2026 at 01:08:38AM +0530, Mukesh Ojha wrote:
> Replace the hand-rolled devm wrapper (mt8192_afe_release_reserved_mem +
> devm_add_action_or_reset) with the standard
> devm_of_reserved_mem_device_init(), letting the device resource manager
> handle cleanup automatically.

Acked-by: Mark Brown <broonie@kernel.org>

--RIv4GAh9IbQg1LAQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpLnIUACgkQJNaLcl1U
h9DXVQgAgtqnDlgz3o2aHoFiTshZUD1qTjoT5cLKw0RATdj7LLFbJi395gfR5E71
JvVM9mudvxBLvs79vDRE5Rfy6beFPzQh5Dg1SQ76jAOtAzA9FZAUKezAHRhNQs9c
reptszRK+aOUOTASYnOIQALfQhbgcXPtWJXGwTdYKeXYSe8LIzcalJxVkQ1fn7G8
97f3HiN6zJErpvZPyuJ6R4I3vG+bqurBBacdUZQIaTFS2PwbuqAwwz+NDTatPdP8
N8OdIEIYo9H1aLp5LJllxJsFosUxl+CxOpdbkxE9ccuJL5TlN0PxRoWsUvkv2AZn
nbRAQNLgyPBrtH2zEMZVAFK9As3uMQ==
=Txxl
-----END PGP SIGNATURE-----

--RIv4GAh9IbQg1LAQ--

