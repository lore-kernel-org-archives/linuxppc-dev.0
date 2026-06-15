Return-Path: <linuxppc-dev+bounces-22643-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0691CD98C5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 14:20:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfC1z3mzdz3bxp;
	Tue, 16 Jun 2026 00:20:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781533207;
	cv=pass; b=RQGL1dHuv6B2O5ZjObnpceHEEH5G2MnFweBIKK90I2X3c8Tlj6T2OQSmeQLlOEE6Zyfkb69SPG4eltrZP2Dai77yOYU4PV3yGGYAOISlTqEZhQXTV9CYc7GZvkCJHHL9hSVW1CTHkpDAUWwvHuZMQVP3zhIsavoo2xUiAP+BpxNTf9y5v/AnfZqhnUFsL07cT47a3Xs3uNQiMsGAa+Irbizob/I7xxGPSBriwtpetmi7wcTe3dJoM1MN7Z5E4Y8k6SUHzbQxdIcqY5fGvBTSHfpu2cvUBo56Jcu80+zCsxX/0c2HfKmsXloDUWj+nHcBfKgl7TzM99VMLZyKX3cOMg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781533207; c=relaxed/relaxed;
	bh=p1kdlnAu1jVQNBrX7vCr57oOIGSXdyFltvXhu76GypI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zrp+dGrc/MMBR44N38wn/bYO5Tyz0K9UPsVP/OqYVpOCHz4Ys8mwBTS2lC51nJ5+8wpXc4aJ7eQ6yPwBOYKJUI9T8h4x1yFA++FFnq1rdZx7ni3OyNzNvc36j03npU4/ML02EOOH4VkcUgpBcmieornMZBZF8+lWEvH2UvVBJAhiCUJSozH25mjjwSF6cYZ1RjY/lOV4U3efxvbSuo9g37bNTZvCyKml5gexXnnot4rh8kzfk8VrYszuGzirFmo29h8B/nsisa7isHAFsGfe1vBYXwRhZaIl1mcn8yCKvb+CLkVgg3QqQ7Tqea17CM7qDqA9JiLmFrHT5qu6DtchEQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=XTLy2oF4; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=XTLy2oF4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfC1y3xLxz3btj
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 00:20:06 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J13YJnd+elXu5xwcYzH8xKVZOcuY7YyJn8Ccd89m+/sUZZJ0P4xraqy8hTrMiKeQPevOEE4ALktyj1oq/pL3H2miMPNnhqQpiQvP74spkKcWIaRcEgVdKGcZHbe7SuHqTAqVV7J7BGvZyxsOV595bQXyVcOevKxgvi2cUEidrnVxz7jPJkkOB5/2dg5A6HiJi/J63A+IBXmncifLHSgC1Cb+FF5Flvkx5S8YgKvj+UBm2FP9CcupCO/G+/7hFMbNnVZLUFqDhj2T6PCC0cXvbOqdEQsavAlgufrA0sbJrVgEwCedsHtFy2M+WKSaqeCn5VqwhRlCiaiDyq5j1g8H6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1kdlnAu1jVQNBrX7vCr57oOIGSXdyFltvXhu76GypI=;
 b=ZQU4ckZknTejiychNZCVFTrMtqp+3F4nBgZ+hOEgzMbopKxRzhfvw5GWO8d40r16rOC1e1DnCEQNym7+lUqH98V5MaN6qnBYbpg1MF+pBdX57uwgPOfUNT4QQu3srQei6qmrsMDL7sxHdJ5QIzxGNI9JW9YATBWdElN/CwsW+3dLTu4P9dr5QDHdcwDfUL7OlFUkBZL1As8O6NII7VuHU1MJaHySHBcmOQBpkH9Oi+cazTTlYgz2iLYQ0TGaPMGkh/wz267eLNcIiJc9Qm9GWr65d9mZOZMAlSWc1OGU0zWLML4bYyp00ZdrJdW5LogDmbg9hnRdO/2gp89sgGVWQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1kdlnAu1jVQNBrX7vCr57oOIGSXdyFltvXhu76GypI=;
 b=XTLy2oF4nlQ891R/EMWGi61cmfoQiruWYDQi45aqaYNWTl8m9hKUwYhVogG+vll4P+2MZGeUgUapY8S0/FXwWw7IX2G/a85Vutv9v/UBlMbjSCW+/1PZGSRTI43HVDf8iWJe6W6pQeCc3SemjMn608Tyrhty/EnuHnfcRVxik5U/olyt7dwR/7Wo7gG4gV5Sa3gu9I9gXB/e+kgz4WlRJ0zrvsz5Mwnv3/De+4GASK/rjyONzvPkEKq8s7J91IVS5UloTyR1GuscevviN0Glzfj6FAKwdRY7VLhYb6Mm+H1jwSc9EMOkipkoJyxEU2AlmwRfKvTxGLZPxjRgT75qwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GVXPR04MB12037.eurprd04.prod.outlook.com (2603:10a6:150:317::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Mon, 15 Jun
 2026 14:19:43 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 14:19:43 +0000
Date: Mon, 15 Jun 2026 09:19:32 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: phucduc.bui@gmail.com
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 07/11] ASoC: fsl_xcvr: Use guard() for spin locks
Message-ID: <ajAJ9AVNhaQubFBz@SMW015318>
References: <20260615093824.115751-1-phucduc.bui@gmail.com>
 <20260615093824.115751-8-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615093824.115751-8-phucduc.bui@gmail.com>
X-ClientProxiedBy: SA1P222CA0127.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::17) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GVXPR04MB12037:EE_
X-MS-Office365-Filtering-Correlation-Id: 23967489-1f95-4f79-a2ae-08decae924f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|1800799024|366016|376014|7416014|56012099006|11063799006|6133799003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XDH9naEIvl8080ehoWEoox1ybpeM6NmzAQxR2o2SaL95j0KWSXKwhjwOyXkPKkPJ35kzJekLkOxKt42qH2TbNHlDGMseKmWoMKYzH9GNow5Clxpde8pPdu1oqDJcQ5BNEwonH9KDx/IuIQEwhwM4RWpc0qG+v42541MCa+yOk+bRs7qvkbjvsIYMZlAkU3HnnMb0jjKDTXTuxVIgg5ErCkPsenv1MemSnQKx/MNQpEEEtKEfytbfkszlx7ekqYywpS/tg7L00xvPy1IqWtyhWhDRABs7KDngduQiAur4K2YAcca0O+ebb2SmGpr9o6/9ZSDJG4WfGp432s7fEM4Q1C7ub+ZhTYjJMSgB7VscwvPsNm0j4F9TGSeYgcDQPGp4RLs0kLlo6QRM5Y9GjIFolFLY5052Gixb7Xvw/y0MierNvjg3J5XNBSqKDt2dRAseBXjD4eonWuWJ/gokZGF+x3XKXVtXPuXFq7WQoZ8zf8jSKNLUHWBL0srVg0wVzp/qn32P+HL9r+xqxQwcgFyDaWQjD4vRI3pOmA1CAD0LFAE0mkMqsN+Ku6cM1BsMY0qnc+0/WeCtOw73jaTV1GSWdZXf2ndR8laqhg9wmxb2zkTzOdYAzbur8S3St6WDOEXR+Bf5ci62mn5fZuV9x+BsMdFg/mbVnJ4ShdS4bmxS/YxcWhXRPyfB/J0OquvQcxan
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(1800799024)(366016)(376014)(7416014)(56012099006)(11063799006)(6133799003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dVE/Wbxaipz+EN7JcUdsKRveVivSIVgJaBbnCgy9eUAW+3bg3LXNRHpB+4Fn?=
 =?us-ascii?Q?Qzo/8UdqHe66H32vR/uTkDgVai1yCE97Kw8dwi84VBUDiC3CHREpsyajETzP?=
 =?us-ascii?Q?4NKEA5fmvrVUSGJbyM0nc5qP5vVgAeBu8aJgLm61ltBZYEpOQsaE5SuEfjFf?=
 =?us-ascii?Q?Tw9PNoxOX5BTVKTKnqmmHWirpBxQux+Ctyp6o8UDXquKQo403OM/2fiPEWlw?=
 =?us-ascii?Q?iKuiI8XlL8Ohbp7XhSzf23XipY/CZgspj2Zq8dwBIiy2yG/3bQEprnxxNgPJ?=
 =?us-ascii?Q?FnJ3b4gzDvPyrUE6w264JEPl30yUeEyJQmvts2SxQwrZll4Md6o3LsKl2hwx?=
 =?us-ascii?Q?cxpM5f3WEvRrzDCZxvm+RRfWf6SDha+yiKSlvD0SKvGZBPg+qcNCJlTnZIXJ?=
 =?us-ascii?Q?7xJDFOJTyjSLblzZr9mOKlDKJfx+jxlk+IRPun+lRAZCBu1kqD20j+6Koja4?=
 =?us-ascii?Q?m0gpu78x2kOjT7UIlLetU5pgIZJ4maHsKhsHajM5bhIR9BWWD7KOvs1co/6t?=
 =?us-ascii?Q?i7No9bsGJmD0dE2Uy++F1nSvFO0pc2qJ9yMD8mQQzy+7q17YZfg8oNLQIcKs?=
 =?us-ascii?Q?/EOWCSmtAnVY+JpmqZzioHNIuu0yiZOALeqwQI2+gxOCMgXT82OR6dvy7pp6?=
 =?us-ascii?Q?oRSu7SUGDvYWAVsk2fELSG242ZDhH6Ho40SBsk7uwu0HkSVQfEyKw3ITLGY9?=
 =?us-ascii?Q?ZSLln0bd5tXqjmLr8SKGEzTfuu2l6oRIWJcBMuJ9qsjVGUDrI0IuM0q62E7L?=
 =?us-ascii?Q?GtBq2Z97KpFfn5gnJlwgBqVwLoRMeixay8AJugEzbMW+5UW72NZv4+4rx/3n?=
 =?us-ascii?Q?wIEZwM3xCw9JLQXCuhQR6N4uq0u4TDqdmXijX+QpU/8Q60rmdovuTS/92w1T?=
 =?us-ascii?Q?uutVCwxMogrwIbJcITQTx8fBcXcGnT8AFSirYwMTrVD1icwxiuKCGvtQu9GI?=
 =?us-ascii?Q?YLiNdBKDfVeOwmXl9Oe60Z27AW/0m6l4J8ODm8O9HMCO485YsJPBVJXrQdMw?=
 =?us-ascii?Q?/lqfX0r/a8kxB4+KlPwMR52HwbT6rsDn3ZQyw5tVNoMVu0qBCj0lzhrt2t6a?=
 =?us-ascii?Q?9jMoCGAMlvbauI+Qi+iq2EIRfhvLut3oKP6PQN+ptf9CJLWFp/PFpjMKewEd?=
 =?us-ascii?Q?kWWbgqqMM3cRaFUxQOmpN9ScFLMT+kdODLx+A2YSZUIrSLAU4EnWFKrrKs9W?=
 =?us-ascii?Q?/xBzQpn4hHIiKmLsnDwoVwrXt80Tzq+sCHXw+6sYtko6VaBUvxPg7BKw/5zp?=
 =?us-ascii?Q?y991EHeyXh26KlvMmALtReWCcQRmnd3vqaRvvxLVkEh90SlJdEkqt299CRJo?=
 =?us-ascii?Q?EYj3ljFxtp5WVYndf7FlRV2V/g4OmUa+Nls4J/dZaS7FiMGFEmG3rLDVcs81?=
 =?us-ascii?Q?oTmN0f+Uh3gB9xMMm/RutP6LfDMCD3j4uebxkSMuufS0dVVWObpUI6/OT19Q?=
 =?us-ascii?Q?IZANYAJ/gVdmDwm9dfPRBK4rivMxa5tN3rSDjeMgFWFWLsAtYUwrMK7L03nC?=
 =?us-ascii?Q?NwJz+dU0Gmhlg8//ZHEpCDdEwoR4n4bHE73AwzTnRGvuIVMKhltI/2UdRjrE?=
 =?us-ascii?Q?ppi35AChkKjMQAGAwxV9RGfCFR0HDtdTYcrvvFeRBMd9e/VH0TTe9q3nX+2F?=
 =?us-ascii?Q?tq6G25se8TF6MWN3X80BgF/k54lruKt5SAn9MyN78a5ECG+6KOHPGMe8OGXi?=
 =?us-ascii?Q?6FaNHg+0qvvm9+PwfbLT0o8e5Xhkw9gbpXyx5CsOP6WvnVbZhFBeKCPYbtAV?=
 =?us-ascii?Q?VsdNqX4/6RDjyahr0W90qhlYpfUo8FkAWrbdMIG7CTXCUE4gB3I/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23967489-1f95-4f79-a2ae-08decae924f8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 14:19:43.2705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: seChDdDF3LsTGZGFoGAKOQerD1kWiG9UuBgIxhXieri+5MZW+ThlG9qPD8yWQUVX0gO2U+0YbNd+la+nBTVHjUwbOp+5HRj050PQzGn1PF7HbYa3+iBL8m1juzb8OkUS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12037

On Mon, Jun 15, 2026 at 04:38:20PM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
>
> Clean up the code using guard() for spin locks.
> Merely code refactoring, and no behavior change.
>
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  sound/soc/fsl/fsl_xcvr.c | 29 ++++++++++++-----------------
>  1 file changed, 12 insertions(+), 17 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
> index 6677d3bf36ec..41d100500534 100644
> --- a/sound/soc/fsl/fsl_xcvr.c
> +++ b/sound/soc/fsl/fsl_xcvr.c
> @@ -797,10 +797,9 @@ static int fsl_xcvr_trigger(struct snd_pcm_substream *substream, int cmd,
>  {
>  	struct fsl_xcvr *xcvr = snd_soc_dai_get_drvdata(dai);
>  	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
> -	unsigned long lock_flags;
>  	int ret = 0;
>
> -	spin_lock_irqsave(&xcvr->lock, lock_flags);
> +	guard(spinlock_irqsave)(&xcvr->lock);
>
>  	switch (cmd) {
>  	case SNDRV_PCM_TRIGGER_START:
> @@ -812,7 +811,7 @@ static int fsl_xcvr_trigger(struct snd_pcm_substream *substream, int cmd,
>  					 FSL_XCVR_EXT_CTRL_DPTH_RESET(tx));
>  		if (ret < 0) {
>  			dev_err(dai->dev, "Failed to set DPATH RESET: %d\n", ret);
> -			goto release_lock;
> +			return ret;
>  		}
>
>  		if (tx) {
> @@ -824,7 +823,7 @@ static int fsl_xcvr_trigger(struct snd_pcm_substream *substream, int cmd,
>  						   FSL_XCVR_ISR_CMDC_TX_EN);
>  				if (ret < 0) {
>  					dev_err(dai->dev, "err updating isr %d\n", ret);
> -					goto release_lock;
> +					return ret;
>  				}
>  				fallthrough;
>  			case FSL_XCVR_MODE_SPDIF:
> @@ -833,7 +832,7 @@ static int fsl_xcvr_trigger(struct snd_pcm_substream *substream, int cmd,
>  						      FSL_XCVR_TX_DPTH_CTRL_STRT_DATA_TX);
>  				if (ret < 0) {
>  					dev_err(dai->dev, "Failed to start DATA_TX: %d\n", ret);
> -					goto release_lock;
> +					return ret;
>  				}
>  				break;
>  			}
> @@ -844,14 +843,14 @@ static int fsl_xcvr_trigger(struct snd_pcm_substream *substream, int cmd,
>  					 FSL_XCVR_EXT_CTRL_DMA_DIS(tx), 0);
>  		if (ret < 0) {
>  			dev_err(dai->dev, "Failed to enable DMA: %d\n", ret);
> -			goto release_lock;
> +			return ret;
>  		}
>
>  		ret = regmap_update_bits(xcvr->regmap, FSL_XCVR_EXT_IER0,
>  					 FSL_XCVR_IRQ_EARC_ALL, FSL_XCVR_IRQ_EARC_ALL);
>  		if (ret < 0) {
>  			dev_err(dai->dev, "Error while setting IER0: %d\n", ret);
> -			goto release_lock;
> +			return ret;
>  		}
>
>  		/* clear DPATH RESET */
> @@ -860,7 +859,7 @@ static int fsl_xcvr_trigger(struct snd_pcm_substream *substream, int cmd,
>  					 0);
>  		if (ret < 0) {
>  			dev_err(dai->dev, "Failed to clear DPATH RESET: %d\n", ret);
> -			goto release_lock;
> +			return ret;
>  		}
>
>  		break;
> @@ -873,14 +872,14 @@ static int fsl_xcvr_trigger(struct snd_pcm_substream *substream, int cmd,
>  					 FSL_XCVR_EXT_CTRL_DMA_DIS(tx));
>  		if (ret < 0) {
>  			dev_err(dai->dev, "Failed to disable DMA: %d\n", ret);
> -			goto release_lock;
> +			return ret;
>  		}
>
>  		ret = regmap_update_bits(xcvr->regmap, FSL_XCVR_EXT_IER0,
>  					 FSL_XCVR_IRQ_EARC_ALL, 0);
>  		if (ret < 0) {
>  			dev_err(dai->dev, "Failed to clear IER0: %d\n", ret);
> -			goto release_lock;
> +			return ret;
>  		}
>
>  		if (tx) {
> @@ -891,7 +890,7 @@ static int fsl_xcvr_trigger(struct snd_pcm_substream *substream, int cmd,
>  							FSL_XCVR_TX_DPTH_CTRL_STRT_DATA_TX);
>  				if (ret < 0) {
>  					dev_err(dai->dev, "Failed to stop DATA_TX: %d\n", ret);
> -					goto release_lock;
> +					return ret;
>  				}
>  				if (xcvr->soc_data->spdif_only)
>  					break;
> @@ -905,7 +904,7 @@ static int fsl_xcvr_trigger(struct snd_pcm_substream *substream, int cmd,
>  				if (ret < 0) {
>  					dev_err(dai->dev,
>  						"Err updating ISR %d\n", ret);
> -					goto release_lock;
> +					return ret;
>  				}
>  				break;
>  			}
> @@ -916,8 +915,6 @@ static int fsl_xcvr_trigger(struct snd_pcm_substream *substream, int cmd,
>  		break;
>  	}
>
> -release_lock:
> -	spin_unlock_irqrestore(&xcvr->lock, lock_flags);
>  	return ret;
>  }
>
> @@ -1448,11 +1445,10 @@ static void reset_rx_work(struct work_struct *work)
>  {
>  	struct fsl_xcvr *xcvr = container_of(work, struct fsl_xcvr, work_rst);
>  	struct device *dev = &xcvr->pdev->dev;
> -	unsigned long lock_flags;
>  	u32 ext_ctrl;
>
>  	dev_dbg(dev, "reset rx path\n");
> -	spin_lock_irqsave(&xcvr->lock, lock_flags);
> +	guard(spinlock_irqsave)(&xcvr->lock);
>  	regmap_read(xcvr->regmap, FSL_XCVR_EXT_CTRL, &ext_ctrl);
>
>  	if (!(ext_ctrl & FSL_XCVR_EXT_CTRL_DMA_RD_DIS)) {
> @@ -1469,7 +1465,6 @@ static void reset_rx_work(struct work_struct *work)
>  				   FSL_XCVR_EXT_CTRL_RX_DPTH_RESET,
>  				   0);
>  	}
> -	spin_unlock_irqrestore(&xcvr->lock, lock_flags);
>  }
>
>  static irqreturn_t irq0_isr(int irq, void *devid)
> --
> 2.43.0
>
>

