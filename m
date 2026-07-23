Return-Path: <linuxppc-dev+bounces-24703-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF50C4453D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 02:20:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5FFP5XSJz2yjq;
	Thu, 23 Jul 2026 12:19:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784773193;
	cv=pass; b=Rxcdgj1MF4XiwmLPNKDWXaE+t4AdUZOSOxRbhC+VAWbja0PfLITs3pEppIdMoAjyldiAZnT788bcjwgf9lcjnWuWQoZZS7S5fHCw0nGHHttSWV+plrJZaVqKcekxgvcX4xIDiLeIuPLxFDtRmylFQOW6X+Szt4AMkr1jhP4B6PKBhpo+zGdzPt6pq+rK6saSNIttesmOEWNGpX1d35dYibd7tCJ/5/IfP2k0teuBQ/uK1N0sgaONLsl4aoWHOcYfXloPWJGA+/+ZQYsZs7+evH26nMAiW21Q0tho7DrzGx6C1jveoHKJZHZbseWvancEam8sZG2L89l+HLiLdzmyUA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784773193; c=relaxed/relaxed;
	bh=jGoTUaZn+jEpuQItU+51jvu6PzW/mByno1WJlMrtnI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UxmPOfHmzs7D8SzoMul5HbkQzzajNtgsk+CU8xML9vf+PHkjCJ+vAKowa+R8gX4lQFQjKm5d/3buif2AJ3MvSztcBkUJtUq0rZ/e92VneaYWilyvGnKR8Ji5DCfNWPhfsa1yt4q1TyWqaev963HMT4KZCNDb5QuZcSlc2aTfOgPu9/y06LU6Xhf41UywXiTRpYPFCMibotzywSbYETzjtKrjjoAhOdUVbx/9+anMGsPcGv91E3DVdYsXBNBdILWmdjUB3rINjjCbjof9DgQ2bXgpBEtpkqDBotBLsscCKJarjfCa+OfFZpdODNleaDbiGp/OgMLkbPJ2FVD2BxUGAw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=bKPbYq2D; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=bKPbYq2D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5FFN6GXGz2yhb
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 12:19:52 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIcY00NLY1NMfUtmBXS2nPAgLec5w9X9pdbjWptej1zQCPjeCr2JOMXeL10AFjckw6rgMjun1YspF+0AoDP6w6tXXd2XMgfKLsO4R7RBBnLbTeMCjBL/zvzXEIVCWQ2lr5An5pFcFYU16cJizVeDAjPHZRa9eCnJZjJREXhm0EQWy0lwkq1o/UNceHP+UEfbsSOng6kaxY6GHiuiOrL8vqbVTMEVWJ1V/kK1QDn9C/GGF+mvLskfPtCnK6XTdxBmU4TQWToxzMBx1PSOs92NXqUFEwBFMTP6c5IuLX+OTh5wXBbyn3rC3dV/OpuMhSpTfumi2BvHJGC1/fyu47qNoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGoTUaZn+jEpuQItU+51jvu6PzW/mByno1WJlMrtnI8=;
 b=UnxtD9MPF15DXK/hYnGOwifyRVWTWIRDrznQLApUwFuhEt8SSILqAawGSECtc7oR/ieUpuzaNtaMm2rFzgdhlKZP1b9ltzGzJnO9gPyqPUbwBcgx5RgaJx4GYDQ/m4ZEft31kbY0lOskLoDdUnSwNZv5WLh4HZ09wwKMjQd44XcIIW+8JbWqyHSKmYujr25/IG4PXBMQsJhSBFVKUeEFcer70DjPAPJpZziVlY7P88HdCPSnqyz2so1zwABQFD5X4E2d5/ONpgqcKO7FbyrzjyVNWaytHeogg+2Q01BShXeJZfbVou7GNnE3byso2vPbH8IHYsCVbvtVClx9Jtryqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGoTUaZn+jEpuQItU+51jvu6PzW/mByno1WJlMrtnI8=;
 b=bKPbYq2Dm6XDmBKKpAz9kdGZit08dS1i0ruVMXwBR3Jlz8GrINm9RZ5mT/NGVfDmf+zrHdbljZ0uh3stR39vgNSupkexChRaFyId7LxzPwjH5L6Vth46MKaLe1yiL+Md0Bct3fSxIAMh1CEXTLoECN1uijyYKcSG44DP9tllLf5adEkImDZ/v1JHFU0z8hw8MkPjRHXGlDEby03YN40WV2G8obKf+xXb6Qa9YzbhLISNmfhHLz16065h8MQqDpfqG6nG8zbrlIw6dYT/Fe77PDcbZR5JSbbhWDzynSXkCFNK4iF6oz+FQLUpyuvB8YaUxa0v2U8dpv7RcBHhq1X0pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by DU0PR04MB9252.eurprd04.prod.outlook.com (2603:10a6:10:353::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 02:19:33 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 02:19:33 +0000
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
Subject: [PATCH v2 2/5] ASoC: dt-bindings: fsl,easrc: add ports binding for multiple conversion paths
Date: Thu, 23 Jul 2026 10:23:10 +0800
Message-Id: <20260723022313.1905051-3-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723022313.1905051-1-shengjiu.wang@oss.nxp.com>
References: <20260723022313.1905051-1-shengjiu.wang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KUZPR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:34::8) To PAXPR04MB9351.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9351:EE_|DU0PR04MB9252:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f965174-6c3c-4785-d60f-08dee860d5e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|19092799006|1800799024|366016|921020|56012099006|11063799006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Sjp4UquubeY5r1UXpwp96mn83gn+jJOzsbXZMuGw1I9RyWQ0RYrtnB7xZTpU2gdNxzFEGyJr2Hwc7zfsp4MSWLGsUDOxQCEGVu+BU/lIS93VXSL6qk2VjjFpPMGkL9q5vBBCNKRlx8rRAVp5MGF/C4UnG4wD9LmsSBGxV/R/XxWmv0ky9BUAgdIQLaK1APLZdj0L1i0jVr2rHZMktaFnF+MjU8h7xuS1hBS1xRENnapPleg1j6LNz0E1L0K/VcGRviL6TpRPqykcJP4nwyr5W8dV9bnm5kz4QuiWDEkT9J+LZs0vk1BEQ1dD6QsgwAKjDBs/mjCmzr2O/CENDVNJd6XfygxQRtTQ3TkcoSnPgzDoBEyHj616Wj4ABWR/2In9PZKcVYS8uu/ylctGBoZRcLA2VUkXv83hDgPnkBct8qPrvpKbxgjuwYHbK5orsTVuj6a8/sqUXiaeGcGsOgV8LgMKffvnul2Jx7UgQVRtMxVAaxHx9uALcwy5cylij33uSwKOrRqsN2Eg2dydbG8ZASb4t9pTtPyWWy5C0q+urNeXqjhr/0FjT1qpDjLJHYwKqRagDEdbGq73WDR8POSOOQk3DxjzOIlou+BnmzY6U+2RDmv1WE+ks0Bl77/gR14MMyXjDCvGWNj1Mf1MSSFsX3hIw1W4Bjcz6d9Dh5jYDnFVR6pWnKdljizdmxPjYzgouojHVLFReYlD2vdWF2WRnA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(19092799006)(1800799024)(366016)(921020)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yY2+nOa1RcdCaWHn0BTux5quiA0YUPBmJu2QiBj/Sv5QCJqioQpmwvGFJXJ3?=
 =?us-ascii?Q?wjZj/h8fET76FR/h1jTMofu8MBTHrKuRIo/HgCH6Ez1rncam+jAugL1itOWP?=
 =?us-ascii?Q?cOFcH/dWChHLLOqg6PWllz1EQmEZnPDwcvZSTciRh7EJKPV1ftnD+mUED9Bk?=
 =?us-ascii?Q?Q70W8u1c+D5YdyWSXBT/eaGLwCws5/moXoGP4Bku677PV6Xdt0z9B3w3V6PP?=
 =?us-ascii?Q?RP28n6tMHqF/k6Mi7pt+5lumozDKeq23VeDdsv4p1zP04c8ylpxsCF+uahZ9?=
 =?us-ascii?Q?O5bA3SUW92dsQ7IoroGHAtbZdiorp8pp/7Lrxdad6ZiKe4FXiyg+hOWkZFtA?=
 =?us-ascii?Q?LfYm65FhigqOEmwtGId8ILDpmpOza1C5fYq9kysFYxZDwSTnLJ47ycw21S35?=
 =?us-ascii?Q?tZwchwjqp1tctHeV30sTIMvRQgmLQBQn2r9ktYoykOUbV7XPnjIhzlTcKEc7?=
 =?us-ascii?Q?132wd7LUOI31hOPR7IoPf/3VM5vsWzlhhMHinNpcHGcV4cmqzvCdfJZeA3KG?=
 =?us-ascii?Q?mkWBzO0cZfrsGhtAFwr4hJnu6R5CH+ZM2ys6rLMTaaimzqngOlWDLQ/+JjAP?=
 =?us-ascii?Q?g81PmWIWJVk4WTO19uxIG3A8A+s8R+dCtOSpmf6yabNP2uYfLW1RHzfBoRuy?=
 =?us-ascii?Q?0J0bgMxLhc3dJJa99Ab0qFNC5YQYae+B486/IaSh46ad0TEtjlvp/1LThyUC?=
 =?us-ascii?Q?7wuHouiaycJm3tBlRjguG5VRWeoYqUxOZDiWHcdehzUln6fxJ/XvMxaxoMI8?=
 =?us-ascii?Q?G39/efIEUG4LllSGZQYc2fA9B7BezdQsEBNW4RaBQMGeOrXC5q2KkUJhV4F6?=
 =?us-ascii?Q?UQ1Y42WiIfAP1DrVKglQQGBSrH5ufK3uvJTtP9j2y8X8xl67PPRVdhT7xhgo?=
 =?us-ascii?Q?dz2YPx93EGxH9z2peX0xVtRqq2Ois9PjG3nKzGbR8P88oZG4XyVfn1hJZ2UG?=
 =?us-ascii?Q?XNt40QQ8RVeGTHgdVlCIGtajV+CZXtstoLrAlXrnfRotDMWO/gOgIrCJJYsY?=
 =?us-ascii?Q?K6pbxY4ezA9ChsuDHN6rQvJKFrcw/Kuo0IIzjFGqLnbWSBTyH86sFBeH+WL+?=
 =?us-ascii?Q?nazYaufqQeZcU2UhZjfVmwZCN3Y2YmtFXWnaBqZNklfa2nLTZm5ph7z+4sXF?=
 =?us-ascii?Q?ncdkyQMwQhiz0SDDm2CP0sHrvtOJyFok6WBEXkANte8ZxoTB5DgZ10hRW5YR?=
 =?us-ascii?Q?Ua0909f4riylr8b2wgcFpveIVR6JSYWOsVqMwV8vei1vomyXI8VlZiTUHPQb?=
 =?us-ascii?Q?L0ixQ8tciNcfMtco4VgzE4DOkqvqW/QPbMqSWrJn1XYs5WaZ4RkxIfYmrt8N?=
 =?us-ascii?Q?iJhKha8iJPXSPD4z9htHKmw5RxXIPsYDWsPaMAtEVzPoRcM0M6B2ozra8RQZ?=
 =?us-ascii?Q?SH4oktOrsB0Hy0cA4U23V2Uv2lecnzMeNauirBiNFMMmCzquKLTR5qja5npS?=
 =?us-ascii?Q?SkcVOhSDYPj8I7db88kF7EabwIZDzoSbXZFnjAqm66aZl0+HHyWRDHVy3DUw?=
 =?us-ascii?Q?smzu3UOoz/HpN237a2EzMEAkVvOIwHN3YLA+DoyNid1bHvLN/ubR+qQrhvU3?=
 =?us-ascii?Q?/62GYphrQNNI1omr4j/jgpy9oXXHOxbU3uuzUQxvtimrZyQnKhfDnjz6vUTX?=
 =?us-ascii?Q?gNiCKWPl1rtPPP5V8LWNuXdnQypdo0SWbPcWayYInU/v2HMqoI0nXJFiMcym?=
 =?us-ascii?Q?pxt4tMEcwf0YPfTXqFy198KR9JcHrluyWZ2Gk+OMvEOp/KBGkCuH6rHOp6pc?=
 =?us-ascii?Q?U27pavAjRz9T5EKo/jJSMiCLJS85PgH0Tevvg+kS3Lv0m+Qma/E7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f965174-6c3c-4785-d60f-08dee860d5e4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 02:19:33.7923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJnZvOgiC2QAnKNsQ4MJQrReGgJxlnfAh67JtrHFvVKKL/C11zqz2gVHxPEgKaGgEB3nsZtZJYO3qY1WG/PSIzO70RouBPxjAQVwpo1zcIQBlV2tCm5LTu8WSBkoCI2Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9252

From: Shengjiu Wang <shengjiu.wang@nxp.com>

The i.MX EASRC hardware supports up to four conversion contexts
(A, B, C, D). Add a ports container property to the binding to allow
each independent conversion path to be represented as an individual
audio-graph port:

  port@0 -- conversion path 0
  port@1 -- conversion path 1
  port@2 -- conversion path 2
  port@3 -- conversion path 3

Each sub-port references audio-graph-port.yaml and follows the standard
audio-graph binding conventions. Contexts are allocated dynamically at
stream open time; each active stream direction (playback or capture) on
a port consumes one hardware context.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 .../devicetree/bindings/sound/fsl,easrc.yaml  | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,easrc.yaml b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
index d5727f8bfb0b..e6d7cae5983d 100644
--- a/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
@@ -55,6 +55,14 @@ properties:
       - const: imx/easrc/easrc-imx8mn.bin
     description: The coefficient table for the filters
 
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    patternProperties:
+      "^port@[0-3]$":
+        $ref: audio-graph-port.yaml#
+        unevaluatedProperties: false
+        description: port for an independent conversion path
+
   fsl,asrc-rate:
     $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 8000
@@ -107,3 +115,63 @@ examples:
         fsl,asrc-rate = <8000>;
         fsl,asrc-format = <2>;
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/imx8mn-clock.h>
+
+    easrc1: easrc@300c0000 {
+        compatible = "fsl,imx8mn-easrc";
+        reg = <0x300c0000 0x10000>;
+        interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clk IMX8MN_CLK_ASRC_ROOT>;
+        clock-names = "mem";
+        dmas = <&sdma2 16 23 0> , <&sdma2 17 23 0>,
+               <&sdma2 18 23 0> , <&sdma2 19 23 0>,
+               <&sdma2 20 23 0> , <&sdma2 21 23 0>,
+               <&sdma2 22 23 0> , <&sdma2 23 23 0>;
+        dma-names = "ctx0_rx", "ctx0_tx",
+                    "ctx1_rx", "ctx1_tx",
+                    "ctx2_rx", "ctx2_tx",
+                    "ctx3_rx", "ctx3_tx";
+        firmware-name = "imx/easrc/easrc-imx8mn.bin";
+        fsl,asrc-rate = <8000>;
+        fsl,asrc-format = <2>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                playback-only;
+                easrc1_endpoint0: endpoint {
+                    remote-endpoint = <&fe00_ep>;
+                };
+            };
+
+            port@1 {
+                reg = <1>;
+                playback-only;
+                easrc1_endpoint1: endpoint {
+                    remote-endpoint = <&fe01_ep>;
+                };
+            };
+
+            port@2 {
+                reg = <2>;
+                capture-only;
+                easrc1_endpoint2: endpoint {
+                    remote-endpoint = <&fe02_ep>;
+                };
+            };
+
+            port@3 {
+                reg = <3>;
+                capture-only;
+                easrc1_endpoint3: endpoint {
+                    remote-endpoint = <&fe03_ep>;
+                };
+            };
+        };
+    };
-- 
2.34.1


