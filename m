Return-Path: <linuxppc-dev+bounces-23603-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E88C44500
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 12:17:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gv3JF74Ndz2yfS;
	Mon, 06 Jul 2026 22:17:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783340221;
	cv=none; b=BjfpezZwLgefEPe/by4jlpKpCTajt/q/bnnVraZDYN9KuSMRjJiIw+STMqbTU6eIvKw2mBBSLDHew+fmEZpl7j9XY/ly9GriLAcO0NK1Mnq4S8/njyXs500R5em25n2go4lUqGEqTc1tjw+RlhQsZLE1enCiLcwsGwNWPlpTf6B5Bs+ni0UAKkYn7/v5GK9rT7xGjo3PzAgMNwoRGGjUcjRSVymjq2xL0KITzix0aLznhIqcLxt0D3pLFn/biHhLRhqukVwNt5l+qwP0wx4Y+rcjJPLdyURHJXqUwguRFqpMVlanrKedlDGq0IpGXdarS6tF6aYToNSbMfDfc4Nxdg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783340221; c=relaxed/relaxed;
	bh=E0ybWUMT5ykKHMt3hRKrJAElXW0KNmumYbWeY/gC6qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QR5Nlbtmd6QCM6WFoIuUz02uf/PfB2iYgbzBSNBxwE5wk/jyaXvJlOsp1pc9dkAgLmMKyWzm0dKdKl/ej9IUyqFcEoDmFJrm6WdU8Ftjzz9XIq88Uc4SYEqcc6+ib8cVH+lU+dbz4G7twPinDtmVY6kT3cTVYNraLFw7vcYtZn4FrWxd58qgy6Eu5n3FTX3YRDd8XQnUfhRFODTnzaPq+0BbfIOXbomvhP9S46mEUOPa0ezusKmSCck1BFXNiLX7T4/hhyBLS4xKX38HyPqmju11+UTZqq8mRMtob1+UghrrImNRN4oQnkyzbyc8DCVg4rVUMiAl0IQKbOIcqjJgbw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I456lAOL; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I456lAOL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gv3JF1QQ0z3bby;
	Mon, 06 Jul 2026 22:17:01 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 608CC414E3;
	Mon,  6 Jul 2026 12:16:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E081F000E9;
	Mon,  6 Jul 2026 12:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783340219;
	bh=E0ybWUMT5ykKHMt3hRKrJAElXW0KNmumYbWeY/gC6qE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I456lAOLpHSI7yX4A3hGGu328x/LhYikS9Ad81LPAWRZkgK1VEhn3TPLSvhmzn0mM
	 0K73I5A/A2Bz2iV9kLkAFoGuRqyr6pAN1YrqId+GUAibWHnH01wwnN03nRJ9CEhKoU
	 gpJr/YCB6noB3KBe2aHXueA71P9tgn3jtye5mWfDylSGkWocqdFhguXArQhxaGhHxQ
	 zbpWSaDSwhRVmCueSSRyKRQgZfSgn/FC+3+kT1JZj75r3yYAX6kHqwofiETMmSmubH
	 wW5EDq67+npBKnaKGfJ9FW79U9Mhb9gfjWQEsWnMT+yIt7aOIzflF6u0d+o41JuFb5
	 XVUr9hkJ77CdA==
Date: Mon, 6 Jul 2026 13:16:41 +0100
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
Subject: Re: [PATCH 26/42] ASoC: mediatek: mt8196: Use
 devm_of_reserved_mem_device_init()
Message-ID: <84b6a669-017f-4737-b6c4-124b0653190a@sirena.org.uk>
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
 <20260703193855.110619-27-mukesh.ojha@oss.qualcomm.com>
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
	protocol="application/pgp-signature"; boundary="k1yPzPS+gn5eXmuc"
Content-Disposition: inline
In-Reply-To: <20260703193855.110619-27-mukesh.ojha@oss.qualcomm.com>
X-Cookie: Did I do an INCORRECT THING??


--k1yPzPS+gn5eXmuc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 04, 2026 at 01:08:39AM +0530, Mukesh Ojha wrote:
> Replace the hand-rolled devm wrapper (mt8196_afe_release_reserved_mem +
> devm_add_action_or_reset) with the standard
> devm_of_reserved_mem_device_init(), letting the device resource manager
> handle cleanup automatically.

Acked-by: Mark Brown <broonie@kernel.org>

--k1yPzPS+gn5eXmuc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpLnKgACgkQJNaLcl1U
h9CxFwf/VwVZ8veo1WnA5s69MQki3XNfL+yi+NPIe9jNxNccdyC7N4F+ss0+2sq4
p8vCAoMmJ05DKMFm564Fmd7qBTw7+pkscjBvwQIr+B2rVpTsvKFyYiLN7gZY5qJZ
4fAKdROuzN5U4ZhsKPf1q6c7eerXcBgi0mXh1YOmGHXoofQa6KAyuZDO/j1nN6FG
nHQbdKDLWcJ8S0AgNBQa1svluugNFONywr/uCZ1WJg9GSQevoPgAeFCFHFL49qJL
eXZO7nm0nm4c/5Hk4++HNZl0jdT/Sdvv2Uy12s8agngU9qWvFIowOpTFDBAfTMZw
XbGlJ/sB0lGgeYUNWcxpVNyGxY14Kg==
=kZm9
-----END PGP SIGNATURE-----

--k1yPzPS+gn5eXmuc--

