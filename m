Return-Path: <linuxppc-dev+bounces-19015-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37BAC10D14A3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 11:25:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkpnn6vM4z2yh4;
	Mon, 30 Mar 2026 22:25:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774869917;
	cv=pass; b=PgfKunuaTh7UuvaVH0lxX4JjDbTdQdyNaw9k52tE4lm+2RMlXZYIHUdNyCXzJFEmUAB+1WFH8ZbMO8Su2pX6wx17MJhv7ZF8ydc7difHM5u2vWdqcPVN7AEcgFevBq3VQQPL/TNhlZ/iIGb3wGxhOUjH7usYfmrRStcC75xfhweS2fPAMdj+rB1eBLgZaGltHLhY0PJsq+EaRr3V3EV+nMZLN6GRdzHkG0tjfsHZ4u3I7yT/tOT49alwmwbvxKUXdcXzAESrzFgWrX7dnjlPAm23xjFw/hpdWkX6XkUlUTo6+/SkRsmGz1M0mdfZaUJrWiZ0dTO8TEgmkm7ZLm6KfQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774869917; c=relaxed/relaxed;
	bh=9Oi/2KTsaG7nxKIQclwlTR7Vxue18R5nbgO2D18qPW4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NxVBdqzxkvcovQhryU5R9gy++acGZT8jvIbN4Yzi9bOe82IKIiiEuk1eruonWyjnnRv2N3PCICZt2bZogbCQHWW8bJAhwuw9ij6h1NYlpVs17Gb0+k2ThDL31ZvfV2pMUdrFS6T4XW4RlYXSV6YBhneayiWvpNUbFgFI1eYaX04k7CUMRjGzrOkPzGD/vdOOvOrQ2NtbfRFDSkV1E3OL/mThdZDccvD7CVpzCjOz1Kxq6D0l3yGMqbVcKUif5MOYsce1gT8+daAZhFSNLnpIBUXKjoPDWoC2F0PDs6jZyeiUr8R7f+xzb3jBJ9H3AqmYFBKC/DNilMpIiajvQbDEhQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ZUBOhjKR; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ZUBOhjKR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkpnn1yMrz2xpt
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 22:25:17 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYjaByX9Fuq48Np2vFCdPKFhk8iSM7xj+w16IfUUVHhjVq7iafZukLKVlYn+3hsGP84tlrj7qMIkHkMaK1UOeaBge64g1Ld/17Vvfh42J6tWnz4MQIovv1jwnm+rttuvYvalJpcPf4rL4jLrvpza3dJfuhWD7lQjZA9i4MvuyxTwCYC2wgEkEIR/jd+Nqif13+aAmEZl8+xiaMQb2sG/d+nFlYRANRlJrKe3poLNeMk1GwTlmvDkCw+wxM6bdllNXWP+7FAD6q8D1lAkFO9i/mPSNvFMIVy2yivSuYdRok6AFRRrrShPPn9dW2tbKEq/OxM5skrUl2QePJujQhJP4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Oi/2KTsaG7nxKIQclwlTR7Vxue18R5nbgO2D18qPW4=;
 b=rKm2ipzMtAEubDSrtAYzP5TBm8Ih9meAQC2qzCKiuF3dhOSxRgyVoxV/VFpjb4sYNFxGkxoE/ZsXPOg6NOZTvSIkRgSO+hVkIUKhTmm2BOYgSdLgD+ly7MdEmhlKxT79hz3nbO1bE7PQO5aA5dVuErkSZMs8Tug4jXtfM+6fb62J6mxl17KSizPjZzVC1P7Bw4Y3IrHnUTOR2aZsbJlZROsMziCBQOz82aevhfnMKpHbHIpalHidYGmGz9AxsuEJGgY7Muiyvr/VfEja1PF/3uyUx1shj9LR2ezxgW4yRXlxgCU/qCdM7xn4qXnuKO5FWfTafrOp13gG8tmoe20PnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Oi/2KTsaG7nxKIQclwlTR7Vxue18R5nbgO2D18qPW4=;
 b=ZUBOhjKRLEymJclsNCuDYLW4maF2Gsuf+kCiof5JfCb5b/1M7nkEdRBjB8LL08uoMqqVgHwUhHZWA95WKmNnI+JhxZXJ1CU87SwB8j/HsDbmDGV9+KCtc2yhJrfYSLsp53AwkNRL/il3bh+OQjb6fjA3RQvk90ZdW7SCsZitwIhSdtCVGI8IUJbRm6vMSIIKwYPCb/NoaiZorhjLqoLl+/GMgQpCtboAspsx8gOIR3pVuh4gExS3ONtyYBw1GMWSLr3T6pPdzcHzyebifH27dtfKp/SdCaB697cfHRLhghvKXcvRs0/hXFbb8g6tJhXF4Mh6lsUJbCutttipH6nPNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by VI0PR04MB11481.eurprd04.prod.outlook.com (2603:10a6:800:2c8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 11:24:52 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b%4]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 11:24:52 +0000
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
Subject: [PATCH 06/11] ASoC: fsl_micfil: Fix event generation in micfil_quality_set()
Date: Mon, 30 Mar 2026 19:25:50 +0800
Message-Id: <20260330112555.3637002-7-shengjiu.wang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 66ec4dd9-62d2-4f1f-1a11-08de8e4ef620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|19092799006|22082099003|56012099003|18002099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	xfVC3Q1KiBeV9mQwUwRbzGhHFscqVWXIBnvf50A1grzucKhyZOxvloI2nYyEErC5P8V+dNPRe415jeNMIenifOh0XApFXac2H5Ke1kvbhTJ2FX4sWsOxZCVQyTry+uSphCEBDgD1ijdUnUqnWkEDpbDlTHb0hNLzOEMoLj/b5E393+JJIwHkb4DqOf49CmnAuD3tZ9Jl42y4JPnECZjWn8No0T5nrL1mlYk2Ng4fr87H7Z799BeGE9E9zkSJ3UHOkn97YhixdpMgoaYYJgvV3Pxt8cLzl9Wp3eFNo/EFCqDk2gybw2APo2dHwoNQrUM+he1PyrdVnuJvyBNiha9jl/ZK+nSScAsmsJA9nXgAly0Ak+o4xjyKWaVj7Jtzdw2qJNw2wzxEQt7QTapm2wwY6f//a4eEzlNoxGRgMypxPxBYoayH3XiNV2cw3Ugdr+G4NxgS9AI542Kcy3QU7R4aGHL/lwGhi23ql7OWRlihhXU6CgC01PyD9H2qQyOGGre1N9/maMPlx+x722F2Q4hePeiRHCUuziv3YNcIaoIrFku5Ez3trQLyNtbFGVxgx2BDL4p9XvLhFtwj74aCN6SifVx3Ohm7Xx6+HJ30a4z8ogq1jtTsTMwufnRdHypKKd0s2WysipVN9b5r9d2IMoAdC5mz/HFc97Sz34+kVbMKk3HfuBV5NLzyoEujzAjPGUHLL7jYRC20H++EgkGXt903SzKk4jEIJ2xLmaWS9uBY7h/9rnMY++sFKmhAJ7e9bq2KKqXrSTHJx4onmPh5klBSK4qPLsrvs30TyoDCMzds8yAY8EpOfSvx4X/KKGuHOWzY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(19092799006)(22082099003)(56012099003)(18002099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1nIbLnt+O4HHWAZ+GyKM1RGMUOhXtP6qWe5VeItZrbGmZvpLm+xC7oFvWpdG?=
 =?us-ascii?Q?Yw+Q/4g/HRdhyUu3ti40W0O1iUzaOKTffD0p5OKOXPG3hgFk0tsjutlYLan3?=
 =?us-ascii?Q?ZLX0ifpS6WHIvcenj+diTApz3+8Yjn606A/PXTaJnzVdnP9QDAgyfffit7Dt?=
 =?us-ascii?Q?Tp4kj/4OtNIrf/xds1lBfbSSIWisDDENry69FNVKh/PlSkneueXrA1dneP+5?=
 =?us-ascii?Q?9Q5WA3pe7YXvKKaE1/D1rynZu55LvvqC6N+7obI8EqGT9YRzjI/83aWJR8Wx?=
 =?us-ascii?Q?OQso9k312+ctEwhLKklJALcBIYf3hx/OuF/QSkv5vvI7Mj2AHkEZSjKWaMVZ?=
 =?us-ascii?Q?ZeJA/a4f7mxLFullqKUNVeTzxhzuOggTfKCCPRafnQy6z9dHBVt5P+Ijzsep?=
 =?us-ascii?Q?SjmyURCyhM8FCeyyYdnvRGvncTrhBTWkSCGSUWEg7tWN/HHP9TbBMjuG2Aer?=
 =?us-ascii?Q?AvuhAr9ez5c2T/4pa+RwHotHtYKvnmNA2wqFj83/mqE22S/4HxkZ40Vk4i+P?=
 =?us-ascii?Q?s1P+I4oNtIEwYz2VKG2CUydhXTzp18Vv9monyuQ2zzD7jiNvGuiIUWnNmSTL?=
 =?us-ascii?Q?1VFsgvYFm42pBcsGcggabswHY+FMeSC1vAffzVGsEg/3ZQ/ke24r31k62d81?=
 =?us-ascii?Q?ax6tckDWan+IlgnChPyyr9Xi10B/uBiIlVp+FIeP/GQ8arz0IODWRRtP+fJn?=
 =?us-ascii?Q?rM/pdHAY+ZHap/Dz5sg2+LxnUbcWpqFpr7q1I0Xf/8jMV7vZDWkeJ/HbWozs?=
 =?us-ascii?Q?e3EqKphPuUNcY8G0s0M9QzJF3D8zUbEGv8WiuZKxGe6yiKxDIlhnOra0+6xu?=
 =?us-ascii?Q?YO3qEm9XyuCHZHYU12zDC37EO/1gyej4nOLEdTFfzH1eh54X3PHLraQIOGAh?=
 =?us-ascii?Q?/wmHqMUWYbJb7LgJ03DZhuVsXhEAFkg3tDGLsR+R+waaZWMvEAu8ZRmrzU+D?=
 =?us-ascii?Q?vDDlhYTh2/oKOWmoHAQa8/wL4RvYZ6o6d9g9j2QjkYLsKOcBVvtSPqWm+/xc?=
 =?us-ascii?Q?NwO7WQoMKUwlrZUvEHf9kA+hA4gbzGiYUuqgmdMkw9aDKN2hjF1FjwACgjLN?=
 =?us-ascii?Q?dHpHX0yFNQigZSNoqfREQOESrK9maM3xZgsT5Vf1Ge9sHUUF5QInYNzuEO+F?=
 =?us-ascii?Q?S0nz+zIga8mXtJ8cF5qx62Oh/23Lju/mz6WcNfN8wY7ChzIiElZRn2agl0Bm?=
 =?us-ascii?Q?oQ9NQHKGtcsc4ov087lzN+9bgzknzLdOfTixYIHWAzPP5NPJedYTweICcHSg?=
 =?us-ascii?Q?GVIita7GLTLY2ZacRH8pScLgkeVZjQdsS2D8amHI4e4dDKu/sg1lXArZCIAF?=
 =?us-ascii?Q?Q3jxFeTySRdS/9+a6cyOOlPQkQDWiXaXghtitcjrXsl8M0A83LFl+8eR3pw+?=
 =?us-ascii?Q?AMy5TO+AWWASxqUo1edZSCby/uBkTDwWEvpAMpqTffalSma/A1+gWu5vL4nm?=
 =?us-ascii?Q?0my7XE9N6UszQb7NCcngPBlccL2RYoONQEWdyJwacm+af7g0u6ln0yStcP3Y?=
 =?us-ascii?Q?BpwaJaa01rL/wHB8wN0JklLM5i321u348KYYw4IfY2J8C8SkiqCL8zkYhwEj?=
 =?us-ascii?Q?J45eWd3+tPjQ7qXWcyAyluV07SYl/nVqK7EZFVROpMStucFRChEF7nqGK3aH?=
 =?us-ascii?Q?A+n2+w6QjI91Gp/v/CjsUVdiq8geu6o0YQT4WS/MNAPtYUAzHE9rqtKgIuNI?=
 =?us-ascii?Q?clyDtPvX3ZxxnOOCIxtPtzoU6hOnwtEn5Dzh4QlXdELUX4p9BfUZ3BMG2jZ9?=
 =?us-ascii?Q?1Hq+AuFMKA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ec4dd9-62d2-4f1f-1a11-08de8e4ef620
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 11:24:52.4540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z0HLcOIOO0LiuWLSwBDC7tlSrChLB4ql7rHt5CPZ9rItorgD1bT2Lhe8eJvOAO+Chy5upvYrjMpqEREQCEdbQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11481

ALSA controls should return 1 if the value in the control changed but the
control put operation micfil_quality_set() only returns 0 or a negative
error code, causing ALSA to not generate any change events.

Add a suitable check in the function before updating the quality variable.

Also enable pm runtime before calling the function micfil_set_quality()
to make the regmap cache data align with the value in hardware.

Fixes: bea1d61d5892 ("ASoC: fsl_micfil: rework quality setting")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_micfil.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 983805bbaae2..2e887f1f1f36 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -289,10 +289,34 @@ static int micfil_quality_set(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_component *cmpnt = snd_kcontrol_chip(kcontrol);
 	struct fsl_micfil *micfil = snd_soc_component_get_drvdata(cmpnt);
+	int val = ucontrol->value.integer.value[0];
+	bool change = false;
+	int old_val;
+	int ret;
+
+	if (val < QUALITY_HIGH || val > QUALITY_VLOW2)
+		return -EINVAL;
+
+	if (micfil->quality != val) {
+		ret = pm_runtime_resume_and_get(cmpnt->dev);
+		if (ret)
+			return ret;
+
+		old_val = micfil->quality;
+		micfil->quality = val;
+		ret = micfil_set_quality(micfil);
 
-	micfil->quality = ucontrol->value.integer.value[0];
+		pm_runtime_put_autosuspend(cmpnt->dev);
 
-	return micfil_set_quality(micfil);
+		if (ret) {
+			micfil->quality = old_val;
+			return ret;
+		}
+
+		change = true;
+	}
+
+	return change;
 }
 
 static const char * const micfil_hwvad_enable[] = {
-- 
2.34.1


