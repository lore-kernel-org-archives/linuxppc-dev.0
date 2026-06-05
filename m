Return-Path: <linuxppc-dev+bounces-22144-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A201CCD6E7B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 22:46:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gXGkX6TzBz2xjd;
	Sat, 06 Jun 2026 08:46:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780699344;
	cv=pass; b=g8OKNdvWT1SbrnkjpriiLc6DJsXRbrTTEELqz/isEwE2+aZ0WkyGdK9HT/09jKlh/iaO4byaP3rphoZZFW0tyFfEQtmgdaj6ym7cDuN1nkyxVFHqIg/sBgeIYON8thfh5pLBGViIlqffu5hTbDJtz3kvpY+rWiwPcUE23zrT/tiPiGVobb7MYRweRsuIzHb9ghvSmmHeRC69ax1p9Dz3+fiqAEthUnR56IpB3xU0Hv3QmEwpQ1LDmMK8DaK2u2CV7SvsDUgkRwWEhNYFK4keQfKbFuqgoS9Lir5uriM1+ITtl2bv6QULAhEacCDZjH0+v3v14o13DzEJJ5f0dzLd7w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780699344; c=relaxed/relaxed;
	bh=5UhhGWg9oJSve8Ce0HXvUNOKrvKkvz1bUbfN4HVdXsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BJ7U1CxSlFWaKc9qNaL9wPZr0hmF9CR6tcuXy1Nzx/P0ema0JdVut64VagzZPyR+AwqLe/r3hXG3V6W7jIGwqkBEWd8WJKcviJ/O/44F5i0dic716k8jn9QYoq1ZMOVsbOo4CmPCkJO+z6S6Lg2A0xX/MOEbdmxyzC/Bxxh8oUm+Rw0hS/RuIzJsQWt9YmiGhgwbktTVLyPzhSq20cwYNSgR34LgKmdDl7G2cKfv6kWd9B3HBn5DQ3PsDJkrlpfqQHFuu+DFQjR68UYdLk9mYjt6qXhmmwW+lkVnDpvAjMjJOepyt94XyN7R/AGXFkQmXIaXWCL/NeihZ0KdWZHFvQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=cO1p8vd9; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=cO1p8vd9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gXGf748k6z3bpm
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 06 Jun 2026 08:42:23 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lFYGt7pypUZH/T7SQYeqi+xX5qQdmoO2XSI1HCRBEEyrPDmx0Xsm8v1qy0IbZasn1j16L46+TRa1ZpnyZPFNvNHb0JuHF5ZNIvYEI0Ym2cmG+vVr2KIDJKNL1YruWWOre+YCUK4nu36JIOomM+AloMXxWbkvfav5KN9jaGaX8Ztg715cM3zluVrlNI5by2wu75QoLaA/pW+cUrOk+6I8u48UAvpyJYIoCdgO9+3Aw4k0nF2JCPIGoOrP1EkyTWZQV54FTfOWhGj469jlR+aP630lWhxjCrGLY5/YLCzZhUMugWOrDxRN4agDWnao8ZY0xdrXEbLBwzQM4nm8jjPNow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UhhGWg9oJSve8Ce0HXvUNOKrvKkvz1bUbfN4HVdXsE=;
 b=e0YJvZB8UU3yHN6ZL7URTNxkDjt8foeTr8HSqVmbsdAdriTa63FViZqnrps69tM8WEpaAZHtXTKs21ZnKRFMRqqEt2F8illyVBVjGMWCfzp05+JeT7dC5gL5yytbgr4Iyxk9mexKrEkCiZW2gii5sMgEDR7K71q+g/7Bov8SSEFcPXmkdG3MiRAT+RzHWzN9hPZoFSG1TAgD1FE1EGy3W9tpJ8MTPAT6RT0BxaqXVgJZMbOejrnyVXYHrHXRGtXnwG5p8EmZUNn+5TzTTJZ1aBxGeBGxTjO/EbVnvHUCQgJhIA6eXap5FVU2/XsCfUuqU4ebfMoAV3UPxDGq2mz6Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UhhGWg9oJSve8Ce0HXvUNOKrvKkvz1bUbfN4HVdXsE=;
 b=cO1p8vd9FBiyOX0EP1iO0p3HtdVmRpwjfGFvejiru3gjjQh8R1dhQeVOjDV0asNYFzK9ZWdoaIPIi+5cipMF+hDekmWOoHYBSZnW4CF8EYxYARGTf4tiqXQ1xqTyrIg+PL+Qv67YUy9UCUe3HMWD2HRkhLIl4kIAykRjNmpB4JI761c68TN/yZsewDzxN7vnaYqV7R7oIPR3mJ4NyRaIJH5mdL9KeR2pPta+eaB5BkFehHKWm+A4bSEFeTxvvFHLKVtWroalJupeL19tIHoMZqWsBok/BdfMuUaAgSM7JLvWp3kO0Cs7DcFBxNGE1ZSIjCW12fE4mOFJsISpRHvafA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PR3PR04MB7257.eurprd04.prod.outlook.com (2603:10a6:102:93::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 22:41:58 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 22:41:58 +0000
Date: Fri, 5 Jun 2026 17:41:48 -0500
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
Subject: Re: [PATCH 05/10] dmaengine: fsldma: convert ioremap to
 devm_platform_ioremap_resource
Message-ID: <aiNQrIsclHXtXu9u@SMW015318>
References: <20260605220134.43295-1-rosenp@gmail.com>
 <20260605220134.43295-6-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605220134.43295-6-rosenp@gmail.com>
X-ClientProxiedBy: PH7PR17CA0005.namprd17.prod.outlook.com
 (2603:10b6:510:324::14) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PR3PR04MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: a20aee03-81eb-48b5-4554-08dec353a6ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|19092799006|1800799024|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	5O/kGQR3Wo/3NO05i1nxspV1PG9CRCwoaxkf1dJOlhEOxDqYM5kTyIyLlYfJRvGq7GSXt9mXcSLnuVE7MCCR4eqiXLm7K34BLx3x27nyVxTMA0uqSzZhz7Ut8/oBP8Ly88hvP3abEBpj+38V6bN47kGOPmGM2ZCsjdkJa9PmJmT5J1wGfBkR1W4kyrrc8A0DCsLl33HPF3iN0HDo0NPeVZQU+/MPoen07lYnCy6mrzR3YgdLo02CKfhyXfeaPBF6lvyKOFe+jhssrSl8N71Z7TRsWb/lhtklY7uAQ2CPURqba2RkkeUgmxnlZefhlYBBI4gvn4jxC7apZyt2aq4sA+jRxdbxwG7VACacuuOIfzGzNXKu1Ph3/f05VuJq8gQu1EusJpoJn9vqdw1edR29m5wJOAzJFR8oiU/NF/LwPvxEqErmqjc4OrmS8AGxgXNk/oFyWX94aHshzxaH/sjbFXyz3elRx7CGJrWJYN+l+sA8w2GLFuCnl0J/F1bbW8QqMHaKFjGONqaBXvLEreJm1jv4k5tLuaksvOlp55iZJgObVV9v4W7HcnSN9dhbZcVpH3VfLC1kv2D3I5BYoNdKUYcA+Pagz4FrLivhDkGpayLWkRoeVFSRNavsSvo9LwBvZSzT7SC60it+Ai8IvIq/8bTDcskLfU6D/c5PGvILV/cTKx75byPc2SxAEmIE2oE0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(19092799006)(1800799024)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U4zJoV8nYTu6hCRAFBD5VzmF0icRi1e455QhWebt1epHV2HMFDMU7N0iSbps?=
 =?us-ascii?Q?Xh9TaviQl0ZYATxGFejz4G2Sz7g663aMNkISFcQ8odS4nYIkwA9CSo4I37o/?=
 =?us-ascii?Q?cuOhxl7EY5rbtOtOOadj28H2PSYZXrH29JtogS63s8vub4hPCnMou1rhXH3d?=
 =?us-ascii?Q?60kDWctrpBzNFpcmTm366h7cfMsdEuFoF83qrRecPzhie2gRA2Fv+2yiHorh?=
 =?us-ascii?Q?2Y1UkjzASnan1hevHvZwjBKlJtP9qMUBeU942usJoI4pUBjNHhnf2ubcRYIP?=
 =?us-ascii?Q?esYAsmffjyT/0JltO58X75VyDjCfS7GSAqqfNjzgrW94UO1oAvFOnul1r22G?=
 =?us-ascii?Q?sOyHo0QoY79N3+shEstnnoMosfGp1uQ6uD1HjbomMc8Eh7nduvjc+gvSocdD?=
 =?us-ascii?Q?fn5ee8MHI58fXQNG6oCfo9CfEgR6ry9ew2oXXgbIg1QFCWCg2BujYzxBMj78?=
 =?us-ascii?Q?cpTRqU9tSqkX8499oPcS1xCi8IlaJ4JkkjcqAWO9p3P51WYZAfPbtNapy9nY?=
 =?us-ascii?Q?BtBx61xVxNazrcZRuDQFsf6jqY8QSF4AQJzlHODAQIYYu5n2NBeH8MNpjOTO?=
 =?us-ascii?Q?yTSPMmTSPyFiwMNQrlBhAXlA73iLYuSkMj4qFGVeToemvM9QiYovhTNl3zvP?=
 =?us-ascii?Q?Ey0l+i4u/bNj2N4LoONjIIVmV1pzHbAXs7uabMTa9FyUkQv79GvMCvp9l9Gh?=
 =?us-ascii?Q?Z8N5NDakYwXn1QV0f0fGdQlSrtjtFqnnIfJMj4pxBGv01IM8xjgEzkZM/uPG?=
 =?us-ascii?Q?gi3fBzrCMdajGWbULgesiUekUp0yqAETKxheN43Z4Czo1lirO1UNiOJiVhnZ?=
 =?us-ascii?Q?JKX13bZ2ZUMelmn6eIRe4OuejZ3jMf2Kx/wjZUVlDYWZGns6wYc/RlolLgfO?=
 =?us-ascii?Q?mGAGEzDhyp/VULxcCwk8UwfGEBLAj97nl0uLavH3E02RaoPvwevW1CwGfIgI?=
 =?us-ascii?Q?0IMC/52J40enaStrepO3S6tJwLnnhgs4u7xturzUEkQLkpBCcEiAATyvGKLX?=
 =?us-ascii?Q?DzSYhVSZwYDDG4gp70izC21vCJqc1REglMCBiz7PYmBb3VfCe6aPbcE4/zx7?=
 =?us-ascii?Q?O5NyDFQ06LHCvdBzKD9iZbLqM3BEOUp1Eq6iSjDbzfqVPV7jErszf7XvYtsX?=
 =?us-ascii?Q?XwD54DGN6VSgFGShl6pJYYsU7dwx265YM0SR7optjd2jQYZXaV4mG9/Id0YF?=
 =?us-ascii?Q?L9vJuiDdFy+q7AvY9RM+5oEj5YeAAy7T2um1pTVCPe+z7xqZ9G7W2V9AmoFM?=
 =?us-ascii?Q?CI8jnVhSHTUYhDLrheHCFsjiZcWEOVz0HoTVfKw9Yb1e+QeNWQmQ/M0eoCqA?=
 =?us-ascii?Q?q2BJQKmhv37jcuw0hhN/s4fFq2bLnsygQHGHJS5Lh6M17wAmb1LgJIHdqXXd?=
 =?us-ascii?Q?BdAafsqYvFPV6kAQ7eSzTXtUm0dGlU1dUkK1rO9T0GZ1Nyc5XjGh8WjSR6bk?=
 =?us-ascii?Q?ex1Xr+MTnEg/BGJgP/2Ztb681isSKz/JBa6a6OY7j7kjYu2aSqUiJIaYNFBd?=
 =?us-ascii?Q?MG/fDd5l5oVkY74gmHSiWGBYzUCkZRnWIxyfEfYX8zhKM3uLrhZky5AwSOlE?=
 =?us-ascii?Q?ry+OsH8L5YxLIkVioA6/D642kXGWqZEaq2tyBNy/cARaYjvuzljSp8nC7zPN?=
 =?us-ascii?Q?i9B/u8tOMNjcrsFUGSGXMHi0+Qu7RSttNeHyA8saSfMIgSqgGAahPGSoE/CB?=
 =?us-ascii?Q?QceNYYtDcXKPycYC57eu4oUUixQuUeAYMmU3ef35SAiYFo7w7whbU++1or+c?=
 =?us-ascii?Q?qEDF1M6xuhEv/vWBZ4RG4yAmDIUYR7wxfk2UYtzwfIFNpqxc6VJF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a20aee03-81eb-48b5-4554-08dec353a6ea
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 22:41:58.6007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2sP/3yIU1hU1hkw1adS9BY7tmpGXNDrirundq7/EgleLzGTM0FqqtzF6Rv9d14bWCnHpUAIxe8JOwk/OwpcVudC5A/AAekNysFOi8ditWOSy/AYQpeIH5BG33i+biWGw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7257

On Fri, Jun 05, 2026 at 03:01:29PM -0700, Rosen Penev wrote:
>
> Convert of_iomap to devm_platform_ioremap_resource to let the devm
> framework handle unmapping. This allows removing the out_iounmap
> label, out_return label, and the explicit iounmap in both the probe
> error path and the remove function.
>
> The DGSR (fdev->regs) and per-channel registers (chan->regs) map
> physically distinct regions in all supported variants
> (EloPlus/Elo/Elo3), so there is no overlap risk.
>
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/dma/fsldma.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 2efa16d12679..2a6a247761a4 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -1229,19 +1229,17 @@ static int fsldma_of_probe(struct platform_device *op)
>         fdev->addr_bits = (long)device_get_match_data(fdev->dev);
>
>         /* ioremap the registers for use */
> -       fdev->regs = of_iomap(op->dev.of_node, 0);
> -       if (!fdev->regs) {
> +       fdev->regs = devm_platform_ioremap_resource(op, 0);
> +       if (IS_ERR(fdev->regs)) {
>                 dev_err(&op->dev, "unable to ioremap registers\n");
> -               return -ENOMEM;
> +               return PTR_ERR(fdev->regs);
>         }

devm_platform_ioremap_resource() should print error message, so you can
remove above dev_err() also

Frank

>
>         /* map the channel IRQ if it exists, but don't hookup the handler yet */
>         fdev->irq = platform_get_irq_optional(op, 0);
>         if (fdev->irq < 0) {
> -               if (fdev->irq != -ENXIO) {
> -                       err = fdev->irq;
> -                       goto out_iounmap;
> -               }
> +               if (fdev->irq != -ENXIO)
> +                       return fdev->irq;
>                 fdev->irq = 0;
>         }
>
> @@ -1309,8 +1307,6 @@ static int fsldma_of_probe(struct platform_device *op)
>                 if (fdev->chan[i])
>                         fsl_dma_chan_remove(fdev->chan[i]);
>         }
> -out_iounmap:
> -       iounmap(fdev->regs);
>         return err;
>  }
>
> @@ -1328,8 +1324,6 @@ static void fsldma_of_remove(struct platform_device *op)
>                 if (fdev->chan[i])
>                         fsl_dma_chan_remove(fdev->chan[i]);
>         }
> -
> -       iounmap(fdev->regs);
>  }
>
>  #ifdef CONFIG_PM
> --
> 2.54.0
>

