Return-Path: <linuxppc-dev+bounces-20072-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BABFE5204
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 10:37:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g28X031Dyz2yvv;
	Fri, 24 Apr 2026 20:36:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777026992;
	cv=pass; b=oOeHO98nqhCNs6Ksk3UYxjEBSB2qGl/UIXMaCnxPc5WRPnMiwwt7nq//c1b1zbDsHGACkub07VSv+M6FjfWJe/eEsXrwjdw3UODe2q6cDUrCSoQYNVnSczBpCoZJybf3Gpx7PG15eXRfsoghnLT0KbMNyzDE2Mvy/VXscPUhuSrlOc7ZiJvCztI22I7Z81wlGUhzpYRDcb+soGktcZ/F0N+cZ5AoUEENIcrMbcGnADTcXKglDVosGsLLM6w1B2rSXuvak/17vXsmBGUc3RyM+Yaw5RXtP+btHR+oRNhiycyOt6x0a0AmbAhvzySLGVdQEtHEHCFFXfYMls0kqM4Bmw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777026992; c=relaxed/relaxed;
	bh=TwhxlCSX9y1bU/FKDoek3ENuNuFmzm0dwhHrVGfnGiA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A9o5FybZWqcvD2Ajm3NpC+k4YLaJIhIWxwPgEJttijR00u+AM5NjcDR0sPGk0t6ea5py9r2di5dPOdmD98gP6UUScH7Cq35bcjUsO2GuYHMKRFbjlgWznFwRIN81Udt7LHdqL/uuaKIENDCcyRMKUUY7jnVaOrisj+oM3+89xNWvT5lIM3JcJ5Pz2Wdk+Oy9iCcuBXn7df14wulnZl1ZV+ppydOwz83uyLWOMxbnCeaLxn/mAzwqO8SFRywfAETxb76yUqL+KNFfUh0dXEZwUmdlFlZZZZ2yi2cVQmW+gohglLy7MimeStjZpHxGm9Sz6gsDZRIvaJmdqRqPcWlNXA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Ql0aF/8K; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Ql0aF/8K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g28Wz3Hf3z306l
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 20:36:31 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=guKcXoc1FtwhpmvNfofW39dCw+xhdmwxZLU8GR8XjwE4Vf2ZHkcmVOceKo6tMhhfuIR24T6535H0pfpAXjjoaiBycAUgntxA8QoODl10YvPZO1yJENaV6bYHZ9sGkzIbRasU1fMD53k7pLNhd5uXSgDkBMVSjZnY0zVrme/wbKzJI2t2l1Hqpal6IT9F6JRcZHJP8jTFy8Krd5TWTMZy0SXup7OOTekZYKSZrYJkK4enDgKk7JWR5J+cC/q0MG5rARi1vYndWtBcHbuGBsUg5eo0C7z8inNnKhO9GDiLD4mE8NUwNlms4mTULMTX7PCS+w+mXE+DQOSB/UY2WwmWiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwhxlCSX9y1bU/FKDoek3ENuNuFmzm0dwhHrVGfnGiA=;
 b=eklYPXPKbCsT46DVA6P+I4dtRm0h9/X8Dze7dM/g/zaiNHDQ8fgfWl1sJ4Km3imsGr7pthLTc6d6dnaqJpYxCRqt4J1XVwDXYwhsb0YdMrdqPPz/nuEvQd9IrUPh+cY+6QQf4MMvJ1BTRV1hEmS+TAO653OGYv1OUYEdNyxMQV1IaHVmEbya/ZUcJYXvtrG30r5key0sZhTUjyGYj5B38eqQSA5I1GfxdiCqZkt/K825ki8ZFIV5X54oORXSAR3g/fVhkAIL1azPmhXRJCRqBQ31xnuGZBtqrZoOcRj68UPb0cSpKrEo+u+xb3w5MwwofB9/fDqmfRu/cqBNsVUvww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwhxlCSX9y1bU/FKDoek3ENuNuFmzm0dwhHrVGfnGiA=;
 b=Ql0aF/8KT8HaG4dNv/tD+QX5puGhXmFmpHfLMU5n2seZcR+cpjAmic0KwN3hyRUqmrfIF/eapsPx5N4F/7PjljaqFsNC1JSwimCgnFP8LzZfVQlkh5TgZl5U+N/5Zn+sVBF1vPf2l4tM2iLaU5nmJgHP+U6yCQ7E+vOzMiW8N4N3vc4agWNUMQh/HObhZQ2OYflgXkEk9b9e9KapFbgVcE3zATAnlwEpmEcytD4J0VjiREq2lS+Oufn1BENMThZpGHiHs8Zlu2oUplCZtfO8QoHbVSlp8rpiKiDLhKuuwmQNEZkYbOnJUfWRcFV6R2hvF20UfBndsq3nScTKg8kc3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by PAXPR04MB9075.eurprd04.prod.outlook.com (2603:10a6:102:229::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Fri, 24 Apr
 2026 10:36:11 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b%4]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 10:36:11 +0000
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
Subject: [PATCH 3/5] ASoC: fsl-asoc-card: add channel and rate constraints for CS42888
Date: Fri, 24 Apr 2026 18:38:04 +0800
Message-Id: <20260424103806.2276780-4-shengjiu.wang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|PAXPR04MB9075:EE_
X-MS-Office365-Filtering-Correlation-Id: a879f782-cb8a-48d7-4ea2-08dea1ed4d4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|52116014|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	krAXIUycBn+dBGFpYQ7wDXCNU7LfRurzzZEYLI64psf6HyhGPxukSiLAy//g11EJXS8yWXIcAHxHRNl1WbfEB0Wv8DVqqA0oI8HMC26P9fzFx7GA7h76VKg7wRtnaZYndWaW6APrFvTh+UhPTQ4jfSK/8XFC+xoPjXqMVJADz8Wh8FujKLRfzK2yIm5di+inUr5qWCqsSj6yLBaj8VXoO3q21asw5RiSFFZYMv/VVgOhLhiiNp8ndGt5BczPBKuv72UPahA8zFHvn8WwQe89cu48sfgevuuqAGEAhTmKJ5KopQ2CNYKEacWEE3tJmkYVqgYAc0PYsbLlCYvS6xo25wV0oRz7UkuNsOqioZMk+Dcw8npki54TbaMRJOUEcwQyFUrX617yry2zIH2k98ljxhES0KBqxtGq1TuS3zaHauppK0FZNLlP6CNYq8VYgnVjQSUucbHVAC6MoJHHtGtmuu/Gs6Cgm12eX9OeIncZETl8IGw0+X4nOYwLMwnN8mpNi1JmJgdCU8TF1Ar2XIO10INBoIO432/D0Yqk5LHarFGeJjhQAq2htiEviszWEOUx/eyEeyuLdgu7VXI0fG2IN22pFeZfz7nJ+sdkC10I6DItS5cNOKVmx0fgg/A69VHBba51VwjNxv69RcZFE+r8DC0679gFD3Axpa9d9XoKoix3uqtFZ1mqUBGVUZnbIi0IzCbkzuIdxXR3Z+UhL7TtrmFZ4QX7/FAB6vuPeO0K4avIA+b4RgRXHBR2kn+uNdEoWf0SZsl+2Pe0FJPLTE0kQb5vqqLliWRDHZaaVHRy71YKto7l2QXMTRIh+idnXJtH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CWsooSkpVYEwnqIM9A8RPB1xZl9u0JR4owWjhqTHYdPHuK815eWosmUHuxve?=
 =?us-ascii?Q?h2LTz7ka3XRivyMeCTTPe2V56SLuEVCNmkr9wi3rHV6ktOvf/FNBT+KDJvYi?=
 =?us-ascii?Q?EOvgy2+dF4RPPhyB2od6JRLT79sxRzTLsMGvX+K1uJ3Lst1cFcEwQkofVJnc?=
 =?us-ascii?Q?d4ILQ9egPmEI01fZdPP69HNVFbpUl9iPztLhiTY41RzWC7nRf23MIZJGAXlU?=
 =?us-ascii?Q?hP+C3RxcQmXfF+VOo8y0ZmU5hH4GRw5ZSEEWktIvl2DRW8q3pnyFyj24OVpD?=
 =?us-ascii?Q?Idi65fq0+e2PFPCSps8ig5zAuBxxqxSGHrsw5xcgAzPdgmCpR03x7da399WB?=
 =?us-ascii?Q?Tk5j5Ageln3hi6vPqY2ADjArqk723oyJh/I6GTa+vnrOMk9DL9+qJSBEAlUL?=
 =?us-ascii?Q?oMaH1vywBYPJ5wWTkaJN8XPkUqFsUQfNO/ogpfku4gmNhFH6dL2kbj+p95BR?=
 =?us-ascii?Q?v4Y+EsonC1CJ2iWA0AMQ9q+eGL21ZsW9+IMoa9GuRQetvlvnYpveZQVeDK+q?=
 =?us-ascii?Q?fMZWUkj2+YoBesJPOf/BEZmGkBiLiD7bw99nJBtBs3IcmrQYFO7C4eWCU798?=
 =?us-ascii?Q?jaKcYIeHsHJpKoR9cPMvSVWWVthHeFQ6UJbNgQshktVze7aKx/Bn1hnnse6a?=
 =?us-ascii?Q?IXo4b0NqjnEVbD54TtH/R6bIzaKQUO81E8XC/tEypkJyj7mRSTZH9tmmaLPl?=
 =?us-ascii?Q?oKpUHraPOYNU9cWnURxTV9tf/XkKKmXHYoJdSd9OIvmhxqSCwZMx06+Vi1sN?=
 =?us-ascii?Q?prX8a+C+hU805XoaKpjCrhPLgdAFDUNJp5ZhHDMsN2H7jN0ZnzuLwigeEpKL?=
 =?us-ascii?Q?/zPiQkaugyuHPeETFU5m0p8mETKlZCBfjFNzQ6fcTIJtEmjaqmS1SdUo9Noa?=
 =?us-ascii?Q?difcoMDYmYVTz/bbNUNhX8mLHP4I/rz4CmoMyfwhoxJ0qjSeB/k36aHzEZez?=
 =?us-ascii?Q?i+RflvgT5x8PKS9AfijgBYE+LSv9LCG4BCaUuw5g+nHObaGNrYDO4sg2Wv1c?=
 =?us-ascii?Q?D1KLrGJbVctQUHCYtkr/IER9sdnwOGCh/kNwyTmKoNH3So+xFmaRhNvymEwX?=
 =?us-ascii?Q?3nnzdOLdK0LEIejztMWojx8UUVDBD1yRrC46XZWVOE1G8mw0g6mGvZuh7jEO?=
 =?us-ascii?Q?TGPnNjRsQpeswLpE3AZ4l0JemARBKz10Ra7a8kLJE7Xzo9pobagPkyZARabo?=
 =?us-ascii?Q?eCmHqhCcp+ZX3Nb8TE8xs6AnkF0xQx9VvqIZLNbHx0PReR7ywa5GcUUpkFMg?=
 =?us-ascii?Q?Hc8y32iKvyEwAlCwc0cDA6CM82m8c9I4YgJUTtMLNdNr+NEyW4zMgWVXuTP6?=
 =?us-ascii?Q?ADUNnaUWxscMoATazDmdSpHa70bnkN8qSlCvnL2oH7UMz7RFnV99TIBNDuSA?=
 =?us-ascii?Q?bR8p90fS7JU5TPFghoEHqqmlr9l2dgQHPwPqgfF/C5sSv8vppr79oeLLHXKU?=
 =?us-ascii?Q?I7eSCd4f4cGrS3BIqW8xnsQdW9BuDJHFhuP7TEswT6O9jTzZ0ac9hQHmocKo?=
 =?us-ascii?Q?tOwQyIkUZp5WipflxbUuyTNrVQ8aWrkwIJIUifQ5I/NiMIe7WBzfLN16orF1?=
 =?us-ascii?Q?frXc+sHR1dfgeRdjsvrqPlmAU7/TXcDeIOEzPFFiq4bkIVq73YzRlH7KdpP+?=
 =?us-ascii?Q?88cRPXE6woaZTa/l87TUP0WlnPjddofxtD6MCFTmjl2MPRhgTcvC4kW/H+9x?=
 =?us-ascii?Q?o21hBlh7WTkkZMVhYRoQ4IkgwYu268R4vblhZCRIc3KHggX/8OlCu8ayVdT/?=
 =?us-ascii?Q?ueBEuccx8g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a879f782-cb8a-48d7-4ea2-08dea1ed4d4e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 10:36:11.0560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AApZTkCCiGORExMCpfkj98CwmXP27DLPsqIyFAJd6Xsvj8Q3DpSWfZRQCuH9jQFZ6IO6HqUHqjACj3B1GZ8mDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9075

The CS42888 codec has 4 I2S lanes with 2 channels per lane. Using odd
channel counts (3, 5, 7) causes data misalignment in the I2S frame,
resulting in incorrect channel mapping. Only mono and even channel
counts (1, 2, 4, 6, 8) work correctly.

Additionally, the fixed system clock on i.MX platforms limits supported
sample rates. With 12.288 MHz MCLK, only 48kHz family rates (48k, 96k,
192k) achieve valid MCLK:LRCK ratios. With 11.2896 MHz MCLK, only 44k
family rates are supported.

Add a startup callback to apply PCM constraints for both channels and
rates, preventing userspace from requesting unsupported configurations.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 67 +++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index e08e135886f7..50d7a5f2d79e 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -40,6 +40,18 @@
 /* Default DAI format without Master and Slave flag */
 #define DAI_FMT_BASE (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF)
 
+static const u32 cs42888_rates_48k[] = {
+	48000, 96000, 192000,
+};
+
+static const u32 cs42888_rates_44k[] = {
+	44100, 88200, 176400,
+};
+
+static const u32 cs42888_channels[] = {
+	1, 2, 4, 6, 8,
+};
+
 /**
  * struct codec_priv - CODEC private data
  * @mclk: Main clock of the CODEC
@@ -93,6 +105,10 @@ struct cpu_priv {
  * @asrc_rate: ASRC sample rate used by Back-Ends
  * @asrc_format: ASRC sample format used by Back-Ends
  * @dai_fmt: DAI format between CPU and CODEC
+ * @support_rates: array of supported rates
+ * @support_channels: array of supported channels
+ * @num_rates: Number of entries in support_rates array
+ * @num_channels: Number of entries in support_channels array
  * @name: Card name
  */
 
@@ -110,6 +126,10 @@ struct fsl_asoc_card_priv {
 	u32 asrc_rate;
 	snd_pcm_format_t asrc_format;
 	u32 dai_fmt;
+	const u32 *support_rates;
+	const u32 *support_channels;
+	u32 num_rates;
+	u32 num_channels;
 	char name[32];
 };
 
@@ -291,7 +311,41 @@ static int fsl_asoc_card_hw_free(struct snd_pcm_substream *substream)
 	return 0;
 }
 
+static int fsl_asoc_card_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct fsl_asoc_card_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	static struct snd_pcm_hw_constraint_list constraint_rates;
+	static struct snd_pcm_hw_constraint_list constraint_channels;
+	int ret;
+
+	constraint_channels.list = priv->support_channels;
+	constraint_channels.count = priv->num_channels;
+	constraint_rates.list = priv->support_rates;
+	constraint_rates.count = priv->num_rates;
+
+	if (constraint_channels.count) {
+		ret = snd_pcm_hw_constraint_list(runtime, 0,
+						 SNDRV_PCM_HW_PARAM_CHANNELS,
+						 &constraint_channels);
+		if (ret)
+			return ret;
+	}
+
+	if (constraint_rates.count) {
+		ret = snd_pcm_hw_constraint_list(runtime, 0,
+						 SNDRV_PCM_HW_PARAM_RATE,
+						 &constraint_rates);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static const struct snd_soc_ops fsl_asoc_card_ops = {
+	.startup = fsl_asoc_card_startup,
 	.hw_params = fsl_asoc_card_hw_params,
 	.hw_free = fsl_asoc_card_hw_free,
 };
@@ -753,6 +807,19 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 		priv->cpu_priv.sysclk_dir[RX] = SND_SOC_CLOCK_OUT;
 		priv->cpu_priv.slot_width = 32;
 		priv->dai_fmt |= SND_SOC_DAIFMT_CBC_CFC;
+		priv->support_channels = cs42888_channels;
+		priv->num_channels = ARRAY_SIZE(cs42888_channels);
+		if (priv->codec_priv[0].mclk_freq % 12288000 == 0) {
+			priv->support_rates = cs42888_rates_48k;
+			priv->num_rates = ARRAY_SIZE(cs42888_rates_48k);
+		} else if (priv->codec_priv[0].mclk_freq % 11289600 == 0) {
+			priv->support_rates = cs42888_rates_44k;
+			priv->num_rates = ARRAY_SIZE(cs42888_rates_44k);
+		} else {
+			/* Unknown MCLK, no rate constraints */
+			dev_warn(&pdev->dev, "Unknown MCLK frequency %lu, no rate constraints\n",
+				 priv->codec_priv[0].mclk_freq);
+		}
 	} else if (of_device_is_compatible(np, "fsl,imx-audio-cs427x")) {
 		codec_dai_name[0] = "cs4271-hifi";
 		priv->codec_priv[0].mclk_id = CS427x_SYSCLK_MCLK;
-- 
2.34.1


