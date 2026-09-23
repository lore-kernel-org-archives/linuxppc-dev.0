Return-Path: <linuxppc-dev+bounces-27959-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D599CC982EA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 06:12:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqRT71sTdz2xs1;
	Wed, 23 Sep 2026 16:12:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790143947;
	cv=pass; b=X2S/zoip3qCiPLxeSgKpMJTjrFTzW2wtNCmn+Pb2tK7HKq73NX1xCPSLcjzPn5tLnI8Olvo6HaPbpIMtCRDFIo435dCzgiDLavrTsTYanoR1ZF7Bv9A+HbWq1YRWHR8mDyE2rei+R2miTKHGAx9qz0EalHvik0dEgpiMwR5Yg/IZ5Ff0uEnQqbLRkHo74oZz0BpZOvsVFpA+5YjiobagA20ytC4+HKsZG2w/VSNWJAlN5ZVR2UatfrcbBnNUqORBFY0EauFuDz0EuNWywpzPb9jQd79tfEkbdqzX66vHqYeuxtNe/1CujkQrhdfb/TAM30Uf1elAToyCy2cqzTu7fw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790143947; c=relaxed/relaxed;
	bh=iQbEdxHK+Cx8f+Fpy98onb8+B0McGTZq5BkbddEj9uA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G9o08irT6UMcI35FMiWcCaUMn54RfNOh9KJf9LWVG3AEd8E4i5XdQ6+xx6Db2NKT/RzZsx/uqQYQsRM/OaFXlh90twyW+eUH5+1KynJu64YmaMsCg+NrbYuQx8RmbnAtMVJ4IO5z/e3eN7d0VXv7sQyQU/mKIMll02HJemVnOqdrQdRZv0lcoUDDXIN70HQeBTb7AFxOUIbmjfcshR9o8xiLLn91mokmv9ACAVh70xgTl07ILRTt49MlwZj4ZsAkkcY8x7esn2xGd0/52bl1R6rByfQKvaAepNH2YvYmJJvtdOHZx28eJnxy7WoqbTAOYdQWoSTLCFakaJcZp7isPg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=BBBbWMca; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=BBBbWMca;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqRT51tmGz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 16:12:24 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YtyUSA1TOvG3M7UQtRTrqEOsJbrQcHOxl+yEuhdcAAawumb/IdtsDjz5bRfz5gZRxZoBfqhJGT8iCB1Z/XWAgcUNqmgDRPtp4+bJ69qU4BBEJP+zXhnYNCLDZfaRVXSG7YwbDQo9hMO0SID6WRXs4pvnKWKOdf7VoVYqVC2ImAl1tEFkK9vRnqyU2WS5b/lcSh6BiRvlYGQjKyv9t4U9a0/3G537HbmKD6c7/MtmadLMIS4BecFn3m8miDoOK//szLWKXRZmqdql9auaCxQSCuP7qJxY7WQUrH1MH2uIS40abLlaXvhSYs0dYvdNhRz7wzy6GzaEu5Bwqo4d9NCKdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQbEdxHK+Cx8f+Fpy98onb8+B0McGTZq5BkbddEj9uA=;
 b=jBz/Ibug7Ft8J7dMZ4kUpBmKtwQx/DMkMIoAilLvc3UtmJRfOQuz5gVCVqppgciZwtb0hrlzZ535CSTiLeMXmCsBqT1QcpV98Q6qFWxrvCQPAIQoukved/EdZrfa3J1V8n38ZeKO5O0AEhDODfyzOMXjjWM7pNjnTuDD6A7PwidNIph4zOZhINHj+/kuyfUDTbRcH+ab2mKpanjAGiSsarqt9YOQleOpwFoO/oAX2Cjuru+JI/Sj6Zwp+Z8WehhyaTnl18WRcCF0M4DZYqHP6GJcdsIagYWNZKImmrwRXn+iqRt6xzyGRLBZsGIA0TaNLVCV8oo1V4sYuWqOLZcW6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQbEdxHK+Cx8f+Fpy98onb8+B0McGTZq5BkbddEj9uA=;
 b=BBBbWMcaIzY0Ux737sRg2x3Rbv3TDdi8JnNDmBR4LbDriSwFjrOc8DmySgZ1+Z29G7ZndpB7zlFuKCJMCscafNCW4A+BK88SlyiUR5dsRik3qqyQs4v0hFO2WOuAfwjTHoN94lRLzaWt9/qiYXM4hY/K9B0x7JAixacVR48fWIqfml57e9JsktC3p5pusgQc0lUp8wexxp4OM9hpO4t58kv11FrJvDncCV0zJm0EK/UBMeIvOqNSus9hznxKu2O1xpPAGgYawhs8kE43qr/sH3tEjK4bVBsDng1oKS1QRPSsYySIPhQfzaJAUccBZjKLp/soDNpw2ohwo2Zqmny9bg==
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17)
 by AS5PR04MB9894.eurprd04.prod.outlook.com (2603:10a6:20b:655::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 06:11:57 +0000
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680]) by AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680%6]) with mapi id 15.21.0428.015; Wed, 23 Sep 2026
 06:11:57 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>, "Wei Fang
 (OSS)" <wei.fang@oss.nxp.com>
CC: Clark Wang <xiaoning.wang@nxp.com>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"olteanv@gmail.com" <olteanv@gmail.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "linusw@kernel.org" <linusw@kernel.org>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 net-next 8/8] net: dsa: netc: add PTP one-step
 timestamping support
Thread-Topic: [PATCH v4 net-next 8/8] net: dsa: netc: add PTP one-step
 timestamping support
Thread-Index: AQHdRz7mJNvdwL5OkEKz7kxCT3KMQbbaSYCAgAE/EDA=
Date: Wed, 23 Sep 2026 06:11:56 +0000
Message-ID:
 <AS4PR04MB9338EB87E61CBBF0C797E85688822@AS4PR04MB9338.eurprd04.prod.outlook.com>
References: <20260918072852.501420-9-wei.fang@oss.nxp.com>
 <179006555987.2160803.11394642259806679085@kernel.org>
In-Reply-To: <179006555987.2160803.11394642259806679085@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9338:EE_|AS5PR04MB9894:EE_
x-ms-office365-filtering-correlation-id: 42ce5146-3445-42a5-0b3d-08df19399266
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|1800799024|366016|376014|19092799006|10067099003|3023799007|6133799003|56012099006|11063799006|4143699003|18002099003|22082099003|5023799004|38070700021;
x-microsoft-antispam-message-info:
 Do1BNmTZ9kzZ8yH6ft2m1ENajvMhmg04FULpoqKc5TfnhEbqTDG8l0HK0I7KMRpTNIK3QnZLoQd/XgPRFtbh48n9G2MsgNmX2U2BDtJjX1FZQrhq21qBvf8mkJAsDKpuKfnyqCNIG5MhCeKmIz9H+jcOgWjsVN/wzrSQX/LQYQTBGt2y4gUKyLET+YulKvcnH4q5vPy7OfUL3T21ibaohMoa+4npuli92jl85+i/d0E7fiH8+OR5n7fLxXj2qdS/BxMXIbcgqbx2iexEJpScMcPW9hG2Fj84c7D9A0ri4iNUQ9R3NmwtE7kibEm0zBHIqxCO8yD5G5LHqg6JZ1NFmRgd4jZSicxCbjW3KiCX3Z+BOxZm+gnMfIvn0XYn3E5ipR5cr9gTrnQ21xolVnm/Mxr1we/2VYzGMzQ8acDfAierdpNGoeT6JjbDtmWlIyCnmtq5woYjoA3wmNSoiwUDV0m1S1+a8nFYd0whVZNq/Ia7+VJ9BHNbXBRPzQxeZh+cBP0f85HIHj++jXLSYiJjn8ABZLGJLN7fn/qOol20dKQGUWGqiCP820G4y9eU+s0jHFOWhTKJ9qXEVKwsBTxhExLGnXC1XJU+ZITfbcOSHj0tkF+A/DWcC19tkf96tM3QFUQGClNUlcXBoy7SW5vKM2+3i/AObbugDffjlI4zWMMWVHLb2hkpy2i/xfTovQNSnR9xkew0Ca/67mU1m47C5ESzVcQHigfSv0Wdgzny3ZU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9338.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(366016)(376014)(19092799006)(10067099003)(3023799007)(6133799003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(5023799004)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IlRSe9C8ZO0vo6DMN1bkOxjH582pIQUuAA3QurS3u+/yhbluiOg6tIzWcksA?=
 =?us-ascii?Q?Qh5s7LZ3vv4Iad1xyyH/OOeV1WMBuWSu3Pfa37M+JPauWcekLw8huJTS2Pji?=
 =?us-ascii?Q?6Wp3Lni5NXBlu4quX9xRy+8NpTCDVEzp4FCNLCdi39GLF9H1ZgYuCOs/wUTI?=
 =?us-ascii?Q?Im4AKsJonDs5Nr8KLYzNcNP80yuYu0edB5ECCPav9V4bbbfN5NwEN6eXveFy?=
 =?us-ascii?Q?zDZY1upnBtj5m2U2vpj53/ryUGypU/r6VoW/h+WRezVd/dlRCHJltwEuOnOw?=
 =?us-ascii?Q?0aJp4EOToyaaq2KPRu1WC7exRUG9vQf2g7tV9KM5TfCafEYV3MRxPbQeRPUz?=
 =?us-ascii?Q?UidZBTBoGvxfuDmBAWwWEmRCrMGLnBXm0ZT78L4QIveQ/dblW+CAz/evn5tr?=
 =?us-ascii?Q?SA8fWK+uhisHLCTLZfcAmyFcWA3r0LeQFoEnKxfTuQbE+FgcKf4pGs+e+KlW?=
 =?us-ascii?Q?sIAKu8cVzHWgXWCULhh8mdF63XasOADPG7XlhBf5WfjULJVjeYYtt8+eZuZg?=
 =?us-ascii?Q?lX8Y69V3YAfdU68uOPWMd2U/3/7zO8ufjYSjBkhODH3d7+Ui3PYh5cWzagJe?=
 =?us-ascii?Q?QdG0quKbl1t0wD65UKqoJwvBWVzS5fPW/0vjCDsARaQOgYyTTyqc+IffT47U?=
 =?us-ascii?Q?m4D1qMjATfO/utdVIOy7ybB1SvHkaImerytDZdp+PuC1T9xDXVb/kBuBvRhS?=
 =?us-ascii?Q?p8N3U9GKhXNGq+ZRUw9nOInvdCpihXHh7+deQdaOVzWHb3v4B4nxOxnGUVci?=
 =?us-ascii?Q?aZfHnmadmfUIkVRnlYIFGHrVqsSoe4iROZ4A6JuGOb5G4hecgY/RCL9T3sCf?=
 =?us-ascii?Q?WIx+guY4jG7gKQ4fELVZmAk+noiz5bnx2WtFbHG5Ly7J4PEKZOshJTYSF4mt?=
 =?us-ascii?Q?JWXb1bea1emqiFbxN2ahH/fYKOhvrcwi2astX6PD5G/H37as6mh3mcQwYdFZ?=
 =?us-ascii?Q?7xXJxmxMLZbbcFClpitdhPPvm46OufAc0XqAV1YStdVnwZ48Rg7q2aVeGY17?=
 =?us-ascii?Q?QCN4eQDXSXn+qoRPteQGuZeAk12L4UqFElUyoex8qO+mAEXjDHuBG5KDFNhD?=
 =?us-ascii?Q?a6SrQ9zvOXvzfSNLev45KUFwiiuoqMJCyxcmrSIpT7GelmcE+2a30gy+rukT?=
 =?us-ascii?Q?ZK7qSTN0PcVGmjTnTjKhKCmK0aulWGZQTKxMsWnoU8gZp/AbSqhfg1cWcAbP?=
 =?us-ascii?Q?KfjJrMsYMgKhK6ZCVz/Flb7GGXlrSdjanOJbuX3wRBVU4hKks876c4EF9k1M?=
 =?us-ascii?Q?6h6uhPhhC2RBW6CdZYud0LJxx/Rm5XmJVfa1XePce44qp8X+bflcKxpz2/dy?=
 =?us-ascii?Q?8UBkalDkqgmpkC1zAkDDpmyx4K94QrL4nQMGeDOCM8fTCXBbcAXPe88FyoLi?=
 =?us-ascii?Q?4qGaPJ3Rvc/qmnHOA3jH3YKD63RWZPoBos/TOuC2Y/xLpB/5u5w2PT17Yx2t?=
 =?us-ascii?Q?4pgwCErv47UEV/fkdI6o88gyQYnT2Ld2TtAOsXrGuZjf5LXmkgoy92c0Iop7?=
 =?us-ascii?Q?Fi50raDIH1cztpkrvc5uFVJtXQxcGQMLesNTTzwszr8bgn9X2unG7KGZNMva?=
 =?us-ascii?Q?c+a5r4l4MJDeuJncMmBDQuVyWDJMjdEbrElv8bR4ZrzVHdGqkMt4w8TZtABA?=
 =?us-ascii?Q?z1aMjIXMFStJWAP+vhAlWX/NVkg7IdDzT35AN1ygn+/BJerAsRYeqWoQcnzD?=
 =?us-ascii?Q?/rv9GZ2Nhg3qH36Yju+2cx8Q9rUovM8y+5Gdexd51B9KXgiB?=
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
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9338.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ce5146-3445-42a5-0b3d-08df19399266
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 06:11:56.9454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3U6IVoQteFCaMlcjnTFcXU5dsHGKItDEg7s2S3NjjeylQW3DETBSEuhSAviUK//y+SF7NDgG1OY6bg7AIVOUmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9894

> > diff --git a/drivers/net/dsa/netc/netc_ptp.c b/drivers/net/dsa/netc/net=
c_ptp.c
> > index 2e743443ca03..1bc0f0956206 100644
> > --- a/drivers/net/dsa/netc/netc_ptp.c
> > +++ b/drivers/net/dsa/netc/netc_ptp.c
> > @@ -11,6 +11,15 @@
> >
> >  #define NETC_NUM_TS_REQ_ID		16
> >  #define NETC_TSTAMP_TIMEOUT		(5 * HZ)
> > +#define NETC_MAX_STEP_OFFSET		0x1ff
> > +#define NETC_ONESTEP_QTH		512
> > +/* The 30-bit timestamp of the To_Port subtype 3 tag lets the hardware
> > + * account for a single wrap, so the correction field of a one-step Sy=
nc
> > + * frame is only correct if it is sent out within 2^30 ns after the
> > + * software timestamp is read. Past this window the frame is beyond
> > + * repair, and PM_SINGLE_STEP becomes safe to reprogram.
> > + */
>=20
> [Severity: Medium]
> This comment argues that the correction value is beyond repair after 2^30=
 ns,
> but PM_SINGLE_STEP also carries the correction-field offset and the
> "update UDP checksum" bit, which the hardware still applies at SFD time t=
o
> whatever frame is being transmitted.
>=20
> If the previously programmed frame is still sitting in the switch or port
> egress path (egress congestion, flow control, TAS gating), the next
> netc_port_set_onestep_control() call can change offset and CH under it.  =
For
> an L2 PTP frame the correction offset is around 22, for UDP/IPv6 around 7=
4,
> so the MAC would write 8 bytes of correction data at the wrong position
> inside the pending frame and may recompute its UDP checksum.
>=20
> The "no ts_req_id available" branch of netc_port_onestep_work() has the s=
ame
> shape: it overwrites np->onestep_state with NETC_ONESTEP_SCHEDULED,
> which
> erases the record that a frame is in flight at all.
>=20
> Would it be safer to only reprogram the register when the new frame's
> offset/CH match the pending one, or to hold off until the pending frame i=
s
> known to be gone?

As stated in the comment, "Past this window the frame is beyond repair",
that is to say, when the sync frame leaves the port, the correction field
is not correct. When PM_SINGLE_STEP is programmed after a timeout,
there are essentially two possibilities: either the value of PM_SINGLE_STEP
remains unchanged, with no impact; or PM_SINGLE_STEP changes, in this
case the frame will be corrupted and either discarded by the sender or
receiver, which is as expected.

>=20
> > +#define NETC_ONESTEP_VALID_WINDOW	0x40000000 /* ns */
> >
> >  static void netc_port_tstamp_timeout_work(struct work_struct *work)
> >  {
> > @@ -68,12 +77,276 @@ static int netc_get_ts_req_id(struct netc_port *np=
)
> >  	return ts_req_id;
> >  }
> >
> > +static int netc_get_phc_time(struct netc_switch *priv, u64 *ns)
> > +{
> > +	if (unlikely(!priv->tmr_dev))
> > +		return -ENODEV;
> > +
> > +	return netc_timer_get_current_time(priv->tmr_dev, ns);
> > +}
> > +
> > +static void netc_port_set_onestep_control(struct netc_port *np,
> > +					  bool csum_update, int offset)
> > +{
> > +	u32 val;
> > +
> > +	val =3D PM_SINGLE_STEP_EN | FIELD_PREP(PM_SINGLE_STEP_OFFSET,
> offset);
> > +	if (csum_update)
> > +		val |=3D PM_SINGLE_STEP_CH;
> > +	netc_mac_port_wr(np, NETC_PM_SINGLE_STEP(0), val);
>=20
> [Severity: Low]
> This isn't a bug on today's hardware, but netc_mac_port_wr() returns with=
out
> touching the register when is_netc_pseudo_port(np) is true, and it report=
s
> nothing back to the caller.
>=20
> The one-step machinery is gated only on dsa_port_is_user(), and
> netc_get_ts_info() advertises HWTSTAMP_TX_ONESTEP_SYNC unconditionally,
> so a
> user port with caps.pseudo_link set would get its originTimestamp rewritt=
en
> and a subtype-3 tag attached while the MAC single-step engine was never
> enabled.
>=20
> That combination looks impossible right now: imx94_switch_phylink_get_cap=
s()
> only marks port 3 (the CPU port) as internal, and the binding requires
> ethernet-port@3 to carry the ethernet =3D <&enetc3> phandle.  Would it st=
ill be
> worth refusing one-step on pseudo-link ports explicitly so a future platf=
orm
> cannot silently drop the register write?

Currently, for i.MX94 only the CPU port is pseudo MAC, so no need to add
a such check in this stage. It is better to be added when future NETCs supp=
ort
pseudo MAC on user port.

>=20
> > +}
> > +
> > +static void netc_port_program_onestep(struct netc_port *np,
> > +				      struct sk_buff *skb)
> > +{
> > +	u16 correction_offset =3D NETC_SKB_CB(skb)->correction_offset;
> > +	u16 tstamp_offset =3D NETC_SKB_CB(skb)->timestamp_offset;
> > +	u64 tstamp =3D NETC_SKB_CB(skb)->tstamp;
> > +	u8 *hdr =3D skb_mac_header(skb);
>=20
> [ ... ]
>=20
> > +	if (NETC_SKB_CB(skb)->is_udp) {
> > +		__be32 old_sec_l, old_ns;
> > +		struct udphdr *uh;
> > +		__be16 old_sec_h;
> > +
> > +		if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> > +			csum_update =3D true;
> > +			goto update_timestamp;
> > +		}
> > +
> > +		if (unlikely(!skb_transport_header_was_set(skb)))
> > +			uh =3D (struct udphdr *)(hdr + tstamp_offset -
> > +					       sizeof(struct ptp_header) -
> > +					       sizeof(struct udphdr));
> > +		else
> > +			uh =3D udp_hdr(skb);
>=20
> [Severity: High]
> Can udp_hdr(skb) be trusted here?  netc_port_prepare_onestep_sync() deriv=
es
> and bounds-checks the PTP offsets itself:
>=20
> 	if (unlikely(tstamp_offset + 10 > skb_headlen(skb) ||
> 		     correction_offset > NETC_MAX_STEP_OFFSET))
> 		goto set_ptp_flag_drop;
>=20
> but skb->transport_header is never validated against skb_headlen(), and t=
he
> safe computed expression is only used when the transport header was not s=
et.
> The code then reads uh->check at offset 6 and writes 2 bytes there throug=
h
> inet_proto_csum_replace2()/inet_proto_csum_replace4().
>=20
> Two AF_PACKET paths can leave transport_header at or past the tail while =
the
> frame still parses as a valid PTPv2 Sync over UDP with ip_summed =3D=3D
> CHECKSUM_NONE:
>=20
> packet_snd()
>   packet_parse_headers()
>     skb_probe_transport_header()
>       __skb_flow_dissect()
>         key_control->thoff =3D min_t(u16, nhoff, skb ? skb->len : hlen);
>=20
> The dissector runs with skb->protocol taken from the user-supplied
> sll_protocol and nhoff =3D 0, so a frame whose declared ethertype disagre=
es
> with its real headers can walk attacker-chosen IPv6 option hdrlen bytes a=
nd
> end with thoff clamped to skb->len, i.e. transport_header =3D=3D tail.
>=20
> The other path is PACKET_VNET_HDR:
>=20
> virtio_net_hdr_to_skb()
>   skb_partial_csum_set()   /* csum_start =3D headlen - 2 accepted */
> ...
> skb_checksum_help()        /* flips ip_summed to CHECKSUM_NONE,
>                               transport_header left as-is */
>=20
> With the frame length tuned so tailroom is under 8 bytes, wouldn't the
> uh->check read go past skb_tail_pointer() and the csum-replace write land
> inside struct skb_shared_info (flags/meta_len/nr_frags/tx_flags/gso_size)=
?
>=20
> Since the validated expression is already computed just above, could it b=
e
> used unconditionally instead of udp_hdr(skb)?  The same udp_hdr() pattern
> exists in drivers/net/ethernet/freescale/enetc/enetc.c, but this path is =
new
> here.

The AF_PACKET + flow-dissector path is real (transport_header can be clampe=
d
to tail), but the OOB write can't happen:

All real reads/writes are mac-header relative, not transport_header relativ=
e.
ptp_parse_header() + ptp_classify_raw() work on actual content, and
tstamp_offset + 10 > skb_headlen() after skb_linearize_cow() bounds the who=
le
region. The correct UDP header is at ptp_hdr - sizeof(udphdr), so uh->check=
 is
always in-bounds.

Hitting the udp_hdr(skb) branch as an exploit needs a frame that both passe=
s
the mac-header bounds check and has transport_header at tail with a non-zer=
o
uh->check - mutually inconsistent. So: not a High OOB write.

That said, your suggestion is right. The skb_transport_header_was_set() bra=
nch
is redundant and trusts an unvalidated transport_header. I'll drop it and u=
se the
already-validated expression unconditionally.

>=20
> > +
> > +		/* For IPv4, a UDP checksum of zero on the wire means "no
> > +		 * checksum". For IPv6, its UDP checksum is mandatory and
> > +		 * never zero.
> > +		 */
> > +		if (!uh->check)
> > +			goto update_timestamp;
> > +
> > +		old_sec_h =3D __get_unaligned_t(__be16, hdr + tstamp_offset);
> > +		old_sec_l =3D __get_unaligned_t(__be32, hdr + tstamp_offset + 2);
> > +		old_ns =3D __get_unaligned_t(__be32, hdr + tstamp_offset + 6);
> > +		inet_proto_csum_replace2(&uh->check, skb, old_sec_h,
> > +					 new_sec_h, false);
> > +		inet_proto_csum_replace4(&uh->check, skb, old_sec_l,
> > +					 new_sec_l, false);
> > +		inet_proto_csum_replace4(&uh->check, skb, old_ns,
> > +					 new_ns, false);
> > +		csum_update =3D true;
> > +	}
> > +
> > +update_timestamp:
>=20
> [ ... ]
>=20
> > +static void netc_port_onestep_work(struct work_struct *work)
> > +{
>=20
> [ ... ]
>=20
> > +skb_dequeue:
> > +	skb =3D __skb_dequeue(&np->onestep_queue);
> > +	if (!skb)
> > +		goto set_onestep_state_idle;
> > +
> > +	/* Clone is a ts_req_id token only; its payload is never read, so
> > +	 * sharing the buffer with the mutated original is fine.
> > +	 */
> > +	clone =3D skb_clone(skb, GFP_ATOMIC);
> > +	if (unlikely(!clone)) {
> > +		kfree_skb(skb);
> > +		goto skb_dequeue;
> > +	}
> > +
> > +	spin_lock_bh(&np->tstamp_lock);
> > +	ts_req_id =3D netc_get_ts_req_id(np);
> > +	if (unlikely(ts_req_id < 0)) {
> > +		spin_unlock_bh(&np->tstamp_lock);
> > +
> > +		/* Re-queuing the frame and immediately rescheduling the work
> > +		 * would busy-loop on system_percpu_wq and burn CPU until an
> > +		 * ID is freed, so drop this frame and move on to the next one
> > +		 * in the queue instead.
> > +		 */
> > +		np->onestep_state =3D NETC_ONESTEP_SCHEDULED;
> > +		schedule_work(&np->onestep_work);
> > +
> > +		goto onestep_unlock;
> > +	}
>=20
> [Severity: Medium]
> The comment says re-queuing plus rescheduling would busy-loop, but the wo=
rk
> does reschedule itself here unconditionally, and each pass destroys one
> queued one-step Sync frame at onestep_unlock.  With NETC_ONESTEP_QTH at
> 512,
> can this discard the entire backlog in quick succession?

That is intention if there is no available ts_req_id. If we do not discard =
the skb,
the work will be busy-loop until there is an available ts_req_id. But the i=
ssue is
that we do not know how long it will take to an available ts_req_id. So dro=
p the
skb is a better choice.

>=20
> The 16-entry ts_req_id pool is shared with the two-step path:
> netc_port_prepare_twostep() takes an ID for every PTP frame that is not a
> one-step Sync (Announce, Follow_Up, Delay_Resp still flow in one-step mod=
e),
> and holds it for up to NETC_TSTAMP_TIMEOUT when a response is lost.  So a
> burst of two-step requests can drive this branch.
>=20
> The only trace is the dev_dbg_ratelimited() inside netc_get_ts_req_id().
> Should ID exhaustion apply backpressure (leave the frame queued and arm a
> delayed retry) rather than dropping frames, and should the changelog ment=
ion
> that exhaustion means one-step Sync frames are discarded?

I don't think this makes much sense. Under normal circumstances, the frame =
is
sent out quickly, and if a situation arises where ts_req_id is unavailable,=
 it will
recover quickly. Discarding the sync frame won't cause any problems, and
subsequent sync frames will still maintain PTP synchronization. If a timeou=
t
occurs, PTP synchronization is already affected, so discarding the message =
is
even less of a problem.

>=20
> > +
> > +	/* PHC is unavailable, drop the whole queue */
> > +	if (unlikely(netc_get_phc_time(priv, &tstamp))) {
> > +		spin_unlock_bh(&np->tstamp_lock);
> > +		goto set_onestep_state_idle;
> > +	}
> > +
> > +	NETC_SKB_CB(skb)->tstamp =3D tstamp;
> > +	NETC_SKB_CB(skb)->ts_req_id =3D ts_req_id;
> > +	NETC_SKB_CB(skb)->ptp_flag =3D NETC_PTP_FLAG_ONESTEP;
> > +	NETC_SKB_CB(clone)->ts_req_id =3D ts_req_id;
> > +	NETC_SKB_CB(clone)->ptp_tx_time =3D jiffies_64;
> > +	NETC_SKB_CB(clone)->ptp_flag =3D NETC_PTP_FLAG_ONESTEP;
> > +	np->onestep_tx_time =3D NETC_SKB_CB(clone)->ptp_tx_time;
> > +	np->onestep_ts_req_id =3D ts_req_id;
> > +
> > +	__skb_queue_tail(&np->tstamp_queue, clone);
> > +	if (!delayed_work_pending(&np->tstamp_timeout_work))
> > +		schedule_delayed_work(&np->tstamp_timeout_work,
> > +				      NETC_TSTAMP_TIMEOUT);
> > +
> > +	spin_unlock_bh(&np->tstamp_lock);
> > +
> > +	np->onestep_state =3D NETC_ONESTEP_IN_FLIGHT;
> > +	spin_unlock_bh(&np->onestep_lock);
> > +
> > +	netc_port_program_onestep(np, skb);
> > +	tagger_data =3D priv->ds->tagger_data;
> > +	tagger_data->onestep_sync_xmit(skb, np->dp->user);
> > +
> > +	return;
> > +
> > +set_onestep_state_idle:
> > +	np->onestep_state =3D NETC_ONESTEP_IDLE;
> > +purge_onestep_queue:
> > +	__skb_queue_purge(&np->onestep_queue);
> > +onestep_unlock:
> > +	spin_unlock_bh(&np->onestep_lock);
> > +	kfree_skb(skb);
> > +	kfree_skb(clone);
> > +}
> > +
> > +static bool netc_onestep_timeout(struct netc_port *np)
> > +{
> > +	u64 expire_time;
> > +
> > +	/* Use monotonic jiffies_64, as the PHC may be stepped backwards.
> > +	 * Add one tick since the ns-to-jiffies conversion rounds down, so
> > +	 * the software window is never shorter than the hardware window.
> > +	 */
> > +	expire_time =3D np->onestep_tx_time + 1 +
> > +		      nsecs_to_jiffies64(NETC_ONESTEP_VALID_WINDOW);
> > +	if (np->onestep_state =3D=3D NETC_ONESTEP_IN_FLIGHT &&
> > +	    time_after64(jiffies_64, expire_time))
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> > +void netc_port_onestep_sync_enqueue(struct dsa_switch *ds, int port,
> > +				    struct sk_buff *skb)
> > +{
> > +	struct netc_port *np =3D NETC_PORT(ds, port);
> > +
> > +	spin_lock_bh(&np->onestep_lock);
> > +	if (unlikely(np->onestep_state =3D=3D NETC_ONESTEP_PORT_INACTIVE)) {
> > +		kfree_skb(skb);
> > +		goto onestep_unlock;
> > +	}
> > +
> > +	if (unlikely(skb_queue_len(&np->onestep_queue) >=3D NETC_ONESTEP_QTH)=
)
> {
> > +		dev_dbg_ratelimited(np->switch_priv->dev,
> > +				    "The onestep_queue of port %d is full\n",
> > +				    port);
> > +		kfree_skb(skb);
> > +		goto onestep_unlock;
> > +	}
> > +
> > +	__skb_queue_tail(&np->onestep_queue, skb);
> > +	if (likely(np->onestep_state =3D=3D NETC_ONESTEP_IDLE) ||
> > +	    netc_onestep_timeout(np)) {
> > +		np->onestep_state =3D NETC_ONESTEP_SCHEDULED;
> > +		schedule_work(&np->onestep_work);
> > +	}
> > +
> > +onestep_unlock:
> > +	spin_unlock_bh(&np->onestep_lock);
> > +}
>=20
> [Severity: High]
> Can the port get stuck in NETC_ONESTEP_IN_FLIGHT forever?

Yes, this is a potential issue, I will fix it.

>=20
> Once netc_port_onestep_work() sets IN_FLIGHT and hands the frame to
> onestep_sync_xmit(), only three things can resume the drain:
>=20
>   1. a matching response in netc_port_txtstamp_handler()
>   2. netc_onestep_timeout(), which is evaluated only from
>      netc_port_onestep_sync_enqueue()
>   3. the ts_req_id exhaustion self-reschedule
>=20
> The changelog says:
>=20
>     A dropped frame produces no response, so reuse tstamp_timeout_work to
>     reclaim its request ID after 5 seconds
>=20
> but netc_port_tstamp_timeout_work() only unlinks and frees the timed-out
> clone:
>=20
> 	__skb_unlink(skb, &np->tstamp_queue);
> 	__skb_queue_tail(&free_list, skb);
> 	...
> 	if (!skb_queue_empty(&np->tstamp_queue))
> 		schedule_delayed_work(&np->tstamp_timeout_work,
> 				      NETC_TSTAMP_TIMEOUT);
>=20
> It never touches np->onestep_state and never schedules np->onestep_work.
> And once the clone has been reaped, a late response takes the !skb_match
> early return in netc_port_txtstamp_handler(), so it cannot clear IN_FLIGH=
T
> either.
>=20
> Concretely: frame A goes IN_FLIGHT with id X, frame B is enqueued inside =
the
> window and only appended, A is dropped in the switch so no response arriv=
es,
> 5 seconds later the timeout work frees A's clone and leaves IN_FLIGHT set=
.
> If the sender then stops, or falls below one frame per window, doesn't B =
and
> everything behind it stay queued and unfreed until link-down, port disabl=
e
> or a hwtstamp reconfiguration?  These are the original TX skbs and still
> hold skb->sk, so the owning socket stays charged.
>=20
> The queue-full branch above also returns before the netc_onestep_timeout(=
)
> check, so once 512 frames have accumulated even continued traffic can no
> longer recover the port.
>=20
> Would it work to reset onestep_state and schedule onestep_work from the
> timeout path, or to arm a delayed work for the validity deadline, so
> recovery does not depend on new traffic arriving?
>=20
> Separately, the changelog says the work is scheduled "when the PTP time h=
as
> advanced beyond NETC_ONESTEP_VALID_WINDOW", while
> netc_onestep_timeout()
> compares monotonic jiffies_64 and only at enqueue time.
>=20
> [ ... ]
>=20
> > @@ -395,6 +673,66 @@ int netc_port_hwtstamp_get(struct dsa_switch *ds,
> int port,
> >  	return 0;
> >  }
> >
> > +static void netc_port_prepare_onestep_sync(struct netc_port *np,
> > +					   struct sk_buff *skb,
> > +					   u32 ptp_class, bool *twostep)
> > +{
>=20
> [ ... ]
>=20
> > +	if (unlikely(skb_linearize_cow(skb)))
> > +		goto set_ptp_flag_drop;
> > +
> > +	ptp_hdr =3D ptp_parse_header(skb, ptp_class);
> > +	if (unlikely(!ptp_hdr))
> > +		goto set_ptp_flag_drop;
> > +
> > +	msg_type =3D ptp_get_msgtype(ptp_hdr, ptp_class);
>=20
> [ ... ]
>=20
> > +set_ptp_flag_drop:
> > +	/* Drop instead of falling back to two-step: if it is a Sync,
> > +	 * one-step offload will not be executed, the timestamp in the
> > +	 * frame is inaccurate, which may affect PTP synchronization.
> > +	 */
> > +	NETC_SKB_CB(skb)->ptp_flag =3D NETC_PTP_FLAG_DROP;
> > +	dev_dbg_ratelimited(priv->dev,
> > +			    "Port %d: PTP frame dropped in error\n",
> > +			    np->dp->index);
> > +}
>=20
> [Severity: Medium]
> The skb_linearize_cow() failure is evaluated before the message type is
> known, so a plain ENOMEM destroys any PTP frame on the port, including a
> Delay_Req that this code would otherwise have sent two-step.  Should the
> linearize failure fall back to two-step, or at least be handled after the
> Sync check?

No, first, the frame might be a sync frame, if fall back to two-step, that =
means
one-step offload will not take effect, so the timestamp of the sync frame i=
s not
correct. If the PTP clocks are already synced, a frame with an incorrect ti=
mestamp
may cause the clocks desynchronization. In this case, drop the frame is bet=
ter
than sending it.

Second, the purpose of skb_linearize_cow() is to ensure that the required
data is in the linear buffer. If a check is performed first, it defeats the=
 purpose
of using skb_linearize_cow(), because it cannot be guaranteed that the
required data is in the linear buffer at this time.

>=20
> None of the new drop paths are accounted anywhere.  dsa_user_xmit() has
> already counted the frame as transmitted via dev_sw_netstats_tx_add() bef=
ore
> the tagger frees it, so from userspace the frames just vanish:
>=20
>   netc_port_prepare_onestep_sync() -> NETC_PTP_FLAG_DROP -> kfree_skb()
> in
>     netc_xmit()                               (linearize/parse/offset
> checks)
>   netc_port_onestep_sync_enqueue()            (queue full, port inactive)
>   netc_port_onestep_work()                    (clone failure, no
> ts_req_id,
>                                                PHC read failure
> purges all)
>   netc_port_purge_onestep_queue()             (hwtstamp
> reconfiguration)
>=20
> netc has no .get_stats64, so dsa_user_get_stats64() falls back to
> dev_get_tstats64(), which folds dev->stats into rtnl_link_stats64 - could
> these paths bump dev->stats.tx_dropped?
>=20
> The changelog only says "Frames that are not one-step Sync still fall bac=
k
> to two-step timestamping", which does not tell a reader that enabling
> one-step turns a degraded timestamp into a frame that is never transmitte=
d.
>=20
> [ ... ]
>=20
> > @@ -449,6 +787,21 @@ void netc_port_txtstamp_handler(struct dsa_switch
> *ds, int port,
> >  		dev_dbg_ratelimited(np->switch_priv->dev,
> >  				    "Port %d ts_req_id %u which seems lost\n",
> >  				    port, ts_req_id);
> > +
> > +		return;
> > +	}
> > +
> > +	if (NETC_SKB_CB(skb_match)->ptp_flag =3D=3D NETC_PTP_FLAG_ONESTEP) {
> > +		spin_lock_bh(&np->onestep_lock);
> > +		if (likely(np->onestep_state =3D=3D NETC_ONESTEP_IN_FLIGHT &&
> > +			   np->onestep_ts_req_id =3D=3D ts_req_id) ||
> > +		    np->onestep_state =3D=3D NETC_ONESTEP_IDLE) {
> > +			np->onestep_state =3D NETC_ONESTEP_SCHEDULED;
> > +			schedule_work(&np->onestep_work);
> > +		}
> > +		spin_unlock_bh(&np->onestep_lock);
> > +		consume_skb(skb_match);
> > +
> >  		return;
> >  	}
>=20
> [Severity: Medium]
> Can the ts_req_id comparison here match a different frame?  The clone is
> unlinked from np->tstamp_queue under tstamp_lock earlier in this function=
,
> which immediately makes the 4-bit id reusable, and onestep_lock is only
> taken afterwards:
>=20
> CPU0 (work, frame A response overdue past the window)
>   netc_port_onestep_sync_enqueue()
>      netc_onestep_timeout() -> true, schedule_work()
>   netc_port_onestep_work()
>      spin_lock_bh(&np->onestep_lock);
>=20
> CPU1 (A's response arrives)
>   netc_port_txtstamp_handler()
>      __skb_unlink(clone_A, &np->tstamp_queue);   /* id X now free */
>      spin_unlock_bh(&np->tstamp_lock);
>      spin_lock_bh(&np->onestep_lock);            /* blocks */
>=20
> CPU0 continues
>      netc_get_ts_req_id() -> X again for frame B
>      np->onestep_ts_req_id =3D X;
>      np->onestep_state =3D NETC_ONESTEP_IN_FLIGHT;
>      spin_unlock_bh(&np->onestep_lock);
>      onestep_sync_xmit(B)
>=20
> CPU1 then sees IN_FLIGHT with onestep_ts_req_id =3D=3D X and treats A's
> response as B's completion, sets SCHEDULED and re-arms the work, which ca=
n
> transmit frame C and reprogram PM_SINGLE_STEP while B is still pending in
> hardware.  Workqueue non-reentrancy serializes the worker, not frame
> completion.
>=20
> Would retiring the id and moving the one-step state under a single lock
> order (onestep_lock then tstamp_lock), or matching on a generation counte=
r
> instead of the reusable 4-bit id, close this?
>=20

This is a hardware limitation, the response frame only contains ts_req_id
and timestamp. the driver can only use the ts_req_id to match the skb from
the queue. The incorrect matches can occur, but only in the event of a
timeout. In the event of a timeout, PTP synchronization has already been
affected, so incorrect matches will not cause any worse consequences.
Once the link recovers, the timeout disappears, and subsequent PTP
synchronization resumes. Therefore, it's a trade-off.


