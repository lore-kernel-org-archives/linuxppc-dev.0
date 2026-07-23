Return-Path: <linuxppc-dev+bounces-24702-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F74C4453A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 02:20:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5FFN4BRCz2xJT;
	Thu, 23 Jul 2026 12:19:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784773192;
	cv=pass; b=jIPKa1eBu/GF1qowc3gNWwJ5WPEpaUqWcNHXx2qHr8xza0fmfyUcIanKfqdQuzKXYAjNsDKNETXfHup7c7GZFUbNnRn1QwQwTc959zP6DvsX0Vq3lkwnVRAP/YuWfctR51NIik4XI7/yJAmHMnR2qBGxkfaPTMpQy+dx0i8b2M4DAYmMEPzclu3qtmZc50TMgL56vnHCSKgFORhzWZgNyoHS+sr+he74y1fyLdb33SzEIHhRmA5w7tOShyqPY/4JGARAdTutQ+y8fKhEzou026l8AHXlqwknt8KsDGJLk9bw0YJKHk1O1Tr6P0O29iQoY1V22y2lch7hWeEG75zipg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784773192; c=relaxed/relaxed;
	bh=Mh6TmC04DTTArJ17QjXOaEgpBxOBd6xooqSZ7trbiEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d8pXKj8VR8twd0kWZahjmmeWTSElh/ln4L8YmLBXPAq0m0XpxONWXieNBSO7qpxTMqOYo9m0dyudkHQHAaf1Y0EXHXgNlqzQWwDGrW/3N1ZcFF9epqJ3ezkiY579v93gsb52mMwaEg6nS4jVAQpy+9iDlWMeWQFCMO/JFZ0YLxRmiRMkEJwlve8V3Ku78Gbc7mHbQyznZYLqMRlc9sDxLFx60L4Ad869mJv1sMVBrwCeXu2jT6wo5zopnqLBpe4eL2yWriZCAldYOgWWJ4K9O8Fw1E0PwI2Kbokkdi56gcZZpXPmMWDD8aa4LDz5/jAOheUeG2wHxTrTH2Nmuc209w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=oQ3taVIE; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=oQ3taVIE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5FFM2zbrz2ygG
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 12:19:51 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJXzwZA/1W+JlsFynLKzKP0O4YuMNRVHqDIUR6xVsJEowlKCErEQKnHvwqV9I4PQQ3qyUSVUlzvZyY3DVwg98Ubmk1/Rrqqj8Be5DqOeoR72ssrREpHLvRyWmQarhekd3CxIbMMQMxh4HhUi7F5OJCukrmPLWiLihKLxQOmAgKMVPZKe7fjjcdl01bJlL7dTEDVD5YMya059aMQi47Hm/s5AvcgmtkX29nFC8lY8MAHmGAUtdMYwFRSpdY/whHss5K0EYFigGiNYPbpcw4sspnp8MLW6+4BV96KmU4KYYa0MUw0atasmuVnU2auA/tt3/+MX898BCyo/ZeMQCQZ4KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mh6TmC04DTTArJ17QjXOaEgpBxOBd6xooqSZ7trbiEM=;
 b=IaIl+tLVMUtT6oVeUBm8ySs9eooglqWUeHwBn+BP1BdtFGRSlfrj5i+BvKMqwYGsXFMxdIckPWg3Lf+t+E9ildRPo3RQqwxQ1fDXic/tKzEEpmE6UFl5dTOBRisJLss0c6mwAHrpbxybyC8MR5jPUtfcPJt10vydkFJUS33XSjjYg5Dy66fYN42C0E5QTy2TQKVDqGt9iHDGXq68v26CRJ7zaTzbzgtIHBjQcOAHgnpaeavkifC9Uf+rkQVKuTK/ts+/+3sjkn4SvGcHgae6sTwUN8PN6IFF0Ha8HuAdOkzdedWVvhyTz+A+Fk93DnSA+v77U6uymZ8/LMMMqM+UbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mh6TmC04DTTArJ17QjXOaEgpBxOBd6xooqSZ7trbiEM=;
 b=oQ3taVIEm4X0mNiiEbrUScPXlE09mNP08o0/K/+cDOlQvXRlmyl7Zsd37ztgc6CRCpE+sV13SfG9pCIq1ajz0+dGoxXgm+wIUp3XOeP6j3cM68259lAmGIqmz4pffCyK/RZB9qv9+NVQXHoUOPBN1gbdwTssTo7ocZHbOyISmrcOqktKqehHgafsQvB7qbhW7dd/WIjuMU289ttctkI5iNMpmM2G1hQfK/pI59mPfnRWbqIZ6WWzZ/AeM6tmduHWHhSiyd4PqYw0x3XNCq7nkP8FXCZk6sezZFlmksRVBRWLtyT+eoK7zNwgmSW0oVqSFguUKOMqdo1qThpAXYn+yQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by DU0PR04MB9252.eurprd04.prod.outlook.com (2603:10a6:10:353::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 02:19:27 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 02:19:27 +0000
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
Subject: [PATCH v2 1/5] ASoC: dt-bindings: fsl,imx-asrc: update port binding to support multiple paths
Date: Thu, 23 Jul 2026 10:23:09 +0800
Message-Id: <20260723022313.1905051-2-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723022313.1905051-1-shengjiu.wang@oss.nxp.com>
References: <20260723022313.1905051-1-shengjiu.wang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MEWPR01CA0307.ausprd01.prod.outlook.com
 (2603:10c6:220:1d8::17) To PAXPR04MB9351.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 700ba7a5-e329-4dcb-99f9-08dee860d1e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|19092799006|1800799024|366016|921020|6133799003|56012099006|11063799006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	hWuwKrRSiyWu/27j3fSeU7gGNiYBrvkBvjgZtD914IWlhYswywML/9x5Ozcf3PVC0TUcsdd5XAidq0VSau2mUQ3QPBvus4il0qLYMYrKYBMIMRPsUz4M5jTDUuReezE7ZCwE1vgaIPEUxD3VRzJf2QdYDVp/5RA6vlOUta0k1AgyIw7DTPW4ZSrTYW4eZ4lh3wFnkBRPqQraaE6SStmxYdx8MjDShNRXTeH5EIV9G8hZvn9HQTZ7XA5q3tJ4QLku1UiDNMeCZWJOgqIrKp5ZyxvDxpF4nCHnEdtxMVc8UJpiqPlo+06JbWVVxpiQEIDFM/+LX7cvUvWnN19DrNFSj4NC8ZGQijNfSGyDJBRzbZK+7TSjJuwHZqTUpnHmX9RPVbn+3/rtln3/dCDDVeLfOnQY/8LqEv0zD0U+1+bq3RTke9iUdeUu1IzZX1C7ZC6pZo00BjjDLGJQf6fFIdW3UvV3MjKoFiEiK0pQDImre9MEKkzazFMNhWES7dVMU8FaoXl0/Vf1mrro1sGpOh6WGAR1GC23bj8zcHWYfaMD44dex5/r4sOxZLBFvYksrD9FArGK/evbHL4Fnd2ezLQgTQlu4vtry/QRlhDz2v3fr9GMUErJcPkcEvj4YpHdWfW8BvjirVHNA8RJ8SwBxGJCYqfYwoDr8BszC47X5umIrCaSSp7DwJ4MiDt/jcipRZXhcjrcaWZAvf9wJXYbgFrmHQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(19092799006)(1800799024)(366016)(921020)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EBZQQazDN9WX9Qp5fo13e9GItwDnlurExu7J5QRWBKtunECSo19tcyCT3Vvb?=
 =?us-ascii?Q?+aOsNZH+4mLu9UJ8ag53UqpoivjcaQHiqRcbVxTOH+ybILVlGshFHJgafGvB?=
 =?us-ascii?Q?rNboGWXoBD7D+1EUIpE0XW8XBhlXdt4rj5G5bX05R47uN8ee170sajPoEhMr?=
 =?us-ascii?Q?nDpu7xmAu8RcqxVQj1ddpVwu86KCQS+9p3i4sN+UCwfw9pH0bheZcccEFooo?=
 =?us-ascii?Q?vPPsuO4+bJKMtRc0YMrjVk2tcncpBxQPVRrS80HniuEFWCoWDqhDe9F2TTz4?=
 =?us-ascii?Q?CmjzEk8R4QUAB0QEvdfBwAyY34qQ1UMIVCxmr0UNs1/jSECBsURMDI9QyHRK?=
 =?us-ascii?Q?oQTWgoIIWBUfVKZFtiOE84lsgLr5oT/xGNJFT3J/xZEKiNW1zWDf8F+Vz5Af?=
 =?us-ascii?Q?WuLpqVaAGRszTsupf/6GPlYlHk1GPf1uhXAUyhN+jeIWfhlV3cMbHgOnV+CD?=
 =?us-ascii?Q?RfD6afVeqrHkOQRoKIQ+saiEijo2EHPpnRGBnegV9nwL0SNymYX9JomChZ51?=
 =?us-ascii?Q?JCcj6mnvQkSGk5Uqf79tLlUkjoog+wG7tI52giZzRy+Am9fvv8l0hqqYpFfU?=
 =?us-ascii?Q?4lYGZQjowBwbJiHr2RkIoIEurXFh9iPZsgNTDnaFxyTTMFV/f1/icktBylEx?=
 =?us-ascii?Q?RKDaYP8UhjhK1jOJRpK2abA4MbwzvGJQTEauBJ3YjrS+lPGekHr0akgKcIyn?=
 =?us-ascii?Q?T0Rmsi7VphRMJByEQbmIyTFHRkAAWjreoRRLf3gKPjWP2GPzD1pAc/jN8QUI?=
 =?us-ascii?Q?iKnM8MydvM/hsJuuDC8t3Ft6Fr6APlGOf8hRjF3S8IFFN2p0T5AMvlSKs0Ne?=
 =?us-ascii?Q?HldWVn04EYbADpL6BNugPRvQZlV+UStERTDX7g8YytENw+/g4nuqes2L3Itk?=
 =?us-ascii?Q?pEYD78RVpAK6qcVyMrEQPRUrovCuJx6w088WpXmTHIN24jtkG6/SdyzmFpsG?=
 =?us-ascii?Q?1vd9ixyCR82ppr8PUb5bw0dGUQiLofhSf6vhm7qj0I54Y7JEWJegjtQaDMXs?=
 =?us-ascii?Q?aHepus3I6jhSA0cqdGJlfd3PxkUiSV06wpFjugJ4oV+tJvBAqRK2mWAcZxnc?=
 =?us-ascii?Q?+5lXYGmUwDAEPXM966mafhDJvDdsBnt/+GzPON5wYzo0TPAggZdP6Ycl1eRA?=
 =?us-ascii?Q?u+FTs9DFoFiLfFNStB+304EBs4DKvR99k0423u9j4cw8cTH3PhyBPAXpk8UM?=
 =?us-ascii?Q?g2NkuaIzgnRFGSLopD7MCk9DjIRgVR7y5B++yk48sHC7N2FTVEz2qJgQ8Wb8?=
 =?us-ascii?Q?IZPZWYsa/x8KPZvCGCmSw0RxuSy22OhjfqC8zxz5IWsXXjm7vWrQUhzzw8QQ?=
 =?us-ascii?Q?Pn6yRHm4DFv66CKHbSmVJgdaTOlALTFcIUWy3wy9o4EyaSHsMQUVjq64IaWp?=
 =?us-ascii?Q?SHwmxBVESs8Kj9UQWUOmrXinWPIhG8AlxpbJQ+fE3UY4xX+SJ6fgM5UZH4Qp?=
 =?us-ascii?Q?jpFUiqCxKjpaBUqQ7Ggnpbv3pmNd/0/oiBDULPsbcLINvVzhnY6DUcFXOeKH?=
 =?us-ascii?Q?XWSF69Cg8y9s6vR/eXmUibAs6tlz1lErKaK/rOqdcusF3/QVun4S+w0t5MtP?=
 =?us-ascii?Q?+wEwst2fbkcvoBxpBSVSjYzkcHigkR5Hmz2J1zF703R24mcBLNiIpDZw90Yn?=
 =?us-ascii?Q?N5qXfCwQm4ZVqEG+c4lcnskYJvWuQsJraztReuAiisrWBSgbU04ag7MyLtvM?=
 =?us-ascii?Q?HOvc8IoW8pGUhpgcQFEPd0SB/+Afa/UaQB+gsQWtR/9QUrGMFAn9N5M/dUpZ?=
 =?us-ascii?Q?o0hWkG4c3fjbnPmfTwpnYu7oVykh3oXRSKbvrTvvzE+xIb9Edlaj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 700ba7a5-e329-4dcb-99f9-08dee860d1e5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 02:19:27.2231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ehpRSRemEbNUArY8BIjSKaAw4OV+e1bh/78BGNTMqDrbL59vuCJxM9RmKlH6gAs0HSGxtXIMrRiXWbnugZ/cEojSJDnqvaMtEGV9tDLRDrNq1gAC/sAPXsqSHeft+FMs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9252

From: Shengjiu Wang <shengjiu.wang@nxp.com>

The i.MX ASRC hardware supports up to three conversion pairs (A, B, C).
The existing binding exposed only a single generic audio-graph port,
which cannot represent independent conversion paths when multiple pairs
are in use simultaneously.

Add a ports container that enumerates up to three sub-ports, each
representing an independent conversion path:
  port@0 -- conversion path 0
  port@1 -- conversion path 1
  port@2 -- conversion path 2

Each sub-port references audio-graph-port.yaml as before. Hardware pairs
are allocated dynamically at stream open time; each active stream
direction (playback or capture) on a port consumes one hardware pair.

For backwards compatibility, keep the old single port property but mark
it deprecated. A schema constraint (not: required: [port, ports]) ensures
that both forms cannot be used at the same time. Update the examples to
show both the new ports form and the deprecated port form.

No existing upstream DTS file for fsl,imx-asrc uses the previously
documented single 'port' node, so this change does not break any
in-tree device tree.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 .../bindings/sound/fsl,imx-asrc.yaml          | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml b/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
index 608defc93c1e..ecb0aacba456 100644
--- a/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
@@ -78,9 +78,19 @@ properties:
   power-domains:
     maxItems: 1
 
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    patternProperties:
+      "^port@[0-2]$":
+        $ref: audio-graph-port.yaml#
+        unevaluatedProperties: false
+        description: port for an independent conversion path
+
   port:
     $ref: audio-graph-port.yaml#
     unevaluatedProperties: false
+    deprecated: true
+    description: deprecated, use ports instead
 
   fsl,asrc-rate:
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -125,6 +135,10 @@ required:
   - fsl,asrc-width
 
 allOf:
+  - not:
+      required:
+        - port
+        - ports
   - $ref: dai-common.yaml#
   - if:
       properties:
@@ -188,3 +202,59 @@ examples:
             };
        };
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/imx6qdl-clock.h>
+    asrc1: asrc@2034000 {
+        compatible = "fsl,imx53-asrc";
+        reg = <0x02034000 0x4000>;
+        interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
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
+                    remote-endpoint = <&fe01_ep>;
+                };
+            };
+
+            port@2 {
+                reg = <2>;
+                capture-only;
+                asrc1_endpoint2: endpoint {
+                    remote-endpoint = <&fe02_ep>;
+                };
+            };
+        };
+    };
-- 
2.34.1


