Return-Path: <linuxppc-dev+bounces-24461-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8DEC44527
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 09:51:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3bPw00Zvz2ySN;
	Mon, 20 Jul 2026 19:51:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784541091;
	cv=pass; b=cnkh7ZQVAUGWI2CKUCILEV6rOwfcjC3fbbHdp4FOaSC7Yy0vj4guuclG0AUm61AmaYblW9kI7eFEjgSmE54HZqARmSTCPJtZGI2VHTESqCQFznp5Xh6lFr9MG7yHGm5TmDap27DVn+dM1+MO2NyMjxtYqG/3OCaK5w4tiUOsgs4TwZ8TisGyWtNcgd8mAEPv/MA5rdBBpTWbgHFyuYAzwqpe5RyKzziIf5RBmo8lOaobsnV+FEc9wv2AqFN2Y3pFLMf5DOY5T0dlAJQsrubCvP9Onp8v9p44XXKZAJRqXADI8n0qu/Abv4Mq5TF8GdtmhQhg6n2QcfRCkIMuFxEGDA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784541091; c=relaxed/relaxed;
	bh=rQiAL4CKbg2qgArn8GZ7Bgk6wQR89Ng2b1TISu00dsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X7hwCA3ZghEY584tKErCWksoBwJ0Wsf4UDQlfuMPFkRNOkGfP0OYqvvGuoEH42dzei7Bgxf9yNYdtsXGN2c5GJly180FBMje0aIbO0Du48Jerd63OxzDrWlJBkmTe01Se/DaO5aem/7jgkL6fpgqzNLqnfPYmBbaLNzKG99fAQommLb2bMaeWi7uvoxmdQuDJQOjwLE1myRdPROxKE8utjOlgRCl0WaHBPVxVbhWWIHIe764Vu6FMVI1vjXUYv/mkBpbkSpAeOw/lSnNUkpDZwgRjw15SogBSoHmp7KWFSm5CmWJNVYaLxpMJljMMQx+3Dy9zOpdfomPkvVtlVPinQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Y7fOqbM7; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Y7fOqbM7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3bPt6W3mz2yYY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 19:51:30 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HwSkXvRWzVoKuAMtZbZ5LrQmN9yqPrvGiLA5X0pIBDfOKbboSRYjMn4RS1GGgNCRQtUU5/xSVHJyhVNzCUAta+dZUd0spNJ53uDTZPaYZioyuwPnr5sryM9piDJFt2nXOrFpF4T9axRZedxhQsv5DhVCHkRYgIKb7kdNfG9+rJ0Yw3EfZJlDq+TgUcevuBbJx9lJ80/2rfBgDjFFr2TrYBAiYptujYTkaWepdAFDvo3u1tt5bIUUIW5JMLUeBrzWC4rG6QU6tADZXj3LwSjzOGmOdqMD8036drObLZ1aajrIbuKJNMh44+uxZRWajpVngaZBRiq89qTqUzmGQInKug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQiAL4CKbg2qgArn8GZ7Bgk6wQR89Ng2b1TISu00dsQ=;
 b=h456nUW2lxnxkvyOnyX9tZb+awNRHkdoM4uyFBUUQ5JT7tmwMQoZIfNgcQkCm6N79A5z2MN67nA1pWLSpc65RvSOlLDm7kd3lVTR5xmQJoNt3+LSPj4sAoc/EyV/auSVPjigC8gT5bUMr1F9nIB8ja4mjrDH0bxMLyyHjtseeDp0b1noCn7hYJzl9tnB5EnchnnmogckNSYfDeDpE342fIOt38owrNfDxMmkyLnYbhdp2mikOaEzPlYao+pkKW6Z7/T7ZrnW3O19Z1UG9OnuosF7f4xCMPlzasCjYHwod2cjQo55GRZQVsB25l/oz9ZITyFMMWzawf4eUBA5lei65A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQiAL4CKbg2qgArn8GZ7Bgk6wQR89Ng2b1TISu00dsQ=;
 b=Y7fOqbM7zBP0/g9pioVdCMaadloXM+0/KbAk/5zjW3hmW7R6rE+u6G375w2sKiGZDqswdrlPmjavqJdWsO6KU4kJkoFo0bX6UQ79rKGU7PTBCUvaZaf7FD2WY5+lAdg7YbVsIfa/ZqaVGblj0yxaSJ50vo6smQCUPgjcqJaY3uZx7Ad5Mg87bgsClZVc+1XOe8mV2ce/YB89gCCfBilXAnthSelaVjbaQ+KxldsteQYhxy8+F47Bv16ra7T5NbCyPRiXNZjrcf4sSvWMmHpqU2rDIzzalLZAmpgI4RgiQ4apPY+R+3YYXpt17ReVh6GUIsJSUVXWua19gqr3akxf/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by AS5PR04MB9800.eurprd04.prod.outlook.com (2603:10a6:20b:677::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 09:51:14 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0202.023; Mon, 20 Jul 2026
 09:51:14 +0000
From: shengjiu.wang@oss.nxp.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	shawnguo@kernel.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	nicoleotsuka@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linuxppc-dev@lists.ozlabs.org
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: [PATCH 1/4] dt-bindings: sound: fsl,imx-asrc: update port binding to support multiple pairs
Date: Mon, 20 Jul 2026 17:54:47 +0800
Message-Id: <20260720095450.1618747-2-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720095450.1618747-1-shengjiu.wang@oss.nxp.com>
References: <20260720095450.1618747-1-shengjiu.wang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::6) To PAXPR04MB9351.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::17)
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9351:EE_|AS5PR04MB9800:EE_
X-MS-Office365-Filtering-Correlation-Id: f16bbb97-c666-42e9-a69d-08dee6446ec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|19092799006|7416014|376014|10067099003|6133799003|3023799007|56012099006|11063799006|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	YlOSOE7I2uPuCc4nkr70w9sTxAIoG/N5I8huSpUQynvLkxK5G0EmznrQWuZwp1mVacZ/Fyttdpoa80meSGkpABuuPO9IJPIYjJ7y8sVePnT+PJmaQ2LKGvi0aZ0JRAINyygXo65MjaxTdcK1/K0vnd9kr55RtBX1eqKEaTAdMgKKc+TVnRZhVmhSbWx5RLc76RjBckctknGba+jhP+3XRdWZ/3gKsrTVhi19AM9bWk5QD9Rko8DgNVcpacr9JYEZJKNi2UKbeC71AdNAofmqxTOX64JWtt87b6qQWqxSNiWCMwDQHXkb+mV5nUgTtix2z0NPlu6R5aVd1w5r49cvNPniv2XH++y3ByU10IC+egpBA1+g5zmyt3emGOmJNBEO6AK/KEcOQvcEx8ZQr9AqNRbklfo8ls+vjJQgpuQEPa2Z0BQvwJ8YF2d6ljptzYWp7MOES69u6CMVUHn8Gkuhl6bjJlciO+L8KoUVEkkrBx2EVAcGQhCb5XkLk8vUptZtGz1mQ5T7csGFeJxLUC1b/EHKpq4C/LmfuE9Obcs244vzmvKjMq8n2r0iz7lU9f8nmWa2Rs95THmZV3k4gTAI5dVH/gBshWii5cNHEUOgebfWdYzjoUW9XU1mMeSY665122MUkiri1rJ+jfbmA7YAhdf4q4BLRYqh5zK6Cburb7S+6YgLHqRBjaTykZKOfkIjzbP6O+VtzTTR322ItCe/gg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(19092799006)(7416014)(376014)(10067099003)(6133799003)(3023799007)(56012099006)(11063799006)(921020)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J6i+1BpbghnHUZLDG2wmKLuwIpUJw7+q5PO/Rf4z6WVCoMoIv3wHEK2JYRue?=
 =?us-ascii?Q?SyVHd2DdRL6YSU387fnL/HKqBPcUr0rJrQgQN7KQw7Mvt5QLELy1vMqmwLaW?=
 =?us-ascii?Q?7Ki4y7rk/5cwh4/OGgwiQnWyznGAG4GdZv5L26Z6aqNKb/J0p5fXkIOid0pA?=
 =?us-ascii?Q?b5v3UoSh8PzCRsQssARmtS4gkgkC016OaRp22NJqzTpz7o4nUsZbeO3Mt5vT?=
 =?us-ascii?Q?fHOiN03HIGbgPehJYlRx+ud4QLUnUx0YkGKzSwkvPKoz2iYVGoEfGwkJ3RRG?=
 =?us-ascii?Q?s/geSTSg6QoaLX+iGZbzdjcftDTjbs+BUJ5ByItzliYP5z0y72Sjq2ji66ku?=
 =?us-ascii?Q?GhXSLtQ0J8XDLatq36MGg25jIUctJXGK1PLkGwz17afC1xkm6WpcKNTZ2cDc?=
 =?us-ascii?Q?gxac+lVDZp8XU17kyRjpXckh2DDDqYuBNyDFl1KfdChOoE6Tqb/xnmZaoT/7?=
 =?us-ascii?Q?HLWQlp5bnAejMCe8LUatzV4FkQxb8voHyx3DFIX11fWtmBDELf4HLXoWqWSM?=
 =?us-ascii?Q?Xf46lV/b2mlGCLJHaO6v0TP7Ls6Gt5lXPer674Pu7j2eRUFgqietf8OY7tGY?=
 =?us-ascii?Q?ch0inzsn5V0zXSZhXN5sgleSFlMuvwdaTvOjKQ9m5mY3g2Lr7ho3ArFdGWgp?=
 =?us-ascii?Q?0POxx+ifOeooLArijPgcjZaQQQkQuQAHHux1lWdCFk+EqBxe4X/G5ky2u3i7?=
 =?us-ascii?Q?w21KrfbcCAtJA+GgZkAm8xL11ZTxgEag7BRW6ueBoa2ydPQFprvf0rCN7RQ/?=
 =?us-ascii?Q?/zX4WbZJspN7FCvSs/wqOtUHtrXQjSqQj2ORL2MWK2YsaEK9NnrXcdzIYbwe?=
 =?us-ascii?Q?YNO8fRu9vnrGGGMBM9DwWULbaaC3zkmMYLe27fkJctOamiRTlE4GNlglwj5s?=
 =?us-ascii?Q?YxNY4IjSNc1ddIExNQIIPH212hIJ7mPx7Gtug58R4iSMsAI2rU0riX3bFXsk?=
 =?us-ascii?Q?hcciPhuMnIvqvthjpVhVsR9KKmIRTBJC38SW1ldJpHlEJJpyCmpMQa2SR/ft?=
 =?us-ascii?Q?Qa+aymmy/NFOroicLtceIgmuZG9ixJrfEX0JjDdIHvZMsbNw0pXRQTefUZzJ?=
 =?us-ascii?Q?Otta7a4CPQqLERpwVCO2R6szZl4RyRILbjFrj9FbueHlguXpBe7IT+P5yQPp?=
 =?us-ascii?Q?/aOw3Ya19e/mdk4ZqKU4MLh7qMFeR1ZdQhZjAZ22TaE9itEbJfovlI6eJFLh?=
 =?us-ascii?Q?hOdYrEIt462ECx3Ix1RRbRwd310YTiwjzkcVlOcg2oSWOI5rEcOiBOhktuPf?=
 =?us-ascii?Q?Li8X1c1JhSQJs/Rb05HPT/uFXGMKMhWVA+M1bKm+ukacfrYURoCgVGoOzjgN?=
 =?us-ascii?Q?0L3SOOLCAnO0Fm3U0X4jYHDy5KqsBFeIW0dYu44MqVqSMJnXLcalDORfbb5E?=
 =?us-ascii?Q?Kn8ybJvaUmrF2ZWO4VHUAOjjYuxzx2poLulsRF9CfXi0nzzVY9/uEQs/DL/I?=
 =?us-ascii?Q?7jwC+EgStXftrgtvBHps9EhHXHXAkRf53MXZJnOUPCuC90iedkn2kdfnp0v6?=
 =?us-ascii?Q?B6DSdueYIl3JQsbPfM8n/0K4KUfRwOILobY0dJvPhANEucjcb2mL8cnGqrk3?=
 =?us-ascii?Q?lTE6b1Jp+FizoAZPs2+5f3QJdvPv8XgDy45cdh10nMu4lf0VBtX5IL47tDf/?=
 =?us-ascii?Q?X0yp/OMaYmSN5kjsOH3YvOfKm8f9lNt+MWQFqbHW2CRVpd4tV1VC6Wpcd49w?=
 =?us-ascii?Q?kf7kdmqyiwGQlky5RzCziSh/KJaIewbvugzO5TB8I2rj8dGVothRR9D6c+Mg?=
 =?us-ascii?Q?j3gjZFlTdXHIjPV5VTWu8mZreM/9KGgwaWKXF1r005yEaSH+d2cZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f16bbb97-c666-42e9-a69d-08dee6446ec6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 09:51:13.8100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KNJGBs6nChkFcWBe7c+ORs+43PCK4dBwAg7wPmI0cORdnSHng875waQk9H3cGt5kpC2Th7ZSMpLd4ttA2JhZDc1atu6upIq32RA3Ew3yGyCqzpy6rzTfplhRwC0BpI6k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9800

From: Shengjiu Wang <shengjiu.wang@nxp.com>

The i.MX ASRC hardware supports up to three conversion pairs (A, B, C).
The existing binding exposed only a single generic audio-graph port,
which cannot represent the individual pair endpoints.

Add a ports container that enumerates three named sub-ports:
  port@0 -- pair A
  port@1 -- pair B
  port@2 -- pair C

Each sub-port references audio-graph-port.yaml as before.

For backwards compatibility, keep the old single port property but mark
it deprecated. A schema constraint (not: required: [port, ports]) ensures
that both forms cannot be used at the same time. Update the examples to
show both the new ports form and the deprecated port form.

No existing upstream DTS file for fsl,imx-asrc uses the previously
documented single 'port' node, so this change does not break any
in-tree device tree.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 .../bindings/sound/fsl,imx-asrc.yaml          | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml b/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
index 608defc93c1e..18d252722aa8 100644
--- a/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
@@ -78,9 +78,29 @@ properties:
   power-domains:
     maxItems: 1
 
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    properties:
+      port@0:
+        $ref: audio-graph-port.yaml#
+        unevaluatedProperties: false
+        description: port for pair A
+
+      port@1:
+        $ref: audio-graph-port.yaml#
+        unevaluatedProperties: false
+        description: port for pair B
+
+      port@2:
+        $ref: audio-graph-port.yaml#
+        unevaluatedProperties: false
+        description: port for pair C
+
   port:
     $ref: audio-graph-port.yaml#
     unevaluatedProperties: false
+    deprecated: true
+    description: deprecated, use ports instead
 
   fsl,asrc-rate:
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -125,6 +145,10 @@ required:
   - fsl,asrc-width
 
 allOf:
+  - not:
+      required:
+        - port
+        - ports
   - $ref: dai-common.yaml#
   - if:
       properties:
@@ -188,3 +212,57 @@ examples:
             };
        };
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/imx6qdl-clock.h>
+    asrc1: asrc@2034000 {
+        compatible = "fsl,imx53-asrc";
+        reg = <0x02034000 0x4000>;
+        interrupts = <0 50 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clks IMX6QDL_CLK_ASRC_IPG>,
+                 <&clks IMX6QDL_CLK_ASRC_MEM>, <&clks 0>,
+                 <&clks 0>, <&clks 0>, <&clks 0>, <&clks 0>,
+                 <&clks 0>, <&clks 0>, <&clks 0>, <&clks 0>,
+                 <&clks 0>, <&clks 0>, <&clks 0>, <&clks 0>,
+                 <&clks IMX6QDL_CLK_ASRC>, <&clks 0>, <&clks 0>,
+                 <&clks IMX6QDL_CLK_SPBA>;
+        clock-names = "mem", "ipg", "asrck_0",
+                "asrck_1", "asrck_2", "asrck_3", "asrck_4",
+                "asrck_5", "asrck_6", "asrck_7", "asrck_8",
+                "asrck_9", "asrck_a", "asrck_b", "asrck_c",
+                "asrck_d", "asrck_e", "asrck_f", "spba";
+        dmas = <&sdma 17 23 1>, <&sdma 18 23 1>, <&sdma 19 23 1>,
+               <&sdma 20 23 1>, <&sdma 21 23 1>, <&sdma 22 23 1>;
+        dma-names = "rxa", "rxb", "rxc",
+                    "txa", "txb", "txc";
+        fsl,asrc-rate = <48000>;
+        fsl,asrc-width = <16>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                playback-only;
+                asrc1_endpoint0: endpoint {
+                    remote-endpoint = <&fe00_ep>;
+                };
+            };
+
+            port@1 {
+                reg = <1>;
+                capture-only;
+                asrc1_endpoint1: endpoint {
+                };
+            };
+
+            port@2 {
+                reg = <2>;
+                capture-only;
+                asrc1_endpoint2: endpoint {
+                };
+            };
+        };
+    };
-- 
2.34.1


