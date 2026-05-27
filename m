Return-Path: <linuxppc-dev+bounces-21576-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56135CD4F54
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 12:14:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQT621DdVz2yYf;
	Wed, 27 May 2026 22:12:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779876025;
	cv=pass; b=S8ROfIGU+7PHoJCmsWv6AyFOaUTGJ3Tmh1PmMGXpTdR5D1zHq21NdJ97LO02A8zqQ/34NQSmTX86+iTd9WqHKH67iWY4wUJIHHteXhu9JW2HNESNws27aozsjkN/aHb92vBnLhr0yi79QJdwg1ukGEpAgPmplVa/C3KhsCmKP5/8p4sweCTC+cZNY7RFciBuV5KHIO3LL1e8WsUTuMyd7bd9kMsSKGp6iE5szFCfYgrcMcgHAsjzPdQlmewEbLP/aN9OUHjroRnUlRkGgRUn4P+lYXa1tJksnEh+BGI3YGarLnHTqj9KJzbNvt4+j9Fs5hS38bJl+GdQlg93IJfsGA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779876025; c=relaxed/relaxed;
	bh=KSyhNw58Xl+OZuSLQSpBdj1p2VjQm4tQfqPgFNNA55Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oKeYq64xXrQr5VYsJmfEVf4nYjRvSIfLsOUMcZVtpugrEocOdRUD9HKws7k6wcEUqLcFm3QCMeVt0cZ+Raf3nInr34DPtpDvrQNXMuaYcKjOj28A9FjR5bCobe1iAR7c7oSN22Qr+vqdTZgRHbmAZ+btV2gVdBdFmkqgB5LLdnE28iH7/Z0OXS+FXrUIZ2Li0tZZoEX6A7CJg1puRYh8bed2bUhhJY1q13H0z1yrL39oaD4RFx2hWRSxFsJ+HxlLjaNt45Wbi7efZP9aDXmk1crf98mum1HhbsFjcPGuBn9bIRARM/BYw4QBoBZBAMwlqIrqgbWOfrBwsiAD26Dlbw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=WyTWEDK8; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=WyTWEDK8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQQ950lvvz2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 20:00:25 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bmGOOKmV4/xXN9Wmnr+Amvt5Mm4sYoajhSpE075XRP44E8tYZCo58KmaGYQV4AtlEPZ+FJg95ZZ7JVt6QlENSkPPAjh6oEatDKf3gfmJJUXghXmyvfYJKnBPjtpQxUCZ2U9MHVy10XQhjM/6pIicVezf3ZMELBvHJ/aLZij2OBH6bAraDKtl/t+aUfiIF/uLnqAYeWrtWGAV5JpIHCZSqFF5jleSEpjr27WkpnC/YZTqKf4n5NiedVQ3eaW+eBT/tJCctEaCE6P6jA0LnypF2tsUFusQoD8i90AjMIQg6S/JlRXta+adf/PjeJaVLusbKHVC0NBkxqBU4l1rv8lV0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSyhNw58Xl+OZuSLQSpBdj1p2VjQm4tQfqPgFNNA55Q=;
 b=niUU+LL3C42FHERTxkECzZL+1xdDOTTt0pVzFQlvGZQQlzgF2kihRHFCUhSOxmUw0NzmPPbNezg7HLFUmcQ1+MyaDMA2TBHtjSfVDArPYcsltK1o9v/hx8AuJ9okl8nMNa1iiOwcKQ5cH40Pr8+B7F8RYsg9w9bdG+fFOSy5qnO6mK3TWtsZtoYfZ+7xEra76JnjWhzxmsiXgoNpRIRhsheBtRFI/8DIYzxlVb56ObfOdPtCQrm+zYC0QjtWao35Dutn6yQmcRreBSGqfLM7oI/CAHjNYJsEsW9OR1AMwyaWPMU0ENdA4NWPO2nygc2yZIzQbM3SfrTneK8Bmfzb9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSyhNw58Xl+OZuSLQSpBdj1p2VjQm4tQfqPgFNNA55Q=;
 b=WyTWEDK84ZNgR/SqXcnKuP47KkXz2zdKABeWLmapETaTQZdDOAwCPeBxl/0ysef1F/rQsS6KjRYd9sxCNiPVCNiIPj9D2/vAemOMuFzKOG2i5mri5uC6lowyB+hCaIvRk/hfeVITQRyFpzeEO/8f+eOK8NT+QXfv93JH/vXS9tpXzC7A1aKi2C2MKxKwYtpgmct6N85hCjRlKVVdfBq4OSViGFFfrZSzGW0cfMhM0P4UY+I060qwY/rOjg7OcuxEX9Z0AltskpsGPNs24uvYgN6CcTg78QHLOrAi5EEJVq++QATkHgw3Bu5fDsOuDQIcbGRS3LwjvvzBXCMO9KS7nQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AMBPR04MB12205.eurprd04.prod.outlook.com (2603:10a6:20b:758::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 10:00:06 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%6]) with mapi id 15.21.0048.019; Wed, 27 May 2026
 10:00:06 +0000
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
Subject: [PATCH net-next 8/9] net: dsa: netc: add bridge mode support
Date: Wed, 27 May 2026 18:02:16 +0800
Message-Id: <20260527100217.794987-9-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527100217.794987-1-wei.fang@oss.nxp.com>
References: <20260527100217.794987-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0076.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d8::10) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 82ac5181-2db8-4b19-4f22-08debbd6baa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|19092799006|11063799006|56012099006|6133799003|18002099003|22082099003|3023799007|921020;
X-Microsoft-Antispam-Message-Info:
	TpIHQ+VridiObk6qKpPqLG+ymsCJlRfKAMDSnfxfwC1DG19RNMcnpCBj0Kqpekvm2d3zK1a6ZaEYuAnJ4q1nZwUapH8O/fgFG/cNnxV3Oket/TfKHQISBQLWPP+UeRvGk3B0KRKqc76ts4A0mTk+jYDyB4STxTxatBvI7GdyTI7J9+bEFyBG66pfr2UR+rFmAwSKBDEmGHTmVAdG+X7h7VwnAAYOplQAsQV94UY8cescEZ27PMnAozanEOmfF7kgzI13FWh1TkIOr0JUc3URhbejzxt3keEmgs9hjHvKCv03mgLsjC8edAEKdrqsetKf8HurUBwa0k3UWvS/O1KQdOhj0UyhoH3q5F5dYLoH7WloWcZ2pTVNnBBXr0Vpk8C2M2WmdV3/beeHOKm4LKBPSj2HMNZwrCXiv6CAtcfFQeKvCKBYto9Yc79uFsACOszv2hTekOimo16oe+oVkVcjdHUFdBuWcq2/gNd0ylLjVY08LIym3Edp0BC58SKm4S/Gqgd4LGhNioujqs11y+5pUo2Bbz6BFEF6tg5EIJgpArBUc/eKMtUqTjh9548WeFLtLAKlHovW/Qhcz7DT29zvRF8Fa5qCmUTlkZrrO3XCxrBIScfKSmrFleMechKlljVIs4aQ6lPMS04U5aIq/m035fn97SALt7NaTV8JC59McFBSKGSiR6nifG3ybBtG8Lq9vOawWlsX3tY9ex72B5PlzQ5tDIj0J1bK3XJJeJEy7Pk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(19092799006)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(3023799007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TgUmROK9h8Yegvua1CDWRWumxpVQYdoVrSXjbqFGeySrHc/L6MJrQYr6RFWd?=
 =?us-ascii?Q?ii+DO5FbwJA9SU/v/A/2vGfm9h5xQ2QOUdSnH9oZO4iUZQTQNSsfNrN2J1xy?=
 =?us-ascii?Q?NyRS/Cl8xYQH7VF/gY3BBDGLUAD+FnYQvSe3yTShE3a8x5+EEaiI3f1AaErx?=
 =?us-ascii?Q?/a7aKxCe6cAYMs6bOI2l3OrtA55ZzpMHq4N4cmba10hysFz9fYkBuNpziGKc?=
 =?us-ascii?Q?skibJ786kc1REQVWwi6EQc8IdMRFdIoUP2NzPRo49WS8JcRcRqxI80dy7veq?=
 =?us-ascii?Q?EJAYDp2WzIK2J6YHeuAfoE52CGtPKGvMsQvrIT+Cdnpk5rU01bIyhlaf75zf?=
 =?us-ascii?Q?yMVgwtA/DeHX61OiDpEQbPNyQNxftfQ+pNdJHbqbx+mNi2to76DWb0hxblLR?=
 =?us-ascii?Q?gfAQGV3GyQ0jqwSizHxOVthUasH19zMRapmfrjKD6neKp67nt0IrqnqQ/Lah?=
 =?us-ascii?Q?a6myfw8iqYE5o8i40wu2r12L3TXKy2e51FcFEdpp1eDYxHQb2MRqq01skQQC?=
 =?us-ascii?Q?XuQxucwiFK3Rv6P0HJtZ0+GiibO/jyQXaRhPlE7o37LOj4Blo2JotlB7fFCX?=
 =?us-ascii?Q?su/scF5eEZLnCh3l8lKFHq+52xPzF5mRXbuC2T2m75gRf6jXtFw6jrwlZLj+?=
 =?us-ascii?Q?NmkIEUXR3X6vB2TW4S44h0X+dAT5w5A0USXMXiG0R2ykh2Mln93avU3zIoC5?=
 =?us-ascii?Q?s8DyKw3acJUx69KA3O7F3t0/peVynujuy5Oqd3VZYxb+ySzLChDdzO2s3q0q?=
 =?us-ascii?Q?3VnFekbKNRESJJyzKLHGoItqcYb+fhQ2mmwLUUx19iS0Wus4DNGjD8eIVnz/?=
 =?us-ascii?Q?t667qMhRquk3mBWpw45tFhe25Speco2lsAd3lWsWBG6MmdHr/5noRWDA9WXn?=
 =?us-ascii?Q?lFv3OkMeNlnusDHKk8Pa+KaZBmJbQp3pJqiAahUnb3yzDXUvtzvr9lzE7NWa?=
 =?us-ascii?Q?nWqQwUMTVQS2o4uT/KPXw1UDHidDDjt8H3BwvQyLL51tNZIp8VQwNKeE3J/U?=
 =?us-ascii?Q?uXkjHnzGZo/1fziMzJCoq9ulGDj5ff5FU7mX6/h69AaOVJSB5EXkzCdqr4m/?=
 =?us-ascii?Q?5/rn5WQoMagBF/L+jcB/B+eemisWBnM5xebUZTdCBDvnZ4UH8HK8+WxD9RSK?=
 =?us-ascii?Q?c5EUqPTan3H/C83Cuocd1mUKLcaOZZ3ke+7dYxUsQht7JuulRNZ6AYPjfcgE?=
 =?us-ascii?Q?JWwj8eKJxU+3fPVY0ivLIxfcCs85kyNIkbQnyWOy9usAqBLNbTKik4u7Khm7?=
 =?us-ascii?Q?4ma4W8mWlmcUKGbXptHrYb28lCzk5XCtZlDWibtGAzRy2vGYlV5hIK0nrQeZ?=
 =?us-ascii?Q?EHuhiQK19qgc6oOtFW4Z0P/GWm7QfYOuuABSJWTJBq/BKn0/oK5nt1in/qz7?=
 =?us-ascii?Q?ao/yVStpjULFwDU7L1hqNSvtV2Y8YqVVgD9YybP/EYgADEwzUs3vy+kuJd/G?=
 =?us-ascii?Q?fd14njUfu6c0qfAgtNdLVMybTaRjHEPSHe9crdPo/tJ+/Fdw5m9v7PuZgWNa?=
 =?us-ascii?Q?Qj/RhFpSq3IZv7BEdF+b5Ui3I6ruzPgpmUE52tlJaPikbbKmD5I1m5VFCZoj?=
 =?us-ascii?Q?b6J9boQCXeSfk3ryTb4bHACEGvS51ZryLy5UlR6GCtjYrW9WKf/y17tmLm2X?=
 =?us-ascii?Q?WJv6Jl+RjksWQxL8+Y+tkMGGeBQ2QPDVKCi2G3GmuShG09VOgF3JDr9kFzFR?=
 =?us-ascii?Q?r+f2fJTVGzm6djAKOxlvf6zy0ZIm2bKu8XWGBau8FW/joxsFI2O1VSnX5O4R?=
 =?us-ascii?Q?FAgQmzKNy9Bd0hCd90loYjHc0bQFRxJaMnw0gbtXodbVUo3keuWZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ac5181-2db8-4b19-4f22-08debbd6baa8
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 10:00:06.3956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wRdSLQ3JArvFvpQ+/sTwQB9dSRC47nbqbrzyUpPrCCLiqip7EonIyMHa/ZnxLYwilrKc+0BqUR/PkrWlgvnmEYTUo/tj3kZS9gk/bVG6Oyq884GnqROmzB9tcVcJ4RNR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12205

From: Wei Fang <wei.fang@nxp.com>

Wire up the port_bridge_join, port_bridge_leave and port_vlan_filtering
DSA callbacks to support both VLAN-unaware and VLAN-aware bridge modes.

For VLAN-unaware bridges, each bridge instance is assigned a dedicated
internal PVID via NETC_VLAN_UNAWARE_PVID(bridge.num), counting down
from VID 4095. A VFT entry is created for this PVID with hardware MAC
learning and flood-on-miss forwarding enabled. The CPU port is included
as a VFT member so frames can reach the host. The reserved VID range is
blocked in port_vlan_add to prevent user-space conflicts.

Only one VLAN-aware bridge is supported at a time; this constraint is
enforced in port_bridge_join and port_vlan_filtering. The per-port PVID
is tracked in software and written to the BPDVR register whenever VLAN
filtering is active.

FDB operations are extended to the bridge database: when vid is zero the
VLAN-unaware PVID for the bridge is substituted. Dynamic entries learned
autonomously by the hardware are handled by falling back to a
key-element-data delete via ntmp_fdbt_delete_entry_by_keye() when an
entry is absent from the software shadow list. Internal PVIDs are
translated back to VID 0 in port_fdb_dump before reporting to
user-space.

Host flood rules are removed from the ingress port filter table when a
port joins a bridge to avoid bypassing FDB lookup and MAC learning.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c   | 297 +++++++++++++++++++++++++++--
 drivers/net/dsa/netc/netc_switch.h |   2 +
 2 files changed, 282 insertions(+), 17 deletions(-)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index 4db42c888470..1fe3b43e0459 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -694,13 +694,18 @@ static int netc_port_del_fdb_entry(struct netc_port *np,
 	mutex_lock(&priv->fdbt_lock);
 
 	entry = netc_lookup_fdb_entry(priv, addr, vid);
-	if (unlikely(!entry))
-		/* Currently only single port mode is supported, MAC learning
-		 * is disabled, so there is no dynamically learned FDB entry.
-		 * We need to support deleting dynamically FDB entry when the
-		 * bridge mode is supported.
-		 */
+	/* If the entry is NULL, the specified FDB entry might be a dynamic
+	 * entry, so try to delete it through the key element data.
+	 */
+	if (!entry) {
+		struct fdbt_keye_data keye = {};
+
+		ether_addr_copy(keye.mac_addr, addr);
+		keye.fid = cpu_to_le16(vid);
+		err = ntmp_fdbt_delete_entry_by_keye(ntmp, &keye);
+
 		goto unlock_fdbt;
+	}
 
 	cfge = &entry->cfge;
 	if (unlikely(!(cfge->port_bitmap & cpu_to_le32(BIT(port)))))
@@ -1259,6 +1264,16 @@ static int netc_port_add_vlan_entry(struct netc_port *np, u16 vid,
 	entry->ect_gid = NTMP_NULL_ENTRY_ID;
 
 	bitmap_stg = BIT(index) | VFT_STG_ID(0);
+	/* If the VID is a VLAN-unaware PVID, the CPU port needs to be
+	 * a member of this VLAN.
+	 */
+	if (dsa_port_is_user(np->dp) &&
+	    vid >= NETC_VLAN_UNAWARE_PVID(priv->ds->max_num_bridges)) {
+		struct dsa_port *cpu_dp = np->dp->cpu_dp;
+
+		bitmap_stg |= BIT(cpu_dp->index);
+	}
+
 	cfg = FIELD_PREP(VFT_MLO, MLO_HW) |
 	      FIELD_PREP(VFT_MFO, MFO_NO_MATCH_FLOOD);
 
@@ -1296,11 +1311,16 @@ static int netc_port_add_vlan_entry(struct netc_port *np, u16 vid,
 	return err;
 }
 
-static bool netc_port_vlan_egress_rule_changed(struct netc_vlan_entry *entry,
+static bool netc_port_vlan_egress_rule_changed(struct netc_switch *priv,
+					       struct netc_vlan_entry *entry,
 					       int port, bool untagged)
 {
 	bool old_untagged = !!(entry->untagged_port_bitmap & BIT(port));
 
+	/* VLAN-unaware VIDs have no egress rules, so return 'false' */
+	if (entry->vid >= NETC_VLAN_UNAWARE_PVID(priv->ds->max_num_bridges))
+		return false;
+
 	return old_untagged != untagged;
 }
 
@@ -1323,7 +1343,8 @@ static int netc_port_set_vlan_entry(struct netc_port *np, u16 vid,
 	}
 
 	/* Check whether the egress VLAN rule is changed */
-	changed = netc_port_vlan_egress_rule_changed(entry, port, untagged);
+	changed = netc_port_vlan_egress_rule_changed(priv, entry, port,
+						     untagged);
 	if (changed) {
 		entry->untagged_port_bitmap ^= BIT(port);
 		err = netc_port_update_vlan_egress_rule(np, entry);
@@ -1387,6 +1408,17 @@ static int netc_port_del_vlan_entry(struct netc_port *np, u16 vid)
 	cfge = &entry->cfge;
 	vlan_port_bitmap = FIELD_GET(VFT_PORT_MEMBERSHIP,
 				     le32_to_cpu(cfge->bitmap_stg));
+	/* If the VID is a VLAN-unaware PVID, we need to clear the CPU
+	 * port bit of vlan_port_bitmap, so that the VLAN entry can be
+	 * deleted if no user ports use this VLAN.
+	 */
+	if (dsa_port_is_user(np->dp) &&
+	    vid >= NETC_VLAN_UNAWARE_PVID(priv->ds->max_num_bridges)) {
+		struct dsa_port *cpu_dp = np->dp->cpu_dp;
+
+		vlan_port_bitmap &= ~BIT(cpu_dp->index);
+	}
+
 	/* If the VLAN only belongs to the current port */
 	if (vlan_port_bitmap == BIT(port)) {
 		err = ntmp_vft_delete_entry(&priv->ntmp, vid);
@@ -1494,17 +1526,53 @@ static int netc_port_max_mtu(struct dsa_switch *ds, int port)
 	return NETC_MAX_FRAME_LEN - VLAN_ETH_HLEN - ETH_FCS_LEN;
 }
 
+static struct net_device *netc_classify_db(struct dsa_db db)
+{
+	switch (db.type) {
+	case DSA_DB_PORT:
+		return NULL;
+	case DSA_DB_BRIDGE:
+		return db.bridge.dev;
+	default:
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+}
+
+static u16 netc_vlan_unaware_pvid(struct dsa_switch *ds,
+				  const struct net_device *br_ndev)
+{
+	struct dsa_port *dp;
+	int br_num = -1;
+
+	if (!br_ndev)
+		return NETC_STANDALONE_PVID;
+
+	dsa_switch_for_each_available_port(dp, ds) {
+		if (dsa_port_bridge_dev_get(dp) == br_ndev) {
+			br_num = dp->bridge->num;
+			break;
+		}
+	}
+
+	/* The br_num is supposed to be 1 ~ ds->max_num_bridges */
+	if (WARN_ON(br_num <= 0))
+		return NETC_STANDALONE_PVID;
+
+	return NETC_VLAN_UNAWARE_PVID(br_num);
+}
+
 static int netc_port_fdb_add(struct dsa_switch *ds, int port,
 			     const unsigned char *addr, u16 vid,
 			     struct dsa_db db)
 {
+	struct net_device *br_ndev = netc_classify_db(db);
 	struct netc_port *np = NETC_PORT(ds, port);
 
-	/* Currently, only support standalone port mode, so only
-	 * NETC_STANDALONE_PVID (= 0) is supported here.
-	 */
-	if (vid != NETC_STANDALONE_PVID)
-		return -EOPNOTSUPP;
+	if (IS_ERR(br_ndev))
+		return PTR_ERR(br_ndev);
+
+	if (!vid)
+		vid = netc_vlan_unaware_pvid(ds, br_ndev);
 
 	return netc_port_set_fdb_entry(np, addr, vid);
 }
@@ -1513,10 +1581,14 @@ static int netc_port_fdb_del(struct dsa_switch *ds, int port,
 			     const unsigned char *addr, u16 vid,
 			     struct dsa_db db)
 {
+	struct net_device *br_ndev = netc_classify_db(db);
 	struct netc_port *np = NETC_PORT(ds, port);
 
-	if (vid != NETC_STANDALONE_PVID)
-		return -EOPNOTSUPP;
+	if (IS_ERR(br_ndev))
+		return PTR_ERR(br_ndev);
+
+	if (!vid)
+		vid = netc_vlan_unaware_pvid(ds, br_ndev);
 
 	return netc_port_del_fdb_entry(np, addr, vid);
 }
@@ -1552,6 +1624,8 @@ static int netc_port_fdb_dump(struct dsa_switch *ds, int port,
 		cfg = le32_to_cpu(cfge->cfg);
 		is_static = (cfg & FDBT_DYNAMIC) ? false : true;
 		vid = le16_to_cpu(keye->fid);
+		if (vid >= NETC_VLAN_UNAWARE_PVID(ds->max_num_bridges))
+			vid = 0;
 
 		err = cb(keye->mac_addr, vid, is_static, data);
 		if (err)
@@ -1668,6 +1742,19 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 	struct netc_port *np = NETC_PORT(ds, port);
 	struct ipft_entry_data *old_host_flood;
 
+	/* Do not add host flood rule to ingress port filter table when
+	 * the port has joined a bridge. Otherwise, the ingress frames
+	 * will bypass FDB table lookup and MAC learning, so the frames
+	 * will be redirected directly to the CPU port.
+	 */
+	if (dsa_port_bridge_dev_get(np->dp)) {
+		netc_port_remove_host_flood(np, np->host_flood);
+		np->host_flood = NULL;
+		netc_port_wr(np, NETC_PIPFCR, 0);
+
+		return;
+	}
+
 	if (np->uc == uc && np->mc == mc)
 		return;
 
@@ -1689,12 +1776,81 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 	netc_port_remove_host_flood(np, old_host_flood);
 }
 
+static int netc_single_vlan_aware_bridge(struct dsa_switch *ds,
+					 struct netlink_ext_ack *extack)
+{
+	struct net_device *br_ndev = NULL;
+	struct dsa_port *dp;
+
+	dsa_switch_for_each_available_port(dp, ds) {
+		struct net_device *port_br = dsa_port_bridge_dev_get(dp);
+
+		if (!port_br || !br_vlan_enabled(port_br))
+			continue;
+
+		if (!br_ndev) {
+			br_ndev = port_br;
+			continue;
+		}
+
+		if (br_ndev == port_br)
+			continue;
+
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Only one VLAN-aware bridge is supported");
+
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int netc_port_vlan_filtering(struct dsa_switch *ds,
+				    int port, bool vlan_aware,
+				    struct netlink_ext_ack *extack)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	struct net_device *br_ndev;
+	u32 pvid, val;
+	int err;
+
+	err = netc_single_vlan_aware_bridge(ds, extack);
+	if (err)
+		return err;
+
+	br_ndev = dsa_port_bridge_dev_get(np->dp);
+	pvid = netc_vlan_unaware_pvid(ds, br_ndev);
+	if (vlan_aware) {
+		err = netc_port_del_vlan_entry(np, pvid);
+		if (err)
+			return err;
+
+		pvid = np->pvid;
+	} else {
+		err = netc_port_set_vlan_entry(np, pvid, false);
+		if (err)
+			return err;
+	}
+
+	val = (vlan_aware ? 0 : BPDVR_RXVAM) | (pvid & BPDVR_VID);
+	netc_port_rmw(np, NETC_BPDVR, BPDVR_RXVAM | BPDVR_VID, val);
+
+	return 0;
+}
+
+static void netc_port_set_pvid(struct netc_port *np, u16 pvid)
+{
+	netc_port_rmw(np, NETC_BPDVR, BPDVR_VID, pvid & BPDVR_VID);
+}
+
 static int netc_port_vlan_add(struct dsa_switch *ds, int port,
 			      const struct switchdev_obj_port_vlan *vlan,
 			      struct netlink_ext_ack *extack)
 {
 	struct netc_port *np = NETC_PORT(ds, port);
+	struct dsa_port *dp = np->dp;
 	bool untagged;
+	int err;
 
 	/* The 8021q layer may attempt to change NETC_STANDALONE_PVID
 	 * (VID 0), so we need to ignore it.
@@ -1702,20 +1858,123 @@ static int netc_port_vlan_add(struct dsa_switch *ds, int port,
 	if (vlan->vid == NETC_STANDALONE_PVID)
 		return 0;
 
+	if (vlan->vid >= NETC_VLAN_UNAWARE_PVID(ds->max_num_bridges)) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "VID %d~4095 reserved for VLAN-unaware bridge",
+				       NETC_VLAN_UNAWARE_PVID(ds->max_num_bridges));
+		return -EOPNOTSUPP;
+	}
+
 	untagged = !!(vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED);
+	err = netc_port_set_vlan_entry(np, vlan->vid, untagged);
+	if (err)
+		return err;
+
+	if (vlan->flags & BRIDGE_VLAN_INFO_PVID) {
+		np->pvid = vlan->vid;
+		if (dsa_port_is_vlan_filtering(dp))
+			netc_port_set_pvid(np, vlan->vid);
+
+		return 0;
+	}
+
+	if (np->pvid != vlan->vid)
+		return 0;
 
-	return netc_port_set_vlan_entry(np, vlan->vid, untagged);
+	/* Delete PVID */
+	np->pvid = 0;
+	if (dsa_port_is_vlan_filtering(dp))
+		netc_port_set_pvid(np, 0);
+
+	return 0;
 }
 
 static int netc_port_vlan_del(struct dsa_switch *ds, int port,
 			      const struct switchdev_obj_port_vlan *vlan)
 {
 	struct netc_port *np = NETC_PORT(ds, port);
+	int err;
 
 	if (vlan->vid == NETC_STANDALONE_PVID)
 		return 0;
 
-	return netc_port_del_vlan_entry(np, vlan->vid);
+	err = netc_port_del_vlan_entry(np, vlan->vid);
+	if (err)
+		return err;
+
+	if (np->pvid == vlan->vid) {
+		np->pvid = 0;
+
+		if (dsa_port_is_vlan_filtering(np->dp))
+			netc_port_set_pvid(np, 0);
+	}
+
+	return 0;
+}
+
+static int netc_port_bridge_join(struct dsa_switch *ds, int port,
+				 struct dsa_bridge bridge,
+				 bool *tx_fwd_offload,
+				 struct netlink_ext_ack *extack)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	u16 vlan_unaware_pvid;
+	int err;
+
+	err = netc_single_vlan_aware_bridge(ds, extack);
+	if (err)
+		return err;
+
+	netc_port_set_mlo(np, MLO_NOT_OVERRIDE);
+
+	if (br_vlan_enabled(bridge.dev))
+		goto out;
+
+	vlan_unaware_pvid = NETC_VLAN_UNAWARE_PVID(bridge.num);
+	err = netc_port_set_vlan_entry(np, vlan_unaware_pvid, false);
+	if (err) {
+		netc_port_set_mlo(np, MLO_DISABLE);
+		return err;
+	}
+
+	netc_port_set_pvid(np, vlan_unaware_pvid);
+
+out:
+	netc_port_remove_host_flood(np, np->host_flood);
+	np->host_flood = NULL;
+	netc_port_wr(np, NETC_PIPFCR, 0);
+
+	return 0;
+}
+
+static void netc_port_bridge_leave(struct dsa_switch *ds, int port,
+				   struct dsa_bridge bridge)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	struct net_device *ndev = np->dp->user;
+	u16 vlan_unaware_pvid;
+	bool mc, uc;
+
+	netc_port_set_mlo(np, MLO_DISABLE);
+	netc_port_set_pvid(np, NETC_STANDALONE_PVID);
+
+	uc = ndev->flags & IFF_PROMISC;
+	mc = ndev->flags & (IFF_PROMISC | IFF_ALLMULTI);
+
+	if (netc_port_add_host_flood_rule(np, uc, mc))
+		dev_warn(ds->dev,
+			 "Failed to restore host flood rule on port %d\n",
+			 port);
+
+	if (br_vlan_enabled(bridge.dev))
+		return;
+
+	vlan_unaware_pvid = NETC_VLAN_UNAWARE_PVID(bridge.num);
+	/* There is no need to check the return value even if it fails.
+	 * Because the PVID has been set to NETC_STANDALONE_PVID, the
+	 * frames will not match this VLAN entry.
+	 */
+	netc_port_del_vlan_entry(np, vlan_unaware_pvid);
 }
 
 static void netc_phylink_get_caps(struct dsa_switch *ds, int port,
@@ -1996,8 +2255,11 @@ static const struct dsa_switch_ops netc_switch_ops = {
 	.port_mdb_add			= netc_port_mdb_add,
 	.port_mdb_del			= netc_port_mdb_del,
 	.port_set_host_flood		= netc_port_set_host_flood,
+	.port_vlan_filtering		= netc_port_vlan_filtering,
 	.port_vlan_add			= netc_port_vlan_add,
 	.port_vlan_del			= netc_port_vlan_del,
+	.port_bridge_join		= netc_port_bridge_join,
+	.port_bridge_leave		= netc_port_bridge_leave,
 	.get_pause_stats		= netc_port_get_pause_stats,
 	.get_rmon_stats			= netc_port_get_rmon_stats,
 	.get_eth_ctrl_stats		= netc_port_get_eth_ctrl_stats,
@@ -2045,6 +2307,7 @@ static int netc_switch_probe(struct pci_dev *pdev,
 	ds->ops = &netc_switch_ops;
 	ds->phylink_mac_ops = &netc_phylink_mac_ops;
 	ds->fdb_isolation = true;
+	ds->max_num_bridges = priv->info->num_ports - 1;
 	ds->priv = priv;
 	priv->ds = ds;
 
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index 9ff334301fbc..982c8d3a3fbf 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -33,6 +33,7 @@
 #define NETC_MAX_FRAME_LEN		9600
 
 #define NETC_STANDALONE_PVID		0
+#define NETC_VLAN_UNAWARE_PVID(br_id)	(4096 - (br_id))
 
 /* Threshold format: MANT (bits 11:4) * 2^EXP (bits 3:0)
  * Unit: Memory words (average of 20 bytes each)
@@ -79,6 +80,7 @@ struct netc_port {
 	u16 enable:1;
 	u16 uc:1;
 	u16 mc:1;
+	u16 pvid;
 	struct ipft_entry_data *host_flood;
 };
 
-- 
2.34.1


