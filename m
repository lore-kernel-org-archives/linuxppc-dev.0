Return-Path: <linuxppc-dev+bounces-22638-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48107CD98C5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 14:15:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfBwJ5WPHz3btj;
	Tue, 16 Jun 2026 00:15:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781532912;
	cv=pass; b=WgLlCxWVUhkdcWct9ODeZf+dqPtqA3VE54ZkJRGVFNvelmO85fx901SBkSnXeKayUEAV87r6V2q7mlghkRwTrrIQBzcm15iwB4NaLmisZelKOPJWAjSat/1nc0Weh2+PqjWXH7V5va+qLfv4ki+3ALN28wY2seIqpNZMfb55vmFUdjPrWzcIOW3i7TYPp/1PRHGBrQii4gIjo8sjVbT9aqFIiYjGbhN6miuXB5osnFrRTi+Xndw0tETzMG5AcB1F4APox8tpozW+iR1A7TGfuRihFFIovSX830NM5qZQ0XJGYRdx3O/IvQ6771zpktz3YC1iv3R1n9QXkNLTm0RJ9Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781532912; c=relaxed/relaxed;
	bh=/k63RwvAxJDa3/NNnzb9pxGZv+j+BxQd9kmDOdLE+kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ELJZAzaoH7hbG8brEjm0sRif+godxS4Xl6CGhnwo3fbIkvNPH+pHlMTBeJNad+JuJoW5RCcvC0OaRDFqIeJUwTtdw5QGWyfhIl4CVgSLtfFvNHAoZF73RfuJraKqSlTIwe3kb9oVFog0iqC1PTIOjuWeOPUGtzRIO0AtLHWE6bCeg74VFQ3ug8bNMXBfGfGZ6KWB4wZXYT/nMcTwmLSqPllTiXnBmiI+l8vuIa5BUiKXOgYbTOM+rVzZMLb7mt+MaAL8oyntg+jhK5pYMOvVxZNfaUyz/9pS3qyPzO8pZcGkToA166o9NMQ+CVhClzigIzXZu0EnFwvQWb7/iXoLZw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=mPZH8SuO; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=mPZH8SuO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfBwH5lNmz3btZ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 00:15:11 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ar/hq9btb77juyxxaOjM87AVVE4whjOQz4xvLetVy8dtDoc32HgJkloaaDZgDsaDxDhBBjWq0BVa8ZKDjR/5reYjRJHyQGNzy8nh3jrxphbDQsap6MJwG4nxanAd0OAYbznwuQG2YqYVCc1e2e+Z7qoNq82BhIISfLNSwJz5ZrfYeSaEsbm3qsdFHOuN73WkFRXwQRZ2NGin2Eww0HlSNcsAv8gqzsxj977MA8+2lGVf0YEDBQslziYUOEjDI1U317ugcmson71/22ZSFnl8FxDaUfXW939vvrY45TGPscz1h7exXWMDxXmATyLo+f6hhH5jGgpf1/uQndsykGvkwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/k63RwvAxJDa3/NNnzb9pxGZv+j+BxQd9kmDOdLE+kQ=;
 b=pKM15dG3VFY6i0bKs2YLvjl8ZArqlF+cxfqzcihANkQmBv0RO3841pzfaWbkzzL5o49J0N+JpUwBeQZ4DVFRrxH17K9UAhjetr104jZkoZsyGDluzUyP558UxhlnDYU6iQF9RTI3Vqj5oKXO0Utrr1KBzKV+YGCGcZbmytKHRAzf2ADEYtSUm6HtilmWRum6AmcGHWnsSzfUA9XbISagI5qMNXXJpXwYwHYQq7tYoHJwse/UcGqfc9a1iiKiGv87cTVPvW0o0aWdqtWDjNDFl+HXE+qHRtq+qXbKgVk9y860G3Z5nNFdC1GnTv+UboxvN52qgvmIecoPUt3ZOc4P4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/k63RwvAxJDa3/NNnzb9pxGZv+j+BxQd9kmDOdLE+kQ=;
 b=mPZH8SuOXzuhC5Grr1mxV+4IYP55oFnNHAXcUndgyj+SbZYgRmUZeKYQaUVEPoo3CJKtX1JWhCBHKPzvPgyt9+eyb/1oatZAY0rCKu6UNUZxFHbHBjmgsSSFyvX1wLLUJ3mlcRCFjf9/kqWPVGbVoyE7to/1Eh8aEEwOSGk/u1QLeX7npj726STqulR1gbtk38d6/iRo9JkRlXes5uxDm3gyp56sE1LcF2bBmxoR8tSu6XcdZO3IrMniwmXFJhwXfOLMVFK+fMrREuvlamJ7gVxO5W2lVUaN0gqEKkRf4zaYQ9vX/NL4XpwN7tjMFPhfZ+hsz4EkljQ3m+HkN7foUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA1PR04MB11082.eurprd04.prod.outlook.com (2603:10a6:102:487::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 14:14:46 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 14:14:46 +0000
Date: Mon, 15 Jun 2026 09:14:35 -0500
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
Subject: Re: [PATCH v2 10/11] ASoC: fsl: mpc5200_dma: Use guard() for spin
 locks
Message-ID: <ajAIy40qrE3F0Lgi@SMW015318>
References: <20260615093824.115751-1-phucduc.bui@gmail.com>
 <20260615093824.115751-11-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615093824.115751-11-phucduc.bui@gmail.com>
X-ClientProxiedBy: SA0PR11CA0107.namprd11.prod.outlook.com
 (2603:10b6:806:d1::22) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA1PR04MB11082:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c2340f2-c84f-45cc-d8a2-08decae873ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|376014|23010399003|1800799024|5023799004|56012099006|4143699003|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	oor42oFmG4CFrmfwNkJt/oprgQOtaWxIiRmdmxrPDhUdlfuAedlEKtt77zIqSOw80NBKpPBWvGfUSRhQ84pZexNpYilr+IAaymEBooQy8DZVegsBd1SKOoyCxcMLaKhvW/JJR4rrOgBIAonN+8lAVS3rm4vRDjZHYMDJuDcrB9N7GHXoi2xRW95bq3A5/s2l+G2kIaBc67GBAcRZJP3zlyql6mJPpFeQvEB2/dC45GA0Nk/MqxfIgucFOBSXBP8uP1SCZXXjn3SwBoh7vA0Q4/zhA6r1AGVdfkfZrbCF1EZQkyKhoGkusYbdFoa+cVvOd7MshhgsqP7cbwR55Dq4/klTeDtN/5yfvR9EFI62jgTEd2urreL4CzGdJ75T7/fAjSxea1pOVUlH8xuo92Vv+hEjeSPMa8QpGlxliI5l2q1t6HFkyIzEWWExLm1ouAvnZCmpM0aUPolFZuhqUOpLTQyedY6iiCi+1MOg15Pf0dJ7jboO19UaW+fR2y1AbLVO4q3MOt8zGgP5bn1d1CZR6/wGxq5KyoFn130yboF9TdwMD6LKk3WUWhYdn1skQtmInqdrYB0Llc6LyGoubk8PoD0EqRn6q6pl3494lhzAdKgTqznC+C/k3jdqRoOBsCweltkC+wVfiGPdCa0J4F8gELI9vx3luOsBMWYWQ4AtZR9IA4NCcGP3rFH3lEPzk2wh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(23010399003)(1800799024)(5023799004)(56012099006)(4143699003)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VSim95QwI+cbXLM6bRuOhXqfMe7VdaPmNLeabGVzkHzb9PZnNvVgqACRCDac?=
 =?us-ascii?Q?jrO6DZGFqWH3kamWIHY8j/U2sXmD7n0v1zFQGImGZG3RQgdFOA/Vx9pBzXfM?=
 =?us-ascii?Q?NEZ5zYsOnzPM6bKOqTdXh0IsVhL0bnjdntrFDag8QMkCNERcHLrWc0vUQ34N?=
 =?us-ascii?Q?h6wBmMPxKborrskMO3D4pjj36oBivZMwEy04S+4Soguu/t3wwIjRHuS6OVZq?=
 =?us-ascii?Q?jgpM9MhN7XSFGwFWoIIQFpSMjGBsPYfXdl3ZpEBRPyToxITKTZW9A58f15nc?=
 =?us-ascii?Q?Vu1pHvOMAtQ6LK1NjA9tAm0hf/rHbVvhp8F3WoKgdElVoRyWzJpGoe21LE23?=
 =?us-ascii?Q?1oH8Uko6rfABcfU4eijNiUSVMQOKpKDsiAtKPwAwB0IANSU937lVbx2qqyyI?=
 =?us-ascii?Q?XlMqV25RxS0tCPx82NCH+ZwnX/M4TNeh/BIPYG6OGYx0D0phJ+xOnoCJ8GAJ?=
 =?us-ascii?Q?kdxvIjDbf64sUMakCy9WsAw9BVOXDpw6S1Q/1fbTqas3YxGCU61mHHBhA1Uj?=
 =?us-ascii?Q?tSGVfFVS9B44XFfwQsZ2jl7iOgcExc7NDljYL3ODY1o/9ONqzf45JUiHioGX?=
 =?us-ascii?Q?juXwP9sySFdw7x8S6TVG/ey8mVntfKmjy4HmGbb3+pTYpJfFfzx3YrEjC2sl?=
 =?us-ascii?Q?Kw68YPTZiwOTYLDBk9KnlNTaWEia/uzl6vrJ9BqU/7S1ssILxH6qXa3/JAHe?=
 =?us-ascii?Q?hfOi2SzsalcZXkCUJBxIFVFqkZFrN+iwz1uxh1E6mRkQHqWMVqgYU3w7W6Wh?=
 =?us-ascii?Q?prHrI5e4yircchJe2F0DNPpNTEGz7ksjuNc2kvhFKkX0elQRRFuFC22e9gkD?=
 =?us-ascii?Q?N8D+1fCQ5UAeY1LGBvTOLuoQUH9ZmFSupyRgUYRDWm0r8Gf8aE7DAP8O62ht?=
 =?us-ascii?Q?7+MHsFFjgFYt2pxK3YhJ4+cC0dsi9u6oM9pLflmNIUX44GJUZLJ+bB49Vwte?=
 =?us-ascii?Q?avZ7tqLMRcyeJKZu1hf15CsdxrTg8ceMhqTEdi2tWidteFxluFLJuPCbeI+U?=
 =?us-ascii?Q?GGA7N3ETgdrT22+mxDxE+MJfUO4knTOC/15ujKP4pGxCqARKATiSukyySJnq?=
 =?us-ascii?Q?f9tRfXU5DniVXSM7iP/YfxDvfmV63o0EDbxat83SeiO1YLbYdIdL/ADOk9g4?=
 =?us-ascii?Q?T5yY6Gg19pPvzL9XrbFh5Q+sFhSxeGkmyNj0hUexrLx1cFYRcol00J1ybXsu?=
 =?us-ascii?Q?P1kHUxQia6ZAUzGnZmssusg3erL1J6lA5ppfvJ4sYNvDBMORwZje6nJfrI8n?=
 =?us-ascii?Q?cZwLw1cY2NySmA3E+pRVgygBnDsnPWcXBey9wKM69TOE6KCogSCoL+DFFGuH?=
 =?us-ascii?Q?ov1i2cdQAyN9twOsqmqiwzhvyqJNY1FrWpQIUikuQQF2vm7Il3a/n3zmzbTA?=
 =?us-ascii?Q?5/pIV0gfbun/j/EF46ua6M57De0cqOs6xtSXAS7czb5SIZNmzHeh40P5KX6I?=
 =?us-ascii?Q?/74n0y5Pd0EbsNnoqBkDlTsqo2W6Ji5OgxwvS99LLJNt8fwdYsUaZ3/XJ8Y8?=
 =?us-ascii?Q?LZRnJzUgzBDlGRSQVuB1KpXbxoi40Qx6ICEPgzvn15ytTs5K1+n/h+2kOWWm?=
 =?us-ascii?Q?yrj7oYzdFuT692KDZcZ+htuNpoil9+1ytCTEABFhguCjNMGi3OZCFnbr7Qwz?=
 =?us-ascii?Q?W4uxWx2fLig9mzbMKVIcKrn3TdSlqx+ge6/zsUxohdC7qszWuu0bqd3wZhd9?=
 =?us-ascii?Q?+THE5Q5cZn742QRkHeWIYKkJcCt/5/Ua/vCuVCefKlPBAn/6xt/EfuepzBoh?=
 =?us-ascii?Q?CGz4jVjKY/BTAyc7g3KkXiuWNdyrBh5SUwgx/GRHGr6EyMiBHuYY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c2340f2-c84f-45cc-d8a2-08decae873ec
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 14:14:46.2537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N56l8IBJsVf1vnbSkN5GLMACyUbJlvDC/jgFZDrKYRuAuogxKq+pJrl9P6fGijZqk5tXv1C5KnAP5Kqxu4KlzNE7E73g/I18hlPY58AhRiIz1LZBh4QBSuv3k67dZq8N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11082

On Mon, Jun 15, 2026 at 04:38:23PM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
>
> Clean up the code using guard() for spin locks.
> Merely code refactoring, and no behavior change.
>
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  sound/soc/fsl/mpc5200_dma.c | 56 ++++++++++++++++++-------------------
>  1 file changed, 28 insertions(+), 28 deletions(-)
>
> diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
> index 56e2cf2f727b..bfedb2dea0b3 100644
> --- a/sound/soc/fsl/mpc5200_dma.c
> +++ b/sound/soc/fsl/mpc5200_dma.c
> @@ -77,18 +77,20 @@ static irqreturn_t psc_dma_bcom_irq(int irq, void *_psc_dma_stream)
>  {
>  	struct psc_dma_stream *s = _psc_dma_stream;
>
> -	spin_lock(&s->psc_dma->lock);
> -	/* For each finished period, dequeue the completed period buffer
> -	 * and enqueue a new one in it's place. */
> -	while (bcom_buffer_done(s->bcom_task)) {
> -		bcom_retrieve_buffer(s->bcom_task, NULL, NULL);
> +	scoped_guard(spinlock, &s->psc_dma->lock) {
> +		/*
> +		 * For each finished period, dequeue the completed period buffer
> +		 * and enqueue a new one in its place
> +		 */
> +		while (bcom_buffer_done(s->bcom_task)) {
> +			bcom_retrieve_buffer(s->bcom_task, NULL, NULL);
>
> -		s->period_current = (s->period_current+1) % s->runtime->periods;
> -		s->period_count++;
> +			s->period_current = (s->period_current+1) % s->runtime->periods;
> +			s->period_count++;
>
> -		psc_dma_bcom_enqueue_next_buffer(s);
> +			psc_dma_bcom_enqueue_next_buffer(s);
> +		}
>  	}
> -	spin_unlock(&s->psc_dma->lock);
>
>  	/* If the stream is active, then also inform the PCM middle layer
>  	 * of the period finished event. */
> @@ -116,7 +118,6 @@ static int psc_dma_trigger(struct snd_soc_component *component,
>  	struct psc_dma_stream *s = to_psc_dma_stream(substream, psc_dma);
>  	struct mpc52xx_psc __iomem *regs = psc_dma->psc_regs;
>  	u16 imr;
> -	unsigned long flags;
>  	int i;
>
>  	switch (cmd) {
> @@ -135,19 +136,18 @@ static int psc_dma_trigger(struct snd_soc_component *component,
>  		/* Fill up the bestcomm bd queue and enable DMA.
>  		 * This will begin filling the PSC's fifo.
>  		 */
> -		spin_lock_irqsave(&psc_dma->lock, flags);
> -
> -		if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE)
> -			bcom_gen_bd_rx_reset(s->bcom_task);
> -		else
> -			bcom_gen_bd_tx_reset(s->bcom_task);
> +		scoped_guard(spinlock_irqsave, &psc_dma->lock) {
> +			if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE)
> +				bcom_gen_bd_rx_reset(s->bcom_task);
> +			else
> +				bcom_gen_bd_tx_reset(s->bcom_task);
>
> -		for (i = 0; i < runtime->periods; i++)
> -			if (!bcom_queue_full(s->bcom_task))
> -				psc_dma_bcom_enqueue_next_buffer(s);
> +			for (i = 0; i < runtime->periods; i++)
> +				if (!bcom_queue_full(s->bcom_task))
> +					psc_dma_bcom_enqueue_next_buffer(s);
>
> -		bcom_enable(s->bcom_task);
> -		spin_unlock_irqrestore(&psc_dma->lock, flags);
> +			bcom_enable(s->bcom_task);
> +		}
>
>  		out_8(&regs->command, MPC52xx_PSC_RST_ERR_STAT);
>
> @@ -158,13 +158,13 @@ static int psc_dma_trigger(struct snd_soc_component *component,
>  			substream->pstr->stream, s->period_count);
>  		s->active = 0;
>
> -		spin_lock_irqsave(&psc_dma->lock, flags);
> -		bcom_disable(s->bcom_task);
> -		if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE)
> -			bcom_gen_bd_rx_reset(s->bcom_task);
> -		else
> -			bcom_gen_bd_tx_reset(s->bcom_task);
> -		spin_unlock_irqrestore(&psc_dma->lock, flags);
> +		scoped_guard(spinlock_irqsave, &psc_dma->lock) {
> +			bcom_disable(s->bcom_task);
> +			if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE)
> +				bcom_gen_bd_rx_reset(s->bcom_task);
> +			else
> +				bcom_gen_bd_tx_reset(s->bcom_task);
> +		}
>
>  		break;
>
> --
> 2.43.0
>
>

