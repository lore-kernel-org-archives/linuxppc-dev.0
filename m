Return-Path: <linuxppc-dev+bounces-25803-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC486C5CFEB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2026 06:55:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLGMJ1mZzz2ykf;
	Thu, 13 Aug 2026 16:55:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786604108;
	cv=pass; b=XVfTJn9g1OiNL6AQoAKB4xJzxk84VWkaP8NOec5biPpJh1avVZahYDKXrPpPszC12/rQxGkXOakPepTC5BUlLb7KrCuY6nqI0Zq00TBxRsWv2ZBJIBzEaP4+wTpn28t8BSv4HDLD852hfKfKQB59rD4py+4qfQrYfpkV2QAY6GAwFdNeClmCgSMFqWi/tXXGv5pmEfsAyp5JqKyJGZLNWALf2/Y7qb5ubGAlNrkg7d/CzzzVo8n4AB7O9wq2Kmgoyi6mUvqYOGdANdMI2yetL7MGZFMMojrZ98w8kpq7caYf0o1ag7HRFGNmmp9p89JITZoYakjPoAKJaiMCQll5jw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786604108; c=relaxed/relaxed;
	bh=MqnFcCPU5nyeHnq8r7sNlx2vP289bsZxtgsHMThdXUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YRXle7tpFcXHZCZVgo5wYJWlhFaF31QNiDTzY4BjtnJ+F8ciLwbCbDf5Y2zhPjvpw64grMPE7YBPv9ztJozXBTnKY5y0uR4Iup+77Ki1L4ohWOVqKrDN1rl98enTC0ZmvWnY73bUQHNWDiSXNedsxRfOBm6Q0M0IZambpi9vaczl/8ggfTY8L9QSD0fgSJJ3Izjv0yH/uA+nPQL8p29fNIgrWm1CxNWFhDIJTe8nLo3enBrtmDchLh9IcwpJP6nKYrNbmUyNsnUoM3kVmNFezXPrdITfAUfPUrKPJ3qQC7JED3/Ag8fNsfJ9l8a0fWDC3Ndpfz/BHb9wUkdLfbfF6A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=iRVcZbWE; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=iRVcZbWE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLGMH0jxDz2ykT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 16:55:07 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ix4W8DMYW1sm/DK+rurdVAw0lfImOJv4yemHA5PE+bYtqie5tDAonC1rMbxu8IJoitD2vcFVQvkfPDJHYSXBBflM8OlhMTvXfoVL0a+aQrDFlD41xVPhshdwpwi7yUSpSBJtgOPVg1dko7N0Ni1r0FixN6GWMdTDAnjT+GnuaSFZJAEOo7S/H9TIWlsO+2Ex8KfXe95iYfZIbCVNNUI3bLa2ezZIG4IRFNGbmknqYkKnwXcBsME1NkepavDlxwayrbgvjUq5xgWo3WL85B41cjGJHj/ZoWD+w4aXnnNnJeXX8AD3Pfy/so/jMaiNGeAOFXyb1rfSrDBUlMh+Vmud3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MqnFcCPU5nyeHnq8r7sNlx2vP289bsZxtgsHMThdXUI=;
 b=gXfRCtz8+9UmKjMxHSSRgiW+18WtOErSgM5sJua8DZn5266HKigG8Bwuyw0UIHEetISaisUtAzh6XaGB/UQ9SL258cYzEXHwx1wweW10JqJ5Ese/Ho8z7wzSZZsUkDeOeoXSsJkMg/Lgm+TgEEsCMb8+NcO01lHMUP1EfiSN/5JvNKY2zvDGdW+PAqiL+Wr4R1I0BP7LqxeXl/30IZiOViQLoeNIdIewFBYTfGe25fBUt91GWyeTVJf/4FmDbcyd0Lq+ZZFKCVvMZKo+w5dyp/TDwxHN1Ye5rUT1QN8/DjRjpxvOz3Dv+7znVUQ0K9ABJifIGJSTaiACDGSxhP310w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqnFcCPU5nyeHnq8r7sNlx2vP289bsZxtgsHMThdXUI=;
 b=iRVcZbWE9L/xveUqDvsntgRn2Ro7czF0odY3O84E4z2vmUstP6ooWEDYYZs+bdHeiWl8To3zxwL+fcQlCm7L6/RJQxeHE7Bv7nqLCZ/8X9Js6MjDpKGSBlr+4gix+K7vo7lVoUeJ+oGX3nLaSX3ZtUE1sdo5rVkZDpKHJigRGVlAvPoGBnzbUBZA0fOMyCdtMBUs1kplPrhvp0j34Q3me/68ecenqmGtzdKX3Grqaxe3dnn7HCQlktbIET9pWhYcZaY68ajo9NpT7Or3yxOnoGvHu50OekmmfPJ+UQb82HJAEbM8xRUTOWRfVh5QuO0kiP6PjVKkYSOSilGmGMgwMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by VI2PR04MB10644.eurprd04.prod.outlook.com (2603:10a6:800:276::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 06:54:42 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0315.012; Thu, 13 Aug 2026
 06:54:42 +0000
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
Subject: [PATCH v4 5/5] ASoC: fsl_easrc: expose individual DAIs per conversion path
Date: Thu, 13 Aug 2026 15:00:20 +0800
Message-Id: <20260813070020.719810-6-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260813070020.719810-1-shengjiu.wang@oss.nxp.com>
References: <20260813070020.719810-1-shengjiu.wang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To PAXPR04MB9351.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9351:EE_|VI2PR04MB10644:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fa06a19-5f03-4ea3-d00a-08def907c0a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|19092799006|1800799024|921020|6133799003|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	EumMkXFMHwz3ALYJCciA0AnQaj9DCGZQofBW55IZsrT4VZEMBZn14ws/X3CVU0NKQGLer5LOsAl/i/IjMQ7dZonnDyTVbZ22Ua1uWPLgPacpHp4EjWGI5uisR/mH1XThsw3lZTuo/hxwkWEmFAGuqWz5uX7KSZDzgzvOzxfxJ2qlUc6OEULtr/1u0TG3F9Gc3UQZsIsCDlTrqn3qsLFym71H6SsdKHdGqgGHU5cKvvsqbWkVDHc6jF/CmHoUXzyfJ/MlbPiBA+tgbtXnSZjN19flpQjbFsZKiiABbFSOMZkYJLrpDVOi7AlLe2cbEob/9bW/CAILUy3Q6+z2MGarHkFVJms95PSau92yXYhD5i+zPwg93dk5bL4rmM+mVhE2PzvJqt8PCBsOGgGTq0kneMfCWY05bRYx2djKDScGeZ/P9c2RCaUVrYcsklKw+Gy/GdTBLkPNg8rMGERU7MkhPF0a/ieMH7zDxrH62M1E+irMpITsnwhuvQu1Rk1oh7pmVFdo0lBdwZDycIoYSDiW2T66lTjbiNFHrlN4gYZBq2+QTw39EE3SPUk80jMQJCrp64JL53AMa/pTp5JiCfCJ7Qj23TDuv6RAAI11hkcu4v1kB/yC/e8xbtrP5sifxJiTPGvZFHmLzQvNtvO0Az3f6RUhCdV22pAnnKrDPWoWFF0s+Dk6bwKnHgOsqAHGs5X5WqXT3R/W2so10PpvujFYow==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(19092799006)(1800799024)(921020)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FQY1JAXHaQf+w+lnbvIRjCtqYOHPqbyC7UKVTLn08NU5rEGoQNLTHXmE0Zqn?=
 =?us-ascii?Q?iKlC2yeexPAmP6z39rdDUNLS/nBpMZz+vq2xvcjhd+lsQMVmrdkJ4HfgBpGz?=
 =?us-ascii?Q?PCcNbUZMdusveyKztbtUvktHB5WOfrqy5ua4Kcp+z4knZTl+d7BvHkdPtp3T?=
 =?us-ascii?Q?18RXcEIa9Xe1S1fODS6YyiTY9U2LnVEm9mCLnAY3iYm1ReQzTP1HxbXHHF7V?=
 =?us-ascii?Q?ozOGtZRZk4LWWqdkJMPmgrR+8RvctO8HfjQBTU8vIaqO+X7cA9iYn5ok1YIU?=
 =?us-ascii?Q?/JGoFfIbYHXcnf17rLRINEBCJFMBYg7gNYidHqkZX11IdOAR6ODoY0un0z5B?=
 =?us-ascii?Q?SxMnyjXR4/gtQ3ljm8EY7TMjnzjj8MIEF0LF6bC9WJBEZU6Lhr0Oakp3nRU+?=
 =?us-ascii?Q?55pJ4tV9X8ha7z2h+iuGjkenJfobgEyvdA/Giey3aY9TMkwoqL31+K3vcPTm?=
 =?us-ascii?Q?+ZTHzfT61FfZixcQC78Z/1NMq2g0ltl1nik9VCV5083HnkSKvdrDJh6aqwTi?=
 =?us-ascii?Q?/hhMOliAeLkvwuSVJx38U4odtICAUH5U4VsZLPaeo0CXdLFA1gqPOYM6uoDi?=
 =?us-ascii?Q?S4xML2jalWcxFy5F3pqXfd2spbrQtTMojYpp6CxjMlSmpCDTjzBDdVoBloti?=
 =?us-ascii?Q?trRgCEMJPNh+rrrvtXFj/nxbkQsOOZzfNbRMwxKfX4bfTnEB3p9EVhk5B9/K?=
 =?us-ascii?Q?h42JsxfBQhozfjngEjZeBwb/INZFkeV4DM4ExehWgd/qk1vzkXyrlixxDTmG?=
 =?us-ascii?Q?JYmNqdMfvyogFfmUuCoUj1DK7W0PVVlmg7rdLnuWoRVs7LBiza0ULx6/r4L0?=
 =?us-ascii?Q?7Y94bAsERTIlU1XDTpm3CI1WvvIx1lXCGV0iJybcRYv0m0swmLdCoZDkaFoC?=
 =?us-ascii?Q?jZzelOobfIpWalBg+KViEjKYmpgF5Zzu8/3RUW0t3XKAv25gyXx3NNDnLCAI?=
 =?us-ascii?Q?wN+Z7H7gL6pWm/yj+L3i5SrC+Y2+m3JzZ1GGth9K8zVE/ae+r1i/kerfIgpK?=
 =?us-ascii?Q?YZ62wemuEEkaLchEAChxwbYXvuEhUTAWPfuYA+0uyrUMGz4FTde81FHQn94O?=
 =?us-ascii?Q?9TKMls6NJ5hobrOw8Z6vZ7Pf8RKrItVutaFt/pjgFMmImPqL/sATnoe3QuMH?=
 =?us-ascii?Q?Kjjng6EhNjOwjePm9+ZSr/6fyx8Z58fA8FsbNHXrgYhZU++1anKRdqccUb3K?=
 =?us-ascii?Q?LNvLOmzoRxxDJL8rELpyS3ew6P7aAaXlDgd+oC0sQ7YvbRUlgRw+lKszDseI?=
 =?us-ascii?Q?ileJP9juZs51gBB+SbW5FCMetGvEaJh5bgTXLZfRSWWwc0DMw3aJxrSSJjWW?=
 =?us-ascii?Q?d+B2pagezEXUmyRMsF7hlizAw1MODOCG3VveBiO6gKFV80WifC8sOvjPN/63?=
 =?us-ascii?Q?Gss2FbqI4pjFnuN2VKMykZoUf48tEds4MEVOd2owcVuhaxie4nAU1GmWPPE+?=
 =?us-ascii?Q?6LT06eXUEO/73X5MjdeVlmp3DPJMySvzQniKFy/zQnVLi1+e9OPYL2KXoanp?=
 =?us-ascii?Q?xkh6mBGTwZbIaFcBiL1fZSdpSyLEVF1Z2GOkdMRS5UlFb/EXQ59iZ+AnD0jI?=
 =?us-ascii?Q?SpCE7EQmj5zOIG4tkdesS7O2J/sUwz0vzFCvm6kgY3gM7i3vte73Ko3pzLgH?=
 =?us-ascii?Q?3htbjEsGVYiwleaZAADqy8xvwvpxaTI/U0BP/IsrSA4+hY5rhS4dbZRGDidf?=
 =?us-ascii?Q?O/cyywScO7PtYBOT+xPT89WGosU5CwXTYUJKXgb/FvkzE6H+TBHr0f0tWkAL?=
 =?us-ascii?Q?W0ClQErGhMFi1ZOv/JSGHUABUjTtXytv8ZlVQdHmmBB4I5hTdd1U?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa06a19-5f03-4ea3-d00a-08def907c0a3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 06:54:42.6988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HmsJEV8X/ib17efdqp47Jyy/Ok1bAaxqhmDnEM1dSNM2JMSNebV9dDrLGqdhLXXymzfj9QoDfbvG47iJSByxdNiMTxa8rzzkE0laVzt9YXs/suFlFNFSUClMGEvk0i0w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10644

From: Shengjiu Wang <shengjiu.wang@nxp.com>

The i.MX EASRC hardware supports four independent conversion contexts
(A, B, C, D). The driver previously registered a single DAI with generic
stream names "ASRC-Playback" and "ASRC-Capture", which prevents
multiple independent conversion paths from being used simultaneously.

Replace the single fsl_easrc_dai instance with an array of four DAI
drivers to allow up to four independent conversion paths to be active
at the same time:

  easrc-0 -- ASRC-Playback / ASRC-Capture (backward compatible)
  easrc-1 -- ASRC1-Playback / ASRC1-Capture
  easrc-2 -- ASRC2-Playback / ASRC2-Capture
  easrc-3 -- ASRC3-Playback / ASRC3-Capture

easrc-0 retains the original generic stream names to preserve backward
compatibility with existing machine drivers and board configurations.
Each DAI retains the same channel, rate and format capabilities as the
original, including IEC958 subframe support on the capture side. Update
the devm_snd_soc_register_component() call to register all four DAIs.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_easrc.c | 112 +++++++++++++++++++++++++++++++-------
 1 file changed, 92 insertions(+), 20 deletions(-)

diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index d23ee482924b..2ac062083782 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -1589,27 +1589,99 @@ static const struct snd_soc_dai_ops fsl_easrc_dai_ops = {
 	.hw_free	= fsl_easrc_hw_free,
 };
 
-static struct snd_soc_dai_driver fsl_easrc_dai = {
-	.playback = {
-		.stream_name = "ASRC-Playback",
-		.channels_min = 1,
-		.channels_max = 32,
-		.rate_min = 8000,
-		.rate_max = 768000,
-		.rates = SNDRV_PCM_RATE_KNOT,
-		.formats = FSL_EASRC_FORMATS,
+static struct snd_soc_dai_driver fsl_easrc_dai[] = {
+	{
+		.name = "easrc-0",
+		.playback = {
+			.stream_name = "ASRC-Playback",
+			.channels_min = 1,
+			.channels_max = 32,
+			.rate_min = 8000,
+			.rate_max = 768000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_EASRC_FORMATS,
+		},
+		.capture = {
+			.stream_name = "ASRC-Capture",
+			.channels_min = 1,
+			.channels_max = 32,
+			.rate_min = 8000,
+			.rate_max = 768000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_EASRC_FORMATS |
+				   SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE,
+		},
+		.ops = &fsl_easrc_dai_ops,
 	},
-	.capture = {
-		.stream_name = "ASRC-Capture",
-		.channels_min = 1,
-		.channels_max = 32,
-		.rate_min = 8000,
-		.rate_max = 768000,
-		.rates = SNDRV_PCM_RATE_KNOT,
-		.formats = FSL_EASRC_FORMATS |
-			   SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE,
+	{
+		.name = "easrc-1",
+		.playback = {
+			.stream_name = "ASRC1-Playback",
+			.channels_min = 1,
+			.channels_max = 32,
+			.rate_min = 8000,
+			.rate_max = 768000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_EASRC_FORMATS,
+		},
+		.capture = {
+			.stream_name = "ASRC1-Capture",
+			.channels_min = 1,
+			.channels_max = 32,
+			.rate_min = 8000,
+			.rate_max = 768000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_EASRC_FORMATS |
+				   SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE,
+		},
+		.ops = &fsl_easrc_dai_ops,
+	},
+	{
+		.name = "easrc-2",
+		.playback = {
+			.stream_name = "ASRC2-Playback",
+			.channels_min = 1,
+			.channels_max = 32,
+			.rate_min = 8000,
+			.rate_max = 768000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_EASRC_FORMATS,
+		},
+		.capture = {
+			.stream_name = "ASRC2-Capture",
+			.channels_min = 1,
+			.channels_max = 32,
+			.rate_min = 8000,
+			.rate_max = 768000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_EASRC_FORMATS |
+				   SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE,
+		},
+		.ops = &fsl_easrc_dai_ops,
+	},
+	{
+		.name = "easrc-3",
+		.playback = {
+			.stream_name = "ASRC3-Playback",
+			.channels_min = 1,
+			.channels_max = 32,
+			.rate_min = 8000,
+			.rate_max = 768000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_EASRC_FORMATS,
+		},
+		.capture = {
+			.stream_name = "ASRC3-Capture",
+			.channels_min = 1,
+			.channels_max = 32,
+			.rate_min = 8000,
+			.rate_max = 768000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_EASRC_FORMATS |
+				   SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE,
+		},
+		.ops = &fsl_easrc_dai_ops,
 	},
-	.ops = &fsl_easrc_dai_ops,
 };
 
 static const struct snd_soc_component_driver fsl_easrc_component = {
@@ -2234,7 +2306,7 @@ static int fsl_easrc_probe(struct platform_device *pdev)
 	regcache_cache_only(easrc->regmap, true);
 
 	ret = devm_snd_soc_register_component(dev, &fsl_easrc_component,
-					      &fsl_easrc_dai, 1);
+					      fsl_easrc_dai, ARRAY_SIZE(fsl_easrc_dai));
 	if (ret) {
 		dev_err(dev, "failed to register ASoC DAI\n");
 		goto err_pm_disable;
-- 
2.34.1


