Return-Path: <linuxppc-dev+bounces-22756-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1278ACD98F8
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jun 2026 04:37:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ggny10qQsz2xM7;
	Thu, 18 Jun 2026 14:37:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781750024;
	cv=pass; b=DqSYJ//KIfI7KqECiUjnXT5SsVI8y08DzT5HCJk0uAn0jCdfVRATVejT15PysqFRvmRbxLytunofllTVX4W0/FeSBqyRGCb/WTBXn/XCt0+3U2fAeKFEXxhRTX71HsfQY+d9WV74hvq7rvzKwZZoh3VTxqsUgxC4Ajga6ZSbWDdNfrN5eemKK/r51KEHiTggFlbdWniP3qyqeH7hlp/XD8vdJxyxrWYUXcbJYXuSJEMx7ecoMO5KU9n58nDdeUh7h5LOnAjoF+DLjPXHmzmH00y4ddJoMv+jQZPsIouLmpqY80RealSiI6tWVlR+1904q6/hhMU0+81D2z8iOoIruQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781750024; c=relaxed/relaxed;
	bh=XUcKetVR6pyg9onxzBTPMrS46H459sV0PsxddOdvrPs=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RH4vjjYmZBg+2JhfT1kmho8b45FNzy2RUniSgUfxXGoUdojV7iNhNZWQG9lALBSD/2j1X+Pa/y6/48dChvwJCvZScIUlUuAr2UyG6DJZvEKFVjzkaUAL9SIRLe4rRXnHi8UNR+0jlQAHhgndYB7jxz7Iu5GLmcXwMkh4zo9rkeUM9ifa6hrGaBAIOVULPNRq6Q5/Nl3FlQdOZRWBpsvsBbXMIA0OzQ+SiaqT5LeNUZohxPM/T3z8S3bskEcQK4EQs4Rc2sB8B7eaZeaDgs+Mgc87P8pPv/Am2S6BWmLA+1WuqdjSt/XkpeMG21ONWWse2GWvX3EU/k1IqweWaUnS+Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=KC3UQoXV; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=KC3UQoXV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gglCW0Sv8z2xLm
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2026 12:33:42 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bhNbggnd2dlH1vF06xsfuePuUvdhNttALVilVHLiXTslADmw/mwUw9pEDHFYz6yID3Z6XaCISb3wadCtS7LKqLZsoTVsle60gSU9CQOotKfyZXBzYbVR1DFkAkj/HveTBknPIEIocJit3RMSpcxZgia0bmMy74GzMofCGAFecKDZ2PXLNio8/5QmosqqrMo5tg3X835U/kAPp5DfJ73rz1WAqiWgZu41g03aMKBjdZcGBcG/oxheSUPJs+it1nyaPIuAviw7d0ARVgQEh4kLGtSBw0GJy5QnsKZuk8ZqWWkYLLPTdeSQNDVaWmuozSe71JqBGzxFncEoybjrgT3xmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUcKetVR6pyg9onxzBTPMrS46H459sV0PsxddOdvrPs=;
 b=R2i7O8NsIOKAWhgGG6+lf63ITvcczctUOcJ5zGWYZI+LQM/sVq4/NOAOBmbxJ2RcOrSvaVyY3CcASxk0LdTa5hWPDeOg14Mwg7Jyktfk1Y2EFZnAR67b0zFJ3L6SVz7vogCVwqM8Z+IuH6PYqMM2vQ7mMrFwwE6j5EWRQzuxc2lSJyD7jASTlKpT0hE1CKISdPnvTyhQDsxblSCIXCxhTvHJ8nFzDAfN27bW3OiTyCCnmFFYiw4ie+1naxtK0uUmVgcMnBEzslfkVEGSuGqTYSfZb0YfuedGx+cBfjBSnyEVTgPNinyzDlYU4B/oVXuLe4DJVAbU8e2z72fXFpShkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUcKetVR6pyg9onxzBTPMrS46H459sV0PsxddOdvrPs=;
 b=KC3UQoXVen+CV20xQcmwWFRlZETBE9CYyvQAHULSgp6PX9xm4m8xt188N0YJKwGW1IjC8h8ihwKRZXr02g6/EjZR6CWJ3ro61PO/B5wfRCR877h8StdPP+XR04blV/fXdqpt8S9qdd+Hl69DO+blXfD2PL6mKUu7hyDVwJ3711zcuKQXU3rbxxY3ZYbkC7voPM28tIcoTFhE90jlCZF0kw6KjIlW+aaW+t1xaZpo8ybKnxe8N2NNNzN1Zude9gYbU073sD/3Vq+66+dvuAc/tcOKbhHU1KL3GYrYKBM9VTNNTgyYlLdyYh5GTD4E6bBBydXCZBffnGRWLefD4Gs3ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by PAXPR04MB9374.eurprd04.prod.outlook.com (2603:10a6:102:2b4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Thu, 18 Jun
 2026 02:33:17 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0139.011; Thu, 18 Jun 2026
 02:33:17 +0000
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
	linux-kernel@vger.kernel.org
Subject: [PATCH V2] ASoC: fsl_audmix: rework runtime PM handling in probe
Date: Thu, 18 Jun 2026 10:38:18 +0800
Message-Id: <20260618023818.31618-1-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0026.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::9) To PAXPR04MB9351.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9351:EE_|PAXPR04MB9374:EE_
X-MS-Office365-Filtering-Correlation-Id: 17015562-3d81-48c6-9a1c-08decce1f41f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|19092799006|366016|56012099006|11063799006|6133799003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	kxIytIkb6mU2Rpp+ulTv1y5UxwNu7iQf+Yi9yLDUg080IwX/h2vbKbAcUTQ960dyQHKw78S9ZbiweJIqLAiCragUSf3q1OgN1klBzSlJT0llvzyw5q2s56pVy2ZUffO1y7iJmtIVhtA2nNNBS/d88fctDoBjW+WsJzrbE/7b8DtMsILCF+ZnZ7Y2Q11W+WBpZ0wSSbG0euUuOL3TQGSNFD6nKaTKLshq05pUMeHvn+u6yWCTUYFuzONa6fiM8zEYfxMixN5uZ/WRTBmZNx/aMl7CUTBClJwzPyqK7g12lm1jFvrdqUHua1eoF6lsANlVaOappcRQLV+odLlTkNwJfspLX1JEhEgju+hU4iQLEfV2NS6uhfHH6qsEafgi+EMoITenWQfE1P1jjrIR4WL6N7RAoq9o289EI+T2PT31DaXNABctOoduE58h9FMhMzfzeNk2sz5zfb+tKjUVjUTO2Ts7ElBxa+vWPGWs1sSmrIVz5QADvNHTQMERpkdDUtNCNwWlKYuPThNNBaHjw1YeDZiSVAZ9lgnvq/Wtfo27RfvJrHz4Lb8vKyTK27yxsC2A6eonlf8pqbMpm6HHoIeuhkY/SbJpOOQEPiVPxwGnu1JXk4BNX+6C7viejurPBLls7V6IPf09bL18R+DvP7C0zS7eQwyhi5qT0WY8LNhG79BzUyRqaTjsi11Ozh1t7aG92jTikmNT+HjkoMo8CBOc1CRVzhli/AmC3yTDpdzcMIui+LsSCTw/g77dLzgNfFza
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(19092799006)(366016)(56012099006)(11063799006)(6133799003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NWQUWf4D7z1dXzd2nTJu8KHfiF+1nRbydHQqTwLbG8oiPr7lbmkmZYtfV5bS?=
 =?us-ascii?Q?BavHFdV1uLpgpNpOsmIh4afPoF9xbUCxr/fkBxZYk5v3JJRUjItWjsJgfAq0?=
 =?us-ascii?Q?wnpaqHw1JCsdQZ8f0Bzm0VeN7CsRXeMSXNR7NKUyOcw3Ds8/prjP1pSUKMPU?=
 =?us-ascii?Q?qrKzXC727epYjONq3uoC24qPncC+Vvgph4GyBfBb/aJ0IjcCXKLTrC5C/jnE?=
 =?us-ascii?Q?BkjJmoBE/JkR9A3M867Lnd14oXQuA8Rg1+1rJLhbnm3v2SY3Ez1HvMlL7Jkf?=
 =?us-ascii?Q?F9wLmPbO2OsS1hDcLfP+NRSdPAj1LG/Tli60SUL86cVcUKqzKTz+60EBeS5V?=
 =?us-ascii?Q?kHnCP1Q6uQH6IEHgPQIcf6I0M9N2AQ4mKzTsCl3aGYw9sw7ImNgWG4uHdMvz?=
 =?us-ascii?Q?ipxqsdpBSjoOAsDURWO0IWc75818GXh87TcpovvXNtQ50ozrVVVJ6NGPzhPY?=
 =?us-ascii?Q?RXz1Te6UKSuuvFq238jDCYGHdF+gj2vdoOIZ+GEcv1VbeKM81OwiGf0j3Isj?=
 =?us-ascii?Q?RT44x+OTcj6a+VQv5umsbrCZ/Xtr9RTV930VZc9LfS/zECyk7wcb7BZa81BO?=
 =?us-ascii?Q?PR/Mo3t38Sp6aDsypwMPFRdfZowFaP8tjdGeIUsWNpyJrXqcaiG9FWue0Spd?=
 =?us-ascii?Q?JLBO+y5OkNJGR/O1KSMQluQQuX3EcM25MAUYjTiPPmB2255nHEsFNjQ16C6w?=
 =?us-ascii?Q?pWRgl8BXrmgsVBUXHnLzqKjtUzMphYzeJkEby/G5ul+9ysAELGehJBi26zHH?=
 =?us-ascii?Q?kb9pkfDkIKgce1qxZNXHTxxi9rpTQA+gHXtpfkgLo1jVewMzAb8uW0asZ9FE?=
 =?us-ascii?Q?cuOflbXsPUCH2ntzj4DLVu1ewN//NYtyiyyvjz4Q+RB57OB0e9/iWjsyo4li?=
 =?us-ascii?Q?3T7dsSPCE+fq3wHvYmpcZ6J3XEnbVHI4E0Fe02evN14wcIo318WYfNYwyGjd?=
 =?us-ascii?Q?QfY4koroV6CmAZTyzjcJUoXcBu2SZALGzOoBPY1OG961r8ObDbOt/qe9+2se?=
 =?us-ascii?Q?5JrycuNnUwxvtwDqEeWcFME7pARzEr95jgjQlKrtpoP7T6LNLy+ld7K6xYb4?=
 =?us-ascii?Q?02uQYfm1Nd/cczsdFT4M9hNk/EaNxAD9xbYCjNDJjXpHbIz3o5/cG+40FqLE?=
 =?us-ascii?Q?skVyZ087+OEiqM/JvDB9YIY0D1xbtjsA8WruW+YMXAqdAVHo97ujrJO6fTNk?=
 =?us-ascii?Q?gPj+7VI5Kphk/44uAlY+9JIdfzmIa9aoEbmSWqQjA0DLWACluhdE0r6sXyOX?=
 =?us-ascii?Q?39RjLuA30oNRg17f8HX86oBAUv5EGfYcE6l3E4lGAbc/mvXEXN1ogukxvyqs?=
 =?us-ascii?Q?CiouVkqysHLcen6B321OHI4AQz90ilkcE4FhZxFw8RAT6FybIkpPDBAiJ/Fn?=
 =?us-ascii?Q?tq15tubfxYAYH6C3nBfXMys1Em/YY4TzqMCzP7NgbVvgRxxgZ8tOis/bCg9q?=
 =?us-ascii?Q?4axAtsPZChyO5z7T1yaVYUIF508ze0TRnlMg8MugIBsXZUCCLK5aDi9XWgq5?=
 =?us-ascii?Q?SSQLGHXZtNlhdN8CCGZrpdbURqII4FBdCn+t8Yzt4OdZfD3fHrTMUtLAk25q?=
 =?us-ascii?Q?jUUFpfcf+4kotLOUe2bbl+6xMW1Wnz/W/WKQR5bFh2QKEHf7qixgK5Tgs1Vp?=
 =?us-ascii?Q?+Sg/6A1fPIQZw9g/FYVfQV/F3J2lSSEW4FyLu3YUZMsQ0AYx4W4+1dx9PBTY?=
 =?us-ascii?Q?Wr6x0DhKm3+SGRZ0zbzFhuMXjvOHPOFPTCtJ548SNTTdZgT27m/Etw5dNFdF?=
 =?us-ascii?Q?enGHtCMJS4ZwRwWXb1RJCADijaxbkL6OKHo/5Sln9xWar+b95RVD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17015562-3d81-48c6-9a1c-08decce1f41f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 02:33:17.1342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vOa4U77T2L7QBMy83X4uvj+J1ZPkAql5aWns4rKmlpzX1pEYrSd5rSVdWFWmMmhcu760B1w1SGOkaHsN9w4dtVrFI/rmCbua5AQMRX4rVTc7aQrLhKkimy4VdlceTMIK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9374

From: Shengjiu Wang <shengjiu.wang@nxp.com>

After pm_runtime_enable() the AUDMIX block is powered off and stays
suspended until the first runtime resume. Register writes issued between
probe() and the first resume (e.g. from DAPM or ALSA control paths)
target unpowered hardware and cause a system hang.

Fix this by calling pm_runtime_resume_and_get() immediately after
pm_runtime_enable() to power the hardware up and enable its clocks.
Release the reference afterwards with pm_runtime_put() to allow the
runtime PM framework to suspend the device and switch the regmap to
cache-only mode when idle.

When CONFIG_PM is disabled or runtime PM is not enabled, pm_runtime_*
calls are stubs that do not power up the hardware. Handle this case
explicitly by calling fsl_audmix_runtime_resume() directly so the
hardware is always initialised and its clocks are enabled, ensuring
register accesses succeed regardless of PM configuration.

Fixes: be1df61cf06ef ("ASoC: fsl: Add Audio Mixer CPU DAI driver")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
Changes in v2:
- remove the call of regcache_cache_only in probe, rework the runtime
  handling in probe, call the pm_runtime_put() to enable the cache only.
- refine the commit message

 sound/soc/fsl/fsl_audmix.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_audmix.c b/sound/soc/fsl/fsl_audmix.c
index f819f33ec46b..2885cc10b02d 100644
--- a/sound/soc/fsl/fsl_audmix.c
+++ b/sound/soc/fsl/fsl_audmix.c
@@ -457,6 +457,9 @@ static const struct of_device_id fsl_audmix_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, fsl_audmix_ids);
 
+static int fsl_audmix_runtime_resume(struct device *dev);
+static int fsl_audmix_runtime_suspend(struct device *dev);
+
 static int fsl_audmix_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -488,13 +491,25 @@ static int fsl_audmix_probe(struct platform_device *pdev)
 	spin_lock_init(&priv->lock);
 	platform_set_drvdata(pdev, priv);
 	pm_runtime_enable(dev);
+	if (!pm_runtime_enabled(dev)) {
+		ret = fsl_audmix_runtime_resume(dev);
+		if (ret)
+			goto err_disable_pm;
+	}
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		goto err_pm_get_sync;
+
+	/* To enable regmap cache only when runtime PM enabled */
+	pm_runtime_put(dev);
 
 	ret = devm_snd_soc_register_component(dev, &fsl_audmix_component,
 					      fsl_audmix_dai,
 					      ARRAY_SIZE(fsl_audmix_dai));
 	if (ret) {
 		dev_err(dev, "failed to register ASoC DAI\n");
-		goto err_disable_pm;
+		goto err_pm_get_sync;
 	}
 
 	/*
@@ -506,12 +521,15 @@ static int fsl_audmix_probe(struct platform_device *pdev)
 		if (IS_ERR(priv->pdev)) {
 			ret = PTR_ERR(priv->pdev);
 			dev_err(dev, "failed to register platform: %d\n", ret);
-			goto err_disable_pm;
+			goto err_pm_get_sync;
 		}
 	}
 
 	return 0;
 
+err_pm_get_sync:
+	if (!pm_runtime_status_suspended(dev))
+		fsl_audmix_runtime_suspend(dev);
 err_disable_pm:
 	pm_runtime_disable(dev);
 	return ret;
@@ -522,6 +540,8 @@ static void fsl_audmix_remove(struct platform_device *pdev)
 	struct fsl_audmix *priv = dev_get_drvdata(&pdev->dev);
 
 	pm_runtime_disable(&pdev->dev);
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		fsl_audmix_runtime_suspend(&pdev->dev);
 
 	if (priv->pdev)
 		platform_device_unregister(priv->pdev);
-- 
2.34.1


