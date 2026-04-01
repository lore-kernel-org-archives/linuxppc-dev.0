Return-Path: <linuxppc-dev+bounces-19134-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83399D35163
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 09:42:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fm0PD0h4cz2yvR;
	Wed, 01 Apr 2026 20:41:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775036495;
	cv=pass; b=UJjAGU715Sfy5a/EbYeTyMJIGSYOnRNyGXH2utJMEEcTI8ittcL9obVTa9u/ELYLVknLl5uBFcXdJRFiGdViekJM86LKh2sh77xVfril5mjMUIN/tp1k2EtWree8gFrINPAZE0atcK2/icJT/d3Kj0aoCaNN5+VIgeCuM4L0EYzmpdDtuqeh0kwdJNvQpxQO0DraGXnwYhn5V7wOA9puFCvDAe5lwJg0VcqmqUCXJPoNf6aDgGXLlQyVwR6ZyzWPX14usCS+2hOEIdYmI1NnZ6mz15kNA36MJb0eB8P63tZPBg10dzvyz/3v0chh3QghxUKVsjoNyns6nhnZhXRB0Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775036495; c=relaxed/relaxed;
	bh=vjz7/cKn+uswz6wnJFHTG2Teqay8TwPjwvJMoHSg6vA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d2kq/6JpsQ6NW+QC+9YSksmqNRFsk//N1Kx4+dg5hWTcztCUNnVvBpvfcPRi2B8S1E9SqoC3KXgcEza4QhB8JInbAPWr6vFwWUkv8QysQb/CTo2/ObJPyTckli5n0V2Ou/5+UFk9qjxReI/aTDL61uCqwgBR9EsjLwcUI+hao2KsMo1mqG0pyg86+Kp2BLc7vwEQKDCvuznAQ6na5t33jVjkSi5pSN8qEPL2teaGLls3LttHVLojVzUX11YIFSPTM22/gcvndRuqQ/kaEDGjTKXwD8vnPLFPdaQYWUBYe3tgJ6HnxmKp1E5KeyyDZ65cstyIKHF0VUFHI7s704na2Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=jfMzOegl; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=jfMzOegl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fm0PC1yfGz2yvB
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 20:41:35 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rzSuGOqY8ckTTwzOiUksj8nsSVFp/XMFS5e5DBK1ySnGSoBvyfFmZDysqWpKjqPM5RhKVloyg2KvOCAz9sUUIFnBkN8w86IpkrumgmV5X/5dve8W3iIheFUT3RKnH2hYGcwfxPS5NbfrThmVm6c9hrAfmwyAuVYKjJw0Rn372gR13FrXXxDI9V/sf/oz/ktp1egRq7mEHIO2U8Hcemdt92lykV3GxzQVZ1liCMn2u8rhmJPiIltzUeW7j/A8vNmCgbmCafLeJU5BrkBCKgJKGRp1eqno4SMmr64+07Phy9Tba0dvqJa7UUvC681W5z39Wp63G3wHmANQkzaBYe+cEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjz7/cKn+uswz6wnJFHTG2Teqay8TwPjwvJMoHSg6vA=;
 b=BqCFV84TXghXX7pxxhs0pGiBdI+ey6gltB7yQ25TypYExseKPNFVUSLuiQagMwaLtygPa/m6V92zjUj9YOlQoTShIJiQsXnxgGjnhe4tzi5d2qzLbpQlsOU9X6NfH8zHBVqxGtT8/w8SQx/Rs1e6OA0Q+VtWz7uY16d2mjF6ap7ykRizz7jk5AEFYYVM3MmCcGu5jbCS40C8ieGkbBT0xjaIiyphyuMkg1jJ+qoJuHdYvawPx2dKGpAiN2jJI8lgGuikB9JXBABO4t+2fdXzkiunIHmfuI26LueYusxO0QnH5N9blcEDRZV3yWjpwtDHxlTkI+oH1v2eQr2Xl3c0Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjz7/cKn+uswz6wnJFHTG2Teqay8TwPjwvJMoHSg6vA=;
 b=jfMzOeglAV2gjCOBUWBthY97KEon+r9bPpfhs0CKSNhK4kjVGq2c6dlue338wImKHPZvHmGfr5A5E9fxDjFGBZTIxdgOVo3tb3TZHK9Yn4Z8UP/S9UwZaCQUv2mrCWRQpDZeefhXneM3fzfv5EDvla75EiEyr1JsYPMfPdqOXzwD+EKqD6D3JDv2CcJogL0e57cuim0gipzCejoyjWeLBIBIfhZ4zc1mMPpVaxUft9LNj77gZgBXqOKC5RBZKLzoIItBzjj/TFajRc+sNNKky5TqA/WzKG4S7RjT6M28YHbaNQr6cdJDsLZFImVraClbZ/NDxpsk2cxAPLr5hCcI/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by AM9PR04MB8241.eurprd04.prod.outlook.com (2603:10a6:20b:3e4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 09:41:31 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b%4]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 09:41:31 +0000
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
Subject: [PATCH v2 07/11] ASoC: fsl_xcvr: Fix event generation in fsl_xcvr_arc_mode_put()
Date: Wed,  1 Apr 2026 17:42:22 +0800
Message-Id: <20260401094226.2900532-8-shengjiu.wang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 118ee732-f917-4e01-53ac-08de8fd2dad3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|19092799006|366016|1800799024|18002099003|56012099003|22082099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	WnQYHGZrpTwlinK5k2N/68v4xCugVUJTSJHA8giBDVOUTiDat0RL71Z6AeERk1Y7N2yv54kBZD4w6LocVXVB/bC4qZT6EEuiLdPCAiTIE7dVWpru6LWlp2rKdq+WEb3ztalKYa1i2llFIqzpQKBxBIZxpHMEoCKBkoPTZfJsnzvnumxPn8364u/Qi5S1joItW6ZoJv2ihCAwzBmVTvkECnNr7O7Ncc+szHmqa6CQjcqZg4fgetet0R8D/6UbGMj5AlaEBBvQqQzmTqua+eWTftpe29F4zUVr8hB8OWq0xMl7vHhUx6zRxB/pEMtjX250t/JgbJwUGB7e2UhJipddGLdkAHZSYnWzEdpsTqGri23vLUuS+9z/WNWNxHPWKenChtCLiejmlmehtIULnc1jMdK8TgtmFWcaUI+AuBradtnG8fSTBf4uaDSqP4y0jqYlPqYbS1d3zHApBAiDCNT9VWqOnuB8PW/+08WVoWqHCN4m/OqzEBbOOlV1ORwCZ+Vd+F9GvyCWonWiFArbLPdvlJlZC6Frn+ajxCcNkE/UTVVKWOHgu2c5g6otQwDFn7+EkoZLVDaGgt4ggIi1ug4dkDMdIAS47LSsdD/hj892cKji8VpMjux86Xx7sfJHzeEGRVKIwzpVauHitW9jxAlEztUWI2tWJIWGVMN1JpQeVa2qZXREpbXuLGR8HTRRxzIc/cE/DQvQw3kkozyoFx0egpzMGPHHQlrmlgs7a0ItFZOqDlswOWL1ZuEUrX4nj1VobqEfaRu3YIOog/AuE5R3GzmxZC8ZesdMilPa5OUcVMyaffPymBWYxVXfstBRND6M
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(19092799006)(366016)(1800799024)(18002099003)(56012099003)(22082099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tSXQpJmp4De27XQAXVNufVIKbIDHShEXzE8JLwdP6HYWnukbBLrHXTgD+zxQ?=
 =?us-ascii?Q?gpGFdyv2huyGJhHU45c2oxhxOzckEUZhjHJ9JqsS10S0erg6pohM7AMmGC7I?=
 =?us-ascii?Q?nNfsYZ3aknsSysXFAzE0ZkYKkGhZHZewKE8WdfyMSuN+wgMNLpuUnLHYW5t4?=
 =?us-ascii?Q?l/pUYxai7etr/Px/6GYpwBKIl+yBKSejv9ZxFhNOjDM0zL+br4GJh2EFrZoy?=
 =?us-ascii?Q?IcImUF+sLoEvhXocIfQyThAgV6nejmAY6f/UV5hq1TMlMNy87W4ZJEAwAXwv?=
 =?us-ascii?Q?cdpmz7Cn7X/Aujv0qUgo2hIYRBL1eAY2cm9mCfi+SvFvy7IQpHkOP2UPVM94?=
 =?us-ascii?Q?BkEOiY5Orq0kCz2QTH0aogdaVT4R6sJSMfFlCDWo31to5GD+CCgwZkEwsMi1?=
 =?us-ascii?Q?5JxPSwyvHtwhHDpWoPSn8SECNMc/LmDvVQM+wJgsXOKWwttyc8DLxy7/4+Yv?=
 =?us-ascii?Q?CAFolGtBiRJKF9D9htP6yjy4bGxQxQqQy343FOHxrAeFKncVs/hiL+B1gWvs?=
 =?us-ascii?Q?wjVI0J/xJMi1/hNqRSIOjQRd2ZN3YDAZEWsQ5OmXC0bXD4siEqEF67TmwtoN?=
 =?us-ascii?Q?afLNAvG7HcBbxSLqpZyjaX4lJE4swcNM9vDBV2l3iF0ofuhK5CIsrsGgrmoj?=
 =?us-ascii?Q?u745hP3njecoq86CFP11fs1ZSllOtfrecoyw3GErx/Aa0z0yT7ep1xCJfAAB?=
 =?us-ascii?Q?UaXAGrKIVOXuyHMFW3yGGM7T5o0+ff2+o5ARx+p0+CjTvOEj8VE6+UEFDJbX?=
 =?us-ascii?Q?sO/HkSTIM1QeG2GZ8hovJln6iyeGPJmfHL6EpfWdyUpafX1jrmzqs9GNylM6?=
 =?us-ascii?Q?QFAgYAqOiAIGHha1BsCQxDaubuPSv2XQiTFQgo7J4ssPLJvyzi0hy7MjUdlS?=
 =?us-ascii?Q?OmISvzPUG8Kc3DRHP0zrf2DvFsfOqqn8xwg0SMfHyFZvP7EiQYjMR6X6ZTVs?=
 =?us-ascii?Q?nW5jFT+TnD86UZ8N5E1xU1tuxGtEpDxlHwscgedW+LSPL4VCKSQclrw19bh1?=
 =?us-ascii?Q?i6mP7HqQnHl2zottEzvA+Yc/ufaT48jrfHYpjRyQpSk0pmdWqx7O9xycUW9O?=
 =?us-ascii?Q?0ISrZ1WmFmCZMK+26iuvW4DkSGpQfcu/iCNGoIAnXfLxPDocNw3SkydFjL7f?=
 =?us-ascii?Q?q8cwsU58zZrkev+3SuWHZa+WL7kLsqNptP/Gw7JQivvEkQr3Z61xgTEdUkhX?=
 =?us-ascii?Q?ffalmfSne7ZYkBjNhKqXzEuiB4DTfJ5+YRe8ZgM6/Q6whdAgzCMFCNo9luSD?=
 =?us-ascii?Q?Rl2hPWkZASnuIsALbc2iY20DdcwIWeeoFy1euY3ZakaLe3OmHdHaPa//om8W?=
 =?us-ascii?Q?otZpyWDfVET+7uh5iq3Zb/yAWPQk3BWJ+1QBiIkuOk2V1rqtKNAIKu/ahQnB?=
 =?us-ascii?Q?eaehvPoYaz0ksoExJGGXqp2+f5E87kfp/xUPnJVf3oLTkW3VM1wMk5Im/H6u?=
 =?us-ascii?Q?9420fUsXAEx8CzKOx6U28RGxfzfYATb3GjVbRepXjjnOF74Lh12ppgD0E1lV?=
 =?us-ascii?Q?Q+dK50aKvJCnoCZS0XpqHwR0/E+t/K6aAC4XzxiNxsuuQ053oPaxAJ75mkq+?=
 =?us-ascii?Q?EdXxL8kQydoo65EaMM4zXYkNWLqcFi422890dw53+InxtOoyvxjTbRc/iMpQ?=
 =?us-ascii?Q?jSiChzGFCBzBA3tuAE7Ivz7gcyMl+5NXrPH3XkU3efgqvByEWPPWZ7YyUt8d?=
 =?us-ascii?Q?1vXilI3PfOOqWuh+M94njP2NE23aunNDdhMj1g8G3QtmeGu7OVcGavNLtiqB?=
 =?us-ascii?Q?kyzl1/wpoQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 118ee732-f917-4e01-53ac-08de8fd2dad3
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 09:41:31.3281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n6QFV1Z/21+52P0b2AGEPK9PR38hKQT+k9b6HPS86sj5mP7+HOjOuJsICa3zkD0H74JW/DQh6uicsGB+lUVRZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8241

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


