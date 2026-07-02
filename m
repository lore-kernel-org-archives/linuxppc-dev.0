Return-Path: <linuxppc-dev+bounces-23353-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13099C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 03:26:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grMkF6qtVz2yjw;
	Thu, 02 Jul 2026 13:26:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782962805;
	cv=pass; b=fJwq7Yn4I/BYnZYE81upMk4R9Y8RmTIFy5p8qmRtvi0cCPzwhZufl17r4RwDJYXGDvhzrZKjkhJ3yxx/U922e/aU3fcvzdeONzDXhoVUXrrt5ZBNmpuRFz0sKhX+Bcb594tog0Axltn/8dbK2AA3ErwpPy+2V5Ag07fv4Pm0Naj39Au8W3l3jbJn/J8in/5fPVc1n/DmxbTxXGbPvgejn+huHN3XTgiVLwNqGjjaeiRui/VniqibArBrT56SnCSMhKhksvboekf2FMMlWWb4xUguruWCsmJqmrNtJRXRvpvJ929HoCaH1+mLCsXfOtVY4NLspKeNbzkSlT1+T54Cbw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782962805; c=relaxed/relaxed;
	bh=6di855Gch2G/PLa3djIfHkR6OgI/5D5Bb33uuzC5prw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SA09vAchCe/27t0thprsflxcAmkfRT7JkCNQMvsmLKD11iTdTCtily0mmm7/kGQC5MAVKv9C+akYttqlu5VRuZPo0KVXsnfFTmsdPxgs+sA65HezbTRzQMQGe3TmcLuyBrRmmAMlOlAFA5dnx+7Tqw61dlvsw1Ji6W7ju8xt2qp29aLH5N/1lmtOiLusdvJoCAj/00EyXhdW0jWpgCbQTslkbtppqGCKoTmynn+u+2bq83U5wOuzfxf8Fbm9Xa1pVcbeBB4Cc2NsrcPjExioA9K/PqFfpe8oDnzXo5CK3SV6cPDVykFULyPS0UzbpkbI5MpHKcxIXZU4/GmuiwsiDA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=QAj7CQC6; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=QAj7CQC6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grMkD1fx2z305P
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 13:26:44 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3LLjAx3aGcp8WdvibxQq7uoNCM2ABFSUt314JMhH7rZY1yOpGiXBYmH4n0c26MF+nzhkk09+oyP+b1JOBEbNaXSPkJV7Xpaa5X6AqI4c8GthD+Ms10ASkJQUuXXeJWIB7WveF3OGSxIL0iZLVRonPxWNRMTLu4OQNoJ3JY60Itnbbv/+r+tup8mDGvp7E1qBc4/YJsySmdAg3L1F1a6LaJ4uNnGrl2TZ3wI+wIX4hxjiEgWJ1bF+XaJtlsRaCPqZ3sG/lDayILsz1D5LdDR9XIqGF1gFwAjm/gT8f+VEArZR048xlEq8+2JtMOPNMrhqL2bzKpkyz+3OZAaQ1hkVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6di855Gch2G/PLa3djIfHkR6OgI/5D5Bb33uuzC5prw=;
 b=vj4pHlq5gXJXVMisAfIAdelxvUwVARMCG7NsNGg+DuRgp9POn2QMJAElw1d7uv7Xylc6v3XkE4xvPPAjODj/FG6YoQxB5zCqgwu1geNeYJHg4KdIhGE7SO36rO74+ZMe/YJ/4oX2b5rZKlw6zP5ZQNWHLjAxcWSpDLZ90pX/DE/b+w94yW1oMpb8JgiSyQJ/Sf/fIg46t9RQ1Z1vNkjJr8nhozeIBnRorjxJmqK5Be7oMBaIs1osHsMYeeMYorOz0S5tTry0DMDGp70bGVNOk9+Pj7C9Sph3lPNP8ROXXGr6lgG8p/juZkVbVJdDnb3lQvUuWvbc45LAEQSt9VLBUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6di855Gch2G/PLa3djIfHkR6OgI/5D5Bb33uuzC5prw=;
 b=QAj7CQC6idQw9mur6vfxJXjfaLxkbpPnIhZnuC6ABAdgE/OcHmRpXMVDzqNW8VAbfDtnsSkNN+ncSgZUJCoqhehzp/qmMSLl42j64E9B3/S8ohnyEUWMyqfT0KmERxwAJGrwz57JGhEq+uJbT8zmRNI7w+aPS/90Ncql/D6AAha3EMYACZx/uR4G05yl3TPXeWYlfcfvtufuVLuy3abkbBgk8PS2nZ+XaWWiCyHLRrkLkZJjvgwnAbtWd/3/Vuybd5ue5qd5febPukT/2F9XYy5R0/DZhItYdKcHjhCqVdFKCz6+by8a9RjjjJ08rw5N3aKV4b5Il1JnmUEAEjb48g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by GVXPR04MB10248.eurprd04.prod.outlook.com (2603:10a6:150:1c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 03:26:31 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 03:26:31 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	wei.fang@nxp.com,
	chleroy@kernel.org
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 net-next 11/14] net: enetc: move enetc_set_si_vlan_promisc() to enetc_pf_common.c
Date: Thu,  2 Jul 2026 10:57:11 +0800
Message-Id: <20260702025714.456233-12-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260702025714.456233-1-wei.fang@oss.nxp.com>
References: <20260702025714.456233-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0138.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d2::18) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|GVXPR04MB10248:EE_
X-MS-Office365-Filtering-Correlation-Id: aa03c970-b531-47cb-0c56-08ded7e9b602
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|376014|1800799024|366016|921020|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5O7w/w0JSuI3IvqgQKrr+6TzBc14dhB3pQsfQOOSWSEz++VlZcVqHSkIT5+P+Lr8J9UvcBiQ3Gq5p23YYWzKLyqFz8YC+hunROttI7ZdBY9HLXaVAafvf/kw44LfG0kdQsiy05LY8XboVP/8lfNJBxhz+0LPCVm6ipmE3RcuxhkiTYrs9hdKQBUhkiV7jYsMmfI6f4o3Rt+3LZCn5hfZq4J+V/MudZP1tED7owiJZzIgdtAg/9/C4290huvCxWpL2hiw2TDZYzLwnfAaDz7WxHXx2bvz0JVZjBEUdya9z4H0M8Shkim3XeiTtyXqFnC+ur/jIPVpeRXDQ4WqTDyAX8GQXEDjatTPEAA9LWTCriQoGcYwIY3NDw/OX913O8hmN5AWt/s2L0F9fDQ71ZRGFDN8ip2gpNZaSFOMlG7nBbyOesIqiz7+tbcUA0tXg56A99jJczXIy6Qx+WoGZgQ45D3+/w6HubCBnHiRbQTq2Yh6zd86gXHtk4zdcj+GWxsQ6j09u5fDeW5ybT3xV4WA3Ec9AqZWuI5wTCJQcIpFEtc00Gjatq8h0TPibJd7MJZQh9d88EZQMotxJvInptLOKlI50jVCaHuq728QDG5UEC17rHfFooul5NSWTwzkSVSXpMU8avDLFvCB9eahKMBYMHxGdGeZ8DPSz5BOTPniOt+R39CxrRyajQr5PND23NliwxjuhwRoLDBN1URjdQOzQA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(1800799024)(366016)(921020)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hG5OmB9aoWIovWQWMoNEoG1ZJ6OrZiHxu6Yq3ZncSZ60Y94s2ZUFmxOxLuCj?=
 =?us-ascii?Q?FjHprUMnps2thoANvpJNBYLcwn92dLL9HTI1lbHE/3/g1/SHsyiA9yc4bMjD?=
 =?us-ascii?Q?giYpTPyZ4+TwQ/V+65X30esJS2IPSgs7OIYQHRGbZA/a1MQcQY46cxpKWdvm?=
 =?us-ascii?Q?KUah4WV3PqI802BVnjhblUJh1JjfzHN/gFHEobAaYRGcZ1wW/o8YHomkCiwo?=
 =?us-ascii?Q?qrljutIkKiS+xeJHpL+ML3kJ1Xbf3F35EbzdhzAkj4D1oqtghjpI7ttizcgJ?=
 =?us-ascii?Q?Dkwgo6oGYaI0O9Y02rjjPtDbaqRKscwEa4zYabNSSPMT22Ld4HstUDXFsYP2?=
 =?us-ascii?Q?SmJ+XyIiOyGrotNlFf9RtlymM5BsMYp/0nIw4zc7dvc/3UeTendjkBdx0nyY?=
 =?us-ascii?Q?DaYOWIOcpkVOr1JClwPB+aijKxF1B6pzpLQb14loNzwkonoRPkIC1sfxhYUL?=
 =?us-ascii?Q?/c2e+EBzDrbu3oXnozqkdeQaiIYeZkSv+fBdzDjGP+qH0p7kVSIRTiuBwU58?=
 =?us-ascii?Q?kvtfvF8nVq2Zcd45o1X1O3EvXFi0FBLrMZhIJqT9nfGrftq3miTr+soCU1Iu?=
 =?us-ascii?Q?oQj88ZSCKd6pEXBobFQ5gZMzyOh9owAejXNX0gAYuujCuQVqme5fQkFM4zwk?=
 =?us-ascii?Q?oxhZQ9PpZ2R4sRR7OXKk+yethtF7u+6/rmiWwU7V5CjyAYY6O2PkIJlanD+c?=
 =?us-ascii?Q?hgoT+wLtjDwd/j54GIrYRbnxjccuBVBwxJY2HeCiRDM2jdUsS9dAm3ysAvgE?=
 =?us-ascii?Q?4MSdq5bqpuIVgGPkyIfEa4oWxBBbbBZZf8SZzOCYBU98b9hYzBIsYzSnbG6q?=
 =?us-ascii?Q?fmYd57oqhSricxhi1FCMLxWINYxPg1m8JsaIYbHMTCq+mtbaMxjk8mKhlyUS?=
 =?us-ascii?Q?B7xUulCrByvz/u7pi0YOUaKx5Q9tzF2h3JXw9+GLMcnkoXtX1M2Evirb0zVH?=
 =?us-ascii?Q?L5GqQDjE7knOp9IEcoJ4sFqLulVZB4/5v9QKt4eTawXmuk7OGtRW66sxJ1Bi?=
 =?us-ascii?Q?jtwcH8aQ1hA/tmT8RoWyYbSsPqNZTcmun8+CPZ1C6/oW2X6MwGyx4K8HrW0W?=
 =?us-ascii?Q?mXDfCuWo0BDWs3XTrBWbToTOCVCSpPJmVTeiekHiKnD+RWUyplPdIMvNXwf7?=
 =?us-ascii?Q?rJDmCwQhPPhYe66cEBaaB+6yvotbW3sED7yjsz1Jk09KfKfSu0Q4Cs1jUlqj?=
 =?us-ascii?Q?hpQlmH/Ufqj2aNiyNlj2GEt4eiEGnvsyN26TKLlUcO+mL/exXn28bQTyWDMi?=
 =?us-ascii?Q?yWHfMuNO+RnP3roZTrnCo47mL47cEdn8Id3V7F4aCVL61A7pLl7o76p61HSC?=
 =?us-ascii?Q?Hl2wK6EIhwfSic3OFegGRB2K7l3AZkLUNn1NpAHvqhQ+Em7TJlol0Ws4u6sb?=
 =?us-ascii?Q?33JIjHSLT0MSV8wqJhzU5H8+3hg04IGPmi9iSz/C6VKcpsU9xKtKuhwaCLNa?=
 =?us-ascii?Q?bGgx2BTM+qe/KyQjqF9cvl2BOHai4jLfwkpnBmbWLn5Rhixnu2cmsiQU8O6F?=
 =?us-ascii?Q?6Wi8dwR9sfU8B2jCtIExWlStzlytGviFsaNRv4VzyIhyMFO3UzBKACPEZsk2?=
 =?us-ascii?Q?58L4dgH2QH1gW+VYWT95pA4nDuZLLizC3PgWJg6vyIoPgEuZiuKpwfWDmQob?=
 =?us-ascii?Q?AoZuwlPzHh1IEQSil5FLjLMx0pLR40jdPtxTrwHX3CAYcunF3pRbC54bOICT?=
 =?us-ascii?Q?o+zynGSjUXDkg2VjhHi9SQFX+4Qzf20mTqa7vj7ttXIs2R0QkUnJlCVEW9fE?=
 =?us-ascii?Q?BIaN49pmbaRxnMncXvG5IXe0idasP6bZzXztPitFcwIiKT/POLHF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa03c970-b531-47cb-0c56-08ded7e9b602
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 03:26:31.5719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A/Igf/s4GKEk0WcChUjb+hXCLKLhEzntg6Dknc0r1/QTyCFoSBYdXQTOMhc8PA9sTD4q5gorIeTkJplHLxSxTNKr7XKPlnEfEYIuD7tOu5qwyKK64pZGhVtmY0S9TMI0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10248

From: Wei Fang <wei.fang@nxp.com>

The PSIPVMR in ENETC v4 has the same bit layout and functionality as the
PSIPVMR register in ENETC v1: bit n (n <= 15) controls VLAN promiscuous
mode for SI n. The only difference between the two hardware generations
is the register address offset.

Since the register functionality is identical, the VLAN promiscuous mode
setting code can be shared between ENETC v1 and v4 drivers.

Move enetc_set_si_vlan_promisc() from enetc_pf.c to enetc_pf_common.c
and export it so that it can be shared between the two drivers. Add a
revision check using is_enetc_rev1() to select the correct register
offset (ENETC_PSIPVMR for v1 and ENETC4_PSIPVMR for v4) while keeping
the same logic.

Remove the v4-specific enetc4_pf_set_si_vlan_promisc() from enetc4_pf.c
and replace its call site with the new common enetc_set_si_vlan_promisc()
to eliminate code duplication.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 15 +------------
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 16 --------------
 .../freescale/enetc/enetc_pf_common.c         | 22 +++++++++++++++++++
 .../freescale/enetc/enetc_pf_common.h         |  1 +
 4 files changed, 24 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 88ad99cecc9c..d919a8645fb1 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -298,18 +298,6 @@ static void enetc4_allocate_si_rings(struct enetc_pf *pf)
 	enetc4_default_rings_allocation(pf);
 }
 
-static void enetc4_pf_set_si_vlan_promisc(struct enetc_hw *hw, int si, bool en)
-{
-	u32 val = enetc_port_rd(hw, ENETC4_PSIPVMR);
-
-	if (en)
-		val |= BIT(si);
-	else
-		val &= ~BIT(si);
-
-	enetc_port_wr(hw, ENETC4_PSIPVMR, val);
-}
-
 /* Allocate the number of MSI-X vectors for per SI. */
 static void enetc4_set_si_msix_num(struct enetc_pf *pf)
 {
@@ -517,12 +505,11 @@ static int enetc4_pf_set_features(struct net_device *ndev,
 {
 	netdev_features_t changed = ndev->features ^ features;
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	struct enetc_hw *hw = &priv->si->hw;
 
 	if (changed & NETIF_F_HW_VLAN_CTAG_FILTER) {
 		bool promisc_en = !(features & NETIF_F_HW_VLAN_CTAG_FILTER);
 
-		enetc4_pf_set_si_vlan_promisc(hw, 0, promisc_en);
+		enetc_set_si_vlan_promisc(priv->si, 0, promisc_en);
 	}
 
 	if (changed & NETIF_F_LOOPBACK)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 096ccb35508c..ac282d17c0d3 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -42,22 +42,6 @@ static void enetc_pf_destroy_pcs(struct phylink_pcs *pcs)
 	lynx_pcs_destroy(pcs);
 }
 
-static void enetc_set_si_vlan_promisc(struct enetc_si *si, int si_id,
-				      bool promisc)
-{
-	struct enetc_hw *hw = &si->hw;
-	u32 val;
-
-	val = enetc_port_rd(hw, ENETC_PSIPVMR);
-
-	if (promisc)
-		val |= PSIPVMR_SI_VLAN_P(si_id);
-	else
-		val &= ~PSIPVMR_SI_VLAN_P(si_id);
-
-	enetc_port_wr(hw, ENETC_PSIPVMR, val);
-}
-
 static void enetc_set_isol_vlan(struct enetc_hw *hw, int si, u16 vlan, u8 qos)
 {
 	u32 val = 0;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 6ccf9b909054..fdfb17093538 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -171,6 +171,28 @@ void enetc_set_si_mc_hash_filter(struct enetc_si *si, int si_id, u64 hash)
 }
 EXPORT_SYMBOL_GPL(enetc_set_si_mc_hash_filter);
 
+void enetc_set_si_vlan_promisc(struct enetc_si *si, int si_id, bool promisc)
+{
+	struct enetc_hw *hw = &si->hw;
+	int psipvmr_off;
+	u32 val;
+
+	if (is_enetc_rev1(si))
+		psipvmr_off = ENETC_PSIPVMR;
+	else
+		psipvmr_off = ENETC4_PSIPVMR;
+
+	val = enetc_port_rd(hw, psipvmr_off);
+
+	if (promisc)
+		val |= PSIPVMR_SI_VLAN_P(si_id);
+	else
+		val &= ~PSIPVMR_SI_VLAN_P(si_id);
+
+	enetc_port_wr(hw, psipvmr_off, val);
+}
+EXPORT_SYMBOL_GPL(enetc_set_si_vlan_promisc);
+
 void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 			   const struct net_device_ops *ndev_ops)
 {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
index bf9029b0a017..8243ce0de57f 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
@@ -21,6 +21,7 @@ void enetc_set_si_uc_promisc(struct enetc_si *si, int si_id, bool promisc);
 void enetc_set_si_mc_promisc(struct enetc_si *si, int si_id, bool promisc);
 void enetc_set_si_uc_hash_filter(struct enetc_si *si, int si_id, u64 hash);
 void enetc_set_si_mc_hash_filter(struct enetc_si *si, int si_id, u64 hash);
+void enetc_set_si_vlan_promisc(struct enetc_si *si, int si_id, bool promisc);
 
 static inline u16 enetc_get_ip_revision(struct enetc_hw *hw)
 {
-- 
2.34.1


