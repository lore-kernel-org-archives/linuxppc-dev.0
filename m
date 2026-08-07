Return-Path: <linuxppc-dev+bounces-25545-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287BCC5AC7A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 07:16:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGb6W1GnJz3bps;
	Fri, 07 Aug 2026 17:16:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786086979;
	cv=pass; b=bLyhTtI1oao8mi9Tf0r1xi4tDxQCyhtPgVVDt1cPL75Dd2SCeg4zy+9MnbYgAeYRLflPNCjYylJO1ocDn9hkHUd1YxtPMb8QiIOzUpJMBLVH8jFrEiue7TU3TvXAHEck+MjvMlmR7Q16EjwYlfjCAYfp3exlPdMPvSlckkW4nzF+2vgJyX+7s57Di1zeedvoEzy5w0lMptRtIx6l1xdCtIZXfsBwx30j507qbTEavp1ZMtJFZfelhJ9zhu3dn/MSHZ/kNHFhLWW9UYp9qyaadFMTdnlhDX1NVbIlmsC6hT7KxS9rIQSFdE7TxvK2bLGfBSdhcTMOi68ULVPamn5DNQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786086979; c=relaxed/relaxed;
	bh=T1mkhYu8b7Ydfeg37IauQHZDhCbntur7SLAvSAgt3OY=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nTIvlPXi90n2edSFo0Ei6OFWH6eAeMRsI/gT8wrpBLfnJTsBQeY2frdxy2bcLGL+zmpK1gH3HXQsv0vc1nTvh6YUfC90ricfTHnaJQqhHX4SnavQtoB0Hv4UO+HMisLs6N6aX4Rg2wivDi/8MnK7zJqxSjJ9M8cfsl7l0x0uZirMCy3Et7nEf6Zwku2ddQtLcJHIjGNl4/2hnQRtB7eszqRdzZV+4xBkrchVxTFq9ZiUbFN94GMkU3xFJKvsxXV9fEGJd69AM2VNDQDf1Zmrsvflu6rY37XcO8haoxXzU/NP1Udc0hh9V1hxe7dMgX2AhPFkwhhf6m6EZp4oBmH2Bg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=gGp+q6E1; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=gGp+q6E1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGb6T5Fydz306N
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 17:16:16 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSk7UOt7Fb2KyLgLaom85DOZlNPJgGThfNnKkz7+8hlynFd4EpPKEMt9ST2J5fN/1ahOT+Wv7S6p4eDuIJnIRQrcIn84OonHCu4y4L5qTrk7lC+gZDnc6tVj12tAXMDXtEyRt9Lf5gGjLq+EJFXDxE7uqB+kk6uzys3Vkidgxir0JEk6R6Pdw/u56bYAoPb6mBhSHWFMffJY+YlIxmEv3TOwwDCedH5OMvnDEPbdIzunf3iroKZXNOjjYaPdWKZ/nf0qaGaARnZFfSFJIfsNfvCugm2z3kqX/Ht1GqKpiwGUZ/B4a+G3XRMY3ls3qwMynD2iofX/1pawdTo4WV/4IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1mkhYu8b7Ydfeg37IauQHZDhCbntur7SLAvSAgt3OY=;
 b=f0bxdndT4oiofGHNV2B3CwqJ0gHEFNnfnSwxUmnqKqPFqrcISiq/tRnl2Osfzf+ZbUyR+UxsoQTsjrtPTLbKdLOHwE8u5w+sWplno2R0jG73mf8uL6052aj0kBNGNqLVm1eAqKVp0p6SxhjrCjveAET/KpX2t1VsTD5EP4y0BJFp024v6ql9gzyygrVR01afyIeOyZZcAaem/VEMnqpL7h32yiVU2vmIRbhSpBe5OwXj066t+jXSivManF2duTZbr+reUyB+Qx7LzZCz40qm4TNrHzygERrI7HJDCv+6JaoqwGbY0dVdzb4pDLwQNIgVbaU/cKlhtK55grLK47X+aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1mkhYu8b7Ydfeg37IauQHZDhCbntur7SLAvSAgt3OY=;
 b=gGp+q6E11VUkcEWlKIaO4QpnXujjQbvwRNq8+Lq6L85RrSKqcUzo0eFbNFbsx4/VhmiOPm6cdf5GjvOiTMpBFE2qpG3Ljz7LXtE7/re4peJ+aNqUXMfKPQ/bUB5g1x3ribMaK8kGo9eUeEEQlYm8zV1bb3xz3wVlUNi9zkO3gzNvcGJpe4E7RmnTuLA0UeAvjBYww29aSSAa2mGLMazaduS7mvSie3DpCTBBt5REylwZUSj19n2LN/63bFVb2Dj4unxHO3bxCTqd3A2VpcFAxGKMjjH78DRd7MiQxn0xkl+dAaSI4dmxSGBsQYzUsnOdBW4t/eUp2tTQIdu2ReA8Qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by PAXPR04MB9124.eurprd04.prod.outlook.com (2603:10a6:102:22f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 07:15:47 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 07:15:47 +0000
From: shengjiu.wang@oss.nxp.com
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
	linux-kernel@vger.kernel.org,
	Frank.Li@nxp.com,
	phucduc.bui@gmail.com
Subject: [PATCH] ASoC: fsl_easrc: fix missing return on success in runtime_resume
Date: Fri,  7 Aug 2026 15:22:02 +0800
Message-Id: <20260807072202.380021-1-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JH0PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:990:5a::17) To PAXPR04MB9351.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9351:EE_|PAXPR04MB9124:EE_
X-MS-Office365-Filtering-Correlation-Id: 303e717d-516c-46e0-e226-08def453b3d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|19092799006|23010399003|56012099006|18002099003|10067099003|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	dolCw6sFEUoINzO3kwv0s+BgZ3H0aguu6N+koJVcobdEgA68B3C9XZbvfMkkGl2SS7tkiJH3mFm2SKFPqUp7/p3p7HIFkYjeV7ppwt+QolA4Ccg0dJa5WnEkSpmCcRyFhwAHmql6eVuIGiTQiR9GGyhnbqKaBNrBBHQpZ8oAImOTLG3CBUg4aAmTpxKgbsmhIhUIRQM2gGPZQRMPZSIXNEjqNkonk+y88OC8K8oRt0advSh4XVGI8Mny07UQRCjpSNdtKUUEaY7EvhAsqRKQiM3M/Fk3YpUTSNI8g9UYDcqzBJPs32S5KjmlTqqluuOWJ33d42gmqJe0iLAAMtiuSHdRX7wCATVB25Na1BeDzOzXEMh/99Q73YBur1/A8XzpLvrgRTS8DL+hpVLetcuj/R54SewtsPhWURHDawIQEPoioIOB5x1lIIoTkcvVS5DkQrjzk7ug8txv6EOZKPq68dOUGPseY1hwmRmJfflaNBZnjpBGEwu1MsOHu6IVf2INhs5a9VvTw6kDSsBDfuFskRwQ2ew0Lk/p5Mvm4dX6HnAX0147cIENXRugh4uJDxppMH/2CzAqD/4cHOcrB3+pp3WBTRfO74vC+Q3pIFerwem5QxNBJL/LGhKHiKFAkX811o4PlzZqwkHZMpap/LULzByYDRoJkayYJjrrSNp5HYXWMi3ItAerRAllu3z3cQTw/OFg9KWoXxQUAV+EzwC6jw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(19092799006)(23010399003)(56012099006)(18002099003)(10067099003)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oEmVxx/G5JqVR93/ZIjfg7TCSYOGBcBhSvsIq9XsAhGhrJfvO27m223um0Ao?=
 =?us-ascii?Q?VgG5gtPyO01S4BrdBDGDY3pPIpbwq4Zu4rPNT3VOyT+hXwkJmczd4TvG+7qC?=
 =?us-ascii?Q?x2lKnmtxe1BldhB50t0nbpak3pJGalvmnM0IlQGvFB06JgeEVolry7i2+rpN?=
 =?us-ascii?Q?FIlJWBqQY/5CzuiWZEY193lpDCSKGdI9Le/ubMNOvMjpIEiSnAcWWwN8Tcg3?=
 =?us-ascii?Q?KL1cE0uzV5Do3VbSTCdD/kQmx1IWq+kkjdLptyTMViFJ0fCN8k93vDevjbIU?=
 =?us-ascii?Q?Py4SvhCfHafwCi10npZJwKOfq1YO6dtyLkWU/Wi5pJodbBEqwC6/wo7ht5KG?=
 =?us-ascii?Q?y9mbOXLVEUojHJGpwzK7wwJdgh4Hk3OHrFn2GOYP3B9o2ENj5hVU2jGUPePW?=
 =?us-ascii?Q?IuBOnfeNt0VKqLCx7qiCqxgzbPghCvOFKeAaE8KgtK36/N1UHL22ZNFt3DK1?=
 =?us-ascii?Q?veN9rUJ/JoK5xgkSzjBFkSxuhBE62g7HMVFqNWfHc0iUiC5pScDVJCfWZi/p?=
 =?us-ascii?Q?vxlTEDDjrJ3XzHpFJaGeK/tpt9v0WyRAUv4EnJIgUfPXzvlu9Zt5TnBPzt61?=
 =?us-ascii?Q?9lV76VekO+7iGKcKvy/xKlVjCKVO/FSUz+zXLPiPTs+/sNucscA0tdhfy63o?=
 =?us-ascii?Q?cHPUE5zhavhTEMEFi5k2bYE6L0gZPeCZhCcAY6Z1VmJGek92tPNJzK6HuIFT?=
 =?us-ascii?Q?mTSKMNhE9EC1FZKfw1uNB+pDN/+8scrlMqVcmUkSUeJCId03tILg5238WV2r?=
 =?us-ascii?Q?OUAOXZ5srBVGXInxMsJupE0pLxf2xqGcgCn7ZLv5KHeWA7I+ibc3mgUkuD6u?=
 =?us-ascii?Q?xPIKPZjgvxW4FHf/X7PGjrT8zvtSLftvpIorf1N/a0ksZL2OAThya5qemrHU?=
 =?us-ascii?Q?S2u3ociBzGJ34qvLsUkw4Co0wqvrLwdP5/hdYtvyLX1Xz/AkK/YRYW6pTXbv?=
 =?us-ascii?Q?gCYU564/jdhlMI0feZxNDX5EQBrBu9bMOsgu4PH8z6RgQe+QEveVXZv8QQ43?=
 =?us-ascii?Q?QbOA7rgL+2a3rag8bcFQJSoCIbbOfCq56+lrJfBGP5kT68IRVGUCy4pEmrQJ?=
 =?us-ascii?Q?n4hU9/G6fRLPASaBVstxLyftnwIHj/xlK80NKuEMDvCkhYzvq7S2onL8H/9L?=
 =?us-ascii?Q?2bYASqsdnhqY40yr3tqS2SGAuD2BEvYO3sxGFipXufB8WXw4EE0wT131M3YE?=
 =?us-ascii?Q?IsM2KR1WW0fLK6MrA5ZD1v7DUSZRzwafkwQGOcEpUCxhYDqP7Nci5+4zhiHu?=
 =?us-ascii?Q?gwOA/no6IgdYf6ojZ2QIu9oItS5NsLTySqOYYlgGMgrzCkRm6Zd+nQJBDTKZ?=
 =?us-ascii?Q?Y7YWUUHGg7l0oL+J50lf5N7J9eBdNBf6uf+JPB7ZUIeIRwtW5Tj9g5kVdNjf?=
 =?us-ascii?Q?2BlnW9H3/t5y2AfctzLNWAaBO7265ksIaC8Re2cjz6GqjEB0B6kBGhSE0GLc?=
 =?us-ascii?Q?gdbI2NYoVi0TTKsA0VU8STZ5pglos1saroaawH170NaVD4y9aiDbXcn7jmEw?=
 =?us-ascii?Q?t3V1ETKPpeNZphgl+58e28J3PndkzGf01N2vL3T8FDi+u6Ur6Hbp2YhHhkT0?=
 =?us-ascii?Q?GKAcGArgaz3JMiIj9uLM+fHEPT2jv9qsjeRsRkvA8GQVbNQhkFncHd1W/Qlv?=
 =?us-ascii?Q?9/ogphASPspmf0DmiueHPlAee7B+JnSHpXw8Vn2DvtyYB4MjL+4GDttRusI7?=
 =?us-ascii?Q?utd7gGsY9wTMTx37XJDEaaaRqfOZobvQVS81unEb7RduZcYdeb6Uz/1MJYlJ?=
 =?us-ascii?Q?Wd6Q+OTY1GyrDZgExl4OwamsEsG4nOQGeXR3rBls3tYsHPtvoevM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 303e717d-516c-46e0-e226-08def453b3d2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 07:15:47.5614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: INfS5A7WGcAxeYpg2v8i9dTmf/UXXg1PX6+Y77bYrB5PHV77PadHobn5A4OtO4a9TnSN2Zh618E6RI8oQ1RALPYV8JlJMd2bUPt5lk8Xjw6wlnPQafMTv1Re+6A/fCyc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9124

From: Shengjiu Wang <shengjiu.wang@nxp.com>

Commit 48d84310be60 ("ASoC: fsl_easrc: Use guard() for spin locks")
refactored fsl_easrc_runtime_resume() but accidentally dropped the
early return on the success path.  The original code had a skip_load
label followed by "return 0"; that label was removed during cleanup
but the corresponding success return was lost too.

As a result, every successful resume falls through into the
disable_mem_clk error path and calls clk_disable_unprepare() on a
clock that is still in use, leading to an unbalanced clock disable.

Restore the missing "return 0" before the disable_mem_clk error label.

Fixes: 48d84310be60 ("ASoC: fsl_easrc: Use guard() for spin locks")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_easrc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index 17d85d484358..2ac062083782 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -2425,6 +2425,7 @@ static int fsl_easrc_runtime_resume(struct device *dev)
 			goto disable_mem_clk;
 	}
 
+	return 0;
 disable_mem_clk:
 	clk_disable_unprepare(easrc->mem_clk);
 	return ret;
-- 
2.34.1


