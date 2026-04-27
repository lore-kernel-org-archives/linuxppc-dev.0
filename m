Return-Path: <linuxppc-dev+bounces-20169-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E619FF885E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2026 13:40:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g44SK08pSz2xlK;
	Mon, 27 Apr 2026 23:40:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c206::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777297200;
	cv=pass; b=DzxlQpR3yKNbR/qD7D6SUt++e3fmtie9CNtjzzySJXPsOPwC9tvsZIaq0nVfw0q131JQRr5CiAnq1qcK6kV0F+XZYMY2oFGOuFzYqbRBSXV/29BWyYF0HvkA7MyvaQ4AoFD6WwFzsplDNeDYimMhIku63rtks6UvCEqgwN92lbgJmLuvfIhy5EKNoD8TOQn+gMqkdy5grCC0v9x249tvQUPxzwpzj7WHLe92muMk9UjF9olK/tXtWOKMpzJsLc1HUbnCRZRhZ3ouobmm/dsljuEPb5ELQCtgzTXiRM18XZudYLjf4MSSVcpS2N9FJJm1BmFC0NsNZ5PtRyxwcd6aPQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777297200; c=relaxed/relaxed;
	bh=Mz6Q6Vet4WtSSpzzCPiqs4M4vi/DowaAEwPM7iGZ5xE=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=nHpvsqK6SR2W5ltj2C+OSy0ayE2rdRJ74q4fz/R8PtT8nge5PeRJKN3S9Yw8wRzHAMgV1LpbgQFRQ42rgUzpto8MPrp3dS8LHCZmdUEuGqU3IVK5Ybns5WX2I7R/QvkvdswxxAvhx3b9rC5jvVVVK8tpgFWciKYoHXOlEWjgPamD1khjRGj4SYIzxeGfgRdQMbnSJEqVRzv/P8mpfGFnSuV6T8jOmIy8DddFZq3GMIfn8pDfGWltxnWKFaRGfctbNdJk/L72NesCsd60fziS2gdSOAWeLganPowjjrYvaMQ9I4djPtJlab24R2Uu7qjTIdGExN/ekGkKNwZ13QrpJQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=KhnmXXyn; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c206::1; helo=cwxp265cu008.outbound.protection.outlook.com; envelope-from=gary@garyguo.net; receiver=lists.ozlabs.org) smtp.mailfrom=garyguo.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=KhnmXXyn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=garyguo.net (client-ip=2a01:111:f403:c206::1; helo=cwxp265cu008.outbound.protection.outlook.com; envelope-from=gary@garyguo.net; receiver=lists.ozlabs.org)
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c206::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g44SH6lb5z2xcD
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 23:39:59 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dz4f/767BsEds9W3e4PFyEM3JSE7R/vNsPI8XpbNrj3C8L03+H92zJdJoACdxnCP4LVlFk+ofPcE+a6Yup93K9GzFB/Icoy9rSEEhM4yD9PZqrqndQYhidMCmGgJsFmAZaHrFZQuKBc5YYJUac95TwC37watwNhpneGLh3t4FeDPUh5Kp2ra73yRy0njGtFldyocJIcpfjD7SKYl/p1R/Bb8+BPqp+1nLlIuccZ2gIS7M3nL5NUYgoe0fawOIYcuc5X9gxBOKuzKPcA/HgGC0WzQfGdrmAQkZJIvTpfhmsketeJ72FtLD5SnYUoZM7wsSIRD4Pc53rNAIUwsCFLzfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mz6Q6Vet4WtSSpzzCPiqs4M4vi/DowaAEwPM7iGZ5xE=;
 b=xfOQR8TpPa6fJnUo5+XPG4NYzNbEAxLGPQw0MHoj89JxhP2MSLbzZhKHORbt4DtG3pVWxeKEn7k8dbws3RJ4Wdl1nUx/xyLIUAeBVak1sPC//mLtWOVea/GY/UEWrZHN7wzZadHYIgkhg4xHZeTeVDBuvqC9+kSX/pdgGv0HGkNwIUQo1DfHWx0RgiYM+QVTXyUh5mBZVDxThs6FFmttmYlnI66mEprkhwlNUr3P0877fZOAaHgAU/PBt835IHvyLwFJ5UioGfxNA8BeCQ5iYA6NPgAFYsOOVTwex2KhsEQHf4GCa8qJgIEYFkeGGhPd2ZnfVrK3i0hfbW/nmSv2HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mz6Q6Vet4WtSSpzzCPiqs4M4vi/DowaAEwPM7iGZ5xE=;
 b=KhnmXXynQmKt5NTZG6s43RQXOVSt8THbNGnMhin0RRTaCFPebW4aACDKNYzDEWmhJwb+QCAqV7j8/RC8Z35nU0Q/h91y2rF8kZWnm6T24V00xmORHtYqYzkMAd82drbceP0CAdXm5/I0OjkCLfZVmj+2C6yApqUgeY2JniqTypw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB1944.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:82::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 13:39:35 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 13:39:35 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Apr 2026 14:39:34 +0100
Message-Id: <DI3Z9MKH147K.3C2RZSDKIAGGP@garyguo.net>
Cc: =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH V15 2/7] dma-resv: Fix undefined symbol when
 CONFIG_DMA_SHARED_BUFFER is disabled
From: "Gary Guo" <gary@garyguo.net>
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
 <maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
 <chleroy@kernel.org>, <peterz@infradead.org>, <jpoimboe@kernel.org>,
 <jbaron@akamai.com>, <aliceryhl@google.com>, <rostedt@goodmis.org>,
 <ardb@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <dakr@kernel.org>,
 <nathan@kernel.org>, <nick.desaulniers+lkml@gmail.com>, <morbo@google.com>,
 <justinstitt@google.com>, <daniel.almeida@collabora.com>,
 <fujita.tomonori@gmail.com>, <viresh.kumar@linaro.org>,
 <prafulrai522@gmail.com>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
 <tamird@kernel.org>, <mark.rutland@arm.com>, <lyude@redhat.com>,
 <lina+kernel@asahilina.net>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <llvm@lists.linux.dev>
X-Mailer: aerc 0.21.0
References: <20260426105932.2270364-1-mkchauras@gmail.com>
 <20260426105932.2270364-3-mkchauras@gmail.com>
In-Reply-To: <20260426105932.2270364-3-mkchauras@gmail.com>
X-ClientProxiedBy: LO6P123CA0037.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::9) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB1944:EE_
X-MS-Office365-Filtering-Correlation-Id: ab02506c-42da-4340-b364-08dea4626bec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	rXjwgYjUHQz5rYfHI7pfC1wVIzb9153q/7zxbvxub5cNw44NAGGcsfgqhwTBpv/D763SeKb8/AiFiRcVZ57TxKYNY9ETumlzpDPvr2oAnl4T670zjUzq8QEdHBwfT8GePKl5XPZqey5vCINNIrgT79GN7GS1B3qjHf52HcQZL2JmnmGWVxhpUjyMFGn+jm+/pWP64vqO9gGURVOJSf5Gv1zVe1Hi02/1oeAnmh8Eb3QySHdHlpJwIhZ22Uk8ZOvMGMJiCHHwnQUqFgVn9TYZh3VkgQVsFeXipGjwG4jYElktmSMiTzdxKY5oMZMSOuJQF7/KNxpy28nNe0oCEeGRtUcnX4yuX9A0wMbkf+kgIGtAos0MDi2K320OImhaYsFJgZHvD+TrVG9gkFQyVSDaRl/L6m7rZmuyjA/hgse950uSeA7pyHHGjoq7CJWqn/EAvE/Yn2reQliI4QVP/1aBV+Vo7bD6BLEGh2kZttQkva4Pb01qiPPAUbUG8zs38VHQ0l5Qe4wS5QCleVNSt3rvDwAqn4svEHlHyDFeZsAM85VbqvFmEQXrW2hHCgVNEvaaDtF2reSwfmmFk9DcmlUlY0etqrWQsnRJaCVfyFoCwNKu/rtGNOYoKbhn7Zi2zi8NixOPRqm1JOtzOgXVMdBmAdFI2E+nsUvucmRvnCH8cP683o9xmMDkFL4apR08p8U+RevmrnNyW4Z/z+R2MTKG1OToVpyXwUgG40SQ6TmNR5PJ0AShE7ldky4cjGpg+jgNKuuMR8cF9cPjAzWDigIb1Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(56012099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmkyQWYvV1N4MFVPbExsVE1DS0RxOVIwM0g3dzVFS1NOTXBxNmVScnFrajl4?=
 =?utf-8?B?dVRQVUM5Ni9MK3RlT0VZeHlaOGFYUHhqN3ovdzFpbHB5ZEJXOFpPZmVOYVp2?=
 =?utf-8?B?ejJuMmJ1SkNpTG9zUFZjUlVXU2dNRlZkS3RpQy9lV2ViM2tLZGVvcmdZVjN2?=
 =?utf-8?B?ZzNjMmoxYzBuK0REcCtsOVJFY29qSTl0blB6MmhHcVlNT0pva0JlY2dIVGNr?=
 =?utf-8?B?SVBqTDltcy9lUkI1bnRYYmlMdmVtdzZnVjN6eWxrb3VsbmpTZkplUVZPWWRG?=
 =?utf-8?B?K1NRd3UwOVMrODRBZHgxclpSWHNkMzFITzhGMzYxVWN6VjFINGpqODV6dkF2?=
 =?utf-8?B?UmlWb1ZHOTdMZjF2Q1lncFVyY2RlbC9VYk1vYnhMRTB2Q1BqaFhZZlEzUlhQ?=
 =?utf-8?B?ZGVaZm1zbkk5b0RJYXh4QUttajN0R1JlWXNoSE5ITFV0eklXUGo4WkRoUm1G?=
 =?utf-8?B?VHlld1NaZk05WEhKUWFqdWZrejFTZi9EMVR5aThXVVlDem5IMGw0Wmg0UWU1?=
 =?utf-8?B?NlN1cTV1QTRuWk9Pb3VkSnExRmlYb1BMVGRqeGl5dFRGTkVDUHgrV1ZkMXpo?=
 =?utf-8?B?RWZNODNTVkxnWm40a1htKzltRW1lM3BRdCtnUUVHcDROSGZaaHVONkExQmlM?=
 =?utf-8?B?eDRPNUZNZTZ0VnVMdVJNeHhDQ1E0cWJKdGM0b3BRRUloNUhpMmQyS2piWjVT?=
 =?utf-8?B?Z29VZEpkVG45MjR4VVVWcnVpdUYwb0ZqdUU2dlpHcXZCQ2t6OVJlSnpCZXJ2?=
 =?utf-8?B?em5NTU4yaFc1c0MvMWxMak1UTjNwSnBSRTV0K0FKQUM4S3kwZ3RiVVRENzN5?=
 =?utf-8?B?RUdLZE1XcEpEcmU5WHJhN2lIMVhDYUhScGc0RktJb0M1ZVEwUUdQcHZ1dnY1?=
 =?utf-8?B?a05HZmxHeklWSUNxNjY2QjhhTXBhZXBzOFN2a1VKbkZXclU3cUVnSFJXMUR0?=
 =?utf-8?B?cGZPMWtuTFkreENpdVFUYlY5SGhiT1crU25zQlp3MjZWMXRxQ3Btc241QUlH?=
 =?utf-8?B?d3FEVjRSUnFLaThhUE0xc29ETXFBQ3pQdUlxNEtwSnBGN0RjaXFhblFqcEtr?=
 =?utf-8?B?ckVpKytkN2I1bU90U1V5NmtQbGpWZElzWlBlcnF4VHBaNDRvbWJKUGpwQXRK?=
 =?utf-8?B?MEMvejVKMkhNQk40N2dTM1BNa2UwU3JHRlZaeTdCOER3MW5YUGpXckZsN1BQ?=
 =?utf-8?B?VzRoc0FmZUNPZWlObU1wa05uYW9EaTE5SWNURm8xdDZkVFI0VHpHRTBYTHI1?=
 =?utf-8?B?QUhsWUNROGxmbitZbEpZR1BOb0M0VC9RN2JiQmVrVlJRZWcrZm1lSnBzU0R1?=
 =?utf-8?B?amUzaVdPRjJmUnpQQW5QcGhLdWFOQ1Y1MjlXcHoycjRxVkRHeVRBaDJjVktW?=
 =?utf-8?B?cnNMSXNuQnZ5YWcvMzdpTkpEbmgxMlFqaE45NCswZ1RKVE5lMk9wcXRFQlNr?=
 =?utf-8?B?OTNQZ20zMGgwRGJkNFgyZTBIczZGSWRRc3c5WE5BZkxwQ1F4N2Q5MHJGVFpN?=
 =?utf-8?B?V3NaRDRSZUorVHdQUktXRWFFWWRma0wvbFBwL3BIRXA5eFJwenNLS2ViUk5l?=
 =?utf-8?B?MEdZZXhZQkpuS2hzVDJsbFIzYmgwK2tUMURVcTQ0R2JVSzdwZFVQUUdtaFNR?=
 =?utf-8?B?VXp2QytlQ3FYSVU4eStUbUp4SzJzT2tqNWVsclByMHFuaFJyNll4LzA1bTR0?=
 =?utf-8?B?Q2hQaVVoWFBYY0FrdlR2cDhiTmVLaGJJMnhxOXkwUWdmM2JFdFJFbGUwRGc5?=
 =?utf-8?B?OVZPWGZ0TENodVdhQjBWMGkwTno1bmhMR21VTHlNeVZCUmpsUklNcUxpelg5?=
 =?utf-8?B?YkNqOGN3bnJid2hiUVdXM0NiZ1hLWW5QNXFueGxRNTRGc0NRK0k5UnJKRzVh?=
 =?utf-8?B?M29uS1VJdUxvV3FSYmRJaTEvUHEzODZFRE80bDU3VCszMDFxS0RRbTkxTlNC?=
 =?utf-8?B?QjA1NmVadEV3alJacXZhRy9OMk1rVDNSV29WbnBtcU5mM3p0OHFpNW5FNCtp?=
 =?utf-8?B?UlRKcVFQcVh4TWlQT1k2U0tCcXVOandYSVNXTWVRaWVWVHNEemx6cjJVcFln?=
 =?utf-8?B?QlNvSDFsaHB3aGpFbDVxQzBkU3ZLTytkY3hkSlZaN2t0NG5xRUhwVWlDTnJn?=
 =?utf-8?B?YytucXF5WTFZVXhsUXc0dWswc1VDc1lQQ25DY1QwK1l1TkkrSVRpV2JueitN?=
 =?utf-8?B?MTJ3QnYwM24rUzU0UTF2TXdDejVNaHhZR1JsRysvSnJYZUxqK0lXQ2pMdWNP?=
 =?utf-8?B?VE9PSXozcnRhRk5YYkJvNHVxN3Mrb3dPaWpqRitMdkxmRGtnZ0E0N1dzdXJt?=
 =?utf-8?B?aWMxMzd5Z2kraXA2NzNmRDZ0Q0JXb3F4MzdGY2VDZ2RqeS9pcnY4QT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ab02506c-42da-4340-b364-08dea4626bec
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 13:39:35.8602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gvbyGbacvqTztL7pVt5s9Rz6BxJtO99luCP6mstY0xgeWi088IzgCSd9kcmvW7Uu7I3T9PvXEedu4oWiuaafBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB1944

On Sun Apr 26, 2026 at 11:59 AM BST, Mukesh Kumar Chaurasiya (IBM) wrote:
> When building with LLVM=3D1 for architectures like powerpc where
> CONFIG_DMA_SHARED_BUFFER is not enabled, the build fails with:
>=20
>   ld.lld: error: undefined symbol: dma_resv_reset_max_fences
>   >>> referenced by helpers.c
>   >>>               rust/helpers/helpers.o:(rust_helper_dma_resv_unlock)
>=20
> The issue occurs because:
> 1. CONFIG_DEBUG_MUTEXES=3Dy is enabled
> 2. CONFIG_DMA_SHARED_BUFFER is not enabled
> 3. dma_resv_reset_max_fences() is declared in the header when
>    CONFIG_DEBUG_MUTEXES is set
> 4. But the function is only compiled in drivers/dma-buf/dma-resv.c,
>    which is only built when CONFIG_DMA_SHARED_BUFFER is enabled
> 5. Rust helpers call dma_resv_unlock() which calls
>    dma_resv_reset_max_fences(), causing an undefined symbol
>=20
> Fix this by compiling `dma-resv.c` file only when CONFIG_DMA_SHARED_BUFFE=
R
> is enabled.
>=20
> Fixes: 9b836641d3bf ("rust: helpers: Add bindings/wrappers for dma_resv_l=
ock")
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/helpers/helpers.c | 2 ++
>  1 file changed, 2 insertions(+)


