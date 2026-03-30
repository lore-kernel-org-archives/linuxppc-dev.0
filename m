Return-Path: <linuxppc-dev+bounces-19013-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECABC10D14A4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 11:25:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkpnT3Jksz2yr8;
	Mon, 30 Mar 2026 22:25:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774869901;
	cv=pass; b=IE2YoLxSO3QsPpLq3Z9fY7wGKXuvcwnXK52JiJP7XxvS4bQqINSKZIBjc0YBvOfos0wNukStqTUL01kOs1BUriTxpz46ZYVHi++Pc3tbVcBV5mCEgTvVYE4jmY5dW0V+en/8mRHHTbXxZ7mpZsW6EQk1fh5okqPiCs0glXzEav5BK4Mpmmnc1b1u1X+vUCn4dyciPgUSN4BpXjV9cLIMOpRMZV9UGdEd6X4LnNE5ruiXl826E+ibg2nU9AKue6QjszndYxXfg0WeXT0XznANnAxvwOySBin4DXas1x9vqeDrOljC72HsMRRjlOUaOF2lBBtuqIE786z4eTVvcS4ImA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774869901; c=relaxed/relaxed;
	bh=haS41qD/fAlt8cHSvubSuj5P3Zr9kdx2zsfBPqlcmMw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OfrhLB/lIxykma8Ar/eNmdHbPjVm/CQc19dnNtTpmXdi8NNyScE8hRkEsqsMCPywZVOG6HjRO963LXIcmyU1DC0HHf4WlEKns7qSU6tuPahpR/gzREKkUUULWq/+rUBXt9s4c6EVKDWmsf0hLAF41K9Vp/FInQ/3jMyofgmEb8t2ABpgWQ4OR6Pc/Xq9ZYrLBanO38qWTDo88gW/3RhK9vIpkTX1OLEgW47eR8WXlLRjMYTObt2pelgBOfha/PKm0ATDPxfO0deSN7S3LW1GYZz9yPCTPGzXvoOXEPWfXeyKtmfvtn6KauXXkUUlhKINedGMa2yrxYfprXZ5zhYhiQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=oRYoUfaB; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=oRYoUfaB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkpnS5N8Jz2yqc
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 22:25:00 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LE3fI3mE9WgB9v6XgCJj6pjelZiwuZsIYnjChLMT4rLdbMh9ZfyXBz62uc3DVirJMRrCAYzMtoeqLdXDzWNQb7CeQJC5HUixvJJWb7ySbVTapCy5ubdRlIyFl0zIz+BfMEsC9lT+ghipH5w6Azul5DdhrahzSmC9hWy3t5FbFum7nXWp/De83HQ6X9sKvqTVJ6TlomLgEpqbmrux7NeY+w6TL8EQbpH4RWnMo7Pc5a4PCPXkDlw4p4RPyOtFHEeu0ANKVhVkuMsi/OC2M/CTvKtSIgrbWp+iruYv0m5DLXEkSO/o50n18tznd90jvknXZx+dSN9h2Wv/djGOClNO6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haS41qD/fAlt8cHSvubSuj5P3Zr9kdx2zsfBPqlcmMw=;
 b=qMTcEO/8yuKZHzR+d4hCMlWVR9vUaeKDbKTIPNHQKOIE9MyIkUi9wNqKmjklEWoBC/Ycn/yJdb/RFvDU9cjzPMm+1WjQnF993E5ma2w2IAxEDgqLg88yA2oIWkg6pnVtX8yM38XmlTwpfeUZPABXd789T4bq6JS89loQ45t9wg82aD/NJih3LAZFJ6tMG5j6W7ZsB80PZAkiD9iHc4kgO/W8MsJjwiUyIHWp5fZxgVF1nQA0JsLfnbnqcYeZzdwqYngT4tVDUuvwZ04CdObYlXwPrfevUMRMDqzjqu/PpM9XbX379LdzH9I2D2KfRv2/C2CPR+GDouA+vD/QpGSsMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haS41qD/fAlt8cHSvubSuj5P3Zr9kdx2zsfBPqlcmMw=;
 b=oRYoUfaBVoydTJZ/tkUvIsT1nFVghXy2vu3P5+tvmE2jvyJ9uQItmXu4WMjiuP9es/iAR2KR5a5Q1lG3CVicqoTUFTv5Qn8R9NTkY+r8AvYzdXJawRL8x7QCLPLnj7HrudpoBFXeIM037O94pcTVt7pIckXdmEh3tKloyQbsiDTPB1XMNhpt42QsomN6zRTtCB6bfJ0kMh7ArH/WCqYY7anhdoMD+eY52Hy4jRM7io2vTDv1+Xjsg/AGTKDMM88Y51WOIaOYczazCIQNyJ3Lg04sIXbTUyovIi2PLIhSf6RYI19Qtx1JvYycb23GmDLFvbCRFOWUyVwM4AoNNy7iQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by PA1PR04MB11036.eurprd04.prod.outlook.com (2603:10a6:102:48b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 11:24:48 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b%4]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 11:24:48 +0000
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
Subject: [PATCH 05/11] ASoC: fsl_micfil: Fix event generation in micfil_put_dc_remover_state()
Date: Mon, 30 Mar 2026 19:25:49 +0800
Message-Id: <20260330112555.3637002-6-shengjiu.wang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|PA1PR04MB11036:EE_
X-MS-Office365-Filtering-Correlation-Id: 28d63676-e1e2-4c9c-c7f6-08de8e4ef3de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|7416014|52116014|376014|366016|56012099003|22082099003|18002099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	RmpFCS1ZlpfplBSV39eqWH3rC56OVeDLUO87BmVipI11k//7pBVCeZLjJpJ2/4px1ubI15PReWP5aQnLvrvKBzzLsd0bXaTcYgNWucvBWcx0zT0dPBEHcACzDwANg3uHeys5+zkslD0O3tUT51LDOQmmxxpZMdomz7UF9DWoiFLVwbGRhsB/E8F/tnyFO4TRasmEoZZJCLgVEw3nXrAM9VQY20I3Uhu4Rl4v2Ri3jvU9YcTErFV9ia7/oUgTIVYDdu0T4jsTRr9fY6a/an+kn9L8XxfW5XSiA6Y85dKQ9X7UA6Umt/H6HRUY2SZYEPFURkqCjfvWLdXDUefQZOIR0QRV9NrgjM7psLognJxJLfeFHJhyh9f6pDzYyEUSY6vH5kdf2IDSTEmWCjr8sY1llek43EglxEQoirYGbCbooU4BYG71+02o0Fyb5pcANiFm31+XIDSgN8V15gxhUU58Kg7udUO/M00RVAX5fdhK6++Cs/zprhlBKkJaEzKHnUaxYbPqXjmHCIelniho1k+T0EGDBf61/9UVmdpOyGHxrIm7mwptiu6h8sPwxdfajqJmU4CHluo7rOEeRCSgJ5PnMLYJKYaMQgQAVYB+zr1uJpe0wun3Ek0wxKnqIsI3xfrR7O0jxFaPSutdNwLyZ4PmscurLyW4qdf86RcUFluXkQfrp0MJs4jUGWhYP3ymMS6s/LkRZOv/rp9fz1O2ZAsrI36bOyi8wnW+bIXl88Vh+1ow5Fj4tHKCUaI5iV2SI+vpCAO7oI91JKQPfVzuZC/VsGFJwUamk93/YEtIshOLCfJ6jW1HnH189hWmmqQqFcSv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(7416014)(52116014)(376014)(366016)(56012099003)(22082099003)(18002099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GOjHPfpZHVkis+75teV/Fhv87NTb31KFx4aLwfLh8I+qHUmTKU1Gt69uMBKo?=
 =?us-ascii?Q?wijPwoI0bBexM9JcoyqwuK6VYgbCC2Sy8feJaM+lvqrrgfW22NWiZSTOqi4C?=
 =?us-ascii?Q?Dk0Foi9FgycEDx1x0h2zfUi+rd2brF6Zz/Fz0BXoWc2dPQmVH0pqFyNyloMc?=
 =?us-ascii?Q?KfgbNuvwCwP3RITVtLG3k34ULAsdSiTkI9RlgrZCQ6G3n2YHOCiedNvU4On9?=
 =?us-ascii?Q?xrf5b8qNBgfyPugQb1wH7iNJ6l/5MS6kKKn1sazmmvKex29cV2D3KiEQrIyv?=
 =?us-ascii?Q?SbOs9Fr1tB0Swll0jHACZBydF/62EAYXQ/P0j3aqO8h1mNZJymBFnnwrFTCg?=
 =?us-ascii?Q?YQwXtAaOcNaBrAT1YzANEMOf2pY+I8/gSI55smkNaTaM/w76wuxnwawhrqjf?=
 =?us-ascii?Q?lI73dbyIKh5KlCp2wbLRVl+BsAzAMsXZdi3L3+sR+Gj+2ErqzymU479cUuMx?=
 =?us-ascii?Q?ZwqzyliJsK3xPpDd9Qm1bKkaRicjy3/C8jru4nwPgnJw0aEUY8fum6qtP0M/?=
 =?us-ascii?Q?/sfC/kMl0CK37ThY0Qbxg2USk1yoq4Pu2V8YxAYjidzW3OjrQ+mLyGYo7Xaj?=
 =?us-ascii?Q?slpOYltPlxg5pIBS794LzvQY7LjVGQWRJoeu2Sh/i2FWPzeK0fQD3VQkg8+R?=
 =?us-ascii?Q?JoZhxa/yEugFTosNagXr2GqlNs/7AUwPLaSLHmyGL2mHpGPuDYeqpc7Zy6Ey?=
 =?us-ascii?Q?8yYYl2eXUJrrPAzywyOZ9go5BPioIGJ6AZ99yasciXxEHHiFJGkQ8ipeQWEo?=
 =?us-ascii?Q?7CILzVdr5sp6KvcsPClZ4qysvctDq5dZyvZN/e4XeO+TG54pKaDot9sBhCG3?=
 =?us-ascii?Q?h2rRt/cwfIgmPoxJhkMt4yosmTd31LAlZHBgiD679H4IOMxusnMBJnlT9OsJ?=
 =?us-ascii?Q?KG9zChE1F4rcOA+9GPJvxEYpGYFI2s0yO1B7pNzjZ41Ss0bTHap8/qdJFHU7?=
 =?us-ascii?Q?ms3hVhYrfgn0L6eNpzj8UWFgoWFHW7YMGXSxLAC4U9v85Mq2eiT5i/AEtt8G?=
 =?us-ascii?Q?meaDll5btagg9Wx/uPvzii8bVRi7FN5ovXYbhH2nkVfqxhuun4WP5fOnYpBz?=
 =?us-ascii?Q?5x4JgkuflLYyfcswvZQU4vhyEwelzJc0r00q9+dw4iZevsOKaPYw79kdejXn?=
 =?us-ascii?Q?K0yGyPT+jhsBOo7r7JYMVJWw0mt83xJr6WqoDHNZ6eMmhd4TGFL8xtEbqFpK?=
 =?us-ascii?Q?AnzzGbeGPnW8w+fRiAWB596ShBH2OWETVhi7LlSouMoG42J2zyHjTfbo3TTF?=
 =?us-ascii?Q?OjhdM86cs6dcTteDUmwTp4pP/OuuKE/eJ6QvE4Md6iNrPFaYu+Qj1sv5ldTP?=
 =?us-ascii?Q?EHVIhMHplPk665vvoYFZ7j064G+Wxk4Rx7WbTjD/K1AvJgtB7EyAbVRvb7UC?=
 =?us-ascii?Q?RRGlrTVK9NUyAKo85h7DZeFWPje+5WyOZsv26T4YQMjAar4y4Kz7h1W1w8up?=
 =?us-ascii?Q?mlEtZo0g+loW39ZiZC3O7qO+NJCcjRfSWrj9U6qBenAGV9eHXkInct8wZKHu?=
 =?us-ascii?Q?anUBXTs3kNbcmMZr81e9BnA8AFmlNwuZp4pPCQBxKku8Q5yYsl9bT4j5pGc0?=
 =?us-ascii?Q?lTlqb5OmquVWFoGrleASW5XG5YWEmYmN0Wo7M5MYvXq7Hx3PQCDqSYmiKRJj?=
 =?us-ascii?Q?ZgKAizmOWxtnSaKti93pONXviExLdL7IkLmCqiox3wlscZr+DproipRhV390?=
 =?us-ascii?Q?c/JBEQi68HLa+vefvRLHvEAjZFvrKiyipauCPUVPiVehivPkeCxABv7ffnGW?=
 =?us-ascii?Q?NLYwnbabHQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d63676-e1e2-4c9c-c7f6-08de8e4ef3de
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 11:24:48.6315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xesnZ50jpj9od0BNCVGWFeJLCKIqwUm/V56ZyLfD/NgI0L5U0E1GysxqbctqTLOuUpysOB2wXGLKY7gsCVNWvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11036

ALSA controls should return 1 if the value in the control changed but the
control put operation micfil_put_dc_remover_state() only returns 0 or a
negative error code, causing ALSA to not generate any change events.

return the value of snd_soc_component_update_bits() directly, as it has
the capability of return check status of changed or not.

Also enable pm runtime before calling the function
snd_soc_component_update_bits() to make the regmap cache data align with
the value in hardware.

Fixes: 29dbfeecab85 ("ASoC: fsl_micfil: Add Hardware Voice Activity Detector support")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_micfil.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 0cfdd6343291..983805bbaae2 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -351,6 +351,10 @@ static int micfil_put_dc_remover_state(struct snd_kcontrol *kcontrol,
 	if (val < 0 || val > 3)
 		return -EINVAL;
 
+	ret = pm_runtime_resume_and_get(comp->dev);
+	if (ret)
+		return ret;
+
 	micfil->dc_remover = val;
 
 	/* Calculate total value for all channels */
@@ -360,10 +364,10 @@ static int micfil_put_dc_remover_state(struct snd_kcontrol *kcontrol,
 	/* Update DC Remover mode for all channels */
 	ret = snd_soc_component_update_bits(comp, REG_MICFIL_DC_CTRL,
 					    MICFIL_DC_CTRL_CONFIG, reg_val);
-	if (ret < 0)
-		return ret;
 
-	return 0;
+	pm_runtime_put_autosuspend(comp->dev);
+
+	return ret;
 }
 
 static int micfil_get_dc_remover_state(struct snd_kcontrol *kcontrol,
-- 
2.34.1


