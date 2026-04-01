Return-Path: <linuxppc-dev+bounces-19129-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D21ED35164
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 09:41:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fm0P63L8Lz2ykf;
	Wed, 01 Apr 2026 20:41:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775036490;
	cv=pass; b=o0VOACtWP95H7o+uBiiGw/AVnX4rB6cZhdtgjj5UAWrLgBgkuy0sDSuj0c80UdmgB5igiyyCxOW+vUyXorgZnEToqSn0HPQfdwvIbnkaT50Iu6Zvq7OCB52pKBN5YFTeHIWcCHmz8oR1xZlLOzwcqfrmAErd4tuBV4wTSK4BR/qxvPxFdL5B7URJkV91lqGAlTK00J2yb1zErhU2wYL80pfX2SYl55ppwmERwdaL+LG86CnFg6tak4adQWwTRG+RnfNHRrhag4/zrSdB7rU8F9dDpG6nwXhQHZexN8W2hSsQHstzyrn+y6ME8QdU61YtUT4CKyNJM/FHT6IcWFbIcw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775036490; c=relaxed/relaxed;
	bh=iYtWKN468AYcmwQsYSWAgH/Fo9OGSrF0j8fEL5WYu3g=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RqJ5qDqVHDmZOJV8xW+ENtXd7VouRgO2+2TXFhibv3RCuBdM0VZSObxRPuehd5UL02Z9a4VoSsaz1XXYQG0b7UKBVkgjpzyiz6gcKE3wI0slEFBf7XWCoYFCDce7JOBlYMGjrJpFk5upNIfRgD/hbfgpwAPQa09lh78i3BiVyNmMEXFLItvbvk20f6DNmZoS/KFQogBAfg7mqY1zJzLUFgWn4WUZdgy0VcJBI6Jr1QDzPHFc8+62ZULzQf/1Gmunuirrq9Oa/i/OqDsKbFKwTktCl9A02a9/8xCkrThMZ0dFaTcGVKCBdKVTA3yoVzVoTcpjWEDVLXTyuUYGTcoViQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=CvrmQAMM; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=CvrmQAMM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fm0P54hKcz2yj1
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 20:41:29 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TG9ZDwnIS9zwqCrLyEK2Jy2roHpN4DbA1JXi/Tp+CHrLOYZExwzBQ19jWEI3Yxfome/5uf+1cdpfHuIOFU+7N3B9mCHEqiMv0VJTtIaKwwUezZmwkTkM1rFx5GwR/nBXzzZWPduiv34ydChLtoaoMhkXk45KEMmPzxoycY0R+Rz5ElrMX9RzH/08cHLK2TJSY5XvlJ2QUDfNlpGb0ECUcgoIzuxwvHnxrF8q6uySoMacCbfZnJBiloBcio77mN89DOLe6FAHNPH1HsNKg/qLVWxlA+YAY7gzgs9KHad9KZ5AWu7r7h4Am4qWOmY/WTXbKer9ulLC6WS7TwxAG+7zzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYtWKN468AYcmwQsYSWAgH/Fo9OGSrF0j8fEL5WYu3g=;
 b=v3n92wxNftqOfhXOnOLxxNf8eYwv5wUY15MpbGYjpUg3NHxRbWh9TSQUU+xhLiyY9bE7mFT7OtdzUqtaa3Op93JaJUTzhCUQ3a7oaval2uBusRKVZaq0QMfJKfl7WrDMMz9O3ELSb5FctVzHdtK1QvilBuvWlfDVPamKqXUD/US0Em/xyc0aMgAjgIDgB0zRFmYUMEqRic/qmH6MJz7b1nkO1f3B1t3mNb5sUK5PwjQGuHmr/n+GEP9yQr3YrVY0u+NA1FJj0nbprfunHxWfS9tb5yW9adJGHjz0ilxNkE5mKjysHEKBHo6AOCF3io47bE5rBdF31+U1/v4cI1/lfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYtWKN468AYcmwQsYSWAgH/Fo9OGSrF0j8fEL5WYu3g=;
 b=CvrmQAMM7AORGTI95c+nfUgHVYlLZA+WihsHKIaiWtbrpOqwDxaDYSYDfxhmotyz9ErzDVz/ySb2PzzC9ps06xcEqofYfGA0PaCFBc9erxPqtEs1r+x/KhCvTHEZrDIcE33sBDN0mttkXn9m3+sFmk2WIyc0I+2tiftuEo1E75vd32YOiIOV2awje1Q7O2JGbngkFYYQWfHgdNRl5vCS39OmzP0NZF6IidlgFTC15wyuD4SEln7FzHEpx+vOSHFhzOVhjoniPxHpK4GrUxmGMPi8sh0RlUXujEq/BvaorXie1yCTjb/gqg9IK0TMc7kGxLsHureaTash0ByLooDbZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by AM9PR04MB8241.eurprd04.prod.outlook.com (2603:10a6:20b:3e4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 09:41:04 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b%4]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 09:41:04 +0000
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
Subject: [PATCH v2 01/11] ASoC: fsl_micfil: Add access property for "VAD Detected"
Date: Wed,  1 Apr 2026 17:42:16 +0800
Message-Id: <20260401094226.2900532-2-shengjiu.wang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 52d43c43-fd56-4c79-d324-08de8fd2caba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|19092799006|366016|1800799024|18002099003|56012099003|22082099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	8mZOGgJ/kZPzBlG1XrawGiZTjN7IG5R75qBj1PurbNypIX8eYVAFB7k+fbBGSWTr5HRsRsUEt3Hf1lhWoPd0Qj1X5G6ZyUs2QFsfMJJbea1xA6oZxPZQWM1m23S7HP1WYOQpN4vilWjqegbgWr3njZRee9tutC71sNaxrsWYl/oJW9+Oe+emDwVxku0PLMAifnhefnwlibob9XPJMtZTCQNPt9UrczMMcTM8f4arGiu5zmPKgpJCVVCBYfAKl4U4vWZebLIV/eYldHkyb3aPP6/WMa63mfkXqq3C8NBDZwpUKUtAbf3rAq+jSw4c2TJNsy12ho8jNQ8M+UymGDYhX5V1ZVUy1lSG/BWMMSt43OcxC126m93dsSD/eucrjd5eBRGYcXJr6dSqRO/v225ZRchfBm899yeY4tGZ5Gm7tfwcVkKbG6CFFyFSDdL0uVcwz+9uBc+xM8YyvdcSYAlRR7CuupcCzDlEwS+mcIXTAP4voohbVSqF2nTbtuRrhE0KDqKAY4+G+F3Jz2xHHWwFuxP1HPpzDct9Sg3vCQYWSRzeMzmqyzoedH0VRzekBHSVmRR1FPns1Xpc0gIrkVMWGhVMKuYHqqTOI6l61d65mvzAg9e8CiUZNocUGOp7AeL6tjM69i6HNVOyJguFAVw5ycbDBoeeE2V1sNqjAGxRSBwxHEFrh91Xa/MKKyhQjqtnIL36rkzSmqOT3UB9QURwutgNpjgukd5sEjmMRixwUuoIme2TLI16lBQmInO6skkkBPGV2E+oPG+aq0cy0+QokHT2YCajgGgyT5Rh/cIFCS6BgPTEbppcL/f9+ggq3hOz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(19092799006)(366016)(1800799024)(18002099003)(56012099003)(22082099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1ThNPPm73R96D665dZpSO+MzGVOQH+XzlOaL/UB60oc7ZVLxjVBs+iw2tAyP?=
 =?us-ascii?Q?VLI6uf9JU9vgy57RW7P9uPQMjw9tYx8REydkEJ0lxzs5FhbnX9SvEI/HqQ0o?=
 =?us-ascii?Q?TcCmHX9vxvBtiV3G0KI3S2Pz6YjsW+JIohEbr46Rt2TzB8BuuptaB12dzvy+?=
 =?us-ascii?Q?0Jt+cjnInXlP9lWK4453X0tTV3Por/OCIiVBEuGL067nmPc3gRfNtHbZ92hs?=
 =?us-ascii?Q?quPjzPwKs1kmMCTi9NSHhNVFBUmiMXEWgAdU47ucFbJH3bYk1GYdk/8t96GV?=
 =?us-ascii?Q?UpUdFm6FM+5UdVHQWPIpLYZR+y/qGjxWVdFWiX57TO6AXX0JL1xlXmnbuPcg?=
 =?us-ascii?Q?tntoGmWWmwUBYQv4DFAPHL6FBGWKRbVESNsm9uC1P47c9gndlxYjJ1LCk6T7?=
 =?us-ascii?Q?5h+TTLsEo28lU5EHP98RmaevkEQTwmHfzpAi04Gbafze2xUsqJdizqxeGaU8?=
 =?us-ascii?Q?45f6oy+4WgsyK7wHNeV9I3i8YqwmlEG1v6LIk3uEYlQRCJPOAtWE05V/Eo/K?=
 =?us-ascii?Q?efH1rfIbUe3+/LY2ha5ZCxtiQO73zExUy6ZuVocJo7xlxBsdvDuJeefwPpZd?=
 =?us-ascii?Q?RwkCg2+jbmjd2A2iQ12/WH45ZSnBujVy3DaDvT4aaFoPiUDusf2pcE7SfFXl?=
 =?us-ascii?Q?mxEUYAfXSNM11+WU/2XBPhYr/DCt5IJl6Mo+xaKJEJhP8qUEfrDQKAQ8UaG2?=
 =?us-ascii?Q?YL7RIm++4cEPm0yiXBEHqdFM7jHYBY+VDxl/R8qQoQpO13Vtexmrn2PTtNwz?=
 =?us-ascii?Q?3y56t6gYOlNtkCdfGMctJsiXMSdF7Ek/OFuruyd54qrS0z285bs7Ve5kTD2f?=
 =?us-ascii?Q?FJ33X9QsIZtsgwY0tSEUG5zigD7GSoYzATIOH6M600nYOLLO2E/3mcAfD0Nc?=
 =?us-ascii?Q?iX8n8SnAUdWX6qVfNLOxBnGP23CDdPUsTBZpltpZ0c5HpZQ3i3ck2rfaDvF+?=
 =?us-ascii?Q?6HP9YLTwLMENGdOa/y6Q5TIfEn4k2OzbBWVow4exihQ0i2zAl+IKUwsiiqyA?=
 =?us-ascii?Q?OVjSZmM1ZEPSo5nGbqYvapYfcLcYusHrM2U+Lg9Y+54EV9PjiHYx8IYHc7+4?=
 =?us-ascii?Q?rftW2DysSiRia+kIA6EjAv8f8bAqxyrh9iT7M12Q3Cgh1Q46a3zHQPAi2zaV?=
 =?us-ascii?Q?ZgDCb/4nvILN+7tMsg0dOXEom1zE5XVnldzlxSZ8kJq3HW8yWSnhCr2Xylp6?=
 =?us-ascii?Q?oJ37WcKKDgkmKRTWX4Bh/Rg/Vf94GQaE2b3ksnjSjXfj2f/ncuugjKtodU9G?=
 =?us-ascii?Q?5CnucjTBCQC0PAv6iqMcPNR+vTBLa0616eDAywtmKVWBtPNDocAh2yMa8rFP?=
 =?us-ascii?Q?Cu0uB8IcXNKG2B1K69G+MpPLSN7cKeKO15bwPzMXDjSDfki/Z8+Zuoa6f1xJ?=
 =?us-ascii?Q?ikKLSnz2oSjP3jnlfVwnEBkv43c7ZOfcFIBe3JkU2a4DWIdVxWxE/8pNJz8v?=
 =?us-ascii?Q?pWtA77VO5EynGY7bynqj6zNnhPPiaTWCFhwMX8jDy9ptM2qet2WvJbhxmG9h?=
 =?us-ascii?Q?8aD+VgJLnRv0Tt3DFT9lJXGN6LilbzZ8BFcXk/iyBHognqtbt6JNKdrIvMgu?=
 =?us-ascii?Q?GVulY/9rAx66QV2H/mkQ0JeaWVMYnWuasNUrRJ0wfYr5fP2Hv4p8Y/Tmbq44?=
 =?us-ascii?Q?PqfjmaiVMWJU2VK3dk6n8VEkgjcd03Om5DuOEBhB0fd3ndDmKZGY0dAr0Oxb?=
 =?us-ascii?Q?QC6aZ3/YHOYPO/C3HSfxTpIeT0e1C9Wdsy/RxNj76MfpZ0pVXVZrSeIjZJbg?=
 =?us-ascii?Q?tE0HM8rQNw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d43c43-fd56-4c79-d324-08de8fd2caba
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 09:41:04.3810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oOHVKfXfAX0zOye10XXUem0+tBeSloSZf+iJu875njeNt3ZtwdQwSybMfJtbvpFo9N9VF97rvKvOmIHiKtWcoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8241

Add access property SNDRV_CTL_ELEM_ACCESS_READ for control "VAD
Detected", which doesn't support put operation, otherwise there will be
issue with mixer-test.

Fixes: 29dbfeecab85 ("ASoC: fsl_micfil: Add Hardware Voice Activity Detector support")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_micfil.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index d6cde2757c6d..79850211742c 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -503,7 +503,13 @@ static const struct snd_kcontrol_new fsl_micfil_snd_controls[] = {
 	SOC_SINGLE("HWVAD ZCD Adjustment", REG_MICFIL_VAD0_ZCD, 8, 15, 0),
 	SOC_SINGLE("HWVAD ZCD And Behavior Switch",
 		   REG_MICFIL_VAD0_ZCD, 4, 1, 0),
-	SOC_SINGLE_BOOL_EXT("VAD Detected", 0, hwvad_detected, NULL),
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.name = "VAD Detected",
+		.info = snd_soc_info_bool_ext,
+		.get = hwvad_detected,
+	},
 };
 
 static int fsl_micfil_use_verid(struct device *dev)
-- 
2.34.1


