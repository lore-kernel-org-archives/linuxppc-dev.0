Return-Path: <linuxppc-dev+bounces-21497-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C358CD5BB4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 05:54:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPhly4QXpz2y8t;
	Tue, 26 May 2026 15:54:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip="2a01:111:f403:c10d::1"
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779774878;
	cv=fail; b=L9Uds+JLDLN/aiXwyLEqlL3nZQDkdp03viZ/UrcnR0sFZ7db+hIrvNsNIZk2vQHVeoTLfFrdOclx/XNQAg1qRxHIlNj8diMZ60PBvSLsKUxx5roYpCqEDa8Ov/8RCU1QmMFERfofKGBL3RiFlr11EZLd3isDzsjxRS8zyviV6Yn+tkI2nquX5QeB5lR2xSFg9yLifdM6Kvb3zyWknG87r9rzfwJmeQJZ9xopwS6p09zxfIF0kyFlowDRtzo2rRMHouAAKDvTAcCROtE+4VlEOmmzaLvCpOsgTxXCsHAbK096K6lo/bpb4N7mcCvsKvZ3xkduWxrDkUF0ryHjj4juMQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779774878; c=relaxed/relaxed;
	bh=IaqBVgyGbOrjmmGv1Zd84r6b/ItQGuK9ZaC0K+dPPm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ITQqREnBZ+kUIbk0PtQrYeFkJOFU1Hv2Ro0vLq3CmTnRCe4pZefxV9r1/bCHEYaVTywty1qklfSo5ALMBVPmhsXGvpdYTfeRTi4Ys5gDppCXgCFS6RUhnKR98sZgnzMJoz2AP8JLPGJpPXAboUkiUkOih/D3KtevX7iWOPxVgxx5vEKU6D+BXuCQykrWYRvYXi4iGwEguD+f7lkPfTJAUvfn/85nOsQ2Szs/Bos+bGs76U+MLYVOArDdOWcBMfcV3jzqujYXjVkN9xnKEjdrgsCZgh++eSAe8Wswt8K5T4/dJUXKV4TEnYHFxVR74ymsz0S76qMDz8JTw/98LwFlmw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=er+2DsoK; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c10d::1; helo=sn4pr2101cu001.outbound.protection.outlook.com; envelope-from=kprateek.nayak@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=er+2DsoK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c10d::1; helo=sn4pr2101cu001.outbound.protection.outlook.com; envelope-from=kprateek.nayak@amd.com; receiver=lists.ozlabs.org)
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazlp170120001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c10d::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPhlx053Bz2xjQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 15:54:36 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U+Oe/CrqF7YgEIB7eS2evhaRZA/elZgNUgHlACBPwOiR8Nx7CDLoe7Rt8j84D4W6uuut0gkwv0BaAXTR4z5J0ujoFeG3Ga2SZWB7v83xvpQCqyZdWUGhr93miBfYjKvY0Oalb5yPM3y5D8jv4F3vTxWoqYf2WJ1CCDw0BPcI66iQxJM3OipWJX1/lKshgjSJnqciW0Vz7f6KlVHZYX9eDUkzBCQrkGnKkPNTfZUa5V6yBJXV/HrSQP5D0PbNQH5K7JjLrEaF/7hB9sc1XvcsYPwstd/u8WEzKb/9bch/wIF1g3JFl44M1JAUDR35spTFafBKPKfTaH0Qh3+1nGGR9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaqBVgyGbOrjmmGv1Zd84r6b/ItQGuK9ZaC0K+dPPm0=;
 b=I39u+3tw5kGqYmsYMXQ8//qpH+k/7Hu+McudQPuJMf9IVFtKrLAN1zE793gwjWLAFYLj5rS1hEvPmAWA15fEoNBwBfy40hXx/fsby0EINDTeMuQjY7ABCFifBEVvkQAQLlY/4UDSd4OvkZwJ2XSAtnqLrIhXVuPkE4Qv8tiJZ8eJDgVFMWDouhmfqzEdPk6RX7oACdw0I6VlEdjUiJbflewGSE77mWSSXCDLIFFqwRkE1mobBFY5xdhvsp1b/5PPODMaDqY9zrY3qu6tgjCgEMkE9t2pEScTcybWYV3Docd3SrFeksgg76LdeASd5OmqX0giFwOwdnlvmv3a7f7X/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaqBVgyGbOrjmmGv1Zd84r6b/ItQGuK9ZaC0K+dPPm0=;
 b=er+2DsoKow5wQJCzBDnyNo6YhDx1F7xdr66UbnZWKwJ/zqPDf4c5/X3mIJXo/E8l7gDxVW4SP4Yd1R7p2bqhdM+GlRp3liPwc4mq2U2EDAAQFxy5mEjcmgJCP2JdHnaEpbhw0pPvA6PCkFfjnw+GT8qEvaOgvtnzZUH9HkrleNY=
Received: from BN9PR03CA0257.namprd03.prod.outlook.com (2603:10b6:408:ff::22)
 by DS0PR12MB8366.namprd12.prod.outlook.com (2603:10b6:8:f9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 05:54:06 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:408:ff:cafe::a1) by BN9PR03CA0257.outlook.office365.com
 (2603:10b6:408:ff::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 05:54:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Tue, 26 May 2026 05:54:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Tue, 26 May
 2026 00:54:04 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 May
 2026 00:54:03 -0500
Received: from [10.136.47.136] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 26 May 2026 00:54:00 -0500
Message-ID: <058664ab-0982-4c13-9d4b-caa2f7616b0f@amd.com>
Date: Tue, 26 May 2026 11:23:59 +0530
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
To: Srikar Dronamraju <srikar@linux.ibm.com>, "Chen, Yu C"
	<yu.c.chen@intel.com>
CC: Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Madhavan Srinivasan
	<maddy@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, "Ritesh
 Harjani" <riteshh@linux.ibm.com>, "Christophe Leroy (CS GROUP)"
	<chleroy@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linuxppc-dev
	<linuxppc-dev@lists.ozlabs.org>, <linux-sched@vger.kernel.org>,
	<tim.c.chen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>
References: <51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com>
 <bca40921-d351-4439-ae6a-9e5294f23e2e@intel.com>
 <ahUQE-AgvOAQV_mI@linux.ibm.com>
 <a0e3f4f4-03b6-4bb1-881f-06bf5abca1a3@intel.com>
 <ahUogeqIq5km7JSr@linux.ibm.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ahUogeqIq5km7JSr@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|DS0PR12MB8366:EE_
X-MS-Office365-Filtering-Correlation-Id: 03623f61-d632-482a-01ac-08debaeb328b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|7416014|1800799024|82310400026|18002099003|56012099003|22082099003|11063799006|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info:
	cYiw29zH2nD56juJXmS76oERzF/wcAugCPfdn/J4fSOaIO1fODVXw3tzE95sBlBaIUkJUne3a6QmdHj8jCXhl3YrkllNCXs9PWqJPERn39+wRdglufITS6tcwt38aaBx1qtoKlBAN+MzBjxeo3p7u2VVD16BK/sObLpghRGRPVdJsyC2g6ZskEoVjfxmooyaIupb8zjv6M7cYMBPJpKJPFE/CT++bBfHRqrEALvwMI/v/71DAL/dQGJROTl4UfllcPaJOWtBmEcozEyVL8tS+gDS/3qmYJ8xYic6hvt/V/K160+CYaS70OTHXKpWNQbr4qLeUBoFXnJ9qiBLDmwkEBAD4Yuq3EzhZ9wWesVmzw8mi07eIy5CnpPEjfT/nYEFpRVTgNFbTxLTMf3iWl07Yr3cy4Icm2665xljxUd054W5CTfS89kFNwSdZZy9fSzjICRN9QvyUuG94QvfI/5WK5rcmVplgdHEiGysCVftYmBckJ7m4yFUaz0nYDaeYULN2NVThaEnMyuuIAJSQ9jwSUfyCF3Dt/Ki1eR/BneXjnrnbJn76c7RYM6PkgBvLdRhRd1/TfXxlnc/hJZbczqpNobxkfcUZif+kaDl4/rmcgSvnSIwTkC3QvYY2FGMvzAfHHLjgOIsr0L1/LU8o/zOQTTcGvpCwKGRw4+MiHz9aj2G0HUbS1txGC03fV5YKruVrhhDL3VTXj+rVst3wicdXpFptH/m4EF9EQ7x8x2It5c=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(7416014)(1800799024)(82310400026)(18002099003)(56012099003)(22082099003)(11063799006)(5023799004)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tqrz8m8Emp9OKg6YrRQCqBxl6MQOStwIrBHKd9lP0J5JOPz3vXyT9ZuEdeAbrdVtxJOc+KtV3eMb1nI63Ko18Bjmu+w7nvg6zG6hnvEPNrF4Jv++Q2D0Js2Hlgv+KUI43UFQlP93qybBgC9VY8fcW8eQ+sWEayiakGDLhcobC2h109cQR5F7Gx5Y9uKnSKZAvQxSbY0OVDeCqmJYXJgEdTB2koTNsubmsMLyb61NF/Au2+xWqIORp3yAcPWdTXsSRN94zAorrlCnbPQ4J1PXNdlV65dB16w2gYuJ7oVWUy5vUnRCvPBMZJ+DBkZ/5V1DAdfMw+TQqDJQ3KG3GEeqMISObAmkpKIrjlwTRcwTUIu8izahtxsjPSQy5EZ/d/UgfaJk9RP2vWHCLrg5wh6jJadrXb6x9QFU/HfJPOnzjQYi0uCYhCr6ZwM6vhOys32J
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 05:54:06.0819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03623f61-d632-482a-01ac-08debaeb328b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8366

Hello Srikar,

On 5/26/2026 10:28 AM, Srikar Dronamraju wrote:
> L2 Cache reported here is for SMT8 Core aka CACHE domain.

Apart for the scheduler, nothing in tree currently cares about
cpu_coregroup_mask() except for drivers/base/arch_topology.c but
Power doesn't select GENERIC_ARCH_TOPOLOGY.

Why can't Power have an internal mask for MC domain (tl_mc_mask) and
the scheduler can use cpu_coregroup_mask() for the actual LLc? (The L2
mask in this case.)

Power anyways adds its own topology via set_sched_topology() so the
default_topology from kernel/sched/topology.c remains unused.

...

> Shouldnt cache-aware scheduling be worried about cpuset partitions too.
> If a cpuset has subset of LLC cores, then we should Scheduler assume it can
> control complete LLC?

Well, the scheduling takes care of partitions and the cache aware
scheduling bits take care of looking at the full system perspective
for stats aggregation and pointing to a particular LLc.

We don't compare llc_id across cpusets so we keeping one unique llc_id
per H/W LLC instance is feasible and it enables us to keep llc_id space
limited for optimizing cache-aware scheduling.

Now if we have threads of same process across partitions, we'll
still aggregate the utilization numbers across the full LLC but
the load balancers at individual partitions will make a call on
the aggregation.

-- 
Thanks and Regards,
Prateek


