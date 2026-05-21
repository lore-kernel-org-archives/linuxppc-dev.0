Return-Path: <linuxppc-dev+bounces-21319-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4320CCD5BAC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 12:55:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLpLN0qg0z2xmX;
	Thu, 21 May 2026 22:55:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip="2a01:111:f403:c200::5"
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779368156;
	cv=fail; b=D534E2wAcTAZrmGq/TEj52bgpu0Kh8q327Z6hBYKIe61pwlsId8quRC8C0LLr0OAptYQ/2KQWCigN/0TwJCBuorqA/75h5dQ3B5aFPxcuTWru/IOgIJPttnWULfRExDUA4JXIUQuKfePNOWyFWDMA7WKD8U7PfAwcB8VA/tPI4UcO88B5wjie6OFJrjuuGL6i/X0ZytfgvhZESmpURhC3YTV8o3tzolN58uXzykDzFt30VyNDDKr7UKWNEjU7sV3MHJ0ljhr2cDHmrSiaNKCQsXLAHfHMXu20DvZRvp2Y59wncexwJY/ZNuqjc0EbvJM8ucL4uXoIWoLY+0JX/JX+w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779368156; c=relaxed/relaxed;
	bh=S8hESN9zTKj5OoAbJc7/aaDhr686VhpDf6QH1mcWiok=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iaGbFaEG9cU1mdATsawNS3ufk9ODU87IGR8b0L6uwWmbzf6aZD2X0JUCam8FiiJYHDUCLFysz66+XwrgEh/sI1ng/f9FGpEhoYB0vTnv+CX0BGEYrika0S+0jXDPGZYh7I/BWoN0Olw6uufzAdRdCEuDwCt+LajVa204kf/FaBn3UM+XGwnXklQM0oK7iPFT0yyvbtgFsQKc2iaUwtocqh/4F2LNEgBanrgSAbZzKeyCSMfWQHxSn5N4MZCN+zdjm3yJFT1BVgG0uXTORVLyjlL+NTMOu14rNVkKZIq4IKigoFO628FzOsEaV2Jp/yinVEMkv8FMKGQTU94BB8IYNg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com; dkim=pass (2048-bit key; unprotected) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.a=rsa-sha256 header.s=selector1 header.b=JwmcatLi; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=christophe.leroy2@cs-soprasteria.com; receiver=lists.ozlabs.org) smtp.mailfrom=cs-soprasteria.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.a=rsa-sha256 header.s=selector1 header.b=JwmcatLi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cs-soprasteria.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=christophe.leroy2@cs-soprasteria.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLpLK0BGRz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 22:55:52 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DVkBSguqv6jXNadkm6E3D4BW1le4a5VIAreisoVRxO6mtcYreL2XjoINZ4Rtd74c83lqon9v4Ykgd5T6HrVA6Y6wLTLQdQpx7/291tRGGTzZBlFzCDwJw/MZ3FbXGwbzDbFdzQZ62hPfD/o9x39QfFfQhGTzMkQ/oPdGJ8E4qd7T4NMVsZVqtyGjatXiSvG0tozGYDE6tPb693rVyLLdsjeH0SrZe11RaqEY6gTkoMchGs/XeE5829jYEn0m8PuD4JINqho08Tiq8wcmJ4vSO51iVaCo7JldX8CMLxadDiW71EKse0+pZXm5N6ziVxME6Eot0VcyWtnsvIUt198GXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8hESN9zTKj5OoAbJc7/aaDhr686VhpDf6QH1mcWiok=;
 b=cL863D+2l9/Yd4FPYFEtlx72PtUSFe3bu+khkz+uBxBwoRcZyWQsAAiZD7rBU8xZmMBIZ/kQIBCvrw1sJJwJiJtJUZvlzn6JNUU1NHWCOleiXaUDeGx6HFb1hIHVKfC/2HlKaoLRunoL7WE+xXLsXPqBRZV2+VDJSgH/M17bMWWVMY7Ax4tkmvX4UjNRGR5JPSzgo6VG1WISKWH4vzzTt1HoGyoGduk4xkGi3Sl/IK3H22/Y1zwwNcrOeHEaAoOjx0BG2JMxenO7mAUvQPJCEUpQsJcEEfpHtW0dP2TMOf0VxleXUdKmb1U2Qu+LUSMe28Ac/vEZtOQjzsHIM5pt/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs-soprasteria.com; dmarc=pass action=none
 header.from=cs-soprasteria.com; dkim=pass header.d=cs-soprasteria.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs-soprasteria.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8hESN9zTKj5OoAbJc7/aaDhr686VhpDf6QH1mcWiok=;
 b=JwmcatLi38c/61OBzPToZiZ0+enRvntdcVhaE5g0olOVNlqoOJMJV1vzW/Sw8BhNWJ2r1gU/KahnI1uIAVyxWCf0JBNq+CnIUDD+OSuJCdImRsBLzKbV2WtsGbQYVnGfap2GmydZehErw6PieF5+jhS/FYSTw0437Y6q47zl7a7bn+QxussOx73i51o2zEA9npyHo513lOeKZqy8Pq3mzVpjoVDLulK0lQLzc5v7zHmGgfqanEjBVEv0yQDkoXuM33W5MPbeY/2HJN6ojkWny+a2MU0V5gRdSbsrHcAL0ZDMbNXyBhAqCqvTUP7MhOEjOp8fqh3JGqJ6jjrdBbGEfA==
Received: from AS8PR07MB7960.eurprd07.prod.outlook.com (2603:10a6:20b:396::20)
 by AM0PR07MB6435.eurprd07.prod.outlook.com (2603:10a6:20b:159::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 12:55:23 +0000
Received: from AS8PR07MB7960.eurprd07.prod.outlook.com
 ([fe80::2c24:b25f:5c9b:6db6]) by AS8PR07MB7960.eurprd07.prod.outlook.com
 ([fe80::2c24:b25f:5c9b:6db6%4]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 12:55:23 +0000
From: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
To: Jakub Kicinski <kuba@kernel.org>, Rosen Penev <rosenp@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "open
 list:FREESCALE QUICC ENGINE UCC ETHERNET DRIVER"
	<linuxppc-dev@lists.ozlabs.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: ucc_geth: Batch RX packets before stack
 handoff
Thread-Topic: [PATCH net-next] net: ucc_geth: Batch RX packets before stack
 handoff
Thread-Index: AQHc5jN8LukEtDwKuUGojDrPW/qNCbYXnIEAgAALt4CAAAGxgIAAy9sA
Date: Thu, 21 May 2026 12:55:23 +0000
Message-ID: <8bc3dc4e-dab7-4354-a594-95ebda75987a@cs-soprasteria.com>
References: <20260517192856.3925-1-rosenp@gmail.com>
 <20260520165746.7ed10c7b@kernel.org>
 <CAKxU2N_vHyqZK8tBbYLo49iOUJSO56rgqbSdw3CnCUZjbs1qNw@mail.gmail.com>
 <20260520174545.69766438@kernel.org>
In-Reply-To: <20260520174545.69766438@kernel.org>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cs-soprasteria.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR07MB7960:EE_|AM0PR07MB6435:EE_
x-ms-office365-filtering-correlation-id: cf3e719c-6170-4a6c-f08b-08deb73838d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|56012099003|18002099003|22082099003|11063799006|4143699003;
x-microsoft-antispam-message-info:
 lUpJLJOYxJa10qYA2gOLU75OfSOV0snMyZEuRDfcnu0sxI+0Uq5BbfU5D6TVr5H0zWfrNumJ5hHizzo+CkgDFIuchcUCdcEB9XEEcyFO+spFZVBM40DNaRU608oIEh4NxGi6IxSXlXPLKnF5aqp1pW7iL9FlCeTWhf/QVxEb1MpPj97PSoHgNo/wJtKvF9zeUz1TcEgdtxxskKDsXp4T3NtKZKCypv00kdnWDiRpK/uyxKPVL5H7RpdvMfW6uZ1DNImJqrFwCxoNaUn3K+kPTzofEnvhy4ZJe/JbXWf7yRYiUhDuRsaN/ZeVm/Z5EbmnLr/4WTL8AfChRKva01BXtEKZ7kg3nfxApugqG3Ej3UJ0Vvd9k7D5kHOVpPQPRlY0uZW61FCctSZaDCZ99a7nMKVX2y2QBKedy62bLUMr1M4AOkt9Pu3hn35LvpjeWdUbZr4xyz6d3j75RLLtdp50t6eHKDj3ipqL5JfYuCaC1DH8zLavsqe3PMjGhoE49rbcBqf8c3fHBIhC5osRA1b6OtaWuU1FU2oMhnYT6HzXmbgeyAY9UPxMDPNT8ntLbQPOFvJHEoEVV15mzKbh7rG0oWtNsNA7Na+I1/58IKIhAa4zOf1SM/gAwVJnAeywoJbgyr4HDLDYLPPoTIjYkrGoFrAv9z/OXV552PWfkbMirRrwwYup5p1H7XTmfPBw9+DPLxL799whhqOdPhNpNZQW0r+/P6sZ7fysWC+U3j5MiPrSSiqe+9KhN1n6wlPTwxmo
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR07MB7960.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(18002099003)(22082099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S1Q2ZmhrWnpyVkVIelFiNU1tcnVrK0xmMzIvUFpQRUV3MWdGZnNlNlNQSXFj?=
 =?utf-8?B?NFdMZG85aUVVSW5nVlhYM3JNNUNBVlB4NERIODk5Mm1JdjhqaTR4OER3ay9R?=
 =?utf-8?B?WmJHZkNjeDFvdUh0UnFQemhuR1I5TGdPbFpYM1hhQ0dmN0pIR2h3WUhCRkls?=
 =?utf-8?B?MWtJY0VPSWU3Q0N6bUxabUJtdXUwazBUZUgwa0U4Nm1VNjRSYmI0SUFDRnYv?=
 =?utf-8?B?QmxsSEFtYXpTU0VPaW04VTBpL3RPRDV4Y0ZMZ0VtMjlaZXZBY1luK1h6UkQ3?=
 =?utf-8?B?OVFVSUNtb3R0RW5hS25sdzlaUEZSenYxUUw0Z3lUdEpGWkRvOHI2RlZ6VVZs?=
 =?utf-8?B?Rk15VDZlTmdnVEdwZUtZaXlKTDhBTE9mSnU0c016aURxTkxaRUo1UDdXRGlD?=
 =?utf-8?B?WnBkK2JiVnJtRWVuZW93WWE4WUFHRWNMS0tCamZEc2pxZmJYV0lac0syMzFU?=
 =?utf-8?B?UVYyRGlsSWkvNWxDVUpvV1JyMStrY1pEUmplYlY5ZkNtTlNlQlB5eFJDZUkx?=
 =?utf-8?B?Q3g2YmpDRktlVWRrOHBXbXVybUhqT2Z2bEhjeVp2TzhaaXE1aExHWlVzVHY2?=
 =?utf-8?B?ZERuaUI2bnhWa1JKRVBXUkJEeGp2SG5nZWRrbjlSNEltUjVBTElQS29UOTJK?=
 =?utf-8?B?eHM2aE54MjBqUXFHc2ZKYUVRUjNEYmFOekp0d1Q4aGFaSmt2b0lxcWJxSXBT?=
 =?utf-8?B?ZEgxZDJHUU1IeDVBdmUwQjBhbDJFbzlxbHJJK0VscEY0bFh5cXZ3bGZMNHp6?=
 =?utf-8?B?SUdiQmRsdjdDMDc3QjFEZDQza3FjRFBvSTBUSEFSQXo2Mzhodi91cW90cmxE?=
 =?utf-8?B?Sk9XNGhIMlE3aXBLVFFMOXZidVdUMHVNR250VVo5UGVZZjNyV1pRSFFYckFD?=
 =?utf-8?B?K003bURHRVhEQ0FaQ3JIaDBHci81RE1Pd2J2OVhaT0tRa2FtRDJOTW1oWnJp?=
 =?utf-8?B?M2Y4TUk0eXoxWGhtTFNmaDFCOTgrSVk4Q2dWOTN2VFJ0cCt6Y0VwUEtTSWhE?=
 =?utf-8?B?SkdGcy9DT0RJU1RnN1JjS0syKzc3MGc1TktwQzZkUHo0eUlGRkZDREdHOW5N?=
 =?utf-8?B?bHlYMmR3ejRjVlVUbjFDZE91QnFjaHJhM3VWa05zZVk2Z2xiZGVlREZiMTlo?=
 =?utf-8?B?aFRzMTNXYnJHTWJPMkd2dHVzRFJvOTZmTnVwUng1RXpOa3EveGtWUG10QS9P?=
 =?utf-8?B?ZjZRMUpFVHdIemlLWENoY0dhSGJmRXlrbFJnb0JTV3MrRU9UWk43K0g5eEMv?=
 =?utf-8?B?eC9Jck95eko4QkhPUEpqUXcyeTQ0bGxYem56Y2FYN2tscWVKSmRWclZ4M0c5?=
 =?utf-8?B?d092c1VUdzcvMkRYNXUvdmkwNHZLb0VxekhaUGJtRFRsL0xqVTFtQUdab25a?=
 =?utf-8?B?RHk0R3JOWXIzUVJYM1d5ZUxLVjBMdlpGNHk5UG9zUGJtTXpPWmdzeldUOHNu?=
 =?utf-8?B?Z0hhQ2pvVUpoN1BpQWNRUGFzRVdsUnNNTHJFZkgrcW5pa1dLTlErNTFYMHQw?=
 =?utf-8?B?NnRXSndrcVV1UVVuWCtabXRnZ0o5a0RLVjNZaG5JMHdEWXlkMmRxQmlvRXhJ?=
 =?utf-8?B?S3pKQWoybFIwTnhjWXpCRDBWamJTM3lXNmFSSERQandpY3BHMVJVRE9CeFJw?=
 =?utf-8?B?cmpVQ3FGczI4NFlIdEF0aXltbHNQeTY2aWdiSVR6b3RjazE4QnliTGUxc2Zy?=
 =?utf-8?B?MDZRU3hnSzkwczNvdmI5a3dFL2hQMkY0SDBUVjIvNVNlTGpTWGE5VExBSkV1?=
 =?utf-8?B?b0toaGFIRlZKR3pKSUVqRlFEMzhuNDM1V2kvNFhocVNuRzZlUzY2aHR0RTR3?=
 =?utf-8?B?YmhvejJJa3doc3pNdWp0bldFNzdkSEV2L0xKaW1ocEpJejNtQjlJQ0t3SVBF?=
 =?utf-8?B?QzZ2Rmx1b3V4WFNkVyt6VGN0M1hsaUlWUmZvNm10T0UvSVhLd2xVRDc3Q3Vm?=
 =?utf-8?B?OWFTY2c2OVBuRjVlRHM3VnpybmNPZE9yU09MZjJUMTVUeTEvSnpzN2VNVk1r?=
 =?utf-8?B?ZWdwM1JaZEFPeTdudWlGR2IwKytLUElvV1ZTbWlsSUI5SWdXM0lWZG55VUg0?=
 =?utf-8?B?VEtRN2g0Rm9NbDIrb3ZiNEV3aFJNbFJGZ3NsWEdBeTBXYUNQclhxa0ZYVW9y?=
 =?utf-8?B?dHIvUkE5Z3g5SXVpamxldlBmRWg3NWt3aXcxOTJMNzZ6ajlHNG4rbEFQeVFF?=
 =?utf-8?B?R3RNRHEvcVN5R0doNUNLM2Vtem96cnNiSUNEZ1FoTFAwUStpeWxja1hPY2sr?=
 =?utf-8?B?VTc5dHo1aHFGOW9CM0pVV3d2VDZha2RrMTJ5ZWxKei94eEJOakJjZlNnS3lq?=
 =?utf-8?B?S0VRQVRDWUJWN2M5Yk1ySjJ2bzF5VnZqQVdZRCt5L1pHREZBWGFIZzkrbWtr?=
 =?utf-8?Q?3i8xmQ4CD19lxv5Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <340CFF7948650141839EE5DFFB2432D5@eurprd07.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR07MB7960.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3e719c-6170-4a6c-f08b-08deb73838d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 12:55:23.2424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8b87af7d-8647-4dc7-8df4-5f69a2011bb5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tDOXYHoKQdMBbAQ/8rk/IJ/pc/ngBlJ7AvHqJdkpk43kumYnK1KApR4w5Umc7oYnuiubY+gYUDmnN19ee46F4wSyfoQv6Sj+PZlJP+MvD850/FVYzVn9EQ1LCrSMs5UN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6435
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 04
X-MS-Exchange-CrossPremises-AuthSource: AS8PR07MB7960.eurprd07.prod.outlook.com
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-messagesource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-originalclientipaddress: 93.17.236.2
X-MS-Exchange-CrossPremises-transporttraffictype: Email
X-MS-Exchange-CrossPremises-antispam-scancontext: DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-processed-by-journaling: Journal Agent
X-OrganizationHeadersPreserved: AM0PR07MB6435.eurprd07.prod.outlook.com

SGkgSmFrdWIsDQoNCkxlIDIxLzA1LzIwMjYgw6AgMDI6NDUsIEpha3ViIEtpY2luc2tpIGEgw6lj
cml0wqA6DQo+IE9uIFdlZCwgMjAgTWF5IDIwMjYgMTc6Mzk6NDEgLTA3MDAgUm9zZW4gUGVuZXYg
d3JvdGU6DQo+Pj4gT24gU3VuLCAxNyBNYXkgMjAyNiAxMjoyODo1NiAtMDcwMCBSb3NlbiBQZW5l
diB3cm90ZToNCj4+Pj4gQ29sbGVjdCByZWNlaXZlZCBza2JzIG9uIGEgbG9jYWwgbGlzdCBkdXJp
bmcgUlggcG9sbGluZyBhbmQgcGFzcyB0aGUNCj4+Pj4gY29tcGxldGVkIGJhdGNoIHRvIG5ldGlm
X3JlY2VpdmVfc2tiX2xpc3QoKS4gVGhpcyBsZXRzIHRoZSBuZXR3b3JraW5nDQo+Pj4+IHN0YWNr
IHByb2Nlc3MgcGFja2V0cyBmcm9tIGEgcG9sbCBjeWNsZSBpbiBidWxrIGluc3RlYWQgb2YgaGFu
ZGluZyBlYWNoDQo+Pj4+IHNrYiB1cCBpbmRpdmlkdWFsbHkuDQo+Pj4NCj4+PiBHUk8gc2hvdWxk
IGJlIGV2ZW4gYmV0dGVyLg0KPj4gR1JPIHdpbGwgcmVzdWx0IGluIHNsb3dlciByb3V0aW5nIHBl
cmZvcm1hbmNlIGJlY2F1c2UgdGhlcmUgaXMgbm8NCj4+IGhhcmR3YXJlIGNoZWNrc3VtLg0KPiAN
Cj4gTWVudGlvbiB0aGlzIGluIHRoZSBjb21taXQgbWVzc2FnZSB0b28uDQo+IE5ldHdvcmsgYWRh
cHRlcnMgd2l0aG91dCBjaGVja3N1bSBvZmZsb2FkIGFyZSBwcmV0dHkgcmFyZSB0aGVzZSBkYXlz
Lg0KPiBTcGVha2luZyBvZiBiZWluZyBvbGQsIGRvIHlvdSBrbm93IGlmIHRoaXMgZHJpdmVyIGlz
IHVzZWQgaW4gcHJhY3RpY2U/DQo+IE1heWJlIHdlIGNhbiBkZWxldGUgaXQuDQo+IA0KDQpUaGF0
J3Mgd2F5IHRvbyBlYXJseSB0byByZW1vdmUgdGhhdCBkcml2ZXIuDQoNClVDQyBpcyB3aGF0IHBy
b3ZpZGVzIEV0aGVybmV0IGNvbm5lY3Rpdml0eSBpbiB0aGUgcG93ZXJwYyBNUEM4M3h4IENQVSAN
CmZhbWlseS4gVGhpcyBmYW1pbHkgaGFzIGp1c3QgYmVlbiBkZWNsYXJlZCBFbmQgT2YgTGlmZSBi
eSBKYW51YXJ5IHRoaXMgDQp5ZWFyIHdpdGggYSBMYXN0IFRpbWUgQnV5IERhdGUgMzAgSnVsIDIw
MjYgYW5kIExhc3QgVGltZSBEZWxpdmVyeSBEYXRlIA0KYnkgMzAgQXByIDIwMjcuIFdlIGhhdmUg
dGhhdCBDUFUgb24gaHVuZHJlZHMgb2YgYm9hcmRzIHNwcmVhZCBhbGwgb3ZlciANCkV1cm9wZSBh
bmQgaGF2ZSB0byBtYWludGFpbiB0aG9zZSBzeXN0ZW1zIGZvciB0aGUgbmV4dCAxMCB0byAxNSB5
ZWFycyBpZiANCm5vdCBldmVuIG1vcmUuDQoNClNvIHdlIGNhbiBtYXliZSByZWNvbnNpZGVyIHJl
bW92aW5nIHRoYXQgZHJpdmVyIGJ5IDIwNDAgYnV0IHVubGlrZWx5IGJlZm9yZS4NCg0KQ2hyaXN0
b3BoZQ0K

