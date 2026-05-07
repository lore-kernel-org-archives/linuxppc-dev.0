Return-Path: <linuxppc-dev+bounces-20546-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E83BDCD342C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 May 2026 02:42:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9xNV4mFbz2xm1;
	Thu, 07 May 2026 12:42:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778121722;
	cv=pass; b=QIEpcfgKU0hwscDKWPiD8Xvzj6qkObfJ3zhdlaz9N/PVE89sCzQ8E8N7o3da6FnfPyRO17q9xUXR86NGRtdswqhCGf9QwomEzaK6/6i66fDrBAgPEdWTUN13V6LtJDoye3tYo4O1GcQWWUMqlgXbnbuK/pLXm4oQ2KRaK95S2G3YWgOhwTLez4g6TB2D2C1pxZo3IpJbWtEmq2M8UO4PindkbZl/0VviDQhkUGGYcX2KmxE+voVG4/JrDlPWLsjIkQtJcv6uy0ZPDgsk5wV92+sjmtL6n4LBABum8PuTgqgYkSFp3UAudauVSwnYpi1VWnbEBDQQx6X7w9eLrG77tQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778121722; c=relaxed/relaxed;
	bh=gTdJAAz9h9cp89iquOygpaohN+RrKF/eO812+hQBckw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EWh1WOP47TctfBESquqRYYSBgIDGqsXfxbnmircMdQvCBGrAZzLCwbMv2u4zr94vcxc6W9xcfM/MjrsWwu5g8ANeU4tqWeMkKrtXO7OTpFqfYnYKNJN3T/33OzfRvmYXN0lI08c9OL6UGqyjHqvPMQf8ggaduFcg8atTmRvvEFFnrg+Kz4xVoXy08YoyBJomDAl+jCxdziYDFV5qfmHfo0SJbj63S9u0eb9vScvxbi0e3I0q09frPB0dVwRDENMX4q3r21cO4W1U8cQSJO8hfwLCGWczWRI5iC64r9xtsl8WLlxpjbS1YkEgmDK/AP7DieN7F1NUF1yl9qkXKAswvA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Zs3FgiHb; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Zs3FgiHb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9xNT2gfgz2xlm
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2026 12:42:01 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDMtlPqjVAnuZdYoGAiv8v8htE3s31q2LTf2mBYDjVG84wAiOMJDhAcENYAY/TEtecE9oTUELzT4ehC/0IIeT4M2dEJ/6pyb1q5Qpos92q3ElkDpLnq5yrw55B+P2X009wsrSNkf7xQHwXKsdQ0wEiasFTMb1NVMDYjVDl31T/YGH/qpiv0LzIy0RElg2VSEudArZzLHc01w0l1Hjc+c5BtFSx3oKUaCz5yb3UmjKSG+YqcVZNR7DZJQqiPFvrgQlkTbKTBUPGZ6A0lcGS9hx5skkZ9FDrT6CAvRA1EdedZUoqCit8bsSp4FTcLDvSInh8gDD6BRELwhAuU+zkUseQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTdJAAz9h9cp89iquOygpaohN+RrKF/eO812+hQBckw=;
 b=nGG7SSYVv6uK4sUuJuZjwwn//I4tDtpn1aBrUDxMHuJ8GYm1Y5wSNEj/r1O8GZz1h94fH2gBgLXR9NE8TB0JGYxrgbu9E1Z4vRYbO1C69Hf5LC25WVnZSOd6EG6oi4nNLKCFbDy3aZH2OqXqdiYGcMX9B2uVdFGkk14YR8KUKEj++XaFfky36w4FG15wmWfLKomMlQldquVXnLtkWZREf39Xj6veY05Dr3Dy9ilWKf821HzThpRYk/NLYtcZsPZkBIaEj7VglK8AK7MahLbdmFGEJyG0G+1dI5L69CUsfbGAfJY7wf1wdQ3BGQYUxEfvqEAg+SZJufuj528RpwcERg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTdJAAz9h9cp89iquOygpaohN+RrKF/eO812+hQBckw=;
 b=Zs3FgiHb/5bko7Di/AgWqoZumja1FKsI8KQKxVTHXaRrdNPWbPzSPgrpWYoW/7adVTO6xSM2pFUv7NZWpxW+d4wYfkkWqv0gqLSh7AkMSfSvEBYlqWrcliNcOcIckjr3JbvdEpyUm4p2BuUCK+kjL9YFcfsPhAe2Hp62j/7mJT2dKXlkFEMVirfOoLe3TdP8e0vLqT4fHj6WwV5oX0SFsgEN5tiNMXtpxfST3+3qqB6GeGndZYTUXO9WV82yUQ8H0AnF/ptrDNGse/xVNkTETnO5RbH/fhhhApIBMtLsQp9gOhyG92+L7Zmtj9a75KUrpeYR5LSOh4o6mynzbpVB7g==
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by DU4PR04MB11725.eurprd04.prod.outlook.com (2603:10a6:10:626::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 02:41:31 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9891.016; Thu, 7 May 2026
 02:41:31 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, Frank Li <frank.li@nxp.com>,
	"chleroy@kernel.org" <chleroy@kernel.org>, "horms@kernel.org"
	<horms@kernel.org>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>
Subject: RE: [PATCH v5 net-next 14/15] net: dsa: netc: add support for the
 standardized counters
Thread-Topic: [PATCH v5 net-next 14/15] net: dsa: netc: add support for the
 standardized counters
Thread-Index: AQHc2Evqr/Y+KyRnR0mgO12vGrKs4LYB4XnQ
Date: Thu, 7 May 2026 02:41:31 +0000
Message-ID:
 <DBBPR04MB75001C6850BFBCBD825E9D43883C2@DBBPR04MB7500.eurprd04.prod.outlook.com>
References: <20260430024945.3413973-1-wei.fang@nxp.com>
 <20260430024945.3413973-15-wei.fang@nxp.com>
In-Reply-To: <20260430024945.3413973-15-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7500:EE_|DU4PR04MB11725:EE_
x-ms-office365-filtering-correlation-id: 4bf6fa01-7488-4a5c-eee2-08deabe225aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|376014|7416014|1800799024|18002099003|921020|38070700021|22082099003|56012099003;
x-microsoft-antispam-message-info:
 E/Ih/PmfxRpfwuLcQZBEuRglRx46CSobrxt+ZRVUJJLK3RzC6iJFSEk4+tONJQH4y2OFksPl9Myi45rGA8Fuzk8mmSEp9igfLaRrquZmXCk1mbbn+Xt/hNlLnhfkEnl3BaSw76H95CkUeqoH6lDfFLZakNoOS8Enm2hqkm0bqIP7/mcI0vaNtkb0unacKqv+epebVEI4V/I+NeoDEnrxeRs2aWOfaB1jjXLkjR2SBo7J8oVwyJ+9zF7yMwBmv3DBmBSTKvRItsy7wCDTtOHrYf/PdJeLHLvlqSFccAXPXmS2RtixGKKf01aRwpwOeEeyAhOqPkz1RTPhnMA1gCFQnP4TfMscrEAbX4ExXRREaQWH2LAU2vmb5qukCcbZZEOCiJZzd+xsGqLJMjHoPIicqmJpPD9b0Cbf50CuX4yhlfaY695el92ImKJKRZUgy1BiG+VIHfTV/Wp8MU8H8TziwwiQVBntqDAiRSn2zPGyT7Dg7ckQBZcx0D2Arhp/MgiZXGkZJ5DF+LjNlVaEst2WxrVxExkAiI1b7SxCA2bN/mbSv4n/ouxp4xUWl26TQ9fJpd6UnIwec3ZtnRaxt3mceX8fUNIC0Bg2dsmCrfMw52btC+yK9504CRW9MMQzAjQSIv9HsOfD7gGl/zTDJuEXraKro9UA3NOYlx0Cwf7OqzzAyYjkPFocBnywLcqV5Hwex5G9q2XWR6wYbhf05TGVXApejxLC6b2JBu/IOiOvG7OLkU5Dkny2V3ZfKpE7XS3/eupjN/RbRuq0tpokhVQmFg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(1800799024)(18002099003)(921020)(38070700021)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?p/lD97mwG/u0w4DbvZCbNBYzLvoR+UNzbQs7gs5djglkZD16fpFkfgt/g05O?=
 =?us-ascii?Q?1v1WRT+9lPvYTZgAV/exJhmLTqV1hDXe1/DLe06SFU0T29c672h+DpsQc0IH?=
 =?us-ascii?Q?4lS20bLB+HF2tcNjeWSMBI0Q524ASFiYmsDhiNJLWO8mjn42A6Rjf64Z5tIw?=
 =?us-ascii?Q?0utYFdeUgRr/dO3xCRM6DC4oCe2CbCvLuDg71gHO9DoNe3DN5xvFXTwrlx7A?=
 =?us-ascii?Q?o97La6rEkHVsDZMzRl4z8BZ0tSsqHXChNaw/h22R5LdXuv4aTAid5/uq/dMX?=
 =?us-ascii?Q?zLC+bJuboY92fStl4cDnjNPWJ0x+mVeI+5YcjizBl/rhAm2Ih0byCgTs/nV0?=
 =?us-ascii?Q?JG1y42mVka1C8Sj89UiuN4zXwDvxSYeNselmDzr71WbQin4ABY7xW4s6CUFl?=
 =?us-ascii?Q?b4amY65U8lnms+Apkc4hvtn4Q8JS8ytP/RWE7FFGE6puqQgpUzYbO0snI1Is?=
 =?us-ascii?Q?EGBjI/eYMPU7gdY26wHmpDtJr3fGyFe61OheGI6SssjsA0VMc1mxHo9wth5C?=
 =?us-ascii?Q?PMdVVWFVPuQXms/iVvOGo1MPhGqwCdnJZyiCMCI4rkr/UWYKU4tAOR6zA847?=
 =?us-ascii?Q?jeHWTCMOVIWtRp/+YzLv6hQHyi1aL8UOOLGi/3CCTwZT8OEaaf5HUSOFc01c?=
 =?us-ascii?Q?xxjEM63M//+X29/Q64mmtcTejKhkx8QStGPeq5nzaK+AyRPtRe/XThvEVu3T?=
 =?us-ascii?Q?vppMwh/fkKF3wc2BcKtywK+oqKQLUEOuf+wNKmxBEecRYcH86ue6M5lrUuL2?=
 =?us-ascii?Q?HxO7Pa3D2VzsPb6aL9/iL0oyPpTDD1LXdsmRYLWQ86E5cZ7sEtI2Ku2cGiSF?=
 =?us-ascii?Q?UjcbMYeG4eCmZdFARgc/8NOh4oZScruAYbQeFp0dw7pSHCHsWPU/4Dyv+mDA?=
 =?us-ascii?Q?DmjPHL5tihLtI7AxIfCMTUQuDi7/wmO/YGKKDPNHbPbgn/8J59c5Vru8B3P9?=
 =?us-ascii?Q?Nd/U2VhpS7lqSi/z7XeKWJkhhd6YfW0zXBMI5pUwUUpIcGB3rkXiHCj4Gnre?=
 =?us-ascii?Q?jwVX8fhNVDV8+j4qv3/DDDwjigXrlxSxU46q07bw2aQSJeJConl+mzdS+5ik?=
 =?us-ascii?Q?9LR2MpRmTPWFK64RBClk/XADuqHxQof69zriLnzOnMjJIbTKbhxZh3GQfUkl?=
 =?us-ascii?Q?Yzvh1LuQBoPJ3uykCPUyyM2bACcMKGIXlzoRm0dJf34s7UivMPQFdjYZR6W7?=
 =?us-ascii?Q?AOXMxpfefFnC2YT4amDptUHmmphSA2yxwX1Y/R3etOXRIoa4irQrN36WDC7t?=
 =?us-ascii?Q?bB4pmWHOUPz7cG7lhJlqJPm+5pSXbznvZsmvivb+7ZF8RbFdzJQVkoq6Lu3t?=
 =?us-ascii?Q?hU3hA5T3ARSdq5tH1kuI1Apv6ZuZS1eRM0ZcOm3KHWUeAbvfYE+8VcnYa4HV?=
 =?us-ascii?Q?7PPySCwaMzs6NF6U6ENIuiEg52frfEnbMYsC8txXaw4ZOYMBeCRB5BNZOBux?=
 =?us-ascii?Q?6fMtKsyvr6LCnsZmGd5rjHYjCloyiq2gwIdOoc//KfJOtqgT5C7X11syZp7O?=
 =?us-ascii?Q?bG1tmAwoXORiwhdQ9TojuypCp/VAu6XTBFvXppnAyADIdbmyxxpxUVC2DcKV?=
 =?us-ascii?Q?v/pxJvJxUF4pRAgSR5xG2rhvsVAiWUtdMM1jY3YblWPJ6QzrY57YnsDr7MhY?=
 =?us-ascii?Q?5d9NjSLViw1gO1n0Ra+wT9njhfA1T0uAcRI2QXkbqN2NKOBCPuxSFPpdpb11?=
 =?us-ascii?Q?TEu19u18BR0NksT2SU57G1sdotbOf/iFsWRitNcIAC5po9OJ?=
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
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf6fa01-7488-4a5c-eee2-08deabe225aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 02:41:31.6074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +X6iLbjTO21IAyUXXnBYcF556ukUC86rEv4/EzuNqOrujBSKMk+QAxtcr4HJHnU6DItgXW7JCRRRlZSRxf9kjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11725

> diff --git a/include/linux/fsl/netc_global.h b/include/linux/fsl/netc_glo=
bal.h
> index fdecca8c90f0..5b8ff528d369 100644
> --- a/include/linux/fsl/netc_global.h
> +++ b/include/linux/fsl/netc_global.h
> @@ -5,6 +5,7 @@
>  #define __NETC_GLOBAL_H
>=20
>  #include <linux/io.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
>=20
>  static inline u32 netc_read(void __iomem *reg)
>  {
> @@ -16,4 +17,9 @@ static inline void netc_write(void __iomem *reg, u32 va=
l)
>  	iowrite32(val, reg);
>  }
>=20
> +static inline u64 netc_read64(void __iomem *reg)
> +{
> +	return ioread64(reg);
> +}
> +

Sashiko says:

Will this cause a build failure on 32-bit architectures? I noticed
ioread64() is used here, but it is strictly gated behind #ifdef CONFIG_64BI=
T
in include/asm-generic/io.h. Even though linux/io-64-nonatomic-lo-hi.h is
included above, ioread64() isn't provided by that header.

If this is updated to use readq() to fix the 32-bit build, could it lead to
torn reads? On 32-bit systems, readq() falls back to lo_hi_readq(), which
reads the lower 32 bits and then the upper 32 bits sequentially.=20

Since these are live, continuously incrementing hardware counters, a wrap o=
f
the lower 32 bits between reads could result in a spurious counter spike of
~4.29 billion. Would it be safer to use a read-high, read-low, read-high
retry loop to ensure atomicity on 32-bit architectures?

First, if CONFIG_64BIT is not selected, then ioread64() is provided by
linux/io-64-nonatomic-lo-hi.h. Sashiko mistakenly believed that
linux/io-64-nonatomic-lo-hi.h did not provide ioread64().

i.MX9x and S32N7 and subsequent SoCs are all arm64 architectures,
netc_read64() is used to read 64-bit registers of NETC.

So this is a false positive.


