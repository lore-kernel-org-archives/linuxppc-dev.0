Return-Path: <linuxppc-dev+bounces-23997-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DF9C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2026 07:09:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxNHB6vsmz2yS4;
	Fri, 10 Jul 2026 17:09:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783667350;
	cv=pass; b=XCT5nRnTGK4QAI0FHVAV9sNrJjDZ5pnHXOCDAzU+SvdU1XBjFf3LM+CMXoOUiw5sx0GjUHZtjoZA4lN9wfBpWT2OFnmP9xugNUxrJCiQHzT3vH/iugMuq8/73XPdGkawNj9+mK1q10zIfCExhRypEBD/o73A0ZEjKT3pJHtOGAkPD391Yihh42gezYWYkHTNJhn+Rlbua05Ic7yMMs/BicdRYOnBjGyYqIUXqIkrCPOk/8dI89kWDa2jkAsnvrWveNpbR9OfXmc278UvJC1EoVu+66OL67HpzwQ/JGqPmpW8PzTkn1/o6ArPW9l3v1bNMY1Q20WtkJrMmRyq+Zlz3Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783667350; c=relaxed/relaxed;
	bh=fXz2KLNXCGaTtaWQqa4S9A5s/g+I7F5MKHvGmyxCPFc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FlmSEqjhErqJJCNfkHkrcHOKQkkKlSYYbsBf+nPTfP5L+iFpDLIYkGLZaepkFSpXSLhKPkYSeQguDtz6Hg8I7HWo7VvEPIkQKBf2PY7x8VRte+lp0tSDH8yqTDEn9XtfjrNIKAiKopv9LSE1MAimjSX1Vi8TEAW1kFpmC0g8aYqR099f1O9rpl1FHNvykJM7BR2qDoEdto0VYTZkS0aju7Dov2upiE1a2CFPbTx5vxiA21yGv6mgFyt+jbuaDH24q//HXWG/44PwKcyFcWQQfH2Q9GILCpp44ppYVrFAoXQu866V2k4QTXsIyKAwQxpA3zCTsmmMsAI0ryP1hx4z8Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DkxdcaSB; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=chancel.liu@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DkxdcaSB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=chancel.liu@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxNH96gX6z2xlt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 17:09:09 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4KzD+w5Gi7+zQkzAvjg+3t6XBqpcf3yG5IDQmUagfI6nhXTZuPzzHLTwSkHPqyDgkpTNQRz6m/d5IULC6JZqHUjk6UWa4sVtj0Vi2Zytqv1YfhRQmvvn5kyO18ddD3K3VESM+uzsf7l77MyeKq/zCm+lHkIQNzxkXvbr4pbdYn+DkdJ8CeMQ/gLDvwwF4Hkmv5OJNEdC1ymdOf9l9urrTLkpcFFZQynw+FmRh7vkpJ6xozLB1VAeSJWaZSR4K6293HQoJph+UFsAguG1J1zpDRdrAc4kEOqAsbB7XSuN9Fy7U0bJRfL0HLSwSKbJQFQiZCcHgANzAmvIcvfEdUWrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXz2KLNXCGaTtaWQqa4S9A5s/g+I7F5MKHvGmyxCPFc=;
 b=Ms4GYfOfzlC1nkstAleOCCSFyjQvfHFe0Z2hL/6eoFzss62qAs0KTMy+LRkvsyHJysc14pU+NdBVFNrnXwWWwXbNtIGcxXPJINsckcWAdZO/vNICsjAJ1moufa/kc495Krp7uT+g1gdvQZqrjdOfHhPkZivLBAW/50lICUcLYAoG88N0k4FMEX6qx1pLt4tafp9osMFSAIX6wIpoVTrau9thRBckbD9G3wAsQsvqUe+zUlkjqCm5g5v5jE5gRW5kPB7klBfPAjqOZr9+pkR8CmOR4Jx0Mgbwp+oLJuOyMNlTKKNYNp3ukhRFY9xMBWNn4waGAL1fPCvewRxMBYoFxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXz2KLNXCGaTtaWQqa4S9A5s/g+I7F5MKHvGmyxCPFc=;
 b=DkxdcaSBTfULdCEZeNPzH9uos/hqWE6bes9Zh5RoqLPNJlhtDgU/CYKcZi5dC3CfdhubYYWi6HV9u4t/ofJX0Ieoq9/1AKlE4zugdi+7N6+nf+wU5NeY9xJDWnpj88hVOLricfffzv2uM/prtWevPRPmcu85i6oC7IUv5jYE4KmcT9L8TNU+UUtGRiE16lXYB5BgvhJQdODDc1EFIvXCuRMyhjv/mnYGtqsNSkXUsxap/0smnvzCswXEKSMIqvCbY3J88JYGUZlj9PgFS6z51c0pU9vm+nyH4hDsieA01rEo3pwIl3lQIMvHNhT8uAe8eTJfunP/bCgQdVGTxBXxnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GVXPR04MB10021.eurprd04.prod.outlook.com
 (2603:10a6:150:112::20) by GV1PR04MB10199.eurprd04.prod.outlook.com
 (2603:10a6:150:1a8::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 07:08:42 +0000
Received: from GVXPR04MB10021.eurprd04.prod.outlook.com
 ([fe80::d247:853:3e16:1994]) by GVXPR04MB10021.eurprd04.prod.outlook.com
 ([fe80::d247:853:3e16:1994%5]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 07:08:42 +0000
From: Chancel Liu <chancel.liu@oss.nxp.com>
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org
Subject: [PATCH v2] ASoC: fsl_sai: Fix spurious BCLK on resume by clearing BYP
Date: Fri, 10 Jul 2026 16:08:35 +0900
Message-ID: <20260710070835.3749817-1-chancel.liu@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0040.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b5::12) To GVXPR04MB10021.eurprd04.prod.outlook.com
 (2603:10a6:150:112::20)
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
X-MS-TrafficTypeDiagnostic: GVXPR04MB10021:EE_|GV1PR04MB10199:EE_
X-MS-Office365-Filtering-Correlation-Id: 46f5c565-7272-4680-3a36-08dede5212eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|19092799006|366016|1800799024|921020|6133799003|5023799004|56012099006|11063799006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	IaUR+LhVIsQaOvRqBkXew9pkoOewUwZWTtTCoYPGgESGGrSyqWKwhSnnLeSCpaTVzv8vbwXedLNtbDKpgW91YDZQ5GXrJ7spYf09UOHIGDU2og9rP/3DHb1ZUAUUgqhDvngIJFWQ0VP17d40//bGMMQTWtCH8HTEYgwXV+SG3y+GZUiUXgoCPmP/UJyT0F7Hg1/Kz6alT/yH8JE4epBejsbCyPXcJbDwK6mFtyxc6dAx+xV1KmIK3q6STkyWBFltPHJwqhzbO7vcEteOCWl64KfCpbSFPVjfa7rXd+9BqcCIKgmHHzMHmefACBnUyk/fxYx+yp76IWbInkvrJFsVe75qpN2pa/eee9SmV/gmrYdiKFV1lmBxvlMAqRpC17e7zqTyLeIs0j5sgYS85LP6FunGazughrmkEG8VQeNqqslKd4zF4NtOdepqebujqW0mBm9EGTid4VekXD0jb7KFc0g5J0538Y4zFBmiFyKhALu8AKPK/+QVWMREtm3aB4wJSUS6l696oy5MC4FqPzswkFQK/vrrKqTBoakqtu0juRYlM3XLWD0b5iu6ouOBljP0whL1TlbzDqng6NcN3pPw1Ztu9Xk5F3e+CLdJQ6tlThY6Gwm8k3OlbRugrwFABIgwZAp+wFVSU1QBzectFwqdO08cXr1InI5G0+Ul8TPoa2ypz/5t3v6v7RHglVpWfKSm80RHHCEQNMocIfE6TOjcDA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB10021.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(19092799006)(366016)(1800799024)(921020)(6133799003)(5023799004)(56012099006)(11063799006)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y9+63qtdu2ZW+A4gCSM68z1eJBkaje5IkxPOPEjBOCbVfXdh8ziBQQIvId/I?=
 =?us-ascii?Q?mXMEbFMlN/GU0XcCgb6S0ENOhXcDaK1LeWL8wDYM9ProaWloWBGZmqJjBpdI?=
 =?us-ascii?Q?OdZbbUPA0VPHQG7KbJUwFnCs8qSrX7m2InveCwALsZl+K72JGDq9JCu7hfU/?=
 =?us-ascii?Q?bWnisDlYUucA3Ts1cmlftVdtbmjp/97ftq+QK7PBWKCOe2D5rcb50/EARwNx?=
 =?us-ascii?Q?GYFWqEmAf/erMbCSSbQ7AHsIr3SIh0O5D3IRLBtaX9sOpUjq5iQTP5Dsyn8M?=
 =?us-ascii?Q?kbvR4id/lZ+UWoZSg33JUDtGeTjCpiqXeMUsJMDNaDBqauv/VA5bPd4R0h+e?=
 =?us-ascii?Q?5hLf2SN8ubfe6DZVlrL4EjpmzeBLy7T/ew8dm/ZSnI+s43TiCi5HROh6aYzv?=
 =?us-ascii?Q?uSVZlpzMBaZAlaVZdbr87NazO4wp9PeiSMil1EFemUFilL9d1xvZAWJkXdo+?=
 =?us-ascii?Q?GezSSAwT8OQcnD4BgDEi3EGPL0F+TfHhIz4/847YjD6+xmyhly5MyiNou4xX?=
 =?us-ascii?Q?l9MMZk3XuWXH9bmkPE7cYpkF9KbG+P6Fb97sb/NC6SjlK4Nm+QXpghQkgPNJ?=
 =?us-ascii?Q?7JqT0bvuYg5FiWVcOWX5lVloTywpGlWwT1XI6gzu5xgptKgjuiHdOSfrvZWH?=
 =?us-ascii?Q?yj4CVjexxvIvUaYXM2DpDHabvMimgvKmBVs+OKUt8VpLSf7AGbZ83SZbw4MM?=
 =?us-ascii?Q?MTMbEF4uP5MtltUrRTTLJEYD3fB+YRE9tuaAZfzkLQb54uvCTg2Hm7FPRkv9?=
 =?us-ascii?Q?sP+0rI2PSdd9pTFwJ8ZBQ9i6SZlp605kYeTvPlwj1ab23DVEfDr9QDoqQFBt?=
 =?us-ascii?Q?s1IazgT6TNTc/X54IL4nMs6AvfzWo8vTySMwnoBnXz5GopyLerVlfzu9TGjC?=
 =?us-ascii?Q?NkmylMUmFtuVoMeFxf1wqiPPPghVAI1T1C4CBmmU1eEXbmA0kh9Oc3nWwHrt?=
 =?us-ascii?Q?aHSJD7aIZ5AuNfZ3HTNcQE38Jx+2X1XBoIvVDia1IG+iGF6unfILLQBlChTt?=
 =?us-ascii?Q?OyAoI9vgAuIvGVXMrfODdENOA6hVI14NBMADanY6PPG9L4ucgoLFRRjDMzVl?=
 =?us-ascii?Q?nIomUnIqpvT+nzLKxFw2H36SjT410DtDhICfI23ovHoK/xKMLkiA7ChNVWXx?=
 =?us-ascii?Q?py22J8vvxQxlTyl/M2f5IVUCY2eb4+ishAMeJ/BxTHXxcyH4AphzxXFbDtKm?=
 =?us-ascii?Q?wJKWLBYBrTM9dOJeTzOQqG02Fih+BSoJ77Dp1m9s+dxMNPKzyRuPimph2Ghx?=
 =?us-ascii?Q?gTo+j+/rwGmBdRbXS5IJuLK0mD56zt6iNoQPajcdvby+IsSPlaOuCgKCJIf4?=
 =?us-ascii?Q?UF19cvsNa8e2Ic5b205K3LrZ/zAGjD2HyLOGiJlXdQR9ygVaJUBiVkTeJC25?=
 =?us-ascii?Q?PtZvO7RKt6vlV+bNXUKCOjIWuHcubC8Nst0GpgMhQ2QolgtN/Bga6MSGRaJ6?=
 =?us-ascii?Q?JK0GrCUxp9wq9F05dkOzsNes8HWFyXNOpDw06z24qWMMdxGAgNpnXiP1++40?=
 =?us-ascii?Q?LSUWSRXeYuZ/4T3Io/XJ+1yXznnAtvZJ5PoykG9y6lkEIVBgZ41KmWZYLC0l?=
 =?us-ascii?Q?jN9HhZ9psyuH1qu2hQxoZoX8t0KzD49b6R1qRuQiH0geT/ykqE3seaTzTXMW?=
 =?us-ascii?Q?ZOF0ju8KEluLXJt3boVH+6BtEsbm+J5gn+CH42kjdA5Z6rwx/AGYJUG25VN8?=
 =?us-ascii?Q?ICooxILFXKj5rb3vreLU5odSz+UD+2Lcr542TpSSUsUfoD1fdypSY3YA+Jnq?=
 =?us-ascii?Q?01J1IHZWWfo9ehIKfmMph60hKRNEh3CkGsZTqS2J7Augb0MA9YkC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f5c565-7272-4680-3a36-08dede5212eb
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB10021.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 07:08:42.1199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XxtiVTvb1/rk/qrWC/U5PQ973Wjb/Q7G9beV8J2PaEcTY0B3dx0wSZfD7eN7O6fKZaD5bh6qvvjBokJAHhZFCchx8k1F83encSwkBC9GI23QtZYQJTNiA3JHLJGtdqj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10199

From: Chancel Liu <chancel.liu@nxp.com>

When the BCLK divider ratio is 1:1, fsl_sai_set_bclk() enables bypass
mode by setting BYP, but never clears the bit. The BYP=1 value remains
in the regcache, and is restored by regcache_sync() on the next runtime
resume.

Since BYP=1 combined with BCD=1 immediately outputs the ungated MCLK
as BCLK without waiting for BCE/TE/RE to be enabled, the clock is
driven prematurely before the stream is fully configured, causing
noise on some codecs.

Fix this by clearing BYP and BCI in fsl_sai_hw_free() taking into
account sync mode and the opposite stream's state, so that the regcache
holds BYP=0 before runtime suspend and regcache_sync() on resume will
not restore bypass mode prematurely.

Fixes: a50b7926d015 ("ASoC: fsl_sai: implement 1:1 bclk:mclk ratio support")
Cc: stable@vger.kernel.org
Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
Changes in v2:
- Move BYP/BCI clearing from fsl_sai_config_disable() (trigger path)
  to fsl_sai_hw_free() to avoid breaking pause/suspend-resume cycles
  where hw_params() is not called again on unpause/resume.

 sound/soc/fsl/fsl_sai.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 9661602b53c5..d232c8f53061 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -808,6 +808,8 @@ static int fsl_sai_hw_free(struct snd_pcm_substream *substream,
 	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
 	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 	unsigned int ofs = sai->soc_data->reg_offset;
+	int adir = tx ? RX : TX;
+	int dir  = tx ? TX : RX;

 	/* Clear xMR to avoid channel swap with mclk_with_tere enabled case */
 	regmap_write(sai->regmap, FSL_SAI_xMR(tx), 0);
@@ -815,10 +817,29 @@ static int fsl_sai_hw_free(struct snd_pcm_substream *substream,
 	regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx, ofs),
 			   FSL_SAI_CR3_TRCE_MASK, 0);

-	if (!sai->is_consumer_mode[tx] &&
-	    sai->mclk_streams & BIT(substream->stream)) {
-		clk_disable_unprepare(sai->mclk_clk[sai->mclk_id[tx]]);
-		sai->mclk_streams &= ~BIT(substream->stream);
+	if (!sai->is_consumer_mode[tx]) {
+		bool adir_active = !!(sai->mclk_streams & BIT(!substream->stream));
+		/*
+		 * If opposite stream provides clocks for synchronous mode and
+		 * it is inactive, Clear BYP and BCI
+		 */
+		if (fsl_sai_dir_is_synced(sai, adir) && !adir_active)
+			regmap_update_bits(sai->regmap, FSL_SAI_xCR2(!tx, ofs),
+					   FSL_SAI_CR2_BCI | FSL_SAI_CR2_BYP, 0);
+		/*
+		 * Clear BYP and BCI of current stream if either of:
+		 * 1. current stream doesn't provide clocks for synchronous mode
+		 * 2. current stream provides clocks for synchronous mode but no
+		 *    more stream is active.
+		 */
+		if (!fsl_sai_dir_is_synced(sai, dir) || !adir_active)
+			regmap_update_bits(sai->regmap, FSL_SAI_xCR2(tx, ofs),
+					   FSL_SAI_CR2_BCI | FSL_SAI_CR2_BYP, 0);
+
+		if (sai->mclk_streams & BIT(substream->stream)) {
+			clk_disable_unprepare(sai->mclk_clk[sai->mclk_id[tx]]);
+			sai->mclk_streams &= ~BIT(substream->stream);
+		}
 	}

 	return 0;
--
2.50.1


