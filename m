Return-Path: <linuxppc-dev+bounces-21601-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A491CD4F54
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 16:31:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQZr619mNz304r;
	Thu, 28 May 2026 02:31:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c110::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779899478;
	cv=pass; b=Y2ah62aqH+MInth9vNih55NQZxXKcEGyb2hr3TMlMiUVEl5J4sl0F2jPxlgY9whU4oO6npbg3g3PnRj0VsEb9IGyN9f2O4/ynMpNm2F/kvy+bgf5mKdIZSiyk5dcTaXhMhV4xOfmJdbuYqSQ28KccOEwPiTb+AdG2OBn6wzKEvzWvMEyn9PWG+bjUCoUAAL93vkpQknmgwOO9HA4POqRBjCtIKfg5dELQdEp5+vAMHy9dB1QkeXDWg6fjOSw3L+OJFn9Iu6EByfiJGJuNarJg0YYZrrCFMbDBQkEfDK/vWU9gwt5eLDDKCaksulfu2hqUS9+reNYvZh/loi/DrbJMA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779899478; c=relaxed/relaxed;
	bh=h66h30DEw4uffY4clzY9K5aqRBD13uTYnqsxsw5M/+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nfT5Lo7CyKuBJb8FrrjHN1EekMwoIBZgpf+VP4t/LYZ4nyA/Uk5Qp5+UcNSDASpiwLgTzEvV06pu3M1Jc1A+GuMfqyvu50o/IfFx5J/Dvz8qqTXpxrcWS0wIJoQDOEbhf/WTt8DGm0hjoow6ASdWVZfsqAskG/G+RHC7dlzbpUfSlUk5F6n2VgQRv3WPXJyNKs0bmAGKv0k2UE/cfCH/p6WC1hBgUbfXZhLcHlaKox7OfkrbpaRQaM69LClx6f4gsgZDehAWhK2W2b3FMY+oMgMlhB7YbjW0bqPGWA4LdL53fZxM6bTNmIbuRX8vPRE0NIX485wO7nNz6DyKWicQPg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Co9fqwzE; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c110::1; helo=bn1pr04cu002.outbound.protection.outlook.com; envelope-from=kprateek.nayak@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Co9fqwzE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c110::1; helo=bn1pr04cu002.outbound.protection.outlook.com; envelope-from=kprateek.nayak@amd.com; receiver=lists.ozlabs.org)
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c110::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQZr31M3Sz303K
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2026 02:31:14 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SXgAmg7DAIqbSG6j2DIeU8dVhkqWpyMKC7uuqsv7w3+bzYeASBZU2Aq2fi5cd9/37y9NMpdUhXGa7nMFIcJsfpFgM2NO/9Fc/rPZ4WPiHEzRr+irSWTVnHX7flLucg6Oy2vCdIudXhoTPvIb0jGP6K0Uci6pQ7scSdyVr24pRtpRtXobWTWFZTexfakaZivR2XxVr1LbdWdtcVzMf/HMTj3LWlMFTndA5JcRXYjx8YOGAcre9cfwnxg8DtxymQ3UXxLpw0mphcAUHMw9ng/6l62897ek5xFKdy28vmmtds+hH/JYSllyna2ZP1EgoB0l+75ZrlwKUAJSOZt711c4Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h66h30DEw4uffY4clzY9K5aqRBD13uTYnqsxsw5M/+E=;
 b=rQTZGtc7AP19r8JGGWT2oeOxpTegLynh3xYJOARv+hWt7jCPLSBGIH1ziAnIC36xEiuFV++dKdR7vGBk9sTqeSKkACsU3Q7YNbAnVVcsbxQfrrj63bX8UpQ3dvrZG5k/CjTPWWCpe2dlcM3B9KX0xYWgoQGCeUCOodGyyLaBOlN09UWxTBJq8dVdM7Q36Fky+Ww5x0EWNDu5qUaK/UnQ1xBiFHKx8JSNED0eGVr0SNPV0D2XMem7wFDE8kqv5AVEqhjK/FpTlyC8JL/aYKBsZ81xaQ0GIpP4cLjL+e0JN7tUmmy1kLA3tPC4EPMCYporKkX+5sRADzPJQkOkbm65kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h66h30DEw4uffY4clzY9K5aqRBD13uTYnqsxsw5M/+E=;
 b=Co9fqwzEHVs178umA/o2UXa1KOjxrvx5hitvBfAkm7rQWTjFTPi5CPzOgwZl263asyU24MxIBhLPiQ0Du+BlEgaxjjjlrwcWsek+g8JoAkVBswBGfHmBjV+Qe1o1chmfdpj6mPOAVyx0BSJ2Q2DT3bLmm0hE9LqMvMmVM3EdrPY=
Received: from BY3PR05CA0050.namprd05.prod.outlook.com (2603:10b6:a03:39b::25)
 by MN2PR12MB4095.namprd12.prod.outlook.com (2603:10b6:208:1d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 16:30:42 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::2b) by BY3PR05CA0050.outlook.office365.com
 (2603:10b6:a03:39b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.3 via Frontend Transport; Wed, 27
 May 2026 16:30:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 16:30:41 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 11:30:41 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 11:30:41 -0500
Received: from [172.31.184.125] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 27 May 2026 11:30:37 -0500
Message-ID: <5e292187-35f1-4ba0-b146-8b1f2fb7f0cd@amd.com>
Date: Wed, 27 May 2026 22:00:31 +0530
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
To: Shrikanth Hegde <sshegde@linux.ibm.com>, Chen Yu <yu.c.chen@intel.com>
CC: <srikar@linux.ibm.com>, <venkat88@linux.ibm.com>, <maddy@linux.ibm.com>,
	<riteshh@linux.ibm.com>, <chleroy@kernel.org>, <tim.c.chen@linux.intel.com>,
	<peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-sched@vger.kernel.org>
References: <51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com>
 <ahUogeqIq5km7JSr@linux.ibm.com>
 <058664ab-0982-4c13-9d4b-caa2f7616b0f@amd.com>
 <20260526140856.139657-1-yu.c.chen@intel.com>
 <d45877d5-86f1-4581-b3e0-59ceb722de3a@linux.ibm.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <d45877d5-86f1-4581-b3e0-59ceb722de3a@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|MN2PR12MB4095:EE_
X-MS-Office365-Filtering-Correlation-Id: 0177c96d-691b-4a8c-2e48-08debc0d4b79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|7416014|376014|13003099007|22082099003|18002099003|56012099006|11063799006|4143699003|5023799004|3023799007;
X-Microsoft-Antispam-Message-Info:
	OQRJFyRZ1/bIe0O4dlqP5zgqsh00pr7STymww2FFso7JAaluiXrgn7/EIVNw+bbvUTscB/rg9UP3QQqR1v5BBZq9cqFMNDemNoUxahGSmIB3g2TRsDOxrXB0xKysi5JhzfKn1J5uAFacqa6hlwQi7+9pg/7rBJWJ8gA3habRHEytZMYn6dPYrNmhqfOP8Chj8r9PbX4HP3Pt0/TaOPKTYOSXSK7bgNM+3lVAVVUgiNhIE0vPzggGq9OgfkJeEj1kAmfRblD+39AEmKigZrBNc4Ie7+B8EIcXhugBOFuwGaETyBnWOV+X0s2qpBoNBi91GA07+5aLv9qiue1SI+BP+0WVjRb/fOLyB2iH2LYhoIbUJUEav204dxBJHNIrcC4HhNynT+p/zfpn7B7nZ90Pc5VSN/JmvbJ0mxgwf9J+qyf5sc8txYl/hghL+lZqOe/m/UHwGS5YvAn89n8SHvrMbfSkQXJymNmypoTZ3WJh647SfIMjM2kJ3X0E11cmoMMNhO6Dy4W4qjIYBCvxiuHhAVUAHcP0nFbJ4ZCXzQBSYWH81ONBOy6FKFSk7k5IwikqD3xRv8isLt5KBS/woX1crk0vQPXJonX4PnPnE6YA0yzzJcFRJTkLWDgII5bEWw+/H1JShHnrneuUd0WLAR1/9vuCDKgfGypNs4ya/DtWun+U4cIj74KUR+oCQvvTALIW
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(7416014)(376014)(13003099007)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(5023799004)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0dMq6SaEBy50x6JDunwFdJeFG4rNT53qEH+684s+rdmey2VR83O6cbrjR2ZDi3rAZBDTphPyGWv1UBQ1dgq7fryjT4BIOct3iuGMJRaibVbiXS2HfoPyptmXb4YtabbmM32K/Q3afGJzPXgCBC1eZteeKrt1eE8e0XiM3LwKEPyyWmhzIX33GMmABI/XakR/pYFoBI/9lvZX4Vcjjtvr6+TjV1+untbj69j3SFqNSSo4IxOMW6ojVcSkquoFDTBO8CD9pmPo0xp6ge9kR5owFC5yUUjeVoNt5YjrhJ0f6xCR7wZA6AgEfKldpXvm5Fea2moFHVx7dKTH8+/HlQcYmKgSe91QzSUGC7h7Go5mvD98TvTQjErISfuXsLcRh9g7bWLbaojnFxSUjAmPKXEwrsVPHSzK5qXjCLvJQ7F52lnrCfRKzP6AF8rANj+8bNkN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 16:30:41.9302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0177c96d-691b-4a8c-2e48-08debc0d4b79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4095

Hello Shrikanth,

On 5/27/2026 12:31 PM, Shrikanth Hegde wrote:
> Hi Chen, Prateek.
> 
> I got back to work today, sorry for delay.
> I am trying to go through the mails.
> Apologies in case i have missed any bits.
> 
> On 5/26/26 7:38 PM, Chen Yu wrote:
>> Hi Prateek,
>>
>> On Tue, 26 May 2026 11:23:59 +0530, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>>> Hello Srikar,
>>>
>>> On 5/26/2026 10:28 AM, Srikar Dronamraju wrote:
>>>> L2 Cache reported here is for SMT8 Core aka CACHE domain.
>>>
>>> Apart for the scheduler, nothing in tree currently cares about
>>> cpu_coregroup_mask() except for drivers/base/arch_topology.c but
>>> Power doesn't select GENERIC_ARCH_TOPOLOGY.
>>>
>>> Why can't Power have an internal mask for MC domain (tl_mc_mask) and
>>> the scheduler can use cpu_coregroup_mask() for the actual LLc? (The L2
>>> mask in this case.)
> 
> This seems wrong. there is no notion that coregroup_mask
> (MC domain) has to point at LLC domain.

It seems that only PowerPC is special at that. Only 3 architectures
override the default topology via set_sched_topology() - x86, and
s390 both still have SD_SHARE_LLC set for their MC domain, as is the
case with default_topology[] in topology.c with cpu_core_flags().

> For example, on Shared LPAR, there is no MC domain and LLC is at SMT core level.
> In that case coregroup_mask has point at SMT mask is wrong.

That is equivalent of MC degenerating onto the core domain right?
cpu_coregroup_mask() pointing to a core shouldn't be problematic
in that case.

> If we need a mask to point to the LLC mask which arch has to return, then we would
> need a new api say cpu_llc_mask ? that can point accordingly.
> 
> I don't like mixing MC domain and LLC into one bit.

The SCHED_CACHE bits assume cpu_coregroup_mask() points to the sd_llc
domain and uses the sched_cpu_activate() path to assign the llc_id
independent of partitions and sched domain bits.

That assumption holds true for everything except powerpc. Is there
anything aside from the scheduler bits that use the
cpu_coregroup_mask()? We can always keep a big fat comment on top that
reads it points to the sd_llc domain and it may not be the MC domain
on power.

>> I suppose what you suggested looks like below:

Hello Chenyu! Yes, this was pretty much what I had in mind! Thank you
for the patch.

>>
>> powerpc/smp: make cpu_coregroup_mask() return the LLC
>>
>> On pSeries shared LPARs(or coregroup_enabled is false on
>> Power9 and earlier) the hemisphere map is not allocated, so
>> build_sched_domains() dereferences a NULL cpumask and crashes.
>>
>> The generic scheduler expects cpu_coregroup_mask() to span the LLC.
>> On powerpc the LLC is the L2. Return cpu_l2_cache_mask() instead of
>> the hemisphere map. Use a coregroup_map() helper for the in-file
>> hemisphere users, and a powerpc_tl_mc_mask() wrapper for the MC
>> sched-domain level.
>>
>> Fixes: b5ea300a17e3 ("sched/cache: Make LLC id continuous")
>> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>> Suggested-by: K Prateek Nayak <kprateek.nayak@amd.com>
>> ---
>>   arch/powerpc/kernel/smp.c | 35 +++++++++++++++++++++++------------
>>   1 file changed, 23 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
>> --- a/arch/powerpc/kernel/smp.c
>> +++ b/arch/powerpc/kernel/smp.c
>> @@ -1040,11 +1040,22 @@ static const struct cpumask *tl_smallcore_smt_mask(struct sched_domain_topology_
>>   }
>>   #endif
>>   +static inline struct cpumask *coregroup_map(int cpu)
>> +{
>> +    return per_cpu(cpu_coregroup_map, cpu);
>> +}
>> +
>>   struct cpumask *cpu_coregroup_mask(int cpu)
>>   {
>> -    return per_cpu(cpu_coregroup_map, cpu);
>> +    return cpu_l2_cache_mask(cpu);
>> +}
> 
> This looks wrong to me too. In different hardware topologies
> there maybe distinction between coregroup and l2 mask.
> 
> Let me go through the code and see if there is better way.

The other option was to add an arch_llc_mask macro that can be
optionally defined on the arch/ side if the cpu_coregroup_mask()
doesn't point to the LLC
https://lore.kernel.org/lkml/8d14c844-b4a8-4af6-acab-2cfdd42225be@intel.com/

-- 
Thanks and Regards,
Prateek


