Return-Path: <linuxppc-dev+bounces-24711-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1EDC44524
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 04:34:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5JFD3SQ7z2yfS;
	Thu, 23 Jul 2026 14:34:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784781296;
	cv=pass; b=BQuLstK+VxhZllSetPL0Kk+l/YnYA4tTRmO3e966v+/9M24WD++o+pTgMlGs9X2UCLxTlvdOnJMcELIvG7rVGiFfWTa8kCZiqT4Sr0i72o/nFx/xnl7f4aseuvIGDLW+f417pCFk1oTlGTjDBJfiYfo0izxkXqAZ5K+aJCLKYni2Y2rSgrUwvzymLi79CeOo1nLaL9/deSpCcA4DNob4XVK9UyaMZ6cfsEKhWCSNNRORPn+gfVSJoawBfY80AOWVah1E/kzYccB8PgnkaeaOxoYD0YF3vrEhV4FCw3AO1Nesjm5lD+9ot7pU0AOBiuDf++q7Bc6/alUhWhC2n3TuTg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784781296; c=relaxed/relaxed;
	bh=qkd3yxuI7Ji+7sHH6dANqOiguDQqyDXpKnLaGP9dPPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k9kBFh52O9RX1L8zYH3OuWgrtgwm3Jt3duv+4KNZFLaRrqmXvaaQNliwRy7BTfYDXpJeam77mONPOjkWUoCZK8ojV+i6XDA6sy+FI+0ArhvJIFhefkz3aihT02KVXYCrDkSHd9ABp3sANMV8NfhRu/t5RQXv+Oj6BWPu8ADBWqEGVWQuY0A/ePoy/kiqlj+7+t1Fi4I83wq42JZUdMT3X696260tvqDJwBxrznSBwzIxrQ3LCGnQ+RyY87NGSczX0fh2en4L7ezn5RT/WdEL4SpNhxT1sl2vtKj/A69wIvlnXaqOmkqXSPKKP/44NQ3AWZqQDSFOTYD1uu6za20/Jg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Pnv404Up; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Pnv404Up;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5JFB3ptHz2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 14:34:53 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IlcAMTrxiI6vBbIu9HSbtlTLOaVdVUvnx/YMT6VNkp5IoQXv/SkOT9XhmW3a9a2aIQdWxaGedoGo2MDrXAgr2305Na7y8CCZ+TF3jjfWR33qAIJES4APeaZM+/gjwfcFlnzAUemqU1gD6HC6FFv51lP00vBUt7Ykvs/wDhu6/xL5auitETwGTjWSf6OotDSURwyUwO4oDmYoBXTJZ7RTR2hw1oj8A281Sx9dLk8XVAu8feLze2ZQR5aJzTMSnkI5W9r9pzjE81LL39eYrOdey1lXZxdZJIewaNYhYqJvc/YKdOXbicTTWloGBfNqFWtbl1KhJMew6FQzmFcDkpbD8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkd3yxuI7Ji+7sHH6dANqOiguDQqyDXpKnLaGP9dPPI=;
 b=Fpua/GFNf9YyghgfHfxl/oYMIZAp17RyJJdeo4MMCsHMWvLwmXW6ZerQzQQJD1IXLmwRmlS5CRW/xcdyTdB4GimmRcrXQJv19Pj/+iFCLGibhg7ac2E5JaMCNR6QzpoWIwKLeP5gO9jHLDHnTYhJASTIRtFF26N4TdIJ9O1+njqG+BQ+oSa/85fHLJwggfHWmS9AfgSZs9Lx5T93HxsntRoGfnn1yrbngm+wHpF8bZVBl692n5y8Lndifu/lfR0urTVSSpxcQS84DtUaP6fsJLH70pSOOZtQE+ERcnB2WFmZoGcmLU7nQgo+LAYt14lvs+i33CUIYolym3hY2g6UlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkd3yxuI7Ji+7sHH6dANqOiguDQqyDXpKnLaGP9dPPI=;
 b=Pnv404UpaRsKFtCMF+q7/pY3djY78TItLhZ4pHEb7jPVCAsaQ7Oo5LW5nT32M7lFH0oxBjZv0dLVXksVqdxBBEx52jb3bQ6Gd6w34VEbeY0pjLZKaL1FHRq/VBVbkj54KFlAKfwT33B5tzizVhTTmBifdwxWcKOotuJzM0a5C+7sqY4+qpOMJDTVK0lH3M50jcfpdfXGzQX1K4aKWeaf0C5IhtQBtQboUNUm956QB7m7A00bO+kbm5+/5IwlSFV2aO6KhTdQrhHnKIkrLz4HFEAiy5SrC7Ve+5pJdwPcsesN1P+rfd9K9vlG4NP1gSbzIV+ipwN9PnujUhiMuY01Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA2PR04MB10374.eurprd04.prod.outlook.com (2603:10a6:102:41e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 04:34:28 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 04:34:28 +0000
Date: Wed, 22 Jul 2026 23:34:13 -0500
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
Subject: Re: [PATCH v2 2/5] ASoC: dt-bindings: fsl,easrc: add ports binding
 for multiple conversion paths
Message-ID: <amGZxZPs1gvPcMeF@SMW015318>
References: <20260723022313.1905051-1-shengjiu.wang@oss.nxp.com>
 <20260723022313.1905051-3-shengjiu.wang@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723022313.1905051-3-shengjiu.wang@oss.nxp.com>
X-ClientProxiedBy: PH7P222CA0011.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::6) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA2PR04MB10374:EE_
X-MS-Office365-Filtering-Correlation-Id: 99dffb3e-288e-4d98-81c2-08dee873ae5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|19092799006|1800799024|366016|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	voGXeRGPRGIyprTfRaWEiWAt+lHqgfw74oH7H0hGYykoynlx2RwIKQN3dczkE390gI+SNljzqMO9NtFRFMIZEVl42RFZitEKyVTyfH7VN8GRX30/MaCh4dtJxwqdhtwhGfbJ1z7n/HXR7NicSygYw39cHoGDM2x1DA18NZn8XULTR5UWk7t0xulqh7wIBpw+EUgSk0Uo8gZG+tUHl+WWAt5ysRdrk80sXadCLsyH/3WBQp6C677jhu1XzieKmCKnvjp3XgAjQu80L/58Hilj6wiVrQGAy9lZQqDAl2G2tRlfTzjjBvzLrMC/NO6pqvV26gJ3r4eDItHBBBybUyM6/em1W/yLIShU2oWDH91NsLROSuXY65oai5F/FbPOgJT7/8duGjtp2S4ACbGkfJVK7jotRtkbqTrafstkcAp802geQBBy+HIJik9x2e/3tS245K3+j6XWp5wAqNeJ46FHlBpanyMj0wVW05RniQTo6xMpLgt4yuzltLgRLnZeH4vRh/Gb9SkPDBftjnc4q5DqwBlJgpufcfdsR1kd//jbVNq5KK5iHO4yUTiyif8sHFsFPBAU68w/Get9HOQrgtRdG6UmNthddFnxOU7eFxZQDub4/Og5Pt0H9yAix96ileB09Iiq2ggxbqAmfFOYnX6vn9SNrnELI8IRsdnxbvqKTUo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(19092799006)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iqP8A6EjygAO7nDzZ29LDYlupFaxQylBgbqU9d+KbwW8LhT2QF/NNJEJ7KEc?=
 =?us-ascii?Q?/9HIjfvcxwGxEynzvz+TlRDTIB4f0ay909OU1gC1t96y7ZfnkwbdFjIMGteQ?=
 =?us-ascii?Q?sBv6Mfl7f2Cw8+lyGygWT5IqrcZivkHMYT2b/4cf0Ua+2jfKVDu1m6p4VN1c?=
 =?us-ascii?Q?C94IsFYxtUNhmV1xLTrAO1Aygd5udEi9iCJ39iW8/sRe4nJkR7u7Eh9N9Kx+?=
 =?us-ascii?Q?gJgQaU1qP5ouNVIo08rsmvlTeu9o8NVz+gZ5CNtpAVazW7jW4tTc+F90Q2lx?=
 =?us-ascii?Q?4kIZiYiFh8Ec9VDbFaHvz5lPJT5OhdDP23AhxUvh6AcpOwzQapTmLNFPJRSa?=
 =?us-ascii?Q?uUUOxwv8RfmalXrskdgJJajszNsZdOhy8TcH9jBkFtiMZYFkKFUid11iJdRQ?=
 =?us-ascii?Q?fhaZqrzZRfJtc6PomqM+74Qki5nR5183IrvJS+dvvi+YpnCrNXvZULdc7c2D?=
 =?us-ascii?Q?fVXQnMc085ocMksQz/JwJRxrmUexRXN6UEnexLzn5NvzzoHrlWqdRTIZWHbJ?=
 =?us-ascii?Q?GthMtQxAP4FFds89UOmYoPvs+e6afsihE9T1Fu0Yh9OYjCkC5oHi3QrPo2yq?=
 =?us-ascii?Q?WSkmArirogFmK+Ul/STuX4yMYZXd5BAiOdhIUDcIhRTRHwCp8x6iTXzw3Eqo?=
 =?us-ascii?Q?O6DdONUf1rE5rL0/vA3UhMU6XBNMKqSmjTW9/DIU62IhqJZHYg5LQRz/PNzb?=
 =?us-ascii?Q?VRdFB3O4twAaq0eCwxBux8GVuZ0hLIcltwSkyI80GIHwmKtxqwq73TtOSgMH?=
 =?us-ascii?Q?1r6h+53cNnX6Esdi4lPPrFDv1XU1OdluWJjuYDp05R6+4cZAscVNlgX5QzCk?=
 =?us-ascii?Q?fw85xVkisZX9n03QdQaQPgWPoQKRAhe5LA04RqyhFFfMwb8USb1MWpL33D26?=
 =?us-ascii?Q?fn0gBSsOFBQNS3yFbhOXDlcYP2feR6GnXQ2Uwgmkftx7faWQK38TVM0bUAgP?=
 =?us-ascii?Q?/Xw0M4r8TaJxqlK2hM9vH8h4ikVJmD3ZRbshKkkWEgGduLDiwOLs8QdH55cp?=
 =?us-ascii?Q?HQtDiWNQA8peCbivp560AQEO3mcmFQ3pzWPCjLVZAt+DFwr8NSq/XhvlZ2cR?=
 =?us-ascii?Q?leTxKg0mZrvWWUYH0+X1OGV9PSZPFTzhrODbXHoCpls3cu0SYPVfdBHWHCOp?=
 =?us-ascii?Q?PuxyBPfsDwAh6HGqoTmM/9yULPwJnwLpqhaUkAmkbvTRkaVPpsYcE93H4sML?=
 =?us-ascii?Q?uwd0QvdetPnge5o/pPqjnTURB8zNTOvYNm6TXE14QFfK1KDIVN7B5ZJA5DGb?=
 =?us-ascii?Q?j5BY2ybdQ/EIV5hRaSbXBa0G/t/eHtvtxN54Kuw158GzMFbL2LwvAWdfIctB?=
 =?us-ascii?Q?RmQ5gMfwNy5/zoFcKesVFfNB3Vvugf+oz8Iw53vo5vif26sOFlOWe6Bk/ANC?=
 =?us-ascii?Q?3O6Q0CGiFRtxhTgGkvp6e4wHaoq9oKXo9OXttsPul/mRiV9n6d0bT3MTkTX/?=
 =?us-ascii?Q?p6LRNj8N6RcDxAsevrykx25N2fj2+9lQeDhS3m+qLXomZxIQR6Pe20241jQm?=
 =?us-ascii?Q?MsZRmKU6V90K9WACGasFtRzEUbUmcC1Fh2Xz/+BUza8X4yTYeUC4qIjlMID1?=
 =?us-ascii?Q?1oriwURowvaoGubwl8XOEclyDkTL/S6hNoT/cZ1JK/2z+mJbDHKFrVvxXZjV?=
 =?us-ascii?Q?ohqAw4OMYU3vlkWFJOKWy9trCUZCfBe/jE/yU5/DOohhmhKdeO+9hOs6CnOZ?=
 =?us-ascii?Q?N8vwUPJLF2yI/2tVwhs3ES7Ukf514DMiuw6qVYUDi5pmZ8axi0rBo7c/gD3b?=
 =?us-ascii?Q?YAJgdl2T0Ab8kbKRrFP/zeXC85aElIfwJXRlkuFzcTKHvgVcrL8m?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99dffb3e-288e-4d98-81c2-08dee873ae5a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 04:34:28.0732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3fLsy009BxTY8JWNgALSI8ymZnMEx1uR+flN25t/mOafloQ8r7gkn2VMBY2nMgRzd76wdw1l5hJk8mSFBEpZn6c2hduWrP+iaQuNvUzSebTzlfJrukXPMqdfpqzhWW0c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10374

On Thu, Jul 23, 2026 at 10:23:10AM +0800, shengjiu.wang@oss.nxp.com wrote:
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
>  .../devicetree/bindings/sound/fsl,easrc.yaml  | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/sound/fsl,easrc.yaml b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
> index d5727f8bfb0b..e6d7cae5983d 100644
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
> @@ -107,3 +115,63 @@ examples:
>          fsl,asrc-rate = <8000>;
>          fsl,asrc-format = <2>;
>      };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/imx8mn-clock.h>
> +
> +    easrc1: easrc@300c0000 {

Needn't label in example.

> +        compatible = "fsl,imx8mn-easrc";
> +        reg = <0x300c0000 0x10000>;
> +        interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&clk IMX8MN_CLK_ASRC_ROOT>;
> +        clock-names = "mem";
> +        dmas = <&sdma2 16 23 0> , <&sdma2 17 23 0>,
> +               <&sdma2 18 23 0> , <&sdma2 19 23 0>,
> +               <&sdma2 20 23 0> , <&sdma2 21 23 0>,
> +               <&sdma2 22 23 0> , <&sdma2 23 23 0>;
> +        dma-names = "ctx0_rx", "ctx0_tx",
> +                    "ctx1_rx", "ctx1_tx",
> +                    "ctx2_rx", "ctx2_tx",
> +                    "ctx3_rx", "ctx3_tx";
> +        firmware-name = "imx/easrc/easrc-imx8mn.bin";
> +        fsl,asrc-rate = <8000>;
> +        fsl,asrc-format = <2>;
> +
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            port@0 {
> +                reg = <0>;
> +                playback-only;
> +                easrc1_endpoint0: endpoint {

Needn't label.

Frank
> +                    remote-endpoint = <&fe00_ep>;
> +                };
> +            };
> +
> +            port@1 {
> +                reg = <1>;
> +                playback-only;
> +                easrc1_endpoint1: endpoint {
> +                    remote-endpoint = <&fe01_ep>;
> +                };
> +            };
> +
> +            port@2 {
> +                reg = <2>;
> +                capture-only;
> +                easrc1_endpoint2: endpoint {
> +                    remote-endpoint = <&fe02_ep>;
> +                };
> +            };
> +
> +            port@3 {
> +                reg = <3>;
> +                capture-only;
> +                easrc1_endpoint3: endpoint {
> +                    remote-endpoint = <&fe03_ep>;
> +                };
> +            };
> +        };
> +    };
> --
> 2.34.1
>
>

