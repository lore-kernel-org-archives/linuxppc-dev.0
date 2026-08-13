Return-Path: <linuxppc-dev+bounces-25798-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3624AC5CFEB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2026 06:54:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLGLh2Jrpz2yKD;
	Thu, 13 Aug 2026 16:54:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786604076;
	cv=pass; b=WILcdfrRl2hHC24uuKBkWAR5IMPFPeeh9NYR0EYxwwNgRNXZNgl0M+A5hrGI4KHeVIHUT+YCcNaw/wC+u7KV7a0hXJElj2XvbQ4ytVIcdAkpY4CGIibogOoVH2a811sHD0LwzdXojZujyyJnqoicgWJYtK1yNdef4GWwu6SykM0x5b9Hk/NnBTeoSic1CpRy3k1T9vbw1Q5vCKUqseGk6JvBNhMQLRuACJQ6VyYwWZ0I4SZdPooPrXcIaGqI7QXBuVrwrY4k+MJxOACl+gIAXU4pYaovSXsbQMUjPQNS7n2BiIQoaRJFdsOe8b8POWlt2d8IPqbGo0uaRsrB9JtBjg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786604076; c=relaxed/relaxed;
	bh=QxsVjUO3n7qu96c8kSzwa7pF9ty3JYbslJhA8kzlW/M=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=JceBAtPcDrIRAb+Hlzli6phbTeDoT1DCGELRdnS0af7oHf7HZCOQCjBqNXymYw9xY5USDxbTDa1rDXYas59TbrOUHUcDEMMi/TcuILJ3nLiI1F9Bq7yrPxtuRdzoDGJG9gdaPHvFTZc5bkjKSgQBLWbqySm6ms/ncxNhpBW7wAFf708BP3VxgpMla5oGO+jypzQmdGJSIZVkHCAakvKgDESF4ZpIa1VhuDehlN/U1rUAl31A731FRsDZVXV9W5xSj3Y6vI7yerFJADDZlMS7PihQlesvD7rIZCM1MZKgjUo6aLvyxW5NHMV+rOTGz/aPY7QM5tX+0w+t7FFcfU5Jvg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=qTa6TdOM; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=qTa6TdOM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLGLf5Bzpz2y0B
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 16:54:33 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z0fcNr6scznFH6JzkTwoR224lYTtzdMvI/QoeLQy+OWHaM/P1LsWRqp1voffHvnaW34glb7YHUH9FaJjGRXlHs+Y85PDAOEQh3LGp1u7vqyTzTDUwrbhvWxbOvIkv+bxCTxZiX/u8bKU7ouUR/FgGU0fxaABian75jbn4Z9z/O51Nz741KKlDrWrLnAZ4J/qemiDXNI4QBU+D3a04BsdGnt1BKL5ym97Y+l98UylaFn+wtPX5y+lIbRWx8sKHMrwjBOibdCCF5lsEjgSmRSNdfJDPkOPX5iFfcKIzPqzxfkfpu19Mr/tBj0DGU/MZ/h4ROAgrWan6MicBgx/ESGfCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxsVjUO3n7qu96c8kSzwa7pF9ty3JYbslJhA8kzlW/M=;
 b=dUj9NLBBMwXslujnLkIJp9m6SVCPVhsWs+kf8Es8TH18EAYrxilcGuC1m60+dTdlscPJuoKT9f8eZckQdplFfstUD+tGORpoV2XmVile1ACyhJE15QcJIx1jPdxYNug/sbC0g/8kpdhyukP7PH9tuCgolzY3d0Uy/V9wSasM4zEeF7OQgxfv/NjwOD7K9m1JgDdF7IXhLXgULzRhBVUzPVcbNTlrI9zuWOS16NIIN1samkZFZ6n6Maxf7TS596sYOrYAGdPFMEZ0ms0fR4N1gbT3WQEUQpyGDPKkeUn2n1tYKazGABC2XLMq2r/npitJ1JXctHWzdmobq3w7ZRBq5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxsVjUO3n7qu96c8kSzwa7pF9ty3JYbslJhA8kzlW/M=;
 b=qTa6TdOMEgOSrF7luNiBB3ruavoWe21pHv61JNsHEbw9fjiO1Yhp9/LMNRcQMPjxGcJfrKJcd+cp80toTJRfJFHyvfxT8HyeTAVKGxM+zUYihJlf7dFnZtktW9mTbU8Un2IfBsGQEqLReVzPdWzVbdeq5O6iJPxTdSCiCTa4dn/MSKizfdafFXf2D8dri0daBqu9JUbUhbiB2XABJ5KwPg4bOaiXK7neTzwy2CnGuCXLgLjBtJ9UyUCHB62wwKD756NggCT5P+QfMCpOsQKoYX01PXVpAhL6dhwmo69Ftp/V8rRyPJKTlXyZs8Nyf415xm6/SnI9ARD8XW+ikmDfew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by AM7PR04MB7158.eurprd04.prod.outlook.com (2603:10a6:20b:120::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 06:54:10 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0315.012; Thu, 13 Aug 2026
 06:54:10 +0000
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
Subject: [PATCH v4 0/5] ASoC: fsl_asrc/fsl_easrc: expose per-pair/context DAIs and fix DMA race
Date: Thu, 13 Aug 2026 15:00:15 +0800
Message-Id: <20260813070020.719810-1-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0132.apcprd02.prod.outlook.com
 (2603:1096:4:188::15) To PAXPR04MB9351.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9351:EE_|AM7PR04MB7158:EE_
X-MS-Office365-Filtering-Correlation-Id: 7437f854-e7d6-4d0a-5bbb-08def907ad01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|19092799006|1800799024|921020|6133799003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	GB4OBb9Ud4JVHYiHl0dxt4h+oXllZAloFiXFLoiyofNnUWqcfEy2sbgPTOpmzoBeLkBEoXZOX9nvP51Ty+Qfa+fqwWbT6oC4mV2I26MlGht1C1wvL2sDzWGV2tagAaylIN2h57pqT13zZcqmipzStKAGWaI3NVQd1m7MKjscec+E764dNY/HYiS4bJCz4Gyn8JNtUuNtnkvLOk3sdyqxDVAfb/vgE3tGld0gNU6K/+VQDIAVCTB64wUCB12aH9p15WSjDpL7NLWv1OVDoiYXdTJqpSQyvbbJajbNh1nI2nu5qkw/joXlVqlxn24tDyrGLBMuiN0b/nKtJGGoVYMDjVmk5TuHpnScmS61MLveKoLgU56HFI/L7EMzjvvk/8GZYborgx50X5jX+Or/GyFKciGaI0Eytt+UdGmOMRaMvI1Uotx4CY6Az8rPJLL2+R5zsX4W2qlqzqdffEGlFI+Kcb9P5TcjkTBmwcEuElm5s05/DlwfT1vg8OB67/VuJJkQVpFse8DFvNWwln3knZ07nR6h1ijfRgX1fr3JU2dVm8Kq2n0KHWQqZLqRQwDo4fCWj6Hcb1GuAqvwZz1m1gfrBE/kSSRQybueU11lJxUtOSsrGp1VMsnxHfaLFIMvbno3+kn7FrrjnSGExi8xKxB54EJ8sDv5rbjpUwwqvcJ+Dx9PYNbCPQf5kLlDm7ZeEO4r+AKhaeZ/nmQVJWLdC0NQcA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(19092799006)(1800799024)(921020)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ef4dK8a0fg4c0Sz3HsZ8AxzyiB42u/zysfSm1CJm692/Ob+No+EK2RpLyAPC?=
 =?us-ascii?Q?KkuQisaOMeAlbH+7/H5QF2hj7H2m+hUarBHJPvqgGg7d2ciUYR/A1kKI/Ahy?=
 =?us-ascii?Q?4L6k2hgDF/d1jM2MVmA/TJw9xLrh8UJQGvMO2LnEUM0j3xMMEme35IGOSwB2?=
 =?us-ascii?Q?KtYNZsQt3tMMPPxQTsQu/eQujG/b8vEqcQtZ1YLG1Nay712qFxzkFAhFdKFo?=
 =?us-ascii?Q?gaQgoRWSpRsLrEu9LGeGAZFCotPE25KipFU86bWybdero2aNMwM9naAP/eHE?=
 =?us-ascii?Q?VyR3OODlntSKGAXgi6DI7tImhhsScTj+De/K1rgpcUYM8hgYQa8k56jpX2xp?=
 =?us-ascii?Q?h+YeaQJg7gyuLJykH9Dj9N/z0mgBx7fMrU6i/PGjoMYqCPwe8/t93JqC9q++?=
 =?us-ascii?Q?m5sBXacjhsXmTRpT7JtcThV192S7dpMI6zrNgPVR5Ol1Y/Nd2wJeV63yCLsQ?=
 =?us-ascii?Q?v92+WbTNTkuvG06F7zhquhqWsD7jBdsWLGw/B7Sg+cAopEClhaV+kNXq8kBQ?=
 =?us-ascii?Q?VZTWMWw/Chue4jtWZB59ZzFzNYVFbDH4eHmqd3k0Hiy4NAXGxEeH41eSnlbe?=
 =?us-ascii?Q?0e0STBDde+H5zxHKCOgcDmxh74BeHmg4US8eSc+p08HfKrm/wgxW2rjsvU48?=
 =?us-ascii?Q?SBcToezRFM2Lm7fYxXWuWiFEn5D9PXJUuRnERMmpzBbHae/UzMbDVEl2abkl?=
 =?us-ascii?Q?3L1dz6SPABKoxgOp6BSC8vnqnMktPcLlHqf16Eqz2tpioabF3wSboeKlV0gE?=
 =?us-ascii?Q?BkafobQLpfpmjm2F7l153h1H0rZNzi0wMRDSL/YsD4j0f4NLtdEjR81su0Rs?=
 =?us-ascii?Q?5InsTswbmr36+yRZUzanfsoxRUpdPcy51IoUEja1IiC2odP0SqrfBCiSGTNT?=
 =?us-ascii?Q?goipcxo2NVDcLQjzoi3pCzumLnAyKtfiCQsYOOqjVLWHfghEk49R1w6tQq+I?=
 =?us-ascii?Q?hqWcpfW3ipJuT51D9JWOcrAHP+U+aYsSJNsmT4BNRF+RcvwBLegPW7vJYHde?=
 =?us-ascii?Q?ntAEKPqKGyKX+4IinJm0HWjGQAZ4Uu22n+FsZPGKrJ08ujO6aJjvpBCGquBX?=
 =?us-ascii?Q?UbhRtWemLrlXGM+wLp1qI+zd8hRPgGEax1QZMVLGHpNqXhUP68wzYPDX5Ni5?=
 =?us-ascii?Q?WXmkSeWfuLmn2YGkodCOi80eEhCfNTJ09LaHaDO5sKSv0UNgOXtL1S9USFLT?=
 =?us-ascii?Q?IK+6RDh1TZPEtGh3IAx+2jUVJPhpvSbFHcglUAjnhSTDu4KCqBqcdsHPw7aC?=
 =?us-ascii?Q?6nt92J96Aj1PUvfCyb6/KhxYa4QbGDhmJi/5HlfFV5W1OUMpaVvD57rKnTMq?=
 =?us-ascii?Q?35D+tCyOSkHA5VJdAjM2xI2Rx7djWfFRP+ms/ZqNEqpG02VyaU+w2nZuYHm/?=
 =?us-ascii?Q?Wz2HrHNFh5MHK4dFq9h+i2o0Gv68lsWuqOhEwabbFr3sMWvDfgutQ/O6tNXF?=
 =?us-ascii?Q?ui0veGSTPEWGGqucXu3qzzWtj4JFSgmooSwxXmPSOz5xra1gdDH9kKW7+jQL?=
 =?us-ascii?Q?tN0UyHIHIxXgFyvou8rO6xR5EmEuDux1fwR+Lvj4LfPMPCK07NAZWPS21oMM?=
 =?us-ascii?Q?ZjC1YX+xPaNwlUhFFIaik6g36f1MP8YEmAlnXUAkf1A5/JFDP2iDH594iqGl?=
 =?us-ascii?Q?Zm1B1aE9F1RnPz+xqHP0XZwkctTfgaY7Z86wKfXnxXR7F8FJJYsBD/9CqHdS?=
 =?us-ascii?Q?/aNe20XkSqT+aUopZbqBIPOUu8m2UtlshHvrneZ9Of6RnebrW3A9zMJga9OF?=
 =?us-ascii?Q?P9tk26OD6AuF9Xfsj7Z97gzmc3wP4T+NebMPbXS/8e2KbY04NlpM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7437f854-e7d6-4d0a-5bbb-08def907ad01
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 06:54:10.2175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yJPU+bukoEbJbjvzenpZapCdpzqbSVHM4TcGjkBgt8BY4YnmZn9sQTvMT1D5lmER/le5znS5hXA26S59BeU6ENz/80OGHGRauKLgFrLMuheM6j8aYojmmI1U/XL7mpyp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7158

From: Shengjiu Wang <shengjiu.wang@nxp.com>

This series extends the i.MX ASRC and EASRC drivers to expose one DAI
per hardware conversion pair/context, allowing multiple independent
conversion paths to be active simultaneously.

Patches 1-2 update the DT bindings to add a ports container so each
conversion path can be wired independently in the audio graph.  The old
single port property is kept but marked deprecated.

Patch 3 moves dma_params into struct fsl_asrc_pair so each pair owns its
own copy, and registers it with the cpu DAI using per-direction setters in
fsl_asrc_dma_startup().  This removes the per-DAI probe callbacks from
fsl_asrc.c and fsl_easrc.c, which are no longer needed.

Patches 4-5 expose the individual DAIs: fsl_asrc registers three DAIs
(asrc-0/1/2) and fsl_easrc registers four (easrc-0/1/2/3).  The first
DAI in each driver retains the original generic stream names for
backward compatibility with existing machine drivers.

Changes since v3:
- Update commit message of Patch 1/5 to remove reduntant sentence.
- add Frank's review tag in Patch 2/5

Changes since v2:
- add ports example to original example case in yaml file as port is
  deprecated
- remove the label in example.

Changes since v1:
- Patch 3 is new: moves dma_params into struct fsl_asrc_pair (one per pair)
- Per-direction snd_soc_dai_dma_data_set_playback/capture used instead
  of snd_soc_dai_init_dma_data to avoid clearing the other direction
- dma_params_tx/rx removed from struct fsl_asrc; single dma_params per
  pair suffices because each pair is unidirectional
- per-DAI probe callbacks removed (startup now sets dma_data)
- Cover letter and commit messages updated to reflect the above
- DAI names changed: paira/pairb/pairc -> asrc-0/asrc-1/asrc-2,
  ctxa/ctxb/ctxc/ctxd -> easrc-0/easrc-1/easrc-2/easrc-3; use index-based
  naming consistent with port@N in the DT binding
- Stream names changed: ASRCB/ASRCC/ASRCD -> ASRC1/ASRC2/ASRC3; align with
  the index-based DAI names above
- Binding port descriptions updated: pair A/B/C -> conversion path 0/1/2;
  hardware-agnostic wording to match port@N numbering

Shengjiu Wang (5):
  ASoC: dt-bindings: fsl,imx-asrc: update port binding to support
    multiple paths
  ASoC: dt-bindings: fsl,easrc: add ports binding for multiple
    conversion paths
  ASoC: fsl_asrc/fsl_easrc: move DMA params into pair/context struct
  ASoC: fsl_asrc: expose individual DAIs per conversion path
  ASoC: fsl_easrc: expose individual DAIs per conversion path

 .../devicetree/bindings/sound/fsl,easrc.yaml  |  45 +++++++
 .../bindings/sound/fsl,imx-asrc.yaml          |  45 ++++++-
 sound/soc/fsl/fsl_asrc.c                      | 100 +++++++++-----
 sound/soc/fsl/fsl_asrc_common.h               |   7 +-
 sound/soc/fsl/fsl_asrc_dma.c                  |  14 ++
 sound/soc/fsl/fsl_easrc.c                     | 123 +++++++++++++-----
 6 files changed, 263 insertions(+), 71 deletions(-)

-- 
2.34.1


