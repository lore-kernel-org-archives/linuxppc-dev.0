Return-Path: <linuxppc-dev+bounces-19020-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD9F10D14A3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 11:26:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkppB2YqKz2yhV;
	Mon, 30 Mar 2026 22:25:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774869938;
	cv=pass; b=BEl6FF7tYmHZtGQVEZieUVpUx/XtpLH2VzX2Zv5VJBynUvXd8cYCvyD1b+TBRPnt0LWumYx2vlxra0vlU9c68dkZfgmJ/HCeiHr6QoW8ElPJEnVe2QchK1gb6ln7bdbjN+zUsGovntMKNLanTqTyJQl8BB2I9tPQK4eYVhCHIG5AjWo18qWQlfozoLhcPd+g0VpQ9purpk3kRBkrUZoJ9FkqkjSbFyVJwhoTr/GUEAh7sq2ZIPCJejxrLrOciWxwCQfX0DELSbdSyDTChUnfNgXWjVFZSW/fKmRiEc/a3W6vu6Yty5TbRUezaOJg3JDdZiFWOwUzC0g6NLr0HR/4ow==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774869938; c=relaxed/relaxed;
	bh=vjz7/cKn+uswz6wnJFHTG2Teqay8TwPjwvJMoHSg6vA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EXvOto23FQATqa9kWQ8bFrSjHlC8Z4xSNjsMyEloudQxFVX4AFKkKCfmI0m/KgIHBLE5EhTWveeG/2LDz6Ztaw5k8g9d3AwYpnQD0XZJKuv9e/C8qbR9AjOHJjYk7VTXFInClpdh3bgMXLDUOhfaHh8modPtnkSb7UqdamGqH6wQpHypz2uayEyEL+ZI5uzegehptvRr+r7MnYSy4x+mfM1YPnb9fZXT99Et6ljP0EJrgRDGmkVKJ3qU7AHcFnm6DZ4zr2rxLj8xc2lghPO2LSBR55lJh4kbzHMio5Bhpo438ezUcoxibml5rKSA65/h6hXNZmIPfTchH+jUTyYtkw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=da3pj2Gf; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=da3pj2Gf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkpp94ddFz2yhP
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 22:25:37 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7/7IuKWQe9jyIHxQbDDH3u8RsnmjnFIh1T+by4B110CSz+ZL+yh1jZlgq71G6Qtik3wKACXRjEjEE9o220PHInLaMzuJo8WYMJuxVHl1C6BRhJD5e8xgN4cdJ3fx2EwKBV52BVktBs40eEFbVw1yJptWN6Zh4n2Q6EpGjOd4wp3MyinkK42Mk5RnR9LaK5Xlxg89HrOZxLyZZGntk7eBTeq295ycw9pADtqZmrGJccsTJxDVc5AmmkpSYXQVcU7rlbWCjGvwlDMg0Z8l+k2Jat5cgTfZdG+iiLBYIs356vRndtxYT8jZ9Jdc+Qv495Sl+6jp+fRfMIUZMnfMRjaqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjz7/cKn+uswz6wnJFHTG2Teqay8TwPjwvJMoHSg6vA=;
 b=efh6HGE8o4mj/W4Axd7l4o2QjdMXoyOX22hsKvS8+bJaMSIWfeE8nq6Spm6esaLLVG4CQU4sc/4nsF1ejAhjq51Kc1EWoL4ONVacJcyRUdRFGSf6M8nv6ykVoo0SvTwKnvs91iuAuIu/cEnTCxoQmk25sYPkTfFYDSMf1awOyP1N57wIOdGbAKS/vIUe1GEPcXyJmPtff0MYJSPIW21BB2HAYyk9NNkzLNNqF8yX0Q154v57WT6y/mddyGA4Q+dNGX1bVPdqzPGBEuuCvhXAqzUWiIyxXNPm7h5d/OlkLmeRFsRJmCy6BqaS/gf38VbDJJUOAKPFb3og+FNd5H8N9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjz7/cKn+uswz6wnJFHTG2Teqay8TwPjwvJMoHSg6vA=;
 b=da3pj2GfBkTNjVeDbqmZNeyWO2VRVjo2+JT4Has4tnoLp5KmcBSdk5uaBIEW+G3jIlk+ZNBYUesWcFns4OkVp9RJ1sYRD4k3gGM1C+r0sj6hGpTgJPMmO+GJng9uR+50K0SR8w5rnAQQlk5lr781DLhxJRx4SZUwwaxLiHpAc1BekjTm+FvvJcKZx+f2JH5UAvJ4UGlvNCJlG0MjaxO/blldvWgmJE3ZTxiNMFiLeS5rStjlgWwJI4iBOACbkSaPvNYtVe0VaZkb1VhHWeUrQHx8HxnuHMo/ddjpPCS8aVMf8dNectIO/vZHchMLjILX0HONv1iWWpAfhyiYx8GBjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by VI0PR04MB11481.eurprd04.prod.outlook.com (2603:10a6:800:2c8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 11:24:56 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b%4]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 11:24:56 +0000
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
Subject: [PATCH 07/11] ASoC: fsl_xcvr: Fix event generation in fsl_xcvr_arc_mode_put()
Date: Mon, 30 Mar 2026 19:25:51 +0800
Message-Id: <20260330112555.3637002-8-shengjiu.wang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: a92677c3-3156-4f4f-c32d-08de8e4ef88b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|19092799006|22082099003|56012099003|18002099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	39YORPYei5dAMhohJns+NMPivlmRpQIgy1BIqmmwCSTNptUTu3Jvs785E6P8rN2fAotYre4IbniEXa4w1Gitq5U9pvgSXVM19IOrYi7XADRWXhfHE2io/mG7msIkTd/RcWScUdEVnS5zLKPdMMtWQYQ7icoBqx+jhYSGQYKOu8q7C6dOaHHN76sr5oYFKbwHLofExEVX/R/JAGKdqnNWJoJSgbMtESg2yWYuacD6Wj5Ow9tCz/E/Jwblr/YAsRTxrSMYIqPKjKV1Ixa444EZ5mBSJD9OKdFTcX8f+Rgtac8V2XduyMuKJTHJX7nVR9bjWlMqgWrZbbyCJTjHRQAlSAwA01ElggRnuzEJRXaLtcD5kFa8+mEs5M2i88Mh6aAhXhBS+CFBWLperFWadHHQVYq09EqG/MZPWbe4RsKw0DBJWJXPr3ff1idV6oZK9PCxAantoee+lfpw3AZiIgisLm6hNygSjEouJr0dMp4yEn+Hd2/4IM/qvFkLPUN/Nv042hd8EZPzaclg/pRT8cnK9u3iV226tMr2QdAwIVZkpHAJy3lp49mWUvtxPOm6xsA4kgXNDaf2Prci9b1S0GxGChR53E/vtzYrFq8k8ddRW7FMZZKC0LqPQRtdIuHr3KEnLiNdn43AHt/QGwgBjYwfOBBN2SB/tg5jbpRILbnPpZPNTD+NjhJUtqmhGuHvkPjTde72Y4lVzYY+uZHPeNXJ3TgEwLPl1I6qLe3PaeY5c4jNFdH3+dDu4Lf0jLbpi1+sy4YxXlCdb4cHLFI85rGpX11VET4hSDeYUfo+3kZLG6sjvfs299vSS5R9y0oFZAbv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(19092799006)(22082099003)(56012099003)(18002099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ntiYhL93jr2KS0QhqDodliKz0HFRIPizdlAswgTK6UPFitoUcszuvCRQnGZe?=
 =?us-ascii?Q?h71B5wkoTxcI011lL8DLsWoIjkxN+aqgiYCCnRzNtZ7I7OUTBtZUK6U2h/JM?=
 =?us-ascii?Q?hK7srz4Emr00Q/BlFrQbL9Ouh4SD9wsHFuWNxsRm/Dv+iyMsHKjln+YtSrWQ?=
 =?us-ascii?Q?lmWImmmUg+Vi6LK4WUqSDOexTDal+KihAAgdoNtz+5wSgdvBTWFnugYin5Mp?=
 =?us-ascii?Q?uC2lXsjSOEJL+W0JoX8DcuiVBK8IZOpvNb8A0I4eeF9fot0WZISelgXZZ3e+?=
 =?us-ascii?Q?82M8kL/b1NAN0Cs0LRInaOLvocCmiIyOGl9eUejU6TdZQv5d90qfCfi/pRqD?=
 =?us-ascii?Q?JsOIGBbt/QlXxgujDnTjXboPU30GTIb055SVrWrLX2eROv21xwh/NMrSLkkf?=
 =?us-ascii?Q?gFX8ZqDfQr0aRl6k3XSUX68Q9rRrrUFk1v2Q29Q6pi2R+vAJ9nISpOaldBVD?=
 =?us-ascii?Q?UMKUg201crH/NmlA9YU+/FciLLNLNlY8+84OLDSa+GU5+lxqvgLKy6MzTLU9?=
 =?us-ascii?Q?ZtX4TxHewP84+27axkEm8LaEylWwpS1it/5YD5dXreqc3qGiugujHaZEw+Dh?=
 =?us-ascii?Q?SKxj4B7detNk9NEwxhEiJldjHPgJzS7ysG2qsb8jfgve+OWLN7Cria84i1J9?=
 =?us-ascii?Q?16RFKZEshSTqFy7bz493ma/SR4RIzD396HWgERVuQIFZWi8MA1m3pAYBHdu/?=
 =?us-ascii?Q?i/BRrgA3fzv6ghKUIiI1i2DclwN6yiZr81tQz25wKyznACHjZs0tmwlQkF4J?=
 =?us-ascii?Q?FSE5i5Vu3OS6Pu1GYXnVVD7kaZLf245ti8Md+SDV3a7e0K3oZoapba/eH3T9?=
 =?us-ascii?Q?gX5YGD9Ju/8hz86Ff9lQJs0q5CG+t5rWVqvcBCMjC1fRO5cf2krhmIifaPK1?=
 =?us-ascii?Q?jQ36X9IsdcmTbtjmVv1x3jdRC4iEyCX5OzfMYFMxPCfiasbrQGpsY0NdMDtR?=
 =?us-ascii?Q?bSpcUSJ7bLMhaVnz4MFTgrdhlZlkXcvXCYtmtn9qizpTNhgLmI/K/NyjnsOv?=
 =?us-ascii?Q?nxvvHFgh3TES/y5UKbAyBCPadOB7ZHZpRQ8xnw2eU8mbnn9gwC5UFKSBb/df?=
 =?us-ascii?Q?4SsD53I2FAuuCAZ+PeuEn7yDt+UVnBkc0fmTGE3iQ9B/9fpld8g53AWTNcRK?=
 =?us-ascii?Q?gC6ucf7XzU0dy4oRKkBbZyNz68Lm/y7OEUV8n3O+po7US1YPVEsLX+e1RgFP?=
 =?us-ascii?Q?/A4d+wMApj4qsaHx89zCH77zgWSydPfanfXA4FbfHvMgtUB4yEUxof+QBRCQ?=
 =?us-ascii?Q?GKd7W0N9bIL0p0W9guwvKF8aregaZp0KUM8YKzDDyXpeQmhqT2eZis3GzYvt?=
 =?us-ascii?Q?1353oHJX3+Rf+dmJBP64Yev3hJG/A9XrX+ERZ86R1f4QMyZiXRNdxDjLqS0R?=
 =?us-ascii?Q?cfvtXUy7cyIx98c5EQal5E2xSgF+0lQlhbSN88fBoqZUQSy5KFI94y1fqXRI?=
 =?us-ascii?Q?RIly4+Keoip6pspvLCD405HdI9jH0AgT3Ff8gBchp0clLv5xkv2wg+4ONqZe?=
 =?us-ascii?Q?GmkBxSVoJGGFGACZxfiaVh5kKHWJlC62mjS8Bz602mPUb5XP2IYYP57eH626?=
 =?us-ascii?Q?5B8hlIzsFdOvaCBHsll/9+JF3gqCO6Tb3zGX2jqn3XvI1+/UKFDjSCHhnwSz?=
 =?us-ascii?Q?vcgGgdOqzxA8LuPMaXxo3NXalJV/QA3uvLkwwNMa/vtcq/ExTgBPLctDypuh?=
 =?us-ascii?Q?+oRo1Pc73MVJ9BatIfMPZkEj74GFlgUQLw6W4Ve7gLiUbaYsBMLcccvJWsHp?=
 =?us-ascii?Q?zF7Gy/ZWsg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a92677c3-3156-4f4f-c32d-08de8e4ef88b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 11:24:56.4035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IcbELolahrE2X4jJblf03Scp54UqRSHiyE2pHo7QJUj3Dic0pGB+6ueTWCu16bXQB3AXvuwsMU1XTGrvadVt5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11481

ALSA controls should return 1 if the value in the control changed but the
control put operation fsl_xcvr_arc_mode_put() only returns 0 or a negative
error code, causing ALSA to not generate any change events.

Add a suitable check in the function before updating the arc_mode
variable.

Fixes: 28564486866f ("ASoC: fsl_xcvr: Add XCVR ASoC CPU DAI driver")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_xcvr.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index de25d9e667ee..109e3e03f455 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -167,10 +167,17 @@ static int fsl_xcvr_arc_mode_put(struct snd_kcontrol *kcontrol,
 	struct fsl_xcvr *xcvr = snd_soc_dai_get_drvdata(dai);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int *item = ucontrol->value.enumerated.item;
+	int val = snd_soc_enum_item_to_val(e, item[0]);
+	int ret;
 
-	xcvr->arc_mode = snd_soc_enum_item_to_val(e, item[0]);
+	if (val < 0 || val > 1)
+		return -EINVAL;
 
-	return 0;
+	ret = (xcvr->arc_mode != val);
+
+	xcvr->arc_mode = val;
+
+	return ret;
 }
 
 static int fsl_xcvr_arc_mode_get(struct snd_kcontrol *kcontrol,
-- 
2.34.1


