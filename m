Return-Path: <linuxppc-dev+bounces-24463-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B2AC44527
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 09:51:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3bQM5vjrz2yYf;
	Mon, 20 Jul 2026 19:51:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784541115;
	cv=pass; b=CMLuVzIHu7wPt9uAY/Rk6kZS2+HQf4TtV91eg4NUW64Pg03O3+l6v8XXPdhVihFylPE2DY/KrX0EPgjd0H5fp0PPsYhKwaaLqEgthZRzzLITjlZmq6m0t/d4hCpwwG8N5RNnYyqWCdf/jI+bv9J1n860SxtapOMamtS3NehS9LxAv/UiaN54UFekY9hrMbFzNJ99Dtia+/7audElH8vnwX6pxmYMuvFs0ITdjupsgnuWxBm933SQFO9353Tk77c9mBx2obk3CTw3s++DY/CNFSlcdQG3vVIgD28+nhQexnRJaXwcxRk/GaBN5w7igDRvPHcrb9odQMemVOe7UzpuLA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784541115; c=relaxed/relaxed;
	bh=2r+6GpbjumT9uE2LhcDV9orVsbg/htI/o39IKMlaJus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z+nP/CoZOd7KIMwGCqVm7u2BFDXThkzrSWI79xP3Ip8YeBaMKZW3YDIa9ZiEPgHoplI5Yuh7z8lljd9HiGz/WlmApz+zx+m3Io0Mexw3m1uCuAe3TArRMJmj0PpfYq6Zg0qfVVH9G1JDd6+c1R5f7JKKtdXU/zuutCTg1BG0fYweWNY12EVOboe1kS3fKzThfae7d4uXB8wWY+6lTaWd0qEjyLbptUxLQdLoi9WgmlQgpyTvr3Mf2rxDl6heZ49vUQasLy7siGKRO4cpTGBpHrhI3IPRT3jC8fy5yy7XdTIXomauK7BRjEcMErhrXILWAagq15kYUuTMp0WIyRC/Hg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=MeJSaJl7; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=MeJSaJl7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3bQL67Vrz304Q
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 19:51:54 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IbDp0ELx8ImYVhqwuQVt8+fRfmo50g/KkI5UkfH8+OdvdZuBnZd57e3u2MM4S79cLwHUeCRVOfWcdDmiD4EsSgWH6YT62wft0xylV0pHtF5LYobytejTBZCWswjxEus9CndO6ZRjIvDjf/mMjU11VcVMpPQwVRxqwWWASv4EI+Yp21y5ZifXmacqF4qjlp3Ty3hI/kSDt7raKn+jYUD5Ho+6CYIRDwGyibRsO48OzuOaXO4wx000/a7SC3e3cEaFoxEl/TwsykHuWOZLHqF4K9XC/fRf9Wzq7N95U5R0YMlIMdszL5o1P98tXqE/+FJyK2mbWRYQhcO8kzbSMBAjCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2r+6GpbjumT9uE2LhcDV9orVsbg/htI/o39IKMlaJus=;
 b=yFn+hy1xsNm7am6SX3gBOE0/By5DMZOXLN5iDt3xKL/HbCLIbOof1YCKVIUOJlsG4wMDa1h1HtTrQie9ywIwib7pMBjB7pVyiMeOMENgedaEAgOh6mH30ElULyHJPPPjWfR4iheXh/1C9GLUkOHdlk+0LzwjHfADMGu/ysFn08Vlbmkl6EcXMPT9kKgATjXoy2U/k5yRIrr2qb7Gddzw6DieZLlFOfrddVb/Bo1E7lzQfmXq3DuD+XvjwVde8PgXDTyUofHwU1drbhVH8B6O0Ht59U9tBgb/xuYYzCt62vcPpgCJ/Rv5DCFCBRDkl+Lh/EpI+CjWMMBOGP8T0Mlqtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2r+6GpbjumT9uE2LhcDV9orVsbg/htI/o39IKMlaJus=;
 b=MeJSaJl7qzUbOBKGTnmjcbLvxb5S9t1USUvU382PTDS4PSS+hr56xHvYW9tQrXui7bQGuHo3WcpfTsdbXjRCpiaI1IzIl0jpzoVk0DZ9Tg8vwmLs3fJlpf3GfQ03bB4LZWIQcnRExIs+F+IvxrSBpfYy5ZHoh0w0hVLUrsQjI6Zp3fHjYndJtsrAbE6N53I7/+DoB8SewI18kUzjVc4/cSUxZuHrJQ+LjDB8hMDKaZLh60tZu2NepW3HPdJFPvthrQeKbI/LobxsQoju3BIenm+CninyD+iReFn3GI1jfBgTn0EX1PdYPMEwkEYbOMfui9J802X5iXODAWhk6kKczg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by AS5PR04MB9800.eurprd04.prod.outlook.com (2603:10a6:20b:677::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 09:51:31 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0202.023; Mon, 20 Jul 2026
 09:51:31 +0000
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
Subject: [PATCH 3/4] ASoC: fsl_asrc: expose individual DAIs per conversion pair
Date: Mon, 20 Jul 2026 17:54:49 +0800
Message-Id: <20260720095450.1618747-4-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720095450.1618747-1-shengjiu.wang@oss.nxp.com>
References: <20260720095450.1618747-1-shengjiu.wang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0235.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b1::13) To PAXPR04MB9351.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9351:EE_|AS5PR04MB9800:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d99441c-1ece-42a6-8cc7-08dee6447994
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|19092799006|7416014|376014|10067099003|6133799003|56012099006|11063799006|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	71e52QeGzh9JrbW+n81EdhjgDnQChtFFKUZdsfhReNLgFJORL3Bul7DgXUmUCdtJgz71W57hdTQaetLRZx8T3GEo83l1orK1CFPEjoaDQN6h+/qknrk8kkYGMJn28PGdaatAo70pmJzWy8QxmIYNae3gSaS7kTP+J/TEaXnR8SHqIU0KGGaRTFuzcjlV/tpP1OZLcni9TkAWd2mvk71HeMp6RIu7Xs3EhGOjSqxyTDoFIg9+d0v53CeDTwoNKhDO6+AVDaO7hJ1UCGCrxE+cnQE/PhrpwQrPh4dhHQklDONB2i+jNuZYZWW80xj9pLY+Z/gjgMCAH37cvNcgfs153ViLLjUF3CB4Ltox5SE2ghmPYVzqoCDg7LQ0US0uICXgExyS5FIXa4KhIoa+S6yvBodka11fnOJszJKA/VpOq/0BKE4dC8il1zVzJF+KtHjc4NGWRKrKnKYhcdlJ7Je3eKzQqQ27xkOeJ6N9RmMqtXcOmJ15VHJIsl0e1DbF7mbKO//g1IBPlc1kN1p1qRxg4KlfWeHt+4v1EIR/T9t6SGKiKkj1vQRhOlZ/g68Rr4+WEmvaA6N9LF7XuW+hBH03ZUgSBYSa1fnEyKMl0zBMhvF7Wov1Q/88BDjZy+AxzPcOf8ykAmD//ilPlaF+FsICl5tW0keRrEh7GRcVT+8Sk9f8KMBSomy68Q4X/LGoUUQi2K1swfbMS0NEGOVwryHMWw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(19092799006)(7416014)(376014)(10067099003)(6133799003)(56012099006)(11063799006)(921020)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IomSKyS5lAxh/qk8TKpPfUkaQhJAQJALWK9GJ/zX2iKeCXtF8/pt1Lpet/05?=
 =?us-ascii?Q?KtWB39KF098MTj+Mt5BSc0d+BiPaQ2+Oo43Dqg2cuL36S6MQaC5+v9tego4z?=
 =?us-ascii?Q?h7vo3pIbwMEMu0K/9COPwIaV7JEzpvOYzBMPs0JJoL5eC4CpigYigPdA+ak+?=
 =?us-ascii?Q?JnpAVwXfa0beU3VNvfUV9Be49c2nvteD3dUYkbF1lp72HrBxIxrWVkIoorhb?=
 =?us-ascii?Q?ZzOMlt78jmlhJpN9UmdS21UJ+B1V2wAOgOy2HluurhwhHgdxGJGDirC4QNL6?=
 =?us-ascii?Q?14qI5NbozubuRK4VRrmRVZOq5OVTnXxj2SzA2NM4VkSORV9hMhCwyAKz/3gF?=
 =?us-ascii?Q?vrDcFmvm/BY9LnnYh2+a6e1w0ZqDDkQFvzUWtlZ0FwVqQoRy479oa3+A4wEm?=
 =?us-ascii?Q?EG7AGIMdy1PZB94VVil5QqsUFtXQ4YwmlJ606MnmyDDN7HbSNjjzGcF2kGz2?=
 =?us-ascii?Q?YYN+dXm590hJ/QcCx1Vuy3twwGhef+rkdpNzEoewPhoegLSNgkl6LJWa6WQV?=
 =?us-ascii?Q?5NEYJpPA5rLjdU6r3vzvtCA9xJ4Tnc79+7dFG26vpCQWuceFj9gL9HZ4aYPr?=
 =?us-ascii?Q?ZAMhc+HQSpISEABlqNkV6Lqgv0C3cW6TF6f90AB9wmRrNFBKBjopLjgInn0K?=
 =?us-ascii?Q?OjoHt1g0da+ipefMAK2QMI0kg1JQz+aYH9FkmPvLelcLFUyiBDYJMowELsft?=
 =?us-ascii?Q?LbshH4h6jWNz0xqC+V8L1zHRDCD96c2B1vbpME/eEHD2pvQVI3JqXBe1j8ZX?=
 =?us-ascii?Q?nfBS+Ipwi4upC5Gcz7FHKJbPCtXBFDLy8CAMG/dpPWOH4cEpG62XqSYziHUM?=
 =?us-ascii?Q?+RNPImxZ4uW7k/CYL8ruZCCVhV9n26Kx4MvzxJFDcg60zclnN+L1SRlyu/ez?=
 =?us-ascii?Q?J9HvM/TE7UX3jBzlQ7Z8DcOfTUY9tpjKtSIbvme+zAzTHfLn3e3D9/ntpNiy?=
 =?us-ascii?Q?y4HheidJeFy/Yxfe90diRw3zb0GL/UvZtmbRZX5i/GUiU7tMwu5Wp+gkq4Vh?=
 =?us-ascii?Q?h1GeBzVvsnFNqikYkAuNqERyRRu2I5xqi1f1n8dHB2Xx12mxlwHZW13pjPV9?=
 =?us-ascii?Q?BisNFAXbdDHLSud5GqJobOMwc+0QaMKuGehYVz/wx2X8NZx5XlYeDPq5m50U?=
 =?us-ascii?Q?5TVKMQ8YZ4rUFAebiGq+Wj3xgF462L5akz0OWKckRpMqIvfYjFa9Clav7TVf?=
 =?us-ascii?Q?3RhxZfNs16cKdAKpOjcWSzk2Q+PdcF9pgk7Dd2ZNyc+HdYs+ECXWHP+Iz3xU?=
 =?us-ascii?Q?vko53V7bPNzLqssHwzJGf+/q8jtMO/jm0elCol/zp3ZOc7JOuMnkVCzAPoWz?=
 =?us-ascii?Q?7O8QZwW145gVYX5hNo7Hq9KRagALpok7u3WtjGvx2pGqV4KsLmfma0E0Anhc?=
 =?us-ascii?Q?ekdVoAVU45pH/oeSTQYbLzHNW1Nso23ps39ilvg6hzqCgLk2iqrlo7QoufY5?=
 =?us-ascii?Q?m0S0dDRdu6nzP+dGExcT6H2+lt9yBlsFTvQD/4IN411ksTPVv3x7OB0OskKL?=
 =?us-ascii?Q?vqqr5kCF4MnogZ55K2Kch9yl+BUUizgz+tJp5OlPp3Uuof5T+yySqhLQew4k?=
 =?us-ascii?Q?W0NIWma3YzZr14SPJXxY18kNhOMfR/sWD8PWwkPaa9y9e+X4jDoDUMehUE5d?=
 =?us-ascii?Q?O62rq4tp9hIJBM5Op0EKv3xjIm4IsS3fN2rkrG6Y/5cwLJTaSPIXoq5/++NM?=
 =?us-ascii?Q?ChNXtlPQPkCNNW9GN+hYg7cTvo0Mc/Hg7LNAoOsanLViga1PywfVI9QkFPbU?=
 =?us-ascii?Q?6ps1gxSSux8bPaVPr6P4YKzdb0rmb9h2Q+14WyJzQteTvC2ciK/G?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d99441c-1ece-42a6-8cc7-08dee6447994
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 09:51:31.0506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BEsHwWVn8hlKb/1mS3jW7jtHvL+F9JFvWBO0Ki++AGXtxPANQ1XVJs2PJI9Cs24rgjyaZ/ZfSQqdWxMhBAqd6klXdHM5s2JdVBQmmSkJItNdc+JuJ/BhNriqM7y0DCi6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9800

From: Shengjiu Wang <shengjiu.wang@nxp.com>

The i.MX ASRC hardware supports three independent conversion pairs
(A, B, C). The driver previously registered a single DAI with generic
stream names "ASRC-Playback" and "ASRC-Capture", which prevents
individual pairs from being routed to separate audio paths simultaneously.

Replace the single fsl_asrc_dai instance with an array of three DAI
drivers, one per pair:

  paira -- ASRC-Playback / ASRC-Capture (backward compatible)
  pairb -- ASRCB-Playback / ASRCB-Capture
  pairc -- ASRCC-Playback / ASRCC-Capture

Pair A retains the original generic stream names to preserve backward
compatibility with existing machine drivers and board configurations.
Each DAI retains the same channel, rate and format capabilities as the
original. Update the devm_snd_soc_register_component() call to register
all three DAIs.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_asrc.c | 89 +++++++++++++++++++++++++++++++---------
 1 file changed, 69 insertions(+), 20 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 0b28bcfa47fe..f83d6cdc6412 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -803,27 +803,76 @@ static const struct snd_soc_dai_ops fsl_asrc_dai_ops = {
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
+		.name = "paira",
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
+		.name = "pairb",
+		.playback = {
+			.stream_name = "ASRCB-Playback",
+			.channels_min = 1,
+			.channels_max = 10,
+			.rate_min = 5512,
+			.rate_max = 192000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_ASRC_FORMATS |
+				   SNDRV_PCM_FMTBIT_S8,
+		},
+		.capture = {
+			.stream_name = "ASRCB-Capture",
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
+		.name = "pairc",
+		.playback = {
+			.stream_name = "ASRCC-Playback",
+			.channels_min = 1,
+			.channels_max = 10,
+			.rate_min = 5512,
+			.rate_max = 192000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_ASRC_FORMATS |
+				   SNDRV_PCM_FMTBIT_S8,
+		},
+		.capture = {
+			.stream_name = "ASRCC-Capture",
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
@@ -1404,7 +1453,7 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 		goto err_pm_get_sync;
 
 	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_asrc_component,
-					      &fsl_asrc_dai, 1);
+					      fsl_asrc_dai, ARRAY_SIZE(fsl_asrc_dai));
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register ASoC DAI\n");
 		goto err_pm_get_sync;
-- 
2.34.1


