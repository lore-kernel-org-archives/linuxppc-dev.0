Return-Path: <linuxppc-dev+bounces-22508-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9EEBCD98CE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 15:43:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbn422dccz3br5;
	Fri, 12 Jun 2026 01:43:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781192610;
	cv=pass; b=blg7Lm3hVgnePuy+HEuRMWYVJmfoRbkcISODRGY/4NpnDnHKBjGjfOJDHgYrRm7DOY8vW7bTVJluPUR8/Od24VAzDy/uHfeNDG65lD2cMVgrKaKocx6zaVKOCln0vXQVWhcqPL+ccZZNrMsPo7yowlyc8D756UVj35RlOEJ81YCW+LXGvfLo1u9veTyeEAkL9hV868mi+ff4/uRGW699saWB956+5rFXS0tIF8VesWo64IE1cMqS0n3s5U2CuwSoD/p2YK98IbEwsgNnU03nkmxJn4LUXfTB2fNbQdpFEwT8f1A5XT+VBUeTXqT4WoXIrftZJq9oniiy4Lbr2zf6LQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781192610; c=relaxed/relaxed;
	bh=4Je7aBgNmSqWX0PXbaGQAvsh28CNXmd9SpmBq96rpao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nthORw3C/FXp1cZJFmD2dZDQMs3G+nBs0EjFsNWEaMEYjpzbcLjK9cisitOdZjMku9BfCiAC8DSup3mPwGpfYTtyR+TNqEsGtj2T7H5LcoGHzeCqwvVqBSzb9atuAC/rsUMLv4XmTlsP4vlDx1dKb6NqJmJJ79QpNe7gPIXuf7oQdPzSSD/ieZFEm0aSfV/nAWtvI/cHqYtiapjz8HVThxjF3wWvgWJ78hap3REL2fWBmbBEHsui38TwEYUjTn2mw0Z/WK5vN6rAV3JUuoYoC+byOhCrlf4p8fX5wIdd8Q3gmJcUDBaH95K7sBB37hhGlhhVb4USCrGktLPZZMf1VQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=sc+05EOv; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=sc+05EOv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbn412bQsz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 01:43:29 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UYCPPVk/xGnwWEYcq5G780i1zbV+krJI/JcB2Lq/xfV4p2CdSzVeSD9LY/gyHkse/AF6V2UJ/q3L8Ks6dJOVWLC7FDgAtH8+7g6hhDz2eluN5lp+iGzCQ/GKVtgVc1hXlK/PJZtk0LHH6mzgVFcx4biiY4/PN9Y9cwxN4ngxSgQmodTCrKBX+ialeRMx3oZKogw0uztHL1k2JJk1pyVHejSDx0l/UsxS3BsR7gFEAdqvNljvr4IrV3En5XinTP5v99EuLlzI2bFd/rnES2mM4jR9WKYxnXk1a2ycLGs4RIGu6chBJwsfEbrpD66tjjYurti04InCL9qiduh2qtKW5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Je7aBgNmSqWX0PXbaGQAvsh28CNXmd9SpmBq96rpao=;
 b=xjWFn9RhPWgwZavqOewBgwgJqymZJCesNfqPZpaRS4rNN+5p6DhKPGDbNce+9Fxnn2sGxgpaJBGmzhmB95L9L4XY5lUKJ50WRKptZYhzQZ7xxe5tk10TRKfcjrHO7IkCSaCNA0Jdw+veHxFdr0PLk2iDAzmZ2Gu4ibV0oCzOL/lWLJUfa9CndfFWgVaTXdpfTQDhFeKH0kunLIXdYZI1UcfCeBonUmSy9T73ZcixoVq7pT2MuHqJy79eTJ2FtR0ZxXt7YHnvwinrgWECWhiTZ8CLMPuvtjSHImdWkQ735oHklOnWzYhJHdQmOJ65okJT4g9KaMSHs37eRuGLz7InFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Je7aBgNmSqWX0PXbaGQAvsh28CNXmd9SpmBq96rpao=;
 b=sc+05EOvgfsf55LmX7wc5kQ1Ns+1mLS/4aE2sH9wE+UQUaNd4xnlV2DUAdeti2neT7rK2y40YwpMW3vcVJSyy5R0gDKiGs8WtAyo5GlrcsUcTZZojM6t0bViYV7yNTTdWF7mVuN4qtF+ssowIOj6YFo/es3dNlxdSLblidV1ZLeUjfAHAXqZYNZPF0dbwN04RTkDErzTfZFyzdbrKICVMrL31koq/vGQzYf8pB/U5fL6pyP80jQKoy/tgwhyzx6ea//N3vKTvtVb4K6gvmlfVnvQwfsAGCJVGWozvgtvYw4OmwhOx9uuT9AzXNbHaC4asvezaC3BnEF+8OPzuQfrhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM9PR04MB8258.eurprd04.prod.outlook.com (2603:10a6:20b:3e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 15:43:06 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0092.016; Thu, 11 Jun 2026
 15:43:05 +0000
Date: Thu, 11 Jun 2026 11:42:58 -0400
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
Subject: Re: [PATCHv4 14/15] dmaengine: fsldma: replace ppc-specific
 accessors with portable generic ones
Message-ID: <airXgsh2tsB9qCZ5@lizhi-Precision-Tower-5810>
References: <20260611035245.13439-1-rosenp@gmail.com>
 <20260611035245.13439-15-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611035245.13439-15-rosenp@gmail.com>
X-ClientProxiedBy: SA9PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:806:a7::10) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM9PR04MB8258:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dd09333-7958-46cc-31bc-08dec7d02105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|23010399003|19092799006|1800799024|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	Iawi5O0Zu5/JQKRQEZMp3OrVBH/HrmleMc3MP5nHt6Fn79EcnxKmDq6FLXJ3poD1V4eguq8W75yN9VMapfDuQziZFAi//nlCAeSMOabuIdqi+FF+Yya0lmva3y0JFXOXC90FYX0D8KRxYTxrhIhss7XAMhGYjZXBueBcphAjPWCxv1PWKHV42F4Yx2e7jH5nL4X/9fPhcj6RYt+kFXMZ0cqzt0t6mXGz+uQzOhYBKDvJe7CeMQNsrFa0CcQ5LFVcc0D2GOxu1W8ExST0NnUrFPNJVJGXmd7XX2svHWlT/LY9UxxFTf3nVX5vbwa2gcOWdT94Z9KruYf+7G05iNN5BXP48pQWYrPDL889IdVpyAlmok+ks/4xEmjlfU1xa5EeEeCdgHusFYlpO1uXiL9tqlee0s8LL6Tu1Ft5nOduxb7hRqHSuUXV96WIH9qrWC46q0S4DdiGB8v9dz0KBIihH/qfz8sYALoE5Ad8Xr7dmdHI8v0X/j/A1Jogx1ZNJo+GhljppVtci+u0zcaMo4kojJzrhFDsAZkSEFomnCvm928mlnnFdu80Z+3EJkghSRheGz1htbEfqHZCTZtgVVPneFZLMDydyJ9WeBbDiPplNwkoFiX7HJ9Y+TQTWpSLbU5h5p/cyxu+oDWVfBiWj/cK2nmy3Mpi0ecYSKhQUfbfHOLkUgYQQNYldzn8GutU2SZf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(23010399003)(19092799006)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i6bnUhMwswczSrgx3FAfFLbAnR98V80FO1ByYD5Fv+xYgpU0sf5RxXxA33Mu?=
 =?us-ascii?Q?AaGfFavvk3pFh1AMnmAqWr1j8yTmRJRO2irFT4xmB9uRbgGKAV0MC0mQNA2W?=
 =?us-ascii?Q?VkylLUO29wnMhkW9iR4oNRY3SRKq7qihXHxFKpLAh/8U5VB6HTTu+FsHowkI?=
 =?us-ascii?Q?cVxqnZP4XJKMH0idQxMrFBxWUNSlyFMOqQCNXsSWv8qXTh0dp8uQEzLpZJLK?=
 =?us-ascii?Q?E0zntxooMYwvJnPGvmzT2Arj1sKp3YoDG6gneJ+4qUh58fUk7KK0iW22urFE?=
 =?us-ascii?Q?yNjpOab1OFHE+gCA98icRSU713hGdS54q7L1IFIhuDVhWKMMwMe/hP1HNsg5?=
 =?us-ascii?Q?J/zxKbzcFdahQjzYJq8XhpNQfGvlCnGtq7kG09UpEbcPnyPOgoEiPFUQ1+Zr?=
 =?us-ascii?Q?0MdpmwU58yBJyMH/jYTqg3lwVQ5UuCpn8ZarqDGrUFHxb/bp4BL8u/1F7lsj?=
 =?us-ascii?Q?DJ306wZ9NtYS5cvxRykomMYgQsovVYVtat9ABytKBn2vfGlHemYICjJXCaaX?=
 =?us-ascii?Q?NJXAbYJsenqTQwvNbiAdqgq6SP+dq2+zqg63xAaPvaTpAHbv/HSf4VKhfKoQ?=
 =?us-ascii?Q?6kj7E48aG0WmBLUN5zU3N4lIlp0PoFSuyr6Uq6TIoRiRnr0CAoCBsrz1382o?=
 =?us-ascii?Q?pQW9fmtRiPqyKDnY2m0Bs83mzPAl1XzZBv1HEAp13k5XuVWv9C40LxaVORI/?=
 =?us-ascii?Q?75TFMTpRlPz8AHtxs4JOPiRGwGSSiBcdjIBqL/CjzV0Fm4X7Qk5z5NwwA8sm?=
 =?us-ascii?Q?rvYOnxTD0gyH+j0oOPlC+Lc6YAGps498O+FsTiJeHetlkuWyVBZxli8unrlX?=
 =?us-ascii?Q?NbdGrcs2CHuvpZWYAGIllRkEBbFC6e9MfQopzKH59zra6C40d9jy+b8PwkBY?=
 =?us-ascii?Q?Yx5x9vPuFDG81dPGkQLRKotQfPa3xviJ8ia7HuDdOPLFE9BzBeYecBDp00JF?=
 =?us-ascii?Q?Ur8LIto7v2H77SrUVn0pmFzRlToXnAdIS76+Zb+IyPe0to4s863vNQEwNaxO?=
 =?us-ascii?Q?LCAeijfBjOlu0Tz2GoeMH5+AwdKGLP7ba5q/mIhOoEzTrhjFkQA/w+haKm42?=
 =?us-ascii?Q?P5+S6X1XEpYB9JtRyfOh3Iu2DXuX3HPyIvZ8WNXvl9HtfsEHrIvOKgcdCCGc?=
 =?us-ascii?Q?8CvHSQvxkm24jtl8s+mNmHgv6jtdStcHTpIVwPWb7M8p9bkhiuB8baXrYaO4?=
 =?us-ascii?Q?3bkoWTgWo78LUSDf0szOOg9W9G+588D3w08OHF4rJD/gzd3a9dK9WaJws5Yz?=
 =?us-ascii?Q?BldWjwoq9qaSO7+43Ckg+atNE9jGxtrnXPRibYkEv0Ppk/W8KLxUw0zELn7O?=
 =?us-ascii?Q?yfrW/PdX3G2CdqygOoYQub5dp+xjmdzvg59oH8fzx+pTuIe62BYBXKvPAR4H?=
 =?us-ascii?Q?3LR+thI2izR92Yf6DY1H/q0xX3OC2ofv04l3KUAm5CP4+iY2aDbfjMDykb87?=
 =?us-ascii?Q?Rs1gMJ/qeVnusq+X+v4W8XPpoO0fHsEae7XJWt9b6sg05dSa0b5H7s3abMeS?=
 =?us-ascii?Q?Gt9Ba/Yx21ZQUbJeE9+5RHBaJjoyScgoZZZaddgksab+3j4DCNclaAQLwWq7?=
 =?us-ascii?Q?z8x14Kz3pRphLdQ1waZAqnBTISxBxNxK5VRuvqvaW/EHYuaZyLtl9tsyCZIV?=
 =?us-ascii?Q?W3L+v8W7pXwJhLxAY7HntOj+xZCss4DLgkaKvxcNesMEtmpBUl8rAzEtHY6X?=
 =?us-ascii?Q?fFejkgt3Rr5TwUcTk7vV/ur3UA9x0gBBTjNjkPN4oZATk3H02g7CMiIoe49G?=
 =?us-ascii?Q?C2LEHjWZplkY3WFYKSIDQ8hRFYFkheg5f+6qNvqKjD8twGf+1vvh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd09333-7958-46cc-31bc-08dec7d02105
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 15:43:05.6275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RZ1KaOPXZNXUpSx+gP9FEyIuOkyf0O/dXiIIxk9CIWfFbpZAjksCkXaI8YbvfUpkn3Kb360Sw2tZuhguWPYVVb9XuHXHwQQt1RLRbrdtrLICdfZqSOip2RzbftHcbPNM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8258

On Wed, Jun 10, 2026 at 08:52:44PM -0700, Rosen Penev wrote:
> - Convert remaining in_be32/in_le32 calls to FSL_DMA_IN macro
> - Replace __ilog2 with generic ilog2 (pull in linux/log2.h)
> - Add linux/io.h include
> - Expand non-PPC accessor support from ARM-only to all architectures
> - Guard 64-bit generic accessors with CONFIG_64BIT; provide
>   emulation using 32-bit accessors on 32-bit platforms
>
> Add COMPILE_TEST support as a result for extra compile coverage.
>
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/Kconfig  |  2 +-
>  drivers/dma/fsldma.c | 11 ++++++-----
>  drivers/dma/fsldma.h | 35 ++++++++++++++++++++++++++++++++---
>  3 files changed, 39 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 302021540d76..9b13e7aa31c7 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -206,7 +206,7 @@ config EP93XX_DMA
>
>  config FSL_DMA
>  	tristate "Freescale Elo series DMA support"
> -	depends on FSL_SOC
> +	depends on FSL_SOC || COMPILE_TEST
>  	select DMA_ENGINE
>  	select ASYNC_TX_ENABLE_CHANNEL_SWITCH
>  	help
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 0ee3d719ae95..157db416eaaf 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -32,6 +32,8 @@
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
>  #include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/log2.h>
>  #include <linux/fsldma.h>
>  #include "dmaengine.h"
>  #include "fsldma.h"
> @@ -266,7 +268,7 @@ static void fsl_chan_set_src_loop_size(struct fsldma_chan *chan, int size)
>  	case 4:
>  	case 8:
>  		mode &= ~FSL_DMA_MR_SAHTS_MASK;
> -		mode |= FSL_DMA_MR_SAHE | (__ilog2(size) << 14);
> +		mode |= FSL_DMA_MR_SAHE | (ilog2(size) << 14);
>  		break;
>  	}
>
> @@ -299,7 +301,7 @@ static void fsl_chan_set_dst_loop_size(struct fsldma_chan *chan, int size)
>  	case 4:
>  	case 8:
>  		mode &= ~FSL_DMA_MR_DAHTS_MASK;
> -		mode |= FSL_DMA_MR_DAHE | (__ilog2(size) << 16);
> +		mode |= FSL_DMA_MR_DAHE | (ilog2(size) << 16);
>  		break;
>  	}
>
> @@ -326,7 +328,7 @@ static void fsl_chan_set_request_count(struct fsldma_chan *chan, int size)
>
>  	mode = get_mr(chan);
>  	mode &= ~FSL_DMA_MR_BWC_MASK;
> -	mode |= (__ilog2(size) << 24) & FSL_DMA_MR_BWC_MASK;
> +	mode |= (ilog2(size) << 24) & FSL_DMA_MR_BWC_MASK;
>
>  	set_mr(chan, mode);
>  }
> @@ -1007,8 +1009,7 @@ static irqreturn_t fsldma_ctrl_irq(int irq, void *data)
>  	u32 gsr, mask;
>  	int i;
>
> -	gsr = (fdev->feature & FSL_DMA_BIG_ENDIAN) ? in_be32(fdev->regs)
> -						   : in_le32(fdev->regs);
> +	gsr = FSL_DMA_IN(fdev, fdev->regs, 32);
>  	mask = 0xff000000;
>  	dev_dbg(fdev->dev, "IRQ: gsr 0x%.8x\n", gsr);
>
> diff --git a/drivers/dma/fsldma.h b/drivers/dma/fsldma.h
> index d7b7a3138b85..01f93123b233 100644
> --- a/drivers/dma/fsldma.h
> +++ b/drivers/dma/fsldma.h
> @@ -232,17 +232,46 @@ static void fsl_iowrite64be(u64 val, u64 __iomem *addr)
>  	out_be32((u32 __iomem *)addr + 1, (u32)val);
>  }
>  #endif
> -#endif
> -
> -#if defined(CONFIG_ARM64) || defined(CONFIG_ARM)
> +#else
>  #define fsl_ioread32(p)		ioread32(p)
>  #define fsl_ioread32be(p)	ioread32be(p)
>  #define fsl_iowrite32(v, p)	iowrite32(v, p)
>  #define fsl_iowrite32be(v, p)	iowrite32be(v, p)
> +
> +#ifdef CONFIG_64BIT
>  #define fsl_ioread64(p)		ioread64(p)
>  #define fsl_ioread64be(p)	ioread64be(p)
>  #define fsl_iowrite64(v, p)	iowrite64(v, p)
>  #define fsl_iowrite64be(v, p)	iowrite64be(v, p)
> +#else
> +static inline u64 fsl_ioread64(const u64 __iomem *addr)
> +{
> +	u32 val_lo = ioread32((u32 __iomem *)addr);
> +	u32 val_hi = ioread32((u32 __iomem *)addr + 1);
> +
> +	return ((u64)val_hi << 32) + val_lo;
> +}
> +
> +static inline void fsl_iowrite64(u64 val, u64 __iomem *addr)
> +{
> +	iowrite32(val >> 32, (u32 __iomem *)addr + 1);
> +	iowrite32((u32)val, (u32 __iomem *)addr);
> +}
> +
> +static inline u64 fsl_ioread64be(const u64 __iomem *addr)
> +{
> +	u32 val_hi = ioread32be((u32 __iomem *)addr);
> +	u32 val_lo = ioread32be((u32 __iomem *)addr + 1);
> +
> +	return ((u64)val_hi << 32) + val_lo;
> +}
> +
> +static inline void fsl_iowrite64be(u64 val, u64 __iomem *addr)
> +{
> +	iowrite32be(val >> 32, (u32 __iomem *)addr);
> +	iowrite32be((u32)val, (u32 __iomem *)addr + 1);
> +}
> +#endif
>  #endif
>
>  #define FSL_DMA_IN(fsl_dma, addr, width)			\
> --
> 2.54.0
>

