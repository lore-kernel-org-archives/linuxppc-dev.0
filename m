Return-Path: <linuxppc-dev+bounces-19136-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A780D35164
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 09:42:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fm0PL639cz302l;
	Wed, 01 Apr 2026 20:41:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775036502;
	cv=pass; b=Jxxmnvw2GWcMKT3leUO+p4RkOs84ntDMxznIEXCc9W6eaMlCgnWTdwo4XCEy2+jkl2GlA5MWqWhWkGF1SjmgyGO1OCYd6snnPFNTbeiteeiYG+k57UEkIfb54b5JhAv5udOkWrv3gsbQ2F0sdCW7TXJ8QcQ1M5WiMOxp/xpAINZdPd/JzyMn3Z7QjMVKSfuomxHzh+xjhB76KWmjvV63hbScFzhPQ4F8LmOI0U/6aNhhb31d1Ioi0X9pksVf3Wf3Cdr5zwpFVfEJNfhdTpnSuSVDskxWj2W8cfG3EocooYCIyZBhsMj1LWS4gVx0Lkt6XGFCN/StS62RxmNX9PClgw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775036502; c=relaxed/relaxed;
	bh=9Uzoe5gXhM8SPvOT7oaHjCJYRsmb2cWNtkzMLoIVxUU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XNE9IQyGZ3GMAUKBQ3I5lls5IdNWdt9jAryS57WAQKPfAtcZ+dPcsm4FouBFvqM/zohwmhZr2kxWatvmNHcXTq1JZbnfXhrqlMGSsXN4z4jx+sEzM6lX2mqb2qeiCgGRD5bgUojpWjE+N231P+DvDYRZ9zQa54OP4NWevm64BqpgB3WK8JRE7SbBnLowl+dAbZGsx1CU7goy8B07FTANkF2fY4TZz29Ogz3HN3dJ8i81XDbSHfHgenVzWvSRRrb+GebWBmIHWGyxhOCZbdR+uxCxly6Gf93WMEHb6QVGvwT+/V398ma9m/CsZ4Vo4P3wXDN591YezyehXXRG/CCLbw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ITTs4sSe; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ITTs4sSe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fm0PL0r0Xz2ygf
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 20:41:42 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kYD5WVKUUYFdE0ntXwHy/caeg0zQsMrjhUFZ+CTv2xPjsrK1Hu1leu6tfezodDBL3m18p7gVoWCIcAf59bh2R3WXZ6LGOPoawMcYYG3hp4NTH49dO9ERifefKuTbFPU4ZQXE5E2YsKVcFXCSfTxiWGXyJJ2YdVZKMYc4x4YxuRck4uqNyzrCiB4xvCkR1BXipSJgxdQ1r0Rdc9DvN7LNMyGTArE1ktK4YQqb/ShQbXir3nK+Mr2BdfZOJK6+s/IYIhiYMVWMsWKKiQbKbl1uwcwEc2Ma8koMQKMb2jaEcvBjteQP0kIwX/Ov4ImPZsKQtisrSgDVpTTMp/XGo/kMwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Uzoe5gXhM8SPvOT7oaHjCJYRsmb2cWNtkzMLoIVxUU=;
 b=s0MBqrUsFwEwOA7KzuvDqlyt8TwBSyDpLOVVth4L+QL+DmnJgEBqM/p2p/q6B4A0GLbPj8o7oKXhW+CZFKjuUVni5ewghkUNPNk5KuvhRy50YKHl9os0A18DD0WfXyFRIyEY/P97elxSIkFIvtpeOnurrSdNt2/ikx9tGc4Pvy2X6M0sPpWRKdPcS6sTtc/T+oD4/M1ibZ2c0EVzOpSOmoezKoQhLyVNqZZJTeqkc+jc9YCgQnVH0OOkHszQUXEto+njQvQSpYWae/cnCjkdFJqj/n50SdscETcHfLkib4QPEu/Btu8OPWZI4NqsQ6hfF+FYJFj+bbJpDUXGBrz+KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Uzoe5gXhM8SPvOT7oaHjCJYRsmb2cWNtkzMLoIVxUU=;
 b=ITTs4sSe6nLR9Fu9FB4y+LJ9UB5Tx997Yn1+7YCeEHcicwc6KpWM8z2++O3GneUt4rDSCr4OB02Zo5Y9VlMpfTMCyr7riinzKvA2spibKikLZ0ldq0YTx5DcZ/tUp2LgyZtawU3JovqlipVC1uEZVQ9FHpqH1tfpcFjeaaUrfD+F3nI8voe2zy+uKI2UqdXhhdyyR4jTCxJZQPM/wrudmdO/jTR2/eejQLo/0CC90EbdggxUR4CC+4FqUMKPetytzXjb/HL2ZMWXVlgHijk0jT2XsALah9HpyJHTsJX/b3xa9f+v+ruIBgJeua+yKEOZ/gVYmpwQFp/He6gBeKnT3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by AM9PR04MB8241.eurprd04.prod.outlook.com (2603:10a6:20b:3e4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 09:41:38 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b%4]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 09:41:38 +0000
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
Subject: [PATCH v2 09/11] ASoC: fsl_easrc: Check the variable range in fsl_easrc_iec958_put_bits()
Date: Wed,  1 Apr 2026 17:42:24 +0800
Message-Id: <20260401094226.2900532-10-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260401094226.2900532-1-shengjiu.wang@nxp.com>
References: <20260401094226.2900532-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To AM0PR04MB7044.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|AM9PR04MB8241:EE_
X-MS-Office365-Filtering-Correlation-Id: 36a858e6-222a-43b4-a384-08de8fd2df40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|19092799006|366016|1800799024|18002099003|56012099003|22082099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	6PnY1QkKX/z20Cikmg+7/Yf30GtAHv7g+awYP1EvwCPOSPt3ydJbOgd6/CIs0aU5Q2Fbk+3itg2MyEmBUFHJ0+8ygj42HfxfBNkonVZIL+BSPTTgxTaMjke49Tgdfg+VUkF+xonDa+rowwaMy6jAvBwm3EImKTRNRMjGnWN8YMolix5kAfHXz5Ogh9E7kNVOmZDB7PaJqMA5D/2cGew1qnOqdmS2s2PZrtOoMRZKSgRaBP4u7jtKAKEhhb6SVJS3WklcyGV/aRFvVoQ0dyR33WXeMGsbSMyhI88//mLb/NL1UmuKFivKLtGYaofraOTLNsSrAxoiu2IvIK1Wl+EDWKXaJVo7pYQdVSQf7dDFDLP+eXk+vo5B1m79vb3VSp0PFMFTK6nXvcR3xbk2GAzVtj1b29evKq88ZVi6UwyhREscSbmNJci8MK+nIBce3Q0yCS3BGpUj6DxBn40tJ/Hsur32B0Cy75OCFtLHVhta3z236n3k2n08t0iLIuBX3Im8BAIyNrYjvX6wc4cjRwgs9XrrPyuS6X8IEzdnF8R1YIKiMsUFB5oPHkSPwdncOxdOfnZAu2OCsVTvQ3TEQM7aK0TcOVvEgttuaY3vsMzkhCxbZPJqa+Zu7V4X5N9BvJ1UV2DQ34AtFygVG/yO8katN1IlpkyFp6nHfsqb1MoNtqRBAuHre7NE/t6jkoCNwXJ/t+YbrhkFDRiZ//5oMEaFJSuShBoRPcSbKgqgFxrdqAZOibF3Epb862gx+/gIFNHNjuVsuq5swEGP9mPRPHtUPasadE6d9PS483Em/58grpLrkzRLPbH6K+sr+rf5a6IF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(19092799006)(366016)(1800799024)(18002099003)(56012099003)(22082099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0GEIh8yr14h3AtBQiUOStOgmSrwwZN7td/z+mLFw+TMPSimrHnQPF/I9ydmm?=
 =?us-ascii?Q?ftKQMvUNvGvdK95wnMq+L3ZMiXccn+O9Tqigz9UOtPGSBwuUmra27MIL9Wwn?=
 =?us-ascii?Q?O/1GnTsUz5fluwCzn1dENI1G2aFanOGz6aJsEz74lSxLw9FvujxTYYWhVhEk?=
 =?us-ascii?Q?EshLafg0eJ4QCniWo1P/dY5Jekc2az8OcuSnADGDLrG8PhTMvpw0hydyaj32?=
 =?us-ascii?Q?yzWn9t81RWGhmFmrq/BRnybcbQhoiFee2lszkLp/cv3f9F2t8uGCUWJ3hz/d?=
 =?us-ascii?Q?86dFx1ZzP9e9HPlV1MzBIVBiScOEp4RTWLPIvk6kb2/jlfu4EE78eou4nLux?=
 =?us-ascii?Q?y2Wag0Lkp8WRjplZahYuFez7L4wUpMsjsg2zEQukTammzVBY9o6HQpKeAhuJ?=
 =?us-ascii?Q?APbbrHohanoWTBLrXXuxRcBJ9mMiik/tHWkxXFxNdDwPMo0NfguQpFCLOKov?=
 =?us-ascii?Q?AVyjQZMOIf3VWyzG0DmuxwEGU849hAFO2awBxgF7eK8R7hhSaA2/c7SXDWDV?=
 =?us-ascii?Q?epGSEMo6spRDEjsFO9tu3+S60u1L0+dqt6zECsiGafYDWJF1qSB+Zlf46fuZ?=
 =?us-ascii?Q?4MSNioXuKtHuB2nZKNKBTAg4xYAEhjvVRTL61vap0fcU6OmluBhCqSL6RcUy?=
 =?us-ascii?Q?t+hXCVz1/PiahpJKsgm533a3cNwdxURl9aEsmv04Wz42EARs/HdQnI/41JFS?=
 =?us-ascii?Q?/ZXv20xDKxcKZYEEYx015whWC12lzGglZEv4CRG0pBleWw4S3dUEiyqdlshL?=
 =?us-ascii?Q?mCLYeaCZfnuhE7VCqIy5wcW37QNctWofQZHFS/iZmf/70gTCcB16nK8r9zBv?=
 =?us-ascii?Q?OPvjjN+fYV9AAwccKC6MGiBRAdOfuotutbPAGUFalcwmvvMI6BZITrfnvEbw?=
 =?us-ascii?Q?95lcXlJFvCSt7fdEsbn/COOnmPaaB5OYnzId63x7MqTVyxn3Hnpk7H1swbnj?=
 =?us-ascii?Q?n+gIjJVMQ+hmyv8uBks6RsYhRVkhCerMo1PvvcyNLC03R/qncnRnRIzXPkuJ?=
 =?us-ascii?Q?WMCUQtaPm/Z7Kxtpl7o2y+R0svcqwqeYsPSlrYUOlF8Ey6Qy8HlF8qMzMI9C?=
 =?us-ascii?Q?VvUgOAF7V3UFmpjFK8UPYtYXC//MokOgGx2MB5gWt/K5ezok1fWv+Ts5QkKP?=
 =?us-ascii?Q?wjwIfOwRNA7rA3TcHcR4mbExqV1mD7iQPZi+aNYNuyczCeSrqigg44FNUBv2?=
 =?us-ascii?Q?jGMYxuyTDlPPunwmQKosXcbM57HSsCWo6ROGGyKDBsImZ46DI+NARWvR+uvr?=
 =?us-ascii?Q?YHD6Tz8fOvrFneziKQvj/773t0g0aUgyLJH4Nyjc2hkn9pVO1bZAMiQJhndf?=
 =?us-ascii?Q?Ci+Dw/ratyoZMQawetOvVvdaKAoSpRmBHyk6CyNl1SXG7pJMv9sAUv261m4H?=
 =?us-ascii?Q?USSzmEtwa2vX7cERWsWm9L73nFQRUZJOu8CkbIuEl8VTDROimbQkuTWotjXe?=
 =?us-ascii?Q?Z3qESl/sfdwrUIDNMJ1SQrUkE9PVVdYcoQA0h5MTZhdAtDlM9SeAma3dAshl?=
 =?us-ascii?Q?6HPbqnf74dpfSzrbPsrCr+KOi9hZ8ZOJet2zWepxmoUbr3lCIxWJo1BrWvdu?=
 =?us-ascii?Q?4d5HXV5HGeIKlPboHGax2CWqjwsb2ndkWZeuq+YKXztEl786RZB8E/XF4HnT?=
 =?us-ascii?Q?oPHNaGy/n0jRlCH5zR0dgmLfwpU/KkRhIDtufdD399GQdRw4Tbag0NVzoH/q?=
 =?us-ascii?Q?IAJYtpmILVO6PbnTKUmW+gneUN+sxp4Yz2ArdQ3gNvf2c+ZSwAW3+V6pBItE?=
 =?us-ascii?Q?4stYfGBoUg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a858e6-222a-43b4-a384-08de8fd2df40
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 09:41:38.8308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l5qvg2bQ7YnnY46PtreRpmZxe2rkLLdMlvuL8oHVzHgU3ACbGX3uw/ANrnwU15B8ZpX5Q1hOEiDdYvIjQuoDCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8241

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


