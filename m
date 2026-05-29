Return-Path: <linuxppc-dev+bounces-21700-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE6ECD5BD2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 08:51:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRcXS2b9gz2xnZ;
	Fri, 29 May 2026 18:51:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780044680;
	cv=pass; b=Qh24ltqZxbirnImkjz5LjMeaXuPY0KTtFe2Lgcmu1QmJO44UltY48EEVzNsZB55VkbOs2snVgul75L0rMn9CBKTDBnY70/gH5CmrLAzTRavEomlyots/xG4Ai/tlsv4kYWel/f+wJJ2QVMYINtho7MhkwDNy4r3+I5h/iJrtGHpZ1Ga5YKZUnfa93mgt8H8g6Be3zIIsSnRX8bUlOCHrabd9an0+wqkvMaeP91q5RKpYZnn+WCJxLkXSvJs2yCKQ9PZKxIYxdaKLg6lU7CrjDqGv7FhdLUFCBkCMpE6IStb5zNp9xflcnBKaPJ8lTn57epd8jqLuwbpbOqosD7hJqQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780044680; c=relaxed/relaxed;
	bh=Oq8/tGUi72BajpVWW4PkpB2phs/PpBWbG1ELBTV2vLU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ma7abFjzYCTWmcN41xzdBkxg41zPaKSm49PqdngP/OnDbv7Ji8HlZ2pVW7L7J+/PJwQpeazsmEOJJ1Q9GA7QnMco+FuzMIycuGD9vio4Ljk651H98sJ90o1mIcB954kLTVts/v9A8gkiNqniCiMKdDp+EQGFDackKTWw4qOY84Pizp8HLin4aHt9c6hfFH6nKrXNK1IUclETARhjDe/I4KCiSo2DVVZBCW+8F5IRXS1ksmVobJkidWv+ZN72nHvwNqyTfE3g7EMM5tOG4codd8hfUhxwklDJrZgyPOi9mH/VoxPvoMmfFk2eRTZaIGRGn7meHYxmRmrvT7gIpdufdA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=MN18HeO/; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=chancel.liu@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=MN18HeO/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=chancel.liu@nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRcXQ676Nz2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 18:51:18 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2AbZcprGNDPpDkEzHQCOsfusnCDOXB2q91ID5pcInBZ6gQcxEQwddWjmspwskDdlKVFKgIeiZswumNTR2B/GuZgOTxPGBtq7ghRyWzPLrofWda+N6PCmOfbeEEddjAJ7ni7/24uQA+FAxd67YE8ODeEhwbbeBTW3rUmPsG0TPfVGoSMxlaqx7toUjVCI8Oxk0nUh8qwH4PLJCwyDuybsNneAWQLUithzDXmiLFHcqCDN4f27aPeiGJ/kQgHvUcKJ0K0NhVb9vTNPmdEWNtQfRIgyiDVV++8mY5ggtVONRJkLBHno/ApwVOah1akgY6EGl36AuXSNAE/95EnPzeCgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oq8/tGUi72BajpVWW4PkpB2phs/PpBWbG1ELBTV2vLU=;
 b=R5bLASwGzv4SuV2HxF6Be1LrP2yBSEk7vRKHgzYMhLCHnZcA96lLYzAY5fsDj+/R+zvTRdH+5eOp43xtE012iQuxO0ShnzrwVUz7QyO/Gl/4gPm5pHevvBw8HA1u0ekwiF2GW9FwXhGa7CM2ZCdrADgBbx1pwZxSn10LoKwvpx0OKGkJrKJ+JndDkJQSJ7NlxezwkggcD3wubhfiROik1FwXCFUvAzvaaSkD6yBd85yh8gR77DelemrsbG1edw4z9m3KHFMghASNCTH1wODYtfYkoKcsko35aSkxvSvNk5OTfVpaIXmRvKu9KVWaePx7mT640KJVfrk1qvYbg1vMQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oq8/tGUi72BajpVWW4PkpB2phs/PpBWbG1ELBTV2vLU=;
 b=MN18HeO/TjHl5kYJM6IfFqKv3J6acTG5bBmnS96/9jJObuV2zt1o7lS7iJDUK4Cig2xkrD+YxgyIsMu0DAxBcppeILO6/BeGnOnGZcZGSzbVu3jOuZV8P0qjukp573gFCLHA1rBP0y2r7vO/eQLdJw7mEiJn4KY/OxHL9w928xDvqdo2WB9bjjjxKu+Wu8rUNeYEf6dse3v4SUBAYeL6WsYuBverKkbPEEIB+9RJ0EN2FOGuoKCxePwyFE/rXU36KES8pdeVp+d/UYMyzWrUUNUdmPv9RoxZMzTctIpiuQ2edKGmQgOJ71n/1+AYpRMixPvR3sGub1HxRWwdwmR24Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8353.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::22)
 by GVXPR04MB11665.eurprd04.prod.outlook.com (2603:10a6:150:2c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Fri, 29 May
 2026 08:50:52 +0000
Received: from AM9PR04MB8353.eurprd04.prod.outlook.com
 ([fe80::46ae:f774:f04c:a1bc]) by AM9PR04MB8353.eurprd04.prod.outlook.com
 ([fe80::46ae:f774:f04c:a1bc%5]) with mapi id 15.20.9870.023; Fri, 29 May 2026
 08:50:52 +0000
From: Chancel Liu <chancel.liu@nxp.com>
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: fsl_sai: Fix 32 slots TDM broken by integer shift UB in xMR write
Date: Fri, 29 May 2026 17:50:20 +0900
Message-ID: <20260529085020.3727790-1-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0024.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b6::6) To AM9PR04MB8353.eurprd04.prod.outlook.com
 (2603:10a6:20b:3ef::22)
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
X-MS-TrafficTypeDiagnostic: AM9PR04MB8353:EE_|GVXPR04MB11665:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bb48f98-1fcf-467e-a4b3-08debd5f629c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|19092799006|38350700014|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	6NkF/g/kaSKYYkI/YmT0gZ0RH1CgEMUyvvV3GiFQ0vyxYlh9gnUWY8uMRJsRr1o5M/Qml8Nu5eJce60xqOSG0HjT9E4xQuy5iz3+LnUEc/cRx4nE9p0jwmDL1L3rn7wyiyhPuq1D3HZX54fMx/6N6mjoIwGrLdHLbuHX2JLC7qtPiDiL3S1qeSYeMy1kEtTQuQKJq4N6+VZYXci2jUJ1y7Lz0VOVJKBHiGIw9ZSGnNxMf2QyZNxJTwGwv+5SM5436cU2MH4FYU2uWdSc1PIGpCsCNhiV/sM2NdXvsVLv/hXzqolyT3W3VHkEON794Gh4cWFeKpY7LWFH9u1+apoTPVySsUj3K2TAk+LaWioHe4d16baW74ZPPB0cnWzahHN50zqSTg+f+Min18cNkyjbUuMbheEONxB6ONS2TShaND1rLqxgxewHm24dTC8CAQ82dGL74BNPlZIRmQSwUfzmjNVe7f1Xy8wgYxLut8e4pUdA4tr8flJ1tiFt2ili0as23NYCCAqvlW7Zz/HOcN6w/q0ONwPHykc1Qb07/Yazvjx8lKLEyNk3o84DvXPmkJqssRCD3bigrt7CMVOfe+NOiV3MCFmKLe++7wTb3/Az5id2kgAsC2+1/4kWjw4+lSgHI7fDG8XtPsiL8HaVC+7vKtXt+5mgFXx9zIRIXrg/RQ++WRNsP5qUFP8G+zGRQuaHpYKBCPBMgqVTiPzEDsb+sHiQbuSR0quSINAjRBU4of74gZgtBsucgpnf+YGD0pf+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8353.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(19092799006)(38350700014)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RxRENxFVic8oehysuswU7hb1ncXIRfZ3eiNUpMyW0gHU5ZuiXN6cpi+0whmW?=
 =?us-ascii?Q?ecJbPurMDRDhXbp/VUr9bmtpkdiBuL63TEXVsJDDWqiWp5kwnlgZvhU5aJ3V?=
 =?us-ascii?Q?K1l1r8VMpjipXjT+LbZvuehok0po+TOsiIaQiyPlZx1/9zFkPCxKtILXQgDK?=
 =?us-ascii?Q?ppzDOPr4b4+UziZNPdLpwaTba3kgWScg0Vc+x2NJjk3ATyunnXkTaMzzfDvq?=
 =?us-ascii?Q?NziBpmuz3N5VUE51Qm2yVZNazu4ruWE0XWqvgOH9jTrZUrQe+sx4OZ8sP4eI?=
 =?us-ascii?Q?0Q0DwClnJ4qX7LmcgjsfVJoC2/fcQWv+gOwMRkYlKOSIvH2HtXw0RcfC8qHt?=
 =?us-ascii?Q?bmbTX818xCjN/hxs7F/sCDGqUUQh4KiUl5Je/3dm/VNoZES2pEKqTP1l5/Sv?=
 =?us-ascii?Q?f4VgJwucXTN4Aa7pN7JNvfwZS7IPsKJT2Yoq62AGOT4jWqodQJ4xm6rVVrMt?=
 =?us-ascii?Q?Rh80l/WL6AjrDxnwI0bIxRsPaI750b5X9LCHemT86y16JqLplL0vROYZ9Zhx?=
 =?us-ascii?Q?8YNs/T6S6Xn5efZ1RQzFlrD7/CTPxliPwnuUvHWpCeLdsZCRINrDbpuj4wbS?=
 =?us-ascii?Q?J7Yu7JqPwgeqxY2hYgDD9H+I0TgqTw6zE6NWAtARCuDCGDBt8frfIm5+YtDw?=
 =?us-ascii?Q?RZO9APi248Xp57iHc1Oo2LyKEfGCXWjtPs2QyP1B9fnGo3TeLEN//ewPL/v+?=
 =?us-ascii?Q?7HlnVSUe6PdknX4CGGUqv4nSiZjPig/aRJv2ibejEzl71ZbKcj3T7CdtZnEZ?=
 =?us-ascii?Q?AcEaV9+dCf+jEYuLdxhsINJo2bWPQ3gSu3d7JQLkx6JTF2Z5gYKHsMQW0nHs?=
 =?us-ascii?Q?6eGbJEF9l6bsWHBc6paRoIxtQlnVvnA2f3CHqUDMh7dAQqGk8gY5KS5C1gg7?=
 =?us-ascii?Q?08ZVIfshyKg03nP/ZUJ6fLfXvYow4um/pEvQ3JGwariEeLQZuJVFIe6uG+89?=
 =?us-ascii?Q?fJO78QmQG1VT3b1HauhUoWpmFGtFkuuA/exmqL8TPsNXObj0V9b2/XPAFeM4?=
 =?us-ascii?Q?asSjBgywkbVhN5qrr17pY8DHocdd/Jos35XVHx4pao/uvwNyTJO6iFF978Qx?=
 =?us-ascii?Q?D+w1Bb2Xid+hD8gfegKy7VALNOXyaKobGgkB02EMXL8pFuRKDqbKCHpmJiVj?=
 =?us-ascii?Q?gOI2bzXqV/clV9ts4FEOTe313s3FleDZA0tVUa4NDZRLQESPVYQEqhHwKzxp?=
 =?us-ascii?Q?TmfzRnJ548i8S2sSFo+WBVvP9KYAm4DrFwc2GZnBiLsSzWrkL0oyFWgpBiEO?=
 =?us-ascii?Q?Ago2N0JTq9XpvxI1cM6kFHLD5G3aX4cSEClmog4okItVuuYqZRQJBHRjSn6P?=
 =?us-ascii?Q?NXcj1eWGe7NtTS3HJx4rOgWtAWR1Hr2/W1S0/X9tcv+lqDN2v8ng9GLIrm1M?=
 =?us-ascii?Q?RoI9iViVL+AC8TRFuhTVW+HQoK/1MgvJFJi7y7lnEJvQWugvlDAz/vNnbnpB?=
 =?us-ascii?Q?dU41X1KP61zrklIknYN/6XaXRvdsKE2lFDzsz/OdDIgKmwT3S7RtTs5wIUiR?=
 =?us-ascii?Q?zsH5TjGvDKvsYy78emsC8A8syP58veYBeDxdDEyRPvJZJbLvWAg38ZbSt7jD?=
 =?us-ascii?Q?IkyuS61jrMyR7Kl/NxlJdbyr24o4h+c8iu/XTyRL/w9nMgwZMtwidEbIUVV7?=
 =?us-ascii?Q?32BXMetX4dRhDO8jcSfNj5bWSZV1MKYLIj7j5Dt5up+oGgam88BVBOoimIMG?=
 =?us-ascii?Q?qNWNPIRMlyG89Fm4REmqrRvbGjFJACTzI8S7X9UxeEI/69kCzSh68oGP70Tc?=
 =?us-ascii?Q?D8S8t6Ir+Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb48f98-1fcf-467e-a4b3-08debd5f629c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8353.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 08:50:52.4007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KoZ/6mt0ofO3BOhQN8OIRQO6hOsj0ubD0+bYG7nO9hVP4Xtqt7kkK2iq4lODRa+P+1Oz7eFdgNiN7lwge0ai1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11665

When configuring 32 slots TDM (channels == slots == 32), the xMR
(Mask Register) write used:
~0UL - ((1 << min(channels, slots)) - 1)

The literal '1' is a signed 32-bit int. Shifting it by 32 positions is
undefined behaviour which may set this register to 0xFFFFFFFF, masking
all 32 slots.

Use 1ULL so the shift is carried out in 64 bits. For 32 slots this
produces a zero mask after truncation to the 32-bit register:
~0ULL - ((1ULL << 32) - 1)
  = 0xFFFFFFFFFFFFFFFF - (0x100000000 - 1)
  = 0xFFFFFFFFFFFFFFFF - 0xFFFFFFFF
  = 0xFFFFFFFF00000000
  -> Truncates to 0x00000000
Behaviour for fewer than 32 slots is unchanged.

Fixes: 770f58d7d2c5 ("ASoC: fsl_sai: Support multiple data channel enable bits")
Cc: stable@vger.kernel.org
Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index d6dd95680892..821e3bd51b6e 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -797,7 +797,7 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 				   FSL_SAI_CR4_FSD_MSTR, FSL_SAI_CR4_FSD_MSTR);
 
 	regmap_write(sai->regmap, FSL_SAI_xMR(tx),
-		     ~0UL - ((1 << min(channels, slots)) - 1));
+		     ~0ULL - ((1ULL << min(channels, slots)) - 1));
 
 	return 0;
 }
-- 
2.50.1


