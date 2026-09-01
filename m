Return-Path: <linuxppc-dev+bounces-26402-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E06C61DD6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 15:29:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZ8t0684sz2xmh;
	Wed, 02 Sep 2026 01:29:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788276568;
	cv=pass; b=fGp6or6HSBCi3g+yH3eS2BafAg8t2AkCGUNs/+Hg+fup9ZriX2/ohEBgzZKF3wZi0NK3a54hUUAbI731+8hcradg5cpUPYRL/glLin/Le5qr401XvQ9xJwcgL9ZZ2MkqySYknb/5sdGYGT/vCAifCSsyjshzw7jMCWPqACwTdgQu8AMtBA3IbhBK8Cmo3Vi9y3Rw9GLJZR7jEHjhpZFb3s8NRP+pcYh4UBWq16GMl7LSH29RnPFzPqpKEJQst4XNCEzMVdITK5TYRJX8uQu8mHrbwDG6HUAU2MWdGX4r3SPSQi2lylnatsv7JhaQKvsOPfUp/htRTyivcjc/SMSTeA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788276568; c=relaxed/relaxed;
	bh=v3PHvMpmh9t3OblqYk7p7NX9pi3mpAUaOPP2ECDHumU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nKnuD3tJg8ItYeTtOXTqLoWnHmm7knHGTAhfi3w2TtiahB3FloTvoBN9RmzBvF4cfMTBf2xuOAJBQXVLTlUtcrS+pSnxahB+XmPagF3iYt+k2xji8XLISvnmVLgCLOZ/ZvYmV6JDrSLqgxkJCSDVjNASxpEBWEcVgWmhh5jcit2M9rGz4EtTi6QQJT+BlMDlsah4U8lff9wWOCYc/VEyF+Svw7IwcW8UBHJaaUFr45bOoUKHmzIkbPSFSADLiTbUEhRy/105iEc88DaGXFUcora5tbnC0AY3d096b9RRrc91w3216bIxoe1OUr1zNbeoITJVgigUc30YxBfj7C5jVw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=P0lpEf1t; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=P0lpEf1t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZ8sz1JBqz2xGt
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2026 01:29:26 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PX5okQzm7nWs6uidqR4/Z+hKbswq2JGXv0CLNV6mmZ8G1O9fDg5/fWqPL43/Flol6MeZAvyAOb0NF7GWH15jXHK/ke18GL8rLt1xAp5UzToFgtZZd/snK8GWtojfIcVnhHagrArJ/ckFgyLN8Ajuzo3ei5v1VYJF8aHrpOWJSL/jQr8IfjyjwfwwKPFbIMWGcgJSjf4WkQLvA/syXwl5u6e7baminhxAXd/f+GrgNFvrg8t9JGfC7+XVR8A4bfR7hxTZmYMFpTP6sgaKEVgztOhjH5HUwHApDumQytGkpTNW+84mmLpKi2dhLKKeue8LzCOKHBfkmZrUevhNms97dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3PHvMpmh9t3OblqYk7p7NX9pi3mpAUaOPP2ECDHumU=;
 b=asdM6wmPMRWsxdIqGPm782ABnUu+GupjFOQVo/NT70fzS+V6k9IRHVO9kvm+fTjIqsPAWTtUkX4YFmFNg9qSwlw4QTeSSIYzYaQvqOLAQ1FHTffkxaeu0uLcCNWs/m6pEWuAYSCcCW1mmCWtgiCmofN7u+9K4N/WNRqnvZZtTowassiKm6GuWbndKxoIYzWzZxUVgJXe4FNHTmT553/nk8T2j9v95wyi4YZaa2xyZP1LpxY6kA2+kvLKr+rL7g/jGUcFPOPXVQMeqb91DOnmPkRPYfXI2saB0nLmOwUZcyaHpJ0GhIgcH54ICRaNCk6eV0fqr9AHNp9KvaJScyQESQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3PHvMpmh9t3OblqYk7p7NX9pi3mpAUaOPP2ECDHumU=;
 b=P0lpEf1tCOhBvLT2cNHmFKx7Eo69CJFiZT7pJEI11JwosaRUhJauqwQ/bqbXfdxhelkO80MptQaMXZEnyye3f1ka2wPplsQs1n/H9yMCwaviN8lnF9Tzk19Vwb8mjIkqIoczVh/bgqby4ZIpUhtHt5EyOtu8AFh+SYrnxfg5myM5PdyklGn9YHGvrGl36Z1+msQ+TYebM9zWiJNpKVlNjm4YgI2MwduDV0GmBMkuUu1JhzVDa/g3inUDBc3xfNddjdKW2C9Sm375C86+auTStMdbJRenay+K2KpZ/SWWv6UmHCNSTSSoWYq/EIHuhCOl5zRAIqhV+1ojXtPc8kEHbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM9PR04MB7505.eurprd04.prod.outlook.com (2603:10a6:20b:285::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 15:29:00 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 15:29:00 +0000
Date: Tue, 1 Sep 2026 10:28:47 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Julian Braha <julianbraha@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, Frank.Li@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, kernel-janitors@vger.kernel.org,
	linusw@kernel.org, kees@kernel.org, colin.i.king@gmail.com,
	rosenp@gmail.com, joao@joaoff.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2] powerpc: remove dead 440SP code
Message-ID: <apbvL6_WqojjOeRA@SMW015318>
References: <20260901150645.1199097-1-julianbraha@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901150645.1199097-1-julianbraha@gmail.com>
X-ClientProxiedBy: PH5P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::13) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM9PR04MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: 0611e558-e069-4c0f-161f-08df083dbec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|23010399003|376014|7416014|6133799003|22082099003|18002099003|56012099006|10067099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	RGuPsj8o45FSoS2OpJjtw5KOYvVTybg9khUmuMspJ3y31YW2v8A60Fm3wURLweynx5SHnXJ4r6o1ZvGqHWGcaZUL3aeD31xMTSMmD3G8LOhaiLr6X4N4bj78LFMlckyVQJ9HkHMIPMsLRnkjV4IGsTq/zIdRKn9Q07ZPgMTqE1K6MZwk/jh/Mi6gZvh1pUvP4Nua4OUKts8W1K8uXPEqHvFp305qvn+BEPtHQ1DMOAlbZF/pMetlrSI+HhAPxaKm1sBQl2AqmVWwyrsOIYlUZuNMrzZfHx/u5W48oOtg7zb8ja0LRUV0JEOf0NIDBJKbz4NLDztVWkgzcmpkhDzM05G1DsXIOfB9TKan8AcjtqQdU4LrYXsTxnv2lGFRzejw1ibC3P37T6M2cgw+wwa6XgdT/P3VgRrIrp5PgZLN3YORVRk7m70azoAJn8ja1nxUpTCohCIvHjiotA8k3vk4ZnaC6nyCgut5T2dELuDCAsDe2ENcG3qwRpf8PosJP9+AIJXxrozihko0NRSyVnG/HbpfqjWf5gihrWBlvwWKTh/GBOB5L96XdFEed6nlHWKEDV4TtzmghwAyo6D1hZ+ZYh6OEsDwTtyTDKXfKXFvGmyuhEvIJ2oVtshHKey4Mfw2dAfnEhM71O1/PdDGpe7V5QU4uxJAwaxoKi/XG/2Bgs4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(23010399003)(376014)(7416014)(6133799003)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JgaKkNkQ40px1isfkYkdaelZDZ3lqRPbfsVQyBRx/gRvhWOgBYWsP0yrtqA5?=
 =?us-ascii?Q?Q8aXZOaLY0MntIqcxP1t5eOAqWRiVSfytlz9TBJidaC2tQj5slnocrqcIkqk?=
 =?us-ascii?Q?6msIGKs4MqzC5H/AwF8DMgTU6biWAzuGKhL8waMpZwKoSpAx75HRqe/oWuqa?=
 =?us-ascii?Q?/Dl6BvRhyfZqUt7HxLGwkZ3AGbktYUvL5GXJra712QV3mBSZUrunz29588v6?=
 =?us-ascii?Q?W1H0aGN4OEXToO6stmHTLosYl41rbMRoPLh8ZUpMe8Hi5+Afpg3JjesO+lu8?=
 =?us-ascii?Q?ZxITyQz8YKNFlE3su/6pFqfBWygvBJ3RM2r0AVgJpMbe27csn9cPmggP8XPp?=
 =?us-ascii?Q?NEVtWVTHr5T3Z24BZ9LQZiXupUxe6/GKYPHCaWE0/lw7DkmT9nBrv6FelvgR?=
 =?us-ascii?Q?KqTcGm6wV2Yk6KWi1SGHnEiuatfcoOHWxzEpmaWKYunnw9P6gXsFlA2XXQr1?=
 =?us-ascii?Q?IzQvbtRIanp3pUDQkm//aFFcfTeJYDIMGZk2+0Hd0fGHUFzKyDrn5yqS39C4?=
 =?us-ascii?Q?mPJVaVlgUqGPfsI1Eu13IsJYi4fnZHiG7Vple0tfO3UHfuliAHOfjdQR8FEC?=
 =?us-ascii?Q?PSPEcwCMjEby7QC/RJDphd7InFhQ6oxwVVXELer316e/9epRHqmD5D4gVy/Z?=
 =?us-ascii?Q?NnLgM4JxBio2YCTdjmPnJ6bVOgvj+jJrP9B2pJ59Qe9SC87kMb//0LJ39QOL?=
 =?us-ascii?Q?xoczsEK/fKXaK6zVEaavbPJus1S+ZXAkOYIPpGnx9RCZ7fI4fOoEhVxSdM1a?=
 =?us-ascii?Q?TbxenjM5Bkv58jnKe/2lqwwkxTUoSJ5ZktAogRH1Ch8NnOuClRJUu0t+PsiC?=
 =?us-ascii?Q?8YXmg9gRuSS/SOPAV7Bpa9CCH6yCwlYpnwPZnmY/gqFT8TYKwU2MUrXZF/DR?=
 =?us-ascii?Q?QjR9B+H1QXlImjzM1t6ShoDF/d0LBIaqz6O07OzBL68EsCAhF5wLPE7QRbvY?=
 =?us-ascii?Q?wL5srmC5dBjDNqDMkomponGD31YFYL2bjBRJ6U4OcfBzBa0lzdkauqSTuLlS?=
 =?us-ascii?Q?J14oKLpAqriqtYU7GOn76V6wGwjZnO/vGBwAcdzHgpTlSZTFK61RrUwLyQTt?=
 =?us-ascii?Q?XaqsB9KijMWcersg81jvb8OqbzAva96vtmhs96W9b/xIgbn0e6hb44V3m7Gn?=
 =?us-ascii?Q?M/5FHXjGoUN4CPx8RMVcB8als2mfPyAn/EZbuMIxZHXNCZf0fV1Y1YFuELma?=
 =?us-ascii?Q?kB8H6jA8k5Yts4Ks7YZUpqdCPpvvdrHFWmRPHJMrR6wkkQXwq7aExrO6f8v6?=
 =?us-ascii?Q?dkKohGrsp1bB4FA8cZZ8IihSG+Oc5eLJu+iqpHkxWLHiCpvMpf0Co2bOdqoq?=
 =?us-ascii?Q?ZueJXpkzXlOzO+ReriELnabwwCiyGvlQ1bvdhxQrkxz8dlPYg2x6Te1oZYTd?=
 =?us-ascii?Q?+u9uyO+TPpnKWvkKmKkENWObInbtJzZG4tWd6M5ZXXFchjbGUv8R6U4c0IFd?=
 =?us-ascii?Q?9dzE3PPU82epTtyoLue4Hu86fQaBemCYH4mZcALS78Zw8bruEoAdkzGNXvXQ?=
 =?us-ascii?Q?6ZFfUWmcdufKIJay1F4bdNPsUxIfDR3S5vmxtAhIRfSH0j0/i5TRirkf6qJC?=
 =?us-ascii?Q?n3HPeAbKexY2+MSc7/D3p7Et80YFwEkRzQrLiXas0RUsmK3lm3gaiHz1v2H9?=
 =?us-ascii?Q?OR35c3RIJ4PuDGwh9XlXMYVP0MIipJ2ay7N0Jos5askz/OzXkMIkzC/pEUTk?=
 =?us-ascii?Q?gSkSlmpSYIlYsduO4KPx0+ZReVBwQvEqA6Jwix/N37jTorGuXgkd4K7F0pWn?=
 =?us-ascii?Q?VeNRcIV/iCE5m4zq66ItCeVA+JzwMBS+2I2ha7Y1K24P/D6iuVo2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0611e558-e069-4c0f-161f-08df083dbec9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 15:29:00.0992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R0+SosJxLhJnst/O4ytzCHi00XD19mVEgo3qSaQVLHcIg3XkpsoAopE4l5NEOsQ3uk4iJ063V/q8F2xkYsfW57X614hAVdaKtzsJ3jpY/8HQDSpSXRFZQmF7GbRvceuP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7505

On Tue, Sep 01, 2026 at 04:06:45PM +0100, Julian Braha wrote:
> The 440SP config option can never be enabled, making all references to it
> dead code.
>
> The only board using CONFIG_440SP was IBM LUAN, which was commented out by
> commit f65573314e4e ("[POWERPC] Re-organize Kconfig code for 4xx in
> arch/powerpc") then removed by commit ff5f483f3091 ("powerpc: 4xx: remove
> commented out Kconfig entries").
>
> Let's remove support for 440SP, since nobody can be using it anyway.
>
> This dead code was found by kconfirm, a static analysis tool for Kconfig.
>
> Signed-off-by: Julian Braha <julianbraha@gmail.com>
> ---
> Changes since v1:
> - cleaned up preprocessor condition
> - added historic details to description
>
> Link to v1:
> https://lore.kernel.org/all/20260816125615.985387-1-julianbraha@gmail.com/
> ---
>  arch/powerpc/boot/cuboot-katmai.c   |  2 +-
>  arch/powerpc/include/asm/async_tx.h |  2 +-
>  arch/powerpc/include/asm/dcr-regs.h | 10 +++++-----
>  arch/powerpc/kernel/cpu_specs_44x.h | 12 ------------
>  arch/powerpc/platforms/44x/Kconfig  |  3 ---
>  drivers/dma/Kconfig                 |  2 +-
>  drivers/dma/ppc4xx/adma.c           |  9 ---------
>  drivers/dma/ppc4xx/adma.h           |  2 +-
>  drivers/dma/ppc4xx/dma.h            |  9 ---------

Please split for difference subsystem.

Frank

>  drivers/net/ethernet/ibm/emac/mal.h |  2 +-
>  10 files changed, 10 insertions(+), 43 deletions(-)
>
> diff --git a/arch/powerpc/boot/cuboot-katmai.c b/arch/powerpc/boot/cuboot-katmai.c
> index 034a748fde24..fcd71e76309f 100644
> --- a/arch/powerpc/boot/cuboot-katmai.c
> +++ b/arch/powerpc/boot/cuboot-katmai.c
> @@ -31,7 +31,7 @@ static void katmai_fixups(void)
>  {
>  	unsigned long sysclk = 33333000;
>
> -	/* 440SP Clock logic is all but identical to 440GX
> +	/* 440SPe Clock logic is all but identical to 440GX
>  	 * so we just use that code for now at least
>  	 */
>  	ibm440spe_fixup_clocks(sysclk, 6 * 1843200, 0);
> diff --git a/arch/powerpc/include/asm/async_tx.h b/arch/powerpc/include/asm/async_tx.h
> index a14758426dd5..1ff5b2ca3ed1 100644
> --- a/arch/powerpc/include/asm/async_tx.h
> +++ b/arch/powerpc/include/asm/async_tx.h
> @@ -7,7 +7,7 @@
>  #ifndef _ASM_POWERPC_ASYNC_TX_H_
>  #define _ASM_POWERPC_ASYNC_TX_H_
>
> -#if defined(CONFIG_440SPe) || defined(CONFIG_440SP)
> +#if defined(CONFIG_440SPe)
>  extern struct dma_chan *
>  ppc440spe_async_tx_find_best_channel(enum dma_transaction_type cap,
>  	struct page **dst_lst, int dst_cnt, struct page **src_lst,
> diff --git a/arch/powerpc/include/asm/dcr-regs.h b/arch/powerpc/include/asm/dcr-regs.h
> index 5c1a4973f46a..e39a55e527da 100644
> --- a/arch/powerpc/include/asm/dcr-regs.h
> +++ b/arch/powerpc/include/asm/dcr-regs.h
> @@ -25,11 +25,11 @@
>   * of the driver main register set
>   */
>
> -/* CPRs (440GX and 440SP/440SPe) */
> +/* CPRs (440GX and 440SPe) */
>  #define DCRN_CPR0_CONFIG_ADDR	0xc
>  #define DCRN_CPR0_CONFIG_DATA	0xd
>
> -/* SDRs (440GX and 440SP/440SPe) */
> +/* SDRs (440GX and 440SPe) */
>  #define DCRN_SDR0_CONFIG_ADDR 	0xe
>  #define DCRN_SDR0_CONFIG_DATA	0xf
>
> @@ -159,18 +159,18 @@
>  #define  L2C_SNP_ESR		0x00000800
>
>  /*
> - * DCR register offsets for 440SP/440SPe I2O/DMA controller.
> + * DCR register offsets for 440SPe I2O/DMA controller.
>   * The base address is configured in the device tree.
>   */
>  #define DCRN_I2O0_IBAL		0x006
>  #define DCRN_I2O0_IBAH		0x007
>  #define I2O_REG_ENABLE		0x00000001	/* Enable I2O/DMA access */
>
> -/* 440SP/440SPe Software Reset DCR */
> +/* 440SPe Software Reset DCR */
>  #define DCRN_SDR0_SRST		0x0200
>  #define DCRN_SDR0_SRST_I2ODMA	(0x80000000 >> 15)	/* Reset I2O/DMA */
>
> -/* 440SP/440SPe Memory Queue DCR offsets */
> +/* 440SPe Memory Queue DCR offsets */
>  #define DCRN_MQ0_XORBA		0x04
>  #define DCRN_MQ0_CF2H		0x06
>  #define DCRN_MQ0_CFBHL		0x0f
> diff --git a/arch/powerpc/kernel/cpu_specs_44x.h b/arch/powerpc/kernel/cpu_specs_44x.h
> index 69c4cdc0cdee..41ed2c16d8cc 100644
> --- a/arch/powerpc/kernel/cpu_specs_44x.h
> +++ b/arch/powerpc/kernel/cpu_specs_44x.h
> @@ -172,18 +172,6 @@ static struct cpu_spec cpu_specs[] __initdata = {
>  		.machine_check		= machine_check_440A,
>  		.platform		= "ppc440",
>  	},
> -	{ /* 440SP Rev. A */
> -		.pvr_mask		= 0xfff00fff,
> -		.pvr_value		= 0x53200891,
> -		.cpu_name		= "440SP Rev. A",
> -		.cpu_features		= CPU_FTRS_44X,
> -		.cpu_user_features	= COMMON_USER_BOOKE,
> -		.mmu_features		= MMU_FTR_TYPE_44x,
> -		.icache_bsize		= 32,
> -		.dcache_bsize		= 32,
> -		.machine_check		= machine_check_4xx,
> -		.platform		= "ppc440",
> -	},
>  	{ /* 440SPe Rev. A */
>  		.pvr_mask               = 0xfff00fff,
>  		.pvr_value              = 0x53400890,
> diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
> index 150813cea945..b481ef2b0f4c 100644
> --- a/arch/powerpc/platforms/44x/Kconfig
> +++ b/arch/powerpc/platforms/44x/Kconfig
> @@ -260,9 +260,6 @@ config 440GX
>  	select IBM_EMAC_ZMII if IBM_EMAC #test only
>  	select IBM_EMAC_TAH if IBM_EMAC  #test only
>
> -config 440SP
> -	bool
> -
>  config 440SPe
>  	bool
>  	select IBM_EMAC_EMAC4 if IBM_EMAC
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index ae6a682c9f76..f0f61b4932f5 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -77,7 +77,7 @@ config AMBA_PL08X
>
>  config AMCC_PPC440SPE_ADMA
>  	tristate "AMCC PPC440SPe ADMA support"
> -	depends on 440SPe || 440SP
> +	depends on 440SPe
>  	select DMA_ENGINE
>  	select DMA_ENGINE_RAID
>  	select ARCH_HAS_ASYNC_TX_FIND_CHANNEL
> diff --git a/drivers/dma/ppc4xx/adma.c b/drivers/dma/ppc4xx/adma.c
> index 279a431ccae3..ecbf4c84a318 100644
> --- a/drivers/dma/ppc4xx/adma.c
> +++ b/drivers/dma/ppc4xx/adma.c
> @@ -4349,14 +4349,9 @@ static ssize_t poly_show(struct device_driver *dev, char *buf)
>  	ssize_t size = 0;
>  	u32 reg;
>
> -#ifdef CONFIG_440SP
> -	/* 440SP has fixed polynomial */
> -	reg = 0x4d;
> -#else
>  	reg = dcr_read(ppc440spe_mq_dcr_host, DCRN_MQ0_CFBHL);
>  	reg >>= MQ0_CFBHL_POLY;
>  	reg &= 0xFF;
> -#endif
>
>  	size = sysfs_emit(buf, "PPC440SP(e) RAID-6 driver "
>  			"uses 0x1%02x polynomial.\n", reg);
> @@ -4368,10 +4363,6 @@ static ssize_t poly_store(struct device_driver *dev, const char *buf,
>  {
>  	unsigned long reg, val;
>  	int err;
> -#ifdef CONFIG_440SP
> -	/* 440SP uses default 0x14D polynomial only */
> -	return -EINVAL;
> -#endif
>
>  	if (!count || count > 6)
>  		return -EINVAL;
> diff --git a/drivers/dma/ppc4xx/adma.h b/drivers/dma/ppc4xx/adma.h
> index f8a5d7c1fb40..0ec35382d274 100644
> --- a/drivers/dma/ppc4xx/adma.h
> +++ b/drivers/dma/ppc4xx/adma.h
> @@ -19,7 +19,7 @@
>  #define tx_to_ppc440spe_adma_slot(tx) \
>  		container_of(tx, struct ppc440spe_adma_desc_slot, async_tx)
>
> -/* Default polynomial (for 440SP is only available) */
> +/* Default polynomial */
>  #define PPC440SPE_DEFAULT_POLY	0x4d
>
>  #define PPC440SPE_ADMA_ENGINES_NUM	(XOR_ENGINES_NUM + DMA_ENGINES_NUM)
> diff --git a/drivers/dma/ppc4xx/dma.h b/drivers/dma/ppc4xx/dma.h
> index b5725481bfa6..17cbb2d1ee1c 100644
> --- a/drivers/dma/ppc4xx/dma.h
> +++ b/drivers/dma/ppc4xx/dma.h
> @@ -70,20 +70,11 @@
>
>  #define DMA_CUED_XOR_BASE	(0x10000000)
>  #define DMA_CUED_XOR_HB		(0x00000008)
> -
> -#ifdef CONFIG_440SP
> -#define DMA_CUED_MULT1_OFF	0
> -#define DMA_CUED_MULT2_OFF	8
> -#define DMA_CUED_MULT3_OFF	16
> -#define DMA_CUED_REGION_OFF	24
> -#define DMA_CUED_XOR_WIN_MSK	(0xFC000000)
> -#else
>  #define DMA_CUED_MULT1_OFF	2
>  #define DMA_CUED_MULT2_OFF	10
>  #define DMA_CUED_MULT3_OFF	18
>  #define DMA_CUED_REGION_OFF	26
>  #define DMA_CUED_XOR_WIN_MSK	(0xF0000000)
> -#endif
>
>  #define DMA_CUED_REGION_MSK	0x3
>  #define DMA_RXOR123		0x0
> diff --git a/drivers/net/ethernet/ibm/emac/mal.h b/drivers/net/ethernet/ibm/emac/mal.h
> index e0ddc41186a2..6cdd40bca2cd 100644
> --- a/drivers/net/ethernet/ibm/emac/mal.h
> +++ b/drivers/net/ethernet/ibm/emac/mal.h
> @@ -26,7 +26,7 @@
>   * We call MAL 1 the version in 405GP, 405GPR, 405EP, 440EP, 440GR and
>   * NP405H.
>   *
> - * We call MAL 2 the version in 440GP, 440GX, 440SP, 440SPE and Axon
> + * We call MAL 2 the version in 440GP, 440GX, 440SPE and Axon
>   *
>   * The driver expects a "version" property in the emac node containing
>   * a number 1 or 2. New device-trees for EMAC capable platforms are thus
> --
> 2.55.0
>

