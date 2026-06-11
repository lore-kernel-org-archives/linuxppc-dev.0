Return-Path: <linuxppc-dev+bounces-22504-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B444CD98CE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 15:35:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbmtv5XG7z3brC;
	Fri, 12 Jun 2026 01:35:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781192135;
	cv=pass; b=CJd3sozwuobIOwdKnV75MKDfSChTFO380DZ4uZ+g3K9SMF/I7Ryd9aeSrhUL9K0QO6tKR6xIKrcJZP+MjZEv0XHNAmIaaM+oCIB/iAogrn8g8jsVOKAe2bZRfP0m08F5zFU52WAXIbSLzyP2ofPlNJ5I97SQLTPd+5WVuCefndtNQyTssSsChj8Gubxv6dLE0CLywDvM22X1o+AYQUqPWJyFVtbDbEbWxigATnnsQttnpbMmkwvYENGYppNbp3VtSpcQVO2se8BOgT3rxMd4JD07GBh0NDVfMFfRq9wumfkS7jBgNSZtAnsmbD7WEOCq5WUA7WM7Peum5Eh4KX7Ovg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781192135; c=relaxed/relaxed;
	bh=ja9Q+jUXqrpOnzysCC5SB16ZTa0nILg3Sc36EFcrq6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TIzMQmpehQaUxi/fqYxyPNZhRXxh3G2DNVDH64DxSJSvNdxudurzW9lIoa519rMWNmuc/QckbLQwfg5QlI3eaQQdmoD8oVqLoN690jVi2uB78dfN6rCuT4F4Ra3xDEA3eGLZfrVT9c3Mtyr2gt4+qbhN/Fsx1VGLHpgBQIlyUNzMBoKXEIRc3m0msBIH1fZqBKemO1ywbFmpk+JCwPWwwme9en+uWNeQqcwdSCwgNphZ8HjtOMiQ263kgIHr641NPuxjAvux997z6lsrBFEonUfRBgLDfFL3SWFF2OYE4jK1KmPAZqhZtxeDinlHO32J95fGNXkhraCOkHKj4PeJBw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=w8uVnOsN; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=w8uVnOsN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbmtt6ssSz3brB
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 01:35:34 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOXPp/yJmluW0KnhhKDw72Edy1kFhR8RgMkbppdC5Xo6JCK//LGj7CIdZdA3ZsfGiJHXdg3ek+9ZCilDqjl5dtIdx2trs7BgAAurEBt6QLqXpuu5bJ3VXuZKzhYEgH4xjQu+2povQtYYkwZYlhCeB2YA5UnWaWdNz2XuQ3fnv7sEluugYUWAVT7bog2SKg7RTW7oy8O+VHg0V5s/CUl2pb7yTW3QOWVms6Yn/W0zcgk0wLRB7IpnWbsS24phZJqxdMnguqDw6wG3OFs3sDmwm1vwZwJ146eIOcsp6YAJkl80eUGR6PN8bA7eVXxoNYvDph/a/zKqHMc9PgRitEw1AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ja9Q+jUXqrpOnzysCC5SB16ZTa0nILg3Sc36EFcrq6I=;
 b=T5csg7MbsBPHPspFIVFXjN1n8QP3bt3xpI3PPwJdqdk6lNJzX1E0qHD8vI7EQcFhOhqlOFTW8sH2etNe6d2QEChETpW2/x39HIvWwynP/OZWNRb+0BEFNAWAYmi4OIa6jrZk1pGsw4qf3igPDQH5YSOvVHqXB2aeovRJ1jBV37tnZAr2qOTfF4kCR3wt0tFBFj3rbND17Wip047uSzFlIhfKm6qsHd+DYLrXTYPZQm/47uP0Ky5zsECbwxrYT/nQbrSCK2ndl01s5ubm5sOx7VSjsxqRwKqYKskLsIws2Mn12Ytx0IItcUxGeBuOJRVesn1wio6yy7/fexyYSxfQ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ja9Q+jUXqrpOnzysCC5SB16ZTa0nILg3Sc36EFcrq6I=;
 b=w8uVnOsN+mH0pUjlxKY89bcfU3Fgpjo7kkO5C/O5aZurr6emNEM3hKJ4ZobcBPenkdeJjvVe+UWFHPwaBr141TyfZl62ORc2vI1LXAXt3eS1TIn5uP8NL7Z13hivVUwAlEeYO8Py7NegDUL8H2jZpFTUA2L8Qx7knwhvAU4IXbN/ufOMDNPu8PgpwJgkU9ZEgULTzletciq3/mbzX3o1TA+rvdk1TAP3ZlezBOUyHYTgJvWUIck+6sajHvmMMEYTgZ4NL+eW0gW7a88hpo1g+1E6CeaCDWNqfkrdChfbx+ZkKkpyakv8HEOKEfzKH9jo0eJWqYLVjuOsn+dqoijkdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DUZPR04MB9728.eurprd04.prod.outlook.com (2603:10a6:10:4e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 15:35:11 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0092.016; Thu, 11 Jun 2026
 15:35:11 +0000
Date: Thu, 11 Jun 2026 11:35:04 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Zhang Wei <zw@zh-kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:FREESCALE DMA DRIVER" <linuxppc-dev@lists.ozlabs.org>,
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Subject: Re: [PATCHv4 10/15] dmaengine: fsldma: use
 devm_platform_ioremap_resource()
Message-ID: <airVqI7ocn5o4sER@lizhi-Precision-Tower-5810>
References: <20260611035245.13439-1-rosenp@gmail.com>
 <20260611035245.13439-11-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611035245.13439-11-rosenp@gmail.com>
X-ClientProxiedBy: SN7PR04CA0088.namprd04.prod.outlook.com
 (2603:10b6:806:121::33) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DUZPR04MB9728:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ec32247-9d6d-4dbf-f55a-08dec7cf0623
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|19092799006|23010399003|366016|22082099003|18002099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	232oEL9g5+kIAqsdymuePObUdfl3Ncw6H3cWcx/R+BCiMzt4Ko6iitQRWhgiA1mAJdLqe8dTdwyGkbRuIAqZVN/RRnqhi9LNMO4azSLSApxTIyFIStZ5avoHnXAhp+rA5Afitj03MYXr+SpK/Yb/EhOaFRWthi9t3kuIFJd/6LciP5+6mLSgOmUbGxe+jfHyXupBsghja2lMQ7GmxrWvHjPZs9FmJiKtPUz1H5P3/7bTsz+90u8nH8kaVXWEPF8PgTWzPNdqbmLv/jLXjYERqHb0VsXMAHZKu3tFUg/2BO7XxfivE6TG0WTNuIEyPudpuFGqsu6zNHxl7A8jS/VxYPwwjmJ7+R1MV1oTxviF1xK/akr5MU/COU60d2GT0RiWtkrNXM8AgljS1wJObgi97IuMk8lahKXpA/KfGP10X9mBPxlvaESvYv37zdceVjDA5/eQGkMnyBODEMYGXpGu5A2s7uCPHOSe8DhUf5sUv6f/44dryP9DF5FKMbJfDp75feOfxFl0U7HdNHmPqyvzdLTmIJv0IXs8eZoy+5QTfiQMs6XNjeGfZBvGziq05doj0ok5sIskQTWToh81gnpYT+IzcoQ6GMpNMoBQaxm+IeqEcbTPoStR1eJR9gZFamA6AczrcaiNLe+L2rovexA7aFxi3CsSmAWM7RvCnMkmO6nwzSIuje1+d+LJWCC6VvhZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(19092799006)(23010399003)(366016)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?02kMNB+XfYDZIYDrwA0VBzRP3GapnCz0y7N+nmmelYar/wrzLvd5/g/7a0HI?=
 =?us-ascii?Q?wM4O1LmOJ0AMYzErOoxgkmi/5xtWQejmTye0YL1z3UR67/DWNmtl81H9ELT/?=
 =?us-ascii?Q?y4zbsBNWCFB6dtmpy7n5bZQBGK/EpYB57Km0K77PbTiUOKwOESWV8ohgWtsC?=
 =?us-ascii?Q?oT7M7JHhKQJgQeQY58OjCZXIgulJji/cszd6jp5FdphiJ7McZo4KloCpAdDM?=
 =?us-ascii?Q?BUnVOZ0PPkt6RsDc7/62muP5R0ns+a1VsAb28lY3swWFVTX44N1wv9kN5YoV?=
 =?us-ascii?Q?N3UXZaUdiR2I26JQan3ANqRIXV6RSfu2UtOo8DhPhrQ+gnRrxNbzY/dpHmzw?=
 =?us-ascii?Q?NgntndkbVwh1dqYbQI7rSEcLXAO/0FwCYZBB3VFCHxv4wM/vyami39xDrb/H?=
 =?us-ascii?Q?YMOOLJrhEdQU1uLg4exBYD7XgsXRdLObt9OLixnM2WuD/qa+xYD6FxOmQXaM?=
 =?us-ascii?Q?xgRNkxI5cwLjEhgsRK8GYmnKoX9OnpXcT4uQXYYcdMOo7JDPxRs+UN1YJMFD?=
 =?us-ascii?Q?ntVi6XA4qaxW0gVwm/VRGByGT95sfg9UOC2WuowlXdNHC2+0bemS5V4AN/3y?=
 =?us-ascii?Q?S/VWQpb34uKQ6KYN3QJrhxf9xEL73mXdvU/ZV/X3OQxVkXwEYsc5k6L4IyfK?=
 =?us-ascii?Q?udB564YK3WNasoTNf4NV9nItxMVWYEVplFSe3UvMIE5/p2CfQFXtjJ1HEaHn?=
 =?us-ascii?Q?H82NTMO/knASsUp3632W2qRUvqXtq7XimIFMpHa1ye33/LytWRRNv8631L1K?=
 =?us-ascii?Q?2KwSawlfS0m7eejsUAzEofSeLpue6l6kgGwMUK6TjQfjN2xnhcWwfRB4sVgs?=
 =?us-ascii?Q?jTYeT8+PKwuq8JZucszlgyz08w+fnm4xkugh1YzMKLRaZOWjgcfna8BFse1O?=
 =?us-ascii?Q?caQ3Dnh8UvPZfYHMz/R8AlPKSsfPyJkol5KmuzxCBZJwP8P/4Jz8cSCHfytT?=
 =?us-ascii?Q?tYVRyq9oiBXHW5PbIcc4ctvYazpY/7kacJg3BZOH1LQdZuK+1h1f3GzQ2dP9?=
 =?us-ascii?Q?taDmCRqG9UBfn4ry2413DEN0eUIA8/cuQDkaT3Rd+udcLdZnsTlY6H5uPFCK?=
 =?us-ascii?Q?OVQZn2IhYCEorPqjllstZYvB1T5BDtKETBAG+dKrnbOE33eUY+5c0lq7IpD7?=
 =?us-ascii?Q?mGF4IjqgCWbOYkEZGW3NEh2LDGIgW99443eNeUiCb6yqfipSWxPCkwFS6jwg?=
 =?us-ascii?Q?TLhHYdPcYMjLLPi9QszbrkOQGx+F7b3EMQmIA12WoPJatdSN6PqG+9tKgm7H?=
 =?us-ascii?Q?vVWOmXjNF4tszaHzfSKdpxCtygh+U65KGr/mAog9V6NIdfIEMdIsaU46jJVX?=
 =?us-ascii?Q?7u78ug9t5YBn227/h7D2lR0Ls1rcA7vos8QL1gUWOu42LFc3+qvBu/fsmI2G?=
 =?us-ascii?Q?mClxwTTv08pDFQgi9SQlG9cInh/vVi93m2Av2U+H9950glauW2DZRrR6EhdP?=
 =?us-ascii?Q?DSqY6NVDyLCmZHQk4NMjCot50jdHDNy+a/yhjZOQIsexOkUdszgTOtf/We9H?=
 =?us-ascii?Q?OlcaRnpCEHexsNBcD3bXlpxpE5TJRIoyyhBKJX6g1bbGX//OwtHP0hRMC91p?=
 =?us-ascii?Q?c57txA4rINwkLuybmc80dYCMY8Ro3TuK9qiu+c2dYWmhZ05klwh/RZG2riAT?=
 =?us-ascii?Q?TH2NHe//Zlw1XmsnmBtn7S6xf/5uW/Y3GuCB4jDHcIpRQHIoaxso/9ERpZhw?=
 =?us-ascii?Q?b1vur2bgztg6VNhDXg9aX1iVbeksKFdJA8FelHr0QGNYKsDMKP1aH24Poaw5?=
 =?us-ascii?Q?8f34epIqetFYzxMXfgStcCinDU2nn1oVzknVHgOT4778FXFUH9Ee?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec32247-9d6d-4dbf-f55a-08dec7cf0623
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 15:35:10.9784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wbDQNZWFssIIa9TrKVMstIGBTlnHY+QvNfkOE9MxaB09y/wzZhfZuZ+PmrjZzW+qWNYL58lZfaPfSg2MfOeM1kUyD95odM2zQwTMMR4K8qIu9d9KPf0pbQExS9rjHRHN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9728

On Wed, Jun 10, 2026 at 08:52:40PM -0700, Rosen Penev wrote:
> Convert of_iomap() to devm_platform_ioremap_resource() to let the devm
> framework handle unmapping. This allows removing the out_iounmap
> label and the explicit iounmap() in both the probe error path and
> the remove function.
>
> The DGSR (fdev->regs) and per-channel registers (chan->regs) map
> physically distinct regions in all supported variants
> (EloPlus/Elo/Elo3), so there is no overlap risk.
>
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/fsldma.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index c3d2b24f8f07..e4a3315a7d9d 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -1238,17 +1238,15 @@ static int fsldma_of_probe(struct platform_device *op)
>  	fdev->addr_bits = (long)device_get_match_data(fdev->dev);
>
>  	/* ioremap the registers for use */
> -	fdev->regs = of_iomap(op->dev.of_node, 0);
> -	if (!fdev->regs)
> -		return dev_err_probe(&op->dev, -ENOMEM, "unable to ioremap registers\n");
> +	fdev->regs = devm_platform_ioremap_resource(op, 0);
> +	if (IS_ERR(fdev->regs))
> +		return PTR_ERR(fdev->regs);
>
>  	/* map the channel IRQ if it exists, but don't hookup the handler yet */
>  	fdev->irq = platform_get_irq_optional(op, 0);
>  	if (fdev->irq < 0) {
> -		if (fdev->irq != -ENXIO) {
> -			err = fdev->irq;
> -			goto out_iounmap;
> -		}
> +		if (fdev->irq != -ENXIO)
> +			return fdev->irq;
>  		fdev->irq = 0;
>  	}
>
> @@ -1319,8 +1317,6 @@ static int fsldma_of_probe(struct platform_device *op)
>  		if (fdev->chan[i])
>  			fsl_dma_chan_remove(fdev->chan[i]);
>  	}
> -out_iounmap:
> -	iounmap(fdev->regs);
>  	return err;
>  }
>
> @@ -1352,8 +1348,6 @@ static void fsldma_of_remove(struct platform_device *op)
>  		if (chans[i])
>  			fsl_dma_chan_remove(chans[i]);
>  	}
> -
> -	iounmap(fdev->regs);
>  }
>
>  #ifdef CONFIG_PM
> --
> 2.54.0
>

