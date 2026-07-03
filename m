Return-Path: <linuxppc-dev+bounces-23490-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30FB6C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 10:43:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gs9MQ5TwWz2yvZ;
	Fri, 03 Jul 2026 20:43:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783075394;
	cv=pass; b=FZwWKFcaTHtueyMEV0x+MbGRfnNEWKNKorism4qmsG+QzFnKTFjK0HCH/gdEO0CKhdMKUH+/ybw37ApHk0CWgFxDaiO6SOvfR0IYsXcilJuWJtk4WWB4HlAUCmH+VAGrNA/xz588Kvl6jFhqLJL35lIFDq7jjE/cLOFDL5D+RtciDVLd5hAQL3lSaeREECB8Oc4SS92A8lcuobK0BcDpvnYW85HPur5kX/3h3TU+hiLlqo3D5+TVNy3tkCVVnqjcN9SH4zxM+uQLkclstnO1dRT/Umq8Qbbm4wy7R4pmrOC0PX2B5pdmJ+KAR51deOI9DKYl0knKDq0K4HCWPpzSeg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783075394; c=relaxed/relaxed;
	bh=8CT8bO+ZvGjCsF5hZO2ObMW4OE9iaBDYdR5oCZ9JbCY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bN0FcI9zvtnLIYpYUUZCuMd2GHnAYe8I7dESyz5Zf2rKAXB6nH9DQUHylj5bsEsOMt5aXcqs9rI2dFI2ssNwTz8OSeWK7u8WIKiQGMWe7VVB9r+dy3gIu2tky7QJX1tpV49cUoHMFlLjS/jhqQiW6d2x5O9PXiEWxwZF5oXrY2MzGHi2tJxzuBkyHMapzK6Wt2So0dPhXpAH3upohkn/QkZcVo5R4klwxOsSXQ5BdkD1H/Xpn1XtUpH1DkS7RCaurBAoeLVR0oN+y8xEnt1oeSC9OMCg+O8DGj2aIMMdr5V7bJ3QThPqCllf72qh4YWuDf96Bw4N1zrcP0VUy9Y4SQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=IfiIswlo; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=IfiIswlo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gs9MP5mQQz2yx7
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 20:43:13 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgqkjRuxE21aMRToHZ4DKmGI+rLLMz9+/0OP9hDOgC5DsJ93P4vfBVg/9mojrPf3Qm7/HgPKVo3RlnEe4Br7tebUxBKQbIp+BNitUV+Jo57CCB2y5akQqq+LpK8QfuEqh9N4+zykxaripIN69sMvILl5lZAMQEQlhWh4BLaEfFU0q4vO7IigpRtYMEqZhEaYIeyy6aQoJ/JgTpu7c3HFCSla3oelL3b4mCbQ+MM1Gv5JUcJtvzBg5nJi39zJr0eX5197HJJYSLi5+zYNVgOGg913XCMWQ4P4NFyATJTflua0RKficE3gWUhovipuv/kDCUPhZT7GrrSFppVJZFQwJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8CT8bO+ZvGjCsF5hZO2ObMW4OE9iaBDYdR5oCZ9JbCY=;
 b=PqLtm++XUfQB2696I6pfPBdVtB2kWYZM8RC6lxaflH991LUHZuNPJYctgUthD+xA5NLR8EOFdsN8dF4OKNZPk+mJOToPDhXuh2rEfda0yUFXE+ZgPGW+3hV/JJyeKMYsDNisT+VbRbV3w+LDaDo/ZxCy9qbXOGQpevNYQtvqSkbDJH4eCq0RBNMXLe6SjTiOF0g7XFBIk9c9K/dcqDtP6e4Ffa4n/kXShArrFEV7jGTSWnoyrT9CVZ17zZoB5zQ89uj90VtsuXCvbquRLnWpL+325Wt1/RRryw0VS/vxDkqssJtkI7l36lhQ3Oaf93+goEPMZzl9Kp3It3T/4ka8eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8CT8bO+ZvGjCsF5hZO2ObMW4OE9iaBDYdR5oCZ9JbCY=;
 b=IfiIswlore9wGfeTOmCGsKxtUxP041MwQw0twphgEWxBXWkestobx+e2TH9xBt++yN45/yHBOk/tl/XXdvkxyj231H6SJtStAz/UhiC+RIgribAr7S+U3oelOG0Te6q8abU7x0KvHP3gjiZoh+2xOYeiKp9cJuX/Ese1po6mSQx1nMRX8BAvQgg2Mj1T3dX5ECwp3AyIfd9Ho8wHTk3yacWqIk/ApqRRvm0v2ZuzqUoLrwb3iDcZttgZbKhx5CBk9RWQ/nXr9MFBk9QTzuw0pocyEAuZszYElWuoGRucPz9/YQaWKoRHqiAXmZZw2E7PWrMFb2JtBFO0JKbMD/qXXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PA1PR04MB10867.eurprd04.prod.outlook.com (2603:10a6:102:483::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 10:43:01 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 10:43:01 +0000
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
Subject: [PATCH v3 net-next 10/14] net: enetc: refactor SI VLAN promiscuous mode configuration
Date: Fri,  3 Jul 2026 18:13:24 +0800
Message-Id: <20260703101328.550714-11-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260703101328.550714-1-wei.fang@oss.nxp.com>
References: <20260703101328.550714-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::8) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PA1PR04MB10867:EE_
X-MS-Office365-Filtering-Correlation-Id: af9beffd-564b-4335-1aa7-08ded8efdb05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|19092799006|1800799024|366016|921020|5023799004|56012099006|6133799003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	J/lbYXvDrSs5n+E9ExgIfzOU4w0IMQUl4kU1/RaTw3ocrwNbTZScIUFh8Uq/QoggNaDeaPBnvZ3Ix1AtEUaY7RcNiRCOBQOgIov7Xay/L4JU3SG+4HpVsgp6qqp6ah491m7eCpoIop4+HRDWb01EnYW+9xQLFOdvbl0gqZ4ibX4oTPkmgGHKUhNleluGeUNialXplwCGUZpfLsTODr5Q/Y0PvcztIIMf2PA9gQc40WJSaagy+GNDPlMu0ENENLe1/cF+FEKfsgOnskoDOzIQvgFvqYNYNOIosqORAVNfJGPErBxj+EPXHA8bsXud2Q5n2JoOyIlbTIIkvguuubZ27bSRAX3MkrxnWMpcaleXS9P2q1LmQF7Vr/ysEut14MvIg2CoHt8tXEA3t1fE9gag3oG/LV8EjvPIWP7AdD3xKaGbb+C1RjLvQxFTQsbvkMJsVQzMDzkCdDb9TVs6huhPdlPCQDQtOz3UsJ86LGe23WD2Q7j6A+w24xgZjX70UT6rLxKbdFJPNCijRZYjWPS0zuoioxo58P5auMf9Vo8bJvtzlsv6AAlhXjRHnrIHb5LcXcR1qO/EsF2sZzEUW6Jrzdl4K7kaM3LJjIh5i+vUlMjq0/TVcv9Yg610winKlHHIMK/Vw7Ni8FGnzfBgLtZ0jAwPOJmihOZyGvOBWiRItXYG/8g11j408bsa3jdqKPg5ezREJRAxdqzo0uVU21SM7A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(19092799006)(1800799024)(366016)(921020)(5023799004)(56012099006)(6133799003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yYVPQexZIL2ppaDmCtCerT/Wbn43b5D9m5j+gFPuCEw4Fy0jwjgutMttGqn9?=
 =?us-ascii?Q?bkf1fYmXIRvXaBx2AfhXTp+YujQQDfCTQxxUHBMmPFsw+lcWTl7bdCCGND5Z?=
 =?us-ascii?Q?8QcacdakrS+YXn9N4tJQrT5Bq80tGTJQAHYWLU8NYAi6rLWABl+xNtYIPJn9?=
 =?us-ascii?Q?LhjjrQS/eV10Jb/ncHppaGlAt+AHcI064695o+1lPynmC77pqfpHypLdwNhA?=
 =?us-ascii?Q?ri96GQ/kcCNzVcw+qGvf3KEoLS6S1ubdgnMIOsI/51YzCam5uDmdYvar8WdI?=
 =?us-ascii?Q?SAcy3rhVnZ1X+FGQ96cRVoH7SUcZKjV6yCPAYj7I3j+XGxX66F2hpq6avUT1?=
 =?us-ascii?Q?EAZYMeqjauaM/3MJTGX7wHJxWHq1O6PQGdwF3njLe0qCrQdk2M6YTR5Erfcb?=
 =?us-ascii?Q?e2o7zK3lhf6pykH6hL3WQluFXREe5DT5AngUYL7/WXOzIc78vXgimhoMwlee?=
 =?us-ascii?Q?PXZXX4y4aB6P+TloNSs/Cak+bKL+RVAdbpciNbvmx4cC7lsCi3qI9OU7cV5n?=
 =?us-ascii?Q?38CikacPNfKbDknkzmqjH/L4uLuA7tCZvGnYyiGg1V+DVsrrFk0DPjxIYz25?=
 =?us-ascii?Q?v8KBUGJsMHMtq9xUf1LvU89xt7WaSGurJOZdFEkCPAOXBW5T4KC1KZj6WBN6?=
 =?us-ascii?Q?GQe25Im/YYxHifIERztLS9OstGmzToIQ4DRkCZandfAQPFD46bSnjVQSXE0v?=
 =?us-ascii?Q?psDNlU0VnfIJbpXee6kJd5rGQRX1qepI4Yon64S1obZhhKnSPVFtyA/VcNr0?=
 =?us-ascii?Q?si5TMWPqEmuk86HLsT6Q+KwOLErUtAMUJnG1Is4sbqqXSZffDohI9oIR4RsM?=
 =?us-ascii?Q?M8Az5GZE8QXR5QEVs6Lg/xAjFq7worTQsqeWP9m9yft9zz/GIUZY40vqMhUt?=
 =?us-ascii?Q?Z52tPVFWuu+J29KS3lbqISO/FASL+YEVWY0XazNVHMcGBT/Jwd037Au/ETcs?=
 =?us-ascii?Q?yHETIzYzw5EdUrsvK3VlJM5aiBjQEgkpZPxaYYxK11BemyFSjPfiYpk//zyx?=
 =?us-ascii?Q?NKGBiyukohzOvxWycYAbGGQXWmQzZ7RApeCcRV8MvycGMzF/J86L5W03iYvN?=
 =?us-ascii?Q?fh4W7F//MP2ym691Y/GVg4Ood40e+CUKjnon+Y3ObvPiUwz5XGqlkCdNbTQw?=
 =?us-ascii?Q?gzc4S7YwsWW47o7g2gkORFyMK2usMz5IYyjFa7siOa/BZn8uro73p+R6/v1m?=
 =?us-ascii?Q?sQcJCrR+PttwwgMWhvl5nDPueh9U0XA/VWUQpFnOsJT5zt8Uy8tuHkkbRxVe?=
 =?us-ascii?Q?FyNQwDF42QBG0dX/s/r/HapAZnF0w1jasYKqaHdiitI3upsqeW8UDn4flOTe?=
 =?us-ascii?Q?L70/jIcb+Kl+xDb840vPeSdZEur1KX/KPiCSxKggd5g1zJp2vT+knox9zYVS?=
 =?us-ascii?Q?mCCKyVjzVcixzSQhGYPlmMkzmVUYh/jU3lsIY3hs6E+FsMXAk4msxz1F3R6p?=
 =?us-ascii?Q?OGsmY4eP188mY70VSn9bThiLcnVWK3riHxEx/gyMx2ZphK7e1J0wTu5gxUje?=
 =?us-ascii?Q?hxqRvmsEqoGOPgGlyQmZqgXO9Mpny3YgXDBlQdOiGy7uIJT+xZGdFqpDpKbW?=
 =?us-ascii?Q?UX9JBU3FnbcqI5iTbLT3jYslYDkau04JBzNTmqdCAFN64J1U/VvxUxvGB9k7?=
 =?us-ascii?Q?cPLn3fCb208E4fKXuVxE7tAmI6giYRbgeZqk5Rg7PNUUZrc8CmrbgvAqHl6K?=
 =?us-ascii?Q?bd3vGIas7NUPfIkSBEMh8j/gC+Mj8YHCnzjD2fQ7GSF/luZ21u98RHSqpH3/?=
 =?us-ascii?Q?X7dEl0vkrGuYhi2QGf+wXzVaCn+ylG5fk/bEDKAgVHmYT42U72/t?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af9beffd-564b-4335-1aa7-08ded8efdb05
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:43:01.7691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: djMFtv74JQQHJhyejLp6ek82QAbBWR/EC+gnAMxhsxVnLc4uI3/ZfZOZNiJh/kZy2ucqTMGh/ldy7nd2COF/ZZIDm352bILu7ikClahHVoYHllmv3Z2VXT3/oOPgliz2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10867

From: Wei Fang <wei.fang@nxp.com>

Remove the enetc_set_vlan_promisc(), enetc_enable_si_vlan_promisc() and
enetc_disable_si_vlan_promisc() functions, and introduce a new unified
function enetc_set_si_vlan_promisc() to enable or disable VLAN
promiscuous mode for a specific SI. This simplifies the logic and makes
the interface more straightforward. The vlan_promisc_simap field in
struct enetc_pf is no longer needed to track the current state.

As ENETC V4 only changes the address offset of PSIPVMR register compared
to V1 without any functional difference, enetc_set_si_vlan_promisc() can
be moved to enetc_pf_common.c in the future with minor adjustments to be
reused by the ENETC V4 driver

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  5 ++-
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 36 ++++++++-----------
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  1 -
 3 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 66bfda60da9c..16da732dc5de 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -185,9 +185,8 @@ enum enetc_bdr_type {TX, RX};
 #define  PSIPMMR_SI_MAC_MP(n)	BIT((n) + 16)
 
 #define ENETC_PSIPVMR		0x001c
-#define ENETC_VLAN_PROMISC_MAP_ALL	0x7
-#define ENETC_PSIPVMR_SET_VP(simap)	((simap) & 0x7)
-#define ENETC_PSIPVMR_SET_VUTA(simap)	(((simap) & 0x7) << 16)
+#define  PSIPVMR_SI_VLAN_P(n)	BIT(n) /* n = SI index */
+
 #define ENETC_PSIPMAR0(n)	(0x0100 + (n) * 0x8) /* n = SI index */
 #define ENETC_PSIPMAR1(n)	(0x0104 + (n) * 0x8)
 #define ENETC_PVCLCTR		0x0208
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index db2a800a7aaf..afc02ed62c77 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -42,24 +42,20 @@ static void enetc_pf_destroy_pcs(struct phylink_pcs *pcs)
 	lynx_pcs_destroy(pcs);
 }
 
-static void enetc_set_vlan_promisc(struct enetc_hw *hw, char si_map)
+static void enetc_set_si_vlan_promisc(struct enetc_si *si, int si_id,
+				      bool promisc)
 {
-	u32 val = enetc_port_rd(hw, ENETC_PSIPVMR);
+	struct enetc_hw *hw = &si->hw;
+	u32 val;
 
-	val &= ~ENETC_PSIPVMR_SET_VP(ENETC_VLAN_PROMISC_MAP_ALL);
-	enetc_port_wr(hw, ENETC_PSIPVMR, ENETC_PSIPVMR_SET_VP(si_map) | val);
-}
+	val = enetc_port_rd(hw, ENETC_PSIPVMR);
 
-static void enetc_enable_si_vlan_promisc(struct enetc_pf *pf, int si_idx)
-{
-	pf->vlan_promisc_simap |= BIT(si_idx);
-	enetc_set_vlan_promisc(&pf->si->hw, pf->vlan_promisc_simap);
-}
+	if (promisc)
+		val |= PSIPVMR_SI_VLAN_P(si_id);
+	else
+		val &= ~PSIPVMR_SI_VLAN_P(si_id);
 
-static void enetc_disable_si_vlan_promisc(struct enetc_pf *pf, int si_idx)
-{
-	pf->vlan_promisc_simap &= ~BIT(si_idx);
-	enetc_set_vlan_promisc(&pf->si->hw, pf->vlan_promisc_simap);
+	enetc_port_wr(hw, ENETC_PSIPVMR, val);
 }
 
 static void enetc_set_isol_vlan(struct enetc_hw *hw, int si, u16 vlan, u8 qos)
@@ -441,10 +437,9 @@ static void enetc_configure_port(struct enetc_pf *pf)
 
 	/* split up RFS entries */
 	enetc_port_assign_rfs_entries(pf->si);
-
 	/* enforce VLAN promisc mode for all SIs */
-	pf->vlan_promisc_simap = ENETC_VLAN_PROMISC_MAP_ALL;
-	enetc_set_vlan_promisc(hw, pf->vlan_promisc_simap);
+	for (int i = 0; i < pf->total_vfs + 1; i++)
+		enetc_set_si_vlan_promisc(pf->si, i, true);
 
 	enetc_port_wr(hw, ENETC_PSIPMMR, 0);
 
@@ -466,12 +461,9 @@ static int enetc_pf_set_features(struct net_device *ndev,
 	}
 
 	if (changed & NETIF_F_HW_VLAN_CTAG_FILTER) {
-		struct enetc_pf *pf = enetc_si_priv(priv->si);
+		bool promisc = !(features & NETIF_F_HW_VLAN_CTAG_FILTER);
 
-		if (!!(features & NETIF_F_HW_VLAN_CTAG_FILTER))
-			enetc_disable_si_vlan_promisc(pf, 0);
-		else
-			enetc_enable_si_vlan_promisc(pf, 0);
+		enetc_set_si_vlan_promisc(priv->si, 0, promisc);
 	}
 
 	if (changed & NETIF_F_LOOPBACK)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 7e886dc49997..1bd3063a3be3 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -45,7 +45,6 @@ struct enetc_pf {
 	struct work_struct msg_task;
 	char msg_int_name[ENETC_INT_NAME_MAX];
 
-	char vlan_promisc_simap; /* bitmap of SIs in VLAN promisc mode */
 	DECLARE_BITMAP(vlan_ht_filter, ENETC_VLAN_HT_SIZE);
 	DECLARE_BITMAP(active_vlans, VLAN_N_VID);
 
-- 
2.34.1


