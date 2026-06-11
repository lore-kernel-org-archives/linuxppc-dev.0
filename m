Return-Path: <linuxppc-dev+bounces-22498-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F397CD98CE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 15:20:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbmYZ4Frbz3bpP;
	Fri, 12 Jun 2026 01:20:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781191234;
	cv=pass; b=YKfezsLxJzuPzjSSFlz9UKqsPviNMx/FZejsg14Xkaj8Zc8g6y45dHXct+YzO9YbWKd+uV7UYAfw+lE4XAn35aHiDtIDC1e+tCCml1mQiiXx8kdOlzlRUctL+iLkOL0ocuwCuuEM7A/IS6xJl5IYDHL2GptLV395XhG8qlU7ZvVXE82z4ueSRn1GTum+XUte2KaMtk3Tc43zuNB3X5RPlAawskiSCukiP0/ldSHz27IZkPJzw2+yCJ1SiDY6gQP7d4YHps3Hc4cf+uVhldGxj78qmv/Hc3VNehBvvCgegQqhr+cvJWOhzznO1sQVP5a0X/TtCjJqUi8LqAAtMsVJeQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781191234; c=relaxed/relaxed;
	bh=Q6pXYqIyKbnLGsq0eyoqZ5OLDLCFziW/k/PuLZsP9zA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JGrQRHisd9pxgD9jJIc4csR7FU+TjLHmz5oSCdqp67ZaMttlgjkAvBBIezOKw/Bh0X5B1VkSFUrEr+VYNtQDIOJtuZKaCLunTKCyXCzXwLMwNaxz5ow/R4jJ94pUTZm4wDeLQ5J4l/wCAv5aRAdNJYec91NF0O9vJxPJTH/7rjvaJZdVSmvKQ0b9Lh5JOL0dE37ytS7ixz1mvlmr4avz93HH3zfpQUP0bv1Htm38zcwIVq6+roaywwfc188b2N1Lx86yH0siKsn2SI+Tv00NFAimMmw8yRBo6iLNwlpLBBxevCOjXlgf7kErf9bnLAyw32VyRU6+V0gPhxgI5hAQFw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Xni1mkMK; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Xni1mkMK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbmYX4J18z2y8h
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 01:20:32 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JdBKTU/8S4KHD8mqXiCF5KfHaIJKMAHJ4TD70J2A69/bJHKOg/+Ffa2uOwIMO/PY8wIcrW3vZA8155cLyxdQnALsrIlYNbEOS2K+uimMI3B0ApgMu5MQi8gPEJBC7TkFoVuClQdAYe8SMnlDmuzcJMxEa00xrBkGxyKfzz5aVP0JCB1f6ciFK6ZIBdmKd1UyU8L+2AR7WT+nfGZTwMdajEsy+6tnCMnfG5btNl1HpS9tB9Fd6tOOyzKjG1Vkn47pq/vmGgqkuvNxH4fgY3zBDATOWjoMhsXM2nbcgDoX+CgXxSe9zruQtBN6iNfGOzn5HMWNiXfIA7I2kkyqUPmN5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6pXYqIyKbnLGsq0eyoqZ5OLDLCFziW/k/PuLZsP9zA=;
 b=QMnJ9z/5H81XB9SB2VSx6t8V6JJJH+DGeatnLowua+/t2SMTn0cuEPa1b7llYKxXmpwKdI8sAylDE66PfcOsf6xV4HvB51nq+mIIzWstR48ixhYJ5mJySeKkh3XCBfGpfvZb1JMrXs6Wqrehov2DMjPVm3E/0f6FEAFBsWtJr5rKL20YzgkgLRE6ohEJ/Yo8ckmKfWCo1ZUv9/jCNgyY5K0Yz1iR93IqXHP2x+Zy1gP36gn6e/WN0wNp7Dfa9qKwryN3CM640Cuycp6LTcrneM0Xt9x1lLZZiy6a9VV7svjEwuPe0g2UfDNdTR4JiTfRGmlR4JVRUZmkZmjuwUwCsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6pXYqIyKbnLGsq0eyoqZ5OLDLCFziW/k/PuLZsP9zA=;
 b=Xni1mkMK5FpyDqkaQ65PM7sC4WxRxnxzg2W6p9y+PO/zR4jFW0NEmiVeF8TiTjmO+YCTYpKErxfi5qFjqHu5tjIzNEyI2Fj2x2Cg0nLAcgKsPpNFcHApFabaoycgYBtz8BbIlwoaMEaJRLNqg3KOKQ65w45KKAt/JxUNZVXPVV9kr7NHrmH3XhfU1A/rDxUgawWOs/JUH/MSsPP8g9eRYQiNbTGvE3NYXFn+yvOAr8Lh2B5SNywnQg1KAmhV6MQC2YfCrufR2PbMRNOM73wXRZGpZ2YHld52Ad0bFxXi8FI4WKuJvTJPjjpzsgK8/o0OP/LVjDZfdPvkJS+oYHfutw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA4PR04MB9270.eurprd04.prod.outlook.com (2603:10a6:102:2a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 15:20:06 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0092.016; Thu, 11 Jun 2026
 15:20:06 +0000
Date: Thu, 11 Jun 2026 11:19:58 -0400
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
Subject: Re: [PATCHv4 02/15] dmaengine: fsldma: drop desc_lock before
 invoking client callback
Message-ID: <airSHmdtCg5yWn0X@lizhi-Precision-Tower-5810>
References: <20260611035245.13439-1-rosenp@gmail.com>
 <20260611035245.13439-3-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611035245.13439-3-rosenp@gmail.com>
X-ClientProxiedBy: SA9P221CA0029.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::34) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA4PR04MB9270:EE_
X-MS-Office365-Filtering-Correlation-Id: aa61d4d8-f4e9-4c4d-5126-08dec7cceaaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|19092799006|7416014|1800799024|376014|56012099006|11063799006|4143699003|5023799004|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AQ6jh9T6iKcX2IztZPS9N5+Qh48fNAUzyCHwWSC4xqEQ+6dqQcY98apT99HAAu2mRWNpQ8dWNJlDmJoIpAzlUZ4KMIfO/KHjb0QyriKm+qy3PLxB6o0oPVsf6A3hUfApmmULw79qK6amJ1X7lQ2YGr4IYLjGlbnZaDNdOAssp33BPQGp9brYqIvmdL3Fah5CLyOS17lIvT39BTH3bBr6sHy7QjuyE9lABjrK21bDnGrPg8HIFDsAN4YVhZbhuf4TXaA1CEZ2dXCKCDkBk7dLR8g3rEltr04ypmtbDIsj5q8WOiaTlvDInjE1nVSWOdtqXTAOsplcChC0yIbrghYhHXzLXybic7pcnyUb9GFY5YRABv6DJFUoslWj9L8+XPPZzcI6j8iPbY8OmkfczQqjiqkORHASOzU5zOsYZSlqLOpZweerwPU0DlgyzhY72KvqFt/5tyDKU9jqlRVdacZEOy+BiWww9K8UQABZ+AFD+1usaQA0WY9Zz9fafxGoVx1mnwjVVLXu6NoPrd+3YJQzUqI4U1zPverf4lB2I8L9qJPApHs2QhJecGLX/ou9jE66OeUYDmZzCdwywkYUfpQf2teJGop0Ma4stdqKPDioY1UkUa3mXc5l28OdDPr9HS8pSwlulL9/3GCipE+Gx9oKsinclSVs4upud6+Tbc3FryI4bqAaPAR7fUWwuqjSKiRa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(19092799006)(7416014)(1800799024)(376014)(56012099006)(11063799006)(4143699003)(5023799004)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y8ZPFu1ERDkpJXY2zvIRjjEfj6tIZ8x1eGSkPK2BIFqf0CADdbYyAGdBYP9s?=
 =?us-ascii?Q?OL5bha9zmyWsTb+YQxxw1/qaXFdZAF6QQfe4cz1aTyGtEM6czNt7CMQ4JPhX?=
 =?us-ascii?Q?5GHfHBWU77dIIpT3a+vG9asCckdQShydIvASItwWc4huUJP4XxAlOZaAqPT5?=
 =?us-ascii?Q?cMIJyoZc9RgHo75WfSTugQlwn/eAsL1hrYBxYY+4voBikyu62cwk9Vc5zWdM?=
 =?us-ascii?Q?r4cWgqz6eiC1DlgqXrIE14NVv6OsWFnp+PZlXJLGkPpfPkd3c8XPRVCfplnW?=
 =?us-ascii?Q?NCe5gZrF0CUBNh5IYPjELKj6UrSW/jS+M0fL2VLvMkm9NLtbcu6VLJtNsmHv?=
 =?us-ascii?Q?X767J14kyiJS6KNgkgIbaJc9UNGYiX+RFPLE96hOBVfiLr8wnd36FzilgHFX?=
 =?us-ascii?Q?tFD2e6HMFlezLBwon88j32JG+bJBpyz444GHFGBPViU5zBW9tE9ddpfM4gU2?=
 =?us-ascii?Q?8Xr7WKD20GkJxwYel4ulvIufxD3V2mb/gHcw2P/td1xWNdJg+efSZhrly7II?=
 =?us-ascii?Q?jRfzYn/fHIm5TlyAH+FN1vOSV1yLAnc0WLQ8izXpb9ErxaZ5NnARK5Da+yBB?=
 =?us-ascii?Q?pkUYlc+TlQZjP7r0z4I/1lQ7EBJCj+96k4rgmNKyi8p3btJ/iOlkykHWYnn6?=
 =?us-ascii?Q?gD58R42nuj1g5NOb7sP7cq0WCq1hrwGMwBsBKu0gItDr/Ey9Mewwmw3UkVoF?=
 =?us-ascii?Q?vLOmDqp9uLxPeySHJ/FHGdT2nawr4MlbD1ZmrTlUzPOb8qPCt/tdDgpONGLK?=
 =?us-ascii?Q?Hpv/WQg/jCoBGDV+d0OEub5q0mbMe6tOcVgkD1YkzOF8HcDiNwWirkyqOwRj?=
 =?us-ascii?Q?1gs9veM7lxA8AdcxJG8VdLLCHU45isXjmiXu8MrEVSgxENm3tegMaLYo9u8j?=
 =?us-ascii?Q?1FFKJLikHhxEVA+hrt+vhecPMXfLlgXzbJ6v9kjiiYMiPwu8a18QYoqIwGDt?=
 =?us-ascii?Q?OLc0u128DJVvTB9kw8oKb/5gHyg7wnqfxT7wPf8U8azfeIH5+EHZdwFHYmmW?=
 =?us-ascii?Q?X0rwyYaTLxrO5OyoI/ff+jDlzHsGGccEx9TZs0jwufy214ivC37HCGm8e3N5?=
 =?us-ascii?Q?zLx+1YjjASH14a4TO1KoovWoRTtKC17/OuKovsAzkaaQlKZPMI0outVbUdEQ?=
 =?us-ascii?Q?ziO4SoxtsUYobmXEK7MhrRj2r9Jwr3YiIvDA6VFYkHFdtRT3dgL8UFC9BOOq?=
 =?us-ascii?Q?dN1QAMWErlnRQ1deBwM5aPKu+NspIxGBna+8QTe9M+KKHwk/mh2wG6T0TnM/?=
 =?us-ascii?Q?yP+CCaWia4mxd9taLmvx2ehzxAcznoE7S5dps7DsxleJpp08qXT6X0pHCmpL?=
 =?us-ascii?Q?h4P8CW3/MwONWEGNEc5Skcm5C3suILqfNosZBezbj8UAgFkD7f3UeGP7OXIZ?=
 =?us-ascii?Q?RAs2OWiLZe6Pv3ztYOyjnkWuqfC8ouachusSdX2RVeUGZYVyaulz2wRfuC82?=
 =?us-ascii?Q?EHCSw20mDr29NULN7paPletJ243Yx6BHStIcvmSiHloaOy+kFTfcDN4hpQio?=
 =?us-ascii?Q?GQhpfNDj7jq3R8/l2Bil4ruqgwvmVnPHPGwZE3J4tb86vREjSIUu/5jyN6w1?=
 =?us-ascii?Q?RVNF6xrsEYf0JT9kEDdAzyg7U+qVvIbu5z4mZ/GVlThbOcB9PQqiibQP9zXc?=
 =?us-ascii?Q?ntLPgn84Wr0XiVjW8GGDCyBXGVeeciEddsqivFotokaJioYy3PeADhwjjUHm?=
 =?us-ascii?Q?8w5tr0s6oTc2sRx/ySSMNPJLvaQgzUJZeHEGNaSzAwg5nlFXpACSO6jdikM8?=
 =?us-ascii?Q?DP4sqV9e201kiHzjqGPA2VeCWBCOdGIHbYflnWFlgzPKWwAA02TV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa61d4d8-f4e9-4c4d-5126-08dec7cceaaa
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 15:20:05.9314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a7s9fc09Kw9si8l/uPwLRpLrbiYAf1IXSI7Bm3YjV4N5TyG6F4cjMeC/5wuXO1A7qc+24yv8BxtEcv0zdiO5fnn0RySLDVgBqOGVKeS7w2mQnZrRDvZvYbfg5Mg8Pu2u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9270

On Wed, Jun 10, 2026 at 08:52:32PM -0700, Rosen Penev wrote:
> fsldma_run_tx_complete_actions() calls dmaengine_desc_get_callback_invoke()
> while still holding chan->desc_lock.  If the client submits a new
> transaction from their completion callback, fsl_dma_tx_submit()
> tries to acquire the same non-recursive spinlock, causing a
> self-deadlock.
>
> Fix by extracting the callback info under the lock, removing the
> descriptor from ld_running, dropping the lock, then invoking the
> callback and running dependencies outside the lock.
>
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/dma/fsldma.c | 108 ++++++++++++++++++++++---------------------
>  1 file changed, 55 insertions(+), 53 deletions(-)
>
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 0e2f84862261..455d21d738de 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -496,16 +496,19 @@ static void fsldma_clean_completed_descriptor(struct fsldma_chan *chan)
>  }
>
>  /**
> - * fsldma_run_tx_complete_actions - cleanup a single link descriptor
> + * fsldma_run_tx_complete_actions - unmap and extract callback from a descriptor
>   * @chan: Freescale DMA channel
> - * @desc: descriptor to cleanup and free
> + * @desc: descriptor to process
>   * @cookie: Freescale DMA transaction identifier
> + * @cb: returned callback information
>   *
> - * This function is used on a descriptor which has been executed by the DMA
> - * controller. It will run any callbacks, submit any dependencies.
> + * Unmap the descriptor if it has been submitted and extract its callback
> + * into @cb.  The caller must invoke the callback and run dependencies
> + * after releasing chan->desc_lock.
>   */
>  static dma_cookie_t fsldma_run_tx_complete_actions(struct fsldma_chan *chan,
> -		struct fsl_desc_sw *desc, dma_cookie_t cookie)
> +		struct fsl_desc_sw *desc, dma_cookie_t cookie,
> +		struct dmaengine_desc_callback *cb)
>  {
>  	struct dma_async_tx_descriptor *txd = &desc->async_tx;
>  	dma_cookie_t ret = cookie;
> @@ -514,49 +517,14 @@ static dma_cookie_t fsldma_run_tx_complete_actions(struct fsldma_chan *chan,
>
>  	if (txd->cookie > 0) {
>  		ret = txd->cookie;
> -
>  		dma_descriptor_unmap(txd);
> -		/* Run the link descriptor callback function */
> -		dmaengine_desc_get_callback_invoke(txd, NULL);
>  	}
>
> -	/* Run any dependencies */
> -	dma_run_dependencies(txd);
> +	dmaengine_desc_get_callback(txd, cb);
>
>  	return ret;
>  }
>
> -/**
> - * fsldma_clean_running_descriptor - move the completed descriptor from
> - * ld_running to ld_completed
> - * @chan: Freescale DMA channel
> - * @desc: the descriptor which is completed
> - *
> - * Free the descriptor directly if acked by async_tx api, or move it to
> - * queue ld_completed.
> - */
> -static void fsldma_clean_running_descriptor(struct fsldma_chan *chan,
> -		struct fsl_desc_sw *desc)
> -{
> -	/* Remove from the list of transactions */
> -	list_del(&desc->node);
> -
> -	/*
> -	 * the client is allowed to attach dependent operations
> -	 * until 'ack' is set
> -	 */
> -	if (!async_tx_test_ack(&desc->async_tx)) {
> -		/*
> -		 * Move this descriptor to the list of descriptors which is
> -		 * completed, but still awaiting the 'ack' bit to be set.
> -		 */
> -		list_add_tail(&desc->node, &chan->ld_completed);
> -		return;
> -	}
> -
> -	dma_pool_free(chan->desc_pool, desc, desc->async_tx.phys);
> -}
> -
>  /**
>   * fsl_chan_xfer_ld_queue - transfer any pending transactions
>   * @chan : Freescale DMA channel
> @@ -635,22 +603,23 @@ static void fsl_chan_xfer_ld_queue(struct fsldma_chan *chan)
>   */
>  static void fsldma_cleanup_descriptors(struct fsldma_chan *chan)
>  {
> -	struct fsl_desc_sw *desc, *_desc;
> +	struct fsl_desc_sw *desc;
>  	dma_cookie_t cookie = 0;
>  	dma_addr_t curr_phys = get_cdar(chan);
>  	int seen_current = 0;
>
>  	fsldma_clean_completed_descriptor(chan);
>
> -	/* Run the callback for each descriptor, in order */
> -	list_for_each_entry_safe(desc, _desc, &chan->ld_running, node) {
> -		/*
> -		 * do not advance past the current descriptor loaded into the
> -		 * hardware channel, subsequent descriptors are either in
> -		 * process or have not been submitted
> -		 */
> -		if (seen_current)
> -			break;
> +	/*
> +	 * Take descriptors one at a time from the front of the running
> +	 * queue.  We re-read the list each iteration so that we don't
> +	 * chase a stale next pointer across the lock-drop below.
> +	 */
> +	while (!seen_current && !list_empty(&chan->ld_running)) {
> +		struct dmaengine_desc_callback cb;
> +
> +		desc = list_first_entry(&chan->ld_running,
> +					struct fsl_desc_sw, node);
>
>  		/*
>  		 * stop the search if we reach the current descriptor and the
> @@ -662,9 +631,42 @@ static void fsldma_cleanup_descriptors(struct fsldma_chan *chan)
>  				break;
>  		}
>
> -		cookie = fsldma_run_tx_complete_actions(chan, desc, cookie);
> +		cookie = fsldma_run_tx_complete_actions(chan, desc, cookie, &cb);
>
> -		fsldma_clean_running_descriptor(chan, desc);
> +		/*
> +		 * Remove from the running list before dropping the lock so
> +		 * that terminate_all cannot free this descriptor while we
> +		 * call into the client below.
> +		 */
> +		list_del(&desc->node);
> +
> +		/*
> +		 * Prevent dma_run_dependencies() from calling
> +		 * fsl_chan_xfer_ld_queue() while we are not holding the
> +		 * lock.  That would splice pending descriptors into
> +		 * ld_running before they have been completed by hardware.
> +		 * fsl_chan_xfer_ld_queue at the end of this function will
> +		 * re-evaluate the situation.
> +		 */
> +		chan->idle = false;
> +
> +		/*
> +		 * Drop the lock before invoking the client callback, since
> +		 * the DMAengine API explicitly allows clients to submit new
> +		 * transactions from their completion callback.  Otherwise
> +		 * we self-deadlock on chan->desc_lock.
> +		 */
> +		spin_unlock(&chan->desc_lock);
> +		dmaengine_desc_callback_invoke(&cb, NULL);
> +		dma_run_dependencies(&desc->async_tx);
> +		spin_lock(&chan->desc_lock);

Not sure if you have hardware to test it. This change is quite big. Generally,
keep desc_lock and move these complete queue,  defer to tasklet or workqueue
run callback in in complete queue by hold complete queue's lock.

> +
> +		chan->idle = true;
> +
> +		if (!async_tx_test_ack(&desc->async_tx))
> +			list_add_tail(&desc->node, &chan->ld_completed);
> +		else
> +			dma_pool_free(chan->desc_pool, desc, desc->async_tx.phys);

desc already removed from list, needn't hold desc_lock, you can move it
just before spin_lock()

You should use difference lock for ld_completed.

Frank

>  	}
>
>  	/*
> --
> 2.54.0
>

