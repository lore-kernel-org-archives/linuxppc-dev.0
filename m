Return-Path: <linuxppc-dev+bounces-25813-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993F2C5CFDB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2026 09:12:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLKPc6YSKz2yKD;
	Thu, 13 Aug 2026 19:12:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c110::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786612340;
	cv=pass; b=i8rduwA6jfAl4TeR6LmBgBiCaFQwlKHhZJgEXIYwJfaCvK6eBK3/iUv0pCDbQhNa5AAIOqYQSjMLn4oqRPtf4Aaa5obdsP8OO8p+vks+ihUNlBqrpbv3AVts6HH3gr5M0Pmq7cNHbl+8CBdzJrBBY5UveJEgyWz7NqVY8cMDxqlTj7wuF53jMel1pU+TpDQ4o+3wyqX4XK4SpN68B3TD2Ng4u2Xqrp75AuRqgP4wtTPzIwavNH8zGwDiRiLiLUAOsoDavYJ65YIlDiqxDgiCYw/EXjOyIMbGS1G9ttFfTm6/iF4UH/nZEOtYotZt5oWOhf2Qku41Dnsc8qFvYq/iUA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786612340; c=relaxed/relaxed;
	bh=9WBFRX6BPgREUxNFn/NzQLKTj2SXHm/y7NBLmhaGT1g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ImF2I0P11sETIv57+IcsTsql6hESxnTHPslLZDHRyBaJXVH02cxA7zCdqo5ig/+mucLYboxQ9kVvJuGVCQsvjAVmCOHZdtt4ZAJ8cQCQQ5nHKt1SHfaXTqmAtke+2T/sZ2Rc5jXAHgo13lBQ+UhDaoYvUf+vmQZKiDtR8wzyhflRlpbPGLaVqBdArFJIKuq/slSzcubMuw9EiWMNloQv7USQTmVjbbNKjCB/tgloPisiuVcNIzozteUCI3h2CgO7OY79hNelC9K9T9g9QthnB3bQhq7NazWFzvawFM3o96XxKCQxIDBieQsqIeppVx6eJjUDI2XKqSyv+QGNfdWn0g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=hc6D6NP4; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c110::3; helo=bn8pr05cu002.outbound.protection.outlook.com; envelope-from=radhey.shyam.pandey@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=hc6D6NP4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c110::3; helo=bn8pr05cu002.outbound.protection.outlook.com; envelope-from=radhey.shyam.pandey@amd.com; receiver=lists.ozlabs.org)
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c110::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLKPZ0Rz6z2y32
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 19:12:16 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CL/VsI7YifQ4s4kuRxfHf/bUSdIr9m8UMBeZP6FiWt2s6GxzqaR4Uf/k4WBk+SEPOxptbUai6WfJBNdIJlYujjRT1WFLL3q9NeLjMkznEUN39DgLp5yoi5puTScaTLS7IsruUVMwh4bk1fV61nn/l9WUdAaMCqltg7snB5r8ZyNrictvSHWExaCn0mCeUdsZIgUh6n4p5RhdNiGKlcnwaNMZkMh4smbawIdvdwmzun6eGlWs2O2hRFKP1EvGo/PG7BCXb1UB78yZKe7+Jp/Yiwzc75E73yBpeTSwK/CtLIZBknQ24XorwvuNbIdUP/ibu2FV4Cyg/Lce6TZVtYmIAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9WBFRX6BPgREUxNFn/NzQLKTj2SXHm/y7NBLmhaGT1g=;
 b=JtstkD/5COxFr9mjUZczV+mtBh+rsxFxX5cizRBW/D07qQRm/JF/gAxvAtGy4WFmcxJ4DLvZvD/xjh5PJKio20MjbKzdhSQCTVJ/HiCuhNXOyBb1kZ3hyIoGstSqfF5+TrJw/u49iUA+4PTCbtU5zVzZog6r9C3VqGPsT46KFA0pkD/S1yRlyaJW0+edeAakyR3yLTFaW8yRWZkYrc3NVtfllY0XNGH9HtHYccG0Lp6HWSrEFyvTEhqUctvRwMl93XddXsqHYbwd8UR6MyRB46AtVf6GhQj6JSR3FYOiZmrO7IGPZGqZg5aYI158ealy6iruWryWwARz3BN4AOPzHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WBFRX6BPgREUxNFn/NzQLKTj2SXHm/y7NBLmhaGT1g=;
 b=hc6D6NP4VpsGty/Sy2vj7wblojOJIZBhnFDKhQzX142p0QS8VQLp4AkY0yUbHY2/0VVprIUrMoykDIr6MteYllGUX3ZyHW7jjnyxtPaXDIhARkm7sUt4IVdAIFl3p9uXuCbPg3zKW412zxnfNAUOdZtcDAFwnj3nym2D9e1rlAI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY1PR12MB9697.namprd12.prod.outlook.com (2603:10b6:930:107::6)
 by SA1PR12MB9489.namprd12.prod.outlook.com (2603:10b6:806:45c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 08:59:49 +0000
Received: from CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d]) by CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d%6]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 09:11:49 +0000
Message-ID: <5810d8cc-78cd-42c1-a671-2d562ea6d7ec@amd.com>
Date: Thu, 13 Aug 2026 14:41:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] EDAC/versalnet: use put_device() on device_register()
 failure
To: tarunsahu@google.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Geoff Levand <geoff@infradead.org>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 dmatlack@google.com, Borislav Petkov <bp@alien8.de>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, djeffery@redhat.com,
 Tony Luck <tony.luck@intel.com>, skhawaja@google.com,
 Russell King <linux@armlinux.org.uk>, stuart.w.hayes@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 linux-edac@vger.kernel.org
References: <20260810162814.1398016-1-tarunsahu@google.com>
 <20260810162814.1398016-4-tarunsahu@google.com>
 <9e189214-1274-491b-97dc-1b943c6c5cea@amd.com>
 <9huzbjb9hrf0.fsf@tarunix.c.googlers.com>
Content-Language: en-US
From: "Pandey, Radhey Shyam" <radheys@amd.com>
In-Reply-To: <9huzbjb9hrf0.fsf@tarunix.c.googlers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0080.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26b::8) To CY1PR12MB9697.namprd12.prod.outlook.com
 (2603:10b6:930:107::6)
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
X-MS-TrafficTypeDiagnostic: CY1PR12MB9697:EE_|SA1PR12MB9489:EE_
X-MS-Office365-Filtering-Correlation-Id: f37db8fa-ad28-4966-3dbc-08def91ae7c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|921020|11063799006|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	JL2PagGibDBbb6WHLY6f9GD7Qvx4D/DlLdjycybkGmnpuu8s4yJIu47VZnYNQZIRJ4cV+q6OxZLBxrfanipt2X+xQo1daI733iPlmcDiWHBvxM8xQW/2URDMDFtf53l0nTDhcF3FU0NO1OGSjhaB8DTd6XmJqxhaopRAPT+pwh1zHleQGzeDZJN50/vWLvOiQTr8JsIvZkf96YacmENTp7x3d6v9C2C3QDSFGJWuojeOy/3EOiAwm8IqxFibbq9nmtCsd5ingt+ihh+/Jz0juFvi+pCwhfa58aLTH56+n5q4ElNJOIk5k0yG7OuTmdZVZvS5dvico89m7rIwX2CDj8uCO0gyVasZ6Ixf4PahdH5qLksTKwrUnBEOHHj3YB9uSnurCr8cFWMTPwJNrkJ25BaRWmxArumTOGQK7LAkOnbrW+4zBvau3ma9UkprmrkMS6Q85f2pEsX4Mcuih+inGiZAA35VadrysJQdRFJ4/S4WrH9sUTx1icmfFTtNRBYEn/3qZH7Ugmg89yp4bEwtdQuTuRtRN4cNYYuC8JA5VoiLGvO+C9sF3juaTFcCMNQT3xW71Z2w5239SsdKMCc0eCq8YhOtatjHopMephSEAalY2YrLxT/rVoBHtOwLKZ8XbQRH4QK5Eqfh1TPCERIdEeVqauZhmnhJquV3Gz/xF2Fk5OpVjpGx8FlkWr8v3C2foZ76L23IaFQ6XPtWXROiOA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9697.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(921020)(11063799006)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnFDZktNZU8yY0xlcE9Qd0xuanJmb212VHRkcUI0aWcyZzlFYjhLcC9Obnox?=
 =?utf-8?B?RWlFQXlRa3hib2N0cExEaWpyN3lQcUFzVUltQnVZOFZLcGFrc2lkUGhYdnhG?=
 =?utf-8?B?ZnRXNFhjMGNNMUtjUEF6alpDL2M0YUdYMzBtNXd5UFFLRVlIL1lHY1NVai8v?=
 =?utf-8?B?ck9UWEF3azNrTGcxUnlVSmJYOHEvRDNVQWhnZDNrV2Mxb3kxVzlhUkdldkpa?=
 =?utf-8?B?M21jZXMwZmR0ZjNmT2QrekUraCthbUxoZmV4Lzc1QVRieE9IRFlEQW9RQkI0?=
 =?utf-8?B?ZHlkZm0ySVl1VzFCaWRJeUVoQ2ZNWllONzMrcWNpY0Q1NXcyMHpnbUhnOEE1?=
 =?utf-8?B?a3hpUlp6Tk56K2xZdzArSU04VGVuY3dDM2tiNzVtRE5hcUxjMVlPSjZPSGpi?=
 =?utf-8?B?dGZvbEZ5dzNLQlIyMGFsd0xzcHR5MDMrSFRaRDVVK21hdDhicnh1SW94ZHhI?=
 =?utf-8?B?UGhKaHpmTDZXZnBpenNOU2dmWU1WT0daMzNtNllwdmpERTJuRlBzb2FxMnBH?=
 =?utf-8?B?ZkVwL1NXTGlzT2p4ck9MZDVZMWliYlZzY0pXRXBUdmorcGVNS1piallYRXR0?=
 =?utf-8?B?UmJCbmdld0xuNDVhMXJqWGJHV2tYcHZyMHIyNjdzWFNGaGVGTVVtYXk3TkRV?=
 =?utf-8?B?Z25CSVAzVlhqNVloaGVIekJOa1htdDdSczBIVUpScmRaWGltdWdtVVRtWjZr?=
 =?utf-8?B?RlF3LzFkYzhFM0dhNFZMZkkwR0Q1Y0lwZXdHSjd6ejJWUDhFeDVYSk1vSjFF?=
 =?utf-8?B?Zmw0WWRsdEkvdGpZSDhVQXZMOE1LaGVESVVaMk9kU1o0R0tKYkZIUWRRTUlN?=
 =?utf-8?B?ckErN2laY09mM1BzSXcwLzBNaVIrakY2ZnQ2NitKM0xOeVlFNm0zYTlYN3dn?=
 =?utf-8?B?dGxaSDBFZmV0NmQrKzgvNlpnUmZ3WFZsZUE2K1R4T29UVkFPQ0RTc2EwOXpr?=
 =?utf-8?B?a2hPY3hEbWxmY2o4M2o4MS85SkVuVzNyZkFjVFBHanI5RmdSNCtSSGtBeVEx?=
 =?utf-8?B?V3VKbHdwa0Y1M1k5RUVOQ0hKbTh6RGFHT1VhWkM0MkJIMXRyeWJFS0xaa1VB?=
 =?utf-8?B?OWpCblVjeDl6ampianJGdUlFVVdsZEp1MW1DM05sVWZZTkh3M0l4M3pZYkY1?=
 =?utf-8?B?VkJBM3lNSWJIbE1pZUhTTlBHaDdXOFZ4Mjlna0xpdUY1WnEzNHFsMDJoQi9a?=
 =?utf-8?B?VUpyN1pwN1JTU2VxQVNLbmRIV0t1VER6SUdtMVFERjQxNU5MTTZZSjZQZ2Nw?=
 =?utf-8?B?OURYN0lQMHVGNFR5Z0gwOWRUTHd3aWJBNlFnVmFtZHZvTDUrU1owdXE3Sk1V?=
 =?utf-8?B?MGtlNFptTUsxdDRJbldoKzRERTdjZlVRai9mdmRsQitSQllwUUxoL3E4aFNT?=
 =?utf-8?B?MWNaNUJwamxua1NONFNpSnV2RGQ3aXRJeVBGWXBpK3lVVDFFL1pmL2NaUXE0?=
 =?utf-8?B?TkExb1lpY2N2MWRTbzVIdVpsajFBUHpjYjFXUkRMZUgxSitrQWp6TUJXdmF1?=
 =?utf-8?B?bzlKNTB6Njk0eWRqYWV5TnhrTy9nNEhyQ1dhanlIWUlrWHNTd01pc2t1YnN1?=
 =?utf-8?B?Q3VRcXAwOUhHVDI4c3pFVnZRdzU1UXUzd2RzRTVyU0o5RktRdEYveFNaTnVH?=
 =?utf-8?B?UXB6QVRWYnovSndBM0I1d3Ivd0hIcnB0ZG1URXBmb0pndlhWb3k0OElUeTFD?=
 =?utf-8?B?U084NCszN2pTMG1PMkVvRmt4Y3oza1hiUkphOVV0L0NMVjN1YWpNV0RyMjVU?=
 =?utf-8?B?Vm9VZ2RUQVd6ekVIelBka2NkQzl3WUlsQWtyZHkxSndVbzFDRUg3djJDU1Zx?=
 =?utf-8?B?V085dDA3K0RIRXk1dkpyS3ZwRFZyd01Gc09lVFluL2ZZNXZ4MXYxWTU3MHZE?=
 =?utf-8?B?bWVPVnVyQWtIY3dSS2tFZllRTi9GTEhxV0NjdkFHWWZZSStDYm1YUElQY3p4?=
 =?utf-8?B?RThwWnFCenlFV2xWZDgrVUg0endPbSs0ODFGNzVsL3c2VVZxd1JkMVJxMFdQ?=
 =?utf-8?B?M3BCWVlPaEttaHBWYjZYL0pFbU81VVFxK1JLcENOS3VpT29SYzUrUDdIS0E2?=
 =?utf-8?B?TVV1Z0hrdUJCTEw0NDgydEllU29VVnMwa0hmZlhjbHc5b0s4dmdkVFg4eXgr?=
 =?utf-8?B?T05JYnJoN0ZhRlUyaVc3eTBadGd0TVVKcjcvZlIzN2FiK2pZOEhlTlhTbE1m?=
 =?utf-8?B?QkVLNUdkcjB0d1dmdGM5cndMeEZ4MEcrL1RqSDQ3Ly9CY1NQdFJ5dlNDVVFk?=
 =?utf-8?B?ZGpmVkdBK00yaDByOTN6Z0dveW5LMkNUeDF0bFhZT28xNVpMMS9PVkp5aUE1?=
 =?utf-8?B?eTNBdHZ4b1IxZWRvVXh3dlZKQ21QTXhYZFgxRWJ6cnJDZE9CZG1Xdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f37db8fa-ad28-4966-3dbc-08def91ae7c3
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 09:11:49.0567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BPUZHpiY2GKMhGiIt8Bgvd1UcRc1+JhKdkT2+Ou8+OSo/0PlP5CyrAi2we+DCBxK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9489

On 8/11/2026 4:09 PM, tarunsahu@google.com wrote:
> "Pandey, Radhey Shyam" <radheys@amd.com> writes:
> 
>> On 8/10/2026 9:58 PM, Tarun Sahu wrote:
>>> When device_register() fails, calling kfree(dev) directly bypasses the
>>> device_release() callback (versal_edac_release) and leaks the allocated
>>> driver core structures.
>>>
>>> Fix this by calling put_device(dev) when device_register() returns an
>>> error, ensuring proper refcount decrement and release cleanup.
>>>
>>> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
>>
>> Thanks for the patch. FYI, this issue is already being addressed in an
>> ongoing series.
>> https://lore.kernel.org/all/20260724171945.2812749-5-shubhrajyoti.datta@amd.com/
>>
> 
> That is good. Should it go as saperate patch or it fits very well with
> the above series. I will drop it incase of later. WDYT?
> 

Please drop it from your series as the fix done in Shubhrajyoti's
series is complete.

Thanks,
Radhey

> ~Tarun
> 
>> -Radhey
>>
>>> ---
>>>    drivers/edac/versalnet_edac.c | 6 ++++--
>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_edac.c
>>> index 97ec05d68bbb..2912b3658915 100644
>>> --- a/drivers/edac/versalnet_edac.c
>>> +++ b/drivers/edac/versalnet_edac.c
>>> @@ -829,8 +829,10 @@ static int init_one_mc(struct mc_priv *priv, struct platform_device *pdev, int i
>>>    	dev->release = versal_edac_release;
>>>    
>>>    	rc = device_register(dev);
>>> -	if (rc)
>>> +	if (rc) {
>>> +		put_device(dev);
>>>    		goto err_mc_free;
>>> +	}
>>>    
>>>    	mci->pdev = dev;
>>>    	mc_init(mci, dev);
>>> @@ -852,9 +854,9 @@ static int init_one_mc(struct mc_priv *priv, struct platform_device *pdev, int i
>>>    	device_unregister(mci->pdev);
>>>    err_mc_free:
>>>    	edac_mc_free(mci);
>>> +	return rc;
>>>    err_dev_free:
>>>    	kfree(dev);
>>> -
>>>    	return rc;
>>>    }
>>>    


