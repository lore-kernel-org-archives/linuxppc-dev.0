Return-Path: <linuxppc-dev+bounces-19017-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299F410D14A4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 11:25:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkpnq6hM2z2yvY;
	Mon, 30 Mar 2026 22:25:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774869919;
	cv=pass; b=CQyclDGYJ446U6+VrSt6IhFvylXMsI7CVVSsxvIA1rX6B368PntTVXtlBGofy9KQxW808gj6L55nMrAf/nwirIAsnRPymHbGvO18/3MCOS1udH7SjT/u/e253WnSwqM+th8+Yc+9w552SdYJoPJ5PdvfyFMTSvJPAAZMqzCe4zIzSDv426NKVtdrb++7tdW/V2xMl55OGDBoOui6Yk375X4A4mYLR28lcl1c5piH9/em3all8gWcGl3EbnJgew8lToR4NGAFu2cqe37P+/V6fdQfZIEYAcjHX813RnEgTLJtLU7mb7diZNiraGcOzE7WzetyY4X8xsi7gXiEC6WiGg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774869919; c=relaxed/relaxed;
	bh=9Uzoe5gXhM8SPvOT7oaHjCJYRsmb2cWNtkzMLoIVxUU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WUDUkz9GmGmGoabZS74apfnDuS3QrpQn8iYX1T18YmGZjl/S/mnXguisDwHbjSDR5KJ+SBX40IB96KSQFXvUG2HtbpYK2/mh7b2kMIt5H4AZzdS1rvyfrYln9m3VdT1R641gI3SPsLd7I4Ux+ZaoNhq5TdzbvrIqUVf+JPoiGmzSUKlnv8Z4Ox2hT8hNiBlO/9VnCmnmvlXlwcga9Ta0m+MhhbUZ7rs4T+/5cg/oLrBkSQFaN/cySv5x/PLQkcJJQjmc3T2SAXpjf6xzuSZAbAUzlS2hYGISWFSZF5r7wX5iacWvETLtik1bmvaZ9ZbZ9mQQrEqFA3EykMFQ73J6kw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=AQiQ0p1J; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=AQiQ0p1J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkpnq1qGVz2yvP
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 22:25:19 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pErrGX5c1xGwCSQhAVKwb99WsKETCVPsFp11zLTzIFtRhtkDqsxLkdNO/n2HgUnnWrv3p74RCBTfUa2hVjpuxeMZgbczN3VCtXvbsdK7TPR+dgzLM6hs98/Bs4PQvniGGMz37P2ZswwEV3DZQG1S7qnIwEKbekdVXJY97OEelvo6S0uPCtjb2CzAAp/1uEfkKsPL/XIE58Cy+1TFzDl9weJhhXfxCCiPtPqnAem4nA2iWvDrmtRD22Lc3qQZaMwBVlpQHN+aZZbhi2WdNIhvYdsQmfGmelUL9Y0JTvJu35eGhYKhI8zFeWpUjFteDrYCFPFU36/3TTujwcOTkFJQyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Uzoe5gXhM8SPvOT7oaHjCJYRsmb2cWNtkzMLoIVxUU=;
 b=PO7O5hMBQT7AjviBeBdXsOTfxgpKk95dyV8qrOBwja1wl8kyKj9gudjuMbJFMBgMKWy2LEMriNwL9bQ07cNgA36I2P4IrOHp4tMfwbEI5BS+vmWO1MUuWUfY7xwc1FK4ocyY88v2wv3qvcyXfBkMHwC4kXV4Vxo2AVjZPV2J4Zli4mcs9m0LOzxctb6DuswQJj9Sj6E+jn1iXszQiSGlUs9nvzej55hvSO4GX7Gh6Zn2EEtk3uYf/cFr2amhT8PDNsbLB8VTVLjgFUXWj7KpptNCmX6PSZ6XSv5dWUq4hYajeGbxKpNbfZgxYj0hjUSqXpRK/AsEPwI0s9fp6iy4EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Uzoe5gXhM8SPvOT7oaHjCJYRsmb2cWNtkzMLoIVxUU=;
 b=AQiQ0p1J5yuDpWFqJ4RuZVgAhaRsA5v1ukZBLWcduWSkGMddeRn+lUlcjqEXhAbXb46jsVc9Qk6Dm/f5mG3PvhFDUBnAEL6RuDsXi2uQ9txSz3TivaRhsKIA5hnbVc3CA/OWgftPH4rejhH9c/BPZS1VPr3oGOFTWJpjzFu16CIkimStmQ4uWkHWiU/+D1O0xWE03fJEzCvPtmcYl22reBN8DRk4+kFfDJCs2+lDoIBOhO0dHo0azLerDiuH4YpTqbjHacADq6qIPBZzKD/hyoMoAuhOIOIqGr0Dtxc1/qDtVe/WZ9qszjS2i2tHJ8PlzPLGk6k7tWxqnf/ZhZJ2WQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by VI0PR04MB11481.eurprd04.prod.outlook.com (2603:10a6:800:2c8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 11:25:04 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b%4]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 11:25:04 +0000
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
Subject: [PATCH 09/11] ASoC: fsl_easrc: Check the variable range in fsl_easrc_iec958_put_bits()
Date: Mon, 30 Mar 2026 19:25:53 +0800
Message-Id: <20260330112555.3637002-10-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260330112555.3637002-1-shengjiu.wang@nxp.com>
References: <20260330112555.3637002-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::10) To AM0PR04MB7044.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|VI0PR04MB11481:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd8e029-516a-4f76-d6de-08de8e4efd37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|19092799006|22082099003|56012099003|18002099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	+MXAH71lMgYJbC+NACtVHhdCgdzy9gk7fgYR3wUJscqMwVKRjTa/GDNVuw3ycSCHX6c+j2b6ModKK/LChUNgOdUBINONIJYee2C66qkLT8tv++31ambscRCO0aKWPsDvju+u8N7770WA4jiZBtaKT4Z2NuffHz8CmvdjOvJ4uKkkC9GaO80gOPbQqj+mNCmWrf3Bzz5JmkLbdmNG1mBFVWmg160K3s+Ke4ImvzOnXPOyLaI+heQnXwT/h9U3LBaRBxnQePow6FJQmB7g9mjD5dVpZzMII52lg83epqdvmrHyrb3znuHtgReNBanlRq5dcgLzF9JPwRtpPLOAACkl2c6VYOR7bQFx/1JJ0q86sW1iePdFkobfUYSjpQQw1WDsm5j/mULNDd91goPr6pxhOVDwvMiPlmvVPmMQbCr5tiFgqWXljNbEs2WrMfDJTWQuyHVC96/8B9qDeGHZgikzd4eSawp2B4PpHoMfQEB2OsMANsTPNq+7VOHu9C8+01XH0FNSJrEUfimHwr8c+EiwkXAnkNdaTbkNJ61QeMwEBzfO8U7r4OBDQSO17Z1tmGZRoWx1cuAaKdNnS4GmW1Ur8Fy1ix3lAnA7KLezJQCyP8dNHwqfDa2b3UWmx2PLCJk66QMElzrCmY9sIMDKiVuKg7zK8CpLz6swXdpZZLR/v0zgDbRwLJileMMGTpzIunRqq2KQGKhfM/St5LcPRsKvRHSYfv3IMVDZej6L5GxAccHYI7qSUU1dZcVahtblNUvhp+S4KS1wJ+iRI0kdIXgHbRrb6UldHB9VIhVDB/YY+IDu63wjJWol42OhHNpMQsos
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(19092799006)(22082099003)(56012099003)(18002099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HGM1F0BhynUlfVWHqN7Fb05U3H4mzWB/qFAipkI9ibX/lUR0LC1gY9THom2L?=
 =?us-ascii?Q?vj4sV4N6FtfFjRdSGFeLl0m6YQ7wfisoJIQQeTUKbdGD/OBeIrS28dR+rhx1?=
 =?us-ascii?Q?8XPcSZbvUW3VBrXRemon1ksHg3K+wALZU9ZFziq9OaGaUeQS6iutpXW+g3kS?=
 =?us-ascii?Q?27mjxnHxKivgrMhlqK3wmz2vjQ1lJh99ebRt5kp2Ds6ThjQVKYyEFMxfnl1j?=
 =?us-ascii?Q?7W2slPoQZiBsZq5EDBdiQQ7YYle5O3oKNlaHRNY87j+BHid6uRkIsuv/rtfW?=
 =?us-ascii?Q?1THGP767oDJMDDlydINRqcZ6TQVnpWeJNHcZSrK65vY76BFs1rrbkWWyaG8h?=
 =?us-ascii?Q?DIX0WyRoZYKAtiCiVe1caF0CHhmgHgPqPTIwm5dOJ1uKHQqhC7N/Y4SCKbv7?=
 =?us-ascii?Q?pkfFn/Lt8tJaXpOKmtUqmhCG52j0iE3akSHZPd0v231rknnUrRolSYP+O2f6?=
 =?us-ascii?Q?CX0kddM3sEJ/XyCjKrM+5EmQIdB88bGmYZoDuManmY21oflqagbl2X26QXPB?=
 =?us-ascii?Q?lhaQ/GX9x76qyRLBuR4308UGZKdkAPHpY6zMOtVakPvnCLsIl6Oss7Rz0Eto?=
 =?us-ascii?Q?BoXRLI+APRtoIxy2SXqFoN4MKCuuCMPp6f8BJwoMlp0/zWORcRjtrPXh8nzT?=
 =?us-ascii?Q?rUvP+X8gVIjL69PPHlnP2Y2lgud4MpicZWULjRbw0dNDw0zvJS1ICrFMwqaq?=
 =?us-ascii?Q?NUhwar/7NmBalEXfJz9QQ/nr5dwDaOHLZwloh8JrgMkVysre/2cpJrq1Evwt?=
 =?us-ascii?Q?s6UuvGrab9PBrpu26YaGiDxWXG68/KZpKUrVBztZpm0H2RxXGj5nupDTPKaV?=
 =?us-ascii?Q?wJ+E7AVsw90F2IwgzyVEQg9gJtXaR0V3yDjB15V0WxvSam4PtLluvAeOV/+5?=
 =?us-ascii?Q?Cltxk00ygcX49eA2h7hYQjC3ihyPvUBVdyLuoT2eV/qZzJRwQ82vVXvzkJTu?=
 =?us-ascii?Q?SNALc2ugIOHyoexbIpZj8khT5ZcwcdCM8j9vkujNvkgFQfE3BfOeB0OMLW/p?=
 =?us-ascii?Q?2kI38oxjdZEFxLsEUDBQ92/2XrQrzveTSq8Ul9p5zds7vEMB3ViQY9H62bLl?=
 =?us-ascii?Q?8AInGPHQwfO2wS0GTZGKYrgreeJzV5G3g0dawfwMLJuH3uVCQY2uPG+e3P1j?=
 =?us-ascii?Q?QGqP1adeqg+MLLWcsLnRqoG8p1bXlx9A8PHMyCPLrXbPU3h6c+FJbhSwl1pW?=
 =?us-ascii?Q?LX16X/mBtdJca7aYSQaDhCrciJzZUP92FPXqvjr72ePozhSwCiVxA9wFhzPp?=
 =?us-ascii?Q?P6vPFaJZdBFQJ+wOGIDAjc0iXMoc8jI4W+YZQgSoqgxcLmTPLkKZm17S4MZz?=
 =?us-ascii?Q?83ZgRC4XG1TJ+HJ0MsC6UJx0GlpQtR4mE18sufz6eobf/gGhxMfCVrAz0aFj?=
 =?us-ascii?Q?2LMNs0il7afCC4QtYbnxQqaftjD+hrmNCCO2RzJurh51DnZbk5zhNkNXXyGX?=
 =?us-ascii?Q?WqVwXGMXk8VSPHrX7wsaCGZc1Q/upVjamOBWvOvhQoyXCo130jewiQaMO2fV?=
 =?us-ascii?Q?tbaup/sTBYbKdn8pTmV2JoQRDnJr/5hOcjKRw/+4LG9HPlTxhE6vfdBSPd27?=
 =?us-ascii?Q?wTDSasl7oHEdJK5xREUbfk1beZvoyJd8pG6t5T23O8BbdskmXdXRuQXU6IU4?=
 =?us-ascii?Q?C+rrn+8krtyWnbukm0Cx9IFM4yrCWgmm9oAt/U3S4x9v7IGp8KobJMUWOO5m?=
 =?us-ascii?Q?Yjonjks60Ladt17H0ykznch2ALzMO+97Jtt5EC0N8g7qJ1hUyVpa8la02VwG?=
 =?us-ascii?Q?JL/7lcDgHQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd8e029-516a-4f76-d6de-08de8e4efd37
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 11:25:04.3077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: La4D4+Ic2lVDs/URN5iVcSAa5FCITPPsjkNG0JvwglQCrJABNJG5d3Z7lOje9HU3hblo98PYxjD+Msdffifpvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11481

Add check of input value's range in fsl_easrc_iec958_put_bits(),
otherwise the wrong value may be written from user space.

Fixes: 955ac624058f ("ASoC: fsl_easrc: Add EASRC ASoC CPU DAI drivers")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_easrc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index 599e439b359a..f48e43a0edcf 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -54,6 +54,9 @@ static int fsl_easrc_iec958_put_bits(struct snd_kcontrol *kcontrol,
 	unsigned int regval = ucontrol->value.integer.value[0];
 	int ret;
 
+	if (regval < EASRC_WIDTH_16_BIT || regval > EASRC_WIDTH_24_BIT)
+		return -EINVAL;
+
 	ret = (easrc_priv->bps_iec958[mc->regbase] != regval);
 
 	easrc_priv->bps_iec958[mc->regbase] = regval;
-- 
2.34.1


