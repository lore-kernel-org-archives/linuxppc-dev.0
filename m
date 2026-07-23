Return-Path: <linuxppc-dev+bounces-24705-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED864C4453D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 02:20:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5FFS2Clfz2ykc;
	Thu, 23 Jul 2026 12:19:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784773196;
	cv=pass; b=BSCcPn/xBZfPNnsWs7tu+k0X2ifDkSKMaBiE0+DBdMU1apFEQNCLndo0auVq3V7dpPhaiyfgcUr6Ece/0beLeBHaDXANTV9iRXZBO5vG9JGSsB8HHyYnoFPT1F5fFus/yJw8FbNnyXp4FI3sdc9i1WAUsLKButhT3CFnjDKwhIYz5LYxMIb81LDHvn5jw7C+VE71U0RGu9h0BEAguOZUMU2uGeE89On9MdFAKtETmw6vmGMAEgk9wK/goR8oDlZgoh2TNBzrye6PG9P0rCi48nvIEedVT/NLCQr7UZviNQkAnsQ99kp1G5aQlKolIkclpyfpY539HcTDku+olwg0pQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784773196; c=relaxed/relaxed;
	bh=gmMJi99JFX7mEi8VLEMcVPjrqji9FJUb1DFUKo4RIXw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cenFXdF7jS/VsrTAVXZIWyqMQTBaiiYRCwe2l2FJtcHzS8XU5rOBU/n3Xm1ZJ1LVpEfy5/MpfT1WS2rwI3OIMjifA2VM+YpzK/MFSVkeNi25X36pmEiTunhLceE0ib/aOOaxHe8QQv5kIPMbS0W+DjcWCYdKUQI47DKbL9IW/yp50tuLnMDB7nnCxA7Dg6/KCEyOVVymfGObuxjkpvQS9BlY9IWplGEWCkdTNf9j9FzTFGAxLr/8NLcD1Zbkda7xC3UUNqXgLIX7FvfNwM4d9aj1NWnVi76GE4YDy9xZUNlLhuu8cvVq4MKBs5D7jM5s4UkMlHvquKV4nJixs0IuRg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=MupXsH6B; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=MupXsH6B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5FFR2SDXz2ynZ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 12:19:55 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fAuYQCf/0rv6hxRf9cKYceBBzdllhzQyB7FvL2XxzkpbxLCeTQ1RLiEUkOebQ5wmZuUSq5DhO1kH1HA1ztv7yJRkGtDE7yBAntrxZ4zsrzu+h9FfCU9JOpXWXaAD00Mul4Gge+3qUroghtcbEm9VMWLxqGEmvyu/R3ScANl61SgCwbEWojqXDRuZfGY/YOL86YcreAcV/zhXWz+ZMFINuUqZnEDV1Zr/Yqlozx0Chg1gEtQtTu05xPwFyjikzBFPRew1hzPv5dN6Bmxcnuow5lQEpgRiv0pBb50ydV6fKxxc378tC7H0j6la90X5mBG2ijFoQCTbNv5T7B0cDr2m9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmMJi99JFX7mEi8VLEMcVPjrqji9FJUb1DFUKo4RIXw=;
 b=RpYdGUEYm+I0TyzsEv1IlBzUxkPG3S0VXTDzjfyaLsMR8BftKBKgVAqZPzEKe4DdUoIIsH6jvB0ppGwORrK1NeIkrRrKZTfKT4JSstVhmlN0iMLGqGVA5jqggDBfMfWuF15yWrcrhW+NDXH96k76gCgaAWRYKnqLNsxA3Otnq63vOks1uk8bpaPo3bBGzuFra51txtIn0pLzjWogMJdi6dnLuGIZMbMpyufzuE41+T0svnnLlePdmiuKeBRE38QftlU5N14NF+2Q6I0UQ38LOwZYEYM1tNN3giAZ05lxjTrNg6I2GmJHSmAyErjnIMkZ5L4GjRIN2rRF9noX65rYBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmMJi99JFX7mEi8VLEMcVPjrqji9FJUb1DFUKo4RIXw=;
 b=MupXsH6BN62q60gadK7hBqu2Ije3OjXOmMhYd2HE7rlmH/7dhOBexFScDx+MN92wBmypCPZyTSDh/0Qdsp+cOGH/qs3Vhy8uALs3LkcO4QMKYHsP+imYKrR9o6p0z5JPuMVOHkZuvsEC10OFDXZoi2LSU2+nNs7Rwe5AQD+BdzLTapr4CL34BlwYhFS+QC/USTnnbYRDzYO05ZavDCk+lDJ3cPWp2B6My+sh95g3HgKB1DFfiBI1PHPF24eQjN29QFseOEO1VS1eodsAHrAOz3s2HuEYHXK1X4dAwXCqA/Oe+v3tx4Lxbxq8/MEPRVjURdRBzsvN7tlW7wkrW5n5Rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by DU0PR04MB9252.eurprd04.prod.outlook.com (2603:10a6:10:353::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 02:19:48 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 02:19:48 +0000
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
Subject: [PATCH v2 4/5] ASoC: fsl_asrc: expose individual DAIs per conversion path
Date: Thu, 23 Jul 2026 10:23:12 +0800
Message-Id: <20260723022313.1905051-5-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723022313.1905051-1-shengjiu.wang@oss.nxp.com>
References: <20260723022313.1905051-1-shengjiu.wang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU0P306CA0100.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:22::7) To PAXPR04MB9351.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9351:EE_|DU0PR04MB9252:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b0161e5-f340-4c08-241a-08dee860de88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|19092799006|1800799024|366016|921020|6133799003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	SxTrrXVZ/5K7f3yG4im5sWroupOj/mzxXQpC9yCVRK/FIBxzDGf8za+N409uzjP1khUKeHNV/+FfTjulxJNu82IwOa0k/gNEL7b4JMUmqIYdnV1QLnnK9iam0uCP/dT1V7HzI0fVed09QDAzB1m2qrO2m9XvPAzvoDW71otVOxygGX5gBtgyaxtx4fabz1zi86QMCzWErHKwbYtwb6YDfvl2s6PijN0a9/4fgcYoczBfCwoHfHZtQlAIc/4lPaaUxc43ySZJ2HZ2HjKtrsin6/Qwodbng4e9CL1kGkHYXi27nklzZ3FaXlxkiNZT8aeCMYp9/n5CELU1Hz7Rcgzl3tFd4n7t/9+8pKpeCYhfafkBsdICFqimbWV1sW9kDGqK/EkHYAz1ppI2ft9A4pTDjQZdivYRGVK9sL38cT6qlnQu5djVksV74Q5+gUD97Ygu2M6K2r8RBu8Sj/i3FlHhpZ/6Eohh90/kEvlvLZu2Ez956JEbp3pruIJSQzPpFV/ZEeKeA8PkgGzhsx3HvKytgTSRfT9vPRIa2pC0BaPPJUo/nbRuqZn4yuQM9SrCYWlg7JU5N1Ra/Ylny/oUtwNy/C9PVrN6NY9fIYb+ROUB1gnhnbXofVKHg+aHviDoXD0j7gBhjo6xSZeEb0yF9t57Fhvt/Rcw0r/bGM/+AKSQGdVBEyhtSqAI7KVB6rkHX2hfotfQbPzLdCyu3y0ZK78I9g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(19092799006)(1800799024)(366016)(921020)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HYzf1KaI9T90QxEoUg1NqRbjFS0Xstx9mlhNjXUSdtsMWAKt8v/v9kGip+Zm?=
 =?us-ascii?Q?gy4DE+wuEplfv1t7OpR0xeXjp84+3ViK65JWp6j6oM0N3380M4D8bXT+fsga?=
 =?us-ascii?Q?R34NnwHZ4kU/llM4WTu6UFcqr6kR1LSeoGflL0IYouEGNhXC7YVcS7zjfe9P?=
 =?us-ascii?Q?jC4Jvdn9YgTVDwlSmKsuBLrCwfHWf2iWiv0ZyCYe87rfu2BJ9bEyBEF9Vvlg?=
 =?us-ascii?Q?RWYhetQaZu1b/x9dBuJyjG0XaDk5YLeadNsjWtdALry0hbA4iMRr2KqF6KKU?=
 =?us-ascii?Q?ZeuXs/wiOhG6huNEhdlOrFA+5BzUJ8TSt6YrApQXggHz5yszhVHXvyMANg98?=
 =?us-ascii?Q?tVn2RgMAe0CsU5vYKnyjbKfNLREJJH8/fhnG5PZCWZRMMS2h9FrCWaH8Wj93?=
 =?us-ascii?Q?H35G7CNYAWRMUtJfiYcwyrJQUFLFFuuz5TGAUkNtAJnhp4mEMNoIe9PcvaLR?=
 =?us-ascii?Q?Hatcknm0eZHWwcv37MWOmZu2oBU0gc6d1nJxwmD7BPU889tFpz3V6+zy6gg5?=
 =?us-ascii?Q?T29BhQ1LgN61ZQND3M31MdjO2th3hHN3WJvZ/K8Jk84aH90/5qIdBhGUnQ4z?=
 =?us-ascii?Q?uVewcYZWF4r5vQj8jsObOcbBSsVifjAH+w2icdmJkbXlefZ5ZrIFOs0ojmHn?=
 =?us-ascii?Q?G/V7QE9WuIpM/oXOmoWiencfsznMI+rgbjzbtF4JXXtqI4+lxX/aa9DNx6R6?=
 =?us-ascii?Q?oExLCb4kReyVujWegfk9q1N0TffgPf07NrnJrHu+tmofHpL4llj6F08d/p8V?=
 =?us-ascii?Q?VeILriTsPjq0PLDgpx/gzmnXMIZ7rF0PfRoMzxc1k6wUfc3s6Pbe7a1uKtxg?=
 =?us-ascii?Q?Z/51nCaIbP86B6jq+Z0X/CJO4Fko7ky5sxbZnihofm1/t/85+cRidq2b0nO1?=
 =?us-ascii?Q?Wi7z+db2qa+8Syf5dvY07uwSEkxHe124Z7g8zsp7c5zShRZQPPqD1uX1B7g3?=
 =?us-ascii?Q?Xl2S4BLU9BEPbPCh5T+cM8ipV98fswvIfquN0r69BdHfzZ9ocos9ogBbH1RM?=
 =?us-ascii?Q?71a5Ad1Et4GLa06FyGL/U//8H+3jD67fJKKNwhlwZA5g+1po+mjTKvNSy/eU?=
 =?us-ascii?Q?/w/4/IsyHShq3iCOuOjpL8H0elqoQWjUl+F2MkQ64rN55q3nb/hJYC9HGb7l?=
 =?us-ascii?Q?kn5lcyNTDGFkTF49PAJvFYL2PtHlK2uj9pyTHIU/sVp2BFSZxQXqZMdzi1vZ?=
 =?us-ascii?Q?L2LrPWx1wN9i7d5/homGXCvEBbx5CwNEzycoKuN1nmq9RYL28kNl8rogRmS7?=
 =?us-ascii?Q?r2Im7xcFZwnOjohcFAtjs8agpLin10ax5ciHpZ265ueHorsXnGdepAYY6I8A?=
 =?us-ascii?Q?a3VgTFdTsL4JAnmAnaOsysFkDPh005cC2HZDvMlZ3w0gwNy80mb/1Y52Mhyf?=
 =?us-ascii?Q?2km+ZFE1LfF31Q3vnvklijSzS5m+/2laGlkI89A05GltrJ5S3l6rx2RHXOpg?=
 =?us-ascii?Q?IDCy/TLfNEaC6a3RmSP9CGDKZTpP2D154d2g4J9Xi2W5xgOMF+xAq5y2u7sc?=
 =?us-ascii?Q?hKumx0YALXIWUYHMKtfRNA9g8PC+/A0+lk/FSqly0/97GuxAFmV7WhKHm6e4?=
 =?us-ascii?Q?/P/E901dpVIHbdJ82JxHHIBSU/A28N7R3q5mnXuYkaK3BOv2zaJ1plmkxHbQ?=
 =?us-ascii?Q?pk92WYBpcjNQFrBTK30xlNZzv0vOMFLS+r5p93fa/VazyqLx2gibaTpWA8ci?=
 =?us-ascii?Q?ZdQ9hz38bFk9vk5ZS7+X86Kj74YAvT2kaJySRahJgHFSMqQk8E0I4OR5bPIb?=
 =?us-ascii?Q?ofEXq/ASNONrVKzRjeu8lMnVrj8hNOFotbkzIQMaQPaw1VHmEldo?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b0161e5-f340-4c08-241a-08dee860de88
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 02:19:48.2244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wD/W+4JwOJCDYKnyb+DgX5aQpAhoHJGV9otZfvghFsnUkTHmfwudFJoO2rqSQeuwz1DKZVhUnSCRfj+M+VpKxMHP6hIyVmy2qo/qR4wgL2sWXRyc37TGUB3EdBFrrIaO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9252

From: Shengjiu Wang <shengjiu.wang@nxp.com>

The i.MX ASRC hardware supports three independent conversion pairs
(A, B, C). The driver previously registered a single DAI with generic
stream names "ASRC-Playback" and "ASRC-Capture", which prevents
multiple independent conversion paths from being used simultaneously.

Replace the single fsl_asrc_dai instance with an array of three DAI
drivers to allow up to three independent conversion paths to be active
at the same time:

  asrc-0 -- ASRC-Playback / ASRC-Capture (backward compatible)
  asrc-1 -- ASRC1-Playback / ASRC1-Capture
  asrc-2 -- ASRC2-Playback / ASRC2-Capture

asrc-0 retains the original generic stream names to preserve backward
compatibility with existing machine drivers and board configurations.
Each DAI retains the same channel, rate and format capabilities as the
original. Update the devm_snd_soc_register_component() call to register
all three DAIs.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_asrc.c | 89 +++++++++++++++++++++++++++++++---------
 1 file changed, 69 insertions(+), 20 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 986a2e26819a..4cb24b8de462 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -792,27 +792,76 @@ static const struct snd_soc_dai_ops fsl_asrc_dai_ops = {
 				 SNDRV_PCM_FMTBIT_S16_LE | \
 				 SNDRV_PCM_FMTBIT_S24_3LE)
 
-static struct snd_soc_dai_driver fsl_asrc_dai = {
-	.playback = {
-		.stream_name = "ASRC-Playback",
-		.channels_min = 1,
-		.channels_max = 10,
-		.rate_min = 5512,
-		.rate_max = 192000,
-		.rates = SNDRV_PCM_RATE_KNOT,
-		.formats = FSL_ASRC_FORMATS |
-			   SNDRV_PCM_FMTBIT_S8,
+static struct snd_soc_dai_driver fsl_asrc_dai[] = {
+	{
+		.name = "asrc-0",
+		.playback = {
+			.stream_name = "ASRC-Playback",
+			.channels_min = 1,
+			.channels_max = 10,
+			.rate_min = 5512,
+			.rate_max = 192000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_ASRC_FORMATS |
+				   SNDRV_PCM_FMTBIT_S8,
+		},
+		.capture = {
+			.stream_name = "ASRC-Capture",
+			.channels_min = 1,
+			.channels_max = 10,
+			.rate_min = 5512,
+			.rate_max = 192000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_ASRC_FORMATS,
+		},
+		.ops = &fsl_asrc_dai_ops,
+	},
+	{
+		.name = "asrc-1",
+		.playback = {
+			.stream_name = "ASRC1-Playback",
+			.channels_min = 1,
+			.channels_max = 10,
+			.rate_min = 5512,
+			.rate_max = 192000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_ASRC_FORMATS |
+				   SNDRV_PCM_FMTBIT_S8,
+		},
+		.capture = {
+			.stream_name = "ASRC1-Capture",
+			.channels_min = 1,
+			.channels_max = 10,
+			.rate_min = 5512,
+			.rate_max = 192000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_ASRC_FORMATS,
+		},
+		.ops = &fsl_asrc_dai_ops,
 	},
-	.capture = {
-		.stream_name = "ASRC-Capture",
-		.channels_min = 1,
-		.channels_max = 10,
-		.rate_min = 5512,
-		.rate_max = 192000,
-		.rates = SNDRV_PCM_RATE_KNOT,
-		.formats = FSL_ASRC_FORMATS,
+	{
+		.name = "asrc-2",
+		.playback = {
+			.stream_name = "ASRC2-Playback",
+			.channels_min = 1,
+			.channels_max = 10,
+			.rate_min = 5512,
+			.rate_max = 192000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_ASRC_FORMATS |
+				   SNDRV_PCM_FMTBIT_S8,
+		},
+		.capture = {
+			.stream_name = "ASRC2-Capture",
+			.channels_min = 1,
+			.channels_max = 10,
+			.rate_min = 5512,
+			.rate_max = 192000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_ASRC_FORMATS,
+		},
+		.ops = &fsl_asrc_dai_ops,
 	},
-	.ops = &fsl_asrc_dai_ops,
 };
 
 static bool fsl_asrc_readable_reg(struct device *dev, unsigned int reg)
@@ -1393,7 +1442,7 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 		goto err_pm_get_sync;
 
 	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_asrc_component,
-					      &fsl_asrc_dai, 1);
+					      fsl_asrc_dai, ARRAY_SIZE(fsl_asrc_dai));
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register ASoC DAI\n");
 		goto err_pm_get_sync;
-- 
2.34.1


