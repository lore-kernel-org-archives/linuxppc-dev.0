Return-Path: <linuxppc-dev+bounces-23545-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91EEFC43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 20:52:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gsQsr2JX6z2ypw;
	Sat, 04 Jul 2026 06:52:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783108102;
	cv=none; b=jI3uP9q6d8QPyFBfbmZPf5brcUKOikYx+R+sF/ZdZ1YmU2of+nagwwphtuBz+SMKAqlOZdTQzsduq236o+1bMeuAo8korWcXFDLL8EiJ8sWqgr+X15DTZRYZzwKcca5TieVojfKZEsUuyukbOZ7kuwN2BwtcPZtHY2PfA2MYJkUb5wckG81s7c9jvLIKDsJGJ28bYnFrA8VPdZCvKzQ3vYComIBYv7StYO66xPHb/9cYtcKZ2hzkN4OCqgf+ImTMw3HyJOXeVtNfdzx/vu6I7Qr2lCucqaZOhbFn0ByIS7I2G3Ow26CHQlhRAxrLJUAM4xct1s+r4CHK2DKOEgbzag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783108102; c=relaxed/relaxed;
	bh=05KKm/2fQBziycvO0o5qtmP7hJCKgsH/Os/8U9RN5hA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMDfJWdVip7S7cfmMK+XA+yTXydkAaKBGiJpIZDzliMn3xYAUYVuwVL2tzauA8EfAtF4eePxiAikyS9BHFdNFkSmYZXRbLUlcDGdpu2wsXhkf4kdlFzG9jGaBK0mp+742UUrjlelrIofe1BgsSd8kR6XWpGf+1FdV6h+0W2X/osFrSEv77LRylR0hlF9GsgLXIKie4lhawZeC8jueWNyLtdXxXT8mVw2J21hNuLPOA8klMcA5fqcaFkTNDSN8/x46zwqnrDXT+kC3eP4EeR85TSS8PmE8USKHTK7tATgeEBUFHfZmgQxmPw/rltGEEIXykGLdgbf+f/RmSjDd7i7wg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FSL4OW4s; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ApeSz4Yn; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FSL4OW4s;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ApeSz4Yn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsPSQ16dJz2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Jul 2026 05:48:21 +1000 (AEST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663HjL8M532674
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Jul 2026 19:48:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=05KKm/2fQBz
	iycvO0o5qtmP7hJCKgsH/Os/8U9RN5hA=; b=FSL4OW4sqkH5b5j9AIsw/YhH1nf
	ibgm5Unh2DNBArFuPePTEp7ydMwknI8hVtfX3hafu/sPH/fll/+Yol1Nt4cgUW3O
	Q2oC0AjaQcNbY6bV1u3Lrt7No3E1HH/aXPsXP7AZG4RXN8ivUpyMfu2BoEamWIFl
	NW3X3tStizixNie01eHQ9xV+jNSuNRjFoUEqBSXss9qBg6i4tK2kHk4NWRI7Hght
	D9IYQ+nKevxHW9yac3lGAA5QYlnpXFWRGBioWY+Th7V0jEKaJwNAXJ3PPQeJmZTX
	xFvGCoL556Tc+tATu/JtYm9O8HvYscVvC/BQqEq/B3XicM6VWsCrI2LiN5A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f648n3smr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 19:48:19 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-37fca5f21b1so2248062a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 12:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783108098; x=1783712898; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05KKm/2fQBziycvO0o5qtmP7hJCKgsH/Os/8U9RN5hA=;
        b=ApeSz4YnQg0aWkUg8itsMZK6VFeIoRatSKIMzakFkaGQzAtT5JSBTMsDgPCz5A68Fi
         4YFdJ4XJOTt1m1jXCW2kfrTfpJyveZDs/1heDpluQf5KIY5M0CDivQs93OiG38eDt17Y
         qehJEhLzkPyYGi5BbjH2jHGOF2U5bOZ3Da75Kq2abZyF7dFUHP/jBKY5o23j43E4hI00
         QlAGUdKxbuGs5QosTzf2NOBf+a///hkEqG5Tm+jYWCMu3iUdBlyErd9GWmWHANE2HUb6
         IbRJ3Iy6gCzRQj21pySoLeZaZeDJb+WK4YQBqbzjCZOo50E8dywoJFGy2pFFG/IUKRCf
         sS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783108098; x=1783712898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=05KKm/2fQBziycvO0o5qtmP7hJCKgsH/Os/8U9RN5hA=;
        b=H+ODAGEQEizMOp8Cwd9Qkd357PooOunRss85QuLGHBcTzo64V2BdDEXGMZc3p6w/8X
         XEWuewiIaymKFYJlQvSv9LldEBMPw7v7dJFCg7FUuWMfKpiuwAUyON/Xje6FzKMuj5ZB
         VGA+kDx9+Wydl9CArooYppu2U0s0CNrRQhI0xfWFrKTK1a8NAQOOrlNU3HEyBH3lmQhd
         C39qnnkFFepnDw7O2hlWMhBBNftSEqGW5iB3i0Z6GWU1rTsXmAMfLo5k9NdazQPm/rM7
         vM6w7ortKO/yBO54v6xoknKg+3Rhq0Ok+3uhkFl1aFWeI8LwLHQuYkUHb4/8Ozb25JZQ
         oOfg==
X-Forwarded-Encrypted: i=1; AHgh+Rqt93/nmPOAXenqNOgkjBPl5FtSyl5AP/zXTR12XeR/bNBqNk4kYfyUklBVoScUUD/6BD7/RarJforFGqo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxpNwDNoelWBQNIeaNbHnl05prKh0v/PfXSb7CP18M0Q2f3N6kA
	gcvYzv583UqIFMSCjQ3iRDIUAPFAAJGexU8/iTK2Hw2IqcebmIURF8gUoGBicBhM78tq7vbh7I2
	hcj3mSAqDiWBPMXqDd0jAH200/6AX8xr1dJK8StEsS3tG0psKe3THRSWygCRbQuJIbh1C
X-Gm-Gg: AfdE7cnpkx+gjGHZ66npGgLpr1dO1sB+Pb25bzbfyTM8GOIHfI6UA7NOO2n66nBjZqg
	gVW/xNA5vVU436gD+DZAN5AWEPUn8XbXGg4fWce7lcUCB2DLd1/OffD+/t4r8o5834izFBSwCQ7
	DpeLpGBBtxNGI3qXpgPR/NQLhDpThmzNJfsakwEA8WahRCyhiEvsVXeaATX95rH1YVCU/3h9yks
	ykO7H/nEWqHga78Pg+e5U8boGwLncx32UuzMyNEC/+Mym5e0RRMSavGsHdS7MCDLTQp6WeN/tcR
	F1uEJIV0jgds1rFquPx/KZBIwk8YevosihMiVbG+6e2AaMas4V7u+V/EQHDvfHztfgLEWWrQ59V
	ebEf4iVMnfpOffdCzdioMRJReacht9j7Ws+YLmg==
X-Received: by 2002:a17:90b:5106:b0:36a:caf2:3815 with SMTP id 98e67ed59e1d1-38112340885mr6288991a91.15.1783108098258;
        Fri, 03 Jul 2026 12:48:18 -0700 (PDT)
X-Received: by 2002:a17:90b:5106:b0:36a:caf2:3815 with SMTP id 98e67ed59e1d1-38112340885mr6288938a91.15.1783108097697;
        Fri, 03 Jul 2026 12:48:17 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f290b6bc2sm10065845eec.27.2026.07.03.12.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 12:48:17 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
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
        Srinivas Kandagatla <srini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ge Gordon <gordon.ge@bst.ai>, Adrian Hunter <adrian.hunter@intel.com>,
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
        Fugang Duan <fugang.duan@cixtech.com>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
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
        imx@lists.linux.dev, sound-open-firmware@alsa-project.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH 22/42] media: mediatek: vpu: Use devm_of_reserved_mem_device_init()
Date: Sat,  4 Jul 2026 01:08:35 +0530
Message-ID: <20260703193855.110619-23-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
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
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDIwMCBTYWx0ZWRfX3D+gfKUei1IW
 0+7/Su0/zOCJtDZvor/3pMQ+TJAeIoeC4qHScmdXil+pOs/TPSFERTJoDr95HeEdLhrRqSfo9SV
 1xyeWoh9VI494kSrnomH8EEwYCIV3sE=
X-Proofpoint-ORIG-GUID: WUZWB4UNozeCkyFYyoAa7HtpsLq3KauQ
X-Authority-Analysis: v=2.4 cv=O4wJeh9W c=1 sm=1 tr=0 ts=6a481203 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=gqQKJLWYzfjTGvuwkdcA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: WUZWB4UNozeCkyFYyoAa7HtpsLq3KauQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDIwMCBTYWx0ZWRfX71AOqRm4XAza
 5AxArCnjRv/1vn9kYRvPsqpE2zu3WIviDshcMUMJLdWYQUDzPz1CcQXEIwc2M1yvxqLbfmlwfxR
 eifzq6WrQAR3rXyall2EC4QjZyUXKF4HDEwmdZyFm96j157Tw+0bpt+Lz77Js8MguejCYKTGaDi
 R4tDfs07lKa3ERoXKfJeSCwBlI9WhLBnz11C+aWjJhue06b5YOliVk0/70HEFGUv85VxC32+rHo
 XURZf4DE6va07OionfBd/6SnvmyDXjYQKGepboJ8VItSL7SvGmQqwom/MiON1nUxuBbGWqAH8au
 bYtf22ZFNdDKhUzRQmlc44pqDhyPEbkr12yUUudV/JZzp0WGI7W7jg+XVZfWFYmbiB4lfTFAIOR
 anEVbn+v1BcXNNPQTYVQ3iG6DPdKl7ABcBgFptwz7BUiaELPWah/Yt/TGfUVHhzeXiKrNSqZK3D
 01efrRF6nRG5q7f1U4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030200

Use the devres-managed devm_of_reserved_mem_device_init() instead of
the manual of_reserved_mem_device_init()/of_reserved_mem_device_release()
pair, letting the device resource manager handle cleanup automatically.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/media/platform/mediatek/vpu/mtk_vpu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/platform/mediatek/vpu/mtk_vpu.c b/drivers/media/platform/mediatek/vpu/mtk_vpu.c
index 8d8319f0cd22..557bffb2c2f1 100644
--- a/drivers/media/platform/mediatek/vpu/mtk_vpu.c
+++ b/drivers/media/platform/mediatek/vpu/mtk_vpu.c
@@ -888,7 +888,7 @@ static int mtk_vpu_probe(struct platform_device *pdev)
 	dev_info(dev, "4GB mode %u\n", vpu->enable_4GB);
 
 	if (vpu->enable_4GB) {
-		ret = of_reserved_mem_device_init(dev);
+		ret = devm_of_reserved_mem_device_init(dev);
 		if (ret)
 			dev_info(dev, "init reserved memory failed\n");
 			/* continue to use dynamic allocation if failed */
@@ -930,7 +930,6 @@ static int mtk_vpu_probe(struct platform_device *pdev)
 free_d_mem:
 	vpu_free_ext_mem(vpu, D_FW);
 remove_debugfs:
-	of_reserved_mem_device_release(dev);
 #ifdef CONFIG_DEBUG_FS
 	debugfs_remove(vpu_debugfs);
 #endif
-- 
2.53.0


