Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE739606A31D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 02:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DOPpoXK+
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDsSl5BCsz2xg9;
	Wed, 28 Oct 2026 13:56:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793156183;
	cv=pass; b=AH1kzuqEmQVbzkYfYmML6k8f1GZRoktTXG9eyeguk9Lc4HcgKrr8st3C2Ku0GcfMERGtBO1kOsSj4Bkn/eoKNZCBbI/pq+IynIOqtdTlu//BHASAne1uqmCGD3anHtmyGR6mlljPPoFTeN/PznzqYcm9ur8o9+zUhlDo2yfGCU3qSGAdlsREE5tr4p16muni4xRoqsdTNRewi8aU6+5ImmMDzoNrOTHdjVdLIDHG4b8Y8uMQSc+YIYlgZ6G5kiJL+pmpy1aG84cEeFrlKg27YuTB7NiEvvPTz0v3dFoCqK6W2zTK2AHxwrngK8GpCjKi5jTcpFs7vL3Iuw7EQalOjg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793156183; c=relaxed/relaxed;
	bh=CvcuC/o04UNCHXAS+1OoReklOXJrJAAy130KN43tMa8=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kpDiRLmfezFb/S427BnPE0Rkzl/gD05DOk/wtWDCSjs7LaVZuYjvxEJUVY5/lyeTPau12TL7bhLqQ5yrNg1KVH99B8iZJt38ffvH7D20NnKILgELM+wWPuDMU+b/pShJvce4JDmuW/VBYPB3kHlwdQO97bNMqXOLb/vECsUnwcKg8Be/X6k8T1vDS2RlFzXt75KO6ZTDn+7upcCfF+5acvPrjsWXFOH387Wau/nYgHHsd5Wl6AaHvOtfqNAlIYlXckXW567N9UR/VSLRcs4xzQXX86AV2S2PiZ7I0FeIvHeB8TdiugEtRZ8uP9HHs1IMnBYQ5/wYlDhVyscThufRvg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DOPpoXK+; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DOPpoXK+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDsSk4224z2xSR
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 13:56:22 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kGN2WTftOZu6NhtjZzJiywqKnCeLulYc8xJ5ZmR0E6AJre/9c94/wDYh5u7yV1JPz3DLDRPGL0ordD6fLbts8wYdM3ruxwjSrBn7YmfHKCFM/eNbSU/XHJGy3Vlc9NTnDL9SMVlzz14SSz5Jx2+b+UG5kdQuognpw7PbGxJTr/9RBjEAGadPt1dxgEUZ6cIawejeJdjtv3huo7i7Ebz7ENicVZXUPo933nqzGBIVh3+6HxcwyNJ1/Rv7MnXsfCB86bL4yKgegNOJMcKdsnSFfWgwxF3GqaJxNo2NB3d/nzZvrU3G0/ANTdz/DHH/c8jS/k2Qss82ZC9HiT8uXhhAVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvcuC/o04UNCHXAS+1OoReklOXJrJAAy130KN43tMa8=;
 b=o8rbbV7Oe5alBvKk3t6sZJe9nl86vwDgzU+BQtaTfmGhsv+4j6XX6Y5CtPhAYGmoDk7u18k46sbGFiwDmijiBXl1xJsZwfqgpB6Uzp6/3W369Gvdn9pYua8TTaVYCXsX/OJ/0XS3Bxm8FeA0qdFY9iLKn9Gu0xZzHbgIdphCfgIBkANSOciFp9dO/PJdxzulWLnkYf5erDOb2pTmtyPuzHQ2DceE8ky8bvtz2+t5CEp4qMSidPThI5tUpvt8evkekc5tQLyho6jI5jkIvTsHMnOqElI8T/OkTssoZ0qODpCNufK99OjVwcclbgvHa1nYUamHMDVJdtHyKN8sHFxoKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvcuC/o04UNCHXAS+1OoReklOXJrJAAy130KN43tMa8=;
 b=DOPpoXK+DxC9RHnAZqt3UGzyAInzoNsr6v8319VSjbdJO51Uvxtw4xsl13xG1WVYJfm6I1SYKl8pI1V5QknMRAtzozazfpNKa08OqfY0WfP84NPWBqK+12VybSAOsvXoua6l4gyMYOfgiI6IElEfs13UceipfTd/jd4e6H/eRazvOtcxptPnkDoYsdo7L1MROM+kXcteu26uJ73+HfGVA1uhlFpoRvXDYmjwki7CEsG4tZhLuQV7PeyEw7pmUa0pRJEBsJhU/L2Dwf4ZoAqrX9mJPEMzb53KMTB6Ya7n9jz8nTgtoCymX7qWtspdyvejjJmlp2KD2YT3P7uz1uapAQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by AS8PR04MB8849.eurprd04.prod.outlook.com (2603:10a6:20b:42c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 02:55:57 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 02:55:57 +0000
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
Subject: [PATCH] ASoC: fsl_asrc_dma: fix error handling for DMA channel retrieval
Date: Wed, 28 Oct 2026 10:59:21 +0800
Message-Id: <20261028025921.4155551-1-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d1::11) To PAXPR04MB9351.eurprd04.prod.outlook.com
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9351:EE_|AS8PR04MB8849:EE_
X-MS-Office365-Filtering-Correlation-Id: dd1171ec-b282-4030-9d24-08df349efd42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|23010399003|18002099003|261026140227099003|921020|261021121427099003|56012099006|11063799006|261021123027099003|10067099003|261022105027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	QID6owi4DHyjkP+xRzKIwYKJANbrVVeM/pC+zh95nYQiLEaDbRwD1Fxs0uIvA3ZAIItutj/Mbf51CZXHmvvdcrRivZqnVQgRY2jS2tAoPLMeWUm1fCZ5S9hPYJMVpoxj6Z7MgPaJ0UO+ejCkzwK6zxZy0H6MiDroQ+RaHr2SRdWJy/a/g2axWcL6u2GAfO7liD9jHBLyPiJwZfulED1IM2BLox6rrKPeJHLD6CU21el0SLZ58WV8IQLKZ9KufzfPxuDjtEzJu0tWxgbOc2jIVaLTHMZB+z+3PvFgzzYdEngcmDbd/3gkxO0Kfp9xdVORyrTB+xCuud6jfdkny6f3DUie6ctbfnr0zoZbA0vSDkQ+l8wdZk8IfaIu0sYnqRa/Rsiep0UbOC/HPLaTXThkkvhzfrZAWKH9z5RDuvA+UJbJUlul3h6CSpF8Ib15rYanNspnPUj/WwpjeHGlZTeYA6QMYOcJYR4sTe86Bazhe2rhGbR2nCraYqNkroQoAFF6TIOg/cc4+/tA3UaOQ5F1ww6LiztqBBvEAXCbfgggZbe039L0/VBhd3/NE8Kq/fQuFhKi0OThPF9jMi7e/ZUJ77B4xnkiptZfQhlVv5vCr/b7f5eM8kiuyit7T7/XGzc5kROaEnnhvdNfbIyyEAtZjB9GHDTAfeb1lK9WIFXkMhJAr5bWhN9HbY5WIG86lwKWvahscvTp8STF0AFUmcmZOQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(23010399003)(18002099003)(261026140227099003)(921020)(261021121427099003)(56012099006)(11063799006)(261021123027099003)(10067099003)(261022105027099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E0+hJpuJEgvZm92nxJ3JGY0+X7gezmhs9ij9cfK9vmu8NQkvbSiHOPGh4myT?=
 =?us-ascii?Q?m+jOJWpUVTqwvAl8EeanO00T6lTKdQVD1HDuUMziGmTWS/40YBsLP3im6G0E?=
 =?us-ascii?Q?JH/dNfri8Zj44F6kemqLlOc/kKd/8Ij8Ugo7ZSMotZdmHNIdj/8NeyVpvjU4?=
 =?us-ascii?Q?0fhf8dDcYZB4m8L1JQxhc7Om+nrJhEaJMaOU2iw0O/KUJPI6f0IeCuonBYR7?=
 =?us-ascii?Q?keGdFduVkBu5WZu8pSqhNKW6ubTrRIx5spjlK6Z8MxSl6CJ0WZLFdE9+udDH?=
 =?us-ascii?Q?q3loWIGL1vgCNKDRq3zbyGqyxVJ7UnIB+GrrnbM0KIBIBuZy1dxl7U5ZKKWA?=
 =?us-ascii?Q?OzSaD4ok/thNMpqcyrmOSgJ+ODTW4Pl6oZddFm+wL1xjBraw6BHXw3ok7nHO?=
 =?us-ascii?Q?/r8NrMuVlrdBblb9zcmMD72qLUHLdOM6iT0FTD1toisJF4l+kRuyG0ww78IJ?=
 =?us-ascii?Q?yUP1S1HP06x0vwicmKcM6ix+w0FcRhpTbkuzarFkTqF1ndGqCMCpFKOQ90P3?=
 =?us-ascii?Q?uxHEBIUfSfDAVfSZFA3M5EthqanN0z0GJi1w7Ui8Fo65Y2KlWhF/XisH5D2j?=
 =?us-ascii?Q?SL3sDrX2mmke+hQA7WPdhSRCFBSBVzWe/jXWrOnlpzLxPQvMsU/rGkNS3dLd?=
 =?us-ascii?Q?t1jU2XY4lUcx1IU0/9pHkGSzYmi4zAl8+lcDMAN9B01MD+HjpuXeLlZ5AbXn?=
 =?us-ascii?Q?Lib+dUI/e9tayfCOItvdrMceV9R9VOzHC0hhrPw8PahJtd0EeXD/+Misua8u?=
 =?us-ascii?Q?527r151lHD/IwjN6w0pG48lYtwxRAAaEHF47poyqMXmXHDYrl7v8aSBk5/3N?=
 =?us-ascii?Q?rOMdxPpz+wUoBRPs6asQv/rP/M9WephT+ydPr/sqQzdofe6qWqXwXFdPCoQd?=
 =?us-ascii?Q?Hslp77baj9la+xHMM597gt+r8SqBi91LJkpnq3VKnfL6jOFFzbuAqzVA37u5?=
 =?us-ascii?Q?xUNA2nloUhvtioYBpVRD2SxncFmt5wsnv2rcd/aLjw+Qj1IRyDNTVVxI6Pjr?=
 =?us-ascii?Q?TOZQDuMZQd80WjZ0canI83h1buDQdCaZM42gi2KFkjGxBJu1XnUILcQTqaFI?=
 =?us-ascii?Q?bpeC/qALnpFHrnpjE7sMqQG986XWlvFuhbNrfnrvfUYD4zNTpVjzZ1/CAd6o?=
 =?us-ascii?Q?Ka/OgFUe1ZB/te1IgBjkq+6kYjOOyXzz+Dg25i/LDeB5ZGHB7CU+d+JMaRu5?=
 =?us-ascii?Q?ZJer4w7QiD9WjdZo5PdsPpZ+TSfqioGaEICvaC2LCIamTLU38H/fHNkjE1IG?=
 =?us-ascii?Q?Lk3sFGglaeD8O0aQGIIDSnLFFy/djDH4OJNGmWWAqduttoWk6QMAbhcEuxgE?=
 =?us-ascii?Q?FUgcHqgoaHuVAY/ytXNRlIqxPIzGs35sOq4KWZrz8blyVKTJmfcYIkrX+qIR?=
 =?us-ascii?Q?6aKFHdpRR8ECKTVMC6V0Uve+bIqNVcWn7Sq3TxLljhuYYoarazoXj7nYgil1?=
 =?us-ascii?Q?kXyA4jAZ2IxClTaXsJEfTU5u2S+J3R4P7tNeNBfN67wnInYqtc/Di1P08Lay?=
 =?us-ascii?Q?3Lw6BZNMfIrplUJAj2/yr2ozgBz3X2XTrWioSCu0NBRfhDPsHdt5g4Y84kiz?=
 =?us-ascii?Q?gCDXt3yVnz1DAiMSefS44eIwekw3s9wEXZdP0R0AQVUfcTcDn8GCOU983ofz?=
 =?us-ascii?Q?pdtxVelBETdq8n9/n43XJn6d9HI/KORjFha9ISaSjWPbKrUEE7s3juohDQXp?=
 =?us-ascii?Q?3/R1o4TZOU4XbayYgKLPm+LuGd7XuCTBRAr3+ZlcnuOjntr7AQ3c/RDh+4kp?=
 =?us-ascii?Q?VpcV2GM+J9ygRa4p2nF7v7HXBzyigrsjJ1VXTd8ggj2VbqRfAr3A?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1171ec-b282-4030-9d24-08df349efd42
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 02:55:57.0443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8b8esbZHLs7B0GWurUETs0b3VJ1mv27beuuzHc2TdTlY9fju56lG3ngCbeT4gT3ieKH9OJdnGXFMc8ktDXUVaEhZKvsal107fxzTmy0XDN3zytXdaiOVtQ8Kq0hBk1My
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8849
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Shengjiu Wang <shengjiu.wang@nxp.com>

The original check used `if (!tmp_chan)`, which only catches NULL pointers.
However `asrc->get_dma_channel()` returns an error pointer. The NULL check
will always succeed, so replace it with `IS_ERR(tmp_chan)` to correctly
detect errors.

Fixes: b4136c0d69ea ("ASoC: fsl_asrc: check the second front-end DMA channel")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_asrc_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
index b417de6abebe..b39d3d76d26a 100644
--- a/sound/soc/fsl/fsl_asrc_dma.c
+++ b/sound/soc/fsl/fsl_asrc_dma.c
@@ -251,7 +251,7 @@ static int fsl_asrc_dma_hw_params(struct snd_soc_component *component,
 
 		/* Get DMA request of Front-End */
 		tmp_chan = asrc->get_dma_channel(pair, dir);
-		if (!tmp_chan) {
+		if (IS_ERR(tmp_chan)) {
 			dma_release_channel(pair->dma_chan[!dir]);
 			pair->dma_chan[!dir] = NULL;
 			return -EINVAL;
-- 
2.34.1


