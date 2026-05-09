Return-Path: <linuxppc-dev+bounces-20642-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E5A9CD37B5
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2026 10:29:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gCMfV2sFNz2xf8;
	Sat, 09 May 2026 20:29:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778322546;
	cv=pass; b=hBAamtpr4OBP8p2UJxQuCE6aNhyqL4m+hdYsBGqD7JLeS0jLf9Nw3vUICDd8a8s4yJ/EqIBg9Dl8rCdwWkNuGXcVSj4TyXfyppf46P3/4qFfZQhG7NgFEDuMKBtiRp1L5fgnGF2OBagalTOmvxhHAAvLB2FIcenDC8+NRJV+kpWSGKyq4UdiE2aG3GaZfS4OkljwffDRNhbAd0IB3hoOptUJzTrtYlqx3NMPfp4jIOlldM1GGgzcc12U3RujsO2G9+WGmPPjfqlvchRUDBvLiQgQfA4v4WgcedhiJca5mEWZdWqa31MzfwMxyu9b/T/gqVeWb+9yGus0oQ9ZLeY0qw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778322546; c=relaxed/relaxed;
	bh=MsscSCcgG93MkgDUcGw3lFg+ehZgNfmlvUHHEf4kN74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KUGuyBqCnL7MU/V8bQv3ww660BAHdwQ7CFcpMvO2ySyUZVcsmOq4qYCUnTSDUpg4lRzbkaC2gJKYmewyOi16GoobGx7eeaxbTIYGE5VK7eTeUQH7DPldicKlooGtWqut2PgZLGlK2MQGlyGxx/g4xGkqIoiy0LG8hJqQyTNFoMVVogKOvtnTkCpt6YkcPPF5YZVPNmIi9SDm4MLv4oZy91KW634aFV1eSNiu9uJEpNLMbhZSDTcG5hYnH53CVeh9KuHSypkOrW17ocp7AgyO9yeaBamSUA9AeAKPek0OTxzPCNM+ParLEA8gA/GPRJhbSM1UuFyymnO7QkVSZNmgFw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=kJY2+nV2; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=kJY2+nV2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gCMfT3CkCz2yC9
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 09 May 2026 20:29:05 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KrvrfxWPtdFTMqmB+PI2q8cfmMlhDD4oDcjo2y0T6bYbvhRt0CqdCAo81BZFIN2zUJoqR9M6ZF9L7hGW00lMlJfumQC+ysNytXGgWdPTWSLfULqU5yXjJp31YFSZq2FJlmlUcalDlYiKpVeRI1iocuziE16Zb5d2nS2h6+v2wTbw/fIrICpQg2goKo/gQ22MRHqDdGPqoE1ajQj5OknNqi8OTDu4hKNibw25pubPWQ6RSFu3L0+kqw73mvxMBdxOVTbB098fhCRycw+zF3C2oVi+suVy0cHUgaXYb+8d8EBpieSbb/IYgvCGN2Ms7GP66SgDTpTe+toEIkTbmEt21Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MsscSCcgG93MkgDUcGw3lFg+ehZgNfmlvUHHEf4kN74=;
 b=JDj8o3xay420D2QRLz8d60iNOyMjmmyTeswuZzQ8NPym2t3Cm9cIG+9AQm54RneFmzQYtdUK97X5TyKXK8fBX0wA8MSmBoCIS1/VmLcEB9TZSDYF91/t6IIX6M24lyNnNzwyfhyvKZwqQjzEI02qgdJSOTDIgUaBEcwjjQoUxoF0kcVrKIpDsHfsrLwcR+bw1JXXrxmhAU6DYTLINBmufTvdy96Q4HZjza3I6xSOQ2KVFTrFgoS7+zw4hVDUIXDEssV0duhXCRKU64NxmjU4bHOUXoLk5quHh4f3BanV6KZng2h9jNYH35WvjOVBFk4bzC2ohtDQukIdVVVJY9CdZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsscSCcgG93MkgDUcGw3lFg+ehZgNfmlvUHHEf4kN74=;
 b=kJY2+nV2PKDfrKHOW5yJdgo7PoRLyTa5XZMKCIuwdnsaVvIgrFZ2yYauhy3F1qwfL0bNyFct+dy2f4+Inuwj4ls8AzMEDqVhKEksQLFOa90DDgdrqtEV2S6bQKwjFOAXelq4HORMhLFFM1p1uA+5kwFHsvKr3eK+FWe+EHTBouBhHDD24jfT3lYFqgUDXUnb3u9oUOJoiUGAsXp6pwL3T2+kPtqGQstD4TkeGPjGNSuXUVuM3zy48bOhlMa7/FADN5XVX70nSq2PCX6A2vb2CwkuTZyx4qvJZ4pLNzofq9wIoR+tS9KXZU9OskmUOfXVeux56p6jQ9k00EztCsLV0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by DU4PR04MB10385.eurprd04.prod.outlook.com (2603:10a6:10:56d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sat, 9 May
 2026 10:28:43 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 10:28:43 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	f.fainelli@gmail.com,
	frank.li@nxp.com,
	chleroy@kernel.org,
	horms@kernel.org,
	linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	andrew@lunn.ch,
	olteanv@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v6 net-next 09/15] net: dsa: add NETC switch tag support
Date: Sat,  9 May 2026 18:29:48 +0800
Message-Id: <20260509102954.4116624-10-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260509102954.4116624-1-wei.fang@nxp.com>
References: <20260509102954.4116624-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|DU4PR04MB10385:EE_
X-MS-Office365-Filtering-Correlation-Id: ec61630f-435c-4b66-90ce-08deadb5beb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|19092799006|18002099003|22082099003|921020|38350700014|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	8vcvzvjb2l7M2u5EzZI7N3N0vetNuOIqn9ev4alSmQT0O1+53vG6WgE+bbpXXcm6aVlxht3pHoOyiuNInGQBdazDkG6GMYE0NlHGqG5SgTK79kH1XBDzSJNqQeffigiUc887QJ0DSn901tfc+naQFmsNwEgZeA8FjqIP7ehO7vskeO70PqhclmAC1XSrXA7d9Hk5yZXDKqG05sqC3uS7ni4fooIQHTj1910JYIJcDEaV/uw/Y9kG+tHLKQ2OZpxF/SOmjyyZ7ebH/oleVuBjX+2eng/bDYLx+h1L5pKuprrJ2DSgTH52JqS9fvwXgbxYEgBQEK6eH4aCkIYgPcLz49iC+dLOg2juHjHTpabl0ij/63hvkBpZRe9pAE5ePXHCO3Uu3lCboAxWyWprUc0UeG3gOeyR9pWHdrgl0QYJYNZd2VcxNQUhpzC0CfKDQoBhnFzk9Lbg7iiaFpISVMpwSMOjvaGk2Iy2E+Y3ga//ZFL5c4/hXWt7UfGB1DpzrdYQr/Zs6m7rasAAnK3vgUbDl3N1aMEWk/sv3JrjFNuj1hyqZsUWKATSYYM2CvlueUzGRTWgEniJ18YIzQ5rfAkpFF73+RgEuluSs0gFvwoW4awav3ei6IbVC3QH6eSZfrPwsPtrXxjwmuE/lruHB6SoTJK8/T95wg/p0AgW8Pr/GLY7o/D4WD/Sa2bxYE5zESrlIQIQ9dF/87wAJQucEcY4+nYrQmR6n7bzfGRWkWqLUUtmb0kM/eVTqLs1FjCmJnO/4mWekSzMKCY/dwOBw/YG6w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(19092799006)(18002099003)(22082099003)(921020)(38350700014)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ieYlWOo5kkiEhitLbdRMOlOHPFGuQnz0RgDT3lJmz9DC6Ai3Ewc3m+zuqwBK?=
 =?us-ascii?Q?locAYaxZz5lrSehs/YESgVGoS8rq1pPhDb2deAroVgg/oxVfZOAJtG6Ngnw9?=
 =?us-ascii?Q?rJAxxv1iaweu9kvQXJjEq7vrzkh/zUJjNpavPFVYygx0o5idfjCqau5jw/u8?=
 =?us-ascii?Q?o8QMiCeBKeN0uF6sQKltdoRWQeb3a0YHDhfHfxvGtpL+5mS28iU+z+GmlIgh?=
 =?us-ascii?Q?yE/OXEPTesaqE+e7XJmP2qlst29X6LbdKmLTLx1rAzdVZoXRNNn124vJedIT?=
 =?us-ascii?Q?KRBNoBsLlrj71Kolne+Y2Ob5gtAotgLLGgmakb5wnw7wNZ2GUKDQjadoCVpw?=
 =?us-ascii?Q?C4E714ah435eJDp7GzZKjswVR4Evq4IarSDY2e/OYpRbRBCUWpa5G9MRwmkW?=
 =?us-ascii?Q?a2nNVFfHs1dV/kc58uH6k8H9+tkgP1ENK67uSUPRb1bzkhaXSTqHlHpChzk/?=
 =?us-ascii?Q?5tmRp48q/MydklJomdxIOvCvZUQID2uhxD6sz3Ta2yC3XGt0SV15LkRmM0eB?=
 =?us-ascii?Q?1NlIyN/qY38Or1IOaVsJjyS2f6w98tyNpPqFS7iAQK7379WYZojHYc+VLNmi?=
 =?us-ascii?Q?ffYtWnAClLidhqylkRYaYjONq9A9R1LDI6d7cikJ4mtjETYCOprK+kQLn/eO?=
 =?us-ascii?Q?FymtQS4sP3oHI89SiOebGGwZBUf6E67OhBRwfdpk9RKvyohIl14wrLQhZYIt?=
 =?us-ascii?Q?uFs7R7FbB3W9mxmkZGInlQOIFqfil7atW7CzC52h4vmtH/oU0IVbt3rysi6n?=
 =?us-ascii?Q?Aq4EwOTdi7AJWajObz6hEsW7Rhp3XTSfDu3INOnpAECRtbjOO+BJUmQv1vlI?=
 =?us-ascii?Q?CogCJORdIUQD4IeEBn7uz4jiHbfbujisWCK8ifQ8dLiKP+T5jCJSCQZCQQIf?=
 =?us-ascii?Q?d8cELhKBeJFd0baZWdsOTNC8nUCpSrb4pDz9W29tGoMHBTGgkTrWHPaMnS1Q?=
 =?us-ascii?Q?KF6mvtF3SEl8JIWdIGqArr3Od+VbPmLbHZotf3+t9PI0QZ6dnWA8c8oTpdnG?=
 =?us-ascii?Q?duQ8bP2VYwmLOj3Gift12vmvhoWb+BCx/zEDb9cL8UNfc/7SWgFdHboeIxHj?=
 =?us-ascii?Q?aBjTZwISCYN0EF9N5rH8n+og3U8ICc14n5qDm855o+oqqZIccGAlKCBE+UFk?=
 =?us-ascii?Q?bibDHdJjILHv1Trnlb90l85rvRxslcABNqKo0CjTmLSgdJ9XH1dLBd4FMnjo?=
 =?us-ascii?Q?OfTlz0HYkWqNuIswDBG+lTEP6OBfh3/B8l039lEpjM0PpmjMne9MSpIJpcD6?=
 =?us-ascii?Q?t0eFfxnpmIclqFy5IIoEychbE2/UTNMZicYcgTB0M53TJZtHwKDuJRPm1Dfh?=
 =?us-ascii?Q?XL3qZ0VHLBGRTs+w8J5AgoiW2pVHuNU5sz/rvLSJbsDKCqVhSEqjLtgog5yo?=
 =?us-ascii?Q?xX4+/KYb9ttWT/nsrntfr5xB5PQKM2jVAvvTS8NaDy/qn/UgOeicLj1UAeoh?=
 =?us-ascii?Q?deYSljgQL6eNTkrEVnS8WYUp/Ue02jVH7W2PumzglqLk+SUO2g7+wDdCeQ14?=
 =?us-ascii?Q?N10LDskTnIgRIZ7yaDIcjyo+xNGCNvgvHr5V3ZuitTZcK8dVTbs9MmnZMw0E?=
 =?us-ascii?Q?Kx3nn2AQUCmNk9jSOcS0tIS0BiyfIpVqZJ9jKHFY65JNcgZe4uQafqMYZU2c?=
 =?us-ascii?Q?Ee0MWZBQJNJAe3TiMfGQbYxzgl9ujE1XNEGJH+p7OFQrQ50Tahe8qopKzVMY?=
 =?us-ascii?Q?J97+81vl+IEcaYILtzwhyCHXxc5xxk9ymOMbgFzOAskvHCFU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec61630f-435c-4b66-90ce-08deadb5beb9
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 10:28:43.6345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ylPbBm1e+mF/oxZ52drLrCOu4yYgedMkAMAzT0nlbyXgYsi6j1i0B3yozRXv6M9psRSXeeGt+Dx4IVl4MLSh9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10385

The NXP NETC switch tag is a proprietary header added to frames after the
source MAC address. The switch tag has 3 types, and each type has 1 ~ 4
subtypes, the details are as follows.

Forward NXP switch tag (Type=0): Represents forwarded frames.
  - SubType = 0 - Normal frame processing.

To_Port NXP switch tag (Type=1): Represents frames that are to be sent
to a specific switch port.
  - SubType = 0. No request to perform timestamping.
  - SubType = 1. Request to perform one-step timestamping.
  - SubType = 2. Request to perform two-step timestamping.
  - SubType = 3. Request to perform both one-step timestamping and
    two-step timestamping.

To_Host NXP switch tag (Type=2): Represents frames redirected or copied
to the switch management port.
  - SubType = 0. Received frames redirected or copied to the switch
    management port.
  - SubType = 1. Received frames redirected or copied to the switch
    management port with captured timestamp at the switch port where
    the frame was received.
  - SubType = 2. Transmit timestamp response (two-step timestamping).

In addition, the length of different type switch tag is different, the
minimum length is 6 bytes, the maximum length is 14 bytes. Currently,
Forward tag, SubType 0 of To_Port tag and Subtype 0 of To_Host tag are
supported. More tags will be supported in the future.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 include/linux/dsa/tag_netc.h  |  14 +++
 include/net/dsa.h             |   2 +
 include/uapi/linux/if_ether.h |   1 +
 net/dsa/Kconfig               |  10 ++
 net/dsa/Makefile              |   1 +
 net/dsa/tag_netc.c            | 193 ++++++++++++++++++++++++++++++++++
 6 files changed, 221 insertions(+)
 create mode 100644 include/linux/dsa/tag_netc.h
 create mode 100644 net/dsa/tag_netc.c

diff --git a/include/linux/dsa/tag_netc.h b/include/linux/dsa/tag_netc.h
new file mode 100644
index 000000000000..fe964722e5b0
--- /dev/null
+++ b/include/linux/dsa/tag_netc.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2025-2026 NXP
+ */
+
+#ifndef __NET_DSA_TAG_NETC_H
+#define __NET_DSA_TAG_NETC_H
+
+#include <linux/skbuff.h>
+#include <net/dsa.h>
+
+#define NETC_TAG_MAX_LEN			14
+
+#endif
diff --git a/include/net/dsa.h b/include/net/dsa.h
index 4cc67469cf2e..8c16ef23cc10 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -58,6 +58,7 @@ struct tc_action;
 #define DSA_TAG_PROTO_YT921X_VALUE		30
 #define DSA_TAG_PROTO_MXL_GSW1XX_VALUE		31
 #define DSA_TAG_PROTO_MXL862_VALUE		32
+#define DSA_TAG_PROTO_NETC_VALUE		33
 
 enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
@@ -93,6 +94,7 @@ enum dsa_tag_protocol {
 	DSA_TAG_PROTO_YT921X		= DSA_TAG_PROTO_YT921X_VALUE,
 	DSA_TAG_PROTO_MXL_GSW1XX	= DSA_TAG_PROTO_MXL_GSW1XX_VALUE,
 	DSA_TAG_PROTO_MXL862		= DSA_TAG_PROTO_MXL862_VALUE,
+	DSA_TAG_PROTO_NETC		= DSA_TAG_PROTO_NETC_VALUE,
 };
 
 struct dsa_switch;
diff --git a/include/uapi/linux/if_ether.h b/include/uapi/linux/if_ether.h
index df9d44a11540..fb5efc8e06cc 100644
--- a/include/uapi/linux/if_ether.h
+++ b/include/uapi/linux/if_ether.h
@@ -123,6 +123,7 @@
 #define ETH_P_DSA_A5PSW	0xE001		/* A5PSW Tag Value [ NOT AN OFFICIALLY REGISTERED ID ] */
 #define ETH_P_IFE	0xED3E		/* ForCES inter-FE LFB type */
 #define ETH_P_AF_IUCV   0xFBFB		/* IBM af_iucv [ NOT AN OFFICIALLY REGISTERED ID ] */
+#define ETH_P_NXP_NETC  0xFD3A		/* NXP NETC DSA [ NOT AN OFFICIALLY REGISTERED ID ] */
 
 #define ETH_P_802_3_MIN	0x0600		/* If the value in the ethernet type is more than this value
 					 * then the frame is Ethernet II. Else it is 802.3 */
diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index 5ed8c704636d..d5e725b90d78 100644
--- a/net/dsa/Kconfig
+++ b/net/dsa/Kconfig
@@ -125,6 +125,16 @@ config NET_DSA_TAG_KSZ
 	  Say Y if you want to enable support for tagging frames for the
 	  Microchip 8795/937x/9477/9893 families of switches.
 
+config NET_DSA_TAG_NETC
+	tristate "Tag driver for NXP NETC switches"
+	help
+	  Say Y or M if you want to enable support for the NXP Switch Tag (NST),
+	  as implemented by NXP NETC switches having version 4.3 or later. The
+	  switch tag is a proprietary header added to frames after the source
+	  MAC address, it has 3 types and each type has different subtypes, so
+	  its length depends on the type and subtype of the tag, the maximum
+	  length is 14 bytes.
+
 config NET_DSA_TAG_OCELOT
 	tristate "Tag driver for Ocelot family of switches, using NPI port"
 	select PACKING
diff --git a/net/dsa/Makefile b/net/dsa/Makefile
index bf7247759a64..b8c2667cd14a 100644
--- a/net/dsa/Makefile
+++ b/net/dsa/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_NET_DSA_TAG_LAN9303) += tag_lan9303.o
 obj-$(CONFIG_NET_DSA_TAG_MTK) += tag_mtk.o
 obj-$(CONFIG_NET_DSA_TAG_MXL_862XX) += tag_mxl862xx.o
 obj-$(CONFIG_NET_DSA_TAG_MXL_GSW1XX) += tag_mxl-gsw1xx.o
+obj-$(CONFIG_NET_DSA_TAG_NETC) += tag_netc.o
 obj-$(CONFIG_NET_DSA_TAG_NONE) += tag_none.o
 obj-$(CONFIG_NET_DSA_TAG_OCELOT) += tag_ocelot.o
 obj-$(CONFIG_NET_DSA_TAG_OCELOT_8021Q) += tag_ocelot_8021q.o
diff --git a/net/dsa/tag_netc.c b/net/dsa/tag_netc.c
new file mode 100644
index 000000000000..b29aa54b1988
--- /dev/null
+++ b/net/dsa/tag_netc.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2025-2026 NXP
+ */
+
+#include <linux/dsa/tag_netc.h>
+
+#include "tag.h"
+
+#define NETC_NAME			"nxp_netc"
+
+/* Forward NXP switch tag */
+#define NETC_TAG_FORWARD		0
+
+/* To_Port NXP switch tag */
+#define NETC_TAG_TO_PORT		1
+/* SubType0: No request to perform timestamping */
+#define NETC_TAG_TP_SUBTYPE0		0
+
+/* To_Host NXP switch tag */
+#define NETC_TAG_TO_HOST		2
+/* SubType0: frames redirected or copied to CPU port */
+#define NETC_TAG_TH_SUBTYPE0		0
+/* SubType1: frames redirected or copied to CPU port with timestamp */
+#define NETC_TAG_TH_SUBTYPE1		1
+/* SubType2: Transmit timestamp response (two-step timestamping) */
+#define NETC_TAG_TH_SUBTYPE2		2
+
+/* NETC switch tag lengths */
+#define NETC_TAG_FORWARD_LEN		6
+#define NETC_TAG_TP_SUBTYPE0_LEN	6
+#define NETC_TAG_TH_SUBTYPE0_LEN	6
+#define NETC_TAG_TH_SUBTYPE1_LEN	14
+#define NETC_TAG_TH_SUBTYPE2_LEN	14
+#define NETC_TAG_CMN_LEN		5
+
+#define NETC_TAG_SUBTYPE		GENMASK(3, 0)
+#define NETC_TAG_TYPE			GENMASK(7, 4)
+#define NETC_TAG_QV			BIT(0)
+#define NETC_TAG_IPV			GENMASK(4, 2)
+#define NETC_TAG_SWITCH			GENMASK(2, 0)
+#define NETC_TAG_PORT			GENMASK(7, 3)
+
+struct netc_tag_cmn {
+	__be16 tpid;
+	u8 type;
+	u8 qos;
+	u8 switch_port;
+} __packed;
+
+static void netc_fill_common_tag(struct netc_tag_cmn *tag, u8 type,
+				 u8 subtype, u8 sw_id, u8 port, u8 ipv)
+{
+	tag->tpid = htons(ETH_P_NXP_NETC);
+	tag->type = FIELD_PREP(NETC_TAG_TYPE, type) |
+		    FIELD_PREP(NETC_TAG_SUBTYPE, subtype);
+	tag->qos = NETC_TAG_QV | FIELD_PREP(NETC_TAG_IPV, ipv);
+	tag->switch_port = FIELD_PREP(NETC_TAG_SWITCH, sw_id) |
+			   FIELD_PREP(NETC_TAG_PORT, port);
+}
+
+static void *netc_fill_common_tp_tag(struct sk_buff *skb,
+				     struct net_device *ndev,
+				     u8 subtype, int tag_len)
+{
+	struct dsa_port *dp = dsa_user_to_port(ndev);
+	u16 queue = skb_get_queue_mapping(skb);
+	s8 ipv = netdev_txq_to_tc(ndev, queue);
+	void *tag;
+
+	if (unlikely(ipv < 0))
+		ipv = 0;
+
+	skb_push(skb, tag_len);
+	dsa_alloc_etype_header(skb, tag_len);
+
+	tag = dsa_etype_header_pos_tx(skb);
+	memset(tag + NETC_TAG_CMN_LEN, 0, tag_len - NETC_TAG_CMN_LEN);
+	/* As 'dsa,member' is a required property for NETC switch, the
+	 * member is used to specify the switch ID (thus the hardware
+	 * switch ID and the software switch ID are consistent), which
+	 * is a non-zero value, so dp->ds->index will not 0 here.
+	 */
+	netc_fill_common_tag(tag, NETC_TAG_TO_PORT, subtype,
+			     dp->ds->index, dp->index, ipv);
+
+	return tag;
+}
+
+static void netc_fill_tp_tag_subtype0(struct sk_buff *skb,
+				      struct net_device *ndev)
+{
+	netc_fill_common_tp_tag(skb, ndev, NETC_TAG_TP_SUBTYPE0,
+				NETC_TAG_TP_SUBTYPE0_LEN);
+}
+
+/* Currently only support To_Port tag, subtype 0 */
+static struct sk_buff *netc_xmit(struct sk_buff *skb,
+				 struct net_device *ndev)
+{
+	netc_fill_tp_tag_subtype0(skb, ndev);
+
+	return skb;
+}
+
+static int netc_get_rx_tag_len(int rx_type)
+{
+	int type = FIELD_GET(NETC_TAG_TYPE, rx_type);
+
+	if (type == NETC_TAG_TO_HOST) {
+		u8 subtype = rx_type & NETC_TAG_SUBTYPE;
+
+		if (subtype == NETC_TAG_TH_SUBTYPE1)
+			return NETC_TAG_TH_SUBTYPE1_LEN;
+		else if (subtype == NETC_TAG_TH_SUBTYPE2)
+			return NETC_TAG_TH_SUBTYPE2_LEN;
+		else
+			return NETC_TAG_TH_SUBTYPE0_LEN;
+	}
+
+	return NETC_TAG_FORWARD_LEN;
+}
+
+static struct sk_buff *netc_rcv(struct sk_buff *skb,
+				struct net_device *ndev)
+{
+	struct netc_tag_cmn *tag_cmn;
+	int tag_len, sw_id, port;
+
+	if (unlikely(!pskb_may_pull(skb, NETC_TAG_MAX_LEN)))
+		return NULL;
+
+	tag_cmn = dsa_etype_header_pos_rx(skb);
+	tag_len = netc_get_rx_tag_len(tag_cmn->type);
+
+	if (ntohs(tag_cmn->tpid) != ETH_P_NXP_NETC) {
+		dev_warn_ratelimited(&ndev->dev, "Unknown TPID 0x%04x\n",
+				     ntohs(tag_cmn->tpid));
+
+		return NULL;
+	}
+
+	if (tag_cmn->qos & NETC_TAG_QV)
+		skb->priority = FIELD_GET(NETC_TAG_IPV, tag_cmn->qos);
+
+	sw_id = FIELD_GET(NETC_TAG_SWITCH, tag_cmn->switch_port);
+	/* ENETC VEPA switch ID (0) is not supported yet */
+	if (!sw_id) {
+		dev_warn_ratelimited(&ndev->dev,
+				     "VEPA switch ID is not supported yet\n");
+
+		return NULL;
+	}
+
+	port = FIELD_GET(NETC_TAG_PORT, tag_cmn->switch_port);
+	skb->dev = dsa_conduit_find_user(ndev, sw_id, port);
+	if (!skb->dev)
+		return NULL;
+
+	if (FIELD_GET(NETC_TAG_TYPE, tag_cmn->type) == NETC_TAG_FORWARD)
+		dsa_default_offload_fwd_mark(skb);
+
+	/* Remove Switch tag from the frame */
+	skb_pull_rcsum(skb, tag_len);
+	dsa_strip_etype_header(skb, tag_len);
+
+	return skb;
+}
+
+static void netc_flow_dissect(const struct sk_buff *skb, __be16 *proto,
+			      int *offset)
+{
+	struct netc_tag_cmn *tag_cmn = (struct netc_tag_cmn *)(skb->data - 2);
+	int tag_len = netc_get_rx_tag_len(tag_cmn->type);
+
+	*offset = tag_len;
+	*proto = ((__be16 *)skb->data)[(tag_len / 2) - 1];
+}
+
+static const struct dsa_device_ops netc_netdev_ops = {
+	.name			= NETC_NAME,
+	.proto			= DSA_TAG_PROTO_NETC,
+	.xmit			= netc_xmit,
+	.rcv			= netc_rcv,
+	.needed_headroom	= NETC_TAG_MAX_LEN,
+	.flow_dissect		= netc_flow_dissect,
+};
+
+MODULE_DESCRIPTION("DSA tag driver for NXP NETC switch family");
+MODULE_LICENSE("GPL");
+
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_NETC, NETC_NAME);
+module_dsa_tag_driver(netc_netdev_ops);
-- 
2.34.1


