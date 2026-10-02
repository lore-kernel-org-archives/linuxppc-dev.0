Return-Path: <linuxppc-dev+bounces-28742-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72BE4CA5FC4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 10:37:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hx4wd54t8z2yDs;
	Fri, 02 Oct 2026 20:37:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790937441;
	cv=pass; b=Tlx2ZNW9I84+k+pr/QPwjBpbV1bMkz6XfbRMUtrpqsOAlDdfjSyjZFjBnFqsvlKKhsJ7B/2o1FqrWHH9/ky+/MV1qXgJGjYetVSFConIAAV4VxIjEj9B66jktXV82Zfl6R1NksDO3PSHBXxwdSY0jPwuc1Z8KFZEoTehYM08Ox6K8X8muY7/p4tob+eMXseINbJAaEni3WOiNnRg6kt3Fwzav+sPuLT417zjmS/15SZfWLeUCfJAio1tTV+QUBHvzC1dZJTB+0xdaWUaQx0nayv3ZirfNW6E9i2Xhqs4GqRJUHhbVLRlcXT43B3se+uX/Pv+NeHw8WuYL/mzMD9mIA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790937441; c=relaxed/relaxed;
	bh=hiQyeJsKEuxDWQN+Q8Iqxepfw7Kni0K8bLfTsyDB5I4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LOSpCaAudY2OFX/M2Z8HKEGApTCBA3sMEXlU+eCXq9kJ9MlNobNOklGFx4iy64wLgvOQXwmj8NUqz90LldKiTVUTPzEnsRtnE3P2I0bF+2Xu1O0c1VYEDF/qM7n+JSbuc8R92tT6FO4BrjZTTQ10TDwnHN6SsdKG9+GFWUjFkqHIhIhoimLWXK1LMP6Hl/xKQmVNOWwQznTmD35h3XhLipGXjg2/0att930AvC0kfGwQL6p+kUjauFbo1jncmFOMScdWDusRg6CCTov8blqdJTvruoqGXqOckB6Rd/QSh92NXmNcd1TVMVFZJ7WUnitTV/xxn/jYZ50kOrJx86tlDQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=eTJi0z/3; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=eTJi0z/3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hx4wc292qz2xfq
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 20:37:19 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AfSOpTf6ZDmBX7dmqqFzDaH992l14Wi5UrQgiBgIPmh0EgYwsXSofdYa0WZXp1188HHHDhXDXGcLwPTUGexDL84DunUsPfq+f+3qjX4ZYKpQMZWizERF8Lw9+vGEDX7ppL6t/1ZzJEP0yIVE2yPh/8cxtQUiTd7V5Mw5RxLFA2dTcrI2Hl6PxqZT2IgrWEOiTTg1QMVOl06tZgPSpZa20bC2uOQG6OsKBsCU/796kPqezvbxzZFYfc9zPpG98vvzhK2N/3HDaWHlOC1I1VsNGrjBLrjFIRGgyJbYMcMGwtLlXzTj9CWkdNcKpzkc1JGPeTPhAdRH0rDkvMCL1pl+1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hiQyeJsKEuxDWQN+Q8Iqxepfw7Kni0K8bLfTsyDB5I4=;
 b=o4GxLl89yEUfD4Pn+3wxaK7oesCGv+scjlywfAYaqzMS2KsqqdkR8kLqEYndv34EgSMMpQ0xYFyakS15OyQ0Qlxb4xc/5OIn+LOTEfp2zpFGRvIUkEXbYsxSaXGH1KNrfNUsX5w/pEB1isKgSbANd7urFqWFjrfmA2S1tcQ+XhZ8irkHYMd6QI7FlgaCG8uCc4cdcYY7n63qvAMQ8YbI95iaOVCM9iiXp7DU3xlAFy7ck5mFOZMDoTOrVRBDKNYwcc4uz5SyxnvltUiNlUe3cJ/OfPfx4TIj+7gSWjVv2qB+EtSPdvIygW8wPIsJkt7GkoNDTjJ9Ea65vOKF/iD60w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hiQyeJsKEuxDWQN+Q8Iqxepfw7Kni0K8bLfTsyDB5I4=;
 b=eTJi0z/3OEDYuTHKUrYvCdhF2UJmd5/RI83yKWxK6cTfJkjUIHcuaNSUVrm6bMOuq5RBZOlUxbzbXGvFct213Aj6BP88opuYcY7FS5suPtcqW6MQ9McTlLUWAWm+nOwLnhNzP9KpQWPu5SNGEWehbfQtX2+YLn68Os9hbo/0f4TAVT3Bpiz8e9U1LcOdMpfjeBylszlpej1DKPpbkgmY8p+rivGjuHTDToy5n7/m53MJdYc4aGHBSzlOtvJW3A8Hbmut7+a6tP5O26VXFqeGlNBkO5i4XHO4HIKnhnCvHPd+spoyhh+Kv8k1k9y5YALCrZ+bEaWAhbKZySi4/zi88g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB019273.eurprd04.prod.outlook.com
 (2603:10a6:290:d3::17) by PA1PR04MB10769.eurprd04.prod.outlook.com
 (2603:10a6:102:488::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 10:36:53 +0000
Received: from MI9PR04MB019273.eurprd04.prod.outlook.com
 ([fe80::263c:943a:dcb0:29d8]) by MI9PR04MB019273.eurprd04.prod.outlook.com
 ([fe80::263c:943a:dcb0:29d8%5]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 10:36:53 +0000
Date: Fri, 2 Oct 2026 13:36:50 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Christophe Leroy <chleroy@kernel.org>, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] soc: fsl: dpio: Release the I/O object on IRQ
 registration failure
Message-ID: <b6hispezu6tbs4jcejf43svafckftcnyis2f4elnr37nf7dmvy@pk5us5x2wqzt>
References: <20260917200138.75755-1-mhun512@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917200138.75755-1-mhun512@gmail.com>
X-ClientProxiedBy: AM8P251CA0024.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::29) To MI9PR04MB019273.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI9PR04MB019273:EE_|PA1PR04MB10769:EE_
X-MS-Office365-Filtering-Correlation-Id: 899c67e7-7885-492d-0518-08df2071135a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|23010399003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	IgCQ58so8EblsjKt6RN/4u5GyoWKo17kqN4UMZEyaOhVrQDbbqJ/tlIkWFaWbdVMxU4+uRjRZkjmN17mAb+wuixF4513ZlR1awHqaKxNqIIb2NqjB6XiaDxDZU2Y3xpR4J/jdsPN9S1zNu11bYgBZbjO9c2ayYSyicUpaiKXP5UhHtx/oe4Qriu3CYSHcAEuaYtH2SOR6xHPrk7nuSDN2s3Do0gOAGO6rZ401/XPlo+wkRTP7bA1Uv37zbuvveQWFzGLRMz/0iI2eWvbI5CETvW5Evdv4WwMlz/eKaeygbMuzxSRo9LY50Ffexwf39lzs/NtLIapUvs98gt/pltWVEKVEUSW2MrBkogxu+gLH7J1nOWDgADGDOoZbmT2cQh4NYAEzWQob5z9m7wO+4hLmPwCvhIiXUB2d9cEyeAdp1gR+g4avO0tWJtsjKOwiWYwQBPrR/327tGMaSnYEYunp72YMWfqE1ngrYQWG7pU8BNuPrc0tfr8E5NzndS+2AuchqAwfzLf6FWVuwwsXrR/zNkTnYfxapz2wCEab2LxxVXwfpSKRT5iqEa7hnizPzNf5M0ly/pUucITQny+da2JzF8LsbjeRCx21aTNZdhvHX84XADvSPHkJtIMNvnYdOfiw5Xd6zsASwwtB89YJAYsu/b2IYimVLRDnEuxnIRnuMM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR04MB019273.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zkH8e3myjTkKlJvX0HSPgM9P5Z5F9c2SW1IJAxwLjdeb7xwM7BfXObzq61F8?=
 =?us-ascii?Q?Ty16BFMsqmtbH91eRFpIz2DpANcayXV6EeT6kAMb762eXpXFqWS8NqR8JsZj?=
 =?us-ascii?Q?z9uIBu4KWVk50uUEQEy89hm8TtmSXgAjXsP/sORctsZROSvULEbiWqYle9Np?=
 =?us-ascii?Q?yGEsiAwRx3g7+tuoVWcKIUsIFoCMk6RXv06UC5nvv7Mqx2N13th707AEt9A8?=
 =?us-ascii?Q?v8JcM2d3SNwR4l/cC0GQnqDgmQ841GhCrKmO5uNgf6hkmZ+rnXDYbhL3o8r7?=
 =?us-ascii?Q?RKtFQJTVkblpuo5jp3i1AUMfPZwW2MnfnYitju4nQEIS4wA1PxCReyAM936n?=
 =?us-ascii?Q?+u/8vG0x/MUVJWLXN1CT+3MnHHplAPH/0poE/2tgo/7ELgzYE8wfVDY//Dbl?=
 =?us-ascii?Q?pL4MoJjtAN01XiKV4oOA7yRlZG/s2ZGoXSlEzHsde+JIE5Hcf5idGgQKSJFV?=
 =?us-ascii?Q?Mocnf+ADPqJG6+/ImFcyTq8BrsNiebstuic4yEgzXxFB/Um9ix/9NcWfht8+?=
 =?us-ascii?Q?fYvgQg/KXL/I6oSQnPkUkbZKt+/dhSBm1OqiCKHpECrFIm7AJEz1vVtH7CWE?=
 =?us-ascii?Q?V6vZyfndRl07ZjOQ2ScXm3GxKVWbM76xS6+5EKuPzr0Gnwf1LUxa0Q5sJT3G?=
 =?us-ascii?Q?8Q1Obqb3kJiVUdlukSUTxoENP8m2u5WuI6R/Hw9jwqTfdACrRWji/DzW4Ylf?=
 =?us-ascii?Q?JFTY9fjXH8oKuhQE8RSrAF3p3l2WU1egTI445R54PqN9Tk68jPiY26bjnUyO?=
 =?us-ascii?Q?pdksskFB5IbVpOS9f9jCwbLwlYedGXUqLWDdkl/wvEhFSoxZLADrftP3WY9G?=
 =?us-ascii?Q?1nf4P9IyWd2e3oKOH+7e4+ZOYWqeM/kSRMG4VCfws4geh4TgzUb2jftSfLA6?=
 =?us-ascii?Q?u2nmEu43zwi4xKxh84i3AAX+ULn+uvaxrkUndBmMOB2QJWGCbKznAcQK2gjR?=
 =?us-ascii?Q?grdrSGC0aWXcqFfNsdEv9KuaLs/1UfF9tA3jJYfYhkNXt48BABM+0aUW3ROJ?=
 =?us-ascii?Q?Xfwd6ItjR0k+ZzBqeZmz8M8iNQgUSWQIOBigNRnsaFKaPBFgH2kxjiz89JnQ?=
 =?us-ascii?Q?rXqjCpldAoAyHNbAyv9GSabn+ywThBAeLbNg77xh9wyxeNoRDGnM8F2uRVri?=
 =?us-ascii?Q?IMg4qG0tp3j0GYZ6Lber23uzTx8C+ZrepOVT9PJzeewABYL3JuANMnDNGoRt?=
 =?us-ascii?Q?AE9vrXbyHAi0Y3EyHmTUKW/3YAYMo1+S743QnltCLxa4xYqeLDCdqm6ARJkZ?=
 =?us-ascii?Q?KzQQd4EqEbP7CcOKFuKgVWyJ8rGu3vlqLMBRyKUj2goRFLtME6F+RavfAjIL?=
 =?us-ascii?Q?oTg67e6RZ1JYzrZyv1vaY4tstX4SXtUvN0lDaygzzg3fuItm71PaL1V7MktS?=
 =?us-ascii?Q?ekeai2SfWfpAFoQYA/RsyzEavfla5O9rTM0FKx6VjorxjAyvUpBuK0qoUFfq?=
 =?us-ascii?Q?zgtks1c97W54hzYr0YwLX7Z3Qn5ZEXBi7CR8KjCOOy7fKGGCIrL8QeteogjH?=
 =?us-ascii?Q?L3hxbJfBnC9fmBqR4xKeBIGZl6c4e3h5KrZkpcs4FJorMkm1bz1Y6J1dN/BY?=
 =?us-ascii?Q?uIxDOgXqKAao0o1MSXspcP+F4rKcQG3hgbkcElMIkN7Ywc4ZftmbiHh+Ab46?=
 =?us-ascii?Q?z8yv3HW3xIJjjUgpZknn2tuQ2oApUrEOmkS1HPYx1CLIzaYAtE0fVDe4U2mh?=
 =?us-ascii?Q?3sJ67JB31XSrefRl+K/v2JGySdSd9GzbvtcV/i96moT2TdV5VmgczRpFTuUq?=
 =?us-ascii?Q?zCkw0iFaMA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 899c67e7-7885-492d-0518-08df2071135a
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB019273.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 10:36:53.8463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqb7VHDwpoVlJJBtP0fJkF8BcZxZFn9e2/NqVckRdc2njS3K9dmMsuATyWjSQTxMhGMFRuAKKitzzg2JrYgSqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10769

On Thu, Sep 17, 2026 at 04:01:38PM -0400, Myeonghun Pak wrote:
> IRQ registration happens after dpaa2_io_create(), but its failure path
> only releases the IRQ resources and the MC portal. The I/O object stays
> allocated and published in the service list and per-CPU lookup table,
> while devres unmaps its portal registers after probe fails.
> 
> Call dpaa2_io_down() on IRQ registration failure to remove the object
> from those lookup structures and free it. Reorder the error labels so
> that a failed dpaa2_io_create() still skips this cleanup.
> 
> This issue was identified during our ongoing static-analysis research
> while reviewing kernel code.
> 
> Fixes: fe8fe7723a3a ("soc: fsl: dpio: register dpio irq handlers after dpio create")
> Assisted-by: LLM
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>  drivers/soc/fsl/dpio/dpio-driver.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- a/drivers/soc/fsl/dpio/dpio-driver.c
> +++ b/drivers/soc/fsl/dpio/dpio-driver.c
> @@ -244,9 +244,10 @@
>  
>  	return 0;
>  
> +err_register_dpio_irq:
> +	dpaa2_io_down(priv->io);

Agreed, if register_dpio_irq_handlers() fails then the dpaa2_io_down()
should be called.

>  err_dpaa2_io_create:
>  	unregister_dpio_irq_handlers(dpio_dev);
> -err_register_dpio_irq:
>  	fsl_mc_free_irqs(dpio_dev);

But if dpaa2_io_create() fails should we still call
unregister_dpio_irq_handlers() considering that the probe path didn't
even reach register_dpio_irq_handlers()?

Please also fix that in a v2.

Thanks,
Ioana

