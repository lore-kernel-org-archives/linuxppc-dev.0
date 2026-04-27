Return-Path: <linuxppc-dev+bounces-20168-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5601FF8860
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2026 13:04:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g43gd2rRXz2y2B;
	Mon, 27 Apr 2026 23:04:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c205::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777295085;
	cv=pass; b=CgTjhMtNPpGwojTJyERzV4My53KInjI6j+48xUeqqS31HK7kbN2i90NmOhTHwYCoM9CNLFQPClC6E3k81ohX90pda6/MdA3v+jTpWMUYJWKCWHHk7ee+0rLbFoENIFTV+jgt802mQOPGJb7X/qRhXZIfXzp/yYVlqUvXj0H3EIIuSKHNpeplquh8ebDaOBNJjkxM7RkiyexHoSi7c97KqQz4KbD70qR1DVW3VlYX684ZIQHKEnL0jc2kd1lDz5ZFfC0YhRDyAOg1K6zelDnIP4BOZz4TBoFZ5Vv4dBk6juJOnDKwfFGtz7MRYCYM12kuLXCJrx9uJV3DTrGX1RZViQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777295085; c=relaxed/relaxed;
	bh=d3xLuyvBLl8qtpsM0U2sMSWzTtQidgBi49zpQDMRu3A=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=XU/0wbn6V+5T6jeac/NEF2eJ3rPuDAtr5P2JCsfJX9faS9LVEpHJ8O9QyJyXJ4/3B19CWMEWTuZ2pgPDQyHodY/sWsuPRe9JAHhEDbQq5RvB52BbYrmkz8osc95nPvnKwUGag00zvnOY5CstYqM6qx5cGe1ljnGzX006+cNeZkiTniNpUF1rAdBtKrEsp1BN2997ixWXRxCwxXwkqH6evA3A/ss/YWFEOj+cE0zqixsQddZ7CCflbsn31PEElpSprlUiss5gzbXWBRg3f4AC3nl2wICx/XAdfe12Ip2q0wVb/NZcEq8McjdK5+gTqiCmOKP8y8rkyurZpOZNrNNeOA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=W5Zlwskh; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c205::5; helo=lo0p265cu003.outbound.protection.outlook.com; envelope-from=gary@garyguo.net; receiver=lists.ozlabs.org) smtp.mailfrom=garyguo.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=W5Zlwskh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=garyguo.net (client-ip=2a01:111:f403:c205::5; helo=lo0p265cu003.outbound.protection.outlook.com; envelope-from=gary@garyguo.net; receiver=lists.ozlabs.org)
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c205::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g43gZ5hKFz2xlK
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 23:04:41 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iiafj0DWR/NbThmTAysv96WRL/svUtSLXUy1psJoMrfajscnnTrGJnwlbbrYuCd/zMWEs9duZrR1kwZ3Ber+jJo0EzppOZj7rYAszBdzWbXivzXVbDj7z0rN9Ga8Fq5IGAB9Q6ActE7VAaY8ND5GX0zO4yJgsU+tKKBBoALUH5+lmPMtGwUND7MsE48dlZADuzdOjH6lYta1M+hWLALSXRUoM6KI3FUDvGjmWdlRKRdhyjcO0N40FQHWAwyw0H4tv2R7qfl4ly2gmFb48oQfahH26SRQh205uviE+Cmu5Cw6hFm0uYUqisuyqR7ONz7A80xDK/dxG1qK+ZCvYc5Icw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3xLuyvBLl8qtpsM0U2sMSWzTtQidgBi49zpQDMRu3A=;
 b=ocuFMhBAwIwSj5qkHj1VCU1aq/dDhWzs6Rny6/OSPbBVCkSfyWYbYZIodrARedUYYI+HvFkBG0CKytQLwIL0LzlEw29Glpc4MAEylBQ+MRhQhwglmNxHosaVl36SP+QB2yKovP4oiKj115kHeEpcqB/hYIxZdOb86UFvD03z1PexIpPERN1Y71VhSVikNSJDpnna0Yr7yBmXofWPrtiIlpGBKDnQQN7YQgBFF4SPM0qGKR29hXZsc3ADLujQJT3dGjBiDvfmNQiFn5OSgLnRYwFmkJo1LyT2OZhoxLVXTLiF5Li60JGd4B9FtjS9EmeDQoiyXvGQFJm9ZCMQocBEyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3xLuyvBLl8qtpsM0U2sMSWzTtQidgBi49zpQDMRu3A=;
 b=W5Zlwskhrg7KHQEDsv1F9ZhxDjRJ14m0lP28HIkiM2Z/L1bmZRYCgATFA1SUswzvEXhm9TvJrfJm2TwLMRHcd6J1Unb0Iicq5ccm5BpLcR+I0dyrK9o0MQKdxF+IfE6YZtSvXq3Sjgena4mo1qkZk+LDDur77ycKvixrhpKct3o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CW1P265MB9152.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:270::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Mon, 27 Apr
 2026 13:04:16 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 13:04:16 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Apr 2026 14:04:15 +0100
Message-Id: <DI3YIKR2CKFR.27RVO55HH5GED@garyguo.net>
Subject: Re: [PATCH V13 5/7] rust: Make __udivdi3() and __umoddi3() panic
From: "Gary Guo" <gary@garyguo.net>
To: "David Laight" <david.laight.linux@gmail.com>, "Gary Guo"
 <gary@garyguo.net>
Cc: "Mukesh Kumar Chaurasiya" <mkchauras@gmail.com>, <maddy@linux.ibm.com>,
 <mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
 <peterz@infradead.org>, <jpoimboe@kernel.org>, <jbaron@akamai.com>,
 <aliceryhl@google.com>, <rostedt@goodmis.org>, <ardb@kernel.org>,
 <sumit.semwal@linaro.org>, <christian.koenig@amd.com>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <dakr@kernel.org>,
 <nathan@kernel.org>, <nick.desaulniers+lkml@gmail.com>, <morbo@google.com>,
 <justinstitt@google.com>, <tamird@kernel.org>, <arnd@arndb.de>,
 <nsc@kernel.org>, <simona.vetter@ffwll.ch>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linaro-mm-sig@lists.linaro.org>, <rust-for-linux@vger.kernel.org>,
 <llvm@lists.linux.dev>, "Link Mauve" <linkmauve@linkmauve.fr>
X-Mailer: aerc 0.21.0
References: <20260424054742.45832-1-mkchauras@gmail.com>
 <20260424054742.45832-6-mkchauras@gmail.com>
 <DI1E781QPU8F.1C28PL0089NP6@garyguo.net>
 <ae3C2gqzoVaovY-h@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <DI35IFD8M019.2WGRH5ADW6NOG@garyguo.net> <20260426230408.489c68c3@pumpkin>
In-Reply-To: <20260426230408.489c68c3@pumpkin>
X-ClientProxiedBy: LO6P123CA0007.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::9) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CW1P265MB9152:EE_
X-MS-Office365-Filtering-Correlation-Id: e7bcf125-2b74-49a4-5bfd-08dea45d7c71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	u6V4ubftfkaX2vcHzfs4NGsvDBoGOe2oDpHS1Lu5vZOKxPZwKP7MK53KN0QQ8Fj2oWt5EsIgJG3VztsR0kC+u2S6+dxKUWHqzIUgcRsjVJPWTpm6qoya1VMl2VU/tX3QMU7JOPV7XvHU/wvbcDpKJwau4YyMO9ZhkXfJccwLWbxdItxaimHAHf11uu343pz01H7W9MkFHmJi3gq/WmQdAhL4sQnJPgOJztohLTsGQycMyWh3qJf2MOXfzZuIMuFJ89WhEVU1ujFdK7mxhPGhfK9WD94jUcV6LpuG2agRSaeeI7ounlbWc1z2/akEiCjcI3a4yKTrm/U6c7s9qfDqWU4vzTGg/5Vv/nFtxjHfXcPJsbhw1fZ/cfE/pKW8oFufTZaekPntKDjq8ZuMk/ji+pjnnERoQuDn2ZgpEmyAOmwaU1UOmaU0FayNXDBcRAUVgUyLMuxXTI8lt6Twm1xR7daBL4sZbwnEVEYUU7xTPMC/vf0SrxJQLE108jvReL/57OoJj38Dcz/XurVTWkxeYtkYIZZCm9B19JaC1Lo2dmNBFtLDoQ7LwOpt8Kkscb+OxXOgD+Gv0tP+nNG64qJ+GZWheNhqdjmS7aPz7Vm/9psgdZly3P1h68tCNYusUOdQHZhwUL2rjIqr/s6Se9kAR0FYOWWsr4xc4/GutIo+2YmfKVbOW/i+xNZnxTKs7oGOYP/DSdgiP7AhmxMaRu/aUdYsFAL4ObjcrI2KFmaawgA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVpsK2kwYVM0Z0s5TWluWUtack9RZTgrbGpNMTZFamFKYjltKzFaMGl0RHV2?=
 =?utf-8?B?Z1BQcHB4ZmdlZlgzNjVzUXVTRVp5dlJhU3ZqbWpWSzgzR1BGOEdvVDlnTEoz?=
 =?utf-8?B?dHIwbm5kUEVHanRNVTNkZG51Ui96NGVEYldkMXpIU1dUZDN5TG1JSVBNbHRi?=
 =?utf-8?B?Rm5ONmhJbVRDWklabEs5Sk82dkVZNWxXRXBvWVA0V3ZlTFpNTXBkWHNuZnNx?=
 =?utf-8?B?T2pMSm1aRGQrbmVMTGtiZmIyTkE2MzR5VFlTTlM0OTd6Rjh6TzlZcUlRbGhG?=
 =?utf-8?B?V0JUSHVuTjZKSWw4OVJsaGtvQVFhd1lmRFo4azZEMmNmV0lDK0djVFFoWnpl?=
 =?utf-8?B?OEVwNndVUjkwcFRpeDZLc0tmRENXb2pONHFqTis2cWJQaU1WVjR0MlhLL1M3?=
 =?utf-8?B?M2xUbEtoc2kvM0ZZRVFqOWJRZ09sOHQ3cksvWmcvT3M4MnBScFNvckdVdERU?=
 =?utf-8?B?alFjQ2lzS2RPSVc2U0F5bGZ1MDFnZFkwYVM4VmlBbFVVdnkxS05HUGZpcnlG?=
 =?utf-8?B?YkgyQjRNcWRKN0MydjU5ZU1CWGVDZEEya2tsQlM2YmdrU2h5VmVYbUcwV3Fo?=
 =?utf-8?B?VEhlUUNrTnBhMGhXTGpydWFoVTQ3ejNqek90d29mZkt5TEtYMHVyaDhwS01Z?=
 =?utf-8?B?Y1BLSWlSZ1VoZU9tQ0lpTlp1OFJvVFFwMTR4UVY1MkF5K0JEY05qKy9vWDZv?=
 =?utf-8?B?VmRrQnRQdVZ4bmh4dnVDV2F5ZC9qYWpJTXY0Wldma0ptL0EvdGMvQ3dXSHls?=
 =?utf-8?B?R1hWTjdWRy9xZW93UlQxMEtGOHFDWldkTEJ1ajdldW1FcUtmMkI2blZOSlc1?=
 =?utf-8?B?cENzdWtOVktsdHNITldVVE4vRXpUUmpndGxia2wvaVhiR0xOZ3lRUWN4MUM1?=
 =?utf-8?B?ZVFCYlZsTXlHSHhid1BpS2cxUSsrOUlhWkUvUGFhTjRYVXB1ZUVMV1BCSTVK?=
 =?utf-8?B?SWtVSndPU08rQ0k2TDlZUmpGQVJwODZMZjlERHNhK1M4UXFtSFI5VGhKends?=
 =?utf-8?B?eEtNMGRuTmZrbWwwVUpKbTJQSDFlTTVXaVhzckw5WFdNcVRBWDgxWTE0RGQz?=
 =?utf-8?B?ZFpjZFdGYnpITUs1TzVIY08wSi9LWXZMRGNkRHErNmVTekZJWFdwSjFOTTBQ?=
 =?utf-8?B?QytiUms1c2NMYWd4TU11aGlCT093VXd0dHhVNk9PSlF4VTFhY09XenRsck50?=
 =?utf-8?B?YUtHa3hiekhEeVBQMkV6cm5CZnBuR2Y1RUMxbngvaHNQVUJsT3FrM2NXSGVN?=
 =?utf-8?B?SVFYT1dKZzludThCNXZGcytKVWc5Mkp4VmlLS3p5SFdsQURsRlRDM2JJU0ht?=
 =?utf-8?B?SUo4MzV6cEtXQU1SN1lqT1B5MnhuZnlCenRxanpjUVh3WFRGNXdEMEk1dUIv?=
 =?utf-8?B?UXh1dVg5MW5ISXV4TDdUOGZ5WTZ0Y29VS293M1JtOGwyOWdUSG9IOG0xWFFo?=
 =?utf-8?B?UHdONHFmRDljOUd6dkc5NVowTzBCK05MdWIvSU50clJ0ZGFPTzM5ZkZRZlR2?=
 =?utf-8?B?dzZtYVpnYlVUQjVFSUZTdWhIUTA5UE9sZTljU1B6SVNBYUhZNHRwRFB0Wkdz?=
 =?utf-8?B?Sm9YY0RZYUZJL0dIZGZoT0VqajVhYVJaOUM5ZmtNb0hRT3hiUDFLenRHU1Fp?=
 =?utf-8?B?Nm1JNng1MHVHOXA4RDJNay8rY3h2WnMwUkdUVHhMb0d2UHJkNUZwOXBDODlj?=
 =?utf-8?B?UVVuMTdwbFhmM1hLM0NwbkVya0VpYzdkUGhwWmpCRmRYbjRaV1B2TmZIS1hT?=
 =?utf-8?B?bWF3VHVmYVlJWXhReTV4NU1uQytrK2dhRFhUdlQ2WE01clNLMUV5VXJYQlZp?=
 =?utf-8?B?LzNSaFRtWVM1dlNBWnZTVkd4TGdidXBHTVd6b1lVVisxRi9wdmFTWWxTdWto?=
 =?utf-8?B?dVcvWkltbGx0N0dsczJIR1ZvQ1RoL21zY24vd05ZaVBFQ3JLaTVSR2pJNjJL?=
 =?utf-8?B?eERiTWZ2cHQ0NGEySWJYdExoaGRvTXpLTUUzTkJwNFV0bnZydjhoOENrMXho?=
 =?utf-8?B?MExKMmNobEFMeEkwdkNDWWtOcWFHelZUdnJ1dVBCc25wZ1RLRnRpT1QxZVpy?=
 =?utf-8?B?T3U2elpuclg3WWFnbWN4bnFwVG1Md1NSSjdnQlRHanVJbnlTTXJMUDVadnFN?=
 =?utf-8?B?WjFJRmN5L28xWlhsbmZKTGJ2bzlkK21QWi9QKzBxdXNhZENRa1RoRDFSYmFM?=
 =?utf-8?B?T2JsNmNnMHVDZE5CSGlubFRHcERuTUl4VGx5b3FobzIzYWgvOHVrM25TaWJ1?=
 =?utf-8?B?QU5YTnVXdmlRd3hibXErQXN2UjFGS3Jxd1BSYXJxRk51cjJpc3dqMUMySklO?=
 =?utf-8?B?NWtubExBZUxuRUlsRHBsakpPVDgwS0Vaa3dYbG40Z1BIQXNCekFLdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e7bcf125-2b74-49a4-5bfd-08dea45d7c71
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 13:04:16.0693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oVCGwCYcidIg8U5ZUV3zcOHSVHsCVTnyVqDQOaJqnTp9BTy/lRU7bTvRCMB39jCB2x8PFG7OVgTsMvnqSPLoyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB9152

On Sun Apr 26, 2026 at 11:04 PM BST, David Laight wrote:
> On Sun, 26 Apr 2026 15:20:31 +0100
> "Gary Guo" <gary@garyguo.net> wrote:
>
>> On Sun Apr 26, 2026 at 8:52 AM BST, Mukesh Kumar Chaurasiya wrote:
>> > On Fri, Apr 24, 2026 at 01:43:43PM +0100, Gary Guo wrote: =20
>> >> On Fri Apr 24, 2026 at 6:47 AM BST, Mukesh Kumar Chaurasiya (IBM) wro=
te: =20
>> >> > From: Link Mauve <linkmauve@linkmauve.fr>
>> >> >
>> >> > The core crate currently depends on these two functions for i64/u64=
/
>> >> > i128/u128/core::time::Duration formatting, but we shouldn=E2=80=99t=
 use that in
>> >> > the kernel so let=E2=80=99s panic if they are ever called.
>> >> >
>> >> > This doesn=E2=80=99t yet fix drm_panic_qr.rs, which also uses __udi=
vdi3 when
>> >> > CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy, but at least makes the rest of the=
 kernel
>> >> > build on PPC32. =20
>> >>=20
>> >> Can we always build libcore with `-C opt-level=3D2` even if
>> >> `CONFIG_CC_OPTIMIZE_FOR_SIZE` is specified? It feels like a better fi=
x than
>> >> stubbing things out.
>> >>=20
>> >> Best,
>> >> Gary
>> >>  =20
>> > The issue is not coming from libcore itself. It's the driver that's
>> > causing this. =20
>>=20
>> Sorry. I quoted the wrong part. I was asking if compiling libcore with O=
2 gets
>> rid of its use of the builtins, as that's what the change this commit is=
 for.
>>=20
>> Formatting of u64 will be needed, so we should make sure that these work=
s as
>> intended.
>
> This code (from nolibc) will convert u64 to ascii in any base:
>
> [snip]
>
> Not hard to do without any divides at all.

I mean, the exact same logic is when LLVM lowers code where divisor is cons=
tant.
It just that it decides that the multiply-by-inverse lowering shouldn't be =
done
with `Os`.

In this case libcore is provided by Rust (think it as freestanding headers)=
,
that code is not part of kernel. And currently they just use constant-divis=
or
divide and have this task performed by LLVM. We could ask Rust to explicitl=
y use
multiply-by-inverse to avoid generating __udivdi3 in the future, but even i=
f we
do that it won't be available to already-released Rust compilers.=20

In the mean time we need to workaround this.

Best,
Gary

