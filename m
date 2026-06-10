Return-Path: <linuxppc-dev+bounces-22375-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F89CD8CB9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 02:47:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZqvD24pNz2xjN;
	Wed, 10 Jun 2026 12:47:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781059656;
	cv=pass; b=MQiPJXODAqrwsUIbIOuP02TYf1NN03sSNscloZaN/KqWkwHtYZypNjFF2/61u0aNnfoFQiRBD6O8bwjfDB0qwcEuqM1l1jJgNqji1j7Qe8JZlBk7RwCp8EunC9wICweX7FX5mzXBbn2T3k2sbhDKrk26WxLTgipF1npAUgxz5b9+YSSuWtf53/vC3PnZeptCvvd1lrstMn3SCPeMk5b3UZR1klinp6iHQJToJTafxo2M4/maa+tNv6N7Tgz2nZegifDg6UwVOfvwzMSc6xQKU0abtsPLwaR/iIrQtxOJ071dtl5MjXNIp9Dd2cHjTPfI4BLpibIcPhrW9rXa6ik16w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781059656; c=relaxed/relaxed;
	bh=eb+su4749vefTGRGMVqPuYfnXZ46ydCYl+j6Ij6YvZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NMtYj39xDkP+DN5FETa2666dC4VD6bALlLr4AJ26d2SFUYjygpiK+Klr+3XwkMZG6wugCX4Lm54w3+LVAw1ty4+Q8ZVERL5Q5oBrrJapEqu9ExwlzdhW4/qBAETo04MOj/+z8GvvzSwKxHKOpPr0Rll93Kv/cjrWiORRGG2vgnOT0o0mnRPSzbfp2Yf5vLNhiuL3htpms8XkXxfozXkbRjiw+a+sCa+WBOkTeOa6app28r3jJ+WXjfpNnYXxMED1u4Qc9mZtNuchg9Xnbmz/8e9b2U93SSCI/EoCC71NoHFfk4ZCg8ZZt+HIQxyScpcq2nZKUUj4bGZPse2YN6l15Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=wWfProsa; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=wWfProsa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZqvB59b4z2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 12:47:34 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k55US6QZoGehiIxR+eTkMRAM6MTOVdiRQIIy5f8zPwLJws9EzE4A0tpmbdeCJqWBvcmBKiLNv7PgHp1EVh31rVef4Sp65or2FdLEr3ZOkkxpX1FZaHmvCtiNJbAovAmvtdWZZidvB0o6vSxnt8lvMayt7f5dos4C+eOqewHdCuOVhPw9LevTSYjsKcikpNOiqsdbV1HpaFS5QQuzbHV7XeRcpXijeGsYLXwoKjegFMMMSB4JrZ/x56w4zdeIasNXFrb6bQ1H6tZsprpvjrdIEcneuKDTjU29F6n9+ht/rRHEKugW3Y/kg+3Ux3YZodJhRUhzNwsCwdiMBCmjqcvndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eb+su4749vefTGRGMVqPuYfnXZ46ydCYl+j6Ij6YvZU=;
 b=t4ambrK+6ZPYZBq/1tkxAe2JnYIAkGTFrmiVBzVbDivvs4HSJpRD+x4tvVms9nPgT+eC4Frt5D5Uu1WyLjZLug5OCmxxIds8DzUyKyhlr2HGDnB066A9XwsyGDQpwK8/1EoCduUmLn0T4jy7x8hcWYwWxCGSYAupBsoPN/rJhCktJVlWHmEmkD8w/r5CiJ3G6IoNOOyrCYN/gU6NT0VGt9OpyyNeoI06tWZD8Qyv9USrfIUFNGTEOj/fmnrQCy87qvp/nugn79LNW72vG4QUnQZZutrgAuM4cXd/KNZOWfF3ZLbwfzYWvorcc3TZFWTE9TtTOleIwiiB+X8BoUDEZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eb+su4749vefTGRGMVqPuYfnXZ46ydCYl+j6Ij6YvZU=;
 b=wWfProsatH02K0Sph1ui+8VPJuV58VTn2jsPEv/qXVr3OYhOAqC3KxqdKfd7+iPe0D3g28SDzETv0YfHwFEBBWo/IJ2YmCKj8aprRwlwbjOZ8xk8zhhJOcTUCqMMviHn8Rw37WTkqQjKixUvNA8TuFF2ik+fazvjqBxPjpozhR68JlwhtMSSB8+Ax93FXQcs7qHobODn5oL6iZJMxqQEQxfjJtyJJBzCIeF16RVwK8ptFPvfnnBShGRA4dDrrbdelnoLMuNPsjJbfz9U2jxGRksN+JhB4P9SaF3qCwv0NkjqhhA3xmOH8kcxyTiTU1/i7LgldZmDwNWIbIfxS0PsLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VE1PR04MB7406.eurprd04.prod.outlook.com (2603:10a6:800:1ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 02:47:09 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 02:47:08 +0000
Date: Tue, 9 Jun 2026 21:46:51 -0500
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
Subject: Re: [PATCHv3 03/15] dmaengine: fsldma: halt DMA engine before
 freeing resources
Message-ID: <aijQGwzQpi8oTGIU@SMW015318>
References: <20260609221926.35538-1-rosenp@gmail.com>
 <20260609221926.35538-4-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609221926.35538-4-rosenp@gmail.com>
X-ClientProxiedBy: SN1PR12CA0060.namprd12.prod.outlook.com
 (2603:10b6:802:20::31) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VE1PR04MB7406:EE_
X-MS-Office365-Filtering-Correlation-Id: 6753c411-2592-41b6-d128-08dec69a908e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|19092799006|366016|1800799024|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Jp2KEZhf9DO5gpjXLPmKXyQpt0H5wHtZKlvg4yCq19nX1FpcwxU6aMUM1c4kQRN5vUimynJacstL1ZrCx0aZ29sKP/vF0SdjejAL3vkqsPLrPo2FgK0b0KHW2tYpPrB/AS7rJ3tD3G5j1GQGk+am7Pl2nC+p1H539TbhgIlPbfAHPHyQvLt72DZepVS8/9i/criCnpksaCXVuTs21YQgROhQBv0gE7Q9THgh6PWMunWxgqqRZCkMKJSYYgpfqlRq+qu+kOvwenV4xo0BYKkVKQRkIzauHzNFvgbLy5T190hoSaLY95XEtMA65rHi9/TvhjlXa7pVbqA5wUyIHfyEYH5aOl+O55oG6GcCPDCIHOQq/lEpdEbYw+oXVXwem5nTUMcD4g9lmjInJrC+fYRs7VS59c7TYvdzbRKrGQiU1HxYkd08MMiFlXvsLPl9kXAFcIscb7Jgv0//lPSxG19Uspp7xwfEqothAJFTWJ/ImLG899EMzMBsiAXw3Rh9CNj0otMNHP7YzD08SlPz4U6ccRQj94yOit/VEgvanUSKnXyP860fWxHAD81PEhkkQmpdsER55OFQr62EZTS2kL9Zvcfx1+U0qF/pvamY0A6BRzwT1XZn2/H56lNAdAS57cWKVymqJ2YW4SeVLHmFQiMlZ1EE7XH6Iz1+Qex154DRB0hk4rwY2nMF4im3htMpvKxH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(19092799006)(366016)(1800799024)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fRdndRmq/bz9fHk8Z2PaQTkUH4DuuMhRg0i6DKBX6E+2ZnrNh6OzP/gz99vP?=
 =?us-ascii?Q?Qw7otiYPxQ5d3NskjwjVquIS/QblJ3cTsj25E3BTls/mTarAidQlI9e9d2f2?=
 =?us-ascii?Q?VRVEp7LWSUzxUHNxv7JRUeOHYB4WlzGGSNlZI+lPjAg645/+oYY/ieQDsGpu?=
 =?us-ascii?Q?B+JwucfIM4U93kUDnLmuiXYOL1qzGy2F1bfm/Ej9sCFqMypA3AV9kSKzyd03?=
 =?us-ascii?Q?6IgwKWUnRG0DSTGfdaJQggEWFliSdkEMqjc01okPzSg0WaYuroX76zShiwxF?=
 =?us-ascii?Q?i7/Rr+DSl/G4tnmUYKhMWZzoR4cUa5pU7drzkNfFf7arTFwWdy9+TiX/1l/A?=
 =?us-ascii?Q?7xQ1Gz6Rcn0E0UgBBciQaIwjgplKK8Z2OrmJ/dv30i22V2zV/c2f3beaP1UZ?=
 =?us-ascii?Q?tTp3aLaQFGVSWDVvvAICoqifjuG72OAwxIiHqXsqu8h8JvOghSMGTokK2O4P?=
 =?us-ascii?Q?LwOcTsSJTdwGJH22Q7kgtDVHbXWbAJE5fyWb/bMc3hNparcn6mNhW1LmG0ri?=
 =?us-ascii?Q?vUwssS29KiK2rO9kHaBHY2YnB0MuWEUKjByAs8U6X4QDDWpOaB0ffqheYXbM?=
 =?us-ascii?Q?aqFNmDHpJxI6icA9ZwMoNb8ZEuKvRZPbPkgCWM2IUkyIn8Jk+SGfJg9Ud2W+?=
 =?us-ascii?Q?wjq8g+OsyxKueTWaVSiP9WSOTv7ZL5upnMaesbv6o4dgqAb/mr/bSJ9mp75j?=
 =?us-ascii?Q?fALWpxchbpGCd4tbdYwycRG0yw7T38jDoFbpkOaG1aJCsOjhAqPJDtZIxpPq?=
 =?us-ascii?Q?jS2TfmpRezc09gZHPo+bCkj6aZQ5SxnwXjXV28WCYjZrksxQLqLur1toTVuh?=
 =?us-ascii?Q?3DNl0aghWK3J9gkbWeStgEoYidQ2wSYnTm7mlI00mXs7bj9xt0elowbNYBLE?=
 =?us-ascii?Q?Q3RkXdN/HFrvUKjuXZlIlZzCXLbSEzfJNFQn4/URAGBQhas+jN17xf44J+LK?=
 =?us-ascii?Q?eypZdZJg+wKCR1GTK4s/hjBf4ReNMJO885KKEHO1cDhfD7ngSEFbiq+SMJ5X?=
 =?us-ascii?Q?bPLKLIAELPVU8ukyyfzktz126546sWm9JCucAYC7083NGWwoKh4fNic9H6vH?=
 =?us-ascii?Q?gSqfR9R0B78JZpgwrSm9EkvPZewttTsvxfyyKUCZgd4Cu2TXiYk2A1GBaKjl?=
 =?us-ascii?Q?u0xfecZ6y8zUBDktP1lEDIQDfKq64Qsrr2Jp6PB6e+AWD5GyVOFP3itf/GoT?=
 =?us-ascii?Q?lx513SLO01DkcJ5SIhfjy+xgF0jamSYRD6tK6pD2EvWP6eWbU56sMmYb3knE?=
 =?us-ascii?Q?5fuoo7mYon1YwbqMUtKFSIuHtSGfI3OUTDEHOXZKbzJ36c445BsUt9JFBxNG?=
 =?us-ascii?Q?mwtb+3VP6WwLosFBGdUDSh7gsAVH63fqSE3FnYUEK3BTnDG3gXvk6LQUCu5m?=
 =?us-ascii?Q?IXfVwVsbUBdhhL1jncPQwQZlD3WFPQ/iXBG8qOJG3YQD9R8n+1zI0xR0R4FV?=
 =?us-ascii?Q?2rvgxes2JnP5yH1wLV3/LKmUeEfzJDzkgJi8Ca4iMR3lgXZlwrlRwrXM+k5R?=
 =?us-ascii?Q?f6Xr9ggr4VmXB32P79U4cOtE7RVPZre8d1FWR972U8ESe63Ez8bvvwTG6C9M?=
 =?us-ascii?Q?6f/SCj/9ERrZP2BEJOz/d28DXzbJPih89xW34W32M1XOJQSZx/G9PrDAaW+f?=
 =?us-ascii?Q?EfJHV1UiIIHMp7Z9YRI/zCutPvZ6xQcpEmKMad1tNPijpQxawPcjhC3Dujwv?=
 =?us-ascii?Q?k8/7MiUpQoqbycWgEtxmvRXWRBNpPcQgsnzYAC9m8TNzfM4sDM7dhkjtRBRO?=
 =?us-ascii?Q?p4vlao4DJsTV06BBd6oE9ePN0fNcY99hUMQ5w82ncfMFcmbI+dXt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6753c411-2592-41b6-d128-08dec69a908e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 02:47:08.8787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3+sC0Vm3b10nRv90Oc6W2614rNGRM0SFiW2bANhYoJGyN/TFkrwYv68ALPcZWsj6VxiWilEFbwM9BxRU1BkNpF8UllwkgCdxNWYoMM5nW53BlPItLOV7YBcgqw+vgAa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7406

On Tue, Jun 09, 2026 at 03:19:14PM -0700, Rosen Penev wrote:
> When a channel is released (fsl_dma_free_chan_resources) or the driver is
> unbound (fsl_dma_chan_remove), the descriptor pool and channel resources
> are freed without stopping the DMA hardware first.  An active transfer
> could continue executing in the background, fetching descriptors or
> writing data to physical memory pages that have already been freed.
>
> Fix by calling dma_halt() in both paths before cleaning up, matching
> the pattern already used in fsl_dma_device_terminate_all().
>
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/fsldma.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 455d21d738de..1ba10d065278 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -748,6 +748,7 @@ static void fsl_dma_free_chan_resources(struct dma_chan *dchan)
>
>  	chan_dbg(chan, "free all channel resources\n");
>  	spin_lock_bh(&chan->desc_lock);
> +	dma_halt(chan);
>  	fsldma_cleanup_descriptors(chan);
>  	fsldma_free_desc_list(chan, &chan->ld_pending);
>  	fsldma_free_desc_list(chan, &chan->ld_running);
> @@ -1207,6 +1208,10 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
>
>  static void fsl_dma_chan_remove(struct fsldma_chan *chan)
>  {
> +	spin_lock_bh(&chan->desc_lock);
> +	dma_halt(chan);
> +	spin_unlock_bh(&chan->desc_lock);
> +
>  	tasklet_kill(&chan->tasklet);
>  	irq_dispose_mapping(chan->irq);
>  	list_del(&chan->common.device_node);
> --
> 2.54.0
>

