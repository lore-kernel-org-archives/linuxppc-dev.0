Return-Path: <linuxppc-dev+bounces-24539-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7C9C44529
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 20:38:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3smj6szCz2ySN;
	Tue, 21 Jul 2026 06:38:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c111::9" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784579925;
	cv=pass; b=SCHFYn+OoqnwsIP7O9sL+Z6sgEq+MvJ4MyjN14EV/uAFlyvGv4WdGxDuuZ14UBRyocePYV4Ydksqxu6+9XFwRKYcPHNsyjDg1+BC320Dr0I/m8+E11glL22DlxUx23JqQlpeFapA/xdt6HZLRXlRcjSjaelMjnswwBbX8UgepRlEKdUkNUX3O9B5Plell37Wv98dqgYb5CJLrFKN0qeVngghZXATOZceuAAeZD0PWfxvvmsypalXuVb/+yf2ZDCoecacrOxH6BAfzmNL1aCZ2kYK2YY/FYpPouHvFvKEUnuNeDP0eCc2zu2/44qa0jkK0vwIG2obnjTgBfFtkDcCSw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784579925; c=relaxed/relaxed;
	bh=iiNWh8vxPs3uCsBV0uSWLUpg/knfg3yz/8lBQl+VPhI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QpW9CRAGQ+8GfFlTm81ut0TJfmETt4Kh2/YEH/2bK+1fSgfKopnx4S56qvWx3J6kJYmAsqGpTgOFdtvmPalcxl70L6xVo49Mj+rvtoPK/QjFnJyX2OujeTM25Bct/GAcl9CtjHFRUm1GJ3rnRFg0RsY283JCylsQgc/ueLZnQWplYe9noAGeLfSypIAUbXrOOlOefiyDzJovVJbchapQzarNNZnMTJJGAsaxK5+SKYcnHRajkdM+TyzQuGbwSgxoPS1nnJIB7iAeOQpGLo2f8wj2EwoZUXRcnqYTRKZLoHmCZcb9dOLeDztKhDJzayWIrsUdSXAxDftPq/olLrKcRw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4t/pFJrg; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c111::9; helo=dm5pr21cu001.outbound.protection.outlook.com; envelope-from=terry.bowman@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4t/pFJrg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c111::9; helo=dm5pr21cu001.outbound.protection.outlook.com; envelope-from=terry.bowman@amd.com; receiver=lists.ozlabs.org)
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazlp170110009.outbound.protection.outlook.com [IPv6:2a01:111:f403:c111::9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3smh6tLzz2yLY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 06:38:44 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XEd4c9c5RToSBGcuysJ4TAFNqqkYgdh8ZYcRaRJbOagnSX8MXM/t4Hqej89qZDfO02NErA9i7x7SGmtga65HvK08DaCtsZrBetB6c2a9VQD7Dqje0RTQ8ch1h4GRLJyrmD/uRRk+zT+GqGPypRAq6hlBexds4AwvsOXylvBvHNpE9NXr1/5tyLIdCe57jj4Ky6dASL5tM4XKXVyHBegq7+FonVO5oRk70um/lqzj/RecY9xCOguZ9whpECwMMZT8ag7xD/cKmPoLo9Uqvvu3jfmnlG/DZXgON86XFseV6MmaY8GVCR6JzdmJv4mZqzGl//icW9yWyiQX5gQY9iFQoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iiNWh8vxPs3uCsBV0uSWLUpg/knfg3yz/8lBQl+VPhI=;
 b=QQS3glxV+hpmgfPWujquJDPg72qSXiG1rOnZ7VsxwI67tMXmU0DqtKGfDeEWRaGUYpEF/hZvVzpf/TqVnVP6RUkAOEGGzgz7z0lDzw8XfVYyhcDMeiwaR40VYjOBMV2t9uoGG4AsZy+4Z59dq5jhVCzFpCtCBuhDs++tmn4dqZvCeCoFMbK9pbFFUobGmjbJ3lgDy+czhZBH09cmuU/CmsrW+LJrTgGvHMyG3EdVvMHiqqLobwl8V+Nyl3pNUW6aD07/VjMkML9lFyUaProbE1l1XPnHa4rmStBXUoY2KnWYLKShc/Q764V102CxzJ3Yv2VxNwPDnyhWIfjj3SUiHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiNWh8vxPs3uCsBV0uSWLUpg/knfg3yz/8lBQl+VPhI=;
 b=4t/pFJrg1zDqvTag5QI63yNrhqjdsH7ngd3zWWA0uN5JYXQmoB3V5AmOhweX3PtGiFqUHoJH/1MZP3i5v1Ozmrpx5hjMS7PPH/CB1Grh1ciFkMRBK6mmkbgFLcRxEXxA4j2oe4R8ZD08BtV4ab8ydwxpZgP/5QdFkc4+A2O+3xc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by CH3PR12MB8458.namprd12.prod.outlook.com (2603:10b6:610:155::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 20:38:20 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%3]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 20:38:20 +0000
Message-ID: <a62cf539-15bc-40e3-b860-3442e2f738bb@amd.com>
Date: Mon, 20 Jul 2026 15:38:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 02/13] acpi/apei/ghes: Use raw_spinlock_t for CXL CPER
 work locks
To: Dave Jiang <dave.jiang@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Len Brown <lenb@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Robert Richter <rrichter@amd.com>
Cc: linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
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
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 linux-acpi@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20260717222706.3540281-1-terry.bowman@amd.com>
 <20260717222706.3540281-3-terry.bowman@amd.com>
 <e66c4a00-53e4-4f5a-bc07-edd9c92beb96@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <e66c4a00-53e4-4f5a-bc07-edd9c92beb96@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS1PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:8:233::19) To CH8PR12MB9766.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|CH3PR12MB8458:EE_
X-MS-Office365-Filtering-Correlation-Id: bbf1cbd2-4dde-4106-240e-08dee69ed5c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|6133799003|56012099006|11063799006|10067099003|4143699003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	n5ON6qdTiihwYW2JBso6UKAoe4GTa6xv4iihTnFcoK/Jskomy1wALELn012ej0B0Lt9hWx1tHO5OdHhMH+Hj2ZWbBqdV7qMDT28I6b0HXQR8rSV1MJBw23cNoUd3L4+72otjhyVNXvyT4It9tcW064ODvOlSxXrfQbWfaJbFi9pTirg1zFnBDo82CcCKMfM7lARNWYxfcX7tKPhs1JZpUAQcGonPEev4FjpH26mCtdhEIMN1HMdYvl3BLde4hLspxximAm3px/V7wDBPVGkQ57K4qtsWkXDk8bjBEbZBKWptM0bZDM1y0G95ICmaKuDz04Q06jy90lfqabQxCQMMHz4JG2E0Fwde70v6zb58bJ0En338l87xUGxMOm4p2n6+Yy+NLrB0X/M6K42dpI8z53GTLooNjiDbbBn3zwPzmyHAnSO9EcaT7b/4ESjn8ojKRPPeyqArb+nN8aAmpoYnzKJWcubQ5WQBxhHoVANOI/9wDirw1+aKR1R8zOjvS5fxCO8ybXWdVUmewY5jAT92NRYLez87iCjlEMqE4gRY8K384TVAib5zg6F7JUJIjKktCj7SHn+Cz0SIU3DEDuKovocg9tN5LTRxPKtkGzZjgQ97I73/2WNDiSfYH7Nlsrzacl8CkcIybYtglqDZPuf0zAt3E/zQEGVhqFbWF2JC5cY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDlmNWY3eWxDbm5FZFdvV2hnWDk2Zzlob1hRN3BJcDVSeUd4TUE5R1NENHFi?=
 =?utf-8?B?T1dTcnUzMlBqSENiLzBNaFRuWHdCQ1p2elVmd3dibUVLYUZza29wUFpKOXMy?=
 =?utf-8?B?Zk1vVlliVU8yWCs4UlN2L1BLNVZBRzlDUXJtMmV4eVpZbkhhSGFqaTczVlZ0?=
 =?utf-8?B?eU5ZWDl2dmprSzVHVyttZWJyZ0VEcHdTYUFVVnFUUStNcDJEUzlrNThBNFBz?=
 =?utf-8?B?ZURWdVRaZmNRZGs1QlpTbXRkanpGdW5pTkx5L3UyeGdiYkZyMDBiZUk3TlYr?=
 =?utf-8?B?ckUwMGRaNVFrOUFxS1l5Rk56c1g0Z244NERBTlBDK0RTN1owT3hJOFh4bjdi?=
 =?utf-8?B?M2lOV3BsV2tFbWZLVng2dVUwT0VDSWgxeUxxUU5OcGNDT1JtKzNuc1hia05W?=
 =?utf-8?B?akxOdUJFQitzVG5VTTVLL0c4V2E1WkM1VUQxNDBkUVJTS0ZrNTM1YkhGK1A5?=
 =?utf-8?B?OFYrYmhJSzNuVHhtenRmVDBQTEJTcS9QZEl1dUNYSVN5VWg5UlNUcFdOMTVt?=
 =?utf-8?B?R2tDb1F0cG1lRXZSR0pLanBTa293azdqbjRlWm5Ob2thV1lldVYyWk0rUWll?=
 =?utf-8?B?Y0lUUE1pSTZ0YWJ5K0VtWk1KTXlTN3FUWW00NDBGeTdSMGNadjlUSFpTV2g1?=
 =?utf-8?B?bmRFa1YrdFZrczh4WTJJMjJTdUEzSm4wUE9KTzR0MGNrUkVKQ3IySmdnWlMz?=
 =?utf-8?B?S2lRYm51QzVNenp3a1NhMkFzKzVieDNWRVRCK1NuankrNUxQbThaa0Foa0kv?=
 =?utf-8?B?VmpxSjBSbHdNb1hvMmZkb2lhSXhTNUlMOGk5Tlp0N2hDUzRXSHpnODVVYW5P?=
 =?utf-8?B?S0NsbFdpYy95RzM1YzZkNG9WVHcyTjR3QWxYMjJnM0Y0OE1ERjVGNzV0N01R?=
 =?utf-8?B?R1M1YUJaOEpYZE5PMyt3TDdJNExnUjREZWF0S0FYMkJWYmVsM1NET28vd0dF?=
 =?utf-8?B?VEdaYlB6Mlk5SGhlb2NEaGQrcWEvSzVQVFkwbVVJRTVxenkrZ2hsTGhreEFI?=
 =?utf-8?B?M2xMOGFDRlRZN0pGRGx0RlhVeTdSeXk3bTFZcklPQ3dBRjBEbStyYWRIeDcz?=
 =?utf-8?B?blhyM3d1L3BVNWRDeVNNNnQyaFdaaFhMRDRkK0JyTi9keWsvL2MyOXFhRGVz?=
 =?utf-8?B?S044NE1xa0N1d3RvdjgvV3VYZXJnNGx2MDlxOWE3YkdaYTUvTXU5cUV5QnRO?=
 =?utf-8?B?Z2dCK2diZEVKS09ZRGRDL0l3TmpSR1VPRVhqdnEraWNQOHpvbDlSMmE0blJn?=
 =?utf-8?B?a1ZPbk5EWXR0d2FIMldrUEJ2NjA0T0Z2V21KNnhvZkZyL3JlS1RneG13UDBI?=
 =?utf-8?B?YkNTRzBJZnlrWko1WlpNVTh1TGMvYTREb0pLdFlxb25JOXpZalQ3MmFwVlRw?=
 =?utf-8?B?UmtVaUk4QU1RM1hPa3FMaVZRbHRSZlVkcWFBZEx4a2VJb3hZR2RqbDZ4WUJR?=
 =?utf-8?B?czFCN1F6VjR6RFFWY0FuaHBaTWQySWQvb3N2TWh3YnNXdzBXVkY2bW9oRUN1?=
 =?utf-8?B?UEFNUHVLQkZDME1tOGlkenM4YXdQVWVrdDM0U0hiNjJuR29Lb2cvRkY1SUkz?=
 =?utf-8?B?UWdQWGNSb0RwL3R2b3VCTTg2bnRBa3Q5SEtSL3BjVUdCeERPeitueTgvYVVi?=
 =?utf-8?B?M1llbGR4dENSa3JPSXZlZ05oYVE0cC9CZyt6bm8wNkpzWW1yWkZCQjZlZW45?=
 =?utf-8?B?aHJzTnlZRDFNVXA3MWg3Z1JJM0U3K0oyL1M0TFpJOWc0NTJaa0JjQTRFRm1Y?=
 =?utf-8?B?WlYwSm5XejdJR1VQekQ4cHdNSDl5bFc5SnhGMGVQNVZpd1VHbkJoTE1oNGJN?=
 =?utf-8?B?QW5KTEl3a01ybzF2VFVnL0tNdkM1UDI4cjlwdVVnOVV2Y0J5S3N2dnRFTTFj?=
 =?utf-8?B?eExsMy85cWY4aUxPVTFhampyMFZXRnkrVzBUWThQM1dnS1lUMUVacllCOTJD?=
 =?utf-8?B?MkE0cVpkZ1F4Y0RCNzdWT1phTjB1eEw0RVdVbzBqS2xHaEVKK1pQVEgxMXhm?=
 =?utf-8?B?ZUxjOHBYNy9LNWo4anE4N3JVRlBBRFNtTVZML2tiZEc2bjZpZHVYSGZWR0hY?=
 =?utf-8?B?dktjRTgwNndrWlFleUpNeVd6N1RoL1FEWEM1UFBkYWNtOE9hUExIc2E4dGs3?=
 =?utf-8?B?WjljYzZrdUNUa1hYRXJkREIxK2JUZXc1aXlFbW5IaFJTVHlnaXNncDRhMDd5?=
 =?utf-8?B?SGYwZkticktoZWQwcTB1cE1vQTNaSkxEeVEzdk1RdlpQRU9CZ1VvRWVML05j?=
 =?utf-8?B?Vk9MNCt1YVhLSTM2L2plU2lEN2l4V0JGZGVXK0IyL0QzZklLenkxeXdXcjFG?=
 =?utf-8?Q?9Xy7XB57JQk4WgEwiM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf1cbd2-4dde-4106-240e-08dee69ed5c7
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 20:38:20.0291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9FGlKrgPauiZFUdZLwcU44+jeFzGh3SmcxeXC2Zg9dllk7iwFF6Rt4/I11cDS+h92bAt5fZuy3cz9+qtgADg/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8458

On 7/20/2026 3:12 PM, Dave Jiang wrote:
> 
> 
> On 7/17/26 3:26 PM, Terry Bowman wrote:
>> The CXL CPER work registration and unregistration helpers in
>> drivers/acpi/apei/ghes.c acquire cxl_cper_work_lock and
>> cxl_cper_prot_err_work_lock with guard(spinlock), which leaves local
>> interrupts enabled. The corresponding post paths
>> (cxl_cper_post_event(), cxl_cper_post_prot_err()) execute in hard IRQ
>> context (they are called from the GHES error notification path) and
>> acquire the same locks via guard(spinlock_irqsave).
>>
>> If a CPU is holding one of these locks via guard(spinlock) when a
>> GHES interrupt arrives on the same CPU, the IRQ handler spins on the
>> held lock waiting for it to release, while the lock holder is
>> preempted by the IRQ. The result is a deadlock.
>>
>> Convert both locks from spinlock_t to raw_spinlock_t and use
>> guard(raw_spinlock_irqsave) at all call sites. On PREEMPT_RT kernels
>> spinlock_t is backed by rt_mutex and sleeping from hard IRQ context is
>> not permitted; raw_spinlock_t is safe in both contexts.
>>
>> Add WARN_ONCE to both register functions to surface double-registration
>> bugs at runtime.
>>
>> Restructure both unregister functions to clear the global work pointer
>> under the lock before calling cancel_work_sync(), closing the window
>> where a CPER interrupt could schedule work on a pointer about to be
>> freed. Add kfifo_reset() after cancel_work_sync() so stale entries
>> are not replayed on next module load.
>>
>> Both kfifos are single-consumer: only one work_struct is registered at
>> a time, enforced by the WARN_ONCE guard in the register functions.
>> kfifo_reset() is safe outside the lock because cancel_work_sync() has
>> already quiesced the consumer, and no new consumer can register until
>> the current module exit completes and a fresh module init runs.
>>
>> Remove the now-redundant cancel_work_sync() call from
>> cxl_pci_driver_exit() - cxl_cper_unregister_work() handles quiescing
>> internally.
>>
>> Reported-by: Sashiko <sashiko@linuxfoundation.org>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Fixes: 5e4a264bf8b5 ("acpi/ghes: Process CXL Component Events")
>> Fixes: 36f257e3b0ba ("acpi/ghes, cxl/pci: Process CXL CPER Protocol Errors")
>> Cc: stable@vger.kernel.org
> 
> With the minor sashiko issue addressed,
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> This can probably be picked up ahead of the series.
> 
> 

Yes.

-Terry

>>
>> ---
>>
>> Changes in v17 -> v18:
>> - New patch.
>> ---
>>  drivers/acpi/apei/ghes.c | 50 ++++++++++++++++++++++++++--------------
>>  drivers/cxl/pci.c        |  1 -
>>  2 files changed, 33 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 3236a3ce79d6b..ca7a138c1ff2e 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -749,7 +749,7 @@ static DEFINE_KFIFO(cxl_cper_prot_err_fifo, struct cxl_cper_prot_err_work_data,
>>  		    CXL_CPER_PROT_ERR_FIFO_DEPTH);
>>  
>>  /* Synchronize schedule_work() with cxl_cper_prot_err_work changes */
>> -static DEFINE_SPINLOCK(cxl_cper_prot_err_work_lock);
>> +static DEFINE_RAW_SPINLOCK(cxl_cper_prot_err_work_lock);
>>  struct work_struct *cxl_cper_prot_err_work;
>>  
>>  static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
>> @@ -761,7 +761,7 @@ static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
>>  	if (cxl_cper_sec_prot_err_valid(prot_err))
>>  		return;
>>  
>> -	guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
>> +	guard(raw_spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
>>  
>>  	if (!cxl_cper_prot_err_work)
>>  		return;
>> @@ -780,10 +780,11 @@ static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
>>  
>>  int cxl_cper_register_prot_err_work(struct work_struct *work)
>>  {
>> -	if (cxl_cper_prot_err_work)
>> -		return -EINVAL;
>> +	guard(raw_spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
>>  
>> -	guard(spinlock)(&cxl_cper_prot_err_work_lock);
>> +	if (WARN_ONCE(cxl_cper_prot_err_work,
>> +		      "CPER-CXL kfifo consumer already registered\n"))
>> +		return -EINVAL;
>>  	cxl_cper_prot_err_work = work;
>>  	return 0;
>>  }
>> @@ -791,11 +792,18 @@ EXPORT_SYMBOL_NS_GPL(cxl_cper_register_prot_err_work, "CXL");
>>  
>>  int cxl_cper_unregister_prot_err_work(struct work_struct *work)
>>  {
>> -	if (cxl_cper_prot_err_work != work)
>> -		return -EINVAL;
>> +	scoped_guard(raw_spinlock_irqsave, &cxl_cper_prot_err_work_lock) {
>> +		if (WARN_ONCE(cxl_cper_prot_err_work != work,
>> +			      "CPER-CXL kfifo consumer mismatch on unregister\n"))
>> +			return -EINVAL;
>> +		cxl_cper_prot_err_work = NULL;
>> +	}
>> +
>> +	cancel_work_sync(work);
>> +
>> +	/* Discard stale entries so they are not replayed on next module load */
>> +	kfifo_reset(&cxl_cper_prot_err_fifo);
>>  
>> -	guard(spinlock)(&cxl_cper_prot_err_work_lock);
>> -	cxl_cper_prot_err_work = NULL;
>>  	return 0;
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_prot_err_work, "CXL");
>> @@ -811,7 +819,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_cper_prot_err_kfifo_get, "CXL");
>>  DEFINE_KFIFO(cxl_cper_fifo, struct cxl_cper_work_data, CXL_CPER_FIFO_DEPTH);
>>  
>>  /* Synchronize schedule_work() with cxl_cper_work changes */
>> -static DEFINE_SPINLOCK(cxl_cper_work_lock);
>> +static DEFINE_RAW_SPINLOCK(cxl_cper_work_lock);
>>  struct work_struct *cxl_cper_work;
>>  
>>  static void cxl_cper_post_event(enum cxl_event_type event_type,
>> @@ -831,7 +839,7 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
>>  		return;
>>  	}
>>  
>> -	guard(spinlock_irqsave)(&cxl_cper_work_lock);
>> +	guard(raw_spinlock_irqsave)(&cxl_cper_work_lock);
>>  
>>  	if (!cxl_cper_work)
>>  		return;
>> @@ -849,10 +857,11 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
>>  
>>  int cxl_cper_register_work(struct work_struct *work)
>>  {
>> -	if (cxl_cper_work)
>> +	guard(raw_spinlock_irqsave)(&cxl_cper_work_lock);
>> +	if (WARN_ONCE(cxl_cper_work,
>> +		      "CXL CPER kfifo consumer already registered\n"))
>>  		return -EINVAL;
>>  
>> -	guard(spinlock)(&cxl_cper_work_lock);
>>  	cxl_cper_work = work;
>>  	return 0;
>>  }
>> @@ -860,11 +869,18 @@ EXPORT_SYMBOL_NS_GPL(cxl_cper_register_work, "CXL");
>>  
>>  int cxl_cper_unregister_work(struct work_struct *work)
>>  {
>> -	if (cxl_cper_work != work)
>> -		return -EINVAL;
>> +	scoped_guard(raw_spinlock_irqsave, &cxl_cper_work_lock) {
>> +		if (WARN_ONCE(cxl_cper_work != work,
>> +			      "CXL CPER kfifo consumer mismatch on unregister\n"))
>> +			return -EINVAL;
>> +		cxl_cper_work = NULL;
>> +	}
>> +
>> +	cancel_work_sync(work);
>> +
>> +	/* Discard stale entries so they are not replayed on next module load */
>> +	kfifo_reset(&cxl_cper_fifo);
>>  
>> -	guard(spinlock)(&cxl_cper_work_lock);
>> -	cxl_cper_work = NULL;
>>  	return 0;
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_work, "CXL");
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index 267c679b0b3c2..7c6faee7f85ed 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -1083,7 +1083,6 @@ static int __init cxl_pci_driver_init(void)
>>  static void __exit cxl_pci_driver_exit(void)
>>  {
>>  	cxl_cper_unregister_work(&cxl_cper_work);
>> -	cancel_work_sync(&cxl_cper_work);
>>  	pci_unregister_driver(&cxl_pci_driver);
>>  }
>>  
> 


