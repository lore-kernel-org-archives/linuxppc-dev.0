Return-Path: <linuxppc-dev+bounces-19279-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE0CCE8536F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2026 15:09:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnMZj2Nsrz2yjV;
	Sat, 04 Apr 2026 02:09:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c205::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775228973;
	cv=pass; b=IiXd7vam5LVuz8KC1057cLBsbR+wYWlRB9BlkU8E2mqP+E4L2PkyvuiWhoeWRrIZb1SGP2+GK+wT9mkMA5YOtIGZThZCokbbGNfepW2csUadIGIzuaQeyarMAdZpEI5hxwcjNmAD2Pqujiz09MoSBtEUWcvC3YnyNuDvHYsAOS++4HJHPm82ihOOHtnMi/Dzqtv+YSn4AlRQ3/Z6qc9m90ecVZadGQysRzVyhDu6mv1Fw8YMsRVJ2gyuP3xr1kPZWYaqyY/jIvBoYZcVhssapSqx5XTkvHf9Sh9cbfuY1BkObZuUm1g0UwL5hZkBrH/6997SyaoKLl+OtPfRTDWrWw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775228973; c=relaxed/relaxed;
	bh=a46WExr9ySM8bW7s9P4MN5kQ8+0di83SI6nRfIjfWek=;
	h=Content-Type:Date:Message-Id:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=d1Yj5y3PB+SnvflS9oH2NUC0YnXVDqA6xufKKLX8TII22xR6fnIoT6FvBdW2u/vgK+ng79dsq3Q40AaP6LPigJQfyGxjW1FJ2CBidJv5CNncP3gpXkJlsZOIbBZ0REA8a72QrfqWcM1USgg5YFz34wpeqVRuavYmqyHyfTujk7AjfctIDmtUi++w7nP3HNNGChnnaueqq0EKebb9/jcoSszciQESe+OnA8uAS5Nfb9rRU7Ft+eaBYzvQ5/Z0LheNj8aKW4O9LfyQoLO6FKowLsB5qLZdyKYvayKhACFkOezuOqMHUbqtyBxZXd6JjSYUdH2dVKyYzXLM6RYEaxXvnw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=TLiBOlS/; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c205::3; helo=lo2p265cu024.outbound.protection.outlook.com; envelope-from=gary@garyguo.net; receiver=lists.ozlabs.org) smtp.mailfrom=garyguo.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=TLiBOlS/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=garyguo.net (client-ip=2a01:111:f403:c205::3; helo=lo2p265cu024.outbound.protection.outlook.com; envelope-from=gary@garyguo.net; receiver=lists.ozlabs.org)
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c205::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnMZg1Ymhz2yWK
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 02:09:30 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nscwew6Z+L1y7JqLGQRL1Ni7IzVuX4ZLc0wEd9zOb4b7gXAy+LXEGjs0frZHY8Fxh0q54HWMCbXlAOYBGblM8/kc4H+Mngl71ptLVWBXHU8tkvx6yeQq2zuQqpbA20DFJFI7N3MIYHAVHIymdQCDQ1egM4mmiDiu1qP5CreQpRgWBjUl0jEs/z8Wnz9F39CvdBvctOLMIFx0ZjvlY6106XY9J5X+byzfprd9hvchM6rVZAceiNm98jdOg9SDiwcG90dU5j/AT0D6x04OgF+lig0AjKUfWQnjU/3HhI2xPgp4TgbV/waY/AA6Zwo0VwlzpSlqErlIR6741FWDnZQGzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a46WExr9ySM8bW7s9P4MN5kQ8+0di83SI6nRfIjfWek=;
 b=Q6oOWJD7df+E0XIvz2P0d8fIehBS4roE5XmW6PpTf+y2soCsT7qOMdJpuBBxTu+2tGaYXB2sFG/ijTJqacJLVHLbm7eBIW5cO5Foz4mHY1Z7wX4ztSLvdUpdMOjTC/+63mvHlkIEmmNzEqxYMNAlYJKAv8MYHZks1A9REsyhA8j68QmraPPGCaCtZb/E36LyeVt6zewdi2B0ztL0zjOLJK6ZmD4hM5MS2vHh+ghRD5Dr3TBRada97gnU/mPCvRqrAJDOqviJ+FDjTOsXHgmqtZj+jmrvRlKenJ86lLu6oco4qXA2FfRMpUYfr1RGmCfvn2GLPgbaavkyUPZq+dcd6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a46WExr9ySM8bW7s9P4MN5kQ8+0di83SI6nRfIjfWek=;
 b=TLiBOlS/gGcOBOKwD5i5cWg3fe9QqkW/5OPKTG/gnqrWrxPCjOSj45JBM+eBkbhPRL6EPKCEfHvGNToWDToMzBolbtY23AAuEVsS674tr2fVReUNygVejcTyU/7Q+ztkvQqvRG7ocQEEVrdiGOAfgvGz9ODJJ6Vbvf1qagqAlVY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB3372.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:16c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Fri, 3 Apr
 2026 15:09:05 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9769.016; Fri, 3 Apr 2026
 15:09:05 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Apr 2026 16:09:04 +0100
Message-Id: <DHJM52JEY7D3.MGKXTZB319ZL@garyguo.net>
Subject: Re: [PATCH V8 1/4] rust: Fix "multiple candidates for rmeta
 dependency core" error
From: "Gary Guo" <gary@garyguo.net>
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
 <maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
 <chleroy@kernel.org>, <peterz@infradead.org>, <jpoimboe@kernel.org>,
 <jbaron@akamai.com>, <aliceryhl@google.com>, <rostedt@goodmis.org>,
 <ardb@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <dakr@kernel.org>,
 <nathan@kernel.org>, <nick.desaulniers+lkml@gmail.com>, <morbo@google.com>,
 <justinstitt@google.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <llvm@lists.linux.dev>
X-Mailer: aerc 0.21.0
References: <20260403145308.1042622-1-mkchauras@gmail.com>
 <20260403145308.1042622-2-mkchauras@gmail.com>
In-Reply-To: <20260403145308.1042622-2-mkchauras@gmail.com>
X-ClientProxiedBy: LO4P123CA0517.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::20) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB3372:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cff182f-13e7-46c8-aef1-08de9192f254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|7416014|366016|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+uJPTShUwjCViiPzKuML9tE7xzFIRLdhR+lmIbnwp45EZKj3VbdaP6DDh+zStSqoPlIwI9boNqYzW80C84d/0BlluMcLVNbx5m7amV1lLrNbTjNn1g5O1sW8Pbb61s10hzG4Pxjn0VXPXd8WOOkTEGA/OlxI6XmQAzIISpuqSmqnxzwJzlAl5jFc0xb7cTLX5UgjpKhjyWf9jIQQrwxCUXFiOpBOaRc8Uf0DwG4sfXqMPjNptvTteUGVAhhq2fM07nU/vhot9WZyGbD5WHE0xd+YYzL2KY9M6A+7V2zzN/xLTvwFcjk+DmdfN7FWuFoCMXGOomXyvs0ljALSJzvIiOPAvVMQKQibtlslSR8B6ww7GDePStR7NHGgwcm6rmE4OCqAXW33ftzU5HJuN4/l/OlHZo8HjP6G/yoyxjD6JovPt6fCQIM/mP1SomEMr4yywGnc67+0N/ZL/6xQMUgH3um2SKeemV9jqY0p40UYLU7SPkLUFnxl7uwNJZgWe5gHImL0PeXj23/CJBGC0voCof0sUBusYWZgFjCzjBQrMPqQAiJ8KmiTofvfWkyWeuSHaaxbehejWDnUrGuw1xsawXxoJlNqqs03XOnBjEL0NB6fxN9+XlkRz/QrM7q0W6diiihkRB5dJePAo5riAc1BtVkBC+Ad4LJPIbqamKiTuEXVmXpi2h628jZkB1EkJAhMvLY1KVvttEwgogLMC38KXCvQegRJZi9paupgXxtC/1BYmrTre30wmep5oxZX4lXmTfiBY7QLypes/dpFuV3LJA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkJNSW41M0t0SnVNMzcvUTBsYTZkZmdMajFWamdRcHFBOW9zN3hCZElDRnZU?=
 =?utf-8?B?RU1TS1d0MmI0eEpRQ0pBckl2b1dXejJKR2phWG9tWFB3cTVZWTVJcUtQalRL?=
 =?utf-8?B?VFB0ZUw0N0d4b2JiZEFVUEtoMS9tQ3VYTEsvTXlLRDJwY0c1alZINGhZS0JM?=
 =?utf-8?B?LzlZRmdGa0tHaWVFWjFjdzdodmREbGxnYmNFREZwaTJFWHYxcFJPdzRZVGw1?=
 =?utf-8?B?cDIxQWhWa0JrNi9xWlZXOUd0R09ERlFCYUN5TWZ3R0RxcDdVd3B1YTlnY0RP?=
 =?utf-8?B?MGlzelZ2ZWdibW1tOWJxbHFwSjIrLzBZdW1OWkVHcFNmcmI4dGFJZEJUVndk?=
 =?utf-8?B?NjhPNkwzbFlGMzlRcHc0RFp0VWRBanQzOVBVMUJIbGdNMmROUGRzZk1sbkQ3?=
 =?utf-8?B?K3JkRW9kODVxMnVVN0ZoY25wRmRLNWEvOWZnUW5ZelhDQUh0ZVUweW5ScFpE?=
 =?utf-8?B?UUN3eTQvL3JIdnlHdmd6bGlVdjhobWhValYycUU5LytLajlDMk1mbkJuZmN6?=
 =?utf-8?B?M2I2Nk1KY1N4ZU1yMTJYUTJhKzRjUDdxSDNHOVpsWHBJQytZNy9wMVg1MU14?=
 =?utf-8?B?bmVOR3pIbDNvVVUxcXNycVA4eGNTMlhWME9TRCtzekZFWWhRVlJPczJlcFZ1?=
 =?utf-8?B?a1doZ0owYklEUUVxQnpBSnE1Nkx4RE85V1RoWXhaeTFNL1NwTW44WWthc2Q2?=
 =?utf-8?B?N3dBMG1abXVPSEJsaWVnY1pPN3V2bWErNDNNOTNoWHlLd1grQ3pZSFZESjBG?=
 =?utf-8?B?ajVjMFdpT3dHM2JwQjlja3AxY3BwMzdYelBya1hhMEVROE9YZ3JDd28yOTlh?=
 =?utf-8?B?QmF6Mld4cUhmb1J5Q1pMejRHL0EvUEF1bTZrTFUxR2k4ZzdJT3J4S28xUEhK?=
 =?utf-8?B?bVlrZnIwU0t5R0dLelpZQjF1WkNsQWJiRzQxR1NLL1VpMlFuT1NZcnR2OHla?=
 =?utf-8?B?c1krYnlYWFNEL2NwQlR4NjB2TUlCQllBVFJVTEhzb1NzeS82MjlSM1drM0lW?=
 =?utf-8?B?WnQ0WWRuNHF2M2kxcDAweFNOVTlIaTdHNzFBVXJMemh0L2lGNlJFMFNTZXBJ?=
 =?utf-8?B?WDg4ME1tb2tYanMzcU5zT09WK0ZacHJQV3hYOW42aGh2N3VuOUJvVXUzVktR?=
 =?utf-8?B?cWpWODM1M3lpbFVTVzhxLytJamdYd0xxSGhVQVltUjQwdDRtbWJ3ZGorR3dN?=
 =?utf-8?B?bk55YUx2S0w4RGVScFFSalc3aS9ySHNHdktMMXZsU0E2UXJTQjlrQmx2Q24y?=
 =?utf-8?B?TXhmRGZyZG84WlJqZ2sxd0xSd1ZpZzNNRFpmSWtkNEZBVjMwSHhVQzFOR0pm?=
 =?utf-8?B?YzgvalJqYjBPK1dlUVlFeUdGMmgrLzNjR1NkR25pRWEybklnSUNYeHJFT1Ja?=
 =?utf-8?B?NjFRbkRScXR6SzJiYjF5K3hsZmVXaG5SZVE4a0tUNmwxcXNFME9WanlJbVFi?=
 =?utf-8?B?SDJRRngrS3hjZmN4N2FjUHZtREdFZEV6bWpVTFUxcEdhK0JXZkM3QzB6dU1x?=
 =?utf-8?B?a0VSbDFNRGFrcHBwTnJIZ3BBT2Z0MEVuSldpYmZHVm1MTnBjakc1VC9YS3NR?=
 =?utf-8?B?WlFoMjhhR0F4SzRjUEx6L1huL1czRk8ycG9uTDJZT0Y4aVlmVk5KRXhzZzJh?=
 =?utf-8?B?RmRIaHBUZmtJbTR3bmRJaUU2aEs1bjRobFBXbzVOd09Sc0RFZTVmMUw5QkxV?=
 =?utf-8?B?TUs2ZW5FMGlkR1gwY1FnMGtZWmhvN0dTN1dsYmtjUDZsTkFVR3ZlNk5TOElz?=
 =?utf-8?B?NGhJZEc4ODdpU25tQk9zNEZ6eW5HNldaN3BHRTQzQVhqcFFVallJSkdYeHZJ?=
 =?utf-8?B?ejdDbzMwKzhnS3Q5N1drSWYyMUk2U2ZCMWNUcFhEVlFLRFMwTnFkSFQxcEpw?=
 =?utf-8?B?N0ovSkFELzhrcHBhaWllc2d2OUxJeXZRa3lQK0FEUWpYcnZaWUtiYzMwNjBT?=
 =?utf-8?B?amdXZkZlbzFCR0J5MCtkNmd6UFFqZlBhMlZSRStNOFFjSTFGZlhHSEJ5UzNP?=
 =?utf-8?B?aWk4S3FJS3krblR6LzNIOWZacG0vMnlNZktneWlIbURTeE5MY3AySmVzbEUy?=
 =?utf-8?B?SndJekxiMHRKb3pYSURkVVFIMWI3Q3g1TndhM1B4Uk95dGtFTE9zSkZRT1Bh?=
 =?utf-8?B?M3lOd0ltQU9ERnJSeTcyVDBqU0V5YUJIaXpianc5Z3pDZmJZbk4wL0YyUFN2?=
 =?utf-8?B?d3hjbHZYVHNOdGdlY2VyM1hmd1VuNXRTQ2UyUGFYMkZrelJtU1p4and1Wnpr?=
 =?utf-8?B?WlNSMmdOeklSUHcyTm4yL25IVnJpb3BZeXMya0I0WDh1R1Q4dDlaM0NMaVFI?=
 =?utf-8?B?Y24yV1llYkp3cDJOd3ZXdFFSWjY1QTRaZVp2S1J6aW5KSk5peXRiUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cff182f-13e7-46c8-aef1-08de9192f254
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 15:09:05.1098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q3GLhBcMHJPS+xYR9Qedqj8o2GQw11zX7Q0eMjz7xug6+PlXW82viM219s4Il7VfxMQOtbTbjbAx31zIl05vqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB3372

On Fri Apr 3, 2026 at 3:53 PM BST, Mukesh Kumar Chaurasiya (IBM) wrote:
> When building Rust code with LLVM=3D1 with -j1, rustc was encountering
> an error:
> "multiple candidates for `rmeta` dependency `core` found", with two
> candidates:
> 1. The host's standard library from the rustup toolchain
> 2. The kernel's custom libcore.rmeta in the rust/ directory
>
> This occurred because the build system was using `-L$(objtree)/rust`
> for host library builds (proc_macro2, quote, syn), which caused rustc
> to search the rust/ directory. During this search, rustc would find
> both the kernel's custom libcore.rmeta and gain access to the host's
> standard library, creating a conflict.
>
> The solution is to separate host libraries into a dedicated rust/host/
> subdirectory and use `-L$(objtree)/rust/host` for host builds instead
> of `-L$(objtree)/rust`. This ensures that:
>
> 1. Host library builds (proc_macro2, quote, syn) only search rust/host/
>    and never encounter the kernel's libcore.rmeta
> 2. Proc macro builds use `-L$(objtree)/rust/host` to find their
>    dependencies
> 3. Test builds use `-L$(objtree)/rust/test` for their dependencies
> 4. Target builds continue to use `-L$(objtree)/rust` as before
>
> Special handling is added for rustdoc-pin_init, which is a host build
> (to access the alloc crate) but depends on proc macros from the main
> rust/ directory. It uses explicit `--extern` paths with absolute paths
> to reference the proc macros without adding `-L$(objtree)/rust`, which
> would reintroduce the conflict.
>
> The rust/host/ directory is added to clean-files to ensure it's removed
> during `make clean`.
>
> Changes:
> - Add clean-files :=3D host/ to clean the generated directory
> - Change host library targets from lib*.rlib to host/lib*.rlib
> - Update cmd_rustc_procmacrolibrary to create host/ directory
> - Update cmd_rustc_procmacro to use -L$(objtree)/rust/host
> - Update cmd_rustdoc to use -L$(objtree)/rust/host for host builds
> - Update cmd_rustc_test_library to use -L$(objtree)/rust/test
> - Update rustdoc-pin_init to use explicit --extern paths for proc macros

This should go after the tags and ---, so it's not part of the commit messa=
ge.

>
> Link: https://github.com/Rust-for-Linux/linux/issues/105
> Link: https://github.com/linuxppc/issues/issues/451
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> ---
>  rust/Makefile | 63 ++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 40 insertions(+), 23 deletions(-)
>
> diff --git a/rust/Makefile b/rust/Makefile
> index 9801af2e1e02..762bddc868e4 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -3,6 +3,9 @@
>  # Where to place rustdoc generated documentation
>  rustdoc_output :=3D $(objtree)/Documentation/output/rust/rustdoc
> =20
> +# Clean generated host directory
> +clean-files :=3D host/
> +
>  obj-$(CONFIG_RUST) +=3D core.o compiler_builtins.o ffi.o
>  always-$(CONFIG_RUST) +=3D exports_core_generated.h
> =20
> @@ -27,7 +30,7 @@ endif
> =20
>  obj-$(CONFIG_RUST) +=3D exports.o
> =20
> -always-$(CONFIG_RUST) +=3D libproc_macro2.rlib libquote.rlib libsyn.rlib
> +always-$(CONFIG_RUST) +=3D host/libproc_macro2.rlib host/libquote.rlib h=
ost/libsyn.rlib
> =20
>  always-$(CONFIG_RUST_KERNEL_DOCTESTS) +=3D doctests_kernel_generated.rs
>  always-$(CONFIG_RUST_KERNEL_DOCTESTS) +=3D doctests_kernel_generated_kun=
it.c
> @@ -150,7 +153,7 @@ quiet_cmd_rustdoc =3D RUSTDOC $(if $(rustdoc_host),H,=
 ) $<
>  	OBJTREE=3D$(abspath $(objtree)) \
>  	$(RUSTDOC) $(filter-out $(skip_flags) --remap-path-prefix=3D% --remap-p=
ath-scope=3D%, \
>  			$(if $(rustdoc_host),$(rust_common_flags),$(rust_flags))) \
> -		$(rustc_target_flags) -L$(objtree)/$(obj) \
> +		$(rustc_target_flags) -L$(objtree)/$(obj)$(if $(rustdoc_host),/host) \
>  		-Zunstable-options --generate-link-to-definition \
>  		--output $(rustdoc_output) \
>  		--crate-name $(subst rustdoc-,,$@) \
> @@ -193,13 +196,16 @@ rustdoc-proc_macro2: $(src)/proc-macro2/lib.rs rust=
doc-clean FORCE
>  	+$(call if_changed,rustdoc)
> =20
>  rustdoc-quote: private rustdoc_host =3D yes
> -rustdoc-quote: private rustc_target_flags =3D $(quote-flags)
> +rustdoc-quote: private rustc_target_flags =3D $(quote-flags) \
> +    --extern proc_macro2=3D$(abspath $(objtree)/$(obj)/host/libproc_macr=
o2.rlib)

Why not just add `-L$(objtree)/$(obj)/host`? If we go with the host directo=
ry
approach we shouldn't need to explicitly specify the path?

Best,
Gary

>  rustdoc-quote: private skip_flags =3D $(quote-skip_flags)
>  rustdoc-quote: $(src)/quote/lib.rs rustdoc-clean rustdoc-proc_macro2 FOR=
CE
>  	+$(call if_changed,rustdoc)
> =20
>  rustdoc-syn: private rustdoc_host =3D yes
> -rustdoc-syn: private rustc_target_flags =3D $(syn-flags)
> +rustdoc-syn: private rustc_target_flags =3D $(syn-flags) \
> +    --extern proc_macro2=3D$(abspath $(objtree)/$(obj)/host/libproc_macr=
o2.rlib) \
> +    --extern quote=3D$(abspath $(objtree)/$(obj)/host/libquote.rlib)
>  rustdoc-syn: $(src)/syn/lib.rs rustdoc-clean rustdoc-quote FORCE
>  	+$(call if_changed,rustdoc)
> =20
> @@ -236,7 +242,10 @@ rustdoc-pin_init_internal: $(src)/pin-init/internal/=
src/lib.rs \
>  	+$(call if_changed,rustdoc)
> =20
>  rustdoc-pin_init: private rustdoc_host =3D yes
> -rustdoc-pin_init: private rustc_target_flags =3D $(pin_init-flags) \
> +rustdoc-pin_init: private rustc_target_flags =3D \
> +    --extern pin_init_internal=3D$(abspath $(objtree)/$(obj)/$(libpin_in=
it_internal_name)) \
> +    --extern macros=3D$(abspath $(objtree)/$(obj)/$(libmacros_name)) \
> +    $(call cfgs-to-flags,$(pin_init-cfgs)) \
>      --extern alloc --cfg feature=3D\"alloc\"
>  rustdoc-pin_init: $(src)/pin-init/src/lib.rs rustdoc-pin_init_internal \
>      rustdoc-macros FORCE
> @@ -369,7 +378,9 @@ rusttest: rusttest-macros
> =20
>  rusttest-macros: private rustc_target_flags =3D --extern proc_macro \
>      --extern macros --extern kernel --extern pin_init \
> -    --extern proc_macro2 --extern quote --extern syn
> +    --extern proc_macro2=3D$(abspath $(objtree)/$(obj)/test/libproc_macr=
o2.rlib) \
> +    --extern quote=3D$(abspath $(objtree)/$(obj)/test/libquote.rlib) \
> +    --extern syn=3D$(abspath $(objtree)/$(obj)/test/libsyn.rlib)
>  rusttest-macros: private rustdoc_test_target_flags =3D --crate-type proc=
-macro
>  rusttest-macros: $(src)/macros/lib.rs \
>      rusttestlib-macros rusttestlib-kernel rusttestlib-pin_init FORCE
> @@ -525,48 +536,54 @@ $(obj)/exports_kernel_generated.h: $(obj)/kernel.o =
FORCE
> =20
>  quiet_cmd_rustc_procmacrolibrary =3D $(RUSTC_OR_CLIPPY_QUIET) PL $@
>        cmd_rustc_procmacrolibrary =3D \
> +	mkdir -p $(dir $@); \
>  	$(if $(skip_clippy),$(RUSTC),$(RUSTC_OR_CLIPPY)) \
>  		$(filter-out $(skip_flags),$(rust_common_flags) $(rustc_target_flags))=
 \
>  		--emit=3Ddep-info=3D$(depfile) --emit=3Dlink=3D$@ --crate-type rlib -O=
 \
> -		--out-dir $(objtree)/$(obj) -L$(objtree)/$(obj) \
>  		--crate-name $(patsubst lib%.rlib,%,$(notdir $@)) $<
> =20
> -$(obj)/libproc_macro2.rlib: private skip_clippy =3D 1
> -$(obj)/libproc_macro2.rlib: private rustc_target_flags =3D $(proc_macro2=
-flags)
> -$(obj)/libproc_macro2.rlib: $(src)/proc-macro2/lib.rs FORCE
> +$(obj)/host/libproc_macro2.rlib: private skip_clippy =3D 1
> +$(obj)/host/libproc_macro2.rlib: private rustc_target_flags =3D $(proc_m=
acro2-flags)
> +$(obj)/host/libproc_macro2.rlib: $(src)/proc-macro2/lib.rs FORCE
>  	+$(call if_changed_dep,rustc_procmacrolibrary)
> =20
> -$(obj)/libquote.rlib: private skip_clippy =3D 1
> -$(obj)/libquote.rlib: private skip_flags =3D $(quote-skip_flags)
> -$(obj)/libquote.rlib: private rustc_target_flags =3D $(quote-flags)
> -$(obj)/libquote.rlib: $(src)/quote/lib.rs $(obj)/libproc_macro2.rlib FOR=
CE
> +$(obj)/host/libquote.rlib: private skip_clippy =3D 1
> +$(obj)/host/libquote.rlib: private skip_flags =3D $(quote-skip_flags)
> +$(obj)/host/libquote.rlib: private rustc_target_flags =3D $(quote-flags)=
 \
> +	--extern proc_macro2=3D$(abspath $(objtree)/$(obj)/host/libproc_macro2.=
rlib)
> +$(obj)/host/libquote.rlib: $(src)/quote/lib.rs $(obj)/host/libproc_macro=
2.rlib FORCE
>  	+$(call if_changed_dep,rustc_procmacrolibrary)
> =20
> -$(obj)/libsyn.rlib: private skip_clippy =3D 1
> -$(obj)/libsyn.rlib: private rustc_target_flags =3D $(syn-flags)
> -$(obj)/libsyn.rlib: $(src)/syn/lib.rs $(obj)/libquote.rlib FORCE
> +$(obj)/host/libsyn.rlib: private skip_clippy =3D 1
> +$(obj)/host/libsyn.rlib: private rustc_target_flags =3D $(syn-flags) \
> +	--extern proc_macro2=3D$(abspath $(objtree)/$(obj)/host/libproc_macro2.=
rlib) \
> +	--extern quote=3D$(abspath $(objtree)/$(obj)/host/libquote.rlib)
> +$(obj)/host/libsyn.rlib: $(src)/syn/lib.rs $(obj)/host/libquote.rlib FOR=
CE
>  	+$(call if_changed_dep,rustc_procmacrolibrary)
> =20
>  quiet_cmd_rustc_procmacro =3D $(RUSTC_OR_CLIPPY_QUIET) P $@
>        cmd_rustc_procmacro =3D \
> -	$(RUSTC_OR_CLIPPY) $(rust_common_flags) $(rustc_target_flags) \
> +	$(RUSTC_OR_CLIPPY) $(rust_common_flags) \
>  		-Clinker-flavor=3Dgcc -Clinker=3D$(HOSTCC) \
>  		-Clink-args=3D'$(call escsq,$(KBUILD_PROCMACROLDFLAGS))' \
>  		--emit=3Ddep-info=3D$(depfile) --emit=3Dlink=3D$@ --extern proc_macro =
\
> -		--crate-type proc-macro -L$(objtree)/$(obj) \
> +		--crate-type proc-macro \
> +		-L$(objtree)/$(obj)/host \
>  		--crate-name $(patsubst lib%.$(libmacros_extension),%,$(notdir $@)) \
> -		@$(objtree)/include/generated/rustc_cfg $<
> +		@$(objtree)/include/generated/rustc_cfg \
> +		$(rustc_target_flags) \
> +		$<
> =20
>  # Procedural macros can only be used with the `rustc` that compiled it.
>  $(obj)/$(libmacros_name): private rustc_target_flags =3D \
>      --extern proc_macro2 --extern quote --extern syn
> -$(obj)/$(libmacros_name): $(src)/macros/lib.rs $(obj)/libproc_macro2.rli=
b \
> -    $(obj)/libquote.rlib $(obj)/libsyn.rlib FORCE
> +$(obj)/$(libmacros_name): $(src)/macros/lib.rs $(obj)/host/libproc_macro=
2.rlib \
> +    $(obj)/host/libquote.rlib $(obj)/host/libsyn.rlib FORCE
>  	+$(call if_changed_dep,rustc_procmacro)
> =20
>  $(obj)/$(libpin_init_internal_name): private rustc_target_flags =3D $(pi=
n_init_internal-flags)
>  $(obj)/$(libpin_init_internal_name): $(src)/pin-init/internal/src/lib.rs=
 \
> -    $(obj)/libproc_macro2.rlib $(obj)/libquote.rlib $(obj)/libsyn.rlib F=
ORCE
> +    $(obj)/host/libproc_macro2.rlib $(obj)/host/libquote.rlib $(obj)/hos=
t/libsyn.rlib FORCE
>  	+$(call if_changed_dep,rustc_procmacro)
> =20
>  # `rustc` requires `-Zunstable-options` to use custom target specificati=
ons


