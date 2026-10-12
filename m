Return-Path: <linuxppc-dev+bounces-29204-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65300CA9ECF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 02:21:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j31RW5zFLz2yDc;
	Mon, 12 Oct 2026 13:21:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c112::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791771671;
	cv=pass; b=NZjPRG5Xta1MwJbG+BrfhvFZFgghOH68CB9Vr1uN4Jij9ePrNs/L2JCu/q/ORVkwVe6Ry+YymciBd5yDQ4uh8w5vZjkDgLDr8nk51B514xTv8wfv6VhN3KxRgPK//z3iPX3PekMh/nfLCB2qkuroc0C5l93IT0MNEUVRh4vwR3r32IPrJ5TbCOEgbqqNaD6OmvVNf0ZWkNgCAc4CULFYdyeyVLYB1CIaSVx+uH6Wxo5DQ3643Gwa2jL5+7Pgl983LE98beM3Nb/6poWh+9l0Yj4g/hFnI37g/uibpMve0hv9r+ULXtNDMqNGAw9K3TKLIy3scqb+4jJ933ustDq9bQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791771671; c=relaxed/relaxed;
	bh=/IS2zb749TnbguDxAdOqQAlQ2h/ai1/MCN8zs0xG4Ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ri81oU1trewMgf63EfricHqWDk1deLDTmKoodDhZiCQB2XZ18l4PiP5qur5eA13DghmdA2RAO4Qag3nzOTReCMrJOmkXmZXD9f0QmRzgNJWBdIzWbKvPwyP2jb3fEfM1sG2IbsFnjeUAct7XJJ3h4NWgwGa/YU4aF2XnJO0WKb8a35gsE60cGrd16C9zcv++3OY0WSxLzp4DU6vclAfjNbpveXZySwwFtO0gFPXFLKe+1HiaJryCxGqBSa+l/Ty4T940GH/yantRryCFctiTkcWQC7VbnmskaJTjTipR8Uy4txnuDM3U2KBm8i4pYjAE19fU58mrbXBog2cw4hun5A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gCIKESSe; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c112::7; helo=cy3pr05cu001.outbound.protection.outlook.com; envelope-from=kprateek.nayak@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gCIKESSe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c112::7; helo=cy3pr05cu001.outbound.protection.outlook.com; envelope-from=kprateek.nayak@amd.com; receiver=lists.ozlabs.org)
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c112::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j31RV4nD0z2xyk
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 13:21:10 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OjiJyE4oBixCXBJ71q8nNpUWxhVVNK+6xA5GIvCry1OMIo3vP5wainuOoAqWDL5oFWSc5MkLU2o4/jknaLksw3ZsrzulUpuRNOYhnNEFBlZLCMjHed+nq+O26Jhvd3uXuWXGmaURZB0Ko55TuMGzi8GT4macjlUz+e01asvkiM3+naKGEZOQpaKIweqFb7NuGIp5uSNmO3dlK4VbdMgP6BI0udYDTBXk8xcUR89UaoDJ8UfGda5UVVEMig9AIpvo0s3H4qbnkVBuC/Sb+XRg/po5KZ3cmR86YFphDIXCV/q/PccfhvQW/QeyCVK/DwrhW1Z/em06fHZ6ftkYHbfPLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IS2zb749TnbguDxAdOqQAlQ2h/ai1/MCN8zs0xG4Ik=;
 b=X/0EHToI0G/FLLuo0ljSg/wVAiK1ouu4oUZ2+LP9Has07oKKnvbmEvDwcppgfBALPhC428sfux6ymN1R0aLMvxyBJlZTi7LzOz6uGrx2RYlEndzWOAAO6KMWklPFEjutxl61iXweWSEt/esMi/wmKpEuKcmr0w/S7g8fqnDU198tr+F3GDqdAOUk+8/BIG4X8nAjjV17qQ+tyDik1Kq9s4//4Mm2FKueC19bvXsF2LdJ9EJSCKhcJnxfOxnjAMkFUTquRJIMR+AwJ9Nay89NpJp0PhGOs6rsYwL6U1lySx6vsoAleLLUm/ojEk+pPs56hcCKOTo72YSoHqGddxikbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IS2zb749TnbguDxAdOqQAlQ2h/ai1/MCN8zs0xG4Ik=;
 b=gCIKESSeYvgY6mGz/Bih7CY32wcmGzhpD/MfJC0eZwhGNAiFnzzJTEHmCQ6UXnheo4wMJWn1g2swm+q144gYOljDLkKXv4jIdfHpe7mHwFaPvt9ZAIp+GPExkWTWk3mbWS4qJq63B0q8cGwRYxzNZ5xpHejgGMU7lP76dqtM3WA=
Received: from CY8P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:930:6b::10)
 by IA0PR12MB7603.namprd12.prod.outlook.com (2603:10b6:208:439::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Mon, 12 Oct
 2026 02:20:44 +0000
Received: from CY5PEPF00000E77.namprd02.prod.outlook.com
 (2603:10b6:930:6b:cafe::e) by CY8P222CA0019.outlook.office365.com
 (2603:10b6:930:6b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon,
 12 Oct 2026 02:20:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY5PEPF00000E77.mail.protection.outlook.com (10.167.247.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 12 Oct 2026 02:20:44 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 11 Oct
 2026 21:20:38 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 11 Oct
 2026 21:20:38 -0500
Received: from [10.136.45.168] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Sun, 11 Oct 2026 21:20:31 -0500
Message-ID: <91a1bbf9-0409-408f-bedf-a5414be4d1a2@amd.com>
Date: Mon, 12 Oct 2026 07:50:25 +0530
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
Subject: Re: [RFC PATCH v3 07/13] s390/topology: Initialize sbm topology
 during topology_init_early()
To: Mete Durlu <meted@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>,
	Chen Yu <yu.c.chen@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>, "Ingo
 Molnar" <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, "Vincent
 Guittot" <vincent.guittot@linaro.org>, Andrew Morton
	<akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	<linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-mips@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<driver-core@lists.linux.dev>, Heiko Carstens <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Shrikanth Hegde
	<sshegde@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
References: <20261001192849.74788-1-kprateek.nayak@amd.com>
 <20261001192849.74788-8-kprateek.nayak@amd.com>
 <bd5201d9-19bb-410e-8954-6c53a5aeb753@linux.ibm.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <bd5201d9-19bb-410e-8954-6c53a5aeb753@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E77:EE_|IA0PR12MB7603:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d2a92ea-c84a-42ab-ce6c-08df28076b5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|7416014|36860700016|1800799024|10067099003|22082099003|18002099003|921020|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	HmtDj/4B8qxEAX9mScbcfsTQ6fArSAJ+XYsmMiTGqQNBipuMlodvZLBMycfn3Fzpy6TD0N09DZHautRaf6dsvVFvxeGh9LqcwNCbXTYX544Y+irK6CMObDa+B49nS0BQRiLuqQ25K77wlTQuc3Dd8uFsNGjlG0Y9OZPSGzprgWIS5dPgg3ZAgj6EfjapHf96KZvl7InKiy+QiPVeklrR3r72mJ+Ki5kigB5/F6zQodgwXkGAmaCgQ6KKCnRm/JgPwBznOeB08lw+jF80lKxIC56K9YXTAS4tmXkceTZIm9V7ZLKerKMs7mBv3EbIMZyHhMQMKD/ZdhGxDaAWVEo3scWYsSpSkNJGXzp9f2lcqzU3esQf2n98bI3Ysh3Nhgvd9otyPWs9n4YrFxQF0/GVQAGagdmr4eyV3qovvuJLLqUSYq/cSDPuLFg3XBpATmhEDf/oDFyy9v/iclQkHlMxPoXFWrngDvC5dEDCYhVRkUYo+544ekvcsjjb1n/i9fj1rydGrdgkJOPY0N17vSGWNEE3BC38oktpIg+InD0Zg7D+AhJDaDt0TunxAMKX/aKj0ttOkaTagHoDahmhZ7jF2CtEYFvJ22mYAGa22EjgC79obbqkMEkZDABCksTFqBGocE9IBiSVGTEnkvy0qW7W2IYLhm8bcHOFWBmw5HAHimE+yrN+d/HZrliCa5eC9y+2wLEZZEH+7uGyB5iLXORslvxw7PpMyZ3vjsE1OYyDjNjMaaRresoOf5GzeVxYlM1T
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(7416014)(36860700016)(1800799024)(10067099003)(22082099003)(18002099003)(921020)(11063799006)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tbryS9J7ew9vgONnMPsBMAyt9IqFcxoStBzef1+0CeylkZNpnw/dOhMHh6hWJULl5Ks0+Fx7OaVtBrCnlIuRrxSqsP6M73p8UpiagR6M3iIxjr/9em/qvsEKj9nlDeCtN5MujxambkTrN4r3e80N5oqMqCrmzRTUeGASCcK3OsKsKmQ2PyKZ41DREb/Ytb1me/elKhDvKP5RpKdMwwnX2/xyHb/7nyGwUjnqVjq7NvvNr54l92ajdKL04HC06DpxLhW8zgfEUcx8fTsm2m25T/+FiPFVWoadLPe52H1EsPOKsDFNHS02q+AXu7zkhkOBACWrKN1UKlSjzXEXMZj+SBUCYd74xNpCwhBRvAxCSCy6m2+EJpKu0ehSOs4BZHTbgtZdqFj6LY5UniUlA0eyOiqPgZJVM5JYNl7WYXKIyOlzTx4dRfY8RKadDSjIH8Fz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 02:20:44.0010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2a92ea-c84a-42ab-ce6c-08df28076b5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY5PEPF00000E77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7603

Hello Mete,

On 10/7/2026 3:49 PM, Mete Durlu wrote:
> On 01/10/2026 21:28, K Prateek Nayak wrote:
>> When the topology mode is TOPOLOGY_MODE_HW, topology_init_early()
>> already parses the set of socket present on the system.
>>
>> Use the socket_info to configure the sparsebitmask (sbm) properties for
>> the system - namely the number of sockets and maximum threads in a
>> socket instance.
>>
>> arch_sbm_cpu_instance_id() traverses all socket instances to find
>> a matching CPU which is not optimal but instance ID is only checked
>> when the CPU is coming online. Since this is a rare event, the
>> inefficiency is tolerable.
>>
>> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
>> ---
>> Build tested with LKP's s390 randconfig with QEMU cmdline:
>>
>>    qemu-system-s390x \
>>    -cpu max \
>>    -smp 2 \
>>    -m 2048 \
>>    -kernel ./arch/s390/boot/vmlinux  \
>>    -append "console=ttyAMA0 earlycon ignore_loglevel log_buf_len=10M print_fatal_signals=1 LOGLEVEL=8 sched_debug" \
>>    -nographic
>>
>> Note: Since ctop needs KVM acceleration to emulate TOPOLOGY_MODE_HW, the
>> actual spasemask setting is only build tested at the moment.
>>
>> XXX: Any way around this using cross-compile and QEMU?
>> ---
>>   arch/s390/kernel/topology.c | 52 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 52 insertions(+)
>>
>> diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
>> index 1377c6f3f670..80dc51f5ce6f 100644
>> --- a/arch/s390/kernel/topology.c
>> +++ b/arch/s390/kernel/topology.c
>> @@ -20,6 +20,7 @@
>>   #include <linux/init.h>
>>   #include <linux/slab.h>
>>   #include <linux/cpu.h>
>> +#include <linux/sbm.h>
>>   #include <linux/smp.h>
>>   #include <linux/mm.h>
>>   #include <linux/nodemask.h>
>> @@ -561,6 +562,55 @@ static int __init detect_polarization(union topology_entry *tle)
>>       return tl_core->pp != POLARIZATION_HRZ;
>>   }
> 
> topology_init_early() is called once during early boot and never again.
> Considering that s390's topology can change during runtime this
> implementation won't work as sbm won't be able to adapt.
> On s390 max_threads_per_instance can change during runtime.
> 
> Like sashiko pointed out, this approach also does not consider
> any newly added cpus.
> 
> IMHO, there is a slight redesign required so that smb_set_topology()
> and smb_init() can be called each time a topology rebuild is necessary.

So based on my limited understanding, doesn't store_topology() populate
the mask for the entire system on s390? Are you saying that can change
or that stsi() may return a partial topology for only the online CPUs?

Since s390 default enables hotplug, I couldn't easily grep the hotplug
bits so please forgive if I missed something.

-- 
Thanks and Regards,
Prateek


