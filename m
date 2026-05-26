Return-Path: <linuxppc-dev+bounces-21510-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB10CD5BDF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 11:03:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPqck6JPcz2y8t;
	Tue, 26 May 2026 21:03:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip="2a01:111:f403:c200::1"
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779793430;
	cv=fail; b=QFzc9Mj6WRJaCGNiOypQBqkWZSZgUz3uqpUGGJ4+A2gR5v1jSN9iwHro54Otvp251SNue5mV3dxUTlsJROmOZTey3SRrx5jmOTotp0DoA8S0VU1evh/TPxx2KOa8J2ezuUgbmw4riYyQI/u0smTIc3s0PhyvHYSNfUjWEE79/KePgmwfgApFVxxiTXvRl1Zaa3gPPl1hNytejAsHr4L5VEKoGyHKP0rosMMvsnsL9XSeOciA3h3auDfKjSa46sz2/RBjoSZP6QQUg53VbPHVkHWMh76nYz5YQogne2Z1prXttwQ+fcOZEpD9e70d+vPuNbEDSDJ/cJaXYjt5Adkkqg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779793430; c=relaxed/relaxed;
	bh=vGESvY4H+Ut4KC/4km3NuRMwuQIwPJ2aKx8V6aaK1fQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QtbIkl+fMDZ7kZkA/6u4XM78PRroh//o1QWNVucexJ3ARIPqM5L71Pumd4oFcQagWsKEvIhjucuQA3h0Fc83WQDDfLxWzyLAfZ5+azAh8fsN1yy/wV7FXLp5YZHoDbNruDnPoLpzCDE8VJqzf7vgHeErOTMH7gr9YwyXSC1FE3FfHmIJv4Uc8QjWJDfU4Sq2ZxRsFw/57ik93sH8AxxRLpYGcjZ4TvV3qC4pjlrIvemB3A/P5kr6RmjRvnEwL+hangzYmtBYVuWstY3aoquHG2mki7lv/BKu4VSac0wqaXcfZIYVhSLtGia3IqJWms4V4MhjDceBMPJmWyZxhjzP5w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=cet1simn; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=cet1simn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPqcj0RMZz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 21:03:48 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpK35PKglT8IJri5N63yX02kT96M3Jxci9z3a6z3WWJv3u5adhqLXXDyFE+gzWpPkT0g8dALu5mwuk0/Kl9A9POMOeA9l/BwuLItFswkOvnUCqWI8IystUNO2msSGmBNaCQdCz+L1GIqFeUAgDqJ7SB8DJ7htwF2HZHLjv8ENCe7gObJtJv+xOl6AKypgNsuLFltOjH6foPdQEhMC3gqdgxJuVeki38H5kLUFUb9TBY71yPTcxUp5Crg0S7PKkq2cP33LAQhYao6IXkbqzKqtMe13+WnCiRyrm8QCXs5wfNYJe9YntcpG4RDEPEnaKvfomIQ9ZcpbGc+oKDWKU96Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGESvY4H+Ut4KC/4km3NuRMwuQIwPJ2aKx8V6aaK1fQ=;
 b=gck15Yy1UvaZw7mibVU9UPtZrCzxLEoSDj63l9VcX+Xn2eQZGWCH8VH2WyfxhIGfC6BCKKdh2mqHstCqXYDdjJ1eowoVh1DwOMVzON5PzEDkn0l7MQs853Yuq3s0QmK9L31Rpb0lzBmtxO6veA8ZNZXHITn5OPJAcRpRd6EbGfKGe5GmL0lWDFC5vPLUCSeJa3B2yItWmX+VHTgKe2v0sDZ6QCCrAS1tdWOyjD3J/BK6Yrwnx/ldhzUpOrJ+64mHV3t9Z9dFqPRNMpli6qr/GBGVTfCPIFl8EC2Y0E/9CI7yYxbMJs4+5dGW8MMV3g0pxI/Xef76YyWyPAEBlP08GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGESvY4H+Ut4KC/4km3NuRMwuQIwPJ2aKx8V6aaK1fQ=;
 b=cet1simnXISTFa+jilVK0ZEEhmdpMxi2/j4ok81n1Zkv6P5v5P9M6ImwuPNIUZQLagdhz/qx8oN6Zocz1aG6A+tnSDU3n8s1tiktdudXwT6UVnKyUt8VnnEaDZWZNhFHU/8Z9iFSZjXwQuMXH5n0yFAyQnbs5AoEp+Irdkx0lc1W9uw5R30MbQnBEjBupcZDtAO6mv8W6EDh2oSQebbwqbjjrMBOAySHicGpcj5OeSQ5P8Gg3n/oevVIjR+TDk8Sydq9WFwDLw/J87dj0Bi/7DdnpVetfkHKnN9rFRqKMWgFn5t32Kyah68aOtv0uPGP5Z8itz8mIvbm+MKYodQBig==
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by DB8PR04MB7194.eurprd04.prod.outlook.com (2603:10a6:10:127::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 11:03:24 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 11:03:24 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Arnd Bergmann <arnd@kernel.org>, Claudiu Manoil <claudiu.manoil@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, "Christophe Leroy (CS GROUP)"
	<chleroy@kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, Andrew Lunn <andrew@lunn.ch>, Vladimir
 Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] [net-next] net: dsa: netc: fix enetc dependencies
Thread-Topic: [PATCH] [net-next] net: dsa: netc: fix enetc dependencies
Thread-Index: AQHc7PpN5+QO0dxQGEmzQ8bYQ25kWbYgIojg
Date: Tue, 26 May 2026 11:03:24 +0000
Message-ID:
 <DBBPR04MB7500D92831D793CDD1D562E2880B2@DBBPR04MB7500.eurprd04.prod.outlook.com>
References: <20260526102708.2837129-1-arnd@kernel.org>
In-Reply-To: <20260526102708.2837129-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7500:EE_|DB8PR04MB7194:EE_
x-ms-office365-filtering-correlation-id: 47fa9dba-ff5f-4285-5a04-08debb16684a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|19092799006|56012099003|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 fF/UluNUQeUzcpSM7Y9303W1u7Md3H4fJhwv34L1C+DPDj6iE5Ka32zRCX6oNSh6QiOjU72w9oY3ELH+PW35rXAQHMPFZKJQxCiZwfv/fhgbSgAmi0QH7YOBDP6hSTyZHED6i/Rphsw6WXXeadrwqbrBuSx2LQaXs3YhXf4tvIXclJKHumGtVYMW7Zgnoq7qmMOJx3aoEH6Ts1xxV6eMmus3prdOJJskwhQWUXGMxfXbDrj/EZvAp0BZfVV/PHqUvlw5j0or5Bq7xnH1X2UNhsGA6drzsEa/XHg32U/VnqdAW/PPNSItqk84ASCmmxiic3Cfjinfe3Sm8pv16rsSwggHQ7pFWlSj207zJENJdwACnLxLxN5susdhXYInOidgtMV26Ih8SCFFmTh3WOjsnFAAgPAbeS3qshpi0unQYhIv7NPbWiFq4phzp6JscDWoz/ZiYbtUta1qvpgA1JLFE4V1wLn/BJoUiwIYlV1kybepHTvNRQWTdI65mUWGqz8a/o065yJ0TOXALDXkZudr0zas9Gf7g1+M+1eQwSpVP+G5LYm4dmCKlmbEqXQjXQ//l/aDpO+3ysU3B4EdDvVYvdkMA65+P4Vj8uFsl9W9uVK0iyYCNyRsx07qVKt6Fpb/pKvdwecYLxdQvS0AetonTZUZ67k3f6MBYBtP/rPxe5Qkdjr1KAJhv9kszsjCi4hepeeCEOcpLGItEyhluW53HQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(19092799006)(56012099003)(11063799006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+L0DLO15AQwMx/fkkpildy7lJdOU/LygYJn8GxB08o+JCrH8syAdCufj+IEH?=
 =?us-ascii?Q?ANcJwQyqzwAMIlDQPHVyN+b2CCixOTusZBnbO6Zhj0cukXvasPDt5mgO8GTe?=
 =?us-ascii?Q?6wi3NVCyK7vXFEeyXnKLBIZFwt12gHtVk8ZF1j1100jwQAR2N9zE6C2pjN+9?=
 =?us-ascii?Q?rnYoB6qAT8JcRE8phwccYN6ormkAhA5wqkbaoLUCMDu24M265cwckN3eHxAE?=
 =?us-ascii?Q?4Sa5TMf77hOS9LphHYMJ4MZ5LHv9VHsGl/1MYmAFPyscWAeyM/zPy8StpcdV?=
 =?us-ascii?Q?+GC89a0n7DWp27WkfbdaqVhYffQfoxHD/soGmIFFd1KavgliWU77u8k3HUR5?=
 =?us-ascii?Q?RDflijYCBHH4AClCF/u1ZVaSKRzIknreIiUjRdNAKw6ayFaMeJf9mPDiAKfv?=
 =?us-ascii?Q?HuTBxdDTnOKZENLW+D6A69lxb5UuUSyXX2gWedZBuL14KIEAWMkZFOZoB6hK?=
 =?us-ascii?Q?A/e4vMBbO4fbD1NriOuJOIHdgQjum1nuJvNZxv+FN0GkIC1xvv+iTh101aP7?=
 =?us-ascii?Q?jjvAeW/+qG+X0J/rSEoDu4m4xgwlz9sFKjI9AMy6aDV8Ut6lR+85JMjWikcq?=
 =?us-ascii?Q?5SFKYmM5zFW0IEYqelE5Dlute+3igdmo4hC3tFVIaRoBsadU8GxNJ3WzL2/i?=
 =?us-ascii?Q?u6NKNlgk8OI46Ubiip1sFzlNneuMRa/3jUHQLVNaPTsUIerWWCl6OOsdj+GX?=
 =?us-ascii?Q?ccHVYqHyviSSZzY57OGUgy2HmTPUfGxZ2potO4ukY1GZtFheTzk7ziWihcvc?=
 =?us-ascii?Q?ic9wdGAfyoQkykYJSu+58VY/s4mq2CXOqIbZVv/rU5dRzSAk0XLb7DK72SvY?=
 =?us-ascii?Q?CLS+0qfSVYtCGCwRjyjvBgB0E6xdk4ns8Plg6ERrc7TNE9DOHF5YJF3dhL5X?=
 =?us-ascii?Q?pl46kG39i75qu6kSrTkB90xWfpqmleh4rmxCYB88oaMBroYHY0bwgyiUq4Cc?=
 =?us-ascii?Q?PVnQlDuo5ymVw6C+riV+DVAdyfE5q1xYZDZxWHsvWScSuMUGzUVsJw/Xh80S?=
 =?us-ascii?Q?n41080SjhylbhS+xmoGBUos7tJbgQjHedEHiHkmv9y+LaF5wdCLi8AIKxA41?=
 =?us-ascii?Q?u/O4WE6++Gk91dCMHtalk89gkTg0rYRTABVZG4M1nBrLjiZ/mwKaDdZENj2u?=
 =?us-ascii?Q?jObrju/9T317b1+1AJ4/e69wp0r6w/UDua1k41Ft9/9EaHuVvnQZ94mKSMXy?=
 =?us-ascii?Q?imxq6piQ/dtZLtV4okGrk8387e9OBXXJIQsMWf9cUlyRPCFHVUZgcDVYcK/m?=
 =?us-ascii?Q?/Q2BncjubSXxH6DsXnVFlGiOXAx2h0dMETnaq98T2JbdP9oILI1luxynDp1a?=
 =?us-ascii?Q?wGojZ3bhuHJj9w5lNlOYPDYGtgj8HDdNdIFahHFwZkiHVUtaN/Y9OHTfoOAC?=
 =?us-ascii?Q?f8K/ViqvdXk7IPZ4+lnh+vbN3UY7wfm2IrsYmVVcwdg2KxIKacxaA/Ua+zi4?=
 =?us-ascii?Q?e4tOlTipk0zc1Fls8r/cwDguJmALrPCJNweLnQypbleQdHaA3kW5Fn9HbGVb?=
 =?us-ascii?Q?sYqdbEkrG6mWkiw7m2I/GFAKXTS9dIHF76AQSynhpp9SphTzN4PT9Rh5A2SD?=
 =?us-ascii?Q?HnXu+se0tYCdcsXxuHClX6P6StiU28RI/KEygng8QUj97/fHGcH/Kf+u6XHU?=
 =?us-ascii?Q?uhW2sZgZ4E0P9a9ActRaqObY4EdfZb7oA545kF7IxV7HeQtND+RSZPl5Nbvt?=
 =?us-ascii?Q?+UzW7iE5evDX4MiLMBCDOu1K9A7qrtpUvIF6gDCGBwbLubiT?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 47fa9dba-ff5f-4285-5a04-08debb16684a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 11:03:24.5949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ub3q1cb/1D6mkYxNeToKb9Us/m1VYNYRFQjWo00nYcWF8v3kqOMFjkH8z4DipYCa4++7p8wxlDkAFbfvmzDREA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7194

> Add the required 'NET_VENDOR_FREESCALE' dependency to make it possible
> to select both the PHY and NTMP library modules. Originally this was
> meant to be done through an 'IS_REACHABLE' check in the header file,
> but that did not work because the drivers/net/ethernet/freescale
> directory is not even entered in this case. IS_REACHABLE() is generally
> counterproductive because even when it works as intended, it turns
> a helpful link-time error into a silent runtime failure that is
> harder to debug. In this case, it clearly did not even do anything.
>=20

Hi Arnd,

Thanks for fix this issue, I have sent a patch last Sunday.
Link: https://lore.kernel.org/netdev/20260524070310.2429819-1-wei.fang@nxp.=
com/

I think the solution should simply be to add
"depends on NET_VENDOR_FREESCALE", right? The changes in
enetc_mdio.h seem more like improvements to me.


