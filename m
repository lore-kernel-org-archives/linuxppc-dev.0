Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46728606A335
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 20:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=KDHuWbfM
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jR8H60Cjlz2xLt;
	Sat, 14 Nov 2026 07:38:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794602321;
	cv=pass; b=lNHJeMUuxTUMNyqNzoGL8u+82Ylei8m4kJslfrTlTKq9R9COyDHP+vPVK+fjRFHuSwQmRbMKt8LHknMNA7/fMPUEN+uE9qf/enY2i8ZNW0IsYZbY7oP8UxjBiwnin5UD3ex/7KrgDXFopigkBEuCpqUZSqiRjaRVub043ZCcV7sXssH6dg/TjGB/6nFKdJqcCC8RmxDI5q1XWKdf72q+b3aTuJsiD9rF8CsGhwkr5H+mFLPjw3R/SzsTWmU8FTMH1MNc5zV9B3TPRn9mnZbuIbCCjsgNUnnq2FcLlsFsU7GHIZqF3oadHd2XiXo4JqGfVPlHrebv57mkf/lT8H3tiQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794602321; c=relaxed/relaxed;
	bh=/e9JU0LM+E0DcpG1r5iIjZXjjMyQwSTWNqGJozgIz8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U3D/5HTrCJ2vKcs8Dr2T11n/5adDbzSIF6TMzlqIwe+zSZVlPoD9tOcESpLNDl/NfGZW/yw/E6qPnZWo5U0XwUlp3Mk5Sia9OkNMc0VB7WiQ+9WdSpp+xmOoCGYqJSpArfhgsPLBJNUjsLUbLuGmTWjtCjS85LR7v5eeANCA2YyJqH2Vn4ynJLAO/F21MLV+48Hs9yyCC976PEslAt7BoGN+2bNxolakH1qgedL8aX81IVHzB5Chp9sltBO5J1wAeJd8aY/4Z4r6C9GFhdE/6gHUJKrXqnVcQH/l+E++QjXDiPevkmXSFEO3LjnbYHcEtYyGXHDAutRKh2CLvdBlKA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=KDHuWbfM; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=KDHuWbfM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jR8H50m81z2xLh
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 07:38:40 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZpuwrY5MP2Go/mvM8YcsOTbOqE0QVvnIUPXGgHXZaRaccXLyrHK6O3M7rz4+FnqRrXQIG6Vo50ISwTk7H0oVyFMVjZ15/QWhrXHWCcfBvbFtpjcxt/XvUXuz5S5dxI//m07tpjmitMLVnWc7mSbRBV2mr96y84Bhx1ZiYQ/a+UghB1ZnJet6RsncOQgSXRReOdnnaHsx09ZdFLHE9iokoI8kKnk3viOvd8/pRgZipCWrj2brNmhE99rMX62U7LPfNCwf2wkb7D3pxyTJcG47BoU71kNEtzGsg895uJ5UcZQr367QbXzlrk8K/3Agb7vcniRJfjCYJjkSP8f24BJZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/e9JU0LM+E0DcpG1r5iIjZXjjMyQwSTWNqGJozgIz8w=;
 b=h3DNS3Fs8+plDVu1OxL+xysVrR8k4x/gDO9oMvJ24k28OpZtuSYTWYpj99HolrHvOChPuI41iyQnGA7EhKUEontvmis0mhzusvJCGUEUW+OgOgDTy6lhaADPVbiUfbJy3WU90Nt1Mme24RwuUkJAUbKR+6XSLdldBUSQE79Q1m4SD+1b9C+CJfNOfueNNTHUweJZYV2ftQ6Uz0QiA3WhxGyItZAKu02YgfetqSGPF1Y72kJXnBfAaSaCAVGtd3lmx+eNAXPSDsWcMPGIL1gnWBh049nKdrgdmxtBezp53sEO878oJl6UhTmFL0B1NDvyQK4Pc/nOa7nF06R8zwvfHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/e9JU0LM+E0DcpG1r5iIjZXjjMyQwSTWNqGJozgIz8w=;
 b=KDHuWbfMutKAFstDPmDiKN590YLr+nDuS/lzt3enR48QYqlzZu/62vXfDr32qe9dIMf2ajHa08/tijAL4qR19deVQdfbRZnYLFdxx2azRnSyelN7y2ZUmpLvffU0wZ7Q0Rw7JfcDjXatBWt+RJJXnTAFM0RRL6B4lwRINpQeyBAheh0ceLkpCfJPWrGulcv16AuBZAdrB7hiavKe4eQtd9wCx/WVCVLH+sOfHMtlu8/JaLpB8rkVE93PVJXrUDBt9Rm4nLQzvOreyrGZX6fgED4xSuxbq9UYWiaoNdXdc8yoL8VNKEat909UrbJhqEz0uiJIngoNNWZgggtfeSRA5g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 20:38:25 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 20:38:24 +0000
Date: Fri, 13 Nov 2026 15:38:17 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Jiale Yao <yaojiale02@163.com>
Cc: Zhang Wei <zw@zh-kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Ebony Zhu <ebony.zhu@freescale.com>,
	Dan Williams <djbw@kernel.org>,
	Kumar Gala <galak@gate.crashing.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] dmaengine: fsldma: drain channel tasklet during
 removal
Message-ID: <avd1OcLoh6PbWk6N@lizhi-Precision-Tower-5810>
References: <20261018040724.534641-1-yaojiale02@163.com>
 <20261018040724.534641-3-yaojiale02@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018040724.534641-3-yaojiale02@163.com>
X-ClientProxiedBy: DS7P220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:223::22) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|PA4PR04MB9367:EE_
X-MS-Office365-Filtering-Correlation-Id: d5778d29-946e-4ed9-d6d4-08df41c610aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|23010399003|1800799024|18002099003|22082099003|56012099006|261021121427099003|11063799006|4143699003|261028144727099003|261022105027099003|261022075727099003|261021123027099003|261102123227099003|10067099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	NMEfYgPtYx3MPbIoxJ2u0YmXv9A1zei/1AH7YS2JI4lkmT9ko4zK/sDgNINE45fNnOXPAp+sdygmxzuCA3T3+lm6o7/BU8CXyIVGBJagUPvxq7/9jh7IxI7Fk3wvFyrcgwJGTuaaZ2awgSMSq1c1Va1aBNRwJeJpaOddPNOpAVD+R4+a26ccEoYem3oS2HKEn19FBVSPttMzl9Coxxh1tF4shldVTYA7kjlFDQgKelOaH90uQ4Z8BVLvhoRRoHDn9hw4tfbHMEFApHv5Dy6SIbiFfH/fZyNGMjYaPZZ3A0Ca3KtmNfP81n4Dozk2FURi2RYaes6km3xMFmO3MgVA32tvepMN+jEP16NY2Esi09O1FQOZbNZGtPvIyLnI2fUuouvvHvd5ZymArfdQe8i6OyQtCKMD2SL8+g1s/FlDfEdj43G1UFkVlC5TYpitBjhY8YymDgwV0lhbWjCy05ebY+O79Y1lNbrau9JId34BYmliYt2iVIL9tlVKFGTy5HpcYeQR7w3VyLKNwTKQp4kPJ4jXD4ZHRpcewJNXrzi0jF3n8dEXuWeqloPF/HuzQl6JTKtA8UcCbHzqcDOvS4h8AUya4LpObGKCyvLJS+pkVPU4C1UaJdyQ/2ad3LCBOPQIbJCI4r1zS7/mxJkt6gfiRJW+VS6IavqpeMg8FPT6e6c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(261021121427099003)(11063799006)(4143699003)(261028144727099003)(261022105027099003)(261022075727099003)(261021123027099003)(261102123227099003)(10067099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OidshjxSMeiN6CALgVzMybXr1uOBVk3LL54sHRGcHIePpeV5tTttslZq5uhG?=
 =?us-ascii?Q?jDlQuNj7+m4kF2EWx0tU97iG9lzpTNCIzxvCavt273gJiIPLD2voFnXlJ1h0?=
 =?us-ascii?Q?XZZ1DHdhgLYQ/tKJLYQ5dDnY0P053Qpvs5axUcD85z/fTYKVeMaNKUJtywMp?=
 =?us-ascii?Q?c6qESodpibAWpuyUuXZsGQ9uG7VROQAHqIFdmO9wK1g4sdnAXo8Hw8ygbFj9?=
 =?us-ascii?Q?w/wkRCBRWU17JtxwLldHOcr47VuBiZzU4Q/ItrhI8OM9MVtDzie4SKYXybiZ?=
 =?us-ascii?Q?4CGhvqCM1P6lWjNRHFw845eYUYoiq+UsnyfpXcKhY+2Le5SNSdkbxgaOHlTw?=
 =?us-ascii?Q?Y5ty9nJxsPxf9fLh70S3pLbT0kTuPfTJI/Wq1g/9Gvu1rEHDQvlDT31AQXaB?=
 =?us-ascii?Q?RjqUQ36T8XmlKegFJKtBQ7ncWXwu1yKtauxCjmWgXo1dFqvKY7LKVZeGT2v8?=
 =?us-ascii?Q?OYtZ/hJyokhXRrvUIgVC7GYtS3wYfh0CLnGAjZLSskoBZm90iX00dVKfSmd2?=
 =?us-ascii?Q?cPIqStw5RcradB+m3xZtIHynD8ZgMZcSI9bI8hY3vz1XlYl+Np3T0TUrawrz?=
 =?us-ascii?Q?M8doKZErWFHk7uGMMPYA9YgqMlhy292in2J6K8t1Ae6JF65gZaQdsb91Pxob?=
 =?us-ascii?Q?7HY5NlCWEJDL9eLIdhShbtpWVDsOM7u7jVHM5w3AGfwgZriHxJbXabdqSoTZ?=
 =?us-ascii?Q?HiiHz5ZVawW3C3oPQLjCpBu0K6F678MOl/Hw4RWcWglfV/RKZVelor4puD64?=
 =?us-ascii?Q?3HRFJhEiUTUVBu2oIV6WxurwA1e/fobFiryq4eAMFy8JPoX40k2woC67gM5y?=
 =?us-ascii?Q?lSLYg3wZ3RIKdt0UnSoSNyqSEedREzKGwpax7L6wXe1iUH8Dri2n2v8q3nEH?=
 =?us-ascii?Q?zHzbpk7QGyoHABtvjYLQ+X6BBkeHlbHuxUqN5vIgbXRaD7aIXcZwH2kbZlvW?=
 =?us-ascii?Q?Vp9EsSMvWwGnIfn/JJjHnu0cigxyiDHeR4Ylk52Z5hDtv/ezEYypy9YKaSPO?=
 =?us-ascii?Q?vS+fyEOfPw3a2JKJKRickct3fB1XsknuxMjsPRTjWy65WXDlhRVIgss6l0iJ?=
 =?us-ascii?Q?/W0UCRiC5noAQWm+nhLSAHoCa2yLtaw6pWKQEkpqMEUjsduIc5dL6XOpDL5R?=
 =?us-ascii?Q?JNAEOo3mXOoL3xomqjyIYT7iN4PqQcMyg8D71z9Kdw2Jzx8d779Ohx3ESLeC?=
 =?us-ascii?Q?7D29zUIwpWLWnM19BCQ829PMT0+YiPo9onQwD0VYIcRUUZnXT8zm8t9uAp1u?=
 =?us-ascii?Q?xLwoJP1Lso/gMq+8vjnsWOzSyRIwiljHZoQC8L0FFTam5Rt8FAyvrKgk2cOJ?=
 =?us-ascii?Q?iRvkDAOz7rN22v3SjftFjU6YIHdEtlRH9eRfY3VNSvVHHj/n8oHQtpaSYWCN?=
 =?us-ascii?Q?+upwwOCDqRb/Rcr4XU9NITQIV/NVMLjDitvxpENKz1bL5koHfGVOGCaR/8si?=
 =?us-ascii?Q?zRrx81fp6lyt53MEBOmyt7eUu1Aw4JQCwCKfvGs1425pMFlMREdaMqgC9tAR?=
 =?us-ascii?Q?S7kGwitP7ZgbhCX1FSiHDTOKz/jZX/YtyGsDJPPJhixViBDL/wBqt/qaKPfO?=
 =?us-ascii?Q?m0cjyfxc0/McrVBqwvuMykaulUgHMyWDU76YJUbssl2u/FVDWam5fh4IvOXT?=
 =?us-ascii?Q?LLUPTyfqmRndVEKJgoRCxWLrXWxu36KDOoqHBe+cEvR/JZt+TtSTmiy13Ccl?=
 =?us-ascii?Q?BGiRtp5SXbUH+f5q4ubzz2Vdw2bcB/sHDIpoXzZOyZyk1yUc7cZc0vpNyVoO?=
 =?us-ascii?Q?wGjTuk/vjzXso/TWSIEO5Phs3zjI/yW2okWlQbCmeefq+12VZg7s?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5778d29-946e-4ed9-d6d4-08df41c610aa
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 20:38:24.9616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tkxX/VwRCbuaEXWVll2pmP5XB/TCh4EJ/X5ap/8ZElRGS/J/dHnSUmS6c0Yp/e2LIwCL20LZHzU0vPrhH/J2oMzednujhox53eilYkrofD6EKE8pRZtuLbeWEwqTnEpD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9367
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Oct 18, 2026 at 12:07:18PM +0800, Jiale Yao wrote:
> The channel IRQ schedules a tasklet that accesses the channel descriptor
> lists. Device removal frees the IRQs and then releases each channel
> without draining tasklets that were already queued.
>
> Kill each channel tasklet before unmapping and freeing the channel. The
> removal path has already freed all controller or channel IRQs, so no
> interrupt handler can queue the tasklet again.
>
> Fixes: 173acc7ce853 ("dmaengine: add driver for Freescale MPC85xx DMA controller")
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/fsldma.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 22d62d958abd..0e2f84862261 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -1205,6 +1205,7 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
>
>  static void fsl_dma_chan_remove(struct fsldma_chan *chan)
>  {
> +	tasklet_kill(&chan->tasklet);
>  	irq_dispose_mapping(chan->irq);
>  	list_del(&chan->common.device_node);
>  	iounmap(chan->regs);
> --
> 2.34.1
>

