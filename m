Return-Path: <linuxppc-dev+bounces-20504-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB83CD3424
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2026 07:35:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9RxQ0QyTz2xdh;
	Wed, 06 May 2026 17:35:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778052921;
	cv=pass; b=aCsWKl2pcwZywRBarlfm58n3unrYBfplA1uiJ5qvBV3v7yNSrPQIG6iHhd/fjFPFVcRIHWOdIW2XO+7J2raLQPkx3TbarFnE9RCEpxXcltu98PBztroXYroUEekHH5ruAuPtNngw7CDtXFRSkLxAC75aCBFWEtUt2xmQZInC+kCVnoprkTk4ThsqIoAbQCjvgfncyIJcmMduii7DXvguHjKXjqJYi7Fp4ubAoJQDpFJgEtdRs3PYs6GVZSYzBMMt47sgkshZsArWjuPgCmkqpF4y7D+9NhDErAa94j8hn4UCZRmpfEw5YvWioOnNpO65Fy4eC5xwc824ysGYObANuw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778052921; c=relaxed/relaxed;
	bh=coPWzdunrUu5dnMXo2xgB1O23ZMxkZq+e5FYUmmfKyQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=luAjxIP3Rq/DI6sMWK4ZseF2Dm4z68hZVqPYnEdpWkbe2Me3r1fuWs8t/tF5WPNPGCo4KgZTk2GWiwYJEudVtkcTf3DsvnA2G/M62ap8mod4tlVnhHV3PRI01bk0RMROIODn565ZDSHE/oMuzSBN3hiwPxRYV7lbltjaIGVQG4uBp3yEJJRGxXvg4me7FqYjEMyDl/v62npErfnsvq4H6Ul7iWoHSIUNLYJRDJwVevg9tdDtdGQRNk1EKkT0jmf4JWl80bE0SYBgZKwk35KZiDWAWQ17YieVRvHJZc8iqgnW30IKwZc1cmmCj6U8XM4Mfi9v9FgcGS38dcNWH7C12w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=VwTwAgmN; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=VwTwAgmN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9RxN6kFcz2xdL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2026 17:35:20 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wMLbcfuNNvt3t1sh7WWxFcrxVzGqaMxsn9TuQ35cYs5LsbA7So7Rngcx3SI2RDAw9PjqaM0ZfZLS4Hc8A1UYyLt8ffW4V1zqvkfakZO5v/gb7FTV3Wh212b1ldXHtAwAR9IM9g+aD21ymzUSSoBTJKwEdxuf/rvVzeVPn48xobeDmpT/jn/UjAwaE3yA7SVMSezXacD782AyZ7PwS84gZ0Vx5mRKiOVlWfaoG3VGTaENIOZ8yMKpQIp5d/B4ftOMa/WluqW/fxEYKioJSKEaCGQZLo6/CVCsZ2BgycY7TZLiI7WDsXjTyE7mGsHIn3rMbEzPb2oZ/+8c8VNFt/K8hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=coPWzdunrUu5dnMXo2xgB1O23ZMxkZq+e5FYUmmfKyQ=;
 b=n2NXWtc5PWCvA61QKNgeRAagSC21DecC6W7s5l/5Co0L9x68ig5JIm4VUHXJ8fAGwR851BbA2aMtQdyXrPDwylvj8Ih/jFfyADSyCETBoD1RNBfGHEEtZb6+fupyRImqjPKq/Ep4+o5iMeqVSa4Ul/Sf0JpCOgFLf0maF6m/bmwiKUrsHN1lVZ11R9bvj/vkrhMtKXAgkpgUzxXRzM4oNeOaf6xaJpttmf2w/U75OKFbv8+0vO0iBg01kNlfoGO3I+tel6bmsBX9cgdgAqVEM7D62LcxeMZvN6g17m/OLU4hjFZINkKCFhmm1uTGD7vRd1sMC31gwVrtQCDRw8xH6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=coPWzdunrUu5dnMXo2xgB1O23ZMxkZq+e5FYUmmfKyQ=;
 b=VwTwAgmNjokiE74qSZ//9k6TkQBh+AUqcIW5916FP3iSOlti+lYPIvpi94lU7tAG1JzzKECLcUniz5rn9rQiLFo2KtrA/tGA4Yskfqhhrap6ULWoKsI/0P1k7oN0dAa9UyaoUae0JYFMCYqdMhjQNSA++0A96w5LlHPDqDN2+5USh8AIDvZqHpb6SZdnHbleIFer9dP4D0tUiwufzKs6SJ/L8njm4iJFZohlXgA7Z6MPnCFQAs/srx+4EvMY5lhvSzI71tFVCrhU7nHtPWOU3ivyfmSjzvsSRTopFXGqyAhlFNdwSKSuxyLu2kBKnY0dfpLba0GatYqD1jTZKUH0jQ==
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PA3PR04MB11228.eurprd04.prod.outlook.com (2603:10a6:102:4b0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 07:34:55 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 07:34:55 +0000
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
Subject: RE: [PATCH v5 net-next 09/15] net: dsa: add NETC switch tag support
Thread-Topic: [PATCH v5 net-next 09/15] net: dsa: add NETC switch tag support
Thread-Index: AQHc2EvUOY2eXubYx0SUTOxsaXqwubYAogjg
Date: Wed, 6 May 2026 07:34:55 +0000
Message-ID:
 <DBBPR04MB75007E458BA3BB1787F81D8B883F2@DBBPR04MB7500.eurprd04.prod.outlook.com>
References: <20260430024945.3413973-1-wei.fang@nxp.com>
 <20260430024945.3413973-10-wei.fang@nxp.com>
In-Reply-To: <20260430024945.3413973-10-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7500:EE_|PA3PR04MB11228:EE_
x-ms-office365-filtering-correlation-id: 6e4ebbb1-5c34-4f44-9768-08deab41f7d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|19092799006|1800799024|366016|921020|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 U8U8kvZY5rPeGMfZ27Oed6+j+KjS/dTveFGpXB96ssUJhDR0S5kCMuqHtnNduNSxkv6ZgsIJPw5YPu0femrFbvKHMPjO/lAPliXucRGCWGnuR+rezZxkZnCI0qQRt1oMtDGeSkyr0OrF0IBb7Ow6KYObJSiHJ8p7x1RNkMZ2TGS5i5w1ehkzWt+bmZebpSmTxjSCE7yC7hKwNGdpBN7pFGURESh2DpDaOHSVpfVPB7ArtZHq4PRFJDPs+1JqBycxtbwiVsXrz46Nb7KWqcjMhclg5Cxkm9ACnGr39RO+H3fVtGGywlNZL9RjxeDpt3OZYlIhcG+x5xt0VICsqWDGOg2wMl1faEijUH6HkesYihEJOOni0anLNdGy2z9ef9LXgNBjAQfXSBwPhcXlx9rPmC9y963GxD7WuDkFAPCRLubGp23C9C30hOL7v1p05K787Itl4GBi6mVEmSv6mx8gTDRh8Uko3ddP/dRAQq2lBQEtKNx2544yXYBZ3MY5hwMjIkn8wkvP9kyUOkeQLV4UxzqCYvdajVOuYMjRCXRVoy2HTOoxgGGMaBoNDJrkGf5bWmalr1JuWvoUmGrzYYQb4aO8faf/i8Yt7Z4V7RyAkOlYw/1EPyNZfA+2W5aiWKcXuWXuba12PKDVxXbJaT+eJ+SNqoDF/+iqZBl0jhhT7GQ2u26GGOPDcvtT41uurnuC9j6ymOLkmrmloeeON86MY2DT78FqHK3SYYg72GNYlo5SHfrnQuyrReQUZD/N4tsRKWSaBEo9GdtbJhjiWIQeDA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(1800799024)(366016)(921020)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zJoJTFOygzc1IUOFLbqITpdKXbqOYxGCpQ0pVk6GdANhDhTa453t90xMWxO3?=
 =?us-ascii?Q?D8imLiMtKuNCpBmRCg1yEfjAsEkSIdMeGrAj1/2y5INWkTdELnrjPxKenT37?=
 =?us-ascii?Q?flYf1EkgU7x/pdh9xQu63oU4iWPYEQ+l8nCfD97u0nmde4HI4ff5CIOJ6cMc?=
 =?us-ascii?Q?jrHTixgvvEXqeycLt88vbS0pgFXl7wsEC5Pm6nJ7EgBITCQIHiLli5rl/JoX?=
 =?us-ascii?Q?MovfAy5/bg5lhM+20iNgIstCey7nCArWvf4nSooWLVs9Gn3dztdvsMtHg+nf?=
 =?us-ascii?Q?v1Ecl8I3lnHHeY5psHENjgY+trSmD9u8HpF2/dWGWYpLTchH30CH2TzaEfnv?=
 =?us-ascii?Q?YIMPluAo1CvcwbyGfczkQ+qFeg1rXV0yDutj70Pfbwm1Or5zRh0ctvnY6XyG?=
 =?us-ascii?Q?mGW5e+KmP/N0DKHzlXY3qNZIqtWCQmjq2c9G2jrQHpJQkru6Z4taKJZkdfUB?=
 =?us-ascii?Q?4pqVXxxAhFCbJ4nsQ+XTifF3sLQ3P2WaerBOY2T/xzFEO9ZcQaTuW9SogATa?=
 =?us-ascii?Q?7DX+w2Ipentxm2OjwO/rdMwWhj3gOlrIpNJ6iMQw+zvjjLSVxCiGzBF92+me?=
 =?us-ascii?Q?lzTovHqqSHq0NY8Jgz1CTNuW4+QuBKT8ATGkGWd1V4rUxO3bwdBptZPwxxlF?=
 =?us-ascii?Q?de5P1WAMALxsEf2XJfGZnnNIjrQZxfrh9HSvSiPJuWg3S1ykFyDwwLx6aWLl?=
 =?us-ascii?Q?4XwDqFIBqVEAqKUOraBsMohwlR+Mi2EpPg/yfERmgTfF0zzCz8N+8t0P2dja?=
 =?us-ascii?Q?n5zu5b99ZRnUIhX+2S0Tj4nAXRwJWbsH6M3hfhyy847YULNbLjXjLn5vWZI2?=
 =?us-ascii?Q?DIAHNTeD2AT/jes7NK/QjKyJvPiYg6177dHMPEeEV2XCIqx204nRVRU1JPAt?=
 =?us-ascii?Q?44gSBSOnO3CXajbwdpKeAnW1/2lutCtG5EIuDig2Hz8KoNKXr36LrJQzKwI5?=
 =?us-ascii?Q?1h9MNUfCmjhMdgaIzt4AJbAlMM7hJWHWY87RYnlkDS3y9o+US8gIUNa54ONC?=
 =?us-ascii?Q?Qva5nTP8V8B9ezXrP+eOtfF+0hC8odV5539XquGMMwzjaF9vhVuyBrfgeex/?=
 =?us-ascii?Q?ndasrYDgNfikZoq5O7+8Kh4WTpDj+f1rHj9ykG/R0EbJ4ducpC7llsv5Reza?=
 =?us-ascii?Q?jIZtMCA/sT/s3VTSn2sLxQcsBrAhECcHqjToqFcNOAAdEx0RC9ZXu1DMbqTw?=
 =?us-ascii?Q?A40hysJEZeUoHrC1F2h5idDvtTARBgpR6hMQIQ53O/C4hFVGRuWz+98cUYw2?=
 =?us-ascii?Q?JbJXwt+zw+r3bXmkIq9IVPZXyAGGLOZseuWI+UqnkkeVjvnfBwQMvMyfoIQn?=
 =?us-ascii?Q?BTFgcnVlMeXFx7DTu/N9O2m7AhwQ8DTznVL2RqXv3H8LNV36jAGrKXjni/Cq?=
 =?us-ascii?Q?WX8afhkD1t+ZLLUtF0eGd6McyAP+S3OkKSA/gu5M8wL0UN6dx4e0iKgC5FY0?=
 =?us-ascii?Q?gxIN0AHALk/YJeoHdYEyNNwnj7YNSRf/1CZ+ckoCfn8sbdMZXyKWg1PBXUuZ?=
 =?us-ascii?Q?zE+0vXilTcOefTHw4H11QTo6pYhoUxdz/aG0Sd2NTlVcGiFus4o/fflikBU2?=
 =?us-ascii?Q?xvkPLAJdlSSt749SdvVdZlX3M3Y7wcj3qOIhxWBqPK7vAgdW2tp+4yrG9941?=
 =?us-ascii?Q?iFaNcpBEGgiDK6wCgpEr/0HYP1kRKCZ0RTKOWYd0ukyBwwf5s98ZZ4RJ20DQ?=
 =?us-ascii?Q?tqlCsF5644WQBLpJpKyTFxj31UF1hUjSfhJvlJvriHmGoaDa?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4ebbb1-5c34-4f44-9768-08deab41f7d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 07:34:55.2519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mKTR3uHNu9pGSc5TY7T51VftRDEH3Aa5PH+UOnPge7vdHu15v1ZUhq1K9HfFVLf8qoxg7cOi73ahgj02E0rkEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11228

> +static void netc_flow_dissect(const struct sk_buff *skb, __be16 *proto,
> +			      int *offset)
> +{
> +	struct netc_tag_cmn *tag_cmn =3D (struct netc_tag_cmn *)(skb->data - 2)=
;
> +	int tag_len =3D netc_get_rx_tag_len(tag_cmn->type);
> +
> +	*offset =3D tag_len;
> +	*proto =3D ((__be16 *)skb->data)[(tag_len / 2) - 1];

Below is the comment from Sashiko.

Can this direct access to skb->data cause an out-of-bounds read?

When __skb_flow_dissect() invokes ops->flow_dissect() on a packet injected =
by
a local user with a small linear area (where skb_headlen(skb) < tag_len),
these accesses might read past skb->tail into uninitialized memory or unmap=
ped
pages.

Since pskb_may_pull() cannot be used on a const struct sk_buff, does this
dissector need to use skb_header_pointer() to safely extract the fields?

This is a false positive, or at least it can be ignored. The RX minimum fra=
me
length of each NETC switch port is set to 64 bytes. The frame will be recei=
ved
by the ENETC driver. From the hardware perspective, each RX BD receive
buffer is at least 128 bytes, so the skb's linear buffer will definitely co=
ntain
the switch tag.


