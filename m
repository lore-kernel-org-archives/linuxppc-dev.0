Return-Path: <linuxppc-dev+bounces-21479-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A61CD5BB1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2026 16:17:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPLd10hhwz2xfB;
	Tue, 26 May 2026 02:17:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip="2a01:111:f403:c111::5"
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779725845;
	cv=fail; b=SSdQnFVi4YzU1Lef/IxbW5Tj73oMUfUB0W3di+HHi6HRvvH9t7Z+z6wcxY6nLE7SUcQtS9dpvlYvgxxs4fpeALmCW9DFz1FysKc2jsJNyjUGkSXh8X7PHHJ+XxURkO/M5J5bJe63jHmFQRNdvDH3cIZZutEyLKHAkKjWU9iDwkW42jZR6YKTKlaAxr6l2XHfMrfFGg2KzkazAVb4Cwr/0HUeiTdmNnP+5CUUEfKDlsyotwAgErCV2st5k+e7rlSLOYXniJNh8pLyIUnujNH3XGxNm+7Nly/A0IVsp2wTEOsTda59IISwc360b0vLYEJwzcXpPrUarL1C/C0YCQYZww==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779725845; c=relaxed/relaxed;
	bh=LukzbtDsbbLjv3BKzXw2nLQaypYXFySwvhK2vzz99kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Zey9hGkP9slr7kPvkhoRE2u6+g1hwIXyoLUYi7Z6XCtIcbMrcNxbmeWulEnH9ocuzEqyEJ3xOI1dl//ANNIOJ22rELn/LfxyFZucgMALkW3Xe0wuRwK+dPp7//Yo7TLR0Xh4cvzSJhYX+cF/5qomP3hCoG3IIQ29Ux7oPttQW3Yw/YN0aPkOWr5CfC7jg2OKJCi4fRMX9Hl4+hmKd/BnQRZLuXSoibvn+4VwNZzttMbjZf+yM+IC7mvU+BfMlZo8Gdtq+OZpIOMNTrms4UmjTA7BOPn31gWmMbKGGymxdRYYg5Cs/Vmbkp4g2te0+oplJ3bYLhXFsQfuB/f3WZH2og==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FL7rU08S; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c111::5; helo=dm1pr04cu001.outbound.protection.outlook.com; envelope-from=kprateek.nayak@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FL7rU08S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c111::5; helo=dm1pr04cu001.outbound.protection.outlook.com; envelope-from=kprateek.nayak@amd.com; receiver=lists.ozlabs.org)
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazlp170100005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c111::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPLcz2dGSz2xbN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 02:17:22 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQ2S5Yj/xy9ObMMzGo/d1aaEV90rq+y/Dq6EfI0UQ2PVdEJuPgNUJj3TiPDnmTjJk12AleZc0uSoBAMUJfs+aOOTSQY/rO5LZ5MrgTxbF1XIEuie2tk8nsLjSzjf984S+NEGmyXhEsJxpSN9r1BWaDFS7tWQGrizrLDAudUuVdqrWq4aNzWzn9yuU5OMHTd8K1u0el21h5lY1DMGZhdLMF5PvlVcjJohr24LjTTm5rmrss1U///KnhqnKSvSKZy3QCpOVru5wHj20aTltIqm08HVLmHymeGdhj8rElkvmdVDSRqMGAYmk/fgZHWWOeiyNar+z9F9jqgMFBUmFexaSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LukzbtDsbbLjv3BKzXw2nLQaypYXFySwvhK2vzz99kw=;
 b=Hs9VJmai4xN1I9Y5H/EEPcNmKvwrC3nIzPUcWkQpkeFr3lXT6JbiTwxFQ/c+vC14Tzz99umxBpAf61ncqrH/vHw3gRQG8jralOUpGVuwHRsf22HPUj5cxdLddYUtJY/hM6hXfiUn3X5RfcLh5rrk9NKrd/bmh4/zvDASvtH5ebNVwBoBqKwtLKU564mQ/lZNAk8/8u+7q5LViYqU/ck542de/RNYRAfK/srZGfReomVqj7OU9pKwxdGMzvxyFUrzJhBLvl9VGCcxCsrH2gLzvaEn/2fNruoQILA6lH4PuiEtzlY9KdohHNwqgkwkvAoVhmInuuVbOVOcjk0Dx1OOkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LukzbtDsbbLjv3BKzXw2nLQaypYXFySwvhK2vzz99kw=;
 b=FL7rU08SMDUnX2jp7yT6kqu5veODXVbIxDSxVNNXfvGoZwlc+GPKt3D6RS1J6uHsz33M+AUFpY0tQEJQr6ohsRbhJPx2c3uCtlD3FX1TbcT90r8woN5Yfdy+YoE3ck9fQStEoHIRIErXYZrfZg8/1QpjHKQEks74RSOsT5oNKLE=
Received: from MN2PR15CA0048.namprd15.prod.outlook.com (2603:10b6:208:237::17)
 by PH0PR12MB8031.namprd12.prod.outlook.com (2603:10b6:510:28e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 16:16:56 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::f) by MN2PR15CA0048.outlook.office365.com
 (2603:10b6:208:237::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Mon, 25
 May 2026 16:16:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Mon, 25 May 2026 16:16:54 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 25 May
 2026 11:16:54 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 25 May
 2026 09:16:53 -0700
Received: from [172.31.184.125] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 25 May 2026 11:16:50 -0500
Message-ID: <75179ee2-ec20-4757-8631-79b1f304c366@amd.com>
Date: Mon, 25 May 2026 21:46:43 +0530
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
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] sched/cache: "Make LLC id continuous" causes NULL cpumask
 dereference in build_sched_domains on POWER9
To: "Chen, Yu C" <yu.c.chen@intel.com>, Venkat Rao Bagalkote
	<venkat88@linux.ibm.com>
CC: Madhavan Srinivasan <maddy@linux.ibm.com>, Shrikanth Hegde
	<sshegde@linux.ibm.com>, Ritesh Harjani <riteshh@linux.ibm.com>, "Christophe
 Leroy (CS GROUP)" <chleroy@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, <linux-sched@vger.kernel.org>,
	<tim.c.chen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>
References: <51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com>
 <bca40921-d351-4439-ae6a-9e5294f23e2e@intel.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <bca40921-d351-4439-ae6a-9e5294f23e2e@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|PH0PR12MB8031:EE_
X-MS-Office365-Filtering-Correlation-Id: ce61fa15-b974-40b3-9d8e-08deba79099e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|7416014|82310400026|22082099003|18002099003|56012099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	MnBnkggU+Ad0Z/FgYzsKtNk7SD/n8FBDHLCME61OqOana/vIS7poo3TDAXJxDSft72E6lzfB5/vNWvhzmDUeW0W6XhVJ08aCDWCErIX22+g8pXC52kNITcAP0mWG2XnfMeIgUf/EqJxqyiqffcfv/A02nGWA6zrkE8Np/xz63ITpikVf3IdXvEz7C9cMOV71KwIjco7OqQoUpU7hz4AH+4uOax0EcyDz0r74JrFQNIBjriYbbRqSZPkiZVwXwTWyN4LxOpJTw703JrFIIm/c/5C85450na+iEQ8+apRIg3NzHSZ1IlPUEZgWqS0yDIsx+yr1jUftefzcM6qUKQOHzB+auNSTynNtaLpZuhdhDrx49VrlP4IgLwwCwMvlBlzLLMnmpAo1X8lpib5/IyZRthySWCzyv3flBWx9OFjTbKsYCktFDxLvWSf0nLO4t6KCElvu6/fWVipfbbhuOHPVTaVaTF0rseuM5jkrLnbwystHtNUe9+V+prIAN0TQIzGdGIrzHMU0GK+hxsicaLMD3NrB1j8qMsSllTianogXUbtTyHNdBu8TGv/3uXWWHpuonaIA+UVtmxFAEDhytjleyyirIu308tj0Db/9vizGfuBB0ABJjBfwYrrAYOs6sEVjm8acu9BtN4nhwTI4cpAiuYq2i3fbQB3OG4UqFxRT8F0x+6HjQyDzxQrLXW6da2W4t5cM4Zo6JjGOozcykJVSf8Jh6FdtbZ0av5ht2IEGSoA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(7416014)(82310400026)(22082099003)(18002099003)(56012099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LLFp0hnZxkIpw3KpXXGQF/P+eqbZClfJGsYGMcs7KQEb01rD+q2ueJqpxTj7WNRlxmRC+qj3nqlprTr50gW7OXXyXpOqyAh/McNzVqxLrx33kKyXD4+fwoA9YlOblolPAj+qdL8/VbPwzu8RnSXHxb1N5O5opK4F0x5yYDARiKyNht2GMn82LmL3p8KwF5MJwxl5hJoOgpd+Dnr1uwvegiU1tzA1my8fx7FeFE1iwOFWhHfMTj4Sr0iilIe2bnsXsxwDMYOcvgUQS2cWA1sdvlVey/IsKaFCj/vOymJNTnz9NBhNqBEKBwaRJK3HvoYSe6m1oEj1QROgLdxwJ530ZHJdjJ8lOa9GvxpsuR3H9eDDCJHZdXgQk9L102c7s7xHemGUep3JvVttPqHY0LhJ/TvWSvX2/P9ycjPewFVBa/sowqog/zTZ7uZznZKS5yXN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 16:16:54.7963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce61fa15-b974-40b3-9d8e-08deba79099e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8031

Hello Chenyu, Venkat,

On 5/25/2026 9:05 PM, Chen, Yu C wrote:
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 3467f86fd78f..cf6c2e4190ab 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -1042,11 +1042,6 @@ static const struct cpumask *tl_smallcore_smt_mask(struct sched_domain_topology_
>  }
>  #endif
> 
> -struct cpumask *cpu_coregroup_mask(int cpu)
> -{
> -       return per_cpu(cpu_coregroup_map, cpu);
> -}
> -
>  static bool has_coregroup_support(void)
>  {
>         /* Coregroup identification not available on shared systems */
> @@ -1056,6 +1051,14 @@ static bool has_coregroup_support(void)
>         return coregroup_enabled;
>  }
> 
> +struct cpumask *cpu_coregroup_mask(int cpu)
> +{
> +       if (!has_coregroup_support())
> +               return cpu_l2_cache_mask(cpu);
> +> +       return per_cpu(cpu_coregroup_map, cpu);

Interestingly, on powerpc, the MC domain doesn't have SD_SHARE_LLC flag
set but I believe there is still some benefit of keeping the tasks on
the same hemisphere?

If we are actually aiming for LLC, I think cpu_l2_cache_mask() is the
right cpumask for all cases since tl_cache_mask() also returns that
and the l2_cache_mask is set in all cases covered by update_mask_by_l2()
in the same file.

If consolidation on hemisphere is beneficial, then the above diff
looks correct.

Note: For has_coregroup_support(), with the above fix, the scheduler
side llc_id will now be based on MC domain's span which seems wrong
since it doesn't have SD_SHARE_LLC flag and might lead to other
behavioral changes now.

> +}
> +
>  static int __init init_big_cores(void)
>  {
>         int cpu;

-- 
Thanks and Regards,
Prateek


