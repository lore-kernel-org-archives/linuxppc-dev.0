Return-Path: <linuxppc-dev+bounces-24746-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 996B7C531CC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 18:28:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5fkf5jyQz2ygm;
	Fri, 24 Jul 2026 04:28:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c110::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784831290;
	cv=pass; b=RoBo10FFyp02gq+yoaJ0jCSxsdwWM/UxG+Ot3iN8ycOyApiLvq+6A65aVnOuG6j9uvODj7S4qQGIQ19MnKlSLkOzYVRjNLUER2kGRvunAREhEGaL4m9PkIbHX3tkC30kfBHkFjIgTk/+Dm5yb6oRQJJrg6Od7Zkt76RdHiNF0rkIs2E1Z5PdA0yE4XoRgs1P2uhKXkhGL8KF8BhlJsj0KSZhJ/0QzcjMzXyIKE8Oc/GeTdcpH1yxDnjqxy174YDg9PTrzkKkMJbXqSBQgphIB4DHACVTIWj9Bp03Flq2MOtWfCCHi+dXEBonn80OlWhfv2j5SZISWtEngJo+7mbuCA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784831290; c=relaxed/relaxed;
	bh=KQtEv5Pq1bdkvyzlUy0uZR/e+i3zIV3SHuAdyPjd7oI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D2bTyJqwvVJZ3W5o9Ff98QHbLDy9IK/KoDB87+XXoE4QEl2a8jjPCOpw13ppBWxnsxBCCNRMk0p1hqgIJqbm/+9EDOgdF60yn688eUoCJkAB1gvMGiUVEII7yWQe8a8Wye+nyO45PgcTr3YxFBJckSllvtcghN3iOlMjZUFlZ2SftiwAwIY5i5Fkk+alhc3ixOerAAQsdhKFRup2CETfYl7t/fZzugZpu1XFlw73BhuSC2myvBh5DX6w3ov8a6n4fj1z6VLlL0vmXNxcRkBTw84uuUeqITXiY+7VDDN5MI5IqgGwg/Bt34V/NkDW8W7lkvMA6xv0Zg3pdMRyqayd1Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bdGqSuYa; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c110::1; helo=bn1pr04cu002.outbound.protection.outlook.com; envelope-from=terry.bowman@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bdGqSuYa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c110::1; helo=bn1pr04cu002.outbound.protection.outlook.com; envelope-from=terry.bowman@amd.com; receiver=lists.ozlabs.org)
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c110::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5fkb5tVXz2xyj
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2026 04:28:06 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VKiugXLySoA4VH/kTrAt3QFcCB9lHP7hHcew10BAB+UqI64F13rcS7cwSB5qyd643T9Z3/XtzMG9KqsGoqlUUtYVTY+skr+bH7QLxkLzGEYqFUZOgnCG/G7sNTOZ4a5m6XWf9BqkF7kg7D3JHGmLIwC1oHWeY+XPVdCDGaiy0Ysc7aZJuWrMXjlyjcq5S3wQKaJIeU5ApSIGw25Fv5MgfZDW3wkqDxX9nZVffJuER+r9rHGyD9y3JAHAaqIYxLm6nVnb0XB4w2G2c57j3utkcsXwbiXA6wT1WdJ7bGTjlecV+xwRkiBe2muPamvtjNVueeK+8LK7dSRzIEEhTVmhpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQtEv5Pq1bdkvyzlUy0uZR/e+i3zIV3SHuAdyPjd7oI=;
 b=xW0UAvd620gJnJMNCpX8m+hkp/nvlrf4qUNKrzYbuAdTp/pqmMW5wAgkoT05esAMhxPtXZJ0JFvGW2v0V4dZ1s7kcS0e3jCrmQsClDfzTe5e+4xeiC8lM+SHAdZbWdF25R6Ipj5nuPU+pa8rty3ZjnRMCVIQZRuyaGErtLbz/UGxmxcSdWwSnV0Q3Lxt9Rto7H2EZusmL/Lx+HnZCs1jz/lrj5YFJWRPjqfyDehV7efSG9YbdLIWX4SdDndMcLS4DJRuGFltwt3jmA0eDM2cZlEvdFi/LyVfVBTenI4k4lE6Z/Pa+/h1h8pL5jXWomu6cZBqz3KE2LNqQIV8CZv+Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQtEv5Pq1bdkvyzlUy0uZR/e+i3zIV3SHuAdyPjd7oI=;
 b=bdGqSuYakr/cgUkMLqrBF16cR38D+nzhdGmIzsjP1uSsPSkx7h98zj7jc1QbL+goKDg+sx5pTWeeUiXuZ6dDOrHRn2LY+MsVN+y8OO/nTQg7xhSNKnWdzJ/fzhPP9Z6IX/LQcsfiHqXQkbm2GclGqkwVW6zahLR0iIs2nvpwQU8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by DS0PR12MB9038.namprd12.prod.outlook.com (2603:10b6:8:f2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 18:27:34 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%5]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 18:27:34 +0000
Message-ID: <f4504410-b69c-4808-8939-a429f9251eaf@amd.com>
Date: Thu, 23 Jul 2026 13:27:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 05/13] PCI/AER: Introduce AER-CXL protocol error kfifo
To: Richard Cheng <icheng@nvidia.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Len Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Robert Richter <rrichter@amd.com>, linux-acpi@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Alejandro Lucero <alucerop@amd.com>,
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
 Ashok Raj <ashok.raj@oss.qualcomm.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org
References: <20260717222706.3540281-1-terry.bowman@amd.com>
 <20260717222706.3540281-6-terry.bowman@amd.com>
 <20260720234106.27e7857d@jic23-huawei> <amGpjXNJbiJX5HTg@MWDK4CY14F>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <amGpjXNJbiJX5HTg@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::11) To CH8PR12MB9766.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|DS0PR12MB9038:EE_
X-MS-Office365-Filtering-Correlation-Id: cb99633f-c7a0-4811-ea9f-08dee8e810bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|11063799006|22082099003|56012099006|4143699003|10067099003|6133799003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info:
	WrA/fHMAwMmKD2M0bvSkMEqMMrj8LaHpNcu5lOsi0PQEXiVbIMoLW1hfK4fS+b8Gc6Y5OIh9SuGVHqsSZ4HyGth4RSE0P1Nnq6ly0ofWsA8m8eJqttVkp7KNBLmPG+KjOToYK8PoEHJK5xni1rKkcDxi53NQkiZbZOvCcikSa6WhZXSLUdPhX3R6LZsYonSzhcaOLBsN2Z+m6dLyuhYudgrEtczCQHJw7i2hLd+iGH1rQkLjXrqmEGqIoM6UuOsTCx4keRK/U97J1jLPbhl/gYOpS6EMilGFKQCJXm2to4qoB3vBZFHsPcle1wbLAdAT9XciSJmTkCRD3z9sN7UcnO04gsubvK3YUMcVQTgt3FKECQ2nNKC1g9Nc0P2oo7jfeLyKFtMfFmUZ8UIbnIOan+RhWWVtrYyYbLdWWB+apKIDBCqCRXy22ak77sTCYSYCmaiw1OpMpSQPyBXnq5rxal/wD/BbiIq3APMuJi5gM5/Re3btrxAdaVKrTq1P/xBItZkFueo3h4uW+QqX8VQnEAaEVrRQOy+OyUZe8FweBA7z/euZOJc08XVAlpbuUZUDrOiHI97DBaL6U+8esI1U2wQFxi9e3aIVdBDBm3kxhRhU8x4TllIrYPqxW/GcCcwVwiv2yStcUIj7F5oAtEyqhqMgsalgQVB4go/lx6lc6kE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(11063799006)(22082099003)(56012099006)(4143699003)(10067099003)(6133799003)(3023799007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUpGSTdsTWxzdEE3Y1V5UkhDUEQ0VDcxSm1GNlFITE03enFVQTgyaUFpQzl5?=
 =?utf-8?B?K0luNnhQVytHRDQweUdUdVRKZys4aS80NG5Od0ZxeUt2N0JjbWZJTmdkeVZV?=
 =?utf-8?B?SXc2SllYWDdBQnVXd2RNT0twWkI3S2tZSjhFZWZ0RVphdkZ1NDgxMWZCdnlU?=
 =?utf-8?B?QWNYdUJYQjM0aUgzeWZRUkkxanNKUVQ3NGxON0l1UFFtRHh6ZExwM3k5Q1Y5?=
 =?utf-8?B?aUtaMWd2YmlwYllzelYrTjRCRGhnWmRTaHV4U2w5SnhoQlVvY0kvZjd3SFd1?=
 =?utf-8?B?bnpDZXYzQjBncFMvdnZYNFVxYW16WlczYUJId2hrY2pjZnhCOGFWaExDR05p?=
 =?utf-8?B?S3BoR3VoTjZBTStBVG1BanBjTGsrQWR6N2dYQklZeUVENkp6U01UTllIZlor?=
 =?utf-8?B?L3kwSnUyK2xCV3lFYXYwT1VNVnlLTXNjdm05SDBBVytrdmRlZnNscis1TVM2?=
 =?utf-8?B?NmhpNDhNSDM4cmpIWEhsQmwwRVNtRWsydVRSZDA2Q0lqaGp0WnRITVl1NHk4?=
 =?utf-8?B?WWRPTkxiU01RbFE2NmxwdEltSkJPc1MxeHI3Qi9jaXRQM1cxdjZVY3NYTGhm?=
 =?utf-8?B?M3dVVzRNc1RxRGQyWlJRVERBOVhLQVNrTU50ckRSK1ZGZEdkV2ZqMDZvSStW?=
 =?utf-8?B?ekdwNmRWVDZaTVZOMnMrQjk5UmJNMi8wazVUN2k0SFp4d3Jod3RSTHc3c0to?=
 =?utf-8?B?akNuTHE4dzBDclpoTENhcmpJNkZMZ1VQbEl3MVNueDkva2FReUZiOTI0MzJW?=
 =?utf-8?B?b3pqSXdSWGlNNTVZbTNndWU2Z0Erb21JcDRGRzRDRGg5M1MxNmczZXNUZW1S?=
 =?utf-8?B?VE9FZW02MTRka2dXZmFsQWlUUUt0bEhDU3QyenByQTk0cXlzek8vTkoxY1pQ?=
 =?utf-8?B?NkJjSWR6RGFibWVMdHpRazJpVlJCTThBdEdoSC85R2svSmNSRTkxOUNZeGxB?=
 =?utf-8?B?amZLcHJLZEl4RmxOSjdRREM0ZU1mbU0wYXpmb3FpekFKM29PRlRDbHEyR3FJ?=
 =?utf-8?B?T0RkcS9YL0RKcnZ5NGswU1hITDFnblNTNlEySWhSNDhiUGUvczA5c1JvVDNM?=
 =?utf-8?B?VHFMRkNGOFl5N3QwUGxrUlJFU2F6akd3MjkwNEZKVnpUQlFYLzJoZDM2MFNl?=
 =?utf-8?B?SFl6dnZxOVV1N1ErV09hL2t2UlJMT1gvRC9zaU5rN1FJUndUZG5BWXpUSFFE?=
 =?utf-8?B?elZ4bW1sTEJ4WVcxUS8wQ2xGazJXUzYyc1JxSUhBRXdHMjNjaUMwdERiSExY?=
 =?utf-8?B?a0VOMGUrQ3RlcUtoZUxYdUxhd2FkRU9zYVNsQTRrbVhlV1NiQjVEZFpuWXpR?=
 =?utf-8?B?cjJhVDdMejFrbEcwdC9MQXk2VmEwTFJSdzUyUnhpL1E1M1JRWTkwWUFiTTZm?=
 =?utf-8?B?MDVhQTExc0JtcXc0SkxjTDROcjI5QUVGZFVmNzBUekpoUEhlZ0svVS9MekxC?=
 =?utf-8?B?UnRXYXdRVFF0Rk5RZGlrekd5Sk16ait5OFo2bVNpamlMcDJPS0VsNmU4SmhM?=
 =?utf-8?B?b0ZIRzZma0NnSnVsSG1oRnVNQkJaZExDaVNyTEJQVzBKK2tnMjhFWC9Qa090?=
 =?utf-8?B?S2NrNVRPZmxsL1RwdXNlaFRWVXUxTE44RERpQWdXRXBTeGdhTEJvT00wc0xD?=
 =?utf-8?B?NUlNYTFaNE93Z0daOW1oSGJEWG44TEkrSlF5WDdVclB2Zk1VMFpHL2t6cDFZ?=
 =?utf-8?B?WWtLeVNyenMzMzNzMlI5RmxURHhVdGRJSnREc3FhNndNeEhuUzVsQ1ZLbDdD?=
 =?utf-8?B?MlZvaXk5VUZqcFNTS2pLalZJL3liOUdvY2RQYjd5a2c0RTVRVGNhOE91ZGpk?=
 =?utf-8?B?WG1jV2dTNnFUL3U1eGVCeWtaN01uODVha0YrUGpRN1V6Tys0cGljaUdjNitw?=
 =?utf-8?B?UDZzblhMbmxYNmRHeXpmeXRISWU4SHkzamhRQ3FaMVYwVytPVUt0MXh1dVJ4?=
 =?utf-8?B?Unl2WmVmcDRXdVRhMmVTc0VvKzUvV3BDd24zTFlySDZHc3FkVFMxQ2huZlBo?=
 =?utf-8?B?YVB1VEdNMklta2dLaTllOGd5blg3dWNxaUZNUWtnNGx4VnloT2VoMVYxTEVT?=
 =?utf-8?B?Sm1OMmhlUXk2V3BpVEJ6MElqZlpROGZwNkM0djMycW5BY054dU5FbWJuajA2?=
 =?utf-8?B?RW9oVERpNHBSeTVUS0gxUGxaV0xidTFXL3R1ZENYdHhyNVZTNDJ5NFZnT0Nm?=
 =?utf-8?B?VS8xbGNrUk1CWi9IN1pnd25Wa1ZLOGV2Q2d1YWpJaENMVW9wcnRnNzJRY0lp?=
 =?utf-8?B?amplNURnUnBIQzhBQWZDQncyemdHN2dUWW5OOU5mTXRoKzRENFB2Rmt3cFo0?=
 =?utf-8?Q?gVceH/YMezBeIQwrjY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb99633f-c7a0-4811-ea9f-08dee8e810bf
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 18:27:34.5858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lUMfZ/6aN9q+SC4GxrItAyQffZ8dum7k73lLK53qClPO2S/PX9m+IaKP2w+mVbd9/XQPaCC1HhnMuE0dOJu2TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9038

On 7/23/2026 12:46 AM, Richard Cheng wrote:
> On Mon, Jul 20, 2026 at 11:41:06PM +0800, Jonathan Cameron wrote:
>> On Fri, 17 Jul 2026 17:26:58 -0500
>> Terry Bowman <terry.bowman@amd.com> wrote:
>>
>> Hi Terry.
>>
>> This is a rather length patch description.  Might be worth
>> a parse to see if key details can be covered in something that folk
>> are more likely to read!
>>
>>> CXL VH RAS handling requires a path for the AER driver to hand off
>>> CXL protocol errors to cxl_core for logging and recovery before PCIe
>>> AER recovery tears down the device. Add
>>> drivers/pci/pcie/aer_cxl_vh.c to implement this handoff via a kfifo-backed
>>> work item.
>>>
>>> Introduce is_aer_internal_error() to identify CXL protocol errors
>>> from AER internal error status bits across both correctable and
>>> uncorrectable severities.
>>
>> Already existed. Just in a different location. 
>>
>>>
>>> Introduce is_cxl_error() to gate the VH kfifo path.
>>
>> Feels like to much detail to me given not really anything to say
>> about it other than the obvious.
>>
>>>
>>> Introduce struct cxl_proto_err_work_data to carry the error source
>>> PCI device and severity through the kfifo. Encapsulate the kfifo,
>>> per-producer spinlock, registration rwsem, and work pointer in struct
>>> cxl_proto_err_kfifo. Initialize the embedded kfifo via INIT_KFIFO()
>>
>> Can we cut this down a little where we don't use useful info. e.g.
>> "Initialize the kfifo from a subsys_initcall() to it is ready before
>> any producer or consumer runs."
>>
>>> from a subsys_initcall so its metadata is populated before any
>>> producer or consumer runs.
>>>
>>
>>> Introduce cxl_forward_error() to enqueue a CXL protocol error. A
>>> reference is taken on the PCI device; the consumer releases it via
>>> for_each_cxl_proto_err(). On enqueue failure the reference is
>>> released immediately, the error is dropped, and the consumer is
>>> scheduled to drain existing entries.
>>
>> We don't need to cover error paths in the patch description unless
>> they are really complex and need explanation. Even then probably belongs
>> more in comments.
>>
>> Anyhow you get the idea..
>>
>>> A subsequent patch wires
>>> cxl_forward_error() into handle_error_source() where correctable and
>>> uncorrectable status clearing is left to pci_aer_handle_error().
>>>
>>> Introduce cxl_proto_err_flush() to synchronously wait for the
>>> consumer worker to drain the kfifo. A subsequent patch wires this
>>> into handle_error_source() for UCE events so the CXL plane completes
>>> error handling and panic policy before pci_aer_handle_error() drives
>>> PCIe recovery.
>>>
>>> Introduce cxl_register_proto_err_work() and
>>> cxl_unregister_proto_err_work() for cxl_core to register and
>>> deregister its work handler. On unregistration, pending kfifo entries
>>> are drained and their pdev references released before
>>> cancel_work_sync() runs. Export these and for_each_cxl_proto_err()
>>> via EXPORT_SYMBOL_FOR_MODULES restricted to cxl_core.
>>>
>>> Protect the work pointer with a rwsem to correctly serialize
>>> registration, deregistration, enqueue, and dequeue against concurrent
>>> AER IRQ threads. Serialize concurrent kfifo writers with a spinlock.
>>>
>>> Add MAINTAINERS entries for aer_cxl_vh.c and aer_cxl_rch.c under
>>> the CXL entry so CXL maintainers are CC'd on changes to the AER-CXL
>>> bridging code.
>>
>> Various things inline.  The one potential thing I'd like to highlight is
>> the loss of tracking assume panic isn't appropriate.  My paranoid hat
>> says always go the other way.  If we don't know we didn't lose an
>> uncorrectable error panic.  Maybe it's worth us considering when this
>> might happen in a real system?
>>
>>>
>>> Co-developed-by: Dan Williams <djbw@kernel.org>
>>> Signed-off-by: Dan Williams <djbw@kernel.org>
>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>>
>>> ---
>>>
>>> Changes in v17->v18:
>>> - Remove correctable status clear from cxl_forward_error(); the AER core
>>>   clears all status bits via pci_aer_handle_error() info->status writeback
>>> - Schedule consumer on kfifo overflow so existing entries can be drained
>>>
>>> Changes in v16->v17:
>>> - Reword "kfifo semaphore" to "kfifo spinlock" to match fifo_lock.
>>> - Defer the handle_error_source() is_cxl_error() switch to the patch that
>>>   registers the kfifo consumer to keep each commit bisect-safe.
>>> - Rename rwsema to rwsem
>>> - Change CPER exports to use EXPORT_SYMBOL_FOR_MODULES.
>>> - Add work cancel function.
>>> - Replace kfifo_put() with kfifo_in_spinlocked() for multiple producers
>>> - Add fifo_lock spinlock for concurrent producer serialisation
>>> - Initialize the embedded kfifo with INIT_KFIFO() in a subsys_initcall so
>>>   kfifo->mask, ->esize and ->data are set before first use.
>>> - Clear PCI_ERR_COR_STATUS in cxl_forward_error() after enqueue so the
>>>   device is acked for correctable events even when the consumer drops the
>>>   event. Uncorrectable status is left for cxl_do_recovery() to clear after
>>>   recovery completes, mirroring the AER core convention.
>>> - WARN on double-registration in cxl_register_proto_err_work() to make an
>>>   unintended second consumer visible at runtime.
>>> - Add direct rwsem.h, cleanup.h and workqueue.h includes for symbols used
>>>   in aer_cxl_vh.c
>>> - Add MAINTAINERS entries for drivers/pci/pcie/aer_cxl_*.c
>>> - Update message
>>> ---
>>>  MAINTAINERS                   |   2 +
>>>  drivers/pci/pcie/Makefile     |   1 +
>>>  drivers/pci/pcie/aer.c        |  10 --
>>>  drivers/pci/pcie/aer_cxl_vh.c | 221 ++++++++++++++++++++++++++++++++++
>>>  drivers/pci/pcie/portdrv.h    |   6 +
>>>  include/linux/aer.h           |  24 ++++
>>>  6 files changed, 254 insertions(+), 10 deletions(-)
>>>  create mode 100644 drivers/pci/pcie/aer_cxl_vh.c
>>>
>>
>>
>>> diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
>>> new file mode 100644
>>> index 0000000000000..93bed07936100
>>> --- /dev/null
>>> +++ b/drivers/pci/pcie/aer_cxl_vh.c
>>> @@ -0,0 +1,221 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/* Copyright(c) 2026 AMD Corporation. All rights reserved. */
>>> +
>>> +#include <linux/aer.h>
>>> +#include <linux/atomic.h>
>>> +#include <linux/cleanup.h>
>>> +#include <linux/init.h>
>>> +#include <linux/kfifo.h>
>>> +#include <linux/rwsem.h>
>>
>> Check these.  I'd expect at least spinlock.h to meet the rough include what
>> you use aim.
>>
>>> +#include <linux/wait_bit.h>
>>> +#include <linux/workqueue.h>
>>> +#include "../pci.h"
>>> +#include "portdrv.h"
>>> +
>>> +#define CXL_ERROR_SOURCES_MAX          128
>>> +
>>> +struct cxl_proto_err_kfifo {
>>> +	struct work_struct *work;
>>> +	void (*flush)(void);
>>> +	struct rw_semaphore rwsem;
>>> +	spinlock_t fifo_lock;
>>
>> Ideally add a quick comment to every lock to say what data it covers.
>> Kind of obvious for this one but in general it is good practice and
>> reduces chance of later scope confusion.
>>
>>> +	atomic_t flush_inflight;
>>> +	DECLARE_KFIFO(fifo, struct cxl_proto_err_work_data,
>>> +		      CXL_ERROR_SOURCES_MAX);
>>> +};
>>
>>> +/**
>>> + * cxl_forward_error - Forward a CXL protocol error to the CXL subsystem via kfifo
>>> + * @pdev: PCI device that reported the AER error
>>> + * @info: AER error info containing severity and status
>>> + *
>>> + * Producer side of the AER-CXL kfifo. Enqueues a CXL protocol error work
>>> + * item and schedules the consumer workqueue. Takes a reference on @pdev
>>> + * that the consumer releases after handling.
>>> + *
>>> + * Return: true if the caller must flush the kfifo before AER recovery,
>>> + * false if no CXL error handling was initiated due to early return on
>>> + * error.
>>> + */
>>> +bool cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info)
>>> +{
>>> +	struct cxl_proto_err_work_data wd = {
>>> +		.severity = info->severity,
>>> +		.pdev = pdev,
>>> +	};
>>> +
>>> +	guard(rwsem_read)(&cxl_proto_err_kfifo.rwsem);
>>> +
>>> +	if (!cxl_proto_err_kfifo.work) {
>>> +		dev_err_ratelimited(&pdev->dev, "AER-CXL kfifo reader not registered\n");
>>> +		return false;
>>> +	}
>>> +
>>> +	/*
>>> +	 * Reference discipline: the AER caller (handle_error_source())
>>> +	 * holds a ref on @pdev for the duration of this call and releases
>>> +	 * it on return. Take a fresh ref here so the pdev stays live while
>>> +	 * queued in the kfifo; the consumer (for_each_cxl_proto_err())
>>> +	 * drops that ref after handling. On enqueue failure below, drop
>>> +	 * the ref we just took to avoid a leak.
>>
>> Most of this is useful. The what we do in error handling (given so local)
>> probably not.
>>
>>> +	 */
>>> +	pci_dev_get(pdev);
>>> +
>>> +	/* Serialize concurrent kfifo writers: multiple AER threaded IRQs */
>>> +	if (!kfifo_in_spinlocked(&cxl_proto_err_kfifo.fifo, &wd, 1,
>>> +				 &cxl_proto_err_kfifo.fifo_lock)) {
>>> +		/* Dropped; no panic - UCE unconfirmed without RAS read */
>>
>> Hmm. That's interesting.  To me it fails the normal ras thing of assume
>> the worst if we lost track. I'd panic. But I'm open to other views on this!
>>
> 
> Hi Terry, Jonathan,
> 
> I aggree with this concern.
> 
> When FIFO is full, cxl_forward_error() drops the new entry regardless of severity
> and returns true. For an UCE, the caller then flushes the worker, but the worker
> can only process the older entries that are still in the FIFO.
> The disgarded one is never read.
> 
> Coud the overflow path be made severity-aware so an UCE is never dropped ?
> For example by processing it synchronously, or reserving space for UCEs ?
> 
> Dropping CE may be acceptable, but that's not the case for UCE.
> 
> --Richard
> 

Hi Richard,

Thanks for reviewing.

The implementation chosen here intentionally follows the same pattern as the 
AER core: both aer_recover_queue() and aer_irq() only log (or silently 
drop) on kfifo overflow rather than escalating. Diverging to panic here would 
be inconsistent with the AER behaviour this code largely mirrors.

An overflow requires a sustained error rate that outpaces the consumer draining. 
Hardware errors are being produced faster than they can be processed. If the 
host cannot maintain free space through the kfifo work handler processing, the 
system already has severe problems well beyond a single dropped entry. The 
system is busted.

You and Jonathan have convinced me to make the overflow path severity aware. 
CXL has system-wide implications, unlike PCI device errors that are typically 
more localized. Given the coherency requirements, changing the kfifo overflow 
behaviour for UCE errors makes sense. I'll add a panic for UCE errors that fail 
to enqueue due to kfifo overflow.

Terry



