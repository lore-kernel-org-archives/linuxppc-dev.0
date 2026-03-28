Return-Path: <linuxppc-dev+bounces-18965-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DDB710D1481
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Mar 2026 20:44:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fjqJJ1QzKz2ySc;
	Sun, 29 Mar 2026 07:44:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c107::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774730688;
	cv=pass; b=D4kKbMEA0qDDFngyCGw2foKCXZjNUX4hUb1v/BmV5oYomWujDMnp+lDIEBVkJawCg/je8lB6E1aAgs7uQkOeA3/lZsxBTPFANrmtGKHFivH3F94mVh/s+lmWKfcOYvlbQQ0Qs3fn3/iXkbusCCfryG90bRk8t0JES6rr0ocFmKySIrDYmyhlOhfY0qXRVD60dEOjv92971Vq/dMWNpRfYwZQ/gD6jcaBjKKAbXh8Bq9y6ancR3Fj9cX/kbWnDo0XmaqYap6WwEELtQWPmpfOHAHgIsb0twzuZEDDdeebqiOypEhJXHnT0CYMts1uHGOBgl7dBRGwMGXE350KWuLDUA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774730688; c=relaxed/relaxed;
	bh=1PgXl2dHnrO3L5XL4Z1eyZnBc5OxEW7kpseNB1h7h+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j1ioWaV7ZNKFraWNUrrqktKVY7zVGLo4kjT4ViebtExczGSeIEhSNKzDdnD/OaVbfFa3dH17DMS6TEuAYQNtDY8mxT+0Dio4Suw/giMCWOuzwah/j7h0slKfrzkOND06G6WqLjLc6n4iOFnINkxHl/vlKmEpmqc9wV+UeDbru2CEGUTdJoC6aGPVkG8H8bJ83bel7sNr/WWVEIsma7NwZoJGbVljx84AFhm1W4MRWbjAs4pSGuRTuZUEVdu2hXLs7Kfbs2T0xdb3GK9BC141Hhlaq5BlKBUdT6LyQfuDvqf9ZIzg/zmwRjtri7RYqOlKnbW6TuEg5sLcVHpN3PNkeg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HrBEvwvS; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c107::3; helo=ph0pr06cu001.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HrBEvwvS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c107::3; helo=ph0pr06cu001.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org)
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c107::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fjqJH1bd6z2ySY
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Mar 2026 07:44:46 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yi9HvG54xNyjdLGmUmdE1xwDtNVpkJj4gDWYZQb2Pk+Ozn1vyfbF5fV77ERjDzBXmQt7/Mg0zRClGjLddank8EQrO2KOSWFxVXOnvLfaEIZ24TVM33H3bKLB7onl/qxloPfqW8LCsAQrRLu1W6N03HSpFLnPF19jegYAJLYKj/90ylLiMSPLl80W3PKAvPYzbv7KuNpVCGBhQFErt7SVhoWPpiVoNNn4xUd5LGyQSq2HdVnDAOkFdo9o5opdIoMxR8ujCVM/o7wruw2QCop7Nh/4lgzPfEwP5SGMZYQDbvTVduD1zn/pPenAp/8hQF41e6OnwElmA9Wwk8Spyl0zIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PgXl2dHnrO3L5XL4Z1eyZnBc5OxEW7kpseNB1h7h+0=;
 b=cya/PnroaGpy0zeAWglbdWNtRRxZ2i5d2LlgjatUD3iETR/LOzv/EI2SsXg/vTrk2kNRAShtgzwH7uzjz3OIWpb86doQkVrizGib9vaFtFM7mDop2QfXjQE6lyeR5EK6r45IDuhXH+iLiHAUlztNjIMjDB1L4vTqOSNZoWnjc4GSlcltJni4EhmNBIforWhVX99pn7KoovPTz1c+v2ErsqklZY+AM7TXfoF0FZXE3K4Y7nIUvFxr+qvICx46VbwFXV+FQ71OUvBKG8BjIt4rkJY8pQ+Nt+4TRbD2/GmFGymI4B97ETF1JYedryvdgFKCdLnPhs+I5k48Cm3KUS2RMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PgXl2dHnrO3L5XL4Z1eyZnBc5OxEW7kpseNB1h7h+0=;
 b=HrBEvwvSJGItS/cw0VfAHiPRcQLCdDgyflNgrgNLWQkConzf+OoDVTLYONcncadHyAqQqtVU43eYrM6BpJ/J4R7U7hxUE4CLHn+/Vayi7V2IUiJ8pyJWIkTyipnK9THsq0xLnwKzqPirSZYFuTmEUIjjfjw6dsBnoOWJtaJEmaqVG4/2qJp4uki1h88k6HJpipJVvjtkvJNsPg9zuNYqg0CKMQULU97qqBBXMgypk+iibCeLg15/uQWCKSkv/Yd6CFe2JFbCsUg+Fji1jS+FZTvniKq33+jL0eqp69WXc9BH7DjkbvyVH9PJEWhhFm8PuTJuv6r8isaDN7miMORV6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7171.namprd12.prod.outlook.com (2603:10b6:930:5c::20)
 by LV2PR12MB5943.namprd12.prod.outlook.com (2603:10b6:408:170::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.11; Sat, 28 Mar
 2026 20:44:23 +0000
Received: from CY8PR12MB7171.namprd12.prod.outlook.com
 ([fe80::4487:395f:3abf:ad9]) by CY8PR12MB7171.namprd12.prod.outlook.com
 ([fe80::4487:395f:3abf:ad9%4]) with mapi id 15.20.9769.011; Sat, 28 Mar 2026
 20:44:23 +0000
Date: Sat, 28 Mar 2026 16:44:21 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
	yury.norov@gmail.com, linux@rasmusvillemoes.dk,
	linux-kernel@vger.kernel.org, chleroy@kernel.org
Subject: Re: [PATCH 1/2] powerpc: Use cpumask_next_wrap instead
Message-ID: <acg9pa74Go58lq0O@yury>
References: <20260327063129.127302-1-sshegde@linux.ibm.com>
 <20260327063129.127302-2-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327063129.127302-2-sshegde@linux.ibm.com>
X-ClientProxiedBy: CH0PR03CA0196.namprd03.prod.outlook.com
 (2603:10b6:610:e4::21) To CY8PR12MB7171.namprd12.prod.outlook.com
 (2603:10b6:930:5c::20)
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
X-MS-TrafficTypeDiagnostic: CY8PR12MB7171:EE_|LV2PR12MB5943:EE_
X-MS-Office365-Filtering-Correlation-Id: 10ef7c3e-86f1-49ae-5a6b-08de8d0acafd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	NMFW91vrm5pyYK94oHn3T68dlyowjls0imYeO/ChYKPY4MhaXHUNuV7KvRgE1TxzHUrEBpQFLj/LbpmZFQleS4UaV86tErro9lQ/EeksZgl8BRgTNuq0Dd6tfCLYx3BExMcf56SrPhxJqs8U6UG/ArtdIKf7X42LpIFIEeWrNxF0QRlCxur2MTQTWZznz+iog4kf6wISqnhi05PPQJEvFA0ZgL6ezY1Vs53jslpQ5mnjkMCdf7OeMXyh0+ezpAia8Ps6JR8F0DxCOXAyCKwMs7ZJe2tJFIkmIIAxcy/gn2C94dgl3SqGb2NupAkpDlzymneeeOFfEZ6rT4s/1y+flAcyHwtuZrETOJGPvrSzfG62U346c8ZpgOrb6RELPIaI1YGNKFei1G7fPOt1ZeQ/dCLBv52h66LN82PqeZ8ZRgq9oZLZv7kEoErsmoVoaSs8cpFd+IaLsy2Yuv64sABionLbYbmuAN+AMBDZAHxjYDn0b0rjmNuMHobmsaxQSuHwtGEEoPcemKDCDhOvswQfCh10vsEsRCgEd/+nWhxXvYFRcc0mTxRBXmrd//SKnsbZlCy7YuXOwj9qAEvgdKQ83ormRFb6CTPktHYvNtpaPhmNWccu6xLeRfYN5mem8EHB+nk3AtjEXaGvst1poqfo2MPEbMOmmoBEF/Nsu83yHBmG/CP37TY8OL/OhrgbqMKkUGF7fsXT6jQz4XS4ZHPu+qDB0UmWT4hqiqwCEEQbg/g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bvC/67mfdj8+4aqahVOJckMDrUrViDls1ryseDk5hWTyrVZKUcaaOFMN/QJG?=
 =?us-ascii?Q?mHdBaogFom6s57stlOngQJPB/jJOWhbTbXNGQSdVPhX4pmeBGKhApQj4WUWh?=
 =?us-ascii?Q?6qdiMSnUIVWBFsOfIwWraJiWPKF2/6p5Jwm7+yT3gQawrDFw6mB+Xuu/KS1D?=
 =?us-ascii?Q?6R3orONg5VEcr3+29C56dwRmAa09RTVPUR0AwcF3RBGQj0m2QfW/oGvKjPR0?=
 =?us-ascii?Q?PGvZU3x0nH99ZK4s3ea3zeAEnoCi/e+VrBVQIhaEK5D+41DFxx5SDuzugVA8?=
 =?us-ascii?Q?Yh74zODgfdDppWFzjW7L6+SeJK+kO5fmXNaySgI0C7EmANJAlUSdUFG+R8VA?=
 =?us-ascii?Q?RMIoJOKRorwamdf+kSsaFwsjTNNFcdp6BkqImuBZ+x7JRc1ioWz+s/hADBXG?=
 =?us-ascii?Q?/eXFU632ojj92hcnrUYmummx0LB5CerSBbpiR2JvGgUPeRmBDakPkxsPfsY0?=
 =?us-ascii?Q?g/6X0N/4Kma7ZwZzLallqd7VD3BIMOTuRcvNNHqzed9vN2ZpXHZFZBa1GI8i?=
 =?us-ascii?Q?ymm34Ki9ZYvFQffbQlpyVdZtnAalN+XwpTB36UyzDLfPOeH2OrY76dGtXbd1?=
 =?us-ascii?Q?0/eDfLSSOaKCNDE3cyNa3ekVCl7GN8jrAFnAgQBDoIgmjxSW8X9lXHetNMl6?=
 =?us-ascii?Q?EY085N0y+bethRL7YITAtpHzUlbE0hoofTFaqvzJwE2dIx14QfW4CwadSVB5?=
 =?us-ascii?Q?UxmXl4V6/FCs7J026xhN4tVm5vOm41M0PYpDKT4vLiwyNl5c33s+gXlBjs8v?=
 =?us-ascii?Q?/UwtOVHj5UhbexznaqvKEBVpET9gfsmREEtyS+gQmKWK3JcSzFg3CeH40WaS?=
 =?us-ascii?Q?IdXGqWIL82eli38P+C4OUSgACojyLUEGN8X7nCwL7tSU6nFtJe6LH6bdvo1P?=
 =?us-ascii?Q?3srOUfrZMRUmV4y73OHTskKvc8u4yKd9ab7yciqR7JJk5ZLv9YaCtYdVCqMf?=
 =?us-ascii?Q?w1NMQ6yxW88jEmGKNfMwtsH2WzOEGFheOnVF7Ox3pkF0afpN+bfeH+gtpxai?=
 =?us-ascii?Q?AxLtq7OS8zsixp6J/BJQBQNAWUtPtome6qc8sHhpLUMzR6Nk+/AowY3H7B0/?=
 =?us-ascii?Q?zyh4KmbmUsmPNIl/Z+V2Pjj1PDwkLQ0DIElzA9BPrp+XMNPWttciVW7FcHJh?=
 =?us-ascii?Q?v2oaMdPtOl9yZeNDolJlDuEmgP0l1LYgU8Y9sFU+HN4+IgjxSo5Np5ANJoQk?=
 =?us-ascii?Q?Ocusd3hiBlKBECxhfvDuUOOhV5ASvv2+W6XJs0N1lrgvs90lDtbZ9Q9nzeg+?=
 =?us-ascii?Q?Uo0JR1VnppBSIUxHeJrwvzWy13pCWCohG1BCKciqqX+5KC/vVfvS7m+oSQVn?=
 =?us-ascii?Q?+dixXKMzJZyWkmg9ZVWtCHInJvK97R/i7p2zXeoCmmcW0N8I1nnQ799GaEc/?=
 =?us-ascii?Q?vzI6huo5Zd/M82vZPMKEYH+uaGsvZHHX99SqYp0sV0WnA74GHvZcnoLyYMoA?=
 =?us-ascii?Q?tjvLR+TQwBMiGR7lCsRZZSttU310C80okvVZ6JrMguamBH6B5KAy3qQTRQsk?=
 =?us-ascii?Q?b66m+Clx14CZQljfJL+EsoCpI+EYWzvpI0RE5xzqvU+/z4A1PrNl5y5AgeYh?=
 =?us-ascii?Q?YnRclCqtJNQJiBPROOpWyJ0YaNJ/TA67Y2FeMmtYBeTfIXFojD7ONvOYFn8Y?=
 =?us-ascii?Q?ib2FSn7vghKtN+ZcuEP4A40DD8nzNu6iEqogkx9q8XKQB8nISCkqffCYLPZ2?=
 =?us-ascii?Q?psuKfpPu7lei8SnUPG63nFxot1f0G/5BvNZZY3UrSoV3F1IcJpqcIqFs30aL?=
 =?us-ascii?Q?r2hqTDMpqOoBuV6X8lEcorDjOloaqXdxF8UX4UjucDYpHsBLXY+2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ef7c3e-86f1-49ae-5a6b-08de8d0acafd
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2026 20:44:22.9824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QMDeolQ4hCV2eLeNQsVdzr/CKDWI4RLH3k4C/KbZazRmmVMykEfdj5RsQWY2WCs/uuTew9QJCWkZDCwBjB3Xjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5943

On Fri, Mar 27, 2026 at 12:01:28PM +0530, Shrikanth Hegde wrote:
> cpu = cpumask_next(cpu, mask)
> if (cpu >= nr_cpu_ids)
>     cpu = cpumask_first(mask)
> 
> Above block is identical to:
> cpu = cpumask_next_wrap(cpu, mask)
> 
> Replace it, No change in functionality or performance.
> Slightly simpler code.
> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  arch/powerpc/kernel/irq.c             | 5 +----
>  arch/powerpc/mm/book3s64/hash_utils.c | 4 +---
>  arch/powerpc/sysdev/xive/common.c     | 5 +----
>  3 files changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index a0e8b998c9b5..f69de08ad347 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -370,10 +370,7 @@ int irq_choose_cpu(const struct cpumask *mask)
>  do_round_robin:
>  		raw_spin_lock_irqsave(&irq_rover_lock, flags);
>  
> -		irq_rover = cpumask_next(irq_rover, cpu_online_mask);
> -		if (irq_rover >= nr_cpu_ids)
> -			irq_rover = cpumask_first(cpu_online_mask);
> -
> +		irq_rover = cpumask_next_wrap(irq_rover, cpu_online_mask);
>  		cpuid = irq_rover;
>  
>  		raw_spin_unlock_irqrestore(&irq_rover_lock, flags);
> diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
> index 9dc5889d6ecb..e4fcf929cb33 100644
> --- a/arch/powerpc/mm/book3s64/hash_utils.c
> +++ b/arch/powerpc/mm/book3s64/hash_utils.c
> @@ -1299,9 +1299,7 @@ static void stress_hpt_timer_fn(struct timer_list *timer)
>  	if (!firmware_has_feature(FW_FEATURE_LPAR))
>  		tlbiel_all();
>  
> -	next_cpu = cpumask_next(raw_smp_processor_id(), cpu_online_mask);
> -	if (next_cpu >= nr_cpu_ids)
> -		next_cpu = cpumask_first(cpu_online_mask);
> +	next_cpu = cpumask_next_wrap(raw_smp_processor_id(), cpu_online_mask);
>  	stress_hpt_timer.expires = jiffies + msecs_to_jiffies(10);
>  	add_timer_on(&stress_hpt_timer, next_cpu);
>  }
> diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
> index e1a4f8a97393..b6446abe29a6 100644
> --- a/arch/powerpc/sysdev/xive/common.c
> +++ b/arch/powerpc/sysdev/xive/common.c
> @@ -577,10 +577,7 @@ static int xive_find_target_in_mask(const struct cpumask *mask,
>  		 */
>  		if (cpu_online(cpu) && xive_try_pick_target(cpu))
>  			return cpu;
> -		cpu = cpumask_next(cpu, mask);
> -		/* Wrap around */
> -		if (cpu >= nr_cpu_ids)
> -			cpu = cpumask_first(mask);
> +		cpu = cpumask_next_wrap(cpu, mask);

Again, for all except this:

Reviewed-by: Yury Norov <yury.norov@gmail.com>


Can you move my series for xive_find_target_in_mask() together with
your patches?

>  	} while (cpu != first);
>  
>  	return -1;
> -- 
> 2.47.3

