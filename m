Return-Path: <linuxppc-dev+bounces-28904-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A70B8CA5FCE
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Oct 2026 04:56:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hynCb744Lz2yf9;
	Mon, 05 Oct 2026 15:56:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791176171;
	cv=pass; b=fmjNDYSZ+n4oAZkLUZ5f0+Xm010ysIX5yZJrmiLEsufbn0b0Vs5EtWb8RssHorWWb+lLd5jdVsqndYhOJ1CKfEhGjCtuaK/x0OYevFuaIdJVQ/mvyp33zdeIAj6dlugrHhRjDwvcj5o2bJHULtbZO0IhmV48QUP9gessP7Fej0w80aGUHy4q93UYbq5M1F8+boc54n6ez29LTXtlF2YHkNPmtmG9o4vJB6ni9Q88rBMBrusG/9TzIIy4orRwk9f33x6thXkO7bTlVYQm7iUQGDV1fGQzsqgabeIiF+Vu9sCEWlM9ZeWMy1iv5Eyf4Q7VfdGnh+eK46dUwMwR0ku7kQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791176171; c=relaxed/relaxed;
	bh=nPEb/8a2cGn67nq2k1mkuW7ZVRq+eCDF67m6uNcZhoE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UOUjVJhRbw3LktXmnwKzvwLHVo/1dVclcHN3QEuJvEUNbnFVrt+qW9z9M+V2QioqZfgWaRlFIVTMOHYq0oPSZoGae05BLUj39/gNrHN6YmxpAUjSCXt4EDEWkPpDtu064YGpomGDZ72iUCvguphTVtMtC6PcRumXuj2v4UTSvh40MP20j98rnDieveD2otlwKNvtIH5fw2agzS0u46aYkPFBzPPCew4w64MdwElRRO6v1TatXfYFKcgWw62eMRuDQK6vRbqhPBahViBfiwXiMznTVwbwKLmjD7XP8+ZeKMzwOT6cEMZudF3KBsmwjW8cWr0/2p+f/9ZqMC3Lu4YMgQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com; dkim=pass (2048-bit key; unprotected) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.a=rsa-sha256 header.s=selector1 header.b=FyQkGA1e; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=christophe.leroy2@cs-soprasteria.com; receiver=lists.ozlabs.org) smtp.mailfrom=cs-soprasteria.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.a=rsa-sha256 header.s=selector1 header.b=FyQkGA1e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cs-soprasteria.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=christophe.leroy2@cs-soprasteria.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hynCZ4QJMz2y7p
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2026 15:56:10 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQbfT4o20vGPiqWUmSIMPUAxZroiQzzfvnW65GERwkU+3RTNFR7RyT6UewYZ4LYU0QX+Ucq4x4/10kcv415dX6Uu3wrNAV0wIN1LEOoXRjfakbE8kbbf+DdeRFgkcVFjII6qEXinaJOE1aZMlnKU3IeZuFia5S63mlhDk8Fk8Rj9fpyYqZqCEwPCim0DUiaTpShy8Jkeu9a6n+PZumrby1aeSJaPuthAkWM/kdVcLV2roLvP7IzHh29D4N6Hxf46YWRnKpLwazOMx8yAeoB3BUfMKUWJDga15OYEknlgIupF6qxXk+vkbp6am+1qCUa+n1n130QSW/ALPoY1w8djAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPEb/8a2cGn67nq2k1mkuW7ZVRq+eCDF67m6uNcZhoE=;
 b=vc53EAvipnfjjLIAdxIgjxEC7ZKMak50BpPnolw3EIajykkPk8G0z5I1KKxOw5ZCCpC/zCzjW3cgyIhir9/8JTpCacHGfnVIExgHYvLZFG7Z5ETv4FjWIOtOyYCUmr59tf4lVpJXPD6qxW4LISDgG+Ftbnv6ROR9hgd2Q/8rThlLyUKqW9LmO0bplOLbIZZpKaWjxumtkyvEnXefC9rdF2r6MMHCtKa5RjBMuOtvB6jy/o9wVwABlaOg7cKc76cOv+UIAdE2pIGFB9uk/VVuCiCw2lgVe+UfHkBVvu/xm5vlWI8rm3pRPz1NAzHTc9XLySsP8arcUOnd9rFj0dgPTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs-soprasteria.com; dmarc=pass action=none
 header.from=cs-soprasteria.com; dkim=pass header.d=cs-soprasteria.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs-soprasteria.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPEb/8a2cGn67nq2k1mkuW7ZVRq+eCDF67m6uNcZhoE=;
 b=FyQkGA1eHtnNrjSXEmkGxw1VJsHRbymqIVP1qj+YYG1I13tnxB/PbTHlbXhKo8NvHNDYMEtwLXfQ0JeUulD9rJe03cjtf5Alszye5KO+wHuvGsJDcV/rPAhl3m42ySqDmMDPqOUX4mWPFoDLjR00TNNPIRqlhEPMQ9hXdjywQhy+KiMeAh2v0GF7z3+tg/zoE0mRXB1vF5ZuP/iJ9SWOhoxRnPb29X5v7UhvemU+DJQYJPmWmCoayqfqz1IGQgPr3fLI612NJLSVrI9xqWhPplib9YgL9a2iXynSljAvsMO0ZsRuwNLG19j8o7LR7hQfSpOuoCaWvznkzXdXvoYL+w==
Received: from PA1PR07MB117361.eurprd07.prod.outlook.com
 (2603:10a6:102:54f::13) by PAXPR07MB7792.eurprd07.prod.outlook.com
 (2603:10a6:102:13b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Mon, 5 Oct
 2026 04:55:39 +0000
Received: from PA1PR07MB117361.eurprd07.prod.outlook.com
 ([fe80::1d89:eaf6:2e3:6d71]) by PA1PR07MB117361.eurprd07.prod.outlook.com
 ([fe80::1d89:eaf6:2e3:6d71%6]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 04:55:39 +0000
From: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
To: Usama Arif <usama.arif@linux.dev>, Andrew Morton
	<akpm@linux-foundation.org>, "david@kernel.org" <david@kernel.org>,
	"chrisl@kernel.org" <chrisl@kernel.org>, "kasong@tencent.com"
	<kasong@tencent.com>, "ljs@kernel.org" <ljs@kernel.org>, "ziy@nvidia.com"
	<ziy@nvidia.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
CC: "ying.huang@linux.alibaba.com" <ying.huang@linux.alibaba.com>, Baoquan He
	<baoquan.he@linux.dev>, "willy@infradead.org" <willy@infradead.org>,
	"youngjun.park@lge.com" <youngjun.park@lge.com>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "riel@surriel.com" <riel@surriel.com>,
	"shakeel.butt@linux.dev" <shakeel.butt@linux.dev>, "alex@ghiti.fr"
	<alex@ghiti.fr>, "kas@kernel.org" <kas@kernel.org>, "baohua@kernel.org"
	<baohua@kernel.org>, "dev.jain@arm.com" <dev.jain@arm.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>, Nico Pache
	<nico.pache@linux.dev>, "Liam R. Howlett" <liam@infradead.org>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, Vlastimil Babka
	<vbabka@kernel.org>, "lance.yang@linux.dev" <lance.yang@linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"nphamcs@gmail.com" <nphamcs@gmail.com>, "shikemeng@huaweicloud.com"
	<shikemeng@huaweicloud.com>, "yosry@kernel.org" <yosry@kernel.org>,
	"qi.zheng@linux.dev" <qi.zheng@linux.dev>, "luizcap@redhat.com"
	<luizcap@redhat.com>, "kernel-team@meta.com" <kernel-team@meta.com>, Madhavan
 Srinivasan <maddy@linux.ibm.com>
Subject: Re: [PATCH v8 04/30] powerpc: mm: add PMD swap-exclusive helpers
Thread-Topic: [PATCH v8 04/30] powerpc: mm: add PMD swap-exclusive helpers
Thread-Index: AQHdUlRCbJ7VUIjfwUWpnFYkjf5EvLbuZt4A
Date: Mon, 5 Oct 2026 04:55:39 +0000
Message-ID: <4a4bf0ca-b21b-4b37-b2e3-9bd8ba343bd6@cs-soprasteria.com>
References: <20261002095503.3585565-1-usama.arif@linux.dev>
 <20261002095503.3585565-5-usama.arif@linux.dev>
In-Reply-To: <20261002095503.3585565-5-usama.arif@linux.dev>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cs-soprasteria.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA1PR07MB117361:EE_|PAXPR07MB7792:EE_
x-ms-office365-filtering-correlation-id: ea2bd5a3-be65-4503-7307-08df229ce6f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|10070799003|23010399003|1800799024|366016|376014|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 TBk+02B+Ty63RhVauyueoiA0Giq/gAr7pzQZC+Z+fUSdVEjUUDFZet1105DehuX7Wn3ICbI3smHXOe2FOfuA+OzP5FdZQCjgEZBwdxY8ZyPjHQncWODtr3PYk4GsMWg6wDBMjvAmABUyGun82i15kGNVltJOp9LipXl591SQXkeH+4d7Yqc0nm9OHtPu8UDRFTE69aqajB4rFXNN/6UxJuSbe9wJ7mq32R7uzLx7l6beTDy5+zwKw75LbrYopEEJ1u4UOVYJu1f+pTFg78grf5OHIqnxoiHjjInkVWrvMCEinCZRJZhivfqik07WW/nVa7w8eVbLN/VQEcF2tz7DUmw5ywmwoKXmKxtmWVI8txALtwDJJsbHyvhf1d/tAGgtYqVIl8KrTGrA5PHAFTZCq2uZytY22E1pqnmrMz9Lm31qDfVmrrDz3+Nise5AmNjD3sifkCail6YbSGtW4qpN1mZqLrFF/RKDsLrQsVC7Fd+5cFcMYcN8ETZt9qgeWnwbd59GwqgIYoG5lypWZFaHnI8P2pT8rbTs7fEcKop3TjsJdwBjgeHNRlO0sZHsuy+qlkS23QF6D87UnnToWC45cpYVsZn/pdL2MYDIfZSioT+1LIhN2VybBvLXldpKcuwyd22HxSmOE8RG00eo/PZGiBJAvMkYvDjMV7OYT10Omy1tL7bVx09e6I0QdIjK+iEnwAArBipcgrTOaWSzOGy6LA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA1PR07MB117361.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(10070799003)(23010399003)(1800799024)(366016)(376014)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VGdFZVlhajJKemE0ZUVPeG9hdUx4elB2OCsyNk01MElQSFRnOWkvVTVBSTY0?=
 =?utf-8?B?NEFVVEdmeWgxSE5pa2o0ZWduTjU2U21vS08waHlWMFcyQ1grUlJUeEZNV3Va?=
 =?utf-8?B?TldsOGlDcmY0dTJqL05DVU81cWYxU2RGZGYxTVZnUDNOaUFaU3QrUDNuL1Ix?=
 =?utf-8?B?K1NFNTRVZDdHbGJkOE5lZDFPY0ZPNmlnODBwVVVtQStuRjd4U1RKUThZS1kz?=
 =?utf-8?B?REppUXdwbFdZVEpmaUV0UFZFUEE5L3F3enJJdkpWVTNDcmd1ODVzZ3F4QWEv?=
 =?utf-8?B?MXdKZndvWGJXSm1DNXdJd29BZ2ZCaTFMYjBQcXkxR2JqT1VJTmNDWndpcEhX?=
 =?utf-8?B?cnRZMFlpOC9UUUo0ZzZJNy9icS9FalpRRTNxa0M5TFdOMXpMVkNmNTBKcEVp?=
 =?utf-8?B?SytROTh6Zm10bzVxemw1c3cza0p4enNMMklZSVVEU01xVm1CQTJkS051L21x?=
 =?utf-8?B?akdYMlRiMGdCdkdSLzIraEtvUG5jQmlyVFZOVkJwZy9LY0h3ZmpINFZaZWlP?=
 =?utf-8?B?K3RYQzYwV0VncTBqSDBQN3hsYy8wckp6c3JlaEJSUE1IdVYwTjVJdEpGNGo0?=
 =?utf-8?B?eHZNRnZvOGppc2RJWEVQdG5PZXU4ZXd6eDl1WmY1Y3V1NkJhcEcxUlpLQW1P?=
 =?utf-8?B?RlFVVjhhT21mZGhOSTBxV2JvajRUdk1hU1hEZEFqN1Y4UTJSeWhlQ1VPZmxM?=
 =?utf-8?B?TUIzY3RaQkxNZTFocmRING1lQ2hhUVErN0hoaVpvUVpwd0cwcGhpZmZObzVi?=
 =?utf-8?B?SHBiNExaaHlxV3NNOGxJaDhPSGtCZmtJYVE5VE03Q1pKYitUTXF2ZjlMSlhv?=
 =?utf-8?B?QVNUK0lyUVQ4ZEhRRG5NVDYxcEJmcmhDQW5UOExEV1lVQXVsMUVkWEYwNUI1?=
 =?utf-8?B?LzFocHNqOUwyNmphOXJUVVRRR1BwWkZNWVlhbmRUaVdVT2pBb1BUbHptRUtM?=
 =?utf-8?B?ck9mM3Z3S2c5MFRGb1p1RldnWXhvaWxSK3pJejhpcFlyYzJqN2k0ZmRrSFc3?=
 =?utf-8?B?N3ZqSGN3N0t5dG00ZENrRWZYV200R0NUV3FQc05ZdFNITWo3b0hGN0JxSjZ2?=
 =?utf-8?B?c2JOa1g1ZFpFY0VWM1hPSDF1aEl3bG9idXYzUGlsNkRuWUNIN20rM1NFQ2Fa?=
 =?utf-8?B?QWVHa2pBOG1oSjFkZXdBZVRYdVpwcytKL0dnT21UazhCSzdWRzRVQUViVnJu?=
 =?utf-8?B?S09MZDlQNzhQRnBBY3FIeFUyQkRHYk1Zc3dGSXdRcnpFb2dUT0tqUGsybXJt?=
 =?utf-8?B?ZWJTMERtVkFqbnFvUHNzN1k1RE9sY0xtdmdlTVFpb081bFNHWTRUOXBaUURr?=
 =?utf-8?B?N2QxWkpJb3FxQUx4Y0ZmRHB6eWJUb0Zzc3dIanI5c012dnhobGl2UmI0R2hx?=
 =?utf-8?B?U0hhTG83OEFZNnB2VDZMc2ZSVlpGVmRubjhFdWUrazFJUDlJVHZFd2pobC9l?=
 =?utf-8?B?UTBXM2hwTFlnMjNlcERPRGdOMmtCTlY2Nk9CMHFBZGR1YjhGaURGeldtUE15?=
 =?utf-8?B?RlcwZlhINGtuVVJ1aGp5VklVcEFSQzdJUW9lOTZXa1hFV3AwYnd2MHVBR0dv?=
 =?utf-8?B?eS9CaFdOa1QxL0d5UzZONXFCUHJZQWJ2NVZjU1ZJR2QreC9rNTgwaVVLZkVm?=
 =?utf-8?B?RUE3c3lHam9zTDhSUDZWL0pHbTdkMjRyRE1lTzU3MHVxZTRORFRNdjZFV0M1?=
 =?utf-8?B?RHE3SGRocmh0Yk9MOGk2NGhPY1RwSCtxbU1LLzJWYUo2SVF1L0VUVUNQUjZx?=
 =?utf-8?B?b0R5aGEvazZScDU5NXRGUTRObTVEYkQ2ZVNHZmJlc3JDRHdZTWIwKzVrVEo4?=
 =?utf-8?B?ZDhOY2xCdlpOZDNIeDBOUE9vOW42RThDRTFTTlIwcnEraUpGSy9rSTgwK282?=
 =?utf-8?B?TGpuQVkrSHc1b2s4b3JaNjVzd0pGaUtTbTl2cTNpdzhpTnVUdzcwNUQzZkxU?=
 =?utf-8?B?Q3BTYmVkQWVPVHpMcjdweTV2ZEVOd0F1cjlxRGt5MXBZU3IxcHM4aEVaVWdv?=
 =?utf-8?B?eEd0clV0VFNobE14STdlSHB4elpXQ1BBUXZHcFFvK3N5R1NaRERwRDF1WXFB?=
 =?utf-8?B?N1lKSGVFNTRidWhnWVlidVJDOUJMcWhFT2N2cXdrWVdjNGtjbStXaGpzeGRp?=
 =?utf-8?B?SmVuWkVpQkIvU3lYZWFWQWdDbng1VkR6QnROYXpRV2I2bDFvSjFpN1F4Y2VD?=
 =?utf-8?B?L1daWTlLNUpOVHVobkNONk00UkYrTkxCSmNMTUorR1BhMHRKb0Z5cjdVWFV0?=
 =?utf-8?B?QWttRXByTEs2TEwzV0Q5UXdJMzIza1lBajRiNkdKVHZPMDQvT0Q3cjJCSFpI?=
 =?utf-8?B?bzhkektKcDFKUWYxd0tjNkZkajJqRzBkeDJQQ0FidmRrOGRnWDd4bnd2Y3RE?=
 =?utf-8?Q?0cLb+mKYYymIRcNYw1+AEfftqiED/M9shkbBelVQyDRzA?=
x-ms-exchange-antispam-messagedata-1: He6QZ0k6Vj3Z+00b5nmgf/swPqFZNDMDSQc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8752F736EA7F8341A815E5AC9A86A31C@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
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
X-OriginatorOrg: cs-soprasteria.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA1PR07MB117361.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea2bd5a3-be65-4503-7307-08df229ce6f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 04:55:39.4320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8b87af7d-8647-4dc7-8df4-5f69a2011bb5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8POoKcuh8h1hx0OdeByBQyzt/sW5WtGwcTn+kWtVwnNTBvKBr1kuteeI4w7UEWOaDJhWBY7+BWXjtxytUSU8vAGEQZGnwANhOaWjyGpn5s1jmKZx9UpUqSJUlAIsYjHJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB7792
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 04
X-MS-Exchange-CrossPremises-AuthSource: PA1PR07MB117361.eurprd07.prod.outlook.com
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-messagesource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-originalclientipaddress: 2a01:e0a:1268:92c0:9afc:451a:f254:8766
X-MS-Exchange-CrossPremises-transporttraffictype: Email
X-MS-Exchange-CrossPremises-antispam-scancontext: DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-processed-by-journaling: Journal Agent
X-OrganizationHeadersPreserved: PAXPR07MB7792.eurprd07.prod.outlook.com

RG9uJ3QgZm9yZ2V0IHRvIENDIDxsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZz4gd2hlbiBh
ZGRyZXNzaW5nIA0KcG93ZXJwYyBhcmNoaXRlY3R1cmUuDQoNCkxlIDAyLzEwLzIwMjYgw6AgMTE6
NTIsIFVzYW1hIEFyaWYgYSDDqWNyaXTCoDoNCj4gUHJlcGFyZSBmb3Iga2VlcGluZyBhIFBNRC1t
YXBwZWQgYW5vbnltb3VzIFRIUCBtYXBwZWQgYnkgYSBQTUQgYWNyb3NzIHRoZQ0KPiBzd2FwIHJv
dW5kLXRyaXAsIHdoaWNoIG1ha2VzIFBHX2Fub25fZXhjbHVzaXZlIGhhdmUgdG8gc3Vydml2ZSBp
biBhIHN3YXANCj4gUE1EIGFuZCBub3QganVzdCBpbiBhIHN3YXAgUFRFLg0KPiANCj4gYm9vazNz
NjQgYnVpbGRzIGEgc3dhcCBQTUQgYnkgcnVubmluZyB0aGUgUFRFIGVuY29kaW5nIG92ZXIgcG1k
X3B0ZSgpLCBzbw0KPiB0aGUgUE1EIGhlbHBlcnMgd3JhcCB0aGUgUFRFIG9uZXMgYW5kIHJldXNl
IF9QQUdFX1NXUF9FWENMVVNJVkUsIGV4YWN0bHkNCj4gYXMgdGhlIHNvZnQtZGlydHkgUE1EIGhl
bHBlcnMgbmV4dCB0byB0aGVtIGRvLiBJdCBpcyBhbHNvIHRoZSBvbmx5IHBvd2VycGMNCj4gdmFy
aWFudCB0aGF0IHNlbGVjdHMgQVJDSF9IQVNfUE1EX1NPRlRMRUFWRVMsIHZpYSBQUENfVEhQLg0K
PiANCj4gQ2M6IE1hZGhhdmFuIFNyaW5pdmFzYW4gPG1hZGR5QGxpbnV4LmlibS5jb20+DQo+IFNp
Z25lZC1vZmYtYnk6IFVzYW1hIEFyaWYgPHVzYW1hLmFyaWZAbGludXguZGV2Pg0KPiAtLS0NCj4g
ICBhcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vYm9vazNzLzY0L3BndGFibGUuaCB8IDYgKysrKysr
DQo+ICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9ib29rM3MvNjQvcGd0YWJsZS5oIGIvYXJjaC9wb3dl
cnBjL2luY2x1ZGUvYXNtL2Jvb2szcy82NC9wZ3RhYmxlLmgNCj4gaW5kZXggZGZmODc5MGEwNDdk
Yi4uNDU4Yzg1Y2ViZmE2NSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNt
L2Jvb2szcy82NC9wZ3RhYmxlLmgNCj4gKysrIGIvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL2Jv
b2szcy82NC9wZ3RhYmxlLmgNCj4gQEAgLTEwNjAsNiArMTA2MCwxMiBAQCBzdGF0aWMgaW5saW5l
IHB0ZV90ICpwbWRwX3B0ZXAocG1kX3QgKnBtZCkNCj4gICAjZW5kaWYNCj4gICAjZW5kaWYgLyog
Q09ORklHX0hBVkVfQVJDSF9TT0ZUX0RJUlRZICovDQo+ICAgDQo+ICsjaWZkZWYgQ09ORklHX0FS
Q0hfSEFTX1BNRF9TT0ZUTEVBVkVTDQo+ICsjZGVmaW5lIHBtZF9zd3BfbWtleGNsdXNpdmUocG1k
KQlwdGVfcG1kKHB0ZV9zd3BfbWtleGNsdXNpdmUocG1kX3B0ZShwbWQpKSkNCj4gKyNkZWZpbmUg
cG1kX3N3cF9leGNsdXNpdmUocG1kKQkJcHRlX3N3cF9leGNsdXNpdmUocG1kX3B0ZShwbWQpKQ0K
PiArI2RlZmluZSBwbWRfc3dwX2NsZWFyX2V4Y2x1c2l2ZShwbWQpCXB0ZV9wbWQocHRlX3N3cF9j
bGVhcl9leGNsdXNpdmUocG1kX3B0ZShwbWQpKSkNCj4gKyNlbmRpZg0KPiArDQo+ICAgI2lmZGVm
IENPTkZJR19BUkNIX0hBU19QVEVfUFJPVE5PTkUNCj4gICBzdGF0aWMgaW5saW5lIGludCBwbWRf
cHJvdG5vbmUocG1kX3QgcG1kKQ0KPiAgIHsNCg0K

