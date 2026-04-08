Return-Path: <linuxppc-dev+bounces-19510-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C721073CBC
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 14:01:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frPqK0qXFz2yDk;
	Thu, 09 Apr 2026 00:01:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c206::4" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775656861;
	cv=pass; b=eUz60tZrPTnOES6XrkIZz2j2tlxCmtG1+nRxWih+6PnXAQS6G2sFEjcl35/wiH201kljqmRp/1gSOr1rRWbhzk0TTuJB6Fgq4Fwck3SsatUX1ZMFL94i6burEUjKTo467FIv1AbcTiH2tmp0nocRmZupozGbN2zn9Ofv4W9/fqtNsYQlzSbXaki0IZGINi356hL9Cw6ZbQYSe6w7a+DYHYqecJkS141v8Ja/6kOgM4V8dB7WfOlayKQRHfrXnYow7RxOpMwkWyTfbMdPrMQIYen6PFv5uMHUqspoNkC+32ByvKB5Ivx2M1Ev+0dSmjv7SnB6/32NkdeDfNBguUJHDA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775656861; c=relaxed/relaxed;
	bh=3xwVmlwYk98XkLTpJflEEK0raTs9M4E/D9PMKVNauPU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=Mcjp5QCTmG45s/tBWHrd0EGJEuR2mxC8nNK9BX8AL+lQ6hlN6wbhifRS06OFO818zfmAGTyPQ5ohAAg/q4zrv3pnHL3LCAqzy9HT+EthzPcL9jEI3aACNDWeTJoshpa8byfI2s+YNNQmpxKblNG6kvMzhJ968C/b7ChC+Gw1KBUcWqnPOUEvwweczQrUHLeOpCsbV3cG4kOCMFRfencGkQ7YzTbYqFKtQ1UVxjAKDkwINhAqfoCJuOph0gjIsGsQYWoeU4HbHCuTQ9xilXEvmnjHZGXpg2TqUwf/5XEojiXKcnmr6QPT5Q+cZNdQlewXKteFQoF1t+FzmTfinOdNew==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=GlQcsogS; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c206::4; helo=cwxp265cu010.outbound.protection.outlook.com; envelope-from=gary@garyguo.net; receiver=lists.ozlabs.org) smtp.mailfrom=garyguo.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=GlQcsogS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=garyguo.net (client-ip=2a01:111:f403:c206::4; helo=cwxp265cu010.outbound.protection.outlook.com; envelope-from=gary@garyguo.net; receiver=lists.ozlabs.org)
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazlp170120004.outbound.protection.outlook.com [IPv6:2a01:111:f403:c206::4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frPqF6FC7z2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Apr 2026 00:00:56 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QqoOtGSGbQhCN9Vlb05DzhqXvgvD85kT1wLMHrxw6l0aGirA4Q5CLrq+6d/XB23S8PgFDiZ0DbYtVuQRtjuGRW5jpanhtxOsGuY4V9I0AF54hItXY3YTM7YSOKRb+91uSig2n7kwzlwP8ObbLvgbuJlUqyePYHulJaB+rP5zgdirLskTVtBPzgxLisaaqNE+maqqupZmvriLOYdnDIKitp8Rql9RU4guNG3QwO5F+LcbSal3qdSL8byahz8XQ+4Xat8pvTZBO9ieEcLiaeCXvUYU2Nsj/xtrp7vhOq+flsCrAFqUMS2yFQMskNHLfAI4NxYuudFJVTBYDYDykQwOCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xwVmlwYk98XkLTpJflEEK0raTs9M4E/D9PMKVNauPU=;
 b=J9M/Ceo7YEajCCmBZO+xffC7aFRd8bIQfiZMDuQlG0mIEPg6ldUK58MHLxHlR2bEcVMKZwKiY+9H77NYvKAdJyEQdZTJKS1qd68yUIBYeO5zf+jEtn7KTdouqtIgLs7rXXlTO3XAl5OSMsADc1pGLSxlvQtAIJTkXMwBggeCHnBZErTd7/QAryihgwd8gJ8f4/XiMu28F4bmB/du4lHj5/YxCMrRidK/mpTcRss7yDfx4wFccb5VIFfAvTVr0VeL6QZA9xmpOBMGZosOdBPIMKz1R44LtIiF3PFpPPjJ72NElVluvb8Nnzp61ygOmby8vPQwmRrMInwL240/jPvS9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xwVmlwYk98XkLTpJflEEK0raTs9M4E/D9PMKVNauPU=;
 b=GlQcsogSAi2v8aTz/3YA2cSHXNcG7HGlbD0Nmh0b37jjKDTakZdbaOsIASMxCnJ38M7VXVgywQSvt5vKrlC2zw5ELVSYfbFRJT8DgLMEgDorsKXCcl8ZcKv/NUCpD8F0RijBmWKZi+ZK4ksN87DokaRYma7LtwHZr6lUSrXwGkU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB2804.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 14:00:24 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 14:00:24 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Apr 2026 15:00:23 +0100
Message-Id: <DHNTT7LIVLDL.5FC5I1FES8IO@garyguo.net>
Cc: <maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
 <chleroy@kernel.org>, <peterz@infradead.org>, <jpoimboe@kernel.org>,
 <jbaron@akamai.com>, <aliceryhl@google.com>, <rostedt@goodmis.org>,
 <ardb@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <dakr@kernel.org>,
 <nathan@kernel.org>, <nick.desaulniers+lkml@gmail.com>, <morbo@google.com>,
 <justinstitt@google.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <llvm@lists.linux.dev>
Subject: Re: [PATCH V10 0/4] Rust support for powerpc [RESEND]
From: "Gary Guo" <gary@garyguo.net>
To: "Link Mauve" <linkmauve@linkmauve.fr>, "Mukesh Kumar Chaurasiya"
 <mkchauras@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260406200149.3727922-1-mkchauras@gmail.com>
 <adYlLLfRgSyxus3n@luna>
 <adZBWoVVoJefiTcM@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <adZV_VISz8DNraug@luna>
In-Reply-To: <adZV_VISz8DNraug@luna>
X-ClientProxiedBy: LO4P123CA0114.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::11) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB2804:EE_
X-MS-Office365-Filtering-Correlation-Id: 01ac8114-17c5-4b89-085c-08de95772e4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	t3O1HWzSMfVYuYyeTOXwkqnPfWTVy4MAHbfxXvln08wpcGRXtGu8NvGkagj+9MUSS2GeHMUNsxedj47tHnK1wkaycEnl/v9UowtXezEWvD9u6OmY2fdZsLCLcg+4fIRUk4wJo9D5jaB2j7Y9H04J2ZxSRMSzguAHuDEq4BGc7xYA46or3uxMX2cb/NABMCqqgH1tvD33Xw8cLtEAQkqS1iW9DHuLaEm6+rYB6++OK/LDATgaJlLqfx2aVbHRs9B5eXoj5kiJ0tqk24zruRJqB3wa71R6YPRzt4maXirFXwbOlDh7PoceDaYcY2U2TI2VvVxIBY53NRa4crcpM6AzeZ+1UNZ4zUG3lTqpgPUA8bv57GmfWWKeh8IRr8O98ZFTKcfIrBgf8YHikKR7eftfrILwWIQs6UMstVpx/j+fnMkFMz6R4oPvYfPyXy6LyF44j6mbcpSW1CV3KuFLSGqzdyv3hBcEx4e+N0x3ynRWNucwYEe639uCNP6M8IpA9CHX6QZngYuMW/ocvTBvVLYeC8daFq3WWpngclNJMJOY4XNRnsHw5m9116c0oVtBtKGVlSf7Q7drYQJRIdD0uoRB1HSo2Xh5KdbnAeutTZpK/LRXjaMi26CFm8QuzTPEX0D5dOgw4E6ugVWspE38+Bi4ObB6gNhtKBQ2o1jxIHhMXFD6PzSYUR3RT4Bk/nt6Dcv4YddeUhVZKThd7W9V8fRRKiOWKuP38j8ia66f2nYZPQs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2NRUk5BWUhwVE54MVVOYU5FNy9MK1g2Y0VDZFFWUVArMjhjeGlmTmh6Z0VM?=
 =?utf-8?B?UjM0bWlpSll6QndyQ1c1Tk44TTRScnlaclBWWGM4eTY5Qm1WWjloZ2xCSVNR?=
 =?utf-8?B?cUhNTGVHbGtIT0ZrZXFhcElpS2haM3RsNWNsKzZIcEZKV0YrY1lSYmhXa25F?=
 =?utf-8?B?eEZmQmdUVUM2aVYvTE5hcjRPRVJIOVorQkRKcHdPUHBWREpHbWtWYlAyOUVB?=
 =?utf-8?B?eFJJczE3dHpKR0hqLzB3cU16cXdjUnZ2bTFSNFowK3pkRlJKOXhoN3VXNkFt?=
 =?utf-8?B?bFA3L2Nta0hhQXpwY1lJZ2VxMVFybk1zb3l5QkZnVTFSOU1tcXVLWGNoeW40?=
 =?utf-8?B?S2J6OUZnRzViSG9NNlZCZ3hqOUZRbHJQUmhqaXU5Yk9xVER4RUN0cGIyVXdy?=
 =?utf-8?B?S1UvbjhuVmxnend6WUJHNDArSjBvdTVrZEtCZW1ITUlNT1NSTFBmZE15OXY2?=
 =?utf-8?B?UFlFRnRQOVRJSFFjTFJOVDAyMWxrMEdHcHdXWXFYUkU1NFdBNHIydFJlaENC?=
 =?utf-8?B?K1BWUE84emduaWxuSEhURGNzQUNTWkk2bFoxaEM3Zi9pd3NYTWppUWdGSnlY?=
 =?utf-8?B?TlJoRXN5QmRFV09BM05TZC81NUwxdlg2SGxNUk1kSWdXSnR2K2JIcHhaOGdx?=
 =?utf-8?B?U0MzLzFHNU1MNmVLMlRacWlzWEpSV0hqdDdYbGdIN0VxNmY5U1NuekRwRVlE?=
 =?utf-8?B?cktHMmMrQUQvOFZrVlowa1g3WFRjTGJZd3hNaGRtOE1oeGVFSWYrQm5OaGlm?=
 =?utf-8?B?b2xQRTdHRkZYWGpuOUxWSitqOTZsSVdaMzE3QS9GTC9rWXF6cUdlQVFOaFp2?=
 =?utf-8?B?dG41c1AyNXloRU5DSWVRSjc4YkR6N0l5YmdrengrVmdBZTQyYjNucXYxejZi?=
 =?utf-8?B?S3FYREREQ1NQNXg4TmI5TVhCUHdaVUs0Mnlxb3dvcmhqRnRUQW5hVXdTM28x?=
 =?utf-8?B?N2FSNmltMkhUeXh3TTFqbUc3TnZWL2VuZWFHL3dOM0l4TEFvN3dqSksxQlFC?=
 =?utf-8?B?RENsV1M2Z1dPTWZjSnloOGJ4K2lvNmV4MmFtZXNXL0IzR1BlUWZsZ3hLWEd4?=
 =?utf-8?B?MzlLci94NEdna2w1WHpIRW50MVN3cEdrMlR2NTFESzQzblZDT055ZnFjeE5M?=
 =?utf-8?B?dmJzeVZsNndsbVNTS3FNRVVZM2tXaCsra084THVoc2kxcWROQ1pUQUNPTC9X?=
 =?utf-8?B?WlFZVUQvM09ERmlsaEQxWEhTTWM0Smp2TGc0RlZJaW5sWmJDNUo4aGErMnNY?=
 =?utf-8?B?OUlHUEs4bS9NelY5Wk92UzU5ZDd1ZmovMisvdFdORnRTM0lMMmluUFZKR1VY?=
 =?utf-8?B?NldZNkdLN2VPUWcwbjVqc1QrcGZTSXhidnpFR3FRRjdkbk54VHZQdTVJdi9u?=
 =?utf-8?B?Y0FZWEJPOVVsNGEwSHVST0ozcGl3YUlqdk5RRDkrWXVVUXRidENYd0gxbElH?=
 =?utf-8?B?dHNXQzB0SUVOU0FCN2lZUmRUclVnWS9PUzQ1SWtGWVY0OHlVTVpXWHRuMjVu?=
 =?utf-8?B?c2tvNHRPVzBaZFV4OU5OZzhpTWFxRmNvMDBZQTlLaEpIYmM5cDRUK1RYS2l5?=
 =?utf-8?B?dFpIcEN5bWJ0eURlZXRPWHFrSlR1T3BhRXIzSGtsdkZWT0pnYmV4WGNMYzU2?=
 =?utf-8?B?MFFhd2dsWGhSb2o5U3kvc2FKRm5xellwalRmMHNnSy92TG4zVldBbFNUYUo5?=
 =?utf-8?B?MlRVZTFjWGZhTDkxVFFZUHhZMFFFYVZmS2tTQjRuQ3kyVTRnbC81Tm1FKzNs?=
 =?utf-8?B?a0YveEo4dlRVZkdoc0lXRW8zU2JBYitVVjlQRmQvalFiMVRkMTBJK0RjS1JH?=
 =?utf-8?B?a1E5Q0ZJajlBUDQwTTI2QkZNVElDSU1UQS9Sekx4UHFwUkdoS2lrVWVWYzlC?=
 =?utf-8?B?cWpiWkFvdytXMzdRek1SaEF1TmR3WkxvY0pnbEFlWGRKMmI3QlhqRnpVM1Va?=
 =?utf-8?B?RVI1dU5pS01iVjd2S2ZST0VvY2w3Z1FEN2dzSHFUUnBZNHgwbUlHTEZ2Zmhq?=
 =?utf-8?B?ekxKd3FFZUdZQjcrYXNkaXlGU3AzWFV2dStTb2xyZkR3bHRsSzQ2S2VxR05z?=
 =?utf-8?B?MEVTRkxRelo1R2FQN240K2k0WjRQd1VkWnF1SUZWN01KSENCS0tuWnJRbWs4?=
 =?utf-8?B?OTRoYWR5RUJoNDA0dnBoN0ZQZTFGSnF3dHBCRjduMW04Q2krNzJwQ3g4ZXpW?=
 =?utf-8?B?UGdvdHl2YS8wNGs2WnMxaXBrampFVWhTYUUzUWZybzUrWmhvWTF4MWRMNVMv?=
 =?utf-8?B?MjFEWU9KVHJVb0h6QWgwT0Q2QXREWElZd1JWQUw2cXBEcG11cmNlTDEzUk1K?=
 =?utf-8?B?bCsyaFFmcGhycnd5N0Q4ajJodGNEVHdjR2NJbmlyZHhZTy9DMXdDdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ac8114-17c5-4b89-085c-08de95772e4a
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 14:00:24.4519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQ9p79VK1EMrrWmeJHP+cE0Z7HFh0iDDcZ5BBaWALBf/iteLjkJgOiFCfRcZ21LQ5Y5HvXF7sBkubO8uHfjxgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2804

On Wed Apr 8, 2026 at 2:19 PM BST, Link Mauve wrote:
> On Wed, Apr 08, 2026 at 05:23:39PM +0530, Mukesh Kumar Chaurasiya wrote:
>> On Wed, Apr 08, 2026 at 11:51:40AM +0200, Link Mauve wrote:
>> > Hi,
>> >=20
>> > (This email is a resent, my IP address got flagged by spamhaus again
>> > because I=E2=80=99m on a residential range, hopefully this incident is
>> > resolved=E2=80=A6)
>> >=20
>> > On Tue, Apr 07, 2026 at 01:31:45AM +0530, Mukesh Kumar Chaurasiya (IBM=
) wrote:
>> > > Enable experimental rust support for ppc64le and ppc32be. The patch =
for
>> > > ppc32 has been provided by Link Mauve[1] and ppc64le support[2] has =
been
>> > > merged over it. ppc32 needs some toolchain fixes mentioned in the pa=
tch
>> > > `rust: Add PowerPC support` and the discussion for that is done here=
[1].
>> > >=20
>> > > This has been tested on
>> > > - powernv9 hardware
>> > > - pseries P11 hardware
>> > > - pseries(9, 10) qemu
>> > > - powernv(9, 10) qemu
>> > > - rustdoc on x86 and powerpc64le
>> > > - rusttest on x86 and powerpc64le
>> >=20
>> > I just tested your series for the Wii, so targeting powerpc (32, be),
>> > and got this error:
>> > ```
>> > error[E0463]: can't find crate for `pin_init_internal`
>> >    --> ../rust/pin-init/src/lib.rs:365:11
>> >     |
>> > 365 | pub use ::pin_init_internal::pin_data;
>> >     |           ^^^^^^^^^^^^^^^^^ can't find crate
>> >=20
>> > error: aborting due to 1 previous error
>> >=20
>> > For more information about this error, try `rustc --explain E0463`.
>> > ```
>> >=20
>> > I didn=E2=80=99t get this error in a previous version of your series, =
would you
>> > want me to bisect them?
>> >=20
>> > Thanks for your continuous work on it anyway!
>> >=20
>>=20
>> Hey Link,
>>=20
>> Thanks for testing this.
>>=20
>> Can you give me the command generated via make with V=3D1
>> e.g. `make LLVM=3D1 V=3D1`
>
> Here it is:
> ```
> % make ARCH=3Dpowerpc CROSS_COMPILE=3Dpowerpc-linux-musl- O=3Dwii W=3D1 V=
=3D1 -j1
> make  -C /home/linkmauve/dev/linux/wii \
> -f /home/linkmauve/dev/linux/Makefile
> make[1]: Entering directory '/home/linkmauve/dev/linux/wii'
> make --no-print-directory -C /home/linkmauve/dev/linux/wii \
> -f /home/linkmauve/dev/linux/Makefile
> ln -fsn .. source
> # GEN     Makefile
>   { echo "# Automatically generated by /home/linkmauve/dev/linux/Makefile=
: don't edit"; echo "export KBUILD_OUTPUT =3D /home/linkmauve/dev/linux/wii=
"; echo "include /home/linkmauve/dev/linux/Makefile"; } > Makefile
> test -e .gitignore || \
> { echo "# this is build directory, ignore it"; echo "*"; } > .gitignore
> make -f ../scripts/Makefile.build obj=3Darch/powerpc/kernel/syscalls all
> make -f ../scripts/Makefile.build obj=3Dscripts/basic
> make -f ../scripts/Makefile.build obj=3Dscripts/dtc
> make -f ../scripts/Makefile.build obj=3Dscripts
> make -f ../scripts/Makefile.build obj=3Dscripts/gcc-plugins \
> need-builtin=3D \
> need-modorder=3D \
>
> set -e; mkdir -p include/config/; trap "rm -f include/config/.tmp_kernel.=
release" EXIT; { ../scripts/setlocalversion ..; } > include/config/.tmp_ker=
nel.release; if [ ! -r include/config/kernel.release ] || ! cmp -s include/=
config/kernel.release include/config/.tmp_kernel.release; then : '  UPD    =
 include/config/kernel.release'; mv -f include/config/.tmp_kernel.release i=
nclude/config/kernel.release; fi
> make -f ../scripts/Makefile.asm-headers obj=3Darch/powerpc/include/genera=
ted/uapi/asm \
> generic=3Dinclude/uapi/asm-generic
> make -f ../scripts/Makefile.asm-headers obj=3Darch/powerpc/include/genera=
ted/asm \
> generic=3Dinclude/asm-generic
> set -e; mkdir -p include/generated/uapi/linux/; trap "rm -f include/gener=
ated/uapi/linux/.tmp_version.h" EXIT; { 	if [ 0 -gt 255 ]; then echo \#defi=
ne LINUX_VERSION_CODE 459007; else echo \#define LINUX_VERSION_CODE 458752;=
 fi; echo '#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + ((c) >=
 255 ? 255 : (c)))'; echo \#define LINUX_VERSION_MAJOR 7; echo \#define LIN=
UX_VERSION_PATCHLEVEL 0; echo \#define LINUX_VERSION_SUBLEVEL 0; } > includ=
e/generated/uapi/linux/.tmp_version.h; if [ ! -r include/generated/uapi/lin=
ux/version.h ] || ! cmp -s include/generated/uapi/linux/version.h include/g=
enerated/uapi/linux/.tmp_version.h; then : '  UPD     include/generated/uap=
i/linux/version.h'; mv -f include/generated/uapi/linux/.tmp_version.h inclu=
de/generated/uapi/linux/version.h; fi
> set -e; mkdir -p include/generated/; trap "rm -f include/generated/.tmp_u=
tsrelease.h" EXIT; { 	if [ `echo -n "7.0.0-rc7-wii+" | wc -c ` -gt 64 ]; th=
en echo '"7.0.0-rc7-wii+" exceeds 64 characters' >&2; exit 1; fi; echo \#de=
fine UTS_RELEASE \"7.0.0-rc7-wii+\"; } > include/generated/.tmp_utsrelease.=
h; if [ ! -r include/generated/utsrelease.h ] || ! cmp -s include/generated=
/utsrelease.h include/generated/.tmp_utsrelease.h; then : '  UPD     includ=
e/generated/utsrelease.h'; mv -f include/generated/.tmp_utsrelease.h includ=
e/generated/utsrelease.h; fi
> set -e; mkdir -p include/generated/; trap "rm -f include/generated/.tmp_c=
ompile.h" EXIT; { ../scripts/mkcompile_h "ppc" "powerpc-linux-musl-gcc (GCC=
) 14.2.1 20250405" "powerpc-linux-musl-ld"; } > include/generated/.tmp_comp=
ile.h; if [ ! -r include/generated/compile.h ] || ! cmp -s include/generate=
d/compile.h include/generated/.tmp_compile.h; then : '  UPD     include/gen=
erated/compile.h'; mv -f include/generated/.tmp_compile.h include/generated=
/compile.h; fi
> ../scripts/remove-stale-files
> make -f ../scripts/Makefile.build obj=3Dscripts/mod
> set -e; mkdir -p scripts/mod/; trap "rm -f scripts/mod/.tmp_devicetable-o=
ffsets.h" EXIT; { 	 echo "#ifndef __DEVICETABLE_OFFSETS_H__"; echo "#define=
 __DEVICETABLE_OFFSETS_H__"; echo "/*"; echo " * DO NOT MODIFY."; echo " *"=
; echo " * This file was generated by Kbuild"; echo " */"; echo ""; sed -ne=
 	's:^[[:space:]]*\.ascii[[:space:]]*"\(.*\)".*:\1:; /^->/{s:->#\(.*\):/* \=
1 */:; s:^->\([^ ]*\) [\$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; s:->:=
:; p;}' < scripts/mod/devicetable-offsets.s; echo ""; echo "#endif"; } > sc=
ripts/mod/.tmp_devicetable-offsets.h; if [ ! -r scripts/mod/devicetable-off=
sets.h ] || ! cmp -s scripts/mod/devicetable-offsets.h scripts/mod/.tmp_dev=
icetable-offsets.h; then : '  UPD     scripts/mod/devicetable-offsets.h'; m=
v -f scripts/mod/.tmp_devicetable-offsets.h scripts/mod/devicetable-offsets=
.h; fi
> make -f ../scripts/Makefile.build obj=3D. prepare
> set -e; mkdir -p include/generated/; trap "rm -f include/generated/.tmp_t=
imeconst.h" EXIT; { echo 1000 | bc -q ../kernel/time/timeconst.bc; } > incl=
ude/generated/.tmp_timeconst.h; if [ ! -r include/generated/timeconst.h ] |=
| ! cmp -s include/generated/timeconst.h include/generated/.tmp_timeconst.h=
; then : '  UPD     include/generated/timeconst.h'; mv -f include/generated=
/.tmp_timeconst.h include/generated/timeconst.h; fi
> set -e; mkdir -p include/generated/; trap "rm -f include/generated/.tmp_b=
ounds.h" EXIT; { 	 echo "#ifndef __LINUX_BOUNDS_H__"; echo "#define __LINUX=
_BOUNDS_H__"; echo "/*"; echo " * DO NOT MODIFY."; echo " *"; echo " * This=
 file was generated by Kbuild"; echo " */"; echo ""; sed -ne 	's:^[[:space:=
]]*\.ascii[[:space:]]*"\(.*\)".*:\1:; /^->/{s:->#\(.*\):/* \1 */:; s:^->\([=
^ ]*\) [\$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; s:->::; p;}' < kerne=
l/bounds.s; echo ""; echo "#endif"; } > include/generated/.tmp_bounds.h; if=
 [ ! -r include/generated/bounds.h ] || ! cmp -s include/generated/bounds.h=
 include/generated/.tmp_bounds.h; then : '  UPD     include/generated/bound=
s.h'; mv -f include/generated/.tmp_bounds.h include/generated/bounds.h; fi
> set -e; mkdir -p include/generated/; trap "rm -f include/generated/.tmp_a=
sm-offsets.h" EXIT; { 	 echo "#ifndef __ASM_OFFSETS_H__"; echo "#define __A=
SM_OFFSETS_H__"; echo "/*"; echo " * DO NOT MODIFY."; echo " *"; echo " * T=
his file was generated by Kbuild"; echo " */"; echo ""; sed -ne 	's:^[[:spa=
ce:]]*\.ascii[[:space:]]*"\(.*\)".*:\1:; /^->/{s:->#\(.*\):/* \1 */:; s:^->=
\([^ ]*\) [\$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; s:->::; p;}' < ar=
ch/powerpc/kernel/asm-offsets.s; echo ""; echo "#endif"; } > include/genera=
ted/.tmp_asm-offsets.h; if [ ! -r include/generated/asm-offsets.h ] || ! cm=
p -s include/generated/asm-offsets.h include/generated/.tmp_asm-offsets.h; =
then : '  UPD     include/generated/asm-offsets.h'; mv -f include/generated=
/.tmp_asm-offsets.h include/generated/asm-offsets.h; fi
> set -e; mkdir -p include/generated/; trap "rm -f include/generated/.tmp_r=
q-offsets.h" EXIT; { 	 echo "#ifndef __RQ_OFFSETS_H__"; echo "#define __RQ_=
OFFSETS_H__"; echo "/*"; echo " * DO NOT MODIFY."; echo " *"; echo " * This=
 file was generated by Kbuild"; echo " */"; echo ""; sed -ne 	's:^[[:space:=
]]*\.ascii[[:space:]]*"\(.*\)".*:\1:; /^->/{s:->#\(.*\):/* \1 */:; s:^->\([=
^ ]*\) [\$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; s:->::; p;}' < kerne=
l/sched/rq-offsets.s; echo ""; echo "#endif"; } > include/generated/.tmp_rq=
-offsets.h; if [ ! -r include/generated/rq-offsets.h ] || ! cmp -s include/=
generated/rq-offsets.h include/generated/.tmp_rq-offsets.h; then : '  UPD  =
   include/generated/rq-offsets.h'; mv -f include/generated/.tmp_rq-offsets=
.h include/generated/rq-offsets.h; fi
> # CALL    ../scripts/checksyscalls.sh
>   sh ../scripts/checksyscalls.sh powerpc-linux-musl-gcc -Wp,-MMD,./.missi=
ng-syscalls.d -nostdinc -I../arch/powerpc/include -I./arch/powerpc/include/=
generated -I../include -I./include -I../arch/powerpc/include/uapi -I./arch/=
powerpc/include/generated/uapi -I../include/uapi -I./include/generated/uapi=
 -include ../include/linux/compiler-version.h -include ../include/linux/kco=
nfig.h -include ../include/linux/compiler_types.h -D__KERNEL__ -mbig-endian=
 -m32 -I ../arch/powerpc -fmacro-prefix-map=3D../=3D -Wundef -DKBUILD_EXTRA=
_WARN1 -std=3Dgnu11 -fshort-wchar -funsigned-char -fno-common -fno-PIE -fno=
-strict-aliasing -msoft-float -ffixed-r2 -mmultiple -mno-readonly-in-sdata =
-mcpu=3Dpowerpc -mno-prefixed -mno-pcrel -mno-altivec -mno-vsx -mno-mma -fn=
o-asynchronous-unwind-tables -mno-string -mbig-endian -fno-delete-null-poin=
ter-checks -Os -fno-allow-store-data-races -fno-stack-protector -fomit-fram=
e-pointer -ftrivial-auto-var-init=3Dzero -fno-stack-clash-protection -fmin-=
function-alignment=3D4 -fstrict-flex-arrays=3D3 -fms-extensions -fno-strict=
-overflow -fno-stack-check -fconserve-stack -fno-builtin-wcslen -Wall -Wext=
ra -Wundef -Werror=3Dimplicit-function-declaration -Werror=3Dimplicit-int -=
Werror=3Dreturn-type -Werror=3Dstrict-prototypes -Wno-format-security -Wno-=
trigraphs -Wno-frame-address -Wno-address-of-packed-member -Wmissing-declar=
ations -Wmissing-prototypes -Wframe-larger-than=3D1280 -Wno-main -Wno-type-=
limits -Wno-dangling-pointer -Wvla-larger-than=3D1 -Wno-pointer-sign -Wcast=
-function-type -Wno-array-bounds -Wno-stringop-overflow -Wno-alloc-size-lar=
ger-than -Wimplicit-fallthrough=3D5 -Werror=3Ddate-time -Werror=3Dincompati=
ble-pointer-types -Werror=3Ddesignated-init -Wenum-conversion -Wunused -Wmi=
ssing-format-attribute -Wmissing-include-dirs -Wunused-const-variable -Wno-=
missing-field-initializers -Wno-shift-negative-value -Wno-maybe-uninitializ=
ed -Wno-sign-compare -Wno-unused-parameter -DGCC_PLUGINS -I../. -I.    -DKB=
UILD_MODFILE=3D'"./missing-syscalls"' -DKBUILD_BASENAME=3D'"missing_syscall=
s"' -DKBUILD_MODNAME=3D'"missing_syscalls"' -D__KBUILD_MODNAME=3Dmissing_sy=
scalls
> make -f ../scripts/Makefile.build obj=3Darch/powerpc/kernel/vdso include/=
generated/vdso32-offsets.h
> mkdir -p ./tools
> make O=3D/home/linkmauve/dev/linux/wii subdir=3Dtools -C ../tools/ objtoo=
l
> mkdir -p /home/linkmauve/dev/linux/wii/tools/objtool && make O=3D/home/li=
nkmauve/dev/linux/wii subdir=3Dtools/objtool --no-print-directory -C objtoo=
l
> make -C /home/linkmauve/dev/linux/tools/build CFLAGS=3D LDFLAGS=3D /home/=
linkmauve/dev/linux/wii/tools/objtool/fixdep
> if [ ! -f /home/linkmauve/dev/linux/wii/tools/objtool/fixdep ]; then					=
	\
> 	make -f /home/linkmauve/dev/linux/tools/build/Makefile.build dir=3D. obj=
=3Dfixdep HOSTCFLAGS=3D"-Wall -Wmissing-prototypes -Wstrict-prototypes -O2 =
-fomit-frame-pointer -std=3Dgnu11   -I ../scripts/include";	\
> 	rm -f /home/linkmauve/dev/linux/wii/tools/objtool/fixdep.o;						\
> fi
> make -f /home/linkmauve/dev/linux/tools/build/Makefile.build dir=3D. obj=
=3Dfixdep HOSTCFLAGS=3D"-Wall -Wmissing-prototypes -Wstrict-prototypes -O2 =
-fomit-frame-pointer -std=3Dgnu11   -I ../scripts/include"
> make -C /home/linkmauve/dev/linux/tools/lib/subcmd/ O=3D/home/linkmauve/d=
ev/linux/wii/tools/objtool/libsubcmd \
> 	DESTDIR=3D/home/linkmauve/dev/linux/wii/tools/objtool/libsubcmd prefix=
=3D subdir=3D \
> 	CC=3D"gcc" LD=3D"ld" AR=3D"ar" EXTRA_CFLAGS=3D"-std=3Dgnu11 -fomit-frame=
-pointer -O2 -g -Werror -Wall -Wextra -Wmissing-prototypes -Wmissing-declar=
ations -Wwrite-strings -Wno-implicit-fallthrough -Wno-sign-compare -Wno-unu=
sed-parameter -I/home/linkmauve/dev/linux/tools/include -I/home/linkmauve/d=
ev/linux/tools/include/uapi -I/home/linkmauve/dev/linux/tools/arch/x86/incl=
ude/uapi -I/home/linkmauve/dev/linux/tools/arch/powerpc/include -I/home/lin=
kmauve/dev/linux/tools/objtool/include -I/home/linkmauve/dev/linux/tools/ob=
jtool/arch/powerpc/include -I/home/linkmauve/dev/linux/wii/tools/objtool/li=
bsubcmd/include   " \
> 	/home/linkmauve/dev/linux/wii/tools/objtool/libsubcmd/libsubcmd.a instal=
l_headers
> make -C /home/linkmauve/dev/linux/tools/build CFLAGS=3D LDFLAGS=3D /home/=
linkmauve/dev/linux/wii/tools/objtool/libsubcmd/fixdep
> if [ ! -f /home/linkmauve/dev/linux/wii/tools/objtool/libsubcmd/fixdep ];=
 then						\
> 	make -f /home/linkmauve/dev/linux/tools/build/Makefile.build dir=3D. obj=
=3Dfixdep HOSTCFLAGS=3D"-Wall -Wmissing-prototypes -Wstrict-prototypes -O2 =
-fomit-frame-pointer -std=3Dgnu11   -I ../scripts/include";	\
> 	rm -f /home/linkmauve/dev/linux/wii/tools/objtool/libsubcmd/fixdep.o;			=
			\
> fi
> make -f /home/linkmauve/dev/linux/tools/build/Makefile.build dir=3D. obj=
=3Dfixdep HOSTCFLAGS=3D"-Wall -Wmissing-prototypes -Wstrict-prototypes -O2 =
-fomit-frame-pointer -std=3Dgnu11   -I ../scripts/include"
> make[5]: 'install_headers' is up to date.
> sh ./sync-check.sh
> make -f /home/linkmauve/dev/linux/tools/build/Makefile.build dir=3D. obj=
=3Dobjtool CC=3D"gcc" LD=3D"ld" AR=3D"ar" CFLAGS=3D"-std=3Dgnu11 -fomit-fra=
me-pointer -O2 -g -Werror -Wall -Wextra -Wmissing-prototypes -Wmissing-decl=
arations -Wwrite-strings -Wno-implicit-fallthrough -Wno-sign-compare -Wno-u=
nused-parameter -I/home/linkmauve/dev/linux/tools/include -I/home/linkmauve=
/dev/linux/tools/include/uapi -I/home/linkmauve/dev/linux/tools/arch/x86/in=
clude/uapi -I/home/linkmauve/dev/linux/tools/arch/powerpc/include -I/home/l=
inkmauve/dev/linux/tools/objtool/include -I/home/linkmauve/dev/linux/tools/=
objtool/arch/powerpc/include -I/home/linkmauve/dev/linux/wii/tools/objtool/=
libsubcmd/include   " \
> 	LDFLAGS=3D"/home/linkmauve/dev/linux/wii/tools/objtool/libsubcmd/libsubc=
md.a -lelf  "
> make -f /home/linkmauve/dev/linux/tools/build/Makefile.build dir=3D./arch=
/powerpc obj=3Dobjtool
> sh ../scripts/rust_is_available.sh
> make -f ../scripts/Makefile.build obj=3Drust
> # RUSTC L rust/pin_init.o
>   OBJTREE=3D/home/linkmauve/dev/linux/wii rustc --edition=3D2021 -Zbinary=
_dep_depinfo=3Dy -Astable_features -Aunused_features -Dnon_ascii_idents -Du=
nsafe_op_in_unsafe_fn -Wmissing_docs -Wrust_2018_idioms -Wunreachable_pub -=
Wclippy::all -Wclippy::as_ptr_cast_mut -Wclippy::as_underscore -Wclippy::ca=
st_lossless -Wclippy::ignored_unit_patterns -Wclippy::mut_mut -Wclippy::nee=
dless_bitwise_bool -Aclippy::needless_lifetimes -Wclippy::no_mangle_with_ru=
st_abi -Wclippy::ptr_as_ptr -Wclippy::ptr_cast_constness -Wclippy::ref_as_p=
tr -Wclippy::undocumented_unsafe_blocks -Wclippy::unnecessary_safety_commen=
t -Wclippy::unnecessary_safety_doc -Wrustdoc::missing_crate_level_docs -Wru=
stdoc::unescaped_backticks -Cpanic=3Dabort -Cembed-bitcode=3Dn -Clto=3Dn -C=
force-unwind-tables=3Dn -Ccodegen-units=3D1 -Csymbol-mangling-version=3Dv0 =
-Crelocation-model=3Dstatic -Zfunction-sections=3Dn -Wclippy::float_arithme=
tic --target=3Dpowerpc-unknown-linux-gnu -Copt-level=3Ds -Cdebug-assertions=
=3Dn -Coverflow-checks=3Dy @./include/generated/rustc_cfg --extern pin_init=
_internal --extern macros --cfg=3D'kernel' --emit=3Ddep-info=3Drust/.pin_in=
it.o.d --emit=3Dobj=3Drust/pin_init.o --emit=3Dmetadata=3Drust/libpin_init.=
rmeta --crate-type rlib -L./rust --crate-name pin_init ../rust/pin-init/src=
/lib.rs --sysroot=3D/dev/null -Zunstable-options   ; ./tools/objtool/objtoo=
l --static-call   rust/pin_init.o

Looks like the command line here is missing -L./rust/host.

Mukesh, perhaps when you test locally you didn't clean out the already-buil=
t
files inside rust directory?

Best,
Gary

> error[E0463]: can't find crate for `pin_init_internal`
>    --> ../rust/pin-init/src/lib.rs:365:11
>     |
> 365 | pub use ::pin_init_internal::pin_data;
>     |           ^^^^^^^^^^^^^^^^^ can't find crate
>
> error: aborting due to 1 previous error
>
> For more information about this error, try `rustc --explain E0463`.
> make[3]: *** [../rust/Makefile:681: rust/pin_init.o] Error 1
> make[2]: *** [/home/linkmauve/dev/linux/Makefile:1343: prepare] Error 2
> make[1]: *** [/home/linkmauve/dev/linux/Makefile:248: __sub-make] Error 2
> make[1]: Leaving directory '/home/linkmauve/dev/linux/wii'
> make: *** [Makefile:248: __sub-make] Error 2
> make ARCH=3Dpowerpc CROSS_COMPILE=3Dpowerpc-linux-musl- O=3Dwii W=3D1 V=
=3D1 -j1  1.15s user 0.56s system 100% cpu 1.695 total
> ```
>
>>=20
>> Regards,
>> Mukesh
>>=20
>> > >=20
>> > > We are actively working with our LLVM team to get the target for ppc=
,
>> > > ppc64 and ppc64le in the rust compiler.
>> > >=20
>> > >=20
>> > > [1] https://lore.kernel.org/all/20260204030507.8203-1-linkmauve@link=
mauve.fr
>> > > [2] https://lore.kernel.org/all/20260204042417.83903-1-mkchauras@gma=
il.com
>> > >=20
>> > > Changelog:
>> > > V9 -> V10:
>> > > - rust/Makefile updated with review comments from Miguel
>> > > - Patch 1/4 updated with commit message and subject
>> > > V9: https://lore.kernel.org/all/20260404121610.1956528-1-mkchauras@g=
mail.com/
>> > >=20
>> > > V8 -> V9:
>> > > - rust/Makefile updated with a directory instead of abspath
>> > > V8: https://lore.kernel.org/all/20260403145308.1042622-1-mkchauras@g=
mail.com/
>> > >=20
>> > > V7 -> V8:
>> > > - rust/Makefile updated to separate host libraries from target
>> > > V7: https://lore.kernel.org/all/20260329160254.2592207-1-mkchauras@g=
mail.com/
>> > >=20
>> > > Changelog:
>> > > V6 -> V7:
>> > > - Documentation removed as powerpc is still under development
>> > > - Added a fix for race condition in rust/Makefile
>> > > V6: https://lore.kernel.org/all/20260210090023.2587534-1-mkchauras@g=
mail.com
>> > >=20
>> > > V5 -> V6:
>> > > - Added a missing Tested by from Venkat which got missed since V3
>> > > - Support is marked as Maintained instead of experimental
>> > > V5: https://lore.kernel.org/all/20260210053756.2088302-1-mkchauras@g=
mail.com
>> > >=20
>> > > V4 -> V5:
>> > > - Removed a nested ifdef from PPC64 for Little endian toolchain
>> > > V4: https://lore.kernel.org/all/20260209105456.1551677-1-mkchauras@g=
mail.com
>> > >=20
>> > > V3 -> V4:
>> > > - Co-developed-by header added in patch 1
>> > > V3: https://lore.kernel.org/all/20260205180429.3280657-1-mkchauras@g=
mail.com
>> > >=20
>> > > V2 -> V3:
>> > > - Splited HAVE_RUST in 2 lines
>> > > - BINDGEN_TARGET_powerpc initialized before assigning the same to
>> > >   BINDGEN_TARGET
>> > > V2: https://lore.kernel.org/all/20260204210125.613350-1-mkchauras@gm=
ail.com
>> > >=20
>> > > V1 -> V2:
>> > > - jump label fix for rust has been moved to a separate patch
>> > > - PPC32 support has been taken
>> > > - rust support has been marked experimental
>> > > - target.json dependency has been removed
>> > > - HAVE_RUST now depends on CPU_LITTLE_ENDIAN for PPC64
>> > >=20
>> > > Link Mauve (1):
>> > >   rust: Add PowerPC support
>> > >=20
>> > > Mukesh Kumar Chaurasiya (IBM) (3):
>> > >   rust: Fix "multiple candidates for rmeta dependency core" error
>> > >   powerpc/jump_label: adjust inline asm to be consistent
>> > >   powerpc: Enable Rust for ppc64le
>> > >=20
>> > >  arch/powerpc/Kconfig                  |  2 +
>> > >  arch/powerpc/Makefile                 |  7 +++
>> > >  arch/powerpc/include/asm/jump_label.h | 23 ++++++----
>> > >  rust/Makefile                         | 66 ++++++++++++++++--------=
---
>> > >  4 files changed, 61 insertions(+), 37 deletions(-)
>> > >=20
>> > > --=20
>> > > 2.53.0
>> > >=20
>> > >=20
>> >=20
>> > --=20
>> > Link Mauve
>> >=20


