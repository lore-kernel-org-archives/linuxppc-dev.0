Return-Path: <linuxppc-dev+bounces-22503-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9E9CD98CE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 15:34:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbmt06yYnz3bsL;
	Fri, 12 Jun 2026 01:34:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781192088;
	cv=pass; b=Hv5Eu1X8E+d7LwyWbDOXSc/6fdoyfrbo9l7XrdCEN0apXpFtAWOnRTFFrF3gNeXtgRpa8shGdRTr5ywf6X7S4ZULheJBNCM6IbC0t9uPU+tkb1wpVpRDEIJBjIV9pkc5xRLEv3x5WeCfcVPvCKUQ6D0zuNodbhwEYD+/cNpdXoqQ+iKi/f9/wk9HGkVoMjwm/qHxZUUE/XV4lJ3+eY8i5EEyw+5OntCKbM45HruRIcwLD6gyjZ5Ku1QjfXHTH1WxFdRldftYGuvUV1/c1GfgKwZLzSePGPf5mxXEUCM0sIHPtcqRjiw2UwmXp1xmZxzePqrpsaRQFlFqT+KvQhdFow==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781192088; c=relaxed/relaxed;
	bh=twdt8wkeP2tCO40sOT6FNyGYCVYwTDR0z4+mm8BwGVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l9QbiSE25mB3a6Eol1IfnY8iugXeosG8Ch0djcVDT4+LX5pU38MxeNE7GxTkIJBCqmI8wjBnA3m4eBNZ/hQQvoEfX9Vjcox3tK05Gx+kSiJD9zbzc1/JExf8LGVERD2wkRejy8aBowZb3dmxoPoCeX5nSMU3dXiFtMH7lwTQ6K9o3uqFnZFosTavEhsY0S9+oh2U8k7MeIrny7+zCiedjZVATQL5uPyvAY5GqakIP4DBSHOabLtVQtEH+SqXMmDGIGwRyYpgxzRbWFQTUUOP6mj7Ykd0o/Q4WAxrzstpGwoFZyLMu2CscOBs1h6eSwoqvAFeF9D3M2NEgwKxcSAFBA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=nonkPmY4; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=nonkPmY4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbmt01bBTz3brZ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 01:34:48 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AKXcPRUZoryvqSBxKw/eZXYT2hjnA2jqlf6+UbT7a9KYdrIRCvrmB1bNSEUp03FiJXfzOq/rwklq53i6zk/mfW/99Sz12ivZ1mpmfQr8/CrxOpl3KYSIEsVUIL94CbOYaRaOGXEx86DxnznMsLPutlSp5BS7lroYQVqUsXhwsD5fmDp2+cN0KVXejiuRy1YMLyosr9ArW76zSnMnHmPbSf/evTIjOC3IhUd/920H4TuC3e/7HHieySOB513HnTs7EAurhWLKTqJqwzjrWYTptMlVfFxH7O7M9OCoyEgbyTeqxjjy5Qr7IhmBKehXm68+9OllCHOcFdQ2ImeNIOYS5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twdt8wkeP2tCO40sOT6FNyGYCVYwTDR0z4+mm8BwGVs=;
 b=JbGJQpVLF+hp2LCNvE3A0Ns5kI7UdCFAliub9aW9JFE/DdWtNtIwNHB1dUFIexQIsxee/ri5jlfvUiX0Ozw8NJk2RDG1tDniKYAYyP2o6J1Ul1lYHP/ekiE5fRcZ7cw4wRheV+piSFx/7m2B0E3HWKcYZE7umVb79S4QUkqya+wXKYXgVQX5IaamUXH73TeLvxoZoOw/v7fhIcfO9T+sLV3xrRnAgCHroFtacT+Yh0oINDZMSc73SfmI+7o3O07MayoMrjcbinmd69isFvsBgjzUMbuO1ilf7K8CAY/n1Xp3HwT5Zw6xczm+yueLf7ssfW+Pyv3rKxHJNC91GgXXAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twdt8wkeP2tCO40sOT6FNyGYCVYwTDR0z4+mm8BwGVs=;
 b=nonkPmY4aiCdLbD2sVjz7EfRwrp1q8kDgcNOwb5CnDioh+i3w37OV7jnhun51SLrwYwqhWRdFeYjiGYDQQ5ytGk35TSWV9vwQoaGcMxmwqQdd0tLWOrV5gqtsaKdbWQ6VDUBuaQNPNzpaHK8FlHDC2/cYMJ7fK++0Bk0kQ6phyO8cqbRThhNYYS95tp7LEneZNSt9haGAI7XBvc4uy3qxPLAWpRjNWXlhS+5xu9BKzrpJ/W9K1YNSyLQHVBEFJA2zaPj4ffz5ovtJujpFHSKCcSQzGz8Z3hB0qpPRjTksYYMpUpjiQVUjMd0isHp/evmbygj6y/2u6+QKOh4oyN+5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV2PR04MB12019.eurprd04.prod.outlook.com (2603:10a6:150:30c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 15:34:24 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0092.016; Thu, 11 Jun 2026
 15:34:24 +0000
Date: Thu, 11 Jun 2026 11:34:16 -0400
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
Subject: Re: [PATCHv4 09/15] dmaengine: fsldma: use devm_kzalloc() to
 simplify code
Message-ID: <airVeJM2YjZtPE7i@lizhi-Precision-Tower-5810>
References: <20260611035245.13439-1-rosenp@gmail.com>
 <20260611035245.13439-10-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611035245.13439-10-rosenp@gmail.com>
X-ClientProxiedBy: PH8PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::19) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV2PR04MB12019:EE_
X-MS-Office365-Filtering-Correlation-Id: 8597be68-28cb-4179-bdff-08dec7ceea66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|366016|7416014|23010399003|1800799024|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	R3G2F0S0qMCqDLA3pkpDrbjo+HzHN9wV/kft5Ug+pRlHuuQ0pjdV2cMVHqkXkrLhIC6peodOu0PkhFcf7B8MT7gaRwE7XLwwJQsD2tPPpVYPz/qN49jJx007Sp0a2UVXnzrhMrDxbtBhGh48qzuySm5RhfjSbBJSWZmVz01bbwvDAtZU4itaL7jyKUznHfu+NqXys7xSplaAuOVVAT66tnxYNFYYTrIC7BB8oKwvdpwn8dw8lB7B5DrmFoDpOGlJQBrGlpoUvRCFX4VT2vaC0U4aiZ01cqXhB8zkBlpqmLkCqOfylILH6ADxTuZwEi8OHNyWxiDzC/xBzQ8LKGHC/vXLdS0ouIhTUvymr/2JKJFFvfDedmgZkpIgHatecnWTbNplmDPSNdpJkwjBKp55YMIKZxF37G8eVCiKGox/zcO6NDXXOGy6BcwDtH6lco29/fum0LWCeTfD0sExWvmgqEwYcNKG687O/9DidAyqV10G+EBKpVaXkU8icWggpdjP6oc3zuBFsVu+nvmwwnqHcMDxBFmGaniaZMxyrf2PDt4ZEk5DVGOjzYnuwwJBiY5e0UdX9uf3wE/QtDwN/ulFrfs2jKo/5g5HSoPuIxQqTd+ZSHFCXcTjDquAD/nK7rNcSkHkxm3MwQqBTOz5oG1nzeQq3036J/BpoXwJixGsZP1aaBRSGDUr2S8z10fT08YH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(7416014)(23010399003)(1800799024)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rM7DcnA3qFCjAsE2ARLwXaI/psnRcpShieblpTeb7a4oOBi0w3LsWcl78lNN?=
 =?us-ascii?Q?sN4OCtb8tZfn+TYHRDb8I/T7rt5QyymTFExm97kHLi4oyxRTJ+cBWXm8ABMo?=
 =?us-ascii?Q?wHQ2clGmVMwFyjvFsqNQJTclX5bFN5nNEZ4tdSIzWMzqlfJ5pBi1FySftX2M?=
 =?us-ascii?Q?vKXsL3KORnbvQapkS2pqedWj0uSzY8hjEq2tngTs9DI2mZYiHxz4+hRo42VB?=
 =?us-ascii?Q?BApr7crg2MdJNWdhBUBJFiCkpNCYjn/E6ovdxgmuR21E2sZ826nQlTGZeCwb?=
 =?us-ascii?Q?laZXWdhD9bYJscTzbzKloE6J6k+pwMe8+LjIN7+agHY3KNkvlxKpsdBKO6IO?=
 =?us-ascii?Q?LqEXwkYieJI6yDbGVWrwTN0NTxCl4z8/vbbr5pxtWOndcxcqHBX+a79JHSm0?=
 =?us-ascii?Q?T8sg2GymhIwELbR/TDWVpj0RjqykoWjnVeFT/OUot45En5yWFndSlOj1ucE/?=
 =?us-ascii?Q?x3q1a/yo3QWscngRDWGw/7dEXlVYB54Jr0cyS/gYkE+aDgLazju2h1ZaywsA?=
 =?us-ascii?Q?flODcMqDMbOMq0cRDuwzmQ4+GIMR16veSv0kF/7ZOaYu+PI2F7d2V3r9blXL?=
 =?us-ascii?Q?e7pLXAIpIMC38Gzux+/pU2mzbi/NbCCghRNtdfxkbPBSjDNCvjL+oXRDseF4?=
 =?us-ascii?Q?LjoTNfM+bvmgOdSp470iswKMcI9NyldyfK8nBKwOMQ9TWzQWWHkkdXpuoqCu?=
 =?us-ascii?Q?a0QL5bbpADBFYs6tTKZaS9eKX57Ss5B5ICR7k6RniFx/PnNDb9OERituoD5T?=
 =?us-ascii?Q?FkSyQ7xyuDBl+SnLYXruhaIDYH09siR/m1tuRBaLQ7E6opyRD8q24H0cBTgC?=
 =?us-ascii?Q?fEysBi+7kuyevD2KE/Hick3DgKa1UeIr0VYzxAR8HixyI442tSwH4mbnAQ3Y?=
 =?us-ascii?Q?SXyV8o7cDF1PmEaYSPo09d1cf4snRKD4FYRhCkkz3WhYCxw40mAp/WXWy+yr?=
 =?us-ascii?Q?h0YxQDVTN9GjegQLspZ/W1DFEzgJ/+FRTEsh0vdScrKVpgv9uwOuoPaejWLi?=
 =?us-ascii?Q?d38dj3wY7ZBia/w6uKEXmIaOpxSq9D1e164FrzKHVg8M4I6Zbnfpod0RGF57?=
 =?us-ascii?Q?DAnWU7IDe+vTjEr2LiiNBijHE2tm8L9DDNd5Ist44gqgnLl9LUL6wpafTaPT?=
 =?us-ascii?Q?VVQhlkfv/0vbmP3osc24NnwD9gG61p80DAkF8Ubla3R5zqYhc5cBdM1Fl2lZ?=
 =?us-ascii?Q?tSQQxZJE8TCNLwsMAH71Wvlv8m9SqzJq9d8/vI5xDjNk+RcIpPc5rP/QQuRg?=
 =?us-ascii?Q?/BLuvKqN0gwjXznX992DtSFmPw+ZwqQxgxwmmI8JpHWp9KL2CpFZyZmSbdUI?=
 =?us-ascii?Q?XCkGaH6zm1h5ao+dKIS65LRFIchjBN0jMhDCOS2aHCE5sd8HDLt0lqU3zwqv?=
 =?us-ascii?Q?nwujbGWj5cGSPhlD04lly+hqwDnZ29IctDM0qEoYXqitkpZebPr0Ht2j2KSa?=
 =?us-ascii?Q?E00wDOIMt/nHkL3WTlUftbUtO50tHLWULxg4R+pF4K8F6uSvutpWgkW/s9yf?=
 =?us-ascii?Q?pI/2wrWQad51zXU0G8+/K2Gqh+84KYUbLMiQrlhN+oSDydpSAvd+1FVJ6Y4Z?=
 =?us-ascii?Q?7uJAf+bSH6ClUIuzjujS6fzQ9UIOl14QzYj5NbLi3eExZN0ZDMF+yUDjRxrI?=
 =?us-ascii?Q?yqWJc52OpotK7n0TRZ1B+YM69igk31P0veBsnkRB+kQDujy2t6gVECjX/lMz?=
 =?us-ascii?Q?TbweCZiQEUtPfKFNrk3pMX3EvRszk/RADFcMLpiwtlgQV85xYbhNZED4cM7a?=
 =?us-ascii?Q?0UG89E2nhKOeGAqMsqWXliyemOCXvmriZjkmoJ4kqFuDHNrYdNxZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8597be68-28cb-4179-bdff-08dec7ceea66
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 15:34:24.4717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iU4aKcMdDtUukbFk2Vc7OzF8D43ZGu5Kfvh10zEzzDMngTZc8VnsgRvhKKzbP5aeF8VySHAgGkOPiWfFw44FEZ7m/0+sgzMOy2U2ZIcHm08hIeDxd34Njoj2BHWTIDNj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12019

On Wed, Jun 10, 2026 at 08:52:39PM -0700, Rosen Penev wrote:
> Convert fdev allocation from kzalloc_obj() to devm_kzalloc() to simplify
> the probe error and remove paths by dropping the explicit kfree.

suggest direct convert to flexiable array

Frank

>
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/dma/fsldma.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index eba194d64105..c3d2b24f8f07 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -1222,29 +1222,25 @@ static void fsldma_device_release(struct dma_device *dma_dev);
>
>  static int fsldma_of_probe(struct platform_device *op)
>  {
> +	struct device *dev = &op->dev;
>  	struct fsldma_device *fdev;
>  	struct device_node *child;
>  	unsigned int i;
>  	int err;
>
> -	fdev = kzalloc_obj(*fdev);
> -	if (!fdev) {
> -		err = -ENOMEM;
> -		goto out_return;
> -	}
> +	fdev = devm_kzalloc(dev, sizeof(*fdev), GFP_KERNEL);
> +	if (!fdev)
> +		return -ENOMEM;
>
> -	fdev->dev = &op->dev;
> +	fdev->dev = dev;
>  	INIT_LIST_HEAD(&fdev->common.channels);
>  	/* The DMA address bits supported for this device. */
>  	fdev->addr_bits = (long)device_get_match_data(fdev->dev);
>
>  	/* ioremap the registers for use */
>  	fdev->regs = of_iomap(op->dev.of_node, 0);
> -	if (!fdev->regs) {
> -		dev_err(&op->dev, "unable to ioremap registers\n");
> -		err = -ENOMEM;
> -		goto out_free;
> -	}
> +	if (!fdev->regs)
> +		return dev_err_probe(&op->dev, -ENOMEM, "unable to ioremap registers\n");
>
>  	/* map the channel IRQ if it exists, but don't hookup the handler yet */
>  	fdev->irq = platform_get_irq_optional(op, 0);
> @@ -1325,9 +1321,6 @@ static int fsldma_of_probe(struct platform_device *op)
>  	}
>  out_iounmap:
>  	iounmap(fdev->regs);
> -out_free:
> -	kfree(fdev);
> -out_return:
>  	return err;
>  }
>
> @@ -1361,7 +1354,6 @@ static void fsldma_of_remove(struct platform_device *op)
>  	}
>
>  	iounmap(fdev->regs);
> -	kfree(fdev);
>  }
>
>  #ifdef CONFIG_PM
> --
> 2.54.0
>

