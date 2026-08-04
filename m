Return-Path: <linuxppc-dev+bounces-25381-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87FDBC5518F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 14:41:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDx7B6ZTTz2yH5;
	Wed, 05 Aug 2026 00:41:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785854470;
	cv=pass; b=LPspz1ipq4x3+hC5YDVYj2Irr1UD5GkQvi/Wfs3dlONfjVRFMlbN/Y1WpEXCX4yXjkI7mTyiEBslGBPAIl54eoVl+YPyR8XcbReGAuMcdJR5DsI8Cx2psuyjThYVhUYwUldGusDjmVOg2QrspxSkImEewbF96VddoKTlduHLWQimhvBcZB4u55AjQwU7p00ypZpG/2uHv9tYvRRUTYWTweMx4OFAzwvDL7et/TMrLQFkhCiqv4xMzLH5I/AbDi6qt72FZ/E5TRJyDdn6spkI5ION8IPQUf7pzzxR/CaPzEYg51bzoyhoz6RFJo2C6wWFxEJhz5pe5NIGxzVqhoLP2Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785854470; c=relaxed/relaxed;
	bh=pjezfk97upb+vMXO5jG3JgUwHEgob8xp+hsatpAVAWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MVpRUUEQAJHZ61prNoJZaA4Z8fgRSsuOXcJKAWaZ+k6rRY5LIVE6bsF5QSnWdQhVCdDM3T3FjYLa7om2FiRDPgADNFyeS6cWeXi3oj0S6wfjSteDAJPCiRKXa12arU2/Wf6oXkS6py5zH60iaLXkSgDVVPCDhdgjHUcKn1hSfVw9S5kh+/smpFsHJmxhA1fRevMFSab7VJR9+Sg/n57G1L0AIdrypzJja5lbHGqaDJOSRFtvm04xLbBrJXMNZpQab55FCluqTQ1yWV1LV+IRw4eaDDEeA4VA/06vrQvjlTLPsGfT9+idRAwWmJhr4Bjsmxa+iYggh967lk7eLlMgrA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=CHoA6MXJ; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=CHoA6MXJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDx7B1SfTz2xyk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 00:41:10 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWapcZhhzB8q4UfarUnJx5E5br78crv46dcQF+f3LoLiCijkGLMkVU/bonpe26VYW9viC2KR1+dMPqCpXcm/yhTTkFn8tqIsEzj5bmlgvhnhDXTNkFFDeG2j090MNsDQYDD4S7xngAgQcHHbazf1h78Y02YaI0PaXzPX9ZEFplQYM0dzgs0WmAOKSwg9EXvbsVYn1ENu3BvEPHCqC6pe6CIqB5bsBG0RcMz3N6y3Vfeibep74ciI4jzIJkbUxENHDHqJ7LDHJmZ5vROz/4P/bUjVaw55xI+dRoh6rN3nwZ/oHanWmF+FJHYCVSUgU3OleeaqC5Q9W2YnNLckVFkvdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjezfk97upb+vMXO5jG3JgUwHEgob8xp+hsatpAVAWM=;
 b=K3rEqDFz2deYippxoLyWqf1CjP0RZABbmfzzw5STfVMSmrz3X28eDJj7TvJqXED1/tbPwGxyjpJTss2lQDrmZvsKLZmqkwFsqgTJNtEAEWIoJNG4nDowCCwGXBEfA1zFJ0SOhup72OzgB+rA8gCpzzEPWtLn96XN3hOyszSM1nKOi8VDIOApD8P3lKGvQyeSwKVfXPo+ivttwSxFs/sIUjc7juDSQb6RlFEcRvOfmB/sKGJFilhTKK14SKheWH72K0GotnHmSOvmCOAa3YCYLuxYgYeEeqf/omZ0koZqbFHuOMB5qTBI+lOATaSM/WEwcOo8yI6FgrND331IzP02ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjezfk97upb+vMXO5jG3JgUwHEgob8xp+hsatpAVAWM=;
 b=CHoA6MXJdfssgyQyM0rUuWw7Kfk4rL7T+ExP0wPrctVuYe/wPjxPVSKPJrNFeZ+4+T7Bxamk58vSruX3ZwUGGg1HSEGDCCNFhVo10v6sS6S2ce4vncANxrfDpGfkjvl/ZnzrDJruFoB2v1wOgPWmp76Uln1Sw3LScYYbnkeNoquZ149udyl0Eu/Lf1ziVF0TfpCR958w/0wE8rCsRxzyTkr19yVJpHXdjGdke2x2WSvNgNGMIsLi1fxGApYXW31GfyW8S78eROfCgMrx9HIUWZPJt80SGqBGDRUDGjqZCb0yk0Ahz3KpGSh/Gx9MGVACcZkGSdLsFEbg42vRhZ7m8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV1PR04MB10920.eurprd04.prod.outlook.com (2603:10a6:150:208::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 14:40:43 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 14:40:43 +0000
Date: Tue, 4 Aug 2026 09:40:33 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: shengjiu.wang@oss.nxp.com
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, Frank.Li@nxp.com,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	shawnguo@kernel.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com,
	nicoleotsuka@gmail.com, perex@perex.cz, tiwai@suse.com,
	linuxppc-dev@lists.ozlabs.org,
	Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v3 2/5] ASoC: dt-bindings: fsl,easrc: add ports binding
 for multiple conversion paths
Message-ID: <anH54bIKJe3TIR-n@SMW015318>
References: <20260804100218.49587-1-shengjiu.wang@oss.nxp.com>
 <20260804100218.49587-3-shengjiu.wang@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804100218.49587-3-shengjiu.wang@oss.nxp.com>
X-ClientProxiedBy: SN7P222CA0010.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::33) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV1PR04MB10920:EE_
X-MS-Office365-Filtering-Correlation-Id: 01f7a7d0-0a45-4448-44f6-08def2365cdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|19092799006|23010399003|18002099003|22082099003|3023799007|10067099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	WpXuKCSiZpOGogCk0fY8pWfDZr6j6R8B9Fymj+ZawzSMtMkapWMfeT4Vr9AU2940lIHERhjK20EsSkN8HkilhxfUeFLzdxGiEQD2kosEAGRiApFu6tMy2py1n2zwSvgukRac5OKCiMLalzYW8WZcfsiA0E3uVfhRvmHC0t76JItoPNAhuAJjaUlEX+u09cHm1xUVa64GLB08r2DNQsydFWvz7GYAn0q35z+ktb/oLEFS5vDo6Nqg48lCt1co4qWkHOnbtjbutaeeBPxOt/X1ZrupBcHI+ZVBYpmvSUUuMCBHWaOqez/ftZT1JhwOWFJDDIxPGiCWslXsR53Za6H4dhhqEAU2CcTWdu1/Vkhaw2cenwFwiCUqAOCVFMVDtulacoW+NoO6W0T0SUuZmxyckxxAqQ8oiUnHr01sp2A4vaeucxgz5BfKyG3kLVBjDAEFP0lDcueOYRlFBwDBQLM4oObjGll4XUpIeC9TZIlXFOFM+cE0OYgQ+B9dnO4A+98fG6QT9HSdxbcPmXs02Auj72/NIzXqFREgqs4vUpJIvk2RzqgDjFQarVY+GnjsIZrm2tZgCUzSvmFk3h+wxsPbaI+yG89CgCXFkuaOvh2ywpbYYj30/KSEKyyytckqCovRC7dppg4+z2SUk64yuA2zPSMl8IdfY9bNa8+APZZv5G8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(19092799006)(23010399003)(18002099003)(22082099003)(3023799007)(10067099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SmpuC8MlRtA2cAHcdMH0c1+iDAdbzvB+BNpqkIK+TVYiCPC0kRtK+HBvVGZv?=
 =?us-ascii?Q?CsyxVdhS1kmjPQQLopEr7FlSio3JUNdKTdm4bOYnmQ3BOTJicMpu6qVdryhr?=
 =?us-ascii?Q?expO5jPyyVezZgQ4QcD2H8WKEd58a1iwUdViw6s3oWSU8kbna6EIi7c8UHSC?=
 =?us-ascii?Q?NxodhRW65pS7S4P4vQ4fUk3XWKGZOXUSuhz05RgBASPkwDhaxAfwvFHflFOI?=
 =?us-ascii?Q?Fyyha2upf2TPaQUraXHIdl25sxSbMAFGjJwnXPnejGDUF25+Vus5t+HJDLEy?=
 =?us-ascii?Q?/xZBU259AeUbzey5G6FES6UigeUQPWiRwGiQvjpJW+fzT6AneR3GGKB1ezOA?=
 =?us-ascii?Q?dGbZJiITSb7KEFrh0kEYaNE9d3JHzDfNftSKDxTvMLfm5npGldeR560Ly8nS?=
 =?us-ascii?Q?Sk7uWrnbRe5BukOwxLnF/c7aGzLkQHHkfop1MuZ6031gSicLZTaVE2SXaW1K?=
 =?us-ascii?Q?1XwRJ5wh4KRKxKh73ksYfSwZTkFiY6Tb+JuG6OxAy0yjUD6M7CL6RoqR32fn?=
 =?us-ascii?Q?fTWbYHHHD/hIvq5DVczvQ2BRqrChmANaX0ZMWuBogByOT2XDQHm/e63e4+9E?=
 =?us-ascii?Q?CBcjh12oisAFZ62Pa2cQJDcz4dv3ZGEJGGaMmIF4xGoL4CWoqSL5x2J+GAJd?=
 =?us-ascii?Q?bzuaUFLTSwUjBFgvSoTTBLGJeydAIdMdn4F5KLh3EBWplixeXYgPiS3aayWZ?=
 =?us-ascii?Q?RasAJDJi9DdycFv0U3qod2Z8MR9/8dB8gZscTDGrnU8XugoFvJPiJ32Jv3Id?=
 =?us-ascii?Q?IcfrItUTjzh9Uf1tMPwYQMW01OrGpWVo+ShWNQpZhxMTSG9CYF9k5Spg2X6/?=
 =?us-ascii?Q?nZLJ2vPhB7BwaKghyENpZRgEP5giWuz8J/Kxi064Sf6wACc7lq5ciAAr4ELx?=
 =?us-ascii?Q?Be4ICcyIodYS25uKJq1h4Osw1LTXJK6um9CCPPgLbv5FKm6kkBChUaF6yJqC?=
 =?us-ascii?Q?5b4g1WaIDNzgK1t2GzleqirTcs/NYBnVtYiBH5pqCqS79Gsl9jPckCG0Nroj?=
 =?us-ascii?Q?rGk0a8lfiFCxqGJBAVTbCGi7LbkDT8aNX0D6rCGq2sA/fmpEF/etnxgqJ6PS?=
 =?us-ascii?Q?qEWYFd4MyaKytVYe3bmuPHNhWJ5i+SxXaDNzZyB1ED4DEhDM5FFOxPsCmBV3?=
 =?us-ascii?Q?NM2VOpYgI+j+fEKsBpITmLEMDoXpp0Oi7pSMqtomUcfAi0a9UwGYZP39aLc5?=
 =?us-ascii?Q?79ayD88aDolc8uuBNftQQjaqvhM8KdaF1RJmktxF1Rf0iIbhG/DL4RwzPlas?=
 =?us-ascii?Q?5GbkfBSFuIAbxkrrnsVYc2qBpASe/LN1/ntLgcf1tQO84x6ozcV8VohJU3nb?=
 =?us-ascii?Q?krS0aVVsia874qvS5O9WzlAU3EsDtUwq/rEEOdhgkhZAurbXDmG9r6mNkxhu?=
 =?us-ascii?Q?JKccdDWcvlrH7R5/ueWqiOII2RGVBuUpeP1naAeG5Uj/Qu/2ghDSE4cTXVkG?=
 =?us-ascii?Q?ha40I1x6FMxawgLfoukmB6WaJ+Xtewk649tNv8Jako8ZeDb0+5Mh7FouFm1K?=
 =?us-ascii?Q?bqeQVhDFZxK/ZYtn5Y/9wECe1Tf1hAq5Jm82O625qSLxeM7K8eqwz/ziAYBv?=
 =?us-ascii?Q?bOq1UBDjqf9AKA2ZjYd2ikEjSJSI+Apg1pIaqgrgTQEwFWEKB6GTkPtQ544w?=
 =?us-ascii?Q?A7x6yybnM7A2UwvHmn0ORCNUrQ3JjNGcI+c9D9s4uBJ3BMSDqEIWlH+dXT54?=
 =?us-ascii?Q?VT4ZGgPzsFSy+u6R9Y1ugOgoFHFayTTgXByJ8aPHxTrxNhqZFoF/GGFPUd5L?=
 =?us-ascii?Q?mEbtMrmPDyaeejakY6RQCFOO09clnS1U7HPYFdklE2NzvfItWSJQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f7a7d0-0a45-4448-44f6-08def2365cdd
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 14:40:43.6243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q1xtWq7nE8uHhPmTlodVvqiEehzxIgFz/nGoAol0GVfWT8Namznwge1zjAxIThdoI82+ZtN4ymjxzre6n/5ZT5jkMDMLSYY/94H53w9+XUzPOlGbXItGfc8LoR6Q9O5Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10920

On Tue, Aug 04, 2026 at 06:02:15PM +0800, shengjiu.wang@oss.nxp.com wrote:
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
>
> The i.MX EASRC hardware supports up to four conversion contexts
> (A, B, C, D). Add a ports container property to the binding to allow
> each independent conversion path to be represented as an individual
> audio-graph port:
>
>   port@0 -- conversion path 0
>   port@1 -- conversion path 1
>   port@2 -- conversion path 2
>   port@3 -- conversion path 3
>
> Each sub-port references audio-graph-port.yaml and follows the standard
> audio-graph binding conventions. Contexts are allocated dynamically at
> stream open time; each active stream direction (playback or capture) on
> a port consumes one hardware context.
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  .../devicetree/bindings/sound/fsl,easrc.yaml  | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/sound/fsl,easrc.yaml b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
> index d5727f8bfb0b..a53ec4f6f1c0 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
> +++ b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
> @@ -55,6 +55,14 @@ properties:
>        - const: imx/easrc/easrc-imx8mn.bin
>      description: The coefficient table for the filters
>
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    patternProperties:
> +      "^port@[0-3]$":
> +        $ref: audio-graph-port.yaml#
> +        unevaluatedProperties: false
> +        description: port for an independent conversion path
> +
>    fsl,asrc-rate:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      minimum: 8000
> @@ -106,4 +114,41 @@ examples:
>          firmware-name = "imx/easrc/easrc-imx8mn.bin";
>          fsl,asrc-rate = <8000>;
>          fsl,asrc-format = <2>;
> +
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            port@0 {
> +                reg = <0>;
> +                playback-only;
> +                endpoint {
> +                    remote-endpoint = <&fe00_ep>;
> +                };
> +            };
> +
> +            port@1 {
> +                reg = <1>;
> +                playback-only;
> +                endpoint {
> +                    remote-endpoint = <&fe01_ep>;
> +                };
> +            };
> +
> +            port@2 {
> +                reg = <2>;
> +                capture-only;
> +                endpoint {
> +                    remote-endpoint = <&fe02_ep>;
> +                };
> +            };
> +
> +            port@3 {
> +                reg = <3>;
> +                capture-only;
> +                endpoint {
> +                    remote-endpoint = <&fe03_ep>;
> +                };
> +            };
> +        };
>      };
> --
> 2.34.1
>
>

