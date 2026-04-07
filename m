Return-Path: <linuxppc-dev+bounces-19447-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F6BFEEF52
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2026 14:57:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqq6x5kyMz2yZ3;
	Wed, 08 Apr 2026 00:57:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c112::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775573849;
	cv=pass; b=XCrROwkK4/JWmU1/jiSWufn6f6DFthbXSpv/phES3bYu0jnklZ0b1G8l6gUUgqlTTtcDXOHnTpm2vu9GtJap8TRhizymh8wcQJTa0b8gNBl9Ow7ulUFkDWszVEUACR39PZHrlGUJwO4YL7JLcaQ7S1ILSoByAcIeK4/UifwHmUFIhXRngxI8bbhuoFteXA0yGvfScT4Kt/wVMQdbP2gZo/mkNyiajqOQHPQd86VT0zsGF5BRH89zOpEPaioPdKbfod0ljQPJS/CGGqVh9Ctl+mL682xpwmR6BVYW4w8n8GETI9Yymikh2G0SEqrHdbJhB+Z4znBNkQbJgMsNxb2VtQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775573849; c=relaxed/relaxed;
	bh=aLggyNnb8GtZsSTTYRBJxz2keAwlT5MeVnYh0sGng4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hDt/sAkKQtUxH02L2G5HgLrqeOqG6y4/b8Io6I6x+wLSrJumhF5cpyBqYjroK0wcxobXbmKEYYncN/V8qAC4/uNnIXEVujjCIGgSP1m78qJb3T7cWPTGApvs09oxAtp3v7MPJslpRKinFAW0RHuanVkCovyguz1P4doTUUauM1SMIFPLMGvMdXtlNAjgHCTI9aMN5LtEXfQUVQNF1AgOu6knWBbDGjv+9rc+NfJY+nSvIQaXCyVLmaRYyCf69Ij5zLJiXOKakKyJ0WM2Ehbbs3Gw7JMWKuZtxcKgFvp4f7/61G3XN72scUTlRBppUZVynb+eV1yB7XIxTClVd7Zqxg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Mk8j/hWu; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c112::7; helo=cy3pr05cu001.outbound.protection.outlook.com; envelope-from=ziy@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Mk8j/hWu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c112::7; helo=cy3pr05cu001.outbound.protection.outlook.com; envelope-from=ziy@nvidia.com; receiver=lists.ozlabs.org)
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c112::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqq6v54vTz2ySk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 00:57:27 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AwQOqSHM6X/HpPUT2jAjrsh4SgYcadoNg1IUxcAPqaympAFonkYUXVZfc9Imal7JDZO2cETyA8yVsp+tAex0LlPVFvhHueVFe9Qa2rmJeMxWAWt73FYGhP1NwLB/S6RvxNwfVEYy+CgsrvxsjBisoyMFHUV9HLx08tGFsqQSV3XqfcRyRO3XQgbR8N0o1RDQ6yOp4fxVUGs7D6WyMzgdW9+igYYf6kO12NhuYfGpzZjGvRIEcI3BJy8hOB+X/sC+H+jJBeTZLyipvU69qLpNXKPGMJJloIgcrIV76jwZb7To2JD6RKeKtIEIMP8xMqiogVJ6GemEsWRbefurM/4CMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLggyNnb8GtZsSTTYRBJxz2keAwlT5MeVnYh0sGng4U=;
 b=sg7/F8xVIjJX5xIloeoNu+QDrUrvAmV9NR+CJUt1k2diLMs1qXd+kgCJFmwCRH0ta5iDuieJIBPG/Q9ilV6AfoghomcCJlGH7IMFEkE2hUQ9ut8yyEH/cE9W37TwoyVX7sOAqQsY3YebbSLOKP/WytA9KrOChhyZWgdmxZ4ZvO2R53q/yLa4go/wFdve1N4a/xDnyIFzfrs0DUnpJdNeveQHQtUmUfMmOOSo2Nue3x4s6oyw2TzXjzEMfeXpDR0LLCLbkxTTHEY1zEpL2Mqrf3KDhTwKm7Zf62+lbb0oqMF4Fc21Zok2ui/W2naFnqNDXEnrFJcx002hchYAW6YTyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLggyNnb8GtZsSTTYRBJxz2keAwlT5MeVnYh0sGng4U=;
 b=Mk8j/hWuZs4g5uWNdmQxfKeOtkPfaaWK9fUvfONTZ0NizugYtZd1vkuh65kPAv0+SY0EpwaEjU1/SlV4httoUNG2vkS6CQl+GqpfSaLscpV2IgP8VhfLyDeyxZqn/i0Qlx0h1dmxuqikGIA/H14n8nUE26FW0hKb8zX5ZNo2vzcGTlgSC7Nk0CZ/5c9br3dwl11R1KRNZdl0tW/22F4VFnOAn3MVVf3kzsMacg77qbC4+IYsfPXVb4aqr3nOwozr/JSMD0wlVMQRcoV2EmRmtjgQLMU3w0ovFN1pbPxtqOG1CAP20STl38+SBDMQwoNUwRu/Rrd4vLI2ZYsiyiQvtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM6PR12MB4171.namprd12.prod.outlook.com (2603:10b6:5:21f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17; Tue, 7 Apr 2026 14:57:03 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9769.014; Tue, 7 Apr 2026
 14:57:03 +0000
From: Zi Yan <ziy@nvidia.com>
To: Sayali Patil <sayalip@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
 David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@kernel.org>,
 Oscar Salvador <osalvador@suse.de>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Dev Jain <dev.jain@arm.com>,
 Liam.Howlett@oracle.com, linuxppc-dev@lists.ozlabs.org,
 Miaohe Lin <linmiaohe@huawei.com>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH v4 08/15] selftest/mm: align memory size to huge page size
 in hugepage-mremap test
Date: Tue, 07 Apr 2026 10:57:00 -0400
X-Mailer: MailMate (2.0r6290)
Message-ID: <15910BAF-8D1D-4EAA-85A6-2E4CD3700513@nvidia.com>
In-Reply-To: <6aecfff81bd3e288e66af238f50f35eac0bd4ee7.1775466330.git.sayalip@linux.ibm.com>
References: <cover.1775466329.git.sayalip@linux.ibm.com>
 <6aecfff81bd3e288e66af238f50f35eac0bd4ee7.1775466330.git.sayalip@linux.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0247.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::12) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
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
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM6PR12MB4171:EE_
X-MS-Office365-Filtering-Correlation-Id: e6f7263a-4baa-4a11-579c-08de94b5eda4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	QWlWtgXcOJeA/jnYz6QkbwXqagt7gsKxI/hvIUXvl/Aswox06T1pRVDYvwNut/gZ+/0Oh1k7yiciJsutoWXifddnj0gC0krDy8pcB9kyQOkMwGQeoe86cYBeoEVTUgXOIiqHuwapHgv+908dhBfsLZM+M29gJpnPpF4jOsG0nmVVdpPaZEQUEI609C/fZdZ8856hfCmhFWY2ZYpbZcw5eYI+joMO6Q1qQTkF5+rN/0WGsEPAe7R7jBsmmKIjMlLrcUX3rMcgbDNJ6FzT8GXbfXEUI/5rd4tPNygT0iKFnbTLnggX7uFRxQ603TMkgK2sRcTRIw1QjVAtSDVmTwh8D+39h8v+cedxYVJrZ4i/hQd/2ErHDJVGyMMI1BwYI+L6WZdL4xyCGeNuSG7aCnhRtwgnVB1bedvbZ9INZoHXCyU4WgUpSJCRlJiJ7RAYMJWvGY3udiKyB1okipJgWpjyWWMfcv8kRZHe6sv412gyKLKt1AavcZ6XtRhADEsOhLWqThpici2BjXL48rlax1CGMrOuSVZ8N8vQJOGeKx5nnS895sfxAo82Q09+MrDaeANcJoFIpwfG3AvQiiEPbkbg085xKpEi6sPMPqNxKHDYstEMoih0By/wYbzXXgFy9KFD6fhNB/+E82G/LrY5kMCof4P4rJb6YHONSUrvAe7CX5+dccmF827elr1KQn/KUS7X442l/T37aq1eGQ/7qPY44T1AFUwErc5UlBerarqi2nU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U4qn2wJKyY2v9tt0LIpuAMdXdTB/xWmkeR16rMSTPaib2Q3+DrTu6cKTP1FZ?=
 =?us-ascii?Q?HrCjZEI6Uoi/knMKRLwfgo4xkf91Qnu/4ZGo66jmYTCWEmpZzpgJ+7fGbeyk?=
 =?us-ascii?Q?H5oFIRfW6V7KDHc+l0pQ1LtZCLcp4IkyQc9bVv4TqQ4wqrKia4m6my7/XtaY?=
 =?us-ascii?Q?n10NvBgTua30OiYZ5/ktfV0CGxu1rPiR4x7absuRHHqN7lMCHHCYmfp7Pmow?=
 =?us-ascii?Q?boXeoe1YzbCyd8sX9ZCWcqAQPeD+13Qvlgz55v64yIOmcjoeFhQW7DT6C7C0?=
 =?us-ascii?Q?f5PUsgSEXLen48nOjnnJz3CL1P5t8w1pfqaYV0ic+mFpMjB2tcTMwtxv1iVj?=
 =?us-ascii?Q?MJfc5VdXEkYHLRa13T2IQ9/LnOX4yzo4LVjrHeZVVfSfWSopPeUCRK3lKCaL?=
 =?us-ascii?Q?jBGiPCZRvbOjxl2pOyPiA9J3R9fdX5wIovwdvQbkmWO+bR1CUif1VlAc1JM3?=
 =?us-ascii?Q?ABSmHdIx+TeLQXWHbJhJjYPXY20ZpkqLX0COjv625hau2giPdO80+W707iZW?=
 =?us-ascii?Q?zhOrAz7w9WxtGcego6YehfXpLOVEVUv08PtO85NwvVvJgr7W+P49ByHbPrUr?=
 =?us-ascii?Q?wjOI0sJSdwg2/tA6g7KcBJFepEA6Y6h0LV44G7Y03T7MawWCJJmAWkUTqF5i?=
 =?us-ascii?Q?BQawTBYcPOBGa7X47zfBpzLUcGpzzds7piLUubv8zcGYJUZvQI41g4x3IJWu?=
 =?us-ascii?Q?7K65YGAuM+E5jRlXxrAfK9yVbm8O6GLFjaICv0Zv4yIvODJJj012QbA+eZn4?=
 =?us-ascii?Q?ym2Y8pvwlzqxpmKpbwTl2diZE3JzAcJ7DPYu2xyyoL/fjTi2ygShgqu5Keef?=
 =?us-ascii?Q?Q+8Bq0M4eqI3luGDus9hIX+Azzn4fgxK1fiE8i6b1XFu2FUlInqEjEaVs5iH?=
 =?us-ascii?Q?xSUQXvO9I/luZN3iGQZFUOlIA8FllemIDu6ADR4y7Kb4xQ3hnkCnF7tzZZB3?=
 =?us-ascii?Q?eMjnU1WcOipf0S0mvE6KFWSTDfDdseM17NlVTk04I3Ck5raGij6NwRLXJtA5?=
 =?us-ascii?Q?adrIND4EeExPNDxbqdHAvr8MIK3wugO8+2N0ed16y1CIn0p+6b3+n8HkcyVQ?=
 =?us-ascii?Q?EYNX1uZQ1mGCg04RTHJT5dG36J9XZw53V6qYsFoBikCsXnNP86hX9pYm6XF/?=
 =?us-ascii?Q?v0GFl5gYi/IGoz5GEDz84SWKvs8UeBpjJWdkdiSj/A8aWKyvEu34tHfMP0xX?=
 =?us-ascii?Q?saRkuoC+75W6MhkdRU+IixnSRj3AAP1BZbL8+2kNhWZ0VExpqMfX+bwUpOeU?=
 =?us-ascii?Q?Fey9ztCWUX8nDhR8Jw3PJvrQnFcwz5EaK8RJxAasUJW1IaFCCtIXxftyOvhm?=
 =?us-ascii?Q?KaocgwIzvZceeM75wjeJsBPXHuZ7MJ9L4S0XrhKVRVRR9e8EuMcoU9PzucNg?=
 =?us-ascii?Q?+wkxgNnxt0kTVv4hsytwj3Kv6bEQbxqKwgvP9JIBD52i0uQRK0US/IaiuOSl?=
 =?us-ascii?Q?3s8iIMbOo5HCghFKfDHrvZI8pwZnlLxisfE6FQ7MCyquQDb9imF8wGqXLl5I?=
 =?us-ascii?Q?k/zaKD3EzfTQ1voq1c3EAPgoDt70eDOlDkyjZYHJ5L91quHxaRnUIbxkF3BP?=
 =?us-ascii?Q?Epgdc1fVWAOw/5nSMnVVTW4DI3S0KNHv/HG9CCVG1M3trOt3GsH7eqefD99W?=
 =?us-ascii?Q?Sjgy0QY49t5FklBeqT1tYBugkVtOPPkJlGTwKr4ujoNO9eCvN7l7KFvOOj5C?=
 =?us-ascii?Q?cbvWCdHA19iPFQwdjT7XMsIQQhzMXd9MOSke4g1TJnK+MtxB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f7263a-4baa-4a11-579c-08de94b5eda4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 14:57:03.1223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G0II/X5BI3r1hh6hXGJ4s9ZeWeFomrjnT/RhDn8bbE+qRLT6CPN+raSFBwjsNfmL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4171

On 6 Apr 2026, at 5:19, Sayali Patil wrote:

> The hugepage-mremap selftest uses a default mapping size of 10MB
> when no argument is provided. This size is not guaranteed to be
> aligned to the system hugepage size, which can cause munmap() to fail
> and mremap() to succeed where a failure is expected.
>
> Align the mapping length to the runtime hugepage size using
> default_huge_page_size() to ensure the mapping is properly
> aligned. Also handle the case where
> default_huge_page_size() returns 0 by skipping the test.
>
> Before patch:
>   running ./hugepage-mremap
>   ------------------------------
>   TAP version 13
>   1..1
>   Map haddr: Returned address is 0x7eaa40000000
>   Map daddr: Returned address is 0x7daa40000000
>   Map vaddr: Returned address is 0x7faa40000000
>   Address returned by mmap() =3D 0x7fffaa600000
>   Mremap: Returned address is 0x7faa40000000
>   First hex is 0
>   First hex is 3020100
>   Bail out! mremap: Expected failure, but call succeeded
>   Planned tests !=3D run tests (1 !=3D 0)
>   Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
>   [FAIL]
> not ok 1 hugepage-mremap # exit=3D1
>
> After patch:
>   running ./hugepage-mremap
>   -------------------------
>   TAP version 13
>   1..1
>   Map haddr: Returned address is 0x7eaa40000000
>   Map daddr: Returned address is 0x7daa40000000
>   Map vaddr: Returned address is 0x7faa40000000
>   Address returned by mmap() =3D 0x7fff13000000
>   Mremap: Returned address is 0x7faa40000000
>   First hex is 0
>   First hex is 3020100
>   ok 1 Read same data
>   Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
>   [PASS]
> ok 1 hugepage-mremap
>
> Fixes: f77a286de48c ("mm, hugepages: make memory size variable in hugep=
age-mremap selftest")
> Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
> ---
>  tools/testing/selftests/mm/hugepage-mremap.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/tools/testing/selftests/mm/hugepage-mremap.c b/tools/testi=
ng/selftests/mm/hugepage-mremap.c
> index b8f7d92e5a35..f66e4d806477 100644
> --- a/tools/testing/selftests/mm/hugepage-mremap.c
> +++ b/tools/testing/selftests/mm/hugepage-mremap.c
> @@ -32,6 +32,7 @@
>
>  #define PROTECTION (PROT_READ | PROT_WRITE | PROT_EXEC)
>  #define FLAGS (MAP_SHARED | MAP_ANONYMOUS)
> +#define ALIGN(x, a) (((x) + ((a) - 1)) & ~((a) - 1))
>
>  static void check_bytes(char *addr)
>  {
> @@ -110,6 +111,7 @@ int main(int argc, char *argv[])
>  {
>  	size_t length =3D 0;
>  	int ret =3D 0, fd;
> +	size_t hpage_size;
>
>  	ksft_print_header();
>  	ksft_set_plan(1);
> @@ -126,6 +128,14 @@ int main(int argc, char *argv[])
>  		length =3D DEFAULT_LENGTH_MB;
>
>  	length =3D MB_TO_BYTES(length);
> +
> +	hpage_size =3D default_huge_page_size();
> +	if (!hpage_size)
> +		ksft_exit_skip("Unable to determine huge page size\n");
> +
> +	/* Ensure length is hugepage aligned */
> +	length =3D ALIGN(length, hpage_size);
> +
>  	fd =3D memfd_create(argv[0], MFD_HUGETLB);
>  	if (fd < 0)
>  		ksft_exit_fail_msg("Open failed: %s\n", strerror(errno));
> -- =

> 2.52.0

LGTM. BTW, it seems that multiple files, pkey-helpers.h, migration.c,
uffed-unit-test.c, hmm-tests.c, have their own ALIGN or ALIGN_UP.
They can be moved to vm_utils.h, later if someone wants to do a cleanup.

Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

