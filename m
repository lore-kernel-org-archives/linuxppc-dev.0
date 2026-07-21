Return-Path: <linuxppc-dev+bounces-24624-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBFEC4452D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 23:17:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4YDj21Pxz2yfD;
	Wed, 22 Jul 2026 09:16:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784675813;
	cv=pass; b=XKI2GSyUOzHThmgyLPAGZ8lnfkKryNyVRqRp68yIsjEqOUyCSI4vOx5B0ioqGfoIib/1YgDQIs3yN/KrXKjbvVe9w6/rDMK1jFj5jZPydVeU1xhUJfxb0sea8NL1J1EcIBbNPW3MejVt5ewOmXWPEF0mgW8LZUkD72XiCpWivdcTFjiZXXiFfjGngvU2OZjqPwjLk5J2ZwySbwzmMapBU94Wqbktuy+7NuyV3d/MSkRmaUYTCl6qMMMt/uw7yjvyM8bO43cZYIvmyIG4NpIgGWGzNL7cP1obBzr7fW6Fh2Q+Sl5wwYfjBN/tJf4/79A4UZ3NvPgz6kwZQniDjgDrxQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784675813; c=relaxed/relaxed;
	bh=MYB23kwk5aBzZ3ZWy0IJZ4ZcX4vE1Dk9+/eT5zIeQhg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=de4KxW6S9y3Sp/ktKoNUzorsrnND3C5Q7qV6+gqyxCrxNAolIq3cbR/w5khyd8RutUHvSrNz1728XEImfLhiSbzEiotIfPQ5pSLLQPfoKKVa42v1MX/mNEqQVilAEx9E+cm3PLudoFgjuCixghme/rQfFs2DcGx7+E2fkPKHFz+6n8FdKK/iD3iJq58CDSNCjo9J5USSH1xRyakdesDmxrEaYHk8sVtysulPH7wjEMz/57F1mhOUjsPzO06lhxXfWuMUO3M86G18XQhNPUQ7knZ28MkuQBDQioM8v3CNr0WCFsQx4Wo64+yj3Ie5SYvHjuEu59LSduX7K6BGH3i5kg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=oG2Bhm1B; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=oG2Bhm1B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4YDg57P3z2xnK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2026 09:16:51 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/3HSPnwd4wXocBfCOLUsC/ekhyV7sMnCi8c9Bp4nMdvybEe8axGyd9IEiJ1e9XVKsj1pLAxcmQbWVqayeBOtzeOTK6uhWwcSqvfJiQw9C8MztUOh5mS8qYjVmq4NWeXBTLprbBe8qKVZvv5gxHbgZMLlwy2S4WuhTjOLyX9MnpRL9rW66rXaqL6njnh6fhICEcfUbsjx31TCePd9UHBsrFDkqS19HIBnPLy1xPIZJH0kIPdwHavuvbqQCYoRQZKrIzeGoC2BxqOUTSehnDiV+eSZZTDiQ5dg7DUTJVy5W6xpkTVrBHK2AU7AUr7AoD1TLXo5L1pxXdIhBkcnnr9nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYB23kwk5aBzZ3ZWy0IJZ4ZcX4vE1Dk9+/eT5zIeQhg=;
 b=O744GMDEohbSavlFZbN5JSCrhM1rWBUfRmzPBPGN3hF6YW80cVbfhva2nGFn11P42aXWWnS/YTZ5A7VFNYO/2H+Zhbj/YxGH1DYmQrpKF78HZgVrZ/Qh09RpSROyOyS481E4CIgXcQCj1v7INkwikGxixlkbDCrW6daET9wdC+Zvj41Mj9OMBXER7t1tCRmzcO6SpxQpHt8i9AWeWkbrSnCNoCa6TaOT59OX3mX9WMzSxp8bJmhOwjcwft4e0fv5vdPSUso2Nj7Lytz3jqZfq0rKxnQPKW1QKPEcvOjSGa47pEcYhbIIRpwwZQonVEmOVK4Dlq1nInh0x7dqdoe8mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYB23kwk5aBzZ3ZWy0IJZ4ZcX4vE1Dk9+/eT5zIeQhg=;
 b=oG2Bhm1B6dC3PLDviuhVzTSahIXV5SOQcZWccJqAszArANIbN5jiMXnl6ASNNu5Fk1oCQGSNWC1LBfkPa5vO1F0T+RIUJ8nDctt66Cew+NzqAl+NXcKjanLqpDqPbCjBy8spTmaFQfqn61vF5TnrsYAp6O5rRbsFPDfrjoIjF5KFmx1o1FD9IeWej71hMEBDHN67nSf3GkJcYFs6kZ6BfkNUICU6cWFOaSNakYWF6O2eQZe/WEZBC5IjOy0rYEtQnaZDxVRjy8HoqD+Ke2KWYuN0/n6pwXYH6iIppnhrzBzSBBr0j3EXSFg+QsVqXUwBeVuo5EJi8m9gNJPgwCz54g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by VI0PR04MB11817.eurprd04.prod.outlook.com (2603:10a6:800:2ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 23:16:23 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%5]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 23:16:23 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Tanjeff Moos <tanjeff.moos@westermo.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 phy-next 6/9] soc: fsl: guts: make fsl_soc_data available after fsl_guts_init()
Date: Wed, 22 Jul 2026 02:16:00 +0300
Message-Id: <20260721231603.67865-7-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260721231603.67865-1-vladimir.oltean@nxp.com>
References: <20260721231603.67865-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0014.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::14) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|VI0PR04MB11817:EE_
X-MS-Office365-Filtering-Correlation-Id: e5412568-c2db-48e4-1cd6-08dee77e14fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|19092799006|1800799024|366016|6133799003|11063799006|10067099003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	HZMSsrRmvabJGpfR22PKrQcjLZLUBwoPVj/QRsSE6Aj2hvTLSvprA9mAAB2XziO67v+/xaL1RTI4Shr7Ps/s9AqbnXLRZNOMcmGnlt3lhXNQF/PAf/9mE1AWfaHoerrPR+bBaYxhlCatkZIAd8YEEbNp9qJYeqK5ZJjVq4PMBaW0uSEZRIU8dPyuiKBekLFa/NWHdCS6Mw5y/iW1wpzA1UUa8sQpCFt+LGhQ+KYuxlvd8TphjDFGydPoms/wRcYi/Vnb6tw9LLNPjZRXdXukqABGnyNXywM0V5A/DgglxBrSjmTIjeDYYvO5u5GHBXBNqP3OjuUUBnkBl5UdOfNwJGvf+mZS3FdfaQ7vfucsvYhJruAA04jd1TIGuIqlaLhOHXS9bqupE9yqKqbULZlnfTQJpsGJcAkCFJX70m3mB3/10AFgMHBpKQ72oD7rRHjbgI2rKs+kcjrHpNStOoj3I896rRqHYmsLS/+xAd3tMur098zDwenLwnrowQI1SyyG5GF1Cu+K1zY7amjLySaquC8SaIDBr6BKqEols9ybnwGdOOSrL1HcqnLOh8+8R6+DlkFwxnzPO/3PVfgzT9YMSlJH9i3YMQiEq9npt78iGFzMtPs3Q+/7sF2N6yElRL4IKRL/CZgiptDqWav7tDRBMg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(19092799006)(1800799024)(366016)(6133799003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+6j7Sej2e4MmTZJVIjtkpAImsXzBjZgCFQmx0qGmfWtICco2sHn2czVl/Fzu?=
 =?us-ascii?Q?fypyPt7yuucmq2O24XVjooT+8P25fn8k/o1ZRqXVlKPZI6xIlXHhpEMDXUeB?=
 =?us-ascii?Q?Z3JY0FAwLLjiX6UAUSLepbUHHd4VQhGSrVkSIV+l+i7a6qPsuiznUH5gtdMM?=
 =?us-ascii?Q?cbukjTQghX6ucyfbYnE2H9AB7O41BFqAZkhPMiIz+6x7cqkzqCdr9Rpfnf4i?=
 =?us-ascii?Q?BUKl63bl2XNArZLol8la2oK/D8w0k/BCRIIj8BZYzagKRUAtnYL/WsAfe9IO?=
 =?us-ascii?Q?mKfBCZc5OCVWbulaFRbTpiPkIgFbl5Mn1NS4Yj40cswPaYqHzkx06pXVAVKM?=
 =?us-ascii?Q?E8N+3Ry+90pca25e5lHBLWwe2OpruOtpqzgokugbBvrV+WKtB8vvFQruQnxk?=
 =?us-ascii?Q?D8hZQaoBY9vT3STeILhGwU1BFaQm2JHB4LrMXiOgg9U5WTzbaNsOFdUtblkx?=
 =?us-ascii?Q?OQt3r5Gei5RbqpCswruxDd64APOJjtnfQwa32GrXYAVLzJHGJIBKTryKsKgI?=
 =?us-ascii?Q?D7CNpJ1YBvKvswpVI1AMz5z6rpQoRO30CyL5JEyc4rtj/9z5FRryrqRD2sAn?=
 =?us-ascii?Q?o3gbzeGDcQ28D9waZ6QcNNamrrUxh8xCEBUH3thXDLZMVJJhNT2P9D4VLTBh?=
 =?us-ascii?Q?uyhmb1U/ww0oVcPrrabJpgiPr2ea+SmVUv3csvZjVNLV9MAOQcRzvOQaHpml?=
 =?us-ascii?Q?OdEQqXBPZSDpq6/aVzIdRr5uyaLJy6zhOp87SqgcDY0Q9zK1gBTXFEl/zlAj?=
 =?us-ascii?Q?9UePS3QarJVJ9ixzPK8Mz4TLKB2/LgXGItIWgegKubpQ+G+9/B3O5T7EWqfc?=
 =?us-ascii?Q?wbJ8/zn5QFWpZ8og2KsQro4zwkuG4VEEoA1SR8C0wsK2GmSjYXo7S/M/KrkA?=
 =?us-ascii?Q?glfJ+fsRCuqjbWlN/slb0GfWbndFXwg+y2UmD8CiJu4EdwUO/Ddectm4s3eG?=
 =?us-ascii?Q?uvkHeuoItr6XKZaIPElCcXqp4sN/10Sr5NbsmeN7NmAWPHQrX5qs5YBQ/Exk?=
 =?us-ascii?Q?OQO7CMooAa8QQxN+D0mD9VeE56o4HJLlpS4rWMb6TcL0EHN/EAS338LO1IiM?=
 =?us-ascii?Q?H8Z1pe1ORe11zJwbR3Of35vqCgmnP+FTPGszMqmsAYusAOM8rXceOVs3K9oq?=
 =?us-ascii?Q?s2MIIsU+NmpviEUzFIuLQ4h33ZWYaUYImdotYgVCF1ma3J7m6IMSy+e5A1Ln?=
 =?us-ascii?Q?T+AxwgnOzvghRWgZV2JH02YG+O0Mzzrl7uLfOTLmuT16Z2DBIvqDeMpLh7mq?=
 =?us-ascii?Q?ZxnCKN9jNDBOMJiYzuesOOmzqSRbMr7XyURx820mszXJ48dUP7nf5RPSlSnA?=
 =?us-ascii?Q?4WZs/E5T82YvWB3zUOJdu+Tlgs8e9Q02l6XjovdOEFLo1Z8H4BqicyPPc/nO?=
 =?us-ascii?Q?OB55No5k1bKS9eymQEZMCk8MSNvhwMsiAmJ2/C/x4TOCRBAwgBOXdT84RtAM?=
 =?us-ascii?Q?Uw1HtrjrBvDOALcGxrws/pOJGXxN092UiCJ6vr09plVklY9xtcjF0nxQozMI?=
 =?us-ascii?Q?RqkC0QS7HBSI3I9CdVJN162f/j5DuoFKiZRhrGi7voHduQxst7Rvf6IJJa8C?=
 =?us-ascii?Q?69gOECbCV5Hh2XRYsfNieUhGo2QLxkebwnoAwzcivSmznS5OlRr45BpvOL02?=
 =?us-ascii?Q?YI5IwuiEKQa0xOoYayh0am0v+FQ+BNPG18Mrt3kAWEPvHz0z3o0hVq/Yy9ek?=
 =?us-ascii?Q?8ndnTStsp6WBq26Swaf5+dphOBsialU8HLCRRX98WRXDTJaXa65QY0o8deAi?=
 =?us-ascii?Q?p0qbQzPyTQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5412568-c2db-48e4-1cd6-08dee77e14fd
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 23:16:23.7968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lCUa9Er45jyj0dgt3Y/6YFArAgQY/dYuNAOtDptJMMStNK1ZuoTFtkBHoEJRVt6z9slblehwZA+5R/P7+iMmQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11817

In a future change, struct fsl_soc_data will be extended with methods
for performing RCW override.

Since this will be performed from a calling context outside
fsl_guts_init(), we need to keep track of the soc_data that we determine
at fsl_guts_init() time, so we can reference it later.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v3->v4: adapt to new error handling scheme
v2->v3: don't leave soc.data a valid pointer if fsl_guts_init() fails
v1->v2: none
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/soc/fsl/guts.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 15674c6734c6..c283d44b68a3 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -138,6 +138,7 @@ static const struct fsl_soc_die_attr fsl_soc_die[] = {
 
 static struct fsl_soc_guts {
 	struct ccsr_guts __iomem *dcfg_ccsr;
+	const struct fsl_soc_data *data;
 	bool little_endian;
 	u32 svr;
 } soc;
@@ -231,10 +232,9 @@ static const struct of_device_id fsl_guts_of_match[] = {
 
 static int __init fsl_guts_init(void)
 {
-	struct soc_device_attribute *soc_dev_attr;
+	struct soc_device_attribute *soc_dev_attr = NULL;
 	static struct soc_device *soc_dev;
 	const struct fsl_soc_die_attr *soc_die;
-	const struct fsl_soc_data *soc_data;
 	const struct of_device_id *match;
 	struct device_node *np;
 	u64 soc_uid = 0;
@@ -243,12 +243,13 @@ static int __init fsl_guts_init(void)
 	np = of_find_matching_node_and_match(NULL, fsl_guts_of_match, &match);
 	if (!np)
 		return 0;
-	soc_data = match->data;
+	soc.data = match->data;
 
 	soc.dcfg_ccsr = of_iomap(np, DCFG_CCSR);
 	if (!soc.dcfg_ccsr) {
 		of_node_put(np);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err_clear_soc_data;
 	}
 
 	soc.little_endian = of_property_read_bool(np, "little-endian");
@@ -291,9 +292,9 @@ static int __init fsl_guts_init(void)
 		goto err_free_soc_id;
 	}
 
-	if (soc_data)
-		soc_uid = fsl_guts_get_soc_uid(soc_data->sfp_compat,
-					       soc_data->uid_offset);
+	if (soc.data)
+		soc_uid = fsl_guts_get_soc_uid(soc.data->sfp_compat,
+					       soc.data->uid_offset);
 	if (soc_uid)
 		soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX",
 							soc_uid);
@@ -323,6 +324,8 @@ static int __init fsl_guts_init(void)
 err_unmap_dcfg_ccsr:
 	iounmap(soc.dcfg_ccsr);
 	soc.dcfg_ccsr = NULL;
+err_clear_soc_data:
+	soc.data = NULL;
 
 	return ret;
 }
-- 
2.34.1


