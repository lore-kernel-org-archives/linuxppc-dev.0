Return-Path: <linuxppc-dev+bounces-28743-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985B4CA5FC4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 10:44:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hx5520dFkz2yPG;
	Fri, 02 Oct 2026 20:44:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790937878;
	cv=pass; b=lbKZY6DPcOEXgMhkqNrjvCHB5/wQrhFboTkh1CcXYiRgd/nSgu67G46wGEWBF0L1U/H6lF2cls5RIa8/P1skBgPnoPBqiiIUpmCRzgQFYjTr9Y40hP4iEDwsVgkGZr48dv75cz0b6NSGtU3XJe4M7+0/kuP0fsmi7WofjW1TEoKt557t9XUIyZYi5PcsPBEP5RFqp00oIXDt9pUD8PXg3Eds7z0dJz3EWwdbymPPCuUfHCFDKOf2klruuhSkCMMDqkOJsznrCynhLEKqU6yTYPbCRBP4VPGEcivd4c4htq5VBp8TfpDO5aiwrklfxv9S9jVFIYSPI7aGtI5rTtaCmQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790937878; c=relaxed/relaxed;
	bh=Wti1/ic+tFuZRhkQBnQgON5/duaVEeCqHwbWaV4Bke4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ef0O3EETsCEbuXaBKcSpokPBr3osyy3VE0ZqBG4W5oyCwoRMaRhf7sqnte4RcUJ1htuJgHk/MhnX9j2Y7AzgXJmHIafYt+x1AaszfrXVA9y+4CPTyCsMmg7Zrq0ODpDoyKq3wVVol1hdlActbETql/qQpy/k5fE5tkovDQhppVHtduhapN8tSBglSRgZDFlzrN2n/utzCh4sDsKTT4nBlAKFtlPqKZU3jygi+tJZq8zHbMxrNQu1V0/GDPzc1qqfWmK1kvh2mPChBho+4OCk3tMYPv3UjPqSxStfXWXmram4qR9o9+IZ/K6hFuwj+mD71QPGs/WrJN7R6TO6Dy3zmA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=QckDrOAe; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=QckDrOAe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hx5511c0bz2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 20:44:37 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zGNB5Vlq/caZsO4RCpvKvyMkYplxADj+2OrjxHkNj8hdU98E+gFvk9vLkxGM6l68zXF/pSx++swVQl/6y/WHzJ4fj0rKnnVXKHxKaO6zaCoXMyoSEUygV1NkeZ+4hZ1Ihaid7iOxpusDuhxpThkgkOA+hTbprBMk1Hpq5eqd8AjwNKBJ95z22Iq2ITRHqTp8DjoUdxFEJlyIIBsBGAKZXd3PfT1HuA/jhTaAe4zZ40elRg+0yJ972DdaBWZ1MYrRPoEjkij05VLsutK6UukL08/w6rAH1C3qgAUbQLSLogCvmylhOtOdhfzfOxl9sLmrjyZtofEepZfXeoUDF8BBAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wti1/ic+tFuZRhkQBnQgON5/duaVEeCqHwbWaV4Bke4=;
 b=fZUk6JIvGva0zldUq0oTYlIc39rZcXjw1KfS/YNhRGJXa9+xIc0P7VdxCcFqI/DwwRnbTOyHHSV7Zb7xGJjIO4aoFGXb6I19g8XE9pOjadXcu2/TQRFX6PTLdV2ek+fgkxU6qLIzzctBifoVN23dFA7Xv+BT5Veq9zCyqjPz0A30Xtsa8/tZhJPzerJd7CB9xXsA5Fzo4E7KmvPLDS0jxr92kCf3JpONLn5Z3iix1PD+iC4sK7BR5LsW12DAAxR5ATaNFLdfU8K4DsjsQhtNUiLAypt4XBVYGGoAlcQpCUFAm/doDJWO6eVxOTxAehAkrg0PNV/hDckU1yqXHtXeVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wti1/ic+tFuZRhkQBnQgON5/duaVEeCqHwbWaV4Bke4=;
 b=QckDrOAeuRPRffUDB5EJqqSdxu4gk0KsQwnlt8wPchH5tbYy8jYhhvsYOp5G9CfwYzg3+FHlSnn2tywGGOYYMJk54YIi+lfgtd8SVoT5WDrf3KI/sq+qgoJtzvyXdKIt1/PJaemHrOxKPQBRsZfVAL1DXC0QZtmTLTtwJIK7t68I7Ex0PYUB9yD1wN+NiCJ0Pm+XncRk5vqTt4hGhVdlT/2qcRzxE1PjL2alN/nIxaMtq8iMtxEsEMR6qdzykp/n9KzSK2BM7Sfe54kg50Iu2b9utQ6BeB6xiMB5DGFU4WbzHB3L10MQWf+tXdf4wVSREaXO4E+PhU/ZT7atAhvogg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB019273.eurprd04.prod.outlook.com
 (2603:10a6:290:d3::17) by GVXPR04MB9951.eurprd04.prod.outlook.com
 (2603:10a6:150:118::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Fri, 2 Oct
 2026 10:44:10 +0000
Received: from MI9PR04MB019273.eurprd04.prod.outlook.com
 ([fe80::263c:943a:dcb0:29d8]) by MI9PR04MB019273.eurprd04.prod.outlook.com
 ([fe80::263c:943a:dcb0:29d8%5]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 10:44:10 +0000
Date: Fri, 2 Oct 2026 13:44:06 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Christophe Leroy <chleroy@kernel.org>, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] soc: fsl: dpio: Free the IRQ before releasing the I/O
 object
Message-ID: <ajjy7y3ycnfqrofts457he5zlv34ncqg3n3g2qxgdgod5vbb2u@u56cc6pxihau>
References: <20260917200136.75721-1-mhun512@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917200136.75721-1-mhun512@gmail.com>
X-ClientProxiedBy: AS4P251CA0027.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::13) To MI9PR04MB019273.eurprd04.prod.outlook.com
 (2603:10a6:290:d3::17)
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
X-MS-TrafficTypeDiagnostic: MI9PR04MB019273:EE_|GVXPR04MB9951:EE_
X-MS-Office365-Filtering-Correlation-Id: 03b6e4cd-f114-4e5f-b0c8-08df2072178e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|1800799024|366016|376014|22082099003|11063799006|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	BFhT0Rs7hzh2bKNIId2BJwomcs9jl7QLBe8JnZ2wJJflZvrjYzVJv2tw3wgH8gY9Ufo0zi904a+1l4GtSUSD9zvRhTAQ0IFQ7F6KlD8wR33EV4AK1SSdlAff792zJoulZTQ9yHRd1qxgT6HRRF9bik9Hcotb/H4gOkGwL5c/ICEte60DYf5I88Fuf6DPn2DpC19gbQEYaPjdIZd2OvR74AwtDp4yCkh899MKqKQDfRjmhlbkXXSxFRa72sVudhqQBkA+EUqXD5bUeGZ9eQht+YN15mVNCzyi/aYWvgvCpcCS3HOApZqiYkxgGxoSVvDCSPhmOj3bwSjiwyAIK43hm79OvAAxlV5bIhCfEORS+zwA2ECUp2Nn48DuKPjkcIH0EJl/62aG7xGcwk7MX5DPFdWwts29yNgHsnYe8e3ODmrqHUnopm/T5P8XENiWAkOjL0mOdsiRa7UXWL7vPNj0lG0+/ywuQOsph1xSZlyT4I7ejdGlxCDN5taQTenhwj6R8JUp/iroVuZtbyGwXIFn1yEOljU1B5g5FoyXmIubjg9udq3lvpdYzQ/jyiG1zeTj9frQP2y2+A6ArbQ5dYNw/N3CXtkyxvUP0viGp/l8OS+XhOU9yrXr1/d1LBh5zqmFIEL0BX0S1Ufk7Z5Xz7oLBGBr6DSAiIEEa1uXh0cu7Ts=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR04MB019273.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(366016)(376014)(22082099003)(11063799006)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wwHoWHJyxr/cEHiS5u5jm20BHR8aCsqMH5YI34OtwRGOvtBtBNQVBrT8EWvw?=
 =?us-ascii?Q?xUJnS2GKKRj0B+y5PPELkOJQUkCZS6OU8mJzhpqKyUgsIddexZpJgvIFrgVE?=
 =?us-ascii?Q?EdFzeRYvLmpJrp3PzUPnf4/b5WdAQvecgDHA+VroJL09Xbrf4h3gGet5+2dW?=
 =?us-ascii?Q?Q9i93cKhYgMhjMeDWxKZe8PjyaxwO2RUp08iBvkUkWPcxZ6lNZBJ2/ignbFh?=
 =?us-ascii?Q?ACRkKFFO/Ug2ijppGHOsZx6oAyy+HwXRPI8PUijZAhkbaVECVGA96jYSZeak?=
 =?us-ascii?Q?4LEkU9RZXS4Z68wcrM8XfRY5ZqrOZSR1UVx7Og67gHAcSy0rAN1Hwt5gDcmX?=
 =?us-ascii?Q?RdxL35WWfTzZyqAdC9yB+Qy03Fq/TlTPM001cGawMQhQwVthRVmbTHyUH7JI?=
 =?us-ascii?Q?pIkcqghnBC/5Q7cSHUuIkuUYRk3hNRo9nR06MIyPv1gDbULUHPIxq7JQps1P?=
 =?us-ascii?Q?MSN8cQCuSCeAl3Wwqzeqed1OhzyO1j7bw7EBKnUQW/EbShGMRKu3wGhpUVuD?=
 =?us-ascii?Q?WjBb5l8LuR/rwnyIxCV6K0BJ66XCYjD/J66noCNiDLR60dQLXYSQ4rxgkGvI?=
 =?us-ascii?Q?TTB4wkFdM7uOeDOwRCMYcpfCup6yWd0m/3BDjzBPjzt0eydDawciU1scHfzs?=
 =?us-ascii?Q?ktTyDkcmvJaJuJrPgA2YasDlQxlFc54FCu79X0E4xYIRAmT5HRPS5xp9zM9m?=
 =?us-ascii?Q?Cjbz/lBick1VLIW3lhbma5Ofb2sWQw2w8XyC2J1EtUTrJkfDl9CmNDeWvWL7?=
 =?us-ascii?Q?wy2VcBqhWQo/b0uOh0cQf/q/UduXYEw82wisdXugP325QndPxjdYithKS/qH?=
 =?us-ascii?Q?ly53mBWPpz8zsR/YGwuIUt6YAMi0zgSAqFl7Re7XOCnSuqaCk3+Ozmwv7AsE?=
 =?us-ascii?Q?MBARqiJ9VSGXEgw3VCfBhCyFdqDlJcudKKP6DwIezPyTL4OOq6iUd0/or1se?=
 =?us-ascii?Q?LDxRJDE6ulrElKS/hNYDTpwFZKvsYHmWdKGHvgx56eQV27o/NoH/MCoj/Kb/?=
 =?us-ascii?Q?gmEmhQytCRoLPzaRl5zHnyW8VGnk8Egz06wYYL5xTKR50cHnUxpdRHqKMJwA?=
 =?us-ascii?Q?+TPDcR0XVBxtglbHxkoTdZGk+eG3TrsfzRzrNY33gs+FId7UYzNRxgUg3uGd?=
 =?us-ascii?Q?+fjpiz7EcgDrZOIp1oksRjuNDFtY36W7zYw322fA0LTT38r8GrDUCocioJye?=
 =?us-ascii?Q?LGoUVh12A6f4y5HWhVCbDXCRz7XmI+/wAoxKz65pvQTRjhBRaifXE9ODFrQn?=
 =?us-ascii?Q?muDhi9sZVAH+tG2/NWMZVmIGRLgk5/53cj0StBVCgqweC/PGOyB3GOLEIHU6?=
 =?us-ascii?Q?NOj1l1EuEbUQpOjXA4BzABle9IBDR+BnuLbGInWdg+4tqk6E/HJQDsYwT6sv?=
 =?us-ascii?Q?xqkDoJJMqwwmz7gQaO4YSjH978HW+rArfXXFgqwcf6mYA9j6RXn4b3TDvNlF?=
 =?us-ascii?Q?sGmKkE+xGrSlHDve6Mr1lID2v6/LOQbWxeBYprKD1JWnpBvrefaj6eu7yCIy?=
 =?us-ascii?Q?oesqf7A3mTQB0bcw9QWOoDRUpIEmdIZ5CO3yMouGioq2fDFCuvNb5IDqLAVz?=
 =?us-ascii?Q?MbUzy7h0BorUGom9YaYyXD5iw0bUmZdKlOS0jdoqfAzUKUNy5OvZeGEqSEyX?=
 =?us-ascii?Q?qGKViu+EAqLiMiAWBFAgzSk/Ey2h/264PqlELMtDpLlY0CAJjcziMGjA8yRr?=
 =?us-ascii?Q?HtPXpS5PJh2unpYZ0hsdXxygj6S8IS3+W2wYsKAEVKQGBzyMC12m/ZXp62Kj?=
 =?us-ascii?Q?5VaJzTI4qg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b6e4cd-f114-4e5f-b0c8-08df2072178e
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB019273.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 10:44:10.3917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CdpmzpNSDi5oyfu1gEgySuFFz3LMuqLQsaJzASG8lsOYwPz2GhxlWkQG09vnpiwYLNutVzw8kKacMkFI9Ll8mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9951

On Thu, Sep 17, 2026 at 04:01:36PM -0400, Myeonghun Pak wrote:
> The DPIO interrupt handler accesses priv->io, but dpaa2_dpio_remove()
> releases that object before tearing down the interrupts. The IRQ was
> requested with devm_request_irq(), and unregister_dpio_irq_handlers()
> only clears its affinity hint. fsl_mc_free_irqs() returns IRQ resources
> to the MC resource pool without freeing the handler. An interrupt can
> therefore access the freed I/O object before devres releases the IRQ.
> 
> Explicitly free the managed IRQ before returning its resource to the
> pool, and perform IRQ teardown before releasing the I/O object. This
> also waits for an in-flight handler while the object is still valid.
> 
> This issue was identified during our ongoing static-analysis research
> while reviewing kernel code.
> 
> Fixes: 993fec7e11ca ("bus: fsl-mc: dpio: add the DPAA2 DPIO object driver")
> Assisted-by: LLM
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>  drivers/soc/fsl/dpio/dpio-driver.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio-driver.c
> index d5198ffc4455..fa82cdcc4922 100644
> --- a/drivers/soc/fsl/dpio/dpio-driver.c
> +++ b/drivers/soc/fsl/dpio/dpio-driver.c
> @@ -263,6 +263,8 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
>  static void dpio_teardown_irqs(struct fsl_mc_device *dpio_dev)
>  {
>  	unregister_dpio_irq_handlers(dpio_dev);
> +	devm_free_irq(&dpio_dev->dev, dpio_dev->irqs[0]->virq,
> +		      &dpio_dev->dev);


I would suggest moving the devm_free_irq() call inside
unregister_dpio_irq_handlers() so that we keep the register_ and
unregister_ in sync.

Thanks,
Ioana

