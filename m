Return-Path: <linuxppc-dev+bounces-22645-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26E1CD98CF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 14:25:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfC8Y0vHxz3bwF;
	Tue, 16 Jun 2026 00:25:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781533549;
	cv=pass; b=GU1co4iEDMZ1JpehiV1ySKAOr9RLo+0TXNi47RehT9D3SKTTR50H405KVW1NBkL5YIt/Q8X63WTpjwHoXROZvkV4dzMQl6hJ06AHzPetP9fS/fCpdoiCnHyK/yJ8xzjFuwqceGpY+T7j3TRUZq9uf0CGlmODYpYvuFeCL6lRnNOhZJyt9jEFfkrPshqOArl/FepvTYK7uJ+pmdIMqa+VnPdNJgKa+vxZXuN4zXTyFZ6293ksHScsnfV+/PcPyeBi6JhFPL5GkSC561KV/Reo6Escw0XnIBj3ouSR9sQa5iRUtCImqczJPWXIC4Xc4rqpL4ATEhMGH+r4L3QiKiwnNw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781533549; c=relaxed/relaxed;
	bh=64O2bV3Ja2G7zsVPHKfWtcBWLW/GECGTf/rcGSBGSj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Te3arEJCm0zeAce+aE/poeLgyYH/cO1sJF6sKZpjPRm024RTo2YiHZIzYoqIJnCOAfmnIIxqhCe93dDqJjUsRkEKqxAV09f7hVCjm4+N0dUq5xdLZVm5kXT4X927iRpSKJeDQMt3WFW0VH+sw0yb/MZCEip0rTR5zYFm+7D+zr+L6hDP86xovPfl+/nSylifh8E7a399xRWvxpwUPZY7yqvNUWSIUT+ZOKS3zIfknJtWoSM33yLK1aLik3wxwpgcm7HzSjfGJ9rOixWd0dKKppuwvSOlGkyZgTaxBdF4MdU2x0Zf6zD9/hD9Q35JAAX1LawdgYWxGzt3ZhrddCeWvg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Bin3USuF; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Bin3USuF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfC8T0jCLz3btl
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 00:25:44 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SfW29u0iH4ECuxKlYFYSDLcKpCeyRaYtAJvuQWnqnzHDMs47vHED/vuNU8EVrWbkGs8r6ZYOphFs7e3dBHziG47e8AKTunfNCPcpMRpMCP0P6FKF/WOAfQZ57o9WB54VvE47KtyBrAABt+ykuYfjSmlrh3ajG+2+8UhU4CvMzTMC+XvJwy2J2uuBGO6E8FmUgq0LPWhLEv/oCboezdS5d4WLroTemSLLB82k4zoUAKSIpVJoO4MgdxIzbH6xKSyUgCz/w4YNuAWlM/3PJv2IX67xX+MFvSskZvtpufDCTQQnMeJ8960LnzYVi+4zNE+00TjbyE8/DBol2vqnRobqOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64O2bV3Ja2G7zsVPHKfWtcBWLW/GECGTf/rcGSBGSj0=;
 b=ww8zaFLdMFqfZG/kIv+cg/zt3NHNZ2z+bzomjRKMfinLU8W2JQpn0Ttc5x85yDi2hzfJeF5NGj9UTEdqBu48uQmN/zHBeGoF6HlgZuSC72ABOR1x77+StqL4qBod8gNqJ2Dlqk1QUBdfT5EEe9+dhnQWZqfVqcFO0xIcwf03haZAAyJaTvH4CVJjhAbDr3Ul4y/RLNlFdFgjBp0ne1i8coDahULit4okU46CYxqXLN5sWXVu9ghzJrgExH9kHdrRxziLOyZQBAclVGfj67MGaC1hlNjnFQ4r/rB6TlWrSZelTAVu4PuOVR/hVeFN3hUcfSWnx9kWIFeILU7TXTnEIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64O2bV3Ja2G7zsVPHKfWtcBWLW/GECGTf/rcGSBGSj0=;
 b=Bin3USuFyTC8DlnV15XIGiXZnBMYyqAtRj7jTFZI3un2feQjB3Chdmst/4gHCDExP/w1ERjVwQJOHlGmpgOzEYnhX1ocSWPHWoFRWjJXIm6AFm2bVbbYkxipLDrRUdEWifS9UdIx864XsDwk1MiOuvE8k1oIEkvEeNg01qBNJvl4XSZ5x4Jt4t+cbcHNNMKILr6+egfHTZ0zJKnsMYChQJTghhRb/hs/j7f/Pu8gzIbRDAeCkJ0IJEym81aH12G1T+WQs/l5hu/IEPUpkA/if5sTFoX+gseHEIrimmRurAxy2XGVN/ZGvpVSnPAepX910Pt6EyW7IpZ4ZQyEIu6pYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA4PR04MB7631.eurprd04.prod.outlook.com (2603:10a6:102:e1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 14:25:21 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 14:25:21 +0000
Date: Mon, 15 Jun 2026 09:25:09 -0500
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
Subject: Re: [PATCH v2 06/11] ASoC: fsl_ssi: Use guard() for mutex locks
Message-ID: <ajALRa1eLYvJom-3@SMW015318>
References: <20260615093824.115751-1-phucduc.bui@gmail.com>
 <20260615093824.115751-7-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615093824.115751-7-phucduc.bui@gmail.com>
X-ClientProxiedBy: PH7PR17CA0062.namprd17.prod.outlook.com
 (2603:10b6:510:325::23) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA4PR04MB7631:EE_
X-MS-Office365-Filtering-Correlation-Id: 06a72f9e-d028-4043-7a34-08decae9ee60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|19092799006|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	t/Vm5pVMcPatlLBwG7TRd2/R34iPUcUUwVTthleXFNM51E0RQd6VH9oK/dydqVGy0BXwE6Vf+u+jd91uA6EdubwXeARnEggNY32tPiDgqvGw8clnUqh7Yc9amRHH/wZBMjuQc6l3DcFPaT5+p7RAleIzLUvYnIkaWPG4UAoAyL40nPALvc9YZg5jPCya2XCJSNEzELJG9HdYbeVStxtIUieONxbFlaA4OwZ3FNiH/rP27eexr/E9UJIYuk6f89ngcVMjsWO8sakVDYGfaozLvvbDg6tMoZ44aU5rm7LuYr/e0r9S3Uus4ypEaCCHBBPlAJOnWCHTPFaVq7m6EIKw5LJwou5Mj4/34xGcrZJAnaTlC+uIA2NvFAqSSau0oUYPiw/VgFHdWVC03bmp0xsWU2w5Tr1dqePDR8s24LXJnTYF29oqgB4oD0ul8UhCrSp4vJ966gBv/iVxnXGsM+9dk1lL9NLgMdPT6PeMJkR4lRdSSE8P0lvLZ+bDY/lu4d6e8qewTuMkwiXfQhSnijtOCyObgoS7qjHEaZHGA9OP5UugGz9/ypfH52HbIA0QSSPQhgKn/G4n7QraKTJXZffrDeMmOB7d8qVHpxs6ZpxZBRZpMtOwNSTUhcTWBYYwn02udx6pO07FAlYELlSUvYJNcZIUeUiv3H1VhArZlcLxsA+JbtTn6Pzh84/t+oKE6aDs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(19092799006)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NswD2+S5hGU89Iu8Itiy+P67akKHSiQ+eCYnj9vA2eKhO3FEi94/7dqKbyH5?=
 =?us-ascii?Q?+mYX+wS71Ii2NX3xy/piqyTNARzN8vksK4242XvHNNRSYROqnukcNvRzBca+?=
 =?us-ascii?Q?alnSmp+S/93rz9ZrnDRCwRMbJ71Ee/oaiw7b3s6J8vGGzTxvwxyp6HbOTHqz?=
 =?us-ascii?Q?vtTAVgpIqo4xDTvfcuuh7XxloWiBC6tpuOm1F0ph+RLP+rk8MxsFT01IYRSE?=
 =?us-ascii?Q?jcPjCitrevBYTegN7Mqz2r97VB6BkN2LnkEfiv4zB5QCvRFitqHVMCcwi2Gr?=
 =?us-ascii?Q?pcHbK4OfozNkMrcjo8PQvKYYiKF4fPdpOde9tOawS56nbNO1nh1B6I82XMmO?=
 =?us-ascii?Q?aDdD8f49lWOPYubuaalI5ugg7ImugvvnEGjwQlW5tfIbvxCx6l0sjTj31GfK?=
 =?us-ascii?Q?gwymoxdp35b5iV7u5iVsRjZYs/2OFZny8dDKIVTrLCX/0o3773c4UDcHzMQi?=
 =?us-ascii?Q?ukl4uQQ06qj4m8H1ZfjAvqxCJJWy8r/r04iBhQP0E7FfSoowcnIroE7kfbcI?=
 =?us-ascii?Q?sh+hnxTm8r3tBcFo1AGMZ06YEqUcGUYBjYYsHyx+sdPxgcJMXUNjYVDy/0MQ?=
 =?us-ascii?Q?6DMlf7U9F9AsG1awOdGscNP5y51Pm/Nhb7Aex03Cj5IAb30UxxFHWnml069l?=
 =?us-ascii?Q?MdN2vd8ylGh2uhxkcKyT2rDjwsauLnt795EcWGyGcYvwU33ZQCb0dg5J1qOY?=
 =?us-ascii?Q?XHIDjVKkRiLN8lvgMHzVTi8e2zGuRdbakQHnbjwk6y/OrFdYnJTj7KMIyKXg?=
 =?us-ascii?Q?7sSyHtMCBK+xg7grdSn7UDgBNqKTR+3opo6exmlPgmzSbH68MPxrZcHaiUTj?=
 =?us-ascii?Q?2rDwttOvH3PqKPPhvqK/iPBQMbgS0A+UT2bb82E2/hgOZufP1TBZNYx3zG1G?=
 =?us-ascii?Q?ZGOhIOE4FiKXG2n262CYQRa1flFHbpc10eKV3qxErK6UA4KFtR+Iyr+YEWE/?=
 =?us-ascii?Q?dt1Ldm2S4tR6P84nMyyyOfhm18BnhpzmuyCtWF+ve4WB+DWwep2orszFgThj?=
 =?us-ascii?Q?uadPdJhJTDAqqpPYqIUE9YGAamoFZ1mfedSML2LLQ9HnZKIIhc8wiCRCcprp?=
 =?us-ascii?Q?zF1SHSFQVFLn6uroUohBnfovPbhSuq8oKu8BZlVrSJ4vus9wUaV1XHq5PzOG?=
 =?us-ascii?Q?rVje/92vzm3bIZ7PmLnAZCbaSP2bmfNid+MZaYWSRhfKcB/oU6Iv7jXcxkCb?=
 =?us-ascii?Q?Q07SGkY9QqiDuNGGmzU0RXeO9N3A/sO6P3Tm8jcL6agYmXEafuBTYHW0h2KU?=
 =?us-ascii?Q?BDpW5cC5RpT/ASBkQgWCbfsrqxEjXU23g+WeXodM9KyKRN96XX5K5uzus6YC?=
 =?us-ascii?Q?Izhx3Bdfu1ESZwEBuE8DDT5PFGLdNrhnigUJCMCPeYZglE+xoHVL7/WP1+cy?=
 =?us-ascii?Q?6+xsoNqib2efJOMjuKQErARwImWB7F9k3S8x0Ve9QUE/BfdsZQ3kavAsJlB4?=
 =?us-ascii?Q?0h3IxnRHaWxq+rKXLiqchatQ5RG6GngnNUsDNyd5AOyU9wteNywToWH0Hky9?=
 =?us-ascii?Q?X1CCSEtylWMG7i0axcz+FL9XGkwWxKrwffhCMjxgML/DLi4zB478/Fgy9sf1?=
 =?us-ascii?Q?BP5xM5jESl1A5gKZiiWW7//OaMxnYfHj8sPT+FJx/ATa4wjABsuvvcU3ZUvy?=
 =?us-ascii?Q?MsclJ4P44B6DkM7nwXXOtFkp11Wi+xTHCfzISUEpHseR3qqYvSKFRdvp41JQ?=
 =?us-ascii?Q?4iZ65CRq9g2p9kLf34/Avly9Is4lYz9xfQFBVPVbQqSUihkajDvI0daalNJ1?=
 =?us-ascii?Q?oRXZCMnmbXfNx3N1/DUW1pTJf8RXMZx/TdPz0TIun4zYuPv3lomx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a72f9e-d028-4043-7a34-08decae9ee60
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 14:25:21.1997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R38yckYkEcCEDNdzmAxsG/H7FlaVrTxXx1i9Bt0CyiUJHh397rRGDX+xaBJInR33bQKr09HubW+dZAxmxz4SlPfuCKeRffhYht0hyHYVkyHGENYjuqrc8dZDNrYtjpvi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7631

On Mon, Jun 15, 2026 at 04:38:19PM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
>
> Clean up the code using guard() for mutex locks.
> Merely code refactoring, and no behavior change.
>
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  sound/soc/fsl/fsl_ssi.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index b2e1da1781ae..dc022976c982 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -1218,13 +1218,13 @@ static void fsl_ssi_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
>  	if (reg > 0x7f)
>  		return;
>
> -	mutex_lock(&fsl_ac97_data->ac97_reg_lock);
> +	guard(mutex)(&fsl_ac97_data->ac97_reg_lock);
>
>  	ret = clk_prepare_enable(fsl_ac97_data->clk);
>  	if (ret) {
>  		pr_err("ac97 write clk_prepare_enable failed: %d\n",
>  			ret);
> -		goto ret_unlock;
> +		return;
>  	}
>
>  	lreg = reg <<  12;
> @@ -1238,9 +1238,6 @@ static void fsl_ssi_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
>  	udelay(100);
>
>  	clk_disable_unprepare(fsl_ac97_data->clk);
> -
> -ret_unlock:
> -	mutex_unlock(&fsl_ac97_data->ac97_reg_lock);
>  }
>
>  static unsigned short fsl_ssi_ac97_read(struct snd_ac97 *ac97,
> @@ -1252,12 +1249,12 @@ static unsigned short fsl_ssi_ac97_read(struct snd_ac97 *ac97,
>  	unsigned int lreg;
>  	int ret;
>
> -	mutex_lock(&fsl_ac97_data->ac97_reg_lock);
> +	guard(mutex)(&fsl_ac97_data->ac97_reg_lock);
>
>  	ret = clk_prepare_enable(fsl_ac97_data->clk);
>  	if (ret) {
>  		pr_err("ac97 read clk_prepare_enable failed: %d\n", ret);
> -		goto ret_unlock;
> +		return val;
>  	}
>
>  	lreg = (reg & 0x7f) <<  12;
> @@ -1272,8 +1269,6 @@ static unsigned short fsl_ssi_ac97_read(struct snd_ac97 *ac97,
>
>  	clk_disable_unprepare(fsl_ac97_data->clk);
>
> -ret_unlock:
> -	mutex_unlock(&fsl_ac97_data->ac97_reg_lock);
>  	return val;
>  }
>
> --
> 2.43.0
>
>

