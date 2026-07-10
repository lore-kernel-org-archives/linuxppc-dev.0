Return-Path: <linuxppc-dev+bounces-24033-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8481C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2026 22:23:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxmYz6MZMz2xSb;
	Sat, 11 Jul 2026 08:23:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783681830;
	cv=pass; b=PSbcWF0DfgMtzXdsKiTiq/vThhjYHxJNL+58eoD3idmzIKgP2nlDRUHBghcMLWbKIV7ujChW8YjfmCzdB6HLIrbg6yHEYef0+wAML1haXVtjVMW+kUQsf3IsD9PrATuRrzTTydtmu7VrOIc9NCDwPNtttbm9wOThLfeVr4jBgbx66dtUM4r5CKS4eNu0/Mqh/O0WA4pvnqNpIqEXuv+tYEtBf475I4bS57Wu+RG0HSpZPa3pp9ST7rDWix0eDhZYFnRuf/cjZrWZhSSAu4afc4YXML3NJlUMhhA1cF0EZLfG2zBLQhEdPK7SkSZS2ftKQUzoYQPJjy5D3egKop6ssw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783681830; c=relaxed/relaxed;
	bh=DSiyO3wCswE4NK+XWgixjCcEme/lwzxsKobOLifhdH4=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Y/kHZIlGkZTPn5SjfxDiXuKAt4zRoYYfSVGefCnZL1b74WH+x4U3TtiGu4RKaQP2Xg8N35oVM8E1qyjPo0ZRyp2GUvXV27LbaeE0sIBHWH7QaCLN+LcZtBA0ukD51gPItNFs2pWvsiq86uQ4tqEtHsJTaGir8OaPqVe1/LcGUkPcEtNzzkn1W6NtonUbJg2gUrn3wT0hi4K7MmSrnrRO5Uoe2CZcBmsDPZrrgMKqdScnbbQBJ4gWiebroGN84aVhCBztZMOuBaAuGXDqnzeFLJRfA9oxm+9BpjYsiYuIVmRFHnU8o4PwBvSfMbSlfehdT+mmwRyhG/oZzAijJ4nPfQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=ivIZaCqi; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=panchuang@vivo.com; receiver=lists.ozlabs.org) smtp.mailfrom=vivo.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=ivIZaCqi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:c405::5; helo=typpr03cu001.outbound.protection.outlook.com; envelope-from=panchuang@vivo.com; receiver=lists.ozlabs.org)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxTdb3c9Hz2yRF
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 21:10:26 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DrcFgd7qw1osXgwD4wrpiC6LqfIB8wQ9odAgeTa40+xeZ05xMDSw6/BkPh+yaUgC1qIpOh9d0nccKxkP+ViHI/BsrdaR4TJ55Zzc4ILtORMeIwWZc8doKJo9LWTlwVeUrHTk+ZpZp2KzQfEzCBbRH+FiEHX4AUaaKv9LXiwnJ/MxTo5k+W9m9A/lOksv8E05eTZ649NGtyzWT3JnXHNJOo+t7XJSpag91agfikiIOFKHUY+YUQYWEgJG4ufFRFsTmgozrfPxgLKLngjsLNdT5RmTH2q1/S3yxzCa5TJiZrhUwT8gzFeJ+MAVT0VamKiVEPRSYG5f6VkfzJKljWf1Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSiyO3wCswE4NK+XWgixjCcEme/lwzxsKobOLifhdH4=;
 b=IXAteWsDAltW9zWRwQ3OEqTV2+ReXYwJNq9Ucw2OVlYzNsLg8fWA5SBfGdmL/dR47XzPIiuk9bJBq4/T4R+doLwOIH2j3abNrNZ4mPWwpZB8nbisvqU6Km7M7XBixuqSmX6cwHh8J+B68XyfXdnyotBhK1ZXP7inxvZoJxagShoMS6/8jto38yOsye90d2nddRGlCsrBLoFD8sipA3eE6h9imgYJ0/RvpwJZUkbG0zdmU5D/LKspGnv0lV96iG0AzoGFFGJZdR1ALA0KFQ8E/wXbluGMhQeJ7ISqyktGDo0UJ8UOIOO64mxQS8AwGXdL9aOeaCctWVvioFNMn8QEVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSiyO3wCswE4NK+XWgixjCcEme/lwzxsKobOLifhdH4=;
 b=ivIZaCqig4a6pX/6vYbjXM/qs/n413FS6lQjOTK2OOiZkUCMgYulCMhFVglExTim8OB8iP1yddMIXA7dK/wbZkxTutzpX8tnXrU5PvLXBKxeKRSghiOim0H6DjAesOZJQKHe7hvTVUaSW7/9ua+6dQdT2FTbRPGabnhS1MOJjX/FG0KmVUD1pWbm1b2weH88E0kjyMdRUYhtDGXzL5Fg+oLAwvoNO6++d3Lk3MbEx/1fmOykcXXqJQ936Ob/xTG3DScfJz14s8JL3Hztln/u92wt0KFg5+EPRE0ZNrEJQhdAODgJc9NRj7526R5uv54CsXbHgOgGVvBSzQV7Llz64g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SETPR06MB9021.apcprd06.prod.outlook.com (2603:1096:101:317::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 11:10:03 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 11:10:02 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Kees Cook <kees@kernel.org>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Pan Chuang <panchuang@vivo.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org (open list:QORIQ DPAA2 FSL-MC BUS DRIVER),
	linux-kernel@vger.kernel.org (open list:QORIQ DPAA2 FSL-MC BUS DRIVER),
	linux-omap@vger.kernel.org (open list:OMAP2+ SUPPORT),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner sunXi SoC support),
	linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi SoC support)
Subject: [PATCH 0/2] bus: Remove redundant error messages on IRQ request failure
Date: Fri, 10 Jul 2026 19:09:25 +0800
Message-Id: <20260710110930.462109-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0005.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:2::8)
 To SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SETPR06MB9021:EE_
X-MS-Office365-Filtering-Correlation-Id: d8b4a032-1cb9-4ee8-2f51-08dede73c9e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|23010399003|18002099003|11063799006|6133799003|56012099006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	xMOzqqjq7gXmUP2XJRysOhf6mgtaKcif18hdKJundxZ+mzGI4180/W+NP+CzQFoL6wCL3fWsIvuJKhE85CNoZJNTZosPwTdU70aI1zbN35GrF1eclF+m3nV0DysEZPaBk8JJSwCsmaNQ/ghACez0TylzY+BpIGZIjhmY30svKqVzQNwu6vnofvAG116MyBp99bzC6MBlnwA44Ucsh0nS3L4EztcvHXQSs6coG9zNWzPXb4PseOGovbgcUlzdy+X7mpbdQDa5ad0L08EvZMh8xBemsj7QFRCoqQJtMy5RSOMU06+SWorm24swkO8JHWSGQEuNuTOuxiDJkzVeRzEIr/7CH9S1YBIZ2M+7vqRUkEiPUpwjjNEKn2owe6I286Jxb9Epb8B9Cejt1axRVVQVu3J6M/5Q9aNdbsQu7f4EhXxMSffUIaIAcrk52oVLXPd+nlJ5Qs4ZtbqElqs9wGyqeSQI4AqwNJETJX2CqK+vrff4egiypsMuGLPf+bw2i+g78wQOFQFZmDGQXDWCfeSdO44v4JONLlrW8WNQU74RSAYTZNoCiuS+7M0phNxo5pjzyuC4MuTNo/9Qq5YmtmytyNSoC7qDUnSQcosx9DKvnTFM089RprTovKeWe+UEkN8D3pcqtNnoiXUMnboRi+uLeoZJlUSzMSndZNQoV2uWbBJeSyrROoehdWZrg2csEraerXPQIquDujUV6DfpIdix5BmbK5p9twziPEcBZ+lTjLQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(23010399003)(18002099003)(11063799006)(6133799003)(56012099006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?exDnPN8dTNsRRCW1C3rEGatOrxylkWxoKilwRNljwQsAT95a0Q8H2ukLa7U/?=
 =?us-ascii?Q?Ae/6h+L4gBqdpmkULeXiuUEdH5+xf39Cx4hkjey/tqI7niVWcssgLiL08GPS?=
 =?us-ascii?Q?HKUoiUMG2/uT7YVefbwCsUMQEuTQLjuLErdfx4RkC+eWj1xEENjjJ+vD82zs?=
 =?us-ascii?Q?p3n2NNRs+q1av0dM5TBE/nCk76gZSWoLf9BMc65cNVM0RmjlwtS69ze+DRY8?=
 =?us-ascii?Q?t1EsOM04+o4iRdR2tFPoX+q4TJ6HaZ9cHJATdFws05Uhh3YTXmFCv4miI44E?=
 =?us-ascii?Q?a1X/rULGz+Y1Mj6Ehtcv6AzoBZVLhk+GY8LC50PjCrZvxi7AIioAMHJyFvHc?=
 =?us-ascii?Q?SSJIv3laJIOv6ZNP6xIKahF1Y+zsDrFhKbWVeGAhfL8e0Y+1MmDnY5ldD3Jt?=
 =?us-ascii?Q?G9dkLYBDnzdO2EJthelGoIihYmlw+IdxMSahbpTV41IKDTAPY05X2ZLE6CJi?=
 =?us-ascii?Q?NT7v1pBgMZy4XuCFTSrLR0ZOOKGI5j/aW6kcMl7JwAJzWjuHznn79M0p37Bz?=
 =?us-ascii?Q?s9OLKUzAb0VsVaURrRsrloVhHkWszXoO6BX2zolKk4kJpYC/Z9n0TbJTuI2U?=
 =?us-ascii?Q?Mm1zWrU89GtKDlllwYyaDuPXlMGImn4w4yy9A0duhnY9ctM1CGFcmFKlAK0L?=
 =?us-ascii?Q?vHK/UwPmwCMnAq6OCFhwS1CJMD7pwVNkznXsIh22uFpw7EFw1u3xIWnaAqwf?=
 =?us-ascii?Q?w/OkfeOKa3jFGYb43bRzqkpEEaW/kTZ+P2dq+5zRdf7S/nSFqySoCtwSlUSA?=
 =?us-ascii?Q?opLzHrlpnSzic6e7Y2GCbe24/5qU5Ai/qd7DidGKyfsL7eHcWan70ZYQDX3g?=
 =?us-ascii?Q?B0S4+0tQNXfWXF9DijNsBXReyEjTptMOBE1e6AQucZu3YyJ1CwWCigjkzQX5?=
 =?us-ascii?Q?UTUIF/9I0bRGj2vBRtSzLoeCpOk+jhdDDo5qx+4kJrIKUTgyAxJ8Y5cUHMHH?=
 =?us-ascii?Q?BPoO1jVuVzee3YoFbvAVUMRvnch1z0T08XKn0mv5JEFdqwLExGFgVOIZysMg?=
 =?us-ascii?Q?EYPlN+jluxO7BInCpi0P5HGNkp41DDxq2HSlthuVBvRMoPMKF4fqfjrFSbSF?=
 =?us-ascii?Q?Iz4ei8ihhMjM284tPIKRN/lp5hJsaw1hpPvft55JlU5W4EoG8V39cYQsvolF?=
 =?us-ascii?Q?H1WamyYYFVfqNdhB5s5gN5KJCNw7ScDSsXWeeoetwU+ImyUpsCDlFh5U5+jH?=
 =?us-ascii?Q?7OnW73/+RvxnDYCWNcyUE85E8rGHeSaQv+pWkAiVtseMqnoJxm+dzUyf8iHr?=
 =?us-ascii?Q?A6BxZEUq8+0425Xi+aM6+VDQjGGCIpfqvkNLpn4IbFksK+mOXEqJeh4Zv/Ba?=
 =?us-ascii?Q?F0IxN0EYUKaCzKyQYMB+Q3NYEYuNXq5OmnKcRHY7lslmhuv7SAZrShnAUEsu?=
 =?us-ascii?Q?aUGyBY6hlkQs/0f4+H4oxubaVE7amMyBHKxRV6qaNeT0Y6XdCNM6XcBkxVHG?=
 =?us-ascii?Q?Qz8IFqgfjWp5pMuhEB8SfQA+/GiUK944F6KscfDuEMD9/vbfvUfG6AzslSFW?=
 =?us-ascii?Q?Kbjv+Ui+TtQC3lArE/unlinq99l1zLefoF44oc1uc5OP68a9ghg3aoQkGF05?=
 =?us-ascii?Q?Mn2TCE+75wW0Gqyky/x1UTlPaKjizZqGHKQzE7H+igxQ6wQejlN8r3vr8uNr?=
 =?us-ascii?Q?0S7OoHCFMWZ85KocWRWErmf7No1Dr2NsY0Xj5gvL88Rw48FX5c7Y+K1ITVg3?=
 =?us-ascii?Q?q6lvVMEupzVXo4e1bFhaw5fm8G77Ka0/KBMqoigEtDlbnnmV4nS2LCgQKj9b?=
 =?us-ascii?Q?u+W/y10m4g=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b4a032-1cb9-4ee8-2f51-08dede73c9e9
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 11:10:02.6577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PlmgvNNtbIl0HchZMszr9fQww4mL110wPjRiXyhezkv+D2IGjcb5nMvW573jIBNFVSqPQWC+ZAZTs8257rbcRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SETPR06MB9021

Commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()") added automatic error logging to
devm_request_threaded_irq() and devm_request_any_context_irq()
via the new devm_request_result() helper, which prints device
name, IRQ number, handler functions, and error code on failure.

Since devm_request_irq() is a static inline wrapper around
devm_request_threaded_irq(), it also benefits from this
automatic logging.

Remove the now-redundant dev_err() and dev_err_probe() calls
in bus drivers that follow these devm_request_*_irq()
functions, as the core now provides more detailed diagnostic
information on failure.

Pan Chuang (2):
  bus: fsl-mc: Remove redundant dev_err()
  bus: Remove redundant dev_err()/dev_err_probe()

 drivers/bus/fsl-mc/dprc-driver.c | 6 +-----
 drivers/bus/omap_l3_noc.c        | 7 +------
 drivers/bus/sunxi-rsb.c          | 3 +--
 3 files changed, 3 insertions(+), 13 deletions(-)

-- 
2.34.1


