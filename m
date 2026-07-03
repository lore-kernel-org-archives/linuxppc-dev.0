Return-Path: <linuxppc-dev+bounces-23488-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31E5C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 10:43:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gs9MN41n5z2ygG;
	Fri, 03 Jul 2026 20:43:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783075392;
	cv=pass; b=b2kKvWPWRT/AVTKSIoPW2XSoV+nhyJOfXDu3F7H4dmyLtAarT/exH7f4E+q6Igh2ecamKo24/NNt+0S8mCH8VkHsT62AC3NJRtoNPQnnilWZx+Oje97Z515SmYbZcEccQMz52J+XpE60VXKY45gwG7oVVmuMVa3mNkFafO6p1FRL8eOOeLTx0rV1xNPP0sVgj1zzBCZf7Kfh/QK0lGxWdEqerxl7gB07mGmy7NrAbiBBlJA1UQifKzFGgryKbX9Bu5Qt/orIrsfQJYQqzz5wMtZfJZjpFrP9lHuJ7g0+J/zmdhJAMJVsZpgqo9SodAduOmKc5HqqtZcHR1mnTjaYsQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783075392; c=relaxed/relaxed;
	bh=lXObFrFI4ieHCs+YnoMphsXVCjKXrlVokbXMdZ6VFnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T97woffhBGN6DJDYOcd+jE0TGK5v3xTDZGzHkUMKqfe4wO892zb/wbvI2OhBqLRi4BYA+2PTGOW7BNoeQ8S9CdR7CL18xZbfHuqn7bvbpI82zfhiAKpz/pKMp9f5WMfZpDNV8YuwBUS14XTHab8sFChWSHDMU7kyyVvxo6d7IWjnYG3KlnUNI46YcNVXLJsY8yd73db7+1Z3D0xHfv9NxGvSQEKMvHhxZVGzBKgsAn2O3CXnq91+OVnX/LsyKcC8wnoqk9RaAEZhGBW6vQY8UBPynvc0ycMB+1xbyRgqDKasXIPElSqGBYkgJwepJ69LDvAMIeXVM+2KYfSf8VeVrA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=t06IjC+6; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=t06IjC+6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gs9MM6Rwlz2yfy
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 20:43:11 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sxm0BwrKHeukmvO/JH7YHvN8+1xsGiSW65pQAZeuvOXi5QNPXhvckMnyQuvuYIGw7gmnlacFv0VHk+Y6UE4YeT0UqiHdTEC+XFumlBDNpXv0aqLuHfYJutLmiCJD3b8IL8TJTcpwlSZv/fNQVd4UPHmzTHo2/Ptn89TuCNkZzUnP1aQ2GjLigtqO7AX2jIbeHJsrC07L4HU6N3GsP8L1dUqnqaxmNKHowXwN09TwIJdSy0ZrCDcj7QHSr/p1V9stt12XUIn0yXrNpbGae9euJvmcMEu1lJ8/6fd9QwIWYH69zHGYbKiz9CdWu+ISBe005HB59FleZMTUquPBt4CtFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXObFrFI4ieHCs+YnoMphsXVCjKXrlVokbXMdZ6VFnM=;
 b=oggyZqCPsTU4ET+8t9ft6tPgq/Igd4V0X4OpbsljoTwUfb4gucNP5QMl4RwUUs8mUEAaPth1sDlxXf7lWwQisv8SUIrJIXfPaWotwsLTiCHaA7j8PV4dvilGK63XeFybWMW+jOE55OBgk6H5t9eAwNP5xtdmQXW5CllVZD2k6GBwFiHCu3hN/YHUKG/4qt4MHt55kQFCtaG9Uv7sZKvbo1MPLHtHm11X121KjJiCyTOhYC4hO9XvIWN3h3s2cPT4cyqXzaM8WgUIwwyUZ/DaF/NGBuua3IHrMIQTL0Q/8m9mZLl4/ZPlKk8ze2LhFOvvru/Gyu3L++1Xg1qPTmWyfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXObFrFI4ieHCs+YnoMphsXVCjKXrlVokbXMdZ6VFnM=;
 b=t06IjC+63oEC0B0ic74tUUK3Fq7Peys9hlEklmN+vzE4+s+jnDBPy1C+eHLKcI+6vYoUK3VqMPKQWs+Cbs51RqvclgEVNWxKeQ9CmUpcd/4Tma1Z6YkjaCiTOQhCOvaiH6Frc42Ver6mrqcDuwestZ751uH5f0B/UDlUsln7MzN2mavu/RYERVDmOSTpMpjWV1/BEIFTwlmhtNp4U7G2726VXxa5dGth64yKG7Z937bKSzPxaM5Oa/YMGyKugH/irSkXtPkENKUqIuE0EU4VjULITM/pKCRaC4SXQ2b6Grc4nU6zDjYJqHMQx+oDGxDK9cgyNJ/noyc7vZK7F6AvbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PA1PR04MB10867.eurprd04.prod.outlook.com (2603:10a6:102:483::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 10:42:48 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 10:42:48 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	wei.fang@nxp.com,
	chleroy@kernel.org,
	maxime.chevallier@bootlin.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 net-next 08/14] net: enetc: remove invalid code from enetc4_pl_mac_link_up()
Date: Fri,  3 Jul 2026 18:13:22 +0800
Message-Id: <20260703101328.550714-9-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260703101328.550714-1-wei.fang@oss.nxp.com>
References: <20260703101328.550714-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0272.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21d::16) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PA1PR04MB10867:EE_
X-MS-Office365-Filtering-Correlation-Id: 1529b0d1-d6f3-4a18-5196-08ded8efd32f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|19092799006|1800799024|366016|921020|56012099006|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	nwav6E9MiKguloxNyBG7jRUGoWGrNtvfr0T9qy6WjzFU+szoUXFosv1KNQ2GG6m0z17mPZqCLEIFFpzqxSLbUIb/+RCdvVBRit2WmEky7CcbsZ6tdaQ+m0jyxkGfk2R4eM/vz8L53Nxui83b9e4LWHeLrExDskR6MNsrzML1u/kYoooLgMasyZ+KBFzmnMzA3WZsY78Fn3vLRRZHUT5emNLwCaN0Hyz1gW8JZpTTFKXsTwGJ2JcnRao0tTn5S58lOj0Ql5HOTrBSBixwB0OP9ZfWW4nethZv1r8Tcx82dCD3xIyynH2KQXjNGmxlozAEl/RSonkIDehhlolCOaDdxl7jgXRZQX7bw5bV5cgeAU1Gjk5fpor/IsellhiKGzg+3x5Ihx0OaOGGrCTT4tqsVzWF+epmpl5cIhB9x9cXgrXeQ9l9zdqKoM+arh7VLwFkRO8Bz/87G1KTmc+kdLwdghcRKQE9uQswck4LphmnFH1HytmzqlyR1qnGO4gOB3C0wc959OLuaSobnHrJhTHWimdNg4FP16oltkKb+87FUDUfjqXwynu1cLxTnVFeIUMF17JKz1X7G6R7qg8noocpeoriZnll4Jq9DYUgab5aLh2ccq6mXVW8uZYMnG3CTwbynMPZF/k+D0A7Y6+Jtwczm2VSX2NrmYd9ng33xRphoX/vywmf+d0RaE4MCB4r22qu4ECCqSGM9w0X6A9b0cKE/Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(19092799006)(1800799024)(366016)(921020)(56012099006)(11063799006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uh3hY2XcRhdmhPbo/Q/n/SqNWd1Tnjz/YJlpusDyuHPGN+ZqAIy3qRD/ECir?=
 =?us-ascii?Q?W+9LacvUFaHT7lPh69bHszm5KruNEYK7k9Fh0wQ0dGIm+Jfk9pkLr+ZDabBY?=
 =?us-ascii?Q?RcbUEVaCfmC1FF2sThh8ALJoJidpjUj80cm5zB2iSSgaYdZVRFfkSIsTbYUu?=
 =?us-ascii?Q?yEuvxlG+KDrYF3uYiGyZa7kR+2U9NjgcknWRDet3IbCHjYVdNWdpBAv5amCU?=
 =?us-ascii?Q?cz67Xair5cIghgUivryDGjEC6SqyqoPITC/h//aktvZ8KpEhPyB1T0d3U0DV?=
 =?us-ascii?Q?6xKVroBp4dFbmi7ANXiFTdqSgMLY44b/zXDcoyhtNn5UxiPyQNgX56el6vnn?=
 =?us-ascii?Q?wpE7bjGzyXuIM62LCsE5I7MEJHQr9Rx5UJ2xxB7CzD0FZiBnA4sIiiYq1SdY?=
 =?us-ascii?Q?v9t3Eh8QcHbxSO9UOFDX0pSgstjfFpv0WntfB4owIp1SXf2FG0jhrGntsBMz?=
 =?us-ascii?Q?75N0niX5p2p9ZYHoqGJCPXDHQoJzF3NlyCE7xn40lhb/g5L0xdOBFwqgT/8r?=
 =?us-ascii?Q?E+4VvjMMEkEPS81Xstq2NO6s0GOVKY8HlYUVYNCcTCDIeIxkfSph5jvXze3N?=
 =?us-ascii?Q?KTOkiAd4XqD7vunhwF9xTEeqV55Ftis/7uxL2ZF3c2yEHBcEAOhdH7H54185?=
 =?us-ascii?Q?bqi+DXUBTkOihk6ypF3dPYztUMrjJwMC9v0bcXYD8+pYa3e+nzuNSwnVWZIr?=
 =?us-ascii?Q?kMwn3AtaPzRWtGJ0yGt5SdS1IrQdudvYEQnepj4bY8ntEY6mFFVg4qbQ4GGg?=
 =?us-ascii?Q?S5Ksd6uU5rtzdbfVZ5QZzJdI702tSHeKFr3+jizHBKyXGfmHmaYAeOYBBNtr?=
 =?us-ascii?Q?X47wzPJFWYZgI1578gmoDvPNxiBCZpgmm3KebE1ug+F7f+lJy4mcO+nyFsPm?=
 =?us-ascii?Q?H/X0+FeALzMNxocnjDgOEAeb8nDHI727N+MLJDi8lodXTwMLmnthlCb+e0y0?=
 =?us-ascii?Q?AzKYg+m4hbPVFwa7XnhLxYc9yvu8h6cQj7+2IKlXgfdZULqahHx4IJ3wRwFg?=
 =?us-ascii?Q?w6V7z8Q0S5nAXaTqrRqbaWn5sWltlvmlSrSJhUJL0kkof7RlB0be7m8XWhyB?=
 =?us-ascii?Q?ynIjflUBUKMbI1+mnqbc3A5vTpZR5Uarvoe7AotqBZI8Eq9tDEnOVK2dfsPo?=
 =?us-ascii?Q?nhRaJmDdZaQolluCPS4fLf6UL0C1lgql0TYvdmZ9zSThGDoR0OrENdK1YJhK?=
 =?us-ascii?Q?F7b62gr6W38y6jA9SqBxBSj4a6uznrjAOGLWlOF3wPhJ0fe/Q9R9g4kOkijE?=
 =?us-ascii?Q?ETNHwfPgzXr1Qc4aDIdpYQYTewXvc3Xrme7tnHb2vyFjoWs29KPvDYnAyec3?=
 =?us-ascii?Q?hV9SyHAZzAttaMinGX/thebQ5EoCSPnAsXgXfUs5d05ijoaVJ/Ez89jQJ6AL?=
 =?us-ascii?Q?Z7bMQbtd4H4UWszi6+XjL8twNIZt0UgOb6MzqROttEGTMhkZmv4nWtfm4ouG?=
 =?us-ascii?Q?wbJUN7yWp2uEFCV++vDd7mkCNgvOW2F9hezqH7FlvlSvzw5JerFE/71r2VZS?=
 =?us-ascii?Q?7IXrANn+cwFyAFlV5xAj0izyI6CM3jRfRtCz11pWYwlFNWMKK/q1W3D58kip?=
 =?us-ascii?Q?YnVGduegDNyUgad/jxDZSSJdUfdSh2Ta/YysZg+d+k9ehnof4pox8+cNR1HB?=
 =?us-ascii?Q?jz+mwLyA6kRcTV5VGPHEiasIW4QiiMVupMu6YV5cHXxhnLDwh0wfUZ3/+TH+?=
 =?us-ascii?Q?VB0vvHO5L9unYvzsPVgT/ZDd3V3lNOnKiVNaAPHHVMlUEtqxaPHzWAFGPw4X?=
 =?us-ascii?Q?VcziM0JeL2u2DQ4ZU5CTPpW/85fZ1Zr8GNZZZWMAoJcbjkT3ANsy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1529b0d1-d6f3-4a18-5196-08ded8efd32f
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:42:48.6391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: twDe59UhwygR88RYiymcIFRwDnogRGcRkg9Gvhq/kd0lAEs3fyArvmHZhbGlsJzqPRZ0CxdImCTa8xfmP2JxLcuJvlWjPztpkXr3UbpqpXfr/SyxnDCCnnrnfgDv6kFl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10867

From: Wei Fang <wei.fang@nxp.com>

When adding phylink MAC operations support to the NETC switch driver,
Russell King pointed out several pieces of invalid logic in the
.mac_link_up() implementation (see [1] and [2]):

1) Half-duplex backpressure is not supported by the kernel, Ethernet
   relies on packet dropping for congestion management.

2) phylink_autoneg_inband() is unnecessary, as RGMII in-band status is
   not supported.

3) TX and RX pause are disabled in half-duplex mode, so there is no
   need to override them in .mac_link_up().

The same invalid logic is also present in enetc4_pl_mac_link_up(), so
remove the invalid code from it.

Given enetc4_set_hd_flow_control() is removed, pf->caps.half_duplex has
also become useless and should therefore be removed as well.

Link: https://lore.kernel.org/imx/acEIQqI-_oyCym8O@shell.armlinux.org.uk/ # 1
Link: https://lore.kernel.org/imx/acEFwqmAvWls_9Ef@shell.armlinux.org.uk/ # 2
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  2 -
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 38 +------------------
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  1 -
 3 files changed, 1 insertion(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index dea1fd0b8175..09025e7a2a3a 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -135,7 +135,6 @@
 #define ENETC4_PSIVHFR1(a)		((a) * 0x80 + 0x2064)
 
 #define ENETC4_PMCAPR			0x4004
-#define  PMCAPR_HD			BIT(8)
 #define  PMCAPR_FP			GENMASK(10, 9)
 
 /* Port capability register */
@@ -198,7 +197,6 @@
 #define  PM_CMD_CFG_CNT_FRM_EN		BIT(13)
 #define  PM_CMD_CFG_TXP			BIT(15)
 #define  PM_CMD_CFG_SEND_IDLE		BIT(16)
-#define  PM_CMD_CFG_HD_FCEN		BIT(18)
 #define  PM_CMD_CFG_SFD			BIT(21)
 #define  PM_CMD_CFG_TX_FLUSH		BIT(22)
 #define  PM_CMD_CFG_TX_LOWP_EN		BIT(23)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 75ee117e9b1d..859b02f5170a 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -29,9 +29,6 @@ static void enetc4_get_port_caps(struct enetc_pf *pf)
 	val = enetc_port_rd(hw, ENETC4_ECAPR2);
 	pf->caps.num_rx_bdr = (val & ECAPR2_NUM_RX_BDR) >> 16;
 	pf->caps.num_tx_bdr = val & ECAPR2_NUM_TX_BDR;
-
-	val = enetc_port_rd(hw, ENETC4_PMCAPR);
-	pf->caps.half_duplex = (val & PMCAPR_HD) ? 1 : 0;
 }
 
 static void enetc4_get_psi_hw_features(struct enetc_si *si)
@@ -588,11 +585,6 @@ static void enetc4_mac_config(struct enetc_pf *pf, unsigned int mode,
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		val |= IFMODE_RGMII;
-		/* We need to enable auto-negotiation for the MAC
-		 * if its RGMII interface support In-Band status.
-		 */
-		if (phylink_autoneg_inband(mode))
-			val |= PM_IF_MODE_ENA;
 		break;
 	case PHY_INTERFACE_MODE_RMII:
 		val |= IFMODE_RMII;
@@ -695,22 +687,6 @@ static void enetc4_set_rmii_mac(struct enetc_pf *pf, int speed, int duplex)
 	enetc_port_mac_wr(si, ENETC4_PM_IF_MODE(0), val);
 }
 
-static void enetc4_set_hd_flow_control(struct enetc_pf *pf, bool enable)
-{
-	struct enetc_si *si = pf->si;
-	u32 old_val, val;
-
-	if (!pf->caps.half_duplex)
-		return;
-
-	old_val = enetc_port_mac_rd(si, ENETC4_PM_CMD_CFG(0));
-	val = u32_replace_bits(old_val, enable ? 1 : 0, PM_CMD_CFG_HD_FCEN);
-	if (val == old_val)
-		return;
-
-	enetc_port_mac_wr(si, ENETC4_PM_CMD_CFG(0), val);
-}
-
 static void enetc4_set_rx_pause(struct enetc_pf *pf, bool rx_pause)
 {
 	struct enetc_si *si = pf->si;
@@ -886,13 +862,11 @@ static void enetc4_pl_mac_link_up(struct phylink_config *config,
 	struct enetc_pf *pf = phylink_to_enetc_pf(config);
 	struct enetc_si *si = pf->si;
 	struct enetc_ndev_priv *priv;
-	bool hd_fc = false;
 
 	priv = netdev_priv(si->ndev);
 	enetc4_set_port_speed(priv, speed);
 
-	if (!phylink_autoneg_inband(mode) &&
-	    phy_interface_mode_is_rgmii(interface))
+	if (phy_interface_mode_is_rgmii(interface))
 		enetc4_set_rgmii_mac(pf, speed, duplex);
 
 	if (interface == PHY_INTERFACE_MODE_RMII)
@@ -904,18 +878,8 @@ static void enetc4_pl_mac_link_up(struct phylink_config *config,
 		 */
 		if (priv->active_offloads & ENETC_F_QBU)
 			tx_pause = false;
-	} else { /* DUPLEX_HALF */
-		if (tx_pause || rx_pause)
-			hd_fc = true;
-
-		/* As per 802.3 annex 31B, PAUSE frames are only supported
-		 * when the link is configured for full duplex operation.
-		 */
-		tx_pause = false;
-		rx_pause = false;
 	}
 
-	enetc4_set_hd_flow_control(pf, hd_fc);
 	enetc4_set_tx_pause(pf, priv->num_rx_rings, tx_pause);
 	enetc4_set_rx_pause(pf, rx_pause);
 	enetc4_mac_tx_enable(pf);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 6f15f9ea1664..7e886dc49997 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -17,7 +17,6 @@ struct enetc_vf_state {
 };
 
 struct enetc_port_caps {
-	u32 half_duplex:1;
 	int num_vsi;
 	int num_msix;
 	int num_rx_bdr;
-- 
2.34.1


