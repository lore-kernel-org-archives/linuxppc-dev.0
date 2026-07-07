Return-Path: <linuxppc-dev+bounces-23701-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816A0C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 11:42:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvfTq1m5vz2xWY;
	Tue, 07 Jul 2026 21:42:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783424543;
	cv=none; b=SPJQs9+g8FjKL/JOWIOzyq7OzhRB1SpatOnMy58YCY0eC49orI8QPt/Nn4odh+QEaKBcbDbrxSmRP6dlaNcj7HP8L7CtN/GLN+5mwemrcEZYxHbArpNcOxmawrxnmUcRqgYkOeozB0wJPZA8/k3htm2wrPW7f3GGmARuIevhmycM9pZl5McGflgoZqouiKJS6PwX7929dXaxXP63YaoyJu/vx0bP9OyzyC7AYJWvxjKlTESAiUFbNZZ+DcVbKlvGf0wxBTeLWUDs9M5BtnEWR51mz9Xrf9oybstVYfEFMUJG6zabX5r9nt7otNzeAmnfoit5NSbG2nqZQaop0hCuQw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783424543; c=relaxed/relaxed;
	bh=vLgY48wjnxI6KTkbs3yoMb3mqAR6cMMCjHviW4AsdM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lw61VE7Y6H4qi6WzaypfKtRe7BDmJsuxR5fEOlcqkX+yKgMo+e8PknSGYXgd7+TbxHbNBrWAbHfUphh3HJ2Z8vE3tif8Z7qLm+Z92npmFupeXrN94GrvWRTTo9Ub8RGVKvZnhSZ4HANQG7V2WTFkVopbuQ59CQNfdgLccZDNCiuYf7Nlnoxlk2b5bi/FGqOza7SUR/oC3iYBuYRw26X56VRQCtRobmDyWhwuVA8TUDNxE7kV3zjgLIOcIT2WRe/ncKMoTcx6WJP+k/QHs4HCU8rX5Fmf/hRlQAc1rZADZyS8ZKtGFcQSipNKBAhID3XnRdjENkUQ/6Ol/B2RM1VYqw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=g8lQFDxh; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=liviu.dudau@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=g8lQFDxh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=liviu.dudau@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvfTp1pqxz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 21:42:22 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A29EC2680
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jul 2026 04:41:46 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C36DD3FAF5
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jul 2026 04:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783424511; bh=AXimq/rtIFwP4aD04kh/5vfPSxje93mi8aUhDJB2eB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g8lQFDxhkRHx+21rjYlAZffhhuBRTsPEAbatD1kNtwItaNR63YFBy9uXxBlhJ/n34
	 C81xPyObYByb+G2DVjJczng8bTHilK/V44VoZXAn/ypWgMyI+W9Rq2DOeM+6Vz1miq
	 Ni2AMgwrjN8nh5xFNKmQKcl2zxkvXd2X2j/PFaqA=
Date: Tue, 7 Jul 2026 12:39:54 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
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
Subject: Re: [PATCH 00/42] of: reserved_mem: Introduce devres helpers and
 convert drivers
Message-ID: <akzliqtjZVwNw594@e142607>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>

On Sat, Jul 04, 2026 at 01:08:13AM +0530, Mukesh Ojha wrote:
> Drivers using of_reserved_mem_device_init() and its variants must
> manually call of_reserved_mem_device_release() in their remove and
> error-unwind paths. This is repetitive boilerplate that is easy to
> get wrong, and several drivers have open-coded the teardown
> inconsistently or skipped it entirely, leading to dangling reserved
> memory references.
> 
> This series introduces devres-managed wrappers —
> devm_of_reserved_mem_device_init(), devm_of_reserved_mem_device_init_by_idx(),
> and devm_of_reserved_mem_device_init_by_name() — that tie the reserved
> memory region lifetime to the device, releasing it automatically on
> unbind. The remaining 40 patches convert drivers across the drm, media,
> ASoC, remoteproc, firmware, mmc, memory and misc subsystems to use these
> helpers, yielding a net reduction of ~90 lines of boilerplate.
> 
> This series depends on  https://lore.kernel.org/lkml/20260703164457.4040457-1-mukesh.ojha@oss.qualcomm.com/
> 
> Konrad Dybcio (1):
>   of: reserved_mem: Introduce devres-managed initialization functions
> 
> Mukesh Ojha (41):
>   of: reserved_mem: Add devm_of_reserved_mem_device_init_by_name()
>   firmware: qcom: scm: Use devm_of_reserved_mem_device_init()
>   remoteproc: da8xx: Use devm_of_reserved_mem_device_init()
>   remoteproc: keystone: Use devm_of_reserved_mem_device_init()
>   media: synopsys: hdmirx: Use devm_of_reserved_mem_device_init()
>   remoteproc: omap: Use devm_of_reserved_mem_device_init()
>   drm: logicvc: Use devm_of_reserved_mem_device_init()
>   drm: hdlcd: Use devm_of_reserved_mem_device_init()
>   drm: pl111: Use devm_of_reserved_mem_device_init()
>   remoteproc: mtk_scp: Use devm_of_reserved_mem_device_init()
>   media: aspeed: Use devm_of_reserved_mem_device_init()
>   media: nuvoton: npcm-video: Use devm_of_reserved_mem_device_init()
>   memory: tegra210-emc: Use devm_of_reserved_mem_device_init_by_name()
>   drm: komeda: Use devm_of_reserved_mem_device_init()
>   drm: malidp: Use devm_of_reserved_mem_device_init()

For the hdlcd, komeda and malidp drivers:

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

>   drm: ingenic: Use devm_of_reserved_mem_device_init()
>   drm: kmb: Use devm_of_reserved_mem_device_init()
>   drm: sun4i: Use devm_of_reserved_mem_device_init()
>   drm: xlnx: zynqmp_dpsub: Use devm_of_reserved_mem_device_init()
>   media: arm: mali-c55: Use devm_of_reserved_mem_device_init()
>   media: mediatek: vpu: Use devm_of_reserved_mem_device_init()
>   mmc: sdhci-of-bst: Use devm_of_reserved_mem_device_init_by_idx()
>   remoteproc: ti_k3: Use devm_of_reserved_mem_device_init()
>   ASoC: mediatek: mt8192: Use devm_of_reserved_mem_device_init()
>   ASoC: mediatek: mt8196: Use devm_of_reserved_mem_device_init()
>   ASoC: mediatek: mt8183: Use devm_of_reserved_mem_device_init()
>   ASoC: mediatek: mt8189: Use devm_of_reserved_mem_device_init()
>   ASoC: SOF: imx: Use devm_of_reserved_mem_device_init_by_name()
>   staging: media: cedrus: Use devm_of_reserved_mem_device_init()
>   ASoC: cix-ipbloq: Use devm_of_reserved_mem_device_init()
>   drm: aspeed: Use devm_of_reserved_mem_device_init()
>   drm: arcpgu: Use devm_of_reserved_mem_device_init()
>   ASoC: mediatek: mt8173: Use devm_of_reserved_mem_device_init()
>   ASoC: mediatek: mt8186: Use devm_of_reserved_mem_device_init()
>   ASoC: mediatek: mt8188: Use devm_of_reserved_mem_device_init()
>   ASoC: mediatek: mt8195: Use devm_of_reserved_mem_device_init()
>   ASoC: SOF: mediatek: mt8186: Use devm_of_reserved_mem_device_init()
>   ASoC: SOF: mediatek: mt8195: Use devm_of_reserved_mem_device_init()
>   misc: fastrpc: Use devm_of_reserved_mem_device_init()
>   ASoC: fsl: imx-rpmsg: Use devm_of_reserved_mem_device_init_by_idx()
>   ASoC: sprd: Use devm_of_reserved_mem_device_init()
> 
>  drivers/firmware/qcom/qcom_scm.c              | 22 +++------
>  .../gpu/drm/arm/display/komeda/komeda_dev.c   |  4 +-
>  drivers/gpu/drm/arm/hdlcd_drv.c               |  6 +--
>  drivers/gpu/drm/arm/malidp_drv.c              |  4 +-
>  drivers/gpu/drm/aspeed/aspeed_gfx_drv.c       |  2 +-
>  drivers/gpu/drm/ingenic/ingenic-drm-drv.c     | 13 +-----
>  drivers/gpu/drm/kmb/kmb_drv.c                 | 12 +----
>  drivers/gpu/drm/logicvc/logicvc_drm.c         | 21 ++++-----
>  drivers/gpu/drm/pl111/pl111_drv.c             |  4 +-
>  drivers/gpu/drm/sun4i/sun4i_drv.c             |  4 +-
>  drivers/gpu/drm/tiny/arcpgu.c                 |  2 +-
>  drivers/gpu/drm/xlnx/zynqmp_dpsub.c           |  4 +-
>  .../platform/arm/mali-c55/mali-c55-core.c     | 12 ++---
>  drivers/media/platform/aspeed/aspeed-video.c  | 12 ++---
>  drivers/media/platform/mediatek/vpu/mtk_vpu.c |  3 +-
>  drivers/media/platform/nuvoton/npcm-video.c   |  9 +---
>  .../platform/synopsys/hdmirx/snps_hdmirx.c    | 16 +------
>  drivers/memory/tegra/tegra210-emc-core.c      | 21 ++++-----
>  drivers/misc/fastrpc.c                        |  2 +-
>  drivers/mmc/host/sdhci-of-bst.c               |  7 +--
>  drivers/of/of_reserved_mem.c                  | 41 +++++++++++++++++
>  drivers/remoteproc/da8xx_remoteproc.c         | 10 +---
>  drivers/remoteproc/keystone_remoteproc.c      | 16 +------
>  drivers/remoteproc/mtk_scp.c                  |  3 +-
>  drivers/remoteproc/omap_remoteproc.c          | 13 +-----
>  drivers/remoteproc/ti_k3_common.c             | 13 +-----
>  drivers/remoteproc/ti_k3_common.h             |  1 -
>  .../staging/media/sunxi/cedrus/cedrus_hw.c    |  6 +--
>  include/linux/of_reserved_mem.h               | 46 +++++++++++++++++++
>  sound/hda/controllers/cix-ipbloq.c            |  2 +-
>  sound/soc/fsl/imx-rpmsg.c                     |  2 +-
>  sound/soc/mediatek/mt8173/mt8173-afe-pcm.c    |  2 +-
>  sound/soc/mediatek/mt8183/mt8183-afe-pcm.c    | 13 +-----
>  sound/soc/mediatek/mt8186/mt8186-afe-pcm.c    |  2 +-
>  sound/soc/mediatek/mt8188/mt8188-afe-pcm.c    |  2 +-
>  sound/soc/mediatek/mt8189/mt8189-afe-pcm.c    | 16 +------
>  sound/soc/mediatek/mt8192/mt8192-afe-pcm.c    | 11 +----
>  sound/soc/mediatek/mt8195/mt8195-afe-pcm.c    |  2 +-
>  sound/soc/mediatek/mt8196/mt8196-afe-pcm.c    | 14 +-----
>  sound/soc/sof/imx/imx-common.c                |  9 ++--
>  sound/soc/sof/mediatek/mt8186/mt8186.c        |  2 +-
>  sound/soc/sof/mediatek/mt8195/mt8195.c        |  2 +-
>  sound/soc/sprd/sprd-pcm-dma.c                 |  3 +-
>  43 files changed, 162 insertions(+), 249 deletions(-)
> 
> -- 
> 2.53.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

