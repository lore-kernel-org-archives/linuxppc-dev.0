Return-Path: <linuxppc-dev+bounces-23492-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DE7C44500
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 10:43:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gs9N2188rz30BR;
	Fri, 03 Jul 2026 20:43:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783075426;
	cv=pass; b=ZWN5M2Rp0z+ne1NCI/LFuYfE7df97VaHshXeA0xRuPH+bf9x1YkCI/qtonao1c64rO8JE1VS3vae7NAdHyIIpPxd5XCFkn8ju/qiFysP0+J5FBFWuFVCQIghJcLTyGWwhKPQUWZcE+SYU27JTHd+JdxApBbqcN7pAKtNGaXXfQO9leRx/L57fFOuKZxaLw7e7PJ8sx6uKAynzKAWtlJzU/nrGne760+tQ7j5MZ8V75QPPZzKmN+gjwHTMUNmBsftdAxs07L+4ZvtYSNARJ0g3Fgr3GepA8tHtfCjbe2W4u7dvlpiK2TSlWu6ySos5MDtk0m2dRV3HYmi9U7D96eZAg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783075426; c=relaxed/relaxed;
	bh=oBoEMBA52xyOWy09kfLHTJptaBPDJVdB/8FSoUUxFbY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZqBmbDIJiKySkRNgilBq0NrCqgnmgpxuPxI3zcw6sRb62Q+oMPyniUfZ3/TSpFb8Zh6RtXTM7cFIViTDFWo1TWOkwvwRtgebVLKy/8Zeb57cOQNn01k91wfakI6j2Qwi+xOBTYxJU1WKEB4OgNhlFDp+G6KZDAUV+76pW84c92SQmWDEmC9wuSTa+YHO1hme6ida9ycT7Jm75lHVp8h7rSA3xOJLtXEzFnceT1k3WscyyD57/hLtzt+zoHbQgdTVM7WrU4v2iDqUrtff/MQXpV7BgCAcORkuVzV2PLZBcZjHE7sHohE4o6nd7t1rH0sf/7T2L8Pi9H2MEcRolszmyA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=FIv97c/H; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=FIv97c/H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gs9N115Y6z2yjN
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 20:43:45 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DaLC3JPBLHAR5/o8kzRA4302SZeAvEcpel0xHI0X2XddLSle+nnsHvn0ivo3sUwOQZ4aHJLm5MpIPoJkrvzcW3hc0KG4fR9TLAkcdg8RNF8u6kHH/eoWYRD2t56FJnLSph6xrtaRfR3ONGja2T02GyFLSvfFdJo7iVwAoonmo1JoaMbKlsRUAl4O8cMqC86fK+vKjsFJsoYOyW/IJsL67V6+QJneET5vCgC8JumbNCoQdgaycW1x7+t6mnLFBmNMYloO2W9sIRxrUQvmqalbMMuybkuLPMuivr91AWCEnWfcIIgnsNnvs4oukTX+brXFF2f2VJe2MSTFaodnhvg5Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBoEMBA52xyOWy09kfLHTJptaBPDJVdB/8FSoUUxFbY=;
 b=DcpDzSAPIQs1EhQMj0bVrkjHpevFRUmvjmk5YexoqQTXEPshhPTSLTsXoZptaPdqJkKcPgbqTntykS2hH8BUEOukGJ/4JRQErmzx7iR73hbeYSlZwep9ks76Oct5XA8gQFLqzpjySup0eJgTbkTZGhAlHqLPG/9DGlByypwg2iBkAw1lkA+tbQUO/giOrytMnvqjACa25BJ0NnW/q1o0JKpnowisFoGZy1yaq2V4vAl9rM5bqQyVxavitRKH/e3qVqvjmnPJ4vsEhuSEbMA+9e6aiWRoAZrEKg7WYz3QPkbOhvvlODhNDtmqJQbLcE6ieM4WoxRb9EoJvDJogs4URw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBoEMBA52xyOWy09kfLHTJptaBPDJVdB/8FSoUUxFbY=;
 b=FIv97c/HpTqATgpfk8sGNHo6VclQ8soaZbBJJ2g4h/lfnmoGf5q1H0dyaFpYEY/v/pXWsk7+IBM7emO97Jso/4sOQIKWlG8Fv/Ll6BKn5wrjW0aVJ7sw2tx4mbKdvk5PXslYsMIdSCH1gCCGJVtx48OI3+Lql1YdhztbV+5Ela/MVXoXQzT5nXuKkoEAxJLyKYyj/+rtvcNyXwvoAyRCc3Ttw2dkBF3KN1x7oRAdg+T75Ko6r3NRo622mlAEqc2XaSXJL13gXPvK93LMOp9xLco1gzwqOs1ObqigqNZd7flRyJE7Nqpl+z1XoiDA4ayr051bMmG1A0/2+56onvqBuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PA1PR04MB10867.eurprd04.prod.outlook.com (2603:10a6:102:483::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 10:43:20 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 10:43:20 +0000
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
Subject: [PATCH v3 net-next 12/14] net: enetc: remove redundant num_vsi field from enetc_port_caps
Date: Fri,  3 Jul 2026 18:13:26 +0800
Message-Id: <20260703101328.550714-13-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260703101328.550714-1-wei.fang@oss.nxp.com>
References: <20260703101328.550714-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0333.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:222::18) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 468097b6-0e1d-458a-534f-08ded8efe5f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|19092799006|1800799024|366016|921020|56012099006|6133799003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ndbeflwoutruIk46U+0zWifCbA2JlBU+6MRpmrBT8QdvMxuAUV4/F363uUb3G2j9Dv3UAn7skp+WRRGNbJt98ROqzW/GpzssiChjGtkEx6lPLbU0cBUWaQe1R2rCsBYBqdeQuXRDawXJ1B0rFQMYs6OwOr/18tt5HP6ZovIiX/lCNC+sV5VYfwKJyqgjA6ApCWiiOIJWqJ6CqJbEPyoqJmhS9IadFtrIsBBT79T5OnD+vP2ed23jmxuKyocuy/1oUZnGdQL855iochfenrSGeNem922Hx9gkzMEZFE7bd61oGYMBI1bYNCSDRSS7O9bBnhU7Cba3JmMRKcmNgeLjwLNhOi0c6K7kObE1LzVWYbekBvjFNDafS0/TYhcSu6eb2aYDg0wePvkfBe2bkRuD+DZWDOauHVgjuhlCdK8k+bEPd8AYbot2CuJBN4pLckGOcJ/l0tlgD9Gxohqo5Ne1K8MsXYR3jvq9O5iM7qJeae37VvT2prK72exdDQtuhqkZhSFhDTvvvuWVSTBwmxSudE3soJg8LQVlsjBVHLFY6qTNFIr5uTGMEqTT4mbH4BLjfUIGYpwUebjkUmeiqB0DE75bVTCq8npwFcu//efaVBDHgZEo7O28ZpMRf9/LdQvz2T0mTMQImpI5Zvui12JLCYJOKKBP4WGTZTmZMpChOosbOdf0jZR8JCTQP+1hUXWK+57F+6bf1fBk6PpFh8+ORQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(19092799006)(1800799024)(366016)(921020)(56012099006)(6133799003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q1fXgbtVAb6DGjGHgfkUMGMkKW3e1FPFTRqxwY3J9BmaEFpp5gf64il+IqSH?=
 =?us-ascii?Q?GQLjKOC6kzp34FVaHTnZ8Ppdfb2YcGFENYqtGJd/1Li4TazKk6H3u6rr6Woj?=
 =?us-ascii?Q?hrsHOVWBtJCFkyJXEaz9CQUYKL3+ZGZh/Hn3Oi29EDMU05BGoZnxfjR2UqwV?=
 =?us-ascii?Q?7DzudWK+KUsnAi5GA6q6lWzxH1NvCOS0s9C0evfSWJxoIlASaSMs2EMEsGx6?=
 =?us-ascii?Q?laGTb9ugXW5XdecvfLbif9yxjoCYx5WazlVn6LqiRhCtGBkd/Rv1J1zkJ9mA?=
 =?us-ascii?Q?/jXKEoREkU/20qfGGehg1etXIhlQTWqE/WnGKKTPTaY3KmijSl2rOQ9HSsDb?=
 =?us-ascii?Q?JfHerJUMyNQP0TyYRIK/K7nq6qqc2f6mavAIBkUZyjNHdZoH438j3Q7P/NqW?=
 =?us-ascii?Q?L7Dt3+BwOMJZIzMYATzxltuHIRlxjHEQ8ovxoJCzkc0YVedlEbxlFdOhTtnG?=
 =?us-ascii?Q?vB+JktvMsKi0m0NbUvbMF+F6onAO7UA59x+o6LtCRkvk/mjOJoI/pqZQIFxR?=
 =?us-ascii?Q?7pNsUQKVUEI1p1L4w4Er25vT4PIZxd5vVWOgevarLLB5stGpd1IwIs9siOQK?=
 =?us-ascii?Q?zG3uKxaB1rQWwZWk1rpp3/xu/4zaD3YRu59oAHpqD0guFBIBtuG2w5lsOy3j?=
 =?us-ascii?Q?pwGU2+OTmcRIgC5nnMmXsKgm13gxPOoBcm0kCMDoQtZAN2QRTyYj0y99oFLd?=
 =?us-ascii?Q?7XQZdYEbV5vl3+3C52I5YHZpFHkwCe4Ofyruplvx+u3Ssr7+6e119skOL28O?=
 =?us-ascii?Q?q19TFyeqNuRJhGc0apBsHQCq8fbO84zzA8XkTurbpGfHjEYUra+u/oOXadTE?=
 =?us-ascii?Q?IyrlZ60xOdbkxqZhLly9na+g/dvj/1wffu29M8AuYXNx4hTwpl9JngA5jgwE?=
 =?us-ascii?Q?jJBRczmRXypv+Kxp5/iRL9onmpwEO9Ij+m0vg6gqwp6sDusTKgUMTSmnc8Ks?=
 =?us-ascii?Q?VdHU9Gq93LS+yTYVgKbLzKPC4ORq+i0iYCrQMvOzj0TWhVTs2drxYwBmBY3V?=
 =?us-ascii?Q?mx8r4joL2VafoTYB2H23s2XFeO8qh20ioRY9Ez1WrqJjd/E5lTpd7H3Zbnmr?=
 =?us-ascii?Q?BjrBQDgaKxtCZ2vHwSS19FGViuaOf4H07biWlRcZsJZ4iMz04X36UqxQYOkO?=
 =?us-ascii?Q?GVlnWEj7SvwYqX0Y0rylSr/Jt6blNOtSz2YOvko1t0kpH7Bxo7rlc+eEJ7Ja?=
 =?us-ascii?Q?lGRGFKPfqrbYzJIy1LUdfst7ccjk30+37Q1/rQjrbmySPQcU31oAXrH5yyiH?=
 =?us-ascii?Q?QBe0UjEJn0j3/slYvDal6AdsdAvnsqwvL8EPxikVS4Z4oz3hiBRUgV6oG5i4?=
 =?us-ascii?Q?QNOUkh/7PczONozRvAryWywYcp30z3Pllt7RCeLQ2ShNH2V64WNz5KLgj8wO?=
 =?us-ascii?Q?sFv/esL+aEiq2MF4hNNU5K7be5Rd7N8KXVAls6rjE4qcS6k5aFqREhN91HmG?=
 =?us-ascii?Q?JrhDTH3QztI1fxPpR29LAI/o2gH+8mQoTAS26KeJXUF9yW6uyU6T71BGC15q?=
 =?us-ascii?Q?9islWcMRa+04DgZe4YmZUKSEbL+BlfYTWiT03eeBm62Ksyz9YcjPy6cihQM2?=
 =?us-ascii?Q?GXTgfcYTR9DAn3OvbqyMZdn7jp5TpYnEmO3KLMYiRGbuoa/Iyc1cNyVi6BRs?=
 =?us-ascii?Q?V9mPDBukzbeis3XqcrL4Aam6bq8F1S6rOqMHucskzWzzpcoMwMQfrTq877CC?=
 =?us-ascii?Q?4B6BZsnzNbC/hkZi/hVE+XHhouqcubfhUE4ulf7ExrNRUpKRN4nnwU6skR5z?=
 =?us-ascii?Q?/AsuimLY2lPE1fR1FvNyT/5poInafzn1lYiqvFam5sYx1KdM8XrI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 468097b6-0e1d-458a-534f-08ded8efe5f8
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:43:20.1469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OGDD+j1PGYIP8AKh/0uMCH86wPLay0xkYPAd+YAPTMOrtzhqKQu9lbJzunX5qjXR0YN5U/Kob+yrc/1ym6ZpOMPQWyhfNR4RHFCsItIUyo/9UwSYU4L5G+P4QZ4peAj3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10867

From: Wei Fang <wei.fang@nxp.com>

The num_vsi field in struct enetc_port_caps is populated by reading the
NUM_VSI field of the ECAPR1 register, which reports the number of VSIs
supported by the ENETC4 port. When CONFIG_PCI_IOV is enabled, this value
matches the total number of VFs reported by the PCI SR-IOV capability,
which is already stored in pf->total_vfs during probe via
pci_sriov_get_totalvfs(). When CONFIG_PCI_IOV is disabled,
pci_sriov_get_totalvfs() returns 0, but this is benign since
pci_enable_sriov() is also stubbed to return -ENODEV, so no VF can be
created, and enetc4_enable_all_si() only enables the PF SI (PSI).

Since pf->total_vfs already reflects the number of VFs that can actually
be used, and is the established convention in the sibling FSL_ENETC PF
driver, there is no need to read and cache num_vsi separately in the port
capabilities structure. Remove the num_vsi field from enetc_port_caps and
the associated ECAPR1_NUM_VSI macro, and replace all uses of
pf->caps.num_vsi with pf->total_vfs in the ring allocation, MSI-X
configuration, SI enable, and debugfs code paths.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../ethernet/freescale/enetc/enetc4_debugfs.c | 13 +++----
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  1 -
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 39 +++++++++----------
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  1 -
 4 files changed, 24 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
index be378bf8f74d..5029038bf99f 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
@@ -28,17 +28,14 @@ static void enetc_show_si_mac_hash_filter(struct seq_file *s, int i)
 
 static int enetc_mac_filter_show(struct seq_file *s, void *data)
 {
-	struct enetc_si *si = s->private;
-	struct enetc_hw *hw = &si->hw;
+	struct enetc_pf *pf = enetc_si_priv(s->private);
+	struct enetc_hw *hw = &pf->si->hw;
+	int num_si = pf->total_vfs + 1;
 	struct maft_entry_data maft;
 	struct ntmp_user *user;
-	struct enetc_pf *pf;
 	u32 val, entry_id;
-	int i, num_si;
 	int err = 0;
-
-	pf = enetc_si_priv(si);
-	num_si = pf->caps.num_vsi + 1;
+	int i;
 
 	val = enetc_port_rd(hw, ENETC4_PSIPMMR);
 	for (i = 0; i < num_si; i++) {
@@ -52,7 +49,7 @@ static int enetc_mac_filter_show(struct seq_file *s, void *data)
 	for (i = 0; i < num_si; i++)
 		enetc_show_si_mac_hash_filter(s, i);
 
-	user = &si->ntmp_user;
+	user = &pf->si->ntmp_user;
 	rtnl_lock();
 
 	if (bitmap_empty(user->maft_eid_bitmap, user->maft_num_entries))
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index 09025e7a2a3a..4856e0ba4d00 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -50,7 +50,6 @@
 #define  ECAPR1_NUM_MCH			GENMASK(9, 8)
 #define  ECAPR1_NUM_UCH			GENMASK(11, 10)
 #define  ECAPR1_NUM_MSIX		GENMASK(22, 12)
-#define  ECAPR1_NUM_VSI			GENMASK(27, 24)
 #define  ECAPR1_NUM_IPV			BIT(31)
 
 #define ENETC4_ECAPR2			0x8
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index cab79f81d6fe..8d536a3831e3 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -23,7 +23,6 @@ static void enetc4_get_port_caps(struct enetc_pf *pf)
 	u32 val;
 
 	val = enetc_port_rd(hw, ENETC4_ECAPR1);
-	pf->caps.num_vsi = (val & ECAPR1_NUM_VSI) >> 24;
 	pf->caps.num_msix = ((val & ECAPR1_NUM_MSIX) >> 12) + 1;
 
 	val = enetc_port_rd(hw, ENETC4_ECAPR2);
@@ -255,34 +254,35 @@ static void enetc4_default_rings_allocation(struct enetc_pf *pf)
 {
 	struct enetc_hw *hw = &pf->si->hw;
 	u32 num_rx_bdr, num_tx_bdr, val;
+	int num_vfs = pf->total_vfs;
 	u32 vf_tx_bdr, vf_rx_bdr;
 	int i, rx_rem, tx_rem;
 
-	if (pf->caps.num_rx_bdr < ENETC_SI_MAX_RING_NUM + pf->caps.num_vsi)
-		num_rx_bdr = pf->caps.num_rx_bdr - pf->caps.num_vsi;
+	if (pf->caps.num_rx_bdr < ENETC_SI_MAX_RING_NUM + num_vfs)
+		num_rx_bdr = pf->caps.num_rx_bdr - num_vfs;
 	else
 		num_rx_bdr = ENETC_SI_MAX_RING_NUM;
 
-	if (pf->caps.num_tx_bdr < ENETC_SI_MAX_RING_NUM + pf->caps.num_vsi)
-		num_tx_bdr = pf->caps.num_tx_bdr - pf->caps.num_vsi;
+	if (pf->caps.num_tx_bdr < ENETC_SI_MAX_RING_NUM + num_vfs)
+		num_tx_bdr = pf->caps.num_tx_bdr - num_vfs;
 	else
 		num_tx_bdr = ENETC_SI_MAX_RING_NUM;
 
 	val = enetc4_psicfgr0_val_construct(false, num_tx_bdr, num_rx_bdr);
 	enetc_port_wr(hw, ENETC4_PSICFGR0(0), val);
 
-	if (!pf->caps.num_vsi)
+	if (!num_vfs)
 		return;
 
 	num_rx_bdr = pf->caps.num_rx_bdr - num_rx_bdr;
-	rx_rem = num_rx_bdr % pf->caps.num_vsi;
-	num_rx_bdr = num_rx_bdr / pf->caps.num_vsi;
+	rx_rem = num_rx_bdr % num_vfs;
+	num_rx_bdr = num_rx_bdr / num_vfs;
 
 	num_tx_bdr = pf->caps.num_tx_bdr - num_tx_bdr;
-	tx_rem = num_tx_bdr % pf->caps.num_vsi;
-	num_tx_bdr = num_tx_bdr / pf->caps.num_vsi;
+	tx_rem = num_tx_bdr % num_vfs;
+	num_tx_bdr = num_tx_bdr / num_vfs;
 
-	for (i = 0; i < pf->caps.num_vsi; i++) {
+	for (i = 0; i < num_vfs; i++) {
 		vf_tx_bdr = (i < tx_rem) ? num_tx_bdr + 1 : num_tx_bdr;
 		vf_rx_bdr = (i < rx_rem) ? num_rx_bdr + 1 : num_rx_bdr;
 		val = enetc4_psicfgr0_val_construct(true, vf_tx_bdr, vf_rx_bdr);
@@ -299,26 +299,25 @@ static void enetc4_allocate_si_rings(struct enetc_pf *pf)
 static void enetc4_set_si_msix_num(struct enetc_pf *pf)
 {
 	struct enetc_hw *hw = &pf->si->hw;
-	int i, num_msix, total_si;
+	int num_si = pf->total_vfs + 1;
+	int i, num_msix;
 	u32 val;
 
-	total_si = pf->caps.num_vsi + 1;
-
-	num_msix = pf->caps.num_msix / total_si +
-		   pf->caps.num_msix % total_si - 1;
+	num_msix = pf->caps.num_msix / num_si +
+		   pf->caps.num_msix % num_si - 1;
 	val = num_msix & PSICFGR2_NUM_MSIX;
 	enetc_port_wr(hw, ENETC4_PSICFGR2(0), val);
 
-	num_msix = pf->caps.num_msix / total_si - 1;
+	num_msix = pf->caps.num_msix / num_si - 1;
 	val = num_msix & PSICFGR2_NUM_MSIX;
-	for (i = 0; i < pf->caps.num_vsi; i++)
+	for (i = 0; i < pf->total_vfs; i++)
 		enetc_port_wr(hw, ENETC4_PSICFGR2(i + 1), val);
 }
 
 static void enetc4_enable_all_si(struct enetc_pf *pf)
 {
 	struct enetc_hw *hw = &pf->si->hw;
-	int num_si = pf->caps.num_vsi + 1;
+	int num_si = pf->total_vfs + 1;
 	u32 si_bitmap = 0;
 	int i;
 
@@ -339,7 +338,7 @@ static void enetc4_configure_port_si(struct enetc_pf *pf)
 	enetc_port_wr(hw, ENETC4_PSIVLANFMR, PSIVLANFMR_VS);
 
 	/* Enforce VLAN promiscuous mode for all SIs */
-	for (int i = 0; i < pf->caps.num_vsi + 1; i++)
+	for (int i = 0; i < pf->total_vfs + 1; i++)
 		enetc_set_si_vlan_promisc(pf->si, i, true);
 
 	/* Disable SI MAC multicast & unicast promiscuous */
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 1bd3063a3be3..56d23a8a11a0 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -17,7 +17,6 @@ struct enetc_vf_state {
 };
 
 struct enetc_port_caps {
-	int num_vsi;
 	int num_msix;
 	int num_rx_bdr;
 	int num_tx_bdr;
-- 
2.34.1


