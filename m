Return-Path: <linuxppc-dev+bounces-22499-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FA5CD98CE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 15:28:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbmky1N0Xz3br5;
	Fri, 12 Jun 2026 01:28:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781191722;
	cv=pass; b=dAPUvVBfMgnTORqsFnvOYu9I0WCug43k3GmzxDlcVM4agqpP6YyQhwO05DCHBoTz9+m14l3hqxUT3lsPKSMFKP8H4JkY1mO7vn72n0UyMtyPXUCD/UifFMb5yZk0inBPpCsiPFh+jIjvTfxDeSZnnstH3MzzKo0gCVDPWGGGkWgNoIwTuSZZMo4iIjpN3bCb//SL0xGbx1yB4yMkc5u7Mn9wb3AaraFGP6Y3pTgKdeYReX8f+IcVTJJTgnXr10XbJY6fXEdSb7Wp/tX4wkzwAF10OB8DyQScESh3ihDKqKJz7GrosRtNlmzCDqCZkDrnrJjyiKbfez5ZjwJ04SeYXg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781191722; c=relaxed/relaxed;
	bh=ySvMtABBlEjtRszOF82cLpYKLRwzEmDxffEhSElt7f8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mORt99sBXn1qS/qEDJ50z6M0G+wazM1An+zwQhmgGgvRD8K/KA2xyFa40bQXRqi3WXaAfcrYS758fRmtdjAChdWKTNUHMw0NPBEL8nh/+eTnYzjMlIKe9qoKFlEMcwcRBEpu1/honk2SRGOdYmfkLVVQlY69WxZ2pmyT43luJHmD0ApGiwFWR7Wb2cNSY90Fc2LeQ57ltLWrZ8ZCbBDegzYgfnr7+y/iKF5gWbY1Yh57MogaWQfKTokHmB2zilADg/J/LznwOZhfxhkV8Cnx5ti1q+bjrYJYI9OKGia6qmjvLO9L1JLj7RSKzssED9v1qHqjx5s9XYgnqzWGB7lFdA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=jvNX7Z4p; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=jvNX7Z4p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbmkx0Twpz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 01:28:40 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FT8lX42yxl6Zug8LtsJHc+nugEScXr3wor4+2gbFsT0qIYl88OgrWaxmXvRAp0wOgsgvTqFy3lpjeyZK2pOXht0Syzd/P5P/XcGHBr2Dv6Vmb9yI6t+FK5CX0/sZS98Msay0w1a7OPpP9rzDfLUpMKqjSTWqUqcikrnduKKVgBxOhgp4e2kPF1w/vw4eXrhCalqRFixersimte0rsfwgihYwR/tF4EXbG2XzoWE/EhrQOhnrH4/OHr2zA+ZjZRPLZkbEiyw9uA826BhKKSXWoDVKLFbww8zyctAuEl5GsHg7PGh6FBwjUGnr2iy2AZo6Hru1D5boZqTOGOuXaTCNWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySvMtABBlEjtRszOF82cLpYKLRwzEmDxffEhSElt7f8=;
 b=A1CLIkBBStkbjNKClFNudUCM7PcbotybZA7x9NjjcOXqsGWCkCrpT/IzJWs1kQtav1WitEdSAasCWmSW5Hw1DuV1uTSUPy2s6adbZchr17sKRYrGDPT71+JGucPIHiFXufqEnFBnpDjcquhH1fZ2YGhMe6El0V1A+MyE5ffapv5736wUAOC9kzfODWj4c3LwNVybQ7G7dzjmE72pfpevkpbul3JIcnK8zHxLUVIPEgBXXUJBDKXfEEmkeWISRpXBi53kn6arrPT3aSX2NzZa9Iy0mLRBm1712miLTeS2GV6uvIUO9TkMmU1tHnCGGTxlUs4Y5I+XX8+kPChWt7OAcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySvMtABBlEjtRszOF82cLpYKLRwzEmDxffEhSElt7f8=;
 b=jvNX7Z4pivQZO0yRQE414jcuOkVv71iPLefi9eNyadc0weRGUwweYtCksJiucu4Z+3M61iWho6bynhsrpx8cVLV4o4Cu3+S4KCY7j/DbIOEsyQPcpiQme0LHTBoRsqcs/jyt+u+bqvbb4S0Ypmwj64T0mrjlhDvb1URkUX3nA3tTUguKFZxvKr2gafsZrYcgy7NguRxUUtBS4YKKKcBvaY//W/8eIFOwETpuHZosZVn1nIUKxnDO6T83pC8oCfRcEk/w4vSJzGFqVNUcDkbE9ZV8MM2tmrD2+TAnqhFYxzKu9adYdGv0N601Xv+AJSIgkWR8wTixVKBUFwN3bF5wMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM7PR04MB6981.eurprd04.prod.outlook.com (2603:10a6:20b:103::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 15:28:17 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0092.016; Thu, 11 Jun 2026
 15:28:17 +0000
Date: Thu, 11 Jun 2026 11:28:09 -0400
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
Subject: Re: [PATCHv4 04/15] dmaengine: fsldma: provide device_release
 callback
Message-ID: <airUCTDEwh0WoNIb@lizhi-Precision-Tower-5810>
References: <20260611035245.13439-1-rosenp@gmail.com>
 <20260611035245.13439-5-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611035245.13439-5-rosenp@gmail.com>
X-ClientProxiedBy: PH7PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:510:339::21) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM7PR04MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e193013-8b0c-40ba-92e4-08dec7ce0f99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|7416014|19092799006|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	5NS27IvLjINB1pO7kLfEOSdxBPcOLKU5MK8B9tIycUxO3jekD8cAk5Gl/CXi3ZwvSPcrKEqYLyL91PMMNxC9EM5aAiwehqOx1erJ3x1HjhDO6bmkWoFBZ8w8bmFLuFbyu9d8Pf9LvqViukUn7rvQ2M4UPJ1fDM6CiXXzn4qw/PCkU1KCsAzS5AdVwWOv84aeIQhbanAl08uIqd1i386aI8R0+hzaCqJ5mOac8kKd4xI7wkaO7A2PaJLN3q0C0q7exEYP8p3ciIwxinVYyqVKqD+qbt7HUEBAkVzlBNsrVE8I1hUxXeYNmUbnUo8CIR4yERa9D6PpdoZp7ZgjO993DzSL7XkDYIQpa8+s+XOjXly459ruyjS8nRrjHQMuK3+p4bEZT59WSNu4LcTFdtfoITg0ZzLfcXSz8Dh/wiUAqOHC4PxdtZ5UXn2ctMO1jiS+y3G7+hkdygI3PpjScx7SDO6E1rcuSyyTVkHfChTfqJ+SiGyMiUZqvTrK+7rAfoTZCMxDRm9Owhd7ycZDOtAgGCjgqkoL3w1SvwLNwz/52Gm3+FD6vhZ4WM5M5xlyd/E/Q/jBNND5zQy7Y6WzQpDqM1adbRZI1uuNWFGh3sF6xh9LtYToLNKtdidH5+iMHIEHeBBJf8OD1oyNhSQPaZShPf9cDB27I4gt03zL10jhNlsQPYtUgFkPOzTN8xIlsyH4wq0cG8A+G/spRXW52SS9uQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(7416014)(19092799006)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4NzSiiP0w9m4jIb0ufNDwW4orqe+osQjA26jZ90itUDE9fl7R/1n6kTc8cLr?=
 =?us-ascii?Q?i4MlsCmHQF8Xv7WN4HWOHhn+dfQAjsXj2YPt7VHzWH0GnWdJUIRbLxFbS503?=
 =?us-ascii?Q?Jfoh6Lt2+TqWFYKqKxPhOpD97VkPhP0gKxcfc2q3CvKzaoVvWj6BpXTbGowa?=
 =?us-ascii?Q?g1NwmCg1Uv8v10atQXyiP+xnVGSZtkT/KqZTXLFHZ31dP+jsIiZRndCdOQrb?=
 =?us-ascii?Q?KySR1/T9A2wBTPYcjyEAsCGVLGZDxWEicrbnBQ1SDoYlb743l8JjXNjEc0wZ?=
 =?us-ascii?Q?v/K/910tADBMh+RZJCiHFTj4CXfdFkP592sCB+4NdvqtG0E199cEp+5miyYk?=
 =?us-ascii?Q?MHuKjH2LHR7HlWvXeJO8PLthzim+s4LYZCXJojArjMxmM44s/fZwfhLcyMas?=
 =?us-ascii?Q?msbckJa+uh3iGw+qOmw1cNwlrB4bLoGrcBriMAuEMOVPrxd7NgCaSEvw43Cf?=
 =?us-ascii?Q?Q1jmKLXM/0S1TEowkEWmm99qaTjb3/8yyiQvCQ7jyYulQ2MwipMTavLnMXCt?=
 =?us-ascii?Q?giv8KDEzOwL8gTEaH5P9v59q+C9oCb8wUfSzHDi2s8+WI9nJF+ZAzpmIodQ/?=
 =?us-ascii?Q?ZGNMmN3dUVujKupNzTB576NYqvfk0QxjaowkZZ0fgizk9NI2+jVQ5VWfQ/8l?=
 =?us-ascii?Q?qcc3RL/6HgC/0TzMlNgX8o69kt/qoajvJoNDzBjsAsQAQMyHcfbfIfARGm0o?=
 =?us-ascii?Q?KjVrY58bfA8vosbU3qqngp1je4YASTF1D+ZmdxR6FGFTpdRzYKUIJ+k99Lo+?=
 =?us-ascii?Q?Mtl/7u56uSQJm6hPgI1mTcyCMwIaJ5l03sgZ9LTZ8+X504gUcKqQyE5bRpfU?=
 =?us-ascii?Q?EOe98qu+3Loxiw0CAzGKSpNBgujDwetRXD/6xVWPDFbgKVO+0fKxzIAGIs1A?=
 =?us-ascii?Q?c5FwH2/K2xd3UINhnCqws81yJwIugC7YteI8x2AadlTiaaUqH0bDnQpsOUcn?=
 =?us-ascii?Q?3RcSuJr1+sf8fFR7iUzX3pcU/8qbMzuCG8G7gvpGsCYbxt4m90MIJTdcSlno?=
 =?us-ascii?Q?YyeqfpN1gzVBTloehgUm+9w/rAoyaZYGtDI0dnXnvdL923qZaonE10pQ6lSs?=
 =?us-ascii?Q?PoywfY6cWJNqKuRuMJygQVk6oMFVzbgUQ9KjlRpWvJygDwdsfi6q8tdhSR7R?=
 =?us-ascii?Q?fIR3DUlbjwawj0rHPNOtgUlOzAWQ4/xkd9PNSTjC8ZmGW4upmrR0dXYLyWxW?=
 =?us-ascii?Q?N2QSuUzrH40l2fGZtToqKM6Vlwv1y1Ryi29L6pENhfKKxPNYCcLkqiSCsz//?=
 =?us-ascii?Q?o2vZw/RZuCOO6LQdSEC296phx9Lb+z7vzncbEyyCVjinFHtKEdJxxCHomDDV?=
 =?us-ascii?Q?G4lJqKOINQLnz/jdfDPiFaz0nmz7FPxtyn3rxTSQ+10fRdtm/EwmbZzO3sKu?=
 =?us-ascii?Q?GP85l7GZcVYwUig+pxkjKMaTVtuyl4EMMvwO8noNodHWlUzGIktyB8mBLw9l?=
 =?us-ascii?Q?L9j3zZp2Zt8OCdzZ3tkIRT89mFNqQkRHQEDodRqUUI7GrgoNfyYd/Zrc0p/J?=
 =?us-ascii?Q?isbt+IdXAluMLP0zgmwlpbx5fDHq/gp76hVGCdLs7LZfZgEsvSgO2EkoOXYP?=
 =?us-ascii?Q?h1E7NGJZl1Rwk9Z+WThnkiI8lWDb4P4uyoKcsm4jprpSqNUN++p3LLwrQ22o?=
 =?us-ascii?Q?x1+/KlDzxDKiK495FpL8OGy8WvkvNxDqvhJhEB+ggYsLNt3Yj978rG1va8jN?=
 =?us-ascii?Q?6bI2NL8ngPnaRAz9XO3BWpanZlW/xbKF+RIMfXvhGgoK5NCewZF5IjN9nd9M?=
 =?us-ascii?Q?hs2uPAcyO2okEBEFa3Y3jtMPGzbZZj8=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e193013-8b0c-40ba-92e4-08dec7ce0f99
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 15:28:17.3968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mDIzC0XyMaAlavbLniBapaBnyFlQZHm6f7LNEu9Pu8YjpK2llFdbo8OyOCwavCm+RT8++9rlUlzh6igzND14/PVmubb8QkAr+uieMnfuCXptYDbe3kYm8sS/niHEyGZW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6981

On Wed, Jun 10, 2026 at 08:52:34PM -0700, Rosen Penev wrote:
> The DMA core requires drivers to set dma_device.device_release so that
> the container structure is only freed after all references to it have
> been dropped (see the comment above dma_async_device_register()).

why not use dmaenginem_async_device_register()
>
> This driver violated that contract: fdev was devm_kzalloc()'d with no
> device_release callback.  If a client still held a channel reference
> when the driver was unbound, dma_device_release() would eventually
> run on freed memory, causing a use-after-free.

new some convert chan[] to flex array.

see
https://lore.kernel.org/dmaengine/20260609194217.76E8B1F00893@smtp.kernel.org/

Frank
>
> Fix by allocating fdev with kzalloc_obj(), adding
> fsldma_device_release() to free it, and setting device_release.
> fsldma_of_remove() now saves channel pointers and frees IRQs before
> calling dma_async_device_unregister(), since fdev may be freed by
> the release callback inside that call.
>
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/dma/fsldma.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 1ba10d065278..43d817f6ded1 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -1219,6 +1219,8 @@ static void fsl_dma_chan_remove(struct fsldma_chan *chan)
>  	kfree(chan);
>  }
>
> +static void fsldma_device_release(struct dma_device *dma_dev);
> +
>  static int fsldma_of_probe(struct platform_device *op)
>  {
>  	struct fsldma_device *fdev;
> @@ -1257,6 +1259,7 @@ static int fsldma_of_probe(struct platform_device *op)
>  	fdev->common.device_issue_pending = fsl_dma_memcpy_issue_pending;
>  	fdev->common.device_config = fsl_dma_device_config;
>  	fdev->common.device_terminate_all = fsl_dma_device_terminate_all;
> +	fdev->common.device_release = fsldma_device_release;
>  	fdev->common.dev = &op->dev;
>
>  	fdev->common.src_addr_widths = FSL_DMA_BUSWIDTHS;
> @@ -1316,19 +1319,33 @@ static int fsldma_of_probe(struct platform_device *op)
>  	return err;
>  }
>
> +static void fsldma_device_release(struct dma_device *dma_dev)
> +{
> +	struct fsldma_device *fdev = container_of(dma_dev, struct fsldma_device,
> +						  common);
> +	kfree(fdev);
> +}
> +
>  static void fsldma_of_remove(struct platform_device *op)
>  {
> -	struct fsldma_device *fdev;
> +	struct fsldma_device *fdev = platform_get_drvdata(op);
> +	struct fsldma_chan *chans[FSL_DMA_MAX_CHANS_PER_DEVICE];
>  	unsigned int i;
>
> -	fdev = platform_get_drvdata(op);
> -	dma_async_device_unregister(&fdev->common);
> +	for (i = 0; i < FSL_DMA_MAX_CHANS_PER_DEVICE; i++)
> +		chans[i] = fdev->chan[i];
>
>  	fsldma_free_irqs(fdev);
>
> +	/*
> +	 * fdev may be freed by fsldma_device_release inside this call;
> +	 * use saved copies of the channel pointers afterwards.
> +	 */
> +	dma_async_device_unregister(&fdev->common);
> +
>  	for (i = 0; i < FSL_DMA_MAX_CHANS_PER_DEVICE; i++) {
> -		if (fdev->chan[i])
> -			fsl_dma_chan_remove(fdev->chan[i]);
> +		if (chans[i])
> +			fsl_dma_chan_remove(chans[i]);
>  	}
>  	irq_dispose_mapping(fdev->irq);
>
> --
> 2.54.0
>

