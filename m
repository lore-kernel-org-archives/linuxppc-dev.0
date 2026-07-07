Return-Path: <linuxppc-dev+bounces-23714-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07122C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 15:01:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvkvs5S4Rz2xpn;
	Wed, 08 Jul 2026 01:01:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783388230;
	cv=pass; b=c8jI+ox6a+podoREFRTGO1A4w6ZWePIXFfTJlaDnEWdv2ohy1qR/WtJH5tFQJUuaANvaLY4OLo8buma1pPrufxmAEhCZdmnwWQdQing+mKhxObrRnhX63ifn7oMm+xKgQvlDEX4WoAaoLGcKebSJgYJhIo586O/8bNDh8YvtU2i0bD0nzgFtvy9yddQJ7ujnFuiyDaMtguYx6DPiLdjVla+t5u/C0W4+o3b1DxLyDl+HPkqn/dUOwis9McPNM0B5NjXkj/p7SqZigTWpdb+PNPTha+qv6TgXVzXEQdr45K1e5zSeJXaXJxaCdOUuMPufY8gErDRzsnJv8oM3Fmkhwg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783388230; c=relaxed/relaxed;
	bh=zVAt++BBwa9Lp7CQU3w81aHy4kuxWu8xS5VkSssx/8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wi2k4ujw2MpZwL/5bf7kmjqhgCIREr+V7CP4kghv2KK7DAjMgZZ4ssklbOI3tSVDaW79scKJoEqeQdbswGlUBIhva67XguGbvO5nKRCVQliqyNkZK2Rgz4zN1Am1kzGhvOMfbXl99h94gs2fX/BKCq+XVlge4HvAWVUPPc7KD/1u9RDDZ2EZ6LZTWPoH+DUPgshNWlrvu4/GKHdFVuA7/6cWa+9tV+Nx846OfmyFncSSIVYwcJHX58DqkjW1Qh18oB+HcjK+vJsgiIoo43blJ1Nv5vJi8elHLdvo58wqYVkHxIpOoy2Atc7VZ5t+qASkeHPnC3sqsYEkOh/7YOLSeA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=gary.yang@cixtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=cixtech.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cixtech.com (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=gary.yang@cixtech.com; receiver=lists.ozlabs.org)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvP3T1Kybz2xyh;
	Tue, 07 Jul 2026 11:37:08 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=enilA8zYZzVL1Y1E8qXyS7/jZFIXtdnJgPiYOmK83r9gOPTKJqwAyI7CyKQs+aKJ1M+HROiyeuGbdPHmRVnJhy8f9qATTUWW/dR+MGYmZboIEBamyfvWeCtG4iGsKDHMY2kTdJvNX5nHkKeH7TKowAy9NEs1b0yc3CF/5K1y/QsnJDJ3tJKH2NOWanUBrhBBdaKZhZN/Ldv5hNETIzEw1qS3ZklECAswkfAwdyvZsZb6Z0hIrUVzYZFStGf3lUW33Dk6c2R8Dsy3z4d2cRMJHVFhIL64JDowVSpYTgqbLqB1q7KSMChujI+tLRZo//qeztXYZaGviP1AgewKeZG6ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVAt++BBwa9Lp7CQU3w81aHy4kuxWu8xS5VkSssx/8s=;
 b=SfMp+HnA/nq59x5AwpIC0k7qpcQi7ldLr+1t2moMNCA4VpXIRK3jyw4SzceIhwaMHBE62OTqFCusu/qV9Hq8mUU68M1RknexNMQwMUDWX/+KLaLBBZyVNSNGSGqQm3zZgCj9USN3uKolqS4FnPJiwobgFokr8JLFK3TBIPxfdipT4A8d5ADV0EfacqXDymSeClaJP+h3oiNPCUqGtmh3/j8fLFwEOVTATcnMN4cKKHaV2K0LTEk6qNqFqsL9MlYAmlqdDk0UAPnSHh+/XIkw/3D+bp8Tt4mg8bzdqVe0S5tO/Hr939ErpSqiU5v4MfF4esSzg4pG1LLn6dbXRZrL2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PUVP216CA0003.KORP216.PROD.OUTLOOK.COM (2603:1096:301:16f::7)
 by SEZPR06MB5992.apcprd06.prod.outlook.com (2603:1096:101:f2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 01:36:42 +0000
Received: from TY2PEPF0000AB85.apcprd03.prod.outlook.com
 (2603:1096:301:16f:cafe::97) by PUVP216CA0003.outlook.office365.com
 (2603:1096:301:16f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Tue, 7
 Jul 2026 01:36:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB85.mail.protection.outlook.com (10.167.253.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 01:36:41 +0000
Received: from gary-System-Product-Name (unknown [172.16.64.196])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 15ED34351F23;
	Tue,  7 Jul 2026 09:36:40 +0800 (CST)
Date: Tue, 7 Jul 2026 09:34:46 +0800
From: Gary Yang <gary.yang@cixtech.com>
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
Subject: Re: [PATCH 31/42] ASoC: cix-ipbloq: Use
 devm_of_reserved_mem_device_init()
Message-ID: <akxXtlUYtT3T-huE@gary-System-Product-Name>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
 <20260703193855.110619-32-mukesh.ojha@oss.qualcomm.com>
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
In-Reply-To: <20260703193855.110619-32-mukesh.ojha@oss.qualcomm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB85:EE_|SEZPR06MB5992:EE_
X-MS-Office365-Filtering-Correlation-Id: 58b0bcd8-fc53-439a-90a3-08dedbc83256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|82310400026|1800799024|36860700016|376014|4143699003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	PbsmJJUC3r+PSMHFYv1/5KAHLPksanDfP7Pr+9GjfsZBINxm7MQ/6oaciRBlKjgm8PiiDmCKpLrQa3R0g79rj/OxhD1HdasUwlMwOHrf0JU8wHBBXuG3hdrKLpnv3P2vBaYKWkRyc7YH5GxFLqRfvvRthoAbKoabp1FOx4VB5JAj7OOr80zr2tzMjzlR47UUAXdphACxz6nv6LEjFZjw5nkP/Lfsoqsy57C1SI/3g+k5VsMhfKjzOnAQN3EyPypuAs7HBnj/AgliW+5HrJP1s74vhFuGt9CA1adcAJymarP4P5Nu6rX/AGOmLp1FnrjZvD2gczG1qUGKllxinGTkHAq4cqKLnqUQi8kaQUtaGx1KVfb86Qb1Z9CU5EFISIvQPEeR4m6sVRd3OljqlwtBXwmq8NH0FKD6SzKRqX4kD7GACn0dK6g6lsKQaR0sduqxWfqLbbg995xOWjawLEAXZ5XeivDMAZdOzhoR1hZr9DyJLv97YF00hvFCX5vTY7XkkngNF6u6oJDxRFbKaxRldx2PRzrbyC1rKEQxL5IX49C9fw7ENvTpNXgi0JPL/z+qTwPIgc77MJq1fRsrgmnB0IzA4DF+dUOpoKdg8bFdE74+HkbQgvupu+ng7tbGCb//sb+zUbDWK84eo+dJfWy2FVgLDQ3OEd3TdRSJu+GPRJAWAcu149u8rXkMyUlF6D54k0cbFWV3qZoNda129jn/Gg==
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(4143699003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YQP9tmTZsZsst2XVhSMEt6ze26TOYYsaRySCTBU4b2JeGgsxxgjlxfxR5rqo9srtq52gxFXeRrAQpizWmq4rnR131aJL0yADN5UOJK5lOhRoyD34mXpqnTYllYtoO8lT3DKhABUr/r2VCTrknBLHcdjkvQxRqySLGfkJL2ujdOo/T6nQjmBRjqZerpuQXpvNUbQjY+9vRg32YosHnAcL16AMcUeJKjcxDswM9WRodsARyKalf+gPqZeGfVvQ8KBlfqwwBXHZU+z4FORlOWYRleGy1UUtXHCYuF2zFO2AEVXiVpYxVmrrfudDWbEcZaDDnNgniI5tZ2x+7qCWJ2wsDNzhdk4pdS+t1rXnoA677qfpLmy+0wLuODVSDADMZKXY1btJl1j4/a4CCslM/GsYj2UZ3ZJuQONRDXT5z0louJEFMWXX8aZh++Us93/xLCDu
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 01:36:41.4300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b0bcd8-fc53-439a-90a3-08dedbc83256
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB85.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5992

On 2026-07-04 01:08, Mukesh Ojha wrote:

> [Some people who received this message don't often get email from mukesh.ojha@oss.qualcomm.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> EXTERNAL EMAIL
> 
> Use the devres-managed devm_of_reserved_mem_device_init() to ensure
> the reserved memory region is released on device removal, fixing a
> missing cleanup in the original code.
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>  sound/hda/controllers/cix-ipbloq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/hda/controllers/cix-ipbloq.c b/sound/hda/controllers/cix-ipbloq.c
> index c1084a915c13..815932e5c58b 100644
> --- a/sound/hda/controllers/cix-ipbloq.c
> +++ b/sound/hda/controllers/cix-ipbloq.c
> @@ -257,7 +257,7 @@ static int cix_ipbloq_hda_probe(struct platform_device *pdev)
> 
>         dma_set_mask_and_coherent(hda->dev, DMA_BIT_MASK(32));
> 
> -       err = of_reserved_mem_device_init(hda->dev);
> +       err = devm_of_reserved_mem_device_init(hda->dev);
>         if (err < 0 && err != -ENODEV) {
>                 dev_err(hda->dev,
>                         "failed to init reserved mem for DMA, err = %d\n", err);

Reviewed-by: Gary Yang <gary.yang@cixtech.com>

> --
> 2.53.0
> 

