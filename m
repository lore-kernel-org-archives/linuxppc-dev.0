Return-Path: <linuxppc-dev+bounces-25665-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441D2C5AD4E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2026 09:39:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJV896HHHz30T0;
	Mon, 10 Aug 2026 19:39:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786354761;
	cv=pass; b=LNApAL8GEx4dtHQ6UL4AhCmVx+jcIQoM1u07H4jhjbPv9jIYXyJ3IrD3BgMfUEo1MqA7IjGYAZ168zK5Uxl73j5bGnH8DLbTWQXFj5NRVKOgLWbb0I9jpvEEWXFDG4tRLWoGUXau0RXx+H9HsvUsLY1BpHN9tMjDvIfjNM51xEOLkTtQQ5QNivZK0DYzRpKzX9nBtSKkSZMx4oeuJZuLnt995Apf2XoyfOIKCvSLSq6lhiaOD5CWnSrQ2sTn1KjjXN64MVDeOKrysz9GocSdg+tHVUOhQ1wDDIDvhr1WAhJkui3uItq9fsL8Zede+vHQwV696s11gigtOOAKKJWdFA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786354761; c=relaxed/relaxed;
	bh=xFGpd67j23hDSxPUCfE6j0kIJXgBjA89GhPIJREdMVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zidv+atPmYausZaPpZrHrB2Bm5e82gilC1OgqGHcWT0OdzYfzDzRJ+kbJT0ZzwVZplQw+wF5QaWWhBpPkgkyRZU85SWWhOMo5O5qLuWEZ77kbbEQoYpevcE0JGEePckYqxppW9LWNVFFfe/QoUhBGCyGjgdTrSejWvQRWb+tLDztILutyeJb6NCRBTF6IMdS2i8o7jndks8KCwjWPJp0fpHK0fIxOtpKuKWTlZpzREEsJUalKSs+1rTpjP1umV/mTECmGfJquSd/Uyihxsok9fA5BiXG0At4ClMKJIP3+rCg8OkSqBN85xDuOVO3Yn8Inoq5JFy/CfNP1sLHadaM7Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=xVBMNIfQ; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=chancel.liu@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=xVBMNIfQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=chancel.liu@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJV882Yf2z30Tx
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2026 19:39:20 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e613H/d3qrQ03n0nXLoW1EkuRTU2lSp+l/PN2NiI0pyAQPg24PQHiMSefCgr5G+GravRQbF0lH6/8VxOfQPerq56gBwJsGKxIH3RPDBWjRu0zyhjcoE/shvK9WTYKmPtbYiBSiHptYMMN4Qh43hJ93sDMO2eApdgHhOHSAuJ2XxNNZ37to8jok4py47/j3/U5z/6PnEnyEiROtR1sZxhFGfPDp/ohYuCXv7x4OEQaCDoBF3FdN/76/rJiWaauM0JEej9eFOdZeumVNOyDAzGyWgIIJudsz7BBviRRQEWpxI86Lzl5aWWc+XAsmM2+cAUHw1uVAjSJA5Y415e21h+/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFGpd67j23hDSxPUCfE6j0kIJXgBjA89GhPIJREdMVE=;
 b=pFiCSiXYoZbf5NX1Kj/TCcuD5GLCfowJylB0yI3FUsLHSRFvUQeobikb/2TaBcoTMS5t0z9VT/5OZuVzrKCaewcA8hGteGRa1HnggWkYsTB06H6Gb+giRDd5QZ4q6Opq5xX2s8LDGWRoaZ/0IHLIPs9384aPMZPHx7xQO6nN02ptualfairMbXgZsz2AF7jI7tRVAo79Kh9nfp05EFgT4TXqDJBQdQcEahULdR/8LbqDtMJj3m4M5P4l19GA9sJv6x1S9hVonblFMoZqKhPkR0zAKJTrrRoaSFil+/kwBvyZna9+w3WEw35ucqoltZEaemNbBjkkbnT5WLxr4SSTFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFGpd67j23hDSxPUCfE6j0kIJXgBjA89GhPIJREdMVE=;
 b=xVBMNIfQTFdtV5rvjJwxiA1BeGO9PmiBksG10A7gsRv5apfNUssXTwlj8BYRU/Wz1ftWSrfPsT/41Al0lEWGf5PIjmFPVT5XusgW4dxSO+PfCX5vQCIqosqVef3WppXD/QIFdz5UEp/Chjj9Nb8RS7nPSAvTxO8viwWOVHZXYnoYqDQyBejRixvwcs5zZj19hH2pjX/ty2xInoN/3GtJtoH3exMT2Izt/FXzgQ4LatzAt/mVLvZtoZk4AKntRlZUdCJwSThtnE0gGimrzgO8bV3xjnEgf3AXbpFAG1RmOM6JEYQ5fL5Kni7f3pTGrXHpX5RDjogsjmp1pLhUm61Q5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GVXPR04MB10021.eurprd04.prod.outlook.com
 (2603:10a6:150:112::20) by AS8PR04MB7557.eurprd04.prod.outlook.com
 (2603:10a6:20b:294::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 09:39:02 +0000
Received: from GVXPR04MB10021.eurprd04.prod.outlook.com
 ([fe80::d247:853:3e16:1994]) by GVXPR04MB10021.eurprd04.prod.outlook.com
 ([fe80::d247:853:3e16:1994%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 09:39:02 +0000
From: Chancel Liu <chancel.liu@oss.nxp.com>
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: hui.wang@canonical.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ASoC: fsl-asoc-card: Move bound-component setup to late_probe
Date: Mon, 10 Aug 2026 18:35:31 +0900
Message-ID: <20260810093834.1511749-4-chancel.liu@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260810093834.1511749-1-chancel.liu@oss.nxp.com>
References: <20260810093834.1511749-1-chancel.liu@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0107.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:3::22) To GVXPR04MB10021.eurprd04.prod.outlook.com
 (2603:10a6:150:112::20)
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
X-MS-TrafficTypeDiagnostic: GVXPR04MB10021:EE_|AS8PR04MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: fd2b7b63-83c2-424d-c296-08def6c33625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|19092799006|6133799003|11063799006|5023799004|56012099006|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	txm7nr/ZPYfeiJHfhOno/SCgPZgnPXS012f3jyuCR3E29Zx3UO213tpXWeutTdW0nOIqN1mLsk210FB9bgbQWcR4LjJEqw4epsniqmH5/ukA1nPFiJkMM+FbEMwT+KW2QEPw5MytAy1scmPseuLYFzEqU87YRLij5UzQpc1Lxarc/Q9Tb8DSt4oNsNQjYxFjGVmA6JEAI2VOR46us0Z3c7QyPNg3lCE7c4h7knbheJP8hiYIGnsFHcHTwZZ0v9Vaqlk7PRxU/vjAgSBY6oqUIKkDFpUxr9tbUMHDL58A3raeLEX0CoFLKAgU+OW9adVxhbQRDTRwCSkS3VHDlLK5FL0b1FzVwEqgMXeq3iDy52qoxrjyEFG9TpU7oSW/1Un4QOYjXtnKJgB6PWBEn+OXzZKr0XeFvIAjHypzjwUf9Jm8McJRbJiW4zSjdMNyds+Q7v17jKyhIflwey1oGOGKDTpHykP1z8NDJNAdG/lMzcuRmeyzWfjAvP0SjHqW/zsZ89uyHchbQ3ldIAS+MRWnvPFCrSwLuVMEGay2q2yKSTaDOvJ3+/Delm1Mbx0R5W/EF3OWbgxFPUz3pseETR6fcu6493fQi8Jx/asXWocFnL8gFcOPhGjbLBFj4OcOIRbk/rBkFs8Wl0qT0R/Xbb28drywwwDRmtPbpL/MrAkNyvA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB10021.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(19092799006)(6133799003)(11063799006)(5023799004)(56012099006)(10067099003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?57FA6cVX94P1ze67u8OMEFl4Nz8Zokvc9DRn8ypwrzha2H/NHzrV99SLJM3Q?=
 =?us-ascii?Q?8odUKaqryqsYJ9bBTmaqqkTzwsfOQcvlwofWSfi2cY84Qpnw22dSlFNQqAiy?=
 =?us-ascii?Q?J1ippLBXMxMV8cibmS13zdySA1Cec8lbbGu+x5KN6oXDHdhBRoYYBSKQ2Vsu?=
 =?us-ascii?Q?lfbcFL0gOeloAjLIZSNyLRtKqF66AIO2rhb318nMbnQvuMfLsjW4Da54Rrm7?=
 =?us-ascii?Q?5Ls57I766/pg72eqG+W3/0HfakrYr6xH+hFQsus71Ng9sIaLM8l0BHGwHd2g?=
 =?us-ascii?Q?AKIQti6PXO86CppJy6Dxzg93gTUkOcfsqtvkQpNpJSzhhMpQWKQ2KVRl1rdN?=
 =?us-ascii?Q?hNNTF4PFhXBQLhHQMxTUq7F2xQafTlgRxNpWFuUz9ViIAelOriOR8MrIOdF0?=
 =?us-ascii?Q?gGrTJiyvRYTuZXIWGypBbLc4TYj5pM3AAG79vnhRvHkuCs0Pu809Qp1J8tI8?=
 =?us-ascii?Q?TLvneF3C4J+zFw3At/bacWZU03V0EXpKOr1gdAEBR3HpD0w7CggTxmua2TtY?=
 =?us-ascii?Q?pYG9Hk6WK24WLyWFyC3Jd65xIKrva7oEw/h83EJPwW5iYpQr5zzCnUwMAZPf?=
 =?us-ascii?Q?2LN3Q2Hmcw+36U8M1qXJkSMUJ06Xb0d6iB/PsjL0o1yHySpTLBhM/XBg7mo9?=
 =?us-ascii?Q?hdMzOSIySMWOO3hCmoYis7pdFoR2yabIwifLC7KBeCCN9M9xfsqWQ/BmdTrf?=
 =?us-ascii?Q?RJSV1yvl7ai1wwXwU9JW9exV0AT5KBqIM0PcneRRwjBOeCwj3YtKt6Gp+Icj?=
 =?us-ascii?Q?5XQ1PqS81qxgKBQGHCx6FH/nD/v4YCxuQtoUaGSkDDf5U4HFh1cUFYBeITQt?=
 =?us-ascii?Q?ENGDhZoNAqICgiqTBiAfvLBVDTIxv0XjxGlSKf6hXOCpc+zd1/e9icTER2OG?=
 =?us-ascii?Q?DAR8OMzHjo6tOKGPwIXRz2+UhPK95YluYolOhdpCf0CN6j5oWO1cw5HRimnf?=
 =?us-ascii?Q?qK5SEkgLGe7RuHB0mvnekSFPZPH+LGrXv6Sr0eaP0l+av0Meyo2sPDHzZIfH?=
 =?us-ascii?Q?p9+qhFALCFr+rm95sZNivvvQo6hWkhSQLRE12ZpS+QpbdA7qmmvkAojjO/mu?=
 =?us-ascii?Q?d1F/lJraC0KsLnfysjjvPT1TIkd/3+o648FUJvgnJBrSx1cROgX6Ms19PYR1?=
 =?us-ascii?Q?wsIQC305wohIl5BpX+EKzff97ZqDtOka4ZQh1TN/0aXnHzbBsL4fuSnoGsk4?=
 =?us-ascii?Q?v6PZ+Fa0/DzZr6urctSEPCwK1LnGojQLWXx7FTznQThWzJZnbT1Ckhk4N/4L?=
 =?us-ascii?Q?XY7rQvBDZZUiKcgUJ4kDdtMBos/WGAeOOVRHnoXvTk0xJ5rkLvdbrS7bJyT9?=
 =?us-ascii?Q?asnXUBU0SFYyEDxgol+f0i0LzKszZ3qzq0MiOJiwrRQdhEG0MX2tQ42BS1I1?=
 =?us-ascii?Q?k/X71gs4nJwd6z61585qSI7d6Hdltwce48dsNDYGAskXI6/RsxgxsMQve/Fj?=
 =?us-ascii?Q?CoAU+tIGPQUSFo3TXJVHZvfwIxahhXw1T5VqyJO0Yz5lO5w9DIvA0KWJro7S?=
 =?us-ascii?Q?VNBhIC7vGO3kByIDpnrxKtApCeenSXwfPCqGEL2/vDCr2rCAu/lThCaGbyQG?=
 =?us-ascii?Q?DiEm/nJZtw+WiEaURhGASc1fqfOcOLCVm39OIE8jBsXHEP/OqUNCF5khdu95?=
 =?us-ascii?Q?GTmKJGG6iZMrCyax3CNVaPASszi7/ABKkYsUSHw6JcustrAPe6/pfvIfSxg3?=
 =?us-ascii?Q?05v9IJ2hpQnfyIhTjU3F9eQcH6MhFsiJi7CLDHEgOVsWG7wx+xsLYfb1Ss5g?=
 =?us-ascii?Q?01VexZeZ0cPnG72Jt1fKFac/Ow/sPJTeFzkdG2rnMxcJty6P+FLX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2b7b63-83c2-424d-c296-08def6c33625
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB10021.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 09:39:02.2709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lOzXILb7eYEsSUC248mgvyfREuZ6vw8L74cZiHPHrAhmFA2asQXCsiYWoRQgehNbpOwWNh97LEaO8Dsrotnupku8YkMjBCKpBCeY4TZ7u9tasr+yVeAAD3UsLgdMhDks
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7557

From: Chancel Liu <chancel.liu@nxp.com>

Move all operations that require bound codec and CPU DAI components out
of probe() and into late_probe(), which is the correct place for them
now that ASoC supports deferrable card binding. late_probe() may be
called multiple times after an unbind/rebind cycle, so every
initialization step is guarded accordingly.

Three new helpers are introduced:
- fsl_asoc_card_init_cpu()
  CPU DAI-specific setup. Previously done in probe() while CPU DAI
  component maybe not ready.

- fsl_asoc_card_init_codecs()
  Reads codec MCLK rates from the bound component devices, invokes the
  per-compatible pdata->codec_init callback if present.

- fsl_asoc_card_init_jack()
  Registers headphone and microphone jacks.

The call site of codec_init callbacks moves from probe() to
fsl_asoc_card_init_codecs(), which runs in late_probe() after the bound
codec device is known. This makes sure codecs can get proper MCLK.

The old card-name fallback depended on codec_dev_name[], which required
looking up the codec device in probe(). This is no longer valid under
deferrable card binding because the codec component may not have probed
yet. Since the DT binding requires "model", remove the fallback and fail
with a clear error.

Assisted-by: VeroCoder:claude-sonnet-4-6
Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 324 ++++++++++++++++++++--------------
 1 file changed, 191 insertions(+), 133 deletions(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 10e432c916b8..3532bf6d507e 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -658,8 +658,14 @@ static int fsl_asoc_card_cs42888_codec_init(struct fsl_asoc_card_priv *priv)
 {
 	unsigned long mclk_freq = priv->codec_priv[0].mclk_freq;
 
-	priv->cpu_priv.sysclk_freq[TX] = mclk_freq;
-	priv->cpu_priv.sysclk_freq[RX] = mclk_freq;
+	/*
+	 * Set CPU sysclk frequency from codec MCLK only if not already
+	 * set by the CPU DAI init (e.g. ESAI extal clock takes precedence).
+	 */
+	if (!priv->cpu_priv.sysclk_freq[TX])
+		priv->cpu_priv.sysclk_freq[TX] = mclk_freq;
+	if (!priv->cpu_priv.sysclk_freq[RX])
+		priv->cpu_priv.sysclk_freq[RX] = mclk_freq;
 
 	priv->constraint_channels = &cs42888_channel_constraints;
 	if (mclk_freq % 12288000 == 0)
@@ -868,17 +874,173 @@ static struct notifier_block mic_jack_nb = {
 	.notifier_call = mic_jack_event,
 };
 
-static int fsl_asoc_card_late_probe(struct snd_soc_card *card)
+/*
+ * fsl_asoc_card_init_cpu - configure CPU DAI-specific settings.
+ *
+ * Called from late_probe() when the CPU DAI component is guaranteed bound.
+ */
+static int fsl_asoc_card_init_cpu(struct snd_soc_card *card,
+				  struct snd_soc_pcm_runtime *rtd)
+{
+	struct fsl_asoc_card_priv *priv = snd_soc_card_get_drvdata(card);
+	struct device_node *np = priv->pdev->dev.of_node;
+	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
+	const char *comp_drv_name = cpu_dai->component->driver->name;
+	struct device *dev = card->dev;
+	int ret;
+
+	if (!strcmp(comp_drv_name, "fsl-ssi")) {
+		/* Only SSI needs to configure AUDMUX */
+		ret = fsl_asoc_card_audmux_init(np, priv);
+		if (ret) {
+			dev_err(dev, "failed to init audmux\n");
+			return ret;
+		}
+	} else if (!strcmp(comp_drv_name, "fsl-esai")) {
+		struct clk *esai_clk = clk_get(cpu_dai->dev, "extal");
+
+		if (!IS_ERR(esai_clk)) {
+			priv->cpu_priv.sysclk_freq[TX] = clk_get_rate(esai_clk);
+			priv->cpu_priv.sysclk_freq[RX] = clk_get_rate(esai_clk);
+			clk_put(esai_clk);
+		} else {
+			dev_warn(dev, "failed to get ESAI extal clock: %ld\n", PTR_ERR(esai_clk));
+		}
+
+		priv->cpu_priv.sysclk_id[TX] = ESAI_HCKT_EXTAL;
+		priv->cpu_priv.sysclk_id[RX] = ESAI_HCKR_EXTAL;
+	} else if (!strcmp(comp_drv_name, "fsl-sai")) {
+		priv->cpu_priv.sysclk_id[TX] = FSL_SAI_CLK_MAST1;
+		priv->cpu_priv.sysclk_id[RX] = FSL_SAI_CLK_MAST1;
+
+		if (priv->pdata->exclude_format)
+			priv->exclude_format = priv->pdata->exclude_format;
+	}
+
+	return 0;
+}
+
+/*
+ * fsl_asoc_card_init_codecs - read codec MCLK rates and set codec sysclk.
+ *
+ * Called from late_probe() after all components are bound.
+ */
+static int fsl_asoc_card_init_codecs(struct snd_soc_card *card,
+				     struct snd_soc_pcm_runtime *rtd)
 {
 	struct fsl_asoc_card_priv *priv = snd_soc_card_get_drvdata(card);
-	struct snd_soc_pcm_runtime *rtd = list_first_entry(
-			&card->rtd_list, struct snd_soc_pcm_runtime, list);
+	const struct fsl_asoc_card_pdata *pdata = priv->pdata;
 	struct snd_soc_dai *codec_dai;
 	struct codec_priv *codec_priv;
 	struct device *dev = card->dev;
 	int codec_idx;
 	int ret;
 
+	/* Read MCLK rate from each bound codec component */
+	for_each_rtd_codec_dais(rtd, codec_idx, codec_dai) {
+		struct clk *codec_clk = clk_get(codec_dai->component->dev, NULL);
+
+		codec_priv = &priv->codec_priv[codec_idx];
+		if (!IS_ERR(codec_clk)) {
+			codec_priv->mclk_freq = clk_get_rate(codec_clk);
+			clk_put(codec_clk);
+		}
+	}
+
+	if (pdata->codec_init) {
+		ret = pdata->codec_init(priv);
+		if (ret)
+			return ret;
+	}
+
+	for_each_rtd_codec_dais(rtd, codec_idx, codec_dai) {
+		codec_priv = &priv->codec_priv[codec_idx];
+
+		ret = snd_soc_dai_set_sysclk(codec_dai, codec_priv->mclk_id,
+					     codec_priv->mclk_freq, SND_SOC_CLOCK_IN);
+		if (ret && ret != -ENOTSUPP) {
+			dev_err(dev, "failed to set sysclk in %s\n", __func__);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static void fsl_asoc_card_free_jack(struct snd_soc_card *card)
+{
+	struct fsl_asoc_card_priv *priv = snd_soc_card_get_drvdata(card);
+
+	if (priv->hp_jack.gpio.desc) {
+		snd_soc_jack_notifier_unregister(&priv->hp_jack.jack, &hp_jack_nb);
+		snd_soc_jack_free_gpios(&priv->hp_jack.jack, 1, &priv->hp_jack.gpio);
+		priv->hp_jack.gpio.desc = NULL;
+	}
+
+	if (priv->mic_jack.gpio.desc) {
+		snd_soc_jack_notifier_unregister(&priv->mic_jack.jack, &mic_jack_nb);
+		snd_soc_jack_free_gpios(&priv->mic_jack.jack, 1, &priv->mic_jack.gpio);
+		priv->mic_jack.gpio.desc = NULL;
+	}
+}
+
+/*
+ * fsl_asoc_card_init_jack - register optional headphone and mic jacks.
+ *
+ * Called from late_probe() once per card bind cycle.
+ */
+static int fsl_asoc_card_init_jack(struct snd_soc_card *card)
+{
+	struct fsl_asoc_card_priv *priv = snd_soc_card_get_drvdata(card);
+	struct device_node *np = priv->pdev->dev.of_node;
+	int ret;
+
+	/*
+	 * Properties "hp-det-gpios" and "mic-det-gpios" are optional.
+	 * simple_util_init_jack() checks for the GPIO property and
+	 * does nothing if it is absent.
+	 */
+	if (of_property_present(np, "hp-det-gpios") ||
+	    of_property_present(np, "hp-det-gpio") /* deprecated */) {
+		ret = simple_util_init_jack(card, &priv->hp_jack,
+					    1, NULL, "Headphone Jack");
+		if (ret)
+			return ret;
+
+		snd_soc_jack_notifier_register(&priv->hp_jack.jack, &hp_jack_nb);
+	}
+
+	if (of_property_present(np, "mic-det-gpios") ||
+	    of_property_present(np, "mic-det-gpio") /* deprecated */) {
+		ret = simple_util_init_jack(card, &priv->mic_jack,
+					    0, NULL, "Mic Jack");
+		if (ret)
+			return ret;
+
+		snd_soc_jack_notifier_register(&priv->mic_jack.jack, &mic_jack_nb);
+	}
+
+	return 0;
+}
+
+static int fsl_asoc_card_late_probe(struct snd_soc_card *card)
+{
+	struct fsl_asoc_card_priv *priv = snd_soc_card_get_drvdata(card);
+	struct snd_soc_pcm_runtime *rtd;
+	int ret;
+
+	/* Use the first rtd which carries the CPU+codec DAIs */
+	rtd = list_first_entry(&card->rtd_list,
+			       struct snd_soc_pcm_runtime, list);
+
+	ret = fsl_asoc_card_init_jack(card);
+	if (ret)
+		goto jack_fail;
+
+	ret = fsl_asoc_card_init_cpu(card, rtd);
+	if (ret)
+		goto jack_fail;
+
 	if (fsl_asoc_card_is_ac97(priv)) {
 #if IS_ENABLED(CONFIG_SND_AC97_CODEC)
 		struct snd_soc_component *component = snd_soc_rtd_to_codec(rtd, 0)->component;
@@ -896,16 +1058,20 @@ static int fsl_asoc_card_late_probe(struct snd_soc_card *card)
 		return 0;
 	}
 
-	for_each_rtd_codec_dais(rtd, codec_idx, codec_dai) {
-		codec_priv = &priv->codec_priv[codec_idx];
+	ret = fsl_asoc_card_init_codecs(card, rtd);
+	if (ret)
+		goto jack_fail;
 
-		ret = snd_soc_dai_set_sysclk(codec_dai, codec_priv->mclk_id,
-					codec_priv->mclk_freq, SND_SOC_CLOCK_IN);
-		if (ret && ret != -ENOTSUPP) {
-			dev_err(dev, "failed to set sysclk in %s\n", __func__);
-			return ret;
-		}
-	}
+	return 0;
+
+jack_fail:
+	fsl_asoc_card_free_jack(card);
+	return ret;
+}
+
+static int fsl_asoc_card_card_remove(struct snd_soc_card *card)
+{
+	fsl_asoc_card_free_jack(card);
 
 	return 0;
 }
@@ -919,13 +1085,10 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	struct platform_device *asrc_pdev = NULL;
 	struct device_node *bitclkprovider = NULL;
 	struct device_node *frameprovider = NULL;
-	struct platform_device *cpu_pdev;
 	struct fsl_asoc_card_priv *priv;
 	const struct fsl_asoc_card_pdata *pdata;
-	struct device *codec_dev[2] = { NULL, NULL };
 	struct snd_soc_dai_link_component *dlc;
-	const char *codec_dai_name[2];
-	const char *codec_dev_name[2];
+	const char *codec_dai_name[2] = { NULL, NULL };
 	u32 asrc_fmt = 0;
 	int codec_idx;
 	u32 width;
@@ -938,8 +1101,10 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	priv->pdev = pdev;
 
 	pdata = of_device_get_match_data(&pdev->dev);
-	if (!pdata)
+	if (!pdata) {
+		dev_err(&pdev->dev, "unknown Device Tree compatible\n");
 		return -EINVAL;
+	}
 	priv->pdata = pdata;
 
 	cpu_np = of_parse_phandle(np, "audio-cpu", 0);
@@ -954,58 +1119,13 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-	cpu_pdev = of_find_device_by_node(cpu_np);
-	if (!cpu_pdev) {
-		dev_err(&pdev->dev, "failed to find CPU DAI device\n");
-		ret = -EINVAL;
-		goto fail;
-	}
-
 	codec_np[0] = of_parse_phandle(np, "audio-codec", 0);
 	codec_np[1] = of_parse_phandle(np, "audio-codec", 1);
 
-	for (codec_idx = 0; codec_idx < 2; codec_idx++) {
-		if (codec_np[codec_idx]) {
-			struct platform_device *codec_pdev;
-			struct i2c_client *codec_i2c;
-
-			codec_i2c = of_find_i2c_device_by_node(codec_np[codec_idx]);
-			if (codec_i2c) {
-				codec_dev[codec_idx] = &codec_i2c->dev;
-				codec_dev_name[codec_idx] = codec_i2c->name;
-			}
-			if (!codec_dev[codec_idx]) {
-				codec_pdev = of_find_device_by_node(codec_np[codec_idx]);
-				if (codec_pdev) {
-					codec_dev[codec_idx] = &codec_pdev->dev;
-					codec_dev_name[codec_idx] = codec_pdev->name;
-				}
-			}
-		}
-	}
-
 	asrc_np = of_parse_phandle(np, "audio-asrc", 0);
 	if (asrc_np)
 		asrc_pdev = of_find_device_by_node(asrc_np);
 
-	/* Get the MCLK rate only, and leave it controlled by CODEC drivers */
-	for (codec_idx = 0; codec_idx < 2; codec_idx++) {
-		if (codec_dev[codec_idx]) {
-			struct clk *codec_clk = clk_get(codec_dev[codec_idx], NULL);
-
-			if (!IS_ERR(codec_clk)) {
-				priv->codec_priv[codec_idx].mclk_freq = clk_get_rate(codec_clk);
-				clk_put(codec_clk);
-			}
-		}
-	}
-
-	if (pdata->codec_init) {
-		ret = pdata->codec_init(priv);
-		if (ret)
-			goto asrc_fail;
-	}
-
 	/* Default sample rate and format, will be updated in hw_params() */
 	priv->sample_rate = 44100;
 	priv->sample_format = SNDRV_PCM_FORMAT_S16_LE;
@@ -1086,9 +1206,6 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	priv->card.dapm_routes = pdata->dapm_routes;
 	priv->card.num_dapm_routes = pdata->num_dapm_routes;
 
-	if (pdata->exclude_format && of_node_name_eq(cpu_np, "sai"))
-		priv->exclude_format = pdata->exclude_format;
-
 	if (pdata->probe_init) {
 		ret = pdata->probe_init(codec_np, cpu_np,
 					codec_dai_name, priv);
@@ -1139,51 +1256,21 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	of_node_put(bitclkprovider);
 	of_node_put(frameprovider);
 
-	if (!fsl_asoc_card_is_ac97(priv) && !codec_dev[0]
-	    && codec_dai_name[0] != snd_soc_dummy_dlc.dai_name) {
-		dev_dbg(&pdev->dev, "failed to find codec device\n");
-		ret = -EPROBE_DEFER;
-		goto asrc_fail;
-	}
-
-	/* Common settings for corresponding Freescale CPU DAI driver */
-	if (of_node_name_eq(cpu_np, "ssi")) {
-		/* Only SSI needs to configure AUDMUX */
-		ret = fsl_asoc_card_audmux_init(np, priv);
-		if (ret) {
-			dev_err(&pdev->dev, "failed to init audmux\n");
-			goto asrc_fail;
-		}
-	} else if (of_node_name_eq(cpu_np, "esai")) {
-		struct clk *esai_clk = clk_get(&cpu_pdev->dev, "extal");
-
-		if (!IS_ERR(esai_clk)) {
-			priv->cpu_priv.sysclk_freq[TX] = clk_get_rate(esai_clk);
-			priv->cpu_priv.sysclk_freq[RX] = clk_get_rate(esai_clk);
-			clk_put(esai_clk);
-		} else if (PTR_ERR(esai_clk) == -EPROBE_DEFER) {
-			ret = -EPROBE_DEFER;
-			goto asrc_fail;
-		}
-
-		priv->cpu_priv.sysclk_id[1] = ESAI_HCKT_EXTAL;
-		priv->cpu_priv.sysclk_id[0] = ESAI_HCKR_EXTAL;
-	} else if (of_node_name_eq(cpu_np, "sai")) {
-		priv->cpu_priv.sysclk_id[1] = FSL_SAI_CLK_MAST1;
-		priv->cpu_priv.sysclk_id[0] = FSL_SAI_CLK_MAST1;
-	}
-
 	/* Initialize sound card */
 	priv->card.dev = &pdev->dev;
 	priv->card.owner = THIS_MODULE;
 	ret = snd_soc_of_parse_card_name(&priv->card, "model");
 	if (ret) {
-		snprintf(priv->name, sizeof(priv->name), "%s-audio",
-			 fsl_asoc_card_is_ac97(priv) ? "ac97" : codec_dev_name[0]);
-		priv->card.name = priv->name;
+		/*
+		 * "model" is required by the DT binding. Enforce it here so
+		 * the driver fails with a clear message.
+		 */
+		dev_err(&pdev->dev, "Error parsing card name: %d\n", ret);
+		goto asrc_fail;
 	}
 	priv->card.dai_link = priv->dai_link;
 	priv->card.late_probe = fsl_asoc_card_late_probe;
+	priv->card.remove = fsl_asoc_card_card_remove;
 	priv->card.dapm_widgets = fsl_asoc_card_dapm_widgets;
 	priv->card.num_dapm_widgets = ARRAY_SIZE(fsl_asoc_card_dapm_widgets);
 
@@ -1290,39 +1377,10 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 		goto asrc_fail;
 	}
 
-	/*
-	 * Properties "hp-det-gpios" and "mic-det-gpios" are optional, and
-	 * simple_util_init_jack() uses these properties for creating
-	 * Headphone Jack and Microphone Jack.
-	 *
-	 * The notifier is initialized in snd_soc_card_jack_new(), then
-	 * snd_soc_jack_notifier_register can be called.
-	 */
-	if (of_property_present(np, "hp-det-gpios") ||
-	    of_property_present(np, "hp-det-gpio") /* deprecated */) {
-		ret = simple_util_init_jack(&priv->card, &priv->hp_jack,
-					    1, NULL, "Headphone Jack");
-		if (ret)
-			goto asrc_fail;
-
-		snd_soc_jack_notifier_register(&priv->hp_jack.jack, &hp_jack_nb);
-	}
-
-	if (of_property_present(np, "mic-det-gpios") ||
-	    of_property_present(np, "mic-det-gpio") /* deprecated */) {
-		ret = simple_util_init_jack(&priv->card, &priv->mic_jack,
-					    0, NULL, "Mic Jack");
-		if (ret)
-			goto asrc_fail;
-
-		snd_soc_jack_notifier_register(&priv->mic_jack.jack, &mic_jack_nb);
-	}
-
 asrc_fail:
 	of_node_put(asrc_np);
 	of_node_put(codec_np[0]);
 	of_node_put(codec_np[1]);
-	put_device(&cpu_pdev->dev);
 fail:
 	of_node_put(cpu_np);
 
-- 
2.50.1


