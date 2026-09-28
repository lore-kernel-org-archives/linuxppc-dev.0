Return-Path: <linuxppc-dev+bounces-28375-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF3AC9833E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 06:13:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htWG00ZYvz30Vj;
	Mon, 28 Sep 2026 16:13:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790576008;
	cv=pass; b=m7cWHF7d3eA/zdLfiZPj09M/NdYrB/1S6T5wOTx1UaLe67V6cimMAOLPovVvGa8f9jqnEswmFKhDOgm617yOYQJyARzaoMwvMHtsLs0ZzTZ3l3aFXTXKA8W0L04l6JQzTdp+7xXMifR1FqqM3oNNL/mv1WQCE0gXXjGErqDBF0qRTRT74ckb1Jr52P2oZTYD2Yji0yy19LAJ1Blc7Zc6pnJOzDgv0Lg/rn/NT6gVkQuNZH7fpbIr2Qo0mfM5UfF/u/do/NNbN4NhKhmf1dQ9RtyVYkqIzu6Y7ZEsZSXv/J2m/v0EtYflGDOyXkZ/gKQNbJevJ9wpRaxZWcRnV7LLBA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790576008; c=relaxed/relaxed;
	bh=ivnkQ8DXZVNOhb9mLyKj3H89pK6FiS2QI5ttq20Vbpc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=K8n937XQCxmgVFB1/QUvRFeI7DrcemHiXwbditC3xK2HgcmWhZ3TrKEyLoHTZWIy4gae+0IPiG6760HHYxLFCUce0Css/0p9V2lA7o+3VU5kFolNNRrjHyTquo3I5xoHvDFIXfcbuil+Fe/zoszTDf7DfUKVAe2KE1n34khmZFxGbgBn2HJNDpU64J8ohWhrbD8yYInZCMVYTzrfJNsY7AbWrQ17cSWii13XLUaC3TgTmHPQQPp3h20ABNvgKJV2e993IVukKV7AOrzv9+0Ix/4LoySJM8b1nbIhsuQpIl4yg6cxLo5p403rhPhWJlwc8ecQeOxz4gg/U1rW8oNBkQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=kQUVANgc; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=kQUVANgc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htWFy6mKSz30Vd
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 16:13:26 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePixIGUtMCNtOYFFG21IdSjiBFphN6dkFohVb2ZzCG8IgXF9gIvISgQ7Drx8gkU196Fw/9ll3b2LbVraHlyaxYineSp6MCjHx0QbnMkgXJ+0dXwS0wgwpxtoW/z13nBiNMir/n99/ZHtN73ZK+CHrUAlXZ+j7h1D571rmwzj2QxQqfKsz+9UDJaTlPiVgzn5IjWGpUlNHV008q9Ag94otj92+R7h5d1mHTyqTnQMbmgrLxcvSsmSMhximEyjmEEOtCw08dSPh3LjPVCHDCa2W+xPfHl8Pm3YkjWaUNTRg09S5Mn2QNBqS1GXp/mC3+9cXyZfTyppm+TNbtvGNYaFGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivnkQ8DXZVNOhb9mLyKj3H89pK6FiS2QI5ttq20Vbpc=;
 b=C6Cwh31Z2O0P7PNn2nXRp8VC+ucMGcyMbwvzFLLFPhQlKz2Trz61lKQ1dopLHUwx2y4k3iT740bnB7HXNq3VmFztHeVQgFMhoLZyS/uHS+RvRmmoD6Sw/vtIte8gK5Xrmu6Sjz91ZcMBPwW6RAmRFWuUF64sgTAiks3Bp+x7krCo8Tcmd275WWqBXWwMw8BhHjC+2eI8vSgtbce6l/boQJ/KUMh0xixZeA2qu/frSdE1872YMv7HFx9061FakT5mkdt3RPJas/nFhSC8cp+ZfJb3fTbcJwz6w8xIy5gVBwEN5hk6Al5gG3AtKOafCjPabLN2jNiawMhhgv5RyqDttw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivnkQ8DXZVNOhb9mLyKj3H89pK6FiS2QI5ttq20Vbpc=;
 b=kQUVANgcS5ttfcohj2OBSNm2QLGNMsV2SbodUVNQIKfgYt96JXCWO3vTP4QdzNxuyx+6CKPpp1mG2NdZK6xM81/FapckpyEuyGdHfdnQGEJdLWw22H01pBlp04ZYgJjCjhrXgnUJpPqlHy0CEwM4Cy7NhWJnSvETWvmRetRrirrKNnr/m0Odjbw6d+8XF/PMi9oc3FnfVV9O7WeWS65xaVdMP+jwf7BfunYmmYe6mMAnZGEMaJ9LhHTR4kLNcIAHz0U4TXrcKBxeIrcmCaEDBkVjwQMWJLZ/N7ZFM/xNFoGk5+Ph5ONnkstDv/uIoX2tyeJesZ9XwqQhGCreWjAk6g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by PA1PR04MB10721.eurprd04.prod.outlook.com (2603:10a6:102:489::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 06:13:02 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 06:13:02 +0000
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
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>,
	Chancel Liu <chancel.liu@gmail.com>
Subject: [PATCH v6 4/5] ASoC: fsl_asrc: expose individual DAIs per conversion path
Date: Mon, 28 Sep 2026 14:17:27 +0800
Message-Id: <20260928061727.1844167-1-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0086.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::11) To PAXPR04MB9351.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9351:EE_|PA1PR04MB10721:EE_
X-MS-Office365-Filtering-Correlation-Id: 51e8f1ee-baa6-4a92-c340-08df1d278d69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|19092799006|366016|23010399003|921020|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	d7puhtk8it0fQAz66JecD1czdhDg+g97Ai6P89WA8bCEQE7ZpcciEV+SBKyCde83Iim6M1X8rbk1i3n+JdnyYM5ZDpIH0ZhVJ8jeJF9rpB+Z50n8nHuoheVBPkNYsDSd770aPPrWu1mohUlShq0w1VxdOFDG1pC3Blcl3lTLuU4UzdVjF3gYSJHVmtlq2Sb/4LPevESTX/C4/ZQjWY7GQdFUzJFgvinXy1WzpP2DvAWwCunhbj50AUcW00NqRDpGJLDKOt97PQPdNsRMkIm/5dAWrDiFpvbtdPJTEA1W5dfOqpWCCdDSBkKRuSxONzr0twBETHw0JLqTpdPP4puoKD2KH2q1fj8E0p1hKF6zLqaYkwDWgEjhylxO2hrC/g40il4V5FHy3FmdtTD5Bk1yqUZWR6KDden8JVM3kp5W0ureDOt3m+JUs7xZ+mCwt8QJFubpvl/zLXGGjeC4i9wgLXJOaK/xrdMdS5voOCT1ESzhxQIBDc7D8rJ3clHWCGlknFqFojmNUOywt/6N2gQ8o25W5t0Lengtj67V9JQALtcN/wyFD2qYEaXWbwIA2vMd2xEJE3Uqe+Ljik+NamgP+AI6pP2suUdfK6ARwzbVBASX6b81SqxGeDSDd+t+2ZILPN0f4io3ubcQBzwTJFEcY8dEcEGCSo2F0x0RUMH7MBWHIDbmhgaUR3UsketcMQOwuEDQn9J2xDQz/6/MqX5WbA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(19092799006)(366016)(23010399003)(921020)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vUbJq25ec2r/dJfMpLsnlo9sQJRViJiqJyXBSrzvpc6p6ZVBf6cJN7UmYBcA?=
 =?us-ascii?Q?1PQ5Vgg1Ld4lsFdVwZBzvaRpmyaaRSSyEqK7+JTf4u8x/xJZcJObji7AXL/x?=
 =?us-ascii?Q?xiB8le8/DM/M7CHfgiWeVQtQAQqPTFD6o6ILuv+IC/9gOgTxLu15jDGbHezy?=
 =?us-ascii?Q?rc6cmP7i6EA1GZ1IIDjiTtrfu12AHbtRtPIoDD6vfSTYhPAifmiwQ8OOmUPx?=
 =?us-ascii?Q?K+RWDJCiOb9nnMIOmucHtGUYQ3tRUypRsHJTrR9pm+ryvruxXDNpePStGsGm?=
 =?us-ascii?Q?OuKahv06qvgig1U3ejLpd8VZ36vHWzPSNrL63rkrBwliQyidYHEeF4WLDurE?=
 =?us-ascii?Q?JxEWZVIhtJghVngXXk6UOzcy3W28HbYVdxQMi2gS3kStFyDRYfgcVa1sXpEo?=
 =?us-ascii?Q?B1TAaYViy23hHq99KkL90ruZzzv+LGNNHb6LMJeF1gEW+rcBJjgNCoKHOjG3?=
 =?us-ascii?Q?Ati/GJ1gFLsk0SutkFPlQQWYYgsslawnoEtqNztBOAGW9aWPTyebFOIP3zB+?=
 =?us-ascii?Q?1SyY+dousM1IGZx9wlrVSJnTDccI5xMbdev227eASEJnT4cRWM8wq8PNWKQh?=
 =?us-ascii?Q?q0zzCxS7te7NScpzKZQXfDaBDid6l0zgIxbmHw/EtoJbjDTDvFy+fWu2fc10?=
 =?us-ascii?Q?8XAMxyTByK3inXmF4JJRR7ur1lJAw3usC2oq5lwEPvwvSKqaaOq4SCCo+cNu?=
 =?us-ascii?Q?83JgSf8/3PCU5ljQtiMonxp4oSmGxWI39J5jTqpxDwlcEBy4HCetgjEkkM+E?=
 =?us-ascii?Q?ui5c4X3/fagiFT0fWggpvyUUreZp92LRcnpaYoIzLd02guiN96UOZ8f7Xkld?=
 =?us-ascii?Q?3vNyUHCTp6p7eUzwmpapWwUIvbKTxOqaVzMw8LakwOhTBDu9vhDxAvG9ctFj?=
 =?us-ascii?Q?LDYa9D8CXDEuNUSz2WX6Dj1XlDGPD9qZ/8P6tR41s2pSWK6tr+9ftP8L+FKm?=
 =?us-ascii?Q?SXvRnI2jAE6QcjKn4yhfj6var0llAOJPnONrknGzLCECoRt79aQdIbznomcn?=
 =?us-ascii?Q?3PY3N29wnBSjBJtaw82yaIggFlef7HD6kyN5NjWpCFhn6oBgXxWZr8jwFiJ9?=
 =?us-ascii?Q?r6IW6A6XnWU11FhKGsF4fknBcvh1VQnu2Vuh+SQIq7MsKreLk05b8Z3Gx/j9?=
 =?us-ascii?Q?TmcCBDCyeBzQ3gJcar4ekqDv46rZA9hOLq0XBiSVycmNw5bM/gbtX2+QlrGE?=
 =?us-ascii?Q?Fz+rFYUwoQML8WvpIf22dEqRMknWIFJD0V8XL5PkdWFVon/owVqCsOryZYQb?=
 =?us-ascii?Q?SKC57Y0wc0WFeayH6edBbEujEOFLxziUUGBD3XsVt74QHW5QDmD1liARZJrX?=
 =?us-ascii?Q?IHTznWzxgGz35f6q1ur/mmUFi6jr2pshbWDfv6s8EXy6ibrfh/o5Ul6B9Yx9?=
 =?us-ascii?Q?Mwq/3Kjx1FvU8YO7hThiL3wxdGfIZZp6YjUNyGb7iSSvGCbKNYW344AQvLxw?=
 =?us-ascii?Q?RsAR5r7AzaT0k1nFM91d3pkzsLSJJ5yvZDevx3v9ALh6daUR/QO1bZcyN5RC?=
 =?us-ascii?Q?qF7wLxY3M1RJuicNbrWm0CG22vIh7SWYQ6odl5xp0l6k6s+/QlphpTc02ZlA?=
 =?us-ascii?Q?nVffpYoORxGcP16byb7uqp634VmdjCpxKk7hD6A9GoTSZZWGwU39dd06CnDA?=
 =?us-ascii?Q?qN4FgsC5oIUryV/PmeTJtgUDUJGWREbxKNXR4qYBl3gLfl51BHMyi2Fm3dmW?=
 =?us-ascii?Q?ClFvTNfiv8NTya6UbWbc2r3IwP34/b0UV81pZUE1nONSoM5kwPzomzFiK2dk?=
 =?us-ascii?Q?w72D0Q1zrgu5lx08QOUUCwx2/YeFx1Q6Z4lWE9KhOmmMziPRP58t?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e8f1ee-baa6-4a92-c340-08df1d278d69
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 06:13:02.4987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wz3uZE7DwP6pCzuLQPjtjU8+G01OskghZPt0OmcUAcaVBcql2OlpBWKmScKOu37Z7fSsj/iBxWMT10ClqWPdkLD+F3fKjF4iFQ5FOVi/4z2GbotmWo0Xo6m7s6eS/We2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10721

From: Shengjiu Wang <shengjiu.wang@nxp.com>

The i.MX ASRC hardware supports three independent conversion pairs
(A, B, C). The driver previously registered a single DAI with generic
stream names "ASRC-Playback" and "ASRC-Capture", which prevents
multiple independent conversion paths from being used simultaneously.

Replace the single fsl_asrc_dai instance with an array of three DAI
drivers to allow up to three independent conversion paths to be active
at the same time:

  asrc-0 -- ASRC-Playback / ASRC-Capture (backward compatible)
  asrc-1 -- ASRC1-Playback / ASRC1-Capture
  asrc-2 -- ASRC2-Playback / ASRC2-Capture

asrc-0 retains the original generic stream names to preserve backward
compatibility with existing machine drivers and board configurations.
Each DAI retains the same channel, rate and format capabilities as the
original. Update the devm_snd_soc_register_component() call to register
all three DAIs.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Chancel Liu <chancel.liu@gmail.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 sound/soc/fsl/fsl_asrc.c | 89 +++++++++++++++++++++++++++++++---------
 1 file changed, 69 insertions(+), 20 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 9be903dc75e4..faf348dd582d 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -792,27 +792,76 @@ static const struct snd_soc_dai_ops fsl_asrc_dai_ops = {
 				 SNDRV_PCM_FMTBIT_S16_LE | \
 				 SNDRV_PCM_FMTBIT_S24_3LE)
 
-static struct snd_soc_dai_driver fsl_asrc_dai = {
-	.playback = {
-		.stream_name = "ASRC-Playback",
-		.channels_min = 1,
-		.channels_max = 10,
-		.rate_min = 5512,
-		.rate_max = 192000,
-		.rates = SNDRV_PCM_RATE_KNOT,
-		.formats = FSL_ASRC_FORMATS |
-			   SNDRV_PCM_FMTBIT_S8,
+static struct snd_soc_dai_driver fsl_asrc_dai[] = {
+	{
+		.name = "asrc-0",
+		.playback = {
+			.stream_name = "ASRC-Playback",
+			.channels_min = 1,
+			.channels_max = 10,
+			.rate_min = 5512,
+			.rate_max = 192000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_ASRC_FORMATS |
+				   SNDRV_PCM_FMTBIT_S8,
+		},
+		.capture = {
+			.stream_name = "ASRC-Capture",
+			.channels_min = 1,
+			.channels_max = 10,
+			.rate_min = 5512,
+			.rate_max = 192000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_ASRC_FORMATS,
+		},
+		.ops = &fsl_asrc_dai_ops,
+	},
+	{
+		.name = "asrc-1",
+		.playback = {
+			.stream_name = "ASRC1-Playback",
+			.channels_min = 1,
+			.channels_max = 10,
+			.rate_min = 5512,
+			.rate_max = 192000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_ASRC_FORMATS |
+				   SNDRV_PCM_FMTBIT_S8,
+		},
+		.capture = {
+			.stream_name = "ASRC1-Capture",
+			.channels_min = 1,
+			.channels_max = 10,
+			.rate_min = 5512,
+			.rate_max = 192000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_ASRC_FORMATS,
+		},
+		.ops = &fsl_asrc_dai_ops,
 	},
-	.capture = {
-		.stream_name = "ASRC-Capture",
-		.channels_min = 1,
-		.channels_max = 10,
-		.rate_min = 5512,
-		.rate_max = 192000,
-		.rates = SNDRV_PCM_RATE_KNOT,
-		.formats = FSL_ASRC_FORMATS,
+	{
+		.name = "asrc-2",
+		.playback = {
+			.stream_name = "ASRC2-Playback",
+			.channels_min = 1,
+			.channels_max = 10,
+			.rate_min = 5512,
+			.rate_max = 192000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_ASRC_FORMATS |
+				   SNDRV_PCM_FMTBIT_S8,
+		},
+		.capture = {
+			.stream_name = "ASRC2-Capture",
+			.channels_min = 1,
+			.channels_max = 10,
+			.rate_min = 5512,
+			.rate_max = 192000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_ASRC_FORMATS,
+		},
+		.ops = &fsl_asrc_dai_ops,
 	},
-	.ops = &fsl_asrc_dai_ops,
 };
 
 static bool fsl_asrc_readable_reg(struct device *dev, unsigned int reg)
@@ -1393,7 +1442,7 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 		goto err_pm_get_sync;
 
 	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_asrc_component,
-					      &fsl_asrc_dai, 1);
+					      fsl_asrc_dai, ARRAY_SIZE(fsl_asrc_dai));
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register ASoC DAI\n");
 		goto err_pm_get_sync;
-- 
2.34.1


