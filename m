Return-Path: <linuxppc-dev+bounces-18982-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A265F3D60E
	for <linuxppc-dev@archiver.kernel.org>; Sun, 29 Mar 2026 18:34:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkNM3511gz2ySS;
	Mon, 30 Mar 2026 05:34:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c205::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774809247;
	cv=pass; b=LO42UCHy5l5EgJDlu+MwO1JETPwwOEugevvSTuQnwndR2nMvH/0n6L0kvX4yjr2xkyuTaf6FVd2+zE3BCtIehgTeOI6PmRlkm/3WAmXFazG5DVgnyZqenWqxahbyIEAfCbf9mHSDqt8V4Qb3PSYZxVvzIIMZn88E3EM0Nj+cZ8/5fvAsg6cuVjOJJhTzQdPrzjYfApqPV04sEPLar63j5tusKyNMC/Gfae9Y8wACKWLRg7zdgtGhET4/R4nAjYMPpSp9OKjJjTJdfC/LbbxLceHCmeM1QjYg0A1ngEVNZ/rD5pyfu4H/FinncV5CSvR52LuHTxvQeM9p6wHJLrteKA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774809247; c=relaxed/relaxed;
	bh=8bUczaAtbLt6hLSCkFfopoQ7kUAr35XpK90jIfz5pQg=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=TLTHLi+QX/B55FRbUDVzBoCGbe3Cf7v9WbD9RhXwEcNqdk82bM+Sr3W863ULmd0QW9VxcAYkfHbNFmpGWxSVtw38LBDizbMIo48I3Kw2nEtKopkjXWbAP0FwlFQ2ZIzSQg/BER/QaPvSRgHp1LbK/bJ68U0I3c88fpdYQcpAMgoCVLBIlOexEPhN56n7Zb1N7RRN1hr5rCZs1mOfQ5mz0LH6tQI/NIqq7dyFlXJJHRLUpP1zBwWyTym1yty9VmAdH9Nk2HDDXDsWuRD0J2XpOCZxmpbCnZivyzOhIXbMaclsHFuTlPYTDnkcTVJG++w66ZFwFZKOw9olEUs/CeZOGA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=FnLNAmvP; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c205::1; helo=lo3p265cu004.outbound.protection.outlook.com; envelope-from=gary@garyguo.net; receiver=lists.ozlabs.org) smtp.mailfrom=garyguo.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=FnLNAmvP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=garyguo.net (client-ip=2a01:111:f403:c205::1; helo=lo3p265cu004.outbound.protection.outlook.com; envelope-from=gary@garyguo.net; receiver=lists.ozlabs.org)
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c205::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkNM25nDVz2xQr
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 05:34:06 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cVsqFD++Y6hNOOK57fXq+zIQ4x5p/ga4UphRQdelqnZCtRe2hg8KaYDfeK4KGwh2Zah480JLRNijPpCWDRMOPaCYabNs4kmfRUnPZ/K5/18v7QyyrOanUZT0uvzHmCjfDwZRTPbWe6t5f6UxN6WW9Gys3RkNCTyfxTGZmWISuc2daRI5pX++pzpYGqFV9woL+61iyxUFx4Fh9A7HsSonvnMGY2HiF8chBWo0B3/YTJn86L+9tnp3noYCMC8eIbXt6Cd21AinejeGnCPQhD44xsr7Fa4ewMdkD0uKKyNYEAB/nt8UKAqHu2DDIpfYd3iI7TckPqJs8uYe1hcy077qRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bUczaAtbLt6hLSCkFfopoQ7kUAr35XpK90jIfz5pQg=;
 b=exNYi3/OCqRL+eUHcr5lk84pJEChPgjct/PTcX8AI2R8/butlO5thHuaJRfq8o+6UKZq3vaoAlwsQIglsXCPdpahrelIIiQexmz0lK28ZowK9SnnjQZcs7lNMTh3hM8unA/vdVQcj/D4KqZWtEAJSX6XqzjaIXXgpeYIRjbd61SraqC7/QyPPsDsFldIFIAPs7wDjIN1+bI8Zl3J0CeFzoioDCY/n9NMP4/pznsNY1tshaIHFoK0Fm+Ru2zAzRYfnuO/32/yXsnfnSwBSkMilTusnoYwkYBW+AgvQqIPWh0dHCBolWVpsjQOioUNFYc1V8bTSDdzWqOeGYjKtCIBIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bUczaAtbLt6hLSCkFfopoQ7kUAr35XpK90jIfz5pQg=;
 b=FnLNAmvPujVZ4nJ35494t9SemfwYZ27VqWJg2B2j5sW2jzLwqakq0iZrgsMzebncaoLQFbhZM9BWiRKucaR3ykh4H4ZrVMMkNm6oChPMiqhf9UjQGjblDtXPcz+2qAtrnp1Ef+EiHlflbg6cwCczjfq6ZxfL30Lnbk4XXPuyQmo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO8P265MB7635.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Sun, 29 Mar
 2026 18:33:44 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9745.027; Sun, 29 Mar 2026
 18:33:43 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 29 Mar 2026 19:33:43 +0100
Message-Id: <DHFHD1CAMGX5.28WBF05Y56EEM@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
 <maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
 <chleroy@kernel.org>, <peterz@infradead.org>, <jpoimboe@kernel.org>,
 <jbaron@akamai.com>, <aliceryhl@google.com>, <rostedt@goodmis.org>,
 <ardb@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <dakr@kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Cc: "Link Mauve" <linkmauve@linkmauve.fr>, "Venkat Rao Bagalkote"
 <venkat88@linux.ibm.com>
Subject: Re: [PATCH V7 4/4] powerpc: Enable Rust for ppc64le
X-Mailer: aerc 0.21.0
References: <20260329160254.2592207-1-mkchauras@gmail.com>
 <20260329160254.2592207-5-mkchauras@gmail.com>
In-Reply-To: <20260329160254.2592207-5-mkchauras@gmail.com>
X-ClientProxiedBy: LO4P265CA0177.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::20) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO8P265MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: 65980465-a809-435f-9b7c-08de8dc1b505
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|376014|1800799024|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	YKScI3u2Rb4eWlP3jKHie8sCPrzsM3CMlA/YZJw03CGibLqUtrdTwguszlqfd1oqwju0iGaR0o9c6gHlBbBH/EcuXyjN6kBVEh2w1/4plBwPHkb5VO5GtCJFVqKnG/Iax7pxjKKGtfJoMfRIj8wk5z3eXs44DhpN+zFC1CkHQ3UoY4T4NRf++Tw5e6Ya0FsGSG/ggiSY5r0FJ+TvZG8Lefj7JkmKDAARkLShmWCoBLEJf0i+YFqifl6Nkg/lBNsJlI2yQpieRhiGFaOvFTdw4kzQSxTLaB5RDMsNv0ota2M5EaTa1vTEqhfv+7G5sZ448dKGGwF57R7T+ffmkrfdlj+G6/R0yKrVeUEkaDTq496+M+WwXCaUHUjTH5NRjAXGAENf7hm+8zixzEunZEPDeQ6WNJcMM9zEjI/+8BLOkYjaL+BuqFQeWs4tPpp4Y3xo8RhUHbZ8Itkw6v1BKQOV2R3Sxz4eWHSC/FrB3Pq/3vK/3PzhFOOpORv5ksDi9gcgNR8VaCWDPnfpxIwZenQUoP305+Aslab8w23LDXq4riEcUBOnGQbIbuesQGhxI6a8kwIhduAqLke+bVWcVX/LZkleKsZQagtzL42mYMUjWZ5W/Y+oysWDwA+i3UnFprEw/4vVes43n2wR6wr8H/ZsZ+Ix75/swn5+Hb73eE5+DO8iazh1xRoG9l2QokB7ujRMyTnxVUYFusyqipswAfWnOXDfjmbXw9VZbHxxjLUXYY42ntdmAum0RIjX0akyDtkVTLrK0Mq/ueD1hMbcSRrTvw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnNpNUtaUXJiL1RaVVp6bXRyWkVSeDZ2MFdCY1R3Z0N0VFA3SnBuc1M1WTNH?=
 =?utf-8?B?WDVoQnJGWVdDNyszNU5JNlJLMXExM1hkanNXWEdGbEpUWXRNY0lkc0RkazNJ?=
 =?utf-8?B?Vk44TUdDcU1lSjFvTHQwdWNackZwWUgyeFpqc3BIUnV3K0ZlK3Y3akx4czg3?=
 =?utf-8?B?a3VFNkF6c1Z6cEdWU2NwdHZWbFUrWHRjT0xWVFlHWCtaMytnU3BBa1BneEZE?=
 =?utf-8?B?MGZtT2UyQUd3bjlxV0ZVMTF1TWdoOWlZTXRlT01meU1BdTdxT2doU1hIVFZE?=
 =?utf-8?B?aFZiSUZ6Vk16eU1ETFFRVXlndWNoRDArU2t0aHBlNFRQdWlURFJXNXFWN0tt?=
 =?utf-8?B?U3RIL1BidDN1Y0t1S1pvb3lrV0FibWRiWWZKQ1hJb0d5RHQ3QlkvRkdiTmtq?=
 =?utf-8?B?Zi8vbkZ3dTNCT2lmRzZwRGE2bDNTWjJNci85aHZnVEcwbkV0QVlXUDNlUmNM?=
 =?utf-8?B?Vjh6Mmlwd081WVEyVHR4RUMwTXg5QUFqVkJMeHJUNERNUTlWRy9GQ1FwYXhz?=
 =?utf-8?B?L2o5cnJqdFY0NkZLa2pYamh5QWNNYjU5QWpOTGlqeFBsYXQwazh4dysxQlhS?=
 =?utf-8?B?dm05K21SK0Ztc1RmMzFzaXJXS1V3Q1RGK2g3a1ZwUk1ZMko3czVFcTA1UDJ0?=
 =?utf-8?B?aG1VWm5GWXZjemJnZDA0RitJbGNxdmN1dHhXbGZpckUxOWtTL1hkeHBuSFRk?=
 =?utf-8?B?T0VJeVk2dlJaZkFWdElYZXFoUjJSbnlZYnNjOWlCTWZIeklaN0VWUmczUTZG?=
 =?utf-8?B?ZGN3SnFSRy85cTlTOTU3YXZDTDgwdWR6MThnTlRNTnFnRHorQno2Z0t0bE8r?=
 =?utf-8?B?Q2NPY21oUnVrS1dLa1p3SjZZU0x5ZmhTbzBFbUVzSStFVjBFS0htZzZ0aG9H?=
 =?utf-8?B?bEFobi9tNVBzTmFnK1h2SGo3bFhPbThlMm45S3JWazZFdXRLOENETFBuL2t6?=
 =?utf-8?B?SGJ5ZjJRK3o5MU50Y2J5SEsxY1VXdzZNM0Z0Q0FLRXB5d1htUG15WjJtSjR1?=
 =?utf-8?B?ZzYvbHg2akxoNUZoT0xhUEJDREF3S2Y5T3ozWElyQU95MkFZWUxOVUxOc2tU?=
 =?utf-8?B?aWZiR0pkTVJEVFpEc0V3eEEwMXVVR25jUkd3dHQ1UDZvZG0va1hWOVVVSEh4?=
 =?utf-8?B?U2U2MUdpUGFsYytGeFhDVytrcGxzYi9Md3NwYWxHWUl0WTZPNFNrNjc0cy9P?=
 =?utf-8?B?THVCb2tOWUVUQVRWWGxpd2xBcG5mOGxnOGNmVVhoN0pUNTB4TmxJZlZseGQ4?=
 =?utf-8?B?V1VqY3R2dWRubE1ORDlHTlpYMFQrVVJkWDRFeVZVdkgyOE1ZR0JySmRyVzlv?=
 =?utf-8?B?VURwd0U4SEtpbDdCbnNLMENUNGt4a1h0NjVwWDdNSCtiOTVibVpjQkNWNXll?=
 =?utf-8?B?elU2Nml3NWdjTFBjazNKaGlBWitmTnpNRUp2TnM2UjRwcUthcFo5MVdGT0hq?=
 =?utf-8?B?Z1NqUjltK3NEMDRNNk0waFFZMU05OWYySEN5bnFkeWhrZ3RTRkdmdm9KMkFs?=
 =?utf-8?B?cys3d2thbERUaXFsdzlXYnYwcE42dCs0dkJjUWRGNzYzT3JwZVZNVlMxdXc1?=
 =?utf-8?B?WURpNWRxdHd4RW1YekR6bkJGblVmUEZXeUcxZUYwUEUvSnBVZ1Y2L1NFOGdN?=
 =?utf-8?B?WUc0SWljblU5K0FvMHBZWmo4RDBUVEw5WHc0aTk1SFgwUStQVWg2R3NIeE9V?=
 =?utf-8?B?TkVINTVEakg4UE51N05nbTBXWWoyRnJHY29KUkIxT2ZpWEpoRzUxTkVDaFBQ?=
 =?utf-8?B?RHltUFB5eTc4cWs5UzBsZG5kck1aVW5HSDJnR1gwbEtHdUI0aXRPaHdaeGgz?=
 =?utf-8?B?MGJ1bVF0aGlWUHZ5VDNnYlVWY0ZOMHkyeHBDTUprSlVvL0toN1lDYUk3Z2dD?=
 =?utf-8?B?WEYzV3dLVklWRVEzSFVyS2FLVTliUmIvV3Y2ckIvL3ZjRUlTUDZSbEpxQWJV?=
 =?utf-8?B?U2ZUay9jV0xzYll5NHhpakFoYjZOOHdzUXBFblljY245QlY5eXdudjkxOEkw?=
 =?utf-8?B?SDhWRWJCWlJNS2pZTlUxOC9NaVNJZVNhN3Q3ZDhEamgrUjVqcVlSaTU2MHB0?=
 =?utf-8?B?RWNNVXFqb2dtbEVpaEtsbkExRWVQLzQwY0phMTNtYW5YVy82c0ZKdHkxRmZq?=
 =?utf-8?B?T2xUdGo2eVE3SURJL2d6ZU0vRnduaEwrRFFjNzR1ZEZwSTlzWFVXcGJCZldk?=
 =?utf-8?B?NVlaU2VQZWZjVmNIeURsTTZ3OEpUajRTd0tOc3UvY1VTaS9qSHhHQWp6ZHFy?=
 =?utf-8?B?NDNnSFlWZVhwczJzNzF0dnNldnNhU2xXaXpVOUlmZ0c5QmxTb29INzE0L00w?=
 =?utf-8?B?RnVRUk5DYW1FRzNURUtlbmtraFBDUFBsamtkSCtsemxiekVobjdoZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 65980465-a809-435f-9b7c-08de8dc1b505
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2026 18:33:43.9112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zftg9GWuoeRwSo2y6TS7nHlXfsGChOPdzsiDSWBZg5UQepl0Lc0cWoNFSHyKExlgUk4iCIbegz+wYyIc3yEtbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7635

On Sun Mar 29, 2026 at 5:02 PM BST, Mukesh Kumar Chaurasiya (IBM) wrote:
> Enabling rust support for ppc64le only.

This line looks inaccurate now given previous commit just enabled it for PP=
C32
too.

>
> Tested on powernv9:
>
> $ uname -rm
> 6.19.0-rc8+ ppc64le
>
> $ sudo modprobe rust_minimal
> [  632.890850] rust_minimal: Rust minimal sample (init)
> [  632.890881] rust_minimal: Am I built-in? false
> [  632.890898] rust_minimal: test_parameter: 1
>
> $ sudo rmmod rust_minimal
> [  648.272832] rust_minimal: My numbers are [72, 108, 200]
> [  648.272873] rust_minimal: Rust minimal sample (exit)
>
> $ sudo modprobe rust_print
> [  843.410391] rust_print: Rust printing macros sample (init)
> [  843.410424] rust_print: Emergency message (level 0) without args
> [  843.410451] rust_print: Alert message (level 1) without args
> [  843.410477] rust_print: Critical message (level 2) without args
> [  843.410503] rust_print: Error message (level 3) without args
> [  843.410530] rust_print: Warning message (level 4) without args
> [  843.410557] rust_print: Notice message (level 5) without args
> [  843.410594] rust_print: Info message (level 6) without args
> [  843.410617] rust_print: A line that is continued without args
> [  843.410646] rust_print: Emergency message (level 0) with args
> [  843.410675] rust_print: Alert message (level 1) with args
> [  843.410691] rust_print: Critical message (level 2) with args
> [  843.410727] rust_print: Error message (level 3) with args
> [  843.410761] rust_print: Warning message (level 4) with args
> [  843.410796] rust_print: Notice message (level 5) with args
> [  843.410821] rust_print: Info message (level 6) with args
> [  843.410854] rust_print: A line that is continued with args
> [  843.410892] rust_print: 1
> [  843.410895] rust_print: "hello, world"
> [  843.410924] rust_print: [samples/rust/rust_print_main.rs:35:5] c =3D "=
hello, world"
> [  843.410977] rust_print: Arc<dyn Display> says 42
> [  843.410979] rust_print: Arc<dyn Display> says hello, world
>
> $ sudo rmmod rust_print
> [  843.411003] rust_print: "hello, world"
> [  888.499935] rust_print: Rust printing macros sample (exit)
>
> Reviewed-by: Link Mauve <linkmauve@linkmauve.fr>
> Tested-by: Link Mauve <linkmauve@linkmauve.fr>
> Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> ---
>  arch/powerpc/Kconfig  | 1 +
>  arch/powerpc/Makefile | 7 ++++++-
>  rust/Makefile         | 6 ++++++
>  3 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 1246b3add8ff..a5f50434daf3 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -285,6 +285,7 @@ config PPC
>  	select HAVE_RELIABLE_STACKTRACE
>  	select HAVE_RSEQ
>  	select HAVE_RUST			if PPC32
> +	select HAVE_RUST			if PPC64 && CPU_LITTLE_ENDIAN
>  	select HAVE_SAMPLE_FTRACE_DIRECT	if HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CAL=
LS
>  	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI	if HAVE_DYNAMIC_FTRACE_WITH_DIRE=
CT_CALLS
>  	select HAVE_SETUP_PER_CPU_AREA		if PPC64
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 589613eaa5dc..9385db478c59 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -61,7 +61,12 @@ else
>  KBUILD_LDFLAGS_MODULE +=3D $(objtree)/arch/powerpc/lib/crtsavres.o
>  endif
> =20
> -KBUILD_RUSTFLAGS 	+=3D --target=3Dpowerpc-unknown-linux-gnu
> +ifdef CONFIG_PPC64
> +KBUILD_RUSTFLAGS	+=3D --target=3Dpowerpc64le-unknown-linux-gnu

It looks like all it takes to enable PPC BE is to have

#ifdef CONFIG_CPU_LITTLE_ENDIAN
KBUILD_RUSTFLAGS	+=3D --target=3Dpowerpc64le-unknown-linux-gnu
#else
KBUILD_RUSTFLAGS	+=3D --target=3Dpowerpc64-unknown-linux-gnu
#endif

(and similarly add bindgen target)?

I think it might worth having PPC32/PPC64/PPC64LE all enabled in a single
commit, and then you can just claim Rust is enabled for PPC and have an
unconditional

    select HAVE_RUST

Thoughts?

Best,
Gary

> +KBUILD_RUSTFLAGS	+=3D -Ctarget-feature=3D-mma,-vsx,-hard-float,-altivec
> +else
> +KBUILD_RUSTFLAGS	+=3D --target=3Dpowerpc-unknown-linux-gnu
> +endif
> =20
>  ifdef CONFIG_CPU_LITTLE_ENDIAN
>  KBUILD_CPPFLAGS	+=3D -mlittle-endian
> diff --git a/rust/Makefile b/rust/Makefile
> index 7ea7570e3f17..7fe4cbbd176e 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -410,7 +410,13 @@ BINDGEN_TARGET_x86	:=3D x86_64-linux-gnu
>  BINDGEN_TARGET_arm64	:=3D aarch64-linux-gnu
>  BINDGEN_TARGET_arm	:=3D arm-linux-gnueabi
>  BINDGEN_TARGET_loongarch	:=3D loongarch64-linux-gnusf
> +
> +ifdef CONFIG_PPC64
> +BINDGEN_TARGET_powerpc	:=3D powerpc64le-linux-gnu
> +else
>  BINDGEN_TARGET_powerpc	:=3D powerpc-linux-gnu
> +endif
> +
>  BINDGEN_TARGET_um	:=3D $(BINDGEN_TARGET_$(SUBARCH))
>  BINDGEN_TARGET		:=3D $(BINDGEN_TARGET_$(SRCARCH))
> =20


