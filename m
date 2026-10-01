Return-Path: <linuxppc-dev+bounces-28696-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B534BCA5FCE
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 21:00:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwkpZ4pycz30DY;
	Fri, 02 Oct 2026 07:00:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790888454;
	cv=pass; b=B/M1HdH0dmxRNtlPIwJJ9GbfDPaMjntD6q6tvqADnSpOzr7IRTb/HG/18RVmJtvnoq+cLmE4R9G8zeXyLJIHIJvhSk5lB0ygXT7zEHa0o8JSzg/CBMBqAyldBz26ysMfr4sNqvVAaNkK/2QVxb+iDjdzowK07o1IacbGoeN0rYg+QJMPsxd0VH6C9CtVRmCifcBswR9Arp7+9MwrlroTmebymlgdXzBM6+8GDhw60w1dcISRnGGAjQ1d5WdqhPWL5Gmwg8CuGdcnRTSfJDmzLQfgmlsvDRhnL+2IlmrUfjEw/hgohcJVwS3LuZXpeTeihI7Bb0qr0IqTloLgZphNqA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790888454; c=relaxed/relaxed;
	bh=onzjOvIGbpGlYemqKkGFWBlCa4whu8fPjNO/X6toQB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nssHxMqe7gfmMLS5Gwv47E9tstQjOu2OdjT0FN+/vrX2J+a5GiDOtPdVPtpZjNWcmUWqG8+hxSQc4kt/+SXXN/92Q1lMs/QwtgRFkIPmzZQlGefeRR2Afr2HMKSMu+/26QpI2Q7R8YvYInyrfSs3G29+ouiiaT9hkySUaVN3Xj0bRRNXkt6ASAykTntTWC/rbsapfAOze16vR94G31h48uM44n2sypOdlHa/5Q0MewIxa9sYEkv+YKbjP1ZPzuEzK8O9ZGC4V276tIhFnlsFftP7ChrObg1+6y/WRJT/oValJGObpEd5737hK2vq1EwDrsmlMaTAgSgt8aXZsoP5iw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=fMZZ2Ndw; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=fMZZ2Ndw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwkpX6RZgz308H
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 07:00:52 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQoY3PnZFNluEATw4RiGS5kaQngOkfu9onPbBY1pSbo8ismrye9WAJEDbywiZKB8UbjI5QncLxxbbSfPfW7p5OL8hh6RLy8JNIgOuC32Gid5QVh1pVZjhjbXU+5UGavDx6nwiBUOaH17PR5tM6xcXCJS2kf6mmpezoawGqAIdm+lasMMW4abvuVZqW1sfGEKqNc60pmuakac6kZg5JBhIlscBs7BCtttiPBL+kxtMRFSWryVxfHdQqkN9qDqvjiR3ZZf+L7mEvZliYOUtB14wMEzfUL/PVGsvYvs9MPY9PcdbHkB/NTTlfyK/elyLwErh5vdgdkYClpMDJyG1t/JBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onzjOvIGbpGlYemqKkGFWBlCa4whu8fPjNO/X6toQB8=;
 b=eeLqr66TgvDjW+yh9FjFii7IR68zMLtN5D//hMvhf6BVq9RAByLdD8DQVvXdEz/Oc8/ShaCTelkVIUpoSVdH28BaWindbFgeDJnEMU9ioFYANSSQQwara6JLZgHIl+v4aNRCGt8X1+7iqDpMp3VYx5Gdosw3158bz9+uptH/Gh1ooy2mdWPbntaY15rctveguF4sKzbTq3UuZyOEPIoFhIMfRT7r60pUjq5WAgpVNogeeaAybc0sBbhVIHbNsVmiSITqApOiM8EWfSaEW0oCUy9/ApQr5bm2viy5xk1umXkwAoQZY3lLZZPP4mgUVvGPcGoyX0zEASC6GqNyNLMlDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onzjOvIGbpGlYemqKkGFWBlCa4whu8fPjNO/X6toQB8=;
 b=fMZZ2NdwDz5ahlyqtyxhcr4w5nmJfFySjcPuS/JTorzRYY1ffhUrBTCJvCO9z+7V6GnpIsCPMJneCNGWmMYoI2HK5CK4iJanW1yfTeAhNZ7iIyWnNFJPiVUbpOFO58VOcYIFSOAHaA07gFVbQAWBVGPwZGNN+4y18WXCfnJyhGa8N+fnQCfBuspG6BCIDH9WjMdngyjHhRFfJI4AApVoXUmN+Ta/sL7hPIZTObnRj9kAz4f7M8SC90ANZZ6lZWkrspp77vj9NdI8/gwBtC8AqQsdLpYJn30HyV11B6zQhtCveHtCYNqT1PyQHYByP68b5vMbG4qBAs+r+Zg4Ay6Edg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA1PR04MB10794.eurprd04.prod.outlook.com (2603:10a6:102:482::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 21:00:25 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 21:00:24 +0000
Date: Thu, 1 Oct 2026 17:00:14 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Julian Braha <julianbraha@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, Frank.Li@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, kernel-janitors@vger.kernel.org,
	linusw@kernel.org, kees@kernel.org, colin.i.king@gmail.com,
	rosenp@gmail.com, joao@joaoff.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v3] powerpc: remove dead 440SP code
Message-ID: <ar7J3nl2pNW-B7AO@lizhi-Precision-Tower-5810>
References: <20260901152341.1219343-1-julianbraha@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901152341.1219343-1-julianbraha@gmail.com>
X-ClientProxiedBy: PH8PR02CA0028.namprd02.prod.outlook.com
 (2603:10b6:510:2da::29) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA1PR04MB10794:EE_
X-MS-Office365-Filtering-Correlation-Id: f00c93c1-9420-4f63-e874-08df1fff037e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|23010399003|366016|376014|7416014|10067099003|56012099006|6133799003|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ARF1Aaju9b2LR5L6PJKmLX4B4Ko1e9T60RsYx62FZvJxIfXqRVQ3ntJh8nHT/EXH0t6Am3M++Avvkb2yJGKBGuS2fxEOmjyov6pkdNjfR6ao86c56VhoWaexl0SFRJooXDHpydX98d/5i8LbsRKbFWIlQj9eA2z+yK2ilQZqCJvz0OZKES/dCw4anW1bcBEINJURNvPaeVXS5Qp0D9KK6RE4E5+JGOM0m74rLQYMwsWkGiiFjAR/O3GknANk/bTmMXmGGhZ3Iuo6IVtk82J04IVmTybz/S353kz4nljS0EFfyuGG4PyuegBbHOYZHiPytHS2rvGu63XoBehPgoP2l20JjNi04a3mgdKSAeKO09PKISHeWXQb0g1FhswysGrLNO6/ltl6tK5gqfSKP89qTXiz5DYCB7tH6p/jh6ISBamIIKw2ijA/WI39U+EXICpywpdwTkpcy9sYlLe337nNylBAW9gj5/JOCcphay4OzrJk8y8UC4pvL2m0JrAoeMTHPl7q3ov8nM8Lf7MxawcQrhcr8WTR23a6xO1MUVL7SW3R7ym0kSTP0Y0Ax+kmKsQuN/uSs0TefI+Tf3RBptqiHWmMHl63ip4iM2psOHErJFKUv79wjw6W+yH5xFpJoE/vD+EyOuni7ZC+b58NWgEB17p6LlPzJqJ+rOtonmwWJfU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(23010399003)(366016)(376014)(7416014)(10067099003)(56012099006)(6133799003)(11063799006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OG/+i1S5/xFn1cN+2RYBNfe+bRaDSTLYZN4FcdCV94tyNYVuGDGRba2uu74B?=
 =?us-ascii?Q?WBgjvy8jp0T72ZbAAKVwVX/HOJeYZAdLrH0RHhhgPOhNC60ibYpHVYNzN2Dt?=
 =?us-ascii?Q?1nR3uVqlMgLayaX35QCP0CxA7xKfUSVDGZG0YfmoUICVNgi3ZoRFBF2XfzdQ?=
 =?us-ascii?Q?ugwYxNCs9qW5N+XjZkboi9yNI0OUeL0Szm+MGf16OipyL7/6z6dsohpqQqLS?=
 =?us-ascii?Q?XdIDiQUU3toDtgDDyjyy2EmegLTysb0aCu4cKsHCLSb9N6oqqcr4Y0y7BJlH?=
 =?us-ascii?Q?IAGFI7W/RBtEP3P5MMNE2RhcdLxRtxgqxi23wBONFHdbwcQO0fbUQVF/MOfQ?=
 =?us-ascii?Q?V194unjEjqZg8s8zXj4tagcXCvFYa/fTPW3WmXAXcPdanOs2LNqzOn/rSLGJ?=
 =?us-ascii?Q?XjQ1to4demhFJ/aE2PsHdi5QPH+u6yWYFrhATiZYiv/SQTUkak49RHWQ1sVn?=
 =?us-ascii?Q?0T88ppbNkQwBpQEO5NMtR6HkzgggP9XVzLaf9oxgSGYpUq2JANx0oA6YorVv?=
 =?us-ascii?Q?zBIk8azkydNIGPqycvoCRh4Kp99sGdFUS0GGcdWiIHZdW3Iq475WLoUEAzQC?=
 =?us-ascii?Q?V07NyoNMUKqgLBAh/5cvggoXGyXSjIgWhFWnarSDE+61RfvX1JLZv9jgDOcr?=
 =?us-ascii?Q?p05fvD5I2P4dqNzHSr84P8RuX4j80IVmlNdIwHFz6kktDNUfbOcQJz7aBJW3?=
 =?us-ascii?Q?RkVQO9O1Kivvb3CSlNM8lTtVMW+g/xLB4x+A9Q9/Hy263Onw4DaPDt8sNmdF?=
 =?us-ascii?Q?pWI5S63MwQiPGDvNeSDGX68XFzlJEje9B1FisquW41pO+ZQjn4fAKPznn81M?=
 =?us-ascii?Q?ieXkO3Pg88haC7Et5fS2+kbREv5yjV/lZLc5dvNCndmy/YV/C88odzHdUpeS?=
 =?us-ascii?Q?Oxblwls2MDz2UCr9oFlD4iXBXrG93syjFLE8AwgaADGvlqkA0KJrYeOIfNOd?=
 =?us-ascii?Q?WDU+w2++qCQqd3pd4eCcksw3qo3GuSHDWY2T5pRvn0ZwLK3niwE+aMzt00w3?=
 =?us-ascii?Q?Zvv6JmGl2aIFgKY9B+pMYWAiqNUVphlxIF8K5ZjHiy2zp5XAm5OGPnIMhOxA?=
 =?us-ascii?Q?pqhpLDOAmxjQPQxgsK7LDEgmBjtRRQX+QVEgkIAesagGQKyr1vbu+I8dFx2Z?=
 =?us-ascii?Q?ou97p4mT8DsKTKSYg/5L9fAQXqlLgOREk3Hy8Ct6yPSxl0zm1nZ51y4fAPO+?=
 =?us-ascii?Q?ZlySsu9J8bha9Ez0B2s/MBRgn4H/xz3AeAgZNJN8zWWmtPZArDYc44o/VBDt?=
 =?us-ascii?Q?4YPD1gMtThDNLWhCOTfemA0OZvapq0pcdaWPSRzudBTw/1nBWw8aahq9JUy+?=
 =?us-ascii?Q?9XsoSB0iDyvUSXZu0lAO/P/NhIqixEgSZB0OFU/DQ1TKN52r4t3sy69ddwxd?=
 =?us-ascii?Q?ycw3LR2uHqHQ4lspzgfm82CMYktOB+PF9kgzReZt12fJAywZSq05w7Re+sy0?=
 =?us-ascii?Q?GHeCi0KcLDjYExBQTxcnNvcoHkbRk/96zXhr4aB0bmsigjm6AGPDAvXW/Igs?=
 =?us-ascii?Q?k8sg+L3s7PiCklcCezXI3q0tqHIdXd8dqzdTsTXdAbT56SPpO3bsqzwK1/gG?=
 =?us-ascii?Q?h83fI588s1M2ftOHAmsdyVFsp9Q6JzUcpuZ8LTK9bpdnZegTSrWuGbF5nG0T?=
 =?us-ascii?Q?pPBGOgSMKJDMnbVAh+E6zvzmVcA3hwIOLs7T1nehjr85RRlPQlwQ2lyISnfH?=
 =?us-ascii?Q?9q03sP0jug+hePX20cxV/cPh2NE+zWiTT+wzOc70oft2jM95S7sk3TolrFZ2?=
 =?us-ascii?Q?EovF06dF2Y1f7HYJkDx9v9YEFCtS86SEphpA4L6jHuZqWyT/RGiS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f00c93c1-9420-4f63-e874-08df1fff037e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 21:00:24.7989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uAWrmtjfNB5trss2Wnr1aIQhbl0ynjxnWOBzfTOHM5muUJGE8g9yAqSDx4Kt+E5RrbYpAOh4CAagDe8A5Q7uJNLZPRaAUpJ6WXAfFf0KWduMAalGnspmISRes+ROKqJr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10794

On Tue, Sep 01, 2026 at 04:23:41PM +0100, Julian Braha wrote:
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

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes since v2:
> - cleaned up preprocessor condition
>
> Link to v2:
> https://lore.kernel.org/all/20260901150645.1199097-1-julianbraha@gmail.com/
>
> Changes since v1:
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
> +#ifdef CONFIG_440SPe
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

