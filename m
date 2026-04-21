Return-Path: <linuxppc-dev+bounces-19900-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A39F8FA94
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 16:00:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0Rrw2WDhz306l;
	Wed, 22 Apr 2026 02:00:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c205::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776787216;
	cv=pass; b=fKoEsjDNSShHGSso3m490yuOnFrZPiaFCN+W3XeMid1H6az/E1HQDmvCCHB3o4xvFnKJeHvN/Ft+xQwP9CJRQqTyYIbL+fZfXDfexbW3SLx0YKJGLF7pfguuwGMIpOsH+NwEstlGPQwYlJdlJdDdPnbhvYItOrgGXSro//Nnc0s3NT+1566v7NSLRnQcn81UNB7+nMw8Zzv8UxzHpnWSzrpmLj4ezNOg01p1LQLCK2Rzcy0pfQETtGRBm+Um0MIo+WID+/tR7HMEz29lEhU7NkUKicpLeRd3NFKSr7IiJrpQojqqkfTfDppDI3FwmjqpIfD7wT8Jzl+oIBW0UVqXXw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776787216; c=relaxed/relaxed;
	bh=1bTHkbNebj/z9UmuzvIMY+71l9KjeQJhZkEZyq8vGMc=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=OlYGjUVZBofmNl22Ov1j2sTfeoJ4eqDJCsQO3JMnebDRq8G2bjCVhwuoT8uYRqI47KelFUfjKXVsXR25+ued42au1+SL7dFG6f1fwfxLrf1GdRvSEZZ1/1R8Lic3FzgAzhNRc2QS4+fYAiwprbfCbFrHxHYcNXi2ITbSOWKi9qHd1aWm3GhGHEVVsJ4wx11g5p4//rMXo/p6RRB9dz26USkYqSjHjLbd4fD/8C0s0edk11b8zpH8g0KUIlsbeA3qOuiYc0aNvJ1q1etl7nt3Y9qgbDGUNVKdcFwK1qn617bAvqnDB++JZnv9hX/ifHbbGcB34R96NOURRWiqEcsx6A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=Z8SDP8zb; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c205::3; helo=lo2p265cu024.outbound.protection.outlook.com; envelope-from=gary@garyguo.net; receiver=lists.ozlabs.org) smtp.mailfrom=garyguo.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=Z8SDP8zb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=garyguo.net (client-ip=2a01:111:f403:c205::3; helo=lo2p265cu024.outbound.protection.outlook.com; envelope-from=gary@garyguo.net; receiver=lists.ozlabs.org)
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c205::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0Rrv4glxz302b
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 02:00:15 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNpBK27Bl+z2Lk+sjKiBHNFX2oOJqETFTuKhEsWhsOt8T6qKpnCyB01i5jS/rSz1iCj9TMjt2aPTop0wFR7fMtMPume4RLrCKu23lu3E2i3yTbu72vc+PWKLkLDiZYJIL/WjZBjTP0Iw+y2yEo3Kv0vpqW4mB00ZCA1Ql0tgVuDaJR5IxjQbATqsf9lKPoo5LFR271hTTGGmJdeuLYRk2k/QDUu4VVEfwe51FJHqtUZ7elD6Hr0+fd38eibI55dHPy07pBmWn3wzqw18A4a2wsgUvjx2bwRZQCkVsut2I5l9VHP/ScTo3vmpziSdVNAorf8XDNKsJii4gxjVybPA9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bTHkbNebj/z9UmuzvIMY+71l9KjeQJhZkEZyq8vGMc=;
 b=VpxcKY8+BXqjF8cQ+Cynmt0bwH7nLeVyVBHNZNMs2xy9I4reGTtkYs1wqaxnpl1AapRh9w6AjyxdQPdjqdV7i6Y2npFR9RCfSl6FG8gz2KlRFh9aWl0JEJIiV4EUdeFBjYiaJy/pnQDkCrI5uJJzDk42hQfmmPTYStnBJFOEZHon8w2wGFqeilkKhneoKYD7I68Ypj44QeLgBjbp9nD4J2jeOGx/BBJoNkVwpwP/xBBbEqks73Kx3czyRB7KMeHRzWQ66NvGYX4yyfRDPL6cRmm4NzZzuqFyjWpLdbcD6zDExACB7oeZT1kiKoXSveSIDO5pW+XyOLIUKc652AdlHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bTHkbNebj/z9UmuzvIMY+71l9KjeQJhZkEZyq8vGMc=;
 b=Z8SDP8zbEeABTkGYpbEdeFrF9Ux9n8rKUaOVJcQFKWtwFTR8Vh6KLKbFtVgEVpkUd3yJQH/jX1puEMJw2tPOSKTyLrXlSX9xzrhOVTLIlOtwagqXWHMh1PkT2PZjqKgDmZdyCmLSrB7KpVXdKjoUmLI4S3oZ2TGHWofKJAuBYAU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CW1P265MB8484.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:26d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 15:59:59 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 15:59:59 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 16:59:58 +0100
Message-Id: <DHYYHUPLMLCE.4XA47SKSSI72@garyguo.net>
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
Cc: "Link Mauve" <linkmauve@linkmauve.fr>, "Venkat Rao Bagalkote"
 <venkat88@linux.ibm.com>
Subject: Re: [PATCH V11 4/4] powerpc: Enable Rust for ppc64le
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260417152253.2312961-1-mkchauras@gmail.com>
 <20260417152253.2312961-5-mkchauras@gmail.com>
In-Reply-To: <20260417152253.2312961-5-mkchauras@gmail.com>
X-ClientProxiedBy: LO4P302CA0016.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::6) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CW1P265MB8484:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c65d8a8-5aa7-44cd-4822-08de9fbf0a32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|10070799003|366016|376014|18002099003|22082099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	zrincHPcv512aH2JTfl2L+OSahOET5Kc7mWIu/6Ldip4igctXVvbYK0U6X5tAy6KVnrAFEMje0Iz/Q2SGSJOuvCIJMvQfMOSA5rPf4Us0osdR2oX2zBFdKlM9uuaLEJ3JzcxG2vSBNTHl9iBORxdw872QFzZJ/LD/7oiBn8QdHq4j0WW/6Asf2SiVc9WlqntxzbG8T1YV/wrd5j7SACTeTlZxyv7uZTjXjApOVuuH79//WWtdUuhUy8Tltt7zdhpddgSQLfGGZHJl2i1wOpEmeVI5bXrZ3G9LMsF827maJIIjGrE5fPh4DAmQft11Y1ccmRil/zh2doyPG3pXqUGuMA9wBtZ4iPo+qE8LyUvbeCYz23lM2tsmU8WMbjzNJSXFJrs5NcILULwkRIln4reeLRQr9+VJc5ePrxfI1cfr6EyEwSc8Db6bvkgVH+l3nVtCgDJxdsLAHcbE0Wm02VRGc3QGK42hqLFKsHo4Hkb6YtmMz23QOlC/SjneF9PE/Ela0TTlurtaOjHp1Q18ujT0fQp0zEK75e9z19wiwmjVvpiBnvB/BPYuaVPAomoGdnOTSp0QEOFRTtKMOKoke0KkA+sCiyF5upUYdMXdhhwX6oAPf1qXaeaUyGmr6QOXvV4qVXmCdy4TPDDqp5HxR256YjigD2L+4513qcHGHQM9oF0DUF4T/Q/ik2HfqSm+ES+q0oV/dPfV++Sd4MgT2ddl0BdrL4p5Bs512jHyy7dWSS9ZlfGowDQ2aVH2h4PIR7vUc1pUyAj9pwcax8VtUNoTbmDqnjoaM0zzH/Ybt+GpFo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(10070799003)(366016)(376014)(18002099003)(22082099003)(56012099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGVRZzE2OVZaRFNBemtMSlJHejhIWnd4d2hucjE3ZTgzYWtYekoxdzdTYTVS?=
 =?utf-8?B?QndTS0xzZXUxTlhHTitwMmR4VFZKSytyckxaLzAzVk5OMXMvdm10bnQ0NFRW?=
 =?utf-8?B?YjNwa0tlWCtMa0IyaG5GbHRGYVFDRUFhQmIxV0xxcWlHckx6TU96a0s0L0Er?=
 =?utf-8?B?TjdPNldtV1FMaWV6UFN5a3RJQnBydTFGVWt3ZTZsL2pqdXFOcnRCSFVmczhy?=
 =?utf-8?B?aUtVcVRzK1p6WlFnVkZ3K1duTG5pK1BFWkJyYjRSbFFvWDFyYjBlem9uTVAv?=
 =?utf-8?B?ZExOSTltcjZiSHVqUHdXcktoRTJ1Qks1SDNRWGh4WHpGRGRZTGZPK0t5bURY?=
 =?utf-8?B?cjlPeXpyT1lKd05WeC9hMEN3VnBYaGxaMFBHYzJDU0RYQitieUJVeUJ5Zyt4?=
 =?utf-8?B?Nk5OQnNWZEJFakYvMldadjZGMmtWZlRQVkNoSjhnaXM0LzBjaCtWQnZXV3Ey?=
 =?utf-8?B?ZHlhTHBEVE4wb2VIazRYdGRXUm8yL0x3T2E2VEVUYVhXd1E4VmRlanpZN2Q3?=
 =?utf-8?B?NzQxMnhvMmR2MVNYTzlpZXplWWdiS2dlUERINHpBdVd0K25tK1N1S3pGSjA2?=
 =?utf-8?B?LzlBU0xtUGhCVld3RjlBbmtRcHN0ZDV1MVNqcEt5U0N0Z0puS1k5MlMwMXFo?=
 =?utf-8?B?S0hrV2ZFMkhKekZTR2czeGVHcVBXNGJkbHhrQUlGVkV5dXlXazVybkZhaTlT?=
 =?utf-8?B?YmxRaWhLcW9vL2FzZmwwaXNodzdSZ05hWU5aUnNPNnM1a1dCYXRqMzBlYWhm?=
 =?utf-8?B?anRkUm9tczQ3cnVDZ1NyaE5JZ3hzWFlYMmx3L1VwWHJ6eFMwSmJVNXJXRytS?=
 =?utf-8?B?Z0E1d1hseGYremE3STR1bnRKTW1iUVhIWEdVdjc3ZTVxclIySXJaUGd4U2Ry?=
 =?utf-8?B?U2hVWWRFaFIxWWFGQ1ZidFo2TFpCRVV2Vm9PbWhQV3ZWMDEyMkNkUnB5eDNy?=
 =?utf-8?B?SnB2bXQ3TjJ4OTdKOXY4MjIzR2VUY1ZiMExTa2hMQjFYZlRjakUvVWhCYmFo?=
 =?utf-8?B?RlVkR09VbGpNZ3FYMXoxREhpN09KSXp2SU5FTy9WRUJMYno3aCtkNFV2eE9D?=
 =?utf-8?B?QXoreEJSN0FJeXJPQzZ5Y1BIanRoREZiSVR6cDFOLzR6SzlxckpwNi9SVG9V?=
 =?utf-8?B?WTZTY004OTVDSmdyb205Q3FrbHNaMzMvQVRpQytUd0diUU5SWDd1RDNpTFht?=
 =?utf-8?B?WGpFcU5VdEVrTStqOS80SCtiTDdsa2FBTHdhbVpIWFE5V2ttUDgrMXNsRURi?=
 =?utf-8?B?LzVoRSt0Z1VmSytkZmJ0a0loTWZVUytpdSt4djRyR3F0V3F2ZDZuaGZjeXRn?=
 =?utf-8?B?RjErKzNOVUtxWWJvUUpjL0swUThwM2JYNzRESjByWnI2UW16SmgyczlaNUNr?=
 =?utf-8?B?NGdWNlZ4cFBZS3ZzNmRoSk9kS3lZeUloKzlvRFdtSHFadTVLS1dnbjFrSXh0?=
 =?utf-8?B?eDNuVTlwZnVlNGRzU0l5ZWNhNXg5QWNNTmJNeGNobk0zdWVRWVFhZDZ0cWl3?=
 =?utf-8?B?ZU5HRXFvd20zY1RmcTU2a01DSGlZeHMxUzVNWGJoZFozQXUxRmoxRkdUZlAx?=
 =?utf-8?B?OGtFQ3NOOWZKK1lzbjF3cWFVcU1qUWM4UFdIY25QQlltWStmdnUrM0hHK2xX?=
 =?utf-8?B?R1hpaG1qcXJVWXhJT1QrOVA3RDhtNEVtMUFkWmdjVXpHamRNa0d4OUYwZWw2?=
 =?utf-8?B?WG5rUm1RL3RZQTliNFl2MVVOeWE3YWRPRXNmWEpGMVcvUkhNekg2dklRaWF5?=
 =?utf-8?B?ZTFJaUVITDh4dFZaSnk1bjEvaFBwQW5VYm5NWFRnaWxWeGZYUFN5dmxZdkFC?=
 =?utf-8?B?VTRCY2Q1QnZZMkx3bUlJaXFyRFptOGlwc1RqUDdDKzYvcGF2K3dzb0FiakVO?=
 =?utf-8?B?TGtoTjBGZ29OOXBab0xWMEM3enpsQlFma25qbkQzckV1YWphYjV0U0RXcFdm?=
 =?utf-8?B?bU5kVkhCUXZvT0J0bjBXak1DdE15cC82bzNPMm1PekJjKzRIaWtBVTcrOG91?=
 =?utf-8?B?TENPQ1JjNmtsVDRTZm9CcE9ocGoxMEFKMEFDOEU4TlRrR0wrRStVeGlEbGJu?=
 =?utf-8?B?R0xFQzQySmlxdmQ1cjFFN0R3NE4xRmt4Z25kSUl3NXNvRE1tSVRNK0dBdUtT?=
 =?utf-8?B?TGVERUtaUnJ6MFNDS3QrZzJyN3BubE1hK0d3bU1TZTdzSlNqcjE0cWJqMFh4?=
 =?utf-8?B?NnZDR2FmZCtZUkdEWWRCUDZlZC9HMDNUa25IZWhVOW5rSjRRcURYZHBCQlQ1?=
 =?utf-8?B?ZVdYZW1mMzZKeHBhSGhFcTUxdDN6dVhIUHgrS29TajROWkZ6cFQ2VTAzT3h4?=
 =?utf-8?B?UFJ3ZVpiVmxUUUw3QjJYTWRVZWs2dEowRmtvaFMyNGdBV0VLNXEyUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c65d8a8-5aa7-44cd-4822-08de9fbf0a32
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 15:59:59.2482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hCaAFhLmeW/8SLRknrQ0kxyXq6vnmzxwou/tmNEQ3/DfdUeI3y6MqG+181aHIWhgL6/yFrLWf98o0nVHPzdo5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB8484

On Fri Apr 17, 2026 at 4:22 PM BST, Mukesh Kumar Chaurasiya (IBM) wrote:
> Enabling rust support for ppc64le.
>=20
> Tested on pseries Power11:
> =E2=95=B0=E2=94=80=E2=9D=AF dmesg | grep rust
> [    0.225728] Initialise system trusted keyrings
> [    0.270961] rust_minimal: Rust minimal sample (init)
> [    0.270968] rust_minimal: Am I built-in? true
> [    0.270974] rust_minimal: test_parameter: 1
> [    0.270983] rust_misc_device: Initialising Rust Misc Device Sample
> [    0.271012] rust_print: Rust printing macros sample (init)
> [    0.271019] rust_print: Emergency message (level 0) without args
> [    0.271023] rust_print: Alert message (level 1) without args
> [    0.271026] rust_print: Critical message (level 2) without args
> [    0.271030] rust_print: Error message (level 3) without args
> [    0.271033] rust_print: Warning message (level 4) without args
> [    0.271037] rust_print: Notice message (level 5) without args
> [    0.271040] rust_print: Info message (level 6) without args
> [    0.271043] rust_print: A line that is continued without args
> [    0.271054] rust_print: Emergency message (level 0) with args
> [    0.271064] rust_print: Alert message (level 1) with args
> [    0.271072] rust_print: Critical message (level 2) with args
> [    0.271077] rust_print: Error message (level 3) with args
> [    0.271083] rust_print: Warning message (level 4) with args
> [    0.271091] rust_print: Notice message (level 5) with args
> [    0.271097] rust_print: Info message (level 6) with args
> [    0.271102] rust_print: A line that is continued with args
> [    0.271110] rust_print: 1
> [    0.271113] rust_print: "hello, world"
> [    0.271121] rust_print: [samples/rust/rust_print_main.rs:35:5] c =3D "=
hello, world"
> [    0.271129] rust_print: Arc<dyn Display> says 42
> [    0.271130] rust_print: Arc<dyn Display> says hello, world
> [    0.271136] rust_print: "hello, world"
> [    0.271198] usbcore: registered new interface driver rust_driver_usb
> [    0.271207] rust_faux_driver: Initialising Rust Faux Device Sample
> [    0.271227] faux_driver rust-faux-sample-device: Hello from faux devic=
e!
> [    0.271297] rust_configfs: Rust configfs sample (init)
>=20
> Reviewed-by: Link Mauve <linkmauve@linkmauve.fr>
> Tested-by: Link Mauve <linkmauve@linkmauve.fr>
> Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Link: https://github.com/Rust-for-Linux/linux/issues/105
> Link: https://github.com/linuxppc/issues/issues/451
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

Acked-by: Gary Guo <gary@garyguo.net>

> ---
>  arch/powerpc/Kconfig  | 1 +
>  arch/powerpc/Makefile | 7 ++++++-
>  rust/Makefile         | 6 ++++++
>  3 files changed, 13 insertions(+), 1 deletion(-)


