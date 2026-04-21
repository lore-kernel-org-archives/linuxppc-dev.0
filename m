Return-Path: <linuxppc-dev+bounces-19897-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E01F8FA90
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 15:58:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0Rpf4DzNz2ynC;
	Wed, 22 Apr 2026 01:58:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c206::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776787098;
	cv=pass; b=n6iEsqRApXF6HbdZBVPwrsUx+QggiCxs5IEN9m8tzb2sOwZvxUj3SFi5tvL4SOKrhDdGtaj6MB6cF3yRtHW/LiM2ZD5UTedjZrLP0dOhAbZTxkhc6HNoonFcz2Z9wgljkXqD6IvyEMUjqnJTDERA5f8xMsd/s6/fzCkeDvuVKSl8gTAazDxcKDNwU+HaoCP5XuAAS20OWRqWaljMpWCy5Zc3QkcrFbXBYUfGzDFMHC4FAiMknx404d2HhLpaPSCgmFstU70hEI5HL5tEIfAC/2lJkkYfp7nUIMDiVpPzPiWrjoZ6XLqfXHkmdmMLoAJ4gDYsJFlNcvxlNI0tLY13mg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776787098; c=relaxed/relaxed;
	bh=rFHgxg+fwcZ2BuPLXscYZNQ9+91vuKqdsJijAfNH6UY=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=gp192h8LS7GuGucAmnLOS0n24EOujqo4MJGr/tfV2l1mzkXP1RIA/0yeYppONNb0E6N1OxVtZnwQZzaNkTGuhw9wTE1hkAEF8WzxGgtRhTrUTFboTLywl7CCPspXsk2XqWAwz5+jAO1wZrEfR6FhyIQOjuvO0SrvyFrhVlMSlA+xjak2N2HEFKdmxMRsNgVetXg7uElPAu3qpgrHzp50E44qlFQuBwWNylccAk5rxZ12JCePAt9RNlZ6kV3OvCvalfyeYn6Cydej/J8vZJXC17sHoCuxWDW+WOzil/WipFPJeF6xuORpr7ABijjMQV/UEly8VjiahPoabzlTGkcGbw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=jHHUru3O; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c206::3; helo=cwxp265cu009.outbound.protection.outlook.com; envelope-from=gary@garyguo.net; receiver=lists.ozlabs.org) smtp.mailfrom=garyguo.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=jHHUru3O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=garyguo.net (client-ip=2a01:111:f403:c206::3; helo=cwxp265cu009.outbound.protection.outlook.com; envelope-from=gary@garyguo.net; receiver=lists.ozlabs.org)
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c206::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0Rpd0K7nz2xlt
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 01:58:15 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VEarmj0u4FQ49+lWMNHklhlr6OjVkTuzGN0hiyVHihylnam0IY0FGqLcD1hUDc1CJAZM1JL0k6AGHFD+fbblQEbL3HoPvYmIE1zpqF1ss4zHmWXO1YDlgFCc7tbwnqo6jdJFdOI4KtRDP+LjBgRQjjEj6RAAW6RmNuF20rlOEQDj5M86j7jyzS0PuwYWbhTcyWJjur0gWM/zK7oUTu/2/wTgkUH7ito6S8H4ZS5eOu+uXWfxlJDQzYF3a2xTzSS1sM2RDalIaAOHaeVtTI9uH1Uf9UgVE14IEjeKEiAfwKYWAs+tZnHS0ttKKoedorwrBOKwFv00x7BamaohW2mo8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFHgxg+fwcZ2BuPLXscYZNQ9+91vuKqdsJijAfNH6UY=;
 b=Ivfj0pPFgRhI/XIIfHrk+i8nP87yjIukxPD/pw5pmyfbdyzLM4lcw2JiRurJyT2PeSH4n+lI3uYI/Hj0SNesFXF+ce+p5kiSSJP9nqxsI/BrMvNeJtMXaUzUGXsIbQZdtZA+CCQKTHabZnIl1MDEMtZJLJyunwUtuQEu8GBXwcSioM1xndcLp6GzCs7jGIyNIleDqPa9McXXSKd5pPTFI+pol9UqkLk6AH8jLmfWPs+0WKVP0ipFQ3SmIEmzhthW6fElsaTPkwX/2bZ6eEJE9YI/7eMQNjcwbbXWQ5lIh4+RKage+KwKn3Jk3rcZ43IfJmBpeE/Qz+OXG/Q5Fpho9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFHgxg+fwcZ2BuPLXscYZNQ9+91vuKqdsJijAfNH6UY=;
 b=jHHUru3OyiX42yPMW3llMGGEOwicWghGYPEAhY55sq6UmoHl99Nwa4SATfMh6MnUU6n6tmy7uIUOqc4LgRVdTnKLhwPZ/E0rxeXntHM/UHlayMtd2y9dFwiWDVw36EYWrgrVMsh/V+p81XL+pEqFsBb9gPH8FfDxTfDtbB+Fadk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB9193.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 15:57:50 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 15:57:50 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 16:57:49 +0100
Message-Id: <DHYYG7A745M5.VQY4GMDJNC1Y@garyguo.net>
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
Subject: Re: [PATCH V11 1/4] rust: Fix "multiple candidates for rmeta
 dependency core" error
From: "Gary Guo" <gary@garyguo.net>
To: "Mukesh Kumar Chaurasiya" <mkchauras@gmail.com>, "Link Mauve"
 <linkmauve@linkmauve.fr>
X-Mailer: aerc 0.21.0
References: <20260417152253.2312961-1-mkchauras@gmail.com>
 <20260417152253.2312961-2-mkchauras@gmail.com> <aedFgEicDW6LAcuq@luna>
 <aedJGuF9P2V1lOCZ@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <aedQ629D0x-5KuKw@luna>
 <aedpk1iaeYyKPSOI@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <aeds6_8Mr_w38oYI@luna>
 <aeec_IzVJwlfarN5@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
In-Reply-To: <aeec_IzVJwlfarN5@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
X-ClientProxiedBy: LO4P123CA0543.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::15) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB9193:EE_
X-MS-Office365-Filtering-Correlation-Id: 80ac2dfb-e957-4536-c3c8-08de9fbebd20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016|22082099003|18002099003|18096099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	fnMYAP0ttXNLgb9BbJEJHQCTF/wauIn18wc+iw0cuTmYEZwz2GqL9VAfxpXmuvBBbenNsFjaZ8Sgkq/p8go9DJidlWB0/kT9A/Gl7TCwCI7zSIsHHtQOMMTfJaQef7XQzjAvYHiq+W2X/4TN3CNvXmozX4NfdJzu1Tovyzdti4CJbPgIS4XKTwiSPOYkk1zzPiQXwm5OgppGN8ZD3QAb2PRwqk1ZhVj3LuzaXK0mAqoL8rw08zqZv9u6IewPqYILzA0SxT8tf5e9jEvmB1gTH3weWgInq+1OzSgCwQ10VwbIqqRfmElsCFhL0cf95u9JZB2oDxkV4cc70hGNzydLVMB9Z8gfOf/GiY423ABln7WTvJWnFwADIRBcSSLILgOojCqHkWBkyjnRum1MRBLakIVpNU7e3Rtdfq5RF2MKzI+BygTGC3tGWrhPjd3PwILZwzSt0+9PIVVlE3G/yPHjfbpuSsYQBu/B3CAdghOTxY+PdEaosqYdUeeGTY7KzxTLRdR4I5bg+5M6Y4g3Nho0knkpGvAqjnNpOQ3fTW4EyriUIldFeyqoTwL5CqjgpKV5dsE6HVVDcFe6nj1QHBoG6TktLSfM46qD4FNd4Y/sq0ayhsXRcULPbUo+3x/p2luvhqt4NlUeEjcIPspfp0Nsp8DQzU88s69k4TNJaJpi2KZPVCOWpxLk9KToah94/wfhP2ZfFM/+MewcmtFQoRE0UK7gqNmVJLYYhy5kvTaqGEw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016)(22082099003)(18002099003)(18096099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0lpWUMvdzZ5dVJiQkU0WFJwQlBqSkJmVEFhNWFzUC9SUkRyYUVaNnJQSXFq?=
 =?utf-8?B?Smg2Mk9vN1BZeEM4VkNtQ3d1NnYvOEJOc3d0R1FhMCs5azlIOWx1K0lTVWho?=
 =?utf-8?B?TG5aWklQTkpvYjRodWJsSjFtYm9KbnBtdC9ncTFkZVh5bFlETnZMWFFGMzdW?=
 =?utf-8?B?eU9VbUtzNlU1K09LcGN3WThVdVlxVG5JeE15c0dqRzRLZGJYWlMrZ0EyZTRC?=
 =?utf-8?B?UlU0UTlFYTNyeU5NbFhRZFE0TEdiT0hDK0R1Q0NONzZRRkV0amxUQy9LSExv?=
 =?utf-8?B?UDliaDZCYjAwVFlEakRQZURLTU5ZQXUvRzVmVUI3ZXRxZ0tzZFRyU2E3em1j?=
 =?utf-8?B?L245U01YbWNBUkxvSXVtK2xFSG9SNDNQdDl2akgzVDJNdHMzTlhkZyt5bnhE?=
 =?utf-8?B?QWNZUlpCR0VRYWd4NWFyWGtrOVlWemZBN0Eyalk4c0tueUFCWWVuc25qTldw?=
 =?utf-8?B?T2ZjcTJiYU1Ib2V2aXhpVGs3d2Y5cm9vT0VzYnlRRTc3TEQ5VFRUUDUvellE?=
 =?utf-8?B?d3R6VUNHOVo3MFhYcmZSVlc1R0JJM0U1L2N3L3pGLzFYTTJ2b3FrczVjZ0NU?=
 =?utf-8?B?SXUrSHhDVk95bDRPWWsreFp3MVN1aUJhQkRSM2huQ09MZkY1SUJHSFdxL0JD?=
 =?utf-8?B?YktOSG5tU2JXVjNOUVM0SDdvNzNhdmNGN1doVUUvd3VZT3RiazdTcGVobXNz?=
 =?utf-8?B?VHA4dHZNSE1YQTllM3Z4NEp4ZE1uSDlrMlU4VnEwdEsraGc4c081dVB4aDM4?=
 =?utf-8?B?WmlxUUxaUmd0Vk5nNUtVbmYrcHRRQ0FmVW92L212RFBwMi9nakNlSTg4dEg0?=
 =?utf-8?B?UmdEcHhjYkRkSHZXUTN4aWJnNzltWklPUE5sei9FQ29xS0h1Y3ZzVUROdXdS?=
 =?utf-8?B?SXBMMVdWaUpiK1hmcTRwSDFMTkkwMU5PR0k2RGF4Wk9DM00xMllMdkZLLzNK?=
 =?utf-8?B?aVI4blgrU0RvMTBZKzk2aEd6endiTHV3YWUxRXpiUTZ0c3UzMG41SVNwY3Bj?=
 =?utf-8?B?OWNyemFmenMwdnhaMm1FVEJSaUF2YUlaMWNFYXlUQ2l2TzJTRklucDdOR0RP?=
 =?utf-8?B?alBrQlJPaGtNMnZ1bDBCdGR1ZDdwK1g4YWFMdi9EckNXYVdGRHJEd3pRYjhk?=
 =?utf-8?B?TzJkV2tGYzg1TVlMUDJxSWhrSHY1RHNzdS80Y29zOUlvZ0pjUXlmL0FYY0Ji?=
 =?utf-8?B?bVp3VzVYTzdES0laTEpnZWNMclJENCt0UGJxeEo3WkJVWUhGem52dnk4SkNr?=
 =?utf-8?B?cVRod2s5MEl3UUsrYWZZbTZVN3pLWkVTcHNUVW5ydGZyNTk1MkJLSFRVa0h3?=
 =?utf-8?B?MHZFQkN1ZkFNdFluaHNCTTZpdW5tU3hBc2ZNVU5hMjI3QUljTWtjelIyOU5z?=
 =?utf-8?B?blhQWGxwYk1YclZ5WnNXWkhXQUM2U1U5QThCcDBLTStVVDBRZFF3VGFoZ1JJ?=
 =?utf-8?B?d0w1dzMxNFlvSzhBYUYvY0w0Z29tZ0hQTi9FNENBOEc5Zk1HaXpCNjBJVzRJ?=
 =?utf-8?B?aHZLNVRnRFh6RVZDQ01XSmJabFpaQ0owUVBiSFJCbGlhOEFaMXZwaGtjODhh?=
 =?utf-8?B?T1AzOWZSSXNaelowL1JmajFVMnp6UEY5Y2puNjd0REhJd2ZnTzBBUDV1b1hv?=
 =?utf-8?B?NThpZEwrUjZpRHVNb2lRK1NMMitnTFQ1V0NzNndXM0NsL3oySjM5QXlQa1Z2?=
 =?utf-8?B?VnBBdmlUdDJEL2RlaS9sN0hvZjA1djlGL1pFSXNiZEx2TmU4SHpZeFBGZzlX?=
 =?utf-8?B?T0RNZU5sTk9iNjdyUFhVMHJZVHdMQ3FXQlhmSkIyV3FHMHF5Z0FwNjNmUHVx?=
 =?utf-8?B?ZnhxWGVnekVaa2VkZE9mY1ZIMG5FMlhBZS9xTnJiVjdaelpKN3o0MThneEJT?=
 =?utf-8?B?ZVJWc3NGMzJMRDdJdnZlR3pxNzZuUVlKdFVxZ0pGM2IzU0l0bnp4c3lUMTh2?=
 =?utf-8?B?TU1NT20yM2RXKzVla0syQ3kySlFiYm9sU1dwUEl5U1NQOERTaGRDTzRKY1ZC?=
 =?utf-8?B?c1FXbGtQUnQxMWNhQ01IUWJneXJrc29YUjhpM05UWHF0QWE4WTkyR2h2MUwy?=
 =?utf-8?B?aVJJUm1ReGk2aXdyT3pldi9seFZRcGJoQ3RoSm5XbHdiOTFYM2ZkU2tUamtn?=
 =?utf-8?B?VkVpbGlHMnh4U3Z2bytVYUNuZlZENHphb2RnR2kwdWdibDFKam5QUXA5Rjhi?=
 =?utf-8?B?UWNnRnJqTGJjREs0QnRGSGovWXZJSTBVbldzVWh0L1NGdklwNWFzZ1J0U3Mr?=
 =?utf-8?B?RnNnODl3bHl3elhkdlFHVXdFdFlCNlpzV1UvZm9hZkhPTGp4aTRIVHQ4VGtU?=
 =?utf-8?B?N3R2YVVoQVBmSnB6eE9TSVpHL3dYQVF5bkc2aUJqdkZTRUtEbEhNZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ac2dfb-e957-4536-c3c8-08de9fbebd20
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 15:57:49.9544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KxCcS8FM3bVqlazAzNZRfbL0wuiglAWv7J+UL+svqezDnt0ViDBkVfn6ChiDkOl/My3Z+1W48I1NnVWTgEWXzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB9193

On Tue Apr 21, 2026 at 4:53 PM BST, Mukesh Kumar Chaurasiya wrote:
> On Tue, Apr 21, 2026 at 02:26:19PM +0200, Link Mauve wrote:
>> On Tue, Apr 21, 2026 at 05:49:32PM +0530, Mukesh Kumar Chaurasiya wrote:
>> > On Tue, Apr 21, 2026 at 12:26:51PM +0200, Link Mauve wrote:
>> > > On Tue, Apr 21, 2026 at 03:25:22PM +0530, Mukesh Kumar Chaurasiya wr=
ote:
>> > > > On Tue, Apr 21, 2026 at 11:38:08AM +0200, Link Mauve wrote:
>> > > > > Hi Mukesh,
>> > > > >=20
>> > > > > This patch doesn=E2=80=99t apply on top of mainline, which tree =
did you base it
>> > > > > off?
>> > > > >=20
>> > > > It was on mainline v7.0 tag.
>> > >=20
>> > > Great thanks, they do apply there!
>> > >=20
>> > > I needed three more patches for the kernel to build on PPC32, I=E2=
=80=99ve
>> > > attached them but they are absolutely not patches which could go int=
o
>> > > the kernel (except for the second, enabling asm_experimental_arch).
>> > >=20
>> > > What do you think we should do about them?
>> > >=20
>> > Regarding the 2nd patch you sent, As the support is experimental as of
>> > now, Let's wait till we get everything stablized, till then we'll use
>> > nightly build for all variants of powerpc. Once we mark it as
>> > maintained, then we can try to push that patch.
>>=20
>> Enabling the feature is mandatory even on nightly or with
>> RUSTC_BOOTSTRAP=3D1, otherwise no asm!() macro can be called and so the
>> kernel crate can=E2=80=99t be built.
>>=20
> The stable support is available on nightly.
> Refer https://github.com/rust-lang/rust/pull/147996

In that case you should add the feature with a comment that it's needed for=
 PPC
only and is stable in 1.95.

Best,
Gary

>
> Regards,
> Mukesh
>> >=20
>> > Maybe Miguel can comment better on this.
>> >=20
>> > Regarding other patches, I am planning to work on ppc32 once ppc64le
>> > stabilizes.


