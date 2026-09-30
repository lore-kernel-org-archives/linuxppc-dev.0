Return-Path: <linuxppc-dev+bounces-28616-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC08FCA5FC5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 20:20:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hw5y14jllz2ygX;
	Thu, 01 Oct 2026 06:20:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790799609;
	cv=pass; b=JY9Xi6zGcr8RdGaqDrBhPWR3Nh+DQJxSE8QtlUd977JCHCAaxNXLjXit0/w8WZ7mD6+Dofb5ACgXscN2C7dPyh5zLN55c118a1XK8joI3aYYDncDziwvhvbnx8ok1mlx7459FEA1hzL1dTSLc4FDVxdnxCRVmEeCEpqT1bDq2AAlEgPwhaIlPp0jsJy8tXWECPjLmM7kIp0MiU1XoBmwYQ0XGw+9c8TSx9FIQc8TbiK4oTgeHPdDuyHNe35k2/UpJ2UNmu/EzsSEsMw3pgS5Bvt6SoDr7qwnnUWH0b2HFpFLBraFcyPJMWC7gwSyEZSZ2X/n2N0uAzgcgy1orBxF8g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790799609; c=relaxed/relaxed;
	bh=FyjLy732LoXSLY/3YjFdGuIybnf569ynjAUnNPiqDhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kp2aHMPuRyktXnltwTRl2IhFOgSOPO2Eb1BIcxWlbYGnIcaHh3nbEBcu35zKVAGTv6+CyKPShAibVyo/sE57ZjteGuac4lGL9o2bRpxco5OqRu3CvDtqCu0n8dx8yHirPyivviBGM4HTusHbXlws4SMoajcmcxRlwWZAkRFJe9BujDy4a9xVZI4VrOyb3dVCzU2w216gweVLUz8KiGBfQAUnv2+05oU0d+F35oLmKTixSKrSPTML09k7xttXrKHgjLrfO7INrP5svD4WRM2prYX26DpWAzQrWe0zAOnIJ7LjZIEkrBtCAxQdBxdjRY2RsRUVw6V71ZPK7wyUXw23fA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=e/CsBvNN; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=e/CsBvNN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hw5y01n4Xz2yfD
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 06:20:07 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jeRll0wiAJDmDkfij3y2WWNEilsiQKYJhQN/ezc4o0QPUdnPD5xeBt/c27+/vSw2vA9v++n5l8aEOe4+0DxihnoXRWj/EUZ5BSvm877EYMn9Y8rBJuImArH2+zm3PAcKOxMJQadNV54mskFpSIjE3GEahmDmdpBkISyipO8AZtDTdNnK0cHOibk/cXzSN7Z8MmdgcILTNkE+Pvo820HMb1LF+8dgKhELF44PUzsl+hNsrQhAOjCSm2n5ORX4P/lwbckquFbKr5V2DllYltpffdU0b1A5z6n0NIQWj6C3QFu6W4ke58kPutQIfYM7fV2GLJcBAmyLDk8wsjbE69A0uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FyjLy732LoXSLY/3YjFdGuIybnf569ynjAUnNPiqDhg=;
 b=PM75JxWfklGdnPufcwEwhCmvV3E0I2p/prlkmQf5JBs3QCG6zPx99kxCT8fIpiTV4U66Wr6XzSCpoeA3a8pPxT2mpOEsHy3IZUB7hRq/HwwyFf7iAfqH6IaXZEZaHLl+R9gSnB+Trf9HmIhFeTGELJzyEAXyTSedJnU0a1oLL8Xyk9WtW1w7V2j1baehegUQXmOK4tC3TBZD7Kb0+ndkfm1wJWvh8ml/ideFO2aZorwKskoVN2o7WM2zRR53a/vf+VQOhpOAEHphZ/9choPO8/LXUhAcvmM3ipqH24T2BCQbLkIufh/f8PLAwDjuYxC03Ky3nt+f64hMHT7doMiLtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FyjLy732LoXSLY/3YjFdGuIybnf569ynjAUnNPiqDhg=;
 b=e/CsBvNNLWK09hAFRQfmoz88t4/t4q6eSgbInkjDrGHi3UANm77jBOrmDciVxhR1rxOzQl6Jgoz3ampzxM9oIVNWUNgwNnSUjD+DPHbkSSbJ+bJXiflQOiDs4o/n4EOt5Ly0DDZSobEZzE9LEgSFSGZnmywUOT/Xb2CkBN3vdpexdgqmVOQ24gRK40Ep21JK17QUo0abI6sjK+1924vejD004XFe7TsfX3/HRfb3/HCDjo7CGJI/PzcGAK0g1zprDsKqFWAwqqE6YHDB3gLyuiVgwIbWG9a9wg/gGsJpvCKRC+RaEWLQK32HPywPQU0Hbe1WEw9AirN/Jchb1kJOKQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by MRWPR04MB12096.eurprd04.prod.outlook.com (2603:10a6:501:98::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.27; Wed, 30 Sep
 2026 20:19:38 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 20:19:38 +0000
Date: Wed, 30 Sep 2026 16:19:31 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:FREESCALE SOC DRIVERS" <linuxppc-dev@lists.ozlabs.org>,
	"moderated list:FREESCALE SOC DRIVERS" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCHv4] dmaengine: bestcomm: use platform machinery to get irq
Message-ID: <ar1u0wRov8d_Rxle@lizhi-Precision-Tower-5810>
References: <20260919001931.723402-1-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919001931.723402-1-rosenp@gmail.com>
X-ClientProxiedBy: CYZPR12CA0002.namprd12.prod.outlook.com
 (2603:10b6:930:8b::13) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|MRWPR04MB12096:EE_
X-MS-Office365-Filtering-Correlation-Id: 851913d8-2dd2-43ab-4198-08df1f302705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|19092799006|376014|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5qu/hXYfFP/a113frSmwkk3lyZetF98PCazgFEZA2s8VteUohbu2E7q2Q1DdA0mlVX1nb9kqzmykGi0tiFu1k881aeh52x39vFVF9U/h5drIzTpS57Jej/l0zBp96xXpbrymWnzKOkXh+IgIi9oiOLM2izRECv15OZ9gZQV0e3eQJOXYnXHuA3Gl6YP0GOVxGRfNIt9cyouFppZwuToBVL1Fc92Y2Dd7mvxWKIYRTjSDdPSq3XeCS0NoiHJR6CACghtTnz69kM4jvaxjvLbg45FxLERk9AxOhSpzSSNxb8qDgiihnaJWhqT7+0SwnRYMj6ppy4LMeXOttluIZbaSMGgcat6Fmo74/XjEymsmlm+jRKrAb7RmLJQCPatFtGwKsWrk0eBTdjNpaImi8NLCBwOPZ+vi99bJC7kE3h18rupsZRX/tKdj3QZsxaoSnek75DKBA0xdI8F3lOAZGtr00YH4Xo9t8MHrYLYT9BsSnI4T5JIffzC2HoqI9bOeGn4p2FFV6RQU2PQNt9JHkNDjJ2g8u4Gu39zepN9RfrniXSmwStsw2SYqWnHuh/1tYtd/TlR0Ox5FO2ETC49PS+8+pD2ix82GvijWXD46w/9/bN6O9NcFNbzHgVJEVsLp7vpbER3TYvHk3FAmizFH/llvj4cS4Ch1Sj5S0akLB/KCKW0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(19092799006)(376014)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rXiAfXcYqMDGYdCfdWLIK/2v1Dv9L+smLZcX+9dPsbSfKgw2bCueh0TPlinY?=
 =?us-ascii?Q?Dmv2m0Wdw8S18mHC8bcFh4ktB+YvTxvX9mytH6tzeDoxUFxUIFvC5jA4sSvy?=
 =?us-ascii?Q?cQQxpNH3G3e2sknoE7OhZ4XJNIW+lqfo0I841PuxvoaM0Y9Sio+qec9qWOrv?=
 =?us-ascii?Q?oFBjrMPiGhrVzqI01MX+7JVLfkhGrN3VEhjKei5EJpguXzuGgjSN7fLFjvxy?=
 =?us-ascii?Q?x/nduX0wGM6nvX50RG1+CHu6mj9QNmCOakxwEDRn36Wj0tNyYHbksiJkPP7e?=
 =?us-ascii?Q?JFDuE76/AikGluoljy0Y8tV8BSwISqUPviC2nxVSQm8zd78jLM/KYVBsKEZ+?=
 =?us-ascii?Q?JqBITVxR+l/P3Yh7nJwJkf4JCX+wvoX+jlPcpi7k7KYhsV3vfwAzR/1SovU/?=
 =?us-ascii?Q?oJj1ugD5MtToeNJdjqJ9feizCLkQgVPByMqCp49kEdTTrLrhNWwZzDSy7Q4A?=
 =?us-ascii?Q?fMVWq8H0vKZiT6TGk+nqrE1CdPfj2UM4DCNIA6sn06ricCKBBSZuPX5BLmgE?=
 =?us-ascii?Q?ZAnGNTmhW2exVTB9JVGFmHcoAV+2VMoFvtwTYT4RRzHx4AkbzjYm463v7VHa?=
 =?us-ascii?Q?R8/jEwTnXtgmtx9qoOMj8Twi8ufdN6XJ1WxFjbnk5yH67dCAEB2lerNdKV2n?=
 =?us-ascii?Q?Uy3biSGSMVhTG0+BZfbp4G8liLJNjKWA1WFTX62w10RipIseoWsy5uohzDaE?=
 =?us-ascii?Q?XkA9/cZf2IFxIX90H+DsqF4u1bYmPO8XUaKb+Og38CKh6U0ZphZXtu/TZFwa?=
 =?us-ascii?Q?LC8XYFCryR/MvbKGMB/mWkESkFm5xUPidrSrzU06ZqHF/1Xp8qvexeyQl+VP?=
 =?us-ascii?Q?eqWNME9MiIVRsHAbYN5P62HsFmsb/OdytIiylhNjLLniV6lVzqhgZ6u0fPzv?=
 =?us-ascii?Q?swaw5JdFP/s8FQnHRxO1+mRlLl4jBPfRh5Ejl39Y1ar+YDow3RKDhW472lM3?=
 =?us-ascii?Q?q4CEmE1rNoWOCEQCPE5pFhmoS1uTU8I3GnXjJ3gmCqT6vxUTHJDyAFTuwIB7?=
 =?us-ascii?Q?EQHfrqBHcVvABziBqG4wOAFCukwX504eZn1HCCdaX7KneSb7xL8lMC0QPLsS?=
 =?us-ascii?Q?Qp+1dmmqnaNA/89t9WmfyFnOlhqhRq1gfzkkGYf0gxL/gSaZ4BUZGFoOl4WF?=
 =?us-ascii?Q?M+uk2EPPP8ZzPy6CpEQcnanOTIYop/442bNCjkcXsankUpCG2cZfASh+oVzj?=
 =?us-ascii?Q?VliXOW0RM9crOlgD/6LD+YzPasLSN0coxbVWA5/VUclpEpN/+CKopKLFzJUY?=
 =?us-ascii?Q?h/eBKiK2xGmToR6NpEM4wd5iEoJ3PtvLXIxhtG49M08xqMtid5bZcl6HxC/l?=
 =?us-ascii?Q?THMBVYBJnP/XTjIbpupUTfT8rw6rgjRljfES25uKD3oMExxn4yx0f0HzhmKJ?=
 =?us-ascii?Q?yGNM86exTROn4uRA+BOuNmaUhA/OwzsuM4XU3o/RhVG+9G2TCueZf71zAQY3?=
 =?us-ascii?Q?casEPKxunmtlLOLFIIzmEImz1pHZrlwjwbjBRxxpp1h8nO4vTcL2BnhLAnPq?=
 =?us-ascii?Q?uaEkQW89OfLGvhePoL2XhYw1ZJICPTlmNg7pOgN2YIQuNc3dFY9kuTJOdoNB?=
 =?us-ascii?Q?RGtRl+ZVs92+iU3h5MjJKsTKrhag/GAt0HS8E65RqdW965VWPx4bglNyCOB4?=
 =?us-ascii?Q?xCzi5h/qloLyBmU6OTsDI/l6ZiaOaDLr2L1mM0flLJkh2Ser9QbOBWnj1iNk?=
 =?us-ascii?Q?Wmr1NJFCgseb+TvUY1ybBllwNJGu0utljGvffkmnGAuT3b3Ap1AUibEhoFsT?=
 =?us-ascii?Q?hJUu8gx4dLI2hbhDpOY7+Tr7BnTYHZuhEGDJCnkPavhB/+q3HZwJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 851913d8-2dd2-43ab-4198-08df1f302705
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 20:19:38.5323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4/ifknOMVEOmwDA3/K7+VSFP6V7sxKTucsdSr7PCincg4HiXXQ2O6Ina3tTq4zfy1tOdHrHumYgX2AQbYDf6YAdN47jgwqJ4SEaSjeEJMTm0Q8n1rNaKD81vuCrthRGV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB12096

On Fri, Sep 18, 2026 at 05:19:31PM -0700, Rosen Penev wrote:
> platform_get_irq() avoids having to explicitly map and dispose of an irq
> by having the platform_device machinery take care of it.
>
> This requires replacing the device_node with a platform_device in the
> bcom_eng struct so that platform_get_irq() can use it.
>
> Conveniently, this also allows getting rid of of_node_get and
> of_node_put as the platform_device machinery also handles that.
>
> Adjust the goto labels in bcom_task_alloc to match what is being freed.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  v4: drop whitespace change
>  v3: drop stale description
>  v2: resend
>  drivers/dma/bestcomm/bestcomm.c            | 46 ++++++++--------------
>  include/linux/fsl/bestcomm/bestcomm_priv.h |  2 +-
>  2 files changed, 18 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/dma/bestcomm/bestcomm.c b/drivers/dma/bestcomm/bestcomm.c
> index 241a91936fe8..310792ccd748 100644
> --- a/drivers/dma/bestcomm/bestcomm.c
> +++ b/drivers/dma/bestcomm/bestcomm.c
> @@ -47,6 +47,7 @@ bcom_task_alloc(int bd_count, int bd_size, int priv_size)
>  {
>  	int i, tasknum = -1;
>  	struct bcom_task *tsk;
> +	int irq;
>
>  	/* Don't try to do anything if bestcomm init failed */
>  	if (!bcom_eng)
> @@ -67,30 +68,32 @@ bcom_task_alloc(int bd_count, int bd_size, int priv_size)
>  	if (tasknum < 0)
>  		return NULL;
>
> +	irq = platform_get_irq(bcom_eng->pdev, tasknum);
> +	if (irq < 0)
> +		goto err1;
> +
>  	/* Allocate our structure */
>  	tsk = kzalloc(sizeof(struct bcom_task) + priv_size, GFP_KERNEL);
>  	if (!tsk)
> -		goto error;
> +		goto err1;
>
>  	tsk->tasknum = tasknum;
>  	if (priv_size)
>  		tsk->priv = (void*)tsk + sizeof(struct bcom_task);
>
>  	/* Get IRQ of that task */
> -	tsk->irq = irq_of_parse_and_map(bcom_eng->ofnode, tsk->tasknum);
> -	if (!tsk->irq)
> -		goto error;
> +	tsk->irq = irq;
>
>  	/* Init the BDs, if needed */
>  	if (bd_count) {
>  		tsk->cookie = kmalloc_array(bd_count, sizeof(void *),
>  					    GFP_KERNEL);
>  		if (!tsk->cookie)
> -			goto error;
> +			goto err2;
>
>  		tsk->bd = bcom_sram_alloc(bd_count * bd_size, 4, &tsk->bd_pa);
>  		if (!tsk->bd)
> -			goto error;
> +			goto err3;
>  		memset_io(tsk->bd, 0x00, bd_count * bd_size);
>
>  		tsk->num_bd = bd_count;
> @@ -99,15 +102,11 @@ bcom_task_alloc(int bd_count, int bd_size, int priv_size)
>
>  	return tsk;
>
> -error:
> -	if (tsk) {
> -		if (tsk->irq)
> -			irq_dispose_mapping(tsk->irq);
> -		bcom_sram_free(tsk->bd);
> -		kfree(tsk->cookie);
> -		kfree(tsk);
> -	}
> -
> +err3:
> +	kfree(tsk->cookie);
> +err2:
> +	kfree(tsk);
> +err1:
>  	bcom_eng->tdt[tasknum].stop = 0;
>
>  	return NULL;
> @@ -125,7 +124,6 @@ bcom_task_free(struct bcom_task *tsk)
>  	bcom_eng->tdt[tsk->tasknum].stop  = 0;
>
>  	/* Free everything */
> -	irq_dispose_mapping(tsk->irq);
>  	bcom_sram_free(tsk->bd);
>  	kfree(tsk->cookie);
>  	kfree(tsk);
> @@ -377,16 +375,12 @@ static int mpc52xx_bcom_probe(struct platform_device *op)
>  	if (IS_ERR(regs))
>  		return PTR_ERR(regs);
>
> -	/* Get the bestcomm node */
> -	of_node_get(op->dev.of_node);
> -
>  	/* Prepare SRAM */
>  	ofn_sram = of_find_matching_node(NULL, mpc52xx_sram_ids);
>  	if (!ofn_sram) {
>  		printk(KERN_ERR DRIVER_NAME ": "
>  			"No SRAM found in device tree\n");
> -		rv = -ENODEV;
> -		goto error_ofput;
> +		return -ENODEV;
>  	}
>  	rv = bcom_sram_init(ofn_sram, DRIVER_NAME);
>  	of_node_put(ofn_sram);
> @@ -394,7 +388,7 @@ static int mpc52xx_bcom_probe(struct platform_device *op)
>  	if (rv) {
>  		printk(KERN_ERR DRIVER_NAME ": "
>  			"Error in SRAM init\n");
> -		goto error_ofput;
> +		return rv;
>  	}
>
>  	/* Get a clean struct */
> @@ -405,8 +399,7 @@ static int mpc52xx_bcom_probe(struct platform_device *op)
>  	}
>
>  	/* Save the node */
> -	bcom_eng->ofnode = op->dev.of_node;
> -
> +	bcom_eng->pdev = op;
>  	bcom_eng->regs = regs;
>  	bcom_eng->regs_base = res_bcom->start;
>
> @@ -426,8 +419,6 @@ static int mpc52xx_bcom_probe(struct platform_device *op)
>  	kfree(bcom_eng);
>  	bcom_eng = NULL;
>  	bcom_sram_cleanup();
> -error_ofput:
> -	of_node_put(op->dev.of_node);
>
>  	printk(KERN_ERR "DMA: MPC52xx BestComm init failed !\n");
>
> @@ -443,9 +434,6 @@ static void mpc52xx_bcom_remove(struct platform_device *op)
>  	/* Cleanup SRAM */
>  	bcom_sram_cleanup();
>
> -	/* Release the node */
> -	of_node_put(bcom_eng->ofnode);
> -
>  	/* Release memory */
>  	kfree(bcom_eng);
>  	bcom_eng = NULL;
> diff --git a/include/linux/fsl/bestcomm/bestcomm_priv.h b/include/linux/fsl/bestcomm/bestcomm_priv.h
> index 3b52f3ffbdf8..cddde7c74cb5 100644
> --- a/include/linux/fsl/bestcomm/bestcomm_priv.h
> +++ b/include/linux/fsl/bestcomm/bestcomm_priv.h
> @@ -66,7 +66,7 @@ struct bcom_tdt {
>   * This holds all info needed globaly to handle the engine
>   */
>  struct bcom_engine {
> -	struct device_node		*ofnode;
> +	struct platform_device		*pdev;
>  	struct mpc52xx_sdma __iomem     *regs;
>  	phys_addr_t                      regs_base;
>
> --
> 2.55.0
>

