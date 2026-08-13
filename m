Return-Path: <linuxppc-dev+bounces-25829-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B9C3C5CFCF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2026 16:52:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLWcz0PC4z2yfR;
	Fri, 14 Aug 2026 02:52:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786639970;
	cv=pass; b=hjkNdqALJ26Y24r58wAf0M8/LWSRW+rjzqV9ZyiGWSWOUQYsi4ctxor/CvZPRVv4SH0vG3SN9Mbc4c/MOo3hgpumY6kr8FE1j31jbPXOURqt+uICUTeq+NpF8KmC/CliSHqPNgMZqDCwP50shTYjsmg7Qd2660Fe/8jBzPtfUcPWYkfHNQTmHxJW8NBgQBjvXIJTuoHckhQWjiO12nZO6GSGRvn3Wlt2Av/ma++jT2tneyYIXEtL882ABmyKs2Ec+ckrEC1E0rsi7WlYzQvjvfR1bUY82lSq/YQ5UaKXRHX0x6LZTpWXc3Fk94gXbTQmzyfVX9EIeS/zt/zriMiUIA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786639970; c=relaxed/relaxed;
	bh=0ITP6GKQxW6bbG8FtbmtnHFu87zPQthUaNPlr47Ojjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e6Gp/+TCMt/4OW0aOebutl/QQ/pUtiLcBojYTn53kIwu/cVrbmBRthWsc9GdWcfKhwQNXvy4mSM9rw52HHG4MYYr7CkEBz74y1jhxtgWOTNhESDDtvAelN6bdsOZFUrL9jwKiHpJquZ41TdU8sEwSHcgdIMo7DOurBbNvJStMrTvoJgsje5RDsGntK3bukHXu0G1QCJty2awSwlyr+UOv0uXiUjqaNj8FcraBLxBki6i8y/5BPiORuooBWF9CJoEJzwLBUo1lHOl1nxa0MizTJvL0Zx4Ft8bgtCeTdreWS7EU/gNqDzYS5npG9ZdRGXSXHXjTeK7snXhV73ywfvv9Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=KE7hGyLV; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=KE7hGyLV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLWcx38Jbz2yKD
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 02:52:49 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHOpDcmKSs5AjR1/0oPfVaZZHy63yrK/Pd4UFf4IoTXU7DgG03zJr6WizKsqZfj33RIhEwSQ6uGlh9wsrfLNi9wW679r+aMxayVuC+1I3OkVPHJdxE1IJ+wv3JjxZ3+pErOIKpAJZBT+Zwi3S9MDbN07v0TFm0x4lr6cxYbvecAac0zvI35EGJO6VMVMWwXQra8jM2aj7yaG02PAsK/x+uo1knAkyvY7n+3pH6kvNKp+07cfsQnidC8T9W7WcouDmiTUPzItLENPVV7beAP2rPrrvFMgMovokiX1V5pl8TnhNsJIQqFxyMrW6eyefhidHE++QhOThRnWMwxza9z2dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ITP6GKQxW6bbG8FtbmtnHFu87zPQthUaNPlr47Ojjc=;
 b=Oc7XEmiPv7Ec5vVTjUAKvO4G6CeIe6m2tZO/PF55f7lFtff4n9uKyymAYoCcjmfRuFbEND3wxjXLVI6ld/0ALVyGGIeOj4ulNy28RytdYOvlk5z/xkAnI1SynOC26fEw8m6YYeH8nkl9L7ot4HW8kew2obGIaiEGcqjzITwlx4Ka1iEgmNLJlaL/zIyuhUKKBE+Mt+wRVqCanNOHTTipZz002K2LSNqRPlWPPAoq8z3tR+KDiYW21EcOLlombUH7kafSXKBDr7Ivrsn8FZDwu/9C7msWJoHTQdz4aYtyBDsp2BDa91MskMHqUSdNSnG6asDHTvl4gu2Y154yyb8NcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ITP6GKQxW6bbG8FtbmtnHFu87zPQthUaNPlr47Ojjc=;
 b=KE7hGyLVTrruKPKMVEtmQ4IyWt5nJOZ+gxPZO4Ru+L1WROj19RNlyqcLbbbxF2v0AjVtravGxkkvQmTfrPp6mJ1raHqtbXsvQF+/UCcsROn1DuNu3hqlONjhrmTsug7D3rz539BPtrAiwCFTUQCmDtIP/GDSgXCq8nuEJDYc2mc09pwTIAD1eBaprB/fZ4lOxrTZz1uNjQyQROybtC+ZhQH+4nyFd/esO0SbbZ6zO9mk3nPc5m3cmdD0IGDunnxm8qMjHV4fgebz6aY5FSbX6u+P/gnS5eeAPFOf1uBiqdfTtOugM6e47e2ohQ8VTpLxs0KGudcJjOJytjliWFZ3wQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com (2603:10a6:10:623::11)
 by VI0PR04MB792713.eurprd04.prod.outlook.com (2603:10a6:800:365::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 16:52:24 +0000
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de]) by DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de%5]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 16:52:24 +0000
Date: Thu, 13 Aug 2026 11:52:17 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: shengjiu.wang@oss.nxp.com
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, Frank.Li@nxp.com,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	shawnguo@kernel.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com,
	nicoleotsuka@gmail.com, perex@perex.cz, tiwai@suse.com,
	linuxppc-dev@lists.ozlabs.org,
	Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v4 3/5] ASoC: fsl_asrc/fsl_easrc: move DMA params into
 pair/context struct
Message-ID: <an32QUTIbtVn1G-I@SMW015318>
References: <20260813070020.719810-1-shengjiu.wang@oss.nxp.com>
 <20260813070020.719810-4-shengjiu.wang@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813070020.719810-4-shengjiu.wang@oss.nxp.com>
X-ClientProxiedBy: SN6PR2101CA0007.namprd21.prod.outlook.com
 (2603:10b6:805:106::17) To DU4PR04MB11791.eurprd04.prod.outlook.com
 (2603:10a6:10:623::11)
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
X-MS-TrafficTypeDiagnostic: DU4PR04MB11791:EE_|VI0PR04MB792713:EE_
X-MS-Office365-Filtering-Correlation-Id: 4de6bd55-c99a-448b-dd7d-08def95b3fd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|19092799006|376014|1800799024|366016|6133799003|10067099003|4143699003|11063799006|22082099003|18002099003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	gh0gKmc4EIVDywIF//jcN+79g3zaTYvPIPujFZSSJT0GnfNs8CYXc+5BXN4PbwA5WaTfsw/g19pnDntG6JZviVO40TgpYdfbGXF8c25j47B1ut+VVNdJyF4IBpU1Bb88Y9rxVxMJvtwXm3bCM7ZZGmrm53lrxmT5bEF/tCp2jxAI62q3YOCGN20GFE3dfBp1jL+Xdy08GcL31AP+axwO9eR86EW7dIZDYoC88+6zGTNn7uWeG5uKdu8RXkLQsoL8orCg/fMgVKH0tc7vg3hYOaVypRYGtXUnM8eKT8fC0ZjeQsMdYQ8susTwntnkI0+gvEWVgOTcje7T07UGGeFCkXjYOae+RZUn0nOWoitWayeai3I2X+T0DGrlXz8TcpO6tf9F8HIv/50gpdxynpPtxFHGhfteWESwwyVNxx8vHKwYmUmE0wKYrbPTOst5Qcm6c4DaQ7Iuz+s4TUUhO7o7IqwmqBBk2tYVzcjSSutcfI2LA5eVL9Dynu3CqKl5i+1VRy6WyPCDqy2HfOKMy8/RPteeN5PWjePP1csDnOZyp4X9zLe5eOUqZxc3Sq01068VdB9JmAelsGK8AfYt8Bat7njDF+qrO5dxtndooevHArgBp+IhYyJ2PhXq7wyT2JnSBrShtYj3oyn9QxgciZkOzwysm/xSxqMOvJyOxp+46Ok=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR04MB11791.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(19092799006)(376014)(1800799024)(366016)(6133799003)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cI79Eqgv8XkjLOYguBNTpJD1UZN6GbpW4SViPSrXyinvmrkR8o+YrCGcXdNw?=
 =?us-ascii?Q?WCMgXJu4uQKYWkq792tAI9KhJl82VnHZBischqMWGWiu+j4c0fT1sgS2vs1c?=
 =?us-ascii?Q?sKmNCTCyZwhBYvxg7qImPM+05C15J2QSrVVqukf6QW1t9vhEfw5yJqcgd/7k?=
 =?us-ascii?Q?zRFcWZg/T0qjATSIJiSlEeOrbyzGnN4ZupmAxOHx0wYD9qMNtgXClweJUg/t?=
 =?us-ascii?Q?OwKs6aCXAKFEoXpGSf/tXCE7TKytA0vdzSeLZA+3lk2uQAelGn0BxmDw7btf?=
 =?us-ascii?Q?ZoczvnFRpwp3sr2S7EAltEI5jbKuN5OxcabQRpQgZleUmLGz3qQr7DPyWE1d?=
 =?us-ascii?Q?XpAgpcj3NOYRcU6JanJjn+tJE0hZWQ/48DUDV0LKpGbt0JvYD/UD0DiLhBWZ?=
 =?us-ascii?Q?dPPzyTZiaQ/txw5EfaJM8UOwYsZH9VJG9j4gdqYOoR6Xn+z+I4Xr5mcaUfCo?=
 =?us-ascii?Q?nRx6p7OBWOd2Nq0rcVbYF1Ta73l8jiftIMo5qgE7ClLX9rqcrMS/rKImdO6E?=
 =?us-ascii?Q?lKJ2JU8huMUVtBQj2qW0HR1/1pp3/weEDH1nSBEdSHN4xlVzvmMiz9Fr7o6B?=
 =?us-ascii?Q?LYTjweDN1+QWdlPGHvX8pXbaNHik4LrGB9Iv5xsTZ5NDrOIgPyCopv8jggSy?=
 =?us-ascii?Q?sbV5cUjKe/6z5g8MboMc9w4BWSk4l3i1XSAcoFtIbu+hP9rZppYE1dQKSKP6?=
 =?us-ascii?Q?zxbXBpJ6TB5+kHrdZE9hhJKA6qYfqAKvLslqRyOeNbDRe3o9z+90bJoE5T7p?=
 =?us-ascii?Q?NnTelgL6yKkWh3ZWT3HBQSZsEHYHy7Fxx7kwDVTA+r6diHq3QXDwBnjrupLw?=
 =?us-ascii?Q?QJhIz+W3hfE6TnA/8yPxEbQga5gZZtmA/M8EoOs+k86RH0leUpY3wn5i35jl?=
 =?us-ascii?Q?CakgNi+9MRxajUkb3FM4TRAwjC8+KbawMOTzif0yETHRgSeoC2lZXQ4PXcKA?=
 =?us-ascii?Q?/iDz5VZIHnqPmdCLSwlH8xZCDhjLuIlb50NcljsDYRCaII1Ca8dX/e3lsRoA?=
 =?us-ascii?Q?St1Rd6jXqez46pVtXJXTc4pM8vH2SZ8ZKLz18WRPX8xg5UMC0Q1brkKBlwQ8?=
 =?us-ascii?Q?JxeXlYa2l1qQi9oYi05DysPjRrPliav7wj/oJp0690appzs4o+oegx8G0ccP?=
 =?us-ascii?Q?hRd9z24GkgZ7nQmCTQvOLY7eH6XYMLHQMNAX5/gSI+u0LtuLujQ9OUl/3I3i?=
 =?us-ascii?Q?oVWH74BgAWV7n0bN1wCP0AugG5yHO2bnfPzWNDsYf0MZ94Kjj0HsZm9/hPYq?=
 =?us-ascii?Q?ogibggxAsgnj/En5UbHKqkplcuQvKInkl75PlZ4qnZ4T3YnbnRN7UFVzq6U1?=
 =?us-ascii?Q?ZH2kF8XY72JXkgjergk+RSDJWOjdACXiC3BU/0oIYRFzjH6PaHvlvtCd7ztT?=
 =?us-ascii?Q?anoDTpfvjAD2LuQmECYHI7fTuevGFkOEavy6voEvX+m1DeVGI9+kum7Rj8An?=
 =?us-ascii?Q?cD90OC53G1kW1rYxfX3IGd6KkS4vOSGdCfBaDHYnCvINC3Bc/1hKfg/g5aGK?=
 =?us-ascii?Q?ScMo4J8fl0/q4/rltJVkuiwjr0py+uxHSgxEMCO720aclu1m8IiMtdJK/kne?=
 =?us-ascii?Q?TmA1J5JDT+gbzPPBIjvS8VbZWZDu0am8QAkTU9dSSoLou5QuDlpX+oYGb5Vj?=
 =?us-ascii?Q?og5t3LCknhFpmVbEkMBWwBG98BpmyTqsEP0I6G3KbgkqY30gLyiP+6+eNKCW?=
 =?us-ascii?Q?GSr2d/E1GDHXmfU+dzjeAPTn79N6pMh8xHqpboXh/RHfsnND8h0PJa/r2fs8?=
 =?us-ascii?Q?YO/svOqtX2P26+eaOA8o6+QkgGsL5IIbWJU+A7jAZ9/uLFuxIHaY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de6bd55-c99a-448b-dd7d-08def95b3fd8
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB11791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 16:52:24.4790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LeDkrsGyPbVehbr4vPuaPaCIIK/tcejvEdDeUVMCiX8c+FEMYLd5N0miWt2vwxMRkjehmaWd3T/mA3zCS2KLeaeJBiTPsUlNNNucn9s3yTMtU7b3OxKcF4cERIU2O5wE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB792713

On Thu, Aug 13, 2026 at 03:00:18PM +0800, shengjiu.wang@oss.nxp.com wrote:
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
>
> The shared dma_params_tx/rx fields in struct fsl_asrc were a single
> instance written by every concurrent fsl_asrc_dma_hw_params() call.
> With multiple DAIs registered (one per pair/context), parallel stream
> open+hw_params races would corrupt addr and maxburst for all active
> streams.
>
> Fix by moving dma_params into struct fsl_asrc_pair so each pair owns
> its own copy. Initialise them in fsl_asrc_dma_startup() where
> the pair is allocated, which makes the per-DAI probe callbacks in
> fsl_asrc.c and fsl_easrc.c redundant; remove those as well.
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  sound/soc/fsl/fsl_asrc.c        | 11 -----------
>  sound/soc/fsl/fsl_asrc_common.h |  7 +++----
>  sound/soc/fsl/fsl_asrc_dma.c    | 14 ++++++++++++++
>  sound/soc/fsl/fsl_easrc.c       | 11 -----------
>  4 files changed, 17 insertions(+), 26 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index df4817ae91b1..2755ee57c6a1 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -781,18 +781,7 @@ static int fsl_asrc_dai_trigger(struct snd_pcm_substream *substream, int cmd,
>  	return 0;
>  }
>
> -static int fsl_asrc_dai_probe(struct snd_soc_dai *dai)
> -{
> -	struct fsl_asrc *asrc = snd_soc_dai_get_drvdata(dai);
> -
> -	snd_soc_dai_init_dma_data(dai, &asrc->dma_params_tx,
> -				  &asrc->dma_params_rx);
> -
> -	return 0;
> -}
> -
>  static const struct snd_soc_dai_ops fsl_asrc_dai_ops = {
> -	.probe		= fsl_asrc_dai_probe,
>  	.startup	= fsl_asrc_dai_startup,
>  	.hw_params	= fsl_asrc_dai_hw_params,
>  	.hw_free	= fsl_asrc_dai_hw_free,
> diff --git a/sound/soc/fsl/fsl_asrc_common.h b/sound/soc/fsl/fsl_asrc_common.h
> index c8a1a2b5915d..4e6b00cb5d63 100644
> --- a/sound/soc/fsl/fsl_asrc_common.h
> +++ b/sound/soc/fsl/fsl_asrc_common.h
> @@ -53,6 +53,7 @@ struct fsl_asrc_m2m_cap {
>   * @dma_data: private dma data
>   * @pos: hardware pointer position
>   * @req_dma_chan: flag to release dev_to_dev chan
> + * @dma_params: DMA parameters for transmit/receive channel
>   * @private: pair private area
>   * @complete: dma task complete
>   * @sample_format: format of m2m
> @@ -76,6 +77,8 @@ struct fsl_asrc_pair {
>  	unsigned int pos;
>  	bool req_dma_chan;
>
> +	struct snd_dmaengine_dai_dma_data dma_params;
> +
>  	void *private;
>
>  	/* used for m2m */
> @@ -92,8 +95,6 @@ struct fsl_asrc_pair {
>  /**
>   * fsl_asrc: ASRC common data
>   *
> - * @dma_params_rx: DMA parameters for receive channel
> - * @dma_params_tx: DMA parameters for transmit channel
>   * @pdev: platform device pointer
>   * @regmap: regmap handler
>   * @paddr: physical address to the base address of registers
> @@ -128,8 +129,6 @@ struct fsl_asrc_pair {
>   * @private: private data structure
>   */
>  struct fsl_asrc {
> -	struct snd_dmaengine_dai_dma_data dma_params_rx;
> -	struct snd_dmaengine_dai_dma_data dma_params_tx;
>  	struct platform_device *pdev;
>  	struct regmap *regmap;
>  	unsigned long paddr;
> diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
> index 2f662bdf14d0..15f2dccc3584 100644
> --- a/sound/soc/fsl/fsl_asrc_dma.c
> +++ b/sound/soc/fsl/fsl_asrc_dma.c
> @@ -392,6 +392,20 @@ static int fsl_asrc_dma_startup(struct snd_soc_component *component,
>
>  	runtime->private_data = pair;
>
> +	/*
> +	 * Point the cpu DAI dma_data at the per-pair params so that
> +	 * concurrent hw_params calls on different pairs each write to
> +	 * their own struct and do not race on addr/maxburst.  Use the
> +	 * per-direction setters so that a concurrent open of the other
> +	 * direction on the same DAI does not NULL out its pointer.
> +	 */
> +	if (tx)
> +		snd_soc_dai_dma_data_set_playback(snd_soc_rtd_to_cpu(rtd, 0),
> +						  &pair->dma_params);
> +	else
> +		snd_soc_dai_dma_data_set_capture(snd_soc_rtd_to_cpu(rtd, 0),
> +						 &pair->dma_params);
> +
>  	/* Request a dummy pair, which will be released later.
>  	 * Request pair function needs channel num as input, for this
>  	 * dummy pair, we just request "1" channel temporarily.
> diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
> index 77c5009cc01f..d23ee482924b 100644
> --- a/sound/soc/fsl/fsl_easrc.c
> +++ b/sound/soc/fsl/fsl_easrc.c
> @@ -1582,18 +1582,7 @@ static int fsl_easrc_hw_free(struct snd_pcm_substream *substream,
>  	return 0;
>  }
>
> -static int fsl_easrc_dai_probe(struct snd_soc_dai *cpu_dai)
> -{
> -	struct fsl_asrc *easrc = dev_get_drvdata(cpu_dai->dev);
> -
> -	snd_soc_dai_init_dma_data(cpu_dai,
> -				  &easrc->dma_params_tx,
> -				  &easrc->dma_params_rx);
> -	return 0;
> -}
> -
>  static const struct snd_soc_dai_ops fsl_easrc_dai_ops = {
> -	.probe		= fsl_easrc_dai_probe,
>  	.startup	= fsl_easrc_startup,
>  	.trigger	= fsl_easrc_trigger,
>  	.hw_params	= fsl_easrc_hw_params,
> --
> 2.34.1
>
>

