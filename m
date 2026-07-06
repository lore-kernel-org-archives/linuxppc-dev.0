Return-Path: <linuxppc-dev+bounces-23638-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F9EC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 15:18:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gv7KD1kccz3bps;
	Tue, 07 Jul 2026 01:18:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=136.143.188.11 arc.chain=zohomail.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783351088;
	cv=pass; b=Lsz2rc0irU51+A2TRSw6j46HuSxU5odr0oTAnunupgfqt6eVpOVDevHP2aBIMFxkxrPiJFdroEnjMVAW2uBHo3mHab6FemptP6tZoca+RiEsL7RMkjQ3Nyolm3CyMJqR33LPcsSO4iHf46XIouQPhOEcsdDKnTKPyoyoT2iAygh5+NC1mWz7BusbvG5/q9JZg2ka1CmDzimw9df0KSD5MRiM6iz1osI3ZcvDhdEIsXK8hcbevf7GTLmwor3AndEE4VYVA3wui7KAoxsY+MVVq2xopGgn2aNdJ74D7lmjOWrs/UXwum97fxaCFpKZV8szrLNodeBRNP9TGFsoTBPFow==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783351088; c=relaxed/relaxed;
	bh=3XwyWTIrA/V6J7edt1EVqOvQjuCfvvAm71aap9OvOCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o3fmPPtZZScUMYNIIQ1a9ev8cs7iPFPPHuEn1EKgXmCKD26afJAHMhhwQneh9h1Re1LBBi1XK77+GeC/ruSsTjrfSc1MffOFoDcGDtOTxeL3E9AeA8ZBo6iZGUUNj4ORCIPmcUU9eWQGu9u08xoG4Y2l8TtraX9MEE/CMKHoIMB1+AEUZAEgbBT3SljNVLol8LFhOTRkTmedTfixb6Gg115jM4hvKs0E1RLF1khfZ84y0EbsDKal4k7ZE2mTWuXzUnSq1MsUR3hnAhAUcJCZykDboLe0eUTjsPZ3nuEwddDglCxL9qmFZQ8MyiQdU6aE68mQyZUwmFJJwUd+ltQTRg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=collabora.com; dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=ImgA1Hj8; dkim-atps=neutral; spf=pass (client-ip=136.143.188.11; helo=sender4-op-o11.zoho.com; envelope-from=dmitry.osipenko@collabora.com; receiver=lists.ozlabs.org) smtp.mailfrom=collabora.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=ImgA1Hj8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=collabora.com (client-ip=136.143.188.11; helo=sender4-op-o11.zoho.com; envelope-from=dmitry.osipenko@collabora.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 917 seconds by postgrey-1.37 at boromir; Tue, 07 Jul 2026 01:18:05 AEST
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gv7K925zXz2yVZ;
	Tue, 07 Jul 2026 01:18:04 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1783350034; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ShBwgIB9Tp0j2ieVFNXD2nNlBvkYSrZX6KL3AeDB+tfLOnE+7CHZu5rN/HP3/wiA65AfS2awNfBnLG6v3KttLERp5k37uX5cTjLkGlHu1epQC0tpKbiWTjw2bmWO4R3cJ9Bceq/UN4MGpiO+12hQk2boeKqRMVN9X9phSckbKF0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783350034; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3XwyWTIrA/V6J7edt1EVqOvQjuCfvvAm71aap9OvOCI=; 
	b=aUIQNdoKYFXhqBqNhsY+F02CkGve6EXcuTScFbe5OHL/WHUKXk+LgtUumBUdfOodPJNOea5bCjHJ9ycCR0cPvohjbCewZV5P129fWS7uy+uA2tTiwdLdX3wI3zpXyvb7h2kq1Re2lQrUV6CFisZwObNuwW+4qzyVdb787O027/g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783350034;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=3XwyWTIrA/V6J7edt1EVqOvQjuCfvvAm71aap9OvOCI=;
	b=ImgA1Hj80B9JHQg2Jp0iR3Hfkzuv+c1ZmjHHLY5vXEEHJlu3rx/mY5cc4HVAWJDf
	QREjGnw/uNA5JcHG0nEUz0PUvTE/0uKgXtwmj8p0wIRVC2fcF+pZOIvPjdNL8NnCNrh
	RgJCMxLw7XsRX8tO1eirdxvjf97IRGDZQzh4oCj8=
Received: by mx.zohomail.com with SMTPS id 1783350031182921.1240379629376;
	Mon, 6 Jul 2026 08:00:31 -0700 (PDT)
Message-ID: <3541fb84-81ce-4415-8027-38aa611834ae@collabora.com>
Date: Mon, 6 Jul 2026 18:00:09 +0300
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/42] media: synopsys: hdmirx: Use
 devm_of_reserved_mem_device_init()
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Paul Cercueil <paul@crapouillou.net>,
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
 Paul Kocialkowski <paulk@sys-base.io>, Linus Walleij <linusw@kernel.org>,
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Alexey Brodkin
 <abrodkin@synopsys.com>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>,
 Daniel Scally <dan.scally@ideasonboard.com>,
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Eddie James <eajames@linux.ibm.com>, Tiffany Lin <tiffany.lin@mediatek.com>,
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 Yunfei Dong <yunfei.dong@mediatek.com>,
 Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
 Houlong Wei <houlong.wei@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Joseph Liu <kwliu@nuvoton.com>, Marvin Lin <kflin@nuvoton.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Srinivas Kandagatla <srini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ge Gordon
 <gordon.ge@bst.ai>, Adrian Hunter <adrian.hunter@intel.com>,
 Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Peter Chen <peter.chen@cixtech.com>, Fugang Duan <fugang.duan@cixtech.com>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 BST Linux Kernel Upstream Group <bst-upstream@bstai.top>,
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
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
 <20260703193855.110619-7-mukesh.ojha@oss.qualcomm.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20260703193855.110619-7-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 7/3/26 22:38, Mukesh Ojha wrote:
> Replace the hand-rolled devm_hdmirx_of_reserved_mem_device_release()
> devres action with devm_of_reserved_mem_device_init(), which handles the
> cleanup automatically. This removes both the wrapper function and the
> devm_add_action_or_reset() call.
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>  .../media/platform/synopsys/hdmirx/snps_hdmirx.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c b/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c
> index 25f8ca0d6d94..7c6acc6d7e88 100644
> --- a/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c
> +++ b/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c
> @@ -2265,11 +2265,6 @@ static const struct hdmirx_cec_ops hdmirx_cec_ops = {
>  	.read = hdmirx_readl,
>  };
>  
> -static void devm_hdmirx_of_reserved_mem_device_release(void *dev)
> -{
> -	of_reserved_mem_device_release(dev);
> -}
> -
>  static int hdmirx_parse_dt(struct snps_hdmirx_dev *hdmirx_dev)
>  {
>  	struct device *dev = hdmirx_dev->dev;
> @@ -2316,16 +2311,9 @@ static int hdmirx_parse_dt(struct snps_hdmirx_dev *hdmirx_dev)
>  	if (!device_property_read_bool(dev, "hpd-is-active-low"))
>  		hdmirx_dev->hpd_trigger_level_high = true;
>  
> -	ret = of_reserved_mem_device_init(dev);
> -	if (ret) {
> +	ret = devm_of_reserved_mem_device_init(dev);
> +	if (ret)
>  		dev_warn(dev, "no reserved memory for HDMIRX, use default CMA\n");
> -	} else {
> -		ret = devm_add_action_or_reset(dev,
> -					       devm_hdmirx_of_reserved_mem_device_release,
> -					       dev);
> -		if (ret)
> -			return ret;
> -	}
>  
>  	return 0;
>  }

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry

