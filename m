Return-Path: <linuxppc-dev+bounces-28771-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B424CA5FE0
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 19:23:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxJbS4JKMz30DK;
	Sat, 03 Oct 2026 05:23:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790968996;
	cv=pass; b=bIh2f0PYJUgLRjAiejNy+yhgL34WlwSdU+fXiXAr7tzUAYNmCJ6Jcy+Mh/dZ6OuQebpdkNITuaFqDSCNLLZsiCfG2hNzCzSshgJ8LDCZp+SXx9mVrMBuexQI1bnQQQiM9Y6ztbB+8ktjUI/OT/npf9QwX8FEcsplZUuahFZIRujxLhh9TeVol63a3vWLuCOk/NTrdM9Y+zSVTurT+hJ6eKZsLr12zzYVQA7T/L1GV2ldtr7Hih/iz3QcQOncR63HQueTsr9VLGDzL5iDJBFLu8vIKBeuBpQ2+1X3qCqN/QmHxxotd8q1NveuQ8+rmCKHFUFhuB8+PTFqHP8BCEtwzw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790968996; c=relaxed/relaxed;
	bh=MlMGaqKAsgQFgWCXAYibGV/KOxVYgv5A6dZveyIsXiU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fT8EBhrm307CYEzPXIoX6HKP5RGsyWIpS6ukSh+2P1P/iNX6wJXeArb7gczMItB63KMr9LdC+zAu45fC5oXx9OKPZrCit5q6lrATLK8d7IKIt6Zkz+qL8icysezW0IxvpkoK88bofK5cYzC98yUKbrhllGDmWbxP8HPDGKTEm1X/94wIoTKQrdTHso34hpIa7EBOrcPd5VbtaeLT/LTLgP0XaEGzW4WVuGNVHGRbtAhDIJ+TFBzuraipjHyEpi2c8eKEPbBg1/OrS2zjgtweXEgjPIRpqdklI1gLyU27lUJW5O/GEKf4h268hXk3DbFlArPTiH3ISfoVEMWSdwnJ0A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ZGNA3sQK; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ZGNA3sQK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxJbR03Xpz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 05:23:13 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aVsHl/lcbfVtcxjKJ2U6u0toH32h93oYnALFSSE8AU0CVmESfSnCPpGllacnd1Qy68ppaplQyixUHHa+9IVWUBdIM3v1GuJMlq+xPJwOXNm4GeOZuZoIzigxZsIuq0wR2ydF80638R/P8fv8BOJe+ENHM2PIIQV5zQ0H330uYfEvZqeURovwilV1RLoH3MwFre7Fy0hjOZBnrc8UXgbeXbdzQMpPPhG7ZilW3uw9sXU2iWBu1BTlCEM4pI/hIxX+eByiXZ2E2lGx4suIVhiu5+iOFT6zLtZK37Ru75IgdKAg4jgMlmb3IiX1AX2LNRkZChMSHugDhkqtVqQ0l0/KWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MlMGaqKAsgQFgWCXAYibGV/KOxVYgv5A6dZveyIsXiU=;
 b=twcYMvO+UVGNUs/syuWGwqWcZQksjzmEa3f814mYz3ngpyUz76PDQIlbSqQK99QOSPYHO3ig3ApUgwmfm3uTdMR+uh2gQiJnoGQtf5Br7Fh0jtpWnIYCVbA8ValkFu4of3S1InhxQJLkVgSNWKMMoHarjIZ7Ecw76QSW6ZvG6lrNNHj2gKFeJfzMmVqjdYksZlz27HlQ9HxdHybUfLMq9DDoJBTdAW7pa4w8NWaDl6pGlAomAhZ10aRGA+HNhDVTCudbQYodtDKspEHGF6xVXC3PUCvs62DRQv2ZCz26scRbKQ6DWGuyB6XIDh3ozmam3fw0gcMLe0zP9rV40r8zkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlMGaqKAsgQFgWCXAYibGV/KOxVYgv5A6dZveyIsXiU=;
 b=ZGNA3sQKVblA7lHd8l27MpMeJQ0vH35RTkjQx62spOxFbvEY5wLwNs7GKuyiHO6SKT2hos35yaBVA6sq6clY6CXXOSsaoJCGOv2/4zMQj5X0397irC2YTmau8vaNnRUmMOufvcv9Fu1W1IcxziNS5lQ83qDW9O+Wsi28xhrnNdWOgKeiaj9reiB/gIpWerHNO6PaOGUOtmFAE6wTRewHpFsPxApPWEebCVp4Cel2eXK1MDppbRFz8zoNy/RWNWmKpTGC3v8W81pxxjC2H5qLPwthKJ176olvuhOWQX16DT4xd02uSWP0uVQz4ZivttOi/5vPlbU5/6CI8fOAsjgSVg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by MI9PR04MB056237.eurprd04.prod.outlook.com (2603:10a6:290:d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 19:22:48 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 19:22:47 +0000
From: Frank.Li@oss.nxp.com
To: Anatolij Gustschin <agust@denx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Frank Li <Frank.Li@nxp.com>,
	linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC EMBEDDED MPC5XXX),
	linux-kernel@vger.kernel.org (open list)
Cc: vkoul@kernel.org,
	imx@lists.linux.dev
Subject: [PATCH 1/1] powerpc/512x: lpbfifo: use dmaengine_submit() instead of ->tx_submit()
Date: Fri,  2 Oct 2026 15:22:33 -0400
Message-ID: <20261002192239.143422-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P222CA0021.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::33) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|MI9PR04MB056237:EE_
X-MS-Office365-Filtering-Correlation-Id: 720e29b2-4790-4aab-6473-08df20ba8ad5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|19092799006|23010399003|366016|921020|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	yoj9E7ShNRTAIIZr2SOWPmWbiH/62X8SGskN6RzxEA93aXdNyaM6vundZSKcm4x3OXj3x6KphDgg+eFIO2Z2ZIFaUDFkg6+GmJzwutWXwYpVQAHxF4YiSnjOpQvjaF2kBUhKs7otj1ZIreGxrRBfzy0PE+5V23SVcDNZkp2ZzkXuz23eespBVj2jhb/Tl4JorVyEQgMuqhw/WGs4/MktflZ5J6w7erT14bgx3Jvv0/Jpx00tw5Y4z0L3mlVSNqkoQ0THnfOVw++EyeUyQzlDC0fJl0zn/CKQxvw4lXJLeGXZ6wisHftreAfwcyBackC0MXULOKTA5RLg4rnegJXPcnQ7s2D4Nmi6ZU8iHVmmoeipFPzSs2kELikWaJiBOKFMNjqr7NAZu1tHa4VZO9o1Q1rC2kpPubUR3dHvrfaV3475kxp8MotV7bk0TglAfETqDCsUAyWyDyK28XXmHcT2lquIPH9YpXvjrNTMHYzXEKxJB7qw9Z6hckZziXOBJHq9CltDBvvlDLd7JRlqm/gVptV0t62+L0Lws1hZqSPkvLROLklvR2QPhttltIgj3G7Z6BW/E06Nl2APyZfQyEJ5n7217NdjIwX+EOQsxD52G0d7OZWhFiT+Bu1cnmooutjoGm8cQLwPV25Em5US+4Kdh7/KnGC6oPG+sBG+tkGdzdvIKyXRJs9VspJlcWN/p4PRb0IMU7Dwe78Tpr2vIdLU/Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(19092799006)(23010399003)(366016)(921020)(18002099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QBLGvCqNEhY7OQslR1SnjE70KBCXUWDHIaT3/bqD8IAHMfg0BCq3y62JtZuy?=
 =?us-ascii?Q?31a+NHdJu+TKkUibcsULscUmFVTketgnbjfohJ4CNOXA9xseKUKZaLu2+4EE?=
 =?us-ascii?Q?CpT+k4zRwr2r8EKwvauNV9whzB+k8utkOtPixtcPxyKyFoH5LZ1NSUow3VWc?=
 =?us-ascii?Q?JxzBkh1YSbSTNY/nndVu7WyCOHD/cVSsRUNrs70cNFNnnbLGBesQN8NPFaWP?=
 =?us-ascii?Q?ae1o+LWh8vhCC56yo5SrHcWj4Xw8JP/2aLNdrZEYK53viGnZtRBbgFlohJUy?=
 =?us-ascii?Q?f3tPNZzf6sQU5UsivP0MnaT4dpnK/2S6WDPT6SpxnCqHYQBKvrNUXmb/C1WV?=
 =?us-ascii?Q?aaEQs067quzEEMwWC1BYonyJsq/UcAG3vwqnuLouDBCu+sFk6os64Qz9GtOR?=
 =?us-ascii?Q?j8QJAMiX4GPuJw+RKcFfNzAJ0tUM+8IvX8o1U1KZX2TuyYtQG7Ql+eu9sVtI?=
 =?us-ascii?Q?Sx7m35tFWywERjReakhAU1nPMRY6Gnf4R4MXOMIkIyfrQnVF77uPEoEoGen1?=
 =?us-ascii?Q?sPLcLNskNw7RwumlUReJ/RBaZynoLUEkqIYnt3ACD46X290NxejefBr8TGdo?=
 =?us-ascii?Q?KW2WwEytoaS9syn9P5no4tO70RDAdTz2FjbJjRbD6JSV+fWfDxvf05D/MSI3?=
 =?us-ascii?Q?nrSskAoJrl3482BGbQmjVM03Jt9Rxu/ysK694Y+hqHQvUoX4wTRroqFr7tlH?=
 =?us-ascii?Q?WYbugG0CzFFfCcDT7xfcBakuDi44CbGOo48XIBLf82wLROYULqS8aWdt8UjM?=
 =?us-ascii?Q?rPkteu6vCb1o6pEOqIGPKovpGzPsNb+eK4XYduPT4rovNdrSICFDILhxQ6qw?=
 =?us-ascii?Q?D/+aLUU9ns7boali/aKXUphRL+0jrkC7JswR1UpH0w5G12UWs0JB11iqN5AU?=
 =?us-ascii?Q?d/m3ErxxYDv7+unwp4f39I/cP5JXBSQ6E88zdNo5Kz9W+WCu9PhEVrJzs5sJ?=
 =?us-ascii?Q?KS41ZrZJJoYvnsMSGUvUj1wwD58GF3D+l7/8qeCNvefDbBwDLMkAyRAp7q/A?=
 =?us-ascii?Q?Ea+6bAf40XvuNlhcqNfy/8MVWVWxt8doGG1S0YFxAdBe9Y1m8Yv4ODd4OYes?=
 =?us-ascii?Q?PWTR1Neumm++eMuoI+cGMMJKCREzrdmbwvmlmVsH+r7DgOekymtqNxN8Jdb1?=
 =?us-ascii?Q?wFRwj3sXzXWjQyCSuWnkaQq3V7kANk9aaAtKYvNrkdx4IMY/GPRs2c/odkU2?=
 =?us-ascii?Q?/O2uh9K5NE91BR+AMFVs3g5ZidVs9pIHLjmAgbswey5YnFUyhYyIaxKmBwsr?=
 =?us-ascii?Q?/pvZTrfOo5p6G+r6GKmsvoYnisqtvVf9EJ2DOAHpE4ailoJblB/84EgT9nuz?=
 =?us-ascii?Q?8qgmUqB1s29yUETEOyzK5iZ9UjJwke1CQd3LizpDkHflXAWzOVqMcnnu04/5?=
 =?us-ascii?Q?5qLOCrh51mm15+jPiaE9PlRqs8Dg1pquxVJo+noijnOop3jtcezIdxihVe75?=
 =?us-ascii?Q?qKEVFRWqPbwScWZjfwSa1+FP3gqUYY9XorItBty+ONYGxwBgjZp98yVFCQDQ?=
 =?us-ascii?Q?DszIdxfF6HeVA1+vkNla9fTz7qdn5eJLKPEabSz87I7NkEx+DCq9BKGHmFUB?=
 =?us-ascii?Q?6Em+DTJfEV1aCyL+d31qF9Y7Q5BSMg8RuKsR0Wn18ORfHTX7Dg0IQqaqLurv?=
 =?us-ascii?Q?nDIDme5Ub+1dAKdnPGmuxvps/6QdyYmc2TD0tGSFViV8T+Wj4gJmKcxCy5lt?=
 =?us-ascii?Q?4nZdaUBrzIlgaO8TMBRbyPF/VHLGcDTsnlmY3ub9hDvGL+m3Ju+liaFLtM4z?=
 =?us-ascii?Q?Ovyjs/IOKM0a34qqmj+gr8pos6HyxibzfghDdNlrmJ7TeDsRINN0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 720e29b2-4790-4aab-6473-08df20ba8ad5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:22:47.8815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tx8fh+JFQsVJNatncbogIW8x25hjzq8DEIxVjcktORCbg/GqXksE3G6kAiZ7pbJdEAZMiXZ0hTqRx7OKYo6USGPDXARL+92KPloBvb6itqQJMwLCV9grXaFP+j8CX9sZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR04MB056237

From: Frank Li <Frank.Li@nxp.com>

Replace direct dma_async_tx_descriptor->tx_submit() call with the
proper dmaengine_submit() API wrapper.

Assisted-by: LLM
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/powerpc/platforms/512x/mpc512x_lpbfifo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/512x/mpc512x_lpbfifo.c b/arch/powerpc/platforms/512x/mpc512x_lpbfifo.c
index f251e0f682620..5f1f8310c30cf 100644
--- a/arch/powerpc/platforms/512x/mpc512x_lpbfifo.c
+++ b/arch/powerpc/platforms/512x/mpc512x_lpbfifo.c
@@ -310,7 +310,7 @@ static int mpc512x_lpbfifo_kick(void)
 	out_be32(&lpbfifo.regs->pkt_size, bits);
 
 	/* 5. Finally kick DMA off */
-	cookie = dma_tx->tx_submit(dma_tx);
+	cookie = dmaengine_submit(dma_tx);
 	if (dma_submit_error(cookie)) {
 		ret = -ENOSPC;
 		goto err_dma_submit;
-- 
2.43.0


