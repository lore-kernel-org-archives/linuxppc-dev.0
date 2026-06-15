Return-Path: <linuxppc-dev+bounces-22644-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB41CD98CF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 14:24:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfC7Y11f6z3btj;
	Tue, 16 Jun 2026 00:24:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781533497;
	cv=pass; b=LKBb3sNYEHgxKV1SOsEprrx9fcVPkwzE5NrV/kxEXBwDEW2+00PLN6IF9bxddMAjgfapctuGGGBLcBhrM7JENm5KYiXo2wWOuuEVQLVDlUV2ZuBNx6pShbgZ5aRBQHfe2SdkiwD706ouDyQR6DRarfMewRVNmAjp/bqUhZjfBkniRad/vk5zfo386l7ozao8UJHaJ1qm46MOv01xg8U7f+RScb5zMM1jrYPSM4d9kMI/WsUVO2KLvfr78DgV2uMcYVBI3FZ6+0XZwoMe4fqAlMefZYFcjeaJpHKGWb2RhDk6CTMKfazvVRuuyeBOp1YdR5qqRfCMKH4SRJ0yda4TnA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781533497; c=relaxed/relaxed;
	bh=PdrNkAIhQTdg9vfFbmtDhtImM8fep7pYNVaEZWGXk7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B9fwkDDBRy5p+JReNcWoEPSNAEMTTet25BkAoY3//zQ/uU24xmi3cFW0KOmMItK5WSpBWgOwV4NcCgZ0DyRvU486oiVLvmHLv6O8O+aIftyWYTmvXd3zSyCmzY3lo/DG2b5R5FMqK+bCipYk5f3vy4PxpzXO+V3JKtdJTz6KitbRdLM9xlgLy5gmu91SqEZllHRT3pVbcNJzHwbcu4qB7ri3mhNCnWaDkRRSjtn5US9FAcyTlGtgAXMbb+X/YJENefz9ovqgJtdpJ2yWM7A1W8PcjezRZL44Lmog0wq4edpvn8Q8BvGKns18Qo+mMujZuzyfd0Iiz4umU96jdTFgGw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ImwMwWaI; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ImwMwWaI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfC7X0c3yz2yT0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 00:24:55 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RbS76hbstENv+yhYArJmTuMxnsBpPsf3xxudGK8X6XGmZLeIxfztx0wty5UeoQekKByOugsHKa4bT7e3pKcjHpE/HPsraK7KCbTst3E/+Tp8+sc1UmDXm5nx2zjsteEyd6PNXb5T/grxKQzdgogdJL1N8SbnCNQylgWX3Xzgpkxy51wajjbGBhHZMCw5Js/ZmsN+qAlAYcLcvoeUY6b939Bl/dPIA/kdw8H0Pek7zsHiBS90yU0Gpem2ciy75LwqQlOfmZ4uudRxJpD116ELv7XnAYauaTErMGbCSXBKb/scVwHF+vCBTugMEW9aSpJhPzOBxfOsAS1VMmO5HIv6iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdrNkAIhQTdg9vfFbmtDhtImM8fep7pYNVaEZWGXk7M=;
 b=dKG3XuSPngR+BNb1SL5J+8bjwTTa+umkNJ/19msn13SbezuE+wxCc+OQwA300LsoOaCW0Mnf9r5IBcRxsuYikHOCxeBeiopbXOaamXICYmFTZsgko2kPaQ659gZWnQpAxkfNjfRWgPlhVCUXyvwhAMmkPJd2d3ylBeyR4TW60UiSvAy6PMhbueLHQyQ+oHu9HJdzUmmuD6oFSE0QXBSxY99Gl0NDU6UVoEP15/yZ33WTK37Q5TAIYkrPBTl7rqdVyreUB+zqlKI0iCaEtdJ2fyx3qWNfo6kYd8pXRzPzpMez+gbUtZB0lca8IVx4s1JNzh60asS/SC2n7ybFWQ9pTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdrNkAIhQTdg9vfFbmtDhtImM8fep7pYNVaEZWGXk7M=;
 b=ImwMwWaIDOoEyjktjCCrC/M3Y3o7NecW7jqnsLaDFmmEe2PF0s9BwfMwUp0PPwl0/VsH59WLTptF6/t5Je3xrkCoAJz3D4y/p1XV0jm54f3L+IS/EBOSV+ygu8pM0mgdNMg9PGfS9jUOJLLCuW997EoKYRD7W5Vc5wSZWYg/I5v5r7nGs2e7lFoTT+bVPN5Eqsz4jHD4ng4uyahLRLhPabbdGhXaDjphIsBvHQILRxyIqDdEUd14/tF4nKERYVnH0UY2N6CUP8yEiyUKyLC9kxZouQNToI1+SomVx8ds4+1uzIgpyFkeuQSVuBDanxDgZmk2LgDInjEcM8nxArC/gA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB10757.eurprd04.prod.outlook.com (2603:10a6:800:26a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 14:24:32 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 14:24:32 +0000
Date: Mon, 15 Jun 2026 09:24:21 -0500
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
Subject: Re: [PATCH v2 03/11] ASoC: fsl_easrc: Use guard() for spin locks
Message-ID: <ajALFe9oi-10soFP@SMW015318>
References: <20260615093824.115751-1-phucduc.bui@gmail.com>
 <20260615093824.115751-4-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615093824.115751-4-phucduc.bui@gmail.com>
X-ClientProxiedBy: SA1PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::29) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB10757:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f1d7798-a08e-4847-bf2f-08decae9d169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|376014|23010399003|1800799024|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yjDxzPvPz+WGVzUT4okyW0T6pOtLHVdqcEKMwuCKgVQXl/84GRmjcBOI8C3nKjqjQCefMowRKEVkuGjBOC45Pm0yu5MsmDa6hKzFItHGDbcqHa6HK4k9zCOmXBhYAGsdLsEmHb6ZoA698TB6cHQG/ueTMLzgrf35U8NVTDbLrQi/TZY7jE6py85nn2JWBg4kIOi6M1UBNAiQz+DRh8fZcqymcg7H7pYxwI362Ki+HgBZwNJ/d8faCWB4OXnsEfttJNT0IEy1pKzqi1UbpzBpLYf4HOrMFcYIP2Y/tG2TqYQTTujiJn7UdohjApjUc3cbDFMRe1qAigJigoJo/5fTVzPPwaPA6V2S67un1yUSRw4Q/bI9rUgsVLqsy69KYhF5Re3lHmr8gJ1CvGlveZYMbDwg9RJwwKGCRI9F9xNTdtjkThpYajGe9Zlr1nYj0Z/SJVE6tluGlmbX92UCk6rkKPgmGpp+GzYS5fKoKIx53pjJ8P4TLOy81KdzpCRWyZyU7woaQzCEVmD2Bo8NmFKyDRzDSPer0lNzyCYmr/bBwwc3deh1I7sgKzk2OKL1EVjAka5N4gS8ScvC0LR1XaStyTbLgfg00ZVOhJTA48x0DuVZUaniphVkvzJ74hdFY+alt/tWiuIUDNMV+/5OXvppHfK0MksCZjVKcHT0lv7EkzuZ4DWgNtbTeb7j6j8VBj1Q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(23010399003)(1800799024)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6LuMqlzsHZDCSqO9Rn8q0bKrfqRp5VvuDZ0BjuowPtB7EX77aDrXqb1DYGSl?=
 =?us-ascii?Q?cXzKKM04Jx3+QjF2gTvQm4IBDvNItVNl0n2+YzvZ8BgWvzfCmKdtuJxZC1Qk?=
 =?us-ascii?Q?D3C0+F5/dLNFHshuz3L1dUFcrnxKu5QfsJnEbVoVgi79x02DAiAb//zC8joM?=
 =?us-ascii?Q?qWfvVMsb/zFycfB84dJNpGgX7AtYTR9i0/9mmWoj0SbJZFAmRCudseDEhpiA?=
 =?us-ascii?Q?cZonQYAIte4gI1GFg9v9o2kv+xvXi3gIsrOmVzmZyh7rSVnWSyNzURuzH/Ht?=
 =?us-ascii?Q?QMGzPJnivN+jdlloSIc5VIT+l9aMJ65V4UVrGUGZkqbyV40UC8D1RO10d1Jx?=
 =?us-ascii?Q?t5h7nXYbGuA+F4cO+cRgmEQlKHph6KRuLvJLBWe8jz4Zeq/3ZV1Z2GR3LcAt?=
 =?us-ascii?Q?3dUTahdF8zIZGznYqRvfKH03ZNI8jV8ibphkv1XMR46HnsSbTb9LGFRRT6Zo?=
 =?us-ascii?Q?wbEqQZaK/fp9GJ5G3oX3sbyjA/txjP2kVqRbUs/HJlS9CBF0epyvzw9ucAks?=
 =?us-ascii?Q?b8TzP3iNRnut9ptfHeb8vHg5qGh4EDiynNeEZjESDCPAAKeIRR6fCQZn6q6D?=
 =?us-ascii?Q?u1G3FhapBLLzhlsmTohf57V+fv53at7d0FfvAjsQZxeTbTuyRYRBQYJOnV2H?=
 =?us-ascii?Q?C7I6DxUca91qj+sBRHZlNHIlcgSuAhqoFz62gXushQiwx4a0eE2NmrrPcE+i?=
 =?us-ascii?Q?nbYVYq9nP4aGB6hg2JkcEocli81HVlDIBigFLiJCFMO/nRzEZdIdwVL5pBD2?=
 =?us-ascii?Q?W8fEV2s1xXjTo+Fh4cMGlfcTjbFMhfaklXzkq4LW9j/VcbpoHJ34HrBM2o+U?=
 =?us-ascii?Q?Kuz/xU6jhNF5SmSGwPfqiN2+CjaU8lbFCF6S+nzmTDdF9z43Z9+BJ760YxPS?=
 =?us-ascii?Q?QewmxttHL2KGGmmV0g4OELpn4mBIGBJrcYfAG8yjyoyRSVgrf3egG55Gw6Fw?=
 =?us-ascii?Q?pjkGFxWZGakmWY5rx/dUTypTD/kX2D/avrM5aoUxJ5do4PZGm5ewBrjyGEHg?=
 =?us-ascii?Q?Xqkzzfdzhb8dJfxeIwQteYEQBe8MjalTsKizJU/hlG2E9O7gwbZeZV7m/cr8?=
 =?us-ascii?Q?79/8qk0IgOf2Howmmwrbd/DMbcByBKk3wx1YKoTB565WeIkti7KQEX6nTzq7?=
 =?us-ascii?Q?NjRl2GSBNtTRQHHIUSoVLRw0eNrA9g2O3WMV8cNQFdsOpRKNoPmTBEE2KTb+?=
 =?us-ascii?Q?v/8KelOKCYcr6mXW5M4Zjri1a5hZ7VsKPC3eNeSGwBlmUuWTnDPrD3laAzTy?=
 =?us-ascii?Q?VGr8C/ZID7+nLRBqo1hh4q/VLmGqgf9wp20otrYMtqhwx3n1ErKpmEopCT9a?=
 =?us-ascii?Q?ZbKgQqTKsXaQPrSJQSLCIgXx9ZjPnZjCWVYbGPKfqt7xIsyYmC56KqC+RF8w?=
 =?us-ascii?Q?5VBy+xGurpwRDzT/zqltQkHxqT6xTQzyb6Rin7rt9hP0iVzXJ9KW2K++tzoN?=
 =?us-ascii?Q?RLBMEw6lQy6vym2zTkYwO8eKbWGeaHS2iuhLSGUqwhyaqJCXUoIEY/McF3Fh?=
 =?us-ascii?Q?S4mDCfumVwHi4nUece7Zl9erMNjn7PBwCA4myPJd7GkrAqf7MfWho460UQ54?=
 =?us-ascii?Q?wsVniF0vFNkFHjXIQijrAAPKu+Suqzs3eY7GcOH8ujjPgRBV9ueHS8w2NC8M?=
 =?us-ascii?Q?4PKkMXB2RQy9sDetGjGGFTU2NHtaOWT7+tWvali2yAUXHw9mFSe0uDoBBjwK?=
 =?us-ascii?Q?XZKHTvzcWK5ZNhFIwJWAn1VIZTZm1M7ZcbbYmE5Zxa0C3mtG9rj6y2XKAv1T?=
 =?us-ascii?Q?6S9I+lDzKS5DGc+eKjzufgLSLBUAOExCk4se4i7sZgtw0oaXpRAT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f1d7798-a08e-4847-bf2f-08decae9d169
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 14:24:32.5493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wEH1+Rt24ktA4roEI0EdTBeTKMCHrQharKouluw1KX1Jdjes7DOHSS/pv0M6/7e+aeP3WYEihxGuMUbJ7kRDtThXMYUXvpsHL5bjF5sJ03ltCBQ5FeYI2y3V+C3/+80A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10757

On Mon, Jun 15, 2026 at 04:38:16PM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
>
> Clean up the code using guard() for spin locks.
> Merely code refactoring, and no behavior change.
>
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  sound/soc/fsl/fsl_easrc.c | 36 ++++++++++--------------------------
>  1 file changed, 10 insertions(+), 26 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
> index 114a6c0b6b73..edfd943197a0 100644
> --- a/sound/soc/fsl/fsl_easrc.c
> +++ b/sound/soc/fsl/fsl_easrc.c
> @@ -1025,7 +1025,6 @@ static int fsl_easrc_config_context(struct fsl_asrc *easrc, unsigned int ctx_id)
>  	struct fsl_easrc_ctx_priv *ctx_priv;
>  	struct fsl_asrc_pair *ctx;
>  	struct device *dev;
> -	unsigned long lock_flags;
>  	int ret;
>
>  	if (!easrc)
> @@ -1053,9 +1052,8 @@ static int fsl_easrc_config_context(struct fsl_asrc *easrc, unsigned int ctx_id)
>  	if (ret)
>  		return ret;
>
> -	spin_lock_irqsave(&easrc->lock, lock_flags);
> -	ret = fsl_easrc_config_slot(easrc, ctx->index);
> -	spin_unlock_irqrestore(&easrc->lock, lock_flags);
> +	scoped_guard(spinlock_irqsave, &easrc->lock)
> +		ret = fsl_easrc_config_slot(easrc, ctx->index);
>  	if (ret)
>  		return ret;
>
> @@ -1301,13 +1299,12 @@ static int fsl_easrc_request_context(int channels, struct fsl_asrc_pair *ctx)
>  	enum asrc_pair_index index = ASRC_INVALID_PAIR;
>  	struct fsl_asrc *easrc = ctx->asrc;
>  	struct device *dev;
> -	unsigned long lock_flags;
>  	int ret = 0;
>  	int i;
>
>  	dev = &easrc->pdev->dev;
>
> -	spin_lock_irqsave(&easrc->lock, lock_flags);
> +	guard(spinlock_irqsave)(&easrc->lock);
>
>  	for (i = ASRC_PAIR_A; i < EASRC_CTX_MAX_NUM; i++) {
>  		if (easrc->pair[i])
> @@ -1331,8 +1328,6 @@ static int fsl_easrc_request_context(int channels, struct fsl_asrc_pair *ctx)
>  		easrc->channel_avail -= channels;
>  	}
>
> -	spin_unlock_irqrestore(&easrc->lock, lock_flags);
> -
>  	return ret;
>  }
>
> @@ -1343,7 +1338,6 @@ static int fsl_easrc_request_context(int channels, struct fsl_asrc_pair *ctx)
>   */
>  static void fsl_easrc_release_context(struct fsl_asrc_pair *ctx)
>  {
> -	unsigned long lock_flags;
>  	struct fsl_asrc *easrc;
>
>  	if (!ctx)
> @@ -1351,14 +1345,12 @@ static void fsl_easrc_release_context(struct fsl_asrc_pair *ctx)
>
>  	easrc = ctx->asrc;
>
> -	spin_lock_irqsave(&easrc->lock, lock_flags);
> +	guard(spinlock_irqsave)(&easrc->lock);
>
>  	fsl_easrc_release_slot(easrc, ctx->index);
>
>  	easrc->channel_avail += ctx->channels;
>  	easrc->pair[ctx->index] = NULL;
> -
> -	spin_unlock_irqrestore(&easrc->lock, lock_flags);
>  }
>
>  /*
> @@ -2292,15 +2284,13 @@ static int fsl_easrc_runtime_suspend(struct device *dev)
>  {
>  	struct fsl_asrc *easrc = dev_get_drvdata(dev);
>  	struct fsl_easrc_priv *easrc_priv = easrc->private;
> -	unsigned long lock_flags;
>
>  	regcache_cache_only(easrc->regmap, true);
>
>  	clk_disable_unprepare(easrc->mem_clk);
>
> -	spin_lock_irqsave(&easrc->lock, lock_flags);
> -	easrc_priv->firmware_loaded = 0;
> -	spin_unlock_irqrestore(&easrc->lock, lock_flags);
> +	scoped_guard(spinlock_irqsave, &easrc->lock)
> +		easrc_priv->firmware_loaded = 0;
>
>  	return 0;
>  }
> @@ -2311,7 +2301,6 @@ static int fsl_easrc_runtime_resume(struct device *dev)
>  	struct fsl_easrc_priv *easrc_priv = easrc->private;
>  	struct fsl_easrc_ctx_priv *ctx_priv;
>  	struct fsl_asrc_pair *ctx;
> -	unsigned long lock_flags;
>  	int ret;
>  	int i;
>
> @@ -2323,13 +2312,11 @@ static int fsl_easrc_runtime_resume(struct device *dev)
>  	regcache_mark_dirty(easrc->regmap);
>  	regcache_sync(easrc->regmap);
>
> -	spin_lock_irqsave(&easrc->lock, lock_flags);
> -	if (easrc_priv->firmware_loaded) {
> -		spin_unlock_irqrestore(&easrc->lock, lock_flags);
> -		goto skip_load;
> +	scoped_guard(spinlock_irqsave, &easrc->lock) {
> +		if (easrc_priv->firmware_loaded)
> +			return 0;
> +		easrc_priv->firmware_loaded = 1;
>  	}
> -	easrc_priv->firmware_loaded = 1;
> -	spin_unlock_irqrestore(&easrc->lock, lock_flags);
>
>  	ret = fsl_easrc_get_firmware(easrc);
>  	if (ret) {
> @@ -2377,9 +2364,6 @@ static int fsl_easrc_runtime_resume(struct device *dev)
>  			goto disable_mem_clk;
>  	}
>
> -skip_load:
> -	return 0;
> -
>  disable_mem_clk:
>  	clk_disable_unprepare(easrc->mem_clk);
>  	return ret;
> --
> 2.43.0
>
>

