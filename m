Return-Path: <linuxppc-dev+bounces-24522-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1801EC44520
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 15:48:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3lL80NPCz2ySN;
	Tue, 21 Jul 2026 01:48:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c107::9" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784562527;
	cv=pass; b=LDOTAfc+kfU/Gf4TyESLbXKPGBP9PhKq+7rae8rRcMLUqgc+3KD/Qy+Qss5+QHoocOiLjxy/jMEyH5JlmfDReD8YGdXJ7fLmKAp0YQGCM0fe6LFdPW6c9b8IIg7mx3RRnrG4zQl6Ki7IGFwIIuIDsWDaslG+EG22YJCfM5+4dFQIQuCh/WI2OK52Fu91D4XU3Dgou2k7Xfj4yRG5pc6JzDgfc3g2HzPRKTLoM9fetnNDRdIPGysb78kWYqukkl7+M3haBMksX1F64IVQsGTaVDnb5PQqg2RjUPGCgliBMrPOcS9IMk9474u9RQdYP1gr+Z8vQq5BeXWu8C/m0RpRGA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784562527; c=relaxed/relaxed;
	bh=NXWQix8BioKNcotXXZv2fggd5bCWR9Hd+L4YgaXaE+Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iMwgvnrYe16YH3b9fI1VC/e3+DXIYXOh/OD1BAo7mKULTWALXa4hpcsPP3oFLckCnqClN/MsbDcSj6iQeOIQH0CSs+DZUbpItw+3++UJAq4l2mYrSeXNg3CSwS9e4Rrwk+OlQvmjQg03Al/LYKLa0FJw7F2h18+JM2oRZ5+D6Ho8Aa9v/CNa01nJG+B1jZ0S2mE/45aazwiNB25xqM8qPA1xhQFBezc+Jyhqn4Yv1F4Ggk7HQ1k1amCVcxgt7cpOH8IWMIedCzdCkAPw5jNEQe6X5cMWHvVz1Jj0ItVI8KddJ5oC/A1+SxQxpH/qen8wD07gjxLF0VRX50ie1R1M8A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SxbxOW3R; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c107::9; helo=ph7pr06cu001.outbound.protection.outlook.com; envelope-from=terry.bowman@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SxbxOW3R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c107::9; helo=ph7pr06cu001.outbound.protection.outlook.com; envelope-from=terry.bowman@amd.com; receiver=lists.ozlabs.org)
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azlp170100009.outbound.protection.outlook.com [IPv6:2a01:111:f403:c107::9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3lL53ny7z2xqJ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 01:48:44 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lEXToT3eArbzXSWDbyGTlBi5knZpGAhbyJyYISmULjI/g4MvECSEiWBqZ1pr6UfFHh8l8CQQwrmwytvChySGjBaAVbd1ar7t7oFSbqRE7MlMySFkPKXj7i7a6YceyWjUW0XBFclzn+A90a5Kq7B8Cx/qpMD3P0NldHvrrRkpW8hw99vD3e+x8X0rcmCwNg0XRbhMxA4hFnio6e5xXBCzHZYesHiPbkk875LNyaGCBr6m7POWhX7V8r16ivDRwm98BgUwPHm20W0+P+1D90wihsrPaxwK7EeQCjHieHnEwvdo30Y9mfIBs/q2MJDR5z5Fq7vQFBwubjf3pn1eddzCFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXWQix8BioKNcotXXZv2fggd5bCWR9Hd+L4YgaXaE+Y=;
 b=MeyjbqGEAuMQ/Ii2tEgGv3OqdSAfOiHB1V22kChkqENY/6o2rQ+2KKk5GBvQ1C45OvI3TY84EmodEleG3UmYtqzlB108Xg/SAjSLGr/6ASGy/Ga0sPJtea1t58cMDQdIqlFSdCjloUJLV1brAEHdoikMbbj8CkCgCxNkDZhH3sfUjk4ZMdl+Csb1nW0k3hGaMiB5xfcd8fx4WFMFkz5i0wXiJpwwnLXG21rQCDW7ErSc6yeQZRy3t5VxncXN4OOwtiW44gx0Q3Pclct3X+Tya+EKdlrAoDSob67329azNV5wwmhcqnP7nBnwyMdRyaboYSAHBtMhHupPiHSWlX+EJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXWQix8BioKNcotXXZv2fggd5bCWR9Hd+L4YgaXaE+Y=;
 b=SxbxOW3RqyqjveRwx1h8u9U1cAPyM4zD+RhyfQr9DstQS5riWflDOerFJWhrdqzkN69q/D85RKPyEO1dIoqP6+J4Ar3K2jQlHOuAvDmrtD4uVWtnV+wntSgzNmDdGfXManBuZrWsUZfqV0bnXZlZtrT1YO/NuzaZlR1t0hTSP4U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by SN7PR12MB8791.namprd12.prod.outlook.com (2603:10b6:806:32a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 15:48:12 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%3]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 15:48:12 +0000
Message-ID: <91e35807-9483-45f5-b4a8-0388aa48ff6f@amd.com>
Date: Mon, 20 Jul 2026 10:48:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 11/13] PCI: Cache PCI DSN into pci_dev->dsn during
 probe
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Len Brown <lenb@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Robert Richter <rrichter@amd.com>,
 linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Alejandro Lucero <alucerop@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Ankit Agrawal <ankita@nvidia.com>, Ard Biesheuvel <ardb@kernel.org>,
 Ben Cheatham <Benjamin.Cheatham@amd.com>, Borislav Petkov <bp@alien8.de>,
 Breno Leitao <leitao@debian.org>, Davidlohr Bueso <dave@stgolabs.net>,
 "Fabio M . De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Gregory Price <gourry@gourry.net>, Hanjun Guo <guohanjun@huawei.com>,
 Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Li Ming <ming.li@zohomail.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Oliver O'Halloran <oohall@gmail.com>, Shiju Jose <shiju.jose@huawei.com>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 Tony Luck <tony.luck@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
 <20260717222706.3540281-12-terry.bowman@amd.com> <alsk97jVqw9jbRdQ@wunner.de>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <alsk97jVqw9jbRdQ@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0075.namprd03.prod.outlook.com
 (2603:10b6:610:cc::20) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
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
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|SN7PR12MB8791:EE_
X-MS-Office365-Filtering-Correlation-Id: b0b00824-e49d-4fb4-22f7-08dee6764e42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	lOVDjwBGDwZham9wojp0oiSyMGBkKFFf7Qn0S3rNOPHTKdfzEOoHWuvKNgPe4YCY3xk22jFr/albX9jGMy18x5hYHXNv43Pw9toYzXZYC/Cnj+k0aWm0ilmLq4+dKVDfsnDvIgEHs+oC+03JUc7EAzWIcBypmMqSUx1iyuQ3T1e6d51PKkN1x7Ckxx1s3c/j9OPc0g7KlL1yFRZLxlt3rjiKUxBEM5Sw7CmelhaxkiYmINQTl1zhR6tDECEQJLpCNyQKq+dH88i0rievYkwxbQNXMZA15xA9hCB1N/tPaxvav6NV1HizP/3fya7RE5HUri/g6B520f3UsHjaDvKhIOHUV+xvyr7tHNURUgT1h9K2ttLw85hWYK4fPR5/qNPUgDJsUztBnQlc9FkpKOkD6stkb16pDLrcUipXIY21yQCTBa3FaNCQbaGT2+Q5F+qmjlq7irDQ+BBclG61ItjTdEtLz5pI19TmF4KoXiK9w7bMpFcb+DQgMGz7hvSTqdXYqbjJJHjDn1QnNKkaacxIiJHS0MkHob6njx/083CPtyUOgHhyhaabiqRgfr9QGmKY0wPzaoO92HjCzlqG2jRi3bdWGlmNTEAx6rcpEAETP+UHPgV2EKfZ8aY8izXXjK9yEc6T0vVVmb4SvlLRsGZH9OzPI28kvmPOR6dOnIA0FNk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aks4VGo3S1E0T0RMMzhqTFpST0RFb1JVZjNZSGxJeGR1VzU0Rk9jdTlXRURO?=
 =?utf-8?B?L2NzWUYrSmJtdzFzR0RCSjFUVzYwQm14azJEd1FZekpkZFd3SG8zNzBqVkpu?=
 =?utf-8?B?dnVSbEp4QW1na0VjYXY4bVBHL28rY2M0NTRLTU5WS2FmcmhQOTVZUDVmQ3pX?=
 =?utf-8?B?MEFaWnRzZzlDSm1MazdDN3lwRzdJaVQzWmxYSzlmU3VpTEtwNVdsRWw1RFZO?=
 =?utf-8?B?NmlGUG5IV2Fnak5OUXpXZ1JnUmFQUDRFRE5HTzY2d05TRzZ2UnExdjZXK2Uy?=
 =?utf-8?B?T2dLUGhYOVkyZmhqazFCTlBESW1GcjRLWnJ2ekdzTjZtSmh3dDRqZU5seXJP?=
 =?utf-8?B?bnpXQmJzZVdjQ0pjdVpBejBJWStXRjlUVFMxT1FTS3JQRmp1V0FxbXZQelc0?=
 =?utf-8?B?T2t4TDQxY0pMY3VmUG5GTWtxUTE5dDQzcHcraW1VTlhIUzVSM2JGZzdKYVp5?=
 =?utf-8?B?aTRnTWI4eG1NVmFRQlNUbGF6ekVpdGU3cmQ1aU1uZUNndG9pSVppZng4LzlL?=
 =?utf-8?B?N2lnMTl6Z29VelNFMzZDMlZUUWlmRGpJZFhYb2xuTkEwMEpuRm1sMHdzL1g5?=
 =?utf-8?B?OGR2Q1hrZE40aWd0RGVFdllrYnZlSWY3QmkySnZ0UU9PZnNZMzdWZFR5dngz?=
 =?utf-8?B?MmYwWmppRHh3NTc4YjB0a0hXdkZnRnNWZWtUY01xeGVYWndJVEZhaE5RQzNy?=
 =?utf-8?B?em5pT0JHRExFci9HbjdBaTdpb1pkbGZaUm1QZWhXVXNPOG1wcXRXeXhhTjJS?=
 =?utf-8?B?L0taQUZKZHo0Z3ZyZWxhRWEyS0hZVkpDaUYwWlQ1ejMzUGJMOHIxR2kyWTAv?=
 =?utf-8?B?TmtDU2l1MDVwYzc3SzJDdWFwR3RvZWgxMGJEazc1SkpqQUUwQmtXWk5hblpZ?=
 =?utf-8?B?T0g5bmR1UmhCTTRrL3VpSUpZQnpnTUx2M3YrNzZUbzgydFhRK1NSdHZyMDVL?=
 =?utf-8?B?aTlvZ0FiMWk2M1RSdmZlSDNJSzV1RDVlQVMvMFo3TFQvVUkzUTRLK2JZREN3?=
 =?utf-8?B?SE5neHJOZGdDQlBNWEdhUUxwQ2YvREpZTjFRVjlSaDBUMFNwWGdMc3ZZUy9N?=
 =?utf-8?B?M2ZlYStNUlkyV1ZaMmlzSHRleFFUeUw5MHFMK1h2cjJQMkF1ZVNEblIxMHg3?=
 =?utf-8?B?Z05aMFFZb1JwMkFzcER3bHFML2tuRlZ0MklEU3dXcjhFV0duVWdtdEVYM2Y3?=
 =?utf-8?B?OEpFdEpZaU1TdEZwR29SQ01OREpkajE1d1pORnFpN25oTzJWM0lGMm9yOFd2?=
 =?utf-8?B?TSszcWs4Z0hpU29lZk5OcDV3RENSdHA4cG01bXlEUytqUGQ5aFJmZkpmaDVz?=
 =?utf-8?B?cktpZFJzWFRORHZIMlB0YkhQdFRXRnBiV2FneWZWQ3FyWVBhNGVDVHJsdW4y?=
 =?utf-8?B?OFhZTDRpLzZoY0JwM0VIenIwMktaTm8rdzI0WDNmOXhDeS96blRXSVB4ZTh1?=
 =?utf-8?B?RUtObjRSME90NitZdi8xa1hpTGNWRm1MSmdXKzBYZlVDWVJVRVlscUFpclIz?=
 =?utf-8?B?VUIwQi9qdlkzbXhiWnloQTFFRm5XOE43WStuRW5tTm80T2FhTk5pdGdFODBh?=
 =?utf-8?B?VGFBN0xtN2VtMmEyUGY1K3dpR1dyc3lTaWFQYUljV21KVEdGZDJEczRicVpw?=
 =?utf-8?B?ZnY4OTU3SmpidTFvSnNaaGdjNE1xRms4QkJIcndRWUFsUmgrS0lkVlZVKy81?=
 =?utf-8?B?OE1uQnR1YlpETjNXWHJmbVoxRk9HdzBLMXhqVHZscmlLS3ZKOXcwQVMvWFBW?=
 =?utf-8?B?N3p0NktLV0NKeTNmMFY1RlFlc1pIQ0FoQlEvM0lCcFk2WEp1Q2ZkaGxkbkIz?=
 =?utf-8?B?ck5nTTFEdDkyQ1VYcDc0WTNlNFd4dXdRWk13Uzk2L1RYRndwNmdUWGc0cGoz?=
 =?utf-8?B?VXVJeTExdyt5MnVMRkZXZDk1WUV1VitibFA1ZXEwV2RYM1A1V0g3bU5NMmxo?=
 =?utf-8?B?Y0hERzdPUTRLellWRGRiY25MVkZNdytVWFdHaGZMaUpubUpDb2ZKOGN4dS8y?=
 =?utf-8?B?QWhNbnRlRnhOdlQ1Y1BhZUtJamZ1a0kyTmhROGRobHBZM0d0cU1Wd2dTNWpX?=
 =?utf-8?B?SFhoc0lqSGl1UWdyenZmQkl6Sm1WSlBhRjBzby95bk1WOS80cEFjMS91THUz?=
 =?utf-8?B?Vm5yMUQxM0xHVzh1b2xnanNtcGdGQSs4OUVhRDJvRG1CN1pBbUZGeG5Bb2Z4?=
 =?utf-8?B?UFgrR2dsRjhITU4vMjlpSUM3Y05oTkNjNVV0TEZ6WTRNS3ZSWHkyblBYUXBF?=
 =?utf-8?B?TXFiWWxEY3hHOE0wcDVReDJyY0IvYnprZysycFp4TFFHeHc1S2NVZEtkWnFP?=
 =?utf-8?Q?9dIZNGo9iBn8QehQ7d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b00824-e49d-4fb4-22f7-08dee6764e42
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 15:48:12.7950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+F7hXuoAQiT4qMyatV3I5daHvvQDK5bXF97E7ZH4ZriMaULL/hNQelM16mirfaczsz0O615dwaFYuoGu3Jdqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8791

On 7/18/2026 2:02 AM, Lukas Wunner wrote:
> On Fri, Jul 17, 2026 at 05:27:04PM -0500, Terry Bowman wrote:
>> Add a u64 dsn field to struct pci_dev and populate it from pci_get_dsn()
>> during pci_init_capabilities() at probe time via pci_dsn_init(). Only
>> write dev->dsn when the read succeeds. The zero initial value from
>> pci_dev allocation already represents 'no DSN available.'
> 
> The DSN is already cached on (natively handled) PCIe hotplug ports
> to detect device replacement during system sleep, see struct controller
> in drivers/pci/hotplug/pciehp.h.
> 
> Please remove that member from struct controller, remove the two
> assignments to the member in pciehp_configure_device() and pcie_init()
> and change the comparison in pciehp_device_replaced() to use the new
> member in struct pci_dev.  You can do this either as part of this patch
> or in a separate patch.
> 
> Thanks,
> 
> Lukas

Hi Lukas,

Thanks for reviewing. Is this the changes you want?

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index debc79b0adfb2..12ec050d8a0fb 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -90,7 +90,6 @@ extern int pciehp_poll_time;
  */
 struct controller {
        struct pcie_device *pcie;
-       u64 dsn;
 
        u32 slot_cap;                           /* capabilities and quirks */
        unsigned int inband_presence_disabled:1;
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 4c62140a3cb44..c07957e0b37a8 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -587,7 +587,7 @@ bool pciehp_device_replaced(struct controller *ctrl)
             reg != (pdev->subsystem_vendor | (pdev->subsystem_device << 16))))
                return true;
 
-       if (pci_get_dsn(pdev) != ctrl->dsn)
+       if (pci_get_dsn(pdev) != pdev->dsn)
                return true;
 
        return false;
@@ -1086,8 +1086,6 @@ struct controller *pcie_init(struct pcie_device *dev)
        }
 
        pdev = pci_get_slot(subordinate, PCI_DEVFN(0, 0));
-       if (pdev)
-               ctrl->dsn = pci_get_dsn(pdev);
        pci_dev_put(pdev);
 
        return ctrl;
diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index 65e50bee1a8c0..065e1f7c9a7bd 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -73,7 +73,6 @@ int pciehp_configure_device(struct controller *ctrl)
        down_read_nested(&ctrl->reset_lock, ctrl->depth);
 
        dev = pci_get_slot(parent, PCI_DEVFN(0, 0));
-       ctrl->dsn = pci_get_dsn(dev);
        pci_dev_put(dev);
 
  out:

-Terry

