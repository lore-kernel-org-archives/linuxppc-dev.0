Return-Path: <linuxppc-dev+bounces-23950-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DEBC43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 17:31:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gx27x5rNZz2yf9;
	Fri, 10 Jul 2026 03:31:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c105::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783618301;
	cv=pass; b=GGy718Pc2ZE7jiRKP4kTVB3f0OSGn4NZmIKTmHWwJd73QfcoBVKs7vtDK5r0z0hQYIy2tDRHhAnUPxCCwCxCRrFgAnhk0vkEzqKMIXnSZxgSQAXLcPV9YXK6YoXbbX528Y7d4tg1eWI4pZGR/0+TyFss13qyDsyTbhOP9j2Wx+AV0gucEysY44Lqg6b4rkjT20gb+JgB4bcOOKBCVFW6CUvGr4G/JQXmZB+6EwN3BJQQoNtPB3R7DO1i/69OscsGqWp20Cacf0ap1Y+0YrIAqVJpwxZJXDnr2tERgaaGA1xAE2+nG+VVu/pZsyQif7Z2eaSkYjTw2yRlw9c5OullSA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783618301; c=relaxed/relaxed;
	bh=7zuEJkHBRCC99KhxsqHG4ENFAbvlvtYI8/11p3ZJ+7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bWn8Vo6qw/6aHXRo6o3a+5DJVbrV/bysquveSiPXR8FIdLOesLQ/9mc0AguGc8X5F5DvqobesnML8qR7uShJzKtokp3AvhRPXZglS4j2jfZNy4crN/5aDwRplquTghYZY9zblnRa3Uk16q0kqGvEIuXrqqxM4cuxzce4D6Sl5OFo3nN2iXwl0V329QYJXCkAcbXSyaP1ar5ggRaVzMD4e/g85PMFMEzp0EdTXetU/Pw/ooTlPvg5p7IpEVC6wbNZHm4/E1S7a/Utce66rRTgaqhs55NmEEfsdRZt8xM4Emnp2GlZt+kE1Nh32t+wmLU+cjQOPmRIINb855AXDpiyZQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=myo6plNq; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c105::5; helo=ch5pr02cu005.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=myo6plNq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c105::5; helo=ch5pr02cu005.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org)
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c105::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gx27v5lnrz2ydq
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 03:31:38 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/P2ej6IMSKY1PGpAxjl4kmrlJ6s9VRGBEHqDWLU26kl6thm12q0HO17NjodvkZAQskKauBaoNQeeDVkcKvBdIwvpj9R+P60fKyMoCvERXxKcH8ygibCcWRoTmGTViR3W6HmtSk5rTRXbDmZpZrAivevtOLZGkdBXSAbdpYRLNCM8nQDrlMcxNqY54CVNLo7a7D6C7udctBU3QR9yjLjTFbO0Iswpr3sZnjx3COtsFbEK4hgX3BycSEizX5dFiIYqNNRi+j6WWkA4lrtZjbC+WAQMNx10ktWwliKaZHcr5xHxwflYdDCm2BzC1GEWb3RL06s/JCUYPOrZaftBgtpIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zuEJkHBRCC99KhxsqHG4ENFAbvlvtYI8/11p3ZJ+7A=;
 b=MfQ4hbALeiK3Mhqv2sU45htJCb+W+t/36UbU7MFAnD3M2FYcmA2GRHfO5V21nUknTASCDoZ7WikpcZ2fvHI2I8YQGB8Y80EL5Ibhv6mT0pqEZk8qbSmLW/K/YtizfEf3wz31zIRPY/8DFYUIjS4a817YDjM1cVg4teHAT/WW5yPfSDQmiu9vqw8jAKoilNeujv0OLt+BhidqoYV5+zbpgf4x/1vX2Krom5GrqFfsf4g8eiMPUqoFBKIlRxDPswkH+bQW0mGNNK+M5QNZ3wk5VgFgFi9IdhgU6nh0Ph4MR75M4bXty9MHhtJoss1XMDRz0i/yS8EP975wE/ImK6mUeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zuEJkHBRCC99KhxsqHG4ENFAbvlvtYI8/11p3ZJ+7A=;
 b=myo6plNqSmd7ZFadOdAijXK9LBDmrrXFBFYa1W57LUOj1BVGGs/WL2iEFSHa/tfuGsRdnJdcBMt8Y/M8i/8KsqgDqVGamWsnGV6RYlhSHJcJFCLh96uoGbi6q8F0sqpzfexwmLR1R4EEOw96Nn8xNiMptaV21K7czcbXxoBTddIZj5gJ30jS1HQl1LUayaFZEMEmenqNseosfjTLu/nXX3aLw9RTZpws3tmZ4guX6FTNgE4zMjIMrk6CJgeAN/mkYQCG8vuhEscDVF2IQEwBy+W8UcZr7BQ9Kp+bB78Ym2+w7uARXtSvu8u7oS2HuFYs4yEg3Tp3JOE/cmESxB5eaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by CY1PR12MB9700.namprd12.prod.outlook.com (2603:10b6:930:108::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 17:31:09 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 17:31:09 +0000
Date: Thu, 9 Jul 2026 13:31:06 -0400
From: Yury Norov <ynorov@nvidia.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Erhard Furtner <erhard_f@mailbox.org>
Subject: Re: [PATCH] bitmap: Properly initialise destination bitmap for
 scatter & gather test
Message-ID: <ak_ayOBErDQR5HH0@yury>
References: <67d1838732b85b1f715cc3ada5bb38dcfcf9db55.1783593992.git.chleroy@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67d1838732b85b1f715cc3ada5bb38dcfcf9db55.1783593992.git.chleroy@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0254.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::19) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|CY1PR12MB9700:EE_
X-MS-Office365-Filtering-Correlation-Id: ec874a27-35c9-4bd8-d0e0-08dedddfdd2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tx+lVfjf/YFRWhsq1wWidhm7b8xU+vwf+U0MC2qcmhjrQoAeur6I09ekhCXrXD2bMdOZ4xM6gQccnrvjrmLbxCl8qlo6sWX6/B8JuZwwXhSyuz3jHVqpqGdfnPYfc984FPC3faxXmmbuSASYrU3sTz9++NO6oyjAIU7luFUOK4w3CB4w72rsMcaFqoIqguUcKMEYv+I6neIx6n1RQTYixflXzYtSBkD/BYK9YzaWD9o3xIBCovOlCQfCtLa859/ZceJqszbNbiYLkfoBRiEm5xA9MgP88gqaOC1R5fAKipzKuo84n77INJlJ0Kr0qabqbUsMjxktTB6VMcjoz0mh0nXSHKb46+lVwn5IQlSIYQHMoCk1lQPm82L7FbNYRlcKhsN9h37ARVAiGkP9nbOSecP3VBJQAe/Zy27IDS/W8vNw8jXl0ODmghDOBlJBaZuEYVxWYL8bf5y9tr2QQvVgct8DVHPQMoDCNqzfDEJptWc1M6xSO3j598xq6Hze8SNV2+65L5YDboKI52qSqBvw9/XgXCYROCHtjssd/6jEcxCaabYQsp0pxF7rWirabir8ISkGBhjyTzLRZ9GCeAd0Jwj/pSkzKL7Hru4bU8EAdId+YdpoAdFr0H18yqjkc+bKYjRz0mYrHZMm5Q//g24+BHEqaXOM05cXHtlUjq/antc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wKalUwWHIX0hPdx0l/JJXOvIKCIAuSuElAjSBofG7fFv/vtqs1jUAaRc5WwU?=
 =?us-ascii?Q?AbWOdZFFYT6RpLHvxwto+GRQQCncg9d/BgOB8FKtscUYjGxfIiyPQv4Bl3lW?=
 =?us-ascii?Q?p5WJ566onS690PFZAsoQkRHpFnFaZNIyQiAwIU0M0nJXk5BEn0yUPeYOXwCO?=
 =?us-ascii?Q?aNaPiJ3CZwcvmn79oUcIjPHEF9PuO6tZnksIYuZ+7K2vbNre4STdmodlnH+G?=
 =?us-ascii?Q?24Wv5kb4QfheX4B+UxNnT019aGK1HuArc1OGhwCw2qw2kECXfKlU7QIboRF6?=
 =?us-ascii?Q?m5B8PaAgIWWd/n2OTudne61ltm671rUKzE+wuQjm+XM1FNBjpz8jUBoLMuuw?=
 =?us-ascii?Q?2kgydeUy1dC74nhVXDXrX0LCZtxJHqBSVGshjmO8BslsAm2Mp2IlNh9wkCVW?=
 =?us-ascii?Q?AZ+LTG3+yZtTM8TO9ihT+niWWkKJ3uSuKEjCIXxDpEDUfzoDbAMcRMHdHEOR?=
 =?us-ascii?Q?SDipAq/dEQJKSXn8lAT337SGpI0UwECAkvTjg30yhKARNlUnkDz7UFbqSCe2?=
 =?us-ascii?Q?LgTUvaEGf6aKsj8Y+dntLBzF7DxLxZKQ9glW/m4UIE24n33u+rufriYE3e57?=
 =?us-ascii?Q?XSMge6DzpDUB3QfYpu5imxmvXaMg9fT1QCvjxa+UCnkAR+YmjraZfqJUNfV1?=
 =?us-ascii?Q?EN+qO7pR1w5EIPzkhNvv1XfWP8X5czG5u6fNiTn7S6a2JheopYrmhcQc42to?=
 =?us-ascii?Q?VwF12DxpFX26TmO75+QW5Taq+Ek68Hv8jadfSq+LlDlP0kR7r12/1LiKCRGQ?=
 =?us-ascii?Q?LcT/cqcMQNw+tGMmyTUHWiUYESEJXcr/acMvh5oTTXqSToINXs+VNqPFU0Hz?=
 =?us-ascii?Q?NLn4/3qkXrZs9VMjnsc7yqrpJP76R9V3Mx4gQ+aQocYktbuJBy4WjdR2H7xG?=
 =?us-ascii?Q?96+KYn/ctaR9Ku3eOgufo36zVxeaz3KJvS+bQ4RN2Nybl6D5d+T/Cxr301t4?=
 =?us-ascii?Q?MtDWwBw1ryjuQb8BFwSmxqLEUZvN2d2WxHdbCREgndpvNpKdj4CEQUKvLIgj?=
 =?us-ascii?Q?HN+lY5X2r326E9pWYDLYm54dDhl2UG27FcGHYnpvanT5ooCxoDTr1qHD53F1?=
 =?us-ascii?Q?sHzRi0nOLYiess45KdZmxqCLpbyd12/jb5WTxDQ/ws+VJs1JO++2Ic4LHQD2?=
 =?us-ascii?Q?PzuX9Qj2P9x4TkFvZLXwhAoZW03/ZExvTH2brW/AYO1EWNzp+DmcQTLN3gvr?=
 =?us-ascii?Q?e5jGfJErfrkxR0SWyxeCLatxI6bTxhQNQkfwBFH1uXg13CPEwfVvcYqHkRXs?=
 =?us-ascii?Q?EYZBX25+QVzSZVmhSd43P6lEkX3cua6R4J4p2KtU0SdR1UoTofdLc+zT798n?=
 =?us-ascii?Q?UhEo6CJG86XL5N9dYfMO+d19a5h+BzZ6ytx9NCS2zBQRoJMA/oQwrdW6Qhl5?=
 =?us-ascii?Q?XR74+pnhxHOxzkOiSRYi6zj0cIuwxx/DVyXipVR8J4RAVQjLz8TZjWfrwkjx?=
 =?us-ascii?Q?UW8KM81Ey1UDuXstFtXsNc5EGht42M+fTJmBw7dnyI1g6OfThYtQwfV2ACL8?=
 =?us-ascii?Q?PDc177l1Fqz6lvhF8dwQC0X4Lipt2A63fOLTZTsZhxjqfuvCKiaUS5T7oGd5?=
 =?us-ascii?Q?ffZHzQdHNoxuawJLB8GAq2Li0YhdFqbdEL+vme/pHyNsyT1EmiZrwApvC8oJ?=
 =?us-ascii?Q?w/7q8oYU0jrrj8A/zy0BYYix8wxSa20GFQKGxz+RWMxFgvbF9EDrtM4JFihi?=
 =?us-ascii?Q?7lPMonf9/zAi4DzkWap6YWHCOvBIDY0XB7Gw1IYNuSd8pBqM2tsPJbAf5bBk?=
 =?us-ascii?Q?+8YrjzBy0A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec874a27-35c9-4bd8-d0e0-08dedddfdd2e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 17:31:09.3119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GDtgbDPAYN+Saj/TnYD6webtBKq2msm4lbPr0WsKaBE9oG4V6fRFAw43UBvRGHB6pLHRk2IFS7OYl0qasrvboQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9700

On Thu, Jul 09, 2026 at 01:40:06PM +0200, Christophe Leroy (CS GROUP) wrote:
> Erhard reports failure of bitmap tests on powerpc:
> 
>   test_bitmap: loaded.
>   test_bitmap: [lib/test_bitmap.c:397] bitmaps contents differ: expected "1,3-4,9", got "1,3-4,9,65-71,73-79,81-87,89-95,97-99"
>   test_bitmap: parselist('0-2047:128/256'):    912
>   test_bitmap: scnprintf("%*pbl", '0-32767'):    5977
>   test_bitmap: test_bitmap_read_perf:        1191082
>   test_bitmap: test_bitmap_write_perf:        1270153
>   test_bitmap: failed 1 out of 208655 tests
> 
> The happens mainly when CONFIG_INIT_STACK_ALL_PATTERN is set.
> 
> Commit 6b5a4b687367 ("bitmap: Add test for out-of-boundary
> modifications for scatter & gather") extended the test to
> out-of-boundary bits, but those bits where left uninitialised.
> 
> Properly initialise the entire result bitmap before the test.
> 
> Reported-by: Erhard Furtner <erhard_f@mailbox.org>
> Closes: https://lore.kernel.org/all/ca3547ae-8b79-43a2-a758-23ec980bfd9a@mailbox.org
> Fixes: 6b5a4b687367 ("bitmap: Add test for out-of-boundary modifications for scatter & gather")
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

Applied, thanks!

> ---
>  lib/test_bitmap.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
> index 69813c10e6c0..448c3eb48a4a 100644
> --- a/lib/test_bitmap.c
> +++ b/lib/test_bitmap.c
> @@ -392,6 +392,7 @@ static void __init test_bitmap_sg(void)
>  
>  	/* Scatter/gather relationship */
>  	bitmap_zero(bmap_tmp, 100);
> +	bitmap_zero(bmap_res, 100);
>  	bitmap_gather(bmap_tmp, bmap_scatter, sg_mask, nbits);
>  	bitmap_scatter(bmap_res, bmap_tmp, sg_mask, nbits);
>  	expect_eq_bitmap(bmap_scatter, bmap_res, 100);
> -- 
> 2.54.0

