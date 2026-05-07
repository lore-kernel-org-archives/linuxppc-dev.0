Return-Path: <linuxppc-dev+bounces-20540-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65345CD3436
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 May 2026 01:39:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9vzT0km8z30WS;
	Thu, 07 May 2026 11:38:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778117925;
	cv=pass; b=X5yfW+hoTNwc5+h1texlrX0b4tXG29wlhohEbmZhH0uWrxC41fV/GCH7XGwGvXu43Ux+dfiv1sFO6DogY2m/lYxRvEASxyznYs1x4Ix7v42VgoGfYpdO5oH53ksK+sHmLnMxVjA6tY155p3LPh8h/kK/LOentmc/BGL2Y3C5TvenWWtl+32uyQxSxQIBqcdW3RWixTCgkHMrKM1DCE+3efN/+1axZsK5v4PbS6GoLWGmAjNkTHnI7POTUHponMDW1lYHqd68iwGae0lrNvBTwV8uMoQ1dIBVevVwVIDcz4I8Ibml+h7pj5J/grjwIjNqjapS/QkAinJGoH0vFqknvA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778117925; c=relaxed/relaxed;
	bh=iHJ6nXuQ4SshV/oziQ5Gh1tJp9/USsj3RYqxbBv4csQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lv1ecR2mBJHY2eLqG2neOu5rIt1j+QDfmON9ASv11TP6mGqUCFEwsOPQs3JJd/2MsNWGw0Ofse1UX3Y6rMddmAyp6wP9AnLnwKtIwrXeo4DYQwHw2N2mq8yqgcq/ESCtjQ4z54kNdDvIr4BCUFt3HZwp5YKu/It0TJpZ758+qqRa0ZXGz6+g6g2Dw2juPJCRC2Gb2JzfK6juNuwokaV/H5Qiot5y6KItx+6A7E//gJWsjsIjgbN5C+Xr4v7i0NsKW63YGWNMo01fyABmdgTSh5qQh6FYtu2+jUz+QGT4CRVkj2YQGSZetzZz1FjBAtOfjrDPEhXZpuYJtnUnZ7+j6w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=jYmC2/3l; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=chancel.liu@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=jYmC2/3l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=chancel.liu@nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9vzS1cqsz30VX
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2026 11:38:44 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOwqTSCr6TiIVaxuiMBb4jgRYTQ46RTrj96cANikRKvuWcfTEHeo7YDwpP0TbnJGJdZyqhPI3mhbuWn4CkUhsDpOciqFYxGU+1Gr2MBXIQKOo3rizai1EdEI7R/Ub/y4kytJKCvpjR967h6yePwuLLxJYwfhI3cfGW0AzGXP2r38OSPc3kg72l6KfJnxECDNop/oJXDCw3r31uQQChCx2RET4+EdGHhxDLTJzMNsKytiCJsBPvqn9JVmNl7LfDiTwn8DDNvaGJPl1ML2+vOVbL1gTlCPTF5eXJVXQ4adVKF0dFbrJC0/Z5trQ7blvFo8TxEEBFOvGfOM5DQA9mahAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHJ6nXuQ4SshV/oziQ5Gh1tJp9/USsj3RYqxbBv4csQ=;
 b=ZB6Uvs4eFgXvYOaEgnVuJ1J5mxnyJYQ4Gybbl+wlNpv8j9yplBuRVoea7RYkTgTp3mLCh/ErN+AffnbGba5yxQ7LvWvVH9x77LnYstmoE7+8OhrTXlcywr8UHjV/0yLyYNpq0HJt9mjIs6E3dhKkbk/LvNKI49zkFuzDyodwrviQuNxqTk++pK9k1kF0Nx3FIz/FyGZg9givh8ApAk9EBHDD/DeXtySIRFqaMc9aezH3DbzTq5r2YC0jH5wFHvrFN+lCbs0TXcmh+MTgGp9nanmppKb/TtJi9FqGk+y1fmhKR1VhL/FEsMsApoqTC2+oA4IN4b75ke/LCmqCWrDcAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHJ6nXuQ4SshV/oziQ5Gh1tJp9/USsj3RYqxbBv4csQ=;
 b=jYmC2/3l0ODeiwx9VBl/SZs0lrP3mA8FcGAs6oFv0jV7fmS7lNIR3TIHgvzTrMBsJJHrdsxQWV8N7I5hKBzWlU4yHclaxdkMpgiWk/IrGUh6KuNGb3TNNxsl3ivJjgd1SywxztNHxQd6d61YvgbV3GQYrrbyG/yRNH2MRkWveTHyHPN/as9DU+3oaHIEE5KHUaQUJs3f+WWvaKko20YPlMT9sK6AL7vyFTANzZv+6UQCotI1TauxOSsP5GUCSW7CjCmLFUlG6J+cRYp8LKiwlFQppZ1M4/zxAljJ/KMufN94VtTiLff5ADrhZPcsLaISBWbtFMT30rQnEBsXM09ppw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8353.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::22)
 by PA2PR04MB10514.eurprd04.prod.outlook.com (2603:10a6:102:41e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 01:38:29 +0000
Received: from AM9PR04MB8353.eurprd04.prod.outlook.com
 ([fe80::46ae:f774:f04c:a1bc]) by AM9PR04MB8353.eurprd04.prod.outlook.com
 ([fe80::46ae:f774:f04c:a1bc%5]) with mapi id 15.20.9870.023; Thu, 7 May 2026
 01:38:29 +0000
From: Chancel Liu <chancel.liu@nxp.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	shumingf@realtek.com,
	pierre-louis.bossart@linux.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 3/3] ASoC: fsl: imx-rpmsg: Switch to core ignore-suspend-widgets support
Date: Thu,  7 May 2026 10:36:54 +0900
Message-ID: <20260507013654.2945915-4-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260507013654.2945915-1-chancel.liu@nxp.com>
References: <20260507013654.2945915-1-chancel.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0087.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bf::14) To AM9PR04MB8353.eurprd04.prod.outlook.com
 (2603:10a6:20b:3ef::22)
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
X-MS-TrafficTypeDiagnostic: AM9PR04MB8353:EE_|PA2PR04MB10514:EE_
X-MS-Office365-Filtering-Correlation-Id: 6be9ff3b-10a5-456b-f000-08deabd95757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|52116014|366016|921020|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	kBM/xioG2eXmITrpsbKsJQ53HnYUhLaRkiunnMdf+2phRFbOItiTT39wP5G2rpP18YkiN3scE7qzv2TCuNJOsLxMIO8lkzxD4jGMEIVGpsKQVf/faRMo09d0EHrtW4pSt1/xd8Yiio9qGkPhDEqKY5Cm7OFuGlK3bY/URFT8FNlecQKeiCLe86TYV2iIwQVPjnfcX4M9V2SrDoHXxJcrAORYb+AZIfYRB8lSvGjLSF6h93X1ceyXuYHdVKhDzppzLnHFMQUbp43pFIs+R7l1Si69eZ5IUmKKIO0it8PpK9GNtnkoIKYedbDDloOfJjy4nF3xm4VNg2pdeSNw1LgnxtYSPfRLM8Y2ctYJEySPu5g2dztE6N8nP3ZN2aRO07E/1YXKB9kPxDBuuuQ+QrOKMBP+UkM8UMcgJzMgo0rRzHNgKABhOaghIuJquVbgoncwPTUPrXtZOPd43YY4NchTPpc5Wh1us7oQyCobXTZjgLI6RVUzaFDCqOfaQGJT0Nm+J9KkyeFFh4G6/1rFV3+UBwDgLXbvHw67GGSR3SBTdoan3bk2bYbpeQVzyogO4Q8m8IMzKnQRiMt4hw3rrToe0F884Af/kysXfSRAuqqZ4C3Q4w4IrSCspbUGWTqv5qdhDo5+durLGv/yZqy05RwQQC5dkZAH7w166yGbFVtcGlbB1afOV6pZ3UKygrkU6d6TXNmSW3K5cjBfk+ysxMBlmPgwN/eCBpz4npiVLcLdRd8yOAgJfSHLj5BE6LBThIgSB1yd2xq6knnyYknNaI9K2A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8353.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(52116014)(366016)(921020)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F4rW0XztjmeV5j2nSEUTXZctRzYpZo5I+rdXf47FPjohYCIEMOVQDuaOCBap?=
 =?us-ascii?Q?c7Igox4VPgqzq8Fhp9KMb9Z/pA1E2o0LzK0ClPzxlnx/mQgsIMr5r1VPS8zC?=
 =?us-ascii?Q?2KgKVhd6nn4TXwRJXJjkvewsp+TIHwzCaP6v9eSdM1mnJAUVrmkhV2m94H8b?=
 =?us-ascii?Q?uD3MwzPHvzOOu2y8woZbGKmzyCnccOft/vRMhaexRGOv30pQalI7F9DspkM8?=
 =?us-ascii?Q?TyzPjC87gYLT9Kt8O0e2M1ZiXaN/q15WYXjing+QagAbpprzz7Tr1wut1TZc?=
 =?us-ascii?Q?3OCQaI7UkM6cXQ0Z1EKxUZajfwdAjbYm8V0mEh44gbztFWQEdNyheUHrJR9X?=
 =?us-ascii?Q?XOmFU5HLeSzljrS9cBMRAblantXMCkoaC/tlEvlVgz1i3ed7s5tSQLaFtSWb?=
 =?us-ascii?Q?rqNmSaAth8f5EkjROMB11Jek3F2RLlKc4cjv79EPANAXQJ3XTB6wg+dHBpD5?=
 =?us-ascii?Q?KL3w84vq0/IEHFtrwF96dBwgG/J8VdxfhPG8qfmDLkyDGWVmfJGwFNWqmwpK?=
 =?us-ascii?Q?t6mazQjR27I+JME7EVxyhPBRVDvoKS4I006KXZpv35jfqhCZytpOWw45zxMq?=
 =?us-ascii?Q?QIejZHX80Wuu2sycQAC8F7qFnaiLE3AhuqUiqqRIt3CHdCxWFLvfJeUjfgB/?=
 =?us-ascii?Q?Odvp8vFdE4bJemWfwKfWCWVX/mLzdnh7stc7CyPXFuVm6pXbvwQzJD/CYKKz?=
 =?us-ascii?Q?QUDq0K1KC7TyQrt4Lit7xL9qBCGXZ7xF/Vqb6sKZnJbYgc6vyZO4Gik2oJ1G?=
 =?us-ascii?Q?CfoJbchC0Wieu9PI/Sg5P7+zlpFKap+qJsSQZcfQPZyUiHeAb+K7ewVG3GMC?=
 =?us-ascii?Q?9A74qcDd4k2ySh78f4V0PTpntb+z9skkw50doW0/k8ImIc/7tPY4fZkATMp4?=
 =?us-ascii?Q?mgpueGwnTEocw5+TpwYm0U0KUaF68y4ByP+ipvd8AL2pCOn2I86Ad5q3jyBl?=
 =?us-ascii?Q?qWARXnaPSluqA7bkx/ftIDUO44rv5gdagMcqspv1DaT/cyAqNH2Yr8r2uxqy?=
 =?us-ascii?Q?tfsXzWm3DuL/0EypvjlnkPdFaIprxpHHxFX97bsxAXoRtwCjFtv2i4WW3LWl?=
 =?us-ascii?Q?Lkdqf+D4aiG+nQbH1T/OWgd88EO4N3lap0N3tH3pYTWRFNZUZ/Kb5FgJNAb9?=
 =?us-ascii?Q?sHFiOiKmTpG0+miGSfUNKfT8zW+3Ja49PD292iKokeF7Wmn6ufpym9Ib1VQ0?=
 =?us-ascii?Q?nQwNCJxkk/CQqAWsZckCC+TBAFg3GUx0A/vEIyUe7VARY489tvkmlB5S/T7D?=
 =?us-ascii?Q?FaoJwPf35QC29wmk4ZrzG2DwB1VxSfBPPg9prLOx4bmD3t5BJRXiGhiPub7Z?=
 =?us-ascii?Q?6lF/JCRLPpoQIKGaVG7ktX/q4yLfTTQXZtY6BXl6HauikBAGQadVYFYKYyMl?=
 =?us-ascii?Q?YyeezGKSjS1tCqEWig2r+WPhi+paeJYjW2VPVFda5lyxFSrRG8Wrt0VmFOJR?=
 =?us-ascii?Q?kQhWIrHAV0oox47n7/ruE8JWgYwGwTGLWUKRmsS8T7nPhcYBrAjQ5EVdTWQ7?=
 =?us-ascii?Q?adG3UQ5QtNgQO3Ct8TVQDHATU5vTmoaIC03aAVxpK8fCMT4FaA++nGNCYOk+?=
 =?us-ascii?Q?rnpYaB0J+eNNU0SKNYn9iQZykKQ/PRZacB+GijcQusM6XRckok8B1RFMPwjY?=
 =?us-ascii?Q?X8mmGYIp422wrVKZxvPxsdpj1kCVLQtYXfzgqRTVZPyJxUKQk2Fo6NxJQpGM?=
 =?us-ascii?Q?MvZK3jQ+gA62UhBmmcSkv0Hbsn+EAteEOp5UQ6W+116ML6ZRxl0MCVzPsZG5?=
 =?us-ascii?Q?/BHgwt74dg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be9ff3b-10a5-456b-f000-08deabd95757
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8353.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 01:38:29.5903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZICdXlvn+k1q21DgoRTk36eMN3Llwl5/9vtLh0j93ILRZ5L5B3yoI3vVpd6XIjVT8aC82sDGbKl8ZjoFUgsgUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10514

The imx-rpmsg machine driver currently implements its own logic to
parse ignore-suspend-widgets from Device Tree and manually traverse
DAPM widgets to mark them as ignore_suspend.

It also has a potential issue that some widgets listed in the property
(e.g. "Headphone Jack") belong to card or CPU DAI DAPM context.

Switch to use snd_soc_of_parse_ignore_suspend_widgets() with the
introduction of a generic ignore-suspend-widgets mechanism in the ASoC
core.

Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
 sound/soc/fsl/imx-rpmsg.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/sound/soc/fsl/imx-rpmsg.c b/sound/soc/fsl/imx-rpmsg.c
index 40e0043cfe15..fd4624786b62 100644
--- a/sound/soc/fsl/imx-rpmsg.c
+++ b/sound/soc/fsl/imx-rpmsg.c
@@ -87,7 +87,6 @@ static int imx_rpmsg_late_probe(struct snd_soc_card *card)
 	int ret;
 
 	if (data->lpa) {
-		struct snd_soc_component *codec_comp;
 		struct device_node *codec_np;
 		struct device_driver *codec_drv;
 		struct device *codec_dev = NULL;
@@ -107,22 +106,6 @@ static int imx_rpmsg_late_probe(struct snd_soc_card *card)
 			}
 		}
 		if (codec_dev) {
-			codec_comp = snd_soc_lookup_component_nolocked(codec_dev, NULL);
-			if (codec_comp) {
-				int i, num_widgets;
-				const char *widgets;
-				struct snd_soc_dapm_context *dapm;
-
-				num_widgets = of_property_count_strings(data->card.dev->of_node,
-									"ignore-suspend-widgets");
-				for (i = 0; i < num_widgets; i++) {
-					of_property_read_string_index(data->card.dev->of_node,
-								      "ignore-suspend-widgets",
-								      i, &widgets);
-					dapm = snd_soc_component_to_dapm(codec_comp);
-					snd_soc_dapm_ignore_suspend(dapm, widgets);
-				}
-			}
 			codec_drv = codec_dev->driver;
 			if (codec_drv->pm) {
 				memcpy(&lpa_pm, codec_drv->pm, sizeof(lpa_pm));
@@ -274,6 +257,15 @@ static int imx_rpmsg_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (data->lpa && of_property_present(np, "ignore-suspend-widgets")) {
+		ret = snd_soc_of_parse_ignore_suspend_widgets(&data->card,
+							      "ignore-suspend-widgets");
+		if (ret) {
+			dev_err(&pdev->dev, "failed to parse ignore-suspend-widgets: %d\n", ret);
+			goto fail;
+		}
+	}
+
 	platform_set_drvdata(pdev, &data->card);
 	snd_soc_card_set_drvdata(&data->card, data);
 	ret = devm_snd_soc_register_card(&pdev->dev, &data->card);
-- 
2.50.1


