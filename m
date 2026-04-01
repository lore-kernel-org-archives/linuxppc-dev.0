Return-Path: <linuxppc-dev+bounces-19135-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384DFD35164
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 09:42:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fm0PD73Kcz2yvr;
	Wed, 01 Apr 2026 20:41:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775036496;
	cv=pass; b=TnY5xgUgYWlRdgNEEtYKtSHFygaegYfBre6NSOEORfMxPOJRgIsHyHbZsgt8cv14BDUYEVZALhKfpDy70OTv1Rx8IJu3+5Kj+M3JfY942y4HkmutgQtZOXUBq+ADAE6YZfqOq4lVs72gT1GKYhI4J5I1YVkzIRkscPVDjX2eLtjXPOlFp+rWDKcUajqvx4+7EQzhXZ6va9Hnyy1HObpOiSA3+utz+QsKKjaKRDF9JkBsNj8gQy6Zq7YWqMfXZqq4/dy5AHypHthLIRVBGyuGi1mCcjCwxnAz4N1N/QrzRWMHZBoslAIvcB1aOfJCVdY1oC5pHgOLV2MQDUD/bqo7kQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775036496; c=relaxed/relaxed;
	bh=z1Ua7Y/Yo6TxbvyaRDoolgjhe+iyuzuyd94d3RcAmdw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=enhXZCOHTa7Cmcw+pxGncxiyTmpSxouIkwZ8G9wHGa9XaceIgORrNya5nIYs4M8GmjjR3QdigE7YJyxOBG51bFcOQVGA7I8AapVQ0ou90iL7o0ZoDGMy33EuusYaacGIx0PvOn8t7eepAwVWUG1aG55eEcKMKmvQOUdqylTrfxR6Y2pY5yZs6V72ypH+Bx2X0oxyCcJC1rkmf3O0dqZG39NuycO+yhSuklS+f65ACSwvPYrLHL59KLDwojeO2B/gltjGYavBK6DaTFpEnnlXyztLrCEjvGEeFSPQSsRhRlMLdWV+UFIQYheEp6qSJJjMmMZa+TITRl67vMXuikQidg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=atIPUcjL; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=atIPUcjL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fm0PD2LKKz2yvW
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 20:41:36 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UW1FTmftt6y/ctIW/vHkPLN3KplezD3PAK9lhF44KpTjArjFftMpssH7lrQIPStfWa0ijvOdN3uBzYhGBuHb76qUgZRa6CDNGw3PJ1/xP90ssNtXKtk0LxaU/YE78V2sOPdDtQqtrpUUMjWNeaQw2VLVTjhX8IdiXDpk2zkjWwoRaJGfmZ0Qie9WkEa7+Kj4iZ+tOhssXVqosmwBc4sudcsk7KlKqgcQ8yk8dFTWNy3L1QdHE34A1TZUAajcvkr7smBEsIIPdGs4vXfQfjJVfAmyrbr4W/AnSRvmShTb+EDdNU99anBvTUS5Kyfx6tRtFXXJ2X2HjHoXAOcEXE7rBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1Ua7Y/Yo6TxbvyaRDoolgjhe+iyuzuyd94d3RcAmdw=;
 b=js9/mv3zWp1iZhpkjJm7O4Kb0ma00bZSerMjR6WBh99h76wxaD9bBIoml6qMlSCLwFpcj5wrs17KchKkB9/kIb3uOgStN8FhMs0EpZ1r06JdPUEfJDs4YfrwpQbYVYztTHV/TsyYVrXsiayQMfn/nYwCWMNoU0C4vdAW3QnIk4UIee0u9zg+VC2oDhY16R8ujYQLnafhIafjxzTM/daiXSkeil2nglqxPMjwEhdDEqT4ObXReXurXiVJL6GFihyaoB9apjzMBuaxz/zX53ajxK/l5G04IRR/OXrsj2V7HOkcxuqRuLD3mDl2ZQLB40qC1P4BYKHTw3R5GblVb9CK1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1Ua7Y/Yo6TxbvyaRDoolgjhe+iyuzuyd94d3RcAmdw=;
 b=atIPUcjLRqESicYggX4KLxNBJZwigI6So/tI1+VSGJxKRz7/O78QxymMVoxDvTM4P3eBgX5Vr9Jdta3WeUcc/QoQDkDAzo1dao9pfqXqlosYmfGq4uQqa8knZ4VT3V35um+IFhJdjhBTzcGZA4aJVqct3JXiBprfCfC3fo4h4Yih0SHJbMcGomK6Ll2l3s2N36IeSHYDTPqP9Cbd1mGkbiE2oJfDaS1z4MIG7gxUsk5XcBgLsFoDb/Axb+Gp5bSai6C78Q5dRL1dKiLnefn3T6mo88d9Y6wcUZKTZQLF+Fb9ubpMx52ei0JWPklmQlbSK7qQ0lDlpDODH4kCTcRwSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by AM9PR04MB8241.eurprd04.prod.outlook.com (2603:10a6:20b:3e4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 09:41:35 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b%4]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 09:41:35 +0000
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
Subject: [PATCH v2 08/11] ASoC: fsl_xcvr: Fix event generation in fsl_xcvr_mode_put()
Date: Wed,  1 Apr 2026 17:42:23 +0800
Message-Id: <20260401094226.2900532-9-shengjiu.wang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 50526bc8-363f-4759-658b-08de8fd2dd19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|19092799006|366016|1800799024|18002099003|56012099003|22082099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	QFjjVopwy5XmuMClGhkD9gfyvYr+SKHFR9dSBGULLzwJu762Eth0ZbUTlhpHoDQM3kQD1C6KZfAxwvPpWfiUpo51adcBKBV+tN3B9IYGwkZVe3AXdb0PvS/t0K5rChCrj7K5aY8DwQpFAcO5e6tDjyGo2k6o7au6atZdV5zDnwRt+lFEm9RcGHQ414zC5uMy5aJL2SAj3Ycn4jaWlIOCnWeI5EnqJPLucdjST6X4GQ3pt2lSwOBrN+siBYOMvm4Wk2FsV8tO+9TAvx8CgGw8incu2aWTgJudJEl3j/+BlXT4kc08HcMJxiC+0newBLttnazQnW31BbkXKgjd/vH6dQ8gUulremviO6umVF3nOmK0CfriuzaBbLjGMgXLdoZ5CNkltwZgoIURXLxvvlY1/R/Cs1+G3TKWAxJCs/BMY40NN9u9ghtJVNdKoIFlj9/P2dVkFNXl/WqevGXGH05JU9Akzk+iuQJX8WD5Hg2Yv4Z1re+Hac5dW6V8WMxKg7Z/kVrBXt2WwXdJztCEgl0LVflli9e27JI+H/h7qqvrG8r/4t72cgRYyd9D+0cOV1oZ8m0Grtut3PKTC5fkQywEHvdIAKO/V/TBIlFcnXEO9Umg+32mv5YIV07Fob5Xyzx6AhP1SauIv4B+8jhyUm9ax4yHNhnDsGMc592AQrUESMbfIf7//HjfN7/Eado3ZY256Ni0SHbkMvjfRQpO7O+MfxppQ4OGbTuM4pde7j4L+fscvdavwoN6sZktwiVthjLKGkJabgbHceUcUWreuQlV5Ldsi5MykLYRIGucNStqPH3mAGCWHKJeKYCBd+hoDPvf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(19092799006)(366016)(1800799024)(18002099003)(56012099003)(22082099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5rWd+zPma3CX9fU0ncjLupWzjE9QIgmbMFIoYe1UlAGn6ZoPagqTseMk4GXI?=
 =?us-ascii?Q?3fSRhJHN2yl3bt9Nuskt8qQEfsnIKuQouApdsQqHNgd7d3IDw3QtYxBk+Ire?=
 =?us-ascii?Q?K1m2BFMPY+rfq3h67tfmgXlBv9Pk8TwqTcZPkH/DXFKnIB1gGGF9es77xRYY?=
 =?us-ascii?Q?skiW65en+rg9alGOv1N83Mx06KDGIIlgPEkOIDzi0QyKzAGsEUyNZDG6lStg?=
 =?us-ascii?Q?L4CWURYQOqIyZO/CcB3+92qLJ/QFQMAAljvefFhdmuQaX9W/OBpD3JMNyB2A?=
 =?us-ascii?Q?fvfJFLpK/e1a8J12ftWGYM+dZVdb7pMwfpamwX7RYkDZ1DYvuwGFB1U9bh0w?=
 =?us-ascii?Q?wCzPutpdAS3+rWdE7UE8HXZZlTJtjw/R4XdORK2aT5cGC3KqV06WuqSgJwrx?=
 =?us-ascii?Q?axQJI6zy3nCToxo9IqmefFkTkTxyqHS/987U79kowTrGRuYDTEpOJVKXH0Tl?=
 =?us-ascii?Q?pD8sWnMac0hlsG/lpwDuv9oui2tMWfD/AGBVqUCelnyX+BuotkE+NZ+wp7sn?=
 =?us-ascii?Q?dDNceZ8xgwHkg/WS0ygnA5OI89AXnkwXeC1erzfiKlk7brzYZNS4MO1khOU2?=
 =?us-ascii?Q?72Hn/oh1Gyx8FRHtysYZ6CO9fkOGUyt+KQ3Z+/aRc2pjn/HSjlq84VqRF2U8?=
 =?us-ascii?Q?f5KL88qhZv/jx34nXXkQ1axuJYlPkeP38Uv/q/t86S7m+3aSAJLbMPzZClbl?=
 =?us-ascii?Q?1XS3fk+PUMqI2ErPQD39LMXIozmUklGxh5GMX1tzDG8j/Ic9Q+jtkcmGPy1S?=
 =?us-ascii?Q?+HejcxGqS/mtlAtFLIGWc7NbTd3JbGYbfkhcAhLzDtfciPQv8WbO4168p13I?=
 =?us-ascii?Q?+JTIBmd7Djl2zSk6EQyvIaP1ZJ9v3QyqQuI53o+Ar0VL7yBxxRglh3GIAu7B?=
 =?us-ascii?Q?0/t72yx9FiYh70Lnu1EYXSwykY77S/ABiSQRHqz0S0kgtsCVdAdv7WRRlW0n?=
 =?us-ascii?Q?WF0HmFDNgqbpinOWam0YBixrUmJCn+9b87+7a2js821iT6o5kXND5NWSrF1Y?=
 =?us-ascii?Q?E3gM9E+l7ML7FfQ6yjbzvR1ZsUX5Wck3PDeVwUHF8CQzuHCkATk5lWS+rZ99?=
 =?us-ascii?Q?Wiedgq5XGMhT3jI5hsmRDG9xt281yB3QLUwDXfTOIcUQs3JXb74L8333gtlD?=
 =?us-ascii?Q?mlE/tqLr+Edh9JJJu7LJbUMBxC13HHUx/CsRtPdx6/4h5r+8rgHYxWIUQ/I0?=
 =?us-ascii?Q?tUI42d2vBrbkVBLhJYl99aYH5PqvfqOBUNdpL0SicMFdLGYnG2l8IuFFjXNh?=
 =?us-ascii?Q?t/izutZzsB+aOSvsHCChPKqEFEGjzDfi9zRMh/rxSOOcm9Pn0XiXQR2HXpW8?=
 =?us-ascii?Q?hDwDIXQps4EHFavtFPrN+DA/t1KnunsQxY5LFKfQ0pbFQdvdDIUp1LfAyJuR?=
 =?us-ascii?Q?8COJ+hoWHFarepze/ZHRZ8lgkOLIx6q5wyj6OdOseg1THheSL5XI5sV/BFJ9?=
 =?us-ascii?Q?gUfhOROr/4Fv1nADV3yUc8Ko65bXsOtc91qLb2u4PECkghN8brZEFdgvikd8?=
 =?us-ascii?Q?1/kcxc4rrzKpmudMn2tJJScU7HKWrOXLMf7TW5k01ZbUocg/k8z4S0K2Z5Ts?=
 =?us-ascii?Q?Dx81nSouqaWA5HjY72MPSXewLG36DPSN5mV3r3K8qxHFM16UyOBcuDKRPJgA?=
 =?us-ascii?Q?ANyFYPlDm37zpNG6W48OZ3tP3rFPHRQtwIgOyS+wstHKG83aHSsSDQ0/Ic0z?=
 =?us-ascii?Q?hXXpQTMUB4tV2OjxDlMxm5apazTVojIJi22HSiZGTsMU7O3SZk+ajcMdR/S7?=
 =?us-ascii?Q?cyVsjZywvw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50526bc8-363f-4759-658b-08de8fd2dd19
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 09:41:34.9738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7PzpRsEzo1hlM/DifBaQvb9VrEydLyOnQZWwTjoNzndnBTatgxF0pd/WjLyJi1nJDqjocVpfmADzLb/MHCsSrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8241

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


