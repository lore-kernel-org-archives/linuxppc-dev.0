Return-Path: <linuxppc-dev+bounces-23683-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C616C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 08:47:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvZbp4JQ8z3bsd;
	Tue, 07 Jul 2026 18:47:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783414038;
	cv=pass; b=DQqGlYo8B1akb9ej6pMV4w3cPi885JG43oHUk9CfSyEIw/UzNbYin6qUOoUK/zufs1ovaXl5ICP6tHYdRrf0k6EWjSqhGarYOOnXVTui0vIKM0Q6nKPGqMVRO/BdwzxEGB8RnCgVB8Fqu5QxurGKTkLRigpv7PpYIE3ZFPYxxXWx/GF0314StI7mFMqsjtOOdml7Uqqkx19B079WGvOK7U4ugGnS29fpdBnW7smRmcayd9ay4CRqGuldKLlGc6PqWqJH3NUaR10AdyzdDqUsV2BqCH/elEAixQIGpiJTQJuzFm3BJHDOIC8EjMqNwT9rfOi+pMGEBEfDmJUbULftmQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783414038; c=relaxed/relaxed;
	bh=GCXpVfilOobuwtQo1MG+AfHJM40d4RwVXZ+w/PwLVOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nz4UNslEDqlD1YnbGYrQ2/UrtCzELOMGfIa7kzZiDNElzHVVX13Xo5xVffO83sKiFUUbv7NLUNo/EMIkhAr1wqStgerO5LBmpbEpLq2QUmXv/j5LWau+r+Coik6Iph074dAcqx450fkMNOgpYNBj7II1WuceaRi5zNhUxwmjupujQQPao+07/HHEo78FwvG6F2XI+OjjzKbnqgcP4kcb4Y/BJWhp/LE2jeCv43GBez5mRZsoVsOdC0teoUfP0Bh2ZGu/OYETZ0qeCRyb+4wyvDsXm1JtdRspjrGPtlSOJRmCYrODU2Xhp0/CmiXv4wCQgdGHbm53TXo8PxcdONux4A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=aq8wteNz; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=aq8wteNz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvZbn2MmFz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 18:47:17 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgI8kczuXLX0RcqUl0wIj/slvPHJ5Ifgje14EG91x2qDtjYPasTBmCnribb3iU0NwQNzbCFcvxCo4rT5qkvFhxY1niu7fE6dCgZZoCxi/g0Lgc99bpHmxqlMCwHEMLaAQ/7/VnKgAf9X9dN3mx3SPBPtqWqg2gHGst+p7qr5Eeme6GQH+q9ntqbCzL1C8JrXrOKimrQsZhoA57O7BY7Xy2tnKu6Qc6BIthuKX+wanW1Nj+3FQSbZUKJmAI2chndXqRIDKZKmQ40DnVcXMx1vha3b/Pd7XPLWrqvpTNqOixrZ4J8qJyIil9gxPwj333GwagpihPaXTi2VCgZ6NyXnFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCXpVfilOobuwtQo1MG+AfHJM40d4RwVXZ+w/PwLVOY=;
 b=dj3LWddzCv6CDHu3AF54mWLc+OeR2XRZfSfS1l4nkHNy7mYfRnSr46a3xdKb9KrhR5diXGpm9pznQKOXJninijkWdsnJb5ft9QJMopHID4dj+XfSv+JBTXi7HAxLHHJSf3RFuu3E7jscH2LxbRViDe6Od/mM4RH1P/vlBCC6eFqDF0U2Xyf/TRZHFOubRzACnWAT/iC5paaT/rbqMzJ+XIfqMvaj+I6A9tyUZnUVfXiNEVDd8S36YsUiZMeKaOdns1Fl8YdqgcRc1lMFaCmcyhB/vna9SUdFYnquwoDfug/PweQSdJGiWMBa3kXsf1ljI9pKyj7EY3i4QCG4nTFjOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCXpVfilOobuwtQo1MG+AfHJM40d4RwVXZ+w/PwLVOY=;
 b=aq8wteNzZJZOPrV6RGOb4J0reHuXij008LAmdQLcmbVNQDozDqFZrXawnT/du6caPVeBQxZqjmwRNw/2zoNSoY99CYIZrg6bpdfdiyWh8wiIHoYU3hjtUaP4oS//1gIDGOfrA+FduOU2YpejLufkRXxryjcMwNROkO1IM8mSxa2f4k2CloBIOpMxRHExjZWgx6hupJZZt6u/seR61nK4+YN6rbAHUXENZm5bCjX8tAsiLy5BTGyGGozaeYJrVh5dOZ6jwjpWbLgrs3F1X2dFGxUW2U1PdKV+jdc9hBFNY2hfwfdQS6YLx8Ui3FEkIIJw38pNs1WCe3gRJzZAN2jxyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DBBPR04MB7898.eurprd04.prod.outlook.com (2603:10a6:10:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 08:46:53 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 08:46:53 +0000
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
	chleroy@kernel.org,
	maxime.chevallier@bootlin.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 net-next 01/14] net: enetc: extract common helpers for MAC promiscuous mode setting
Date: Tue,  7 Jul 2026 16:18:21 +0800
Message-Id: <20260707081834.710730-2-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260707081834.710730-1-wei.fang@oss.nxp.com>
References: <20260707081834.710730-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0264.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f1::15) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DBBPR04MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: 463926d7-1b4f-4b22-e066-08dedc044b0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|19092799006|11063799006|6133799003|22082099003|56012099006|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	/AduczmriW/FnGack4UmRysWf6rb0AwmfpDsdEsE1tjtzAgZ4EZXqPsx2/GgoZnCTeq4HXez4gLBgQ67lseiz7scYvx/0UxNBvgqRooC21XMUjm68Ryt1mhGnV1QUKGrb/Y9bff9WhkLAtL6vlZeoYe1aHnkLxPXwQSgLpazjZtZKRyCtTws4vDiWSH/6UtQJP/uQDd6WlAG2hRXjBkG6a/Qokmg5vBwiYQbYwhJoAYG6M+PlpAEj4DGs+X3TVlfGVbOKcRcEFwv+GCvglOcGVrHLQVdx4++qr9lVc7DQ/ikbC180llu4gYq0bILiBnKg5jkJ1z++agLu1wp+sfSPxIBExqSo1NBA0PhjdP5TLCBT7B1LKTsiXfsL10pzRcJF31pxU+Mwhwy7/nkW1tt4pFYstd/S6nxIn0pdu/l9QqzOAs3MKprUOr9U7NSXYZfDc6ZbgIWND9cxQQ20O0cml0g9ZBSK0DT3xTJkz+p0ukHrgffcRCcxtSxM5/R4LZz9rHghliLADU3JZ4B6P//Xdoqe5xvr2abfF5/ZXIccQnoD8dQNY6m26eoj2oIPuIylPGP0+lJZ7ntm4CnTFFuF/2d8NRJkDGO5dokW3QX7dwklay1XdYolBzxxPJFr2zrJ+9UxfGgs4tF1lb4j3fL/VKYcubYPp4G7KnyVJIBIvzfybLpDAaNGKjRvBxLXUFBpfDxWIB1jDw41FsJMWgXvw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(19092799006)(11063799006)(6133799003)(22082099003)(56012099006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R5nX7VWGjMOztH251TyKCtHeij0rNbVEE0QLUEy+Kt/2tsoJilNVON81rz3A?=
 =?us-ascii?Q?L0ftCBzFvuWaA3RbiFZ5JK54AU1DvaUTJxZL0j6/hTXFiPygnr4mjzq+JEKL?=
 =?us-ascii?Q?y0OYgHl3hjFvxm58QzYYajxZ9/VSNp8F+XMCaGrz02aSVWK2t8NjbQarlOBg?=
 =?us-ascii?Q?0fsf7z9UbG3kEwpXZrgcK/2KS+BTZGaTTXoTwlR0HrV5z77hPrYjgLNNaEZh?=
 =?us-ascii?Q?oI/aESfucocSup5lASAStTcO4jFRioPZUzgts3tO9YI/kYJUeiJZ/9ztWpW9?=
 =?us-ascii?Q?t6Fye2Q1Vp37KNJKN1t+yYuMzClv02VRs9v7nwLMtdHD3FTLEr7ecU6c+4NS?=
 =?us-ascii?Q?v0lXhwlXmVS5E7gsyjbIeqkcItaboG0qRmd4HyIy4THVj/SAvuTbeYFAjtCP?=
 =?us-ascii?Q?VE1++gZcJCppZaGUYoHLrVribabT5GJdsPViScvPUtPzfoyJr/j4dwu1+HOH?=
 =?us-ascii?Q?XDL9GsaToPk7UmNX+OPoQoAK02wbdUKUgBHUkxhn955djNXBdH2WGTFnLqIE?=
 =?us-ascii?Q?Rkz7Sr1KY6ZSGIBDCI6TE/rwlJ3gnmxb5QQP1EQjZWtFKUqMyhNArAovjknP?=
 =?us-ascii?Q?qvn9S2XArie9tQayw5+gY5HzAF/TRJcam9e4EHVc9Q9zYJhag+vTI4AyU5fc?=
 =?us-ascii?Q?1vAhMpRJtVd2M0oqzIAbV/833Lg6JF1ix5U/4Kud0VcGxRM5SGyaoFM/MZx0?=
 =?us-ascii?Q?e2HxDDm7M9n+XUXgGwSU8htfTPMbvEs7GDl2nLsf41LME7YgKXAnF5SIkjq8?=
 =?us-ascii?Q?Qfm2GWm30Be3o3hyJMTIAqBuhnqxlNRPJs1oEy9ziExG5t1nFonFsUe0GFBS?=
 =?us-ascii?Q?lmAuH2EuT+gGqJFQnDCIhVK0k4AD+htsjMXgf2fkUrw9qgLDQy5OI+lUAXoc?=
 =?us-ascii?Q?7JZinjnlLFrYa9/8++IFFkdgBSEvSOckUcba+AgcABnAcvZwN0sp8Yx+X743?=
 =?us-ascii?Q?GEJjQqxIZVVK5eMWz7TDmkbSUq5TlOmcsqqx9vhunEvkJXUw1PKsBFCI1tmc?=
 =?us-ascii?Q?8pc/otBs/ty8SMSMW3g+UVM9VxA4+NbUd4I9Kn2VISVYPT3EH+zM3pd5U0op?=
 =?us-ascii?Q?+g072K0eTHv0F5qRBBQYOslkJSG24yiSPWxRS85NVVqrXOG3U/x5/UXpEs1g?=
 =?us-ascii?Q?O8kcdoaJA2zfoYfDr82xf5QsYgcn1VvNDfWd9n7m3LUY6BONWpaDfQmMkU+u?=
 =?us-ascii?Q?bA+1VhXYRWkT6TXbp7Em9VkNm33Vk2gWizbSyaPSTQ0wa4IwKYBGbWmgOnG5?=
 =?us-ascii?Q?s2Ar+8C3vs7mmG2O7kUNYza8LMXodU1CLuMeJzSV91nQhy92aL6H601BDtA7?=
 =?us-ascii?Q?49KTLhGku+X/N4/HJasKpxmf6kZm33s4IaGuDofMOLiWxsljVSnmD6ldgsWD?=
 =?us-ascii?Q?T1yLT5t3qewUaDoWGrS/Z8H3M6dAGdkwgqO4OwKenBB+Q+M2Xe6wLnAJ7pr2?=
 =?us-ascii?Q?TXwBCC92aClHVXUB+RR8CQxezovfjWP3L8g2AG0mP1sPixmrEyzgDR//gFS1?=
 =?us-ascii?Q?BU6z1dkKDHkpU/LUlRD812D8g/lWG4W5RRn7yWRVk1sBDRyi4QTRx5geDohZ?=
 =?us-ascii?Q?cB3xr0g9FJy9Bwzj76rfZOC287+P8bidJxNZ7UrwVklmWz/f3dQJavsKNbS3?=
 =?us-ascii?Q?zZ3KsFIog+Jo07WiT6eAETvupLbTQ7RXNc+U5ELfFNgdFWWL8j0D682KPEiR?=
 =?us-ascii?Q?VBNvuSuM0btUD7Qz+NbtYsIaEJpUz11QudVXaFiqK1ieJQPWzwRGJuez4HMt?=
 =?us-ascii?Q?5Q8yFXAopeJXz7SB9W1pVuW2YbcXzZQXgFnv5NVvEyH+0qYzTw7t?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 463926d7-1b4f-4b22-e066-08dedc044b0a
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:46:53.2000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/46LJ7GD9NnLKjEEl0KhdCz9eisg0Crauk5N6rj0LU2kDRTIpehLsG/tB6wB2+jxhI7cBVr0pCcWpT2XPpNpVCLVEAGsC+wNPiqyXq5ST238LutAZeeZ8lgcd/pxu5O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7898

From: Wei Fang <wei.fang@nxp.com>

The PSIPMMR (Port Station Interface Promiscuous MAC Mode Register) in
ENETC v4 has the same bit layout as the PSIPMR register in ENETC v1: bit
n controls unicast promiscuous mode for SI n, and bit (n + 16) controls
multicast promiscuous mode for SI n. The only difference between the two
hardware generations is the register address offset.

Since the register functionality is identical, the MAC promiscuous mode
setting code can be shared between ENETC v1 and v4 drivers.

Rename ENETC_PSIPMR to ENETC_PSIPMMR in enetc_hw.h to match the actual
register name used in the reference manual, and extract two new common
helper functions, enetc_set_si_uc_promisc() and
enetc_set_si_mc_promisc(), into enetc_pf_common.c. These helpers select
the correct register offset based on the hardware revision via
is_enetc_rev1().

Remove the v4-specific enetc4_pf_set_si_mac_promisc() function from
enetc4_pf.c and the duplicate PSIPMMR_SI_MAC_UP/MP macro definitions
from enetc4_hw.h, as they are now superseded by the shared code.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  2 -
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 21 +--------
 .../ethernet/freescale/enetc/enetc_ethtool.c  |  2 +-
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  7 +--
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 11 ++---
 .../freescale/enetc/enetc_pf_common.c         | 44 +++++++++++++++++++
 .../freescale/enetc/enetc_pf_common.h         |  2 +
 7 files changed, 56 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index f18437556a0e..6a8f2ed56017 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -69,8 +69,6 @@
 
 /* Port Station interface promiscuous MAC mode register */
 #define ENETC4_PSIPMMR			0x200
-#define  PSIPMMR_SI_MAC_UP(a)		BIT(a) /* a = SI index */
-#define  PSIPMMR_SI_MAC_MP(a)		BIT((a) + 16)
 
 /* Port Station interface promiscuous VLAN mode register */
 #define ENETC4_PSIPVMR			0x204
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 437a15bbb47b..304ec069654d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -75,24 +75,6 @@ static void enetc4_pf_get_si_primary_mac(struct enetc_hw *hw, int si,
 	put_unaligned_le16(lower, addr + 4);
 }
 
-static void enetc4_pf_set_si_mac_promisc(struct enetc_hw *hw, int si,
-					 bool uc_promisc, bool mc_promisc)
-{
-	u32 val = enetc_port_rd(hw, ENETC4_PSIPMMR);
-
-	if (uc_promisc)
-		val |= PSIPMMR_SI_MAC_UP(si);
-	else
-		val &= ~PSIPMMR_SI_MAC_UP(si);
-
-	if (mc_promisc)
-		val |= PSIPMMR_SI_MAC_MP(si);
-	else
-		val &= ~PSIPMMR_SI_MAC_MP(si);
-
-	enetc_port_wr(hw, ENETC4_PSIPMMR, val);
-}
-
 static void enetc4_pf_set_si_uc_hash_filter(struct enetc_hw *hw, int si,
 					    u64 hash)
 {
@@ -515,7 +497,8 @@ static void enetc4_psi_do_set_rx_mode(struct work_struct *work)
 		type = ENETC_MAC_FILTER_TYPE_ALL;
 	}
 
-	enetc4_pf_set_si_mac_promisc(hw, 0, uc_promisc, mc_promisc);
+	enetc_set_si_uc_promisc(si, 0, uc_promisc);
+	enetc_set_si_mc_promisc(si, 0, mc_promisc);
 
 	if (uc_promisc) {
 		enetc4_pf_set_si_uc_hash_filter(hw, 0, 0);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 71f376ef1be1..07b7832f2427 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -29,7 +29,7 @@ static const u32 enetc_rxbdr_regs[] = {
 };
 
 static const u32 enetc_port_regs[] = {
-	ENETC_PMR, ENETC_PSR, ENETC_PSIPMR, ENETC_PSIPMAR0(0),
+	ENETC_PMR, ENETC_PSR, ENETC_PSIPMMR, ENETC_PSIPMAR0(0),
 	ENETC_PSIPMAR1(0), ENETC_PTXMBAR, ENETC_PCAPR0, ENETC_PCAPR1,
 	ENETC_PSICFGR0(0), ENETC_PRFSCAPR, ENETC_PTCMSDUR(0),
 	ENETC_PM0_CMD_CFG, ENETC_PM0_MAXFRM, ENETC_PM0_IF_MODE
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index bf99b65d7598..66bfda60da9c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -180,9 +180,10 @@ enum enetc_bdr_type {TX, RX};
 #define ENETC_PMR_PSPEED_1000M	BIT(9)
 #define ENETC_PMR_PSPEED_2500M	BIT(10)
 #define ENETC_PSR		0x0004 /* RO */
-#define ENETC_PSIPMR		0x0018
-#define ENETC_PSIPMR_SET_UP(n)	BIT(n) /* n = SI index */
-#define ENETC_PSIPMR_SET_MP(n)	BIT((n) + 16)
+#define ENETC_PSIPMMR		0x0018
+#define  PSIPMMR_SI_MAC_UP(n)	BIT(n) /* n = SI index */
+#define  PSIPMMR_SI_MAC_MP(n)	BIT((n) + 16)
+
 #define ENETC_PSIPVMR		0x001c
 #define ENETC_VLAN_PROMISC_MAP_ALL	0x7
 #define ENETC_PSIPVMR_SET_VP(simap)	((simap) & 0x7)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 2d687bb8c3a0..a97d2e2dd07b 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -159,21 +159,17 @@ static void enetc_pf_set_rx_mode(struct net_device *ndev)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct enetc_pf *pf = enetc_si_priv(priv->si);
-	struct enetc_hw *hw = &priv->si->hw;
 	bool uprom = false, mprom = false;
 	struct enetc_mac_filter *filter;
 	struct netdev_hw_addr *ha;
-	u32 psipmr = 0;
 	bool em;
 
 	if (ndev->flags & IFF_PROMISC) {
 		/* enable promisc mode for SI0 (PF) */
-		psipmr = ENETC_PSIPMR_SET_UP(0) | ENETC_PSIPMR_SET_MP(0);
 		uprom = true;
 		mprom = true;
 	} else if (ndev->flags & IFF_ALLMULTI) {
 		/* enable multi cast promisc mode for SI0 (PF) */
-		psipmr = ENETC_PSIPMR_SET_MP(0);
 		mprom = true;
 	}
 
@@ -211,9 +207,8 @@ static void enetc_pf_set_rx_mode(struct net_device *ndev)
 		/* update PF entries */
 		enetc_sync_mac_filters(pf);
 
-	psipmr |= enetc_port_rd(hw, ENETC_PSIPMR) &
-		  ~(ENETC_PSIPMR_SET_UP(0) | ENETC_PSIPMR_SET_MP(0));
-	enetc_port_wr(hw, ENETC_PSIPMR, psipmr);
+	enetc_set_si_uc_promisc(priv->si, 0, uprom);
+	enetc_set_si_mc_promisc(priv->si, 0, mprom);
 }
 
 static void enetc_set_loopback(struct net_device *ndev, bool en)
@@ -474,7 +469,7 @@ static void enetc_configure_port(struct enetc_pf *pf)
 	pf->vlan_promisc_simap = ENETC_VLAN_PROMISC_MAP_ALL;
 	enetc_set_vlan_promisc(hw, pf->vlan_promisc_simap);
 
-	enetc_port_wr(hw, ENETC_PSIPMR, 0);
+	enetc_port_wr(hw, ENETC_PSIPMMR, 0);
 
 	/* enable port */
 	enetc_port_wr(hw, ENETC_PMR, ENETC_PMR_EN);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 6e5d2f869915..b0c0dc668e34 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -87,6 +87,50 @@ int enetc_setup_mac_addresses(struct device_node *np, struct enetc_pf *pf)
 }
 EXPORT_SYMBOL_GPL(enetc_setup_mac_addresses);
 
+void enetc_set_si_uc_promisc(struct enetc_si *si, int si_id, bool promisc)
+{
+	struct enetc_hw *hw = &si->hw;
+	int psipmmr_off;
+	u32 val;
+
+	if (is_enetc_rev1(si))
+		psipmmr_off = ENETC_PSIPMMR;
+	else
+		psipmmr_off = ENETC4_PSIPMMR;
+
+	val = enetc_port_rd(hw, psipmmr_off);
+
+	if (promisc)
+		val |= PSIPMMR_SI_MAC_UP(si_id);
+	else
+		val &= ~PSIPMMR_SI_MAC_UP(si_id);
+
+	enetc_port_wr(hw, psipmmr_off, val);
+}
+EXPORT_SYMBOL_GPL(enetc_set_si_uc_promisc);
+
+void enetc_set_si_mc_promisc(struct enetc_si *si, int si_id, bool promisc)
+{
+	struct enetc_hw *hw = &si->hw;
+	int psipmmr_off;
+	u32 val;
+
+	if (is_enetc_rev1(si))
+		psipmmr_off = ENETC_PSIPMMR;
+	else
+		psipmmr_off = ENETC4_PSIPMMR;
+
+	val = enetc_port_rd(hw, psipmmr_off);
+
+	if (promisc)
+		val |= PSIPMMR_SI_MAC_MP(si_id);
+	else
+		val &= ~PSIPMMR_SI_MAC_MP(si_id);
+
+	enetc_port_wr(hw, psipmmr_off, val);
+}
+EXPORT_SYMBOL_GPL(enetc_set_si_mc_promisc);
+
 void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 			   const struct net_device_ops *ndev_ops)
 {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
index 57d2e0ebd2b0..a619fb8fed9c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
@@ -17,6 +17,8 @@ void enetc_set_default_rss_key(struct enetc_pf *pf);
 int enetc_vlan_rx_add_vid(struct net_device *ndev, __be16 prot, u16 vid);
 int enetc_vlan_rx_del_vid(struct net_device *ndev, __be16 prot, u16 vid);
 int enetc_init_sriov_resources(struct enetc_pf *pf);
+void enetc_set_si_uc_promisc(struct enetc_si *si, int si_id, bool promisc);
+void enetc_set_si_mc_promisc(struct enetc_si *si, int si_id, bool promisc);
 
 static inline u16 enetc_get_ip_revision(struct enetc_hw *hw)
 {
-- 
2.34.1


