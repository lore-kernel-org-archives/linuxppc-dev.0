Return-Path: <linuxppc-dev+bounces-17957-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C9DCEB1049
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2026 10:41:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVVml6ByCz3bjb;
	Tue, 10 Mar 2026 21:41:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773139303;
	cv=pass; b=YshzgHK+5xM4gOUG054qzjpscmcvhxLUjU4ehT1ksje8E9inBwG6KTfjS1DhzOQTPpYdGmS/+M2AirDZxMHhpIQcI/KJv/NSAIGb0zgMJnAK1QDkinSvQ5XRO9kdwFsnTXwTo8OXp9ZneGU6xvT6FxEa3z1QxrMlB+df/Ttm5dWxA0OK+udc1+Ui7YOcgma699N9lJrp4vy9dppYc1w+z/imnqvjn7Mq5bNSNzNGZd+d6d/ZxGuWly6CVptD/su02PGDlts4YnOmc/ej+FflKbeEE905alJxM3A1oqOPOv7c393oKEpFRUOo6iIyNnGQQQ2CbBlMRpKekC4rtCsVNQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773139303; c=relaxed/relaxed;
	bh=Mqoct+Vm5QMXhQBRQSgnKUd2cZ2iDlRzrdojRg4xlxE=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=B3U8qQ6DzOyYYcxHAPxLodIG+0BwtPxdKrExveXkedgD1OqR+RWLGYjmEvBr/Sg2LYmN7YxpQQdoAdjE3fG7p1/Jdrq6/vbQyQCiNVx3xuTdjuCdJm3N0wi23EOapIYegd0QDXlFyp2r3ZXlnyt7qGcP4INbUWM2SWOMOT42JjiqajIwN3+zU0d6VoJOcOEj7NNn0uKnemEhmY8ucw/70/XM989ICHFiiPoGU/Nd+7Rm2v8iMUVN72Da9ucDd+ycn1BFSF1LEoHms1jWmXiVjYlk+ohSbkJwDG51C7R+FJlpgwK8xtamAOpN3k4a3FhAAMkiIkdvXlPKrDCdYjsg3w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=AqL7MsbC; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=AqL7MsbC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVVmk3gvDz2yFY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 21:41:41 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEGXSJk/HEER3stURyjkq9ZPoTSC8l7c3rjiYcL3QqCJO5idZeyA5RDa/6XRUX/14BR4KPYRF5CciN2S9DjioLdxVkF/Dcu/9Zz8VmUbrxz7NFJtfjXeL06PEei0KbrpIR1rxW0f9GAeqyWtcEx4yMpawJwNMRiHvsCgkonunWMlu3GMgL2rs3lxnDS2em9Hq3JE7N/mA4WqcSl5IVlHCePYSor+aUCfPSC9PZaVV7Y1xlVPYCZiuI6kICGTQ5CsyA2niouZg9W8Gjup5WnUYQtUu0HsyCJSJwKaDMdpHgedTLvsOdsnwKGmAyYHbwDl0PYNRtfWrKk5aUaE7ePwZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mqoct+Vm5QMXhQBRQSgnKUd2cZ2iDlRzrdojRg4xlxE=;
 b=Xqsr9XX69zwLJpydsDOfz3JQ9oV9BhY7ILzkSO4EqVcn91+OPwFvg07y3olFL3ardx/dXW6hN0Syjnsp2HEeVR+um95F3ckdfh7XIdnbL00coz5u/4AZa2tws7V/f12TgY92mk/SOyld6eP+NFg9cfOOtOsPrTnRwFLUlgLK4tjbf+m1Jv7FGA2UXosHWHQEEXd9xCpF4H8zwCintycPPt/Eoko9B3wwmbuzjABPB5Lm3rEWNDwiIlbU40K1m4RvarnKEiWdNcpEox7QbyJlFiBlYTfK6K7dqLKROw426zyJyxKCmG7cDb5Rh58flYUKvlQKSbjBfgCljrH9JPz0cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mqoct+Vm5QMXhQBRQSgnKUd2cZ2iDlRzrdojRg4xlxE=;
 b=AqL7MsbCp4cXdO94D+huxMK7ZplnAYit3Czi+hksVDmOVMg6SNzTxdREIIhZFrYjWJ/SlJNIgWeBK4C3Jn270igHutgh2qmcn6K9V9vuU6RdFraDVUdhTSa6DBQk3O61GIsKIESUXSn+5mBBsh6jlIGr4Mmn/Dj2PoFVVixPhXei4Szuv5xabINr+ts4kWwOG7Umbw5Ng0q8GSFIpjubOr5L4RovU3Kp7HT75u8I+aihKVcvPlbGrR80I8batJBAn8U1Px2ESiP5DLv3if8eTX5n9wtor73YgQJrwaPna3QlHcS07hZyxG2MbDcdoWcMnH7YBiY1buZmbNe+Wurv3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by PA2PR04MB10279.eurprd04.prod.outlook.com (2603:10a6:102:406::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 10:41:17 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b%3]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 10:41:16 +0000
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
Subject: [PATCH v6 0/3] ASoC: fsl: add bitcount and timestamp controls
Date: Tue, 10 Mar 2026 18:42:32 +0800
Message-Id: <20260310104235.1234569-1-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:54::23) To AM0PR04MB7044.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|PA2PR04MB10279:EE_
X-MS-Office365-Filtering-Correlation-Id: e3cff3af-c70f-4cc8-af01-08de7e918ef4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|7416014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	CZhf8RjrAlF0z7LK36dLTWxhH+Unn+0vcLlZ4yPr+J8JCTPz0kM6djNRc7pvVVP9oeBRQsQn6B7HtEn+KL+dX2I8qR6N0DbvMbg3bhMTU7Ljw8uecGIHHF689bBNXoWM+SFs6VHd+2cTYsxDc4qCjbyWo4jMRy7gRdWT6ctQYhAgKKKYgaA8XIFpN7uiJme7W/gscx5ocKCSWAOwc9I/iOLAVVMOmEI3rEls6ILklnuGUUEQw0UZaLTpNln2o9az9XjW7kgzHA9HpObAK8j08PAZfelpodnksXqVHM5CV2ecYXkhaX4C4o6VV2B11CyvtLZYz89TDezC+VMkVM0r0py/bYhvY6GdUNMhTPCqcAacDFdRZKGPyB0AV9/mteCHhiVg90BJ6mg++UzYuBkpNEw7x6hbg9poUOah1bWIIFHi74jSRzA/j01MY0svBR0rRljehmqdiF2qTukLLVaQAglGaDN7oLzWEhPvxIiw7XBnj0D+ev4hAr0T79mdHjozt66ejt4NRNq8HnyTSftz0p55g+90983FqyhN0V9WFrT1bl1aGyzHBJKD7Kpil8uptmsCw5WRY8CVGmeYnA8mEMAclVw+KxQeSeYlLFwwfNXwDI741R6NJN1xpQvXuHq2HRHj8FMXVrfj7B5fv+3UEPtXKdXciTX0MRJ9MDtLAPFqSQDV7sb62BiXyuLggE8ZB+kLW5PqF5c4QWrUes9StBJ3bFB2BbaiFvIcY2arMed2ZvX2bmDh2uZ9M066mm4lorSr8XAjr9yd/GXRZzrGEGTjrJWhoyYyE9168F3P3ZQe5+LGmrh8HO577DZZrnDO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(7416014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0CzL0Z//pRbG/GniEtCGayXmuz7p12e8sZRFvETQ4Pe/65SOECUlSA+ZWgEI?=
 =?us-ascii?Q?Yg/y6wWBmcvkN0ktF1cVw+6G3dRtc+OwpZ/vYS9uS+tSLgUurr8Cmffm9Wq/?=
 =?us-ascii?Q?RPSEd/k6jHFxi4Cbb6FRlqF3cuxQtGlOFlQe/fXeL9Fzq46ViqJqman/NI+G?=
 =?us-ascii?Q?o3VJPTjIoT3Y3mrVBNYrWKFf4m4KBpkxMny+TWsTILQMIlx5M9R/RwgOd2hq?=
 =?us-ascii?Q?2+g77FfDta/NEsNXojdEhLKvbFkbouwNwz6hjRP3Jk+rG7Ipyw2hFEMwLBFR?=
 =?us-ascii?Q?r5UuYGty5JV5Vz5Ix0VQ4AmjDmGVm1luP4bk3j9kzkMlIh34WsEQ5sCUNDqy?=
 =?us-ascii?Q?72oAUnYD+IGPFQmko6TfBJkHbZEftcuGgzDMFSfpuZXqp/kG3ptMxaOWwVAm?=
 =?us-ascii?Q?Zq3UNbI9MdDFQJ1lfi5sgHZpaXAQK7k33jMqKcP80GPiTGTXs1piDt+QqRhG?=
 =?us-ascii?Q?fjwnCn2iI+jYPs0I6Q5gFyzGwqT/tocx9olK/0UqEJ48GJpi3FOkxValIsE+?=
 =?us-ascii?Q?cnmUSNlL00RvBIhjP5OSTcnTK2tTuPajjd7vTb1Ku/I9ZgLouHTmvUSyj0GU?=
 =?us-ascii?Q?svwjv6t4OBcHWJA6eSP3N8gxsdjQ4pIGYZfUFEnu7nDSGvJFShGg11+zcGH0?=
 =?us-ascii?Q?op8XPemIRCOw2OgK8rhBH3mZ6Y5w5zeY1egxCCebfhb+zvng34vABVlrJsYH?=
 =?us-ascii?Q?zYW5LhS2s60uZ8i6Bs99NFZGQGv08KuCrmiFn/fnUt9e0C4vxX1KialdQkmW?=
 =?us-ascii?Q?sXEKJSfDOYxXvUGruqP0mc5KIAud77kTZocjP2P5iajrYmSW6PbA0gr//jRE?=
 =?us-ascii?Q?sz38VeXvD1/9NAz0mpiGz0Hw0Zub7m1vmOtBTC3HgFmbSz0Jz0/dnY8PYaX7?=
 =?us-ascii?Q?R7KGbUA5ndcTb090VcByC8eUyBrMHvu4f9efT6SsvEcsgiZe+rGAsCR8EJGW?=
 =?us-ascii?Q?WosEMpuH1vD5lEXnRzT2BZkQtadxlh8hpaPuqL+WhGeQxd/7M8AwM7toCEjD?=
 =?us-ascii?Q?hiJ0DKkeku8qr5w1AftNxmAacfl5QEpYUsj15CKQM1r9jAApCwY1ec2R7oLJ?=
 =?us-ascii?Q?ihHWw8ukoQDfkfMV8LnnsJcJIibBpqrveixBIB9U9yUYGUzXcXINMPQK5fhZ?=
 =?us-ascii?Q?XBGCuOxETIxSjgiFhW0XmP/NFK4KaQkb3+2PMC8A4eqCJZ4zQKnXSygSkEVv?=
 =?us-ascii?Q?5FSRX7wdj3ojtBj/q6gsRcxnC4RtUEJtwknI1mQo6U5v9xQDFFP7W8te2roV?=
 =?us-ascii?Q?qq6NbT2J037fCFrS6RtYqZhopiSYxc5O2czb0kfIVb/E9nphGmfz88A7Pwby?=
 =?us-ascii?Q?kOw7pGGRke6RAfh6oEABkK06w7ak8Fgf6oPQn66LLYsF9y9/c8Xl2PXpGrBK?=
 =?us-ascii?Q?ssK2LtVJd/V52u/5oKjQppG6aNWWB4gjaPP79FzuAhEVtMCJ37Ymmkpcw7re?=
 =?us-ascii?Q?UAk6WdZbIfxTpFTTLVCy9VDPuy9mJJ36lDVKHAQ1Gk6i2/koAvaw7HACeiog?=
 =?us-ascii?Q?2U1ps49bgbn+H+eTqsNttFv6DRbAbbgGn8SOgzqTnFhGtA2lZ/68z4ZsctDG?=
 =?us-ascii?Q?J13YKxhqM7DYxY6kMzpdMVAtlG4G1f8OshqciFRGR347z1fN6L3VA2hPpAtC?=
 =?us-ascii?Q?BW+NCWPa77v44DYv9VcjM23qkChEUqivtCW8PhGKTSc0Qd+VZeCXEi6Pfdrz?=
 =?us-ascii?Q?T3AmSXwcGR+OJCGRszkPHzGiuZ6Rp0noiXbHHNd/Ed03yl6wgC67oSV6oTYB?=
 =?us-ascii?Q?6jCVXb9XZQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3cff3af-c70f-4cc8-af01-08de7e918ef4
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 10:41:16.8227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rl43GtlbA5rxmonnbj033+iRHnNh2WCaCaqwOGLqoeZGGGeED8n02X67VY5QV89iamv0m5uiztuqKvMv6KQIdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10279

The SAI and XCVR have the timestamp counters and bit counters, which can
be used by software to track the progress of the transmitter and receiver.
They can also be used to calculate the relative frequency of the bit clock
against the bus interface clock.

changes in v6:
- define FSL_ASOC_SINGLE_EXT and FSL_ASOC_ENUM_EXT, which are
  SNDRV_CTL_ELEM_ACCESS_VOLATILE.
- return 0 in fsl_asoc_put_volsw, fsl_asoc_put_enum_double and
  fsl_asoc_put_xr_sx to avoid control event notification.

changes in v5:
- use EXPORT_SYMBOL_GPL to replace EXPORT_SYMBOL in patch 1/3

changes in v4:
- use the pm_runtime_resume_and_get to get pm reference before calling
  fuctions and use pm_runtime_put_autosuspend to release the reference
  in patch 1/3

changes in v3:
- define own functions which check the pm status before accessing the
  registers to avoid -EBUSY error reported by mixer-test.

Changes in v2:
- remove arrays of enums, define transmit_tstmp_enum and receive_tstmp_enum
  separately.
- remove __bf_shf(), define the XXX_SHIFT macros.

Shengjiu Wang (3):
  ASoC: fsl_utils: Add snd_kcontrol functions for specific cases
  ASoC: fsl_sai: add bitcount and timestamp controls
  ASoC: fsl_xcvr: add bitcount and timestamp controls

 sound/soc/fsl/fsl_sai.c   |  66 +++++++++++++++++++
 sound/soc/fsl/fsl_sai.h   |   4 ++
 sound/soc/fsl/fsl_utils.c | 131 ++++++++++++++++++++++++++++++++++++++
 sound/soc/fsl/fsl_utils.h |  48 ++++++++++++++
 sound/soc/fsl/fsl_xcvr.c  |  64 +++++++++++++++++++
 sound/soc/fsl/fsl_xcvr.h  |  18 ++++++
 6 files changed, 331 insertions(+)

-- 
2.34.1


