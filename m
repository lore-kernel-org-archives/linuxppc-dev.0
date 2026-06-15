Return-Path: <linuxppc-dev+bounces-22639-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50314CD98CF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 14:16:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfBxZ6tZbz3btj;
	Tue, 16 Jun 2026 00:16:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781532978;
	cv=pass; b=b6axwikaAEp27aYfU0bJq7vw2pXadbMiBMfhJEB5ArJjhIaUqlCr9zKX1xoW5VNGOG3i9e44cSpGW6VtqKrVRBtf0pjafY89e5n7O2ygX9b4Y/3kCfe4DbeApghoAT6BlwoErc+x23GzwnvqaDqekYuvmHLBxbbrjS9lzHV+tUNIfkvXlNIQB1bI/fvsrw4eKl2/rEnJA8Oxpvx51fnlKeBpJ6xWMKBcrItiipp9ILMKmfu4KXxqQQV2tb30gEpgARwUfOBlqfuC6JN8WgygfV9Pu0y1apr1Il2SbTYBtYtVkkSOlzjyYdTv/BERnqA55QVAON3jfoqgIty2mKbuqg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781532978; c=relaxed/relaxed;
	bh=SQTpoYqYDt+wwaX7XKeMsaf6yhmttUPt+OGGWaW5pwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YxpXmpHsFyiQp1g5LHX0a3ZKWF65O04nLaGYqQQ1+nwoXjedDYTlEFEtdLMpQP8ltgLVH/4Q8GfEidQvkJtOf70MqPPKhUuEEYAbJEC0FFglPm0vvrFJPCH8KUBb0mfwc9cNPS07YG7jKMafltAawYFcsf+h1S3Ae49RSJvT5zf9RmbpnaUgygnO2Zo43wTZSXEF/UdpTOjPauhr5lYNr2xZ/Osg8JgMjfX5X0JrJyH5U5ALqYO6f/gr3kBodzNOP/LdvNWtWpz8W/gO4+MR+UuOcn8m49aq54QnnN17NjlZYXlZAjF5K+hC2bT+fiziRxxglNGacbuoslnElZsCmQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=LOdAu+Ak; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=LOdAu+Ak;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfBxY4xFhz3bsj
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 00:16:17 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D5Yldb9M3W5x7RdcAalrRZW8t/j9o/BmEXWVY9QwfmnhIy5n0r+YpZdUYthDQ5RxarOKnMDHx5cG49T3Im5Dj75Vq+dmDJ+CtSZYc4z4Nil3L1IEuCRlZFgRSXepGKWz3B+OtlZ8iITzUADA7e3wE31rwjAJS4nYnqEE7m/tVY1Yn+ahuCv5oadddwZ78wszriDqF3aIkuy7Zjqt7PtnSwOw4KIlXwCAureQntH4+eAlybSQliRTNj18fit410+lbY9r5AO8NiADlEIZo/9GycdY8aDOumkUe5aYDOKgE3DnKqd758mbs2IANzqZkhHkrJmata5DzGts0/TDmYyUUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQTpoYqYDt+wwaX7XKeMsaf6yhmttUPt+OGGWaW5pwQ=;
 b=EPGmC93vVvLad1ScnXLGBPO/phzDS8DxtLYBxcs901WJMKPGP7dd3br1Ge2MLfz5GM8kOw9W0nQOxFlrF1JaUq1u8qgz7r8ijD3BhaRjwHStN3Rs/UgZVJjWa+TNqlLHGB1zbN+fmL1OdK9G3JxsqaO6oa/ViVb9/uICNnkJrftN2dhyzxk4d74Gmawzx1kDar8WuNa/1P9cTYoR9eU+KKSv+263TnYYPu0X3QiuJOoVJnRA37Sf9OTAUjHg0Ah2FkR5iX1qLBDL6ifwPDREtJe3sjjpfW683d9bJ83CIi1lkfoziRn0Bq5ear/As8zpSg7cAxl3y6r8EmdcoQOpMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQTpoYqYDt+wwaX7XKeMsaf6yhmttUPt+OGGWaW5pwQ=;
 b=LOdAu+AkHEzUYrksMzLOQFYchf2PHr7NuKH1bX+zoCcvC4zm2j3bSC/pjC1pbj2qhCDORYRIUc4gahtYzbqLY75+cNOZgeXrWdvWA2c2WqABgHg4XNetiDMjiWBGae6A30Cv3aOWk625g0o3z7R1rdn948fJOnhky8mLAiNjiMe3snU9nRZmxVaUgxl+7g3536JHNMjO7mDBBMqak/kRyqmPzTIgOJhSsWDtkB291g2BnZECVG3UzQfo6SpTiJT8/Wf40C0g7Z+qOTmgjF8E870TJpOw3eBJPkS370fiRQD5Ir5kWQeATlT/bxcVEFox/lbEp9sJwn599m1V5nfzog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM8PR04MB7459.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 14:15:54 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 14:15:54 +0000
Date: Mon, 15 Jun 2026 09:15:43 -0500
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
Subject: Re: [PATCH v2 04/11] ASoC: fsl_esai: Use guard() for spin locks
Message-ID: <ajAJD-xr0m2riJzL@SMW015318>
References: <20260615093824.115751-1-phucduc.bui@gmail.com>
 <20260615093824.115751-5-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615093824.115751-5-phucduc.bui@gmail.com>
X-ClientProxiedBy: SA1PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::16) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM8PR04MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: a07dbb7a-3446-4cf3-1315-08decae89c90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|19092799006|376014|1800799024|366016|23010399003|6133799003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	q0EvNCrQ+ujFr36yhfD8+idWbhwGKPL8QPuGJRgY3YDZ0IQKULTKwj1LN3C0zYE4dQFSnTZQRiXUitsczerlQ9nhFqbIYENZHN7xk1HOQAvPKIYO/A1OjgA6pteSq7Fj2MnWnb+bJRd5LYfQwSuwBo4XJolPupyLpWBSyjnvgx5AanwD88KZq1WSjjEAEj0WNkce11LwxnxLqcxnoLJ0eoUw4g1TCkDHzJ2LLLNlOqaPZx0vOPFya8R2vVIUOgvOzq27RcDUfnuK66yHGAESMafDgDggKNvqk5ZTaVBit89SNf81TYCOX83qlsTbZnbZ0a9FKFnFN5DDTfXCICFTcMJsWY0owkCyoywSkg3YM2p/lnfqpTJ1K+LCtedzIBlDv32lX4EOl5DI5iYBpVoEv2q7eupLKjFQiOamqkU3abyFZvbxOi+zYu5uS+XToBi/Wv5MlFDfG7kAPlYvwhFlCU5SEfsk2Oh4s/ADAlH1gP46DKWzX5jxmvtDSFBc4hxneXQKjS4ubwV+3PLJZ/ODPipzBpKeIPksrt1HA2Q6+K5wg9o5B1+OBeevGYmHMfu6CabEPDmC78XGRMPqg8anfQeod832y9yFRx4tNJBX7mXN2nAJ2+rj+XRSDSgxzEgkP3+wda5cRNm05xhuBPf77S3pyzX2BnyltXtfIIS60+8PP0/fDsI5ZSHb/ErwFgm3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(19092799006)(376014)(1800799024)(366016)(23010399003)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TDD4iMiraoQItmcuBCLDwsAiu8m2v+fyi0j5b/Yc6ki2gcZwYE99Ly8BTeqO?=
 =?us-ascii?Q?1F23xhMJ1m1e3NINyUbWkgTJFyDAYvX4m09jQbXACENMJUKUVr0/M318rdU+?=
 =?us-ascii?Q?n0nRWVJbgK0yxoNrVV1PNJPVhHhG5lA3VLBk3xIZl3u2Wxs05wHdknbpKm7o?=
 =?us-ascii?Q?yjTZ6b3YYwCJn5APj1dwuDyF8pwP0UbInHD/6LlcwTiQQk4czJ6zQ0qQMJih?=
 =?us-ascii?Q?xz/EFmZkDlAjURa5/DkWG3TT8gLb6C4E8ql5WvjKECylt7qRDD5t7FUizrUc?=
 =?us-ascii?Q?NBCMtZZqy0XDsLaa3l+dOav8yFPiSeqZdfcmyyuZYVRNaSYHK7dPjIeH3zWt?=
 =?us-ascii?Q?smmeOCwWcEgNfK8nQhTvWG0giKvgQAP78chPsFf6NKid553ECmhMEr+jDaHC?=
 =?us-ascii?Q?m1IwDcKumNIxyeaR3r/DHyrU70dW08RVqHzwIWyjvZF6Qm3XDiN9gxICDA8b?=
 =?us-ascii?Q?cH1mG1FNAxWCOQ2ch7v+ONaw4gWJ3jI6+wc0l4i+jCVRATUPWBE+gVlvUU3/?=
 =?us-ascii?Q?DHG8KRiToBwFA/u7aJ+JrEV0o7nxCcJOASiJELewrWofvgSDK/mkye1C5mkE?=
 =?us-ascii?Q?KdTil2n7uyF588aDX/DQnha4sMan4xvSY7KNB/BZ5XkaJbisNezFTGKQ1amq?=
 =?us-ascii?Q?Guk5i83DZY0OiBRYNlO6r0j0QcqLRd6BHClCjkJRrBD7aAvAJAFccIoSoN7/?=
 =?us-ascii?Q?i9LVNeofIgCZ9fzuEkurzpk/1FRGaoye9Y6o5HQS9AZSXjzGO4yBQTrwWRCc?=
 =?us-ascii?Q?/lIhGV9fnYyhz0Z6DqXJf1ub+lKBZz0THssUCiJO154BK8f8oxTtSgH66PPN?=
 =?us-ascii?Q?OJ0IBnwQ8i1lABAgJlrU8RXho5SDbwo7u7f2TxIz3vHLbX3YloWYkLIOZDCe?=
 =?us-ascii?Q?fT9J/8gW0ZPlw6SbP6qQknO4AnHPYXy3wOfWt2ToO6V07sIZXWy//9Qqr6ds?=
 =?us-ascii?Q?tDKd7iZa3GxgAaBwKGNkpq4egba9uXtxiICAvQgkj94M5EFUM6R9zbcMWYpf?=
 =?us-ascii?Q?aYmQ9eE4wcakHiqGP6tEAXz9BvoADta6NJe7HPx5eMENJPFZcWwe7Q/KJLHO?=
 =?us-ascii?Q?6dPkzQVK8fE4wJ/7tHhrr/uFXh52ljX0CMbyVOAp8ZL/iIagBVPSoF/TS7kH?=
 =?us-ascii?Q?uvCtQylXz743yIVYTkNzThIq98PPdaaf33hkoQ0Nb5H+QmSVR9O3g18lshgN?=
 =?us-ascii?Q?5nuXkDnCqBQCCxrmU4c6QeklclEkKrcXSBS6oZEGqJrp5g6E7Ee9eVyGuoXs?=
 =?us-ascii?Q?3rEejVhCI8toZNbhCRDxf01PleSE/gZWK7hsCTyPTkCLkmykS8RgnvnXa1MA?=
 =?us-ascii?Q?M88W7LMk1nTObhioe+hgVibJa70h8AVOdm9FpLCXYoyy7epnOCpDkOLioGIA?=
 =?us-ascii?Q?meup3XPgx4FaScUDNSfIIioQgKl+UlnuR5eyBMtfPUjuqlDSmplrDgAnhuD5?=
 =?us-ascii?Q?vC1LDXgjT0c07EJKCjXP1GeuaVkN7SoYCEaBdncA7bl+4HEbvfWXMMUQNiKg?=
 =?us-ascii?Q?laNpQhR/ULfTBgPXX8nanrjI9yeb7sHnU1mhDjwNb1vQt2TAb1TP9BitHdyC?=
 =?us-ascii?Q?8s13DNsQNi75LOvzjc4MCmj1YgdjUNWWljSo3bdy97OxPM2SqzdT5Jd4XJ/v?=
 =?us-ascii?Q?NzXEvReVbqN5FxjgGMRfkfM2N6gq8Zfbxz75mnkr0O4EAwkE3OVdJSvwtXJM?=
 =?us-ascii?Q?tYX/+gsffj3ynlN0qbcN03PtLw4M3AfY395Fj/FpPrsHeoWN2mQXuuZNVdSa?=
 =?us-ascii?Q?ytousWsQbOxfY3CYRELy4V6UWg4U4taqrroczPYaF5YqtFNjmm4f?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a07dbb7a-3446-4cf3-1315-08decae89c90
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 14:15:54.5223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dg8AH4nq9avAk0Sx0YV8hd4sd/LWhYPwWTCWW19plLVzGWvLVRC+yRpkYoa6NHmQ73ZUbhUPIvS2NwLFUx0U7VqSGv+9r6b21xCYMJPi591Vk/pKUrOizTpB91P8SIna
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7459

On Mon, Jun 15, 2026 at 04:38:17PM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
>
> Clean up the code using guard() for spin locks.
> Merely code refactoring, and no behavior change.
>
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  sound/soc/fsl/fsl_esai.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
> index cde0b0c6c1ef..4a530a6c33f0 100644
> --- a/sound/soc/fsl/fsl_esai.c
> +++ b/sound/soc/fsl/fsl_esai.c
> @@ -709,10 +709,9 @@ static void fsl_esai_hw_reset(struct work_struct *work)
>  {
>  	struct fsl_esai *esai_priv = container_of(work, struct fsl_esai, work);
>  	bool tx = true, rx = false, enabled[2];
> -	unsigned long lock_flags;
>  	u32 tfcr, rfcr;
>
> -	spin_lock_irqsave(&esai_priv->lock, lock_flags);
> +	guard(spinlock_irqsave)(&esai_priv->lock);
>  	/* Save the registers */
>  	regmap_read(esai_priv->regmap, REG_ESAI_TFCR, &tfcr);
>  	regmap_read(esai_priv->regmap, REG_ESAI_RFCR, &rfcr);
> @@ -750,8 +749,6 @@ static void fsl_esai_hw_reset(struct work_struct *work)
>  		fsl_esai_trigger_start(esai_priv, tx);
>  	if (enabled[rx])
>  		fsl_esai_trigger_start(esai_priv, rx);
> -
> -	spin_unlock_irqrestore(&esai_priv->lock, lock_flags);
>  }
>
>  static int fsl_esai_trigger(struct snd_pcm_substream *substream, int cmd,
> @@ -759,7 +756,6 @@ static int fsl_esai_trigger(struct snd_pcm_substream *substream, int cmd,
>  {
>  	struct fsl_esai *esai_priv = snd_soc_dai_get_drvdata(dai);
>  	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
> -	unsigned long lock_flags;
>
>  	esai_priv->channels[tx] = substream->runtime->channels;
>
> @@ -767,16 +763,14 @@ static int fsl_esai_trigger(struct snd_pcm_substream *substream, int cmd,
>  	case SNDRV_PCM_TRIGGER_START:
>  	case SNDRV_PCM_TRIGGER_RESUME:
>  	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> -		spin_lock_irqsave(&esai_priv->lock, lock_flags);
> -		fsl_esai_trigger_start(esai_priv, tx);
> -		spin_unlock_irqrestore(&esai_priv->lock, lock_flags);
> +		scoped_guard(spinlock_irqsave, &esai_priv->lock)
> +			fsl_esai_trigger_start(esai_priv, tx);
>  		break;
>  	case SNDRV_PCM_TRIGGER_SUSPEND:
>  	case SNDRV_PCM_TRIGGER_STOP:
>  	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> -		spin_lock_irqsave(&esai_priv->lock, lock_flags);
> -		fsl_esai_trigger_stop(esai_priv, tx);
> -		spin_unlock_irqrestore(&esai_priv->lock, lock_flags);
> +		scoped_guard(spinlock_irqsave, &esai_priv->lock)
> +			fsl_esai_trigger_stop(esai_priv, tx);
>  		break;
>  	default:
>  		return -EINVAL;
> --
> 2.43.0
>
>

