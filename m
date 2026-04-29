Return-Path: <linuxppc-dev+bounces-20266-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 843B1FF8877
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 09:59:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5CSH5HtLz2yvV;
	Wed, 29 Apr 2026 19:58:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777456735;
	cv=pass; b=OLfeJ3n6STQi3oH0mn5Ou15ym00tYd0sdgKOXsUAqUu8+8LSRP5kT9jALKCHGAgpFnjhBVzXUqLquoxfFd3UvO3hnuC6fKU3WgrHjK7NSFI9eTXl6GWwq1DU/KfiPNbRlVoFQOYtXvv5RrRy6ipzQeG/Hujs4HC0DD4pZuxHayuvDoJAlsRiRwPW6hFy63sIlCRIyLbIQSJCQRPaClgQSlxXK16iDz3b3zwZcUeehcnsWAOXbY7olvUHTLgvmesXM85G+yIlZtBhRPz6d1lipI9tOBHDwZ8rmUbIZZTUIJrobFjU8Vy/VZN6cXkW1dQR0xxSi/OoB+GzInjkDwrVgw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777456735; c=relaxed/relaxed;
	bh=HTt1TJCql10MN7yHqE6AMTCLTFedCZip5Vu8emkSp4o=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IXv1YbisQheFgvwcvJQPqYtmJYcB23+LK/8VirK1sLpoHMQoWJmcivxXCPgNoUUvrv7RKSoZE/u8TkYN+9cCxet7HqfcWGsBMJvL6uPKDTDBejGu4adf3ImywTzr0mm+jV65if3FudEEWxDmgYiZ8XJ2fCnE2FgyEDjlV93M3R0DvzT/dEwln/LOBSL+4L7D+oR4fGYXsf0Cu1E6qcrdHNSiA+ODLdwGfIpvoB17CkGIRPx/6mEXUALfUaSGCNgDem6S/5KeUv/EelKboLSm79zK2qEsV3w/TTHrFXXNDXMtrWAhJnuGzo5KhPFbb+CN2MnJJtKCa3fXEo50frg1Hg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=cR8x0H9K; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=cR8x0H9K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5CSG3nMLz2yv9
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2026 19:58:54 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D2ym+bXm8D7Z4GCL+axFPuASEFFBpoeFRtimYd1ZH6m5rNMaHL2Q5pZtcQndHrag2oAcg75L1mRK8p5qGnBllSxIKE1AeFaCpajNsxr+TNpAuvPEaaGEFxzc0XIlNKbbBS5UopRDBkq+gGQSNmtbgq+ir2ALZqnunuGSRJSh95ukWzIAQ8ygpRJ4AtFkZEEoqvE/hKvo0uqjKq0ocsZ4P1gQ075fg/TZpzJbFYxF/81+Nb+3j0t+/a8EuJBxJlflgOOXC/mgdoAnPUofO2eg9r3WH17XNv8tC2X2YHXTVYyvlVayvIeZ2TT0aCUVfDs3tkS13EA6bTn3ky7tsLGfHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTt1TJCql10MN7yHqE6AMTCLTFedCZip5Vu8emkSp4o=;
 b=I86ojLYitU5eHVypQoCHDLjHL8ZGyBz2NyFLTwLXmvsbODN7mlOCUhM0BSU2t7/DWpzbGd5Jek2B8kW/QoyoOxVpJNehnRcPexSTQ1EGy3cWtrojs0ma5xzuyYYiqmz7F8xvSMFzt5pHS7mu8eB8tvBCfWeIsZs5Gv4WtdbM9yx5RN4UVllpzgwzYS21EFLYgEFj50GLZP8XFsiK/7y9k7GMPcRmcLvGw2hauy83OPvwVoU2gdF+llb3W7VJgVjcOdRweMUwT7yDmczo89p3jcLU6XSkDLRgoaVpFAy02uGAmV2oABOf5w28ksO5PUf7yhnVRUmxmpW/Z/ZgaERH+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTt1TJCql10MN7yHqE6AMTCLTFedCZip5Vu8emkSp4o=;
 b=cR8x0H9KMIpGBVzU/6OrpzFpaQ5wBXXgBrdS4DMpMy0bKMTStPXk8+wQEEFABnKXlYPiQ+YncKCwIeIa5hQ0UCRllQsQCD3+DA/p0WFS9OArU4oqd/M3fGy9LqhfLjg77ACFTKbzXN8w5E46nu3f4l8uEt0QbcdzbLBaof2eIjC6+oZRlqeGN0QOqcTCFWcCoxAJ532vPUGS1E/G7MFookv71W2XBT09pC8azOXy255Fw2TgguJLfOCjJGMjAtT6+KLLF3p7D3Me+z/SEqJ5ADVqogYB/RgfOBE0mybuKB42EpjBMa6Vw1BfBtKp8l1yVNbvpT4NL6AB0HGZEr8Bzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by PAXPR04MB8269.eurprd04.prod.outlook.com (2603:10a6:102:1c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Wed, 29 Apr
 2026 09:58:40 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b%4]) with mapi id 15.20.9846.025; Wed, 29 Apr 2026
 09:58:40 +0000
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
Subject: [PATCH v2 3/5] ASoC: fsl-asoc-card: add channel and rate constraints for CS42888
Date: Wed, 29 Apr 2026 18:00:25 +0800
Message-Id: <20260429100028.2739711-4-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260429100028.2739711-1-shengjiu.wang@nxp.com>
References: <20260429100028.2739711-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0005.APCP153.PROD.OUTLOOK.COM (2603:1096::15) To
 AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|PAXPR04MB8269:EE_
X-MS-Office365-Filtering-Correlation-Id: 0790acd2-1232-42bb-cf61-08dea5d5e40c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|7416014|1800799024|56012099003|22082099003|18002099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	1MkTekPGjbvrySwMInwprasi0uzaz9I6a/jbZil1Or4m2/9FskW3OGw5SpDC25LAjMmR8hMxJQXDPh5xYo7fiX1DexEaw68BAUxSF774UHgPv7RqSZ7+3nFlJc5dU+ph/7CTPwavP5LWKvV+76CeWRchapHlVGeQHI+nLvi2OLTL178QjpiPK1vK9a50c864c3VSwgzDFzCqAmxlkNdqjIi1s2iLcsRsqai5T+426qUL2jUvzNafxiBxha0gRrvEATIoVCEZYkRJCclXr47Z7hkiBiWXOXaTcqpYeSeMzCQBZhY1gjK5gDdUk6XODaxzjcVNZ93GsVcj73UAMFrIXK0/yJw6dITzsG4S17FnQw160StIkv69P2URgL3Pn97qkNm06UzLFnJ5aKqWXeDfVgsud0DbZL2sghJQON6BP9JYcWs2I6EwY1HaBy+lVQsxRmrOJif+lCfHKfKQKXRl56Y6/e/c6H2BA0VHmjIH5nnUGTXKLv01w498mQc7PqZBVOT9QEBdC8iYTuNBquvpKHQtzHB8y+hWJJ/zU5wTsKgQlpaz/9UByK3NRTXk3mhDAuzdWnpFHlMmjgE5XZO3P/WZq191TR4tJW+5+RZ49cOtiNL7+0tG/IVH12OC5hiLcDextW3Htc9qqS2jBEDrSbcoNmf1mjEXbY037yyk0HaXfySgy76plGLP+Ny9N4USPX9RmHoQhzF1t3agb6ki/J0+oc0eVDNWXRdOD0yWBzy4s5LgCa7uLQoUgQY7e5ijxreav72wEpsAhBBQQKSIIVMiIXDLRcDQOwvEvOSD5gc+Wi/F85zyqOLE7qzChVCM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X5B/NAvf/CrCLLefSUKJBSCUxi8cJVtH0K94zYnAuVzoORgQ1fSg99f3YLo1?=
 =?us-ascii?Q?+fwi6eiIDQGRDr+DNCJKkrlJXi7FQ2aphk33s2wUK1wbyjqIpnI51bKGYJk2?=
 =?us-ascii?Q?dNXZkajg/nLIO0DjftwJMqNem7odEcCHloKR5QPAMOgokf5FbalSN7+CMEHb?=
 =?us-ascii?Q?ylPBkB8VbTNE138iJAVmRCJEaV+ACa1u1QpfsMADMNdx8/N+KpiXJiuadDBg?=
 =?us-ascii?Q?4ZGsvY9IaQQcjes3g0KJr0bH4VrKvUP1RrSFGTkKTZDnIqfQTSesqhyi3PQ+?=
 =?us-ascii?Q?Xo4/6yFUil/WH1trh332myGxGxd6z4M7nJJhZa+NaAVyeKuIsi6Cd/q9CKie?=
 =?us-ascii?Q?wiAGwoXSl7EgTURQC5KI32GEHlKbMLS/a1z2JwLJVF4ntvZm/fshx10A1g2O?=
 =?us-ascii?Q?rxbSsl6da9DuxpyIvIT8QLVlM+TFvJirlRpC8000if8gN+vLpMS1QEzVtRoJ?=
 =?us-ascii?Q?ihmxeR7IL7S/5gF4JZykfRRGRftRClOk+x7VBvyRe9zIRZbcc8FYqniE4eBi?=
 =?us-ascii?Q?0gsX3tCskv4AbA0msBbnL4L2+X1S4dLFLgVkOWDnqvzfHfLjf7DyX8da90AM?=
 =?us-ascii?Q?pW+uAvOqha88egpnBl8Im99YNoTe8OVpST1ThbspN30i+ErWmf0g3ehayXCG?=
 =?us-ascii?Q?y/5TqtjPFXfAZqdnT+RdEJ9gkLOAx+/I8bovXRwertsWXOnbhzVlvZxNjpin?=
 =?us-ascii?Q?ruZD4H+CS4i72h5xlKvE/7+jwlSqU75dQrK2yniVdqGwh1zlMw1O8HJhyQ+6?=
 =?us-ascii?Q?Wbk5+5SXZujy3l+O62NLXfmBEDX94yDNuFcQ+nkvYg+fiiJhFz5egdV8E6p3?=
 =?us-ascii?Q?wAc3QMKDUpSEuw6+Krual/b5ITYqg2PxnHjkBmw8SM4YjaIT5Cvuiha/0wxD?=
 =?us-ascii?Q?rubgmci+A4WVA2XT5mR8rP8JAX9gPHPivKII71BLSl07oA1ruLoVeA22qVol?=
 =?us-ascii?Q?GQqXRrjcJI0X2HlfHeVdxEU6ke9vRs0TSkNfHh0TYdM++BJTlcpVynJvDHg2?=
 =?us-ascii?Q?yHB/fnRg08Hq0mpzPU7UIX3BP4qfe71ZFR7KsppZyvwHPzpaol8IHkzs4ghh?=
 =?us-ascii?Q?vVuaPksOeEWMLmmmbRFw5qUFQGDTBuuoozCagy0dDpkFeuemtw9dOKj3D/81?=
 =?us-ascii?Q?P+7clumY5v+W584JSrVbFYiSuAusnQsRyC8JhU6z6P1Emtw0ga8mF+f7XuuD?=
 =?us-ascii?Q?2R+wEqJ3J8BUhnY4cHQ6XWQers8ux7j9DSoSm7JCWM+2+e6J01v68zGrcBi9?=
 =?us-ascii?Q?WGZqEj4RO+7SZ6LvVr2NiEJu2GIbVUOdkGkB1syR8dF0qkRvnZrq78L+r6Rd?=
 =?us-ascii?Q?mSGHqfcI2y5M7ExhvJyGXifoqvXoHep/BWlXajuW1ykpftiAxVsmWIB1JAnO?=
 =?us-ascii?Q?hlTouf2uphk5mDTW72OVJkrZ9FRt3irQ9wgOj20pSdNYHyoGyuEKARrq/ALD?=
 =?us-ascii?Q?aCT1qWPqM65ZFp+3fc6dPMBueKfmAXqR5NpoSYPvHRRQTgZTqdzxxMUoVTjD?=
 =?us-ascii?Q?H/e5z0qLD7u2W93o6DL9fs5HuAuutjqFr2n38RfA1uaN5N1oxgeIMLXdFRkY?=
 =?us-ascii?Q?LXqPVmeXwdzUqPf3rfvZLl4iXO5wLlKMSOuCMRWHriVzfINkiM8UNnRXNTRg?=
 =?us-ascii?Q?Zg9S4MBSwPMQk3171GzVgxBMoo1QxhVDjvoAId8sD4TWxiN6fgVENJVWfp38?=
 =?us-ascii?Q?4iTl8XlYSEvh0rcReeufgMZO4ctE5uupifuZyQ0KKQhDBbxCUZinlm9IAGtA?=
 =?us-ascii?Q?QfTUSMs7Rw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0790acd2-1232-42bb-cf61-08dea5d5e40c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 09:58:40.6828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQxogmjYWFvniVQe/ubYf3eYrFOg2Cg+9iVkRqFAl7rTq8Wf+6c4F3HbZfKmEyLZomGw3fgQ8Et8jKmaOwRlcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8269

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
 sound/soc/fsl/fsl-asoc-card.c | 71 +++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index e08e135886f7..90414ac10032 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -40,6 +40,33 @@
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
+static const struct snd_pcm_hw_constraint_list cs42888_rate_48k_constraints = {
+	.list = cs42888_rates_48k,
+	.count = ARRAY_SIZE(cs42888_rates_48k),
+};
+
+static const struct snd_pcm_hw_constraint_list cs42888_rate_44k_constraints = {
+	.list = cs42888_rates_44k,
+	.count = ARRAY_SIZE(cs42888_rates_44k),
+};
+
+static const struct snd_pcm_hw_constraint_list cs42888_channel_constraints = {
+	.list = cs42888_channels,
+	.count = ARRAY_SIZE(cs42888_channels),
+};
+
 /**
  * struct codec_priv - CODEC private data
  * @mclk: Main clock of the CODEC
@@ -87,6 +114,8 @@ struct cpu_priv {
  * @codec_priv: CODEC private data
  * @cpu_priv: CPU private data
  * @card: ASoC card structure
+ * @constraint_rates: array of supported rates
+ * @constraint_channels: array of supported channels
  * @streams: Mask of current active streams
  * @sample_rate: Current sample rate
  * @sample_format: Current sample format
@@ -104,6 +133,8 @@ struct fsl_asoc_card_priv {
 	struct codec_priv codec_priv[2];
 	struct cpu_priv cpu_priv;
 	struct snd_soc_card card;
+	const struct snd_pcm_hw_constraint_list *constraint_rates;
+	const struct snd_pcm_hw_constraint_list *constraint_channels;
 	u8 streams;
 	u32 sample_rate;
 	snd_pcm_format_t sample_format;
@@ -291,7 +322,39 @@ static int fsl_asoc_card_hw_free(struct snd_pcm_substream *substream)
 	return 0;
 }
 
+static int fsl_asoc_card_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct fsl_asoc_card_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int ret;
+
+	if (priv->constraint_channels) {
+		ret = snd_pcm_hw_constraint_list(runtime, 0,
+						 SNDRV_PCM_HW_PARAM_CHANNELS,
+						 priv->constraint_channels);
+		if (ret)
+			return ret;
+	}
+
+	/*
+	 * Apply rate constraints only to frontend DAI links (no_pcm = 0).
+	 * Skip DPCM backend (no_pcm = 1) as rate is fixed by be_hw_params_fixup()
+	 * and ASRC frontend handles rate conversion.
+	 */
+	if (priv->constraint_rates && !rtd->dai_link->no_pcm) {
+		ret = snd_pcm_hw_constraint_list(runtime, 0,
+						 SNDRV_PCM_HW_PARAM_RATE,
+						 priv->constraint_rates);
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
@@ -753,6 +816,14 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 		priv->cpu_priv.sysclk_dir[RX] = SND_SOC_CLOCK_OUT;
 		priv->cpu_priv.slot_width = 32;
 		priv->dai_fmt |= SND_SOC_DAIFMT_CBC_CFC;
+		priv->constraint_channels = &cs42888_channel_constraints;
+		if (priv->codec_priv[0].mclk_freq % 12288000 == 0)
+			priv->constraint_rates  = &cs42888_rate_48k_constraints;
+		else if (priv->codec_priv[0].mclk_freq % 11289600 == 0)
+			priv->constraint_rates = &cs42888_rate_44k_constraints;
+		else
+			dev_warn(&pdev->dev, "Unknown MCLK frequency %lu, no rate constraints\n",
+				 priv->codec_priv[0].mclk_freq);
 	} else if (of_device_is_compatible(np, "fsl,imx-audio-cs427x")) {
 		codec_dai_name[0] = "cs4271-hifi";
 		priv->codec_priv[0].mclk_id = CS427x_SYSCLK_MCLK;
-- 
2.34.1


