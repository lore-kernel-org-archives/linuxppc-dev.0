Return-Path: <linuxppc-dev+bounces-26023-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE535C5DF81
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Aug 2026 15:48:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQnsv4c6wz2xT6;
	Fri, 21 Aug 2026 01:48:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787240931;
	cv=pass; b=DTsi0PphzEVtq7dJGEAdaKO1JtssFbTp50Xe44Z0Gg3xLujwRCKRscHPoO3cPmQ7Hl4pIKtTRIorSu1TBs0a5jE6BWXf2n/ipkvq3nZNAXSCUnSpVTjHLpIJWpi26sII9zPGA/+LcqFl84q5Po+VzJLaWRwZo5Nz1YFIe0ZF5yPQ/IWrIKQw3gZ81BRb/5wgMM1ydsce+KE7YNEeA3xkmt0cgv+P/gML/rJmOI7DDtk1ALbQX9gGaEkF4nMba+Hjf3j+5eVyERJFy2Zn7uuUUFPPMrL8mtVBX4Dhl6+cjL56U1kOKr3FWM38eK56vfOXXZp0wnaMYcbcvlwaHaeTWw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787240931; c=relaxed/relaxed;
	bh=Ud6aDbZ0Lcn7skElVQT7S1fgF2RS44N6gV8XrR01MiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aOVdjE0qa8jz20wuoa5GNHC6+98AQTrJrDWEEc9PuO0Zj3E1EApUoImw85OiFFfU7iad/jAC62DdHAs9mtR2WGf+AAczK059JW4ftSNXgPoLsxEiMzjYEF3EzgZ82+UvxH3bZ0geIGR6FkaREC0qDjT8MFzJKOl5VHYB5yB0AaZVRJfLyiS4OoGcaS/THw83P+CBCzbZW5pxuLo6bZw6I8qY5COM3NyflC3Say6kkmsoSefE9J0zo8FBJosvO4oOyHMZQFRj/DayQlVtNaCTRcflFU2wQl8Fb1kIoBH61v1/KbVkVdyzxN1P8OSbH7zE6MFEzrJTH7jiLizI+gtxtg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=d8QMWAsA; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=d8QMWAsA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQnss6l53z2xRw
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2026 01:48:49 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N61fI3ych7FBBLBDTYiLBxJVR8gmznAgRHnutHv7Uz6Knyx9SJIrSs6Q+s6/X1tLdeSltHBhi4ZBTB4E9WgUePwDV9CgsOEhHjBBDUvWi9f4S8FHJAAuL/TaubGdkTxVlUQ6PVMQ8rgCfAo3fmTulT/g73NDdkjg2OygdcuwmC3OTKNpYYp7EnaLC7q15bOKSmuBqCXeQ92C0qdjqGJowJBy7Qdtrcw4WKQ4RwxZ8J15O567ZJ6Pp5rhyeJKnuMLhGkJz9O8tE+UTC8ZOymXfXkaw/2D7kFAULgK1oSOCoikKPs9CuMDIDEhuvR9bX5ojv9HGNkvom1egfq374ygwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ud6aDbZ0Lcn7skElVQT7S1fgF2RS44N6gV8XrR01MiM=;
 b=eqfmx6xnsjqoqa9m6vfnN0utDG+Lwfxk5uqjEYONz6ES2/bhNe3kq4wBsmN3BBMT8enWTU178FKWcXs/PKCCUXcaYJz2HTit/9OjJGLoqhT3Idp/hBV8MEGxvctfJZCJe4d8an8cog6wbHlCjlrZF3EFKQerfLqooT/ILJB/xJu1xg06EdHEwIQjdxF7PEMc/Knd35wXhfvrqAtF9A2AACArfe2Y4QFrOBgxicb6eLztG/0SXHzp4s931UncyuHZvUBAjVuZNd9DPH250mU1whmFMPQPOwEyb3txeZkllQ5/8DShSwB5i+pbUeKUhqFTPf907poC6PVf7LY4hynvJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ud6aDbZ0Lcn7skElVQT7S1fgF2RS44N6gV8XrR01MiM=;
 b=d8QMWAsAKA4mmuq2yFjkBhx/qsTSpXBr6aJtGdxJ+S9vmsUmpXOujMlJLX0oIOa2xS25G5owfx5x0RNO9XF9qbgbANNagThnmfNt2DDDWbZ3fxvhtRqfLOS5H1fD/jc+3m5YLNCJg4Dxi+U4y6MPHoe2eZFhBJ0O87ugmfBh9mDwOUgM9zVveX9r9YQexBoeEOjVjhi6wSGN/XQ2BUWkQ3CcOk0waWY8hYKNEpdW+z37OxdaXHMtk0TFvjtYFQpbG6qz6HzmPBptuV8oxj/MyKlJpJX2QAenjwDliujcxf0StVWv/aqNFsqyAk/ONJOQWoozVNHoBRbp1Yp3DKBQNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV1PR04MB10776.eurprd04.prod.outlook.com (2603:10a6:150:20b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 15:48:24 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 15:48:23 +0000
Date: Thu, 20 Aug 2026 11:48:15 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Chancel Liu <chancel.liu@oss.nxp.com>
Cc: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
	perex@perex.cz, tiwai@suse.com, Frank.Li@nxp.com,
	linuxppc-dev@lists.ozlabs.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_mqs: Add DAPM output widgets for MQS_L/MQS_R
 pins
Message-ID: <aochvwR3MubqISOS@lizhi-Precision-Tower-5810>
References: <20260820021454.2229094-1-chancel.liu@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820021454.2229094-1-chancel.liu@oss.nxp.com>
X-ClientProxiedBy: PH5P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::17) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
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
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV1PR04MB10776:EE_
X-MS-Office365-Filtering-Correlation-Id: 607623b9-8cd9-4006-b2e3-08defed2778c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|19092799006|1800799024|3023799007|56012099006|10067099003|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Xr7+omjhw6cZE06Mf4g5rjMLZRScNEDURJtR0NYcBg5JatjJl8Aagi+1+UJXkxoAxDN/z4sqASPBkiDkUqWSr66qByvPvPb0wozcogWLwk8waUWcwd4GwpwzdVO5Ccj6X8IYR6D1Ful3Vn8iSxF0fV98p+0GaAPGd8jwlx/4kNu83q1nRlsRag0Yo6W8U0vka1qytDSAsMVUkmtejm3lmnD+vmDAx94MjXiYCHUpVNJxlWXYuAzvbQyUUzWFacwwQWBN/w0NdYvAbtuTVY4jiItiMlanmkW5dBGslc2jvGIsEvhRNQbTQ6PJz/8RAk3MsDcGQ++aBN6QkkWgGtldp689D/Fappv/WblN/N01yG415m6Km+YFuSi7x14YNT+aC1A/CRRTyd4ygPxBAwC5TDWNj/qdFp02CTDytwfCnYc+SdmUErDr+wtMb/b1lUPavCxQXVYaVGjIuVtba0P+nE4Yanw/X6bDkpz/cctooIHrra2xJ/d54yWCDQNr/XufQTyTWliDG8+U0LyJytAFbI/+UzyBQV5umhBvHVmCqT/IiZMagBcLLESkPyvgh5ROmuxXK+o8vtD555wI+ge9DHSZ9JDjMPiPdN1BjNK92OtYMgaspr6ex04iUx8eE2r6IALMOdZC5Nnwu27QuZtVohzHSPXzqo1sQvnnnMnxmiw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(19092799006)(1800799024)(3023799007)(56012099006)(10067099003)(5023799004)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7zXq51mecgt9zhdR7/6hex9cfjKO3+KubMWr/MrJHx98kdQJcyVI33qGI9kV?=
 =?us-ascii?Q?HPg90t+2IIcNW1IeJ+Z/HNfU17nZ89grW3jmCq/Bx8IzLWY837FOa+FExgZ3?=
 =?us-ascii?Q?qmbAxIJ9mEKssefBFGRpBImCK/e2opbWRSd61dXTQkH5W3qgFbHHqyaLYw7d?=
 =?us-ascii?Q?MXSzsHtP3giHbqxMERK31ul37Tjt4og3AJ0PykfL4XHWTvXiEF14YWfTs8qR?=
 =?us-ascii?Q?xzPLd2vgr1UicJEDkLtrL/v6TTsyfZAMyz8d+rgMZNnEhNgj79aPVtS8DqVR?=
 =?us-ascii?Q?AUINHAx+CdtR+80dWO+MJlCWioy+Wbeq7W3UN/dG6AJzIs7nqoh2uZQx8JKj?=
 =?us-ascii?Q?CLmerSFLVXI1J9Nnr7fMKG4F9ChBqfP8xm3NhA2pR5Kj1bxw1fVzwTSu0S/D?=
 =?us-ascii?Q?qTc3Pl1RoSg4agU24fETyDnUdjH5vdXiPF7eVlpVYrzcfcIQLWrVWLlW7Afs?=
 =?us-ascii?Q?vLwc+AnsHVbDzzUg15/tqHSmquVfnjqSy/pSIk98Z5kcjPqPI19Wska1xVUj?=
 =?us-ascii?Q?yclXocrmR5m/ovStm5n0b9r5b9AQlRi95geC15dFOYsKEd+69rxrQnKUUHjr?=
 =?us-ascii?Q?HNsAEZUZT9St4WQP6woJ920t1C7d0ELGEaYzDRc0rMgfA5h6am6Aohs96+ft?=
 =?us-ascii?Q?amTBAhCS5np3CT9Ar40Tyk6bpTgjdJglfFk14r+26a5wmCB5uEeA/oeDAI21?=
 =?us-ascii?Q?CbX989K3G2UuNwfAW23z69G6FJlRylaKtFawGoHLc1RYS9sGiXxZYAyeaL60?=
 =?us-ascii?Q?hJWDrnhOsmKSIDy3BB6uIGiXR1tRWAoIniF9GyEsewT1nIvzeLp/cyCzyish?=
 =?us-ascii?Q?RIF/SKGrw1QWQfo8Pikk27dWZnW6V+ePOzNmygnpvhQINRFlknLWrl2Vlhpu?=
 =?us-ascii?Q?VOxjb+Azc+TA9H1dpCXYvkc34+DwdztA7ULJI8RUUsC/kecUXR7zMm/S7V9i?=
 =?us-ascii?Q?zo9nMsGCjfhsaRkhEN602bmec+a86YZ0435eU6LSpTP0owoe4A1+7wGW6N0G?=
 =?us-ascii?Q?am3pObWHbfjlb0IyyMr9h/NLqUmA8qCZ+QxDQQpxHZlahuofLOdkWgJdTJEK?=
 =?us-ascii?Q?6o6FqaSVI+ogRhFhaGZkZfTRFY8XRNK/kKaiEgj/Cd3jkTV1xkrX/C2VeHcu?=
 =?us-ascii?Q?4vccSE+yilN0wZOR54BG6c0d9NGp41qJA4IdkPeJWXKkNg8xHBscfiCgYIMQ?=
 =?us-ascii?Q?RJup8B/ue/pzLRNSRf2XNJ5JGsQWtLVGAlB8uqI39grx7yaZ/LQkBnB4qiHY?=
 =?us-ascii?Q?PloUketwGdPV6wbxkKloglspNhYu5wwsE46OKhN/vOoIc30QCXYWdNgP5eq6?=
 =?us-ascii?Q?9RdsnPY4+5Eui+Jcd4hiF/NWWrjjZZvj6LIaClxpoqFgV59tbNoMFba1zTs7?=
 =?us-ascii?Q?W0v9rIL1yFqztQyBUbt5A38ogXceaxBmMLQAXwuTKLn9oev4bGliAaGUvnns?=
 =?us-ascii?Q?IYYCjaTwC8CPNRShZZwwsKiesnUrgh9baisWG9BKZ23ARDZR2RCcLFIorBr6?=
 =?us-ascii?Q?t1uk47xqyuXNkcdJYyFwLV/zznFQojJ8nOF/mevUgPcMl4idOripAdKni58p?=
 =?us-ascii?Q?bFD31ikM0kLmbXqn1K+wZ7ldWqHz/7jD86gm5FkollJVKnJbAFj8Zldw8Ycv?=
 =?us-ascii?Q?pvUd1SON2MLNravGxMe9cyqmVPistNeJ2gAxPFGrcY7gX1e3Eozb30CVPWtK?=
 =?us-ascii?Q?jC+4+CvHElPpRHayia9C8pJKdRTjgh22LuwK4OnfiPjFAF0YNU2guz6sUUca?=
 =?us-ascii?Q?/hRknUtbsfwfuJR2htI9eCGRIkFvFr3ML+fQ/fo0F5msc8qTfZoR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 607623b9-8cd9-4006-b2e3-08defed2778c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 15:48:23.8154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YkrV0CVWTSmy2jN+0s4tE0h1nOCKr3DfQ9vO9+rqkD/OtYMw6fIdoL3TN4dufPyE7VdQiYVmn3cPFW2euO5W0Jnz3s11iqQyvKlQ63MuzMXSN3vDcnpOdV129gjxWoz+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10776

On Thu, Aug 20, 2026 at 11:14:53AM +0900, Chancel Liu wrote:
> From: Chancel Liu <chancel.liu@nxp.com>
>
> Provide DAPM output widgets for the MQS_L/MQS_R pins and route them
> from the "Playback" stream. This allows external amplifiers connected
> to the MQS outputs to be properly linked into the DAPM graph, so their
> power state can follow the playback stream.
>
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  sound/soc/fsl/fsl_mqs.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/sound/soc/fsl/fsl_mqs.c b/sound/soc/fsl/fsl_mqs.c
> index 901f840df904..5b00488253bb 100644
> --- a/sound/soc/fsl/fsl_mqs.c
> +++ b/sound/soc/fsl/fsl_mqs.c
> @@ -183,7 +183,21 @@ static void fsl_mqs_shutdown(struct snd_pcm_substream *substream,
>  			   mqs_priv->soc->en_mask, 0);
>  }
>
> +static const struct snd_soc_dapm_widget fsl_mqs_dapm_widgets[] = {
> +	SND_SOC_DAPM_OUTPUT("MQS_L"),
> +	SND_SOC_DAPM_OUTPUT("MQS_R"),
> +};
> +
> +static const struct snd_soc_dapm_route fsl_mqs_dapm_routes[] = {
> +	{ "MQS_L", NULL, "Playback" },
> +	{ "MQS_R", NULL, "Playback" },
> +};
> +
>  static const struct snd_soc_component_driver soc_codec_fsl_mqs = {
> +	.dapm_widgets = fsl_mqs_dapm_widgets,
> +	.num_dapm_widgets = ARRAY_SIZE(fsl_mqs_dapm_widgets),
> +	.dapm_routes = fsl_mqs_dapm_routes,
> +	.num_dapm_routes = ARRAY_SIZE(fsl_mqs_dapm_routes),
>  	.idle_bias_on = 1,
>  };
>
> --
> 2.50.1
>

