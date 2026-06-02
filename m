Return-Path: <linuxppc-dev+bounces-21849-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB27CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 07:21:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV2Ln1RCsz3bpM;
	Tue, 02 Jun 2026 17:21:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780384881;
	cv=pass; b=mc/OLc8Ene+4zv0zyO5tENldzFAfV0mUjywGDfReWOQdnavXATsx5Bb2hhlx2SWh9XN2MWQFZwCG1mtE65tlU50aZ3pC0Ou5Q4N0vKQJsE/Hknn8a44q2ykP2WvNX+KQ9c0diUi9G9LF/Mhv8lu8BYUMyUpJecX3A4YeJvFl+tezc6yy3bNGK56Ye++Z84/8E+R1G10djDfrYMiN6tIt6Jowz4DYx5T0r844pWrvf4R+wKCVbUUGrPvyMy16Uec23IBvpDFI4wDdZ6dZjPaN/sek1Ch9waR4IzfYaRyto8CC/At1+C1ZEesqZbjnWF+xFQM1O2tTXYG1yyAKM+eSlg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780384881; c=relaxed/relaxed;
	bh=9IVC8fyJOuX2uPMFMpA/E1gP+26TYlKP6X7P/QKaEpg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l1DIdmtzG25Js7iHC9yJhlzhQtD4CMA1CbwtydUuXeZqQ/EclbGISglJOZk/PRR0RxZ/VNmVoBXkmOhZYou17wAH+Ok+WGWS1QnxxgqbVEJgxn6BV/M5MtBG4yNTehNyDxHg+bKf6700sCZMr7jBufx6tHamXzmKZMMEClWF3XgwmxAKILEpq7DaoXbWSgHb3h5r87Dxgv/mVNm6PRzfCUCUa7Mn443DEmanltO75nk4ZmzP4WPoRyndC/1lspwUlbAdgGQsnH6jhmNuH1ulFIa37nl3Mrp+SdQcqyDc7FpoRIMKCA5v4fo+UzTWS7+EFdFzUq5hQSo+pI85rYB5KA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ce9trP8W; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ce9trP8W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV2Ll4CFMz3bp7
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 17:21:19 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWDY37D8rQkvVFnnCgPAdZdzCo5OA4YlAEpdPfFcSGDF6nS7tMWId7TXylOqo1hsZlwcN+4nD+d9O/ab09fRcEu+qRMdVtF0CgFSPaztIvSkDQxbRy046NRScld4H6datam/QS+qpng2EQf6xRII7n6MLsl8TmvuaVqgHmWuItmAZeDUeyRHDekJNNke5joLFF9H++fwUqBr+JO7yhXN9kytKLRrrPlEt7ohNZbydInqN46dNtEgB6Hep4LElLD9pIyQBi8SJoGA1GPyUCCdhFGSiHxtEdYh/B5esCs/ccdF7DwIf6RVUoqNMm3hyAwJW8fajBNaWRDdBwIFRU7cDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IVC8fyJOuX2uPMFMpA/E1gP+26TYlKP6X7P/QKaEpg=;
 b=sNJspc1pIC9/75ctT2Id5E/hzl3E73OPsGyHpoDH13p1LeCFRqs998rX0LPO5X12uBuhaqtDa58NER4m1tEdiHEDneJY4kX5tan2jdwt8S8BnwsZDN8iftGYStf70Hs5iHS70pdMmNs7D3mhx8KKx7oQDMh8k8BaWz3VkVV6lxB0bckcTO1it+V0HK6Hw4W80CU52Q+ub0D77PPH9kgnBInlGhrLzb9M0GjPyz8iVl6Dbo5lxolfma6xDUlAj+MLwzx/s2q0rO93YOwT26Bza4wO6ApSaDjAEeiD/NmOrIG7q5yYYSeVX4NtbRzgpTuK+CEbMr9mAshU2wAHcD3SaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IVC8fyJOuX2uPMFMpA/E1gP+26TYlKP6X7P/QKaEpg=;
 b=ce9trP8WeDxM+SYFO1eri+eL34WRvkKhJP3aqscbct4/T60Cn/wXGhQwNNHjjoXlb7qIC/FYsKHu62XZmSoyLyFnCiT5wTPmCKhQpW7OkTIATH0IkQQt0DSMQaOhQQac3mqRKMvr+BBa84EVsFDPO9SaqFsnE6PaN6wfBXMmXqf8yWB9r8tZwQo7Snh7vtmUN4SCtS7WGO3hEdGvQeZGfLcmrSEV7c4Z9bXJMnpSSK8JuUVK/bMhu/oes76sFgPl1WrXwoNSiMcuFk4o7COZYkUC4PWjSLYzCQ1ssZc8J3Xr//bWZOkhy2rYTuIAfv3lhdeAf1NMzNWiVk76g6DMzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AM9PR04MB7684.eurprd04.prod.outlook.com (2603:10a6:20b:287::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 07:20:56 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 07:20:56 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	chleroy@kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 net-next 7/9] net: dsa: netc: add VLAN filter table and egress treatment management
Date: Tue,  2 Jun 2026 15:23:11 +0800
Message-Id: <20260602072313.3162120-8-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260602072313.3162120-1-wei.fang@oss.nxp.com>
References: <20260602072313.3162120-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0016.APCP153.PROD.OUTLOOK.COM (2603:1096::26) To
 VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AM9PR04MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: a0b3f36a-8fcd-46e8-3a87-08dec0777cdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|19092799006|376014|921020|6133799003|3023799007|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AUNdAZfz3uRcFHvgFOgK6FJ0/JzsRfPBXpA9NcMeHeLKJ0RS9Xqp+IVt1XWWmPFCAfgkdhglEGvmJaxmjtnOF+IrfdTogd6bHKT+w90CC4v2pCw5e6mP5ibTUiNNSzMq3oTUtQxyu9qc4z6/VOTQWE2jEjCBUTLlIslJvJqzLPP7YK8thUFLfTrLi3Tx+ekLk20sNoCY217qROOBMF8sMn0a/Z5sj4A42QUk3pcyYOu7EyHNdW1lzFkrLRaqT4qucLv5TVTiCAjxan1HIAw4JgOr/M+cRH5D24QIeR4+AQHpfO7kYBQ3WdLro5jlLvdwZfMlQgwI9M4lAm2OboXwYLw6gQRLK6Yw1qeLdgLTNW7pHwkLS9ts1Yr31kn5wILq55m+/7mU7mbcEGJPC1YkQHgu0QKVXB51xX4kX3RIM7+7aSELAvK2Bhs0lRwi/4+aph57vj+E1im30FctGUbdB0uD8qsFDeUj+0r/m8D9o1dimxx70pk1eM+gzK8g7rkngEQXn4/M1Sucurax3QkqB8DVxFjJ9KUoXl4sy5JFk4Lt2e/AdD7YGbcx//MJk7p7viHEwz1Ptk0RJnxi34N+Ruhg780s4nmeGdRKKRFrD1jzL1xnGaZoMCYmicLlyVjx3wNrMP3zG4aYk76+z1ghOryJm6DJUwrYTXue0qYw6ZejmmgGnU+TGZk7h89jHE0RUGx2UPezBO9rn/+S9iq5YrKoFaHtAIByzt38xuZ3o7Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(19092799006)(376014)(921020)(6133799003)(3023799007)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KzIQdtHeZTE92Kg7swlf1mnioXi7rwuxc7awwX25YDVR7CKUR+uqQbn0uIje?=
 =?us-ascii?Q?kwSFDFoBlmzDNSk2FJgpfZTBQ3ilOvgpHO1BdnQATOf88k0uxmgUC2NZShQ3?=
 =?us-ascii?Q?sEdvotaaWwCMaqNO1J5+akbzweRZJc2gPN9/GrxyfkN6bdKi1C3a5HNBxDWa?=
 =?us-ascii?Q?/Bm04rdMuAD+Q2DgRmLmSuVYBb5jMhYXZGChRtdS3CQgM57802pUeqhae4MH?=
 =?us-ascii?Q?VeAsXNDe2A3H6hFXz0OFBG0kd5mRRMSjBu4Svjzq+g9xr6vVBwJuQiGeL9eU?=
 =?us-ascii?Q?k39AvMWZtPE4smSzj78i+CSS3t6HWcLf0WSApebSJlWcKebfVm3GtOgL8uIC?=
 =?us-ascii?Q?ED3jmjmAclrB8zMXakaQG5DL1toy10rSoRlcwi/I86TIiSEEcj9ULURDwxoe?=
 =?us-ascii?Q?m+/rcRVnzlogDnhhPWMJrMXc5sLhbg1etlpKC+5q8ugYQsz5Pfs8VpfGdRSN?=
 =?us-ascii?Q?6FdELdchkTpRFS/Uwc36tgTM6cJN0X/kQISWNW6NCkqLMu6C4Cc0KBkEhfqP?=
 =?us-ascii?Q?QFKJtCNhI+IA9pHlK+HXiQU+CdiO5ROpmhPzVk85z09iEqP8Lk52t1YHayeh?=
 =?us-ascii?Q?/gNCmGh3ZDAxepXIrNUn/Ar8qe3BECCZgCLOuw5CrmviPdVvqe8lithKUS1K?=
 =?us-ascii?Q?8vkk9jt8H3enbkqU3Sn86yABgtQOyoUpv22l+yP190nBSZs/cDOLfnZBsA5V?=
 =?us-ascii?Q?tCYrjzZ2p8wSLmVCKc2Mocyet9H8DVMWkHU2e5wggTQzsCGNkyhFpk0A7a+s?=
 =?us-ascii?Q?4+iCTd6HjIUQbB+X7e8JFeJplLkTPqyixslAxbIpV70yVLZic4WIo1Tqr5kU?=
 =?us-ascii?Q?AyE8bPMevtG2YwqNP3TIOBOE+kmfAXocIvg6AqqsnWlOq4BVgZg9fkfdPW55?=
 =?us-ascii?Q?8p2BMRgDCuR9iqog4Y+0IY5i1UFUUURVTQ9kdwUPEHWKl6DOZ3qBky15KPpo?=
 =?us-ascii?Q?3X/ja4SNLFI2nZeoIgOxJbvDwUTM6C8BB04EBDfxZexyR6Y2wBZenUN6ylxa?=
 =?us-ascii?Q?a382URJgBY4t+O4QCq/Rr6wDsstvyOKeQCJIxopWAlppCfKavG2YfD6UYiw6?=
 =?us-ascii?Q?zmmpVUBLn5xrbUOjM4LnWy1xXpSrrXfWb1i4yjHQOTL+gJ95G5SefYz1T4NS?=
 =?us-ascii?Q?IqeBKgema2IJaV0TDnaI1E8SGA43JtB9g7eIgfuJyd3FN98OIu7TX9zwAvAf?=
 =?us-ascii?Q?m73CEgPX5paSnpH2nRi7McYJEZQ7XVkxaqs9KmS+NHLIYaUdLeJjw2NRlBaD?=
 =?us-ascii?Q?+quWlzc41KXbyo9U45P2lh7K7ZPjbhXmQbIZ+532j93EZHB9xUH5go5tXfi/?=
 =?us-ascii?Q?eiwaogNP78GleIblZ/RrWRz/X0LjvbozW/h26NoOS5Ppywi0kQ1PrUsCbcpL?=
 =?us-ascii?Q?aAzrOYX3+JTTtRPh6Vc43NQ3zCKcG1n9P/zV4jX6Q1NQrC6nhmVcXLnP+JrV?=
 =?us-ascii?Q?RsQeDKxrAr3atJYFWAfhfnpwR81jO1+8cf6Bh++wEaHUIfT2xvCB27YKDM0U?=
 =?us-ascii?Q?fzxsbNiusUBLDhr+anNO7uCv0qun3de1lxtUab87adjNT4zaHGkxloy20Zcb?=
 =?us-ascii?Q?r7yJ9Y9Rpvo5HyTybGKOr56OLBlUyGKxDeUj16ETeG+TPe2Ie06scsuW26WL?=
 =?us-ascii?Q?o3dCOGwE72tPB/rK8pzfNxBApT3TACLUH9rLND7OaETgUnCRtHB/creyH2SK?=
 =?us-ascii?Q?uBmeJYAFr8MUIB+nSIju8B5Jlh8A6GLBzt6bhZFxGcoaqHmsgPIbc/LstSco?=
 =?us-ascii?Q?44PHCQmfhmYxzVim4gtpOFsFRNYAylXevtwcgbdRB6RlYo4kZHyF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b3f36a-8fcd-46e8-3a87-08dec0777cdb
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 07:20:56.3868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MCxthmQ+kMBg3l+6tlMimMXVv6rbUR5d3UI4xda6LkWN2F4jXiy5lChwvQ5H0E0woM4Z46ASKaTBUr9dN2kAhy6R2D4veEZ3SaCPDpWjOEIxghRq4+wsT0lvJ5t7g/t1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7684

From: Wei Fang <wei.fang@nxp.com>

Implement the DSA .port_vlan_add and .port_vlan_del operations to enable
VLAN-aware bridge offloading on the NETC switch.

VLAN membership is maintained in the VLAN Filter Table (VFT). Adding the
first port to a VLAN creates a new VFT entry with hardware MAC learning
and flood-on-miss forwarding; subsequent ports update the existing
entry's membership bitmap. Removing the last port deletes the entry.

Egress tagging is handled through the Egress Treatment Table (ETT). Each
VLAN is allocated a group of ETT entries, one per available port. Ports
are assigned a sequential ett_offset during initialisation, used to
address each port's entry within the group. Untagged ports configure the
ETT to strip the outer VLAN tag; tagged ports pass frames through
unmodified. Each ETT group is optionally paired with an Egress Counter
Table (ECT) group for per-port frame counting, allocated on a best-effort
basis. When the egress rule of an ETT entry changes, the counter of the
corresponding ECT entry will be recounted to track the number of frames
that match the new egress rule.

A software shadow list serialised by vft_lock tracks active VLAN state
across both port membership and egress tagging. VID 0 is used for single
port mode and is ignored by both callbacks.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c   | 436 +++++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_switch.h |  24 ++
 include/linux/fsl/ntmp.h           |  15 +
 3 files changed, 475 insertions(+)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index d4475ad7ed6c..a97121dda237 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -37,6 +37,27 @@ static void netc_destroy_fdb_list(struct netc_switch *priv)
 		netc_del_fdb_entry(entry);
 }
 
+static struct netc_vlan_entry *
+netc_lookup_vlan_entry(struct netc_switch *priv, u16 vid)
+{
+	struct netc_vlan_entry *entry;
+
+	hlist_for_each_entry(entry, &priv->vlan_list, node)
+		if (entry->vid == vid)
+			return entry;
+
+	return NULL;
+}
+
+static void netc_destroy_vlan_list(struct netc_switch *priv)
+{
+	struct netc_vlan_entry *entry;
+	struct hlist_node *tmp;
+
+	hlist_for_each_entry_safe(entry, tmp, &priv->vlan_list, node)
+		netc_del_vlan_entry(entry);
+}
+
 static enum dsa_tag_protocol
 netc_get_tag_protocol(struct dsa_switch *ds, int port,
 		      enum dsa_tag_protocol mprot)
@@ -222,6 +243,7 @@ static int netc_init_all_ports(struct netc_switch *priv)
 	struct device *dev = priv->dev;
 	struct netc_port *np;
 	struct dsa_port *dp;
+	int ett_offset = 0;
 	int err;
 
 	priv->ports = devm_kcalloc(dev, priv->info->num_ports,
@@ -251,6 +273,8 @@ static int netc_init_all_ports(struct netc_switch *priv)
 	dsa_switch_for_each_available_port(dp, priv->ds) {
 		np = priv->ports[dp->index];
 		np->dp = dp;
+		np->ett_offset = ett_offset++;
+		priv->port_bitmap |= BIT(dp->index);
 
 		err = netc_port_get_info_from_dt(np, dp->dn, dev);
 		if (err)
@@ -831,6 +855,8 @@ static int netc_setup(struct dsa_switch *ds)
 
 	INIT_HLIST_HEAD(&priv->fdb_list);
 	mutex_init(&priv->fdbt_lock);
+	INIT_HLIST_HEAD(&priv->vlan_list);
+	mutex_init(&priv->vft_lock);
 
 	netc_switch_fixed_config(priv);
 
@@ -858,6 +884,7 @@ static int netc_setup(struct dsa_switch *ds)
 	 * hardware state.
 	 */
 	mutex_destroy(&priv->fdbt_lock);
+	mutex_destroy(&priv->vft_lock);
 	netc_free_ntmp_user(priv);
 
 	return err;
@@ -867,6 +894,8 @@ static void netc_destroy_all_lists(struct netc_switch *priv)
 {
 	netc_destroy_fdb_list(priv);
 	mutex_destroy(&priv->fdbt_lock);
+	netc_destroy_vlan_list(priv);
+	mutex_destroy(&priv->vft_lock);
 }
 
 static void netc_free_host_flood_rules(struct netc_switch *priv)
@@ -1025,6 +1054,382 @@ static void netc_switch_get_ip_revision(struct netc_switch *priv)
 	priv->revision = FIELD_GET(IPBRR0_IP_REV, val);
 }
 
+static void netc_init_ett_cfge(struct ett_cfge_data *cfge, bool untagged,
+			       u32 ett_eid, u32 ect_eid)
+{
+	u32 vuda_sqta = FMTEID_VUDA_SQTA;
+	u16 efm_cfg = 0;
+
+	if (ect_eid != NTMP_NULL_ENTRY_ID) {
+		/* Increase egress frame counter */
+		efm_cfg |= FIELD_PREP(ETT_ECA, ETT_ECA_INC);
+		cfge->ec_eid = cpu_to_le32(ect_eid);
+	}
+
+	/* If egress rule is VLAN untagged */
+	if (untagged) {
+		/* delete outer VLAN tag */
+		vuda_sqta |= FIELD_PREP(FMTEID_VUDA, FMTEID_VUDA_DEL_OTAG);
+		/* length change: twos-complement notation */
+		efm_cfg |= FIELD_PREP(ETT_EFM_LEN_CHANGE,
+				      ETT_FRM_LEN_DEL_VLAN);
+	}
+
+	cfge->efm_eid = cpu_to_le32(vuda_sqta);
+	cfge->efm_cfg = cpu_to_le16(efm_cfg);
+}
+
+static int netc_add_ett_entry(struct netc_switch *priv, bool untagged,
+			      u32 ett_eid, u32 ect_eid)
+{
+	struct ntmp_user *ntmp = &priv->ntmp;
+	struct ett_cfge_data cfge = {};
+
+	netc_init_ett_cfge(&cfge, untagged, ett_eid, ect_eid);
+
+	return ntmp_ett_add_entry(ntmp, ett_eid, &cfge);
+}
+
+static int netc_update_ett_entry(struct netc_switch *priv, bool untagged,
+				 u32 ett_eid, u32 ect_eid)
+{
+	struct ntmp_user *ntmp = &priv->ntmp;
+	struct ett_cfge_data cfge = {};
+
+	netc_init_ett_cfge(&cfge, untagged, ett_eid, ect_eid);
+
+	return ntmp_ett_update_entry(ntmp, ett_eid, &cfge);
+}
+
+static int netc_add_ett_group_entries(struct netc_switch *priv,
+				      u32 untagged_port_bitmap,
+				      u32 ett_base_eid,
+				      u32 ect_base_eid)
+{
+	struct netc_port **ports = priv->ports;
+	u32 ett_eid, ect_eid;
+	bool untagged;
+	int i, err;
+
+	for (i = 0; i < priv->info->num_ports; i++) {
+		if (!ports[i]->dp)
+			continue;
+
+		untagged = !!(untagged_port_bitmap & BIT(i));
+		ett_eid = ett_base_eid + ports[i]->ett_offset;
+		ect_eid = NTMP_NULL_ENTRY_ID;
+		if (ect_base_eid != NTMP_NULL_ENTRY_ID)
+			ect_eid = ect_base_eid + ports[i]->ett_offset;
+
+		err = netc_add_ett_entry(priv, untagged, ett_eid, ect_eid);
+		if (err)
+			goto clear_ett_entries;
+	}
+
+	return 0;
+
+clear_ett_entries:
+	while (--i >= 0) {
+		if (!ports[i]->dp)
+			continue;
+
+		ett_eid = ett_base_eid + ports[i]->ett_offset;
+		ntmp_ett_delete_entry(&priv->ntmp, ett_eid);
+	}
+
+	return err;
+}
+
+static int netc_add_vlan_egress_rule(struct netc_switch *priv,
+				     struct netc_vlan_entry *entry)
+{
+	u32 num_ports = netc_num_available_ports(priv);
+	struct ntmp_user *ntmp = &priv->ntmp;
+	u32 ect_eid = NTMP_NULL_ENTRY_ID;
+	u32 ett_eid, ett_gid, ect_gid;
+	int err;
+
+	/* Step 1: Find available egress counter table entries and update
+	 * these entries.
+	 */
+	ect_gid = ntmp_lookup_free_eid(ntmp->ect_gid_bitmap,
+				       ntmp->ect_bitmap_size);
+	if (ect_gid == NTMP_NULL_ENTRY_ID) {
+		dev_info(priv->dev,
+			 "No egress counter table entries available\n");
+	} else {
+		ect_eid = ect_gid * num_ports;
+		for (int i = 0; i < num_ports; i++)
+			/* Reset the counters of the entry. There is no need
+			 * to check the return value, the only issue is that
+			 * the entry's counter might be inaccurate, but it
+			 * will not affect the functionality.
+			 */
+			ntmp_ect_update_entry(ntmp, ect_eid + i);
+	}
+
+	/* Step 2: Find available egress treatment table entries and add
+	 * these entries.
+	 */
+	ett_gid = ntmp_lookup_free_eid(ntmp->ett_gid_bitmap,
+				       ntmp->ett_bitmap_size);
+	if (ett_gid == NTMP_NULL_ENTRY_ID) {
+		dev_err(priv->dev,
+			"No egress treatment table entries available\n");
+		err = -ENOSPC;
+		goto clear_ect_gid;
+	}
+
+	ett_eid = ett_gid * num_ports;
+	err = netc_add_ett_group_entries(priv, entry->untagged_port_bitmap,
+					 ett_eid, ect_eid);
+	if (err)
+		goto clear_ett_gid;
+
+	entry->cfge.et_eid = cpu_to_le32(ett_eid);
+	entry->ect_gid = ect_gid;
+
+	return 0;
+
+clear_ett_gid:
+	ntmp_clear_eid_bitmap(ntmp->ett_gid_bitmap, ett_gid);
+
+clear_ect_gid:
+	if (ect_gid != NTMP_NULL_ENTRY_ID)
+		ntmp_clear_eid_bitmap(ntmp->ect_gid_bitmap, ect_gid);
+
+	return err;
+}
+
+static void netc_delete_vlan_egress_rule(struct netc_switch *priv,
+					 struct netc_vlan_entry *entry)
+{
+	u32 num_ports = netc_num_available_ports(priv);
+	struct ntmp_user *ntmp = &priv->ntmp;
+	u32 ett_eid, ett_gid;
+
+	ett_eid = le32_to_cpu(entry->cfge.et_eid);
+	if (ett_eid == NTMP_NULL_ENTRY_ID)
+		return;
+
+	ett_gid = ett_eid / num_ports;
+	ntmp_clear_eid_bitmap(ntmp->ett_gid_bitmap, ett_gid);
+	for (int i = 0; i < num_ports; i++)
+		ntmp_ett_delete_entry(ntmp, ett_eid + i);
+
+	if (entry->ect_gid == NTMP_NULL_ENTRY_ID)
+		return;
+
+	ntmp_clear_eid_bitmap(ntmp->ect_gid_bitmap, entry->ect_gid);
+}
+
+static int netc_port_update_vlan_egress_rule(struct netc_port *np,
+					     struct netc_vlan_entry *entry)
+{
+	bool untagged = !!(entry->untagged_port_bitmap & BIT(np->dp->index));
+	u32 num_ports = netc_num_available_ports(np->switch_priv);
+	u32 ett_eid = le32_to_cpu(entry->cfge.et_eid);
+	struct netc_switch *priv = np->switch_priv;
+	u32 ect_eid = NTMP_NULL_ENTRY_ID;
+	int err;
+
+	if (ett_eid == NTMP_NULL_ENTRY_ID)
+		return 0;
+
+	if (entry->ect_gid != NTMP_NULL_ENTRY_ID) {
+		/* Each ETT entry maps to an ECT entry if ect_gid is not NULL
+		 * entry ID. The offset of the ECT entry corresponding to the
+		 * port in the group is equal to ett_offset.
+		 */
+		ect_eid = entry->ect_gid * num_ports + np->ett_offset;
+		ntmp_ect_update_entry(&priv->ntmp, ect_eid);
+	}
+
+	ett_eid += np->ett_offset;
+	err = netc_update_ett_entry(priv, untagged, ett_eid, ect_eid);
+	if (err)
+		dev_err(priv->dev,
+			"Failed to update VLAN %u egress rule on port %d\n",
+			entry->vid, np->dp->index);
+
+	return err;
+}
+
+static int netc_port_add_vlan_entry(struct netc_port *np, u16 vid,
+				    bool untagged)
+{
+	struct netc_switch *priv = np->switch_priv;
+	struct netc_vlan_entry *entry;
+	struct vft_cfge_data *cfge;
+	u32 index = np->dp->index;
+	u32 bitmap_stg;
+	int err;
+	u16 cfg;
+
+	entry = kzalloc_obj(*entry);
+	if (!entry)
+		return -ENOMEM;
+
+	entry->vid = vid;
+	entry->ect_gid = NTMP_NULL_ENTRY_ID;
+
+	bitmap_stg = BIT(index) | VFT_STG_ID(0);
+	cfg = FIELD_PREP(VFT_MLO, MLO_HW) |
+	      FIELD_PREP(VFT_MFO, MFO_NO_MATCH_FLOOD);
+
+	cfge = &entry->cfge;
+	cfge->et_eid = cpu_to_le32(NTMP_NULL_ENTRY_ID);
+	cfge->bitmap_stg = cpu_to_le32(bitmap_stg);
+	cfge->fid = cpu_to_le16(vid);
+	cfge->cfg = cpu_to_le16(cfg);
+	cfge->eta_port_bitmap = cpu_to_le32(priv->port_bitmap);
+
+	if (untagged)
+		entry->untagged_port_bitmap = BIT(index);
+
+	err = netc_add_vlan_egress_rule(priv, entry);
+	if (err)
+		goto free_vlan_entry;
+
+	err = ntmp_vft_add_entry(&priv->ntmp, vid, cfge);
+	if (err) {
+		dev_err(priv->dev,
+			"Failed to add VLAN %u entry on port %d\n",
+			vid, index);
+		goto delete_vlan_egress_rule;
+	}
+
+	netc_add_vlan_entry(priv, entry);
+
+	return 0;
+
+delete_vlan_egress_rule:
+	netc_delete_vlan_egress_rule(priv, entry);
+free_vlan_entry:
+	kfree(entry);
+
+	return err;
+}
+
+static bool netc_port_vlan_egress_rule_changed(struct netc_vlan_entry *entry,
+					       int port, bool untagged)
+{
+	bool old_untagged = !!(entry->untagged_port_bitmap & BIT(port));
+
+	return old_untagged != untagged;
+}
+
+static int netc_port_set_vlan_entry(struct netc_port *np, u16 vid,
+				    bool untagged)
+{
+	struct netc_switch *priv = np->switch_priv;
+	struct netc_vlan_entry *entry;
+	struct vft_cfge_data *cfge;
+	int port = np->dp->index;
+	bool changed;
+	int err = 0;
+
+	mutex_lock(&priv->vft_lock);
+
+	entry = netc_lookup_vlan_entry(priv, vid);
+	if (!entry) {
+		err = netc_port_add_vlan_entry(np, vid, untagged);
+		goto unlock_vft;
+	}
+
+	/* Check whether the egress VLAN rule is changed */
+	changed = netc_port_vlan_egress_rule_changed(entry, port, untagged);
+	if (changed) {
+		entry->untagged_port_bitmap ^= BIT(port);
+		err = netc_port_update_vlan_egress_rule(np, entry);
+		if (err) {
+			entry->untagged_port_bitmap ^= BIT(port);
+			goto unlock_vft;
+		}
+	}
+
+	cfge = &entry->cfge;
+	if (cfge->bitmap_stg & cpu_to_le32(BIT(port)))
+		goto unlock_vft;
+
+	cfge->bitmap_stg |= cpu_to_le32(BIT(port));
+	err = ntmp_vft_update_entry(&priv->ntmp, vid, cfge);
+	if (err) {
+		dev_err(priv->dev,
+			"Failed to update VLAN %u entry on port %d\n",
+			vid, port);
+
+		goto restore_bitmap_stg;
+	}
+
+	mutex_unlock(&priv->vft_lock);
+
+	return 0;
+
+restore_bitmap_stg:
+	cfge->bitmap_stg &= cpu_to_le32(~BIT(port));
+	if (changed) {
+		entry->untagged_port_bitmap ^= BIT(port);
+		/* Recover the corresponding ETT entry. It doesn't matter
+		 * if it fails because the bit corresponding to the port
+		 * in the port bitmap of the VFT entry is not set. so the
+		 * frame will not match that ETT entry.
+		 */
+		if (netc_port_update_vlan_egress_rule(np, entry))
+			entry->untagged_port_bitmap ^= BIT(port);
+	}
+unlock_vft:
+	mutex_unlock(&priv->vft_lock);
+
+	return err;
+}
+
+static int netc_port_del_vlan_entry(struct netc_port *np, u16 vid)
+{
+	struct netc_switch *priv = np->switch_priv;
+	struct netc_vlan_entry *entry;
+	struct vft_cfge_data *cfge;
+	int port = np->dp->index;
+	u32 vlan_port_bitmap;
+	int err = 0;
+
+	mutex_lock(&priv->vft_lock);
+
+	entry = netc_lookup_vlan_entry(priv, vid);
+	if (!entry)
+		goto unlock_vft;
+
+	cfge = &entry->cfge;
+	vlan_port_bitmap = FIELD_GET(VFT_PORT_MEMBERSHIP,
+				     le32_to_cpu(cfge->bitmap_stg));
+	/* If the VLAN only belongs to the current port */
+	if (vlan_port_bitmap == BIT(port)) {
+		err = ntmp_vft_delete_entry(&priv->ntmp, vid);
+		if (err)
+			goto unlock_vft;
+
+		netc_delete_vlan_egress_rule(priv, entry);
+		netc_del_vlan_entry(entry);
+
+		goto unlock_vft;
+	}
+
+	if (!(vlan_port_bitmap & BIT(port)))
+		goto unlock_vft;
+
+	cfge->bitmap_stg &= cpu_to_le32(~BIT(port));
+	err = ntmp_vft_update_entry(&priv->ntmp, vid, cfge);
+	if (err) {
+		cfge->bitmap_stg |= cpu_to_le32(BIT(port));
+		goto unlock_vft;
+	}
+
+unlock_vft:
+	mutex_unlock(&priv->vft_lock);
+
+	return err;
+}
+
 static int netc_port_enable(struct dsa_switch *ds, int port,
 			    struct phy_device *phy)
 {
@@ -1297,6 +1702,35 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 	netc_port_remove_host_flood(np, old_host_flood);
 }
 
+static int netc_port_vlan_add(struct dsa_switch *ds, int port,
+			      const struct switchdev_obj_port_vlan *vlan,
+			      struct netlink_ext_ack *extack)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	bool untagged;
+
+	/* The 8021q layer may attempt to change NETC_STANDALONE_PVID
+	 * (VID 0), so we need to ignore it.
+	 */
+	if (vlan->vid == NETC_STANDALONE_PVID)
+		return 0;
+
+	untagged = !!(vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED);
+
+	return netc_port_set_vlan_entry(np, vlan->vid, untagged);
+}
+
+static int netc_port_vlan_del(struct dsa_switch *ds, int port,
+			      const struct switchdev_obj_port_vlan *vlan)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+
+	if (vlan->vid == NETC_STANDALONE_PVID)
+		return 0;
+
+	return netc_port_del_vlan_entry(np, vlan->vid);
+}
+
 static void netc_phylink_get_caps(struct dsa_switch *ds, int port,
 				  struct phylink_config *config)
 {
@@ -1575,6 +2009,8 @@ static const struct dsa_switch_ops netc_switch_ops = {
 	.port_mdb_add			= netc_port_mdb_add,
 	.port_mdb_del			= netc_port_mdb_del,
 	.port_set_host_flood		= netc_port_set_host_flood,
+	.port_vlan_add			= netc_port_vlan_add,
+	.port_vlan_del			= netc_port_vlan_del,
 	.get_pause_stats		= netc_port_get_pause_stats,
 	.get_rmon_stats			= netc_port_get_rmon_stats,
 	.get_eth_ctrl_stats		= netc_port_get_eth_ctrl_stats,
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index 4fbd12825b67..9ff334301fbc 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -74,6 +74,7 @@ struct netc_port {
 	struct dsa_port *dp;
 	struct clk *ref_clk; /* RGMII/RMII reference clock */
 	struct mii_bus *emdio;
+	int ett_offset;
 
 	u16 enable:1;
 	u16 uc:1;
@@ -94,6 +95,14 @@ struct netc_fdb_entry {
 	struct hlist_node node;
 };
 
+struct netc_vlan_entry {
+	u16 vid;
+	u32 ect_gid;
+	u32 untagged_port_bitmap;
+	struct vft_cfge_data cfge;
+	struct hlist_node node;
+};
+
 struct netc_port_stat {
 	int reg;
 	char name[ETH_GSTRING_LEN] __nonstring;
@@ -108,10 +117,13 @@ struct netc_switch {
 	const struct netc_switch_info *info;
 	struct netc_switch_regs regs;
 	struct netc_port **ports;
+	u32 port_bitmap; /* bitmap of available ports */
 
 	struct ntmp_user ntmp;
 	struct hlist_head fdb_list;
 	struct mutex fdbt_lock; /* FDB table lock */
+	struct hlist_head vlan_list;
+	struct mutex vft_lock; /* VLAN filter table lock */
 
 	/* Switch hardware capabilities */
 	u32 htmcapr_num_words;
@@ -153,6 +165,18 @@ static inline void netc_del_fdb_entry(struct netc_fdb_entry *entry)
 	kfree(entry);
 }
 
+static inline void netc_add_vlan_entry(struct netc_switch *priv,
+				       struct netc_vlan_entry *entry)
+{
+	hlist_add_head(&entry->node, &priv->vlan_list);
+}
+
+static inline void netc_del_vlan_entry(struct netc_vlan_entry *entry)
+{
+	hlist_del(&entry->node);
+	kfree(entry);
+}
+
 int netc_switch_platform_probe(struct netc_switch *priv);
 
 /* ethtool APIs */
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index 531c3b9982ee..1e6fd7c94af0 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -267,6 +267,21 @@ struct bpt_cfge_data {
 	__le32 fc_ports;
 };
 
+union ntmp_fmt_eid {
+	__le32 index;
+#define	FMTEID_INDEX		GENMASK(12, 0)
+	__le32 vuda_sqta;
+#define FMTEID_VUDA		GENMASK(1, 0)
+#define FMTEID_VUDA_DEL_OTAG	2
+#define FMTEID_SQTA		GENMASK(4, 2)
+#define FMTEID_SQTA_DEL		2
+#define FMTEID_VUDA_SQTA	BIT(13)
+	__le32 vara_vid;
+#define FMTEID_VID		GENMASK(11, 0)
+#define FMTEID_VARA		GENMASK(13, 12)
+#define FMTEID_VARA_VID		BIT(14)
+};
+
 #if IS_ENABLED(CONFIG_NXP_NETC_LIB)
 int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 		   const struct netc_cbdr_regs *regs);
-- 
2.34.1


