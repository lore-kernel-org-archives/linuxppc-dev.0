Return-Path: <linuxppc-dev+bounces-22143-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F289CD6E7C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 22:45:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gXGjx5Zcrz2xdb;
	Sat, 06 Jun 2026 08:45:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780699013;
	cv=pass; b=PW+Ey8mD8zhi+d2ttQ7zvx/KN9/1mXCKuR+3D00k2TrT9QgpqWez4Afo2ToKxcv0qm8fhaUENymX357NZQpUmm3gJsDnkEGg7AQK3HUDAv+h5mS2rgB/0SXRpL07vq8wqDASMWlmbx6hCx1IQ+5k/C7KZXjlVtT4rjqZ0CGRNIa4LDxpPAbELms8kD1Eg8rvfeh8N9fq8wkTyB20egX3I9lOGUVogDKJXjICKrLoOliBCJUmXNkzpchJFgoIrYTJKYHk9DTc9MeCshfRxjf7+fWbgvhff2G4TubYMSUvDZDXX0Sw/gv340ex/B7/zMUgyqOBj+rP2OcdPKqL3c14Bg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780699013; c=relaxed/relaxed;
	bh=aI3mkGnXiqdnW9INK8xk/FTrSBHneMedRdvu9wX5BRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KyIs8BTRvaSe5VCQ2WJDKPqVr2YUhM2q3DW5UbMmFyOpnXaHbge26fMxYH9SjBlKWv0pUK4Jwlm/xe5EhRYMVdjzzSGWu1DGqSJQhoZLde9KPNAGzDI0028KATx1yU9JILli5NyzwzK8Zi2Rp/8HoiAE64TzA5tnmROORVCYZyd9yfN7HrRYP0261F3a1HV65RvMDyZBptZaXHjSDPWe+sVEH/7ZpcQ7FLkvQfqH40XAxQJG1G6M+QLdi468yDPYqp5UCSXnX1hRH4+M590HcpvIQdAN4hg1pMDbGkOSwcHKguVCnciq5ZZyDn18kZ8hVwd5qY10RXan7JwAapNlkw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=dyz3G1VI; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=dyz3G1VI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gXGWm6bvpz2xMW
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 06 Jun 2026 08:36:52 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/xepDT1NbZ6VB6YUgeN5SeYLagbu+V4GdHR110nAyt7cVfhb+9uvC9g/A0FJ5KISoZd5f5KXFb5qwGAdhOF71lzjdHBbzODa/MnoXo9iWh9WJ06i6+KgcNsAq7+6ANPvQboqdAn9hZtmK9f++R1Rddz/C5GHpfJB6GnpUjcBePxgSUlJ1U7DDZmdaCSHvEapRAVyEnMP2++zJqy38PkDt850nD4VtouXkREueTvMOgLrZzbUdl8sO1dnvEgvfWabxnHctUgLJt0p9GZ/iaBToICUPwqpDfYQRNHduqJVt/fbfJV6U3iCZe5sKgiMs0SmZ28F9crOOGSi10xKz1qAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aI3mkGnXiqdnW9INK8xk/FTrSBHneMedRdvu9wX5BRk=;
 b=pOCrWVadqA8pAXyEBt7UIufzlSlnxloc5vRB4GeVL3KV0uEvdh4wTq5B684ExfqvuWf743vgLC5kKYWQ0yM6ESf20QQ+nncvTxiQKNnSo+1slcM4JQnkJbrIxXgYhwaxSn4OH6RQKsCdnhRejbcGIZ4ZGuaNdmxNH2cjgqYK0rablsEB/CoaTfyTEFHA3zm37qljKcjv8QBo3BFC7qXN7NTncHObD8M1wPWbOGf8pZYBNJ9xK1kDHxY0TbLs3pfblxixKm/oNWdxuM9z8gli59IK8GLt0TBbIZSTqucXWqzu3R/1m9t5iHdyjJsng1tw0tN4R20ue71qU3KSkCor7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aI3mkGnXiqdnW9INK8xk/FTrSBHneMedRdvu9wX5BRk=;
 b=dyz3G1VIGJaYiBFDA4Rg9SYzphdcygdyqC+WLD9Xs+Ah/aoVJ8YmRySQRkLMhNrPaHrkp/KAUZCtOhiFj6qsu4/hJ7UPuYC/nhVfXiGiisQhrMNcPI+hwvP3QYNKyO5YPOeB23xSGui6sH9xKhhm4v3k/2gQb9ZWVaAk6+QUFdbIh4dALkfgtKty8hbdzhExsjgLlfkLJ8gvvGkDkNQC2BZstxOANdPO+hQsaj2AEhpLKncRNOeiPJp5mACRTMG+e9+hG7XvmUslYejPiaQKnJm8Z95YoXvtKc/zVlUbux7rMj2NE1H2wCpahpzE7JxmppgV0rxP8qbRVrCwHqC88w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB10463.eurprd04.prod.outlook.com (2603:10a6:800:238::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 22:36:31 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 22:36:31 +0000
Date: Fri, 5 Jun 2026 17:36:21 -0500
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
Subject: Re: [PATCH 00/10] dmaengine: fsldma: devm conversion, fixups, and
 cleanups
Message-ID: <aiNPZYzZRiBBZK6I@SMW015318>
References: <20260605220134.43295-1-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605220134.43295-1-rosenp@gmail.com>
X-ClientProxiedBy: PH8PR02CA0028.namprd02.prod.outlook.com
 (2603:10b6:510:2da::29) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB10463:EE_
X-MS-Office365-Filtering-Correlation-Id: cbc49569-f02f-41ac-3f60-08dec352e3b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|1800799024|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	W+mpzvnZpg3TQTkIF917YX5MJ3GE40bREXdGiqT+FvhDUqxSMBLd/4bUdO1pPRImf9sF8MCPrFd9sn7aIDMYuoHTPigvLXmq71q/IzQyJ2+yIzDK/5Vli6s2bNG+w06sTsrfGz9m/v4q0kUqVfUG2ogfTCVIbdR7mg9x/lLB0Y73ChK5kJQJQfID1uWnanYM0gHqkoIJAmXDlckRY7hDFM5lR7p+/LZmyZ6pRzBGZUM0sscdfgI0qfLdP2nnBsUj+MqM34WIq3j/MyWEfYVL/286alemTRTcF5kWTPX68Imrg5vHH4TgFXSTtiOw3uVcgEJty/iGWxzeWZLyYV3/Ud3+bS6RojAEwdqFQeh24kZQKGPPeDljSAVswvsJvXdl0N5M6xqpKUTuAidNMczncCopAGXfLl/gkv/hePOouiL23wTjWk/s02ZV545WJvbWeCf9KzzpHsaSQP6uHP8b4ZPAOv1qssRKzWvjxDhNOEZ4ZOEZDJU7K5nWaw8skEQ0hAWXuHrnrKFYebhd+Dt3S+b9mqmHa/TAySWXzdqIwA2YhIujGrQ+91ImMaGK8ownbd7YQ0f54r4/ruoBKcs8E+mlM6QaUg6wjhLBhBsf5C9oYVZ8ccIQn48DqjGsEJlzLx48TirPzUgcADUTqP+OgCPf7kpopwAwhAtIMA+T16XOhg36V66vydvXCmXW3AOY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SFjA7+nXlfjL/HlMnqI3+wzse2klNHd8WvYBcnf1wsRzbLcylf7ZtLhccByQ?=
 =?us-ascii?Q?MBCUiET+yUGBE9As1OH/nUa68dEGVgSqg/eJ0ONa9ZkQ7bllHzLyN3XbGUCQ?=
 =?us-ascii?Q?CotR2WRJxEWD8tFrTji5ZR7P/RinI6OUP1Lo5w4cZ5EZg3Y2s3Vmo/KbkNi6?=
 =?us-ascii?Q?sNr1++o9eWHVc+g3vNdRDaokOTXkckFs68o4wgkki5rH8EhMtrwPCfTcWD+e?=
 =?us-ascii?Q?5sbR8cS1LzhLnX3cfTI5B4lcmLRH77RNwr42d1QkdjFv9YsJ3M6uM9fuwics?=
 =?us-ascii?Q?zUm3SR1JfrdiM2PV4WXVuypRI+5qapDUcEdzIFkI5Zk5ApIyuJZE55/fsKcZ?=
 =?us-ascii?Q?Hv7YQrsS8f//eAiRbICVcfNPpmP+jhpxsls2slvPmVcVRAD09gd2y55qeefi?=
 =?us-ascii?Q?c6pAYnAbZLTlw8m5HihsoOaYEzCj81rEQ2W4HPjdIfukBwUTPHU4guC0q+v0?=
 =?us-ascii?Q?F4iXFvzwIUoZ8KpfXEtef9lE9zxg/WqvelXWkIls6e//Uv1Ly1mVLCTEGM2t?=
 =?us-ascii?Q?xnQvvLIaYXmc97pFZYnv17BdFAKCTzGV44brdYPssEpzBrBMIcbKqrom6Lsm?=
 =?us-ascii?Q?A4b6/icGMkPRIvPOS18pvdTsDzBK83q3aOgvD8gShjFBrVkxQk3Mf+qL99Pi?=
 =?us-ascii?Q?hypGxGZZrQI+OBLkmUSA5sSCdBGg6Lvm1tOJhab9c6sPEGguAHpRDEUNCqcc?=
 =?us-ascii?Q?pMXr/cUPlDvLguIutHVBKIaycIA3bFCb3DI9ZgLXpt9m/tA0wXwRRzy6VR1S?=
 =?us-ascii?Q?2NmCiUfAMKi5xjRqrNDosnfVJSNERRKAFabCYDITic0jKqB8BjumTkKHz3Ss?=
 =?us-ascii?Q?XLmAF73/snji39l/TjVYHvHC1Yqb9+r39NGBvKhRNdNaEOwaWpMUuxorFdxd?=
 =?us-ascii?Q?bjd5rkZlHw7ekMkp4xBUyyoiO/r3MtzL9aNzJQuUmtnGPWYmkox1IeD9blwj?=
 =?us-ascii?Q?oyAoSnWpRvn79GoalNCzu5gU2soTLbhn9MeVF2gMfql2BFlTmNOLs5RKncbh?=
 =?us-ascii?Q?vax2gPNFoY51G/APVVpqJmNQxke4V+s/2S3752/+bMmmHKMu14LK8zq/o0QC?=
 =?us-ascii?Q?kIiS/sd1cChYUf6tQ+0SwBOvDUTib9D18cY3XEn26zGWeqr0Cgxxit/2Nwnz?=
 =?us-ascii?Q?d7ctm3BkWEvWr4yStkPEoP8L0bkDS+JFhJowdvWh5SGjXFjiv0G9bfirbxUu?=
 =?us-ascii?Q?SswTpdUyTdWcznExUb32AQeupjGbCZOMYDj9nQrtdpc/eCt9oip8WG8dkecA?=
 =?us-ascii?Q?H5dfqh5vsfjGvJXYMfWqF3iZ1taZqVKxYKqxBWTJz52nfX41sXkuyPlpplVX?=
 =?us-ascii?Q?Yk7UvfRP+4bhI693Zm8bdCqHbrN9ChIe3ny7aV97EdPJouG/2L3cVN1IVMMF?=
 =?us-ascii?Q?FXXnGKj1eDd500auqaom2ANvIdZr7Vv1rg0NP/lE9HMbIQHg3Xaebx5aO+wS?=
 =?us-ascii?Q?92eKUqYEfniJUekmL0mEII86ZNQWHsL+O8B2ySlazdAYeIWSqe8o/Oed9Kp2?=
 =?us-ascii?Q?81sy/07zXzffvXLL5Jhfio66dIDVkod2uiqzdAsxJvEk5cf5YebZcVeD8yZZ?=
 =?us-ascii?Q?UQmRXE/DzoCZyEY+CECF4ooF0p3wlcVQxkuVnA+PC1ec7Qf/r3B51SxTGiIk?=
 =?us-ascii?Q?ul/xUSXtAmPFgRju5mLhURg6rqukONKZsS8KwL0h7kY0OU9gCwH89p3bFAP0?=
 =?us-ascii?Q?gegTjPT0rlYcmAA1AxWa9oqPsxmmmVINnT8qp4Bo+rpR90NX6upJ1xm8R++B?=
 =?us-ascii?Q?iDwQH2TyFRiKfs4zO0z44DHV719SEzGCMstthyOm/wZA4k6ZmR0x?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc49569-f02f-41ac-3f60-08dec352e3b0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 22:36:31.1234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cp+myD7hxCFup4uPV7Ub4Ymfo35eXhw6BsHDoczYnSEFae357EWQJS9KmqkZJMcNXuIpO8a806N9mn4RfshnaZd4ctQjsGmgd9DxwliXnvg6KFR79kLaZympb7U/jjeS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10463

On Fri, Jun 05, 2026 at 03:01:24PM -0700, Rosen Penev wrote:
>
> Convert the Freescale Elo DMA driver to use managed device resources
> (devm), simplifying probe error handling and the remove path by
> dropping explicit iounmap, kfree, and free_irq calls.
>
> While doing so, fix a few issues uncovered along the way:
>
>   - Kill the channel tasklet before removal to prevent a race with
>     the IRQ handler.
>   - Check the return value of dma_async_device_register() instead
>     of silently returning success.
>   - Replace the powerpc-specific I/O accessors with portable
>     generic ones so the driver can be built on non-powerpc
>     architectures.
>
> Build-tested with LLVM=1 ARCH=powerpc allmodconfig.

Suppose this v2, please add V2 at subject after [PATCH v2 ...]
Add change log here or each patch after --- to show what change in new version

Frank

>
> Rosen Penev (10):
>   dmaengine: fsldma: kill tasklet before removing channel
>   dmaengine: fsldma: check dma_async_device_register() return value
>   dmaengine: fsldma: convert to platform_get_irq_optional()
>   dmaengine: fsldma: convert to devm_kzalloc and fix error path
>   dmaengine: fsldma: convert ioremap to devm_platform_ioremap_resource
>   dmaengine: fsldma: convert channel allocation to devm_kzalloc
>   dmaengine: fsldma: convert channel ioremap to devm_of_iomap
>   dmaengine: fsldma: replace irq_of_parse_and_map with of_irq_get
>   dmaengine: fsldma: convert to devm_request_irq
>   dmaengine: fsldma: replace ppc-specific accessors with portable
>     generic ones
>
>  drivers/dma/Kconfig  |   2 +-
>  drivers/dma/fsldma.c | 139 +++++++++++++------------------------------
>  drivers/dma/fsldma.h |  35 ++++++++++-
>  3 files changed, 76 insertions(+), 100 deletions(-)
>
> --
> 2.54.0
>

