Return-Path: <linuxppc-dev+bounces-26426-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18D9C61DD6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2026 01:44:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZQW26XwSz2xLG;
	Wed, 02 Sep 2026 11:43:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788313438;
	cv=pass; b=jEePe30ehWZgOUJxeoqVXVw95/oybrM76EoTirkkgFXz+8Pcoq3gmUBFT3N1z4oDrZQzSLZk89bAVt7bBNmddDFTTWV/20VZc2TLPnukNSI+mQ+1dcL9f/btXWeQAwNmKGaVSuGegjZeznDNybnSzoDmKETIr0jz16Ilo3KmhsCk3x1M0X5Huov+RxJTm1y5ndCpGSiM2c42m6P3bKz9RcNHBRLk6ic0BCgSil07q4JWkmie3zD3WDzf9N2jbQE4Bx79nzYym3sPq+yI7Tk8iVAad4WC6FVOEemiYliS4ejaeRU2NwaUaYLXKp03/r7iKBetZQB+/d4dGKW8H8J4BQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788313438; c=relaxed/relaxed;
	bh=AQaLT2zZCFDWN2vwwfUKQXLUXtpMPHPvIGpOsySFKns=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aGmaKfOsITVQFtPOzXTiJpaHV7sYn+z2kdD2mXry571bGsQZmGmvlU1+cb3wdScADfZtm/73eQ20NUjo0q7KhfVhPJ87HmVHOaLxUfWlGoU+btcPepbznKXureJmwjUV9mJHRLbH4/B5CFUAiXnM/y1vVi5xHzbWGj40fh4JpDEBlYDzl2HW9YSQABa0nsGGpThQxjEwAhMt9nOROf3bH8r0cCTiciGqBnxI1q6iaTGt8hfS5OTTuNbcMk5p3LQcEShVtqO01ec2OYIdduHqpG17RchYL76uefPPctGR5aALJ9J/BkUEL2bQVLrjFzwZj7tby4bc7u9HkqNS94iyXg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Dcz3EJk/; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Dcz3EJk/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZQW10xR8z2xBK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2026 11:43:56 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qBZqaWaSU3ryvaPTCUQP435oqYWDrq5vubPZDA3TVjkzRlfMRXiKrcdUugiLcZ7lQVRu3T+Rh61/5glm2P+dM9D4zshx14GPoNkjS4I+qR1qQn/qwvk+GZ3UsvaKP0WOKxR1dBwVVR3n7h7BLE9Y+JFzJdDp+RyC5haF90jWT96XMLeqwLD2nqucNM8AOfCLLvhs2aw7PFps7a2dPciRtrN5VYaLlijuuw3XhqD9SgjbNage9aytSqz8sjI0Qi/mxVelBTF2uxzagZEsGj0Y9qHNyu3nhXYIOB7X/nw+YCe9hOdZXTa/A8VD8/N5rtpTbB2hIR0Or6xETnJNBZB/mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQaLT2zZCFDWN2vwwfUKQXLUXtpMPHPvIGpOsySFKns=;
 b=UpIKFqJWVnpOA/HKdR3opTuH0N00Ea2YgcWmakk2eUpw1/wVIQQRXrrz6YwLhrM65hWnPD5D56rpFcU8Eed2mX9GOvhWw31AH0Lh9+p/MyGmcfgrSOuFy3OSsngre7BbPrmSBpE4UuXRcn8M2JniKIH2PNXaP8Opu4h2MwZmsxqHY1AtPSlFC3CfW6388hWekXQQ8HNykIRi0XEiIXbkkQdXz0GdJmuieDx2b+YQozRrVKAvprhuSUBEinyrZGPcWBNtVkJ7toUVAVhovbXJ08g2y7z//tcTWBZ+mZ4rjW4gg9tglsoR4Tui1V+7E05OXsDv2l55xJhIC5U7+XDGiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQaLT2zZCFDWN2vwwfUKQXLUXtpMPHPvIGpOsySFKns=;
 b=Dcz3EJk/tiXpP/2aZA0SHoYEQ+M41gd0u1mufTLOtioSUgfU1q4YNZhjugHa4LYKWN7mkd4w1MQOKeRh/sD6q7dU1j1BgwfZyS96OYv29z3adbZSsls8vdfi8GLlagXj+bgz785KAJ5iUwnMh0SMNmD9WzY6n4zTHXzLzsQhcVhD0jsaScuiWNKkNS6ah/AtPLXtVSusEByoF2ZQSiwiU5JSKJGbOvTNu/eqNZNWCXT4IZCtcgUdw0yhNeEW0/uiN2JFano1yLCiHPrjmpa6EMFX2p3Gcl9pg+C+bfx4qXnFkHmZFTCVpx+E8x4r1uJLYxlWlJl8gMwXCIGb9PBHxQ==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by GVXPR04MB10202.eurprd04.prod.outlook.com
 (2603:10a6:150:1c2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 01:43:30 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 01:43:30 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>, "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
CC: Clark Wang <xiaoning.wang@nxp.com>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"olteanv@gmail.com" <olteanv@gmail.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v3 net-next 0/8] net: dsa: netc: add PTP support for NETC
 switch
Thread-Topic: [PATCH v3 net-next 0/8] net: dsa: netc: add PTP support for NETC
 switch
Thread-Index: AQHdOSFyxDnezHhky0Oua7JIEybwnLa51ZsAgACwmjA=
Date: Wed, 2 Sep 2026 01:43:30 +0000
Message-ID:
 <GV2PR04MB11739E3BACC0BAA6DE3E1461D88B72@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260831082335.1184605-1-wei.fang@oss.nxp.com>
 <20260901080950.63e28bab@kernel.org>
In-Reply-To: <20260901080950.63e28bab@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|GVXPR04MB10202:EE_
x-ms-office365-filtering-correlation-id: 9a6a347b-0636-4312-540f-08df0893975e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|7416014|23010399003|1800799024|366016|38070700021|10067099003|11063799006|4143699003|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info:
 TN+VY7AUOFwSsVzrlhJ2EPzi9Tpm1SAJiVfIILb9abEzyBZI+UL3GkAG3eaKOW5C5D5gKcI06f7F9wk86O7z4NknUZCjlrT2sIF3JP9/KiiVRpwEd/YKz5Pub2G83rqsLso/9iad79KpEuwu/tfHhhR1iKk0UBSqVmFgMDBTyq7CHtS7oHExr4PyFksoJ2eOji8Siv+p1cY2gi1++rlEgiRb0oDHt27xaldh5EnHdxaafm6Kh809mAv4+y0bdJ8H6KYLKAwtEtkWSVIFC9BDt2lRC3eo2gOiKQKGPwZNa8gfGFli/R5dzm6tE9htVDCvWY8g31rPijAvOjn44EZE0Ivpxc5y08RPtEb7W7QY6NfvXCdVNMBCPfd28M2LPoWxujqrkFrMQxuDRO1cZwUEKFvXVyHTNBlU02Tbr6IFMpAZE5LwganEfEozA0XAsKIV/d4qOq7MdLW0GbP9AZV14pxzdMowphZz0ioSiufL3h4KZ7xj835K9IqNpzVKekMb6k5sC+cVXXbx+WYDEQyIuR5jbpty+229XHP4cYT5xcq6xtr77BUCGJkpssIsvQYH5QGjkzwh77RUEXF2TXwGpbo0HV2yg/LcO3gM9kgZya/3iHJvcBUscr9lL+XqSgk2iO8PzeX5Mp3Q+asEYQ2oNl0g4S88adWiJTkfeaFygvhL+MuZ+E3jLgBL0kn14JhXbP8j4a9gE5uO+gJd4BDhPMIJcnH/5m2smX03OeWa4zA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(23010399003)(1800799024)(366016)(38070700021)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4cVFDfVSYojDMiejlpGEjHh1GMSwPiC1BpFYx5wvyN/h+KO0cVq1uUUP2ICF?=
 =?us-ascii?Q?Qhc4jgve2e2k+FKYe9O5jCjt3yq8aBMgn7U4Zisw2a0uj4w7GAtov+l/IjQY?=
 =?us-ascii?Q?5va7ORJ6a3gxPkIwqx/f/hDqxFpoH/woYWiIQVDlbXVvumzL2KDtCgS+pQlo?=
 =?us-ascii?Q?giYzMIT9d6Qscla7qqwBuZuC6c31CyfQmcQhUtHPSO9VC8KtW7XT5sHtHWWZ?=
 =?us-ascii?Q?LFgfstBpBSgU6nWx9F50h37kMb0OPylF9mJ/XlLBBun9GJ+oFaIBPwnfz1RQ?=
 =?us-ascii?Q?NTeZP+8TPTXJiojT38lAi1YQPQOxe769mH21PSYIOg1ggg1wtKrTVheChOpe?=
 =?us-ascii?Q?NQRWIdXxJvZ91Paun41PapA0v40ayVuZkJGCfY4uEIH0bQjTUwoDwTsr9aIp?=
 =?us-ascii?Q?SGlXAcFKHd3ZsEniys8kC65ntAZKt52CtuBGYrQxzcxQZ94fgsvTvN1OveBX?=
 =?us-ascii?Q?ky/mYBrgULsUnIUVfHnmYXf1/B5cnUiTF1AoWEFQQ0B7ZPTL8xzaGnpEsB3K?=
 =?us-ascii?Q?Rl8gQmgLPQLH/0BEV1PFDYKCY4q5gvoikisbCtIQ2JlsqzAIaHec7l1+JQFW?=
 =?us-ascii?Q?X1tSY1ijcRogOuQDHLa/d9bo/qL6/Ia9WfyEgm8hUxy02kl8oj80m6U2r9gq?=
 =?us-ascii?Q?18LLTMLGZz5+JRsg/6tpDv7kv8fZJ6VioaMnAo0cxmKIPsxDkuyUiJdQ6Vq5?=
 =?us-ascii?Q?s0Os8Mw/pBEtuxdSnm+NN+7f0LJYrSylris8fMZr3EnG6osZNOfSolWeOPd/?=
 =?us-ascii?Q?0rjzhcd+Ks9vcYK/y0Sf1cZ9Efq57cUAlF7idp5gOXJAlAn2R2htHbVRc6p5?=
 =?us-ascii?Q?IcjGIsM6nQdiE3AZ5WhXWEv+MDJTBfQV4t42Ov0O5RHp2ztPLjRnFZyCbMEO?=
 =?us-ascii?Q?uESZh8ykQWCjsW1fw4XXfzA4poBty7cMJZNaiuafePnfo5EsQGK9F/BaqAqY?=
 =?us-ascii?Q?+y/3AfW2ZDhdnE0mr+r9oAdnGeumc5WmQX/WeXTxNe28y/W0fF6gMY+4e96a?=
 =?us-ascii?Q?LYzxMAPS+NI65rEMb+eDDPzclZj/d1lx3t8TVkwwYPXD87QoCbtpqFVN2s9P?=
 =?us-ascii?Q?iLLGAaTii8pdZ5Y5T9n6sp5uxB8PifsIrBSSF7XmXAA4plR1LpQ/CBHf5bSv?=
 =?us-ascii?Q?FXXg83Y7QXTuNXiiLdJg4IPjXmQ8riu09z9DnQcYh0Dz7Mo1zniFLf0d+NuS?=
 =?us-ascii?Q?ryhvVkhW+08Lky9/89Annx1GwLkySbR8H9pRTB36Z4i/2JyKv26PQh/bo1yS?=
 =?us-ascii?Q?oiPvkPgKGMyq1OI2qU8NfLQ8d0I7WiyLY2v8TnG7X6et966V2VZ6a4CYijYQ?=
 =?us-ascii?Q?ZnWHJQXDi4pnCnl/HbdvYTqBZtwhR9yqMn55i8hAjYbjMRkVy4gdbeH2sRH8?=
 =?us-ascii?Q?RzR2gSjTMD7s4XsjtesOGSCt0uOaDP0AkfzGqy4CCcrnxXKbT6qgRJpCuYqN?=
 =?us-ascii?Q?1c0HsEWyx+W3jOHd3p+/n3en5/r3j/9fN9PZgfiWPQwEVFy0MxGCvFGBIvN9?=
 =?us-ascii?Q?qxA9xSk03Q3b7Z5G46S6YlwlF/GK4L/btTTUZJRvWJgPsa8qR2Lg92jIKKHT?=
 =?us-ascii?Q?MYHms0nPWLpZYU+wpLpxJ7F+7yld2xrU/a3xf94G7Tg3w0z/bAKb4KdBRG19?=
 =?us-ascii?Q?BeHM58ZbbsIX1nlORqYgyzNnA8iUp3Nqa70Pm1P2D6unyxw3E5W+X5H7Ulpq?=
 =?us-ascii?Q?mLlVQbuTIsHDHc8fSbbK7S/gXsX+eKliJBNX9xeIsMM5ZljR?=
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
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11739.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a6a347b-0636-4312-540f-08df0893975e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 01:43:30.2036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VurXMC6kxp/XhKIX1xxKhMbKKrA98VGYIITlmDtN2ZQSRbUe3ZdlYWUgDRSXJeYdufHW/3BAjJS2ZcpE5ZJbeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10202

> On Mon, 31 Aug 2026 16:23:27 +0800 wei.fang@oss.nxp.com wrote:
> > Subject: [PATCH v3 net-next 0/8] net: dsa: netc: add PTP support for NE=
TC
> switch
>=20
> Please be advised that the limit of 15 patches applies across
> the series. You posted 2 large series to net-next at once.
>=20
> See "Limit patches outstanding on mailing list" in the docs.
> If this happens again we'll be forced to start discarding your patches.

Oh, sorry, I was not aware of the rule has been updated. I will repost
this series when the ENETC VF series is applied to net-next tree, thanks.


