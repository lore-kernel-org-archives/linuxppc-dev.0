Return-Path: <linuxppc-dev+bounces-19014-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C2D10D14A4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 11:25:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkpnk1ZLgz2yF1;
	Mon, 30 Mar 2026 22:25:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774869914;
	cv=pass; b=leCbC+ieTm19LMwI97hPmV9azdcGZHTuM5UigD1bXCphUN/x6mAqYzlGjQwfi4ahzvU4UQzKtsKWa6gAUBW9nl06C9EUgOxaqGjoA7UVl2lKId56kxW0mz1z9GyuwUvdZlEquFNTOZaN8UoHlFlTEzKWV9Ywh0VEAnnltH62x6XWpymq8uzTUd6jM+r+ECtjTfQt1krO7jkZ4irHIWo0QUTAvesmzWPuMfo4MZJiO+JCmrdt2wo/PDoMTTHH740R6oBiwexPprmznU8swBonmOzCA/MqS5yUM7cBdwucmG5G6iEXshQRgcjeIzxW5L65e06PNu6/5OcJz1vzHoIRcw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774869914; c=relaxed/relaxed;
	bh=iYtWKN468AYcmwQsYSWAgH/Fo9OGSrF0j8fEL5WYu3g=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N2ZAj4Q/ciiYbL8jEjXWlUOjV/SzDVrUI/ANxISjJrAbVixMgOPXDpJ5Sj0micPLjUi+Fa2MJaHLrc/VZkaLqw3BQjgDNBWgqDKOXcCqa+rq9atsVdz9CMCsyBj4+fq4jAxSYbQ5jLEG5/DxE//DvFfn4lO1Yd0l+DOuO0ejhkwGwGcJuYG/tFuVs/XG+yWO+ezjs4BLoKnyugW0NyajymmUQfog0JdBf0RxFfmQGyiPJR6rY8A/sg+tOJrQEExXWFRGEBNGHjeXeibBBueNHN8L2tsNSug/r2OqpQI9fDqKlgU2JikS8vYv6PIDjboEHUe7GliRvvrJQ22SZ2WZCg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=n3hh0YEZ; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=n3hh0YEZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkpnj37wCz2xpt
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 22:25:13 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wpS3CO/BAX2lOc6HorIE/vWm+F/q9mCpzO+n8Vq3wXtHJ0/etjgsNcz5X2WJC1bk48AbPrkpXX7xh+gAj9sFnfIkOtXBPmHjvWA8k+AEqoQJR5rfPsU7ch5TcRGEyerskxrQ2RJLgFIpQEqHD48a6wO6NQpn0BP9CyDYDSjpV+fHjFJ5DB9vWWKWVB60MCd3Hjl+t+c1LHiwwLy9+B6sQw7ui5Lu6NKeoRs1GF7196vHGEpNdQYEXUflel7U7DViUNiEL9WL/js7q+bVgt0hHj1D0+gGrE+hzDKNpiruPzVG93kcgpv2G4V4pmH/QulpVV8VIbrzgHAgBsFIw5h1Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYtWKN468AYcmwQsYSWAgH/Fo9OGSrF0j8fEL5WYu3g=;
 b=v6l/sXCiekej9uai6Ez/S0OmGa3pXAtYkhSmTjJwCw/GQOPptWI5laZa6nnti/Nnh4ypPy/KEeFZ88FiDDPv0Zjv3OG6tnzPB4hFvXmMpbdaG1tfU0t3nVPFQPI6aT5kauI6oOVY2MTnQLvNWa64EHBovmGb16nFF8n9/ibytQF+MuzHRdtQbhN+Ca94I7BbTvWQC/BfHSM4Pk8R2ZaoX9K8aTCYdyVtXb6zykNDYhTdwZjbsfENtjYTDqmDvehduxwfG8G79wBMo2g64TQPpwhOcZlBrXyd4oaFvngWKwLf6cNoBwR8j+uFQq6h6latvzg1MFvHT0wCxg7DwCTPpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYtWKN468AYcmwQsYSWAgH/Fo9OGSrF0j8fEL5WYu3g=;
 b=n3hh0YEZ4o9hul+NZ7ALq6BHw/LxSWruSjJ7kyl+VGPj7GooFdAJj7CwQOaI5fw6ayjER2LXJtn6KNJr0OxOHcZXWrNvScKRbmeddA7vYHrcMT52wS2+92MaX8Te75/HMp8GlWDtDpSf5y00drv02OyWJgO9EjT87HplvQTsZPfrsl/dn1HbUdua1ivY9Ejk9a4a3FuUx8ka5m+Cr75nN4XxJJTimXVb0nglCtWVCAiJEPhiKtyicDdYQUDTDDfRNDx36jaCW8n99u4NY6Xrms5T65P8uH3wDCibAnZJsmyQRS8mhryv2pJbVHMB8i23+6BTvhTgZDNhRB3+I+b/8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by PA1PR04MB11036.eurprd04.prod.outlook.com (2603:10a6:102:48b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 11:24:33 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b%4]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 11:24:33 +0000
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
Subject: [PATCH 01/11] ASoC: fsl_micfil: Add access property for "VAD Detected"
Date: Mon, 30 Mar 2026 19:25:45 +0800
Message-Id: <20260330112555.3637002-2-shengjiu.wang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 06150b00-3bc0-4632-ee14-08de8e4eeaaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|7416014|52116014|376014|366016|56012099003|22082099003|18002099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	995CB84K+mRh/KPmVJK7hIWlfNEUzq5hPPUNzV709Siz7Ca6KFguEmOJdyM7a+lH4zYHTtHEWtrmxcwUCQAc1rplMFPES0C/7eIm25SHRIZBBavg9c23dljtkXCFwfrX6wrI6nZv5yDXNFk6/Yn8Ww3qSNBYkPM1SvmrRR/U1OYtVghPowER8CqHfXp2Z9cNXJkxqLZS+MuZJrgdciNAn+pPRFabN96maQjmiBu6t2XJ75kyjwOTkrGVIzS2sTlBX0o9RkbVA2n9zyJ+arAMNH1dGQvEeP/VAfpQb1GjdT0yo7erNlvVBlmmJHFlhLfiDUepi64oIeP9H+w8jyM+rhtNtXVxMrxOUK6GyeIozj3sLK+o6fxEfS2v2II4pNt1FNOfw8EplfXF6RV2M9a742369uDjpRRcz/7f/bT7bOEiNvON5u79pObacMI2Wl4YVtkr/fmW62gKLSaaU5DVPRFip2MDJ5AUf0vvmtSMtOdSKn2H0MrdsATFbPBkdTs8nFuW7ePBhq5k8QPJ4ygZMC5JjlizFxWkcU3E/wY4criKTUtF0xRjNtkI8mXCzmb9O8Pls7Frzu1zaIdJlLYMuesqlzJ7JjBUGwEMpKk9Y4l7lQaLcc+GJvtEFGZ5grKODNpq0VUaJx7dWubmfdisG9PORjp/eOlAHeDgJAnQ31CmkE9awzckhmpZJB5eJOsrhivv1zeK1hw87+x55Ihdfqfnjib30bZv/IuBF8QFLjrzNFJIbXNQ2ij/B2dLkOpPsUThpa+6f02KCWKiV4B52lDqEbX69SvDvskFzdfzxSHyEKItlpyw6xn3A1KtUydS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(7416014)(52116014)(376014)(366016)(56012099003)(22082099003)(18002099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RyM32qIkSOxS6SldrwUmkHXVYBQFsNyt4Zq2nrHp+zLR+ODhzell+WxHCasP?=
 =?us-ascii?Q?gt3kvkmyffjm7HAu365R1arvXVGtYNIWBNwMb1pfVY/T3/y8vphgrRRKAoNg?=
 =?us-ascii?Q?YxJbw0QcivBQPmiheVUmzY8Gt8exgxnv5zPK6O46fxJCaj74hbBeFvmXu18r?=
 =?us-ascii?Q?FZod0dq3LjDahrOlWihPxg7nIGseuAA6QggoyUdXVLELMWSwL9FeC1+CLv4f?=
 =?us-ascii?Q?KhXUTT6W7MlhNkLGnieMknR6s9Rrx7TclyDgBR4hPJ+P/KRrhrdcF6sROFf1?=
 =?us-ascii?Q?8IJHav+vNFK9o+Hro8O8ffwQ3/2L9xmfyHevmnhqD/y/dy3hXPbSKFZnHIrT?=
 =?us-ascii?Q?CobFD+wXK9wruqHd3Rq2waLVjWUXlsXyHH9l+rPFYoOPoW87OD7sI73omS+W?=
 =?us-ascii?Q?OtqvCBlp48X2dzmRrnDA5PsUYp61m5JWn37ErmxdgWQX5bgdADC5lHcumxPb?=
 =?us-ascii?Q?PAU4IK6xh2zricHXcXRQ0yv96LRh3MdiLPg76TZJcQrLBwDqe+EvYcSeI/Dk?=
 =?us-ascii?Q?jkj85SoZ3GuucRMBsa6X8X305NScWXuuLs0WZbXk0WLDU+GYZT+dBfAaHYKj?=
 =?us-ascii?Q?QhmHTkMJdgJGsz+MfwzrkP1kpzZ2gXc/Yd50h7q31MHaiZ1wyWi8E8IdQznJ?=
 =?us-ascii?Q?4caio2LCTbbJRppaG0zuDN14EqBd3OaKkHa2MmPmrZ8cAt7Ah48Zls3RFxwy?=
 =?us-ascii?Q?2E77z/K0BF1hTn+kTICvHctEsuQhCzglu9k3wgyX91sh37U6Q/WTJt+6Lw03?=
 =?us-ascii?Q?BNnYhjxW8h+9Ix+AUohqXxmiWEHmyjEXyq1LdHNW0RR3YpbJpd+vWeCOGa7F?=
 =?us-ascii?Q?e54eVLhBeboI6n4iZ38GSBavuK2n2vId86tWSTwtq0mC9y2Hi49qg1Dn88eu?=
 =?us-ascii?Q?4nTbHpPHNqYdArObZQJW6nbOXxZpSTlmDSCPwdjl0p+yfyMmf0JoD5Umwt9f?=
 =?us-ascii?Q?fLw8wynEFIFlcr/FRq/rQhYIC9jjQzEEAiMOTnvWZxxe/6hh3ERKYhQ3/qtf?=
 =?us-ascii?Q?NzDV8jv9DWf2dA+cUK7oRAFJ2qsTMRFF+SjcMey6XeCw59Cx8G5cm/e8P1rX?=
 =?us-ascii?Q?7YYknNufqd2OhQtkREviH0+bi9LrP9DBNEXlwjMIW8mBYrlyMmbrYjj33qdd?=
 =?us-ascii?Q?cjv4/shz6A5XySL0HLAZ8LbI78r0Qxax2bjNuOipkIZMIQI7knRqfRMTfxCV?=
 =?us-ascii?Q?BenKITE5X1gHcri4r9vmgCqYLYrBhsV7+/xKX722npbtwJbze1OfV/Y5M708?=
 =?us-ascii?Q?6f7ut/ClG8eXljKSkdPzsBWQT4H8I6WodVSzElyqZeEqFb1Hl1bJqXGFc1c5?=
 =?us-ascii?Q?l0r5b10vf6EN9MiABF7yuNLw8qnWGjythm8hSDLJWuxfg7ozcwDqsPgVdTvK?=
 =?us-ascii?Q?81kn4BjEWAPMqAA0/Ll/Rt6fL0gBdS+3QtYggJna3fbE8OU8pIb3M5NJf5yM?=
 =?us-ascii?Q?FOSDwfvdv/f3uhHuKOfYy/S+JO770L/UPsNLfhkh+eoCImitUcOw/xis2o48?=
 =?us-ascii?Q?N8TUbjOjp3DNaKlS1J37sf446mowAQrLIZhfHl5wkxSf6y0nnMkwuS4V99IB?=
 =?us-ascii?Q?4xrleag9iWrCx9MZhz9z1KdV9r5OAfwHLSgU90rNYzfX1Ak7IhITf9DTOfz8?=
 =?us-ascii?Q?/CCGH92p/cyQ4MI3zYiE9fYpZEkqS47ByXlNsFSC0JljEZXjIngn6Umi4roV?=
 =?us-ascii?Q?8EZZJGVmO9xxjbEt7mfdE4SEzwltYA9KbRmuv5Lkjc77PPYErXNMqz9DwVII?=
 =?us-ascii?Q?Kf3Eheaqog=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06150b00-3bc0-4632-ee14-08de8e4eeaaa
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 11:24:33.2426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dKhuslLd30VJtouwKNlA+pIzQv8gOkhR0n+NL1sjo13GmrtOWDx2nkftnnkjyUdAbd5rh9jNNVKD0cqXTqqVrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11036

Add access property SNDRV_CTL_ELEM_ACCESS_READ for control "VAD
Detected", which doesn't support put operation, otherwise there will be
issue with mixer-test.

Fixes: 29dbfeecab85 ("ASoC: fsl_micfil: Add Hardware Voice Activity Detector support")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_micfil.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index d6cde2757c6d..79850211742c 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -503,7 +503,13 @@ static const struct snd_kcontrol_new fsl_micfil_snd_controls[] = {
 	SOC_SINGLE("HWVAD ZCD Adjustment", REG_MICFIL_VAD0_ZCD, 8, 15, 0),
 	SOC_SINGLE("HWVAD ZCD And Behavior Switch",
 		   REG_MICFIL_VAD0_ZCD, 4, 1, 0),
-	SOC_SINGLE_BOOL_EXT("VAD Detected", 0, hwvad_detected, NULL),
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.name = "VAD Detected",
+		.info = snd_soc_info_bool_ext,
+		.get = hwvad_detected,
+	},
 };
 
 static int fsl_micfil_use_verid(struct device *dev)
-- 
2.34.1


