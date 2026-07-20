Return-Path: <linuxppc-dev+bounces-24527-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5994AC44529
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 18:13:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3pXs2R0Xz2ySN;
	Tue, 21 Jul 2026 04:13:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c111::9" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784571197;
	cv=pass; b=aswVUmSCoL64BXIdoFdUntpUPcBRiyoyQX1wrgzOFLX0SgolqRaZYNzrIpjL8Caa1zNfTG9L1+uF4FNgi/U3Um8ydCbuIQVTMvzCqcEzDUZdcOEuE0dzMAJZEjrUnMYobji/rVgcTS0VkTEtPJujautdl+/Mfj0O/f3JLtLZKs1MEjdKSezLQBXjDxSMeDZeSDrQQz2+5eNI2EPkajmX6QrGfyPAPdb7n3aHs1tFieT72EbRoDKopdiBQmQokI4AxmQ/z4AntOU5Unkg9hBLivbSeb3uva6rRBaEhcL82mAGnYh1BX27IXXHaBcfJZESBwR3Ddwn2l+HaBVPYBQDhA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784571197; c=relaxed/relaxed;
	bh=3RlEdrbrIhDTmMHUEP8MgUrUgNOPtQe6oaui2VSEN6g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cQJag9Ik6JqFI4T8taTnnEe2gRQJ/l7P5WwEdBl4fw+K0hqwMJAZYwfhI++do2wxoceMVk0OQ5HKBPuHN8EtbHsD8LVZ26t/ZC0X9DVo2ltxzYtbIe9CCQxUhnuDSVq3k6RhzMw2UL3mDBpU0BwDtm2cV4D4z0cuGKqR9SIZp3yht/6hFdirhbhWBXx+TIXoisXxfavZ1nVtx1j1zof+HiLTB5/Jz73NkB7e3Uhr4jLVPys70ZOD46NQ8PnDEn0Bc1fFb6ktqlnLZj81/hmS8aoD0o+Q6/9gckDPMau44FWI7fy2RrzOP00oAJZ3NEesRQU0U7CmSXjSCrxHvx8nZA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2MznsapA; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c111::9; helo=dm5pr21cu001.outbound.protection.outlook.com; envelope-from=terry.bowman@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2MznsapA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c111::9; helo=dm5pr21cu001.outbound.protection.outlook.com; envelope-from=terry.bowman@amd.com; receiver=lists.ozlabs.org)
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazlp170110009.outbound.protection.outlook.com [IPv6:2a01:111:f403:c111::9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3pXp6NhMz2xqJ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 04:13:13 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mor0/t6H5eOMMFFk9FRCg+7hiOP0KjoWQjsjF5ChY5AbzSnDUfzjVjTMIFTdA1ZnGhKspS3WJOH6dbyxNZUSbqN3s4tFcz/Pr1HEx/iLb5gmjAMAzwXDdxAH3maRESOSvhRJhNNbt8G5QO4NLbpgzTkGDfhGLGZm3okboa+qBgiXvTfji5azxwDMHk0qLjmIw6HzGg+W6+xY+XKWupJHfvLbzT8zC88NEsIhCxYQ9OlWbIFdrp4ofxGE8kBK6mtgU60dWze7XQp8qJPpUHad5kdUFN08sVNx0TJSmlZUEmjqzdTJ3h0J0sOjs6ztDA5Mh1ts1Yto+m4Hd8sp+ogecA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RlEdrbrIhDTmMHUEP8MgUrUgNOPtQe6oaui2VSEN6g=;
 b=DoneN+LBzWc4a/dCPvb8BrkqooEDz7knw25pgish4FtqwUgKfTaJytEG6jTNCbuXy1gvDfwJM/tO+H4FT7GgA58Xh0dGlYx0yhciUb3PD4NswhX9cK9CmKxsjG8LoOpQfSPP47X5mQxvUPVKdwCCSu41Bn8MAPFNrjALOsU74S/2IJ4ZqkaohRJFWUA3TJRHkmKUDCsGw65hL6elaeLXSpTk8LmewaXxrAbrVvQU8knOPB+TUWTdzQEXaUlaEcLBMIDFy95m+xkgZnG0vGVmtVMlHQG4VGNf8pIZ6W2So1/lOWORhcYdC+fEOSkWMaGsT5JuM1Hxeoxy9u0LkreBJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RlEdrbrIhDTmMHUEP8MgUrUgNOPtQe6oaui2VSEN6g=;
 b=2MznsapAGVMjJG6/sbz1Ecfnc7de6DsViBBexJXvpJzZ3Y+6xe4/LagUykSI3VNWfgT267zQRoIveQ3CYIgtBQhK8zlnq7DBFP0cZ5J1lF+1UxokRDOX+9vX9+6kyAwUI/cRGO9eOx8RZRFSWp9QivfnVx7TBDZ8gFTlHq6B4N4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by CYYPR12MB8749.namprd12.prod.outlook.com (2603:10b6:930:c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 18:12:43 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%3]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 18:12:41 +0000
Message-ID: <5b4b84b0-e2f4-4ee2-8275-35df808ac87c@amd.com>
Date: Mon, 20 Jul 2026 13:12:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] cxl: Device protocol AER injection
To: Dave Jiang <dave.jiang@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Robert Richter <rrichter@amd.com>
Cc: linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Alejandro Lucero <alucerop@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Ben Cheatham <Benjamin.Cheatham@amd.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Gregory Price <gourry@gourry.net>
References: <20260717225700.3543801-1-terry.bowman@amd.com>
 <6ff8d646-61b1-496e-bdc0-f4a4011d1d58@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <6ff8d646-61b1-496e-bdc0-f4a4011d1d58@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR11CA0010.namprd11.prod.outlook.com
 (2603:10b6:610:54::20) To CH8PR12MB9766.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|CYYPR12MB8749:EE_
X-MS-Office365-Filtering-Correlation-Id: 799e1231-2fb8-4666-1d33-08dee68a7ced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|10067099003|6133799003|5023799004|4143699003|3023799007|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	iVEUHmysBaNO9Aja5EXgI0+AdLKLAV1j1Ezoe5/1ua6nm8613mqoo2FgR6CMUWtqPFh9eTMdh8RZeeft+TXv/l0BvFghU6NpQlbQmnGDiWkbVpAvTMFh6Cd7d65Gsq8uE98ngi7euSYX1eWydHOo2w7q1DhkAzRCt0oC+wIATI+wQnTvy8RwhV3D/2hihZatklQm380a4gHm/iiZI9L6sp3mBty5tkBNWolQ99kXwOOfKsPR67PMT970YwDWs9uFh0IadyMYiwf1Z9MnBmmkZArrTtPrMPqiHQCAxGc0EiwHYIIY6INSOfHGVahNTlsXQ3TBWyUl0t1JJ51efe2qgQ/uD0j5lgd7jdSw8Lk7qNxy5Xq6yEjvE+lJHXXgASxEupQgBtqDiwgUf5NLTQa1hc0+38M5pJfjfDHRALLTXg5lePA8yl8Pv07L3Q8N+hmpcnpJGxWQbu1nENm3Ul5Xxai6bhuXVgYatOv6Zfq0bzvh0y6nhE+Vb/qr912dljQDF/olp17/NgXW5lr/LNSI0bI9eW2kTdRW2EYgveVvhBlUZT1JQqyU0Bs6zwoRVZWDSSiHel0Unhq23T0rT9vx8HqeNlNwBE3mqn34lJdLichp3j2X2WjjhNPZjDXZ5A5XV4PJF72aZUw7G7SiIvRLhTxksfGdB+WNH0ueX2GdVIU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(10067099003)(6133799003)(5023799004)(4143699003)(3023799007)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVZid2xJdDBUOUV6dURSalZEZkorSkNUdkt1b05LVTllVlp4NEFWblhiRm5E?=
 =?utf-8?B?M1pkOXRQVnNWSzFhNTNlc1diQzl5NjVLdFJjbTZGZUczQkszTm82dW5ma3p1?=
 =?utf-8?B?ekdPRHAxdUE2Q3ZiMSs1a05za2s4ODFxVzVlWGVYWXpIZjRHWHNzWjAzM29H?=
 =?utf-8?B?WFgrRFAzNm5Hemd4K3R2V3ZWRGdpZTUyWXZmMWkrZzNvNWxCVGVURzdlWkw3?=
 =?utf-8?B?NmYvU2YwRVV4TTIvSFpIYkxacUt5b1cxQVJZU0pwL3YzVjVyeGQ3bTBRR0V2?=
 =?utf-8?B?OGVLOS9tV2tmTTkzLzl5dTdYdTJiRHYyTEF2d0FybVJ0NU1GSzFBdFhIL2s2?=
 =?utf-8?B?YlZUZU1mdjNjTmFHWGZnVUI2VzA2R2ZjeUJ4Tjhub1BwcStvZzRLSnpJRkh6?=
 =?utf-8?B?MnZaVks4b2lib2NaVTk0Z0xHRTZZUGhoS09jWVVLVXhGRzlQekhMSzMwMHlN?=
 =?utf-8?B?TWMzTVhiRWU3ekNuR2lwU254bWJVaVFCYWpTM0lRbng4OHJFNU9Ld29TRktM?=
 =?utf-8?B?enlKaXYzaDFiQytRVFFtMXRoZnlWbmFHQk5GUzFIbHhPZjNxU3U2SlZHek4v?=
 =?utf-8?B?WVM1UklwQlE3bFd2Z1ZBQXg2ek9CN0ZWR0wrR1RNNDY3UmVza2xxRVJQdnZw?=
 =?utf-8?B?b21hbkxTMVdSS2E3bkVBRWpQZ004QWxHNmNoYkhmYU0rL2hqc05wQWJMZXNq?=
 =?utf-8?B?aVdjdUpHakhwK1p2SHdiNlpnaEJJWFVERm10Nklyb3MybWN4TnIzdndrc0s4?=
 =?utf-8?B?cDU4WjNPVkpZY0IyY0Y2UFovTXZPUVVMODQzeWluOHROcDJHbWRLQmxjQnl4?=
 =?utf-8?B?RDRCU3k3NW9YMUJvbjVpRlMxc0l3amZDbUM1cG0xd2V6YncwN1huSzRXSXhR?=
 =?utf-8?B?MFJtNitSRDZtc1NNZUZEVFhERXZ3UHhGMkJSbmo1d0F6UlVqMWRxZ25jYzRG?=
 =?utf-8?B?cU5JRHpFMHJyTW5qaFVUNDlkdWVySzlnK09RanFrVzcyKzV1MS8wcnV1VkJo?=
 =?utf-8?B?dS82M1NYZDVZUitEaVAxQmJxZ2VUUzVSVFdxdldIdjJUeXRuV2F4Q0NTQTNo?=
 =?utf-8?B?RXZhYlFwaDRJL211SGRyNjZ2ZnVsa0M5MGk5KzZkdjVzYmZDbEJIemN0Rk84?=
 =?utf-8?B?NzM1T2NrdlNpSVBsWXlmZ0JGVjBsZ3FKNWhnRjRwNHdsVzFteVJKMm95UkJB?=
 =?utf-8?B?bmpWYTNDcm9KQTBMRTBJYkorRStJejRVY29YZWEySGVoRUVWZmZlZ2lhcElT?=
 =?utf-8?B?TFQvUlA1a3lHMC91UWt3clZXb2dlOUtvUloyc1oxOFlGbzlFOXJtRERaREZj?=
 =?utf-8?B?Vkd1SitYZkRDZ0Y5aXVlSUJDZkRJdjFCeXBMT1d6WVJ1TFR5dklCYjJjQTVq?=
 =?utf-8?B?NzlnZGM3Yk9Wb0hOVVg1WGU4WWJZd2Vha1JRblQzN3VwWEhUbHFzc0RYUmdC?=
 =?utf-8?B?Nk44VzRrYXhON05wTytDNlJTL29SR3VBN0xnNVI5VEYxTUFRWW1KOTUzZmNj?=
 =?utf-8?B?V1FHejgyTWZ0UnFqSk8wcjBsVXE1dGZxam4zUDhBblRaclZ1QXdQUW5YeHRK?=
 =?utf-8?B?bzV1bmhoWi9lb2pzTWhXWVdqeXplTW5FRDhQTWE1SVY4RU1WQ2MwTEo2M1dl?=
 =?utf-8?B?dWRJa1ZGRFpZU3ZTNEdKK2dudVFLUnBkd1d4WlkrZ2RKdlNVNFZZV3M1SUJw?=
 =?utf-8?B?UXd1UU5QVWJ4Q1g4N3RwK0tPSFFlU3NQWndUUUgwVEd5SWc1ekdENGZQVXJI?=
 =?utf-8?B?dlI1Z3VjblJ5cW9wQkVKbHNEeDltYldid0VmVlpyYS9uaWs4em8xbGp0MUNU?=
 =?utf-8?B?QmhabFhLc0JUa05mcjk3WEdaTEFZWXpXQTRxYmM5aEo5SGtiTndxVkZBM3FG?=
 =?utf-8?B?WjJubXczdjlrNHY3a014K1RRckVIMklURVRSeDBQVHYySWpBalVZalQrV3NI?=
 =?utf-8?B?S2k5bmtiVlZ6T3ZJUFFpTDN2cmd2NnY5WW9uNTVSKzRuMEkyTFZPM1pKdGdL?=
 =?utf-8?B?QndCT0NGZENVamwvN3U2dEJMM3VRb3ByMXBRMGkvVmtKUWt6Yy9tWnRpbGRH?=
 =?utf-8?B?cDBHSEFOelE3T0VGSHdDb2Y1bU9JWjFOd2EyYXlFaHNIN3VIb1NYcmdOd2h2?=
 =?utf-8?B?T1VjNi9yZkE5SjBTNFgzRTMraHhtQmdPRTVhNUZDQjdvdWVRN1U1Z01kMkNk?=
 =?utf-8?B?Wkp4MWJZeDJjMkEvWHg3VWcxS2IrOXFTOHowS2VueWRMbllObGVWeXZlNU9U?=
 =?utf-8?B?SXYxcEZEUEpFWG90UWhwUzVzSG8xeW5vd25hQ0NyQVJSYjhRSUlDRXBtd0V2?=
 =?utf-8?Q?FZMSewRnKjXAUKQBR4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 799e1231-2fb8-4666-1d33-08dee68a7ced
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 18:12:41.0061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZtMSvjBHVvlCw8RzhENuTqtdD0dvo7N2FSziNOL0NJkrivpQvP1+bFIUfZ8XNN8mBr6xJKtlnjqA5woofUyFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8749

On 7/20/2026 12:38 PM, Dave Jiang wrote:
> 
> 
> On 7/17/26 3:57 PM, Terry Bowman wrote:
>> This patch is intended to provide a method of testing the recently submitted
>> cxl series "cxl: Enable CXL PCIe Port Protocol Error handling and logging" found
>> here:
>>
>> https://lore.kernel.org/linux-cxl/20260717222706.3540281-1-terry.bowman@amd.com/T/#md90ec1fdd1b374bf1e32e7736e2b3e34b328c701
>>
>> The changes in this patch will allow CXL RAS protocol testing by injecting
>> AER errors using AER EINJ. The RAS register block status is updated
>> using a central function to augment RAS register block returned by
>> to_ras_base(). This supports all CXL devices including Root Ports,
>> Upstream Switch Ports, Downstream Switch Ports, Endpoints, and RCH
>> Downstream Ports.
>>
>> Add debugfs-based CXL protocol error injection for testing CXL RAS
>> error handling paths. Injects CXL RAS protocol errors using AER internal
>> error inject interface via /sys/kernel/debug/cxl/aer_einj_inject.
>>
>> RAS CXL status is set using to_ras_base() function override when kernel config
>> CONFIG_CXL_PROTO_AER_EINJ is enabled.
>>
>> Usage:
>>   echo "DDDD:BB:DD.F [UCE|CE] AER_STATUS RAS_STATUS [RCH]" > \
>>       /sys/kernel/debug/cxl/aer_einj_inject
>>
>> Move struct aer_error_inj and aer_inject() to linux/aer.h so CXL
>> can invoke AER injection directly. Export aer_inject() with
>> EXPORT_SYMBOL_GPL.
>>
>> Make cxl_debugfs non-static in port.c and declare it extern in
>> core.h so the debugfs file can be created under the existing CXL
>> debugfs root.
>>
>> Co-developed-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>  drivers/cxl/Kconfig           |  13 +++
>>  drivers/cxl/core/core.h       |  21 ++++
>>  drivers/cxl/core/port.c       |   2 +-
>>  drivers/cxl/core/ras.c        | 208 ++++++++++++++++++++++++++++++++++
>>  drivers/cxl/core/ras_rch.c    |  12 ++
>>  drivers/pci/pcie/aer_inject.c |  29 ++---
>>  include/linux/aer.h           |  15 +++
>>  7 files changed, 281 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
>> index 80aeb0d556bd7..ef449228b2549 100644
>> --- a/drivers/cxl/Kconfig
>> +++ b/drivers/cxl/Kconfig
>> @@ -238,6 +238,19 @@ config CXL_RAS
>>  	def_bool y
>>  	depends on ACPI_APEI_GHES && PCIEAER && CXL_BUS
>>  
>> +config CXL_PROTO_AER_EINJ
>> +	bool "CXL: RAS Protocol Error Injection using AER EINJ"
>> +	depends on CXL_RAS
>> +	depends on PCIEAER_INJECT
>> +	help
>> +	  Enable debugfs-based CXL protocol error injection. Writes to
>> +	  /sys/kernel/debug/cxl/aer_einj_inject inject CXL RAS protocol
>> +	  errors using the AER internal error inject interface.
>> +
>> +	  This is a debug/test facility. Say N for production kernels.
>> +
>> +	  If unsure say N.
>> +
>>  config CXL_ATL
>>  	def_bool y
>>  	depends on CXL_REGION
>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>> index a55a4e409feda..91910d2bb5d39 100644
>> --- a/drivers/cxl/core/core.h
>> +++ b/drivers/cxl/core/core.h
>> @@ -182,6 +182,9 @@ static inline struct device *dport_to_host(struct cxl_dport *dport)
>>  		return port->uport_dev;
>>  	return &port->dev;
>>  }
>> +
>> +extern struct dentry *cxl_debugfs;
>> +
>>  #ifdef CONFIG_CXL_RAS
>>  void cxl_ras_init(void);
>>  void cxl_ras_exit(void);
>> @@ -244,4 +247,22 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>>  
>>  resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>>  					   struct cxl_dport *dport);
>> +
>> +#ifdef CONFIG_CXL_PROTO_AER_EINJ
>> +
>> +#define AER_REGISTER_SIZE 5
>> +#define RAS_REGISTER_SIZE (CXL_RAS_CAPABILITY_LENGTH / sizeof(u32))
>> +
>> +struct cxl_aer_einj {
>> +	int correctable;
>> +	bool is_rch;
>> +	struct mutex *lock;
>> +	struct device *dev;
>> +	u32 aer_registers[AER_REGISTER_SIZE];
>> +	u32 ras_registers[RAS_REGISTER_SIZE];
>> +};
>> +
>> +extern struct cxl_aer_einj cxl_aer_einj;
>> +#endif
>> +
>>  #endif /* __CXL_CORE_H__ */
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index a76f3ee05cba8..79657e5fddaac 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -2501,7 +2501,7 @@ const struct bus_type cxl_bus_type = {
>>  };
>>  EXPORT_SYMBOL_NS_GPL(cxl_bus_type, "CXL");
>>  
>> -static struct dentry *cxl_debugfs;
>> +struct dentry *cxl_debugfs;
>>  
>>  struct dentry *cxl_debugfs_create_dir(const char *dir)
>>  {
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index d77208af41e03..d41deea899d30 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -3,6 +3,7 @@
>>  
>>  #include <linux/pci.h>
>>  #include <linux/aer.h>
>> +#include <linux/debugfs.h>
>>  #include <cxl/event.h>
>>  #include <cxlmem.h>
>>  #include <cxlpci.h>
>> @@ -117,6 +118,195 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
>>  }
>>  static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>>  
>> +#if IS_ENABLED(CONFIG_CXL_PROTO_AER_EINJ)
> 
> Can this be moved to a header file? Prefer to not introduce #ifdef in the C source.
> 

Yes, I will move to core.h. 

>> +
>> +static DEFINE_MUTEX(cxl_aer_einj_mutex);
>> +
>> +struct cxl_aer_einj cxl_aer_einj = {
>> +	.lock = &cxl_aer_einj_mutex,
>> +};
>> +
>> +static const char cxl_aer_einj_usage[] =
>> +	"ssss:bb:dd.f [UCE|CE] AER_STATUS RAS_STATUS [RCH]\n";
>> +
>> +static int cxl_aer_inject_error(struct pci_dev *pdev, bool correctable,
>> +				u32 aer_status, u32 ras_status)
>> +{
>> +	/* RCD errors are signaled as internal errors on the associated RCEC */
>> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END) {
>> +		if (!pdev->rcec)
>> +			return -ENODEV;
>> +		pdev = pdev->rcec;
>> +	}
>> +
>> +	struct aer_error_inj einj = {
>> +		.bus = pdev->bus->number,
>> +		.dev = PCI_SLOT(pdev->devfn),
>> +		.fn = PCI_FUNC(pdev->devfn),
>> +		.domain = pci_domain_nr(pdev->bus),
>> +	};
>> +	int ret;
>> +	int aer_offset;
>> +	int ras_offset;
>> +
>> +	if (correctable) {
>> +		einj.cor_status = aer_status | PCI_ERR_COR_INTERNAL;
>> +		aer_offset = PCI_ERR_COR_STATUS / sizeof(u32);
>> +		ras_offset = CXL_RAS_CORRECTABLE_STATUS_OFFSET / sizeof(u32);
>> +	} else {
>> +		einj.uncor_status = aer_status | PCI_ERR_UNC_INTN;
>> +		aer_offset = PCI_ERR_UNCOR_STATUS / sizeof(u32);
>> +		ras_offset = CXL_RAS_UNCORRECTABLE_STATUS_OFFSET / sizeof(u32);
>> +	}
>> +
>> +	cxl_aer_einj.correctable = correctable;
>> +	cxl_aer_einj.aer_registers[aer_offset] = aer_status;
>> +	cxl_aer_einj.ras_registers[ras_offset] = ras_status;
>> +
>> +	ret = aer_inject(&einj);
>> +	if (ret) {
>> +		pr_err("cxl-einj: aer_inject failed: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static ssize_t cxl_aer_einj_write(struct file *file,
>> +				    const char __user *ubuf,
>> +				    size_t count, loff_t *ppos)
>> +{
>> +	char sbdf[16], severity[4], topology[4] = "";
>> +	unsigned int domain, bus, dev, fn;
>> +	u32 aer_status, ras_status;
>> +	struct cxl_dport *dport;
>> +	char buf[128];
>> +	int nargs;
>> +	int ret;
>> +
>> +	if (!capable(CAP_SYS_ADMIN))
>> +		return -EPERM;
>> +
>> +	if (count >= sizeof(buf)) {
>> +		pr_err("cxl-einj: input too long (%zu bytes, max %zu)\n", count, sizeof(buf) - 1);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (copy_from_user(buf, ubuf, count)) {
>> +		pr_err("cxl-einj: copy_from_user failed\n");
>> +		return -EFAULT;
>> +	}
>> +	buf[count] = '\0';
>> +
>> +	nargs = sscanf(buf, "%15s %3s %x %x %3s", sbdf, severity,
>> +		       &aer_status, &ras_status, topology);
>> +	if (nargs < 4) {
>> +		pr_err("cxl-einj: expected format: <SBDF> <UCE|CE> <aer_status> <ras_status>\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (nargs == 5 && strcmp(topology, "RCH") != 0)
>> +		return -EINVAL;
>> +
>> +	if (strcmp(severity, "UCE") != 0 && strcmp(severity, "CE") != 0) {
>> +		pr_err("cxl-einj: expected 'UCE' or 'CE', got '%s'\n", severity);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (sscanf(sbdf, "%x:%x:%x.%x", &domain, &bus, &dev, &fn) != 4) {
>> +		pr_err("cxl-einj: invalid SBDF format '%s', expected DDDD:BB:DD.F\n", sbdf);
>> +		return -EINVAL;
>> +	}
>> +
>> +	struct pci_dev *pdev __free(pci_dev_put) =
>> +		pci_get_domain_bus_and_slot(domain, bus, PCI_DEVFN(dev, fn));
>> +	if (!pdev) {
>> +		pr_err("cxl-einj: device %s not found\n", sbdf);
>> +		return -ENODEV;
>> +	}
>> +
>> +	guard(mutex)(cxl_aer_einj.lock);
>> +	cxl_aer_einj.dev = NULL;
>> +
>> +	struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_dev(&pdev->dev, &dport);
>> +	if (!port) {
>> +		dev_err(&pdev->dev, "cxl-einj: Failed to find CXL Port.\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (!to_ras_base(port, dport)) {
>> +		dev_err(&pdev->dev, "cxl-einj: RAS not initialized.\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	cxl_aer_einj.is_rch = (nargs == 5 && strcmp(topology, "RCH") == 0);
>> +	if (!cxl_aer_einj.is_rch)
>> +		pci_dev_get(pdev);
>> +	cxl_aer_einj.dev = cxl_aer_einj.is_rch ? pdev->dev.parent : &pdev->dev;
>> +	ret = cxl_aer_inject_error(pdev, strcmp(severity, "CE") == 0,
>> +				   aer_status, ras_status);
>> +	if (ret) {
>> +		if (!cxl_aer_einj.is_rch)
>> +			pci_dev_put(pdev);
>> +		cxl_aer_einj.dev = NULL;
>> +		pr_err("cxl-einj: injection failed for %s: %d\n", sbdf, ret);
>> +		return ret;
>> +	}
>> +
>> +	return count;
>> +}
>> +
>> +static ssize_t cxl_aer_einj_read(struct file *file, char __user *ubuf,
>> +				 size_t count, loff_t *ppos)
>> +{
>> +	return simple_read_from_buffer(ubuf, count, ppos,
>> +				       cxl_aer_einj_usage,
>> +				       sizeof(cxl_aer_einj_usage) - 1);
>> +}
>> +
>> +static const struct file_operations cxl_ras_error_fops = {
>> +	.owner		= THIS_MODULE,
>> +	.read		= cxl_aer_einj_read,
>> +	.write		= cxl_aer_einj_write,
>> +	.llseek		= default_llseek,
>> +};
>> +
>> +static void cxl_ras_create_debugfs(struct dentry *dir)
>> +{
>> +	debugfs_create_file("aer_einj_inject", 0600, dir, NULL,
>> +			    &cxl_ras_error_fops);
>> +}
>> +
>> +static void __iomem *to_einj_ras_base(struct cxl_port *port, struct cxl_dport *dport)
>> +{
>> +	if (dport) {
>> +		if (cxl_aer_einj.is_rch) {
>> +			if (cxl_aer_einj.dev == dport->dport_dev) {
>> +				cxl_aer_einj.dev = NULL;
>> +				return (__force void __iomem *)cxl_aer_einj.ras_registers;
>> +			}
>> +		} else {
>> +			if (cxl_aer_einj.dev == dport->dport_dev) {
>> +				pci_dev_put(to_pci_dev(cxl_aer_einj.dev));
>> +				cxl_aer_einj.dev = NULL;
>> +				return (__force void __iomem *)cxl_aer_einj.ras_registers;
>> +			}
>> +		}
>> +	} else if (!cxl_aer_einj.is_rch) {
>> +		struct device *dev = is_cxl_endpoint(port) ?
>> +			port->uport_dev->parent : port->uport_dev;
>> +
>> +		if (dev_is_pci(dev) && cxl_aer_einj.dev == dev) {
>> +			pci_dev_put(to_pci_dev(cxl_aer_einj.dev));
>> +			cxl_aer_einj.dev = NULL;
>> +			return (__force void __iomem *)cxl_aer_einj.ras_registers;
>> +		}
>> +	}
>> +
>> +	return NULL;
>> +}
>> +#endif
>> +
>>  static void cxl_unmask_proto_interrupts(struct device *dev)
>>  {
>>  	struct pci_dev *pdev;
>> @@ -238,6 +428,14 @@ void __iomem *to_ras_base(struct cxl_port *port, struct cxl_dport *dport)
>>  	if (!port)
>>  		return NULL;
>>  
>> +#if IS_ENABLED(CONFIG_CXL_PROTO_AER_EINJ)
> 
> I think you can do something like below instead:
> 
> 	if (IS_ENABLED(CONFIG_CXL_PROTO_AER_EINJ))
> 
> DJ
> 

Good idea. Thanks for pointing this out.

Terry

[snip]


