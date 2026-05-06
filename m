Return-Path: <linuxppc-dev+bounces-20500-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEBA1CD342C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2026 06:37:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9Qff35rSz2xFl;
	Wed, 06 May 2026 16:37:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778049450;
	cv=pass; b=JdWbE/CbN+ihu1VMbbMBTn2YSqyeeJo5lZMiYq6+nlFtNKG86S+LnnlSK9Yqc0ZJ/7jfUUVe4KBCmf9ByL7m+8vgbo228pHlvZtYkbMGeCZL4X87m2qHzigKnOi1PXdLGllKWMLDRPpVjo5g51geLwMIFSI8vophjVt0uqdP1NWtu5XZswxGrfXKKTTpW/EPwupp9Euwjc/NM8Ar7keXhaMZ/cwuZqFa8OHzroZ9t0M1FEjRH/HVQR5YwprGSPFeZNUM/gZDMC+I3SZ4JdfyPgSavoe8EO8dPWDIpQpYdIUNCtZ0XONuat20RKJHR0dq9C+N/Os4c5eF6W+RvzIpZg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778049450; c=relaxed/relaxed;
	bh=gkXDS2Ka5t3HO2UJbT5sbMd/ZWX30UhbZhoLgXE95BM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KxyiK6TarcstY+9dOJ/cnAJbgyyvLopzrDz/p4ViJfOubbhmt3j7gdxspGKGBgpsBhv5eSX92/tVPuO8mGMrAw9kbUmR8iO6gUIT0mxxyDmteCi6HcFPuBqgNFyTj0Lr5VCtshDd3kuCWLVj0rrOrzbX0ZBqmmEX5ghCSzT6I/Ie0bV9ZfJRUXCyPvu3C7/dHrYYxu6RAHT2b29VPTmQfel9O0k/5Ac+mbv2CiCfB723ZcZVfPW+Xrp1GXyYU9/XVs8St1ZVvxDOo0LRqAd4HU0o88TkKi3D0ap/KFVoc1A5VVtiktsaNGzJZLosgIhvePPQRGKVqUUZTZ8MqPBB7w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=kVhTcQGK; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=kVhTcQGK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9Qfb6vv3z2xdh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2026 16:37:27 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vo6ebBFD8xgWkEX17QP98idI0FQYQQVhzQrIhfCxvyrljCuRmcfWonpkUqvwFvi6h8h2Gz94ZBTESVWhubSSIWkcwA3bzzHmUHvh9oy2pljH3+rDYerU8ErDwcDiUwCgkFAqrPfjy+Gjb9u8owF+9EHAOEs28btqNNhzv2AncmcsC89iqI7w3qxq1hSRK6dWY9vxp1hysqrwHomC0RTjN0Kh1LVCfV89Gx1DxwE0ivY3lLBrw3Y67psWu/sN8iClZrXzbYJ30XfIZoK8JVHzBVtSqmcZOjVS/Kabl6rs7c0psNnD7ChTFP55Jw9a2CxM+wE6cx2tooDOGAkYe/5oqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkXDS2Ka5t3HO2UJbT5sbMd/ZWX30UhbZhoLgXE95BM=;
 b=bwqhFMpRIcVGg6FMHPdErNlYZTI7Ouh+hrqunESSvwIHU4sELHZFswzd06NSaz38baLGMIq3lkE2Ilf1ohF+8aO3s1ttokSeiQLINy8XcTVyaTrt9lYH3zFFD52QyrREYMxaseBo25rm28ms486R5vtfjkQ/FI63KQOc1akRH7SvnRCJXfV7hMIIKYwxaI4s9mo2l2+Kz1jzy1677Pph7QNfG26JlgS3Jls7GpzW88Mt8jGeV8yhuaXt24hiec0zUJ7m+Q2lNhFDoqyYsxeqauC4SXAYzEYe8V5/0mGiz1k+2I+k4E3XIuNQFkTblHnAOWz2k7vDPgLkMVx4L1EH9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkXDS2Ka5t3HO2UJbT5sbMd/ZWX30UhbZhoLgXE95BM=;
 b=kVhTcQGKndZLNpvspub0CxTUNmrGJgdk5hmu7hv2wPSqVCBMpMx62uy6lqv+3dTdEg9ozfkF6kGTMIZyqYt1ZehQDQjSxikNFtAvYrpMZeVWleNxmFEWd2If79BDojLp1N+jlMf0vjjFXKzvjC4Afw8X5YfMJNfmZHSxdwkpUJdIW8P54l+jyhD74ODtBGI/kjIr+dt5NzLE1mz4lBO1PdNhNik6w8Jkgs6E4V73QLhLZsH5npVv79Ls0onQEskrgHAqZJ+eDjjrB0iHpaWl5kc9C3WEWBhdh+tKPnauoW2Hm7QY5UvxWqzLdhByScxq55v/noDxcx+Nn4/m2t0oSA==
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by DU4PR04MB10575.eurprd04.prod.outlook.com (2603:10a6:10:585::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 06:37:03 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 06:37:02 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, Frank
 Li <frank.li@nxp.com>, "chleroy@kernel.org" <chleroy@kernel.org>,
	"horms@kernel.org" <horms@kernel.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>
Subject: RE: [PATCH v5 net-next 04/15] net: enetc: add basic operations to the
 FDB table
Thread-Topic: [PATCH v5 net-next 04/15] net: enetc: add basic operations to
 the FDB table
Thread-Index: AQHc2Eu9niAvge9XQkmehImaWA9JL7X/KkoAgAFky/A=
Date: Wed, 6 May 2026 06:37:02 +0000
Message-ID:
 <DBBPR04MB7500310D3671BC551F10B340883F2@DBBPR04MB7500.eurprd04.prod.outlook.com>
References: <20260430024945.3413973-1-wei.fang@nxp.com>
 <20260430024945.3413973-5-wei.fang@nxp.com>
 <6324783e-b5c8-462d-8cf7-f6cc9c01ea89@redhat.com>
In-Reply-To: <6324783e-b5c8-462d-8cf7-f6cc9c01ea89@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7500:EE_|DU4PR04MB10575:EE_
x-ms-office365-filtering-correlation-id: 88827b71-9342-434f-ae57-08deab39e227
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 Pq8Ri6IhfQCcY3sOTHxC0imkjv/iOJ1V1rKkDF8xNa9SVAl5dkO3sKSCla2TnHjYy+RBjy3hGgEq+FQjDuoR9RG1PAcQg/7MTkGQaVuPR6sNYmAI/VdpTPeZfwpt9G4kW+I25O+JVw+MSuVPJWU7Rfyg+XOVN8zaZJS2bmnq9C1y0sR7g0TKo5D2H1dtubk3o8rrkjsix94dIz2ao8UDhpMCo9iNrYMRI80qS7Ujw6z/Ptsc/KgTEUEbs2bsiHxTO5IwMjR/5+UfqbuyZv0CyI7ZauJVszsD9oXQPZzmNPjnk2znX5zhPGR6c1S9Ny9zWq8ezZCCdK5qrzCbFtIOYWZ5GUafmLwmC1eGhIeKvUXCDVQascLQScESYxGXFcEZjTNxN7w8zmgVN6VFpi6iY43C3BnDzlOQXhW8OJ2S493ml3D08sBzrz4gP4VDNpEygvqGfethcvvMfpELR2f/VKFxtRk1tC0Vkze+HYQEcA4IsWr+XYibmj6RMF/kfy7gXePhohW5msITJ66h6tkn4fPCvkwYi2GmDh758MX6uxil+jBmIne0pj689GM6gYMHptRwaI5uhS3gr32sCtgUtEaZuwFqJdi6/XjmKGThq2L12TVwlh1QXuhDpeQW0QFp42x9dZvvlsiyaeD+ETguWEcFyEaLTgSXN7wcDBnvhx/N6zMK86Kj4nWAPE0JUkVa4fj4s28t99lZf55eNhVWoGhiLIHKcMvcAoDqsZLSERYcgnQW9U7w+wyHV2D0WYx5
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TzR5Qi85S2hHcTJFRHRVeVlWSjRnNjR1ZUVmMHU2eDNXcFNVVUFNNVRLM0VH?=
 =?utf-8?B?dlFabVAvQmVmQThkUy9PRWVCRFhDdVA1TVVqdmxRVFk3SUhxRUY3VmpLU3Bs?=
 =?utf-8?B?RHp2MDhQRDE2aEpDQjR2RC9mUXl6VkllVHJ1MkZ5NWt1b3BaaXVrN3gvVnFX?=
 =?utf-8?B?N2tRYTY5bkhJWWtMM1diR2t1aXBLTGdXVVk2R2YzeUprREs2RzZ0WU91ZVpu?=
 =?utf-8?B?TkRyc1QxYUMwRWlCS1F0Zi95aXFHMnFOSU9MZ1llQkN2K0g0ZDRuQ0VROFR6?=
 =?utf-8?B?V21aNnZjZmFwNEZQN0NBdnFkeTBJZndYQ1FKRXRQRnRiNkFJUnZobDljRFpk?=
 =?utf-8?B?RU1ER0haWkZ5SEFTQ1E0M1l1UHBGUkRka092Z0hPL3Qwbno5ZTV0aWZtTER4?=
 =?utf-8?B?L09JbEgxdmZobDFvR1VtM1FGVXNDeFNwMkROc3llTzh0ZUZ0WkVYWHNLMFVO?=
 =?utf-8?B?dHc5WDJ5a0VmRklWdXNSMXpUNTNHMGlXWnM4NG5Wb25zYWZzZ2NvZVV0QnRl?=
 =?utf-8?B?aTU5WHNXMTVON3VZb0Y0V0ovOGhxTTUxakhlaFJHSzNJRS9mK0RCeVdzVHN6?=
 =?utf-8?B?b1FveXduRklKekwwdkRXWVdyRVp5VWNiaGRVSllQd2dSaDhzOWZnL2tqM2JZ?=
 =?utf-8?B?a2VCbVFBcGdyYXZCNmx2a2FWUEo0ZHU3eE8xV0pMYkdtSkxpOTJBVDBQb2Ft?=
 =?utf-8?B?NE52RHB3NGtBem5WQlA1bExEaXBhekluY2VBZkdrejQ5V3ZhamtPSnlISm1F?=
 =?utf-8?B?K09rTzJDY3JhZDFNcVc5NGt3cnl2bTBBdWU1YjFqOG01U2t1d0FNaWo2RU1O?=
 =?utf-8?B?QXdyNjA4TG9IUENWRzEveDRUVTNIb3huUWo3aFA1NFFzdmdUN2NDd2Q3SnU2?=
 =?utf-8?B?c3puZWVrb3BNRm1jTEViMVViNDZXOFJrQTNNRWZIc2taSkFEc3lmYW9haTdh?=
 =?utf-8?B?dkFCK042dlF5WnRpUEtPMXlQd0wrZHh1M1c1VC9tTGpaRUVrWnNBaVN1K2RL?=
 =?utf-8?B?YXhoV3pDcDk2bm9EZFBPbjd4OGNrR2kxTncvWWorSU01Zzl3T2ZqcU9lSTM5?=
 =?utf-8?B?SFYxdWtCUXVsK1F5dEE4TWpHckxKVWUyUkF6NHdjWjg3aytpRjBmR3VPc0lM?=
 =?utf-8?B?Sm51YnJiNDFWYk1HVnZ2elFlTFdrYkVDSm1FUVN6LzVqRUpLUFl3UEgyVTFV?=
 =?utf-8?B?WGxyT2xQNWI3M3Q1Umx4L00yOVpxaktYaU5ISGJOWTZVMnNzdS9vU0txTUcz?=
 =?utf-8?B?RVZyWmczTFhHWEFrMmtmZzVsdkZoNkJJNUN5UVNmekZla0FlcGVUdmdSQ04z?=
 =?utf-8?B?dEFSYzlESXNiTms3ckx0bE80bFVzSkpvaWlKRmRZaTRLZyt5WXlVQnB2LzIw?=
 =?utf-8?B?aGw0Mi9jaklLTjQ2MHMyRklhRExaM3FDaklhVWJFc3RZOE9ZS29BTFBPV25h?=
 =?utf-8?B?c3F4OVl3R3BVbm83anBtUGI5ZmtkdUl6Y1lsYTdVRW5vQzRVM3lJcklaM21p?=
 =?utf-8?B?RlhLcmlDcFZJQWFLVWUwQ2dheS82ejFiQkEvVXFKUWRlWVlDenFPRGtPVkJG?=
 =?utf-8?B?eTZOQml1UzhzUUMxTSt6K3V3MEozdUE0QUprcGVoc01TNExMZCtlMHp6Ylha?=
 =?utf-8?B?RnAyUWhOQXlOeDlrazBXSHl3T1dERGc4MVpDb1cyTW4zTWdDYThKZys4dWhJ?=
 =?utf-8?B?dkFjLzR3M1d0dVFEd056cUtua0N5YTBIR011VkJsMVZ6QXk2U2JuQXAwYU9i?=
 =?utf-8?B?V2plTVNoMnF1RVJwdWE3RFI0cUI0ZURzTUYyYmg2ZXEzZG81SVZwYStwakFL?=
 =?utf-8?B?WWNNZ2o1VzB2MnBYTFJwWnNLWFcyRGducDFEZmlZbEhPNi9Vd2FaVGZOdVQr?=
 =?utf-8?B?a0V3QSszODU1aldYa0Y2WkdpTWU4NGhUd2ZlL2NTZGl1WGsxZzQ5NjIvQVJs?=
 =?utf-8?B?MHRyclhTeGVEeGhLSVpSK0NlSlJueDZLRjBqdmhwZ2hGSEw0VXRzRW16clZ2?=
 =?utf-8?B?bWtUbUhjeG1RUTVYd0E0NzlKbVNuSmd2SjBsQVp0QkxOWmoyYklCMEhTSC9y?=
 =?utf-8?B?Tng4NXUvbUtIMVEwSkZrMjJOTG9IYjB0NThUMjBUck1yd1dienRjWTNhRjRl?=
 =?utf-8?B?d3V2Q0gxVE9VeFVIK0phYnBPYWluaHNCb0gyWXpITUtYOW4xMjRuVThxZitx?=
 =?utf-8?B?L3BEWk5obml3ZGlrckxFOExKMlNLbVAxY281YmxrK2hVckI0K0ZmOGxPS1ZK?=
 =?utf-8?B?VVVseHoxZEwvWU5INVdFbHFFZW5tOFZNbGxtYWRTS004a05UUDJWTVdUc29O?=
 =?utf-8?Q?p/C4usXzid/HN1xvnu?=
Content-Type: text/plain; charset="utf-8"
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
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88827b71-9342-434f-ae57-08deab39e227
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 06:37:02.8210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M9eqTQ8fLuJCY3NPQO7N56Vy1XMxrnTiRvMFY50VGlWT380JL/Y7hsC4Iw8vipS390Jzb19XMGA1LqLNo6o4cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10575

PiBPbiA0LzMwLzI2IDQ6NDkgQU0sIFdlaSBGYW5nIHdyb3RlOg0KPiA+IFRoZSBGREIgdGFibGUg
aXMgdXNlZCBmb3IgTUFDIGxlYXJuaW5nIGxvb2t1cHMgYW5kIE1BQyBmb3J3YXJkaW5nIGxvb2t1
cHMuDQo+ID4gRWFjaCB0YWJsZSBlbnRyeSBpbmNsdWRlcyBpbmZvcm1hdGlvbiBzdWNoIGFzIGEg
RklEIGFuZCBNQUMgYWRkcmVzcyB0aGF0DQo+ID4gbWF5IGJlIHVuaWNhc3Qgb3IgbXVsdGljYXN0
IGFuZCBhIGZvcndhcmRpbmcgZGVzdGluYXRpb24gZmllbGQgY29udGFpbmluZw0KPiA+IGEgcG9y
dCBiaXRtYXAgaWRlbnRpZnlpbmcgdGhlIGFzc29jaWF0ZWQgcG9ydChzKSB3aXRoIHRoZSBNQUMg
YWRkcmVzcy4NCj4gPiBGREIgdGFibGUgZW50cmllcyBjYW4gYmUgc3RhdGljIG9yIGR5bmFtaWMu
IFN0YXRpYyBlbnRyaWVzIGFyZSBhZGRlZCBmcm9tDQo+ID4gc29mdHdhcmUgd2hlcmVieSBkeW5h
bWljIGVudHJpZXMgYXJlIGFkZGVkIGVpdGhlciBieSBzb2Z0d2FyZSBvciBieSB0aGUNCj4gPiBo
YXJkd2FyZSBhcyBNQUMgYWRkcmVzc2VzIGFyZSBsZWFybmVkIGluIHRoZSBkYXRhcGF0aC4NCj4g
Pg0KPiA+IFRoZSBGREIgdGFibGUgY2FuIG9ubHkgYmUgbWFuYWdlZCBieSB0aGUgY29tbWFuZCBC
RCByaW5nIHVzaW5nIHRhYmxlDQo+ID4gbWFuYWdlbWVudCBwcm90b2NvbCB2ZXJzaW9uIDIuMC4g
VGFibGUgbWFuYWdlbWVudCBjb21tYW5kIG9wZXJhdGlvbnMNCj4gQWRkLA0KPiA+IERlbGV0ZSwg
VXBkYXRlIGFuZCBRdWVyeSBhcmUgc3VwcG9ydGVkLiBBbmQgdGhlIEZEQiB0YWJsZSBzdXBwb3J0
cyB0aHJlZQ0KPiA+IGFjY2VzcyBtZXRob2RzOiBFbnRyeSBJRCwgRXhhY3QgTWF0Y2ggS2V5IEVs
ZW1lbnQgYW5kIFNlYXJjaC4gVGhpcyBwYXRjaA0KPiA+IGFkZHMgdGhlIGZvbGxvd2luZyBiYXNp
YyBzdXBwb3J0cyB0byB0aGUgRkRCIHRhYmxlLg0KPiA+DQo+ID4gbnRtcF9mZGJ0X3VwZGF0ZV9l
bnRyeSgpIC0gdXBkYXRlIHRoZSBjb25maWd1cmF0aW9uIGVsZW1lbnQgZGF0YSBvZiBhDQo+ID4g
c3BlY2lmaWVkIEZEQiBlbnRyeQ0KPiA+DQo+ID4gbnRtcF9mZGJ0X2RlbGV0ZV9lbnRyeSgpIC0g
ZGVsZXRlIGEgc3BlY2lmaWVkIEZEQiBlbnRyeQ0KPiA+DQo+ID4gbnRtcF9mZGJ0X2FkZF9lbnRy
eSgpIC0gYWRkIGFuIGVudHJ5IGludG8gdGhlIEZEQiB0YWJsZQ0KPiA+DQo+ID4gbnRtcF9mZGJ0
X3NlYXJjaF9wb3J0X2VudHJ5KCkgLSBTZWFyY2ggdGhlIEZEQiBlbnRyeSBvbiB0aGUgc3BlY2lm
aWVkDQo+ID4gcG9ydCBiYXNlZCBvbiBSRVNVTUVfRU5UUllfSUQuDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVy
cy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjL250bXAuYyAgIHwgMjAzDQo+ICsrKysrKysr
KysrKysrKysrLQ0KPiA+ICAuLi4vZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjL250bXBfcHJpdmF0
ZS5oICAgfCAgNjEgKysrKystDQo+ID4gIGluY2x1ZGUvbGludXgvZnNsL250bXAuaCAgICAgICAg
ICAgICAgICAgICAgICB8ICA0NCArKystDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMzA1IGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjL250bXAuYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L2ZyZWVzY2FsZS9lbmV0Yy9udG1wLmMNCj4gPiBpbmRleCBjOTRhOTI4NjIyZmQuLjRlZDhk
NzgzYTlhMiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUv
ZW5ldGMvbnRtcC5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2Vu
ZXRjL250bXAuYw0KPiA+IEBAIC0xLDcgKzEsNyBAQA0KPiA+ICAvLyBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogKEdQTC0yLjArIE9SIEJTRC0zLUNsYXVzZSkNCj4gPiAgLyoNCj4gPiAgICogTkVU
QyBOVE1QIChORVRDIFRhYmxlIE1hbmFnZW1lbnQgUHJvdG9jb2wpIDIuMCBMaWJyYXJ5DQo+ID4g
LSAqIENvcHlyaWdodCAyMDI1IE5YUA0KPiA+ICsgKiBDb3B5cmlnaHQgMjAyNS0yMDI2IE5YUA0K
PiA+ICAgKi8NCj4gPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvZG1hLW1hcHBpbmcuaD4NCj4gPiBA
QCAtMjEsMTEgKzIxLDE1IEBADQo+ID4gIC8qIERlZmluZSBOVE1QIFRhYmxlIElEICovDQo+ID4g
ICNkZWZpbmUgTlRNUF9NQUZUX0lECQkJMQ0KPiA+ICAjZGVmaW5lIE5UTVBfUlNTVF9JRAkJCTMN
Cj4gPiArI2RlZmluZSBOVE1QX0ZEQlRfSUQJCQkxNQ0KPiA+DQo+ID4gIC8qIEdlbmVyaWMgVXBk
YXRlIEFjdGlvbnMgZm9yIG1vc3QgdGFibGVzICovDQo+ID4gICNkZWZpbmUgTlRNUF9HRU5fVUFf
Q0ZHRVUJCUJJVCgwKQ0KPiA+ICAjZGVmaW5lIE5UTVBfR0VOX1VBX1NUU0VVCQlCSVQoMSkNCj4g
Pg0KPiA+ICsvKiBRdWVyeSBBY3Rpb246IDA6IEZ1bGwgcXVlcnksIDE6IE9ubHkgcXVlcnkgZW50
cnkgSUQgKi8NCj4gPiArI2RlZmluZSBOVE1QX1FBX0VOVFJZX0lECQkxDQo+IA0KPiBTYXNoaWtv
IG5vdGVkIHRoYXQgdGhlIGFib3ZlIGNvbW1lbnRzIGxvb2tzIGluY29uc2lzdGVudCB3aXRoIHRo
ZSB1cGRhdGUNCj4gY29kZSwgd2hlcmUgTlRNUF9RQV9FTlRSWV9JRCBhcHBhcmVudGx5IHVzZXMg
YSBmdWxsIHF1ZXJ5LCBhbmQgMCBqdXN0DQo+IHRoZSBlbnRyeSBJRC4NCj4gDQoNClRoZSBkZWZp
bml0aW9uIGlzIGNvcnJlY3QsIDAgaW5kaWNhdGVzIGEgZnVsbCBxdWVyeSwgMSBpbmRpY2F0ZXMg
anVzdCBxdWVyeSB0aGUNCmVudHJ5IElELiBJdCBzZWVtcyB5b3UgbWlzdW5kZXJzdG9vZCBTYXNo
aWtvJ3MgY29tbWVudC4gQmVsb3cgaXMgdGhlDQpjb21tZW50IGZyb20gU2FzaGlrby4NCg0KU2lu
Y2UgdGhpcyBjb21tYW5kIHVzZXMgdGhlIE5UTVBfUUFfRU5UUllfSUQgKCdPbmx5IHF1ZXJ5IGVu
dHJ5IElEJykgcXVlcnkNCmFjdGlvbiwgdGhlIGhhcmR3YXJlIHJldHVybnMgb25seSBhIDQtYnl0
ZSBlbnRyeSBJRCBhdCBvZmZzZXQgMC4gSG93ZXZlciwNCmluIHN0cnVjdCBmZGJ0X3Jlc3BfcXVl
cnksIHRoZSBlbnRyeV9pZCBmaWVsZCBpcyBsb2NhdGVkIGF0IG9mZnNldCA0LA0KZm9sbG93aW5n
IHRoZSBzdGF0dXMgZmllbGQuDQoNCkkgd291bGQgc2F5IHRoaXMgaXMgYSBmYWxzZSBwb3NpdGl2
ZS4gQmVsb3cgaXMgdGhlIHJlc3BvbnNlIGRhdGEgc3RydWN0dXJlIG9mIGENCmZ1bGwgcXVlcnku
IE5UTVBfUUFfRU5UUllfSUQgZG9lcyBub3QgbWVhbiB0aGUgaGFyZHdhcmUgd2lsbCByZXR1cm4N
Cm9ubHkgYSA0LWJ5dGUgZW50cnkgSUQgYXQgb2Zmc2V0IDAsIGl0IGluZGljYXRlcyB0aGUgZmll
bGRzIGFmdGVyIGVudHJ5X2lkIHdpbGwNCm5vdCBiZSBwcmVzZW50IGluIHRoZSByZXNwb25zZSBk
YXRhLCBzdWNoIGFzIGtleWUsIGNmZ2UsIGFjdGUgYW5kIHJlc3YuDQoNCnN0cnVjdCBmZGJ0X3Jl
c3BfcXVlcnkgew0KCV9fbGUzMiBzdGF0dXM7DQoJX19sZTMyIGVudHJ5X2lkOw0KCXN0cnVjdCBm
ZGJ0X2tleWVfZGF0YSBrZXllOw0KCXN0cnVjdCBmZGJ0X2NmZ2VfZGF0YSBjZmdlOw0KCXU4IGFj
dGU7DQoJdTggcmVzdlszXTsNCn07DQoNCg==

