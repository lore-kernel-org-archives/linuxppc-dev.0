Return-Path: <linuxppc-dev+bounces-22374-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A061FCD8CA8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 01:57:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZpnn0D89z2ysW;
	Wed, 10 Jun 2026 11:57:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781056668;
	cv=pass; b=P9v5JLTIP6+yuAumq630r96aC1qCfMp/6cLxr9nkHkvVKIy458PsQ41JkNTgQ/dF/QThybVrnCLcrrF/6LEBqpzrMVKtCx88lYV9MRMsj90u2Fdsp2cRqugRn2SO+GzDuMjThqt+jLAX0bnw6t6DOHt0Vyg4LIH9kh50Hk6KaSv81+7j32K3e/asZc3oRR3rvNcKCXFTVmBD4HkZy7EKuakMgfAPth1YD6d+2Y/dD7Pgg60l63xc6m313g+tLxSximmU1slkRLxpQyNBkbFf+lQq+iNOQW3vycHBj096wr1VEGW6R8NhEfJVwPkT5b1SLzGbnUKfZfI9rP/cYGZUmg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781056668; c=relaxed/relaxed;
	bh=Qd0ZpoQWjwRx7f+zxgH4Qj4M7C3TAgzhAvirHpC/s3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ut6yCgM3NxB6DAKE8jSjz+qS2SnVNMYLM5GZLh6fgo7DaxHU5YkoXRQ4E2+QZVOj/A/Q823BLmuhDCS3CrIGPCX8Tunv3vpWjntwMjb6esamwL6lBQwaB4Bu6yurlhRzqwqxtVknMMeLUnUH6XJk5YpJ1Ra6/0jhtsAptJa0jKIDdTCHo6MhjWn6NkiH12uAsKiSZkmeRaeCgNzzfaWtv6pwZexMChjc9QbM4gytJ7q9zTrGz2rlCLLv/Ou4BTKKdO8LBMY6UkhLnsvaFBSYFPMcjup9f4f8qXxsWVyayl7amZAV5Htt5TovSw7Izn+zghCU4v5phOYEaCm7GJNXFA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ClMR8cCp; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ClMR8cCp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZpnm1hFRz2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 11:57:48 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VW3hEudYb4DehiPbZop4RG69Erw3mUl/y9dl2bCEiK+NdLYZrXZDLhgBwzEP0muvkh0K8ivNk8BAgAg7BXklno9mt0BLDZnLGHmu7kRYykgLr/RGA+7JWLTFtm2nZbyxh33KTX7cHPZYlRjArxVs9My89UdKtTZ+g6fxq81FuWCC0e0aLNUAQ2oCZtrSuddFA0+Cm9VsyB0Wn8sHuOGlczEyIWS6diL9d6kw5M4dMA7s4qQBD2xe9LXTRVk66mWtX1UBKSJfWNGJFk28GI5+WWR6ZDeKKRuej7b/s1X4POKC9dPkHN3PfpOIzMFRuEwtHa4gxgCHSnsyrBBI3Qq7kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qd0ZpoQWjwRx7f+zxgH4Qj4M7C3TAgzhAvirHpC/s3A=;
 b=p3I4hVS2GGnwEatcG/gRdFpplBKq28WM7JibfwjH9WhXP7t7XpSdjN01cUi7rYCSiJSy49376uGg4lLK8sM/TA1oVVKIbxTP2Di4Xi2iC7e4ZjeAFna7BVyp0pMmbcU7JVkf8Ht45DnBvciuYxtvIscYfpZj0k+Hr2FnqdOQcJ+O1O1/xBBwYiEbQD+DOyYYgpWbjj78aM1hjsv8T8xXfMgDuQb6EuLEAud0dVF2avvqOrCWu2VFj5nWmjb2DMa9GDeUm7F+roCLLmLiZnJY4I7hmM+kHIngJUsxTdJfjA9DnppTtKM6yWBSasxA4lNHV0ICfkRIboht0tKxej/JGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qd0ZpoQWjwRx7f+zxgH4Qj4M7C3TAgzhAvirHpC/s3A=;
 b=ClMR8cCpYibKwM0rLTcmHksHAm/Tl/gNc9JL2KsDYdSkGdRYsG0HGrjhjizWov6DgdaMaf35xaBxDymDFnM2byqgY3fuG2PAKEsY92usZs1mcTslrj9cwCuQ9LmRYIYOllVn5/UXpSi8+6PdrQaqs684GV5fSYAn9YO9tMWM87VH/UVl3/AQyUAOAEAnXyLyCHQxVInJTsAiNNG4PeYcSKQLlHJbjJTd8Amxupxx2DhWGIatQd3z72pT5oMLXHDaMwNWAIDHBvCkAqkSO5vym1WHT9XySjc/RGduCDhmektViAaZZQyVhs8WquievhVKzeoTE5EoVLGHNKOELemoGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS8PR04MB8867.eurprd04.prod.outlook.com (2603:10a6:20b:42e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Wed, 10 Jun
 2026 01:57:25 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 01:57:25 +0000
Date: Tue, 9 Jun 2026 20:57:12 -0500
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
Subject: Re: [PATCHv3 09/15] dmaengine: fsldma: use devm for kzalloc()
Message-ID: <aijEeJq6nvKj7eP4@SMW015318>
References: <20260609221926.35538-1-rosenp@gmail.com>
 <20260609221926.35538-10-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609221926.35538-10-rosenp@gmail.com>
X-ClientProxiedBy: SA9PR11CA0020.namprd11.prod.outlook.com
 (2603:10b6:806:6e::25) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS8PR04MB8867:EE_
X-MS-Office365-Filtering-Correlation-Id: bb69cec8-d2c7-4b8a-4228-08dec6939e35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|19092799006|1800799024|22082099003|56012099006|4143699003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	pprnBbxnRrCU1RryDdjnOLIGQEMcQ+MpuV7plhN7gMiU4bH4qpNhjG3/EumssAhHBxJ68w7EJgvugZ3gHblMwlTD+8qHiJfpXKP7yU6MuflEBCC4kXuv7hELLjWGgRRLrzD97Dp8nc2Yn1s8Ji96/3QW7esTv3CwzPmDe1Vpv2UbN8yM1NVAwe2rlrN1JRjKg6K6f3TMM3GSKApdw5rykl8rPMiYb939JLAJX8FAzKBaEeVswdJZ2MJGAG6pLXTCBouIw9+FSqO6e59fuBMk5gJnDjzQXkf8FQ4lyCP8WSgHIQdBG1vlfa2Nv+n74KM4hMJXIHnLUKgu9rMK0U69kNTgmqRSXo2n3i5JUXpyVDzZSxdjwXxBCERuVKRBcfebS5ZPlYvbhWL+pKi+e+1avf/2xoGxpLod5BYU/fL23Eb6UaV8q8rjo4H5LNH+UoFELuYaUcFkgbkn9B6qCYC5ytdS61u44TzlTP04NPT5btgjBSk3UkxOPZMoAIsQPHQ/LLwINpDaqoQ9qohtfMI3UCMilTGC3NfnSFlNUzqOs4IvYcltRMLCXk4YJyDZnJEaVYyu+59/WvJm5JFXpU/7AF/Xn5PF4Tham0De4zIFAZP/vnP5cAR6EH8wrOVBeJcggOS4ZbbjkNuh40pezKoKjQxBoI/j8b92L4moF/RbNaNjqajSUXPYhP6Z6fJU3uuE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(19092799006)(1800799024)(22082099003)(56012099006)(4143699003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jXdBgdotEUISVbV4hxrVLOhXJfmv3POOdGhQEdNjt7H2UJ2wHyJHv2qdSf+o?=
 =?us-ascii?Q?Vv9M6OdVhP2N7AD7Ay/39GgLXP8VgZlrGFVUShmfeInwZtx0A5HXGvX2Rg8v?=
 =?us-ascii?Q?zAIN6Otx181SIqe8YrDeZazUNpmccq1k7JeeeZP6dsDDGBxyzKs469IZ+QVQ?=
 =?us-ascii?Q?MqbdllyXZsAWpjxaRrKOF2eUVJUyw6AEyzv3r4L9YSL6DVVUZN/a5KlmOwLE?=
 =?us-ascii?Q?SjJVvDG7nxx+UcMf8F1k6ap+uf60erPtrsOHkOod51L3LGuoyIgFKPfOKiCc?=
 =?us-ascii?Q?q1A4CUrsY20MICov0lIXXwkO1tSI+BWPX7LpoiO7mRMkHwEXCo9Y9fNbNP/2?=
 =?us-ascii?Q?cb4Si5DZu1JAnuY4+rsa3SqSTZzKZbtx5uiDlF2K8FBlJrqUbE2T211+lpIa?=
 =?us-ascii?Q?rHfKJQXfUYJgRcP25aulV+8jtCtuH0TOiy2SuAP3QSouWLItnoi/UYct+goZ?=
 =?us-ascii?Q?IPSjs7Yabh9nwSTGHSY5otuKYaxZWu4BSqDTm4LgFhddt06urSn/19/F2T8d?=
 =?us-ascii?Q?YLqXkGeFke6WQKqeuky+P76xw+FELkC+p1yzutT/AL6XPhuBpRwdk5pOMaUA?=
 =?us-ascii?Q?JRVY36n/dD8tvd/UBkrq5sWZlNNccMd9LDysX9nsogg1xaOgYzSDop1Z0GaQ?=
 =?us-ascii?Q?JwilX8nlVOAZlpweFsnI2G9AK3nju+CfnvB8m6iWNZYWAJ5lCKnasDvy0Fd8?=
 =?us-ascii?Q?ZAbQiDpR6lC+Sh+XmAZ3yjgvYTsIIu59WHY7Rzlj9M4I/sJvq0fGmre83UJv?=
 =?us-ascii?Q?dUTBYaYyU5aqgOoTZyr2Cm6Oj97uDiQPuQ52TGapmt5mkYaMlupe5hxnRyuD?=
 =?us-ascii?Q?MudFjpJO3mQ/VdFMSh/+javxmyRbhnf/TEqaLtA9Z5xyIr0/lJ/Zh13ZnWR7?=
 =?us-ascii?Q?UiqlmvwmlThYHMr2i0jJlUhDVtlXx5jlJFaIAs3A5XvX159gq/zh8h/bp179?=
 =?us-ascii?Q?FXNWzT5pRI4HwN96m2uzRRQ2ot+4NGLIrsUj4hKMVXii/yY6dcZPfXTTTGkM?=
 =?us-ascii?Q?q5wev0Ya4FWvx6uOQCDEIZNyI/S7PVI5gxX1iP3orm0pfxxce3Hs/sctZY/r?=
 =?us-ascii?Q?RWhZQdeBSAD/a8MPyWzn8QQ2QETZ0hMOFFNZ60k/WTbrrXom7soQvS4IQ2IX?=
 =?us-ascii?Q?kXdsjcSRrnDR8e8GLwpXM4ivdvgxfR/K7pc8+W3Ffm+yfHaITYSHISr5ze5p?=
 =?us-ascii?Q?bhUtUpMPwEOuFOP2Nmq6olrNmkASy75VmEX1OqCSSm14c6+PMu/Ylh8V4MCW?=
 =?us-ascii?Q?6xM2VvrP/MdKiUPsdtVXLtyl0IRkbjqSSeUMRCpVqPc+b71+f9OiKim4ktyi?=
 =?us-ascii?Q?quyBwJfft0ejjjj0gp+yp0l3hX1haO7iWF+CPWEUdXYj4PCH8DhP+bz2KaF9?=
 =?us-ascii?Q?HJHuHRrZ74zOFKzGjLRErAUxhU92jCIvocm5JFazJRCpfXv22QlK5YGxVG9R?=
 =?us-ascii?Q?Ta1jAA8Inp0LyfgfBcWbFN/jGP52ehhRtGqN+1akagGjAw7s88v1kmlnunVT?=
 =?us-ascii?Q?3HKRvBTXeBRBnASCcEisl4LAQBlcCiJ1RsC5U1VEbWnbn5M1LVFBGnUMltBR?=
 =?us-ascii?Q?w0TwcCO0ffY5Aa+41q5p2a4o3jKFewTqdwQhiTAZqUpkH+UDUmZJYxjtZu6w?=
 =?us-ascii?Q?mKQGqrgiYAgbhTixMYNhXRDTAYYPaQ9vDTLP2qjojtuPq0Y0djAugXK3zKxl?=
 =?us-ascii?Q?Xb3IrSV1pCn5PTmCQcCrQdtEeeVDoE6IrGXqJ+e+di5j/8xR7HzuA4v44mBd?=
 =?us-ascii?Q?VsKKZPzE5m830I88+GlfFIUq+0kyaZ/zex8oDiEnfh+9tMMPW8mF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb69cec8-d2c7-4b8a-4228-08dec6939e35
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 01:57:25.3106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QFKTnq4JOWPOfh526QSQSUvCzS0e5HojxaegZTpfD6MOE+OU39UNzTgcuZOYYQk7mLGzPHkH/VSH5cWepkG0y8NedQBdtm7A7oILTqrwg2HJl2IUYk0ja+eJItbiQiDp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8867

On Tue, Jun 09, 2026 at 03:19:20PM -0700, Rosen Penev wrote:

nit: subject

dmaengine: fsldma: use devm_kzalloc() to simplify code.

> Convert fdev allocation from kzalloc_obj() to devm_kzalloc() to simplify
> the probe error and remove paths by dropping the explicit kfree.
>
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/dma/fsldma.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index eba194d64105..dac12de06ef5 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -1222,18 +1222,17 @@ static void fsldma_device_release(struct dma_device *dma_dev);
>
>  static int fsldma_of_probe(struct platform_device *op)
>  {
> +	struct device *dev = &op->dev;
>  	struct fsldma_device *fdev;
>  	struct device_node *child;
>  	unsigned int i;
>  	int err;
>
> -	fdev = kzalloc_obj(*fdev);
> -	if (!fdev) {
> -		err = -ENOMEM;
> -		goto out_return;
> -	}
> +	fdev = devm_kzalloc(dev, sizeof(*fdev), GFP_KERNEL);
> +	if (!fdev)
> +		return -ENOMEM;
>
> -	fdev->dev = &op->dev;
> +	fdev->dev = dev;

not big beanfit add dev in this patch.

If you like, create new patch, replace all op->dev with dev.

>  	INIT_LIST_HEAD(&fdev->common.channels);
>  	/* The DMA address bits supported for this device. */
>  	fdev->addr_bits = (long)device_get_match_data(fdev->dev);
> @@ -1242,8 +1241,7 @@ static int fsldma_of_probe(struct platform_device *op)
>  	fdev->regs = of_iomap(op->dev.of_node, 0);
>  	if (!fdev->regs) {
>  		dev_err(&op->dev, "unable to ioremap registers\n");
> -		err = -ENOMEM;
> -		goto out_free;
> +		return -ENOMEM;

return dev_err_probe()

Frank
>  	}
>
>  	/* map the channel IRQ if it exists, but don't hookup the handler yet */
> @@ -1325,9 +1323,6 @@ static int fsldma_of_probe(struct platform_device *op)
>  	}
>  out_iounmap:
>  	iounmap(fdev->regs);
> -out_free:
> -	kfree(fdev);
> -out_return:
>  	return err;
>  }
>
> @@ -1361,7 +1356,6 @@ static void fsldma_of_remove(struct platform_device *op)
>  	}
>
>  	iounmap(fdev->regs);
> -	kfree(fdev);
>  }
>
>  #ifdef CONFIG_PM
> --
> 2.54.0
>

