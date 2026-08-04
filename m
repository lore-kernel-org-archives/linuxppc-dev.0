Return-Path: <linuxppc-dev+bounces-25348-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCA5C55172
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 09:56:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDppP2MlDz30C9;
	Tue, 04 Aug 2026 19:56:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785837373;
	cv=pass; b=CQm2wxmduoqoqlboiX1gMphLtNng4lWAPMNXnvDQvEBn/GxrgIj5sorpLIsTa78AldtRR1VHQ4fCpmOgY8NHM0p10788G7hjB7v0dF00ZpD1RVEL0YFUvDR6dFI7YBmP8lMlJIedm2OkrckdtN5GlOa1D5GxQeTvwtOKR2x9XNziwUajO/kJ4HDdvMeXtxEnzQ/UbGaUmcrrYiCqe2ZMcq9akoGrTmFU/bZt+CJ8SSMgcimhALVHTiWHKuAKHevvC0yFUSEqaBXYVWsm/JNV9m2L/B3Qyo93WSlnzsRRAqfaK2lr24wmxw8M+xSIQmlJtjMExt4jBptxoHjrtx69zA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785837373; c=relaxed/relaxed;
	bh=ziM/S/jiLWEZ5SO0amJrXFxj4SA0GCYQHxv2OrGEyWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=juKypCqEiuyzj74RUkth7NBv2RqO36/9yR5M2SHmP8v48rW6+r40ejFosZe3Z1FRJyKzMc+oA/yyjjVbwCzfUMFDH0whowfdOIgyYuLIzigVKdZnK0Ymd/Iq8LXFEinEQyR+LmTDdPwGESC4OSm0JYjlsOw+U8hYdCDf84CdYxmdXyExxWX67NwgHB1B2gnOO3cF6GxcVqaSHF3ecrAlioIia7poOw8WasIWhp9PprTaGmA1S40Tu1Sej+O4pJS1EM8pxmimItGDAzgdukH8eZSWxSLwnwH7X+2+MgIgBe2xuASdp8mcFIzkBVhhdBG5TDhsbRw9ieqeiSR6/DQY/A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=a9v8smSV; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=a9v8smSV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDppN3VBCz308j
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 19:56:12 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rbczoz6DDL+QN/LcuBwuEdDhVNmTE9beKWSBN3PfnaCPf/XtPaVM5zGOaoUArTQGFKYUgfdHZpfzhvxzfM/Ah5MadyyirhxZPjf49XvG6PYiYryzZq3nagye53gEIYNgm1C0v7Dl3rx9JxatXJ1eskxYYXZZQocX/cBXx4NyWw87BJOM7ZiBsAD0CPLHODa6Bb70NmdEPhtK1bwW58AVwSREnM2E/7M2JNVxF8IBtff+cB+kAWoMixNmO8YXgj/ZnrC3fPFLuATe4x5kiTQn4X+HDupGCsjT811M46vlLmbRtHNK2uum3lxfcux52MheoKvVGibjHiUeKG1hXdoiXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ziM/S/jiLWEZ5SO0amJrXFxj4SA0GCYQHxv2OrGEyWs=;
 b=c7jpKC76HmLtIO7++MRUxfpT/DyglBKrEKFYmaJQZTKnrmtbVMrJeRTI95EIcO7rzM5+lQduSoM6i0HT/Zu5575bn6herR/6mUOt7j0rZvZ4pUjILnWzZzcxqM8Kw1+bf6v0t8gIj84gqc6DHxCERW8GzFm2/CphS8jccLEdMDylKL/JEC3xp0ZY4HUaTkZNGtr+pE8sa7rPJdYuDUMpKjvQDd44keckfqwocfgyLAUqW/mcHWYVx1loVZgyoXv+5EKl6szKknV1gM+fKAmOqAdsNPu13zD92YKNmIuh5IZolYQi5/6eIlr+rtvoR22j4qkztR/mkFg8yry033Y6yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ziM/S/jiLWEZ5SO0amJrXFxj4SA0GCYQHxv2OrGEyWs=;
 b=a9v8smSVIwWnlMyQ5wmOLOl6kYumJaiaNHUKR9AHwpPivJrzQ4HgzyCuTguPQOpnjJMgb38yqfJT1qA8DhKFSDvSN7r/FBg+3J/t5psofT1rcPcsj+pQw2VpiuJPNAlhuImbxHXYhUmeVkFWCBoSvOQ9d3zU3PGqgEGUVQQdP5AXdjYNpXFov8Ag13ScNvkBGVmhlC9w8hxhZRge9zc3z/+9np7kG26mS/Gji3H6DQv1ZksrLLfdWAKo/2cGIjEHZSLPu0hqbJXTwhJxkjUokPotT0Y5FDfLTyBaTYmIP9do8z1kWfIaRvL8ZcdJnUO46HqCPzfccZ6sCMcATdwHIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by DU0PR04MB9465.eurprd04.prod.outlook.com (2603:10a6:10:359::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 09:55:51 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 09:55:51 +0000
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
Subject: [PATCH v3 1/5] ASoC: dt-bindings: fsl,imx-asrc: update port binding to support multiple paths
Date: Tue,  4 Aug 2026 18:02:14 +0800
Message-Id: <20260804100218.49587-2-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260804100218.49587-1-shengjiu.wang@oss.nxp.com>
References: <20260804100218.49587-1-shengjiu.wang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::10) To PAXPR04MB9351.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9351:EE_|DU0PR04MB9465:EE_
X-MS-Office365-Filtering-Correlation-Id: de42cf4f-ba48-4c9f-a230-08def20e9119
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|23010399003|1800799024|366016|22082099003|18002099003|11063799006|56012099006|3023799007|6133799003|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	VKpH6kYon9CSOOPqE3fePu5Xk8m2jVvdpVaV+Zvz2ZOD1mQ/JebIeEaxJPXX8Kp7nSNk5JqA+WesSM9obXU+4inBBAJSxhBqN9kYtlls0OYAgLKJA+0t9ZDAB+WKeyxSoFnR5fy0vYcALDXDj6T8FLuuUgz96Bq/IKytPSwYSK/caM6jkkjWm9Hem5KqNhzltF4PAX0nQEJ1SiHaSBqn2uw5Rko6KMV8IAumjA+9oMuqIddhgYBr4wiBvRGHNHJ5CUpaOgncfnr1mkwCXxPkyHISL2G/wZR07GrCkDzNxxw8OSq0vP7Wzf9BnYTFKh1umCcaBWcxR+S1KWqRCQdTRSuGYl8KIMR21UCAJ5iFAtyycphNICsoClXPVXyXAhwwddqPP1qleuBpZx8gqiKqyPOGkYmcTRBkags95VRzkbA8Fh2Tno1k6waRybb0esgbjxtJcQQ5NH7qKcLGyawVM9skOFuRdraERtbEl/ygvS1rmqIJ5SXI88SuIqi7T1rq13fsQ9TH/S2kjOYW0I7WHt40TF65u0tqUntajm2NkZCyGfrfFoIf/ZrfSo55ae2EwR8xkTL7hPJ7sJt9gripl3W8AQWB+uJ4ukA0zPka6gSrgdrnYrtl/xC+jW1fwni1sHp46HEXFk5VJdi6hwdTZmaKYl5+z+ARyfAEBO09r0phEFdsh85ivvdgXkaRih2wbczNCKYTtzD3wuzehgp1JQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(11063799006)(56012099006)(3023799007)(6133799003)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qm2LElzYbWqhDUB6eMi0JfC281mwaEsgVzyf4OPF+QuXMY0w9PlT6Lp2M+sM?=
 =?us-ascii?Q?uCQWr0Xw3OOcPWPptt7sTxjOi2ogDiL0+vY3+4X0hN/OTH1pWxfkbG4GBluU?=
 =?us-ascii?Q?pJMlTkznbA/PSSoQsroquklgFDyiXX/qNFYr6PnvgP1Y3RpFj+irl89FIsPk?=
 =?us-ascii?Q?8FJYejHhyx5mpN55WSHR/6dbw1TgWwG94zTa/lJ2FH1krkYg2LRw1MaMC7Bh?=
 =?us-ascii?Q?nVmRy3VICEnvvSCfYW2dFUDfIKhKo8xspTqhEFEACQhfurWzhl6AbYXDaRC5?=
 =?us-ascii?Q?pzkXKrLPJSkyD323pvl8qq/8Pb1v2VfysqNNQaueObPKlMHOuFLaa2o4l0Pq?=
 =?us-ascii?Q?Q4tWgl9LGPlQC6CocaFPpAspyLXdx4AehRzpC61wSGxfchQ1hd6+zBC76PKa?=
 =?us-ascii?Q?xk6TNSvLExY0Fe7TarQhiwaknWgX4+2OYLvCS+9cqqvcobkhFanMVuuK4lN+?=
 =?us-ascii?Q?FbF8kWkIxRcyAEXOwLnjLv53q+4IosEJsVUaCA1/o1UjvaOGSMSpwPuKSB09?=
 =?us-ascii?Q?FR1KSVKmCt0rzk9REcFBiMBR33pRCtO/mmgWF0/anZS2c2J0Ez5qJ3snD24G?=
 =?us-ascii?Q?0974eKu3515F2DVr4lfflC/qtsLp4N4pezwU1hfg30morhwn0AbiVLAR6oVI?=
 =?us-ascii?Q?Xof2sVHz8juPfRSpeRBDV0dUQqialeLYQ4RdcCmPFTDe29eRmMs3tP592Kdw?=
 =?us-ascii?Q?UsZlp5jCcTqovJk3Hf7VF3Sr/Gw9/iQ93egM6Q1oHeId8y2Nxdonn46IjORW?=
 =?us-ascii?Q?n0uVFypirTJHIUtq9H4BaQPKR8TLR+snovWUv+uM63ofQqW7H47qUEZDYSYi?=
 =?us-ascii?Q?+2e0d9h/RfbQovgsD5KLj6Km/OFI7vRvnBZMcTqzMOqp2szd89gzqPIyV93O?=
 =?us-ascii?Q?Apiod1mz8phTaxyOVb9v8xmuNbSo/BXoqh+4fspO9Z21Jxi1ekjv911ODzdV?=
 =?us-ascii?Q?dz6iRwYfbm1AWdRPbrl0x+eipOpbV9K6Ih8aghHLao6p56vXyM0sZp0E3kU5?=
 =?us-ascii?Q?O9++PcFh3tttWWasP8yU4Met055j4w4Aznjkzz8njkOvxqb+/MUSjE3GukNL?=
 =?us-ascii?Q?49WfnXxvd1LTkZ1nPR08lun4LuipNF+qU6grCFTgjuvgPIVwYffextNopMa8?=
 =?us-ascii?Q?DmeP4joieV7gFQuQLiKrRzWWKWprjhcpHm27ONHQB1rgz342yBYYbyx0O0Rv?=
 =?us-ascii?Q?eHRIc4jRAJ1kGy8dLXxz0T+mmRhXZHFanMID9SGM5YxI1XvhuXDpWxLG24VL?=
 =?us-ascii?Q?NoTOIkWQFDQyZs5WMmIXYTCHFKEgH33e2pif/oV1Ivs5p+/ZWFEhWk/mUVoG?=
 =?us-ascii?Q?aI8VPH/9jNUL41oAFpinrWBgBEB7fYdPEIuAxX4r/nz8BXouPhDwtpl5aaHf?=
 =?us-ascii?Q?EAB7WtrNOQ5DNW8j+LhuPdsZ4uQmDaKmCJReFl67ldF7B6hOVwGlJHJxv82s?=
 =?us-ascii?Q?Z/IQja2GvWCEmQHAWhZNI1TsIOK0N3JfPtadqwE4BeI9N6iVh6jlG/YeRAqY?=
 =?us-ascii?Q?qxvC74mNWNmenHqpXM1HYqQcmY0Wt/7dn9h0qKobJ1TpOOaY6sEpwjGglnpe?=
 =?us-ascii?Q?nBgeRrzuhi9FAihWNqX8hJU7C0EJ23BGG3YErY0gjXQr1NVIROp3vYqlryxA?=
 =?us-ascii?Q?wTuhqi1UZseBEhGPfOdz0trr/gI+e+STQeVCM+GEpNBN12fpKZ/PMEsMpZ9a?=
 =?us-ascii?Q?Rvc+3C2cpLjn7CQV3AhoNoRRRlYu+v5vc+92FKNPM0TZIDlp3OW/3m52RGlv?=
 =?us-ascii?Q?iP6LMvULt42+H31jqAGh7cN4MJc/fDgQ/yP9rC0pbDThuFaZTJRY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de42cf4f-ba48-4c9f-a230-08def20e9119
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 09:55:51.4999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wO8SNqQNnrliLq5LJLbI9WUCGMa4nA4agRAyx8Z4m0uaJ1PmQBkVLyaPUurCSt4zwhWzKYkxOeayUKI8JaiOfXL6ySsS5Ui1uj8SykfEWLb6bRo0QIREdcOzrJxcOZtA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9465

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
that both forms cannot be used at the same time. The binding example is
updated to show the preferred ports form.

No existing upstream DTS file for fsl,imx-asrc uses the previously
documented single 'port' node, so this change does not break any
in-tree device tree.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 .../bindings/sound/fsl,imx-asrc.yaml          | 45 ++++++++++++++++---
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml b/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
index 608defc93c1e..67d2826eef3f 100644
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
@@ -180,11 +194,32 @@ examples:
         fsl,asrc-rate = <48000>;
         fsl,asrc-width = <16>;
 
-        port {
-            playback-only;
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                playback-only;
+                endpoint {
+                    remote-endpoint = <&fe00_ep>;
+                };
+            };
+
+            port@1 {
+                reg = <1>;
+                capture-only;
+                endpoint {
+                    remote-endpoint = <&fe01_ep>;
+                };
+            };
 
-            asrc_endpoint: endpoint {
-                remote-endpoint = <&fe00_ep>;
+            port@2 {
+                reg = <2>;
+                capture-only;
+                endpoint {
+                    remote-endpoint = <&fe02_ep>;
+                };
             };
-       };
+        };
     };
-- 
2.34.1


