Return-Path: <linuxppc-dev+bounces-22372-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D42CD8CA8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 01:36:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZpK50tkwz2ySD;
	Wed, 10 Jun 2026 11:36:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781055385;
	cv=pass; b=Osuf5i1xUYnmGqi/Dwv+2NSm7sTPRiiW0TqjatIqEHmEBFYNJBXgY3cLNZ7aGP5biHmRw42G9cjizOCOdJ2xCILKuubZ2CN8koMjwaxSheDU8TCT+hbTiD/3sRAShH6VnJxa3emcfT+wuP7wujFSqP2TFiUHg8NB/6qG9s4thinX6erX3YC03PoElH5zqSKnwfX4ewGvqJDx+nDrJYJ2dnQPjMFNzOnr6a7mUHXokBmRyBc4C3HZSvYUxYwS7N5lCy3SzuG76y3gpMiH4s1S0vmxwsa1haq/zBqQBKBACiCGWyGSn7z45PREEJRo24agCdJrFhEtgsxwAeikd8suTQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781055385; c=relaxed/relaxed;
	bh=RNkzCEbBN0YhYHMENbI1gkIE12fW6IMc0wWT7gLN8yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EhGpegCQ0zv/CrNjzDFwr92oG+/Cfc2AJn4uQxom+zsbBkQzYvGBjls6vDCGHGD62xn9whN2+N5T0oUSFE5IcccR2bU3CTm/vKEBsatK1gtw37GZUz/evKYgEL5VMFsB8M3EAS1JNC/O/qg5xOOQi0BIT15Sceqbhw2MA0T2b/I633/QobpvnOdmLnlGhVvCccuP/UGusptZz/QCir/WToiuMEjM3ErrGCUyyXI8g7bZri56n5xdV4/ZXAAKbPFicUjJKXvj6ul75HR/M4E9zqUQVEThqirzzPXKrj+GQKI+zinnUfSSD3+W/f9BcdEugiBbL388kt1g0AzOW7brMw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=TX8iB0Cf; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=TX8iB0Cf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZpK40K03z2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 11:36:23 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HGa2W3ALa+i3EvNMNAMj+9L2viP7uFPwnJONoCaHawDtI9o/GJtmpPg6/68XMMiGAKaempVouDuXzRYBbuQTttsydSH0rFNVCr0DdR420yaN0hcTnl4xDsbmQCXpAspgI4vXSeptzc1i453dJj8i97pVJ3wE/HIfWys4XYoEZhMLIk2oXe0VDYdXF/tDBTU3cfH5CSkoBCEAWsE0OjEvL5yV5HgSQoxpmCI/agsyhoTQpFzAzApz25QHru9irE7LVLqBcEqHlb/86mEP5XFiQqP3F3f9///9EKfZeeoXoCUTTrHGkgUHC2AGmd7/Z1olwRe/PcQi8LWC1qwDXC6Ayw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNkzCEbBN0YhYHMENbI1gkIE12fW6IMc0wWT7gLN8yA=;
 b=JS+jkZiNwLv9Z4EJFQlSI3e4l+E47gqr8AkPCGMVJ3M4TW+JVDYgn5btI8CDh8BMgNX/ybvqEg34oFeUdtHjVk7gNCMzI+VD/WN7wy5+3c1F6Wm0fRp+u7Ed83iFX4lMv1Dkk+lY7CVsd2eJZyHLKCc3j9vVUOh8+bkpn/a4+ll01piykRpFeB+1ZD1cIvI3rIwozxLM06ICcu/v04HJ0o2K7nUNjivTG7aIgaabDMIX3tTk5z+zyDZZ/uSaATbw6oFkNF3pTZSY7RXyobEbTMhX6WI339N/WgMXxmpA693Uj9uqf1VycBkOrHY9YtJzriMEEG4KKQGFeeUPHE3Oxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNkzCEbBN0YhYHMENbI1gkIE12fW6IMc0wWT7gLN8yA=;
 b=TX8iB0CfPZgB6TnWPPnSYtERFOkAnQRKC0dIVyUB8DdKiJ7WQYAeMFRxmmFWXVCHMPTVUou/w7PknjGp3g29GHlOPcYCASxrPEadNx7FqI0xOk8FoiS2Sn8y28ZW5J/2jGKitEcjbJtXPeOPaAuQ2o5+YXzLme72jYEQY9wI3B9PWqkf0uRwOJe2arDAz2dKgxysqVWAH1dkcQe6X/NnlpDk5WHdHsIbkB86rEWVuYYBE6OuJPdJRrSeNq2CX8yetpPxSuxA8xQ8UBRoSZW483gXV9skURMng3iQym67rKYqX+fVkjavXmtIPkaqT3ICUvkoGrKwt2i61NBsCOT0Hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GVXPR04MB10564.eurprd04.prod.outlook.com (2603:10a6:150:215::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 01:36:00 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 01:36:00 +0000
Date: Tue, 9 Jun 2026 20:35:51 -0500
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
Subject: Re: [PATCHv3 01/15] dmaengine: fsldma: kill tasklet before removing
 channel
Message-ID: <aii_d2iifIoDetMW@SMW015318>
References: <20260609221926.35538-1-rosenp@gmail.com>
 <20260609221926.35538-2-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609221926.35538-2-rosenp@gmail.com>
X-ClientProxiedBy: SA9PR13CA0117.namprd13.prod.outlook.com
 (2603:10b6:806:24::32) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GVXPR04MB10564:EE_
X-MS-Office365-Filtering-Correlation-Id: 7da9badf-c1ac-4001-7d92-08dec690a037
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|19092799006|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Jx3eEHSMTHKwfTcxtSCDI4Dmwq+xdr9Y9mLglAoCZsGu4UORS2QAqRFb/kSX6PaT3/sS9ZdVPSy/V2/jknVaGp2q+pw/j2HTar97k8uLxuVG5G6+s1hkYsWZ/EvUWECL9F+Iyd8KKtZAwf+Zb3tNE80qwUapEZ3S0tYr4wYvR7TLe4KlUCvO7wDSuWArb5YRQwsvzJsBSyDNWUx9mKM/F/UT124oBnM5JWOVp/GOse4ibZk7G264UI8Gv68xP5Q1lAK5CIOUWCoZ3f5mJemmHLdXPxZqE/BrwXAhm1KJBGzVaQznss0hHb8RNCFWjS275aIXlpaJlyKx20ujCxkJMh6oc1MLizjfRaI/I9jfzkuN1rONUZ2P/qgk0c/PAoCr0uDl8ZJ+vRZfCW5yFW+eO79nFjkXi1LmkMho7R8Oxgs0TbMPHg/fh6utZXcHlFfuZWVWTp+I4QEPeGHdwaXya3KZTZ5blJBiHTHW2672R6WdATk+PUWUw93K4Yh+Geut0VHzhDU2BVRiVM+Yv4wydXkTn8o5aq0m+Nuwt38fkQmDg6Nl8TuvvV7rgeR7qTAQs/O3Hiv6f2eXrSwPzCkhgeC8W3TQStXdsEjL2wjzf2fhuqmRNvjpRgQrNSv+SP1EFRc8EMxEGuGoBKokSL0YctwYqgtDzUrXMUEI93W49+wcV862SmCfapNRG+Auv3bk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(19092799006)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xWfUij2NG4jJmomTiHC2Lt0bqJoRfizM7zKe3X9SlbPeamc7cF+A5E9ERgnj?=
 =?us-ascii?Q?WKdggLRp+p2eDYdsOkPKrzv/iD0yHOyhq9vMxgT8m58nqDadY/CAeCVw1YaD?=
 =?us-ascii?Q?wtWzLH5rKwRqkX/ZAc57zVcMu1EqZ051YYOjFKTnQckQ6DXmLru9SdFwixpC?=
 =?us-ascii?Q?a/MY0egmUuE1wSYyGrZ6z4yrUZmpjvEUiaBUC50skfARa/kn01J3TBjI0z6+?=
 =?us-ascii?Q?ZRsXsHL5NOiByk7wtn7ooGGPukSb2Uz+zRPKbzhlnbUww+8vljoWwF14AfBm?=
 =?us-ascii?Q?94infkg3EyibnPrlyE6Y0WMuGS4Iemq8xZ1GLbyWtMiFeWX1L0mZfKavywcE?=
 =?us-ascii?Q?RVWcHwxetz9sC1UFW+18u/liOZl+Cg3z8jIsPYTCeS/IZky4vr5Dgq+fSbzt?=
 =?us-ascii?Q?muIFLvkKGxBq/f2AQ4UQEzXIFPwN9aS82eMo6DPmK5FbTkAUD2phpYtZRKDa?=
 =?us-ascii?Q?3HvILHVNfJe2MSZ0vGfMJxRR86f+mtrycdWswDpjGiYRTWOdMwvdei8BCfbu?=
 =?us-ascii?Q?cHh6grqZEtMutK74gnl5vtkMI4T6iY5lBb7B8g3/3tfYTIqGeJTdbedsmWVg?=
 =?us-ascii?Q?b5lIPHikRXfXgbYxYhWprUIsvWYj2XQ/UzSo9tHPC+AM0IkPmSX7gZQxYjJK?=
 =?us-ascii?Q?iWx4ZqC2GNX0L4YBhwsKQnit42gHcspMnCtjibX4gSR+TT69K3qi6R1ih4iC?=
 =?us-ascii?Q?DA/JAIEebrG7RCMnB1G6KnBtHz4/Oj3D2mm2kwWqCqaZMoz/er1VfgNkM1jl?=
 =?us-ascii?Q?w/hCckaIfhpij68sc2b2Ie0DMZgSBt7WPov5/93wt3PHTtSWtze/A2lLubUW?=
 =?us-ascii?Q?kqFhXtX2WG8Uqmk6wbaivnrz0zKMHjizdFiCDW4UbdGhGwC3nUeYBTzLWvuX?=
 =?us-ascii?Q?tZefZ2PUsKaKkDaOHq2c8SpoQDyG5MzIaRly9jvigZEkGQXzfjxlEEKZqDvc?=
 =?us-ascii?Q?1z/XWxK12yMzWSXemO5LJvCcgCblWgEZNQ2TLZaMovjAu4YOpz/BbpahFB5+?=
 =?us-ascii?Q?1W+4Ao80tC5nIoAE/lw6Z3QooRVOye9b3Jhwv/wxTq05Lv4Xv9qlVg/pEdJx?=
 =?us-ascii?Q?Xw8LAXtD0DcgLldrFOARvuaCbL+wuNo27tDGiJ5voI4JSUGZL8c3JrG4rFlu?=
 =?us-ascii?Q?5KXk+LVzLvo0cdYILFtUS3Iic3hsUk3UxQmkB/ySDJwKQ5IBGri4oYAyvn2I?=
 =?us-ascii?Q?E+Jwu2RLX7VR4yeGW5ElSQKVLr1H217ohWCo43CWf4xn8LzqmPt8o2dnToVj?=
 =?us-ascii?Q?JFNR5OI+opnQNN+8uTS7ud+x3TFYpJFYwFDd41+PfCT9Wc/8DVCUoo9Klxuu?=
 =?us-ascii?Q?5WGvg4zZeKlvoNHOzCczrtdYOl4gYEL2cJ0cKdZR60bfH++OejXhOmZARuUk?=
 =?us-ascii?Q?sfEcOtwoZiGMm6ELugH3Aw3qNUKppX8f/HOmnZiZBTyhz2hwqaZaLaAqUhqQ?=
 =?us-ascii?Q?YdaXmZZz5Fhwu3Hda+5QRGms0oaxH1n9ZVJVxNbZY4/DDucjor8cWNiVEQAe?=
 =?us-ascii?Q?l4T0e+7cX9TyjYpyWgqDK9Qie8LlM1VEEgvDS4E97KEr/eZ5QK1DUmi1RuUK?=
 =?us-ascii?Q?ugReqQGK+uo2QGPbqJk01z7/WCJ1fA+PX6X9+6k06hvW1GyVv7lIxyc8wznJ?=
 =?us-ascii?Q?q5Yz6rbpZBzdgQAr2A7a4P04bavs+U32HysMZ/Nb7mYSqG417EofsOS27qZT?=
 =?us-ascii?Q?JVN3JwKSH/eSLYj6k/YPMM/ejn+gQNfVMyxvwmQHRsCajQB3Jf0lnpJpWymj?=
 =?us-ascii?Q?rdYTX/2xgeb0FjQaa91WcWYMEJxgPFX1ylku0XzAQLTuKn0ONChs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da9badf-c1ac-4001-7d92-08dec690a037
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 01:36:00.1869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WbC56Dvu4OV7dnAGHi+JJeBFYLfXgksZBy/qxL2BtrZ0lAjTSH78rE2MXnvRDfdO33yfzVgb9fz2kwgP+iwucXTSyIAhHtoaviXiYNK0eT/J9K+19O2aCd3hJrzs7BYq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10564

On Tue, Jun 09, 2026 at 03:19:12PM -0700, Rosen Penev wrote:
> Add tasklet_kill() in fsl_dma_chan_remove() to prevent a race
> where the tasklet, scheduled by the IRQ handler, runs after
> the channel has been freed.

Nit: please wrap at 75 char

Add tasklet_kill() in fsl_dma_chan_remove() to prevent a race where the
tasklet is scheduled by the IRQ handler and runs after the channel has been
freed.

>
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/fsldma.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 22d62d958abd..0e2f84862261 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -1205,6 +1205,7 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
>
>  static void fsl_dma_chan_remove(struct fsldma_chan *chan)
>  {
> +	tasklet_kill(&chan->tasklet);
>  	irq_dispose_mapping(chan->irq);
>  	list_del(&chan->common.device_node);
>  	iounmap(chan->regs);
> --
> 2.54.0
>

