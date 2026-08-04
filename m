Return-Path: <linuxppc-dev+bounces-25352-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CCEC55172
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 09:56:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDpph74h9z3bs0;
	Tue, 04 Aug 2026 19:56:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785837388;
	cv=pass; b=kojua3M3G0ev8tPmYsd0P+uM8eGagFI5CueXCuFLNOfMMq2Am5QermT43RdSfwsMVg/TpG/PIi6hZ/kNZ8yIcAu9t6y0qg9p9xMV/XD9Vt0V7pjDWrh2Dw4of5ELp8dyhN1nvB9TCqabCzWPyxxNHt7ubyo5XpZCe8zk1TxLQC68jehwEpfTHg7iZ0C6jQoMyFB46TU3hhVMHmFhqHMOyhfF0/plHEAZmS17mx5domroxyBaWG/tJdSm06O6YSZ86HoCkv5Mw5ET/AU7HE3NToeIffDPmvS+cKhjBmPN1FMQ0YRef1AmhFjZMs9TH7oHCut+UtRfO6laKmCOPN4jng==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785837388; c=relaxed/relaxed;
	bh=udpQrkSuL10XzYU3I0gW9J7I1gyKVJbO8x3yk5JXuJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PmC7FXXDoYY5Gs4xODVZn5oNs3yl8Z+5RX7Dd2AqNGZRlzqBPD6oc/SNGLgtnj+w9jrqcLpuuCnS07nsNJkunGy7Va+3lbDkacizmJxpJBpca2kROCqhdrOCzvC4Y251QADZhoLTP9Bl4pGaKLrobSJqFVhUoBq6wtW3jTZk5DCn+M4qkgZeFCqVe3cFaG0rPI0dY+3MezIn4UY76cuV84yqokT47mqD22PL7Sgxwgg6+8Ersw0kX7Eaz0iW0gJkTHLgwkDzGwOAXDTWAY/40Y5zBQygSPDHkD5yc+geoZJy5q0ln+bml6GBdjLptmEIC7k/8hhmu1b2U3/NxhPW5Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=l5hE1nTg; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=l5hE1nTg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDpph0YHLz3bxM
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 19:56:28 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bjfI2pWshLoj5p/YsT3+bqECssMOt1CZEAi310QRSMraeHpEvdwDIXRxloA+i7jTIJHQ4jwH05ElFQXCXNAfbuJ4XysoG0PEhjfACUHP3mt0SBRgBoYn1Vlog/o7Ijl2Qhcinub6PzK3zsV/w2iRDrGi1liAMi7ZXDLRrjNScB9/135YmB3LWFmORNuheHLYGTtm+xxw5YYhG7Ql7mN10MfoFgqLtlc0xWFG7OubCAMIt76om45ag9T8iAJsQxgv/hKfDd6oBiUgWfL9m98+lo52BwYYNOns5xIGDtVZSBKXRLiMdrvUVU3vnPBR8b+jy1CpNhbYCDxMYyv4ugVTIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udpQrkSuL10XzYU3I0gW9J7I1gyKVJbO8x3yk5JXuJU=;
 b=jKe9fDtLLjRGPpvroDRfLNqY+R+EOVocOgnz00jNkpdceQfR1B/Zcnf/Ve9FO1jJVPUA0f7knUoOmozWz+29sMM/ezE00aEW0ZEZ3w3c+lnXLFpwvXT31w9hhDd6SPUHPnRpwfaeO0bCuOSpY5JgNf7QioWBP0AqUrYSLzV1tPO3wQQNWjD9nCh/X8+bzDvvqR8jKyz/WfEcPfxj+lCxyrwcRZmqxDkR5SutdmYTdE32DHkwy7wIrngXkLJ5p2JG3EN7xmJLRfBBi3puqW+2SrGQdsezo1krGiRQL+wdgrNDEq+xpFAECf19BrZtfYySqWmM7wikQFGEuGnppM5+qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udpQrkSuL10XzYU3I0gW9J7I1gyKVJbO8x3yk5JXuJU=;
 b=l5hE1nTguR3yS/OIR4ePL6GGd0zYMb0JWHxtZUqLGJf8TkiMbev2O6VP9Oq1gjYhx/Yd7x1BZNRFJcNymMH7tuSxYDgfbuhWoClXvKQP6M43u5ye/Dq6e7DM7GzSO8Cnmp+cyghNPUX28S8KK0kJQmuCqwrmK8VN7uMN7NuGrgZYIsHGhDmTcGITV3kmeNMTsHDdvlpPhCGdbSDYBEGWXxPtDJWhOQi5B5nUsocHpWokJ6WtbHbzXwXQMf2Es1eUxi2iTwK4cWCkTIVWdIV5wiDGuJWh6fO3saha3iMWUAdStzodAWFyDL0RgJzIWmqip8NL61otpyZjSSJArLmvew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by VI0PR04MB10592.eurprd04.prod.outlook.com (2603:10a6:800:266::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 09:56:19 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 09:56:19 +0000
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
Subject: [PATCH v3 5/5] ASoC: fsl_easrc: expose individual DAIs per conversion path
Date: Tue,  4 Aug 2026 18:02:18 +0800
Message-Id: <20260804100218.49587-6-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260804100218.49587-1-shengjiu.wang@oss.nxp.com>
References: <20260804100218.49587-1-shengjiu.wang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To PAXPR04MB9351.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: a2bc8b72-9376-44af-cf25-08def20ea1ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|376014|7416014|366016|1800799024|10067099003|921020|56012099006|22082099003|18002099003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	39svciKj9t/Xq1hxwCFtQV0F1YQI6DpEoDVbnIU6S2+dfc7dXxMP+6w0dClGP7hkri5/Td2ICPKyx89bjrrpeY3MU8RwLgVzO4DUXeXYLTPsikTHbPSj/pQkqxzv9/b3jZU5pW9icEbSiSN0m1S88YQaxdw2T01JQNj3it+WbLkM6Wf3+3QWAgloELLkz+PZOelsH8Bq7Fys/DJS5PjTFJiC4a8xHroFueTB72hX8fLroUN9JK6/4dkghsM0ydsi9Vdwn2U4HqD5l6+SKKWzbHfPbePZYReqRABG4YpPYUWPpChzidsvNiV0VRZZqydIDVW1OPiZVhJTy1Q9t0xrJTbTGN1P8AIWl2+ILzscJQ1aDn8g/wdF5JlGWpR648MVsVxTOijBX7FOLbXNsAajYNXAl3nFH3N5owJq5aSOke3qbyKJ58RI76j/8yTPa3WqCImt7HAKWEI6hLRvD2KQzvFB7f1kSrJ8HB4KGc/2a0LX7J512wlXwbkM9LFkFLNfNI8jEoE/vqaoSPXAqa+Ih/iI5ac2jJiEbBK/a3an0S+lhmqQOFRbaowx6won9HqHJIy5CyGyNf8MMvhs4mFrFqqxTT4bemcl7nMEcvLXWSsJ/6StCSnLTOXhsdqyVhM4ft7XsAP/9MO8s5dYCH5ooELXyGYoDbn8Omrugle+R7D1JtHYjPd08MS+rAKIjOyeNsQh1rL0oGb/WjXOv/aasA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(921020)(56012099006)(22082099003)(18002099003)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AQ9whA0sO7U0AX4+3sVwIhKe8LPDcXGsZOzrhc1Kxb+Ql9JHK8xGgAdehVQL?=
 =?us-ascii?Q?T8VLm6e85syzOQ88VUqwjWjlxV86BtElpryo5BWtHpUd184s/4aEHiRC6hWE?=
 =?us-ascii?Q?9z4eyYfXPdfzOe06DCQ1xvpLOlk185czx4aggGm6u++eHYWeLj13+XHF2oJL?=
 =?us-ascii?Q?c27m+khIeyqDfvE9O7jvg5YJfIrB2HIcnrI7ic98CrKyYIya2SLEXpj4owDM?=
 =?us-ascii?Q?c7CT7BSzScR3HKctcxNZS8Tw6jVleam2O/14tOpwN5moiBvZ1nNWqXcAsuFi?=
 =?us-ascii?Q?WhxFY6toyS+Of5QPIwWzUHvCHLl95BTLdt+E+a4Ly79LqtxWs+RXJ4aogjMg?=
 =?us-ascii?Q?E1ZdJ65kd/Y10B5F+9lm6mNeCPhsP7NVfLZZXHzjRugKJSR3/R3ZeqDCIJ8b?=
 =?us-ascii?Q?qelj9L0Nuf15kuN68wG+TgKNy8LqzNZl0hLPv/Zip4B4hsToMkW0rbx78y1w?=
 =?us-ascii?Q?38OBTrOUvLTfi2UvgXOVV5gzATPEW/gCPkZ3jFD66OWlJzQB6awc1hBX6LEK?=
 =?us-ascii?Q?QUCZygBdkqboEzX9rqS/ZIvIS7b+m0aEO93tE3hw0okVq0e2lnhLTwFh0oiw?=
 =?us-ascii?Q?/Klco830ONQ0gLLzKutVcZ2LS1AorPV8InDZXfvKvGVskLTa8cBnDgIGs2cT?=
 =?us-ascii?Q?Aman4t6gbHHSZpfquhTrAX8KYGv/+gLqMFTFEFcYMSATEfbQxIaIU32gGoqx?=
 =?us-ascii?Q?R5gt5sCJWVVWd12yia6g3WbLbqH0PXCfJrN2oc8NekFvyrS7qn0bRuDkGDke?=
 =?us-ascii?Q?xeiBE477ZgJBBd7k2ioPJHarAgv+igv80/BZNSQA24NlmFPLPK45OaScCpqh?=
 =?us-ascii?Q?ezCVu6TAm2CW+1bK5lnTxgOcrW3HwjY4P98Wcr2dhCdux1USeV8668IuiWuu?=
 =?us-ascii?Q?2nlX7eDvLeIlccuIlHjtf5Enk9Vzdtsv3K1C6h4whCIXyjBhNwaF7cWHDkDw?=
 =?us-ascii?Q?hidQA/LF8hK9BCSkcELVgt0maLizO9qLO7cMlIElBMPOYVuksHLDChLwLtwC?=
 =?us-ascii?Q?Y97dX5dAv+RgvrCc7q2pOvVxnaoixZgaR8BmAiQt9ONTrrHodA/KXv/BMI4F?=
 =?us-ascii?Q?7M8tmIZiErMUUb8hC38HS7caTQAzIQGuadmX1bwrpLX8WVsxMJ6cpYzIDkc7?=
 =?us-ascii?Q?+rO5QuxU3Uomp637fACn2SrowvwyEcUymP+ZEcu97L/DE4mxra67CKKTgtXN?=
 =?us-ascii?Q?XFj+X9t1Z6iUv6Neq5pplqzVCr3B0t8OFuL8eKnVV+3ObR9XLKjHfo0OfxC1?=
 =?us-ascii?Q?uxq8toQtcWC0+8MGe3q3OphGOUfNITlvDBeWoLhZrXHIGCnFzK3Xjo180nnN?=
 =?us-ascii?Q?opD67Xx44e4khfLv867TJhhzNhnvaNTjxZZNunXScJSMoidUM9XOMqYv+7Nu?=
 =?us-ascii?Q?ul4hdzagqc4bFkFA7zjlX2sXzoyxM2g7Tu6Q0MsEc0eRqDKPulbjUMd5QeNY?=
 =?us-ascii?Q?XUC9BMT6RyUDtSb9HOEXD30GGG6KFyscF+KqyAufOS1z2PDbt198ZlmtmRoa?=
 =?us-ascii?Q?othmQKO8LyurKaiqeh6gy6qBEk5Dilm2/JUQ4HU9UvKTamJKx1x5EF/su31j?=
 =?us-ascii?Q?EngcUZGqIioCCs5Gbtvvw6C/dqIP0rwho6rDWAzutMS0LuVX17TxJAhM+pQb?=
 =?us-ascii?Q?398LeVpT5JIIuPXagVInAdfJdjHVAF7HsoXJ08DIVon4wkS+Q4PZa7iT/w9u?=
 =?us-ascii?Q?OJ3ISf0gP+IUt3/fByg5kob2zW7nAWwBvRYCZ1NZLc60zkKMECj5s/yuYA49?=
 =?us-ascii?Q?X7106zB98o/7ZITEC4L1+TnOVul6NLfwAh9edEEUHb60AYmPCuAK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2bc8b72-9376-44af-cf25-08def20ea1ab
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 09:56:19.2453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WroQy7U9ZHJl2903clBKZ6R1NvUSA4w1ErWeEAu+kAuImX7FzH3+PARdZo8UV92zNPTDZGCsubuEk0Z4f9XSjbyxCGSM4YzuzHo7u/4x28WUGWvqMBmVFwzmmZupMMFE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10592

From: Shengjiu Wang <shengjiu.wang@nxp.com>

The i.MX EASRC hardware supports four independent conversion contexts
(A, B, C, D). The driver previously registered a single DAI with generic
stream names "ASRC-Playback" and "ASRC-Capture", which prevents
multiple independent conversion paths from being used simultaneously.

Replace the single fsl_easrc_dai instance with an array of four DAI
drivers to allow up to four independent conversion paths to be active
at the same time:

  easrc-0 -- ASRC-Playback / ASRC-Capture (backward compatible)
  easrc-1 -- ASRC1-Playback / ASRC1-Capture
  easrc-2 -- ASRC2-Playback / ASRC2-Capture
  easrc-3 -- ASRC3-Playback / ASRC3-Capture

easrc-0 retains the original generic stream names to preserve backward
compatibility with existing machine drivers and board configurations.
Each DAI retains the same channel, rate and format capabilities as the
original, including IEC958 subframe support on the capture side. Update
the devm_snd_soc_register_component() call to register all four DAIs.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_easrc.c | 112 +++++++++++++++++++++++++++++++-------
 1 file changed, 92 insertions(+), 20 deletions(-)

diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index f1249da0658c..17d85d484358 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -1589,27 +1589,99 @@ static const struct snd_soc_dai_ops fsl_easrc_dai_ops = {
 	.hw_free	= fsl_easrc_hw_free,
 };
 
-static struct snd_soc_dai_driver fsl_easrc_dai = {
-	.playback = {
-		.stream_name = "ASRC-Playback",
-		.channels_min = 1,
-		.channels_max = 32,
-		.rate_min = 8000,
-		.rate_max = 768000,
-		.rates = SNDRV_PCM_RATE_KNOT,
-		.formats = FSL_EASRC_FORMATS,
+static struct snd_soc_dai_driver fsl_easrc_dai[] = {
+	{
+		.name = "easrc-0",
+		.playback = {
+			.stream_name = "ASRC-Playback",
+			.channels_min = 1,
+			.channels_max = 32,
+			.rate_min = 8000,
+			.rate_max = 768000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_EASRC_FORMATS,
+		},
+		.capture = {
+			.stream_name = "ASRC-Capture",
+			.channels_min = 1,
+			.channels_max = 32,
+			.rate_min = 8000,
+			.rate_max = 768000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_EASRC_FORMATS |
+				   SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE,
+		},
+		.ops = &fsl_easrc_dai_ops,
 	},
-	.capture = {
-		.stream_name = "ASRC-Capture",
-		.channels_min = 1,
-		.channels_max = 32,
-		.rate_min = 8000,
-		.rate_max = 768000,
-		.rates = SNDRV_PCM_RATE_KNOT,
-		.formats = FSL_EASRC_FORMATS |
-			   SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE,
+	{
+		.name = "easrc-1",
+		.playback = {
+			.stream_name = "ASRC1-Playback",
+			.channels_min = 1,
+			.channels_max = 32,
+			.rate_min = 8000,
+			.rate_max = 768000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_EASRC_FORMATS,
+		},
+		.capture = {
+			.stream_name = "ASRC1-Capture",
+			.channels_min = 1,
+			.channels_max = 32,
+			.rate_min = 8000,
+			.rate_max = 768000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_EASRC_FORMATS |
+				   SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE,
+		},
+		.ops = &fsl_easrc_dai_ops,
+	},
+	{
+		.name = "easrc-2",
+		.playback = {
+			.stream_name = "ASRC2-Playback",
+			.channels_min = 1,
+			.channels_max = 32,
+			.rate_min = 8000,
+			.rate_max = 768000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_EASRC_FORMATS,
+		},
+		.capture = {
+			.stream_name = "ASRC2-Capture",
+			.channels_min = 1,
+			.channels_max = 32,
+			.rate_min = 8000,
+			.rate_max = 768000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_EASRC_FORMATS |
+				   SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE,
+		},
+		.ops = &fsl_easrc_dai_ops,
+	},
+	{
+		.name = "easrc-3",
+		.playback = {
+			.stream_name = "ASRC3-Playback",
+			.channels_min = 1,
+			.channels_max = 32,
+			.rate_min = 8000,
+			.rate_max = 768000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_EASRC_FORMATS,
+		},
+		.capture = {
+			.stream_name = "ASRC3-Capture",
+			.channels_min = 1,
+			.channels_max = 32,
+			.rate_min = 8000,
+			.rate_max = 768000,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = FSL_EASRC_FORMATS |
+				   SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE,
+		},
+		.ops = &fsl_easrc_dai_ops,
 	},
-	.ops = &fsl_easrc_dai_ops,
 };
 
 static const struct snd_soc_component_driver fsl_easrc_component = {
@@ -2234,7 +2306,7 @@ static int fsl_easrc_probe(struct platform_device *pdev)
 	regcache_cache_only(easrc->regmap, true);
 
 	ret = devm_snd_soc_register_component(dev, &fsl_easrc_component,
-					      &fsl_easrc_dai, 1);
+					      fsl_easrc_dai, ARRAY_SIZE(fsl_easrc_dai));
 	if (ret) {
 		dev_err(dev, "failed to register ASoC DAI\n");
 		goto err_pm_disable;
-- 
2.34.1


