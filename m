Return-Path: <linuxppc-dev+bounces-20073-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66ED1FE5204
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 10:37:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g28X12WyFz30FR;
	Fri, 24 Apr 2026 20:36:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777026993;
	cv=pass; b=f/zSva18xFLiWizKs0/VN/iu3qvLHEmVuqzFXfzuZMRCFk1oRIjHBPGRqkZ4K9X3ROQozEbPyTzBjAGonvzXJeV0NvZ5Qy8x/3bqyBOssDGMwXjj5iG35xgmsHbjcP9W9FlRdE2SRWf50B35HoE+Oer5+gaPV4vJhARgXH+1GUbnvorMHty0KrpfEIIxj3MLvHFfUU2aTsOJ2Vk1hNkmkBudCGpsBdTaTPz7s39LIePidbS8Wy4crHJamNfrVO5MckHVZn09yuAls6XZ8bz4lkjUrMtDitMojQrvlYWXc3kEA2EDGyt59eP87fv2CuuOWGXdPBkmLEwcw3tLvgpkMw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777026993; c=relaxed/relaxed;
	bh=IdoF38dUGMunIi4jHqEmT+QtXYophBpYj5dzRpECB1k=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VwKIBZ0LkEnhc04xDQoyTnPZ6xm59PKVZGNTclyOnAJ9B93fbB24n5YfUeqxMyrnWtMoajj4zcZp9BH6WVDLbeAxNTaImHrtW8e5HkpX4HcPEcSueU90yX2gYlNB0PlVN65m/em2+N62eOvul1UFjFCpAx4EdGl1EtR+SqWSouIoP0rMrnoF673LJYecpDS3t798JFlHsLBCIs8/QoOl4it3NJXF6aOCKUNDBJ9WDg1FGU3cuTyW0/UUpZE784KfVW2G/JnrcIwhWIQRkL/Iy1iK8h7rPPD2MZEEFdgiAgv5vy8zDsGuAPuzVhr1Z3rtUvqsnxa5fa5K8v8hcuvr1w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=cnapfHWk; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=cnapfHWk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g28X051s2z30BR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 20:36:32 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3u5ggA5g8k5wAVhkAz0pjvCBjuqlXyu1xM0nHqAOEYqLDhZJwCqO4vD1q4Avx/8kTd7cOLvwXRQR6Rpu4uR6XlIy5ElJgTN1TKb2EreUZmnNRHnfFlNapknM0avxPdBViyzaXBhD5CGMWKDfpzDoU+ZbjrL+KCed4vurUP+xWT8IaO43vTd6OaNeRRF4peQODVgJ6pIr+nS5WKhkyoo5V/uKIC5YImZ9rh+xZNpAYDFG5MV6iD63wmT54ItLCeTp2cJfCkpGGhgogPJY1dg5R/bNdp8k0Ku4VaEe6Fv42vq5WZp8BejKRA99yP6JH+ugJUjSCpvqthWWnhJyqHh4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdoF38dUGMunIi4jHqEmT+QtXYophBpYj5dzRpECB1k=;
 b=C1RfAfA0tCuLBcDHeYN7eLPptZIi2CmgCUJYP+8E4l/C78Jci10YoeReQ0XEnNyXCL62sOcNGsnJOfs31nOv0DMaZH/71RC42Tx21MNX5GRykTG2LrKol0qw6sranSzoCfnpe9wLiq7nTEcTnrFntXFvq0qpD7OyLscvBwFF6Mfmae/ujpSCXiRN1KAgpoTCB6PcyPK0r9YHHCEcZRS6gwuaC7ZwO2iHTrqZaRXaA6mOP6a55kgmqgR6BDZz38aUUqPR8o1C9XpvRcls1e0Q/TPQCVAJAMVcLAqOJkZwyrHeJWeub1QwJjAIkhqPy8tHrunvhaGYATZdbn9k7gSsFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdoF38dUGMunIi4jHqEmT+QtXYophBpYj5dzRpECB1k=;
 b=cnapfHWkp3ZdbZhzyFIfAEdMPbWNJx++95GCUCWiJs7CFQ7Qkg6ou4vdU+SyS4vlJnLTtnpLB+gzUl+Ky5/ByFOaaIGH40dnAFVIOm01N9DTQxkjDPqE3uCWIh/VYogdNs5JHU/mycxWcY02qgkFszlNWi2cngXEQg3QBZndR/GEJBez2EHew5Q8AX8Xhf/96cknFqaUaP9JT3hXpnuAx7zaiJ983EW6uD35r5TsV9smjftrfn5wZJ6z9iT4bDAz+1OoP+B2gViIhq9Ej8aOUU3ks+NtuD+AAdleInHmMK3f0Gfpg6exIM3Q78snxZ3uTpgi70BVZo2Gpwra6s4I5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by PAXPR04MB9075.eurprd04.prod.outlook.com (2603:10a6:102:229::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Fri, 24 Apr
 2026 10:36:14 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b%4]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 10:36:14 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] ASoC: fsl-asoc-card: exclude S20_3LE format due to clock limitations
Date: Fri, 24 Apr 2026 18:38:05 +0800
Message-Id: <20260424103806.2276780-5-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260424103806.2276780-1-shengjiu.wang@nxp.com>
References: <20260424103806.2276780-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::15) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|PAXPR04MB9075:EE_
X-MS-Office365-Filtering-Correlation-Id: 255baff3-c604-45ab-03cb-08dea1ed4f83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|52116014|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xx0VuromrOkDSgvJvZpvJQUJPk5rwVFoxiIRS8PDhEDZbLWG4PXsOlR7uuyokEsq+N1SSmA/a+h5xWZaY2munZ2RNYdRbsqpdP1z5aZ8WIFwzKbxFiRrBVfK7UnRGwNEDHn+6iWlQ3ZJg4prbKx7TKoX3Qyivxp6XVtpGipiMzJkfpxbeYSyhhROzU3bcmo+pMtWkQuuLBdgL7Q+rkJ3Kvl6LNyxige/fBb8dBKF0t0mEYF7zw2z5naLGmqe1D5/p6rydflV44O5iLc4TqniSDC55exGLp0SDyol0OjG6coRjGSgJR6DyP4VSlDzeiqTJm0x6bYwbJOIz/4u2F0psl8WNm+XivC91QK2I68BCcQ8pem3oBDRs4jzszs+DSh34jftvO2zVMQNeEd1iVFHbkTRTOJ9CA/VCV+JnuSjpgDlXw8J/QTYAMmUWtpgXBWzmYOPAPCdCHmYds7ClwY5EAmqS1CClFD0XSAi1Uy/kHO60XXh5sX3xpxKphdgUKWYblQWG5hlcIiJZbvgdbEg/4+m/H1jrNCVZn1Fsaw2AFPUJ+IsBFU1M2/uqGyBYCoWIYhm/CiIc+jY3pYLUH+ZabhqY02fmc50DG5WokIJNMvq1oH7d+g2oQqUCWnsHvvKpkYBR7U9Sq5KbY/fk1K1/3sj0k8xAHamR9HPMXUsXF6Krg629Hj89Bapg/fIOtWxxljdlJ5JdUf7APfrFmR7sKYYUHqzvk9Ryg3ncXuoobywe9WsuS+af6sbg3UnzAhl4tfL997yRjR0XAblCB8VzbrSQe2g+95T9PeSwutyVor1kUxRLHIxxvWhU6bSxL/O
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uUSarRlga2xCzyT7+H82Baa2QR6J7YcyMs57LWfNiwVAI+vOxZYacJSavZAG?=
 =?us-ascii?Q?jPQRBcAuWASW/EH4IgRRofX8r35DwUc7GOh/XhgubxLsd9f4+ZeIB1yDvVKw?=
 =?us-ascii?Q?Xa6PnUqq2QrbqJqREJhVrmo6h3eaCCzPlxZN+LtcmG4IXKacehxsQegGMVDc?=
 =?us-ascii?Q?/xZiRBdutA07U8v2UYxOqJnwwHlVRuBSGc94+PoeyOSJZNKpvY64wrZNghN4?=
 =?us-ascii?Q?TCRxKdRavfDQkivlUSRViw8b4DzSrM3rp93YODkG8oB/QxbFrx9dqHYmWdJY?=
 =?us-ascii?Q?9CR+FtsyvjaSQD1DP1+8N+6kFQ2zQuyx1jBRD8Ks7t/DIfdIeo9gp3hwjkz9?=
 =?us-ascii?Q?jHq4U1ltK3s7gUFDWSphlpyNr+FojzuEURa8noJGjScNxkI0lcoymuggaJAS?=
 =?us-ascii?Q?eGQtzuYzC/Rv+jkPFFhrd8XgC0nuJuWP1Z9vhR/Me5WhdyRbNgJWZx8tJpAr?=
 =?us-ascii?Q?CAzK8Lb/TY8s/zgL2t632zw8Ej1Y2u7W9uNWMjoVBAYr9F/XOi+0VR/maNmS?=
 =?us-ascii?Q?j3ixpnpgQtA+G62QnPNaI0sf7LcJkgIA3ALQ0NP7fjO3QpSIqshH0tFCR2Nf?=
 =?us-ascii?Q?k9cYAofK3fNW6FJFItJF9KoM0x4HQVpewzpVCzVM6Y5WmjhudC4nipbo1ADy?=
 =?us-ascii?Q?cLQs0OgJE08zAfMA2JaPMu3o9YJcOo63DBdqiiJUxycUs9wLu9rS7kg0pfIs?=
 =?us-ascii?Q?JmZPX/j7GVjid7h7WrcuW63lOCTMldj6ggH8rPYL4CavAAZ3QC2LXeRzkZNQ?=
 =?us-ascii?Q?7bwrzOzMHOF84QK3eJwF3/P1V5GKBM17y3X92xCcaqvquqxWuEbq7k7t15NJ?=
 =?us-ascii?Q?2ID6cF6fS72HMam2qUCZZ2zigrXuzjb+u9ysuM/37dxAXXAjcn/jYPTHOdLC?=
 =?us-ascii?Q?L5YMuBfUS/s3sDpYmakk9w2nsad5NhifyBWZ8bRx08BIGtbSTXKHK71CdwvN?=
 =?us-ascii?Q?YxAd9HK+C+bA4MRH+PAMn4pKQVBzAfl9jGkgHyy2qscWTXFmzGAl0m9EjGhF?=
 =?us-ascii?Q?hiYcrQIDvPejW8tN9sceA/ezxwZCq4Sx28k95hLIG9tL5Ls8/ciRnhGbA8Sz?=
 =?us-ascii?Q?hPOx9Uvl9L6CvExpf1R3mRaVikRGln7UUeJvXEvtmQ8iB3rK9lnkryL2kWSm?=
 =?us-ascii?Q?ZbKsxkkGMBeQzav6/LKR41xcyCT1346cciwXijcAvBcwa8AL4l1NSqM0o6Fe?=
 =?us-ascii?Q?aOFgfM9OMAFXVJ+2FbclcT/5iUP4b+2QIBi3oXQUXpEXMH9JuA/adnYVdBeJ?=
 =?us-ascii?Q?/q4NojJniqvOVwDh+Mq/v/CGzzQaibN7+PUvfbTxqjs7u4zmGPP/U5w0ohfq?=
 =?us-ascii?Q?tBKVCcPb9thscvVcafB/yqtveUNOZcoLkDcQYbDHbiK6fZkispQgtKwp0YFm?=
 =?us-ascii?Q?zOvlzAXaoTvoM/InsgrV4VI2GTJoH85mjNWSg5lRV/T1tQLAoKOeRrRdrbud?=
 =?us-ascii?Q?tCdOi7TvJ9FeHmm4SG0bNUkbgijp2su7TYXIhuzPsktRK5VwQ1LAaGn2Bas/?=
 =?us-ascii?Q?AM/BUxcxZ6X39jo1rnqC9VJOKMO8lR9nsV3kiyQ1VRLqwT0pkg+TGvw9Zb7w?=
 =?us-ascii?Q?SZF47HpYUlEjobOnkU7Muu0RmtzajTtZWB79BcfV2YowkryTmaXxl7JPexdc?=
 =?us-ascii?Q?Y5WAjZzhvCZHX39LqIROQrKHxeLx7jAH5+/tjaoljQfcijJRdyd8r3HMycf6?=
 =?us-ascii?Q?eE1gywB9jPXzOmZzVDL77FI8+2En9DeUg7jaJa79tNNJ3l9tX+IJQRn7gwDd?=
 =?us-ascii?Q?V+NYKGZztw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 255baff3-c604-45ab-03cb-08dea1ed4f83
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 10:36:14.8717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tV1GRzqrfYV7354KOMxj1tgKH6Fxf5Dq8wiRBh66JvJMaBlIq/Jnv0aNqAHIPwlzho3/bFqoyxOgc9BYi9bLRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9075

The S20_3LE format (20-bit samples in 3 bytes) requires bit clock
frequencies that cannot be generated by i.MX SAI/ESAI hardware.

SAI/ESAI derive BCLK from MCLK using integer dividers only. S20_3LE
requires non-integer divider ratios with standard MCLK frequencies.
For example, 48kHz stereo needs 1.920 MHz BCLK, which requires a
divider of 6.4 from 12.288 MHz MCLK (not an integer).

Add a format constraint to exclude S20_3LE, preventing clock
configuration failures. Users should use S16_LE, S24_LE, or S32_LE
instead.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 50d7a5f2d79e..36c789f15582 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -320,6 +320,16 @@ static int fsl_asoc_card_startup(struct snd_pcm_substream *substream)
 	static struct snd_pcm_hw_constraint_list constraint_channels;
 	int ret;
 
+	/*
+	 * Remove S20_3LE as the clock (sysclk, bclk) can't be acquired
+	 * due to non-integer divider ratios.
+	 */
+	ret = snd_pcm_hw_constraint_mask64(runtime,
+					   SNDRV_PCM_HW_PARAM_FORMAT,
+					   ~SNDRV_PCM_FMTBIT_S20_3LE);
+	if (ret)
+		return ret;
+
 	constraint_channels.list = priv->support_channels;
 	constraint_channels.count = priv->num_channels;
 	constraint_rates.list = priv->support_rates;
-- 
2.34.1


