Return-Path: <linuxppc-dev+bounces-22642-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3926CD98C5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 14:19:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfC0q4bRxz3btl;
	Tue, 16 Jun 2026 00:19:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781533147;
	cv=pass; b=AQJSsQlA3jSyZ4wauVvRbUewgzHbHZfhKFi3fxMHxkQi4reOq1OppKfARrUGiqV9Xp8vakh6NO6kpp8NQh6/TL1uEIbNR7W/43jAFv8UFQ6B93v5fZYpF9vvQ5VXJ0hxlQS1wRBDUFGZOqCR/ZWgkuhypKLyEq3ARfm6TeREDnWDE2aechXhSpoh+qIQEKbnOtktpSbe5SWR52se/0VxZlDfrxy887eV8EnhQoS7ykKzSwrVILqTxmRz4RO3y9dvr50/MT4H/uBncbTlOqfyHHDFMyMc4R8hoysNflC5qx3IhmsB+duaUegnFgrI9CBcDsfa/Fhk7ZzrYt5dkmubIQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781533147; c=relaxed/relaxed;
	bh=73/5c3rKYsuqyMvovsu534x3N/IXgdewNp9Ym9yE1KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hPcAx4Squheg5+mO6DlUGAYRiAQVGqwwAjfZcGUvZkPHKVhJVjvAnV/tMCP078uDWP3y4K2bQsIZXoVjE5QbaJb2XNErzGZdZaDJbLlTUnk4E8shx9tR2mu4Djxn8aXvOb9A3zSCS9j2r6zVkGIeAxAmHNYPRTLvkFxFpgTWAuTsAPg5EFSEyS0oXlspV9z7r/V7teeqiChZxK9SLDXbmHC7niGEDB0QzGGpsVHo1O3B/X7SmXhIo+CD3pbQ5RENyycFzl5f5gJ1rVG6ckW/sDxLdSKdH149wswRDYqE2Sv2LW3Jpc7ABqIQ9zUj7DPOvgn78/Nnq1mqK7CGM3TvFg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=PRgMLbRg; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=PRgMLbRg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfC0p6jT9z3btj
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 00:19:06 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F6jQkT3NI9W6sZksRv13XwtBY0Zhiii54LoIf4E6LtZFgt5Pq1V1dTBC7kkBj5Hvuy/l5JuGcJtNvSXMpcGfdVSDz2E4kq3GsSt/R6XTOdZLPq4ge9/5q7/LgBzhDr1J2jllgkYSMwKyfY04Csl4a+wByLDkse/7fAHUqNSVKFc1J42qVmsJgsL5j/Mvku2f5IGdA+Swc6daQMmITBdUPPaDJ61eKxMcsmWaEWXICRT4KW4k3nPhe2j/AEckZBBsVtsUO/54RypO4HhSQ4cwkq5ukP4dpX/uVWD90Tj9RdaHrlwCT9sYmKcGcIP1xRAu6HuIiGak0bh6XK96WcKbiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73/5c3rKYsuqyMvovsu534x3N/IXgdewNp9Ym9yE1KQ=;
 b=cptU3VL4k5tsUatK8rLNY0zedtfPi1nzcK57hHaPJ9eimXQ6Txl6F/frp4MiP4OWAa5sNNRye+82Cb1lGmyRjQ7S9kSEPglZgnEc1qsMXr7vqMBvaDKraL4Zs+9a3tYKwrSQXBLL7iW72y9ngfhzg+e2nP6vGI2VcCTOdrHlF4YAtRKkC19UNp5x1LBoELT+7w0xjOaS5iIK1sF+IpVWxX1MzRfyrnz3Ltmnpui1oSJ4d4Ji9gyiag1n+wlERD5hPTdEhvQ7MTghEw0Akh62B6zOWcr8fqgLx4y94x7Ck7k3J9PiZFKIZbphU5Y61aT7zN/QgqeuTO1FxZQs4ahqLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73/5c3rKYsuqyMvovsu534x3N/IXgdewNp9Ym9yE1KQ=;
 b=PRgMLbRgPKBtZLrNMAO4DixFeGbv6U4IkeAxBO0jncxicihvlVj6FiCG5p3th386YqdSTRIYGO2KwDDYVbdtQjSuUgz6d4b3oPw26E0lFik14Q/IvNzYXdSSEhqyg8KdHOXDVYt7nT2R3g9DckSbfoW14Zgo1PvAVBU10A2CF7t7XNb6ZTKF2u61syDafXLwckPeRTCCQuOGZ5DW5vd9gl92JU6RlyGoF2SfuIfXouPLBegzZEOrJfbZPbD/MwSbCYmjKhFgM65e6+nXIQa3devU7EoApfuaNDbwqHPR3MU7LUSU+hzE6w7rLwQg1jLZg5EvH9SlyH1/e4N4el+u5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI1PR04MB7167.eurprd04.prod.outlook.com (2603:10a6:800:12a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 14:18:42 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 14:18:42 +0000
Date: Mon, 15 Jun 2026 09:18:31 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: phucduc.bui@gmail.com
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 01/11] ASoC: fsl_asrc: Use guard() for spin locks
Message-ID: <ajAJt-EV1sSfG3OC@SMW015318>
References: <20260615093824.115751-1-phucduc.bui@gmail.com>
 <20260615093824.115751-2-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615093824.115751-2-phucduc.bui@gmail.com>
X-ClientProxiedBy: SN7PR18CA0011.namprd18.prod.outlook.com
 (2603:10b6:806:f3::19) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI1PR04MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: 019d7cf1-a7ca-4a45-8cd4-08decae90089
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|23010399003|1800799024|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	tK5f5iPawE6HB3s4KvB+/jJq5A3Qvz9tha0TtZVPFcJ24rq1ptS5fDoBFWZ66YkfEsn1/nrBU9va/XPz+luXECjAngq7UUQ8DmHIHOXKpqpPGe3AsxliQmpl4ApQu9GjnLMgPWxn+GidrJDBvQiOWDgfg4S/d2btI2yGnvU6eJDe8PAoeXm5fPr1JJNoCPxm/Mqyzrn0aHy5Yn/dZwmh9Pq/m6LYDSp3nefCmeye3heV3/Dayj0ZeynZlYnK0iQh7pYr0u1GVy0E540rVBUuQRG7GcflpX2YTROIiIEeAYOdb+xaP7zrMoqLO7Bo7to/r2oFlDarhekaCPX+b+OY0mUZuOILxvLN5n1QVT7sDahcqeBFkEajnl7oNXmFQkqj/11tk9munjlleMwYh+JLhYwDM9eY7uMtJbKgPnir0/2JklYh/s0zNLBxSpaR5oowY/FU/OhY0FRMJSvpiQ/ZTBehAEoQD4qHkYO+BL8cryZiWxIyqdPMNNn/pKsf3GtjA9QP4yJmsv7JStUL8mNM4H5Rkh6FdHSk50OlWSyijT0bXZnx2XEHBKyufBmpl/iOFOaKiEuQTup385pUXf410xxMst31C8f9cUsjF7djfYUrpqMQQsCvR8F5dVCme195//gp1k24Avg8dS1FDwrx0bhPzK+HgIl+TKq4G4OgnZPOvGKPAihT4+VAWBIscWpA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(23010399003)(1800799024)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D50qzVTApRfmWaUx4un/qyt8lEF4mOcTs09H2BR7ZemxAnRVBcmstA3s2thP?=
 =?us-ascii?Q?rCOaRes7qjBjrdUfZCyd89HzioP+nCR9JiRYWyWH3+m6UdIqc88hd1yPSbdn?=
 =?us-ascii?Q?nmE6w94Nolofk0PuAePjZmkDP158V13RHBestCxHHxPXhh2bJsnA2LhqjKBO?=
 =?us-ascii?Q?IO+8ic4WXvs6nl2FeXI9yrJoi0+lqC/u461p0QhLBYa0AF4/v6JHw9Tk0ZvZ?=
 =?us-ascii?Q?F3ZHgzXV9iFASnYbM6wH9mkoXc67/IMVasAeaOF5lR7QgKG16DyMSwc+REJy?=
 =?us-ascii?Q?3Z1LGiRdA1IT3AaQQO2ISWdCDsLyNW+PaQfLZfoG0tdUukiaG0JnrWNiC5/3?=
 =?us-ascii?Q?R82XC3dFBQMKFeC+bmyCeyR0jLkdMjlzb3BpcGsPH3Ziw6sROnv5o6KVrl5y?=
 =?us-ascii?Q?pifCjP+1YUEAvU/1cMr5hWvvQMrIe8XvkK4iVvFkuRQo31I+B1/3PslLajEs?=
 =?us-ascii?Q?FIixh2OiFmnHVUFJJrxTPmPviidfHzrmhS56qKiEEjt5gwl+gTw/PdGwJe/5?=
 =?us-ascii?Q?IXdP1YFeDDj6u4w7B/dUsATE2oV2aLvcy/w8e/SaWpTpWrJO6Klg1fefbZFo?=
 =?us-ascii?Q?TKZjvXnOj0BDAJ1pwNPQr04Ptb/xLEl7AySgI9l0MZM0YCZNl8yRuxrmxBvo?=
 =?us-ascii?Q?08DvtxcFQsKF5vbrjf+kMDLRtf6KWFx6QITkqBx6Mo7LrGSWPLdvN8vxoJi/?=
 =?us-ascii?Q?B7d/u/+PZmSLfWTIg+k2mE7lfjGnbmat+QJxJ5LdzhpVaBKNb2pbVTr1jg71?=
 =?us-ascii?Q?oxXj9/mLFhmMxcYXWC696Ez5JFIxtlxxm824oO3/lPzOBJx56wb2o7zLpOwe?=
 =?us-ascii?Q?JImHxrRkiI6/Gz2hJGw2DQWJhtbjlT7Z1p2tzMgbogpR41eyYuoOdTspYeIP?=
 =?us-ascii?Q?5YICqdjqxocfnJzDJYGruxMNz6Q9vgp8axhiU2DOWtN6YFUkXnbulMc9H3Kf?=
 =?us-ascii?Q?cVUBn7lc8ZMCmuy132N1BvPJHycR8dtAAfLpLAVMfqD+MstiC+ms9qTnDndK?=
 =?us-ascii?Q?TQrk5RaLA1yMAb7jYeyps9Nd4uSLBJZZuRbevpFycq4Twa02g0OFZcSY88eK?=
 =?us-ascii?Q?q7HiYbt2etSMJ9EU61EKHXW5ZqMytbSJfbfWYFvgmfTl0Wm7QUNwgjApbnBi?=
 =?us-ascii?Q?ljP8z+Gc6k9LjldsIEH4fIRQ6DC5Y5YKleD2puAMAgq8s5Brc4zLaLqGlb+9?=
 =?us-ascii?Q?T+xNaxNWb5ncQBzvnldJeoqWyGpG0qY/31emHHYc0aqFyJoyPsfpWMeohS9C?=
 =?us-ascii?Q?watJazk+RUZ1qwsuLPzq14jV3NgiP+EqeDPFsSUuTQoU9DeDFnkiwiYryUMx?=
 =?us-ascii?Q?Jae0NP+HoJZU4nPn7RqcZ92pzNIBNnGughK1IFrdG2x8iz9fiprZtbVjrhCk?=
 =?us-ascii?Q?dhThlqRryOmFEgAxfZ8+8q/DLl1YYjSQMg0Tc7JpamxdLKEsC/F24btioeCb?=
 =?us-ascii?Q?NK6RUgU/XYa/IRsO7gugIjPYn2HkOI2/EOr3fy3/brPKR+8dYRjNaRWItAGw?=
 =?us-ascii?Q?ULpQYYeuHZVu90EW3zG21IxEacow5hlogSjxWNZfQzjO2+M7mkostA2N2OEZ?=
 =?us-ascii?Q?GRg3Wo3WsaTApUFK/bg9PvXGu4T9t6JvOvVXnOjTSqtP+6MKVdLWZ/2mEBvp?=
 =?us-ascii?Q?qzkWL41ZU8aLrVr4TbD2bEAJfDCE8DTdDsSXywQJLKrq+VpbhyMqi6S4n3EN?=
 =?us-ascii?Q?vy9LJwAEi5+zVfkcAfE2+IQaoqFbnyzSDzMK1jAK4Y3eD/2WnbaNbGOl3DpO?=
 =?us-ascii?Q?hUGzDTCwbhAWL/dWfULZH8yR3OHxYQK5g1SYhN1RtuCwbGaJuBPf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 019d7cf1-a7ca-4a45-8cd4-08decae90089
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 14:18:42.1443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3XDyW7TekVCMty4EsjhU2fdiFk9lkJw/Ymb6QB7RTUrDJ4Dv19XATvUJCwCAQpO6ZnTLMMczOBspborGkQK5NnwN4zB5MelAGVL5c3iVXW7GsFeNQoQ8eSAv4XsH61XR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7167

On Mon, Jun 15, 2026 at 04:38:14PM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
>
> Clean up the code using guard() for spin locks.
> Merely code refactoring, and no behavior change.
>
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  sound/soc/fsl/fsl_asrc.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index 5fda9b647c70..0b28bcfa47fe 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -222,10 +222,9 @@ static int fsl_asrc_request_pair(int channels, struct fsl_asrc_pair *pair)
>  	enum asrc_pair_index index = ASRC_INVALID_PAIR;
>  	struct fsl_asrc *asrc = pair->asrc;
>  	struct device *dev = &asrc->pdev->dev;
> -	unsigned long lock_flags;
>  	int i, ret = 0;
>
> -	spin_lock_irqsave(&asrc->lock, lock_flags);
> +	guard(spinlock_irqsave)(&asrc->lock);
>
>  	for (i = ASRC_PAIR_A; i < ASRC_PAIR_MAX_NUM; i++) {
>  		if (asrc->pair[i] != NULL)
> @@ -250,8 +249,6 @@ static int fsl_asrc_request_pair(int channels, struct fsl_asrc_pair *pair)
>  		pair->index = index;
>  	}
>
> -	spin_unlock_irqrestore(&asrc->lock, lock_flags);
> -
>  	return ret;
>  }
>
> @@ -265,19 +262,16 @@ static void fsl_asrc_release_pair(struct fsl_asrc_pair *pair)
>  {
>  	struct fsl_asrc *asrc = pair->asrc;
>  	enum asrc_pair_index index = pair->index;
> -	unsigned long lock_flags;
>
>  	/* Make sure the pair is disabled */
>  	regmap_update_bits(asrc->regmap, REG_ASRCTR,
>  			   ASRCTR_ASRCEi_MASK(index), 0);
>
> -	spin_lock_irqsave(&asrc->lock, lock_flags);
> +	guard(spinlock_irqsave)(&asrc->lock);
>
>  	asrc->channel_avail += pair->channels;
>  	asrc->pair[index] = NULL;
>  	pair->error = 0;
> -
> -	spin_unlock_irqrestore(&asrc->lock, lock_flags);
>  }
>
>  /**
> --
> 2.43.0
>
>

