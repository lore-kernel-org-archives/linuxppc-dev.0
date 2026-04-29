Return-Path: <linuxppc-dev+bounces-20250-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB40BFF885A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 02:14:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g517m0WFMz2yv8;
	Wed, 29 Apr 2026 12:13:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777428835;
	cv=pass; b=aQb7pRv1bF+c4IZw0/oDe3lRRXESQUrm8xEc/O42Auhz4vFhY9tDGJxrj9ZA5gO49Yay7eKl0dh89+8dFnJYcIrHJgDvG4HCll5pO8NrjSc5k+mjk9UHAUw+afhr5BoRB4f6pbLB1x4e1Dy0go+TkJ5v9nOv49de5ON9Yh/UMTdLCm4LoeF8pYN0ke/FdDXgspEYqeVkocAfQa1Eievmd4VSVl7cZcfXjKE+guVZYwtURaDyeU75PTIihYNj3WHY5jOIOlTZFRX7uF/J3FzlDqEbMZyQMH6tIDHnFu2/T3oW42PYRR+zLXEu+f5sQs54kljDIkeazFnbJ1dWuvo53Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777428835; c=relaxed/relaxed;
	bh=Lj4ow+POcv6qIcuPkA6csArudyjVdjzN2opgHF+HGKw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yllw7lnuuEaOOk9dS+2yUfCyMvo41YEVBDBRHwit3/86KCvYkevCJHZQBDN9NlLMeKOxa6g4V32yq5ApN2/h7QquoaFaAmpe9rBTeHWhBdNEKDXP+3UZePRkOTryc0Zorkn4cGP1vs4cEOUbAZgBMMxKukBMMxeUuh99CVhw2kRccRwATzcSM4WDQ0bB8z9C9YrayIf8pQEmoTO+mt9DaM2kRHr5hHzSWwZ0fm5vw2biPxpCIlT19RfGtoos0GhNQ+k9sg8GKmHugA0R5uyH8wcQKLJBItqz5GCzj3ofA3De0IuLcGLphT6dTOkcfJWn1FGL70l/QCGtiSy03unkzQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Iv/BGjNw; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=chancel.liu@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Iv/BGjNw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=chancel.liu@nxp.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g517l0BrSz2ytV
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2026 12:13:55 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u3JwzQD5TLCqiLu7kCA4+l7bRR8wlYaYQyJTMHD1JWOipm1DnYT+VzkYmwFDCYRaWqAiGV/YrZqziR3xSAYob/jsl2HeQbOy50v7xmNfWrXejcgKGJabov/LOlkOfZqDRJ4YXuJD4KAM+0z7BCkmOmV6cuiuufs9VUNFEhu+eezGX9516remOABv177FmRZZNu7nHYCpuKIK2OJgvin5r0A3s6g9Iaj++Mo/h3Y6N2Hhkfh+hdE7XIW+VwITHUruJDDDUnWWovfDCQ0WY18giDsEuvuob/Rv8o1xDYlKc8YLiOu7Qti885KWNnK5BHL9rUUE6zaAMymnicRKWn5gEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lj4ow+POcv6qIcuPkA6csArudyjVdjzN2opgHF+HGKw=;
 b=PxbNQH5zfNi1MfhLe2qGZr1XyHQHQ1JnAZoqQwvjR7H8CiPFTohchnz4fybQ2NuvxAy36WdvzBaur0kjCzi8yg4BooIdnY7StOrUnKnqxhE+iqQ2JAnu621SaUeOXOlUCAj1pmScQOLcl840hZeMNA0tUusv+xtxK+U7Nain3mmCpccqCMEwfFPL43nHzFOYc8jkFPcnakvHJa1MUNO3Enu4p/lZtBPN+dGrrt9s+l36/KSLkl27OWFh9rsWZpOPjHdpTLwiIY/aHK9yHXsLPL/RTV2F2MDAVhL/TVAvbRC9DidCR2MNg3um7M1jmL/NgYqtlaWsn1It5Ws00a496w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lj4ow+POcv6qIcuPkA6csArudyjVdjzN2opgHF+HGKw=;
 b=Iv/BGjNwLaz0bU+rgGeUwZkrHiD/ynFpPUxygVWhGR+DnWfUAdL2zEqnAc1oIgTsM0JxGxT/lL50mOTu1F5gsdj1/YxHa9MHrs0clKE+DVBNBgwSnAkhDJ4PChfCCaGeOKxBRudG0vIYQa8CmCtJvGGGJhg5uLjHUh377yWYJQ8DgYRTHjFs6xtr4zSRfCvXcQAMYW/+QzHPXRQYWFawCJY7kATleoodLdhGftK0tyiu1rBnGMxwCOX7rimiKs4Chw70jt+AFQMamzeRcKkWB70FS02DU/hHPTNDrzZa4/9BmXHd0AqrW6SoE+we9oF9/AG2jVbhcVJ/I/fiN50GOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8353.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::22)
 by AM9PR04MB8276.eurprd04.prod.outlook.com (2603:10a6:20b:3e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 02:13:30 +0000
Received: from AM9PR04MB8353.eurprd04.prod.outlook.com
 ([fe80::46ae:f774:f04c:a1bc]) by AM9PR04MB8353.eurprd04.prod.outlook.com
 ([fe80::46ae:f774:f04c:a1bc%5]) with mapi id 15.20.9769.016; Wed, 29 Apr 2026
 02:13:30 +0000
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
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	shumingf@realtek.com,
	rander.wang@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/3] ASoC: soc-core: Add core support for ignoring suspend on selected DAPM widgets
Date: Wed, 29 Apr 2026 11:12:51 +0900
Message-ID: <20260429021252.691263-3-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260429021252.691263-1-chancel.liu@nxp.com>
References: <20260429021252.691263-1-chancel.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0139.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c8::11) To AM9PR04MB8353.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM9PR04MB8353:EE_|AM9PR04MB8276:EE_
X-MS-Office365-Filtering-Correlation-Id: d36b53cd-ddaf-4356-34f0-08dea594e862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|7416014|376014|366016|921020|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	jCELBScZoeI5JNTPCfgTEaYKiEpoRUzJ/1s2lvCuT1ulXU7OIJlj8dKSW4kWkKgiz4PMemz8p/M0kDlABzidc/CNGTH9qrDavLcNiXRBUdwJN/EQUuMhugyHhCcDDF2VJPf+gN6QcGU3KVie27Ky+jA4+y9G3E1KMNgIYn4RGlmdhzerywQuprCUChkyu3TpKjHuZckC/RQkjeqLVB7b/0FsJgE6WMe6ybvQBXYIGtBsLrcNnglU3stimvUkq3aXQKcGm49H9mmqfgzevm5EVXqupEzGlGbEPBhx58nfOYNBVGIS/5kFZvHEXILlQ9xaRnvOlkKZId9EanRiP2nC2cwqrKwqjz2ZMurK/vE100kBFlh+oDfI+NvS+e/x0Vgk8CplbHZ9Sq6+SF3O9OeIQ0qXCNctUMJATxkI36DLGQo6q5Ld+20KLElVQDayCGXyggf/KSNNWCf+Rbw4qP+hY8IKXFAOFHdwQgPAdTpf7NXC4YnG3M6caYOwAkn5NY0TKGu/ef79uyx2OB7os4P8X/YfUjC278bqMEMhKbroF02oQUs9KTef+atkKo66D3xETPn15cgFPYJsM0Iu9ccRwUu5/MxfFODifRLD7UN2zP/usILYll9LgnlQIdu7S2wGLD4kKZeT7qNLNTTvqEg2uTqWmzgz7/ZA1ewDmIpgfcS+IseLAmFl7P9W4Cn84kcm6UBWfeJbPUn6txXqHOqbowCDFtohp/CzFDJJdXxJD/Fs6GL7fPapHOHtzAfGa4LRLZSxK8OrTmqGxewLXCN6e6nGC16nOLdRCZJJ9bToscDcwvSWmNHh4r63oh8mVzFi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8353.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WeWQ5RFFtbHPYa0Mc9rp23QvyZUoaCd2klH8HG/M3Su+7Pco/NkasJlc0iZ+?=
 =?us-ascii?Q?R99ptYWjsgsgfHQrCZrGx6LEkancf2oKEqsQOQSZESf3tvKo+7agQTKTqteC?=
 =?us-ascii?Q?dVU1KZhmOB+JUG1mEn/QemTwdds40OmmfKeyNfINfjxMG5SeEsEgFjzDtFpz?=
 =?us-ascii?Q?fhRWK/08rFeJW4d2g9/uW9Gc7/JbZEAwprU7xmF0NS446yvPtxzAST6cPV8j?=
 =?us-ascii?Q?Td/0q7hj+1bGLaZiSD9wnMdGeVqD4rIEFjT11ATO3d6NPoj86jd1qIiQCSQz?=
 =?us-ascii?Q?mETsEMUE42yd/7UsUSQ5KwPKSj6iyAQ8vmVPlMccPGPA8srYjn/gH/txA9g+?=
 =?us-ascii?Q?QSRd0xkLbRqlf+TXKVIu5nhijcYKXyeuvkf+ZdW2n33NY6962gwLNga5ze3x?=
 =?us-ascii?Q?NKFy7BSyKZwczmS2UhotgdcQ3L9GJymM/7a0dRl5EztMeO+OS2WUSMGHmtIt?=
 =?us-ascii?Q?a+cPryEd6dC500MFwFzFR6S5miVqwZIHnWJ7HSZcOIbcV1/7VHcDkeN7QnAf?=
 =?us-ascii?Q?1ulr95snCLB1ngjt4QhEPD32OnbQ+TsamigRMB+V5PuaYbPD1nVo7hFgCf7M?=
 =?us-ascii?Q?A0sC888ol6mNZhfrZFGZAROSp5Mkg8zFIB47xfYqP8RQmw62ZpSmB7yHZ1DO?=
 =?us-ascii?Q?R+bVxgSmD7Lnv8eSHKBCeE/SgM9mJ05zxpSOmF12Z0h31jeUZZ0NXH6XAl+C?=
 =?us-ascii?Q?RyOIw88b0bBrVtfjZUbsonwCT/OjXwkfvUMuJv2S2EHrrBVIdJS9D0hnRRSU?=
 =?us-ascii?Q?j/H/xZRRpgUZz2Ph10Mg+8w9qf/D4MfA8+aJP/gAgeZ60IlV6t0Rvv4RBlDq?=
 =?us-ascii?Q?wIs7/V2BgkeFWxw7U0LPZr13D/4gTd3j5uZtWLuVh4GZqmeSBqtDPZ2EQRfa?=
 =?us-ascii?Q?+MP8Zg65f9V1leW3KVL9s3s0X/+mCIs0AZWoroV5O6DT6j/gqWtV+aymbU7/?=
 =?us-ascii?Q?mraTvcKXOh2ZbJBnbe+STwVnECOZLmjNNHfHTnMQpKKK9lM0StQx65GJSndp?=
 =?us-ascii?Q?0gjjyQNuXgB/IIQVNTnb0NtL+2DNzlCq7J37G+X2qL+664mCVpgQEb0bxXgB?=
 =?us-ascii?Q?Sm+tqGFdsYzOoZsys6MVQFoKKkwxjUSOZNtaADYFHMCIMHfCcJRwXhRaSwi3?=
 =?us-ascii?Q?Qp3IHuc6/FhWo7xjKS82la1agGxU8OnZxHDRmannlzNyn/6wPXEiKVg8AdAE?=
 =?us-ascii?Q?g0jpnb7g2LqtPtrx0hxaOlCpo7gtGmf28G5LTiqt/Sj+nqsJ1OFjYWX8sos7?=
 =?us-ascii?Q?Pm3M57LuEBN+6V/3fmkwO5z0FPFHpWzWVZydk80IM/b1SNJ72A7HHcSD8cuZ?=
 =?us-ascii?Q?O/KHt7fHJZhhiIv7VvYJyLTpNvdWUxg90ROWO6wmJ46EuQaSdbju8jhH0k/8?=
 =?us-ascii?Q?uZOZXq9gVK8YCQoMupzoMiBC3OqcTA5Oy5GoBytuzjfT4fA5Yl6ynsw6ZDdX?=
 =?us-ascii?Q?HtdVsoFfapVo6QOcr9MJsvIqcSRLZqI3rBUDMs+12xggMK1cnOMXslqHk06/?=
 =?us-ascii?Q?zbjhP8Qs8QYOnNiMF5mg8TvopMQSY4rkZ4jmlTnjCCtUUCIynGcKZ81By1RT?=
 =?us-ascii?Q?V8HOhhGZI0+4wlFw+ETS6d9RXhbnKQkhQ/2lHDwuhhfjviakIYeEUHwaveAl?=
 =?us-ascii?Q?1AAaMeBfPdpKUddNHW1XkBgUaEORcjjzIW+qzrlUpYLLAAJFjZ3MryEPx371?=
 =?us-ascii?Q?YUHmb+U4OuntkG8MwN9WW+6G9yuPZu9kEX3MNKuWIqnsjIZ4jE+0RoAxSWij?=
 =?us-ascii?Q?jasACvDIxA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d36b53cd-ddaf-4356-34f0-08dea594e862
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8353.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 02:13:30.6721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vqld0Z6iFAxnuJdSOuieA5ro+LNoBCkwOKrewT4wlK+Arx48C84uqZOv9HwGP+KFlQYm5rn3ZCGjAGfdAzISug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8276

Some audio systems require specific DAPM widgets to remain powered
during system suspend. Introduce a generic and reusable mechanism in
the ASoC core to mark selected DAPM widgets as ignore_suspend.

The unified mechanism consists of two parts:
1. Parse and store the name list of widgets to ignore suspend in
struct snd_soc_card

The list of widgets can be provided either by the machine driver or
parsed from Device Tree. Different machines have different routing and
power requirements. Each machine can specify its own widgets to ignore
suspend through DT property. It enables flexible policy without hard
code. A new helper, snd_soc_of_parse_ignore_suspend_widgets() is added
for this purpose.

2. Apply ignore_suspend flags during snd_soc_bind_card()

After all components have been probed and all DAPM widgets have been
registered, snd_soc_bind_card() performs a unified lookup of the
configured widget names across all DAPM contexts of the card and marks
the matching widgets with ignore_suspend = 1.

Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
 include/sound/soc-dapm.h |  1 +
 include/sound/soc.h      |  5 +++++
 sound/soc/soc-core.c     | 43 ++++++++++++++++++++++++++++++++++++++++
 sound/soc/soc-dapm.c     | 30 ++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 4f8fb7622a13..39c290e0eb7f 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -636,6 +636,7 @@ int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm, struct snd_s
 void snd_soc_dapm_free_widget(struct snd_soc_dapm_widget *w);
 int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card);
 void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card);
+int snd_soc_dapm_ignore_suspend_widgets(struct snd_soc_card *card);
 
 int snd_soc_dapm_update_dai(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params, struct snd_soc_dai *dai);
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 5e3eb617d832..7d6fa79f48e3 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1057,10 +1057,14 @@ struct snd_soc_card {
 	int num_dapm_widgets;
 	const struct snd_soc_dapm_route *dapm_routes;
 	int num_dapm_routes;
+	const char **ignore_suspend_widgets;
+	int num_ignore_suspend_widgets;
 	const struct snd_soc_dapm_widget *of_dapm_widgets;
 	int num_of_dapm_widgets;
 	const struct snd_soc_dapm_route *of_dapm_routes;
 	int num_of_dapm_routes;
+	const char **of_ignore_suspend_widgets;
+	int num_of_ignore_suspend_widgets;
 
 	/* lists of probed devices belonging to this card */
 	struct list_head component_dev_list;
@@ -1339,6 +1343,7 @@ void snd_soc_of_parse_node_prefix(struct device_node *np,
 int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 				   const char *propname);
 int snd_soc_of_parse_aux_devs(struct snd_soc_card *card, const char *propname);
+int snd_soc_of_parse_ignore_suspend_widgets(struct snd_soc_card *card, const char *propname);
 
 unsigned int snd_soc_daifmt_clock_provider_flipped(unsigned int dai_fmt);
 unsigned int snd_soc_daifmt_clock_provider_from_bitmap(unsigned int bit_frame);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 3fecf9fc903c..705181dae472 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2289,6 +2289,10 @@ static int snd_soc_bind_card(struct snd_soc_card *card)
 	if (ret < 0)
 		goto probe_end;
 
+	ret = snd_soc_dapm_ignore_suspend_widgets(card);
+	if (ret < 0)
+		goto probe_end;
+
 	snd_soc_dapm_new_widgets(card);
 	snd_soc_card_fixup_controls(card);
 
@@ -3294,6 +3298,45 @@ int snd_soc_of_parse_aux_devs(struct snd_soc_card *card, const char *propname)
 }
 EXPORT_SYMBOL_GPL(snd_soc_of_parse_aux_devs);
 
+int snd_soc_of_parse_ignore_suspend_widgets(struct snd_soc_card *card,
+					    const char *propname)
+{
+	struct device_node *np = card->dev->of_node;
+	int num_widgets;
+	const char **widgets;
+	int i;
+
+	num_widgets = of_property_count_strings(np, propname);
+	if (num_widgets < 0) {
+		dev_err(card->dev,
+			"ASoC: Property '%s' does not exist\n", propname);
+		return -EINVAL;
+	}
+
+	widgets = devm_kcalloc(card->dev, num_widgets, sizeof(char *), GFP_KERNEL);
+	if (!widgets)
+		return -ENOMEM;
+
+	for (i = 0; i < num_widgets; i++) {
+		const char *name;
+		int ret = of_property_read_string_index(np, propname, i, &name);
+
+		if (ret) {
+			dev_err(card->dev,
+				"ASoC: Property '%s' could not be read: %d\n",
+				propname, ret);
+			return -EINVAL;
+		}
+		widgets[i] = name;
+	}
+
+	card->num_of_ignore_suspend_widgets = num_widgets;
+	card->of_ignore_suspend_widgets = widgets;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_of_parse_ignore_suspend_widgets);
+
 unsigned int snd_soc_daifmt_clock_provider_flipped(unsigned int dai_fmt)
 {
 	unsigned int inv_dai_fmt = dai_fmt & ~SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index c5b80d9ed64b..209f86b9add6 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -4595,6 +4595,36 @@ void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card)
 	}
 }
 
+int snd_soc_dapm_ignore_suspend_widgets(struct snd_soc_card *card)
+{
+	struct snd_soc_dapm_widget *w;
+	int i;
+
+	for (i = 0; i < card->num_ignore_suspend_widgets; i++) {
+		w = dapm_find_widget(snd_soc_card_to_dapm(card),
+				     card->ignore_suspend_widgets[i], true);
+		if (!w) {
+			dev_err(card->dev, "ASoC: DAPM unknown ignore suspend widget %s\n",
+				card->ignore_suspend_widgets[i]);
+			return -EINVAL;
+		}
+		w->ignore_suspend = 1;
+	}
+
+	for (i = 0; i < card->num_of_ignore_suspend_widgets; i++) {
+		w = dapm_find_widget(snd_soc_card_to_dapm(card),
+				     card->of_ignore_suspend_widgets[i], true);
+		if (!w) {
+			dev_err(card->dev, "ASoC: DAPM unknown ignore suspend widget %s\n",
+				card->of_ignore_suspend_widgets[i]);
+			return -EINVAL;
+		}
+		w->ignore_suspend = 1;
+	}
+
+	return 0;
+}
+
 static void dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream, int event)
 {
 	struct snd_soc_dai *dai;
-- 
2.50.1


