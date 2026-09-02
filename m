Return-Path: <linuxppc-dev+bounces-26448-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE8DC61DD6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2026 14:53:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZm1w0jwNz2xmh;
	Thu, 03 Sep 2026 00:53:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788360804;
	cv=pass; b=l6M0KIJhVER3qG4+u/s/qeBWH20iWp0GgcBcYfTzzYCPK3MptcEYuEl7V3ow/+LrE21aTs+dfwJx0F3wk8Sw4l56ZiIYSWHlL1EP4lxzoZn7k1BDLnz+3xdlPh1i4nbplzBxdxk7HQKycg7IVbvRelE1Vm5RVXnfMZ4PnO/MQFbwwHdwsQmVuvPbN2VrlDb+mU4P4V+ucueATpKoAkHVEodmam7qBpjrXnHj4mn7BMH8gOBkBQvwZvj+eLg1aOkDPMugeBiy6ZKVqLbYFj3C3VFfaBvbgZGxYMTUsE65qgQKhNYs9Jlqpk14Q5+bSWWI4l9AguqhwV7jGd1l3G2uWg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788360804; c=relaxed/relaxed;
	bh=wH0xGxqxvNHvEanP2Bcv8vpG82XKS8V8/8SXDNRwnV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X5Brs9b4h6n5DyGIRYrGBRZZVVS6aQw5i4yMMas34kjcHZvIismY4DLmIVe9nrdcu49lpkcEXygFyCrtGjm1MOZc+4D4/Wr6U91jyT9K8fR1QgzkexYat4zgWyrNSf7d3ikBdVHbGum1s589e8SKfJzixXHe/B53bN17ehhbcpVq1VnlKQFd3xBHsRp4JKTecevkOAN1U3ckDlR+uYOX2WPumL0UWP8gGscyrLpCqiygrvBfIcL2zb3LBoE+4ATPVmF1ARMU05ZxhcrCMKabTmZVge3FVmzeVcXns0tg2HXGrOUkJ+gf/0mOcqOPYCqNvUUKiDj3N1znF6ytJV3NbQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=sJGzFwjJ; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=sJGzFwjJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZm1t5FJDz2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 00:53:22 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kUzbxafE+cF4rrKNy44c2np8BpOhDHf22hAtXl0H09SutGbnndfXOpGBimHvj/nkYleojZVOLLbtAx/STQE/ZoxCpsj+JQdXfVicFkEQkOqsoXCN/jCrqkPoUz+dhO9OzFgcsewKbwVRfOz/hxKBOMSTf/K0KKF6zLc3a7xECG37y09lNb7jdHXDF2ntghnSM43rtUUH3BiYg4i1oS9TwjqCvvawLQRwdLd/RrTieXEQoJNMjcJoOcGZ3ke406ogMHy13FPLqaI3tH73owFfBEd33FfwfwNfhkM6FR/eAf/9tYQjrAf+ggJXWz6CeAMFsPYWWiU9WR4X4XSPYtVW3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wH0xGxqxvNHvEanP2Bcv8vpG82XKS8V8/8SXDNRwnV8=;
 b=y7K5TKXUk2KvRFgLDb0UvCMxvqGbOWPWOfQK/Y1OeOU2QQSF0dywGlXdtxKKJv/R0d8OR5zlvE+xZZPFZ9a6BJa9+FvRFzLL42JfjOdyDls/pUtDckfv7H5oOQwuwd0w46dd/0Ka2fTQxwDsu4u/4wDRDbmKGCIkmtG6RiqLWNTdjBWlT66bT5lKOyRceNB9EKrSicG+hO5Q8JkBdN+qP87MAFycWoqo0Z0l8J9LvL564phn6aYkGP72LHC1HNWJiAtM5Q3Hgo2+vS31H6LZcfwicHFPuNBXqlkZ+k8q1wT5w2r53Bu98h1zsaXt6Cu1YjWpCSIakArH8vV+XEAtGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wH0xGxqxvNHvEanP2Bcv8vpG82XKS8V8/8SXDNRwnV8=;
 b=sJGzFwjJEMnTnfCyCasAelMjjnl4RYmfi89mqDmFNns1eUdQgiNd+Z+SbW94yKHJrr+q7N9DxCKw7g/pH0NtmwH47GGRNeDvXhAGvpepfVJ4pq9+BF3XzqZkUR6Xty325ZS0zM9ys9Hp0UjSFmjlvtuz0BvmThYobVJx9wreHbFGKb3EZ6RMgmZ6d0yD7EhlqYgQoCRz4dkgAgsmpL/8KZqNrLu6Yv9k5qPVkHuMBIBXsJyeOOfrTVVscRGO5T1axdW+sNy4TwQDzEODuzf6VgUob/NPFb3BxN9aUzuDimtqid+CXoaKbzIlEAwPDVzUarool4l8WYmytDgRFLdRtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB8PR04MB7003.eurprd04.prod.outlook.com (2603:10a6:10:11d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 14:52:56 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 14:52:55 +0000
Date: Wed, 2 Sep 2026 10:52:48 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Allen Pais <allen.lkml@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <kees@kernel.org>,
	Zhang Wei <zw@zh-kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 06/34] dmaengine: fsldma: migrate tasklet to dmaengine
 BH
Message-ID: <apg4QOg9qN74cEuL@lizhi-Precision-Tower-5810>
References: <cover.1785183549.git.allen.lkml@gmail.com>
 <cover.1786384168.git.allen.lkml@gmail.com>
 <a9c4d258c73c2d7e3c23825db272cdfeacea478e.1786384168.git.allen.lkml@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9c4d258c73c2d7e3c23825db272cdfeacea478e.1786384168.git.allen.lkml@gmail.com>
X-ClientProxiedBy: PH3PEPF000040A6.namprd05.prod.outlook.com
 (2603:10b6:518:1::55) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB8PR04MB7003:EE_
X-MS-Office365-Filtering-Correlation-Id: 6761eb67-4ab2-4d2c-26e5-08df0901df4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|19092799006|4143699003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4W3vgROAVeP0CAiXPXyyP4N+0DXpBZT2SwDdkR5JHkofiR9ave9gAArnBymjy1naPVxE0ek0Tr2VVy1yppqKgzh+j6o0vZ2+K715gC1Q837mxR457x1Fq6//V/1RN2bQ0Y1Kf0SBHHI2Mef30I2X+JbUQUzTGy8zkS3hIYF2rgMFEM8A9DWjbDohZ8ty2C6qS3gNhzl3FVkwwPK6yn8Of5jL3aEs3ml+H0wAXnsFGaskOasN0Wn2wH7HcScfIYignK/YTmp3UZ8ohZSNStzS7dHykLtUqrGU2sDAficVkA07utvDkIqhZxY36EBePzzKjKCyWC4rQ8KDCq+sd92o1KUr6vLqp3hmTaNTSoE9pKky5mAPhCiHVLbDrLnnGFwe6gKBsJM953T5z53IWWRRxpxszT/WK1kAAgQ8RHnMwAvLebAskwvVFtJ+qUcx1epHkmkUJMO4H0HbhVWvgNqZKaTy9fkU1H6o8CSkuoaSkBQaAYpwIB8gNv38ndEjV2pShlwcTmsaSfStGgtUJS2AlpwUhJVw+gODpqEDIK0yVAuI+nB5XArDJZfYwaVAAQsc7frgv5xH08dr9wKdIq3j1MCcScz2vOnhUGGcX7mHW9HUCOQM7uzIQJv+CgxUpMW4l4QOQGXzqVVZX7XcUBF1R66ZeTpJy6HRaMVblXuK/qQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(19092799006)(4143699003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F1Z6oVVB6Hn7tilk+YZ3gX9orR6S3bfe4ATUnY3iJ/46kMoakG4E7ouSvQEp?=
 =?us-ascii?Q?CqgWBWaLZEE+lu3qZr6oLJX0k/fDkaTqPWr5qY4U0x0V2D8bKDBvZ2i51Pmz?=
 =?us-ascii?Q?cKx7yZjR40JaXbCokNLT9pi+qT+0sIYdJchjPzbwnqRa7Gppo13dZkJS+0UY?=
 =?us-ascii?Q?mfNYjEVNA2Ggrp3RnUZEFwCGY2nIP0EFIpOlFhsmEnNxj/M68HcuAZ/bxKZg?=
 =?us-ascii?Q?D2w5Srool/Lc5LLkDTLw8xGfdHOTjXz8+JK88nP0V+PAERIYxiLAj3IAaulD?=
 =?us-ascii?Q?JPUu5piRsU6gqpUKpCD4D6LIAKeh3hJ5YMT3XWj62F4mg2+ip9C6VmHPP/4w?=
 =?us-ascii?Q?QAawfp5G+eJyUMLi6al+3bGtfloMADVFnSqTxMjXyJWqzMLvHuZeilUQ1O3x?=
 =?us-ascii?Q?j5LHgMZdKmh5u55lj4iaHaq1CGgStNL0rjmOjAP5OB4Ec9VirlKArAc1LOhj?=
 =?us-ascii?Q?9Ys5SDjhRydquiADmxZTC2IX55QCXYRI1prqochGjWameLEFE9Epo7CH0t2/?=
 =?us-ascii?Q?NXzRMmItJTre6Dl/n7lDdyOoNj6wBQSxiSAxU82zzdXEnhFS/J98e4njUP0n?=
 =?us-ascii?Q?RZyipkmVhJUiHoe4VCSXQndzHgNG/zWRVYeqv8z4IZcWdVmeEgHL4J+NSmuQ?=
 =?us-ascii?Q?Ck+iQC5G5qhita5nlcn82TyvF4u7br3AIiVK9/fhc7MJaZtOFSVhDB3jqjw+?=
 =?us-ascii?Q?rRBY/bAmbGP8cQJJPoLVHr47qsfwvcQGDVo/ie0OGZPycVvmxik1XcaLgowP?=
 =?us-ascii?Q?ElDz0BWmr1lfC/10HlmciqhndEUZ+Ysi6uOCibaFpiTk3bUjsZ1kIXqKsP3n?=
 =?us-ascii?Q?3T8+ECBcIWfnrspM4r+q2SnRJxlR+mJHRbiSELA7q68bjnL9lbw0TxGwRvaU?=
 =?us-ascii?Q?jOwN5kxacLNqjaEoO4U9uBec3oA5uuixoCy1+LK4VlRFH4oZGN1xWwcxrkUh?=
 =?us-ascii?Q?EUXHyDZ6XhAD0N+UtI86Q+LF1LU+oAi5SO7LxaIsS4fHkqr59xtvE/F8r+qO?=
 =?us-ascii?Q?uFh3FAnV3bPyHB+ruUc3Z8R9c5g63yPVvvmgI1PglCe0anATPOciAJ2TtTQ5?=
 =?us-ascii?Q?FeP0Hn/PBdXECjt2EU/G7tdW+Medtl8of5r4bnPMLLZ4Iu5ZAX2dkAyGr2+J?=
 =?us-ascii?Q?bcVXG32U0/0tkgVyV4Leaf7rpK6vHZHMroUcpsM++2zW6HYFi8XAa6YNipFX?=
 =?us-ascii?Q?+Nw5t4go/nDc3F+UOsF2a0ai6dshiCrHHDdyBs28oS7CRLSwxJVOnyAZzgb/?=
 =?us-ascii?Q?TAmoe6Ng3eR4rGo4pJzz8HwlYF0gsEzp4tqj8fIZRFDoExdXBgdxcupslc/R?=
 =?us-ascii?Q?KOzCBxi9HVsCh8eIFKM22h+/hMEN21JUObuB0RyjCjgauy1e0uVDh62ODvzO?=
 =?us-ascii?Q?CjX7lpvJccHBvLqaGDZOKzFDkDtVzP1CRYdmIw9M33S+45cHXwHEp3EztB8Z?=
 =?us-ascii?Q?YmStRAnesM5Z6oQr17YvahrpOczSvIEs6ocdEMQ8NN1yOIVv2dhane9Demak?=
 =?us-ascii?Q?IMSg/VWkCAtyW7LhwkWhdqesDLyrp3e+cFRxJ0oLn0Ad6x/dCQ0id6S4U3VP?=
 =?us-ascii?Q?vHhrWWkWjt8Cf0jzVwyLZYLNAvndauukV/LQ8n4U2wgH5hYqrqmCclQMKHfD?=
 =?us-ascii?Q?UnA7p7pdJ4gpZv04KDRpNYR6CVfbybnLflaJ88EzNSYojp6sJ3NgpUMWyUU5?=
 =?us-ascii?Q?ExuzyqwxcKmKmHa74CwGS6zl5GIdiE9xlT0fnE3C70qAe0GiJPSFrHTGK4Is?=
 =?us-ascii?Q?VxRgYuX5XIyb90jGQthC8Tjn9fKRmxE/3kiK+TFjMOuY50AHaRJg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6761eb67-4ab2-4d2c-26e5-08df0901df4e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 14:52:55.9293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1aeAFsD76xq3GUGJtmMleldnn6favzm7YjhJcyey3OlxK2Dap5lE7pIPXJXymDTeK4vCCBf7zHXLPv4H8u40WhBC2JBiPJHy4feLjOXe43caZEACyjang0G3aWogNt2X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7003

On Mon, Aug 10, 2026 at 11:09:07AM -0700, Allen Pais wrote:
> Replace the per-channel tasklet with the shared dmaengine BH helper.
> The handler continues to run in softirq context while dmaengine owns
> the common scheduling and teardown mechanism.
>
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/fsldma.c | 10 +++++-----
>  drivers/dma/fsldma.h |  1 -
>  2 files changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 22d62d958abd..f52547611db9 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -968,18 +968,18 @@ static irqreturn_t fsldma_chan_irq(int irq, void *data)
>  		chan_err(chan, "irq: unhandled sr 0x%08x\n", stat);
>
>  	/*
> -	 * Schedule the tasklet to handle all cleanup of the current
> +	 * Queue the BH worker to handle all cleanup of the current
>  	 * transaction. It will start a new transaction if there is
>  	 * one pending.
>  	 */
> -	tasklet_schedule(&chan->tasklet);
> +	dmaengine_schedule_bh(&chan->common);
>  	chan_dbg(chan, "irq: Exit\n");
>  	return IRQ_HANDLED;
>  }
>
> -static void dma_do_tasklet(struct tasklet_struct *t)
> +static void dma_do_tasklet(struct dma_chan *c)
>  {
> -	struct fsldma_chan *chan = from_tasklet(chan, t, tasklet);
> +	struct fsldma_chan *chan = to_fsl_chan(c);
>
>  	chan_dbg(chan, "tasklet entry\n");
>
> @@ -1152,7 +1152,7 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
>  	}
>
>  	fdev->chan[chan->id] = chan;
> -	tasklet_setup(&chan->tasklet, dma_do_tasklet);
> +	dmaengine_init_bh(&chan->common, dma_do_tasklet);
>  	snprintf(chan->name, sizeof(chan->name), "chan%d", chan->id);
>
>  	/* Initialize the channel */
> diff --git a/drivers/dma/fsldma.h b/drivers/dma/fsldma.h
> index d7b7a3138b85..cab33d010d51 100644
> --- a/drivers/dma/fsldma.h
> +++ b/drivers/dma/fsldma.h
> @@ -173,7 +173,6 @@ struct fsldma_chan {
>  	struct device *dev;		/* Channel device */
>  	int irq;			/* Channel IRQ */
>  	int id;				/* Raw id of this channel */
> -	struct tasklet_struct tasklet;
>  	u32 feature;
>  	bool idle;			/* DMA controller is idle */
>  #ifdef CONFIG_PM
> --
> 2.43.0
>

