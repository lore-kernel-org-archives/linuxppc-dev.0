Return-Path: <linuxppc-dev+bounces-23168-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B866C43638
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 07:49:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqFfZ75MZz2yxN;
	Tue, 30 Jun 2026 17:49:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782805782;
	cv=pass; b=KN0y8wC31J6S2ijPtX+y3mg6opoVc0yTuwUOAGLQC1Ug1SbcDQMt4Yy4/zRETA7mDRfwJA4gN4/r7a7kbMOtvL1ovABXKLcPsaNtB8Q4JQuDtRWadUCNZbwus4Z/e0iyg1pa/QTjMspQgAmbcJNVAO92bQW7DQKHPc5kH24wzwTO6gf9y/DM7xHwLv6i3ys0NHdL+X6QGDE6jYW+1il0tm94rS6Sg2DjC24xZSVa587c5O/irMsGUUQcQWI6cME1cyF6Rq0CTt2HHc6vBpl+IBSCv+J91AZIz2bNKPh/MWWcQybLJMjDp9q8Bib2iQ9rotJm8SoS9PLxaNssPo8GlQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782805782; c=relaxed/relaxed;
	bh=4xXf4We4g7UqeQwdurv3O8BsA5z1dsSy1EnxUpT9Yfk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aPX/xDzGluYUQFYwgM+S6iY22/uaKwXEk9kcyDGIWtrON51VEQYGOV5i5/qi59EANpVPkCBCoCB3RjwVAXXpq3/WoGFPs6MmoeqgzptHU0FA9pKACWKMsV2FH7f+JmoRjt+X5Ng3FWl3Xh7MALgGMs9rgoOHCEhcHahafS0wrNaA+ssWk9qJ+7zs6+EHIBXw6WtdFZuXoBSEJq5Z4lnBI7Kz7H223C29OCF0SQIBfe8q1QOTogusjk1ZTpe1E+RydfRGZabDuacjYniRtwIQAs67Luvd1cKAbovAChTYbkXiSvskp7546f648Ku0xLCV/vg09cN7c1YqgAvxx/ZXEA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=FEFbDF1e; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=FEFbDF1e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqFfZ0PC1z2yx7
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 17:49:42 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kSjAtkX+Y5y1vXjShmMvEFm2NHe3/3VRqljIeC2aACSC7VXbLLuj3aAqjiUAGyhmaGKeYa1nZFN/U9gQsUEdGIzePoXzxUgYXX3BQlW9Fx4IeXvcjfW5maiJEMhA7h4f2guKm1QRsQvTH4hDuSOW+P5k/dp0uHnX2Hg8JqgAWMVxAwr+1t5xDs56B7ML1h6krPQtiBty1+yWYfOVxv2l2Hn/3+eLk9icGdlfydufwhbi7PKUM/SCF60PsIZFeGFk5Zx2akD0wN8DLvlHcJlZ8EHQvJ6+hNXE2EFovSMnvDH5MdxPkukQqhwPGmruP+kMshdyDzvh4QrQwDb4NJNL2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xXf4We4g7UqeQwdurv3O8BsA5z1dsSy1EnxUpT9Yfk=;
 b=SZExL2SLbPmNRf1C9W477xNyvjstZcGHzY77CAWMNq79FubekFHG7x/1Q/FyzEQDYcjet6ILkVPpd1fSj1RWLusMLqLNlQYr0u9MC1w8isD1dtNhxhCAucFghTEqS5/wmankAr7MjhFK3gwGJ3A6nXRN51eqi9Nbd6Sim42Z8ilE39e58+ORZHcC8dD9KYs7aJx7BQyageXCWqSMDaNOamR67PrXgczic6uA/LzIVVlryJcTTs8J+yt8tCIvKWYuycrYFA77jj71gSjkmUNIsYzCz2fui45zUk1HzMtQ8JTV5AfDe7YTzvkpL1wLAjkrJWD6Ig5ufGRJFrsrq0OxnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xXf4We4g7UqeQwdurv3O8BsA5z1dsSy1EnxUpT9Yfk=;
 b=FEFbDF1eTTaNaJLZ/lMtg0tXtKKN88Rm4zJPlsd66Gw6jvuYL8+kv+q6Xb2ZalA09LBcZQL8GfIN3jIoTDWoD85ME2uoA5nRjV8HVoZq9pikUtybfj+SlRhfYVhhEULX6CQxMbiwlLSd1KsZEjDKYsIJvJv43Ctn6H4h2djtoiPS+KgA2iHom5RweY93oxk/ZsibXMjJcVlsugCOZ9IAEZTWCSji0PHqZrqzwdluKdIil2c8IhmW9anpf1zE4iXqqljiWd4ZvbiMZ83YsYi8jsXfQ9LJxX/JxHQdWFrrmixdc9G8Yal3Zlj7IX307SZqpkhzRVz+LRPuPCdzBpA4Xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DU0PR04MB9561.eurprd04.prod.outlook.com (2603:10a6:10:312::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 07:49:16 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 07:49:16 +0000
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
Subject: [PATCH net-next 07/14] net: enetc: differentiate phylink capabilities for pseudo-MAC and standalone MAC
Date: Tue, 30 Jun 2026 15:20:29 +0800
Message-Id: <20260630072036.382761-8-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630072036.382761-1-wei.fang@oss.nxp.com>
References: <20260630072036.382761-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DU0PR04MB9561:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b0a26e9-ce3b-4de7-c9b1-08ded67c15ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|23010399003|19092799006|1800799024|22082099003|18002099003|11063799006|56012099006|921020|6133799003;
X-Microsoft-Antispam-Message-Info:
	OLD3d2R9OZ07Sxv3+cRXIv0z0Z5IcTYazP3v5uHPu33YUNH/rAP8nenfY+1OFaz97sFyub3BupDESfpjSS0CchHVaayvRfhQAdta47fTskxrKLE6S+r0guPO6+nCEQ70APIx7650j9oZhMtK7u53Vz0pU7Gj9wnDW7LReLGkc6BM/bSOIFAY45LiC1KEMtLypCBOFSyNcfVqRdNvzGqDuMoIH4duJMkvFNrAksCmcEbzTTwWYoP+CN9hCGxfpkslHpXcy+7FJIsh2IJho5ocZ3cgQHqai1jWuZ/dVxUFExHzLouekcD9JcYvhxyUWqVzw7dNk9N3mvUYA4KO601L/xnNC54ADWyK3wcvI+DAUWrp9iWQyMTtw0M4C1atoCA7mATBel4+zS8DzdT+Ev9NGJg5L8t1QlPuFP2G1kKL+TJYXXQnm/7dRHwY6bfGsKTfEtJaCw1o8002ShuwojeUgOUVUct0hzkmC51ioniZ8HaWyxBYBNWtwlVzgHgTHQsDSsEVp4sP0YA/AlTT0WnsLh9kvfxC5NP0/WGPeppiCcfAq+OymjUDYXdnvQuKY2ykkCkDm+yUbEyVa4b8LJmp/cQ2LYkIVtPWMitSH0+GPAbUKHUnCrWpoaG7Vj4CLF1yQDsMuBCOTuUwZ/V2TI6o6oFecfcfw9jT9VZM/m4frpEJmWwz3W+3gSutZ8xFJcvc8EEb66aej8VHszQCV/+FzA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(23010399003)(19092799006)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(921020)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V75AJ9+HoK3nXIcR4DJsRtHmmDZ2Wn+19SB59wHeqaXLOkEWdDz7dwjPQs4z?=
 =?us-ascii?Q?CJrjY/wguZqVSHKpR8N26OcN8KroG/EWmpp2aLYITplfGOLntJfc/GimmG/c?=
 =?us-ascii?Q?4S6sPm7+gMNJ/CFj6qOYYB3fNwTUOAyf3xB5AyW9qxZW4k5oyQGhDRCFwvvy?=
 =?us-ascii?Q?E36MHtu+pSVxwUj9XGGo5xTBKSo4JgX0/EC+pxVoiD2tXkOQg5JTwmbBajhB?=
 =?us-ascii?Q?SdrOYdkWYb6/dskv8U1EoQxlNNZA0565TNX3Qtt91uBMshLWdWmgCWtY9EO7?=
 =?us-ascii?Q?PmhiEp+sIlsSb1G/CHyRWtyzPmENCkSnc5TN9ggS0I3Sf9wyLjvRtrISOJzU?=
 =?us-ascii?Q?EbHc/AVNWLG8YuBcNZ/uibgum1+LsxlvMBpfL5VH83B47GGMDYq1+tqtez6e?=
 =?us-ascii?Q?Hy9h9gJ33Qsylzi+PoBYWnNUy7T6VfVtOAX4eGqfFBYvoFyXgLCMRaerpbLS?=
 =?us-ascii?Q?sZHwIli6yG6YqoopG5CEkFZtL8t3rapsBTFyGXEgjmsYtJV1Ig3ZClHuiCfO?=
 =?us-ascii?Q?naIOLMYxHAn44xesPz45tpWkyBiKZ01z7G2ERQVNFHtqnj6aMLAL/J2JoQpW?=
 =?us-ascii?Q?kjgymPqy8dxZ35TpBYFKmo9ZZLwc2wOIbmT1S4NNDdT3DjYVUUf08iKBjczW?=
 =?us-ascii?Q?k5ILy9bcgnqQh2PHiUe+lS8kkH4DD6/MEJvgBzBKA9DP54FPKtgi6i+nh4aV?=
 =?us-ascii?Q?UX5Tz/eb26vW7VHFwBhlNkgx1q3gJ93t3CGvs8PbFanoiq/oWhHQjCnnmjgn?=
 =?us-ascii?Q?5VnYYUSCHP3aVtJ4I2IGf+jmGCmGU8E5RkducivkexB04Pjsd3zdVS/bFwNc?=
 =?us-ascii?Q?/5/qh9D1JNYKLQLqc3jqjv7K0RPxY2tfxWK5KmrOqQ8RTt4vxz3szz5SzR+T?=
 =?us-ascii?Q?b5L2LwAEb+BfOPC3OYCbH/se/AOMcXn5qEXAsBVWU9qBLK2TaLniIyhx1nx1?=
 =?us-ascii?Q?lOQsOt50WyxNwdcgznb20JTL6MRp11GlyLYMO6/PiOkGTVIgoy4NjzKOZgqi?=
 =?us-ascii?Q?Lo1NPjWDKrPwflsAdft7lKmS8rOmU7Nr3KUG/iyHQOHsX13qUkLgiUHJ4ETd?=
 =?us-ascii?Q?Hz8A6iYtlRZd18DpNAWsXU2g+WV7VpbDFJP3DQWfXUNxmcw8sus0CJBlQVYd?=
 =?us-ascii?Q?S8Ke5kAfrRznGUhg2SoCr0pDYKhTLvUcJIpp2yFAt6Ko5QS9TW/+P9MRtmSp?=
 =?us-ascii?Q?QUFxgcXR6njmglXj31DDIPLUbfPeVb9Yp26sjod9bRtlYD4VP2xzBQ2m4Nan?=
 =?us-ascii?Q?XHEsUekQC4E7OzYeF/A1KICvEjVUab1toeVAGn6CZbXBD+8pyJOXFZ7t+y/r?=
 =?us-ascii?Q?lnsoVjMr5JEu/ekIS4QLxthoZ6452N4SAuabbZYgO26edmxZGk9vGqW3CuEt?=
 =?us-ascii?Q?SKcQQtzYGHK7lz0vILB4ikqZUegHv9q3jLPbCi7aLXRqT4+uTpy8ZLZ255fH?=
 =?us-ascii?Q?rXqy7wqqTXjih5b4/FMFZm3teMv0fv7OXQ+KKBjEeO9SzGqm87lRgFs0TldA?=
 =?us-ascii?Q?WqR1xEPG99BFNJCWj8zXaN3XYKUE1R9B/RIajv27MWfkKCkEbdiHDZTcmWw1?=
 =?us-ascii?Q?kBmRsdnCTNaR9XUQ97hU2xnej9oWJkkb9AMtLWKFY6LQJoWzGR9qkoF40Saf?=
 =?us-ascii?Q?Xt7bcrjjMrcXLtvHPZcubhxcuYxfYiOtpTtNUT/WXoufGBjsQ0yCf/P1nkgB?=
 =?us-ascii?Q?kpADAyEI3QVBqrJ8St2ulfkBDHAsb0rElbo5o7j2LNkbnfhWRNbr/U39hbQ+?=
 =?us-ascii?Q?kCvcQbcCJ3ybDirJcQE7yh9Rpb0X3hhN1qZDZ1IrwFy683boKBsv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b0a26e9-ce3b-4de7-c9b1-08ded67c15ff
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 07:49:16.7842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ljI2aCX+EgusRDIHcwaAJifiwKWFLOFXp4OX4blRSt+dlLT0KmJsM2cGNW6wFnegRt2JQT9tgELGzqcMYuzRGddNE9guAKiqU5FRjIhaaPn6LqQETD51EOKFbP7PscGf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9561

From: Claudiu Manoil <claudiu.manoil@nxp.com>

The ENETC pseudo-MACs are proprietary internal links that do not
implement any standard MII interface, so restrict their supported PHY
interface modes to PHY_INTERFACE_MODE_INTERNAL only.

Since pseudo-MACs can operate at any speed between 10Mbps and 25Gbps
in multiples of 10Mbps, set their MAC capabilities to cover the full
range of standard full-duplex speeds: 10/100/1000/2500/5000/10000/
20000/25000 Mbps.

For standalone ENETC, expand the supported interface modes to include
10GBASER and XGMII in addition to the existing RGMII, SGMII, 1000BASEX,
2500BASEX and USXGMII modes, with MAC capabilities up to 10G. MAC_1000
is replaced with MAC_1000FD to explicitly exclude 1000M half-duplex,
which is not supported.

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.h  |  2 +-
 .../freescale/enetc/enetc_pf_common.c         | 39 +++++++++++++------
 2 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 06a9f1ee0970..8839cfb49bcf 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/* Copyright 2017-2019 NXP */
+/* Copyright 2017-2019, 2025-2026 NXP */
 
 #include <linux/timer.h>
 #include <linux/pci.h>
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 3597cb81a7cc..adf79a99a8c8 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
-/* Copyright 2024 NXP */
+/* Copyright 2024-2026 NXP */
 
 #include <linux/fsl/enetc_mdio.h>
 #include <linux/of_mdio.h>
@@ -400,25 +400,40 @@ int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
 {
 	struct enetc_pf *pf = enetc_si_priv(priv->si);
 	struct phylink *phylink;
+	unsigned long mac_caps;
 	int err;
 
 	pf->phylink_config.dev = &priv->ndev->dev;
 	pf->phylink_config.type = PHYLINK_NETDEV;
-	pf->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
-		MAC_10 | MAC_100 | MAC_1000 | MAC_2500FD;
 
 	__set_bit(PHY_INTERFACE_MODE_INTERNAL,
 		  pf->phylink_config.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_SGMII,
-		  pf->phylink_config.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_1000BASEX,
-		  pf->phylink_config.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_2500BASEX,
-		  pf->phylink_config.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_USXGMII,
-		  pf->phylink_config.supported_interfaces);
-	phy_interface_set_rgmii(pf->phylink_config.supported_interfaces);
 
+	mac_caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE;
+	if (!enetc_is_pseudo_mac(priv->si)) {
+		mac_caps |= MAC_10 | MAC_100 | MAC_1000FD | MAC_2500FD |
+			    MAC_5000FD | MAC_10000FD;
+
+		__set_bit(PHY_INTERFACE_MODE_SGMII,
+			  pf->phylink_config.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
+			  pf->phylink_config.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
+			  pf->phylink_config.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_USXGMII,
+			  pf->phylink_config.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_10GBASER,
+			  pf->phylink_config.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_XGMII,
+			  pf->phylink_config.supported_interfaces);
+		phy_interface_set_rgmii(pf->phylink_config.supported_interfaces);
+	} else {
+		mac_caps |= MAC_10FD | MAC_100FD | MAC_1000FD | MAC_2500FD |
+			    MAC_5000FD | MAC_10000FD | MAC_20000FD |
+			    MAC_25000FD;
+	}
+
+	pf->phylink_config.mac_capabilities = mac_caps;
 	phylink = phylink_create(&pf->phylink_config, of_fwnode_handle(node),
 				 pf->if_mode, ops);
 	if (IS_ERR(phylink)) {
-- 
2.34.1


