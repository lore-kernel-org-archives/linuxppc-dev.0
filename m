Return-Path: <linuxppc-dev+bounces-19016-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6051910D14A4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 11:25:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkpnp70W6z2yvK;
	Mon, 30 Mar 2026 22:25:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774869918;
	cv=pass; b=D2Ueb/VC25YL6PQxtvLe9XJKh3CHa73eHqJ8bklYGY+r/moy53iV7LDY9Fz0o30b9p6L38HPTnJP6x2Qc5SNFbOtMFMNjdT0gQToWiQGUz6yA9QUSPUl+PplJwrKgQmXXdip9QwWXeM0av8DAW+QG52poHwK8aok/KHeIBp9UxhkSff6TLCD8gX6XdXnWPI0R4PbpXR/d0g5oUj0DlvNdFAJ+ZKu2aIv1KSoME22q98RdrunLPS3K06s9drS8sWm6IPA3zWDIeJBoktgELh77s1CWAeubok+OEgBrzSb6U41KRl4spffiaINj/3qIJz8WekqIunlsCDFEVnCZ4swug==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774869918; c=relaxed/relaxed;
	bh=z1Ua7Y/Yo6TxbvyaRDoolgjhe+iyuzuyd94d3RcAmdw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OKljocz4aQS+d2+BJgiBf6t+k6PTLga+yVDmC9FqqVUNtSPl3B6v2j2dyo1PgWXF+UdIK9PUR8VAV4ingdOF1uJGzYrUSY9bymiXMbF1BcGQG1lDqPb8a4+PBBO9f4tpAThKNZS3vjhiDoyI21rIdcPOX75liVqL/bgJRX8kXhp4qTdCOgA6rvtFMQy9Cvj6WuHgN7a/xyN1jlcRWrEDGhy2XCthqmKMG5heoLl2e3pSA0Fe/OpI8Ht+gZLI0S00gnbPlDLVR/u8Nvu0lYvy80N9A53xyHmsDa2uerxXGg1pqbwv881+K6j4JH5El85y6z43mzHYs+8AhrtESZtgkA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=FilLD6Mq; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=FilLD6Mq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkpnp1yLxz2yv7
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 22:25:18 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8KxgLRZSl3OH5OntrGS5XOTq+AUFW4OSrsg96OglKT1BVOfPTuCvA4YRjG6bC3dtxamhyPpOwd3vSZMHfWGxnJWnng6okKDikEnM+/BfpGEXSjT2c93tcVt6VudHTgxTeJQ4m+dK9euuzVCAfYPrwu6O37t5WiAMrwA+Ma4V1d+BvbQ7kGXydWQwWGDe7fgp5gfi8Af4A9FVpkKE8nhseZA5sWHuK96txLBSiHZUKNX72pFNF//newid1QJTSOChWOwafGqWjiVGpYz+BGv2jyyyLgghGbBhePohZ6D1jDIFdGcSsBx7iFAyRtfh/qS8HR2coOUe42HWCmC2sZS7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1Ua7Y/Yo6TxbvyaRDoolgjhe+iyuzuyd94d3RcAmdw=;
 b=ECkNKW/5T+rE9JoOBMdQrreaXnNtKziXktIfuqsTT6s4B0ZHeyAxGBarpqF8MJEDM6/rQnX7lLeJzMwN9iRy+h60eJSbgnpc75NTXg+RbaLFnrv2dwiTGWN+9CRlG6hTpDzN5kzWUeNjXJWMePtYXoiSKxQha+f/S6IH768GOa7TvbiTruQ3gxH/hRTbm8nehDyc3MaBMXkJzsr8eimQHuObmDrG1sH5bam3DN6WlRVDL2A5ipJyKwcRp4jQkBgqPDMK4UgsoGSTA6CjqsVuCv927eFOAk7NAcPDMicrclPrRTO2VNYOp5UCl3BZpFXnxeBm/jIuX82Wou22Gf1rjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1Ua7Y/Yo6TxbvyaRDoolgjhe+iyuzuyd94d3RcAmdw=;
 b=FilLD6Mq/Ver6Qt2N5L0qbZE5oYqjPEC4UY/2sNKOJUkjw0fYz6N+eDA51LSrXkfbCkD0q7tIfdlzu05BXdb3WMyKzDY3FvQiJqr8xdb65JWFNy1YsZkBuJd/cl8+gdjMbBow3ZG5wk0OESfiLalktJjRJmM8xxQ8lr1oDT0MGteuX60llZDXXOMp2ZlQ0DKSyibNpJMAPC1KafJ0CIPBDJJiJrwZhIZKtZEfcVhmgmZKfRk/9WfFMFn3T0cFl7wP2EteaVhr7a8lFVhvcF0nf+YJ+GJS5HbQWeHy9Qnu4fvLmwX3yihs9SiJknopGec8VRHnvlC7+I1O8Kium6tFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by VI0PR04MB11481.eurprd04.prod.outlook.com (2603:10a6:800:2c8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 11:25:00 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b%4]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 11:25:00 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] ASoC: fsl_xcvr: Fix event generation in fsl_xcvr_mode_put()
Date: Mon, 30 Mar 2026 19:25:52 +0800
Message-Id: <20260330112555.3637002-9-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260330112555.3637002-1-shengjiu.wang@nxp.com>
References: <20260330112555.3637002-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::10) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|VI0PR04MB11481:EE_
X-MS-Office365-Filtering-Correlation-Id: ed8d20f3-0d5d-4160-8879-08de8e4efaf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|19092799006|22082099003|56012099003|18002099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	1KI+fSdsGOkw4YbhwSTVg2+gtyt0RliY8CRFMJNnkWjwO3V9ylGpTUyVzhCZtAxSB8/qxrLepe0Ny5dCRoWcM7OaxousqhfAJY51bY9Gqon3nASlFgojuyh1xCM8DcgUmORTubyEmBJiwDjBTgai75a93QwvYlSEyuBmedYfhZe5v2UDSNafp0zBGeq++3W2OMvYjpbTKBD8WnuLPSCOJD+9xQ1ImOkcKZWF4Ku2J7XFn83tTJUR1F9M7zddiPMgWYd/+T1XHNTu9wwmw9ueBbRrD1kz+TuEfOpr3lWsDpc2p6Is61GYZmrGA7E9/ow8BL+W1q/G0uvylfU4NoNQ46oAIRkt3rWXtbyBREnlpHHytTujh9J/tLlX4M/5Au4RxKmJODJetk1P7U9JlRDdCzBxOu9gTOhc1FVnf78+jiRhzXh9CErzdYF9Wbw/uC4ZH8Yp0xflagnyo//+1kCmzYUsQ6OqsUSZbtpQbi2gGtuFuHCJ8nifFv+B5G3fyE8gopTXQBnlhxnwnj8IAX/qMipv7ojtl5Fz80j8uAez213nYVrRXzFiAg/bjALLN7lVR9mUokWvtv1YG0EGE2GIrvZOgqvVVM0u6odcvB0mLBwxjgEdLVTvBIxguskrjQWJP3JTh6LIjon1DuhS2RDfG1LMXsjcsLFLkGm3+a6MEbiqgq3C6+82xeeX4O/mo3RH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(19092799006)(22082099003)(56012099003)(18002099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IN1okvTBsp9kuWvxVkJIwm6SMuEvSSKXH7nc/2xGQKmA4S7fR+8nN154qLBI?=
 =?us-ascii?Q?P8Y1xw8o0eSXzeCQx6aAXlM+WxcBNMJ0jirqsXz9uX2266QZ55n1/U6DyPvP?=
 =?us-ascii?Q?1qSZT7pn5ldECoMcN4S1QkeuMojLI5wT6hvI9C3sEE7VhX+cruhigJpHsjH7?=
 =?us-ascii?Q?YmAWmcatSojqTOZ+8v4jhc/QxJDESgYh+qGWBe3hCKoPVMVirUBJNDXF1uU4?=
 =?us-ascii?Q?7Q7az3LdEi17pFu5fvbuwVHsImQGwd8mzugXdRyJLJH4TJ0Qrd0lpI68nEb8?=
 =?us-ascii?Q?DKBuSAMJCgY9eWnlSSIaD3I6T6GvXbL93dLLbqml3Vz5O9mxz0fgXbYrzsi2?=
 =?us-ascii?Q?2206VSB6hXa4tDAahQLCrsswyb50SOfR6mjDnxdHjj5RjR1oUanxky6gy/dO?=
 =?us-ascii?Q?9kUnkEgQmI2KP1IErQPMPz8PAHSui4gjY4x91gb4wtMOf9a0033sE+yUikPw?=
 =?us-ascii?Q?Rt0JzPvtCEE6VuL1nA9Xm1vsFjR1dwksr5PhQX5f4GrZ1Dq5JJTUQdErq7bx?=
 =?us-ascii?Q?8aXFxxzYeuxShkF9E+QvyzncpkOPMQ2rU2xFdG/B4htsbKdoFKwHBtMZXnTL?=
 =?us-ascii?Q?p2sS8l3QwW7N86WmO0Ab48ETs019s6VUdBGAcfVlNnfmNrZYtoO/RSeKbRIY?=
 =?us-ascii?Q?u0XeESfLYENO4ZrJ2PA/84N3WWAD/VVcuxhGjTDH2nInExvFNKR0Y7yjrzdb?=
 =?us-ascii?Q?2pajBabeS+WO07uN94xzgcYBPTjoLf5o1kp1HBMAIsFSx1ZiKotePSeK4VWR?=
 =?us-ascii?Q?gYwZIaCtmQrS0yH3mci1QkDxY6Zg6i0Y52cRwVVUioP5Lw20O7vyJ3ayjxYQ?=
 =?us-ascii?Q?vjEDYkLmQ2LWfVmRnY0aAAW6dQZ15bajuo3qlQVYkpBZvEWNzW9EKfO2pRD1?=
 =?us-ascii?Q?WV74AFO8rH0pCv1T7Ww5Npjq5mxQwgo/j6f+BmvQB4Wp2N8nZragowoCSl9T?=
 =?us-ascii?Q?t+Qb+gAIpfmfLa+L3fS6yNrXiMKdCdrJ85aOIztfDlmmIxpnoqHEYYXKsRZU?=
 =?us-ascii?Q?uhhmYzgRKrw+zHPv5cj2Kl/0qQIFWyCYc8wMRv11hCu0JWjq5CfNOrzMEi4n?=
 =?us-ascii?Q?2ypEDDNfn2k5JotsYV3D+e+lmst78SWPuCJ/digQES0DCTkiDPdwcj5tB1iI?=
 =?us-ascii?Q?P3ZY9U9w1YLybfgVl31flw07+3WW5LGGUM63UavawYjjwxCh4ZOtX8gsGpGv?=
 =?us-ascii?Q?knJ+vzB0ywmuiRWiqE1EFUpTJtiaEQGpGhVXBpFnvN+haD7XrLnEVQCs1KX0?=
 =?us-ascii?Q?nrbrlbRRKxXtM2PynOfWSwlpasUSM2Px27l3WETNiGQ8tU4oL+DuPPHC3Akn?=
 =?us-ascii?Q?9pEVc/pGK1oXO/R/g7gvFpLh1z4P3ItKtguHIeyJiuJ1yUu2YSh3QcMHPKmg?=
 =?us-ascii?Q?ncdcdLDfgQ/fSLBQur6sW56aZHBKUrt86badyOlnQ96UZ6nkxPPF3oIkcioR?=
 =?us-ascii?Q?P/i8NdmCi5GZZJANKxrsuilgS6sxzRS7we0w665L3BWL4jMxM1mV0Fa2B6Zf?=
 =?us-ascii?Q?84Xx3bRZgOqgghzo4OC54/d1nCZxfTZeqj6wma7EAOiNhgSnA9kHp5c9f2xy?=
 =?us-ascii?Q?9p3To+BnTndGhLkp428XV8nz2/pidiOZ4jpdQ9cOdkcANyMjWh8rLkt0+eO9?=
 =?us-ascii?Q?2Q4CwvkqeQ/rMij1HOz6/NttvnkO2JD98opUQR4FQ2OWOPlwulVhMvw2CUUG?=
 =?us-ascii?Q?uzHD7MIgg6+Tr3+wcU3U/fFRkrNEYJa14yFh8i5oXugZsyQc8H+8kL/3j70+?=
 =?us-ascii?Q?c7uEpNsGPQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed8d20f3-0d5d-4160-8879-08de8e4efaf6
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 11:25:00.5151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 96NaPr1N9sFV12c6anz4YD2Suxx0k2h0hHdyeSyBF3gT8XMG/6PEeDJ14jEIweynIWcOPa66NHzu0czoLqkkAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11481

ALSA controls should return 1 if the value in the control changed but the
control put operation fsl_xcvr_mode_put() only returns 0 or a negative
error code, causing ALSA to not generate any change events.

Add a suitable check in the function before updating the mode variable.

Fixes: 28564486866f ("ASoC: fsl_xcvr: Add XCVR ASoC CPU DAI driver")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_xcvr.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index 109e3e03f455..ee16cf681488 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -277,10 +277,17 @@ static int fsl_xcvr_mode_put(struct snd_kcontrol *kcontrol,
 	struct fsl_xcvr *xcvr = snd_soc_dai_get_drvdata(dai);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int *item = ucontrol->value.enumerated.item;
+	int val = snd_soc_enum_item_to_val(e, item[0]);
 	struct snd_soc_card *card = dai->component->card;
 	struct snd_soc_pcm_runtime *rtd;
+	int ret;
+
+	if (val < FSL_XCVR_MODE_SPDIF || val > FSL_XCVR_MODE_EARC)
+		return -EINVAL;
 
-	xcvr->mode = snd_soc_enum_item_to_val(e, item[0]);
+	ret = (xcvr->mode != val);
+
+	xcvr->mode = val;
 
 	fsl_xcvr_activate_ctl(dai, fsl_xcvr_arc_mode_kctl.name,
 			      (xcvr->mode == FSL_XCVR_MODE_ARC));
@@ -290,7 +297,7 @@ static int fsl_xcvr_mode_put(struct snd_kcontrol *kcontrol,
 	rtd = snd_soc_get_pcm_runtime(card, card->dai_link);
 	rtd->pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream_count =
 		(xcvr->mode == FSL_XCVR_MODE_SPDIF ? 1 : 0);
-	return 0;
+	return ret;
 }
 
 static int fsl_xcvr_mode_get(struct snd_kcontrol *kcontrol,
-- 
2.34.1


