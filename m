Return-Path: <linuxppc-dev+bounces-19909-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7923CF94CA4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 18:11:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0VmN0rtMz2yvM;
	Wed, 22 Apr 2026 04:11:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c206::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776795092;
	cv=pass; b=ba1prW9tk9wFatfhZA8dGsjH33bHvTyFLNSTRBlKlBbE7EOBG+LtWD7YnnPUmQC9cot9Vim7EuDE2Sxed/CwmWw6Uz6To5V/H2Rse8O4hRu8VtEBvA76e0UEjBs3YAg+eSFN6x0v6BXHNb/ndR4gb53xj+SrZkQlZE56G0yAxbKWhcsIE3Lln1kwRbPXCbL4UK4DSblzTQIlU0AAFMYCGxDcSboTrICH6Z3xDpQdLk/V51kt8nD55//XErbPFfYn41vbNa4JT6ud8nEzmyR1XJ6ZXkQz0Z5c9Drl4tgRXvcUtmehVXLZsxysIVQU83TZVVb74v2caLat1QYXhzYwbQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776795092; c=relaxed/relaxed;
	bh=O6FWE/YDZ3qcTtyJFfrPXP1pV5QvG12uv5P8DLfLb58=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=lJcZrWXybejVKvFbNLfVhUBBG3Q3AAGheCbpDCa/Jl2V2dUH02DQlwvLoTjCDJyQuc41CetRmvCiSvmjjw26FYiKRnlkvCRU1qxlHA425Y/e2x+NmZry7Z3TIY4de5jmuNSWLCcQbgTlmKsptu4gquXsEsXFQYbq8Wjo6ZVJ8zvGKmyNm3fxmqIXKk2JbHyM07pqFhJdHG+9WWu+Qfmq1BP34J3LgLYn1gMMDioXoCOx3i5k/hLZ+ibYzQD3WCq3kCbZ+mY3868XokVjAjJBPpPtZ92lzuMWZUgM1Puvzgk8bOUeZ9OItQJD5blNnQBY9PW/K/MphpB0KftY5gIbOw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=xvl3twRd; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c206::3; helo=cwxp265cu009.outbound.protection.outlook.com; envelope-from=gary@garyguo.net; receiver=lists.ozlabs.org) smtp.mailfrom=garyguo.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=xvl3twRd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=garyguo.net (client-ip=2a01:111:f403:c206::3; helo=cwxp265cu009.outbound.protection.outlook.com; envelope-from=gary@garyguo.net; receiver=lists.ozlabs.org)
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c206::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0VmK6ZJtz30Kg
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 04:11:29 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jDUKnPCgDdO0zPZu+pM0cPrbNfOjNAuq4pzy1IAF22y+zkA8HUAxtkN8c8i3hiui5IuIDEOsZFhx1cG7wLtokHwLxsyAnY6NunAx67zV9svw9hAuaxpHiUAOuQdencsvBGW91vsuVwvuxfBRf3ANGSGxR+fnpI3iBnhV/rA7a5eIzvfbbNTvlht8Ws4r0lv2dDQGLlpTYXhHnOI4WkDo65Z9PEbkm1ZZt6YoFLR6hALl00SjSHjUPRT8PsdvCyfS8EHLlOXrLFZVQ9dRc7lLyeyDbHOb+11ZipPkkk/riFTNqR+Pnn3uNaSl4232lCG5Q5F+4uVI8R4wWwpb54TUWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6FWE/YDZ3qcTtyJFfrPXP1pV5QvG12uv5P8DLfLb58=;
 b=lc26kz+zwdGLJxaogek5DktTTpYix1hqmfqBNBOvVw+OSGmTiEJ+Qw9kX0gHF/onpp+2Pd3ZzRWHaaMdlVtfowMQ8zezZMyLpHYzAvEXgY6OhO5Bfm4Ij3wMpzeQf96k+PToQEwHOxxk93i5zx6HA7R3VldMJdkLFr5F6vuC6vfh6KpeN0aj3qBCT8INozUnFPOf+k+THxpGj5+egke7yCd5Vkh6bQEeSKKCxrBQq+JKQIwceLgGhxQtOXrYnwtEpdRpx/34okq6j/KE8Gn5KLh5xa+/3HxQMy4kWGz3cJWK+YZ5yfToE/nGNfLUZUjU031TWrF6UHZPg/fwV+o4Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6FWE/YDZ3qcTtyJFfrPXP1pV5QvG12uv5P8DLfLb58=;
 b=xvl3twRdcXKZpO7IqYylJh9fzWboPaISlpi7NQJ5TAMsfTXma3ROybKnwxBgPhM5VlHZBdkbp7600bvSkAEtz9ani3qSfPqrEMaLaoUYTA3zr/Nt+IsaKREmcLNcpYPAvWtX2owixjZN9idQZLRUyL/ssrxjObpsLUX4GImEMX8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB6662.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:30b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 18:11:02 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 18:11:02 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 19:10:59 +0100
Message-Id: <DHZ1A60MCSWV.2M1KPNR0M6DJ3@garyguo.net>
Cc: "Link Mauve" <linkmauve@linkmauve.fr>, <maddy@linux.ibm.com>,
 <mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
 <peterz@infradead.org>, <jpoimboe@kernel.org>, <jbaron@akamai.com>,
 <aliceryhl@google.com>, <rostedt@goodmis.org>, <ardb@kernel.org>,
 <ojeda@kernel.org>, <boqun@kernel.org>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <dakr@kernel.org>, <nathan@kernel.org>, <nick.desaulniers+lkml@gmail.com>,
 <morbo@google.com>, <justinstitt@google.com>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <llvm@lists.linux.dev>
Subject: Re: [PATCH V11 1/4] rust: Fix "multiple candidates for rmeta
 dependency core" error
From: "Gary Guo" <gary@garyguo.net>
To: "Mukesh Kumar Chaurasiya" <mkchauras@gmail.com>, "Gary Guo"
 <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260417152253.2312961-1-mkchauras@gmail.com>
 <20260417152253.2312961-2-mkchauras@gmail.com> <aedFgEicDW6LAcuq@luna>
 <aedJGuF9P2V1lOCZ@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <aedQ629D0x-5KuKw@luna>
 <aedpk1iaeYyKPSOI@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <aeds6_8Mr_w38oYI@luna>
 <aeec_IzVJwlfarN5@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <DHYYG7A745M5.VQY4GMDJNC1Y@garyguo.net>
 <aee3ivM9VkbqdQby@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
In-Reply-To: <aee3ivM9VkbqdQby@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
X-ClientProxiedBy: DU7P191CA0027.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::29) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
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
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB6662:EE_
X-MS-Office365-Filtering-Correlation-Id: 64e9b724-608c-4652-2cd9-08de9fd158f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|18002099003|22082099003|18096099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	gm3v4K18qqqF5F9Q2jhudtYVUdOc53j4iW9lcrIpdl6hG3e2sVZ74cq3dHi8o3AmlPjhnfKmXFqQtPbVWKWhxrqsCFrWLB5Pqd/+xOWfPueiyZqITw54NjvVNmBncpyRpnThS2+u7XSPeNql5Vz/Bni3T4AekyxPmV9kdvgKg5SH//DHkM4U6qa2gcmmgR9CP1OZSAsZBGFQ4p9tz+2KQMbCx2RXommSjK6G+O4LjDQiFTXMLjwodHirBhglFvCspStbUeMrs149gK7z2wXMyqZNvTFzYi6LgWIWiPJMhhcp+7949fWoSKJHRwDJeoh7swZ0k4YBGcRsZhrXhjEF7idnS3NqrLxL1Sc4WxcTxuG+YjnsalX2oANzIJjFE/8ErxlYeXlwqi9q3oG4mIrUxBUbwsLAkbjWH8NSR/ynrZCFuSYs+22RbnIr+gBllWGYxdm4Y+fPGhLKnkZzi8yiq8LQnJBQpFy5RAmO098/bhTR7J1rOtlxt+opf2xVZT7PgAtGdHFN/Z5lN0jIPVwJTWv+yU/bAYZR7fEyfdBh0RKoyqXLLUy9niXs0ROl19BW69aCffrwJ0OIGYepiAY3fsEgpYQh7VzsWyo2lB/pkcvjv+EE7LuGwoZuzA35g7G6gphSX/pC9iJIdGLnt6D86zCzi/7cdGAEutwnd1t1+dBm8IlVrwtf2VYqDO7b9aLcRMpTEiZvUD892wgBaqb44mKvRpbxYaJPI99xXSC8bfs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(18002099003)(22082099003)(18096099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXpvc0RiR2h3a1U2RjJXZ1B2S3k3TEFBMVpaZHNHVXNpcE9mWGx1TWpFc2Vm?=
 =?utf-8?B?ZFdHNkdyeEc2VnFOa0tEK2xxVkRCa3FZdVk1Q05aY1JPWnFIRXh6bGxZL3Ix?=
 =?utf-8?B?MHZzZEN3bGdKZmdWL0RWOHhFWFFXdm5BeU9OWm5iRTNHRlZVbGplcWgydnBO?=
 =?utf-8?B?Qjk3REQ3VXlDYmd2bXRSREJDUUFWOEZIZzBwUHRmNVZFSXd4aGJtcVV1WXkx?=
 =?utf-8?B?eHI1eXhrNXNwWnlVTjNSd2I1a2ppS25oQ1VkNGNZb294MFRqSFdxVWtjQVJn?=
 =?utf-8?B?cmFQSlNlb1QydGd3NUtIUDFpZHE0ZlEwbHJpazJ0ZU1HOHc5OFlvZW5qU3Yw?=
 =?utf-8?B?aVpvT051MWtSMU5heDhIdm9BZnFlenhFYW51ODNrZ0ZvUlRpM2J3MWpCY3R5?=
 =?utf-8?B?dk44amh6SEhuaXpuQ0czdmtHTm9BZjdSam0vYlVmUzFSMkNCNUg2bjN5d0hB?=
 =?utf-8?B?OHhhUHhoN3BaZFIwYWhWNkYwMjV0MUhpS05lOFZKcWJCMXNGL1hHZi9yK21J?=
 =?utf-8?B?djhlZm5yWjlzWTFEU2ZDOFk0cHVIaUVuRktYc2ZweDJGUm9ibDM1OFBidHow?=
 =?utf-8?B?UVNvUDlUdlljTGNIVUVZdUlCMGNveWl4ODg4SnQ3dzRZbjNoM2R1NUNsREp4?=
 =?utf-8?B?SU9RUk5NeVNocEh4eDV3YlY5ZDRaNTEvK1NKUktPQXp0MzJoZG82cTlmWVc3?=
 =?utf-8?B?czBkWjNYYURmSjcwbGl2cTN6cGV0bTZVaHR6U0NMUmN5THRtVW5sSEdGYUdi?=
 =?utf-8?B?VEIrbXh2UVFsdkx6SWlqQ2dIV2RUV2dVWnp3d3BTOG0xVmMzbXJmTFZHQlFL?=
 =?utf-8?B?aUVjdUQ1b2NTbDJqZ2JrYzM1QTFXMGFqK3ZpRXdadkxaNDBvNVN4OFYydHVD?=
 =?utf-8?B?RHJ1Z2JQZ011WjdUbExQSmtiUk5BWmxlaEFqZVZUN1BKSW9WWksvaUlTVUJX?=
 =?utf-8?B?UHZEcTV5UmdVOVVKQU1TdW94UlB0NVFhQ2xFcXJGOEFia1RtT1pCT0QvL2p1?=
 =?utf-8?B?Y0N4ZENkWkdrQW1PS3N6ZTFodWtyL1cxd2xSVm1UdDFoUTZqaCtQNW8wK0sr?=
 =?utf-8?B?N2p6NG9FWDZycGtLa1U0bkVrREZVQklRcTkrSzhsR0kwcHY0eFpRczYrOEF1?=
 =?utf-8?B?ZDlXMGs4UWxwcFRLVzlQQzdISUN6dFVJMnBUWjhPRlB2azRzV053WWZ4dWJw?=
 =?utf-8?B?cFUvYnMxYTIzUDBMNzFuZmp6aUY4V0kxTnFtSkJ3a0dtNVRuL0RJTFVRaGIx?=
 =?utf-8?B?OU56VXlLd3M1dGdERUdvNTRBNzNPQlBUd3RGUGwrTFlQQmpyUC9IYldJU0o3?=
 =?utf-8?B?SWFzbVYvdE5qcE8veVlFMVY3Zm9wSU9UWk4ySzY4endlS1Q1dHZ4ZGZhK0J3?=
 =?utf-8?B?K0R6UEp6RU5xTUlkK0JxZnhZdWpGSXdaazlKamRKRjVRNXFkWGF4M3F5eE9T?=
 =?utf-8?B?dmp2VHhPR1REZ0FWSk1ZM1psVDdXSE9ONTdLYUFZdmsxNDFqNFYzRnBMVVBM?=
 =?utf-8?B?TlM2ZUV4bWFhZlp1aSszOVNiRUozQVJtY1FYZ295RVMydi9McG80NVdxYVox?=
 =?utf-8?B?aVFWcU5xMTZGc1BSZzlrNk1WaEI1dTVzbDgza0F4UkJoVXlDM3Z1N1F6bUZV?=
 =?utf-8?B?RWg0eFRDYXBZL3JJR0p2c2s5OWVOQ2pBYlZGNXFnMXlQRHk5U3M4anNsMWhD?=
 =?utf-8?B?THE1WitnMy9HZ2lvUFN0ZW5BL0ovYVJFY2Y3d1R2VHNrNHFnODVqVkt5T3Ar?=
 =?utf-8?B?UkdMR3pVN2pMVXpKeHIweUs3QUViNHdwZm9uUFpPQ2hEaDdSVE4raDVaTTBy?=
 =?utf-8?B?UllGQWxpcVJTZ1VPM21uZ2hFRXBralVSQTFQME1OVitubnpoYXpqb3VrejZa?=
 =?utf-8?B?NDNqaU44NEZmV0JjWE0raGxNT2RFVndEdUcvSEpXdW9YYU5jNkgwU1pab0VQ?=
 =?utf-8?B?eFo2bEJNaGJ0UExpcUdUOTQ1ZFBjVmhQeGhHbGw4d0loTmFBK3FXQUV5djR1?=
 =?utf-8?B?Y1FxZFVMTXd0YUZiSzJvaE00QXZWRjVHRGM2UkY1UW05V2tXdnNMVS9scFk5?=
 =?utf-8?B?QXV3WTR5UDhLcDMwR2FPQmI3SUhsTmFSbDNnOW1DQTJ0clBCSTlLa0c2OFdG?=
 =?utf-8?B?QzdxNW4yb0hvR3plWGYxbW44cml0VXM3cm9MN3g4NFF6UEIwbG91OXFIWExp?=
 =?utf-8?B?T2NpaWt1ZkhsVHhRVFkyRkowYjZ6VlYwOFQxL09aUDdTMlhodDFGWi9aQVZ1?=
 =?utf-8?B?bXpubzFyTy91OGwxbENKQUdvWkVJL3g5R3M3Ri9tdzMrazRpWmQ3NTIrNWVm?=
 =?utf-8?Q?6gRMlaUma1XFcF8+y0?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e9b724-608c-4652-2cd9-08de9fd158f5
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 18:11:02.3545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TVlhM3vS3qVvK+TrqkRjdUfRxvFYrjbdo+r7nUBR+3P2HfY64aHvGL6+5tuTy9PYXDTPaM1NANbFbEyClRwEZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6662

On Tue Apr 21, 2026 at 6:47 PM BST, Mukesh Kumar Chaurasiya wrote:
> On Tue, Apr 21, 2026 at 04:57:49PM +0100, Gary Guo wrote:
>> On Tue Apr 21, 2026 at 4:53 PM BST, Mukesh Kumar Chaurasiya wrote:
>> > On Tue, Apr 21, 2026 at 02:26:19PM +0200, Link Mauve wrote:
>> >> On Tue, Apr 21, 2026 at 05:49:32PM +0530, Mukesh Kumar Chaurasiya wro=
te:
>> >> > On Tue, Apr 21, 2026 at 12:26:51PM +0200, Link Mauve wrote:
>> >> > > On Tue, Apr 21, 2026 at 03:25:22PM +0530, Mukesh Kumar Chaurasiya=
 wrote:
>> >> > > > On Tue, Apr 21, 2026 at 11:38:08AM +0200, Link Mauve wrote:
>> >> > > > > Hi Mukesh,
>> >> > > > >=20
>> >> > > > > This patch doesn=E2=80=99t apply on top of mainline, which tr=
ee did you base it
>> >> > > > > off?
>> >> > > > >=20
>> >> > > > It was on mainline v7.0 tag.
>> >> > >=20
>> >> > > Great thanks, they do apply there!
>> >> > >=20
>> >> > > I needed three more patches for the kernel to build on PPC32, I=
=E2=80=99ve
>> >> > > attached them but they are absolutely not patches which could go =
into
>> >> > > the kernel (except for the second, enabling asm_experimental_arch=
).
>> >> > >=20
>> >> > > What do you think we should do about them?
>> >> > >=20
>> >> > Regarding the 2nd patch you sent, As the support is experimental as=
 of
>> >> > now, Let's wait till we get everything stablized, till then we'll u=
se
>> >> > nightly build for all variants of powerpc. Once we mark it as
>> >> > maintained, then we can try to push that patch.
>> >>=20
>> >> Enabling the feature is mandatory even on nightly or with
>> >> RUSTC_BOOTSTRAP=3D1, otherwise no asm!() macro can be called and so t=
he
>> >> kernel crate can=E2=80=99t be built.
>> >>=20
>> > The stable support is available on nightly.
>> > Refer https://github.com/rust-lang/rust/pull/147996
>>=20
>> In that case you should add the feature with a comment that it's needed =
for PPC
>> only and is stable in 1.95.
>>=20
>> Best,
>> Gary
>>=20
> There are some other build errors apart from this on 1.85. So few months
> back in the meeting with LLVM team we concluded that for sometime
> powerpc will be ahead of other archs at 1.95 till others catch up.
>

Is that LLVM 22 being relied on?

If that's the case, you should also gate PPC with CONFIG_RUSTC_LLVM_VERSION=
.
It's possible to build a Rust with older LLVM versions.

Best,
Gary


