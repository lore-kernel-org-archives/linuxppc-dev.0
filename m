Return-Path: <linuxppc-dev+bounces-22678-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03475CD98DE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2026 02:58:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfWrs2cPcz3bqh;
	Tue, 16 Jun 2026 12:58:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781578567;
	cv=pass; b=bPThfrUTxYC4kOC0MtszMZ1mT62BJHR3a5DpDsZbzwOx8uMwgttrXgUNI44OtI7zJZC6AVTZAcy414I83rUDHSpMU5IrqCHpejcFScNn9Mr786oXIAs/Cq8TAGx5NdMrPvUlEQXiJnV6STWul8BVyv2S3Ga12NLzvUibV1OvlJtgpKHB+n0G1tbt0m2AntTallIHdqJCXN12ZEe+OY4i93FQZY2mPxHOJeztYYvzDyO2yNeuF+C5A15AIwlQU8dNbE2nh3gf/bhTALFw/A3mNUF+cGmiKPXfzxdDBHb7nNJRIke27ADxZ2j4M0JAAZFXe57W0GkSJygtUE0wEPijBQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781578567; c=relaxed/relaxed;
	bh=VniVVmey6R8v1LIKXBxYX526Kc1k48PWa/K1A3y2JAE=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fHWbJCIP7AnLp1d9XJ7gfYOAKMVLy8CWGmXccqJr7kvQYT9XCR13LFlmmdTC+9qZ6UPjbWMDJxStuAqg8hJsWLLWs1YcF1Fltx6s2urOngw//ug14uhOG9L8zgv1xIjD3f8gdL+jFGfgR009KrmWnAHjt2CiZ+ZDzEkWghUq159zF9aAZ1wVc64G1tNxG1YogVPjRzAZ8n8a6uzAccI5lAYfdS3fsaidSerosgmO5w1Qb0vFHsYK6ZBdrPMmvy8QGXYY+41ShZ/bnXD/gNDn/XfcMThw4fk0i/u99/x/WxsRZpdfL+pEtOGBGkcg3SyGVeqGSZzT+vPnaYe5o63pGA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=wIfvxsun; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=wIfvxsun;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfWpG2LPgz30FP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 12:56:05 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/FJrBEx3jKrUtxZdlmFrSqCfF9zrAE+bYtb/yGecNrw6fNJtBjvLfCB3tM0lwvyVxVrUirfNYOeBoSFlbKE0I9n0dskzp0eQJg8PekRzwx2BabnyEwBuqGOmhWyTBgWxJaOWnYl0xYvy4CD/L/F790sov7lp50KJPMtU8R+AMMCoY1dvOZjSOr+OhNUpuTKV4n6x1LLphxfhIoQ4iLEycF9C2hIVI93zUhZlFwX9ctgPWvn3uXjsb5seNa6hwQTpukeYnxfN0qJub75Q/svMtmhaAV40/4EyaoTUqhy6HDSEt228VgMNDAShTpzpoiDx5f1ziCLQg3MKMIaqj8SYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VniVVmey6R8v1LIKXBxYX526Kc1k48PWa/K1A3y2JAE=;
 b=RBRL612fj6IzeQGnOKsjmmjYm3k21oYa3Otf8HhwSicbVMdvPOFY+1ObcmzYLiJHZ7GJhHq+lHvr5aU5X6jcWOKWJLTZYnXD4019wcR4P02QwZ6KmqP0ud8magGhiR6c5J1o579b37N1n8wX7zt0XIqCONbZJRVf5tOEnTjid8P/xsr2meI+rntma0cIFX9xS/8mfkc2eRYIG/Z6A/AtqUW3tw786qGlIPTCttB8ltQobA9RxyQpz1cWSlglKHACUg4OEy6Cr8tGSzP7M23cBuEo9iWkWMhQl37y4Fl7BvU0VsVUUufRpwvfuf/2CVVuks1x8FC7ApzDrMJoLyn/Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VniVVmey6R8v1LIKXBxYX526Kc1k48PWa/K1A3y2JAE=;
 b=wIfvxsun8maovHvm5OP+RSwHRf0p+854NECV4RVvPDhbk4UOJJ2X7zDaOcrwu3pj2xm1b5IM51bjNCa0MS/vVLIkJsJZEATetb27Fp1KD8odgHFzj+jOotsrW2Oh0a/SZYskljx7RwmC99galgudYaPavNc6tYDbzWJcnZ7E4z/o6lBbRfKk+UeHuhVLitKfjlL4W1C6jyX/1z01h63h33YxwYRBKTtCmIdLdsQWLSyEFv5uZ10/jwifzm1bukKIahQct33+s8G3uEIPx/9CUVCqpWMbP5vLwLM3sLPMwdmVyDg6FqaGa3bk9IeSGf2kbnJDMwdPqMHgXlvGs6iNtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by GVXPR04MB9804.eurprd04.prod.outlook.com (2603:10a6:150:114::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 02:55:36 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 02:55:36 +0000
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
Subject: [PATCH] ASoC: fsl_audmix: switch regmap to cache-only mode after probe
Date: Tue, 16 Jun 2026 11:00:38 +0800
Message-Id: <20260616030038.4170204-1-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0147.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::17) To PAXPR04MB9351.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9351:EE_|GVXPR04MB9804:EE_
X-MS-Office365-Filtering-Correlation-Id: c361d2ec-2ea2-47d8-6801-08decb52bde8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|1800799024|366016|7416014|376014|18002099003|921020|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	1wAQHw5t22yw11abMCqSi1FvPpVECM3SFczq2Qs4KEmKuW3Ej7y8BSKW6+N96jg3j5eUfUX9jVQkLKY4GzS2SvOLHXh87H2t7aCJzZGYgKryqb9fN4/amPiemiZB3qb1bvpe+sppMy4hp5ZvLlf+ZMg4krkNlMqdgHN62fZttTUdqU1zfUbKbCIl/Psln+BtVrUEJ6GFD52vGYjTOmzQQe+/Z6sbeC9WnDvlDFZT92+YIJU6AqqAj1mci6HN2n0b/aXVb/eNjUYi2xKQaMaLUHJLpdFGPiEAXmiQ36rMLcBQ+UzfyGfkQ77HiwYwbetBVWvldJwBbJ1NJ3EhcblnObKXXpOzrhhlvTsDHYmBEmLM+QMBjmOwNFa3UZQk80gtesgtZ3wY6ytD/URxwrKGLlZOWK8e3jyaRsKmIeVxVXWtQdYCbOQq+oNvhRiru0XDiBlNZiaeR9sybj1YaVMUUMYMF851t5v4rYo8Ln2hjC55/2aJ+XMw3dCqPQ4v+xYPo9oFkBRg0vM5xh9dJWKBAsP8KmTAmrwVcOm9cPe7PiYn4xd8zog5DTA2dmNWhmEvLdKvqOkYI6GsoDihARMcy2J4zVBzb557yTghPw1xCm6xFwTvPjV+oTqPtXj6mJU00UfzO2L3SBOvmKvmFiLNi1/B73CQBMtzcdc7xXOy5m/WOS6Dg/nIVPB3ymZCupnkH2bpkwJCDW3rhLdgNzpj3lTxtG2TGWRaiT/eBnUqGBA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(366016)(7416014)(376014)(18002099003)(921020)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XhZKuQ3sUy3Tu8iwTQz91o5ybx0uC4CJwWckVp+4B9kBUVF0X6U9UKURHPJB?=
 =?us-ascii?Q?y/iZrJxr4rMRhdxKu3MHKtOoPhXqZfXVudgFUWUy5ExEla2+0qIKmCjhYy/z?=
 =?us-ascii?Q?olzpcJH4Gx5aCjQPLe/QKcGS8WrXAd/LmmS7yOykVZdnLuuiAG3YBUtycPkr?=
 =?us-ascii?Q?hm4/tgz47qZFYs29/+D/2EF6CO2/AlSbV16J2CEZJZH5vZRIZNDWzdLHshIm?=
 =?us-ascii?Q?3q8EooPrKnh0ctD/+7YrvYoLrtNki0beyeViQ4u+zYBKYOcy2msQbbtTGd/R?=
 =?us-ascii?Q?bSGZn5+5AL03fQV7IQsHYwG6lOXkc8XV7pq1lVdIwF39MT0lFwjreH5Kby7s?=
 =?us-ascii?Q?cA6v+7p0mCG4bkvFRUGK3Bsmyeot6aMOQcGigUEJoX26LUPGD/swtVQLd/oT?=
 =?us-ascii?Q?wKb3h4Qj4HYt0b1eDYndTnDFVMAIr8CKm32X9ScQrOVIJYInvhSjofVzPIJ0?=
 =?us-ascii?Q?XxaZLUw31AWC5h81+HaHHnZ+j4ucOYB6TwJ3PiZ9Auf4ib7dATrpZVlnkYaN?=
 =?us-ascii?Q?reOI1hbzRITP5ucTRQhY7GiThckQ0eqCFqieaVBm+RUMRFRcdCzPedbCOQB9?=
 =?us-ascii?Q?NPTisOht2vpAqw2p9mheYw58yeZ6f5c7EWiust6YomUK2IZz+la7CYFUhHgl?=
 =?us-ascii?Q?VXrwpU70NnRr28qweF60oSlFGPQvjbUK4nEHrkaRXHWRKIfWHjAi70PRJoLt?=
 =?us-ascii?Q?h/3Nhp2utekELiHavki4+xE0EivI/U48kJdwvctsRkpZAchdH/6dESOWrvtB?=
 =?us-ascii?Q?hFO3xdsiCRLtUpso+e8PkmnbN9JH4yovQD2Ye+XwkUlYEMxQuyNcfPKTrGOJ?=
 =?us-ascii?Q?tGpwzsMMvGppZjaWG2jQZIU1QVCLf6pot9yYl9Pb/ene33CV+LRG1Wl5ilQ9?=
 =?us-ascii?Q?BHKvjz0FBY2HWfM6u2orHC+r13bSTt6T6Ea4ALl0UTtlhjCLsv/48Js35rKl?=
 =?us-ascii?Q?h6ByXP67CU/djwFkte1YaGXY3X8sFeqors964vjA7LbhEc1eHIfp81TfiUye?=
 =?us-ascii?Q?HsVjc36vyDk2mVJV8FHvqD55SfziBQlPz7euoZBgFr7MqPYWnoViOgVrBhKe?=
 =?us-ascii?Q?30odjWmrtlowt/lNLhYn/CZgCUd5vjcwA3+6JtPeeCHvdFtrWiJRikIrJ0Fs?=
 =?us-ascii?Q?ZSzZ5lESkJ8A/awwcJlKIMaBY7hUH/Pt7N3vwKZrfcosyGCUhi2XwaqEN1lv?=
 =?us-ascii?Q?vP5TujT3PkgEL4zov8BTHwOVyp9zs5mZYQMgjz9ned1+kvUEjyvQPxzTelxH?=
 =?us-ascii?Q?NRrpnYso/RMrmnvEh6RiuG3vCYsUFpnVb/V7BMqTOfaqBJfbbINzbXa6SQHO?=
 =?us-ascii?Q?mly09S6Tbe5vYNnl8rFX0uP874xbumcJoFBYOI1+RWHmKrZ8UMBR3pTuYEll?=
 =?us-ascii?Q?+2H4aAhw8iTqQiA1fnvVo67IUj/7O9j4lTc7ErB2mixoKgwERUvEYWBLCTfc?=
 =?us-ascii?Q?OZdNjxtskxf2AN/gOliXwjd19aoxo+i1q/z3iAgFts4gZGjS50ucFiytmiuD?=
 =?us-ascii?Q?G5l9tf1cObGz2Ilmvg8KAQ96kq9l+RReSwwrTy+Js6NSVKW69D9TjimbuDOP?=
 =?us-ascii?Q?xSla9dqs2c3225B8kgtRBX5fqt9aL4BzM8ntciyEBg6jzzHKk16zyUJ89jN+?=
 =?us-ascii?Q?oJH7jyAzO7Cmqn9AbEy0RZxGN+EwXxdLv6IxaOF4LIaUfaNajF44C3KL4Bu6?=
 =?us-ascii?Q?3hiuXOhr3u9d2XZzxmrc+aKLznhVPejZdEyDbRsJcNkrnn7b2rAlyqeI30qF?=
 =?us-ascii?Q?KPxoXcTzD6dUCienRWK0xwvQSJ8Mbvrz2Gjv9xXeuV9ufvTQWzwd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c361d2ec-2ea2-47d8-6801-08decb52bde8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 02:55:36.8878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RNe/lazOihNxN0+8JU1UcGzLJAqwkBRMppDN4lBfjKCqJYVDcDBxSmoBn7MJnxljIZ21800bvd3ZTm3tuvWfbC4pCkvr5dSiP3gmlTfuQZer+9vJkZcfBfqwlRbQi17o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9804

From: Shengjiu Wang <shengjiu.wang@nxp.com>

After pm_runtime_enable() the AUDMIX hardware block is powered off and
remains suspended until the first runtime resume. Any register write
issued between probe() and the first resume (for example from DAPM or
ALSA control paths) would target unpowered hardware and be silently
lost.

Enable regmap cache-only mode immediately after pm_runtime_enable() so
that register accesses during this window go to the cache. The cached
values are flushed to hardware on the first runtime resume via
regcache_sync(), ensuring the hardware is programmed correctly when
power is restored.

Fixes: be1df61cf06ef ("ASoC: fsl: Add Audio Mixer CPU DAI driver")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_audmix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/fsl_audmix.c b/sound/soc/fsl/fsl_audmix.c
index f819f33ec46b..0e6586a2ae69 100644
--- a/sound/soc/fsl/fsl_audmix.c
+++ b/sound/soc/fsl/fsl_audmix.c
@@ -488,6 +488,7 @@ static int fsl_audmix_probe(struct platform_device *pdev)
 	spin_lock_init(&priv->lock);
 	platform_set_drvdata(pdev, priv);
 	pm_runtime_enable(dev);
+	regcache_cache_only(priv->regmap, true);
 
 	ret = devm_snd_soc_register_component(dev, &fsl_audmix_component,
 					      fsl_audmix_dai,
-- 
2.34.1


