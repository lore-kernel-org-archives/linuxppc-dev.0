Return-Path: <linuxppc-dev+bounces-24706-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21425C4453A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 02:20:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5FFx0Y80z2ygL;
	Thu, 23 Jul 2026 12:20:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784773221;
	cv=pass; b=HF54i3tmE0pcZKxAhHIjzPJz01Xluw04h4OngdHBK56ToDU2oX3SPwUo3+zSQfLrTb34GAJesmxGLXJmY0ZReMSYMov4YmWViJQUXvoj3RCCEYrl87g7GdOWEPtEDMb0MF2CiZuv2Yca+BtP/3v5jTkLas3uaoO39Mzfx6AUg0fEB7hw5HyXdwHJARzdb3TI2tyG1U0X/nMKpZmM71wXygFuFAdnEpYXfZP1z33jHYOr1fGSUEwSL20HlZMdguM5ipjKxkD/xEb4470BtNJWZ6GEPu5kvAT/vpJqAVq+81UEdgMTCoxko3o6PNdX5lAEDKuAs2ZA5IbS+2ytpNcOXQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784773221; c=relaxed/relaxed;
	bh=gwzohd4gnzgydc8pnQ27HyzZf77uVO8FACmnw7IqlZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xcn2f86nJDxaKnN+nQ7IkdkYbZ7wUY1VvmLBW3S6r32f6VlwqzNm/23m/s4oqhyG1EE6Aby3qyFRgKixeV87p4DWoYk7mRlofN/A8fRBHZvnwA4ZTgT9kQTqs9UrKTqjy120BE//CbB/9Pkz/ZiFW2Uw9z0iNgv5BkpG44GQZaSBbpVsgXf9TKj6kgYPodaZxeW0KJL9R/faRGPmfF1w0MKh+eVuleqUK7TeU7IqzEdEzivMm6ioftWJtIasg/CyGWpcJYzHaJQMRqCA1EymYa7kAF2i7Z/N6gTjNEizvZ7lq1YGYtRjgqflqhoKpUpYF8/5OZwjmcjzTLfF8f59Yg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=F2zpgrwS; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=F2zpgrwS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5FFw0GKQz2yrL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 12:20:19 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKtLFg96qOW4LczZK5A4sQVss3mmLB6ogBgUV0ekSrE3ot6TGDoKsnkqcqry3R3s77qWEK3UBkez25gOQxCVlxMkMyObqgox5dMapvC0I/fnR2G67E2QVsNsKd5iD9eky73WUo8vFnqQ6/Aa3D0VerZuOV2HiVo44KmZsn2Z5gV6LThuod4KyOLfZ2ZcJEf1rTkQXdc3PQlol6SmNP7l9EO/tE+99mESrytpRhYCiUetnWOBMaV9+mWWut30Nmkd/wXvTHIgAIj6q0r84KeY0xDvgyKTFZ8nGoQcNsfEmqYjYmvrDVwtfOuWO99+G9xx/HS6qlWzhfHeJBiqBGsSiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwzohd4gnzgydc8pnQ27HyzZf77uVO8FACmnw7IqlZU=;
 b=beOhpqxwfELwTW9h01rQX0YIToQO8YX5/xKeKotAddfP0eRUj5ZxXshHdUKVAmEN9FkDm0w1hik3kwTC4YqI1bBVkACLD405cYxnqoP1Ar1CL68KOChDuCmrRuerpOFLM8wnhJ8CS9uYuY3ktzvTZOvwCtrSEP13Gi0GPN6aaXLCs2Ok29107MwewZTLmf/K0V8hEaazEhNlgiq05eJHXdhiBnUKQm/wKKgFKuLknsE/KvajpiwXH2W4kmihnupWz8RlZei85twi8eYMDmSvDLxHBdTYLj+L6TabNiUkKeXXULC9jBCaT55wm0O5rCI5/6NFCd+RpYGuIu9mFM1ZGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwzohd4gnzgydc8pnQ27HyzZf77uVO8FACmnw7IqlZU=;
 b=F2zpgrwSth64kdiL0tghylsbPqNf5nAaTbx3OLnSjG6WLuCIdnJbx1F5cH/j/j97YxpCBGzHYW56snZeL6FCIGQ93aUecNtoU3czXAnoIuJMHGH8AlQBatRStvbhjg89MqkokUbwfMX5XuHNErKz+D2lxJVux/EL69OmSjzunKbmKLYuaY6l2W1UwlNyPfb7qG55L485NZxbUpYrSWjuPsFEuOUebwz70NxFetDjft0D2iEEuv3tMsdmT4VECeFOzEC9XZxljlWPm3kFXw30Dn1+Pnc4y4ydJ2CHtf8kn/vX+kIxUFbLEny0mBQJva+DgBjrnNiGhvpnKth+YMdbcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by DU0PR04MB9252.eurprd04.prod.outlook.com (2603:10a6:10:353::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 02:19:56 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 02:19:55 +0000
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
Subject: [PATCH v2 5/5] ASoC: fsl_easrc: expose individual DAIs per conversion path
Date: Thu, 23 Jul 2026 10:23:13 +0800
Message-Id: <20260723022313.1905051-6-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723022313.1905051-1-shengjiu.wang@oss.nxp.com>
References: <20260723022313.1905051-1-shengjiu.wang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0141.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d2::6) To PAXPR04MB9351.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 87156165-146a-4887-15a9-08dee860e303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|19092799006|1800799024|366016|921020|6133799003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5cegR5ddw3b2VdZRONhKF4uRifJ10vGTPTcSzUq0LJl83m/JpB8jbQvDW4vdFQ8BnFvU0cczUTXiRqqMnKjlC/bzB2/cQxZlogGzjRqhb5uB9Lo3KyPlddnWLFObZsbgVEg2wR8zyCLo2sKIK4cr77SYGb7GVor/Y+2PmKb6RvbRDBBFI8tNLh7JuAR7knHj05mHSkAIlnaZBzVRz3bo0oBL6Eb/akyEVUC6IghfJyK5LDUxu4Vi6EWYnOnbYvrcbmDN8EySNAdOruKdDkKmwSDvkh+Ck8NGFCi8aXgtEyCMxBgoRJTv90bYgZ1saHixKK/IMycvsw3mLQS9qNLcJ2iDa3UkJMjOSKrSuCHN8zwCXJcQTtJNo60TUSO1uOtj8yRvaMese3OdkSxsN5YS3rvuCgEZV7hR4GRuw56tkXBRj66LlY3AinWWkmieq+PlR7bf8rtCsNuDAiBuHoLDdpqYVGpoKj4A/mnpfPRKV6NWZuXXdutnQymULMYbokS892hOA9jva0h2AulCJjLfBHK/nyKj5chJund0mRlGZ2I9Oa2XRnkZN+c+HF+b4+kF0iNsLgJSEz1CzfPRFQr7d7jc3AkW5ZSJbNh1KStPVp6fw2mL4PcxvWK1C3GiUWcDdlAhfdHpc0YTt2OXMLeGYRfh+Ueche0g7euncKbCvBegcuN6dwUaPsqOHwAR6PDrqeinv3aH5rSCzeZqcKZTYg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(19092799006)(1800799024)(366016)(921020)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NttoXwrSW7xEzo3bfKTCC/LnzDLGDhBzPd42aneiCDL4zemNJkIRKT0esgLC?=
 =?us-ascii?Q?nwAVg/u5zzF7JlGHYRmo5zth4s69WUHJk/zR2VoRnP/FYC4WAY8Aqr9+Yj/z?=
 =?us-ascii?Q?HU0awkClh2Fo/snYkqFdIDT4J48SNP5pI13XN4HBqzKfbYxvQUC/cwrRa4/+?=
 =?us-ascii?Q?q2gal+uQfeKB8R/6hMA1SvWO2n6XfhpO4pOLxd3r3m6Dx57qpDbJ5Vd/Vi4+?=
 =?us-ascii?Q?hVo+dTyczQgmNCN9LE8e0MvSlfkNiPeYKD2xcbPOQaq4LIaDOXW4wNi9DAHu?=
 =?us-ascii?Q?/6VwViuUxQspWkuN9bsPPzn1LZWzitSS0H7bggC08nixrcobF2q4ELZslqNJ?=
 =?us-ascii?Q?GRMkl0u5jBBjF6FPXHpqssQZLSE0Qe3UvHnIERt4+L79zly++PpJbiq3AxEl?=
 =?us-ascii?Q?h66P/2pK+l1yGuvbW/Wezi4APLCfU6Zp473kPYa4ePZEyZVte0q6yKaKb9uO?=
 =?us-ascii?Q?2dfDk71bC/D4A/Kf6ZUgnWf2+8ost5fJK/jAt/vuPh6xe2m3zzekQfaY5OPi?=
 =?us-ascii?Q?Cxelb3FkTS8LTHeZ5dFtyzwRdMWTo+jS23FLR20jfXkJloksc5awR1aIY42z?=
 =?us-ascii?Q?G5LjPb+zFNQ0KoMJTOOCzru5+87iep7nhywtUwq4EoNouIb+Z665fneS01MD?=
 =?us-ascii?Q?nu6BGFGeWGo5velg5qKyfii6Gox4bYYqWo04dSUISuDFnPdNXZdCLGMVkcGd?=
 =?us-ascii?Q?IEqIISwUvfjNXBlph5yNv66dyx95DKesxYkEBpt9bFVFwWiYccQDR03IZezt?=
 =?us-ascii?Q?1L8zzWr44zTaA2c7WlXAj1cd4D54HXAbtjGWpcAS4CUEM63qBVjfBH+uPGL8?=
 =?us-ascii?Q?pK7/jG0+hQxcYWofu2mNMdHOadoAj1HohHGRzCD0s56rZhK3XFiGzJ+pC/Rs?=
 =?us-ascii?Q?JDdRssAgnr0glYzdxcV5ACTpmMeJNVABvGGgvkbYa19kn5Ah8neTcaP5FKwH?=
 =?us-ascii?Q?1lAJHaD6/V1oRb7EYLpU6LfJSRlnYLmETI8dLsWWCetd4mDi7I1WPKXarwB3?=
 =?us-ascii?Q?rHivSQZrrGnIn6wPdbmqrw1VLpeF4+u5sfjNLgRIrI99osPNZPcTI2QH/lY1?=
 =?us-ascii?Q?pmmfkT9L6op4yRBOT0UqyhOySKnZmlt7wEt7kWQQvKsV7qZSIXAReqzB8xSN?=
 =?us-ascii?Q?a7Ns3yepUuaefoyCpLTzjQO6w6PhvK6QNt07AmlQ59FIZ36qLufZ42BD+MJf?=
 =?us-ascii?Q?2WJ4eD2Xxbnl6uOT1oL0oC7Awk0fXjAOCirwYUORYQ+RsWFZv6M8q1tiLfic?=
 =?us-ascii?Q?Zknj9jMUmm8rbc0pglm34la9v5Smhek8IstsX+gXLNM85IKAni0WPZCnbpYQ?=
 =?us-ascii?Q?9ouTDznxCsQfJMtsvBot8ueBWwjB3E9pIXoh7J7tp5TyXMJukF13aW5tvufR?=
 =?us-ascii?Q?keo7cIgSnSSqIlhNEKf8UoQqZ4aH3zutHaDWMx/HVdR1RfOqPQ//ZwQm5IrI?=
 =?us-ascii?Q?x8Z8UkzjEmO3CP4q0sw4DQhVsMAJdS3MxHleuOT4tqkRUuxxCR5E2Cei/8sa?=
 =?us-ascii?Q?RW1nETRAS7AVBvYs21ke7JvLGWZ8UowdG8hGGXTgnF6njVNAlamGMN+IlcGT?=
 =?us-ascii?Q?bdTSYeuAh1OKD4KVk8tSo8sBXCZKaObZfnPHqJacc8bV3/JmElnD4jxh2dm8?=
 =?us-ascii?Q?cu1gVkRfPc7L6MOSA8qBaG/9ctj/RqJMnoIsVHykYYaicmCKmoiJOOXknwkG?=
 =?us-ascii?Q?r40/DXGzSWXzI18v5lXWvH3BP0Xtr07h8Q6RmeOgExAO8iZ+bX7eIKb9ZPPj?=
 =?us-ascii?Q?jEqS+2jgv3BfcacgHbF6PlXpfo4/7OUyyWUHfBC6Ea6PDYPYt0LB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87156165-146a-4887-15a9-08dee860e303
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 02:19:55.8142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LzIp2vl/d4sp9qEGA2L/ny8LprmmtWMW8AIE6UM9wez3rg2lkP9Uk3W54U1WU6mulzAJ+I4Hxz7qrAc1iLwaUadF5oHYMj0GAGvUtZ6iSwAGa91fzyDPdyDKYXzVRqFk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9252

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
index e68f6cbdd653..8571fa0bfabd 100644
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


