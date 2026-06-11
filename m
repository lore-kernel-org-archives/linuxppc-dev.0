Return-Path: <linuxppc-dev+bounces-22505-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F341FCD98C7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 15:36:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbmw153Wpz3btc;
	Fri, 12 Jun 2026 01:36:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781192193;
	cv=pass; b=eWrwNh3nbUlZo/+/Bw2m070sqPkcogBhFTUym/Copmivx3g+5lcTIxCU1X8gG9H05YK5UtwM4cNOJCo7nErwJ14pG5sZd5gQutYgFZTaR0+rmhH0ZlIZxh/L1bj1tMXxRfDex9M01oSSR1X9WbN0FGAGhBcZwt9Ysl4QdxzGFmsFOyg2zob0P9qxsVCWk9Qg/WBErZHQdcEMsJAl2WaPDqo8pScgGuB3SyaDlMeRNYUa75QIeKPVbnFGH8p+vCA6XO0rV5vKiX6hQYoiJf30k+9sPMw02FoHMZgTGd+3jOUKZKfQWI2l3R7e0rJV1M1wTL91y2HRTp3JbnznlsD1Qw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781192193; c=relaxed/relaxed;
	bh=8krmzwjIaX/jbkbr1o9JInz9/GfCfU4BvsncmlRn7WI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lP9OEHl/bdiSKT628bIIY1LzGdis9glH1mlKZulFlHY9CbASEIolv8Tkib3Qzv2aGx7KTUAcKMHFYwDzrNxUTZxXxLqfjD65N2STwMp9js/4B5V8mbPBVjcoaxaNvUuOoUILWBp3PxzumrL3JfvSewot+YbGnKA+XhP2qJd4sY+dOSS0NYbCef6yGm7WWkuh2eWpHxFbXdsTtZUWUQKrmQ4Z+MRYrWAd7cineZHGjKDlotLewwhQzp+PFz+4Lqw3SUskTTgcdPY4dRwGiTc2fUORatGcofqoXBYHd3/FECdPzhw/YHUrzVopo4IJ2y37tqtoDzYunIQZk4EIyPubmQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=OTyq4wDm; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=OTyq4wDm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbmw02Y9Tz3btZ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 01:36:32 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EULme5gBdtuqOciViHNWNOZ11/Ov2wKhuBZ9gEvYneY4+1n/pj07nPH9spA30HgKkwHsEkdH7k7NuU/RpW+XuC5zDYCTxp01TM9xRKmZLj6IglSK4lebgLfCV94djXQlTPbcjfgWKfGxJKM7ugiicml0LK/F5kvSk4dd0GtMyVttMuMCvZpH2+I+yY9Jwq1oJ13BKksTx5aI2CdNUvyfFVUSbntLym9NpzRHLTf/lezMiWJ+eHtoSSlvQeCKeAYg5iX/VlQxDCo+jFMUoFvCO5kokx3XSSlv8jwhwl5mpK//WjxP1G5IHiXb230I0Blxr9j1+ozIDsq0w+vXZUEf7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8krmzwjIaX/jbkbr1o9JInz9/GfCfU4BvsncmlRn7WI=;
 b=flMsXNM7KibbSM8jiQIID06DmHdltLlMmfAQRc5D5rYFbVt88dYRkvdRFkh2P4tLOdQB3OlzOj2KpsCeLcnE/skgmVwY8LLyYca1rmV0WjTMPU05nBTVVTr4ykrAF9kq0GFHevoSrZA34asDUbzp4M4iaz+oc7GkT93PyazyyqT4KJf1KJGv+Pq5DZnIxQd8rNWHp2lveKpEaL7LMfY5LwGfhBgE5IajYBGDdtgFEbmqX6wXWK9Isf6GzQ3zDO8iLgLyOubzIoMPHBnfQZyc2fF/yc7mJGH5L2r6d/TVBcp+UFLoiQz85RfEF/LtrImCFRG51xTyPdYdMUOba7/kuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8krmzwjIaX/jbkbr1o9JInz9/GfCfU4BvsncmlRn7WI=;
 b=OTyq4wDmGdwC40HU1bTb/9DJgmz7IsMgBDRXpNEGUbUxhGluh6fzEg7bu7bre32BMQI8Ggf2ywjQ0+VN5/RBe9Fs2zfeZFtv3odB9W6hw/zY4llyTopSwNJQuHU0BN106oVk9EaJbfYQ+g/tyHOdS37s5QbZwytMyyD6Do6UUo5HY8MPZnODS0LFWGnvNQuMxekCkSROr8fyFlfkxsiwV/wisuLGDBMFR0iSwziwB1+sco56/sT78pk35O6on0gGp2JYS4M9BP5Ni+UDovrERNtAOU4W9MVTJgEdNu6NgVA2AbjstUQ9wLlLX+Dp/ubB/kEm2E32caPIEFhoRC5hZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB8PR04MB7019.eurprd04.prod.outlook.com (2603:10a6:10:12b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 15:36:27 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0092.016; Thu, 11 Jun 2026
 15:36:27 +0000
Date: Thu, 11 Jun 2026 11:36:17 -0400
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
Subject: Re: [PATCHv4 11/15] dmaengine: fsldma: convert channel allocation to
 devm_kzalloc()
Message-ID: <airV8Wm3yyY4hTQP@lizhi-Precision-Tower-5810>
References: <20260611035245.13439-1-rosenp@gmail.com>
 <20260611035245.13439-12-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611035245.13439-12-rosenp@gmail.com>
X-ClientProxiedBy: PH7P220CA0050.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::28) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB8PR04MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: dbbdd2ef-ab58-4a7a-c116-08dec7cf336c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|7416014|376014|366016|23010399003|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	zmtaoy3aY+UY9hwCNGK8cFtxwMzQOim/z5vP8sjtcusxY5ytQCooFKU20SxuzUBiNV7H0wCyvfn/vQQ8yo67VmtrX17LzGe8ERUzREjE7MB74RTxfF1fdx1RdsOu4H50QeIc3sjMOT2kliJRpHqBDRs3+/xKC+ol3loBY48iOmKGKHUIhs0Om1oVXD3Sm/9yWsu1A9r+S4DDsrB2mRNI1HpIZ/+cglwHxf0H5Uhtcd/v6+dH0pmDPOJsD7nkBHoGPUXR59Ed40TzXi92XsAchMN4wRGS29ggjLdbLtcJcDYxJj8BEewjs6casv4rUnAcWt+lKANOvZRuZP4vyVPzKE2j0gr5ALO+ebczEwHXx4F2p8lwyX4InuWQuBO/IzqHYWusPP6jO/82pAd/hEtXfgTS0+GzpVHID0Dg/jdzNT/313u1FFdP+FYCoHaZb1b7fSRu1j6EmreD/UKXuQd+fMktbGKjckIiVmiRhnm1hOSqr057OZQR10okpAmmQUtGOiUUh2qXftj8lTKBPQBJ/FPrx74XXz0pMWttXuBw7Q8l+0WO1HuuXpCAgTW1OcBCiEtK3g7zjF7RTEmTZjXq61Sgcdt0hwwHWg7lVlxhPl6NBQrz51KdVR7HSqNU2CcTFU7G+mlRFNt9ZPJcsS8/8/V4M0NUKC/QUpEs+b9bEryqvUtO0MTQln/O8zLmYWDT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(366016)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gSqA6Ij61dknGgDg2nca8FANWMjIvwuMOfhMj26t+aOQA6VLZnWR91rmymh8?=
 =?us-ascii?Q?5H8gGFOXRJ6rR0NDryHL1xKKUWIZyhAJ0mQhcE8GW9BbSBIi5eiYowqGK5b7?=
 =?us-ascii?Q?QfVCDKQKnctgb26QlyydLwq4ubY4/MbpZ+A87j5j73GtKGcYQ9kug92JZ/8R?=
 =?us-ascii?Q?3/iNZ0H0GzYUlgXk951vsY0/+pcUUKzIoVLLzzFrKG1Ui2i2m7NqDUyu8dSn?=
 =?us-ascii?Q?3dvE6RAk6cdUJdA0BTul2jnMBx6uaVQvAJQYFLogVrelBH+x8vsSMFghphSQ?=
 =?us-ascii?Q?PkjinuAEvj2iQUavy8pwedGQ5ZRk2C+ByPzukF/3RKQ6S5UYSXorBf2mXTW9?=
 =?us-ascii?Q?Ud5qXddYAofW2yYatBFQofC0sHg2JjtAVNG1c9zgO2eqvJJhi+vvsGtzQ8S6?=
 =?us-ascii?Q?sclQfw4ZSC6QA/yZf8cY4mu4EczkjJp04xBcD9IsPdaahH4AJHr2sdQmQ1gM?=
 =?us-ascii?Q?DI//WxXCOxUxoTD3inI+M4ROaYl7N0KESYJz7wdiqxQHbxJ0m/RNvtxbMAJo?=
 =?us-ascii?Q?aCupEgzItpWsMfjU6qSPjd+pUL1/30PFD2mtXZsCuS3tTh9WwxrTjXx2X/19?=
 =?us-ascii?Q?tDbSmSyNmMmVF7DvIa5RHHGYxmpQ6hc7wgQMekje2QGIT0Pi7XE+dnrUohUD?=
 =?us-ascii?Q?XgNYnIV+NC7tKD75GGIp5GJNjGyo4qyIL6k7jrFx6j/2B0bpLTYnKdvdDTTO?=
 =?us-ascii?Q?suLfxE/BrVdGLl59keNZkhdIm2CALrB1utCyxQljhniJHE6/jTG8alGoykgD?=
 =?us-ascii?Q?cKTYIJ867xjk5z0CW1LgwiXhJaC6A9m6wpOWVl/AlcVpEh8syCrXW3r+eMFR?=
 =?us-ascii?Q?w/KPh6U+1CI/Q1slJwRTjIZZLMaUZ/+Kx72ogJk1CeHJ4CQCKU4bpvfB3e1V?=
 =?us-ascii?Q?zlkZ+WvXlIyLUsnV2MI55RxOApLCvydVKkh1tQCOh8HrZgbOMYGM3n1QzPX8?=
 =?us-ascii?Q?oU0JZ8yy6A9CDG9xWpf06HpOcRYVR+id5uZsyuBDZgW1bpDqn55YlLC+SkVv?=
 =?us-ascii?Q?Up4z1v9qtYtLAVaK67w+yr2sgpG7mzbR/2s3kDqtMsU0aW8PJe+G4KUwh4N3?=
 =?us-ascii?Q?uCy5HOzr0vRNtF/pz+tN1yG43l4VvDx7ve0C/+g0gDShzNnBfWS+wJNf6Mk4?=
 =?us-ascii?Q?7XHoUUXyJZb+KHcFnDjoUwNN4kPOWoUfbirn5+KnyzLi5bVuveu8LhOUGzX+?=
 =?us-ascii?Q?2m9WoAzdxHCB+jOX53CijLcpF5aGgxIXS4Wp0DFE+CboKbM2VUV+4GjIr+8G?=
 =?us-ascii?Q?ZgGCXLAKI0tZbrtsvFmxw8SL6B1/bDevegL+1++wtC+SDGiEOeJXfI+Qckjs?=
 =?us-ascii?Q?CSlFTowevwb4x0H7KkeX96DW8b3yjley26MyJPsexNJcpVsrTwpWdkTkF3hM?=
 =?us-ascii?Q?M4F89w6f9PC4mdQ9MgwrVnoCN8jLBRZha+SI21kGTG+iVv4gjK3SjoObRHRR?=
 =?us-ascii?Q?zPhHxo4VTY3/p4/PvoaX0fxLr/UyteA6B91Gd2f2AMwWdHX8X2RMk408wBSo?=
 =?us-ascii?Q?8j/OFtDkdbn/5V23YOE/IX6As12BXjQf13X4zrtBh06w4/bhH3sAsxWmsg6Q?=
 =?us-ascii?Q?Bsa3u9qLmn1ZD7rcQoQfArhJ2PQxqrWWDobtOnG3CMrDbx279nGCH47mJXaO?=
 =?us-ascii?Q?/SlHScwyiAjBWFlj6ujV0HHEUGNIRwpHFLlx02a3k9V31HQ3rA6b5N2+zlSu?=
 =?us-ascii?Q?KFwKbsyMGqwVyDMu4P5rdoXPQfbPMuivTWlWgpuwvQ7e/6b/C2ggi6HoJQ+J?=
 =?us-ascii?Q?1CQeljTTUdp3V8kCzM1U5cfCq6CUOaO8MICk/cH6r+xk7IrrmVqT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbbdd2ef-ab58-4a7a-c116-08dec7cf336c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 15:36:27.0320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rBJmvngIeJ6qnuTCw/uCVW6AAyXoLyPosnGJuix98KPKolUnYbvrqo5SDV0W11KNjfaBcdPoF3ZcXBqJ765X4x8y7OKiptz3X/AJWm/r22FRpZ2F6cndrEWBWkJf1A81
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7019

On Wed, Jun 10, 2026 at 08:52:41PM -0700, Rosen Penev wrote:
> Convert fsl_dma_chan_probe from kzalloc_obj() to devm_kzalloc(), tying
> the channel lifetime to the parent DMA device. Remove kfree(chan) in both
> the probe error path and the remove function.
>
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---

If use flexible array, needn't allocate channel

Frank

>  drivers/dma/fsldma.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index e4a3315a7d9d..0df09789187d 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -1114,11 +1114,9 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
>  	int err;
>
>  	/* alloc channel */
> -	chan = kzalloc_obj(*chan);
> -	if (!chan) {
> -		err = -ENOMEM;
> -		goto out_return;
> -	}
> +	chan = devm_kzalloc(fdev->dev, sizeof(*chan), GFP_KERNEL);
> +	if (!chan)
> +		return -ENOMEM;
>
>  	/* ioremap registers for use */
>  	chan->regs = of_iomap(node, 0);
> @@ -1200,9 +1198,6 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
>
>  out_iounmap_regs:
>  	iounmap(chan->regs);
> -out_free_chan:
> -	kfree(chan);
> -out_return:
>  	return err;
>  }
>
> @@ -1215,7 +1210,6 @@ static void fsl_dma_chan_remove(struct fsldma_chan *chan)
>  	tasklet_kill(&chan->tasklet);
>  	list_del(&chan->common.device_node);
>  	iounmap(chan->regs);
> -	kfree(chan);
>  }
>
>  static void fsldma_device_release(struct dma_device *dma_dev);
> --
> 2.54.0
>

