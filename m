Return-Path: <linuxppc-dev+bounces-21083-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0407CCD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 08:23:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJrRS6ltTz2yRG;
	Mon, 18 May 2026 18:23:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779092612;
	cv=pass; b=Bw+Y4F5pd9pbuJ/HA1NSaAd67uew9kgs13sHcXTZpiOBwIG+9iPcKUkjMHXNwGVqD3b7UI2x6rWAhvaToDyRLyixFAAW0VD1/P7Ba3+hdkr6h7ij9x8mg/bms8g8aQQOE+Joq8B6v/ugIodIlulN5BgawSIKYH47I7mpMvsB22ZKZbF0eW5FIn5pGksS/XyyG03wsy7mvaVHfwnAYqkTx74Ubhm+zCFN9Cg50L2wA3NG4tkOf+nNSGe4fAIauAiaupf4txU4Eh9+DLPXZiAdEBksICVCc4Bpwxcdcr0XpjzBsBEZhztD2ZNKRlvKe8bDMsOkX4VdxfNKya/Xx5HCoA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779092612; c=relaxed/relaxed;
	bh=kSc8Q48CjHF7K1oPYUnmKGERCq0WRSdQS9aH8eNEY8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BJIf/8REHgOcVuPsL/zyM+zj8hUFrkxoYBZ1sGtdgrWZ/wQmrtBZxucmw367oAxoHQy7C62MNO7RAy5Yh4DpHgu4qkytmH2DK38fXvCPOZIYHPHaq5dYdnxyfyHYC8AYpp/NLP2OUjV86b6Fpjy290UOCqeqrmxVeZF6+ecUDIojHeZZRTOlq+Zj20m9lrofri1WxmE5VT7gG8wTVWxyd650lW0Q+SUREyQ/N9fteDIqNZskaDj8GcULc22XvZ9SG20auZpRBnROJ1YkOJsdSM/AJqGNQUx7qjOpWrzCdi7j3MlPftPeLAhVr9sjZLFeAxy+1L+GOnt9qmEhC3tr4g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=QAvT4hJF; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=QAvT4hJF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJrRR4f2Fz3bs2
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 18:23:31 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zHiVkCYD8uaMTuu43Z1B/Yv3sYtA0BldNr8mCSeng+IwRDmRF/hWMm7N0fRK7QBfyhgVxXlGod50AX2LBIpNRys13dDMpiox9JGoMt+4RDyu8YFAnNma6O/SUGnGw/s4Ny9BE9vkRXVA39ONb7sSb8FlOm61PCn1D7Q+TV8gyRszpWUUBowCo19mdVxvCJkroxzESfrKES9uPWncs/q7EPIK/Z8oXs0CdBqwU8F6Lx66+oCUpjWiH04UYkwcxDXCtjBxHcWwvqEs9wCU+Af+vn9pICgA1WI9X0IgFCCo0SSc22Xyh159OFZqtVFEqbNnUyjaQiBKZuFR+HsUa6iMIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSc8Q48CjHF7K1oPYUnmKGERCq0WRSdQS9aH8eNEY8A=;
 b=WFyBOrRhsDWe+dp6chWlvfZAe7RGcVgOOA7Thd6CeV/avqVE3LIT6U97d5nK3bcNzQk0UIKlNgaugcjOKX2VLTBZLXwVGzd/gJdNritQTHLwA9iqP9kJXbYgUKs2BMZaXI2Zx0PWaLcusM5LyfNf897pPXCRw/lTwUeovmK8XeMuvkRpGRjc25zUdGrbP1DXY8RE++9ka1lNdkhDQy61y+ORcKrE1R/LL0g37zcDUIaG3tpUGIBuAwBHmT5Wj0nWm2czOWHrO6w3d5ygWWkglZC0VXav4DIc+34FxfCiOJk6sPZMPT0Kdfjd/UQxft77QDTia8FcWs5MN7g7k5lwdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSc8Q48CjHF7K1oPYUnmKGERCq0WRSdQS9aH8eNEY8A=;
 b=QAvT4hJF6Wf7fGSoNLm1+XipuPdkcy1WstdbpZzbBtPpMy2oh+oCcQ9eV1zb+H0CDFC+ZQKABNRyuQVlzs4NxUPmchungk1FRl65dP70WNuBxQs7PVe6EsBuxdg0DOyujVcZflNsk8ifCPtQYVkUqKBXrR5GrqDhBQquf1A8MRF7nFIuuDmlQiWZS7pPA2ThXdRZq/KNBA4lSuLb1smEKmiitRSG/vbf6lD4OF8C606iF/2afbGCBs4y8S3BREvFXvYE2jdsAbpVIUDQ9ZKsmjH54k7dGQACmsaOQyUdfz7Q6KtOtfm07gz0RP5/v4W5+eDXo4WP4FdW2lwwTQDjxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by AM9PR04MB7713.eurprd04.prod.outlook.com (2603:10a6:20b:2d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 08:23:17 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 08:23:17 +0000
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
Subject: [PATCH v8 net-next 04/15] net: enetc: add basic operations to the FDB table
Date: Mon, 18 May 2026 16:24:55 +0800
Message-Id: <20260518082506.1318236-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518082506.1318236-1-wei.fang@nxp.com>
References: <20260518082506.1318236-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0005.APCP153.PROD.OUTLOOK.COM (2603:1096::15) To
 DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|AM9PR04MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: b10a20df-d145-404c-0493-08deb4b6b626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|19092799006|366016|38350700014|921020|18002099003|56012099003|22082099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info:
	JoW0dz25q4YO16kPSHzGD4S2uZaIJNM3fg+p5xqix9gCBeZ7ojxJCVHvuxNaFCbicnyUaFA4nBSt5e3ubo/a4okd7z5lByXv3jqDWTPiclnkV8rIC5TbOCST9Bl5Rc/LRg27X7aKou6Z6qODjTNV/GQTSVtNUqbKXIkjXQiJsr9jtgB4+QNyEDsyyxbGNkGCz7mcDJbKHbppULjhPPzy/PBzx9i5Y3oGKXfoakVH6xE4g3gmnblboE/6grYRPFcnAGD7eY2DLsXrqaP4EPu9+J8Ex51Q5xh9Nn8R5Jl5taaI49F/qO+N7EjstkLyjrAkkZGvp05mSsd61LQwCANI0KuWENxJubibhqoVXEpA3yy20Jb+ro2w4mvgbvrr2uF5Ocv5/e9/Geq41tJ4Ht5jL3l/d+j8L5UuLgpAr2upGnppI2UYeIMM7ETtOSlNr2zqR3bqBoJ2x73jVSkg1P3i2mSJlZM1aU8fFWK9lL82oLmh1DjmTaYAkUyHNWrZlqKmN6hGEccaGDIoyVwqSVet0ZLpqQW/V81ehxcoUR5TCyjbvehH/WNihozZzWD7tzn2XO/0G0heXRlR/VxERWMMmE3zhmjDnv1J+pVyBtVS9i8mdBXgnE4Fq927t/TVwNPeU/gmdfNk2hSgw5ycsjRroN3kGQXYlGegWeSIMUWNkZfLZ+eekdIdl8JM0irfHdZM58xQ+mvPsQ7Z1gckNvEGOalqZxoN60zMcgquwOF1zv1/XDI/i25J1u9vLRz1pSqfwjRDievWjuOPW9vRIHmzMA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(19092799006)(366016)(38350700014)(921020)(18002099003)(56012099003)(22082099003)(3023799003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2DnuN3gNlcbNiGNv4nmKs8rfxvoI6W7BKaUh62Gwvjtt8ilsbgZwb/4Ih+RY?=
 =?us-ascii?Q?KoNIIOkfI0FQUDW4B/C1wW1BOniDz3DsTEzMZEIpF8jJWyF5VFjiYwXPlHms?=
 =?us-ascii?Q?VWgxHQzvEDvLk9wOuqh7TvkBIzP3B6HXE32CWvJSB5N/bAo3XO8if96SMQo4?=
 =?us-ascii?Q?ER2xJtO/qGsb4CHqzrUbYiJNgFGpOTI39wfAU9TSdl4WLqRViuMhwizjiySy?=
 =?us-ascii?Q?XA8fYILbGE7ODbYg8U1rzXUVwxMVC0kk6PpV6rhH9ah+P2mgU9uA1Pw+cn9S?=
 =?us-ascii?Q?b3SRtsJu39nnnyzWTnm27jvUXO+1cn4fZNJ5rNbn6pgLXgMnRdHEwDs+/LJT?=
 =?us-ascii?Q?uBbY25+WMWNVFPRWb4l8q7tEDKsE+oi89RDecabYAupjtknxf/O1ALF8JSo1?=
 =?us-ascii?Q?O+dX6MWsSL1D6udc3q0JceJORy44dyH9eHfNjnjyQmz1mcuzWqvfyT1gJj/r?=
 =?us-ascii?Q?NzPx3ixVT6o4f33ygCj0fJAG6bRBx1xcED/LxlAZpySURiEm+m15C3oiUvgU?=
 =?us-ascii?Q?kWOG///SZpCEhSEIeuNhVJeYSniQDCfEZrJ34C74ClpQgNhnyXLbVS3oZwDM?=
 =?us-ascii?Q?KB23mxcZagxxWUgVSBCkqbNNyPLGoZElyqNEDChctQSMsQN7wiraO6MmhEvD?=
 =?us-ascii?Q?OqkGLRwszZqtdjxWq4OMUmoA5TQCmu2mFbxYcWjyCMKU62iS9/I9NWyjUbbC?=
 =?us-ascii?Q?pucKfJBZArqgnwvZveR7dov2SBsQMIFCT8hvtcbJLqXPBjY+wVSWhbCCJYmS?=
 =?us-ascii?Q?f7RSj1Y5scZpun+Rp/8KKIFib+KGaY3ecRrY4IJFX2E7bJp+tXoXMAbOmAmx?=
 =?us-ascii?Q?Ipe54BrD+OBRV6LMvadAVXIA4oarXsbalQFSUATYCR7sZuMnRMHQjHh4KMeW?=
 =?us-ascii?Q?a8kftQty4tPLB0x0W3ppRRWkljr8NhpWqy2tH+BDc3YAB/KyaNQFwz7nggki?=
 =?us-ascii?Q?i4PP3596ndnr0B/gKoqrbwhkw1oQdeXy9TQY9EihEB4aECXzMGcinjgRQaja?=
 =?us-ascii?Q?jb7gbwCk12ZL+y6cGH8WcgErDK2NykfuRls8dUtnFJW8UdThdQfkAYYhv0v/?=
 =?us-ascii?Q?Z+86vyHyWcXGzXmP/Dv8GwYbbWeeg/fqg3PdPg9pI+20c7dwS8vm4ARnV1zF?=
 =?us-ascii?Q?HPV3HhlBj7Zx+1tn5OAuB7bBb281iIFyJyB1JCP/9ORMPTwS+MFOrKsDngL5?=
 =?us-ascii?Q?H1g/pkYzLQNo/+5d1L7wos459BHgQKy3gqKumXKN6cWd5/ovJIB8ZsywXZQs?=
 =?us-ascii?Q?xRJFHQiVYY2bDVqJOw3SGbEOJxA3Kw5/DF8z6mNmimG0lsP6ohb6DozgAXi5?=
 =?us-ascii?Q?LGA6oHCY0kh27ODaPKenN4LsvI0aAo4hwXOxmAQ4DvxVh7uOyv1w5ei7NopV?=
 =?us-ascii?Q?ekVhKnVGk+JPKW61DOfq8sJC3VBqtTU194p8pbftSAiWYCWd1uwmgnoALrEh?=
 =?us-ascii?Q?YGU8AIaQEUbn2ZPENYfFXwWXN5yD1uf5KHAjGQ3K1eHRWk9tQZhgoFkWwOnD?=
 =?us-ascii?Q?Q2ovXO9IHRefHCi08i3flnm0BDfWRdVrkGuM/4Nnx4hjoIVoFBKz0MSEUb1k?=
 =?us-ascii?Q?ZmNyalPJUk+vNzMWefCNJIydK4qaIgfyI822DmO90i+cUnH6y8Oj5mMK940u?=
 =?us-ascii?Q?wMvYpTzZCH/3TFPUr5vuwRJxWlCfwoWpuKtH5vwkZzplXhxeozjAVmNEI9Va?=
 =?us-ascii?Q?Bmx3/EnCdd0IQjgm+Q5A3LDNf6cG8YgVc4gvcRpqInjl0XVf960rdUxYmD+X?=
 =?us-ascii?Q?z56vcCDABQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b10a20df-d145-404c-0493-08deb4b6b626
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 08:23:16.9262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: od6sj8mQlj71x637eSi9tQ+eL/qgChKwzWZYEdYNb3oI65CNrflAXxtJE3aTFinEzPJhHmMLMoJsImynLCWZ+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7713

The FDB table is used for MAC learning lookups and MAC forwarding lookups.
Each table entry includes information such as a FID and MAC address that
may be unicast or multicast and a forwarding destination field containing
a port bitmap identifying the associated port(s) with the MAC address.
FDB table entries can be static or dynamic. Static entries are added from
software whereby dynamic entries are added either by software or by the
hardware as MAC addresses are learned in the datapath.

The FDB table can only be managed by the command BD ring using table
management protocol version 2.0. Table management command operations Add,
Delete, Update and Query are supported. And the FDB table supports three
access methods: Entry ID, Exact Match Key Element and Search. This patch
adds the following basic supports to the FDB table.

ntmp_fdbt_update_entry() - update the configuration element data of a
specified FDB entry

ntmp_fdbt_delete_entry() - delete a specified FDB entry

ntmp_fdbt_add_entry() - add an entry into the FDB table

ntmp_fdbt_search_port_entry() - Search the FDB entry on the specified
port based on RESUME_ENTRY_ID.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 205 +++++++++++++++++-
 .../ethernet/freescale/enetc/ntmp_private.h   |  61 +++++-
 include/linux/fsl/ntmp.h                      |  44 +++-
 3 files changed, 307 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index c94a928622fd..6074eeafd5a2 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /*
  * NETC NTMP (NETC Table Management Protocol) 2.0 Library
- * Copyright 2025 NXP
+ * Copyright 2025-2026 NXP
  */
 
 #include <linux/dma-mapping.h>
@@ -21,11 +21,17 @@
 /* Define NTMP Table ID */
 #define NTMP_MAFT_ID			1
 #define NTMP_RSST_ID			3
+#define NTMP_FDBT_ID			15
 
 /* Generic Update Actions for most tables */
 #define NTMP_GEN_UA_CFGEU		BIT(0)
 #define NTMP_GEN_UA_STSEU		BIT(1)
 
+/* Query Action: 0: Full query. 1: Query entry ID, the fields after entry
+ * ID are not returned.
+ */
+#define NTMP_QA_ENTRY_ID		1
+
 #define NTMP_ENTRY_ID_SIZE		4
 #define RSST_ENTRY_NUM			64
 #define RSST_STSE_DATA_SIZE(n)		((n) * 8)
@@ -260,6 +266,8 @@ static const char *ntmp_table_name(int tbl_id)
 		return "MAC Address Filter Table";
 	case NTMP_RSST_ID:
 		return "RSS Table";
+	case NTMP_FDBT_ID:
+		return "FDB Table";
 	default:
 		return "Unknown Table";
 	}
@@ -496,5 +504,200 @@ int ntmp_rsst_query_entry(struct ntmp_user *user, u32 *table, int count)
 }
 EXPORT_SYMBOL_GPL(ntmp_rsst_query_entry);
 
+/**
+ * ntmp_fdbt_add_entry - add an entry into the FDB table
+ * @user: target ntmp_user struct
+ * @entry_id: returned value, the entry ID of the new added entry
+ * @keye: key element data
+ * @cfge: configuration element data
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_add_entry(struct ntmp_user *user, u32 *entry_id,
+			const struct fdbt_keye_data *keye,
+			const struct fdbt_cfge_data *cfge)
+{
+	struct fdbt_resp_query *resp;
+	struct fdbt_req_ua *req;
+	struct netc_swcbd swcbd;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	swcbd.size = sizeof(*req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.fdbt_ver, NTMP_QA_ENTRY_ID,
+		      NTMP_GEN_UA_CFGEU);
+	req->ak.exact.keye = *keye;
+	req->cfge = *cfge;
+
+	len = NTMP_LEN(swcbd.size, sizeof(*resp));
+	/* The entry ID is allotted by hardware, so we need to perform
+	 * a query action after the add action to get the entry ID from
+	 * hardware.
+	 */
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_AQ, NTMP_AM_EXACT_KEY);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err) {
+		dev_err(user->dev, "Failed to add %s entry, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), ERR_PTR(err));
+		goto unlock_cbdr;
+	}
+
+	if (entry_id) {
+		resp = (struct fdbt_resp_query *)req;
+		*entry_id = le32_to_cpu(resp->entry_id);
+	}
+
+unlock_cbdr:
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_add_entry);
+
+/**
+ * ntmp_fdbt_update_entry - update the configuration element data of the
+ * specified FDB entry
+ * @user: target ntmp_user struct
+ * @entry_id: the specified entry ID of the FDB table
+ * @cfge: configuration element data
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_update_entry(struct ntmp_user *user, u32 entry_id,
+			   const struct fdbt_cfge_data *cfge)
+{
+	struct fdbt_req_ua *req;
+	struct netc_swcbd swcbd;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	swcbd.size = sizeof(*req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.fdbt_ver, 0, NTMP_GEN_UA_CFGEU);
+	req->ak.eid.entry_id = cpu_to_le32(entry_id);
+	req->cfge = *cfge;
+
+	/* Request header */
+	len = NTMP_LEN(swcbd.size, NTMP_STATUS_RESP_LEN);
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_UPDATE, NTMP_AM_ENTRY_ID);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err)
+		dev_err(user->dev, "Failed to update %s entry, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), ERR_PTR(err));
+
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_update_entry);
+
+/**
+ * ntmp_fdbt_delete_entry - delete the specified FDB entry
+ * @user: target ntmp_user struct
+ * @entry_id: the specified ID of the FDB entry
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_delete_entry(struct ntmp_user *user, u32 entry_id)
+{
+	u32 req_len = sizeof(struct fdbt_req_qd);
+
+	return ntmp_delete_entry_by_id(user, NTMP_FDBT_ID,
+				       user->tbl.fdbt_ver,
+				       entry_id, req_len,
+				       NTMP_STATUS_RESP_LEN);
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_delete_entry);
+
+/**
+ * ntmp_fdbt_search_port_entry - Search the FDB entry on the specified
+ * port based on RESUME_ENTRY_ID
+ * @user: target ntmp_user struct
+ * @port: the specified switch port ID
+ * @resume_entry_id: it is both an input and an output. As an input, it
+ * represents the FDB entry ID to be searched. If it is a NULL entry ID,
+ * it indicates that the first FDB entry for that port is being searched.
+ * As an output, it represents the next FDB entry ID to be searched.
+ * @entry: returned value, the response data of the searched FDB entry
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
+				u32 *resume_entry_id,
+				struct fdbt_entry_data *entry)
+{
+	struct fdbt_resp_query *resp;
+	struct fdbt_req_qd *req;
+	struct netc_swcbd swcbd;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	swcbd.size = sizeof(*req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.fdbt_ver, 0, 0);
+	req->ak.search.resume_eid = cpu_to_le32(*resume_entry_id);
+	req->ak.search.cfge.port_bitmap = cpu_to_le32(BIT(port));
+	/* Match CFGE_DATA[PORT_BITMAP] field */
+	req->ak.search.cfge_mc = FDBT_CFGE_MC_PORT_BITMAP;
+
+	/* Request header */
+	len = NTMP_LEN(swcbd.size, sizeof(*resp));
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_QUERY, NTMP_AM_SEARCH);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err) {
+		dev_err(user->dev,
+			"Failed to search %s entry on port %d, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), port, ERR_PTR(err));
+		goto unlock_cbdr;
+	}
+
+	if (!cbd.resp_hdr.num_matched) {
+		entry->entry_id = NTMP_NULL_ENTRY_ID;
+		*resume_entry_id = NTMP_NULL_ENTRY_ID;
+		goto unlock_cbdr;
+	}
+
+	resp = (struct fdbt_resp_query *)req;
+	*resume_entry_id = le32_to_cpu(resp->status);
+	entry->entry_id = le32_to_cpu(resp->entry_id);
+	entry->keye = resp->keye;
+	entry->cfge = resp->cfge;
+	entry->acte = resp->acte;
+
+unlock_cbdr:
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_search_port_entry);
+
 MODULE_DESCRIPTION("NXP NETC Library");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index f8dff3ba2c28..b0b5805ac4f6 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
 /*
  * NTMP table request and response data buffer formats
- * Copyright 2025 NXP
+ * Copyright 2025-2026 NXP
  */
 
 #ifndef __NTMP_PRIVATE_H
@@ -11,6 +11,7 @@
 #include <linux/fsl/ntmp.h>
 
 #define NTMP_EID_REQ_LEN	8
+#define NTMP_STATUS_RESP_LEN	4
 #define NETC_CBDR_BD_NUM	256
 #define NETC_CBDRCIR_INDEX	GENMASK(9, 0)
 #define NETC_CBDRCIR_SBE	BIT(31)
@@ -30,6 +31,7 @@ union netc_cbd {
 #define NTMP_CMD_QUERY		BIT(2)
 #define NTMP_CMD_ADD		BIT(3)
 #define NTMP_CMD_QU		(NTMP_CMD_QUERY | NTMP_CMD_UPDATE)
+#define NTMP_CMD_AQ		(NTMP_CMD_ADD | NTMP_CMD_QUERY)
 		u8 access_method;
 #define NTMP_ACCESS_METHOD	GENMASK(7, 4)
 #define NTMP_AM_ENTRY_ID	0
@@ -97,4 +99,61 @@ struct rsst_req_update {
 	u8 groups[];
 };
 
+/* Access Key Format of FDB Table */
+struct fdbt_ak_eid {
+	__le32 entry_id;
+	__le32 resv[7];
+};
+
+struct fdbt_ak_exact {
+	struct fdbt_keye_data keye;
+	__le32 resv[5];
+};
+
+struct fdbt_ak_search {
+	__le32 resume_eid;
+	struct fdbt_keye_data keye;
+	struct fdbt_cfge_data cfge;
+	u8 acte;
+	u8 keye_mc;
+#define FDBT_KEYE_MAC		GENMASK(1, 0)
+	u8 cfge_mc;
+#define FDBT_CFGE_MC		GENMASK(2, 0)
+#define FDBT_CFGE_MC_ANY		0
+#define FDBT_CFGE_MC_DYNAMIC		1
+#define FDBT_CFGE_MC_PORT_BITMAP	2
+#define FDBT_CFGE_MC_DYNAMIC_AND_PORT_BITMAP	3
+	u8 acte_mc;
+#define FDBT_ACTE_MC		BIT(0)
+};
+
+union fdbt_access_key {
+	struct fdbt_ak_eid eid;
+	struct fdbt_ak_exact exact;
+	struct fdbt_ak_search search;
+};
+
+/* FDB Table Request Data Buffer Format of Update and Add actions */
+struct fdbt_req_ua {
+	struct ntmp_cmn_req_data crd;
+	union fdbt_access_key ak;
+	struct fdbt_cfge_data cfge;
+};
+
+/* FDB Table Request Data Buffer Format of Query and Delete actions */
+struct fdbt_req_qd {
+	struct ntmp_cmn_req_data crd;
+	union fdbt_access_key ak;
+};
+
+/* FDB Table Response Data Buffer Format of Query action */
+struct fdbt_resp_query {
+	__le32 status;
+	__le32 entry_id;
+	struct fdbt_keye_data keye;
+	struct fdbt_cfge_data cfge;
+	u8 acte;
+	u8 resv[3];
+};
+
 #endif
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index 83a449b4d6ec..4cfff835954e 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -1,11 +1,13 @@
 /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/* Copyright 2025 NXP */
+/* Copyright 2025-2026 NXP */
 #ifndef __NETC_NTMP_H
 #define __NETC_NTMP_H
 
 #include <linux/bitops.h>
 #include <linux/if_ether.h>
 
+#define NTMP_NULL_ENTRY_ID		0xffffffffU
+
 struct maft_keye_data {
 	u8 mac_addr[ETH_ALEN];
 	__le16 resv;
@@ -29,6 +31,7 @@ struct netc_cbdr_regs {
 struct netc_tbl_vers {
 	u8 maft_ver;
 	u8 rsst_ver;
+	u8 fdbt_ver;
 };
 
 struct netc_swcbd {
@@ -68,6 +71,36 @@ struct maft_entry_data {
 	struct maft_cfge_data cfge;
 };
 
+struct fdbt_keye_data {
+	u8 mac_addr[ETH_ALEN]; /* big-endian */
+	__le16 resv0;
+	__le16 fid;
+#define FDBT_FID		GENMASK(11, 0)
+	__le16 resv1;
+};
+
+struct fdbt_cfge_data {
+	__le32 port_bitmap;
+#define FDBT_PORT_BITMAP	GENMASK(23, 0)
+	__le32 cfg;
+#define FDBT_OETEID		GENMASK(1, 0)
+#define FDBT_EPORT		GENMASK(6, 2)
+#define FDBT_IMIRE		BIT(7)
+#define FDBT_CTD		GENMASK(10, 9)
+#define FDBT_DYNAMIC		BIT(11)
+#define FDBT_TIMECAPE		BIT(12)
+	__le32 et_eid;
+};
+
+struct fdbt_entry_data {
+	u32 entry_id;
+	struct fdbt_keye_data keye;
+	struct fdbt_cfge_data cfge;
+	u8 acte;
+#define FDBT_ACT_CNT		GENMASK(6, 0)
+#define FDBT_ACT_FLAG		BIT(7)
+};
+
 #if IS_ENABLED(CONFIG_NXP_NETC_LIB)
 int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 		   const struct netc_cbdr_regs *regs);
@@ -83,6 +116,15 @@ int ntmp_rsst_update_entry(struct ntmp_user *user, const u32 *table,
 			   int count);
 int ntmp_rsst_query_entry(struct ntmp_user *user,
 			  u32 *table, int count);
+int ntmp_fdbt_add_entry(struct ntmp_user *user, u32 *entry_id,
+			const struct fdbt_keye_data *keye,
+			const struct fdbt_cfge_data *cfge);
+int ntmp_fdbt_update_entry(struct ntmp_user *user, u32 entry_id,
+			   const struct fdbt_cfge_data *cfge);
+int ntmp_fdbt_delete_entry(struct ntmp_user *user, u32 entry_id);
+int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
+				u32 *resume_entry_id,
+				struct fdbt_entry_data *entry);
 #else
 static inline int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 				 const struct netc_cbdr_regs *regs)
-- 
2.34.1


