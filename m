Return-Path: <linuxppc-dev+bounces-19132-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C142D35163
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 09:41:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fm0P96SzBz2yrl;
	Wed, 01 Apr 2026 20:41:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775036493;
	cv=pass; b=TvAe8SzJx56Un1B13RisNSgQLVOBZNuvOBxIH/5OeJc+Qh0DpNsGC5Rj7mm2+39+sV7hNzlyQRFRY1meQ5et6hWc1yZBNVcFbRPFTY6t3eAu1R/tVJwUFCT5s7xxUTR4IhTjBfPYB4BGSLLSPxKBhfxDiWnLn6RryRGtQYcqC5bGY6/Dh3hpHtGRqVy5UzLZaReWElGkvhPUirWu77vmnCmAUwoy6HEv2k/ViAwn1U495ep8Xyusx7hsiQTCrmx75Hp8Enf2PcU+g+oB2mSroZVWEuj/zN9RanxAmoSh24hTgGvGLaLWONHlcVk1uHx/rRoapKRAOjhZhUwK+NLbdQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775036493; c=relaxed/relaxed;
	bh=FmrTItx47rJ0HdJvNf6wHuSfObpE19m86nMqe1jrQsE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B2im76czwqLj7f5Zz/Q75DueG8nOjpeWApDzFcJhxJwQnRWmSMW8dSPiC4rwSTmI23G6l3VRm8+oM2gajxcDUYDFiaIKoOsW8dngkmztefVFnYJ2JaBI25ST+26ad98mmC+XL/7+sQnTRGSSMixrd+nR1LV0RAhy9VMpXfwu+1avc6Y+RYwPx5YpN5ekYtfY6dTIZUELHaohLvdESj1kWQIE/QfdRzvoaZH8hPzDKTusx0+VALC3H4WcGI/mZAKzxnUQr6QkI9207KnWUalvGPubNmaxwh3RY5K2ZTpU3jPjNb7tLaeM9idpN84a0iihF/sCvrqtYTaDuppEGABD4A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=lF3c3hC2; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=lF3c3hC2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fm0P90TShz2yrK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 20:41:33 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UX/s4rddaoJ54+QbvPT7PCe7eoALg1u6BG0OSNthbis4wrkkQCbtYgahjutZFmmENUPfoV8gKahPaWaANvt8rypByDwC/IHqDDMAuJ6vMU4Xi2de6zSXJdWQqN6BZLf6MQJrwTCL0nPRmJQNX7128fBUihITUdFhD0oUCnAUYoc7by0xliWzFgjlLz8t19U452quLESS94/ss9kBDey8Co3+QspJ5+F2dBz2aa+VOgX4MNrSAx4LCfcIvmoEjEz/GfcJzIqsjiultNewGDL2idOU0UbIz7vaxFNFCJmZ7R/ZkzzF2CZh9g0y4N9dyZDQJgVVDpjEYIglirTl0fDovA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmrTItx47rJ0HdJvNf6wHuSfObpE19m86nMqe1jrQsE=;
 b=Gd4RoVWvRddfc5qpbEnmpIpQTau6u51+NEMhrHaEGaEf/xWj2kmZ2xw2jn5FJKBWUqgo1TZ30zkmvApie8jc/oREwMq5lh7rCdC/BwAdjtc5R8/TAj2kTt4D8DuYRGchtDOnoh9OOLrSjgxpcvEwY/whNk/6jMzGD0U4GHJGbdX7S8qu70UzZ0/h6JBLN1Qlk4A0Q3CMaQB3hqZNbTnG7nXfHcK1EfRUXQSGhlTmPf82fxoZnUA02jej/9pBfg3VfHIdwr1Qtdv8jaeCfga5M2PB5HCGtaYFOP/C7jfht0IVi0CnRkSpe6y6f/uwQZAkcKXsgxIbbP1pO9cz58kSDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmrTItx47rJ0HdJvNf6wHuSfObpE19m86nMqe1jrQsE=;
 b=lF3c3hC2/S1L8g6OtulJrxqVB50mCfmcCFTtssQLAvC06RFbYi1OwHRZGHkevuMN9l/TLKgRj6EUjGyshZLC54XKxcvsZ4QvTA9mdAv/L4Xi34Ro4k17uhA5Czpl46GSEmHfYjnGbB+AsTOHPe4G7kNlaKo3q7wDg0JhqswDMoTzIvBuEYRm292e2Lw7PPYvsST6pll3xQB7vB2D+Zf+k/3+U9CHlBRqqwonylI3RohjLUOssE42ghbgDARUWK49DQ4/7RygTL5+amNicbuGF5uGlhODehn+6PRHriYy14RtAs4gGRXGIrK+XmD7TfTI2lq3b868uzyMu0U79bW7kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by AM9PR04MB8241.eurprd04.prod.outlook.com (2603:10a6:20b:3e4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 09:41:18 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b%4]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 09:41:18 +0000
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
Subject: [PATCH v2 04/11] ASoC: fsl_micfil: Fix event generation in micfil_range_set()
Date: Wed,  1 Apr 2026 17:42:19 +0800
Message-Id: <20260401094226.2900532-5-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260401094226.2900532-1-shengjiu.wang@nxp.com>
References: <20260401094226.2900532-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To AM0PR04MB7044.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|AM9PR04MB8241:EE_
X-MS-Office365-Filtering-Correlation-Id: af69e423-6348-420a-c7f0-08de8fd2d32a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|19092799006|366016|1800799024|18002099003|56012099003|22082099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	F5f7GE1GOix02N8IW3pBJtcnIpS52Y3WP5A275el7WVRU9gm84bIT00ZLzMk2AOPiGLlHSXZfcsTfz/iCsdSFuCbCssu6For6VY6oTK1fAeKW1eBkhNzdAz+eHo9pwwjEXapR7Hh2XrZFEO/sOHpVG4O5CVDBFcovVhmfQCmarae5uP+PKDKkU+x05cxebmxihFlt7PYS+BDLO6VvZDpEr+fmZ0whX8SDEL73CcYAp1tGILA88ESPAz7MJ6lejXKXYrpS127v2dzeuRVmbK8b4oF2rcEf+qhDPPQ5SQaPKKmGTqPKCiIdhW6qTSziUEIpkxlRId0Gnwpal8Vzkho4bVHq+GTioFape7P1zQVoxhaTphlr9vDI7DyfgdOH4hWkw4USrv2eQomv79dKzFZUwEv3ZomOfaXQIETAVsPYWoY5d3xzFTozdC7uPHm5PIFNVH/KeGICnZX0I/aevUJVD/wcC9s1lAOrabJJgWp7LWCP5b5TBGa4JUOOBiNNr3id1Kfcm4zHF589xZpu127MNtGWmRpeW0abMWrAe+LzLc/j54U5x5hIgZHMcrxd0zc5tGG8uZHUFHGdjoYJOHyLG9xLRTe92CjbFhLLpFf0wrgXxyYmSK4vcM/AfDkytLUCoEG5OUX8tqNHHPJ1VldqBcBUs88796f2IVGvhcgGwBLjcqiJa4Fdn37XoIW55MsGkDpOo/tSavl63Cx5NnomMy/nl1AW3gcv5XP1RyekizuOg1qckGbaX0s0WJ9iRKTZe4wNhX1V6mGHLO5AGfUBhUgEpNMX7f6YIKD50yHvpZHA1/XqplepGJk8KVCgvgp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(19092799006)(366016)(1800799024)(18002099003)(56012099003)(22082099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gJ9BK06/4fOHrWGSUn5/HUOfUeZsF+oRSQkTag6M+UvLN3bV4kGBd5lPhC5I?=
 =?us-ascii?Q?dyy8nXnm/ipWEncwoR3vf7CGSp6SPrXbXCrSX9gtYnbd2G1SftEhtSjsadbz?=
 =?us-ascii?Q?X3IxV6JWzksYRhE67vzJZ8B9q3QTuKQ3SVjpGQbUJou8mFSem7cWhypgPP+C?=
 =?us-ascii?Q?3mwC5OJWR55qAbdoET2rhBv7+I7jg+WCDgM5TCytoYCUNC0HQR1BIBn5Q2ll?=
 =?us-ascii?Q?u5mE1ITnj1anQFhvoKmftgvXtrxCHmqdl2CT61aVhcaIJnpwV2/m03y+Pmbb?=
 =?us-ascii?Q?Wd6U+ulv+VF9d9zGbB+L5wCLMMTeBx/8GIEBXNwrZWbP1GZ0A6IYOIWFY3pb?=
 =?us-ascii?Q?i5g/wm/1rKf3LI+lrFiHll4WkwG5SXCujupSwgms6HlupS2dhDNDgeJc8rTs?=
 =?us-ascii?Q?QH//jyCqCjfCArd4wH68tbaGNZ7ra28Yw8cX3Pm7vygkQvofWoucpw4xjJyb?=
 =?us-ascii?Q?iE/AhX8i6AKjshQZZEZbRyVe90Bpo60LDruZTOl6pxG9UqhmppyoD1NTX6wu?=
 =?us-ascii?Q?tIWI8cH7z3OsKVHgcJB0AY0KP3r5lzICFtbID1dmtddEXwmFwJZuHo3fSTHa?=
 =?us-ascii?Q?Wijz5bm6zSpo1HpSbAZLIOD6mlnheP4Hv804pKjg9hG3i3kZk5Ec7KdtUzqe?=
 =?us-ascii?Q?1I1BY2nnBmuMM2sDFTI5m7HCILFLA295LQAQP64eGa86rufeepVMvqpcdLKa?=
 =?us-ascii?Q?h+DP+Tt4PFCl7/dxL+uCf6n5rydiurOPtvqLoiJRGU//OtxzZeSN87//E5Xd?=
 =?us-ascii?Q?8irqs3x43Nyhpgqkywfb7yGAbigi95WxaZBL6zYbbN4XSAkNvq+j8cVovSCk?=
 =?us-ascii?Q?2a4lha5+DM3BPMvuyDs+Owm2CsVF8gaBTsNMNac8ZndXFH79S7YEL9UCXBN7?=
 =?us-ascii?Q?Ppn0wtgjZqKWuGWt24Mje3/lqq5vgW/g3BNFpOuZFHJODRSIt6p4Euuvo49a?=
 =?us-ascii?Q?gt1NP5de1hhvuoJ0TKCLFQ42ZzMorAfdyI4IHeCnz/J1AKro/4rUIxINhdKn?=
 =?us-ascii?Q?Ud5nSZi3WPH0d965tH5gyWZ7p6ZkRvvfVBv3buZyW2NjeomCq9NUfbD6QkRn?=
 =?us-ascii?Q?D+KAOsMiCAIhmx/wKVxUv+QPQf8lKISeH+aA2kMTJPmb7ytmDOnOqhkyxr+Y?=
 =?us-ascii?Q?8d4dtV9bHNY7ar73xjLTv9WleofWolGwT+KMYpBiJmZzDcOeJQExUMFdMczM?=
 =?us-ascii?Q?iGRewCAgYe1ge8FwsWSUk/lhKU2X/eX31jnvkQYQmbqLcknEqM8DP3ed9BZV?=
 =?us-ascii?Q?wiVmyKOLl9Bbq+4TsbTmxvI72/VvvvtI21oi7dStNGH4Hfp3SO0/DKoTZEXe?=
 =?us-ascii?Q?6g0WSPPhMFq30rom2NBHaxPR7XkfuSah0rJWoRGA6on2TotlnLQiLH88lgSM?=
 =?us-ascii?Q?09q9zsa27XbE97nBSV9HRtQdbpKo3Pls/UwaUCXggxj3ILOm8i+mTMtotwCT?=
 =?us-ascii?Q?QRnILIwRtwy5GyMZzcYvzVn7rQq+WWIHjkfw67mX50kOIFNjDaifrAtpUB/V?=
 =?us-ascii?Q?5BEk9LNqMa3ekPoLQ51Ga2Fmr+MaWhuur0xAt7K+t055FtkcOlRf97tLU48A?=
 =?us-ascii?Q?nxzMQt9uVxxIWRs3lviPgsY1N/2ZgZ1AEGM7KM4akXhBUFgBiZy/o3GlW3VM?=
 =?us-ascii?Q?wX7E72U+s9gMxKg7TbBHN5tX0SOTp8xwSh3xAejjgU48enobkPoUUBJVp1vp?=
 =?us-ascii?Q?fWykB/NaffgU1zes4rwll3vZYO2AB795/FC6PbWrYGMLFBe6snE9lpZc3Gqk?=
 =?us-ascii?Q?vSjpPUmVoQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af69e423-6348-420a-c7f0-08de8fd2d32a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 09:41:18.3295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8HiAw0VRp8iK+4kp1ckSwSKG8/d6pb0bfTZGjxec8zqo0xx13mdwy7SQ2iynNCRPh4DNP6JvF7tpEcdhurXLNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8241

ALSA controls should return 1 if the value in the control changed but the
control put operation micfil_range_set() only returns 0 or a negative
error code, causing ALSA to not generate any change events.

Use snd_soc_component_update_bits() function to replace the
regmap_update_bits(), for snd_soc_component_update_bits() has the
capability of return check status.

Also enable pm runtime before calling the function
snd_soc_component_update_bits() to make the regmap cache data align with
the value in hardware.

Fixes: ef1a7e02fdb7 ("ASoC: fsl_micfil: Set channel range control")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_micfil.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 1c826e0cb1d5..0cfdd6343291 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -210,15 +210,23 @@ static int micfil_range_set(struct snd_kcontrol *kcontrol,
 		(struct soc_mixer_control *)kcontrol->private_value;
 	unsigned int shift = mc->shift;
 	int max_range, new_range;
+	int ret;
 
 	new_range = ucontrol->value.integer.value[0];
 	max_range = micfil_get_max_range(micfil);
 	if (new_range > max_range)
 		dev_warn(&micfil->pdev->dev, "range makes channel %d data unreliable\n", shift / 4);
 
-	regmap_update_bits(micfil->regmap, REG_MICFIL_OUT_CTRL, 0xF << shift, new_range << shift);
+	ret = pm_runtime_resume_and_get(cmpnt->dev);
+	if (ret)
+		return ret;
 
-	return 0;
+	ret = snd_soc_component_update_bits(cmpnt, REG_MICFIL_OUT_CTRL, 0xF << shift,
+					    new_range << shift);
+
+	pm_runtime_put_autosuspend(cmpnt->dev);
+
+	return ret;
 }
 
 static int micfil_set_quality(struct fsl_micfil *micfil)
-- 
2.34.1


