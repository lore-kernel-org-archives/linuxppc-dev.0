Return-Path: <linuxppc-dev+bounces-20070-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43850FE5205
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 10:36:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g28Wv4jkMz2yxl;
	Fri, 24 Apr 2026 20:36:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777026987;
	cv=pass; b=WCWaQHlfunYLXXsZKFW7ClGsOecT85fAFP06dKRhUqdRwtezENE8klcnXGcEAi/j9o/Hi6bQSxoQsJcjR3Dq+35BGMR/PkNj81DfcGM7Xjx11V41xJfA+b6ocroRtUoUuolX3O2PXjSem2j8guTG093mx0R+mOA6WUmRDfyPtiPPN+Xs1QFhlnZifcKutN1sjKNOwv3pU8EPHDCB7rvkuPJKF0LY9PtMpBKdB9Rn9y+iZaEAb+zm2DzmPGQsjk1lS+IpcE363pFaiPfZZ3Qm+r7V0L0wKDQAS/lunVuVH2nwZhMUu2NOyRXLXydvNUn4UKu0o2CBrtHr5cTJ/ua2Bg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777026987; c=relaxed/relaxed;
	bh=WGjcGfh6rZFSyH+EJF3nu7I+miScj+Z0EKlyoHzPofg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f/vA1vaKSjm6RzNTvzNRpsCCKnHhNQJOGtPJayf//V5cyuTjlikSKTkMDnMotGSiGJTzq2YOg7MdXT7JABK1NpcaV0/RHi3Jh9t2hi1uWrlkPvs3FPqyWGa++ySSppXOcr5pVBFdv5GNVAz1c6pcrFMGa1+7jDUH5wN00TfNq414kVXSqzrriH2jqeNSocoEdvTKJpqzqYx+4ey2n2QTihM1L9QN6pi3RHnZct/zFzNjuIC5xkcPumC+BuUyZnxa70AZm9/eKF6uUAxGtks5BI/8AmQRSMEQ9N1KCFOsgOBoq0tdLMk2Bz8Nq9ixWJGopCxv+Ssydy9yuSRd4ruQGQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=CshlOK0T; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=CshlOK0T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g28Wv0gRFz2yvv
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 20:36:27 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GoR5xtqZYsvJBVgJBZFHPZBDp3NVqqhpjrlPPvoOyuyueIWpfS90l+MXX6z1ppX6t7ETRV7iE4lr6zy7BmLkGOKdpjtklNBJQFl9gcI4gacA+AObXZ5hTgZ8RzgqQzwjQ17PudV9xVxwJ3MqTHBCGSI75hd8z5FtMGBvZT0UChiUBlp4qP2ZR/4C7HHblcwXJHQSS5IfqgTwhDLrOWFW28UBesURJmL+5Z9Ok/nE1Pmb99k11RN9AsXc/5Y9+l7dJnNuBG4X61tnVd2EvDH6Gs8Pq7WOdSsjGl6nzmVmDkttyGfI7LY7hcHfVx5ElTPex6ubtLJSWJyXYIK4XShA2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGjcGfh6rZFSyH+EJF3nu7I+miScj+Z0EKlyoHzPofg=;
 b=Pf2v/tKEy6XkY8HtmyjRuuR7O1LIaAvsbb044oZ6FVnqr2Zfs05XKSMudy/zYGzGb761RVVh8SXOvx/F+nYJrRz7x0pVU65SaLLGEd98GtMi9BNYZJoTSm9pFAXLXdadu/RXaeV3yzf+dA0aJ7RPF8Dszd7etMQlr+WcY6EWi+/JeexqlISPzOEwpignyqV69bAgE9/3y4oL0Rjm1p3pYeeFonVCSEc2NUcCctGYl0h2kkaTtWXf6wdnio05x7wl77XjO2N6UTr/3O7ujv1bsuHFlSzbIdbpT0QzLWut6DT86IcqqGTDxeP8GvklIdYuBjNoM5fYSNRczHrE/b7eyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGjcGfh6rZFSyH+EJF3nu7I+miScj+Z0EKlyoHzPofg=;
 b=CshlOK0TMdKFGCX5Ma4ar+sqB3sIp4yaoKN1ADq1j3qzsSc+HDMncTNQt17NbvNHx8TTsXwbZaQgDAfs3DKF0Yo3gC0PWwzMBDWy0biS3Ml17Dmgl4jmzndox1WkiKjwDiNM8eWMdiDfTi8LayOk3P0caZFvW1aOGqKCIFh/UPafaZJfbKOIDMe9cUoftb2HspPtIQ+wJLTEEf5dj2fGjJtJ5LCEeHkoktxsDxfamp+6LZ8lfjiCrrgk3ceaF663kpFyGLRs7lgUsg0kI7IHCSC515UhhV3w7BKT2eveweNkkIpgyVP8H5+VEqfRFzUiPgjslLb7MtsJ97CJvHpu+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by PA1PR04MB10698.eurprd04.prod.outlook.com (2603:10a6:102:492::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 10:36:03 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b%4]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 10:36:03 +0000
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
Subject: [PATCH 1/5] ASoC: fsl-asoc-card: enable dpcm_merged_chan flag for ASRC frontend
Date: Fri, 24 Apr 2026 18:38:02 +0800
Message-Id: <20260424103806.2276780-2-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260424103806.2276780-1-shengjiu.wang@nxp.com>
References: <20260424103806.2276780-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::15) To AM0PR04MB7044.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|PA1PR04MB10698:EE_
X-MS-Office365-Filtering-Correlation-Id: 5306537c-e76d-4ad3-b851-08dea1ed48d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|19092799006|366016|921020|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	v087y+0DMTaj8GnFIMrYZINLOJuAB3LWWiePysaqOakyXQOTBzYf7v5gHbBZ/3r/cR6fEZ3Xop9JeBNAHSHjvTjQ88xbmuylgSoErjE/xLgpMw3dYmqH9kUga0RBgMtw28+vRH4PcfoLlQmIY4UcVIMZJWNqs/cGQUiDVDGaVHMaNDW3tdL5Js0Yvg6AjCOAywiNgBUBoUxvd68CjKhjqvKZZLbOnBvgYO9dV29Y3XMwJUo4iAuw03cUf8+doW5E4wM/OT1p3WpIWCNQpSfhsK86qyeTa8nBrb3b85hR6LySQvINbQIlYbR9HfQuRXnN03aesNXAJb2frd23K2Xjgz4UBWOlDZEkoNVrStJa+YjqFRuGR5lOC4u52hHLHACHet7g/TXJn3fvrlH/xdD4Y/f1blQ8b55ypUM+H2WnSdHN/I7iRNu+gW8n8o1ZCl7YtqVy1BU0Ga9AmC8F9XRtDvHlXtFn02PA0PFjdZ5pVkoBBpIRefeaAx6iwOhBvITxrPK3mf/H2Yh3cYI8kGte3r9uG17lq+4peCBpcJ7qVcZeBYxes/PvuR17d1bNZfBOj2YurWqowyeigO+BCyUqMJqQZyGdzctJHuBYeKgjvGMTjopLiYMhFuWJHPBpWr81tLjHmvKTjB9t1aZItd8WXvMGsLf/rnSzbYMZapJLOhERSdTELXANM7bSvLCi+rbjthj69PlHyYi2vehU9KgljsQiSjkNMxR7v25lbI/sypV+mkecOUwaDuse8kvLxQ31mvnrHfXNOcegJu28mECqULXq6oEpXVwHWM+dHGhglsgdNOy6/XddC+fmwCUYxnrh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(19092799006)(366016)(921020)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6r1AkBJ3crex0Z/F1rFnX92Pnm6QlxhcIUVUyMuby9Bts2cV1CtvNUlkd8cS?=
 =?us-ascii?Q?NbAVCaI26B+KIpfXpPr5/uJxEofyEN56BCpMguGRNkzqnWY3LLn6VNf5nxtY?=
 =?us-ascii?Q?vuID52W6T7V66TNKQeotszIte4JiSyM6yhx7S2N2eMZFjmIKATt1y77Uz9gB?=
 =?us-ascii?Q?MALJ6P0BBzKMBQjfIxE9xszgB/AEDo8gy96+X0p40yps96ov5JLnZCzLJKvN?=
 =?us-ascii?Q?ZIXd7VZLL+AbkFtljd1PAYslJuRdpSsO3Nc19flSraTPn2J2kUYrqiwC7uev?=
 =?us-ascii?Q?aMOvrJKxYMTilcUrsx4JnwX8FQeaKfiHz7gCZTJn+ULiHR8lpDL9AtmSvkhg?=
 =?us-ascii?Q?rgABu5vtTBS8LZ/7qZf8ETw/5LdYAQZ6jSJJrxbFw2mAjCd6XXCPHja6M3yv?=
 =?us-ascii?Q?Jpu/s2Lqic9zPU1qv+xO4HgbINVOlYLJ51HomtaKG//Ecy97iu3/cJAkp0PD?=
 =?us-ascii?Q?WBREtIhv+toc7S9uhgGpQp9apGOtZGA3mi5fYiSqFVUHLa/67Ihorw90q5RF?=
 =?us-ascii?Q?GP/J1qpDwXX0DQy5b+ahasOzx3L2lPdb1WgRIeC32ZJ5NRaM8KDk3gRrjIyh?=
 =?us-ascii?Q?5P9iyqzaI1MyagWeDgFVALR5qzxn+hmlBCCvK/2Ld47vYvBQcGKZoLj9K7m5?=
 =?us-ascii?Q?dX2Xchr/E5B+LzJXRPcMK4JjYj+4eew5gjgf3lpY2V5dM0Ga9eFyIOK44/eB?=
 =?us-ascii?Q?dcnMGDLu20s0KmG13Nk1rkSurs31Rnztshdkx3uEbMeZNVuGq9rMl2UUCgqN?=
 =?us-ascii?Q?ocZt0QwFtApCO0WVegqs5SkqauCK9/Ufjqufk+P8+sGQ6Oa87Em7DKTtTXra?=
 =?us-ascii?Q?6vHfZjo6n8yM8jkBjiwlHanGKakI1fuYsvKZL/ulXDCXgDEhOO4Wzm2RlMRc?=
 =?us-ascii?Q?3IF/Xypq2tS0euqmkJEgan2Y75/y59n9Cp3NSGNAyvqDL4Q62dkmk9RJzGIX?=
 =?us-ascii?Q?08uizeKueQwMI3uvwWMJCYH7+vLxGhycgu4WoiM9t+aVzpukQ80ZYK6L9fgr?=
 =?us-ascii?Q?pQaIY8rKa7p6+xC3z1NapKacjZXlvoSKUNmVwd01jeSXOefLUcUK+eMal4Sz?=
 =?us-ascii?Q?fuPniKstILLoAlRN0hLh3Z1lC5YRN1ifpDJfnWNCuLIbzXLpl5TcsuozLSE9?=
 =?us-ascii?Q?ZD/1s4GJKIgCn08+EdqXGvUVIdbNCZmWYY9BIEiWJRUxK/P31XmK30I9n+CG?=
 =?us-ascii?Q?4UVPLw9lvimUEcIjE5huZ+Y1ZpOIDOEs5uaUzTzN6d1PF/ok+DJ8Xa3hDPqV?=
 =?us-ascii?Q?RhBq52Dx60UMNqRKlfvw0t7fzngJkfXNZ4Ts3uCnTePogddxkhhRzM0yR4Hu?=
 =?us-ascii?Q?qczaVztUpRzdj0wfdDUZoP2Cd0FCAocPNlHHO55vhMnSl3T49d/9SkoAp85w?=
 =?us-ascii?Q?scTHrsTzBlXDdrkLwB6CV7Uj+pPEwpgThI504cO6ovqm1X/nNSRs8Hu/s0Gt?=
 =?us-ascii?Q?R/5HIxzylyHdl+AGHCp4XiuPXGREET7SMaRvyAA9V8AsoqeHKuduznSCPMVV?=
 =?us-ascii?Q?jtcoMglSw8FLakDCSoCkZTTG4JHuJFFmrZRJOMYyfFKzmqtrS7mk/0uwg0O5?=
 =?us-ascii?Q?U5UQZyWcTS05n4yqc0DP75cthQR4oUv/RuZ3c/Mni+ZOeyfwScQ44dr3Y7Re?=
 =?us-ascii?Q?M8Od/qZP+S6YN010dlEpMxKXwZ3XKc9xQHnAqMARhDzoXiTstmSAZYMDZ7R3?=
 =?us-ascii?Q?fc6yu6TjuK2yFSgBoLXQy195jPD2JZTDe4hLUgAbqdfcFATbTE1ODbTQv9SM?=
 =?us-ascii?Q?ShZZnjcYBQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5306537c-e76d-4ad3-b851-08dea1ed48d1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 10:36:03.5529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kiW/fZm5j+X2BsGA1KdzYZ91GUu0nnkyTkhFzxwO4L3p4w9CPZZdpG3+2z/2WT2mMADnoyuETWmpNfkvqSO9uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10698

When using ASRC in DPCM mode, the backend DAI (codec) may have channel
constraints that differ from the frontend. For example, the ASRC can
support 1-8 channels, but the codec might only support stereo (2 channels).

Without dpcm_merged_chan, userspace can open the frontend with unsupported
channel counts, leading to errors when the backend is configured.

Enable dpcm_merged_chan to merge backend channel constraints to the
frontend, ensuring userspace only sees valid channel configurations.

This fixes issues where applications attempt to use channel counts
that the backend codec doesn't support.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 70a6159430ed..41cd2fc2ea56 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -989,6 +989,7 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 
 	if (asrc_pdev) {
 		/* DPCM DAI Links only if ASRC exists */
+		priv->dai_link[1].dpcm_merged_chan = 1;
 		priv->dai_link[1].cpus->of_node = asrc_np;
 		priv->dai_link[1].platforms->of_node = asrc_np;
 		for_each_link_codecs((&(priv->dai_link[2])), codec_idx, codec_comp) {
-- 
2.34.1


