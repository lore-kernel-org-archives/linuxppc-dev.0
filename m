Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A54F606A337
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 11:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=eaKt2gw9
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKNgD4WZFz2xf8;
	Wed, 04 Nov 2026 22:36:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793792168;
	cv=pass; b=UY8ojlNVxnRPVfSqjJbMxP4gJ2rehSQjw9tOSzGEUxbf/zfptmf0nzlHjmWaBUQ/p3Icc3JYMVPlR/2BPTnrnPA+ZFo1yp6VASjMXwaAcKQ46lVacGYagxYT5n8EMs8LI8JenrZzPDTdpqIySq9OBkxVQwCjUyDzuI4Maen7hXxRdL6kN355/JLzQpyt5Le1tpoxxTgjobuxz+eeGm8uPutNanRF0YJ6J/IcAmQ3IPCudOy4RekBAbionwAoDcOWjKiQz3ee41WT6viQfsEAeoPwUudghXIPYZBRNPQpud2D62JtAXhQ4cIDoApfM4c1jvPq0HoIMDcyGNXjJb5Pyw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793792168; c=relaxed/relaxed;
	bh=l7DohzCIHf10qNuJDvDwIx1bpPJpGYgB2VxTVUnmOs8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FSKoZ9yuzYQmYg+ZV75Aia2kpWMhzmjZPMFEwfNRTvfg6Gcho0DHN0cpcpFoLXVZMcEifXywF5CAHGB8gNaOi6p1GNeSxdbSOT5YMIObPXi2dA9UoEAljW30yhSBfjYjNvO6Wa3PK2+r2wNKxyzGURUUYG5lY/UymJAzcRK+ekZXebYDuAtbfY5dR/2GleI+d2RsRJ2GVtMsirPIh6eD0xzkrSZtv03XJxLpMa1/P2t5ARTv02O+x4mXZzvUR9s9g2ZfEh4oqdZFdw+zJNnlPwgQpO4NVfbysttLfdIlhCIIV5+Y7o2v66eQG+1eN7vlvrNWExHHySYpietrt5ou9w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=eaKt2gw9; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=peng.fan@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=eaKt2gw9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=peng.fan@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKNgC2G1sz2x9N
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 22:36:06 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0jaMzwdaJDfXfKT9OD+ABz6j/yE8+msA0Mt+IAQXVFTDYDBfClQaelGd29cohoESpTrpTLBOUTFwaV8CXjHKyMFHhRwiH5SkShrWX3r1y6yEGfQwcmwwQqBy3Tm0YG7A/mWBh9t8pEr/EmJfVzZyQEsNn3l8belR91ztwpIqRQDXyD+/CHnzWIXg2OmUoSWwXZT2M4TNa9apGeRIKLYfXGqwXugc2Cxy2209j/oRAzUcFgbua89fCWBmf9UPQs8yGX3hIvdD87LGsdeQIAK5I1oGspd6+U/XZv2T5GY7YQ1ksx3m/FStAzP104rN0Q5hiAA6DiA1AOgvb1ykBezeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7DohzCIHf10qNuJDvDwIx1bpPJpGYgB2VxTVUnmOs8=;
 b=TynuzlpWgFr6wh+rDxbLh9jOdB2L6UXafDQ2B4671mVmTvQ7YmSrxuU+3TBXWx3aOr6+ZPS8v5n9+fIiVIh2PH8cJnhPk9VgmVQ8gzzk4g1SfSJ/U7PxVzYCpl17szw1BvemAZVMlpfoZ8bqwCauUg1oCABtcu+9OjIzwAUjQkljaWal7hWspC6hVmDLWCbOSTceg/SjWwoS0XCV59YeKTTInvgb4RSeX8YFbXj8ThOn7CGrYgUGZYYBf8/y2iiAvFVdoVRO3RjI3iH0PrgdTLcRh/tPPayWZaDNgJuf3SBVMHHE3bDuK4uyOz+AOf3CfPAj9SlwrGmbCfrCrutm6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7DohzCIHf10qNuJDvDwIx1bpPJpGYgB2VxTVUnmOs8=;
 b=eaKt2gw9/pZR3T4MbA27A2Uy0Xoo7fYTlPb1yBDoIHy6Upf7GKdLEcozfsyaFoTCPcjt2Gt1erGaKiQsbOVKeMEfP5x44m1m3641lZHMQIn9Yop5DZsvRp7E2ZXhYfWjrbOmgxd0oIUgfWmDh0bDPGZV6+Nb2Aq5I7tkXt+2cfF9nmbHzloCw+91sCFrNDrl4Kjhtnr6tK5dNkicMaUSBjIrxeyLcs/J5c6URmJXFW1xuaz8ggFRht3TlwP5TT4vtS0bsLNDCqvs0I4HXDG2NTeSAfAD6T3mTZxyKOkRq394I0CbYL6hOQnrISsg8lbgo9NigZUE5/34DOeF+53thg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by GV1PR04MB10331.eurprd04.prod.outlook.com (2603:10a6:150:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 11:35:47 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 11:35:47 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: imx-audmux: Convert to subsys_platform_driver()
Date: Wed,  4 Nov 2026 19:32:28 +0800
Message-ID: <20261104113228.1634005-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|GV1PR04MB10331:EE_
X-MS-Office365-Filtering-Correlation-Id: ef58942f-ee69-42d7-beb2-08df3a67c4d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|19092799006|921020|11063799006|56012099006|261021123027099003|261021121427099003|261009223027099003|261022075727099003|261102123227099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ASgcd4wBf666O+mzZ0qVfNehh3kVdO7hAAi2W5wVVVj/gfNdBkXKi03A1yv7znxfniAD18VxnPFX0uxgoIB9HKYBbQTD5s+fE/hCXadgGnm7X1TkY86YSvapbGilQxfedkV2WccYaTz+0oh5o6e4erbIDg17NLDbkyJ59zAeLqHvUY8pTlJy6kxKBAabghRdCnqHE3Bfx9GePFzK60Fi4XJlkQ+m7A3VmVh2r0CbxBtBjuoAKxWZ1uOMwEy71MHSOF/vfrbOduTAeJYqfbRNQta/gE1UCvwUmNL6iLoEbCzspJ7jVunXzf1aLfZx8gT0NLhAK5y8M0zXYGaTXgui9Bw0cBu5H15BfU78p8OTDKXe76O4MmS8UYFDRsjVu8kvi0l51Pu91XAkARS4GtRIitrZwTpxJRuUiL9lBZifcwbIQkBeuTtF2fFy131OpiM/PcqjG7K9Vr4N2zG2gtCuKqPe9Cf0mOxHI8/E8T23d0uMK14g574KKKg5XQQUP97KJakmptrRGZu0vYtEvRMGCVmIKBRceqqr/o6q+PEtGzWE3wdm9GkavBoWKrrPIq8lEQmGs1Tf1KYA/lrBGDWEP1RQVUOPbEp6QbWKZSdLejmvUDgYUO1nGO/aJOjs2jt6RCaNegZfRkBVm3uVR1w5V9WZXylwi5cFDnt0nLo1tjFAPA/ZUD4uGa6oQu70xoVqFuUfho3s2e3Z/bVv5zvFqw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(19092799006)(921020)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261022075727099003)(261102123227099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e6xQbK3MeLdzYCvaq3p6HAW+QXwU+m1qTv1mkOBH5/OCvp4ecoW8JjGGbD/s?=
 =?us-ascii?Q?a2ZX4dPGrczSRuW8yiMf6KTuUk3dPYRZ8pl/hfkptuSlE3vlJ58H6kSHXCHX?=
 =?us-ascii?Q?nBzX6CJMzmMtu+1jVvRCX/EfYQglyIADBtuYIzkKB2hkiLiSPqhy+Sq+07XS?=
 =?us-ascii?Q?ODvKsi4YR2LsWKgg2DnDjsjZ0eup3OQOXi0VvS/pX1ZsnTyxpeM5gu6M2PFF?=
 =?us-ascii?Q?t5hrV7IcK9fO4/A1Oabn6PqPtjdw+0eMDU4zPYcZA6Dla03FP2PeqesUI6gt?=
 =?us-ascii?Q?aVJ5j2EDFvoj0zkEXQgOCbMj8Xyf0CeQSmhuKYAu2xTifDu5yzmpgaLWJLa5?=
 =?us-ascii?Q?dk9HRVXNoBNTmhIaXSKQYXtA4/SlIdNRMARH/ASqPmNBBwwmxVtQQYFBRNG3?=
 =?us-ascii?Q?Uk1MoY51W8tUOFVR4GvR168us46nCz2VpdYwqfT9p1XKLcbE/xjdhfdd9E2P?=
 =?us-ascii?Q?S3mO3nsO16pwJfHUK39mI/pwbHYerg5qG6guMGfZLUdd5PsKmdqn1TvRez65?=
 =?us-ascii?Q?fojl/cUMQExUZE/yohGIrdBX9CeAC1/otIC4msN/D8vqGYFUqfSJcs4xpMQ+?=
 =?us-ascii?Q?JD8BRoIQ5R+rzidyPsHI53hVtGywHXtwu/UGLcZGzRh+C1kLQ47Qj3dUQVrL?=
 =?us-ascii?Q?8d8empQxYzh4VCG7FhNf52FWqP+W4wDUjz3czOJn6JQ9m4hh3LHtNdkwV46i?=
 =?us-ascii?Q?XYvFXzdt7/fw1HCIBrD99bL4estB75jemGa6iXyRHHQF3ZzVasfNFpsLNKmD?=
 =?us-ascii?Q?sqLI6uLCkOfVLaCAPVIzL1TV56kBHZkYtxoq2GiiPoLVKyKVliAe1EqIBIB3?=
 =?us-ascii?Q?CZuRqSoZSWEmTg3eRCaXJa5P59fJ06AOJqDwbDtJJoByw2+HTCyenKKVqWOQ?=
 =?us-ascii?Q?TUD08N3ND6bhf9+qz/Ky3m+joL9HY64MAGVOFDXrx3xM9fMLZ1kO0SyOboaE?=
 =?us-ascii?Q?XgwTashCHvjikm83WfCU9/tGEkkYVZeDyEe6toADhfB61FoRyx/HDcm+Legv?=
 =?us-ascii?Q?mfCWxV0WZYlxgik5V9Qcp1JM1CYFSa29pnETfyLjy2hVHaqywPwSneNEzy6C?=
 =?us-ascii?Q?Ns/vzF34Yx7jNvUlfdY+CpBs1HtArB00NaHIatcGZWumqHjN+VWUtr59FVh1?=
 =?us-ascii?Q?C3hckbHQ4nEzd8Fs5AgkPkS4h2dvOlfXW7MYh0y7Bx2CEkGMkDhmudlqd/g+?=
 =?us-ascii?Q?CWMleIfIjk4pTws4ffWSaOO9zPMRQ8QFl1RASjbePy4SVHLvD/UA9Yl1UB9x?=
 =?us-ascii?Q?svoPoaMNgsR79I0qLtjAMWanrEdkWjGEatDet9LYTmvwlsULeJAPQtqEOW2T?=
 =?us-ascii?Q?he7Q5cnNhM7eFAO2mHvgDHDs4qMt7GA5uayPYeIQcoWLTY9+JdRfOB6TNWlz?=
 =?us-ascii?Q?vo8z+MjU4oJfWs4DgIm1pWqG6fHZYtAuNhRU1hvKHfgkilLLbOKvYBdb6iOy?=
 =?us-ascii?Q?GNMLTS+gb1UmKFIgHXcMFhkNi/4BZM0afeq/j3cBv1jROetcmrVhbr357HZq?=
 =?us-ascii?Q?3RuXRzfkarpnNQjl3xvosv1tPqL69JDcrNw676jq1I0j6kLwbn280LXLfclS?=
 =?us-ascii?Q?U0xWMpkLROxmsETlrlDrZ5LJwZ5qT+SEuSciiDTo3OK/c9nbWlSFfT+DsJMT?=
 =?us-ascii?Q?8hE07176+UwSwCig5j0/9BHORE7n/5iarIdiTEiO833J6NF5u6XOIKKNpzJ1?=
 =?us-ascii?Q?Yr7q4Z7Ql4Rdxf2CzXI7EsY8QXlnw9Hrf/zH/vV+m5kL52Y0SGkfLCUEeb+g?=
 =?us-ascii?Q?eZIntUQ116FlBXQTPORh6ED+nVLex0BhFAhn/3oZXUxandmASDLH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef58942f-ee69-42d7-beb2-08df3a67c4d9
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 11:35:47.0670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KLnsZ4kgmz6Yle4spaJ5c9StxwZUPS+GYHMdRsFYnZEdx2itoyEkE3bACUgQZClaVAJGHwpHlb4UhM87kcfAk6NURx+3TLzZSMhN152c88fDksQjj/xF/nwE/T7jYf8T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10331
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peng Fan <peng.fan@nxp.com>

Replace the open-coded subsys_initcall()/module_exit() platform driver
registration with subsys_platform_driver().

No functional change.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 sound/soc/fsl/imx-audmux.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index f8335a04595a..d46f43ab66cf 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -361,18 +361,7 @@ static struct platform_driver imx_audmux_driver = {
 		.of_match_table = imx_audmux_dt_ids,
 	}
 };
-
-static int __init imx_audmux_init(void)
-{
-	return platform_driver_register(&imx_audmux_driver);
-}
-subsys_initcall(imx_audmux_init);
-
-static void __exit imx_audmux_exit(void)
-{
-	platform_driver_unregister(&imx_audmux_driver);
-}
-module_exit(imx_audmux_exit);
+subsys_platform_driver(imx_audmux_driver);
 
 MODULE_DESCRIPTION("Freescale i.MX AUDMUX driver");
 MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
-- 
2.51.0


