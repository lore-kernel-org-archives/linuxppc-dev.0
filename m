Return-Path: <linuxppc-dev+bounces-23172-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA54C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 07:50:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqFfh6nwhz300M;
	Tue, 30 Jun 2026 17:49:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782805788;
	cv=pass; b=dII46BNfg1hyqyU9tOqYZCITx09Vgvt/UK1XZs+mRKr37WXWLh4FnrWzWh8vpjkaqug+3Zl61jbPSJn/AiRUySAt0Zdgm5mfARX5PHfa/Cf1KK2OW201hyhPQLyLP5iWkmEZ+Hm8mVAYZG0kijxlmG+uQ1U3hPS52E4GnltoaOlxUiUdbkReOAECFM7hXhFC53FFx4GykcgsrM3tWi9tR3GRKW1+egRhpKADBcLq120ZfFrRQiJ5EO16Xl9ahr+yrnTUH+SIMFhCIRBrFzPkb15NltM9O0iK27GRCu1lNykYzVUbzFWmoGSFFRB9A938vTzFTcsXr1XwXDJmI3WfqA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782805788; c=relaxed/relaxed;
	bh=ry3dFK71fybVUZimY1nsp69jg29Ugxd+1zZFlEL6aes=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LgANH43Dlydbz7RRi3XJ3m+tlgb0NmZL6MTMt3Ydhoh0bb1VGxSLvDSzztskdR0JAPBA1uLdxKYi9PwaF4R8YDXecIQ9EnG/6bT4REp0sKJshHHLK8AqqFEY7vlfyO2be+Qm6X4poKj238IGVMVJlBxCveMtqZMPZlCMS4hJqCZyODaXrg3AD60RS7ZA61KZJTeYUm5HWtD5SNHeBQKvKWs856Wr6GwiWiB3tUWXuCv5BD0TOaaoFZDcYifqluOx17ZPnQHmzraYo4WdN6lv6x0rR4ZYgAf6wFbbGJs3YmMWu3Km4c/e8Q4g3HT9OQRVM+fsBfwHV6DbShKqIM3njA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=RA2VNf03; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=RA2VNf03;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqFfh06S4z30G2
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 17:49:48 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OdMXKv/C/O+j0khx38TEpPSJfU7MskMvyzf5eoq7Oudk4u+MxHEuhNRMB9uHVLKL6FMEHGCv1hK7pt9dUsmWh6F7e3uWsVRWhH4cNNPKbMaai4856PW6I7JRt9lZKiSp9Jk+q8Ngh/PkK6rGJ5x+tdXT70/nvLlYNEQlSRkMSgmWGapqlYeKSdkjK1KyieHuxZ1KkFGOrEaFr3TFz5j6clIueVxGseMZ6fgZ9I6lGTnlKZaZwOTWGa7bGVENkKqQ3p5PXNAICUhzjV1hWQyb/tWbedzyxiOfplJ45wvr/YtkaGOALWFNP0RwO7pm4kU1RX362c7/Y8odTUK9QBHbMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ry3dFK71fybVUZimY1nsp69jg29Ugxd+1zZFlEL6aes=;
 b=HKsDPeUC9Xk5BFuGsOsovsdvvYmvHzydnat3+IMPY26v885UC/KSYVI9Z+e6eDdVegDcnzQMs6zC6NMSD2k21iC/DHQVhURgSgGd3MxSsV+hDQvoializLMZNMiSTVnTGHczXPWR5oraYkAWcVFndixjrhV+MvQhHiGhY2ninV4+8PmEv2ZdUgnE/XucVJiqoReNIRQT3CTs7KrIDDgx7x/AUX+LgK6zg4VijvpD82iqVYvqOC2b+/B63kWz019zaoDZcCDTntULE/tWnk90YY6GLYrGcsZ2RFzqQiXqDR5gU/Q0VYa658JQCCSQ9TNbto0qPFOUlU8uuXnRp0pZeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ry3dFK71fybVUZimY1nsp69jg29Ugxd+1zZFlEL6aes=;
 b=RA2VNf03yRKC8WBPiyp4qNPMa8HiZS+Wp2XGx2Bnhza/PZmRfuc7lDtXDrzoVNcFI8K4iTCBXMNYjl2rYA7cG92cLUM8pde0VgCY6SzEDnS5kuzA0AftEaEZMQ3r8l0ZdnVvxvMzxAVDVzF6s3o0FhVF7JdQfnQTOSonm2aBBYgFOifmY5bsOIuTEi1Q1Mi4IL+kxaY28GI9GdOjJJyHsaLundSVa2nNPLe6CjR3oehWeb7Tw6soksYrtYwSZrrLQpvj3rnaSj/iohyu4lCP8AssBUMJrfprnxfXXXFNOfyFuT/Mu3rtAgRF6jsX5qCwHODny+1cWxdN0o7OYsTLwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DU0PR04MB9561.eurprd04.prod.outlook.com (2603:10a6:10:312::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 07:49:36 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 07:49:36 +0000
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
	chleroy@kernel.org
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 10/14] net: enetc: refactor SI VLAN promiscuous mode configuration
Date: Tue, 30 Jun 2026 15:20:32 +0800
Message-Id: <20260630072036.382761-11-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630072036.382761-1-wei.fang@oss.nxp.com>
References: <20260630072036.382761-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0196.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::23) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DU0PR04MB9561:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a6be60b-6254-4746-8f17-08ded67c21ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|23010399003|19092799006|1800799024|22082099003|18002099003|11063799006|5023799004|56012099006|921020|6133799003;
X-Microsoft-Antispam-Message-Info:
	VCyjj8F7PK0K9dNZBfg9qpm/4OR72tMaLLaVVIAy5AaQuGXvENXjbOIKdsej10Re1jz2qsTkMWwJLUIfRyGbWYgmtYP5Jer005fA3SSr2mxIajD7HcAT6QWll1/Y2+4NarX+r6N3rHcyUJvveZFR7wQmPW/4QyBMcNxtYCh6O0jQzgja9wZsT2QlkuxSumON83cNPvFksnvy6GLPFy+SWoAZZotIJPxW0mE7ezAnX+BoWy9oQvBtv2+R+XMM5JjKUUUmmEtKMEHX5PELZCK7YYUiEaY8i6QpdI3oMvRRw+WOOPrz8zwwJTClxkoCFyqKF58pxtIJks1jhu4uwM92jv4/wzyYOLmKD00Ab5euU01N3wBHReoFpKKrKlJKOnvcFPw2rBn+nx48hlD8eoW8WaaxD+yI/H2sKnIQjItLKrj1Am+8wlqf58M6gpQylu6Spm1pz1TyJOWXC2r7pPU+89IsBEMSdWTBKwpZi6oeX9KbT4a2q7FRD7O6yycsAF13OB6y25X19HsU9Ds9wcLAWCCRQO4bQP2KSY5tk18zJ33YvVjiD5ijMzoFiyiv8wU3BIbVwtMs4dq0qm72tOs/1BIx6nj3i4zmWvlfP5T6SHODPLiUtnXad4UMlPjOUsQuFx94fTpnwHuWP53xsK+1CphAFXFyTQv0WkKhFnf0kD/YoVGvNYO1irh3jamQa4tIF/62XZa+XQaFuJzIYJLaLw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(23010399003)(19092799006)(1800799024)(22082099003)(18002099003)(11063799006)(5023799004)(56012099006)(921020)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vUpvc1ZDCppoguZBQhcFCeRfpRFnmrT7nsRSMiC6owrd94J1S4q2WbZuLhjR?=
 =?us-ascii?Q?s4xPUwGJl/pyY4+RUKORttCBUWQ7hQjgZwyqpGW8cIHNCPwel5EL4golHRcg?=
 =?us-ascii?Q?Mw+IqlRhs4ZLfEKdK+DoxU2lUjD8q6qDR0l3IAU91zfT/6uthn6Hhe5cOeqZ?=
 =?us-ascii?Q?C1JDsL5Pnl93ujhTNo581qfuEn579n8w6FanfMnIOeRfQuagbsSk2lY06fud?=
 =?us-ascii?Q?1TtL9ZLAZ/0zHs3UEnZO+LeegetjwUYeZa+/MowrZQkECQbMZQNXuJywj2D1?=
 =?us-ascii?Q?cWPKCJrSzyyXZpSzRq1PqlTB+i/jC5zMthDmaU4keGt0DYeIvh6VcM/mhHAw?=
 =?us-ascii?Q?BEES3yPRbxBctpSgaWJdk7O7HnmO5+eYitNu4sylhlva/ht/WIDFB3qo1PTy?=
 =?us-ascii?Q?4ailKEOIF58fRQzlhFH96frozNwX7RgIhUfHeRvbvPMhRg7MYgnCJIQYqLsN?=
 =?us-ascii?Q?sCCpNtSTKpAc1bwxj3RrwX8ubetfgebiL2rKzahZCj53xzqex5FeOADM5tUi?=
 =?us-ascii?Q?SSvsCGz/m85sFaXW07qzLhMCYaSvb1UsGdGbOHU0pGLgd/6k8NQ8WHtJOJWZ?=
 =?us-ascii?Q?XOBANrN/UszfG0GSO803Sia5kTnCSG3SdZoazlVi6gO0vPqb0D3rYlm5v7nq?=
 =?us-ascii?Q?uB8qC56Cy8eGrIm5yOecdVjIAw/1ZJ6ZFizSADCdQvGtMuUk6JETl9MOd3it?=
 =?us-ascii?Q?Ip2K1lgywDrX2FmWbVG1r9X7eO9y48cRwEawzKgrSX3dJfBbZ36+CCowJVKl?=
 =?us-ascii?Q?8Rut8jt7aiO8CR3PJh4IVgRawyGJyqf8UNczzDFdfMgmgtfe5/nAxGT7Ti47?=
 =?us-ascii?Q?CrxCrFhamGq5Xkw0pjR1ZMx6z20oogGUKotGklaIytYXq5VcKgYKYSxMRwgJ?=
 =?us-ascii?Q?hTY8cOa2CuTGNT3iU8l6Gc+o7YG3wNzoV+6WzpS3e3ZPX0DTmmcm1ZDFxsVn?=
 =?us-ascii?Q?qhC9nqYdHzePTJh59sIjH+6NfBhWaCETM+CF5sg5PKoN8/3lGBW8Hq9+RAFz?=
 =?us-ascii?Q?rG2t/yi8hZLC/1wRR6TTvF8Ta9/5dJDcvF4hq/UwCiGZiV4F9ySIff0EL44b?=
 =?us-ascii?Q?ccGLDQWjPdAzCR+akB0Kj7xFy/OVvQwPvDPDcOcTtLkl/1vW67QbEgzZUggJ?=
 =?us-ascii?Q?T6N6iHMlniQvsPHxgxUdcMUPO+sO1p22f3utyvTMW4/FIgry92VqcQhGHxSk?=
 =?us-ascii?Q?GUVbQyI3gJVym1xPfrUdTdXFC8P1/FF8agFwgdX1/BnsjTk1CLpeu5Z0cyFW?=
 =?us-ascii?Q?D8rgqtrq2phpObM4pzuiYQenolQ6HfS/Ga30wJH9Tgq37nsnPMf+Uqs4j5GT?=
 =?us-ascii?Q?IgNeJlSnb/2YZuPvil/PwI/GywJwUo4jHIDH2i82GGuIgHPGly4tYBBirepX?=
 =?us-ascii?Q?hAaFcBFyHd6I/P/fCt731NtCg6DiWPSI2uZl3shAzDeESCpa2geWPA7hM5rv?=
 =?us-ascii?Q?IioFiYrItMKOznvOSBqM/MFoXNCJC1wpIHfSQ9H5zGZ/FrMfg6933VtxaVQY?=
 =?us-ascii?Q?XW/d17ADBsOH6gb5cqXrK1h1GgnFMvD3pZHG9F3ViQkI0iFLf4RQJKX4ykbu?=
 =?us-ascii?Q?d2okWhvEIhYvXDOp8J2IvLaWH7QSeQ+BwD3kDVxoeYtucNDcrO9tETZUlBQ+?=
 =?us-ascii?Q?uD6klXqEh6vFSg7TdAHqWQzs8VJIKOiEKZjrUx6JDJshvd5dwDpedsahlPBx?=
 =?us-ascii?Q?nVIzZVf9q8KjcjW5TOoL6lNlK+EBbzl6YohEP22lluf4Z9IVCi5OxHuFmKOO?=
 =?us-ascii?Q?Jn31WMkufeUtDQNayun8eGMJa+hJ3WgJsjn6q+iLppCYuou2U7pF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a6be60b-6254-4746-8f17-08ded67c21ac
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 07:49:36.3696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I27MAOMyQZHRrvvUnizTmJ8qyWKnKYjKU+yXPwUE15Cx0wiIJLaKithHh21FCzEx5xzsrnxzAmlL9ZGqCc5CWziyJ/i7YgdCnNGEdPHNTFZhGx6b0o9YM3qhZpXogiL9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9561

From: Wei Fang <wei.fang@nxp.com>

Since a PCI FLR (Function Level Reset) is performed during probe, and
the hardware enables VLAN promiscuous mode for all SIs by default after
reset, there is no need to explicitly set it in enetc_configure_port().
Remove the redundant initialization of vlan_promisc_simap and the call
to enetc_set_vlan_promisc() from enetc_configure_port().

Remove the enetc_set_vlan_promisc(), enetc_enable_si_vlan_promisc() and
enetc_disable_si_vlan_promisc() functions, and introduce a new unified
function enetc_set_si_vlan_promisc() to enable or disable VLAN
promiscuous mode for a specific SI. This simplifies the logic and makes
the interface more straightforward.

As ENETC V4 only changes the address offset of PSIPVMR register compared
to V1 without any functional difference, enetc_set_si_vlan_promisc() can
be moved to enetc_pf_common.c in the future with minor adjustments to be
reused by the ENETC V4 driver

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  5 ++-
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 35 +++++++------------
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  1 -
 3 files changed, 14 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 66bfda60da9c..16da732dc5de 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -185,9 +185,8 @@ enum enetc_bdr_type {TX, RX};
 #define  PSIPMMR_SI_MAC_MP(n)	BIT((n) + 16)
 
 #define ENETC_PSIPVMR		0x001c
-#define ENETC_VLAN_PROMISC_MAP_ALL	0x7
-#define ENETC_PSIPVMR_SET_VP(simap)	((simap) & 0x7)
-#define ENETC_PSIPVMR_SET_VUTA(simap)	(((simap) & 0x7) << 16)
+#define  PSIPVMR_SI_VLAN_P(n)	BIT(n) /* n = SI index */
+
 #define ENETC_PSIPMAR0(n)	(0x0100 + (n) * 0x8) /* n = SI index */
 #define ENETC_PSIPMAR1(n)	(0x0104 + (n) * 0x8)
 #define ENETC_PVCLCTR		0x0208
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index db2a800a7aaf..096ccb35508c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -42,24 +42,20 @@ static void enetc_pf_destroy_pcs(struct phylink_pcs *pcs)
 	lynx_pcs_destroy(pcs);
 }
 
-static void enetc_set_vlan_promisc(struct enetc_hw *hw, char si_map)
+static void enetc_set_si_vlan_promisc(struct enetc_si *si, int si_id,
+				      bool promisc)
 {
-	u32 val = enetc_port_rd(hw, ENETC_PSIPVMR);
+	struct enetc_hw *hw = &si->hw;
+	u32 val;
 
-	val &= ~ENETC_PSIPVMR_SET_VP(ENETC_VLAN_PROMISC_MAP_ALL);
-	enetc_port_wr(hw, ENETC_PSIPVMR, ENETC_PSIPVMR_SET_VP(si_map) | val);
-}
+	val = enetc_port_rd(hw, ENETC_PSIPVMR);
 
-static void enetc_enable_si_vlan_promisc(struct enetc_pf *pf, int si_idx)
-{
-	pf->vlan_promisc_simap |= BIT(si_idx);
-	enetc_set_vlan_promisc(&pf->si->hw, pf->vlan_promisc_simap);
-}
+	if (promisc)
+		val |= PSIPVMR_SI_VLAN_P(si_id);
+	else
+		val &= ~PSIPVMR_SI_VLAN_P(si_id);
 
-static void enetc_disable_si_vlan_promisc(struct enetc_pf *pf, int si_idx)
-{
-	pf->vlan_promisc_simap &= ~BIT(si_idx);
-	enetc_set_vlan_promisc(&pf->si->hw, pf->vlan_promisc_simap);
+	enetc_port_wr(hw, ENETC_PSIPVMR, val);
 }
 
 static void enetc_set_isol_vlan(struct enetc_hw *hw, int si, u16 vlan, u8 qos)
@@ -442,10 +438,6 @@ static void enetc_configure_port(struct enetc_pf *pf)
 	/* split up RFS entries */
 	enetc_port_assign_rfs_entries(pf->si);
 
-	/* enforce VLAN promisc mode for all SIs */
-	pf->vlan_promisc_simap = ENETC_VLAN_PROMISC_MAP_ALL;
-	enetc_set_vlan_promisc(hw, pf->vlan_promisc_simap);
-
 	enetc_port_wr(hw, ENETC_PSIPMMR, 0);
 
 	/* enable port */
@@ -466,12 +458,9 @@ static int enetc_pf_set_features(struct net_device *ndev,
 	}
 
 	if (changed & NETIF_F_HW_VLAN_CTAG_FILTER) {
-		struct enetc_pf *pf = enetc_si_priv(priv->si);
+		bool promisc = !(features & NETIF_F_HW_VLAN_CTAG_FILTER);
 
-		if (!!(features & NETIF_F_HW_VLAN_CTAG_FILTER))
-			enetc_disable_si_vlan_promisc(pf, 0);
-		else
-			enetc_enable_si_vlan_promisc(pf, 0);
+		enetc_set_si_vlan_promisc(priv->si, 0, promisc);
 	}
 
 	if (changed & NETIF_F_LOOPBACK)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 6f15f9ea1664..574ab4e76d8b 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -46,7 +46,6 @@ struct enetc_pf {
 	struct work_struct msg_task;
 	char msg_int_name[ENETC_INT_NAME_MAX];
 
-	char vlan_promisc_simap; /* bitmap of SIs in VLAN promisc mode */
 	DECLARE_BITMAP(vlan_ht_filter, ENETC_VLAN_HT_SIZE);
 	DECLARE_BITMAP(active_vlans, VLAN_N_VID);
 
-- 
2.34.1


