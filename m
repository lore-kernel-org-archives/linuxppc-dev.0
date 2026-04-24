Return-Path: <linuxppc-dev+bounces-20046-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3192FB44C8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 07:56:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g24zr2vYLz2xwH;
	Fri, 24 Apr 2026 17:56:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c111::9" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777017416;
	cv=pass; b=jydrnG1vuG+ZRrNZ9ZxHjPHJX5Hxyt7vDp4AFieFAvgbGenBFSSvkdQEGPc7kWOKUVbACIQlQ/igwUcnyil7XigwJ4wNKrj/61I+5QLJ/Ssup76biugY3HuHQeNg6S5q766M/4xcNK9vSmMCQ13PZSm7E3q9DImJLRLw9l5NmWYoqCyY3ByjQd/5IO7+RKngtBG/xeeDx8UzSBuaw0sfzVFVUs7TMNTG/A9C5tNn69SdmYaQkcKMF8Fag/2hSpXSttLLE65dB5woLJmGOnb//Nv5Jxv+giqSmrwZST7h9LR7iUhIMi6yglMhR5726IsEFZfUxTB7CoDzKJWs8h7Y6w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777017416; c=relaxed/relaxed;
	bh=scSnd+H3WVxhMjEXoi5rhivsgX1stNt6JPlyZUyc9XI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a2QbBombxCib8z+AtupZLLAQPWbub7zK61ShYO7yYs6AXSAnA9E042oq5h9e7MwiNWzDhDEINLL8MYVYtYHANMDKq5ySI/YS4XluvTz19mT837q3tnOmbiS7XiY7vphncu2UvFXIu8ZoMA+WJcTYRu+3TWml6kgSXyCsZhapLAkpu+g3TGaDbGfrqpLQvZIeawFQneM+7MpnOTBHn0ldZ3VLVXzc9s7Si1t4pvMGNXTSO1A7YGUetEIrWyeIqAOYaxVlIVeNBhW5QPuBbW/9rSQqKrhE1nIbtkYTkhnTzMuMwbP1FbOM6KhGYtGVPRe3Gj19ve8ra37vwhyK8P4gmg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=k2Wo/xFD; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c111::9; helo=dm5pr21cu001.outbound.protection.outlook.com; envelope-from=christian.koenig@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=k2Wo/xFD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c111::9; helo=dm5pr21cu001.outbound.protection.outlook.com; envelope-from=christian.koenig@amd.com; receiver=lists.ozlabs.org)
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazlp170110009.outbound.protection.outlook.com [IPv6:2a01:111:f403:c111::9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g24zp0PJBz2xly
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 17:56:53 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o9/KAROI8IXfUP1G0TO7wdtlJO7mOum5bLdxe43PzOTHpMyMdOg+cF+CaxYGP+zWq5zgzWVBHqekDPlWaz7vQcd85xIys5SGSCCsLtlR9G97KKHF8bqBCwV4XD0q+MvX7UYqeJMfN1X8TPxj46QTYwT2S7+U06p7qmuLYT4xBMwTzeCQkBO2+ivAnCZDl2LhTuDyic3gJ5QXYWjOprJOSTKIC+Z0XoQ3VP8u5QTM/S+yLgLQEOPZEWOx/hepCSkovjrEHhGibC+i7tfl9CrsIdd0w6k6jBSlKCWYRuMXyRFuREPAjaDly2BpLdwxSgd9FhDpKOciFBoFQ7D7novHoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scSnd+H3WVxhMjEXoi5rhivsgX1stNt6JPlyZUyc9XI=;
 b=fEvTqyVHnYZIGdYWmQTEhpmHxKmhchh1PpH/uWlNqlbmATa0j2IVH+JmMOOGfjjo1XFKk0SoRMCUSk6ylkq3COABqRb+pd0Sh92DJmYcuM5VV6OvwD3/SlZUjDwa+YaVkZLqDE6zOoU8mMcsj4zYvKx6wCn48yTxVVPPB8o7LcOs1In2KjY/vGBdf1m6wL5HJNhuWcbG4wRzOm13S6DApkUfHTJR2aDGY+7aDzjE2acMBGbqSfLXXhAMjr4AZrjW7V19D2dG+IMZMfFhrRy/EDVxJjxu3X2rJ2I+dgMUgjnIlGOh+XbR6T4k6gMi3JSkFZmOS1UV+tMOPZSvJ8C5xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scSnd+H3WVxhMjEXoi5rhivsgX1stNt6JPlyZUyc9XI=;
 b=k2Wo/xFDdkNGpLbd7eVOFdCwu+4zIiBfEEN9gToSEyZeCXiaqreSJfwDI2pY7TP36J35TIayBw4t2Fppz00HDKRkj7Zg9uyAFqlLL2hRubF6nHh3GojvQ6JdY11fDg8CGVn3+07RGvLbMxtN1aWl+u1AkgR0YBfXWP4B6QkrTGI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB6861.namprd12.prod.outlook.com (2603:10b6:806:266::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Fri, 24 Apr
 2026 07:56:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 07:56:27 +0000
Message-ID: <b4dcb464-7784-47e2-a973-6d731ab9ccf8@amd.com>
Date: Fri, 24 Apr 2026 09:56:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V13 2/7] dma-resv: Fix undefined symbol when
 CONFIG_DMA_SHARED_BUFFER is disabled
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
 jbaron@akamai.com, aliceryhl@google.com, rostedt@goodmis.org,
 ardb@kernel.org, sumit.semwal@linaro.org, ojeda@kernel.org,
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
 dakr@kernel.org, nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
 morbo@google.com, justinstitt@google.com, tamird@kernel.org, arnd@arndb.de,
 nsc@kernel.org, simona.vetter@ffwll.ch, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
References: <20260424054742.45832-1-mkchauras@gmail.com>
 <20260424054742.45832-3-mkchauras@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260424054742.45832-3-mkchauras@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: e1a51f7d-c556-4420-2a76-08dea1d6fcbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|18002099003|921020|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	hcbDccIkFnEwL3/hvvoGROrys+qLkGqjSziOPe48RryGsAdQ8W0uOEdRMCOEn1YevwM677ZCrknXyClW6rMT4dhIQw9EyBWRWzWLZ1xwjlNmoNnBNmGstDFoDJEBXpqES7Err+Uv/e/XR2IIWY134wY/7Dn78BpfUi6yWnXSy4y3BGw8rCJuLjabcdk9rZvxry8frWuMkexJ1TcNMJV++xmT5hQxP4k3tzxTq9eKh04bwQ2gX3/hSBwXXm9OanbUPOlRV1UtLpbLhvi6G5mDmdfqTsWeIUMFFElWvRBmyGdL4aZw7aOXulr1UZALvSHDy4yykXBJ110rlI3AqoK25GQaBKqGmlCYFTBKnLsr0z7QEEWCiaOrjgSD4ZGmkSxUyVCldO/zkPMKZeC+s7vqpqBU27WvTu1hGC5G94K8GDrYBUnFo57Mmk94Kk2MjClLZkLmFTphVPa0DXYcUrBfY4Q+3dkF+8LbzPcSF3vgBeZdHVzrP4g9KvzhVPpcWg85Nz+IFItfWHkxh4eRihcoUtEA5nWalgAUvukE7QHRPDa9lA6K3Yw+inNqWhLgf0GzoH8ZT7DXKNN3Zmx3SFIS6+V/JoG4iALfvvZ16Ro1RfeEvXGmhOrnmiV4G1UQjUE49+ZKgFpg80JeOQ+XlCzXA2QInij0aAOks5yVJK5PFeIwXDs1zlEr6dzvkwkjlrPtpCJVCX50SJGHS6vxzNySD/7dqavktMCJTiSuHl5SvUOrK9NW7RZ6FKRsNIu5mDB4TLGom+XfVeS277+4nBNFUg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(18002099003)(921020)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDNjcXJIT2IwelRlN0Y2Nkl0aGFkQVFYNyt4TVg1dE5NQ1RqNklZcVM3Y3ly?=
 =?utf-8?B?M01wcVUrTTJSQXV1bnYxMnlqZWsrVk5RMmVoYmF5S2VHMFlmRUY3RkU1SWs5?=
 =?utf-8?B?NTZ2U0F3SzR0cFJTd1VyZmp2TmJrUlkwblZlMGtSVDNIajJhanBkY08xbjJh?=
 =?utf-8?B?NnhEdXVCcFBwNnJkRlRnenBlbStzM0cwNVBRbEZ0WEJpamliWXNmdmQxYjVX?=
 =?utf-8?B?OFB1MzIyNjFxSjNqcEpyc05nNXhWc0JFZThQQWcrUkQvd1FnWjdjRUZjb3BI?=
 =?utf-8?B?UEt4bHl5dnpYWll5TGhzdEs3NGk0Nm41RU1vaXVrM29lQVFIaFE3RlY5SWdw?=
 =?utf-8?B?UzJIeEViTStnUG90OU4vZzFHbGo0M2tFanhTS0h6OFJjak91MmdHTWxPRlds?=
 =?utf-8?B?TjBOaGJPZlVqRmt4NnYrT2tHSjRRZGRzVHJSbm9SQmFRcGYxY0dVamQ2VVNS?=
 =?utf-8?B?SnlyUEd6dldOaHdzR3VjN2syN2VuUk4yOHJuNkNmWFd1YkFGSFQ4WjA5MTg4?=
 =?utf-8?B?TmUwQkhSLzZ0UFFvZmhLRWNERkd1b21sNGQ0LzAreUVoRjVNWU9KQzNUWkV2?=
 =?utf-8?B?M0JuSjB1Ry9Fd0FRSDJCbnV3dTl5QlBGemZYNWRpU2VEcjhNbmJ0RWl3YWZF?=
 =?utf-8?B?QkVXamxiM2x3OTM0VHB5emgyVXVVaTJIODFaNXhHSUdYR1Y3SCt6MUlKODhx?=
 =?utf-8?B?WTRVaEQ4Rk05MzFlNERZeVB3RlcvYmx0cll1WGpKVjR2N0pqTFMydEdKQWY5?=
 =?utf-8?B?NUt1Z05URFQrQndGcERnQ3orK0UwdXAvdjlESkVmb0ZPaUgzN2pFeEFEOUFp?=
 =?utf-8?B?R1V5dWV4cHM5dmFEdHd0RXQzSi84c2V0eGtaZnJMMXlSUWxPYk5qbTRZTkkx?=
 =?utf-8?B?K1NpL0FyQ3ZzUmY3T1NrMk9YNEtKaGJ6NmRaRTNubmhDd0g5NXptVGRiQ3Bs?=
 =?utf-8?B?cHJwRi8rQk42Q1RBa204OWpyV2xiRGJpZEpwRmJKV0g1d1VHeGxFaVlTK1NG?=
 =?utf-8?B?TFFPeHdtWm8zMGs5V2xpejFXYW1HS05XeERnQ3gwR1lqYjFhbHJFWTlneDhZ?=
 =?utf-8?B?ZWp4MVdSSXFVcTZHVTVUZ2hZYVU1R3VWVWdNaVVBcWV2czcxeGdOVXI3OC9w?=
 =?utf-8?B?L01ueTBwK1RsSEV1VFVGS0llNkNmbmlWaUtoUWFmVVBWY0czZDFqcXNRNW5K?=
 =?utf-8?B?c2U1MlJHR1IzQkRMa0lXMEh4VUNyaWpMeCtidFAxL1hJYURkNVJpMlZRcmVY?=
 =?utf-8?B?S3oweVVaTUE5ZkJ1bEpnRzNVOEZRRFRJYUM4bk4vY3Z5N2oxSksrVUhTU3pD?=
 =?utf-8?B?U3FScTJwOElzeWlNT2xWd3UxTUdVOWpPU2hhUjJmM3Y0WlpVODh4RG80b0FQ?=
 =?utf-8?B?b2VZWk1GWjZ5OXlBdU9BZ1BxMFp2RTNtVTBZUHd0SEFScW5PbStiM0J6WmYy?=
 =?utf-8?B?NklnelNqaThpbUxxMSs3UzM5QlpSOWZxeDYwRmlrOHVxMTVHRU5zTm1YUjQr?=
 =?utf-8?B?VnBsNFRHUXJxeGtlZThFSVRkZDVZdkplRm4vNlBiSmVlRzAyWmtZdlRxRTdh?=
 =?utf-8?B?N0pncXhidmZ2bWZTangwV3JrU2psaU9DQytoSlZ2dkI5S29vZTNJcVBvZk5B?=
 =?utf-8?B?aHlSSERhZitmdXNubmUxalNGcFJITXlxRkNlK3ZvUjdTanI2L2RxWThQc1hF?=
 =?utf-8?B?T3QzdkdTZEFtRUo2YmlwQ1U2SzIwZDdDV3RzUTVrS1VmTDh5aUtDRmVwa1Z3?=
 =?utf-8?B?aHByNVAxQ2cwNW0zOGVmcHdKYzZQT2xWYTBVc2IzUHdtNjd0Z29mSzRockxp?=
 =?utf-8?B?dGVIbVhLZTZneHE1bEY5azVCRTh2Q3NkMG9NNzd0K0hjMVFyOU1KK3F1SWNO?=
 =?utf-8?B?RHo3Zk9pcXpkUjg4bnVTUGZrUWRCNkNwQTdiRmVBSDBIWG14V0JQUnYzeW1G?=
 =?utf-8?B?SG84MEhiSm1KSzFUVnZ5bGx1b01tTDFzMUJPc3NsZEYveCsvdjRlazNoeVNQ?=
 =?utf-8?B?QWIrRVdSQXJjQlp5TUtYZFpyVUx2ZFJTS1lqQzVQTkorM1NjVlV4UmZOMzNh?=
 =?utf-8?B?c2VyeWNhbmRzLytsSDJFaDZFRzdNTnpLaU1kM01USjYycUF3TkxTTmI5dHdV?=
 =?utf-8?B?VUU2MEtoMW5ocUNSMHBuUFBDRjh2a09sM0srVEpFR1l6T3dlamZXcjM0VEZy?=
 =?utf-8?B?dVI3aDZ6aGZSWnN2d3FlUGtGcWhtcGpQTWNWN2JiSFdsWlNGOEQ2TTN2V0M0?=
 =?utf-8?B?Q1Bod2puUmQ3WnQ3Z0h4MWF5N05naDlpdFF5SW5MWW5jNG4xczBRRUtSblJS?=
 =?utf-8?Q?gD0nSOcdQyAiCVRh+g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a51f7d-c556-4420-2a76-08dea1d6fcbf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 07:56:27.0591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yHnvy7/gV1lsr8iRkL1ZFfLZEjHYbGw2wOg8trkR4KMWvq3PWoA2oVfCOWzlfemM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6861

On 4/24/26 07:47, Mukesh Kumar Chaurasiya (IBM) wrote:
> When building with LLVM=1 for architectures like powerpc where
> CONFIG_DMA_SHARED_BUFFER is not enabled, the build fails with:
> 
>   ld.lld: error: undefined symbol: dma_resv_reset_max_fences
>   >>> referenced by helpers.c
>   >>>               rust/helpers/helpers.o:(rust_helper_dma_resv_unlock)
> 
> The issue occurs because:
> 1. CONFIG_DEBUG_MUTEXES=y is enabled
> 2. CONFIG_DMA_SHARED_BUFFER is not enabled
> 3. dma_resv_reset_max_fences() is declared in the header when
>    CONFIG_DEBUG_MUTEXES is set
> 4. But the function is only compiled in drivers/dma-buf/dma-resv.c,
>    which is only built when CONFIG_DMA_SHARED_BUFFER is enabled
> 5. Rust helpers call dma_resv_unlock() which calls
>    dma_resv_reset_max_fences(), causing an undefined symbol
> 
> Fix this by making the function declaration conditional on both
> CONFIG_DEBUG_MUTEXES and CONFIG_DMA_SHARED_BUFFER. When either is
> disabled, use a static inline stub instead.

Well we are clearly missing something here, but of hand that doesn't looks like the right fix.

When CONFIG_DMA_SHARED_BUFFER isn't enabled then the whole dma-resv.h header can't be used at all.

So you also can't call dma_resv_unlock() from the Rust helpers. Which means that we need to make the Rust helpers somehow depend on CONFIG_DMA_SHARED_BUFFER.

Alternative would be to provide dummies for the functions in dma-resv.h when CONFIG_DMA_SHARED_BUFFER isn't set, but that looks a bit like it just hides the issue.

Regards,
Christian.

> 
> Fixes: 0c6b522abc2a ("dma-buf: cleanup dma-resv shared fence debugging a bit v2")
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> ---
>  include/linux/dma-resv.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/dma-resv.h b/include/linux/dma-resv.h
> index c5ab6fd9ebe8..23c8db0b5214 100644
> --- a/include/linux/dma-resv.h
> +++ b/include/linux/dma-resv.h
> @@ -311,7 +311,7 @@ static inline bool dma_resv_iter_is_restarted(struct dma_resv_iter *cursor)
>  #define dma_resv_held(obj) lockdep_is_held(&(obj)->lock.base)
>  #define dma_resv_assert_held(obj) lockdep_assert_held(&(obj)->lock.base)
> 
> -#ifdef CONFIG_DEBUG_MUTEXES
> +#if IS_ENABLED(CONFIG_DEBUG_MUTEXES) && IS_ENABLED(CONFIG_DMA_SHARED_BUFFER)
>  void dma_resv_reset_max_fences(struct dma_resv *obj);
>  #else
>  static inline void dma_resv_reset_max_fences(struct dma_resv *obj) {}
> --
> 2.53.0
> 


