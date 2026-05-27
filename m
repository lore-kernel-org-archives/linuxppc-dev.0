Return-Path: <linuxppc-dev+bounces-21571-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA354CD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 12:12:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQT5P6ny8z2yjV;
	Wed, 27 May 2026 22:12:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779875994;
	cv=pass; b=UZUX2QpM3yoBWWR9rJBJcuThcKTpsCNbYmwmgE4w0xKXBIT7IMouMSFegL5DbtnU3tFOQPEz2fZfM4uj1DhQbHEoaaVD21p6+jEN8UP/SQmY0LVo5SnCQY5dz5J9WRr+woMTH3SYxd3UpiHulkD1Adx8JTiPuvVLd9lcFNhXaCbdonx7Adn5vi6kFFkcdBF/reD8onEbbAxsW5oyivWtMhVoVL+O1ia0fT6ipxt2levNxGJxsgxfU5zZfe9UudXhgXqLt1oIMSJHhicsegmRvWCCAhCW3YQHa+xuESF2dYFm/BKuVKKN8+g9B1W5LI8uP0tcCF3WRMmRqR33+zyOxA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779875994; c=relaxed/relaxed;
	bh=eM+zzK2Re7Lk1FfqfonwV3vc6lOH3hWbUDRAIArgDSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YU/DrEK7aId9BNuUZR9PdZBYr2d1FzwcqHEwVFJlfAN2UqDNrW/GfXc3J2t1Zl0zq5vfGLekY4sZiuYdGa7wqI+KjjiQ7f5WH9T+qbKvV1jPz3IDY8VWpXeeQTwK1oGP9+U11p842sirLEUHG7C7T8sFIaFrBssxHNeSkojtepjdZZao2iY2h/a95XeKUscf7zlrPmpXo2udXJq/fn2IOd1xZPhGnmxiBXtoBzPQ/nDVCsdBgKPXNjOAJ5gDlLzqfmBVRTHI7TxLeXQ7P05i/DtjdZb634J8N35aTawrJ+ifRprHhMZEdu9YgVOttNayEtt7+AG5jigQj8+7bBJL9A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=isMTe8pO; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=isMTe8pO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQQ8V00fQz2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 19:59:53 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yfBMuymNh1qnEGKpjbAlaZoQdjmEBqJFIZSo1iLurfYspJQ/z1PXEwi950jN8fkc7z7JhUdDDOlJqiV0C8+Vkj1zuyTcx96IV5nL1g48xN8/Zo7VeZ0DrGTFWfItfzlOGVEhBR3nNUKoDU63Ma6m3gEknD0C7jcY44dG4sSR1E/6OolxhMhu90AtEowWh8hTRjXdiGTvgII0wG3g8/TrVvRoiq49vV0diwKtC/Gr/ZRWWqf4wd6r+Clu+awB6TUEpO1uXcaIxlytNy8TPnyf5VGjc7ySf1+ts9+mqIpKKnXcys7YJtYAuY3b8BwQM1wjvdxtUKtFs2a7sB6oikgKlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eM+zzK2Re7Lk1FfqfonwV3vc6lOH3hWbUDRAIArgDSU=;
 b=uXpbWXafOcCZDaRLhbn5VrRytv4VLowsdBMs/YSCUp9FFK/c5kAh686jmAsd1bCTuYJ/p969pHwsObkKBbikDeYUVBYhN3qHjWaRI95gATAf2KXavt6OSWUe5WmFCrn8/ks3B0lDBpINfi7vp1uczOF/R1RTojmGTSXDkBhCtatFEBQy2r6dzuaGfN4wZtaWTK3kBfD7y1m6U5AbC7GIfv0XDzPMrtD3P1nOatHrve0+59UWG0yODJqq+Vl5uVc5VpmWA3sNXw9h/DdvQ58Xj6/ZHwyeL2JsG/pAnDyzw0UcHWBrPSLAyybQAi96oBRIz7ihC5O/QidkmXe8MmO/0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eM+zzK2Re7Lk1FfqfonwV3vc6lOH3hWbUDRAIArgDSU=;
 b=isMTe8pO2U6pyKPZD9cNBC3BdA5ilwOMKQK0zqhi14FgOqdg9HrkkFM1SRsToLcX7HkPXBNalSIQ5NZIu+tdSeqVHgRS+Y+6/8/fgcMhhSlpqSvAi8NZf9MG3nfZGVIAi3/0KyNnxaNNMUDAGFlW3t2zTDNFgFUvpawf1tXthiHNAVV2sEn4d6EEz0txSYDjEmM12FiRPIQ6hgbw/hSsWtX1MWMrXI2/eP3/KzDSWQ4YKHNmTQ7R26xF8OprYK7Zqg5wJIjsaaDo7g2Q9C9VQBqdFLWMOdZENk9yWBEUa/aaSUya5daueQY8c2vCf0zY/H5/S88wj3YtzpX2bPQ95A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AMBPR04MB12205.eurprd04.prod.outlook.com (2603:10a6:20b:758::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 09:59:34 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%6]) with mapi id 15.21.0048.019; Wed, 27 May 2026
 09:59:34 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	chleroy@kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 3/9] net: enetc: add interfaces to manage egress treatment table
Date: Wed, 27 May 2026 18:02:11 +0800
Message-Id: <20260527100217.794987-4-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527100217.794987-1-wei.fang@oss.nxp.com>
References: <20260527100217.794987-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AMBPR04MB12205:EE_
X-MS-Office365-Filtering-Correlation-Id: a9910e1e-ffac-4c98-9580-08debbd6a787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|19092799006|11063799006|56012099006|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	Lq3EfGnUbBfHWZgSTSLDNJHttvXadHXs+VEOOEZdAJ4DEsuLc4eU70RRdpsO4xd2B2drEgMalMwGPG650ve8+lqcmASEbKPyWdTL/6OSIYD5P7qJgiY3V+zjntYeD7GKuIM8azeqsuPvyTRgG+dQay/kUjWULZW1LS3WkEpaCt5CnBOpNkGGV1cw0VPt0RUU/5oDjoiW0v+03x/NXPYWoTPDhvU6aLzl2L8/Oddx3yeln4u0SrY1KnlJV6Ad3XHkzrL8VyrlnO7fXpCkVEQqXBoKMg1XZ0TsbShldi+zvqN2QxHwDDgyoKkow75v62UGGYjvnnDqDZWK52bUwMG6DBSfYprBP++PeOEBHCTP5nEzsbzlVVF16oZEhnG+4WaOoKQHm6p+IKomXN+akXxwMTPMyGfaWaEY1WmCm2MKSVwQi3sQ3fVIy+1MRSr+eNKRGYRIC5hTDiVufkXUaFGhkcvLX0OSvy5XEXDUVKB8cb+FpQpMm7OQIg0hTmfSYo/5yTR1b9ocFfHEmlf2dl2AXSK0nKF8bWDLoIy8w2lCaps4yAnhzGpvTLJCYZ2Il3moOHg1/M19QfX0XUFQ3wI9bSyvMGHutFZ+ndyyunEJ6ZWWOhU7RCFcJDWt6yPT0JKGX/TBM743kLp2YY9OCf0lDkQswmwXE7RvPVCImaU31aM+stUp8s8TzEmxy2lnkO57rdGGqbJGJX4vXLpf1zzS2m/Ww8bPPmdf+tGZK48ofH4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(19092799006)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XEn4ks7x5pY5FmOkxAlvIzZxdzEuemzvR8WPEIneCynFaJo/dWhLurlww/JA?=
 =?us-ascii?Q?NR0FAI1g4DzzDszMp+isamM4XexwEkMIzKEvYPGscySMGQuChd9O/5XaKBij?=
 =?us-ascii?Q?qEMTGMUwX07lhTgR3h4mgh+wIZMjJ6bSy5CUybV70+7GcL2AKu1MP+3P5T6G?=
 =?us-ascii?Q?5TOCJHDZLSnu0O+KK7TzcHgvFWgCBYdMrUiPZifpPg3fgmfsbpnTBvcrVVtU?=
 =?us-ascii?Q?dm/m7LkCe8bsfTrItFnOCwymqYXUoa1Vs+j2TzXZoY72i3zKK9gVK1q41Aki?=
 =?us-ascii?Q?D7/RZnEW0UhGKW+GlbnjIxCh01Xk46cEhOd1NyoQ+xmLUI3ZRX75VhE8t9dQ?=
 =?us-ascii?Q?82xXMpXZwRvqTXtyKFy+d9SGQ1gN2i5sOuGo1R5DyYpbgSBv7aTfjiLTPyWa?=
 =?us-ascii?Q?TLEywEKfM1VrHhvoCvpUTihsxeUg4C3RBKZ7wSkWkidobTXAHbx55l7zrBWa?=
 =?us-ascii?Q?cWPDfl5q3Ky2VXMjMKm/ArtplxVykx8tI6ADQyc0jVkinFyCKzehATuH7XZD?=
 =?us-ascii?Q?1euWIPRS/qM2v819hcx/vBVGZSqBPRlx6Co/2lHwxpqLKUg6GaNw7GHN4Ql0?=
 =?us-ascii?Q?iwTQnhs/guWReN3V07JwCX2KUPqGrDa8GVF+gMO2c+Ttst7r0MTMR3GKcCM2?=
 =?us-ascii?Q?sPR4M4W/iVayS+Av+Y9wQT5Wvp6XNnGX/UmK17/E79LGRZpccOXuyiIMnjON?=
 =?us-ascii?Q?Pv12XsKveFZGv4l1iEAp0oa8g0viWIqpNWi7XFeORfYn8L7uM0BpOqRUj1FY?=
 =?us-ascii?Q?SwQ/YQA2mEi8ou42cdE20mlFzLgXnFMT0OJ054pLSujg39zOF1QCQXWbF6ph?=
 =?us-ascii?Q?pX2DR2kCMLYaiAiqjabQ8EzYVVQtQjc22ap+2Jrafwdh6XfyS4gHt0B1bXT7?=
 =?us-ascii?Q?sUIbrdYs6YlmvVQGSANQGHYEY0zmzciovR6u9X9DgC5DIgg8rLmJWDfZ03YP?=
 =?us-ascii?Q?q33EZFPFIRao5MAV3W0DdhtoxYlqdxVLnnb0iK9wr9OeSHaK5ZqnLnR3Pwgv?=
 =?us-ascii?Q?o8hBec8Wk1WG0qVNary8g6ZwbV2AJADxHnnw9Hewuz8ne8wU2yRYYgy5na3h?=
 =?us-ascii?Q?l45TJ9Ef+6ahQx8+bVKIM4rpAkyn4GyD54ToYBdsPpvOcmXjOepCnIJO7X6K?=
 =?us-ascii?Q?W7S5wXh30OG5hFnLYBRvh9Tn3ipAvTNpyiEcgWNm8jK1+R3FxNxf5PMyOn2O?=
 =?us-ascii?Q?h9i8w4nxMPLUxMDCoV6OVEHGdj7z2i7lAUJLRPZxxlB4O8Yf5DOzdw2HliM1?=
 =?us-ascii?Q?XNWj0E/2tFcbjSZa6B2qEP6AREQ5akZHde2OIntV1c3X6mBzHFNeCQcitDnw?=
 =?us-ascii?Q?tE4+yPZiRkGtn5YQ2CJCE8OFu+2rR70fTKolzlKLY+07MlIKggy8ZRYzTJsB?=
 =?us-ascii?Q?T7M9PMsAYm9SH4iHnUH45nLXIylnxM6A0b1JSjhsrW+s+8ZK5OlvvVn7Cn1N?=
 =?us-ascii?Q?crF+KThYk4IgDeqJX4+4aWye0uYvJu+C8HxKsDOuFbi2jW8ukbrfzhJJFrMQ?=
 =?us-ascii?Q?QgQukCV5QOeaVgEoioVY+RbyYf1r2o8Yr4MVC0PGZYRtSSgaShgC0niA0tOS?=
 =?us-ascii?Q?r8nfnH/RJRI4Tr2ZeqF3ngSFqpq0jBa/QboSSMLoAf4KOfWMfxsx7zISvSLK?=
 =?us-ascii?Q?BfzkKy7jQVbetK2wfkjVc1IH4Um7VrQpJ3Xh5xhRwk4pLr1QL9D6tEoM07Nf?=
 =?us-ascii?Q?liqs/6v7S9JK0lDZ/FX/7VQTTSovxgSvFvVAqzKq7KIXHKCHbxXPieSNNZZd?=
 =?us-ascii?Q?HkU4hkfqirYwOasrTzA/HaAftvoHVL3Yr4b+tReiaOXoHHXafUSL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9910e1e-ffac-4c98-9580-08debbd6a787
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 09:59:34.2988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQTkafFJ/jSXA3H0szAvZMwdOtluRAYM9XxGtxqBiSeHmHw/MGtxIYjPXYC+JcolsuzaoTgoTKbcBEnGGCvxKhTiRCFbKwN00P626fLW6Ty9Qc9R7luLZZzXYIxSOjJZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12205

From: Wei Fang <wei.fang@nxp.com>

Each entry in the egress treatment table contains the egress packet
processing actions to be applied to a grouping or scope of packets
exiting on a particular egress port of the switch. A scope of packets,
for example, could be the packets exiting a particular VLAN, matching
a particular 802.1Q bridge forwarding entry or belonging to a stream
identified at ingress. The egress treatment table is implemented as a
linear array of entries accessed using an index (0,1, 2, ..., n) that
uniquely identifies an entry within the array.

The egress treatment table only supports access vid entry ID, which is
assigned by the software. It supports Add, Update, Delete and Query
operations. Note that only Query operation is not supported yet.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 65 +++++++++++++++++++
 .../ethernet/freescale/enetc/ntmp_private.h   |  8 +++
 include/linux/fsl/ntmp.h                      | 21 ++++++
 3 files changed, 94 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index 85abf9303bac..6f81f90af7b0 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -24,6 +24,7 @@
 #define NTMP_IPFT_ID			13
 #define NTMP_FDBT_ID			15
 #define NTMP_VFT_ID			18
+#define NTMP_ETT_ID			33
 #define NTMP_BPT_ID			41
 
 /* Generic Update Actions for most tables */
@@ -284,6 +285,8 @@ static const char *ntmp_table_name(int tbl_id)
 		return "FDB Table";
 	case NTMP_VFT_ID:
 		return "VLAN Filter Table";
+	case NTMP_ETT_ID:
+		return "Egress Treatment Table";
 	case NTMP_BPT_ID:
 		return "Buffer Pool Table";
 	default:
@@ -1137,6 +1140,68 @@ int ntmp_vft_delete_entry(struct ntmp_user *user, u16 vid)
 }
 EXPORT_SYMBOL_GPL(ntmp_vft_delete_entry);
 
+/**
+ * ntmp_ett_add_or_update_entry - add a new entry to the egress treatment
+ * table or update the configuration element data of the specified entry
+ * @user: target ntmp_user struct
+ * @entry_id: entry ID
+ * @add: true means add operation, false means update operation
+ * @cfge: configuration element data
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_ett_add_or_update_entry(struct ntmp_user *user, u32 entry_id,
+				 bool add, const struct ett_cfge_data *cfge)
+{
+	int cmd = add ? NTMP_CMD_ADD : NTMP_CMD_UPDATE;
+	struct netc_swcbd swcbd;
+	struct ett_req_ua *req;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	int err;
+
+	swcbd.size = sizeof(*req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd_eid(&req->rbe, user->tbl.ett_ver, 0,
+			  NTMP_GEN_UA_CFGEU, entry_id);
+	req->cfge = *cfge;
+
+	/* Request header */
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, NTMP_LEN(swcbd.size, 0),
+			      NTMP_ETT_ID, cmd, NTMP_AM_ENTRY_ID);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err)
+		dev_err(user->dev,
+			"Failed to %s %s entry 0x%x, err :%pe\n",
+			add ? "add" : "update", ntmp_table_name(NTMP_ETT_ID),
+			entry_id, ERR_PTR(err));
+
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_ett_add_or_update_entry);
+
+/**
+ * ntmp_ett_delete_entry - delete the specified egress treatment table entry
+ * @user: target ntmp_user struct
+ * @entry_id: entry ID
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_ett_delete_entry(struct ntmp_user *user, u32 entry_id)
+{
+	return ntmp_delete_entry_by_id(user, NTMP_ETT_ID, user->tbl.ett_ver,
+				       entry_id, NTMP_EID_REQ_LEN, 0);
+}
+EXPORT_SYMBOL_GPL(ntmp_ett_delete_entry);
+
 int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
 			  const struct bpt_cfge_data *cfge)
 {
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index ec2a1cdb0768..0309f98b297a 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -217,6 +217,14 @@ struct vft_req_qd {
 	union vft_access_key ak;
 };
 
+/* Egress Treatment Table Request Data Buffer Format of Update and Add
+ * actions
+ */
+struct ett_req_ua {
+	struct ntmp_req_by_eid rbe;
+	struct ett_cfge_data cfge;
+};
+
 /* Buffer Pool Table Request Data Buffer Format of Update action */
 struct bpt_req_update {
 	struct ntmp_req_by_eid rbe;
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index f34151cc160e..d433b2317123 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -36,6 +36,7 @@ struct netc_tbl_vers {
 	u8 vft_ver;
 	u8 bpt_ver;
 	u8 ipft_ver;
+	u8 ett_ver;
 };
 
 struct netc_swcbd {
@@ -214,6 +215,23 @@ struct vft_cfge_data {
 	__le32 et_eid;
 };
 
+struct ett_cfge_data {
+	__le16 efm_cfg;
+#define ETT_EFM_MODE		GENMASK(1, 0)
+#define ETT_ESQA		GENMASK(5, 4)
+#define ETT_ECA			GENMASK(8, 6)
+#define ETT_ECA_INC		1
+#define ETT_EFM_LEN_CHANGE	GENMASK(15, 9)
+#define ETT_FRM_LEN_DEL_VLAN	0x7c
+#define ETT_FRM_LEN_DEL_RTAG	0x7a
+#define ETT_FRM_LEN_DEL_VLAN_RTAG	0x76
+	__le16 efm_data_len;
+#define ETT_EFM_DATA_LEN	GENMASK(10, 0)
+	__le32 efm_eid;
+	__le32 ec_eid;
+	__le32 esqa_tgt_eid;
+};
+
 struct bpt_bpse_data {
 	__le32 amount_used;
 	__le32 amount_used_hwm;
@@ -273,6 +291,9 @@ int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
 int ntmp_vft_update_entry(struct ntmp_user *user, u16 vid,
 			  const struct vft_cfge_data *cfge);
 int ntmp_vft_delete_entry(struct ntmp_user *user, u16 vid);
+int ntmp_ett_add_or_update_entry(struct ntmp_user *user, u32 entry_id,
+				 bool add, const struct ett_cfge_data *cfge);
+int ntmp_ett_delete_entry(struct ntmp_user *user, u32 entry_id);
 int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
 			  const struct bpt_cfge_data *cfge);
 #else
-- 
2.34.1


