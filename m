Return-Path: <linuxppc-dev+bounces-19139-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D17D35163
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 09:42:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fm0PW0j4Tz30N8;
	Wed, 01 Apr 2026 20:41:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775036511;
	cv=pass; b=evDNXw2zUk3ogzpHcyJKRPFrNLVEMHbP5bBsD1LHCeM1CQ+DU9tCqiJWwfb4Q5c7W9mGh8RLNuXnoSzYng9O1cousn4XGoGn2L7W9zZwLbEtUlzEz1HE09pNOVIlLmKwR50YbPQy5JacNZ9eXrFxTU1j2XbqljEXrigTkUUgHdqjLfDbKq2zEosSDsoMtTNYGgcd8I0tJGjwMmOF4OeouHCaBat7JOv9dX+1NixzB/ra0uI4/7R1FCyYkXMRQbabrzq8AVnS+ieJIl32WqADJ/nWJCZBEcSMAu3qzLLDb7KFdDa34eiMyMXT3ORpj2EutLfU3P6yOgUouOGBnrgVOQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775036511; c=relaxed/relaxed;
	bh=lcy5UmZqh/o0ySld2VRlYssBwZ+fCg5A6+bAmvQGrUI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AnNLivFI4nHUiHhBm8S8hDvKeXje2DFniWX2hQoA8+DI8TKVlpX/B7iRFdUtAFavPApP3dMRlvA8kQ2gjtZgm55mV7spW7gF06Ug+Jx26fRJr/hPC+52ZQ+lal9PHnoFnMPYcvBdkJmpuSsB4soPMRLGLIxcARWSzBlaNOx7W0lzZabr4E9n+wNsohk8utewvvSiFRLfiKBG9oUL1ANoRMuVJLZuOwuDvmparyoF7o9/eZBuQw+39eHX3Rr3bvOe3+XX10eOLuqtHSw/nrnWMSr6mZS1cI2qPYQnZR98CzfvBi2oDw5traLrCnzdWF2HdU39vKr/1zahZr3UrCc5AA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=XVipNUdY; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=XVipNUdY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fm0PV2H4mz30HQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 20:41:50 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SDsR9vkt0e/45AR3+ZQJt+LxAek1zPX2qeB0mjhVFbB1uECCZx4eZoIGWaeaJgG9GDOrTK1RuydkeBRP3/8NpiuGEMAAyTuwyeiSXyyX7CB+OHAt27qIKOShXE345NIto5xiXHvv1YkUmEp+xR7nj4vhsXWiwF7PkGI70MnOXqS6tcvTI0RZavxg42hJHuVHgUsqyaTXvyKfdvdeKuma8/nnOCb6Xps05dfCBiQ8gjFvPueYvEnV2cwktHYrSekQglxpGfszX7n4aI5teS+pgUcxALhri9Yyyfvmk5chDxR2wgFUAbLCRrpfKgDWceLTGYC3txNJOVPhAXtl1F1nFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcy5UmZqh/o0ySld2VRlYssBwZ+fCg5A6+bAmvQGrUI=;
 b=A1xsVv7aawVfW59jTXhyX9n1pUf/+JUCmabz+U2zJZSr6WARvKnxdVj9GfYzgz1NoTrkKvOcQMOvPqRASglpH0GLzeX/dqk47ey714YoSh4QnQPI4Jae6eaVOQtwYMgHeWiNVxgtInXzAngIOJYlMCjdxK9sVloKGBpaYqVSkpKtax1XyeGqR2okyxzW9pfXoIUXrrIgcvdbNGoZDthSINLbTkplAg32gN3gmsib6azyCscX4X/MglI6pJwUgZUa0ghrgHfmFJwURJwIX6PUQDpOCbEvQUB+G+OZGORHETT4mE+VJ2rvT3wj3TfeX4vL5p5qj3tLN9jv20KFuf6T3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcy5UmZqh/o0ySld2VRlYssBwZ+fCg5A6+bAmvQGrUI=;
 b=XVipNUdYnmSn1UvJFOQ2m94PMNgxFlsaO1ROslYW+PqfcKgVsR8v1e9/Rip7xOpsrBriL3ivD1X8EihB7AhPoIo3ja+vmfumyiq+OyPlgpl7ztTccb/PuK1eoeU+U6oS8sWQGmM2tpccA/iHlK3a8ecjd6u9QhCUU4+NkzUrqHu8hZ5tqLiawsdKBaxWVKiZZ1JHUkq6RLeqUgJ5Nrxgst2lQbObiyxnjxs1T/uh2tALcuMopwhPDwr2q+y0Ikvm68qVQzePOOmHzYYGUnAryYn6Q1olelaHcQ4yhg0e7YWtGjlicR6QkPmusc5zzKoQovLJ8btu8TWe+5XUsGzEIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by AMDPR04MB11607.eurprd04.prod.outlook.com (2603:10a6:20b:71e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 09:41:46 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b%4]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 09:41:46 +0000
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
Subject: [PATCH v2 11/11] ASoC: fsl_easrc: Change the type for iec958 channel status controls
Date: Wed,  1 Apr 2026 17:42:26 +0800
Message-Id: <20260401094226.2900532-12-shengjiu.wang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|AMDPR04MB11607:EE_
X-MS-Office365-Filtering-Correlation-Id: c4201a8d-6710-4c06-7743-08de8fd2e3d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|19092799006|7416014|376014|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pi68TQ4Hi17gfnqYV9ElSAE+VliIa0EN39RJeGd57icFzBG4iCqr1jsN8aYaqmrVjhJVK6Zq6ceZS96vEJgjOb2JW/qFeoWpBueS4Fwhyq1GbTp0STotKVMECO2onbiN9uuiOfV0+7tigv/lubcrUm16e8mIDQJo9nW3ATWyXz6BDSKotrP1fOE3dwggxAolUtav+qaeqV/GnqcbTP9oyXiYnLgtpBHNg34C0hCO/e7gIYNOEzDZ8qur6aJ+XR7N6eL2rt4SL2LZ8+QgGOcewTtz2q1tyfvYqE6bITjDQ+3wd30DLcJF2S/ed9BThp8v4hbungO8gFqwrGDrWYLCuPAf6rvSKZS6LV4rFdzJsGtPVu+DlBz/gSY9slxQEP6MEKXS9HXTmewXOfRCA5I7x0lEBecd6hNu1D7e+hC2Xw0T49hP8HZXJeldemR0MPsVtd2D5irX02KViDCDuw7FCXqNK45j2fcAqQUIQS9SvT+SZgm8XtWHL8g3QiMRijo2LuDbUVXrM/sg6ugrwnwlSQ/BMgE1dYegadydKabHzdTAMGa78oWs47I2ls/NxGhOPZSW4buw/qQeZpUvgY4kvoymuV9/Ij0g8y9INIkyzldhUnGtkbtnXD3qCjOBEtxb9fpuJUgo6kXhFwLKgHpawrQPuXC7PVjIAoEHqD5MrMVnITdNK1c/xgtRPzoI8tGB+u+qHb5zPk7IcZrrqDAdks5rUHuSHzmb0n9HKw+3N4XPqWmBxwl6QxXgkIpTVM7LPDy/qBRQomV0x9PcV0a7yGkMxTSMJL2LujGR2yXRicRpbvWD9+TqSEWBI9gxE46l
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(19092799006)(7416014)(376014)(38350700014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vXJGfKBDxkbB1INgDshPvVx2hTL3nfebkUR6vfxl+1cVYkT+k9ov/moWDuZ/?=
 =?us-ascii?Q?xfip2Gecpdq/5qlT4hPWZDQYL1uENZdEM4ooRXbaVoQKn3vrz6+suJzkhsCE?=
 =?us-ascii?Q?OTFEsd5iif8hAWB6yoVvIDff8u9l6oF6wrz2iW9IbTsxllGTnQ+CjKq6U//K?=
 =?us-ascii?Q?Gpf8tWoZ6WiwHL1qmfd5ti7QIhClO5mL6x4NYaE1OQH/c8dR777R+f/gaiv8?=
 =?us-ascii?Q?c2oerUFzPACxV8byBq84gfC/YNDqpAOXNkQtwVZIg2BWhpoTgG/IbvLAm+af?=
 =?us-ascii?Q?33K8WSqcbfuCIlnCab2RXK3iO5PRvETW4JFvMwO4UBDFdpPEgmwNHAaI7IfG?=
 =?us-ascii?Q?HhtnXVdERsGiREMx3u8lC7T/rYtvObxUZ+BMeYKcZBhvLEsWdQakbDjgvQIP?=
 =?us-ascii?Q?sPWZtgCdHDp0OvjQyNL8Bz6DMHGm7SHZvdrT8Ut7azz5TeZ3lBdUaFKS0qgo?=
 =?us-ascii?Q?M5jcmmydTW1CG29w17SrJJsT4+P5QpDrXlihqStTPKJ9br73dO6mQnUkuzLO?=
 =?us-ascii?Q?v0J+ygQFVQjpVAjq9S2mQs/oBvB88FsO53JO9+VquEsj4cx4Vwcya5QBT6Id?=
 =?us-ascii?Q?nny/6wMF2u8eli+Snur5GS2iKqiiz+V2r9ELc26qFBE1mjmOZzeOgL5Df8aM?=
 =?us-ascii?Q?I3YFmOR4lsGreLxnsoEPIFs1iMSgRhmQ2cLxUtDPII5xDR0x7krmluQ5B9t5?=
 =?us-ascii?Q?d9GZUsniPnnzqtUHBlTnfEA6C1jVz/0+2HB5x+om2Hzctiq4cSxiANgCV9Al?=
 =?us-ascii?Q?U6TgwMb2eu/mw/uZR6GB7tmndacB8KedgJ2fTFe8wONkYptWeiLGpddf904f?=
 =?us-ascii?Q?CLOcwMqGDvCMugEo0dNi4dIt3HcMtj4DMhh7vthe+/0T9uGr98Rb4RJynop/?=
 =?us-ascii?Q?06/N7Uihx36DwAGRw+b6/y3v1+IoSgid0Cbl17ExMeQC2m6XKUkW0mg/vs74?=
 =?us-ascii?Q?kV1cSaJvl7g6NS6+Ze64HQqXreh2nJHvDObOBdXkdr0cePdXBxPlS3ml5sEF?=
 =?us-ascii?Q?Gi61hRFdmn+bXpq9msMhqSJuFyX+xoqtV17PH74Mcz+rnphzDdO8IiYmHY7D?=
 =?us-ascii?Q?IFzXzSlIEWT7xpFlvOHSHVhDw9zRLNf1gHWRz9YPfRGoZbOiUMuEnkkeK0by?=
 =?us-ascii?Q?SSZa3DLChcNncxMbNDccY0WN2r9Oh1DS4bETsh37oqelAL3T4YVV6BzNET1Y?=
 =?us-ascii?Q?EcbApDYi5hYRKyupuL7wmW0hF9v/g3u68moz4MGOA3WCs75/7QAOoulVRpF8?=
 =?us-ascii?Q?eUlfr5iOLwpuCkPT2wghV8Iu/CKvHdB5ow7l8ineNGCb+0E8hrCrFeryhzqT?=
 =?us-ascii?Q?BSeNjov8HKSEwBE9gaBoNZEn5SbpqWWdLgM1Ds8nZBZClA/ygJ3HgzeqxnII?=
 =?us-ascii?Q?aY7P875uiXNBwOCJAv11xXlcyOgrGwOxhoXRIR2cuLaI8ditmdiJtigc6Q54?=
 =?us-ascii?Q?orGrC35rK9W4hwQv5VNacMwet4NAHurWkP+tptVqiHpREQ3gDgbfhDGeqx5C?=
 =?us-ascii?Q?oZGghMGDuAsyJBFKvEq58pDERyRSbzdkYceGjtE4iYxmamvZN18F+/jFpbgv?=
 =?us-ascii?Q?1vtoajbcYhUR+/UEHjd0aL1lBAsNUs4hedUjjrzHqry4m0yb6Rxdp5LXcO55?=
 =?us-ascii?Q?nK5rS5pz9FiSHNEeVKHKNL+S0a1jndeuvu0n6Advq35MYMC5s5qDUQVYZbVP?=
 =?us-ascii?Q?xSNGNdbA941aS48dag3LwAfPcMIx7vsNVBMsVD102AVFVGXKOSZixtBIJYa2?=
 =?us-ascii?Q?bewgudfBZw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4201a8d-6710-4c06-7743-08de8fd2e3d6
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 09:41:46.2431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pHYSYdkeGDmZvjFlmZcyX+XGI+eKl0Psw+7vm6+lVwboDpt2uL1hX82wQ921jAcX8Pin1/yMZsDarpy9xR5UsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11607

Use the type SNDRV_CTL_ELEM_TYPE_IEC958 for iec958 channel status
controls, the original type will cause mixer-test to iterate all 32bit
values, which costs a lot of time. And using IEC958 type can reduce the
control numbers.

Also enable pm runtime before updating registers to make the regmap cache
data align with the value in hardware.

Fixes: 955ac624058f ("ASoC: fsl_easrc: Add EASRC ASoC CPU DAI drivers")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_easrc.c | 118 +++++++++++++++++++++++++++-----------
 1 file changed, 84 insertions(+), 34 deletions(-)

diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index 3086cb758beb..114a6c0b6b73 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -78,17 +78,47 @@ static int fsl_easrc_iec958_get_bits(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+static int fsl_easrc_iec958_info(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_IEC958;
+	uinfo->count = 1;
+	return 0;
+}
+
 static int fsl_easrc_get_reg(struct snd_kcontrol *kcontrol,
 			     struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct soc_mreg_control *mc =
 		(struct soc_mreg_control *)kcontrol->private_value;
-	unsigned int regval;
+	struct fsl_asrc *easrc = snd_soc_component_get_drvdata(component);
+	unsigned int *regval = (unsigned int *)ucontrol->value.iec958.status;
+	int ret;
+
+	ret = regmap_read(easrc->regmap, REG_EASRC_CS0(mc->regbase), &regval[0]);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(easrc->regmap, REG_EASRC_CS1(mc->regbase), &regval[1]);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(easrc->regmap, REG_EASRC_CS2(mc->regbase), &regval[2]);
+	if (ret)
+		return ret;
 
-	regval = snd_soc_component_read(component, mc->regbase);
+	ret = regmap_read(easrc->regmap, REG_EASRC_CS3(mc->regbase), &regval[3]);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(easrc->regmap, REG_EASRC_CS4(mc->regbase), &regval[4]);
+	if (ret)
+		return ret;
 
-	ucontrol->value.integer.value[0] = regval;
+	ret = regmap_read(easrc->regmap, REG_EASRC_CS5(mc->regbase), &regval[5]);
+	if (ret)
+		return ret;
 
 	return 0;
 }
@@ -100,22 +130,62 @@ static int fsl_easrc_set_reg(struct snd_kcontrol *kcontrol,
 	struct soc_mreg_control *mc =
 		(struct soc_mreg_control *)kcontrol->private_value;
 	struct fsl_asrc *easrc = snd_soc_component_get_drvdata(component);
-	unsigned int regval = ucontrol->value.integer.value[0];
-	bool changed;
+	unsigned int *regval = (unsigned int *)ucontrol->value.iec958.status;
+	bool changed, changed_all = false;
 	int ret;
 
-	ret = regmap_update_bits_check(easrc->regmap, mc->regbase,
-				       GENMASK(31, 0), regval, &changed);
-	if (ret != 0)
+	ret = pm_runtime_resume_and_get(component->dev);
+	if (ret)
 		return ret;
 
-	return changed;
+	ret = regmap_update_bits_check(easrc->regmap, REG_EASRC_CS0(mc->regbase),
+				       GENMASK(31, 0), regval[0], &changed);
+	if (ret != 0)
+		goto err;
+	changed_all |= changed;
+
+	ret = regmap_update_bits_check(easrc->regmap, REG_EASRC_CS1(mc->regbase),
+				       GENMASK(31, 0), regval[1], &changed);
+	if (ret != 0)
+		goto err;
+	changed_all |= changed;
+
+	ret = regmap_update_bits_check(easrc->regmap, REG_EASRC_CS2(mc->regbase),
+				       GENMASK(31, 0), regval[2], &changed);
+	if (ret != 0)
+		goto err;
+	changed_all |= changed;
+
+	ret = regmap_update_bits_check(easrc->regmap, REG_EASRC_CS3(mc->regbase),
+				       GENMASK(31, 0), regval[3], &changed);
+	if (ret != 0)
+		goto err;
+	changed_all |= changed;
+
+	ret = regmap_update_bits_check(easrc->regmap, REG_EASRC_CS4(mc->regbase),
+				       GENMASK(31, 0), regval[4], &changed);
+	if (ret != 0)
+		goto err;
+	changed_all |= changed;
+
+	ret = regmap_update_bits_check(easrc->regmap, REG_EASRC_CS5(mc->regbase),
+				       GENMASK(31, 0), regval[5], &changed);
+	if (ret != 0)
+		goto err;
+	changed_all |= changed;
+err:
+	pm_runtime_put_autosuspend(component->dev);
+
+	if (ret != 0)
+		return ret;
+	else
+		return changed_all;
 }
 
 #define SOC_SINGLE_REG_RW(xname, xreg) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_PCM, .name = (xname), \
 	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE, \
-	.info = snd_soc_info_xr_sx, .get = fsl_easrc_get_reg, \
+	.info = fsl_easrc_iec958_info, .get = fsl_easrc_get_reg, \
 	.put = fsl_easrc_set_reg, \
 	.private_value = (unsigned long)&(struct soc_mreg_control) \
 		{ .regbase = xreg, .regcount = 1, .nbits = 32, \
@@ -146,30 +216,10 @@ static const struct snd_kcontrol_new fsl_easrc_snd_controls[] = {
 	SOC_SINGLE_VAL_RW("Context 2 IEC958 Bits Per Sample", 2),
 	SOC_SINGLE_VAL_RW("Context 3 IEC958 Bits Per Sample", 3),
 
-	SOC_SINGLE_REG_RW("Context 0 IEC958 CS0", REG_EASRC_CS0(0)),
-	SOC_SINGLE_REG_RW("Context 1 IEC958 CS0", REG_EASRC_CS0(1)),
-	SOC_SINGLE_REG_RW("Context 2 IEC958 CS0", REG_EASRC_CS0(2)),
-	SOC_SINGLE_REG_RW("Context 3 IEC958 CS0", REG_EASRC_CS0(3)),
-	SOC_SINGLE_REG_RW("Context 0 IEC958 CS1", REG_EASRC_CS1(0)),
-	SOC_SINGLE_REG_RW("Context 1 IEC958 CS1", REG_EASRC_CS1(1)),
-	SOC_SINGLE_REG_RW("Context 2 IEC958 CS1", REG_EASRC_CS1(2)),
-	SOC_SINGLE_REG_RW("Context 3 IEC958 CS1", REG_EASRC_CS1(3)),
-	SOC_SINGLE_REG_RW("Context 0 IEC958 CS2", REG_EASRC_CS2(0)),
-	SOC_SINGLE_REG_RW("Context 1 IEC958 CS2", REG_EASRC_CS2(1)),
-	SOC_SINGLE_REG_RW("Context 2 IEC958 CS2", REG_EASRC_CS2(2)),
-	SOC_SINGLE_REG_RW("Context 3 IEC958 CS2", REG_EASRC_CS2(3)),
-	SOC_SINGLE_REG_RW("Context 0 IEC958 CS3", REG_EASRC_CS3(0)),
-	SOC_SINGLE_REG_RW("Context 1 IEC958 CS3", REG_EASRC_CS3(1)),
-	SOC_SINGLE_REG_RW("Context 2 IEC958 CS3", REG_EASRC_CS3(2)),
-	SOC_SINGLE_REG_RW("Context 3 IEC958 CS3", REG_EASRC_CS3(3)),
-	SOC_SINGLE_REG_RW("Context 0 IEC958 CS4", REG_EASRC_CS4(0)),
-	SOC_SINGLE_REG_RW("Context 1 IEC958 CS4", REG_EASRC_CS4(1)),
-	SOC_SINGLE_REG_RW("Context 2 IEC958 CS4", REG_EASRC_CS4(2)),
-	SOC_SINGLE_REG_RW("Context 3 IEC958 CS4", REG_EASRC_CS4(3)),
-	SOC_SINGLE_REG_RW("Context 0 IEC958 CS5", REG_EASRC_CS5(0)),
-	SOC_SINGLE_REG_RW("Context 1 IEC958 CS5", REG_EASRC_CS5(1)),
-	SOC_SINGLE_REG_RW("Context 2 IEC958 CS5", REG_EASRC_CS5(2)),
-	SOC_SINGLE_REG_RW("Context 3 IEC958 CS5", REG_EASRC_CS5(3)),
+	SOC_SINGLE_REG_RW("Context 0 IEC958 CS", 0),
+	SOC_SINGLE_REG_RW("Context 1 IEC958 CS", 1),
+	SOC_SINGLE_REG_RW("Context 2 IEC958 CS", 2),
+	SOC_SINGLE_REG_RW("Context 3 IEC958 CS", 3),
 };
 
 /*
-- 
2.34.1


