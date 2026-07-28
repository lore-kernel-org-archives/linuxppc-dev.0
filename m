Return-Path: <linuxppc-dev+bounces-24927-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56ADC53219
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2026 10:42:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8X972L31z2ykc;
	Tue, 28 Jul 2026 20:42:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785235355;
	cv=pass; b=bJA8IswWI17XVhYpqs9+jdoaO3h67wu+orajvXt+9wf4diqg7B3rYQwt5tuPMx/x3xvbeXTUQLj9SH/f5wcm3p7YLcR0RljZoH1njYcUL1qlulj/Zk+o7Zk3Hk9t5KsfqbjhALmA4Ulk9lsRHjNXU4kP6ukptB0fvtGHBpMKG8MmDU5MvVFPiUBTOxYOuST60uA0LH5x7e86X1/7vTawxnYmAd9VZTbuXf3PuOdJrqsRZMG7IEQ9QAYvgkt2cdnkDU4p/XA8TB9MMOE+WxwECZoBAMKPSZxSGYNt9tXH5mhXr0jHqZucMLQM18r1OocP76Xsq7Cjwye56E9VeC8o1A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785235355; c=relaxed/relaxed;
	bh=dXCl9aiWwmRHllW6CavIYaiR91eNj21ldMovcvX3MeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nlSLYrQgq05bQ6SC4WZdVKSb3DLlHcFMzWRAaJkKpwMQ5DS8hzDXQ/TAra+IsTi0sfsFzkbGn2QdQgPYD8XjsFzOY+zGYGkoF8h9AABGsUvMrIc888zpGxxVF1VGB6M9l6PfxIAH5WPqaUzxOLkj4CSB/Lt7KbyVow8fyr6HKx6odrn/b/yfb/bc0jmB6HzFnrU0Z01VB4afjBZD9JI2ktdmbU5UhQKn1h2lkIAB5CYliCFI0Hz240iQ9mv/V5RSO/YH2/yaVHOYGpVeUKPLpyO+BMyExdZeF3BXbr2H52Xkp3Kj2BOnj1XZUq4Yg7MxQoAlKMIGxDvOhwmZ/0D+wg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=AlbxX6g6; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=AlbxX6g6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8X963SL7z2xlQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 20:42:34 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rJWDWKxPC8TrUXv1mlk9HzBQri5Is4W4dnOWlTP8Eiaq7Sbet1lKGttSCfmKb+FI9Tr/8qMhOL50VrkS4wIBuNwQw1XsLoeSolDUfdYCnm/+FynFtpj79ccrP54qe5v2pzgJTpBVl6yMOCSdLLCtUGi4spPFRl/4my/G7N/jsx7fa2wGi6X0ln/wIjGkkvXkVZAtv/NaOOWi2rtr19yjnO7WS5L2vBSKuCkDz0fN90dVWB+djZpF/rGiSjkbhVa5gC25hK/9e4JAqNtAED1JuBun7DLYs7SIsTth7LKiFhjdGFSApYBAX4MvazuHnT+HkqvWsUHD5RiH/UMaYXAtdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXCl9aiWwmRHllW6CavIYaiR91eNj21ldMovcvX3MeQ=;
 b=tRuoIV9RLcQ/lm/8a2rWTnieBURwwymvALfZm5Oz2o9QvcKYP1aefYi/huxQ46csrTVAjiARjVLMl5ccC2I8r/rcLvkWQ5cv1PkLXgdYqPH4J7K4aruTeY47CiJBzTCRUkYFsRt0ShLstAu/5tB+pdS5goVNHNFI4E20Z8tkcmSJ+j8yQSdirC3MNvqpPzqS19m4bSr744IyBVozxSvBKrKrbdIbm8YvB7hrc1LfQv1JvpHRX22RMsCVh96AhTmRSbLsMU1paZ53ADy/5iVZQ1wB16203E0kCW0CXR9e718Q68iref2wuIU30wBwahFz+dxW7Z5W9ebw6mWNOrdynQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXCl9aiWwmRHllW6CavIYaiR91eNj21ldMovcvX3MeQ=;
 b=AlbxX6g6bgxtMizW3U2hg8hVkZlTpbfLuhHFrAKiCh2Qsm9Es1JarxfeBOuK9E5jlFojowhy5skmAXGIqZikc4GmQQ0GoRTICF0jNl9pPY3lKSayvSuWPU8E2Qpzq01Vz8rKmlkvJromNPpUIesXvxNeCdTutoDe2kSaD95e1moEB4R31hh8iyY6lPqprAvojPEu96KseLjzLstGDC7dcsDbDaRZJZB8IGHnN1/TWWiuMGiaeaVk8P2TgVbohFAvI7n2VYWg00bfOJAGbCLk8yhuK0uu/bsSn+CMHjoCiNIpIAsFOpcuyylFfw2l1qS6cSZv2uM6ZIfFxqBk+BlESQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com (2603:10a6:10:1b2::17)
 by GV2PR04MB11835.eurprd04.prod.outlook.com (2603:10a6:150:2fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 10:42:10 +0000
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14]) by DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14%6]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 10:42:10 +0000
From: wei.fang@oss.nxp.com
To: richardcochran@gmail.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	olteanv@gmail.com
Cc: wei.fang@nxp.com,
	chleroy@kernel.org,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 1/7] ptp: netc: use ioread64_lo_hi/iowrite64_lo_hi for 64-bit register access
Date: Tue, 28 Jul 2026 18:45:42 +0800
Message-Id: <20260728104548.3301214-2-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260728104548.3301214-1-wei.fang@oss.nxp.com>
References: <20260728104548.3301214-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::7) To DBAPR04MB7207.eurprd04.prod.outlook.com
 (2603:10a6:10:1b2::17)
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
X-MS-TrafficTypeDiagnostic: DBAPR04MB7207:EE_|GV2PR04MB11835:EE_
X-MS-Office365-Filtering-Correlation-Id: da636d59-4507-4114-7206-08deec94e0ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|366016|1800799024|7416014|376014|56012099006|10067099003|11063799006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	DWs5gI0yA8BgUld3zT2lsxNEgGiWNWBhNI4Qqgye9g/f/O3Om6/FWxSVKwW+kwublGyBNp6O7sV3Qlpr8sJSPAKgwzP0hptQcYlf2E4q4xxPQ2lguSOl6C6+i12vpe5Lp561DF7EaZqBm2NRbtHY+Ylxspn+/95oAND2XLTSvJRjqhKTq5KN/BOwkKt32IJCyUJEUBYCgkraI/NeUIG7oyVUbqeGAJeIZ+A7WvGuECgQIxh8Vy4y82OFP3aag/u/YZBBHAS7s5zB+yL2ANJe2pxnDEMspKuAVfNKzlvU9hcT5ou/qc2XsUFAWqzpCh3k7W5kuFuZbPV3nJNGGMo4ayjfryny86usPGH/7UkadiMMyH+P3aRQuA2mrorb65VabnmZZmsWRj+lo+FarhAvSh1EBviQvdIjQKqsLSmFa+pVEIIZ3B5GA8XFMRhq7uvB8+rkjX1KnIbaM8aCZKWhai6Ab/766ZFEgA2EjLQr6exAq5xnLia2k3+Pua4e90OVsI38rFv8YgwoKKFkmvHOEM2gX13aVFsf2UEsTz11xh957kKdqjRk65GiXYPeEAM6UBknx3L24fOeZG/OJ3cmSVPpHD4n7HfJSIzAyiyELtbvpzqGiONDTGaeg2nhZwfGIAfcdLzLpXS35vuqPQu3xcGUnUBEW7AAbmDdjwHN8s86FAXKhQa7I7LPXaZpoVmkpekaeiXl+TpUls+pUsWV0A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR04MB7207.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(366016)(1800799024)(7416014)(376014)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PtgcNg+n5fWAYYbltG/GFeF+rT/xkJJ+RH4cd/qNjg1/lUh8h956gX37kfvz?=
 =?us-ascii?Q?GM3IpaptF0nD3Pte1MDERQugGtmfLX+Y+jdDPDmEjovTKe5DHuDbwepw3YAr?=
 =?us-ascii?Q?nqA2n5Nkci06Arb6Cky/36yq3jT7vi2Gp6VwkyQl0nn1eB6rJ22wdmc1R4q2?=
 =?us-ascii?Q?3eMdn9LNIo1vxQOjar+KlGyDE/C2uopGjK7f0rDKyjJczrUhbCTipOQVuGL5?=
 =?us-ascii?Q?hddkIwpRbezenYCfPzvSn7o2v3d3djSq7HHjqT1k5tHT8OUVPpyPlQ3p/9hD?=
 =?us-ascii?Q?JD195MPGPPzn0XvImr40kIUS0i37aUKsQ0fdQVHnynEIAXsliIiBfz/b9iZW?=
 =?us-ascii?Q?gXNN4burRDK1qqW7CkfTeZH9aiy+AK8hm6L/BsbTNR/TQGzLK821RQ3qaRYx?=
 =?us-ascii?Q?5Foq3YdpWvFUIxro0GwOiNgiSTthS7V1oOwRVwORMi/sjo589W405Kd6Ve9x?=
 =?us-ascii?Q?82iYxE2iU0rBC7NnMkn/64y5uVmq/dvJVEBIoU/GNaGcENFa2CqacO7uN63b?=
 =?us-ascii?Q?2ozgsJqLmJT2Rzw//8uNWbgXLY7mmDrXVdjUYuw3i4lvJ3abQYJmv+1v1Hj7?=
 =?us-ascii?Q?XEoIHRCeDYNIRRUTMQDT52TRkcf1muyRi4M+wE+eqb3I0fXdRI9ntEf/uq7H?=
 =?us-ascii?Q?GNCBBCsVm4dfZz09XU4aHobPNXN3iLoNCvLhAp1aJ/lH/0ZlHcqveAaXm3Ox?=
 =?us-ascii?Q?qV19GPBmFFQSrVgbSJrJWGLA80Yp7ct8cciPprzNmoqItdn9BoNZqPk1WToX?=
 =?us-ascii?Q?1/nACdD6ZHkwMO5MqXoym0mvzICqcy9AwiRW6t8QXsqWxQZAlTXJhx43WMxz?=
 =?us-ascii?Q?XPKm0fWAgUew15lpnQOspQ4ge+CE//0iutay7gES8e6XimqOUPPnhPYvcI18?=
 =?us-ascii?Q?1cohThgJLA0doOTvkp80xkohRiSwKm0rviFw24CjjMJbOyYjp9Pu0IIJsnEN?=
 =?us-ascii?Q?uaQg26nfUuKBWQAF3L6L/JMtgpDOYC7zGkHuMppVzdepRYqWPs8iUN3oEQ9u?=
 =?us-ascii?Q?tl2gFaklyyiW9YdSfAS4+Ssgkb7GtVeizJgBqoqxm75wpqMmixJ0N4tD23MK?=
 =?us-ascii?Q?FSuPta9EmwySjTGZixd8kdb6oRlKbtvBOGSu5iGOgE6jl/KfM1S36FgVUVK/?=
 =?us-ascii?Q?0lgJwNouGN/ZlJ9p/udphsFLOqaa7rf/oTX0aT7jtLx2MFvndpSVyP6RP6qp?=
 =?us-ascii?Q?SUuCR4YqWdF3lobsXuSKIsAmhN7iKjH7xZe69+ux9aq77AjypycI3YUwPjKk?=
 =?us-ascii?Q?idfDnw4mCOeLPlfpib1zSWREGQhGAJ0qXViJ88VfscOfWUV2pOs31kSZ2Nvs?=
 =?us-ascii?Q?sqUKHDmByK5R1jBq93l+m716ruMRGvDv4lDsx842gCFZEFUoRjCBpFcL+llk?=
 =?us-ascii?Q?tP0D8ZAphtYbRXwK1gIlSw388Zu/SCxZBRNnGUMPoJ8338HLSAIlInkzbLVa?=
 =?us-ascii?Q?MsYX7DhNRiA5Qi8pgIAZcPqaucceHd6zH9h+jpp9fx3DNTbu+F2F2/vIbej0?=
 =?us-ascii?Q?Chiwm/pUBro2OOAjX0teTLOkGKgoDPHj2lfog35//bGvgQgkVNvqvnepxPVM?=
 =?us-ascii?Q?lWdagS/JMCzSzVCL2PkXT8BjWBvajo70gG5UflF+joddyB6eUwKDkywk9gfG?=
 =?us-ascii?Q?t5DMEkxK4H7Qxf5J6pM1o8jG2KvgKa9nTpwM7wb8wN1ikiqXP4ZoTadzBpVB?=
 =?us-ascii?Q?YO3SnT4B7tn/QGV72BmJQjPQAyv9e/AgVzxRCgorYoU1xFdwu3tfJw2gafus?=
 =?us-ascii?Q?BUSWd+TOmewz2/p7oSzS6hFoRULxh/waYu5xnGoqd1VjPP6qeRty?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da636d59-4507-4114-7206-08deec94e0ec
X-MS-Exchange-CrossTenant-AuthSource: DBAPR04MB7207.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 10:42:10.7894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G2q7V3knuJSjYU12FxIQWHdGif5Wz6HT/2dtWHe7naMQ5Ho/0opd2987cTsWe113TeqTXe46IvHl45/cIZqnpA6ibGT/eQxWuTeQJIbrn1f+zXBTCOHsy0+pct8+5hAU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11835

From: Wei Fang <wei.fang@nxp.com>

Replace the open-coded 64-bit register read/write sequences with
ioread64_lo_hi() and iowrite64_lo_hi() helpers. Introduce two new macros
netc_timer_rd64() and netc_timer_wr64() that wrap these helpers and use
them throughout the driver. This reduces boilerplate and makes the intent
of each operation clearer.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/ptp/ptp_netc.c | 72 ++++++++++++------------------------------
 1 file changed, 21 insertions(+), 51 deletions(-)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index 94e952ee6990..78c6d235127d 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -127,6 +127,17 @@ struct netc_timer {
 
 #define netc_timer_rd(p, o)		netc_read((p)->base + (o))
 #define netc_timer_wr(p, o, v)		netc_write((p)->base + (o), v)
+
+/* The 64-bit timer registers consist of a low (L) and high (H) register pair.
+ * Hardware requires a strict access order: for writes, TMR_xxx_L must be
+ * written first, which latches the value into a shadow register; the write
+ * to TMR_xxx_H then atomically transfers both shadow registers into the live
+ * counter. For reads, TMR_xxx_L must be read first to capture a coherent
+ * snapshot. iowrite64_lo_hi() and ioread64_lo_hi() enforce this L-before-H
+ * ordering.
+ */
+#define netc_timer_rd64(p, o)		ioread64_lo_hi((p)->base + (o))
+#define netc_timer_wr64(p, o, v)	iowrite64_lo_hi(v, (p)->base + (o))
 #define ptp_to_netc_timer(ptp)		container_of((ptp), struct netc_timer, caps)
 
 static const char *const timer_clk_src[] = {
@@ -136,66 +147,28 @@ static const char *const timer_clk_src[] = {
 
 static void netc_timer_cnt_write(struct netc_timer *priv, u64 ns)
 {
-	u32 tmr_cnt_h = upper_32_bits(ns);
-	u32 tmr_cnt_l = lower_32_bits(ns);
-
-	/* Writes to the TMR_CNT_L register copies the written value
-	 * into the shadow TMR_CNT_L register. Writes to the TMR_CNT_H
-	 * register copies the values written into the shadow TMR_CNT_H
-	 * register. Contents of the shadow registers are copied into
-	 * the TMR_CNT_L and TMR_CNT_H registers following a write into
-	 * the TMR_CNT_H register. So the user must writes to TMR_CNT_L
-	 * register first. Other H/L registers should have the same
-	 * behavior.
-	 */
-	netc_timer_wr(priv, NETC_TMR_CNT_L, tmr_cnt_l);
-	netc_timer_wr(priv, NETC_TMR_CNT_H, tmr_cnt_h);
+	netc_timer_wr64(priv, NETC_TMR_CNT_L, ns);
 }
 
 static u64 netc_timer_offset_read(struct netc_timer *priv)
 {
-	u32 tmr_off_l, tmr_off_h;
-	u64 offset;
-
-	tmr_off_l = netc_timer_rd(priv, NETC_TMR_OFF_L);
-	tmr_off_h = netc_timer_rd(priv, NETC_TMR_OFF_H);
-	offset = (((u64)tmr_off_h) << 32) | tmr_off_l;
-
-	return offset;
+	return netc_timer_rd64(priv, NETC_TMR_OFF_L);
 }
 
 static void netc_timer_offset_write(struct netc_timer *priv, u64 offset)
 {
-	u32 tmr_off_h = upper_32_bits(offset);
-	u32 tmr_off_l = lower_32_bits(offset);
-
-	netc_timer_wr(priv, NETC_TMR_OFF_L, tmr_off_l);
-	netc_timer_wr(priv, NETC_TMR_OFF_H, tmr_off_h);
+	netc_timer_wr64(priv, NETC_TMR_OFF_L, offset);
 }
 
 static u64 netc_timer_cur_time_read(struct netc_timer *priv)
 {
-	u32 time_h, time_l;
-	u64 ns;
-
-	/* The user should read NETC_TMR_CUR_TIME_L first to
-	 * get correct current time.
-	 */
-	time_l = netc_timer_rd(priv, NETC_TMR_CUR_TIME_L);
-	time_h = netc_timer_rd(priv, NETC_TMR_CUR_TIME_H);
-	ns = (u64)time_h << 32 | time_l;
-
-	return ns;
+	return netc_timer_rd64(priv, NETC_TMR_CUR_TIME_L);
 }
 
 static void netc_timer_alarm_write(struct netc_timer *priv,
 				   u64 alarm, int index)
 {
-	u32 alarm_h = upper_32_bits(alarm);
-	u32 alarm_l = lower_32_bits(alarm);
-
-	netc_timer_wr(priv, NETC_TMR_ALARM_L(index), alarm_l);
-	netc_timer_wr(priv, NETC_TMR_ALARM_H(index), alarm_h);
+	netc_timer_wr64(priv, NETC_TMR_ALARM_L(index), alarm);
 }
 
 static u32 netc_timer_get_integral_period(struct netc_timer *priv)
@@ -497,22 +470,19 @@ static void netc_timer_handle_etts_event(struct netc_timer *priv, int index,
 					 bool update_event)
 {
 	struct ptp_clock_event event;
-	u32 etts_l = 0, etts_h = 0;
+	u64 etts = 0;
 
-	while (netc_timer_rd(priv, NETC_TMR_STAT) & TMR_STAT_ETS_VLD(index)) {
-		etts_l = netc_timer_rd(priv, NETC_TMR_ETTS_L(index));
-		etts_h = netc_timer_rd(priv, NETC_TMR_ETTS_H(index));
-	}
+	while (netc_timer_rd(priv, NETC_TMR_STAT) & TMR_STAT_ETS_VLD(index))
+		etts = netc_timer_rd64(priv, NETC_TMR_ETTS_L(index));
 
 	/* Invalid time stamp */
-	if (!etts_l && !etts_h)
+	if (!etts)
 		return;
 
 	if (update_event) {
 		event.type = PTP_CLOCK_EXTTS;
 		event.index = index;
-		event.timestamp = (u64)etts_h << 32;
-		event.timestamp |= etts_l;
+		event.timestamp = etts;
 		ptp_clock_event(priv->clock, &event);
 	}
 }
-- 
2.34.1


