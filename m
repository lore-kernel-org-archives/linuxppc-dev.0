Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A1B606A320
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 22:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=F01VqdAZ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPLrh3lGMz2yKn;
	Wed, 11 Nov 2026 09:28:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794312499;
	cv=pass; b=MiPnwHc/kt9LO1KG8/cuCYwco643RfrPOTxsHioL86YP3beRZwRJ+7w/vtlq/UwpeYgpwmVA1cUpGLNOq6wWYlMxwyvY3Ou0NF0wM68ZTTHc50w5udheNnzQWN02rZwRuk6oAOGlHcno8Rz/oIyMVKlxKEmZ3YVsW40wUvuRymyENWUBCZZv6esP2AFG5UcY8v5CntpH7Sg8Xf3gT6AmiztckQLAN6zpAENyxXHmiIQfkjVY793mFog2R1+6/RIbzWVZaQC+6h8DepmcXGrItwtydjbISl1XMR1kBVF33SN29FfLvNRbaPlVwiXXwVvSH575sZ6I0XfiGdSz+eRGxA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794312499; c=relaxed/relaxed;
	bh=0gxdWHr0+mVgtPQQwdI2400x1FCK3nBQPNjwhtWTKu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KoU49rVHgJxbd8wQlu/LV8Srbnvyj6paOcSmRre/eWJ+lzyrVfdQckmIiHi83F7bGrNsSftem+QFGbrTB1gvxbA3YzyToQ5+agRxrbEcDw9OEA8Oi7PXp/eoYcIMoRbu2ZI39e1a1oS4TsOnTWyauZyVjL/rBpEJkbMdVFN3jhLtQ76KOVW2DxOat0L9AA/S1HMMJ1VL/FO//OfxMBRyIFLGWte1fAPMWP36H0Su3myrkuALGO6cCbMTLt26zjBAfC+df+Zd/jJyFdbr8/BupyRsBvHQf73/bdyE4SDk8EvzAyd/TYuyVpbmxyu8BP8wgc9R1RV7/ZFUNcy92PFvfA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=F01VqdAZ; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=stefan.ghetu@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=F01VqdAZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=stefan.ghetu@nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jP55Z5H6Jz2x9N
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 23:08:18 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IB1gSvL03ldMa/UTZRq8WSOPxI9xoWqOnJVOmfpjRaTx+OBYO3TG4JmFz0rP8HPT4dPsn7hxo4F7P+1NVpTgLUmjp+7JKVUpwxZuqsHSif8oJarTDqg1uMhIOPBjl0CNb0/DwRv/cMWkbvovuqEYq5edjiLUiSh0KFoLVk4h6ZRJ//tZrbaW2xW3nsD0M3Dc8fLK1PQO7K+ps/iI5oIAWc85K3otwfwWpLuX6+jyOQ45KCyLdU62aUY752NDPuPIV+frlgM6JHPgECqk7I+jM0aM+M5sMmdpEymwJ/aKXjkJovHBi1qNaqTZBMh8j9dsfQj2pgpusufQLXYu3Y2HGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gxdWHr0+mVgtPQQwdI2400x1FCK3nBQPNjwhtWTKu8=;
 b=q0VQzuCoLH51i8wHzm1uEe9J90NHgkVOUjAuQXH3cyyzqD1ZlcEhl57gjqMkn/UzXD37Oz879ZCGp4crWXNU55xcUJoBHOPNwLrhmt3S9iQITFW9qWH2xXDvYZYTIPGG+FR7rYLWiOwtS/Q/VwB6Qn8cxMtj5EKs80Laa0ooUMIf379gXZ4I9nykxqB4qWxytTUaq0f2NBRpq+zHJ5YI0c7aJMBcPSKHlA3XirT59pUhzmv9uiczP0gtsMDZMQZCkuR+tbV+fTKT8+lNBQbhgsyBXB1YgEELzOMn5sXCtM/LhDr1i2lMUakJkN8YgO7iRYQf88iTIlDq+tedxDZ3uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gxdWHr0+mVgtPQQwdI2400x1FCK3nBQPNjwhtWTKu8=;
 b=F01VqdAZeCR0S3o/jhf0BA9CPtt13+BddG+22xkmpYcmvxISs1bLI8+T1KdgkdSgTDu+85HjmZPfxp5AZEj+pVEvVX14Bxk79FD1TAjN8pfaU9kaLsz1jDU6tkaMEo92EL0UBnywBgJbVqp47aHJGhZxlg7Y5Z1AL1sKS52FxYI5pPoEyaLO+5Xn523JoU4AfXihTWoWEkZ8oLrdFz3leNTWN37aPFM9SadWqNilwjUCkibMe5TLLTNEim3cx2tFGKbS2b1lOr7e7FzfG57sX/UMJa5r4+iS8TTeQYKIrVq2nUPMW/Onn1jAFq7Ghr1YdwJi3/HAddYWEDNQhDRCEA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4472.eurprd04.prod.outlook.com (2603:10a6:20b:23::20)
 by PA6PR04MB11832.eurprd04.prod.outlook.com (2603:10a6:102:520::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 12:08:07 +0000
Received: from AM6PR04MB4472.eurprd04.prod.outlook.com
 ([fe80::aed9:e8b9:c352:9ba0]) by AM6PR04MB4472.eurprd04.prod.outlook.com
 ([fe80::aed9:e8b9:c352:9ba0%6]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 12:08:07 +0000
From: Stefan Ghetu <stefan.ghetu@nxp.com>
To: Shengjiu Wang <shengjiu.wang@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-sound@vger.kernel.org
Cc: daniel.baluta@nxp.com,
	Stefan Ghetu <stefan.ghetu@nxp.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] ASoC: fsl_easrc: fix context ownership on repeated
Date: Tue, 10 Nov 2026 14:07:42 +0200
Message-Id: <20261110120743.6301-5-stefan.ghetu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110120743.6301-1-stefan.ghetu@nxp.com>
References: <20261110120743.6301-1-stefan.ghetu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0045.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::28) To AM6PR04MB4472.eurprd04.prod.outlook.com
 (2603:10a6:20b:23::20)
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
X-MS-TrafficTypeDiagnostic: AM6PR04MB4472:EE_|PA6PR04MB11832:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e276dde-2723-4b96-1fe2-08df3f2347f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|7416014|23010399003|56012099006|5023799004|11063799006|22082099003|18002099003|10067099003|261009223027099003|261028144727099003|261102123227099003|261021121427099003|261026121527099003|261026140227099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	mblX5qPnbw0QJFfyALEe2lPzhxYZ0YmiwNga2+dgPkfczmVePy+sdGHhQk1+Fo0yp/5XXwTloYvCZcqmwUuBOSTFl/zMkWc+bwz/AZfnipoQRwDKJ3JpyrdYO2xQ19aLrtluj59b2kUv1WlPHfxq8Ah3ts8HuZDYoswx2f7l+vcB4O/hT0SfVm6Hc85KiNHOSbZu/6ZFnXAFSCddmnvE8Rx3MzSF4Rf4INOcQg05OgDDQBQPfQ3UjTAl4nQzxK15IljMj5OdPo0ny538i/qS9XOEq6SphJ3XmZiizkDnRmL3eNua8cYZZIVB2n1xyccI7CeldctR5Ll1x6LueX6pJ0yZLop0yi4Zhvkl1OfMtwHtAUT7gjT18tQNK4JchgPd2XuPmXlbTIy81Uf/wrdZjTJc14gRwHa2qbg8Lx5tZjsLMbKPsuUdm+x7o2femn86SXmHvpfVl1p//jnUdOARu25igjufrNDXT0pEmYAVw2zTuf/tEvWnQl6LVUIEGqhJ6zMsWhjwXmfQQl0O0DECrZOFLvC9FWpi8v8DoWsYZmhjHWGIs3AZErA6U+SmUWR9CCfO6NZabbAvLCl+RQOG+7OWYDkZEgPgNB0HsmrMtPQp5Gag9ceybE6fK7zqpa50aKSHWQU6mth4XvsL/ku7kOKIp5fZcmy4uLSGexGxoQE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4472.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014)(23010399003)(56012099006)(5023799004)(11063799006)(22082099003)(18002099003)(10067099003)(261009223027099003)(261028144727099003)(261102123227099003)(261021121427099003)(261026121527099003)(261026140227099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QgdU3jO8v57TmVLEiCv49MUieXrhqn5ebcw0hlBktB77uUbFS9ibeFW27Qs+?=
 =?us-ascii?Q?fFJMTk0DH26/ij6acbVNYkroAZ1mFUGpuWXf8X6xrZaRk8M900z1HkLr7SEF?=
 =?us-ascii?Q?0U6f/1+4YTN5D0ELPqK2Q8SspHyxJePHAimus9L2aX/NSFJjrm3h3+YplzVV?=
 =?us-ascii?Q?jP8/89JWJJH5nP3zq/dJ0BWZNNnRytH40feHsC1og7MiKtamLbVi9m6NFDrB?=
 =?us-ascii?Q?RpzzJKDIEhV8fRUvibDARxWv2uOTUwvfEae4k+2KLAdZqIoBRPaZPsyM7zH1?=
 =?us-ascii?Q?zGXhTrbAD8CQGyY5By4mmBu9qPn3pHtJL1yES6WKgoyKkfCv6GgkMPbupoK6?=
 =?us-ascii?Q?Umdj+3POgQ+hFLyPwliKcIur2trPzGmFZFDbpuhhw4hSH3pYSpz322t2tVMt?=
 =?us-ascii?Q?lSYN2CujnLIstD6+ltf5fNgzIJPl9kwQsemOZ0hyPRyLp2RRZk9irbqmL56g?=
 =?us-ascii?Q?ZhjwsVgE1V1CO7mzlzzn9hDFdIX4h7f41BYWHnX7yju+6StvctYbdSZGlLQn?=
 =?us-ascii?Q?eyBk4v+4e8IYG8KQLcS3subR0ujLVZ0vsBXK9UC5ANnMTpABsEyaaQWHZgxn?=
 =?us-ascii?Q?xWcQINxs8C3njapDiNoVUEXmkwPNQ9T66eniXY/y8BaJ3ID3QjufSLqz0/FB?=
 =?us-ascii?Q?OubFxvB2wGuj2CdZ1LKN/oN+c2CZiVHgcrRb7pSKNEFHWMqmfHTWSXn6FDMG?=
 =?us-ascii?Q?ZP54LGGY1V6u1n8t02I0mBb3mwpJVs+dgJSYI7dS74PdSOwDZ+Y88MM91Xxe?=
 =?us-ascii?Q?WOCxpVprCcAStsoGU8SRjvFe8K3/6voTQsWrtoo/LK/aLlfyTKCSoGwcIizr?=
 =?us-ascii?Q?YVkE5az2lI9zZ5DgW87SJWa5nSnHiRnVcUuB6bzngI/yrlBSg4ubV4GHT0kv?=
 =?us-ascii?Q?hyhSPItLk2LzVIbUhZeaxNiAamlGD+Z5bN5Lk79zAsUWsbBKGjjne9MqjwfH?=
 =?us-ascii?Q?TQQCI/Dy35FS0HzXDTXY5ZDo1kWmid2nfON6ccZfyiSN2n6ThragSUEpl4ho?=
 =?us-ascii?Q?Axqgplp4olL9VDdFFUu0P/gwxTqosgiZjPr/9QClHxzm4QpOa1XHXNx12gNp?=
 =?us-ascii?Q?GdeeRHbDZpd0VXw+mvQlhvx3U3ktY/08S9udoYfbJnssZ3QjlOvfjho0qRZ3?=
 =?us-ascii?Q?WlOHqnhX4qVCZENYDT+GRCZb+2ocVHIf0APIdcKBkPTBuqHGsVaphMp8owHZ?=
 =?us-ascii?Q?tc3qO26fFo4dyuW/QQe3Hwto3tgz4BnrvTW8C+4XO4ulVZoizkf6ScD3MnpZ?=
 =?us-ascii?Q?yB6XBePOSqWhbltEkRKFk1YSKTP5LE2ZOwukTYukydbH+V3RTaB97WkM4TJy?=
 =?us-ascii?Q?UxYXvkjb61cTFtPP7kfh3EnhoKyL2TtYvQtfsskSIV/Cco3prh8e2+VN19rz?=
 =?us-ascii?Q?jL7JXJBqNGD9r2z95+VXbo6PrKrgKxgIpqw9C7becAdqvaUE8XcKeMqJwVBT?=
 =?us-ascii?Q?g1NDxBFsf7Dc2YVLRh+zV3UV6+rPAJeM/OKOx5FO2e8mqzaEjVu0JQijPf+b?=
 =?us-ascii?Q?sl6cqObgd15ntkwlLFMAbTT+l4Y8KEE5sMPTGdPoAdxz2zTf1CroWBz2ckBH?=
 =?us-ascii?Q?58KKGB0Wix/Huu++puTUm3n0yACugQLhhRyAbgOWag/tHMotkYK2EtL5u9BI?=
 =?us-ascii?Q?NacFOF9t6nRr3YFbb+SSWEH23LWtCD2aUW/77MapefbFWsk2R8Ou4lGvD1Tp?=
 =?us-ascii?Q?+/1o0mw+feOwY13YR8nj9mCGm/s4kT8vk1C20ncTt0A4VackOQ3/+K04O4l+?=
 =?us-ascii?Q?RVuWmr2kfw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e276dde-2723-4b96-1fe2-08df3f2347f2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4472.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 12:08:07.4772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HTFpM485CVGWATI3VR+2u5dYd6UGpRK4PLdDfz3yPycuLDTiKkEHX4Dh8AK88mEKeJbfzTDf4I9PnAmFfVMptg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11832
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

hw_params() can be called again without hw_free() in between.
fsl_easrc_hw_params() then requests a second context while the stream
still owns the first one, which is never released. After close, that
easrc->pair[] entry points to freed memory and is dereferenced by
fsl_easrc_runtime_resume() on the next open.

The EASRC slots depend on the number of channels, so release the owned
context before requesting a new one, and make
fsl_easrc_release_context() ignore a context it does not own.

Fixes: 955ac624058f ("ASoC: fsl_easrc: Add EASRC ASoC CPU DAI drivers")
Signed-off-by: Stefan Ghetu <stefan.ghetu@nxp.com>
---
 sound/soc/fsl/fsl_easrc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index 5d715bc07357..ae0fbf6c316b 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -1347,6 +1347,10 @@ static void fsl_easrc_release_context(struct fsl_asrc_pair *ctx)
 
 	guard(spinlock_irqsave)(&easrc->lock);
 
+	/* Nothing to release if the context is not owned by @ctx */
+	if (easrc->pair[ctx->index] != ctx)
+		return;
+
 	fsl_easrc_release_slot(easrc, ctx->index);
 
 	easrc->channel_avail += ctx->channels;
@@ -1500,6 +1504,12 @@ static int fsl_easrc_hw_params(struct snd_pcm_substream *substream,
 	snd_pcm_format_t format = params_format(params);
 	int ret;
 
+	/* hw_params() may be called again without hw_free() in between */
+	if (ctx_priv->ctx_streams & BIT(substream->stream)) {
+		ctx_priv->ctx_streams &= ~BIT(substream->stream);
+		fsl_easrc_release_context(ctx);
+	}
+
 	ret = fsl_easrc_request_context(channels, ctx);
 	if (ret) {
 		dev_err(dev, "failed to request context\n");
-- 
2.53.0


