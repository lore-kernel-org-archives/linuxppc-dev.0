Return-Path: <linuxppc-dev+bounces-27179-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D5ACC88E59
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Sep 2026 18:00:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhzhc6WNZz2y2h;
	Sun, 13 Sep 2026 04:00:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c205::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789236000;
	cv=pass; b=UhIpunkTMUEf+sD6TFTiCb3lMRRlOqz5uxk0I2/AcrTCCPJWSoQhUcOyBlVDMDgflWQztRc3URHeF0xmF952YfSeJeGRcbUH9TofVKAYJ+1LGN/ZzpbV8aQJpn1i8oXHd0RQejPEubSRtkxQCrSqK9uyOKkFzZQLPdl5bUDrv7HNjvKIVdlTj3cCoehcWKIP+LLdtfjQ0CxMcsulsiciaIzT81dOW6Tpc49L7hAj8ilvqde4TOty64L2ol7N1obbFliWekOFXEhFwfzwV92tS2Fggeza65GkJV7aG4MjwiV/204I5XHqqPZw8nFPEcvgFDNl9ba+rusmf3+3y20Ygw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789236000; c=relaxed/relaxed;
	bh=TpZaSBpqqdInkP76WycFaNhWlegAp/IWv2/2dBrerZU=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=EIt3tSDDP3fIfXmyYCdQ3988yN/GgS2+9orIahIOrzK+zzagxJXUeVPk8bjO3c3kE3q19bD+z5/ON3OMpLod4Z/BUDBMPuM98Dn+RuJ176PJ+Ky164+E847787r4zuqCDpbGmji1IyVsD7ptk7wcjpGD2wLF33ud60Jk1uQ+ty280XRaiFLplXWuIhstjbWisLK4/OnsNXHHuJPC8wfMRqDDepy5xVrYI1JJAQyMBLqnCGgqicjZqqiLktaCqbXZZa0XQ80I1py0TY5ectFHP2LeMrSEkSVWFfPiLKPLtKnBtG0EYXVYrLH2e+eFPhAhvkk03/xpt8IesZZS96cJUw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=refhPzqd; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c205::5; helo=lo0p265cu003.outbound.protection.outlook.com; envelope-from=gary@garyguo.net; receiver=lists.ozlabs.org) smtp.mailfrom=garyguo.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=refhPzqd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=garyguo.net (client-ip=2a01:111:f403:c205::5; helo=lo0p265cu003.outbound.protection.outlook.com; envelope-from=gary@garyguo.net; receiver=lists.ozlabs.org)
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c205::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hhzhZ0sfZz2xqM
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Sep 2026 03:59:57 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNVY6nPr0yNDYQNxlCyHrgMckZ7Ug+XEKwPQl/sJGI3AYKQgrW5bY4CXIqMdnfoWqOmnyEA7Ga/AfCARjWf8pbO4chkc/9MzZ+kFnEMBqz0KHG5NArm4FtZt67TFBfJNklHbkLKMsamAy4ptD1Px5vb74N3NjbLdgs/iKuZP/CClBQKIB8S4LNeeuX2hZYQgpu6C9Ne2TgcB28wSpet5xllg+MtMuuaf1RVGPqNnFZNEd8jzx0HOVZLSeAWp4wqmHvMEboy4Wk+pbDbOTQLXzk48m56tHt4Sw/m/MTv7VTSiVO5jLI3NCrlhZZBt/nEqGy5xgxDn/c8dO/ZNVY7dRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpZaSBpqqdInkP76WycFaNhWlegAp/IWv2/2dBrerZU=;
 b=ne54jPuCTk39V7ctEZadCw+4AQnlGFKI4wwrrhDCoipFQF8BQ9jobnSj0a/szbETEHwTI8+RwKQ2XhYVsqm6ShJw3L4XxE8KWJdB7SxKlUc+RwE09YTI4RtXJUl7BFnJklDQaOdyiK+lKH1cwhISveMyHgDTebc3b7NXOX0jgXGI/PkCOPLGi3V/jEKIT3tDtTMEy8WYIZHYZ1cOAVMxY4lSGhXP8EpaAq7r1QCZom4yw5SWnPzW/uft5brXcdmvASwTK0nJ0BscTY7BYuBSNJNVhXGe5q/MxH1QAejy1Sp/9oe4E5iYbpqVERSNLjKo9DRKz0xXjP1IZE1eesCJAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpZaSBpqqdInkP76WycFaNhWlegAp/IWv2/2dBrerZU=;
 b=refhPzqd62pMQpGUuoDjGkhljXUiz/FdVI9zSrLWPYxy5fCsc2jZTi6/86BMAzHXfxOHN+5vJKUAifu8oAV+bmB/odsoV+j+Vqpsg/0jFSIrkJnEFWxPoWHJTh0wZisAagv/QbZYCkXvXULv7sISydjQtxgNYZt0mysQSQLkK30=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO0P265MB6725.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:30b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Sat, 12 Sep
 2026 17:59:31 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0406.007; Sat, 12 Sep 2026
 17:59:31 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 12 Sep 2026 18:59:30 +0100
Message-Id: <DLDJ7TNEH9MS.2I386V2SZ5QDR@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
 <maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
 <chleroy@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <dakr@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <acourbot@nvidia.com>, <work@onurozkan.dev>, <pjw@kernel.org>,
 <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
 <nathan@kernel.org>, <ndesaulniers@google.com>, <morbo@google.com>,
 <justinstitt@google.com>, <ynorov@nvidia.com>, <ecourtney@nvidia.com>,
 <joelagnelf@nvidia.com>, <fujita.tomonori@gmail.com>,
 <linkmauve@linkmauve.fr>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <llvm@lists.linux.dev>
Cc: "FUJITA Tomonori" <tomo@flapping.org>
Subject: Re: [PATCH v4 1/2] powerpc/bug: Add ARCH_WARN_ASM and refactor
 _EMIT_BUG_ENTRY for Rust support
X-Mailer: aerc 0.22.0
References: <20260912065902.24017-1-mkchauras@gmail.com>
 <20260912065902.24017-2-mkchauras@gmail.com>
In-Reply-To: <20260912065902.24017-2-mkchauras@gmail.com>
X-ClientProxiedBy: LO4P265CA0170.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::9) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
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
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO0P265MB6725:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fde31b3-115b-483f-72e2-08df10f798d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|10070799003|6133799003|22082099003|18002099003|3023799007|921020|4143699003|10067099003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	UCgY0M/oJpvkE7hTNrPIhOZr9foUrzP1S7zF6WHbhZTwYHONCJqP37XY72EWlhCn/ko59/j5ZWHRVj1fDiBKksrFOrroV3aLk8b1iYTOtq8I1ux+oz/4LkME179ky7qUQGMkxDeApLxmuheDrQm4ILlR6dZT3fIi9X7XhIHsBzxXVDUSrIgGdVo/DbcqTlXmH3nFCoQlnzUzUVZ6SYKRutmTlh7BbGejqKaNyQp8JMmqOwkGPD9ys6o3oyDwvq7ByoIUJeIzDcpkVWqYKtJiiFcOEGxEe9L3GZz8lLufhnX4MtV3ujvf350eK2A+GVzkqEfwMeKV1zHPLCBJ2fmhBBDg0wEWA0qIieiUeUmg86NXB9Rd4BAnmAyGr+1LurcYuyoy9MAGW4IOPt8LxnSgxPFiQDjkikKR/PD6209Uj9rwtry5URxExNk88KU6XRcLoxvCNxiWhrA7gXRRQQFTbJ7PDYfGq4GyNJLHEER2QbXd9uHUbv+Ox7PrMxTUh1ryPpiIcTVYU7O1D2Hl45Phajz3jjxMSzm5pB2a/EmFo9wRvc1bA836yqL5+bzrmRrwZDh13fwWIpDTdCfoES3YSv2cMGbIl+GmZSHbpRiM4VQxc02IAAJIYwujs/vxln/D7qzJKjgHlhAlXLIRImXrOmHLVOp3daoQaRQtpchF7IoE9b8Hhf4F5U7txsBGyu5x5Wf4+CcCj0WdpGph8MnuxQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(10070799003)(6133799003)(22082099003)(18002099003)(3023799007)(921020)(4143699003)(10067099003)(56012099006)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnYybFgvMGl3V3Bwd1FpY1ZMeFRDK1FPaUJJdm91azRBUEpScDNWdGZFdTFo?=
 =?utf-8?B?ODl6K25BMmRCb2ZRVStiN3I0dEU4ekhYTWV0dzZPYklWeitPNy9RSmVFdHRB?=
 =?utf-8?B?OU5KbnBWcUNLSEVhREJpS21uWHExbXdPaG5sb21zTlBKSmJweTJFR0lrMTZJ?=
 =?utf-8?B?cUNnR0MwcHVxWXJ4MytwakpHVHpUN09NZ29jK2dySW1HcDRlSVlIZFQ1czI0?=
 =?utf-8?B?QU8xY2c3T09FODN1U2dTRlJJNXFMbkRudjhyUGJnSENJM2JGeEJqenhWNkJW?=
 =?utf-8?B?Zm16M3p2VUV0Tjhyc0ZBVzNFSjM0Z3dBMmpFWDZzc2UzVldLZnJmRlhteXZW?=
 =?utf-8?B?Qnk2MTlzbVlTQnk4TzNpQ0wyUzcwR1F0Tm9CdWVydjRpclBoeWtGMUtJbGFp?=
 =?utf-8?B?WmN5NDBMWVh6NXRyZy8vRnZBMkhuUDRvUHFDV21wNS9RVTZDWkNxOWpQY0RE?=
 =?utf-8?B?TERtNExmb29CRVdHa1F3TUJ4eTNTSXVtMEsrNmVqRm02M2RraUMyVko5RVB6?=
 =?utf-8?B?UDlXUUV0bFc2cThibkJsUEs5QWZHUXo4aTQ4WXNldFpTMUwvRXkvSXI1UjhH?=
 =?utf-8?B?Ujkrdkg4VXZ4VlROL2xXUExuNmU5eHpzSnhhK1Z2L3FXVW1JWEtqczBKK3Z6?=
 =?utf-8?B?RXBYRXFEWFFrTE1JaUZ2VjJmY0lqU25FSUNEMHYrSGc3RTh6b1pYRDRIUjBI?=
 =?utf-8?B?WXBxQzBYMERXSHIvL3dVZkF4amVpRXl0L0Fwa2pGVXUzUU5TTGlxVVpWTkdU?=
 =?utf-8?B?T2NoK0xtOTlILzhjS0lJRE9HQ09ubFBXckFlYVVDYzlwY1JpdGRYbU10Qzdq?=
 =?utf-8?B?enlGQ01nV3p2cnNDdzJFSGJTcDhwRDYzQUN5MFZJL3JrbWhhMDUxak1uUDcw?=
 =?utf-8?B?NjB4RklwV3dhdkhCY1VQVmI0WW0rc2l3b29BUkZCUVpIVVhpRVpLWm5UeDln?=
 =?utf-8?B?WHNnZTNmZURXQkJKRVN2Nk9ZSFAzNXdzVERRVWhuZ1dQR20vYzhNQnBEamhP?=
 =?utf-8?B?bzRIRWplUWx1b1U3KzJTV2ZMUkFPRElVOW5UdGhoajV5UlhuSEYycTF1K3V0?=
 =?utf-8?B?WVllWXpYcndoZUkzdXBIT2dSa2ZWcjgwMWM2QzJpWnFTeFRxYkt4WDNyY3A3?=
 =?utf-8?B?bnIycCtoMzVYcTV2Y25Keit2NSs5VTcxU0tIWmN5Z2dPUlVyTXhFNTFYRzZ1?=
 =?utf-8?B?Z2x5eU1ScFd6dXBCOHZYNjU1MDc1OEd2S3I5RnVpVFdvbTNxdUtBdjBqVWEw?=
 =?utf-8?B?NkpDVnorVlErdXRHYUFjcDRpSFNIOTQ1VlpMa29jZVl2dWtGQjVsaDl3dE5y?=
 =?utf-8?B?ZzlNMmlGTDMvQjJRQ3lLNUIzYUpiYlVDNnZhUExPTENmRmRGZTg4a1NjWFpi?=
 =?utf-8?B?bm8xaXRiWHgxZ2VmdUtuV21SMnN0ZGtHY2FnRW5adXB2RW1UVm4rSkcwMmJw?=
 =?utf-8?B?K0xibVhoOUtWZVR0TWxVYVI3cWxxVGNCdGhvaDdrSE1KaXNQWXducEhWb3ZK?=
 =?utf-8?B?OE5LMkhuNjdGVHJSV0pQZ1ViZWdUYVZtbWRGYW0xRHhmZWhWRkFMZWFRL1BQ?=
 =?utf-8?B?cnBrVUU5d3htVVNLcEtpQnpOdVFaSEdsN3BKMDhOdjVwRTVnRFBwUXpnL0lv?=
 =?utf-8?B?TUY2L0RaSWp4MUhseWozczEzRVZnbDFZOEplOHNoUjZQbWFpeTFMMmdhMmlE?=
 =?utf-8?B?RzA4WXJaWExlNG52UmkxSXhXSW04WUw1Wm42OFB3S2pPQXVHUkdvWGdEV1hT?=
 =?utf-8?B?TmpFYk1wVFdKd01NWVBGT09wdmFPbDd5U3ZnN2FUN0Z6VktiQjArbjZuWWcz?=
 =?utf-8?B?R1lsaEV3dDZyaVdaSDBmV2pteTNkdGpDUHU0dVMwRkpXWUhTK2FuZFhxTTdI?=
 =?utf-8?B?VlY2TDF4bjRBdXB2VTVia1A3YzExNzZyUzd0UFRFRlZweFhKSzgwUjFkeThn?=
 =?utf-8?B?ZU9hZk1kTjArTjc5Uk9JM0d1SnMxQStobkszd1VMM1pVUlp2SkFPRUFRZFla?=
 =?utf-8?B?QzlsSWN0M1gySE9YQzNHckExazMwSGRjeHhJVnpkMWZYdE5PaEZjS1ZlMHpy?=
 =?utf-8?B?eXk5S0lpZDJhdHRNYXdsSDYzVTlyaUZtUXFjWWZVMmcvL0JIZTMxbkFpeE1Z?=
 =?utf-8?B?cllVV0wvUC9RUUxDOXR2ZnhoL2wyUGcxZ0krMHNaUmNRdU1vSTMybkdNV0NI?=
 =?utf-8?B?UVNvMkRaN0UzdFhldVdsZWxOb2ZkaFRwOFhDa3MwTEFPV1loa1NPS090dnI0?=
 =?utf-8?B?SkpYM051a3JCbVVOQlRQOGpkVDhxQ21EblFzdUppWWpvRnZVZlNkZVdla1JK?=
 =?utf-8?B?NFh5dmNHY3Y2UmNWVjZ2czdBUHZRd2JHRVR6VG9mbUFNY2tqRjQwZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fde31b3-115b-483f-72e2-08df10f798d3
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2026 17:59:31.7599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vdOQpLW1kmP6kt/S+emz+U1u6tgoy0LSR3GXswATjY9+68+88dW0JVQMNUZpY02XJzcdr9wgEHe0yPagaOG4sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6725

On Sat Sep 12, 2026 at 7:59 AM BST, Mukesh Kumar Chaurasiya (IBM) wrote:
> The Rust kernel infrastructure generates inline asm for WARN() via
> ARCH_WARN_ASM(file, line, flags, size), expanding it through a C
> preprocessor pass (generated_arch_warn_asm.rs.S) to produce an
> arch-specific asm template string for use in Rust's core::arch macros.
>
> powerpc currently lacks ARCH_WARN_ASM and ARCH_WARN_REACHABLE, causing
> Rust builds to fail on powerpc with
> ```
> error: no rules expected `ARCH_WARN_ASM`
>    --> /home/linkmauve/dev/linux/wii/rust/kernel/generated_arch_warn_asm.=
rs:1:28
>     |
>   1 | ::kernel::concat_literals!(ARCH_WARN_ASM("{file}", "{line}", "{flag=
s}", "{size}"))
>     |                            ^^^^^^^^^^^^^ no rules expected this tok=
en in macro call
>     |
>    ::: ../rust/kernel/lib.rs:279:1
>     |
> 279 | macro_rules! concat_literals {
>     | ---------------------------- when calling this macro
>     |
>     =3D note: while trying to match sequence start
>
> error: no rules expected `ARCH_WARN_REACHABLE`
>    --> /home/linkmauve/dev/linux/wii/rust/kernel/generated_arch_reachable=
_asm.rs:1:28
>     |
>   1 | ::kernel::concat_literals!(ARCH_WARN_REACHABLE)
>     |                            ^^^^^^^^^^^^^^^^^^^ no rules expected th=
is token in macro call
>     |
>    ::: ../rust/kernel/lib.rs:279:1
>     |
> 279 | macro_rules! concat_literals {
>     | ---------------------------- when calling this macro
>     |
>     =3D note: while trying to match sequence start
>
> error: aborting due to 2 previous errors
> ```
>
> To add ARCH_WARN_ASM, _EMIT_BUG_ENTRY first needs to be refactored.
> The old definition was a bare macro with no parameters, relying on
> positional asm operand references (%0-%3), hardcoding the backward
> reference to local label 1b, and including .org/.previous directives
> inline. That made it impossible to compose as a plain string outside of
> an asm operand context, and left an invisible contract that callers must
> always emit their trap at label 1:.
>
> Refactor _EMIT_BUG_ENTRY to take explicit (label, file, line, flags)
> string arguments via string concatenation. This removes the dependency
> on asm operand numbering and makes the trap label an explicit argument,
> so the caller's intent is visible at the call site and a future caller
> using a different label cannot silently produce a wrong bug table entry.
>
> Move the .org and .previous directives out of _EMIT_BUG_ENTRY and into
> each call site, so BUG_ENTRY() can still pass sizeof(struct bug_entry)
> as an asm operand while ARCH_WARN_ASM can supply its own size string
> independently.
>
> Add ARCH_WARN_REACHABLE as an empty define, matching the arm64
> convention, indicating that no additional reachability annotation is
> needed after a WARN on powerpc.
>
> This brings powerpc into line with x86, arm64, s390, and riscv, all of
> which already define ARCH_WARN_ASM and ARCH_WARN_REACHABLE.
>
> Reported-by: FUJITA Tomonori <tomo@flapping.org>
> Closes: https://lore.kernel.org/all/anG67Q6Y59kDqh-c@desktop
> Fixes: 73b741adb264 ("rust: Add PowerPC support")
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> ---
>  arch/powerpc/include/asm/bug.h | 36 +++++++++++++++++++---------------
>  1 file changed, 20 insertions(+), 16 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bu=
g.h
> index 0db48977c70c..6f0f652d9348 100644
> --- a/arch/powerpc/include/asm/bug.h
> +++ b/arch/powerpc/include/asm/bug.h
> @@ -32,34 +32,38 @@
>  #endif /* verbose */
> =20
>  #else /* !__ASSEMBLER__ */
> -/* _EMIT_BUG_ENTRY expects args %0,%1,%2,%3 to be FILE, LINE, flags and
> -   sizeof(struct bug_entry), respectively */
>  #ifdef CONFIG_DEBUG_BUGVERBOSE
> -#define _EMIT_BUG_ENTRY				\
> -	".section __bug_table,\"aw\"\n"		\
> -	"2:	.4byte 1b - .\n"		\
> -	"	.4byte %0 - .\n"		\
> -	"	.short %1, %2\n"		\
> -	".org 2b+%3\n"				\
> -	".previous\n"
> +#define _EMIT_BUG_ENTRY(label, file, line, flags)	\
> +	".section __bug_table,\"aw\"\n"			\
> +	"2:	.4byte " #label " - .\n"		\
> +	"	.4byte " file " - .\n"			\
> +	"	.short " line ", " flags "\n"
>  #else
> -#define _EMIT_BUG_ENTRY				\
> -	".section __bug_table,\"aw\"\n"		\
> -	"2:	.4byte 1b - .\n"		\
> -	"	.short %2\n"			\
> -	".org 2b+%3\n"				\
> -	".previous\n"
> +#define _EMIT_BUG_ENTRY(label, file, line, flags)	\
> +	".section __bug_table,\"aw\"\n"			\
> +	"2:	.4byte " #label " - .\n"		\
> +	"	.short " flags "\n"
>  #endif
> =20
>  #define BUG_ENTRY(cond_str, insn, flags, ...)		\
>  	__asm__ __volatile__(				\
>  		"1:	" insn "\n"			\
> -		_EMIT_BUG_ENTRY				\
> +		_EMIT_BUG_ENTRY(1b, "%0", "%1", "%2")	\
> +		".org 2b+%3\n"				\
> +		".previous\n"				\
>  		: : "i" (WARN_CONDITION_STR(cond_str) __FILE__), "i" (__LINE__),	\
>  		  "i" (flags),				\
>  		  "i" (sizeof(struct bug_entry)),	\
>  		  ##__VA_ARGS__)
> =20
> +#define ARCH_WARN_ASM(file, line, flags, size)		\
> +		"1:	twi 31, 0, 0\n"			\
> +		_EMIT_BUG_ENTRY(1b, file, line, flags)	\
> +		".org 2b+" size "\n"			\

From the current implementation it looks like making "1b" a parameter doesn=
't
really help anything. The fact that it internally rely on `2:` as label is =
still
hardcoded.

I think you should either make the label custom too, so you write

    "1:	twi 31, 0, 0\n"	\
    _EMIT_BUG_ENTRY(2, 1b, file, line, flags) \
    ".org 2b+" size "\n" \

Or you should just hardcode "2" and "1b" and document them.

This stucks in mid-way and is arguably worse than either option.

Best,
Gary

> +		".previous\n"
> +
> +#define ARCH_WARN_REACHABLE
> +
>  /*
>   * BUG_ON() and WARN_ON() do their best to cooperate with compile-time
>   * optimisations. However depending on the complexity of the condition



