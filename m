Return-Path: <linuxppc-dev+bounces-24252-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F127C44508
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 15:47:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h03b04RTdz2yRl;
	Wed, 15 Jul 2026 01:47:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:d111::" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784044028;
	cv=pass; b=Pmi0ohNPGeo3YpOV15oE2/R+sF0Quf0IrdfkNGqung1nSriDqAo1il2HRLOSwClLMRvHLTGmQ1rdoI7pPaLtYBlzo/5wzQgJ8o8ModBa4IOrj15jXs+A8VKuS+/9zhkcEjEV3SyikUhmJr01cfIlFXoqp1zbzB8yW7mxURzMkDHRnFOIcus2+86tzRiG0dg0hQ64hsH239HeidZCRq7DQ0Yu7OwJ943rXCc7Nf2yg+h5Unh3u2a3JPyTVyHEsi0NROfI8oRbG8kM3yAFspGqJsWHwi7XqKV9kzOb4xzy45jWDUN2uUeE/wd5JgGIplWXVhHm7VJjiW+1ru6civttrg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784044028; c=relaxed/relaxed;
	bh=AkxJFdvFImNHaUkEOP56gpJG+1IskAsN9CBJ7CIBpzs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SxHqCGNJc7Cr1BCY4AvOZHtrM+tnxidwxVBzpu3a+RpVqUQpGNm0xuUxV2Z4K8JzebuBdTiTlKTCdWqXcSnJe82zXn4hmVV6zFWhEqkPyZNiH4Ax3bMgsg/TCd+jQZBOLesWcPcg+OXLSGVrX0kOeb4dAXRJOtorIgBVktH2tsif/8aIZL9eAuNTt9DKXVZf/mNEm11jlGV14bG3kx3KPyS8xOgLd0NF+ZDgfn5woIQuMgi14s7lf0Po2FUPyLeES7R31pSARYOMLRYx1E0XS04CigNOrA+V3qEHLfqtphVMSOP1vd1NoSsiCaTcTJDD5iP2P/we5SWOBqti0iDR7Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=outlook.com; dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=UTxpF5so; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:d111::; helo=ch1pr05cu001.outbound.protection.outlook.com; envelope-from=mhklinux@outlook.com; receiver=lists.ozlabs.org) smtp.mailfrom=outlook.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=UTxpF5so;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=outlook.com (client-ip=2a01:111:f403:d111::; helo=ch1pr05cu001.outbound.protection.outlook.com; envelope-from=mhklinux@outlook.com; receiver=lists.ozlabs.org)
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn190100000.outbound.protection.outlook.com [IPv6:2a01:111:f403:d111::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h03Zz3WCWz2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 01:47:07 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nVHY8Y26798GAgW5ItQvwTbtGcTRE1B52slJ1weVhuRHVsDLgD4pYm1iruHP++tB5gcK3BEqAS9KeqJ2/BNiLHIxSw42DLZNiEw4BK3hNLNifoxV/gZlQAI2vqEkyb3TfTZOMqr0ABWi4CAFvChwCKb3P+iYdDWS+iuBH1HNrjZmJ+qYjfHh7kJwuT6+afmqQS+/HdC7WyQ9LDtXwmecsod5fdZmgiu0cixaik9pevpuh2M2ViEV0cbqDt5SYwcn58+oZ9RCxnUXCYrcGaBrzzHo8O6TSIUcgJIP4cwNCLEv4gIJiNwssglsgDLmHNCWr0hjpgQ6bdmALKJMUG6O0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkxJFdvFImNHaUkEOP56gpJG+1IskAsN9CBJ7CIBpzs=;
 b=wjd3BTPJGIsXCtSwvzQazqIw+f7sBwhfTGdrSm4Guzxj9sXkPTPEdTJI9jRYdKLYJdthej26Q1tmR33cOtvu1rMdkIs/37K/OQ1UR3UXkbW+13L5EQQlNa34tlOgcSToopQz/yvHPaJd51FozSZqptKc5agDSzjEk8bU7bqglSe6lt8G2uYSao013PmASZ1gl/tkolRC3U9uyNAsIdy4q7pAeA9veIQVqREAL/eWBwtqUvZIKhLX+3+Hxa146cMM0HL7V74mHnV9tOu3y+VaO+GpVB2zx9rQMOCQ8CqqKQmVG9hg7MSzd6A0d1JBQwekw2Js+w4432OgQgnGRKjxHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkxJFdvFImNHaUkEOP56gpJG+1IskAsN9CBJ7CIBpzs=;
 b=UTxpF5so6xwu0mYpO0rPzvjYkSwK6iCbvS8oRdKD3QhFdlpr/r3Gp2CpmQd22Z+lVZYe+JoV5neQJ2AJ5K25tXRjJlP/NpgXHuosnNxJv4HxnwGBi3vR/vAfBTu6tOGjQHOU2gFixqf5zvRoCjD0+58bfIj+AdK/fCIjrL5OXKkpQZhdOuQrLv0mdr5cfT7KaKLKE1iC70n8gS6lVcR6GWPhoHEX1nEUEl7yLXLstJ2ZAiaMwrkHF5wEuuO8ZpRzk/hxKtj9mmHwBr0pYm9YpfA3t244X9etzNYjYs9brNvw9Ge5GTuxXHOJ2GPruXjJ7KCqhOQ+AWC2yGi+/F7Eow==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by SJ0PR02MB7613.namprd02.prod.outlook.com (2603:10b6:a03:322::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 15:46:38 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef%6]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 15:46:37 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Aneesh Kumar K.V <aneesh.kumar@kernel.org>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, Robin Murphy <robin.murphy@arm.com>, Marek
 Szyprowski <m.szyprowski@samsung.com>, Will Deacon <will@kernel.org>, Marc
 Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>, Suzuki K
 Poulose <Suzuki.Poulose@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>, Petr
 Tesarik <ptesarik@suse.com>, Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
	<chleroy@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Gerald
 Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger
	<borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
	"x86@kernel.org" <x86@kernel.org>, Jiri Pirko <jiri@nvidia.com>, Michael
 Kelley <mhklinux@outlook.com>
Subject: RE: [PATCH v7 11/22] dma-pool: track decrypted atomic pools and
 select them via attrs
Thread-Topic: [PATCH v7 11/22] dma-pool: track decrypted atomic pools and
 select them via attrs
Thread-Index: AQHdCR21HzJYiEbtiU2dmeozUbuIfbZrz5EAgACpXoCAAIxuAIAAOE7g
Date: Tue, 14 Jul 2026 15:46:37 +0000
Message-ID:
 <BN7PR02MB41480896D46601E8B7F6166DD4F92@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-12-aneesh.kumar@kernel.org>
 <20260713175616.GJ3133966@ziepe.ca> <yq5atsq2md64.fsf@kernel.org>
 <20260714122504.GG3133966@ziepe.ca>
In-Reply-To: <20260714122504.GG3133966@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|SJ0PR02MB7613:EE_
x-ms-office365-filtering-correlation-id: ae017260-74a3-488f-95c6-08dee1bf1732
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|15080799012|19110799012|8062599012|8060799015|31061999003|13091999003|25010399006|51005399006|37011999003|40105399003|102099032|3412199025|440099028|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Red/QiJYwYIJ8CicvWHgzRvBK/ghVQ0p5dTfV8s1p7GHqfaYmvTZuKtNC6ev?=
 =?us-ascii?Q?2pYDoqikZN4IRI7VUZ46HprR8vCVEtF7uXX3MDQvy9HHTA2FQlkum8pqzju1?=
 =?us-ascii?Q?AvOWKv9DxGVIkbvNKGnEvaj//VbAxVEA4UhQ+lvqU86Kz5IcC4k6t9quU492?=
 =?us-ascii?Q?u9fC7v4fxlgfxfsC133Q7Tf7qhnZ7buAEEiY6LahU4vOOt43kYygP15VP3YZ?=
 =?us-ascii?Q?2a+4/n5EtOLctGMZPAztZLc5OQv0UHmVV29aIBfX76wCXa/57HniOLNCXYZf?=
 =?us-ascii?Q?KNFbMskluj3AfcXZSqDmhdkhJM1mFVmi+ZgtY1utWjX5RxwHf49GouI9ix0X?=
 =?us-ascii?Q?Z3Fiqy4IHurPFcIKX65IQrWvuDv4NRN/xt0KBDf1dO1Pr8DrSKvnvk+dmTYQ?=
 =?us-ascii?Q?0LCUJ652Iv5pI8vXqoUuSzafiZwSib01jMZPzU+2/Ue3Ujo52P2EnHwOoj63?=
 =?us-ascii?Q?XCVD+G0XQPTE6JTvrlZ6gbLihNGwoFvfEap042/n+l6NC3oUin3RHkvcOVyu?=
 =?us-ascii?Q?mPDVCQQVCakhoO3e1fiCL83docgEBQYeGCbAVigVKj+Ah9wHyEND0JDgxUE5?=
 =?us-ascii?Q?sOSjm30pznXqqF4akJsXewvJsiPolfvG1LqaxfRLjXUy+gPnBNuSM1JdBXZD?=
 =?us-ascii?Q?9lJoHiVCz1EW2qHQY/p1Y1qiaZjDmngmrInOTN/NS9iwPhkyZqTuJ5eUAdbR?=
 =?us-ascii?Q?SYDlgOHukaE5YVa3P/imJKR6VyDOHMAge2ez4dw1WF0pJz4T8dzu/D1ZD8/d?=
 =?us-ascii?Q?ugdDi05TEczpz33yU7gTIB1hS3GLZoGIlwSfw1/Mdr25VgFjKTTZlpZHDSi3?=
 =?us-ascii?Q?m1ZheAp+P/3BNpJFyqk2avbkQkBJexmW7AkOpRZTHmc5CEVVfRlp9Cr+N7by?=
 =?us-ascii?Q?5A10AfsSvXXsL5wUmByNkdCbE4C72/dlkyoHjx8KTDGrIsd+0/xt1XNdqM5i?=
 =?us-ascii?Q?E/bET8TPilxTQF0KP3UudptVwtuTwQR7srVQNY64L1VbUg7SOE2EXTKfoFq0?=
 =?us-ascii?Q?lKDhHeJ59BXNy3YiMaL7bUAPgQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+fZINyrI1VxSyC5Zw09hM84dNk+TMVMSlLnMzx9+n3GHdRDh2UPTqPzIJfAj?=
 =?us-ascii?Q?SNF2lr7bTCm7Zd471BslTAt08q4fKTF3L8DiW7PrNpRsFV1+dUaPPFQaSt5k?=
 =?us-ascii?Q?z8b7aRvY9L3YBM9SJtsrr+Pluj+RyE0VaIiHv3nmYG9yyPy/4BFSRK3kyOoR?=
 =?us-ascii?Q?NKQEcc49pZKQnbIrUkEPab4d7SA7YowHcePzEuvLFsnb24KTZC8b0M5zQsv9?=
 =?us-ascii?Q?P4NNC01W9mfqZNxaUyxonBIMCG9q2MoTvsdazTXj9sLK9Wxv27hggXYrhofp?=
 =?us-ascii?Q?HTWXWRv181i6e4fu63ZPsqTzWIN/H5ROJFVZ4gCh+f965tnuCgQOuPtPACEk?=
 =?us-ascii?Q?5t5zTf/Cpx11rX4oAOcyr29Dh9FQLNZM1B0gTNAPm6qdSZ/AYlC7RMMYniDY?=
 =?us-ascii?Q?sB9LP8TLcR42dAv9/E4a1G4ZTsg7ew62vWGrk76xfAcnwaeJMzZ0R8zqbLAi?=
 =?us-ascii?Q?dlvWCBcEGG7vzylGC7KWKjCFHQ9ca5XHTJCNW3A8fsDd3LF1FK2TPKKfF76T?=
 =?us-ascii?Q?W307dbpd2s6HPSOBruybPXL2O6gNPM5W3Kwp1wa/tQz8q/DBEk/h+q0hJgpI?=
 =?us-ascii?Q?TxiaipaCuUv2e1JVOTRy2yV+6L8L7W/C3DXv2xMtkdn4KerfNA+1dVQNUAfj?=
 =?us-ascii?Q?ZeJ45/AWJXMJjaiLs9vYTu1rV0ZSU3DAhZU5BHErAbGFl+1kOhs0euy2AA6J?=
 =?us-ascii?Q?ncdWAt673nXkueFHFHeQbn+9dHaRDt2EASqe5TyRZjatIgP+Wrc8sNPCCUuF?=
 =?us-ascii?Q?vdvO+7faEzs1XOP0CG1ItTbo8DIwteBLpX/ybla8PvlG0bhB6+jsGtUvILcm?=
 =?us-ascii?Q?Neg7pgxmnPV3/YxCZsZskdclY7mASeeKb5HEQ6iQvqAVfudrlHcJnabsW9AC?=
 =?us-ascii?Q?X86yzb+ahwp1TBt2qVTPGO0vsgnuc6W/RcMsxNy/we0YEyPp2fPQ9MVvJrNa?=
 =?us-ascii?Q?RvCwamgDhln+TOGBRl+yzdiG0vWibkgZ05Z9k5+L+aMglj+91SrdFfcrASla?=
 =?us-ascii?Q?HWnULMU58tePO9TT150itdaCICDJB3rMTCywouEHTtfWlMUU5pXIWpl495NQ?=
 =?us-ascii?Q?w/CMP3RBWC9cw+c8Mc1If424R3R5q/i/aikY95nAz4mo6FWZoFhLxzBDfpP0?=
 =?us-ascii?Q?krmtpYSeGIwtApM8C1sOr+dMzi84Q3cEs8nxNyGyk5j6jp6n14PxfuHWCfi8?=
 =?us-ascii?Q?9K3sODTHDfGJcWdOa8zmpgUx1k2ccjhu43oMHQA/2swwu1M2g0qiguRuKasg?=
 =?us-ascii?Q?anPRd2TFac3qATumidrXMUEdegb/R24OGM+fAohxEQMavTIQ+ePrfR1OuUsQ?=
 =?us-ascii?Q?cKMu2lydhQZ3HMKPNbNVGvcg7PD5XhFdRJ4e8NuGWANdObXJv/rLrPw9MFRN?=
 =?us-ascii?Q?kazUgyc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ae017260-74a3-488f-95c6-08dee1bf1732
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 15:46:37.6833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7613

From: Jason Gunthorpe <jgg@ziepe.ca> Sent: Tuesday, July 14, 2026 5:25 AM
>=20
> On Tue, Jul 14, 2026 at 09:32:27AM +0530, Aneesh Kumar K.V wrote:
>=20
> > If we want to warn about such failures, we should add the warning
> > consistently across the code. We may also want to handle decrypt
> > failures by encrypting the page again to avoid leaking it.
> >
> > I will work on that as a tree-wide change in a separate patch.
>=20
> IMHO the WARN should be inside set_memory_encrypted(), and maybe it
> should be a BUG_ON...

There was a discussion about this a while back. The decision was
to embed the WARNs,  and that callers should not output any error
messages upon failure.

The x86 implementation of set_memory_decrypted() and
set_memory_encrypted() has an embedded WARN_ON_ONCE()
that triggers on a failure. The arm64 realm encrypt/decrypt ops also
have an embedded WARN().

The pkvm encrypt/decrypt ops do not, so that's maybe where it should
be added.

Michael

