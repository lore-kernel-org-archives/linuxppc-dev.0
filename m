Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854E4606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 08:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=WMKlusXW
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jP0d42452z2xwN;
	Tue, 10 Nov 2026 19:46:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794300408;
	cv=pass; b=h6Z/F7hkYUn8zzupyrmwrggaZAC3uAa9Fsrom+wWzOqbnqOokfX0xNVUcNdVkWJGmfA+dUSWSoT6E5h2zxk/c5kmAjYMlr94eHbqEe3BbsQryf5oHw2JIo99mZ/+Yz0vxPCVsibP8n7i1tByk2GL0joa0IEes1P+MLqXzi0y81kO86HuwOEv/0G4K5EsvQFzPBq/MYJ2hEQCyhi3jQVITvptjTSsg1jIV+CbGSX4bmnXIlxdnJbYLiU5DZVQgryQiViANLodTudJHefnjnmCBhRnPV0J4nrA56OjrFYZLjMuQKo8L1rV1o4hENOFlL6ovuLq7MViWR8ct7oYxJTSaQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794300408; c=relaxed/relaxed;
	bh=AakoS8URjXe4KfYhkU7uhKWXv627gMWYPKeVg6j0H7g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hFGF4essIS4b4SxNkZqzSzkVmymUo9oTj4RJC+MrTGM82y17A46xMBb9akSFmnfhrfCjXpWUjfokxOkhE9sI9h9b245pAD1ZXp3c2UryQZ2H+U6l5uXr+BisGf+9lm7QAXnEEWOwsshSZJEzLR505p0DfWa4wy4JvMPGbGMBSRVs2kVljskKCeZJgVKI/o7kf3F3CqSDq4Zpi51tBxSuSQtX75ydnBTmnDQlI9MhfkxelyAb98HhA+MAMF6Z51FRIIzvNbvvE95j4VPQe7p/xAp6zb3TQPdEhZrKDfmVMyf0yZMcqpRO0uZmS0PIUPXpz30mi/6SFKA97rNeBqvT4w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=WMKlusXW; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=WMKlusXW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jP0d232dfz2xrC
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 19:46:45 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g7QtENwmK6mU50nvTRHj+5gepYI7nu2deLB5LCONvt6UNIT4WZJOm46wcYmTVz5n0ochCu0OuTARdi+tb6S3/lq7XhnF0lvqgf6obcOghtvHHXNrhLDWLZP1fHlarZlfpkF/+xeK4uvP3dwJQoEgniMq1AVl93Jh6Ei6c/Vk+fFVhRLAZz+gvKRWAt6ZK7N4aHPeEZN6c21vrzeqRrpqWIGQ6CEbF61j+lFwc7Ok0bMy+BApQ7FeWNLa6KDk6UZW9UmiEmjdLk3aIdxM/elJ7Mxvu/Sa37nrLxYTWxGWSnHU1bntXCQBkDz99HJpCeE8GadFAknpV9uKrerphpabvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AakoS8URjXe4KfYhkU7uhKWXv627gMWYPKeVg6j0H7g=;
 b=NX3AhUm3T+8a+1/b8HDRuRxrNlKy7M7wIPUKAro9ZLHH3vZ2dHGLe6+fgSTwQyYi72j1ovcNxA2es4E+zsmY24i555oW/W6U/DAJDbrSXVj7ASWD+L+fwrlLFHrWJEWg8KTVcDeqAep7No04PVT8hTGr5vxZdnbRkIpet6uvahB+VJK7ozlb79zcQI0qIcLZkMR0YprIby2qCl8ceAZ4yfRI6G2xL8wbhSsqnMk0SDGptivfGkiUaVdSd4L3x8ghASdDKIEy/q4lJzyNqarzRbwEifLm7EeoAbJUy33EjA6XjcjDjM4y5N8ODe0Be8NW4ZnzySbJNJoRALcoCJdNIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AakoS8URjXe4KfYhkU7uhKWXv627gMWYPKeVg6j0H7g=;
 b=WMKlusXWuXdZy0XnYg56h+HwWS42G98lAlYan7Z0p+EbyFoKm31WibED9jkSYc3pkcHn0nR3WNAv7TfS6hKtBO/1yDUPOEDRg8BYfiuK771vMcPtIkGCv9tNwDeJsJ7g/NMnWRYZ3TZoJB5OiZMmX5yj0brEekA4BEbQwUQjAH//yglYHmDQZ2UiC7GmhHekyypcT+JbbXb57VK/pJzqBBJPxtnU9iDFBxyZ8blAdagz7Gn62rVQDs7E0Xo9mP9JJX1iSk3mGLdbSzlHiwl100ceVe0r5hGPWZZwAAhDfdNi50svNYtlVO8qNF68JYaKajtZ2Lk7ELT8iLkyKE6x0Q==
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17)
 by AS8PR04MB8851.eurprd04.prod.outlook.com (2603:10a6:20b:42e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Tue, 10 Nov
 2026 08:46:20 +0000
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680]) by AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680%7]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 08:46:20 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"olteanv@gmail.com" <olteanv@gmail.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "linusw@kernel.org" <linusw@kernel.org>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v6 net-next 0/9] net: dsa: netc: add PTP support for NETC
 switch
Thread-Topic: [PATCH v6 net-next 0/9] net: dsa: netc: add PTP support for NETC
 switch
Thread-Index: AQHdazfZzWTjAGf+JkC6X61TwLJlT7cnCJ4A
Date: Tue, 10 Nov 2026 08:46:20 +0000
Message-ID:
 <AS4PR04MB9338322C1A3ADEDCE79D9F3188722@AS4PR04MB9338.eurprd04.prod.outlook.com>
References: <20261103021024.3121936-1-wei.fang@oss.nxp.com>
In-Reply-To: <20261103021024.3121936-1-wei.fang@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-11-10T08:43:15.0000000Z;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9338:EE_|AS8PR04MB8851:EE_
x-ms-office365-filtering-correlation-id: d68afd5a-22e6-4c47-618d-08df3f071775
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|366016|7416014|23010399003|1800799024|6133799003|10067099003|18002099003|22082099003|38070700021|921020|261021121427099003|56012099006|261022105027099003|261026121527099003|261026140227099003|261028144727099003|261009223027099003|261102130727099003|11063799006|261102123227099003;
x-microsoft-antispam-message-info:
 +AAeBiCIofBwdhYirJIyYa6b33qIj5EbmDwmjkdWcjT6Na0wLGAJ7S1xWJ4McYEuLaee56RcfaIAi5Tv50PoL4/sZSM7iWauHc2hGYiKWWBOH1ArUSqiv+s3opGDDXdBE4gkhDQffevvAJNHJsHhRtXyS4FojC9t61N/xOfp4p6QYmWBnLETG9zB5yaRvr7+7OVzREQ5HJmw8hpoAagBevdO89dMGgqZFcha/j8b5DoF5OOnoMgT7/OqeCwk+WZlTlEG7OMEqHxdnXH52aMNNX3Y6COgw90CfHgMJt9Shi+G+AvNDW27GmqOz+8QYzc2bUFTJY4Fer4O2YBULndrjMQQgWhZc3Dgkokx88tQ+KFEzse/K82ApYWlMlXIHU4j5tiopRZy32lEBTYxi7HuqqilmIxCqmYZSZuZBvYzZd4E8xxNNygj+Em7FqBvZTqWYIPn1pACBif871GviZf72mZ++GGWVfuSNypP9fSX9yDiCnxebdF77BZ44O/N2m3ajDskbtRacxTD1uRlIq7sfV/gi9jZH06Ux4ben4cMLciOlt7w8gUUOsUUSvzNBzhFo1Qvp9LpLW0wHxRuctZmpjzfyeQe7hD7NdX0p0Au7lsjRbqeXEtW4jv19SI4qjHEm3vv+GObksZ7kxdQaWo74ieVrD8yMxwcjpvuizMqCWzN8EGNtXbxFxHkrZ7GoYzP
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9338.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(7416014)(23010399003)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(38070700021)(921020)(261021121427099003)(56012099006)(261022105027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261009223027099003)(261102130727099003)(11063799006)(261102123227099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4bDSI1tALlioVnLzxk4eD0fvnbIB5t7BMMPrptxwOEV2U6susj0nOG5IG/D3?=
 =?us-ascii?Q?ZS+ADcuU7/RHQ6QSPnugxpoixRp6A8U7a0DUEnQ18knKaFHVARRHPBR67WlV?=
 =?us-ascii?Q?nJilwDyewhx8kbf/GaQV6v9txMrIjCmDsH0NHbwTGQ/27C0jltw/QupkJl7Y?=
 =?us-ascii?Q?vZw/O7QdTulRP9pCBIozackzSP6WBkmkqOGDFIPpN6FAHNqG7A9r/6mKchlj?=
 =?us-ascii?Q?hoWuxlFVSexf5WGUo5In8g8Z79EJG8J2pGxrpWaumfGqrA9c3f4erFK/QEyW?=
 =?us-ascii?Q?ROMb+rSMrCyDgn2Nhl6ao5uxnQwMpXK75E/8G5fDmRUhgEqqWttc0AZJvQRx?=
 =?us-ascii?Q?rfChvSOvFDTPfhmRDGUg2gCNbAK6Vmn9p6hn8PfXJTNR/MKkjuiNMVJgjC97?=
 =?us-ascii?Q?QG8RuPcn3iGUcMWVEMrxfzAT+sbJulvN7U2r/vv9e/d8tXkhYch5eKn4W6O7?=
 =?us-ascii?Q?qAzHyyMu/T8+Wvw29RxXZ6M5FIt+6Oq6PZzLXDlLfg/akzy6ZChqwfUILwZL?=
 =?us-ascii?Q?+3mAST0mt9quSMavadrzQ2IcP5qZAqX0sbW18y65qetKlHi+ChIQxe4T9BW9?=
 =?us-ascii?Q?G1/2i+fsKG6GhlIk2pi45HrCNO3f0noz6+TTN2Q4E9rSaUGtzJdbOPn7Rx3B?=
 =?us-ascii?Q?CxEGawtNykX0HrC7t4iY1snkuxkNLSf+WMH4+crmBq1EKBZQwlKUoD0Aig7l?=
 =?us-ascii?Q?w6m8gjvqVKx8isW2EJQMcjH4Wk1AXF2ZEK91jvmnlsbsj7odc4PyUITOMMlE?=
 =?us-ascii?Q?L6UAg+163PztdpaSu8B7XdrdjgGx4ERLlniAhJ49DnoPvfDswybf65hd/1uG?=
 =?us-ascii?Q?+nnRjNX8pmNxsnHVHPquRGrSdCGR6texCUVQA/AUOIecuqBR2V6aofVa/RYv?=
 =?us-ascii?Q?CWdD2BcioiZGxTSTKFeNvGZLWZDIvviHCv0xjjKlj4EZ0Mr5NNPn7IBRTTlE?=
 =?us-ascii?Q?87J54PmPzlv6E7OUcltuROvdY5um5UFXRpJIZ9HnziHR1h+w5NYxJ3/s1ftK?=
 =?us-ascii?Q?SkkUudsaue0ZVOUONIHt4ECyUO5nbzrJRz2qwiZq7Svyvf9389nBfSfHQGZH?=
 =?us-ascii?Q?SbkEVDWbkL1FcIqe5SP8VI1gvFhb1SZrzcd5m28MQBK6ChNhcXbbdREh/9sH?=
 =?us-ascii?Q?2KFTzi+1ypPMmAQiEKkOO37F/2SR1XS5YVCaYdBvNER1HnqwcFgWmz3XTTzR?=
 =?us-ascii?Q?PRrwRT5AtFf5Hh36IeAJvvlTSIFq0nyYPZGjg/CG6NUKRpyn7iyBw6KVJuvs?=
 =?us-ascii?Q?LRg5bIqmXTCkEDeSqF/Z1yMXLEsgO+gc642jl9Lr2/unl/KN8xD6+dngJihz?=
 =?us-ascii?Q?NCq+sg1VCw6L8S7DqMtGE8L9RKwyXpMLrNvtxqmatSawTbpL37KTHlvFFyml?=
 =?us-ascii?Q?XTajP+6tQZYKzbNzkL51JfKLSc7HrmcXbBKpMF+Fa51n+JKX5ddiAbsB3PeW?=
 =?us-ascii?Q?jdNd8joQ8TSpjKVcV8xQHWLHu/5Oa6tiW4pHW7+xeTcbQhc2LW/FRVfMxFSZ?=
 =?us-ascii?Q?d/ScKrZLoTVhyYleZv+B7CZoqGNVJ3GOZLi+KVkwtFzbF09yH4TmBgMipwpY?=
 =?us-ascii?Q?ZwR6NsmlvK8KdugIovCwYNRPe6ByS9v/VL5WBDMxJsucbyPNiUx8TKD14lLU?=
 =?us-ascii?Q?Sug+LFoBvGPqt0qzLBem6dFUaKUISQnscU+Dklla5ohx3D8nsxBzrr3fWP+H?=
 =?us-ascii?Q?KcLAnoxVoG/y+4cby53tFbcxVoW720nvKd1Wp9+Fs/ADSaps?=
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9338.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d68afd5a-22e6-4c47-618d-08df3f071775
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 08:46:20.0362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tqAGki/DtAjMazJQMph0Oj7YZcpVbdCGYTWKWMLilxvzkbVOnahXTmXrtnuDGRO5C2yqbIBaPOFsQuZbLIA0gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8851
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> This patch set adds PTP timestamping support to the NETC switch, so that
> the switch ports can be used for IEEE 1588 PTP synchronization.
>
> The NETC switch has no time registers of its own and instead shares the
> PTP time of the NETC Timer, which is a separate PCIe function driven by
> its own driver. The first 3 patches prepare the Timer driver for this
> role: tidy up its 64-bit register access, drop an ineffective reset, and
> export netc_timer_get_current_time() so the switch driver can read the
> current PTP time across the driver boundary in a race-free way.
>
> The switch redirects PTP frames to the CPU through the ingress port
> filter table (IPFT). A few patches harden and simplify the existing IPFT
> and host flood handling first, then enable the ingress port filtering
> lookup by default so PTP filter rules take effect without extra software
> tracking.
>
> On top of that groundwork, the switch driver gains RX timestamping and
> both flavours of TX timestamping. Timestamps are carried between the
> hardware and the driver through dedicated switch tags: the ingress and
> transmit timestamps ride in To_Host tags, and per-frame requests ride in
> To_Port tags. Two-step TX matches a queued skb clone against the
> timestamp response echoed back by the hardware. One-step TX defers the
> Sync frame to a per-port work, where the driver reads a fresh PTP time
> and writes it into the Sync frame's timestamp field, then programs the
> single-step register and transmits the frame so the hardware can add the
> residence time to the correction field on the wire.
>
> Together these changes let standard user-space PTP stacks drive hardware
> timestamping on the NETC switch ports.

I saw netdev's Sashiko reported some issues [1], and I think some of them
should be fixed or improved.

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103021024.3121=
936-1-wei.fang%40oss.nxp.com

--
pw-bot: cr


NXP Confidential

