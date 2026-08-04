Return-Path: <linuxppc-dev+bounces-25351-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E1EC55172
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 09:56:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDppg5ZLlz3bqV;
	Tue, 04 Aug 2026 19:56:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785837387;
	cv=pass; b=keXeRgOM7e7MgbnFXXYA2hbiaHaGIXEUnMZzzyZjj9G5P2LmwgEQAEUQYK0tLyCKtDElxBp4jwVCib/Sxtuax6cpjpocBue9EwmDCDeKsKf3/BOWolMkT/Fj/jXzhIudNg/BpMZ9Ch3aTHLEMyoLIGKaD1hjjOvkNP+wdRk5fnapQaTyxCg0iBQZsq6v0oCVt39d1W42mmeZ76eByuHVsns9NVqIu/bQBsuHevWbt1At09/zTGlLYPjxtekVmBpV2rQav+cLkXRBpTDKCkfgEBtW0Ri263v53WLUZ98D+xFQN7PURGtAN7kydvMuMd+Wh2piCV3sYSFDskoUFGI73A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785837387; c=relaxed/relaxed;
	bh=HUrEleeYnaMpLux4g93s6uxQVTUZ/liDOoBhBcdt2xk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nqqfI9nQ3SqEfSKLhzFLb597ZR/xx5ZtV4iArtDPBjLbsiHibh4/S1NWR9wnby45Cwt1YQKBLQG397PATOcVf3urVX7OZqwkHhBu8+agBP64Sz+ErTgemGtFrogr+wxwCAxbqcq+Rz7+GpBI/8tzrzInD+s9qxESuvgc98UzFqtKWHIpcF1cyf1UpdgH9zbNZboBcsraUhwk/TS9+9v5EYGVpf1fxEobq55sCXESy6CyRu869eBU9U8jUvejWcUlCcMPD+2yPsHCvwAAQrkdLRwdJaJcrpwJgEI9bNUkkraiTApNfdPSqh1r2CziawCDCDrWxe2aCNxB0yBin1fC+A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=N3Cd7dvL; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=N3Cd7dvL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDppf2sSfz3bs0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 19:56:26 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEusBlgXWzvolIUbUnOAgsSrevkrWTZ6i9VTvVqD7XTSuHuK9Y5KFgaiocX+u+CkKbh8Cs4hW+MCbHQ19GfMk3N6g8Ew7lTj+AqNPDLHa5NZPKezrmTlGjvEGE7UmO+DkAwO8AS2nTxaXsMVJw0YtpdzjdRaM8nyaOVlq0jUoxEqi3Dse+iZIKJ1fSp8MZ8kqTpL0UQblLmWpB7ZkmsB2lWUfjTdyMSepJJ3Lw5n9s6LP0QQEGl2m7PZ3CiLQ0dNF5i5trF9BFiBhsFPM+x7V/jWQL1VUO5SChUISiXI8owDZ+l0edxt0xzdh5ZiKo/mBgH+Vuxq13uYRc5AxIoGqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUrEleeYnaMpLux4g93s6uxQVTUZ/liDOoBhBcdt2xk=;
 b=vl1kVoDsnmPUb6ogdzmGY9cEUGlPxI+63RSsI4hrVFpIILgN0qVPY6Ds2sX1RXcdv4x21ZHqgV86zrIy+BOZbbF9Rhr2/ctJ2t5vqZBRhgzjO8AkUUFlqY8ZaU7j8yNXCEo3f+hzNKy1oplYK5CgHm9rIQ4cpkE5OTooMKd3qkWfFAqSnfrjHeMbNcm7/GPO8s9M08d8kKEYbjsq4HesvcUxshQSMllQM4s/Q67wlqG1RVODfne6fU/Zd5K19TjZrnmcASLkfTlw/g9O3l52LQGtsrVyg9hSacvTCKMAWlbbx7kp4nWIiqgIvrbnMtXRWNu108IfHFY5tjASyyN5Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUrEleeYnaMpLux4g93s6uxQVTUZ/liDOoBhBcdt2xk=;
 b=N3Cd7dvL786sNivxzkK6u4ZF8vv5zsjODqtCCc9GG/LJs6gnosF07VdoySX8174OzR7SevOUjouZloMnhdbQaLcx+RyVL6pfdqjzAskNrqCe45UjVIc7g51Vpk5eU0KoNRdI/p8r5KwIWnB4uv+SG5+aGAQlQ6nRVRy9K3ve8+BNMEYrqDElKsJX6B+cA3dAXwX+cVhcLQd6ILBDPbOmRxhnbTmPEHFAXwbfwXJFsJckyJxjqBcr6fyx3vCL1pEK7OYeifmU7yJKN+LgUdloSeYl7//u0tVzV7FrU+51EL66YVnhOCXuLLN0YlHdNDb0LXqe689LG7kwQNjM1RFTew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by VI0PR04MB10592.eurprd04.prod.outlook.com (2603:10a6:800:266::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 09:56:12 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 09:56:12 +0000
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
Subject: [PATCH v3 4/5] ASoC: fsl_asrc: expose individual DAIs per conversion path
Date: Tue,  4 Aug 2026 18:02:17 +0800
Message-Id: <20260804100218.49587-5-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260804100218.49587-1-shengjiu.wang@oss.nxp.com>
References: <20260804100218.49587-1-shengjiu.wang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0042.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::23) To PAXPR04MB9351.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9351:EE_|VI0PR04MB10592:EE_
X-MS-Office365-Filtering-Correlation-Id: b31b3f6e-8314-42ed-8c69-08def20e9dd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|376014|7416014|366016|1800799024|10067099003|921020|56012099006|22082099003|18002099003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	BFqMTvHFnqw0N7uIPA2nmOMcvf8iau+3rTgMyuU2VUg79VwT3+FoA8ZKbse55oxyDTkxM0TLxK00aVR3gkL0EtSYBNw+3q2cklVd921ygSGK0dAEAjodTd87EUPTdj8A84mReOeJzX4OQCjbEuJ6do7/Gq1rydlHmn7eWo/p7xcRnHgqF9D3YNP671ntdBDyHfUIn2cflVha03EGJ3AojyzQTgyqxn44V5dqvMm+MdgZpl3Tf4QVkFm7/x28szXV5zmZuyUHpd5CzUTGaNsL85pVvq0s/E+/XctkCiRmHbbPoOBpE4a2xwYhWi0RybtLNHb2/Nn6gPwtIrBDoYIoBB9cnxzOo4p6WX8QO8zfSwGqxJw2I0EdStGclUYw71QHKl9mQjfe+PxH8bOO9Zx/zpvNRWdEUo9gg4U6cW68bnKqk2zb34kUWCljRWoeE2xq7l/TiEnAti/bxHWC/Rq33xFGauvBPQ22vTB7m8dljjYwsqK64MQxkE2LsESz6HmlJ4CZldxzUcFRvHpMiRhmwfpk1/3m4CBQoBci9Es6BIP8hFvEOdyRemwp589lSlNK7iOuucfjAifGJ9QMyP9BDnA12kFjhN0KDIJPVvmkHeCyKJoLWYGOFcp0RelmVAOzX+3+4CVYZyidiZXmDUROgbsexC0fU20fkmzaGDpfw/aOTtLIQnv+OpM2jA4pFGZGYfzMu8PwzKTTpEIBFxQekw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(921020)(56012099006)(22082099003)(18002099003)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i2909NymhW24KLNHOeUnER6CxOxj9IL2xwW6Q04ctL859Vs2kMVNHTJX81TL?=
 =?us-ascii?Q?lVbsNrMyGZqIpfd1ejvad2NYkwNyW4N9WbGVLY6tqfWCPUneG9YmZMvgYATO?=
 =?us-ascii?Q?X7+8/7MSpFwMrJF9FJ7nJb2TzilYbO5S6X93ja8f9Lz99HWsFSW6NUq9fTeJ?=
 =?us-ascii?Q?i2p4KiUh1y2XMnygdiNueir2dTnijnTBBuFjWx34JGnqFcDFjMthwPdAyafw?=
 =?us-ascii?Q?2I+lBh0bhGVhJmNx4f+WT/c7OMlk/f0S4Wk2AThzVkSfcKp/g1I15wKQNRo5?=
 =?us-ascii?Q?v8RITs/hXPnKSk889ssMuZvKx+1BaYKj3398gxnCPCx4UWFcVC8rddwJr1ao?=
 =?us-ascii?Q?Jvl4OBQxAwqk/e1q4FEJcgz6PqUVQmiJ3bjqQOm5fep1DRDhnMSJlMPaMoFC?=
 =?us-ascii?Q?843hcwU1dKOb1+zXIg520ts7XoyVHZ4zfM653jFrTnsI1s+gWFkmeAuqdzY3?=
 =?us-ascii?Q?ET3AQKu+x21mJjDIWt64rqIZEtfGXV+yb8TsvkDZYCQuXcarkehKmPRIuqOP?=
 =?us-ascii?Q?HbG5d3pa2C6Gf3arXLmgNldC+/UOn2fMRSCtaFpT1uX1XE0qpjdnd+VBUj+6?=
 =?us-ascii?Q?HoHcIEe1xatEuc3frQcLviegQuADw6JPcCVC2ltcR3OyNScIB6WOUbDMcClw?=
 =?us-ascii?Q?JQhRsZGlxeinz+D1N39NET+DbANmov8gxXRFpbsc8g9uffyWeYk60+bgLwv9?=
 =?us-ascii?Q?0G9T8LaItjIj4CWeojEUkFYxhfxarvtPXO34ZNk2BO7psWPVe9OcTEg7rcRH?=
 =?us-ascii?Q?1QrKWwPKzo+JI4qKBNgfGpuk4wEgKU3YotNIQT8vwXc/d0vMv5zHizoMrvy1?=
 =?us-ascii?Q?XQpnRjgAVjoBF3PcxjxV7M/JufJrRZJcLvreCE8ITie3+u3OGCdzQOD4YXU3?=
 =?us-ascii?Q?cFNz/qmVzsfKuew2PTOXBHzl5luoZ+JjTaUBUbFmoZeMH4rtWCzFS2L77MHm?=
 =?us-ascii?Q?bxyoHsuLZuXeomtLMvCtnij8gN1BfEcmXqLliDz4XF2UVioldZQPyuIZWfR3?=
 =?us-ascii?Q?xRY5AdPurmBN1fRIqAsImvFDgwJndmMu6kceSHQi27v/IpYrueRsFhUdWYk/?=
 =?us-ascii?Q?sUkoc6NgMcg9KScOFqkJHtlVB0TwAWiIgSZ0WEzVRW+WqmhmZiguSyDoj5Sc?=
 =?us-ascii?Q?51C5VOhAAP2WOspAqARek0mwyIqGybrapX9/CUw/L03nFMh/udXeTLI31dN+?=
 =?us-ascii?Q?LNgULPPxel7DKGDPaZuZY89LAfJ4BY3W4WdbgaPMVwg1bhW+U4CdhOJHC+1m?=
 =?us-ascii?Q?aAu0VIonPV9P96GPMw5DAxqf3MbARgVcW+7TWEWVIIrSPZCQoAg0VgvGzE3S?=
 =?us-ascii?Q?ej5QNO0vX43O1Ij1saBs78aLWVtmKiFq5k8Bgo3PIKMrjE5a9peRsVc2gN6K?=
 =?us-ascii?Q?yW5b4WM3EPiiRjRH4HBQO10T0j45IzwsyAz45khYPXWWEiOcJ3RJ9TrZmw2Q?=
 =?us-ascii?Q?dtgUB1Gpm49p+ybk386eBl7OIkqI1oG1MhRz9/OtTCzj09NKI3uN6EX8j6UI?=
 =?us-ascii?Q?jT06IQWupI77N84UJOq1JnMQVp8D+n5QDxLs0cQuqLpxpgXtcsCTD+F6QlbN?=
 =?us-ascii?Q?nrji+Gg4Sl6XqPWb3M2fEoz0veCw/DOwDR4eSoJhuoDHX9aRSBwIwk1WV631?=
 =?us-ascii?Q?g3rSlHd7ZZ+wiqLNMn3MDYuSWVlbnnGIxEIXImaRTKAqlMcgSLlZgC5tDlLB?=
 =?us-ascii?Q?vnl9aABCmqJ8ejMwNZePew2PVGqbyZfhX61Pth6gMlNZ+bPXEj8Gjx6RfmQb?=
 =?us-ascii?Q?CQccVpzZxflGoaFKtiIDEmm/icLQH2ciemXE/SVeMHHK9J6QWb3j?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b31b3f6e-8314-42ed-8c69-08def20e9dd3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 09:56:12.6896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xqSPoKNbbrgg4j8mTezhThuwwPhfSubc/WtGIV6KW8DTXzicaH5RvGQsKLSeftOJpFDEt2WAab+qAcHE3VUtQ6sX3EDefL7TkPA2xnIDlCVMtLdSkYn0Kcu3OZDh2e1u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10592

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
index 2755ee57c6a1..a5d6c4c1e929 100644
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


